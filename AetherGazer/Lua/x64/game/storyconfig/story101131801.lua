return {
	Play113181001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113181001
		arg_1_1.duration_ = 8.67

		local var_1_0 = {
			ja = 8.566,
			ko = 8.666,
			zh = 7.8,
			en = 8.3
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
				arg_1_0:Play113181002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F04"

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
				local var_4_5 = arg_1_1.bgs_.F04

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
					if iter_4_0 ~= "F04" then
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

			local var_4_22 = "1084ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1084ui_story"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(-0.7, -0.97, -6)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = 1.8

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_4_38 = arg_1_1.actors_["1084ui_story"]
			local var_4_39 = 1.8

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.2

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_42 = 0
			local var_4_43 = 1

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

			local var_4_48 = 2
			local var_4_49 = 1

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor")

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
			local var_4_55 = 0.575

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

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(113181001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181001", "story_v_out_113181.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_out_113181", "113181001", "story_v_out_113181.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_out_113181", "113181001", "story_v_out_113181.awb")

						arg_1_1:RecordAudio("113181001", var_4_64)
						arg_1_1:RecordAudio("113181001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113181", "113181001", "story_v_out_113181.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113181", "113181001", "story_v_out_113181.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play113181002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 113181002
		arg_9_1.duration_ = 13.3

		local var_9_0 = {
			ja = 9.133,
			ko = 9.833,
			zh = 9.066,
			en = 13.3
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
				arg_9_0:Play113181003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1038ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_9_1.stage_.transform)

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

			local var_12_5 = 0

			if var_12_5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_12_7 = arg_9_1.actors_["1038ui_story"]
			local var_12_8 = 0

			if var_12_8 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.characterEffect1038ui_story == nil then
				arg_9_1.var_.characterEffect1038ui_story = var_12_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_9 = 0.2

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_9 and not isNil(var_12_7) then
				local var_12_10 = (arg_9_1.time_ - var_12_8) / var_12_9

				if arg_9_1.var_.characterEffect1038ui_story and not isNil(var_12_7) then
					arg_9_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_8 + var_12_9 and arg_9_1.time_ < var_12_8 + var_12_9 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.characterEffect1038ui_story then
				arg_9_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_12_11 = arg_9_1.actors_["1038ui_story"].transform
			local var_12_12 = 0

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.var_.moveOldPos1038ui_story = var_12_11.localPosition
			end

			local var_12_13 = 0.001

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_13 then
				local var_12_14 = (arg_9_1.time_ - var_12_12) / var_12_13
				local var_12_15 = Vector3.New(0.7, -1.11, -5.9)

				var_12_11.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1038ui_story, var_12_15, var_12_14)

				local var_12_16 = manager.ui.mainCamera.transform.position - var_12_11.position

				var_12_11.forward = Vector3.New(var_12_16.x, var_12_16.y, var_12_16.z)

				local var_12_17 = var_12_11.localEulerAngles

				var_12_17.z = 0
				var_12_17.x = 0
				var_12_11.localEulerAngles = var_12_17
			end

			if arg_9_1.time_ >= var_12_12 + var_12_13 and arg_9_1.time_ < var_12_12 + var_12_13 + arg_12_0 then
				var_12_11.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_12_18 = manager.ui.mainCamera.transform.position - var_12_11.position

				var_12_11.forward = Vector3.New(var_12_18.x, var_12_18.y, var_12_18.z)

				local var_12_19 = var_12_11.localEulerAngles

				var_12_19.z = 0
				var_12_19.x = 0
				var_12_11.localEulerAngles = var_12_19
			end

			local var_12_20 = arg_9_1.actors_["1084ui_story"]
			local var_12_21 = 0

			if var_12_21 < arg_9_1.time_ and arg_9_1.time_ <= var_12_21 + arg_12_0 and not isNil(var_12_20) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = var_12_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_22 = 0.2

			if var_12_21 <= arg_9_1.time_ and arg_9_1.time_ < var_12_21 + var_12_22 and not isNil(var_12_20) then
				local var_12_23 = (arg_9_1.time_ - var_12_21) / var_12_22

				if arg_9_1.var_.characterEffect1084ui_story and not isNil(var_12_20) then
					local var_12_24 = Mathf.Lerp(0, 0.5, var_12_23)

					arg_9_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1084ui_story.fillRatio = var_12_24
				end
			end

			if arg_9_1.time_ >= var_12_21 + var_12_22 and arg_9_1.time_ < var_12_21 + var_12_22 + arg_12_0 and not isNil(var_12_20) and arg_9_1.var_.characterEffect1084ui_story then
				local var_12_25 = 0.5

				arg_9_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1084ui_story.fillRatio = var_12_25
			end

			local var_12_26 = 0
			local var_12_27 = 1.075

			if var_12_26 < arg_9_1.time_ and arg_9_1.time_ <= var_12_26 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_28 = arg_9_1:FormatText(StoryNameCfg[94].name)

				arg_9_1.leftNameTxt_.text = var_12_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_29 = arg_9_1:GetWordFromCfg(113181002)
				local var_12_30 = arg_9_1:FormatText(var_12_29.content)

				arg_9_1.text_.text = var_12_30

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_31 = 43
				local var_12_32 = utf8.len(var_12_30)
				local var_12_33 = var_12_31 <= 0 and var_12_27 or var_12_27 * (var_12_32 / var_12_31)

				if var_12_33 > 0 and var_12_27 < var_12_33 then
					arg_9_1.talkMaxDuration = var_12_33

					if var_12_33 + var_12_26 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_33 + var_12_26
					end
				end

				arg_9_1.text_.text = var_12_30
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181002", "story_v_out_113181.awb") ~= 0 then
					local var_12_34 = manager.audio:GetVoiceLength("story_v_out_113181", "113181002", "story_v_out_113181.awb") / 1000

					if var_12_34 + var_12_26 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_34 + var_12_26
					end

					if var_12_29.prefab_name ~= "" and arg_9_1.actors_[var_12_29.prefab_name] ~= nil then
						local var_12_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_29.prefab_name].transform, "story_v_out_113181", "113181002", "story_v_out_113181.awb")

						arg_9_1:RecordAudio("113181002", var_12_35)
						arg_9_1:RecordAudio("113181002", var_12_35)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_113181", "113181002", "story_v_out_113181.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_113181", "113181002", "story_v_out_113181.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_36 = math.max(var_12_27, arg_9_1.talkMaxDuration)

			if var_12_26 <= arg_9_1.time_ and arg_9_1.time_ < var_12_26 + var_12_36 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_26) / var_12_36

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_26 + var_12_36 and arg_9_1.time_ < var_12_26 + var_12_36 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play113181003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 113181003
		arg_13_1.duration_ = 9.87

		local var_13_0 = {
			ja = 9.866,
			ko = 7.2,
			zh = 8.033,
			en = 9.766
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
				arg_13_0:Play113181004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_16_1 = 0
			local var_16_2 = 0.875

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_3 = arg_13_1:FormatText(StoryNameCfg[94].name)

				arg_13_1.leftNameTxt_.text = var_16_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_4 = arg_13_1:GetWordFromCfg(113181003)
				local var_16_5 = arg_13_1:FormatText(var_16_4.content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_6 = 35
				local var_16_7 = utf8.len(var_16_5)
				local var_16_8 = var_16_6 <= 0 and var_16_2 or var_16_2 * (var_16_7 / var_16_6)

				if var_16_8 > 0 and var_16_2 < var_16_8 then
					arg_13_1.talkMaxDuration = var_16_8

					if var_16_8 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181003", "story_v_out_113181.awb") ~= 0 then
					local var_16_9 = manager.audio:GetVoiceLength("story_v_out_113181", "113181003", "story_v_out_113181.awb") / 1000

					if var_16_9 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_1
					end

					if var_16_4.prefab_name ~= "" and arg_13_1.actors_[var_16_4.prefab_name] ~= nil then
						local var_16_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_4.prefab_name].transform, "story_v_out_113181", "113181003", "story_v_out_113181.awb")

						arg_13_1:RecordAudio("113181003", var_16_10)
						arg_13_1:RecordAudio("113181003", var_16_10)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_113181", "113181003", "story_v_out_113181.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_113181", "113181003", "story_v_out_113181.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_11 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_11 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_11

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_11 and arg_13_1.time_ < var_16_1 + var_16_11 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play113181004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 113181004
		arg_17_1.duration_ = 8.07

		local var_17_0 = {
			ja = 4.5,
			ko = 5.8,
			zh = 7.066,
			en = 8.066
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
				arg_17_0:Play113181005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1038ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1038ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1038ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, 100, 0)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1084ui_story"].transform
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.var_.moveOldPos1084ui_story = var_20_9.localPosition
			end

			local var_20_11 = 0.001

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11
				local var_20_13 = Vector3.New(0, 100, 0)

				var_20_9.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1084ui_story, var_20_13, var_20_12)

				local var_20_14 = manager.ui.mainCamera.transform.position - var_20_9.position

				var_20_9.forward = Vector3.New(var_20_14.x, var_20_14.y, var_20_14.z)

				local var_20_15 = var_20_9.localEulerAngles

				var_20_15.z = 0
				var_20_15.x = 0
				var_20_9.localEulerAngles = var_20_15
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 then
				var_20_9.localPosition = Vector3.New(0, 100, 0)

				local var_20_16 = manager.ui.mainCamera.transform.position - var_20_9.position

				var_20_9.forward = Vector3.New(var_20_16.x, var_20_16.y, var_20_16.z)

				local var_20_17 = var_20_9.localEulerAngles

				var_20_17.z = 0
				var_20_17.x = 0
				var_20_9.localEulerAngles = var_20_17
			end

			local var_20_18 = "1097ui_story"

			if arg_17_1.actors_[var_20_18] == nil then
				local var_20_19 = Asset.Load("Char/" .. "1097ui_story")

				if not isNil(var_20_19) then
					local var_20_20 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_17_1.stage_.transform)

					var_20_20.name = var_20_18
					var_20_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_17_1.actors_[var_20_18] = var_20_20

					local var_20_21 = var_20_20:GetComponentInChildren(typeof(CharacterEffect))

					var_20_21.enabled = true

					local var_20_22 = GameObjectTools.GetOrAddComponent(var_20_20, typeof(DynamicBoneHelper))

					if var_20_22 then
						var_20_22:EnableDynamicBone(false)
					end

					arg_17_1:ShowWeapon(var_20_21.transform, false)

					arg_17_1.var_[var_20_18 .. "Animator"] = var_20_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_17_1.var_[var_20_18 .. "Animator"].applyRootMotion = true
					arg_17_1.var_[var_20_18 .. "LipSync"] = var_20_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_20_23 = arg_17_1.actors_["1097ui_story"].transform
			local var_20_24 = 0

			if var_20_24 < arg_17_1.time_ and arg_17_1.time_ <= var_20_24 + arg_20_0 then
				arg_17_1.var_.moveOldPos1097ui_story = var_20_23.localPosition
			end

			local var_20_25 = 0.001

			if var_20_24 <= arg_17_1.time_ and arg_17_1.time_ < var_20_24 + var_20_25 then
				local var_20_26 = (arg_17_1.time_ - var_20_24) / var_20_25
				local var_20_27 = Vector3.New(-0.7, -0.54, -6.3)

				var_20_23.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1097ui_story, var_20_27, var_20_26)

				local var_20_28 = manager.ui.mainCamera.transform.position - var_20_23.position

				var_20_23.forward = Vector3.New(var_20_28.x, var_20_28.y, var_20_28.z)

				local var_20_29 = var_20_23.localEulerAngles

				var_20_29.z = 0
				var_20_29.x = 0
				var_20_23.localEulerAngles = var_20_29
			end

			if arg_17_1.time_ >= var_20_24 + var_20_25 and arg_17_1.time_ < var_20_24 + var_20_25 + arg_20_0 then
				var_20_23.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_20_30 = manager.ui.mainCamera.transform.position - var_20_23.position

				var_20_23.forward = Vector3.New(var_20_30.x, var_20_30.y, var_20_30.z)

				local var_20_31 = var_20_23.localEulerAngles

				var_20_31.z = 0
				var_20_31.x = 0
				var_20_23.localEulerAngles = var_20_31
			end

			local var_20_32 = 0

			if var_20_32 < arg_17_1.time_ and arg_17_1.time_ <= var_20_32 + arg_20_0 then
				arg_17_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action4_1")
			end

			local var_20_33 = 0

			if var_20_33 < arg_17_1.time_ and arg_17_1.time_ <= var_20_33 + arg_20_0 then
				arg_17_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_20_34 = arg_17_1.actors_["1097ui_story"]
			local var_20_35 = 0

			if var_20_35 < arg_17_1.time_ and arg_17_1.time_ <= var_20_35 + arg_20_0 and not isNil(var_20_34) and arg_17_1.var_.characterEffect1097ui_story == nil then
				arg_17_1.var_.characterEffect1097ui_story = var_20_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_36 = 0.2

			if var_20_35 <= arg_17_1.time_ and arg_17_1.time_ < var_20_35 + var_20_36 and not isNil(var_20_34) then
				local var_20_37 = (arg_17_1.time_ - var_20_35) / var_20_36

				if arg_17_1.var_.characterEffect1097ui_story and not isNil(var_20_34) then
					arg_17_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_35 + var_20_36 and arg_17_1.time_ < var_20_35 + var_20_36 + arg_20_0 and not isNil(var_20_34) and arg_17_1.var_.characterEffect1097ui_story then
				arg_17_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_20_38 = 0
			local var_20_39 = 0.35

			if var_20_38 < arg_17_1.time_ and arg_17_1.time_ <= var_20_38 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_40 = arg_17_1:FormatText(StoryNameCfg[216].name)

				arg_17_1.leftNameTxt_.text = var_20_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_41 = arg_17_1:GetWordFromCfg(113181004)
				local var_20_42 = arg_17_1:FormatText(var_20_41.content)

				arg_17_1.text_.text = var_20_42

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_43 = 14
				local var_20_44 = utf8.len(var_20_42)
				local var_20_45 = var_20_43 <= 0 and var_20_39 or var_20_39 * (var_20_44 / var_20_43)

				if var_20_45 > 0 and var_20_39 < var_20_45 then
					arg_17_1.talkMaxDuration = var_20_45

					if var_20_45 + var_20_38 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_45 + var_20_38
					end
				end

				arg_17_1.text_.text = var_20_42
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181004", "story_v_out_113181.awb") ~= 0 then
					local var_20_46 = manager.audio:GetVoiceLength("story_v_out_113181", "113181004", "story_v_out_113181.awb") / 1000

					if var_20_46 + var_20_38 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_46 + var_20_38
					end

					if var_20_41.prefab_name ~= "" and arg_17_1.actors_[var_20_41.prefab_name] ~= nil then
						local var_20_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_41.prefab_name].transform, "story_v_out_113181", "113181004", "story_v_out_113181.awb")

						arg_17_1:RecordAudio("113181004", var_20_47)
						arg_17_1:RecordAudio("113181004", var_20_47)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_113181", "113181004", "story_v_out_113181.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_113181", "113181004", "story_v_out_113181.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_48 = math.max(var_20_39, arg_17_1.talkMaxDuration)

			if var_20_38 <= arg_17_1.time_ and arg_17_1.time_ < var_20_38 + var_20_48 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_38) / var_20_48

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_38 + var_20_48 and arg_17_1.time_ < var_20_38 + var_20_48 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play113181005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 113181005
		arg_21_1.duration_ = 3.4

		local var_21_0 = {
			ja = 3.4,
			ko = 1.999999999999,
			zh = 2.933,
			en = 2.033
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
				arg_21_0:Play113181006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "6046_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "6046_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_21_1.stage_.transform)

					var_24_2.name = var_24_0
					var_24_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_21_1.actors_[var_24_0] = var_24_2

					local var_24_3 = var_24_2:GetComponentInChildren(typeof(CharacterEffect))

					var_24_3.enabled = true

					local var_24_4 = GameObjectTools.GetOrAddComponent(var_24_2, typeof(DynamicBoneHelper))

					if var_24_4 then
						var_24_4:EnableDynamicBone(false)
					end

					arg_21_1:ShowWeapon(var_24_3.transform, false)

					arg_21_1.var_[var_24_0 .. "Animator"] = var_24_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_21_1.var_[var_24_0 .. "Animator"].applyRootMotion = true
					arg_21_1.var_[var_24_0 .. "LipSync"] = var_24_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_24_5 = 0

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_24_7 = arg_21_1.actors_["6046_story"]
			local var_24_8 = 0

			if var_24_8 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.characterEffect6046_story == nil then
				arg_21_1.var_.characterEffect6046_story = var_24_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_9 = 0.2

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_9 and not isNil(var_24_7) then
				local var_24_10 = (arg_21_1.time_ - var_24_8) / var_24_9

				if arg_21_1.var_.characterEffect6046_story and not isNil(var_24_7) then
					arg_21_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_8 + var_24_9 and arg_21_1.time_ < var_24_8 + var_24_9 + arg_24_0 and not isNil(var_24_7) and arg_21_1.var_.characterEffect6046_story then
				arg_21_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_24_11 = arg_21_1.actors_["6046_story"].transform
			local var_24_12 = 0

			if var_24_12 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.var_.moveOldPos6046_story = var_24_11.localPosition

				local var_24_13 = GameObjectTools.GetOrAddComponent(var_24_11.gameObject, typeof(DynamicBoneHelper))

				if var_24_13 then
					var_24_13:EnableDynamicBone(false)
				end
			end

			local var_24_14 = 0.001

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_14 then
				local var_24_15 = (arg_21_1.time_ - var_24_12) / var_24_14
				local var_24_16 = Vector3.New(0.7, -0.5, -6.3)

				var_24_11.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos6046_story, var_24_16, var_24_15)

				local var_24_17 = manager.ui.mainCamera.transform.position - var_24_11.position

				var_24_11.forward = Vector3.New(var_24_17.x, var_24_17.y, var_24_17.z)

				local var_24_18 = var_24_11.localEulerAngles

				var_24_18.z = 0
				var_24_18.x = 0
				var_24_11.localEulerAngles = var_24_18
			end

			if arg_21_1.time_ >= var_24_12 + var_24_14 and arg_21_1.time_ < var_24_12 + var_24_14 + arg_24_0 then
				var_24_11.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_24_19 = manager.ui.mainCamera.transform.position - var_24_11.position

				var_24_11.forward = Vector3.New(var_24_19.x, var_24_19.y, var_24_19.z)

				local var_24_20 = var_24_11.localEulerAngles

				var_24_20.z = 0
				var_24_20.x = 0
				var_24_11.localEulerAngles = var_24_20

				local var_24_21 = GameObjectTools.GetOrAddComponent(var_24_11.gameObject, typeof(DynamicBoneHelper))

				if var_24_21 then
					var_24_21:EnableDynamicBone(true)
				end
			end

			local var_24_22 = arg_21_1.actors_["1097ui_story"]
			local var_24_23 = 0

			if var_24_23 < arg_21_1.time_ and arg_21_1.time_ <= var_24_23 + arg_24_0 and not isNil(var_24_22) and arg_21_1.var_.characterEffect1097ui_story == nil then
				arg_21_1.var_.characterEffect1097ui_story = var_24_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_24 = 0.2

			if var_24_23 <= arg_21_1.time_ and arg_21_1.time_ < var_24_23 + var_24_24 and not isNil(var_24_22) then
				local var_24_25 = (arg_21_1.time_ - var_24_23) / var_24_24

				if arg_21_1.var_.characterEffect1097ui_story and not isNil(var_24_22) then
					local var_24_26 = Mathf.Lerp(0, 0.5, var_24_25)

					arg_21_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1097ui_story.fillRatio = var_24_26
				end
			end

			if arg_21_1.time_ >= var_24_23 + var_24_24 and arg_21_1.time_ < var_24_23 + var_24_24 + arg_24_0 and not isNil(var_24_22) and arg_21_1.var_.characterEffect1097ui_story then
				local var_24_27 = 0.5

				arg_21_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1097ui_story.fillRatio = var_24_27
			end

			local var_24_28 = 0

			if var_24_28 < arg_21_1.time_ and arg_21_1.time_ <= var_24_28 + arg_24_0 then
				arg_21_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action4_2")
			end

			local var_24_29 = 0

			if var_24_29 < arg_21_1.time_ and arg_21_1.time_ <= var_24_29 + arg_24_0 then
				arg_21_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_24_30 = 0
			local var_24_31 = 0.2

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_32 = arg_21_1:FormatText(StoryNameCfg[214].name)

				arg_21_1.leftNameTxt_.text = var_24_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_33 = arg_21_1:GetWordFromCfg(113181005)
				local var_24_34 = arg_21_1:FormatText(var_24_33.content)

				arg_21_1.text_.text = var_24_34

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_35 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181005", "story_v_out_113181.awb") ~= 0 then
					local var_24_38 = manager.audio:GetVoiceLength("story_v_out_113181", "113181005", "story_v_out_113181.awb") / 1000

					if var_24_38 + var_24_30 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_38 + var_24_30
					end

					if var_24_33.prefab_name ~= "" and arg_21_1.actors_[var_24_33.prefab_name] ~= nil then
						local var_24_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_33.prefab_name].transform, "story_v_out_113181", "113181005", "story_v_out_113181.awb")

						arg_21_1:RecordAudio("113181005", var_24_39)
						arg_21_1:RecordAudio("113181005", var_24_39)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_113181", "113181005", "story_v_out_113181.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_113181", "113181005", "story_v_out_113181.awb")
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
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play113181006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 113181006
		arg_25_1.duration_ = 8.3

		local var_25_0 = {
			ja = 6.966,
			ko = 8.3,
			zh = 6.233,
			en = 4.5
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
				arg_25_0:Play113181007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["6046_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect6046_story == nil then
				arg_25_1.var_.characterEffect6046_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.2

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect6046_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect6046_story.fillFlat = true
					arg_25_1.var_.characterEffect6046_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect6046_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect6046_story.fillFlat = true
				arg_25_1.var_.characterEffect6046_story.fillRatio = var_28_5
			end

			local var_28_6 = 0
			local var_28_7 = 0.55

			if var_28_6 < arg_25_1.time_ and arg_25_1.time_ <= var_28_6 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_8 = arg_25_1:FormatText(StoryNameCfg[215].name)

				arg_25_1.leftNameTxt_.text = var_28_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_9 = arg_25_1:GetWordFromCfg(113181006)
				local var_28_10 = arg_25_1:FormatText(var_28_9.content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_11 = 22
				local var_28_12 = utf8.len(var_28_10)
				local var_28_13 = var_28_11 <= 0 and var_28_7 or var_28_7 * (var_28_12 / var_28_11)

				if var_28_13 > 0 and var_28_7 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_6
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181006", "story_v_out_113181.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_113181", "113181006", "story_v_out_113181.awb") / 1000

					if var_28_14 + var_28_6 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_6
					end

					if var_28_9.prefab_name ~= "" and arg_25_1.actors_[var_28_9.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_9.prefab_name].transform, "story_v_out_113181", "113181006", "story_v_out_113181.awb")

						arg_25_1:RecordAudio("113181006", var_28_15)
						arg_25_1:RecordAudio("113181006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_113181", "113181006", "story_v_out_113181.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_113181", "113181006", "story_v_out_113181.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_7, arg_25_1.talkMaxDuration)

			if var_28_6 <= arg_25_1.time_ and arg_25_1.time_ < var_28_6 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_6) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_6 + var_28_16 and arg_25_1.time_ < var_28_6 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play113181007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 113181007
		arg_29_1.duration_ = 7.33

		local var_29_0 = {
			ja = 4.9,
			ko = 7.333,
			zh = 7.266,
			en = 6.8
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
				arg_29_0:Play113181008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1097ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1097ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1097ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = 0

			if var_32_9 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_32_11 = arg_29_1.actors_["1097ui_story"]
			local var_32_12 = 0

			if var_32_12 < arg_29_1.time_ and arg_29_1.time_ <= var_32_12 + arg_32_0 and not isNil(var_32_11) and arg_29_1.var_.characterEffect1097ui_story == nil then
				arg_29_1.var_.characterEffect1097ui_story = var_32_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_13 = 0.2

			if var_32_12 <= arg_29_1.time_ and arg_29_1.time_ < var_32_12 + var_32_13 and not isNil(var_32_11) then
				local var_32_14 = (arg_29_1.time_ - var_32_12) / var_32_13

				if arg_29_1.var_.characterEffect1097ui_story and not isNil(var_32_11) then
					arg_29_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_12 + var_32_13 and arg_29_1.time_ < var_32_12 + var_32_13 + arg_32_0 and not isNil(var_32_11) and arg_29_1.var_.characterEffect1097ui_story then
				arg_29_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_32_15 = 0
			local var_32_16 = 0.5

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_17 = arg_29_1:FormatText(StoryNameCfg[216].name)

				arg_29_1.leftNameTxt_.text = var_32_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(113181007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_20 = 20
				local var_32_21 = utf8.len(var_32_19)
				local var_32_22 = var_32_20 <= 0 and var_32_16 or var_32_16 * (var_32_21 / var_32_20)

				if var_32_22 > 0 and var_32_16 < var_32_22 then
					arg_29_1.talkMaxDuration = var_32_22

					if var_32_22 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_22 + var_32_15
					end
				end

				arg_29_1.text_.text = var_32_19
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181007", "story_v_out_113181.awb") ~= 0 then
					local var_32_23 = manager.audio:GetVoiceLength("story_v_out_113181", "113181007", "story_v_out_113181.awb") / 1000

					if var_32_23 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_15
					end

					if var_32_18.prefab_name ~= "" and arg_29_1.actors_[var_32_18.prefab_name] ~= nil then
						local var_32_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_18.prefab_name].transform, "story_v_out_113181", "113181007", "story_v_out_113181.awb")

						arg_29_1:RecordAudio("113181007", var_32_24)
						arg_29_1:RecordAudio("113181007", var_32_24)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_113181", "113181007", "story_v_out_113181.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_113181", "113181007", "story_v_out_113181.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_25 = math.max(var_32_16, arg_29_1.talkMaxDuration)

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_25 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_15) / var_32_25

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_15 + var_32_25 and arg_29_1.time_ < var_32_15 + var_32_25 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play113181008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 113181008
		arg_33_1.duration_ = 2

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play113181009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_36_1 = 0
			local var_36_2 = 1

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				local var_36_3 = "play"
				local var_36_4 = "music"

				arg_33_1:AudioAction(var_36_3, var_36_4, "ui_battle", "ui_battle_stopbgm", "")

				local var_36_5 = ""
				local var_36_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_36_6 ~= "" then
					if arg_33_1.bgmTxt_.text ~= var_36_6 and arg_33_1.bgmTxt_.text ~= "" then
						if arg_33_1.bgmTxt2_.text ~= "" then
							arg_33_1.bgmTxt_.text = arg_33_1.bgmTxt2_.text
						end

						arg_33_1.bgmTxt2_.text = var_36_6

						arg_33_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_33_1.bgmTxt_.text = var_36_6
						arg_33_1.bgmTxt2_.text = var_36_6
					end

					if arg_33_1.bgmTimer then
						arg_33_1.bgmTimer:Stop()

						arg_33_1.bgmTimer = nil
					end

					if arg_33_1.settingData.show_music_name == 1 then
						arg_33_1.musicController:SetSelectedState("show")
						arg_33_1.musicAnimator_:Play("open", 0, 0)

						if arg_33_1.settingData.music_time ~= 0 then
							arg_33_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_33_1.settingData.music_time), function()
								if arg_33_1 == nil or isNil(arg_33_1.bgmTxt_) then
									return
								end

								arg_33_1.musicController:SetSelectedState("hide")
								arg_33_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_36_7 = 0
			local var_36_8 = 0.1

			if var_36_7 < arg_33_1.time_ and arg_33_1.time_ <= var_36_7 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_9 = arg_33_1:FormatText(StoryNameCfg[216].name)

				arg_33_1.leftNameTxt_.text = var_36_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_10 = arg_33_1:GetWordFromCfg(113181008)
				local var_36_11 = arg_33_1:FormatText(var_36_10.content)

				arg_33_1.text_.text = var_36_11

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_12 = 4
				local var_36_13 = utf8.len(var_36_11)
				local var_36_14 = var_36_12 <= 0 and var_36_8 or var_36_8 * (var_36_13 / var_36_12)

				if var_36_14 > 0 and var_36_8 < var_36_14 then
					arg_33_1.talkMaxDuration = var_36_14

					if var_36_14 + var_36_7 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_7
					end
				end

				arg_33_1.text_.text = var_36_11
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181008", "story_v_out_113181.awb") ~= 0 then
					local var_36_15 = manager.audio:GetVoiceLength("story_v_out_113181", "113181008", "story_v_out_113181.awb") / 1000

					if var_36_15 + var_36_7 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_15 + var_36_7
					end

					if var_36_10.prefab_name ~= "" and arg_33_1.actors_[var_36_10.prefab_name] ~= nil then
						local var_36_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_10.prefab_name].transform, "story_v_out_113181", "113181008", "story_v_out_113181.awb")

						arg_33_1:RecordAudio("113181008", var_36_16)
						arg_33_1:RecordAudio("113181008", var_36_16)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_113181", "113181008", "story_v_out_113181.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_113181", "113181008", "story_v_out_113181.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_17 = math.max(var_36_8, arg_33_1.talkMaxDuration)

			if var_36_7 <= arg_33_1.time_ and arg_33_1.time_ < var_36_7 + var_36_17 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_7) / var_36_17

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_7 + var_36_17 and arg_33_1.time_ < var_36_7 + var_36_17 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play113181009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 113181009
		arg_38_1.duration_ = 2

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play113181010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0

			if var_41_0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_0 + arg_41_0 then
				arg_38_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_41_2 = arg_38_1.actors_["6046_story"]
			local var_41_3 = 0

			if var_41_3 < arg_38_1.time_ and arg_38_1.time_ <= var_41_3 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.characterEffect6046_story == nil then
				arg_38_1.var_.characterEffect6046_story = var_41_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_4 = 0.2

			if var_41_3 <= arg_38_1.time_ and arg_38_1.time_ < var_41_3 + var_41_4 and not isNil(var_41_2) then
				local var_41_5 = (arg_38_1.time_ - var_41_3) / var_41_4

				if arg_38_1.var_.characterEffect6046_story and not isNil(var_41_2) then
					arg_38_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_3 + var_41_4 and arg_38_1.time_ < var_41_3 + var_41_4 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.characterEffect6046_story then
				arg_38_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_41_6 = arg_38_1.actors_["1097ui_story"]
			local var_41_7 = 0

			if var_41_7 < arg_38_1.time_ and arg_38_1.time_ <= var_41_7 + arg_41_0 and not isNil(var_41_6) and arg_38_1.var_.characterEffect1097ui_story == nil then
				arg_38_1.var_.characterEffect1097ui_story = var_41_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_8 = 0.2

			if var_41_7 <= arg_38_1.time_ and arg_38_1.time_ < var_41_7 + var_41_8 and not isNil(var_41_6) then
				local var_41_9 = (arg_38_1.time_ - var_41_7) / var_41_8

				if arg_38_1.var_.characterEffect1097ui_story and not isNil(var_41_6) then
					local var_41_10 = Mathf.Lerp(0, 0.5, var_41_9)

					arg_38_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1097ui_story.fillRatio = var_41_10
				end
			end

			if arg_38_1.time_ >= var_41_7 + var_41_8 and arg_38_1.time_ < var_41_7 + var_41_8 + arg_41_0 and not isNil(var_41_6) and arg_38_1.var_.characterEffect1097ui_story then
				local var_41_11 = 0.5

				arg_38_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1097ui_story.fillRatio = var_41_11
			end

			local var_41_12 = 0
			local var_41_13 = 0.175

			if var_41_12 < arg_38_1.time_ and arg_38_1.time_ <= var_41_12 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_14 = arg_38_1:FormatText(StoryNameCfg[214].name)

				arg_38_1.leftNameTxt_.text = var_41_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_15 = arg_38_1:GetWordFromCfg(113181009)
				local var_41_16 = arg_38_1:FormatText(var_41_15.content)

				arg_38_1.text_.text = var_41_16

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_17 = 7
				local var_41_18 = utf8.len(var_41_16)
				local var_41_19 = var_41_17 <= 0 and var_41_13 or var_41_13 * (var_41_18 / var_41_17)

				if var_41_19 > 0 and var_41_13 < var_41_19 then
					arg_38_1.talkMaxDuration = var_41_19

					if var_41_19 + var_41_12 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_19 + var_41_12
					end
				end

				arg_38_1.text_.text = var_41_16
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181009", "story_v_out_113181.awb") ~= 0 then
					local var_41_20 = manager.audio:GetVoiceLength("story_v_out_113181", "113181009", "story_v_out_113181.awb") / 1000

					if var_41_20 + var_41_12 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_20 + var_41_12
					end

					if var_41_15.prefab_name ~= "" and arg_38_1.actors_[var_41_15.prefab_name] ~= nil then
						local var_41_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_15.prefab_name].transform, "story_v_out_113181", "113181009", "story_v_out_113181.awb")

						arg_38_1:RecordAudio("113181009", var_41_21)
						arg_38_1:RecordAudio("113181009", var_41_21)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_113181", "113181009", "story_v_out_113181.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_113181", "113181009", "story_v_out_113181.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_22 = math.max(var_41_13, arg_38_1.talkMaxDuration)

			if var_41_12 <= arg_38_1.time_ and arg_38_1.time_ < var_41_12 + var_41_22 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_12) / var_41_22

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_12 + var_41_22 and arg_38_1.time_ < var_41_12 + var_41_22 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play113181010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 113181010
		arg_42_1.duration_ = 2.57

		local var_42_0 = {
			ja = 2.566,
			ko = 2.2,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_42_0:Play113181011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_45_1 = arg_42_1.actors_["1097ui_story"]
			local var_45_2 = 0

			if var_45_2 < arg_42_1.time_ and arg_42_1.time_ <= var_45_2 + arg_45_0 and not isNil(var_45_1) and arg_42_1.var_.characterEffect1097ui_story == nil then
				arg_42_1.var_.characterEffect1097ui_story = var_45_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_3 = 0.2

			if var_45_2 <= arg_42_1.time_ and arg_42_1.time_ < var_45_2 + var_45_3 and not isNil(var_45_1) then
				local var_45_4 = (arg_42_1.time_ - var_45_2) / var_45_3

				if arg_42_1.var_.characterEffect1097ui_story and not isNil(var_45_1) then
					arg_42_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_2 + var_45_3 and arg_42_1.time_ < var_45_2 + var_45_3 + arg_45_0 and not isNil(var_45_1) and arg_42_1.var_.characterEffect1097ui_story then
				arg_42_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_45_5 = arg_42_1.actors_["6046_story"]
			local var_45_6 = 0

			if var_45_6 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.characterEffect6046_story == nil then
				arg_42_1.var_.characterEffect6046_story = var_45_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_7 = 0.2

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_7 and not isNil(var_45_5) then
				local var_45_8 = (arg_42_1.time_ - var_45_6) / var_45_7

				if arg_42_1.var_.characterEffect6046_story and not isNil(var_45_5) then
					local var_45_9 = Mathf.Lerp(0, 0.5, var_45_8)

					arg_42_1.var_.characterEffect6046_story.fillFlat = true
					arg_42_1.var_.characterEffect6046_story.fillRatio = var_45_9
				end
			end

			if arg_42_1.time_ >= var_45_6 + var_45_7 and arg_42_1.time_ < var_45_6 + var_45_7 + arg_45_0 and not isNil(var_45_5) and arg_42_1.var_.characterEffect6046_story then
				local var_45_10 = 0.5

				arg_42_1.var_.characterEffect6046_story.fillFlat = true
				arg_42_1.var_.characterEffect6046_story.fillRatio = var_45_10
			end

			local var_45_11 = 0

			if var_45_11 < arg_42_1.time_ and arg_42_1.time_ <= var_45_11 + arg_45_0 then
				arg_42_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_45_12 = 0
			local var_45_13 = 0.125

			if var_45_12 < arg_42_1.time_ and arg_42_1.time_ <= var_45_12 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_14 = arg_42_1:FormatText(StoryNameCfg[216].name)

				arg_42_1.leftNameTxt_.text = var_45_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_15 = arg_42_1:GetWordFromCfg(113181010)
				local var_45_16 = arg_42_1:FormatText(var_45_15.content)

				arg_42_1.text_.text = var_45_16

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_17 = 5
				local var_45_18 = utf8.len(var_45_16)
				local var_45_19 = var_45_17 <= 0 and var_45_13 or var_45_13 * (var_45_18 / var_45_17)

				if var_45_19 > 0 and var_45_13 < var_45_19 then
					arg_42_1.talkMaxDuration = var_45_19

					if var_45_19 + var_45_12 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_19 + var_45_12
					end
				end

				arg_42_1.text_.text = var_45_16
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181010", "story_v_out_113181.awb") ~= 0 then
					local var_45_20 = manager.audio:GetVoiceLength("story_v_out_113181", "113181010", "story_v_out_113181.awb") / 1000

					if var_45_20 + var_45_12 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_20 + var_45_12
					end

					if var_45_15.prefab_name ~= "" and arg_42_1.actors_[var_45_15.prefab_name] ~= nil then
						local var_45_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_15.prefab_name].transform, "story_v_out_113181", "113181010", "story_v_out_113181.awb")

						arg_42_1:RecordAudio("113181010", var_45_21)
						arg_42_1:RecordAudio("113181010", var_45_21)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_113181", "113181010", "story_v_out_113181.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_113181", "113181010", "story_v_out_113181.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_22 = math.max(var_45_13, arg_42_1.talkMaxDuration)

			if var_45_12 <= arg_42_1.time_ and arg_42_1.time_ < var_45_12 + var_45_22 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_12) / var_45_22

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_12 + var_45_22 and arg_42_1.time_ < var_45_12 + var_45_22 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play113181011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 113181011
		arg_46_1.duration_ = 2.13

		local var_46_0 = {
			ja = 1.999999999999,
			ko = 2.1,
			zh = 2.1,
			en = 2.133
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
				arg_46_0:Play113181012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["6046_story"].transform
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.var_.moveOldPos6046_story = var_49_0.localPosition

				local var_49_2 = GameObjectTools.GetOrAddComponent(var_49_0.gameObject, typeof(DynamicBoneHelper))

				if var_49_2 then
					var_49_2:EnableDynamicBone(false)
				end
			end

			local var_49_3 = 0.001

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_3 then
				local var_49_4 = (arg_46_1.time_ - var_49_1) / var_49_3
				local var_49_5 = Vector3.New(0, 100, 0)

				var_49_0.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos6046_story, var_49_5, var_49_4)

				local var_49_6 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_6.x, var_49_6.y, var_49_6.z)

				local var_49_7 = var_49_0.localEulerAngles

				var_49_7.z = 0
				var_49_7.x = 0
				var_49_0.localEulerAngles = var_49_7
			end

			if arg_46_1.time_ >= var_49_1 + var_49_3 and arg_46_1.time_ < var_49_1 + var_49_3 + arg_49_0 then
				var_49_0.localPosition = Vector3.New(0, 100, 0)

				local var_49_8 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_8.x, var_49_8.y, var_49_8.z)

				local var_49_9 = var_49_0.localEulerAngles

				var_49_9.z = 0
				var_49_9.x = 0
				var_49_0.localEulerAngles = var_49_9

				local var_49_10 = GameObjectTools.GetOrAddComponent(var_49_0.gameObject, typeof(DynamicBoneHelper))

				if var_49_10 then
					var_49_10:EnableDynamicBone(true)
				end
			end

			local var_49_11 = arg_46_1.actors_["1038ui_story"].transform
			local var_49_12 = 0

			if var_49_12 < arg_46_1.time_ and arg_46_1.time_ <= var_49_12 + arg_49_0 then
				arg_46_1.var_.moveOldPos1038ui_story = var_49_11.localPosition
			end

			local var_49_13 = 0.001

			if var_49_12 <= arg_46_1.time_ and arg_46_1.time_ < var_49_12 + var_49_13 then
				local var_49_14 = (arg_46_1.time_ - var_49_12) / var_49_13
				local var_49_15 = Vector3.New(0.7, -1.11, -5.9)

				var_49_11.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1038ui_story, var_49_15, var_49_14)

				local var_49_16 = manager.ui.mainCamera.transform.position - var_49_11.position

				var_49_11.forward = Vector3.New(var_49_16.x, var_49_16.y, var_49_16.z)

				local var_49_17 = var_49_11.localEulerAngles

				var_49_17.z = 0
				var_49_17.x = 0
				var_49_11.localEulerAngles = var_49_17
			end

			if arg_46_1.time_ >= var_49_12 + var_49_13 and arg_46_1.time_ < var_49_12 + var_49_13 + arg_49_0 then
				var_49_11.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_49_18 = manager.ui.mainCamera.transform.position - var_49_11.position

				var_49_11.forward = Vector3.New(var_49_18.x, var_49_18.y, var_49_18.z)

				local var_49_19 = var_49_11.localEulerAngles

				var_49_19.z = 0
				var_49_19.x = 0
				var_49_11.localEulerAngles = var_49_19
			end

			local var_49_20 = 0

			if var_49_20 < arg_46_1.time_ and arg_46_1.time_ <= var_49_20 + arg_49_0 then
				arg_46_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_49_21 = 0

			if var_49_21 < arg_46_1.time_ and arg_46_1.time_ <= var_49_21 + arg_49_0 then
				arg_46_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_49_22 = arg_46_1.actors_["1038ui_story"]
			local var_49_23 = 0

			if var_49_23 < arg_46_1.time_ and arg_46_1.time_ <= var_49_23 + arg_49_0 and not isNil(var_49_22) and arg_46_1.var_.characterEffect1038ui_story == nil then
				arg_46_1.var_.characterEffect1038ui_story = var_49_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_24 = 0.2

			if var_49_23 <= arg_46_1.time_ and arg_46_1.time_ < var_49_23 + var_49_24 and not isNil(var_49_22) then
				local var_49_25 = (arg_46_1.time_ - var_49_23) / var_49_24

				if arg_46_1.var_.characterEffect1038ui_story and not isNil(var_49_22) then
					arg_46_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= var_49_23 + var_49_24 and arg_46_1.time_ < var_49_23 + var_49_24 + arg_49_0 and not isNil(var_49_22) and arg_46_1.var_.characterEffect1038ui_story then
				arg_46_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_49_26 = arg_46_1.actors_["1097ui_story"]
			local var_49_27 = 0

			if var_49_27 < arg_46_1.time_ and arg_46_1.time_ <= var_49_27 + arg_49_0 and not isNil(var_49_26) and arg_46_1.var_.characterEffect1097ui_story == nil then
				arg_46_1.var_.characterEffect1097ui_story = var_49_26:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_28 = 0.2

			if var_49_27 <= arg_46_1.time_ and arg_46_1.time_ < var_49_27 + var_49_28 and not isNil(var_49_26) then
				local var_49_29 = (arg_46_1.time_ - var_49_27) / var_49_28

				if arg_46_1.var_.characterEffect1097ui_story and not isNil(var_49_26) then
					local var_49_30 = Mathf.Lerp(0, 0.5, var_49_29)

					arg_46_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1097ui_story.fillRatio = var_49_30
				end
			end

			if arg_46_1.time_ >= var_49_27 + var_49_28 and arg_46_1.time_ < var_49_27 + var_49_28 + arg_49_0 and not isNil(var_49_26) and arg_46_1.var_.characterEffect1097ui_story then
				local var_49_31 = 0.5

				arg_46_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1097ui_story.fillRatio = var_49_31
			end

			local var_49_32 = 0
			local var_49_33 = 0.275

			if var_49_32 < arg_46_1.time_ and arg_46_1.time_ <= var_49_32 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_34 = arg_46_1:FormatText(StoryNameCfg[94].name)

				arg_46_1.leftNameTxt_.text = var_49_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_35 = arg_46_1:GetWordFromCfg(113181011)
				local var_49_36 = arg_46_1:FormatText(var_49_35.content)

				arg_46_1.text_.text = var_49_36

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_37 = 11
				local var_49_38 = utf8.len(var_49_36)
				local var_49_39 = var_49_37 <= 0 and var_49_33 or var_49_33 * (var_49_38 / var_49_37)

				if var_49_39 > 0 and var_49_33 < var_49_39 then
					arg_46_1.talkMaxDuration = var_49_39

					if var_49_39 + var_49_32 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_39 + var_49_32
					end
				end

				arg_46_1.text_.text = var_49_36
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181011", "story_v_out_113181.awb") ~= 0 then
					local var_49_40 = manager.audio:GetVoiceLength("story_v_out_113181", "113181011", "story_v_out_113181.awb") / 1000

					if var_49_40 + var_49_32 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_40 + var_49_32
					end

					if var_49_35.prefab_name ~= "" and arg_46_1.actors_[var_49_35.prefab_name] ~= nil then
						local var_49_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_35.prefab_name].transform, "story_v_out_113181", "113181011", "story_v_out_113181.awb")

						arg_46_1:RecordAudio("113181011", var_49_41)
						arg_46_1:RecordAudio("113181011", var_49_41)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_113181", "113181011", "story_v_out_113181.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_113181", "113181011", "story_v_out_113181.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_42 = math.max(var_49_33, arg_46_1.talkMaxDuration)

			if var_49_32 <= arg_46_1.time_ and arg_46_1.time_ < var_49_32 + var_49_42 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_32) / var_49_42

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_32 + var_49_42 and arg_46_1.time_ < var_49_32 + var_49_42 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play113181012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 113181012
		arg_50_1.duration_ = 7.87

		local var_50_0 = {
			ja = 7.866,
			ko = 5.366,
			zh = 5.033,
			en = 6.433
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
				arg_50_0:Play113181013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1097ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1097ui_story == nil then
				arg_50_1.var_.characterEffect1097ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.2

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect1097ui_story and not isNil(var_53_0) then
					arg_50_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect1097ui_story then
				arg_50_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_53_4 = 0

			if var_53_4 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action5_1")
			end

			local var_53_5 = 0

			if var_53_5 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_53_6 = arg_50_1.actors_["1038ui_story"]
			local var_53_7 = 0

			if var_53_7 < arg_50_1.time_ and arg_50_1.time_ <= var_53_7 + arg_53_0 and not isNil(var_53_6) and arg_50_1.var_.characterEffect1038ui_story == nil then
				arg_50_1.var_.characterEffect1038ui_story = var_53_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_8 = 0.2

			if var_53_7 <= arg_50_1.time_ and arg_50_1.time_ < var_53_7 + var_53_8 and not isNil(var_53_6) then
				local var_53_9 = (arg_50_1.time_ - var_53_7) / var_53_8

				if arg_50_1.var_.characterEffect1038ui_story and not isNil(var_53_6) then
					local var_53_10 = Mathf.Lerp(0, 0.5, var_53_9)

					arg_50_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1038ui_story.fillRatio = var_53_10
				end
			end

			if arg_50_1.time_ >= var_53_7 + var_53_8 and arg_50_1.time_ < var_53_7 + var_53_8 + arg_53_0 and not isNil(var_53_6) and arg_50_1.var_.characterEffect1038ui_story then
				local var_53_11 = 0.5

				arg_50_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1038ui_story.fillRatio = var_53_11
			end

			local var_53_12 = arg_50_1.actors_["1097ui_story"].transform
			local var_53_13 = 0

			if var_53_13 < arg_50_1.time_ and arg_50_1.time_ <= var_53_13 + arg_53_0 then
				local var_53_14 = arg_50_1.var_.effect1097ui_storyyanwu1
				local var_53_15
				local var_53_16 = var_53_12

				if not var_53_14 then
					var_53_14 = Object.Instantiate(Asset.Load("Effect/Hero/1097/fx_1097_story_smoke"), var_53_16)
					var_53_14.name = "yanwu1"
					arg_50_1.var_.effect1097ui_storyyanwu1 = var_53_14
				else
					var_53_14.transform:SetParent(var_53_16)
				end

				var_53_14.transform.localPosition = Vector3.New(0, 1.28, 0.3)
				var_53_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_53_17 = arg_50_1.actors_["1097ui_story"].transform
			local var_53_18 = 2

			if var_53_18 < arg_50_1.time_ and arg_50_1.time_ <= var_53_18 + arg_53_0 then
				local var_53_19 = arg_50_1.var_.effect1097ui_storyyanwu1

				if var_53_19 then
					Object.Destroy(var_53_19)

					arg_50_1.var_.effect1097ui_storyyanwu1 = nil
				end
			end

			local var_53_20 = 0
			local var_53_21 = 1

			if var_53_20 < arg_50_1.time_ and arg_50_1.time_ <= var_53_20 + arg_53_0 then
				local var_53_22 = "play"
				local var_53_23 = "music"

				arg_50_1:AudioAction(var_53_22, var_53_23, "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_53_24 = ""
				local var_53_25 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

				if var_53_25 ~= "" then
					if arg_50_1.bgmTxt_.text ~= var_53_25 and arg_50_1.bgmTxt_.text ~= "" then
						if arg_50_1.bgmTxt2_.text ~= "" then
							arg_50_1.bgmTxt_.text = arg_50_1.bgmTxt2_.text
						end

						arg_50_1.bgmTxt2_.text = var_53_25

						arg_50_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_50_1.bgmTxt_.text = var_53_25
						arg_50_1.bgmTxt2_.text = var_53_25
					end

					if arg_50_1.bgmTimer then
						arg_50_1.bgmTimer:Stop()

						arg_50_1.bgmTimer = nil
					end

					if arg_50_1.settingData.show_music_name == 1 then
						arg_50_1.musicController:SetSelectedState("show")
						arg_50_1.musicAnimator_:Play("open", 0, 0)

						if arg_50_1.settingData.music_time ~= 0 then
							arg_50_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_50_1.settingData.music_time), function()
								if arg_50_1 == nil or isNil(arg_50_1.bgmTxt_) then
									return
								end

								arg_50_1.musicController:SetSelectedState("hide")
								arg_50_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_53_26 = 0
			local var_53_27 = 0.4

			if var_53_26 < arg_50_1.time_ and arg_50_1.time_ <= var_53_26 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_28 = arg_50_1:FormatText(StoryNameCfg[216].name)

				arg_50_1.leftNameTxt_.text = var_53_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_29 = arg_50_1:GetWordFromCfg(113181012)
				local var_53_30 = arg_50_1:FormatText(var_53_29.content)

				arg_50_1.text_.text = var_53_30

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_31 = 16
				local var_53_32 = utf8.len(var_53_30)
				local var_53_33 = var_53_31 <= 0 and var_53_27 or var_53_27 * (var_53_32 / var_53_31)

				if var_53_33 > 0 and var_53_27 < var_53_33 then
					arg_50_1.talkMaxDuration = var_53_33

					if var_53_33 + var_53_26 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_33 + var_53_26
					end
				end

				arg_50_1.text_.text = var_53_30
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181012", "story_v_out_113181.awb") ~= 0 then
					local var_53_34 = manager.audio:GetVoiceLength("story_v_out_113181", "113181012", "story_v_out_113181.awb") / 1000

					if var_53_34 + var_53_26 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_34 + var_53_26
					end

					if var_53_29.prefab_name ~= "" and arg_50_1.actors_[var_53_29.prefab_name] ~= nil then
						local var_53_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_29.prefab_name].transform, "story_v_out_113181", "113181012", "story_v_out_113181.awb")

						arg_50_1:RecordAudio("113181012", var_53_35)
						arg_50_1:RecordAudio("113181012", var_53_35)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_113181", "113181012", "story_v_out_113181.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_113181", "113181012", "story_v_out_113181.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_36 = math.max(var_53_27, arg_50_1.talkMaxDuration)

			if var_53_26 <= arg_50_1.time_ and arg_50_1.time_ < var_53_26 + var_53_36 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_26) / var_53_36

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_26 + var_53_36 and arg_50_1.time_ < var_53_26 + var_53_36 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play113181013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 113181013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play113181014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1097ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1097ui_story == nil then
				arg_55_1.var_.characterEffect1097ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.2

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 and not isNil(var_58_0) then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect1097ui_story and not isNil(var_58_0) then
					local var_58_4 = Mathf.Lerp(0, 0.5, var_58_3)

					arg_55_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1097ui_story.fillRatio = var_58_4
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1097ui_story then
				local var_58_5 = 0.5

				arg_55_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1097ui_story.fillRatio = var_58_5
			end

			local var_58_6 = 0
			local var_58_7 = 0.6

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_8 = arg_55_1:GetWordFromCfg(113181013)
				local var_58_9 = arg_55_1:FormatText(var_58_8.content)

				arg_55_1.text_.text = var_58_9

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_10 = 24
				local var_58_11 = utf8.len(var_58_9)
				local var_58_12 = var_58_10 <= 0 and var_58_7 or var_58_7 * (var_58_11 / var_58_10)

				if var_58_12 > 0 and var_58_7 < var_58_12 then
					arg_55_1.talkMaxDuration = var_58_12

					if var_58_12 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_12 + var_58_6
					end
				end

				arg_55_1.text_.text = var_58_9
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_13 = math.max(var_58_7, arg_55_1.talkMaxDuration)

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_13 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_6) / var_58_13

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_6 + var_58_13 and arg_55_1.time_ < var_58_6 + var_58_13 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play113181014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 113181014
		arg_59_1.duration_ = 7.47

		local var_59_0 = {
			ja = 7.466,
			ko = 5.4,
			zh = 4.533,
			en = 6.633
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play113181015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_62_1 = arg_59_1.actors_["1038ui_story"]
			local var_62_2 = 0

			if var_62_2 < arg_59_1.time_ and arg_59_1.time_ <= var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1038ui_story == nil then
				arg_59_1.var_.characterEffect1038ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_3 = 0.2

			if var_62_2 <= arg_59_1.time_ and arg_59_1.time_ < var_62_2 + var_62_3 and not isNil(var_62_1) then
				local var_62_4 = (arg_59_1.time_ - var_62_2) / var_62_3

				if arg_59_1.var_.characterEffect1038ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_2 + var_62_3 and arg_59_1.time_ < var_62_2 + var_62_3 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1038ui_story then
				arg_59_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_62_5 = 0
			local var_62_6 = 0.65

			if var_62_5 < arg_59_1.time_ and arg_59_1.time_ <= var_62_5 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_7 = arg_59_1:FormatText(StoryNameCfg[94].name)

				arg_59_1.leftNameTxt_.text = var_62_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_8 = arg_59_1:GetWordFromCfg(113181014)
				local var_62_9 = arg_59_1:FormatText(var_62_8.content)

				arg_59_1.text_.text = var_62_9

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_10 = 26
				local var_62_11 = utf8.len(var_62_9)
				local var_62_12 = var_62_10 <= 0 and var_62_6 or var_62_6 * (var_62_11 / var_62_10)

				if var_62_12 > 0 and var_62_6 < var_62_12 then
					arg_59_1.talkMaxDuration = var_62_12

					if var_62_12 + var_62_5 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_12 + var_62_5
					end
				end

				arg_59_1.text_.text = var_62_9
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181014", "story_v_out_113181.awb") ~= 0 then
					local var_62_13 = manager.audio:GetVoiceLength("story_v_out_113181", "113181014", "story_v_out_113181.awb") / 1000

					if var_62_13 + var_62_5 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_5
					end

					if var_62_8.prefab_name ~= "" and arg_59_1.actors_[var_62_8.prefab_name] ~= nil then
						local var_62_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_8.prefab_name].transform, "story_v_out_113181", "113181014", "story_v_out_113181.awb")

						arg_59_1:RecordAudio("113181014", var_62_14)
						arg_59_1:RecordAudio("113181014", var_62_14)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_113181", "113181014", "story_v_out_113181.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_113181", "113181014", "story_v_out_113181.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_15 = math.max(var_62_6, arg_59_1.talkMaxDuration)

			if var_62_5 <= arg_59_1.time_ and arg_59_1.time_ < var_62_5 + var_62_15 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_5) / var_62_15

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_5 + var_62_15 and arg_59_1.time_ < var_62_5 + var_62_15 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play113181015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 113181015
		arg_63_1.duration_ = 14.2

		local var_63_0 = {
			ja = 14.2,
			ko = 10.433,
			zh = 8.666,
			en = 11
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play113181016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1038ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1038ui_story == nil then
				arg_63_1.var_.characterEffect1038ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.2

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1038ui_story and not isNil(var_66_0) then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1038ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1038ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1038ui_story.fillRatio = var_66_5
			end

			local var_66_6 = 0

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_66_7 = arg_63_1.actors_["1097ui_story"]
			local var_66_8 = 0

			if var_66_8 < arg_63_1.time_ and arg_63_1.time_ <= var_66_8 + arg_66_0 and not isNil(var_66_7) and arg_63_1.var_.characterEffect1097ui_story == nil then
				arg_63_1.var_.characterEffect1097ui_story = var_66_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_9 = 0.2

			if var_66_8 <= arg_63_1.time_ and arg_63_1.time_ < var_66_8 + var_66_9 and not isNil(var_66_7) then
				local var_66_10 = (arg_63_1.time_ - var_66_8) / var_66_9

				if arg_63_1.var_.characterEffect1097ui_story and not isNil(var_66_7) then
					arg_63_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= var_66_8 + var_66_9 and arg_63_1.time_ < var_66_8 + var_66_9 + arg_66_0 and not isNil(var_66_7) and arg_63_1.var_.characterEffect1097ui_story then
				arg_63_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_66_11 = 0
			local var_66_12 = 0.925

			if var_66_11 < arg_63_1.time_ and arg_63_1.time_ <= var_66_11 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_13 = arg_63_1:FormatText(StoryNameCfg[216].name)

				arg_63_1.leftNameTxt_.text = var_66_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_14 = arg_63_1:GetWordFromCfg(113181015)
				local var_66_15 = arg_63_1:FormatText(var_66_14.content)

				arg_63_1.text_.text = var_66_15

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_16 = 37
				local var_66_17 = utf8.len(var_66_15)
				local var_66_18 = var_66_16 <= 0 and var_66_12 or var_66_12 * (var_66_17 / var_66_16)

				if var_66_18 > 0 and var_66_12 < var_66_18 then
					arg_63_1.talkMaxDuration = var_66_18

					if var_66_18 + var_66_11 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_18 + var_66_11
					end
				end

				arg_63_1.text_.text = var_66_15
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181015", "story_v_out_113181.awb") ~= 0 then
					local var_66_19 = manager.audio:GetVoiceLength("story_v_out_113181", "113181015", "story_v_out_113181.awb") / 1000

					if var_66_19 + var_66_11 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_19 + var_66_11
					end

					if var_66_14.prefab_name ~= "" and arg_63_1.actors_[var_66_14.prefab_name] ~= nil then
						local var_66_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_14.prefab_name].transform, "story_v_out_113181", "113181015", "story_v_out_113181.awb")

						arg_63_1:RecordAudio("113181015", var_66_20)
						arg_63_1:RecordAudio("113181015", var_66_20)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_113181", "113181015", "story_v_out_113181.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_113181", "113181015", "story_v_out_113181.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_21 = math.max(var_66_12, arg_63_1.talkMaxDuration)

			if var_66_11 <= arg_63_1.time_ and arg_63_1.time_ < var_66_11 + var_66_21 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_11) / var_66_21

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_11 + var_66_21 and arg_63_1.time_ < var_66_11 + var_66_21 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play113181016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 113181016
		arg_67_1.duration_ = 3.57

		local var_67_0 = {
			ja = 3.566,
			ko = 2.4,
			zh = 2.066,
			en = 3.366
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play113181017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1097ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1097ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0, 100, 0)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1097ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, 100, 0)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = arg_67_1.actors_["1084ui_story"].transform
			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 then
				arg_67_1.var_.moveOldPos1084ui_story = var_70_9.localPosition
			end

			local var_70_11 = 0.001

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_11 then
				local var_70_12 = (arg_67_1.time_ - var_70_10) / var_70_11
				local var_70_13 = Vector3.New(-0.7, -0.97, -6)

				var_70_9.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1084ui_story, var_70_13, var_70_12)

				local var_70_14 = manager.ui.mainCamera.transform.position - var_70_9.position

				var_70_9.forward = Vector3.New(var_70_14.x, var_70_14.y, var_70_14.z)

				local var_70_15 = var_70_9.localEulerAngles

				var_70_15.z = 0
				var_70_15.x = 0
				var_70_9.localEulerAngles = var_70_15
			end

			if arg_67_1.time_ >= var_70_10 + var_70_11 and arg_67_1.time_ < var_70_10 + var_70_11 + arg_70_0 then
				var_70_9.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_70_16 = manager.ui.mainCamera.transform.position - var_70_9.position

				var_70_9.forward = Vector3.New(var_70_16.x, var_70_16.y, var_70_16.z)

				local var_70_17 = var_70_9.localEulerAngles

				var_70_17.z = 0
				var_70_17.x = 0
				var_70_9.localEulerAngles = var_70_17
			end

			local var_70_18 = 0

			if var_70_18 < arg_67_1.time_ and arg_67_1.time_ <= var_70_18 + arg_70_0 then
				arg_67_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_70_19 = 0

			if var_70_19 < arg_67_1.time_ and arg_67_1.time_ <= var_70_19 + arg_70_0 then
				arg_67_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_70_20 = arg_67_1.actors_["1084ui_story"]
			local var_70_21 = 0

			if var_70_21 < arg_67_1.time_ and arg_67_1.time_ <= var_70_21 + arg_70_0 and not isNil(var_70_20) and arg_67_1.var_.characterEffect1084ui_story == nil then
				arg_67_1.var_.characterEffect1084ui_story = var_70_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_22 = 0.2

			if var_70_21 <= arg_67_1.time_ and arg_67_1.time_ < var_70_21 + var_70_22 and not isNil(var_70_20) then
				local var_70_23 = (arg_67_1.time_ - var_70_21) / var_70_22

				if arg_67_1.var_.characterEffect1084ui_story and not isNil(var_70_20) then
					arg_67_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_21 + var_70_22 and arg_67_1.time_ < var_70_21 + var_70_22 + arg_70_0 and not isNil(var_70_20) and arg_67_1.var_.characterEffect1084ui_story then
				arg_67_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_70_24 = 0
			local var_70_25 = 0.2

			if var_70_24 < arg_67_1.time_ and arg_67_1.time_ <= var_70_24 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_26 = arg_67_1:FormatText(StoryNameCfg[6].name)

				arg_67_1.leftNameTxt_.text = var_70_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_27 = arg_67_1:GetWordFromCfg(113181016)
				local var_70_28 = arg_67_1:FormatText(var_70_27.content)

				arg_67_1.text_.text = var_70_28

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_29 = 8
				local var_70_30 = utf8.len(var_70_28)
				local var_70_31 = var_70_29 <= 0 and var_70_25 or var_70_25 * (var_70_30 / var_70_29)

				if var_70_31 > 0 and var_70_25 < var_70_31 then
					arg_67_1.talkMaxDuration = var_70_31

					if var_70_31 + var_70_24 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_31 + var_70_24
					end
				end

				arg_67_1.text_.text = var_70_28
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181016", "story_v_out_113181.awb") ~= 0 then
					local var_70_32 = manager.audio:GetVoiceLength("story_v_out_113181", "113181016", "story_v_out_113181.awb") / 1000

					if var_70_32 + var_70_24 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_32 + var_70_24
					end

					if var_70_27.prefab_name ~= "" and arg_67_1.actors_[var_70_27.prefab_name] ~= nil then
						local var_70_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_27.prefab_name].transform, "story_v_out_113181", "113181016", "story_v_out_113181.awb")

						arg_67_1:RecordAudio("113181016", var_70_33)
						arg_67_1:RecordAudio("113181016", var_70_33)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_113181", "113181016", "story_v_out_113181.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_113181", "113181016", "story_v_out_113181.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_34 = math.max(var_70_25, arg_67_1.talkMaxDuration)

			if var_70_24 <= arg_67_1.time_ and arg_67_1.time_ < var_70_24 + var_70_34 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_24) / var_70_34

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_24 + var_70_34 and arg_67_1.time_ < var_70_24 + var_70_34 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play113181017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 113181017
		arg_71_1.duration_ = 16.47

		local var_71_0 = {
			ja = 16.466,
			ko = 12.833,
			zh = 9.566,
			en = 10.933
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play113181018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1084ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1084ui_story == nil then
				arg_71_1.var_.characterEffect1084ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.2

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect1084ui_story and not isNil(var_74_0) then
					local var_74_4 = Mathf.Lerp(0, 0.5, var_74_3)

					arg_71_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1084ui_story.fillRatio = var_74_4
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1084ui_story then
				local var_74_5 = 0.5

				arg_71_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1084ui_story.fillRatio = var_74_5
			end

			local var_74_6 = 0

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_74_7 = arg_71_1.actors_["1038ui_story"]
			local var_74_8 = 0

			if var_74_8 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 and not isNil(var_74_7) and arg_71_1.var_.characterEffect1038ui_story == nil then
				arg_71_1.var_.characterEffect1038ui_story = var_74_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_9 = 0.2

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_9 and not isNil(var_74_7) then
				local var_74_10 = (arg_71_1.time_ - var_74_8) / var_74_9

				if arg_71_1.var_.characterEffect1038ui_story and not isNil(var_74_7) then
					arg_71_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_8 + var_74_9 and arg_71_1.time_ < var_74_8 + var_74_9 + arg_74_0 and not isNil(var_74_7) and arg_71_1.var_.characterEffect1038ui_story then
				arg_71_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_74_11 = arg_71_1.actors_["1038ui_story"].transform
			local var_74_12 = 0

			if var_74_12 < arg_71_1.time_ and arg_71_1.time_ <= var_74_12 + arg_74_0 then
				arg_71_1.var_.moveOldPos1038ui_story = var_74_11.localPosition
			end

			local var_74_13 = 0.001

			if var_74_12 <= arg_71_1.time_ and arg_71_1.time_ < var_74_12 + var_74_13 then
				local var_74_14 = (arg_71_1.time_ - var_74_12) / var_74_13
				local var_74_15 = Vector3.New(0.7, -1.11, -5.9)

				var_74_11.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1038ui_story, var_74_15, var_74_14)

				local var_74_16 = manager.ui.mainCamera.transform.position - var_74_11.position

				var_74_11.forward = Vector3.New(var_74_16.x, var_74_16.y, var_74_16.z)

				local var_74_17 = var_74_11.localEulerAngles

				var_74_17.z = 0
				var_74_17.x = 0
				var_74_11.localEulerAngles = var_74_17
			end

			if arg_71_1.time_ >= var_74_12 + var_74_13 and arg_71_1.time_ < var_74_12 + var_74_13 + arg_74_0 then
				var_74_11.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_74_18 = manager.ui.mainCamera.transform.position - var_74_11.position

				var_74_11.forward = Vector3.New(var_74_18.x, var_74_18.y, var_74_18.z)

				local var_74_19 = var_74_11.localEulerAngles

				var_74_19.z = 0
				var_74_19.x = 0
				var_74_11.localEulerAngles = var_74_19
			end

			local var_74_20 = 0
			local var_74_21 = 1.275

			if var_74_20 < arg_71_1.time_ and arg_71_1.time_ <= var_74_20 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_22 = arg_71_1:FormatText(StoryNameCfg[94].name)

				arg_71_1.leftNameTxt_.text = var_74_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_23 = arg_71_1:GetWordFromCfg(113181017)
				local var_74_24 = arg_71_1:FormatText(var_74_23.content)

				arg_71_1.text_.text = var_74_24

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_25 = 51
				local var_74_26 = utf8.len(var_74_24)
				local var_74_27 = var_74_25 <= 0 and var_74_21 or var_74_21 * (var_74_26 / var_74_25)

				if var_74_27 > 0 and var_74_21 < var_74_27 then
					arg_71_1.talkMaxDuration = var_74_27

					if var_74_27 + var_74_20 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_27 + var_74_20
					end
				end

				arg_71_1.text_.text = var_74_24
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181017", "story_v_out_113181.awb") ~= 0 then
					local var_74_28 = manager.audio:GetVoiceLength("story_v_out_113181", "113181017", "story_v_out_113181.awb") / 1000

					if var_74_28 + var_74_20 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_28 + var_74_20
					end

					if var_74_23.prefab_name ~= "" and arg_71_1.actors_[var_74_23.prefab_name] ~= nil then
						local var_74_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_23.prefab_name].transform, "story_v_out_113181", "113181017", "story_v_out_113181.awb")

						arg_71_1:RecordAudio("113181017", var_74_29)
						arg_71_1:RecordAudio("113181017", var_74_29)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_113181", "113181017", "story_v_out_113181.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_113181", "113181017", "story_v_out_113181.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_30 = math.max(var_74_21, arg_71_1.talkMaxDuration)

			if var_74_20 <= arg_71_1.time_ and arg_71_1.time_ < var_74_20 + var_74_30 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_20) / var_74_30

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_20 + var_74_30 and arg_71_1.time_ < var_74_20 + var_74_30 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play113181018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 113181018
		arg_75_1.duration_ = 14.5

		local var_75_0 = {
			ja = 14.5,
			ko = 10.3,
			zh = 6.866,
			en = 13.566
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play113181019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action3_1")
			end

			local var_78_2 = 0
			local var_78_3 = 0.925

			if var_78_2 < arg_75_1.time_ and arg_75_1.time_ <= var_78_2 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_4 = arg_75_1:FormatText(StoryNameCfg[94].name)

				arg_75_1.leftNameTxt_.text = var_78_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_5 = arg_75_1:GetWordFromCfg(113181018)
				local var_78_6 = arg_75_1:FormatText(var_78_5.content)

				arg_75_1.text_.text = var_78_6

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_7 = 37
				local var_78_8 = utf8.len(var_78_6)
				local var_78_9 = var_78_7 <= 0 and var_78_3 or var_78_3 * (var_78_8 / var_78_7)

				if var_78_9 > 0 and var_78_3 < var_78_9 then
					arg_75_1.talkMaxDuration = var_78_9

					if var_78_9 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_2
					end
				end

				arg_75_1.text_.text = var_78_6
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181018", "story_v_out_113181.awb") ~= 0 then
					local var_78_10 = manager.audio:GetVoiceLength("story_v_out_113181", "113181018", "story_v_out_113181.awb") / 1000

					if var_78_10 + var_78_2 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_10 + var_78_2
					end

					if var_78_5.prefab_name ~= "" and arg_75_1.actors_[var_78_5.prefab_name] ~= nil then
						local var_78_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_5.prefab_name].transform, "story_v_out_113181", "113181018", "story_v_out_113181.awb")

						arg_75_1:RecordAudio("113181018", var_78_11)
						arg_75_1:RecordAudio("113181018", var_78_11)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_113181", "113181018", "story_v_out_113181.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_113181", "113181018", "story_v_out_113181.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_12 = math.max(var_78_3, arg_75_1.talkMaxDuration)

			if var_78_2 <= arg_75_1.time_ and arg_75_1.time_ < var_78_2 + var_78_12 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_2) / var_78_12

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_2 + var_78_12 and arg_75_1.time_ < var_78_2 + var_78_12 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play113181019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 113181019
		arg_79_1.duration_ = 2.67

		local var_79_0 = {
			ja = 1.999999999999,
			ko = 2.666,
			zh = 2.4,
			en = 1.999999999999
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
				arg_79_0:Play113181020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4134")
			end

			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_82_2 = arg_79_1.actors_["1084ui_story"]
			local var_82_3 = 0

			if var_82_3 < arg_79_1.time_ and arg_79_1.time_ <= var_82_3 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1084ui_story == nil then
				arg_79_1.var_.characterEffect1084ui_story = var_82_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_4 = 0.2

			if var_82_3 <= arg_79_1.time_ and arg_79_1.time_ < var_82_3 + var_82_4 and not isNil(var_82_2) then
				local var_82_5 = (arg_79_1.time_ - var_82_3) / var_82_4

				if arg_79_1.var_.characterEffect1084ui_story and not isNil(var_82_2) then
					arg_79_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_3 + var_82_4 and arg_79_1.time_ < var_82_3 + var_82_4 + arg_82_0 and not isNil(var_82_2) and arg_79_1.var_.characterEffect1084ui_story then
				arg_79_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_82_6 = arg_79_1.actors_["1038ui_story"]
			local var_82_7 = 0

			if var_82_7 < arg_79_1.time_ and arg_79_1.time_ <= var_82_7 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect1038ui_story == nil then
				arg_79_1.var_.characterEffect1038ui_story = var_82_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_8 = 0.2

			if var_82_7 <= arg_79_1.time_ and arg_79_1.time_ < var_82_7 + var_82_8 and not isNil(var_82_6) then
				local var_82_9 = (arg_79_1.time_ - var_82_7) / var_82_8

				if arg_79_1.var_.characterEffect1038ui_story and not isNil(var_82_6) then
					local var_82_10 = Mathf.Lerp(0, 0.5, var_82_9)

					arg_79_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1038ui_story.fillRatio = var_82_10
				end
			end

			if arg_79_1.time_ >= var_82_7 + var_82_8 and arg_79_1.time_ < var_82_7 + var_82_8 + arg_82_0 and not isNil(var_82_6) and arg_79_1.var_.characterEffect1038ui_story then
				local var_82_11 = 0.5

				arg_79_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1038ui_story.fillRatio = var_82_11
			end

			local var_82_12 = 0
			local var_82_13 = 0.2

			if var_82_12 < arg_79_1.time_ and arg_79_1.time_ <= var_82_12 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_14 = arg_79_1:FormatText(StoryNameCfg[6].name)

				arg_79_1.leftNameTxt_.text = var_82_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_15 = arg_79_1:GetWordFromCfg(113181019)
				local var_82_16 = arg_79_1:FormatText(var_82_15.content)

				arg_79_1.text_.text = var_82_16

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_17 = 8
				local var_82_18 = utf8.len(var_82_16)
				local var_82_19 = var_82_17 <= 0 and var_82_13 or var_82_13 * (var_82_18 / var_82_17)

				if var_82_19 > 0 and var_82_13 < var_82_19 then
					arg_79_1.talkMaxDuration = var_82_19

					if var_82_19 + var_82_12 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_19 + var_82_12
					end
				end

				arg_79_1.text_.text = var_82_16
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181019", "story_v_out_113181.awb") ~= 0 then
					local var_82_20 = manager.audio:GetVoiceLength("story_v_out_113181", "113181019", "story_v_out_113181.awb") / 1000

					if var_82_20 + var_82_12 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_20 + var_82_12
					end

					if var_82_15.prefab_name ~= "" and arg_79_1.actors_[var_82_15.prefab_name] ~= nil then
						local var_82_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_15.prefab_name].transform, "story_v_out_113181", "113181019", "story_v_out_113181.awb")

						arg_79_1:RecordAudio("113181019", var_82_21)
						arg_79_1:RecordAudio("113181019", var_82_21)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_113181", "113181019", "story_v_out_113181.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_113181", "113181019", "story_v_out_113181.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_22 = math.max(var_82_13, arg_79_1.talkMaxDuration)

			if var_82_12 <= arg_79_1.time_ and arg_79_1.time_ < var_82_12 + var_82_22 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_12) / var_82_22

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_12 + var_82_22 and arg_79_1.time_ < var_82_12 + var_82_22 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play113181020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 113181020
		arg_83_1.duration_ = 4.97

		local var_83_0 = {
			ja = 3.7,
			ko = 3.766,
			zh = 3.133,
			en = 4.966
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
				arg_83_0:Play113181021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action3_2")
			end

			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_86_2 = arg_83_1.actors_["1038ui_story"]
			local var_86_3 = 0

			if var_86_3 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect1038ui_story == nil then
				arg_83_1.var_.characterEffect1038ui_story = var_86_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_4 = 0.2

			if var_86_3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_3 + var_86_4 and not isNil(var_86_2) then
				local var_86_5 = (arg_83_1.time_ - var_86_3) / var_86_4

				if arg_83_1.var_.characterEffect1038ui_story and not isNil(var_86_2) then
					arg_83_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_3 + var_86_4 and arg_83_1.time_ < var_86_3 + var_86_4 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect1038ui_story then
				arg_83_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_86_6 = arg_83_1.actors_["1084ui_story"]
			local var_86_7 = 0

			if var_86_7 < arg_83_1.time_ and arg_83_1.time_ <= var_86_7 + arg_86_0 and not isNil(var_86_6) and arg_83_1.var_.characterEffect1084ui_story == nil then
				arg_83_1.var_.characterEffect1084ui_story = var_86_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_8 = 0.2

			if var_86_7 <= arg_83_1.time_ and arg_83_1.time_ < var_86_7 + var_86_8 and not isNil(var_86_6) then
				local var_86_9 = (arg_83_1.time_ - var_86_7) / var_86_8

				if arg_83_1.var_.characterEffect1084ui_story and not isNil(var_86_6) then
					local var_86_10 = Mathf.Lerp(0, 0.5, var_86_9)

					arg_83_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1084ui_story.fillRatio = var_86_10
				end
			end

			if arg_83_1.time_ >= var_86_7 + var_86_8 and arg_83_1.time_ < var_86_7 + var_86_8 + arg_86_0 and not isNil(var_86_6) and arg_83_1.var_.characterEffect1084ui_story then
				local var_86_11 = 0.5

				arg_83_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1084ui_story.fillRatio = var_86_11
			end

			local var_86_12 = 0
			local var_86_13 = 0.425

			if var_86_12 < arg_83_1.time_ and arg_83_1.time_ <= var_86_12 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_14 = arg_83_1:FormatText(StoryNameCfg[94].name)

				arg_83_1.leftNameTxt_.text = var_86_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_15 = arg_83_1:GetWordFromCfg(113181020)
				local var_86_16 = arg_83_1:FormatText(var_86_15.content)

				arg_83_1.text_.text = var_86_16

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_17 = 17
				local var_86_18 = utf8.len(var_86_16)
				local var_86_19 = var_86_17 <= 0 and var_86_13 or var_86_13 * (var_86_18 / var_86_17)

				if var_86_19 > 0 and var_86_13 < var_86_19 then
					arg_83_1.talkMaxDuration = var_86_19

					if var_86_19 + var_86_12 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_19 + var_86_12
					end
				end

				arg_83_1.text_.text = var_86_16
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181020", "story_v_out_113181.awb") ~= 0 then
					local var_86_20 = manager.audio:GetVoiceLength("story_v_out_113181", "113181020", "story_v_out_113181.awb") / 1000

					if var_86_20 + var_86_12 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_20 + var_86_12
					end

					if var_86_15.prefab_name ~= "" and arg_83_1.actors_[var_86_15.prefab_name] ~= nil then
						local var_86_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_15.prefab_name].transform, "story_v_out_113181", "113181020", "story_v_out_113181.awb")

						arg_83_1:RecordAudio("113181020", var_86_21)
						arg_83_1:RecordAudio("113181020", var_86_21)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_113181", "113181020", "story_v_out_113181.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_113181", "113181020", "story_v_out_113181.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_22 = math.max(var_86_13, arg_83_1.talkMaxDuration)

			if var_86_12 <= arg_83_1.time_ and arg_83_1.time_ < var_86_12 + var_86_22 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_12) / var_86_22

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_12 + var_86_22 and arg_83_1.time_ < var_86_12 + var_86_22 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play113181021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 113181021
		arg_87_1.duration_ = 11.6

		local var_87_0 = {
			ja = 6.4,
			ko = 4.633,
			zh = 4.633,
			en = 11.6
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
				arg_87_0:Play113181022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1097ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1097ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(-0.7, -0.54, -6.3)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1097ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(-0.7, -0.54, -6.3)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = 0

			if var_90_9 < arg_87_1.time_ and arg_87_1.time_ <= var_90_9 + arg_90_0 then
				arg_87_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 then
				arg_87_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_90_11 = arg_87_1.actors_["1097ui_story"]
			local var_90_12 = 0

			if var_90_12 < arg_87_1.time_ and arg_87_1.time_ <= var_90_12 + arg_90_0 and not isNil(var_90_11) and arg_87_1.var_.characterEffect1097ui_story == nil then
				arg_87_1.var_.characterEffect1097ui_story = var_90_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_13 = 0.2

			if var_90_12 <= arg_87_1.time_ and arg_87_1.time_ < var_90_12 + var_90_13 and not isNil(var_90_11) then
				local var_90_14 = (arg_87_1.time_ - var_90_12) / var_90_13

				if arg_87_1.var_.characterEffect1097ui_story and not isNil(var_90_11) then
					arg_87_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_12 + var_90_13 and arg_87_1.time_ < var_90_12 + var_90_13 + arg_90_0 and not isNil(var_90_11) and arg_87_1.var_.characterEffect1097ui_story then
				arg_87_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_90_15 = arg_87_1.actors_["1038ui_story"]
			local var_90_16 = 0

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 and not isNil(var_90_15) and arg_87_1.var_.characterEffect1038ui_story == nil then
				arg_87_1.var_.characterEffect1038ui_story = var_90_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_17 = 0.2

			if var_90_16 <= arg_87_1.time_ and arg_87_1.time_ < var_90_16 + var_90_17 and not isNil(var_90_15) then
				local var_90_18 = (arg_87_1.time_ - var_90_16) / var_90_17

				if arg_87_1.var_.characterEffect1038ui_story and not isNil(var_90_15) then
					local var_90_19 = Mathf.Lerp(0, 0.5, var_90_18)

					arg_87_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1038ui_story.fillRatio = var_90_19
				end
			end

			if arg_87_1.time_ >= var_90_16 + var_90_17 and arg_87_1.time_ < var_90_16 + var_90_17 + arg_90_0 and not isNil(var_90_15) and arg_87_1.var_.characterEffect1038ui_story then
				local var_90_20 = 0.5

				arg_87_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1038ui_story.fillRatio = var_90_20
			end

			local var_90_21 = arg_87_1.actors_["1084ui_story"].transform
			local var_90_22 = 0

			if var_90_22 < arg_87_1.time_ and arg_87_1.time_ <= var_90_22 + arg_90_0 then
				arg_87_1.var_.moveOldPos1084ui_story = var_90_21.localPosition
			end

			local var_90_23 = 0.001

			if var_90_22 <= arg_87_1.time_ and arg_87_1.time_ < var_90_22 + var_90_23 then
				local var_90_24 = (arg_87_1.time_ - var_90_22) / var_90_23
				local var_90_25 = Vector3.New(0, 100, 0)

				var_90_21.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1084ui_story, var_90_25, var_90_24)

				local var_90_26 = manager.ui.mainCamera.transform.position - var_90_21.position

				var_90_21.forward = Vector3.New(var_90_26.x, var_90_26.y, var_90_26.z)

				local var_90_27 = var_90_21.localEulerAngles

				var_90_27.z = 0
				var_90_27.x = 0
				var_90_21.localEulerAngles = var_90_27
			end

			if arg_87_1.time_ >= var_90_22 + var_90_23 and arg_87_1.time_ < var_90_22 + var_90_23 + arg_90_0 then
				var_90_21.localPosition = Vector3.New(0, 100, 0)

				local var_90_28 = manager.ui.mainCamera.transform.position - var_90_21.position

				var_90_21.forward = Vector3.New(var_90_28.x, var_90_28.y, var_90_28.z)

				local var_90_29 = var_90_21.localEulerAngles

				var_90_29.z = 0
				var_90_29.x = 0
				var_90_21.localEulerAngles = var_90_29
			end

			local var_90_30 = 0
			local var_90_31 = 0.375

			if var_90_30 < arg_87_1.time_ and arg_87_1.time_ <= var_90_30 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_32 = arg_87_1:FormatText(StoryNameCfg[216].name)

				arg_87_1.leftNameTxt_.text = var_90_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_33 = arg_87_1:GetWordFromCfg(113181021)
				local var_90_34 = arg_87_1:FormatText(var_90_33.content)

				arg_87_1.text_.text = var_90_34

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_35 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181021", "story_v_out_113181.awb") ~= 0 then
					local var_90_38 = manager.audio:GetVoiceLength("story_v_out_113181", "113181021", "story_v_out_113181.awb") / 1000

					if var_90_38 + var_90_30 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_38 + var_90_30
					end

					if var_90_33.prefab_name ~= "" and arg_87_1.actors_[var_90_33.prefab_name] ~= nil then
						local var_90_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_33.prefab_name].transform, "story_v_out_113181", "113181021", "story_v_out_113181.awb")

						arg_87_1:RecordAudio("113181021", var_90_39)
						arg_87_1:RecordAudio("113181021", var_90_39)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_113181", "113181021", "story_v_out_113181.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_113181", "113181021", "story_v_out_113181.awb")
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
				actorName = "1097ui_story",
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play113181022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 113181022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play113181023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1097ui_story"]
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1097ui_story == nil then
				arg_91_1.var_.characterEffect1097ui_story = var_94_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.2

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 and not isNil(var_94_0) then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2

				if arg_91_1.var_.characterEffect1097ui_story and not isNil(var_94_0) then
					local var_94_4 = Mathf.Lerp(0, 0.5, var_94_3)

					arg_91_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1097ui_story.fillRatio = var_94_4
				end
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 and not isNil(var_94_0) and arg_91_1.var_.characterEffect1097ui_story then
				local var_94_5 = 0.5

				arg_91_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1097ui_story.fillRatio = var_94_5
			end

			local var_94_6 = 0
			local var_94_7 = 0.375

			if var_94_6 < arg_91_1.time_ and arg_91_1.time_ <= var_94_6 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_8 = arg_91_1:GetWordFromCfg(113181022)
				local var_94_9 = arg_91_1:FormatText(var_94_8.content)

				arg_91_1.text_.text = var_94_9

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_10 = 15
				local var_94_11 = utf8.len(var_94_9)
				local var_94_12 = var_94_10 <= 0 and var_94_7 or var_94_7 * (var_94_11 / var_94_10)

				if var_94_12 > 0 and var_94_7 < var_94_12 then
					arg_91_1.talkMaxDuration = var_94_12

					if var_94_12 + var_94_6 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_12 + var_94_6
					end
				end

				arg_91_1.text_.text = var_94_9
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_13 = math.max(var_94_7, arg_91_1.talkMaxDuration)

			if var_94_6 <= arg_91_1.time_ and arg_91_1.time_ < var_94_6 + var_94_13 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_6) / var_94_13

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_6 + var_94_13 and arg_91_1.time_ < var_94_6 + var_94_13 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play113181023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 113181023
		arg_95_1.duration_ = 2.9

		local var_95_0 = {
			ja = 2.9,
			ko = 2.866,
			zh = 1.999999999999,
			en = 2.266
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
			arg_95_1.auto_ = false
		end

		function arg_95_1.playNext_(arg_97_0)
			arg_95_1.onStoryFinished_()
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1038ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1038ui_story == nil then
				arg_95_1.var_.characterEffect1038ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.2

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1038ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1038ui_story then
				arg_95_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_98_4 = 0

			if var_98_4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_98_5 = 0

			if var_98_5 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			local var_98_6 = 0
			local var_98_7 = 0.15

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_8 = arg_95_1:FormatText(StoryNameCfg[94].name)

				arg_95_1.leftNameTxt_.text = var_98_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_9 = arg_95_1:GetWordFromCfg(113181023)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 6
				local var_98_12 = utf8.len(var_98_10)
				local var_98_13 = var_98_11 <= 0 and var_98_7 or var_98_7 * (var_98_12 / var_98_11)

				if var_98_13 > 0 and var_98_7 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181023", "story_v_out_113181.awb") ~= 0 then
					local var_98_14 = manager.audio:GetVoiceLength("story_v_out_113181", "113181023", "story_v_out_113181.awb") / 1000

					if var_98_14 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_14 + var_98_6
					end

					if var_98_9.prefab_name ~= "" and arg_95_1.actors_[var_98_9.prefab_name] ~= nil then
						local var_98_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_9.prefab_name].transform, "story_v_out_113181", "113181023", "story_v_out_113181.awb")

						arg_95_1:RecordAudio("113181023", var_98_15)
						arg_95_1:RecordAudio("113181023", var_98_15)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_113181", "113181023", "story_v_out_113181.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_113181", "113181023", "story_v_out_113181.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_16 and arg_95_1.time_ < var_98_6 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F04"
	},
	voices = {
		"story_v_out_113181.awb"
	}
}
