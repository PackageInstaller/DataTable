return {
	Play102112001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 102112001
		arg_1_1.duration_ = 6.7

		local var_1_0 = {
			ja = 6.7,
			ko = 6.366,
			zh = 4.933,
			en = 4.5
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
				arg_1_0:Play102112002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 0
			local var_4_1 = 1

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				local var_4_2 = "play"
				local var_4_3 = "music"

				arg_1_1:AudioAction(var_4_2, var_4_3, "bgm_victory_count", "bgm_count", "bgm_victory_count")

				local var_4_4 = ""
				local var_4_5 = manager.audio:GetAudioName("bgm_victory_count", "bgm_count")

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

			local var_4_10 = "3009ui_story"

			if arg_1_1.actors_[var_4_10] == nil then
				local var_4_11 = Asset.Load("Char/" .. "3009ui_story")

				if not isNil(var_4_11) then
					local var_4_12 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_1_1.stage_.transform)

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

			local var_4_15 = arg_1_1.actors_["3009ui_story"]
			local var_4_16 = 1.8

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect3009ui_story == nil then
				arg_1_1.var_.characterEffect3009ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_17 = 0.1

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 and not isNil(var_4_15) then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17

				if arg_1_1.var_.characterEffect3009ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect3009ui_story then
				arg_1_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_4_19 = "B08b"

			if arg_1_1.bgs_[var_4_19] == nil then
				local var_4_20 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_20:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_19)
				var_4_20.name = var_4_19
				var_4_20.transform.parent = arg_1_1.stage_.transform
				var_4_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_19] = var_4_20
			end

			local var_4_21 = 0

			if var_4_21 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				local var_4_22 = manager.ui.mainCamera.transform.localPosition
				local var_4_23 = Vector3.New(0, 0, 10) + Vector3.New(var_4_22.x, var_4_22.y, 0)
				local var_4_24 = arg_1_1.bgs_.B08b

				var_4_24.transform.localPosition = var_4_23
				var_4_24.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_25 = var_4_24:GetComponent("SpriteRenderer")

				if var_4_25 and var_4_25.sprite then
					local var_4_26 = (var_4_24.transform.localPosition - var_4_22).z
					local var_4_27 = manager.ui.mainCameraCom_
					local var_4_28 = 2 * var_4_26 * Mathf.Tan(var_4_27.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_29 = var_4_28 * var_4_27.aspect
					local var_4_30 = var_4_25.sprite.bounds.size.x
					local var_4_31 = var_4_25.sprite.bounds.size.y
					local var_4_32 = var_4_29 / var_4_30
					local var_4_33 = var_4_28 / var_4_31
					local var_4_34 = var_4_33 < var_4_32 and var_4_32 or var_4_33

					var_4_24.transform.localScale = Vector3.New(var_4_34, var_4_34, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B08b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_35 = arg_1_1.actors_["3009ui_story"].transform
			local var_4_36 = 1.79999995231628

			if var_4_36 < arg_1_1.time_ and arg_1_1.time_ <= var_4_36 + arg_4_0 then
				arg_1_1.var_.moveOldPos3009ui_story = var_4_35.localPosition

				local var_4_37 = "3009ui_story"

				arg_1_1:ShowWeapon(arg_1_1.var_[var_4_37 .. "Animator"].transform, true)
			end

			local var_4_38 = 0.001

			if var_4_36 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_38 then
				local var_4_39 = (arg_1_1.time_ - var_4_36) / var_4_38
				local var_4_40 = Vector3.New(-0.7, -1.75, -4.8)

				var_4_35.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos3009ui_story, var_4_40, var_4_39)

				local var_4_41 = manager.ui.mainCamera.transform.position - var_4_35.position

				var_4_35.forward = Vector3.New(var_4_41.x, var_4_41.y, var_4_41.z)

				local var_4_42 = var_4_35.localEulerAngles

				var_4_42.z = 0
				var_4_42.x = 0
				var_4_35.localEulerAngles = var_4_42
			end

			if arg_1_1.time_ >= var_4_36 + var_4_38 and arg_1_1.time_ < var_4_36 + var_4_38 + arg_4_0 then
				var_4_35.localPosition = Vector3.New(-0.7, -1.75, -4.8)

				local var_4_43 = manager.ui.mainCamera.transform.position - var_4_35.position

				var_4_35.forward = Vector3.New(var_4_43.x, var_4_43.y, var_4_43.z)

				local var_4_44 = var_4_35.localEulerAngles

				var_4_44.z = 0
				var_4_44.x = 0
				var_4_35.localEulerAngles = var_4_44
			end

			local var_4_45 = 1.8

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_1")
			end

			local var_4_46 = 0

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_47 = 2

			if var_4_46 <= arg_1_1.time_ and arg_1_1.time_ < var_4_46 + var_4_47 then
				local var_4_48 = (arg_1_1.time_ - var_4_46) / var_4_47
				local var_4_49 = Color.New(0, 0, 0)

				var_4_49.a = Mathf.Lerp(1, 0, var_4_48)
				arg_1_1.mask_.color = var_4_49
			end

			if arg_1_1.time_ >= var_4_46 + var_4_47 and arg_1_1.time_ < var_4_46 + var_4_47 + arg_4_0 then
				local var_4_50 = Color.New(0, 0, 0)
				local var_4_51 = 0

				arg_1_1.mask_.enabled = false
				var_4_50.a = var_4_51
				arg_1_1.mask_.color = var_4_50
			end

			local var_4_52 = 1.8

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_53 = 2
			local var_4_54 = 0.375

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

				local var_4_56 = arg_1_1:FormatText(StoryNameCfg[43].name)

				arg_1_1.leftNameTxt_.text = var_4_56

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_57 = arg_1_1:GetWordFromCfg(102112001)
				local var_4_58 = arg_1_1:FormatText(var_4_57.content)

				arg_1_1.text_.text = var_4_58

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_59 = 15
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

				if manager.audio:GetVoiceLength("story_v_out_102112", "102112001", "story_v_out_102112.awb") ~= 0 then
					local var_4_62 = manager.audio:GetVoiceLength("story_v_out_102112", "102112001", "story_v_out_102112.awb") / 1000

					if var_4_62 + var_4_53 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_53
					end

					if var_4_57.prefab_name ~= "" and arg_1_1.actors_[var_4_57.prefab_name] ~= nil then
						local var_4_63 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_57.prefab_name].transform, "story_v_out_102112", "102112001", "story_v_out_102112.awb")

						arg_1_1:RecordAudio("102112001", var_4_63)
						arg_1_1:RecordAudio("102112001", var_4_63)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_102112", "102112001", "story_v_out_102112.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_102112", "102112001", "story_v_out_102112.awb")
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
				actorName = "3009ui_story",
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
	Play102112002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 102112002
		arg_8_1.duration_ = 8.37

		local var_8_0 = {
			ja = 3.9,
			ko = 6.933,
			zh = 6.5,
			en = 8.366
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
				arg_8_0:Play102112003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "3008ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "3008ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["3008ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect3008ui_story == nil then
				arg_8_1.var_.characterEffect3008ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect3008ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect3008ui_story then
				arg_8_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["3009ui_story"]
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect3009ui_story == nil then
				arg_8_1.var_.characterEffect3009ui_story = var_11_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.1

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 and not isNil(var_11_9) then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11

				if arg_8_1.var_.characterEffect3009ui_story and not isNil(var_11_9) then
					local var_11_13 = Mathf.Lerp(0, 0.5, var_11_12)

					arg_8_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_8_1.var_.characterEffect3009ui_story.fillRatio = var_11_13
				end
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 and not isNil(var_11_9) and arg_8_1.var_.characterEffect3009ui_story then
				local var_11_14 = 0.5

				arg_8_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_8_1.var_.characterEffect3009ui_story.fillRatio = var_11_14
			end

			local var_11_15 = arg_8_1.actors_["3008ui_story"].transform
			local var_11_16 = 0

			if var_11_16 < arg_8_1.time_ and arg_8_1.time_ <= var_11_16 + arg_11_0 then
				arg_8_1.var_.moveOldPos3008ui_story = var_11_15.localPosition
			end

			local var_11_17 = 0.001

			if var_11_16 <= arg_8_1.time_ and arg_8_1.time_ < var_11_16 + var_11_17 then
				local var_11_18 = (arg_8_1.time_ - var_11_16) / var_11_17
				local var_11_19 = Vector3.New(0.7, -1.51, -4.3)

				var_11_15.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos3008ui_story, var_11_19, var_11_18)

				local var_11_20 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_20.x, var_11_20.y, var_11_20.z)

				local var_11_21 = var_11_15.localEulerAngles

				var_11_21.z = 0
				var_11_21.x = 0
				var_11_15.localEulerAngles = var_11_21
			end

			if arg_8_1.time_ >= var_11_16 + var_11_17 and arg_8_1.time_ < var_11_16 + var_11_17 + arg_11_0 then
				var_11_15.localPosition = Vector3.New(0.7, -1.51, -4.3)

				local var_11_22 = manager.ui.mainCamera.transform.position - var_11_15.position

				var_11_15.forward = Vector3.New(var_11_22.x, var_11_22.y, var_11_22.z)

				local var_11_23 = var_11_15.localEulerAngles

				var_11_23.z = 0
				var_11_23.x = 0
				var_11_15.localEulerAngles = var_11_23
			end

			local var_11_24 = 0

			if var_11_24 < arg_8_1.time_ and arg_8_1.time_ <= var_11_24 + arg_11_0 then
				arg_8_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			local var_11_25 = 0

			if var_11_25 < arg_8_1.time_ and arg_8_1.time_ <= var_11_25 + arg_11_0 then
				arg_8_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_11_26 = 0
			local var_11_27 = 0.8

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_28 = arg_8_1:FormatText(StoryNameCfg[20].name)

				arg_8_1.leftNameTxt_.text = var_11_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_29 = arg_8_1:GetWordFromCfg(102112002)
				local var_11_30 = arg_8_1:FormatText(var_11_29.content)

				arg_8_1.text_.text = var_11_30

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_31 = 32
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

				if manager.audio:GetVoiceLength("story_v_out_102112", "102112002", "story_v_out_102112.awb") ~= 0 then
					local var_11_34 = manager.audio:GetVoiceLength("story_v_out_102112", "102112002", "story_v_out_102112.awb") / 1000

					if var_11_34 + var_11_26 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_34 + var_11_26
					end

					if var_11_29.prefab_name ~= "" and arg_8_1.actors_[var_11_29.prefab_name] ~= nil then
						local var_11_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_29.prefab_name].transform, "story_v_out_102112", "102112002", "story_v_out_102112.awb")

						arg_8_1:RecordAudio("102112002", var_11_35)
						arg_8_1:RecordAudio("102112002", var_11_35)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_102112", "102112002", "story_v_out_102112.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_102112", "102112002", "story_v_out_102112.awb")
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
				actorName = "3008ui_story",
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
	Play102112003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 102112003
		arg_12_1.duration_ = 4.3

		local var_12_0 = {
			ja = 4.3,
			ko = 2.5,
			zh = 2.833,
			en = 3.333
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
				arg_12_0:Play102112004(arg_12_1)
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

			local var_15_9 = arg_12_1.actors_["3008ui_story"].transform
			local var_15_10 = 0

			if var_15_10 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.var_.moveOldPos3008ui_story = var_15_9.localPosition
			end

			local var_15_11 = 0.001

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_11 then
				local var_15_12 = (arg_12_1.time_ - var_15_10) / var_15_11
				local var_15_13 = Vector3.New(0, 100, 0)

				var_15_9.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3008ui_story, var_15_13, var_15_12)

				local var_15_14 = manager.ui.mainCamera.transform.position - var_15_9.position

				var_15_9.forward = Vector3.New(var_15_14.x, var_15_14.y, var_15_14.z)

				local var_15_15 = var_15_9.localEulerAngles

				var_15_15.z = 0
				var_15_15.x = 0
				var_15_9.localEulerAngles = var_15_15
			end

			if arg_12_1.time_ >= var_15_10 + var_15_11 and arg_12_1.time_ < var_15_10 + var_15_11 + arg_15_0 then
				var_15_9.localPosition = Vector3.New(0, 100, 0)

				local var_15_16 = manager.ui.mainCamera.transform.position - var_15_9.position

				var_15_9.forward = Vector3.New(var_15_16.x, var_15_16.y, var_15_16.z)

				local var_15_17 = var_15_9.localEulerAngles

				var_15_17.z = 0
				var_15_17.x = 0
				var_15_9.localEulerAngles = var_15_17
			end

			local var_15_18 = arg_12_1.actors_["3009ui_story"].transform
			local var_15_19 = 0

			if var_15_19 < arg_12_1.time_ and arg_12_1.time_ <= var_15_19 + arg_15_0 then
				arg_12_1.var_.moveOldPos3009ui_story = var_15_18.localPosition
			end

			local var_15_20 = 0.001

			if var_15_19 <= arg_12_1.time_ and arg_12_1.time_ < var_15_19 + var_15_20 then
				local var_15_21 = (arg_12_1.time_ - var_15_19) / var_15_20
				local var_15_22 = Vector3.New(0, 100, 0)

				var_15_18.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3009ui_story, var_15_22, var_15_21)

				local var_15_23 = manager.ui.mainCamera.transform.position - var_15_18.position

				var_15_18.forward = Vector3.New(var_15_23.x, var_15_23.y, var_15_23.z)

				local var_15_24 = var_15_18.localEulerAngles

				var_15_24.z = 0
				var_15_24.x = 0
				var_15_18.localEulerAngles = var_15_24
			end

			if arg_12_1.time_ >= var_15_19 + var_15_20 and arg_12_1.time_ < var_15_19 + var_15_20 + arg_15_0 then
				var_15_18.localPosition = Vector3.New(0, 100, 0)

				local var_15_25 = manager.ui.mainCamera.transform.position - var_15_18.position

				var_15_18.forward = Vector3.New(var_15_25.x, var_15_25.y, var_15_25.z)

				local var_15_26 = var_15_18.localEulerAngles

				var_15_26.z = 0
				var_15_26.x = 0
				var_15_18.localEulerAngles = var_15_26
			end

			local var_15_27 = 0

			if var_15_27 < arg_12_1.time_ and arg_12_1.time_ <= var_15_27 + arg_15_0 then
				arg_12_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_15_28 = arg_12_1.actors_["1011ui_story"].transform
			local var_15_29 = 0

			if var_15_29 < arg_12_1.time_ and arg_12_1.time_ <= var_15_29 + arg_15_0 then
				arg_12_1.var_.moveOldPos1011ui_story = var_15_28.localPosition
			end

			local var_15_30 = 0.001

			if var_15_29 <= arg_12_1.time_ and arg_12_1.time_ < var_15_29 + var_15_30 then
				local var_15_31 = (arg_12_1.time_ - var_15_29) / var_15_30
				local var_15_32 = Vector3.New(-0.7, -0.71, -6)

				var_15_28.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1011ui_story, var_15_32, var_15_31)

				local var_15_33 = manager.ui.mainCamera.transform.position - var_15_28.position

				var_15_28.forward = Vector3.New(var_15_33.x, var_15_33.y, var_15_33.z)

				local var_15_34 = var_15_28.localEulerAngles

				var_15_34.z = 0
				var_15_34.x = 0
				var_15_28.localEulerAngles = var_15_34
			end

			if arg_12_1.time_ >= var_15_29 + var_15_30 and arg_12_1.time_ < var_15_29 + var_15_30 + arg_15_0 then
				var_15_28.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_15_35 = manager.ui.mainCamera.transform.position - var_15_28.position

				var_15_28.forward = Vector3.New(var_15_35.x, var_15_35.y, var_15_35.z)

				local var_15_36 = var_15_28.localEulerAngles

				var_15_36.z = 0
				var_15_36.x = 0
				var_15_28.localEulerAngles = var_15_36
			end

			local var_15_37 = 0

			if var_15_37 < arg_12_1.time_ and arg_12_1.time_ <= var_15_37 + arg_15_0 then
				arg_12_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_15_38 = 0
			local var_15_39 = 0.225

			if var_15_38 < arg_12_1.time_ and arg_12_1.time_ <= var_15_38 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_40 = arg_12_1:FormatText(StoryNameCfg[37].name)

				arg_12_1.leftNameTxt_.text = var_15_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_41 = arg_12_1:GetWordFromCfg(102112003)
				local var_15_42 = arg_12_1:FormatText(var_15_41.content)

				arg_12_1.text_.text = var_15_42

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_43 = 9
				local var_15_44 = utf8.len(var_15_42)
				local var_15_45 = var_15_43 <= 0 and var_15_39 or var_15_39 * (var_15_44 / var_15_43)

				if var_15_45 > 0 and var_15_39 < var_15_45 then
					arg_12_1.talkMaxDuration = var_15_45

					if var_15_45 + var_15_38 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_45 + var_15_38
					end
				end

				arg_12_1.text_.text = var_15_42
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102112", "102112003", "story_v_out_102112.awb") ~= 0 then
					local var_15_46 = manager.audio:GetVoiceLength("story_v_out_102112", "102112003", "story_v_out_102112.awb") / 1000

					if var_15_46 + var_15_38 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_46 + var_15_38
					end

					if var_15_41.prefab_name ~= "" and arg_12_1.actors_[var_15_41.prefab_name] ~= nil then
						local var_15_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_41.prefab_name].transform, "story_v_out_102112", "102112003", "story_v_out_102112.awb")

						arg_12_1:RecordAudio("102112003", var_15_47)
						arg_12_1:RecordAudio("102112003", var_15_47)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_102112", "102112003", "story_v_out_102112.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_102112", "102112003", "story_v_out_102112.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_48 = math.max(var_15_39, arg_12_1.talkMaxDuration)

			if var_15_38 <= arg_12_1.time_ and arg_12_1.time_ < var_15_38 + var_15_48 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_38) / var_15_48

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_38 + var_15_48 and arg_12_1.time_ < var_15_38 + var_15_48 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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
				actorName = "3009ui_story",
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
	Play102112004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 102112004
		arg_16_1.duration_ = 8.67

		local var_16_0 = {
			ja = 8.666,
			ko = 4.466,
			zh = 4.266,
			en = 6.466
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
				arg_16_0:Play102112005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1019ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_16_1.stage_.transform)

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

			local var_19_5 = arg_16_1.actors_["1019ui_story"]
			local var_19_6 = 0

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1019ui_story == nil then
				arg_16_1.var_.characterEffect1019ui_story = var_19_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_7 and not isNil(var_19_5) then
				local var_19_8 = (arg_16_1.time_ - var_19_6) / var_19_7

				if arg_16_1.var_.characterEffect1019ui_story and not isNil(var_19_5) then
					arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_6 + var_19_7 and arg_16_1.time_ < var_19_6 + var_19_7 + arg_19_0 and not isNil(var_19_5) and arg_16_1.var_.characterEffect1019ui_story then
				arg_16_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_19_9 = arg_16_1.actors_["1011ui_story"]
			local var_19_10 = 0

			if var_19_10 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1011ui_story == nil then
				arg_16_1.var_.characterEffect1011ui_story = var_19_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_11 = 0.1

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_11 and not isNil(var_19_9) then
				local var_19_12 = (arg_16_1.time_ - var_19_10) / var_19_11

				if arg_16_1.var_.characterEffect1011ui_story and not isNil(var_19_9) then
					local var_19_13 = Mathf.Lerp(0, 0.5, var_19_12)

					arg_16_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1011ui_story.fillRatio = var_19_13
				end
			end

			if arg_16_1.time_ >= var_19_10 + var_19_11 and arg_16_1.time_ < var_19_10 + var_19_11 + arg_19_0 and not isNil(var_19_9) and arg_16_1.var_.characterEffect1011ui_story then
				local var_19_14 = 0.5

				arg_16_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1011ui_story.fillRatio = var_19_14
			end

			local var_19_15 = arg_16_1.actors_["1019ui_story"].transform
			local var_19_16 = 0

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.var_.moveOldPos1019ui_story = var_19_15.localPosition
			end

			local var_19_17 = 0.001

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_17 then
				local var_19_18 = (arg_16_1.time_ - var_19_16) / var_19_17
				local var_19_19 = Vector3.New(0.7, -1.08, -5.9)

				var_19_15.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1019ui_story, var_19_19, var_19_18)

				local var_19_20 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_20.x, var_19_20.y, var_19_20.z)

				local var_19_21 = var_19_15.localEulerAngles

				var_19_21.z = 0
				var_19_21.x = 0
				var_19_15.localEulerAngles = var_19_21
			end

			if arg_16_1.time_ >= var_19_16 + var_19_17 and arg_16_1.time_ < var_19_16 + var_19_17 + arg_19_0 then
				var_19_15.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_19_22 = manager.ui.mainCamera.transform.position - var_19_15.position

				var_19_15.forward = Vector3.New(var_19_22.x, var_19_22.y, var_19_22.z)

				local var_19_23 = var_19_15.localEulerAngles

				var_19_23.z = 0
				var_19_23.x = 0
				var_19_15.localEulerAngles = var_19_23
			end

			local var_19_24 = 0

			if var_19_24 < arg_16_1.time_ and arg_16_1.time_ <= var_19_24 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_19_25 = 0

			if var_19_25 < arg_16_1.time_ and arg_16_1.time_ <= var_19_25 + arg_19_0 then
				arg_16_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_19_26 = 0
			local var_19_27 = 0.5

			if var_19_26 < arg_16_1.time_ and arg_16_1.time_ <= var_19_26 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_28 = arg_16_1:FormatText(StoryNameCfg[13].name)

				arg_16_1.leftNameTxt_.text = var_19_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_29 = arg_16_1:GetWordFromCfg(102112004)
				local var_19_30 = arg_16_1:FormatText(var_19_29.content)

				arg_16_1.text_.text = var_19_30

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_31 = 20
				local var_19_32 = utf8.len(var_19_30)
				local var_19_33 = var_19_31 <= 0 and var_19_27 or var_19_27 * (var_19_32 / var_19_31)

				if var_19_33 > 0 and var_19_27 < var_19_33 then
					arg_16_1.talkMaxDuration = var_19_33

					if var_19_33 + var_19_26 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_33 + var_19_26
					end
				end

				arg_16_1.text_.text = var_19_30
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102112", "102112004", "story_v_out_102112.awb") ~= 0 then
					local var_19_34 = manager.audio:GetVoiceLength("story_v_out_102112", "102112004", "story_v_out_102112.awb") / 1000

					if var_19_34 + var_19_26 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_34 + var_19_26
					end

					if var_19_29.prefab_name ~= "" and arg_16_1.actors_[var_19_29.prefab_name] ~= nil then
						local var_19_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_29.prefab_name].transform, "story_v_out_102112", "102112004", "story_v_out_102112.awb")

						arg_16_1:RecordAudio("102112004", var_19_35)
						arg_16_1:RecordAudio("102112004", var_19_35)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_102112", "102112004", "story_v_out_102112.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_102112", "102112004", "story_v_out_102112.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_36 = math.max(var_19_27, arg_16_1.talkMaxDuration)

			if var_19_26 <= arg_16_1.time_ and arg_16_1.time_ < var_19_26 + var_19_36 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_26) / var_19_36

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_26 + var_19_36 and arg_16_1.time_ < var_19_26 + var_19_36 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play102112005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 102112005
		arg_20_1.duration_ = 6.67

		local var_20_0 = {
			ja = 6.666,
			ko = 3.9,
			zh = 3.233,
			en = 3.866
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
				arg_20_0:Play102112006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["3008ui_story"]
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect3008ui_story == nil then
				arg_20_1.var_.characterEffect3008ui_story = var_23_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_2 = 0.1

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 and not isNil(var_23_0) then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2

				if arg_20_1.var_.characterEffect3008ui_story and not isNil(var_23_0) then
					arg_20_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 and not isNil(var_23_0) and arg_20_1.var_.characterEffect3008ui_story then
				arg_20_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_23_4 = arg_20_1.actors_["1019ui_story"].transform
			local var_23_5 = 0

			if var_23_5 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1.var_.moveOldPos1019ui_story = var_23_4.localPosition
			end

			local var_23_6 = 0.001

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 then
				local var_23_7 = (arg_20_1.time_ - var_23_5) / var_23_6
				local var_23_8 = Vector3.New(0, 100, 0)

				var_23_4.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1019ui_story, var_23_8, var_23_7)

				local var_23_9 = manager.ui.mainCamera.transform.position - var_23_4.position

				var_23_4.forward = Vector3.New(var_23_9.x, var_23_9.y, var_23_9.z)

				local var_23_10 = var_23_4.localEulerAngles

				var_23_10.z = 0
				var_23_10.x = 0
				var_23_4.localEulerAngles = var_23_10
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 then
				var_23_4.localPosition = Vector3.New(0, 100, 0)

				local var_23_11 = manager.ui.mainCamera.transform.position - var_23_4.position

				var_23_4.forward = Vector3.New(var_23_11.x, var_23_11.y, var_23_11.z)

				local var_23_12 = var_23_4.localEulerAngles

				var_23_12.z = 0
				var_23_12.x = 0
				var_23_4.localEulerAngles = var_23_12
			end

			local var_23_13 = arg_20_1.actors_["1011ui_story"].transform
			local var_23_14 = 0

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1.var_.moveOldPos1011ui_story = var_23_13.localPosition
			end

			local var_23_15 = 0.001

			if var_23_14 <= arg_20_1.time_ and arg_20_1.time_ < var_23_14 + var_23_15 then
				local var_23_16 = (arg_20_1.time_ - var_23_14) / var_23_15
				local var_23_17 = Vector3.New(0, 100, 0)

				var_23_13.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1011ui_story, var_23_17, var_23_16)

				local var_23_18 = manager.ui.mainCamera.transform.position - var_23_13.position

				var_23_13.forward = Vector3.New(var_23_18.x, var_23_18.y, var_23_18.z)

				local var_23_19 = var_23_13.localEulerAngles

				var_23_19.z = 0
				var_23_19.x = 0
				var_23_13.localEulerAngles = var_23_19
			end

			if arg_20_1.time_ >= var_23_14 + var_23_15 and arg_20_1.time_ < var_23_14 + var_23_15 + arg_23_0 then
				var_23_13.localPosition = Vector3.New(0, 100, 0)

				local var_23_20 = manager.ui.mainCamera.transform.position - var_23_13.position

				var_23_13.forward = Vector3.New(var_23_20.x, var_23_20.y, var_23_20.z)

				local var_23_21 = var_23_13.localEulerAngles

				var_23_21.z = 0
				var_23_21.x = 0
				var_23_13.localEulerAngles = var_23_21
			end

			local var_23_22 = arg_20_1.actors_["3008ui_story"].transform
			local var_23_23 = 0

			if var_23_23 < arg_20_1.time_ and arg_20_1.time_ <= var_23_23 + arg_23_0 then
				arg_20_1.var_.moveOldPos3008ui_story = var_23_22.localPosition
			end

			local var_23_24 = 0.001

			if var_23_23 <= arg_20_1.time_ and arg_20_1.time_ < var_23_23 + var_23_24 then
				local var_23_25 = (arg_20_1.time_ - var_23_23) / var_23_24
				local var_23_26 = Vector3.New(0, -1.51, -4.3)

				var_23_22.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos3008ui_story, var_23_26, var_23_25)

				local var_23_27 = manager.ui.mainCamera.transform.position - var_23_22.position

				var_23_22.forward = Vector3.New(var_23_27.x, var_23_27.y, var_23_27.z)

				local var_23_28 = var_23_22.localEulerAngles

				var_23_28.z = 0
				var_23_28.x = 0
				var_23_22.localEulerAngles = var_23_28
			end

			if arg_20_1.time_ >= var_23_23 + var_23_24 and arg_20_1.time_ < var_23_23 + var_23_24 + arg_23_0 then
				var_23_22.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_23_29 = manager.ui.mainCamera.transform.position - var_23_22.position

				var_23_22.forward = Vector3.New(var_23_29.x, var_23_29.y, var_23_29.z)

				local var_23_30 = var_23_22.localEulerAngles

				var_23_30.z = 0
				var_23_30.x = 0
				var_23_22.localEulerAngles = var_23_30
			end

			local var_23_31 = 0

			if var_23_31 < arg_20_1.time_ and arg_20_1.time_ <= var_23_31 + arg_23_0 then
				arg_20_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_1")
			end

			local var_23_32 = 0

			if var_23_32 < arg_20_1.time_ and arg_20_1.time_ <= var_23_32 + arg_23_0 then
				arg_20_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_23_33 = 0
			local var_23_34 = 0.375

			if var_23_33 < arg_20_1.time_ and arg_20_1.time_ <= var_23_33 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_35 = arg_20_1:FormatText(StoryNameCfg[20].name)

				arg_20_1.leftNameTxt_.text = var_23_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_36 = arg_20_1:GetWordFromCfg(102112005)
				local var_23_37 = arg_20_1:FormatText(var_23_36.content)

				arg_20_1.text_.text = var_23_37

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_38 = 15
				local var_23_39 = utf8.len(var_23_37)
				local var_23_40 = var_23_38 <= 0 and var_23_34 or var_23_34 * (var_23_39 / var_23_38)

				if var_23_40 > 0 and var_23_34 < var_23_40 then
					arg_20_1.talkMaxDuration = var_23_40

					if var_23_40 + var_23_33 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_40 + var_23_33
					end
				end

				arg_20_1.text_.text = var_23_37
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102112", "102112005", "story_v_out_102112.awb") ~= 0 then
					local var_23_41 = manager.audio:GetVoiceLength("story_v_out_102112", "102112005", "story_v_out_102112.awb") / 1000

					if var_23_41 + var_23_33 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_41 + var_23_33
					end

					if var_23_36.prefab_name ~= "" and arg_20_1.actors_[var_23_36.prefab_name] ~= nil then
						local var_23_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_36.prefab_name].transform, "story_v_out_102112", "102112005", "story_v_out_102112.awb")

						arg_20_1:RecordAudio("102112005", var_23_42)
						arg_20_1:RecordAudio("102112005", var_23_42)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_102112", "102112005", "story_v_out_102112.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_102112", "102112005", "story_v_out_102112.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_43 = math.max(var_23_34, arg_20_1.talkMaxDuration)

			if var_23_33 <= arg_20_1.time_ and arg_20_1.time_ < var_23_33 + var_23_43 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_33) / var_23_43

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_33 + var_23_43 and arg_20_1.time_ < var_23_33 + var_23_43 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
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
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
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
	Play102112006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 102112006
		arg_24_1.duration_ = 4.33

		local var_24_0 = {
			ja = 3.9,
			ko = 3.8,
			zh = 3.166,
			en = 4.333
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
				arg_24_0:Play102112007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["1011ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1011ui_story == nil then
				arg_24_1.var_.characterEffect1011ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.1

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect1011ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect1011ui_story then
				arg_24_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_27_4 = arg_24_1.actors_["3008ui_story"]
			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect3008ui_story == nil then
				arg_24_1.var_.characterEffect3008ui_story = var_27_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_6 = 0.1

			if var_27_5 <= arg_24_1.time_ and arg_24_1.time_ < var_27_5 + var_27_6 and not isNil(var_27_4) then
				local var_27_7 = (arg_24_1.time_ - var_27_5) / var_27_6

				if arg_24_1.var_.characterEffect3008ui_story and not isNil(var_27_4) then
					local var_27_8 = Mathf.Lerp(0, 0.5, var_27_7)

					arg_24_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_24_1.var_.characterEffect3008ui_story.fillRatio = var_27_8
				end
			end

			if arg_24_1.time_ >= var_27_5 + var_27_6 and arg_24_1.time_ < var_27_5 + var_27_6 + arg_27_0 and not isNil(var_27_4) and arg_24_1.var_.characterEffect3008ui_story then
				local var_27_9 = 0.5

				arg_24_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_24_1.var_.characterEffect3008ui_story.fillRatio = var_27_9
			end

			local var_27_10 = 0
			local var_27_11 = 0.3

			if var_27_10 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_12 = arg_24_1:FormatText(StoryNameCfg[37].name)

				arg_24_1.leftNameTxt_.text = var_27_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_13 = arg_24_1:GetWordFromCfg(102112006)
				local var_27_14 = arg_24_1:FormatText(var_27_13.content)

				arg_24_1.text_.text = var_27_14

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_15 = 12
				local var_27_16 = utf8.len(var_27_14)
				local var_27_17 = var_27_15 <= 0 and var_27_11 or var_27_11 * (var_27_16 / var_27_15)

				if var_27_17 > 0 and var_27_11 < var_27_17 then
					arg_24_1.talkMaxDuration = var_27_17

					if var_27_17 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_17 + var_27_10
					end
				end

				arg_24_1.text_.text = var_27_14
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102112", "102112006", "story_v_out_102112.awb") ~= 0 then
					local var_27_18 = manager.audio:GetVoiceLength("story_v_out_102112", "102112006", "story_v_out_102112.awb") / 1000

					if var_27_18 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_18 + var_27_10
					end

					if var_27_13.prefab_name ~= "" and arg_24_1.actors_[var_27_13.prefab_name] ~= nil then
						local var_27_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_13.prefab_name].transform, "story_v_out_102112", "102112006", "story_v_out_102112.awb")

						arg_24_1:RecordAudio("102112006", var_27_19)
						arg_24_1:RecordAudio("102112006", var_27_19)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_102112", "102112006", "story_v_out_102112.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_102112", "102112006", "story_v_out_102112.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_20 = math.max(var_27_11, arg_24_1.talkMaxDuration)

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_20 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_10) / var_27_20

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_10 + var_27_20 and arg_24_1.time_ < var_27_10 + var_27_20 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play102112007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 102112007
		arg_28_1.duration_ = 7.67

		local var_28_0 = {
			ja = 7.666,
			ko = 5.566,
			zh = 5,
			en = 4.233
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
				arg_28_0:Play102112008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = "4010ui_story"

			if arg_28_1.actors_[var_31_0] == nil then
				local var_31_1 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_31_1) then
					local var_31_2 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_28_1.stage_.transform)

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

			local var_31_5 = arg_28_1.actors_["4010ui_story"]
			local var_31_6 = 0

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect4010ui_story == nil then
				arg_28_1.var_.characterEffect4010ui_story = var_31_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_7 = 0.1

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_7 and not isNil(var_31_5) then
				local var_31_8 = (arg_28_1.time_ - var_31_6) / var_31_7

				if arg_28_1.var_.characterEffect4010ui_story and not isNil(var_31_5) then
					arg_28_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_6 + var_31_7 and arg_28_1.time_ < var_31_6 + var_31_7 + arg_31_0 and not isNil(var_31_5) and arg_28_1.var_.characterEffect4010ui_story then
				arg_28_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_31_9 = arg_28_1.actors_["3008ui_story"].transform
			local var_31_10 = 0

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.var_.moveOldPos3008ui_story = var_31_9.localPosition
			end

			local var_31_11 = 0.001

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_11 then
				local var_31_12 = (arg_28_1.time_ - var_31_10) / var_31_11
				local var_31_13 = Vector3.New(0, 100, 0)

				var_31_9.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3008ui_story, var_31_13, var_31_12)

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

			local var_31_18 = arg_28_1.actors_["4010ui_story"].transform
			local var_31_19 = 0

			if var_31_19 < arg_28_1.time_ and arg_28_1.time_ <= var_31_19 + arg_31_0 then
				arg_28_1.var_.moveOldPos4010ui_story = var_31_18.localPosition
			end

			local var_31_20 = 0.001

			if var_31_19 <= arg_28_1.time_ and arg_28_1.time_ < var_31_19 + var_31_20 then
				local var_31_21 = (arg_28_1.time_ - var_31_19) / var_31_20
				local var_31_22 = Vector3.New(0, -1.59, -5.2)

				var_31_18.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos4010ui_story, var_31_22, var_31_21)

				local var_31_23 = manager.ui.mainCamera.transform.position - var_31_18.position

				var_31_18.forward = Vector3.New(var_31_23.x, var_31_23.y, var_31_23.z)

				local var_31_24 = var_31_18.localEulerAngles

				var_31_24.z = 0
				var_31_24.x = 0
				var_31_18.localEulerAngles = var_31_24
			end

			if arg_28_1.time_ >= var_31_19 + var_31_20 and arg_28_1.time_ < var_31_19 + var_31_20 + arg_31_0 then
				var_31_18.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_31_25 = manager.ui.mainCamera.transform.position - var_31_18.position

				var_31_18.forward = Vector3.New(var_31_25.x, var_31_25.y, var_31_25.z)

				local var_31_26 = var_31_18.localEulerAngles

				var_31_26.z = 0
				var_31_26.x = 0
				var_31_18.localEulerAngles = var_31_26
			end

			local var_31_27 = 0

			if var_31_27 < arg_28_1.time_ and arg_28_1.time_ <= var_31_27 + arg_31_0 then
				arg_28_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_31_28 = 0

			if var_31_28 < arg_28_1.time_ and arg_28_1.time_ <= var_31_28 + arg_31_0 then
				arg_28_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_31_29 = 0
			local var_31_30 = 0.425

			if var_31_29 < arg_28_1.time_ and arg_28_1.time_ <= var_31_29 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_31 = arg_28_1:FormatText(StoryNameCfg[42].name)

				arg_28_1.leftNameTxt_.text = var_31_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_32 = arg_28_1:GetWordFromCfg(102112007)
				local var_31_33 = arg_28_1:FormatText(var_31_32.content)

				arg_28_1.text_.text = var_31_33

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_34 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_102112", "102112007", "story_v_out_102112.awb") ~= 0 then
					local var_31_37 = manager.audio:GetVoiceLength("story_v_out_102112", "102112007", "story_v_out_102112.awb") / 1000

					if var_31_37 + var_31_29 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_37 + var_31_29
					end

					if var_31_32.prefab_name ~= "" and arg_28_1.actors_[var_31_32.prefab_name] ~= nil then
						local var_31_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_32.prefab_name].transform, "story_v_out_102112", "102112007", "story_v_out_102112.awb")

						arg_28_1:RecordAudio("102112007", var_31_38)
						arg_28_1:RecordAudio("102112007", var_31_38)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_102112", "102112007", "story_v_out_102112.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_102112", "102112007", "story_v_out_102112.awb")
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
				actorName = "4010ui_story",
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
	Play102112008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 102112008
		arg_32_1.duration_ = 2.6

		local var_32_0 = {
			ja = 2.2,
			ko = 2.6,
			zh = 2,
			en = 2.066
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
				arg_32_0:Play102112009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["3008ui_story"]
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3008ui_story == nil then
				arg_32_1.var_.characterEffect3008ui_story = var_35_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.1

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 and not isNil(var_35_0) then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2

				if arg_32_1.var_.characterEffect3008ui_story and not isNil(var_35_0) then
					arg_32_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 and not isNil(var_35_0) and arg_32_1.var_.characterEffect3008ui_story then
				arg_32_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_35_4 = arg_32_1.actors_["4010ui_story"].transform
			local var_35_5 = 0

			if var_35_5 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1.var_.moveOldPos4010ui_story = var_35_4.localPosition
			end

			local var_35_6 = 0.001

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 then
				local var_35_7 = (arg_32_1.time_ - var_35_5) / var_35_6
				local var_35_8 = Vector3.New(0, 100, 0)

				var_35_4.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos4010ui_story, var_35_8, var_35_7)

				local var_35_9 = manager.ui.mainCamera.transform.position - var_35_4.position

				var_35_4.forward = Vector3.New(var_35_9.x, var_35_9.y, var_35_9.z)

				local var_35_10 = var_35_4.localEulerAngles

				var_35_10.z = 0
				var_35_10.x = 0
				var_35_4.localEulerAngles = var_35_10
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 then
				var_35_4.localPosition = Vector3.New(0, 100, 0)

				local var_35_11 = manager.ui.mainCamera.transform.position - var_35_4.position

				var_35_4.forward = Vector3.New(var_35_11.x, var_35_11.y, var_35_11.z)

				local var_35_12 = var_35_4.localEulerAngles

				var_35_12.z = 0
				var_35_12.x = 0
				var_35_4.localEulerAngles = var_35_12
			end

			local var_35_13 = arg_32_1.actors_["3008ui_story"].transform
			local var_35_14 = 0

			if var_35_14 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 then
				arg_32_1.var_.moveOldPos3008ui_story = var_35_13.localPosition
			end

			local var_35_15 = 0.001

			if var_35_14 <= arg_32_1.time_ and arg_32_1.time_ < var_35_14 + var_35_15 then
				local var_35_16 = (arg_32_1.time_ - var_35_14) / var_35_15
				local var_35_17 = Vector3.New(0, -1.51, -4.3)

				var_35_13.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos3008ui_story, var_35_17, var_35_16)

				local var_35_18 = manager.ui.mainCamera.transform.position - var_35_13.position

				var_35_13.forward = Vector3.New(var_35_18.x, var_35_18.y, var_35_18.z)

				local var_35_19 = var_35_13.localEulerAngles

				var_35_19.z = 0
				var_35_19.x = 0
				var_35_13.localEulerAngles = var_35_19
			end

			if arg_32_1.time_ >= var_35_14 + var_35_15 and arg_32_1.time_ < var_35_14 + var_35_15 + arg_35_0 then
				var_35_13.localPosition = Vector3.New(0, -1.51, -4.3)

				local var_35_20 = manager.ui.mainCamera.transform.position - var_35_13.position

				var_35_13.forward = Vector3.New(var_35_20.x, var_35_20.y, var_35_20.z)

				local var_35_21 = var_35_13.localEulerAngles

				var_35_21.z = 0
				var_35_21.x = 0
				var_35_13.localEulerAngles = var_35_21
			end

			local var_35_22 = 0

			if var_35_22 < arg_32_1.time_ and arg_32_1.time_ <= var_35_22 + arg_35_0 then
				arg_32_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_2")
			end

			local var_35_23 = 0

			if var_35_23 < arg_32_1.time_ and arg_32_1.time_ <= var_35_23 + arg_35_0 then
				arg_32_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_35_24 = 0
			local var_35_25 = 0.15

			if var_35_24 < arg_32_1.time_ and arg_32_1.time_ <= var_35_24 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_26 = arg_32_1:FormatText(StoryNameCfg[20].name)

				arg_32_1.leftNameTxt_.text = var_35_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_27 = arg_32_1:GetWordFromCfg(102112008)
				local var_35_28 = arg_32_1:FormatText(var_35_27.content)

				arg_32_1.text_.text = var_35_28

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_29 = 6
				local var_35_30 = utf8.len(var_35_28)
				local var_35_31 = var_35_29 <= 0 and var_35_25 or var_35_25 * (var_35_30 / var_35_29)

				if var_35_31 > 0 and var_35_25 < var_35_31 then
					arg_32_1.talkMaxDuration = var_35_31

					if var_35_31 + var_35_24 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_31 + var_35_24
					end
				end

				arg_32_1.text_.text = var_35_28
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102112", "102112008", "story_v_out_102112.awb") ~= 0 then
					local var_35_32 = manager.audio:GetVoiceLength("story_v_out_102112", "102112008", "story_v_out_102112.awb") / 1000

					if var_35_32 + var_35_24 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_32 + var_35_24
					end

					if var_35_27.prefab_name ~= "" and arg_32_1.actors_[var_35_27.prefab_name] ~= nil then
						local var_35_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_27.prefab_name].transform, "story_v_out_102112", "102112008", "story_v_out_102112.awb")

						arg_32_1:RecordAudio("102112008", var_35_33)
						arg_32_1:RecordAudio("102112008", var_35_33)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_102112", "102112008", "story_v_out_102112.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_102112", "102112008", "story_v_out_102112.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_34 = math.max(var_35_25, arg_32_1.talkMaxDuration)

			if var_35_24 <= arg_32_1.time_ and arg_32_1.time_ < var_35_24 + var_35_34 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_24) / var_35_34

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_24 + var_35_34 and arg_32_1.time_ < var_35_24 + var_35_34 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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
				actorName = "3008ui_story",
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
	Play102112009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 102112009
		arg_36_1.duration_ = 3.47

		local var_36_0 = {
			ja = 2.7,
			ko = 2.266,
			zh = 2.866,
			en = 3.466
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
				arg_36_0:Play102112010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = "1084ui_story"

			if arg_36_1.actors_[var_39_0] == nil then
				local var_39_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_39_1) then
					local var_39_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_36_1.stage_.transform)

					var_39_2.name = var_39_0
					var_39_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_36_1.actors_[var_39_0] = var_39_2

					local var_39_3 = var_39_2:GetComponentInChildren(typeof(CharacterEffect))

					var_39_3.enabled = true

					local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_2, typeof(DynamicBoneHelper))

					if var_39_4 then
						var_39_4:EnableDynamicBone(false)
					end

					arg_36_1:ShowWeapon(var_39_3.transform, false)

					arg_36_1.var_[var_39_0 .. "Animator"] = var_39_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_36_1.var_[var_39_0 .. "Animator"].applyRootMotion = true
					arg_36_1.var_[var_39_0 .. "LipSync"] = var_39_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_39_5 = arg_36_1.actors_["1084ui_story"]
			local var_39_6 = 0

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_7 = 0.1

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_7 and not isNil(var_39_5) then
				local var_39_8 = (arg_36_1.time_ - var_39_6) / var_39_7

				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_5) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_6 + var_39_7 and arg_36_1.time_ < var_39_6 + var_39_7 + arg_39_0 and not isNil(var_39_5) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_39_9 = arg_36_1.actors_["3008ui_story"].transform
			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.var_.moveOldPos3008ui_story = var_39_9.localPosition
			end

			local var_39_11 = 0.001

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_11 then
				local var_39_12 = (arg_36_1.time_ - var_39_10) / var_39_11
				local var_39_13 = Vector3.New(0, 100, 0)

				var_39_9.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos3008ui_story, var_39_13, var_39_12)

				local var_39_14 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_14.x, var_39_14.y, var_39_14.z)

				local var_39_15 = var_39_9.localEulerAngles

				var_39_15.z = 0
				var_39_15.x = 0
				var_39_9.localEulerAngles = var_39_15
			end

			if arg_36_1.time_ >= var_39_10 + var_39_11 and arg_36_1.time_ < var_39_10 + var_39_11 + arg_39_0 then
				var_39_9.localPosition = Vector3.New(0, 100, 0)

				local var_39_16 = manager.ui.mainCamera.transform.position - var_39_9.position

				var_39_9.forward = Vector3.New(var_39_16.x, var_39_16.y, var_39_16.z)

				local var_39_17 = var_39_9.localEulerAngles

				var_39_17.z = 0
				var_39_17.x = 0
				var_39_9.localEulerAngles = var_39_17
			end

			local var_39_18 = 0

			if var_39_18 < arg_36_1.time_ and arg_36_1.time_ <= var_39_18 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_39_19 = arg_36_1.actors_["1084ui_story"].transform
			local var_39_20 = 0

			if var_39_20 < arg_36_1.time_ and arg_36_1.time_ <= var_39_20 + arg_39_0 then
				arg_36_1.var_.moveOldPos1084ui_story = var_39_19.localPosition
			end

			local var_39_21 = 0.001

			if var_39_20 <= arg_36_1.time_ and arg_36_1.time_ < var_39_20 + var_39_21 then
				local var_39_22 = (arg_36_1.time_ - var_39_20) / var_39_21
				local var_39_23 = Vector3.New(-0.7, -0.97, -6)

				var_39_19.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1084ui_story, var_39_23, var_39_22)

				local var_39_24 = manager.ui.mainCamera.transform.position - var_39_19.position

				var_39_19.forward = Vector3.New(var_39_24.x, var_39_24.y, var_39_24.z)

				local var_39_25 = var_39_19.localEulerAngles

				var_39_25.z = 0
				var_39_25.x = 0
				var_39_19.localEulerAngles = var_39_25
			end

			if arg_36_1.time_ >= var_39_20 + var_39_21 and arg_36_1.time_ < var_39_20 + var_39_21 + arg_39_0 then
				var_39_19.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_39_26 = manager.ui.mainCamera.transform.position - var_39_19.position

				var_39_19.forward = Vector3.New(var_39_26.x, var_39_26.y, var_39_26.z)

				local var_39_27 = var_39_19.localEulerAngles

				var_39_27.z = 0
				var_39_27.x = 0
				var_39_19.localEulerAngles = var_39_27
			end

			local var_39_28 = 0

			if var_39_28 < arg_36_1.time_ and arg_36_1.time_ <= var_39_28 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_39_29 = 0
			local var_39_30 = 0.2

			if var_39_29 < arg_36_1.time_ and arg_36_1.time_ <= var_39_29 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_31 = arg_36_1:FormatText(StoryNameCfg[6].name)

				arg_36_1.leftNameTxt_.text = var_39_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_32 = arg_36_1:GetWordFromCfg(102112009)
				local var_39_33 = arg_36_1:FormatText(var_39_32.content)

				arg_36_1.text_.text = var_39_33

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_34 = 8
				local var_39_35 = utf8.len(var_39_33)
				local var_39_36 = var_39_34 <= 0 and var_39_30 or var_39_30 * (var_39_35 / var_39_34)

				if var_39_36 > 0 and var_39_30 < var_39_36 then
					arg_36_1.talkMaxDuration = var_39_36

					if var_39_36 + var_39_29 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_36 + var_39_29
					end
				end

				arg_36_1.text_.text = var_39_33
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102112", "102112009", "story_v_out_102112.awb") ~= 0 then
					local var_39_37 = manager.audio:GetVoiceLength("story_v_out_102112", "102112009", "story_v_out_102112.awb") / 1000

					if var_39_37 + var_39_29 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_37 + var_39_29
					end

					if var_39_32.prefab_name ~= "" and arg_36_1.actors_[var_39_32.prefab_name] ~= nil then
						local var_39_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_32.prefab_name].transform, "story_v_out_102112", "102112009", "story_v_out_102112.awb")

						arg_36_1:RecordAudio("102112009", var_39_38)
						arg_36_1:RecordAudio("102112009", var_39_38)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_102112", "102112009", "story_v_out_102112.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_102112", "102112009", "story_v_out_102112.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_39 = math.max(var_39_30, arg_36_1.talkMaxDuration)

			if var_39_29 <= arg_36_1.time_ and arg_36_1.time_ < var_39_29 + var_39_39 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_29) / var_39_39

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_29 + var_39_39 and arg_36_1.time_ < var_39_29 + var_39_39 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
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
	Play102112010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 102112010
		arg_40_1.duration_ = 3

		local var_40_0 = {
			ja = 2.366,
			ko = 2.3,
			zh = 3,
			en = 3
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
				arg_40_0:Play102112011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1019ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1019ui_story == nil then
				arg_40_1.var_.characterEffect1019ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.1

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1019ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1019ui_story then
				arg_40_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["1084ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.1

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect1084ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1084ui_story.fillRatio = var_43_9
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_43_11 = arg_40_1.actors_["1019ui_story"].transform
			local var_43_12 = 0

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.var_.moveOldPos1019ui_story = var_43_11.localPosition
			end

			local var_43_13 = 0.001

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_13 then
				local var_43_14 = (arg_40_1.time_ - var_43_12) / var_43_13
				local var_43_15 = Vector3.New(0.7, -1.08, -5.9)

				var_43_11.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1019ui_story, var_43_15, var_43_14)

				local var_43_16 = manager.ui.mainCamera.transform.position - var_43_11.position

				var_43_11.forward = Vector3.New(var_43_16.x, var_43_16.y, var_43_16.z)

				local var_43_17 = var_43_11.localEulerAngles

				var_43_17.z = 0
				var_43_17.x = 0
				var_43_11.localEulerAngles = var_43_17
			end

			if arg_40_1.time_ >= var_43_12 + var_43_13 and arg_40_1.time_ < var_43_12 + var_43_13 + arg_43_0 then
				var_43_11.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_43_18 = manager.ui.mainCamera.transform.position - var_43_11.position

				var_43_11.forward = Vector3.New(var_43_18.x, var_43_18.y, var_43_18.z)

				local var_43_19 = var_43_11.localEulerAngles

				var_43_19.z = 0
				var_43_19.x = 0
				var_43_11.localEulerAngles = var_43_19
			end

			local var_43_20 = 0

			if var_43_20 < arg_40_1.time_ and arg_40_1.time_ <= var_43_20 + arg_43_0 then
				arg_40_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_43_21 = 0
			local var_43_22 = 0.4

			if var_43_21 < arg_40_1.time_ and arg_40_1.time_ <= var_43_21 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_23 = arg_40_1:FormatText(StoryNameCfg[13].name)

				arg_40_1.leftNameTxt_.text = var_43_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_24 = arg_40_1:GetWordFromCfg(102112010)
				local var_43_25 = arg_40_1:FormatText(var_43_24.content)

				arg_40_1.text_.text = var_43_25

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_26 = 16
				local var_43_27 = utf8.len(var_43_25)
				local var_43_28 = var_43_26 <= 0 and var_43_22 or var_43_22 * (var_43_27 / var_43_26)

				if var_43_28 > 0 and var_43_22 < var_43_28 then
					arg_40_1.talkMaxDuration = var_43_28

					if var_43_28 + var_43_21 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_28 + var_43_21
					end
				end

				arg_40_1.text_.text = var_43_25
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102112", "102112010", "story_v_out_102112.awb") ~= 0 then
					local var_43_29 = manager.audio:GetVoiceLength("story_v_out_102112", "102112010", "story_v_out_102112.awb") / 1000

					if var_43_29 + var_43_21 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_29 + var_43_21
					end

					if var_43_24.prefab_name ~= "" and arg_40_1.actors_[var_43_24.prefab_name] ~= nil then
						local var_43_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_24.prefab_name].transform, "story_v_out_102112", "102112010", "story_v_out_102112.awb")

						arg_40_1:RecordAudio("102112010", var_43_30)
						arg_40_1:RecordAudio("102112010", var_43_30)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_102112", "102112010", "story_v_out_102112.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_102112", "102112010", "story_v_out_102112.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_31 = math.max(var_43_22, arg_40_1.talkMaxDuration)

			if var_43_21 <= arg_40_1.time_ and arg_40_1.time_ < var_43_21 + var_43_31 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_21) / var_43_31

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_21 + var_43_31 and arg_40_1.time_ < var_43_21 + var_43_31 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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

		arg_40_1:InitPlayNodeList()
	end,
	Play102112011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 102112011
		arg_44_1.duration_ = 4.83

		local var_44_0 = {
			ja = 4.833,
			ko = 4,
			zh = 3.733,
			en = 3.066
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
				arg_44_0:Play102112012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["3008ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect3008ui_story == nil then
				arg_44_1.var_.characterEffect3008ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.1

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect3008ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect3008ui_story then
				arg_44_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_47_4 = arg_44_1.actors_["1019ui_story"].transform
			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.var_.moveOldPos1019ui_story = var_47_4.localPosition
			end

			local var_47_6 = 0.001

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_6 then
				local var_47_7 = (arg_44_1.time_ - var_47_5) / var_47_6
				local var_47_8 = Vector3.New(0, 100, 0)

				var_47_4.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1019ui_story, var_47_8, var_47_7)

				local var_47_9 = manager.ui.mainCamera.transform.position - var_47_4.position

				var_47_4.forward = Vector3.New(var_47_9.x, var_47_9.y, var_47_9.z)

				local var_47_10 = var_47_4.localEulerAngles

				var_47_10.z = 0
				var_47_10.x = 0
				var_47_4.localEulerAngles = var_47_10
			end

			if arg_44_1.time_ >= var_47_5 + var_47_6 and arg_44_1.time_ < var_47_5 + var_47_6 + arg_47_0 then
				var_47_4.localPosition = Vector3.New(0, 100, 0)

				local var_47_11 = manager.ui.mainCamera.transform.position - var_47_4.position

				var_47_4.forward = Vector3.New(var_47_11.x, var_47_11.y, var_47_11.z)

				local var_47_12 = var_47_4.localEulerAngles

				var_47_12.z = 0
				var_47_12.x = 0
				var_47_4.localEulerAngles = var_47_12
			end

			local var_47_13 = arg_44_1.actors_["1084ui_story"].transform
			local var_47_14 = 0

			if var_47_14 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1.var_.moveOldPos1084ui_story = var_47_13.localPosition
			end

			local var_47_15 = 0.001

			if var_47_14 <= arg_44_1.time_ and arg_44_1.time_ < var_47_14 + var_47_15 then
				local var_47_16 = (arg_44_1.time_ - var_47_14) / var_47_15
				local var_47_17 = Vector3.New(0, 100, 0)

				var_47_13.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1084ui_story, var_47_17, var_47_16)

				local var_47_18 = manager.ui.mainCamera.transform.position - var_47_13.position

				var_47_13.forward = Vector3.New(var_47_18.x, var_47_18.y, var_47_18.z)

				local var_47_19 = var_47_13.localEulerAngles

				var_47_19.z = 0
				var_47_19.x = 0
				var_47_13.localEulerAngles = var_47_19
			end

			if arg_44_1.time_ >= var_47_14 + var_47_15 and arg_44_1.time_ < var_47_14 + var_47_15 + arg_47_0 then
				var_47_13.localPosition = Vector3.New(0, 100, 0)

				local var_47_20 = manager.ui.mainCamera.transform.position - var_47_13.position

				var_47_13.forward = Vector3.New(var_47_20.x, var_47_20.y, var_47_20.z)

				local var_47_21 = var_47_13.localEulerAngles

				var_47_21.z = 0
				var_47_21.x = 0
				var_47_13.localEulerAngles = var_47_21
			end

			local var_47_22 = arg_44_1.actors_["3008ui_story"].transform
			local var_47_23 = 0

			if var_47_23 < arg_44_1.time_ and arg_44_1.time_ <= var_47_23 + arg_47_0 then
				arg_44_1.var_.moveOldPos3008ui_story = var_47_22.localPosition
			end

			local var_47_24 = 0.001

			if var_47_23 <= arg_44_1.time_ and arg_44_1.time_ < var_47_23 + var_47_24 then
				local var_47_25 = (arg_44_1.time_ - var_47_23) / var_47_24
				local var_47_26 = Vector3.New(-0.7, -1.51, -4.3)

				var_47_22.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos3008ui_story, var_47_26, var_47_25)

				local var_47_27 = manager.ui.mainCamera.transform.position - var_47_22.position

				var_47_22.forward = Vector3.New(var_47_27.x, var_47_27.y, var_47_27.z)

				local var_47_28 = var_47_22.localEulerAngles

				var_47_28.z = 0
				var_47_28.x = 0
				var_47_22.localEulerAngles = var_47_28
			end

			if arg_44_1.time_ >= var_47_23 + var_47_24 and arg_44_1.time_ < var_47_23 + var_47_24 + arg_47_0 then
				var_47_22.localPosition = Vector3.New(-0.7, -1.51, -4.3)

				local var_47_29 = manager.ui.mainCamera.transform.position - var_47_22.position

				var_47_22.forward = Vector3.New(var_47_29.x, var_47_29.y, var_47_29.z)

				local var_47_30 = var_47_22.localEulerAngles

				var_47_30.z = 0
				var_47_30.x = 0
				var_47_22.localEulerAngles = var_47_30
			end

			local var_47_31 = 0

			if var_47_31 < arg_44_1.time_ and arg_44_1.time_ <= var_47_31 + arg_47_0 then
				arg_44_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			local var_47_32 = 0

			if var_47_32 < arg_44_1.time_ and arg_44_1.time_ <= var_47_32 + arg_47_0 then
				arg_44_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_47_33 = 0
			local var_47_34 = 0.425

			if var_47_33 < arg_44_1.time_ and arg_44_1.time_ <= var_47_33 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_35 = arg_44_1:FormatText(StoryNameCfg[20].name)

				arg_44_1.leftNameTxt_.text = var_47_35

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_36 = arg_44_1:GetWordFromCfg(102112011)
				local var_47_37 = arg_44_1:FormatText(var_47_36.content)

				arg_44_1.text_.text = var_47_37

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_38 = 17
				local var_47_39 = utf8.len(var_47_37)
				local var_47_40 = var_47_38 <= 0 and var_47_34 or var_47_34 * (var_47_39 / var_47_38)

				if var_47_40 > 0 and var_47_34 < var_47_40 then
					arg_44_1.talkMaxDuration = var_47_40

					if var_47_40 + var_47_33 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_40 + var_47_33
					end
				end

				arg_44_1.text_.text = var_47_37
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102112", "102112011", "story_v_out_102112.awb") ~= 0 then
					local var_47_41 = manager.audio:GetVoiceLength("story_v_out_102112", "102112011", "story_v_out_102112.awb") / 1000

					if var_47_41 + var_47_33 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_41 + var_47_33
					end

					if var_47_36.prefab_name ~= "" and arg_44_1.actors_[var_47_36.prefab_name] ~= nil then
						local var_47_42 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_36.prefab_name].transform, "story_v_out_102112", "102112011", "story_v_out_102112.awb")

						arg_44_1:RecordAudio("102112011", var_47_42)
						arg_44_1:RecordAudio("102112011", var_47_42)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_102112", "102112011", "story_v_out_102112.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_102112", "102112011", "story_v_out_102112.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_43 = math.max(var_47_34, arg_44_1.talkMaxDuration)

			if var_47_33 <= arg_44_1.time_ and arg_44_1.time_ < var_47_33 + var_47_43 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_33) / var_47_43

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_33 + var_47_43 and arg_44_1.time_ < var_47_33 + var_47_43 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play102112012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 102112012
		arg_48_1.duration_ = 10.97

		local var_48_0 = {
			ja = 10.966,
			ko = 7.6,
			zh = 8.8,
			en = 6.766
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
				arg_48_0:Play102112013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["4010ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect4010ui_story == nil then
				arg_48_1.var_.characterEffect4010ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect4010ui_story and not isNil(var_51_0) then
					arg_48_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect4010ui_story then
				arg_48_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_51_4 = arg_48_1.actors_["3008ui_story"]
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect3008ui_story == nil then
				arg_48_1.var_.characterEffect3008ui_story = var_51_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_6 = 0.1

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 and not isNil(var_51_4) then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6

				if arg_48_1.var_.characterEffect3008ui_story and not isNil(var_51_4) then
					local var_51_8 = Mathf.Lerp(0, 0.5, var_51_7)

					arg_48_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_48_1.var_.characterEffect3008ui_story.fillRatio = var_51_8
				end
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 and not isNil(var_51_4) and arg_48_1.var_.characterEffect3008ui_story then
				local var_51_9 = 0.5

				arg_48_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_48_1.var_.characterEffect3008ui_story.fillRatio = var_51_9
			end

			local var_51_10 = arg_48_1.actors_["4010ui_story"].transform
			local var_51_11 = 0

			if var_51_11 < arg_48_1.time_ and arg_48_1.time_ <= var_51_11 + arg_51_0 then
				arg_48_1.var_.moveOldPos4010ui_story = var_51_10.localPosition
			end

			local var_51_12 = 0.001

			if var_51_11 <= arg_48_1.time_ and arg_48_1.time_ < var_51_11 + var_51_12 then
				local var_51_13 = (arg_48_1.time_ - var_51_11) / var_51_12
				local var_51_14 = Vector3.New(0.7, -1.59, -5.2)

				var_51_10.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos4010ui_story, var_51_14, var_51_13)

				local var_51_15 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_15.x, var_51_15.y, var_51_15.z)

				local var_51_16 = var_51_10.localEulerAngles

				var_51_16.z = 0
				var_51_16.x = 0
				var_51_10.localEulerAngles = var_51_16
			end

			if arg_48_1.time_ >= var_51_11 + var_51_12 and arg_48_1.time_ < var_51_11 + var_51_12 + arg_51_0 then
				var_51_10.localPosition = Vector3.New(0.7, -1.59, -5.2)

				local var_51_17 = manager.ui.mainCamera.transform.position - var_51_10.position

				var_51_10.forward = Vector3.New(var_51_17.x, var_51_17.y, var_51_17.z)

				local var_51_18 = var_51_10.localEulerAngles

				var_51_18.z = 0
				var_51_18.x = 0
				var_51_10.localEulerAngles = var_51_18
			end

			local var_51_19 = 0

			if var_51_19 < arg_48_1.time_ and arg_48_1.time_ <= var_51_19 + arg_51_0 then
				arg_48_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_51_20 = 0

			if var_51_20 < arg_48_1.time_ and arg_48_1.time_ <= var_51_20 + arg_51_0 then
				arg_48_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_51_21 = 0
			local var_51_22 = 1.05

			if var_51_21 < arg_48_1.time_ and arg_48_1.time_ <= var_51_21 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_23 = arg_48_1:FormatText(StoryNameCfg[42].name)

				arg_48_1.leftNameTxt_.text = var_51_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_24 = arg_48_1:GetWordFromCfg(102112012)
				local var_51_25 = arg_48_1:FormatText(var_51_24.content)

				arg_48_1.text_.text = var_51_25

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_26 = 42
				local var_51_27 = utf8.len(var_51_25)
				local var_51_28 = var_51_26 <= 0 and var_51_22 or var_51_22 * (var_51_27 / var_51_26)

				if var_51_28 > 0 and var_51_22 < var_51_28 then
					arg_48_1.talkMaxDuration = var_51_28

					if var_51_28 + var_51_21 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_28 + var_51_21
					end
				end

				arg_48_1.text_.text = var_51_25
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102112", "102112012", "story_v_out_102112.awb") ~= 0 then
					local var_51_29 = manager.audio:GetVoiceLength("story_v_out_102112", "102112012", "story_v_out_102112.awb") / 1000

					if var_51_29 + var_51_21 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_29 + var_51_21
					end

					if var_51_24.prefab_name ~= "" and arg_48_1.actors_[var_51_24.prefab_name] ~= nil then
						local var_51_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_24.prefab_name].transform, "story_v_out_102112", "102112012", "story_v_out_102112.awb")

						arg_48_1:RecordAudio("102112012", var_51_30)
						arg_48_1:RecordAudio("102112012", var_51_30)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_102112", "102112012", "story_v_out_102112.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_102112", "102112012", "story_v_out_102112.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_31 = math.max(var_51_22, arg_48_1.talkMaxDuration)

			if var_51_21 <= arg_48_1.time_ and arg_48_1.time_ < var_51_21 + var_51_31 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_21) / var_51_31

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_21 + var_51_31 and arg_48_1.time_ < var_51_21 + var_51_31 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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

		arg_48_1:InitPlayNodeList()
	end,
	Play102112013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 102112013
		arg_52_1.duration_ = 2

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play102112014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["1019ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1019ui_story == nil then
				arg_52_1.var_.characterEffect1019ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.1

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect1019ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect1019ui_story then
				arg_52_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_55_4 = arg_52_1.actors_["4010ui_story"]
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect4010ui_story == nil then
				arg_52_1.var_.characterEffect4010ui_story = var_55_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_6 = 0.1

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 and not isNil(var_55_4) then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6

				if arg_52_1.var_.characterEffect4010ui_story and not isNil(var_55_4) then
					local var_55_8 = Mathf.Lerp(0, 0.5, var_55_7)

					arg_52_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_52_1.var_.characterEffect4010ui_story.fillRatio = var_55_8
				end
			end

			if arg_52_1.time_ >= var_55_5 + var_55_6 and arg_52_1.time_ < var_55_5 + var_55_6 + arg_55_0 and not isNil(var_55_4) and arg_52_1.var_.characterEffect4010ui_story then
				local var_55_9 = 0.5

				arg_52_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_52_1.var_.characterEffect4010ui_story.fillRatio = var_55_9
			end

			local var_55_10 = arg_52_1.actors_["4010ui_story"].transform
			local var_55_11 = 0

			if var_55_11 < arg_52_1.time_ and arg_52_1.time_ <= var_55_11 + arg_55_0 then
				arg_52_1.var_.moveOldPos4010ui_story = var_55_10.localPosition
			end

			local var_55_12 = 0.001

			if var_55_11 <= arg_52_1.time_ and arg_52_1.time_ < var_55_11 + var_55_12 then
				local var_55_13 = (arg_52_1.time_ - var_55_11) / var_55_12
				local var_55_14 = Vector3.New(0, 100, 0)

				var_55_10.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos4010ui_story, var_55_14, var_55_13)

				local var_55_15 = manager.ui.mainCamera.transform.position - var_55_10.position

				var_55_10.forward = Vector3.New(var_55_15.x, var_55_15.y, var_55_15.z)

				local var_55_16 = var_55_10.localEulerAngles

				var_55_16.z = 0
				var_55_16.x = 0
				var_55_10.localEulerAngles = var_55_16
			end

			if arg_52_1.time_ >= var_55_11 + var_55_12 and arg_52_1.time_ < var_55_11 + var_55_12 + arg_55_0 then
				var_55_10.localPosition = Vector3.New(0, 100, 0)

				local var_55_17 = manager.ui.mainCamera.transform.position - var_55_10.position

				var_55_10.forward = Vector3.New(var_55_17.x, var_55_17.y, var_55_17.z)

				local var_55_18 = var_55_10.localEulerAngles

				var_55_18.z = 0
				var_55_18.x = 0
				var_55_10.localEulerAngles = var_55_18
			end

			local var_55_19 = arg_52_1.actors_["1019ui_story"].transform
			local var_55_20 = 0

			if var_55_20 < arg_52_1.time_ and arg_52_1.time_ <= var_55_20 + arg_55_0 then
				arg_52_1.var_.moveOldPos1019ui_story = var_55_19.localPosition
			end

			local var_55_21 = 0.001

			if var_55_20 <= arg_52_1.time_ and arg_52_1.time_ < var_55_20 + var_55_21 then
				local var_55_22 = (arg_52_1.time_ - var_55_20) / var_55_21
				local var_55_23 = Vector3.New(-0.2, -1.08, -5.9)

				var_55_19.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1019ui_story, var_55_23, var_55_22)

				local var_55_24 = manager.ui.mainCamera.transform.position - var_55_19.position

				var_55_19.forward = Vector3.New(var_55_24.x, var_55_24.y, var_55_24.z)

				local var_55_25 = var_55_19.localEulerAngles

				var_55_25.z = 0
				var_55_25.x = 0
				var_55_19.localEulerAngles = var_55_25
			end

			if arg_52_1.time_ >= var_55_20 + var_55_21 and arg_52_1.time_ < var_55_20 + var_55_21 + arg_55_0 then
				var_55_19.localPosition = Vector3.New(-0.2, -1.08, -5.9)

				local var_55_26 = manager.ui.mainCamera.transform.position - var_55_19.position

				var_55_19.forward = Vector3.New(var_55_26.x, var_55_26.y, var_55_26.z)

				local var_55_27 = var_55_19.localEulerAngles

				var_55_27.z = 0
				var_55_27.x = 0
				var_55_19.localEulerAngles = var_55_27
			end

			local var_55_28 = 0

			if var_55_28 < arg_52_1.time_ and arg_52_1.time_ <= var_55_28 + arg_55_0 then
				arg_52_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_55_29 = arg_52_1.actors_["3008ui_story"].transform
			local var_55_30 = 0

			if var_55_30 < arg_52_1.time_ and arg_52_1.time_ <= var_55_30 + arg_55_0 then
				arg_52_1.var_.moveOldPos3008ui_story = var_55_29.localPosition
			end

			local var_55_31 = 0.001

			if var_55_30 <= arg_52_1.time_ and arg_52_1.time_ < var_55_30 + var_55_31 then
				local var_55_32 = (arg_52_1.time_ - var_55_30) / var_55_31
				local var_55_33 = Vector3.New(0, 100, 0)

				var_55_29.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos3008ui_story, var_55_33, var_55_32)

				local var_55_34 = manager.ui.mainCamera.transform.position - var_55_29.position

				var_55_29.forward = Vector3.New(var_55_34.x, var_55_34.y, var_55_34.z)

				local var_55_35 = var_55_29.localEulerAngles

				var_55_35.z = 0
				var_55_35.x = 0
				var_55_29.localEulerAngles = var_55_35
			end

			if arg_52_1.time_ >= var_55_30 + var_55_31 and arg_52_1.time_ < var_55_30 + var_55_31 + arg_55_0 then
				var_55_29.localPosition = Vector3.New(0, 100, 0)

				local var_55_36 = manager.ui.mainCamera.transform.position - var_55_29.position

				var_55_29.forward = Vector3.New(var_55_36.x, var_55_36.y, var_55_36.z)

				local var_55_37 = var_55_29.localEulerAngles

				var_55_37.z = 0
				var_55_37.x = 0
				var_55_29.localEulerAngles = var_55_37
			end

			local var_55_38 = 0
			local var_55_39 = 0.075

			if var_55_38 < arg_52_1.time_ and arg_52_1.time_ <= var_55_38 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_40 = arg_52_1:FormatText(StoryNameCfg[13].name)

				arg_52_1.leftNameTxt_.text = var_55_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_41 = arg_52_1:GetWordFromCfg(102112013)
				local var_55_42 = arg_52_1:FormatText(var_55_41.content)

				arg_52_1.text_.text = var_55_42

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_43 = 3
				local var_55_44 = utf8.len(var_55_42)
				local var_55_45 = var_55_43 <= 0 and var_55_39 or var_55_39 * (var_55_44 / var_55_43)

				if var_55_45 > 0 and var_55_39 < var_55_45 then
					arg_52_1.talkMaxDuration = var_55_45

					if var_55_45 + var_55_38 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_45 + var_55_38
					end
				end

				arg_52_1.text_.text = var_55_42
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102112", "102112013", "story_v_out_102112.awb") ~= 0 then
					local var_55_46 = manager.audio:GetVoiceLength("story_v_out_102112", "102112013", "story_v_out_102112.awb") / 1000

					if var_55_46 + var_55_38 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_46 + var_55_38
					end

					if var_55_41.prefab_name ~= "" and arg_52_1.actors_[var_55_41.prefab_name] ~= nil then
						local var_55_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_41.prefab_name].transform, "story_v_out_102112", "102112013", "story_v_out_102112.awb")

						arg_52_1:RecordAudio("102112013", var_55_47)
						arg_52_1:RecordAudio("102112013", var_55_47)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_102112", "102112013", "story_v_out_102112.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_102112", "102112013", "story_v_out_102112.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_48 = math.max(var_55_39, arg_52_1.talkMaxDuration)

			if var_55_38 <= arg_52_1.time_ and arg_52_1.time_ < var_55_38 + var_55_48 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_38) / var_55_48

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_38 + var_55_48 and arg_52_1.time_ < var_55_38 + var_55_48 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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
				actorName = "3008ui_story",
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
	Play102112014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 102112014
		arg_56_1.duration_ = 15.57

		local var_56_0 = {
			ja = 15.566,
			ko = 7.633,
			zh = 10.133,
			en = 13.366
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
			arg_56_1.auto_ = false
		end

		function arg_56_1.playNext_(arg_58_0)
			arg_56_1.onStoryFinished_()
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["4010ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect4010ui_story == nil then
				arg_56_1.var_.characterEffect4010ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.1

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect4010ui_story and not isNil(var_59_0) then
					arg_56_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect4010ui_story then
				arg_56_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_59_4 = arg_56_1.actors_["1019ui_story"]
			local var_59_5 = 0

			if var_59_5 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1019ui_story == nil then
				arg_56_1.var_.characterEffect1019ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_6 = 0.1

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_6 and not isNil(var_59_4) then
				local var_59_7 = (arg_56_1.time_ - var_59_5) / var_59_6

				if arg_56_1.var_.characterEffect1019ui_story and not isNil(var_59_4) then
					local var_59_8 = Mathf.Lerp(0, 0.5, var_59_7)

					arg_56_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1019ui_story.fillRatio = var_59_8
				end
			end

			if arg_56_1.time_ >= var_59_5 + var_59_6 and arg_56_1.time_ < var_59_5 + var_59_6 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1019ui_story then
				local var_59_9 = 0.5

				arg_56_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1019ui_story.fillRatio = var_59_9
			end

			local var_59_10 = arg_56_1.actors_["1019ui_story"].transform
			local var_59_11 = 0

			if var_59_11 < arg_56_1.time_ and arg_56_1.time_ <= var_59_11 + arg_59_0 then
				arg_56_1.var_.moveOldPos1019ui_story = var_59_10.localPosition
			end

			local var_59_12 = 0.001

			if var_59_11 <= arg_56_1.time_ and arg_56_1.time_ < var_59_11 + var_59_12 then
				local var_59_13 = (arg_56_1.time_ - var_59_11) / var_59_12
				local var_59_14 = Vector3.New(0, 100, 0)

				var_59_10.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1019ui_story, var_59_14, var_59_13)

				local var_59_15 = manager.ui.mainCamera.transform.position - var_59_10.position

				var_59_10.forward = Vector3.New(var_59_15.x, var_59_15.y, var_59_15.z)

				local var_59_16 = var_59_10.localEulerAngles

				var_59_16.z = 0
				var_59_16.x = 0
				var_59_10.localEulerAngles = var_59_16
			end

			if arg_56_1.time_ >= var_59_11 + var_59_12 and arg_56_1.time_ < var_59_11 + var_59_12 + arg_59_0 then
				var_59_10.localPosition = Vector3.New(0, 100, 0)

				local var_59_17 = manager.ui.mainCamera.transform.position - var_59_10.position

				var_59_10.forward = Vector3.New(var_59_17.x, var_59_17.y, var_59_17.z)

				local var_59_18 = var_59_10.localEulerAngles

				var_59_18.z = 0
				var_59_18.x = 0
				var_59_10.localEulerAngles = var_59_18
			end

			local var_59_19 = arg_56_1.actors_["4010ui_story"].transform
			local var_59_20 = 0

			if var_59_20 < arg_56_1.time_ and arg_56_1.time_ <= var_59_20 + arg_59_0 then
				arg_56_1.var_.moveOldPos4010ui_story = var_59_19.localPosition
			end

			local var_59_21 = 0.001

			if var_59_20 <= arg_56_1.time_ and arg_56_1.time_ < var_59_20 + var_59_21 then
				local var_59_22 = (arg_56_1.time_ - var_59_20) / var_59_21
				local var_59_23 = Vector3.New(0, -1.59, -5.2)

				var_59_19.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos4010ui_story, var_59_23, var_59_22)

				local var_59_24 = manager.ui.mainCamera.transform.position - var_59_19.position

				var_59_19.forward = Vector3.New(var_59_24.x, var_59_24.y, var_59_24.z)

				local var_59_25 = var_59_19.localEulerAngles

				var_59_25.z = 0
				var_59_25.x = 0
				var_59_19.localEulerAngles = var_59_25
			end

			if arg_56_1.time_ >= var_59_20 + var_59_21 and arg_56_1.time_ < var_59_20 + var_59_21 + arg_59_0 then
				var_59_19.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_59_26 = manager.ui.mainCamera.transform.position - var_59_19.position

				var_59_19.forward = Vector3.New(var_59_26.x, var_59_26.y, var_59_26.z)

				local var_59_27 = var_59_19.localEulerAngles

				var_59_27.z = 0
				var_59_27.x = 0
				var_59_19.localEulerAngles = var_59_27
			end

			local var_59_28 = 0

			if var_59_28 < arg_56_1.time_ and arg_56_1.time_ <= var_59_28 + arg_59_0 then
				arg_56_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action7_1")
			end

			local var_59_29 = 0

			if var_59_29 < arg_56_1.time_ and arg_56_1.time_ <= var_59_29 + arg_59_0 then
				arg_56_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_59_30 = 0
			local var_59_31 = 1.05

			if var_59_30 < arg_56_1.time_ and arg_56_1.time_ <= var_59_30 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_32 = arg_56_1:FormatText(StoryNameCfg[42].name)

				arg_56_1.leftNameTxt_.text = var_59_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_33 = arg_56_1:GetWordFromCfg(102112014)
				local var_59_34 = arg_56_1:FormatText(var_59_33.content)

				arg_56_1.text_.text = var_59_34

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_35 = 42
				local var_59_36 = utf8.len(var_59_34)
				local var_59_37 = var_59_35 <= 0 and var_59_31 or var_59_31 * (var_59_36 / var_59_35)

				if var_59_37 > 0 and var_59_31 < var_59_37 then
					arg_56_1.talkMaxDuration = var_59_37

					if var_59_37 + var_59_30 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_37 + var_59_30
					end
				end

				arg_56_1.text_.text = var_59_34
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102112", "102112014", "story_v_out_102112.awb") ~= 0 then
					local var_59_38 = manager.audio:GetVoiceLength("story_v_out_102112", "102112014", "story_v_out_102112.awb") / 1000

					if var_59_38 + var_59_30 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_38 + var_59_30
					end

					if var_59_33.prefab_name ~= "" and arg_56_1.actors_[var_59_33.prefab_name] ~= nil then
						local var_59_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_33.prefab_name].transform, "story_v_out_102112", "102112014", "story_v_out_102112.awb")

						arg_56_1:RecordAudio("102112014", var_59_39)
						arg_56_1:RecordAudio("102112014", var_59_39)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_102112", "102112014", "story_v_out_102112.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_102112", "102112014", "story_v_out_102112.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_40 = math.max(var_59_31, arg_56_1.talkMaxDuration)

			if var_59_30 <= arg_56_1.time_ and arg_56_1.time_ < var_59_30 + var_59_40 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_30) / var_59_40

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_30 + var_59_40 and arg_56_1.time_ < var_59_30 + var_59_40 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
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
	assets = {
		"TextureConfig/Background/B08b"
	},
	voices = {
		"story_v_out_102112.awb"
	}
}
