return {
	Play103102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103102001
		arg_1_1.duration_ = 9.2

		local var_1_0 = {
			ja = 9.2,
			ko = 6.7,
			zh = 6.6,
			en = 6.033
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
				arg_1_0:Play103102002(arg_1_1)
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

			local var_4_10 = "4010ui_story"

			if arg_1_1.actors_[var_4_10] == nil then
				local var_4_11 = Asset.Load("Char/" .. "4010ui_story")

				if not isNil(var_4_11) then
					local var_4_12 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_1_1.stage_.transform)

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

			local var_4_15 = arg_1_1.actors_["4010ui_story"]
			local var_4_16 = 2

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect4010ui_story == nil then
				arg_1_1.var_.characterEffect4010ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_17 = 0.1

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 and not isNil(var_4_15) then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17

				if arg_1_1.var_.characterEffect4010ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect4010ui_story then
				arg_1_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_4_19 = 0

			if var_4_19 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_20 = 2

			if var_4_19 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				local var_4_21 = (arg_1_1.time_ - var_4_19) / var_4_20
				local var_4_22 = Color.New(0, 0, 0)

				var_4_22.a = Mathf.Lerp(1, 0, var_4_21)
				arg_1_1.mask_.color = var_4_22
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				local var_4_23 = Color.New(0, 0, 0)
				local var_4_24 = 0

				arg_1_1.mask_.enabled = false
				var_4_23.a = var_4_24
				arg_1_1.mask_.color = var_4_23
			end

			local var_4_25 = "B03d"

			if arg_1_1.bgs_[var_4_25] == nil then
				local var_4_26 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_26:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_25)
				var_4_26.name = var_4_25
				var_4_26.transform.parent = arg_1_1.stage_.transform
				var_4_26.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_25] = var_4_26
			end

			local var_4_27 = 0

			if var_4_27 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				local var_4_28 = manager.ui.mainCamera.transform.localPosition
				local var_4_29 = Vector3.New(0, 0, 10) + Vector3.New(var_4_28.x, var_4_28.y, 0)
				local var_4_30 = arg_1_1.bgs_.B03d

				var_4_30.transform.localPosition = var_4_29
				var_4_30.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_31 = var_4_30:GetComponent("SpriteRenderer")

				if var_4_31 and var_4_31.sprite then
					local var_4_32 = (var_4_30.transform.localPosition - var_4_28).z
					local var_4_33 = manager.ui.mainCameraCom_
					local var_4_34 = 2 * var_4_32 * Mathf.Tan(var_4_33.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_35 = var_4_34 * var_4_33.aspect
					local var_4_36 = var_4_31.sprite.bounds.size.x
					local var_4_37 = var_4_31.sprite.bounds.size.y
					local var_4_38 = var_4_35 / var_4_36
					local var_4_39 = var_4_34 / var_4_37
					local var_4_40 = var_4_39 < var_4_38 and var_4_38 or var_4_39

					var_4_30.transform.localScale = Vector3.New(var_4_40, var_4_40, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B03d" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_41 = arg_1_1.actors_["4010ui_story"].transform
			local var_4_42 = 1.79999995231628

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1.var_.moveOldPos4010ui_story = var_4_41.localPosition
			end

			local var_4_43 = 0.001

			if var_4_42 <= arg_1_1.time_ and arg_1_1.time_ < var_4_42 + var_4_43 then
				local var_4_44 = (arg_1_1.time_ - var_4_42) / var_4_43
				local var_4_45 = Vector3.New(0, -1.59, -5.2)

				var_4_41.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos4010ui_story, var_4_45, var_4_44)

				local var_4_46 = manager.ui.mainCamera.transform.position - var_4_41.position

				var_4_41.forward = Vector3.New(var_4_46.x, var_4_46.y, var_4_46.z)

				local var_4_47 = var_4_41.localEulerAngles

				var_4_47.z = 0
				var_4_47.x = 0
				var_4_41.localEulerAngles = var_4_47
			end

			if arg_1_1.time_ >= var_4_42 + var_4_43 and arg_1_1.time_ < var_4_42 + var_4_43 + arg_4_0 then
				var_4_41.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_4_48 = manager.ui.mainCamera.transform.position - var_4_41.position

				var_4_41.forward = Vector3.New(var_4_48.x, var_4_48.y, var_4_48.z)

				local var_4_49 = var_4_41.localEulerAngles

				var_4_49.z = 0
				var_4_49.x = 0
				var_4_41.localEulerAngles = var_4_49
			end

			local var_4_50 = 1.79999995231628

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				arg_1_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_4_51 = 1.79999995231628

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				arg_1_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_52 = 2
			local var_4_53 = 0.475

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_54 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_54:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_54:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_54:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_55 = arg_1_1:FormatText(StoryNameCfg[42].name)

				arg_1_1.leftNameTxt_.text = var_4_55

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_56 = arg_1_1:GetWordFromCfg(103102001)
				local var_4_57 = arg_1_1:FormatText(var_4_56.content)

				arg_1_1.text_.text = var_4_57

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_58 = 19
				local var_4_59 = utf8.len(var_4_57)
				local var_4_60 = var_4_58 <= 0 and var_4_53 or var_4_53 * (var_4_59 / var_4_58)

				if var_4_60 > 0 and var_4_53 < var_4_60 then
					arg_1_1.talkMaxDuration = var_4_60
					var_4_52 = var_4_52 + 0.3

					if var_4_60 + var_4_52 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_60 + var_4_52
					end
				end

				arg_1_1.text_.text = var_4_57
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102001", "story_v_out_103102.awb") ~= 0 then
					local var_4_61 = manager.audio:GetVoiceLength("story_v_out_103102", "103102001", "story_v_out_103102.awb") / 1000

					if var_4_61 + var_4_52 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_61 + var_4_52
					end

					if var_4_56.prefab_name ~= "" and arg_1_1.actors_[var_4_56.prefab_name] ~= nil then
						local var_4_62 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_56.prefab_name].transform, "story_v_out_103102", "103102001", "story_v_out_103102.awb")

						arg_1_1:RecordAudio("103102001", var_4_62)
						arg_1_1:RecordAudio("103102001", var_4_62)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_103102", "103102001", "story_v_out_103102.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_103102", "103102001", "story_v_out_103102.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_63 = var_4_52 + 0.3
			local var_4_64 = math.max(var_4_53, arg_1_1.talkMaxDuration)

			if var_4_63 <= arg_1_1.time_ and arg_1_1.time_ < var_4_63 + var_4_64 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_63) / var_4_64

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_63 + var_4_64 and arg_1_1.time_ < var_4_63 + var_4_64 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play103102002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 103102002
		arg_8_1.duration_ = 2

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play103102003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = "1084ui_story"

			if arg_8_1.actors_[var_11_0] == nil then
				local var_11_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_11_1) then
					local var_11_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

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

			local var_11_5 = arg_8_1.actors_["1084ui_story"]
			local var_11_6 = 0

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_7 and not isNil(var_11_5) then
				local var_11_8 = (arg_8_1.time_ - var_11_6) / var_11_7

				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_6 + var_11_7 and arg_8_1.time_ < var_11_6 + var_11_7 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_9 = arg_8_1.actors_["4010ui_story"].transform
			local var_11_10 = 0

			if var_11_10 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.var_.moveOldPos4010ui_story = var_11_9.localPosition
			end

			local var_11_11 = 0.001

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_11 then
				local var_11_12 = (arg_8_1.time_ - var_11_10) / var_11_11
				local var_11_13 = Vector3.New(0, 100, 0)

				var_11_9.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos4010ui_story, var_11_13, var_11_12)

				local var_11_14 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_14.x, var_11_14.y, var_11_14.z)

				local var_11_15 = var_11_9.localEulerAngles

				var_11_15.z = 0
				var_11_15.x = 0
				var_11_9.localEulerAngles = var_11_15
			end

			if arg_8_1.time_ >= var_11_10 + var_11_11 and arg_8_1.time_ < var_11_10 + var_11_11 + arg_11_0 then
				var_11_9.localPosition = Vector3.New(0, 100, 0)

				local var_11_16 = manager.ui.mainCamera.transform.position - var_11_9.position

				var_11_9.forward = Vector3.New(var_11_16.x, var_11_16.y, var_11_16.z)

				local var_11_17 = var_11_9.localEulerAngles

				var_11_17.z = 0
				var_11_17.x = 0
				var_11_9.localEulerAngles = var_11_17
			end

			local var_11_18 = 0

			if var_11_18 < arg_8_1.time_ and arg_8_1.time_ <= var_11_18 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_11_19 = arg_8_1.actors_["1084ui_story"].transform
			local var_11_20 = 0

			if var_11_20 < arg_8_1.time_ and arg_8_1.time_ <= var_11_20 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_19.localPosition

				local var_11_21 = "1084ui_story"

				arg_8_1:ShowWeapon(arg_8_1.var_[var_11_21 .. "Animator"].transform, true)
			end

			local var_11_22 = 0.001

			if var_11_20 <= arg_8_1.time_ and arg_8_1.time_ < var_11_20 + var_11_22 then
				local var_11_23 = (arg_8_1.time_ - var_11_20) / var_11_22
				local var_11_24 = Vector3.New(0, -0.97, -6)

				var_11_19.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, var_11_24, var_11_23)

				local var_11_25 = manager.ui.mainCamera.transform.position - var_11_19.position

				var_11_19.forward = Vector3.New(var_11_25.x, var_11_25.y, var_11_25.z)

				local var_11_26 = var_11_19.localEulerAngles

				var_11_26.z = 0
				var_11_26.x = 0
				var_11_19.localEulerAngles = var_11_26
			end

			if arg_8_1.time_ >= var_11_20 + var_11_22 and arg_8_1.time_ < var_11_20 + var_11_22 + arg_11_0 then
				var_11_19.localPosition = Vector3.New(0, -0.97, -6)

				local var_11_27 = manager.ui.mainCamera.transform.position - var_11_19.position

				var_11_19.forward = Vector3.New(var_11_27.x, var_11_27.y, var_11_27.z)

				local var_11_28 = var_11_19.localEulerAngles

				var_11_28.z = 0
				var_11_28.x = 0
				var_11_19.localEulerAngles = var_11_28
			end

			local var_11_29 = 0

			if var_11_29 < arg_8_1.time_ and arg_8_1.time_ <= var_11_29 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_11_30 = 0
			local var_11_31 = 0.075

			if var_11_30 < arg_8_1.time_ and arg_8_1.time_ <= var_11_30 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_32 = arg_8_1:FormatText(StoryNameCfg[6].name)

				arg_8_1.leftNameTxt_.text = var_11_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_33 = arg_8_1:GetWordFromCfg(103102002)
				local var_11_34 = arg_8_1:FormatText(var_11_33.content)

				arg_8_1.text_.text = var_11_34

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_35 = 3
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

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102002", "story_v_out_103102.awb") ~= 0 then
					local var_11_38 = manager.audio:GetVoiceLength("story_v_out_103102", "103102002", "story_v_out_103102.awb") / 1000

					if var_11_38 + var_11_30 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_38 + var_11_30
					end

					if var_11_33.prefab_name ~= "" and arg_8_1.actors_[var_11_33.prefab_name] ~= nil then
						local var_11_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_33.prefab_name].transform, "story_v_out_103102", "103102002", "story_v_out_103102.awb")

						arg_8_1:RecordAudio("103102002", var_11_39)
						arg_8_1:RecordAudio("103102002", var_11_39)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_103102", "103102002", "story_v_out_103102.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_103102", "103102002", "story_v_out_103102.awb")
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
				actorName = "1084ui_story",
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
	Play103102003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 103102003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play103102004(arg_12_1)
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
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1084ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 0.5

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_9 = arg_12_1:GetWordFromCfg(103102003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 20
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_7 or var_15_7 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_7 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_14 and arg_12_1.time_ < var_15_6 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play103102004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 103102004
		arg_16_1.duration_ = 6

		local var_16_0 = {
			ja = 6,
			ko = 4.266,
			zh = 3.966,
			en = 5.1
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
				arg_16_0:Play103102005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0
			local var_19_1 = 1

			if var_19_0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_0 + arg_19_0 then
				local var_19_2 = "play"
				local var_19_3 = "effect"

				arg_16_1:AudioAction(var_19_2, var_19_3, "se_story_3", "se_story_3_destroy_1", "")
			end

			local var_19_4 = arg_16_1.actors_["1084ui_story"].transform
			local var_19_5 = 0

			if var_19_5 < arg_16_1.time_ and arg_16_1.time_ <= var_19_5 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_4.localPosition
			end

			local var_19_6 = 0.001

			if var_19_5 <= arg_16_1.time_ and arg_16_1.time_ < var_19_5 + var_19_6 then
				local var_19_7 = (arg_16_1.time_ - var_19_5) / var_19_6
				local var_19_8 = Vector3.New(0, 100, 0)

				var_19_4.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, var_19_8, var_19_7)

				local var_19_9 = manager.ui.mainCamera.transform.position - var_19_4.position

				var_19_4.forward = Vector3.New(var_19_9.x, var_19_9.y, var_19_9.z)

				local var_19_10 = var_19_4.localEulerAngles

				var_19_10.z = 0
				var_19_10.x = 0
				var_19_4.localEulerAngles = var_19_10
			end

			if arg_16_1.time_ >= var_19_5 + var_19_6 and arg_16_1.time_ < var_19_5 + var_19_6 + arg_19_0 then
				var_19_4.localPosition = Vector3.New(0, 100, 0)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_4.position

				var_19_4.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_4.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_4.localEulerAngles = var_19_12
			end

			local var_19_13 = 0

			if var_19_13 < arg_16_1.time_ and arg_16_1.time_ <= var_19_13 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_2")
			end

			local var_19_14 = 0
			local var_19_15 = 0.325

			if var_19_14 < arg_16_1.time_ and arg_16_1.time_ <= var_19_14 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_16 = arg_16_1:FormatText(StoryNameCfg[53].name)

				arg_16_1.leftNameTxt_.text = var_19_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_17 = arg_16_1:GetWordFromCfg(103102004)
				local var_19_18 = arg_16_1:FormatText(var_19_17.content)

				arg_16_1.text_.text = var_19_18

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_19 = 13
				local var_19_20 = utf8.len(var_19_18)
				local var_19_21 = var_19_19 <= 0 and var_19_15 or var_19_15 * (var_19_20 / var_19_19)

				if var_19_21 > 0 and var_19_15 < var_19_21 then
					arg_16_1.talkMaxDuration = var_19_21

					if var_19_21 + var_19_14 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_21 + var_19_14
					end
				end

				arg_16_1.text_.text = var_19_18
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102004", "story_v_out_103102.awb") ~= 0 then
					local var_19_22 = manager.audio:GetVoiceLength("story_v_out_103102", "103102004", "story_v_out_103102.awb") / 1000

					if var_19_22 + var_19_14 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_22 + var_19_14
					end

					if var_19_17.prefab_name ~= "" and arg_16_1.actors_[var_19_17.prefab_name] ~= nil then
						local var_19_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_17.prefab_name].transform, "story_v_out_103102", "103102004", "story_v_out_103102.awb")

						arg_16_1:RecordAudio("103102004", var_19_23)
						arg_16_1:RecordAudio("103102004", var_19_23)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_103102", "103102004", "story_v_out_103102.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_103102", "103102004", "story_v_out_103102.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_24 = math.max(var_19_15, arg_16_1.talkMaxDuration)

			if var_19_14 <= arg_16_1.time_ and arg_16_1.time_ < var_19_14 + var_19_24 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_14) / var_19_24

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_14 + var_19_24 and arg_16_1.time_ < var_19_14 + var_19_24 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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
	Play103102005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 103102005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play103102006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_1 = 0.5

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_1 then
				local var_23_2 = (arg_20_1.time_ - var_23_0) / var_23_1
				local var_23_3 = Color.New(1, 1, 1)

				var_23_3.a = Mathf.Lerp(1, 0, var_23_2)
				arg_20_1.mask_.color = var_23_3
			end

			if arg_20_1.time_ >= var_23_0 + var_23_1 and arg_20_1.time_ < var_23_0 + var_23_1 + arg_23_0 then
				local var_23_4 = Color.New(1, 1, 1)
				local var_23_5 = 0

				arg_20_1.mask_.enabled = false
				var_23_4.a = var_23_5
				arg_20_1.mask_.color = var_23_4
			end

			local var_23_6 = manager.ui.mainCamera.transform
			local var_23_7 = 0

			if var_23_7 < arg_20_1.time_ and arg_20_1.time_ <= var_23_7 + arg_23_0 then
				arg_20_1.var_.shakeOldPosMainCamera = var_23_6.localPosition
			end

			local var_23_8 = 0.600000023841858

			if var_23_7 <= arg_20_1.time_ and arg_20_1.time_ < var_23_7 + var_23_8 then
				local var_23_9 = (arg_20_1.time_ - var_23_7) / 0.066
				local var_23_10, var_23_11 = math.modf(var_23_9)

				var_23_6.localPosition = Vector3.New(var_23_11 * 0.13, var_23_11 * 0.13, var_23_11 * 0.13) + arg_20_1.var_.shakeOldPosMainCamera
			end

			if arg_20_1.time_ >= var_23_7 + var_23_8 and arg_20_1.time_ < var_23_7 + var_23_8 + arg_23_0 then
				var_23_6.localPosition = arg_20_1.var_.shakeOldPosMainCamera
			end

			local var_23_12 = 0
			local var_23_13 = 1.425

			if var_23_12 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_14 = arg_20_1:GetWordFromCfg(103102005)
				local var_23_15 = arg_20_1:FormatText(var_23_14.content)

				arg_20_1.text_.text = var_23_15

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_16 = 57
				local var_23_17 = utf8.len(var_23_15)
				local var_23_18 = var_23_16 <= 0 and var_23_13 or var_23_13 * (var_23_17 / var_23_16)

				if var_23_18 > 0 and var_23_13 < var_23_18 then
					arg_20_1.talkMaxDuration = var_23_18

					if var_23_18 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_18 + var_23_12
					end
				end

				arg_20_1.text_.text = var_23_15
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_19 = math.max(var_23_13, arg_20_1.talkMaxDuration)

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_19 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_12) / var_23_19

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_12 + var_23_19 and arg_20_1.time_ < var_23_12 + var_23_19 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play103102006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 103102006
		arg_24_1.duration_ = 3.07

		local var_24_0 = {
			ja = 2.866,
			ko = 2.566,
			zh = 3.066,
			en = 3.033
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
				arg_24_0:Play103102007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0
			local var_27_1 = 0.225

			if var_27_0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_2 = arg_24_1:FormatText(StoryNameCfg[49].name)

				arg_24_1.leftNameTxt_.text = var_27_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:GetWordFromCfg(103102006)
				local var_27_4 = arg_24_1:FormatText(var_27_3.content)

				arg_24_1.text_.text = var_27_4

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 9
				local var_27_6 = utf8.len(var_27_4)
				local var_27_7 = var_27_5 <= 0 and var_27_1 or var_27_1 * (var_27_6 / var_27_5)

				if var_27_7 > 0 and var_27_1 < var_27_7 then
					arg_24_1.talkMaxDuration = var_27_7

					if var_27_7 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_7 + var_27_0
					end
				end

				arg_24_1.text_.text = var_27_4
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102006", "story_v_out_103102.awb") ~= 0 then
					local var_27_8 = manager.audio:GetVoiceLength("story_v_out_103102", "103102006", "story_v_out_103102.awb") / 1000

					if var_27_8 + var_27_0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_0
					end

					if var_27_3.prefab_name ~= "" and arg_24_1.actors_[var_27_3.prefab_name] ~= nil then
						local var_27_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_3.prefab_name].transform, "story_v_out_103102", "103102006", "story_v_out_103102.awb")

						arg_24_1:RecordAudio("103102006", var_27_9)
						arg_24_1:RecordAudio("103102006", var_27_9)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_103102", "103102006", "story_v_out_103102.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_103102", "103102006", "story_v_out_103102.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_10 = math.max(var_27_1, arg_24_1.talkMaxDuration)

			if var_27_0 <= arg_24_1.time_ and arg_24_1.time_ < var_27_0 + var_27_10 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_0) / var_27_10

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_0 + var_27_10 and arg_24_1.time_ < var_27_0 + var_27_10 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play103102007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 103102007
		arg_28_1.duration_ = 5.13

		local var_28_0 = {
			ja = 5.133,
			ko = 4.3,
			zh = 3.433,
			en = 2.566
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
				arg_28_0:Play103102008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["4010ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect4010ui_story == nil then
				arg_28_1.var_.characterEffect4010ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.1

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect4010ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect4010ui_story then
				arg_28_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["4010ui_story"].transform
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.var_.moveOldPos4010ui_story = var_31_4.localPosition
			end

			local var_31_6 = 0.001

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6
				local var_31_8 = Vector3.New(0, -1.59, -5.2)

				var_31_4.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos4010ui_story, var_31_8, var_31_7)

				local var_31_9 = manager.ui.mainCamera.transform.position - var_31_4.position

				var_31_4.forward = Vector3.New(var_31_9.x, var_31_9.y, var_31_9.z)

				local var_31_10 = var_31_4.localEulerAngles

				var_31_10.z = 0
				var_31_10.x = 0
				var_31_4.localEulerAngles = var_31_10
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 then
				var_31_4.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_31_11 = manager.ui.mainCamera.transform.position - var_31_4.position

				var_31_4.forward = Vector3.New(var_31_11.x, var_31_11.y, var_31_11.z)

				local var_31_12 = var_31_4.localEulerAngles

				var_31_12.z = 0
				var_31_12.x = 0
				var_31_4.localEulerAngles = var_31_12
			end

			local var_31_13 = 0

			if var_31_13 < arg_28_1.time_ and arg_28_1.time_ <= var_31_13 + arg_31_0 then
				arg_28_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			local var_31_14 = 0

			if var_31_14 < arg_28_1.time_ and arg_28_1.time_ <= var_31_14 + arg_31_0 then
				arg_28_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_31_15 = 0
			local var_31_16 = 0.375

			if var_31_15 < arg_28_1.time_ and arg_28_1.time_ <= var_31_15 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_17 = arg_28_1:FormatText(StoryNameCfg[42].name)

				arg_28_1.leftNameTxt_.text = var_31_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_18 = arg_28_1:GetWordFromCfg(103102007)
				local var_31_19 = arg_28_1:FormatText(var_31_18.content)

				arg_28_1.text_.text = var_31_19

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_20 = 15
				local var_31_21 = utf8.len(var_31_19)
				local var_31_22 = var_31_20 <= 0 and var_31_16 or var_31_16 * (var_31_21 / var_31_20)

				if var_31_22 > 0 and var_31_16 < var_31_22 then
					arg_28_1.talkMaxDuration = var_31_22

					if var_31_22 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_22 + var_31_15
					end
				end

				arg_28_1.text_.text = var_31_19
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102007", "story_v_out_103102.awb") ~= 0 then
					local var_31_23 = manager.audio:GetVoiceLength("story_v_out_103102", "103102007", "story_v_out_103102.awb") / 1000

					if var_31_23 + var_31_15 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_23 + var_31_15
					end

					if var_31_18.prefab_name ~= "" and arg_28_1.actors_[var_31_18.prefab_name] ~= nil then
						local var_31_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_18.prefab_name].transform, "story_v_out_103102", "103102007", "story_v_out_103102.awb")

						arg_28_1:RecordAudio("103102007", var_31_24)
						arg_28_1:RecordAudio("103102007", var_31_24)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_103102", "103102007", "story_v_out_103102.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_103102", "103102007", "story_v_out_103102.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_25 = math.max(var_31_16, arg_28_1.talkMaxDuration)

			if var_31_15 <= arg_28_1.time_ and arg_28_1.time_ < var_31_15 + var_31_25 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_15) / var_31_25

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_15 + var_31_25 and arg_28_1.time_ < var_31_15 + var_31_25 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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
	Play103102008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 103102008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play103102009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = arg_32_1.actors_["4010ui_story"].transform
			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.var_.moveOldPos4010ui_story = var_35_0.localPosition
			end

			local var_35_2 = 0.001

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_2 then
				local var_35_3 = (arg_32_1.time_ - var_35_1) / var_35_2
				local var_35_4 = Vector3.New(0, 100, 0)

				var_35_0.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos4010ui_story, var_35_4, var_35_3)

				local var_35_5 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_5.x, var_35_5.y, var_35_5.z)

				local var_35_6 = var_35_0.localEulerAngles

				var_35_6.z = 0
				var_35_6.x = 0
				var_35_0.localEulerAngles = var_35_6
			end

			if arg_32_1.time_ >= var_35_1 + var_35_2 and arg_32_1.time_ < var_35_1 + var_35_2 + arg_35_0 then
				var_35_0.localPosition = Vector3.New(0, 100, 0)

				local var_35_7 = manager.ui.mainCamera.transform.position - var_35_0.position

				var_35_0.forward = Vector3.New(var_35_7.x, var_35_7.y, var_35_7.z)

				local var_35_8 = var_35_0.localEulerAngles

				var_35_8.z = 0
				var_35_8.x = 0
				var_35_0.localEulerAngles = var_35_8
			end

			local var_35_9 = 0
			local var_35_10 = 0.375

			if var_35_9 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_11 = arg_32_1:GetWordFromCfg(103102008)
				local var_35_12 = arg_32_1:FormatText(var_35_11.content)

				arg_32_1.text_.text = var_35_12

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_13 = 15
				local var_35_14 = utf8.len(var_35_12)
				local var_35_15 = var_35_13 <= 0 and var_35_10 or var_35_10 * (var_35_14 / var_35_13)

				if var_35_15 > 0 and var_35_10 < var_35_15 then
					arg_32_1.talkMaxDuration = var_35_15

					if var_35_15 + var_35_9 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_15 + var_35_9
					end
				end

				arg_32_1.text_.text = var_35_12
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_16 = math.max(var_35_10, arg_32_1.talkMaxDuration)

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_16 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_9) / var_35_16

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_9 + var_35_16 and arg_32_1.time_ < var_35_9 + var_35_16 + arg_35_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play103102009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 103102009
		arg_36_1.duration_ = 2.5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play103102010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 1

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				local var_39_2 = "play"
				local var_39_3 = "effect"

				arg_36_1:AudioAction(var_39_2, var_39_3, "se_story_3", "se_story_3_destroy_2", "")
			end

			local var_39_4 = 0

			if var_39_4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.mask_.enabled = true
				arg_36_1.mask_.raycastTarget = true

				arg_36_1:SetGaussion(false)
			end

			local var_39_5 = 0.5

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_5 then
				local var_39_6 = (arg_36_1.time_ - var_39_4) / var_39_5
				local var_39_7 = Color.New(1, 1, 1)

				var_39_7.a = Mathf.Lerp(1, 0, var_39_6)
				arg_36_1.mask_.color = var_39_7
			end

			if arg_36_1.time_ >= var_39_4 + var_39_5 and arg_36_1.time_ < var_39_4 + var_39_5 + arg_39_0 then
				local var_39_8 = Color.New(1, 1, 1)
				local var_39_9 = 0

				arg_36_1.mask_.enabled = false
				var_39_8.a = var_39_9
				arg_36_1.mask_.color = var_39_8
			end

			local var_39_10 = manager.ui.mainCamera.transform
			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1.var_.shakeOldPosMainCamera = var_39_10.localPosition
			end

			local var_39_12 = 0.600000023841858

			if var_39_11 <= arg_36_1.time_ and arg_36_1.time_ < var_39_11 + var_39_12 then
				local var_39_13 = (arg_36_1.time_ - var_39_11) / 0.066
				local var_39_14, var_39_15 = math.modf(var_39_13)

				var_39_10.localPosition = Vector3.New(var_39_15 * 0.13, var_39_15 * 0.13, var_39_15 * 0.13) + arg_36_1.var_.shakeOldPosMainCamera
			end

			if arg_36_1.time_ >= var_39_11 + var_39_12 and arg_36_1.time_ < var_39_11 + var_39_12 + arg_39_0 then
				var_39_10.localPosition = arg_36_1.var_.shakeOldPosMainCamera
			end

			local var_39_16 = 0
			local var_39_17 = 0.15

			if var_39_16 < arg_36_1.time_ and arg_36_1.time_ <= var_39_16 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_18 = arg_36_1:FormatText(StoryNameCfg[53].name)

				arg_36_1.leftNameTxt_.text = var_39_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_19 = arg_36_1:GetWordFromCfg(103102009)
				local var_39_20 = arg_36_1:FormatText(var_39_19.content)

				arg_36_1.text_.text = var_39_20

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_21 = 6
				local var_39_22 = utf8.len(var_39_20)
				local var_39_23 = var_39_21 <= 0 and var_39_17 or var_39_17 * (var_39_22 / var_39_21)

				if var_39_23 > 0 and var_39_17 < var_39_23 then
					arg_36_1.talkMaxDuration = var_39_23

					if var_39_23 + var_39_16 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_23 + var_39_16
					end
				end

				arg_36_1.text_.text = var_39_20
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102009", "story_v_out_103102.awb") ~= 0 then
					local var_39_24 = manager.audio:GetVoiceLength("story_v_out_103102", "103102009", "story_v_out_103102.awb") / 1000

					if var_39_24 + var_39_16 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_24 + var_39_16
					end

					if var_39_19.prefab_name ~= "" and arg_36_1.actors_[var_39_19.prefab_name] ~= nil then
						local var_39_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_19.prefab_name].transform, "story_v_out_103102", "103102009", "story_v_out_103102.awb")

						arg_36_1:RecordAudio("103102009", var_39_25)
						arg_36_1:RecordAudio("103102009", var_39_25)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_103102", "103102009", "story_v_out_103102.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_103102", "103102009", "story_v_out_103102.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_26 = math.max(var_39_17, arg_36_1.talkMaxDuration)

			if var_39_16 <= arg_36_1.time_ and arg_36_1.time_ < var_39_16 + var_39_26 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_16) / var_39_26

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_16 + var_39_26 and arg_36_1.time_ < var_39_16 + var_39_26 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play103102010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 103102010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play103102011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.225

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_2 = arg_40_1:GetWordFromCfg(103102010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 9
				local var_43_5 = utf8.len(var_43_3)
				local var_43_6 = var_43_4 <= 0 and var_43_1 or var_43_1 * (var_43_5 / var_43_4)

				if var_43_6 > 0 and var_43_1 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_7 and arg_40_1.time_ < var_43_0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play103102011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 103102011
		arg_44_1.duration_ = 2

		local var_44_0 = {
			ja = 1.333,
			ko = 0.933,
			zh = 2,
			en = 1.8
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
				arg_44_0:Play103102012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 0.125

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[49].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(103102011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 5
				local var_47_6 = utf8.len(var_47_4)
				local var_47_7 = var_47_5 <= 0 and var_47_1 or var_47_1 * (var_47_6 / var_47_5)

				if var_47_7 > 0 and var_47_1 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102011", "story_v_out_103102.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_103102", "103102011", "story_v_out_103102.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_103102", "103102011", "story_v_out_103102.awb")

						arg_44_1:RecordAudio("103102011", var_47_9)
						arg_44_1:RecordAudio("103102011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_103102", "103102011", "story_v_out_103102.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_103102", "103102011", "story_v_out_103102.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_10 and arg_44_1.time_ < var_47_0 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play103102012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 103102012
		arg_48_1.duration_ = 6.93

		local var_48_0 = {
			ja = 6.933,
			ko = 5.7,
			zh = 5.6,
			en = 6.2
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
				arg_48_0:Play103102013(arg_48_1)
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

			local var_51_4 = arg_48_1.actors_["4010ui_story"].transform
			local var_51_5 = 0

			if var_51_5 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.var_.moveOldPos4010ui_story = var_51_4.localPosition
			end

			local var_51_6 = 0.001

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 then
				local var_51_7 = (arg_48_1.time_ - var_51_5) / var_51_6
				local var_51_8 = Vector3.New(0, -1.59, -5.2)

				var_51_4.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos4010ui_story, var_51_8, var_51_7)

				local var_51_9 = manager.ui.mainCamera.transform.position - var_51_4.position

				var_51_4.forward = Vector3.New(var_51_9.x, var_51_9.y, var_51_9.z)

				local var_51_10 = var_51_4.localEulerAngles

				var_51_10.z = 0
				var_51_10.x = 0
				var_51_4.localEulerAngles = var_51_10
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 then
				var_51_4.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_51_11 = manager.ui.mainCamera.transform.position - var_51_4.position

				var_51_4.forward = Vector3.New(var_51_11.x, var_51_11.y, var_51_11.z)

				local var_51_12 = var_51_4.localEulerAngles

				var_51_12.z = 0
				var_51_12.x = 0
				var_51_4.localEulerAngles = var_51_12
			end

			local var_51_13 = 0

			if var_51_13 < arg_48_1.time_ and arg_48_1.time_ <= var_51_13 + arg_51_0 then
				arg_48_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action5_1")
			end

			local var_51_14 = 0

			if var_51_14 < arg_48_1.time_ and arg_48_1.time_ <= var_51_14 + arg_51_0 then
				arg_48_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_51_15 = 0
			local var_51_16 = 0.5

			if var_51_15 < arg_48_1.time_ and arg_48_1.time_ <= var_51_15 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_17 = arg_48_1:FormatText(StoryNameCfg[42].name)

				arg_48_1.leftNameTxt_.text = var_51_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_18 = arg_48_1:GetWordFromCfg(103102012)
				local var_51_19 = arg_48_1:FormatText(var_51_18.content)

				arg_48_1.text_.text = var_51_19

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_20 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102012", "story_v_out_103102.awb") ~= 0 then
					local var_51_23 = manager.audio:GetVoiceLength("story_v_out_103102", "103102012", "story_v_out_103102.awb") / 1000

					if var_51_23 + var_51_15 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_23 + var_51_15
					end

					if var_51_18.prefab_name ~= "" and arg_48_1.actors_[var_51_18.prefab_name] ~= nil then
						local var_51_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_18.prefab_name].transform, "story_v_out_103102", "103102012", "story_v_out_103102.awb")

						arg_48_1:RecordAudio("103102012", var_51_24)
						arg_48_1:RecordAudio("103102012", var_51_24)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_103102", "103102012", "story_v_out_103102.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_103102", "103102012", "story_v_out_103102.awb")
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play103102013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 103102013
		arg_52_1.duration_ = 7.1

		local var_52_0 = {
			ja = 4.3,
			ko = 7.1,
			zh = 3.533,
			en = 3.433
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
				arg_52_0:Play103102014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 1.63333333333333
			local var_55_1 = 1

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				local var_55_2 = "play"
				local var_55_3 = "effect"

				arg_52_1:AudioAction(var_55_2, var_55_3, "se_story_3", "se_story_3_destroy_3", "")
			end

			local var_55_4 = arg_52_1.actors_["4010ui_story"].transform
			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1.var_.moveOldPos4010ui_story = var_55_4.localPosition
			end

			local var_55_6 = 0.001

			if var_55_5 <= arg_52_1.time_ and arg_52_1.time_ < var_55_5 + var_55_6 then
				local var_55_7 = (arg_52_1.time_ - var_55_5) / var_55_6
				local var_55_8 = Vector3.New(0, 100, 0)

				var_55_4.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos4010ui_story, var_55_8, var_55_7)

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

			local var_55_13 = 0
			local var_55_14 = 0.7

			if var_55_13 < arg_52_1.time_ and arg_52_1.time_ <= var_55_13 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_15 = arg_52_1:FormatText(StoryNameCfg[49].name)

				arg_52_1.leftNameTxt_.text = var_55_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_16 = arg_52_1:GetWordFromCfg(103102013)
				local var_55_17 = arg_52_1:FormatText(var_55_16.content)

				arg_52_1.text_.text = var_55_17

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_18 = 28
				local var_55_19 = utf8.len(var_55_17)
				local var_55_20 = var_55_18 <= 0 and var_55_14 or var_55_14 * (var_55_19 / var_55_18)

				if var_55_20 > 0 and var_55_14 < var_55_20 then
					arg_52_1.talkMaxDuration = var_55_20

					if var_55_20 + var_55_13 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_20 + var_55_13
					end
				end

				arg_52_1.text_.text = var_55_17
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102013", "story_v_out_103102.awb") ~= 0 then
					local var_55_21 = manager.audio:GetVoiceLength("story_v_out_103102", "103102013", "story_v_out_103102.awb") / 1000

					if var_55_21 + var_55_13 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_21 + var_55_13
					end

					if var_55_16.prefab_name ~= "" and arg_52_1.actors_[var_55_16.prefab_name] ~= nil then
						local var_55_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_16.prefab_name].transform, "story_v_out_103102", "103102013", "story_v_out_103102.awb")

						arg_52_1:RecordAudio("103102013", var_55_22)
						arg_52_1:RecordAudio("103102013", var_55_22)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_103102", "103102013", "story_v_out_103102.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_103102", "103102013", "story_v_out_103102.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_23 = math.max(var_55_14, arg_52_1.talkMaxDuration)

			if var_55_13 <= arg_52_1.time_ and arg_52_1.time_ < var_55_13 + var_55_23 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_13) / var_55_23

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_13 + var_55_23 and arg_52_1.time_ < var_55_13 + var_55_23 + arg_55_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play103102014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 103102014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play103102015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0
			local var_59_1 = 0.725

			if var_59_0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_2 = arg_56_1:GetWordFromCfg(103102014)
				local var_59_3 = arg_56_1:FormatText(var_59_2.content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 29
				local var_59_5 = utf8.len(var_59_3)
				local var_59_6 = var_59_4 <= 0 and var_59_1 or var_59_1 * (var_59_5 / var_59_4)

				if var_59_6 > 0 and var_59_1 < var_59_6 then
					arg_56_1.talkMaxDuration = var_59_6

					if var_59_6 + var_59_0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_6 + var_59_0
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_1, arg_56_1.talkMaxDuration)

			if var_59_0 <= arg_56_1.time_ and arg_56_1.time_ < var_59_0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_0 + var_59_7 and arg_56_1.time_ < var_59_0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play103102015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 103102015
		arg_60_1.duration_ = 5.3

		local var_60_0 = {
			ja = 5.3,
			ko = 4.233,
			zh = 4.566,
			en = 4.866
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
				arg_60_0:Play103102016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = "1011ui_story"

			if arg_60_1.actors_[var_63_0] == nil then
				local var_63_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_63_1) then
					local var_63_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_60_1.stage_.transform)

					var_63_2.name = var_63_0
					var_63_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_60_1.actors_[var_63_0] = var_63_2

					local var_63_3 = var_63_2:GetComponentInChildren(typeof(CharacterEffect))

					var_63_3.enabled = true

					local var_63_4 = GameObjectTools.GetOrAddComponent(var_63_2, typeof(DynamicBoneHelper))

					if var_63_4 then
						var_63_4:EnableDynamicBone(false)
					end

					arg_60_1:ShowWeapon(var_63_3.transform, false)

					arg_60_1.var_[var_63_0 .. "Animator"] = var_63_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_60_1.var_[var_63_0 .. "Animator"].applyRootMotion = true
					arg_60_1.var_[var_63_0 .. "LipSync"] = var_63_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_63_5 = arg_60_1.actors_["1011ui_story"]
			local var_63_6 = 2

			if var_63_6 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.characterEffect1011ui_story == nil then
				arg_60_1.var_.characterEffect1011ui_story = var_63_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_7 = 0.1

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_7 and not isNil(var_63_5) then
				local var_63_8 = (arg_60_1.time_ - var_63_6) / var_63_7

				if arg_60_1.var_.characterEffect1011ui_story and not isNil(var_63_5) then
					arg_60_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_6 + var_63_7 and arg_60_1.time_ < var_63_6 + var_63_7 + arg_63_0 and not isNil(var_63_5) and arg_60_1.var_.characterEffect1011ui_story then
				arg_60_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_63_9 = 0

			if var_63_9 < arg_60_1.time_ and arg_60_1.time_ <= var_63_9 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_10 = 1.5

			if var_63_9 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_10 then
				local var_63_11 = (arg_60_1.time_ - var_63_9) / var_63_10
				local var_63_12 = Color.New(0, 0, 0)

				var_63_12.a = Mathf.Lerp(0, 1, var_63_11)
				arg_60_1.mask_.color = var_63_12
			end

			if arg_60_1.time_ >= var_63_9 + var_63_10 and arg_60_1.time_ < var_63_9 + var_63_10 + arg_63_0 then
				local var_63_13 = Color.New(0, 0, 0)

				var_63_13.a = 1
				arg_60_1.mask_.color = var_63_13
			end

			local var_63_14 = 1.5

			if var_63_14 < arg_60_1.time_ and arg_60_1.time_ <= var_63_14 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_15 = 1.5

			if var_63_14 <= arg_60_1.time_ and arg_60_1.time_ < var_63_14 + var_63_15 then
				local var_63_16 = (arg_60_1.time_ - var_63_14) / var_63_15
				local var_63_17 = Color.New(0, 0, 0)

				var_63_17.a = Mathf.Lerp(1, 0, var_63_16)
				arg_60_1.mask_.color = var_63_17
			end

			if arg_60_1.time_ >= var_63_14 + var_63_15 and arg_60_1.time_ < var_63_14 + var_63_15 + arg_63_0 then
				local var_63_18 = Color.New(0, 0, 0)
				local var_63_19 = 0

				arg_60_1.mask_.enabled = false
				var_63_18.a = var_63_19
				arg_60_1.mask_.color = var_63_18
			end

			local var_63_20 = "B03f"

			if arg_60_1.bgs_[var_63_20] == nil then
				local var_63_21 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_21:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_63_20)
				var_63_21.name = var_63_20
				var_63_21.transform.parent = arg_60_1.stage_.transform
				var_63_21.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_[var_63_20] = var_63_21
			end

			local var_63_22 = 1.5

			if var_63_22 < arg_60_1.time_ and arg_60_1.time_ <= var_63_22 + arg_63_0 then
				local var_63_23 = manager.ui.mainCamera.transform.localPosition
				local var_63_24 = Vector3.New(0, 0, 10) + Vector3.New(var_63_23.x, var_63_23.y, 0)
				local var_63_25 = arg_60_1.bgs_.B03f

				var_63_25.transform.localPosition = var_63_24
				var_63_25.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_26 = var_63_25:GetComponent("SpriteRenderer")

				if var_63_26 and var_63_26.sprite then
					local var_63_27 = (var_63_25.transform.localPosition - var_63_23).z
					local var_63_28 = manager.ui.mainCameraCom_
					local var_63_29 = 2 * var_63_27 * Mathf.Tan(var_63_28.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_63_30 = var_63_29 * var_63_28.aspect
					local var_63_31 = var_63_26.sprite.bounds.size.x
					local var_63_32 = var_63_26.sprite.bounds.size.y
					local var_63_33 = var_63_30 / var_63_31
					local var_63_34 = var_63_29 / var_63_32
					local var_63_35 = var_63_34 < var_63_33 and var_63_33 or var_63_34

					var_63_25.transform.localScale = Vector3.New(var_63_35, var_63_35, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "B03f" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_36 = arg_60_1.actors_["4010ui_story"].transform
			local var_63_37 = 0

			if var_63_37 < arg_60_1.time_ and arg_60_1.time_ <= var_63_37 + arg_63_0 then
				arg_60_1.var_.moveOldPos4010ui_story = var_63_36.localPosition
			end

			local var_63_38 = 0.001

			if var_63_37 <= arg_60_1.time_ and arg_60_1.time_ < var_63_37 + var_63_38 then
				local var_63_39 = (arg_60_1.time_ - var_63_37) / var_63_38
				local var_63_40 = Vector3.New(0, 100, 0)

				var_63_36.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos4010ui_story, var_63_40, var_63_39)

				local var_63_41 = manager.ui.mainCamera.transform.position - var_63_36.position

				var_63_36.forward = Vector3.New(var_63_41.x, var_63_41.y, var_63_41.z)

				local var_63_42 = var_63_36.localEulerAngles

				var_63_42.z = 0
				var_63_42.x = 0
				var_63_36.localEulerAngles = var_63_42
			end

			if arg_60_1.time_ >= var_63_37 + var_63_38 and arg_60_1.time_ < var_63_37 + var_63_38 + arg_63_0 then
				var_63_36.localPosition = Vector3.New(0, 100, 0)

				local var_63_43 = manager.ui.mainCamera.transform.position - var_63_36.position

				var_63_36.forward = Vector3.New(var_63_43.x, var_63_43.y, var_63_43.z)

				local var_63_44 = var_63_36.localEulerAngles

				var_63_44.z = 0
				var_63_44.x = 0
				var_63_36.localEulerAngles = var_63_44
			end

			local var_63_45 = arg_60_1.actors_["1011ui_story"].transform
			local var_63_46 = 1.79999995231628

			if var_63_46 < arg_60_1.time_ and arg_60_1.time_ <= var_63_46 + arg_63_0 then
				arg_60_1.var_.moveOldPos1011ui_story = var_63_45.localPosition
			end

			local var_63_47 = 0.001

			if var_63_46 <= arg_60_1.time_ and arg_60_1.time_ < var_63_46 + var_63_47 then
				local var_63_48 = (arg_60_1.time_ - var_63_46) / var_63_47
				local var_63_49 = Vector3.New(0, -0.71, -6)

				var_63_45.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1011ui_story, var_63_49, var_63_48)

				local var_63_50 = manager.ui.mainCamera.transform.position - var_63_45.position

				var_63_45.forward = Vector3.New(var_63_50.x, var_63_50.y, var_63_50.z)

				local var_63_51 = var_63_45.localEulerAngles

				var_63_51.z = 0
				var_63_51.x = 0
				var_63_45.localEulerAngles = var_63_51
			end

			if arg_60_1.time_ >= var_63_46 + var_63_47 and arg_60_1.time_ < var_63_46 + var_63_47 + arg_63_0 then
				var_63_45.localPosition = Vector3.New(0, -0.71, -6)

				local var_63_52 = manager.ui.mainCamera.transform.position - var_63_45.position

				var_63_45.forward = Vector3.New(var_63_52.x, var_63_52.y, var_63_52.z)

				local var_63_53 = var_63_45.localEulerAngles

				var_63_53.z = 0
				var_63_53.x = 0
				var_63_45.localEulerAngles = var_63_53
			end

			local var_63_54 = 1.79999995231628

			if var_63_54 < arg_60_1.time_ and arg_60_1.time_ <= var_63_54 + arg_63_0 then
				arg_60_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_63_55 = 0

			if var_63_55 < arg_60_1.time_ and arg_60_1.time_ <= var_63_55 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			local var_63_56 = 2

			if arg_60_1.time_ >= var_63_55 + var_63_56 and arg_60_1.time_ < var_63_55 + var_63_56 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			local var_63_57 = 0

			if var_63_57 < arg_60_1.time_ and arg_60_1.time_ <= var_63_57 + arg_63_0 then
				arg_60_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_58 = 2
			local var_63_59 = 0.225

			if var_63_58 < arg_60_1.time_ and arg_60_1.time_ <= var_63_58 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_60 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_60:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_61 = arg_60_1:FormatText(StoryNameCfg[37].name)

				arg_60_1.leftNameTxt_.text = var_63_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_62 = arg_60_1:GetWordFromCfg(103102015)
				local var_63_63 = arg_60_1:FormatText(var_63_62.content)

				arg_60_1.text_.text = var_63_63

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_64 = 9
				local var_63_65 = utf8.len(var_63_63)
				local var_63_66 = var_63_64 <= 0 and var_63_59 or var_63_59 * (var_63_65 / var_63_64)

				if var_63_66 > 0 and var_63_59 < var_63_66 then
					arg_60_1.talkMaxDuration = var_63_66
					var_63_58 = var_63_58 + 0.3

					if var_63_66 + var_63_58 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_66 + var_63_58
					end
				end

				arg_60_1.text_.text = var_63_63
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102015", "story_v_out_103102.awb") ~= 0 then
					local var_63_67 = manager.audio:GetVoiceLength("story_v_out_103102", "103102015", "story_v_out_103102.awb") / 1000

					if var_63_67 + var_63_58 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_67 + var_63_58
					end

					if var_63_62.prefab_name ~= "" and arg_60_1.actors_[var_63_62.prefab_name] ~= nil then
						local var_63_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_62.prefab_name].transform, "story_v_out_103102", "103102015", "story_v_out_103102.awb")

						arg_60_1:RecordAudio("103102015", var_63_68)
						arg_60_1:RecordAudio("103102015", var_63_68)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_103102", "103102015", "story_v_out_103102.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_103102", "103102015", "story_v_out_103102.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_69 = var_63_58 + 0.3
			local var_63_70 = math.max(var_63_59, arg_60_1.talkMaxDuration)

			if var_63_69 <= arg_60_1.time_ and arg_60_1.time_ < var_63_69 + var_63_70 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_69) / var_63_70

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_69 + var_63_70 and arg_60_1.time_ < var_63_69 + var_63_70 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play103102016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 103102016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play103102017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1011ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1011ui_story == nil then
				arg_66_1.var_.characterEffect1011ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.1

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1011ui_story and not isNil(var_69_0) then
					local var_69_4 = Mathf.Lerp(0, 0.5, var_69_3)

					arg_66_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1011ui_story.fillRatio = var_69_4
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1011ui_story then
				local var_69_5 = 0.5

				arg_66_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1011ui_story.fillRatio = var_69_5
			end

			local var_69_6 = 0
			local var_69_7 = 0.75

			if var_69_6 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_8 = arg_66_1:FormatText(StoryNameCfg[7].name)

				arg_66_1.leftNameTxt_.text = var_69_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_9 = arg_66_1:GetWordFromCfg(103102016)
				local var_69_10 = arg_66_1:FormatText(var_69_9.content)

				arg_66_1.text_.text = var_69_10

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 30
				local var_69_12 = utf8.len(var_69_10)
				local var_69_13 = var_69_11 <= 0 and var_69_7 or var_69_7 * (var_69_12 / var_69_11)

				if var_69_13 > 0 and var_69_7 < var_69_13 then
					arg_66_1.talkMaxDuration = var_69_13

					if var_69_13 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_13 + var_69_6
					end
				end

				arg_66_1.text_.text = var_69_10
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_14 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_14 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_14

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_14 and arg_66_1.time_ < var_69_6 + var_69_14 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play103102017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 103102017
		arg_70_1.duration_ = 2

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play103102018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["1084ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1084ui_story == nil then
				arg_70_1.var_.characterEffect1084ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.1

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect1084ui_story and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect1084ui_story then
				arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_73_4 = arg_70_1.actors_["1084ui_story"].transform
			local var_73_5 = 0

			if var_73_5 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 then
				arg_70_1.var_.moveOldPos1084ui_story = var_73_4.localPosition

				local var_73_6 = "1084ui_story"

				arg_70_1:ShowWeapon(arg_70_1.var_[var_73_6 .. "Animator"].transform, false)
			end

			local var_73_7 = 0.001

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_7 then
				local var_73_8 = (arg_70_1.time_ - var_73_5) / var_73_7
				local var_73_9 = Vector3.New(0, -0.97, -6)

				var_73_4.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1084ui_story, var_73_9, var_73_8)

				local var_73_10 = manager.ui.mainCamera.transform.position - var_73_4.position

				var_73_4.forward = Vector3.New(var_73_10.x, var_73_10.y, var_73_10.z)

				local var_73_11 = var_73_4.localEulerAngles

				var_73_11.z = 0
				var_73_11.x = 0
				var_73_4.localEulerAngles = var_73_11
			end

			if arg_70_1.time_ >= var_73_5 + var_73_7 and arg_70_1.time_ < var_73_5 + var_73_7 + arg_73_0 then
				var_73_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_73_12 = manager.ui.mainCamera.transform.position - var_73_4.position

				var_73_4.forward = Vector3.New(var_73_12.x, var_73_12.y, var_73_12.z)

				local var_73_13 = var_73_4.localEulerAngles

				var_73_13.z = 0
				var_73_13.x = 0
				var_73_4.localEulerAngles = var_73_13
			end

			local var_73_14 = 0

			if var_73_14 < arg_70_1.time_ and arg_70_1.time_ <= var_73_14 + arg_73_0 then
				arg_70_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_73_15 = 0

			if var_73_15 < arg_70_1.time_ and arg_70_1.time_ <= var_73_15 + arg_73_0 then
				arg_70_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_73_16 = arg_70_1.actors_["1011ui_story"].transform
			local var_73_17 = 0

			if var_73_17 < arg_70_1.time_ and arg_70_1.time_ <= var_73_17 + arg_73_0 then
				arg_70_1.var_.moveOldPos1011ui_story = var_73_16.localPosition

				local var_73_18 = "1011ui_story"

				arg_70_1:ShowWeapon(arg_70_1.var_[var_73_18 .. "Animator"].transform, false)
			end

			local var_73_19 = 0.001

			if var_73_17 <= arg_70_1.time_ and arg_70_1.time_ < var_73_17 + var_73_19 then
				local var_73_20 = (arg_70_1.time_ - var_73_17) / var_73_19
				local var_73_21 = Vector3.New(0, 100, 0)

				var_73_16.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1011ui_story, var_73_21, var_73_20)

				local var_73_22 = manager.ui.mainCamera.transform.position - var_73_16.position

				var_73_16.forward = Vector3.New(var_73_22.x, var_73_22.y, var_73_22.z)

				local var_73_23 = var_73_16.localEulerAngles

				var_73_23.z = 0
				var_73_23.x = 0
				var_73_16.localEulerAngles = var_73_23
			end

			if arg_70_1.time_ >= var_73_17 + var_73_19 and arg_70_1.time_ < var_73_17 + var_73_19 + arg_73_0 then
				var_73_16.localPosition = Vector3.New(0, 100, 0)

				local var_73_24 = manager.ui.mainCamera.transform.position - var_73_16.position

				var_73_16.forward = Vector3.New(var_73_24.x, var_73_24.y, var_73_24.z)

				local var_73_25 = var_73_16.localEulerAngles

				var_73_25.z = 0
				var_73_25.x = 0
				var_73_16.localEulerAngles = var_73_25
			end

			local var_73_26 = 0
			local var_73_27 = 0.2

			if var_73_26 < arg_70_1.time_ and arg_70_1.time_ <= var_73_26 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_28 = arg_70_1:FormatText(StoryNameCfg[6].name)

				arg_70_1.leftNameTxt_.text = var_73_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_29 = arg_70_1:GetWordFromCfg(103102017)
				local var_73_30 = arg_70_1:FormatText(var_73_29.content)

				arg_70_1.text_.text = var_73_30

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_31 = 8
				local var_73_32 = utf8.len(var_73_30)
				local var_73_33 = var_73_31 <= 0 and var_73_27 or var_73_27 * (var_73_32 / var_73_31)

				if var_73_33 > 0 and var_73_27 < var_73_33 then
					arg_70_1.talkMaxDuration = var_73_33

					if var_73_33 + var_73_26 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_33 + var_73_26
					end
				end

				arg_70_1.text_.text = var_73_30
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102017", "story_v_out_103102.awb") ~= 0 then
					local var_73_34 = manager.audio:GetVoiceLength("story_v_out_103102", "103102017", "story_v_out_103102.awb") / 1000

					if var_73_34 + var_73_26 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_34 + var_73_26
					end

					if var_73_29.prefab_name ~= "" and arg_70_1.actors_[var_73_29.prefab_name] ~= nil then
						local var_73_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_29.prefab_name].transform, "story_v_out_103102", "103102017", "story_v_out_103102.awb")

						arg_70_1:RecordAudio("103102017", var_73_35)
						arg_70_1:RecordAudio("103102017", var_73_35)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_103102", "103102017", "story_v_out_103102.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_103102", "103102017", "story_v_out_103102.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_36 = math.max(var_73_27, arg_70_1.talkMaxDuration)

			if var_73_26 <= arg_70_1.time_ and arg_70_1.time_ < var_73_26 + var_73_36 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_26) / var_73_36

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_26 + var_73_36 and arg_70_1.time_ < var_73_26 + var_73_36 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
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

		arg_70_1:InitPlayNodeList()
	end,
	Play103102018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 103102018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play103102019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["4010ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect4010ui_story == nil then
				arg_74_1.var_.characterEffect4010ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.1

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect4010ui_story and not isNil(var_77_0) then
					local var_77_4 = Mathf.Lerp(0, 0.5, var_77_3)

					arg_74_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_74_1.var_.characterEffect4010ui_story.fillRatio = var_77_4
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect4010ui_story then
				local var_77_5 = 0.5

				arg_74_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_74_1.var_.characterEffect4010ui_story.fillRatio = var_77_5
			end

			local var_77_6 = arg_74_1.actors_["1084ui_story"].transform
			local var_77_7 = 0

			if var_77_7 < arg_74_1.time_ and arg_74_1.time_ <= var_77_7 + arg_77_0 then
				arg_74_1.var_.moveOldPos1084ui_story = var_77_6.localPosition
			end

			local var_77_8 = 0.001

			if var_77_7 <= arg_74_1.time_ and arg_74_1.time_ < var_77_7 + var_77_8 then
				local var_77_9 = (arg_74_1.time_ - var_77_7) / var_77_8
				local var_77_10 = Vector3.New(0, 100, 0)

				var_77_6.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1084ui_story, var_77_10, var_77_9)

				local var_77_11 = manager.ui.mainCamera.transform.position - var_77_6.position

				var_77_6.forward = Vector3.New(var_77_11.x, var_77_11.y, var_77_11.z)

				local var_77_12 = var_77_6.localEulerAngles

				var_77_12.z = 0
				var_77_12.x = 0
				var_77_6.localEulerAngles = var_77_12
			end

			if arg_74_1.time_ >= var_77_7 + var_77_8 and arg_74_1.time_ < var_77_7 + var_77_8 + arg_77_0 then
				var_77_6.localPosition = Vector3.New(0, 100, 0)

				local var_77_13 = manager.ui.mainCamera.transform.position - var_77_6.position

				var_77_6.forward = Vector3.New(var_77_13.x, var_77_13.y, var_77_13.z)

				local var_77_14 = var_77_6.localEulerAngles

				var_77_14.z = 0
				var_77_14.x = 0
				var_77_6.localEulerAngles = var_77_14
			end

			local var_77_15 = arg_74_1.actors_["4010ui_story"].transform
			local var_77_16 = 0

			if var_77_16 < arg_74_1.time_ and arg_74_1.time_ <= var_77_16 + arg_77_0 then
				arg_74_1.var_.moveOldPos4010ui_story = var_77_15.localPosition
			end

			local var_77_17 = 0.001

			if var_77_16 <= arg_74_1.time_ and arg_74_1.time_ < var_77_16 + var_77_17 then
				local var_77_18 = (arg_74_1.time_ - var_77_16) / var_77_17
				local var_77_19 = Vector3.New(0, -1.59, -5.2)

				var_77_15.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos4010ui_story, var_77_19, var_77_18)

				local var_77_20 = manager.ui.mainCamera.transform.position - var_77_15.position

				var_77_15.forward = Vector3.New(var_77_20.x, var_77_20.y, var_77_20.z)

				local var_77_21 = var_77_15.localEulerAngles

				var_77_21.z = 0
				var_77_21.x = 0
				var_77_15.localEulerAngles = var_77_21
			end

			if arg_74_1.time_ >= var_77_16 + var_77_17 and arg_74_1.time_ < var_77_16 + var_77_17 + arg_77_0 then
				var_77_15.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_77_22 = manager.ui.mainCamera.transform.position - var_77_15.position

				var_77_15.forward = Vector3.New(var_77_22.x, var_77_22.y, var_77_22.z)

				local var_77_23 = var_77_15.localEulerAngles

				var_77_23.z = 0
				var_77_23.x = 0
				var_77_15.localEulerAngles = var_77_23
			end

			local var_77_24 = 0

			if var_77_24 < arg_74_1.time_ and arg_74_1.time_ <= var_77_24 + arg_77_0 then
				arg_74_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_77_25 = 0
			local var_77_26 = 0.525

			if var_77_25 < arg_74_1.time_ and arg_74_1.time_ <= var_77_25 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_27 = arg_74_1:GetWordFromCfg(103102018)
				local var_77_28 = arg_74_1:FormatText(var_77_27.content)

				arg_74_1.text_.text = var_77_28

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_29 = 21
				local var_77_30 = utf8.len(var_77_28)
				local var_77_31 = var_77_29 <= 0 and var_77_26 or var_77_26 * (var_77_30 / var_77_29)

				if var_77_31 > 0 and var_77_26 < var_77_31 then
					arg_74_1.talkMaxDuration = var_77_31

					if var_77_31 + var_77_25 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_31 + var_77_25
					end
				end

				arg_74_1.text_.text = var_77_28
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_32 = math.max(var_77_26, arg_74_1.talkMaxDuration)

			if var_77_25 <= arg_74_1.time_ and arg_74_1.time_ < var_77_25 + var_77_32 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_25) / var_77_32

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_25 + var_77_32 and arg_74_1.time_ < var_77_25 + var_77_32 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play103102019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 103102019
		arg_78_1.duration_ = 5.97

		local var_78_0 = {
			ja = 4.633,
			ko = 5.3,
			zh = 5.966,
			en = 5.033
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play103102020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["4010ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect4010ui_story == nil then
				arg_78_1.var_.characterEffect4010ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_2 = 0.1

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 and not isNil(var_81_0) then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2

				if arg_78_1.var_.characterEffect4010ui_story and not isNil(var_81_0) then
					arg_78_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 and not isNil(var_81_0) and arg_78_1.var_.characterEffect4010ui_story then
				arg_78_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_81_4 = 0

			if var_81_4 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_81_5 = 0
			local var_81_6 = 0.5

			if var_81_5 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_7 = arg_78_1:FormatText(StoryNameCfg[42].name)

				arg_78_1.leftNameTxt_.text = var_81_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_8 = arg_78_1:GetWordFromCfg(103102019)
				local var_81_9 = arg_78_1:FormatText(var_81_8.content)

				arg_78_1.text_.text = var_81_9

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_10 = 20
				local var_81_11 = utf8.len(var_81_9)
				local var_81_12 = var_81_10 <= 0 and var_81_6 or var_81_6 * (var_81_11 / var_81_10)

				if var_81_12 > 0 and var_81_6 < var_81_12 then
					arg_78_1.talkMaxDuration = var_81_12

					if var_81_12 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_12 + var_81_5
					end
				end

				arg_78_1.text_.text = var_81_9
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102019", "story_v_out_103102.awb") ~= 0 then
					local var_81_13 = manager.audio:GetVoiceLength("story_v_out_103102", "103102019", "story_v_out_103102.awb") / 1000

					if var_81_13 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_5
					end

					if var_81_8.prefab_name ~= "" and arg_78_1.actors_[var_81_8.prefab_name] ~= nil then
						local var_81_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_8.prefab_name].transform, "story_v_out_103102", "103102019", "story_v_out_103102.awb")

						arg_78_1:RecordAudio("103102019", var_81_14)
						arg_78_1:RecordAudio("103102019", var_81_14)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_103102", "103102019", "story_v_out_103102.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_103102", "103102019", "story_v_out_103102.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_15 = math.max(var_81_6, arg_78_1.talkMaxDuration)

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_15 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_5) / var_81_15

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_5 + var_81_15 and arg_78_1.time_ < var_81_5 + var_81_15 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play103102020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 103102020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play103102021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["4010ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos4010ui_story = var_85_0.localPosition
			end

			local var_85_2 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2
				local var_85_4 = Vector3.New(0, 100, 0)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos4010ui_story, var_85_4, var_85_3)

				local var_85_5 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_5.x, var_85_5.y, var_85_5.z)

				local var_85_6 = var_85_0.localEulerAngles

				var_85_6.z = 0
				var_85_6.x = 0
				var_85_0.localEulerAngles = var_85_6
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0, 100, 0)

				local var_85_7 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_7.x, var_85_7.y, var_85_7.z)

				local var_85_8 = var_85_0.localEulerAngles

				var_85_8.z = 0
				var_85_8.x = 0
				var_85_0.localEulerAngles = var_85_8
			end

			local var_85_9 = 0
			local var_85_10 = 0.65

			if var_85_9 < arg_82_1.time_ and arg_82_1.time_ <= var_85_9 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_11 = arg_82_1:GetWordFromCfg(103102020)
				local var_85_12 = arg_82_1:FormatText(var_85_11.content)

				arg_82_1.text_.text = var_85_12

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_13 = 26
				local var_85_14 = utf8.len(var_85_12)
				local var_85_15 = var_85_13 <= 0 and var_85_10 or var_85_10 * (var_85_14 / var_85_13)

				if var_85_15 > 0 and var_85_10 < var_85_15 then
					arg_82_1.talkMaxDuration = var_85_15

					if var_85_15 + var_85_9 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_15 + var_85_9
					end
				end

				arg_82_1.text_.text = var_85_12
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_16 = math.max(var_85_10, arg_82_1.talkMaxDuration)

			if var_85_9 <= arg_82_1.time_ and arg_82_1.time_ < var_85_9 + var_85_16 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_9) / var_85_16

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_9 + var_85_16 and arg_82_1.time_ < var_85_9 + var_85_16 + arg_85_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play103102021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 103102021
		arg_86_1.duration_ = 2.73

		local var_86_0 = {
			ja = 2.733,
			ko = 2.166,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_86_0:Play103102022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1084ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1084ui_story == nil then
				arg_86_1.var_.characterEffect1084ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.1

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect1084ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect1084ui_story then
				arg_86_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_89_4 = arg_86_1.actors_["1084ui_story"].transform
			local var_89_5 = 0

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 then
				arg_86_1.var_.moveOldPos1084ui_story = var_89_4.localPosition
			end

			local var_89_6 = 0.001

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 then
				local var_89_7 = (arg_86_1.time_ - var_89_5) / var_89_6
				local var_89_8 = Vector3.New(0, -0.97, -6)

				var_89_4.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1084ui_story, var_89_8, var_89_7)

				local var_89_9 = manager.ui.mainCamera.transform.position - var_89_4.position

				var_89_4.forward = Vector3.New(var_89_9.x, var_89_9.y, var_89_9.z)

				local var_89_10 = var_89_4.localEulerAngles

				var_89_10.z = 0
				var_89_10.x = 0
				var_89_4.localEulerAngles = var_89_10
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 then
				var_89_4.localPosition = Vector3.New(0, -0.97, -6)

				local var_89_11 = manager.ui.mainCamera.transform.position - var_89_4.position

				var_89_4.forward = Vector3.New(var_89_11.x, var_89_11.y, var_89_11.z)

				local var_89_12 = var_89_4.localEulerAngles

				var_89_12.z = 0
				var_89_12.x = 0
				var_89_4.localEulerAngles = var_89_12
			end

			local var_89_13 = 0

			if var_89_13 < arg_86_1.time_ and arg_86_1.time_ <= var_89_13 + arg_89_0 then
				arg_86_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_89_14 = 0

			if var_89_14 < arg_86_1.time_ and arg_86_1.time_ <= var_89_14 + arg_89_0 then
				arg_86_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_89_15 = 0
			local var_89_16 = 0.1

			if var_89_15 < arg_86_1.time_ and arg_86_1.time_ <= var_89_15 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_17 = arg_86_1:FormatText(StoryNameCfg[6].name)

				arg_86_1.leftNameTxt_.text = var_89_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_18 = arg_86_1:GetWordFromCfg(103102021)
				local var_89_19 = arg_86_1:FormatText(var_89_18.content)

				arg_86_1.text_.text = var_89_19

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_20 = 4
				local var_89_21 = utf8.len(var_89_19)
				local var_89_22 = var_89_20 <= 0 and var_89_16 or var_89_16 * (var_89_21 / var_89_20)

				if var_89_22 > 0 and var_89_16 < var_89_22 then
					arg_86_1.talkMaxDuration = var_89_22

					if var_89_22 + var_89_15 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_22 + var_89_15
					end
				end

				arg_86_1.text_.text = var_89_19
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102021", "story_v_out_103102.awb") ~= 0 then
					local var_89_23 = manager.audio:GetVoiceLength("story_v_out_103102", "103102021", "story_v_out_103102.awb") / 1000

					if var_89_23 + var_89_15 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_23 + var_89_15
					end

					if var_89_18.prefab_name ~= "" and arg_86_1.actors_[var_89_18.prefab_name] ~= nil then
						local var_89_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_18.prefab_name].transform, "story_v_out_103102", "103102021", "story_v_out_103102.awb")

						arg_86_1:RecordAudio("103102021", var_89_24)
						arg_86_1:RecordAudio("103102021", var_89_24)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_103102", "103102021", "story_v_out_103102.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_103102", "103102021", "story_v_out_103102.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_25 = math.max(var_89_16, arg_86_1.talkMaxDuration)

			if var_89_15 <= arg_86_1.time_ and arg_86_1.time_ < var_89_15 + var_89_25 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_15) / var_89_25

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_15 + var_89_25 and arg_86_1.time_ < var_89_15 + var_89_25 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play103102022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 103102022
		arg_90_1.duration_ = 5.27

		local var_90_0 = {
			ja = 5.266,
			ko = 3.4,
			zh = 4.233,
			en = 3.1
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
				arg_90_0:Play103102023(arg_90_1)
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

			local var_93_4 = arg_90_1.actors_["1084ui_story"].transform
			local var_93_5 = 0

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 then
				arg_90_1.var_.moveOldPos1084ui_story = var_93_4.localPosition
			end

			local var_93_6 = 0.001

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_6 then
				local var_93_7 = (arg_90_1.time_ - var_93_5) / var_93_6
				local var_93_8 = Vector3.New(0, 100, 0)

				var_93_4.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1084ui_story, var_93_8, var_93_7)

				local var_93_9 = manager.ui.mainCamera.transform.position - var_93_4.position

				var_93_4.forward = Vector3.New(var_93_9.x, var_93_9.y, var_93_9.z)

				local var_93_10 = var_93_4.localEulerAngles

				var_93_10.z = 0
				var_93_10.x = 0
				var_93_4.localEulerAngles = var_93_10
			end

			if arg_90_1.time_ >= var_93_5 + var_93_6 and arg_90_1.time_ < var_93_5 + var_93_6 + arg_93_0 then
				var_93_4.localPosition = Vector3.New(0, 100, 0)

				local var_93_11 = manager.ui.mainCamera.transform.position - var_93_4.position

				var_93_4.forward = Vector3.New(var_93_11.x, var_93_11.y, var_93_11.z)

				local var_93_12 = var_93_4.localEulerAngles

				var_93_12.z = 0
				var_93_12.x = 0
				var_93_4.localEulerAngles = var_93_12
			end

			local var_93_13 = arg_90_1.actors_["4010ui_story"].transform
			local var_93_14 = 0

			if var_93_14 < arg_90_1.time_ and arg_90_1.time_ <= var_93_14 + arg_93_0 then
				arg_90_1.var_.moveOldPos4010ui_story = var_93_13.localPosition
			end

			local var_93_15 = 0.001

			if var_93_14 <= arg_90_1.time_ and arg_90_1.time_ < var_93_14 + var_93_15 then
				local var_93_16 = (arg_90_1.time_ - var_93_14) / var_93_15
				local var_93_17 = Vector3.New(-0.7, -1.59, -5.2)

				var_93_13.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos4010ui_story, var_93_17, var_93_16)

				local var_93_18 = manager.ui.mainCamera.transform.position - var_93_13.position

				var_93_13.forward = Vector3.New(var_93_18.x, var_93_18.y, var_93_18.z)

				local var_93_19 = var_93_13.localEulerAngles

				var_93_19.z = 0
				var_93_19.x = 0
				var_93_13.localEulerAngles = var_93_19
			end

			if arg_90_1.time_ >= var_93_14 + var_93_15 and arg_90_1.time_ < var_93_14 + var_93_15 + arg_93_0 then
				var_93_13.localPosition = Vector3.New(-0.7, -1.59, -5.2)

				local var_93_20 = manager.ui.mainCamera.transform.position - var_93_13.position

				var_93_13.forward = Vector3.New(var_93_20.x, var_93_20.y, var_93_20.z)

				local var_93_21 = var_93_13.localEulerAngles

				var_93_21.z = 0
				var_93_21.x = 0
				var_93_13.localEulerAngles = var_93_21
			end

			local var_93_22 = 0

			if var_93_22 < arg_90_1.time_ and arg_90_1.time_ <= var_93_22 + arg_93_0 then
				arg_90_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			local var_93_23 = 0

			if var_93_23 < arg_90_1.time_ and arg_90_1.time_ <= var_93_23 + arg_93_0 then
				arg_90_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_93_24 = 0
			local var_93_25 = 0.425

			if var_93_24 < arg_90_1.time_ and arg_90_1.time_ <= var_93_24 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_26 = arg_90_1:FormatText(StoryNameCfg[42].name)

				arg_90_1.leftNameTxt_.text = var_93_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_27 = arg_90_1:GetWordFromCfg(103102022)
				local var_93_28 = arg_90_1:FormatText(var_93_27.content)

				arg_90_1.text_.text = var_93_28

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_29 = 17
				local var_93_30 = utf8.len(var_93_28)
				local var_93_31 = var_93_29 <= 0 and var_93_25 or var_93_25 * (var_93_30 / var_93_29)

				if var_93_31 > 0 and var_93_25 < var_93_31 then
					arg_90_1.talkMaxDuration = var_93_31

					if var_93_31 + var_93_24 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_31 + var_93_24
					end
				end

				arg_90_1.text_.text = var_93_28
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102022", "story_v_out_103102.awb") ~= 0 then
					local var_93_32 = manager.audio:GetVoiceLength("story_v_out_103102", "103102022", "story_v_out_103102.awb") / 1000

					if var_93_32 + var_93_24 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_32 + var_93_24
					end

					if var_93_27.prefab_name ~= "" and arg_90_1.actors_[var_93_27.prefab_name] ~= nil then
						local var_93_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_27.prefab_name].transform, "story_v_out_103102", "103102022", "story_v_out_103102.awb")

						arg_90_1:RecordAudio("103102022", var_93_33)
						arg_90_1:RecordAudio("103102022", var_93_33)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_103102", "103102022", "story_v_out_103102.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_103102", "103102022", "story_v_out_103102.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_34 = math.max(var_93_25, arg_90_1.talkMaxDuration)

			if var_93_24 <= arg_90_1.time_ and arg_90_1.time_ < var_93_24 + var_93_34 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_24) / var_93_34

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_24 + var_93_34 and arg_90_1.time_ < var_93_24 + var_93_34 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play103102023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 103102023
		arg_94_1.duration_ = 2.27

		local var_94_0 = {
			ja = 2.266,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_94_0:Play103102024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = "1019ui_story"

			if arg_94_1.actors_[var_97_0] == nil then
				local var_97_1 = Asset.Load("Char/" .. "1019ui_story")

				if not isNil(var_97_1) then
					local var_97_2 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_94_1.stage_.transform)

					var_97_2.name = var_97_0
					var_97_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_94_1.actors_[var_97_0] = var_97_2

					local var_97_3 = var_97_2:GetComponentInChildren(typeof(CharacterEffect))

					var_97_3.enabled = true

					local var_97_4 = GameObjectTools.GetOrAddComponent(var_97_2, typeof(DynamicBoneHelper))

					if var_97_4 then
						var_97_4:EnableDynamicBone(false)
					end

					arg_94_1:ShowWeapon(var_97_3.transform, false)

					arg_94_1.var_[var_97_0 .. "Animator"] = var_97_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_94_1.var_[var_97_0 .. "Animator"].applyRootMotion = true
					arg_94_1.var_[var_97_0 .. "LipSync"] = var_97_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_97_5 = arg_94_1.actors_["1019ui_story"]
			local var_97_6 = 0

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 and not isNil(var_97_5) and arg_94_1.var_.characterEffect1019ui_story == nil then
				arg_94_1.var_.characterEffect1019ui_story = var_97_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_7 = 0.1

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_7 and not isNil(var_97_5) then
				local var_97_8 = (arg_94_1.time_ - var_97_6) / var_97_7

				if arg_94_1.var_.characterEffect1019ui_story and not isNil(var_97_5) then
					arg_94_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_6 + var_97_7 and arg_94_1.time_ < var_97_6 + var_97_7 + arg_97_0 and not isNil(var_97_5) and arg_94_1.var_.characterEffect1019ui_story then
				arg_94_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_97_9 = arg_94_1.actors_["4010ui_story"]
			local var_97_10 = 0

			if var_97_10 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 and not isNil(var_97_9) and arg_94_1.var_.characterEffect4010ui_story == nil then
				arg_94_1.var_.characterEffect4010ui_story = var_97_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_11 = 0.1

			if var_97_10 <= arg_94_1.time_ and arg_94_1.time_ < var_97_10 + var_97_11 and not isNil(var_97_9) then
				local var_97_12 = (arg_94_1.time_ - var_97_10) / var_97_11

				if arg_94_1.var_.characterEffect4010ui_story and not isNil(var_97_9) then
					local var_97_13 = Mathf.Lerp(0, 0.5, var_97_12)

					arg_94_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_94_1.var_.characterEffect4010ui_story.fillRatio = var_97_13
				end
			end

			if arg_94_1.time_ >= var_97_10 + var_97_11 and arg_94_1.time_ < var_97_10 + var_97_11 + arg_97_0 and not isNil(var_97_9) and arg_94_1.var_.characterEffect4010ui_story then
				local var_97_14 = 0.5

				arg_94_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_94_1.var_.characterEffect4010ui_story.fillRatio = var_97_14
			end

			local var_97_15 = 0

			if var_97_15 < arg_94_1.time_ and arg_94_1.time_ <= var_97_15 + arg_97_0 then
				arg_94_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_97_16 = arg_94_1.actors_["1019ui_story"].transform
			local var_97_17 = 0

			if var_97_17 < arg_94_1.time_ and arg_94_1.time_ <= var_97_17 + arg_97_0 then
				arg_94_1.var_.moveOldPos1019ui_story = var_97_16.localPosition
			end

			local var_97_18 = 0.001

			if var_97_17 <= arg_94_1.time_ and arg_94_1.time_ < var_97_17 + var_97_18 then
				local var_97_19 = (arg_94_1.time_ - var_97_17) / var_97_18
				local var_97_20 = Vector3.New(0.7, -1.08, -5.9)

				var_97_16.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1019ui_story, var_97_20, var_97_19)

				local var_97_21 = manager.ui.mainCamera.transform.position - var_97_16.position

				var_97_16.forward = Vector3.New(var_97_21.x, var_97_21.y, var_97_21.z)

				local var_97_22 = var_97_16.localEulerAngles

				var_97_22.z = 0
				var_97_22.x = 0
				var_97_16.localEulerAngles = var_97_22
			end

			if arg_94_1.time_ >= var_97_17 + var_97_18 and arg_94_1.time_ < var_97_17 + var_97_18 + arg_97_0 then
				var_97_16.localPosition = Vector3.New(0.7, -1.08, -5.9)

				local var_97_23 = manager.ui.mainCamera.transform.position - var_97_16.position

				var_97_16.forward = Vector3.New(var_97_23.x, var_97_23.y, var_97_23.z)

				local var_97_24 = var_97_16.localEulerAngles

				var_97_24.z = 0
				var_97_24.x = 0
				var_97_16.localEulerAngles = var_97_24
			end

			local var_97_25 = 0

			if var_97_25 < arg_94_1.time_ and arg_94_1.time_ <= var_97_25 + arg_97_0 then
				arg_94_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_97_26 = 0
			local var_97_27 = 0.15

			if var_97_26 < arg_94_1.time_ and arg_94_1.time_ <= var_97_26 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_28 = arg_94_1:FormatText(StoryNameCfg[13].name)

				arg_94_1.leftNameTxt_.text = var_97_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_29 = arg_94_1:GetWordFromCfg(103102023)
				local var_97_30 = arg_94_1:FormatText(var_97_29.content)

				arg_94_1.text_.text = var_97_30

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_31 = 6
				local var_97_32 = utf8.len(var_97_30)
				local var_97_33 = var_97_31 <= 0 and var_97_27 or var_97_27 * (var_97_32 / var_97_31)

				if var_97_33 > 0 and var_97_27 < var_97_33 then
					arg_94_1.talkMaxDuration = var_97_33

					if var_97_33 + var_97_26 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_33 + var_97_26
					end
				end

				arg_94_1.text_.text = var_97_30
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102023", "story_v_out_103102.awb") ~= 0 then
					local var_97_34 = manager.audio:GetVoiceLength("story_v_out_103102", "103102023", "story_v_out_103102.awb") / 1000

					if var_97_34 + var_97_26 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_34 + var_97_26
					end

					if var_97_29.prefab_name ~= "" and arg_94_1.actors_[var_97_29.prefab_name] ~= nil then
						local var_97_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_29.prefab_name].transform, "story_v_out_103102", "103102023", "story_v_out_103102.awb")

						arg_94_1:RecordAudio("103102023", var_97_35)
						arg_94_1:RecordAudio("103102023", var_97_35)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_103102", "103102023", "story_v_out_103102.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_103102", "103102023", "story_v_out_103102.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_36 = math.max(var_97_27, arg_94_1.talkMaxDuration)

			if var_97_26 <= arg_94_1.time_ and arg_94_1.time_ < var_97_26 + var_97_36 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_26) / var_97_36

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_26 + var_97_36 and arg_94_1.time_ < var_97_26 + var_97_36 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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

		arg_94_1:InitPlayNodeList()
	end,
	Play103102024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 103102024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play103102025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1019ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1019ui_story == nil then
				arg_98_1.var_.characterEffect1019ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.1

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1019ui_story and not isNil(var_101_0) then
					local var_101_4 = Mathf.Lerp(0, 0.5, var_101_3)

					arg_98_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1019ui_story.fillRatio = var_101_4
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1019ui_story then
				local var_101_5 = 0.5

				arg_98_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1019ui_story.fillRatio = var_101_5
			end

			local var_101_6 = 0
			local var_101_7 = 0.55

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_8 = arg_98_1:GetWordFromCfg(103102024)
				local var_101_9 = arg_98_1:FormatText(var_101_8.content)

				arg_98_1.text_.text = var_101_9

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_10 = 22
				local var_101_11 = utf8.len(var_101_9)
				local var_101_12 = var_101_10 <= 0 and var_101_7 or var_101_7 * (var_101_11 / var_101_10)

				if var_101_12 > 0 and var_101_7 < var_101_12 then
					arg_98_1.talkMaxDuration = var_101_12

					if var_101_12 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_12 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_9
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_13 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_13 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_13

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_13 and arg_98_1.time_ < var_101_6 + var_101_13 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play103102025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 103102025
		arg_102_1.duration_ = 8.5

		local var_102_0 = {
			ja = 8.5,
			ko = 6.766,
			zh = 7.933,
			en = 8.366
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play103102026(arg_102_1)
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
					arg_102_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect4010ui_story then
				arg_102_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_105_4 = 0

			if var_105_4 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010actionlink/4010action426")
			end

			local var_105_6 = 0
			local var_105_7 = 0.9

			if var_105_6 < arg_102_1.time_ and arg_102_1.time_ <= var_105_6 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_8 = arg_102_1:FormatText(StoryNameCfg[42].name)

				arg_102_1.leftNameTxt_.text = var_105_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_9 = arg_102_1:GetWordFromCfg(103102025)
				local var_105_10 = arg_102_1:FormatText(var_105_9.content)

				arg_102_1.text_.text = var_105_10

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_11 = 36
				local var_105_12 = utf8.len(var_105_10)
				local var_105_13 = var_105_11 <= 0 and var_105_7 or var_105_7 * (var_105_12 / var_105_11)

				if var_105_13 > 0 and var_105_7 < var_105_13 then
					arg_102_1.talkMaxDuration = var_105_13

					if var_105_13 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_13 + var_105_6
					end
				end

				arg_102_1.text_.text = var_105_10
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102025", "story_v_out_103102.awb") ~= 0 then
					local var_105_14 = manager.audio:GetVoiceLength("story_v_out_103102", "103102025", "story_v_out_103102.awb") / 1000

					if var_105_14 + var_105_6 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_14 + var_105_6
					end

					if var_105_9.prefab_name ~= "" and arg_102_1.actors_[var_105_9.prefab_name] ~= nil then
						local var_105_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_9.prefab_name].transform, "story_v_out_103102", "103102025", "story_v_out_103102.awb")

						arg_102_1:RecordAudio("103102025", var_105_15)
						arg_102_1:RecordAudio("103102025", var_105_15)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_103102", "103102025", "story_v_out_103102.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_103102", "103102025", "story_v_out_103102.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_16 = math.max(var_105_7, arg_102_1.talkMaxDuration)

			if var_105_6 <= arg_102_1.time_ and arg_102_1.time_ < var_105_6 + var_105_16 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_6) / var_105_16

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_6 + var_105_16 and arg_102_1.time_ < var_105_6 + var_105_16 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play103102026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 103102026
		arg_106_1.duration_ = 3.13

		local var_106_0 = {
			ja = 3.133,
			ko = 1.999999999999,
			zh = 2.1,
			en = 2.933
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
				arg_106_0:Play103102027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1019ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1019ui_story == nil then
				arg_106_1.var_.characterEffect1019ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.1

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1019ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1019ui_story then
				arg_106_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_109_4 = arg_106_1.actors_["4010ui_story"]
			local var_109_5 = 0

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect4010ui_story == nil then
				arg_106_1.var_.characterEffect4010ui_story = var_109_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_6 = 0.1

			if var_109_5 <= arg_106_1.time_ and arg_106_1.time_ < var_109_5 + var_109_6 and not isNil(var_109_4) then
				local var_109_7 = (arg_106_1.time_ - var_109_5) / var_109_6

				if arg_106_1.var_.characterEffect4010ui_story and not isNil(var_109_4) then
					local var_109_8 = Mathf.Lerp(0, 0.5, var_109_7)

					arg_106_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_106_1.var_.characterEffect4010ui_story.fillRatio = var_109_8
				end
			end

			if arg_106_1.time_ >= var_109_5 + var_109_6 and arg_106_1.time_ < var_109_5 + var_109_6 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect4010ui_story then
				local var_109_9 = 0.5

				arg_106_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_106_1.var_.characterEffect4010ui_story.fillRatio = var_109_9
			end

			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 then
				arg_106_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			local var_109_11 = 0

			if var_109_11 < arg_106_1.time_ and arg_106_1.time_ <= var_109_11 + arg_109_0 then
				arg_106_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_109_12 = 0
			local var_109_13 = 0.3

			if var_109_12 < arg_106_1.time_ and arg_106_1.time_ <= var_109_12 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_14 = arg_106_1:FormatText(StoryNameCfg[13].name)

				arg_106_1.leftNameTxt_.text = var_109_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_15 = arg_106_1:GetWordFromCfg(103102026)
				local var_109_16 = arg_106_1:FormatText(var_109_15.content)

				arg_106_1.text_.text = var_109_16

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_17 = 12
				local var_109_18 = utf8.len(var_109_16)
				local var_109_19 = var_109_17 <= 0 and var_109_13 or var_109_13 * (var_109_18 / var_109_17)

				if var_109_19 > 0 and var_109_13 < var_109_19 then
					arg_106_1.talkMaxDuration = var_109_19

					if var_109_19 + var_109_12 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_19 + var_109_12
					end
				end

				arg_106_1.text_.text = var_109_16
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102026", "story_v_out_103102.awb") ~= 0 then
					local var_109_20 = manager.audio:GetVoiceLength("story_v_out_103102", "103102026", "story_v_out_103102.awb") / 1000

					if var_109_20 + var_109_12 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_20 + var_109_12
					end

					if var_109_15.prefab_name ~= "" and arg_106_1.actors_[var_109_15.prefab_name] ~= nil then
						local var_109_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_15.prefab_name].transform, "story_v_out_103102", "103102026", "story_v_out_103102.awb")

						arg_106_1:RecordAudio("103102026", var_109_21)
						arg_106_1:RecordAudio("103102026", var_109_21)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_103102", "103102026", "story_v_out_103102.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_103102", "103102026", "story_v_out_103102.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_22 = math.max(var_109_13, arg_106_1.talkMaxDuration)

			if var_109_12 <= arg_106_1.time_ and arg_106_1.time_ < var_109_12 + var_109_22 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_12) / var_109_22

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_12 + var_109_22 and arg_106_1.time_ < var_109_12 + var_109_22 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play103102027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 103102027
		arg_110_1.duration_ = 4.4

		local var_110_0 = {
			ja = 4.4,
			ko = 3.566,
			zh = 3.366,
			en = 3.866
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
				arg_110_0:Play103102028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = "3009ui_story"

			if arg_110_1.actors_[var_113_0] == nil then
				local var_113_1 = Asset.Load("Char/" .. "3009ui_story")

				if not isNil(var_113_1) then
					local var_113_2 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_110_1.stage_.transform)

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

			local var_113_5 = arg_110_1.actors_["3009ui_story"]
			local var_113_6 = 0

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 and not isNil(var_113_5) and arg_110_1.var_.characterEffect3009ui_story == nil then
				arg_110_1.var_.characterEffect3009ui_story = var_113_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_7 = 0.1

			if var_113_6 <= arg_110_1.time_ and arg_110_1.time_ < var_113_6 + var_113_7 and not isNil(var_113_5) then
				local var_113_8 = (arg_110_1.time_ - var_113_6) / var_113_7

				if arg_110_1.var_.characterEffect3009ui_story and not isNil(var_113_5) then
					arg_110_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_6 + var_113_7 and arg_110_1.time_ < var_113_6 + var_113_7 + arg_113_0 and not isNil(var_113_5) and arg_110_1.var_.characterEffect3009ui_story then
				arg_110_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_113_9 = arg_110_1.actors_["1019ui_story"]
			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 and not isNil(var_113_9) and arg_110_1.var_.characterEffect1019ui_story == nil then
				arg_110_1.var_.characterEffect1019ui_story = var_113_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_11 = 0.1

			if var_113_10 <= arg_110_1.time_ and arg_110_1.time_ < var_113_10 + var_113_11 and not isNil(var_113_9) then
				local var_113_12 = (arg_110_1.time_ - var_113_10) / var_113_11

				if arg_110_1.var_.characterEffect1019ui_story and not isNil(var_113_9) then
					local var_113_13 = Mathf.Lerp(0, 0.5, var_113_12)

					arg_110_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1019ui_story.fillRatio = var_113_13
				end
			end

			if arg_110_1.time_ >= var_113_10 + var_113_11 and arg_110_1.time_ < var_113_10 + var_113_11 + arg_113_0 and not isNil(var_113_9) and arg_110_1.var_.characterEffect1019ui_story then
				local var_113_14 = 0.5

				arg_110_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1019ui_story.fillRatio = var_113_14
			end

			local var_113_15 = arg_110_1.actors_["1019ui_story"].transform
			local var_113_16 = 0

			if var_113_16 < arg_110_1.time_ and arg_110_1.time_ <= var_113_16 + arg_113_0 then
				arg_110_1.var_.moveOldPos1019ui_story = var_113_15.localPosition
			end

			local var_113_17 = 0.001

			if var_113_16 <= arg_110_1.time_ and arg_110_1.time_ < var_113_16 + var_113_17 then
				local var_113_18 = (arg_110_1.time_ - var_113_16) / var_113_17
				local var_113_19 = Vector3.New(0, 100, 0)

				var_113_15.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1019ui_story, var_113_19, var_113_18)

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

			local var_113_24 = arg_110_1.actors_["4010ui_story"].transform
			local var_113_25 = 0

			if var_113_25 < arg_110_1.time_ and arg_110_1.time_ <= var_113_25 + arg_113_0 then
				arg_110_1.var_.moveOldPos4010ui_story = var_113_24.localPosition
			end

			local var_113_26 = 0.001

			if var_113_25 <= arg_110_1.time_ and arg_110_1.time_ < var_113_25 + var_113_26 then
				local var_113_27 = (arg_110_1.time_ - var_113_25) / var_113_26
				local var_113_28 = Vector3.New(0, 100, 0)

				var_113_24.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos4010ui_story, var_113_28, var_113_27)

				local var_113_29 = manager.ui.mainCamera.transform.position - var_113_24.position

				var_113_24.forward = Vector3.New(var_113_29.x, var_113_29.y, var_113_29.z)

				local var_113_30 = var_113_24.localEulerAngles

				var_113_30.z = 0
				var_113_30.x = 0
				var_113_24.localEulerAngles = var_113_30
			end

			if arg_110_1.time_ >= var_113_25 + var_113_26 and arg_110_1.time_ < var_113_25 + var_113_26 + arg_113_0 then
				var_113_24.localPosition = Vector3.New(0, 100, 0)

				local var_113_31 = manager.ui.mainCamera.transform.position - var_113_24.position

				var_113_24.forward = Vector3.New(var_113_31.x, var_113_31.y, var_113_31.z)

				local var_113_32 = var_113_24.localEulerAngles

				var_113_32.z = 0
				var_113_32.x = 0
				var_113_24.localEulerAngles = var_113_32
			end

			local var_113_33 = arg_110_1.actors_["3009ui_story"].transform
			local var_113_34 = 0

			if var_113_34 < arg_110_1.time_ and arg_110_1.time_ <= var_113_34 + arg_113_0 then
				arg_110_1.var_.moveOldPos3009ui_story = var_113_33.localPosition

				local var_113_35 = "3009ui_story"

				arg_110_1:ShowWeapon(arg_110_1.var_[var_113_35 .. "Animator"].transform, true)
			end

			local var_113_36 = 0.001

			if var_113_34 <= arg_110_1.time_ and arg_110_1.time_ < var_113_34 + var_113_36 then
				local var_113_37 = (arg_110_1.time_ - var_113_34) / var_113_36
				local var_113_38 = Vector3.New(0, -1.75, -4.8)

				var_113_33.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos3009ui_story, var_113_38, var_113_37)

				local var_113_39 = manager.ui.mainCamera.transform.position - var_113_33.position

				var_113_33.forward = Vector3.New(var_113_39.x, var_113_39.y, var_113_39.z)

				local var_113_40 = var_113_33.localEulerAngles

				var_113_40.z = 0
				var_113_40.x = 0
				var_113_33.localEulerAngles = var_113_40
			end

			if arg_110_1.time_ >= var_113_34 + var_113_36 and arg_110_1.time_ < var_113_34 + var_113_36 + arg_113_0 then
				var_113_33.localPosition = Vector3.New(0, -1.75, -4.8)

				local var_113_41 = manager.ui.mainCamera.transform.position - var_113_33.position

				var_113_33.forward = Vector3.New(var_113_41.x, var_113_41.y, var_113_41.z)

				local var_113_42 = var_113_33.localEulerAngles

				var_113_42.z = 0
				var_113_42.x = 0
				var_113_33.localEulerAngles = var_113_42
			end

			local var_113_43 = 0

			if var_113_43 < arg_110_1.time_ and arg_110_1.time_ <= var_113_43 + arg_113_0 then
				arg_110_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_1")
			end

			local var_113_44 = 0

			if var_113_44 < arg_110_1.time_ and arg_110_1.time_ <= var_113_44 + arg_113_0 then
				arg_110_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_113_45 = 0
			local var_113_46 = 0.425

			if var_113_45 < arg_110_1.time_ and arg_110_1.time_ <= var_113_45 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_47 = arg_110_1:FormatText(StoryNameCfg[43].name)

				arg_110_1.leftNameTxt_.text = var_113_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_48 = arg_110_1:GetWordFromCfg(103102027)
				local var_113_49 = arg_110_1:FormatText(var_113_48.content)

				arg_110_1.text_.text = var_113_49

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_50 = 17
				local var_113_51 = utf8.len(var_113_49)
				local var_113_52 = var_113_50 <= 0 and var_113_46 or var_113_46 * (var_113_51 / var_113_50)

				if var_113_52 > 0 and var_113_46 < var_113_52 then
					arg_110_1.talkMaxDuration = var_113_52

					if var_113_52 + var_113_45 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_52 + var_113_45
					end
				end

				arg_110_1.text_.text = var_113_49
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102027", "story_v_out_103102.awb") ~= 0 then
					local var_113_53 = manager.audio:GetVoiceLength("story_v_out_103102", "103102027", "story_v_out_103102.awb") / 1000

					if var_113_53 + var_113_45 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_53 + var_113_45
					end

					if var_113_48.prefab_name ~= "" and arg_110_1.actors_[var_113_48.prefab_name] ~= nil then
						local var_113_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_48.prefab_name].transform, "story_v_out_103102", "103102027", "story_v_out_103102.awb")

						arg_110_1:RecordAudio("103102027", var_113_54)
						arg_110_1:RecordAudio("103102027", var_113_54)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_103102", "103102027", "story_v_out_103102.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_103102", "103102027", "story_v_out_103102.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_55 = math.max(var_113_46, arg_110_1.talkMaxDuration)

			if var_113_45 <= arg_110_1.time_ and arg_110_1.time_ < var_113_45 + var_113_55 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_45) / var_113_55

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_45 + var_113_55 and arg_110_1.time_ < var_113_45 + var_113_55 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
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

		arg_110_1:InitPlayNodeList()
	end,
	Play103102028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 103102028
		arg_114_1.duration_ = 8.93

		local var_114_0 = {
			ja = 8.933,
			ko = 4.6,
			zh = 4,
			en = 5.033
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play103102029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 0

			if var_117_0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_117_1 = 0
			local var_117_2 = 0.6

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_3 = arg_114_1:FormatText(StoryNameCfg[43].name)

				arg_114_1.leftNameTxt_.text = var_117_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_4 = arg_114_1:GetWordFromCfg(103102028)
				local var_117_5 = arg_114_1:FormatText(var_117_4.content)

				arg_114_1.text_.text = var_117_5

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_6 = 24
				local var_117_7 = utf8.len(var_117_5)
				local var_117_8 = var_117_6 <= 0 and var_117_2 or var_117_2 * (var_117_7 / var_117_6)

				if var_117_8 > 0 and var_117_2 < var_117_8 then
					arg_114_1.talkMaxDuration = var_117_8

					if var_117_8 + var_117_1 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_1
					end
				end

				arg_114_1.text_.text = var_117_5
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102028", "story_v_out_103102.awb") ~= 0 then
					local var_117_9 = manager.audio:GetVoiceLength("story_v_out_103102", "103102028", "story_v_out_103102.awb") / 1000

					if var_117_9 + var_117_1 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_9 + var_117_1
					end

					if var_117_4.prefab_name ~= "" and arg_114_1.actors_[var_117_4.prefab_name] ~= nil then
						local var_117_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_4.prefab_name].transform, "story_v_out_103102", "103102028", "story_v_out_103102.awb")

						arg_114_1:RecordAudio("103102028", var_117_10)
						arg_114_1:RecordAudio("103102028", var_117_10)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_103102", "103102028", "story_v_out_103102.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_103102", "103102028", "story_v_out_103102.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_11 = math.max(var_117_2, arg_114_1.talkMaxDuration)

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_11 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_1) / var_117_11

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_1 + var_117_11 and arg_114_1.time_ < var_117_1 + var_117_11 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play103102029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 103102029
		arg_118_1.duration_ = 9.2

		local var_118_0 = {
			ja = 9.2,
			ko = 6.533,
			zh = 7.6,
			en = 7.933
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
				arg_118_0:Play103102030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["4010ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect4010ui_story == nil then
				arg_118_1.var_.characterEffect4010ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.1

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect4010ui_story and not isNil(var_121_0) then
					arg_118_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect4010ui_story then
				arg_118_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_121_4 = arg_118_1.actors_["3009ui_story"]
			local var_121_5 = 0

			if var_121_5 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect3009ui_story == nil then
				arg_118_1.var_.characterEffect3009ui_story = var_121_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_6 = 0.1

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 and not isNil(var_121_4) then
				local var_121_7 = (arg_118_1.time_ - var_121_5) / var_121_6

				if arg_118_1.var_.characterEffect3009ui_story and not isNil(var_121_4) then
					local var_121_8 = Mathf.Lerp(0, 0.5, var_121_7)

					arg_118_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_118_1.var_.characterEffect3009ui_story.fillRatio = var_121_8
				end
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect3009ui_story then
				local var_121_9 = 0.5

				arg_118_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_118_1.var_.characterEffect3009ui_story.fillRatio = var_121_9
			end

			local var_121_10 = arg_118_1.actors_["3009ui_story"].transform
			local var_121_11 = 0

			if var_121_11 < arg_118_1.time_ and arg_118_1.time_ <= var_121_11 + arg_121_0 then
				arg_118_1.var_.moveOldPos3009ui_story = var_121_10.localPosition
			end

			local var_121_12 = 0.001

			if var_121_11 <= arg_118_1.time_ and arg_118_1.time_ < var_121_11 + var_121_12 then
				local var_121_13 = (arg_118_1.time_ - var_121_11) / var_121_12
				local var_121_14 = Vector3.New(0, 100, 0)

				var_121_10.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos3009ui_story, var_121_14, var_121_13)

				local var_121_15 = manager.ui.mainCamera.transform.position - var_121_10.position

				var_121_10.forward = Vector3.New(var_121_15.x, var_121_15.y, var_121_15.z)

				local var_121_16 = var_121_10.localEulerAngles

				var_121_16.z = 0
				var_121_16.x = 0
				var_121_10.localEulerAngles = var_121_16
			end

			if arg_118_1.time_ >= var_121_11 + var_121_12 and arg_118_1.time_ < var_121_11 + var_121_12 + arg_121_0 then
				var_121_10.localPosition = Vector3.New(0, 100, 0)

				local var_121_17 = manager.ui.mainCamera.transform.position - var_121_10.position

				var_121_10.forward = Vector3.New(var_121_17.x, var_121_17.y, var_121_17.z)

				local var_121_18 = var_121_10.localEulerAngles

				var_121_18.z = 0
				var_121_18.x = 0
				var_121_10.localEulerAngles = var_121_18
			end

			local var_121_19 = arg_118_1.actors_["4010ui_story"].transform
			local var_121_20 = 0

			if var_121_20 < arg_118_1.time_ and arg_118_1.time_ <= var_121_20 + arg_121_0 then
				arg_118_1.var_.moveOldPos4010ui_story = var_121_19.localPosition
			end

			local var_121_21 = 0.001

			if var_121_20 <= arg_118_1.time_ and arg_118_1.time_ < var_121_20 + var_121_21 then
				local var_121_22 = (arg_118_1.time_ - var_121_20) / var_121_21
				local var_121_23 = Vector3.New(0, -1.59, -5.2)

				var_121_19.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos4010ui_story, var_121_23, var_121_22)

				local var_121_24 = manager.ui.mainCamera.transform.position - var_121_19.position

				var_121_19.forward = Vector3.New(var_121_24.x, var_121_24.y, var_121_24.z)

				local var_121_25 = var_121_19.localEulerAngles

				var_121_25.z = 0
				var_121_25.x = 0
				var_121_19.localEulerAngles = var_121_25
			end

			if arg_118_1.time_ >= var_121_20 + var_121_21 and arg_118_1.time_ < var_121_20 + var_121_21 + arg_121_0 then
				var_121_19.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_121_26 = manager.ui.mainCamera.transform.position - var_121_19.position

				var_121_19.forward = Vector3.New(var_121_26.x, var_121_26.y, var_121_26.z)

				local var_121_27 = var_121_19.localEulerAngles

				var_121_27.z = 0
				var_121_27.x = 0
				var_121_19.localEulerAngles = var_121_27
			end

			local var_121_28 = 0

			if var_121_28 < arg_118_1.time_ and arg_118_1.time_ <= var_121_28 + arg_121_0 then
				arg_118_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_121_29 = 0

			if var_121_29 < arg_118_1.time_ and arg_118_1.time_ <= var_121_29 + arg_121_0 then
				arg_118_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_121_30 = 0
			local var_121_31 = 0.925

			if var_121_30 < arg_118_1.time_ and arg_118_1.time_ <= var_121_30 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_32 = arg_118_1:FormatText(StoryNameCfg[42].name)

				arg_118_1.leftNameTxt_.text = var_121_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_33 = arg_118_1:GetWordFromCfg(103102029)
				local var_121_34 = arg_118_1:FormatText(var_121_33.content)

				arg_118_1.text_.text = var_121_34

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_35 = 37
				local var_121_36 = utf8.len(var_121_34)
				local var_121_37 = var_121_35 <= 0 and var_121_31 or var_121_31 * (var_121_36 / var_121_35)

				if var_121_37 > 0 and var_121_31 < var_121_37 then
					arg_118_1.talkMaxDuration = var_121_37

					if var_121_37 + var_121_30 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_37 + var_121_30
					end
				end

				arg_118_1.text_.text = var_121_34
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102029", "story_v_out_103102.awb") ~= 0 then
					local var_121_38 = manager.audio:GetVoiceLength("story_v_out_103102", "103102029", "story_v_out_103102.awb") / 1000

					if var_121_38 + var_121_30 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_38 + var_121_30
					end

					if var_121_33.prefab_name ~= "" and arg_118_1.actors_[var_121_33.prefab_name] ~= nil then
						local var_121_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_33.prefab_name].transform, "story_v_out_103102", "103102029", "story_v_out_103102.awb")

						arg_118_1:RecordAudio("103102029", var_121_39)
						arg_118_1:RecordAudio("103102029", var_121_39)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_103102", "103102029", "story_v_out_103102.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_103102", "103102029", "story_v_out_103102.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_40 = math.max(var_121_31, arg_118_1.talkMaxDuration)

			if var_121_30 <= arg_118_1.time_ and arg_118_1.time_ < var_121_30 + var_121_40 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_30) / var_121_40

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_30 + var_121_40 and arg_118_1.time_ < var_121_30 + var_121_40 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
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
	Play103102030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 103102030
		arg_122_1.duration_ = 2

		local var_122_0 = {
			ja = 1.999999999999,
			ko = 2,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_122_0:Play103102031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1084ui_story"]
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = var_125_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_2 = 0.1

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 and not isNil(var_125_0) then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2

				if arg_122_1.var_.characterEffect1084ui_story and not isNil(var_125_0) then
					arg_122_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 and not isNil(var_125_0) and arg_122_1.var_.characterEffect1084ui_story then
				arg_122_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_125_4 = arg_122_1.actors_["4010ui_story"]
			local var_125_5 = 0

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect4010ui_story == nil then
				arg_122_1.var_.characterEffect4010ui_story = var_125_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_6 = 0.1

			if var_125_5 <= arg_122_1.time_ and arg_122_1.time_ < var_125_5 + var_125_6 and not isNil(var_125_4) then
				local var_125_7 = (arg_122_1.time_ - var_125_5) / var_125_6

				if arg_122_1.var_.characterEffect4010ui_story and not isNil(var_125_4) then
					local var_125_8 = Mathf.Lerp(0, 0.5, var_125_7)

					arg_122_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_122_1.var_.characterEffect4010ui_story.fillRatio = var_125_8
				end
			end

			if arg_122_1.time_ >= var_125_5 + var_125_6 and arg_122_1.time_ < var_125_5 + var_125_6 + arg_125_0 and not isNil(var_125_4) and arg_122_1.var_.characterEffect4010ui_story then
				local var_125_9 = 0.5

				arg_122_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_122_1.var_.characterEffect4010ui_story.fillRatio = var_125_9
			end

			local var_125_10 = arg_122_1.actors_["4010ui_story"].transform
			local var_125_11 = 0

			if var_125_11 < arg_122_1.time_ and arg_122_1.time_ <= var_125_11 + arg_125_0 then
				arg_122_1.var_.moveOldPos4010ui_story = var_125_10.localPosition
			end

			local var_125_12 = 0.001

			if var_125_11 <= arg_122_1.time_ and arg_122_1.time_ < var_125_11 + var_125_12 then
				local var_125_13 = (arg_122_1.time_ - var_125_11) / var_125_12
				local var_125_14 = Vector3.New(0, 100, 0)

				var_125_10.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos4010ui_story, var_125_14, var_125_13)

				local var_125_15 = manager.ui.mainCamera.transform.position - var_125_10.position

				var_125_10.forward = Vector3.New(var_125_15.x, var_125_15.y, var_125_15.z)

				local var_125_16 = var_125_10.localEulerAngles

				var_125_16.z = 0
				var_125_16.x = 0
				var_125_10.localEulerAngles = var_125_16
			end

			if arg_122_1.time_ >= var_125_11 + var_125_12 and arg_122_1.time_ < var_125_11 + var_125_12 + arg_125_0 then
				var_125_10.localPosition = Vector3.New(0, 100, 0)

				local var_125_17 = manager.ui.mainCamera.transform.position - var_125_10.position

				var_125_10.forward = Vector3.New(var_125_17.x, var_125_17.y, var_125_17.z)

				local var_125_18 = var_125_10.localEulerAngles

				var_125_18.z = 0
				var_125_18.x = 0
				var_125_10.localEulerAngles = var_125_18
			end

			local var_125_19 = 0

			if var_125_19 < arg_122_1.time_ and arg_122_1.time_ <= var_125_19 + arg_125_0 then
				arg_122_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_125_20 = arg_122_1.actors_["1084ui_story"].transform
			local var_125_21 = 0

			if var_125_21 < arg_122_1.time_ and arg_122_1.time_ <= var_125_21 + arg_125_0 then
				arg_122_1.var_.moveOldPos1084ui_story = var_125_20.localPosition

				local var_125_22 = "1084ui_story"

				arg_122_1:ShowWeapon(arg_122_1.var_[var_125_22 .. "Animator"].transform, true)
			end

			local var_125_23 = 0.001

			if var_125_21 <= arg_122_1.time_ and arg_122_1.time_ < var_125_21 + var_125_23 then
				local var_125_24 = (arg_122_1.time_ - var_125_21) / var_125_23
				local var_125_25 = Vector3.New(0, -0.97, -6)

				var_125_20.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1084ui_story, var_125_25, var_125_24)

				local var_125_26 = manager.ui.mainCamera.transform.position - var_125_20.position

				var_125_20.forward = Vector3.New(var_125_26.x, var_125_26.y, var_125_26.z)

				local var_125_27 = var_125_20.localEulerAngles

				var_125_27.z = 0
				var_125_27.x = 0
				var_125_20.localEulerAngles = var_125_27
			end

			if arg_122_1.time_ >= var_125_21 + var_125_23 and arg_122_1.time_ < var_125_21 + var_125_23 + arg_125_0 then
				var_125_20.localPosition = Vector3.New(0, -0.97, -6)

				local var_125_28 = manager.ui.mainCamera.transform.position - var_125_20.position

				var_125_20.forward = Vector3.New(var_125_28.x, var_125_28.y, var_125_28.z)

				local var_125_29 = var_125_20.localEulerAngles

				var_125_29.z = 0
				var_125_29.x = 0
				var_125_20.localEulerAngles = var_125_29
			end

			local var_125_30 = 0

			if var_125_30 < arg_122_1.time_ and arg_122_1.time_ <= var_125_30 + arg_125_0 then
				arg_122_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_125_31 = 0
			local var_125_32 = 0.15

			if var_125_31 < arg_122_1.time_ and arg_122_1.time_ <= var_125_31 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_33 = arg_122_1:FormatText(StoryNameCfg[6].name)

				arg_122_1.leftNameTxt_.text = var_125_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_34 = arg_122_1:GetWordFromCfg(103102030)
				local var_125_35 = arg_122_1:FormatText(var_125_34.content)

				arg_122_1.text_.text = var_125_35

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_36 = 6
				local var_125_37 = utf8.len(var_125_35)
				local var_125_38 = var_125_36 <= 0 and var_125_32 or var_125_32 * (var_125_37 / var_125_36)

				if var_125_38 > 0 and var_125_32 < var_125_38 then
					arg_122_1.talkMaxDuration = var_125_38

					if var_125_38 + var_125_31 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_38 + var_125_31
					end
				end

				arg_122_1.text_.text = var_125_35
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102030", "story_v_out_103102.awb") ~= 0 then
					local var_125_39 = manager.audio:GetVoiceLength("story_v_out_103102", "103102030", "story_v_out_103102.awb") / 1000

					if var_125_39 + var_125_31 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_39 + var_125_31
					end

					if var_125_34.prefab_name ~= "" and arg_122_1.actors_[var_125_34.prefab_name] ~= nil then
						local var_125_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_34.prefab_name].transform, "story_v_out_103102", "103102030", "story_v_out_103102.awb")

						arg_122_1:RecordAudio("103102030", var_125_40)
						arg_122_1:RecordAudio("103102030", var_125_40)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_103102", "103102030", "story_v_out_103102.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_103102", "103102030", "story_v_out_103102.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_41 = math.max(var_125_32, arg_122_1.talkMaxDuration)

			if var_125_31 <= arg_122_1.time_ and arg_122_1.time_ < var_125_31 + var_125_41 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_31) / var_125_41

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_31 + var_125_41 and arg_122_1.time_ < var_125_31 + var_125_41 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
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
	Play103102031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 103102031
		arg_126_1.duration_ = 14.43

		local var_126_0 = {
			ja = 14.433,
			ko = 10.066,
			zh = 11.466,
			en = 9.5
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
				arg_126_0:Play103102032(arg_126_1)
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

			local var_129_4 = arg_126_1.actors_["1084ui_story"]
			local var_129_5 = 0

			if var_129_5 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect1084ui_story == nil then
				arg_126_1.var_.characterEffect1084ui_story = var_129_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_6 = 0.1

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_6 and not isNil(var_129_4) then
				local var_129_7 = (arg_126_1.time_ - var_129_5) / var_129_6

				if arg_126_1.var_.characterEffect1084ui_story and not isNil(var_129_4) then
					local var_129_8 = Mathf.Lerp(0, 0.5, var_129_7)

					arg_126_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1084ui_story.fillRatio = var_129_8
				end
			end

			if arg_126_1.time_ >= var_129_5 + var_129_6 and arg_126_1.time_ < var_129_5 + var_129_6 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect1084ui_story then
				local var_129_9 = 0.5

				arg_126_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1084ui_story.fillRatio = var_129_9
			end

			local var_129_10 = arg_126_1.actors_["1084ui_story"].transform
			local var_129_11 = 0

			if var_129_11 < arg_126_1.time_ and arg_126_1.time_ <= var_129_11 + arg_129_0 then
				arg_126_1.var_.moveOldPos1084ui_story = var_129_10.localPosition

				local var_129_12 = "1084ui_story"

				arg_126_1:ShowWeapon(arg_126_1.var_[var_129_12 .. "Animator"].transform, false)
			end

			local var_129_13 = 0.001

			if var_129_11 <= arg_126_1.time_ and arg_126_1.time_ < var_129_11 + var_129_13 then
				local var_129_14 = (arg_126_1.time_ - var_129_11) / var_129_13
				local var_129_15 = Vector3.New(0, 100, 0)

				var_129_10.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1084ui_story, var_129_15, var_129_14)

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
			end

			local var_129_20 = arg_126_1.actors_["4010ui_story"].transform
			local var_129_21 = 0

			if var_129_21 < arg_126_1.time_ and arg_126_1.time_ <= var_129_21 + arg_129_0 then
				arg_126_1.var_.moveOldPos4010ui_story = var_129_20.localPosition
			end

			local var_129_22 = 0.001

			if var_129_21 <= arg_126_1.time_ and arg_126_1.time_ < var_129_21 + var_129_22 then
				local var_129_23 = (arg_126_1.time_ - var_129_21) / var_129_22
				local var_129_24 = Vector3.New(0, -1.59, -5.2)

				var_129_20.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos4010ui_story, var_129_24, var_129_23)

				local var_129_25 = manager.ui.mainCamera.transform.position - var_129_20.position

				var_129_20.forward = Vector3.New(var_129_25.x, var_129_25.y, var_129_25.z)

				local var_129_26 = var_129_20.localEulerAngles

				var_129_26.z = 0
				var_129_26.x = 0
				var_129_20.localEulerAngles = var_129_26
			end

			if arg_126_1.time_ >= var_129_21 + var_129_22 and arg_126_1.time_ < var_129_21 + var_129_22 + arg_129_0 then
				var_129_20.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_129_27 = manager.ui.mainCamera.transform.position - var_129_20.position

				var_129_20.forward = Vector3.New(var_129_27.x, var_129_27.y, var_129_27.z)

				local var_129_28 = var_129_20.localEulerAngles

				var_129_28.z = 0
				var_129_28.x = 0
				var_129_20.localEulerAngles = var_129_28
			end

			local var_129_29 = 0

			if var_129_29 < arg_126_1.time_ and arg_126_1.time_ <= var_129_29 + arg_129_0 then
				arg_126_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			local var_129_30 = 0

			if var_129_30 < arg_126_1.time_ and arg_126_1.time_ <= var_129_30 + arg_129_0 then
				arg_126_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_129_31 = 0
			local var_129_32 = 1.3

			if var_129_31 < arg_126_1.time_ and arg_126_1.time_ <= var_129_31 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_33 = arg_126_1:FormatText(StoryNameCfg[42].name)

				arg_126_1.leftNameTxt_.text = var_129_33

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_34 = arg_126_1:GetWordFromCfg(103102031)
				local var_129_35 = arg_126_1:FormatText(var_129_34.content)

				arg_126_1.text_.text = var_129_35

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_36 = 54
				local var_129_37 = utf8.len(var_129_35)
				local var_129_38 = var_129_36 <= 0 and var_129_32 or var_129_32 * (var_129_37 / var_129_36)

				if var_129_38 > 0 and var_129_32 < var_129_38 then
					arg_126_1.talkMaxDuration = var_129_38

					if var_129_38 + var_129_31 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_38 + var_129_31
					end
				end

				arg_126_1.text_.text = var_129_35
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102031", "story_v_out_103102.awb") ~= 0 then
					local var_129_39 = manager.audio:GetVoiceLength("story_v_out_103102", "103102031", "story_v_out_103102.awb") / 1000

					if var_129_39 + var_129_31 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_39 + var_129_31
					end

					if var_129_34.prefab_name ~= "" and arg_126_1.actors_[var_129_34.prefab_name] ~= nil then
						local var_129_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_34.prefab_name].transform, "story_v_out_103102", "103102031", "story_v_out_103102.awb")

						arg_126_1:RecordAudio("103102031", var_129_40)
						arg_126_1:RecordAudio("103102031", var_129_40)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_103102", "103102031", "story_v_out_103102.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_103102", "103102031", "story_v_out_103102.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_41 = math.max(var_129_32, arg_126_1.talkMaxDuration)

			if var_129_31 <= arg_126_1.time_ and arg_126_1.time_ < var_129_31 + var_129_41 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_31) / var_129_41

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_31 + var_129_41 and arg_126_1.time_ < var_129_31 + var_129_41 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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
	Play103102032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 103102032
		arg_130_1.duration_ = 6.7

		local var_130_0 = {
			ja = 6.7,
			ko = 5.466,
			zh = 4.366,
			en = 6.266
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play103102033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = "1036ui_story"

			if arg_130_1.actors_[var_133_0] == nil then
				local var_133_1 = Asset.Load("Char/" .. "1036ui_story")

				if not isNil(var_133_1) then
					local var_133_2 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_130_1.stage_.transform)

					var_133_2.name = var_133_0
					var_133_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_130_1.actors_[var_133_0] = var_133_2

					local var_133_3 = var_133_2:GetComponentInChildren(typeof(CharacterEffect))

					var_133_3.enabled = true

					local var_133_4 = GameObjectTools.GetOrAddComponent(var_133_2, typeof(DynamicBoneHelper))

					if var_133_4 then
						var_133_4:EnableDynamicBone(false)
					end

					arg_130_1:ShowWeapon(var_133_3.transform, false)

					arg_130_1.var_[var_133_0 .. "Animator"] = var_133_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_130_1.var_[var_133_0 .. "Animator"].applyRootMotion = true
					arg_130_1.var_[var_133_0 .. "LipSync"] = var_133_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_133_5 = arg_130_1.actors_["1036ui_story"]
			local var_133_6 = 0

			if var_133_6 < arg_130_1.time_ and arg_130_1.time_ <= var_133_6 + arg_133_0 and not isNil(var_133_5) and arg_130_1.var_.characterEffect1036ui_story == nil then
				arg_130_1.var_.characterEffect1036ui_story = var_133_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_7 = 0.1

			if var_133_6 <= arg_130_1.time_ and arg_130_1.time_ < var_133_6 + var_133_7 and not isNil(var_133_5) then
				local var_133_8 = (arg_130_1.time_ - var_133_6) / var_133_7

				if arg_130_1.var_.characterEffect1036ui_story and not isNil(var_133_5) then
					arg_130_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_6 + var_133_7 and arg_130_1.time_ < var_133_6 + var_133_7 + arg_133_0 and not isNil(var_133_5) and arg_130_1.var_.characterEffect1036ui_story then
				arg_130_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_133_9 = arg_130_1.actors_["4010ui_story"]
			local var_133_10 = 0

			if var_133_10 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 and not isNil(var_133_9) and arg_130_1.var_.characterEffect4010ui_story == nil then
				arg_130_1.var_.characterEffect4010ui_story = var_133_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_11 = 0.1

			if var_133_10 <= arg_130_1.time_ and arg_130_1.time_ < var_133_10 + var_133_11 and not isNil(var_133_9) then
				local var_133_12 = (arg_130_1.time_ - var_133_10) / var_133_11

				if arg_130_1.var_.characterEffect4010ui_story and not isNil(var_133_9) then
					local var_133_13 = Mathf.Lerp(0, 0.5, var_133_12)

					arg_130_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_130_1.var_.characterEffect4010ui_story.fillRatio = var_133_13
				end
			end

			if arg_130_1.time_ >= var_133_10 + var_133_11 and arg_130_1.time_ < var_133_10 + var_133_11 + arg_133_0 and not isNil(var_133_9) and arg_130_1.var_.characterEffect4010ui_story then
				local var_133_14 = 0.5

				arg_130_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_130_1.var_.characterEffect4010ui_story.fillRatio = var_133_14
			end

			local var_133_15 = arg_130_1.actors_["4010ui_story"].transform
			local var_133_16 = 0

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				arg_130_1.var_.moveOldPos4010ui_story = var_133_15.localPosition
			end

			local var_133_17 = 0.001

			if var_133_16 <= arg_130_1.time_ and arg_130_1.time_ < var_133_16 + var_133_17 then
				local var_133_18 = (arg_130_1.time_ - var_133_16) / var_133_17
				local var_133_19 = Vector3.New(0, 100, 0)

				var_133_15.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos4010ui_story, var_133_19, var_133_18)

				local var_133_20 = manager.ui.mainCamera.transform.position - var_133_15.position

				var_133_15.forward = Vector3.New(var_133_20.x, var_133_20.y, var_133_20.z)

				local var_133_21 = var_133_15.localEulerAngles

				var_133_21.z = 0
				var_133_21.x = 0
				var_133_15.localEulerAngles = var_133_21
			end

			if arg_130_1.time_ >= var_133_16 + var_133_17 and arg_130_1.time_ < var_133_16 + var_133_17 + arg_133_0 then
				var_133_15.localPosition = Vector3.New(0, 100, 0)

				local var_133_22 = manager.ui.mainCamera.transform.position - var_133_15.position

				var_133_15.forward = Vector3.New(var_133_22.x, var_133_22.y, var_133_22.z)

				local var_133_23 = var_133_15.localEulerAngles

				var_133_23.z = 0
				var_133_23.x = 0
				var_133_15.localEulerAngles = var_133_23
			end

			local var_133_24 = 0

			if var_133_24 < arg_130_1.time_ and arg_130_1.time_ <= var_133_24 + arg_133_0 then
				arg_130_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_133_25 = arg_130_1.actors_["1036ui_story"].transform
			local var_133_26 = 0

			if var_133_26 < arg_130_1.time_ and arg_130_1.time_ <= var_133_26 + arg_133_0 then
				arg_130_1.var_.moveOldPos1036ui_story = var_133_25.localPosition
			end

			local var_133_27 = 0.001

			if var_133_26 <= arg_130_1.time_ and arg_130_1.time_ < var_133_26 + var_133_27 then
				local var_133_28 = (arg_130_1.time_ - var_133_26) / var_133_27
				local var_133_29 = Vector3.New(-0.7, -1.09, -5.78)

				var_133_25.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1036ui_story, var_133_29, var_133_28)

				local var_133_30 = manager.ui.mainCamera.transform.position - var_133_25.position

				var_133_25.forward = Vector3.New(var_133_30.x, var_133_30.y, var_133_30.z)

				local var_133_31 = var_133_25.localEulerAngles

				var_133_31.z = 0
				var_133_31.x = 0
				var_133_25.localEulerAngles = var_133_31
			end

			if arg_130_1.time_ >= var_133_26 + var_133_27 and arg_130_1.time_ < var_133_26 + var_133_27 + arg_133_0 then
				var_133_25.localPosition = Vector3.New(-0.7, -1.09, -5.78)

				local var_133_32 = manager.ui.mainCamera.transform.position - var_133_25.position

				var_133_25.forward = Vector3.New(var_133_32.x, var_133_32.y, var_133_32.z)

				local var_133_33 = var_133_25.localEulerAngles

				var_133_33.z = 0
				var_133_33.x = 0
				var_133_25.localEulerAngles = var_133_33
			end

			local var_133_34 = 0

			if var_133_34 < arg_130_1.time_ and arg_130_1.time_ <= var_133_34 + arg_133_0 then
				arg_130_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_133_35 = 0
			local var_133_36 = 0.65

			if var_133_35 < arg_130_1.time_ and arg_130_1.time_ <= var_133_35 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_37 = arg_130_1:FormatText(StoryNameCfg[5].name)

				arg_130_1.leftNameTxt_.text = var_133_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_38 = arg_130_1:GetWordFromCfg(103102032)
				local var_133_39 = arg_130_1:FormatText(var_133_38.content)

				arg_130_1.text_.text = var_133_39

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_40 = 25
				local var_133_41 = utf8.len(var_133_39)
				local var_133_42 = var_133_40 <= 0 and var_133_36 or var_133_36 * (var_133_41 / var_133_40)

				if var_133_42 > 0 and var_133_36 < var_133_42 then
					arg_130_1.talkMaxDuration = var_133_42

					if var_133_42 + var_133_35 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_42 + var_133_35
					end
				end

				arg_130_1.text_.text = var_133_39
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102032", "story_v_out_103102.awb") ~= 0 then
					local var_133_43 = manager.audio:GetVoiceLength("story_v_out_103102", "103102032", "story_v_out_103102.awb") / 1000

					if var_133_43 + var_133_35 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_43 + var_133_35
					end

					if var_133_38.prefab_name ~= "" and arg_130_1.actors_[var_133_38.prefab_name] ~= nil then
						local var_133_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_38.prefab_name].transform, "story_v_out_103102", "103102032", "story_v_out_103102.awb")

						arg_130_1:RecordAudio("103102032", var_133_44)
						arg_130_1:RecordAudio("103102032", var_133_44)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_103102", "103102032", "story_v_out_103102.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_103102", "103102032", "story_v_out_103102.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_45 = math.max(var_133_36, arg_130_1.talkMaxDuration)

			if var_133_35 <= arg_130_1.time_ and arg_130_1.time_ < var_133_35 + var_133_45 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_35) / var_133_45

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_35 + var_133_45 and arg_130_1.time_ < var_133_35 + var_133_45 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play103102033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 103102033
		arg_134_1.duration_ = 2

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play103102034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["1084ui_story"]
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1084ui_story == nil then
				arg_134_1.var_.characterEffect1084ui_story = var_137_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_2 = 0.1

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 and not isNil(var_137_0) then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2

				if arg_134_1.var_.characterEffect1084ui_story and not isNil(var_137_0) then
					arg_134_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 and not isNil(var_137_0) and arg_134_1.var_.characterEffect1084ui_story then
				arg_134_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_137_4 = arg_134_1.actors_["1036ui_story"]
			local var_137_5 = 0

			if var_137_5 < arg_134_1.time_ and arg_134_1.time_ <= var_137_5 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect1036ui_story == nil then
				arg_134_1.var_.characterEffect1036ui_story = var_137_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_6 = 0.1

			if var_137_5 <= arg_134_1.time_ and arg_134_1.time_ < var_137_5 + var_137_6 and not isNil(var_137_4) then
				local var_137_7 = (arg_134_1.time_ - var_137_5) / var_137_6

				if arg_134_1.var_.characterEffect1036ui_story and not isNil(var_137_4) then
					local var_137_8 = Mathf.Lerp(0, 0.5, var_137_7)

					arg_134_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1036ui_story.fillRatio = var_137_8
				end
			end

			if arg_134_1.time_ >= var_137_5 + var_137_6 and arg_134_1.time_ < var_137_5 + var_137_6 + arg_137_0 and not isNil(var_137_4) and arg_134_1.var_.characterEffect1036ui_story then
				local var_137_9 = 0.5

				arg_134_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1036ui_story.fillRatio = var_137_9
			end

			local var_137_10 = arg_134_1.actors_["1084ui_story"].transform
			local var_137_11 = 0

			if var_137_11 < arg_134_1.time_ and arg_134_1.time_ <= var_137_11 + arg_137_0 then
				arg_134_1.var_.moveOldPos1084ui_story = var_137_10.localPosition

				local var_137_12 = "1084ui_story"

				arg_134_1:ShowWeapon(arg_134_1.var_[var_137_12 .. "Animator"].transform, false)
			end

			local var_137_13 = 0.001

			if var_137_11 <= arg_134_1.time_ and arg_134_1.time_ < var_137_11 + var_137_13 then
				local var_137_14 = (arg_134_1.time_ - var_137_11) / var_137_13
				local var_137_15 = Vector3.New(0.7, -0.97, -6)

				var_137_10.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1084ui_story, var_137_15, var_137_14)

				local var_137_16 = manager.ui.mainCamera.transform.position - var_137_10.position

				var_137_10.forward = Vector3.New(var_137_16.x, var_137_16.y, var_137_16.z)

				local var_137_17 = var_137_10.localEulerAngles

				var_137_17.z = 0
				var_137_17.x = 0
				var_137_10.localEulerAngles = var_137_17
			end

			if arg_134_1.time_ >= var_137_11 + var_137_13 and arg_134_1.time_ < var_137_11 + var_137_13 + arg_137_0 then
				var_137_10.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_137_18 = manager.ui.mainCamera.transform.position - var_137_10.position

				var_137_10.forward = Vector3.New(var_137_18.x, var_137_18.y, var_137_18.z)

				local var_137_19 = var_137_10.localEulerAngles

				var_137_19.z = 0
				var_137_19.x = 0
				var_137_10.localEulerAngles = var_137_19
			end

			local var_137_20 = 0

			if var_137_20 < arg_134_1.time_ and arg_134_1.time_ <= var_137_20 + arg_137_0 then
				arg_134_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_137_21 = 0

			if var_137_21 < arg_134_1.time_ and arg_134_1.time_ <= var_137_21 + arg_137_0 then
				arg_134_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_137_22 = 0
			local var_137_23 = 0.175

			if var_137_22 < arg_134_1.time_ and arg_134_1.time_ <= var_137_22 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_24 = arg_134_1:FormatText(StoryNameCfg[6].name)

				arg_134_1.leftNameTxt_.text = var_137_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_25 = arg_134_1:GetWordFromCfg(103102033)
				local var_137_26 = arg_134_1:FormatText(var_137_25.content)

				arg_134_1.text_.text = var_137_26

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_27 = 7
				local var_137_28 = utf8.len(var_137_26)
				local var_137_29 = var_137_27 <= 0 and var_137_23 or var_137_23 * (var_137_28 / var_137_27)

				if var_137_29 > 0 and var_137_23 < var_137_29 then
					arg_134_1.talkMaxDuration = var_137_29

					if var_137_29 + var_137_22 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_29 + var_137_22
					end
				end

				arg_134_1.text_.text = var_137_26
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102033", "story_v_out_103102.awb") ~= 0 then
					local var_137_30 = manager.audio:GetVoiceLength("story_v_out_103102", "103102033", "story_v_out_103102.awb") / 1000

					if var_137_30 + var_137_22 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_30 + var_137_22
					end

					if var_137_25.prefab_name ~= "" and arg_134_1.actors_[var_137_25.prefab_name] ~= nil then
						local var_137_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_25.prefab_name].transform, "story_v_out_103102", "103102033", "story_v_out_103102.awb")

						arg_134_1:RecordAudio("103102033", var_137_31)
						arg_134_1:RecordAudio("103102033", var_137_31)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_103102", "103102033", "story_v_out_103102.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_103102", "103102033", "story_v_out_103102.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_32 = math.max(var_137_23, arg_134_1.talkMaxDuration)

			if var_137_22 <= arg_134_1.time_ and arg_134_1.time_ < var_137_22 + var_137_32 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_22) / var_137_32

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_22 + var_137_32 and arg_134_1.time_ < var_137_22 + var_137_32 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
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

		arg_134_1:InitPlayNodeList()
	end,
	Play103102034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 103102034
		arg_138_1.duration_ = 6.6

		local var_138_0 = {
			ja = 6.6,
			ko = 4.466,
			zh = 5.766,
			en = 3.366
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
			arg_138_1.auto_ = false
		end

		function arg_138_1.playNext_(arg_140_0)
			arg_138_1.onStoryFinished_()
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = arg_138_1.actors_["4010ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect4010ui_story == nil then
				arg_138_1.var_.characterEffect4010ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.1

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect4010ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect4010ui_story then
				arg_138_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_141_4 = arg_138_1.actors_["1084ui_story"]
			local var_141_5 = 0

			if var_141_5 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect1084ui_story == nil then
				arg_138_1.var_.characterEffect1084ui_story = var_141_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_6 = 0.1

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_6 and not isNil(var_141_4) then
				local var_141_7 = (arg_138_1.time_ - var_141_5) / var_141_6

				if arg_138_1.var_.characterEffect1084ui_story and not isNil(var_141_4) then
					local var_141_8 = Mathf.Lerp(0, 0.5, var_141_7)

					arg_138_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1084ui_story.fillRatio = var_141_8
				end
			end

			if arg_138_1.time_ >= var_141_5 + var_141_6 and arg_138_1.time_ < var_141_5 + var_141_6 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect1084ui_story then
				local var_141_9 = 0.5

				arg_138_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1084ui_story.fillRatio = var_141_9
			end

			local var_141_10 = arg_138_1.actors_["1084ui_story"].transform
			local var_141_11 = 0

			if var_141_11 < arg_138_1.time_ and arg_138_1.time_ <= var_141_11 + arg_141_0 then
				arg_138_1.var_.moveOldPos1084ui_story = var_141_10.localPosition
			end

			local var_141_12 = 0.001

			if var_141_11 <= arg_138_1.time_ and arg_138_1.time_ < var_141_11 + var_141_12 then
				local var_141_13 = (arg_138_1.time_ - var_141_11) / var_141_12
				local var_141_14 = Vector3.New(0, 100, 0)

				var_141_10.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1084ui_story, var_141_14, var_141_13)

				local var_141_15 = manager.ui.mainCamera.transform.position - var_141_10.position

				var_141_10.forward = Vector3.New(var_141_15.x, var_141_15.y, var_141_15.z)

				local var_141_16 = var_141_10.localEulerAngles

				var_141_16.z = 0
				var_141_16.x = 0
				var_141_10.localEulerAngles = var_141_16
			end

			if arg_138_1.time_ >= var_141_11 + var_141_12 and arg_138_1.time_ < var_141_11 + var_141_12 + arg_141_0 then
				var_141_10.localPosition = Vector3.New(0, 100, 0)

				local var_141_17 = manager.ui.mainCamera.transform.position - var_141_10.position

				var_141_10.forward = Vector3.New(var_141_17.x, var_141_17.y, var_141_17.z)

				local var_141_18 = var_141_10.localEulerAngles

				var_141_18.z = 0
				var_141_18.x = 0
				var_141_10.localEulerAngles = var_141_18
			end

			local var_141_19 = arg_138_1.actors_["1036ui_story"].transform
			local var_141_20 = 0

			if var_141_20 < arg_138_1.time_ and arg_138_1.time_ <= var_141_20 + arg_141_0 then
				arg_138_1.var_.moveOldPos1036ui_story = var_141_19.localPosition
			end

			local var_141_21 = 0.001

			if var_141_20 <= arg_138_1.time_ and arg_138_1.time_ < var_141_20 + var_141_21 then
				local var_141_22 = (arg_138_1.time_ - var_141_20) / var_141_21
				local var_141_23 = Vector3.New(0, 100, 0)

				var_141_19.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1036ui_story, var_141_23, var_141_22)

				local var_141_24 = manager.ui.mainCamera.transform.position - var_141_19.position

				var_141_19.forward = Vector3.New(var_141_24.x, var_141_24.y, var_141_24.z)

				local var_141_25 = var_141_19.localEulerAngles

				var_141_25.z = 0
				var_141_25.x = 0
				var_141_19.localEulerAngles = var_141_25
			end

			if arg_138_1.time_ >= var_141_20 + var_141_21 and arg_138_1.time_ < var_141_20 + var_141_21 + arg_141_0 then
				var_141_19.localPosition = Vector3.New(0, 100, 0)

				local var_141_26 = manager.ui.mainCamera.transform.position - var_141_19.position

				var_141_19.forward = Vector3.New(var_141_26.x, var_141_26.y, var_141_26.z)

				local var_141_27 = var_141_19.localEulerAngles

				var_141_27.z = 0
				var_141_27.x = 0
				var_141_19.localEulerAngles = var_141_27
			end

			local var_141_28 = arg_138_1.actors_["4010ui_story"].transform
			local var_141_29 = 0

			if var_141_29 < arg_138_1.time_ and arg_138_1.time_ <= var_141_29 + arg_141_0 then
				arg_138_1.var_.moveOldPos4010ui_story = var_141_28.localPosition
			end

			local var_141_30 = 0.001

			if var_141_29 <= arg_138_1.time_ and arg_138_1.time_ < var_141_29 + var_141_30 then
				local var_141_31 = (arg_138_1.time_ - var_141_29) / var_141_30
				local var_141_32 = Vector3.New(0, -1.59, -5.2)

				var_141_28.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos4010ui_story, var_141_32, var_141_31)

				local var_141_33 = manager.ui.mainCamera.transform.position - var_141_28.position

				var_141_28.forward = Vector3.New(var_141_33.x, var_141_33.y, var_141_33.z)

				local var_141_34 = var_141_28.localEulerAngles

				var_141_34.z = 0
				var_141_34.x = 0
				var_141_28.localEulerAngles = var_141_34
			end

			if arg_138_1.time_ >= var_141_29 + var_141_30 and arg_138_1.time_ < var_141_29 + var_141_30 + arg_141_0 then
				var_141_28.localPosition = Vector3.New(0, -1.59, -5.2)

				local var_141_35 = manager.ui.mainCamera.transform.position - var_141_28.position

				var_141_28.forward = Vector3.New(var_141_35.x, var_141_35.y, var_141_35.z)

				local var_141_36 = var_141_28.localEulerAngles

				var_141_36.z = 0
				var_141_36.x = 0
				var_141_28.localEulerAngles = var_141_36
			end

			local var_141_37 = 0

			if var_141_37 < arg_138_1.time_ and arg_138_1.time_ <= var_141_37 + arg_141_0 then
				arg_138_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_141_38 = 0

			if var_141_38 < arg_138_1.time_ and arg_138_1.time_ <= var_141_38 + arg_141_0 then
				arg_138_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_141_39 = 0
			local var_141_40 = 0.375

			if var_141_39 < arg_138_1.time_ and arg_138_1.time_ <= var_141_39 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_41 = arg_138_1:FormatText(StoryNameCfg[42].name)

				arg_138_1.leftNameTxt_.text = var_141_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_42 = arg_138_1:GetWordFromCfg(103102034)
				local var_141_43 = arg_138_1:FormatText(var_141_42.content)

				arg_138_1.text_.text = var_141_43

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_44 = 15
				local var_141_45 = utf8.len(var_141_43)
				local var_141_46 = var_141_44 <= 0 and var_141_40 or var_141_40 * (var_141_45 / var_141_44)

				if var_141_46 > 0 and var_141_40 < var_141_46 then
					arg_138_1.talkMaxDuration = var_141_46

					if var_141_46 + var_141_39 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_46 + var_141_39
					end
				end

				arg_138_1.text_.text = var_141_43
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102034", "story_v_out_103102.awb") ~= 0 then
					local var_141_47 = manager.audio:GetVoiceLength("story_v_out_103102", "103102034", "story_v_out_103102.awb") / 1000

					if var_141_47 + var_141_39 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_47 + var_141_39
					end

					if var_141_42.prefab_name ~= "" and arg_138_1.actors_[var_141_42.prefab_name] ~= nil then
						local var_141_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_42.prefab_name].transform, "story_v_out_103102", "103102034", "story_v_out_103102.awb")

						arg_138_1:RecordAudio("103102034", var_141_48)
						arg_138_1:RecordAudio("103102034", var_141_48)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_103102", "103102034", "story_v_out_103102.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_103102", "103102034", "story_v_out_103102.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_49 = math.max(var_141_40, arg_138_1.talkMaxDuration)

			if var_141_39 <= arg_138_1.time_ and arg_138_1.time_ < var_141_39 + var_141_49 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_39) / var_141_49

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_39 + var_141_49 and arg_138_1.time_ < var_141_39 + var_141_49 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B03d",
		"TextureConfig/Background/B03f"
	},
	voices = {
		"story_v_out_103102.awb"
	}
}
