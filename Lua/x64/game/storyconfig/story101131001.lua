return {
	Play113101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113101001
		arg_1_1.duration_ = 6.67

		local var_1_0 = {
			ja = 5.499999999999,
			ko = 6.665999999999,
			zh = 6.299999999999,
			en = 6.099999999999
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
				arg_1_0:Play113101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F03"

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
				local var_4_5 = arg_1_1.bgs_.F03

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
					if iter_4_0 ~= "F03" then
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

			local var_4_22 = "1041ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["1041ui_story"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1041ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(-0.7, -1.11, -5.9)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1041ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = 1.8

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 then
				arg_1_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_4_38 = arg_1_1.actors_["1041ui_story"]
			local var_4_39 = 1.799999999999

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1041ui_story == nil then
				arg_1_1.var_.characterEffect1041ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.2

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1041ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1041ui_story then
				arg_1_1.var_.characterEffect1041ui_story.fillFlat = false
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

			local var_4_48 = 1.999999999999
			local var_4_49 = 0.800000000001

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

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

			local var_4_54 = 1.999999999999
			local var_4_55 = 0.55

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[208].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(113101001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 22
				local var_4_60 = utf8.len(var_4_58)
				local var_4_61 = var_4_59 <= 0 and var_4_55 or var_4_55 * (var_4_60 / var_4_59)

				if var_4_61 > 0 and var_4_55 < var_4_61 then
					arg_1_1.talkMaxDuration = var_4_61

					if var_4_61 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_54
					end
				end

				arg_1_1.text_.text = var_4_58
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101001", "story_v_out_113101.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_out_113101", "113101001", "story_v_out_113101.awb") / 1000

					if var_4_62 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_54
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_out_113101", "113101001", "story_v_out_113101.awb")

						arg_1_1:RecordAudio("113101001", var_4_63)
						arg_1_1:RecordAudio("113101001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113101", "113101001", "story_v_out_113101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113101", "113101001", "story_v_out_113101.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_64 = math.max(var_4_55, arg_1_1.talkMaxDuration)

			if var_4_54 <= arg_1_1.time_ and arg_1_1.time_ < var_4_54 + var_4_64 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_54) / var_4_64

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_54 + var_4_64 and arg_1_1.time_ < var_4_54 + var_4_64 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
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
	Play113101002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 113101002
		arg_7_1.duration_ = 7.37

		local var_7_0 = {
			ja = 6.133,
			ko = 7.366,
			zh = 7.266,
			en = 7.066
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play113101003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = "1084ui_story"

			if arg_7_1.actors_[var_10_0] == nil then
				local var_10_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_10_1) then
					local var_10_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_7_1.stage_.transform)

					var_10_2.name = var_10_0
					var_10_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_7_1.actors_[var_10_0] = var_10_2

					local var_10_3 = var_10_2:GetComponentInChildren(typeof(CharacterEffect))

					var_10_3.enabled = true

					local var_10_4 = GameObjectTools.GetOrAddComponent(var_10_2, typeof(DynamicBoneHelper))

					if var_10_4 then
						var_10_4:EnableDynamicBone(false)
					end

					arg_7_1:ShowWeapon(var_10_3.transform, false)

					arg_7_1.var_[var_10_0 .. "Animator"] = var_10_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_7_1.var_[var_10_0 .. "Animator"].applyRootMotion = true
					arg_7_1.var_[var_10_0 .. "LipSync"] = var_10_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_10_5 = arg_7_1.actors_["1084ui_story"].transform
			local var_10_6 = 1.00008890058234e-12

			if var_10_6 < arg_7_1.time_ and arg_7_1.time_ <= var_10_6 + arg_10_0 then
				arg_7_1.var_.moveOldPos1084ui_story = var_10_5.localPosition
			end

			local var_10_7 = 0.001

			if var_10_6 <= arg_7_1.time_ and arg_7_1.time_ < var_10_6 + var_10_7 then
				local var_10_8 = (arg_7_1.time_ - var_10_6) / var_10_7
				local var_10_9 = Vector3.New(0.7, -0.97, -6)

				var_10_5.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1084ui_story, var_10_9, var_10_8)

				local var_10_10 = manager.ui.mainCamera.transform.position - var_10_5.position

				var_10_5.forward = Vector3.New(var_10_10.x, var_10_10.y, var_10_10.z)

				local var_10_11 = var_10_5.localEulerAngles

				var_10_11.z = 0
				var_10_11.x = 0
				var_10_5.localEulerAngles = var_10_11
			end

			if arg_7_1.time_ >= var_10_6 + var_10_7 and arg_7_1.time_ < var_10_6 + var_10_7 + arg_10_0 then
				var_10_5.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_10_12 = manager.ui.mainCamera.transform.position - var_10_5.position

				var_10_5.forward = Vector3.New(var_10_12.x, var_10_12.y, var_10_12.z)

				local var_10_13 = var_10_5.localEulerAngles

				var_10_13.z = 0
				var_10_13.x = 0
				var_10_5.localEulerAngles = var_10_13
			end

			local var_10_14 = 1.00008890058234e-12

			if var_10_14 < arg_7_1.time_ and arg_7_1.time_ <= var_10_14 + arg_10_0 then
				arg_7_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_10_15 = 1.00008890058234e-12

			if var_10_15 < arg_7_1.time_ and arg_7_1.time_ <= var_10_15 + arg_10_0 then
				arg_7_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_10_16 = arg_7_1.actors_["1084ui_story"]
			local var_10_17 = 0

			if var_10_17 < arg_7_1.time_ and arg_7_1.time_ <= var_10_17 + arg_10_0 and not isNil(var_10_16) and arg_7_1.var_.characterEffect1084ui_story == nil then
				arg_7_1.var_.characterEffect1084ui_story = var_10_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_18 = 0.2

			if var_10_17 <= arg_7_1.time_ and arg_7_1.time_ < var_10_17 + var_10_18 and not isNil(var_10_16) then
				local var_10_19 = (arg_7_1.time_ - var_10_17) / var_10_18

				if arg_7_1.var_.characterEffect1084ui_story and not isNil(var_10_16) then
					arg_7_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= var_10_17 + var_10_18 and arg_7_1.time_ < var_10_17 + var_10_18 + arg_10_0 and not isNil(var_10_16) and arg_7_1.var_.characterEffect1084ui_story then
				arg_7_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_10_20 = arg_7_1.actors_["1041ui_story"]
			local var_10_21 = 0

			if var_10_21 < arg_7_1.time_ and arg_7_1.time_ <= var_10_21 + arg_10_0 and not isNil(var_10_20) and arg_7_1.var_.characterEffect1041ui_story == nil then
				arg_7_1.var_.characterEffect1041ui_story = var_10_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_22 = 0.2

			if var_10_21 <= arg_7_1.time_ and arg_7_1.time_ < var_10_21 + var_10_22 and not isNil(var_10_20) then
				local var_10_23 = (arg_7_1.time_ - var_10_21) / var_10_22

				if arg_7_1.var_.characterEffect1041ui_story and not isNil(var_10_20) then
					local var_10_24 = Mathf.Lerp(0, 0.5, var_10_23)

					arg_7_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1041ui_story.fillRatio = var_10_24
				end
			end

			if arg_7_1.time_ >= var_10_21 + var_10_22 and arg_7_1.time_ < var_10_21 + var_10_22 + arg_10_0 and not isNil(var_10_20) and arg_7_1.var_.characterEffect1041ui_story then
				local var_10_25 = 0.5

				arg_7_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1041ui_story.fillRatio = var_10_25
			end

			local var_10_26 = 0
			local var_10_27 = 0.725

			if var_10_26 < arg_7_1.time_ and arg_7_1.time_ <= var_10_26 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				local var_10_28 = arg_7_1:FormatText(StoryNameCfg[6].name)

				arg_7_1.leftNameTxt_.text = var_10_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_29 = arg_7_1:GetWordFromCfg(113101002)
				local var_10_30 = arg_7_1:FormatText(var_10_29.content)

				arg_7_1.text_.text = var_10_30

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_31 = 29
				local var_10_32 = utf8.len(var_10_30)
				local var_10_33 = var_10_31 <= 0 and var_10_27 or var_10_27 * (var_10_32 / var_10_31)

				if var_10_33 > 0 and var_10_27 < var_10_33 then
					arg_7_1.talkMaxDuration = var_10_33

					if var_10_33 + var_10_26 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_33 + var_10_26
					end
				end

				arg_7_1.text_.text = var_10_30
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101002", "story_v_out_113101.awb") ~= 0 then
					local var_10_34 = manager.audio:GetVoiceLength("story_v_out_113101", "113101002", "story_v_out_113101.awb") / 1000

					if var_10_34 + var_10_26 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_34 + var_10_26
					end

					if var_10_29.prefab_name ~= "" and arg_7_1.actors_[var_10_29.prefab_name] ~= nil then
						local var_10_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_29.prefab_name].transform, "story_v_out_113101", "113101002", "story_v_out_113101.awb")

						arg_7_1:RecordAudio("113101002", var_10_35)
						arg_7_1:RecordAudio("113101002", var_10_35)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_113101", "113101002", "story_v_out_113101.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_113101", "113101002", "story_v_out_113101.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_36 = math.max(var_10_27, arg_7_1.talkMaxDuration)

			if var_10_26 <= arg_7_1.time_ and arg_7_1.time_ < var_10_26 + var_10_36 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_26) / var_10_36

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_26 + var_10_36 and arg_7_1.time_ < var_10_26 + var_10_36 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play113101003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 113101003
		arg_11_1.duration_ = 2.77

		local var_11_0 = {
			ja = 2.766,
			ko = 2.333,
			zh = 2,
			en = 2.433
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play113101004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 1.00008890058234e-12

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_14_1 = arg_11_1.actors_["1041ui_story"]
			local var_14_2 = 0

			if var_14_2 < arg_11_1.time_ and arg_11_1.time_ <= var_14_2 + arg_14_0 and not isNil(var_14_1) and arg_11_1.var_.characterEffect1041ui_story == nil then
				arg_11_1.var_.characterEffect1041ui_story = var_14_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_3 = 0.2

			if var_14_2 <= arg_11_1.time_ and arg_11_1.time_ < var_14_2 + var_14_3 and not isNil(var_14_1) then
				local var_14_4 = (arg_11_1.time_ - var_14_2) / var_14_3

				if arg_11_1.var_.characterEffect1041ui_story and not isNil(var_14_1) then
					arg_11_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= var_14_2 + var_14_3 and arg_11_1.time_ < var_14_2 + var_14_3 + arg_14_0 and not isNil(var_14_1) and arg_11_1.var_.characterEffect1041ui_story then
				arg_11_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_14_5 = arg_11_1.actors_["1084ui_story"]
			local var_14_6 = 0

			if var_14_6 < arg_11_1.time_ and arg_11_1.time_ <= var_14_6 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect1084ui_story == nil then
				arg_11_1.var_.characterEffect1084ui_story = var_14_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_7 = 0.2

			if var_14_6 <= arg_11_1.time_ and arg_11_1.time_ < var_14_6 + var_14_7 and not isNil(var_14_5) then
				local var_14_8 = (arg_11_1.time_ - var_14_6) / var_14_7

				if arg_11_1.var_.characterEffect1084ui_story and not isNil(var_14_5) then
					local var_14_9 = Mathf.Lerp(0, 0.5, var_14_8)

					arg_11_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1084ui_story.fillRatio = var_14_9
				end
			end

			if arg_11_1.time_ >= var_14_6 + var_14_7 and arg_11_1.time_ < var_14_6 + var_14_7 + arg_14_0 and not isNil(var_14_5) and arg_11_1.var_.characterEffect1084ui_story then
				local var_14_10 = 0.5

				arg_11_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1084ui_story.fillRatio = var_14_10
			end

			local var_14_11 = 0
			local var_14_12 = 0.2

			if var_14_11 < arg_11_1.time_ and arg_11_1.time_ <= var_14_11 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				local var_14_13 = arg_11_1:FormatText(StoryNameCfg[208].name)

				arg_11_1.leftNameTxt_.text = var_14_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_14 = arg_11_1:GetWordFromCfg(113101003)
				local var_14_15 = arg_11_1:FormatText(var_14_14.content)

				arg_11_1.text_.text = var_14_15

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_16 = 8
				local var_14_17 = utf8.len(var_14_15)
				local var_14_18 = var_14_16 <= 0 and var_14_12 or var_14_12 * (var_14_17 / var_14_16)

				if var_14_18 > 0 and var_14_12 < var_14_18 then
					arg_11_1.talkMaxDuration = var_14_18

					if var_14_18 + var_14_11 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_18 + var_14_11
					end
				end

				arg_11_1.text_.text = var_14_15
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101003", "story_v_out_113101.awb") ~= 0 then
					local var_14_19 = manager.audio:GetVoiceLength("story_v_out_113101", "113101003", "story_v_out_113101.awb") / 1000

					if var_14_19 + var_14_11 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_19 + var_14_11
					end

					if var_14_14.prefab_name ~= "" and arg_11_1.actors_[var_14_14.prefab_name] ~= nil then
						local var_14_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_14.prefab_name].transform, "story_v_out_113101", "113101003", "story_v_out_113101.awb")

						arg_11_1:RecordAudio("113101003", var_14_20)
						arg_11_1:RecordAudio("113101003", var_14_20)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_113101", "113101003", "story_v_out_113101.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_113101", "113101003", "story_v_out_113101.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_21 = math.max(var_14_12, arg_11_1.talkMaxDuration)

			if var_14_11 <= arg_11_1.time_ and arg_11_1.time_ < var_14_11 + var_14_21 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_11) / var_14_21

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_11 + var_14_21 and arg_11_1.time_ < var_14_11 + var_14_21 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play113101004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 113101004
		arg_15_1.duration_ = 8.83

		local var_15_0 = {
			ja = 8.833,
			ko = 4.666,
			zh = 4.666,
			en = 5.9
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play113101005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = arg_15_1.actors_["1084ui_story"].transform
			local var_18_1 = 1.00008890058234e-12

			if var_18_1 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.var_.moveOldPos1084ui_story = var_18_0.localPosition
			end

			local var_18_2 = 0.001

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_2 then
				local var_18_3 = (arg_15_1.time_ - var_18_1) / var_18_2
				local var_18_4 = Vector3.New(0, 100, 0)

				var_18_0.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1084ui_story, var_18_4, var_18_3)

				local var_18_5 = manager.ui.mainCamera.transform.position - var_18_0.position

				var_18_0.forward = Vector3.New(var_18_5.x, var_18_5.y, var_18_5.z)

				local var_18_6 = var_18_0.localEulerAngles

				var_18_6.z = 0
				var_18_6.x = 0
				var_18_0.localEulerAngles = var_18_6
			end

			if arg_15_1.time_ >= var_18_1 + var_18_2 and arg_15_1.time_ < var_18_1 + var_18_2 + arg_18_0 then
				var_18_0.localPosition = Vector3.New(0, 100, 0)

				local var_18_7 = manager.ui.mainCamera.transform.position - var_18_0.position

				var_18_0.forward = Vector3.New(var_18_7.x, var_18_7.y, var_18_7.z)

				local var_18_8 = var_18_0.localEulerAngles

				var_18_8.z = 0
				var_18_8.x = 0
				var_18_0.localEulerAngles = var_18_8
			end

			local var_18_9 = "1042ui_story"

			if arg_15_1.actors_[var_18_9] == nil then
				local var_18_10 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_18_10) then
					local var_18_11 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_15_1.stage_.transform)

					var_18_11.name = var_18_9
					var_18_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_15_1.actors_[var_18_9] = var_18_11

					local var_18_12 = var_18_11:GetComponentInChildren(typeof(CharacterEffect))

					var_18_12.enabled = true

					local var_18_13 = GameObjectTools.GetOrAddComponent(var_18_11, typeof(DynamicBoneHelper))

					if var_18_13 then
						var_18_13:EnableDynamicBone(false)
					end

					arg_15_1:ShowWeapon(var_18_12.transform, false)

					arg_15_1.var_[var_18_9 .. "Animator"] = var_18_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_15_1.var_[var_18_9 .. "Animator"].applyRootMotion = true
					arg_15_1.var_[var_18_9 .. "LipSync"] = var_18_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_18_14 = arg_15_1.actors_["1042ui_story"].transform
			local var_18_15 = 1.00008890058234e-12

			if var_18_15 < arg_15_1.time_ and arg_15_1.time_ <= var_18_15 + arg_18_0 then
				arg_15_1.var_.moveOldPos1042ui_story = var_18_14.localPosition
			end

			local var_18_16 = 0.001

			if var_18_15 <= arg_15_1.time_ and arg_15_1.time_ < var_18_15 + var_18_16 then
				local var_18_17 = (arg_15_1.time_ - var_18_15) / var_18_16
				local var_18_18 = Vector3.New(0.7, -1.06, -6.2)

				var_18_14.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1042ui_story, var_18_18, var_18_17)

				local var_18_19 = manager.ui.mainCamera.transform.position - var_18_14.position

				var_18_14.forward = Vector3.New(var_18_19.x, var_18_19.y, var_18_19.z)

				local var_18_20 = var_18_14.localEulerAngles

				var_18_20.z = 0
				var_18_20.x = 0
				var_18_14.localEulerAngles = var_18_20
			end

			if arg_15_1.time_ >= var_18_15 + var_18_16 and arg_15_1.time_ < var_18_15 + var_18_16 + arg_18_0 then
				var_18_14.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_18_21 = manager.ui.mainCamera.transform.position - var_18_14.position

				var_18_14.forward = Vector3.New(var_18_21.x, var_18_21.y, var_18_21.z)

				local var_18_22 = var_18_14.localEulerAngles

				var_18_22.z = 0
				var_18_22.x = 0
				var_18_14.localEulerAngles = var_18_22
			end

			local var_18_23 = 1.00008890058234e-12

			if var_18_23 < arg_15_1.time_ and arg_15_1.time_ <= var_18_23 + arg_18_0 then
				arg_15_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_18_24 = 1.00008890058234e-12

			if var_18_24 < arg_15_1.time_ and arg_15_1.time_ <= var_18_24 + arg_18_0 then
				arg_15_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_18_25 = arg_15_1.actors_["1042ui_story"]
			local var_18_26 = 0

			if var_18_26 < arg_15_1.time_ and arg_15_1.time_ <= var_18_26 + arg_18_0 and not isNil(var_18_25) and arg_15_1.var_.characterEffect1042ui_story == nil then
				arg_15_1.var_.characterEffect1042ui_story = var_18_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_27 = 0.2

			if var_18_26 <= arg_15_1.time_ and arg_15_1.time_ < var_18_26 + var_18_27 and not isNil(var_18_25) then
				local var_18_28 = (arg_15_1.time_ - var_18_26) / var_18_27

				if arg_15_1.var_.characterEffect1042ui_story and not isNil(var_18_25) then
					arg_15_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_26 + var_18_27 and arg_15_1.time_ < var_18_26 + var_18_27 + arg_18_0 and not isNil(var_18_25) and arg_15_1.var_.characterEffect1042ui_story then
				arg_15_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_18_29 = arg_15_1.actors_["1041ui_story"]
			local var_18_30 = 0

			if var_18_30 < arg_15_1.time_ and arg_15_1.time_ <= var_18_30 + arg_18_0 and not isNil(var_18_29) and arg_15_1.var_.characterEffect1041ui_story == nil then
				arg_15_1.var_.characterEffect1041ui_story = var_18_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_31 = 0.2

			if var_18_30 <= arg_15_1.time_ and arg_15_1.time_ < var_18_30 + var_18_31 and not isNil(var_18_29) then
				local var_18_32 = (arg_15_1.time_ - var_18_30) / var_18_31

				if arg_15_1.var_.characterEffect1041ui_story and not isNil(var_18_29) then
					local var_18_33 = Mathf.Lerp(0, 0.5, var_18_32)

					arg_15_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1041ui_story.fillRatio = var_18_33
				end
			end

			if arg_15_1.time_ >= var_18_30 + var_18_31 and arg_15_1.time_ < var_18_30 + var_18_31 + arg_18_0 and not isNil(var_18_29) and arg_15_1.var_.characterEffect1041ui_story then
				local var_18_34 = 0.5

				arg_15_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1041ui_story.fillRatio = var_18_34
			end

			local var_18_35 = 0
			local var_18_36 = 0.6

			if var_18_35 < arg_15_1.time_ and arg_15_1.time_ <= var_18_35 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_37 = arg_15_1:FormatText(StoryNameCfg[205].name)

				arg_15_1.leftNameTxt_.text = var_18_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_38 = arg_15_1:GetWordFromCfg(113101004)
				local var_18_39 = arg_15_1:FormatText(var_18_38.content)

				arg_15_1.text_.text = var_18_39

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_40 = 24
				local var_18_41 = utf8.len(var_18_39)
				local var_18_42 = var_18_40 <= 0 and var_18_36 or var_18_36 * (var_18_41 / var_18_40)

				if var_18_42 > 0 and var_18_36 < var_18_42 then
					arg_15_1.talkMaxDuration = var_18_42

					if var_18_42 + var_18_35 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_42 + var_18_35
					end
				end

				arg_15_1.text_.text = var_18_39
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101004", "story_v_out_113101.awb") ~= 0 then
					local var_18_43 = manager.audio:GetVoiceLength("story_v_out_113101", "113101004", "story_v_out_113101.awb") / 1000

					if var_18_43 + var_18_35 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_43 + var_18_35
					end

					if var_18_38.prefab_name ~= "" and arg_15_1.actors_[var_18_38.prefab_name] ~= nil then
						local var_18_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_38.prefab_name].transform, "story_v_out_113101", "113101004", "story_v_out_113101.awb")

						arg_15_1:RecordAudio("113101004", var_18_44)
						arg_15_1:RecordAudio("113101004", var_18_44)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_113101", "113101004", "story_v_out_113101.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_113101", "113101004", "story_v_out_113101.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_45 = math.max(var_18_36, arg_15_1.talkMaxDuration)

			if var_18_35 <= arg_15_1.time_ and arg_15_1.time_ < var_18_35 + var_18_45 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_35) / var_18_45

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_35 + var_18_45 and arg_15_1.time_ < var_18_35 + var_18_45 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play113101005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 113101005
		arg_19_1.duration_ = 5.87

		local var_19_0 = {
			ja = 4.666,
			ko = 5.366,
			zh = 4.366,
			en = 5.866
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play113101006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = arg_19_1.actors_["1042ui_story"].transform
			local var_22_1 = 1.00008890058234e-12

			if var_22_1 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				arg_19_1.var_.moveOldPos1042ui_story = var_22_0.localPosition
			end

			local var_22_2 = 0.001

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_2 then
				local var_22_3 = (arg_19_1.time_ - var_22_1) / var_22_2
				local var_22_4 = Vector3.New(0, 100, 0)

				var_22_0.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1042ui_story, var_22_4, var_22_3)

				local var_22_5 = manager.ui.mainCamera.transform.position - var_22_0.position

				var_22_0.forward = Vector3.New(var_22_5.x, var_22_5.y, var_22_5.z)

				local var_22_6 = var_22_0.localEulerAngles

				var_22_6.z = 0
				var_22_6.x = 0
				var_22_0.localEulerAngles = var_22_6
			end

			if arg_19_1.time_ >= var_22_1 + var_22_2 and arg_19_1.time_ < var_22_1 + var_22_2 + arg_22_0 then
				var_22_0.localPosition = Vector3.New(0, 100, 0)

				local var_22_7 = manager.ui.mainCamera.transform.position - var_22_0.position

				var_22_0.forward = Vector3.New(var_22_7.x, var_22_7.y, var_22_7.z)

				local var_22_8 = var_22_0.localEulerAngles

				var_22_8.z = 0
				var_22_8.x = 0
				var_22_0.localEulerAngles = var_22_8
			end

			local var_22_9 = arg_19_1.actors_["1084ui_story"].transform
			local var_22_10 = 1.00008890058234e-12

			if var_22_10 < arg_19_1.time_ and arg_19_1.time_ <= var_22_10 + arg_22_0 then
				arg_19_1.var_.moveOldPos1084ui_story = var_22_9.localPosition
			end

			local var_22_11 = 0.001

			if var_22_10 <= arg_19_1.time_ and arg_19_1.time_ < var_22_10 + var_22_11 then
				local var_22_12 = (arg_19_1.time_ - var_22_10) / var_22_11
				local var_22_13 = Vector3.New(0.7, -0.97, -6)

				var_22_9.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1084ui_story, var_22_13, var_22_12)

				local var_22_14 = manager.ui.mainCamera.transform.position - var_22_9.position

				var_22_9.forward = Vector3.New(var_22_14.x, var_22_14.y, var_22_14.z)

				local var_22_15 = var_22_9.localEulerAngles

				var_22_15.z = 0
				var_22_15.x = 0
				var_22_9.localEulerAngles = var_22_15
			end

			if arg_19_1.time_ >= var_22_10 + var_22_11 and arg_19_1.time_ < var_22_10 + var_22_11 + arg_22_0 then
				var_22_9.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_22_16 = manager.ui.mainCamera.transform.position - var_22_9.position

				var_22_9.forward = Vector3.New(var_22_16.x, var_22_16.y, var_22_16.z)

				local var_22_17 = var_22_9.localEulerAngles

				var_22_17.z = 0
				var_22_17.x = 0
				var_22_9.localEulerAngles = var_22_17
			end

			local var_22_18 = 1.00008890058234e-12

			if var_22_18 < arg_19_1.time_ and arg_19_1.time_ <= var_22_18 + arg_22_0 then
				arg_19_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			local var_22_19 = 0

			if var_22_19 < arg_19_1.time_ and arg_19_1.time_ <= var_22_19 + arg_22_0 then
				arg_19_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_22_20 = arg_19_1.actors_["1084ui_story"]
			local var_22_21 = 0

			if var_22_21 < arg_19_1.time_ and arg_19_1.time_ <= var_22_21 + arg_22_0 and not isNil(var_22_20) and arg_19_1.var_.characterEffect1084ui_story == nil then
				arg_19_1.var_.characterEffect1084ui_story = var_22_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_22 = 0.2

			if var_22_21 <= arg_19_1.time_ and arg_19_1.time_ < var_22_21 + var_22_22 and not isNil(var_22_20) then
				local var_22_23 = (arg_19_1.time_ - var_22_21) / var_22_22

				if arg_19_1.var_.characterEffect1084ui_story and not isNil(var_22_20) then
					arg_19_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= var_22_21 + var_22_22 and arg_19_1.time_ < var_22_21 + var_22_22 + arg_22_0 and not isNil(var_22_20) and arg_19_1.var_.characterEffect1084ui_story then
				arg_19_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_22_24 = 0
			local var_22_25 = 0.625

			if var_22_24 < arg_19_1.time_ and arg_19_1.time_ <= var_22_24 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_26 = arg_19_1:FormatText(StoryNameCfg[6].name)

				arg_19_1.leftNameTxt_.text = var_22_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_27 = arg_19_1:GetWordFromCfg(113101005)
				local var_22_28 = arg_19_1:FormatText(var_22_27.content)

				arg_19_1.text_.text = var_22_28

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_29 = 25
				local var_22_30 = utf8.len(var_22_28)
				local var_22_31 = var_22_29 <= 0 and var_22_25 or var_22_25 * (var_22_30 / var_22_29)

				if var_22_31 > 0 and var_22_25 < var_22_31 then
					arg_19_1.talkMaxDuration = var_22_31

					if var_22_31 + var_22_24 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_31 + var_22_24
					end
				end

				arg_19_1.text_.text = var_22_28
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101005", "story_v_out_113101.awb") ~= 0 then
					local var_22_32 = manager.audio:GetVoiceLength("story_v_out_113101", "113101005", "story_v_out_113101.awb") / 1000

					if var_22_32 + var_22_24 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_32 + var_22_24
					end

					if var_22_27.prefab_name ~= "" and arg_19_1.actors_[var_22_27.prefab_name] ~= nil then
						local var_22_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_27.prefab_name].transform, "story_v_out_113101", "113101005", "story_v_out_113101.awb")

						arg_19_1:RecordAudio("113101005", var_22_33)
						arg_19_1:RecordAudio("113101005", var_22_33)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_113101", "113101005", "story_v_out_113101.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_113101", "113101005", "story_v_out_113101.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_34 = math.max(var_22_25, arg_19_1.talkMaxDuration)

			if var_22_24 <= arg_19_1.time_ and arg_19_1.time_ < var_22_24 + var_22_34 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_24) / var_22_34

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_24 + var_22_34 and arg_19_1.time_ < var_22_24 + var_22_34 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play113101006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 113101006
		arg_23_1.duration_ = 2

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play113101007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["1084ui_story"]
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1084ui_story == nil then
				arg_23_1.var_.characterEffect1084ui_story = var_26_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.2

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 and not isNil(var_26_0) then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2

				if arg_23_1.var_.characterEffect1084ui_story and not isNil(var_26_0) then
					local var_26_4 = Mathf.Lerp(0, 0.5, var_26_3)

					arg_23_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1084ui_story.fillRatio = var_26_4
				end
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 and not isNil(var_26_0) and arg_23_1.var_.characterEffect1084ui_story then
				local var_26_5 = 0.5

				arg_23_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1084ui_story.fillRatio = var_26_5
			end

			local var_26_6 = 1.00008890058234e-12

			if var_26_6 < arg_23_1.time_ and arg_23_1.time_ <= var_26_6 + arg_26_0 then
				arg_23_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_26_7 = arg_23_1.actors_["1041ui_story"]
			local var_26_8 = 0

			if var_26_8 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 and not isNil(var_26_7) and arg_23_1.var_.characterEffect1041ui_story == nil then
				arg_23_1.var_.characterEffect1041ui_story = var_26_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_9 = 0.2

			if var_26_8 <= arg_23_1.time_ and arg_23_1.time_ < var_26_8 + var_26_9 and not isNil(var_26_7) then
				local var_26_10 = (arg_23_1.time_ - var_26_8) / var_26_9

				if arg_23_1.var_.characterEffect1041ui_story and not isNil(var_26_7) then
					arg_23_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= var_26_8 + var_26_9 and arg_23_1.time_ < var_26_8 + var_26_9 + arg_26_0 and not isNil(var_26_7) and arg_23_1.var_.characterEffect1041ui_story then
				arg_23_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_26_11 = 0
			local var_26_12 = 0.05

			if var_26_11 < arg_23_1.time_ and arg_23_1.time_ <= var_26_11 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				local var_26_13 = arg_23_1:FormatText(StoryNameCfg[208].name)

				arg_23_1.leftNameTxt_.text = var_26_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_14 = arg_23_1:GetWordFromCfg(113101006)
				local var_26_15 = arg_23_1:FormatText(var_26_14.content)

				arg_23_1.text_.text = var_26_15

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_16 = 2
				local var_26_17 = utf8.len(var_26_15)
				local var_26_18 = var_26_16 <= 0 and var_26_12 or var_26_12 * (var_26_17 / var_26_16)

				if var_26_18 > 0 and var_26_12 < var_26_18 then
					arg_23_1.talkMaxDuration = var_26_18

					if var_26_18 + var_26_11 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_18 + var_26_11
					end
				end

				arg_23_1.text_.text = var_26_15
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101006", "story_v_out_113101.awb") ~= 0 then
					local var_26_19 = manager.audio:GetVoiceLength("story_v_out_113101", "113101006", "story_v_out_113101.awb") / 1000

					if var_26_19 + var_26_11 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_19 + var_26_11
					end

					if var_26_14.prefab_name ~= "" and arg_23_1.actors_[var_26_14.prefab_name] ~= nil then
						local var_26_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_14.prefab_name].transform, "story_v_out_113101", "113101006", "story_v_out_113101.awb")

						arg_23_1:RecordAudio("113101006", var_26_20)
						arg_23_1:RecordAudio("113101006", var_26_20)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_113101", "113101006", "story_v_out_113101.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_113101", "113101006", "story_v_out_113101.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_21 = math.max(var_26_12, arg_23_1.talkMaxDuration)

			if var_26_11 <= arg_23_1.time_ and arg_23_1.time_ < var_26_11 + var_26_21 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_11) / var_26_21

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_11 + var_26_21 and arg_23_1.time_ < var_26_11 + var_26_21 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play113101007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 113101007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play113101008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = arg_27_1.actors_["1041ui_story"].transform
			local var_30_1 = 0

			if var_30_1 < arg_27_1.time_ and arg_27_1.time_ <= var_30_1 + arg_30_0 then
				arg_27_1.var_.moveOldPos1041ui_story = var_30_0.localPosition
			end

			local var_30_2 = 0.001

			if var_30_1 <= arg_27_1.time_ and arg_27_1.time_ < var_30_1 + var_30_2 then
				local var_30_3 = (arg_27_1.time_ - var_30_1) / var_30_2
				local var_30_4 = Vector3.New(0, 100, 0)

				var_30_0.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1041ui_story, var_30_4, var_30_3)

				local var_30_5 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_5.x, var_30_5.y, var_30_5.z)

				local var_30_6 = var_30_0.localEulerAngles

				var_30_6.z = 0
				var_30_6.x = 0
				var_30_0.localEulerAngles = var_30_6
			end

			if arg_27_1.time_ >= var_30_1 + var_30_2 and arg_27_1.time_ < var_30_1 + var_30_2 + arg_30_0 then
				var_30_0.localPosition = Vector3.New(0, 100, 0)

				local var_30_7 = manager.ui.mainCamera.transform.position - var_30_0.position

				var_30_0.forward = Vector3.New(var_30_7.x, var_30_7.y, var_30_7.z)

				local var_30_8 = var_30_0.localEulerAngles

				var_30_8.z = 0
				var_30_8.x = 0
				var_30_0.localEulerAngles = var_30_8
			end

			local var_30_9 = arg_27_1.actors_["1084ui_story"].transform
			local var_30_10 = 0

			if var_30_10 < arg_27_1.time_ and arg_27_1.time_ <= var_30_10 + arg_30_0 then
				arg_27_1.var_.moveOldPos1084ui_story = var_30_9.localPosition
			end

			local var_30_11 = 0.001

			if var_30_10 <= arg_27_1.time_ and arg_27_1.time_ < var_30_10 + var_30_11 then
				local var_30_12 = (arg_27_1.time_ - var_30_10) / var_30_11
				local var_30_13 = Vector3.New(0, 100, 0)

				var_30_9.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1084ui_story, var_30_13, var_30_12)

				local var_30_14 = manager.ui.mainCamera.transform.position - var_30_9.position

				var_30_9.forward = Vector3.New(var_30_14.x, var_30_14.y, var_30_14.z)

				local var_30_15 = var_30_9.localEulerAngles

				var_30_15.z = 0
				var_30_15.x = 0
				var_30_9.localEulerAngles = var_30_15
			end

			if arg_27_1.time_ >= var_30_10 + var_30_11 and arg_27_1.time_ < var_30_10 + var_30_11 + arg_30_0 then
				var_30_9.localPosition = Vector3.New(0, 100, 0)

				local var_30_16 = manager.ui.mainCamera.transform.position - var_30_9.position

				var_30_9.forward = Vector3.New(var_30_16.x, var_30_16.y, var_30_16.z)

				local var_30_17 = var_30_9.localEulerAngles

				var_30_17.z = 0
				var_30_17.x = 0
				var_30_9.localEulerAngles = var_30_17
			end

			local var_30_18 = 0
			local var_30_19 = 0.7

			if var_30_18 < arg_27_1.time_ and arg_27_1.time_ <= var_30_18 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_20 = arg_27_1:GetWordFromCfg(113101007)
				local var_30_21 = arg_27_1:FormatText(var_30_20.content)

				arg_27_1.text_.text = var_30_21

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_22 = 28
				local var_30_23 = utf8.len(var_30_21)
				local var_30_24 = var_30_22 <= 0 and var_30_19 or var_30_19 * (var_30_23 / var_30_22)

				if var_30_24 > 0 and var_30_19 < var_30_24 then
					arg_27_1.talkMaxDuration = var_30_24

					if var_30_24 + var_30_18 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_24 + var_30_18
					end
				end

				arg_27_1.text_.text = var_30_21
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_25 = math.max(var_30_19, arg_27_1.talkMaxDuration)

			if var_30_18 <= arg_27_1.time_ and arg_27_1.time_ < var_30_18 + var_30_25 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_18) / var_30_25

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_18 + var_30_25 and arg_27_1.time_ < var_30_18 + var_30_25 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
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

		arg_27_1:InitPlayNodeList()
	end,
	Play113101008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 113101008
		arg_31_1.duration_ = 2.63

		local var_31_0 = {
			ja = 2.633,
			ko = 2.633,
			zh = 2.2,
			en = 2.566
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play113101009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["1041ui_story"].transform
			local var_34_1 = 1.00008890058234e-12

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos1041ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(-0.7, -1.11, -5.9)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1041ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = 1.00008890058234e-12

			if var_34_9 < arg_31_1.time_ and arg_31_1.time_ <= var_34_9 + arg_34_0 then
				arg_31_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_34_10 = 1.00008890058234e-12

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 then
				arg_31_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_34_11 = arg_31_1.actors_["1041ui_story"]
			local var_34_12 = 0

			if var_34_12 < arg_31_1.time_ and arg_31_1.time_ <= var_34_12 + arg_34_0 and not isNil(var_34_11) and arg_31_1.var_.characterEffect1041ui_story == nil then
				arg_31_1.var_.characterEffect1041ui_story = var_34_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_13 = 0.2

			if var_34_12 <= arg_31_1.time_ and arg_31_1.time_ < var_34_12 + var_34_13 and not isNil(var_34_11) then
				local var_34_14 = (arg_31_1.time_ - var_34_12) / var_34_13

				if arg_31_1.var_.characterEffect1041ui_story and not isNil(var_34_11) then
					arg_31_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_12 + var_34_13 and arg_31_1.time_ < var_34_12 + var_34_13 + arg_34_0 and not isNil(var_34_11) and arg_31_1.var_.characterEffect1041ui_story then
				arg_31_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_34_15 = 0
			local var_34_16 = 0.3

			if var_34_15 < arg_31_1.time_ and arg_31_1.time_ <= var_34_15 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_17 = arg_31_1:FormatText(StoryNameCfg[208].name)

				arg_31_1.leftNameTxt_.text = var_34_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_18 = arg_31_1:GetWordFromCfg(113101008)
				local var_34_19 = arg_31_1:FormatText(var_34_18.content)

				arg_31_1.text_.text = var_34_19

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_20 = 12
				local var_34_21 = utf8.len(var_34_19)
				local var_34_22 = var_34_20 <= 0 and var_34_16 or var_34_16 * (var_34_21 / var_34_20)

				if var_34_22 > 0 and var_34_16 < var_34_22 then
					arg_31_1.talkMaxDuration = var_34_22

					if var_34_22 + var_34_15 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_22 + var_34_15
					end
				end

				arg_31_1.text_.text = var_34_19
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101008", "story_v_out_113101.awb") ~= 0 then
					local var_34_23 = manager.audio:GetVoiceLength("story_v_out_113101", "113101008", "story_v_out_113101.awb") / 1000

					if var_34_23 + var_34_15 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_23 + var_34_15
					end

					if var_34_18.prefab_name ~= "" and arg_31_1.actors_[var_34_18.prefab_name] ~= nil then
						local var_34_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_18.prefab_name].transform, "story_v_out_113101", "113101008", "story_v_out_113101.awb")

						arg_31_1:RecordAudio("113101008", var_34_24)
						arg_31_1:RecordAudio("113101008", var_34_24)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_113101", "113101008", "story_v_out_113101.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_113101", "113101008", "story_v_out_113101.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_25 = math.max(var_34_16, arg_31_1.talkMaxDuration)

			if var_34_15 <= arg_31_1.time_ and arg_31_1.time_ < var_34_15 + var_34_25 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_15) / var_34_25

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_15 + var_34_25 and arg_31_1.time_ < var_34_15 + var_34_25 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play113101009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 113101009
		arg_35_1.duration_ = 5.5

		local var_35_0 = {
			ja = 4.066,
			ko = 5.5,
			zh = 3.5,
			en = 2
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play113101010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1084ui_story"].transform
			local var_38_1 = 1.00008890058234e-12

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos1084ui_story = var_38_0.localPosition
			end

			local var_38_2 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2
				local var_38_4 = Vector3.New(0.7, -0.97, -6)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1084ui_story, var_38_4, var_38_3)

				local var_38_5 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_5.x, var_38_5.y, var_38_5.z)

				local var_38_6 = var_38_0.localEulerAngles

				var_38_6.z = 0
				var_38_6.x = 0
				var_38_0.localEulerAngles = var_38_6
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_38_7 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_7.x, var_38_7.y, var_38_7.z)

				local var_38_8 = var_38_0.localEulerAngles

				var_38_8.z = 0
				var_38_8.x = 0
				var_38_0.localEulerAngles = var_38_8
			end

			local var_38_9 = 0

			if var_38_9 < arg_35_1.time_ and arg_35_1.time_ <= var_38_9 + arg_38_0 then
				arg_35_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_38_10 = 1.00008890058234e-12

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 then
				arg_35_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_38_11 = arg_35_1.actors_["1084ui_story"]
			local var_38_12 = 0

			if var_38_12 < arg_35_1.time_ and arg_35_1.time_ <= var_38_12 + arg_38_0 and not isNil(var_38_11) and arg_35_1.var_.characterEffect1084ui_story == nil then
				arg_35_1.var_.characterEffect1084ui_story = var_38_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_13 = 0.2

			if var_38_12 <= arg_35_1.time_ and arg_35_1.time_ < var_38_12 + var_38_13 and not isNil(var_38_11) then
				local var_38_14 = (arg_35_1.time_ - var_38_12) / var_38_13

				if arg_35_1.var_.characterEffect1084ui_story and not isNil(var_38_11) then
					arg_35_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_12 + var_38_13 and arg_35_1.time_ < var_38_12 + var_38_13 + arg_38_0 and not isNil(var_38_11) and arg_35_1.var_.characterEffect1084ui_story then
				arg_35_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_38_15 = arg_35_1.actors_["1041ui_story"]
			local var_38_16 = 0

			if var_38_16 < arg_35_1.time_ and arg_35_1.time_ <= var_38_16 + arg_38_0 and not isNil(var_38_15) and arg_35_1.var_.characterEffect1041ui_story == nil then
				arg_35_1.var_.characterEffect1041ui_story = var_38_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_17 = 0.2

			if var_38_16 <= arg_35_1.time_ and arg_35_1.time_ < var_38_16 + var_38_17 and not isNil(var_38_15) then
				local var_38_18 = (arg_35_1.time_ - var_38_16) / var_38_17

				if arg_35_1.var_.characterEffect1041ui_story and not isNil(var_38_15) then
					local var_38_19 = Mathf.Lerp(0, 0.5, var_38_18)

					arg_35_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1041ui_story.fillRatio = var_38_19
				end
			end

			if arg_35_1.time_ >= var_38_16 + var_38_17 and arg_35_1.time_ < var_38_16 + var_38_17 + arg_38_0 and not isNil(var_38_15) and arg_35_1.var_.characterEffect1041ui_story then
				local var_38_20 = 0.5

				arg_35_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1041ui_story.fillRatio = var_38_20
			end

			local var_38_21 = 0
			local var_38_22 = 0.45

			if var_38_21 < arg_35_1.time_ and arg_35_1.time_ <= var_38_21 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_23 = arg_35_1:FormatText(StoryNameCfg[6].name)

				arg_35_1.leftNameTxt_.text = var_38_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_24 = arg_35_1:GetWordFromCfg(113101009)
				local var_38_25 = arg_35_1:FormatText(var_38_24.content)

				arg_35_1.text_.text = var_38_25

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_26 = 18
				local var_38_27 = utf8.len(var_38_25)
				local var_38_28 = var_38_26 <= 0 and var_38_22 or var_38_22 * (var_38_27 / var_38_26)

				if var_38_28 > 0 and var_38_22 < var_38_28 then
					arg_35_1.talkMaxDuration = var_38_28

					if var_38_28 + var_38_21 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_28 + var_38_21
					end
				end

				arg_35_1.text_.text = var_38_25
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101009", "story_v_out_113101.awb") ~= 0 then
					local var_38_29 = manager.audio:GetVoiceLength("story_v_out_113101", "113101009", "story_v_out_113101.awb") / 1000

					if var_38_29 + var_38_21 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_29 + var_38_21
					end

					if var_38_24.prefab_name ~= "" and arg_35_1.actors_[var_38_24.prefab_name] ~= nil then
						local var_38_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_24.prefab_name].transform, "story_v_out_113101", "113101009", "story_v_out_113101.awb")

						arg_35_1:RecordAudio("113101009", var_38_30)
						arg_35_1:RecordAudio("113101009", var_38_30)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_113101", "113101009", "story_v_out_113101.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_113101", "113101009", "story_v_out_113101.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_31 = math.max(var_38_22, arg_35_1.talkMaxDuration)

			if var_38_21 <= arg_35_1.time_ and arg_35_1.time_ < var_38_21 + var_38_31 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_21) / var_38_31

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_21 + var_38_31 and arg_35_1.time_ < var_38_21 + var_38_31 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play113101010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 113101010
		arg_39_1.duration_ = 7.07

		local var_39_0 = {
			ja = 7.066,
			ko = 5.966,
			zh = 6.433,
			en = 6.533
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play113101011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = arg_39_1.actors_["1084ui_story"]
			local var_42_1 = 0

			if var_42_1 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1084ui_story == nil then
				arg_39_1.var_.characterEffect1084ui_story = var_42_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.2

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_2 and not isNil(var_42_0) then
				local var_42_3 = (arg_39_1.time_ - var_42_1) / var_42_2

				if arg_39_1.var_.characterEffect1084ui_story and not isNil(var_42_0) then
					local var_42_4 = Mathf.Lerp(0, 0.5, var_42_3)

					arg_39_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1084ui_story.fillRatio = var_42_4
				end
			end

			if arg_39_1.time_ >= var_42_1 + var_42_2 and arg_39_1.time_ < var_42_1 + var_42_2 + arg_42_0 and not isNil(var_42_0) and arg_39_1.var_.characterEffect1084ui_story then
				local var_42_5 = 0.5

				arg_39_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1084ui_story.fillRatio = var_42_5
			end

			local var_42_6 = arg_39_1.actors_["1041ui_story"]
			local var_42_7 = 0

			if var_42_7 < arg_39_1.time_ and arg_39_1.time_ <= var_42_7 + arg_42_0 and not isNil(var_42_6) and arg_39_1.var_.characterEffect1041ui_story == nil then
				arg_39_1.var_.characterEffect1041ui_story = var_42_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_8 = 0.2

			if var_42_7 <= arg_39_1.time_ and arg_39_1.time_ < var_42_7 + var_42_8 and not isNil(var_42_6) then
				local var_42_9 = (arg_39_1.time_ - var_42_7) / var_42_8

				if arg_39_1.var_.characterEffect1041ui_story and not isNil(var_42_6) then
					arg_39_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= var_42_7 + var_42_8 and arg_39_1.time_ < var_42_7 + var_42_8 + arg_42_0 and not isNil(var_42_6) and arg_39_1.var_.characterEffect1041ui_story then
				arg_39_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_42_10 = 0

			if var_42_10 < arg_39_1.time_ and arg_39_1.time_ <= var_42_10 + arg_42_0 then
				arg_39_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_42_11 = 0

			if var_42_11 < arg_39_1.time_ and arg_39_1.time_ <= var_42_11 + arg_42_0 then
				arg_39_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_1")
			end

			local var_42_12 = 0
			local var_42_13 = 0.825

			if var_42_12 < arg_39_1.time_ and arg_39_1.time_ <= var_42_12 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				local var_42_14 = arg_39_1:FormatText(StoryNameCfg[208].name)

				arg_39_1.leftNameTxt_.text = var_42_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_15 = arg_39_1:GetWordFromCfg(113101010)
				local var_42_16 = arg_39_1:FormatText(var_42_15.content)

				arg_39_1.text_.text = var_42_16

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_17 = 33
				local var_42_18 = utf8.len(var_42_16)
				local var_42_19 = var_42_17 <= 0 and var_42_13 or var_42_13 * (var_42_18 / var_42_17)

				if var_42_19 > 0 and var_42_13 < var_42_19 then
					arg_39_1.talkMaxDuration = var_42_19

					if var_42_19 + var_42_12 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_19 + var_42_12
					end
				end

				arg_39_1.text_.text = var_42_16
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101010", "story_v_out_113101.awb") ~= 0 then
					local var_42_20 = manager.audio:GetVoiceLength("story_v_out_113101", "113101010", "story_v_out_113101.awb") / 1000

					if var_42_20 + var_42_12 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_20 + var_42_12
					end

					if var_42_15.prefab_name ~= "" and arg_39_1.actors_[var_42_15.prefab_name] ~= nil then
						local var_42_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_15.prefab_name].transform, "story_v_out_113101", "113101010", "story_v_out_113101.awb")

						arg_39_1:RecordAudio("113101010", var_42_21)
						arg_39_1:RecordAudio("113101010", var_42_21)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_113101", "113101010", "story_v_out_113101.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_113101", "113101010", "story_v_out_113101.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_22 = math.max(var_42_13, arg_39_1.talkMaxDuration)

			if var_42_12 <= arg_39_1.time_ and arg_39_1.time_ < var_42_12 + var_42_22 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_12) / var_42_22

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_12 + var_42_22 and arg_39_1.time_ < var_42_12 + var_42_22 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play113101011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 113101011
		arg_43_1.duration_ = 5.33

		local var_43_0 = {
			ja = 4.1,
			ko = 4.2,
			zh = 3.133,
			en = 5.333
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play113101012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = arg_43_1.actors_["1041ui_story"]
			local var_46_1 = 0

			if var_46_1 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1041ui_story == nil then
				arg_43_1.var_.characterEffect1041ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.2

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_2 and not isNil(var_46_0) then
				local var_46_3 = (arg_43_1.time_ - var_46_1) / var_46_2

				if arg_43_1.var_.characterEffect1041ui_story and not isNil(var_46_0) then
					local var_46_4 = Mathf.Lerp(0, 0.5, var_46_3)

					arg_43_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1041ui_story.fillRatio = var_46_4
				end
			end

			if arg_43_1.time_ >= var_46_1 + var_46_2 and arg_43_1.time_ < var_46_1 + var_46_2 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect1041ui_story then
				local var_46_5 = 0.5

				arg_43_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1041ui_story.fillRatio = var_46_5
			end

			local var_46_6 = arg_43_1.actors_["1084ui_story"]
			local var_46_7 = 0

			if var_46_7 < arg_43_1.time_ and arg_43_1.time_ <= var_46_7 + arg_46_0 and not isNil(var_46_6) and arg_43_1.var_.characterEffect1084ui_story == nil then
				arg_43_1.var_.characterEffect1084ui_story = var_46_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_8 = 0.2

			if var_46_7 <= arg_43_1.time_ and arg_43_1.time_ < var_46_7 + var_46_8 and not isNil(var_46_6) then
				local var_46_9 = (arg_43_1.time_ - var_46_7) / var_46_8

				if arg_43_1.var_.characterEffect1084ui_story and not isNil(var_46_6) then
					arg_43_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= var_46_7 + var_46_8 and arg_43_1.time_ < var_46_7 + var_46_8 + arg_46_0 and not isNil(var_46_6) and arg_43_1.var_.characterEffect1084ui_story then
				arg_43_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_46_10 = 1.00008890058234e-12

			if var_46_10 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 then
				arg_43_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_46_11 = 0
			local var_46_12 = 0.425

			if var_46_11 < arg_43_1.time_ and arg_43_1.time_ <= var_46_11 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				local var_46_13 = arg_43_1:FormatText(StoryNameCfg[6].name)

				arg_43_1.leftNameTxt_.text = var_46_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_14 = arg_43_1:GetWordFromCfg(113101011)
				local var_46_15 = arg_43_1:FormatText(var_46_14.content)

				arg_43_1.text_.text = var_46_15

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_16 = 17
				local var_46_17 = utf8.len(var_46_15)
				local var_46_18 = var_46_16 <= 0 and var_46_12 or var_46_12 * (var_46_17 / var_46_16)

				if var_46_18 > 0 and var_46_12 < var_46_18 then
					arg_43_1.talkMaxDuration = var_46_18

					if var_46_18 + var_46_11 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_18 + var_46_11
					end
				end

				arg_43_1.text_.text = var_46_15
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101011", "story_v_out_113101.awb") ~= 0 then
					local var_46_19 = manager.audio:GetVoiceLength("story_v_out_113101", "113101011", "story_v_out_113101.awb") / 1000

					if var_46_19 + var_46_11 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_19 + var_46_11
					end

					if var_46_14.prefab_name ~= "" and arg_43_1.actors_[var_46_14.prefab_name] ~= nil then
						local var_46_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_14.prefab_name].transform, "story_v_out_113101", "113101011", "story_v_out_113101.awb")

						arg_43_1:RecordAudio("113101011", var_46_20)
						arg_43_1:RecordAudio("113101011", var_46_20)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_113101", "113101011", "story_v_out_113101.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_113101", "113101011", "story_v_out_113101.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_21 = math.max(var_46_12, arg_43_1.talkMaxDuration)

			if var_46_11 <= arg_43_1.time_ and arg_43_1.time_ < var_46_11 + var_46_21 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_11) / var_46_21

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_11 + var_46_21 and arg_43_1.time_ < var_46_11 + var_46_21 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play113101012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 113101012
		arg_47_1.duration_ = 8.97

		local var_47_0 = {
			ja = 8.966,
			ko = 6.233,
			zh = 5.633,
			en = 4.966
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
				arg_47_0:Play113101013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = arg_47_1.actors_["1041ui_story"]
			local var_50_1 = 0

			if var_50_1 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1041ui_story == nil then
				arg_47_1.var_.characterEffect1041ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.2

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_2 and not isNil(var_50_0) then
				local var_50_3 = (arg_47_1.time_ - var_50_1) / var_50_2

				if arg_47_1.var_.characterEffect1041ui_story and not isNil(var_50_0) then
					arg_47_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= var_50_1 + var_50_2 and arg_47_1.time_ < var_50_1 + var_50_2 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1041ui_story then
				arg_47_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_50_4 = arg_47_1.actors_["1084ui_story"]
			local var_50_5 = 0

			if var_50_5 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1084ui_story == nil then
				arg_47_1.var_.characterEffect1084ui_story = var_50_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_6 = 0.2

			if var_50_5 <= arg_47_1.time_ and arg_47_1.time_ < var_50_5 + var_50_6 and not isNil(var_50_4) then
				local var_50_7 = (arg_47_1.time_ - var_50_5) / var_50_6

				if arg_47_1.var_.characterEffect1084ui_story and not isNil(var_50_4) then
					local var_50_8 = Mathf.Lerp(0, 0.5, var_50_7)

					arg_47_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1084ui_story.fillRatio = var_50_8
				end
			end

			if arg_47_1.time_ >= var_50_5 + var_50_6 and arg_47_1.time_ < var_50_5 + var_50_6 + arg_50_0 and not isNil(var_50_4) and arg_47_1.var_.characterEffect1084ui_story then
				local var_50_9 = 0.5

				arg_47_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1084ui_story.fillRatio = var_50_9
			end

			local var_50_10 = 0

			if var_50_10 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 then
				arg_47_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_2")
			end

			local var_50_11 = 0

			if var_50_11 < arg_47_1.time_ and arg_47_1.time_ <= var_50_11 + arg_50_0 then
				arg_47_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_50_12 = 0
			local var_50_13 = 0.775

			if var_50_12 < arg_47_1.time_ and arg_47_1.time_ <= var_50_12 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_14 = arg_47_1:FormatText(StoryNameCfg[208].name)

				arg_47_1.leftNameTxt_.text = var_50_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_15 = arg_47_1:GetWordFromCfg(113101012)
				local var_50_16 = arg_47_1:FormatText(var_50_15.content)

				arg_47_1.text_.text = var_50_16

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_17 = 31
				local var_50_18 = utf8.len(var_50_16)
				local var_50_19 = var_50_17 <= 0 and var_50_13 or var_50_13 * (var_50_18 / var_50_17)

				if var_50_19 > 0 and var_50_13 < var_50_19 then
					arg_47_1.talkMaxDuration = var_50_19

					if var_50_19 + var_50_12 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_19 + var_50_12
					end
				end

				arg_47_1.text_.text = var_50_16
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101012", "story_v_out_113101.awb") ~= 0 then
					local var_50_20 = manager.audio:GetVoiceLength("story_v_out_113101", "113101012", "story_v_out_113101.awb") / 1000

					if var_50_20 + var_50_12 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_20 + var_50_12
					end

					if var_50_15.prefab_name ~= "" and arg_47_1.actors_[var_50_15.prefab_name] ~= nil then
						local var_50_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_15.prefab_name].transform, "story_v_out_113101", "113101012", "story_v_out_113101.awb")

						arg_47_1:RecordAudio("113101012", var_50_21)
						arg_47_1:RecordAudio("113101012", var_50_21)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_113101", "113101012", "story_v_out_113101.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_113101", "113101012", "story_v_out_113101.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_22 = math.max(var_50_13, arg_47_1.talkMaxDuration)

			if var_50_12 <= arg_47_1.time_ and arg_47_1.time_ < var_50_12 + var_50_22 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_12) / var_50_22

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_12 + var_50_22 and arg_47_1.time_ < var_50_12 + var_50_22 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play113101013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 113101013
		arg_51_1.duration_ = 9.1

		local var_51_0 = {
			ja = 9.1,
			ko = 8.6,
			zh = 8.933,
			en = 6.733
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
				arg_51_0:Play113101014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_54_1 = 0
			local var_54_2 = 1.1

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_3 = arg_51_1:FormatText(StoryNameCfg[208].name)

				arg_51_1.leftNameTxt_.text = var_54_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_4 = arg_51_1:GetWordFromCfg(113101013)
				local var_54_5 = arg_51_1:FormatText(var_54_4.content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_6 = 44
				local var_54_7 = utf8.len(var_54_5)
				local var_54_8 = var_54_6 <= 0 and var_54_2 or var_54_2 * (var_54_7 / var_54_6)

				if var_54_8 > 0 and var_54_2 < var_54_8 then
					arg_51_1.talkMaxDuration = var_54_8

					if var_54_8 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101013", "story_v_out_113101.awb") ~= 0 then
					local var_54_9 = manager.audio:GetVoiceLength("story_v_out_113101", "113101013", "story_v_out_113101.awb") / 1000

					if var_54_9 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_9 + var_54_1
					end

					if var_54_4.prefab_name ~= "" and arg_51_1.actors_[var_54_4.prefab_name] ~= nil then
						local var_54_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_4.prefab_name].transform, "story_v_out_113101", "113101013", "story_v_out_113101.awb")

						arg_51_1:RecordAudio("113101013", var_54_10)
						arg_51_1:RecordAudio("113101013", var_54_10)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_113101", "113101013", "story_v_out_113101.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_113101", "113101013", "story_v_out_113101.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_11 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_11 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_11

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_11 and arg_51_1.time_ < var_54_1 + var_54_11 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play113101014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 113101014
		arg_55_1.duration_ = 4.03

		local var_55_0 = {
			ja = 4.033,
			ko = 3.1,
			zh = 3.566,
			en = 3.233
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
				arg_55_0:Play113101015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1042ui_story"].transform
			local var_58_1 = 1.00008890058234e-12

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1042ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(0.7, -1.06, -6.2)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1042ui_story, var_58_4, var_58_3)

				local var_58_5 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_5.x, var_58_5.y, var_58_5.z)

				local var_58_6 = var_58_0.localEulerAngles

				var_58_6.z = 0
				var_58_6.x = 0
				var_58_0.localEulerAngles = var_58_6
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_58_7 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_7.x, var_58_7.y, var_58_7.z)

				local var_58_8 = var_58_0.localEulerAngles

				var_58_8.z = 0
				var_58_8.x = 0
				var_58_0.localEulerAngles = var_58_8
			end

			local var_58_9 = 1.00008890058234e-12

			if var_58_9 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 then
				arg_55_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_58_10 = 1.00008890058234e-12

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 then
				arg_55_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_58_11 = arg_55_1.actors_["1042ui_story"]
			local var_58_12 = 0

			if var_58_12 < arg_55_1.time_ and arg_55_1.time_ <= var_58_12 + arg_58_0 and not isNil(var_58_11) and arg_55_1.var_.characterEffect1042ui_story == nil then
				arg_55_1.var_.characterEffect1042ui_story = var_58_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_13 = 0.2

			if var_58_12 <= arg_55_1.time_ and arg_55_1.time_ < var_58_12 + var_58_13 and not isNil(var_58_11) then
				local var_58_14 = (arg_55_1.time_ - var_58_12) / var_58_13

				if arg_55_1.var_.characterEffect1042ui_story and not isNil(var_58_11) then
					arg_55_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= var_58_12 + var_58_13 and arg_55_1.time_ < var_58_12 + var_58_13 + arg_58_0 and not isNil(var_58_11) and arg_55_1.var_.characterEffect1042ui_story then
				arg_55_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_58_15 = arg_55_1.actors_["1041ui_story"]
			local var_58_16 = 0

			if var_58_16 < arg_55_1.time_ and arg_55_1.time_ <= var_58_16 + arg_58_0 and not isNil(var_58_15) and arg_55_1.var_.characterEffect1041ui_story == nil then
				arg_55_1.var_.characterEffect1041ui_story = var_58_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_17 = 0.2

			if var_58_16 <= arg_55_1.time_ and arg_55_1.time_ < var_58_16 + var_58_17 and not isNil(var_58_15) then
				local var_58_18 = (arg_55_1.time_ - var_58_16) / var_58_17

				if arg_55_1.var_.characterEffect1041ui_story and not isNil(var_58_15) then
					local var_58_19 = Mathf.Lerp(0, 0.5, var_58_18)

					arg_55_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1041ui_story.fillRatio = var_58_19
				end
			end

			if arg_55_1.time_ >= var_58_16 + var_58_17 and arg_55_1.time_ < var_58_16 + var_58_17 + arg_58_0 and not isNil(var_58_15) and arg_55_1.var_.characterEffect1041ui_story then
				local var_58_20 = 0.5

				arg_55_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1041ui_story.fillRatio = var_58_20
			end

			local var_58_21 = arg_55_1.actors_["1084ui_story"].transform
			local var_58_22 = 1.00008890058234e-12

			if var_58_22 < arg_55_1.time_ and arg_55_1.time_ <= var_58_22 + arg_58_0 then
				arg_55_1.var_.moveOldPos1084ui_story = var_58_21.localPosition
			end

			local var_58_23 = 0.001

			if var_58_22 <= arg_55_1.time_ and arg_55_1.time_ < var_58_22 + var_58_23 then
				local var_58_24 = (arg_55_1.time_ - var_58_22) / var_58_23
				local var_58_25 = Vector3.New(0, 100, 0)

				var_58_21.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1084ui_story, var_58_25, var_58_24)

				local var_58_26 = manager.ui.mainCamera.transform.position - var_58_21.position

				var_58_21.forward = Vector3.New(var_58_26.x, var_58_26.y, var_58_26.z)

				local var_58_27 = var_58_21.localEulerAngles

				var_58_27.z = 0
				var_58_27.x = 0
				var_58_21.localEulerAngles = var_58_27
			end

			if arg_55_1.time_ >= var_58_22 + var_58_23 and arg_55_1.time_ < var_58_22 + var_58_23 + arg_58_0 then
				var_58_21.localPosition = Vector3.New(0, 100, 0)

				local var_58_28 = manager.ui.mainCamera.transform.position - var_58_21.position

				var_58_21.forward = Vector3.New(var_58_28.x, var_58_28.y, var_58_28.z)

				local var_58_29 = var_58_21.localEulerAngles

				var_58_29.z = 0
				var_58_29.x = 0
				var_58_21.localEulerAngles = var_58_29
			end

			local var_58_30 = 0
			local var_58_31 = 0.35

			if var_58_30 < arg_55_1.time_ and arg_55_1.time_ <= var_58_30 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_32 = arg_55_1:FormatText(StoryNameCfg[205].name)

				arg_55_1.leftNameTxt_.text = var_58_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_33 = arg_55_1:GetWordFromCfg(113101014)
				local var_58_34 = arg_55_1:FormatText(var_58_33.content)

				arg_55_1.text_.text = var_58_34

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_35 = 14
				local var_58_36 = utf8.len(var_58_34)
				local var_58_37 = var_58_35 <= 0 and var_58_31 or var_58_31 * (var_58_36 / var_58_35)

				if var_58_37 > 0 and var_58_31 < var_58_37 then
					arg_55_1.talkMaxDuration = var_58_37

					if var_58_37 + var_58_30 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_37 + var_58_30
					end
				end

				arg_55_1.text_.text = var_58_34
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101014", "story_v_out_113101.awb") ~= 0 then
					local var_58_38 = manager.audio:GetVoiceLength("story_v_out_113101", "113101014", "story_v_out_113101.awb") / 1000

					if var_58_38 + var_58_30 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_38 + var_58_30
					end

					if var_58_33.prefab_name ~= "" and arg_55_1.actors_[var_58_33.prefab_name] ~= nil then
						local var_58_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_33.prefab_name].transform, "story_v_out_113101", "113101014", "story_v_out_113101.awb")

						arg_55_1:RecordAudio("113101014", var_58_39)
						arg_55_1:RecordAudio("113101014", var_58_39)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_113101", "113101014", "story_v_out_113101.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_113101", "113101014", "story_v_out_113101.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_40 = math.max(var_58_31, arg_55_1.talkMaxDuration)

			if var_58_30 <= arg_55_1.time_ and arg_55_1.time_ < var_58_30 + var_58_40 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_30) / var_58_40

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_30 + var_58_40 and arg_55_1.time_ < var_58_30 + var_58_40 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play113101015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 113101015
		arg_59_1.duration_ = 2.83

		local var_59_0 = {
			ja = 1.999999999999,
			ko = 2.266,
			zh = 2.833,
			en = 2.566
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
				arg_59_0:Play113101016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1041ui_story"]
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1041ui_story == nil then
				arg_59_1.var_.characterEffect1041ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.2

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 and not isNil(var_62_0) then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2

				if arg_59_1.var_.characterEffect1041ui_story and not isNil(var_62_0) then
					arg_59_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1041ui_story then
				arg_59_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_62_4 = arg_59_1.actors_["1042ui_story"]
			local var_62_5 = 0

			if var_62_5 < arg_59_1.time_ and arg_59_1.time_ <= var_62_5 + arg_62_0 and not isNil(var_62_4) and arg_59_1.var_.characterEffect1042ui_story == nil then
				arg_59_1.var_.characterEffect1042ui_story = var_62_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_6 = 0.2

			if var_62_5 <= arg_59_1.time_ and arg_59_1.time_ < var_62_5 + var_62_6 and not isNil(var_62_4) then
				local var_62_7 = (arg_59_1.time_ - var_62_5) / var_62_6

				if arg_59_1.var_.characterEffect1042ui_story and not isNil(var_62_4) then
					local var_62_8 = Mathf.Lerp(0, 0.5, var_62_7)

					arg_59_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1042ui_story.fillRatio = var_62_8
				end
			end

			if arg_59_1.time_ >= var_62_5 + var_62_6 and arg_59_1.time_ < var_62_5 + var_62_6 + arg_62_0 and not isNil(var_62_4) and arg_59_1.var_.characterEffect1042ui_story then
				local var_62_9 = 0.5

				arg_59_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1042ui_story.fillRatio = var_62_9
			end

			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 then
				arg_59_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_62_11 = 0
			local var_62_12 = 0.325

			if var_62_11 < arg_59_1.time_ and arg_59_1.time_ <= var_62_11 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_13 = arg_59_1:FormatText(StoryNameCfg[208].name)

				arg_59_1.leftNameTxt_.text = var_62_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_14 = arg_59_1:GetWordFromCfg(113101015)
				local var_62_15 = arg_59_1:FormatText(var_62_14.content)

				arg_59_1.text_.text = var_62_15

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_16 = 13
				local var_62_17 = utf8.len(var_62_15)
				local var_62_18 = var_62_16 <= 0 and var_62_12 or var_62_12 * (var_62_17 / var_62_16)

				if var_62_18 > 0 and var_62_12 < var_62_18 then
					arg_59_1.talkMaxDuration = var_62_18

					if var_62_18 + var_62_11 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_18 + var_62_11
					end
				end

				arg_59_1.text_.text = var_62_15
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101015", "story_v_out_113101.awb") ~= 0 then
					local var_62_19 = manager.audio:GetVoiceLength("story_v_out_113101", "113101015", "story_v_out_113101.awb") / 1000

					if var_62_19 + var_62_11 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_19 + var_62_11
					end

					if var_62_14.prefab_name ~= "" and arg_59_1.actors_[var_62_14.prefab_name] ~= nil then
						local var_62_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_14.prefab_name].transform, "story_v_out_113101", "113101015", "story_v_out_113101.awb")

						arg_59_1:RecordAudio("113101015", var_62_20)
						arg_59_1:RecordAudio("113101015", var_62_20)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_113101", "113101015", "story_v_out_113101.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_113101", "113101015", "story_v_out_113101.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_21 = math.max(var_62_12, arg_59_1.talkMaxDuration)

			if var_62_11 <= arg_59_1.time_ and arg_59_1.time_ < var_62_11 + var_62_21 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_11) / var_62_21

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_11 + var_62_21 and arg_59_1.time_ < var_62_11 + var_62_21 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play113101016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 113101016
		arg_63_1.duration_ = 7.17

		local var_63_0 = {
			ja = 7.166,
			ko = 4.066,
			zh = 3.8,
			en = 4.466
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
				arg_63_0:Play113101017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 then
				arg_63_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_1")
			end

			local var_66_2 = 0
			local var_66_3 = 0.475

			if var_66_2 < arg_63_1.time_ and arg_63_1.time_ <= var_66_2 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_4 = arg_63_1:FormatText(StoryNameCfg[208].name)

				arg_63_1.leftNameTxt_.text = var_66_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_5 = arg_63_1:GetWordFromCfg(113101016)
				local var_66_6 = arg_63_1:FormatText(var_66_5.content)

				arg_63_1.text_.text = var_66_6

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_7 = 19
				local var_66_8 = utf8.len(var_66_6)
				local var_66_9 = var_66_7 <= 0 and var_66_3 or var_66_3 * (var_66_8 / var_66_7)

				if var_66_9 > 0 and var_66_3 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_2
					end
				end

				arg_63_1.text_.text = var_66_6
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101016", "story_v_out_113101.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_out_113101", "113101016", "story_v_out_113101.awb") / 1000

					if var_66_10 + var_66_2 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_2
					end

					if var_66_5.prefab_name ~= "" and arg_63_1.actors_[var_66_5.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_5.prefab_name].transform, "story_v_out_113101", "113101016", "story_v_out_113101.awb")

						arg_63_1:RecordAudio("113101016", var_66_11)
						arg_63_1:RecordAudio("113101016", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_113101", "113101016", "story_v_out_113101.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_113101", "113101016", "story_v_out_113101.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_3, arg_63_1.talkMaxDuration)

			if var_66_2 <= arg_63_1.time_ and arg_63_1.time_ < var_66_2 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_2) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_2 + var_66_12 and arg_63_1.time_ < var_66_2 + var_66_12 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play113101017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 113101017
		arg_67_1.duration_ = 4.23

		local var_67_0 = {
			ja = 4.233,
			ko = 2.7,
			zh = 2.3,
			en = 2.2
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
				arg_67_0:Play113101018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 1.00008890058234e-12

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_70_1 = 1.00008890058234e-12

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_70_2 = arg_67_1.actors_["1042ui_story"]
			local var_70_3 = 0

			if var_70_3 < arg_67_1.time_ and arg_67_1.time_ <= var_70_3 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.characterEffect1042ui_story == nil then
				arg_67_1.var_.characterEffect1042ui_story = var_70_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_4 = 0.2

			if var_70_3 <= arg_67_1.time_ and arg_67_1.time_ < var_70_3 + var_70_4 and not isNil(var_70_2) then
				local var_70_5 = (arg_67_1.time_ - var_70_3) / var_70_4

				if arg_67_1.var_.characterEffect1042ui_story and not isNil(var_70_2) then
					arg_67_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_3 + var_70_4 and arg_67_1.time_ < var_70_3 + var_70_4 + arg_70_0 and not isNil(var_70_2) and arg_67_1.var_.characterEffect1042ui_story then
				arg_67_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_70_6 = arg_67_1.actors_["1041ui_story"]
			local var_70_7 = 0

			if var_70_7 < arg_67_1.time_ and arg_67_1.time_ <= var_70_7 + arg_70_0 and not isNil(var_70_6) and arg_67_1.var_.characterEffect1041ui_story == nil then
				arg_67_1.var_.characterEffect1041ui_story = var_70_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_8 = 0.2

			if var_70_7 <= arg_67_1.time_ and arg_67_1.time_ < var_70_7 + var_70_8 and not isNil(var_70_6) then
				local var_70_9 = (arg_67_1.time_ - var_70_7) / var_70_8

				if arg_67_1.var_.characterEffect1041ui_story and not isNil(var_70_6) then
					local var_70_10 = Mathf.Lerp(0, 0.5, var_70_9)

					arg_67_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1041ui_story.fillRatio = var_70_10
				end
			end

			if arg_67_1.time_ >= var_70_7 + var_70_8 and arg_67_1.time_ < var_70_7 + var_70_8 + arg_70_0 and not isNil(var_70_6) and arg_67_1.var_.characterEffect1041ui_story then
				local var_70_11 = 0.5

				arg_67_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1041ui_story.fillRatio = var_70_11
			end

			local var_70_12 = 0
			local var_70_13 = 0.25

			if var_70_12 < arg_67_1.time_ and arg_67_1.time_ <= var_70_12 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_14 = arg_67_1:FormatText(StoryNameCfg[205].name)

				arg_67_1.leftNameTxt_.text = var_70_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_15 = arg_67_1:GetWordFromCfg(113101017)
				local var_70_16 = arg_67_1:FormatText(var_70_15.content)

				arg_67_1.text_.text = var_70_16

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_17 = 10
				local var_70_18 = utf8.len(var_70_16)
				local var_70_19 = var_70_17 <= 0 and var_70_13 or var_70_13 * (var_70_18 / var_70_17)

				if var_70_19 > 0 and var_70_13 < var_70_19 then
					arg_67_1.talkMaxDuration = var_70_19

					if var_70_19 + var_70_12 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_19 + var_70_12
					end
				end

				arg_67_1.text_.text = var_70_16
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101017", "story_v_out_113101.awb") ~= 0 then
					local var_70_20 = manager.audio:GetVoiceLength("story_v_out_113101", "113101017", "story_v_out_113101.awb") / 1000

					if var_70_20 + var_70_12 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_20 + var_70_12
					end

					if var_70_15.prefab_name ~= "" and arg_67_1.actors_[var_70_15.prefab_name] ~= nil then
						local var_70_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_15.prefab_name].transform, "story_v_out_113101", "113101017", "story_v_out_113101.awb")

						arg_67_1:RecordAudio("113101017", var_70_21)
						arg_67_1:RecordAudio("113101017", var_70_21)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_113101", "113101017", "story_v_out_113101.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_113101", "113101017", "story_v_out_113101.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_22 = math.max(var_70_13, arg_67_1.talkMaxDuration)

			if var_70_12 <= arg_67_1.time_ and arg_67_1.time_ < var_70_12 + var_70_22 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_12) / var_70_22

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_12 + var_70_22 and arg_67_1.time_ < var_70_12 + var_70_22 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play113101018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 113101018
		arg_71_1.duration_ = 3.1

		local var_71_0 = {
			ja = 2.1,
			ko = 2,
			zh = 2,
			en = 3.1
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
				arg_71_0:Play113101019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1041ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1041ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, 100, 0)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1041ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, 100, 0)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = arg_71_1.actors_["1042ui_story"].transform
			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 then
				arg_71_1.var_.moveOldPos1042ui_story = var_74_9.localPosition
			end

			local var_74_11 = 0.001

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_11 then
				local var_74_12 = (arg_71_1.time_ - var_74_10) / var_74_11
				local var_74_13 = Vector3.New(0, 100, 0)

				var_74_9.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1042ui_story, var_74_13, var_74_12)

				local var_74_14 = manager.ui.mainCamera.transform.position - var_74_9.position

				var_74_9.forward = Vector3.New(var_74_14.x, var_74_14.y, var_74_14.z)

				local var_74_15 = var_74_9.localEulerAngles

				var_74_15.z = 0
				var_74_15.x = 0
				var_74_9.localEulerAngles = var_74_15
			end

			if arg_71_1.time_ >= var_74_10 + var_74_11 and arg_71_1.time_ < var_74_10 + var_74_11 + arg_74_0 then
				var_74_9.localPosition = Vector3.New(0, 100, 0)

				local var_74_16 = manager.ui.mainCamera.transform.position - var_74_9.position

				var_74_9.forward = Vector3.New(var_74_16.x, var_74_16.y, var_74_16.z)

				local var_74_17 = var_74_9.localEulerAngles

				var_74_17.z = 0
				var_74_17.x = 0
				var_74_9.localEulerAngles = var_74_17
			end

			local var_74_18 = arg_71_1.actors_["1084ui_story"].transform
			local var_74_19 = 1.00008890058234e-12

			if var_74_19 < arg_71_1.time_ and arg_71_1.time_ <= var_74_19 + arg_74_0 then
				arg_71_1.var_.moveOldPos1084ui_story = var_74_18.localPosition
			end

			local var_74_20 = 0.001

			if var_74_19 <= arg_71_1.time_ and arg_71_1.time_ < var_74_19 + var_74_20 then
				local var_74_21 = (arg_71_1.time_ - var_74_19) / var_74_20
				local var_74_22 = Vector3.New(0, -0.97, -6)

				var_74_18.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1084ui_story, var_74_22, var_74_21)

				local var_74_23 = manager.ui.mainCamera.transform.position - var_74_18.position

				var_74_18.forward = Vector3.New(var_74_23.x, var_74_23.y, var_74_23.z)

				local var_74_24 = var_74_18.localEulerAngles

				var_74_24.z = 0
				var_74_24.x = 0
				var_74_18.localEulerAngles = var_74_24
			end

			if arg_71_1.time_ >= var_74_19 + var_74_20 and arg_71_1.time_ < var_74_19 + var_74_20 + arg_74_0 then
				var_74_18.localPosition = Vector3.New(0, -0.97, -6)

				local var_74_25 = manager.ui.mainCamera.transform.position - var_74_18.position

				var_74_18.forward = Vector3.New(var_74_25.x, var_74_25.y, var_74_25.z)

				local var_74_26 = var_74_18.localEulerAngles

				var_74_26.z = 0
				var_74_26.x = 0
				var_74_18.localEulerAngles = var_74_26
			end

			local var_74_27 = 1.00008890058234e-12

			if var_74_27 < arg_71_1.time_ and arg_71_1.time_ <= var_74_27 + arg_74_0 then
				arg_71_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_74_28 = 1.00008890058234e-12

			if var_74_28 < arg_71_1.time_ and arg_71_1.time_ <= var_74_28 + arg_74_0 then
				arg_71_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_74_29 = arg_71_1.actors_["1084ui_story"]
			local var_74_30 = 0

			if var_74_30 < arg_71_1.time_ and arg_71_1.time_ <= var_74_30 + arg_74_0 and not isNil(var_74_29) and arg_71_1.var_.characterEffect1084ui_story == nil then
				arg_71_1.var_.characterEffect1084ui_story = var_74_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_31 = 0.2

			if var_74_30 <= arg_71_1.time_ and arg_71_1.time_ < var_74_30 + var_74_31 and not isNil(var_74_29) then
				local var_74_32 = (arg_71_1.time_ - var_74_30) / var_74_31

				if arg_71_1.var_.characterEffect1084ui_story and not isNil(var_74_29) then
					arg_71_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_30 + var_74_31 and arg_71_1.time_ < var_74_30 + var_74_31 + arg_74_0 and not isNil(var_74_29) and arg_71_1.var_.characterEffect1084ui_story then
				arg_71_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_74_33 = 0
			local var_74_34 = 0.1

			if var_74_33 < arg_71_1.time_ and arg_71_1.time_ <= var_74_33 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_35 = arg_71_1:FormatText(StoryNameCfg[6].name)

				arg_71_1.leftNameTxt_.text = var_74_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_36 = arg_71_1:GetWordFromCfg(113101018)
				local var_74_37 = arg_71_1:FormatText(var_74_36.content)

				arg_71_1.text_.text = var_74_37

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_38 = 4
				local var_74_39 = utf8.len(var_74_37)
				local var_74_40 = var_74_38 <= 0 and var_74_34 or var_74_34 * (var_74_39 / var_74_38)

				if var_74_40 > 0 and var_74_34 < var_74_40 then
					arg_71_1.talkMaxDuration = var_74_40

					if var_74_40 + var_74_33 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_40 + var_74_33
					end
				end

				arg_71_1.text_.text = var_74_37
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101018", "story_v_out_113101.awb") ~= 0 then
					local var_74_41 = manager.audio:GetVoiceLength("story_v_out_113101", "113101018", "story_v_out_113101.awb") / 1000

					if var_74_41 + var_74_33 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_41 + var_74_33
					end

					if var_74_36.prefab_name ~= "" and arg_71_1.actors_[var_74_36.prefab_name] ~= nil then
						local var_74_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_36.prefab_name].transform, "story_v_out_113101", "113101018", "story_v_out_113101.awb")

						arg_71_1:RecordAudio("113101018", var_74_42)
						arg_71_1:RecordAudio("113101018", var_74_42)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_113101", "113101018", "story_v_out_113101.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_113101", "113101018", "story_v_out_113101.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_43 = math.max(var_74_34, arg_71_1.talkMaxDuration)

			if var_74_33 <= arg_71_1.time_ and arg_71_1.time_ < var_74_33 + var_74_43 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_33) / var_74_43

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_33 + var_74_43 and arg_71_1.time_ < var_74_33 + var_74_43 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
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
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play113101019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 113101019
		arg_75_1.duration_ = 0.2

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"

			SetActive(arg_75_1.choicesGo_, true)

			for iter_76_0, iter_76_1 in ipairs(arg_75_1.choices_) do
				local var_76_0 = iter_76_0 <= 2

				SetActive(iter_76_1.go, var_76_0)
			end

			arg_75_1.choices_[1].txt.text = arg_75_1:FormatText(StoryChoiceCfg[199].name)
			arg_75_1.choices_[2].txt.text = arg_75_1:FormatText(StoryChoiceCfg[200].name)
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play113101020(arg_75_1)
			end

			if arg_77_0 == 2 then
				arg_75_0:Play113101020(arg_75_1)
			end

			arg_75_1:RecordChoiceLog(113101019, 199, 200)
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1084ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1084ui_story == nil then
				arg_75_1.var_.characterEffect1084ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.2

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1084ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1084ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1084ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1084ui_story.fillRatio = var_78_5
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play113101020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 113101020
		arg_79_1.duration_ = 8.67

		local var_79_0 = {
			ja = 8.666,
			ko = 4.666,
			zh = 4.6,
			en = 5.1
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
				arg_79_0:Play113101021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1084ui_story"].transform
			local var_82_1 = 1.00008890058234e-12

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.var_.moveOldPos1084ui_story = var_82_0.localPosition
			end

			local var_82_2 = 0.001

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2
				local var_82_4 = Vector3.New(0, 100, 0)

				var_82_0.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1084ui_story, var_82_4, var_82_3)

				local var_82_5 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_5.x, var_82_5.y, var_82_5.z)

				local var_82_6 = var_82_0.localEulerAngles

				var_82_6.z = 0
				var_82_6.x = 0
				var_82_0.localEulerAngles = var_82_6
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 then
				var_82_0.localPosition = Vector3.New(0, 100, 0)

				local var_82_7 = manager.ui.mainCamera.transform.position - var_82_0.position

				var_82_0.forward = Vector3.New(var_82_7.x, var_82_7.y, var_82_7.z)

				local var_82_8 = var_82_0.localEulerAngles

				var_82_8.z = 0
				var_82_8.x = 0
				var_82_0.localEulerAngles = var_82_8
			end

			local var_82_9 = arg_79_1.actors_["1041ui_story"].transform
			local var_82_10 = 1.00008890058234e-12

			if var_82_10 < arg_79_1.time_ and arg_79_1.time_ <= var_82_10 + arg_82_0 then
				arg_79_1.var_.moveOldPos1041ui_story = var_82_9.localPosition
			end

			local var_82_11 = 0.001

			if var_82_10 <= arg_79_1.time_ and arg_79_1.time_ < var_82_10 + var_82_11 then
				local var_82_12 = (arg_79_1.time_ - var_82_10) / var_82_11
				local var_82_13 = Vector3.New(0, -1.11, -5.9)

				var_82_9.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1041ui_story, var_82_13, var_82_12)

				local var_82_14 = manager.ui.mainCamera.transform.position - var_82_9.position

				var_82_9.forward = Vector3.New(var_82_14.x, var_82_14.y, var_82_14.z)

				local var_82_15 = var_82_9.localEulerAngles

				var_82_15.z = 0
				var_82_15.x = 0
				var_82_9.localEulerAngles = var_82_15
			end

			if arg_79_1.time_ >= var_82_10 + var_82_11 and arg_79_1.time_ < var_82_10 + var_82_11 + arg_82_0 then
				var_82_9.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_82_16 = manager.ui.mainCamera.transform.position - var_82_9.position

				var_82_9.forward = Vector3.New(var_82_16.x, var_82_16.y, var_82_16.z)

				local var_82_17 = var_82_9.localEulerAngles

				var_82_17.z = 0
				var_82_17.x = 0
				var_82_9.localEulerAngles = var_82_17
			end

			local var_82_18 = "1041ui_story"

			if arg_79_1.actors_[var_82_18] == nil then
				local var_82_19 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_82_19) then
					local var_82_20 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_79_1.stage_.transform)

					var_82_20.name = var_82_18
					var_82_20.transform.localPosition = Vector3.New(0, 100, 0)
					arg_79_1.actors_[var_82_18] = var_82_20

					local var_82_21 = var_82_20:GetComponentInChildren(typeof(CharacterEffect))

					var_82_21.enabled = true

					local var_82_22 = GameObjectTools.GetOrAddComponent(var_82_20, typeof(DynamicBoneHelper))

					if var_82_22 then
						var_82_22:EnableDynamicBone(false)
					end

					arg_79_1:ShowWeapon(var_82_21.transform, false)

					arg_79_1.var_[var_82_18 .. "Animator"] = var_82_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_79_1.var_[var_82_18 .. "Animator"].applyRootMotion = true
					arg_79_1.var_[var_82_18 .. "LipSync"] = var_82_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_82_23 = 1.00008890058234e-12

			if var_82_23 < arg_79_1.time_ and arg_79_1.time_ <= var_82_23 + arg_82_0 then
				arg_79_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_82_24 = "1041ui_story"

			if arg_79_1.actors_[var_82_24] == nil then
				local var_82_25 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_82_25) then
					local var_82_26 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_79_1.stage_.transform)

					var_82_26.name = var_82_24
					var_82_26.transform.localPosition = Vector3.New(0, 100, 0)
					arg_79_1.actors_[var_82_24] = var_82_26

					local var_82_27 = var_82_26:GetComponentInChildren(typeof(CharacterEffect))

					var_82_27.enabled = true

					local var_82_28 = GameObjectTools.GetOrAddComponent(var_82_26, typeof(DynamicBoneHelper))

					if var_82_28 then
						var_82_28:EnableDynamicBone(false)
					end

					arg_79_1:ShowWeapon(var_82_27.transform, false)

					arg_79_1.var_[var_82_24 .. "Animator"] = var_82_27.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_79_1.var_[var_82_24 .. "Animator"].applyRootMotion = true
					arg_79_1.var_[var_82_24 .. "LipSync"] = var_82_27.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_82_29 = 1.00008890058234e-12

			if var_82_29 < arg_79_1.time_ and arg_79_1.time_ <= var_82_29 + arg_82_0 then
				arg_79_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_82_30 = arg_79_1.actors_["1041ui_story"]
			local var_82_31 = 0

			if var_82_31 < arg_79_1.time_ and arg_79_1.time_ <= var_82_31 + arg_82_0 and not isNil(var_82_30) and arg_79_1.var_.characterEffect1041ui_story == nil then
				arg_79_1.var_.characterEffect1041ui_story = var_82_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_32 = 0.2

			if var_82_31 <= arg_79_1.time_ and arg_79_1.time_ < var_82_31 + var_82_32 and not isNil(var_82_30) then
				local var_82_33 = (arg_79_1.time_ - var_82_31) / var_82_32

				if arg_79_1.var_.characterEffect1041ui_story and not isNil(var_82_30) then
					arg_79_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_31 + var_82_32 and arg_79_1.time_ < var_82_31 + var_82_32 + arg_82_0 and not isNil(var_82_30) and arg_79_1.var_.characterEffect1041ui_story then
				arg_79_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_82_34 = 0
			local var_82_35 = 0.525

			if var_82_34 < arg_79_1.time_ and arg_79_1.time_ <= var_82_34 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_36 = arg_79_1:FormatText(StoryNameCfg[208].name)

				arg_79_1.leftNameTxt_.text = var_82_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_37 = arg_79_1:GetWordFromCfg(113101020)
				local var_82_38 = arg_79_1:FormatText(var_82_37.content)

				arg_79_1.text_.text = var_82_38

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_39 = 21
				local var_82_40 = utf8.len(var_82_38)
				local var_82_41 = var_82_39 <= 0 and var_82_35 or var_82_35 * (var_82_40 / var_82_39)

				if var_82_41 > 0 and var_82_35 < var_82_41 then
					arg_79_1.talkMaxDuration = var_82_41

					if var_82_41 + var_82_34 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_41 + var_82_34
					end
				end

				arg_79_1.text_.text = var_82_38
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101020", "story_v_out_113101.awb") ~= 0 then
					local var_82_42 = manager.audio:GetVoiceLength("story_v_out_113101", "113101020", "story_v_out_113101.awb") / 1000

					if var_82_42 + var_82_34 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_42 + var_82_34
					end

					if var_82_37.prefab_name ~= "" and arg_79_1.actors_[var_82_37.prefab_name] ~= nil then
						local var_82_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_37.prefab_name].transform, "story_v_out_113101", "113101020", "story_v_out_113101.awb")

						arg_79_1:RecordAudio("113101020", var_82_43)
						arg_79_1:RecordAudio("113101020", var_82_43)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_113101", "113101020", "story_v_out_113101.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_113101", "113101020", "story_v_out_113101.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_44 = math.max(var_82_35, arg_79_1.talkMaxDuration)

			if var_82_34 <= arg_79_1.time_ and arg_79_1.time_ < var_82_34 + var_82_44 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_34) / var_82_44

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_34 + var_82_44 and arg_79_1.time_ < var_82_34 + var_82_44 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play113101021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 113101021
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
			arg_83_1.auto_ = false
		end

		function arg_83_1.playNext_(arg_85_0)
			arg_83_1.onStoryFinished_()
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1041ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1041ui_story == nil then
				arg_83_1.var_.characterEffect1041ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.2

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1041ui_story and not isNil(var_86_0) then
					local var_86_4 = Mathf.Lerp(0, 0.5, var_86_3)

					arg_83_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1041ui_story.fillRatio = var_86_4
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1041ui_story then
				local var_86_5 = 0.5

				arg_83_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1041ui_story.fillRatio = var_86_5
			end

			local var_86_6 = 0
			local var_86_7 = 0.475

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_8 = arg_83_1:GetWordFromCfg(113101021)
				local var_86_9 = arg_83_1:FormatText(var_86_8.content)

				arg_83_1.text_.text = var_86_9

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 19
				local var_86_11 = utf8.len(var_86_9)
				local var_86_12 = var_86_10 <= 0 and var_86_7 or var_86_7 * (var_86_11 / var_86_10)

				if var_86_12 > 0 and var_86_7 < var_86_12 then
					arg_83_1.talkMaxDuration = var_86_12

					if var_86_12 + var_86_6 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_12 + var_86_6
					end
				end

				arg_83_1.text_.text = var_86_9
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_13 = math.max(var_86_7, arg_83_1.talkMaxDuration)

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_13 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_6) / var_86_13

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_6 + var_86_13 and arg_83_1.time_ < var_86_6 + var_86_13 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F03"
	},
	voices = {
		"story_v_out_113101.awb"
	}
}
