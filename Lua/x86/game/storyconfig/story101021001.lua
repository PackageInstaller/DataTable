return {
	Play102101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 102101001
		arg_1_1.duration_ = 6.57

		local var_1_0 = {
			ja = 5.133,
			ko = 5.833,
			zh = 6.566,
			en = 5.766
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
				arg_1_0:Play102101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

			local var_4_6 = "1019ui_story"

			if arg_1_1.actors_[var_4_6] == nil then
				local var_4_7 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_4_7) then
					local var_4_8 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_1_1.stage_.transform)

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

			local var_4_11 = arg_1_1.actors_["1019ui_story"]
			local var_4_12 = 2

			if var_4_12 < arg_1_1.time_ and arg_1_1.time_ <= var_4_12 + arg_4_0 and not isNil(var_4_11) and arg_1_1.var_.characterEffect1019ui_story == nil then
				arg_1_1.var_.characterEffect1019ui_story = var_4_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_13 = 0.1

			if var_4_12 <= arg_1_1.time_ and arg_1_1.time_ < var_4_12 + var_4_13 and not isNil(var_4_11) then
				local var_4_14 = (arg_1_1.time_ - var_4_12) / var_4_13

				if arg_1_1.var_.characterEffect1019ui_story and not isNil(var_4_11) then
					arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_12 + var_4_13 and arg_1_1.time_ < var_4_12 + var_4_13 + arg_4_0 and not isNil(var_4_11) and arg_1_1.var_.characterEffect1019ui_story then
				arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_4_15 = "B02c"

			if arg_1_1.bgs_[var_4_15] == nil then
				local var_4_16 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_16:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_15)
				var_4_16.name = var_4_15
				var_4_16.transform.parent = arg_1_1.stage_.transform
				var_4_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_15] = var_4_16
			end

			local var_4_17 = arg_1_1.bgs_.B02c
			local var_4_18 = 0

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				local var_4_19 = var_4_17:GetComponent("SpriteRenderer")

				if var_4_19 then
					arg_1_1.var_.alphaOldValueB02c = var_4_19.color.a
					arg_1_1.var_.alphaMatValueB02c = var_4_19
				end

				arg_1_1.var_.alphaOldValueB02c = 0
			end

			local var_4_20 = 1.5

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_20 then
				local var_4_21 = (arg_1_1.time_ - var_4_18) / var_4_20
				local var_4_22 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB02c, 1, var_4_21)

				if arg_1_1.var_.alphaMatValueB02c then
					local var_4_23 = arg_1_1.var_.alphaMatValueB02c.color

					var_4_23.a = var_4_22
					arg_1_1.var_.alphaMatValueB02c.color = var_4_23
				end
			end

			if arg_1_1.time_ >= var_4_18 + var_4_20 and arg_1_1.time_ < var_4_18 + var_4_20 + arg_4_0 and arg_1_1.var_.alphaMatValueB02c then
				local var_4_24 = arg_1_1.var_.alphaMatValueB02c
				local var_4_25 = var_4_24.color

				var_4_25.a = 1
				var_4_24.color = var_4_25
			end

			local var_4_26 = 0

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_27 = manager.ui.mainCamera.transform.localPosition
				local var_4_28 = Vector3.New(0, 0, 10) + Vector3.New(var_4_27.x, var_4_27.y, 0)
				local var_4_29 = arg_1_1.bgs_.B02c

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
					if iter_4_0 ~= "B02c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_40 = arg_1_1.actors_["1019ui_story"].transform
			local var_4_41 = 1.79999995231628

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1.var_.moveOldPos1019ui_story = var_4_40.localPosition
			end

			local var_4_42 = 0.001

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42
				local var_4_44 = Vector3.New(-0.7, -1.08, -5.9)

				var_4_40.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1019ui_story, var_4_44, var_4_43)

				local var_4_45 = manager.ui.mainCamera.transform.position - var_4_40.position

				var_4_40.forward = Vector3.New(var_4_45.x, var_4_45.y, var_4_45.z)

				local var_4_46 = var_4_40.localEulerAngles

				var_4_46.z = 0
				var_4_46.x = 0
				var_4_40.localEulerAngles = var_4_46
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 then
				var_4_40.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_4_47 = manager.ui.mainCamera.transform.position - var_4_40.position

				var_4_40.forward = Vector3.New(var_4_47.x, var_4_47.y, var_4_47.z)

				local var_4_48 = var_4_40.localEulerAngles

				var_4_48.z = 0
				var_4_48.x = 0
				var_4_40.localEulerAngles = var_4_48
			end

			local var_4_49 = 1.79999995231628

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
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
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_53 = 2
			local var_4_54 = 0.5

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

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[13].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(102101001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101001", "story_v_out_102101.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_out_102101", "102101001", "story_v_out_102101.awb") / 1000

					if var_4_62 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_53
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_out_102101", "102101001", "story_v_out_102101.awb")

						arg_1_1:RecordAudio("102101001", var_4_63)
						arg_1_1:RecordAudio("102101001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_102101", "102101001", "story_v_out_102101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_102101", "102101001", "story_v_out_102101.awb")
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
				actorName = "1019ui_story",
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
	Play102101002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 102101002
		arg_8_1.duration_ = 5.6

		local var_8_0 = {
			ja = 4.4,
			ko = 4.9,
			zh = 5.6,
			en = 4.233
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
				arg_8_0:Play102101003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				local var_11_2 = "play"
				local var_11_3 = "effect"

				arg_8_1:AudioAction(var_11_2, var_11_3, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_11_4 = "10002ui_story"

			if arg_8_1.actors_[var_11_4] == nil then
				local var_11_5 = Asset.Load("Char/" .. "10002ui_story")

				if not isNil(var_11_5) then
					local var_11_6 = Object.Instantiate(Asset.Load("Char/" .. "10002ui_story"), arg_8_1.stage_.transform)

					var_11_6.name = var_11_4
					var_11_6.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_4] = var_11_6

					local var_11_7 = var_11_6:GetComponentInChildren(typeof(CharacterEffect))

					var_11_7.enabled = true

					local var_11_8 = GameObjectTools.GetOrAddComponent(var_11_6, typeof(DynamicBoneHelper))

					if var_11_8 then
						var_11_8:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_7.transform, false)

					arg_8_1.var_[var_11_4 .. "Animator"] = var_11_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_4 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_4 .. "LipSync"] = var_11_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_9 = arg_8_1.actors_["10002ui_story"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect10002ui_story == nil then
				arg_8_1.var_.characterEffect10002ui_story = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.1

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect10002ui_story and not isNil(var_11_9) then
					arg_8_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect10002ui_story then
				arg_8_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_11_13 = arg_8_1.actors_["1019ui_story"]
			local var_11_14 = 0

			if var_11_14 < arg_8_1.time_ and arg_8_1.time_ <= var_11_14 + arg_11_0 and not isNil(var_11_13) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_15 = 0.1

			if var_11_14 <= arg_8_1.time_ and arg_8_1.time_ < var_11_14 + var_11_15 and not isNil(var_11_13) then
				local var_11_16 = (arg_8_1.time_ - var_11_14) / var_11_15

				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_13) then
					local var_11_17 = Mathf.Lerp(0, 0.5, var_11_16)

					arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1019ui_story.fillRatio = var_11_17
				end
			end

			if arg_8_1.time_ >= var_11_14 + var_11_15 and arg_8_1.time_ < var_11_14 + var_11_15 + arg_11_0 and not isNil(var_11_13) and arg_8_1.var_.characterEffect1019ui_story then
				local var_11_18 = 0.5

				arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1019ui_story.fillRatio = var_11_18
			end

			local var_11_19 = arg_8_1.actors_["10002ui_story"].transform
			local var_11_20 = 0

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.var_.moveOldPos10002ui_story = var_11_19.localPosition
			end

			local var_11_21 = 0.001

			if var_11_20 <= arg_8_1.time_ and arg_8_1.time_ < var_11_20 + var_11_21 then
				local var_11_22 = (arg_8_1.time_ - var_11_20) / var_11_21
				local var_11_23 = Vector3.New(0.7, -1.2, -5.8)

				var_11_19.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10002ui_story, var_11_23, var_11_22)

				local var_11_24 = manager.ui.mainCamera.transform.position - var_11_19.position

				var_11_19.forward = Vector3.New(var_11_24.x, var_11_24.y, var_11_24.z)

				local var_11_25 = var_11_19.localEulerAngles

				var_11_25.z = 0
				var_11_25.x = 0
				var_11_19.localEulerAngles = var_11_25
			end

			if arg_8_1.time_ >= var_11_20 + var_11_21 and arg_8_1.time_ < var_11_20 + var_11_21 + arg_11_0 then
				var_11_19.localPosition = Vector3.New(0.7, -1.2, -5.8)

				local var_11_26 = manager.ui.mainCamera.transform.position - var_11_19.position

				var_11_19.forward = Vector3.New(var_11_26.x, var_11_26.y, var_11_26.z)

				local var_11_27 = var_11_19.localEulerAngles

				var_11_27.z = 0
				var_11_27.x = 0
				var_11_19.localEulerAngles = var_11_27
			end

			local var_11_28 = 0

			if var_11_28 < arg_8_1.time_ and arg_8_1.time_ <= var_11_28 + arg_11_0 then
				arg_8_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			local var_11_29 = 0

			if var_11_29 < arg_8_1.time_ and arg_8_1.time_ <= var_11_29 + arg_11_0 then
				arg_8_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_11_30 = 0
			local var_11_31 = 0.45

			if var_11_30 < arg_8_1.time_ and arg_8_1.time_ <= var_11_30 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_32 = arg_8_1:FormatText(StoryNameCfg[39].name)

				arg_8_1.leftNameTxt_.text = var_11_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_33 = arg_8_1:GetWordFromCfg(102101002)
				local var_11_34 = arg_8_1:FormatText(var_11_33.content)

				arg_8_1.text_.text = var_11_34

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_35 = 18
				local var_11_36 = utf8.len(var_11_34)
				local var_11_37 = var_11_35 <= 0 and var_11_31 or var_11_31 * (var_11_36 / var_11_35)

				if var_11_37 > 0 and var_11_31 < var_11_37 then
					arg_8_1.talkMaxDuration = var_11_37

					if var_11_37 + var_11_30 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_37 + var_11_30
					end
				end

				arg_8_1.text_.text = var_11_34
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101002", "story_v_out_102101.awb") ~= 0 then
					local var_11_38 = manager.audio:GetVoiceLength("story_v_out_102101", "102101002", "story_v_out_102101.awb") / 1000

					if var_11_38 + var_11_30 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_38 + var_11_30
					end

					if var_11_33.prefab_name ~= "" and arg_8_1.actors_[var_11_33.prefab_name] ~= nil then
						local var_11_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_33.prefab_name].transform, "story_v_out_102101", "102101002", "story_v_out_102101.awb")

						arg_8_1:RecordAudio("102101002", var_11_39)
						arg_8_1:RecordAudio("102101002", var_11_39)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_102101", "102101002", "story_v_out_102101.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_102101", "102101002", "story_v_out_102101.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_40 = math.max(var_11_31, arg_8_1.talkMaxDuration)

			if var_11_30 <= arg_8_1.time_ and arg_8_1.time_ < var_11_30 + var_11_40 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_30) / var_11_40

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_30 + var_11_40 and arg_8_1.time_ < var_11_30 + var_11_40 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
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
	Play102101003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 102101003
		arg_12_1.duration_ = 9.53

		local var_12_0 = {
			ja = 8.3,
			ko = 6.033,
			zh = 6.166,
			en = 9.533
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
				arg_12_0:Play102101004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = "1011ui_story"

			if arg_12_1.actors_[var_15_0] == nil then
				local var_15_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_15_1) then
					local var_15_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_12_1.stage_.transform)

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

			local var_15_5 = arg_12_1.actors_["1011ui_story"]
			local var_15_6 = 0

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1011ui_story == nil then
				arg_12_1.var_.characterEffect1011ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.1

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 and not isNil(var_15_5) then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / var_15_7

				if arg_12_1.var_.characterEffect1011ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1011ui_story then
				arg_12_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_15_9 = arg_12_1.actors_["10002ui_story"]
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect10002ui_story == nil then
				arg_12_1.var_.characterEffect10002ui_story = var_15_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_11 = 0.1

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 and not isNil(var_15_9) then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11

				if arg_12_1.var_.characterEffect10002ui_story and not isNil(var_15_9) then
					local var_15_13 = Mathf.Lerp(0, 0.5, var_15_12)

					arg_12_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_12_1.var_.characterEffect10002ui_story.fillRatio = var_15_13
				end
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 and not isNil(var_15_9) and arg_12_1.var_.characterEffect10002ui_story then
				local var_15_14 = 0.5

				arg_12_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_12_1.var_.characterEffect10002ui_story.fillRatio = var_15_14
			end

			local var_15_15 = arg_12_1.actors_["1019ui_story"].transform
			local var_15_16 = 0

			if var_15_16 < arg_12_1.time_ and arg_12_1.time_ <= var_15_16 + arg_15_0 then
				arg_12_1.var_.moveOldPos1019ui_story = var_15_15.localPosition
			end

			local var_15_17 = 0.001

			if var_15_16 <= arg_12_1.time_ and arg_12_1.time_ < var_15_16 + var_15_17 then
				local var_15_18 = (arg_12_1.time_ - var_15_16) / var_15_17
				local var_15_19 = Vector3.New(0, 100, 0)

				var_15_15.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1019ui_story, var_15_19, var_15_18)

				local var_15_20 = manager.ui.mainCamera.transform.position - var_15_15.position

				var_15_15.forward = Vector3.New(var_15_20.x, var_15_20.y, var_15_20.z)

				local var_15_21 = var_15_15.localEulerAngles

				var_15_21.z = 0
				var_15_21.x = 0
				var_15_15.localEulerAngles = var_15_21
			end

			if arg_12_1.time_ >= var_15_16 + var_15_17 and arg_12_1.time_ < var_15_16 + var_15_17 + arg_15_0 then
				var_15_15.localPosition = Vector3.New(0, 100, 0)

				local var_15_22 = manager.ui.mainCamera.transform.position - var_15_15.position

				var_15_15.forward = Vector3.New(var_15_22.x, var_15_22.y, var_15_22.z)

				local var_15_23 = var_15_15.localEulerAngles

				var_15_23.z = 0
				var_15_23.x = 0
				var_15_15.localEulerAngles = var_15_23
			end

			local var_15_24 = arg_12_1.actors_["1011ui_story"].transform
			local var_15_25 = 0

			if var_15_25 < arg_12_1.time_ and arg_12_1.time_ <= var_15_25 + arg_15_0 then
				arg_12_1.var_.moveOldPos1011ui_story = var_15_24.localPosition
			end

			local var_15_26 = 0.001

			if var_15_25 <= arg_12_1.time_ and arg_12_1.time_ < var_15_25 + var_15_26 then
				local var_15_27 = (arg_12_1.time_ - var_15_25) / var_15_26
				local var_15_28 = Vector3.New(-0.7, -0.71, -6)

				var_15_24.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1011ui_story, var_15_28, var_15_27)

				local var_15_29 = manager.ui.mainCamera.transform.position - var_15_24.position

				var_15_24.forward = Vector3.New(var_15_29.x, var_15_29.y, var_15_29.z)

				local var_15_30 = var_15_24.localEulerAngles

				var_15_30.z = 0
				var_15_30.x = 0
				var_15_24.localEulerAngles = var_15_30
			end

			if arg_12_1.time_ >= var_15_25 + var_15_26 and arg_12_1.time_ < var_15_25 + var_15_26 + arg_15_0 then
				var_15_24.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_15_31 = manager.ui.mainCamera.transform.position - var_15_24.position

				var_15_24.forward = Vector3.New(var_15_31.x, var_15_31.y, var_15_31.z)

				local var_15_32 = var_15_24.localEulerAngles

				var_15_32.z = 0
				var_15_32.x = 0
				var_15_24.localEulerAngles = var_15_32
			end

			local var_15_33 = 0

			if var_15_33 < arg_12_1.time_ and arg_12_1.time_ <= var_15_33 + arg_15_0 then
				arg_12_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_15_34 = 0

			if var_15_34 < arg_12_1.time_ and arg_12_1.time_ <= var_15_34 + arg_15_0 then
				arg_12_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_15_35 = 0
			local var_15_36 = 0.675

			if var_15_35 < arg_12_1.time_ and arg_12_1.time_ <= var_15_35 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_37 = arg_12_1:FormatText(StoryNameCfg[37].name)

				arg_12_1.leftNameTxt_.text = var_15_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_38 = arg_12_1:GetWordFromCfg(102101003)
				local var_15_39 = arg_12_1:FormatText(var_15_38.content)

				arg_12_1.text_.text = var_15_39

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_40 = 27
				local var_15_41 = utf8.len(var_15_39)
				local var_15_42 = var_15_40 <= 0 and var_15_36 or var_15_36 * (var_15_41 / var_15_40)

				if var_15_42 > 0 and var_15_36 < var_15_42 then
					arg_12_1.talkMaxDuration = var_15_42

					if var_15_42 + var_15_35 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_42 + var_15_35
					end
				end

				arg_12_1.text_.text = var_15_39
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101003", "story_v_out_102101.awb") ~= 0 then
					local var_15_43 = manager.audio:GetVoiceLength("story_v_out_102101", "102101003", "story_v_out_102101.awb") / 1000

					if var_15_43 + var_15_35 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_43 + var_15_35
					end

					if var_15_38.prefab_name ~= "" and arg_12_1.actors_[var_15_38.prefab_name] ~= nil then
						local var_15_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_38.prefab_name].transform, "story_v_out_102101", "102101003", "story_v_out_102101.awb")

						arg_12_1:RecordAudio("102101003", var_15_44)
						arg_12_1:RecordAudio("102101003", var_15_44)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_102101", "102101003", "story_v_out_102101.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_102101", "102101003", "story_v_out_102101.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_45 = math.max(var_15_36, arg_12_1.talkMaxDuration)

			if var_15_35 <= arg_12_1.time_ and arg_12_1.time_ < var_15_35 + var_15_45 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_35) / var_15_45

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_35 + var_15_45 and arg_12_1.time_ < var_15_35 + var_15_45 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play102101004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 102101004
		arg_16_1.duration_ = 7.57

		local var_16_0 = {
			ja = 7.566,
			ko = 5.366,
			zh = 4.7,
			en = 4.666
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
				arg_16_0:Play102101005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10002ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect10002ui_story == nil then
				arg_16_1.var_.characterEffect10002ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.1

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect10002ui_story and not isNil(var_19_0) then
					arg_16_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect10002ui_story then
				arg_16_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_19_4 = arg_16_1.actors_["1011ui_story"]
			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect1011ui_story == nil then
				arg_16_1.var_.characterEffect1011ui_story = var_19_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_6 = 0.1

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 and not isNil(var_19_4) then
				local var_19_7 = (arg_16_1.time_ - var_19_5) / var_19_6

				if arg_16_1.var_.characterEffect1011ui_story and not isNil(var_19_4) then
					local var_19_8 = Mathf.Lerp(0, 0.5, var_19_7)

					arg_16_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1011ui_story.fillRatio = var_19_8
				end
			end

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 and not isNil(var_19_4) and arg_16_1.var_.characterEffect1011ui_story then
				local var_19_9 = 0.5

				arg_16_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1011ui_story.fillRatio = var_19_9
			end

			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_2")
			end

			local var_19_11 = 0

			if var_19_11 < arg_16_1.time_ and arg_16_1.time_ <= var_19_11 + arg_19_0 then
				arg_16_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_19_12 = 0
			local var_19_13 = 0.475

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_14 = arg_16_1:FormatText(StoryNameCfg[39].name)

				arg_16_1.leftNameTxt_.text = var_19_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_15 = arg_16_1:GetWordFromCfg(102101004)
				local var_19_16 = arg_16_1:FormatText(var_19_15.content)

				arg_16_1.text_.text = var_19_16

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_17 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101004", "story_v_out_102101.awb") ~= 0 then
					local var_19_20 = manager.audio:GetVoiceLength("story_v_out_102101", "102101004", "story_v_out_102101.awb") / 1000

					if var_19_20 + var_19_12 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_20 + var_19_12
					end

					if var_19_15.prefab_name ~= "" and arg_16_1.actors_[var_19_15.prefab_name] ~= nil then
						local var_19_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_15.prefab_name].transform, "story_v_out_102101", "102101004", "story_v_out_102101.awb")

						arg_16_1:RecordAudio("102101004", var_19_21)
						arg_16_1:RecordAudio("102101004", var_19_21)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_102101", "102101004", "story_v_out_102101.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_102101", "102101004", "story_v_out_102101.awb")
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
	Play102101005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 102101005
		arg_20_1.duration_ = 18.07

		local var_20_0 = {
			ja = 14.2,
			ko = 18.066,
			zh = 12.966,
			en = 15.4
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
				arg_20_0:Play102101006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_23_1 = 0
			local var_23_2 = 1.125

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_3 = arg_20_1:FormatText(StoryNameCfg[39].name)

				arg_20_1.leftNameTxt_.text = var_23_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_4 = arg_20_1:GetWordFromCfg(102101005)
				local var_23_5 = arg_20_1:FormatText(var_23_4.content)

				arg_20_1.text_.text = var_23_5

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_6 = 45
				local var_23_7 = utf8.len(var_23_5)
				local var_23_8 = var_23_6 <= 0 and var_23_2 or var_23_2 * (var_23_7 / var_23_6)

				if var_23_8 > 0 and var_23_2 < var_23_8 then
					arg_20_1.talkMaxDuration = var_23_8

					if var_23_8 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_8 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_5
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101005", "story_v_out_102101.awb") ~= 0 then
					local var_23_9 = manager.audio:GetVoiceLength("story_v_out_102101", "102101005", "story_v_out_102101.awb") / 1000

					if var_23_9 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_1
					end

					if var_23_4.prefab_name ~= "" and arg_20_1.actors_[var_23_4.prefab_name] ~= nil then
						local var_23_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_4.prefab_name].transform, "story_v_out_102101", "102101005", "story_v_out_102101.awb")

						arg_20_1:RecordAudio("102101005", var_23_10)
						arg_20_1:RecordAudio("102101005", var_23_10)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_102101", "102101005", "story_v_out_102101.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_102101", "102101005", "story_v_out_102101.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_11 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_11 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_11

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_11 and arg_20_1.time_ < var_23_1 + var_23_11 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play102101006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 102101006
		arg_24_1.duration_ = 16.63

		local var_24_0 = {
			ja = 16.366,
			ko = 16.633,
			zh = 11.9,
			en = 15.733
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
				arg_24_0:Play102101007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_27_1 = 0
			local var_27_2 = 1.35

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_3 = arg_24_1:FormatText(StoryNameCfg[39].name)

				arg_24_1.leftNameTxt_.text = var_27_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_4 = arg_24_1:GetWordFromCfg(102101006)
				local var_27_5 = arg_24_1:FormatText(var_27_4.content)

				arg_24_1.text_.text = var_27_5

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_6 = 54
				local var_27_7 = utf8.len(var_27_5)
				local var_27_8 = var_27_6 <= 0 and var_27_2 or var_27_2 * (var_27_7 / var_27_6)

				if var_27_8 > 0 and var_27_2 < var_27_8 then
					arg_24_1.talkMaxDuration = var_27_8

					if var_27_8 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_5
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101006", "story_v_out_102101.awb") ~= 0 then
					local var_27_9 = manager.audio:GetVoiceLength("story_v_out_102101", "102101006", "story_v_out_102101.awb") / 1000

					if var_27_9 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_1
					end

					if var_27_4.prefab_name ~= "" and arg_24_1.actors_[var_27_4.prefab_name] ~= nil then
						local var_27_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_4.prefab_name].transform, "story_v_out_102101", "102101006", "story_v_out_102101.awb")

						arg_24_1:RecordAudio("102101006", var_27_10)
						arg_24_1:RecordAudio("102101006", var_27_10)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_102101", "102101006", "story_v_out_102101.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_102101", "102101006", "story_v_out_102101.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_11 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_11 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_11

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_11 and arg_24_1.time_ < var_27_1 + var_27_11 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play102101007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 102101007
		arg_28_1.duration_ = 5.47

		local var_28_0 = {
			ja = 5.466,
			ko = 4.233,
			zh = 3.133,
			en = 5.133
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
				arg_28_0:Play102101008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1011ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1011ui_story == nil then
				arg_28_1.var_.characterEffect1011ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1011ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1011ui_story then
				arg_28_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_31_4 = 0

			if var_31_4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_31_5 = 0
			local var_31_6 = 0.375

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_7 = arg_28_1:FormatText(StoryNameCfg[37].name)

				arg_28_1.leftNameTxt_.text = var_31_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_8 = arg_28_1:GetWordFromCfg(102101007)
				local var_31_9 = arg_28_1:FormatText(var_31_8.content)

				arg_28_1.text_.text = var_31_9

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_10 = 15
				local var_31_11 = utf8.len(var_31_9)
				local var_31_12 = var_31_10 <= 0 and var_31_6 or var_31_6 * (var_31_11 / var_31_10)

				if var_31_12 > 0 and var_31_6 < var_31_12 then
					arg_28_1.talkMaxDuration = var_31_12

					if var_31_12 + var_31_5 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_5
					end
				end

				arg_28_1.text_.text = var_31_9
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101007", "story_v_out_102101.awb") ~= 0 then
					local var_31_13 = manager.audio:GetVoiceLength("story_v_out_102101", "102101007", "story_v_out_102101.awb") / 1000

					if var_31_13 + var_31_5 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_5
					end

					if var_31_8.prefab_name ~= "" and arg_28_1.actors_[var_31_8.prefab_name] ~= nil then
						local var_31_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_8.prefab_name].transform, "story_v_out_102101", "102101007", "story_v_out_102101.awb")

						arg_28_1:RecordAudio("102101007", var_31_14)
						arg_28_1:RecordAudio("102101007", var_31_14)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_102101", "102101007", "story_v_out_102101.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_102101", "102101007", "story_v_out_102101.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_15 = math.max(var_31_6, arg_28_1.talkMaxDuration)

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_15 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_5) / var_31_15

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_5 + var_31_15 and arg_28_1.time_ < var_31_5 + var_31_15 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play102101008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 102101008
		arg_32_1.duration_ = 6.57

		local var_32_0 = {
			ja = 6.566,
			ko = 4.966,
			zh = 3.866,
			en = 5
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
				arg_32_0:Play102101009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["10002ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10002ui_story == nil then
				arg_32_1.var_.characterEffect10002ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect10002ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_32_1.var_.characterEffect10002ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect10002ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_32_1.var_.characterEffect10002ui_story.fillRatio = var_35_5
			end

			local var_35_6 = arg_32_1.actors_["1019ui_story"]
			local var_35_7 = 0

			if var_35_7 < arg_32_1.time_ and arg_32_1.time_ <= var_35_7 + arg_35_0 and not isNil(var_35_6) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = var_35_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_8 = 0.1

			if var_35_7 <= arg_32_1.time_ and arg_32_1.time_ < var_35_7 + var_35_8 and not isNil(var_35_6) then
				local var_35_9 = (arg_32_1.time_ - var_35_7) / var_35_8

				if arg_32_1.var_.characterEffect1019ui_story and not isNil(var_35_6) then
					arg_32_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_7 + var_35_8 and arg_32_1.time_ < var_35_7 + var_35_8 + arg_35_0 and not isNil(var_35_6) and arg_32_1.var_.characterEffect1019ui_story then
				arg_32_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_35_10 = 0

			if var_35_10 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_35_11 = arg_32_1.actors_["1011ui_story"].transform
			local var_35_12 = 0

			if var_35_12 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.var_.moveOldPos1011ui_story = var_35_11.localPosition
			end

			local var_35_13 = 0.001

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_13 then
				local var_35_14 = (arg_32_1.time_ - var_35_12) / var_35_13
				local var_35_15 = Vector3.New(0, 100, 0)

				var_35_11.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1011ui_story, var_35_15, var_35_14)

				local var_35_16 = manager.ui.mainCamera.transform.position - var_35_11.position

				var_35_11.forward = Vector3.New(var_35_16.x, var_35_16.y, var_35_16.z)

				local var_35_17 = var_35_11.localEulerAngles

				var_35_17.z = 0
				var_35_17.x = 0
				var_35_11.localEulerAngles = var_35_17
			end

			if arg_32_1.time_ >= var_35_12 + var_35_13 and arg_32_1.time_ < var_35_12 + var_35_13 + arg_35_0 then
				var_35_11.localPosition = Vector3.New(0, 100, 0)

				local var_35_18 = manager.ui.mainCamera.transform.position - var_35_11.position

				var_35_11.forward = Vector3.New(var_35_18.x, var_35_18.y, var_35_18.z)

				local var_35_19 = var_35_11.localEulerAngles

				var_35_19.z = 0
				var_35_19.x = 0
				var_35_11.localEulerAngles = var_35_19
			end

			local var_35_20 = arg_32_1.actors_["1019ui_story"].transform
			local var_35_21 = 0

			if var_35_21 < arg_32_1.time_ and arg_32_1.time_ <= var_35_21 + arg_35_0 then
				arg_32_1.var_.moveOldPos1019ui_story = var_35_20.localPosition
			end

			local var_35_22 = 0.001

			if var_35_21 <= arg_32_1.time_ and arg_32_1.time_ < var_35_21 + var_35_22 then
				local var_35_23 = (arg_32_1.time_ - var_35_21) / var_35_22
				local var_35_24 = Vector3.New(-0.7, -1.08, -5.9)

				var_35_20.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1019ui_story, var_35_24, var_35_23)

				local var_35_25 = manager.ui.mainCamera.transform.position - var_35_20.position

				var_35_20.forward = Vector3.New(var_35_25.x, var_35_25.y, var_35_25.z)

				local var_35_26 = var_35_20.localEulerAngles

				var_35_26.z = 0
				var_35_26.x = 0
				var_35_20.localEulerAngles = var_35_26
			end

			if arg_32_1.time_ >= var_35_21 + var_35_22 and arg_32_1.time_ < var_35_21 + var_35_22 + arg_35_0 then
				var_35_20.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_35_27 = manager.ui.mainCamera.transform.position - var_35_20.position

				var_35_20.forward = Vector3.New(var_35_27.x, var_35_27.y, var_35_27.z)

				local var_35_28 = var_35_20.localEulerAngles

				var_35_28.z = 0
				var_35_28.x = 0
				var_35_20.localEulerAngles = var_35_28
			end

			local var_35_29 = 0

			if var_35_29 < arg_32_1.time_ and arg_32_1.time_ <= var_35_29 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_35_30 = 0
			local var_35_31 = 0.475

			if var_35_30 < arg_32_1.time_ and arg_32_1.time_ <= var_35_30 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_32 = arg_32_1:FormatText(StoryNameCfg[13].name)

				arg_32_1.leftNameTxt_.text = var_35_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_33 = arg_32_1:GetWordFromCfg(102101008)
				local var_35_34 = arg_32_1:FormatText(var_35_33.content)

				arg_32_1.text_.text = var_35_34

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_35 = 19
				local var_35_36 = utf8.len(var_35_34)
				local var_35_37 = var_35_35 <= 0 and var_35_31 or var_35_31 * (var_35_36 / var_35_35)

				if var_35_37 > 0 and var_35_31 < var_35_37 then
					arg_32_1.talkMaxDuration = var_35_37

					if var_35_37 + var_35_30 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_37 + var_35_30
					end
				end

				arg_32_1.text_.text = var_35_34
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101008", "story_v_out_102101.awb") ~= 0 then
					local var_35_38 = manager.audio:GetVoiceLength("story_v_out_102101", "102101008", "story_v_out_102101.awb") / 1000

					if var_35_38 + var_35_30 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_38 + var_35_30
					end

					if var_35_33.prefab_name ~= "" and arg_32_1.actors_[var_35_33.prefab_name] ~= nil then
						local var_35_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_33.prefab_name].transform, "story_v_out_102101", "102101008", "story_v_out_102101.awb")

						arg_32_1:RecordAudio("102101008", var_35_39)
						arg_32_1:RecordAudio("102101008", var_35_39)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_102101", "102101008", "story_v_out_102101.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_102101", "102101008", "story_v_out_102101.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_40 = math.max(var_35_31, arg_32_1.talkMaxDuration)

			if var_35_30 <= arg_32_1.time_ and arg_32_1.time_ < var_35_30 + var_35_40 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_30) / var_35_40

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_30 + var_35_40 and arg_32_1.time_ < var_35_30 + var_35_40 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play102101009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 102101009
		arg_36_1.duration_ = 20.73

		local var_36_0 = {
			ja = 20.733,
			ko = 11.566,
			zh = 11.066,
			en = 12.166
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
				arg_36_0:Play102101010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_39_1 = 0
			local var_39_2 = 1.15

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_3 = arg_36_1:FormatText(StoryNameCfg[39].name)

				arg_36_1.leftNameTxt_.text = var_39_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:GetWordFromCfg(102101009)
				local var_39_5 = arg_36_1:FormatText(var_39_4.content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_6 = 47
				local var_39_7 = utf8.len(var_39_5)
				local var_39_8 = var_39_6 <= 0 and var_39_2 or var_39_2 * (var_39_7 / var_39_6)

				if var_39_8 > 0 and var_39_2 < var_39_8 then
					arg_36_1.talkMaxDuration = var_39_8

					if var_39_8 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101009", "story_v_out_102101.awb") ~= 0 then
					local var_39_9 = manager.audio:GetVoiceLength("story_v_out_102101", "102101009", "story_v_out_102101.awb") / 1000

					if var_39_9 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_1
					end

					if var_39_4.prefab_name ~= "" and arg_36_1.actors_[var_39_4.prefab_name] ~= nil then
						local var_39_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_4.prefab_name].transform, "story_v_out_102101", "102101009", "story_v_out_102101.awb")

						arg_36_1:RecordAudio("102101009", var_39_10)
						arg_36_1:RecordAudio("102101009", var_39_10)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_102101", "102101009", "story_v_out_102101.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_102101", "102101009", "story_v_out_102101.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_11 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_11 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_11

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_11 and arg_36_1.time_ < var_39_1 + var_39_11 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play102101010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 102101010
		arg_40_1.duration_ = 3.4

		local var_40_0 = {
			ja = 2.533,
			ko = 3.4,
			zh = 2.766,
			en = 2
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
				arg_40_0:Play102101011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = "1084ui_story"

			if arg_40_1.actors_[var_43_0] == nil then
				local var_43_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_43_1) then
					local var_43_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_40_1.stage_.transform)

					var_43_2.name = var_43_0
					var_43_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_40_1.actors_[var_43_0] = var_43_2

					local var_43_3 = var_43_2:GetComponentInChildren(typeof(CharacterEffect))

					var_43_3.enabled = true

					local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_2, typeof(DynamicBoneHelper))

					if var_43_4 then
						var_43_4:EnableDynamicBone(false)
					end

					arg_40_1:ShowWeapon(var_43_3.transform, false)

					arg_40_1.var_[var_43_0 .. "Animator"] = var_43_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_40_1.var_[var_43_0 .. "Animator"].applyRootMotion = true
					arg_40_1.var_[var_43_0 .. "LipSync"] = var_43_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_43_5 = arg_40_1.actors_["1084ui_story"]
			local var_43_6 = 0

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_7 = 0.1

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_7 and not isNil(var_43_5) then
				local var_43_8 = (arg_40_1.time_ - var_43_6) / var_43_7

				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_5) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_6 + var_43_7 and arg_40_1.time_ < var_43_6 + var_43_7 + arg_43_0 and not isNil(var_43_5) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_43_9 = arg_40_1.actors_["10002ui_story"]
			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect10002ui_story == nil then
				arg_40_1.var_.characterEffect10002ui_story = var_43_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_11 = 0.1

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_11 and not isNil(var_43_9) then
				local var_43_12 = (arg_40_1.time_ - var_43_10) / var_43_11

				if arg_40_1.var_.characterEffect10002ui_story and not isNil(var_43_9) then
					local var_43_13 = Mathf.Lerp(0, 0.5, var_43_12)

					arg_40_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10002ui_story.fillRatio = var_43_13
				end
			end

			if arg_40_1.time_ >= var_43_10 + var_43_11 and arg_40_1.time_ < var_43_10 + var_43_11 + arg_43_0 and not isNil(var_43_9) and arg_40_1.var_.characterEffect10002ui_story then
				local var_43_14 = 0.5

				arg_40_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10002ui_story.fillRatio = var_43_14
			end

			local var_43_15 = arg_40_1.actors_["10002ui_story"].transform
			local var_43_16 = 0

			if var_43_16 < arg_40_1.time_ and arg_40_1.time_ <= var_43_16 + arg_43_0 then
				arg_40_1.var_.moveOldPos10002ui_story = var_43_15.localPosition
			end

			local var_43_17 = 0.001

			if var_43_16 <= arg_40_1.time_ and arg_40_1.time_ < var_43_16 + var_43_17 then
				local var_43_18 = (arg_40_1.time_ - var_43_16) / var_43_17
				local var_43_19 = Vector3.New(0, 100, 0)

				var_43_15.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos10002ui_story, var_43_19, var_43_18)

				local var_43_20 = manager.ui.mainCamera.transform.position - var_43_15.position

				var_43_15.forward = Vector3.New(var_43_20.x, var_43_20.y, var_43_20.z)

				local var_43_21 = var_43_15.localEulerAngles

				var_43_21.z = 0
				var_43_21.x = 0
				var_43_15.localEulerAngles = var_43_21
			end

			if arg_40_1.time_ >= var_43_16 + var_43_17 and arg_40_1.time_ < var_43_16 + var_43_17 + arg_43_0 then
				var_43_15.localPosition = Vector3.New(0, 100, 0)

				local var_43_22 = manager.ui.mainCamera.transform.position - var_43_15.position

				var_43_15.forward = Vector3.New(var_43_22.x, var_43_22.y, var_43_22.z)

				local var_43_23 = var_43_15.localEulerAngles

				var_43_23.z = 0
				var_43_23.x = 0
				var_43_15.localEulerAngles = var_43_23
			end

			local var_43_24 = 0

			if var_43_24 < arg_40_1.time_ and arg_40_1.time_ <= var_43_24 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_43_25 = arg_40_1.actors_["1084ui_story"].transform
			local var_43_26 = 0

			if var_43_26 < arg_40_1.time_ and arg_40_1.time_ <= var_43_26 + arg_43_0 then
				arg_40_1.var_.moveOldPos1084ui_story = var_43_25.localPosition
			end

			local var_43_27 = 0.001

			if var_43_26 <= arg_40_1.time_ and arg_40_1.time_ < var_43_26 + var_43_27 then
				local var_43_28 = (arg_40_1.time_ - var_43_26) / var_43_27
				local var_43_29 = Vector3.New(0.7, -0.97, -6)

				var_43_25.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1084ui_story, var_43_29, var_43_28)

				local var_43_30 = manager.ui.mainCamera.transform.position - var_43_25.position

				var_43_25.forward = Vector3.New(var_43_30.x, var_43_30.y, var_43_30.z)

				local var_43_31 = var_43_25.localEulerAngles

				var_43_31.z = 0
				var_43_31.x = 0
				var_43_25.localEulerAngles = var_43_31
			end

			if arg_40_1.time_ >= var_43_26 + var_43_27 and arg_40_1.time_ < var_43_26 + var_43_27 + arg_43_0 then
				var_43_25.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_43_32 = manager.ui.mainCamera.transform.position - var_43_25.position

				var_43_25.forward = Vector3.New(var_43_32.x, var_43_32.y, var_43_32.z)

				local var_43_33 = var_43_25.localEulerAngles

				var_43_33.z = 0
				var_43_33.x = 0
				var_43_25.localEulerAngles = var_43_33
			end

			local var_43_34 = 0

			if var_43_34 < arg_40_1.time_ and arg_40_1.time_ <= var_43_34 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_43_35 = 0
			local var_43_36 = 0.25

			if var_43_35 < arg_40_1.time_ and arg_40_1.time_ <= var_43_35 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_37 = arg_40_1:FormatText(StoryNameCfg[6].name)

				arg_40_1.leftNameTxt_.text = var_43_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_38 = arg_40_1:GetWordFromCfg(102101010)
				local var_43_39 = arg_40_1:FormatText(var_43_38.content)

				arg_40_1.text_.text = var_43_39

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_40 = 10
				local var_43_41 = utf8.len(var_43_39)
				local var_43_42 = var_43_40 <= 0 and var_43_36 or var_43_36 * (var_43_41 / var_43_40)

				if var_43_42 > 0 and var_43_36 < var_43_42 then
					arg_40_1.talkMaxDuration = var_43_42

					if var_43_42 + var_43_35 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_42 + var_43_35
					end
				end

				arg_40_1.text_.text = var_43_39
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101010", "story_v_out_102101.awb") ~= 0 then
					local var_43_43 = manager.audio:GetVoiceLength("story_v_out_102101", "102101010", "story_v_out_102101.awb") / 1000

					if var_43_43 + var_43_35 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_43 + var_43_35
					end

					if var_43_38.prefab_name ~= "" and arg_40_1.actors_[var_43_38.prefab_name] ~= nil then
						local var_43_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_38.prefab_name].transform, "story_v_out_102101", "102101010", "story_v_out_102101.awb")

						arg_40_1:RecordAudio("102101010", var_43_44)
						arg_40_1:RecordAudio("102101010", var_43_44)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_102101", "102101010", "story_v_out_102101.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_102101", "102101010", "story_v_out_102101.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_45 = math.max(var_43_36, arg_40_1.talkMaxDuration)

			if var_43_35 <= arg_40_1.time_ and arg_40_1.time_ < var_43_35 + var_43_45 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_35) / var_43_45

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_35 + var_43_45 and arg_40_1.time_ < var_43_35 + var_43_45 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_40_1:InitPlayNodeList()
	end,
	Play102101011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 102101011
		arg_44_1.duration_ = 8.63

		local var_44_0 = {
			ja = 7.4,
			ko = 6.2,
			zh = 6.266,
			en = 8.633
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
				arg_44_0:Play102101012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1019ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1019ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1019ui_story then
				arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["1084ui_story"]
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_6 = 0.1

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 and not isNil(var_47_4) then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6

				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_4) then
					local var_47_8 = Mathf.Lerp(0, 0.5, var_47_7)

					arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1084ui_story.fillRatio = var_47_8
				end
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1084ui_story then
				local var_47_9 = 0.5

				arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1084ui_story.fillRatio = var_47_9
			end

			local var_47_10 = 0

			if var_47_10 < arg_44_1.time_ and arg_44_1.time_ <= var_47_10 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action465")
			end

			local var_47_11 = 0

			if var_47_11 < arg_44_1.time_ and arg_44_1.time_ <= var_47_11 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_47_12 = 0
			local var_47_13 = 0.825

			if var_47_12 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_14 = arg_44_1:FormatText(StoryNameCfg[13].name)

				arg_44_1.leftNameTxt_.text = var_47_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_15 = arg_44_1:GetWordFromCfg(102101011)
				local var_47_16 = arg_44_1:FormatText(var_47_15.content)

				arg_44_1.text_.text = var_47_16

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 34
				local var_47_18 = utf8.len(var_47_16)
				local var_47_19 = var_47_17 <= 0 and var_47_13 or var_47_13 * (var_47_18 / var_47_17)

				if var_47_19 > 0 and var_47_13 < var_47_19 then
					arg_44_1.talkMaxDuration = var_47_19

					if var_47_19 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_19 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_16
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101011", "story_v_out_102101.awb") ~= 0 then
					local var_47_20 = manager.audio:GetVoiceLength("story_v_out_102101", "102101011", "story_v_out_102101.awb") / 1000

					if var_47_20 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_20 + var_47_12
					end

					if var_47_15.prefab_name ~= "" and arg_44_1.actors_[var_47_15.prefab_name] ~= nil then
						local var_47_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_15.prefab_name].transform, "story_v_out_102101", "102101011", "story_v_out_102101.awb")

						arg_44_1:RecordAudio("102101011", var_47_21)
						arg_44_1:RecordAudio("102101011", var_47_21)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_102101", "102101011", "story_v_out_102101.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_102101", "102101011", "story_v_out_102101.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_22 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_22 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_22

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_22 and arg_44_1.time_ < var_47_12 + var_47_22 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play102101012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 102101012
		arg_48_1.duration_ = 9

		local var_48_0 = {
			ja = 9,
			ko = 3.633,
			zh = 3.833,
			en = 3.566
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
				arg_48_0:Play102101013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["1011ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1011ui_story == nil then
				arg_48_1.var_.characterEffect1011ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect1011ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect1011ui_story then
				arg_48_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["1019ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect1019ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1019ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect1019ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1019ui_story.fillRatio = var_51_9
			end

			local var_51_10 = arg_48_1.actors_["1084ui_story"].transform
			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1.var_.moveOldPos1084ui_story = var_51_10.localPosition
			end

			local var_51_12 = 0.001

			if var_51_11 <= arg_48_1.time_ and arg_48_1.time_ < var_51_11 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_11) / var_51_12
				local var_51_14 = Vector3.New(0, 100, 0)

				var_51_10.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1084ui_story, var_51_14, var_51_13)

				local var_51_15 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_15.x, var_51_15.y, var_51_15.z)

				local var_51_16 = var_51_10.localEulerAngles

				var_51_16.z = 0
				var_51_16.x = 0
				var_51_10.localEulerAngles = var_51_16
			end

			if arg_48_1.time_ >= var_51_11 + var_51_12 and arg_48_1.time_ < var_51_11 + var_51_12 + arg_51_0 then
				var_51_10.localPosition = Vector3.New(0, 100, 0)

				local var_51_17 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_17.x, var_51_17.y, var_51_17.z)

				local var_51_18 = var_51_10.localEulerAngles

				var_51_18.z = 0
				var_51_18.x = 0
				var_51_10.localEulerAngles = var_51_18
			end

			local var_51_19 = arg_48_1.actors_["1011ui_story"].transform
			local var_51_20 = 0

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1.var_.moveOldPos1011ui_story = var_51_19.localPosition
			end

			local var_51_21 = 0.001

			if var_51_20 <= arg_48_1.time_ and arg_48_1.time_ < var_51_20 + var_51_21 then
				local var_51_22 = (arg_48_1.time_ - var_51_20) / var_51_21
				local var_51_23 = Vector3.New(0.7, -0.71, -6)

				var_51_19.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1011ui_story, var_51_23, var_51_22)

				local var_51_24 = manager.ui.mainCamera.transform.position - var_51_19.position

				var_51_19.forward = Vector3.New(var_51_24.x, var_51_24.y, var_51_24.z)

				local var_51_25 = var_51_19.localEulerAngles

				var_51_25.z = 0
				var_51_25.x = 0
				var_51_19.localEulerAngles = var_51_25
			end

			if arg_48_1.time_ >= var_51_20 + var_51_21 and arg_48_1.time_ < var_51_20 + var_51_21 + arg_51_0 then
				var_51_19.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_51_26 = manager.ui.mainCamera.transform.position - var_51_19.position

				var_51_19.forward = Vector3.New(var_51_26.x, var_51_26.y, var_51_26.z)

				local var_51_27 = var_51_19.localEulerAngles

				var_51_27.z = 0
				var_51_27.x = 0
				var_51_19.localEulerAngles = var_51_27
			end

			local var_51_28 = 0

			if var_51_28 < arg_48_1.time_ and arg_48_1.time_ <= var_51_28 + arg_51_0 then
				arg_48_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_51_29 = 0

			if var_51_29 < arg_48_1.time_ and arg_48_1.time_ <= var_51_29 + arg_51_0 then
				arg_48_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_51_30 = 0
			local var_51_31 = 0.4

			if var_51_30 < arg_48_1.time_ and arg_48_1.time_ <= var_51_30 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_32 = arg_48_1:FormatText(StoryNameCfg[37].name)

				arg_48_1.leftNameTxt_.text = var_51_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_33 = arg_48_1:GetWordFromCfg(102101012)
				local var_51_34 = arg_48_1:FormatText(var_51_33.content)

				arg_48_1.text_.text = var_51_34

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_35 = 16
				local var_51_36 = utf8.len(var_51_34)
				local var_51_37 = var_51_35 <= 0 and var_51_31 or var_51_31 * (var_51_36 / var_51_35)

				if var_51_37 > 0 and var_51_31 < var_51_37 then
					arg_48_1.talkMaxDuration = var_51_37

					if var_51_37 + var_51_30 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_37 + var_51_30
					end
				end

				arg_48_1.text_.text = var_51_34
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101012", "story_v_out_102101.awb") ~= 0 then
					local var_51_38 = manager.audio:GetVoiceLength("story_v_out_102101", "102101012", "story_v_out_102101.awb") / 1000

					if var_51_38 + var_51_30 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_38 + var_51_30
					end

					if var_51_33.prefab_name ~= "" and arg_48_1.actors_[var_51_33.prefab_name] ~= nil then
						local var_51_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_33.prefab_name].transform, "story_v_out_102101", "102101012", "story_v_out_102101.awb")

						arg_48_1:RecordAudio("102101012", var_51_39)
						arg_48_1:RecordAudio("102101012", var_51_39)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_102101", "102101012", "story_v_out_102101.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_102101", "102101012", "story_v_out_102101.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_40 = math.max(var_51_31, arg_48_1.talkMaxDuration)

			if var_51_30 <= arg_48_1.time_ and arg_48_1.time_ < var_51_30 + var_51_40 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_30) / var_51_40

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_30 + var_51_40 and arg_48_1.time_ < var_51_30 + var_51_40 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
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
	Play102101013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 102101013
		arg_52_1.duration_ = 11.33

		local var_52_0 = {
			ja = 10.333,
			ko = 9.166,
			zh = 8.533,
			en = 11.333
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
				arg_52_0:Play102101014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10002ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10002ui_story == nil then
				arg_52_1.var_.characterEffect10002ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect10002ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10002ui_story then
				arg_52_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["1011ui_story"].transform
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.var_.moveOldPos1011ui_story = var_55_4.localPosition
			end

			local var_55_6 = 0.001

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6
				local var_55_8 = Vector3.New(0, 100, 0)

				var_55_4.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1011ui_story, var_55_8, var_55_7)

				local var_55_9 = manager.ui.mainCamera.transform.position - var_55_4.position

				var_55_4.forward = Vector3.New(var_55_9.x, var_55_9.y, var_55_9.z)

				local var_55_10 = var_55_4.localEulerAngles

				var_55_10.z = 0
				var_55_10.x = 0
				var_55_4.localEulerAngles = var_55_10
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 then
				var_55_4.localPosition = Vector3.New(0, 100, 0)

				local var_55_11 = manager.ui.mainCamera.transform.position - var_55_4.position

				var_55_4.forward = Vector3.New(var_55_11.x, var_55_11.y, var_55_11.z)

				local var_55_12 = var_55_4.localEulerAngles

				var_55_12.z = 0
				var_55_12.x = 0
				var_55_4.localEulerAngles = var_55_12
			end

			local var_55_13 = arg_52_1.actors_["1019ui_story"].transform
			local var_55_14 = 0

			if var_55_14 < arg_52_1.time_ and arg_52_1.time_ <= var_55_14 + arg_55_0 then
				arg_52_1.var_.moveOldPos1019ui_story = var_55_13.localPosition
			end

			local var_55_15 = 0.001

			if var_55_14 <= arg_52_1.time_ and arg_52_1.time_ < var_55_14 + var_55_15 then
				local var_55_16 = (arg_52_1.time_ - var_55_14) / var_55_15
				local var_55_17 = Vector3.New(0, 100, 0)

				var_55_13.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1019ui_story, var_55_17, var_55_16)

				local var_55_18 = manager.ui.mainCamera.transform.position - var_55_13.position

				var_55_13.forward = Vector3.New(var_55_18.x, var_55_18.y, var_55_18.z)

				local var_55_19 = var_55_13.localEulerAngles

				var_55_19.z = 0
				var_55_19.x = 0
				var_55_13.localEulerAngles = var_55_19
			end

			if arg_52_1.time_ >= var_55_14 + var_55_15 and arg_52_1.time_ < var_55_14 + var_55_15 + arg_55_0 then
				var_55_13.localPosition = Vector3.New(0, 100, 0)

				local var_55_20 = manager.ui.mainCamera.transform.position - var_55_13.position

				var_55_13.forward = Vector3.New(var_55_20.x, var_55_20.y, var_55_20.z)

				local var_55_21 = var_55_13.localEulerAngles

				var_55_21.z = 0
				var_55_21.x = 0
				var_55_13.localEulerAngles = var_55_21
			end

			local var_55_22 = arg_52_1.actors_["10002ui_story"].transform
			local var_55_23 = 0

			if var_55_23 < arg_52_1.time_ and arg_52_1.time_ <= var_55_23 + arg_55_0 then
				arg_52_1.var_.moveOldPos10002ui_story = var_55_22.localPosition
			end

			local var_55_24 = 0.001

			if var_55_23 <= arg_52_1.time_ and arg_52_1.time_ < var_55_23 + var_55_24 then
				local var_55_25 = (arg_52_1.time_ - var_55_23) / var_55_24
				local var_55_26 = Vector3.New(0, -1.2, -5.8)

				var_55_22.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10002ui_story, var_55_26, var_55_25)

				local var_55_27 = manager.ui.mainCamera.transform.position - var_55_22.position

				var_55_22.forward = Vector3.New(var_55_27.x, var_55_27.y, var_55_27.z)

				local var_55_28 = var_55_22.localEulerAngles

				var_55_28.z = 0
				var_55_28.x = 0
				var_55_22.localEulerAngles = var_55_28
			end

			if arg_52_1.time_ >= var_55_23 + var_55_24 and arg_52_1.time_ < var_55_23 + var_55_24 + arg_55_0 then
				var_55_22.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_55_29 = manager.ui.mainCamera.transform.position - var_55_22.position

				var_55_22.forward = Vector3.New(var_55_29.x, var_55_29.y, var_55_29.z)

				local var_55_30 = var_55_22.localEulerAngles

				var_55_30.z = 0
				var_55_30.x = 0
				var_55_22.localEulerAngles = var_55_30
			end

			local var_55_31 = 0

			if var_55_31 < arg_52_1.time_ and arg_52_1.time_ <= var_55_31 + arg_55_0 then
				arg_52_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			local var_55_32 = 0

			if var_55_32 < arg_52_1.time_ and arg_52_1.time_ <= var_55_32 + arg_55_0 then
				arg_52_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_55_33 = 0
			local var_55_34 = 0.875

			if var_55_33 < arg_52_1.time_ and arg_52_1.time_ <= var_55_33 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_35 = arg_52_1:FormatText(StoryNameCfg[39].name)

				arg_52_1.leftNameTxt_.text = var_55_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_36 = arg_52_1:GetWordFromCfg(102101013)
				local var_55_37 = arg_52_1:FormatText(var_55_36.content)

				arg_52_1.text_.text = var_55_37

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_38 = 33
				local var_55_39 = utf8.len(var_55_37)
				local var_55_40 = var_55_38 <= 0 and var_55_34 or var_55_34 * (var_55_39 / var_55_38)

				if var_55_40 > 0 and var_55_34 < var_55_40 then
					arg_52_1.talkMaxDuration = var_55_40

					if var_55_40 + var_55_33 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_40 + var_55_33
					end
				end

				arg_52_1.text_.text = var_55_37
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101013", "story_v_out_102101.awb") ~= 0 then
					local var_55_41 = manager.audio:GetVoiceLength("story_v_out_102101", "102101013", "story_v_out_102101.awb") / 1000

					if var_55_41 + var_55_33 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_41 + var_55_33
					end

					if var_55_36.prefab_name ~= "" and arg_52_1.actors_[var_55_36.prefab_name] ~= nil then
						local var_55_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_36.prefab_name].transform, "story_v_out_102101", "102101013", "story_v_out_102101.awb")

						arg_52_1:RecordAudio("102101013", var_55_42)
						arg_52_1:RecordAudio("102101013", var_55_42)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_102101", "102101013", "story_v_out_102101.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_102101", "102101013", "story_v_out_102101.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_43 = math.max(var_55_34, arg_52_1.talkMaxDuration)

			if var_55_33 <= arg_52_1.time_ and arg_52_1.time_ < var_55_33 + var_55_43 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_33) / var_55_43

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_33 + var_55_43 and arg_52_1.time_ < var_55_33 + var_55_43 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
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
	Play102101014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 102101014
		arg_56_1.duration_ = 5.33

		local var_56_0 = {
			ja = 5.333,
			ko = 4.766,
			zh = 4.233,
			en = 4.3
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
				arg_56_0:Play102101015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1084ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1084ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1084ui_story then
				arg_56_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["10002ui_story"].transform
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.var_.moveOldPos10002ui_story = var_59_4.localPosition
			end

			local var_59_6 = 0.001

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6
				local var_59_8 = Vector3.New(0, 100, 0)

				var_59_4.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos10002ui_story, var_59_8, var_59_7)

				local var_59_9 = manager.ui.mainCamera.transform.position - var_59_4.position

				var_59_4.forward = Vector3.New(var_59_9.x, var_59_9.y, var_59_9.z)

				local var_59_10 = var_59_4.localEulerAngles

				var_59_10.z = 0
				var_59_10.x = 0
				var_59_4.localEulerAngles = var_59_10
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 then
				var_59_4.localPosition = Vector3.New(0, 100, 0)

				local var_59_11 = manager.ui.mainCamera.transform.position - var_59_4.position

				var_59_4.forward = Vector3.New(var_59_11.x, var_59_11.y, var_59_11.z)

				local var_59_12 = var_59_4.localEulerAngles

				var_59_12.z = 0
				var_59_12.x = 0
				var_59_4.localEulerAngles = var_59_12
			end

			local var_59_13 = arg_56_1.actors_["1084ui_story"].transform
			local var_59_14 = 0

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 then
				arg_56_1.var_.moveOldPos1084ui_story = var_59_13.localPosition
			end

			local var_59_15 = 0.001

			if var_59_14 <= arg_56_1.time_ and arg_56_1.time_ < var_59_14 + var_59_15 then
				local var_59_16 = (arg_56_1.time_ - var_59_14) / var_59_15
				local var_59_17 = Vector3.New(-0.7, -0.97, -6)

				var_59_13.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1084ui_story, var_59_17, var_59_16)

				local var_59_18 = manager.ui.mainCamera.transform.position - var_59_13.position

				var_59_13.forward = Vector3.New(var_59_18.x, var_59_18.y, var_59_18.z)

				local var_59_19 = var_59_13.localEulerAngles

				var_59_19.z = 0
				var_59_19.x = 0
				var_59_13.localEulerAngles = var_59_19
			end

			if arg_56_1.time_ >= var_59_14 + var_59_15 and arg_56_1.time_ < var_59_14 + var_59_15 + arg_59_0 then
				var_59_13.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_59_20 = manager.ui.mainCamera.transform.position - var_59_13.position

				var_59_13.forward = Vector3.New(var_59_20.x, var_59_20.y, var_59_20.z)

				local var_59_21 = var_59_13.localEulerAngles

				var_59_21.z = 0
				var_59_21.x = 0
				var_59_13.localEulerAngles = var_59_21
			end

			local var_59_22 = 0

			if var_59_22 < arg_56_1.time_ and arg_56_1.time_ <= var_59_22 + arg_59_0 then
				arg_56_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_59_23 = 0

			if var_59_23 < arg_56_1.time_ and arg_56_1.time_ <= var_59_23 + arg_59_0 then
				arg_56_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_59_24 = 0
			local var_59_25 = 0.375

			if var_59_24 < arg_56_1.time_ and arg_56_1.time_ <= var_59_24 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_26 = arg_56_1:FormatText(StoryNameCfg[6].name)

				arg_56_1.leftNameTxt_.text = var_59_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_27 = arg_56_1:GetWordFromCfg(102101014)
				local var_59_28 = arg_56_1:FormatText(var_59_27.content)

				arg_56_1.text_.text = var_59_28

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_29 = 15
				local var_59_30 = utf8.len(var_59_28)
				local var_59_31 = var_59_29 <= 0 and var_59_25 or var_59_25 * (var_59_30 / var_59_29)

				if var_59_31 > 0 and var_59_25 < var_59_31 then
					arg_56_1.talkMaxDuration = var_59_31

					if var_59_31 + var_59_24 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_31 + var_59_24
					end
				end

				arg_56_1.text_.text = var_59_28
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101014", "story_v_out_102101.awb") ~= 0 then
					local var_59_32 = manager.audio:GetVoiceLength("story_v_out_102101", "102101014", "story_v_out_102101.awb") / 1000

					if var_59_32 + var_59_24 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_32 + var_59_24
					end

					if var_59_27.prefab_name ~= "" and arg_56_1.actors_[var_59_27.prefab_name] ~= nil then
						local var_59_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_27.prefab_name].transform, "story_v_out_102101", "102101014", "story_v_out_102101.awb")

						arg_56_1:RecordAudio("102101014", var_59_33)
						arg_56_1:RecordAudio("102101014", var_59_33)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_102101", "102101014", "story_v_out_102101.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_102101", "102101014", "story_v_out_102101.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_34 = math.max(var_59_25, arg_56_1.talkMaxDuration)

			if var_59_24 <= arg_56_1.time_ and arg_56_1.time_ < var_59_24 + var_59_34 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_24) / var_59_34

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_24 + var_59_34 and arg_56_1.time_ < var_59_24 + var_59_34 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_56_1:InitPlayNodeList()
	end,
	Play102101015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 102101015
		arg_60_1.duration_ = 9.37

		local var_60_0 = {
			ja = 9.366,
			ko = 6.4,
			zh = 7.033,
			en = 8.5
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
				arg_60_0:Play102101016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["1019ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1019ui_story == nil then
				arg_60_1.var_.characterEffect1019ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.1

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect1019ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect1019ui_story then
				arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_63_4 = arg_60_1.actors_["1084ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.1

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect1084ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1084ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1084ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1084ui_story.fillRatio = var_63_9
			end

			local var_63_10 = arg_60_1.actors_["1019ui_story"].transform
			local var_63_11 = 0

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1.var_.moveOldPos1019ui_story = var_63_10.localPosition
			end

			local var_63_12 = 0.001

			if var_63_11 <= arg_60_1.time_ and arg_60_1.time_ < var_63_11 + var_63_12 then
				local var_63_13 = (arg_60_1.time_ - var_63_11) / var_63_12
				local var_63_14 = Vector3.New(0.7, -1.08, -5.9)

				var_63_10.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1019ui_story, var_63_14, var_63_13)

				local var_63_15 = manager.ui.mainCamera.transform.position - var_63_10.position

				var_63_10.forward = Vector3.New(var_63_15.x, var_63_15.y, var_63_15.z)

				local var_63_16 = var_63_10.localEulerAngles

				var_63_16.z = 0
				var_63_16.x = 0
				var_63_10.localEulerAngles = var_63_16
			end

			if arg_60_1.time_ >= var_63_11 + var_63_12 and arg_60_1.time_ < var_63_11 + var_63_12 + arg_63_0 then
				var_63_10.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_63_17 = manager.ui.mainCamera.transform.position - var_63_10.position

				var_63_10.forward = Vector3.New(var_63_17.x, var_63_17.y, var_63_17.z)

				local var_63_18 = var_63_10.localEulerAngles

				var_63_18.z = 0
				var_63_18.x = 0
				var_63_10.localEulerAngles = var_63_18
			end

			local var_63_19 = 0

			if var_63_19 < arg_60_1.time_ and arg_60_1.time_ <= var_63_19 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_63_20 = 0

			if var_63_20 < arg_60_1.time_ and arg_60_1.time_ <= var_63_20 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_63_21 = 0
			local var_63_22 = 0.85

			if var_63_21 < arg_60_1.time_ and arg_60_1.time_ <= var_63_21 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_23 = arg_60_1:FormatText(StoryNameCfg[13].name)

				arg_60_1.leftNameTxt_.text = var_63_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_24 = arg_60_1:GetWordFromCfg(102101015)
				local var_63_25 = arg_60_1:FormatText(var_63_24.content)

				arg_60_1.text_.text = var_63_25

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_26 = 34
				local var_63_27 = utf8.len(var_63_25)
				local var_63_28 = var_63_26 <= 0 and var_63_22 or var_63_22 * (var_63_27 / var_63_26)

				if var_63_28 > 0 and var_63_22 < var_63_28 then
					arg_60_1.talkMaxDuration = var_63_28

					if var_63_28 + var_63_21 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_28 + var_63_21
					end
				end

				arg_60_1.text_.text = var_63_25
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101015", "story_v_out_102101.awb") ~= 0 then
					local var_63_29 = manager.audio:GetVoiceLength("story_v_out_102101", "102101015", "story_v_out_102101.awb") / 1000

					if var_63_29 + var_63_21 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_29 + var_63_21
					end

					if var_63_24.prefab_name ~= "" and arg_60_1.actors_[var_63_24.prefab_name] ~= nil then
						local var_63_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_24.prefab_name].transform, "story_v_out_102101", "102101015", "story_v_out_102101.awb")

						arg_60_1:RecordAudio("102101015", var_63_30)
						arg_60_1:RecordAudio("102101015", var_63_30)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_102101", "102101015", "story_v_out_102101.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_102101", "102101015", "story_v_out_102101.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_31 = math.max(var_63_22, arg_60_1.talkMaxDuration)

			if var_63_21 <= arg_60_1.time_ and arg_60_1.time_ < var_63_21 + var_63_31 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_21) / var_63_31

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_21 + var_63_31 and arg_60_1.time_ < var_63_21 + var_63_31 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play102101016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 102101016
		arg_64_1.duration_ = 5

		local var_64_0 = {
			ja = 5,
			ko = 3.6,
			zh = 3,
			en = 3.166
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
				arg_64_0:Play102101017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1011ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1011ui_story == nil then
				arg_64_1.var_.characterEffect1011ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1011ui_story and not isNil(var_67_0) then
					arg_64_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1011ui_story then
				arg_64_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_67_4 = arg_64_1.actors_["1019ui_story"]
			local var_67_5 = 0

			if var_67_5 < arg_64_1.time_ and arg_64_1.time_ <= var_67_5 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1019ui_story == nil then
				arg_64_1.var_.characterEffect1019ui_story = var_67_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_6 = 0.1

			if var_67_5 <= arg_64_1.time_ and arg_64_1.time_ < var_67_5 + var_67_6 and not isNil(var_67_4) then
				local var_67_7 = (arg_64_1.time_ - var_67_5) / var_67_6

				if arg_64_1.var_.characterEffect1019ui_story and not isNil(var_67_4) then
					local var_67_8 = Mathf.Lerp(0, 0.5, var_67_7)

					arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1019ui_story.fillRatio = var_67_8
				end
			end

			if arg_64_1.time_ >= var_67_5 + var_67_6 and arg_64_1.time_ < var_67_5 + var_67_6 + arg_67_0 and not isNil(var_67_4) and arg_64_1.var_.characterEffect1019ui_story then
				local var_67_9 = 0.5

				arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1019ui_story.fillRatio = var_67_9
			end

			local var_67_10 = arg_64_1.actors_["1019ui_story"].transform
			local var_67_11 = 0

			if var_67_11 < arg_64_1.time_ and arg_64_1.time_ <= var_67_11 + arg_67_0 then
				arg_64_1.var_.moveOldPos1019ui_story = var_67_10.localPosition
			end

			local var_67_12 = 0.001

			if var_67_11 <= arg_64_1.time_ and arg_64_1.time_ < var_67_11 + var_67_12 then
				local var_67_13 = (arg_64_1.time_ - var_67_11) / var_67_12
				local var_67_14 = Vector3.New(0, 100, 0)

				var_67_10.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1019ui_story, var_67_14, var_67_13)

				local var_67_15 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_15.x, var_67_15.y, var_67_15.z)

				local var_67_16 = var_67_10.localEulerAngles

				var_67_16.z = 0
				var_67_16.x = 0
				var_67_10.localEulerAngles = var_67_16
			end

			if arg_64_1.time_ >= var_67_11 + var_67_12 and arg_64_1.time_ < var_67_11 + var_67_12 + arg_67_0 then
				var_67_10.localPosition = Vector3.New(0, 100, 0)

				local var_67_17 = manager.ui.mainCamera.transform.position - var_67_10.position

				var_67_10.forward = Vector3.New(var_67_17.x, var_67_17.y, var_67_17.z)

				local var_67_18 = var_67_10.localEulerAngles

				var_67_18.z = 0
				var_67_18.x = 0
				var_67_10.localEulerAngles = var_67_18
			end

			local var_67_19 = arg_64_1.actors_["1084ui_story"].transform
			local var_67_20 = 0

			if var_67_20 < arg_64_1.time_ and arg_64_1.time_ <= var_67_20 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = var_67_19.localPosition
			end

			local var_67_21 = 0.001

			if var_67_20 <= arg_64_1.time_ and arg_64_1.time_ < var_67_20 + var_67_21 then
				local var_67_22 = (arg_64_1.time_ - var_67_20) / var_67_21
				local var_67_23 = Vector3.New(0, 100, 0)

				var_67_19.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, var_67_23, var_67_22)

				local var_67_24 = manager.ui.mainCamera.transform.position - var_67_19.position

				var_67_19.forward = Vector3.New(var_67_24.x, var_67_24.y, var_67_24.z)

				local var_67_25 = var_67_19.localEulerAngles

				var_67_25.z = 0
				var_67_25.x = 0
				var_67_19.localEulerAngles = var_67_25
			end

			if arg_64_1.time_ >= var_67_20 + var_67_21 and arg_64_1.time_ < var_67_20 + var_67_21 + arg_67_0 then
				var_67_19.localPosition = Vector3.New(0, 100, 0)

				local var_67_26 = manager.ui.mainCamera.transform.position - var_67_19.position

				var_67_19.forward = Vector3.New(var_67_26.x, var_67_26.y, var_67_26.z)

				local var_67_27 = var_67_19.localEulerAngles

				var_67_27.z = 0
				var_67_27.x = 0
				var_67_19.localEulerAngles = var_67_27
			end

			local var_67_28 = 0

			if var_67_28 < arg_64_1.time_ and arg_64_1.time_ <= var_67_28 + arg_67_0 then
				arg_64_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_67_29 = arg_64_1.actors_["1011ui_story"].transform
			local var_67_30 = 0

			if var_67_30 < arg_64_1.time_ and arg_64_1.time_ <= var_67_30 + arg_67_0 then
				arg_64_1.var_.moveOldPos1011ui_story = var_67_29.localPosition
			end

			local var_67_31 = 0.001

			if var_67_30 <= arg_64_1.time_ and arg_64_1.time_ < var_67_30 + var_67_31 then
				local var_67_32 = (arg_64_1.time_ - var_67_30) / var_67_31
				local var_67_33 = Vector3.New(-0.7, -0.71, -6)

				var_67_29.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1011ui_story, var_67_33, var_67_32)

				local var_67_34 = manager.ui.mainCamera.transform.position - var_67_29.position

				var_67_29.forward = Vector3.New(var_67_34.x, var_67_34.y, var_67_34.z)

				local var_67_35 = var_67_29.localEulerAngles

				var_67_35.z = 0
				var_67_35.x = 0
				var_67_29.localEulerAngles = var_67_35
			end

			if arg_64_1.time_ >= var_67_30 + var_67_31 and arg_64_1.time_ < var_67_30 + var_67_31 + arg_67_0 then
				var_67_29.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_67_36 = manager.ui.mainCamera.transform.position - var_67_29.position

				var_67_29.forward = Vector3.New(var_67_36.x, var_67_36.y, var_67_36.z)

				local var_67_37 = var_67_29.localEulerAngles

				var_67_37.z = 0
				var_67_37.x = 0
				var_67_29.localEulerAngles = var_67_37
			end

			local var_67_38 = 0

			if var_67_38 < arg_64_1.time_ and arg_64_1.time_ <= var_67_38 + arg_67_0 then
				arg_64_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_67_39 = 0
			local var_67_40 = 0.375

			if var_67_39 < arg_64_1.time_ and arg_64_1.time_ <= var_67_39 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_41 = arg_64_1:FormatText(StoryNameCfg[37].name)

				arg_64_1.leftNameTxt_.text = var_67_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_42 = arg_64_1:GetWordFromCfg(102101016)
				local var_67_43 = arg_64_1:FormatText(var_67_42.content)

				arg_64_1.text_.text = var_67_43

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_44 = 15
				local var_67_45 = utf8.len(var_67_43)
				local var_67_46 = var_67_44 <= 0 and var_67_40 or var_67_40 * (var_67_45 / var_67_44)

				if var_67_46 > 0 and var_67_40 < var_67_46 then
					arg_64_1.talkMaxDuration = var_67_46

					if var_67_46 + var_67_39 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_46 + var_67_39
					end
				end

				arg_64_1.text_.text = var_67_43
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101016", "story_v_out_102101.awb") ~= 0 then
					local var_67_47 = manager.audio:GetVoiceLength("story_v_out_102101", "102101016", "story_v_out_102101.awb") / 1000

					if var_67_47 + var_67_39 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_47 + var_67_39
					end

					if var_67_42.prefab_name ~= "" and arg_64_1.actors_[var_67_42.prefab_name] ~= nil then
						local var_67_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_42.prefab_name].transform, "story_v_out_102101", "102101016", "story_v_out_102101.awb")

						arg_64_1:RecordAudio("102101016", var_67_48)
						arg_64_1:RecordAudio("102101016", var_67_48)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_102101", "102101016", "story_v_out_102101.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_102101", "102101016", "story_v_out_102101.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_49 = math.max(var_67_40, arg_64_1.talkMaxDuration)

			if var_67_39 <= arg_64_1.time_ and arg_64_1.time_ < var_67_39 + var_67_49 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_39) / var_67_49

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_39 + var_67_49 and arg_64_1.time_ < var_67_39 + var_67_49 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_64_1:InitPlayNodeList()
	end,
	Play102101017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 102101017
		arg_68_1.duration_ = 15.57

		local var_68_0 = {
			ja = 11.366,
			ko = 15.566,
			zh = 12.8,
			en = 14.166
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play102101018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10002ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10002ui_story == nil then
				arg_68_1.var_.characterEffect10002ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.1

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect10002ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10002ui_story then
				arg_68_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_71_4 = arg_68_1.actors_["1011ui_story"]
			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1011ui_story == nil then
				arg_68_1.var_.characterEffect1011ui_story = var_71_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_6 = 0.1

			if var_71_5 <= arg_68_1.time_ and arg_68_1.time_ < var_71_5 + var_71_6 and not isNil(var_71_4) then
				local var_71_7 = (arg_68_1.time_ - var_71_5) / var_71_6

				if arg_68_1.var_.characterEffect1011ui_story and not isNil(var_71_4) then
					local var_71_8 = Mathf.Lerp(0, 0.5, var_71_7)

					arg_68_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1011ui_story.fillRatio = var_71_8
				end
			end

			if arg_68_1.time_ >= var_71_5 + var_71_6 and arg_68_1.time_ < var_71_5 + var_71_6 + arg_71_0 and not isNil(var_71_4) and arg_68_1.var_.characterEffect1011ui_story then
				local var_71_9 = 0.5

				arg_68_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1011ui_story.fillRatio = var_71_9
			end

			local var_71_10 = arg_68_1.actors_["10002ui_story"].transform
			local var_71_11 = 0

			if var_71_11 < arg_68_1.time_ and arg_68_1.time_ <= var_71_11 + arg_71_0 then
				arg_68_1.var_.moveOldPos10002ui_story = var_71_10.localPosition
			end

			local var_71_12 = 0.001

			if var_71_11 <= arg_68_1.time_ and arg_68_1.time_ < var_71_11 + var_71_12 then
				local var_71_13 = (arg_68_1.time_ - var_71_11) / var_71_12
				local var_71_14 = Vector3.New(0.7, -1.2, -5.8)

				var_71_10.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos10002ui_story, var_71_14, var_71_13)

				local var_71_15 = manager.ui.mainCamera.transform.position - var_71_10.position

				var_71_10.forward = Vector3.New(var_71_15.x, var_71_15.y, var_71_15.z)

				local var_71_16 = var_71_10.localEulerAngles

				var_71_16.z = 0
				var_71_16.x = 0
				var_71_10.localEulerAngles = var_71_16
			end

			if arg_68_1.time_ >= var_71_11 + var_71_12 and arg_68_1.time_ < var_71_11 + var_71_12 + arg_71_0 then
				var_71_10.localPosition = Vector3.New(0.7, -1.2, -5.8)

				local var_71_17 = manager.ui.mainCamera.transform.position - var_71_10.position

				var_71_10.forward = Vector3.New(var_71_17.x, var_71_17.y, var_71_17.z)

				local var_71_18 = var_71_10.localEulerAngles

				var_71_18.z = 0
				var_71_18.x = 0
				var_71_10.localEulerAngles = var_71_18
			end

			local var_71_19 = 0

			if var_71_19 < arg_68_1.time_ and arg_68_1.time_ <= var_71_19 + arg_71_0 then
				arg_68_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			local var_71_20 = 0

			if var_71_20 < arg_68_1.time_ and arg_68_1.time_ <= var_71_20 + arg_71_0 then
				arg_68_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_71_21 = 0
			local var_71_22 = 1.4

			if var_71_21 < arg_68_1.time_ and arg_68_1.time_ <= var_71_21 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_23 = arg_68_1:FormatText(StoryNameCfg[39].name)

				arg_68_1.leftNameTxt_.text = var_71_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_24 = arg_68_1:GetWordFromCfg(102101017)
				local var_71_25 = arg_68_1:FormatText(var_71_24.content)

				arg_68_1.text_.text = var_71_25

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_26 = 56
				local var_71_27 = utf8.len(var_71_25)
				local var_71_28 = var_71_26 <= 0 and var_71_22 or var_71_22 * (var_71_27 / var_71_26)

				if var_71_28 > 0 and var_71_22 < var_71_28 then
					arg_68_1.talkMaxDuration = var_71_28

					if var_71_28 + var_71_21 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_28 + var_71_21
					end
				end

				arg_68_1.text_.text = var_71_25
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101017", "story_v_out_102101.awb") ~= 0 then
					local var_71_29 = manager.audio:GetVoiceLength("story_v_out_102101", "102101017", "story_v_out_102101.awb") / 1000

					if var_71_29 + var_71_21 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_29 + var_71_21
					end

					if var_71_24.prefab_name ~= "" and arg_68_1.actors_[var_71_24.prefab_name] ~= nil then
						local var_71_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_24.prefab_name].transform, "story_v_out_102101", "102101017", "story_v_out_102101.awb")

						arg_68_1:RecordAudio("102101017", var_71_30)
						arg_68_1:RecordAudio("102101017", var_71_30)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_102101", "102101017", "story_v_out_102101.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_102101", "102101017", "story_v_out_102101.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_31 = math.max(var_71_22, arg_68_1.talkMaxDuration)

			if var_71_21 <= arg_68_1.time_ and arg_68_1.time_ < var_71_21 + var_71_31 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_21) / var_71_31

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_21 + var_71_31 and arg_68_1.time_ < var_71_21 + var_71_31 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_68_1:InitPlayNodeList()
	end,
	Play102101018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 102101018
		arg_72_1.duration_ = 6.83

		local var_72_0 = {
			ja = 6.833,
			ko = 3.933,
			zh = 3.6,
			en = 4.066
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play102101019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["1084ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.1

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect1084ui_story and not isNil(var_75_0) then
					arg_72_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect1084ui_story then
				arg_72_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_75_4 = arg_72_1.actors_["10002ui_story"]
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect10002ui_story == nil then
				arg_72_1.var_.characterEffect10002ui_story = var_75_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.1

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 and not isNil(var_75_4) then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6

				if arg_72_1.var_.characterEffect10002ui_story and not isNil(var_75_4) then
					local var_75_8 = Mathf.Lerp(0, 0.5, var_75_7)

					arg_72_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_72_1.var_.characterEffect10002ui_story.fillRatio = var_75_8
				end
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect10002ui_story then
				local var_75_9 = 0.5

				arg_72_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_72_1.var_.characterEffect10002ui_story.fillRatio = var_75_9
			end

			local var_75_10 = arg_72_1.actors_["1011ui_story"].transform
			local var_75_11 = 0

			if var_75_11 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 then
				arg_72_1.var_.moveOldPos1011ui_story = var_75_10.localPosition
			end

			local var_75_12 = 0.001

			if var_75_11 <= arg_72_1.time_ and arg_72_1.time_ < var_75_11 + var_75_12 then
				local var_75_13 = (arg_72_1.time_ - var_75_11) / var_75_12
				local var_75_14 = Vector3.New(0, 100, 0)

				var_75_10.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1011ui_story, var_75_14, var_75_13)

				local var_75_15 = manager.ui.mainCamera.transform.position - var_75_10.position

				var_75_10.forward = Vector3.New(var_75_15.x, var_75_15.y, var_75_15.z)

				local var_75_16 = var_75_10.localEulerAngles

				var_75_16.z = 0
				var_75_16.x = 0
				var_75_10.localEulerAngles = var_75_16
			end

			if arg_72_1.time_ >= var_75_11 + var_75_12 and arg_72_1.time_ < var_75_11 + var_75_12 + arg_75_0 then
				var_75_10.localPosition = Vector3.New(0, 100, 0)

				local var_75_17 = manager.ui.mainCamera.transform.position - var_75_10.position

				var_75_10.forward = Vector3.New(var_75_17.x, var_75_17.y, var_75_17.z)

				local var_75_18 = var_75_10.localEulerAngles

				var_75_18.z = 0
				var_75_18.x = 0
				var_75_10.localEulerAngles = var_75_18
			end

			local var_75_19 = arg_72_1.actors_["1084ui_story"].transform
			local var_75_20 = 0

			if var_75_20 < arg_72_1.time_ and arg_72_1.time_ <= var_75_20 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_19.localPosition
			end

			local var_75_21 = 0.001

			if var_75_20 <= arg_72_1.time_ and arg_72_1.time_ < var_75_20 + var_75_21 then
				local var_75_22 = (arg_72_1.time_ - var_75_20) / var_75_21
				local var_75_23 = Vector3.New(-0.7, -0.97, -6)

				var_75_19.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, var_75_23, var_75_22)

				local var_75_24 = manager.ui.mainCamera.transform.position - var_75_19.position

				var_75_19.forward = Vector3.New(var_75_24.x, var_75_24.y, var_75_24.z)

				local var_75_25 = var_75_19.localEulerAngles

				var_75_25.z = 0
				var_75_25.x = 0
				var_75_19.localEulerAngles = var_75_25
			end

			if arg_72_1.time_ >= var_75_20 + var_75_21 and arg_72_1.time_ < var_75_20 + var_75_21 + arg_75_0 then
				var_75_19.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_75_26 = manager.ui.mainCamera.transform.position - var_75_19.position

				var_75_19.forward = Vector3.New(var_75_26.x, var_75_26.y, var_75_26.z)

				local var_75_27 = var_75_19.localEulerAngles

				var_75_27.z = 0
				var_75_27.x = 0
				var_75_19.localEulerAngles = var_75_27
			end

			local var_75_28 = 0

			if var_75_28 < arg_72_1.time_ and arg_72_1.time_ <= var_75_28 + arg_75_0 then
				arg_72_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			local var_75_29 = 0

			if var_75_29 < arg_72_1.time_ and arg_72_1.time_ <= var_75_29 + arg_75_0 then
				arg_72_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_75_30 = 0
			local var_75_31 = 0.375

			if var_75_30 < arg_72_1.time_ and arg_72_1.time_ <= var_75_30 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_32 = arg_72_1:FormatText(StoryNameCfg[6].name)

				arg_72_1.leftNameTxt_.text = var_75_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_33 = arg_72_1:GetWordFromCfg(102101018)
				local var_75_34 = arg_72_1:FormatText(var_75_33.content)

				arg_72_1.text_.text = var_75_34

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_35 = 15
				local var_75_36 = utf8.len(var_75_34)
				local var_75_37 = var_75_35 <= 0 and var_75_31 or var_75_31 * (var_75_36 / var_75_35)

				if var_75_37 > 0 and var_75_31 < var_75_37 then
					arg_72_1.talkMaxDuration = var_75_37

					if var_75_37 + var_75_30 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_37 + var_75_30
					end
				end

				arg_72_1.text_.text = var_75_34
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101018", "story_v_out_102101.awb") ~= 0 then
					local var_75_38 = manager.audio:GetVoiceLength("story_v_out_102101", "102101018", "story_v_out_102101.awb") / 1000

					if var_75_38 + var_75_30 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_38 + var_75_30
					end

					if var_75_33.prefab_name ~= "" and arg_72_1.actors_[var_75_33.prefab_name] ~= nil then
						local var_75_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_33.prefab_name].transform, "story_v_out_102101", "102101018", "story_v_out_102101.awb")

						arg_72_1:RecordAudio("102101018", var_75_39)
						arg_72_1:RecordAudio("102101018", var_75_39)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_102101", "102101018", "story_v_out_102101.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_102101", "102101018", "story_v_out_102101.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_40 = math.max(var_75_31, arg_72_1.talkMaxDuration)

			if var_75_30 <= arg_72_1.time_ and arg_72_1.time_ < var_75_30 + var_75_40 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_30) / var_75_40

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_30 + var_75_40 and arg_72_1.time_ < var_75_30 + var_75_40 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_72_1:InitPlayNodeList()
	end,
	Play102101019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 102101019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play102101020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1084ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1084ui_story == nil then
				arg_76_1.var_.characterEffect1084ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1084ui_story and not isNil(var_79_0) then
					local var_79_4 = Mathf.Lerp(0, 0.5, var_79_3)

					arg_76_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1084ui_story.fillRatio = var_79_4
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1084ui_story then
				local var_79_5 = 0.5

				arg_76_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1084ui_story.fillRatio = var_79_5
			end

			local var_79_6 = arg_76_1.actors_["1084ui_story"].transform
			local var_79_7 = 0

			if var_79_7 < arg_76_1.time_ and arg_76_1.time_ <= var_79_7 + arg_79_0 then
				arg_76_1.var_.moveOldPos1084ui_story = var_79_6.localPosition
			end

			local var_79_8 = 0.001

			if var_79_7 <= arg_76_1.time_ and arg_76_1.time_ < var_79_7 + var_79_8 then
				local var_79_9 = (arg_76_1.time_ - var_79_7) / var_79_8
				local var_79_10 = Vector3.New(0, 100, 0)

				var_79_6.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1084ui_story, var_79_10, var_79_9)

				local var_79_11 = manager.ui.mainCamera.transform.position - var_79_6.position

				var_79_6.forward = Vector3.New(var_79_11.x, var_79_11.y, var_79_11.z)

				local var_79_12 = var_79_6.localEulerAngles

				var_79_12.z = 0
				var_79_12.x = 0
				var_79_6.localEulerAngles = var_79_12
			end

			if arg_76_1.time_ >= var_79_7 + var_79_8 and arg_76_1.time_ < var_79_7 + var_79_8 + arg_79_0 then
				var_79_6.localPosition = Vector3.New(0, 100, 0)

				local var_79_13 = manager.ui.mainCamera.transform.position - var_79_6.position

				var_79_6.forward = Vector3.New(var_79_13.x, var_79_13.y, var_79_13.z)

				local var_79_14 = var_79_6.localEulerAngles

				var_79_14.z = 0
				var_79_14.x = 0
				var_79_6.localEulerAngles = var_79_14
			end

			local var_79_15 = arg_76_1.actors_["10002ui_story"].transform
			local var_79_16 = 0

			if var_79_16 < arg_76_1.time_ and arg_76_1.time_ <= var_79_16 + arg_79_0 then
				arg_76_1.var_.moveOldPos10002ui_story = var_79_15.localPosition
			end

			local var_79_17 = 0.001

			if var_79_16 <= arg_76_1.time_ and arg_76_1.time_ < var_79_16 + var_79_17 then
				local var_79_18 = (arg_76_1.time_ - var_79_16) / var_79_17
				local var_79_19 = Vector3.New(0.7, -1.2, -5.8)

				var_79_15.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10002ui_story, var_79_19, var_79_18)

				local var_79_20 = manager.ui.mainCamera.transform.position - var_79_15.position

				var_79_15.forward = Vector3.New(var_79_20.x, var_79_20.y, var_79_20.z)

				local var_79_21 = var_79_15.localEulerAngles

				var_79_21.z = 0
				var_79_21.x = 0
				var_79_15.localEulerAngles = var_79_21
			end

			if arg_76_1.time_ >= var_79_16 + var_79_17 and arg_76_1.time_ < var_79_16 + var_79_17 + arg_79_0 then
				var_79_15.localPosition = Vector3.New(0.7, -1.2, -5.8)

				local var_79_22 = manager.ui.mainCamera.transform.position - var_79_15.position

				var_79_15.forward = Vector3.New(var_79_22.x, var_79_22.y, var_79_22.z)

				local var_79_23 = var_79_15.localEulerAngles

				var_79_23.z = 0
				var_79_23.x = 0
				var_79_15.localEulerAngles = var_79_23
			end

			local var_79_24 = arg_76_1.actors_["10002ui_story"].transform
			local var_79_25 = 0.033

			if var_79_25 < arg_76_1.time_ and arg_76_1.time_ <= var_79_25 + arg_79_0 then
				arg_76_1.var_.moveOldPos10002ui_story = var_79_24.localPosition
			end

			local var_79_26 = 0.5

			if var_79_25 <= arg_76_1.time_ and arg_76_1.time_ < var_79_25 + var_79_26 then
				local var_79_27 = (arg_76_1.time_ - var_79_25) / var_79_26
				local var_79_28 = Vector3.New(0, -1.2, -5.8)

				var_79_24.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos10002ui_story, var_79_28, var_79_27)

				local var_79_29 = manager.ui.mainCamera.transform.position - var_79_24.position

				var_79_24.forward = Vector3.New(var_79_29.x, var_79_29.y, var_79_29.z)

				local var_79_30 = var_79_24.localEulerAngles

				var_79_30.z = 0
				var_79_30.x = 0
				var_79_24.localEulerAngles = var_79_30
			end

			if arg_76_1.time_ >= var_79_25 + var_79_26 and arg_76_1.time_ < var_79_25 + var_79_26 + arg_79_0 then
				var_79_24.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_79_31 = manager.ui.mainCamera.transform.position - var_79_24.position

				var_79_24.forward = Vector3.New(var_79_31.x, var_79_31.y, var_79_31.z)

				local var_79_32 = var_79_24.localEulerAngles

				var_79_32.z = 0
				var_79_32.x = 0
				var_79_24.localEulerAngles = var_79_32
			end

			local var_79_33 = 0

			if var_79_33 < arg_76_1.time_ and arg_76_1.time_ <= var_79_33 + arg_79_0 then
				arg_76_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_2")
			end

			local var_79_34 = 0
			local var_79_35 = 0.875

			if var_79_34 < arg_76_1.time_ and arg_76_1.time_ <= var_79_34 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_36 = arg_76_1:FormatText(StoryNameCfg[48].name)

				arg_76_1.leftNameTxt_.text = var_79_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_37 = arg_76_1:GetWordFromCfg(102101019)
				local var_79_38 = arg_76_1:FormatText(var_79_37.content)

				arg_76_1.text_.text = var_79_38

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_39 = 35
				local var_79_40 = utf8.len(var_79_38)
				local var_79_41 = var_79_39 <= 0 and var_79_35 or var_79_35 * (var_79_40 / var_79_39)

				if var_79_41 > 0 and var_79_35 < var_79_41 then
					arg_76_1.talkMaxDuration = var_79_41

					if var_79_41 + var_79_34 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_41 + var_79_34
					end
				end

				arg_76_1.text_.text = var_79_38
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_42 = math.max(var_79_35, arg_76_1.talkMaxDuration)

			if var_79_34 <= arg_76_1.time_ and arg_76_1.time_ < var_79_34 + var_79_42 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_34) / var_79_42

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_34 + var_79_42 and arg_76_1.time_ < var_79_34 + var_79_42 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0.033,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play102101020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 102101020
		arg_80_1.duration_ = 15.4

		local var_80_0 = {
			ja = 6.6,
			ko = 11,
			zh = 11.566,
			en = 15.4
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play102101021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10002ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10002ui_story == nil then
				arg_80_1.var_.characterEffect10002ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect10002ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10002ui_story then
				arg_80_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_83_4 = 0

			if var_83_4 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			local var_83_5 = 0

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_83_6 = 0
			local var_83_7 = 1.2

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_8 = arg_80_1:FormatText(StoryNameCfg[39].name)

				arg_80_1.leftNameTxt_.text = var_83_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_9 = arg_80_1:GetWordFromCfg(102101020)
				local var_83_10 = arg_80_1:FormatText(var_83_9.content)

				arg_80_1.text_.text = var_83_10

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 46
				local var_83_12 = utf8.len(var_83_10)
				local var_83_13 = var_83_11 <= 0 and var_83_7 or var_83_7 * (var_83_12 / var_83_11)

				if var_83_13 > 0 and var_83_7 < var_83_13 then
					arg_80_1.talkMaxDuration = var_83_13

					if var_83_13 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_13 + var_83_6
					end
				end

				arg_80_1.text_.text = var_83_10
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101020", "story_v_out_102101.awb") ~= 0 then
					local var_83_14 = manager.audio:GetVoiceLength("story_v_out_102101", "102101020", "story_v_out_102101.awb") / 1000

					if var_83_14 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_14 + var_83_6
					end

					if var_83_9.prefab_name ~= "" and arg_80_1.actors_[var_83_9.prefab_name] ~= nil then
						local var_83_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_9.prefab_name].transform, "story_v_out_102101", "102101020", "story_v_out_102101.awb")

						arg_80_1:RecordAudio("102101020", var_83_15)
						arg_80_1:RecordAudio("102101020", var_83_15)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_102101", "102101020", "story_v_out_102101.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_102101", "102101020", "story_v_out_102101.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_16 = math.max(var_83_7, arg_80_1.talkMaxDuration)

			if var_83_6 <= arg_80_1.time_ and arg_80_1.time_ < var_83_6 + var_83_16 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_6) / var_83_16

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_6 + var_83_16 and arg_80_1.time_ < var_83_6 + var_83_16 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play102101021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 102101021
		arg_84_1.duration_ = 6.03

		local var_84_0 = {
			ja = 6.033,
			ko = 5.033,
			zh = 4.766,
			en = 4.266
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play102101022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0

			if var_87_0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_2")
			end

			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_87_2 = 0
			local var_87_3 = 0.55

			if var_87_2 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_4 = arg_84_1:FormatText(StoryNameCfg[39].name)

				arg_84_1.leftNameTxt_.text = var_87_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_5 = arg_84_1:GetWordFromCfg(102101021)
				local var_87_6 = arg_84_1:FormatText(var_87_5.content)

				arg_84_1.text_.text = var_87_6

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 23
				local var_87_8 = utf8.len(var_87_6)
				local var_87_9 = var_87_7 <= 0 and var_87_3 or var_87_3 * (var_87_8 / var_87_7)

				if var_87_9 > 0 and var_87_3 < var_87_9 then
					arg_84_1.talkMaxDuration = var_87_9

					if var_87_9 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_9 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_6
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101021", "story_v_out_102101.awb") ~= 0 then
					local var_87_10 = manager.audio:GetVoiceLength("story_v_out_102101", "102101021", "story_v_out_102101.awb") / 1000

					if var_87_10 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_10 + var_87_2
					end

					if var_87_5.prefab_name ~= "" and arg_84_1.actors_[var_87_5.prefab_name] ~= nil then
						local var_87_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_5.prefab_name].transform, "story_v_out_102101", "102101021", "story_v_out_102101.awb")

						arg_84_1:RecordAudio("102101021", var_87_11)
						arg_84_1:RecordAudio("102101021", var_87_11)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_102101", "102101021", "story_v_out_102101.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_102101", "102101021", "story_v_out_102101.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_12 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_12 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_12

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_12 and arg_84_1.time_ < var_87_2 + var_87_12 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play102101022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 102101022
		arg_88_1.duration_ = 2.6

		local var_88_0 = {
			ja = 2.4,
			ko = 2.2,
			zh = 2.6,
			en = 1.999999999999
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play102101023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1084ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1084ui_story == nil then
				arg_88_1.var_.characterEffect1084ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1084ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1084ui_story then
				arg_88_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_91_4 = arg_88_1.actors_["10002ui_story"]
			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect10002ui_story == nil then
				arg_88_1.var_.characterEffect10002ui_story = var_91_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_6 = 0.1

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_6 and not isNil(var_91_4) then
				local var_91_7 = (arg_88_1.time_ - var_91_5) / var_91_6

				if arg_88_1.var_.characterEffect10002ui_story and not isNil(var_91_4) then
					local var_91_8 = Mathf.Lerp(0, 0.5, var_91_7)

					arg_88_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_88_1.var_.characterEffect10002ui_story.fillRatio = var_91_8
				end
			end

			if arg_88_1.time_ >= var_91_5 + var_91_6 and arg_88_1.time_ < var_91_5 + var_91_6 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect10002ui_story then
				local var_91_9 = 0.5

				arg_88_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_88_1.var_.characterEffect10002ui_story.fillRatio = var_91_9
			end

			local var_91_10 = arg_88_1.actors_["10002ui_story"].transform
			local var_91_11 = 0

			if var_91_11 < arg_88_1.time_ and arg_88_1.time_ <= var_91_11 + arg_91_0 then
				arg_88_1.var_.moveOldPos10002ui_story = var_91_10.localPosition
			end

			local var_91_12 = 0.001

			if var_91_11 <= arg_88_1.time_ and arg_88_1.time_ < var_91_11 + var_91_12 then
				local var_91_13 = (arg_88_1.time_ - var_91_11) / var_91_12
				local var_91_14 = Vector3.New(0, 100, 0)

				var_91_10.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10002ui_story, var_91_14, var_91_13)

				local var_91_15 = manager.ui.mainCamera.transform.position - var_91_10.position

				var_91_10.forward = Vector3.New(var_91_15.x, var_91_15.y, var_91_15.z)

				local var_91_16 = var_91_10.localEulerAngles

				var_91_16.z = 0
				var_91_16.x = 0
				var_91_10.localEulerAngles = var_91_16
			end

			if arg_88_1.time_ >= var_91_11 + var_91_12 and arg_88_1.time_ < var_91_11 + var_91_12 + arg_91_0 then
				var_91_10.localPosition = Vector3.New(0, 100, 0)

				local var_91_17 = manager.ui.mainCamera.transform.position - var_91_10.position

				var_91_10.forward = Vector3.New(var_91_17.x, var_91_17.y, var_91_17.z)

				local var_91_18 = var_91_10.localEulerAngles

				var_91_18.z = 0
				var_91_18.x = 0
				var_91_10.localEulerAngles = var_91_18
			end

			local var_91_19 = arg_88_1.actors_["1084ui_story"].transform
			local var_91_20 = 0

			if var_91_20 < arg_88_1.time_ and arg_88_1.time_ <= var_91_20 + arg_91_0 then
				arg_88_1.var_.moveOldPos1084ui_story = var_91_19.localPosition
			end

			local var_91_21 = 0.001

			if var_91_20 <= arg_88_1.time_ and arg_88_1.time_ < var_91_20 + var_91_21 then
				local var_91_22 = (arg_88_1.time_ - var_91_20) / var_91_21
				local var_91_23 = Vector3.New(0, -0.97, -6)

				var_91_19.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1084ui_story, var_91_23, var_91_22)

				local var_91_24 = manager.ui.mainCamera.transform.position - var_91_19.position

				var_91_19.forward = Vector3.New(var_91_24.x, var_91_24.y, var_91_24.z)

				local var_91_25 = var_91_19.localEulerAngles

				var_91_25.z = 0
				var_91_25.x = 0
				var_91_19.localEulerAngles = var_91_25
			end

			if arg_88_1.time_ >= var_91_20 + var_91_21 and arg_88_1.time_ < var_91_20 + var_91_21 + arg_91_0 then
				var_91_19.localPosition = Vector3.New(0, -0.97, -6)

				local var_91_26 = manager.ui.mainCamera.transform.position - var_91_19.position

				var_91_19.forward = Vector3.New(var_91_26.x, var_91_26.y, var_91_26.z)

				local var_91_27 = var_91_19.localEulerAngles

				var_91_27.z = 0
				var_91_27.x = 0
				var_91_19.localEulerAngles = var_91_27
			end

			local var_91_28 = 0

			if var_91_28 < arg_88_1.time_ and arg_88_1.time_ <= var_91_28 + arg_91_0 then
				arg_88_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_91_29 = 0

			if var_91_29 < arg_88_1.time_ and arg_88_1.time_ <= var_91_29 + arg_91_0 then
				arg_88_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_91_30 = 0
			local var_91_31 = 0.15

			if var_91_30 < arg_88_1.time_ and arg_88_1.time_ <= var_91_30 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_32 = arg_88_1:FormatText(StoryNameCfg[6].name)

				arg_88_1.leftNameTxt_.text = var_91_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_33 = arg_88_1:GetWordFromCfg(102101022)
				local var_91_34 = arg_88_1:FormatText(var_91_33.content)

				arg_88_1.text_.text = var_91_34

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_35 = 6
				local var_91_36 = utf8.len(var_91_34)
				local var_91_37 = var_91_35 <= 0 and var_91_31 or var_91_31 * (var_91_36 / var_91_35)

				if var_91_37 > 0 and var_91_31 < var_91_37 then
					arg_88_1.talkMaxDuration = var_91_37

					if var_91_37 + var_91_30 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_37 + var_91_30
					end
				end

				arg_88_1.text_.text = var_91_34
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101022", "story_v_out_102101.awb") ~= 0 then
					local var_91_38 = manager.audio:GetVoiceLength("story_v_out_102101", "102101022", "story_v_out_102101.awb") / 1000

					if var_91_38 + var_91_30 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_38 + var_91_30
					end

					if var_91_33.prefab_name ~= "" and arg_88_1.actors_[var_91_33.prefab_name] ~= nil then
						local var_91_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_33.prefab_name].transform, "story_v_out_102101", "102101022", "story_v_out_102101.awb")

						arg_88_1:RecordAudio("102101022", var_91_39)
						arg_88_1:RecordAudio("102101022", var_91_39)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_102101", "102101022", "story_v_out_102101.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_102101", "102101022", "story_v_out_102101.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_40 = math.max(var_91_31, arg_88_1.talkMaxDuration)

			if var_91_30 <= arg_88_1.time_ and arg_88_1.time_ < var_91_30 + var_91_40 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_30) / var_91_40

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_30 + var_91_40 and arg_88_1.time_ < var_91_30 + var_91_40 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_88_1:InitPlayNodeList()
	end,
	Play102101023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 102101023
		arg_92_1.duration_ = 16.27

		local var_92_0 = {
			ja = 14.3,
			ko = 16.266,
			zh = 12,
			en = 11.3
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play102101024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10002ui_story"]
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect10002ui_story == nil then
				arg_92_1.var_.characterEffect10002ui_story = var_95_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_2 = 0.1

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 and not isNil(var_95_0) then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2

				if arg_92_1.var_.characterEffect10002ui_story and not isNil(var_95_0) then
					arg_92_1.var_.characterEffect10002ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 and not isNil(var_95_0) and arg_92_1.var_.characterEffect10002ui_story then
				arg_92_1.var_.characterEffect10002ui_story.fillFlat = false
			end

			local var_95_4 = arg_92_1.actors_["1084ui_story"]
			local var_95_5 = 0

			if var_95_5 < arg_92_1.time_ and arg_92_1.time_ <= var_95_5 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1084ui_story == nil then
				arg_92_1.var_.characterEffect1084ui_story = var_95_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_6 = 0.1

			if var_95_5 <= arg_92_1.time_ and arg_92_1.time_ < var_95_5 + var_95_6 and not isNil(var_95_4) then
				local var_95_7 = (arg_92_1.time_ - var_95_5) / var_95_6

				if arg_92_1.var_.characterEffect1084ui_story and not isNil(var_95_4) then
					local var_95_8 = Mathf.Lerp(0, 0.5, var_95_7)

					arg_92_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1084ui_story.fillRatio = var_95_8
				end
			end

			if arg_92_1.time_ >= var_95_5 + var_95_6 and arg_92_1.time_ < var_95_5 + var_95_6 + arg_95_0 and not isNil(var_95_4) and arg_92_1.var_.characterEffect1084ui_story then
				local var_95_9 = 0.5

				arg_92_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1084ui_story.fillRatio = var_95_9
			end

			local var_95_10 = arg_92_1.actors_["1084ui_story"].transform
			local var_95_11 = 0

			if var_95_11 < arg_92_1.time_ and arg_92_1.time_ <= var_95_11 + arg_95_0 then
				arg_92_1.var_.moveOldPos1084ui_story = var_95_10.localPosition
			end

			local var_95_12 = 0.001

			if var_95_11 <= arg_92_1.time_ and arg_92_1.time_ < var_95_11 + var_95_12 then
				local var_95_13 = (arg_92_1.time_ - var_95_11) / var_95_12
				local var_95_14 = Vector3.New(0, 100, 0)

				var_95_10.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1084ui_story, var_95_14, var_95_13)

				local var_95_15 = manager.ui.mainCamera.transform.position - var_95_10.position

				var_95_10.forward = Vector3.New(var_95_15.x, var_95_15.y, var_95_15.z)

				local var_95_16 = var_95_10.localEulerAngles

				var_95_16.z = 0
				var_95_16.x = 0
				var_95_10.localEulerAngles = var_95_16
			end

			if arg_92_1.time_ >= var_95_11 + var_95_12 and arg_92_1.time_ < var_95_11 + var_95_12 + arg_95_0 then
				var_95_10.localPosition = Vector3.New(0, 100, 0)

				local var_95_17 = manager.ui.mainCamera.transform.position - var_95_10.position

				var_95_10.forward = Vector3.New(var_95_17.x, var_95_17.y, var_95_17.z)

				local var_95_18 = var_95_10.localEulerAngles

				var_95_18.z = 0
				var_95_18.x = 0
				var_95_10.localEulerAngles = var_95_18
			end

			local var_95_19 = arg_92_1.actors_["10002ui_story"].transform
			local var_95_20 = 0

			if var_95_20 < arg_92_1.time_ and arg_92_1.time_ <= var_95_20 + arg_95_0 then
				arg_92_1.var_.moveOldPos10002ui_story = var_95_19.localPosition
			end

			local var_95_21 = 0.001

			if var_95_20 <= arg_92_1.time_ and arg_92_1.time_ < var_95_20 + var_95_21 then
				local var_95_22 = (arg_92_1.time_ - var_95_20) / var_95_21
				local var_95_23 = Vector3.New(0, -1.2, -5.8)

				var_95_19.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10002ui_story, var_95_23, var_95_22)

				local var_95_24 = manager.ui.mainCamera.transform.position - var_95_19.position

				var_95_19.forward = Vector3.New(var_95_24.x, var_95_24.y, var_95_24.z)

				local var_95_25 = var_95_19.localEulerAngles

				var_95_25.z = 0
				var_95_25.x = 0
				var_95_19.localEulerAngles = var_95_25
			end

			if arg_92_1.time_ >= var_95_20 + var_95_21 and arg_92_1.time_ < var_95_20 + var_95_21 + arg_95_0 then
				var_95_19.localPosition = Vector3.New(0, -1.2, -5.8)

				local var_95_26 = manager.ui.mainCamera.transform.position - var_95_19.position

				var_95_19.forward = Vector3.New(var_95_26.x, var_95_26.y, var_95_26.z)

				local var_95_27 = var_95_19.localEulerAngles

				var_95_27.z = 0
				var_95_27.x = 0
				var_95_19.localEulerAngles = var_95_27
			end

			local var_95_28 = 0

			if var_95_28 < arg_92_1.time_ and arg_92_1.time_ <= var_95_28 + arg_95_0 then
				arg_92_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/story10002/story10002action/10002action3_1")
			end

			local var_95_29 = 0

			if var_95_29 < arg_92_1.time_ and arg_92_1.time_ <= var_95_29 + arg_95_0 then
				arg_92_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_95_30 = 0

			if var_95_30 < arg_92_1.time_ and arg_92_1.time_ <= var_95_30 + arg_95_0 then
				arg_92_1:PlayTimeline("10002ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_95_31 = 0
			local var_95_32 = 1.25

			if var_95_31 < arg_92_1.time_ and arg_92_1.time_ <= var_95_31 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_33 = arg_92_1:FormatText(StoryNameCfg[39].name)

				arg_92_1.leftNameTxt_.text = var_95_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_34 = arg_92_1:GetWordFromCfg(102101023)
				local var_95_35 = arg_92_1:FormatText(var_95_34.content)

				arg_92_1.text_.text = var_95_35

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_36 = 49
				local var_95_37 = utf8.len(var_95_35)
				local var_95_38 = var_95_36 <= 0 and var_95_32 or var_95_32 * (var_95_37 / var_95_36)

				if var_95_38 > 0 and var_95_32 < var_95_38 then
					arg_92_1.talkMaxDuration = var_95_38

					if var_95_38 + var_95_31 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_38 + var_95_31
					end
				end

				arg_92_1.text_.text = var_95_35
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101023", "story_v_out_102101.awb") ~= 0 then
					local var_95_39 = manager.audio:GetVoiceLength("story_v_out_102101", "102101023", "story_v_out_102101.awb") / 1000

					if var_95_39 + var_95_31 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_39 + var_95_31
					end

					if var_95_34.prefab_name ~= "" and arg_92_1.actors_[var_95_34.prefab_name] ~= nil then
						local var_95_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_34.prefab_name].transform, "story_v_out_102101", "102101023", "story_v_out_102101.awb")

						arg_92_1:RecordAudio("102101023", var_95_40)
						arg_92_1:RecordAudio("102101023", var_95_40)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_102101", "102101023", "story_v_out_102101.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_102101", "102101023", "story_v_out_102101.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_41 = math.max(var_95_32, arg_92_1.talkMaxDuration)

			if var_95_31 <= arg_92_1.time_ and arg_92_1.time_ < var_95_31 + var_95_41 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_31) / var_95_41

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_31 + var_95_41 and arg_92_1.time_ < var_95_31 + var_95_41 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play102101024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 102101024
		arg_96_1.duration_ = 1.27

		local var_96_0 = {
			ja = 1.166,
			ko = 0.999999999999,
			zh = 1.266,
			en = 1
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play102101025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1019ui_story"]
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1019ui_story == nil then
				arg_96_1.var_.characterEffect1019ui_story = var_99_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.1

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 and not isNil(var_99_0) then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2

				if arg_96_1.var_.characterEffect1019ui_story and not isNil(var_99_0) then
					arg_96_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 and not isNil(var_99_0) and arg_96_1.var_.characterEffect1019ui_story then
				arg_96_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_99_4 = arg_96_1.actors_["10002ui_story"]
			local var_99_5 = 0

			if var_99_5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_5 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect10002ui_story == nil then
				arg_96_1.var_.characterEffect10002ui_story = var_99_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_6 = 0.1

			if var_99_5 <= arg_96_1.time_ and arg_96_1.time_ < var_99_5 + var_99_6 and not isNil(var_99_4) then
				local var_99_7 = (arg_96_1.time_ - var_99_5) / var_99_6

				if arg_96_1.var_.characterEffect10002ui_story and not isNil(var_99_4) then
					local var_99_8 = Mathf.Lerp(0, 0.5, var_99_7)

					arg_96_1.var_.characterEffect10002ui_story.fillFlat = true
					arg_96_1.var_.characterEffect10002ui_story.fillRatio = var_99_8
				end
			end

			if arg_96_1.time_ >= var_99_5 + var_99_6 and arg_96_1.time_ < var_99_5 + var_99_6 + arg_99_0 and not isNil(var_99_4) and arg_96_1.var_.characterEffect10002ui_story then
				local var_99_9 = 0.5

				arg_96_1.var_.characterEffect10002ui_story.fillFlat = true
				arg_96_1.var_.characterEffect10002ui_story.fillRatio = var_99_9
			end

			local var_99_10 = arg_96_1.actors_["10002ui_story"].transform
			local var_99_11 = 0

			if var_99_11 < arg_96_1.time_ and arg_96_1.time_ <= var_99_11 + arg_99_0 then
				arg_96_1.var_.moveOldPos10002ui_story = var_99_10.localPosition
			end

			local var_99_12 = 0.001

			if var_99_11 <= arg_96_1.time_ and arg_96_1.time_ < var_99_11 + var_99_12 then
				local var_99_13 = (arg_96_1.time_ - var_99_11) / var_99_12
				local var_99_14 = Vector3.New(0, 100, 0)

				var_99_10.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10002ui_story, var_99_14, var_99_13)

				local var_99_15 = manager.ui.mainCamera.transform.position - var_99_10.position

				var_99_10.forward = Vector3.New(var_99_15.x, var_99_15.y, var_99_15.z)

				local var_99_16 = var_99_10.localEulerAngles

				var_99_16.z = 0
				var_99_16.x = 0
				var_99_10.localEulerAngles = var_99_16
			end

			if arg_96_1.time_ >= var_99_11 + var_99_12 and arg_96_1.time_ < var_99_11 + var_99_12 + arg_99_0 then
				var_99_10.localPosition = Vector3.New(0, 100, 0)

				local var_99_17 = manager.ui.mainCamera.transform.position - var_99_10.position

				var_99_10.forward = Vector3.New(var_99_17.x, var_99_17.y, var_99_17.z)

				local var_99_18 = var_99_10.localEulerAngles

				var_99_18.z = 0
				var_99_18.x = 0
				var_99_10.localEulerAngles = var_99_18
			end

			local var_99_19 = arg_96_1.actors_["1019ui_story"].transform
			local var_99_20 = 0

			if var_99_20 < arg_96_1.time_ and arg_96_1.time_ <= var_99_20 + arg_99_0 then
				arg_96_1.var_.moveOldPos1019ui_story = var_99_19.localPosition
			end

			local var_99_21 = 0.001

			if var_99_20 <= arg_96_1.time_ and arg_96_1.time_ < var_99_20 + var_99_21 then
				local var_99_22 = (arg_96_1.time_ - var_99_20) / var_99_21
				local var_99_23 = Vector3.New(-0.2, -1.08, -5.9)

				var_99_19.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1019ui_story, var_99_23, var_99_22)

				local var_99_24 = manager.ui.mainCamera.transform.position - var_99_19.position

				var_99_19.forward = Vector3.New(var_99_24.x, var_99_24.y, var_99_24.z)

				local var_99_25 = var_99_19.localEulerAngles

				var_99_25.z = 0
				var_99_25.x = 0
				var_99_19.localEulerAngles = var_99_25
			end

			if arg_96_1.time_ >= var_99_20 + var_99_21 and arg_96_1.time_ < var_99_20 + var_99_21 + arg_99_0 then
				var_99_19.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_99_26 = manager.ui.mainCamera.transform.position - var_99_19.position

				var_99_19.forward = Vector3.New(var_99_26.x, var_99_26.y, var_99_26.z)

				local var_99_27 = var_99_19.localEulerAngles

				var_99_27.z = 0
				var_99_27.x = 0
				var_99_19.localEulerAngles = var_99_27
			end

			local var_99_28 = 0

			if var_99_28 < arg_96_1.time_ and arg_96_1.time_ <= var_99_28 + arg_99_0 then
				arg_96_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_99_29 = 0
			local var_99_30 = 0.05

			if var_99_29 < arg_96_1.time_ and arg_96_1.time_ <= var_99_29 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_31 = arg_96_1:FormatText(StoryNameCfg[13].name)

				arg_96_1.leftNameTxt_.text = var_99_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_32 = arg_96_1:GetWordFromCfg(102101024)
				local var_99_33 = arg_96_1:FormatText(var_99_32.content)

				arg_96_1.text_.text = var_99_33

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_34 = 2
				local var_99_35 = utf8.len(var_99_33)
				local var_99_36 = var_99_34 <= 0 and var_99_30 or var_99_30 * (var_99_35 / var_99_34)

				if var_99_36 > 0 and var_99_30 < var_99_36 then
					arg_96_1.talkMaxDuration = var_99_36

					if var_99_36 + var_99_29 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_36 + var_99_29
					end
				end

				arg_96_1.text_.text = var_99_33
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101024", "story_v_out_102101.awb") ~= 0 then
					local var_99_37 = manager.audio:GetVoiceLength("story_v_out_102101", "102101024", "story_v_out_102101.awb") / 1000

					if var_99_37 + var_99_29 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_37 + var_99_29
					end

					if var_99_32.prefab_name ~= "" and arg_96_1.actors_[var_99_32.prefab_name] ~= nil then
						local var_99_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_32.prefab_name].transform, "story_v_out_102101", "102101024", "story_v_out_102101.awb")

						arg_96_1:RecordAudio("102101024", var_99_38)
						arg_96_1:RecordAudio("102101024", var_99_38)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_102101", "102101024", "story_v_out_102101.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_102101", "102101024", "story_v_out_102101.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_39 = math.max(var_99_30, arg_96_1.talkMaxDuration)

			if var_99_29 <= arg_96_1.time_ and arg_96_1.time_ < var_99_29 + var_99_39 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_29) / var_99_39

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_29 + var_99_39 and arg_96_1.time_ < var_99_29 + var_99_39 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10002ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play102101025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 102101025
		arg_100_1.duration_ = 7.67

		local var_100_0 = {
			ja = 6.6,
			ko = 7.1,
			zh = 7.666,
			en = 6.533
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
			arg_100_1.auto_ = false
		end

		function arg_100_1.playNext_(arg_102_0)
			arg_100_1.onStoryFinished_()
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_103_2 = 0
			local var_103_3 = 0.875

			if var_103_2 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_4 = arg_100_1:FormatText(StoryNameCfg[13].name)

				arg_100_1.leftNameTxt_.text = var_103_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_5 = arg_100_1:GetWordFromCfg(102101025)
				local var_103_6 = arg_100_1:FormatText(var_103_5.content)

				arg_100_1.text_.text = var_103_6

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 35
				local var_103_8 = utf8.len(var_103_6)
				local var_103_9 = var_103_7 <= 0 and var_103_3 or var_103_3 * (var_103_8 / var_103_7)

				if var_103_9 > 0 and var_103_3 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_6
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102101", "102101025", "story_v_out_102101.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_102101", "102101025", "story_v_out_102101.awb") / 1000

					if var_103_10 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_2
					end

					if var_103_5.prefab_name ~= "" and arg_100_1.actors_[var_103_5.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_5.prefab_name].transform, "story_v_out_102101", "102101025", "story_v_out_102101.awb")

						arg_100_1:RecordAudio("102101025", var_103_11)
						arg_100_1:RecordAudio("102101025", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_102101", "102101025", "story_v_out_102101.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_102101", "102101025", "story_v_out_102101.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_12 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_12 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_12

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_12 and arg_100_1.time_ < var_103_2 + var_103_12 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B02c"
	},
	voices = {
		"story_v_out_102101.awb"
	}
}
