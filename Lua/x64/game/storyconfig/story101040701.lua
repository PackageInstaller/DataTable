return {
	Play104071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104071001
		arg_1_1.duration_ = 7.03

		local var_1_0 = {
			ja = 7.033,
			ko = 5.7,
			zh = 5.833,
			en = 7.033
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
				arg_1_0:Play104071002(arg_1_1)
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

			local var_4_6 = 0
			local var_4_7 = 1

			if var_4_6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_6 + arg_4_0 then
				local var_4_8 = "play"
				local var_4_9 = "effect"

				arg_1_1:AudioAction(var_4_8, var_4_9, "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_10 = "1019ui_story"

			if arg_1_1.actors_[var_4_10] == nil then
				local var_4_11 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_4_11) then
					local var_4_12 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_1_1.stage_.transform)

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

			local var_4_15 = arg_1_1.actors_["1019ui_story"]
			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1019ui_story == nil then
				arg_1_1.var_.characterEffect1019ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_17 = 0.1

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 and not isNil(var_4_15) then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17

				if arg_1_1.var_.characterEffect1019ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1019ui_story then
				arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_4_19 = "B06a"

			if arg_1_1.bgs_[var_4_19] == nil then
				local var_4_20 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_19)
				var_4_20.name = var_4_19
				var_4_20.transform.parent = arg_1_1.stage_.transform
				var_4_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_19] = var_4_20
			end

			local var_4_21 = arg_1_1.bgs_.B06a
			local var_4_22 = 0

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_23 = var_4_21:GetComponent("SpriteRenderer")

				if var_4_23 then
					arg_1_1.var_.alphaOldValueB06a = var_4_23.color.a
					arg_1_1.var_.alphaMatValueB06a = var_4_23
				end

				arg_1_1.var_.alphaOldValueB06a = 0
			end

			local var_4_24 = 1.5

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_24 then
				local var_4_25 = (arg_1_1.time_ - var_4_22) / var_4_24
				local var_4_26 = Mathf.Lerp(arg_1_1.var_.alphaOldValueB06a, 1, var_4_25)

				if arg_1_1.var_.alphaMatValueB06a then
					local var_4_27 = arg_1_1.var_.alphaMatValueB06a.color

					var_4_27.a = var_4_26
					arg_1_1.var_.alphaMatValueB06a.color = var_4_27
				end
			end

			if arg_1_1.time_ >= var_4_22 + var_4_24 and arg_1_1.time_ < var_4_22 + var_4_24 + arg_4_0 and arg_1_1.var_.alphaMatValueB06a then
				local var_4_28 = arg_1_1.var_.alphaMatValueB06a
				local var_4_29 = var_4_28.color

				var_4_29.a = 1
				var_4_28.color = var_4_29
			end

			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				local var_4_31 = manager.ui.mainCamera.transform.localPosition
				local var_4_32 = Vector3.New(0, 0, 10) + Vector3.New(var_4_31.x, var_4_31.y, 0)
				local var_4_33 = arg_1_1.bgs_.B06a

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
					if iter_4_0 ~= "B06a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_44 = arg_1_1.actors_["1019ui_story"].transform
			local var_4_45 = 1.79999995231628

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1.var_.moveOldPos1019ui_story = var_4_44.localPosition
			end

			local var_4_46 = 0.001

			if var_4_45 <= arg_1_1.time_ and arg_1_1.time_ < var_4_45 + var_4_46 then
				local var_4_47 = (arg_1_1.time_ - var_4_45) / var_4_46
				local var_4_48 = Vector3.New(-0.7, -1.08, -5.9)

				var_4_44.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1019ui_story, var_4_48, var_4_47)

				local var_4_49 = manager.ui.mainCamera.transform.position - var_4_44.position

				var_4_44.forward = Vector3.New(var_4_49.x, var_4_49.y, var_4_49.z)

				local var_4_50 = var_4_44.localEulerAngles

				var_4_50.z = 0
				var_4_50.x = 0
				var_4_44.localEulerAngles = var_4_50
			end

			if arg_1_1.time_ >= var_4_45 + var_4_46 and arg_1_1.time_ < var_4_45 + var_4_46 + arg_4_0 then
				var_4_44.localPosition = Vector3.New(-0.7, -1.08, -5.9)

				local var_4_51 = manager.ui.mainCamera.transform.position - var_4_44.position

				var_4_44.forward = Vector3.New(var_4_51.x, var_4_51.y, var_4_51.z)

				local var_4_52 = var_4_44.localEulerAngles

				var_4_52.z = 0
				var_4_52.x = 0
				var_4_44.localEulerAngles = var_4_52
			end

			local var_4_53 = 0

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_4_54 = 0

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_55 = 2

			if arg_1_1.time_ >= var_4_54 + var_4_55 and arg_1_1.time_ < var_4_54 + var_4_55 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_56 = 2
			local var_4_57 = 0.475

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

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[13].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(104071001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071001", "story_v_out_104071.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_104071", "104071001", "story_v_out_104071.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_104071", "104071001", "story_v_out_104071.awb")

						arg_1_1:RecordAudio("104071001", var_4_66)
						arg_1_1:RecordAudio("104071001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_104071", "104071001", "story_v_out_104071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_104071", "104071001", "story_v_out_104071.awb")
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
	Play104071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104071002
		arg_8_1.duration_ = 16.67

		local var_8_0 = {
			ja = 16.666,
			ko = 15,
			zh = 13.966,
			en = 13.866
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
				arg_8_0:Play104071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "10001_tpose"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "10001_tpose")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["10001_tpose"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect10001_tpose == nil then
				arg_8_1.var_.characterEffect10001_tpose = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect10001_tpose and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect10001_tpose then
				arg_8_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["1019ui_story"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.1

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_9) then
					local var_11_13 = Mathf.Lerp(0, 0.5, var_11_12)

					arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1019ui_story.fillRatio = var_11_13
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect1019ui_story then
				local var_11_14 = 0.5

				arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1019ui_story.fillRatio = var_11_14
			end

			local var_11_15 = arg_8_1.actors_["10001_tpose"].transform
			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.var_.moveOldPos10001_tpose = var_11_15.localPosition

				local var_11_17 = GameObjectTools.GetOrAddComponent(var_11_15.gameObject, typeof(DynamicBoneHelper))

				if var_11_17 then
					var_11_17:EnableDynamicBone(false)
				end
			end

			local var_11_18 = 0.001

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_18 then
				local var_11_19 = (arg_8_1.time_ - var_11_16) / var_11_18
				local var_11_20 = Vector3.New(0.7, -1.23, -5.8)

				var_11_15.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10001_tpose, var_11_20, var_11_19)

				local var_11_21 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_21.x, var_11_21.y, var_11_21.z)

				local var_11_22 = var_11_15.localEulerAngles

				var_11_22.z = 0
				var_11_22.x = 0
				var_11_15.localEulerAngles = var_11_22
			end

			if arg_8_1.time_ >= var_11_16 + var_11_18 and arg_8_1.time_ < var_11_16 + var_11_18 + arg_11_0 then
				var_11_15.localPosition = Vector3.New(0.7, -1.23, -5.8)

				local var_11_23 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_23.x, var_11_23.y, var_11_23.z)

				local var_11_24 = var_11_15.localEulerAngles

				var_11_24.z = 0
				var_11_24.x = 0
				var_11_15.localEulerAngles = var_11_24

				local var_11_25 = GameObjectTools.GetOrAddComponent(var_11_15.gameObject, typeof(DynamicBoneHelper))

				if var_11_25 then
					var_11_25:EnableDynamicBone(true)
				end
			end

			local var_11_26 = 0

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				arg_8_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action2_1")
			end

			local var_11_27 = 0

			if var_11_27 < arg_8_1.time_ and arg_8_1.time_ <= var_11_27 + arg_11_0 then
				arg_8_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_11_28 = 0
			local var_11_29 = 1.7

			if var_11_28 < arg_8_1.time_ and arg_8_1.time_ <= var_11_28 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_30 = arg_8_1:FormatText(StoryNameCfg[31].name)

				arg_8_1.leftNameTxt_.text = var_11_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_31 = arg_8_1:GetWordFromCfg(104071002)
				local var_11_32 = arg_8_1:FormatText(var_11_31.content)

				arg_8_1.text_.text = var_11_32

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_33 = 68
				local var_11_34 = utf8.len(var_11_32)
				local var_11_35 = var_11_33 <= 0 and var_11_29 or var_11_29 * (var_11_34 / var_11_33)

				if var_11_35 > 0 and var_11_29 < var_11_35 then
					arg_8_1.talkMaxDuration = var_11_35

					if var_11_35 + var_11_28 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_35 + var_11_28
					end
				end

				arg_8_1.text_.text = var_11_32
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071002", "story_v_out_104071.awb") ~= 0 then
					local var_11_36 = manager.audio:GetVoiceLength("story_v_out_104071", "104071002", "story_v_out_104071.awb") / 1000

					if var_11_36 + var_11_28 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_36 + var_11_28
					end

					if var_11_31.prefab_name ~= "" and arg_8_1.actors_[var_11_31.prefab_name] ~= nil then
						local var_11_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_31.prefab_name].transform, "story_v_out_104071", "104071002", "story_v_out_104071.awb")

						arg_8_1:RecordAudio("104071002", var_11_37)
						arg_8_1:RecordAudio("104071002", var_11_37)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104071", "104071002", "story_v_out_104071.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104071", "104071002", "story_v_out_104071.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_38 = math.max(var_11_29, arg_8_1.talkMaxDuration)

			if var_11_28 <= arg_8_1.time_ and arg_8_1.time_ < var_11_28 + var_11_38 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_28) / var_11_38

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_28 + var_11_38 and arg_8_1.time_ < var_11_28 + var_11_38 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
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
	Play104071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104071003
		arg_12_1.duration_ = 8.47

		local var_12_0 = {
			ja = 8.366,
			ko = 8.466,
			zh = 8.066,
			en = 8.033
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
				arg_12_0:Play104071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0

			if var_15_0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action425")
			end

			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_15_2 = 0
			local var_15_3 = 1

			if var_15_2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_4 = arg_12_1:FormatText(StoryNameCfg[31].name)

				arg_12_1.leftNameTxt_.text = var_15_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_5 = arg_12_1:GetWordFromCfg(104071003)
				local var_15_6 = arg_12_1:FormatText(var_15_5.content)

				arg_12_1.text_.text = var_15_6

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_7 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071003", "story_v_out_104071.awb") ~= 0 then
					local var_15_10 = manager.audio:GetVoiceLength("story_v_out_104071", "104071003", "story_v_out_104071.awb") / 1000

					if var_15_10 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_10 + var_15_2
					end

					if var_15_5.prefab_name ~= "" and arg_12_1.actors_[var_15_5.prefab_name] ~= nil then
						local var_15_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_5.prefab_name].transform, "story_v_out_104071", "104071003", "story_v_out_104071.awb")

						arg_12_1:RecordAudio("104071003", var_15_11)
						arg_12_1:RecordAudio("104071003", var_15_11)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104071", "104071003", "story_v_out_104071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104071", "104071003", "story_v_out_104071.awb")
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
	Play104071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104071004
		arg_16_1.duration_ = 7.6

		local var_16_0 = {
			ja = 7.6,
			ko = 6.6,
			zh = 4.933,
			en = 4.533
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
				arg_16_0:Play104071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1084ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["1084ui_story"]
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 and not isNil(var_19_5) then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_19_9 = arg_16_1.actors_["10001_tpose"]
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect10001_tpose == nil then
				arg_16_1.var_.characterEffect10001_tpose = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_11 = 0.1

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 and not isNil(var_19_9) then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11

				if arg_16_1.var_.characterEffect10001_tpose and not isNil(var_19_9) then
					local var_19_13 = Mathf.Lerp(0, 0.5, var_19_12)

					arg_16_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_16_1.var_.characterEffect10001_tpose.fillRatio = var_19_13
				end
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect10001_tpose then
				local var_19_14 = 0.5

				arg_16_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_16_1.var_.characterEffect10001_tpose.fillRatio = var_19_14
			end

			local var_19_15 = arg_16_1.actors_["10001_tpose"].transform
			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.var_.moveOldPos10001_tpose = var_19_15.localPosition

				local var_19_17 = GameObjectTools.GetOrAddComponent(var_19_15.gameObject, typeof(DynamicBoneHelper))

				if var_19_17 then
					var_19_17:EnableDynamicBone(false)
				end
			end

			local var_19_18 = 0.001

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_18 then
				local var_19_19 = (arg_16_1.time_ - var_19_16) / var_19_18
				local var_19_20 = Vector3.New(0, 100, 0)

				var_19_15.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10001_tpose, var_19_20, var_19_19)

				local var_19_21 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_21.x, var_19_21.y, var_19_21.z)

				local var_19_22 = var_19_15.localEulerAngles

				var_19_22.z = 0
				var_19_22.x = 0
				var_19_15.localEulerAngles = var_19_22
			end

			if arg_16_1.time_ >= var_19_16 + var_19_18 and arg_16_1.time_ < var_19_16 + var_19_18 + arg_19_0 then
				var_19_15.localPosition = Vector3.New(0, 100, 0)

				local var_19_23 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_23.x, var_19_23.y, var_19_23.z)

				local var_19_24 = var_19_15.localEulerAngles

				var_19_24.z = 0
				var_19_24.x = 0
				var_19_15.localEulerAngles = var_19_24

				local var_19_25 = GameObjectTools.GetOrAddComponent(var_19_15.gameObject, typeof(DynamicBoneHelper))

				if var_19_25 then
					var_19_25:EnableDynamicBone(true)
				end
			end

			local var_19_26 = arg_16_1.actors_["1019ui_story"].transform
			local var_19_27 = 0

			if var_19_27 < arg_16_1.time_ and arg_16_1.time_ <= var_19_27 + arg_19_0 then
				arg_16_1.var_.moveOldPos1019ui_story = var_19_26.localPosition
			end

			local var_19_28 = 0.001

			if var_19_27 <= arg_16_1.time_ and arg_16_1.time_ < var_19_27 + var_19_28 then
				local var_19_29 = (arg_16_1.time_ - var_19_27) / var_19_28
				local var_19_30 = Vector3.New(0, 100, 0)

				var_19_26.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1019ui_story, var_19_30, var_19_29)

				local var_19_31 = manager.ui.mainCamera.transform.position - var_19_26.position

				var_19_26.forward = Vector3.New(var_19_31.x, var_19_31.y, var_19_31.z)

				local var_19_32 = var_19_26.localEulerAngles

				var_19_32.z = 0
				var_19_32.x = 0
				var_19_26.localEulerAngles = var_19_32
			end

			if arg_16_1.time_ >= var_19_27 + var_19_28 and arg_16_1.time_ < var_19_27 + var_19_28 + arg_19_0 then
				var_19_26.localPosition = Vector3.New(0, 100, 0)

				local var_19_33 = manager.ui.mainCamera.transform.position - var_19_26.position

				var_19_26.forward = Vector3.New(var_19_33.x, var_19_33.y, var_19_33.z)

				local var_19_34 = var_19_26.localEulerAngles

				var_19_34.z = 0
				var_19_34.x = 0
				var_19_26.localEulerAngles = var_19_34
			end

			local var_19_35 = arg_16_1.actors_["1084ui_story"].transform
			local var_19_36 = 0

			if var_19_36 < arg_16_1.time_ and arg_16_1.time_ <= var_19_36 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_35.localPosition
			end

			local var_19_37 = 0.001

			if var_19_36 <= arg_16_1.time_ and arg_16_1.time_ < var_19_36 + var_19_37 then
				local var_19_38 = (arg_16_1.time_ - var_19_36) / var_19_37
				local var_19_39 = Vector3.New(0, -0.97, -6)

				var_19_35.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, var_19_39, var_19_38)

				local var_19_40 = manager.ui.mainCamera.transform.position - var_19_35.position

				var_19_35.forward = Vector3.New(var_19_40.x, var_19_40.y, var_19_40.z)

				local var_19_41 = var_19_35.localEulerAngles

				var_19_41.z = 0
				var_19_41.x = 0
				var_19_35.localEulerAngles = var_19_41
			end

			if arg_16_1.time_ >= var_19_36 + var_19_37 and arg_16_1.time_ < var_19_36 + var_19_37 + arg_19_0 then
				var_19_35.localPosition = Vector3.New(0, -0.97, -6)

				local var_19_42 = manager.ui.mainCamera.transform.position - var_19_35.position

				var_19_35.forward = Vector3.New(var_19_42.x, var_19_42.y, var_19_42.z)

				local var_19_43 = var_19_35.localEulerAngles

				var_19_43.z = 0
				var_19_43.x = 0
				var_19_35.localEulerAngles = var_19_43
			end

			local var_19_44 = 0

			if var_19_44 < arg_16_1.time_ and arg_16_1.time_ <= var_19_44 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			local var_19_45 = 0

			if var_19_45 < arg_16_1.time_ and arg_16_1.time_ <= var_19_45 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_19_46 = 0
			local var_19_47 = 0.65

			if var_19_46 < arg_16_1.time_ and arg_16_1.time_ <= var_19_46 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_48 = arg_16_1:FormatText(StoryNameCfg[6].name)

				arg_16_1.leftNameTxt_.text = var_19_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_49 = arg_16_1:GetWordFromCfg(104071004)
				local var_19_50 = arg_16_1:FormatText(var_19_49.content)

				arg_16_1.text_.text = var_19_50

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_51 = 26
				local var_19_52 = utf8.len(var_19_50)
				local var_19_53 = var_19_51 <= 0 and var_19_47 or var_19_47 * (var_19_52 / var_19_51)

				if var_19_53 > 0 and var_19_47 < var_19_53 then
					arg_16_1.talkMaxDuration = var_19_53

					if var_19_53 + var_19_46 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_53 + var_19_46
					end
				end

				arg_16_1.text_.text = var_19_50
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071004", "story_v_out_104071.awb") ~= 0 then
					local var_19_54 = manager.audio:GetVoiceLength("story_v_out_104071", "104071004", "story_v_out_104071.awb") / 1000

					if var_19_54 + var_19_46 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_54 + var_19_46
					end

					if var_19_49.prefab_name ~= "" and arg_16_1.actors_[var_19_49.prefab_name] ~= nil then
						local var_19_55 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_49.prefab_name].transform, "story_v_out_104071", "104071004", "story_v_out_104071.awb")

						arg_16_1:RecordAudio("104071004", var_19_55)
						arg_16_1:RecordAudio("104071004", var_19_55)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104071", "104071004", "story_v_out_104071.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104071", "104071004", "story_v_out_104071.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_56 = math.max(var_19_47, arg_16_1.talkMaxDuration)

			if var_19_46 <= arg_16_1.time_ and arg_16_1.time_ < var_19_46 + var_19_56 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_46) / var_19_56

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_46 + var_19_56 and arg_16_1.time_ < var_19_46 + var_19_56 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
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
				actorName = "1084ui_story",
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
	Play104071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104071005
		arg_20_1.duration_ = 3.57

		local var_20_0 = {
			ja = 3.2,
			ko = 3.1,
			zh = 3.566,
			en = 3.433
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
				arg_20_0:Play104071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1019ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect1019ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect1019ui_story then
				arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_23_4 = arg_20_1.actors_["1084ui_story"]
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = var_23_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_6 = 0.1

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 and not isNil(var_23_4) then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6

				if arg_20_1.var_.characterEffect1084ui_story and not isNil(var_23_4) then
					local var_23_8 = Mathf.Lerp(0, 0.5, var_23_7)

					arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1084ui_story.fillRatio = var_23_8
				end
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 and not isNil(var_23_4) and arg_20_1.var_.characterEffect1084ui_story then
				local var_23_9 = 0.5

				arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1084ui_story.fillRatio = var_23_9
			end

			local var_23_10 = arg_20_1.actors_["1084ui_story"].transform
			local var_23_11 = 0

			if var_23_11 < arg_20_1.time_ and arg_20_1.time_ <= var_23_11 + arg_23_0 then
				arg_20_1.var_.moveOldPos1084ui_story = var_23_10.localPosition
			end

			local var_23_12 = 0.001

			if var_23_11 <= arg_20_1.time_ and arg_20_1.time_ < var_23_11 + var_23_12 then
				local var_23_13 = (arg_20_1.time_ - var_23_11) / var_23_12
				local var_23_14 = Vector3.New(0, 100, 0)

				var_23_10.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1084ui_story, var_23_14, var_23_13)

				local var_23_15 = manager.ui.mainCamera.transform.position - var_23_10.position

				var_23_10.forward = Vector3.New(var_23_15.x, var_23_15.y, var_23_15.z)

				local var_23_16 = var_23_10.localEulerAngles

				var_23_16.z = 0
				var_23_16.x = 0
				var_23_10.localEulerAngles = var_23_16
			end

			if arg_20_1.time_ >= var_23_11 + var_23_12 and arg_20_1.time_ < var_23_11 + var_23_12 + arg_23_0 then
				var_23_10.localPosition = Vector3.New(0, 100, 0)

				local var_23_17 = manager.ui.mainCamera.transform.position - var_23_10.position

				var_23_10.forward = Vector3.New(var_23_17.x, var_23_17.y, var_23_17.z)

				local var_23_18 = var_23_10.localEulerAngles

				var_23_18.z = 0
				var_23_18.x = 0
				var_23_10.localEulerAngles = var_23_18
			end

			local var_23_19 = arg_20_1.actors_["1019ui_story"].transform
			local var_23_20 = 0

			if var_23_20 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1.var_.moveOldPos1019ui_story = var_23_19.localPosition
			end

			local var_23_21 = 0.001

			if var_23_20 <= arg_20_1.time_ and arg_20_1.time_ < var_23_20 + var_23_21 then
				local var_23_22 = (arg_20_1.time_ - var_23_20) / var_23_21
				local var_23_23 = Vector3.New(-0.2, -1.08, -5.9)

				var_23_19.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1019ui_story, var_23_23, var_23_22)

				local var_23_24 = manager.ui.mainCamera.transform.position - var_23_19.position

				var_23_19.forward = Vector3.New(var_23_24.x, var_23_24.y, var_23_24.z)

				local var_23_25 = var_23_19.localEulerAngles

				var_23_25.z = 0
				var_23_25.x = 0
				var_23_19.localEulerAngles = var_23_25
			end

			if arg_20_1.time_ >= var_23_20 + var_23_21 and arg_20_1.time_ < var_23_20 + var_23_21 + arg_23_0 then
				var_23_19.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_23_26 = manager.ui.mainCamera.transform.position - var_23_19.position

				var_23_19.forward = Vector3.New(var_23_26.x, var_23_26.y, var_23_26.z)

				local var_23_27 = var_23_19.localEulerAngles

				var_23_27.z = 0
				var_23_27.x = 0
				var_23_19.localEulerAngles = var_23_27
			end

			local var_23_28 = 0

			if var_23_28 < arg_20_1.time_ and arg_20_1.time_ <= var_23_28 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			local var_23_29 = 0

			if var_23_29 < arg_20_1.time_ and arg_20_1.time_ <= var_23_29 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_23_30 = 0
			local var_23_31 = 0.425

			if var_23_30 < arg_20_1.time_ and arg_20_1.time_ <= var_23_30 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_32 = arg_20_1:FormatText(StoryNameCfg[13].name)

				arg_20_1.leftNameTxt_.text = var_23_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_33 = arg_20_1:GetWordFromCfg(104071005)
				local var_23_34 = arg_20_1:FormatText(var_23_33.content)

				arg_20_1.text_.text = var_23_34

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_35 = 17
				local var_23_36 = utf8.len(var_23_34)
				local var_23_37 = var_23_35 <= 0 and var_23_31 or var_23_31 * (var_23_36 / var_23_35)

				if var_23_37 > 0 and var_23_31 < var_23_37 then
					arg_20_1.talkMaxDuration = var_23_37

					if var_23_37 + var_23_30 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_37 + var_23_30
					end
				end

				arg_20_1.text_.text = var_23_34
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071005", "story_v_out_104071.awb") ~= 0 then
					local var_23_38 = manager.audio:GetVoiceLength("story_v_out_104071", "104071005", "story_v_out_104071.awb") / 1000

					if var_23_38 + var_23_30 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_38 + var_23_30
					end

					if var_23_33.prefab_name ~= "" and arg_20_1.actors_[var_23_33.prefab_name] ~= nil then
						local var_23_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_33.prefab_name].transform, "story_v_out_104071", "104071005", "story_v_out_104071.awb")

						arg_20_1:RecordAudio("104071005", var_23_39)
						arg_20_1:RecordAudio("104071005", var_23_39)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104071", "104071005", "story_v_out_104071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104071", "104071005", "story_v_out_104071.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_40 = math.max(var_23_31, arg_20_1.talkMaxDuration)

			if var_23_30 <= arg_20_1.time_ and arg_20_1.time_ < var_23_30 + var_23_40 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_30) / var_23_40

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_30 + var_23_40 and arg_20_1.time_ < var_23_30 + var_23_40 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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
				actorName = "1019ui_story",
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
	Play104071006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104071006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play104071007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1019ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_0) then
					local var_27_4 = Mathf.Lerp(0, 0.5, var_27_3)

					arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1019ui_story.fillRatio = var_27_4
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1019ui_story then
				local var_27_5 = 0.5

				arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1019ui_story.fillRatio = var_27_5
			end

			local var_27_6 = 0
			local var_27_7 = 1.3

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_8 = arg_24_1:FormatText(StoryNameCfg[7].name)

				arg_24_1.leftNameTxt_.text = var_27_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_9 = arg_24_1:GetWordFromCfg(104071006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 52
				local var_27_12 = utf8.len(var_27_10)
				local var_27_13 = var_27_11 <= 0 and var_27_7 or var_27_7 * (var_27_12 / var_27_11)

				if var_27_13 > 0 and var_27_7 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_10
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_14 and arg_24_1.time_ < var_27_6 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play104071007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104071007
		arg_28_1.duration_ = 4.63

		local var_28_0 = {
			ja = 4.633,
			ko = 2.4,
			zh = 2.2,
			en = 2.3
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
				arg_28_0:Play104071008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "1036ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_28_1.stage_.transform)

					var_31_2.name = var_31_0
					var_31_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_28_1.actors_[var_31_0] = var_31_2

					local var_31_3 = var_31_2:GetComponentInChildren(typeof(CharacterEffect))

					var_31_3.enabled = true

					local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_2, typeof(DynamicBoneHelper))

					if var_31_4 then
						var_31_4:EnableDynamicBone(false)
					end

					arg_28_1:ShowWeapon(var_31_3.transform, false)

					arg_28_1.var_[var_31_0 .. "Animator"] = var_31_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_28_1.var_[var_31_0 .. "Animator"].applyRootMotion = true
					arg_28_1.var_[var_31_0 .. "LipSync"] = var_31_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_31_5 = arg_28_1.actors_["1036ui_story"]
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1036ui_story == nil then
				arg_28_1.var_.characterEffect1036ui_story = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_7 = 0.1

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 and not isNil(var_31_5) then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7

				if arg_28_1.var_.characterEffect1036ui_story and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect1036ui_story then
				arg_28_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_31_9 = arg_28_1.actors_["1019ui_story"].transform
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.var_.moveOldPos1019ui_story = var_31_9.localPosition
			end

			local var_31_11 = 0.001

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11
				local var_31_13 = Vector3.New(0, 100, 0)

				var_31_9.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1019ui_story, var_31_13, var_31_12)

				local var_31_14 = manager.ui.mainCamera.transform.position - var_31_9.position

				var_31_9.forward = Vector3.New(var_31_14.x, var_31_14.y, var_31_14.z)

				local var_31_15 = var_31_9.localEulerAngles

				var_31_15.z = 0
				var_31_15.x = 0
				var_31_9.localEulerAngles = var_31_15
			end

			if arg_28_1.time_ >= var_31_10 + var_31_11 and arg_28_1.time_ < var_31_10 + var_31_11 + arg_31_0 then
				var_31_9.localPosition = Vector3.New(0, 100, 0)

				local var_31_16 = manager.ui.mainCamera.transform.position - var_31_9.position

				var_31_9.forward = Vector3.New(var_31_16.x, var_31_16.y, var_31_16.z)

				local var_31_17 = var_31_9.localEulerAngles

				var_31_17.z = 0
				var_31_17.x = 0
				var_31_9.localEulerAngles = var_31_17
			end

			local var_31_18 = arg_28_1.actors_["1036ui_story"].transform
			local var_31_19 = 0

			if var_31_19 < arg_28_1.time_ and arg_28_1.time_ <= var_31_19 + arg_31_0 then
				arg_28_1.var_.moveOldPos1036ui_story = var_31_18.localPosition
			end

			local var_31_20 = 0.001

			if var_31_19 <= arg_28_1.time_ and arg_28_1.time_ < var_31_19 + var_31_20 then
				local var_31_21 = (arg_28_1.time_ - var_31_19) / var_31_20
				local var_31_22 = Vector3.New(0, -1.09, -5.78)

				var_31_18.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1036ui_story, var_31_22, var_31_21)

				local var_31_23 = manager.ui.mainCamera.transform.position - var_31_18.position

				var_31_18.forward = Vector3.New(var_31_23.x, var_31_23.y, var_31_23.z)

				local var_31_24 = var_31_18.localEulerAngles

				var_31_24.z = 0
				var_31_24.x = 0
				var_31_18.localEulerAngles = var_31_24
			end

			if arg_28_1.time_ >= var_31_19 + var_31_20 and arg_28_1.time_ < var_31_19 + var_31_20 + arg_31_0 then
				var_31_18.localPosition = Vector3.New(0, -1.09, -5.78)

				local var_31_25 = manager.ui.mainCamera.transform.position - var_31_18.position

				var_31_18.forward = Vector3.New(var_31_25.x, var_31_25.y, var_31_25.z)

				local var_31_26 = var_31_18.localEulerAngles

				var_31_26.z = 0
				var_31_26.x = 0
				var_31_18.localEulerAngles = var_31_26
			end

			local var_31_27 = 0

			if var_31_27 < arg_28_1.time_ and arg_28_1.time_ <= var_31_27 + arg_31_0 then
				arg_28_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_31_28 = 0

			if var_31_28 < arg_28_1.time_ and arg_28_1.time_ <= var_31_28 + arg_31_0 then
				arg_28_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_31_29 = 0
			local var_31_30 = 0.4

			if var_31_29 < arg_28_1.time_ and arg_28_1.time_ <= var_31_29 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_31 = arg_28_1:FormatText(StoryNameCfg[5].name)

				arg_28_1.leftNameTxt_.text = var_31_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_32 = arg_28_1:GetWordFromCfg(104071007)
				local var_31_33 = arg_28_1:FormatText(var_31_32.content)

				arg_28_1.text_.text = var_31_33

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_34 = 16
				local var_31_35 = utf8.len(var_31_33)
				local var_31_36 = var_31_34 <= 0 and var_31_30 or var_31_30 * (var_31_35 / var_31_34)

				if var_31_36 > 0 and var_31_30 < var_31_36 then
					arg_28_1.talkMaxDuration = var_31_36

					if var_31_36 + var_31_29 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_36 + var_31_29
					end
				end

				arg_28_1.text_.text = var_31_33
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071007", "story_v_out_104071.awb") ~= 0 then
					local var_31_37 = manager.audio:GetVoiceLength("story_v_out_104071", "104071007", "story_v_out_104071.awb") / 1000

					if var_31_37 + var_31_29 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_37 + var_31_29
					end

					if var_31_32.prefab_name ~= "" and arg_28_1.actors_[var_31_32.prefab_name] ~= nil then
						local var_31_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_32.prefab_name].transform, "story_v_out_104071", "104071007", "story_v_out_104071.awb")

						arg_28_1:RecordAudio("104071007", var_31_38)
						arg_28_1:RecordAudio("104071007", var_31_38)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_104071", "104071007", "story_v_out_104071.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_104071", "104071007", "story_v_out_104071.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_39 = math.max(var_31_30, arg_28_1.talkMaxDuration)

			if var_31_29 <= arg_28_1.time_ and arg_28_1.time_ < var_31_29 + var_31_39 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_29) / var_31_39

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_29 + var_31_39 and arg_28_1.time_ < var_31_29 + var_31_39 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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
				actorName = "1036ui_story",
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
	Play104071008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104071008
		arg_32_1.duration_ = 3.87

		local var_32_0 = {
			ja = 2.133,
			ko = 2.766,
			zh = 3.866,
			en = 2.7
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
				arg_32_0:Play104071009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["1036ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1036ui_story == nil then
				arg_32_1.var_.characterEffect1036ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect1036ui_story and not isNil(var_35_0) then
					local var_35_4 = Mathf.Lerp(0, 0.5, var_35_3)

					arg_32_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1036ui_story.fillRatio = var_35_4
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect1036ui_story then
				local var_35_5 = 0.5

				arg_32_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1036ui_story.fillRatio = var_35_5
			end

			local var_35_6 = 0
			local var_35_7 = 0.3

			if var_35_6 < arg_32_1.time_ and arg_32_1.time_ <= var_35_6 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_8 = arg_32_1:FormatText(StoryNameCfg[15].name)

				arg_32_1.leftNameTxt_.text = var_35_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_9 = arg_32_1:GetWordFromCfg(104071008)
				local var_35_10 = arg_32_1:FormatText(var_35_9.content)

				arg_32_1.text_.text = var_35_10

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_11 = 12
				local var_35_12 = utf8.len(var_35_10)
				local var_35_13 = var_35_11 <= 0 and var_35_7 or var_35_7 * (var_35_12 / var_35_11)

				if var_35_13 > 0 and var_35_7 < var_35_13 then
					arg_32_1.talkMaxDuration = var_35_13

					if var_35_13 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_13 + var_35_6
					end
				end

				arg_32_1.text_.text = var_35_10
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071008", "story_v_out_104071.awb") ~= 0 then
					local var_35_14 = manager.audio:GetVoiceLength("story_v_out_104071", "104071008", "story_v_out_104071.awb") / 1000

					if var_35_14 + var_35_6 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_14 + var_35_6
					end

					if var_35_9.prefab_name ~= "" and arg_32_1.actors_[var_35_9.prefab_name] ~= nil then
						local var_35_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_9.prefab_name].transform, "story_v_out_104071", "104071008", "story_v_out_104071.awb")

						arg_32_1:RecordAudio("104071008", var_35_15)
						arg_32_1:RecordAudio("104071008", var_35_15)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104071", "104071008", "story_v_out_104071.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104071", "104071008", "story_v_out_104071.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_7, arg_32_1.talkMaxDuration)

			if var_35_6 <= arg_32_1.time_ and arg_32_1.time_ < var_35_6 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_6) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_6 + var_35_16 and arg_32_1.time_ < var_35_6 + var_35_16 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play104071009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104071009
		arg_36_1.duration_ = 2

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play104071010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["1036ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1036ui_story == nil then
				arg_36_1.var_.characterEffect1036ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.1

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect1036ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect1036ui_story then
				arg_36_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_39_4 = 0

			if var_39_4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_2")
			end

			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_39_6 = 0
			local var_39_7 = 0.15

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_8 = arg_36_1:FormatText(StoryNameCfg[5].name)

				arg_36_1.leftNameTxt_.text = var_39_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_9 = arg_36_1:GetWordFromCfg(104071009)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 6
				local var_39_12 = utf8.len(var_39_10)
				local var_39_13 = var_39_11 <= 0 and var_39_7 or var_39_7 * (var_39_12 / var_39_11)

				if var_39_13 > 0 and var_39_7 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071009", "story_v_out_104071.awb") ~= 0 then
					local var_39_14 = manager.audio:GetVoiceLength("story_v_out_104071", "104071009", "story_v_out_104071.awb") / 1000

					if var_39_14 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_6
					end

					if var_39_9.prefab_name ~= "" and arg_36_1.actors_[var_39_9.prefab_name] ~= nil then
						local var_39_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_9.prefab_name].transform, "story_v_out_104071", "104071009", "story_v_out_104071.awb")

						arg_36_1:RecordAudio("104071009", var_39_15)
						arg_36_1:RecordAudio("104071009", var_39_15)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104071", "104071009", "story_v_out_104071.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104071", "104071009", "story_v_out_104071.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_16 and arg_36_1.time_ < var_39_6 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play104071010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104071010
		arg_40_1.duration_ = 5.8

		local var_40_0 = {
			ja = 4.466,
			ko = 4.4,
			zh = 5.8,
			en = 4.6
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
				arg_40_0:Play104071011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1036ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1036ui_story == nil then
				arg_40_1.var_.characterEffect1036ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1036ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1036ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1036ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1036ui_story.fillRatio = var_43_5
			end

			local var_43_6 = 0
			local var_43_7 = 0.55

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[15].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_9 = arg_40_1:GetWordFromCfg(104071010)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 22
				local var_43_12 = utf8.len(var_43_10)
				local var_43_13 = var_43_11 <= 0 and var_43_7 or var_43_7 * (var_43_12 / var_43_11)

				if var_43_13 > 0 and var_43_7 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_10
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071010", "story_v_out_104071.awb") ~= 0 then
					local var_43_14 = manager.audio:GetVoiceLength("story_v_out_104071", "104071010", "story_v_out_104071.awb") / 1000

					if var_43_14 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_6
					end

					if var_43_9.prefab_name ~= "" and arg_40_1.actors_[var_43_9.prefab_name] ~= nil then
						local var_43_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_9.prefab_name].transform, "story_v_out_104071", "104071010", "story_v_out_104071.awb")

						arg_40_1:RecordAudio("104071010", var_43_15)
						arg_40_1:RecordAudio("104071010", var_43_15)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_104071", "104071010", "story_v_out_104071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_104071", "104071010", "story_v_out_104071.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_16 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_16 and arg_40_1.time_ < var_43_6 + var_43_16 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play104071011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104071011
		arg_44_1.duration_ = 3.43

		local var_44_0 = {
			ja = 3.433,
			ko = 3.4,
			zh = 3.166,
			en = 3.233
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
				arg_44_0:Play104071012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["1036ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1036ui_story == nil then
				arg_44_1.var_.characterEffect1036ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect1036ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect1036ui_story then
				arg_44_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_47_4 = 0

			if var_47_4 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_47_6 = 0
			local var_47_7 = 0.35

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_8 = arg_44_1:FormatText(StoryNameCfg[5].name)

				arg_44_1.leftNameTxt_.text = var_47_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_9 = arg_44_1:GetWordFromCfg(104071011)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 14
				local var_47_12 = utf8.len(var_47_10)
				local var_47_13 = var_47_11 <= 0 and var_47_7 or var_47_7 * (var_47_12 / var_47_11)

				if var_47_13 > 0 and var_47_7 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071011", "story_v_out_104071.awb") ~= 0 then
					local var_47_14 = manager.audio:GetVoiceLength("story_v_out_104071", "104071011", "story_v_out_104071.awb") / 1000

					if var_47_14 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_6
					end

					if var_47_9.prefab_name ~= "" and arg_44_1.actors_[var_47_9.prefab_name] ~= nil then
						local var_47_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_9.prefab_name].transform, "story_v_out_104071", "104071011", "story_v_out_104071.awb")

						arg_44_1:RecordAudio("104071011", var_47_15)
						arg_44_1:RecordAudio("104071011", var_47_15)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_104071", "104071011", "story_v_out_104071.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_104071", "104071011", "story_v_out_104071.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_16 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_16 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_16

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_16 and arg_44_1.time_ < var_47_6 + var_47_16 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play104071012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 104071012
		arg_48_1.duration_ = 3.53

		local var_48_0 = {
			ja = 3.066,
			ko = 2.4,
			zh = 3.533,
			en = 2.8
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
				arg_48_0:Play104071013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_51_1 = 0
			local var_51_2 = 0.375

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_3 = arg_48_1:FormatText(StoryNameCfg[5].name)

				arg_48_1.leftNameTxt_.text = var_51_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_4 = arg_48_1:GetWordFromCfg(104071012)
				local var_51_5 = arg_48_1:FormatText(var_51_4.content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_6 = 15
				local var_51_7 = utf8.len(var_51_5)
				local var_51_8 = var_51_6 <= 0 and var_51_2 or var_51_2 * (var_51_7 / var_51_6)

				if var_51_8 > 0 and var_51_2 < var_51_8 then
					arg_48_1.talkMaxDuration = var_51_8

					if var_51_8 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_1
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071012", "story_v_out_104071.awb") ~= 0 then
					local var_51_9 = manager.audio:GetVoiceLength("story_v_out_104071", "104071012", "story_v_out_104071.awb") / 1000

					if var_51_9 + var_51_1 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_1
					end

					if var_51_4.prefab_name ~= "" and arg_48_1.actors_[var_51_4.prefab_name] ~= nil then
						local var_51_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_4.prefab_name].transform, "story_v_out_104071", "104071012", "story_v_out_104071.awb")

						arg_48_1:RecordAudio("104071012", var_51_10)
						arg_48_1:RecordAudio("104071012", var_51_10)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_104071", "104071012", "story_v_out_104071.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_104071", "104071012", "story_v_out_104071.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_11 = math.max(var_51_2, arg_48_1.talkMaxDuration)

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_11 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_1) / var_51_11

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_1 + var_51_11 and arg_48_1.time_ < var_51_1 + var_51_11 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play104071013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 104071013
		arg_52_1.duration_ = 7.3

		local var_52_0 = {
			ja = 7.266,
			ko = 6.933,
			zh = 7.3,
			en = 6.3
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
				arg_52_0:Play104071014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1036ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1036ui_story == nil then
				arg_52_1.var_.characterEffect1036ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1036ui_story and not isNil(var_55_0) then
					local var_55_4 = Mathf.Lerp(0, 0.5, var_55_3)

					arg_52_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1036ui_story.fillRatio = var_55_4
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1036ui_story then
				local var_55_5 = 0.5

				arg_52_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1036ui_story.fillRatio = var_55_5
			end

			local var_55_6 = 0
			local var_55_7 = 0.9

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[15].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_9 = arg_52_1:GetWordFromCfg(104071013)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071013", "story_v_out_104071.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_out_104071", "104071013", "story_v_out_104071.awb") / 1000

					if var_55_14 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_6
					end

					if var_55_9.prefab_name ~= "" and arg_52_1.actors_[var_55_9.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_9.prefab_name].transform, "story_v_out_104071", "104071013", "story_v_out_104071.awb")

						arg_52_1:RecordAudio("104071013", var_55_15)
						arg_52_1:RecordAudio("104071013", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_104071", "104071013", "story_v_out_104071.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_104071", "104071013", "story_v_out_104071.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_16 and arg_52_1.time_ < var_55_6 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play104071014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 104071014
		arg_56_1.duration_ = 2

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play104071015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["1036ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1036ui_story == nil then
				arg_56_1.var_.characterEffect1036ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect1036ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect1036ui_story then
				arg_56_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_59_4 = 0

			if var_59_4 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action447")
			end

			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_59_6 = 0
			local var_59_7 = 0.05

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_8 = arg_56_1:FormatText(StoryNameCfg[5].name)

				arg_56_1.leftNameTxt_.text = var_59_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_9 = arg_56_1:GetWordFromCfg(104071014)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 2
				local var_59_12 = utf8.len(var_59_10)
				local var_59_13 = var_59_11 <= 0 and var_59_7 or var_59_7 * (var_59_12 / var_59_11)

				if var_59_13 > 0 and var_59_7 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071014", "story_v_out_104071.awb") ~= 0 then
					local var_59_14 = manager.audio:GetVoiceLength("story_v_out_104071", "104071014", "story_v_out_104071.awb") / 1000

					if var_59_14 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_14 + var_59_6
					end

					if var_59_9.prefab_name ~= "" and arg_56_1.actors_[var_59_9.prefab_name] ~= nil then
						local var_59_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_9.prefab_name].transform, "story_v_out_104071", "104071014", "story_v_out_104071.awb")

						arg_56_1:RecordAudio("104071014", var_59_15)
						arg_56_1:RecordAudio("104071014", var_59_15)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_104071", "104071014", "story_v_out_104071.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_104071", "104071014", "story_v_out_104071.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_16 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_16 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_16

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_16 and arg_56_1.time_ < var_59_6 + var_59_16 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play104071015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 104071015
		arg_60_1.duration_ = 2.93

		local var_60_0 = {
			ja = 2.3,
			ko = 2.033,
			zh = 2.933,
			en = 2.866
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
				arg_60_0:Play104071016(arg_60_1)
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

			local var_63_4 = arg_60_1.actors_["1036ui_story"]
			local var_63_5 = 0

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1036ui_story == nil then
				arg_60_1.var_.characterEffect1036ui_story = var_63_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_6 = 0.1

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_6 and not isNil(var_63_4) then
				local var_63_7 = (arg_60_1.time_ - var_63_5) / var_63_6

				if arg_60_1.var_.characterEffect1036ui_story and not isNil(var_63_4) then
					local var_63_8 = Mathf.Lerp(0, 0.5, var_63_7)

					arg_60_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1036ui_story.fillRatio = var_63_8
				end
			end

			if arg_60_1.time_ >= var_63_5 + var_63_6 and arg_60_1.time_ < var_63_5 + var_63_6 + arg_63_0 and not isNil(var_63_4) and arg_60_1.var_.characterEffect1036ui_story then
				local var_63_9 = 0.5

				arg_60_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1036ui_story.fillRatio = var_63_9
			end

			local var_63_10 = arg_60_1.actors_["1036ui_story"].transform
			local var_63_11 = 0

			if var_63_11 < arg_60_1.time_ and arg_60_1.time_ <= var_63_11 + arg_63_0 then
				arg_60_1.var_.moveOldPos1036ui_story = var_63_10.localPosition
			end

			local var_63_12 = 0.001

			if var_63_11 <= arg_60_1.time_ and arg_60_1.time_ < var_63_11 + var_63_12 then
				local var_63_13 = (arg_60_1.time_ - var_63_11) / var_63_12
				local var_63_14 = Vector3.New(0, 100, 0)

				var_63_10.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1036ui_story, var_63_14, var_63_13)

				local var_63_15 = manager.ui.mainCamera.transform.position - var_63_10.position

				var_63_10.forward = Vector3.New(var_63_15.x, var_63_15.y, var_63_15.z)

				local var_63_16 = var_63_10.localEulerAngles

				var_63_16.z = 0
				var_63_16.x = 0
				var_63_10.localEulerAngles = var_63_16
			end

			if arg_60_1.time_ >= var_63_11 + var_63_12 and arg_60_1.time_ < var_63_11 + var_63_12 + arg_63_0 then
				var_63_10.localPosition = Vector3.New(0, 100, 0)

				local var_63_17 = manager.ui.mainCamera.transform.position - var_63_10.position

				var_63_10.forward = Vector3.New(var_63_17.x, var_63_17.y, var_63_17.z)

				local var_63_18 = var_63_10.localEulerAngles

				var_63_18.z = 0
				var_63_18.x = 0
				var_63_10.localEulerAngles = var_63_18
			end

			local var_63_19 = arg_60_1.actors_["1019ui_story"].transform
			local var_63_20 = 0

			if var_63_20 < arg_60_1.time_ and arg_60_1.time_ <= var_63_20 + arg_63_0 then
				arg_60_1.var_.moveOldPos1019ui_story = var_63_19.localPosition
			end

			local var_63_21 = 0.001

			if var_63_20 <= arg_60_1.time_ and arg_60_1.time_ < var_63_20 + var_63_21 then
				local var_63_22 = (arg_60_1.time_ - var_63_20) / var_63_21
				local var_63_23 = Vector3.New(-0.2, -1.08, -5.9)

				var_63_19.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1019ui_story, var_63_23, var_63_22)

				local var_63_24 = manager.ui.mainCamera.transform.position - var_63_19.position

				var_63_19.forward = Vector3.New(var_63_24.x, var_63_24.y, var_63_24.z)

				local var_63_25 = var_63_19.localEulerAngles

				var_63_25.z = 0
				var_63_25.x = 0
				var_63_19.localEulerAngles = var_63_25
			end

			if arg_60_1.time_ >= var_63_20 + var_63_21 and arg_60_1.time_ < var_63_20 + var_63_21 + arg_63_0 then
				var_63_19.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_63_26 = manager.ui.mainCamera.transform.position - var_63_19.position

				var_63_19.forward = Vector3.New(var_63_26.x, var_63_26.y, var_63_26.z)

				local var_63_27 = var_63_19.localEulerAngles

				var_63_27.z = 0
				var_63_27.x = 0
				var_63_19.localEulerAngles = var_63_27
			end

			local var_63_28 = 0

			if var_63_28 < arg_60_1.time_ and arg_60_1.time_ <= var_63_28 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_63_29 = 0

			if var_63_29 < arg_60_1.time_ and arg_60_1.time_ <= var_63_29 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_63_30 = 0
			local var_63_31 = 0.35

			if var_63_30 < arg_60_1.time_ and arg_60_1.time_ <= var_63_30 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_32 = arg_60_1:FormatText(StoryNameCfg[13].name)

				arg_60_1.leftNameTxt_.text = var_63_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_33 = arg_60_1:GetWordFromCfg(104071015)
				local var_63_34 = arg_60_1:FormatText(var_63_33.content)

				arg_60_1.text_.text = var_63_34

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_35 = 14
				local var_63_36 = utf8.len(var_63_34)
				local var_63_37 = var_63_35 <= 0 and var_63_31 or var_63_31 * (var_63_36 / var_63_35)

				if var_63_37 > 0 and var_63_31 < var_63_37 then
					arg_60_1.talkMaxDuration = var_63_37

					if var_63_37 + var_63_30 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_37 + var_63_30
					end
				end

				arg_60_1.text_.text = var_63_34
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071015", "story_v_out_104071.awb") ~= 0 then
					local var_63_38 = manager.audio:GetVoiceLength("story_v_out_104071", "104071015", "story_v_out_104071.awb") / 1000

					if var_63_38 + var_63_30 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_38 + var_63_30
					end

					if var_63_33.prefab_name ~= "" and arg_60_1.actors_[var_63_33.prefab_name] ~= nil then
						local var_63_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_33.prefab_name].transform, "story_v_out_104071", "104071015", "story_v_out_104071.awb")

						arg_60_1:RecordAudio("104071015", var_63_39)
						arg_60_1:RecordAudio("104071015", var_63_39)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_104071", "104071015", "story_v_out_104071.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_104071", "104071015", "story_v_out_104071.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_40 = math.max(var_63_31, arg_60_1.talkMaxDuration)

			if var_63_30 <= arg_60_1.time_ and arg_60_1.time_ < var_63_30 + var_63_40 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_30) / var_63_40

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_30 + var_63_40 and arg_60_1.time_ < var_63_30 + var_63_40 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
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

		arg_60_1:InitPlayNodeList()
	end,
	Play104071016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 104071016
		arg_64_1.duration_ = 10.13

		local var_64_0 = {
			ja = 9.4,
			ko = 9.366,
			zh = 10.133,
			en = 8.266
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
				arg_64_0:Play104071017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["1019ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1019ui_story == nil then
				arg_64_1.var_.characterEffect1019ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.1

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect1019ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1019ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect1019ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1019ui_story.fillRatio = var_67_5
			end

			local var_67_6 = 0
			local var_67_7 = 0.95

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_8 = arg_64_1:FormatText(StoryNameCfg[44].name)

				arg_64_1.leftNameTxt_.text = var_67_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_9 = arg_64_1:GetWordFromCfg(104071016)
				local var_67_10 = arg_64_1:FormatText(var_67_9.content)

				arg_64_1.text_.text = var_67_10

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_11 = 37
				local var_67_12 = utf8.len(var_67_10)
				local var_67_13 = var_67_11 <= 0 and var_67_7 or var_67_7 * (var_67_12 / var_67_11)

				if var_67_13 > 0 and var_67_7 < var_67_13 then
					arg_64_1.talkMaxDuration = var_67_13

					if var_67_13 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_13 + var_67_6
					end
				end

				arg_64_1.text_.text = var_67_10
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071016", "story_v_out_104071.awb") ~= 0 then
					local var_67_14 = manager.audio:GetVoiceLength("story_v_out_104071", "104071016", "story_v_out_104071.awb") / 1000

					if var_67_14 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_14 + var_67_6
					end

					if var_67_9.prefab_name ~= "" and arg_64_1.actors_[var_67_9.prefab_name] ~= nil then
						local var_67_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_9.prefab_name].transform, "story_v_out_104071", "104071016", "story_v_out_104071.awb")

						arg_64_1:RecordAudio("104071016", var_67_15)
						arg_64_1:RecordAudio("104071016", var_67_15)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_104071", "104071016", "story_v_out_104071.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_104071", "104071016", "story_v_out_104071.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_16 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_16 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_16

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_16 and arg_64_1.time_ < var_67_6 + var_67_16 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play104071017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 104071017
		arg_68_1.duration_ = 2.23

		local var_68_0 = {
			ja = 2.233,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_68_0:Play104071018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = "1011ui_story"

			if arg_68_1.actors_[var_71_0] == nil then
				local var_71_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_71_1) then
					local var_71_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_68_1.stage_.transform)

					var_71_2.name = var_71_0
					var_71_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_68_1.actors_[var_71_0] = var_71_2

					local var_71_3 = var_71_2:GetComponentInChildren(typeof(CharacterEffect))

					var_71_3.enabled = true

					local var_71_4 = GameObjectTools.GetOrAddComponent(var_71_2, typeof(DynamicBoneHelper))

					if var_71_4 then
						var_71_4:EnableDynamicBone(false)
					end

					arg_68_1:ShowWeapon(var_71_3.transform, false)

					arg_68_1.var_[var_71_0 .. "Animator"] = var_71_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_68_1.var_[var_71_0 .. "Animator"].applyRootMotion = true
					arg_68_1.var_[var_71_0 .. "LipSync"] = var_71_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_71_5 = arg_68_1.actors_["1011ui_story"]
			local var_71_6 = 0

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 and not isNil(var_71_5) and arg_68_1.var_.characterEffect1011ui_story == nil then
				arg_68_1.var_.characterEffect1011ui_story = var_71_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_7 = 0.1

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_7 and not isNil(var_71_5) then
				local var_71_8 = (arg_68_1.time_ - var_71_6) / var_71_7

				if arg_68_1.var_.characterEffect1011ui_story and not isNil(var_71_5) then
					arg_68_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_6 + var_71_7 and arg_68_1.time_ < var_71_6 + var_71_7 + arg_71_0 and not isNil(var_71_5) and arg_68_1.var_.characterEffect1011ui_story then
				arg_68_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_71_9 = arg_68_1.actors_["1019ui_story"].transform
			local var_71_10 = 0

			if var_71_10 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1.var_.moveOldPos1019ui_story = var_71_9.localPosition
			end

			local var_71_11 = 0.001

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_11 then
				local var_71_12 = (arg_68_1.time_ - var_71_10) / var_71_11
				local var_71_13 = Vector3.New(0, 100, 0)

				var_71_9.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1019ui_story, var_71_13, var_71_12)

				local var_71_14 = manager.ui.mainCamera.transform.position - var_71_9.position

				var_71_9.forward = Vector3.New(var_71_14.x, var_71_14.y, var_71_14.z)

				local var_71_15 = var_71_9.localEulerAngles

				var_71_15.z = 0
				var_71_15.x = 0
				var_71_9.localEulerAngles = var_71_15
			end

			if arg_68_1.time_ >= var_71_10 + var_71_11 and arg_68_1.time_ < var_71_10 + var_71_11 + arg_71_0 then
				var_71_9.localPosition = Vector3.New(0, 100, 0)

				local var_71_16 = manager.ui.mainCamera.transform.position - var_71_9.position

				var_71_9.forward = Vector3.New(var_71_16.x, var_71_16.y, var_71_16.z)

				local var_71_17 = var_71_9.localEulerAngles

				var_71_17.z = 0
				var_71_17.x = 0
				var_71_9.localEulerAngles = var_71_17
			end

			local var_71_18 = arg_68_1.actors_["1011ui_story"].transform
			local var_71_19 = 0

			if var_71_19 < arg_68_1.time_ and arg_68_1.time_ <= var_71_19 + arg_71_0 then
				arg_68_1.var_.moveOldPos1011ui_story = var_71_18.localPosition
			end

			local var_71_20 = 0.001

			if var_71_19 <= arg_68_1.time_ and arg_68_1.time_ < var_71_19 + var_71_20 then
				local var_71_21 = (arg_68_1.time_ - var_71_19) / var_71_20
				local var_71_22 = Vector3.New(-0.7, -0.71, -6)

				var_71_18.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1011ui_story, var_71_22, var_71_21)

				local var_71_23 = manager.ui.mainCamera.transform.position - var_71_18.position

				var_71_18.forward = Vector3.New(var_71_23.x, var_71_23.y, var_71_23.z)

				local var_71_24 = var_71_18.localEulerAngles

				var_71_24.z = 0
				var_71_24.x = 0
				var_71_18.localEulerAngles = var_71_24
			end

			if arg_68_1.time_ >= var_71_19 + var_71_20 and arg_68_1.time_ < var_71_19 + var_71_20 + arg_71_0 then
				var_71_18.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_71_25 = manager.ui.mainCamera.transform.position - var_71_18.position

				var_71_18.forward = Vector3.New(var_71_25.x, var_71_25.y, var_71_25.z)

				local var_71_26 = var_71_18.localEulerAngles

				var_71_26.z = 0
				var_71_26.x = 0
				var_71_18.localEulerAngles = var_71_26
			end

			local var_71_27 = 0

			if var_71_27 < arg_68_1.time_ and arg_68_1.time_ <= var_71_27 + arg_71_0 then
				arg_68_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_71_28 = 0

			if var_71_28 < arg_68_1.time_ and arg_68_1.time_ <= var_71_28 + arg_71_0 then
				arg_68_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_71_29 = 0
			local var_71_30 = 0.15

			if var_71_29 < arg_68_1.time_ and arg_68_1.time_ <= var_71_29 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_31 = arg_68_1:FormatText(StoryNameCfg[37].name)

				arg_68_1.leftNameTxt_.text = var_71_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_32 = arg_68_1:GetWordFromCfg(104071017)
				local var_71_33 = arg_68_1:FormatText(var_71_32.content)

				arg_68_1.text_.text = var_71_33

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_34 = 6
				local var_71_35 = utf8.len(var_71_33)
				local var_71_36 = var_71_34 <= 0 and var_71_30 or var_71_30 * (var_71_35 / var_71_34)

				if var_71_36 > 0 and var_71_30 < var_71_36 then
					arg_68_1.talkMaxDuration = var_71_36

					if var_71_36 + var_71_29 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_36 + var_71_29
					end
				end

				arg_68_1.text_.text = var_71_33
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071017", "story_v_out_104071.awb") ~= 0 then
					local var_71_37 = manager.audio:GetVoiceLength("story_v_out_104071", "104071017", "story_v_out_104071.awb") / 1000

					if var_71_37 + var_71_29 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_37 + var_71_29
					end

					if var_71_32.prefab_name ~= "" and arg_68_1.actors_[var_71_32.prefab_name] ~= nil then
						local var_71_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_32.prefab_name].transform, "story_v_out_104071", "104071017", "story_v_out_104071.awb")

						arg_68_1:RecordAudio("104071017", var_71_38)
						arg_68_1:RecordAudio("104071017", var_71_38)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_104071", "104071017", "story_v_out_104071.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_104071", "104071017", "story_v_out_104071.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_39 = math.max(var_71_30, arg_68_1.talkMaxDuration)

			if var_71_29 <= arg_68_1.time_ and arg_68_1.time_ < var_71_29 + var_71_39 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_29) / var_71_39

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_29 + var_71_39 and arg_68_1.time_ < var_71_29 + var_71_39 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
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

		arg_68_1:InitPlayNodeList()
	end,
	Play104071018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 104071018
		arg_72_1.duration_ = 3.57

		local var_72_0 = {
			ja = 3.533,
			ko = 3.566,
			zh = 2.9,
			en = 3.2
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
				arg_72_0:Play104071019(arg_72_1)
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

			local var_75_4 = arg_72_1.actors_["1011ui_story"]
			local var_75_5 = 0

			if var_75_5 < arg_72_1.time_ and arg_72_1.time_ <= var_75_5 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect1011ui_story == nil then
				arg_72_1.var_.characterEffect1011ui_story = var_75_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.1

			if var_75_5 <= arg_72_1.time_ and arg_72_1.time_ < var_75_5 + var_75_6 and not isNil(var_75_4) then
				local var_75_7 = (arg_72_1.time_ - var_75_5) / var_75_6

				if arg_72_1.var_.characterEffect1011ui_story and not isNil(var_75_4) then
					local var_75_8 = Mathf.Lerp(0, 0.5, var_75_7)

					arg_72_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1011ui_story.fillRatio = var_75_8
				end
			end

			if arg_72_1.time_ >= var_75_5 + var_75_6 and arg_72_1.time_ < var_75_5 + var_75_6 + arg_75_0 and not isNil(var_75_4) and arg_72_1.var_.characterEffect1011ui_story then
				local var_75_9 = 0.5

				arg_72_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1011ui_story.fillRatio = var_75_9
			end

			local var_75_10 = arg_72_1.actors_["1084ui_story"].transform
			local var_75_11 = 0

			if var_75_11 < arg_72_1.time_ and arg_72_1.time_ <= var_75_11 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_10.localPosition
			end

			local var_75_12 = 0.001

			if var_75_11 <= arg_72_1.time_ and arg_72_1.time_ < var_75_11 + var_75_12 then
				local var_75_13 = (arg_72_1.time_ - var_75_11) / var_75_12
				local var_75_14 = Vector3.New(0.7, -0.97, -6)

				var_75_10.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, var_75_14, var_75_13)

				local var_75_15 = manager.ui.mainCamera.transform.position - var_75_10.position

				var_75_10.forward = Vector3.New(var_75_15.x, var_75_15.y, var_75_15.z)

				local var_75_16 = var_75_10.localEulerAngles

				var_75_16.z = 0
				var_75_16.x = 0
				var_75_10.localEulerAngles = var_75_16
			end

			if arg_72_1.time_ >= var_75_11 + var_75_12 and arg_72_1.time_ < var_75_11 + var_75_12 + arg_75_0 then
				var_75_10.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_75_17 = manager.ui.mainCamera.transform.position - var_75_10.position

				var_75_10.forward = Vector3.New(var_75_17.x, var_75_17.y, var_75_17.z)

				local var_75_18 = var_75_10.localEulerAngles

				var_75_18.z = 0
				var_75_18.x = 0
				var_75_10.localEulerAngles = var_75_18
			end

			local var_75_19 = 0

			if var_75_19 < arg_72_1.time_ and arg_72_1.time_ <= var_75_19 + arg_75_0 then
				arg_72_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			local var_75_20 = 0

			if var_75_20 < arg_72_1.time_ and arg_72_1.time_ <= var_75_20 + arg_75_0 then
				arg_72_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_75_21 = 0
			local var_75_22 = 0.3

			if var_75_21 < arg_72_1.time_ and arg_72_1.time_ <= var_75_21 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_23 = arg_72_1:FormatText(StoryNameCfg[6].name)

				arg_72_1.leftNameTxt_.text = var_75_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_24 = arg_72_1:GetWordFromCfg(104071018)
				local var_75_25 = arg_72_1:FormatText(var_75_24.content)

				arg_72_1.text_.text = var_75_25

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_26 = 12
				local var_75_27 = utf8.len(var_75_25)
				local var_75_28 = var_75_26 <= 0 and var_75_22 or var_75_22 * (var_75_27 / var_75_26)

				if var_75_28 > 0 and var_75_22 < var_75_28 then
					arg_72_1.talkMaxDuration = var_75_28

					if var_75_28 + var_75_21 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_28 + var_75_21
					end
				end

				arg_72_1.text_.text = var_75_25
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071018", "story_v_out_104071.awb") ~= 0 then
					local var_75_29 = manager.audio:GetVoiceLength("story_v_out_104071", "104071018", "story_v_out_104071.awb") / 1000

					if var_75_29 + var_75_21 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_29 + var_75_21
					end

					if var_75_24.prefab_name ~= "" and arg_72_1.actors_[var_75_24.prefab_name] ~= nil then
						local var_75_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_24.prefab_name].transform, "story_v_out_104071", "104071018", "story_v_out_104071.awb")

						arg_72_1:RecordAudio("104071018", var_75_30)
						arg_72_1:RecordAudio("104071018", var_75_30)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_104071", "104071018", "story_v_out_104071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_104071", "104071018", "story_v_out_104071.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_31 = math.max(var_75_22, arg_72_1.talkMaxDuration)

			if var_75_21 <= arg_72_1.time_ and arg_72_1.time_ < var_75_21 + var_75_31 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_21) / var_75_31

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_21 + var_75_31 and arg_72_1.time_ < var_75_21 + var_75_31 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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
	Play104071019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 104071019
		arg_76_1.duration_ = 5.07

		local var_76_0 = {
			ja = 5.033,
			ko = 3.666,
			zh = 5,
			en = 5.066
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play104071020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = arg_76_1.actors_["1019ui_story"]
			local var_79_1 = 0

			if var_79_1 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1019ui_story == nil then
				arg_76_1.var_.characterEffect1019ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_2 = 0.1

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_2 and not isNil(var_79_0) then
				local var_79_3 = (arg_76_1.time_ - var_79_1) / var_79_2

				if arg_76_1.var_.characterEffect1019ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= var_79_1 + var_79_2 and arg_76_1.time_ < var_79_1 + var_79_2 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1019ui_story then
				arg_76_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_79_4 = arg_76_1.actors_["1084ui_story"]
			local var_79_5 = 0

			if var_79_5 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1084ui_story == nil then
				arg_76_1.var_.characterEffect1084ui_story = var_79_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_6 = 0.1

			if var_79_5 <= arg_76_1.time_ and arg_76_1.time_ < var_79_5 + var_79_6 and not isNil(var_79_4) then
				local var_79_7 = (arg_76_1.time_ - var_79_5) / var_79_6

				if arg_76_1.var_.characterEffect1084ui_story and not isNil(var_79_4) then
					local var_79_8 = Mathf.Lerp(0, 0.5, var_79_7)

					arg_76_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1084ui_story.fillRatio = var_79_8
				end
			end

			if arg_76_1.time_ >= var_79_5 + var_79_6 and arg_76_1.time_ < var_79_5 + var_79_6 + arg_79_0 and not isNil(var_79_4) and arg_76_1.var_.characterEffect1084ui_story then
				local var_79_9 = 0.5

				arg_76_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1084ui_story.fillRatio = var_79_9
			end

			local var_79_10 = arg_76_1.actors_["1084ui_story"].transform
			local var_79_11 = 0

			if var_79_11 < arg_76_1.time_ and arg_76_1.time_ <= var_79_11 + arg_79_0 then
				arg_76_1.var_.moveOldPos1084ui_story = var_79_10.localPosition
			end

			local var_79_12 = 0.001

			if var_79_11 <= arg_76_1.time_ and arg_76_1.time_ < var_79_11 + var_79_12 then
				local var_79_13 = (arg_76_1.time_ - var_79_11) / var_79_12
				local var_79_14 = Vector3.New(0, 100, 0)

				var_79_10.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1084ui_story, var_79_14, var_79_13)

				local var_79_15 = manager.ui.mainCamera.transform.position - var_79_10.position

				var_79_10.forward = Vector3.New(var_79_15.x, var_79_15.y, var_79_15.z)

				local var_79_16 = var_79_10.localEulerAngles

				var_79_16.z = 0
				var_79_16.x = 0
				var_79_10.localEulerAngles = var_79_16
			end

			if arg_76_1.time_ >= var_79_11 + var_79_12 and arg_76_1.time_ < var_79_11 + var_79_12 + arg_79_0 then
				var_79_10.localPosition = Vector3.New(0, 100, 0)

				local var_79_17 = manager.ui.mainCamera.transform.position - var_79_10.position

				var_79_10.forward = Vector3.New(var_79_17.x, var_79_17.y, var_79_17.z)

				local var_79_18 = var_79_10.localEulerAngles

				var_79_18.z = 0
				var_79_18.x = 0
				var_79_10.localEulerAngles = var_79_18
			end

			local var_79_19 = arg_76_1.actors_["1011ui_story"].transform
			local var_79_20 = 0

			if var_79_20 < arg_76_1.time_ and arg_76_1.time_ <= var_79_20 + arg_79_0 then
				arg_76_1.var_.moveOldPos1011ui_story = var_79_19.localPosition
			end

			local var_79_21 = 0.001

			if var_79_20 <= arg_76_1.time_ and arg_76_1.time_ < var_79_20 + var_79_21 then
				local var_79_22 = (arg_76_1.time_ - var_79_20) / var_79_21
				local var_79_23 = Vector3.New(0, 100, 0)

				var_79_19.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1011ui_story, var_79_23, var_79_22)

				local var_79_24 = manager.ui.mainCamera.transform.position - var_79_19.position

				var_79_19.forward = Vector3.New(var_79_24.x, var_79_24.y, var_79_24.z)

				local var_79_25 = var_79_19.localEulerAngles

				var_79_25.z = 0
				var_79_25.x = 0
				var_79_19.localEulerAngles = var_79_25
			end

			if arg_76_1.time_ >= var_79_20 + var_79_21 and arg_76_1.time_ < var_79_20 + var_79_21 + arg_79_0 then
				var_79_19.localPosition = Vector3.New(0, 100, 0)

				local var_79_26 = manager.ui.mainCamera.transform.position - var_79_19.position

				var_79_19.forward = Vector3.New(var_79_26.x, var_79_26.y, var_79_26.z)

				local var_79_27 = var_79_19.localEulerAngles

				var_79_27.z = 0
				var_79_27.x = 0
				var_79_19.localEulerAngles = var_79_27
			end

			local var_79_28 = arg_76_1.actors_["1019ui_story"].transform
			local var_79_29 = 0

			if var_79_29 < arg_76_1.time_ and arg_76_1.time_ <= var_79_29 + arg_79_0 then
				arg_76_1.var_.moveOldPos1019ui_story = var_79_28.localPosition
			end

			local var_79_30 = 0.001

			if var_79_29 <= arg_76_1.time_ and arg_76_1.time_ < var_79_29 + var_79_30 then
				local var_79_31 = (arg_76_1.time_ - var_79_29) / var_79_30
				local var_79_32 = Vector3.New(-0.2, -1.08, -5.9)

				var_79_28.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1019ui_story, var_79_32, var_79_31)

				local var_79_33 = manager.ui.mainCamera.transform.position - var_79_28.position

				var_79_28.forward = Vector3.New(var_79_33.x, var_79_33.y, var_79_33.z)

				local var_79_34 = var_79_28.localEulerAngles

				var_79_34.z = 0
				var_79_34.x = 0
				var_79_28.localEulerAngles = var_79_34
			end

			if arg_76_1.time_ >= var_79_29 + var_79_30 and arg_76_1.time_ < var_79_29 + var_79_30 + arg_79_0 then
				var_79_28.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_79_35 = manager.ui.mainCamera.transform.position - var_79_28.position

				var_79_28.forward = Vector3.New(var_79_35.x, var_79_35.y, var_79_35.z)

				local var_79_36 = var_79_28.localEulerAngles

				var_79_36.z = 0
				var_79_36.x = 0
				var_79_28.localEulerAngles = var_79_36
			end

			local var_79_37 = 0

			if var_79_37 < arg_76_1.time_ and arg_76_1.time_ <= var_79_37 + arg_79_0 then
				arg_76_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_79_38 = 0

			if var_79_38 < arg_76_1.time_ and arg_76_1.time_ <= var_79_38 + arg_79_0 then
				arg_76_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_79_39 = 0
			local var_79_40 = 0.65

			if var_79_39 < arg_76_1.time_ and arg_76_1.time_ <= var_79_39 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_41 = arg_76_1:FormatText(StoryNameCfg[13].name)

				arg_76_1.leftNameTxt_.text = var_79_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_42 = arg_76_1:GetWordFromCfg(104071019)
				local var_79_43 = arg_76_1:FormatText(var_79_42.content)

				arg_76_1.text_.text = var_79_43

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_44 = 26
				local var_79_45 = utf8.len(var_79_43)
				local var_79_46 = var_79_44 <= 0 and var_79_40 or var_79_40 * (var_79_45 / var_79_44)

				if var_79_46 > 0 and var_79_40 < var_79_46 then
					arg_76_1.talkMaxDuration = var_79_46

					if var_79_46 + var_79_39 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_46 + var_79_39
					end
				end

				arg_76_1.text_.text = var_79_43
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071019", "story_v_out_104071.awb") ~= 0 then
					local var_79_47 = manager.audio:GetVoiceLength("story_v_out_104071", "104071019", "story_v_out_104071.awb") / 1000

					if var_79_47 + var_79_39 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_47 + var_79_39
					end

					if var_79_42.prefab_name ~= "" and arg_76_1.actors_[var_79_42.prefab_name] ~= nil then
						local var_79_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_42.prefab_name].transform, "story_v_out_104071", "104071019", "story_v_out_104071.awb")

						arg_76_1:RecordAudio("104071019", var_79_48)
						arg_76_1:RecordAudio("104071019", var_79_48)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_104071", "104071019", "story_v_out_104071.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_104071", "104071019", "story_v_out_104071.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_49 = math.max(var_79_40, arg_76_1.talkMaxDuration)

			if var_79_39 <= arg_76_1.time_ and arg_76_1.time_ < var_79_39 + var_79_49 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_39) / var_79_49

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_39 + var_79_49 and arg_76_1.time_ < var_79_39 + var_79_49 + arg_79_0 then
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
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play104071020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 104071020
		arg_80_1.duration_ = 1.77

		local var_80_0 = {
			ja = 1.633,
			ko = 1.766,
			zh = 1.266,
			en = 1.3
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
				arg_80_0:Play104071021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["1019ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1019ui_story == nil then
				arg_80_1.var_.characterEffect1019ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.1

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect1019ui_story and not isNil(var_83_0) then
					local var_83_4 = Mathf.Lerp(0, 0.5, var_83_3)

					arg_80_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1019ui_story.fillRatio = var_83_4
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect1019ui_story then
				local var_83_5 = 0.5

				arg_80_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1019ui_story.fillRatio = var_83_5
			end

			local var_83_6 = 0
			local var_83_7 = 0.075

			if var_83_6 < arg_80_1.time_ and arg_80_1.time_ <= var_83_6 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_8 = arg_80_1:FormatText(StoryNameCfg[44].name)

				arg_80_1.leftNameTxt_.text = var_83_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_9 = arg_80_1:GetWordFromCfg(104071020)
				local var_83_10 = arg_80_1:FormatText(var_83_9.content)

				arg_80_1.text_.text = var_83_10

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_11 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071020", "story_v_out_104071.awb") ~= 0 then
					local var_83_14 = manager.audio:GetVoiceLength("story_v_out_104071", "104071020", "story_v_out_104071.awb") / 1000

					if var_83_14 + var_83_6 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_14 + var_83_6
					end

					if var_83_9.prefab_name ~= "" and arg_80_1.actors_[var_83_9.prefab_name] ~= nil then
						local var_83_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_9.prefab_name].transform, "story_v_out_104071", "104071020", "story_v_out_104071.awb")

						arg_80_1:RecordAudio("104071020", var_83_15)
						arg_80_1:RecordAudio("104071020", var_83_15)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_104071", "104071020", "story_v_out_104071.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_104071", "104071020", "story_v_out_104071.awb")
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
	Play104071021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 104071021
		arg_84_1.duration_ = 4.2

		local var_84_0 = {
			ja = 4.2,
			ko = 3.333,
			zh = 3.333,
			en = 3.266
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
				arg_84_0:Play104071022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1011ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1011ui_story == nil then
				arg_84_1.var_.characterEffect1011ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.1

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1011ui_story and not isNil(var_87_0) then
					arg_84_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1011ui_story then
				arg_84_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_87_4 = arg_84_1.actors_["1019ui_story"].transform
			local var_87_5 = 0

			if var_87_5 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1.var_.moveOldPos1019ui_story = var_87_4.localPosition
			end

			local var_87_6 = 0.001

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 then
				local var_87_7 = (arg_84_1.time_ - var_87_5) / var_87_6
				local var_87_8 = Vector3.New(0, 100, 0)

				var_87_4.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1019ui_story, var_87_8, var_87_7)

				local var_87_9 = manager.ui.mainCamera.transform.position - var_87_4.position

				var_87_4.forward = Vector3.New(var_87_9.x, var_87_9.y, var_87_9.z)

				local var_87_10 = var_87_4.localEulerAngles

				var_87_10.z = 0
				var_87_10.x = 0
				var_87_4.localEulerAngles = var_87_10
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 then
				var_87_4.localPosition = Vector3.New(0, 100, 0)

				local var_87_11 = manager.ui.mainCamera.transform.position - var_87_4.position

				var_87_4.forward = Vector3.New(var_87_11.x, var_87_11.y, var_87_11.z)

				local var_87_12 = var_87_4.localEulerAngles

				var_87_12.z = 0
				var_87_12.x = 0
				var_87_4.localEulerAngles = var_87_12
			end

			local var_87_13 = arg_84_1.actors_["1011ui_story"].transform
			local var_87_14 = 0

			if var_87_14 < arg_84_1.time_ and arg_84_1.time_ <= var_87_14 + arg_87_0 then
				arg_84_1.var_.moveOldPos1011ui_story = var_87_13.localPosition
			end

			local var_87_15 = 0.001

			if var_87_14 <= arg_84_1.time_ and arg_84_1.time_ < var_87_14 + var_87_15 then
				local var_87_16 = (arg_84_1.time_ - var_87_14) / var_87_15
				local var_87_17 = Vector3.New(0, -0.71, -6)

				var_87_13.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1011ui_story, var_87_17, var_87_16)

				local var_87_18 = manager.ui.mainCamera.transform.position - var_87_13.position

				var_87_13.forward = Vector3.New(var_87_18.x, var_87_18.y, var_87_18.z)

				local var_87_19 = var_87_13.localEulerAngles

				var_87_19.z = 0
				var_87_19.x = 0
				var_87_13.localEulerAngles = var_87_19
			end

			if arg_84_1.time_ >= var_87_14 + var_87_15 and arg_84_1.time_ < var_87_14 + var_87_15 + arg_87_0 then
				var_87_13.localPosition = Vector3.New(0, -0.71, -6)

				local var_87_20 = manager.ui.mainCamera.transform.position - var_87_13.position

				var_87_13.forward = Vector3.New(var_87_20.x, var_87_20.y, var_87_20.z)

				local var_87_21 = var_87_13.localEulerAngles

				var_87_21.z = 0
				var_87_21.x = 0
				var_87_13.localEulerAngles = var_87_21
			end

			local var_87_22 = 0

			if var_87_22 < arg_84_1.time_ and arg_84_1.time_ <= var_87_22 + arg_87_0 then
				arg_84_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_87_23 = 0

			if var_87_23 < arg_84_1.time_ and arg_84_1.time_ <= var_87_23 + arg_87_0 then
				arg_84_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_87_24 = 0
			local var_87_25 = 0.375

			if var_87_24 < arg_84_1.time_ and arg_84_1.time_ <= var_87_24 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_26 = arg_84_1:FormatText(StoryNameCfg[37].name)

				arg_84_1.leftNameTxt_.text = var_87_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_27 = arg_84_1:GetWordFromCfg(104071021)
				local var_87_28 = arg_84_1:FormatText(var_87_27.content)

				arg_84_1.text_.text = var_87_28

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_29 = 15
				local var_87_30 = utf8.len(var_87_28)
				local var_87_31 = var_87_29 <= 0 and var_87_25 or var_87_25 * (var_87_30 / var_87_29)

				if var_87_31 > 0 and var_87_25 < var_87_31 then
					arg_84_1.talkMaxDuration = var_87_31

					if var_87_31 + var_87_24 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_31 + var_87_24
					end
				end

				arg_84_1.text_.text = var_87_28
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071021", "story_v_out_104071.awb") ~= 0 then
					local var_87_32 = manager.audio:GetVoiceLength("story_v_out_104071", "104071021", "story_v_out_104071.awb") / 1000

					if var_87_32 + var_87_24 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_32 + var_87_24
					end

					if var_87_27.prefab_name ~= "" and arg_84_1.actors_[var_87_27.prefab_name] ~= nil then
						local var_87_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_27.prefab_name].transform, "story_v_out_104071", "104071021", "story_v_out_104071.awb")

						arg_84_1:RecordAudio("104071021", var_87_33)
						arg_84_1:RecordAudio("104071021", var_87_33)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_104071", "104071021", "story_v_out_104071.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_104071", "104071021", "story_v_out_104071.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_34 = math.max(var_87_25, arg_84_1.talkMaxDuration)

			if var_87_24 <= arg_84_1.time_ and arg_84_1.time_ < var_87_24 + var_87_34 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_24) / var_87_34

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_24 + var_87_34 and arg_84_1.time_ < var_87_24 + var_87_34 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play104071022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 104071022
		arg_88_1.duration_ = 4.33

		local var_88_0 = {
			ja = 4.333,
			ko = 4.066,
			zh = 3.533,
			en = 4.133
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
				arg_88_0:Play104071023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1019ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1019ui_story == nil then
				arg_88_1.var_.characterEffect1019ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.1

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect1019ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect1019ui_story then
				arg_88_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_91_4 = arg_88_1.actors_["1011ui_story"]
			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1011ui_story == nil then
				arg_88_1.var_.characterEffect1011ui_story = var_91_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_6 = 0.1

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_6 and not isNil(var_91_4) then
				local var_91_7 = (arg_88_1.time_ - var_91_5) / var_91_6

				if arg_88_1.var_.characterEffect1011ui_story and not isNil(var_91_4) then
					local var_91_8 = Mathf.Lerp(0, 0.5, var_91_7)

					arg_88_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1011ui_story.fillRatio = var_91_8
				end
			end

			if arg_88_1.time_ >= var_91_5 + var_91_6 and arg_88_1.time_ < var_91_5 + var_91_6 + arg_91_0 and not isNil(var_91_4) and arg_88_1.var_.characterEffect1011ui_story then
				local var_91_9 = 0.5

				arg_88_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1011ui_story.fillRatio = var_91_9
			end

			local var_91_10 = arg_88_1.actors_["1011ui_story"].transform
			local var_91_11 = 0

			if var_91_11 < arg_88_1.time_ and arg_88_1.time_ <= var_91_11 + arg_91_0 then
				arg_88_1.var_.moveOldPos1011ui_story = var_91_10.localPosition
			end

			local var_91_12 = 0.001

			if var_91_11 <= arg_88_1.time_ and arg_88_1.time_ < var_91_11 + var_91_12 then
				local var_91_13 = (arg_88_1.time_ - var_91_11) / var_91_12
				local var_91_14 = Vector3.New(0, 100, 0)

				var_91_10.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1011ui_story, var_91_14, var_91_13)

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

			local var_91_19 = arg_88_1.actors_["1019ui_story"].transform
			local var_91_20 = 0

			if var_91_20 < arg_88_1.time_ and arg_88_1.time_ <= var_91_20 + arg_91_0 then
				arg_88_1.var_.moveOldPos1019ui_story = var_91_19.localPosition
			end

			local var_91_21 = 0.001

			if var_91_20 <= arg_88_1.time_ and arg_88_1.time_ < var_91_20 + var_91_21 then
				local var_91_22 = (arg_88_1.time_ - var_91_20) / var_91_21
				local var_91_23 = Vector3.New(-0.2, -1.08, -5.9)

				var_91_19.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1019ui_story, var_91_23, var_91_22)

				local var_91_24 = manager.ui.mainCamera.transform.position - var_91_19.position

				var_91_19.forward = Vector3.New(var_91_24.x, var_91_24.y, var_91_24.z)

				local var_91_25 = var_91_19.localEulerAngles

				var_91_25.z = 0
				var_91_25.x = 0
				var_91_19.localEulerAngles = var_91_25
			end

			if arg_88_1.time_ >= var_91_20 + var_91_21 and arg_88_1.time_ < var_91_20 + var_91_21 + arg_91_0 then
				var_91_19.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_91_26 = manager.ui.mainCamera.transform.position - var_91_19.position

				var_91_19.forward = Vector3.New(var_91_26.x, var_91_26.y, var_91_26.z)

				local var_91_27 = var_91_19.localEulerAngles

				var_91_27.z = 0
				var_91_27.x = 0
				var_91_19.localEulerAngles = var_91_27
			end

			local var_91_28 = 0

			if var_91_28 < arg_88_1.time_ and arg_88_1.time_ <= var_91_28 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_91_29 = 0

			if var_91_29 < arg_88_1.time_ and arg_88_1.time_ <= var_91_29 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_91_30 = 0
			local var_91_31 = 0.45

			if var_91_30 < arg_88_1.time_ and arg_88_1.time_ <= var_91_30 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_32 = arg_88_1:FormatText(StoryNameCfg[13].name)

				arg_88_1.leftNameTxt_.text = var_91_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_33 = arg_88_1:GetWordFromCfg(104071022)
				local var_91_34 = arg_88_1:FormatText(var_91_33.content)

				arg_88_1.text_.text = var_91_34

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_35 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071022", "story_v_out_104071.awb") ~= 0 then
					local var_91_38 = manager.audio:GetVoiceLength("story_v_out_104071", "104071022", "story_v_out_104071.awb") / 1000

					if var_91_38 + var_91_30 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_38 + var_91_30
					end

					if var_91_33.prefab_name ~= "" and arg_88_1.actors_[var_91_33.prefab_name] ~= nil then
						local var_91_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_33.prefab_name].transform, "story_v_out_104071", "104071022", "story_v_out_104071.awb")

						arg_88_1:RecordAudio("104071022", var_91_39)
						arg_88_1:RecordAudio("104071022", var_91_39)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_104071", "104071022", "story_v_out_104071.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_104071", "104071022", "story_v_out_104071.awb")
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
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play104071023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 104071023
		arg_92_1.duration_ = 8.97

		local var_92_0 = {
			ja = 8.133,
			ko = 6.666,
			zh = 7.066,
			en = 8.966
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
				arg_92_0:Play104071024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_95_2 = 0
			local var_95_3 = 1

			if var_95_2 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_4 = arg_92_1:FormatText(StoryNameCfg[13].name)

				arg_92_1.leftNameTxt_.text = var_95_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_5 = arg_92_1:GetWordFromCfg(104071023)
				local var_95_6 = arg_92_1:FormatText(var_95_5.content)

				arg_92_1.text_.text = var_95_6

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_7 = 40
				local var_95_8 = utf8.len(var_95_6)
				local var_95_9 = var_95_7 <= 0 and var_95_3 or var_95_3 * (var_95_8 / var_95_7)

				if var_95_9 > 0 and var_95_3 < var_95_9 then
					arg_92_1.talkMaxDuration = var_95_9

					if var_95_9 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_9 + var_95_2
					end
				end

				arg_92_1.text_.text = var_95_6
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071023", "story_v_out_104071.awb") ~= 0 then
					local var_95_10 = manager.audio:GetVoiceLength("story_v_out_104071", "104071023", "story_v_out_104071.awb") / 1000

					if var_95_10 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_2
					end

					if var_95_5.prefab_name ~= "" and arg_92_1.actors_[var_95_5.prefab_name] ~= nil then
						local var_95_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_5.prefab_name].transform, "story_v_out_104071", "104071023", "story_v_out_104071.awb")

						arg_92_1:RecordAudio("104071023", var_95_11)
						arg_92_1:RecordAudio("104071023", var_95_11)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_104071", "104071023", "story_v_out_104071.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_104071", "104071023", "story_v_out_104071.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_12 = math.max(var_95_3, arg_92_1.talkMaxDuration)

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_12 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_2) / var_95_12

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_2 + var_95_12 and arg_92_1.time_ < var_95_2 + var_95_12 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play104071024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 104071024
		arg_96_1.duration_ = 6.5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play104071025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.bgs_.B06a
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				local var_99_2 = var_99_0:GetComponent("SpriteRenderer")

				if var_99_2 then
					arg_96_1.var_.alphaOldValueB06a = var_99_2.color.a
					arg_96_1.var_.alphaMatValueB06a = var_99_2
				end

				arg_96_1.var_.alphaOldValueB06a = 1
			end

			local var_99_3 = 1.5

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_3 then
				local var_99_4 = (arg_96_1.time_ - var_99_1) / var_99_3
				local var_99_5 = Mathf.Lerp(arg_96_1.var_.alphaOldValueB06a, 0, var_99_4)

				if arg_96_1.var_.alphaMatValueB06a then
					local var_99_6 = arg_96_1.var_.alphaMatValueB06a.color

					var_99_6.a = var_99_5
					arg_96_1.var_.alphaMatValueB06a.color = var_99_6
				end
			end

			if arg_96_1.time_ >= var_99_1 + var_99_3 and arg_96_1.time_ < var_99_1 + var_99_3 + arg_99_0 and arg_96_1.var_.alphaMatValueB06a then
				local var_99_7 = arg_96_1.var_.alphaMatValueB06a
				local var_99_8 = var_99_7.color

				var_99_8.a = 0
				var_99_7.color = var_99_8
			end

			local var_99_9 = arg_96_1.bgs_.B06a.transform
			local var_99_10 = 1.5

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1.var_.moveOldPosB06a = var_99_9.localPosition
			end

			local var_99_11 = 0.001

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_11 then
				local var_99_12 = (arg_96_1.time_ - var_99_10) / var_99_11
				local var_99_13 = Vector3.New(0, -100, 10)

				var_99_9.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPosB06a, var_99_13, var_99_12)
			end

			if arg_96_1.time_ >= var_99_10 + var_99_11 and arg_96_1.time_ < var_99_10 + var_99_11 + arg_99_0 then
				var_99_9.localPosition = Vector3.New(0, -100, 10)
			end

			local var_99_14 = "A00"

			if arg_96_1.bgs_[var_99_14] == nil then
				local var_99_15 = Object.Instantiate(arg_96_1.paintGo_)

				var_99_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_99_14)
				var_99_15.name = var_99_14
				var_99_15.transform.parent = arg_96_1.stage_.transform
				var_99_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.bgs_[var_99_14] = var_99_15
			end

			local var_99_16 = arg_96_1.bgs_.A00
			local var_99_17 = 1.5

			if var_99_17 < arg_96_1.time_ and arg_96_1.time_ <= var_99_17 + arg_99_0 then
				local var_99_18 = var_99_16:GetComponent("SpriteRenderer")

				if var_99_18 then
					arg_96_1.var_.alphaOldValueA00 = var_99_18.color.a
					arg_96_1.var_.alphaMatValueA00 = var_99_18
				end

				arg_96_1.var_.alphaOldValueA00 = 0
			end

			local var_99_19 = 1.5

			if var_99_17 <= arg_96_1.time_ and arg_96_1.time_ < var_99_17 + var_99_19 then
				local var_99_20 = (arg_96_1.time_ - var_99_17) / var_99_19
				local var_99_21 = Mathf.Lerp(arg_96_1.var_.alphaOldValueA00, 1, var_99_20)

				if arg_96_1.var_.alphaMatValueA00 then
					local var_99_22 = arg_96_1.var_.alphaMatValueA00.color

					var_99_22.a = var_99_21
					arg_96_1.var_.alphaMatValueA00.color = var_99_22
				end
			end

			if arg_96_1.time_ >= var_99_17 + var_99_19 and arg_96_1.time_ < var_99_17 + var_99_19 + arg_99_0 and arg_96_1.var_.alphaMatValueA00 then
				local var_99_23 = arg_96_1.var_.alphaMatValueA00
				local var_99_24 = var_99_23.color

				var_99_24.a = 1
				var_99_23.color = var_99_24
			end

			local var_99_25 = 1.5

			if var_99_25 < arg_96_1.time_ and arg_96_1.time_ <= var_99_25 + arg_99_0 then
				local var_99_26 = manager.ui.mainCamera.transform.localPosition
				local var_99_27 = Vector3.New(0, 0, 10) + Vector3.New(var_99_26.x, var_99_26.y, 0)
				local var_99_28 = arg_96_1.bgs_.A00

				var_99_28.transform.localPosition = var_99_27
				var_99_28.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_99_29 = var_99_28:GetComponent("SpriteRenderer")

				if var_99_29 and var_99_29.sprite then
					local var_99_30 = (var_99_28.transform.localPosition - var_99_26).z
					local var_99_31 = manager.ui.mainCameraCom_
					local var_99_32 = 2 * var_99_30 * Mathf.Tan(var_99_31.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_99_33 = var_99_32 * var_99_31.aspect
					local var_99_34 = var_99_29.sprite.bounds.size.x
					local var_99_35 = var_99_29.sprite.bounds.size.y
					local var_99_36 = var_99_33 / var_99_34
					local var_99_37 = var_99_32 / var_99_35
					local var_99_38 = var_99_37 < var_99_36 and var_99_36 or var_99_37

					var_99_28.transform.localScale = Vector3.New(var_99_38, var_99_38, 0)
				end

				for iter_99_0, iter_99_1 in pairs(arg_96_1.bgs_) do
					if iter_99_0 ~= "A00" then
						iter_99_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_99_39 = arg_96_1.actors_["1019ui_story"].transform
			local var_99_40 = 0

			if var_99_40 < arg_96_1.time_ and arg_96_1.time_ <= var_99_40 + arg_99_0 then
				arg_96_1.var_.moveOldPos1019ui_story = var_99_39.localPosition
			end

			local var_99_41 = 0.001

			if var_99_40 <= arg_96_1.time_ and arg_96_1.time_ < var_99_40 + var_99_41 then
				local var_99_42 = (arg_96_1.time_ - var_99_40) / var_99_41
				local var_99_43 = Vector3.New(0, 100, 0)

				var_99_39.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1019ui_story, var_99_43, var_99_42)

				local var_99_44 = manager.ui.mainCamera.transform.position - var_99_39.position

				var_99_39.forward = Vector3.New(var_99_44.x, var_99_44.y, var_99_44.z)

				local var_99_45 = var_99_39.localEulerAngles

				var_99_45.z = 0
				var_99_45.x = 0
				var_99_39.localEulerAngles = var_99_45
			end

			if arg_96_1.time_ >= var_99_40 + var_99_41 and arg_96_1.time_ < var_99_40 + var_99_41 + arg_99_0 then
				var_99_39.localPosition = Vector3.New(0, 100, 0)

				local var_99_46 = manager.ui.mainCamera.transform.position - var_99_39.position

				var_99_39.forward = Vector3.New(var_99_46.x, var_99_46.y, var_99_46.z)

				local var_99_47 = var_99_39.localEulerAngles

				var_99_47.z = 0
				var_99_47.x = 0
				var_99_39.localEulerAngles = var_99_47
			end

			local var_99_48 = 0

			if var_99_48 < arg_96_1.time_ and arg_96_1.time_ <= var_99_48 + arg_99_0 then
				arg_96_1.allBtn_.enabled = false
			end

			local var_99_49 = 1.5

			if arg_96_1.time_ >= var_99_48 + var_99_49 and arg_96_1.time_ < var_99_48 + var_99_49 + arg_99_0 then
				arg_96_1.allBtn_.enabled = true
			end

			local var_99_50 = 1.5
			local var_99_51 = 0.275

			if var_99_50 < arg_96_1.time_ and arg_96_1.time_ <= var_99_50 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_52 = arg_96_1:GetWordFromCfg(104071024)
				local var_99_53 = arg_96_1:FormatText(var_99_52.content)

				arg_96_1.text_.text = var_99_53

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_54 = 11
				local var_99_55 = utf8.len(var_99_53)
				local var_99_56 = var_99_54 <= 0 and var_99_51 or var_99_51 * (var_99_55 / var_99_54)

				if var_99_56 > 0 and var_99_51 < var_99_56 then
					arg_96_1.talkMaxDuration = var_99_56

					if var_99_56 + var_99_50 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_56 + var_99_50
					end
				end

				arg_96_1.text_.text = var_99_53
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_57 = math.max(var_99_51, arg_96_1.talkMaxDuration)

			if var_99_50 <= arg_96_1.time_ and arg_96_1.time_ < var_99_50 + var_99_57 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_50) / var_99_57

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_50 + var_99_57 and arg_96_1.time_ < var_99_50 + var_99_57 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B06a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
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
	Play104071025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 104071025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play104071026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.45

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:GetWordFromCfg(104071025)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 18
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_8 and arg_100_1.time_ < var_103_0 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play104071026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 104071026
		arg_104_1.duration_ = 9.37

		local var_104_0 = {
			ja = 9.366,
			ko = 6.966,
			zh = 5.7,
			en = 9.333
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play104071027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0
			local var_107_1 = 0.725

			if var_107_0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_2 = arg_104_1:FormatText(StoryNameCfg[10].name)

				arg_104_1.leftNameTxt_.text = var_107_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_3 = arg_104_1:GetWordFromCfg(104071026)
				local var_107_4 = arg_104_1:FormatText(var_107_3.content)

				arg_104_1.text_.text = var_107_4

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_5 = 29
				local var_107_6 = utf8.len(var_107_4)
				local var_107_7 = var_107_5 <= 0 and var_107_1 or var_107_1 * (var_107_6 / var_107_5)

				if var_107_7 > 0 and var_107_1 < var_107_7 then
					arg_104_1.talkMaxDuration = var_107_7

					if var_107_7 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_7 + var_107_0
					end
				end

				arg_104_1.text_.text = var_107_4
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071026", "story_v_out_104071.awb") ~= 0 then
					local var_107_8 = manager.audio:GetVoiceLength("story_v_out_104071", "104071026", "story_v_out_104071.awb") / 1000

					if var_107_8 + var_107_0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_8 + var_107_0
					end

					if var_107_3.prefab_name ~= "" and arg_104_1.actors_[var_107_3.prefab_name] ~= nil then
						local var_107_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_3.prefab_name].transform, "story_v_out_104071", "104071026", "story_v_out_104071.awb")

						arg_104_1:RecordAudio("104071026", var_107_9)
						arg_104_1:RecordAudio("104071026", var_107_9)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_104071", "104071026", "story_v_out_104071.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_104071", "104071026", "story_v_out_104071.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_10 = math.max(var_107_1, arg_104_1.talkMaxDuration)

			if var_107_0 <= arg_104_1.time_ and arg_104_1.time_ < var_107_0 + var_107_10 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_0) / var_107_10

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_0 + var_107_10 and arg_104_1.time_ < var_107_0 + var_107_10 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play104071027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 104071027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play104071028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0
			local var_111_1 = 0.125

			if var_111_0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_2 = arg_108_1:FormatText(StoryNameCfg[7].name)

				arg_108_1.leftNameTxt_.text = var_111_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_3 = arg_108_1:GetWordFromCfg(104071027)
				local var_111_4 = arg_108_1:FormatText(var_111_3.content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 5
				local var_111_6 = utf8.len(var_111_4)
				local var_111_7 = var_111_5 <= 0 and var_111_1 or var_111_1 * (var_111_6 / var_111_5)

				if var_111_7 > 0 and var_111_1 < var_111_7 then
					arg_108_1.talkMaxDuration = var_111_7

					if var_111_7 + var_111_0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_7 + var_111_0
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_8 = math.max(var_111_1, arg_108_1.talkMaxDuration)

			if var_111_0 <= arg_108_1.time_ and arg_108_1.time_ < var_111_0 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_0) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_0 + var_111_8 and arg_108_1.time_ < var_111_0 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play104071028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 104071028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play104071029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = manager.ui.mainCamera.transform
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 then
				arg_112_1.var_.shakeOldPosMainCamera = var_115_0.localPosition
			end

			local var_115_2 = 0.600000023841858

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / 0.066
				local var_115_4, var_115_5 = math.modf(var_115_3)

				var_115_0.localPosition = Vector3.New(var_115_5 * 0.13, var_115_5 * 0.13, var_115_5 * 0.13) + arg_112_1.var_.shakeOldPosMainCamera
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 then
				var_115_0.localPosition = arg_112_1.var_.shakeOldPosMainCamera
			end

			local var_115_6 = 0
			local var_115_7 = 1.225

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_8 = arg_112_1:GetWordFromCfg(104071028)
				local var_115_9 = arg_112_1:FormatText(var_115_8.content)

				arg_112_1.text_.text = var_115_9

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_10 = 49
				local var_115_11 = utf8.len(var_115_9)
				local var_115_12 = var_115_10 <= 0 and var_115_7 or var_115_7 * (var_115_11 / var_115_10)

				if var_115_12 > 0 and var_115_7 < var_115_12 then
					arg_112_1.talkMaxDuration = var_115_12

					if var_115_12 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_12 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_9
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_13 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_13 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_13

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_13 and arg_112_1.time_ < var_115_6 + var_115_13 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play104071029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 104071029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play104071030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0
			local var_119_1 = 1

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_2 = arg_116_1:GetWordFromCfg(104071029)
				local var_119_3 = arg_116_1:FormatText(var_119_2.content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 40
				local var_119_5 = utf8.len(var_119_3)
				local var_119_6 = var_119_4 <= 0 and var_119_1 or var_119_1 * (var_119_5 / var_119_4)

				if var_119_6 > 0 and var_119_1 < var_119_6 then
					arg_116_1.talkMaxDuration = var_119_6

					if var_119_6 + var_119_0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_6 + var_119_0
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_1, arg_116_1.talkMaxDuration)

			if var_119_0 <= arg_116_1.time_ and arg_116_1.time_ < var_119_0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_0 + var_119_7 and arg_116_1.time_ < var_119_0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play104071030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 104071030
		arg_120_1.duration_ = 8.6

		local var_120_0 = {
			ja = 8.3,
			ko = 8.6,
			zh = 8.066,
			en = 8.6
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
				arg_120_0:Play104071031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0
			local var_123_1 = 0.9

			if var_123_0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_2 = arg_120_1:FormatText(StoryNameCfg[10].name)

				arg_120_1.leftNameTxt_.text = var_123_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_3 = arg_120_1:GetWordFromCfg(104071030)
				local var_123_4 = arg_120_1:FormatText(var_123_3.content)

				arg_120_1.text_.text = var_123_4

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_5 = 36
				local var_123_6 = utf8.len(var_123_4)
				local var_123_7 = var_123_5 <= 0 and var_123_1 or var_123_1 * (var_123_6 / var_123_5)

				if var_123_7 > 0 and var_123_1 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_0
					end
				end

				arg_120_1.text_.text = var_123_4
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071030", "story_v_out_104071.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_104071", "104071030", "story_v_out_104071.awb") / 1000

					if var_123_8 + var_123_0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_0
					end

					if var_123_3.prefab_name ~= "" and arg_120_1.actors_[var_123_3.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_3.prefab_name].transform, "story_v_out_104071", "104071030", "story_v_out_104071.awb")

						arg_120_1:RecordAudio("104071030", var_123_9)
						arg_120_1:RecordAudio("104071030", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_104071", "104071030", "story_v_out_104071.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_104071", "104071030", "story_v_out_104071.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_1, arg_120_1.talkMaxDuration)

			if var_123_0 <= arg_120_1.time_ and arg_120_1.time_ < var_123_0 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_0) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_0 + var_123_10 and arg_120_1.time_ < var_123_0 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play104071031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 104071031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play104071032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0
			local var_127_1 = 0.475

			if var_127_0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_2 = arg_124_1:FormatText(StoryNameCfg[7].name)

				arg_124_1.leftNameTxt_.text = var_127_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_3 = arg_124_1:GetWordFromCfg(104071031)
				local var_127_4 = arg_124_1:FormatText(var_127_3.content)

				arg_124_1.text_.text = var_127_4

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 19
				local var_127_6 = utf8.len(var_127_4)
				local var_127_7 = var_127_5 <= 0 and var_127_1 or var_127_1 * (var_127_6 / var_127_5)

				if var_127_7 > 0 and var_127_1 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_4
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_8 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_8 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_8

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_8 and arg_124_1.time_ < var_127_0 + var_127_8 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play104071032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 104071032
		arg_128_1.duration_ = 14.03

		local var_128_0 = {
			ja = 14.033,
			ko = 11.266,
			zh = 9,
			en = 11.166
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
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play104071033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = "1037ui_story"

			if arg_128_1.actors_[var_131_0] == nil then
				local var_131_1 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_131_1) then
					local var_131_2 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_128_1.stage_.transform)

					var_131_2.name = var_131_0
					var_131_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_128_1.actors_[var_131_0] = var_131_2

					local var_131_3 = var_131_2:GetComponentInChildren(typeof(CharacterEffect))

					var_131_3.enabled = true

					local var_131_4 = GameObjectTools.GetOrAddComponent(var_131_2, typeof(DynamicBoneHelper))

					if var_131_4 then
						var_131_4:EnableDynamicBone(false)
					end

					arg_128_1:ShowWeapon(var_131_3.transform, false)

					arg_128_1.var_[var_131_0 .. "Animator"] = var_131_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_128_1.var_[var_131_0 .. "Animator"].applyRootMotion = true
					arg_128_1.var_[var_131_0 .. "LipSync"] = var_131_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_131_5 = arg_128_1.actors_["1037ui_story"]
			local var_131_6 = 0

			if var_131_6 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 and not isNil(var_131_5) and arg_128_1.var_.characterEffect1037ui_story == nil then
				arg_128_1.var_.characterEffect1037ui_story = var_131_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_7 = 0.1

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_7 and not isNil(var_131_5) then
				local var_131_8 = (arg_128_1.time_ - var_131_6) / var_131_7

				if arg_128_1.var_.characterEffect1037ui_story and not isNil(var_131_5) then
					arg_128_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_6 + var_131_7 and arg_128_1.time_ < var_131_6 + var_131_7 + arg_131_0 and not isNil(var_131_5) and arg_128_1.var_.characterEffect1037ui_story then
				arg_128_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_131_9 = arg_128_1.actors_["1037ui_story"].transform
			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 then
				arg_128_1.var_.moveOldPos1037ui_story = var_131_9.localPosition
			end

			local var_131_11 = 0.001

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_11 then
				local var_131_12 = (arg_128_1.time_ - var_131_10) / var_131_11
				local var_131_13 = Vector3.New(0, -1.09, -5.81)

				var_131_9.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1037ui_story, var_131_13, var_131_12)

				local var_131_14 = manager.ui.mainCamera.transform.position - var_131_9.position

				var_131_9.forward = Vector3.New(var_131_14.x, var_131_14.y, var_131_14.z)

				local var_131_15 = var_131_9.localEulerAngles

				var_131_15.z = 0
				var_131_15.x = 0
				var_131_9.localEulerAngles = var_131_15
			end

			if arg_128_1.time_ >= var_131_10 + var_131_11 and arg_128_1.time_ < var_131_10 + var_131_11 + arg_131_0 then
				var_131_9.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_131_16 = manager.ui.mainCamera.transform.position - var_131_9.position

				var_131_9.forward = Vector3.New(var_131_16.x, var_131_16.y, var_131_16.z)

				local var_131_17 = var_131_9.localEulerAngles

				var_131_17.z = 0
				var_131_17.x = 0
				var_131_9.localEulerAngles = var_131_17
			end

			local var_131_18 = 0

			if var_131_18 < arg_128_1.time_ and arg_128_1.time_ <= var_131_18 + arg_131_0 then
				arg_128_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_1")
			end

			local var_131_19 = 0

			if var_131_19 < arg_128_1.time_ and arg_128_1.time_ <= var_131_19 + arg_131_0 then
				arg_128_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_131_20 = 0
			local var_131_21 = 1.125

			if var_131_20 < arg_128_1.time_ and arg_128_1.time_ <= var_131_20 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_22 = arg_128_1:FormatText(StoryNameCfg[15].name)

				arg_128_1.leftNameTxt_.text = var_131_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_23 = arg_128_1:GetWordFromCfg(104071032)
				local var_131_24 = arg_128_1:FormatText(var_131_23.content)

				arg_128_1.text_.text = var_131_24

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_25 = 45
				local var_131_26 = utf8.len(var_131_24)
				local var_131_27 = var_131_25 <= 0 and var_131_21 or var_131_21 * (var_131_26 / var_131_25)

				if var_131_27 > 0 and var_131_21 < var_131_27 then
					arg_128_1.talkMaxDuration = var_131_27

					if var_131_27 + var_131_20 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_27 + var_131_20
					end
				end

				arg_128_1.text_.text = var_131_24
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071032", "story_v_out_104071.awb") ~= 0 then
					local var_131_28 = manager.audio:GetVoiceLength("story_v_out_104071", "104071032", "story_v_out_104071.awb") / 1000

					if var_131_28 + var_131_20 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_28 + var_131_20
					end

					if var_131_23.prefab_name ~= "" and arg_128_1.actors_[var_131_23.prefab_name] ~= nil then
						local var_131_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_23.prefab_name].transform, "story_v_out_104071", "104071032", "story_v_out_104071.awb")

						arg_128_1:RecordAudio("104071032", var_131_29)
						arg_128_1:RecordAudio("104071032", var_131_29)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_104071", "104071032", "story_v_out_104071.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_104071", "104071032", "story_v_out_104071.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_30 = math.max(var_131_21, arg_128_1.talkMaxDuration)

			if var_131_20 <= arg_128_1.time_ and arg_128_1.time_ < var_131_20 + var_131_30 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_20) / var_131_30

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_20 + var_131_30 and arg_128_1.time_ < var_131_20 + var_131_30 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play104071033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 104071033
		arg_132_1.duration_ = 10.3

		local var_132_0 = {
			ja = 10.3,
			ko = 5.533,
			zh = 4.8,
			en = 7.2
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play104071034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1037ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1037ui_story == nil then
				arg_132_1.var_.characterEffect1037ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.1

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1037ui_story and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1037ui_story.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1037ui_story then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1037ui_story.fillRatio = var_135_5
			end

			local var_135_6 = 0
			local var_135_7 = 0.625

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_8 = arg_132_1:FormatText(StoryNameCfg[10].name)

				arg_132_1.leftNameTxt_.text = var_135_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_9 = arg_132_1:GetWordFromCfg(104071033)
				local var_135_10 = arg_132_1:FormatText(var_135_9.content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 25
				local var_135_12 = utf8.len(var_135_10)
				local var_135_13 = var_135_11 <= 0 and var_135_7 or var_135_7 * (var_135_12 / var_135_11)

				if var_135_13 > 0 and var_135_7 < var_135_13 then
					arg_132_1.talkMaxDuration = var_135_13

					if var_135_13 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_13 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_10
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071033", "story_v_out_104071.awb") ~= 0 then
					local var_135_14 = manager.audio:GetVoiceLength("story_v_out_104071", "104071033", "story_v_out_104071.awb") / 1000

					if var_135_14 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_14 + var_135_6
					end

					if var_135_9.prefab_name ~= "" and arg_132_1.actors_[var_135_9.prefab_name] ~= nil then
						local var_135_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_9.prefab_name].transform, "story_v_out_104071", "104071033", "story_v_out_104071.awb")

						arg_132_1:RecordAudio("104071033", var_135_15)
						arg_132_1:RecordAudio("104071033", var_135_15)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_104071", "104071033", "story_v_out_104071.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_104071", "104071033", "story_v_out_104071.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_16 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_16 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_16

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_16 and arg_132_1.time_ < var_135_6 + var_135_16 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play104071034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 104071034
		arg_136_1.duration_ = 6.4

		local var_136_0 = {
			ja = 6.4,
			ko = 2.6,
			zh = 2.333,
			en = 3.033
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play104071035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1037ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1037ui_story == nil then
				arg_136_1.var_.characterEffect1037ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.1

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1037ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1037ui_story then
				arg_136_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_139_4 = 0

			if var_139_4 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action456")
			end

			local var_139_5 = 0

			if var_139_5 < arg_136_1.time_ and arg_136_1.time_ <= var_139_5 + arg_139_0 then
				arg_136_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_139_6 = 0
			local var_139_7 = 0.275

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_8 = arg_136_1:FormatText(StoryNameCfg[15].name)

				arg_136_1.leftNameTxt_.text = var_139_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_9 = arg_136_1:GetWordFromCfg(104071034)
				local var_139_10 = arg_136_1:FormatText(var_139_9.content)

				arg_136_1.text_.text = var_139_10

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 11
				local var_139_12 = utf8.len(var_139_10)
				local var_139_13 = var_139_11 <= 0 and var_139_7 or var_139_7 * (var_139_12 / var_139_11)

				if var_139_13 > 0 and var_139_7 < var_139_13 then
					arg_136_1.talkMaxDuration = var_139_13

					if var_139_13 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_13 + var_139_6
					end
				end

				arg_136_1.text_.text = var_139_10
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071034", "story_v_out_104071.awb") ~= 0 then
					local var_139_14 = manager.audio:GetVoiceLength("story_v_out_104071", "104071034", "story_v_out_104071.awb") / 1000

					if var_139_14 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_14 + var_139_6
					end

					if var_139_9.prefab_name ~= "" and arg_136_1.actors_[var_139_9.prefab_name] ~= nil then
						local var_139_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_9.prefab_name].transform, "story_v_out_104071", "104071034", "story_v_out_104071.awb")

						arg_136_1:RecordAudio("104071034", var_139_15)
						arg_136_1:RecordAudio("104071034", var_139_15)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_104071", "104071034", "story_v_out_104071.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_104071", "104071034", "story_v_out_104071.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_16 = math.max(var_139_7, arg_136_1.talkMaxDuration)

			if var_139_6 <= arg_136_1.time_ and arg_136_1.time_ < var_139_6 + var_139_16 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_6) / var_139_16

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_6 + var_139_16 and arg_136_1.time_ < var_139_6 + var_139_16 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play104071035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 104071035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play104071036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1037ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1037ui_story == nil then
				arg_140_1.var_.characterEffect1037ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.1

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1037ui_story and not isNil(var_143_0) then
					local var_143_4 = Mathf.Lerp(0, 0.5, var_143_3)

					arg_140_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1037ui_story.fillRatio = var_143_4
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1037ui_story then
				local var_143_5 = 0.5

				arg_140_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1037ui_story.fillRatio = var_143_5
			end

			local var_143_6 = arg_140_1.actors_["1037ui_story"].transform
			local var_143_7 = 0

			if var_143_7 < arg_140_1.time_ and arg_140_1.time_ <= var_143_7 + arg_143_0 then
				arg_140_1.var_.moveOldPos1037ui_story = var_143_6.localPosition
			end

			local var_143_8 = 0.001

			if var_143_7 <= arg_140_1.time_ and arg_140_1.time_ < var_143_7 + var_143_8 then
				local var_143_9 = (arg_140_1.time_ - var_143_7) / var_143_8
				local var_143_10 = Vector3.New(0, 100, 0)

				var_143_6.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1037ui_story, var_143_10, var_143_9)

				local var_143_11 = manager.ui.mainCamera.transform.position - var_143_6.position

				var_143_6.forward = Vector3.New(var_143_11.x, var_143_11.y, var_143_11.z)

				local var_143_12 = var_143_6.localEulerAngles

				var_143_12.z = 0
				var_143_12.x = 0
				var_143_6.localEulerAngles = var_143_12
			end

			if arg_140_1.time_ >= var_143_7 + var_143_8 and arg_140_1.time_ < var_143_7 + var_143_8 + arg_143_0 then
				var_143_6.localPosition = Vector3.New(0, 100, 0)

				local var_143_13 = manager.ui.mainCamera.transform.position - var_143_6.position

				var_143_6.forward = Vector3.New(var_143_13.x, var_143_13.y, var_143_13.z)

				local var_143_14 = var_143_6.localEulerAngles

				var_143_14.z = 0
				var_143_14.x = 0
				var_143_6.localEulerAngles = var_143_14
			end

			local var_143_15 = 0
			local var_143_16 = 0.075

			if var_143_15 < arg_140_1.time_ and arg_140_1.time_ <= var_143_15 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_17 = arg_140_1:FormatText(StoryNameCfg[7].name)

				arg_140_1.leftNameTxt_.text = var_143_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_18 = arg_140_1:GetWordFromCfg(104071035)
				local var_143_19 = arg_140_1:FormatText(var_143_18.content)

				arg_140_1.text_.text = var_143_19

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_20 = 3
				local var_143_21 = utf8.len(var_143_19)
				local var_143_22 = var_143_20 <= 0 and var_143_16 or var_143_16 * (var_143_21 / var_143_20)

				if var_143_22 > 0 and var_143_16 < var_143_22 then
					arg_140_1.talkMaxDuration = var_143_22

					if var_143_22 + var_143_15 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_22 + var_143_15
					end
				end

				arg_140_1.text_.text = var_143_19
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_23 = math.max(var_143_16, arg_140_1.talkMaxDuration)

			if var_143_15 <= arg_140_1.time_ and arg_140_1.time_ < var_143_15 + var_143_23 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_15) / var_143_23

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_15 + var_143_23 and arg_140_1.time_ < var_143_15 + var_143_23 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play104071036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 104071036
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
			arg_144_1.auto_ = false
		end

		function arg_144_1.playNext_(arg_146_0)
			arg_144_1.onStoryFinished_()
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0
			local var_147_1 = 0.425

			if var_147_0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_2 = arg_144_1:FormatText(StoryNameCfg[7].name)

				arg_144_1.leftNameTxt_.text = var_147_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:GetWordFromCfg(104071036)
				local var_147_4 = arg_144_1:FormatText(var_147_3.content)

				arg_144_1.text_.text = var_147_4

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 17
				local var_147_6 = utf8.len(var_147_4)
				local var_147_7 = var_147_5 <= 0 and var_147_1 or var_147_1 * (var_147_6 / var_147_5)

				if var_147_7 > 0 and var_147_1 < var_147_7 then
					arg_144_1.talkMaxDuration = var_147_7

					if var_147_7 + var_147_0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_7 + var_147_0
					end
				end

				arg_144_1.text_.text = var_147_4
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_8 = math.max(var_147_1, arg_144_1.talkMaxDuration)

			if var_147_0 <= arg_144_1.time_ and arg_144_1.time_ < var_147_0 + var_147_8 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_0) / var_147_8

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_0 + var_147_8 and arg_144_1.time_ < var_147_0 + var_147_8 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B06a",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_out_104071.awb"
	}
}
