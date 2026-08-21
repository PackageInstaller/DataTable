return {
	Play319391001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319391001
		arg_1_1.duration_ = 8.2

		local var_1_0 = {
			zh = 4.133,
			ja = 8.2
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
				arg_1_0:Play319391002(arg_1_1)
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

			local var_4_22 = "10066ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["10066ui_story"].transform
			local var_4_28 = 2

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos10066ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -0.99, -5.83)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10066ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["10066ui_story"]
			local var_4_37 = 2

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect10066ui_story == nil then
				arg_1_1.var_.characterEffect10066ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect10066ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect10066ui_story then
				arg_1_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_4_40 = 2

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			local var_4_41 = 2

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_42 = 0
			local var_4_43 = 0.1

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

			local var_4_48 = 0.133333333333333
			local var_4_49 = 0.966666666666667

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

			local var_4_54 = 2
			local var_4_55 = 0.275

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

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[640].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(319391001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391001", "story_v_out_319391.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_out_319391", "319391001", "story_v_out_319391.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_out_319391", "319391001", "story_v_out_319391.awb")

						arg_1_1:RecordAudio("319391001", var_4_64)
						arg_1_1:RecordAudio("319391001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319391", "319391001", "story_v_out_319391.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319391", "319391001", "story_v_out_319391.awb")
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
				actorName = "10066ui_story",
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
	Play319391002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319391002
		arg_9_1.duration_ = 10.8

		local var_9_0 = {
			zh = 5.366,
			ja = 10.8
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
				arg_9_0:Play319391003(arg_9_1)
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
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_20 = arg_9_1.actors_["10066ui_story"].transform
			local var_12_21 = 0

			if var_12_21 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 then
				arg_9_1.var_.moveOldPos10066ui_story = var_12_20.localPosition
			end

			local var_12_22 = 0.001

			if var_12_21 <= arg_9_1.time_ and arg_9_1.time_ < var_12_21 + var_12_22 then
				local var_12_23 = (arg_9_1.time_ - var_12_21) / var_12_22
				local var_12_24 = Vector3.New(-0.7, -0.99, -5.83)

				var_12_20.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10066ui_story, var_12_24, var_12_23)

				local var_12_25 = manager.ui.mainCamera.transform.position - var_12_20.position

				var_12_20.forward = Vector3.New(var_12_25.x, var_12_25.y, var_12_25.z)

				local var_12_26 = var_12_20.localEulerAngles

				var_12_26.z = 0
				var_12_26.x = 0
				var_12_20.localEulerAngles = var_12_26
			end

			if arg_9_1.time_ >= var_12_21 + var_12_22 and arg_9_1.time_ < var_12_21 + var_12_22 + arg_12_0 then
				var_12_20.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_12_27 = manager.ui.mainCamera.transform.position - var_12_20.position

				var_12_20.forward = Vector3.New(var_12_27.x, var_12_27.y, var_12_27.z)

				local var_12_28 = var_12_20.localEulerAngles

				var_12_28.z = 0
				var_12_28.x = 0
				var_12_20.localEulerAngles = var_12_28
			end

			local var_12_29 = arg_9_1.actors_["10066ui_story"]
			local var_12_30 = 0

			if var_12_30 < arg_9_1.time_ and arg_9_1.time_ <= var_12_30 + arg_12_0 and not isNil(var_12_29) and arg_9_1.var_.characterEffect10066ui_story == nil then
				arg_9_1.var_.characterEffect10066ui_story = var_12_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_31 = 0.200000002980232

			if var_12_30 <= arg_9_1.time_ and arg_9_1.time_ < var_12_30 + var_12_31 and not isNil(var_12_29) then
				local var_12_32 = (arg_9_1.time_ - var_12_30) / var_12_31

				if arg_9_1.var_.characterEffect10066ui_story and not isNil(var_12_29) then
					local var_12_33 = Mathf.Lerp(0, 0.5, var_12_32)

					arg_9_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10066ui_story.fillRatio = var_12_33
				end
			end

			if arg_9_1.time_ >= var_12_30 + var_12_31 and arg_9_1.time_ < var_12_30 + var_12_31 + arg_12_0 and not isNil(var_12_29) and arg_9_1.var_.characterEffect10066ui_story then
				local var_12_34 = 0.5

				arg_9_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10066ui_story.fillRatio = var_12_34
			end

			local var_12_35 = 0
			local var_12_36 = 0.625

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

				local var_12_38 = arg_9_1:GetWordFromCfg(319391002)
				local var_12_39 = arg_9_1:FormatText(var_12_38.content)

				arg_9_1.text_.text = var_12_39

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_40 = 25
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

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391002", "story_v_out_319391.awb") ~= 0 then
					local var_12_43 = manager.audio:GetVoiceLength("story_v_out_319391", "319391002", "story_v_out_319391.awb") / 1000

					if var_12_43 + var_12_35 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_43 + var_12_35
					end

					if var_12_38.prefab_name ~= "" and arg_9_1.actors_[var_12_38.prefab_name] ~= nil then
						local var_12_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_38.prefab_name].transform, "story_v_out_319391", "319391002", "story_v_out_319391.awb")

						arg_9_1:RecordAudio("319391002", var_12_44)
						arg_9_1:RecordAudio("319391002", var_12_44)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319391", "319391002", "story_v_out_319391.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319391", "319391002", "story_v_out_319391.awb")
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
				actorName = "10066ui_story",
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
	Play319391003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319391003
		arg_13_1.duration_ = 9.5

		local var_13_0 = {
			zh = 4.566,
			ja = 9.5
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
				arg_13_0:Play319391004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1084ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1084ui_story == nil then
				arg_13_1.var_.characterEffect1084ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1084ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1084ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1084ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1084ui_story.fillRatio = var_16_5
			end

			local var_16_6 = arg_13_1.actors_["10066ui_story"]
			local var_16_7 = 0

			if var_16_7 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 and not isNil(var_16_6) and arg_13_1.var_.characterEffect10066ui_story == nil then
				arg_13_1.var_.characterEffect10066ui_story = var_16_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_8 = 0.200000002980232

			if var_16_7 <= arg_13_1.time_ and arg_13_1.time_ < var_16_7 + var_16_8 and not isNil(var_16_6) then
				local var_16_9 = (arg_13_1.time_ - var_16_7) / var_16_8

				if arg_13_1.var_.characterEffect10066ui_story and not isNil(var_16_6) then
					arg_13_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_7 + var_16_8 and arg_13_1.time_ < var_16_7 + var_16_8 + arg_16_0 and not isNil(var_16_6) and arg_13_1.var_.characterEffect10066ui_story then
				arg_13_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			local var_16_11 = 0

			if var_16_11 < arg_13_1.time_ and arg_13_1.time_ <= var_16_11 + arg_16_0 then
				arg_13_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_16_12 = 0
			local var_16_13 = 0.45

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_14 = arg_13_1:FormatText(StoryNameCfg[640].name)

				arg_13_1.leftNameTxt_.text = var_16_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_15 = arg_13_1:GetWordFromCfg(319391003)
				local var_16_16 = arg_13_1:FormatText(var_16_15.content)

				arg_13_1.text_.text = var_16_16

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 18
				local var_16_18 = utf8.len(var_16_16)
				local var_16_19 = var_16_17 <= 0 and var_16_13 or var_16_13 * (var_16_18 / var_16_17)

				if var_16_19 > 0 and var_16_13 < var_16_19 then
					arg_13_1.talkMaxDuration = var_16_19

					if var_16_19 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_19 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_16
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391003", "story_v_out_319391.awb") ~= 0 then
					local var_16_20 = manager.audio:GetVoiceLength("story_v_out_319391", "319391003", "story_v_out_319391.awb") / 1000

					if var_16_20 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_20 + var_16_12
					end

					if var_16_15.prefab_name ~= "" and arg_13_1.actors_[var_16_15.prefab_name] ~= nil then
						local var_16_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_15.prefab_name].transform, "story_v_out_319391", "319391003", "story_v_out_319391.awb")

						arg_13_1:RecordAudio("319391003", var_16_21)
						arg_13_1:RecordAudio("319391003", var_16_21)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319391", "319391003", "story_v_out_319391.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319391", "319391003", "story_v_out_319391.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_22 and arg_13_1.time_ < var_16_12 + var_16_22 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play319391004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319391004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play319391005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10066ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10066ui_story == nil then
				arg_17_1.var_.characterEffect10066ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect10066ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10066ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10066ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10066ui_story.fillRatio = var_20_5
			end

			local var_20_6 = 0
			local var_20_7 = 0.95

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

				local var_20_8 = arg_17_1:GetWordFromCfg(319391004)
				local var_20_9 = arg_17_1:FormatText(var_20_8.content)

				arg_17_1.text_.text = var_20_9

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 38
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
	Play319391005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319391005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play319391006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1084ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1084ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1084ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(0, 100, 0)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["1084ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect1084ui_story and not isNil(var_24_9) then
					local var_24_13 = Mathf.Lerp(0, 0.5, var_24_12)

					arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1084ui_story.fillRatio = var_24_13
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1084ui_story then
				local var_24_14 = 0.5

				arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1084ui_story.fillRatio = var_24_14
			end

			local var_24_15 = arg_21_1.actors_["10066ui_story"].transform
			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.var_.moveOldPos10066ui_story = var_24_15.localPosition
			end

			local var_24_17 = 0.001

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_17 then
				local var_24_18 = (arg_21_1.time_ - var_24_16) / var_24_17
				local var_24_19 = Vector3.New(0, 100, 0)

				var_24_15.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10066ui_story, var_24_19, var_24_18)

				local var_24_20 = manager.ui.mainCamera.transform.position - var_24_15.position

				var_24_15.forward = Vector3.New(var_24_20.x, var_24_20.y, var_24_20.z)

				local var_24_21 = var_24_15.localEulerAngles

				var_24_21.z = 0
				var_24_21.x = 0
				var_24_15.localEulerAngles = var_24_21
			end

			if arg_21_1.time_ >= var_24_16 + var_24_17 and arg_21_1.time_ < var_24_16 + var_24_17 + arg_24_0 then
				var_24_15.localPosition = Vector3.New(0, 100, 0)

				local var_24_22 = manager.ui.mainCamera.transform.position - var_24_15.position

				var_24_15.forward = Vector3.New(var_24_22.x, var_24_22.y, var_24_22.z)

				local var_24_23 = var_24_15.localEulerAngles

				var_24_23.z = 0
				var_24_23.x = 0
				var_24_15.localEulerAngles = var_24_23
			end

			local var_24_24 = arg_21_1.actors_["10066ui_story"]
			local var_24_25 = 0

			if var_24_25 < arg_21_1.time_ and arg_21_1.time_ <= var_24_25 + arg_24_0 and not isNil(var_24_24) and arg_21_1.var_.characterEffect10066ui_story == nil then
				arg_21_1.var_.characterEffect10066ui_story = var_24_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_26 = 0.200000002980232

			if var_24_25 <= arg_21_1.time_ and arg_21_1.time_ < var_24_25 + var_24_26 and not isNil(var_24_24) then
				local var_24_27 = (arg_21_1.time_ - var_24_25) / var_24_26

				if arg_21_1.var_.characterEffect10066ui_story and not isNil(var_24_24) then
					local var_24_28 = Mathf.Lerp(0, 0.5, var_24_27)

					arg_21_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10066ui_story.fillRatio = var_24_28
				end
			end

			if arg_21_1.time_ >= var_24_25 + var_24_26 and arg_21_1.time_ < var_24_25 + var_24_26 + arg_24_0 and not isNil(var_24_24) and arg_21_1.var_.characterEffect10066ui_story then
				local var_24_29 = 0.5

				arg_21_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10066ui_story.fillRatio = var_24_29
			end

			local var_24_30 = 0
			local var_24_31 = 1.1

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_32 = arg_21_1:GetWordFromCfg(319391005)
				local var_24_33 = arg_21_1:FormatText(var_24_32.content)

				arg_21_1.text_.text = var_24_33

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_34 = 44
				local var_24_35 = utf8.len(var_24_33)
				local var_24_36 = var_24_34 <= 0 and var_24_31 or var_24_31 * (var_24_35 / var_24_34)

				if var_24_36 > 0 and var_24_31 < var_24_36 then
					arg_21_1.talkMaxDuration = var_24_36

					if var_24_36 + var_24_30 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_36 + var_24_30
					end
				end

				arg_21_1.text_.text = var_24_33
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_37 = math.max(var_24_31, arg_21_1.talkMaxDuration)

			if var_24_30 <= arg_21_1.time_ and arg_21_1.time_ < var_24_30 + var_24_37 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_30) / var_24_37

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_30 + var_24_37 and arg_21_1.time_ < var_24_30 + var_24_37 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play319391006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319391006
		arg_25_1.duration_ = 4.27

		local var_25_0 = {
			zh = 2.033,
			ja = 4.266
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
				arg_25_0:Play319391007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = "10069ui_story"

			if arg_25_1.actors_[var_28_0] == nil then
				local var_28_1 = Asset.Load("Char/" .. "10069ui_story")

				if not isNil(var_28_1) then
					local var_28_2 = Object.Instantiate(Asset.Load("Char/" .. "10069ui_story"), arg_25_1.stage_.transform)

					var_28_2.name = var_28_0
					var_28_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_25_1.actors_[var_28_0] = var_28_2

					local var_28_3 = var_28_2:GetComponentInChildren(typeof(CharacterEffect))

					var_28_3.enabled = true

					local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_2, typeof(DynamicBoneHelper))

					if var_28_4 then
						var_28_4:EnableDynamicBone(false)
					end

					arg_25_1:ShowWeapon(var_28_3.transform, false)

					arg_25_1.var_[var_28_0 .. "Animator"] = var_28_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_25_1.var_[var_28_0 .. "Animator"].applyRootMotion = true
					arg_25_1.var_[var_28_0 .. "LipSync"] = var_28_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_28_5 = arg_25_1.actors_["10069ui_story"].transform
			local var_28_6 = 0

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.var_.moveOldPos10069ui_story = var_28_5.localPosition
			end

			local var_28_7 = 0.001

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_7 then
				local var_28_8 = (arg_25_1.time_ - var_28_6) / var_28_7
				local var_28_9 = Vector3.New(0, -1.08, -6.33)

				var_28_5.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10069ui_story, var_28_9, var_28_8)

				local var_28_10 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_10.x, var_28_10.y, var_28_10.z)

				local var_28_11 = var_28_5.localEulerAngles

				var_28_11.z = 0
				var_28_11.x = 0
				var_28_5.localEulerAngles = var_28_11
			end

			if arg_25_1.time_ >= var_28_6 + var_28_7 and arg_25_1.time_ < var_28_6 + var_28_7 + arg_28_0 then
				var_28_5.localPosition = Vector3.New(0, -1.08, -6.33)

				local var_28_12 = manager.ui.mainCamera.transform.position - var_28_5.position

				var_28_5.forward = Vector3.New(var_28_12.x, var_28_12.y, var_28_12.z)

				local var_28_13 = var_28_5.localEulerAngles

				var_28_13.z = 0
				var_28_13.x = 0
				var_28_5.localEulerAngles = var_28_13
			end

			local var_28_14 = arg_25_1.actors_["10069ui_story"]
			local var_28_15 = 0

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect10069ui_story == nil then
				arg_25_1.var_.characterEffect10069ui_story = var_28_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_16 = 0.200000002980232

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_16 and not isNil(var_28_14) then
				local var_28_17 = (arg_25_1.time_ - var_28_15) / var_28_16

				if arg_25_1.var_.characterEffect10069ui_story and not isNil(var_28_14) then
					arg_25_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_15 + var_28_16 and arg_25_1.time_ < var_28_15 + var_28_16 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect10069ui_story then
				arg_25_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_28_18 = 0

			if var_28_18 < arg_25_1.time_ and arg_25_1.time_ <= var_28_18 + arg_28_0 then
				arg_25_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_28_19 = 0

			if var_28_19 < arg_25_1.time_ and arg_25_1.time_ <= var_28_19 + arg_28_0 then
				arg_25_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_20 = 0
			local var_28_21 = 0.15

			if var_28_20 < arg_25_1.time_ and arg_25_1.time_ <= var_28_20 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_22 = arg_25_1:FormatText(StoryNameCfg[693].name)

				arg_25_1.leftNameTxt_.text = var_28_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_23 = arg_25_1:GetWordFromCfg(319391006)
				local var_28_24 = arg_25_1:FormatText(var_28_23.content)

				arg_25_1.text_.text = var_28_24

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_25 = 6
				local var_28_26 = utf8.len(var_28_24)
				local var_28_27 = var_28_25 <= 0 and var_28_21 or var_28_21 * (var_28_26 / var_28_25)

				if var_28_27 > 0 and var_28_21 < var_28_27 then
					arg_25_1.talkMaxDuration = var_28_27

					if var_28_27 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_27 + var_28_20
					end
				end

				arg_25_1.text_.text = var_28_24
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391006", "story_v_out_319391.awb") ~= 0 then
					local var_28_28 = manager.audio:GetVoiceLength("story_v_out_319391", "319391006", "story_v_out_319391.awb") / 1000

					if var_28_28 + var_28_20 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_28 + var_28_20
					end

					if var_28_23.prefab_name ~= "" and arg_25_1.actors_[var_28_23.prefab_name] ~= nil then
						local var_28_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_23.prefab_name].transform, "story_v_out_319391", "319391006", "story_v_out_319391.awb")

						arg_25_1:RecordAudio("319391006", var_28_29)
						arg_25_1:RecordAudio("319391006", var_28_29)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319391", "319391006", "story_v_out_319391.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319391", "319391006", "story_v_out_319391.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_30 = math.max(var_28_21, arg_25_1.talkMaxDuration)

			if var_28_20 <= arg_25_1.time_ and arg_25_1.time_ < var_28_20 + var_28_30 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_20) / var_28_30

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_20 + var_28_30 and arg_25_1.time_ < var_28_20 + var_28_30 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play319391007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319391007
		arg_29_1.duration_ = 3.6

		local var_29_0 = {
			zh = 3.2,
			ja = 3.6
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
				arg_29_0:Play319391008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10069ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10069ui_story == nil then
				arg_29_1.var_.characterEffect10069ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect10069ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10069ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect10069ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10069ui_story.fillRatio = var_32_5
			end

			local var_32_6 = arg_29_1.actors_["10066ui_story"]
			local var_32_7 = 0

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect10066ui_story == nil then
				arg_29_1.var_.characterEffect10066ui_story = var_32_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_8 = 0.200000002980232

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_8 and not isNil(var_32_6) then
				local var_32_9 = (arg_29_1.time_ - var_32_7) / var_32_8

				if arg_29_1.var_.characterEffect10066ui_story and not isNil(var_32_6) then
					arg_29_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_7 + var_32_8 and arg_29_1.time_ < var_32_7 + var_32_8 + arg_32_0 and not isNil(var_32_6) and arg_29_1.var_.characterEffect10066ui_story then
				arg_29_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_32_10 = arg_29_1.actors_["10069ui_story"].transform
			local var_32_11 = 0

			if var_32_11 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.var_.moveOldPos10069ui_story = var_32_10.localPosition
			end

			local var_32_12 = 0.001

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_12 then
				local var_32_13 = (arg_29_1.time_ - var_32_11) / var_32_12
				local var_32_14 = Vector3.New(0, 100, 0)

				var_32_10.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10069ui_story, var_32_14, var_32_13)

				local var_32_15 = manager.ui.mainCamera.transform.position - var_32_10.position

				var_32_10.forward = Vector3.New(var_32_15.x, var_32_15.y, var_32_15.z)

				local var_32_16 = var_32_10.localEulerAngles

				var_32_16.z = 0
				var_32_16.x = 0
				var_32_10.localEulerAngles = var_32_16
			end

			if arg_29_1.time_ >= var_32_11 + var_32_12 and arg_29_1.time_ < var_32_11 + var_32_12 + arg_32_0 then
				var_32_10.localPosition = Vector3.New(0, 100, 0)

				local var_32_17 = manager.ui.mainCamera.transform.position - var_32_10.position

				var_32_10.forward = Vector3.New(var_32_17.x, var_32_17.y, var_32_17.z)

				local var_32_18 = var_32_10.localEulerAngles

				var_32_18.z = 0
				var_32_18.x = 0
				var_32_10.localEulerAngles = var_32_18
			end

			local var_32_19 = arg_29_1.actors_["10066ui_story"]
			local var_32_20 = 0

			if var_32_20 < arg_29_1.time_ and arg_29_1.time_ <= var_32_20 + arg_32_0 and not isNil(var_32_19) and arg_29_1.var_.characterEffect10066ui_story == nil then
				arg_29_1.var_.characterEffect10066ui_story = var_32_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_21 = 0.200000002980232

			if var_32_20 <= arg_29_1.time_ and arg_29_1.time_ < var_32_20 + var_32_21 and not isNil(var_32_19) then
				local var_32_22 = (arg_29_1.time_ - var_32_20) / var_32_21

				if arg_29_1.var_.characterEffect10066ui_story and not isNil(var_32_19) then
					arg_29_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_20 + var_32_21 and arg_29_1.time_ < var_32_20 + var_32_21 + arg_32_0 and not isNil(var_32_19) and arg_29_1.var_.characterEffect10066ui_story then
				arg_29_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_32_23 = 0

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 then
				arg_29_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action465")
			end

			local var_32_24 = 0

			if var_32_24 < arg_29_1.time_ and arg_29_1.time_ <= var_32_24 + arg_32_0 then
				arg_29_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_32_25 = arg_29_1.actors_["10066ui_story"].transform
			local var_32_26 = 0

			if var_32_26 < arg_29_1.time_ and arg_29_1.time_ <= var_32_26 + arg_32_0 then
				arg_29_1.var_.moveOldPos10066ui_story = var_32_25.localPosition
			end

			local var_32_27 = 0.001

			if var_32_26 <= arg_29_1.time_ and arg_29_1.time_ < var_32_26 + var_32_27 then
				local var_32_28 = (arg_29_1.time_ - var_32_26) / var_32_27
				local var_32_29 = Vector3.New(0, -0.99, -5.83)

				var_32_25.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10066ui_story, var_32_29, var_32_28)

				local var_32_30 = manager.ui.mainCamera.transform.position - var_32_25.position

				var_32_25.forward = Vector3.New(var_32_30.x, var_32_30.y, var_32_30.z)

				local var_32_31 = var_32_25.localEulerAngles

				var_32_31.z = 0
				var_32_31.x = 0
				var_32_25.localEulerAngles = var_32_31
			end

			if arg_29_1.time_ >= var_32_26 + var_32_27 and arg_29_1.time_ < var_32_26 + var_32_27 + arg_32_0 then
				var_32_25.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_32_32 = manager.ui.mainCamera.transform.position - var_32_25.position

				var_32_25.forward = Vector3.New(var_32_32.x, var_32_32.y, var_32_32.z)

				local var_32_33 = var_32_25.localEulerAngles

				var_32_33.z = 0
				var_32_33.x = 0
				var_32_25.localEulerAngles = var_32_33
			end

			local var_32_34 = 0
			local var_32_35 = 0.175

			if var_32_34 < arg_29_1.time_ and arg_29_1.time_ <= var_32_34 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_36 = arg_29_1:FormatText(StoryNameCfg[640].name)

				arg_29_1.leftNameTxt_.text = var_32_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_37 = arg_29_1:GetWordFromCfg(319391007)
				local var_32_38 = arg_29_1:FormatText(var_32_37.content)

				arg_29_1.text_.text = var_32_38

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_39 = 7
				local var_32_40 = utf8.len(var_32_38)
				local var_32_41 = var_32_39 <= 0 and var_32_35 or var_32_35 * (var_32_40 / var_32_39)

				if var_32_41 > 0 and var_32_35 < var_32_41 then
					arg_29_1.talkMaxDuration = var_32_41

					if var_32_41 + var_32_34 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_41 + var_32_34
					end
				end

				arg_29_1.text_.text = var_32_38
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391007", "story_v_out_319391.awb") ~= 0 then
					local var_32_42 = manager.audio:GetVoiceLength("story_v_out_319391", "319391007", "story_v_out_319391.awb") / 1000

					if var_32_42 + var_32_34 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_42 + var_32_34
					end

					if var_32_37.prefab_name ~= "" and arg_29_1.actors_[var_32_37.prefab_name] ~= nil then
						local var_32_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_37.prefab_name].transform, "story_v_out_319391", "319391007", "story_v_out_319391.awb")

						arg_29_1:RecordAudio("319391007", var_32_43)
						arg_29_1:RecordAudio("319391007", var_32_43)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319391", "319391007", "story_v_out_319391.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319391", "319391007", "story_v_out_319391.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_44 = math.max(var_32_35, arg_29_1.talkMaxDuration)

			if var_32_34 <= arg_29_1.time_ and arg_29_1.time_ < var_32_34 + var_32_44 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_34) / var_32_44

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_34 + var_32_44 and arg_29_1.time_ < var_32_34 + var_32_44 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play319391008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319391008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play319391009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10066ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10066ui_story == nil then
				arg_33_1.var_.characterEffect10066ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect10066ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10066ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect10066ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10066ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 1.05

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(319391008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 42
				local var_36_11 = utf8.len(var_36_9)
				local var_36_12 = var_36_10 <= 0 and var_36_7 or var_36_7 * (var_36_11 / var_36_10)

				if var_36_12 > 0 and var_36_7 < var_36_12 then
					arg_33_1.talkMaxDuration = var_36_12

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_13 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_13 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_13

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_13 and arg_33_1.time_ < var_36_6 + var_36_13 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play319391009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319391009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play319391010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 1.55

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:GetWordFromCfg(319391009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_4 = 62
				local var_40_5 = utf8.len(var_40_3)
				local var_40_6 = var_40_4 <= 0 and var_40_1 or var_40_1 * (var_40_5 / var_40_4)

				if var_40_6 > 0 and var_40_1 < var_40_6 then
					arg_37_1.talkMaxDuration = var_40_6

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_7 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_7 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_7

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_7 and arg_37_1.time_ < var_40_0 + var_40_7 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play319391010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319391010
		arg_41_1.duration_ = 10.83

		local var_41_0 = {
			zh = 7.466,
			ja = 10.833
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
				arg_41_0:Play319391011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = "ST71a"

			if arg_41_1.bgs_[var_44_0] == nil then
				local var_44_1 = Object.Instantiate(arg_41_1.paintGo_)

				var_44_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_44_0)
				var_44_1.name = var_44_0
				var_44_1.transform.parent = arg_41_1.stage_.transform
				var_44_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.bgs_[var_44_0] = var_44_1
			end

			local var_44_2 = 2

			if var_44_2 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				local var_44_3 = manager.ui.mainCamera.transform.localPosition
				local var_44_4 = Vector3.New(0, 0, 10) + Vector3.New(var_44_3.x, var_44_3.y, 0)
				local var_44_5 = arg_41_1.bgs_.ST71a

				var_44_5.transform.localPosition = var_44_4
				var_44_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_44_6 = var_44_5:GetComponent("SpriteRenderer")

				if var_44_6 and var_44_6.sprite then
					local var_44_7 = (var_44_5.transform.localPosition - var_44_3).z
					local var_44_8 = manager.ui.mainCameraCom_
					local var_44_9 = 2 * var_44_7 * Mathf.Tan(var_44_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_44_10 = var_44_9 * var_44_8.aspect
					local var_44_11 = var_44_6.sprite.bounds.size.x
					local var_44_12 = var_44_6.sprite.bounds.size.y
					local var_44_13 = var_44_10 / var_44_11
					local var_44_14 = var_44_9 / var_44_12
					local var_44_15 = var_44_14 < var_44_13 and var_44_13 or var_44_14

					var_44_5.transform.localScale = Vector3.New(var_44_15, var_44_15, 0)
				end

				for iter_44_0, iter_44_1 in pairs(arg_41_1.bgs_) do
					if iter_44_0 ~= "ST71a" then
						iter_44_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_44_16 = 0

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_17 = 2

			if var_44_16 <= arg_41_1.time_ and arg_41_1.time_ < var_44_16 + var_44_17 then
				local var_44_18 = (arg_41_1.time_ - var_44_16) / var_44_17
				local var_44_19 = Color.New(0, 0, 0)

				var_44_19.a = Mathf.Lerp(0, 1, var_44_18)
				arg_41_1.mask_.color = var_44_19
			end

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 then
				local var_44_20 = Color.New(0, 0, 0)

				var_44_20.a = 1
				arg_41_1.mask_.color = var_44_20
			end

			local var_44_21 = 2

			if var_44_21 < arg_41_1.time_ and arg_41_1.time_ <= var_44_21 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_22 = 2

			if var_44_21 <= arg_41_1.time_ and arg_41_1.time_ < var_44_21 + var_44_22 then
				local var_44_23 = (arg_41_1.time_ - var_44_21) / var_44_22
				local var_44_24 = Color.New(0, 0, 0)

				var_44_24.a = Mathf.Lerp(1, 0, var_44_23)
				arg_41_1.mask_.color = var_44_24
			end

			if arg_41_1.time_ >= var_44_21 + var_44_22 and arg_41_1.time_ < var_44_21 + var_44_22 + arg_44_0 then
				local var_44_25 = Color.New(0, 0, 0)
				local var_44_26 = 0

				arg_41_1.mask_.enabled = false
				var_44_25.a = var_44_26
				arg_41_1.mask_.color = var_44_25
			end

			local var_44_27 = arg_41_1.actors_["10069ui_story"].transform
			local var_44_28 = 4

			if var_44_28 < arg_41_1.time_ and arg_41_1.time_ <= var_44_28 + arg_44_0 then
				arg_41_1.var_.moveOldPos10069ui_story = var_44_27.localPosition
			end

			local var_44_29 = 0.001

			if var_44_28 <= arg_41_1.time_ and arg_41_1.time_ < var_44_28 + var_44_29 then
				local var_44_30 = (arg_41_1.time_ - var_44_28) / var_44_29
				local var_44_31 = Vector3.New(0, -1.08, -6.33)

				var_44_27.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10069ui_story, var_44_31, var_44_30)

				local var_44_32 = manager.ui.mainCamera.transform.position - var_44_27.position

				var_44_27.forward = Vector3.New(var_44_32.x, var_44_32.y, var_44_32.z)

				local var_44_33 = var_44_27.localEulerAngles

				var_44_33.z = 0
				var_44_33.x = 0
				var_44_27.localEulerAngles = var_44_33
			end

			if arg_41_1.time_ >= var_44_28 + var_44_29 and arg_41_1.time_ < var_44_28 + var_44_29 + arg_44_0 then
				var_44_27.localPosition = Vector3.New(0, -1.08, -6.33)

				local var_44_34 = manager.ui.mainCamera.transform.position - var_44_27.position

				var_44_27.forward = Vector3.New(var_44_34.x, var_44_34.y, var_44_34.z)

				local var_44_35 = var_44_27.localEulerAngles

				var_44_35.z = 0
				var_44_35.x = 0
				var_44_27.localEulerAngles = var_44_35
			end

			local var_44_36 = arg_41_1.actors_["10069ui_story"]
			local var_44_37 = 4

			if var_44_37 < arg_41_1.time_ and arg_41_1.time_ <= var_44_37 + arg_44_0 and not isNil(var_44_36) and arg_41_1.var_.characterEffect10069ui_story == nil then
				arg_41_1.var_.characterEffect10069ui_story = var_44_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_38 = 0.200000002980232

			if var_44_37 <= arg_41_1.time_ and arg_41_1.time_ < var_44_37 + var_44_38 and not isNil(var_44_36) then
				local var_44_39 = (arg_41_1.time_ - var_44_37) / var_44_38

				if arg_41_1.var_.characterEffect10069ui_story and not isNil(var_44_36) then
					arg_41_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_37 + var_44_38 and arg_41_1.time_ < var_44_37 + var_44_38 + arg_44_0 and not isNil(var_44_36) and arg_41_1.var_.characterEffect10069ui_story then
				arg_41_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_44_40 = 4

			if var_44_40 < arg_41_1.time_ and arg_41_1.time_ <= var_44_40 + arg_44_0 then
				arg_41_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_44_41 = 4

			if var_44_41 < arg_41_1.time_ and arg_41_1.time_ <= var_44_41 + arg_44_0 then
				arg_41_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_44_42 = arg_41_1.actors_["10066ui_story"].transform
			local var_44_43 = 2

			if var_44_43 < arg_41_1.time_ and arg_41_1.time_ <= var_44_43 + arg_44_0 then
				arg_41_1.var_.moveOldPos10066ui_story = var_44_42.localPosition
			end

			local var_44_44 = 0.001

			if var_44_43 <= arg_41_1.time_ and arg_41_1.time_ < var_44_43 + var_44_44 then
				local var_44_45 = (arg_41_1.time_ - var_44_43) / var_44_44
				local var_44_46 = Vector3.New(0, 100, 0)

				var_44_42.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10066ui_story, var_44_46, var_44_45)

				local var_44_47 = manager.ui.mainCamera.transform.position - var_44_42.position

				var_44_42.forward = Vector3.New(var_44_47.x, var_44_47.y, var_44_47.z)

				local var_44_48 = var_44_42.localEulerAngles

				var_44_48.z = 0
				var_44_48.x = 0
				var_44_42.localEulerAngles = var_44_48
			end

			if arg_41_1.time_ >= var_44_43 + var_44_44 and arg_41_1.time_ < var_44_43 + var_44_44 + arg_44_0 then
				var_44_42.localPosition = Vector3.New(0, 100, 0)

				local var_44_49 = manager.ui.mainCamera.transform.position - var_44_42.position

				var_44_42.forward = Vector3.New(var_44_49.x, var_44_49.y, var_44_49.z)

				local var_44_50 = var_44_42.localEulerAngles

				var_44_50.z = 0
				var_44_50.x = 0
				var_44_42.localEulerAngles = var_44_50
			end

			local var_44_51 = 0
			local var_44_52 = 1

			if var_44_51 < arg_41_1.time_ and arg_41_1.time_ <= var_44_51 + arg_44_0 then
				local var_44_53 = "play"
				local var_44_54 = "effect"

				arg_41_1:AudioAction(var_44_53, var_44_54, "ui_skip", "ui_bgm_lower", "")
			end

			local var_44_55 = 2

			arg_41_1.isInRecall_ = false

			if var_44_55 < arg_41_1.time_ and arg_41_1.time_ <= var_44_55 + arg_44_0 then
				arg_41_1.screenFilterGo_:SetActive(true)

				arg_41_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_44_2, iter_44_3 in pairs(arg_41_1.actors_) do
					local var_44_56 = iter_44_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_44_4, iter_44_5 in ipairs(var_44_56) do
						if iter_44_5.color.r > 0.51 then
							iter_44_5.color = Color.New(1, 1, 1)
						else
							iter_44_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_44_57 = 2

			if var_44_55 <= arg_41_1.time_ and arg_41_1.time_ < var_44_55 + var_44_57 then
				local var_44_58 = (arg_41_1.time_ - var_44_55) / var_44_57

				arg_41_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_44_58)
			end

			if arg_41_1.time_ >= var_44_55 + var_44_57 and arg_41_1.time_ < var_44_55 + var_44_57 + arg_44_0 then
				arg_41_1.screenFilterEffect_.weight = 1
			end

			local var_44_59 = arg_41_1.actors_["1084ui_story"].transform
			local var_44_60 = 2

			if var_44_60 < arg_41_1.time_ and arg_41_1.time_ <= var_44_60 + arg_44_0 then
				arg_41_1.var_.moveOldPos1084ui_story = var_44_59.localPosition
			end

			local var_44_61 = 0.001

			if var_44_60 <= arg_41_1.time_ and arg_41_1.time_ < var_44_60 + var_44_61 then
				local var_44_62 = (arg_41_1.time_ - var_44_60) / var_44_61
				local var_44_63 = Vector3.New(0, 100, 0)

				var_44_59.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1084ui_story, var_44_63, var_44_62)

				local var_44_64 = manager.ui.mainCamera.transform.position - var_44_59.position

				var_44_59.forward = Vector3.New(var_44_64.x, var_44_64.y, var_44_64.z)

				local var_44_65 = var_44_59.localEulerAngles

				var_44_65.z = 0
				var_44_65.x = 0
				var_44_59.localEulerAngles = var_44_65
			end

			if arg_41_1.time_ >= var_44_60 + var_44_61 and arg_41_1.time_ < var_44_60 + var_44_61 + arg_44_0 then
				var_44_59.localPosition = Vector3.New(0, 100, 0)

				local var_44_66 = manager.ui.mainCamera.transform.position - var_44_59.position

				var_44_59.forward = Vector3.New(var_44_66.x, var_44_66.y, var_44_66.z)

				local var_44_67 = var_44_59.localEulerAngles

				var_44_67.z = 0
				var_44_67.x = 0
				var_44_59.localEulerAngles = var_44_67
			end

			local var_44_68 = arg_41_1.actors_["1084ui_story"]
			local var_44_69 = 2

			if var_44_69 < arg_41_1.time_ and arg_41_1.time_ <= var_44_69 + arg_44_0 and not isNil(var_44_68) and arg_41_1.var_.characterEffect1084ui_story == nil then
				arg_41_1.var_.characterEffect1084ui_story = var_44_68:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_70 = 0.200000002980232

			if var_44_69 <= arg_41_1.time_ and arg_41_1.time_ < var_44_69 + var_44_70 and not isNil(var_44_68) then
				local var_44_71 = (arg_41_1.time_ - var_44_69) / var_44_70

				if arg_41_1.var_.characterEffect1084ui_story and not isNil(var_44_68) then
					local var_44_72 = Mathf.Lerp(0, 0.5, var_44_71)

					arg_41_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1084ui_story.fillRatio = var_44_72
				end
			end

			if arg_41_1.time_ >= var_44_69 + var_44_70 and arg_41_1.time_ < var_44_69 + var_44_70 + arg_44_0 and not isNil(var_44_68) and arg_41_1.var_.characterEffect1084ui_story then
				local var_44_73 = 0.5

				arg_41_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1084ui_story.fillRatio = var_44_73
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_74 = 4
			local var_44_75 = 0.35

			if var_44_74 < arg_41_1.time_ and arg_41_1.time_ <= var_44_74 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_76 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_76:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_76:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_76:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_77 = arg_41_1:FormatText(StoryNameCfg[693].name)

				arg_41_1.leftNameTxt_.text = var_44_77

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_78 = arg_41_1:GetWordFromCfg(319391010)
				local var_44_79 = arg_41_1:FormatText(var_44_78.content)

				arg_41_1.text_.text = var_44_79

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_80 = 14
				local var_44_81 = utf8.len(var_44_79)
				local var_44_82 = var_44_80 <= 0 and var_44_75 or var_44_75 * (var_44_81 / var_44_80)

				if var_44_82 > 0 and var_44_75 < var_44_82 then
					arg_41_1.talkMaxDuration = var_44_82
					var_44_74 = var_44_74 + 0.3

					if var_44_82 + var_44_74 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_82 + var_44_74
					end
				end

				arg_41_1.text_.text = var_44_79
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391010", "story_v_out_319391.awb") ~= 0 then
					local var_44_83 = manager.audio:GetVoiceLength("story_v_out_319391", "319391010", "story_v_out_319391.awb") / 1000

					if var_44_83 + var_44_74 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_83 + var_44_74
					end

					if var_44_78.prefab_name ~= "" and arg_41_1.actors_[var_44_78.prefab_name] ~= nil then
						local var_44_84 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_78.prefab_name].transform, "story_v_out_319391", "319391010", "story_v_out_319391.awb")

						arg_41_1:RecordAudio("319391010", var_44_84)
						arg_41_1:RecordAudio("319391010", var_44_84)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319391", "319391010", "story_v_out_319391.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319391", "319391010", "story_v_out_319391.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_85 = var_44_74 + 0.3
			local var_44_86 = math.max(var_44_75, arg_41_1.talkMaxDuration)

			if var_44_85 <= arg_41_1.time_ and arg_41_1.time_ < var_44_85 + var_44_86 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_85) / var_44_86

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_85 + var_44_86 and arg_41_1.time_ < var_44_85 + var_44_86 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play319391011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319391011
		arg_47_1.duration_ = 3.83

		local var_47_0 = {
			zh = 3.833,
			ja = 3.7
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play319391012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["10069ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect10069ui_story == nil then
				arg_47_1.var_.characterEffect10069ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect10069ui_story and not isNil(var_50_0) then
					local var_50_4 = Mathf.Lerp(0, 0.5, var_50_3)

					arg_47_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10069ui_story.fillRatio = var_50_4
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect10069ui_story then
				local var_50_5 = 0.5

				arg_47_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10069ui_story.fillRatio = var_50_5
			end

			local var_50_6 = 0
			local var_50_7 = 0.375

			if var_50_6 < arg_47_1.time_ and arg_47_1.time_ <= var_50_6 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_8 = arg_47_1:FormatText(StoryNameCfg[36].name)

				arg_47_1.leftNameTxt_.text = var_50_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_9 = arg_47_1:GetWordFromCfg(319391011)
				local var_50_10 = arg_47_1:FormatText(var_50_9.content)

				arg_47_1.text_.text = var_50_10

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_11 = 15
				local var_50_12 = utf8.len(var_50_10)
				local var_50_13 = var_50_11 <= 0 and var_50_7 or var_50_7 * (var_50_12 / var_50_11)

				if var_50_13 > 0 and var_50_7 < var_50_13 then
					arg_47_1.talkMaxDuration = var_50_13

					if var_50_13 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_13 + var_50_6
					end
				end

				arg_47_1.text_.text = var_50_10
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391011", "story_v_out_319391.awb") ~= 0 then
					local var_50_14 = manager.audio:GetVoiceLength("story_v_out_319391", "319391011", "story_v_out_319391.awb") / 1000

					if var_50_14 + var_50_6 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_6
					end

					if var_50_9.prefab_name ~= "" and arg_47_1.actors_[var_50_9.prefab_name] ~= nil then
						local var_50_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_9.prefab_name].transform, "story_v_out_319391", "319391011", "story_v_out_319391.awb")

						arg_47_1:RecordAudio("319391011", var_50_15)
						arg_47_1:RecordAudio("319391011", var_50_15)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_319391", "319391011", "story_v_out_319391.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_319391", "319391011", "story_v_out_319391.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_16 = math.max(var_50_7, arg_47_1.talkMaxDuration)

			if var_50_6 <= arg_47_1.time_ and arg_47_1.time_ < var_50_6 + var_50_16 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_6) / var_50_16

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_6 + var_50_16 and arg_47_1.time_ < var_50_6 + var_50_16 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play319391012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319391012
		arg_51_1.duration_ = 1.73

		local var_51_0 = {
			zh = 1,
			ja = 1.733
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play319391013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["10069ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect10069ui_story == nil then
				arg_51_1.var_.characterEffect10069ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect10069ui_story and not isNil(var_54_0) then
					arg_51_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect10069ui_story then
				arg_51_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_54_4 = 0
			local var_54_5 = 0.075

			if var_54_4 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_6 = arg_51_1:FormatText(StoryNameCfg[693].name)

				arg_51_1.leftNameTxt_.text = var_54_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_7 = arg_51_1:GetWordFromCfg(319391012)
				local var_54_8 = arg_51_1:FormatText(var_54_7.content)

				arg_51_1.text_.text = var_54_8

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_9 = 3
				local var_54_10 = utf8.len(var_54_8)
				local var_54_11 = var_54_9 <= 0 and var_54_5 or var_54_5 * (var_54_10 / var_54_9)

				if var_54_11 > 0 and var_54_5 < var_54_11 then
					arg_51_1.talkMaxDuration = var_54_11

					if var_54_11 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_11 + var_54_4
					end
				end

				arg_51_1.text_.text = var_54_8
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391012", "story_v_out_319391.awb") ~= 0 then
					local var_54_12 = manager.audio:GetVoiceLength("story_v_out_319391", "319391012", "story_v_out_319391.awb") / 1000

					if var_54_12 + var_54_4 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_12 + var_54_4
					end

					if var_54_7.prefab_name ~= "" and arg_51_1.actors_[var_54_7.prefab_name] ~= nil then
						local var_54_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_7.prefab_name].transform, "story_v_out_319391", "319391012", "story_v_out_319391.awb")

						arg_51_1:RecordAudio("319391012", var_54_13)
						arg_51_1:RecordAudio("319391012", var_54_13)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_319391", "319391012", "story_v_out_319391.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_319391", "319391012", "story_v_out_319391.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_14 = math.max(var_54_5, arg_51_1.talkMaxDuration)

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_14 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_4) / var_54_14

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_4 + var_54_14 and arg_51_1.time_ < var_54_4 + var_54_14 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play319391013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319391013
		arg_55_1.duration_ = 19.4

		local var_55_0 = {
			zh = 13.0663333333333,
			ja = 19.3993333333333
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play319391014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = "ST71"

			if arg_55_1.bgs_[var_58_0] == nil then
				local var_58_1 = Object.Instantiate(arg_55_1.paintGo_)

				var_58_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_58_0)
				var_58_1.name = var_58_0
				var_58_1.transform.parent = arg_55_1.stage_.transform
				var_58_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.bgs_[var_58_0] = var_58_1
			end

			local var_58_2 = 2

			if var_58_2 < arg_55_1.time_ and arg_55_1.time_ <= var_58_2 + arg_58_0 then
				local var_58_3 = manager.ui.mainCamera.transform.localPosition
				local var_58_4 = Vector3.New(0, 0, 10) + Vector3.New(var_58_3.x, var_58_3.y, 0)
				local var_58_5 = arg_55_1.bgs_.ST71

				var_58_5.transform.localPosition = var_58_4
				var_58_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_58_6 = var_58_5:GetComponent("SpriteRenderer")

				if var_58_6 and var_58_6.sprite then
					local var_58_7 = (var_58_5.transform.localPosition - var_58_3).z
					local var_58_8 = manager.ui.mainCameraCom_
					local var_58_9 = 2 * var_58_7 * Mathf.Tan(var_58_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_58_10 = var_58_9 * var_58_8.aspect
					local var_58_11 = var_58_6.sprite.bounds.size.x
					local var_58_12 = var_58_6.sprite.bounds.size.y
					local var_58_13 = var_58_10 / var_58_11
					local var_58_14 = var_58_9 / var_58_12
					local var_58_15 = var_58_14 < var_58_13 and var_58_13 or var_58_14

					var_58_5.transform.localScale = Vector3.New(var_58_15, var_58_15, 0)
				end

				for iter_58_0, iter_58_1 in pairs(arg_55_1.bgs_) do
					if iter_58_0 ~= "ST71" then
						iter_58_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_58_16 = 0

			if var_58_16 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_17 = 2

			if var_58_16 <= arg_55_1.time_ and arg_55_1.time_ < var_58_16 + var_58_17 then
				local var_58_18 = (arg_55_1.time_ - var_58_16) / var_58_17
				local var_58_19 = Color.New(0, 0, 0)

				var_58_19.a = Mathf.Lerp(0, 1, var_58_18)
				arg_55_1.mask_.color = var_58_19
			end

			if arg_55_1.time_ >= var_58_16 + var_58_17 and arg_55_1.time_ < var_58_16 + var_58_17 + arg_58_0 then
				local var_58_20 = Color.New(0, 0, 0)

				var_58_20.a = 1
				arg_55_1.mask_.color = var_58_20
			end

			local var_58_21 = 2

			if var_58_21 < arg_55_1.time_ and arg_55_1.time_ <= var_58_21 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_22 = 1.53333333333333

			if var_58_21 <= arg_55_1.time_ and arg_55_1.time_ < var_58_21 + var_58_22 then
				local var_58_23 = (arg_55_1.time_ - var_58_21) / var_58_22
				local var_58_24 = Color.New(0, 0, 0)

				var_58_24.a = Mathf.Lerp(1, 0, var_58_23)
				arg_55_1.mask_.color = var_58_24
			end

			if arg_55_1.time_ >= var_58_21 + var_58_22 and arg_55_1.time_ < var_58_21 + var_58_22 + arg_58_0 then
				local var_58_25 = Color.New(0, 0, 0)
				local var_58_26 = 0

				arg_55_1.mask_.enabled = false
				var_58_25.a = var_58_26
				arg_55_1.mask_.color = var_58_25
			end

			local var_58_27 = arg_55_1.actors_["10069ui_story"]
			local var_58_28 = 2

			if var_58_28 < arg_55_1.time_ and arg_55_1.time_ <= var_58_28 + arg_58_0 and not isNil(var_58_27) and arg_55_1.var_.characterEffect10069ui_story == nil then
				arg_55_1.var_.characterEffect10069ui_story = var_58_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_29 = 0.200000002980232

			if var_58_28 <= arg_55_1.time_ and arg_55_1.time_ < var_58_28 + var_58_29 and not isNil(var_58_27) then
				local var_58_30 = (arg_55_1.time_ - var_58_28) / var_58_29

				if arg_55_1.var_.characterEffect10069ui_story and not isNil(var_58_27) then
					arg_55_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_28 + var_58_29 and arg_55_1.time_ < var_58_28 + var_58_29 + arg_58_0 and not isNil(var_58_27) and arg_55_1.var_.characterEffect10069ui_story then
				arg_55_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_58_31 = arg_55_1.actors_["10069ui_story"].transform
			local var_58_32 = 2

			if var_58_32 < arg_55_1.time_ and arg_55_1.time_ <= var_58_32 + arg_58_0 then
				arg_55_1.var_.moveOldPos10069ui_story = var_58_31.localPosition
			end

			local var_58_33 = 0.001

			if var_58_32 <= arg_55_1.time_ and arg_55_1.time_ < var_58_32 + var_58_33 then
				local var_58_34 = (arg_55_1.time_ - var_58_32) / var_58_33
				local var_58_35 = Vector3.New(0, 100, 0)

				var_58_31.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10069ui_story, var_58_35, var_58_34)

				local var_58_36 = manager.ui.mainCamera.transform.position - var_58_31.position

				var_58_31.forward = Vector3.New(var_58_36.x, var_58_36.y, var_58_36.z)

				local var_58_37 = var_58_31.localEulerAngles

				var_58_37.z = 0
				var_58_37.x = 0
				var_58_31.localEulerAngles = var_58_37
			end

			if arg_55_1.time_ >= var_58_32 + var_58_33 and arg_55_1.time_ < var_58_32 + var_58_33 + arg_58_0 then
				var_58_31.localPosition = Vector3.New(0, 100, 0)

				local var_58_38 = manager.ui.mainCamera.transform.position - var_58_31.position

				var_58_31.forward = Vector3.New(var_58_38.x, var_58_38.y, var_58_38.z)

				local var_58_39 = var_58_31.localEulerAngles

				var_58_39.z = 0
				var_58_39.x = 0
				var_58_31.localEulerAngles = var_58_39
			end

			local var_58_40 = arg_55_1.actors_["10069ui_story"].transform
			local var_58_41 = 3.53333333333333

			if var_58_41 < arg_55_1.time_ and arg_55_1.time_ <= var_58_41 + arg_58_0 then
				arg_55_1.var_.moveOldPos10069ui_story = var_58_40.localPosition
			end

			local var_58_42 = 0.001

			if var_58_41 <= arg_55_1.time_ and arg_55_1.time_ < var_58_41 + var_58_42 then
				local var_58_43 = (arg_55_1.time_ - var_58_41) / var_58_42
				local var_58_44 = Vector3.New(0, -1.08, -6.33)

				var_58_40.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10069ui_story, var_58_44, var_58_43)

				local var_58_45 = manager.ui.mainCamera.transform.position - var_58_40.position

				var_58_40.forward = Vector3.New(var_58_45.x, var_58_45.y, var_58_45.z)

				local var_58_46 = var_58_40.localEulerAngles

				var_58_46.z = 0
				var_58_46.x = 0
				var_58_40.localEulerAngles = var_58_46
			end

			if arg_55_1.time_ >= var_58_41 + var_58_42 and arg_55_1.time_ < var_58_41 + var_58_42 + arg_58_0 then
				var_58_40.localPosition = Vector3.New(0, -1.08, -6.33)

				local var_58_47 = manager.ui.mainCamera.transform.position - var_58_40.position

				var_58_40.forward = Vector3.New(var_58_47.x, var_58_47.y, var_58_47.z)

				local var_58_48 = var_58_40.localEulerAngles

				var_58_48.z = 0
				var_58_48.x = 0
				var_58_40.localEulerAngles = var_58_48
			end

			local var_58_49 = arg_55_1.actors_["10069ui_story"]
			local var_58_50 = 3.53333333333333

			if var_58_50 < arg_55_1.time_ and arg_55_1.time_ <= var_58_50 + arg_58_0 and not isNil(var_58_49) and arg_55_1.var_.characterEffect10069ui_story == nil then
				arg_55_1.var_.characterEffect10069ui_story = var_58_49:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_51 = 0.200000002980232

			if var_58_50 <= arg_55_1.time_ and arg_55_1.time_ < var_58_50 + var_58_51 and not isNil(var_58_49) then
				local var_58_52 = (arg_55_1.time_ - var_58_50) / var_58_51

				if arg_55_1.var_.characterEffect10069ui_story and not isNil(var_58_49) then
					arg_55_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_50 + var_58_51 and arg_55_1.time_ < var_58_50 + var_58_51 + arg_58_0 and not isNil(var_58_49) and arg_55_1.var_.characterEffect10069ui_story then
				arg_55_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_53 = 3.53333333333333
			local var_58_54 = 0.975

			if var_58_53 < arg_55_1.time_ and arg_55_1.time_ <= var_58_53 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_55 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_55:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_56 = arg_55_1:FormatText(StoryNameCfg[693].name)

				arg_55_1.leftNameTxt_.text = var_58_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_57 = arg_55_1:GetWordFromCfg(319391013)
				local var_58_58 = arg_55_1:FormatText(var_58_57.content)

				arg_55_1.text_.text = var_58_58

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_59 = 39
				local var_58_60 = utf8.len(var_58_58)
				local var_58_61 = var_58_59 <= 0 and var_58_54 or var_58_54 * (var_58_60 / var_58_59)

				if var_58_61 > 0 and var_58_54 < var_58_61 then
					arg_55_1.talkMaxDuration = var_58_61
					var_58_53 = var_58_53 + 0.3

					if var_58_61 + var_58_53 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_61 + var_58_53
					end
				end

				arg_55_1.text_.text = var_58_58
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391013", "story_v_out_319391.awb") ~= 0 then
					local var_58_62 = manager.audio:GetVoiceLength("story_v_out_319391", "319391013", "story_v_out_319391.awb") / 1000

					if var_58_62 + var_58_53 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_62 + var_58_53
					end

					if var_58_57.prefab_name ~= "" and arg_55_1.actors_[var_58_57.prefab_name] ~= nil then
						local var_58_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_57.prefab_name].transform, "story_v_out_319391", "319391013", "story_v_out_319391.awb")

						arg_55_1:RecordAudio("319391013", var_58_63)
						arg_55_1:RecordAudio("319391013", var_58_63)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_319391", "319391013", "story_v_out_319391.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_319391", "319391013", "story_v_out_319391.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_64 = var_58_53 + 0.3
			local var_58_65 = math.max(var_58_54, arg_55_1.talkMaxDuration)

			if var_58_64 <= arg_55_1.time_ and arg_55_1.time_ < var_58_64 + var_58_65 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_64) / var_58_65

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_64 + var_58_65 and arg_55_1.time_ < var_58_64 + var_58_65 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.53333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play319391014 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319391014
		arg_61_1.duration_ = 9.47

		local var_61_0 = {
			zh = 7,
			ja = 9.466
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
				arg_61_0:Play319391015(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10069/story10069action/10069action3_1")
			end

			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_64_2 = 0
			local var_64_3 = 0.725

			if var_64_2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_4 = arg_61_1:FormatText(StoryNameCfg[693].name)

				arg_61_1.leftNameTxt_.text = var_64_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_5 = arg_61_1:GetWordFromCfg(319391014)
				local var_64_6 = arg_61_1:FormatText(var_64_5.content)

				arg_61_1.text_.text = var_64_6

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 29
				local var_64_8 = utf8.len(var_64_6)
				local var_64_9 = var_64_7 <= 0 and var_64_3 or var_64_3 * (var_64_8 / var_64_7)

				if var_64_9 > 0 and var_64_3 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_2
					end
				end

				arg_61_1.text_.text = var_64_6
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391014", "story_v_out_319391.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_319391", "319391014", "story_v_out_319391.awb") / 1000

					if var_64_10 + var_64_2 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_2
					end

					if var_64_5.prefab_name ~= "" and arg_61_1.actors_[var_64_5.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_5.prefab_name].transform, "story_v_out_319391", "319391014", "story_v_out_319391.awb")

						arg_61_1:RecordAudio("319391014", var_64_11)
						arg_61_1:RecordAudio("319391014", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319391", "319391014", "story_v_out_319391.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319391", "319391014", "story_v_out_319391.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_3, arg_61_1.talkMaxDuration)

			if var_64_2 <= arg_61_1.time_ and arg_61_1.time_ < var_64_2 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_2) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_2 + var_64_12 and arg_61_1.time_ < var_64_2 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play319391015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319391015
		arg_65_1.duration_ = 21.93

		local var_65_0 = {
			zh = 13.733,
			ja = 21.933
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
				arg_65_0:Play319391016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10069ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10069ui_story == nil then
				arg_65_1.var_.characterEffect10069ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect10069ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10069ui_story then
				arg_65_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_68_4 = 0
			local var_68_5 = 1.25

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_6 = arg_65_1:FormatText(StoryNameCfg[693].name)

				arg_65_1.leftNameTxt_.text = var_68_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_7 = arg_65_1:GetWordFromCfg(319391015)
				local var_68_8 = arg_65_1:FormatText(var_68_7.content)

				arg_65_1.text_.text = var_68_8

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 50
				local var_68_10 = utf8.len(var_68_8)
				local var_68_11 = var_68_9 <= 0 and var_68_5 or var_68_5 * (var_68_10 / var_68_9)

				if var_68_11 > 0 and var_68_5 < var_68_11 then
					arg_65_1.talkMaxDuration = var_68_11

					if var_68_11 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_8
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391015", "story_v_out_319391.awb") ~= 0 then
					local var_68_12 = manager.audio:GetVoiceLength("story_v_out_319391", "319391015", "story_v_out_319391.awb") / 1000

					if var_68_12 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_4
					end

					if var_68_7.prefab_name ~= "" and arg_65_1.actors_[var_68_7.prefab_name] ~= nil then
						local var_68_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_7.prefab_name].transform, "story_v_out_319391", "319391015", "story_v_out_319391.awb")

						arg_65_1:RecordAudio("319391015", var_68_13)
						arg_65_1:RecordAudio("319391015", var_68_13)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319391", "319391015", "story_v_out_319391.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319391", "319391015", "story_v_out_319391.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_14 and arg_65_1.time_ < var_68_4 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play319391016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319391016
		arg_69_1.duration_ = 10.97

		local var_69_0 = {
			zh = 6.766,
			ja = 10.966
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
				arg_69_0:Play319391017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0

			if var_72_0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_0 + arg_72_0 then
				arg_69_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10069/story10069actionlink/10069action436")
			end

			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_72_2 = 0
			local var_72_3 = 0.85

			if var_72_2 < arg_69_1.time_ and arg_69_1.time_ <= var_72_2 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_4 = arg_69_1:FormatText(StoryNameCfg[693].name)

				arg_69_1.leftNameTxt_.text = var_72_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_5 = arg_69_1:GetWordFromCfg(319391016)
				local var_72_6 = arg_69_1:FormatText(var_72_5.content)

				arg_69_1.text_.text = var_72_6

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_7 = 34
				local var_72_8 = utf8.len(var_72_6)
				local var_72_9 = var_72_7 <= 0 and var_72_3 or var_72_3 * (var_72_8 / var_72_7)

				if var_72_9 > 0 and var_72_3 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_2
					end
				end

				arg_69_1.text_.text = var_72_6
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391016", "story_v_out_319391.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_319391", "319391016", "story_v_out_319391.awb") / 1000

					if var_72_10 + var_72_2 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_2
					end

					if var_72_5.prefab_name ~= "" and arg_69_1.actors_[var_72_5.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_5.prefab_name].transform, "story_v_out_319391", "319391016", "story_v_out_319391.awb")

						arg_69_1:RecordAudio("319391016", var_72_11)
						arg_69_1:RecordAudio("319391016", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319391", "319391016", "story_v_out_319391.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319391", "319391016", "story_v_out_319391.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_3, arg_69_1.talkMaxDuration)

			if var_72_2 <= arg_69_1.time_ and arg_69_1.time_ < var_72_2 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_2) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_2 + var_72_12 and arg_69_1.time_ < var_72_2 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319391017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319391017
		arg_73_1.duration_ = 16.67

		local var_73_0 = {
			zh = 8.53333333333333,
			ja = 16.6663333333333
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
				arg_73_0:Play319391018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = "ST70"

			if arg_73_1.bgs_[var_76_0] == nil then
				local var_76_1 = Object.Instantiate(arg_73_1.paintGo_)

				var_76_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_76_0)
				var_76_1.name = var_76_0
				var_76_1.transform.parent = arg_73_1.stage_.transform
				var_76_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.bgs_[var_76_0] = var_76_1
			end

			local var_76_2 = 2

			if var_76_2 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				local var_76_3 = manager.ui.mainCamera.transform.localPosition
				local var_76_4 = Vector3.New(0, 0, 10) + Vector3.New(var_76_3.x, var_76_3.y, 0)
				local var_76_5 = arg_73_1.bgs_.ST70

				var_76_5.transform.localPosition = var_76_4
				var_76_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_76_6 = var_76_5:GetComponent("SpriteRenderer")

				if var_76_6 and var_76_6.sprite then
					local var_76_7 = (var_76_5.transform.localPosition - var_76_3).z
					local var_76_8 = manager.ui.mainCameraCom_
					local var_76_9 = 2 * var_76_7 * Mathf.Tan(var_76_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_76_10 = var_76_9 * var_76_8.aspect
					local var_76_11 = var_76_6.sprite.bounds.size.x
					local var_76_12 = var_76_6.sprite.bounds.size.y
					local var_76_13 = var_76_10 / var_76_11
					local var_76_14 = var_76_9 / var_76_12
					local var_76_15 = var_76_14 < var_76_13 and var_76_13 or var_76_14

					var_76_5.transform.localScale = Vector3.New(var_76_15, var_76_15, 0)
				end

				for iter_76_0, iter_76_1 in pairs(arg_73_1.bgs_) do
					if iter_76_0 ~= "ST70" then
						iter_76_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 then
				arg_73_1.allBtn_.enabled = false
			end

			local var_76_17 = 0.3

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 then
				arg_73_1.allBtn_.enabled = true
			end

			local var_76_18 = 0

			if var_76_18 < arg_73_1.time_ and arg_73_1.time_ <= var_76_18 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_19 = 2

			if var_76_18 <= arg_73_1.time_ and arg_73_1.time_ < var_76_18 + var_76_19 then
				local var_76_20 = (arg_73_1.time_ - var_76_18) / var_76_19
				local var_76_21 = Color.New(0, 0, 0)

				var_76_21.a = Mathf.Lerp(0, 1, var_76_20)
				arg_73_1.mask_.color = var_76_21
			end

			if arg_73_1.time_ >= var_76_18 + var_76_19 and arg_73_1.time_ < var_76_18 + var_76_19 + arg_76_0 then
				local var_76_22 = Color.New(0, 0, 0)

				var_76_22.a = 1
				arg_73_1.mask_.color = var_76_22
			end

			local var_76_23 = 2

			if var_76_23 < arg_73_1.time_ and arg_73_1.time_ <= var_76_23 + arg_76_0 then
				arg_73_1.mask_.enabled = true
				arg_73_1.mask_.raycastTarget = true

				arg_73_1:SetGaussion(false)
			end

			local var_76_24 = 2.03333333631357

			if var_76_23 <= arg_73_1.time_ and arg_73_1.time_ < var_76_23 + var_76_24 then
				local var_76_25 = (arg_73_1.time_ - var_76_23) / var_76_24
				local var_76_26 = Color.New(0, 0, 0)

				var_76_26.a = Mathf.Lerp(1, 0, var_76_25)
				arg_73_1.mask_.color = var_76_26
			end

			if arg_73_1.time_ >= var_76_23 + var_76_24 and arg_73_1.time_ < var_76_23 + var_76_24 + arg_76_0 then
				local var_76_27 = Color.New(0, 0, 0)
				local var_76_28 = 0

				arg_73_1.mask_.enabled = false
				var_76_27.a = var_76_28
				arg_73_1.mask_.color = var_76_27
			end

			local var_76_29 = 0
			local var_76_30 = 1

			if var_76_29 < arg_73_1.time_ and arg_73_1.time_ <= var_76_29 + arg_76_0 then
				local var_76_31 = "play"
				local var_76_32 = "effect"

				arg_73_1:AudioAction(var_76_31, var_76_32, "ui_skip", "ui_bgm_lower_back", "")
			end

			local var_76_33 = arg_73_1.actors_["10069ui_story"].transform
			local var_76_34 = 3.83333333333433

			if var_76_34 < arg_73_1.time_ and arg_73_1.time_ <= var_76_34 + arg_76_0 then
				arg_73_1.var_.moveOldPos10069ui_story = var_76_33.localPosition
			end

			local var_76_35 = 0.001

			if var_76_34 <= arg_73_1.time_ and arg_73_1.time_ < var_76_34 + var_76_35 then
				local var_76_36 = (arg_73_1.time_ - var_76_34) / var_76_35
				local var_76_37 = Vector3.New(0, -1.08, -6.33)

				var_76_33.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10069ui_story, var_76_37, var_76_36)

				local var_76_38 = manager.ui.mainCamera.transform.position - var_76_33.position

				var_76_33.forward = Vector3.New(var_76_38.x, var_76_38.y, var_76_38.z)

				local var_76_39 = var_76_33.localEulerAngles

				var_76_39.z = 0
				var_76_39.x = 0
				var_76_33.localEulerAngles = var_76_39
			end

			if arg_73_1.time_ >= var_76_34 + var_76_35 and arg_73_1.time_ < var_76_34 + var_76_35 + arg_76_0 then
				var_76_33.localPosition = Vector3.New(0, -1.08, -6.33)

				local var_76_40 = manager.ui.mainCamera.transform.position - var_76_33.position

				var_76_33.forward = Vector3.New(var_76_40.x, var_76_40.y, var_76_40.z)

				local var_76_41 = var_76_33.localEulerAngles

				var_76_41.z = 0
				var_76_41.x = 0
				var_76_33.localEulerAngles = var_76_41
			end

			local var_76_42 = arg_73_1.actors_["10069ui_story"]
			local var_76_43 = 3.83333333333333

			if var_76_43 < arg_73_1.time_ and arg_73_1.time_ <= var_76_43 + arg_76_0 and not isNil(var_76_42) and arg_73_1.var_.characterEffect10069ui_story == nil then
				arg_73_1.var_.characterEffect10069ui_story = var_76_42:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_44 = 0.200000002980232

			if var_76_43 <= arg_73_1.time_ and arg_73_1.time_ < var_76_43 + var_76_44 and not isNil(var_76_42) then
				local var_76_45 = (arg_73_1.time_ - var_76_43) / var_76_44

				if arg_73_1.var_.characterEffect10069ui_story and not isNil(var_76_42) then
					arg_73_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_43 + var_76_44 and arg_73_1.time_ < var_76_43 + var_76_44 + arg_76_0 and not isNil(var_76_42) and arg_73_1.var_.characterEffect10069ui_story then
				arg_73_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_76_46 = arg_73_1.actors_["10069ui_story"].transform
			local var_76_47 = 1.96599999815226

			if var_76_47 < arg_73_1.time_ and arg_73_1.time_ <= var_76_47 + arg_76_0 then
				arg_73_1.var_.moveOldPos10069ui_story = var_76_46.localPosition
			end

			local var_76_48 = 0.001

			if var_76_47 <= arg_73_1.time_ and arg_73_1.time_ < var_76_47 + var_76_48 then
				local var_76_49 = (arg_73_1.time_ - var_76_47) / var_76_48
				local var_76_50 = Vector3.New(0, 100, 0)

				var_76_46.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10069ui_story, var_76_50, var_76_49)

				local var_76_51 = manager.ui.mainCamera.transform.position - var_76_46.position

				var_76_46.forward = Vector3.New(var_76_51.x, var_76_51.y, var_76_51.z)

				local var_76_52 = var_76_46.localEulerAngles

				var_76_52.z = 0
				var_76_52.x = 0
				var_76_46.localEulerAngles = var_76_52
			end

			if arg_73_1.time_ >= var_76_47 + var_76_48 and arg_73_1.time_ < var_76_47 + var_76_48 + arg_76_0 then
				var_76_46.localPosition = Vector3.New(0, 100, 0)

				local var_76_53 = manager.ui.mainCamera.transform.position - var_76_46.position

				var_76_46.forward = Vector3.New(var_76_53.x, var_76_53.y, var_76_53.z)

				local var_76_54 = var_76_46.localEulerAngles

				var_76_54.z = 0
				var_76_54.x = 0
				var_76_46.localEulerAngles = var_76_54
			end

			local var_76_55 = 3.83333333333333

			if var_76_55 < arg_73_1.time_ and arg_73_1.time_ <= var_76_55 + arg_76_0 then
				arg_73_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10069/story10069action/10069action1_1")
			end

			if arg_73_1.frameCnt_ <= 1 then
				arg_73_1.dialog_:SetActive(false)
			end

			local var_76_56 = 3.83333333333333
			local var_76_57 = 0.525

			if var_76_56 < arg_73_1.time_ and arg_73_1.time_ <= var_76_56 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0

				arg_73_1.dialog_:SetActive(true)

				arg_73_1.dialogCg_.alpha = 0

				local var_76_58 = LeanTween.value(arg_73_1.dialog_, 0, 1, 0.3)

				var_76_58:setOnUpdate(LuaHelper.FloatAction(function(arg_77_0)
					arg_73_1.dialogCg_.alpha = arg_77_0
				end))
				var_76_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_73_1.dialog_)
					var_76_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_73_1.duration_ = arg_73_1.duration_ + 0.3

				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_59 = arg_73_1:FormatText(StoryNameCfg[693].name)

				arg_73_1.leftNameTxt_.text = var_76_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_60 = arg_73_1:GetWordFromCfg(319391017)
				local var_76_61 = arg_73_1:FormatText(var_76_60.content)

				arg_73_1.text_.text = var_76_61

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_62 = 21
				local var_76_63 = utf8.len(var_76_61)
				local var_76_64 = var_76_62 <= 0 and var_76_57 or var_76_57 * (var_76_63 / var_76_62)

				if var_76_64 > 0 and var_76_57 < var_76_64 then
					arg_73_1.talkMaxDuration = var_76_64
					var_76_56 = var_76_56 + 0.3

					if var_76_64 + var_76_56 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_64 + var_76_56
					end
				end

				arg_73_1.text_.text = var_76_61
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391017", "story_v_out_319391.awb") ~= 0 then
					local var_76_65 = manager.audio:GetVoiceLength("story_v_out_319391", "319391017", "story_v_out_319391.awb") / 1000

					if var_76_65 + var_76_56 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_65 + var_76_56
					end

					if var_76_60.prefab_name ~= "" and arg_73_1.actors_[var_76_60.prefab_name] ~= nil then
						local var_76_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_60.prefab_name].transform, "story_v_out_319391", "319391017", "story_v_out_319391.awb")

						arg_73_1:RecordAudio("319391017", var_76_66)
						arg_73_1:RecordAudio("319391017", var_76_66)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_319391", "319391017", "story_v_out_319391.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_319391", "319391017", "story_v_out_319391.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_67 = var_76_56 + 0.3
			local var_76_68 = math.max(var_76_57, arg_73_1.talkMaxDuration)

			if var_76_67 <= arg_73_1.time_ and arg_73_1.time_ < var_76_67 + var_76_68 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_67) / var_76_68

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_67 + var_76_68 and arg_73_1.time_ < var_76_67 + var_76_68 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333433,
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

		arg_73_1:InitPlayNodeList()
	end,
	Play319391018 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319391018
		arg_79_1.duration_ = 14.77

		local var_79_0 = {
			zh = 9.666,
			ja = 14.766
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
				arg_79_0:Play319391019(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_82_1 = 0
			local var_82_2 = 0.95

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_3 = arg_79_1:FormatText(StoryNameCfg[693].name)

				arg_79_1.leftNameTxt_.text = var_82_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_4 = arg_79_1:GetWordFromCfg(319391018)
				local var_82_5 = arg_79_1:FormatText(var_82_4.content)

				arg_79_1.text_.text = var_82_5

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_6 = 38
				local var_82_7 = utf8.len(var_82_5)
				local var_82_8 = var_82_6 <= 0 and var_82_2 or var_82_2 * (var_82_7 / var_82_6)

				if var_82_8 > 0 and var_82_2 < var_82_8 then
					arg_79_1.talkMaxDuration = var_82_8

					if var_82_8 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_8 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_5
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391018", "story_v_out_319391.awb") ~= 0 then
					local var_82_9 = manager.audio:GetVoiceLength("story_v_out_319391", "319391018", "story_v_out_319391.awb") / 1000

					if var_82_9 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_1
					end

					if var_82_4.prefab_name ~= "" and arg_79_1.actors_[var_82_4.prefab_name] ~= nil then
						local var_82_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_4.prefab_name].transform, "story_v_out_319391", "319391018", "story_v_out_319391.awb")

						arg_79_1:RecordAudio("319391018", var_82_10)
						arg_79_1:RecordAudio("319391018", var_82_10)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_319391", "319391018", "story_v_out_319391.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_319391", "319391018", "story_v_out_319391.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_11 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_11 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_11

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_11 and arg_79_1.time_ < var_82_1 + var_82_11 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play319391019 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 319391019
		arg_83_1.duration_ = 12.7

		local var_83_0 = {
			zh = 8.033,
			ja = 12.7
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
				arg_83_0:Play319391020(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_86_1 = 0
			local var_86_2 = 0.725

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_3 = arg_83_1:FormatText(StoryNameCfg[693].name)

				arg_83_1.leftNameTxt_.text = var_86_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_4 = arg_83_1:GetWordFromCfg(319391019)
				local var_86_5 = arg_83_1:FormatText(var_86_4.content)

				arg_83_1.text_.text = var_86_5

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_6 = 29
				local var_86_7 = utf8.len(var_86_5)
				local var_86_8 = var_86_6 <= 0 and var_86_2 or var_86_2 * (var_86_7 / var_86_6)

				if var_86_8 > 0 and var_86_2 < var_86_8 then
					arg_83_1.talkMaxDuration = var_86_8

					if var_86_8 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_5
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391019", "story_v_out_319391.awb") ~= 0 then
					local var_86_9 = manager.audio:GetVoiceLength("story_v_out_319391", "319391019", "story_v_out_319391.awb") / 1000

					if var_86_9 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_9 + var_86_1
					end

					if var_86_4.prefab_name ~= "" and arg_83_1.actors_[var_86_4.prefab_name] ~= nil then
						local var_86_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_4.prefab_name].transform, "story_v_out_319391", "319391019", "story_v_out_319391.awb")

						arg_83_1:RecordAudio("319391019", var_86_10)
						arg_83_1:RecordAudio("319391019", var_86_10)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_319391", "319391019", "story_v_out_319391.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_319391", "319391019", "story_v_out_319391.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_11 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_11 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_11

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_11 and arg_83_1.time_ < var_86_1 + var_86_11 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play319391020 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 319391020
		arg_87_1.duration_ = 8.07

		local var_87_0 = {
			zh = 7.266,
			ja = 8.066
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
				arg_87_0:Play319391021(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = "I11l"

			if arg_87_1.bgs_[var_90_0] == nil then
				local var_90_1 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_90_0)
				var_90_1.name = var_90_0
				var_90_1.transform.parent = arg_87_1.stage_.transform
				var_90_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_[var_90_0] = var_90_1
			end

			local var_90_2 = 2

			if var_90_2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				local var_90_3 = manager.ui.mainCamera.transform.localPosition
				local var_90_4 = Vector3.New(0, 0, 10) + Vector3.New(var_90_3.x, var_90_3.y, 0)
				local var_90_5 = arg_87_1.bgs_.I11l

				var_90_5.transform.localPosition = var_90_4
				var_90_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_6 = var_90_5:GetComponent("SpriteRenderer")

				if var_90_6 and var_90_6.sprite then
					local var_90_7 = (var_90_5.transform.localPosition - var_90_3).z
					local var_90_8 = manager.ui.mainCameraCom_
					local var_90_9 = 2 * var_90_7 * Mathf.Tan(var_90_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_90_10 = var_90_9 * var_90_8.aspect
					local var_90_11 = var_90_6.sprite.bounds.size.x
					local var_90_12 = var_90_6.sprite.bounds.size.y
					local var_90_13 = var_90_10 / var_90_11
					local var_90_14 = var_90_9 / var_90_12
					local var_90_15 = var_90_14 < var_90_13 and var_90_13 or var_90_14

					var_90_5.transform.localScale = Vector3.New(var_90_15, var_90_15, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "I11l" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_16 = 0

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 then
				arg_87_1.allBtn_.enabled = false
			end

			local var_90_17 = 0.3

			if arg_87_1.time_ >= var_90_16 + var_90_17 and arg_87_1.time_ < var_90_16 + var_90_17 + arg_90_0 then
				arg_87_1.allBtn_.enabled = true
			end

			local var_90_18 = 0

			if var_90_18 < arg_87_1.time_ and arg_87_1.time_ <= var_90_18 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_19 = 2

			if var_90_18 <= arg_87_1.time_ and arg_87_1.time_ < var_90_18 + var_90_19 then
				local var_90_20 = (arg_87_1.time_ - var_90_18) / var_90_19
				local var_90_21 = Color.New(0, 0, 0)

				var_90_21.a = Mathf.Lerp(0, 1, var_90_20)
				arg_87_1.mask_.color = var_90_21
			end

			if arg_87_1.time_ >= var_90_18 + var_90_19 and arg_87_1.time_ < var_90_18 + var_90_19 + arg_90_0 then
				local var_90_22 = Color.New(0, 0, 0)

				var_90_22.a = 1
				arg_87_1.mask_.color = var_90_22
			end

			local var_90_23 = 2

			if var_90_23 < arg_87_1.time_ and arg_87_1.time_ <= var_90_23 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_24 = 2

			if var_90_23 <= arg_87_1.time_ and arg_87_1.time_ < var_90_23 + var_90_24 then
				local var_90_25 = (arg_87_1.time_ - var_90_23) / var_90_24
				local var_90_26 = Color.New(0, 0, 0)

				var_90_26.a = Mathf.Lerp(1, 0, var_90_25)
				arg_87_1.mask_.color = var_90_26
			end

			if arg_87_1.time_ >= var_90_23 + var_90_24 and arg_87_1.time_ < var_90_23 + var_90_24 + arg_90_0 then
				local var_90_27 = Color.New(0, 0, 0)
				local var_90_28 = 0

				arg_87_1.mask_.enabled = false
				var_90_27.a = var_90_28
				arg_87_1.mask_.color = var_90_27
			end

			local var_90_29 = arg_87_1.actors_["10069ui_story"].transform
			local var_90_30 = 4

			if var_90_30 < arg_87_1.time_ and arg_87_1.time_ <= var_90_30 + arg_90_0 then
				arg_87_1.var_.moveOldPos10069ui_story = var_90_29.localPosition
			end

			local var_90_31 = 0.001

			if var_90_30 <= arg_87_1.time_ and arg_87_1.time_ < var_90_30 + var_90_31 then
				local var_90_32 = (arg_87_1.time_ - var_90_30) / var_90_31
				local var_90_33 = Vector3.New(0, -1.08, -6.33)

				var_90_29.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10069ui_story, var_90_33, var_90_32)

				local var_90_34 = manager.ui.mainCamera.transform.position - var_90_29.position

				var_90_29.forward = Vector3.New(var_90_34.x, var_90_34.y, var_90_34.z)

				local var_90_35 = var_90_29.localEulerAngles

				var_90_35.z = 0
				var_90_35.x = 0
				var_90_29.localEulerAngles = var_90_35
			end

			if arg_87_1.time_ >= var_90_30 + var_90_31 and arg_87_1.time_ < var_90_30 + var_90_31 + arg_90_0 then
				var_90_29.localPosition = Vector3.New(0, -1.08, -6.33)

				local var_90_36 = manager.ui.mainCamera.transform.position - var_90_29.position

				var_90_29.forward = Vector3.New(var_90_36.x, var_90_36.y, var_90_36.z)

				local var_90_37 = var_90_29.localEulerAngles

				var_90_37.z = 0
				var_90_37.x = 0
				var_90_29.localEulerAngles = var_90_37
			end

			local var_90_38 = arg_87_1.actors_["10069ui_story"]
			local var_90_39 = 4

			if var_90_39 < arg_87_1.time_ and arg_87_1.time_ <= var_90_39 + arg_90_0 and not isNil(var_90_38) and arg_87_1.var_.characterEffect10069ui_story == nil then
				arg_87_1.var_.characterEffect10069ui_story = var_90_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_40 = 0.200000002980232

			if var_90_39 <= arg_87_1.time_ and arg_87_1.time_ < var_90_39 + var_90_40 and not isNil(var_90_38) then
				local var_90_41 = (arg_87_1.time_ - var_90_39) / var_90_40

				if arg_87_1.var_.characterEffect10069ui_story and not isNil(var_90_38) then
					arg_87_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_39 + var_90_40 and arg_87_1.time_ < var_90_39 + var_90_40 + arg_90_0 and not isNil(var_90_38) and arg_87_1.var_.characterEffect10069ui_story then
				arg_87_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_90_42 = 4

			if var_90_42 < arg_87_1.time_ and arg_87_1.time_ <= var_90_42 + arg_90_0 then
				arg_87_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_90_43 = 4

			if var_90_43 < arg_87_1.time_ and arg_87_1.time_ <= var_90_43 + arg_90_0 then
				arg_87_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_90_44 = arg_87_1.actors_["10069ui_story"].transform
			local var_90_45 = 2

			if var_90_45 < arg_87_1.time_ and arg_87_1.time_ <= var_90_45 + arg_90_0 then
				arg_87_1.var_.moveOldPos10069ui_story = var_90_44.localPosition
			end

			local var_90_46 = 0.001

			if var_90_45 <= arg_87_1.time_ and arg_87_1.time_ < var_90_45 + var_90_46 then
				local var_90_47 = (arg_87_1.time_ - var_90_45) / var_90_46
				local var_90_48 = Vector3.New(0, 100, 0)

				var_90_44.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10069ui_story, var_90_48, var_90_47)

				local var_90_49 = manager.ui.mainCamera.transform.position - var_90_44.position

				var_90_44.forward = Vector3.New(var_90_49.x, var_90_49.y, var_90_49.z)

				local var_90_50 = var_90_44.localEulerAngles

				var_90_50.z = 0
				var_90_50.x = 0
				var_90_44.localEulerAngles = var_90_50
			end

			if arg_87_1.time_ >= var_90_45 + var_90_46 and arg_87_1.time_ < var_90_45 + var_90_46 + arg_90_0 then
				var_90_44.localPosition = Vector3.New(0, 100, 0)

				local var_90_51 = manager.ui.mainCamera.transform.position - var_90_44.position

				var_90_44.forward = Vector3.New(var_90_51.x, var_90_51.y, var_90_51.z)

				local var_90_52 = var_90_44.localEulerAngles

				var_90_52.z = 0
				var_90_52.x = 0
				var_90_44.localEulerAngles = var_90_52
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_53 = 4
			local var_90_54 = 0.325

			if var_90_53 < arg_87_1.time_ and arg_87_1.time_ <= var_90_53 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				arg_87_1.dialogCg_.alpha = 0

				local var_90_55 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_55:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_55:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_55:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_56 = arg_87_1:FormatText(StoryNameCfg[693].name)

				arg_87_1.leftNameTxt_.text = var_90_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_57 = arg_87_1:GetWordFromCfg(319391020)
				local var_90_58 = arg_87_1:FormatText(var_90_57.content)

				arg_87_1.text_.text = var_90_58

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_59 = 13
				local var_90_60 = utf8.len(var_90_58)
				local var_90_61 = var_90_59 <= 0 and var_90_54 or var_90_54 * (var_90_60 / var_90_59)

				if var_90_61 > 0 and var_90_54 < var_90_61 then
					arg_87_1.talkMaxDuration = var_90_61
					var_90_53 = var_90_53 + 0.3

					if var_90_61 + var_90_53 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_61 + var_90_53
					end
				end

				arg_87_1.text_.text = var_90_58
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391020", "story_v_out_319391.awb") ~= 0 then
					local var_90_62 = manager.audio:GetVoiceLength("story_v_out_319391", "319391020", "story_v_out_319391.awb") / 1000

					if var_90_62 + var_90_53 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_62 + var_90_53
					end

					if var_90_57.prefab_name ~= "" and arg_87_1.actors_[var_90_57.prefab_name] ~= nil then
						local var_90_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_57.prefab_name].transform, "story_v_out_319391", "319391020", "story_v_out_319391.awb")

						arg_87_1:RecordAudio("319391020", var_90_63)
						arg_87_1:RecordAudio("319391020", var_90_63)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_319391", "319391020", "story_v_out_319391.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_319391", "319391020", "story_v_out_319391.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_64 = var_90_53 + 0.3
			local var_90_65 = math.max(var_90_54, arg_87_1.talkMaxDuration)

			if var_90_64 <= arg_87_1.time_ and arg_87_1.time_ < var_90_64 + var_90_65 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_64) / var_90_65

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_64 + var_90_65 and arg_87_1.time_ < var_90_64 + var_90_65 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play319391021 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319391021
		arg_93_1.duration_ = 9.1

		local var_93_0 = {
			zh = 5.833,
			ja = 9.1
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
				arg_93_0:Play319391022(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0
			local var_96_1 = 0.7

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_2 = arg_93_1:FormatText(StoryNameCfg[693].name)

				arg_93_1.leftNameTxt_.text = var_96_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:GetWordFromCfg(319391021)
				local var_96_4 = arg_93_1:FormatText(var_96_3.content)

				arg_93_1.text_.text = var_96_4

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 28
				local var_96_6 = utf8.len(var_96_4)
				local var_96_7 = var_96_5 <= 0 and var_96_1 or var_96_1 * (var_96_6 / var_96_5)

				if var_96_7 > 0 and var_96_1 < var_96_7 then
					arg_93_1.talkMaxDuration = var_96_7

					if var_96_7 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_7 + var_96_0
					end
				end

				arg_93_1.text_.text = var_96_4
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391021", "story_v_out_319391.awb") ~= 0 then
					local var_96_8 = manager.audio:GetVoiceLength("story_v_out_319391", "319391021", "story_v_out_319391.awb") / 1000

					if var_96_8 + var_96_0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_8 + var_96_0
					end

					if var_96_3.prefab_name ~= "" and arg_93_1.actors_[var_96_3.prefab_name] ~= nil then
						local var_96_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_3.prefab_name].transform, "story_v_out_319391", "319391021", "story_v_out_319391.awb")

						arg_93_1:RecordAudio("319391021", var_96_9)
						arg_93_1:RecordAudio("319391021", var_96_9)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319391", "319391021", "story_v_out_319391.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319391", "319391021", "story_v_out_319391.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_10 = math.max(var_96_1, arg_93_1.talkMaxDuration)

			if var_96_0 <= arg_93_1.time_ and arg_93_1.time_ < var_96_0 + var_96_10 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_0) / var_96_10

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_0 + var_96_10 and arg_93_1.time_ < var_96_0 + var_96_10 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319391022 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319391022
		arg_97_1.duration_ = 10.17

		local var_97_0 = {
			zh = 6.566,
			ja = 10.166
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
				arg_97_0:Play319391023(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["10069ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10069ui_story == nil then
				arg_97_1.var_.characterEffect10069ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect10069ui_story and not isNil(var_100_0) then
					arg_97_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect10069ui_story then
				arg_97_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_100_4 = 0

			if var_100_4 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_100_5 = 0
			local var_100_6 = 0.6

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_7 = arg_97_1:FormatText(StoryNameCfg[693].name)

				arg_97_1.leftNameTxt_.text = var_100_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:GetWordFromCfg(319391022)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 24
				local var_100_11 = utf8.len(var_100_9)
				local var_100_12 = var_100_10 <= 0 and var_100_6 or var_100_6 * (var_100_11 / var_100_10)

				if var_100_12 > 0 and var_100_6 < var_100_12 then
					arg_97_1.talkMaxDuration = var_100_12

					if var_100_12 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_5
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391022", "story_v_out_319391.awb") ~= 0 then
					local var_100_13 = manager.audio:GetVoiceLength("story_v_out_319391", "319391022", "story_v_out_319391.awb") / 1000

					if var_100_13 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_5
					end

					if var_100_8.prefab_name ~= "" and arg_97_1.actors_[var_100_8.prefab_name] ~= nil then
						local var_100_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_8.prefab_name].transform, "story_v_out_319391", "319391022", "story_v_out_319391.awb")

						arg_97_1:RecordAudio("319391022", var_100_14)
						arg_97_1:RecordAudio("319391022", var_100_14)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319391", "319391022", "story_v_out_319391.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319391", "319391022", "story_v_out_319391.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_15 = math.max(var_100_6, arg_97_1.talkMaxDuration)

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_15 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_5) / var_100_15

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_5 + var_100_15 and arg_97_1.time_ < var_100_5 + var_100_15 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play319391023 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319391023
		arg_101_1.duration_ = 6

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play319391024(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 2

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				local var_104_1 = manager.ui.mainCamera.transform.localPosition
				local var_104_2 = Vector3.New(0, 0, 10) + Vector3.New(var_104_1.x, var_104_1.y, 0)
				local var_104_3 = arg_101_1.bgs_.ST72

				var_104_3.transform.localPosition = var_104_2
				var_104_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_104_4 = var_104_3:GetComponent("SpriteRenderer")

				if var_104_4 and var_104_4.sprite then
					local var_104_5 = (var_104_3.transform.localPosition - var_104_1).z
					local var_104_6 = manager.ui.mainCameraCom_
					local var_104_7 = 2 * var_104_5 * Mathf.Tan(var_104_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_104_8 = var_104_7 * var_104_6.aspect
					local var_104_9 = var_104_4.sprite.bounds.size.x
					local var_104_10 = var_104_4.sprite.bounds.size.y
					local var_104_11 = var_104_8 / var_104_9
					local var_104_12 = var_104_7 / var_104_10
					local var_104_13 = var_104_12 < var_104_11 and var_104_11 or var_104_12

					var_104_3.transform.localScale = Vector3.New(var_104_13, var_104_13, 0)
				end

				for iter_104_0, iter_104_1 in pairs(arg_101_1.bgs_) do
					if iter_104_0 ~= "ST72" then
						iter_104_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_15 = 2

			if var_104_14 <= arg_101_1.time_ and arg_101_1.time_ < var_104_14 + var_104_15 then
				local var_104_16 = (arg_101_1.time_ - var_104_14) / var_104_15
				local var_104_17 = Color.New(0, 0, 0)

				var_104_17.a = Mathf.Lerp(0, 1, var_104_16)
				arg_101_1.mask_.color = var_104_17
			end

			if arg_101_1.time_ >= var_104_14 + var_104_15 and arg_101_1.time_ < var_104_14 + var_104_15 + arg_104_0 then
				local var_104_18 = Color.New(0, 0, 0)

				var_104_18.a = 1
				arg_101_1.mask_.color = var_104_18
			end

			local var_104_19 = 2

			if var_104_19 < arg_101_1.time_ and arg_101_1.time_ <= var_104_19 + arg_104_0 then
				arg_101_1.mask_.enabled = true
				arg_101_1.mask_.raycastTarget = true

				arg_101_1:SetGaussion(false)
			end

			local var_104_20 = 2

			if var_104_19 <= arg_101_1.time_ and arg_101_1.time_ < var_104_19 + var_104_20 then
				local var_104_21 = (arg_101_1.time_ - var_104_19) / var_104_20
				local var_104_22 = Color.New(0, 0, 0)

				var_104_22.a = Mathf.Lerp(1, 0, var_104_21)
				arg_101_1.mask_.color = var_104_22
			end

			if arg_101_1.time_ >= var_104_19 + var_104_20 and arg_101_1.time_ < var_104_19 + var_104_20 + arg_104_0 then
				local var_104_23 = Color.New(0, 0, 0)
				local var_104_24 = 0

				arg_101_1.mask_.enabled = false
				var_104_23.a = var_104_24
				arg_101_1.mask_.color = var_104_23
			end

			local var_104_25 = arg_101_1.actors_["1084ui_story"].transform
			local var_104_26 = 4

			if var_104_26 < arg_101_1.time_ and arg_101_1.time_ <= var_104_26 + arg_104_0 then
				arg_101_1.var_.moveOldPos1084ui_story = var_104_25.localPosition
			end

			local var_104_27 = 0.001

			if var_104_26 <= arg_101_1.time_ and arg_101_1.time_ < var_104_26 + var_104_27 then
				local var_104_28 = (arg_101_1.time_ - var_104_26) / var_104_27
				local var_104_29 = Vector3.New(0, -0.97, -6)

				var_104_25.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1084ui_story, var_104_29, var_104_28)

				local var_104_30 = manager.ui.mainCamera.transform.position - var_104_25.position

				var_104_25.forward = Vector3.New(var_104_30.x, var_104_30.y, var_104_30.z)

				local var_104_31 = var_104_25.localEulerAngles

				var_104_31.z = 0
				var_104_31.x = 0
				var_104_25.localEulerAngles = var_104_31
			end

			if arg_101_1.time_ >= var_104_26 + var_104_27 and arg_101_1.time_ < var_104_26 + var_104_27 + arg_104_0 then
				var_104_25.localPosition = Vector3.New(0, -0.97, -6)

				local var_104_32 = manager.ui.mainCamera.transform.position - var_104_25.position

				var_104_25.forward = Vector3.New(var_104_32.x, var_104_32.y, var_104_32.z)

				local var_104_33 = var_104_25.localEulerAngles

				var_104_33.z = 0
				var_104_33.x = 0
				var_104_25.localEulerAngles = var_104_33
			end

			local var_104_34 = arg_101_1.actors_["1084ui_story"]
			local var_104_35 = 4

			if var_104_35 < arg_101_1.time_ and arg_101_1.time_ <= var_104_35 + arg_104_0 and not isNil(var_104_34) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_36 = 0.200000002980232

			if var_104_35 <= arg_101_1.time_ and arg_101_1.time_ < var_104_35 + var_104_36 and not isNil(var_104_34) then
				local var_104_37 = (arg_101_1.time_ - var_104_35) / var_104_36

				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_34) then
					arg_101_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_35 + var_104_36 and arg_101_1.time_ < var_104_35 + var_104_36 + arg_104_0 and not isNil(var_104_34) and arg_101_1.var_.characterEffect1084ui_story then
				arg_101_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_104_38 = 4

			if var_104_38 < arg_101_1.time_ and arg_101_1.time_ <= var_104_38 + arg_104_0 then
				arg_101_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_104_39 = arg_101_1.actors_["10069ui_story"].transform
			local var_104_40 = 2

			if var_104_40 < arg_101_1.time_ and arg_101_1.time_ <= var_104_40 + arg_104_0 then
				arg_101_1.var_.moveOldPos10069ui_story = var_104_39.localPosition
			end

			local var_104_41 = 0.001

			if var_104_40 <= arg_101_1.time_ and arg_101_1.time_ < var_104_40 + var_104_41 then
				local var_104_42 = (arg_101_1.time_ - var_104_40) / var_104_41
				local var_104_43 = Vector3.New(0, 100, 0)

				var_104_39.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10069ui_story, var_104_43, var_104_42)

				local var_104_44 = manager.ui.mainCamera.transform.position - var_104_39.position

				var_104_39.forward = Vector3.New(var_104_44.x, var_104_44.y, var_104_44.z)

				local var_104_45 = var_104_39.localEulerAngles

				var_104_45.z = 0
				var_104_45.x = 0
				var_104_39.localEulerAngles = var_104_45
			end

			if arg_101_1.time_ >= var_104_40 + var_104_41 and arg_101_1.time_ < var_104_40 + var_104_41 + arg_104_0 then
				var_104_39.localPosition = Vector3.New(0, 100, 0)

				local var_104_46 = manager.ui.mainCamera.transform.position - var_104_39.position

				var_104_39.forward = Vector3.New(var_104_46.x, var_104_46.y, var_104_46.z)

				local var_104_47 = var_104_39.localEulerAngles

				var_104_47.z = 0
				var_104_47.x = 0
				var_104_39.localEulerAngles = var_104_47
			end

			local var_104_48 = arg_101_1.actors_["10069ui_story"]
			local var_104_49 = 2

			if var_104_49 < arg_101_1.time_ and arg_101_1.time_ <= var_104_49 + arg_104_0 and not isNil(var_104_48) and arg_101_1.var_.characterEffect10069ui_story == nil then
				arg_101_1.var_.characterEffect10069ui_story = var_104_48:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_50 = 0.200000002980232

			if var_104_49 <= arg_101_1.time_ and arg_101_1.time_ < var_104_49 + var_104_50 and not isNil(var_104_48) then
				local var_104_51 = (arg_101_1.time_ - var_104_49) / var_104_50

				if arg_101_1.var_.characterEffect10069ui_story and not isNil(var_104_48) then
					local var_104_52 = Mathf.Lerp(0, 0.5, var_104_51)

					arg_101_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10069ui_story.fillRatio = var_104_52
				end
			end

			if arg_101_1.time_ >= var_104_49 + var_104_50 and arg_101_1.time_ < var_104_49 + var_104_50 + arg_104_0 and not isNil(var_104_48) and arg_101_1.var_.characterEffect10069ui_story then
				local var_104_53 = 0.5

				arg_101_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10069ui_story.fillRatio = var_104_53
			end

			local var_104_54 = 2

			arg_101_1.isInRecall_ = false

			if var_104_54 < arg_101_1.time_ and arg_101_1.time_ <= var_104_54 + arg_104_0 then
				arg_101_1.screenFilterGo_:SetActive(false)

				for iter_104_2, iter_104_3 in pairs(arg_101_1.actors_) do
					local var_104_55 = iter_104_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_104_4, iter_104_5 in ipairs(var_104_55) do
						if iter_104_5.color.r > 0.51 then
							iter_104_5.color = Color.New(1, 1, 1)
						else
							iter_104_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_104_56 = 0.2333333

			if var_104_54 <= arg_101_1.time_ and arg_101_1.time_ < var_104_54 + var_104_56 then
				local var_104_57 = (arg_101_1.time_ - var_104_54) / var_104_56

				arg_101_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_104_57)
			end

			if arg_101_1.time_ >= var_104_54 + var_104_56 and arg_101_1.time_ < var_104_54 + var_104_56 + arg_104_0 then
				arg_101_1.screenFilterEffect_.weight = 0
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_58 = 4
			local var_104_59 = 0.175

			if var_104_58 < arg_101_1.time_ and arg_101_1.time_ <= var_104_58 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_60 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_60:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_61 = arg_101_1:FormatText(StoryNameCfg[6].name)

				arg_101_1.leftNameTxt_.text = var_104_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_62 = arg_101_1:GetWordFromCfg(319391023)
				local var_104_63 = arg_101_1:FormatText(var_104_62.content)

				arg_101_1.text_.text = var_104_63

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_64 = 7
				local var_104_65 = utf8.len(var_104_63)
				local var_104_66 = var_104_64 <= 0 and var_104_59 or var_104_59 * (var_104_65 / var_104_64)

				if var_104_66 > 0 and var_104_59 < var_104_66 then
					arg_101_1.talkMaxDuration = var_104_66
					var_104_58 = var_104_58 + 0.3

					if var_104_66 + var_104_58 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_66 + var_104_58
					end
				end

				arg_101_1.text_.text = var_104_63
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391023", "story_v_out_319391.awb") ~= 0 then
					local var_104_67 = manager.audio:GetVoiceLength("story_v_out_319391", "319391023", "story_v_out_319391.awb") / 1000

					if var_104_67 + var_104_58 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_67 + var_104_58
					end

					if var_104_62.prefab_name ~= "" and arg_101_1.actors_[var_104_62.prefab_name] ~= nil then
						local var_104_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_62.prefab_name].transform, "story_v_out_319391", "319391023", "story_v_out_319391.awb")

						arg_101_1:RecordAudio("319391023", var_104_68)
						arg_101_1:RecordAudio("319391023", var_104_68)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319391", "319391023", "story_v_out_319391.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319391", "319391023", "story_v_out_319391.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_69 = var_104_58 + 0.3
			local var_104_70 = math.max(var_104_59, arg_101_1.talkMaxDuration)

			if var_104_69 <= arg_101_1.time_ and arg_101_1.time_ < var_104_69 + var_104_70 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_69) / var_104_70

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_69 + var_104_70 and arg_101_1.time_ < var_104_69 + var_104_70 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play319391024 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319391024
		arg_107_1.duration_ = 4.67

		local var_107_0 = {
			zh = 3.5,
			ja = 4.666
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
				arg_107_0:Play319391025(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["10069ui_story"].transform
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 then
				arg_107_1.var_.moveOldPos10069ui_story = var_110_0.localPosition
			end

			local var_110_2 = 0.001

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2
				local var_110_4 = Vector3.New(0.7, -1.08, -6.33)

				var_110_0.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10069ui_story, var_110_4, var_110_3)

				local var_110_5 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_5.x, var_110_5.y, var_110_5.z)

				local var_110_6 = var_110_0.localEulerAngles

				var_110_6.z = 0
				var_110_6.x = 0
				var_110_0.localEulerAngles = var_110_6
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 then
				var_110_0.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_110_7 = manager.ui.mainCamera.transform.position - var_110_0.position

				var_110_0.forward = Vector3.New(var_110_7.x, var_110_7.y, var_110_7.z)

				local var_110_8 = var_110_0.localEulerAngles

				var_110_8.z = 0
				var_110_8.x = 0
				var_110_0.localEulerAngles = var_110_8
			end

			local var_110_9 = arg_107_1.actors_["10069ui_story"]
			local var_110_10 = 0

			if var_110_10 < arg_107_1.time_ and arg_107_1.time_ <= var_110_10 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect10069ui_story == nil then
				arg_107_1.var_.characterEffect10069ui_story = var_110_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_11 = 0.200000002980232

			if var_110_10 <= arg_107_1.time_ and arg_107_1.time_ < var_110_10 + var_110_11 and not isNil(var_110_9) then
				local var_110_12 = (arg_107_1.time_ - var_110_10) / var_110_11

				if arg_107_1.var_.characterEffect10069ui_story and not isNil(var_110_9) then
					arg_107_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= var_110_10 + var_110_11 and arg_107_1.time_ < var_110_10 + var_110_11 + arg_110_0 and not isNil(var_110_9) and arg_107_1.var_.characterEffect10069ui_story then
				arg_107_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_110_13 = 0

			if var_110_13 < arg_107_1.time_ and arg_107_1.time_ <= var_110_13 + arg_110_0 then
				arg_107_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_110_14 = arg_107_1.actors_["1084ui_story"].transform
			local var_110_15 = 0

			if var_110_15 < arg_107_1.time_ and arg_107_1.time_ <= var_110_15 + arg_110_0 then
				arg_107_1.var_.moveOldPos1084ui_story = var_110_14.localPosition
			end

			local var_110_16 = 0.001

			if var_110_15 <= arg_107_1.time_ and arg_107_1.time_ < var_110_15 + var_110_16 then
				local var_110_17 = (arg_107_1.time_ - var_110_15) / var_110_16
				local var_110_18 = Vector3.New(-0.7, -0.97, -6)

				var_110_14.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1084ui_story, var_110_18, var_110_17)

				local var_110_19 = manager.ui.mainCamera.transform.position - var_110_14.position

				var_110_14.forward = Vector3.New(var_110_19.x, var_110_19.y, var_110_19.z)

				local var_110_20 = var_110_14.localEulerAngles

				var_110_20.z = 0
				var_110_20.x = 0
				var_110_14.localEulerAngles = var_110_20
			end

			if arg_107_1.time_ >= var_110_15 + var_110_16 and arg_107_1.time_ < var_110_15 + var_110_16 + arg_110_0 then
				var_110_14.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_110_21 = manager.ui.mainCamera.transform.position - var_110_14.position

				var_110_14.forward = Vector3.New(var_110_21.x, var_110_21.y, var_110_21.z)

				local var_110_22 = var_110_14.localEulerAngles

				var_110_22.z = 0
				var_110_22.x = 0
				var_110_14.localEulerAngles = var_110_22
			end

			local var_110_23 = arg_107_1.actors_["1084ui_story"]
			local var_110_24 = 0

			if var_110_24 < arg_107_1.time_ and arg_107_1.time_ <= var_110_24 + arg_110_0 and not isNil(var_110_23) and arg_107_1.var_.characterEffect1084ui_story == nil then
				arg_107_1.var_.characterEffect1084ui_story = var_110_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_25 = 0.200000002980232

			if var_110_24 <= arg_107_1.time_ and arg_107_1.time_ < var_110_24 + var_110_25 and not isNil(var_110_23) then
				local var_110_26 = (arg_107_1.time_ - var_110_24) / var_110_25

				if arg_107_1.var_.characterEffect1084ui_story and not isNil(var_110_23) then
					local var_110_27 = Mathf.Lerp(0, 0.5, var_110_26)

					arg_107_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1084ui_story.fillRatio = var_110_27
				end
			end

			if arg_107_1.time_ >= var_110_24 + var_110_25 and arg_107_1.time_ < var_110_24 + var_110_25 + arg_110_0 and not isNil(var_110_23) and arg_107_1.var_.characterEffect1084ui_story then
				local var_110_28 = 0.5

				arg_107_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1084ui_story.fillRatio = var_110_28
			end

			local var_110_29 = 0
			local var_110_30 = 0.35

			if var_110_29 < arg_107_1.time_ and arg_107_1.time_ <= var_110_29 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_31 = arg_107_1:FormatText(StoryNameCfg[693].name)

				arg_107_1.leftNameTxt_.text = var_110_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_32 = arg_107_1:GetWordFromCfg(319391024)
				local var_110_33 = arg_107_1:FormatText(var_110_32.content)

				arg_107_1.text_.text = var_110_33

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_34 = 14
				local var_110_35 = utf8.len(var_110_33)
				local var_110_36 = var_110_34 <= 0 and var_110_30 or var_110_30 * (var_110_35 / var_110_34)

				if var_110_36 > 0 and var_110_30 < var_110_36 then
					arg_107_1.talkMaxDuration = var_110_36

					if var_110_36 + var_110_29 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_36 + var_110_29
					end
				end

				arg_107_1.text_.text = var_110_33
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391024", "story_v_out_319391.awb") ~= 0 then
					local var_110_37 = manager.audio:GetVoiceLength("story_v_out_319391", "319391024", "story_v_out_319391.awb") / 1000

					if var_110_37 + var_110_29 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_37 + var_110_29
					end

					if var_110_32.prefab_name ~= "" and arg_107_1.actors_[var_110_32.prefab_name] ~= nil then
						local var_110_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_32.prefab_name].transform, "story_v_out_319391", "319391024", "story_v_out_319391.awb")

						arg_107_1:RecordAudio("319391024", var_110_38)
						arg_107_1:RecordAudio("319391024", var_110_38)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_319391", "319391024", "story_v_out_319391.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_319391", "319391024", "story_v_out_319391.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_39 = math.max(var_110_30, arg_107_1.talkMaxDuration)

			if var_110_29 <= arg_107_1.time_ and arg_107_1.time_ < var_110_29 + var_110_39 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_29) / var_110_39

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_29 + var_110_39 and arg_107_1.time_ < var_110_29 + var_110_39 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play319391025 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319391025
		arg_111_1.duration_ = 2.6

		local var_111_0 = {
			zh = 2.6,
			ja = 2.266
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
				arg_111_0:Play319391026(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10069ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10069ui_story == nil then
				arg_111_1.var_.characterEffect10069ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect10069ui_story and not isNil(var_114_0) then
					local var_114_4 = Mathf.Lerp(0, 0.5, var_114_3)

					arg_111_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10069ui_story.fillRatio = var_114_4
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect10069ui_story then
				local var_114_5 = 0.5

				arg_111_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10069ui_story.fillRatio = var_114_5
			end

			local var_114_6 = arg_111_1.actors_["1084ui_story"]
			local var_114_7 = 0

			if var_114_7 < arg_111_1.time_ and arg_111_1.time_ <= var_114_7 + arg_114_0 and not isNil(var_114_6) and arg_111_1.var_.characterEffect1084ui_story == nil then
				arg_111_1.var_.characterEffect1084ui_story = var_114_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_8 = 0.200000002980232

			if var_114_7 <= arg_111_1.time_ and arg_111_1.time_ < var_114_7 + var_114_8 and not isNil(var_114_6) then
				local var_114_9 = (arg_111_1.time_ - var_114_7) / var_114_8

				if arg_111_1.var_.characterEffect1084ui_story and not isNil(var_114_6) then
					arg_111_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_7 + var_114_8 and arg_111_1.time_ < var_114_7 + var_114_8 + arg_114_0 and not isNil(var_114_6) and arg_111_1.var_.characterEffect1084ui_story then
				arg_111_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				arg_111_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4123")
			end

			local var_114_11 = 0
			local var_114_12 = 0.275

			if var_114_11 < arg_111_1.time_ and arg_111_1.time_ <= var_114_11 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_13 = arg_111_1:FormatText(StoryNameCfg[6].name)

				arg_111_1.leftNameTxt_.text = var_114_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_14 = arg_111_1:GetWordFromCfg(319391025)
				local var_114_15 = arg_111_1:FormatText(var_114_14.content)

				arg_111_1.text_.text = var_114_15

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_16 = 11
				local var_114_17 = utf8.len(var_114_15)
				local var_114_18 = var_114_16 <= 0 and var_114_12 or var_114_12 * (var_114_17 / var_114_16)

				if var_114_18 > 0 and var_114_12 < var_114_18 then
					arg_111_1.talkMaxDuration = var_114_18

					if var_114_18 + var_114_11 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_18 + var_114_11
					end
				end

				arg_111_1.text_.text = var_114_15
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391025", "story_v_out_319391.awb") ~= 0 then
					local var_114_19 = manager.audio:GetVoiceLength("story_v_out_319391", "319391025", "story_v_out_319391.awb") / 1000

					if var_114_19 + var_114_11 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_19 + var_114_11
					end

					if var_114_14.prefab_name ~= "" and arg_111_1.actors_[var_114_14.prefab_name] ~= nil then
						local var_114_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_14.prefab_name].transform, "story_v_out_319391", "319391025", "story_v_out_319391.awb")

						arg_111_1:RecordAudio("319391025", var_114_20)
						arg_111_1:RecordAudio("319391025", var_114_20)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_319391", "319391025", "story_v_out_319391.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_319391", "319391025", "story_v_out_319391.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_21 = math.max(var_114_12, arg_111_1.talkMaxDuration)

			if var_114_11 <= arg_111_1.time_ and arg_111_1.time_ < var_114_11 + var_114_21 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_11) / var_114_21

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_11 + var_114_21 and arg_111_1.time_ < var_114_11 + var_114_21 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play319391026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319391026
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play319391027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1084ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1084ui_story == nil then
				arg_115_1.var_.characterEffect1084ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1084ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1084ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1084ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1084ui_story.fillRatio = var_118_5
			end

			local var_118_6 = 0
			local var_118_7 = 0.875

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_8 = arg_115_1:GetWordFromCfg(319391026)
				local var_118_9 = arg_115_1:FormatText(var_118_8.content)

				arg_115_1.text_.text = var_118_9

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_10 = 35
				local var_118_11 = utf8.len(var_118_9)
				local var_118_12 = var_118_10 <= 0 and var_118_7 or var_118_7 * (var_118_11 / var_118_10)

				if var_118_12 > 0 and var_118_7 < var_118_12 then
					arg_115_1.talkMaxDuration = var_118_12

					if var_118_12 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_12 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_9
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_13 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_13 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_13

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_13 and arg_115_1.time_ < var_118_6 + var_118_13 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play319391027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319391027
		arg_119_1.duration_ = 18

		local var_119_0 = {
			zh = 8,
			ja = 18
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
				arg_119_0:Play319391028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["10069ui_story"].transform
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1.var_.moveOldPos10069ui_story = var_122_0.localPosition
			end

			local var_122_2 = 0.001

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2
				local var_122_4 = Vector3.New(0.7, -1.08, -6.33)

				var_122_0.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10069ui_story, var_122_4, var_122_3)

				local var_122_5 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_5.x, var_122_5.y, var_122_5.z)

				local var_122_6 = var_122_0.localEulerAngles

				var_122_6.z = 0
				var_122_6.x = 0
				var_122_0.localEulerAngles = var_122_6
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 then
				var_122_0.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_122_7 = manager.ui.mainCamera.transform.position - var_122_0.position

				var_122_0.forward = Vector3.New(var_122_7.x, var_122_7.y, var_122_7.z)

				local var_122_8 = var_122_0.localEulerAngles

				var_122_8.z = 0
				var_122_8.x = 0
				var_122_0.localEulerAngles = var_122_8
			end

			local var_122_9 = arg_119_1.actors_["10069ui_story"]
			local var_122_10 = 0

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect10069ui_story == nil then
				arg_119_1.var_.characterEffect10069ui_story = var_122_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_11 = 0.200000002980232

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_11 and not isNil(var_122_9) then
				local var_122_12 = (arg_119_1.time_ - var_122_10) / var_122_11

				if arg_119_1.var_.characterEffect10069ui_story and not isNil(var_122_9) then
					arg_119_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_10 + var_122_11 and arg_119_1.time_ < var_122_10 + var_122_11 + arg_122_0 and not isNil(var_122_9) and arg_119_1.var_.characterEffect10069ui_story then
				arg_119_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_122_13 = 0

			if var_122_13 < arg_119_1.time_ and arg_119_1.time_ <= var_122_13 + arg_122_0 then
				arg_119_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_122_14 = 0
			local var_122_15 = 1.025

			if var_122_14 < arg_119_1.time_ and arg_119_1.time_ <= var_122_14 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_16 = arg_119_1:FormatText(StoryNameCfg[693].name)

				arg_119_1.leftNameTxt_.text = var_122_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_17 = arg_119_1:GetWordFromCfg(319391027)
				local var_122_18 = arg_119_1:FormatText(var_122_17.content)

				arg_119_1.text_.text = var_122_18

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_19 = 41
				local var_122_20 = utf8.len(var_122_18)
				local var_122_21 = var_122_19 <= 0 and var_122_15 or var_122_15 * (var_122_20 / var_122_19)

				if var_122_21 > 0 and var_122_15 < var_122_21 then
					arg_119_1.talkMaxDuration = var_122_21

					if var_122_21 + var_122_14 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_21 + var_122_14
					end
				end

				arg_119_1.text_.text = var_122_18
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391027", "story_v_out_319391.awb") ~= 0 then
					local var_122_22 = manager.audio:GetVoiceLength("story_v_out_319391", "319391027", "story_v_out_319391.awb") / 1000

					if var_122_22 + var_122_14 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_22 + var_122_14
					end

					if var_122_17.prefab_name ~= "" and arg_119_1.actors_[var_122_17.prefab_name] ~= nil then
						local var_122_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_17.prefab_name].transform, "story_v_out_319391", "319391027", "story_v_out_319391.awb")

						arg_119_1:RecordAudio("319391027", var_122_23)
						arg_119_1:RecordAudio("319391027", var_122_23)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319391", "319391027", "story_v_out_319391.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319391", "319391027", "story_v_out_319391.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_24 = math.max(var_122_15, arg_119_1.talkMaxDuration)

			if var_122_14 <= arg_119_1.time_ and arg_119_1.time_ < var_122_14 + var_122_24 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_14) / var_122_24

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_14 + var_122_24 and arg_119_1.time_ < var_122_14 + var_122_24 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
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

		arg_119_1:InitPlayNodeList()
	end,
	Play319391028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319391028
		arg_123_1.duration_ = 7.7

		local var_123_0 = {
			zh = 3.5,
			ja = 7.7
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
				arg_123_0:Play319391029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10069ui_story"]
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10069ui_story == nil then
				arg_123_1.var_.characterEffect10069ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 and not isNil(var_126_0) then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2

				if arg_123_1.var_.characterEffect10069ui_story and not isNil(var_126_0) then
					local var_126_4 = Mathf.Lerp(0, 0.5, var_126_3)

					arg_123_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10069ui_story.fillRatio = var_126_4
				end
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect10069ui_story then
				local var_126_5 = 0.5

				arg_123_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10069ui_story.fillRatio = var_126_5
			end

			local var_126_6 = arg_123_1.actors_["1084ui_story"]
			local var_126_7 = 0

			if var_126_7 < arg_123_1.time_ and arg_123_1.time_ <= var_126_7 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect1084ui_story == nil then
				arg_123_1.var_.characterEffect1084ui_story = var_126_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_8 = 0.200000002980232

			if var_126_7 <= arg_123_1.time_ and arg_123_1.time_ < var_126_7 + var_126_8 and not isNil(var_126_6) then
				local var_126_9 = (arg_123_1.time_ - var_126_7) / var_126_8

				if arg_123_1.var_.characterEffect1084ui_story and not isNil(var_126_6) then
					arg_123_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_7 + var_126_8 and arg_123_1.time_ < var_126_7 + var_126_8 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect1084ui_story then
				arg_123_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 then
				arg_123_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_126_11 = 0
			local var_126_12 = 0.45

			if var_126_11 < arg_123_1.time_ and arg_123_1.time_ <= var_126_11 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_13 = arg_123_1:FormatText(StoryNameCfg[6].name)

				arg_123_1.leftNameTxt_.text = var_126_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_14 = arg_123_1:GetWordFromCfg(319391028)
				local var_126_15 = arg_123_1:FormatText(var_126_14.content)

				arg_123_1.text_.text = var_126_15

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_16 = 18
				local var_126_17 = utf8.len(var_126_15)
				local var_126_18 = var_126_16 <= 0 and var_126_12 or var_126_12 * (var_126_17 / var_126_16)

				if var_126_18 > 0 and var_126_12 < var_126_18 then
					arg_123_1.talkMaxDuration = var_126_18

					if var_126_18 + var_126_11 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_18 + var_126_11
					end
				end

				arg_123_1.text_.text = var_126_15
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391028", "story_v_out_319391.awb") ~= 0 then
					local var_126_19 = manager.audio:GetVoiceLength("story_v_out_319391", "319391028", "story_v_out_319391.awb") / 1000

					if var_126_19 + var_126_11 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_19 + var_126_11
					end

					if var_126_14.prefab_name ~= "" and arg_123_1.actors_[var_126_14.prefab_name] ~= nil then
						local var_126_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_14.prefab_name].transform, "story_v_out_319391", "319391028", "story_v_out_319391.awb")

						arg_123_1:RecordAudio("319391028", var_126_20)
						arg_123_1:RecordAudio("319391028", var_126_20)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319391", "319391028", "story_v_out_319391.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319391", "319391028", "story_v_out_319391.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_21 = math.max(var_126_12, arg_123_1.talkMaxDuration)

			if var_126_11 <= arg_123_1.time_ and arg_123_1.time_ < var_126_11 + var_126_21 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_11) / var_126_21

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_11 + var_126_21 and arg_123_1.time_ < var_126_11 + var_126_21 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play319391029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319391029
		arg_127_1.duration_ = 16.27

		local var_127_0 = {
			zh = 6.866,
			ja = 16.266
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
				arg_127_0:Play319391030(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10069ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10069ui_story == nil then
				arg_127_1.var_.characterEffect10069ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect10069ui_story and not isNil(var_130_0) then
					arg_127_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect10069ui_story then
				arg_127_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_130_4 = arg_127_1.actors_["1084ui_story"]
			local var_130_5 = 0

			if var_130_5 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect1084ui_story == nil then
				arg_127_1.var_.characterEffect1084ui_story = var_130_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_6 = 0.200000002980232

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_6 and not isNil(var_130_4) then
				local var_130_7 = (arg_127_1.time_ - var_130_5) / var_130_6

				if arg_127_1.var_.characterEffect1084ui_story and not isNil(var_130_4) then
					local var_130_8 = Mathf.Lerp(0, 0.5, var_130_7)

					arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1084ui_story.fillRatio = var_130_8
				end
			end

			if arg_127_1.time_ >= var_130_5 + var_130_6 and arg_127_1.time_ < var_130_5 + var_130_6 + arg_130_0 and not isNil(var_130_4) and arg_127_1.var_.characterEffect1084ui_story then
				local var_130_9 = 0.5

				arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1084ui_story.fillRatio = var_130_9
			end

			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 then
				arg_127_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_130_11 = 0

			if var_130_11 < arg_127_1.time_ and arg_127_1.time_ <= var_130_11 + arg_130_0 then
				arg_127_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_130_12 = 0
			local var_130_13 = 0.625

			if var_130_12 < arg_127_1.time_ and arg_127_1.time_ <= var_130_12 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_14 = arg_127_1:FormatText(StoryNameCfg[693].name)

				arg_127_1.leftNameTxt_.text = var_130_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_15 = arg_127_1:GetWordFromCfg(319391029)
				local var_130_16 = arg_127_1:FormatText(var_130_15.content)

				arg_127_1.text_.text = var_130_16

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_17 = 25
				local var_130_18 = utf8.len(var_130_16)
				local var_130_19 = var_130_17 <= 0 and var_130_13 or var_130_13 * (var_130_18 / var_130_17)

				if var_130_19 > 0 and var_130_13 < var_130_19 then
					arg_127_1.talkMaxDuration = var_130_19

					if var_130_19 + var_130_12 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_19 + var_130_12
					end
				end

				arg_127_1.text_.text = var_130_16
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391029", "story_v_out_319391.awb") ~= 0 then
					local var_130_20 = manager.audio:GetVoiceLength("story_v_out_319391", "319391029", "story_v_out_319391.awb") / 1000

					if var_130_20 + var_130_12 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_20 + var_130_12
					end

					if var_130_15.prefab_name ~= "" and arg_127_1.actors_[var_130_15.prefab_name] ~= nil then
						local var_130_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_15.prefab_name].transform, "story_v_out_319391", "319391029", "story_v_out_319391.awb")

						arg_127_1:RecordAudio("319391029", var_130_21)
						arg_127_1:RecordAudio("319391029", var_130_21)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319391", "319391029", "story_v_out_319391.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319391", "319391029", "story_v_out_319391.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_22 = math.max(var_130_13, arg_127_1.talkMaxDuration)

			if var_130_12 <= arg_127_1.time_ and arg_127_1.time_ < var_130_12 + var_130_22 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_12) / var_130_22

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_12 + var_130_22 and arg_127_1.time_ < var_130_12 + var_130_22 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play319391030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319391030
		arg_131_1.duration_ = 7.6

		local var_131_0 = {
			zh = 5.466,
			ja = 7.6
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
				arg_131_0:Play319391031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1084ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1084ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(-0.7, -0.97, -6)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1084ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["1084ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1084ui_story == nil then
				arg_131_1.var_.characterEffect1084ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect1084ui_story and not isNil(var_134_9) then
					arg_131_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect1084ui_story then
				arg_131_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_134_13 = arg_131_1.actors_["10069ui_story"]
			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 and not isNil(var_134_13) and arg_131_1.var_.characterEffect10069ui_story == nil then
				arg_131_1.var_.characterEffect10069ui_story = var_134_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_15 = 0.200000002980232

			if var_134_14 <= arg_131_1.time_ and arg_131_1.time_ < var_134_14 + var_134_15 and not isNil(var_134_13) then
				local var_134_16 = (arg_131_1.time_ - var_134_14) / var_134_15

				if arg_131_1.var_.characterEffect10069ui_story and not isNil(var_134_13) then
					local var_134_17 = Mathf.Lerp(0, 0.5, var_134_16)

					arg_131_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10069ui_story.fillRatio = var_134_17
				end
			end

			if arg_131_1.time_ >= var_134_14 + var_134_15 and arg_131_1.time_ < var_134_14 + var_134_15 + arg_134_0 and not isNil(var_134_13) and arg_131_1.var_.characterEffect10069ui_story then
				local var_134_18 = 0.5

				arg_131_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10069ui_story.fillRatio = var_134_18
			end

			local var_134_19 = 0
			local var_134_20 = 0.625

			if var_134_19 < arg_131_1.time_ and arg_131_1.time_ <= var_134_19 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_21 = arg_131_1:FormatText(StoryNameCfg[6].name)

				arg_131_1.leftNameTxt_.text = var_134_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_22 = arg_131_1:GetWordFromCfg(319391030)
				local var_134_23 = arg_131_1:FormatText(var_134_22.content)

				arg_131_1.text_.text = var_134_23

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_24 = 25
				local var_134_25 = utf8.len(var_134_23)
				local var_134_26 = var_134_24 <= 0 and var_134_20 or var_134_20 * (var_134_25 / var_134_24)

				if var_134_26 > 0 and var_134_20 < var_134_26 then
					arg_131_1.talkMaxDuration = var_134_26

					if var_134_26 + var_134_19 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_26 + var_134_19
					end
				end

				arg_131_1.text_.text = var_134_23
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391030", "story_v_out_319391.awb") ~= 0 then
					local var_134_27 = manager.audio:GetVoiceLength("story_v_out_319391", "319391030", "story_v_out_319391.awb") / 1000

					if var_134_27 + var_134_19 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_27 + var_134_19
					end

					if var_134_22.prefab_name ~= "" and arg_131_1.actors_[var_134_22.prefab_name] ~= nil then
						local var_134_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_22.prefab_name].transform, "story_v_out_319391", "319391030", "story_v_out_319391.awb")

						arg_131_1:RecordAudio("319391030", var_134_28)
						arg_131_1:RecordAudio("319391030", var_134_28)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319391", "319391030", "story_v_out_319391.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319391", "319391030", "story_v_out_319391.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_29 = math.max(var_134_20, arg_131_1.talkMaxDuration)

			if var_134_19 <= arg_131_1.time_ and arg_131_1.time_ < var_134_19 + var_134_29 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_19) / var_134_29

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_19 + var_134_29 and arg_131_1.time_ < var_134_19 + var_134_29 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play319391031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319391031
		arg_135_1.duration_ = 7.73

		local var_135_0 = {
			zh = 7.366,
			ja = 7.733
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
				arg_135_0:Play319391032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1084ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1084ui_story == nil then
				arg_135_1.var_.characterEffect1084ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1084ui_story and not isNil(var_138_0) then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_135_1.var_.characterEffect1084ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1084ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_135_1.var_.characterEffect1084ui_story.fillRatio = var_138_5
			end

			local var_138_6 = arg_135_1.actors_["10069ui_story"]
			local var_138_7 = 0

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect10069ui_story == nil then
				arg_135_1.var_.characterEffect10069ui_story = var_138_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_8 = 0.200000002980232

			if var_138_7 <= arg_135_1.time_ and arg_135_1.time_ < var_138_7 + var_138_8 and not isNil(var_138_6) then
				local var_138_9 = (arg_135_1.time_ - var_138_7) / var_138_8

				if arg_135_1.var_.characterEffect10069ui_story and not isNil(var_138_6) then
					arg_135_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_7 + var_138_8 and arg_135_1.time_ < var_138_7 + var_138_8 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect10069ui_story then
				arg_135_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_138_11 = 0
			local var_138_12 = 0.725

			if var_138_11 < arg_135_1.time_ and arg_135_1.time_ <= var_138_11 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_13 = arg_135_1:FormatText(StoryNameCfg[693].name)

				arg_135_1.leftNameTxt_.text = var_138_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_14 = arg_135_1:GetWordFromCfg(319391031)
				local var_138_15 = arg_135_1:FormatText(var_138_14.content)

				arg_135_1.text_.text = var_138_15

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_16 = 29
				local var_138_17 = utf8.len(var_138_15)
				local var_138_18 = var_138_16 <= 0 and var_138_12 or var_138_12 * (var_138_17 / var_138_16)

				if var_138_18 > 0 and var_138_12 < var_138_18 then
					arg_135_1.talkMaxDuration = var_138_18

					if var_138_18 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_18 + var_138_11
					end
				end

				arg_135_1.text_.text = var_138_15
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391031", "story_v_out_319391.awb") ~= 0 then
					local var_138_19 = manager.audio:GetVoiceLength("story_v_out_319391", "319391031", "story_v_out_319391.awb") / 1000

					if var_138_19 + var_138_11 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_19 + var_138_11
					end

					if var_138_14.prefab_name ~= "" and arg_135_1.actors_[var_138_14.prefab_name] ~= nil then
						local var_138_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_14.prefab_name].transform, "story_v_out_319391", "319391031", "story_v_out_319391.awb")

						arg_135_1:RecordAudio("319391031", var_138_20)
						arg_135_1:RecordAudio("319391031", var_138_20)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319391", "319391031", "story_v_out_319391.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319391", "319391031", "story_v_out_319391.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_21 = math.max(var_138_12, arg_135_1.talkMaxDuration)

			if var_138_11 <= arg_135_1.time_ and arg_135_1.time_ < var_138_11 + var_138_21 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_11) / var_138_21

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_11 + var_138_21 and arg_135_1.time_ < var_138_11 + var_138_21 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play319391032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319391032
		arg_139_1.duration_ = 6.1

		local var_139_0 = {
			zh = 5.466,
			ja = 6.1
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
				arg_139_0:Play319391033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10069ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10069ui_story == nil then
				arg_139_1.var_.characterEffect10069ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect10069ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10069ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect10069ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10069ui_story.fillRatio = var_142_5
			end

			local var_142_6 = arg_139_1.actors_["1084ui_story"]
			local var_142_7 = 0

			if var_142_7 < arg_139_1.time_ and arg_139_1.time_ <= var_142_7 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1084ui_story == nil then
				arg_139_1.var_.characterEffect1084ui_story = var_142_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_8 = 0.200000002980232

			if var_142_7 <= arg_139_1.time_ and arg_139_1.time_ < var_142_7 + var_142_8 and not isNil(var_142_6) then
				local var_142_9 = (arg_139_1.time_ - var_142_7) / var_142_8

				if arg_139_1.var_.characterEffect1084ui_story and not isNil(var_142_6) then
					arg_139_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_7 + var_142_8 and arg_139_1.time_ < var_142_7 + var_142_8 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1084ui_story then
				arg_139_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 then
				arg_139_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_142_11 = 0
			local var_142_12 = 0.6

			if var_142_11 < arg_139_1.time_ and arg_139_1.time_ <= var_142_11 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_13 = arg_139_1:FormatText(StoryNameCfg[6].name)

				arg_139_1.leftNameTxt_.text = var_142_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_14 = arg_139_1:GetWordFromCfg(319391032)
				local var_142_15 = arg_139_1:FormatText(var_142_14.content)

				arg_139_1.text_.text = var_142_15

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_16 = 24
				local var_142_17 = utf8.len(var_142_15)
				local var_142_18 = var_142_16 <= 0 and var_142_12 or var_142_12 * (var_142_17 / var_142_16)

				if var_142_18 > 0 and var_142_12 < var_142_18 then
					arg_139_1.talkMaxDuration = var_142_18

					if var_142_18 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_18 + var_142_11
					end
				end

				arg_139_1.text_.text = var_142_15
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391032", "story_v_out_319391.awb") ~= 0 then
					local var_142_19 = manager.audio:GetVoiceLength("story_v_out_319391", "319391032", "story_v_out_319391.awb") / 1000

					if var_142_19 + var_142_11 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_19 + var_142_11
					end

					if var_142_14.prefab_name ~= "" and arg_139_1.actors_[var_142_14.prefab_name] ~= nil then
						local var_142_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_14.prefab_name].transform, "story_v_out_319391", "319391032", "story_v_out_319391.awb")

						arg_139_1:RecordAudio("319391032", var_142_20)
						arg_139_1:RecordAudio("319391032", var_142_20)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319391", "319391032", "story_v_out_319391.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319391", "319391032", "story_v_out_319391.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_21 = math.max(var_142_12, arg_139_1.talkMaxDuration)

			if var_142_11 <= arg_139_1.time_ and arg_139_1.time_ < var_142_11 + var_142_21 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_11) / var_142_21

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_11 + var_142_21 and arg_139_1.time_ < var_142_11 + var_142_21 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play319391033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319391033
		arg_143_1.duration_ = 2.93

		local var_143_0 = {
			zh = 2.933,
			ja = 1.999999999999
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
				arg_143_0:Play319391034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["10066ui_story"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos10066ui_story = var_146_0.localPosition
			end

			local var_146_2 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2
				local var_146_4 = Vector3.New(0, -0.99, -5.83)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10066ui_story, var_146_4, var_146_3)

				local var_146_5 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_5.x, var_146_5.y, var_146_5.z)

				local var_146_6 = var_146_0.localEulerAngles

				var_146_6.z = 0
				var_146_6.x = 0
				var_146_0.localEulerAngles = var_146_6
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_146_7 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_7.x, var_146_7.y, var_146_7.z)

				local var_146_8 = var_146_0.localEulerAngles

				var_146_8.z = 0
				var_146_8.x = 0
				var_146_0.localEulerAngles = var_146_8
			end

			local var_146_9 = arg_143_1.actors_["10066ui_story"]
			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 and not isNil(var_146_9) and arg_143_1.var_.characterEffect10066ui_story == nil then
				arg_143_1.var_.characterEffect10066ui_story = var_146_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_11 = 0.200000002980232

			if var_146_10 <= arg_143_1.time_ and arg_143_1.time_ < var_146_10 + var_146_11 and not isNil(var_146_9) then
				local var_146_12 = (arg_143_1.time_ - var_146_10) / var_146_11

				if arg_143_1.var_.characterEffect10066ui_story and not isNil(var_146_9) then
					arg_143_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_10 + var_146_11 and arg_143_1.time_ < var_146_10 + var_146_11 + arg_146_0 and not isNil(var_146_9) and arg_143_1.var_.characterEffect10066ui_story then
				arg_143_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_146_13 = 0

			if var_146_13 < arg_143_1.time_ and arg_143_1.time_ <= var_146_13 + arg_146_0 then
				arg_143_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_1")
			end

			local var_146_14 = 0

			if var_146_14 < arg_143_1.time_ and arg_143_1.time_ <= var_146_14 + arg_146_0 then
				arg_143_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_146_15 = arg_143_1.actors_["1084ui_story"].transform
			local var_146_16 = 0

			if var_146_16 < arg_143_1.time_ and arg_143_1.time_ <= var_146_16 + arg_146_0 then
				arg_143_1.var_.moveOldPos1084ui_story = var_146_15.localPosition
			end

			local var_146_17 = 0.001

			if var_146_16 <= arg_143_1.time_ and arg_143_1.time_ < var_146_16 + var_146_17 then
				local var_146_18 = (arg_143_1.time_ - var_146_16) / var_146_17
				local var_146_19 = Vector3.New(0, 100, 0)

				var_146_15.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1084ui_story, var_146_19, var_146_18)

				local var_146_20 = manager.ui.mainCamera.transform.position - var_146_15.position

				var_146_15.forward = Vector3.New(var_146_20.x, var_146_20.y, var_146_20.z)

				local var_146_21 = var_146_15.localEulerAngles

				var_146_21.z = 0
				var_146_21.x = 0
				var_146_15.localEulerAngles = var_146_21
			end

			if arg_143_1.time_ >= var_146_16 + var_146_17 and arg_143_1.time_ < var_146_16 + var_146_17 + arg_146_0 then
				var_146_15.localPosition = Vector3.New(0, 100, 0)

				local var_146_22 = manager.ui.mainCamera.transform.position - var_146_15.position

				var_146_15.forward = Vector3.New(var_146_22.x, var_146_22.y, var_146_22.z)

				local var_146_23 = var_146_15.localEulerAngles

				var_146_23.z = 0
				var_146_23.x = 0
				var_146_15.localEulerAngles = var_146_23
			end

			local var_146_24 = arg_143_1.actors_["1084ui_story"]
			local var_146_25 = 0

			if var_146_25 < arg_143_1.time_ and arg_143_1.time_ <= var_146_25 + arg_146_0 and not isNil(var_146_24) and arg_143_1.var_.characterEffect1084ui_story == nil then
				arg_143_1.var_.characterEffect1084ui_story = var_146_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_26 = 0.200000002980232

			if var_146_25 <= arg_143_1.time_ and arg_143_1.time_ < var_146_25 + var_146_26 and not isNil(var_146_24) then
				local var_146_27 = (arg_143_1.time_ - var_146_25) / var_146_26

				if arg_143_1.var_.characterEffect1084ui_story and not isNil(var_146_24) then
					local var_146_28 = Mathf.Lerp(0, 0.5, var_146_27)

					arg_143_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1084ui_story.fillRatio = var_146_28
				end
			end

			if arg_143_1.time_ >= var_146_25 + var_146_26 and arg_143_1.time_ < var_146_25 + var_146_26 + arg_146_0 and not isNil(var_146_24) and arg_143_1.var_.characterEffect1084ui_story then
				local var_146_29 = 0.5

				arg_143_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1084ui_story.fillRatio = var_146_29
			end

			local var_146_30 = arg_143_1.actors_["10069ui_story"].transform
			local var_146_31 = 0

			if var_146_31 < arg_143_1.time_ and arg_143_1.time_ <= var_146_31 + arg_146_0 then
				arg_143_1.var_.moveOldPos10069ui_story = var_146_30.localPosition
			end

			local var_146_32 = 0.001

			if var_146_31 <= arg_143_1.time_ and arg_143_1.time_ < var_146_31 + var_146_32 then
				local var_146_33 = (arg_143_1.time_ - var_146_31) / var_146_32
				local var_146_34 = Vector3.New(0, 100, 0)

				var_146_30.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10069ui_story, var_146_34, var_146_33)

				local var_146_35 = manager.ui.mainCamera.transform.position - var_146_30.position

				var_146_30.forward = Vector3.New(var_146_35.x, var_146_35.y, var_146_35.z)

				local var_146_36 = var_146_30.localEulerAngles

				var_146_36.z = 0
				var_146_36.x = 0
				var_146_30.localEulerAngles = var_146_36
			end

			if arg_143_1.time_ >= var_146_31 + var_146_32 and arg_143_1.time_ < var_146_31 + var_146_32 + arg_146_0 then
				var_146_30.localPosition = Vector3.New(0, 100, 0)

				local var_146_37 = manager.ui.mainCamera.transform.position - var_146_30.position

				var_146_30.forward = Vector3.New(var_146_37.x, var_146_37.y, var_146_37.z)

				local var_146_38 = var_146_30.localEulerAngles

				var_146_38.z = 0
				var_146_38.x = 0
				var_146_30.localEulerAngles = var_146_38
			end

			local var_146_39 = arg_143_1.actors_["10069ui_story"]
			local var_146_40 = 0

			if var_146_40 < arg_143_1.time_ and arg_143_1.time_ <= var_146_40 + arg_146_0 and not isNil(var_146_39) and arg_143_1.var_.characterEffect10069ui_story == nil then
				arg_143_1.var_.characterEffect10069ui_story = var_146_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_41 = 0.200000002980232

			if var_146_40 <= arg_143_1.time_ and arg_143_1.time_ < var_146_40 + var_146_41 and not isNil(var_146_39) then
				local var_146_42 = (arg_143_1.time_ - var_146_40) / var_146_41

				if arg_143_1.var_.characterEffect10069ui_story and not isNil(var_146_39) then
					local var_146_43 = Mathf.Lerp(0, 0.5, var_146_42)

					arg_143_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10069ui_story.fillRatio = var_146_43
				end
			end

			if arg_143_1.time_ >= var_146_40 + var_146_41 and arg_143_1.time_ < var_146_40 + var_146_41 + arg_146_0 and not isNil(var_146_39) and arg_143_1.var_.characterEffect10069ui_story then
				local var_146_44 = 0.5

				arg_143_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10069ui_story.fillRatio = var_146_44
			end

			local var_146_45 = 0
			local var_146_46 = 0.275

			if var_146_45 < arg_143_1.time_ and arg_143_1.time_ <= var_146_45 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_47 = arg_143_1:FormatText(StoryNameCfg[640].name)

				arg_143_1.leftNameTxt_.text = var_146_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_48 = arg_143_1:GetWordFromCfg(319391033)
				local var_146_49 = arg_143_1:FormatText(var_146_48.content)

				arg_143_1.text_.text = var_146_49

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_50 = 11
				local var_146_51 = utf8.len(var_146_49)
				local var_146_52 = var_146_50 <= 0 and var_146_46 or var_146_46 * (var_146_51 / var_146_50)

				if var_146_52 > 0 and var_146_46 < var_146_52 then
					arg_143_1.talkMaxDuration = var_146_52

					if var_146_52 + var_146_45 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_52 + var_146_45
					end
				end

				arg_143_1.text_.text = var_146_49
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391033", "story_v_out_319391.awb") ~= 0 then
					local var_146_53 = manager.audio:GetVoiceLength("story_v_out_319391", "319391033", "story_v_out_319391.awb") / 1000

					if var_146_53 + var_146_45 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_53 + var_146_45
					end

					if var_146_48.prefab_name ~= "" and arg_143_1.actors_[var_146_48.prefab_name] ~= nil then
						local var_146_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_48.prefab_name].transform, "story_v_out_319391", "319391033", "story_v_out_319391.awb")

						arg_143_1:RecordAudio("319391033", var_146_54)
						arg_143_1:RecordAudio("319391033", var_146_54)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319391", "319391033", "story_v_out_319391.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319391", "319391033", "story_v_out_319391.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_55 = math.max(var_146_46, arg_143_1.talkMaxDuration)

			if var_146_45 <= arg_143_1.time_ and arg_143_1.time_ < var_146_45 + var_146_55 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_45) / var_146_55

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_45 + var_146_55 and arg_143_1.time_ < var_146_45 + var_146_55 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play319391034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319391034
		arg_147_1.duration_ = 5.27

		local var_147_0 = {
			zh = 1.999999999999,
			ja = 5.266
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
				arg_147_0:Play319391035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10069ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos10069ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0.7, -1.08, -6.33)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10069ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["10069ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect10069ui_story == nil then
				arg_147_1.var_.characterEffect10069ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 and not isNil(var_150_9) then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect10069ui_story and not isNil(var_150_9) then
					arg_147_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and not isNil(var_150_9) and arg_147_1.var_.characterEffect10069ui_story then
				arg_147_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action4_1")
			end

			local var_150_14 = 0

			if var_150_14 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_15 = arg_147_1.actors_["10066ui_story"].transform
			local var_150_16 = 0

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 then
				arg_147_1.var_.moveOldPos10066ui_story = var_150_15.localPosition
			end

			local var_150_17 = 0.001

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_17 then
				local var_150_18 = (arg_147_1.time_ - var_150_16) / var_150_17
				local var_150_19 = Vector3.New(-0.7, -0.99, -5.83)

				var_150_15.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10066ui_story, var_150_19, var_150_18)

				local var_150_20 = manager.ui.mainCamera.transform.position - var_150_15.position

				var_150_15.forward = Vector3.New(var_150_20.x, var_150_20.y, var_150_20.z)

				local var_150_21 = var_150_15.localEulerAngles

				var_150_21.z = 0
				var_150_21.x = 0
				var_150_15.localEulerAngles = var_150_21
			end

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 then
				var_150_15.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_150_22 = manager.ui.mainCamera.transform.position - var_150_15.position

				var_150_15.forward = Vector3.New(var_150_22.x, var_150_22.y, var_150_22.z)

				local var_150_23 = var_150_15.localEulerAngles

				var_150_23.z = 0
				var_150_23.x = 0
				var_150_15.localEulerAngles = var_150_23
			end

			local var_150_24 = arg_147_1.actors_["10066ui_story"]
			local var_150_25 = 0

			if var_150_25 < arg_147_1.time_ and arg_147_1.time_ <= var_150_25 + arg_150_0 and not isNil(var_150_24) and arg_147_1.var_.characterEffect10066ui_story == nil then
				arg_147_1.var_.characterEffect10066ui_story = var_150_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_26 = 0.200000002980232

			if var_150_25 <= arg_147_1.time_ and arg_147_1.time_ < var_150_25 + var_150_26 and not isNil(var_150_24) then
				local var_150_27 = (arg_147_1.time_ - var_150_25) / var_150_26

				if arg_147_1.var_.characterEffect10066ui_story and not isNil(var_150_24) then
					local var_150_28 = Mathf.Lerp(0, 0.5, var_150_27)

					arg_147_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10066ui_story.fillRatio = var_150_28
				end
			end

			if arg_147_1.time_ >= var_150_25 + var_150_26 and arg_147_1.time_ < var_150_25 + var_150_26 + arg_150_0 and not isNil(var_150_24) and arg_147_1.var_.characterEffect10066ui_story then
				local var_150_29 = 0.5

				arg_147_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10066ui_story.fillRatio = var_150_29
			end

			local var_150_30 = 0
			local var_150_31 = 0.1

			if var_150_30 < arg_147_1.time_ and arg_147_1.time_ <= var_150_30 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_32 = arg_147_1:FormatText(StoryNameCfg[693].name)

				arg_147_1.leftNameTxt_.text = var_150_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_33 = arg_147_1:GetWordFromCfg(319391034)
				local var_150_34 = arg_147_1:FormatText(var_150_33.content)

				arg_147_1.text_.text = var_150_34

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_35 = 4
				local var_150_36 = utf8.len(var_150_34)
				local var_150_37 = var_150_35 <= 0 and var_150_31 or var_150_31 * (var_150_36 / var_150_35)

				if var_150_37 > 0 and var_150_31 < var_150_37 then
					arg_147_1.talkMaxDuration = var_150_37

					if var_150_37 + var_150_30 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_37 + var_150_30
					end
				end

				arg_147_1.text_.text = var_150_34
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391034", "story_v_out_319391.awb") ~= 0 then
					local var_150_38 = manager.audio:GetVoiceLength("story_v_out_319391", "319391034", "story_v_out_319391.awb") / 1000

					if var_150_38 + var_150_30 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_38 + var_150_30
					end

					if var_150_33.prefab_name ~= "" and arg_147_1.actors_[var_150_33.prefab_name] ~= nil then
						local var_150_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_33.prefab_name].transform, "story_v_out_319391", "319391034", "story_v_out_319391.awb")

						arg_147_1:RecordAudio("319391034", var_150_39)
						arg_147_1:RecordAudio("319391034", var_150_39)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_319391", "319391034", "story_v_out_319391.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_319391", "319391034", "story_v_out_319391.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_40 = math.max(var_150_31, arg_147_1.talkMaxDuration)

			if var_150_30 <= arg_147_1.time_ and arg_147_1.time_ < var_150_30 + var_150_40 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_30) / var_150_40

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_30 + var_150_40 and arg_147_1.time_ < var_150_30 + var_150_40 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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
				actorName = "10066ui_story",
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
	Play319391035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319391035
		arg_151_1.duration_ = 8.63

		local var_151_0 = {
			zh = 8.4,
			ja = 8.633
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
				arg_151_0:Play319391036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10066ui_story"].transform
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.var_.moveOldPos10066ui_story = var_154_0.localPosition
			end

			local var_154_2 = 0.001

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2
				local var_154_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_154_0.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10066ui_story, var_154_4, var_154_3)

				local var_154_5 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_5.x, var_154_5.y, var_154_5.z)

				local var_154_6 = var_154_0.localEulerAngles

				var_154_6.z = 0
				var_154_6.x = 0
				var_154_0.localEulerAngles = var_154_6
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 then
				var_154_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_154_7 = manager.ui.mainCamera.transform.position - var_154_0.position

				var_154_0.forward = Vector3.New(var_154_7.x, var_154_7.y, var_154_7.z)

				local var_154_8 = var_154_0.localEulerAngles

				var_154_8.z = 0
				var_154_8.x = 0
				var_154_0.localEulerAngles = var_154_8
			end

			local var_154_9 = arg_151_1.actors_["10066ui_story"]
			local var_154_10 = 0

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect10066ui_story == nil then
				arg_151_1.var_.characterEffect10066ui_story = var_154_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_11 = 0.200000002980232

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_11 and not isNil(var_154_9) then
				local var_154_12 = (arg_151_1.time_ - var_154_10) / var_154_11

				if arg_151_1.var_.characterEffect10066ui_story and not isNil(var_154_9) then
					arg_151_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_10 + var_154_11 and arg_151_1.time_ < var_154_10 + var_154_11 + arg_154_0 and not isNil(var_154_9) and arg_151_1.var_.characterEffect10066ui_story then
				arg_151_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_154_13 = 0

			if var_154_13 < arg_151_1.time_ and arg_151_1.time_ <= var_154_13 + arg_154_0 then
				arg_151_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_2")
			end

			local var_154_14 = 0

			if var_154_14 < arg_151_1.time_ and arg_151_1.time_ <= var_154_14 + arg_154_0 then
				arg_151_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_154_15 = arg_151_1.actors_["10069ui_story"]
			local var_154_16 = 0

			if var_154_16 < arg_151_1.time_ and arg_151_1.time_ <= var_154_16 + arg_154_0 and not isNil(var_154_15) and arg_151_1.var_.characterEffect10069ui_story == nil then
				arg_151_1.var_.characterEffect10069ui_story = var_154_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_17 = 0.200000002980232

			if var_154_16 <= arg_151_1.time_ and arg_151_1.time_ < var_154_16 + var_154_17 and not isNil(var_154_15) then
				local var_154_18 = (arg_151_1.time_ - var_154_16) / var_154_17

				if arg_151_1.var_.characterEffect10069ui_story and not isNil(var_154_15) then
					local var_154_19 = Mathf.Lerp(0, 0.5, var_154_18)

					arg_151_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10069ui_story.fillRatio = var_154_19
				end
			end

			if arg_151_1.time_ >= var_154_16 + var_154_17 and arg_151_1.time_ < var_154_16 + var_154_17 + arg_154_0 and not isNil(var_154_15) and arg_151_1.var_.characterEffect10069ui_story then
				local var_154_20 = 0.5

				arg_151_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10069ui_story.fillRatio = var_154_20
			end

			local var_154_21 = 0
			local var_154_22 = 0.625

			if var_154_21 < arg_151_1.time_ and arg_151_1.time_ <= var_154_21 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_23 = arg_151_1:FormatText(StoryNameCfg[640].name)

				arg_151_1.leftNameTxt_.text = var_154_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_24 = arg_151_1:GetWordFromCfg(319391035)
				local var_154_25 = arg_151_1:FormatText(var_154_24.content)

				arg_151_1.text_.text = var_154_25

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_26 = 25
				local var_154_27 = utf8.len(var_154_25)
				local var_154_28 = var_154_26 <= 0 and var_154_22 or var_154_22 * (var_154_27 / var_154_26)

				if var_154_28 > 0 and var_154_22 < var_154_28 then
					arg_151_1.talkMaxDuration = var_154_28

					if var_154_28 + var_154_21 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_28 + var_154_21
					end
				end

				arg_151_1.text_.text = var_154_25
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391035", "story_v_out_319391.awb") ~= 0 then
					local var_154_29 = manager.audio:GetVoiceLength("story_v_out_319391", "319391035", "story_v_out_319391.awb") / 1000

					if var_154_29 + var_154_21 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_29 + var_154_21
					end

					if var_154_24.prefab_name ~= "" and arg_151_1.actors_[var_154_24.prefab_name] ~= nil then
						local var_154_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_24.prefab_name].transform, "story_v_out_319391", "319391035", "story_v_out_319391.awb")

						arg_151_1:RecordAudio("319391035", var_154_30)
						arg_151_1:RecordAudio("319391035", var_154_30)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319391", "319391035", "story_v_out_319391.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319391", "319391035", "story_v_out_319391.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_31 = math.max(var_154_22, arg_151_1.talkMaxDuration)

			if var_154_21 <= arg_151_1.time_ and arg_151_1.time_ < var_154_21 + var_154_31 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_21) / var_154_31

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_21 + var_154_31 and arg_151_1.time_ < var_154_21 + var_154_31 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play319391036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319391036
		arg_155_1.duration_ = 8.93

		local var_155_0 = {
			zh = 4.4,
			ja = 8.933
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
				arg_155_0:Play319391037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10066ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10066ui_story == nil then
				arg_155_1.var_.characterEffect10066ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect10066ui_story and not isNil(var_158_0) then
					local var_158_4 = Mathf.Lerp(0, 0.5, var_158_3)

					arg_155_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10066ui_story.fillRatio = var_158_4
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect10066ui_story then
				local var_158_5 = 0.5

				arg_155_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10066ui_story.fillRatio = var_158_5
			end

			local var_158_6 = arg_155_1.actors_["10069ui_story"]
			local var_158_7 = 0

			if var_158_7 < arg_155_1.time_ and arg_155_1.time_ <= var_158_7 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect10069ui_story == nil then
				arg_155_1.var_.characterEffect10069ui_story = var_158_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_8 = 0.200000002980232

			if var_158_7 <= arg_155_1.time_ and arg_155_1.time_ < var_158_7 + var_158_8 and not isNil(var_158_6) then
				local var_158_9 = (arg_155_1.time_ - var_158_7) / var_158_8

				if arg_155_1.var_.characterEffect10069ui_story and not isNil(var_158_6) then
					arg_155_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_7 + var_158_8 and arg_155_1.time_ < var_158_7 + var_158_8 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect10069ui_story then
				arg_155_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_158_10 = 0

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 then
				arg_155_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action4_2")
			end

			local var_158_11 = 0

			if var_158_11 < arg_155_1.time_ and arg_155_1.time_ <= var_158_11 + arg_158_0 then
				arg_155_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_158_12 = 0
			local var_158_13 = 0.425

			if var_158_12 < arg_155_1.time_ and arg_155_1.time_ <= var_158_12 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_14 = arg_155_1:FormatText(StoryNameCfg[693].name)

				arg_155_1.leftNameTxt_.text = var_158_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_15 = arg_155_1:GetWordFromCfg(319391036)
				local var_158_16 = arg_155_1:FormatText(var_158_15.content)

				arg_155_1.text_.text = var_158_16

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_17 = 17
				local var_158_18 = utf8.len(var_158_16)
				local var_158_19 = var_158_17 <= 0 and var_158_13 or var_158_13 * (var_158_18 / var_158_17)

				if var_158_19 > 0 and var_158_13 < var_158_19 then
					arg_155_1.talkMaxDuration = var_158_19

					if var_158_19 + var_158_12 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_19 + var_158_12
					end
				end

				arg_155_1.text_.text = var_158_16
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391036", "story_v_out_319391.awb") ~= 0 then
					local var_158_20 = manager.audio:GetVoiceLength("story_v_out_319391", "319391036", "story_v_out_319391.awb") / 1000

					if var_158_20 + var_158_12 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_20 + var_158_12
					end

					if var_158_15.prefab_name ~= "" and arg_155_1.actors_[var_158_15.prefab_name] ~= nil then
						local var_158_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_15.prefab_name].transform, "story_v_out_319391", "319391036", "story_v_out_319391.awb")

						arg_155_1:RecordAudio("319391036", var_158_21)
						arg_155_1:RecordAudio("319391036", var_158_21)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319391", "319391036", "story_v_out_319391.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319391", "319391036", "story_v_out_319391.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_22 = math.max(var_158_13, arg_155_1.talkMaxDuration)

			if var_158_12 <= arg_155_1.time_ and arg_155_1.time_ < var_158_12 + var_158_22 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_12) / var_158_22

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_12 + var_158_22 and arg_155_1.time_ < var_158_12 + var_158_22 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play319391037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319391037
		arg_159_1.duration_ = 7.63

		local var_159_0 = {
			zh = 7.633,
			ja = 5.966
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
				arg_159_0:Play319391038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["10069ui_story"]
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10069ui_story == nil then
				arg_159_1.var_.characterEffect10069ui_story = var_162_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 and not isNil(var_162_0) then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2

				if arg_159_1.var_.characterEffect10069ui_story and not isNil(var_162_0) then
					local var_162_4 = Mathf.Lerp(0, 0.5, var_162_3)

					arg_159_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10069ui_story.fillRatio = var_162_4
				end
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 and not isNil(var_162_0) and arg_159_1.var_.characterEffect10069ui_story then
				local var_162_5 = 0.5

				arg_159_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10069ui_story.fillRatio = var_162_5
			end

			local var_162_6 = arg_159_1.actors_["10066ui_story"]
			local var_162_7 = 0

			if var_162_7 < arg_159_1.time_ and arg_159_1.time_ <= var_162_7 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect10066ui_story == nil then
				arg_159_1.var_.characterEffect10066ui_story = var_162_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_8 = 0.200000002980232

			if var_162_7 <= arg_159_1.time_ and arg_159_1.time_ < var_162_7 + var_162_8 and not isNil(var_162_6) then
				local var_162_9 = (arg_159_1.time_ - var_162_7) / var_162_8

				if arg_159_1.var_.characterEffect10066ui_story and not isNil(var_162_6) then
					arg_159_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_7 + var_162_8 and arg_159_1.time_ < var_162_7 + var_162_8 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect10066ui_story then
				arg_159_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_162_10 = 0
			local var_162_11 = 0.85

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_12 = arg_159_1:FormatText(StoryNameCfg[640].name)

				arg_159_1.leftNameTxt_.text = var_162_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_13 = arg_159_1:GetWordFromCfg(319391037)
				local var_162_14 = arg_159_1:FormatText(var_162_13.content)

				arg_159_1.text_.text = var_162_14

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_15 = 34
				local var_162_16 = utf8.len(var_162_14)
				local var_162_17 = var_162_15 <= 0 and var_162_11 or var_162_11 * (var_162_16 / var_162_15)

				if var_162_17 > 0 and var_162_11 < var_162_17 then
					arg_159_1.talkMaxDuration = var_162_17

					if var_162_17 + var_162_10 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_17 + var_162_10
					end
				end

				arg_159_1.text_.text = var_162_14
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391037", "story_v_out_319391.awb") ~= 0 then
					local var_162_18 = manager.audio:GetVoiceLength("story_v_out_319391", "319391037", "story_v_out_319391.awb") / 1000

					if var_162_18 + var_162_10 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_18 + var_162_10
					end

					if var_162_13.prefab_name ~= "" and arg_159_1.actors_[var_162_13.prefab_name] ~= nil then
						local var_162_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_13.prefab_name].transform, "story_v_out_319391", "319391037", "story_v_out_319391.awb")

						arg_159_1:RecordAudio("319391037", var_162_19)
						arg_159_1:RecordAudio("319391037", var_162_19)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_319391", "319391037", "story_v_out_319391.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_319391", "319391037", "story_v_out_319391.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_20 = math.max(var_162_11, arg_159_1.talkMaxDuration)

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_20 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_10) / var_162_20

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_10 + var_162_20 and arg_159_1.time_ < var_162_10 + var_162_20 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play319391038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 319391038
		arg_163_1.duration_ = 14.47

		local var_163_0 = {
			zh = 10.2,
			ja = 14.466
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
				arg_163_0:Play319391039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 1.075

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_2 = arg_163_1:FormatText(StoryNameCfg[640].name)

				arg_163_1.leftNameTxt_.text = var_166_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_3 = arg_163_1:GetWordFromCfg(319391038)
				local var_166_4 = arg_163_1:FormatText(var_166_3.content)

				arg_163_1.text_.text = var_166_4

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_5 = 43
				local var_166_6 = utf8.len(var_166_4)
				local var_166_7 = var_166_5 <= 0 and var_166_1 or var_166_1 * (var_166_6 / var_166_5)

				if var_166_7 > 0 and var_166_1 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_4
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391038", "story_v_out_319391.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_319391", "319391038", "story_v_out_319391.awb") / 1000

					if var_166_8 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_0
					end

					if var_166_3.prefab_name ~= "" and arg_163_1.actors_[var_166_3.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_3.prefab_name].transform, "story_v_out_319391", "319391038", "story_v_out_319391.awb")

						arg_163_1:RecordAudio("319391038", var_166_9)
						arg_163_1:RecordAudio("319391038", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_319391", "319391038", "story_v_out_319391.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_319391", "319391038", "story_v_out_319391.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_10 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_10 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_10

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_10 and arg_163_1.time_ < var_166_0 + var_166_10 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play319391039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 319391039
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play319391040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10066ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10066ui_story == nil then
				arg_167_1.var_.characterEffect10066ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect10066ui_story and not isNil(var_170_0) then
					local var_170_4 = Mathf.Lerp(0, 0.5, var_170_3)

					arg_167_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10066ui_story.fillRatio = var_170_4
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect10066ui_story then
				local var_170_5 = 0.5

				arg_167_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10066ui_story.fillRatio = var_170_5
			end

			local var_170_6 = 0
			local var_170_7 = 1.225

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_8 = arg_167_1:GetWordFromCfg(319391039)
				local var_170_9 = arg_167_1:FormatText(var_170_8.content)

				arg_167_1.text_.text = var_170_9

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_10 = 49
				local var_170_11 = utf8.len(var_170_9)
				local var_170_12 = var_170_10 <= 0 and var_170_7 or var_170_7 * (var_170_11 / var_170_10)

				if var_170_12 > 0 and var_170_7 < var_170_12 then
					arg_167_1.talkMaxDuration = var_170_12

					if var_170_12 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_12 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_9
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_13 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_13 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_13

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_13 and arg_167_1.time_ < var_170_6 + var_170_13 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play319391040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 319391040
		arg_171_1.duration_ = 16.27

		local var_171_0 = {
			zh = 8.6,
			ja = 16.266
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
				arg_171_0:Play319391041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10069ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10069ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0.7, -1.08, -6.33)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10069ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = arg_171_1.actors_["10069ui_story"]
			local var_174_10 = 0

			if var_174_10 < arg_171_1.time_ and arg_171_1.time_ <= var_174_10 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10069ui_story == nil then
				arg_171_1.var_.characterEffect10069ui_story = var_174_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_11 = 0.200000002980232

			if var_174_10 <= arg_171_1.time_ and arg_171_1.time_ < var_174_10 + var_174_11 and not isNil(var_174_9) then
				local var_174_12 = (arg_171_1.time_ - var_174_10) / var_174_11

				if arg_171_1.var_.characterEffect10069ui_story and not isNil(var_174_9) then
					arg_171_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_10 + var_174_11 and arg_171_1.time_ < var_174_10 + var_174_11 + arg_174_0 and not isNil(var_174_9) and arg_171_1.var_.characterEffect10069ui_story then
				arg_171_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_174_13 = 0

			if var_174_13 < arg_171_1.time_ and arg_171_1.time_ <= var_174_13 + arg_174_0 then
				arg_171_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action3_1")
			end

			local var_174_14 = 0

			if var_174_14 < arg_171_1.time_ and arg_171_1.time_ <= var_174_14 + arg_174_0 then
				arg_171_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_174_15 = 0
			local var_174_16 = 0.975

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_17 = arg_171_1:FormatText(StoryNameCfg[693].name)

				arg_171_1.leftNameTxt_.text = var_174_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_18 = arg_171_1:GetWordFromCfg(319391040)
				local var_174_19 = arg_171_1:FormatText(var_174_18.content)

				arg_171_1.text_.text = var_174_19

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_20 = 39
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

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391040", "story_v_out_319391.awb") ~= 0 then
					local var_174_23 = manager.audio:GetVoiceLength("story_v_out_319391", "319391040", "story_v_out_319391.awb") / 1000

					if var_174_23 + var_174_15 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_23 + var_174_15
					end

					if var_174_18.prefab_name ~= "" and arg_171_1.actors_[var_174_18.prefab_name] ~= nil then
						local var_174_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_18.prefab_name].transform, "story_v_out_319391", "319391040", "story_v_out_319391.awb")

						arg_171_1:RecordAudio("319391040", var_174_24)
						arg_171_1:RecordAudio("319391040", var_174_24)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_319391", "319391040", "story_v_out_319391.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_319391", "319391040", "story_v_out_319391.awb")
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
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play319391041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 319391041
		arg_175_1.duration_ = 3.2

		local var_175_0 = {
			zh = 3.2,
			ja = 2.866
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
				arg_175_0:Play319391042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["10066ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos10066ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10066ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["10066ui_story"]
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect10066ui_story == nil then
				arg_175_1.var_.characterEffect10066ui_story = var_178_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_11 = 0.200000002980232

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 and not isNil(var_178_9) then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11

				if arg_175_1.var_.characterEffect10066ui_story and not isNil(var_178_9) then
					arg_175_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect10066ui_story then
				arg_175_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_178_13 = 0

			if var_178_13 < arg_175_1.time_ and arg_175_1.time_ <= var_178_13 + arg_178_0 then
				arg_175_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			local var_178_14 = 0

			if var_178_14 < arg_175_1.time_ and arg_175_1.time_ <= var_178_14 + arg_178_0 then
				arg_175_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_178_15 = arg_175_1.actors_["10069ui_story"]
			local var_178_16 = 0

			if var_178_16 < arg_175_1.time_ and arg_175_1.time_ <= var_178_16 + arg_178_0 and not isNil(var_178_15) and arg_175_1.var_.characterEffect10069ui_story == nil then
				arg_175_1.var_.characterEffect10069ui_story = var_178_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_17 = 0.200000002980232

			if var_178_16 <= arg_175_1.time_ and arg_175_1.time_ < var_178_16 + var_178_17 and not isNil(var_178_15) then
				local var_178_18 = (arg_175_1.time_ - var_178_16) / var_178_17

				if arg_175_1.var_.characterEffect10069ui_story and not isNil(var_178_15) then
					local var_178_19 = Mathf.Lerp(0, 0.5, var_178_18)

					arg_175_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10069ui_story.fillRatio = var_178_19
				end
			end

			if arg_175_1.time_ >= var_178_16 + var_178_17 and arg_175_1.time_ < var_178_16 + var_178_17 + arg_178_0 and not isNil(var_178_15) and arg_175_1.var_.characterEffect10069ui_story then
				local var_178_20 = 0.5

				arg_175_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10069ui_story.fillRatio = var_178_20
			end

			local var_178_21 = 0
			local var_178_22 = 0.225

			if var_178_21 < arg_175_1.time_ and arg_175_1.time_ <= var_178_21 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_23 = arg_175_1:FormatText(StoryNameCfg[640].name)

				arg_175_1.leftNameTxt_.text = var_178_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_24 = arg_175_1:GetWordFromCfg(319391041)
				local var_178_25 = arg_175_1:FormatText(var_178_24.content)

				arg_175_1.text_.text = var_178_25

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_26 = 9
				local var_178_27 = utf8.len(var_178_25)
				local var_178_28 = var_178_26 <= 0 and var_178_22 or var_178_22 * (var_178_27 / var_178_26)

				if var_178_28 > 0 and var_178_22 < var_178_28 then
					arg_175_1.talkMaxDuration = var_178_28

					if var_178_28 + var_178_21 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_28 + var_178_21
					end
				end

				arg_175_1.text_.text = var_178_25
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391041", "story_v_out_319391.awb") ~= 0 then
					local var_178_29 = manager.audio:GetVoiceLength("story_v_out_319391", "319391041", "story_v_out_319391.awb") / 1000

					if var_178_29 + var_178_21 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_29 + var_178_21
					end

					if var_178_24.prefab_name ~= "" and arg_175_1.actors_[var_178_24.prefab_name] ~= nil then
						local var_178_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_24.prefab_name].transform, "story_v_out_319391", "319391041", "story_v_out_319391.awb")

						arg_175_1:RecordAudio("319391041", var_178_30)
						arg_175_1:RecordAudio("319391041", var_178_30)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_319391", "319391041", "story_v_out_319391.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_319391", "319391041", "story_v_out_319391.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_31 = math.max(var_178_22, arg_175_1.talkMaxDuration)

			if var_178_21 <= arg_175_1.time_ and arg_175_1.time_ < var_178_21 + var_178_31 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_21) / var_178_31

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_21 + var_178_31 and arg_175_1.time_ < var_178_21 + var_178_31 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play319391042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 319391042
		arg_179_1.duration_ = 16.53

		local var_179_0 = {
			zh = 10.966,
			ja = 16.533
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
				arg_179_0:Play319391043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10066ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect10066ui_story == nil then
				arg_179_1.var_.characterEffect10066ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect10066ui_story and not isNil(var_182_0) then
					local var_182_4 = Mathf.Lerp(0, 0.5, var_182_3)

					arg_179_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10066ui_story.fillRatio = var_182_4
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect10066ui_story then
				local var_182_5 = 0.5

				arg_179_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10066ui_story.fillRatio = var_182_5
			end

			local var_182_6 = arg_179_1.actors_["10069ui_story"]
			local var_182_7 = 0

			if var_182_7 < arg_179_1.time_ and arg_179_1.time_ <= var_182_7 + arg_182_0 and not isNil(var_182_6) and arg_179_1.var_.characterEffect10069ui_story == nil then
				arg_179_1.var_.characterEffect10069ui_story = var_182_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_8 = 0.200000002980232

			if var_182_7 <= arg_179_1.time_ and arg_179_1.time_ < var_182_7 + var_182_8 and not isNil(var_182_6) then
				local var_182_9 = (arg_179_1.time_ - var_182_7) / var_182_8

				if arg_179_1.var_.characterEffect10069ui_story and not isNil(var_182_6) then
					arg_179_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_7 + var_182_8 and arg_179_1.time_ < var_182_7 + var_182_8 + arg_182_0 and not isNil(var_182_6) and arg_179_1.var_.characterEffect10069ui_story then
				arg_179_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_182_10 = 0
			local var_182_11 = 1.275

			if var_182_10 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_12 = arg_179_1:FormatText(StoryNameCfg[693].name)

				arg_179_1.leftNameTxt_.text = var_182_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_13 = arg_179_1:GetWordFromCfg(319391042)
				local var_182_14 = arg_179_1:FormatText(var_182_13.content)

				arg_179_1.text_.text = var_182_14

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_15 = 51
				local var_182_16 = utf8.len(var_182_14)
				local var_182_17 = var_182_15 <= 0 and var_182_11 or var_182_11 * (var_182_16 / var_182_15)

				if var_182_17 > 0 and var_182_11 < var_182_17 then
					arg_179_1.talkMaxDuration = var_182_17

					if var_182_17 + var_182_10 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_17 + var_182_10
					end
				end

				arg_179_1.text_.text = var_182_14
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391042", "story_v_out_319391.awb") ~= 0 then
					local var_182_18 = manager.audio:GetVoiceLength("story_v_out_319391", "319391042", "story_v_out_319391.awb") / 1000

					if var_182_18 + var_182_10 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_18 + var_182_10
					end

					if var_182_13.prefab_name ~= "" and arg_179_1.actors_[var_182_13.prefab_name] ~= nil then
						local var_182_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_13.prefab_name].transform, "story_v_out_319391", "319391042", "story_v_out_319391.awb")

						arg_179_1:RecordAudio("319391042", var_182_19)
						arg_179_1:RecordAudio("319391042", var_182_19)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_319391", "319391042", "story_v_out_319391.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_319391", "319391042", "story_v_out_319391.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_20 = math.max(var_182_11, arg_179_1.talkMaxDuration)

			if var_182_10 <= arg_179_1.time_ and arg_179_1.time_ < var_182_10 + var_182_20 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_10) / var_182_20

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_10 + var_182_20 and arg_179_1.time_ < var_182_10 + var_182_20 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play319391043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 319391043
		arg_183_1.duration_ = 8.1

		local var_183_0 = {
			zh = 3.566,
			ja = 8.1
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
				arg_183_0:Play319391044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.4

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[693].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:GetWordFromCfg(319391043)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 16
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391043", "story_v_out_319391.awb") ~= 0 then
					local var_186_8 = manager.audio:GetVoiceLength("story_v_out_319391", "319391043", "story_v_out_319391.awb") / 1000

					if var_186_8 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_0
					end

					if var_186_3.prefab_name ~= "" and arg_183_1.actors_[var_186_3.prefab_name] ~= nil then
						local var_186_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_3.prefab_name].transform, "story_v_out_319391", "319391043", "story_v_out_319391.awb")

						arg_183_1:RecordAudio("319391043", var_186_9)
						arg_183_1:RecordAudio("319391043", var_186_9)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_319391", "319391043", "story_v_out_319391.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_319391", "319391043", "story_v_out_319391.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_10 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_10 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_10

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_10 and arg_183_1.time_ < var_186_0 + var_186_10 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play319391044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319391044
		arg_187_1.duration_ = 3.07

		local var_187_0 = {
			zh = 1.999999999999,
			ja = 3.066
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play319391045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10069ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect10069ui_story == nil then
				arg_187_1.var_.characterEffect10069ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect10069ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10069ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect10069ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10069ui_story.fillRatio = var_190_5
			end

			local var_190_6 = arg_187_1.actors_["10066ui_story"]
			local var_190_7 = 0

			if var_190_7 < arg_187_1.time_ and arg_187_1.time_ <= var_190_7 + arg_190_0 and not isNil(var_190_6) and arg_187_1.var_.characterEffect10066ui_story == nil then
				arg_187_1.var_.characterEffect10066ui_story = var_190_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_8 = 0.200000002980232

			if var_190_7 <= arg_187_1.time_ and arg_187_1.time_ < var_190_7 + var_190_8 and not isNil(var_190_6) then
				local var_190_9 = (arg_187_1.time_ - var_190_7) / var_190_8

				if arg_187_1.var_.characterEffect10066ui_story and not isNil(var_190_6) then
					arg_187_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_7 + var_190_8 and arg_187_1.time_ < var_190_7 + var_190_8 + arg_190_0 and not isNil(var_190_6) and arg_187_1.var_.characterEffect10066ui_story then
				arg_187_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 then
				arg_187_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_2")
			end

			local var_190_11 = 0

			if var_190_11 < arg_187_1.time_ and arg_187_1.time_ <= var_190_11 + arg_190_0 then
				arg_187_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_190_12 = 0
			local var_190_13 = 0.125

			if var_190_12 < arg_187_1.time_ and arg_187_1.time_ <= var_190_12 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_14 = arg_187_1:FormatText(StoryNameCfg[640].name)

				arg_187_1.leftNameTxt_.text = var_190_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_15 = arg_187_1:GetWordFromCfg(319391044)
				local var_190_16 = arg_187_1:FormatText(var_190_15.content)

				arg_187_1.text_.text = var_190_16

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_17 = 5
				local var_190_18 = utf8.len(var_190_16)
				local var_190_19 = var_190_17 <= 0 and var_190_13 or var_190_13 * (var_190_18 / var_190_17)

				if var_190_19 > 0 and var_190_13 < var_190_19 then
					arg_187_1.talkMaxDuration = var_190_19

					if var_190_19 + var_190_12 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_19 + var_190_12
					end
				end

				arg_187_1.text_.text = var_190_16
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391044", "story_v_out_319391.awb") ~= 0 then
					local var_190_20 = manager.audio:GetVoiceLength("story_v_out_319391", "319391044", "story_v_out_319391.awb") / 1000

					if var_190_20 + var_190_12 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_20 + var_190_12
					end

					if var_190_15.prefab_name ~= "" and arg_187_1.actors_[var_190_15.prefab_name] ~= nil then
						local var_190_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_15.prefab_name].transform, "story_v_out_319391", "319391044", "story_v_out_319391.awb")

						arg_187_1:RecordAudio("319391044", var_190_21)
						arg_187_1:RecordAudio("319391044", var_190_21)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_319391", "319391044", "story_v_out_319391.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_319391", "319391044", "story_v_out_319391.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_22 = math.max(var_190_13, arg_187_1.talkMaxDuration)

			if var_190_12 <= arg_187_1.time_ and arg_187_1.time_ < var_190_12 + var_190_22 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_12) / var_190_22

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_12 + var_190_22 and arg_187_1.time_ < var_190_12 + var_190_22 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play319391045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 319391045
		arg_191_1.duration_ = 7.5

		local var_191_0 = {
			zh = 7.5,
			ja = 5.533
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play319391046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10069ui_story"].transform
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 then
				arg_191_1.var_.moveOldPos10069ui_story = var_194_0.localPosition
			end

			local var_194_2 = 0.001

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2
				local var_194_4 = Vector3.New(0.7, -1.08, -6.33)

				var_194_0.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10069ui_story, var_194_4, var_194_3)

				local var_194_5 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_5.x, var_194_5.y, var_194_5.z)

				local var_194_6 = var_194_0.localEulerAngles

				var_194_6.z = 0
				var_194_6.x = 0
				var_194_0.localEulerAngles = var_194_6
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 then
				var_194_0.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_194_7 = manager.ui.mainCamera.transform.position - var_194_0.position

				var_194_0.forward = Vector3.New(var_194_7.x, var_194_7.y, var_194_7.z)

				local var_194_8 = var_194_0.localEulerAngles

				var_194_8.z = 0
				var_194_8.x = 0
				var_194_0.localEulerAngles = var_194_8
			end

			local var_194_9 = arg_191_1.actors_["10069ui_story"]
			local var_194_10 = 0

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect10069ui_story == nil then
				arg_191_1.var_.characterEffect10069ui_story = var_194_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_11 = 0.200000002980232

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_11 and not isNil(var_194_9) then
				local var_194_12 = (arg_191_1.time_ - var_194_10) / var_194_11

				if arg_191_1.var_.characterEffect10069ui_story and not isNil(var_194_9) then
					arg_191_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_10 + var_194_11 and arg_191_1.time_ < var_194_10 + var_194_11 + arg_194_0 and not isNil(var_194_9) and arg_191_1.var_.characterEffect10069ui_story then
				arg_191_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_194_13 = 0

			if var_194_13 < arg_191_1.time_ and arg_191_1.time_ <= var_194_13 + arg_194_0 then
				arg_191_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action3_2")
			end

			local var_194_14 = 0

			if var_194_14 < arg_191_1.time_ and arg_191_1.time_ <= var_194_14 + arg_194_0 then
				arg_191_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_194_15 = arg_191_1.actors_["10066ui_story"]
			local var_194_16 = 0

			if var_194_16 < arg_191_1.time_ and arg_191_1.time_ <= var_194_16 + arg_194_0 and not isNil(var_194_15) and arg_191_1.var_.characterEffect10066ui_story == nil then
				arg_191_1.var_.characterEffect10066ui_story = var_194_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_17 = 0.200000002980232

			if var_194_16 <= arg_191_1.time_ and arg_191_1.time_ < var_194_16 + var_194_17 and not isNil(var_194_15) then
				local var_194_18 = (arg_191_1.time_ - var_194_16) / var_194_17

				if arg_191_1.var_.characterEffect10066ui_story and not isNil(var_194_15) then
					local var_194_19 = Mathf.Lerp(0, 0.5, var_194_18)

					arg_191_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10066ui_story.fillRatio = var_194_19
				end
			end

			if arg_191_1.time_ >= var_194_16 + var_194_17 and arg_191_1.time_ < var_194_16 + var_194_17 + arg_194_0 and not isNil(var_194_15) and arg_191_1.var_.characterEffect10066ui_story then
				local var_194_20 = 0.5

				arg_191_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10066ui_story.fillRatio = var_194_20
			end

			local var_194_21 = 0
			local var_194_22 = 0.675

			if var_194_21 < arg_191_1.time_ and arg_191_1.time_ <= var_194_21 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_23 = arg_191_1:FormatText(StoryNameCfg[693].name)

				arg_191_1.leftNameTxt_.text = var_194_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_24 = arg_191_1:GetWordFromCfg(319391045)
				local var_194_25 = arg_191_1:FormatText(var_194_24.content)

				arg_191_1.text_.text = var_194_25

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_26 = 27
				local var_194_27 = utf8.len(var_194_25)
				local var_194_28 = var_194_26 <= 0 and var_194_22 or var_194_22 * (var_194_27 / var_194_26)

				if var_194_28 > 0 and var_194_22 < var_194_28 then
					arg_191_1.talkMaxDuration = var_194_28

					if var_194_28 + var_194_21 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_28 + var_194_21
					end
				end

				arg_191_1.text_.text = var_194_25
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391045", "story_v_out_319391.awb") ~= 0 then
					local var_194_29 = manager.audio:GetVoiceLength("story_v_out_319391", "319391045", "story_v_out_319391.awb") / 1000

					if var_194_29 + var_194_21 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_29 + var_194_21
					end

					if var_194_24.prefab_name ~= "" and arg_191_1.actors_[var_194_24.prefab_name] ~= nil then
						local var_194_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_24.prefab_name].transform, "story_v_out_319391", "319391045", "story_v_out_319391.awb")

						arg_191_1:RecordAudio("319391045", var_194_30)
						arg_191_1:RecordAudio("319391045", var_194_30)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_319391", "319391045", "story_v_out_319391.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_319391", "319391045", "story_v_out_319391.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_31 = math.max(var_194_22, arg_191_1.talkMaxDuration)

			if var_194_21 <= arg_191_1.time_ and arg_191_1.time_ < var_194_21 + var_194_31 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_21) / var_194_31

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_21 + var_194_31 and arg_191_1.time_ < var_194_21 + var_194_31 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	Play319391046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319391046
		arg_195_1.duration_ = 2.63

		local var_195_0 = {
			zh = 1.999999999999,
			ja = 2.633
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play319391047(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1084ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1084ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(0, -0.97, -6)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1084ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = arg_195_1.actors_["1084ui_story"]
			local var_198_10 = 0

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1084ui_story == nil then
				arg_195_1.var_.characterEffect1084ui_story = var_198_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_11 = 0.200000002980232

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_11 and not isNil(var_198_9) then
				local var_198_12 = (arg_195_1.time_ - var_198_10) / var_198_11

				if arg_195_1.var_.characterEffect1084ui_story and not isNil(var_198_9) then
					arg_195_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_10 + var_198_11 and arg_195_1.time_ < var_198_10 + var_198_11 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1084ui_story then
				arg_195_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_198_13 = 0

			if var_198_13 < arg_195_1.time_ and arg_195_1.time_ <= var_198_13 + arg_198_0 then
				arg_195_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_198_14 = 0

			if var_198_14 < arg_195_1.time_ and arg_195_1.time_ <= var_198_14 + arg_198_0 then
				arg_195_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_198_15 = arg_195_1.actors_["10069ui_story"].transform
			local var_198_16 = 0

			if var_198_16 < arg_195_1.time_ and arg_195_1.time_ <= var_198_16 + arg_198_0 then
				arg_195_1.var_.moveOldPos10069ui_story = var_198_15.localPosition
			end

			local var_198_17 = 0.001

			if var_198_16 <= arg_195_1.time_ and arg_195_1.time_ < var_198_16 + var_198_17 then
				local var_198_18 = (arg_195_1.time_ - var_198_16) / var_198_17
				local var_198_19 = Vector3.New(0, 100, 0)

				var_198_15.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10069ui_story, var_198_19, var_198_18)

				local var_198_20 = manager.ui.mainCamera.transform.position - var_198_15.position

				var_198_15.forward = Vector3.New(var_198_20.x, var_198_20.y, var_198_20.z)

				local var_198_21 = var_198_15.localEulerAngles

				var_198_21.z = 0
				var_198_21.x = 0
				var_198_15.localEulerAngles = var_198_21
			end

			if arg_195_1.time_ >= var_198_16 + var_198_17 and arg_195_1.time_ < var_198_16 + var_198_17 + arg_198_0 then
				var_198_15.localPosition = Vector3.New(0, 100, 0)

				local var_198_22 = manager.ui.mainCamera.transform.position - var_198_15.position

				var_198_15.forward = Vector3.New(var_198_22.x, var_198_22.y, var_198_22.z)

				local var_198_23 = var_198_15.localEulerAngles

				var_198_23.z = 0
				var_198_23.x = 0
				var_198_15.localEulerAngles = var_198_23
			end

			local var_198_24 = arg_195_1.actors_["10069ui_story"]
			local var_198_25 = 0

			if var_198_25 < arg_195_1.time_ and arg_195_1.time_ <= var_198_25 + arg_198_0 and not isNil(var_198_24) and arg_195_1.var_.characterEffect10069ui_story == nil then
				arg_195_1.var_.characterEffect10069ui_story = var_198_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_26 = 0.200000002980232

			if var_198_25 <= arg_195_1.time_ and arg_195_1.time_ < var_198_25 + var_198_26 and not isNil(var_198_24) then
				local var_198_27 = (arg_195_1.time_ - var_198_25) / var_198_26

				if arg_195_1.var_.characterEffect10069ui_story and not isNil(var_198_24) then
					local var_198_28 = Mathf.Lerp(0, 0.5, var_198_27)

					arg_195_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10069ui_story.fillRatio = var_198_28
				end
			end

			if arg_195_1.time_ >= var_198_25 + var_198_26 and arg_195_1.time_ < var_198_25 + var_198_26 + arg_198_0 and not isNil(var_198_24) and arg_195_1.var_.characterEffect10069ui_story then
				local var_198_29 = 0.5

				arg_195_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10069ui_story.fillRatio = var_198_29
			end

			local var_198_30 = arg_195_1.actors_["10066ui_story"].transform
			local var_198_31 = 0

			if var_198_31 < arg_195_1.time_ and arg_195_1.time_ <= var_198_31 + arg_198_0 then
				arg_195_1.var_.moveOldPos10066ui_story = var_198_30.localPosition
			end

			local var_198_32 = 0.001

			if var_198_31 <= arg_195_1.time_ and arg_195_1.time_ < var_198_31 + var_198_32 then
				local var_198_33 = (arg_195_1.time_ - var_198_31) / var_198_32
				local var_198_34 = Vector3.New(0, 100, 0)

				var_198_30.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10066ui_story, var_198_34, var_198_33)

				local var_198_35 = manager.ui.mainCamera.transform.position - var_198_30.position

				var_198_30.forward = Vector3.New(var_198_35.x, var_198_35.y, var_198_35.z)

				local var_198_36 = var_198_30.localEulerAngles

				var_198_36.z = 0
				var_198_36.x = 0
				var_198_30.localEulerAngles = var_198_36
			end

			if arg_195_1.time_ >= var_198_31 + var_198_32 and arg_195_1.time_ < var_198_31 + var_198_32 + arg_198_0 then
				var_198_30.localPosition = Vector3.New(0, 100, 0)

				local var_198_37 = manager.ui.mainCamera.transform.position - var_198_30.position

				var_198_30.forward = Vector3.New(var_198_37.x, var_198_37.y, var_198_37.z)

				local var_198_38 = var_198_30.localEulerAngles

				var_198_38.z = 0
				var_198_38.x = 0
				var_198_30.localEulerAngles = var_198_38
			end

			local var_198_39 = arg_195_1.actors_["10066ui_story"]
			local var_198_40 = 0

			if var_198_40 < arg_195_1.time_ and arg_195_1.time_ <= var_198_40 + arg_198_0 and not isNil(var_198_39) and arg_195_1.var_.characterEffect10066ui_story == nil then
				arg_195_1.var_.characterEffect10066ui_story = var_198_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_41 = 0.200000002980232

			if var_198_40 <= arg_195_1.time_ and arg_195_1.time_ < var_198_40 + var_198_41 and not isNil(var_198_39) then
				local var_198_42 = (arg_195_1.time_ - var_198_40) / var_198_41

				if arg_195_1.var_.characterEffect10066ui_story and not isNil(var_198_39) then
					local var_198_43 = Mathf.Lerp(0, 0.5, var_198_42)

					arg_195_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10066ui_story.fillRatio = var_198_43
				end
			end

			if arg_195_1.time_ >= var_198_40 + var_198_41 and arg_195_1.time_ < var_198_40 + var_198_41 + arg_198_0 and not isNil(var_198_39) and arg_195_1.var_.characterEffect10066ui_story then
				local var_198_44 = 0.5

				arg_195_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10066ui_story.fillRatio = var_198_44
			end

			local var_198_45 = 0
			local var_198_46 = 0.125

			if var_198_45 < arg_195_1.time_ and arg_195_1.time_ <= var_198_45 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_47 = arg_195_1:FormatText(StoryNameCfg[6].name)

				arg_195_1.leftNameTxt_.text = var_198_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_48 = arg_195_1:GetWordFromCfg(319391046)
				local var_198_49 = arg_195_1:FormatText(var_198_48.content)

				arg_195_1.text_.text = var_198_49

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_50 = 5
				local var_198_51 = utf8.len(var_198_49)
				local var_198_52 = var_198_50 <= 0 and var_198_46 or var_198_46 * (var_198_51 / var_198_50)

				if var_198_52 > 0 and var_198_46 < var_198_52 then
					arg_195_1.talkMaxDuration = var_198_52

					if var_198_52 + var_198_45 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_52 + var_198_45
					end
				end

				arg_195_1.text_.text = var_198_49
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391046", "story_v_out_319391.awb") ~= 0 then
					local var_198_53 = manager.audio:GetVoiceLength("story_v_out_319391", "319391046", "story_v_out_319391.awb") / 1000

					if var_198_53 + var_198_45 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_53 + var_198_45
					end

					if var_198_48.prefab_name ~= "" and arg_195_1.actors_[var_198_48.prefab_name] ~= nil then
						local var_198_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_48.prefab_name].transform, "story_v_out_319391", "319391046", "story_v_out_319391.awb")

						arg_195_1:RecordAudio("319391046", var_198_54)
						arg_195_1:RecordAudio("319391046", var_198_54)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_319391", "319391046", "story_v_out_319391.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_319391", "319391046", "story_v_out_319391.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_55 = math.max(var_198_46, arg_195_1.talkMaxDuration)

			if var_198_45 <= arg_195_1.time_ and arg_195_1.time_ < var_198_45 + var_198_55 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_45) / var_198_55

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_45 + var_198_55 and arg_195_1.time_ < var_198_45 + var_198_55 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play319391047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319391047
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play319391048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1084ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1084ui_story == nil then
				arg_199_1.var_.characterEffect1084ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1084ui_story and not isNil(var_202_0) then
					local var_202_4 = Mathf.Lerp(0, 0.5, var_202_3)

					arg_199_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1084ui_story.fillRatio = var_202_4
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1084ui_story then
				local var_202_5 = 0.5

				arg_199_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1084ui_story.fillRatio = var_202_5
			end

			local var_202_6 = 0
			local var_202_7 = 1.475

			if var_202_6 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_8 = arg_199_1:GetWordFromCfg(319391047)
				local var_202_9 = arg_199_1:FormatText(var_202_8.content)

				arg_199_1.text_.text = var_202_9

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_10 = 59
				local var_202_11 = utf8.len(var_202_9)
				local var_202_12 = var_202_10 <= 0 and var_202_7 or var_202_7 * (var_202_11 / var_202_10)

				if var_202_12 > 0 and var_202_7 < var_202_12 then
					arg_199_1.talkMaxDuration = var_202_12

					if var_202_12 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_12 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_9
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_13 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_13 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_13

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_13 and arg_199_1.time_ < var_202_6 + var_202_13 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play319391048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 319391048
		arg_203_1.duration_ = 6.8

		local var_203_0 = {
			zh = 6.8,
			ja = 3.3
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play319391049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1084ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1084ui_story == nil then
				arg_203_1.var_.characterEffect1084ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect1084ui_story and not isNil(var_206_0) then
					arg_203_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1084ui_story then
				arg_203_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_206_4 = 0
			local var_206_5 = 0.75

			if var_206_4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_6 = arg_203_1:FormatText(StoryNameCfg[6].name)

				arg_203_1.leftNameTxt_.text = var_206_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_7 = arg_203_1:GetWordFromCfg(319391048)
				local var_206_8 = arg_203_1:FormatText(var_206_7.content)

				arg_203_1.text_.text = var_206_8

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_9 = 30
				local var_206_10 = utf8.len(var_206_8)
				local var_206_11 = var_206_9 <= 0 and var_206_5 or var_206_5 * (var_206_10 / var_206_9)

				if var_206_11 > 0 and var_206_5 < var_206_11 then
					arg_203_1.talkMaxDuration = var_206_11

					if var_206_11 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_4
					end
				end

				arg_203_1.text_.text = var_206_8
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391048", "story_v_out_319391.awb") ~= 0 then
					local var_206_12 = manager.audio:GetVoiceLength("story_v_out_319391", "319391048", "story_v_out_319391.awb") / 1000

					if var_206_12 + var_206_4 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_12 + var_206_4
					end

					if var_206_7.prefab_name ~= "" and arg_203_1.actors_[var_206_7.prefab_name] ~= nil then
						local var_206_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_7.prefab_name].transform, "story_v_out_319391", "319391048", "story_v_out_319391.awb")

						arg_203_1:RecordAudio("319391048", var_206_13)
						arg_203_1:RecordAudio("319391048", var_206_13)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_319391", "319391048", "story_v_out_319391.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_319391", "319391048", "story_v_out_319391.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_14 = math.max(var_206_5, arg_203_1.talkMaxDuration)

			if var_206_4 <= arg_203_1.time_ and arg_203_1.time_ < var_206_4 + var_206_14 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_4) / var_206_14

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_4 + var_206_14 and arg_203_1.time_ < var_206_4 + var_206_14 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play319391049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 319391049
		arg_207_1.duration_ = 2.7

		local var_207_0 = {
			zh = 1.366,
			ja = 2.7
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play319391050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.15

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_2 = arg_207_1:FormatText(StoryNameCfg[6].name)

				arg_207_1.leftNameTxt_.text = var_210_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_3 = arg_207_1:GetWordFromCfg(319391049)
				local var_210_4 = arg_207_1:FormatText(var_210_3.content)

				arg_207_1.text_.text = var_210_4

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_5 = 6
				local var_210_6 = utf8.len(var_210_4)
				local var_210_7 = var_210_5 <= 0 and var_210_1 or var_210_1 * (var_210_6 / var_210_5)

				if var_210_7 > 0 and var_210_1 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_4
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391049", "story_v_out_319391.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_319391", "319391049", "story_v_out_319391.awb") / 1000

					if var_210_8 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_0
					end

					if var_210_3.prefab_name ~= "" and arg_207_1.actors_[var_210_3.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_3.prefab_name].transform, "story_v_out_319391", "319391049", "story_v_out_319391.awb")

						arg_207_1:RecordAudio("319391049", var_210_9)
						arg_207_1:RecordAudio("319391049", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_319391", "319391049", "story_v_out_319391.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_319391", "319391049", "story_v_out_319391.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_10 and arg_207_1.time_ < var_210_0 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play319391050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 319391050
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play319391051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10069ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos10069ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0, 100, 0)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10069ui_story, var_214_4, var_214_3)

				local var_214_5 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_5.x, var_214_5.y, var_214_5.z)

				local var_214_6 = var_214_0.localEulerAngles

				var_214_6.z = 0
				var_214_6.x = 0
				var_214_0.localEulerAngles = var_214_6
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, 100, 0)

				local var_214_7 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_7.x, var_214_7.y, var_214_7.z)

				local var_214_8 = var_214_0.localEulerAngles

				var_214_8.z = 0
				var_214_8.x = 0
				var_214_0.localEulerAngles = var_214_8
			end

			local var_214_9 = arg_211_1.actors_["1084ui_story"].transform
			local var_214_10 = 0

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 then
				arg_211_1.var_.moveOldPos1084ui_story = var_214_9.localPosition
			end

			local var_214_11 = 0.001

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_11 then
				local var_214_12 = (arg_211_1.time_ - var_214_10) / var_214_11
				local var_214_13 = Vector3.New(0, 100, 0)

				var_214_9.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1084ui_story, var_214_13, var_214_12)

				local var_214_14 = manager.ui.mainCamera.transform.position - var_214_9.position

				var_214_9.forward = Vector3.New(var_214_14.x, var_214_14.y, var_214_14.z)

				local var_214_15 = var_214_9.localEulerAngles

				var_214_15.z = 0
				var_214_15.x = 0
				var_214_9.localEulerAngles = var_214_15
			end

			if arg_211_1.time_ >= var_214_10 + var_214_11 and arg_211_1.time_ < var_214_10 + var_214_11 + arg_214_0 then
				var_214_9.localPosition = Vector3.New(0, 100, 0)

				local var_214_16 = manager.ui.mainCamera.transform.position - var_214_9.position

				var_214_9.forward = Vector3.New(var_214_16.x, var_214_16.y, var_214_16.z)

				local var_214_17 = var_214_9.localEulerAngles

				var_214_17.z = 0
				var_214_17.x = 0
				var_214_9.localEulerAngles = var_214_17
			end

			local var_214_18 = "STblack"

			if arg_211_1.bgs_[var_214_18] == nil then
				local var_214_19 = Object.Instantiate(arg_211_1.paintGo_)

				var_214_19:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_214_18)
				var_214_19.name = var_214_18
				var_214_19.transform.parent = arg_211_1.stage_.transform
				var_214_19.transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.bgs_[var_214_18] = var_214_19
			end

			local var_214_20 = 0

			if var_214_20 < arg_211_1.time_ and arg_211_1.time_ <= var_214_20 + arg_214_0 then
				local var_214_21 = manager.ui.mainCamera.transform.localPosition
				local var_214_22 = Vector3.New(0, 0, 10) + Vector3.New(var_214_21.x, var_214_21.y, 0)
				local var_214_23 = arg_211_1.bgs_.STblack

				var_214_23.transform.localPosition = var_214_22
				var_214_23.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_214_24 = var_214_23:GetComponent("SpriteRenderer")

				if var_214_24 and var_214_24.sprite then
					local var_214_25 = (var_214_23.transform.localPosition - var_214_21).z
					local var_214_26 = manager.ui.mainCameraCom_
					local var_214_27 = 2 * var_214_25 * Mathf.Tan(var_214_26.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_214_28 = var_214_27 * var_214_26.aspect
					local var_214_29 = var_214_24.sprite.bounds.size.x
					local var_214_30 = var_214_24.sprite.bounds.size.y
					local var_214_31 = var_214_28 / var_214_29
					local var_214_32 = var_214_27 / var_214_30
					local var_214_33 = var_214_32 < var_214_31 and var_214_31 or var_214_32

					var_214_23.transform.localScale = Vector3.New(var_214_33, var_214_33, 0)
				end

				for iter_214_0, iter_214_1 in pairs(arg_211_1.bgs_) do
					if iter_214_0 ~= "STblack" then
						iter_214_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_214_34 = 0

			if var_214_34 < arg_211_1.time_ and arg_211_1.time_ <= var_214_34 + arg_214_0 then
				local var_214_35 = arg_211_1.fswbg_.transform:Find("textbox/adapt/content") or arg_211_1.fswbg_.transform:Find("textbox/content")
				local var_214_36 = arg_211_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_214_37 = var_214_35:GetComponent("Text")
				local var_214_38 = var_214_35:GetComponent("RectTransform")

				var_214_37.alignment = UnityEngine.TextAnchor.LowerCenter
				var_214_38.offsetMin = Vector2.New(0, 0)
				var_214_38.offsetMax = Vector2.New(0, 0)
			end

			local var_214_39 = 0

			if var_214_39 < arg_211_1.time_ and arg_211_1.time_ <= var_214_39 + arg_214_0 then
				arg_211_1.fswbg_:SetActive(true)
				arg_211_1.dialog_:SetActive(false)

				arg_211_1.fswtw_.percent = 0

				local var_214_40 = arg_211_1:GetWordFromCfg(319391050)
				local var_214_41 = arg_211_1:FormatText(var_214_40.content)

				arg_211_1.fswt_.text = var_214_41

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.fswt_)

				arg_211_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_211_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_211_1.fswtw_:SetDirty()

				arg_211_1.typewritterCharCountI18N = 0

				SetActive(arg_211_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_211_1:ShowNextGo(false)
			end

			local var_214_42 = 0.466666666666667

			if var_214_42 < arg_211_1.time_ and arg_211_1.time_ <= var_214_42 + arg_214_0 then
				arg_211_1.var_.oldValueTypewriter = arg_211_1.fswtw_.percent

				SetActive(arg_211_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_211_1:ShowNextGo(false)
			end

			local var_214_43 = 4
			local var_214_44 = 0.266666666666667
			local var_214_45 = arg_211_1:GetWordFromCfg(319391050)
			local var_214_46 = arg_211_1:FormatText(var_214_45.content)
			local var_214_47, var_214_48 = arg_211_1:GetPercentByPara(var_214_46, 1)

			if var_214_42 < arg_211_1.time_ and arg_211_1.time_ <= var_214_42 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0

				local var_214_49 = var_214_43 <= 0 and var_214_44 or var_214_44 * ((var_214_48 - arg_211_1.typewritterCharCountI18N) / var_214_43)

				if var_214_49 > 0 and var_214_44 < var_214_49 then
					arg_211_1.talkMaxDuration = var_214_49

					if var_214_49 + var_214_42 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_49 + var_214_42
					end
				end
			end

			local var_214_50 = 0.266666666666667
			local var_214_51 = math.max(var_214_50, arg_211_1.talkMaxDuration)

			if var_214_42 <= arg_211_1.time_ and arg_211_1.time_ < var_214_42 + var_214_51 then
				local var_214_52 = (arg_211_1.time_ - var_214_42) / var_214_51

				arg_211_1.fswtw_.percent = Mathf.Lerp(arg_211_1.var_.oldValueTypewriter, var_214_47, var_214_52)
				arg_211_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_211_1.fswtw_:SetDirty()
			end

			if arg_211_1.time_ >= var_214_42 + var_214_51 and arg_211_1.time_ < var_214_42 + var_214_51 + arg_214_0 then
				arg_211_1.fswtw_.percent = var_214_47

				arg_211_1.fswtw_:SetDirty()
				arg_211_1:ShowNextGo(true)

				arg_211_1.typewritterCharCountI18N = var_214_48
			end

			local var_214_53 = 0

			if var_214_53 < arg_211_1.time_ and arg_211_1.time_ <= var_214_53 + arg_214_0 then
				arg_211_1.cswbg_:SetActive(true)

				local var_214_54 = arg_211_1.cswt_:GetComponent("RectTransform")

				arg_211_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_214_54.offsetMin = Vector2.New(410, 330)
				var_214_54.offsetMax = Vector2.New(-400, -175)

				local var_214_55 = arg_211_1:GetWordFromCfg(419017)
				local var_214_56 = arg_211_1:FormatText(var_214_55.content)

				arg_211_1.cswt_.text = var_214_56

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.cswt_)

				arg_211_1.cswt_.fontSize = 180
				arg_211_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_211_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_211_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_214_57 = 0.466666666666667
			local var_214_58 = 1.166
			local var_214_59 = manager.audio:GetVoiceLength("story_v_out_319391", "319391050", "story_v_out_319391.awb") / 1000

			if var_214_59 > 0 and var_214_58 < var_214_59 and var_214_59 + var_214_57 > arg_211_1.duration_ then
				local var_214_60 = var_214_59

				arg_211_1.duration_ = var_214_59 + var_214_57
			end

			if var_214_57 < arg_211_1.time_ and arg_211_1.time_ <= var_214_57 + arg_214_0 then
				local var_214_61 = "play"
				local var_214_62 = "voice"

				arg_211_1:AudioAction(var_214_61, var_214_62, "story_v_out_319391", "319391050", "story_v_out_319391.awb")
			end
		end

		arg_211_1.nodeConfigList_ = {
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

		arg_211_1:InitPlayNodeList()
	end,
	Play319391051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 319391051
		arg_215_1.duration_ = 3.03

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play319391052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = 0

			if var_218_0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_0 + arg_218_0 then
				arg_215_1.fswbg_:SetActive(true)
				arg_215_1.dialog_:SetActive(false)

				arg_215_1.fswtw_.percent = 0

				local var_218_1 = arg_215_1:GetWordFromCfg(319391051)
				local var_218_2 = arg_215_1:FormatText(var_218_1.content)

				arg_215_1.fswt_.text = var_218_2

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.fswt_)

				arg_215_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_215_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_215_1.fswtw_:SetDirty()

				arg_215_1.typewritterCharCountI18N = 0

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_3 = 0.433333333333333

			if var_218_3 < arg_215_1.time_ and arg_215_1.time_ <= var_218_3 + arg_218_0 then
				arg_215_1.var_.oldValueTypewriter = arg_215_1.fswtw_.percent

				SetActive(arg_215_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_215_1:ShowNextGo(false)
			end

			local var_218_4 = 39
			local var_218_5 = 2.6
			local var_218_6 = arg_215_1:GetWordFromCfg(319391051)
			local var_218_7 = arg_215_1:FormatText(var_218_6.content)
			local var_218_8, var_218_9 = arg_215_1:GetPercentByPara(var_218_7, 1)

			if var_218_3 < arg_215_1.time_ and arg_215_1.time_ <= var_218_3 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				local var_218_10 = var_218_4 <= 0 and var_218_5 or var_218_5 * ((var_218_9 - arg_215_1.typewritterCharCountI18N) / var_218_4)

				if var_218_10 > 0 and var_218_5 < var_218_10 then
					arg_215_1.talkMaxDuration = var_218_10

					if var_218_10 + var_218_3 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_3
					end
				end
			end

			local var_218_11 = 2.6
			local var_218_12 = math.max(var_218_11, arg_215_1.talkMaxDuration)

			if var_218_3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_3 + var_218_12 then
				local var_218_13 = (arg_215_1.time_ - var_218_3) / var_218_12

				arg_215_1.fswtw_.percent = Mathf.Lerp(arg_215_1.var_.oldValueTypewriter, var_218_8, var_218_13)
				arg_215_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_215_1.fswtw_:SetDirty()
			end

			if arg_215_1.time_ >= var_218_3 + var_218_12 and arg_215_1.time_ < var_218_3 + var_218_12 + arg_218_0 then
				arg_215_1.fswtw_.percent = var_218_8

				arg_215_1.fswtw_:SetDirty()
				arg_215_1:ShowNextGo(true)

				arg_215_1.typewritterCharCountI18N = var_218_9
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play319391052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 319391052
		arg_219_1.duration_ = 8.52

		local var_219_0 = {
			zh = 7.516,
			ja = 8.516
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play319391053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				local var_222_1 = manager.ui.mainCamera.transform.localPosition
				local var_222_2 = Vector3.New(0, 0, 10) + Vector3.New(var_222_1.x, var_222_1.y, 0)
				local var_222_3 = arg_219_1.bgs_.ST72

				var_222_3.transform.localPosition = var_222_2
				var_222_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_222_4 = var_222_3:GetComponent("SpriteRenderer")

				if var_222_4 and var_222_4.sprite then
					local var_222_5 = (var_222_3.transform.localPosition - var_222_1).z
					local var_222_6 = manager.ui.mainCameraCom_
					local var_222_7 = 2 * var_222_5 * Mathf.Tan(var_222_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_222_8 = var_222_7 * var_222_6.aspect
					local var_222_9 = var_222_4.sprite.bounds.size.x
					local var_222_10 = var_222_4.sprite.bounds.size.y
					local var_222_11 = var_222_8 / var_222_9
					local var_222_12 = var_222_7 / var_222_10
					local var_222_13 = var_222_12 < var_222_11 and var_222_11 or var_222_12

					var_222_3.transform.localScale = Vector3.New(var_222_13, var_222_13, 0)
				end

				for iter_222_0, iter_222_1 in pairs(arg_219_1.bgs_) do
					if iter_222_0 ~= "ST72" then
						iter_222_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_222_14 = arg_219_1.actors_["1084ui_story"].transform
			local var_222_15 = 1.73333333333333

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1.var_.moveOldPos1084ui_story = var_222_14.localPosition
			end

			local var_222_16 = 0.001

			if var_222_15 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_16 then
				local var_222_17 = (arg_219_1.time_ - var_222_15) / var_222_16
				local var_222_18 = Vector3.New(0, -0.97, -6)

				var_222_14.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos1084ui_story, var_222_18, var_222_17)

				local var_222_19 = manager.ui.mainCamera.transform.position - var_222_14.position

				var_222_14.forward = Vector3.New(var_222_19.x, var_222_19.y, var_222_19.z)

				local var_222_20 = var_222_14.localEulerAngles

				var_222_20.z = 0
				var_222_20.x = 0
				var_222_14.localEulerAngles = var_222_20
			end

			if arg_219_1.time_ >= var_222_15 + var_222_16 and arg_219_1.time_ < var_222_15 + var_222_16 + arg_222_0 then
				var_222_14.localPosition = Vector3.New(0, -0.97, -6)

				local var_222_21 = manager.ui.mainCamera.transform.position - var_222_14.position

				var_222_14.forward = Vector3.New(var_222_21.x, var_222_21.y, var_222_21.z)

				local var_222_22 = var_222_14.localEulerAngles

				var_222_22.z = 0
				var_222_22.x = 0
				var_222_14.localEulerAngles = var_222_22
			end

			local var_222_23 = arg_219_1.actors_["1084ui_story"]
			local var_222_24 = 1.73333333333333

			if var_222_24 < arg_219_1.time_ and arg_219_1.time_ <= var_222_24 + arg_222_0 and not isNil(var_222_23) and arg_219_1.var_.characterEffect1084ui_story == nil then
				arg_219_1.var_.characterEffect1084ui_story = var_222_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_25 = 0.200000002980232

			if var_222_24 <= arg_219_1.time_ and arg_219_1.time_ < var_222_24 + var_222_25 and not isNil(var_222_23) then
				local var_222_26 = (arg_219_1.time_ - var_222_24) / var_222_25

				if arg_219_1.var_.characterEffect1084ui_story and not isNil(var_222_23) then
					arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_24 + var_222_25 and arg_219_1.time_ < var_222_24 + var_222_25 + arg_222_0 and not isNil(var_222_23) and arg_219_1.var_.characterEffect1084ui_story then
				arg_219_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_222_27 = 1.73333333333333

			if var_222_27 < arg_219_1.time_ and arg_219_1.time_ <= var_222_27 + arg_222_0 then
				arg_219_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_222_28 = 0

			if var_222_28 < arg_219_1.time_ and arg_219_1.time_ <= var_222_28 + arg_222_0 then
				arg_219_1.fswbg_:SetActive(false)
				arg_219_1.dialog_:SetActive(false)
				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_29 = 0.300000000000001

			if var_222_29 < arg_219_1.time_ and arg_219_1.time_ <= var_222_29 + arg_222_0 then
				arg_219_1.fswbg_:SetActive(false)
				arg_219_1.dialog_:SetActive(false)
				SetActive(arg_219_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_219_1:ShowNextGo(false)
			end

			local var_222_30 = 0

			if var_222_30 < arg_219_1.time_ and arg_219_1.time_ <= var_222_30 + arg_222_0 then
				arg_219_1.cswbg_:SetActive(false)
			end

			if arg_219_1.frameCnt_ <= 1 then
				arg_219_1.dialog_:SetActive(false)
			end

			local var_222_31 = 1.25
			local var_222_32 = 0.75

			if var_222_31 < arg_219_1.time_ and arg_219_1.time_ <= var_222_31 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0

				arg_219_1.dialog_:SetActive(true)

				arg_219_1.dialogCg_.alpha = 0

				local var_222_33 = LeanTween.value(arg_219_1.dialog_, 0, 1, 0.3)

				var_222_33:setOnUpdate(LuaHelper.FloatAction(function(arg_223_0)
					arg_219_1.dialogCg_.alpha = arg_223_0
				end))
				var_222_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_219_1.dialog_)
					var_222_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_219_1.duration_ = arg_219_1.duration_ + 0.3

				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_34 = arg_219_1:FormatText(StoryNameCfg[6].name)

				arg_219_1.leftNameTxt_.text = var_222_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_35 = arg_219_1:GetWordFromCfg(319391052)
				local var_222_36 = arg_219_1:FormatText(var_222_35.content)

				arg_219_1.text_.text = var_222_36

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_37 = 30
				local var_222_38 = utf8.len(var_222_36)
				local var_222_39 = var_222_37 <= 0 and var_222_32 or var_222_32 * (var_222_38 / var_222_37)

				if var_222_39 > 0 and var_222_32 < var_222_39 then
					arg_219_1.talkMaxDuration = var_222_39
					var_222_31 = var_222_31 + 0.3

					if var_222_39 + var_222_31 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_39 + var_222_31
					end
				end

				arg_219_1.text_.text = var_222_36
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391052", "story_v_out_319391.awb") ~= 0 then
					local var_222_40 = manager.audio:GetVoiceLength("story_v_out_319391", "319391052", "story_v_out_319391.awb") / 1000

					if var_222_40 + var_222_31 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_40 + var_222_31
					end

					if var_222_35.prefab_name ~= "" and arg_219_1.actors_[var_222_35.prefab_name] ~= nil then
						local var_222_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_35.prefab_name].transform, "story_v_out_319391", "319391052", "story_v_out_319391.awb")

						arg_219_1:RecordAudio("319391052", var_222_41)
						arg_219_1:RecordAudio("319391052", var_222_41)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_319391", "319391052", "story_v_out_319391.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_319391", "319391052", "story_v_out_319391.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_42 = var_222_31 + 0.3
			local var_222_43 = math.max(var_222_32, arg_219_1.talkMaxDuration)

			if var_222_42 <= arg_219_1.time_ and arg_219_1.time_ < var_222_42 + var_222_43 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_42) / var_222_43

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_42 + var_222_43 and arg_219_1.time_ < var_222_42 + var_222_43 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play319391053 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 319391053
		arg_225_1.duration_ = 7.37

		local var_225_0 = {
			zh = 2.066,
			ja = 7.366
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
				arg_225_0:Play319391054(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1084ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1084ui_story == nil then
				arg_225_1.var_.characterEffect1084ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect1084ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_225_1.var_.characterEffect1084ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect1084ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_225_1.var_.characterEffect1084ui_story.fillRatio = var_228_5
			end

			local var_228_6 = arg_225_1.actors_["10069ui_story"]
			local var_228_7 = 0

			if var_228_7 < arg_225_1.time_ and arg_225_1.time_ <= var_228_7 + arg_228_0 and not isNil(var_228_6) and arg_225_1.var_.characterEffect10069ui_story == nil then
				arg_225_1.var_.characterEffect10069ui_story = var_228_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_8 = 0.200000002980232

			if var_228_7 <= arg_225_1.time_ and arg_225_1.time_ < var_228_7 + var_228_8 and not isNil(var_228_6) then
				local var_228_9 = (arg_225_1.time_ - var_228_7) / var_228_8

				if arg_225_1.var_.characterEffect10069ui_story and not isNil(var_228_6) then
					arg_225_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= var_228_7 + var_228_8 and arg_225_1.time_ < var_228_7 + var_228_8 + arg_228_0 and not isNil(var_228_6) and arg_225_1.var_.characterEffect10069ui_story then
				arg_225_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_228_10 = arg_225_1.actors_["10069ui_story"].transform
			local var_228_11 = 0

			if var_228_11 < arg_225_1.time_ and arg_225_1.time_ <= var_228_11 + arg_228_0 then
				arg_225_1.var_.moveOldPos10069ui_story = var_228_10.localPosition
			end

			local var_228_12 = 0.001

			if var_228_11 <= arg_225_1.time_ and arg_225_1.time_ < var_228_11 + var_228_12 then
				local var_228_13 = (arg_225_1.time_ - var_228_11) / var_228_12
				local var_228_14 = Vector3.New(0.7, -1.08, -6.33)

				var_228_10.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos10069ui_story, var_228_14, var_228_13)

				local var_228_15 = manager.ui.mainCamera.transform.position - var_228_10.position

				var_228_10.forward = Vector3.New(var_228_15.x, var_228_15.y, var_228_15.z)

				local var_228_16 = var_228_10.localEulerAngles

				var_228_16.z = 0
				var_228_16.x = 0
				var_228_10.localEulerAngles = var_228_16
			end

			if arg_225_1.time_ >= var_228_11 + var_228_12 and arg_225_1.time_ < var_228_11 + var_228_12 + arg_228_0 then
				var_228_10.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_228_17 = manager.ui.mainCamera.transform.position - var_228_10.position

				var_228_10.forward = Vector3.New(var_228_17.x, var_228_17.y, var_228_17.z)

				local var_228_18 = var_228_10.localEulerAngles

				var_228_18.z = 0
				var_228_18.x = 0
				var_228_10.localEulerAngles = var_228_18
			end

			local var_228_19 = arg_225_1.actors_["1084ui_story"].transform
			local var_228_20 = 0

			if var_228_20 < arg_225_1.time_ and arg_225_1.time_ <= var_228_20 + arg_228_0 then
				arg_225_1.var_.moveOldPos1084ui_story = var_228_19.localPosition
			end

			local var_228_21 = 0.001

			if var_228_20 <= arg_225_1.time_ and arg_225_1.time_ < var_228_20 + var_228_21 then
				local var_228_22 = (arg_225_1.time_ - var_228_20) / var_228_21
				local var_228_23 = Vector3.New(-0.7, -0.97, -6)

				var_228_19.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1084ui_story, var_228_23, var_228_22)

				local var_228_24 = manager.ui.mainCamera.transform.position - var_228_19.position

				var_228_19.forward = Vector3.New(var_228_24.x, var_228_24.y, var_228_24.z)

				local var_228_25 = var_228_19.localEulerAngles

				var_228_25.z = 0
				var_228_25.x = 0
				var_228_19.localEulerAngles = var_228_25
			end

			if arg_225_1.time_ >= var_228_20 + var_228_21 and arg_225_1.time_ < var_228_20 + var_228_21 + arg_228_0 then
				var_228_19.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_228_26 = manager.ui.mainCamera.transform.position - var_228_19.position

				var_228_19.forward = Vector3.New(var_228_26.x, var_228_26.y, var_228_26.z)

				local var_228_27 = var_228_19.localEulerAngles

				var_228_27.z = 0
				var_228_27.x = 0
				var_228_19.localEulerAngles = var_228_27
			end

			local var_228_28 = 0
			local var_228_29 = 0.25

			if var_228_28 < arg_225_1.time_ and arg_225_1.time_ <= var_228_28 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_30 = arg_225_1:FormatText(StoryNameCfg[693].name)

				arg_225_1.leftNameTxt_.text = var_228_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_31 = arg_225_1:GetWordFromCfg(319391053)
				local var_228_32 = arg_225_1:FormatText(var_228_31.content)

				arg_225_1.text_.text = var_228_32

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_33 = 10
				local var_228_34 = utf8.len(var_228_32)
				local var_228_35 = var_228_33 <= 0 and var_228_29 or var_228_29 * (var_228_34 / var_228_33)

				if var_228_35 > 0 and var_228_29 < var_228_35 then
					arg_225_1.talkMaxDuration = var_228_35

					if var_228_35 + var_228_28 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_35 + var_228_28
					end
				end

				arg_225_1.text_.text = var_228_32
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391053", "story_v_out_319391.awb") ~= 0 then
					local var_228_36 = manager.audio:GetVoiceLength("story_v_out_319391", "319391053", "story_v_out_319391.awb") / 1000

					if var_228_36 + var_228_28 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_36 + var_228_28
					end

					if var_228_31.prefab_name ~= "" and arg_225_1.actors_[var_228_31.prefab_name] ~= nil then
						local var_228_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_225_1.actors_[var_228_31.prefab_name].transform, "story_v_out_319391", "319391053", "story_v_out_319391.awb")

						arg_225_1:RecordAudio("319391053", var_228_37)
						arg_225_1:RecordAudio("319391053", var_228_37)
					else
						arg_225_1:AudioAction("play", "voice", "story_v_out_319391", "319391053", "story_v_out_319391.awb")
					end

					arg_225_1:RecordHistoryTalkVoice("story_v_out_319391", "319391053", "story_v_out_319391.awb")
				end

				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_38 = math.max(var_228_29, arg_225_1.talkMaxDuration)

			if var_228_28 <= arg_225_1.time_ and arg_225_1.time_ < var_228_28 + var_228_38 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_28) / var_228_38

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_28 + var_228_38 and arg_225_1.time_ < var_228_28 + var_228_38 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
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

		arg_225_1:InitPlayNodeList()
	end,
	Play319391054 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 319391054
		arg_229_1.duration_ = 6.1

		local var_229_0 = {
			zh = 6.1,
			ja = 5.4
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
				arg_229_0:Play319391055(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = arg_229_1.actors_["1084ui_story"]
			local var_232_1 = 0

			if var_232_1 < arg_229_1.time_ and arg_229_1.time_ <= var_232_1 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1084ui_story == nil then
				arg_229_1.var_.characterEffect1084ui_story = var_232_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if var_232_1 <= arg_229_1.time_ and arg_229_1.time_ < var_232_1 + var_232_2 and not isNil(var_232_0) then
				local var_232_3 = (arg_229_1.time_ - var_232_1) / var_232_2

				if arg_229_1.var_.characterEffect1084ui_story and not isNil(var_232_0) then
					arg_229_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= var_232_1 + var_232_2 and arg_229_1.time_ < var_232_1 + var_232_2 + arg_232_0 and not isNil(var_232_0) and arg_229_1.var_.characterEffect1084ui_story then
				arg_229_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_232_4 = arg_229_1.actors_["10069ui_story"]
			local var_232_5 = 0

			if var_232_5 < arg_229_1.time_ and arg_229_1.time_ <= var_232_5 + arg_232_0 and not isNil(var_232_4) and arg_229_1.var_.characterEffect10069ui_story == nil then
				arg_229_1.var_.characterEffect10069ui_story = var_232_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_6 = 0.200000002980232

			if var_232_5 <= arg_229_1.time_ and arg_229_1.time_ < var_232_5 + var_232_6 and not isNil(var_232_4) then
				local var_232_7 = (arg_229_1.time_ - var_232_5) / var_232_6

				if arg_229_1.var_.characterEffect10069ui_story and not isNil(var_232_4) then
					local var_232_8 = Mathf.Lerp(0, 0.5, var_232_7)

					arg_229_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_229_1.var_.characterEffect10069ui_story.fillRatio = var_232_8
				end
			end

			if arg_229_1.time_ >= var_232_5 + var_232_6 and arg_229_1.time_ < var_232_5 + var_232_6 + arg_232_0 and not isNil(var_232_4) and arg_229_1.var_.characterEffect10069ui_story then
				local var_232_9 = 0.5

				arg_229_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_229_1.var_.characterEffect10069ui_story.fillRatio = var_232_9
			end

			local var_232_10 = 0

			if var_232_10 < arg_229_1.time_ and arg_229_1.time_ <= var_232_10 + arg_232_0 then
				arg_229_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action435")
			end

			local var_232_11 = 0
			local var_232_12 = 0.675

			if var_232_11 < arg_229_1.time_ and arg_229_1.time_ <= var_232_11 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_13 = arg_229_1:FormatText(StoryNameCfg[6].name)

				arg_229_1.leftNameTxt_.text = var_232_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_14 = arg_229_1:GetWordFromCfg(319391054)
				local var_232_15 = arg_229_1:FormatText(var_232_14.content)

				arg_229_1.text_.text = var_232_15

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_16 = 27
				local var_232_17 = utf8.len(var_232_15)
				local var_232_18 = var_232_16 <= 0 and var_232_12 or var_232_12 * (var_232_17 / var_232_16)

				if var_232_18 > 0 and var_232_12 < var_232_18 then
					arg_229_1.talkMaxDuration = var_232_18

					if var_232_18 + var_232_11 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_18 + var_232_11
					end
				end

				arg_229_1.text_.text = var_232_15
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391054", "story_v_out_319391.awb") ~= 0 then
					local var_232_19 = manager.audio:GetVoiceLength("story_v_out_319391", "319391054", "story_v_out_319391.awb") / 1000

					if var_232_19 + var_232_11 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_19 + var_232_11
					end

					if var_232_14.prefab_name ~= "" and arg_229_1.actors_[var_232_14.prefab_name] ~= nil then
						local var_232_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_14.prefab_name].transform, "story_v_out_319391", "319391054", "story_v_out_319391.awb")

						arg_229_1:RecordAudio("319391054", var_232_20)
						arg_229_1:RecordAudio("319391054", var_232_20)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_319391", "319391054", "story_v_out_319391.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_319391", "319391054", "story_v_out_319391.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_21 = math.max(var_232_12, arg_229_1.talkMaxDuration)

			if var_232_11 <= arg_229_1.time_ and arg_229_1.time_ < var_232_11 + var_232_21 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_11) / var_232_21

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_11 + var_232_21 and arg_229_1.time_ < var_232_11 + var_232_21 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play319391055 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 319391055
		arg_233_1.duration_ = 5.37

		local var_233_0 = {
			zh = 2.333,
			ja = 5.366
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
				arg_233_0:Play319391056(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10069ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos10069ui_story = var_236_0.localPosition
			end

			local var_236_2 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2
				local var_236_4 = Vector3.New(0.7, -1.08, -6.33)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10069ui_story, var_236_4, var_236_3)

				local var_236_5 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_5.x, var_236_5.y, var_236_5.z)

				local var_236_6 = var_236_0.localEulerAngles

				var_236_6.z = 0
				var_236_6.x = 0
				var_236_0.localEulerAngles = var_236_6
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_236_7 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_7.x, var_236_7.y, var_236_7.z)

				local var_236_8 = var_236_0.localEulerAngles

				var_236_8.z = 0
				var_236_8.x = 0
				var_236_0.localEulerAngles = var_236_8
			end

			local var_236_9 = arg_233_1.actors_["10069ui_story"]
			local var_236_10 = 0

			if var_236_10 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect10069ui_story == nil then
				arg_233_1.var_.characterEffect10069ui_story = var_236_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_11 = 0.200000002980232

			if var_236_10 <= arg_233_1.time_ and arg_233_1.time_ < var_236_10 + var_236_11 and not isNil(var_236_9) then
				local var_236_12 = (arg_233_1.time_ - var_236_10) / var_236_11

				if arg_233_1.var_.characterEffect10069ui_story and not isNil(var_236_9) then
					arg_233_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_10 + var_236_11 and arg_233_1.time_ < var_236_10 + var_236_11 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect10069ui_story then
				arg_233_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_236_13 = 0

			if var_236_13 < arg_233_1.time_ and arg_233_1.time_ <= var_236_13 + arg_236_0 then
				arg_233_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action2_1")
			end

			local var_236_14 = 0

			if var_236_14 < arg_233_1.time_ and arg_233_1.time_ <= var_236_14 + arg_236_0 then
				arg_233_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_236_15 = arg_233_1.actors_["1084ui_story"]
			local var_236_16 = 0

			if var_236_16 < arg_233_1.time_ and arg_233_1.time_ <= var_236_16 + arg_236_0 and not isNil(var_236_15) and arg_233_1.var_.characterEffect1084ui_story == nil then
				arg_233_1.var_.characterEffect1084ui_story = var_236_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_17 = 0.200000002980232

			if var_236_16 <= arg_233_1.time_ and arg_233_1.time_ < var_236_16 + var_236_17 and not isNil(var_236_15) then
				local var_236_18 = (arg_233_1.time_ - var_236_16) / var_236_17

				if arg_233_1.var_.characterEffect1084ui_story and not isNil(var_236_15) then
					local var_236_19 = Mathf.Lerp(0, 0.5, var_236_18)

					arg_233_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_233_1.var_.characterEffect1084ui_story.fillRatio = var_236_19
				end
			end

			if arg_233_1.time_ >= var_236_16 + var_236_17 and arg_233_1.time_ < var_236_16 + var_236_17 + arg_236_0 and not isNil(var_236_15) and arg_233_1.var_.characterEffect1084ui_story then
				local var_236_20 = 0.5

				arg_233_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_233_1.var_.characterEffect1084ui_story.fillRatio = var_236_20
			end

			local var_236_21 = 0
			local var_236_22 = 0.3

			if var_236_21 < arg_233_1.time_ and arg_233_1.time_ <= var_236_21 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_23 = arg_233_1:FormatText(StoryNameCfg[693].name)

				arg_233_1.leftNameTxt_.text = var_236_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_24 = arg_233_1:GetWordFromCfg(319391055)
				local var_236_25 = arg_233_1:FormatText(var_236_24.content)

				arg_233_1.text_.text = var_236_25

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_26 = 12
				local var_236_27 = utf8.len(var_236_25)
				local var_236_28 = var_236_26 <= 0 and var_236_22 or var_236_22 * (var_236_27 / var_236_26)

				if var_236_28 > 0 and var_236_22 < var_236_28 then
					arg_233_1.talkMaxDuration = var_236_28

					if var_236_28 + var_236_21 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_28 + var_236_21
					end
				end

				arg_233_1.text_.text = var_236_25
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391055", "story_v_out_319391.awb") ~= 0 then
					local var_236_29 = manager.audio:GetVoiceLength("story_v_out_319391", "319391055", "story_v_out_319391.awb") / 1000

					if var_236_29 + var_236_21 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_29 + var_236_21
					end

					if var_236_24.prefab_name ~= "" and arg_233_1.actors_[var_236_24.prefab_name] ~= nil then
						local var_236_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_24.prefab_name].transform, "story_v_out_319391", "319391055", "story_v_out_319391.awb")

						arg_233_1:RecordAudio("319391055", var_236_30)
						arg_233_1:RecordAudio("319391055", var_236_30)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_319391", "319391055", "story_v_out_319391.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_319391", "319391055", "story_v_out_319391.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_31 = math.max(var_236_22, arg_233_1.talkMaxDuration)

			if var_236_21 <= arg_233_1.time_ and arg_233_1.time_ < var_236_21 + var_236_31 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_21) / var_236_31

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_21 + var_236_31 and arg_233_1.time_ < var_236_21 + var_236_31 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
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

		arg_233_1:InitPlayNodeList()
	end,
	Play319391056 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 319391056
		arg_237_1.duration_ = 13.17

		local var_237_0 = {
			zh = 9.866,
			ja = 13.166
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
				arg_237_0:Play319391057(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 1.275

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[693].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:GetWordFromCfg(319391056)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 51
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

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391056", "story_v_out_319391.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_out_319391", "319391056", "story_v_out_319391.awb") / 1000

					if var_240_8 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_0
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_319391", "319391056", "story_v_out_319391.awb")

						arg_237_1:RecordAudio("319391056", var_240_9)
						arg_237_1:RecordAudio("319391056", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_319391", "319391056", "story_v_out_319391.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_319391", "319391056", "story_v_out_319391.awb")
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
	Play319391057 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 319391057
		arg_241_1.duration_ = 6.67

		local var_241_0 = {
			zh = 3.666,
			ja = 6.666
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
				arg_241_0:Play319391058(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["1084ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1084ui_story == nil then
				arg_241_1.var_.characterEffect1084ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect1084ui_story and not isNil(var_244_0) then
					arg_241_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect1084ui_story then
				arg_241_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_244_4 = arg_241_1.actors_["10069ui_story"]
			local var_244_5 = 0

			if var_244_5 < arg_241_1.time_ and arg_241_1.time_ <= var_244_5 + arg_244_0 and not isNil(var_244_4) and arg_241_1.var_.characterEffect10069ui_story == nil then
				arg_241_1.var_.characterEffect10069ui_story = var_244_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_6 = 0.200000002980232

			if var_244_5 <= arg_241_1.time_ and arg_241_1.time_ < var_244_5 + var_244_6 and not isNil(var_244_4) then
				local var_244_7 = (arg_241_1.time_ - var_244_5) / var_244_6

				if arg_241_1.var_.characterEffect10069ui_story and not isNil(var_244_4) then
					local var_244_8 = Mathf.Lerp(0, 0.5, var_244_7)

					arg_241_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_241_1.var_.characterEffect10069ui_story.fillRatio = var_244_8
				end
			end

			if arg_241_1.time_ >= var_244_5 + var_244_6 and arg_241_1.time_ < var_244_5 + var_244_6 + arg_244_0 and not isNil(var_244_4) and arg_241_1.var_.characterEffect10069ui_story then
				local var_244_9 = 0.5

				arg_241_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_241_1.var_.characterEffect10069ui_story.fillRatio = var_244_9
			end

			local var_244_10 = 0

			if var_244_10 < arg_241_1.time_ and arg_241_1.time_ <= var_244_10 + arg_244_0 then
				arg_241_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			local var_244_11 = 0
			local var_244_12 = 0.25

			if var_244_11 < arg_241_1.time_ and arg_241_1.time_ <= var_244_11 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_13 = arg_241_1:FormatText(StoryNameCfg[6].name)

				arg_241_1.leftNameTxt_.text = var_244_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_14 = arg_241_1:GetWordFromCfg(319391057)
				local var_244_15 = arg_241_1:FormatText(var_244_14.content)

				arg_241_1.text_.text = var_244_15

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_16 = 10
				local var_244_17 = utf8.len(var_244_15)
				local var_244_18 = var_244_16 <= 0 and var_244_12 or var_244_12 * (var_244_17 / var_244_16)

				if var_244_18 > 0 and var_244_12 < var_244_18 then
					arg_241_1.talkMaxDuration = var_244_18

					if var_244_18 + var_244_11 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_18 + var_244_11
					end
				end

				arg_241_1.text_.text = var_244_15
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391057", "story_v_out_319391.awb") ~= 0 then
					local var_244_19 = manager.audio:GetVoiceLength("story_v_out_319391", "319391057", "story_v_out_319391.awb") / 1000

					if var_244_19 + var_244_11 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_19 + var_244_11
					end

					if var_244_14.prefab_name ~= "" and arg_241_1.actors_[var_244_14.prefab_name] ~= nil then
						local var_244_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_14.prefab_name].transform, "story_v_out_319391", "319391057", "story_v_out_319391.awb")

						arg_241_1:RecordAudio("319391057", var_244_20)
						arg_241_1:RecordAudio("319391057", var_244_20)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_319391", "319391057", "story_v_out_319391.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_319391", "319391057", "story_v_out_319391.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_21 = math.max(var_244_12, arg_241_1.talkMaxDuration)

			if var_244_11 <= arg_241_1.time_ and arg_241_1.time_ < var_244_11 + var_244_21 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_11) / var_244_21

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_11 + var_244_21 and arg_241_1.time_ < var_244_11 + var_244_21 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play319391058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 319391058
		arg_245_1.duration_ = 7.1

		local var_245_0 = {
			zh = 4.366,
			ja = 7.1
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
				arg_245_0:Play319391059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1084ui_story"]
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1084ui_story == nil then
				arg_245_1.var_.characterEffect1084ui_story = var_248_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_2 = 0.200000002980232

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 and not isNil(var_248_0) then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2

				if arg_245_1.var_.characterEffect1084ui_story and not isNil(var_248_0) then
					local var_248_4 = Mathf.Lerp(0, 0.5, var_248_3)

					arg_245_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1084ui_story.fillRatio = var_248_4
				end
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 and not isNil(var_248_0) and arg_245_1.var_.characterEffect1084ui_story then
				local var_248_5 = 0.5

				arg_245_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1084ui_story.fillRatio = var_248_5
			end

			local var_248_6 = arg_245_1.actors_["10069ui_story"]
			local var_248_7 = 0

			if var_248_7 < arg_245_1.time_ and arg_245_1.time_ <= var_248_7 + arg_248_0 and not isNil(var_248_6) and arg_245_1.var_.characterEffect10069ui_story == nil then
				arg_245_1.var_.characterEffect10069ui_story = var_248_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_8 = 0.200000002980232

			if var_248_7 <= arg_245_1.time_ and arg_245_1.time_ < var_248_7 + var_248_8 and not isNil(var_248_6) then
				local var_248_9 = (arg_245_1.time_ - var_248_7) / var_248_8

				if arg_245_1.var_.characterEffect10069ui_story and not isNil(var_248_6) then
					arg_245_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_7 + var_248_8 and arg_245_1.time_ < var_248_7 + var_248_8 + arg_248_0 and not isNil(var_248_6) and arg_245_1.var_.characterEffect10069ui_story then
				arg_245_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_248_10 = 0
			local var_248_11 = 0.575

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_12 = arg_245_1:FormatText(StoryNameCfg[693].name)

				arg_245_1.leftNameTxt_.text = var_248_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_13 = arg_245_1:GetWordFromCfg(319391058)
				local var_248_14 = arg_245_1:FormatText(var_248_13.content)

				arg_245_1.text_.text = var_248_14

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_15 = 23
				local var_248_16 = utf8.len(var_248_14)
				local var_248_17 = var_248_15 <= 0 and var_248_11 or var_248_11 * (var_248_16 / var_248_15)

				if var_248_17 > 0 and var_248_11 < var_248_17 then
					arg_245_1.talkMaxDuration = var_248_17

					if var_248_17 + var_248_10 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_17 + var_248_10
					end
				end

				arg_245_1.text_.text = var_248_14
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391058", "story_v_out_319391.awb") ~= 0 then
					local var_248_18 = manager.audio:GetVoiceLength("story_v_out_319391", "319391058", "story_v_out_319391.awb") / 1000

					if var_248_18 + var_248_10 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_18 + var_248_10
					end

					if var_248_13.prefab_name ~= "" and arg_245_1.actors_[var_248_13.prefab_name] ~= nil then
						local var_248_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_13.prefab_name].transform, "story_v_out_319391", "319391058", "story_v_out_319391.awb")

						arg_245_1:RecordAudio("319391058", var_248_19)
						arg_245_1:RecordAudio("319391058", var_248_19)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_319391", "319391058", "story_v_out_319391.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_319391", "319391058", "story_v_out_319391.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_20 = math.max(var_248_11, arg_245_1.talkMaxDuration)

			if var_248_10 <= arg_245_1.time_ and arg_245_1.time_ < var_248_10 + var_248_20 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_10) / var_248_20

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_10 + var_248_20 and arg_245_1.time_ < var_248_10 + var_248_20 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play319391059 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 319391059
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play319391060(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["10069ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect10069ui_story == nil then
				arg_249_1.var_.characterEffect10069ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect10069ui_story and not isNil(var_252_0) then
					local var_252_4 = Mathf.Lerp(0, 0.5, var_252_3)

					arg_249_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_249_1.var_.characterEffect10069ui_story.fillRatio = var_252_4
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect10069ui_story then
				local var_252_5 = 0.5

				arg_249_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_249_1.var_.characterEffect10069ui_story.fillRatio = var_252_5
			end

			local var_252_6 = 0
			local var_252_7 = 1.325

			if var_252_6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_8 = arg_249_1:GetWordFromCfg(319391059)
				local var_252_9 = arg_249_1:FormatText(var_252_8.content)

				arg_249_1.text_.text = var_252_9

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_10 = 53
				local var_252_11 = utf8.len(var_252_9)
				local var_252_12 = var_252_10 <= 0 and var_252_7 or var_252_7 * (var_252_11 / var_252_10)

				if var_252_12 > 0 and var_252_7 < var_252_12 then
					arg_249_1.talkMaxDuration = var_252_12

					if var_252_12 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_12 + var_252_6
					end
				end

				arg_249_1.text_.text = var_252_9
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_13 = math.max(var_252_7, arg_249_1.talkMaxDuration)

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_13 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_6) / var_252_13

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_6 + var_252_13 and arg_249_1.time_ < var_252_6 + var_252_13 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play319391060 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 319391060
		arg_253_1.duration_ = 10.7

		local var_253_0 = {
			zh = 7.166,
			ja = 10.7
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
				arg_253_0:Play319391061(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = arg_253_1.actors_["10069ui_story"]
			local var_256_1 = 0

			if var_256_1 < arg_253_1.time_ and arg_253_1.time_ <= var_256_1 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect10069ui_story == nil then
				arg_253_1.var_.characterEffect10069ui_story = var_256_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if var_256_1 <= arg_253_1.time_ and arg_253_1.time_ < var_256_1 + var_256_2 and not isNil(var_256_0) then
				local var_256_3 = (arg_253_1.time_ - var_256_1) / var_256_2

				if arg_253_1.var_.characterEffect10069ui_story and not isNil(var_256_0) then
					arg_253_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= var_256_1 + var_256_2 and arg_253_1.time_ < var_256_1 + var_256_2 + arg_256_0 and not isNil(var_256_0) and arg_253_1.var_.characterEffect10069ui_story then
				arg_253_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_256_4 = 0

			if var_256_4 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action2_2")
			end

			local var_256_5 = 0

			if var_256_5 < arg_253_1.time_ and arg_253_1.time_ <= var_256_5 + arg_256_0 then
				arg_253_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_256_6 = 0
			local var_256_7 = 0.75

			if var_256_6 < arg_253_1.time_ and arg_253_1.time_ <= var_256_6 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_8 = arg_253_1:FormatText(StoryNameCfg[693].name)

				arg_253_1.leftNameTxt_.text = var_256_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_9 = arg_253_1:GetWordFromCfg(319391060)
				local var_256_10 = arg_253_1:FormatText(var_256_9.content)

				arg_253_1.text_.text = var_256_10

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_11 = 30
				local var_256_12 = utf8.len(var_256_10)
				local var_256_13 = var_256_11 <= 0 and var_256_7 or var_256_7 * (var_256_12 / var_256_11)

				if var_256_13 > 0 and var_256_7 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_6
					end
				end

				arg_253_1.text_.text = var_256_10
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391060", "story_v_out_319391.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_out_319391", "319391060", "story_v_out_319391.awb") / 1000

					if var_256_14 + var_256_6 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_6
					end

					if var_256_9.prefab_name ~= "" and arg_253_1.actors_[var_256_9.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_9.prefab_name].transform, "story_v_out_319391", "319391060", "story_v_out_319391.awb")

						arg_253_1:RecordAudio("319391060", var_256_15)
						arg_253_1:RecordAudio("319391060", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_319391", "319391060", "story_v_out_319391.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_319391", "319391060", "story_v_out_319391.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_16 = math.max(var_256_7, arg_253_1.talkMaxDuration)

			if var_256_6 <= arg_253_1.time_ and arg_253_1.time_ < var_256_6 + var_256_16 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_6) / var_256_16

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_6 + var_256_16 and arg_253_1.time_ < var_256_6 + var_256_16 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play319391061 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 319391061
		arg_257_1.duration_ = 5.53

		local var_257_0 = {
			zh = 2.933,
			ja = 5.533
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
				arg_257_0:Play319391062(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = arg_257_1.actors_["1084ui_story"]
			local var_260_1 = 0

			if var_260_1 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1084ui_story == nil then
				arg_257_1.var_.characterEffect1084ui_story = var_260_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_2 = 0.200000002980232

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_2 and not isNil(var_260_0) then
				local var_260_3 = (arg_257_1.time_ - var_260_1) / var_260_2

				if arg_257_1.var_.characterEffect1084ui_story and not isNil(var_260_0) then
					arg_257_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= var_260_1 + var_260_2 and arg_257_1.time_ < var_260_1 + var_260_2 + arg_260_0 and not isNil(var_260_0) and arg_257_1.var_.characterEffect1084ui_story then
				arg_257_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_260_4 = arg_257_1.actors_["10069ui_story"]
			local var_260_5 = 0

			if var_260_5 < arg_257_1.time_ and arg_257_1.time_ <= var_260_5 + arg_260_0 and not isNil(var_260_4) and arg_257_1.var_.characterEffect10069ui_story == nil then
				arg_257_1.var_.characterEffect10069ui_story = var_260_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_6 = 0.200000002980232

			if var_260_5 <= arg_257_1.time_ and arg_257_1.time_ < var_260_5 + var_260_6 and not isNil(var_260_4) then
				local var_260_7 = (arg_257_1.time_ - var_260_5) / var_260_6

				if arg_257_1.var_.characterEffect10069ui_story and not isNil(var_260_4) then
					local var_260_8 = Mathf.Lerp(0, 0.5, var_260_7)

					arg_257_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_257_1.var_.characterEffect10069ui_story.fillRatio = var_260_8
				end
			end

			if arg_257_1.time_ >= var_260_5 + var_260_6 and arg_257_1.time_ < var_260_5 + var_260_6 + arg_260_0 and not isNil(var_260_4) and arg_257_1.var_.characterEffect10069ui_story then
				local var_260_9 = 0.5

				arg_257_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_257_1.var_.characterEffect10069ui_story.fillRatio = var_260_9
			end

			local var_260_10 = 0

			if var_260_10 < arg_257_1.time_ and arg_257_1.time_ <= var_260_10 + arg_260_0 then
				arg_257_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_260_11 = 0

			if var_260_11 < arg_257_1.time_ and arg_257_1.time_ <= var_260_11 + arg_260_0 then
				arg_257_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_260_12 = 0
			local var_260_13 = 0.35

			if var_260_12 < arg_257_1.time_ and arg_257_1.time_ <= var_260_12 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_14 = arg_257_1:FormatText(StoryNameCfg[6].name)

				arg_257_1.leftNameTxt_.text = var_260_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_15 = arg_257_1:GetWordFromCfg(319391061)
				local var_260_16 = arg_257_1:FormatText(var_260_15.content)

				arg_257_1.text_.text = var_260_16

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_17 = 14
				local var_260_18 = utf8.len(var_260_16)
				local var_260_19 = var_260_17 <= 0 and var_260_13 or var_260_13 * (var_260_18 / var_260_17)

				if var_260_19 > 0 and var_260_13 < var_260_19 then
					arg_257_1.talkMaxDuration = var_260_19

					if var_260_19 + var_260_12 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_19 + var_260_12
					end
				end

				arg_257_1.text_.text = var_260_16
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391061", "story_v_out_319391.awb") ~= 0 then
					local var_260_20 = manager.audio:GetVoiceLength("story_v_out_319391", "319391061", "story_v_out_319391.awb") / 1000

					if var_260_20 + var_260_12 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_20 + var_260_12
					end

					if var_260_15.prefab_name ~= "" and arg_257_1.actors_[var_260_15.prefab_name] ~= nil then
						local var_260_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_15.prefab_name].transform, "story_v_out_319391", "319391061", "story_v_out_319391.awb")

						arg_257_1:RecordAudio("319391061", var_260_21)
						arg_257_1:RecordAudio("319391061", var_260_21)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_319391", "319391061", "story_v_out_319391.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_319391", "319391061", "story_v_out_319391.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_22 = math.max(var_260_13, arg_257_1.talkMaxDuration)

			if var_260_12 <= arg_257_1.time_ and arg_257_1.time_ < var_260_12 + var_260_22 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_12) / var_260_22

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_12 + var_260_22 and arg_257_1.time_ < var_260_12 + var_260_22 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play319391062 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 319391062
		arg_261_1.duration_ = 2

		local var_261_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_261_0:Play319391063(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["10069ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos10069ui_story = var_264_0.localPosition
			end

			local var_264_2 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2
				local var_264_4 = Vector3.New(0.7, -1.08, -6.33)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos10069ui_story, var_264_4, var_264_3)

				local var_264_5 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_5.x, var_264_5.y, var_264_5.z)

				local var_264_6 = var_264_0.localEulerAngles

				var_264_6.z = 0
				var_264_6.x = 0
				var_264_0.localEulerAngles = var_264_6
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0.7, -1.08, -6.33)

				local var_264_7 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_7.x, var_264_7.y, var_264_7.z)

				local var_264_8 = var_264_0.localEulerAngles

				var_264_8.z = 0
				var_264_8.x = 0
				var_264_0.localEulerAngles = var_264_8
			end

			local var_264_9 = arg_261_1.actors_["10069ui_story"]
			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect10069ui_story == nil then
				arg_261_1.var_.characterEffect10069ui_story = var_264_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_11 = 0.200000002980232

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_11 and not isNil(var_264_9) then
				local var_264_12 = (arg_261_1.time_ - var_264_10) / var_264_11

				if arg_261_1.var_.characterEffect10069ui_story and not isNil(var_264_9) then
					arg_261_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_10 + var_264_11 and arg_261_1.time_ < var_264_10 + var_264_11 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect10069ui_story then
				arg_261_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_264_13 = 0

			if var_264_13 < arg_261_1.time_ and arg_261_1.time_ <= var_264_13 + arg_264_0 then
				arg_261_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			local var_264_14 = 0

			if var_264_14 < arg_261_1.time_ and arg_261_1.time_ <= var_264_14 + arg_264_0 then
				arg_261_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_264_15 = arg_261_1.actors_["1084ui_story"]
			local var_264_16 = 0

			if var_264_16 < arg_261_1.time_ and arg_261_1.time_ <= var_264_16 + arg_264_0 and not isNil(var_264_15) and arg_261_1.var_.characterEffect1084ui_story == nil then
				arg_261_1.var_.characterEffect1084ui_story = var_264_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_17 = 0.200000002980232

			if var_264_16 <= arg_261_1.time_ and arg_261_1.time_ < var_264_16 + var_264_17 and not isNil(var_264_15) then
				local var_264_18 = (arg_261_1.time_ - var_264_16) / var_264_17

				if arg_261_1.var_.characterEffect1084ui_story and not isNil(var_264_15) then
					local var_264_19 = Mathf.Lerp(0, 0.5, var_264_18)

					arg_261_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1084ui_story.fillRatio = var_264_19
				end
			end

			if arg_261_1.time_ >= var_264_16 + var_264_17 and arg_261_1.time_ < var_264_16 + var_264_17 + arg_264_0 and not isNil(var_264_15) and arg_261_1.var_.characterEffect1084ui_story then
				local var_264_20 = 0.5

				arg_261_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1084ui_story.fillRatio = var_264_20
			end

			local var_264_21 = 0
			local var_264_22 = 0.175

			if var_264_21 < arg_261_1.time_ and arg_261_1.time_ <= var_264_21 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_23 = arg_261_1:FormatText(StoryNameCfg[693].name)

				arg_261_1.leftNameTxt_.text = var_264_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_24 = arg_261_1:GetWordFromCfg(319391062)
				local var_264_25 = arg_261_1:FormatText(var_264_24.content)

				arg_261_1.text_.text = var_264_25

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_26 = 7
				local var_264_27 = utf8.len(var_264_25)
				local var_264_28 = var_264_26 <= 0 and var_264_22 or var_264_22 * (var_264_27 / var_264_26)

				if var_264_28 > 0 and var_264_22 < var_264_28 then
					arg_261_1.talkMaxDuration = var_264_28

					if var_264_28 + var_264_21 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_28 + var_264_21
					end
				end

				arg_261_1.text_.text = var_264_25
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391062", "story_v_out_319391.awb") ~= 0 then
					local var_264_29 = manager.audio:GetVoiceLength("story_v_out_319391", "319391062", "story_v_out_319391.awb") / 1000

					if var_264_29 + var_264_21 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_29 + var_264_21
					end

					if var_264_24.prefab_name ~= "" and arg_261_1.actors_[var_264_24.prefab_name] ~= nil then
						local var_264_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_24.prefab_name].transform, "story_v_out_319391", "319391062", "story_v_out_319391.awb")

						arg_261_1:RecordAudio("319391062", var_264_30)
						arg_261_1:RecordAudio("319391062", var_264_30)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_319391", "319391062", "story_v_out_319391.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_319391", "319391062", "story_v_out_319391.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_31 = math.max(var_264_22, arg_261_1.talkMaxDuration)

			if var_264_21 <= arg_261_1.time_ and arg_261_1.time_ < var_264_21 + var_264_31 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_21) / var_264_31

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_21 + var_264_31 and arg_261_1.time_ < var_264_21 + var_264_31 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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

		arg_261_1:InitPlayNodeList()
	end,
	Play319391063 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 319391063
		arg_265_1.duration_ = 1.33

		local var_265_0 = {
			zh = 0.999999999999,
			ja = 1.333
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
				arg_265_0:Play319391064(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1084ui_story"].transform
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1.var_.moveOldPos1084ui_story = var_268_0.localPosition
			end

			local var_268_2 = 0.001

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2
				local var_268_4 = Vector3.New(-0.7, -0.97, -6)

				var_268_0.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1084ui_story, var_268_4, var_268_3)

				local var_268_5 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_5.x, var_268_5.y, var_268_5.z)

				local var_268_6 = var_268_0.localEulerAngles

				var_268_6.z = 0
				var_268_6.x = 0
				var_268_0.localEulerAngles = var_268_6
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 then
				var_268_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_268_7 = manager.ui.mainCamera.transform.position - var_268_0.position

				var_268_0.forward = Vector3.New(var_268_7.x, var_268_7.y, var_268_7.z)

				local var_268_8 = var_268_0.localEulerAngles

				var_268_8.z = 0
				var_268_8.x = 0
				var_268_0.localEulerAngles = var_268_8
			end

			local var_268_9 = arg_265_1.actors_["1084ui_story"]
			local var_268_10 = 0

			if var_268_10 < arg_265_1.time_ and arg_265_1.time_ <= var_268_10 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect1084ui_story == nil then
				arg_265_1.var_.characterEffect1084ui_story = var_268_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_11 = 0.200000002980232

			if var_268_10 <= arg_265_1.time_ and arg_265_1.time_ < var_268_10 + var_268_11 and not isNil(var_268_9) then
				local var_268_12 = (arg_265_1.time_ - var_268_10) / var_268_11

				if arg_265_1.var_.characterEffect1084ui_story and not isNil(var_268_9) then
					arg_265_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= var_268_10 + var_268_11 and arg_265_1.time_ < var_268_10 + var_268_11 + arg_268_0 and not isNil(var_268_9) and arg_265_1.var_.characterEffect1084ui_story then
				arg_265_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_268_13 = arg_265_1.actors_["10069ui_story"]
			local var_268_14 = 0

			if var_268_14 < arg_265_1.time_ and arg_265_1.time_ <= var_268_14 + arg_268_0 and not isNil(var_268_13) and arg_265_1.var_.characterEffect10069ui_story == nil then
				arg_265_1.var_.characterEffect10069ui_story = var_268_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_15 = 0.200000002980232

			if var_268_14 <= arg_265_1.time_ and arg_265_1.time_ < var_268_14 + var_268_15 and not isNil(var_268_13) then
				local var_268_16 = (arg_265_1.time_ - var_268_14) / var_268_15

				if arg_265_1.var_.characterEffect10069ui_story and not isNil(var_268_13) then
					local var_268_17 = Mathf.Lerp(0, 0.5, var_268_16)

					arg_265_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_265_1.var_.characterEffect10069ui_story.fillRatio = var_268_17
				end
			end

			if arg_265_1.time_ >= var_268_14 + var_268_15 and arg_265_1.time_ < var_268_14 + var_268_15 + arg_268_0 and not isNil(var_268_13) and arg_265_1.var_.characterEffect10069ui_story then
				local var_268_18 = 0.5

				arg_265_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_265_1.var_.characterEffect10069ui_story.fillRatio = var_268_18
			end

			local var_268_19 = 0
			local var_268_20 = 0.05

			if var_268_19 < arg_265_1.time_ and arg_265_1.time_ <= var_268_19 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_21 = arg_265_1:FormatText(StoryNameCfg[6].name)

				arg_265_1.leftNameTxt_.text = var_268_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_22 = arg_265_1:GetWordFromCfg(319391063)
				local var_268_23 = arg_265_1:FormatText(var_268_22.content)

				arg_265_1.text_.text = var_268_23

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_24 = 2
				local var_268_25 = utf8.len(var_268_23)
				local var_268_26 = var_268_24 <= 0 and var_268_20 or var_268_20 * (var_268_25 / var_268_24)

				if var_268_26 > 0 and var_268_20 < var_268_26 then
					arg_265_1.talkMaxDuration = var_268_26

					if var_268_26 + var_268_19 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_26 + var_268_19
					end
				end

				arg_265_1.text_.text = var_268_23
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391063", "story_v_out_319391.awb") ~= 0 then
					local var_268_27 = manager.audio:GetVoiceLength("story_v_out_319391", "319391063", "story_v_out_319391.awb") / 1000

					if var_268_27 + var_268_19 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_27 + var_268_19
					end

					if var_268_22.prefab_name ~= "" and arg_265_1.actors_[var_268_22.prefab_name] ~= nil then
						local var_268_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_22.prefab_name].transform, "story_v_out_319391", "319391063", "story_v_out_319391.awb")

						arg_265_1:RecordAudio("319391063", var_268_28)
						arg_265_1:RecordAudio("319391063", var_268_28)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_319391", "319391063", "story_v_out_319391.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_319391", "319391063", "story_v_out_319391.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_29 = math.max(var_268_20, arg_265_1.talkMaxDuration)

			if var_268_19 <= arg_265_1.time_ and arg_265_1.time_ < var_268_19 + var_268_29 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_19) / var_268_29

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_19 + var_268_29 and arg_265_1.time_ < var_268_19 + var_268_29 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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

		arg_265_1:InitPlayNodeList()
	end,
	Play319391064 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 319391064
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play319391065(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1084ui_story"]
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1084ui_story == nil then
				arg_269_1.var_.characterEffect1084ui_story = var_272_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_2 = 0.200000002980232

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 and not isNil(var_272_0) then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2

				if arg_269_1.var_.characterEffect1084ui_story and not isNil(var_272_0) then
					local var_272_4 = Mathf.Lerp(0, 0.5, var_272_3)

					arg_269_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1084ui_story.fillRatio = var_272_4
				end
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 and not isNil(var_272_0) and arg_269_1.var_.characterEffect1084ui_story then
				local var_272_5 = 0.5

				arg_269_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1084ui_story.fillRatio = var_272_5
			end

			local var_272_6 = 0
			local var_272_7 = 1

			if var_272_6 < arg_269_1.time_ and arg_269_1.time_ <= var_272_6 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, false)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_8 = arg_269_1:GetWordFromCfg(319391064)
				local var_272_9 = arg_269_1:FormatText(var_272_8.content)

				arg_269_1.text_.text = var_272_9

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_10 = 40
				local var_272_11 = utf8.len(var_272_9)
				local var_272_12 = var_272_10 <= 0 and var_272_7 or var_272_7 * (var_272_11 / var_272_10)

				if var_272_12 > 0 and var_272_7 < var_272_12 then
					arg_269_1.talkMaxDuration = var_272_12

					if var_272_12 + var_272_6 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_12 + var_272_6
					end
				end

				arg_269_1.text_.text = var_272_9
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_13 = math.max(var_272_7, arg_269_1.talkMaxDuration)

			if var_272_6 <= arg_269_1.time_ and arg_269_1.time_ < var_272_6 + var_272_13 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_6) / var_272_13

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_6 + var_272_13 and arg_269_1.time_ < var_272_6 + var_272_13 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play319391065 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 319391065
		arg_273_1.duration_ = 8.8

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play319391066(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 2

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				local var_276_1 = manager.ui.mainCamera.transform.localPosition
				local var_276_2 = Vector3.New(0, 0, 10) + Vector3.New(var_276_1.x, var_276_1.y, 0)
				local var_276_3 = arg_273_1.bgs_.ST72

				var_276_3.transform.localPosition = var_276_2
				var_276_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_276_4 = var_276_3:GetComponent("SpriteRenderer")

				if var_276_4 and var_276_4.sprite then
					local var_276_5 = (var_276_3.transform.localPosition - var_276_1).z
					local var_276_6 = manager.ui.mainCameraCom_
					local var_276_7 = 2 * var_276_5 * Mathf.Tan(var_276_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_276_8 = var_276_7 * var_276_6.aspect
					local var_276_9 = var_276_4.sprite.bounds.size.x
					local var_276_10 = var_276_4.sprite.bounds.size.y
					local var_276_11 = var_276_8 / var_276_9
					local var_276_12 = var_276_7 / var_276_10
					local var_276_13 = var_276_12 < var_276_11 and var_276_11 or var_276_12

					var_276_3.transform.localScale = Vector3.New(var_276_13, var_276_13, 0)
				end

				for iter_276_0, iter_276_1 in pairs(arg_273_1.bgs_) do
					if iter_276_0 ~= "ST72" then
						iter_276_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_276_14 = 0

			if var_276_14 < arg_273_1.time_ and arg_273_1.time_ <= var_276_14 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_15 = 2

			if var_276_14 <= arg_273_1.time_ and arg_273_1.time_ < var_276_14 + var_276_15 then
				local var_276_16 = (arg_273_1.time_ - var_276_14) / var_276_15
				local var_276_17 = Color.New(0, 0, 0)

				var_276_17.a = Mathf.Lerp(0, 1, var_276_16)
				arg_273_1.mask_.color = var_276_17
			end

			if arg_273_1.time_ >= var_276_14 + var_276_15 and arg_273_1.time_ < var_276_14 + var_276_15 + arg_276_0 then
				local var_276_18 = Color.New(0, 0, 0)

				var_276_18.a = 1
				arg_273_1.mask_.color = var_276_18
			end

			local var_276_19 = 2

			if var_276_19 < arg_273_1.time_ and arg_273_1.time_ <= var_276_19 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_20 = 2

			if var_276_19 <= arg_273_1.time_ and arg_273_1.time_ < var_276_19 + var_276_20 then
				local var_276_21 = (arg_273_1.time_ - var_276_19) / var_276_20
				local var_276_22 = Color.New(0, 0, 0)

				var_276_22.a = Mathf.Lerp(1, 0, var_276_21)
				arg_273_1.mask_.color = var_276_22
			end

			if arg_273_1.time_ >= var_276_19 + var_276_20 and arg_273_1.time_ < var_276_19 + var_276_20 + arg_276_0 then
				local var_276_23 = Color.New(0, 0, 0)
				local var_276_24 = 0

				arg_273_1.mask_.enabled = false
				var_276_23.a = var_276_24
				arg_273_1.mask_.color = var_276_23
			end

			local var_276_25 = arg_273_1.actors_["1084ui_story"].transform
			local var_276_26 = 2

			if var_276_26 < arg_273_1.time_ and arg_273_1.time_ <= var_276_26 + arg_276_0 then
				arg_273_1.var_.moveOldPos1084ui_story = var_276_25.localPosition
			end

			local var_276_27 = 0.001

			if var_276_26 <= arg_273_1.time_ and arg_273_1.time_ < var_276_26 + var_276_27 then
				local var_276_28 = (arg_273_1.time_ - var_276_26) / var_276_27
				local var_276_29 = Vector3.New(0, 100, 0)

				var_276_25.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1084ui_story, var_276_29, var_276_28)

				local var_276_30 = manager.ui.mainCamera.transform.position - var_276_25.position

				var_276_25.forward = Vector3.New(var_276_30.x, var_276_30.y, var_276_30.z)

				local var_276_31 = var_276_25.localEulerAngles

				var_276_31.z = 0
				var_276_31.x = 0
				var_276_25.localEulerAngles = var_276_31
			end

			if arg_273_1.time_ >= var_276_26 + var_276_27 and arg_273_1.time_ < var_276_26 + var_276_27 + arg_276_0 then
				var_276_25.localPosition = Vector3.New(0, 100, 0)

				local var_276_32 = manager.ui.mainCamera.transform.position - var_276_25.position

				var_276_25.forward = Vector3.New(var_276_32.x, var_276_32.y, var_276_32.z)

				local var_276_33 = var_276_25.localEulerAngles

				var_276_33.z = 0
				var_276_33.x = 0
				var_276_25.localEulerAngles = var_276_33
			end

			local var_276_34 = arg_273_1.actors_["10069ui_story"].transform
			local var_276_35 = 2

			if var_276_35 < arg_273_1.time_ and arg_273_1.time_ <= var_276_35 + arg_276_0 then
				arg_273_1.var_.moveOldPos10069ui_story = var_276_34.localPosition
			end

			local var_276_36 = 0.001

			if var_276_35 <= arg_273_1.time_ and arg_273_1.time_ < var_276_35 + var_276_36 then
				local var_276_37 = (arg_273_1.time_ - var_276_35) / var_276_36
				local var_276_38 = Vector3.New(0, 100, 0)

				var_276_34.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10069ui_story, var_276_38, var_276_37)

				local var_276_39 = manager.ui.mainCamera.transform.position - var_276_34.position

				var_276_34.forward = Vector3.New(var_276_39.x, var_276_39.y, var_276_39.z)

				local var_276_40 = var_276_34.localEulerAngles

				var_276_40.z = 0
				var_276_40.x = 0
				var_276_34.localEulerAngles = var_276_40
			end

			if arg_273_1.time_ >= var_276_35 + var_276_36 and arg_273_1.time_ < var_276_35 + var_276_36 + arg_276_0 then
				var_276_34.localPosition = Vector3.New(0, 100, 0)

				local var_276_41 = manager.ui.mainCamera.transform.position - var_276_34.position

				var_276_34.forward = Vector3.New(var_276_41.x, var_276_41.y, var_276_41.z)

				local var_276_42 = var_276_34.localEulerAngles

				var_276_42.z = 0
				var_276_42.x = 0
				var_276_34.localEulerAngles = var_276_42
			end

			if arg_273_1.frameCnt_ <= 1 then
				arg_273_1.dialog_:SetActive(false)
			end

			local var_276_43 = 3.8
			local var_276_44 = 0.65

			if var_276_43 < arg_273_1.time_ and arg_273_1.time_ <= var_276_43 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				arg_273_1.dialog_:SetActive(true)

				arg_273_1.dialogCg_.alpha = 0

				local var_276_45 = LeanTween.value(arg_273_1.dialog_, 0, 1, 0.3)

				var_276_45:setOnUpdate(LuaHelper.FloatAction(function(arg_277_0)
					arg_273_1.dialogCg_.alpha = arg_277_0
				end))
				var_276_45:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_273_1.dialog_)
					var_276_45:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_273_1.duration_ = arg_273_1.duration_ + 0.3

				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_46 = arg_273_1:GetWordFromCfg(319391065)
				local var_276_47 = arg_273_1:FormatText(var_276_46.content)

				arg_273_1.text_.text = var_276_47

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_48 = 26
				local var_276_49 = utf8.len(var_276_47)
				local var_276_50 = var_276_48 <= 0 and var_276_44 or var_276_44 * (var_276_49 / var_276_48)

				if var_276_50 > 0 and var_276_44 < var_276_50 then
					arg_273_1.talkMaxDuration = var_276_50
					var_276_43 = var_276_43 + 0.3

					if var_276_50 + var_276_43 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_50 + var_276_43
					end
				end

				arg_273_1.text_.text = var_276_47
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_51 = var_276_43 + 0.3
			local var_276_52 = math.max(var_276_44, arg_273_1.talkMaxDuration)

			if var_276_51 <= arg_273_1.time_ and arg_273_1.time_ < var_276_51 + var_276_52 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_51) / var_276_52

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_51 + var_276_52 and arg_273_1.time_ < var_276_51 + var_276_52 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play319391066 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 319391066
		arg_279_1.duration_ = 4.37

		local var_279_0 = {
			zh = 1.3,
			ja = 4.366
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play319391067(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10069ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect10069ui_story == nil then
				arg_279_1.var_.characterEffect10069ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect10069ui_story and not isNil(var_282_0) then
					arg_279_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect10069ui_story then
				arg_279_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_282_4 = 0
			local var_282_5 = 0.175

			if var_282_4 < arg_279_1.time_ and arg_279_1.time_ <= var_282_4 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_6 = arg_279_1:FormatText(StoryNameCfg[693].name)

				arg_279_1.leftNameTxt_.text = var_282_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, true)
				arg_279_1.iconController_:SetSelectedState("hero")

				arg_279_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10069")

				arg_279_1.callingController_:SetSelectedState("normal")

				arg_279_1.keyicon_.color = Color.New(1, 1, 1)
				arg_279_1.icon_.color = Color.New(1, 1, 1)

				local var_282_7 = arg_279_1:GetWordFromCfg(319391066)
				local var_282_8 = arg_279_1:FormatText(var_282_7.content)

				arg_279_1.text_.text = var_282_8

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_9 = 7
				local var_282_10 = utf8.len(var_282_8)
				local var_282_11 = var_282_9 <= 0 and var_282_5 or var_282_5 * (var_282_10 / var_282_9)

				if var_282_11 > 0 and var_282_5 < var_282_11 then
					arg_279_1.talkMaxDuration = var_282_11

					if var_282_11 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_11 + var_282_4
					end
				end

				arg_279_1.text_.text = var_282_8
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391066", "story_v_out_319391.awb") ~= 0 then
					local var_282_12 = manager.audio:GetVoiceLength("story_v_out_319391", "319391066", "story_v_out_319391.awb") / 1000

					if var_282_12 + var_282_4 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_12 + var_282_4
					end

					if var_282_7.prefab_name ~= "" and arg_279_1.actors_[var_282_7.prefab_name] ~= nil then
						local var_282_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_7.prefab_name].transform, "story_v_out_319391", "319391066", "story_v_out_319391.awb")

						arg_279_1:RecordAudio("319391066", var_282_13)
						arg_279_1:RecordAudio("319391066", var_282_13)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_319391", "319391066", "story_v_out_319391.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_319391", "319391066", "story_v_out_319391.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_14 = math.max(var_282_5, arg_279_1.talkMaxDuration)

			if var_282_4 <= arg_279_1.time_ and arg_279_1.time_ < var_282_4 + var_282_14 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_4) / var_282_14

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_4 + var_282_14 and arg_279_1.time_ < var_282_4 + var_282_14 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play319391067 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 319391067
		arg_283_1.duration_ = 4

		local var_283_0 = {
			zh = 3.166,
			ja = 4
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play319391068(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10066ui_story"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos10066ui_story = var_286_0.localPosition
			end

			local var_286_2 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2
				local var_286_4 = Vector3.New(0, -0.99, -5.83)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10066ui_story, var_286_4, var_286_3)

				local var_286_5 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_5.x, var_286_5.y, var_286_5.z)

				local var_286_6 = var_286_0.localEulerAngles

				var_286_6.z = 0
				var_286_6.x = 0
				var_286_0.localEulerAngles = var_286_6
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_286_7 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_7.x, var_286_7.y, var_286_7.z)

				local var_286_8 = var_286_0.localEulerAngles

				var_286_8.z = 0
				var_286_8.x = 0
				var_286_0.localEulerAngles = var_286_8
			end

			local var_286_9 = arg_283_1.actors_["10066ui_story"]
			local var_286_10 = 0

			if var_286_10 < arg_283_1.time_ and arg_283_1.time_ <= var_286_10 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect10066ui_story == nil then
				arg_283_1.var_.characterEffect10066ui_story = var_286_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_11 = 0.200000002980232

			if var_286_10 <= arg_283_1.time_ and arg_283_1.time_ < var_286_10 + var_286_11 and not isNil(var_286_9) then
				local var_286_12 = (arg_283_1.time_ - var_286_10) / var_286_11

				if arg_283_1.var_.characterEffect10066ui_story and not isNil(var_286_9) then
					arg_283_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_10 + var_286_11 and arg_283_1.time_ < var_286_10 + var_286_11 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect10066ui_story then
				arg_283_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_286_13 = 0

			if var_286_13 < arg_283_1.time_ and arg_283_1.time_ <= var_286_13 + arg_286_0 then
				arg_283_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_286_14 = 0

			if var_286_14 < arg_283_1.time_ and arg_283_1.time_ <= var_286_14 + arg_286_0 then
				arg_283_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_286_15 = arg_283_1.actors_["1084ui_story"].transform
			local var_286_16 = 0

			if var_286_16 < arg_283_1.time_ and arg_283_1.time_ <= var_286_16 + arg_286_0 then
				arg_283_1.var_.moveOldPos1084ui_story = var_286_15.localPosition
			end

			local var_286_17 = 0.001

			if var_286_16 <= arg_283_1.time_ and arg_283_1.time_ < var_286_16 + var_286_17 then
				local var_286_18 = (arg_283_1.time_ - var_286_16) / var_286_17
				local var_286_19 = Vector3.New(0, 100, 0)

				var_286_15.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos1084ui_story, var_286_19, var_286_18)

				local var_286_20 = manager.ui.mainCamera.transform.position - var_286_15.position

				var_286_15.forward = Vector3.New(var_286_20.x, var_286_20.y, var_286_20.z)

				local var_286_21 = var_286_15.localEulerAngles

				var_286_21.z = 0
				var_286_21.x = 0
				var_286_15.localEulerAngles = var_286_21
			end

			if arg_283_1.time_ >= var_286_16 + var_286_17 and arg_283_1.time_ < var_286_16 + var_286_17 + arg_286_0 then
				var_286_15.localPosition = Vector3.New(0, 100, 0)

				local var_286_22 = manager.ui.mainCamera.transform.position - var_286_15.position

				var_286_15.forward = Vector3.New(var_286_22.x, var_286_22.y, var_286_22.z)

				local var_286_23 = var_286_15.localEulerAngles

				var_286_23.z = 0
				var_286_23.x = 0
				var_286_15.localEulerAngles = var_286_23
			end

			local var_286_24 = arg_283_1.actors_["1084ui_story"]
			local var_286_25 = 0

			if var_286_25 < arg_283_1.time_ and arg_283_1.time_ <= var_286_25 + arg_286_0 and not isNil(var_286_24) and arg_283_1.var_.characterEffect1084ui_story == nil then
				arg_283_1.var_.characterEffect1084ui_story = var_286_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_26 = 0.200000002980232

			if var_286_25 <= arg_283_1.time_ and arg_283_1.time_ < var_286_25 + var_286_26 and not isNil(var_286_24) then
				local var_286_27 = (arg_283_1.time_ - var_286_25) / var_286_26

				if arg_283_1.var_.characterEffect1084ui_story and not isNil(var_286_24) then
					local var_286_28 = Mathf.Lerp(0, 0.5, var_286_27)

					arg_283_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1084ui_story.fillRatio = var_286_28
				end
			end

			if arg_283_1.time_ >= var_286_25 + var_286_26 and arg_283_1.time_ < var_286_25 + var_286_26 + arg_286_0 and not isNil(var_286_24) and arg_283_1.var_.characterEffect1084ui_story then
				local var_286_29 = 0.5

				arg_283_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1084ui_story.fillRatio = var_286_29
			end

			local var_286_30 = arg_283_1.actors_["10069ui_story"].transform
			local var_286_31 = 0

			if var_286_31 < arg_283_1.time_ and arg_283_1.time_ <= var_286_31 + arg_286_0 then
				arg_283_1.var_.moveOldPos10069ui_story = var_286_30.localPosition
			end

			local var_286_32 = 0.001

			if var_286_31 <= arg_283_1.time_ and arg_283_1.time_ < var_286_31 + var_286_32 then
				local var_286_33 = (arg_283_1.time_ - var_286_31) / var_286_32
				local var_286_34 = Vector3.New(0, 100, 0)

				var_286_30.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10069ui_story, var_286_34, var_286_33)

				local var_286_35 = manager.ui.mainCamera.transform.position - var_286_30.position

				var_286_30.forward = Vector3.New(var_286_35.x, var_286_35.y, var_286_35.z)

				local var_286_36 = var_286_30.localEulerAngles

				var_286_36.z = 0
				var_286_36.x = 0
				var_286_30.localEulerAngles = var_286_36
			end

			if arg_283_1.time_ >= var_286_31 + var_286_32 and arg_283_1.time_ < var_286_31 + var_286_32 + arg_286_0 then
				var_286_30.localPosition = Vector3.New(0, 100, 0)

				local var_286_37 = manager.ui.mainCamera.transform.position - var_286_30.position

				var_286_30.forward = Vector3.New(var_286_37.x, var_286_37.y, var_286_37.z)

				local var_286_38 = var_286_30.localEulerAngles

				var_286_38.z = 0
				var_286_38.x = 0
				var_286_30.localEulerAngles = var_286_38
			end

			local var_286_39 = arg_283_1.actors_["10069ui_story"]
			local var_286_40 = 0

			if var_286_40 < arg_283_1.time_ and arg_283_1.time_ <= var_286_40 + arg_286_0 and not isNil(var_286_39) and arg_283_1.var_.characterEffect10069ui_story == nil then
				arg_283_1.var_.characterEffect10069ui_story = var_286_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_41 = 0.200000002980232

			if var_286_40 <= arg_283_1.time_ and arg_283_1.time_ < var_286_40 + var_286_41 and not isNil(var_286_39) then
				local var_286_42 = (arg_283_1.time_ - var_286_40) / var_286_41

				if arg_283_1.var_.characterEffect10069ui_story and not isNil(var_286_39) then
					local var_286_43 = Mathf.Lerp(0, 0.5, var_286_42)

					arg_283_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_283_1.var_.characterEffect10069ui_story.fillRatio = var_286_43
				end
			end

			if arg_283_1.time_ >= var_286_40 + var_286_41 and arg_283_1.time_ < var_286_40 + var_286_41 + arg_286_0 and not isNil(var_286_39) and arg_283_1.var_.characterEffect10069ui_story then
				local var_286_44 = 0.5

				arg_283_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_283_1.var_.characterEffect10069ui_story.fillRatio = var_286_44
			end

			local var_286_45 = 0
			local var_286_46 = 0.25

			if var_286_45 < arg_283_1.time_ and arg_283_1.time_ <= var_286_45 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_47 = arg_283_1:FormatText(StoryNameCfg[640].name)

				arg_283_1.leftNameTxt_.text = var_286_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_48 = arg_283_1:GetWordFromCfg(319391067)
				local var_286_49 = arg_283_1:FormatText(var_286_48.content)

				arg_283_1.text_.text = var_286_49

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_50 = 10
				local var_286_51 = utf8.len(var_286_49)
				local var_286_52 = var_286_50 <= 0 and var_286_46 or var_286_46 * (var_286_51 / var_286_50)

				if var_286_52 > 0 and var_286_46 < var_286_52 then
					arg_283_1.talkMaxDuration = var_286_52

					if var_286_52 + var_286_45 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_52 + var_286_45
					end
				end

				arg_283_1.text_.text = var_286_49
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391067", "story_v_out_319391.awb") ~= 0 then
					local var_286_53 = manager.audio:GetVoiceLength("story_v_out_319391", "319391067", "story_v_out_319391.awb") / 1000

					if var_286_53 + var_286_45 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_53 + var_286_45
					end

					if var_286_48.prefab_name ~= "" and arg_283_1.actors_[var_286_48.prefab_name] ~= nil then
						local var_286_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_48.prefab_name].transform, "story_v_out_319391", "319391067", "story_v_out_319391.awb")

						arg_283_1:RecordAudio("319391067", var_286_54)
						arg_283_1:RecordAudio("319391067", var_286_54)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_319391", "319391067", "story_v_out_319391.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_319391", "319391067", "story_v_out_319391.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_55 = math.max(var_286_46, arg_283_1.talkMaxDuration)

			if var_286_45 <= arg_283_1.time_ and arg_283_1.time_ < var_286_45 + var_286_55 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_45) / var_286_55

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_45 + var_286_55 and arg_283_1.time_ < var_286_45 + var_286_55 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play319391068 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 319391068
		arg_287_1.duration_ = 7.33

		local var_287_0 = {
			zh = 6.8,
			ja = 7.333
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play319391069(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1084ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos1084ui_story = var_290_0.localPosition
			end

			local var_290_2 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2
				local var_290_4 = Vector3.New(-0.7, -0.97, -6)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1084ui_story, var_290_4, var_290_3)

				local var_290_5 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_5.x, var_290_5.y, var_290_5.z)

				local var_290_6 = var_290_0.localEulerAngles

				var_290_6.z = 0
				var_290_6.x = 0
				var_290_0.localEulerAngles = var_290_6
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_290_7 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_7.x, var_290_7.y, var_290_7.z)

				local var_290_8 = var_290_0.localEulerAngles

				var_290_8.z = 0
				var_290_8.x = 0
				var_290_0.localEulerAngles = var_290_8
			end

			local var_290_9 = arg_287_1.actors_["1084ui_story"]
			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1084ui_story == nil then
				arg_287_1.var_.characterEffect1084ui_story = var_290_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_11 = 0.200000002980232

			if var_290_10 <= arg_287_1.time_ and arg_287_1.time_ < var_290_10 + var_290_11 and not isNil(var_290_9) then
				local var_290_12 = (arg_287_1.time_ - var_290_10) / var_290_11

				if arg_287_1.var_.characterEffect1084ui_story and not isNil(var_290_9) then
					arg_287_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_10 + var_290_11 and arg_287_1.time_ < var_290_10 + var_290_11 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1084ui_story then
				arg_287_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_290_13 = 0

			if var_290_13 < arg_287_1.time_ and arg_287_1.time_ <= var_290_13 + arg_290_0 then
				arg_287_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_290_14 = arg_287_1.actors_["10066ui_story"].transform
			local var_290_15 = 0

			if var_290_15 < arg_287_1.time_ and arg_287_1.time_ <= var_290_15 + arg_290_0 then
				arg_287_1.var_.moveOldPos10066ui_story = var_290_14.localPosition
			end

			local var_290_16 = 0.001

			if var_290_15 <= arg_287_1.time_ and arg_287_1.time_ < var_290_15 + var_290_16 then
				local var_290_17 = (arg_287_1.time_ - var_290_15) / var_290_16
				local var_290_18 = Vector3.New(0.7, -0.99, -5.83)

				var_290_14.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10066ui_story, var_290_18, var_290_17)

				local var_290_19 = manager.ui.mainCamera.transform.position - var_290_14.position

				var_290_14.forward = Vector3.New(var_290_19.x, var_290_19.y, var_290_19.z)

				local var_290_20 = var_290_14.localEulerAngles

				var_290_20.z = 0
				var_290_20.x = 0
				var_290_14.localEulerAngles = var_290_20
			end

			if arg_287_1.time_ >= var_290_15 + var_290_16 and arg_287_1.time_ < var_290_15 + var_290_16 + arg_290_0 then
				var_290_14.localPosition = Vector3.New(0.7, -0.99, -5.83)

				local var_290_21 = manager.ui.mainCamera.transform.position - var_290_14.position

				var_290_14.forward = Vector3.New(var_290_21.x, var_290_21.y, var_290_21.z)

				local var_290_22 = var_290_14.localEulerAngles

				var_290_22.z = 0
				var_290_22.x = 0
				var_290_14.localEulerAngles = var_290_22
			end

			local var_290_23 = arg_287_1.actors_["10066ui_story"]
			local var_290_24 = 0

			if var_290_24 < arg_287_1.time_ and arg_287_1.time_ <= var_290_24 + arg_290_0 and not isNil(var_290_23) and arg_287_1.var_.characterEffect10066ui_story == nil then
				arg_287_1.var_.characterEffect10066ui_story = var_290_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_25 = 0.200000002980232

			if var_290_24 <= arg_287_1.time_ and arg_287_1.time_ < var_290_24 + var_290_25 and not isNil(var_290_23) then
				local var_290_26 = (arg_287_1.time_ - var_290_24) / var_290_25

				if arg_287_1.var_.characterEffect10066ui_story and not isNil(var_290_23) then
					local var_290_27 = Mathf.Lerp(0, 0.5, var_290_26)

					arg_287_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_287_1.var_.characterEffect10066ui_story.fillRatio = var_290_27
				end
			end

			if arg_287_1.time_ >= var_290_24 + var_290_25 and arg_287_1.time_ < var_290_24 + var_290_25 + arg_290_0 and not isNil(var_290_23) and arg_287_1.var_.characterEffect10066ui_story then
				local var_290_28 = 0.5

				arg_287_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_287_1.var_.characterEffect10066ui_story.fillRatio = var_290_28
			end

			local var_290_29 = 0
			local var_290_30 = 0.7

			if var_290_29 < arg_287_1.time_ and arg_287_1.time_ <= var_290_29 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_31 = arg_287_1:FormatText(StoryNameCfg[6].name)

				arg_287_1.leftNameTxt_.text = var_290_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_32 = arg_287_1:GetWordFromCfg(319391068)
				local var_290_33 = arg_287_1:FormatText(var_290_32.content)

				arg_287_1.text_.text = var_290_33

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_34 = 28
				local var_290_35 = utf8.len(var_290_33)
				local var_290_36 = var_290_34 <= 0 and var_290_30 or var_290_30 * (var_290_35 / var_290_34)

				if var_290_36 > 0 and var_290_30 < var_290_36 then
					arg_287_1.talkMaxDuration = var_290_36

					if var_290_36 + var_290_29 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_36 + var_290_29
					end
				end

				arg_287_1.text_.text = var_290_33
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391068", "story_v_out_319391.awb") ~= 0 then
					local var_290_37 = manager.audio:GetVoiceLength("story_v_out_319391", "319391068", "story_v_out_319391.awb") / 1000

					if var_290_37 + var_290_29 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_37 + var_290_29
					end

					if var_290_32.prefab_name ~= "" and arg_287_1.actors_[var_290_32.prefab_name] ~= nil then
						local var_290_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_32.prefab_name].transform, "story_v_out_319391", "319391068", "story_v_out_319391.awb")

						arg_287_1:RecordAudio("319391068", var_290_38)
						arg_287_1:RecordAudio("319391068", var_290_38)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_319391", "319391068", "story_v_out_319391.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_319391", "319391068", "story_v_out_319391.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_39 = math.max(var_290_30, arg_287_1.talkMaxDuration)

			if var_290_29 <= arg_287_1.time_ and arg_287_1.time_ < var_290_29 + var_290_39 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_29) / var_290_39

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_29 + var_290_39 and arg_287_1.time_ < var_290_29 + var_290_39 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
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
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play319391069 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 319391069
		arg_291_1.duration_ = 6.53

		local var_291_0 = {
			zh = 2.3,
			ja = 6.533
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play319391070(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1084ui_story"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1084ui_story == nil then
				arg_291_1.var_.characterEffect1084ui_story = var_294_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.characterEffect1084ui_story and not isNil(var_294_0) then
					local var_294_4 = Mathf.Lerp(0, 0.5, var_294_3)

					arg_291_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1084ui_story.fillRatio = var_294_4
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1084ui_story then
				local var_294_5 = 0.5

				arg_291_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1084ui_story.fillRatio = var_294_5
			end

			local var_294_6 = arg_291_1.actors_["10066ui_story"]
			local var_294_7 = 0

			if var_294_7 < arg_291_1.time_ and arg_291_1.time_ <= var_294_7 + arg_294_0 and not isNil(var_294_6) and arg_291_1.var_.characterEffect10066ui_story == nil then
				arg_291_1.var_.characterEffect10066ui_story = var_294_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_8 = 0.200000002980232

			if var_294_7 <= arg_291_1.time_ and arg_291_1.time_ < var_294_7 + var_294_8 and not isNil(var_294_6) then
				local var_294_9 = (arg_291_1.time_ - var_294_7) / var_294_8

				if arg_291_1.var_.characterEffect10066ui_story and not isNil(var_294_6) then
					arg_291_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_7 + var_294_8 and arg_291_1.time_ < var_294_7 + var_294_8 + arg_294_0 and not isNil(var_294_6) and arg_291_1.var_.characterEffect10066ui_story then
				arg_291_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_294_10 = 0

			if var_294_10 < arg_291_1.time_ and arg_291_1.time_ <= var_294_10 + arg_294_0 then
				arg_291_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_294_11 = 0
			local var_294_12 = 0.25

			if var_294_11 < arg_291_1.time_ and arg_291_1.time_ <= var_294_11 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_13 = arg_291_1:FormatText(StoryNameCfg[640].name)

				arg_291_1.leftNameTxt_.text = var_294_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_14 = arg_291_1:GetWordFromCfg(319391069)
				local var_294_15 = arg_291_1:FormatText(var_294_14.content)

				arg_291_1.text_.text = var_294_15

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_16 = 10
				local var_294_17 = utf8.len(var_294_15)
				local var_294_18 = var_294_16 <= 0 and var_294_12 or var_294_12 * (var_294_17 / var_294_16)

				if var_294_18 > 0 and var_294_12 < var_294_18 then
					arg_291_1.talkMaxDuration = var_294_18

					if var_294_18 + var_294_11 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_18 + var_294_11
					end
				end

				arg_291_1.text_.text = var_294_15
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391069", "story_v_out_319391.awb") ~= 0 then
					local var_294_19 = manager.audio:GetVoiceLength("story_v_out_319391", "319391069", "story_v_out_319391.awb") / 1000

					if var_294_19 + var_294_11 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_19 + var_294_11
					end

					if var_294_14.prefab_name ~= "" and arg_291_1.actors_[var_294_14.prefab_name] ~= nil then
						local var_294_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_14.prefab_name].transform, "story_v_out_319391", "319391069", "story_v_out_319391.awb")

						arg_291_1:RecordAudio("319391069", var_294_20)
						arg_291_1:RecordAudio("319391069", var_294_20)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_319391", "319391069", "story_v_out_319391.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_319391", "319391069", "story_v_out_319391.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_21 = math.max(var_294_12, arg_291_1.talkMaxDuration)

			if var_294_11 <= arg_291_1.time_ and arg_291_1.time_ < var_294_11 + var_294_21 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_11) / var_294_21

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_11 + var_294_21 and arg_291_1.time_ < var_294_11 + var_294_21 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play319391070 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 319391070
		arg_295_1.duration_ = 2.93

		local var_295_0 = {
			zh = 1.999999999999,
			ja = 2.933
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play319391071(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["10066ui_story"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect10066ui_story == nil then
				arg_295_1.var_.characterEffect10066ui_story = var_298_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.characterEffect10066ui_story and not isNil(var_298_0) then
					local var_298_4 = Mathf.Lerp(0, 0.5, var_298_3)

					arg_295_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_295_1.var_.characterEffect10066ui_story.fillRatio = var_298_4
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect10066ui_story then
				local var_298_5 = 0.5

				arg_295_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_295_1.var_.characterEffect10066ui_story.fillRatio = var_298_5
			end

			local var_298_6 = arg_295_1.actors_["1084ui_story"]
			local var_298_7 = 0

			if var_298_7 < arg_295_1.time_ and arg_295_1.time_ <= var_298_7 + arg_298_0 and not isNil(var_298_6) and arg_295_1.var_.characterEffect1084ui_story == nil then
				arg_295_1.var_.characterEffect1084ui_story = var_298_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_8 = 0.200000002980232

			if var_298_7 <= arg_295_1.time_ and arg_295_1.time_ < var_298_7 + var_298_8 and not isNil(var_298_6) then
				local var_298_9 = (arg_295_1.time_ - var_298_7) / var_298_8

				if arg_295_1.var_.characterEffect1084ui_story and not isNil(var_298_6) then
					arg_295_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= var_298_7 + var_298_8 and arg_295_1.time_ < var_298_7 + var_298_8 + arg_298_0 and not isNil(var_298_6) and arg_295_1.var_.characterEffect1084ui_story then
				arg_295_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_298_10 = 0

			if var_298_10 < arg_295_1.time_ and arg_295_1.time_ <= var_298_10 + arg_298_0 then
				arg_295_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			local var_298_11 = 0

			if var_298_11 < arg_295_1.time_ and arg_295_1.time_ <= var_298_11 + arg_298_0 then
				arg_295_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_298_12 = 0
			local var_298_13 = 0.25

			if var_298_12 < arg_295_1.time_ and arg_295_1.time_ <= var_298_12 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_14 = arg_295_1:FormatText(StoryNameCfg[6].name)

				arg_295_1.leftNameTxt_.text = var_298_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_15 = arg_295_1:GetWordFromCfg(319391070)
				local var_298_16 = arg_295_1:FormatText(var_298_15.content)

				arg_295_1.text_.text = var_298_16

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_17 = 10
				local var_298_18 = utf8.len(var_298_16)
				local var_298_19 = var_298_17 <= 0 and var_298_13 or var_298_13 * (var_298_18 / var_298_17)

				if var_298_19 > 0 and var_298_13 < var_298_19 then
					arg_295_1.talkMaxDuration = var_298_19

					if var_298_19 + var_298_12 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_19 + var_298_12
					end
				end

				arg_295_1.text_.text = var_298_16
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391070", "story_v_out_319391.awb") ~= 0 then
					local var_298_20 = manager.audio:GetVoiceLength("story_v_out_319391", "319391070", "story_v_out_319391.awb") / 1000

					if var_298_20 + var_298_12 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_20 + var_298_12
					end

					if var_298_15.prefab_name ~= "" and arg_295_1.actors_[var_298_15.prefab_name] ~= nil then
						local var_298_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_15.prefab_name].transform, "story_v_out_319391", "319391070", "story_v_out_319391.awb")

						arg_295_1:RecordAudio("319391070", var_298_21)
						arg_295_1:RecordAudio("319391070", var_298_21)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_319391", "319391070", "story_v_out_319391.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_319391", "319391070", "story_v_out_319391.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_22 = math.max(var_298_13, arg_295_1.talkMaxDuration)

			if var_298_12 <= arg_295_1.time_ and arg_295_1.time_ < var_298_12 + var_298_22 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_12) / var_298_22

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_12 + var_298_22 and arg_295_1.time_ < var_298_12 + var_298_22 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play319391071 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 319391071
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play319391072(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1084ui_story"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1084ui_story == nil then
				arg_299_1.var_.characterEffect1084ui_story = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.characterEffect1084ui_story and not isNil(var_302_0) then
					local var_302_4 = Mathf.Lerp(0, 0.5, var_302_3)

					arg_299_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1084ui_story.fillRatio = var_302_4
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1084ui_story then
				local var_302_5 = 0.5

				arg_299_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1084ui_story.fillRatio = var_302_5
			end

			local var_302_6 = 0
			local var_302_7 = 1.125

			if var_302_6 < arg_299_1.time_ and arg_299_1.time_ <= var_302_6 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_8 = arg_299_1:GetWordFromCfg(319391071)
				local var_302_9 = arg_299_1:FormatText(var_302_8.content)

				arg_299_1.text_.text = var_302_9

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_10 = 45
				local var_302_11 = utf8.len(var_302_9)
				local var_302_12 = var_302_10 <= 0 and var_302_7 or var_302_7 * (var_302_11 / var_302_10)

				if var_302_12 > 0 and var_302_7 < var_302_12 then
					arg_299_1.talkMaxDuration = var_302_12

					if var_302_12 + var_302_6 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_12 + var_302_6
					end
				end

				arg_299_1.text_.text = var_302_9
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_13 = math.max(var_302_7, arg_299_1.talkMaxDuration)

			if var_302_6 <= arg_299_1.time_ and arg_299_1.time_ < var_302_6 + var_302_13 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_6) / var_302_13

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_6 + var_302_13 and arg_299_1.time_ < var_302_6 + var_302_13 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play319391072 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 319391072
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play319391073(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_306_1 = 0
			local var_306_2 = 1.175

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:GetWordFromCfg(319391072)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 47
				local var_306_6 = utf8.len(var_306_4)
				local var_306_7 = var_306_5 <= 0 and var_306_2 or var_306_2 * (var_306_6 / var_306_5)

				if var_306_7 > 0 and var_306_2 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_8 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_8 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_8

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_8 and arg_303_1.time_ < var_306_1 + var_306_8 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play319391073 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 319391073
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play319391074(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0
			local var_310_1 = 1

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				local var_310_2 = "play"
				local var_310_3 = "effect"

				arg_307_1:AudioAction(var_310_2, var_310_3, "se_story_130", "se_story_130_didi", "")
			end

			local var_310_4 = arg_307_1.actors_["1084ui_story"].transform
			local var_310_5 = 0

			if var_310_5 < arg_307_1.time_ and arg_307_1.time_ <= var_310_5 + arg_310_0 then
				arg_307_1.var_.moveOldPos1084ui_story = var_310_4.localPosition
			end

			local var_310_6 = 0.001

			if var_310_5 <= arg_307_1.time_ and arg_307_1.time_ < var_310_5 + var_310_6 then
				local var_310_7 = (arg_307_1.time_ - var_310_5) / var_310_6
				local var_310_8 = Vector3.New(0, 100, 0)

				var_310_4.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos1084ui_story, var_310_8, var_310_7)

				local var_310_9 = manager.ui.mainCamera.transform.position - var_310_4.position

				var_310_4.forward = Vector3.New(var_310_9.x, var_310_9.y, var_310_9.z)

				local var_310_10 = var_310_4.localEulerAngles

				var_310_10.z = 0
				var_310_10.x = 0
				var_310_4.localEulerAngles = var_310_10
			end

			if arg_307_1.time_ >= var_310_5 + var_310_6 and arg_307_1.time_ < var_310_5 + var_310_6 + arg_310_0 then
				var_310_4.localPosition = Vector3.New(0, 100, 0)

				local var_310_11 = manager.ui.mainCamera.transform.position - var_310_4.position

				var_310_4.forward = Vector3.New(var_310_11.x, var_310_11.y, var_310_11.z)

				local var_310_12 = var_310_4.localEulerAngles

				var_310_12.z = 0
				var_310_12.x = 0
				var_310_4.localEulerAngles = var_310_12
			end

			local var_310_13 = arg_307_1.actors_["10066ui_story"].transform
			local var_310_14 = 0

			if var_310_14 < arg_307_1.time_ and arg_307_1.time_ <= var_310_14 + arg_310_0 then
				arg_307_1.var_.moveOldPos10066ui_story = var_310_13.localPosition
			end

			local var_310_15 = 0.001

			if var_310_14 <= arg_307_1.time_ and arg_307_1.time_ < var_310_14 + var_310_15 then
				local var_310_16 = (arg_307_1.time_ - var_310_14) / var_310_15
				local var_310_17 = Vector3.New(0, 100, 0)

				var_310_13.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos10066ui_story, var_310_17, var_310_16)

				local var_310_18 = manager.ui.mainCamera.transform.position - var_310_13.position

				var_310_13.forward = Vector3.New(var_310_18.x, var_310_18.y, var_310_18.z)

				local var_310_19 = var_310_13.localEulerAngles

				var_310_19.z = 0
				var_310_19.x = 0
				var_310_13.localEulerAngles = var_310_19
			end

			if arg_307_1.time_ >= var_310_14 + var_310_15 and arg_307_1.time_ < var_310_14 + var_310_15 + arg_310_0 then
				var_310_13.localPosition = Vector3.New(0, 100, 0)

				local var_310_20 = manager.ui.mainCamera.transform.position - var_310_13.position

				var_310_13.forward = Vector3.New(var_310_20.x, var_310_20.y, var_310_20.z)

				local var_310_21 = var_310_13.localEulerAngles

				var_310_21.z = 0
				var_310_21.x = 0
				var_310_13.localEulerAngles = var_310_21
			end

			local var_310_22 = 0
			local var_310_23 = 1.125

			if var_310_22 < arg_307_1.time_ and arg_307_1.time_ <= var_310_22 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_24 = arg_307_1:GetWordFromCfg(319391073)
				local var_310_25 = arg_307_1:FormatText(var_310_24.content)

				arg_307_1.text_.text = var_310_25

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_26 = 45
				local var_310_27 = utf8.len(var_310_25)
				local var_310_28 = var_310_26 <= 0 and var_310_23 or var_310_23 * (var_310_27 / var_310_26)

				if var_310_28 > 0 and var_310_23 < var_310_28 then
					arg_307_1.talkMaxDuration = var_310_28

					if var_310_28 + var_310_22 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_28 + var_310_22
					end
				end

				arg_307_1.text_.text = var_310_25
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_29 = math.max(var_310_23, arg_307_1.talkMaxDuration)

			if var_310_22 <= arg_307_1.time_ and arg_307_1.time_ < var_310_22 + var_310_29 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_22) / var_310_29

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_22 + var_310_29 and arg_307_1.time_ < var_310_22 + var_310_29 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
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
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play319391074 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 319391074
		arg_311_1.duration_ = 7.87

		local var_311_0 = {
			zh = 6.633,
			ja = 7.866
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
				arg_311_0:Play319391075(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["1084ui_story"].transform
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.var_.moveOldPos1084ui_story = var_314_0.localPosition

				local var_314_2 = "1084ui_story"

				arg_311_1:ShowWeapon(arg_311_1.var_[var_314_2 .. "Animator"].transform, false)
			end

			local var_314_3 = 0.001

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_3 then
				local var_314_4 = (arg_311_1.time_ - var_314_1) / var_314_3
				local var_314_5 = Vector3.New(0, -0.97, -6)

				var_314_0.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos1084ui_story, var_314_5, var_314_4)

				local var_314_6 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_6.x, var_314_6.y, var_314_6.z)

				local var_314_7 = var_314_0.localEulerAngles

				var_314_7.z = 0
				var_314_7.x = 0
				var_314_0.localEulerAngles = var_314_7
			end

			if arg_311_1.time_ >= var_314_1 + var_314_3 and arg_311_1.time_ < var_314_1 + var_314_3 + arg_314_0 then
				var_314_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_314_8 = manager.ui.mainCamera.transform.position - var_314_0.position

				var_314_0.forward = Vector3.New(var_314_8.x, var_314_8.y, var_314_8.z)

				local var_314_9 = var_314_0.localEulerAngles

				var_314_9.z = 0
				var_314_9.x = 0
				var_314_0.localEulerAngles = var_314_9
			end

			local var_314_10 = arg_311_1.actors_["1084ui_story"]
			local var_314_11 = 0

			if var_314_11 < arg_311_1.time_ and arg_311_1.time_ <= var_314_11 + arg_314_0 and not isNil(var_314_10) and arg_311_1.var_.characterEffect1084ui_story == nil then
				arg_311_1.var_.characterEffect1084ui_story = var_314_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_12 = 0.200000002980232

			if var_314_11 <= arg_311_1.time_ and arg_311_1.time_ < var_314_11 + var_314_12 and not isNil(var_314_10) then
				local var_314_13 = (arg_311_1.time_ - var_314_11) / var_314_12

				if arg_311_1.var_.characterEffect1084ui_story and not isNil(var_314_10) then
					arg_311_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_11 + var_314_12 and arg_311_1.time_ < var_314_11 + var_314_12 + arg_314_0 and not isNil(var_314_10) and arg_311_1.var_.characterEffect1084ui_story then
				arg_311_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_314_14 = 0

			if var_314_14 < arg_311_1.time_ and arg_311_1.time_ <= var_314_14 + arg_314_0 then
				arg_311_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_314_15 = 0

			if var_314_15 < arg_311_1.time_ and arg_311_1.time_ <= var_314_15 + arg_314_0 then
				arg_311_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_314_16 = 0
			local var_314_17 = 1

			if var_314_16 < arg_311_1.time_ and arg_311_1.time_ <= var_314_16 + arg_314_0 then
				local var_314_18 = "stop"
				local var_314_19 = "effect"

				arg_311_1:AudioAction(var_314_18, var_314_19, "se_story_130", "se_story_130_didi", "")
			end

			local var_314_20 = 0
			local var_314_21 = 0.725

			if var_314_20 < arg_311_1.time_ and arg_311_1.time_ <= var_314_20 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_22 = arg_311_1:FormatText(StoryNameCfg[6].name)

				arg_311_1.leftNameTxt_.text = var_314_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_23 = arg_311_1:GetWordFromCfg(319391074)
				local var_314_24 = arg_311_1:FormatText(var_314_23.content)

				arg_311_1.text_.text = var_314_24

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_25 = 29
				local var_314_26 = utf8.len(var_314_24)
				local var_314_27 = var_314_25 <= 0 and var_314_21 or var_314_21 * (var_314_26 / var_314_25)

				if var_314_27 > 0 and var_314_21 < var_314_27 then
					arg_311_1.talkMaxDuration = var_314_27

					if var_314_27 + var_314_20 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_27 + var_314_20
					end
				end

				arg_311_1.text_.text = var_314_24
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391074", "story_v_out_319391.awb") ~= 0 then
					local var_314_28 = manager.audio:GetVoiceLength("story_v_out_319391", "319391074", "story_v_out_319391.awb") / 1000

					if var_314_28 + var_314_20 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_28 + var_314_20
					end

					if var_314_23.prefab_name ~= "" and arg_311_1.actors_[var_314_23.prefab_name] ~= nil then
						local var_314_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_23.prefab_name].transform, "story_v_out_319391", "319391074", "story_v_out_319391.awb")

						arg_311_1:RecordAudio("319391074", var_314_29)
						arg_311_1:RecordAudio("319391074", var_314_29)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_319391", "319391074", "story_v_out_319391.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_319391", "319391074", "story_v_out_319391.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_30 = math.max(var_314_21, arg_311_1.talkMaxDuration)

			if var_314_20 <= arg_311_1.time_ and arg_311_1.time_ < var_314_20 + var_314_30 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_20) / var_314_30

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_20 + var_314_30 and arg_311_1.time_ < var_314_20 + var_314_30 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
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

		arg_311_1:InitPlayNodeList()
	end,
	Play319391075 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 319391075
		arg_315_1.duration_ = 11.2

		local var_315_0 = {
			zh = 6.3,
			ja = 11.2
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
				arg_315_0:Play319391076(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 0.875

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_2 = arg_315_1:FormatText(StoryNameCfg[6].name)

				arg_315_1.leftNameTxt_.text = var_318_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_3 = arg_315_1:GetWordFromCfg(319391075)
				local var_318_4 = arg_315_1:FormatText(var_318_3.content)

				arg_315_1.text_.text = var_318_4

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391075", "story_v_out_319391.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_out_319391", "319391075", "story_v_out_319391.awb") / 1000

					if var_318_8 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_0
					end

					if var_318_3.prefab_name ~= "" and arg_315_1.actors_[var_318_3.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_3.prefab_name].transform, "story_v_out_319391", "319391075", "story_v_out_319391.awb")

						arg_315_1:RecordAudio("319391075", var_318_9)
						arg_315_1:RecordAudio("319391075", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_319391", "319391075", "story_v_out_319391.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_319391", "319391075", "story_v_out_319391.awb")
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
	Play319391076 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 319391076
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play319391077(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = arg_319_1.actors_["1084ui_story"].transform
			local var_322_1 = 0

			if var_322_1 < arg_319_1.time_ and arg_319_1.time_ <= var_322_1 + arg_322_0 then
				arg_319_1.var_.moveOldPos1084ui_story = var_322_0.localPosition
			end

			local var_322_2 = 0.001

			if var_322_1 <= arg_319_1.time_ and arg_319_1.time_ < var_322_1 + var_322_2 then
				local var_322_3 = (arg_319_1.time_ - var_322_1) / var_322_2
				local var_322_4 = Vector3.New(0, 100, 0)

				var_322_0.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos1084ui_story, var_322_4, var_322_3)

				local var_322_5 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_5.x, var_322_5.y, var_322_5.z)

				local var_322_6 = var_322_0.localEulerAngles

				var_322_6.z = 0
				var_322_6.x = 0
				var_322_0.localEulerAngles = var_322_6
			end

			if arg_319_1.time_ >= var_322_1 + var_322_2 and arg_319_1.time_ < var_322_1 + var_322_2 + arg_322_0 then
				var_322_0.localPosition = Vector3.New(0, 100, 0)

				local var_322_7 = manager.ui.mainCamera.transform.position - var_322_0.position

				var_322_0.forward = Vector3.New(var_322_7.x, var_322_7.y, var_322_7.z)

				local var_322_8 = var_322_0.localEulerAngles

				var_322_8.z = 0
				var_322_8.x = 0
				var_322_0.localEulerAngles = var_322_8
			end

			local var_322_9 = arg_319_1.actors_["1084ui_story"]
			local var_322_10 = 0

			if var_322_10 < arg_319_1.time_ and arg_319_1.time_ <= var_322_10 + arg_322_0 and not isNil(var_322_9) and arg_319_1.var_.characterEffect1084ui_story == nil then
				arg_319_1.var_.characterEffect1084ui_story = var_322_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_11 = 0.200000002980232

			if var_322_10 <= arg_319_1.time_ and arg_319_1.time_ < var_322_10 + var_322_11 and not isNil(var_322_9) then
				local var_322_12 = (arg_319_1.time_ - var_322_10) / var_322_11

				if arg_319_1.var_.characterEffect1084ui_story and not isNil(var_322_9) then
					local var_322_13 = Mathf.Lerp(0, 0.5, var_322_12)

					arg_319_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_319_1.var_.characterEffect1084ui_story.fillRatio = var_322_13
				end
			end

			if arg_319_1.time_ >= var_322_10 + var_322_11 and arg_319_1.time_ < var_322_10 + var_322_11 + arg_322_0 and not isNil(var_322_9) and arg_319_1.var_.characterEffect1084ui_story then
				local var_322_14 = 0.5

				arg_319_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_319_1.var_.characterEffect1084ui_story.fillRatio = var_322_14
			end

			local var_322_15 = arg_319_1.actors_["10066ui_story"].transform
			local var_322_16 = 0

			if var_322_16 < arg_319_1.time_ and arg_319_1.time_ <= var_322_16 + arg_322_0 then
				arg_319_1.var_.moveOldPos10066ui_story = var_322_15.localPosition
			end

			local var_322_17 = 0.001

			if var_322_16 <= arg_319_1.time_ and arg_319_1.time_ < var_322_16 + var_322_17 then
				local var_322_18 = (arg_319_1.time_ - var_322_16) / var_322_17
				local var_322_19 = Vector3.New(0, 100, 0)

				var_322_15.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos10066ui_story, var_322_19, var_322_18)

				local var_322_20 = manager.ui.mainCamera.transform.position - var_322_15.position

				var_322_15.forward = Vector3.New(var_322_20.x, var_322_20.y, var_322_20.z)

				local var_322_21 = var_322_15.localEulerAngles

				var_322_21.z = 0
				var_322_21.x = 0
				var_322_15.localEulerAngles = var_322_21
			end

			if arg_319_1.time_ >= var_322_16 + var_322_17 and arg_319_1.time_ < var_322_16 + var_322_17 + arg_322_0 then
				var_322_15.localPosition = Vector3.New(0, 100, 0)

				local var_322_22 = manager.ui.mainCamera.transform.position - var_322_15.position

				var_322_15.forward = Vector3.New(var_322_22.x, var_322_22.y, var_322_22.z)

				local var_322_23 = var_322_15.localEulerAngles

				var_322_23.z = 0
				var_322_23.x = 0
				var_322_15.localEulerAngles = var_322_23
			end

			local var_322_24 = arg_319_1.actors_["10066ui_story"]
			local var_322_25 = 0

			if var_322_25 < arg_319_1.time_ and arg_319_1.time_ <= var_322_25 + arg_322_0 and not isNil(var_322_24) and arg_319_1.var_.characterEffect10066ui_story == nil then
				arg_319_1.var_.characterEffect10066ui_story = var_322_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_26 = 0.200000002980232

			if var_322_25 <= arg_319_1.time_ and arg_319_1.time_ < var_322_25 + var_322_26 and not isNil(var_322_24) then
				local var_322_27 = (arg_319_1.time_ - var_322_25) / var_322_26

				if arg_319_1.var_.characterEffect10066ui_story and not isNil(var_322_24) then
					local var_322_28 = Mathf.Lerp(0, 0.5, var_322_27)

					arg_319_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_319_1.var_.characterEffect10066ui_story.fillRatio = var_322_28
				end
			end

			if arg_319_1.time_ >= var_322_25 + var_322_26 and arg_319_1.time_ < var_322_25 + var_322_26 + arg_322_0 and not isNil(var_322_24) and arg_319_1.var_.characterEffect10066ui_story then
				local var_322_29 = 0.5

				arg_319_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_319_1.var_.characterEffect10066ui_story.fillRatio = var_322_29
			end

			local var_322_30 = 0
			local var_322_31 = 1.125

			if var_322_30 < arg_319_1.time_ and arg_319_1.time_ <= var_322_30 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_32 = arg_319_1:GetWordFromCfg(319391076)
				local var_322_33 = arg_319_1:FormatText(var_322_32.content)

				arg_319_1.text_.text = var_322_33

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_34 = 45
				local var_322_35 = utf8.len(var_322_33)
				local var_322_36 = var_322_34 <= 0 and var_322_31 or var_322_31 * (var_322_35 / var_322_34)

				if var_322_36 > 0 and var_322_31 < var_322_36 then
					arg_319_1.talkMaxDuration = var_322_36

					if var_322_36 + var_322_30 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_36 + var_322_30
					end
				end

				arg_319_1.text_.text = var_322_33
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_37 = math.max(var_322_31, arg_319_1.talkMaxDuration)

			if var_322_30 <= arg_319_1.time_ and arg_319_1.time_ < var_322_30 + var_322_37 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_30) / var_322_37

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_30 + var_322_37 and arg_319_1.time_ < var_322_30 + var_322_37 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
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
				actorName = "10066ui_story",
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
	Play319391077 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 319391077
		arg_323_1.duration_ = 7.63

		local var_323_0 = {
			zh = 1.233,
			ja = 7.633
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
				arg_323_0:Play319391078(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = 0
			local var_326_1 = 0.175

			if var_326_0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_0 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_2 = arg_323_1:FormatText(StoryNameCfg[693].name)

				arg_323_1.leftNameTxt_.text = var_326_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, true)
				arg_323_1.iconController_:SetSelectedState("hero")

				arg_323_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10069")

				arg_323_1.callingController_:SetSelectedState("normal")

				arg_323_1.keyicon_.color = Color.New(1, 1, 1)
				arg_323_1.icon_.color = Color.New(1, 1, 1)

				local var_326_3 = arg_323_1:GetWordFromCfg(319391077)
				local var_326_4 = arg_323_1:FormatText(var_326_3.content)

				arg_323_1.text_.text = var_326_4

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391077", "story_v_out_319391.awb") ~= 0 then
					local var_326_8 = manager.audio:GetVoiceLength("story_v_out_319391", "319391077", "story_v_out_319391.awb") / 1000

					if var_326_8 + var_326_0 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_8 + var_326_0
					end

					if var_326_3.prefab_name ~= "" and arg_323_1.actors_[var_326_3.prefab_name] ~= nil then
						local var_326_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_3.prefab_name].transform, "story_v_out_319391", "319391077", "story_v_out_319391.awb")

						arg_323_1:RecordAudio("319391077", var_326_9)
						arg_323_1:RecordAudio("319391077", var_326_9)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_319391", "319391077", "story_v_out_319391.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_319391", "319391077", "story_v_out_319391.awb")
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
	Play319391078 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 319391078
		arg_327_1.duration_ = 2

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play319391079(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1084ui_story"].transform
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 then
				arg_327_1.var_.moveOldPos1084ui_story = var_330_0.localPosition
			end

			local var_330_2 = 0.001

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2
				local var_330_4 = Vector3.New(0, -0.97, -6)

				var_330_0.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos1084ui_story, var_330_4, var_330_3)

				local var_330_5 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_5.x, var_330_5.y, var_330_5.z)

				local var_330_6 = var_330_0.localEulerAngles

				var_330_6.z = 0
				var_330_6.x = 0
				var_330_0.localEulerAngles = var_330_6
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 then
				var_330_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_330_7 = manager.ui.mainCamera.transform.position - var_330_0.position

				var_330_0.forward = Vector3.New(var_330_7.x, var_330_7.y, var_330_7.z)

				local var_330_8 = var_330_0.localEulerAngles

				var_330_8.z = 0
				var_330_8.x = 0
				var_330_0.localEulerAngles = var_330_8
			end

			local var_330_9 = arg_327_1.actors_["1084ui_story"]
			local var_330_10 = 0

			if var_330_10 < arg_327_1.time_ and arg_327_1.time_ <= var_330_10 + arg_330_0 and not isNil(var_330_9) and arg_327_1.var_.characterEffect1084ui_story == nil then
				arg_327_1.var_.characterEffect1084ui_story = var_330_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_11 = 0.200000002980232

			if var_330_10 <= arg_327_1.time_ and arg_327_1.time_ < var_330_10 + var_330_11 and not isNil(var_330_9) then
				local var_330_12 = (arg_327_1.time_ - var_330_10) / var_330_11

				if arg_327_1.var_.characterEffect1084ui_story and not isNil(var_330_9) then
					arg_327_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= var_330_10 + var_330_11 and arg_327_1.time_ < var_330_10 + var_330_11 + arg_330_0 and not isNil(var_330_9) and arg_327_1.var_.characterEffect1084ui_story then
				arg_327_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_330_13 = 0

			if var_330_13 < arg_327_1.time_ and arg_327_1.time_ <= var_330_13 + arg_330_0 then
				arg_327_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_330_14 = 0

			if var_330_14 < arg_327_1.time_ and arg_327_1.time_ <= var_330_14 + arg_330_0 then
				arg_327_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_330_15 = 0
			local var_330_16 = 0.05

			if var_330_15 < arg_327_1.time_ and arg_327_1.time_ <= var_330_15 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_17 = arg_327_1:FormatText(StoryNameCfg[6].name)

				arg_327_1.leftNameTxt_.text = var_330_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_18 = arg_327_1:GetWordFromCfg(319391078)
				local var_330_19 = arg_327_1:FormatText(var_330_18.content)

				arg_327_1.text_.text = var_330_19

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_20 = 2
				local var_330_21 = utf8.len(var_330_19)
				local var_330_22 = var_330_20 <= 0 and var_330_16 or var_330_16 * (var_330_21 / var_330_20)

				if var_330_22 > 0 and var_330_16 < var_330_22 then
					arg_327_1.talkMaxDuration = var_330_22

					if var_330_22 + var_330_15 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_22 + var_330_15
					end
				end

				arg_327_1.text_.text = var_330_19
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391078", "story_v_out_319391.awb") ~= 0 then
					local var_330_23 = manager.audio:GetVoiceLength("story_v_out_319391", "319391078", "story_v_out_319391.awb") / 1000

					if var_330_23 + var_330_15 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_23 + var_330_15
					end

					if var_330_18.prefab_name ~= "" and arg_327_1.actors_[var_330_18.prefab_name] ~= nil then
						local var_330_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_18.prefab_name].transform, "story_v_out_319391", "319391078", "story_v_out_319391.awb")

						arg_327_1:RecordAudio("319391078", var_330_24)
						arg_327_1:RecordAudio("319391078", var_330_24)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_319391", "319391078", "story_v_out_319391.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_319391", "319391078", "story_v_out_319391.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_25 = math.max(var_330_16, arg_327_1.talkMaxDuration)

			if var_330_15 <= arg_327_1.time_ and arg_327_1.time_ < var_330_15 + var_330_25 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_15) / var_330_25

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_15 + var_330_25 and arg_327_1.time_ < var_330_15 + var_330_25 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
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

		arg_327_1:InitPlayNodeList()
	end,
	Play319391079 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 319391079
		arg_331_1.duration_ = 4.47

		local var_331_0 = {
			zh = 1.833,
			ja = 4.466
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
				arg_331_0:Play319391080(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1084ui_story"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1084ui_story == nil then
				arg_331_1.var_.characterEffect1084ui_story = var_334_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.characterEffect1084ui_story and not isNil(var_334_0) then
					local var_334_4 = Mathf.Lerp(0, 0.5, var_334_3)

					arg_331_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_331_1.var_.characterEffect1084ui_story.fillRatio = var_334_4
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1084ui_story then
				local var_334_5 = 0.5

				arg_331_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_331_1.var_.characterEffect1084ui_story.fillRatio = var_334_5
			end

			local var_334_6 = 0
			local var_334_7 = 0.225

			if var_334_6 < arg_331_1.time_ and arg_331_1.time_ <= var_334_6 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_8 = arg_331_1:FormatText(StoryNameCfg[693].name)

				arg_331_1.leftNameTxt_.text = var_334_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, true)
				arg_331_1.iconController_:SetSelectedState("hero")

				arg_331_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10069")

				arg_331_1.callingController_:SetSelectedState("normal")

				arg_331_1.keyicon_.color = Color.New(1, 1, 1)
				arg_331_1.icon_.color = Color.New(1, 1, 1)

				local var_334_9 = arg_331_1:GetWordFromCfg(319391079)
				local var_334_10 = arg_331_1:FormatText(var_334_9.content)

				arg_331_1.text_.text = var_334_10

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_11 = 9
				local var_334_12 = utf8.len(var_334_10)
				local var_334_13 = var_334_11 <= 0 and var_334_7 or var_334_7 * (var_334_12 / var_334_11)

				if var_334_13 > 0 and var_334_7 < var_334_13 then
					arg_331_1.talkMaxDuration = var_334_13

					if var_334_13 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_13 + var_334_6
					end
				end

				arg_331_1.text_.text = var_334_10
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391079", "story_v_out_319391.awb") ~= 0 then
					local var_334_14 = manager.audio:GetVoiceLength("story_v_out_319391", "319391079", "story_v_out_319391.awb") / 1000

					if var_334_14 + var_334_6 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_14 + var_334_6
					end

					if var_334_9.prefab_name ~= "" and arg_331_1.actors_[var_334_9.prefab_name] ~= nil then
						local var_334_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_9.prefab_name].transform, "story_v_out_319391", "319391079", "story_v_out_319391.awb")

						arg_331_1:RecordAudio("319391079", var_334_15)
						arg_331_1:RecordAudio("319391079", var_334_15)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_319391", "319391079", "story_v_out_319391.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_319391", "319391079", "story_v_out_319391.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_16 = math.max(var_334_7, arg_331_1.talkMaxDuration)

			if var_334_6 <= arg_331_1.time_ and arg_331_1.time_ < var_334_6 + var_334_16 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_6) / var_334_16

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_6 + var_334_16 and arg_331_1.time_ < var_334_6 + var_334_16 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play319391080 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 319391080
		arg_335_1.duration_ = 7.43

		local var_335_0 = {
			zh = 4.366,
			ja = 7.433
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
			local var_338_1 = 0.5

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_2 = arg_335_1:FormatText(StoryNameCfg[693].name)

				arg_335_1.leftNameTxt_.text = var_338_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10069")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_3 = arg_335_1:GetWordFromCfg(319391080)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_319391", "319391080", "story_v_out_319391.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_out_319391", "319391080", "story_v_out_319391.awb") / 1000

					if var_338_8 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_0
					end

					if var_338_3.prefab_name ~= "" and arg_335_1.actors_[var_338_3.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_3.prefab_name].transform, "story_v_out_319391", "319391080", "story_v_out_319391.awb")

						arg_335_1:RecordAudio("319391080", var_338_9)
						arg_335_1:RecordAudio("319391080", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_319391", "319391080", "story_v_out_319391.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_319391", "319391080", "story_v_out_319391.awb")
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
		"TextureConfig/Background/ST72",
		"TextureConfig/Background/ST71a",
		"TextureConfig/Background/ST71",
		"TextureConfig/Background/ST70",
		"TextureConfig/Background/I11l",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319391.awb"
	}
}
