return {
	Play319881001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319881001
		arg_1_1.duration_ = 4.73

		local var_1_0 = {
			zh = 3.899999999999,
			ja = 4.733
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
				arg_1_0:Play319881002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST70a"

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
				local var_4_5 = arg_1_1.bgs_.ST70a

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
					if iter_4_0 ~= "ST70a" then
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

			local var_4_24 = "1095ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1095ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1095ui_story"].transform
			local var_4_30 = 1.9

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1095ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -0.98, -6.1)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1095ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1095ui_story"]
			local var_4_39 = 1.9

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1095ui_story == nil then
				arg_1_1.var_.characterEffect1095ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1095ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1095ui_story then
				arg_1_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_4_42 = 1.9

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_4_43 = 1.9

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_4_44 = 0
			local var_4_45 = 0.2

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "music"

				arg_1_1:AudioAction(var_4_46, var_4_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_48 = ""
				local var_4_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_49 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_49 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_49

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_49
						arg_1_1.bgmTxt2_.text = var_4_49
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

			local var_4_50 = 0.233333333333333
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

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
			local var_4_57 = 0.25

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_58 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_58:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[471].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(319881001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881001", "story_v_out_319881.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_319881", "319881001", "story_v_out_319881.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_319881", "319881001", "story_v_out_319881.awb")

						arg_1_1:RecordAudio("319881001", var_4_66)
						arg_1_1:RecordAudio("319881001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319881", "319881001", "story_v_out_319881.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319881", "319881001", "story_v_out_319881.awb")
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play319881002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319881002
		arg_9_1.duration_ = 3.17

		local var_9_0 = {
			zh = 1.999999999999,
			ja = 3.166
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
				arg_9_0:Play319881003(arg_9_1)
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
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_12_20 = arg_9_1.actors_["1095ui_story"].transform
			local var_12_21 = 0

			if var_12_21 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 then
				arg_9_1.var_.moveOldPos1095ui_story = var_12_20.localPosition
			end

			local var_12_22 = 0.001

			if var_12_21 <= arg_9_1.time_ and arg_9_1.time_ < var_12_21 + var_12_22 then
				local var_12_23 = (arg_9_1.time_ - var_12_21) / var_12_22
				local var_12_24 = Vector3.New(-0.7, -0.98, -6.1)

				var_12_20.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1095ui_story, var_12_24, var_12_23)

				local var_12_25 = manager.ui.mainCamera.transform.position - var_12_20.position

				var_12_20.forward = Vector3.New(var_12_25.x, var_12_25.y, var_12_25.z)

				local var_12_26 = var_12_20.localEulerAngles

				var_12_26.z = 0
				var_12_26.x = 0
				var_12_20.localEulerAngles = var_12_26
			end

			if arg_9_1.time_ >= var_12_21 + var_12_22 and arg_9_1.time_ < var_12_21 + var_12_22 + arg_12_0 then
				var_12_20.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_12_27 = manager.ui.mainCamera.transform.position - var_12_20.position

				var_12_20.forward = Vector3.New(var_12_27.x, var_12_27.y, var_12_27.z)

				local var_12_28 = var_12_20.localEulerAngles

				var_12_28.z = 0
				var_12_28.x = 0
				var_12_20.localEulerAngles = var_12_28
			end

			local var_12_29 = arg_9_1.actors_["1095ui_story"]
			local var_12_30 = 0

			if var_12_30 < arg_9_1.time_ and arg_9_1.time_ <= var_12_30 + arg_12_0 and not isNil(var_12_29) and arg_9_1.var_.characterEffect1095ui_story == nil then
				arg_9_1.var_.characterEffect1095ui_story = var_12_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_31 = 0.200000002980232

			if var_12_30 <= arg_9_1.time_ and arg_9_1.time_ < var_12_30 + var_12_31 and not isNil(var_12_29) then
				local var_12_32 = (arg_9_1.time_ - var_12_30) / var_12_31

				if arg_9_1.var_.characterEffect1095ui_story and not isNil(var_12_29) then
					local var_12_33 = Mathf.Lerp(0, 0.5, var_12_32)

					arg_9_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1095ui_story.fillRatio = var_12_33
				end
			end

			if arg_9_1.time_ >= var_12_30 + var_12_31 and arg_9_1.time_ < var_12_30 + var_12_31 + arg_12_0 and not isNil(var_12_29) and arg_9_1.var_.characterEffect1095ui_story then
				local var_12_34 = 0.5

				arg_9_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1095ui_story.fillRatio = var_12_34
			end

			local var_12_35 = 0
			local var_12_36 = 0.15

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

				local var_12_38 = arg_9_1:GetWordFromCfg(319881002)
				local var_12_39 = arg_9_1:FormatText(var_12_38.content)

				arg_9_1.text_.text = var_12_39

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_40 = 6
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

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881002", "story_v_out_319881.awb") ~= 0 then
					local var_12_43 = manager.audio:GetVoiceLength("story_v_out_319881", "319881002", "story_v_out_319881.awb") / 1000

					if var_12_43 + var_12_35 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_43 + var_12_35
					end

					if var_12_38.prefab_name ~= "" and arg_9_1.actors_[var_12_38.prefab_name] ~= nil then
						local var_12_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_38.prefab_name].transform, "story_v_out_319881", "319881002", "story_v_out_319881.awb")

						arg_9_1:RecordAudio("319881002", var_12_44)
						arg_9_1:RecordAudio("319881002", var_12_44)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319881", "319881002", "story_v_out_319881.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319881", "319881002", "story_v_out_319881.awb")
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
				actorName = "1095ui_story",
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
	Play319881003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319881003
		arg_13_1.duration_ = 2.93

		local var_13_0 = {
			zh = 1.366,
			ja = 2.933
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
				arg_13_0:Play319881004(arg_13_1)
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

			local var_16_6 = arg_13_1.actors_["1095ui_story"]
			local var_16_7 = 0

			if var_16_7 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 and not isNil(var_16_6) and arg_13_1.var_.characterEffect1095ui_story == nil then
				arg_13_1.var_.characterEffect1095ui_story = var_16_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_8 = 0.200000002980232

			if var_16_7 <= arg_13_1.time_ and arg_13_1.time_ < var_16_7 + var_16_8 and not isNil(var_16_6) then
				local var_16_9 = (arg_13_1.time_ - var_16_7) / var_16_8

				if arg_13_1.var_.characterEffect1095ui_story and not isNil(var_16_6) then
					arg_13_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_7 + var_16_8 and arg_13_1.time_ < var_16_7 + var_16_8 + arg_16_0 and not isNil(var_16_6) and arg_13_1.var_.characterEffect1095ui_story then
				arg_13_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_16_10 = 0
			local var_16_11 = 0.175

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_12 = arg_13_1:FormatText(StoryNameCfg[471].name)

				arg_13_1.leftNameTxt_.text = var_16_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_13 = arg_13_1:GetWordFromCfg(319881003)
				local var_16_14 = arg_13_1:FormatText(var_16_13.content)

				arg_13_1.text_.text = var_16_14

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 7
				local var_16_16 = utf8.len(var_16_14)
				local var_16_17 = var_16_15 <= 0 and var_16_11 or var_16_11 * (var_16_16 / var_16_15)

				if var_16_17 > 0 and var_16_11 < var_16_17 then
					arg_13_1.talkMaxDuration = var_16_17

					if var_16_17 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_17 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_14
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881003", "story_v_out_319881.awb") ~= 0 then
					local var_16_18 = manager.audio:GetVoiceLength("story_v_out_319881", "319881003", "story_v_out_319881.awb") / 1000

					if var_16_18 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_18 + var_16_10
					end

					if var_16_13.prefab_name ~= "" and arg_13_1.actors_[var_16_13.prefab_name] ~= nil then
						local var_16_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_13.prefab_name].transform, "story_v_out_319881", "319881003", "story_v_out_319881.awb")

						arg_13_1:RecordAudio("319881003", var_16_19)
						arg_13_1:RecordAudio("319881003", var_16_19)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319881", "319881003", "story_v_out_319881.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319881", "319881003", "story_v_out_319881.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_20 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_20 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_10) / var_16_20

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_10 + var_16_20 and arg_13_1.time_ < var_16_10 + var_16_20 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play319881004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319881004
		arg_17_1.duration_ = 2.9

		local var_17_0 = {
			zh = 1.733,
			ja = 2.9
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
				arg_17_0:Play319881005(arg_17_1)
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
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_20_4 = arg_17_1.actors_["1095ui_story"]
			local var_20_5 = 0

			if var_20_5 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1095ui_story == nil then
				arg_17_1.var_.characterEffect1095ui_story = var_20_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_6 and not isNil(var_20_4) then
				local var_20_7 = (arg_17_1.time_ - var_20_5) / var_20_6

				if arg_17_1.var_.characterEffect1095ui_story and not isNil(var_20_4) then
					local var_20_8 = Mathf.Lerp(0, 0.5, var_20_7)

					arg_17_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1095ui_story.fillRatio = var_20_8
				end
			end

			if arg_17_1.time_ >= var_20_5 + var_20_6 and arg_17_1.time_ < var_20_5 + var_20_6 + arg_20_0 and not isNil(var_20_4) and arg_17_1.var_.characterEffect1095ui_story then
				local var_20_9 = 0.5

				arg_17_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1095ui_story.fillRatio = var_20_9
			end

			local var_20_10 = 0
			local var_20_11 = 0.15

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_12 = arg_17_1:FormatText(StoryNameCfg[6].name)

				arg_17_1.leftNameTxt_.text = var_20_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_13 = arg_17_1:GetWordFromCfg(319881004)
				local var_20_14 = arg_17_1:FormatText(var_20_13.content)

				arg_17_1.text_.text = var_20_14

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_15 = 6
				local var_20_16 = utf8.len(var_20_14)
				local var_20_17 = var_20_15 <= 0 and var_20_11 or var_20_11 * (var_20_16 / var_20_15)

				if var_20_17 > 0 and var_20_11 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_10
					end
				end

				arg_17_1.text_.text = var_20_14
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881004", "story_v_out_319881.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_319881", "319881004", "story_v_out_319881.awb") / 1000

					if var_20_18 + var_20_10 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_10
					end

					if var_20_13.prefab_name ~= "" and arg_17_1.actors_[var_20_13.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_13.prefab_name].transform, "story_v_out_319881", "319881004", "story_v_out_319881.awb")

						arg_17_1:RecordAudio("319881004", var_20_19)
						arg_17_1:RecordAudio("319881004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319881", "319881004", "story_v_out_319881.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319881", "319881004", "story_v_out_319881.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_20 = math.max(var_20_11, arg_17_1.talkMaxDuration)

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_10) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_10 + var_20_20 and arg_17_1.time_ < var_20_10 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play319881005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319881005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play319881006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1084ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1084ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1084ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1084ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1084ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 1.225

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:GetWordFromCfg(319881005)
				local var_24_9 = arg_21_1:FormatText(var_24_8.content)

				arg_21_1.text_.text = var_24_9

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 49
				local var_24_11 = utf8.len(var_24_9)
				local var_24_12 = var_24_10 <= 0 and var_24_7 or var_24_7 * (var_24_11 / var_24_10)

				if var_24_12 > 0 and var_24_7 < var_24_12 then
					arg_21_1.talkMaxDuration = var_24_12

					if var_24_12 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_12 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_9
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_13 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_13 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_13

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_13 and arg_21_1.time_ < var_24_6 + var_24_13 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play319881006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319881006
		arg_25_1.duration_ = 9.77

		local var_25_0 = {
			zh = 4.866,
			ja = 9.766
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
				arg_25_0:Play319881007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1084ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1084ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0.7, -0.97, -6)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1084ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1084ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1084ui_story and not isNil(var_28_9) then
					arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1084ui_story then
				arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_28_13 = 0

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_28_14 = 0

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_28_15 = 0
			local var_28_16 = 0.7

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_17 = arg_25_1:FormatText(StoryNameCfg[6].name)

				arg_25_1.leftNameTxt_.text = var_28_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_18 = arg_25_1:GetWordFromCfg(319881006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_20 = 28
				local var_28_21 = utf8.len(var_28_19)
				local var_28_22 = var_28_20 <= 0 and var_28_16 or var_28_16 * (var_28_21 / var_28_20)

				if var_28_22 > 0 and var_28_16 < var_28_22 then
					arg_25_1.talkMaxDuration = var_28_22

					if var_28_22 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_19
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881006", "story_v_out_319881.awb") ~= 0 then
					local var_28_23 = manager.audio:GetVoiceLength("story_v_out_319881", "319881006", "story_v_out_319881.awb") / 1000

					if var_28_23 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_15
					end

					if var_28_18.prefab_name ~= "" and arg_25_1.actors_[var_28_18.prefab_name] ~= nil then
						local var_28_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_18.prefab_name].transform, "story_v_out_319881", "319881006", "story_v_out_319881.awb")

						arg_25_1:RecordAudio("319881006", var_28_24)
						arg_25_1:RecordAudio("319881006", var_28_24)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319881", "319881006", "story_v_out_319881.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319881", "319881006", "story_v_out_319881.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_25 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_25 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_25

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_25 and arg_25_1.time_ < var_28_15 + var_28_25 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
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

		arg_25_1:InitPlayNodeList()
	end,
	Play319881007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319881007
		arg_29_1.duration_ = 14.9

		local var_29_0 = {
			zh = 6.5,
			ja = 14.9
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
				arg_29_0:Play319881008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1095ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1095ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1095ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["1095ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1095ui_story == nil then
				arg_29_1.var_.characterEffect1095ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect1095ui_story and not isNil(var_32_9) then
					arg_29_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1095ui_story then
				arg_29_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_32_13 = arg_29_1.actors_["1084ui_story"]
			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 and not isNil(var_32_13) and arg_29_1.var_.characterEffect1084ui_story == nil then
				arg_29_1.var_.characterEffect1084ui_story = var_32_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_15 = 0.200000002980232

			if var_32_14 <= arg_29_1.time_ and arg_29_1.time_ < var_32_14 + var_32_15 and not isNil(var_32_13) then
				local var_32_16 = (arg_29_1.time_ - var_32_14) / var_32_15

				if arg_29_1.var_.characterEffect1084ui_story and not isNil(var_32_13) then
					local var_32_17 = Mathf.Lerp(0, 0.5, var_32_16)

					arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1084ui_story.fillRatio = var_32_17
				end
			end

			if arg_29_1.time_ >= var_32_14 + var_32_15 and arg_29_1.time_ < var_32_14 + var_32_15 + arg_32_0 and not isNil(var_32_13) and arg_29_1.var_.characterEffect1084ui_story then
				local var_32_18 = 0.5

				arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1084ui_story.fillRatio = var_32_18
			end

			local var_32_19 = 0
			local var_32_20 = 0.875

			if var_32_19 < arg_29_1.time_ and arg_29_1.time_ <= var_32_19 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_21 = arg_29_1:FormatText(StoryNameCfg[471].name)

				arg_29_1.leftNameTxt_.text = var_32_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_22 = arg_29_1:GetWordFromCfg(319881007)
				local var_32_23 = arg_29_1:FormatText(var_32_22.content)

				arg_29_1.text_.text = var_32_23

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_24 = 35
				local var_32_25 = utf8.len(var_32_23)
				local var_32_26 = var_32_24 <= 0 and var_32_20 or var_32_20 * (var_32_25 / var_32_24)

				if var_32_26 > 0 and var_32_20 < var_32_26 then
					arg_29_1.talkMaxDuration = var_32_26

					if var_32_26 + var_32_19 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_26 + var_32_19
					end
				end

				arg_29_1.text_.text = var_32_23
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881007", "story_v_out_319881.awb") ~= 0 then
					local var_32_27 = manager.audio:GetVoiceLength("story_v_out_319881", "319881007", "story_v_out_319881.awb") / 1000

					if var_32_27 + var_32_19 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_27 + var_32_19
					end

					if var_32_22.prefab_name ~= "" and arg_29_1.actors_[var_32_22.prefab_name] ~= nil then
						local var_32_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_22.prefab_name].transform, "story_v_out_319881", "319881007", "story_v_out_319881.awb")

						arg_29_1:RecordAudio("319881007", var_32_28)
						arg_29_1:RecordAudio("319881007", var_32_28)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319881", "319881007", "story_v_out_319881.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319881", "319881007", "story_v_out_319881.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_29 = math.max(var_32_20, arg_29_1.talkMaxDuration)

			if var_32_19 <= arg_29_1.time_ and arg_29_1.time_ < var_32_19 + var_32_29 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_19) / var_32_29

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_19 + var_32_29 and arg_29_1.time_ < var_32_19 + var_32_29 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319881008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319881008
		arg_33_1.duration_ = 4.83

		local var_33_0 = {
			zh = 4,
			ja = 4.833
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
				arg_33_0:Play319881009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1095ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1095ui_story == nil then
				arg_33_1.var_.characterEffect1095ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1095ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1095ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1095ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1095ui_story.fillRatio = var_36_5
			end

			local var_36_6 = arg_33_1.actors_["1084ui_story"]
			local var_36_7 = 0

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect1084ui_story == nil then
				arg_33_1.var_.characterEffect1084ui_story = var_36_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_8 = 0.200000002980232

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_8 and not isNil(var_36_6) then
				local var_36_9 = (arg_33_1.time_ - var_36_7) / var_36_8

				if arg_33_1.var_.characterEffect1084ui_story and not isNil(var_36_6) then
					arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_7 + var_36_8 and arg_33_1.time_ < var_36_7 + var_36_8 + arg_36_0 and not isNil(var_36_6) and arg_33_1.var_.characterEffect1084ui_story then
				arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_36_10 = 0
			local var_36_11 = 0.525

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_12 = arg_33_1:FormatText(StoryNameCfg[6].name)

				arg_33_1.leftNameTxt_.text = var_36_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_13 = arg_33_1:GetWordFromCfg(319881008)
				local var_36_14 = arg_33_1:FormatText(var_36_13.content)

				arg_33_1.text_.text = var_36_14

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_15 = 21
				local var_36_16 = utf8.len(var_36_14)
				local var_36_17 = var_36_15 <= 0 and var_36_11 or var_36_11 * (var_36_16 / var_36_15)

				if var_36_17 > 0 and var_36_11 < var_36_17 then
					arg_33_1.talkMaxDuration = var_36_17

					if var_36_17 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_17 + var_36_10
					end
				end

				arg_33_1.text_.text = var_36_14
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881008", "story_v_out_319881.awb") ~= 0 then
					local var_36_18 = manager.audio:GetVoiceLength("story_v_out_319881", "319881008", "story_v_out_319881.awb") / 1000

					if var_36_18 + var_36_10 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_18 + var_36_10
					end

					if var_36_13.prefab_name ~= "" and arg_33_1.actors_[var_36_13.prefab_name] ~= nil then
						local var_36_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_13.prefab_name].transform, "story_v_out_319881", "319881008", "story_v_out_319881.awb")

						arg_33_1:RecordAudio("319881008", var_36_19)
						arg_33_1:RecordAudio("319881008", var_36_19)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319881", "319881008", "story_v_out_319881.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319881", "319881008", "story_v_out_319881.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_20 = math.max(var_36_11, arg_33_1.talkMaxDuration)

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_20 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_10) / var_36_20

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_10 + var_36_20 and arg_33_1.time_ < var_36_10 + var_36_20 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play319881009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319881009
		arg_37_1.duration_ = 15.23

		local var_37_0 = {
			zh = 8.3,
			ja = 15.233
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
				arg_37_0:Play319881010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1084ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1084ui_story == nil then
				arg_37_1.var_.characterEffect1084ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1084ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1084ui_story then
				arg_37_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_40_4 = 0

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4138")
			end

			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_6 = 0
			local var_40_7 = 1.125

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[6].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_9 = arg_37_1:GetWordFromCfg(319881009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 45
				local var_40_12 = utf8.len(var_40_10)
				local var_40_13 = var_40_11 <= 0 and var_40_7 or var_40_7 * (var_40_12 / var_40_11)

				if var_40_13 > 0 and var_40_7 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881009", "story_v_out_319881.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_319881", "319881009", "story_v_out_319881.awb") / 1000

					if var_40_14 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_6
					end

					if var_40_9.prefab_name ~= "" and arg_37_1.actors_[var_40_9.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_9.prefab_name].transform, "story_v_out_319881", "319881009", "story_v_out_319881.awb")

						arg_37_1:RecordAudio("319881009", var_40_15)
						arg_37_1:RecordAudio("319881009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319881", "319881009", "story_v_out_319881.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319881", "319881009", "story_v_out_319881.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_16 and arg_37_1.time_ < var_40_6 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play319881010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319881010
		arg_41_1.duration_ = 4.17

		local var_41_0 = {
			zh = 2.5,
			ja = 4.166
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
				arg_41_0:Play319881011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1095ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1095ui_story == nil then
				arg_41_1.var_.characterEffect1095ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1095ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1095ui_story then
				arg_41_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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
			local var_44_13 = 0.325

			if var_44_12 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_14 = arg_41_1:FormatText(StoryNameCfg[471].name)

				arg_41_1.leftNameTxt_.text = var_44_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_15 = arg_41_1:GetWordFromCfg(319881010)
				local var_44_16 = arg_41_1:FormatText(var_44_15.content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 13
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

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881010", "story_v_out_319881.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_319881", "319881010", "story_v_out_319881.awb") / 1000

					if var_44_20 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_12
					end

					if var_44_15.prefab_name ~= "" and arg_41_1.actors_[var_44_15.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_15.prefab_name].transform, "story_v_out_319881", "319881010", "story_v_out_319881.awb")

						arg_41_1:RecordAudio("319881010", var_44_21)
						arg_41_1:RecordAudio("319881010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319881", "319881010", "story_v_out_319881.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319881", "319881010", "story_v_out_319881.awb")
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
	Play319881011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319881011
		arg_45_1.duration_ = 3.1

		local var_45_0 = {
			zh = 2.033,
			ja = 3.1
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
				arg_45_0:Play319881012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1095ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1095ui_story == nil then
				arg_45_1.var_.characterEffect1095ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1095ui_story and not isNil(var_48_0) then
					local var_48_4 = Mathf.Lerp(0, 0.5, var_48_3)

					arg_45_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1095ui_story.fillRatio = var_48_4
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1095ui_story then
				local var_48_5 = 0.5

				arg_45_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1095ui_story.fillRatio = var_48_5
			end

			local var_48_6 = arg_45_1.actors_["1084ui_story"]
			local var_48_7 = 0

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1084ui_story == nil then
				arg_45_1.var_.characterEffect1084ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_8 = 0.200000002980232

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_8 and not isNil(var_48_6) then
				local var_48_9 = (arg_45_1.time_ - var_48_7) / var_48_8

				if arg_45_1.var_.characterEffect1084ui_story and not isNil(var_48_6) then
					arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_7 + var_48_8 and arg_45_1.time_ < var_48_7 + var_48_8 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1084ui_story then
				arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_48_10 = 0
			local var_48_11 = 0.225

			if var_48_10 < arg_45_1.time_ and arg_45_1.time_ <= var_48_10 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_12 = arg_45_1:FormatText(StoryNameCfg[6].name)

				arg_45_1.leftNameTxt_.text = var_48_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_13 = arg_45_1:GetWordFromCfg(319881011)
				local var_48_14 = arg_45_1:FormatText(var_48_13.content)

				arg_45_1.text_.text = var_48_14

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_15 = 9
				local var_48_16 = utf8.len(var_48_14)
				local var_48_17 = var_48_15 <= 0 and var_48_11 or var_48_11 * (var_48_16 / var_48_15)

				if var_48_17 > 0 and var_48_11 < var_48_17 then
					arg_45_1.talkMaxDuration = var_48_17

					if var_48_17 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_17 + var_48_10
					end
				end

				arg_45_1.text_.text = var_48_14
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881011", "story_v_out_319881.awb") ~= 0 then
					local var_48_18 = manager.audio:GetVoiceLength("story_v_out_319881", "319881011", "story_v_out_319881.awb") / 1000

					if var_48_18 + var_48_10 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_18 + var_48_10
					end

					if var_48_13.prefab_name ~= "" and arg_45_1.actors_[var_48_13.prefab_name] ~= nil then
						local var_48_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_13.prefab_name].transform, "story_v_out_319881", "319881011", "story_v_out_319881.awb")

						arg_45_1:RecordAudio("319881011", var_48_19)
						arg_45_1:RecordAudio("319881011", var_48_19)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319881", "319881011", "story_v_out_319881.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319881", "319881011", "story_v_out_319881.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_20 = math.max(var_48_11, arg_45_1.talkMaxDuration)

			if var_48_10 <= arg_45_1.time_ and arg_45_1.time_ < var_48_10 + var_48_20 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_10) / var_48_20

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_10 + var_48_20 and arg_45_1.time_ < var_48_10 + var_48_20 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play319881012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319881012
		arg_49_1.duration_ = 11.53

		local var_49_0 = {
			zh = 10.1,
			ja = 11.533
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
				arg_49_0:Play319881013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1095ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1095ui_story == nil then
				arg_49_1.var_.characterEffect1095ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1095ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1095ui_story then
				arg_49_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_52_4 = arg_49_1.actors_["1084ui_story"]
			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1084ui_story == nil then
				arg_49_1.var_.characterEffect1084ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_6 = 0.200000002980232

			if var_52_5 <= arg_49_1.time_ and arg_49_1.time_ < var_52_5 + var_52_6 and not isNil(var_52_4) then
				local var_52_7 = (arg_49_1.time_ - var_52_5) / var_52_6

				if arg_49_1.var_.characterEffect1084ui_story and not isNil(var_52_4) then
					local var_52_8 = Mathf.Lerp(0, 0.5, var_52_7)

					arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1084ui_story.fillRatio = var_52_8
				end
			end

			if arg_49_1.time_ >= var_52_5 + var_52_6 and arg_49_1.time_ < var_52_5 + var_52_6 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1084ui_story then
				local var_52_9 = 0.5

				arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1084ui_story.fillRatio = var_52_9
			end

			local var_52_10 = 0
			local var_52_11 = 1.275

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_12 = arg_49_1:FormatText(StoryNameCfg[471].name)

				arg_49_1.leftNameTxt_.text = var_52_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_13 = arg_49_1:GetWordFromCfg(319881012)
				local var_52_14 = arg_49_1:FormatText(var_52_13.content)

				arg_49_1.text_.text = var_52_14

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_15 = 51
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

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881012", "story_v_out_319881.awb") ~= 0 then
					local var_52_18 = manager.audio:GetVoiceLength("story_v_out_319881", "319881012", "story_v_out_319881.awb") / 1000

					if var_52_18 + var_52_10 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_18 + var_52_10
					end

					if var_52_13.prefab_name ~= "" and arg_49_1.actors_[var_52_13.prefab_name] ~= nil then
						local var_52_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_13.prefab_name].transform, "story_v_out_319881", "319881012", "story_v_out_319881.awb")

						arg_49_1:RecordAudio("319881012", var_52_19)
						arg_49_1:RecordAudio("319881012", var_52_19)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319881", "319881012", "story_v_out_319881.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319881", "319881012", "story_v_out_319881.awb")
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
	Play319881013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319881013
		arg_53_1.duration_ = 8.3

		local var_53_0 = {
			zh = 6.4,
			ja = 8.3
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
				arg_53_0:Play319881014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 0.775

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[471].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(319881013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 31
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881013", "story_v_out_319881.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881013", "story_v_out_319881.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_319881", "319881013", "story_v_out_319881.awb")

						arg_53_1:RecordAudio("319881013", var_56_9)
						arg_53_1:RecordAudio("319881013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319881", "319881013", "story_v_out_319881.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319881", "319881013", "story_v_out_319881.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play319881014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319881014
		arg_57_1.duration_ = 7.4

		local var_57_0 = {
			zh = 7.4,
			ja = 7
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
				arg_57_0:Play319881015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1084ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1084ui_story == nil then
				arg_57_1.var_.characterEffect1084ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1084ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1084ui_story then
				arg_57_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_60_4 = 0

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action487")
			end

			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_6 = arg_57_1.actors_["1095ui_story"]
			local var_60_7 = 0

			if var_60_7 < arg_57_1.time_ and arg_57_1.time_ <= var_60_7 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1095ui_story == nil then
				arg_57_1.var_.characterEffect1095ui_story = var_60_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_8 = 0.200000002980232

			if var_60_7 <= arg_57_1.time_ and arg_57_1.time_ < var_60_7 + var_60_8 and not isNil(var_60_6) then
				local var_60_9 = (arg_57_1.time_ - var_60_7) / var_60_8

				if arg_57_1.var_.characterEffect1095ui_story and not isNil(var_60_6) then
					local var_60_10 = Mathf.Lerp(0, 0.5, var_60_9)

					arg_57_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1095ui_story.fillRatio = var_60_10
				end
			end

			if arg_57_1.time_ >= var_60_7 + var_60_8 and arg_57_1.time_ < var_60_7 + var_60_8 + arg_60_0 and not isNil(var_60_6) and arg_57_1.var_.characterEffect1095ui_story then
				local var_60_11 = 0.5

				arg_57_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1095ui_story.fillRatio = var_60_11
			end

			local var_60_12 = 0
			local var_60_13 = 0.95

			if var_60_12 < arg_57_1.time_ and arg_57_1.time_ <= var_60_12 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_14 = arg_57_1:FormatText(StoryNameCfg[6].name)

				arg_57_1.leftNameTxt_.text = var_60_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_15 = arg_57_1:GetWordFromCfg(319881014)
				local var_60_16 = arg_57_1:FormatText(var_60_15.content)

				arg_57_1.text_.text = var_60_16

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_17 = 38
				local var_60_18 = utf8.len(var_60_16)
				local var_60_19 = var_60_17 <= 0 and var_60_13 or var_60_13 * (var_60_18 / var_60_17)

				if var_60_19 > 0 and var_60_13 < var_60_19 then
					arg_57_1.talkMaxDuration = var_60_19

					if var_60_19 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_19 + var_60_12
					end
				end

				arg_57_1.text_.text = var_60_16
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881014", "story_v_out_319881.awb") ~= 0 then
					local var_60_20 = manager.audio:GetVoiceLength("story_v_out_319881", "319881014", "story_v_out_319881.awb") / 1000

					if var_60_20 + var_60_12 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_20 + var_60_12
					end

					if var_60_15.prefab_name ~= "" and arg_57_1.actors_[var_60_15.prefab_name] ~= nil then
						local var_60_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_15.prefab_name].transform, "story_v_out_319881", "319881014", "story_v_out_319881.awb")

						arg_57_1:RecordAudio("319881014", var_60_21)
						arg_57_1:RecordAudio("319881014", var_60_21)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319881", "319881014", "story_v_out_319881.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319881", "319881014", "story_v_out_319881.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_22 = math.max(var_60_13, arg_57_1.talkMaxDuration)

			if var_60_12 <= arg_57_1.time_ and arg_57_1.time_ < var_60_12 + var_60_22 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_12) / var_60_22

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_12 + var_60_22 and arg_57_1.time_ < var_60_12 + var_60_22 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play319881015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319881015
		arg_61_1.duration_ = 2

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play319881016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1095ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1095ui_story == nil then
				arg_61_1.var_.characterEffect1095ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1095ui_story and not isNil(var_64_0) then
					arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1095ui_story then
				arg_61_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_64_4 = 0

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_64_5 = 0

			if var_64_5 < arg_61_1.time_ and arg_61_1.time_ <= var_64_5 + arg_64_0 then
				arg_61_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
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
			local var_64_13 = 0.075

			if var_64_12 < arg_61_1.time_ and arg_61_1.time_ <= var_64_12 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_14 = arg_61_1:FormatText(StoryNameCfg[471].name)

				arg_61_1.leftNameTxt_.text = var_64_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_15 = arg_61_1:GetWordFromCfg(319881015)
				local var_64_16 = arg_61_1:FormatText(var_64_15.content)

				arg_61_1.text_.text = var_64_16

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_17 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881015", "story_v_out_319881.awb") ~= 0 then
					local var_64_20 = manager.audio:GetVoiceLength("story_v_out_319881", "319881015", "story_v_out_319881.awb") / 1000

					if var_64_20 + var_64_12 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_12
					end

					if var_64_15.prefab_name ~= "" and arg_61_1.actors_[var_64_15.prefab_name] ~= nil then
						local var_64_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_15.prefab_name].transform, "story_v_out_319881", "319881015", "story_v_out_319881.awb")

						arg_61_1:RecordAudio("319881015", var_64_21)
						arg_61_1:RecordAudio("319881015", var_64_21)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319881", "319881015", "story_v_out_319881.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319881", "319881015", "story_v_out_319881.awb")
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
	Play319881016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319881016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play319881017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1095ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1095ui_story == nil then
				arg_65_1.var_.characterEffect1095ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1095ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1095ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1095ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1095ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_68_7 = 0
			local var_68_8 = 1

			if var_68_7 < arg_65_1.time_ and arg_65_1.time_ <= var_68_7 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, false)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_9 = arg_65_1:GetWordFromCfg(319881016)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 40
				local var_68_12 = utf8.len(var_68_10)
				local var_68_13 = var_68_11 <= 0 and var_68_8 or var_68_8 * (var_68_12 / var_68_11)

				if var_68_13 > 0 and var_68_8 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_7 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_7
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_8, arg_65_1.talkMaxDuration)

			if var_68_7 <= arg_65_1.time_ and arg_65_1.time_ < var_68_7 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_7) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_7 + var_68_14 and arg_65_1.time_ < var_68_7 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play319881017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319881017
		arg_69_1.duration_ = 3.67

		local var_69_0 = {
			zh = 2.1,
			ja = 3.666
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
				arg_69_0:Play319881018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1095ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1095ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1095ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["1095ui_story"]
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1095ui_story == nil then
				arg_69_1.var_.characterEffect1095ui_story = var_72_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 and not isNil(var_72_9) then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11

				if arg_69_1.var_.characterEffect1095ui_story and not isNil(var_72_9) then
					arg_69_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1095ui_story then
				arg_69_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_72_13 = 0
			local var_72_14 = 0.375

			if var_72_13 < arg_69_1.time_ and arg_69_1.time_ <= var_72_13 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_15 = arg_69_1:FormatText(StoryNameCfg[471].name)

				arg_69_1.leftNameTxt_.text = var_72_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_16 = arg_69_1:GetWordFromCfg(319881017)
				local var_72_17 = arg_69_1:FormatText(var_72_16.content)

				arg_69_1.text_.text = var_72_17

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_18 = 15
				local var_72_19 = utf8.len(var_72_17)
				local var_72_20 = var_72_18 <= 0 and var_72_14 or var_72_14 * (var_72_19 / var_72_18)

				if var_72_20 > 0 and var_72_14 < var_72_20 then
					arg_69_1.talkMaxDuration = var_72_20

					if var_72_20 + var_72_13 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_20 + var_72_13
					end
				end

				arg_69_1.text_.text = var_72_17
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881017", "story_v_out_319881.awb") ~= 0 then
					local var_72_21 = manager.audio:GetVoiceLength("story_v_out_319881", "319881017", "story_v_out_319881.awb") / 1000

					if var_72_21 + var_72_13 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_21 + var_72_13
					end

					if var_72_16.prefab_name ~= "" and arg_69_1.actors_[var_72_16.prefab_name] ~= nil then
						local var_72_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_16.prefab_name].transform, "story_v_out_319881", "319881017", "story_v_out_319881.awb")

						arg_69_1:RecordAudio("319881017", var_72_22)
						arg_69_1:RecordAudio("319881017", var_72_22)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319881", "319881017", "story_v_out_319881.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319881", "319881017", "story_v_out_319881.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_23 = math.max(var_72_14, arg_69_1.talkMaxDuration)

			if var_72_13 <= arg_69_1.time_ and arg_69_1.time_ < var_72_13 + var_72_23 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_13) / var_72_23

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_13 + var_72_23 and arg_69_1.time_ < var_72_13 + var_72_23 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play319881018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319881018
		arg_73_1.duration_ = 10

		local var_73_0 = {
			zh = 7.066,
			ja = 10
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
				arg_73_0:Play319881019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1084ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1084ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0.7, -0.97, -6)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1084ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["1084ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1084ui_story == nil then
				arg_73_1.var_.characterEffect1084ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect1084ui_story and not isNil(var_76_9) then
					arg_73_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1084ui_story then
				arg_73_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_76_13 = 0

			if var_76_13 < arg_73_1.time_ and arg_73_1.time_ <= var_76_13 + arg_76_0 then
				arg_73_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action473")
			end

			local var_76_14 = 0

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_76_15 = arg_73_1.actors_["1095ui_story"]
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.characterEffect1095ui_story == nil then
				arg_73_1.var_.characterEffect1095ui_story = var_76_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_17 = 0.200000002980232

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 and not isNil(var_76_15) then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17

				if arg_73_1.var_.characterEffect1095ui_story and not isNil(var_76_15) then
					local var_76_19 = Mathf.Lerp(0, 0.5, var_76_18)

					arg_73_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1095ui_story.fillRatio = var_76_19
				end
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.characterEffect1095ui_story then
				local var_76_20 = 0.5

				arg_73_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1095ui_story.fillRatio = var_76_20
			end

			local var_76_21 = 0
			local var_76_22 = 0.85

			if var_76_21 < arg_73_1.time_ and arg_73_1.time_ <= var_76_21 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_23 = arg_73_1:FormatText(StoryNameCfg[6].name)

				arg_73_1.leftNameTxt_.text = var_76_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_24 = arg_73_1:GetWordFromCfg(319881018)
				local var_76_25 = arg_73_1:FormatText(var_76_24.content)

				arg_73_1.text_.text = var_76_25

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_26 = 34
				local var_76_27 = utf8.len(var_76_25)
				local var_76_28 = var_76_26 <= 0 and var_76_22 or var_76_22 * (var_76_27 / var_76_26)

				if var_76_28 > 0 and var_76_22 < var_76_28 then
					arg_73_1.talkMaxDuration = var_76_28

					if var_76_28 + var_76_21 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_28 + var_76_21
					end
				end

				arg_73_1.text_.text = var_76_25
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881018", "story_v_out_319881.awb") ~= 0 then
					local var_76_29 = manager.audio:GetVoiceLength("story_v_out_319881", "319881018", "story_v_out_319881.awb") / 1000

					if var_76_29 + var_76_21 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_29 + var_76_21
					end

					if var_76_24.prefab_name ~= "" and arg_73_1.actors_[var_76_24.prefab_name] ~= nil then
						local var_76_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_24.prefab_name].transform, "story_v_out_319881", "319881018", "story_v_out_319881.awb")

						arg_73_1:RecordAudio("319881018", var_76_30)
						arg_73_1:RecordAudio("319881018", var_76_30)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_319881", "319881018", "story_v_out_319881.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_319881", "319881018", "story_v_out_319881.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_31 = math.max(var_76_22, arg_73_1.talkMaxDuration)

			if var_76_21 <= arg_73_1.time_ and arg_73_1.time_ < var_76_21 + var_76_31 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_21) / var_76_31

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_21 + var_76_31 and arg_73_1.time_ < var_76_21 + var_76_31 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play319881019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319881019
		arg_77_1.duration_ = 7.1

		local var_77_0 = {
			zh = 3.566,
			ja = 7.1
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
				arg_77_0:Play319881020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1084ui_story"]
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1084ui_story == nil then
				arg_77_1.var_.characterEffect1084ui_story = var_80_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 and not isNil(var_80_0) then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2

				if arg_77_1.var_.characterEffect1084ui_story and not isNil(var_80_0) then
					local var_80_4 = Mathf.Lerp(0, 0.5, var_80_3)

					arg_77_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1084ui_story.fillRatio = var_80_4
				end
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 and not isNil(var_80_0) and arg_77_1.var_.characterEffect1084ui_story then
				local var_80_5 = 0.5

				arg_77_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1084ui_story.fillRatio = var_80_5
			end

			local var_80_6 = arg_77_1.actors_["1095ui_story"]
			local var_80_7 = 0

			if var_80_7 < arg_77_1.time_ and arg_77_1.time_ <= var_80_7 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect1095ui_story == nil then
				arg_77_1.var_.characterEffect1095ui_story = var_80_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_8 = 0.200000002980232

			if var_80_7 <= arg_77_1.time_ and arg_77_1.time_ < var_80_7 + var_80_8 and not isNil(var_80_6) then
				local var_80_9 = (arg_77_1.time_ - var_80_7) / var_80_8

				if arg_77_1.var_.characterEffect1095ui_story and not isNil(var_80_6) then
					arg_77_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_7 + var_80_8 and arg_77_1.time_ < var_80_7 + var_80_8 + arg_80_0 and not isNil(var_80_6) and arg_77_1.var_.characterEffect1095ui_story then
				arg_77_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_80_10 = 0
			local var_80_11 = 0.425

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_12 = arg_77_1:FormatText(StoryNameCfg[471].name)

				arg_77_1.leftNameTxt_.text = var_80_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_13 = arg_77_1:GetWordFromCfg(319881019)
				local var_80_14 = arg_77_1:FormatText(var_80_13.content)

				arg_77_1.text_.text = var_80_14

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_15 = 17
				local var_80_16 = utf8.len(var_80_14)
				local var_80_17 = var_80_15 <= 0 and var_80_11 or var_80_11 * (var_80_16 / var_80_15)

				if var_80_17 > 0 and var_80_11 < var_80_17 then
					arg_77_1.talkMaxDuration = var_80_17

					if var_80_17 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_17 + var_80_10
					end
				end

				arg_77_1.text_.text = var_80_14
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881019", "story_v_out_319881.awb") ~= 0 then
					local var_80_18 = manager.audio:GetVoiceLength("story_v_out_319881", "319881019", "story_v_out_319881.awb") / 1000

					if var_80_18 + var_80_10 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_18 + var_80_10
					end

					if var_80_13.prefab_name ~= "" and arg_77_1.actors_[var_80_13.prefab_name] ~= nil then
						local var_80_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_13.prefab_name].transform, "story_v_out_319881", "319881019", "story_v_out_319881.awb")

						arg_77_1:RecordAudio("319881019", var_80_19)
						arg_77_1:RecordAudio("319881019", var_80_19)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319881", "319881019", "story_v_out_319881.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319881", "319881019", "story_v_out_319881.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_20 = math.max(var_80_11, arg_77_1.talkMaxDuration)

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_20 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_10) / var_80_20

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_10 + var_80_20 and arg_77_1.time_ < var_80_10 + var_80_20 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play319881020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319881020
		arg_81_1.duration_ = 2.37

		local var_81_0 = {
			zh = 1.333,
			ja = 2.366
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
				arg_81_0:Play319881021(arg_81_1)
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

			local var_84_4 = arg_81_1.actors_["1095ui_story"]
			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1095ui_story == nil then
				arg_81_1.var_.characterEffect1095ui_story = var_84_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_6 = 0.200000002980232

			if var_84_5 <= arg_81_1.time_ and arg_81_1.time_ < var_84_5 + var_84_6 and not isNil(var_84_4) then
				local var_84_7 = (arg_81_1.time_ - var_84_5) / var_84_6

				if arg_81_1.var_.characterEffect1095ui_story and not isNil(var_84_4) then
					local var_84_8 = Mathf.Lerp(0, 0.5, var_84_7)

					arg_81_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1095ui_story.fillRatio = var_84_8
				end
			end

			if arg_81_1.time_ >= var_84_5 + var_84_6 and arg_81_1.time_ < var_84_5 + var_84_6 + arg_84_0 and not isNil(var_84_4) and arg_81_1.var_.characterEffect1095ui_story then
				local var_84_9 = 0.5

				arg_81_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1095ui_story.fillRatio = var_84_9
			end

			local var_84_10 = 0
			local var_84_11 = 0.1

			if var_84_10 < arg_81_1.time_ and arg_81_1.time_ <= var_84_10 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_12 = arg_81_1:FormatText(StoryNameCfg[6].name)

				arg_81_1.leftNameTxt_.text = var_84_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_13 = arg_81_1:GetWordFromCfg(319881020)
				local var_84_14 = arg_81_1:FormatText(var_84_13.content)

				arg_81_1.text_.text = var_84_14

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_15 = 4
				local var_84_16 = utf8.len(var_84_14)
				local var_84_17 = var_84_15 <= 0 and var_84_11 or var_84_11 * (var_84_16 / var_84_15)

				if var_84_17 > 0 and var_84_11 < var_84_17 then
					arg_81_1.talkMaxDuration = var_84_17

					if var_84_17 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_17 + var_84_10
					end
				end

				arg_81_1.text_.text = var_84_14
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881020", "story_v_out_319881.awb") ~= 0 then
					local var_84_18 = manager.audio:GetVoiceLength("story_v_out_319881", "319881020", "story_v_out_319881.awb") / 1000

					if var_84_18 + var_84_10 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_18 + var_84_10
					end

					if var_84_13.prefab_name ~= "" and arg_81_1.actors_[var_84_13.prefab_name] ~= nil then
						local var_84_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_13.prefab_name].transform, "story_v_out_319881", "319881020", "story_v_out_319881.awb")

						arg_81_1:RecordAudio("319881020", var_84_19)
						arg_81_1:RecordAudio("319881020", var_84_19)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319881", "319881020", "story_v_out_319881.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319881", "319881020", "story_v_out_319881.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_20 = math.max(var_84_11, arg_81_1.talkMaxDuration)

			if var_84_10 <= arg_81_1.time_ and arg_81_1.time_ < var_84_10 + var_84_20 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_10) / var_84_20

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_10 + var_84_20 and arg_81_1.time_ < var_84_10 + var_84_20 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play319881021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319881021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play319881022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1084ui_story"]
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 and not isNil(var_88_0) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = var_88_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.2

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

			local var_88_6 = 0

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_88_7 = 0
			local var_88_8 = 0.625

			if var_88_7 < arg_85_1.time_ and arg_85_1.time_ <= var_88_7 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_9 = arg_85_1:GetWordFromCfg(319881021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 25
				local var_88_12 = utf8.len(var_88_10)
				local var_88_13 = var_88_11 <= 0 and var_88_8 or var_88_8 * (var_88_12 / var_88_11)

				if var_88_13 > 0 and var_88_8 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_7 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_7
					end
				end

				arg_85_1.text_.text = var_88_10
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_8, arg_85_1.talkMaxDuration)

			if var_88_7 <= arg_85_1.time_ and arg_85_1.time_ < var_88_7 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_7) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_7 + var_88_14 and arg_85_1.time_ < var_88_7 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play319881022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319881022
		arg_89_1.duration_ = 12.87

		local var_89_0 = {
			zh = 7.2,
			ja = 12.866
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
				arg_89_0:Play319881023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1095ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1095ui_story == nil then
				arg_89_1.var_.characterEffect1095ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1095ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1095ui_story then
				arg_89_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_92_4 = 0
			local var_92_5 = 0.875

			if var_92_4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_6 = arg_89_1:FormatText(StoryNameCfg[471].name)

				arg_89_1.leftNameTxt_.text = var_92_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_7 = arg_89_1:GetWordFromCfg(319881022)
				local var_92_8 = arg_89_1:FormatText(var_92_7.content)

				arg_89_1.text_.text = var_92_8

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_9 = 35
				local var_92_10 = utf8.len(var_92_8)
				local var_92_11 = var_92_9 <= 0 and var_92_5 or var_92_5 * (var_92_10 / var_92_9)

				if var_92_11 > 0 and var_92_5 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_4
					end
				end

				arg_89_1.text_.text = var_92_8
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881022", "story_v_out_319881.awb") ~= 0 then
					local var_92_12 = manager.audio:GetVoiceLength("story_v_out_319881", "319881022", "story_v_out_319881.awb") / 1000

					if var_92_12 + var_92_4 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_4
					end

					if var_92_7.prefab_name ~= "" and arg_89_1.actors_[var_92_7.prefab_name] ~= nil then
						local var_92_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_7.prefab_name].transform, "story_v_out_319881", "319881022", "story_v_out_319881.awb")

						arg_89_1:RecordAudio("319881022", var_92_13)
						arg_89_1:RecordAudio("319881022", var_92_13)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_319881", "319881022", "story_v_out_319881.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_319881", "319881022", "story_v_out_319881.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_5, arg_89_1.talkMaxDuration)

			if var_92_4 <= arg_89_1.time_ and arg_89_1.time_ < var_92_4 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_4) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_4 + var_92_14 and arg_89_1.time_ < var_92_4 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play319881023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319881023
		arg_93_1.duration_ = 7.13

		local var_93_0 = {
			zh = 4.266,
			ja = 7.133
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
				arg_93_0:Play319881024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				arg_93_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_96_2 = 0
			local var_96_3 = 0.5

			if var_96_2 < arg_93_1.time_ and arg_93_1.time_ <= var_96_2 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_4 = arg_93_1:FormatText(StoryNameCfg[471].name)

				arg_93_1.leftNameTxt_.text = var_96_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_5 = arg_93_1:GetWordFromCfg(319881023)
				local var_96_6 = arg_93_1:FormatText(var_96_5.content)

				arg_93_1.text_.text = var_96_6

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_7 = 20
				local var_96_8 = utf8.len(var_96_6)
				local var_96_9 = var_96_7 <= 0 and var_96_3 or var_96_3 * (var_96_8 / var_96_7)

				if var_96_9 > 0 and var_96_3 < var_96_9 then
					arg_93_1.talkMaxDuration = var_96_9

					if var_96_9 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_9 + var_96_2
					end
				end

				arg_93_1.text_.text = var_96_6
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881023", "story_v_out_319881.awb") ~= 0 then
					local var_96_10 = manager.audio:GetVoiceLength("story_v_out_319881", "319881023", "story_v_out_319881.awb") / 1000

					if var_96_10 + var_96_2 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_10 + var_96_2
					end

					if var_96_5.prefab_name ~= "" and arg_93_1.actors_[var_96_5.prefab_name] ~= nil then
						local var_96_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_5.prefab_name].transform, "story_v_out_319881", "319881023", "story_v_out_319881.awb")

						arg_93_1:RecordAudio("319881023", var_96_11)
						arg_93_1:RecordAudio("319881023", var_96_11)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319881", "319881023", "story_v_out_319881.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319881", "319881023", "story_v_out_319881.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_12 = math.max(var_96_3, arg_93_1.talkMaxDuration)

			if var_96_2 <= arg_93_1.time_ and arg_93_1.time_ < var_96_2 + var_96_12 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_2) / var_96_12

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_2 + var_96_12 and arg_93_1.time_ < var_96_2 + var_96_12 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319881024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319881024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play319881025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1084ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1084ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, 100, 0)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1084ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, 100, 0)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = arg_97_1.actors_["1084ui_story"]
			local var_100_10 = 0

			if var_100_10 < arg_97_1.time_ and arg_97_1.time_ <= var_100_10 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1084ui_story == nil then
				arg_97_1.var_.characterEffect1084ui_story = var_100_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_11 = 0.200000002980232

			if var_100_10 <= arg_97_1.time_ and arg_97_1.time_ < var_100_10 + var_100_11 and not isNil(var_100_9) then
				local var_100_12 = (arg_97_1.time_ - var_100_10) / var_100_11

				if arg_97_1.var_.characterEffect1084ui_story and not isNil(var_100_9) then
					arg_97_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_10 + var_100_11 and arg_97_1.time_ < var_100_10 + var_100_11 + arg_100_0 and not isNil(var_100_9) and arg_97_1.var_.characterEffect1084ui_story then
				arg_97_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_100_13 = arg_97_1.actors_["1095ui_story"].transform
			local var_100_14 = 0

			if var_100_14 < arg_97_1.time_ and arg_97_1.time_ <= var_100_14 + arg_100_0 then
				arg_97_1.var_.moveOldPos1095ui_story = var_100_13.localPosition
			end

			local var_100_15 = 0.001

			if var_100_14 <= arg_97_1.time_ and arg_97_1.time_ < var_100_14 + var_100_15 then
				local var_100_16 = (arg_97_1.time_ - var_100_14) / var_100_15
				local var_100_17 = Vector3.New(0, 100, 0)

				var_100_13.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1095ui_story, var_100_17, var_100_16)

				local var_100_18 = manager.ui.mainCamera.transform.position - var_100_13.position

				var_100_13.forward = Vector3.New(var_100_18.x, var_100_18.y, var_100_18.z)

				local var_100_19 = var_100_13.localEulerAngles

				var_100_19.z = 0
				var_100_19.x = 0
				var_100_13.localEulerAngles = var_100_19
			end

			if arg_97_1.time_ >= var_100_14 + var_100_15 and arg_97_1.time_ < var_100_14 + var_100_15 + arg_100_0 then
				var_100_13.localPosition = Vector3.New(0, 100, 0)

				local var_100_20 = manager.ui.mainCamera.transform.position - var_100_13.position

				var_100_13.forward = Vector3.New(var_100_20.x, var_100_20.y, var_100_20.z)

				local var_100_21 = var_100_13.localEulerAngles

				var_100_21.z = 0
				var_100_21.x = 0
				var_100_13.localEulerAngles = var_100_21
			end

			local var_100_22 = "STblack"

			if arg_97_1.bgs_[var_100_22] == nil then
				local var_100_23 = Object.Instantiate(arg_97_1.paintGo_)

				var_100_23:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_100_22)
				var_100_23.name = var_100_22
				var_100_23.transform.parent = arg_97_1.stage_.transform
				var_100_23.transform.localPosition = Vector3.New(0, 100, 0)
				arg_97_1.bgs_[var_100_22] = var_100_23
			end

			local var_100_24 = 0

			if var_100_24 < arg_97_1.time_ and arg_97_1.time_ <= var_100_24 + arg_100_0 then
				local var_100_25 = manager.ui.mainCamera.transform.localPosition
				local var_100_26 = Vector3.New(0, 0, 10) + Vector3.New(var_100_25.x, var_100_25.y, 0)
				local var_100_27 = arg_97_1.bgs_.STblack

				var_100_27.transform.localPosition = var_100_26
				var_100_27.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_100_28 = var_100_27:GetComponent("SpriteRenderer")

				if var_100_28 and var_100_28.sprite then
					local var_100_29 = (var_100_27.transform.localPosition - var_100_25).z
					local var_100_30 = manager.ui.mainCameraCom_
					local var_100_31 = 2 * var_100_29 * Mathf.Tan(var_100_30.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_100_32 = var_100_31 * var_100_30.aspect
					local var_100_33 = var_100_28.sprite.bounds.size.x
					local var_100_34 = var_100_28.sprite.bounds.size.y
					local var_100_35 = var_100_32 / var_100_33
					local var_100_36 = var_100_31 / var_100_34
					local var_100_37 = var_100_36 < var_100_35 and var_100_35 or var_100_36

					var_100_27.transform.localScale = Vector3.New(var_100_37, var_100_37, 0)
				end

				for iter_100_0, iter_100_1 in pairs(arg_97_1.bgs_) do
					if iter_100_0 ~= "STblack" then
						iter_100_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_100_38 = 0

			if var_100_38 < arg_97_1.time_ and arg_97_1.time_ <= var_100_38 + arg_100_0 then
				local var_100_39 = arg_97_1.fswbg_.transform:Find("textbox/adapt/content") or arg_97_1.fswbg_.transform:Find("textbox/content")
				local var_100_40 = arg_97_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_100_41 = var_100_39:GetComponent("Text")
				local var_100_42 = var_100_39:GetComponent("RectTransform")

				var_100_41.alignment = UnityEngine.TextAnchor.LowerCenter
				var_100_42.offsetMin = Vector2.New(0, 0)
				var_100_42.offsetMax = Vector2.New(0, 0)
			end

			local var_100_43 = 0

			if var_100_43 < arg_97_1.time_ and arg_97_1.time_ <= var_100_43 + arg_100_0 then
				arg_97_1.fswbg_:SetActive(true)
				arg_97_1.dialog_:SetActive(false)

				arg_97_1.fswtw_.percent = 0

				local var_100_44 = arg_97_1:GetWordFromCfg(319881024)
				local var_100_45 = arg_97_1:FormatText(var_100_44.content)

				arg_97_1.fswt_.text = var_100_45

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.fswt_)

				arg_97_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_97_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_97_1.fswtw_:SetDirty()

				arg_97_1.typewritterCharCountI18N = 0

				SetActive(arg_97_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_97_1:ShowNextGo(false)
			end

			local var_100_46 = 1.43333333333333

			if var_100_46 < arg_97_1.time_ and arg_97_1.time_ <= var_100_46 + arg_100_0 then
				arg_97_1.var_.oldValueTypewriter = arg_97_1.fswtw_.percent

				SetActive(arg_97_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_97_1:ShowNextGo(false)
			end

			local var_100_47 = 8
			local var_100_48 = 0.533333333333333
			local var_100_49 = arg_97_1:GetWordFromCfg(319881024)
			local var_100_50 = arg_97_1:FormatText(var_100_49.content)
			local var_100_51, var_100_52 = arg_97_1:GetPercentByPara(var_100_50, 1)

			if var_100_46 < arg_97_1.time_ and arg_97_1.time_ <= var_100_46 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0

				local var_100_53 = var_100_47 <= 0 and var_100_48 or var_100_48 * ((var_100_52 - arg_97_1.typewritterCharCountI18N) / var_100_47)

				if var_100_53 > 0 and var_100_48 < var_100_53 then
					arg_97_1.talkMaxDuration = var_100_53

					if var_100_53 + var_100_46 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_53 + var_100_46
					end
				end
			end

			local var_100_54 = 0.533333333333333
			local var_100_55 = math.max(var_100_54, arg_97_1.talkMaxDuration)

			if var_100_46 <= arg_97_1.time_ and arg_97_1.time_ < var_100_46 + var_100_55 then
				local var_100_56 = (arg_97_1.time_ - var_100_46) / var_100_55

				arg_97_1.fswtw_.percent = Mathf.Lerp(arg_97_1.var_.oldValueTypewriter, var_100_51, var_100_56)
				arg_97_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_97_1.fswtw_:SetDirty()
			end

			if arg_97_1.time_ >= var_100_46 + var_100_55 and arg_97_1.time_ < var_100_46 + var_100_55 + arg_100_0 then
				arg_97_1.fswtw_.percent = var_100_51

				arg_97_1.fswtw_:SetDirty()
				arg_97_1:ShowNextGo(true)

				arg_97_1.typewritterCharCountI18N = var_100_52
			end

			local var_100_57 = 1.43333333333333
			local var_100_58 = 2.066
			local var_100_59 = manager.audio:GetVoiceLength("story_v_out_319881", "319881024", "story_v_out_319881.awb") / 1000

			if var_100_59 > 0 and var_100_58 < var_100_59 and var_100_59 + var_100_57 > arg_97_1.duration_ then
				local var_100_60 = var_100_59

				arg_97_1.duration_ = var_100_59 + var_100_57
			end

			if var_100_57 < arg_97_1.time_ and arg_97_1.time_ <= var_100_57 + arg_100_0 then
				local var_100_61 = "play"
				local var_100_62 = "voice"

				arg_97_1:AudioAction(var_100_61, var_100_62, "story_v_out_319881", "319881024", "story_v_out_319881.awb")
			end

			local var_100_63 = 0

			if var_100_63 < arg_97_1.time_ and arg_97_1.time_ <= var_100_63 + arg_100_0 then
				arg_97_1.cswbg_:SetActive(true)

				local var_100_64 = arg_97_1.cswt_:GetComponent("RectTransform")

				arg_97_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_100_64.offsetMin = Vector2.New(410, 330)
				var_100_64.offsetMax = Vector2.New(-400, -175)

				local var_100_65 = arg_97_1:GetWordFromCfg(419058)
				local var_100_66 = arg_97_1:FormatText(var_100_65.content)

				arg_97_1.cswt_.text = var_100_66

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.cswt_)

				arg_97_1.cswt_.fontSize = 180
				arg_97_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_97_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_97_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_97_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play319881025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319881025
		arg_101_1.duration_ = 15.97

		local var_101_0 = {
			zh = 11.5670000018477,
			ja = 15.9670000018477
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
				arg_101_0:Play319881026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				local var_104_1 = manager.ui.mainCamera.transform.localPosition
				local var_104_2 = Vector3.New(0, 0, 10) + Vector3.New(var_104_1.x, var_104_1.y, 0)
				local var_104_3 = arg_101_1.bgs_.ST70a

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
					if iter_104_0 ~= "ST70a" then
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

				var_104_17.a = Mathf.Lerp(1, 0, var_104_16)
				arg_101_1.mask_.color = var_104_17
			end

			if arg_101_1.time_ >= var_104_14 + var_104_15 and arg_101_1.time_ < var_104_14 + var_104_15 + arg_104_0 then
				local var_104_18 = Color.New(0, 0, 0)
				local var_104_19 = 0

				arg_101_1.mask_.enabled = false
				var_104_18.a = var_104_19
				arg_101_1.mask_.color = var_104_18
			end

			local var_104_20 = arg_101_1.actors_["1095ui_story"].transform
			local var_104_21 = 1.8

			if var_104_21 < arg_101_1.time_ and arg_101_1.time_ <= var_104_21 + arg_104_0 then
				arg_101_1.var_.moveOldPos1095ui_story = var_104_20.localPosition
			end

			local var_104_22 = 0.001

			if var_104_21 <= arg_101_1.time_ and arg_101_1.time_ < var_104_21 + var_104_22 then
				local var_104_23 = (arg_101_1.time_ - var_104_21) / var_104_22
				local var_104_24 = Vector3.New(0, -0.98, -6.1)

				var_104_20.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1095ui_story, var_104_24, var_104_23)

				local var_104_25 = manager.ui.mainCamera.transform.position - var_104_20.position

				var_104_20.forward = Vector3.New(var_104_25.x, var_104_25.y, var_104_25.z)

				local var_104_26 = var_104_20.localEulerAngles

				var_104_26.z = 0
				var_104_26.x = 0
				var_104_20.localEulerAngles = var_104_26
			end

			if arg_101_1.time_ >= var_104_21 + var_104_22 and arg_101_1.time_ < var_104_21 + var_104_22 + arg_104_0 then
				var_104_20.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_104_27 = manager.ui.mainCamera.transform.position - var_104_20.position

				var_104_20.forward = Vector3.New(var_104_27.x, var_104_27.y, var_104_27.z)

				local var_104_28 = var_104_20.localEulerAngles

				var_104_28.z = 0
				var_104_28.x = 0
				var_104_20.localEulerAngles = var_104_28
			end

			local var_104_29 = arg_101_1.actors_["1095ui_story"]
			local var_104_30 = 1.8

			if var_104_30 < arg_101_1.time_ and arg_101_1.time_ <= var_104_30 + arg_104_0 and not isNil(var_104_29) and arg_101_1.var_.characterEffect1095ui_story == nil then
				arg_101_1.var_.characterEffect1095ui_story = var_104_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_31 = 0.200000002980232

			if var_104_30 <= arg_101_1.time_ and arg_101_1.time_ < var_104_30 + var_104_31 and not isNil(var_104_29) then
				local var_104_32 = (arg_101_1.time_ - var_104_30) / var_104_31

				if arg_101_1.var_.characterEffect1095ui_story and not isNil(var_104_29) then
					arg_101_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_30 + var_104_31 and arg_101_1.time_ < var_104_30 + var_104_31 + arg_104_0 and not isNil(var_104_29) and arg_101_1.var_.characterEffect1095ui_story then
				arg_101_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_104_33 = arg_101_1.actors_["1084ui_story"]
			local var_104_34 = 0

			if var_104_34 < arg_101_1.time_ and arg_101_1.time_ <= var_104_34 + arg_104_0 and not isNil(var_104_33) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_35 = 0.200000002980232

			if var_104_34 <= arg_101_1.time_ and arg_101_1.time_ < var_104_34 + var_104_35 and not isNil(var_104_33) then
				local var_104_36 = (arg_101_1.time_ - var_104_34) / var_104_35

				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_33) then
					local var_104_37 = Mathf.Lerp(0, 0.5, var_104_36)

					arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1084ui_story.fillRatio = var_104_37
				end
			end

			if arg_101_1.time_ >= var_104_34 + var_104_35 and arg_101_1.time_ < var_104_34 + var_104_35 + arg_104_0 and not isNil(var_104_33) and arg_101_1.var_.characterEffect1084ui_story then
				local var_104_38 = 0.5

				arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1084ui_story.fillRatio = var_104_38
			end

			local var_104_39 = 0

			if var_104_39 < arg_101_1.time_ and arg_101_1.time_ <= var_104_39 + arg_104_0 then
				arg_101_1.fswbg_:SetActive(false)
				arg_101_1.dialog_:SetActive(false)
				SetActive(arg_101_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_101_1:ShowNextGo(false)
			end

			local var_104_40 = 0.0166666666666667

			if var_104_40 < arg_101_1.time_ and arg_101_1.time_ <= var_104_40 + arg_104_0 then
				arg_101_1.fswbg_:SetActive(false)
				arg_101_1.dialog_:SetActive(false)
				SetActive(arg_101_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_101_1:ShowNextGo(false)
			end

			local var_104_41 = 0

			if var_104_41 < arg_101_1.time_ and arg_101_1.time_ <= var_104_41 + arg_104_0 then
				arg_101_1.cswbg_:SetActive(false)
			end

			if arg_101_1.frameCnt_ <= 1 then
				arg_101_1.dialog_:SetActive(false)
			end

			local var_104_42 = 1.93400000184774
			local var_104_43 = 1.075

			if var_104_42 < arg_101_1.time_ and arg_101_1.time_ <= var_104_42 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0

				arg_101_1.dialog_:SetActive(true)

				arg_101_1.dialogCg_.alpha = 0

				local var_104_44 = LeanTween.value(arg_101_1.dialog_, 0, 1, 0.3)

				var_104_44:setOnUpdate(LuaHelper.FloatAction(function(arg_105_0)
					arg_101_1.dialogCg_.alpha = arg_105_0
				end))
				var_104_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_101_1.dialog_)
					var_104_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_101_1.duration_ = arg_101_1.duration_ + 0.3

				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_45 = arg_101_1:FormatText(StoryNameCfg[471].name)

				arg_101_1.leftNameTxt_.text = var_104_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_46 = arg_101_1:GetWordFromCfg(319881025)
				local var_104_47 = arg_101_1:FormatText(var_104_46.content)

				arg_101_1.text_.text = var_104_47

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_48 = 43
				local var_104_49 = utf8.len(var_104_47)
				local var_104_50 = var_104_48 <= 0 and var_104_43 or var_104_43 * (var_104_49 / var_104_48)

				if var_104_50 > 0 and var_104_43 < var_104_50 then
					arg_101_1.talkMaxDuration = var_104_50
					var_104_42 = var_104_42 + 0.3

					if var_104_50 + var_104_42 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_50 + var_104_42
					end
				end

				arg_101_1.text_.text = var_104_47
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881025", "story_v_out_319881.awb") ~= 0 then
					local var_104_51 = manager.audio:GetVoiceLength("story_v_out_319881", "319881025", "story_v_out_319881.awb") / 1000

					if var_104_51 + var_104_42 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_51 + var_104_42
					end

					if var_104_46.prefab_name ~= "" and arg_101_1.actors_[var_104_46.prefab_name] ~= nil then
						local var_104_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_46.prefab_name].transform, "story_v_out_319881", "319881025", "story_v_out_319881.awb")

						arg_101_1:RecordAudio("319881025", var_104_52)
						arg_101_1:RecordAudio("319881025", var_104_52)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319881", "319881025", "story_v_out_319881.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319881", "319881025", "story_v_out_319881.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_53 = var_104_42 + 0.3
			local var_104_54 = math.max(var_104_43, arg_101_1.talkMaxDuration)

			if var_104_53 <= arg_101_1.time_ and arg_101_1.time_ < var_104_53 + var_104_54 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_53) / var_104_54

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_53 + var_104_54 and arg_101_1.time_ < var_104_53 + var_104_54 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play319881026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319881026
		arg_107_1.duration_ = 16.87

		local var_107_0 = {
			zh = 10.033,
			ja = 16.866
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
				arg_107_0:Play319881027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 1.25

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[471].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:GetWordFromCfg(319881026)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 50
				local var_110_6 = utf8.len(var_110_4)
				local var_110_7 = var_110_5 <= 0 and var_110_1 or var_110_1 * (var_110_6 / var_110_5)

				if var_110_7 > 0 and var_110_1 < var_110_7 then
					arg_107_1.talkMaxDuration = var_110_7

					if var_110_7 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_7 + var_110_0
					end
				end

				arg_107_1.text_.text = var_110_4
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881026", "story_v_out_319881.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881026", "story_v_out_319881.awb") / 1000

					if var_110_8 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_0
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_out_319881", "319881026", "story_v_out_319881.awb")

						arg_107_1:RecordAudio("319881026", var_110_9)
						arg_107_1:RecordAudio("319881026", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_319881", "319881026", "story_v_out_319881.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_319881", "319881026", "story_v_out_319881.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_10 = math.max(var_110_1, arg_107_1.talkMaxDuration)

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_10 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_0) / var_110_10

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_0 + var_110_10 and arg_107_1.time_ < var_110_0 + var_110_10 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play319881027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319881027
		arg_111_1.duration_ = 9.9

		local var_111_0 = {
			zh = 5.933,
			ja = 9.9
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
				arg_111_0:Play319881028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_114_2 = 0
			local var_114_3 = 0.8

			if var_114_2 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_4 = arg_111_1:FormatText(StoryNameCfg[471].name)

				arg_111_1.leftNameTxt_.text = var_114_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_5 = arg_111_1:GetWordFromCfg(319881027)
				local var_114_6 = arg_111_1:FormatText(var_114_5.content)

				arg_111_1.text_.text = var_114_6

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 32
				local var_114_8 = utf8.len(var_114_6)
				local var_114_9 = var_114_7 <= 0 and var_114_3 or var_114_3 * (var_114_8 / var_114_7)

				if var_114_9 > 0 and var_114_3 < var_114_9 then
					arg_111_1.talkMaxDuration = var_114_9

					if var_114_9 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_6
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881027", "story_v_out_319881.awb") ~= 0 then
					local var_114_10 = manager.audio:GetVoiceLength("story_v_out_319881", "319881027", "story_v_out_319881.awb") / 1000

					if var_114_10 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_2
					end

					if var_114_5.prefab_name ~= "" and arg_111_1.actors_[var_114_5.prefab_name] ~= nil then
						local var_114_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_5.prefab_name].transform, "story_v_out_319881", "319881027", "story_v_out_319881.awb")

						arg_111_1:RecordAudio("319881027", var_114_11)
						arg_111_1:RecordAudio("319881027", var_114_11)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_319881", "319881027", "story_v_out_319881.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_319881", "319881027", "story_v_out_319881.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_12 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_12 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_12

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_12 and arg_111_1.time_ < var_114_2 + var_114_12 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play319881028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319881028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play319881029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1095ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1095ui_story == nil then
				arg_115_1.var_.characterEffect1095ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1095ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1095ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1095ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1095ui_story.fillRatio = var_118_5
			end

			local var_118_6 = 0
			local var_118_7 = 1.05

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

				local var_118_8 = arg_115_1:GetWordFromCfg(319881028)
				local var_118_9 = arg_115_1:FormatText(var_118_8.content)

				arg_115_1.text_.text = var_118_9

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_10 = 42
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
	Play319881029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319881029
		arg_119_1.duration_ = 10.43

		local var_119_0 = {
			zh = 5.8,
			ja = 10.433
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
				arg_119_0:Play319881030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1095ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1095ui_story == nil then
				arg_119_1.var_.characterEffect1095ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect1095ui_story and not isNil(var_122_0) then
					arg_119_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1095ui_story then
				arg_119_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_122_4 = 0
			local var_122_5 = 0.725

			if var_122_4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_6 = arg_119_1:FormatText(StoryNameCfg[471].name)

				arg_119_1.leftNameTxt_.text = var_122_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_7 = arg_119_1:GetWordFromCfg(319881029)
				local var_122_8 = arg_119_1:FormatText(var_122_7.content)

				arg_119_1.text_.text = var_122_8

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_9 = 29
				local var_122_10 = utf8.len(var_122_8)
				local var_122_11 = var_122_9 <= 0 and var_122_5 or var_122_5 * (var_122_10 / var_122_9)

				if var_122_11 > 0 and var_122_5 < var_122_11 then
					arg_119_1.talkMaxDuration = var_122_11

					if var_122_11 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_11 + var_122_4
					end
				end

				arg_119_1.text_.text = var_122_8
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881029", "story_v_out_319881.awb") ~= 0 then
					local var_122_12 = manager.audio:GetVoiceLength("story_v_out_319881", "319881029", "story_v_out_319881.awb") / 1000

					if var_122_12 + var_122_4 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_12 + var_122_4
					end

					if var_122_7.prefab_name ~= "" and arg_119_1.actors_[var_122_7.prefab_name] ~= nil then
						local var_122_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_7.prefab_name].transform, "story_v_out_319881", "319881029", "story_v_out_319881.awb")

						arg_119_1:RecordAudio("319881029", var_122_13)
						arg_119_1:RecordAudio("319881029", var_122_13)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319881", "319881029", "story_v_out_319881.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319881", "319881029", "story_v_out_319881.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_14 = math.max(var_122_5, arg_119_1.talkMaxDuration)

			if var_122_4 <= arg_119_1.time_ and arg_119_1.time_ < var_122_4 + var_122_14 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_4) / var_122_14

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_4 + var_122_14 and arg_119_1.time_ < var_122_4 + var_122_14 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play319881030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319881030
		arg_123_1.duration_ = 16.47

		local var_123_0 = {
			zh = 7.166,
			ja = 16.466
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
				arg_123_0:Play319881031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 0.85

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_2 = arg_123_1:FormatText(StoryNameCfg[471].name)

				arg_123_1.leftNameTxt_.text = var_126_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_3 = arg_123_1:GetWordFromCfg(319881030)
				local var_126_4 = arg_123_1:FormatText(var_126_3.content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_5 = 34
				local var_126_6 = utf8.len(var_126_4)
				local var_126_7 = var_126_5 <= 0 and var_126_1 or var_126_1 * (var_126_6 / var_126_5)

				if var_126_7 > 0 and var_126_1 < var_126_7 then
					arg_123_1.talkMaxDuration = var_126_7

					if var_126_7 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_7 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881030", "story_v_out_319881.awb") ~= 0 then
					local var_126_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881030", "story_v_out_319881.awb") / 1000

					if var_126_8 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_0
					end

					if var_126_3.prefab_name ~= "" and arg_123_1.actors_[var_126_3.prefab_name] ~= nil then
						local var_126_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_3.prefab_name].transform, "story_v_out_319881", "319881030", "story_v_out_319881.awb")

						arg_123_1:RecordAudio("319881030", var_126_9)
						arg_123_1:RecordAudio("319881030", var_126_9)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319881", "319881030", "story_v_out_319881.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319881", "319881030", "story_v_out_319881.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_10 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_10 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_10

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_10 and arg_123_1.time_ < var_126_0 + var_126_10 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play319881031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319881031
		arg_127_1.duration_ = 11.87

		local var_127_0 = {
			zh = 8.333,
			ja = 11.866
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
				arg_127_0:Play319881032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action7_1")
			end

			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_130_2 = 0
			local var_130_3 = 1.075

			if var_130_2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_4 = arg_127_1:FormatText(StoryNameCfg[471].name)

				arg_127_1.leftNameTxt_.text = var_130_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_5 = arg_127_1:GetWordFromCfg(319881031)
				local var_130_6 = arg_127_1:FormatText(var_130_5.content)

				arg_127_1.text_.text = var_130_6

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_7 = 43
				local var_130_8 = utf8.len(var_130_6)
				local var_130_9 = var_130_7 <= 0 and var_130_3 or var_130_3 * (var_130_8 / var_130_7)

				if var_130_9 > 0 and var_130_3 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_2
					end
				end

				arg_127_1.text_.text = var_130_6
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881031", "story_v_out_319881.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_319881", "319881031", "story_v_out_319881.awb") / 1000

					if var_130_10 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_2
					end

					if var_130_5.prefab_name ~= "" and arg_127_1.actors_[var_130_5.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_5.prefab_name].transform, "story_v_out_319881", "319881031", "story_v_out_319881.awb")

						arg_127_1:RecordAudio("319881031", var_130_11)
						arg_127_1:RecordAudio("319881031", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319881", "319881031", "story_v_out_319881.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319881", "319881031", "story_v_out_319881.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_3, arg_127_1.talkMaxDuration)

			if var_130_2 <= arg_127_1.time_ and arg_127_1.time_ < var_130_2 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_2) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_2 + var_130_12 and arg_127_1.time_ < var_130_2 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play319881032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319881032
		arg_131_1.duration_ = 3.63

		local var_131_0 = {
			zh = 1.999999999999,
			ja = 3.63333333333333
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
				arg_131_0:Play319881033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["1084ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos1084ui_story = var_134_0.localPosition

				local var_134_2 = "1084ui_story"

				arg_131_1:ShowWeapon(arg_131_1.var_[var_134_2 .. "Animator"].transform, false)
			end

			local var_134_3 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_3 then
				local var_134_4 = (arg_131_1.time_ - var_134_1) / var_134_3
				local var_134_5 = Vector3.New(0.7, -0.97, -6)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1084ui_story, var_134_5, var_134_4)

				local var_134_6 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_6.x, var_134_6.y, var_134_6.z)

				local var_134_7 = var_134_0.localEulerAngles

				var_134_7.z = 0
				var_134_7.x = 0
				var_134_0.localEulerAngles = var_134_7
			end

			if arg_131_1.time_ >= var_134_1 + var_134_3 and arg_131_1.time_ < var_134_1 + var_134_3 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_134_8 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_8.x, var_134_8.y, var_134_8.z)

				local var_134_9 = var_134_0.localEulerAngles

				var_134_9.z = 0
				var_134_9.x = 0
				var_134_0.localEulerAngles = var_134_9
			end

			local var_134_10 = arg_131_1.actors_["1084ui_story"]
			local var_134_11 = 0

			if var_134_11 < arg_131_1.time_ and arg_131_1.time_ <= var_134_11 + arg_134_0 and not isNil(var_134_10) and arg_131_1.var_.characterEffect1084ui_story == nil then
				arg_131_1.var_.characterEffect1084ui_story = var_134_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_12 = 0.200000002980232

			if var_134_11 <= arg_131_1.time_ and arg_131_1.time_ < var_134_11 + var_134_12 and not isNil(var_134_10) then
				local var_134_13 = (arg_131_1.time_ - var_134_11) / var_134_12

				if arg_131_1.var_.characterEffect1084ui_story and not isNil(var_134_10) then
					arg_131_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_11 + var_134_12 and arg_131_1.time_ < var_134_11 + var_134_12 + arg_134_0 and not isNil(var_134_10) and arg_131_1.var_.characterEffect1084ui_story then
				arg_131_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 then
				arg_131_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_134_15 = 0

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_134_16 = arg_131_1.actors_["1095ui_story"]
			local var_134_17 = 0

			if var_134_17 < arg_131_1.time_ and arg_131_1.time_ <= var_134_17 + arg_134_0 and not isNil(var_134_16) and arg_131_1.var_.characterEffect1095ui_story == nil then
				arg_131_1.var_.characterEffect1095ui_story = var_134_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_18 = 0.200000002980232

			if var_134_17 <= arg_131_1.time_ and arg_131_1.time_ < var_134_17 + var_134_18 and not isNil(var_134_16) then
				local var_134_19 = (arg_131_1.time_ - var_134_17) / var_134_18

				if arg_131_1.var_.characterEffect1095ui_story and not isNil(var_134_16) then
					local var_134_20 = Mathf.Lerp(0, 0.5, var_134_19)

					arg_131_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1095ui_story.fillRatio = var_134_20
				end
			end

			if arg_131_1.time_ >= var_134_17 + var_134_18 and arg_131_1.time_ < var_134_17 + var_134_18 + arg_134_0 and not isNil(var_134_16) and arg_131_1.var_.characterEffect1095ui_story then
				local var_134_21 = 0.5

				arg_131_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1095ui_story.fillRatio = var_134_21
			end

			local var_134_22 = arg_131_1.actors_["1095ui_story"].transform
			local var_134_23 = 0

			if var_134_23 < arg_131_1.time_ and arg_131_1.time_ <= var_134_23 + arg_134_0 then
				arg_131_1.var_.moveOldPos1095ui_story = var_134_22.localPosition
			end

			local var_134_24 = 0.001

			if var_134_23 <= arg_131_1.time_ and arg_131_1.time_ < var_134_23 + var_134_24 then
				local var_134_25 = (arg_131_1.time_ - var_134_23) / var_134_24
				local var_134_26 = Vector3.New(-0.7, -0.98, -6.1)

				var_134_22.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1095ui_story, var_134_26, var_134_25)

				local var_134_27 = manager.ui.mainCamera.transform.position - var_134_22.position

				var_134_22.forward = Vector3.New(var_134_27.x, var_134_27.y, var_134_27.z)

				local var_134_28 = var_134_22.localEulerAngles

				var_134_28.z = 0
				var_134_28.x = 0
				var_134_22.localEulerAngles = var_134_28
			end

			if arg_131_1.time_ >= var_134_23 + var_134_24 and arg_131_1.time_ < var_134_23 + var_134_24 + arg_134_0 then
				var_134_22.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_134_29 = manager.ui.mainCamera.transform.position - var_134_22.position

				var_134_22.forward = Vector3.New(var_134_29.x, var_134_29.y, var_134_29.z)

				local var_134_30 = var_134_22.localEulerAngles

				var_134_30.z = 0
				var_134_30.x = 0
				var_134_22.localEulerAngles = var_134_30
			end

			if arg_131_1.frameCnt_ <= 1 then
				arg_131_1.dialog_:SetActive(false)
			end

			local var_134_31 = 0.433333333333333
			local var_134_32 = 0.15

			if var_134_31 < arg_131_1.time_ and arg_131_1.time_ <= var_134_31 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0

				arg_131_1.dialog_:SetActive(true)

				arg_131_1.dialogCg_.alpha = 0

				local var_134_33 = LeanTween.value(arg_131_1.dialog_, 0, 1, 0.3)

				var_134_33:setOnUpdate(LuaHelper.FloatAction(function(arg_135_0)
					arg_131_1.dialogCg_.alpha = arg_135_0
				end))
				var_134_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_131_1.dialog_)
					var_134_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_131_1.duration_ = arg_131_1.duration_ + 0.3

				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_34 = arg_131_1:FormatText(StoryNameCfg[6].name)

				arg_131_1.leftNameTxt_.text = var_134_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_35 = arg_131_1:GetWordFromCfg(319881032)
				local var_134_36 = arg_131_1:FormatText(var_134_35.content)

				arg_131_1.text_.text = var_134_36

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_37 = 6
				local var_134_38 = utf8.len(var_134_36)
				local var_134_39 = var_134_37 <= 0 and var_134_32 or var_134_32 * (var_134_38 / var_134_37)

				if var_134_39 > 0 and var_134_32 < var_134_39 then
					arg_131_1.talkMaxDuration = var_134_39
					var_134_31 = var_134_31 + 0.3

					if var_134_39 + var_134_31 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_39 + var_134_31
					end
				end

				arg_131_1.text_.text = var_134_36
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881032", "story_v_out_319881.awb") ~= 0 then
					local var_134_40 = manager.audio:GetVoiceLength("story_v_out_319881", "319881032", "story_v_out_319881.awb") / 1000

					if var_134_40 + var_134_31 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_40 + var_134_31
					end

					if var_134_35.prefab_name ~= "" and arg_131_1.actors_[var_134_35.prefab_name] ~= nil then
						local var_134_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_35.prefab_name].transform, "story_v_out_319881", "319881032", "story_v_out_319881.awb")

						arg_131_1:RecordAudio("319881032", var_134_41)
						arg_131_1:RecordAudio("319881032", var_134_41)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319881", "319881032", "story_v_out_319881.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319881", "319881032", "story_v_out_319881.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_42 = var_134_31 + 0.3
			local var_134_43 = math.max(var_134_32, arg_131_1.talkMaxDuration)

			if var_134_42 <= arg_131_1.time_ and arg_131_1.time_ < var_134_42 + var_134_43 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_42) / var_134_43

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_42 + var_134_43 and arg_131_1.time_ < var_134_42 + var_134_43 + arg_134_0 then
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
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319881033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319881033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play319881034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				local var_140_1 = manager.ui.mainCamera.transform.localPosition
				local var_140_2 = Vector3.New(0, 0, 10) + Vector3.New(var_140_1.x, var_140_1.y, 0)
				local var_140_3 = arg_137_1.bgs_.STblack

				var_140_3.transform.localPosition = var_140_2
				var_140_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_140_4 = var_140_3:GetComponent("SpriteRenderer")

				if var_140_4 and var_140_4.sprite then
					local var_140_5 = (var_140_3.transform.localPosition - var_140_1).z
					local var_140_6 = manager.ui.mainCameraCom_
					local var_140_7 = 2 * var_140_5 * Mathf.Tan(var_140_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_140_8 = var_140_7 * var_140_6.aspect
					local var_140_9 = var_140_4.sprite.bounds.size.x
					local var_140_10 = var_140_4.sprite.bounds.size.y
					local var_140_11 = var_140_8 / var_140_9
					local var_140_12 = var_140_7 / var_140_10
					local var_140_13 = var_140_12 < var_140_11 and var_140_11 or var_140_12

					var_140_3.transform.localScale = Vector3.New(var_140_13, var_140_13, 0)
				end

				for iter_140_0, iter_140_1 in pairs(arg_137_1.bgs_) do
					if iter_140_0 ~= "STblack" then
						iter_140_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_140_14 = 0

			if var_140_14 < arg_137_1.time_ and arg_137_1.time_ <= var_140_14 + arg_140_0 then
				local var_140_15 = arg_137_1.fswbg_.transform:Find("textbox/adapt/content") or arg_137_1.fswbg_.transform:Find("textbox/content")
				local var_140_16 = arg_137_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_140_17 = var_140_15:GetComponent("Text")
				local var_140_18 = var_140_15:GetComponent("RectTransform")

				var_140_17.alignment = UnityEngine.TextAnchor.LowerCenter
				var_140_18.offsetMin = Vector2.New(0, 0)
				var_140_18.offsetMax = Vector2.New(0, 0)
			end

			local var_140_19 = 0

			if var_140_19 < arg_137_1.time_ and arg_137_1.time_ <= var_140_19 + arg_140_0 then
				arg_137_1.fswbg_:SetActive(true)
				arg_137_1.dialog_:SetActive(false)

				arg_137_1.fswtw_.percent = 0

				local var_140_20 = arg_137_1:GetWordFromCfg(319881033)
				local var_140_21 = arg_137_1:FormatText(var_140_20.content)

				arg_137_1.fswt_.text = var_140_21

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.fswt_)

				arg_137_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_137_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_137_1.fswtw_:SetDirty()

				arg_137_1.typewritterCharCountI18N = 0

				SetActive(arg_137_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_137_1:ShowNextGo(false)
			end

			local var_140_22 = 1.2

			if var_140_22 < arg_137_1.time_ and arg_137_1.time_ <= var_140_22 + arg_140_0 then
				arg_137_1.var_.oldValueTypewriter = arg_137_1.fswtw_.percent

				SetActive(arg_137_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_137_1:ShowNextGo(false)
			end

			local var_140_23 = 33
			local var_140_24 = 2.2
			local var_140_25 = arg_137_1:GetWordFromCfg(319881033)
			local var_140_26 = arg_137_1:FormatText(var_140_25.content)
			local var_140_27, var_140_28 = arg_137_1:GetPercentByPara(var_140_26, 1)

			if var_140_22 < arg_137_1.time_ and arg_137_1.time_ <= var_140_22 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0

				local var_140_29 = var_140_23 <= 0 and var_140_24 or var_140_24 * ((var_140_28 - arg_137_1.typewritterCharCountI18N) / var_140_23)

				if var_140_29 > 0 and var_140_24 < var_140_29 then
					arg_137_1.talkMaxDuration = var_140_29

					if var_140_29 + var_140_22 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_29 + var_140_22
					end
				end
			end

			local var_140_30 = 2.2
			local var_140_31 = math.max(var_140_30, arg_137_1.talkMaxDuration)

			if var_140_22 <= arg_137_1.time_ and arg_137_1.time_ < var_140_22 + var_140_31 then
				local var_140_32 = (arg_137_1.time_ - var_140_22) / var_140_31

				arg_137_1.fswtw_.percent = Mathf.Lerp(arg_137_1.var_.oldValueTypewriter, var_140_27, var_140_32)
				arg_137_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_137_1.fswtw_:SetDirty()
			end

			if arg_137_1.time_ >= var_140_22 + var_140_31 and arg_137_1.time_ < var_140_22 + var_140_31 + arg_140_0 then
				arg_137_1.fswtw_.percent = var_140_27

				arg_137_1.fswtw_:SetDirty()
				arg_137_1:ShowNextGo(true)

				arg_137_1.typewritterCharCountI18N = var_140_28
			end

			local var_140_33 = arg_137_1.actors_["1084ui_story"].transform
			local var_140_34 = 0

			if var_140_34 < arg_137_1.time_ and arg_137_1.time_ <= var_140_34 + arg_140_0 then
				arg_137_1.var_.moveOldPos1084ui_story = var_140_33.localPosition
			end

			local var_140_35 = 0.001

			if var_140_34 <= arg_137_1.time_ and arg_137_1.time_ < var_140_34 + var_140_35 then
				local var_140_36 = (arg_137_1.time_ - var_140_34) / var_140_35
				local var_140_37 = Vector3.New(0, 100, 0)

				var_140_33.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1084ui_story, var_140_37, var_140_36)

				local var_140_38 = manager.ui.mainCamera.transform.position - var_140_33.position

				var_140_33.forward = Vector3.New(var_140_38.x, var_140_38.y, var_140_38.z)

				local var_140_39 = var_140_33.localEulerAngles

				var_140_39.z = 0
				var_140_39.x = 0
				var_140_33.localEulerAngles = var_140_39
			end

			if arg_137_1.time_ >= var_140_34 + var_140_35 and arg_137_1.time_ < var_140_34 + var_140_35 + arg_140_0 then
				var_140_33.localPosition = Vector3.New(0, 100, 0)

				local var_140_40 = manager.ui.mainCamera.transform.position - var_140_33.position

				var_140_33.forward = Vector3.New(var_140_40.x, var_140_40.y, var_140_40.z)

				local var_140_41 = var_140_33.localEulerAngles

				var_140_41.z = 0
				var_140_41.x = 0
				var_140_33.localEulerAngles = var_140_41
			end

			local var_140_42 = arg_137_1.actors_["1095ui_story"].transform
			local var_140_43 = 0

			if var_140_43 < arg_137_1.time_ and arg_137_1.time_ <= var_140_43 + arg_140_0 then
				arg_137_1.var_.moveOldPos1095ui_story = var_140_42.localPosition
			end

			local var_140_44 = 0.001

			if var_140_43 <= arg_137_1.time_ and arg_137_1.time_ < var_140_43 + var_140_44 then
				local var_140_45 = (arg_137_1.time_ - var_140_43) / var_140_44
				local var_140_46 = Vector3.New(0, 100, 0)

				var_140_42.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1095ui_story, var_140_46, var_140_45)

				local var_140_47 = manager.ui.mainCamera.transform.position - var_140_42.position

				var_140_42.forward = Vector3.New(var_140_47.x, var_140_47.y, var_140_47.z)

				local var_140_48 = var_140_42.localEulerAngles

				var_140_48.z = 0
				var_140_48.x = 0
				var_140_42.localEulerAngles = var_140_48
			end

			if arg_137_1.time_ >= var_140_43 + var_140_44 and arg_137_1.time_ < var_140_43 + var_140_44 + arg_140_0 then
				var_140_42.localPosition = Vector3.New(0, 100, 0)

				local var_140_49 = manager.ui.mainCamera.transform.position - var_140_42.position

				var_140_42.forward = Vector3.New(var_140_49.x, var_140_49.y, var_140_49.z)

				local var_140_50 = var_140_42.localEulerAngles

				var_140_50.z = 0
				var_140_50.x = 0
				var_140_42.localEulerAngles = var_140_50
			end

			local var_140_51 = 1.2
			local var_140_52 = 1
			local var_140_53 = manager.audio:GetVoiceLength("story_v_out_319881", "319881033", "story_v_out_319881.awb") / 1000

			if var_140_53 > 0 and var_140_52 < var_140_53 and var_140_53 + var_140_51 > arg_137_1.duration_ then
				local var_140_54 = var_140_53

				arg_137_1.duration_ = var_140_53 + var_140_51
			end

			if var_140_51 < arg_137_1.time_ and arg_137_1.time_ <= var_140_51 + arg_140_0 then
				local var_140_55 = "play"
				local var_140_56 = "voice"

				arg_137_1:AudioAction(var_140_55, var_140_56, "story_v_out_319881", "319881033", "story_v_out_319881.awb")
			end

			local var_140_57 = 0

			if var_140_57 < arg_137_1.time_ and arg_137_1.time_ <= var_140_57 + arg_140_0 then
				arg_137_1.cswbg_:SetActive(true)

				local var_140_58 = arg_137_1.cswt_:GetComponent("RectTransform")

				arg_137_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_140_58.offsetMin = Vector2.New(410, 330)
				var_140_58.offsetMax = Vector2.New(-400, -175)

				local var_140_59 = arg_137_1:GetWordFromCfg(419059)
				local var_140_60 = arg_137_1:FormatText(var_140_59.content)

				arg_137_1.cswt_.text = var_140_60

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.cswt_)

				arg_137_1.cswt_.fontSize = 180
				arg_137_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_137_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_137_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_137_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play319881034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319881034
		arg_141_1.duration_ = 3.93

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play319881035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.fswbg_:SetActive(true)
				arg_141_1.dialog_:SetActive(false)

				arg_141_1.fswtw_.percent = 0

				local var_144_1 = arg_141_1:GetWordFromCfg(319881034)
				local var_144_2 = arg_141_1:FormatText(var_144_1.content)

				arg_141_1.fswt_.text = var_144_2

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.fswt_)

				arg_141_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_141_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_141_1.fswtw_:SetDirty()

				arg_141_1.typewritterCharCountI18N = 0

				SetActive(arg_141_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_141_1:ShowNextGo(false)
			end

			local var_144_3 = 0.8

			if var_144_3 < arg_141_1.time_ and arg_141_1.time_ <= var_144_3 + arg_144_0 then
				arg_141_1.var_.oldValueTypewriter = arg_141_1.fswtw_.percent

				SetActive(arg_141_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_141_1:ShowNextGo(false)
			end

			local var_144_4 = 47
			local var_144_5 = 3.13333333333333
			local var_144_6 = arg_141_1:GetWordFromCfg(319881034)
			local var_144_7 = arg_141_1:FormatText(var_144_6.content)
			local var_144_8, var_144_9 = arg_141_1:GetPercentByPara(var_144_7, 1)

			if var_144_3 < arg_141_1.time_ and arg_141_1.time_ <= var_144_3 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0

				local var_144_10 = var_144_4 <= 0 and var_144_5 or var_144_5 * ((var_144_9 - arg_141_1.typewritterCharCountI18N) / var_144_4)

				if var_144_10 > 0 and var_144_5 < var_144_10 then
					arg_141_1.talkMaxDuration = var_144_10

					if var_144_10 + var_144_3 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_10 + var_144_3
					end
				end
			end

			local var_144_11 = 3.13333333333333
			local var_144_12 = math.max(var_144_11, arg_141_1.talkMaxDuration)

			if var_144_3 <= arg_141_1.time_ and arg_141_1.time_ < var_144_3 + var_144_12 then
				local var_144_13 = (arg_141_1.time_ - var_144_3) / var_144_12

				arg_141_1.fswtw_.percent = Mathf.Lerp(arg_141_1.var_.oldValueTypewriter, var_144_8, var_144_13)
				arg_141_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_141_1.fswtw_:SetDirty()
			end

			if arg_141_1.time_ >= var_144_3 + var_144_12 and arg_141_1.time_ < var_144_3 + var_144_12 + arg_144_0 then
				arg_141_1.fswtw_.percent = var_144_8

				arg_141_1.fswtw_:SetDirty()
				arg_141_1:ShowNextGo(true)

				arg_141_1.typewritterCharCountI18N = var_144_9
			end

			local var_144_14 = 0.8
			local var_144_15 = 1
			local var_144_16 = manager.audio:GetVoiceLength("story_v_out_319881", "319881034", "story_v_out_319881.awb") / 1000

			if var_144_16 > 0 and var_144_15 < var_144_16 and var_144_16 + var_144_14 > arg_141_1.duration_ then
				local var_144_17 = var_144_16

				arg_141_1.duration_ = var_144_16 + var_144_14
			end

			if var_144_14 < arg_141_1.time_ and arg_141_1.time_ <= var_144_14 + arg_144_0 then
				local var_144_18 = "play"
				local var_144_19 = "voice"

				arg_141_1:AudioAction(var_144_18, var_144_19, "story_v_out_319881", "319881034", "story_v_out_319881.awb")
			end

			local var_144_20 = 0

			if var_144_20 < arg_141_1.time_ and arg_141_1.time_ <= var_144_20 + arg_144_0 then
				arg_141_1.cswbg_:SetActive(true)

				local var_144_21 = arg_141_1.cswt_:GetComponent("RectTransform")

				arg_141_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_144_21.offsetMin = Vector2.New(410, 330)
				var_144_21.offsetMax = Vector2.New(-400, -175)

				local var_144_22 = arg_141_1:GetWordFromCfg(419060)
				local var_144_23 = arg_141_1:FormatText(var_144_22.content)

				arg_141_1.cswt_.text = var_144_23

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.cswt_)

				arg_141_1.cswt_.fontSize = 180
				arg_141_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_141_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_141_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play319881035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 319881035
		arg_145_1.duration_ = 1.73

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play319881036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.fswbg_:SetActive(true)
				arg_145_1.dialog_:SetActive(false)

				arg_145_1.fswtw_.percent = 0

				local var_148_1 = arg_145_1:GetWordFromCfg(319881035)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.fswt_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.fswt_)

				arg_145_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_145_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_145_1.fswtw_:SetDirty()

				arg_145_1.typewritterCharCountI18N = 0

				SetActive(arg_145_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_145_1:ShowNextGo(false)
			end

			local var_148_3 = 0.733333333333333

			if var_148_3 < arg_145_1.time_ and arg_145_1.time_ <= var_148_3 + arg_148_0 then
				arg_145_1.var_.oldValueTypewriter = arg_145_1.fswtw_.percent

				SetActive(arg_145_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_145_1:ShowNextGo(false)
			end

			local var_148_4 = 2
			local var_148_5 = 0.133333333333333
			local var_148_6 = arg_145_1:GetWordFromCfg(319881035)
			local var_148_7 = arg_145_1:FormatText(var_148_6.content)
			local var_148_8, var_148_9 = arg_145_1:GetPercentByPara(var_148_7, 1)

			if var_148_3 < arg_145_1.time_ and arg_145_1.time_ <= var_148_3 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0

				local var_148_10 = var_148_4 <= 0 and var_148_5 or var_148_5 * ((var_148_9 - arg_145_1.typewritterCharCountI18N) / var_148_4)

				if var_148_10 > 0 and var_148_5 < var_148_10 then
					arg_145_1.talkMaxDuration = var_148_10

					if var_148_10 + var_148_3 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_10 + var_148_3
					end
				end
			end

			local var_148_11 = 0.133333333333333
			local var_148_12 = math.max(var_148_11, arg_145_1.talkMaxDuration)

			if var_148_3 <= arg_145_1.time_ and arg_145_1.time_ < var_148_3 + var_148_12 then
				local var_148_13 = (arg_145_1.time_ - var_148_3) / var_148_12

				arg_145_1.fswtw_.percent = Mathf.Lerp(arg_145_1.var_.oldValueTypewriter, var_148_8, var_148_13)
				arg_145_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_145_1.fswtw_:SetDirty()
			end

			if arg_145_1.time_ >= var_148_3 + var_148_12 and arg_145_1.time_ < var_148_3 + var_148_12 + arg_148_0 then
				arg_145_1.fswtw_.percent = var_148_8

				arg_145_1.fswtw_:SetDirty()
				arg_145_1:ShowNextGo(true)

				arg_145_1.typewritterCharCountI18N = var_148_9
			end

			local var_148_14 = 0.733333333333333
			local var_148_15 = 1
			local var_148_16 = manager.audio:GetVoiceLength("story_v_out_319881", "319881035", "story_v_out_319881.awb") / 1000

			if var_148_16 > 0 and var_148_15 < var_148_16 and var_148_16 + var_148_14 > arg_145_1.duration_ then
				local var_148_17 = var_148_16

				arg_145_1.duration_ = var_148_16 + var_148_14
			end

			if var_148_14 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				local var_148_18 = "play"
				local var_148_19 = "voice"

				arg_145_1:AudioAction(var_148_18, var_148_19, "story_v_out_319881", "319881035", "story_v_out_319881.awb")
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play319881036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 319881036
		arg_149_1.duration_ = 2.63

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play319881037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.fswbg_:SetActive(true)
				arg_149_1.dialog_:SetActive(false)

				arg_149_1.fswtw_.percent = 0

				local var_152_1 = arg_149_1:GetWordFromCfg(319881036)
				local var_152_2 = arg_149_1:FormatText(var_152_1.content)

				arg_149_1.fswt_.text = var_152_2

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.fswt_)

				arg_149_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_149_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_149_1.fswtw_:SetDirty()

				arg_149_1.typewritterCharCountI18N = 0

				SetActive(arg_149_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_149_1:ShowNextGo(false)
			end

			local var_152_3 = 1.16666666666667

			if var_152_3 < arg_149_1.time_ and arg_149_1.time_ <= var_152_3 + arg_152_0 then
				arg_149_1.var_.oldValueTypewriter = arg_149_1.fswtw_.percent

				SetActive(arg_149_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_149_1:ShowNextGo(false)
			end

			local var_152_4 = 22
			local var_152_5 = 1.46666666666667
			local var_152_6 = arg_149_1:GetWordFromCfg(319881036)
			local var_152_7 = arg_149_1:FormatText(var_152_6.content)
			local var_152_8, var_152_9 = arg_149_1:GetPercentByPara(var_152_7, 1)

			if var_152_3 < arg_149_1.time_ and arg_149_1.time_ <= var_152_3 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0

				local var_152_10 = var_152_4 <= 0 and var_152_5 or var_152_5 * ((var_152_9 - arg_149_1.typewritterCharCountI18N) / var_152_4)

				if var_152_10 > 0 and var_152_5 < var_152_10 then
					arg_149_1.talkMaxDuration = var_152_10

					if var_152_10 + var_152_3 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_10 + var_152_3
					end
				end
			end

			local var_152_11 = 1.46666666666667
			local var_152_12 = math.max(var_152_11, arg_149_1.talkMaxDuration)

			if var_152_3 <= arg_149_1.time_ and arg_149_1.time_ < var_152_3 + var_152_12 then
				local var_152_13 = (arg_149_1.time_ - var_152_3) / var_152_12

				arg_149_1.fswtw_.percent = Mathf.Lerp(arg_149_1.var_.oldValueTypewriter, var_152_8, var_152_13)
				arg_149_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_149_1.fswtw_:SetDirty()
			end

			if arg_149_1.time_ >= var_152_3 + var_152_12 and arg_149_1.time_ < var_152_3 + var_152_12 + arg_152_0 then
				arg_149_1.fswtw_.percent = var_152_8

				arg_149_1.fswtw_:SetDirty()
				arg_149_1:ShowNextGo(true)

				arg_149_1.typewritterCharCountI18N = var_152_9
			end

			local var_152_14 = 1.16666666666667
			local var_152_15 = 1
			local var_152_16 = manager.audio:GetVoiceLength("story_v_out_319881", "319881036", "story_v_out_319881.awb") / 1000

			if var_152_16 > 0 and var_152_15 < var_152_16 and var_152_16 + var_152_14 > arg_149_1.duration_ then
				local var_152_17 = var_152_16

				arg_149_1.duration_ = var_152_16 + var_152_14
			end

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 then
				local var_152_18 = "play"
				local var_152_19 = "voice"

				arg_149_1:AudioAction(var_152_18, var_152_19, "story_v_out_319881", "319881036", "story_v_out_319881.awb")
			end

			local var_152_20 = 0

			if var_152_20 < arg_149_1.time_ and arg_149_1.time_ <= var_152_20 + arg_152_0 then
				arg_149_1.cswbg_:SetActive(true)

				local var_152_21 = arg_149_1.cswt_:GetComponent("RectTransform")

				arg_149_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_152_21.offsetMin = Vector2.New(410, 330)
				var_152_21.offsetMax = Vector2.New(-400, -175)

				local var_152_22 = arg_149_1:GetWordFromCfg(419061)
				local var_152_23 = arg_149_1:FormatText(var_152_22.content)

				arg_149_1.cswt_.text = var_152_23

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.cswt_)

				arg_149_1.cswt_.fontSize = 180
				arg_149_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_149_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_149_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play319881037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 319881037
		arg_153_1.duration_ = 3.33

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play319881038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.fswbg_:SetActive(true)
				arg_153_1.dialog_:SetActive(false)

				arg_153_1.fswtw_.percent = 0

				local var_156_1 = arg_153_1:GetWordFromCfg(319881037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.fswt_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.fswt_)

				arg_153_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_153_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_153_1.fswtw_:SetDirty()

				arg_153_1.typewritterCharCountI18N = 0

				SetActive(arg_153_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_153_1:ShowNextGo(false)
			end

			local var_156_3 = 1.66666666666667

			if var_156_3 < arg_153_1.time_ and arg_153_1.time_ <= var_156_3 + arg_156_0 then
				arg_153_1.var_.oldValueTypewriter = arg_153_1.fswtw_.percent

				SetActive(arg_153_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_153_1:ShowNextGo(false)
			end

			local var_156_4 = 25
			local var_156_5 = 1.66666666666667
			local var_156_6 = arg_153_1:GetWordFromCfg(319881037)
			local var_156_7 = arg_153_1:FormatText(var_156_6.content)
			local var_156_8, var_156_9 = arg_153_1:GetPercentByPara(var_156_7, 1)

			if var_156_3 < arg_153_1.time_ and arg_153_1.time_ <= var_156_3 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0

				local var_156_10 = var_156_4 <= 0 and var_156_5 or var_156_5 * ((var_156_9 - arg_153_1.typewritterCharCountI18N) / var_156_4)

				if var_156_10 > 0 and var_156_5 < var_156_10 then
					arg_153_1.talkMaxDuration = var_156_10

					if var_156_10 + var_156_3 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_3
					end
				end
			end

			local var_156_11 = 1.66666666666667
			local var_156_12 = math.max(var_156_11, arg_153_1.talkMaxDuration)

			if var_156_3 <= arg_153_1.time_ and arg_153_1.time_ < var_156_3 + var_156_12 then
				local var_156_13 = (arg_153_1.time_ - var_156_3) / var_156_12

				arg_153_1.fswtw_.percent = Mathf.Lerp(arg_153_1.var_.oldValueTypewriter, var_156_8, var_156_13)
				arg_153_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_153_1.fswtw_:SetDirty()
			end

			if arg_153_1.time_ >= var_156_3 + var_156_12 and arg_153_1.time_ < var_156_3 + var_156_12 + arg_156_0 then
				arg_153_1.fswtw_.percent = var_156_8

				arg_153_1.fswtw_:SetDirty()
				arg_153_1:ShowNextGo(true)

				arg_153_1.typewritterCharCountI18N = var_156_9
			end

			local var_156_14 = 1.66666666666667
			local var_156_15 = 1
			local var_156_16 = manager.audio:GetVoiceLength("story_v_out_319881", "319881037", "story_v_out_319881.awb") / 1000

			if var_156_16 > 0 and var_156_15 < var_156_16 and var_156_16 + var_156_14 > arg_153_1.duration_ then
				local var_156_17 = var_156_16

				arg_153_1.duration_ = var_156_16 + var_156_14
			end

			if var_156_14 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 then
				local var_156_18 = "play"
				local var_156_19 = "voice"

				arg_153_1:AudioAction(var_156_18, var_156_19, "story_v_out_319881", "319881037", "story_v_out_319881.awb")
			end

			local var_156_20 = 0

			if var_156_20 < arg_153_1.time_ and arg_153_1.time_ <= var_156_20 + arg_156_0 then
				arg_153_1.cswbg_:SetActive(true)

				local var_156_21 = arg_153_1.cswt_:GetComponent("RectTransform")

				arg_153_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_156_21.offsetMin = Vector2.New(410, 330)
				var_156_21.offsetMax = Vector2.New(-400, -175)

				local var_156_22 = arg_153_1:GetWordFromCfg(419062)
				local var_156_23 = arg_153_1:FormatText(var_156_22.content)

				arg_153_1.cswt_.text = var_156_23

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.cswt_)

				arg_153_1.cswt_.fontSize = 180
				arg_153_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_153_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_153_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play319881038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 319881038
		arg_157_1.duration_ = 2.13

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play319881039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.fswbg_:SetActive(true)
				arg_157_1.dialog_:SetActive(false)

				arg_157_1.fswtw_.percent = 0

				local var_160_1 = arg_157_1:GetWordFromCfg(319881038)
				local var_160_2 = arg_157_1:FormatText(var_160_1.content)

				arg_157_1.fswt_.text = var_160_2

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.fswt_)

				arg_157_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_157_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_157_1.fswtw_:SetDirty()

				arg_157_1.typewritterCharCountI18N = 0

				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_157_1:ShowNextGo(false)
			end

			local var_160_3 = 0.266666666666667

			if var_160_3 < arg_157_1.time_ and arg_157_1.time_ <= var_160_3 + arg_160_0 then
				arg_157_1.var_.oldValueTypewriter = arg_157_1.fswtw_.percent

				SetActive(arg_157_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_157_1:ShowNextGo(false)
			end

			local var_160_4 = 28
			local var_160_5 = 1.86666666666667
			local var_160_6 = arg_157_1:GetWordFromCfg(319881038)
			local var_160_7 = arg_157_1:FormatText(var_160_6.content)
			local var_160_8, var_160_9 = arg_157_1:GetPercentByPara(var_160_7, 1)

			if var_160_3 < arg_157_1.time_ and arg_157_1.time_ <= var_160_3 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0

				local var_160_10 = var_160_4 <= 0 and var_160_5 or var_160_5 * ((var_160_9 - arg_157_1.typewritterCharCountI18N) / var_160_4)

				if var_160_10 > 0 and var_160_5 < var_160_10 then
					arg_157_1.talkMaxDuration = var_160_10

					if var_160_10 + var_160_3 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_3
					end
				end
			end

			local var_160_11 = 1.86666666666667
			local var_160_12 = math.max(var_160_11, arg_157_1.talkMaxDuration)

			if var_160_3 <= arg_157_1.time_ and arg_157_1.time_ < var_160_3 + var_160_12 then
				local var_160_13 = (arg_157_1.time_ - var_160_3) / var_160_12

				arg_157_1.fswtw_.percent = Mathf.Lerp(arg_157_1.var_.oldValueTypewriter, var_160_8, var_160_13)
				arg_157_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_157_1.fswtw_:SetDirty()
			end

			if arg_157_1.time_ >= var_160_3 + var_160_12 and arg_157_1.time_ < var_160_3 + var_160_12 + arg_160_0 then
				arg_157_1.fswtw_.percent = var_160_8

				arg_157_1.fswtw_:SetDirty()
				arg_157_1:ShowNextGo(true)

				arg_157_1.typewritterCharCountI18N = var_160_9
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play319881039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319881039
		arg_161_1.duration_ = 1.83

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play319881040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.fswbg_:SetActive(true)
				arg_161_1.dialog_:SetActive(false)

				arg_161_1.fswtw_.percent = 0

				local var_164_1 = arg_161_1:GetWordFromCfg(319881039)
				local var_164_2 = arg_161_1:FormatText(var_164_1.content)

				arg_161_1.fswt_.text = var_164_2

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.fswt_)

				arg_161_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_161_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_161_1.fswtw_:SetDirty()

				arg_161_1.typewritterCharCountI18N = 0

				SetActive(arg_161_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_161_1:ShowNextGo(false)
			end

			local var_164_3 = 0.433333333333333

			if var_164_3 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.var_.oldValueTypewriter = arg_161_1.fswtw_.percent

				SetActive(arg_161_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_161_1:ShowNextGo(false)
			end

			local var_164_4 = 21
			local var_164_5 = 1.4
			local var_164_6 = arg_161_1:GetWordFromCfg(319881039)
			local var_164_7 = arg_161_1:FormatText(var_164_6.content)
			local var_164_8, var_164_9 = arg_161_1:GetPercentByPara(var_164_7, 1)

			if var_164_3 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0

				local var_164_10 = var_164_4 <= 0 and var_164_5 or var_164_5 * ((var_164_9 - arg_161_1.typewritterCharCountI18N) / var_164_4)

				if var_164_10 > 0 and var_164_5 < var_164_10 then
					arg_161_1.talkMaxDuration = var_164_10

					if var_164_10 + var_164_3 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_3
					end
				end
			end

			local var_164_11 = 1.4
			local var_164_12 = math.max(var_164_11, arg_161_1.talkMaxDuration)

			if var_164_3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_3 + var_164_12 then
				local var_164_13 = (arg_161_1.time_ - var_164_3) / var_164_12

				arg_161_1.fswtw_.percent = Mathf.Lerp(arg_161_1.var_.oldValueTypewriter, var_164_8, var_164_13)
				arg_161_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_161_1.fswtw_:SetDirty()
			end

			if arg_161_1.time_ >= var_164_3 + var_164_12 and arg_161_1.time_ < var_164_3 + var_164_12 + arg_164_0 then
				arg_161_1.fswtw_.percent = var_164_8

				arg_161_1.fswtw_:SetDirty()
				arg_161_1:ShowNextGo(true)

				arg_161_1.typewritterCharCountI18N = var_164_9
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play319881040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319881040
		arg_165_1.duration_ = 1.8

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play319881041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.fswbg_:SetActive(true)
				arg_165_1.dialog_:SetActive(false)

				arg_165_1.fswtw_.percent = 0

				local var_168_1 = arg_165_1:GetWordFromCfg(319881040)
				local var_168_2 = arg_165_1:FormatText(var_168_1.content)

				arg_165_1.fswt_.text = var_168_2

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.fswt_)

				arg_165_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_165_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_165_1.fswtw_:SetDirty()

				arg_165_1.typewritterCharCountI18N = 0

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_165_1:ShowNextGo(false)
			end

			local var_168_3 = 1

			if var_168_3 < arg_165_1.time_ and arg_165_1.time_ <= var_168_3 + arg_168_0 then
				arg_165_1.var_.oldValueTypewriter = arg_165_1.fswtw_.percent

				SetActive(arg_165_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_165_1:ShowNextGo(false)
			end

			local var_168_4 = 12
			local var_168_5 = 0.8
			local var_168_6 = arg_165_1:GetWordFromCfg(319881040)
			local var_168_7 = arg_165_1:FormatText(var_168_6.content)
			local var_168_8, var_168_9 = arg_165_1:GetPercentByPara(var_168_7, 1)

			if var_168_3 < arg_165_1.time_ and arg_165_1.time_ <= var_168_3 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0

				local var_168_10 = var_168_4 <= 0 and var_168_5 or var_168_5 * ((var_168_9 - arg_165_1.typewritterCharCountI18N) / var_168_4)

				if var_168_10 > 0 and var_168_5 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_3 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_3
					end
				end
			end

			local var_168_11 = 0.8
			local var_168_12 = math.max(var_168_11, arg_165_1.talkMaxDuration)

			if var_168_3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_3 + var_168_12 then
				local var_168_13 = (arg_165_1.time_ - var_168_3) / var_168_12

				arg_165_1.fswtw_.percent = Mathf.Lerp(arg_165_1.var_.oldValueTypewriter, var_168_8, var_168_13)
				arg_165_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_165_1.fswtw_:SetDirty()
			end

			if arg_165_1.time_ >= var_168_3 + var_168_12 and arg_165_1.time_ < var_168_3 + var_168_12 + arg_168_0 then
				arg_165_1.fswtw_.percent = var_168_8

				arg_165_1.fswtw_:SetDirty()
				arg_165_1:ShowNextGo(true)

				arg_165_1.typewritterCharCountI18N = var_168_9
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play319881041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319881041
		arg_169_1.duration_ = 15.77

		local var_169_0 = {
			zh = 8.466,
			ja = 15.766
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
				arg_169_0:Play319881042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				local var_172_1 = manager.ui.mainCamera.transform.localPosition
				local var_172_2 = Vector3.New(0, 0, 10) + Vector3.New(var_172_1.x, var_172_1.y, 0)
				local var_172_3 = arg_169_1.bgs_.ST70a

				var_172_3.transform.localPosition = var_172_2
				var_172_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_172_4 = var_172_3:GetComponent("SpriteRenderer")

				if var_172_4 and var_172_4.sprite then
					local var_172_5 = (var_172_3.transform.localPosition - var_172_1).z
					local var_172_6 = manager.ui.mainCameraCom_
					local var_172_7 = 2 * var_172_5 * Mathf.Tan(var_172_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_172_8 = var_172_7 * var_172_6.aspect
					local var_172_9 = var_172_4.sprite.bounds.size.x
					local var_172_10 = var_172_4.sprite.bounds.size.y
					local var_172_11 = var_172_8 / var_172_9
					local var_172_12 = var_172_7 / var_172_10
					local var_172_13 = var_172_12 < var_172_11 and var_172_11 or var_172_12

					var_172_3.transform.localScale = Vector3.New(var_172_13, var_172_13, 0)
				end

				for iter_172_0, iter_172_1 in pairs(arg_169_1.bgs_) do
					if iter_172_0 ~= "ST70a" then
						iter_172_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_172_14 = 0

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			local var_172_15 = 0.3

			if arg_169_1.time_ >= var_172_14 + var_172_15 and arg_169_1.time_ < var_172_14 + var_172_15 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end

			local var_172_16 = 0

			if var_172_16 < arg_169_1.time_ and arg_169_1.time_ <= var_172_16 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = true

				arg_169_1:SetGaussion(false)
			end

			local var_172_17 = 2

			if var_172_16 <= arg_169_1.time_ and arg_169_1.time_ < var_172_16 + var_172_17 then
				local var_172_18 = (arg_169_1.time_ - var_172_16) / var_172_17
				local var_172_19 = Color.New(0, 0, 0)

				var_172_19.a = Mathf.Lerp(1, 0, var_172_18)
				arg_169_1.mask_.color = var_172_19
			end

			if arg_169_1.time_ >= var_172_16 + var_172_17 and arg_169_1.time_ < var_172_16 + var_172_17 + arg_172_0 then
				local var_172_20 = Color.New(0, 0, 0)
				local var_172_21 = 0

				arg_169_1.mask_.enabled = false
				var_172_20.a = var_172_21
				arg_169_1.mask_.color = var_172_20
			end

			local var_172_22 = 0
			local var_172_23 = 0.2

			if var_172_22 < arg_169_1.time_ and arg_169_1.time_ <= var_172_22 + arg_172_0 then
				local var_172_24 = "play"
				local var_172_25 = "music"

				arg_169_1:AudioAction(var_172_24, var_172_25, "ui_battle", "ui_battle_stopbgm", "")

				local var_172_26 = ""
				local var_172_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_172_27 ~= "" then
					if arg_169_1.bgmTxt_.text ~= var_172_27 and arg_169_1.bgmTxt_.text ~= "" then
						if arg_169_1.bgmTxt2_.text ~= "" then
							arg_169_1.bgmTxt_.text = arg_169_1.bgmTxt2_.text
						end

						arg_169_1.bgmTxt2_.text = var_172_27

						arg_169_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_169_1.bgmTxt_.text = var_172_27
						arg_169_1.bgmTxt2_.text = var_172_27
					end

					if arg_169_1.bgmTimer then
						arg_169_1.bgmTimer:Stop()

						arg_169_1.bgmTimer = nil
					end

					if arg_169_1.settingData.show_music_name == 1 then
						arg_169_1.musicController:SetSelectedState("show")
						arg_169_1.musicAnimator_:Play("open", 0, 0)

						if arg_169_1.settingData.music_time ~= 0 then
							arg_169_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_169_1.settingData.music_time), function()
								if arg_169_1 == nil or isNil(arg_169_1.bgmTxt_) then
									return
								end

								arg_169_1.musicController:SetSelectedState("hide")
								arg_169_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_172_28 = 0.233333333333333
			local var_172_29 = 1

			if var_172_28 < arg_169_1.time_ and arg_169_1.time_ <= var_172_28 + arg_172_0 then
				local var_172_30 = "play"
				local var_172_31 = "music"

				arg_169_1:AudioAction(var_172_30, var_172_31, "bgm_activity_3_0_story_ominous", "bgm_activity_3_0_story_ominous", "bgm_activity_3_0_story_ominous.awb")

				local var_172_32 = ""
				local var_172_33 = manager.audio:GetAudioName("bgm_activity_3_0_story_ominous", "bgm_activity_3_0_story_ominous")

				if var_172_33 ~= "" then
					if arg_169_1.bgmTxt_.text ~= var_172_33 and arg_169_1.bgmTxt_.text ~= "" then
						if arg_169_1.bgmTxt2_.text ~= "" then
							arg_169_1.bgmTxt_.text = arg_169_1.bgmTxt2_.text
						end

						arg_169_1.bgmTxt2_.text = var_172_33

						arg_169_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_169_1.bgmTxt_.text = var_172_33
						arg_169_1.bgmTxt2_.text = var_172_33
					end

					if arg_169_1.bgmTimer then
						arg_169_1.bgmTimer:Stop()

						arg_169_1.bgmTimer = nil
					end

					if arg_169_1.settingData.show_music_name == 1 then
						arg_169_1.musicController:SetSelectedState("show")
						arg_169_1.musicAnimator_:Play("open", 0, 0)

						if arg_169_1.settingData.music_time ~= 0 then
							arg_169_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_169_1.settingData.music_time), function()
								if arg_169_1 == nil or isNil(arg_169_1.bgmTxt_) then
									return
								end

								arg_169_1.musicController:SetSelectedState("hide")
								arg_169_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_172_34 = 0

			if var_172_34 < arg_169_1.time_ and arg_169_1.time_ <= var_172_34 + arg_172_0 then
				arg_169_1.fswbg_:SetActive(false)
				arg_169_1.dialog_:SetActive(false)
				SetActive(arg_169_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_169_1:ShowNextGo(false)
			end

			local var_172_35 = 0.2

			if var_172_35 < arg_169_1.time_ and arg_169_1.time_ <= var_172_35 + arg_172_0 then
				arg_169_1.fswbg_:SetActive(false)
				arg_169_1.dialog_:SetActive(false)
				SetActive(arg_169_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_169_1:ShowNextGo(false)
			end

			local var_172_36 = 0

			if var_172_36 < arg_169_1.time_ and arg_169_1.time_ <= var_172_36 + arg_172_0 then
				arg_169_1.cswbg_:SetActive(false)
			end

			local var_172_37 = arg_169_1.actors_["1095ui_story"].transform
			local var_172_38 = 1.9

			if var_172_38 < arg_169_1.time_ and arg_169_1.time_ <= var_172_38 + arg_172_0 then
				arg_169_1.var_.moveOldPos1095ui_story = var_172_37.localPosition
			end

			local var_172_39 = 0.001

			if var_172_38 <= arg_169_1.time_ and arg_169_1.time_ < var_172_38 + var_172_39 then
				local var_172_40 = (arg_169_1.time_ - var_172_38) / var_172_39
				local var_172_41 = Vector3.New(0, -0.98, -6.1)

				var_172_37.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1095ui_story, var_172_41, var_172_40)

				local var_172_42 = manager.ui.mainCamera.transform.position - var_172_37.position

				var_172_37.forward = Vector3.New(var_172_42.x, var_172_42.y, var_172_42.z)

				local var_172_43 = var_172_37.localEulerAngles

				var_172_43.z = 0
				var_172_43.x = 0
				var_172_37.localEulerAngles = var_172_43
			end

			if arg_169_1.time_ >= var_172_38 + var_172_39 and arg_169_1.time_ < var_172_38 + var_172_39 + arg_172_0 then
				var_172_37.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_172_44 = manager.ui.mainCamera.transform.position - var_172_37.position

				var_172_37.forward = Vector3.New(var_172_44.x, var_172_44.y, var_172_44.z)

				local var_172_45 = var_172_37.localEulerAngles

				var_172_45.z = 0
				var_172_45.x = 0
				var_172_37.localEulerAngles = var_172_45
			end

			local var_172_46 = arg_169_1.actors_["1095ui_story"]
			local var_172_47 = 1.9

			if var_172_47 < arg_169_1.time_ and arg_169_1.time_ <= var_172_47 + arg_172_0 and not isNil(var_172_46) and arg_169_1.var_.characterEffect1095ui_story == nil then
				arg_169_1.var_.characterEffect1095ui_story = var_172_46:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_48 = 0.200000002980232

			if var_172_47 <= arg_169_1.time_ and arg_169_1.time_ < var_172_47 + var_172_48 and not isNil(var_172_46) then
				local var_172_49 = (arg_169_1.time_ - var_172_47) / var_172_48

				if arg_169_1.var_.characterEffect1095ui_story and not isNil(var_172_46) then
					arg_169_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_47 + var_172_48 and arg_169_1.time_ < var_172_47 + var_172_48 + arg_172_0 and not isNil(var_172_46) and arg_169_1.var_.characterEffect1095ui_story then
				arg_169_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_172_50 = 1.9

			if var_172_50 < arg_169_1.time_ and arg_169_1.time_ <= var_172_50 + arg_172_0 then
				arg_169_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_172_51 = 1.9

			if var_172_51 < arg_169_1.time_ and arg_169_1.time_ <= var_172_51 + arg_172_0 then
				arg_169_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_169_1.frameCnt_ <= 1 then
				arg_169_1.dialog_:SetActive(false)
			end

			local var_172_52 = 2
			local var_172_53 = 0.775

			if var_172_52 < arg_169_1.time_ and arg_169_1.time_ <= var_172_52 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0

				arg_169_1.dialog_:SetActive(true)

				arg_169_1.dialogCg_.alpha = 0

				local var_172_54 = LeanTween.value(arg_169_1.dialog_, 0, 1, 0.3)

				var_172_54:setOnUpdate(LuaHelper.FloatAction(function(arg_175_0)
					arg_169_1.dialogCg_.alpha = arg_175_0
				end))
				var_172_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_169_1.dialog_)
					var_172_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_169_1.duration_ = arg_169_1.duration_ + 0.3

				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_55 = arg_169_1:FormatText(StoryNameCfg[471].name)

				arg_169_1.leftNameTxt_.text = var_172_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_56 = arg_169_1:GetWordFromCfg(319881041)
				local var_172_57 = arg_169_1:FormatText(var_172_56.content)

				arg_169_1.text_.text = var_172_57

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_58 = 31
				local var_172_59 = utf8.len(var_172_57)
				local var_172_60 = var_172_58 <= 0 and var_172_53 or var_172_53 * (var_172_59 / var_172_58)

				if var_172_60 > 0 and var_172_53 < var_172_60 then
					arg_169_1.talkMaxDuration = var_172_60
					var_172_52 = var_172_52 + 0.3

					if var_172_60 + var_172_52 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_60 + var_172_52
					end
				end

				arg_169_1.text_.text = var_172_57
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881041", "story_v_out_319881.awb") ~= 0 then
					local var_172_61 = manager.audio:GetVoiceLength("story_v_out_319881", "319881041", "story_v_out_319881.awb") / 1000

					if var_172_61 + var_172_52 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_61 + var_172_52
					end

					if var_172_56.prefab_name ~= "" and arg_169_1.actors_[var_172_56.prefab_name] ~= nil then
						local var_172_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_56.prefab_name].transform, "story_v_out_319881", "319881041", "story_v_out_319881.awb")

						arg_169_1:RecordAudio("319881041", var_172_62)
						arg_169_1:RecordAudio("319881041", var_172_62)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319881", "319881041", "story_v_out_319881.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319881", "319881041", "story_v_out_319881.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_63 = var_172_52 + 0.3
			local var_172_64 = math.max(var_172_53, arg_169_1.talkMaxDuration)

			if var_172_63 <= arg_169_1.time_ and arg_169_1.time_ < var_172_63 + var_172_64 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_63) / var_172_64

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_63 + var_172_64 and arg_169_1.time_ < var_172_63 + var_172_64 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play319881042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319881042
		arg_177_1.duration_ = 8.47

		local var_177_0 = {
			zh = 7.933,
			ja = 8.466
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
				arg_177_0:Play319881043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1095ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1095ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, -0.98, -6.1)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1095ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = 0

			if var_180_9 < arg_177_1.time_ and arg_177_1.time_ <= var_180_9 + arg_180_0 then
				arg_177_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_180_10 = 0
			local var_180_11 = 0.9

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_12 = arg_177_1:FormatText(StoryNameCfg[471].name)

				arg_177_1.leftNameTxt_.text = var_180_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_13 = arg_177_1:GetWordFromCfg(319881042)
				local var_180_14 = arg_177_1:FormatText(var_180_13.content)

				arg_177_1.text_.text = var_180_14

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_15 = 36
				local var_180_16 = utf8.len(var_180_14)
				local var_180_17 = var_180_15 <= 0 and var_180_11 or var_180_11 * (var_180_16 / var_180_15)

				if var_180_17 > 0 and var_180_11 < var_180_17 then
					arg_177_1.talkMaxDuration = var_180_17

					if var_180_17 + var_180_10 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_17 + var_180_10
					end
				end

				arg_177_1.text_.text = var_180_14
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881042", "story_v_out_319881.awb") ~= 0 then
					local var_180_18 = manager.audio:GetVoiceLength("story_v_out_319881", "319881042", "story_v_out_319881.awb") / 1000

					if var_180_18 + var_180_10 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_18 + var_180_10
					end

					if var_180_13.prefab_name ~= "" and arg_177_1.actors_[var_180_13.prefab_name] ~= nil then
						local var_180_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_13.prefab_name].transform, "story_v_out_319881", "319881042", "story_v_out_319881.awb")

						arg_177_1:RecordAudio("319881042", var_180_19)
						arg_177_1:RecordAudio("319881042", var_180_19)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_319881", "319881042", "story_v_out_319881.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_319881", "319881042", "story_v_out_319881.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_20 = math.max(var_180_11, arg_177_1.talkMaxDuration)

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_20 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_10) / var_180_20

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_10 + var_180_20 and arg_177_1.time_ < var_180_10 + var_180_20 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319881043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319881043
		arg_181_1.duration_ = 6.3

		local var_181_0 = {
			zh = 5.133,
			ja = 6.3
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play319881044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1084ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1084ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(0.7, -0.97, -6)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1084ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["1084ui_story"]
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1084ui_story == nil then
				arg_181_1.var_.characterEffect1084ui_story = var_184_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_11 = 0.200000002980232

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 and not isNil(var_184_9) then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11

				if arg_181_1.var_.characterEffect1084ui_story and not isNil(var_184_9) then
					arg_181_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1084ui_story then
				arg_181_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_184_13 = 0

			if var_184_13 < arg_181_1.time_ and arg_181_1.time_ <= var_184_13 + arg_184_0 then
				arg_181_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_184_14 = 0

			if var_184_14 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 then
				arg_181_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_184_15 = arg_181_1.actors_["1095ui_story"]
			local var_184_16 = 0

			if var_184_16 < arg_181_1.time_ and arg_181_1.time_ <= var_184_16 + arg_184_0 and not isNil(var_184_15) and arg_181_1.var_.characterEffect1095ui_story == nil then
				arg_181_1.var_.characterEffect1095ui_story = var_184_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_17 = 0.200000002980232

			if var_184_16 <= arg_181_1.time_ and arg_181_1.time_ < var_184_16 + var_184_17 and not isNil(var_184_15) then
				local var_184_18 = (arg_181_1.time_ - var_184_16) / var_184_17

				if arg_181_1.var_.characterEffect1095ui_story and not isNil(var_184_15) then
					local var_184_19 = Mathf.Lerp(0, 0.5, var_184_18)

					arg_181_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1095ui_story.fillRatio = var_184_19
				end
			end

			if arg_181_1.time_ >= var_184_16 + var_184_17 and arg_181_1.time_ < var_184_16 + var_184_17 + arg_184_0 and not isNil(var_184_15) and arg_181_1.var_.characterEffect1095ui_story then
				local var_184_20 = 0.5

				arg_181_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1095ui_story.fillRatio = var_184_20
			end

			local var_184_21 = arg_181_1.actors_["1095ui_story"].transform
			local var_184_22 = 0

			if var_184_22 < arg_181_1.time_ and arg_181_1.time_ <= var_184_22 + arg_184_0 then
				arg_181_1.var_.moveOldPos1095ui_story = var_184_21.localPosition
			end

			local var_184_23 = 0.001

			if var_184_22 <= arg_181_1.time_ and arg_181_1.time_ < var_184_22 + var_184_23 then
				local var_184_24 = (arg_181_1.time_ - var_184_22) / var_184_23
				local var_184_25 = Vector3.New(-0.7, -0.98, -6.1)

				var_184_21.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1095ui_story, var_184_25, var_184_24)

				local var_184_26 = manager.ui.mainCamera.transform.position - var_184_21.position

				var_184_21.forward = Vector3.New(var_184_26.x, var_184_26.y, var_184_26.z)

				local var_184_27 = var_184_21.localEulerAngles

				var_184_27.z = 0
				var_184_27.x = 0
				var_184_21.localEulerAngles = var_184_27
			end

			if arg_181_1.time_ >= var_184_22 + var_184_23 and arg_181_1.time_ < var_184_22 + var_184_23 + arg_184_0 then
				var_184_21.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_184_28 = manager.ui.mainCamera.transform.position - var_184_21.position

				var_184_21.forward = Vector3.New(var_184_28.x, var_184_28.y, var_184_28.z)

				local var_184_29 = var_184_21.localEulerAngles

				var_184_29.z = 0
				var_184_29.x = 0
				var_184_21.localEulerAngles = var_184_29
			end

			local var_184_30 = 0
			local var_184_31 = 0.575

			if var_184_30 < arg_181_1.time_ and arg_181_1.time_ <= var_184_30 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_32 = arg_181_1:FormatText(StoryNameCfg[6].name)

				arg_181_1.leftNameTxt_.text = var_184_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_33 = arg_181_1:GetWordFromCfg(319881043)
				local var_184_34 = arg_181_1:FormatText(var_184_33.content)

				arg_181_1.text_.text = var_184_34

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_35 = 23
				local var_184_36 = utf8.len(var_184_34)
				local var_184_37 = var_184_35 <= 0 and var_184_31 or var_184_31 * (var_184_36 / var_184_35)

				if var_184_37 > 0 and var_184_31 < var_184_37 then
					arg_181_1.talkMaxDuration = var_184_37

					if var_184_37 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_37 + var_184_30
					end
				end

				arg_181_1.text_.text = var_184_34
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881043", "story_v_out_319881.awb") ~= 0 then
					local var_184_38 = manager.audio:GetVoiceLength("story_v_out_319881", "319881043", "story_v_out_319881.awb") / 1000

					if var_184_38 + var_184_30 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_38 + var_184_30
					end

					if var_184_33.prefab_name ~= "" and arg_181_1.actors_[var_184_33.prefab_name] ~= nil then
						local var_184_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_33.prefab_name].transform, "story_v_out_319881", "319881043", "story_v_out_319881.awb")

						arg_181_1:RecordAudio("319881043", var_184_39)
						arg_181_1:RecordAudio("319881043", var_184_39)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_319881", "319881043", "story_v_out_319881.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_319881", "319881043", "story_v_out_319881.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_40 = math.max(var_184_31, arg_181_1.talkMaxDuration)

			if var_184_30 <= arg_181_1.time_ and arg_181_1.time_ < var_184_30 + var_184_40 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_30) / var_184_40

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_30 + var_184_40 and arg_181_1.time_ < var_184_30 + var_184_40 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play319881044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319881044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play319881045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1084ui_story"]
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1084ui_story == nil then
				arg_185_1.var_.characterEffect1084ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 and not isNil(var_188_0) then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2

				if arg_185_1.var_.characterEffect1084ui_story and not isNil(var_188_0) then
					local var_188_4 = Mathf.Lerp(0, 0.5, var_188_3)

					arg_185_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1084ui_story.fillRatio = var_188_4
				end
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1084ui_story then
				local var_188_5 = 0.5

				arg_185_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1084ui_story.fillRatio = var_188_5
			end

			local var_188_6 = 0
			local var_188_7 = 1.275

			if var_188_6 < arg_185_1.time_ and arg_185_1.time_ <= var_188_6 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_8 = arg_185_1:GetWordFromCfg(319881044)
				local var_188_9 = arg_185_1:FormatText(var_188_8.content)

				arg_185_1.text_.text = var_188_9

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_10 = 51
				local var_188_11 = utf8.len(var_188_9)
				local var_188_12 = var_188_10 <= 0 and var_188_7 or var_188_7 * (var_188_11 / var_188_10)

				if var_188_12 > 0 and var_188_7 < var_188_12 then
					arg_185_1.talkMaxDuration = var_188_12

					if var_188_12 + var_188_6 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_12 + var_188_6
					end
				end

				arg_185_1.text_.text = var_188_9
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_13 = math.max(var_188_7, arg_185_1.talkMaxDuration)

			if var_188_6 <= arg_185_1.time_ and arg_185_1.time_ < var_188_6 + var_188_13 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_6) / var_188_13

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_6 + var_188_13 and arg_185_1.time_ < var_188_6 + var_188_13 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play319881045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319881045
		arg_189_1.duration_ = 7.3

		local var_189_0 = {
			zh = 3.8,
			ja = 7.3
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
				arg_189_0:Play319881046(arg_189_1)
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
					arg_189_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 and not isNil(var_192_0) and arg_189_1.var_.characterEffect1084ui_story then
				arg_189_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_192_4 = 0
			local var_192_5 = 0.325

			if var_192_4 < arg_189_1.time_ and arg_189_1.time_ <= var_192_4 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_6 = arg_189_1:FormatText(StoryNameCfg[6].name)

				arg_189_1.leftNameTxt_.text = var_192_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_7 = arg_189_1:GetWordFromCfg(319881045)
				local var_192_8 = arg_189_1:FormatText(var_192_7.content)

				arg_189_1.text_.text = var_192_8

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_9 = 13
				local var_192_10 = utf8.len(var_192_8)
				local var_192_11 = var_192_9 <= 0 and var_192_5 or var_192_5 * (var_192_10 / var_192_9)

				if var_192_11 > 0 and var_192_5 < var_192_11 then
					arg_189_1.talkMaxDuration = var_192_11

					if var_192_11 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_4
					end
				end

				arg_189_1.text_.text = var_192_8
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881045", "story_v_out_319881.awb") ~= 0 then
					local var_192_12 = manager.audio:GetVoiceLength("story_v_out_319881", "319881045", "story_v_out_319881.awb") / 1000

					if var_192_12 + var_192_4 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_12 + var_192_4
					end

					if var_192_7.prefab_name ~= "" and arg_189_1.actors_[var_192_7.prefab_name] ~= nil then
						local var_192_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_7.prefab_name].transform, "story_v_out_319881", "319881045", "story_v_out_319881.awb")

						arg_189_1:RecordAudio("319881045", var_192_13)
						arg_189_1:RecordAudio("319881045", var_192_13)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_319881", "319881045", "story_v_out_319881.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_319881", "319881045", "story_v_out_319881.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_14 = math.max(var_192_5, arg_189_1.talkMaxDuration)

			if var_192_4 <= arg_189_1.time_ and arg_189_1.time_ < var_192_4 + var_192_14 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_4) / var_192_14

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_4 + var_192_14 and arg_189_1.time_ < var_192_4 + var_192_14 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play319881046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319881046
		arg_193_1.duration_ = 7.47

		local var_193_0 = {
			zh = 6.4,
			ja = 7.466
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
				arg_193_0:Play319881047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1095ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1095ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1095ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = arg_193_1.actors_["1095ui_story"]
			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1095ui_story == nil then
				arg_193_1.var_.characterEffect1095ui_story = var_196_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_11 = 0.200000002980232

			if var_196_10 <= arg_193_1.time_ and arg_193_1.time_ < var_196_10 + var_196_11 and not isNil(var_196_9) then
				local var_196_12 = (arg_193_1.time_ - var_196_10) / var_196_11

				if arg_193_1.var_.characterEffect1095ui_story and not isNil(var_196_9) then
					arg_193_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_10 + var_196_11 and arg_193_1.time_ < var_196_10 + var_196_11 + arg_196_0 and not isNil(var_196_9) and arg_193_1.var_.characterEffect1095ui_story then
				arg_193_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_196_13 = 0

			if var_196_13 < arg_193_1.time_ and arg_193_1.time_ <= var_196_13 + arg_196_0 then
				arg_193_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_196_14 = 0

			if var_196_14 < arg_193_1.time_ and arg_193_1.time_ <= var_196_14 + arg_196_0 then
				arg_193_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_196_15 = arg_193_1.actors_["1084ui_story"]
			local var_196_16 = 0

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.characterEffect1084ui_story == nil then
				arg_193_1.var_.characterEffect1084ui_story = var_196_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_17 = 0.200000002980232

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_17 and not isNil(var_196_15) then
				local var_196_18 = (arg_193_1.time_ - var_196_16) / var_196_17

				if arg_193_1.var_.characterEffect1084ui_story and not isNil(var_196_15) then
					local var_196_19 = Mathf.Lerp(0, 0.5, var_196_18)

					arg_193_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1084ui_story.fillRatio = var_196_19
				end
			end

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 and not isNil(var_196_15) and arg_193_1.var_.characterEffect1084ui_story then
				local var_196_20 = 0.5

				arg_193_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1084ui_story.fillRatio = var_196_20
			end

			local var_196_21 = 0
			local var_196_22 = 0.55

			if var_196_21 < arg_193_1.time_ and arg_193_1.time_ <= var_196_21 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_23 = arg_193_1:FormatText(StoryNameCfg[471].name)

				arg_193_1.leftNameTxt_.text = var_196_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_24 = arg_193_1:GetWordFromCfg(319881046)
				local var_196_25 = arg_193_1:FormatText(var_196_24.content)

				arg_193_1.text_.text = var_196_25

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_26 = 22
				local var_196_27 = utf8.len(var_196_25)
				local var_196_28 = var_196_26 <= 0 and var_196_22 or var_196_22 * (var_196_27 / var_196_26)

				if var_196_28 > 0 and var_196_22 < var_196_28 then
					arg_193_1.talkMaxDuration = var_196_28

					if var_196_28 + var_196_21 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_28 + var_196_21
					end
				end

				arg_193_1.text_.text = var_196_25
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881046", "story_v_out_319881.awb") ~= 0 then
					local var_196_29 = manager.audio:GetVoiceLength("story_v_out_319881", "319881046", "story_v_out_319881.awb") / 1000

					if var_196_29 + var_196_21 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_29 + var_196_21
					end

					if var_196_24.prefab_name ~= "" and arg_193_1.actors_[var_196_24.prefab_name] ~= nil then
						local var_196_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_24.prefab_name].transform, "story_v_out_319881", "319881046", "story_v_out_319881.awb")

						arg_193_1:RecordAudio("319881046", var_196_30)
						arg_193_1:RecordAudio("319881046", var_196_30)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_319881", "319881046", "story_v_out_319881.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_319881", "319881046", "story_v_out_319881.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_31 = math.max(var_196_22, arg_193_1.talkMaxDuration)

			if var_196_21 <= arg_193_1.time_ and arg_193_1.time_ < var_196_21 + var_196_31 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_21) / var_196_31

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_21 + var_196_31 and arg_193_1.time_ < var_196_21 + var_196_31 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play319881047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 319881047
		arg_197_1.duration_ = 8.37

		local var_197_0 = {
			zh = 4.866,
			ja = 8.366
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
				arg_197_0:Play319881048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1084ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos1084ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0.7, -0.97, -6)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1084ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["1084ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1084ui_story == nil then
				arg_197_1.var_.characterEffect1084ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect1084ui_story and not isNil(var_200_9) then
					arg_197_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1084ui_story then
				arg_197_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_200_13 = 0

			if var_200_13 < arg_197_1.time_ and arg_197_1.time_ <= var_200_13 + arg_200_0 then
				arg_197_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_200_14 = arg_197_1.actors_["1095ui_story"]
			local var_200_15 = 0

			if var_200_15 < arg_197_1.time_ and arg_197_1.time_ <= var_200_15 + arg_200_0 and not isNil(var_200_14) and arg_197_1.var_.characterEffect1095ui_story == nil then
				arg_197_1.var_.characterEffect1095ui_story = var_200_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_16 = 0.200000002980232

			if var_200_15 <= arg_197_1.time_ and arg_197_1.time_ < var_200_15 + var_200_16 and not isNil(var_200_14) then
				local var_200_17 = (arg_197_1.time_ - var_200_15) / var_200_16

				if arg_197_1.var_.characterEffect1095ui_story and not isNil(var_200_14) then
					local var_200_18 = Mathf.Lerp(0, 0.5, var_200_17)

					arg_197_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1095ui_story.fillRatio = var_200_18
				end
			end

			if arg_197_1.time_ >= var_200_15 + var_200_16 and arg_197_1.time_ < var_200_15 + var_200_16 + arg_200_0 and not isNil(var_200_14) and arg_197_1.var_.characterEffect1095ui_story then
				local var_200_19 = 0.5

				arg_197_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1095ui_story.fillRatio = var_200_19
			end

			local var_200_20 = 0
			local var_200_21 = 0.4

			if var_200_20 < arg_197_1.time_ and arg_197_1.time_ <= var_200_20 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_22 = arg_197_1:FormatText(StoryNameCfg[6].name)

				arg_197_1.leftNameTxt_.text = var_200_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_23 = arg_197_1:GetWordFromCfg(319881047)
				local var_200_24 = arg_197_1:FormatText(var_200_23.content)

				arg_197_1.text_.text = var_200_24

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_25 = 16
				local var_200_26 = utf8.len(var_200_24)
				local var_200_27 = var_200_25 <= 0 and var_200_21 or var_200_21 * (var_200_26 / var_200_25)

				if var_200_27 > 0 and var_200_21 < var_200_27 then
					arg_197_1.talkMaxDuration = var_200_27

					if var_200_27 + var_200_20 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_27 + var_200_20
					end
				end

				arg_197_1.text_.text = var_200_24
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881047", "story_v_out_319881.awb") ~= 0 then
					local var_200_28 = manager.audio:GetVoiceLength("story_v_out_319881", "319881047", "story_v_out_319881.awb") / 1000

					if var_200_28 + var_200_20 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_28 + var_200_20
					end

					if var_200_23.prefab_name ~= "" and arg_197_1.actors_[var_200_23.prefab_name] ~= nil then
						local var_200_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_23.prefab_name].transform, "story_v_out_319881", "319881047", "story_v_out_319881.awb")

						arg_197_1:RecordAudio("319881047", var_200_29)
						arg_197_1:RecordAudio("319881047", var_200_29)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_319881", "319881047", "story_v_out_319881.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_319881", "319881047", "story_v_out_319881.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_30 = math.max(var_200_21, arg_197_1.talkMaxDuration)

			if var_200_20 <= arg_197_1.time_ and arg_197_1.time_ < var_200_20 + var_200_30 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_20) / var_200_30

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_20 + var_200_30 and arg_197_1.time_ < var_200_20 + var_200_30 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
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

		arg_197_1:InitPlayNodeList()
	end,
	Play319881048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 319881048
		arg_201_1.duration_ = 5.2

		local var_201_0 = {
			zh = 5.2,
			ja = 4.1
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
				arg_201_0:Play319881049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1084ui_story"]
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1084ui_story == nil then
				arg_201_1.var_.characterEffect1084ui_story = var_204_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_2 = 0.200000002980232

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 and not isNil(var_204_0) then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2

				if arg_201_1.var_.characterEffect1084ui_story and not isNil(var_204_0) then
					arg_201_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 and not isNil(var_204_0) and arg_201_1.var_.characterEffect1084ui_story then
				arg_201_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_204_4 = 0

			if var_204_4 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_204_5 = 0
			local var_204_6 = 0.575

			if var_204_5 < arg_201_1.time_ and arg_201_1.time_ <= var_204_5 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_7 = arg_201_1:FormatText(StoryNameCfg[6].name)

				arg_201_1.leftNameTxt_.text = var_204_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_8 = arg_201_1:GetWordFromCfg(319881048)
				local var_204_9 = arg_201_1:FormatText(var_204_8.content)

				arg_201_1.text_.text = var_204_9

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_10 = 23
				local var_204_11 = utf8.len(var_204_9)
				local var_204_12 = var_204_10 <= 0 and var_204_6 or var_204_6 * (var_204_11 / var_204_10)

				if var_204_12 > 0 and var_204_6 < var_204_12 then
					arg_201_1.talkMaxDuration = var_204_12

					if var_204_12 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_12 + var_204_5
					end
				end

				arg_201_1.text_.text = var_204_9
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881048", "story_v_out_319881.awb") ~= 0 then
					local var_204_13 = manager.audio:GetVoiceLength("story_v_out_319881", "319881048", "story_v_out_319881.awb") / 1000

					if var_204_13 + var_204_5 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_13 + var_204_5
					end

					if var_204_8.prefab_name ~= "" and arg_201_1.actors_[var_204_8.prefab_name] ~= nil then
						local var_204_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_8.prefab_name].transform, "story_v_out_319881", "319881048", "story_v_out_319881.awb")

						arg_201_1:RecordAudio("319881048", var_204_14)
						arg_201_1:RecordAudio("319881048", var_204_14)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_319881", "319881048", "story_v_out_319881.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_319881", "319881048", "story_v_out_319881.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_15 = math.max(var_204_6, arg_201_1.talkMaxDuration)

			if var_204_5 <= arg_201_1.time_ and arg_201_1.time_ < var_204_5 + var_204_15 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_5) / var_204_15

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_5 + var_204_15 and arg_201_1.time_ < var_204_5 + var_204_15 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play319881049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 319881049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play319881050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1084ui_story"]
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1084ui_story == nil then
				arg_205_1.var_.characterEffect1084ui_story = var_208_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 and not isNil(var_208_0) then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2

				if arg_205_1.var_.characterEffect1084ui_story and not isNil(var_208_0) then
					local var_208_4 = Mathf.Lerp(0, 0.5, var_208_3)

					arg_205_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1084ui_story.fillRatio = var_208_4
				end
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 and not isNil(var_208_0) and arg_205_1.var_.characterEffect1084ui_story then
				local var_208_5 = 0.5

				arg_205_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1084ui_story.fillRatio = var_208_5
			end

			local var_208_6 = 0
			local var_208_7 = 0.9

			if var_208_6 < arg_205_1.time_ and arg_205_1.time_ <= var_208_6 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, false)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_8 = arg_205_1:GetWordFromCfg(319881049)
				local var_208_9 = arg_205_1:FormatText(var_208_8.content)

				arg_205_1.text_.text = var_208_9

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_10 = 36
				local var_208_11 = utf8.len(var_208_9)
				local var_208_12 = var_208_10 <= 0 and var_208_7 or var_208_7 * (var_208_11 / var_208_10)

				if var_208_12 > 0 and var_208_7 < var_208_12 then
					arg_205_1.talkMaxDuration = var_208_12

					if var_208_12 + var_208_6 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_12 + var_208_6
					end
				end

				arg_205_1.text_.text = var_208_9
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_13 = math.max(var_208_7, arg_205_1.talkMaxDuration)

			if var_208_6 <= arg_205_1.time_ and arg_205_1.time_ < var_208_6 + var_208_13 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_6) / var_208_13

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_6 + var_208_13 and arg_205_1.time_ < var_208_6 + var_208_13 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play319881050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 319881050
		arg_209_1.duration_ = 11.13

		local var_209_0 = {
			zh = 8.5,
			ja = 11.133
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
				arg_209_0:Play319881051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1084ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1084ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0.7, -0.97, -6)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1084ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = arg_209_1.actors_["1084ui_story"]
			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1084ui_story == nil then
				arg_209_1.var_.characterEffect1084ui_story = var_212_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_11 = 0.200000002980232

			if var_212_10 <= arg_209_1.time_ and arg_209_1.time_ < var_212_10 + var_212_11 and not isNil(var_212_9) then
				local var_212_12 = (arg_209_1.time_ - var_212_10) / var_212_11

				if arg_209_1.var_.characterEffect1084ui_story and not isNil(var_212_9) then
					arg_209_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_10 + var_212_11 and arg_209_1.time_ < var_212_10 + var_212_11 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1084ui_story then
				arg_209_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_212_13 = 0

			if var_212_13 < arg_209_1.time_ and arg_209_1.time_ <= var_212_13 + arg_212_0 then
				arg_209_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_212_14 = 0
			local var_212_15 = 0.925

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_16 = arg_209_1:FormatText(StoryNameCfg[6].name)

				arg_209_1.leftNameTxt_.text = var_212_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_17 = arg_209_1:GetWordFromCfg(319881050)
				local var_212_18 = arg_209_1:FormatText(var_212_17.content)

				arg_209_1.text_.text = var_212_18

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_19 = 37
				local var_212_20 = utf8.len(var_212_18)
				local var_212_21 = var_212_19 <= 0 and var_212_15 or var_212_15 * (var_212_20 / var_212_19)

				if var_212_21 > 0 and var_212_15 < var_212_21 then
					arg_209_1.talkMaxDuration = var_212_21

					if var_212_21 + var_212_14 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_21 + var_212_14
					end
				end

				arg_209_1.text_.text = var_212_18
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881050", "story_v_out_319881.awb") ~= 0 then
					local var_212_22 = manager.audio:GetVoiceLength("story_v_out_319881", "319881050", "story_v_out_319881.awb") / 1000

					if var_212_22 + var_212_14 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_22 + var_212_14
					end

					if var_212_17.prefab_name ~= "" and arg_209_1.actors_[var_212_17.prefab_name] ~= nil then
						local var_212_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_17.prefab_name].transform, "story_v_out_319881", "319881050", "story_v_out_319881.awb")

						arg_209_1:RecordAudio("319881050", var_212_23)
						arg_209_1:RecordAudio("319881050", var_212_23)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_319881", "319881050", "story_v_out_319881.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_319881", "319881050", "story_v_out_319881.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_24 = math.max(var_212_15, arg_209_1.talkMaxDuration)

			if var_212_14 <= arg_209_1.time_ and arg_209_1.time_ < var_212_14 + var_212_24 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_14) / var_212_24

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_14 + var_212_24 and arg_209_1.time_ < var_212_14 + var_212_24 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
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

		arg_209_1:InitPlayNodeList()
	end,
	Play319881051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 319881051
		arg_213_1.duration_ = 12.1

		local var_213_0 = {
			zh = 6.333,
			ja = 12.1
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
				arg_213_0:Play319881052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.75

			if var_216_0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_0 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_2 = arg_213_1:FormatText(StoryNameCfg[6].name)

				arg_213_1.leftNameTxt_.text = var_216_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_3 = arg_213_1:GetWordFromCfg(319881051)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881051", "story_v_out_319881.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881051", "story_v_out_319881.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_319881", "319881051", "story_v_out_319881.awb")

						arg_213_1:RecordAudio("319881051", var_216_9)
						arg_213_1:RecordAudio("319881051", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_319881", "319881051", "story_v_out_319881.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_319881", "319881051", "story_v_out_319881.awb")
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
	Play319881052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 319881052
		arg_217_1.duration_ = 6.35

		local var_217_0 = {
			zh = 3.583,
			ja = 6.35
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
				arg_217_0:Play319881053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1084ui_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos1084ui_story = var_220_0.localPosition
			end

			local var_220_2 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2
				local var_220_4 = Vector3.New(0.7, -0.97, -6)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1084ui_story, var_220_4, var_220_3)

				local var_220_5 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_5.x, var_220_5.y, var_220_5.z)

				local var_220_6 = var_220_0.localEulerAngles

				var_220_6.z = 0
				var_220_6.x = 0
				var_220_0.localEulerAngles = var_220_6
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_220_7 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_7.x, var_220_7.y, var_220_7.z)

				local var_220_8 = var_220_0.localEulerAngles

				var_220_8.z = 0
				var_220_8.x = 0
				var_220_0.localEulerAngles = var_220_8
			end

			local var_220_9 = arg_217_1.actors_["1084ui_story"]
			local var_220_10 = 0

			if var_220_10 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect1084ui_story == nil then
				arg_217_1.var_.characterEffect1084ui_story = var_220_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_11 = 0.200000002980232

			if var_220_10 <= arg_217_1.time_ and arg_217_1.time_ < var_220_10 + var_220_11 and not isNil(var_220_9) then
				local var_220_12 = (arg_217_1.time_ - var_220_10) / var_220_11

				if arg_217_1.var_.characterEffect1084ui_story and not isNil(var_220_9) then
					arg_217_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_10 + var_220_11 and arg_217_1.time_ < var_220_10 + var_220_11 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect1084ui_story then
				arg_217_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_220_13 = 0

			if var_220_13 < arg_217_1.time_ and arg_217_1.time_ <= var_220_13 + arg_220_0 then
				arg_217_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_220_14 = 0

			if var_220_14 < arg_217_1.time_ and arg_217_1.time_ <= var_220_14 + arg_220_0 then
				arg_217_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if arg_217_1.frameCnt_ <= 1 then
				arg_217_1.dialog_:SetActive(false)
			end

			local var_220_15 = 0.75
			local var_220_16 = 0.25

			if var_220_15 < arg_217_1.time_ and arg_217_1.time_ <= var_220_15 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0

				arg_217_1.dialog_:SetActive(true)

				arg_217_1.dialogCg_.alpha = 0

				local var_220_17 = LeanTween.value(arg_217_1.dialog_, 0, 1, 0.3)

				var_220_17:setOnUpdate(LuaHelper.FloatAction(function(arg_221_0)
					arg_217_1.dialogCg_.alpha = arg_221_0
				end))
				var_220_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_217_1.dialog_)
					var_220_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_217_1.duration_ = arg_217_1.duration_ + 0.3

				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_18 = arg_217_1:FormatText(StoryNameCfg[6].name)

				arg_217_1.leftNameTxt_.text = var_220_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_19 = arg_217_1:GetWordFromCfg(319881052)
				local var_220_20 = arg_217_1:FormatText(var_220_19.content)

				arg_217_1.text_.text = var_220_20

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_21 = 10
				local var_220_22 = utf8.len(var_220_20)
				local var_220_23 = var_220_21 <= 0 and var_220_16 or var_220_16 * (var_220_22 / var_220_21)

				if var_220_23 > 0 and var_220_16 < var_220_23 then
					arg_217_1.talkMaxDuration = var_220_23
					var_220_15 = var_220_15 + 0.3

					if var_220_23 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_15
					end
				end

				arg_217_1.text_.text = var_220_20
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881052", "story_v_out_319881.awb") ~= 0 then
					local var_220_24 = manager.audio:GetVoiceLength("story_v_out_319881", "319881052", "story_v_out_319881.awb") / 1000

					if var_220_24 + var_220_15 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_24 + var_220_15
					end

					if var_220_19.prefab_name ~= "" and arg_217_1.actors_[var_220_19.prefab_name] ~= nil then
						local var_220_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_19.prefab_name].transform, "story_v_out_319881", "319881052", "story_v_out_319881.awb")

						arg_217_1:RecordAudio("319881052", var_220_25)
						arg_217_1:RecordAudio("319881052", var_220_25)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_319881", "319881052", "story_v_out_319881.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_319881", "319881052", "story_v_out_319881.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_26 = var_220_15 + 0.3
			local var_220_27 = math.max(var_220_16, arg_217_1.talkMaxDuration)

			if var_220_26 <= arg_217_1.time_ and arg_217_1.time_ < var_220_26 + var_220_27 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_26) / var_220_27

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_26 + var_220_27 and arg_217_1.time_ < var_220_26 + var_220_27 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
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

		arg_217_1:InitPlayNodeList()
	end,
	Play319881053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 319881053
		arg_223_1.duration_ = 7.3

		local var_223_0 = {
			zh = 7.3,
			ja = 5.3
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play319881054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1084ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1084ui_story == nil then
				arg_223_1.var_.characterEffect1084ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect1084ui_story and not isNil(var_226_0) then
					local var_226_4 = Mathf.Lerp(0, 0.5, var_226_3)

					arg_223_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_223_1.var_.characterEffect1084ui_story.fillRatio = var_226_4
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1084ui_story then
				local var_226_5 = 0.5

				arg_223_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_223_1.var_.characterEffect1084ui_story.fillRatio = var_226_5
			end

			local var_226_6 = arg_223_1.actors_["1095ui_story"]
			local var_226_7 = 0

			if var_226_7 < arg_223_1.time_ and arg_223_1.time_ <= var_226_7 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect1095ui_story == nil then
				arg_223_1.var_.characterEffect1095ui_story = var_226_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_8 = 0.200000002980232

			if var_226_7 <= arg_223_1.time_ and arg_223_1.time_ < var_226_7 + var_226_8 and not isNil(var_226_6) then
				local var_226_9 = (arg_223_1.time_ - var_226_7) / var_226_8

				if arg_223_1.var_.characterEffect1095ui_story and not isNil(var_226_6) then
					arg_223_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_7 + var_226_8 and arg_223_1.time_ < var_226_7 + var_226_8 + arg_226_0 and not isNil(var_226_6) and arg_223_1.var_.characterEffect1095ui_story then
				arg_223_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_226_10 = 0
			local var_226_11 = 0.85

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_12 = arg_223_1:FormatText(StoryNameCfg[471].name)

				arg_223_1.leftNameTxt_.text = var_226_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_13 = arg_223_1:GetWordFromCfg(319881053)
				local var_226_14 = arg_223_1:FormatText(var_226_13.content)

				arg_223_1.text_.text = var_226_14

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_15 = 34
				local var_226_16 = utf8.len(var_226_14)
				local var_226_17 = var_226_15 <= 0 and var_226_11 or var_226_11 * (var_226_16 / var_226_15)

				if var_226_17 > 0 and var_226_11 < var_226_17 then
					arg_223_1.talkMaxDuration = var_226_17

					if var_226_17 + var_226_10 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_17 + var_226_10
					end
				end

				arg_223_1.text_.text = var_226_14
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881053", "story_v_out_319881.awb") ~= 0 then
					local var_226_18 = manager.audio:GetVoiceLength("story_v_out_319881", "319881053", "story_v_out_319881.awb") / 1000

					if var_226_18 + var_226_10 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_18 + var_226_10
					end

					if var_226_13.prefab_name ~= "" and arg_223_1.actors_[var_226_13.prefab_name] ~= nil then
						local var_226_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_13.prefab_name].transform, "story_v_out_319881", "319881053", "story_v_out_319881.awb")

						arg_223_1:RecordAudio("319881053", var_226_19)
						arg_223_1:RecordAudio("319881053", var_226_19)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_319881", "319881053", "story_v_out_319881.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_319881", "319881053", "story_v_out_319881.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_20 = math.max(var_226_11, arg_223_1.talkMaxDuration)

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_20 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_10) / var_226_20

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_10 + var_226_20 and arg_223_1.time_ < var_226_10 + var_226_20 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play319881054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 319881054
		arg_227_1.duration_ = 10.13

		local var_227_0 = {
			zh = 6.666,
			ja = 10.133
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play319881055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1095ui_story"].transform
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1.var_.moveOldPos1095ui_story = var_230_0.localPosition
			end

			local var_230_2 = 0.001

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2
				local var_230_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_230_0.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1095ui_story, var_230_4, var_230_3)

				local var_230_5 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_5.x, var_230_5.y, var_230_5.z)

				local var_230_6 = var_230_0.localEulerAngles

				var_230_6.z = 0
				var_230_6.x = 0
				var_230_0.localEulerAngles = var_230_6
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 then
				var_230_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_230_7 = manager.ui.mainCamera.transform.position - var_230_0.position

				var_230_0.forward = Vector3.New(var_230_7.x, var_230_7.y, var_230_7.z)

				local var_230_8 = var_230_0.localEulerAngles

				var_230_8.z = 0
				var_230_8.x = 0
				var_230_0.localEulerAngles = var_230_8
			end

			local var_230_9 = 0

			if var_230_9 < arg_227_1.time_ and arg_227_1.time_ <= var_230_9 + arg_230_0 then
				arg_227_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_230_10 = 0

			if var_230_10 < arg_227_1.time_ and arg_227_1.time_ <= var_230_10 + arg_230_0 then
				arg_227_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_230_11 = 0
			local var_230_12 = 0.825

			if var_230_11 < arg_227_1.time_ and arg_227_1.time_ <= var_230_11 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_13 = arg_227_1:FormatText(StoryNameCfg[471].name)

				arg_227_1.leftNameTxt_.text = var_230_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_14 = arg_227_1:GetWordFromCfg(319881054)
				local var_230_15 = arg_227_1:FormatText(var_230_14.content)

				arg_227_1.text_.text = var_230_15

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_16 = 33
				local var_230_17 = utf8.len(var_230_15)
				local var_230_18 = var_230_16 <= 0 and var_230_12 or var_230_12 * (var_230_17 / var_230_16)

				if var_230_18 > 0 and var_230_12 < var_230_18 then
					arg_227_1.talkMaxDuration = var_230_18

					if var_230_18 + var_230_11 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_18 + var_230_11
					end
				end

				arg_227_1.text_.text = var_230_15
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881054", "story_v_out_319881.awb") ~= 0 then
					local var_230_19 = manager.audio:GetVoiceLength("story_v_out_319881", "319881054", "story_v_out_319881.awb") / 1000

					if var_230_19 + var_230_11 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_19 + var_230_11
					end

					if var_230_14.prefab_name ~= "" and arg_227_1.actors_[var_230_14.prefab_name] ~= nil then
						local var_230_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_14.prefab_name].transform, "story_v_out_319881", "319881054", "story_v_out_319881.awb")

						arg_227_1:RecordAudio("319881054", var_230_20)
						arg_227_1:RecordAudio("319881054", var_230_20)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_319881", "319881054", "story_v_out_319881.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_319881", "319881054", "story_v_out_319881.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_21 = math.max(var_230_12, arg_227_1.talkMaxDuration)

			if var_230_11 <= arg_227_1.time_ and arg_227_1.time_ < var_230_11 + var_230_21 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_11) / var_230_21

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_11 + var_230_21 and arg_227_1.time_ < var_230_11 + var_230_21 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play319881055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 319881055
		arg_231_1.duration_ = 7.33

		local var_231_0 = {
			zh = 7.333,
			ja = 5.9
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play319881056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1084ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos1084ui_story = var_234_0.localPosition
			end

			local var_234_2 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2
				local var_234_4 = Vector3.New(0.7, -0.97, -6)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1084ui_story, var_234_4, var_234_3)

				local var_234_5 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_5.x, var_234_5.y, var_234_5.z)

				local var_234_6 = var_234_0.localEulerAngles

				var_234_6.z = 0
				var_234_6.x = 0
				var_234_0.localEulerAngles = var_234_6
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_234_7 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_7.x, var_234_7.y, var_234_7.z)

				local var_234_8 = var_234_0.localEulerAngles

				var_234_8.z = 0
				var_234_8.x = 0
				var_234_0.localEulerAngles = var_234_8
			end

			local var_234_9 = arg_231_1.actors_["1084ui_story"]
			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 and not isNil(var_234_9) and arg_231_1.var_.characterEffect1084ui_story == nil then
				arg_231_1.var_.characterEffect1084ui_story = var_234_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_11 = 0.200000002980232

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_11 and not isNil(var_234_9) then
				local var_234_12 = (arg_231_1.time_ - var_234_10) / var_234_11

				if arg_231_1.var_.characterEffect1084ui_story and not isNil(var_234_9) then
					arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_10 + var_234_11 and arg_231_1.time_ < var_234_10 + var_234_11 + arg_234_0 and not isNil(var_234_9) and arg_231_1.var_.characterEffect1084ui_story then
				arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_234_13 = 0

			if var_234_13 < arg_231_1.time_ and arg_231_1.time_ <= var_234_13 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			local var_234_14 = 0

			if var_234_14 < arg_231_1.time_ and arg_231_1.time_ <= var_234_14 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_234_15 = arg_231_1.actors_["1095ui_story"]
			local var_234_16 = 0

			if var_234_16 < arg_231_1.time_ and arg_231_1.time_ <= var_234_16 + arg_234_0 and not isNil(var_234_15) and arg_231_1.var_.characterEffect1095ui_story == nil then
				arg_231_1.var_.characterEffect1095ui_story = var_234_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_17 = 0.200000002980232

			if var_234_16 <= arg_231_1.time_ and arg_231_1.time_ < var_234_16 + var_234_17 and not isNil(var_234_15) then
				local var_234_18 = (arg_231_1.time_ - var_234_16) / var_234_17

				if arg_231_1.var_.characterEffect1095ui_story and not isNil(var_234_15) then
					local var_234_19 = Mathf.Lerp(0, 0.5, var_234_18)

					arg_231_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1095ui_story.fillRatio = var_234_19
				end
			end

			if arg_231_1.time_ >= var_234_16 + var_234_17 and arg_231_1.time_ < var_234_16 + var_234_17 + arg_234_0 and not isNil(var_234_15) and arg_231_1.var_.characterEffect1095ui_story then
				local var_234_20 = 0.5

				arg_231_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1095ui_story.fillRatio = var_234_20
			end

			local var_234_21 = 0
			local var_234_22 = 0.925

			if var_234_21 < arg_231_1.time_ and arg_231_1.time_ <= var_234_21 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_23 = arg_231_1:FormatText(StoryNameCfg[6].name)

				arg_231_1.leftNameTxt_.text = var_234_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_24 = arg_231_1:GetWordFromCfg(319881055)
				local var_234_25 = arg_231_1:FormatText(var_234_24.content)

				arg_231_1.text_.text = var_234_25

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_26 = 37
				local var_234_27 = utf8.len(var_234_25)
				local var_234_28 = var_234_26 <= 0 and var_234_22 or var_234_22 * (var_234_27 / var_234_26)

				if var_234_28 > 0 and var_234_22 < var_234_28 then
					arg_231_1.talkMaxDuration = var_234_28

					if var_234_28 + var_234_21 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_28 + var_234_21
					end
				end

				arg_231_1.text_.text = var_234_25
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881055", "story_v_out_319881.awb") ~= 0 then
					local var_234_29 = manager.audio:GetVoiceLength("story_v_out_319881", "319881055", "story_v_out_319881.awb") / 1000

					if var_234_29 + var_234_21 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_29 + var_234_21
					end

					if var_234_24.prefab_name ~= "" and arg_231_1.actors_[var_234_24.prefab_name] ~= nil then
						local var_234_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_24.prefab_name].transform, "story_v_out_319881", "319881055", "story_v_out_319881.awb")

						arg_231_1:RecordAudio("319881055", var_234_30)
						arg_231_1:RecordAudio("319881055", var_234_30)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_319881", "319881055", "story_v_out_319881.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_319881", "319881055", "story_v_out_319881.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_31 = math.max(var_234_22, arg_231_1.talkMaxDuration)

			if var_234_21 <= arg_231_1.time_ and arg_231_1.time_ < var_234_21 + var_234_31 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_21) / var_234_31

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_21 + var_234_31 and arg_231_1.time_ < var_234_21 + var_234_31 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
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

		arg_231_1:InitPlayNodeList()
	end,
	Play319881056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 319881056
		arg_235_1.duration_ = 6.07

		local var_235_0 = {
			zh = 5.6,
			ja = 6.066
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play319881057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4813")
			end

			local var_238_1 = 0
			local var_238_2 = 0.775

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_3 = arg_235_1:FormatText(StoryNameCfg[6].name)

				arg_235_1.leftNameTxt_.text = var_238_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_4 = arg_235_1:GetWordFromCfg(319881056)
				local var_238_5 = arg_235_1:FormatText(var_238_4.content)

				arg_235_1.text_.text = var_238_5

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_6 = 31
				local var_238_7 = utf8.len(var_238_5)
				local var_238_8 = var_238_6 <= 0 and var_238_2 or var_238_2 * (var_238_7 / var_238_6)

				if var_238_8 > 0 and var_238_2 < var_238_8 then
					arg_235_1.talkMaxDuration = var_238_8

					if var_238_8 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_8 + var_238_1
					end
				end

				arg_235_1.text_.text = var_238_5
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881056", "story_v_out_319881.awb") ~= 0 then
					local var_238_9 = manager.audio:GetVoiceLength("story_v_out_319881", "319881056", "story_v_out_319881.awb") / 1000

					if var_238_9 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_1
					end

					if var_238_4.prefab_name ~= "" and arg_235_1.actors_[var_238_4.prefab_name] ~= nil then
						local var_238_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_4.prefab_name].transform, "story_v_out_319881", "319881056", "story_v_out_319881.awb")

						arg_235_1:RecordAudio("319881056", var_238_10)
						arg_235_1:RecordAudio("319881056", var_238_10)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_319881", "319881056", "story_v_out_319881.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_319881", "319881056", "story_v_out_319881.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_11 = math.max(var_238_2, arg_235_1.talkMaxDuration)

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_11 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_1) / var_238_11

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_1 + var_238_11 and arg_235_1.time_ < var_238_1 + var_238_11 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play319881057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 319881057
		arg_239_1.duration_ = 2

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play319881058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["1084ui_story"].transform
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.var_.moveOldPos1084ui_story = var_242_0.localPosition
			end

			local var_242_2 = 0.001

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2
				local var_242_4 = Vector3.New(0.7, -0.97, -6)

				var_242_0.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1084ui_story, var_242_4, var_242_3)

				local var_242_5 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_5.x, var_242_5.y, var_242_5.z)

				local var_242_6 = var_242_0.localEulerAngles

				var_242_6.z = 0
				var_242_6.x = 0
				var_242_0.localEulerAngles = var_242_6
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 then
				var_242_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_242_7 = manager.ui.mainCamera.transform.position - var_242_0.position

				var_242_0.forward = Vector3.New(var_242_7.x, var_242_7.y, var_242_7.z)

				local var_242_8 = var_242_0.localEulerAngles

				var_242_8.z = 0
				var_242_8.x = 0
				var_242_0.localEulerAngles = var_242_8
			end

			local var_242_9 = arg_239_1.actors_["1084ui_story"]
			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1084ui_story == nil then
				arg_239_1.var_.characterEffect1084ui_story = var_242_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_11 = 0.200000002980232

			if var_242_10 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 and not isNil(var_242_9) then
				local var_242_12 = (arg_239_1.time_ - var_242_10) / var_242_11

				if arg_239_1.var_.characterEffect1084ui_story and not isNil(var_242_9) then
					arg_239_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 and not isNil(var_242_9) and arg_239_1.var_.characterEffect1084ui_story then
				arg_239_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_242_13 = 0

			if var_242_13 < arg_239_1.time_ and arg_239_1.time_ <= var_242_13 + arg_242_0 then
				arg_239_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_14 = 0.366666666666667
			local var_242_15 = 0.125

			if var_242_14 < arg_239_1.time_ and arg_239_1.time_ <= var_242_14 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_16 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_16:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_239_1.dialogCg_.alpha = arg_243_0
				end))
				var_242_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_17 = arg_239_1:FormatText(StoryNameCfg[6].name)

				arg_239_1.leftNameTxt_.text = var_242_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_18 = arg_239_1:GetWordFromCfg(319881057)
				local var_242_19 = arg_239_1:FormatText(var_242_18.content)

				arg_239_1.text_.text = var_242_19

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_20 = 5
				local var_242_21 = utf8.len(var_242_19)
				local var_242_22 = var_242_20 <= 0 and var_242_15 or var_242_15 * (var_242_21 / var_242_20)

				if var_242_22 > 0 and var_242_15 < var_242_22 then
					arg_239_1.talkMaxDuration = var_242_22
					var_242_14 = var_242_14 + 0.3

					if var_242_22 + var_242_14 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_22 + var_242_14
					end
				end

				arg_239_1.text_.text = var_242_19
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881057", "story_v_out_319881.awb") ~= 0 then
					local var_242_23 = manager.audio:GetVoiceLength("story_v_out_319881", "319881057", "story_v_out_319881.awb") / 1000

					if var_242_23 + var_242_14 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_23 + var_242_14
					end

					if var_242_18.prefab_name ~= "" and arg_239_1.actors_[var_242_18.prefab_name] ~= nil then
						local var_242_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_18.prefab_name].transform, "story_v_out_319881", "319881057", "story_v_out_319881.awb")

						arg_239_1:RecordAudio("319881057", var_242_24)
						arg_239_1:RecordAudio("319881057", var_242_24)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_319881", "319881057", "story_v_out_319881.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_319881", "319881057", "story_v_out_319881.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_25 = var_242_14 + 0.3
			local var_242_26 = math.max(var_242_15, arg_239_1.talkMaxDuration)

			if var_242_25 <= arg_239_1.time_ and arg_239_1.time_ < var_242_25 + var_242_26 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_25) / var_242_26

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_25 + var_242_26 and arg_239_1.time_ < var_242_25 + var_242_26 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
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

		arg_239_1:InitPlayNodeList()
	end,
	Play319881058 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 319881058
		arg_245_1.duration_ = 2

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play319881059(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1095ui_story"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos1095ui_story = var_248_0.localPosition
			end

			local var_248_2 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2
				local var_248_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1095ui_story, var_248_4, var_248_3)

				local var_248_5 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_5.x, var_248_5.y, var_248_5.z)

				local var_248_6 = var_248_0.localEulerAngles

				var_248_6.z = 0
				var_248_6.x = 0
				var_248_0.localEulerAngles = var_248_6
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_248_7 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_7.x, var_248_7.y, var_248_7.z)

				local var_248_8 = var_248_0.localEulerAngles

				var_248_8.z = 0
				var_248_8.x = 0
				var_248_0.localEulerAngles = var_248_8
			end

			local var_248_9 = arg_245_1.actors_["1095ui_story"]
			local var_248_10 = 0

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 and not isNil(var_248_9) and arg_245_1.var_.characterEffect1095ui_story == nil then
				arg_245_1.var_.characterEffect1095ui_story = var_248_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_11 = 0.200000002980232

			if var_248_10 <= arg_245_1.time_ and arg_245_1.time_ < var_248_10 + var_248_11 and not isNil(var_248_9) then
				local var_248_12 = (arg_245_1.time_ - var_248_10) / var_248_11

				if arg_245_1.var_.characterEffect1095ui_story and not isNil(var_248_9) then
					arg_245_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_10 + var_248_11 and arg_245_1.time_ < var_248_10 + var_248_11 + arg_248_0 and not isNil(var_248_9) and arg_245_1.var_.characterEffect1095ui_story then
				arg_245_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_248_13 = 0

			if var_248_13 < arg_245_1.time_ and arg_245_1.time_ <= var_248_13 + arg_248_0 then
				arg_245_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_248_14 = 0

			if var_248_14 < arg_245_1.time_ and arg_245_1.time_ <= var_248_14 + arg_248_0 then
				arg_245_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_248_15 = arg_245_1.actors_["1084ui_story"]
			local var_248_16 = 0

			if var_248_16 < arg_245_1.time_ and arg_245_1.time_ <= var_248_16 + arg_248_0 and not isNil(var_248_15) and arg_245_1.var_.characterEffect1084ui_story == nil then
				arg_245_1.var_.characterEffect1084ui_story = var_248_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_17 = 0.200000002980232

			if var_248_16 <= arg_245_1.time_ and arg_245_1.time_ < var_248_16 + var_248_17 and not isNil(var_248_15) then
				local var_248_18 = (arg_245_1.time_ - var_248_16) / var_248_17

				if arg_245_1.var_.characterEffect1084ui_story and not isNil(var_248_15) then
					local var_248_19 = Mathf.Lerp(0, 0.5, var_248_18)

					arg_245_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1084ui_story.fillRatio = var_248_19
				end
			end

			if arg_245_1.time_ >= var_248_16 + var_248_17 and arg_245_1.time_ < var_248_16 + var_248_17 + arg_248_0 and not isNil(var_248_15) and arg_245_1.var_.characterEffect1084ui_story then
				local var_248_20 = 0.5

				arg_245_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1084ui_story.fillRatio = var_248_20
			end

			local var_248_21 = 0
			local var_248_22 = 0.05

			if var_248_21 < arg_245_1.time_ and arg_245_1.time_ <= var_248_21 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0

				arg_245_1.dialog_:SetActive(true)

				arg_245_1.dialogCg_.alpha = 0

				local var_248_23 = LeanTween.value(arg_245_1.dialog_, 0, 1, 0.3)

				var_248_23:setOnUpdate(LuaHelper.FloatAction(function(arg_249_0)
					arg_245_1.dialogCg_.alpha = arg_249_0
				end))
				var_248_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_245_1.dialog_)
					var_248_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_245_1.duration_ = arg_245_1.duration_ + 0.3

				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_24 = arg_245_1:FormatText(StoryNameCfg[471].name)

				arg_245_1.leftNameTxt_.text = var_248_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_25 = arg_245_1:GetWordFromCfg(319881058)
				local var_248_26 = arg_245_1:FormatText(var_248_25.content)

				arg_245_1.text_.text = var_248_26

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_27 = 2
				local var_248_28 = utf8.len(var_248_26)
				local var_248_29 = var_248_27 <= 0 and var_248_22 or var_248_22 * (var_248_28 / var_248_27)

				if var_248_29 > 0 and var_248_22 < var_248_29 then
					arg_245_1.talkMaxDuration = var_248_29
					var_248_21 = var_248_21 + 0.3

					if var_248_29 + var_248_21 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_29 + var_248_21
					end
				end

				arg_245_1.text_.text = var_248_26
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881058", "story_v_out_319881.awb") ~= 0 then
					local var_248_30 = manager.audio:GetVoiceLength("story_v_out_319881", "319881058", "story_v_out_319881.awb") / 1000

					if var_248_30 + var_248_21 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_30 + var_248_21
					end

					if var_248_25.prefab_name ~= "" and arg_245_1.actors_[var_248_25.prefab_name] ~= nil then
						local var_248_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_25.prefab_name].transform, "story_v_out_319881", "319881058", "story_v_out_319881.awb")

						arg_245_1:RecordAudio("319881058", var_248_31)
						arg_245_1:RecordAudio("319881058", var_248_31)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_319881", "319881058", "story_v_out_319881.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_319881", "319881058", "story_v_out_319881.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_32 = var_248_21 + 0.3
			local var_248_33 = math.max(var_248_22, arg_245_1.talkMaxDuration)

			if var_248_32 <= arg_245_1.time_ and arg_245_1.time_ < var_248_32 + var_248_33 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_32) / var_248_33

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_32 + var_248_33 and arg_245_1.time_ < var_248_32 + var_248_33 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_245_1:InitPlayNodeList()
	end,
	Play319881059 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 319881059
		arg_251_1.duration_ = 5.63

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play319881060(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = "ML0206"

			if arg_251_1.bgs_[var_254_0] == nil then
				local var_254_1 = Object.Instantiate(arg_251_1.paintGo_)

				var_254_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_254_0)
				var_254_1.name = var_254_0
				var_254_1.transform.parent = arg_251_1.stage_.transform
				var_254_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_251_1.bgs_[var_254_0] = var_254_1
			end

			local var_254_2 = 0.00200000554323188

			if var_254_2 < arg_251_1.time_ and arg_251_1.time_ <= var_254_2 + arg_254_0 then
				local var_254_3 = manager.ui.mainCamera.transform.localPosition
				local var_254_4 = Vector3.New(0, 0, 10) + Vector3.New(var_254_3.x, var_254_3.y, 0)
				local var_254_5 = arg_251_1.bgs_.ML0206

				var_254_5.transform.localPosition = var_254_4
				var_254_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_254_6 = var_254_5:GetComponent("SpriteRenderer")

				if var_254_6 and var_254_6.sprite then
					local var_254_7 = (var_254_5.transform.localPosition - var_254_3).z
					local var_254_8 = manager.ui.mainCameraCom_
					local var_254_9 = 2 * var_254_7 * Mathf.Tan(var_254_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_254_10 = var_254_9 * var_254_8.aspect
					local var_254_11 = var_254_6.sprite.bounds.size.x
					local var_254_12 = var_254_6.sprite.bounds.size.y
					local var_254_13 = var_254_10 / var_254_11
					local var_254_14 = var_254_9 / var_254_12
					local var_254_15 = var_254_14 < var_254_13 and var_254_13 or var_254_14

					var_254_5.transform.localScale = Vector3.New(var_254_15, var_254_15, 0)
				end

				for iter_254_0, iter_254_1 in pairs(arg_251_1.bgs_) do
					if iter_254_0 ~= "ML0206" then
						iter_254_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_254_16 = 0

			if var_254_16 < arg_251_1.time_ and arg_251_1.time_ <= var_254_16 + arg_254_0 then
				arg_251_1.mask_.enabled = true
				arg_251_1.mask_.raycastTarget = true

				arg_251_1:SetGaussion(false)
			end

			local var_254_17 = 0.6

			if var_254_16 <= arg_251_1.time_ and arg_251_1.time_ < var_254_16 + var_254_17 then
				local var_254_18 = (arg_251_1.time_ - var_254_16) / var_254_17
				local var_254_19 = Color.New(1, 1, 1)

				var_254_19.a = Mathf.Lerp(1, 0, var_254_18)
				arg_251_1.mask_.color = var_254_19
			end

			if arg_251_1.time_ >= var_254_16 + var_254_17 and arg_251_1.time_ < var_254_16 + var_254_17 + arg_254_0 then
				local var_254_20 = Color.New(1, 1, 1)
				local var_254_21 = 0

				arg_251_1.mask_.enabled = false
				var_254_20.a = var_254_21
				arg_251_1.mask_.color = var_254_20
			end

			local var_254_22 = arg_251_1.actors_["1095ui_story"].transform
			local var_254_23 = 0

			if var_254_23 < arg_251_1.time_ and arg_251_1.time_ <= var_254_23 + arg_254_0 then
				arg_251_1.var_.moveOldPos1095ui_story = var_254_22.localPosition
			end

			local var_254_24 = 0.001

			if var_254_23 <= arg_251_1.time_ and arg_251_1.time_ < var_254_23 + var_254_24 then
				local var_254_25 = (arg_251_1.time_ - var_254_23) / var_254_24
				local var_254_26 = Vector3.New(0, 100, 0)

				var_254_22.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1095ui_story, var_254_26, var_254_25)

				local var_254_27 = manager.ui.mainCamera.transform.position - var_254_22.position

				var_254_22.forward = Vector3.New(var_254_27.x, var_254_27.y, var_254_27.z)

				local var_254_28 = var_254_22.localEulerAngles

				var_254_28.z = 0
				var_254_28.x = 0
				var_254_22.localEulerAngles = var_254_28
			end

			if arg_251_1.time_ >= var_254_23 + var_254_24 and arg_251_1.time_ < var_254_23 + var_254_24 + arg_254_0 then
				var_254_22.localPosition = Vector3.New(0, 100, 0)

				local var_254_29 = manager.ui.mainCamera.transform.position - var_254_22.position

				var_254_22.forward = Vector3.New(var_254_29.x, var_254_29.y, var_254_29.z)

				local var_254_30 = var_254_22.localEulerAngles

				var_254_30.z = 0
				var_254_30.x = 0
				var_254_22.localEulerAngles = var_254_30
			end

			local var_254_31 = arg_251_1.actors_["1084ui_story"].transform
			local var_254_32 = 0

			if var_254_32 < arg_251_1.time_ and arg_251_1.time_ <= var_254_32 + arg_254_0 then
				arg_251_1.var_.moveOldPos1084ui_story = var_254_31.localPosition
			end

			local var_254_33 = 0.001

			if var_254_32 <= arg_251_1.time_ and arg_251_1.time_ < var_254_32 + var_254_33 then
				local var_254_34 = (arg_251_1.time_ - var_254_32) / var_254_33
				local var_254_35 = Vector3.New(0, 100, 0)

				var_254_31.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1084ui_story, var_254_35, var_254_34)

				local var_254_36 = manager.ui.mainCamera.transform.position - var_254_31.position

				var_254_31.forward = Vector3.New(var_254_36.x, var_254_36.y, var_254_36.z)

				local var_254_37 = var_254_31.localEulerAngles

				var_254_37.z = 0
				var_254_37.x = 0
				var_254_31.localEulerAngles = var_254_37
			end

			if arg_251_1.time_ >= var_254_32 + var_254_33 and arg_251_1.time_ < var_254_32 + var_254_33 + arg_254_0 then
				var_254_31.localPosition = Vector3.New(0, 100, 0)

				local var_254_38 = manager.ui.mainCamera.transform.position - var_254_31.position

				var_254_31.forward = Vector3.New(var_254_38.x, var_254_38.y, var_254_38.z)

				local var_254_39 = var_254_31.localEulerAngles

				var_254_39.z = 0
				var_254_39.x = 0
				var_254_31.localEulerAngles = var_254_39
			end

			local var_254_40 = arg_251_1.bgs_.ML0206.transform
			local var_254_41 = 0.034000001847744

			if var_254_41 < arg_251_1.time_ and arg_251_1.time_ <= var_254_41 + arg_254_0 then
				arg_251_1.var_.moveOldPosML0206 = var_254_40.localPosition
			end

			local var_254_42 = 0.001

			if var_254_41 <= arg_251_1.time_ and arg_251_1.time_ < var_254_41 + var_254_42 then
				local var_254_43 = (arg_251_1.time_ - var_254_41) / var_254_42
				local var_254_44 = Vector3.New(0, 1, 10)

				var_254_40.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPosML0206, var_254_44, var_254_43)
			end

			if arg_251_1.time_ >= var_254_41 + var_254_42 and arg_251_1.time_ < var_254_41 + var_254_42 + arg_254_0 then
				var_254_40.localPosition = Vector3.New(0, 1, 10)
			end

			local var_254_45 = arg_251_1.bgs_.ML0206.transform
			local var_254_46 = 0.0506666685144106

			if var_254_46 < arg_251_1.time_ and arg_251_1.time_ <= var_254_46 + arg_254_0 then
				arg_251_1.var_.moveOldPosML0206 = var_254_45.localPosition
			end

			local var_254_47 = 2.41666666666667

			if var_254_46 <= arg_251_1.time_ and arg_251_1.time_ < var_254_46 + var_254_47 then
				local var_254_48 = (arg_251_1.time_ - var_254_46) / var_254_47
				local var_254_49 = Vector3.New(0, 1, 8.14)

				var_254_45.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPosML0206, var_254_49, var_254_48)
			end

			if arg_251_1.time_ >= var_254_46 + var_254_47 and arg_251_1.time_ < var_254_46 + var_254_47 + arg_254_0 then
				var_254_45.localPosition = Vector3.New(0, 1, 8.14)
			end

			local var_254_50 = 0
			local var_254_51 = 1

			if var_254_50 < arg_251_1.time_ and arg_251_1.time_ <= var_254_50 + arg_254_0 then
				local var_254_52 = "play"
				local var_254_53 = "effect"

				arg_251_1:AudioAction(var_254_52, var_254_53, "se_story_131", "se_story_131__1095_skill1_2", "")
			end

			local var_254_54 = manager.ui.mainCamera.transform
			local var_254_55 = 0

			if var_254_55 < arg_251_1.time_ and arg_251_1.time_ <= var_254_55 + arg_254_0 then
				arg_251_1.var_.shakeOldPos = var_254_54.localPosition
			end

			local var_254_56 = 0.6

			if var_254_55 <= arg_251_1.time_ and arg_251_1.time_ < var_254_55 + var_254_56 then
				local var_254_57 = (arg_251_1.time_ - var_254_55) / 0.066
				local var_254_58, var_254_59 = math.modf(var_254_57)

				var_254_54.localPosition = Vector3.New(var_254_59 * 0.13, var_254_59 * 0.13, var_254_59 * 0.13) + arg_251_1.var_.shakeOldPos
			end

			if arg_251_1.time_ >= var_254_55 + var_254_56 and arg_251_1.time_ < var_254_55 + var_254_56 + arg_254_0 then
				var_254_54.localPosition = arg_251_1.var_.shakeOldPos
			end

			if arg_251_1.frameCnt_ <= 1 then
				arg_251_1.dialog_:SetActive(false)
			end

			local var_254_60 = 0.634000001847744
			local var_254_61 = 1.125

			if var_254_60 < arg_251_1.time_ and arg_251_1.time_ <= var_254_60 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				arg_251_1.dialog_:SetActive(true)

				arg_251_1.dialogCg_.alpha = 0

				local var_254_62 = LeanTween.value(arg_251_1.dialog_, 0, 1, 0.3)

				var_254_62:setOnUpdate(LuaHelper.FloatAction(function(arg_255_0)
					arg_251_1.dialogCg_.alpha = arg_255_0
				end))
				var_254_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_251_1.dialog_)
					var_254_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_251_1.duration_ = arg_251_1.duration_ + 0.3

				SetActive(arg_251_1.leftNameGo_, false)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_63 = arg_251_1:GetWordFromCfg(319881059)
				local var_254_64 = arg_251_1:FormatText(var_254_63.content)

				arg_251_1.text_.text = var_254_64

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_65 = 45
				local var_254_66 = utf8.len(var_254_64)
				local var_254_67 = var_254_65 <= 0 and var_254_61 or var_254_61 * (var_254_66 / var_254_65)

				if var_254_67 > 0 and var_254_61 < var_254_67 then
					arg_251_1.talkMaxDuration = var_254_67
					var_254_60 = var_254_60 + 0.3

					if var_254_67 + var_254_60 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_67 + var_254_60
					end
				end

				arg_251_1.text_.text = var_254_64
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_68 = var_254_60 + 0.3
			local var_254_69 = math.max(var_254_61, arg_251_1.talkMaxDuration)

			if var_254_68 <= arg_251_1.time_ and arg_251_1.time_ < var_254_68 + var_254_69 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_68) / var_254_69

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_68 + var_254_69 and arg_251_1.time_ < var_254_68 + var_254_69 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
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
				actorName = "ML0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.034000001847744,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.41666666666667,
				className = "StoryMoveNode",
				startTime = 0.0506666685144106,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play319881060 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 319881060
		arg_257_1.duration_ = 14.1

		local var_257_0 = {
			zh = 14.1,
			ja = 5
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
				arg_257_0:Play319881061(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 1.475

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[471].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_3 = arg_257_1:GetWordFromCfg(319881060)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 59
				local var_260_6 = utf8.len(var_260_4)
				local var_260_7 = var_260_5 <= 0 and var_260_1 or var_260_1 * (var_260_6 / var_260_5)

				if var_260_7 > 0 and var_260_1 < var_260_7 then
					arg_257_1.talkMaxDuration = var_260_7

					if var_260_7 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_7 + var_260_0
					end
				end

				arg_257_1.text_.text = var_260_4
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881060", "story_v_out_319881.awb") ~= 0 then
					local var_260_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881060", "story_v_out_319881.awb") / 1000

					if var_260_8 + var_260_0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_0
					end

					if var_260_3.prefab_name ~= "" and arg_257_1.actors_[var_260_3.prefab_name] ~= nil then
						local var_260_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_3.prefab_name].transform, "story_v_out_319881", "319881060", "story_v_out_319881.awb")

						arg_257_1:RecordAudio("319881060", var_260_9)
						arg_257_1:RecordAudio("319881060", var_260_9)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_319881", "319881060", "story_v_out_319881.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_319881", "319881060", "story_v_out_319881.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_10 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_10 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_10

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_10 and arg_257_1.time_ < var_260_0 + var_260_10 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play319881061 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 319881061
		arg_261_1.duration_ = 10.57

		local var_261_0 = {
			zh = 8.366,
			ja = 10.566
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
				arg_261_0:Play319881062(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 0.95

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[471].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:GetWordFromCfg(319881061)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881061", "story_v_out_319881.awb") ~= 0 then
					local var_264_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881061", "story_v_out_319881.awb") / 1000

					if var_264_8 + var_264_0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_8 + var_264_0
					end

					if var_264_3.prefab_name ~= "" and arg_261_1.actors_[var_264_3.prefab_name] ~= nil then
						local var_264_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_3.prefab_name].transform, "story_v_out_319881", "319881061", "story_v_out_319881.awb")

						arg_261_1:RecordAudio("319881061", var_264_9)
						arg_261_1:RecordAudio("319881061", var_264_9)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_319881", "319881061", "story_v_out_319881.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_319881", "319881061", "story_v_out_319881.awb")
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
	Play319881062 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 319881062
		arg_265_1.duration_ = 12.57

		local var_265_0 = {
			zh = 6.9,
			ja = 12.566
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
				arg_265_0:Play319881063(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 0.8

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[471].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_3 = arg_265_1:GetWordFromCfg(319881062)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881062", "story_v_out_319881.awb") ~= 0 then
					local var_268_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881062", "story_v_out_319881.awb") / 1000

					if var_268_8 + var_268_0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_8 + var_268_0
					end

					if var_268_3.prefab_name ~= "" and arg_265_1.actors_[var_268_3.prefab_name] ~= nil then
						local var_268_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_3.prefab_name].transform, "story_v_out_319881", "319881062", "story_v_out_319881.awb")

						arg_265_1:RecordAudio("319881062", var_268_9)
						arg_265_1:RecordAudio("319881062", var_268_9)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_319881", "319881062", "story_v_out_319881.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_319881", "319881062", "story_v_out_319881.awb")
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
	Play319881063 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 319881063
		arg_269_1.duration_ = 3.7

		local var_269_0 = {
			zh = 2.4,
			ja = 3.7
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
				arg_269_0:Play319881064(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 0.3

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[6].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_3 = arg_269_1:GetWordFromCfg(319881063)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 12
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881063", "story_v_out_319881.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881063", "story_v_out_319881.awb") / 1000

					if var_272_8 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_0
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_out_319881", "319881063", "story_v_out_319881.awb")

						arg_269_1:RecordAudio("319881063", var_272_9)
						arg_269_1:RecordAudio("319881063", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_319881", "319881063", "story_v_out_319881.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_319881", "319881063", "story_v_out_319881.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_10 and arg_269_1.time_ < var_272_0 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play319881064 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 319881064
		arg_273_1.duration_ = 3.3

		local var_273_0 = {
			zh = 2.066,
			ja = 3.3
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
				arg_273_0:Play319881065(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0
			local var_276_1 = 0.275

			if var_276_0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_2 = arg_273_1:FormatText(StoryNameCfg[471].name)

				arg_273_1.leftNameTxt_.text = var_276_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:GetWordFromCfg(319881064)
				local var_276_4 = arg_273_1:FormatText(var_276_3.content)

				arg_273_1.text_.text = var_276_4

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881064", "story_v_out_319881.awb") ~= 0 then
					local var_276_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881064", "story_v_out_319881.awb") / 1000

					if var_276_8 + var_276_0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_0
					end

					if var_276_3.prefab_name ~= "" and arg_273_1.actors_[var_276_3.prefab_name] ~= nil then
						local var_276_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_3.prefab_name].transform, "story_v_out_319881", "319881064", "story_v_out_319881.awb")

						arg_273_1:RecordAudio("319881064", var_276_9)
						arg_273_1:RecordAudio("319881064", var_276_9)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_319881", "319881064", "story_v_out_319881.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_319881", "319881064", "story_v_out_319881.awb")
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
	Play319881065 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 319881065
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play319881066(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.375

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

				local var_280_2 = arg_277_1:GetWordFromCfg(319881065)
				local var_280_3 = arg_277_1:FormatText(var_280_2.content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 15
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
	Play319881066 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 319881066
		arg_281_1.duration_ = 11.87

		local var_281_0 = {
			zh = 10.2,
			ja = 11.866
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
				arg_281_0:Play319881067(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.bgs_.ML0206.transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPosML0206 = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(0, 1, 8.14)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPosML0206, var_284_4, var_284_3)
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0, 1, 8.14)
			end

			local var_284_5 = arg_281_1.bgs_.ML0206.transform
			local var_284_6 = 0.0166666666666667

			if var_284_6 < arg_281_1.time_ and arg_281_1.time_ <= var_284_6 + arg_284_0 then
				arg_281_1.var_.moveOldPosML0206 = var_284_5.localPosition
			end

			local var_284_7 = 2.18333333333333

			if var_284_6 <= arg_281_1.time_ and arg_281_1.time_ < var_284_6 + var_284_7 then
				local var_284_8 = (arg_281_1.time_ - var_284_6) / var_284_7
				local var_284_9 = Vector3.New(0, 1, 10)

				var_284_5.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPosML0206, var_284_9, var_284_8)
			end

			if arg_281_1.time_ >= var_284_6 + var_284_7 and arg_281_1.time_ < var_284_6 + var_284_7 + arg_284_0 then
				var_284_5.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_281_1.frameCnt_ <= 1 then
				arg_281_1.dialog_:SetActive(false)
			end

			local var_284_10 = 2.2
			local var_284_11 = 0.925

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				arg_281_1.dialog_:SetActive(true)

				arg_281_1.dialogCg_.alpha = 0

				local var_284_12 = LeanTween.value(arg_281_1.dialog_, 0, 1, 0.3)

				var_284_12:setOnUpdate(LuaHelper.FloatAction(function(arg_285_0)
					arg_281_1.dialogCg_.alpha = arg_285_0
				end))
				var_284_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_281_1.dialog_)
					var_284_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_281_1.duration_ = arg_281_1.duration_ + 0.3

				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_13 = arg_281_1:FormatText(StoryNameCfg[6].name)

				arg_281_1.leftNameTxt_.text = var_284_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_14 = arg_281_1:GetWordFromCfg(319881066)
				local var_284_15 = arg_281_1:FormatText(var_284_14.content)

				arg_281_1.text_.text = var_284_15

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_16 = 37
				local var_284_17 = utf8.len(var_284_15)
				local var_284_18 = var_284_16 <= 0 and var_284_11 or var_284_11 * (var_284_17 / var_284_16)

				if var_284_18 > 0 and var_284_11 < var_284_18 then
					arg_281_1.talkMaxDuration = var_284_18
					var_284_10 = var_284_10 + 0.3

					if var_284_18 + var_284_10 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_18 + var_284_10
					end
				end

				arg_281_1.text_.text = var_284_15
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881066", "story_v_out_319881.awb") ~= 0 then
					local var_284_19 = manager.audio:GetVoiceLength("story_v_out_319881", "319881066", "story_v_out_319881.awb") / 1000

					if var_284_19 + var_284_10 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_19 + var_284_10
					end

					if var_284_14.prefab_name ~= "" and arg_281_1.actors_[var_284_14.prefab_name] ~= nil then
						local var_284_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_14.prefab_name].transform, "story_v_out_319881", "319881066", "story_v_out_319881.awb")

						arg_281_1:RecordAudio("319881066", var_284_20)
						arg_281_1:RecordAudio("319881066", var_284_20)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_319881", "319881066", "story_v_out_319881.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_319881", "319881066", "story_v_out_319881.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_21 = var_284_10 + 0.3
			local var_284_22 = math.max(var_284_11, arg_281_1.talkMaxDuration)

			if var_284_21 <= arg_281_1.time_ and arg_281_1.time_ < var_284_21 + var_284_22 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_21) / var_284_22

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_21 + var_284_22 and arg_281_1.time_ < var_284_21 + var_284_22 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0206",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.18333333333333,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play319881067 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 319881067
		arg_287_1.duration_ = 10.1

		local var_287_0 = {
			zh = 8.9,
			ja = 10.1
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
				arg_287_0:Play319881068(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0
			local var_290_1 = 1.125

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_2 = arg_287_1:FormatText(StoryNameCfg[6].name)

				arg_287_1.leftNameTxt_.text = var_290_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_3 = arg_287_1:GetWordFromCfg(319881067)
				local var_290_4 = arg_287_1:FormatText(var_290_3.content)

				arg_287_1.text_.text = var_290_4

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 45
				local var_290_6 = utf8.len(var_290_4)
				local var_290_7 = var_290_5 <= 0 and var_290_1 or var_290_1 * (var_290_6 / var_290_5)

				if var_290_7 > 0 and var_290_1 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_0
					end
				end

				arg_287_1.text_.text = var_290_4
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881067", "story_v_out_319881.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881067", "story_v_out_319881.awb") / 1000

					if var_290_8 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_0
					end

					if var_290_3.prefab_name ~= "" and arg_287_1.actors_[var_290_3.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_3.prefab_name].transform, "story_v_out_319881", "319881067", "story_v_out_319881.awb")

						arg_287_1:RecordAudio("319881067", var_290_9)
						arg_287_1:RecordAudio("319881067", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_319881", "319881067", "story_v_out_319881.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_319881", "319881067", "story_v_out_319881.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_1, arg_287_1.talkMaxDuration)

			if var_290_0 <= arg_287_1.time_ and arg_287_1.time_ < var_290_0 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_0) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_0 + var_290_10 and arg_287_1.time_ < var_290_0 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play319881068 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 319881068
		arg_291_1.duration_ = 13.03

		local var_291_0 = {
			zh = 10.8,
			ja = 13.033
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
				arg_291_0:Play319881069(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = 0
			local var_294_1 = 1.225

			if var_294_0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_0 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_2 = arg_291_1:FormatText(StoryNameCfg[6].name)

				arg_291_1.leftNameTxt_.text = var_294_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_3 = arg_291_1:GetWordFromCfg(319881068)
				local var_294_4 = arg_291_1:FormatText(var_294_3.content)

				arg_291_1.text_.text = var_294_4

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 49
				local var_294_6 = utf8.len(var_294_4)
				local var_294_7 = var_294_5 <= 0 and var_294_1 or var_294_1 * (var_294_6 / var_294_5)

				if var_294_7 > 0 and var_294_1 < var_294_7 then
					arg_291_1.talkMaxDuration = var_294_7

					if var_294_7 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_7 + var_294_0
					end
				end

				arg_291_1.text_.text = var_294_4
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881068", "story_v_out_319881.awb") ~= 0 then
					local var_294_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881068", "story_v_out_319881.awb") / 1000

					if var_294_8 + var_294_0 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_8 + var_294_0
					end

					if var_294_3.prefab_name ~= "" and arg_291_1.actors_[var_294_3.prefab_name] ~= nil then
						local var_294_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_3.prefab_name].transform, "story_v_out_319881", "319881068", "story_v_out_319881.awb")

						arg_291_1:RecordAudio("319881068", var_294_9)
						arg_291_1:RecordAudio("319881068", var_294_9)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_319881", "319881068", "story_v_out_319881.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_319881", "319881068", "story_v_out_319881.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_1, arg_291_1.talkMaxDuration)

			if var_294_0 <= arg_291_1.time_ and arg_291_1.time_ < var_294_0 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_0) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_0 + var_294_10 and arg_291_1.time_ < var_294_0 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play319881069 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 319881069
		arg_295_1.duration_ = 12.43

		local var_295_0 = {
			zh = 9.033,
			ja = 12.433
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
				arg_295_0:Play319881070(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.875

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_2 = arg_295_1:FormatText(StoryNameCfg[6].name)

				arg_295_1.leftNameTxt_.text = var_298_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_3 = arg_295_1:GetWordFromCfg(319881069)
				local var_298_4 = arg_295_1:FormatText(var_298_3.content)

				arg_295_1.text_.text = var_298_4

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_5 = 35
				local var_298_6 = utf8.len(var_298_4)
				local var_298_7 = var_298_5 <= 0 and var_298_1 or var_298_1 * (var_298_6 / var_298_5)

				if var_298_7 > 0 and var_298_1 < var_298_7 then
					arg_295_1.talkMaxDuration = var_298_7

					if var_298_7 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_7 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_4
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881069", "story_v_out_319881.awb") ~= 0 then
					local var_298_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881069", "story_v_out_319881.awb") / 1000

					if var_298_8 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_8 + var_298_0
					end

					if var_298_3.prefab_name ~= "" and arg_295_1.actors_[var_298_3.prefab_name] ~= nil then
						local var_298_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_3.prefab_name].transform, "story_v_out_319881", "319881069", "story_v_out_319881.awb")

						arg_295_1:RecordAudio("319881069", var_298_9)
						arg_295_1:RecordAudio("319881069", var_298_9)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_319881", "319881069", "story_v_out_319881.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_319881", "319881069", "story_v_out_319881.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_10 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_10 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_10

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_10 and arg_295_1.time_ < var_298_0 + var_298_10 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play319881070 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 319881070
		arg_299_1.duration_ = 3.73

		local var_299_0 = {
			zh = 1.733,
			ja = 3.733
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play319881071(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 0.25

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_2 = arg_299_1:FormatText(StoryNameCfg[471].name)

				arg_299_1.leftNameTxt_.text = var_302_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_3 = arg_299_1:GetWordFromCfg(319881070)
				local var_302_4 = arg_299_1:FormatText(var_302_3.content)

				arg_299_1.text_.text = var_302_4

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 10
				local var_302_6 = utf8.len(var_302_4)
				local var_302_7 = var_302_5 <= 0 and var_302_1 or var_302_1 * (var_302_6 / var_302_5)

				if var_302_7 > 0 and var_302_1 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_4
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881070", "story_v_out_319881.awb") ~= 0 then
					local var_302_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881070", "story_v_out_319881.awb") / 1000

					if var_302_8 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_0
					end

					if var_302_3.prefab_name ~= "" and arg_299_1.actors_[var_302_3.prefab_name] ~= nil then
						local var_302_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_3.prefab_name].transform, "story_v_out_319881", "319881070", "story_v_out_319881.awb")

						arg_299_1:RecordAudio("319881070", var_302_9)
						arg_299_1:RecordAudio("319881070", var_302_9)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_319881", "319881070", "story_v_out_319881.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_319881", "319881070", "story_v_out_319881.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_10 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_10 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_10

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_10 and arg_299_1.time_ < var_302_0 + var_302_10 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play319881071 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 319881071
		arg_303_1.duration_ = 1.07

		local var_303_0 = {
			zh = 1.066,
			ja = 1
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
				arg_303_0:Play319881072(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 0.05

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_2 = arg_303_1:FormatText(StoryNameCfg[6].name)

				arg_303_1.leftNameTxt_.text = var_306_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:GetWordFromCfg(319881071)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 2
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

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881071", "story_v_out_319881.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881071", "story_v_out_319881.awb") / 1000

					if var_306_8 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_0
					end

					if var_306_3.prefab_name ~= "" and arg_303_1.actors_[var_306_3.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_3.prefab_name].transform, "story_v_out_319881", "319881071", "story_v_out_319881.awb")

						arg_303_1:RecordAudio("319881071", var_306_9)
						arg_303_1:RecordAudio("319881071", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_319881", "319881071", "story_v_out_319881.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_319881", "319881071", "story_v_out_319881.awb")
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
	Play319881072 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 319881072
		arg_307_1.duration_ = 12.83

		local var_307_0 = {
			zh = 6.433,
			ja = 12.833
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
				arg_307_0:Play319881073(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0
			local var_310_1 = 0.875

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_2 = arg_307_1:FormatText(StoryNameCfg[471].name)

				arg_307_1.leftNameTxt_.text = var_310_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_3 = arg_307_1:GetWordFromCfg(319881072)
				local var_310_4 = arg_307_1:FormatText(var_310_3.content)

				arg_307_1.text_.text = var_310_4

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881072", "story_v_out_319881.awb") ~= 0 then
					local var_310_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881072", "story_v_out_319881.awb") / 1000

					if var_310_8 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_0
					end

					if var_310_3.prefab_name ~= "" and arg_307_1.actors_[var_310_3.prefab_name] ~= nil then
						local var_310_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_3.prefab_name].transform, "story_v_out_319881", "319881072", "story_v_out_319881.awb")

						arg_307_1:RecordAudio("319881072", var_310_9)
						arg_307_1:RecordAudio("319881072", var_310_9)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_319881", "319881072", "story_v_out_319881.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_319881", "319881072", "story_v_out_319881.awb")
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
	Play319881073 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 319881073
		arg_311_1.duration_ = 9.93

		local var_311_0 = {
			zh = 5.6,
			ja = 9.933
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
				arg_311_0:Play319881074(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 0.75

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_2 = arg_311_1:FormatText(StoryNameCfg[471].name)

				arg_311_1.leftNameTxt_.text = var_314_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_3 = arg_311_1:GetWordFromCfg(319881073)
				local var_314_4 = arg_311_1:FormatText(var_314_3.content)

				arg_311_1.text_.text = var_314_4

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 30
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

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881073", "story_v_out_319881.awb") ~= 0 then
					local var_314_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881073", "story_v_out_319881.awb") / 1000

					if var_314_8 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_8 + var_314_0
					end

					if var_314_3.prefab_name ~= "" and arg_311_1.actors_[var_314_3.prefab_name] ~= nil then
						local var_314_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_3.prefab_name].transform, "story_v_out_319881", "319881073", "story_v_out_319881.awb")

						arg_311_1:RecordAudio("319881073", var_314_9)
						arg_311_1:RecordAudio("319881073", var_314_9)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_319881", "319881073", "story_v_out_319881.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_319881", "319881073", "story_v_out_319881.awb")
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
	Play319881074 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 319881074
		arg_315_1.duration_ = 4.37

		local var_315_0 = {
			zh = 2.7,
			ja = 4.366
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
				arg_315_0:Play319881075(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 0.25

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

				local var_318_3 = arg_315_1:GetWordFromCfg(319881074)
				local var_318_4 = arg_315_1:FormatText(var_318_3.content)

				arg_315_1.text_.text = var_318_4

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881074", "story_v_out_319881.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_out_319881", "319881074", "story_v_out_319881.awb") / 1000

					if var_318_8 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_0
					end

					if var_318_3.prefab_name ~= "" and arg_315_1.actors_[var_318_3.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_3.prefab_name].transform, "story_v_out_319881", "319881074", "story_v_out_319881.awb")

						arg_315_1:RecordAudio("319881074", var_318_9)
						arg_315_1:RecordAudio("319881074", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_319881", "319881074", "story_v_out_319881.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_319881", "319881074", "story_v_out_319881.awb")
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
	Play319881075 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 319881075
		arg_319_1.duration_ = 7.5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play319881076(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 1

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				local var_322_1 = manager.ui.mainCamera.transform.localPosition
				local var_322_2 = Vector3.New(0, 0, 10) + Vector3.New(var_322_1.x, var_322_1.y, 0)
				local var_322_3 = arg_319_1.bgs_.ST70a

				var_322_3.transform.localPosition = var_322_2
				var_322_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_322_4 = var_322_3:GetComponent("SpriteRenderer")

				if var_322_4 and var_322_4.sprite then
					local var_322_5 = (var_322_3.transform.localPosition - var_322_1).z
					local var_322_6 = manager.ui.mainCameraCom_
					local var_322_7 = 2 * var_322_5 * Mathf.Tan(var_322_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_322_8 = var_322_7 * var_322_6.aspect
					local var_322_9 = var_322_4.sprite.bounds.size.x
					local var_322_10 = var_322_4.sprite.bounds.size.y
					local var_322_11 = var_322_8 / var_322_9
					local var_322_12 = var_322_7 / var_322_10
					local var_322_13 = var_322_12 < var_322_11 and var_322_11 or var_322_12

					var_322_3.transform.localScale = Vector3.New(var_322_13, var_322_13, 0)
				end

				for iter_322_0, iter_322_1 in pairs(arg_319_1.bgs_) do
					if iter_322_0 ~= "ST70a" then
						iter_322_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_322_14 = 0

			if var_322_14 < arg_319_1.time_ and arg_319_1.time_ <= var_322_14 + arg_322_0 then
				arg_319_1.allBtn_.enabled = false
			end

			local var_322_15 = 0.3

			if arg_319_1.time_ >= var_322_14 + var_322_15 and arg_319_1.time_ < var_322_14 + var_322_15 + arg_322_0 then
				arg_319_1.allBtn_.enabled = true
			end

			local var_322_16 = 0

			if var_322_16 < arg_319_1.time_ and arg_319_1.time_ <= var_322_16 + arg_322_0 then
				arg_319_1.mask_.enabled = true
				arg_319_1.mask_.raycastTarget = true

				arg_319_1:SetGaussion(false)
			end

			local var_322_17 = 1

			if var_322_16 <= arg_319_1.time_ and arg_319_1.time_ < var_322_16 + var_322_17 then
				local var_322_18 = (arg_319_1.time_ - var_322_16) / var_322_17
				local var_322_19 = Color.New(0, 0, 0)

				var_322_19.a = Mathf.Lerp(0, 1, var_322_18)
				arg_319_1.mask_.color = var_322_19
			end

			if arg_319_1.time_ >= var_322_16 + var_322_17 and arg_319_1.time_ < var_322_16 + var_322_17 + arg_322_0 then
				local var_322_20 = Color.New(0, 0, 0)

				var_322_20.a = 1
				arg_319_1.mask_.color = var_322_20
			end

			local var_322_21 = 1

			if var_322_21 < arg_319_1.time_ and arg_319_1.time_ <= var_322_21 + arg_322_0 then
				arg_319_1.mask_.enabled = true
				arg_319_1.mask_.raycastTarget = true

				arg_319_1:SetGaussion(false)
			end

			local var_322_22 = 1.5

			if var_322_21 <= arg_319_1.time_ and arg_319_1.time_ < var_322_21 + var_322_22 then
				local var_322_23 = (arg_319_1.time_ - var_322_21) / var_322_22
				local var_322_24 = Color.New(0, 0, 0)

				var_322_24.a = Mathf.Lerp(1, 0, var_322_23)
				arg_319_1.mask_.color = var_322_24
			end

			if arg_319_1.time_ >= var_322_21 + var_322_22 and arg_319_1.time_ < var_322_21 + var_322_22 + arg_322_0 then
				local var_322_25 = Color.New(0, 0, 0)
				local var_322_26 = 0

				arg_319_1.mask_.enabled = false
				var_322_25.a = var_322_26
				arg_319_1.mask_.color = var_322_25
			end

			if arg_319_1.frameCnt_ <= 1 then
				arg_319_1.dialog_:SetActive(false)
			end

			local var_322_27 = 2.5
			local var_322_28 = 0.725

			if var_322_27 < arg_319_1.time_ and arg_319_1.time_ <= var_322_27 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0

				arg_319_1.dialog_:SetActive(true)

				arg_319_1.dialogCg_.alpha = 0

				local var_322_29 = LeanTween.value(arg_319_1.dialog_, 0, 1, 0.3)

				var_322_29:setOnUpdate(LuaHelper.FloatAction(function(arg_323_0)
					arg_319_1.dialogCg_.alpha = arg_323_0
				end))
				var_322_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_319_1.dialog_)
					var_322_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_319_1.duration_ = arg_319_1.duration_ + 0.3

				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_30 = arg_319_1:GetWordFromCfg(319881075)
				local var_322_31 = arg_319_1:FormatText(var_322_30.content)

				arg_319_1.text_.text = var_322_31

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_32 = 29
				local var_322_33 = utf8.len(var_322_31)
				local var_322_34 = var_322_32 <= 0 and var_322_28 or var_322_28 * (var_322_33 / var_322_32)

				if var_322_34 > 0 and var_322_28 < var_322_34 then
					arg_319_1.talkMaxDuration = var_322_34
					var_322_27 = var_322_27 + 0.3

					if var_322_34 + var_322_27 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_34 + var_322_27
					end
				end

				arg_319_1.text_.text = var_322_31
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_35 = var_322_27 + 0.3
			local var_322_36 = math.max(var_322_28, arg_319_1.talkMaxDuration)

			if var_322_35 <= arg_319_1.time_ and arg_319_1.time_ < var_322_35 + var_322_36 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_35) / var_322_36

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_35 + var_322_36 and arg_319_1.time_ < var_322_35 + var_322_36 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play319881076 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 319881076
		arg_325_1.duration_ = 5.47

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play319881077(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 1

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				local var_328_2 = "play"
				local var_328_3 = "effect"

				arg_325_1:AudioAction(var_328_2, var_328_3, "se_story_123_01", "se_story_123_01_hit", "")
			end

			local var_328_4 = manager.ui.mainCamera.transform
			local var_328_5 = 0

			if var_328_5 < arg_325_1.time_ and arg_325_1.time_ <= var_328_5 + arg_328_0 then
				local var_328_6 = arg_325_1.var_.effect9991111
				local var_328_7
				local var_328_8 = var_328_4

				if not var_328_6 then
					var_328_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_328_8)
					var_328_6.name = "1111"
					arg_325_1.var_.effect9991111 = var_328_6
				else
					var_328_6.transform:SetParent(var_328_8)
				end

				var_328_6.transform.localPosition = Vector3.New(0, 0, 0.44)
				var_328_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_325_1.frameCnt_ <= 1 then
				arg_325_1.dialog_:SetActive(false)
			end

			local var_328_9 = 0.466666666666667
			local var_328_10 = 1.35

			if var_328_9 < arg_325_1.time_ and arg_325_1.time_ <= var_328_9 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0

				arg_325_1.dialog_:SetActive(true)

				arg_325_1.dialogCg_.alpha = 0

				local var_328_11 = LeanTween.value(arg_325_1.dialog_, 0, 1, 0.3)

				var_328_11:setOnUpdate(LuaHelper.FloatAction(function(arg_329_0)
					arg_325_1.dialogCg_.alpha = arg_329_0
				end))
				var_328_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_325_1.dialog_)
					var_328_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_325_1.duration_ = arg_325_1.duration_ + 0.3

				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_12 = arg_325_1:GetWordFromCfg(319881076)
				local var_328_13 = arg_325_1:FormatText(var_328_12.content)

				arg_325_1.text_.text = var_328_13

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_14 = 54
				local var_328_15 = utf8.len(var_328_13)
				local var_328_16 = var_328_14 <= 0 and var_328_10 or var_328_10 * (var_328_15 / var_328_14)

				if var_328_16 > 0 and var_328_10 < var_328_16 then
					arg_325_1.talkMaxDuration = var_328_16
					var_328_9 = var_328_9 + 0.3

					if var_328_16 + var_328_9 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_16 + var_328_9
					end
				end

				arg_325_1.text_.text = var_328_13
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_17 = var_328_9 + 0.3
			local var_328_18 = math.max(var_328_10, arg_325_1.talkMaxDuration)

			if var_328_17 <= arg_325_1.time_ and arg_325_1.time_ < var_328_17 + var_328_18 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_17) / var_328_18

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_17 + var_328_18 and arg_325_1.time_ < var_328_17 + var_328_18 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play319881077 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 319881077
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play319881078(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = manager.ui.mainCamera.transform
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				local var_334_2 = arg_331_1.var_.effect9991111

				if var_334_2 then
					Object.Destroy(var_334_2)

					arg_331_1.var_.effect9991111 = nil
				end
			end

			local var_334_3 = 0
			local var_334_4 = 1.25

			if var_334_3 < arg_331_1.time_ and arg_331_1.time_ <= var_334_3 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_5 = arg_331_1:GetWordFromCfg(319881077)
				local var_334_6 = arg_331_1:FormatText(var_334_5.content)

				arg_331_1.text_.text = var_334_6

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_7 = 50
				local var_334_8 = utf8.len(var_334_6)
				local var_334_9 = var_334_7 <= 0 and var_334_4 or var_334_4 * (var_334_8 / var_334_7)

				if var_334_9 > 0 and var_334_4 < var_334_9 then
					arg_331_1.talkMaxDuration = var_334_9

					if var_334_9 + var_334_3 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_9 + var_334_3
					end
				end

				arg_331_1.text_.text = var_334_6
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_10 = math.max(var_334_4, arg_331_1.talkMaxDuration)

			if var_334_3 <= arg_331_1.time_ and arg_331_1.time_ < var_334_3 + var_334_10 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_3) / var_334_10

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_3 + var_334_10 and arg_331_1.time_ < var_334_3 + var_334_10 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play319881078 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 319881078
		arg_335_1.duration_ = 2.6

		local var_335_0 = {
			zh = 1.999999999999,
			ja = 2.6
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
				arg_335_0:Play319881079(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1084ui_story"].transform
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 then
				arg_335_1.var_.moveOldPos1084ui_story = var_338_0.localPosition
			end

			local var_338_2 = 0.001

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2
				local var_338_4 = Vector3.New(0, -0.97, -6)

				var_338_0.localPosition = Vector3.Lerp(arg_335_1.var_.moveOldPos1084ui_story, var_338_4, var_338_3)

				local var_338_5 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_5.x, var_338_5.y, var_338_5.z)

				local var_338_6 = var_338_0.localEulerAngles

				var_338_6.z = 0
				var_338_6.x = 0
				var_338_0.localEulerAngles = var_338_6
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 then
				var_338_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_338_7 = manager.ui.mainCamera.transform.position - var_338_0.position

				var_338_0.forward = Vector3.New(var_338_7.x, var_338_7.y, var_338_7.z)

				local var_338_8 = var_338_0.localEulerAngles

				var_338_8.z = 0
				var_338_8.x = 0
				var_338_0.localEulerAngles = var_338_8
			end

			local var_338_9 = arg_335_1.actors_["1084ui_story"]
			local var_338_10 = 0

			if var_338_10 < arg_335_1.time_ and arg_335_1.time_ <= var_338_10 + arg_338_0 and not isNil(var_338_9) and arg_335_1.var_.characterEffect1084ui_story == nil then
				arg_335_1.var_.characterEffect1084ui_story = var_338_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_11 = 0.200000002980232

			if var_338_10 <= arg_335_1.time_ and arg_335_1.time_ < var_338_10 + var_338_11 and not isNil(var_338_9) then
				local var_338_12 = (arg_335_1.time_ - var_338_10) / var_338_11

				if arg_335_1.var_.characterEffect1084ui_story and not isNil(var_338_9) then
					arg_335_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= var_338_10 + var_338_11 and arg_335_1.time_ < var_338_10 + var_338_11 + arg_338_0 and not isNil(var_338_9) and arg_335_1.var_.characterEffect1084ui_story then
				arg_335_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_338_13 = 0

			if var_338_13 < arg_335_1.time_ and arg_335_1.time_ <= var_338_13 + arg_338_0 then
				arg_335_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_338_14 = 0

			if var_338_14 < arg_335_1.time_ and arg_335_1.time_ <= var_338_14 + arg_338_0 then
				arg_335_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_338_15 = 0
			local var_338_16 = 0.075

			if var_338_15 < arg_335_1.time_ and arg_335_1.time_ <= var_338_15 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_17 = arg_335_1:FormatText(StoryNameCfg[6].name)

				arg_335_1.leftNameTxt_.text = var_338_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_18 = arg_335_1:GetWordFromCfg(319881078)
				local var_338_19 = arg_335_1:FormatText(var_338_18.content)

				arg_335_1.text_.text = var_338_19

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_20 = 3
				local var_338_21 = utf8.len(var_338_19)
				local var_338_22 = var_338_20 <= 0 and var_338_16 or var_338_16 * (var_338_21 / var_338_20)

				if var_338_22 > 0 and var_338_16 < var_338_22 then
					arg_335_1.talkMaxDuration = var_338_22

					if var_338_22 + var_338_15 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_22 + var_338_15
					end
				end

				arg_335_1.text_.text = var_338_19
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881078", "story_v_out_319881.awb") ~= 0 then
					local var_338_23 = manager.audio:GetVoiceLength("story_v_out_319881", "319881078", "story_v_out_319881.awb") / 1000

					if var_338_23 + var_338_15 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_23 + var_338_15
					end

					if var_338_18.prefab_name ~= "" and arg_335_1.actors_[var_338_18.prefab_name] ~= nil then
						local var_338_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_18.prefab_name].transform, "story_v_out_319881", "319881078", "story_v_out_319881.awb")

						arg_335_1:RecordAudio("319881078", var_338_24)
						arg_335_1:RecordAudio("319881078", var_338_24)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_319881", "319881078", "story_v_out_319881.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_319881", "319881078", "story_v_out_319881.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_25 = math.max(var_338_16, arg_335_1.talkMaxDuration)

			if var_338_15 <= arg_335_1.time_ and arg_335_1.time_ < var_338_15 + var_338_25 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_15) / var_338_25

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_15 + var_338_25 and arg_335_1.time_ < var_338_15 + var_338_25 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {
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

		arg_335_1:InitPlayNodeList()
	end,
	Play319881079 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 319881079
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play319881080(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1084ui_story"].transform
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 then
				arg_339_1.var_.moveOldPos1084ui_story = var_342_0.localPosition
			end

			local var_342_2 = 0.001

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2
				local var_342_4 = Vector3.New(0, 100, 0)

				var_342_0.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos1084ui_story, var_342_4, var_342_3)

				local var_342_5 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_5.x, var_342_5.y, var_342_5.z)

				local var_342_6 = var_342_0.localEulerAngles

				var_342_6.z = 0
				var_342_6.x = 0
				var_342_0.localEulerAngles = var_342_6
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 then
				var_342_0.localPosition = Vector3.New(0, 100, 0)

				local var_342_7 = manager.ui.mainCamera.transform.position - var_342_0.position

				var_342_0.forward = Vector3.New(var_342_7.x, var_342_7.y, var_342_7.z)

				local var_342_8 = var_342_0.localEulerAngles

				var_342_8.z = 0
				var_342_8.x = 0
				var_342_0.localEulerAngles = var_342_8
			end

			local var_342_9 = arg_339_1.actors_["1084ui_story"]
			local var_342_10 = 0

			if var_342_10 < arg_339_1.time_ and arg_339_1.time_ <= var_342_10 + arg_342_0 and not isNil(var_342_9) and arg_339_1.var_.characterEffect1084ui_story == nil then
				arg_339_1.var_.characterEffect1084ui_story = var_342_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_11 = 0.200000002980232

			if var_342_10 <= arg_339_1.time_ and arg_339_1.time_ < var_342_10 + var_342_11 and not isNil(var_342_9) then
				local var_342_12 = (arg_339_1.time_ - var_342_10) / var_342_11

				if arg_339_1.var_.characterEffect1084ui_story and not isNil(var_342_9) then
					local var_342_13 = Mathf.Lerp(0, 0.5, var_342_12)

					arg_339_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1084ui_story.fillRatio = var_342_13
				end
			end

			if arg_339_1.time_ >= var_342_10 + var_342_11 and arg_339_1.time_ < var_342_10 + var_342_11 + arg_342_0 and not isNil(var_342_9) and arg_339_1.var_.characterEffect1084ui_story then
				local var_342_14 = 0.5

				arg_339_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1084ui_story.fillRatio = var_342_14
			end

			local var_342_15 = 0
			local var_342_16 = 1.375

			if var_342_15 < arg_339_1.time_ and arg_339_1.time_ <= var_342_15 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_17 = arg_339_1:GetWordFromCfg(319881079)
				local var_342_18 = arg_339_1:FormatText(var_342_17.content)

				arg_339_1.text_.text = var_342_18

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_19 = 55
				local var_342_20 = utf8.len(var_342_18)
				local var_342_21 = var_342_19 <= 0 and var_342_16 or var_342_16 * (var_342_20 / var_342_19)

				if var_342_21 > 0 and var_342_16 < var_342_21 then
					arg_339_1.talkMaxDuration = var_342_21

					if var_342_21 + var_342_15 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_21 + var_342_15
					end
				end

				arg_339_1.text_.text = var_342_18
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_22 = math.max(var_342_16, arg_339_1.talkMaxDuration)

			if var_342_15 <= arg_339_1.time_ and arg_339_1.time_ < var_342_15 + var_342_22 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_15) / var_342_22

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_15 + var_342_22 and arg_339_1.time_ < var_342_15 + var_342_22 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
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

		arg_339_1:InitPlayNodeList()
	end,
	Play319881080 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 319881080
		arg_343_1.duration_ = 6.1

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play319881081(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 1

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				local var_346_2 = "play"
				local var_346_3 = "effect"

				arg_343_1:AudioAction(var_346_2, var_346_3, "se_story_122_02", "se_story_122_02_hit", "")
			end

			local var_346_4 = manager.ui.mainCamera.transform
			local var_346_5 = 0.5

			if var_346_5 < arg_343_1.time_ and arg_343_1.time_ <= var_346_5 + arg_346_0 then
				arg_343_1.var_.shakeOldPos = var_346_4.localPosition
			end

			local var_346_6 = 0.6

			if var_346_5 <= arg_343_1.time_ and arg_343_1.time_ < var_346_5 + var_346_6 then
				local var_346_7 = (arg_343_1.time_ - var_346_5) / 0.066
				local var_346_8, var_346_9 = math.modf(var_346_7)

				var_346_4.localPosition = Vector3.New(var_346_9 * 0.13, var_346_9 * 0.13, var_346_9 * 0.13) + arg_343_1.var_.shakeOldPos
			end

			if arg_343_1.time_ >= var_346_5 + var_346_6 and arg_343_1.time_ < var_346_5 + var_346_6 + arg_346_0 then
				var_346_4.localPosition = arg_343_1.var_.shakeOldPos
			end

			local var_346_10 = 0

			if var_346_10 < arg_343_1.time_ and arg_343_1.time_ <= var_346_10 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = false

				arg_343_1:SetGaussion(false)
			end

			local var_346_11 = 0.466666666666667

			if var_346_10 <= arg_343_1.time_ and arg_343_1.time_ < var_346_10 + var_346_11 then
				local var_346_12 = (arg_343_1.time_ - var_346_10) / var_346_11
				local var_346_13 = Color.New(1, 1, 1)

				var_346_13.a = Mathf.Lerp(1, 0, var_346_12)
				arg_343_1.mask_.color = var_346_13
			end

			if arg_343_1.time_ >= var_346_10 + var_346_11 and arg_343_1.time_ < var_346_10 + var_346_11 + arg_346_0 then
				local var_346_14 = Color.New(1, 1, 1)
				local var_346_15 = 0

				arg_343_1.mask_.enabled = false
				var_346_14.a = var_346_15
				arg_343_1.mask_.color = var_346_14
			end

			if arg_343_1.frameCnt_ <= 1 then
				arg_343_1.dialog_:SetActive(false)
			end

			local var_346_16 = 1.1
			local var_346_17 = 1.175

			if var_346_16 < arg_343_1.time_ and arg_343_1.time_ <= var_346_16 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0

				arg_343_1.dialog_:SetActive(true)

				arg_343_1.dialogCg_.alpha = 0

				local var_346_18 = LeanTween.value(arg_343_1.dialog_, 0, 1, 0.3)

				var_346_18:setOnUpdate(LuaHelper.FloatAction(function(arg_347_0)
					arg_343_1.dialogCg_.alpha = arg_347_0
				end))
				var_346_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_343_1.dialog_)
					var_346_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_343_1.duration_ = arg_343_1.duration_ + 0.3

				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_19 = arg_343_1:GetWordFromCfg(319881080)
				local var_346_20 = arg_343_1:FormatText(var_346_19.content)

				arg_343_1.text_.text = var_346_20

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_21 = 47
				local var_346_22 = utf8.len(var_346_20)
				local var_346_23 = var_346_21 <= 0 and var_346_17 or var_346_17 * (var_346_22 / var_346_21)

				if var_346_23 > 0 and var_346_17 < var_346_23 then
					arg_343_1.talkMaxDuration = var_346_23
					var_346_16 = var_346_16 + 0.3

					if var_346_23 + var_346_16 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_23 + var_346_16
					end
				end

				arg_343_1.text_.text = var_346_20
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_24 = var_346_16 + 0.3
			local var_346_25 = math.max(var_346_17, arg_343_1.talkMaxDuration)

			if var_346_24 <= arg_343_1.time_ and arg_343_1.time_ < var_346_24 + var_346_25 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_24) / var_346_25

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_24 + var_346_25 and arg_343_1.time_ < var_346_24 + var_346_25 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play319881081 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 319881081
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play319881082(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = 0

			if var_352_0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				local var_352_1 = arg_349_1.fswbg_.transform:Find("textbox/adapt/content") or arg_349_1.fswbg_.transform:Find("textbox/content")
				local var_352_2 = arg_349_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_352_3 = var_352_1:GetComponent("Text")
				local var_352_4 = var_352_1:GetComponent("RectTransform")

				var_352_3.alignment = UnityEngine.TextAnchor.LowerCenter
				var_352_4.offsetMin = Vector2.New(0, 0)
				var_352_4.offsetMax = Vector2.New(0, 0)
			end

			local var_352_5 = 0

			if var_352_5 < arg_349_1.time_ and arg_349_1.time_ <= var_352_5 + arg_352_0 then
				arg_349_1.fswbg_:SetActive(true)
				arg_349_1.dialog_:SetActive(false)

				arg_349_1.fswtw_.percent = 0

				local var_352_6 = arg_349_1:GetWordFromCfg(319881081)
				local var_352_7 = arg_349_1:FormatText(var_352_6.content)

				arg_349_1.fswt_.text = var_352_7

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.fswt_)

				arg_349_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_349_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_349_1.fswtw_:SetDirty()

				arg_349_1.typewritterCharCountI18N = 0

				SetActive(arg_349_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_349_1:ShowNextGo(false)
			end

			local var_352_8 = 0.8

			if var_352_8 < arg_349_1.time_ and arg_349_1.time_ <= var_352_8 + arg_352_0 then
				arg_349_1.var_.oldValueTypewriter = arg_349_1.fswtw_.percent

				SetActive(arg_349_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_349_1:ShowNextGo(false)
			end

			local var_352_9 = 7
			local var_352_10 = 0.466666666666667
			local var_352_11 = arg_349_1:GetWordFromCfg(319881081)
			local var_352_12 = arg_349_1:FormatText(var_352_11.content)
			local var_352_13, var_352_14 = arg_349_1:GetPercentByPara(var_352_12, 1)

			if var_352_8 < arg_349_1.time_ and arg_349_1.time_ <= var_352_8 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0

				local var_352_15 = var_352_9 <= 0 and var_352_10 or var_352_10 * ((var_352_14 - arg_349_1.typewritterCharCountI18N) / var_352_9)

				if var_352_15 > 0 and var_352_10 < var_352_15 then
					arg_349_1.talkMaxDuration = var_352_15

					if var_352_15 + var_352_8 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_15 + var_352_8
					end
				end
			end

			local var_352_16 = 0.466666666666667
			local var_352_17 = math.max(var_352_16, arg_349_1.talkMaxDuration)

			if var_352_8 <= arg_349_1.time_ and arg_349_1.time_ < var_352_8 + var_352_17 then
				local var_352_18 = (arg_349_1.time_ - var_352_8) / var_352_17

				arg_349_1.fswtw_.percent = Mathf.Lerp(arg_349_1.var_.oldValueTypewriter, var_352_13, var_352_18)
				arg_349_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_349_1.fswtw_:SetDirty()
			end

			if arg_349_1.time_ >= var_352_8 + var_352_17 and arg_349_1.time_ < var_352_8 + var_352_17 + arg_352_0 then
				arg_349_1.fswtw_.percent = var_352_13

				arg_349_1.fswtw_:SetDirty()
				arg_349_1:ShowNextGo(true)

				arg_349_1.typewritterCharCountI18N = var_352_14
			end

			local var_352_19 = 0

			if var_352_19 < arg_349_1.time_ and arg_349_1.time_ <= var_352_19 + arg_352_0 then
				local var_352_20 = manager.ui.mainCamera.transform.localPosition
				local var_352_21 = Vector3.New(0, 0, 10) + Vector3.New(var_352_20.x, var_352_20.y, 0)
				local var_352_22 = arg_349_1.bgs_.STblack

				var_352_22.transform.localPosition = var_352_21
				var_352_22.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_352_23 = var_352_22:GetComponent("SpriteRenderer")

				if var_352_23 and var_352_23.sprite then
					local var_352_24 = (var_352_22.transform.localPosition - var_352_20).z
					local var_352_25 = manager.ui.mainCameraCom_
					local var_352_26 = 2 * var_352_24 * Mathf.Tan(var_352_25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_352_27 = var_352_26 * var_352_25.aspect
					local var_352_28 = var_352_23.sprite.bounds.size.x
					local var_352_29 = var_352_23.sprite.bounds.size.y
					local var_352_30 = var_352_27 / var_352_28
					local var_352_31 = var_352_26 / var_352_29
					local var_352_32 = var_352_31 < var_352_30 and var_352_30 or var_352_31

					var_352_22.transform.localScale = Vector3.New(var_352_32, var_352_32, 0)
				end

				for iter_352_0, iter_352_1 in pairs(arg_349_1.bgs_) do
					if iter_352_0 ~= "STblack" then
						iter_352_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_352_33 = 0.8
			local var_352_34 = 1
			local var_352_35 = manager.audio:GetVoiceLength("story_v_out_319881", "319881081", "story_v_out_319881.awb") / 1000

			if var_352_35 > 0 and var_352_34 < var_352_35 and var_352_35 + var_352_33 > arg_349_1.duration_ then
				local var_352_36 = var_352_35

				arg_349_1.duration_ = var_352_35 + var_352_33
			end

			if var_352_33 < arg_349_1.time_ and arg_349_1.time_ <= var_352_33 + arg_352_0 then
				local var_352_37 = "play"
				local var_352_38 = "voice"

				arg_349_1:AudioAction(var_352_37, var_352_38, "story_v_out_319881", "319881081", "story_v_out_319881.awb")
			end

			local var_352_39 = 0

			if var_352_39 < arg_349_1.time_ and arg_349_1.time_ <= var_352_39 + arg_352_0 then
				arg_349_1.cswbg_:SetActive(true)

				local var_352_40 = arg_349_1.cswt_:GetComponent("RectTransform")

				arg_349_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_352_40.offsetMin = Vector2.New(0, 0)
				var_352_40.offsetMax = Vector2.New(0, 0)

				local var_352_41 = arg_349_1:GetWordFromCfg(419063)
				local var_352_42 = arg_349_1:FormatText(var_352_41.content)

				arg_349_1.cswt_.text = var_352_42

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.cswt_)

				arg_349_1.cswt_.fontSize = 175
				arg_349_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_349_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_349_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play319881082 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 319881082
		arg_353_1.duration_ = 7

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play319881083(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = "XH0407a"

			if arg_353_1.bgs_[var_356_0] == nil then
				local var_356_1 = Object.Instantiate(arg_353_1.paintGo_)

				var_356_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_356_0)
				var_356_1.name = var_356_0
				var_356_1.transform.parent = arg_353_1.stage_.transform
				var_356_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_353_1.bgs_[var_356_0] = var_356_1
			end

			local var_356_2 = 0

			if var_356_2 < arg_353_1.time_ and arg_353_1.time_ <= var_356_2 + arg_356_0 then
				local var_356_3 = manager.ui.mainCamera.transform.localPosition
				local var_356_4 = Vector3.New(0, 0, 10) + Vector3.New(var_356_3.x, var_356_3.y, 0)
				local var_356_5 = arg_353_1.bgs_.XH0407a

				var_356_5.transform.localPosition = var_356_4
				var_356_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_356_6 = var_356_5:GetComponent("SpriteRenderer")

				if var_356_6 and var_356_6.sprite then
					local var_356_7 = (var_356_5.transform.localPosition - var_356_3).z
					local var_356_8 = manager.ui.mainCameraCom_
					local var_356_9 = 2 * var_356_7 * Mathf.Tan(var_356_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_356_10 = var_356_9 * var_356_8.aspect
					local var_356_11 = var_356_6.sprite.bounds.size.x
					local var_356_12 = var_356_6.sprite.bounds.size.y
					local var_356_13 = var_356_10 / var_356_11
					local var_356_14 = var_356_9 / var_356_12
					local var_356_15 = var_356_14 < var_356_13 and var_356_13 or var_356_14

					var_356_5.transform.localScale = Vector3.New(var_356_15, var_356_15, 0)
				end

				for iter_356_0, iter_356_1 in pairs(arg_353_1.bgs_) do
					if iter_356_0 ~= "XH0407a" then
						iter_356_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_356_16 = 0

			if var_356_16 < arg_353_1.time_ and arg_353_1.time_ <= var_356_16 + arg_356_0 then
				arg_353_1.allBtn_.enabled = false
			end

			local var_356_17 = 0.3

			if arg_353_1.time_ >= var_356_16 + var_356_17 and arg_353_1.time_ < var_356_16 + var_356_17 + arg_356_0 then
				arg_353_1.allBtn_.enabled = true
			end

			local var_356_18 = 0

			if var_356_18 < arg_353_1.time_ and arg_353_1.time_ <= var_356_18 + arg_356_0 then
				arg_353_1.mask_.enabled = true
				arg_353_1.mask_.raycastTarget = true

				arg_353_1:SetGaussion(false)
			end

			local var_356_19 = 2

			if var_356_18 <= arg_353_1.time_ and arg_353_1.time_ < var_356_18 + var_356_19 then
				local var_356_20 = (arg_353_1.time_ - var_356_18) / var_356_19
				local var_356_21 = Color.New(0, 0, 0)

				var_356_21.a = Mathf.Lerp(1, 0, var_356_20)
				arg_353_1.mask_.color = var_356_21
			end

			if arg_353_1.time_ >= var_356_18 + var_356_19 and arg_353_1.time_ < var_356_18 + var_356_19 + arg_356_0 then
				local var_356_22 = Color.New(0, 0, 0)
				local var_356_23 = 0

				arg_353_1.mask_.enabled = false
				var_356_22.a = var_356_23
				arg_353_1.mask_.color = var_356_22
			end

			local var_356_24 = arg_353_1.actors_["1095ui_story"].transform
			local var_356_25 = 0

			if var_356_25 < arg_353_1.time_ and arg_353_1.time_ <= var_356_25 + arg_356_0 then
				arg_353_1.var_.moveOldPos1095ui_story = var_356_24.localPosition
			end

			local var_356_26 = 0.001

			if var_356_25 <= arg_353_1.time_ and arg_353_1.time_ < var_356_25 + var_356_26 then
				local var_356_27 = (arg_353_1.time_ - var_356_25) / var_356_26
				local var_356_28 = Vector3.New(0, 100, 0)

				var_356_24.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1095ui_story, var_356_28, var_356_27)

				local var_356_29 = manager.ui.mainCamera.transform.position - var_356_24.position

				var_356_24.forward = Vector3.New(var_356_29.x, var_356_29.y, var_356_29.z)

				local var_356_30 = var_356_24.localEulerAngles

				var_356_30.z = 0
				var_356_30.x = 0
				var_356_24.localEulerAngles = var_356_30
			end

			if arg_353_1.time_ >= var_356_25 + var_356_26 and arg_353_1.time_ < var_356_25 + var_356_26 + arg_356_0 then
				var_356_24.localPosition = Vector3.New(0, 100, 0)

				local var_356_31 = manager.ui.mainCamera.transform.position - var_356_24.position

				var_356_24.forward = Vector3.New(var_356_31.x, var_356_31.y, var_356_31.z)

				local var_356_32 = var_356_24.localEulerAngles

				var_356_32.z = 0
				var_356_32.x = 0
				var_356_24.localEulerAngles = var_356_32
			end

			local var_356_33 = arg_353_1.actors_["1095ui_story"]
			local var_356_34 = 0

			if var_356_34 < arg_353_1.time_ and arg_353_1.time_ <= var_356_34 + arg_356_0 and not isNil(var_356_33) and arg_353_1.var_.characterEffect1095ui_story == nil then
				arg_353_1.var_.characterEffect1095ui_story = var_356_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_35 = 0.200000002980232

			if var_356_34 <= arg_353_1.time_ and arg_353_1.time_ < var_356_34 + var_356_35 and not isNil(var_356_33) then
				local var_356_36 = (arg_353_1.time_ - var_356_34) / var_356_35

				if arg_353_1.var_.characterEffect1095ui_story and not isNil(var_356_33) then
					local var_356_37 = Mathf.Lerp(0, 0.5, var_356_36)

					arg_353_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_353_1.var_.characterEffect1095ui_story.fillRatio = var_356_37
				end
			end

			if arg_353_1.time_ >= var_356_34 + var_356_35 and arg_353_1.time_ < var_356_34 + var_356_35 + arg_356_0 and not isNil(var_356_33) and arg_353_1.var_.characterEffect1095ui_story then
				local var_356_38 = 0.5

				arg_353_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_353_1.var_.characterEffect1095ui_story.fillRatio = var_356_38
			end

			local var_356_39 = 0

			if var_356_39 < arg_353_1.time_ and arg_353_1.time_ <= var_356_39 + arg_356_0 then
				arg_353_1.fswbg_:SetActive(false)
				arg_353_1.dialog_:SetActive(false)
				SetActive(arg_353_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_353_1:ShowNextGo(false)
			end

			local var_356_40 = 0.034000001847744

			if var_356_40 < arg_353_1.time_ and arg_353_1.time_ <= var_356_40 + arg_356_0 then
				arg_353_1.fswbg_:SetActive(false)
				arg_353_1.dialog_:SetActive(false)
				SetActive(arg_353_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_353_1:ShowNextGo(false)
			end

			local var_356_41 = 0

			if var_356_41 < arg_353_1.time_ and arg_353_1.time_ <= var_356_41 + arg_356_0 then
				arg_353_1.cswbg_:SetActive(false)
			end

			if arg_353_1.frameCnt_ <= 1 then
				arg_353_1.dialog_:SetActive(false)
			end

			local var_356_42 = 2
			local var_356_43 = 0.2

			if var_356_42 < arg_353_1.time_ and arg_353_1.time_ <= var_356_42 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0

				arg_353_1.dialog_:SetActive(true)

				arg_353_1.dialogCg_.alpha = 0

				local var_356_44 = LeanTween.value(arg_353_1.dialog_, 0, 1, 0.3)

				var_356_44:setOnUpdate(LuaHelper.FloatAction(function(arg_357_0)
					arg_353_1.dialogCg_.alpha = arg_357_0
				end))
				var_356_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_353_1.dialog_)
					var_356_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_353_1.duration_ = arg_353_1.duration_ + 0.3

				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_45 = arg_353_1:FormatText(StoryNameCfg[36].name)

				arg_353_1.leftNameTxt_.text = var_356_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_46 = arg_353_1:GetWordFromCfg(319881082)
				local var_356_47 = arg_353_1:FormatText(var_356_46.content)

				arg_353_1.text_.text = var_356_47

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_48 = 8
				local var_356_49 = utf8.len(var_356_47)
				local var_356_50 = var_356_48 <= 0 and var_356_43 or var_356_43 * (var_356_49 / var_356_48)

				if var_356_50 > 0 and var_356_43 < var_356_50 then
					arg_353_1.talkMaxDuration = var_356_50
					var_356_42 = var_356_42 + 0.3

					if var_356_50 + var_356_42 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_50 + var_356_42
					end
				end

				arg_353_1.text_.text = var_356_47
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_51 = var_356_42 + 0.3
			local var_356_52 = math.max(var_356_43, arg_353_1.talkMaxDuration)

			if var_356_51 <= arg_353_1.time_ and arg_353_1.time_ < var_356_51 + var_356_52 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_51) / var_356_52

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_51 + var_356_52 and arg_353_1.time_ < var_356_51 + var_356_52 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_353_1:InitPlayNodeList()
	end,
	Play319881083 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 319881083
		arg_359_1.duration_ = 2

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play319881084(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1084ui_story"].transform
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.var_.moveOldPos1084ui_story = var_362_0.localPosition
			end

			local var_362_2 = 0.001

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2
				local var_362_4 = Vector3.New(0, 100, 0)

				var_362_0.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1084ui_story, var_362_4, var_362_3)

				local var_362_5 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_5.x, var_362_5.y, var_362_5.z)

				local var_362_6 = var_362_0.localEulerAngles

				var_362_6.z = 0
				var_362_6.x = 0
				var_362_0.localEulerAngles = var_362_6
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 then
				var_362_0.localPosition = Vector3.New(0, 100, 0)

				local var_362_7 = manager.ui.mainCamera.transform.position - var_362_0.position

				var_362_0.forward = Vector3.New(var_362_7.x, var_362_7.y, var_362_7.z)

				local var_362_8 = var_362_0.localEulerAngles

				var_362_8.z = 0
				var_362_8.x = 0
				var_362_0.localEulerAngles = var_362_8
			end

			local var_362_9 = arg_359_1.actors_["1095ui_story"].transform
			local var_362_10 = 0

			if var_362_10 < arg_359_1.time_ and arg_359_1.time_ <= var_362_10 + arg_362_0 then
				arg_359_1.var_.moveOldPos1095ui_story = var_362_9.localPosition
			end

			local var_362_11 = 0.001

			if var_362_10 <= arg_359_1.time_ and arg_359_1.time_ < var_362_10 + var_362_11 then
				local var_362_12 = (arg_359_1.time_ - var_362_10) / var_362_11
				local var_362_13 = Vector3.New(0, -0.98, -6.1)

				var_362_9.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPos1095ui_story, var_362_13, var_362_12)

				local var_362_14 = manager.ui.mainCamera.transform.position - var_362_9.position

				var_362_9.forward = Vector3.New(var_362_14.x, var_362_14.y, var_362_14.z)

				local var_362_15 = var_362_9.localEulerAngles

				var_362_15.z = 0
				var_362_15.x = 0
				var_362_9.localEulerAngles = var_362_15
			end

			if arg_359_1.time_ >= var_362_10 + var_362_11 and arg_359_1.time_ < var_362_10 + var_362_11 + arg_362_0 then
				var_362_9.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_362_16 = manager.ui.mainCamera.transform.position - var_362_9.position

				var_362_9.forward = Vector3.New(var_362_16.x, var_362_16.y, var_362_16.z)

				local var_362_17 = var_362_9.localEulerAngles

				var_362_17.z = 0
				var_362_17.x = 0
				var_362_9.localEulerAngles = var_362_17
			end

			local var_362_18 = arg_359_1.actors_["1095ui_story"]
			local var_362_19 = 0

			if var_362_19 < arg_359_1.time_ and arg_359_1.time_ <= var_362_19 + arg_362_0 and not isNil(var_362_18) and arg_359_1.var_.characterEffect1095ui_story == nil then
				arg_359_1.var_.characterEffect1095ui_story = var_362_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_20 = 0.200000002980232

			if var_362_19 <= arg_359_1.time_ and arg_359_1.time_ < var_362_19 + var_362_20 and not isNil(var_362_18) then
				local var_362_21 = (arg_359_1.time_ - var_362_19) / var_362_20

				if arg_359_1.var_.characterEffect1095ui_story and not isNil(var_362_18) then
					arg_359_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= var_362_19 + var_362_20 and arg_359_1.time_ < var_362_19 + var_362_20 + arg_362_0 and not isNil(var_362_18) and arg_359_1.var_.characterEffect1095ui_story then
				arg_359_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_362_22 = 0

			if var_362_22 < arg_359_1.time_ and arg_359_1.time_ <= var_362_22 + arg_362_0 then
				arg_359_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_362_23 = 0

			if var_362_23 < arg_359_1.time_ and arg_359_1.time_ <= var_362_23 + arg_362_0 then
				arg_359_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_362_24 = 0
			local var_362_25 = 0.075

			if var_362_24 < arg_359_1.time_ and arg_359_1.time_ <= var_362_24 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_26 = arg_359_1:FormatText(StoryNameCfg[471].name)

				arg_359_1.leftNameTxt_.text = var_362_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_27 = arg_359_1:GetWordFromCfg(319881083)
				local var_362_28 = arg_359_1:FormatText(var_362_27.content)

				arg_359_1.text_.text = var_362_28

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_29 = 3
				local var_362_30 = utf8.len(var_362_28)
				local var_362_31 = var_362_29 <= 0 and var_362_25 or var_362_25 * (var_362_30 / var_362_29)

				if var_362_31 > 0 and var_362_25 < var_362_31 then
					arg_359_1.talkMaxDuration = var_362_31

					if var_362_31 + var_362_24 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_31 + var_362_24
					end
				end

				arg_359_1.text_.text = var_362_28
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881083", "story_v_out_319881.awb") ~= 0 then
					local var_362_32 = manager.audio:GetVoiceLength("story_v_out_319881", "319881083", "story_v_out_319881.awb") / 1000

					if var_362_32 + var_362_24 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_32 + var_362_24
					end

					if var_362_27.prefab_name ~= "" and arg_359_1.actors_[var_362_27.prefab_name] ~= nil then
						local var_362_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_27.prefab_name].transform, "story_v_out_319881", "319881083", "story_v_out_319881.awb")

						arg_359_1:RecordAudio("319881083", var_362_33)
						arg_359_1:RecordAudio("319881083", var_362_33)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_319881", "319881083", "story_v_out_319881.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_319881", "319881083", "story_v_out_319881.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_34 = math.max(var_362_25, arg_359_1.talkMaxDuration)

			if var_362_24 <= arg_359_1.time_ and arg_359_1.time_ < var_362_24 + var_362_34 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_24) / var_362_34

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_24 + var_362_34 and arg_359_1.time_ < var_362_24 + var_362_34 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play319881084 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 319881084
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play319881085(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0
			local var_366_1 = 1

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				local var_366_2 = "play"
				local var_366_3 = "effect"

				arg_363_1:AudioAction(var_366_2, var_366_3, "se_story_130", "se_story_130_fall2", "")
			end

			local var_366_4 = arg_363_1.actors_["1095ui_story"].transform
			local var_366_5 = 0

			if var_366_5 < arg_363_1.time_ and arg_363_1.time_ <= var_366_5 + arg_366_0 then
				arg_363_1.var_.moveOldPos1095ui_story = var_366_4.localPosition
			end

			local var_366_6 = 0.001

			if var_366_5 <= arg_363_1.time_ and arg_363_1.time_ < var_366_5 + var_366_6 then
				local var_366_7 = (arg_363_1.time_ - var_366_5) / var_366_6
				local var_366_8 = Vector3.New(0, 100, 0)

				var_366_4.localPosition = Vector3.Lerp(arg_363_1.var_.moveOldPos1095ui_story, var_366_8, var_366_7)

				local var_366_9 = manager.ui.mainCamera.transform.position - var_366_4.position

				var_366_4.forward = Vector3.New(var_366_9.x, var_366_9.y, var_366_9.z)

				local var_366_10 = var_366_4.localEulerAngles

				var_366_10.z = 0
				var_366_10.x = 0
				var_366_4.localEulerAngles = var_366_10
			end

			if arg_363_1.time_ >= var_366_5 + var_366_6 and arg_363_1.time_ < var_366_5 + var_366_6 + arg_366_0 then
				var_366_4.localPosition = Vector3.New(0, 100, 0)

				local var_366_11 = manager.ui.mainCamera.transform.position - var_366_4.position

				var_366_4.forward = Vector3.New(var_366_11.x, var_366_11.y, var_366_11.z)

				local var_366_12 = var_366_4.localEulerAngles

				var_366_12.z = 0
				var_366_12.x = 0
				var_366_4.localEulerAngles = var_366_12
			end

			local var_366_13 = 0
			local var_366_14 = 0.4

			if var_366_13 < arg_363_1.time_ and arg_363_1.time_ <= var_366_13 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_15 = arg_363_1:GetWordFromCfg(319881084)
				local var_366_16 = arg_363_1:FormatText(var_366_15.content)

				arg_363_1.text_.text = var_366_16

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_17 = 16
				local var_366_18 = utf8.len(var_366_16)
				local var_366_19 = var_366_17 <= 0 and var_366_14 or var_366_14 * (var_366_18 / var_366_17)

				if var_366_19 > 0 and var_366_14 < var_366_19 then
					arg_363_1.talkMaxDuration = var_366_19

					if var_366_19 + var_366_13 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_19 + var_366_13
					end
				end

				arg_363_1.text_.text = var_366_16
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_20 = math.max(var_366_14, arg_363_1.talkMaxDuration)

			if var_366_13 <= arg_363_1.time_ and arg_363_1.time_ < var_366_13 + var_366_20 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_13) / var_366_20

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_13 + var_366_20 and arg_363_1.time_ < var_366_13 + var_366_20 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_363_1:InitPlayNodeList()
	end,
	Play319881085 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 319881085
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play319881086(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0
			local var_370_1 = 1

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_2 = arg_367_1:GetWordFromCfg(319881085)
				local var_370_3 = arg_367_1:FormatText(var_370_2.content)

				arg_367_1.text_.text = var_370_3

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 40
				local var_370_5 = utf8.len(var_370_3)
				local var_370_6 = var_370_4 <= 0 and var_370_1 or var_370_1 * (var_370_5 / var_370_4)

				if var_370_6 > 0 and var_370_1 < var_370_6 then
					arg_367_1.talkMaxDuration = var_370_6

					if var_370_6 + var_370_0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_6 + var_370_0
					end
				end

				arg_367_1.text_.text = var_370_3
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_1, arg_367_1.talkMaxDuration)

			if var_370_0 <= arg_367_1.time_ and arg_367_1.time_ < var_370_0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_0 + var_370_7 and arg_367_1.time_ < var_370_0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play319881086 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 319881086
		arg_371_1.duration_ = 2.53

		local var_371_0 = {
			zh = 2,
			ja = 2.533
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play319881087(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1084ui_story"].transform
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 then
				arg_371_1.var_.moveOldPos1084ui_story = var_374_0.localPosition
			end

			local var_374_2 = 0.001

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2
				local var_374_4 = Vector3.New(0, -0.97, -6)

				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPos1084ui_story, var_374_4, var_374_3)

				local var_374_5 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_5.x, var_374_5.y, var_374_5.z)

				local var_374_6 = var_374_0.localEulerAngles

				var_374_6.z = 0
				var_374_6.x = 0
				var_374_0.localEulerAngles = var_374_6
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_374_7 = manager.ui.mainCamera.transform.position - var_374_0.position

				var_374_0.forward = Vector3.New(var_374_7.x, var_374_7.y, var_374_7.z)

				local var_374_8 = var_374_0.localEulerAngles

				var_374_8.z = 0
				var_374_8.x = 0
				var_374_0.localEulerAngles = var_374_8
			end

			local var_374_9 = arg_371_1.actors_["1084ui_story"]
			local var_374_10 = 0

			if var_374_10 < arg_371_1.time_ and arg_371_1.time_ <= var_374_10 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1084ui_story == nil then
				arg_371_1.var_.characterEffect1084ui_story = var_374_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_11 = 0.200000002980232

			if var_374_10 <= arg_371_1.time_ and arg_371_1.time_ < var_374_10 + var_374_11 and not isNil(var_374_9) then
				local var_374_12 = (arg_371_1.time_ - var_374_10) / var_374_11

				if arg_371_1.var_.characterEffect1084ui_story and not isNil(var_374_9) then
					arg_371_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= var_374_10 + var_374_11 and arg_371_1.time_ < var_374_10 + var_374_11 + arg_374_0 and not isNil(var_374_9) and arg_371_1.var_.characterEffect1084ui_story then
				arg_371_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_374_13 = 0

			if var_374_13 < arg_371_1.time_ and arg_371_1.time_ <= var_374_13 + arg_374_0 then
				arg_371_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_374_14 = 0

			if var_374_14 < arg_371_1.time_ and arg_371_1.time_ <= var_374_14 + arg_374_0 then
				arg_371_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_2")
			end

			if arg_371_1.frameCnt_ <= 1 then
				arg_371_1.dialog_:SetActive(false)
			end

			local var_374_15 = 0.7
			local var_374_16 = 0.1

			if var_374_15 < arg_371_1.time_ and arg_371_1.time_ <= var_374_15 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0

				arg_371_1.dialog_:SetActive(true)

				arg_371_1.dialogCg_.alpha = 0

				local var_374_17 = LeanTween.value(arg_371_1.dialog_, 0, 1, 0.3)

				var_374_17:setOnUpdate(LuaHelper.FloatAction(function(arg_375_0)
					arg_371_1.dialogCg_.alpha = arg_375_0
				end))
				var_374_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_371_1.dialog_)
					var_374_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_371_1.duration_ = arg_371_1.duration_ + 0.3

				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_18 = arg_371_1:FormatText(StoryNameCfg[6].name)

				arg_371_1.leftNameTxt_.text = var_374_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_19 = arg_371_1:GetWordFromCfg(319881086)
				local var_374_20 = arg_371_1:FormatText(var_374_19.content)

				arg_371_1.text_.text = var_374_20

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_21 = 4
				local var_374_22 = utf8.len(var_374_20)
				local var_374_23 = var_374_21 <= 0 and var_374_16 or var_374_16 * (var_374_22 / var_374_21)

				if var_374_23 > 0 and var_374_16 < var_374_23 then
					arg_371_1.talkMaxDuration = var_374_23
					var_374_15 = var_374_15 + 0.3

					if var_374_23 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_23 + var_374_15
					end
				end

				arg_371_1.text_.text = var_374_20
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881086", "story_v_out_319881.awb") ~= 0 then
					local var_374_24 = manager.audio:GetVoiceLength("story_v_out_319881", "319881086", "story_v_out_319881.awb") / 1000

					if var_374_24 + var_374_15 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_24 + var_374_15
					end

					if var_374_19.prefab_name ~= "" and arg_371_1.actors_[var_374_19.prefab_name] ~= nil then
						local var_374_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_19.prefab_name].transform, "story_v_out_319881", "319881086", "story_v_out_319881.awb")

						arg_371_1:RecordAudio("319881086", var_374_25)
						arg_371_1:RecordAudio("319881086", var_374_25)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_319881", "319881086", "story_v_out_319881.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_319881", "319881086", "story_v_out_319881.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_26 = var_374_15 + 0.3
			local var_374_27 = math.max(var_374_16, arg_371_1.talkMaxDuration)

			if var_374_26 <= arg_371_1.time_ and arg_371_1.time_ < var_374_26 + var_374_27 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_26) / var_374_27

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_26 + var_374_27 and arg_371_1.time_ < var_374_26 + var_374_27 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
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

		arg_371_1:InitPlayNodeList()
	end,
	Play319881087 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 319881087
		arg_377_1.duration_ = 6.83

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play319881088(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = 0.6

			if var_380_0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_0 + arg_380_0 then
				local var_380_1 = manager.ui.mainCamera.transform.localPosition
				local var_380_2 = Vector3.New(0, 0, 10) + Vector3.New(var_380_1.x, var_380_1.y, 0)
				local var_380_3 = arg_377_1.bgs_.ST70a

				var_380_3.transform.localPosition = var_380_2
				var_380_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_380_4 = var_380_3:GetComponent("SpriteRenderer")

				if var_380_4 and var_380_4.sprite then
					local var_380_5 = (var_380_3.transform.localPosition - var_380_1).z
					local var_380_6 = manager.ui.mainCameraCom_
					local var_380_7 = 2 * var_380_5 * Mathf.Tan(var_380_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_380_8 = var_380_7 * var_380_6.aspect
					local var_380_9 = var_380_4.sprite.bounds.size.x
					local var_380_10 = var_380_4.sprite.bounds.size.y
					local var_380_11 = var_380_8 / var_380_9
					local var_380_12 = var_380_7 / var_380_10
					local var_380_13 = var_380_12 < var_380_11 and var_380_11 or var_380_12

					var_380_3.transform.localScale = Vector3.New(var_380_13, var_380_13, 0)
				end

				for iter_380_0, iter_380_1 in pairs(arg_377_1.bgs_) do
					if iter_380_0 ~= "ST70a" then
						iter_380_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_380_14 = 0

			if var_380_14 < arg_377_1.time_ and arg_377_1.time_ <= var_380_14 + arg_380_0 then
				arg_377_1.allBtn_.enabled = false
			end

			local var_380_15 = 0.3

			if arg_377_1.time_ >= var_380_14 + var_380_15 and arg_377_1.time_ < var_380_14 + var_380_15 + arg_380_0 then
				arg_377_1.allBtn_.enabled = true
			end

			local var_380_16 = 0

			if var_380_16 < arg_377_1.time_ and arg_377_1.time_ <= var_380_16 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_17 = 0.6

			if var_380_16 <= arg_377_1.time_ and arg_377_1.time_ < var_380_16 + var_380_17 then
				local var_380_18 = (arg_377_1.time_ - var_380_16) / var_380_17
				local var_380_19 = Color.New(0, 0, 0)

				var_380_19.a = Mathf.Lerp(0, 1, var_380_18)
				arg_377_1.mask_.color = var_380_19
			end

			if arg_377_1.time_ >= var_380_16 + var_380_17 and arg_377_1.time_ < var_380_16 + var_380_17 + arg_380_0 then
				local var_380_20 = Color.New(0, 0, 0)

				var_380_20.a = 1
				arg_377_1.mask_.color = var_380_20
			end

			local var_380_21 = 0.6

			if var_380_21 < arg_377_1.time_ and arg_377_1.time_ <= var_380_21 + arg_380_0 then
				arg_377_1.mask_.enabled = true
				arg_377_1.mask_.raycastTarget = true

				arg_377_1:SetGaussion(false)
			end

			local var_380_22 = 1.36666666666667

			if var_380_21 <= arg_377_1.time_ and arg_377_1.time_ < var_380_21 + var_380_22 then
				local var_380_23 = (arg_377_1.time_ - var_380_21) / var_380_22
				local var_380_24 = Color.New(0, 0, 0)

				var_380_24.a = Mathf.Lerp(1, 0, var_380_23)
				arg_377_1.mask_.color = var_380_24
			end

			if arg_377_1.time_ >= var_380_21 + var_380_22 and arg_377_1.time_ < var_380_21 + var_380_22 + arg_380_0 then
				local var_380_25 = Color.New(0, 0, 0)
				local var_380_26 = 0

				arg_377_1.mask_.enabled = false
				var_380_25.a = var_380_26
				arg_377_1.mask_.color = var_380_25
			end

			local var_380_27 = arg_377_1.actors_["1084ui_story"].transform
			local var_380_28 = 0.565999998152256

			if var_380_28 < arg_377_1.time_ and arg_377_1.time_ <= var_380_28 + arg_380_0 then
				arg_377_1.var_.moveOldPos1084ui_story = var_380_27.localPosition
			end

			local var_380_29 = 0.001

			if var_380_28 <= arg_377_1.time_ and arg_377_1.time_ < var_380_28 + var_380_29 then
				local var_380_30 = (arg_377_1.time_ - var_380_28) / var_380_29
				local var_380_31 = Vector3.New(0, 100, 0)

				var_380_27.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1084ui_story, var_380_31, var_380_30)

				local var_380_32 = manager.ui.mainCamera.transform.position - var_380_27.position

				var_380_27.forward = Vector3.New(var_380_32.x, var_380_32.y, var_380_32.z)

				local var_380_33 = var_380_27.localEulerAngles

				var_380_33.z = 0
				var_380_33.x = 0
				var_380_27.localEulerAngles = var_380_33
			end

			if arg_377_1.time_ >= var_380_28 + var_380_29 and arg_377_1.time_ < var_380_28 + var_380_29 + arg_380_0 then
				var_380_27.localPosition = Vector3.New(0, 100, 0)

				local var_380_34 = manager.ui.mainCamera.transform.position - var_380_27.position

				var_380_27.forward = Vector3.New(var_380_34.x, var_380_34.y, var_380_34.z)

				local var_380_35 = var_380_27.localEulerAngles

				var_380_35.z = 0
				var_380_35.x = 0
				var_380_27.localEulerAngles = var_380_35
			end

			if arg_377_1.frameCnt_ <= 1 then
				arg_377_1.dialog_:SetActive(false)
			end

			local var_380_36 = 1.83333333333333
			local var_380_37 = 1.1

			if var_380_36 < arg_377_1.time_ and arg_377_1.time_ <= var_380_36 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0

				arg_377_1.dialog_:SetActive(true)

				arg_377_1.dialogCg_.alpha = 0

				local var_380_38 = LeanTween.value(arg_377_1.dialog_, 0, 1, 0.3)

				var_380_38:setOnUpdate(LuaHelper.FloatAction(function(arg_381_0)
					arg_377_1.dialogCg_.alpha = arg_381_0
				end))
				var_380_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_377_1.dialog_)
					var_380_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_377_1.duration_ = arg_377_1.duration_ + 0.3

				SetActive(arg_377_1.leftNameGo_, false)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_39 = arg_377_1:GetWordFromCfg(319881087)
				local var_380_40 = arg_377_1:FormatText(var_380_39.content)

				arg_377_1.text_.text = var_380_40

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_41 = 44
				local var_380_42 = utf8.len(var_380_40)
				local var_380_43 = var_380_41 <= 0 and var_380_37 or var_380_37 * (var_380_42 / var_380_41)

				if var_380_43 > 0 and var_380_37 < var_380_43 then
					arg_377_1.talkMaxDuration = var_380_43
					var_380_36 = var_380_36 + 0.3

					if var_380_43 + var_380_36 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_43 + var_380_36
					end
				end

				arg_377_1.text_.text = var_380_40
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_44 = var_380_36 + 0.3
			local var_380_45 = math.max(var_380_37, arg_377_1.talkMaxDuration)

			if var_380_44 <= arg_377_1.time_ and arg_377_1.time_ < var_380_44 + var_380_45 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_44) / var_380_45

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_44 + var_380_45 and arg_377_1.time_ < var_380_44 + var_380_45 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.565999998152256,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_377_1:InitPlayNodeList()
	end,
	Play319881088 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 319881088
		arg_383_1.duration_ = 5

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play319881089(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = 0
			local var_386_1 = 1.025

			if var_386_0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_0 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, false)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_2 = arg_383_1:GetWordFromCfg(319881088)
				local var_386_3 = arg_383_1:FormatText(var_386_2.content)

				arg_383_1.text_.text = var_386_3

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_4 = 41
				local var_386_5 = utf8.len(var_386_3)
				local var_386_6 = var_386_4 <= 0 and var_386_1 or var_386_1 * (var_386_5 / var_386_4)

				if var_386_6 > 0 and var_386_1 < var_386_6 then
					arg_383_1.talkMaxDuration = var_386_6

					if var_386_6 + var_386_0 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_6 + var_386_0
					end
				end

				arg_383_1.text_.text = var_386_3
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)
				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_7 = math.max(var_386_1, arg_383_1.talkMaxDuration)

			if var_386_0 <= arg_383_1.time_ and arg_383_1.time_ < var_386_0 + var_386_7 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_0) / var_386_7

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_0 + var_386_7 and arg_383_1.time_ < var_386_0 + var_386_7 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play319881089 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 319881089
		arg_387_1.duration_ = 3.7

		local var_387_0 = {
			zh = 3.066,
			ja = 3.7
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play319881090(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["1084ui_story"].transform
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1.var_.moveOldPos1084ui_story = var_390_0.localPosition
			end

			local var_390_2 = 0.001

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2
				local var_390_4 = Vector3.New(0, -0.97, -6)

				var_390_0.localPosition = Vector3.Lerp(arg_387_1.var_.moveOldPos1084ui_story, var_390_4, var_390_3)

				local var_390_5 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_5.x, var_390_5.y, var_390_5.z)

				local var_390_6 = var_390_0.localEulerAngles

				var_390_6.z = 0
				var_390_6.x = 0
				var_390_0.localEulerAngles = var_390_6
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 then
				var_390_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_390_7 = manager.ui.mainCamera.transform.position - var_390_0.position

				var_390_0.forward = Vector3.New(var_390_7.x, var_390_7.y, var_390_7.z)

				local var_390_8 = var_390_0.localEulerAngles

				var_390_8.z = 0
				var_390_8.x = 0
				var_390_0.localEulerAngles = var_390_8
			end

			local var_390_9 = arg_387_1.actors_["1084ui_story"]
			local var_390_10 = 0

			if var_390_10 < arg_387_1.time_ and arg_387_1.time_ <= var_390_10 + arg_390_0 and not isNil(var_390_9) and arg_387_1.var_.characterEffect1084ui_story == nil then
				arg_387_1.var_.characterEffect1084ui_story = var_390_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_11 = 0.200000002980232

			if var_390_10 <= arg_387_1.time_ and arg_387_1.time_ < var_390_10 + var_390_11 and not isNil(var_390_9) then
				local var_390_12 = (arg_387_1.time_ - var_390_10) / var_390_11

				if arg_387_1.var_.characterEffect1084ui_story and not isNil(var_390_9) then
					arg_387_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= var_390_10 + var_390_11 and arg_387_1.time_ < var_390_10 + var_390_11 + arg_390_0 and not isNil(var_390_9) and arg_387_1.var_.characterEffect1084ui_story then
				arg_387_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_390_13 = 0

			if var_390_13 < arg_387_1.time_ and arg_387_1.time_ <= var_390_13 + arg_390_0 then
				arg_387_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if arg_387_1.frameCnt_ <= 1 then
				arg_387_1.dialog_:SetActive(false)
			end

			local var_390_14 = 0.8
			local var_390_15 = 0.2

			if var_390_14 < arg_387_1.time_ and arg_387_1.time_ <= var_390_14 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0

				arg_387_1.dialog_:SetActive(true)

				arg_387_1.dialogCg_.alpha = 0

				local var_390_16 = LeanTween.value(arg_387_1.dialog_, 0, 1, 0.3)

				var_390_16:setOnUpdate(LuaHelper.FloatAction(function(arg_391_0)
					arg_387_1.dialogCg_.alpha = arg_391_0
				end))
				var_390_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_387_1.dialog_)
					var_390_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_387_1.duration_ = arg_387_1.duration_ + 0.3

				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_17 = arg_387_1:FormatText(StoryNameCfg[6].name)

				arg_387_1.leftNameTxt_.text = var_390_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_18 = arg_387_1:GetWordFromCfg(319881089)
				local var_390_19 = arg_387_1:FormatText(var_390_18.content)

				arg_387_1.text_.text = var_390_19

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_20 = 8
				local var_390_21 = utf8.len(var_390_19)
				local var_390_22 = var_390_20 <= 0 and var_390_15 or var_390_15 * (var_390_21 / var_390_20)

				if var_390_22 > 0 and var_390_15 < var_390_22 then
					arg_387_1.talkMaxDuration = var_390_22
					var_390_14 = var_390_14 + 0.3

					if var_390_22 + var_390_14 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_22 + var_390_14
					end
				end

				arg_387_1.text_.text = var_390_19
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881089", "story_v_out_319881.awb") ~= 0 then
					local var_390_23 = manager.audio:GetVoiceLength("story_v_out_319881", "319881089", "story_v_out_319881.awb") / 1000

					if var_390_23 + var_390_14 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_23 + var_390_14
					end

					if var_390_18.prefab_name ~= "" and arg_387_1.actors_[var_390_18.prefab_name] ~= nil then
						local var_390_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_18.prefab_name].transform, "story_v_out_319881", "319881089", "story_v_out_319881.awb")

						arg_387_1:RecordAudio("319881089", var_390_24)
						arg_387_1:RecordAudio("319881089", var_390_24)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_319881", "319881089", "story_v_out_319881.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_319881", "319881089", "story_v_out_319881.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_25 = var_390_14 + 0.3
			local var_390_26 = math.max(var_390_15, arg_387_1.talkMaxDuration)

			if var_390_25 <= arg_387_1.time_ and arg_387_1.time_ < var_390_25 + var_390_26 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_25) / var_390_26

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_25 + var_390_26 and arg_387_1.time_ < var_390_25 + var_390_26 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {
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

		arg_387_1:InitPlayNodeList()
	end,
	Play319881090 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 319881090
		arg_393_1.duration_ = 4.93

		local var_393_0 = {
			zh = 2.866,
			ja = 4.933
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play319881091(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if arg_393_1.frameCnt_ <= 1 then
				arg_393_1.dialog_:SetActive(false)
			end

			local var_396_2 = 0.3
			local var_396_3 = 0.275

			if var_396_2 < arg_393_1.time_ and arg_393_1.time_ <= var_396_2 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0

				arg_393_1.dialog_:SetActive(true)

				arg_393_1.dialogCg_.alpha = 0

				local var_396_4 = LeanTween.value(arg_393_1.dialog_, 0, 1, 0.3)

				var_396_4:setOnUpdate(LuaHelper.FloatAction(function(arg_397_0)
					arg_393_1.dialogCg_.alpha = arg_397_0
				end))
				var_396_4:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_393_1.dialog_)
					var_396_4:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_393_1.duration_ = arg_393_1.duration_ + 0.3

				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_5 = arg_393_1:FormatText(StoryNameCfg[6].name)

				arg_393_1.leftNameTxt_.text = var_396_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_6 = arg_393_1:GetWordFromCfg(319881090)
				local var_396_7 = arg_393_1:FormatText(var_396_6.content)

				arg_393_1.text_.text = var_396_7

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_8 = 11
				local var_396_9 = utf8.len(var_396_7)
				local var_396_10 = var_396_8 <= 0 and var_396_3 or var_396_3 * (var_396_9 / var_396_8)

				if var_396_10 > 0 and var_396_3 < var_396_10 then
					arg_393_1.talkMaxDuration = var_396_10
					var_396_2 = var_396_2 + 0.3

					if var_396_10 + var_396_2 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_10 + var_396_2
					end
				end

				arg_393_1.text_.text = var_396_7
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881090", "story_v_out_319881.awb") ~= 0 then
					local var_396_11 = manager.audio:GetVoiceLength("story_v_out_319881", "319881090", "story_v_out_319881.awb") / 1000

					if var_396_11 + var_396_2 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_11 + var_396_2
					end

					if var_396_6.prefab_name ~= "" and arg_393_1.actors_[var_396_6.prefab_name] ~= nil then
						local var_396_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_6.prefab_name].transform, "story_v_out_319881", "319881090", "story_v_out_319881.awb")

						arg_393_1:RecordAudio("319881090", var_396_12)
						arg_393_1:RecordAudio("319881090", var_396_12)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_319881", "319881090", "story_v_out_319881.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_319881", "319881090", "story_v_out_319881.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_13 = var_396_2 + 0.3
			local var_396_14 = math.max(var_396_3, arg_393_1.talkMaxDuration)

			if var_396_13 <= arg_393_1.time_ and arg_393_1.time_ < var_396_13 + var_396_14 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_13) / var_396_14

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_13 + var_396_14 and arg_393_1.time_ < var_396_13 + var_396_14 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play319881091 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 319881091
		arg_399_1.duration_ = 8.2

		local var_399_0 = {
			zh = 4.633,
			ja = 8.2
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play319881092(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = arg_399_1.actors_["1095ui_story"].transform
			local var_402_1 = 0

			if var_402_1 < arg_399_1.time_ and arg_399_1.time_ <= var_402_1 + arg_402_0 then
				arg_399_1.var_.moveOldPos1095ui_story = var_402_0.localPosition
			end

			local var_402_2 = 0.001

			if var_402_1 <= arg_399_1.time_ and arg_399_1.time_ < var_402_1 + var_402_2 then
				local var_402_3 = (arg_399_1.time_ - var_402_1) / var_402_2
				local var_402_4 = Vector3.New(0.7, -0.98, -6.1)

				var_402_0.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1095ui_story, var_402_4, var_402_3)

				local var_402_5 = manager.ui.mainCamera.transform.position - var_402_0.position

				var_402_0.forward = Vector3.New(var_402_5.x, var_402_5.y, var_402_5.z)

				local var_402_6 = var_402_0.localEulerAngles

				var_402_6.z = 0
				var_402_6.x = 0
				var_402_0.localEulerAngles = var_402_6
			end

			if arg_399_1.time_ >= var_402_1 + var_402_2 and arg_399_1.time_ < var_402_1 + var_402_2 + arg_402_0 then
				var_402_0.localPosition = Vector3.New(0.7, -0.98, -6.1)

				local var_402_7 = manager.ui.mainCamera.transform.position - var_402_0.position

				var_402_0.forward = Vector3.New(var_402_7.x, var_402_7.y, var_402_7.z)

				local var_402_8 = var_402_0.localEulerAngles

				var_402_8.z = 0
				var_402_8.x = 0
				var_402_0.localEulerAngles = var_402_8
			end

			local var_402_9 = arg_399_1.actors_["1095ui_story"]
			local var_402_10 = 0

			if var_402_10 < arg_399_1.time_ and arg_399_1.time_ <= var_402_10 + arg_402_0 and not isNil(var_402_9) and arg_399_1.var_.characterEffect1095ui_story == nil then
				arg_399_1.var_.characterEffect1095ui_story = var_402_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_11 = 0.200000002980232

			if var_402_10 <= arg_399_1.time_ and arg_399_1.time_ < var_402_10 + var_402_11 and not isNil(var_402_9) then
				local var_402_12 = (arg_399_1.time_ - var_402_10) / var_402_11

				if arg_399_1.var_.characterEffect1095ui_story and not isNil(var_402_9) then
					arg_399_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_399_1.time_ >= var_402_10 + var_402_11 and arg_399_1.time_ < var_402_10 + var_402_11 + arg_402_0 and not isNil(var_402_9) and arg_399_1.var_.characterEffect1095ui_story then
				arg_399_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_402_13 = 0

			if var_402_13 < arg_399_1.time_ and arg_399_1.time_ <= var_402_13 + arg_402_0 then
				arg_399_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_402_14 = 0

			if var_402_14 < arg_399_1.time_ and arg_399_1.time_ <= var_402_14 + arg_402_0 then
				arg_399_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2201cva")
			end

			local var_402_15 = arg_399_1.actors_["1084ui_story"].transform
			local var_402_16 = 0

			if var_402_16 < arg_399_1.time_ and arg_399_1.time_ <= var_402_16 + arg_402_0 then
				arg_399_1.var_.moveOldPos1084ui_story = var_402_15.localPosition
			end

			local var_402_17 = 0.001

			if var_402_16 <= arg_399_1.time_ and arg_399_1.time_ < var_402_16 + var_402_17 then
				local var_402_18 = (arg_399_1.time_ - var_402_16) / var_402_17
				local var_402_19 = Vector3.New(-0.7, -0.97, -6)

				var_402_15.localPosition = Vector3.Lerp(arg_399_1.var_.moveOldPos1084ui_story, var_402_19, var_402_18)

				local var_402_20 = manager.ui.mainCamera.transform.position - var_402_15.position

				var_402_15.forward = Vector3.New(var_402_20.x, var_402_20.y, var_402_20.z)

				local var_402_21 = var_402_15.localEulerAngles

				var_402_21.z = 0
				var_402_21.x = 0
				var_402_15.localEulerAngles = var_402_21
			end

			if arg_399_1.time_ >= var_402_16 + var_402_17 and arg_399_1.time_ < var_402_16 + var_402_17 + arg_402_0 then
				var_402_15.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_402_22 = manager.ui.mainCamera.transform.position - var_402_15.position

				var_402_15.forward = Vector3.New(var_402_22.x, var_402_22.y, var_402_22.z)

				local var_402_23 = var_402_15.localEulerAngles

				var_402_23.z = 0
				var_402_23.x = 0
				var_402_15.localEulerAngles = var_402_23
			end

			local var_402_24 = arg_399_1.actors_["1084ui_story"]
			local var_402_25 = 0

			if var_402_25 < arg_399_1.time_ and arg_399_1.time_ <= var_402_25 + arg_402_0 and not isNil(var_402_24) and arg_399_1.var_.characterEffect1084ui_story == nil then
				arg_399_1.var_.characterEffect1084ui_story = var_402_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_402_26 = 0.200000002980232

			if var_402_25 <= arg_399_1.time_ and arg_399_1.time_ < var_402_25 + var_402_26 and not isNil(var_402_24) then
				local var_402_27 = (arg_399_1.time_ - var_402_25) / var_402_26

				if arg_399_1.var_.characterEffect1084ui_story and not isNil(var_402_24) then
					local var_402_28 = Mathf.Lerp(0, 0.5, var_402_27)

					arg_399_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_399_1.var_.characterEffect1084ui_story.fillRatio = var_402_28
				end
			end

			if arg_399_1.time_ >= var_402_25 + var_402_26 and arg_399_1.time_ < var_402_25 + var_402_26 + arg_402_0 and not isNil(var_402_24) and arg_399_1.var_.characterEffect1084ui_story then
				local var_402_29 = 0.5

				arg_399_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_399_1.var_.characterEffect1084ui_story.fillRatio = var_402_29
			end

			local var_402_30 = 0
			local var_402_31 = 0.575

			if var_402_30 < arg_399_1.time_ and arg_399_1.time_ <= var_402_30 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_32 = arg_399_1:FormatText(StoryNameCfg[471].name)

				arg_399_1.leftNameTxt_.text = var_402_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_33 = arg_399_1:GetWordFromCfg(319881091)
				local var_402_34 = arg_399_1:FormatText(var_402_33.content)

				arg_399_1.text_.text = var_402_34

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_35 = 23
				local var_402_36 = utf8.len(var_402_34)
				local var_402_37 = var_402_35 <= 0 and var_402_31 or var_402_31 * (var_402_36 / var_402_35)

				if var_402_37 > 0 and var_402_31 < var_402_37 then
					arg_399_1.talkMaxDuration = var_402_37

					if var_402_37 + var_402_30 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_37 + var_402_30
					end
				end

				arg_399_1.text_.text = var_402_34
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881091", "story_v_out_319881.awb") ~= 0 then
					local var_402_38 = manager.audio:GetVoiceLength("story_v_out_319881", "319881091", "story_v_out_319881.awb") / 1000

					if var_402_38 + var_402_30 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_38 + var_402_30
					end

					if var_402_33.prefab_name ~= "" and arg_399_1.actors_[var_402_33.prefab_name] ~= nil then
						local var_402_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_33.prefab_name].transform, "story_v_out_319881", "319881091", "story_v_out_319881.awb")

						arg_399_1:RecordAudio("319881091", var_402_39)
						arg_399_1:RecordAudio("319881091", var_402_39)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_319881", "319881091", "story_v_out_319881.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_319881", "319881091", "story_v_out_319881.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_40 = math.max(var_402_31, arg_399_1.talkMaxDuration)

			if var_402_30 <= arg_399_1.time_ and arg_399_1.time_ < var_402_30 + var_402_40 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_30) / var_402_40

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_30 + var_402_40 and arg_399_1.time_ < var_402_30 + var_402_40 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end

		arg_399_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_399_1:InitPlayNodeList()
	end,
	Play319881092 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 319881092
		arg_403_1.duration_ = 3

		local var_403_0 = {
			zh = 3,
			ja = 2.333
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play319881093(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = arg_403_1.actors_["1095ui_story"]
			local var_406_1 = 0

			if var_406_1 < arg_403_1.time_ and arg_403_1.time_ <= var_406_1 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect1095ui_story == nil then
				arg_403_1.var_.characterEffect1095ui_story = var_406_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_2 = 0.200000002980232

			if var_406_1 <= arg_403_1.time_ and arg_403_1.time_ < var_406_1 + var_406_2 and not isNil(var_406_0) then
				local var_406_3 = (arg_403_1.time_ - var_406_1) / var_406_2

				if arg_403_1.var_.characterEffect1095ui_story and not isNil(var_406_0) then
					local var_406_4 = Mathf.Lerp(0, 0.5, var_406_3)

					arg_403_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_403_1.var_.characterEffect1095ui_story.fillRatio = var_406_4
				end
			end

			if arg_403_1.time_ >= var_406_1 + var_406_2 and arg_403_1.time_ < var_406_1 + var_406_2 + arg_406_0 and not isNil(var_406_0) and arg_403_1.var_.characterEffect1095ui_story then
				local var_406_5 = 0.5

				arg_403_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_403_1.var_.characterEffect1095ui_story.fillRatio = var_406_5
			end

			local var_406_6 = arg_403_1.actors_["1084ui_story"]
			local var_406_7 = 0

			if var_406_7 < arg_403_1.time_ and arg_403_1.time_ <= var_406_7 + arg_406_0 and not isNil(var_406_6) and arg_403_1.var_.characterEffect1084ui_story == nil then
				arg_403_1.var_.characterEffect1084ui_story = var_406_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_406_8 = 0.200000002980232

			if var_406_7 <= arg_403_1.time_ and arg_403_1.time_ < var_406_7 + var_406_8 and not isNil(var_406_6) then
				local var_406_9 = (arg_403_1.time_ - var_406_7) / var_406_8

				if arg_403_1.var_.characterEffect1084ui_story and not isNil(var_406_6) then
					arg_403_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_403_1.time_ >= var_406_7 + var_406_8 and arg_403_1.time_ < var_406_7 + var_406_8 + arg_406_0 and not isNil(var_406_6) and arg_403_1.var_.characterEffect1084ui_story then
				arg_403_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_406_10 = 0

			if var_406_10 < arg_403_1.time_ and arg_403_1.time_ <= var_406_10 + arg_406_0 then
				arg_403_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_406_11 = 0
			local var_406_12 = 0.3

			if var_406_11 < arg_403_1.time_ and arg_403_1.time_ <= var_406_11 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_13 = arg_403_1:FormatText(StoryNameCfg[6].name)

				arg_403_1.leftNameTxt_.text = var_406_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_14 = arg_403_1:GetWordFromCfg(319881092)
				local var_406_15 = arg_403_1:FormatText(var_406_14.content)

				arg_403_1.text_.text = var_406_15

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_16 = 12
				local var_406_17 = utf8.len(var_406_15)
				local var_406_18 = var_406_16 <= 0 and var_406_12 or var_406_12 * (var_406_17 / var_406_16)

				if var_406_18 > 0 and var_406_12 < var_406_18 then
					arg_403_1.talkMaxDuration = var_406_18

					if var_406_18 + var_406_11 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_18 + var_406_11
					end
				end

				arg_403_1.text_.text = var_406_15
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881092", "story_v_out_319881.awb") ~= 0 then
					local var_406_19 = manager.audio:GetVoiceLength("story_v_out_319881", "319881092", "story_v_out_319881.awb") / 1000

					if var_406_19 + var_406_11 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_19 + var_406_11
					end

					if var_406_14.prefab_name ~= "" and arg_403_1.actors_[var_406_14.prefab_name] ~= nil then
						local var_406_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_14.prefab_name].transform, "story_v_out_319881", "319881092", "story_v_out_319881.awb")

						arg_403_1:RecordAudio("319881092", var_406_20)
						arg_403_1:RecordAudio("319881092", var_406_20)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_319881", "319881092", "story_v_out_319881.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_319881", "319881092", "story_v_out_319881.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_21 = math.max(var_406_12, arg_403_1.talkMaxDuration)

			if var_406_11 <= arg_403_1.time_ and arg_403_1.time_ < var_406_11 + var_406_21 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_11) / var_406_21

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_11 + var_406_21 and arg_403_1.time_ < var_406_11 + var_406_21 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play319881093 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 319881093
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play319881094(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1084ui_story"]
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1084ui_story == nil then
				arg_407_1.var_.characterEffect1084ui_story = var_410_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_2 = 0.200000002980232

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 and not isNil(var_410_0) then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2

				if arg_407_1.var_.characterEffect1084ui_story and not isNil(var_410_0) then
					local var_410_4 = Mathf.Lerp(0, 0.5, var_410_3)

					arg_407_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_407_1.var_.characterEffect1084ui_story.fillRatio = var_410_4
				end
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 and not isNil(var_410_0) and arg_407_1.var_.characterEffect1084ui_story then
				local var_410_5 = 0.5

				arg_407_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_407_1.var_.characterEffect1084ui_story.fillRatio = var_410_5
			end

			local var_410_6 = 0
			local var_410_7 = 1.1

			if var_410_6 < arg_407_1.time_ and arg_407_1.time_ <= var_410_6 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_8 = arg_407_1:GetWordFromCfg(319881093)
				local var_410_9 = arg_407_1:FormatText(var_410_8.content)

				arg_407_1.text_.text = var_410_9

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_10 = 44
				local var_410_11 = utf8.len(var_410_9)
				local var_410_12 = var_410_10 <= 0 and var_410_7 or var_410_7 * (var_410_11 / var_410_10)

				if var_410_12 > 0 and var_410_7 < var_410_12 then
					arg_407_1.talkMaxDuration = var_410_12

					if var_410_12 + var_410_6 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_12 + var_410_6
					end
				end

				arg_407_1.text_.text = var_410_9
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_13 = math.max(var_410_7, arg_407_1.talkMaxDuration)

			if var_410_6 <= arg_407_1.time_ and arg_407_1.time_ < var_410_6 + var_410_13 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_6) / var_410_13

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_6 + var_410_13 and arg_407_1.time_ < var_410_6 + var_410_13 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play319881094 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 319881094
		arg_411_1.duration_ = 2.7

		local var_411_0 = {
			zh = 2.566,
			ja = 2.7
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play319881095(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1084ui_story"]
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1084ui_story == nil then
				arg_411_1.var_.characterEffect1084ui_story = var_414_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.200000002980232

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 and not isNil(var_414_0) then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2

				if arg_411_1.var_.characterEffect1084ui_story and not isNil(var_414_0) then
					arg_411_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 and not isNil(var_414_0) and arg_411_1.var_.characterEffect1084ui_story then
				arg_411_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_414_4 = 0

			if var_414_4 < arg_411_1.time_ and arg_411_1.time_ <= var_414_4 + arg_414_0 then
				arg_411_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			local var_414_5 = 0

			if var_414_5 < arg_411_1.time_ and arg_411_1.time_ <= var_414_5 + arg_414_0 then
				arg_411_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_414_6 = 0
			local var_414_7 = 0.275

			if var_414_6 < arg_411_1.time_ and arg_411_1.time_ <= var_414_6 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_8 = arg_411_1:FormatText(StoryNameCfg[6].name)

				arg_411_1.leftNameTxt_.text = var_414_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_9 = arg_411_1:GetWordFromCfg(319881094)
				local var_414_10 = arg_411_1:FormatText(var_414_9.content)

				arg_411_1.text_.text = var_414_10

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_11 = 11
				local var_414_12 = utf8.len(var_414_10)
				local var_414_13 = var_414_11 <= 0 and var_414_7 or var_414_7 * (var_414_12 / var_414_11)

				if var_414_13 > 0 and var_414_7 < var_414_13 then
					arg_411_1.talkMaxDuration = var_414_13

					if var_414_13 + var_414_6 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_13 + var_414_6
					end
				end

				arg_411_1.text_.text = var_414_10
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319881", "319881094", "story_v_out_319881.awb") ~= 0 then
					local var_414_14 = manager.audio:GetVoiceLength("story_v_out_319881", "319881094", "story_v_out_319881.awb") / 1000

					if var_414_14 + var_414_6 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_14 + var_414_6
					end

					if var_414_9.prefab_name ~= "" and arg_411_1.actors_[var_414_9.prefab_name] ~= nil then
						local var_414_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_9.prefab_name].transform, "story_v_out_319881", "319881094", "story_v_out_319881.awb")

						arg_411_1:RecordAudio("319881094", var_414_15)
						arg_411_1:RecordAudio("319881094", var_414_15)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_319881", "319881094", "story_v_out_319881.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_319881", "319881094", "story_v_out_319881.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_16 = math.max(var_414_7, arg_411_1.talkMaxDuration)

			if var_414_6 <= arg_411_1.time_ and arg_411_1.time_ < var_414_6 + var_414_16 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_6) / var_414_16

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_6 + var_414_16 and arg_411_1.time_ < var_414_6 + var_414_16 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play319881095 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 319881095
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play319881096(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["1095ui_story"].transform
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 then
				arg_415_1.var_.moveOldPos1095ui_story = var_418_0.localPosition
			end

			local var_418_2 = 0.001

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2
				local var_418_4 = Vector3.New(0, 100, 0)

				var_418_0.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1095ui_story, var_418_4, var_418_3)

				local var_418_5 = manager.ui.mainCamera.transform.position - var_418_0.position

				var_418_0.forward = Vector3.New(var_418_5.x, var_418_5.y, var_418_5.z)

				local var_418_6 = var_418_0.localEulerAngles

				var_418_6.z = 0
				var_418_6.x = 0
				var_418_0.localEulerAngles = var_418_6
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 then
				var_418_0.localPosition = Vector3.New(0, 100, 0)

				local var_418_7 = manager.ui.mainCamera.transform.position - var_418_0.position

				var_418_0.forward = Vector3.New(var_418_7.x, var_418_7.y, var_418_7.z)

				local var_418_8 = var_418_0.localEulerAngles

				var_418_8.z = 0
				var_418_8.x = 0
				var_418_0.localEulerAngles = var_418_8
			end

			local var_418_9 = arg_415_1.actors_["1084ui_story"].transform
			local var_418_10 = 0

			if var_418_10 < arg_415_1.time_ and arg_415_1.time_ <= var_418_10 + arg_418_0 then
				arg_415_1.var_.moveOldPos1084ui_story = var_418_9.localPosition
			end

			local var_418_11 = 0.001

			if var_418_10 <= arg_415_1.time_ and arg_415_1.time_ < var_418_10 + var_418_11 then
				local var_418_12 = (arg_415_1.time_ - var_418_10) / var_418_11
				local var_418_13 = Vector3.New(0, 100, 0)

				var_418_9.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1084ui_story, var_418_13, var_418_12)

				local var_418_14 = manager.ui.mainCamera.transform.position - var_418_9.position

				var_418_9.forward = Vector3.New(var_418_14.x, var_418_14.y, var_418_14.z)

				local var_418_15 = var_418_9.localEulerAngles

				var_418_15.z = 0
				var_418_15.x = 0
				var_418_9.localEulerAngles = var_418_15
			end

			if arg_415_1.time_ >= var_418_10 + var_418_11 and arg_415_1.time_ < var_418_10 + var_418_11 + arg_418_0 then
				var_418_9.localPosition = Vector3.New(0, 100, 0)

				local var_418_16 = manager.ui.mainCamera.transform.position - var_418_9.position

				var_418_9.forward = Vector3.New(var_418_16.x, var_418_16.y, var_418_16.z)

				local var_418_17 = var_418_9.localEulerAngles

				var_418_17.z = 0
				var_418_17.x = 0
				var_418_9.localEulerAngles = var_418_17
			end

			local var_418_18 = 0
			local var_418_19 = 0.725

			if var_418_18 < arg_415_1.time_ and arg_415_1.time_ <= var_418_18 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, false)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_20 = arg_415_1:GetWordFromCfg(319881095)
				local var_418_21 = arg_415_1:FormatText(var_418_20.content)

				arg_415_1.text_.text = var_418_21

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_22 = 29
				local var_418_23 = utf8.len(var_418_21)
				local var_418_24 = var_418_22 <= 0 and var_418_19 or var_418_19 * (var_418_23 / var_418_22)

				if var_418_24 > 0 and var_418_19 < var_418_24 then
					arg_415_1.talkMaxDuration = var_418_24

					if var_418_24 + var_418_18 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_24 + var_418_18
					end
				end

				arg_415_1.text_.text = var_418_21
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_25 = math.max(var_418_19, arg_415_1.talkMaxDuration)

			if var_418_18 <= arg_415_1.time_ and arg_415_1.time_ < var_418_18 + var_418_25 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_18) / var_418_25

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_18 + var_418_25 and arg_415_1.time_ < var_418_18 + var_418_25 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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

		arg_415_1:InitPlayNodeList()
	end,
	Play319881096 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 319881096
		arg_419_1.duration_ = 5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play319881097(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0
			local var_422_1 = 0.85

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_2 = arg_419_1:GetWordFromCfg(319881096)
				local var_422_3 = arg_419_1:FormatText(var_422_2.content)

				arg_419_1.text_.text = var_422_3

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_4 = 34
				local var_422_5 = utf8.len(var_422_3)
				local var_422_6 = var_422_4 <= 0 and var_422_1 or var_422_1 * (var_422_5 / var_422_4)

				if var_422_6 > 0 and var_422_1 < var_422_6 then
					arg_419_1.talkMaxDuration = var_422_6

					if var_422_6 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_6 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_3
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_7 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_7 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_7

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_7 and arg_419_1.time_ < var_422_0 + var_422_7 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play319881097 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 319881097
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
			arg_423_1.auto_ = false
		end

		function arg_423_1.playNext_(arg_425_0)
			arg_423_1.onStoryFinished_()
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0
			local var_426_1 = 1.25

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_2 = arg_423_1:GetWordFromCfg(319881097)
				local var_426_3 = arg_423_1:FormatText(var_426_2.content)

				arg_423_1.text_.text = var_426_3

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_4 = 50
				local var_426_5 = utf8.len(var_426_3)
				local var_426_6 = var_426_4 <= 0 and var_426_1 or var_426_1 * (var_426_5 / var_426_4)

				if var_426_6 > 0 and var_426_1 < var_426_6 then
					arg_423_1.talkMaxDuration = var_426_6

					if var_426_6 + var_426_0 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_6 + var_426_0
					end
				end

				arg_423_1.text_.text = var_426_3
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_7 = math.max(var_426_1, arg_423_1.talkMaxDuration)

			if var_426_0 <= arg_423_1.time_ and arg_423_1.time_ < var_426_0 + var_426_7 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_0) / var_426_7

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_0 + var_426_7 and arg_423_1.time_ < var_426_0 + var_426_7 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST70a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ML0206",
		"TextureConfig/Background/XH0407a"
	},
	voices = {
		"story_v_out_319881.awb"
	}
}
