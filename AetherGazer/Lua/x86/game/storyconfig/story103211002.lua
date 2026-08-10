return {
	Play321102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321102001
		arg_1_1.duration_ = 7

		local var_1_0 = {
			zh = 4.50000000298023,
			ja = 7.00000000298023
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
				arg_1_0:Play321102002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L10f"

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
				local var_4_5 = arg_1_1.bgs_.L10f

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
					if iter_4_0 ~= "L10f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2

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

			local var_4_24 = "1156ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1156ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1156ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1156ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -1.1, -6.18)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1156ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1156ui_story"]
			local var_4_39 = 1.8

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1156ui_story == nil then
				arg_1_1.var_.characterEffect1156ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1156ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1156ui_story then
				arg_1_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
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

			local var_4_50 = 0.3
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_4_0_story_quake_daily", "bgm_activity_4_0_story_quake_daily", "bgm_activity_4_0_story_quake_daily.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_daily", "bgm_activity_4_0_story_quake_daily")

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

			local var_4_56 = 2.00000000298023
			local var_4_57 = 0.4

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

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[605].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(321102001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102001", "story_v_out_321102.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_321102", "321102001", "story_v_out_321102.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_321102", "321102001", "story_v_out_321102.awb")

						arg_1_1:RecordAudio("321102001", var_4_66)
						arg_1_1:RecordAudio("321102001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_321102", "321102001", "story_v_out_321102.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_321102", "321102001", "story_v_out_321102.awb")
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
				actorName = "1156ui_story",
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
	Play321102002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321102002
		arg_9_1.duration_ = 22

		local var_9_0 = {
			zh = 8.533,
			ja = 22
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
				arg_9_0:Play321102003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1156ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1156ui_story == nil then
				arg_9_1.var_.characterEffect1156ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect1156ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1156ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1156ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1156ui_story.fillRatio = var_12_5
			end

			local var_12_6 = arg_9_1.actors_["1156ui_story"].transform
			local var_12_7 = 0

			if var_12_7 < arg_9_1.time_ and arg_9_1.time_ <= var_12_7 + arg_12_0 then
				arg_9_1.var_.moveOldPos1156ui_story = var_12_6.localPosition
			end

			local var_12_8 = 0.001

			if var_12_7 <= arg_9_1.time_ and arg_9_1.time_ < var_12_7 + var_12_8 then
				local var_12_9 = (arg_9_1.time_ - var_12_7) / var_12_8
				local var_12_10 = Vector3.New(0, 100, 0)

				var_12_6.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1156ui_story, var_12_10, var_12_9)

				local var_12_11 = manager.ui.mainCamera.transform.position - var_12_6.position

				var_12_6.forward = Vector3.New(var_12_11.x, var_12_11.y, var_12_11.z)

				local var_12_12 = var_12_6.localEulerAngles

				var_12_12.z = 0
				var_12_12.x = 0
				var_12_6.localEulerAngles = var_12_12
			end

			if arg_9_1.time_ >= var_12_7 + var_12_8 and arg_9_1.time_ < var_12_7 + var_12_8 + arg_12_0 then
				var_12_6.localPosition = Vector3.New(0, 100, 0)

				local var_12_13 = manager.ui.mainCamera.transform.position - var_12_6.position

				var_12_6.forward = Vector3.New(var_12_13.x, var_12_13.y, var_12_13.z)

				local var_12_14 = var_12_6.localEulerAngles

				var_12_14.z = 0
				var_12_14.x = 0
				var_12_6.localEulerAngles = var_12_14
			end

			local var_12_15 = 0
			local var_12_16 = 0.9

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_17 = arg_9_1:FormatText(StoryNameCfg[600].name)

				arg_9_1.leftNameTxt_.text = var_12_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_18 = arg_9_1:GetWordFromCfg(321102002)
				local var_12_19 = arg_9_1:FormatText(var_12_18.content)

				arg_9_1.text_.text = var_12_19

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_20 = 36
				local var_12_21 = utf8.len(var_12_19)
				local var_12_22 = var_12_20 <= 0 and var_12_16 or var_12_16 * (var_12_21 / var_12_20)

				if var_12_22 > 0 and var_12_16 < var_12_22 then
					arg_9_1.talkMaxDuration = var_12_22

					if var_12_22 + var_12_15 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_22 + var_12_15
					end
				end

				arg_9_1.text_.text = var_12_19
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102002", "story_v_out_321102.awb") ~= 0 then
					local var_12_23 = manager.audio:GetVoiceLength("story_v_out_321102", "321102002", "story_v_out_321102.awb") / 1000

					if var_12_23 + var_12_15 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_23 + var_12_15
					end

					if var_12_18.prefab_name ~= "" and arg_9_1.actors_[var_12_18.prefab_name] ~= nil then
						local var_12_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_18.prefab_name].transform, "story_v_out_321102", "321102002", "story_v_out_321102.awb")

						arg_9_1:RecordAudio("321102002", var_12_24)
						arg_9_1:RecordAudio("321102002", var_12_24)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_321102", "321102002", "story_v_out_321102.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_321102", "321102002", "story_v_out_321102.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_25 = math.max(var_12_16, arg_9_1.talkMaxDuration)

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_25 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_15) / var_12_25

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_15 + var_12_25 and arg_9_1.time_ < var_12_15 + var_12_25 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play321102003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321102003
		arg_13_1.duration_ = 8

		local var_13_0 = {
			zh = 4.333,
			ja = 8
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
				arg_13_0:Play321102004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.525

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[1174].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow10061")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(321102003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102003", "story_v_out_321102.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102003", "story_v_out_321102.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_out_321102", "321102003", "story_v_out_321102.awb")

						arg_13_1:RecordAudio("321102003", var_16_9)
						arg_13_1:RecordAudio("321102003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_321102", "321102003", "story_v_out_321102.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_321102", "321102003", "story_v_out_321102.awb")
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
	Play321102004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321102004
		arg_17_1.duration_ = 5.1

		local var_17_0 = {
			zh = 3.5,
			ja = 5.1
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
				arg_17_0:Play321102005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 0
			local var_20_1 = 0.275

			if var_20_0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_0 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_2 = arg_17_1:FormatText(StoryNameCfg[600].name)

				arg_17_1.leftNameTxt_.text = var_20_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_17_1.callingController_:SetSelectedState("normal")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_3 = arg_17_1:GetWordFromCfg(321102004)
				local var_20_4 = arg_17_1:FormatText(var_20_3.content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 11
				local var_20_6 = utf8.len(var_20_4)
				local var_20_7 = var_20_5 <= 0 and var_20_1 or var_20_1 * (var_20_6 / var_20_5)

				if var_20_7 > 0 and var_20_1 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_0
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102004", "story_v_out_321102.awb") ~= 0 then
					local var_20_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102004", "story_v_out_321102.awb") / 1000

					if var_20_8 + var_20_0 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_8 + var_20_0
					end

					if var_20_3.prefab_name ~= "" and arg_17_1.actors_[var_20_3.prefab_name] ~= nil then
						local var_20_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_3.prefab_name].transform, "story_v_out_321102", "321102004", "story_v_out_321102.awb")

						arg_17_1:RecordAudio("321102004", var_20_9)
						arg_17_1:RecordAudio("321102004", var_20_9)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321102", "321102004", "story_v_out_321102.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321102", "321102004", "story_v_out_321102.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_1, arg_17_1.talkMaxDuration)

			if var_20_0 <= arg_17_1.time_ and arg_17_1.time_ < var_20_0 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_0) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_0 + var_20_10 and arg_17_1.time_ < var_20_0 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play321102005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321102005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play321102006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1156ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1156ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(0, 100, 0)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1156ui_story, var_24_4, var_24_3)

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

			local var_24_9 = 0
			local var_24_10 = 1.35

			if var_24_9 < arg_21_1.time_ and arg_21_1.time_ <= var_24_9 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_11 = arg_21_1:GetWordFromCfg(321102005)
				local var_24_12 = arg_21_1:FormatText(var_24_11.content)

				arg_21_1.text_.text = var_24_12

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 54
				local var_24_14 = utf8.len(var_24_12)
				local var_24_15 = var_24_13 <= 0 and var_24_10 or var_24_10 * (var_24_14 / var_24_13)

				if var_24_15 > 0 and var_24_10 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_9 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_9
					end
				end

				arg_21_1.text_.text = var_24_12
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_10, arg_21_1.talkMaxDuration)

			if var_24_9 <= arg_21_1.time_ and arg_21_1.time_ < var_24_9 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_9) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_9 + var_24_16 and arg_21_1.time_ < var_24_9 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play321102006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321102006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play321102007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.05
			local var_28_1 = 1

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				local var_28_2 = "play"
				local var_28_3 = "effect"

				arg_25_1:AudioAction(var_28_2, var_28_3, "se_story_139", "se_story_139_thunderenergy", "")
			end

			local var_28_4 = 0
			local var_28_5 = 1.1

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(321102006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_8 = 44
				local var_28_9 = utf8.len(var_28_7)
				local var_28_10 = var_28_8 <= 0 and var_28_5 or var_28_5 * (var_28_9 / var_28_8)

				if var_28_10 > 0 and var_28_5 < var_28_10 then
					arg_25_1.talkMaxDuration = var_28_10

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_11 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_11 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_11

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_11 and arg_25_1.time_ < var_28_4 + var_28_11 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play321102007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321102007
		arg_29_1.duration_ = 4.2

		local var_29_0 = {
			zh = 3,
			ja = 4.2
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
				arg_29_0:Play321102008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0
			local var_32_1 = 0.325

			if var_32_0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_2 = arg_29_1:FormatText(StoryNameCfg[1175].name)

				arg_29_1.leftNameTxt_.text = var_32_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2078")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_3 = arg_29_1:GetWordFromCfg(321102007)
				local var_32_4 = arg_29_1:FormatText(var_32_3.content)

				arg_29_1.text_.text = var_32_4

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 13
				local var_32_6 = utf8.len(var_32_4)
				local var_32_7 = var_32_5 <= 0 and var_32_1 or var_32_1 * (var_32_6 / var_32_5)

				if var_32_7 > 0 and var_32_1 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_0
					end
				end

				arg_29_1.text_.text = var_32_4
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102007", "story_v_out_321102.awb") ~= 0 then
					local var_32_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102007", "story_v_out_321102.awb") / 1000

					if var_32_8 + var_32_0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_0
					end

					if var_32_3.prefab_name ~= "" and arg_29_1.actors_[var_32_3.prefab_name] ~= nil then
						local var_32_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_3.prefab_name].transform, "story_v_out_321102", "321102007", "story_v_out_321102.awb")

						arg_29_1:RecordAudio("321102007", var_32_9)
						arg_29_1:RecordAudio("321102007", var_32_9)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_321102", "321102007", "story_v_out_321102.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_321102", "321102007", "story_v_out_321102.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_10 = math.max(var_32_1, arg_29_1.talkMaxDuration)

			if var_32_0 <= arg_29_1.time_ and arg_29_1.time_ < var_32_0 + var_32_10 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_0) / var_32_10

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_0 + var_32_10 and arg_29_1.time_ < var_32_0 + var_32_10 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play321102008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321102008
		arg_33_1.duration_ = 6

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play321102009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = "2078ui_story"

			if arg_33_1.actors_[var_36_0] == nil then
				local var_36_1 = Asset.Load("Char/" .. "2078ui_story")

				if not isNil(var_36_1) then
					local var_36_2 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_33_1.stage_.transform)

					var_36_2.name = var_36_0
					var_36_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_33_1.actors_[var_36_0] = var_36_2

					local var_36_3 = var_36_2:GetComponentInChildren(typeof(CharacterEffect))

					var_36_3.enabled = true

					local var_36_4 = GameObjectTools.GetOrAddComponent(var_36_2, typeof(DynamicBoneHelper))

					if var_36_4 then
						var_36_4:EnableDynamicBone(false)
					end

					arg_33_1:ShowWeapon(var_36_3.transform, false)

					arg_33_1.var_[var_36_0 .. "Animator"] = var_36_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_33_1.var_[var_36_0 .. "Animator"].applyRootMotion = true
					arg_33_1.var_[var_36_0 .. "LipSync"] = var_36_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_36_5 = arg_33_1.actors_["2078ui_story"].transform
			local var_36_6 = 0

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.var_.moveOldPos2078ui_story = var_36_5.localPosition
			end

			local var_36_7 = 0.001

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_7 then
				local var_36_8 = (arg_33_1.time_ - var_36_6) / var_36_7
				local var_36_9 = Vector3.New(0, 100, 0)

				var_36_5.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos2078ui_story, var_36_9, var_36_8)

				local var_36_10 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_10.x, var_36_10.y, var_36_10.z)

				local var_36_11 = var_36_5.localEulerAngles

				var_36_11.z = 0
				var_36_11.x = 0
				var_36_5.localEulerAngles = var_36_11
			end

			if arg_33_1.time_ >= var_36_6 + var_36_7 and arg_33_1.time_ < var_36_6 + var_36_7 + arg_36_0 then
				var_36_5.localPosition = Vector3.New(0, 100, 0)

				local var_36_12 = manager.ui.mainCamera.transform.position - var_36_5.position

				var_36_5.forward = Vector3.New(var_36_12.x, var_36_12.y, var_36_12.z)

				local var_36_13 = var_36_5.localEulerAngles

				var_36_13.z = 0
				var_36_13.x = 0
				var_36_5.localEulerAngles = var_36_13
			end

			local var_36_14 = arg_33_1.actors_["2078ui_story"]
			local var_36_15 = 0

			if var_36_15 < arg_33_1.time_ and arg_33_1.time_ <= var_36_15 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect2078ui_story == nil then
				arg_33_1.var_.characterEffect2078ui_story = var_36_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_16 = 0.200000002980232

			if var_36_15 <= arg_33_1.time_ and arg_33_1.time_ < var_36_15 + var_36_16 and not isNil(var_36_14) then
				local var_36_17 = (arg_33_1.time_ - var_36_15) / var_36_16

				if arg_33_1.var_.characterEffect2078ui_story and not isNil(var_36_14) then
					local var_36_18 = Mathf.Lerp(0, 0.5, var_36_17)

					arg_33_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_33_1.var_.characterEffect2078ui_story.fillRatio = var_36_18
				end
			end

			if arg_33_1.time_ >= var_36_15 + var_36_16 and arg_33_1.time_ < var_36_15 + var_36_16 + arg_36_0 and not isNil(var_36_14) and arg_33_1.var_.characterEffect2078ui_story then
				local var_36_19 = 0.5

				arg_33_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_33_1.var_.characterEffect2078ui_story.fillRatio = var_36_19
			end

			local var_36_20 = manager.ui.mainCamera.transform
			local var_36_21 = 0

			if var_36_21 < arg_33_1.time_ and arg_33_1.time_ <= var_36_21 + arg_36_0 then
				arg_33_1.var_.shakeOldPos = var_36_20.localPosition
			end

			local var_36_22 = 0.642580199241638

			if var_36_21 <= arg_33_1.time_ and arg_33_1.time_ < var_36_21 + var_36_22 then
				local var_36_23 = (arg_33_1.time_ - var_36_21) / 0.066
				local var_36_24, var_36_25 = math.modf(var_36_23)

				var_36_20.localPosition = Vector3.New(var_36_25 * 0.13, var_36_25 * 0.13, var_36_25 * 0.13) + arg_33_1.var_.shakeOldPos
			end

			if arg_33_1.time_ >= var_36_21 + var_36_22 and arg_33_1.time_ < var_36_21 + var_36_22 + arg_36_0 then
				var_36_20.localPosition = arg_33_1.var_.shakeOldPos
			end

			local var_36_26 = manager.ui.mainCamera.transform
			local var_36_27 = 0.034

			if var_36_27 < arg_33_1.time_ and arg_33_1.time_ <= var_36_27 + arg_36_0 then
				local var_36_28 = arg_33_1.var_.effect244
				local var_36_29
				local var_36_30 = var_36_26

				if not var_36_28 then
					var_36_28 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), var_36_30)
					var_36_28.name = "244"
					arg_33_1.var_.effect244 = var_36_28
				else
					var_36_28.transform:SetParent(var_36_30)
				end

				var_36_28.transform.localPosition = Vector3.New(0, 0, 0)
				var_36_28.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_36_31 = manager.ui.mainCameraCom_
				local var_36_32 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_36_31.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_36_33 = var_36_28.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_36_34 = 15
				local var_36_35 = 2 * var_36_34 * Mathf.Tan(var_36_31.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_36_31.aspect
				local var_36_36 = 1
				local var_36_37 = 1.7777777777777777

				if var_36_37 < var_36_31.aspect then
					var_36_36 = var_36_35 / (2 * var_36_34 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_36_37)
				end

				for iter_36_0, iter_36_1 in ipairs(var_36_33) do
					local var_36_38 = iter_36_1.transform.localScale

					iter_36_1.transform.localScale = Vector3.New(var_36_38.x / var_36_32 * var_36_36, var_36_38.y / var_36_32, var_36_38.z)
				end
			end

			local var_36_39 = manager.ui.mainCamera.transform
			local var_36_40 = 0.534

			if var_36_40 < arg_33_1.time_ and arg_33_1.time_ <= var_36_40 + arg_36_0 then
				local var_36_41 = arg_33_1.var_.effect245

				if var_36_41 then
					Object.Destroy(var_36_41)

					arg_33_1.var_.effect245 = nil
				end
			end

			local var_36_42 = 0

			if var_36_42 < arg_33_1.time_ and arg_33_1.time_ <= var_36_42 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_43 = 0.333333333333333

			if var_36_42 <= arg_33_1.time_ and arg_33_1.time_ < var_36_42 + var_36_43 then
				local var_36_44 = (arg_33_1.time_ - var_36_42) / var_36_43
				local var_36_45 = Color.New(1, 1, 1)

				var_36_45.a = Mathf.Lerp(1, 0, var_36_44)
				arg_33_1.mask_.color = var_36_45
			end

			if arg_33_1.time_ >= var_36_42 + var_36_43 and arg_33_1.time_ < var_36_42 + var_36_43 + arg_36_0 then
				local var_36_46 = Color.New(1, 1, 1)
				local var_36_47 = 0

				arg_33_1.mask_.enabled = false
				var_36_46.a = var_36_47
				arg_33_1.mask_.color = var_36_46
			end

			local var_36_48 = manager.ui.mainCamera.transform
			local var_36_49 = 0

			if var_36_49 < arg_33_1.time_ and arg_33_1.time_ <= var_36_49 + arg_36_0 then
				arg_33_1.var_.shakeOldPos = var_36_48.localPosition
			end

			local var_36_50 = 0.466666666666667

			if var_36_49 <= arg_33_1.time_ and arg_33_1.time_ < var_36_49 + var_36_50 then
				local var_36_51 = (arg_33_1.time_ - var_36_49) / 0.066
				local var_36_52, var_36_53 = math.modf(var_36_51)

				var_36_48.localPosition = Vector3.New(var_36_53 * 0.13, var_36_53 * 0.13, var_36_53 * 0.13) + arg_33_1.var_.shakeOldPos
			end

			if arg_33_1.time_ >= var_36_49 + var_36_50 and arg_33_1.time_ < var_36_49 + var_36_50 + arg_36_0 then
				var_36_48.localPosition = arg_33_1.var_.shakeOldPos
			end

			local var_36_54 = 0.05
			local var_36_55 = 1

			if var_36_54 < arg_33_1.time_ and arg_33_1.time_ <= var_36_54 + arg_36_0 then
				local var_36_56 = "play"
				local var_36_57 = "effect"

				arg_33_1:AudioAction(var_36_56, var_36_57, "se_story_138", "se_story_138_thunderhit", "")
			end

			if arg_33_1.frameCnt_ <= 1 then
				arg_33_1.dialog_:SetActive(false)
			end

			local var_36_58 = 1
			local var_36_59 = 1.275

			if var_36_58 < arg_33_1.time_ and arg_33_1.time_ <= var_36_58 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0

				arg_33_1.dialog_:SetActive(true)

				arg_33_1.dialogCg_.alpha = 0

				local var_36_60 = LeanTween.value(arg_33_1.dialog_, 0, 1, 0.3)

				var_36_60:setOnUpdate(LuaHelper.FloatAction(function(arg_37_0)
					arg_33_1.dialogCg_.alpha = arg_37_0
				end))
				var_36_60:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_33_1.dialog_)
					var_36_60:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_33_1.duration_ = arg_33_1.duration_ + 0.3

				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_61 = arg_33_1:GetWordFromCfg(321102008)
				local var_36_62 = arg_33_1:FormatText(var_36_61.content)

				arg_33_1.text_.text = var_36_62

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_63 = 51
				local var_36_64 = utf8.len(var_36_62)
				local var_36_65 = var_36_63 <= 0 and var_36_59 or var_36_59 * (var_36_64 / var_36_63)

				if var_36_65 > 0 and var_36_59 < var_36_65 then
					arg_33_1.talkMaxDuration = var_36_65
					var_36_58 = var_36_58 + 0.3

					if var_36_65 + var_36_58 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_65 + var_36_58
					end
				end

				arg_33_1.text_.text = var_36_62
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_66 = var_36_58 + 0.3
			local var_36_67 = math.max(var_36_59, arg_33_1.talkMaxDuration)

			if var_36_66 <= arg_33_1.time_ and arg_33_1.time_ < var_36_66 + var_36_67 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_66) / var_36_67

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_66 + var_36_67 and arg_33_1.time_ < var_36_66 + var_36_67 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play321102009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 321102009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play321102010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.05
			local var_42_1 = 1

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				local var_42_2 = "play"
				local var_42_3 = "effect"

				arg_39_1:AudioAction(var_42_2, var_42_3, "se_story_139", "se_story_139_thunderskill", "")
			end

			local var_42_4 = 0
			local var_42_5 = 1.525

			if var_42_4 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_6 = arg_39_1:GetWordFromCfg(321102009)
				local var_42_7 = arg_39_1:FormatText(var_42_6.content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_8 = 61
				local var_42_9 = utf8.len(var_42_7)
				local var_42_10 = var_42_8 <= 0 and var_42_5 or var_42_5 * (var_42_9 / var_42_8)

				if var_42_10 > 0 and var_42_5 < var_42_10 then
					arg_39_1.talkMaxDuration = var_42_10

					if var_42_10 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_11 = math.max(var_42_5, arg_39_1.talkMaxDuration)

			if var_42_4 <= arg_39_1.time_ and arg_39_1.time_ < var_42_4 + var_42_11 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_4) / var_42_11

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_4 + var_42_11 and arg_39_1.time_ < var_42_4 + var_42_11 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play321102010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 321102010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play321102011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.05
			local var_46_1 = 1

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				local var_46_2 = "play"
				local var_46_3 = "effect"

				arg_43_1:AudioAction(var_46_2, var_46_3, "se_story_140", "se_story_140_scythe1", "")
			end

			local var_46_4 = 0
			local var_46_5 = 0.675

			if var_46_4 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(321102010)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_8 = 27
				local var_46_9 = utf8.len(var_46_7)
				local var_46_10 = var_46_8 <= 0 and var_46_5 or var_46_5 * (var_46_9 / var_46_8)

				if var_46_10 > 0 and var_46_5 < var_46_10 then
					arg_43_1.talkMaxDuration = var_46_10

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_11 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_11 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_11

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_11 and arg_43_1.time_ < var_46_4 + var_46_11 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play321102011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 321102011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play321102012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 1.225

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_2 = arg_47_1:GetWordFromCfg(321102011)
				local var_50_3 = arg_47_1:FormatText(var_50_2.content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 49
				local var_50_5 = utf8.len(var_50_3)
				local var_50_6 = var_50_4 <= 0 and var_50_1 or var_50_1 * (var_50_5 / var_50_4)

				if var_50_6 > 0 and var_50_1 < var_50_6 then
					arg_47_1.talkMaxDuration = var_50_6

					if var_50_6 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_6 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_7 and arg_47_1.time_ < var_50_0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play321102012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 321102012
		arg_51_1.duration_ = 13.93

		local var_51_0 = {
			zh = 6.033,
			ja = 13.933
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
				arg_51_0:Play321102013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.475

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[600].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:GetWordFromCfg(321102012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 19
				local var_54_6 = utf8.len(var_54_4)
				local var_54_7 = var_54_5 <= 0 and var_54_1 or var_54_1 * (var_54_6 / var_54_5)

				if var_54_7 > 0 and var_54_1 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102012", "story_v_out_321102.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102012", "story_v_out_321102.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_321102", "321102012", "story_v_out_321102.awb")

						arg_51_1:RecordAudio("321102012", var_54_9)
						arg_51_1:RecordAudio("321102012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_321102", "321102012", "story_v_out_321102.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_321102", "321102012", "story_v_out_321102.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_10 and arg_51_1.time_ < var_54_0 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play321102013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 321102013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play321102014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.975

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_2 = arg_55_1:GetWordFromCfg(321102013)
				local var_58_3 = arg_55_1:FormatText(var_58_2.content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 39
				local var_58_5 = utf8.len(var_58_3)
				local var_58_6 = var_58_4 <= 0 and var_58_1 or var_58_1 * (var_58_5 / var_58_4)

				if var_58_6 > 0 and var_58_1 < var_58_6 then
					arg_55_1.talkMaxDuration = var_58_6

					if var_58_6 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_6 + var_58_0
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_7 = math.max(var_58_1, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_7 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_0) / var_58_7

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_7 and arg_55_1.time_ < var_58_0 + var_58_7 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play321102014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 321102014
		arg_59_1.duration_ = 9.07

		local var_59_0 = {
			zh = 5.6,
			ja = 9.066
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
				arg_59_0:Play321102015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1156ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos1156ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, -1.1, -6.18)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1156ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = arg_59_1.actors_["1156ui_story"]
			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect1156ui_story == nil then
				arg_59_1.var_.characterEffect1156ui_story = var_62_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_11 = 0.200000002980232

			if var_62_10 <= arg_59_1.time_ and arg_59_1.time_ < var_62_10 + var_62_11 and not isNil(var_62_9) then
				local var_62_12 = (arg_59_1.time_ - var_62_10) / var_62_11

				if arg_59_1.var_.characterEffect1156ui_story and not isNil(var_62_9) then
					arg_59_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_10 + var_62_11 and arg_59_1.time_ < var_62_10 + var_62_11 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect1156ui_story then
				arg_59_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_62_13 = 0

			if var_62_13 < arg_59_1.time_ and arg_59_1.time_ <= var_62_13 + arg_62_0 then
				arg_59_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action11_1")
			end

			local var_62_14 = 0

			if var_62_14 < arg_59_1.time_ and arg_59_1.time_ <= var_62_14 + arg_62_0 then
				arg_59_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_62_15 = 0
			local var_62_16 = 0.625

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_17 = arg_59_1:FormatText(StoryNameCfg[605].name)

				arg_59_1.leftNameTxt_.text = var_62_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_18 = arg_59_1:GetWordFromCfg(321102014)
				local var_62_19 = arg_59_1:FormatText(var_62_18.content)

				arg_59_1.text_.text = var_62_19

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_20 = 25
				local var_62_21 = utf8.len(var_62_19)
				local var_62_22 = var_62_20 <= 0 and var_62_16 or var_62_16 * (var_62_21 / var_62_20)

				if var_62_22 > 0 and var_62_16 < var_62_22 then
					arg_59_1.talkMaxDuration = var_62_22

					if var_62_22 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_22 + var_62_15
					end
				end

				arg_59_1.text_.text = var_62_19
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102014", "story_v_out_321102.awb") ~= 0 then
					local var_62_23 = manager.audio:GetVoiceLength("story_v_out_321102", "321102014", "story_v_out_321102.awb") / 1000

					if var_62_23 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_23 + var_62_15
					end

					if var_62_18.prefab_name ~= "" and arg_59_1.actors_[var_62_18.prefab_name] ~= nil then
						local var_62_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_18.prefab_name].transform, "story_v_out_321102", "321102014", "story_v_out_321102.awb")

						arg_59_1:RecordAudio("321102014", var_62_24)
						arg_59_1:RecordAudio("321102014", var_62_24)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_321102", "321102014", "story_v_out_321102.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_321102", "321102014", "story_v_out_321102.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_25 = math.max(var_62_16, arg_59_1.talkMaxDuration)

			if var_62_15 <= arg_59_1.time_ and arg_59_1.time_ < var_62_15 + var_62_25 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_15) / var_62_25

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_15 + var_62_25 and arg_59_1.time_ < var_62_15 + var_62_25 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play321102015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 321102015
		arg_63_1.duration_ = 8.47

		local var_63_0 = {
			zh = 4.866,
			ja = 8.466
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
				arg_63_0:Play321102016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1156ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1156ui_story == nil then
				arg_63_1.var_.characterEffect1156ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1156ui_story and not isNil(var_66_0) then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1156ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1156ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1156ui_story.fillRatio = var_66_5
			end

			local var_66_6 = 0
			local var_66_7 = 0.35

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_8 = arg_63_1:FormatText(StoryNameCfg[600].name)

				arg_63_1.leftNameTxt_.text = var_66_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_9 = arg_63_1:GetWordFromCfg(321102015)
				local var_66_10 = arg_63_1:FormatText(var_66_9.content)

				arg_63_1.text_.text = var_66_10

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 14
				local var_66_12 = utf8.len(var_66_10)
				local var_66_13 = var_66_11 <= 0 and var_66_7 or var_66_7 * (var_66_12 / var_66_11)

				if var_66_13 > 0 and var_66_7 < var_66_13 then
					arg_63_1.talkMaxDuration = var_66_13

					if var_66_13 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_13 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_10
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102015", "story_v_out_321102.awb") ~= 0 then
					local var_66_14 = manager.audio:GetVoiceLength("story_v_out_321102", "321102015", "story_v_out_321102.awb") / 1000

					if var_66_14 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_6
					end

					if var_66_9.prefab_name ~= "" and arg_63_1.actors_[var_66_9.prefab_name] ~= nil then
						local var_66_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_9.prefab_name].transform, "story_v_out_321102", "321102015", "story_v_out_321102.awb")

						arg_63_1:RecordAudio("321102015", var_66_15)
						arg_63_1:RecordAudio("321102015", var_66_15)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_321102", "321102015", "story_v_out_321102.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_321102", "321102015", "story_v_out_321102.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_16 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_16 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_16

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_16 and arg_63_1.time_ < var_66_6 + var_66_16 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play321102016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 321102016
		arg_67_1.duration_ = 2

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play321102017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1156ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1156ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0, -1.1, -6.18)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1156ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = arg_67_1.actors_["1156ui_story"]
			local var_70_10 = 0

			if var_70_10 < arg_67_1.time_ and arg_67_1.time_ <= var_70_10 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1156ui_story == nil then
				arg_67_1.var_.characterEffect1156ui_story = var_70_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_11 = 0.200000002980232

			if var_70_10 <= arg_67_1.time_ and arg_67_1.time_ < var_70_10 + var_70_11 and not isNil(var_70_9) then
				local var_70_12 = (arg_67_1.time_ - var_70_10) / var_70_11

				if arg_67_1.var_.characterEffect1156ui_story and not isNil(var_70_9) then
					arg_67_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= var_70_10 + var_70_11 and arg_67_1.time_ < var_70_10 + var_70_11 + arg_70_0 and not isNil(var_70_9) and arg_67_1.var_.characterEffect1156ui_story then
				arg_67_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_70_13 = 0

			if var_70_13 < arg_67_1.time_ and arg_67_1.time_ <= var_70_13 + arg_70_0 then
				arg_67_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action11_2")
			end

			local var_70_14 = 0

			if var_70_14 < arg_67_1.time_ and arg_67_1.time_ <= var_70_14 + arg_70_0 then
				arg_67_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_70_15 = 0
			local var_70_16 = 0.125

			if var_70_15 < arg_67_1.time_ and arg_67_1.time_ <= var_70_15 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_17 = arg_67_1:FormatText(StoryNameCfg[605].name)

				arg_67_1.leftNameTxt_.text = var_70_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_18 = arg_67_1:GetWordFromCfg(321102016)
				local var_70_19 = arg_67_1:FormatText(var_70_18.content)

				arg_67_1.text_.text = var_70_19

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_20 = 5
				local var_70_21 = utf8.len(var_70_19)
				local var_70_22 = var_70_20 <= 0 and var_70_16 or var_70_16 * (var_70_21 / var_70_20)

				if var_70_22 > 0 and var_70_16 < var_70_22 then
					arg_67_1.talkMaxDuration = var_70_22

					if var_70_22 + var_70_15 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_22 + var_70_15
					end
				end

				arg_67_1.text_.text = var_70_19
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102016", "story_v_out_321102.awb") ~= 0 then
					local var_70_23 = manager.audio:GetVoiceLength("story_v_out_321102", "321102016", "story_v_out_321102.awb") / 1000

					if var_70_23 + var_70_15 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_23 + var_70_15
					end

					if var_70_18.prefab_name ~= "" and arg_67_1.actors_[var_70_18.prefab_name] ~= nil then
						local var_70_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_18.prefab_name].transform, "story_v_out_321102", "321102016", "story_v_out_321102.awb")

						arg_67_1:RecordAudio("321102016", var_70_24)
						arg_67_1:RecordAudio("321102016", var_70_24)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_321102", "321102016", "story_v_out_321102.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_321102", "321102016", "story_v_out_321102.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_25 = math.max(var_70_16, arg_67_1.talkMaxDuration)

			if var_70_15 <= arg_67_1.time_ and arg_67_1.time_ < var_70_15 + var_70_25 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_15) / var_70_25

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_15 + var_70_25 and arg_67_1.time_ < var_70_15 + var_70_25 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play321102017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 321102017
		arg_71_1.duration_ = 9.33

		local var_71_0 = {
			zh = 6.033,
			ja = 9.333
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
				arg_71_0:Play321102018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1156ui_story"]
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1156ui_story == nil then
				arg_71_1.var_.characterEffect1156ui_story = var_74_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 and not isNil(var_74_0) then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2

				if arg_71_1.var_.characterEffect1156ui_story and not isNil(var_74_0) then
					local var_74_4 = Mathf.Lerp(0, 0.5, var_74_3)

					arg_71_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1156ui_story.fillRatio = var_74_4
				end
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 and not isNil(var_74_0) and arg_71_1.var_.characterEffect1156ui_story then
				local var_74_5 = 0.5

				arg_71_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1156ui_story.fillRatio = var_74_5
			end

			local var_74_6 = 0
			local var_74_7 = 0.55

			if var_74_6 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_8 = arg_71_1:FormatText(StoryNameCfg[600].name)

				arg_71_1.leftNameTxt_.text = var_74_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_9 = arg_71_1:GetWordFromCfg(321102017)
				local var_74_10 = arg_71_1:FormatText(var_74_9.content)

				arg_71_1.text_.text = var_74_10

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 22
				local var_74_12 = utf8.len(var_74_10)
				local var_74_13 = var_74_11 <= 0 and var_74_7 or var_74_7 * (var_74_12 / var_74_11)

				if var_74_13 > 0 and var_74_7 < var_74_13 then
					arg_71_1.talkMaxDuration = var_74_13

					if var_74_13 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_10
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102017", "story_v_out_321102.awb") ~= 0 then
					local var_74_14 = manager.audio:GetVoiceLength("story_v_out_321102", "321102017", "story_v_out_321102.awb") / 1000

					if var_74_14 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_14 + var_74_6
					end

					if var_74_9.prefab_name ~= "" and arg_71_1.actors_[var_74_9.prefab_name] ~= nil then
						local var_74_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_9.prefab_name].transform, "story_v_out_321102", "321102017", "story_v_out_321102.awb")

						arg_71_1:RecordAudio("321102017", var_74_15)
						arg_71_1:RecordAudio("321102017", var_74_15)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_321102", "321102017", "story_v_out_321102.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_321102", "321102017", "story_v_out_321102.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_16 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_16 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_16

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_16 and arg_71_1.time_ < var_74_6 + var_74_16 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play321102018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 321102018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play321102019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1156ui_story"].transform
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.var_.moveOldPos1156ui_story = var_78_0.localPosition
			end

			local var_78_2 = 0.001

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2
				local var_78_4 = Vector3.New(0, 100, 0)

				var_78_0.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1156ui_story, var_78_4, var_78_3)

				local var_78_5 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_5.x, var_78_5.y, var_78_5.z)

				local var_78_6 = var_78_0.localEulerAngles

				var_78_6.z = 0
				var_78_6.x = 0
				var_78_0.localEulerAngles = var_78_6
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 then
				var_78_0.localPosition = Vector3.New(0, 100, 0)

				local var_78_7 = manager.ui.mainCamera.transform.position - var_78_0.position

				var_78_0.forward = Vector3.New(var_78_7.x, var_78_7.y, var_78_7.z)

				local var_78_8 = var_78_0.localEulerAngles

				var_78_8.z = 0
				var_78_8.x = 0
				var_78_0.localEulerAngles = var_78_8
			end

			local var_78_9 = 1.18210370047018
			local var_78_10 = 1

			if var_78_9 < arg_75_1.time_ and arg_75_1.time_ <= var_78_9 + arg_78_0 then
				local var_78_11 = "play"
				local var_78_12 = "effect"

				arg_75_1:AudioAction(var_78_11, var_78_12, "se_story_140", "se_story_140_punch", "")
			end

			local var_78_13 = 0
			local var_78_14 = 1.525

			if var_78_13 < arg_75_1.time_ and arg_75_1.time_ <= var_78_13 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_15 = arg_75_1:GetWordFromCfg(321102018)
				local var_78_16 = arg_75_1:FormatText(var_78_15.content)

				arg_75_1.text_.text = var_78_16

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_17 = 61
				local var_78_18 = utf8.len(var_78_16)
				local var_78_19 = var_78_17 <= 0 and var_78_14 or var_78_14 * (var_78_18 / var_78_17)

				if var_78_19 > 0 and var_78_14 < var_78_19 then
					arg_75_1.talkMaxDuration = var_78_19

					if var_78_19 + var_78_13 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_19 + var_78_13
					end
				end

				arg_75_1.text_.text = var_78_16
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_20 = math.max(var_78_14, arg_75_1.talkMaxDuration)

			if var_78_13 <= arg_75_1.time_ and arg_75_1.time_ < var_78_13 + var_78_20 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_13) / var_78_20

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_13 + var_78_20 and arg_75_1.time_ < var_78_13 + var_78_20 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_75_1:InitPlayNodeList()
	end,
	Play321102019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 321102019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play321102020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 1.025

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_2 = arg_79_1:GetWordFromCfg(321102019)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_4 = 41
				local var_82_5 = utf8.len(var_82_3)
				local var_82_6 = var_82_4 <= 0 and var_82_1 or var_82_1 * (var_82_5 / var_82_4)

				if var_82_6 > 0 and var_82_1 < var_82_6 then
					arg_79_1.talkMaxDuration = var_82_6

					if var_82_6 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_7 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_7 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_7

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_7 and arg_79_1.time_ < var_82_0 + var_82_7 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play321102020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 321102020
		arg_83_1.duration_ = 2

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play321102021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = "1011ui_story"

			if arg_83_1.actors_[var_86_0] == nil then
				local var_86_1 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_86_1) then
					local var_86_2 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_83_1.stage_.transform)

					var_86_2.name = var_86_0
					var_86_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_83_1.actors_[var_86_0] = var_86_2

					local var_86_3 = var_86_2:GetComponentInChildren(typeof(CharacterEffect))

					var_86_3.enabled = true

					local var_86_4 = GameObjectTools.GetOrAddComponent(var_86_2, typeof(DynamicBoneHelper))

					if var_86_4 then
						var_86_4:EnableDynamicBone(false)
					end

					arg_83_1:ShowWeapon(var_86_3.transform, false)

					arg_83_1.var_[var_86_0 .. "Animator"] = var_86_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_83_1.var_[var_86_0 .. "Animator"].applyRootMotion = true
					arg_83_1.var_[var_86_0 .. "LipSync"] = var_86_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_86_5 = arg_83_1.actors_["1011ui_story"].transform
			local var_86_6 = 0

			if var_86_6 < arg_83_1.time_ and arg_83_1.time_ <= var_86_6 + arg_86_0 then
				arg_83_1.var_.moveOldPos1011ui_story = var_86_5.localPosition
			end

			local var_86_7 = 0.001

			if var_86_6 <= arg_83_1.time_ and arg_83_1.time_ < var_86_6 + var_86_7 then
				local var_86_8 = (arg_83_1.time_ - var_86_6) / var_86_7
				local var_86_9 = Vector3.New(0, -0.71, -6)

				var_86_5.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1011ui_story, var_86_9, var_86_8)

				local var_86_10 = manager.ui.mainCamera.transform.position - var_86_5.position

				var_86_5.forward = Vector3.New(var_86_10.x, var_86_10.y, var_86_10.z)

				local var_86_11 = var_86_5.localEulerAngles

				var_86_11.z = 0
				var_86_11.x = 0
				var_86_5.localEulerAngles = var_86_11
			end

			if arg_83_1.time_ >= var_86_6 + var_86_7 and arg_83_1.time_ < var_86_6 + var_86_7 + arg_86_0 then
				var_86_5.localPosition = Vector3.New(0, -0.71, -6)

				local var_86_12 = manager.ui.mainCamera.transform.position - var_86_5.position

				var_86_5.forward = Vector3.New(var_86_12.x, var_86_12.y, var_86_12.z)

				local var_86_13 = var_86_5.localEulerAngles

				var_86_13.z = 0
				var_86_13.x = 0
				var_86_5.localEulerAngles = var_86_13
			end

			local var_86_14 = arg_83_1.actors_["1011ui_story"]
			local var_86_15 = 0

			if var_86_15 < arg_83_1.time_ and arg_83_1.time_ <= var_86_15 + arg_86_0 and not isNil(var_86_14) and arg_83_1.var_.characterEffect1011ui_story == nil then
				arg_83_1.var_.characterEffect1011ui_story = var_86_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_16 = 0.200000002980232

			if var_86_15 <= arg_83_1.time_ and arg_83_1.time_ < var_86_15 + var_86_16 and not isNil(var_86_14) then
				local var_86_17 = (arg_83_1.time_ - var_86_15) / var_86_16

				if arg_83_1.var_.characterEffect1011ui_story and not isNil(var_86_14) then
					arg_83_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_15 + var_86_16 and arg_83_1.time_ < var_86_15 + var_86_16 + arg_86_0 and not isNil(var_86_14) and arg_83_1.var_.characterEffect1011ui_story then
				arg_83_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_86_18 = 0

			if var_86_18 < arg_83_1.time_ and arg_83_1.time_ <= var_86_18 + arg_86_0 then
				arg_83_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_86_19 = 0

			if var_86_19 < arg_83_1.time_ and arg_83_1.time_ <= var_86_19 + arg_86_0 then
				arg_83_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_86_20 = 0
			local var_86_21 = 0.1

			if var_86_20 < arg_83_1.time_ and arg_83_1.time_ <= var_86_20 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_22 = arg_83_1:FormatText(StoryNameCfg[37].name)

				arg_83_1.leftNameTxt_.text = var_86_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_23 = arg_83_1:GetWordFromCfg(321102020)
				local var_86_24 = arg_83_1:FormatText(var_86_23.content)

				arg_83_1.text_.text = var_86_24

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_25 = 4
				local var_86_26 = utf8.len(var_86_24)
				local var_86_27 = var_86_25 <= 0 and var_86_21 or var_86_21 * (var_86_26 / var_86_25)

				if var_86_27 > 0 and var_86_21 < var_86_27 then
					arg_83_1.talkMaxDuration = var_86_27

					if var_86_27 + var_86_20 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_27 + var_86_20
					end
				end

				arg_83_1.text_.text = var_86_24
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102020", "story_v_out_321102.awb") ~= 0 then
					local var_86_28 = manager.audio:GetVoiceLength("story_v_out_321102", "321102020", "story_v_out_321102.awb") / 1000

					if var_86_28 + var_86_20 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_28 + var_86_20
					end

					if var_86_23.prefab_name ~= "" and arg_83_1.actors_[var_86_23.prefab_name] ~= nil then
						local var_86_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_23.prefab_name].transform, "story_v_out_321102", "321102020", "story_v_out_321102.awb")

						arg_83_1:RecordAudio("321102020", var_86_29)
						arg_83_1:RecordAudio("321102020", var_86_29)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_321102", "321102020", "story_v_out_321102.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_321102", "321102020", "story_v_out_321102.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_30 = math.max(var_86_21, arg_83_1.talkMaxDuration)

			if var_86_20 <= arg_83_1.time_ and arg_83_1.time_ < var_86_20 + var_86_30 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_20) / var_86_30

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_20 + var_86_30 and arg_83_1.time_ < var_86_20 + var_86_30 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_83_1:InitPlayNodeList()
	end,
	Play321102021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 321102021
		arg_87_1.duration_ = 3.1

		local var_87_0 = {
			zh = 2.466,
			ja = 3.1
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
				arg_87_0:Play321102022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1011ui_story"]
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1011ui_story == nil then
				arg_87_1.var_.characterEffect1011ui_story = var_90_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 and not isNil(var_90_0) then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2

				if arg_87_1.var_.characterEffect1011ui_story and not isNil(var_90_0) then
					local var_90_4 = Mathf.Lerp(0, 0.5, var_90_3)

					arg_87_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1011ui_story.fillRatio = var_90_4
				end
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 and not isNil(var_90_0) and arg_87_1.var_.characterEffect1011ui_story then
				local var_90_5 = 0.5

				arg_87_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1011ui_story.fillRatio = var_90_5
			end

			local var_90_6 = 0
			local var_90_7 = 0.25

			if var_90_6 < arg_87_1.time_ and arg_87_1.time_ <= var_90_6 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_8 = arg_87_1:FormatText(StoryNameCfg[605].name)

				arg_87_1.leftNameTxt_.text = var_90_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_9 = arg_87_1:GetWordFromCfg(321102021)
				local var_90_10 = arg_87_1:FormatText(var_90_9.content)

				arg_87_1.text_.text = var_90_10

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_11 = 10
				local var_90_12 = utf8.len(var_90_10)
				local var_90_13 = var_90_11 <= 0 and var_90_7 or var_90_7 * (var_90_12 / var_90_11)

				if var_90_13 > 0 and var_90_7 < var_90_13 then
					arg_87_1.talkMaxDuration = var_90_13

					if var_90_13 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_13 + var_90_6
					end
				end

				arg_87_1.text_.text = var_90_10
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102021", "story_v_out_321102.awb") ~= 0 then
					local var_90_14 = manager.audio:GetVoiceLength("story_v_out_321102", "321102021", "story_v_out_321102.awb") / 1000

					if var_90_14 + var_90_6 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_14 + var_90_6
					end

					if var_90_9.prefab_name ~= "" and arg_87_1.actors_[var_90_9.prefab_name] ~= nil then
						local var_90_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_9.prefab_name].transform, "story_v_out_321102", "321102021", "story_v_out_321102.awb")

						arg_87_1:RecordAudio("321102021", var_90_15)
						arg_87_1:RecordAudio("321102021", var_90_15)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_321102", "321102021", "story_v_out_321102.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_321102", "321102021", "story_v_out_321102.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_16 = math.max(var_90_7, arg_87_1.talkMaxDuration)

			if var_90_6 <= arg_87_1.time_ and arg_87_1.time_ < var_90_6 + var_90_16 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_6) / var_90_16

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_6 + var_90_16 and arg_87_1.time_ < var_90_6 + var_90_16 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play321102022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 321102022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play321102023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = arg_91_1.actors_["1011ui_story"].transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.var_.moveOldPos1011ui_story = var_94_0.localPosition
			end

			local var_94_2 = 0.001

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_2 then
				local var_94_3 = (arg_91_1.time_ - var_94_1) / var_94_2
				local var_94_4 = Vector3.New(0, 100, 0)

				var_94_0.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1011ui_story, var_94_4, var_94_3)

				local var_94_5 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_5.x, var_94_5.y, var_94_5.z)

				local var_94_6 = var_94_0.localEulerAngles

				var_94_6.z = 0
				var_94_6.x = 0
				var_94_0.localEulerAngles = var_94_6
			end

			if arg_91_1.time_ >= var_94_1 + var_94_2 and arg_91_1.time_ < var_94_1 + var_94_2 + arg_94_0 then
				var_94_0.localPosition = Vector3.New(0, 100, 0)

				local var_94_7 = manager.ui.mainCamera.transform.position - var_94_0.position

				var_94_0.forward = Vector3.New(var_94_7.x, var_94_7.y, var_94_7.z)

				local var_94_8 = var_94_0.localEulerAngles

				var_94_8.z = 0
				var_94_8.x = 0
				var_94_0.localEulerAngles = var_94_8
			end

			local var_94_9 = arg_91_1.actors_["1156ui_story"].transform
			local var_94_10 = 0

			if var_94_10 < arg_91_1.time_ and arg_91_1.time_ <= var_94_10 + arg_94_0 then
				arg_91_1.var_.moveOldPos1156ui_story = var_94_9.localPosition
			end

			local var_94_11 = 0.001

			if var_94_10 <= arg_91_1.time_ and arg_91_1.time_ < var_94_10 + var_94_11 then
				local var_94_12 = (arg_91_1.time_ - var_94_10) / var_94_11
				local var_94_13 = Vector3.New(0, 100, 0)

				var_94_9.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1156ui_story, var_94_13, var_94_12)

				local var_94_14 = manager.ui.mainCamera.transform.position - var_94_9.position

				var_94_9.forward = Vector3.New(var_94_14.x, var_94_14.y, var_94_14.z)

				local var_94_15 = var_94_9.localEulerAngles

				var_94_15.z = 0
				var_94_15.x = 0
				var_94_9.localEulerAngles = var_94_15
			end

			if arg_91_1.time_ >= var_94_10 + var_94_11 and arg_91_1.time_ < var_94_10 + var_94_11 + arg_94_0 then
				var_94_9.localPosition = Vector3.New(0, 100, 0)

				local var_94_16 = manager.ui.mainCamera.transform.position - var_94_9.position

				var_94_9.forward = Vector3.New(var_94_16.x, var_94_16.y, var_94_16.z)

				local var_94_17 = var_94_9.localEulerAngles

				var_94_17.z = 0
				var_94_17.x = 0
				var_94_9.localEulerAngles = var_94_17
			end

			local var_94_18 = arg_91_1.actors_["1156ui_story"]
			local var_94_19 = 0

			if var_94_19 < arg_91_1.time_ and arg_91_1.time_ <= var_94_19 + arg_94_0 and not isNil(var_94_18) and arg_91_1.var_.characterEffect1156ui_story == nil then
				arg_91_1.var_.characterEffect1156ui_story = var_94_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_20 = 0.200000002980232

			if var_94_19 <= arg_91_1.time_ and arg_91_1.time_ < var_94_19 + var_94_20 and not isNil(var_94_18) then
				local var_94_21 = (arg_91_1.time_ - var_94_19) / var_94_20

				if arg_91_1.var_.characterEffect1156ui_story and not isNil(var_94_18) then
					local var_94_22 = Mathf.Lerp(0, 0.5, var_94_21)

					arg_91_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1156ui_story.fillRatio = var_94_22
				end
			end

			if arg_91_1.time_ >= var_94_19 + var_94_20 and arg_91_1.time_ < var_94_19 + var_94_20 + arg_94_0 and not isNil(var_94_18) and arg_91_1.var_.characterEffect1156ui_story then
				local var_94_23 = 0.5

				arg_91_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1156ui_story.fillRatio = var_94_23
			end

			local var_94_24 = 0
			local var_94_25 = 0.975

			if var_94_24 < arg_91_1.time_ and arg_91_1.time_ <= var_94_24 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_26 = arg_91_1:GetWordFromCfg(321102022)
				local var_94_27 = arg_91_1:FormatText(var_94_26.content)

				arg_91_1.text_.text = var_94_27

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_28 = 39
				local var_94_29 = utf8.len(var_94_27)
				local var_94_30 = var_94_28 <= 0 and var_94_25 or var_94_25 * (var_94_29 / var_94_28)

				if var_94_30 > 0 and var_94_25 < var_94_30 then
					arg_91_1.talkMaxDuration = var_94_30

					if var_94_30 + var_94_24 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_30 + var_94_24
					end
				end

				arg_91_1.text_.text = var_94_27
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_31 = math.max(var_94_25, arg_91_1.talkMaxDuration)

			if var_94_24 <= arg_91_1.time_ and arg_91_1.time_ < var_94_24 + var_94_31 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_24) / var_94_31

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_24 + var_94_31 and arg_91_1.time_ < var_94_24 + var_94_31 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play321102023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 321102023
		arg_95_1.duration_ = 14.13

		local var_95_0 = {
			zh = 5.6,
			ja = 14.133
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
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play321102024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.575

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[600].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:GetWordFromCfg(321102023)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 23
				local var_98_6 = utf8.len(var_98_4)
				local var_98_7 = var_98_5 <= 0 and var_98_1 or var_98_1 * (var_98_6 / var_98_5)

				if var_98_7 > 0 and var_98_1 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102023", "story_v_out_321102.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102023", "story_v_out_321102.awb") / 1000

					if var_98_8 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_0
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_321102", "321102023", "story_v_out_321102.awb")

						arg_95_1:RecordAudio("321102023", var_98_9)
						arg_95_1:RecordAudio("321102023", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_321102", "321102023", "story_v_out_321102.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_321102", "321102023", "story_v_out_321102.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_10 and arg_95_1.time_ < var_98_0 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play321102024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 321102024
		arg_99_1.duration_ = 2

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play321102025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1011ui_story"].transform
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 then
				arg_99_1.var_.moveOldPos1011ui_story = var_102_0.localPosition
			end

			local var_102_2 = 0.001

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2
				local var_102_4 = Vector3.New(0, -0.71, -6)

				var_102_0.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1011ui_story, var_102_4, var_102_3)

				local var_102_5 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_5.x, var_102_5.y, var_102_5.z)

				local var_102_6 = var_102_0.localEulerAngles

				var_102_6.z = 0
				var_102_6.x = 0
				var_102_0.localEulerAngles = var_102_6
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 then
				var_102_0.localPosition = Vector3.New(0, -0.71, -6)

				local var_102_7 = manager.ui.mainCamera.transform.position - var_102_0.position

				var_102_0.forward = Vector3.New(var_102_7.x, var_102_7.y, var_102_7.z)

				local var_102_8 = var_102_0.localEulerAngles

				var_102_8.z = 0
				var_102_8.x = 0
				var_102_0.localEulerAngles = var_102_8
			end

			local var_102_9 = arg_99_1.actors_["1011ui_story"]
			local var_102_10 = 0

			if var_102_10 < arg_99_1.time_ and arg_99_1.time_ <= var_102_10 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect1011ui_story == nil then
				arg_99_1.var_.characterEffect1011ui_story = var_102_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_11 = 0.200000002980232

			if var_102_10 <= arg_99_1.time_ and arg_99_1.time_ < var_102_10 + var_102_11 and not isNil(var_102_9) then
				local var_102_12 = (arg_99_1.time_ - var_102_10) / var_102_11

				if arg_99_1.var_.characterEffect1011ui_story and not isNil(var_102_9) then
					arg_99_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= var_102_10 + var_102_11 and arg_99_1.time_ < var_102_10 + var_102_11 + arg_102_0 and not isNil(var_102_9) and arg_99_1.var_.characterEffect1011ui_story then
				arg_99_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_102_13 = 0

			if var_102_13 < arg_99_1.time_ and arg_99_1.time_ <= var_102_13 + arg_102_0 then
				arg_99_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			local var_102_14 = 0

			if var_102_14 < arg_99_1.time_ and arg_99_1.time_ <= var_102_14 + arg_102_0 then
				arg_99_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_102_15 = 0
			local var_102_16 = 0.05

			if var_102_15 < arg_99_1.time_ and arg_99_1.time_ <= var_102_15 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_17 = arg_99_1:FormatText(StoryNameCfg[37].name)

				arg_99_1.leftNameTxt_.text = var_102_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_18 = arg_99_1:GetWordFromCfg(321102024)
				local var_102_19 = arg_99_1:FormatText(var_102_18.content)

				arg_99_1.text_.text = var_102_19

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_20 = 2
				local var_102_21 = utf8.len(var_102_19)
				local var_102_22 = var_102_20 <= 0 and var_102_16 or var_102_16 * (var_102_21 / var_102_20)

				if var_102_22 > 0 and var_102_16 < var_102_22 then
					arg_99_1.talkMaxDuration = var_102_22

					if var_102_22 + var_102_15 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_22 + var_102_15
					end
				end

				arg_99_1.text_.text = var_102_19
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102024", "story_v_out_321102.awb") ~= 0 then
					local var_102_23 = manager.audio:GetVoiceLength("story_v_out_321102", "321102024", "story_v_out_321102.awb") / 1000

					if var_102_23 + var_102_15 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_23 + var_102_15
					end

					if var_102_18.prefab_name ~= "" and arg_99_1.actors_[var_102_18.prefab_name] ~= nil then
						local var_102_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_18.prefab_name].transform, "story_v_out_321102", "321102024", "story_v_out_321102.awb")

						arg_99_1:RecordAudio("321102024", var_102_24)
						arg_99_1:RecordAudio("321102024", var_102_24)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_321102", "321102024", "story_v_out_321102.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_321102", "321102024", "story_v_out_321102.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_25 = math.max(var_102_16, arg_99_1.talkMaxDuration)

			if var_102_15 <= arg_99_1.time_ and arg_99_1.time_ < var_102_15 + var_102_25 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_15) / var_102_25

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_15 + var_102_25 and arg_99_1.time_ < var_102_15 + var_102_25 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play321102025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 321102025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play321102026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1011ui_story"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos1011ui_story = var_106_0.localPosition
			end

			local var_106_2 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2
				local var_106_4 = Vector3.New(0, 100, 0)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1011ui_story, var_106_4, var_106_3)

				local var_106_5 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_5.x, var_106_5.y, var_106_5.z)

				local var_106_6 = var_106_0.localEulerAngles

				var_106_6.z = 0
				var_106_6.x = 0
				var_106_0.localEulerAngles = var_106_6
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0, 100, 0)

				local var_106_7 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_7.x, var_106_7.y, var_106_7.z)

				local var_106_8 = var_106_0.localEulerAngles

				var_106_8.z = 0
				var_106_8.x = 0
				var_106_0.localEulerAngles = var_106_8
			end

			local var_106_9 = arg_103_1.actors_["1011ui_story"]
			local var_106_10 = 0

			if var_106_10 < arg_103_1.time_ and arg_103_1.time_ <= var_106_10 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1011ui_story == nil then
				arg_103_1.var_.characterEffect1011ui_story = var_106_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_11 = 0.200000002980232

			if var_106_10 <= arg_103_1.time_ and arg_103_1.time_ < var_106_10 + var_106_11 and not isNil(var_106_9) then
				local var_106_12 = (arg_103_1.time_ - var_106_10) / var_106_11

				if arg_103_1.var_.characterEffect1011ui_story and not isNil(var_106_9) then
					local var_106_13 = Mathf.Lerp(0, 0.5, var_106_12)

					arg_103_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1011ui_story.fillRatio = var_106_13
				end
			end

			if arg_103_1.time_ >= var_106_10 + var_106_11 and arg_103_1.time_ < var_106_10 + var_106_11 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1011ui_story then
				local var_106_14 = 0.5

				arg_103_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1011ui_story.fillRatio = var_106_14
			end

			local var_106_15 = 0
			local var_106_16 = 1.075

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_17 = arg_103_1:GetWordFromCfg(321102025)
				local var_106_18 = arg_103_1:FormatText(var_106_17.content)

				arg_103_1.text_.text = var_106_18

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_19 = 43
				local var_106_20 = utf8.len(var_106_18)
				local var_106_21 = var_106_19 <= 0 and var_106_16 or var_106_16 * (var_106_20 / var_106_19)

				if var_106_21 > 0 and var_106_16 < var_106_21 then
					arg_103_1.talkMaxDuration = var_106_21

					if var_106_21 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_21 + var_106_15
					end
				end

				arg_103_1.text_.text = var_106_18
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_22 = math.max(var_106_16, arg_103_1.talkMaxDuration)

			if var_106_15 <= arg_103_1.time_ and arg_103_1.time_ < var_106_15 + var_106_22 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_15) / var_106_22

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_15 + var_106_22 and arg_103_1.time_ < var_106_15 + var_106_22 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play321102026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 321102026
		arg_107_1.duration_ = 6.7

		local var_107_0 = {
			zh = 4.166,
			ja = 6.7
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
				arg_107_0:Play321102027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 0.35

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[600].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_3 = arg_107_1:GetWordFromCfg(321102026)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 14
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

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102026", "story_v_out_321102.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102026", "story_v_out_321102.awb") / 1000

					if var_110_8 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_0
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_out_321102", "321102026", "story_v_out_321102.awb")

						arg_107_1:RecordAudio("321102026", var_110_9)
						arg_107_1:RecordAudio("321102026", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_321102", "321102026", "story_v_out_321102.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_321102", "321102026", "story_v_out_321102.awb")
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
	Play321102027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 321102027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play321102028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 0.875

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_2 = arg_111_1:GetWordFromCfg(321102027)
				local var_114_3 = arg_111_1:FormatText(var_114_2.content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_4 = 35
				local var_114_5 = utf8.len(var_114_3)
				local var_114_6 = var_114_4 <= 0 and var_114_1 or var_114_1 * (var_114_5 / var_114_4)

				if var_114_6 > 0 and var_114_1 < var_114_6 then
					arg_111_1.talkMaxDuration = var_114_6

					if var_114_6 + var_114_0 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_6 + var_114_0
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_7 = math.max(var_114_1, arg_111_1.talkMaxDuration)

			if var_114_0 <= arg_111_1.time_ and arg_111_1.time_ < var_114_0 + var_114_7 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_0) / var_114_7

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_0 + var_114_7 and arg_111_1.time_ < var_114_0 + var_114_7 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play321102028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 321102028
		arg_115_1.duration_ = 1.07

		local var_115_0 = {
			zh = 1.066,
			ja = 1
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play321102029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1011ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1011ui_story == nil then
				arg_115_1.var_.characterEffect1011ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1011ui_story and not isNil(var_118_0) then
					arg_115_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1011ui_story then
				arg_115_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_118_4 = 0
			local var_118_5 = 0.075

			if var_118_4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_6 = arg_115_1:FormatText(StoryNameCfg[37].name)

				arg_115_1.leftNameTxt_.text = var_118_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_7 = arg_115_1:GetWordFromCfg(321102028)
				local var_118_8 = arg_115_1:FormatText(var_118_7.content)

				arg_115_1.text_.text = var_118_8

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_9 = 3
				local var_118_10 = utf8.len(var_118_8)
				local var_118_11 = var_118_9 <= 0 and var_118_5 or var_118_5 * (var_118_10 / var_118_9)

				if var_118_11 > 0 and var_118_5 < var_118_11 then
					arg_115_1.talkMaxDuration = var_118_11

					if var_118_11 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_11 + var_118_4
					end
				end

				arg_115_1.text_.text = var_118_8
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102028", "story_v_out_321102.awb") ~= 0 then
					local var_118_12 = manager.audio:GetVoiceLength("story_v_out_321102", "321102028", "story_v_out_321102.awb") / 1000

					if var_118_12 + var_118_4 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_12 + var_118_4
					end

					if var_118_7.prefab_name ~= "" and arg_115_1.actors_[var_118_7.prefab_name] ~= nil then
						local var_118_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_7.prefab_name].transform, "story_v_out_321102", "321102028", "story_v_out_321102.awb")

						arg_115_1:RecordAudio("321102028", var_118_13)
						arg_115_1:RecordAudio("321102028", var_118_13)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_321102", "321102028", "story_v_out_321102.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_321102", "321102028", "story_v_out_321102.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_14 = math.max(var_118_5, arg_115_1.talkMaxDuration)

			if var_118_4 <= arg_115_1.time_ and arg_115_1.time_ < var_118_4 + var_118_14 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_4) / var_118_14

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_4 + var_118_14 and arg_115_1.time_ < var_118_4 + var_118_14 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play321102029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 321102029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play321102030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1011ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1011ui_story == nil then
				arg_119_1.var_.characterEffect1011ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect1011ui_story and not isNil(var_122_0) then
					local var_122_4 = Mathf.Lerp(0, 0.5, var_122_3)

					arg_119_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1011ui_story.fillRatio = var_122_4
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1011ui_story then
				local var_122_5 = 0.5

				arg_119_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1011ui_story.fillRatio = var_122_5
			end

			local var_122_6 = 0.200000002980232
			local var_122_7 = 1

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				local var_122_8 = "play"
				local var_122_9 = "effect"

				arg_119_1:AudioAction(var_122_8, var_122_9, "se_story_140", "se_story_140_light", "")
			end

			local var_122_10 = 0
			local var_122_11 = 1.1

			if var_122_10 < arg_119_1.time_ and arg_119_1.time_ <= var_122_10 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_12 = arg_119_1:GetWordFromCfg(321102029)
				local var_122_13 = arg_119_1:FormatText(var_122_12.content)

				arg_119_1.text_.text = var_122_13

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_14 = 44
				local var_122_15 = utf8.len(var_122_13)
				local var_122_16 = var_122_14 <= 0 and var_122_11 or var_122_11 * (var_122_15 / var_122_14)

				if var_122_16 > 0 and var_122_11 < var_122_16 then
					arg_119_1.talkMaxDuration = var_122_16

					if var_122_16 + var_122_10 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_16 + var_122_10
					end
				end

				arg_119_1.text_.text = var_122_13
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_17 = math.max(var_122_11, arg_119_1.talkMaxDuration)

			if var_122_10 <= arg_119_1.time_ and arg_119_1.time_ < var_122_10 + var_122_17 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_10) / var_122_17

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_10 + var_122_17 and arg_119_1.time_ < var_122_10 + var_122_17 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play321102030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321102030
		arg_123_1.duration_ = 7.83

		local var_123_0 = {
			zh = 7.83300000297923,
			ja = 6.80000000297923
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
				arg_123_0:Play321102031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = "L10g"

			if arg_123_1.bgs_[var_126_0] == nil then
				local var_126_1 = Object.Instantiate(arg_123_1.paintGo_)

				var_126_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_126_0)
				var_126_1.name = var_126_0
				var_126_1.transform.parent = arg_123_1.stage_.transform
				var_126_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_123_1.bgs_[var_126_0] = var_126_1
			end

			local var_126_2 = 1.80000000298023

			if var_126_2 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				local var_126_3 = manager.ui.mainCamera.transform.localPosition
				local var_126_4 = Vector3.New(0, 0, 10) + Vector3.New(var_126_3.x, var_126_3.y, 0)
				local var_126_5 = arg_123_1.bgs_.L10g

				var_126_5.transform.localPosition = var_126_4
				var_126_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_126_6 = var_126_5:GetComponent("SpriteRenderer")

				if var_126_6 and var_126_6.sprite then
					local var_126_7 = (var_126_5.transform.localPosition - var_126_3).z
					local var_126_8 = manager.ui.mainCameraCom_
					local var_126_9 = 2 * var_126_7 * Mathf.Tan(var_126_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_126_10 = var_126_9 * var_126_8.aspect
					local var_126_11 = var_126_6.sprite.bounds.size.x
					local var_126_12 = var_126_6.sprite.bounds.size.y
					local var_126_13 = var_126_10 / var_126_11
					local var_126_14 = var_126_9 / var_126_12
					local var_126_15 = var_126_14 < var_126_13 and var_126_13 or var_126_14

					var_126_5.transform.localScale = Vector3.New(var_126_15, var_126_15, 0)
				end

				for iter_126_0, iter_126_1 in pairs(arg_123_1.bgs_) do
					if iter_126_0 ~= "L10g" then
						iter_126_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_126_16 = 3.80000000297923

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 then
				arg_123_1.allBtn_.enabled = false
			end

			local var_126_17 = 0.3

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 then
				arg_123_1.allBtn_.enabled = true
			end

			local var_126_18 = 0

			if var_126_18 < arg_123_1.time_ and arg_123_1.time_ <= var_126_18 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_19 = 1.79999999701977

			if var_126_18 <= arg_123_1.time_ and arg_123_1.time_ < var_126_18 + var_126_19 then
				local var_126_20 = (arg_123_1.time_ - var_126_18) / var_126_19
				local var_126_21 = Color.New(1, 1, 1)

				var_126_21.a = Mathf.Lerp(0, 1, var_126_20)
				arg_123_1.mask_.color = var_126_21
			end

			if arg_123_1.time_ >= var_126_18 + var_126_19 and arg_123_1.time_ < var_126_18 + var_126_19 + arg_126_0 then
				local var_126_22 = Color.New(1, 1, 1)

				var_126_22.a = 1
				arg_123_1.mask_.color = var_126_22
			end

			local var_126_23 = 1.80000000297923

			if var_126_23 < arg_123_1.time_ and arg_123_1.time_ <= var_126_23 + arg_126_0 then
				arg_123_1.mask_.enabled = true
				arg_123_1.mask_.raycastTarget = true

				arg_123_1:SetGaussion(false)
			end

			local var_126_24 = 2

			if var_126_23 <= arg_123_1.time_ and arg_123_1.time_ < var_126_23 + var_126_24 then
				local var_126_25 = (arg_123_1.time_ - var_126_23) / var_126_24
				local var_126_26 = Color.New(1, 1, 1)

				var_126_26.a = Mathf.Lerp(1, 0, var_126_25)
				arg_123_1.mask_.color = var_126_26
			end

			if arg_123_1.time_ >= var_126_23 + var_126_24 and arg_123_1.time_ < var_126_23 + var_126_24 + arg_126_0 then
				local var_126_27 = Color.New(1, 1, 1)
				local var_126_28 = 0

				arg_123_1.mask_.enabled = false
				var_126_27.a = var_126_28
				arg_123_1.mask_.color = var_126_27
			end

			local var_126_29 = arg_123_1.actors_["1156ui_story"]
			local var_126_30 = 1.6

			if var_126_30 < arg_123_1.time_ and arg_123_1.time_ <= var_126_30 + arg_126_0 and not isNil(var_126_29) and arg_123_1.var_.characterEffect1156ui_story == nil then
				arg_123_1.var_.characterEffect1156ui_story = var_126_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_31 = 0.200000002980232

			if var_126_30 <= arg_123_1.time_ and arg_123_1.time_ < var_126_30 + var_126_31 and not isNil(var_126_29) then
				local var_126_32 = (arg_123_1.time_ - var_126_30) / var_126_31

				if arg_123_1.var_.characterEffect1156ui_story and not isNil(var_126_29) then
					arg_123_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_30 + var_126_31 and arg_123_1.time_ < var_126_30 + var_126_31 + arg_126_0 and not isNil(var_126_29) and arg_123_1.var_.characterEffect1156ui_story then
				arg_123_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			if arg_123_1.frameCnt_ <= 1 then
				arg_123_1.dialog_:SetActive(false)
			end

			local var_126_33 = 3.80000000297923
			local var_126_34 = 0.25

			if var_126_33 < arg_123_1.time_ and arg_123_1.time_ <= var_126_33 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0

				arg_123_1.dialog_:SetActive(true)

				arg_123_1.dialogCg_.alpha = 0

				local var_126_35 = LeanTween.value(arg_123_1.dialog_, 0, 1, 0.3)

				var_126_35:setOnUpdate(LuaHelper.FloatAction(function(arg_127_0)
					arg_123_1.dialogCg_.alpha = arg_127_0
				end))
				var_126_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_123_1.dialog_)
					var_126_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_123_1.duration_ = arg_123_1.duration_ + 0.3

				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_36 = arg_123_1:FormatText(StoryNameCfg[605].name)

				arg_123_1.leftNameTxt_.text = var_126_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1156")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_37 = arg_123_1:GetWordFromCfg(321102030)
				local var_126_38 = arg_123_1:FormatText(var_126_37.content)

				arg_123_1.text_.text = var_126_38

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_39 = 10
				local var_126_40 = utf8.len(var_126_38)
				local var_126_41 = var_126_39 <= 0 and var_126_34 or var_126_34 * (var_126_40 / var_126_39)

				if var_126_41 > 0 and var_126_34 < var_126_41 then
					arg_123_1.talkMaxDuration = var_126_41
					var_126_33 = var_126_33 + 0.3

					if var_126_41 + var_126_33 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_41 + var_126_33
					end
				end

				arg_123_1.text_.text = var_126_38
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102030", "story_v_out_321102.awb") ~= 0 then
					local var_126_42 = manager.audio:GetVoiceLength("story_v_out_321102", "321102030", "story_v_out_321102.awb") / 1000

					if var_126_42 + var_126_33 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_42 + var_126_33
					end

					if var_126_37.prefab_name ~= "" and arg_123_1.actors_[var_126_37.prefab_name] ~= nil then
						local var_126_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_37.prefab_name].transform, "story_v_out_321102", "321102030", "story_v_out_321102.awb")

						arg_123_1:RecordAudio("321102030", var_126_43)
						arg_123_1:RecordAudio("321102030", var_126_43)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_321102", "321102030", "story_v_out_321102.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_321102", "321102030", "story_v_out_321102.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_44 = var_126_33 + 0.3
			local var_126_45 = math.max(var_126_34, arg_123_1.talkMaxDuration)

			if var_126_44 <= arg_123_1.time_ and arg_123_1.time_ < var_126_44 + var_126_45 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_44) / var_126_45

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_44 + var_126_45 and arg_123_1.time_ < var_126_44 + var_126_45 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play321102031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 321102031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play321102032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1156ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1156ui_story == nil then
				arg_129_1.var_.characterEffect1156ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1156ui_story and not isNil(var_132_0) then
					local var_132_4 = Mathf.Lerp(0, 0.5, var_132_3)

					arg_129_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1156ui_story.fillRatio = var_132_4
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1156ui_story then
				local var_132_5 = 0.5

				arg_129_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1156ui_story.fillRatio = var_132_5
			end

			local var_132_6 = 0
			local var_132_7 = 1.15

			if var_132_6 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(321102031)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_10 = 46
				local var_132_11 = utf8.len(var_132_9)
				local var_132_12 = var_132_10 <= 0 and var_132_7 or var_132_7 * (var_132_11 / var_132_10)

				if var_132_12 > 0 and var_132_7 < var_132_12 then
					arg_129_1.talkMaxDuration = var_132_12

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_13 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_13 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_13

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_13 and arg_129_1.time_ < var_132_6 + var_132_13 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play321102032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 321102032
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play321102033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 1.3

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_2 = arg_133_1:GetWordFromCfg(321102032)
				local var_136_3 = arg_133_1:FormatText(var_136_2.content)

				arg_133_1.text_.text = var_136_3

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_4 = 52
				local var_136_5 = utf8.len(var_136_3)
				local var_136_6 = var_136_4 <= 0 and var_136_1 or var_136_1 * (var_136_5 / var_136_4)

				if var_136_6 > 0 and var_136_1 < var_136_6 then
					arg_133_1.talkMaxDuration = var_136_6

					if var_136_6 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_6 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_3
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_7 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_7 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_7

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_7 and arg_133_1.time_ < var_136_0 + var_136_7 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play321102033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 321102033
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play321102034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 1.1

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, false)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_2 = arg_137_1:GetWordFromCfg(321102033)
				local var_140_3 = arg_137_1:FormatText(var_140_2.content)

				arg_137_1.text_.text = var_140_3

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_4 = 44
				local var_140_5 = utf8.len(var_140_3)
				local var_140_6 = var_140_4 <= 0 and var_140_1 or var_140_1 * (var_140_5 / var_140_4)

				if var_140_6 > 0 and var_140_1 < var_140_6 then
					arg_137_1.talkMaxDuration = var_140_6

					if var_140_6 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_6 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_3
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_7 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_7 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_7

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_7 and arg_137_1.time_ < var_140_0 + var_140_7 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play321102034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 321102034
		arg_141_1.duration_ = 10.67

		local var_141_0 = {
			zh = 7.366,
			ja = 10.666
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play321102035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = arg_141_1.actors_["1156ui_story"].transform
			local var_144_1 = 0

			if var_144_1 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.var_.moveOldPos1156ui_story = var_144_0.localPosition
			end

			local var_144_2 = 0.001

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_2 then
				local var_144_3 = (arg_141_1.time_ - var_144_1) / var_144_2
				local var_144_4 = Vector3.New(0, -1.1, -6.18)

				var_144_0.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1156ui_story, var_144_4, var_144_3)

				local var_144_5 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_5.x, var_144_5.y, var_144_5.z)

				local var_144_6 = var_144_0.localEulerAngles

				var_144_6.z = 0
				var_144_6.x = 0
				var_144_0.localEulerAngles = var_144_6
			end

			if arg_141_1.time_ >= var_144_1 + var_144_2 and arg_141_1.time_ < var_144_1 + var_144_2 + arg_144_0 then
				var_144_0.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_144_7 = manager.ui.mainCamera.transform.position - var_144_0.position

				var_144_0.forward = Vector3.New(var_144_7.x, var_144_7.y, var_144_7.z)

				local var_144_8 = var_144_0.localEulerAngles

				var_144_8.z = 0
				var_144_8.x = 0
				var_144_0.localEulerAngles = var_144_8
			end

			local var_144_9 = arg_141_1.actors_["1156ui_story"]
			local var_144_10 = 0

			if var_144_10 < arg_141_1.time_ and arg_141_1.time_ <= var_144_10 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1156ui_story == nil then
				arg_141_1.var_.characterEffect1156ui_story = var_144_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_11 = 0.200000002980232

			if var_144_10 <= arg_141_1.time_ and arg_141_1.time_ < var_144_10 + var_144_11 and not isNil(var_144_9) then
				local var_144_12 = (arg_141_1.time_ - var_144_10) / var_144_11

				if arg_141_1.var_.characterEffect1156ui_story and not isNil(var_144_9) then
					arg_141_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_141_1.time_ >= var_144_10 + var_144_11 and arg_141_1.time_ < var_144_10 + var_144_11 + arg_144_0 and not isNil(var_144_9) and arg_141_1.var_.characterEffect1156ui_story then
				arg_141_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_144_13 = 0

			if var_144_13 < arg_141_1.time_ and arg_141_1.time_ <= var_144_13 + arg_144_0 then
				arg_141_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_1")
			end

			local var_144_14 = 0

			if var_144_14 < arg_141_1.time_ and arg_141_1.time_ <= var_144_14 + arg_144_0 then
				arg_141_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_144_15 = 0
			local var_144_16 = 0.875

			if var_144_15 < arg_141_1.time_ and arg_141_1.time_ <= var_144_15 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_17 = arg_141_1:FormatText(StoryNameCfg[605].name)

				arg_141_1.leftNameTxt_.text = var_144_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_18 = arg_141_1:GetWordFromCfg(321102034)
				local var_144_19 = arg_141_1:FormatText(var_144_18.content)

				arg_141_1.text_.text = var_144_19

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_20 = 35
				local var_144_21 = utf8.len(var_144_19)
				local var_144_22 = var_144_20 <= 0 and var_144_16 or var_144_16 * (var_144_21 / var_144_20)

				if var_144_22 > 0 and var_144_16 < var_144_22 then
					arg_141_1.talkMaxDuration = var_144_22

					if var_144_22 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_22 + var_144_15
					end
				end

				arg_141_1.text_.text = var_144_19
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102034", "story_v_out_321102.awb") ~= 0 then
					local var_144_23 = manager.audio:GetVoiceLength("story_v_out_321102", "321102034", "story_v_out_321102.awb") / 1000

					if var_144_23 + var_144_15 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_23 + var_144_15
					end

					if var_144_18.prefab_name ~= "" and arg_141_1.actors_[var_144_18.prefab_name] ~= nil then
						local var_144_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_18.prefab_name].transform, "story_v_out_321102", "321102034", "story_v_out_321102.awb")

						arg_141_1:RecordAudio("321102034", var_144_24)
						arg_141_1:RecordAudio("321102034", var_144_24)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_321102", "321102034", "story_v_out_321102.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_321102", "321102034", "story_v_out_321102.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_25 = math.max(var_144_16, arg_141_1.talkMaxDuration)

			if var_144_15 <= arg_141_1.time_ and arg_141_1.time_ < var_144_15 + var_144_25 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_15) / var_144_25

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_15 + var_144_25 and arg_141_1.time_ < var_144_15 + var_144_25 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play321102035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 321102035
		arg_145_1.duration_ = 12

		local var_145_0 = {
			zh = 10,
			ja = 12
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play321102036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1011ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos1011ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0.7, -0.71, -6)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1011ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["1156ui_story"].transform
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 then
				arg_145_1.var_.moveOldPos1156ui_story = var_148_9.localPosition
			end

			local var_148_11 = 0.001

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11
				local var_148_13 = Vector3.New(-0.9, -1.1, -6.18)

				var_148_9.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1156ui_story, var_148_13, var_148_12)

				local var_148_14 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_14.x, var_148_14.y, var_148_14.z)

				local var_148_15 = var_148_9.localEulerAngles

				var_148_15.z = 0
				var_148_15.x = 0
				var_148_9.localEulerAngles = var_148_15
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 then
				var_148_9.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_148_16 = manager.ui.mainCamera.transform.position - var_148_9.position

				var_148_9.forward = Vector3.New(var_148_16.x, var_148_16.y, var_148_16.z)

				local var_148_17 = var_148_9.localEulerAngles

				var_148_17.z = 0
				var_148_17.x = 0
				var_148_9.localEulerAngles = var_148_17
			end

			local var_148_18 = arg_145_1.actors_["1011ui_story"]
			local var_148_19 = 0

			if var_148_19 < arg_145_1.time_ and arg_145_1.time_ <= var_148_19 + arg_148_0 and not isNil(var_148_18) and arg_145_1.var_.characterEffect1011ui_story == nil then
				arg_145_1.var_.characterEffect1011ui_story = var_148_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_20 = 0.200000002980232

			if var_148_19 <= arg_145_1.time_ and arg_145_1.time_ < var_148_19 + var_148_20 and not isNil(var_148_18) then
				local var_148_21 = (arg_145_1.time_ - var_148_19) / var_148_20

				if arg_145_1.var_.characterEffect1011ui_story and not isNil(var_148_18) then
					arg_145_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_19 + var_148_20 and arg_145_1.time_ < var_148_19 + var_148_20 + arg_148_0 and not isNil(var_148_18) and arg_145_1.var_.characterEffect1011ui_story then
				arg_145_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_148_22 = arg_145_1.actors_["1156ui_story"]
			local var_148_23 = 0

			if var_148_23 < arg_145_1.time_ and arg_145_1.time_ <= var_148_23 + arg_148_0 and not isNil(var_148_22) and arg_145_1.var_.characterEffect1156ui_story == nil then
				arg_145_1.var_.characterEffect1156ui_story = var_148_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_24 = 0.200000002980232

			if var_148_23 <= arg_145_1.time_ and arg_145_1.time_ < var_148_23 + var_148_24 and not isNil(var_148_22) then
				local var_148_25 = (arg_145_1.time_ - var_148_23) / var_148_24

				if arg_145_1.var_.characterEffect1156ui_story and not isNil(var_148_22) then
					local var_148_26 = Mathf.Lerp(0, 0.5, var_148_25)

					arg_145_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1156ui_story.fillRatio = var_148_26
				end
			end

			if arg_145_1.time_ >= var_148_23 + var_148_24 and arg_145_1.time_ < var_148_23 + var_148_24 + arg_148_0 and not isNil(var_148_22) and arg_145_1.var_.characterEffect1156ui_story then
				local var_148_27 = 0.5

				arg_145_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1156ui_story.fillRatio = var_148_27
			end

			local var_148_28 = 0

			if var_148_28 < arg_145_1.time_ and arg_145_1.time_ <= var_148_28 + arg_148_0 then
				arg_145_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_148_29 = 0

			if var_148_29 < arg_145_1.time_ and arg_145_1.time_ <= var_148_29 + arg_148_0 then
				arg_145_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_148_30 = 0
			local var_148_31 = 1.075

			if var_148_30 < arg_145_1.time_ and arg_145_1.time_ <= var_148_30 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_32 = arg_145_1:FormatText(StoryNameCfg[37].name)

				arg_145_1.leftNameTxt_.text = var_148_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_33 = arg_145_1:GetWordFromCfg(321102035)
				local var_148_34 = arg_145_1:FormatText(var_148_33.content)

				arg_145_1.text_.text = var_148_34

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_35 = 43
				local var_148_36 = utf8.len(var_148_34)
				local var_148_37 = var_148_35 <= 0 and var_148_31 or var_148_31 * (var_148_36 / var_148_35)

				if var_148_37 > 0 and var_148_31 < var_148_37 then
					arg_145_1.talkMaxDuration = var_148_37

					if var_148_37 + var_148_30 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_37 + var_148_30
					end
				end

				arg_145_1.text_.text = var_148_34
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102035", "story_v_out_321102.awb") ~= 0 then
					local var_148_38 = manager.audio:GetVoiceLength("story_v_out_321102", "321102035", "story_v_out_321102.awb") / 1000

					if var_148_38 + var_148_30 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_38 + var_148_30
					end

					if var_148_33.prefab_name ~= "" and arg_145_1.actors_[var_148_33.prefab_name] ~= nil then
						local var_148_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_33.prefab_name].transform, "story_v_out_321102", "321102035", "story_v_out_321102.awb")

						arg_145_1:RecordAudio("321102035", var_148_39)
						arg_145_1:RecordAudio("321102035", var_148_39)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_321102", "321102035", "story_v_out_321102.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_321102", "321102035", "story_v_out_321102.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_40 = math.max(var_148_31, arg_145_1.talkMaxDuration)

			if var_148_30 <= arg_145_1.time_ and arg_145_1.time_ < var_148_30 + var_148_40 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_30) / var_148_40

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_30 + var_148_40 and arg_145_1.time_ < var_148_30 + var_148_40 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play321102036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 321102036
		arg_149_1.duration_ = 7.73

		local var_149_0 = {
			zh = 5,
			ja = 7.733
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play321102037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1156ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1156ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(-0.9, -1.1, -6.18)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1156ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["1156ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1156ui_story == nil then
				arg_149_1.var_.characterEffect1156ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect1156ui_story and not isNil(var_152_9) then
					arg_149_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect1156ui_story then
				arg_149_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_152_13 = arg_149_1.actors_["1011ui_story"]
			local var_152_14 = 0

			if var_152_14 < arg_149_1.time_ and arg_149_1.time_ <= var_152_14 + arg_152_0 and not isNil(var_152_13) and arg_149_1.var_.characterEffect1011ui_story == nil then
				arg_149_1.var_.characterEffect1011ui_story = var_152_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_15 = 0.200000002980232

			if var_152_14 <= arg_149_1.time_ and arg_149_1.time_ < var_152_14 + var_152_15 and not isNil(var_152_13) then
				local var_152_16 = (arg_149_1.time_ - var_152_14) / var_152_15

				if arg_149_1.var_.characterEffect1011ui_story and not isNil(var_152_13) then
					local var_152_17 = Mathf.Lerp(0, 0.5, var_152_16)

					arg_149_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1011ui_story.fillRatio = var_152_17
				end
			end

			if arg_149_1.time_ >= var_152_14 + var_152_15 and arg_149_1.time_ < var_152_14 + var_152_15 + arg_152_0 and not isNil(var_152_13) and arg_149_1.var_.characterEffect1011ui_story then
				local var_152_18 = 0.5

				arg_149_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1011ui_story.fillRatio = var_152_18
			end

			local var_152_19 = 0

			if var_152_19 < arg_149_1.time_ and arg_149_1.time_ <= var_152_19 + arg_152_0 then
				arg_149_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action8_2")
			end

			local var_152_20 = 0

			if var_152_20 < arg_149_1.time_ and arg_149_1.time_ <= var_152_20 + arg_152_0 then
				arg_149_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_152_21 = 0
			local var_152_22 = 0.6

			if var_152_21 < arg_149_1.time_ and arg_149_1.time_ <= var_152_21 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_23 = arg_149_1:FormatText(StoryNameCfg[605].name)

				arg_149_1.leftNameTxt_.text = var_152_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_24 = arg_149_1:GetWordFromCfg(321102036)
				local var_152_25 = arg_149_1:FormatText(var_152_24.content)

				arg_149_1.text_.text = var_152_25

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_26 = 24
				local var_152_27 = utf8.len(var_152_25)
				local var_152_28 = var_152_26 <= 0 and var_152_22 or var_152_22 * (var_152_27 / var_152_26)

				if var_152_28 > 0 and var_152_22 < var_152_28 then
					arg_149_1.talkMaxDuration = var_152_28

					if var_152_28 + var_152_21 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_28 + var_152_21
					end
				end

				arg_149_1.text_.text = var_152_25
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102036", "story_v_out_321102.awb") ~= 0 then
					local var_152_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102036", "story_v_out_321102.awb") / 1000

					if var_152_29 + var_152_21 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_29 + var_152_21
					end

					if var_152_24.prefab_name ~= "" and arg_149_1.actors_[var_152_24.prefab_name] ~= nil then
						local var_152_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_24.prefab_name].transform, "story_v_out_321102", "321102036", "story_v_out_321102.awb")

						arg_149_1:RecordAudio("321102036", var_152_30)
						arg_149_1:RecordAudio("321102036", var_152_30)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_321102", "321102036", "story_v_out_321102.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_321102", "321102036", "story_v_out_321102.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_31 = math.max(var_152_22, arg_149_1.talkMaxDuration)

			if var_152_21 <= arg_149_1.time_ and arg_149_1.time_ < var_152_21 + var_152_31 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_21) / var_152_31

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_21 + var_152_31 and arg_149_1.time_ < var_152_21 + var_152_31 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_149_1:InitPlayNodeList()
	end,
	Play321102037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 321102037
		arg_153_1.duration_ = 9.9

		local var_153_0 = {
			zh = 6.9,
			ja = 9.9
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play321102038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1011ui_story"].transform
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 then
				arg_153_1.var_.moveOldPos1011ui_story = var_156_0.localPosition
			end

			local var_156_2 = 0.001

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2
				local var_156_4 = Vector3.New(0.7, -0.71, -6)

				var_156_0.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1011ui_story, var_156_4, var_156_3)

				local var_156_5 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_5.x, var_156_5.y, var_156_5.z)

				local var_156_6 = var_156_0.localEulerAngles

				var_156_6.z = 0
				var_156_6.x = 0
				var_156_0.localEulerAngles = var_156_6
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 then
				var_156_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_156_7 = manager.ui.mainCamera.transform.position - var_156_0.position

				var_156_0.forward = Vector3.New(var_156_7.x, var_156_7.y, var_156_7.z)

				local var_156_8 = var_156_0.localEulerAngles

				var_156_8.z = 0
				var_156_8.x = 0
				var_156_0.localEulerAngles = var_156_8
			end

			local var_156_9 = arg_153_1.actors_["1011ui_story"]
			local var_156_10 = 0

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1011ui_story == nil then
				arg_153_1.var_.characterEffect1011ui_story = var_156_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_11 = 0.200000002980232

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_11 and not isNil(var_156_9) then
				local var_156_12 = (arg_153_1.time_ - var_156_10) / var_156_11

				if arg_153_1.var_.characterEffect1011ui_story and not isNil(var_156_9) then
					arg_153_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_10 + var_156_11 and arg_153_1.time_ < var_156_10 + var_156_11 + arg_156_0 and not isNil(var_156_9) and arg_153_1.var_.characterEffect1011ui_story then
				arg_153_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_156_13 = arg_153_1.actors_["1156ui_story"]
			local var_156_14 = 0

			if var_156_14 < arg_153_1.time_ and arg_153_1.time_ <= var_156_14 + arg_156_0 and not isNil(var_156_13) and arg_153_1.var_.characterEffect1156ui_story == nil then
				arg_153_1.var_.characterEffect1156ui_story = var_156_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_15 = 0.200000002980232

			if var_156_14 <= arg_153_1.time_ and arg_153_1.time_ < var_156_14 + var_156_15 and not isNil(var_156_13) then
				local var_156_16 = (arg_153_1.time_ - var_156_14) / var_156_15

				if arg_153_1.var_.characterEffect1156ui_story and not isNil(var_156_13) then
					local var_156_17 = Mathf.Lerp(0, 0.5, var_156_16)

					arg_153_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1156ui_story.fillRatio = var_156_17
				end
			end

			if arg_153_1.time_ >= var_156_14 + var_156_15 and arg_153_1.time_ < var_156_14 + var_156_15 + arg_156_0 and not isNil(var_156_13) and arg_153_1.var_.characterEffect1156ui_story then
				local var_156_18 = 0.5

				arg_153_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1156ui_story.fillRatio = var_156_18
			end

			local var_156_19 = 0

			if var_156_19 < arg_153_1.time_ and arg_153_1.time_ <= var_156_19 + arg_156_0 then
				arg_153_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action1_1")
			end

			local var_156_20 = 0

			if var_156_20 < arg_153_1.time_ and arg_153_1.time_ <= var_156_20 + arg_156_0 then
				arg_153_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_156_21 = 0
			local var_156_22 = 0.825

			if var_156_21 < arg_153_1.time_ and arg_153_1.time_ <= var_156_21 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_23 = arg_153_1:FormatText(StoryNameCfg[37].name)

				arg_153_1.leftNameTxt_.text = var_156_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_24 = arg_153_1:GetWordFromCfg(321102037)
				local var_156_25 = arg_153_1:FormatText(var_156_24.content)

				arg_153_1.text_.text = var_156_25

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_26 = 33
				local var_156_27 = utf8.len(var_156_25)
				local var_156_28 = var_156_26 <= 0 and var_156_22 or var_156_22 * (var_156_27 / var_156_26)

				if var_156_28 > 0 and var_156_22 < var_156_28 then
					arg_153_1.talkMaxDuration = var_156_28

					if var_156_28 + var_156_21 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_28 + var_156_21
					end
				end

				arg_153_1.text_.text = var_156_25
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102037", "story_v_out_321102.awb") ~= 0 then
					local var_156_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102037", "story_v_out_321102.awb") / 1000

					if var_156_29 + var_156_21 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_29 + var_156_21
					end

					if var_156_24.prefab_name ~= "" and arg_153_1.actors_[var_156_24.prefab_name] ~= nil then
						local var_156_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_24.prefab_name].transform, "story_v_out_321102", "321102037", "story_v_out_321102.awb")

						arg_153_1:RecordAudio("321102037", var_156_30)
						arg_153_1:RecordAudio("321102037", var_156_30)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_321102", "321102037", "story_v_out_321102.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_321102", "321102037", "story_v_out_321102.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_31 = math.max(var_156_22, arg_153_1.talkMaxDuration)

			if var_156_21 <= arg_153_1.time_ and arg_153_1.time_ < var_156_21 + var_156_31 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_21) / var_156_31

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_21 + var_156_31 and arg_153_1.time_ < var_156_21 + var_156_31 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play321102038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 321102038
		arg_157_1.duration_ = 5.47

		local var_157_0 = {
			zh = 4.4,
			ja = 5.466
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play321102039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["1156ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos1156ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(-0.9, -1.1, -6.18)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1156ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["1156ui_story"]
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1156ui_story == nil then
				arg_157_1.var_.characterEffect1156ui_story = var_160_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_11 = 0.200000002980232

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 and not isNil(var_160_9) then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11

				if arg_157_1.var_.characterEffect1156ui_story and not isNil(var_160_9) then
					arg_157_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect1156ui_story then
				arg_157_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_160_13 = arg_157_1.actors_["1011ui_story"]
			local var_160_14 = 0

			if var_160_14 < arg_157_1.time_ and arg_157_1.time_ <= var_160_14 + arg_160_0 and not isNil(var_160_13) and arg_157_1.var_.characterEffect1011ui_story == nil then
				arg_157_1.var_.characterEffect1011ui_story = var_160_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_15 = 0.200000002980232

			if var_160_14 <= arg_157_1.time_ and arg_157_1.time_ < var_160_14 + var_160_15 and not isNil(var_160_13) then
				local var_160_16 = (arg_157_1.time_ - var_160_14) / var_160_15

				if arg_157_1.var_.characterEffect1011ui_story and not isNil(var_160_13) then
					local var_160_17 = Mathf.Lerp(0, 0.5, var_160_16)

					arg_157_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1011ui_story.fillRatio = var_160_17
				end
			end

			if arg_157_1.time_ >= var_160_14 + var_160_15 and arg_157_1.time_ < var_160_14 + var_160_15 + arg_160_0 and not isNil(var_160_13) and arg_157_1.var_.characterEffect1011ui_story then
				local var_160_18 = 0.5

				arg_157_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1011ui_story.fillRatio = var_160_18
			end

			local var_160_19 = 0

			if var_160_19 < arg_157_1.time_ and arg_157_1.time_ <= var_160_19 + arg_160_0 then
				arg_157_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_1")
			end

			local var_160_20 = 0

			if var_160_20 < arg_157_1.time_ and arg_157_1.time_ <= var_160_20 + arg_160_0 then
				arg_157_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_160_21 = 0
			local var_160_22 = 0.625

			if var_160_21 < arg_157_1.time_ and arg_157_1.time_ <= var_160_21 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_23 = arg_157_1:FormatText(StoryNameCfg[605].name)

				arg_157_1.leftNameTxt_.text = var_160_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_24 = arg_157_1:GetWordFromCfg(321102038)
				local var_160_25 = arg_157_1:FormatText(var_160_24.content)

				arg_157_1.text_.text = var_160_25

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_26 = 25
				local var_160_27 = utf8.len(var_160_25)
				local var_160_28 = var_160_26 <= 0 and var_160_22 or var_160_22 * (var_160_27 / var_160_26)

				if var_160_28 > 0 and var_160_22 < var_160_28 then
					arg_157_1.talkMaxDuration = var_160_28

					if var_160_28 + var_160_21 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_28 + var_160_21
					end
				end

				arg_157_1.text_.text = var_160_25
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102038", "story_v_out_321102.awb") ~= 0 then
					local var_160_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102038", "story_v_out_321102.awb") / 1000

					if var_160_29 + var_160_21 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_29 + var_160_21
					end

					if var_160_24.prefab_name ~= "" and arg_157_1.actors_[var_160_24.prefab_name] ~= nil then
						local var_160_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_24.prefab_name].transform, "story_v_out_321102", "321102038", "story_v_out_321102.awb")

						arg_157_1:RecordAudio("321102038", var_160_30)
						arg_157_1:RecordAudio("321102038", var_160_30)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_321102", "321102038", "story_v_out_321102.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_321102", "321102038", "story_v_out_321102.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_31 = math.max(var_160_22, arg_157_1.talkMaxDuration)

			if var_160_21 <= arg_157_1.time_ and arg_157_1.time_ < var_160_21 + var_160_31 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_21) / var_160_31

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_21 + var_160_31 and arg_157_1.time_ < var_160_21 + var_160_31 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play321102039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 321102039
		arg_161_1.duration_ = 8.6

		local var_161_0 = {
			zh = 6,
			ja = 8.6
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play321102040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1011ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos1011ui_story = var_164_0.localPosition
			end

			local var_164_2 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2
				local var_164_4 = Vector3.New(0.7, -0.71, -6)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1011ui_story, var_164_4, var_164_3)

				local var_164_5 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_5.x, var_164_5.y, var_164_5.z)

				local var_164_6 = var_164_0.localEulerAngles

				var_164_6.z = 0
				var_164_6.x = 0
				var_164_0.localEulerAngles = var_164_6
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_164_7 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_7.x, var_164_7.y, var_164_7.z)

				local var_164_8 = var_164_0.localEulerAngles

				var_164_8.z = 0
				var_164_8.x = 0
				var_164_0.localEulerAngles = var_164_8
			end

			local var_164_9 = arg_161_1.actors_["1011ui_story"]
			local var_164_10 = 0

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect1011ui_story == nil then
				arg_161_1.var_.characterEffect1011ui_story = var_164_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_11 = 0.200000002980232

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_11 and not isNil(var_164_9) then
				local var_164_12 = (arg_161_1.time_ - var_164_10) / var_164_11

				if arg_161_1.var_.characterEffect1011ui_story and not isNil(var_164_9) then
					arg_161_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_10 + var_164_11 and arg_161_1.time_ < var_164_10 + var_164_11 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect1011ui_story then
				arg_161_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_164_13 = arg_161_1.actors_["1156ui_story"]
			local var_164_14 = 0

			if var_164_14 < arg_161_1.time_ and arg_161_1.time_ <= var_164_14 + arg_164_0 and not isNil(var_164_13) and arg_161_1.var_.characterEffect1156ui_story == nil then
				arg_161_1.var_.characterEffect1156ui_story = var_164_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_15 = 0.200000002980232

			if var_164_14 <= arg_161_1.time_ and arg_161_1.time_ < var_164_14 + var_164_15 and not isNil(var_164_13) then
				local var_164_16 = (arg_161_1.time_ - var_164_14) / var_164_15

				if arg_161_1.var_.characterEffect1156ui_story and not isNil(var_164_13) then
					local var_164_17 = Mathf.Lerp(0, 0.5, var_164_16)

					arg_161_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1156ui_story.fillRatio = var_164_17
				end
			end

			if arg_161_1.time_ >= var_164_14 + var_164_15 and arg_161_1.time_ < var_164_14 + var_164_15 + arg_164_0 and not isNil(var_164_13) and arg_161_1.var_.characterEffect1156ui_story then
				local var_164_18 = 0.5

				arg_161_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1156ui_story.fillRatio = var_164_18
			end

			local var_164_19 = 0

			if var_164_19 < arg_161_1.time_ and arg_161_1.time_ <= var_164_19 + arg_164_0 then
				arg_161_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_164_20 = 0

			if var_164_20 < arg_161_1.time_ and arg_161_1.time_ <= var_164_20 + arg_164_0 then
				arg_161_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_164_21 = 0
			local var_164_22 = 0.575

			if var_164_21 < arg_161_1.time_ and arg_161_1.time_ <= var_164_21 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_23 = arg_161_1:FormatText(StoryNameCfg[37].name)

				arg_161_1.leftNameTxt_.text = var_164_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_24 = arg_161_1:GetWordFromCfg(321102039)
				local var_164_25 = arg_161_1:FormatText(var_164_24.content)

				arg_161_1.text_.text = var_164_25

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_26 = 23
				local var_164_27 = utf8.len(var_164_25)
				local var_164_28 = var_164_26 <= 0 and var_164_22 or var_164_22 * (var_164_27 / var_164_26)

				if var_164_28 > 0 and var_164_22 < var_164_28 then
					arg_161_1.talkMaxDuration = var_164_28

					if var_164_28 + var_164_21 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_28 + var_164_21
					end
				end

				arg_161_1.text_.text = var_164_25
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102039", "story_v_out_321102.awb") ~= 0 then
					local var_164_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102039", "story_v_out_321102.awb") / 1000

					if var_164_29 + var_164_21 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_29 + var_164_21
					end

					if var_164_24.prefab_name ~= "" and arg_161_1.actors_[var_164_24.prefab_name] ~= nil then
						local var_164_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_24.prefab_name].transform, "story_v_out_321102", "321102039", "story_v_out_321102.awb")

						arg_161_1:RecordAudio("321102039", var_164_30)
						arg_161_1:RecordAudio("321102039", var_164_30)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_321102", "321102039", "story_v_out_321102.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_321102", "321102039", "story_v_out_321102.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_31 = math.max(var_164_22, arg_161_1.talkMaxDuration)

			if var_164_21 <= arg_161_1.time_ and arg_161_1.time_ < var_164_21 + var_164_31 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_21) / var_164_31

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_21 + var_164_31 and arg_161_1.time_ < var_164_21 + var_164_31 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play321102040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 321102040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play321102041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1011ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1011ui_story == nil then
				arg_165_1.var_.characterEffect1011ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect1011ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1011ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1011ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1011ui_story.fillRatio = var_168_5
			end

			local var_168_6 = 0
			local var_168_7 = 1.175

			if var_168_6 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:GetWordFromCfg(321102040)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 47
				local var_168_11 = utf8.len(var_168_9)
				local var_168_12 = var_168_10 <= 0 and var_168_7 or var_168_7 * (var_168_11 / var_168_10)

				if var_168_12 > 0 and var_168_7 < var_168_12 then
					arg_165_1.talkMaxDuration = var_168_12

					if var_168_12 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_12 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_9
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_13 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_13 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_13

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_13 and arg_165_1.time_ < var_168_6 + var_168_13 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play321102041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 321102041
		arg_169_1.duration_ = 2.27

		local var_169_0 = {
			zh = 1.999999999999,
			ja = 2.266
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
				arg_169_0:Play321102042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["1011ui_story"].transform
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.var_.moveOldPos1011ui_story = var_172_0.localPosition
			end

			local var_172_2 = 0.001

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2
				local var_172_4 = Vector3.New(0.7, -0.71, -6)

				var_172_0.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1011ui_story, var_172_4, var_172_3)

				local var_172_5 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_5.x, var_172_5.y, var_172_5.z)

				local var_172_6 = var_172_0.localEulerAngles

				var_172_6.z = 0
				var_172_6.x = 0
				var_172_0.localEulerAngles = var_172_6
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 then
				var_172_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_172_7 = manager.ui.mainCamera.transform.position - var_172_0.position

				var_172_0.forward = Vector3.New(var_172_7.x, var_172_7.y, var_172_7.z)

				local var_172_8 = var_172_0.localEulerAngles

				var_172_8.z = 0
				var_172_8.x = 0
				var_172_0.localEulerAngles = var_172_8
			end

			local var_172_9 = arg_169_1.actors_["1011ui_story"]
			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1011ui_story == nil then
				arg_169_1.var_.characterEffect1011ui_story = var_172_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_11 = 0.200000002980232

			if var_172_10 <= arg_169_1.time_ and arg_169_1.time_ < var_172_10 + var_172_11 and not isNil(var_172_9) then
				local var_172_12 = (arg_169_1.time_ - var_172_10) / var_172_11

				if arg_169_1.var_.characterEffect1011ui_story and not isNil(var_172_9) then
					arg_169_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_10 + var_172_11 and arg_169_1.time_ < var_172_10 + var_172_11 + arg_172_0 and not isNil(var_172_9) and arg_169_1.var_.characterEffect1011ui_story then
				arg_169_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_172_13 = 0

			if var_172_13 < arg_169_1.time_ and arg_169_1.time_ <= var_172_13 + arg_172_0 then
				arg_169_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_2")
			end

			local var_172_14 = 0

			if var_172_14 < arg_169_1.time_ and arg_169_1.time_ <= var_172_14 + arg_172_0 then
				arg_169_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_172_15 = 0
			local var_172_16 = 0.15

			if var_172_15 < arg_169_1.time_ and arg_169_1.time_ <= var_172_15 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_17 = arg_169_1:FormatText(StoryNameCfg[37].name)

				arg_169_1.leftNameTxt_.text = var_172_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_18 = arg_169_1:GetWordFromCfg(321102041)
				local var_172_19 = arg_169_1:FormatText(var_172_18.content)

				arg_169_1.text_.text = var_172_19

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_20 = 6
				local var_172_21 = utf8.len(var_172_19)
				local var_172_22 = var_172_20 <= 0 and var_172_16 or var_172_16 * (var_172_21 / var_172_20)

				if var_172_22 > 0 and var_172_16 < var_172_22 then
					arg_169_1.talkMaxDuration = var_172_22

					if var_172_22 + var_172_15 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_22 + var_172_15
					end
				end

				arg_169_1.text_.text = var_172_19
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102041", "story_v_out_321102.awb") ~= 0 then
					local var_172_23 = manager.audio:GetVoiceLength("story_v_out_321102", "321102041", "story_v_out_321102.awb") / 1000

					if var_172_23 + var_172_15 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_23 + var_172_15
					end

					if var_172_18.prefab_name ~= "" and arg_169_1.actors_[var_172_18.prefab_name] ~= nil then
						local var_172_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_18.prefab_name].transform, "story_v_out_321102", "321102041", "story_v_out_321102.awb")

						arg_169_1:RecordAudio("321102041", var_172_24)
						arg_169_1:RecordAudio("321102041", var_172_24)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_321102", "321102041", "story_v_out_321102.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_321102", "321102041", "story_v_out_321102.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_25 = math.max(var_172_16, arg_169_1.talkMaxDuration)

			if var_172_15 <= arg_169_1.time_ and arg_169_1.time_ < var_172_15 + var_172_25 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_15) / var_172_25

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_15 + var_172_25 and arg_169_1.time_ < var_172_15 + var_172_25 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play321102042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 321102042
		arg_173_1.duration_ = 9.43

		local var_173_0 = {
			zh = 6.7,
			ja = 9.433
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play321102043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1156ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos1156ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(-0.9, -1.1, -6.18)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1156ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["1156ui_story"]
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1156ui_story == nil then
				arg_173_1.var_.characterEffect1156ui_story = var_176_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_11 = 0.200000002980232

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 and not isNil(var_176_9) then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11

				if arg_173_1.var_.characterEffect1156ui_story and not isNil(var_176_9) then
					arg_173_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect1156ui_story then
				arg_173_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_176_13 = arg_173_1.actors_["1011ui_story"]
			local var_176_14 = 0

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 and not isNil(var_176_13) and arg_173_1.var_.characterEffect1011ui_story == nil then
				arg_173_1.var_.characterEffect1011ui_story = var_176_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_15 = 0.200000002980232

			if var_176_14 <= arg_173_1.time_ and arg_173_1.time_ < var_176_14 + var_176_15 and not isNil(var_176_13) then
				local var_176_16 = (arg_173_1.time_ - var_176_14) / var_176_15

				if arg_173_1.var_.characterEffect1011ui_story and not isNil(var_176_13) then
					local var_176_17 = Mathf.Lerp(0, 0.5, var_176_16)

					arg_173_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1011ui_story.fillRatio = var_176_17
				end
			end

			if arg_173_1.time_ >= var_176_14 + var_176_15 and arg_173_1.time_ < var_176_14 + var_176_15 + arg_176_0 and not isNil(var_176_13) and arg_173_1.var_.characterEffect1011ui_story then
				local var_176_18 = 0.5

				arg_173_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1011ui_story.fillRatio = var_176_18
			end

			local var_176_19 = 0

			if var_176_19 < arg_173_1.time_ and arg_173_1.time_ <= var_176_19 + arg_176_0 then
				arg_173_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_2")
			end

			local var_176_20 = 0

			if var_176_20 < arg_173_1.time_ and arg_173_1.time_ <= var_176_20 + arg_176_0 then
				arg_173_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_176_21 = 0
			local var_176_22 = 0.875

			if var_176_21 < arg_173_1.time_ and arg_173_1.time_ <= var_176_21 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_23 = arg_173_1:FormatText(StoryNameCfg[605].name)

				arg_173_1.leftNameTxt_.text = var_176_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_24 = arg_173_1:GetWordFromCfg(321102042)
				local var_176_25 = arg_173_1:FormatText(var_176_24.content)

				arg_173_1.text_.text = var_176_25

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_26 = 35
				local var_176_27 = utf8.len(var_176_25)
				local var_176_28 = var_176_26 <= 0 and var_176_22 or var_176_22 * (var_176_27 / var_176_26)

				if var_176_28 > 0 and var_176_22 < var_176_28 then
					arg_173_1.talkMaxDuration = var_176_28

					if var_176_28 + var_176_21 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_28 + var_176_21
					end
				end

				arg_173_1.text_.text = var_176_25
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102042", "story_v_out_321102.awb") ~= 0 then
					local var_176_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102042", "story_v_out_321102.awb") / 1000

					if var_176_29 + var_176_21 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_29 + var_176_21
					end

					if var_176_24.prefab_name ~= "" and arg_173_1.actors_[var_176_24.prefab_name] ~= nil then
						local var_176_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_24.prefab_name].transform, "story_v_out_321102", "321102042", "story_v_out_321102.awb")

						arg_173_1:RecordAudio("321102042", var_176_30)
						arg_173_1:RecordAudio("321102042", var_176_30)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_321102", "321102042", "story_v_out_321102.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_321102", "321102042", "story_v_out_321102.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_31 = math.max(var_176_22, arg_173_1.talkMaxDuration)

			if var_176_21 <= arg_173_1.time_ and arg_173_1.time_ < var_176_21 + var_176_31 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_21) / var_176_31

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_21 + var_176_31 and arg_173_1.time_ < var_176_21 + var_176_31 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play321102043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 321102043
		arg_177_1.duration_ = 10.43

		local var_177_0 = {
			zh = 6.633,
			ja = 10.433
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
				arg_177_0:Play321102044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["1011ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos1011ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0.7, -0.71, -6)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1011ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["1011ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1011ui_story == nil then
				arg_177_1.var_.characterEffect1011ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.200000002980232

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect1011ui_story and not isNil(var_180_9) then
					arg_177_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect1011ui_story then
				arg_177_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_180_13 = arg_177_1.actors_["1156ui_story"]
			local var_180_14 = 0

			if var_180_14 < arg_177_1.time_ and arg_177_1.time_ <= var_180_14 + arg_180_0 and not isNil(var_180_13) and arg_177_1.var_.characterEffect1156ui_story == nil then
				arg_177_1.var_.characterEffect1156ui_story = var_180_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_15 = 0.200000002980232

			if var_180_14 <= arg_177_1.time_ and arg_177_1.time_ < var_180_14 + var_180_15 and not isNil(var_180_13) then
				local var_180_16 = (arg_177_1.time_ - var_180_14) / var_180_15

				if arg_177_1.var_.characterEffect1156ui_story and not isNil(var_180_13) then
					local var_180_17 = Mathf.Lerp(0, 0.5, var_180_16)

					arg_177_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1156ui_story.fillRatio = var_180_17
				end
			end

			if arg_177_1.time_ >= var_180_14 + var_180_15 and arg_177_1.time_ < var_180_14 + var_180_15 + arg_180_0 and not isNil(var_180_13) and arg_177_1.var_.characterEffect1156ui_story then
				local var_180_18 = 0.5

				arg_177_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1156ui_story.fillRatio = var_180_18
			end

			local var_180_19 = 0

			if var_180_19 < arg_177_1.time_ and arg_177_1.time_ <= var_180_19 + arg_180_0 then
				arg_177_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_180_20 = 0
			local var_180_21 = 0.7

			if var_180_20 < arg_177_1.time_ and arg_177_1.time_ <= var_180_20 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_22 = arg_177_1:FormatText(StoryNameCfg[37].name)

				arg_177_1.leftNameTxt_.text = var_180_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_23 = arg_177_1:GetWordFromCfg(321102043)
				local var_180_24 = arg_177_1:FormatText(var_180_23.content)

				arg_177_1.text_.text = var_180_24

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_25 = 28
				local var_180_26 = utf8.len(var_180_24)
				local var_180_27 = var_180_25 <= 0 and var_180_21 or var_180_21 * (var_180_26 / var_180_25)

				if var_180_27 > 0 and var_180_21 < var_180_27 then
					arg_177_1.talkMaxDuration = var_180_27

					if var_180_27 + var_180_20 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_27 + var_180_20
					end
				end

				arg_177_1.text_.text = var_180_24
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102043", "story_v_out_321102.awb") ~= 0 then
					local var_180_28 = manager.audio:GetVoiceLength("story_v_out_321102", "321102043", "story_v_out_321102.awb") / 1000

					if var_180_28 + var_180_20 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_28 + var_180_20
					end

					if var_180_23.prefab_name ~= "" and arg_177_1.actors_[var_180_23.prefab_name] ~= nil then
						local var_180_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_23.prefab_name].transform, "story_v_out_321102", "321102043", "story_v_out_321102.awb")

						arg_177_1:RecordAudio("321102043", var_180_29)
						arg_177_1:RecordAudio("321102043", var_180_29)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_321102", "321102043", "story_v_out_321102.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_321102", "321102043", "story_v_out_321102.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_30 = math.max(var_180_21, arg_177_1.talkMaxDuration)

			if var_180_20 <= arg_177_1.time_ and arg_177_1.time_ < var_180_20 + var_180_30 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_20) / var_180_30

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_20 + var_180_30 and arg_177_1.time_ < var_180_20 + var_180_30 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321102044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 321102044
		arg_181_1.duration_ = 6.63

		local var_181_0 = {
			zh = 4.266,
			ja = 6.633
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
				arg_181_0:Play321102045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["1156ui_story"].transform
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.var_.moveOldPos1156ui_story = var_184_0.localPosition
			end

			local var_184_2 = 0.001

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2
				local var_184_4 = Vector3.New(-0.9, -1.1, -6.18)

				var_184_0.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1156ui_story, var_184_4, var_184_3)

				local var_184_5 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_5.x, var_184_5.y, var_184_5.z)

				local var_184_6 = var_184_0.localEulerAngles

				var_184_6.z = 0
				var_184_6.x = 0
				var_184_0.localEulerAngles = var_184_6
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 then
				var_184_0.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_184_7 = manager.ui.mainCamera.transform.position - var_184_0.position

				var_184_0.forward = Vector3.New(var_184_7.x, var_184_7.y, var_184_7.z)

				local var_184_8 = var_184_0.localEulerAngles

				var_184_8.z = 0
				var_184_8.x = 0
				var_184_0.localEulerAngles = var_184_8
			end

			local var_184_9 = arg_181_1.actors_["1156ui_story"]
			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1156ui_story == nil then
				arg_181_1.var_.characterEffect1156ui_story = var_184_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_11 = 0.200000002980232

			if var_184_10 <= arg_181_1.time_ and arg_181_1.time_ < var_184_10 + var_184_11 and not isNil(var_184_9) then
				local var_184_12 = (arg_181_1.time_ - var_184_10) / var_184_11

				if arg_181_1.var_.characterEffect1156ui_story and not isNil(var_184_9) then
					arg_181_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_10 + var_184_11 and arg_181_1.time_ < var_184_10 + var_184_11 + arg_184_0 and not isNil(var_184_9) and arg_181_1.var_.characterEffect1156ui_story then
				arg_181_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_184_13 = arg_181_1.actors_["1011ui_story"]
			local var_184_14 = 0

			if var_184_14 < arg_181_1.time_ and arg_181_1.time_ <= var_184_14 + arg_184_0 and not isNil(var_184_13) and arg_181_1.var_.characterEffect1011ui_story == nil then
				arg_181_1.var_.characterEffect1011ui_story = var_184_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_15 = 0.200000002980232

			if var_184_14 <= arg_181_1.time_ and arg_181_1.time_ < var_184_14 + var_184_15 and not isNil(var_184_13) then
				local var_184_16 = (arg_181_1.time_ - var_184_14) / var_184_15

				if arg_181_1.var_.characterEffect1011ui_story and not isNil(var_184_13) then
					local var_184_17 = Mathf.Lerp(0, 0.5, var_184_16)

					arg_181_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1011ui_story.fillRatio = var_184_17
				end
			end

			if arg_181_1.time_ >= var_184_14 + var_184_15 and arg_181_1.time_ < var_184_14 + var_184_15 + arg_184_0 and not isNil(var_184_13) and arg_181_1.var_.characterEffect1011ui_story then
				local var_184_18 = 0.5

				arg_181_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1011ui_story.fillRatio = var_184_18
			end

			local var_184_19 = 0

			if var_184_19 < arg_181_1.time_ and arg_181_1.time_ <= var_184_19 + arg_184_0 then
				arg_181_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action5_1")
			end

			local var_184_20 = 0
			local var_184_21 = 0.525

			if var_184_20 < arg_181_1.time_ and arg_181_1.time_ <= var_184_20 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_22 = arg_181_1:FormatText(StoryNameCfg[605].name)

				arg_181_1.leftNameTxt_.text = var_184_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_23 = arg_181_1:GetWordFromCfg(321102044)
				local var_184_24 = arg_181_1:FormatText(var_184_23.content)

				arg_181_1.text_.text = var_184_24

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_25 = 21
				local var_184_26 = utf8.len(var_184_24)
				local var_184_27 = var_184_25 <= 0 and var_184_21 or var_184_21 * (var_184_26 / var_184_25)

				if var_184_27 > 0 and var_184_21 < var_184_27 then
					arg_181_1.talkMaxDuration = var_184_27

					if var_184_27 + var_184_20 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_27 + var_184_20
					end
				end

				arg_181_1.text_.text = var_184_24
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102044", "story_v_out_321102.awb") ~= 0 then
					local var_184_28 = manager.audio:GetVoiceLength("story_v_out_321102", "321102044", "story_v_out_321102.awb") / 1000

					if var_184_28 + var_184_20 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_28 + var_184_20
					end

					if var_184_23.prefab_name ~= "" and arg_181_1.actors_[var_184_23.prefab_name] ~= nil then
						local var_184_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_23.prefab_name].transform, "story_v_out_321102", "321102044", "story_v_out_321102.awb")

						arg_181_1:RecordAudio("321102044", var_184_29)
						arg_181_1:RecordAudio("321102044", var_184_29)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_321102", "321102044", "story_v_out_321102.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_321102", "321102044", "story_v_out_321102.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_30 = math.max(var_184_21, arg_181_1.talkMaxDuration)

			if var_184_20 <= arg_181_1.time_ and arg_181_1.time_ < var_184_20 + var_184_30 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_20) / var_184_30

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_20 + var_184_30 and arg_181_1.time_ < var_184_20 + var_184_30 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play321102045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 321102045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play321102046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = arg_185_1.actors_["1011ui_story"].transform
			local var_188_1 = 0

			if var_188_1 < arg_185_1.time_ and arg_185_1.time_ <= var_188_1 + arg_188_0 then
				arg_185_1.var_.moveOldPos1011ui_story = var_188_0.localPosition
			end

			local var_188_2 = 0.001

			if var_188_1 <= arg_185_1.time_ and arg_185_1.time_ < var_188_1 + var_188_2 then
				local var_188_3 = (arg_185_1.time_ - var_188_1) / var_188_2
				local var_188_4 = Vector3.New(0, 100, 0)

				var_188_0.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1011ui_story, var_188_4, var_188_3)

				local var_188_5 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_5.x, var_188_5.y, var_188_5.z)

				local var_188_6 = var_188_0.localEulerAngles

				var_188_6.z = 0
				var_188_6.x = 0
				var_188_0.localEulerAngles = var_188_6
			end

			if arg_185_1.time_ >= var_188_1 + var_188_2 and arg_185_1.time_ < var_188_1 + var_188_2 + arg_188_0 then
				var_188_0.localPosition = Vector3.New(0, 100, 0)

				local var_188_7 = manager.ui.mainCamera.transform.position - var_188_0.position

				var_188_0.forward = Vector3.New(var_188_7.x, var_188_7.y, var_188_7.z)

				local var_188_8 = var_188_0.localEulerAngles

				var_188_8.z = 0
				var_188_8.x = 0
				var_188_0.localEulerAngles = var_188_8
			end

			local var_188_9 = arg_185_1.actors_["1156ui_story"].transform
			local var_188_10 = 0

			if var_188_10 < arg_185_1.time_ and arg_185_1.time_ <= var_188_10 + arg_188_0 then
				arg_185_1.var_.moveOldPos1156ui_story = var_188_9.localPosition
			end

			local var_188_11 = 0.001

			if var_188_10 <= arg_185_1.time_ and arg_185_1.time_ < var_188_10 + var_188_11 then
				local var_188_12 = (arg_185_1.time_ - var_188_10) / var_188_11
				local var_188_13 = Vector3.New(0, 100, 0)

				var_188_9.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1156ui_story, var_188_13, var_188_12)

				local var_188_14 = manager.ui.mainCamera.transform.position - var_188_9.position

				var_188_9.forward = Vector3.New(var_188_14.x, var_188_14.y, var_188_14.z)

				local var_188_15 = var_188_9.localEulerAngles

				var_188_15.z = 0
				var_188_15.x = 0
				var_188_9.localEulerAngles = var_188_15
			end

			if arg_185_1.time_ >= var_188_10 + var_188_11 and arg_185_1.time_ < var_188_10 + var_188_11 + arg_188_0 then
				var_188_9.localPosition = Vector3.New(0, 100, 0)

				local var_188_16 = manager.ui.mainCamera.transform.position - var_188_9.position

				var_188_9.forward = Vector3.New(var_188_16.x, var_188_16.y, var_188_16.z)

				local var_188_17 = var_188_9.localEulerAngles

				var_188_17.z = 0
				var_188_17.x = 0
				var_188_9.localEulerAngles = var_188_17
			end

			local var_188_18 = arg_185_1.actors_["1156ui_story"]
			local var_188_19 = 0

			if var_188_19 < arg_185_1.time_ and arg_185_1.time_ <= var_188_19 + arg_188_0 and not isNil(var_188_18) and arg_185_1.var_.characterEffect1156ui_story == nil then
				arg_185_1.var_.characterEffect1156ui_story = var_188_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_20 = 0.200000002980232

			if var_188_19 <= arg_185_1.time_ and arg_185_1.time_ < var_188_19 + var_188_20 and not isNil(var_188_18) then
				local var_188_21 = (arg_185_1.time_ - var_188_19) / var_188_20

				if arg_185_1.var_.characterEffect1156ui_story and not isNil(var_188_18) then
					local var_188_22 = Mathf.Lerp(0, 0.5, var_188_21)

					arg_185_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_185_1.var_.characterEffect1156ui_story.fillRatio = var_188_22
				end
			end

			if arg_185_1.time_ >= var_188_19 + var_188_20 and arg_185_1.time_ < var_188_19 + var_188_20 + arg_188_0 and not isNil(var_188_18) and arg_185_1.var_.characterEffect1156ui_story then
				local var_188_23 = 0.5

				arg_185_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_185_1.var_.characterEffect1156ui_story.fillRatio = var_188_23
			end

			local var_188_24 = 0
			local var_188_25 = 1.4

			if var_188_24 < arg_185_1.time_ and arg_185_1.time_ <= var_188_24 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_26 = arg_185_1:GetWordFromCfg(321102045)
				local var_188_27 = arg_185_1:FormatText(var_188_26.content)

				arg_185_1.text_.text = var_188_27

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_28 = 56
				local var_188_29 = utf8.len(var_188_27)
				local var_188_30 = var_188_28 <= 0 and var_188_25 or var_188_25 * (var_188_29 / var_188_28)

				if var_188_30 > 0 and var_188_25 < var_188_30 then
					arg_185_1.talkMaxDuration = var_188_30

					if var_188_30 + var_188_24 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_30 + var_188_24
					end
				end

				arg_185_1.text_.text = var_188_27
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_31 = math.max(var_188_25, arg_185_1.talkMaxDuration)

			if var_188_24 <= arg_185_1.time_ and arg_185_1.time_ < var_188_24 + var_188_31 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_24) / var_188_31

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_24 + var_188_31 and arg_185_1.time_ < var_188_24 + var_188_31 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_185_1:InitPlayNodeList()
	end,
	Play321102046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 321102046
		arg_189_1.duration_ = 6.87

		local var_189_0 = {
			zh = 5.8,
			ja = 6.866
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
				arg_189_0:Play321102047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["1011ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos1011ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0.7, -0.71, -6)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1011ui_story, var_192_4, var_192_3)

				local var_192_5 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_5.x, var_192_5.y, var_192_5.z)

				local var_192_6 = var_192_0.localEulerAngles

				var_192_6.z = 0
				var_192_6.x = 0
				var_192_0.localEulerAngles = var_192_6
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_192_7 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_7.x, var_192_7.y, var_192_7.z)

				local var_192_8 = var_192_0.localEulerAngles

				var_192_8.z = 0
				var_192_8.x = 0
				var_192_0.localEulerAngles = var_192_8
			end

			local var_192_9 = arg_189_1.actors_["1156ui_story"].transform
			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 then
				arg_189_1.var_.moveOldPos1156ui_story = var_192_9.localPosition
			end

			local var_192_11 = 0.001

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_11 then
				local var_192_12 = (arg_189_1.time_ - var_192_10) / var_192_11
				local var_192_13 = Vector3.New(-0.9, -1.1, -6.18)

				var_192_9.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1156ui_story, var_192_13, var_192_12)

				local var_192_14 = manager.ui.mainCamera.transform.position - var_192_9.position

				var_192_9.forward = Vector3.New(var_192_14.x, var_192_14.y, var_192_14.z)

				local var_192_15 = var_192_9.localEulerAngles

				var_192_15.z = 0
				var_192_15.x = 0
				var_192_9.localEulerAngles = var_192_15
			end

			if arg_189_1.time_ >= var_192_10 + var_192_11 and arg_189_1.time_ < var_192_10 + var_192_11 + arg_192_0 then
				var_192_9.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_192_16 = manager.ui.mainCamera.transform.position - var_192_9.position

				var_192_9.forward = Vector3.New(var_192_16.x, var_192_16.y, var_192_16.z)

				local var_192_17 = var_192_9.localEulerAngles

				var_192_17.z = 0
				var_192_17.x = 0
				var_192_9.localEulerAngles = var_192_17
			end

			local var_192_18 = arg_189_1.actors_["1156ui_story"]
			local var_192_19 = 0

			if var_192_19 < arg_189_1.time_ and arg_189_1.time_ <= var_192_19 + arg_192_0 and not isNil(var_192_18) and arg_189_1.var_.characterEffect1156ui_story == nil then
				arg_189_1.var_.characterEffect1156ui_story = var_192_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_20 = 0.200000002980232

			if var_192_19 <= arg_189_1.time_ and arg_189_1.time_ < var_192_19 + var_192_20 and not isNil(var_192_18) then
				local var_192_21 = (arg_189_1.time_ - var_192_19) / var_192_20

				if arg_189_1.var_.characterEffect1156ui_story and not isNil(var_192_18) then
					arg_189_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_19 + var_192_20 and arg_189_1.time_ < var_192_19 + var_192_20 + arg_192_0 and not isNil(var_192_18) and arg_189_1.var_.characterEffect1156ui_story then
				arg_189_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_192_22 = 0

			if var_192_22 < arg_189_1.time_ and arg_189_1.time_ <= var_192_22 + arg_192_0 then
				arg_189_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_192_23 = 0
			local var_192_24 = 0.775

			if var_192_23 < arg_189_1.time_ and arg_189_1.time_ <= var_192_23 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_25 = arg_189_1:FormatText(StoryNameCfg[605].name)

				arg_189_1.leftNameTxt_.text = var_192_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_26 = arg_189_1:GetWordFromCfg(321102046)
				local var_192_27 = arg_189_1:FormatText(var_192_26.content)

				arg_189_1.text_.text = var_192_27

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_28 = 31
				local var_192_29 = utf8.len(var_192_27)
				local var_192_30 = var_192_28 <= 0 and var_192_24 or var_192_24 * (var_192_29 / var_192_28)

				if var_192_30 > 0 and var_192_24 < var_192_30 then
					arg_189_1.talkMaxDuration = var_192_30

					if var_192_30 + var_192_23 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_30 + var_192_23
					end
				end

				arg_189_1.text_.text = var_192_27
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102046", "story_v_out_321102.awb") ~= 0 then
					local var_192_31 = manager.audio:GetVoiceLength("story_v_out_321102", "321102046", "story_v_out_321102.awb") / 1000

					if var_192_31 + var_192_23 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_31 + var_192_23
					end

					if var_192_26.prefab_name ~= "" and arg_189_1.actors_[var_192_26.prefab_name] ~= nil then
						local var_192_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_26.prefab_name].transform, "story_v_out_321102", "321102046", "story_v_out_321102.awb")

						arg_189_1:RecordAudio("321102046", var_192_32)
						arg_189_1:RecordAudio("321102046", var_192_32)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_321102", "321102046", "story_v_out_321102.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_321102", "321102046", "story_v_out_321102.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_33 = math.max(var_192_24, arg_189_1.talkMaxDuration)

			if var_192_23 <= arg_189_1.time_ and arg_189_1.time_ < var_192_23 + var_192_33 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_23) / var_192_33

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_23 + var_192_33 and arg_189_1.time_ < var_192_23 + var_192_33 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play321102047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 321102047
		arg_193_1.duration_ = 14.6

		local var_193_0 = {
			zh = 8.866,
			ja = 14.6
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
				arg_193_0:Play321102048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = arg_193_1.actors_["1156ui_story"].transform
			local var_196_1 = 0

			if var_196_1 < arg_193_1.time_ and arg_193_1.time_ <= var_196_1 + arg_196_0 then
				arg_193_1.var_.moveOldPos1156ui_story = var_196_0.localPosition
			end

			local var_196_2 = 0.001

			if var_196_1 <= arg_193_1.time_ and arg_193_1.time_ < var_196_1 + var_196_2 then
				local var_196_3 = (arg_193_1.time_ - var_196_1) / var_196_2
				local var_196_4 = Vector3.New(-0.9, -1.1, -6.18)

				var_196_0.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1156ui_story, var_196_4, var_196_3)

				local var_196_5 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_5.x, var_196_5.y, var_196_5.z)

				local var_196_6 = var_196_0.localEulerAngles

				var_196_6.z = 0
				var_196_6.x = 0
				var_196_0.localEulerAngles = var_196_6
			end

			if arg_193_1.time_ >= var_196_1 + var_196_2 and arg_193_1.time_ < var_196_1 + var_196_2 + arg_196_0 then
				var_196_0.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_196_7 = manager.ui.mainCamera.transform.position - var_196_0.position

				var_196_0.forward = Vector3.New(var_196_7.x, var_196_7.y, var_196_7.z)

				local var_196_8 = var_196_0.localEulerAngles

				var_196_8.z = 0
				var_196_8.x = 0
				var_196_0.localEulerAngles = var_196_8
			end

			local var_196_9 = 0

			if var_196_9 < arg_193_1.time_ and arg_193_1.time_ <= var_196_9 + arg_196_0 then
				arg_193_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_196_10 = 0

			if var_196_10 < arg_193_1.time_ and arg_193_1.time_ <= var_196_10 + arg_196_0 then
				arg_193_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action5_2")
			end

			local var_196_11 = 0
			local var_196_12 = 1.225

			if var_196_11 < arg_193_1.time_ and arg_193_1.time_ <= var_196_11 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_13 = arg_193_1:FormatText(StoryNameCfg[605].name)

				arg_193_1.leftNameTxt_.text = var_196_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_14 = arg_193_1:GetWordFromCfg(321102047)
				local var_196_15 = arg_193_1:FormatText(var_196_14.content)

				arg_193_1.text_.text = var_196_15

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_16 = 49
				local var_196_17 = utf8.len(var_196_15)
				local var_196_18 = var_196_16 <= 0 and var_196_12 or var_196_12 * (var_196_17 / var_196_16)

				if var_196_18 > 0 and var_196_12 < var_196_18 then
					arg_193_1.talkMaxDuration = var_196_18

					if var_196_18 + var_196_11 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_18 + var_196_11
					end
				end

				arg_193_1.text_.text = var_196_15
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102047", "story_v_out_321102.awb") ~= 0 then
					local var_196_19 = manager.audio:GetVoiceLength("story_v_out_321102", "321102047", "story_v_out_321102.awb") / 1000

					if var_196_19 + var_196_11 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_19 + var_196_11
					end

					if var_196_14.prefab_name ~= "" and arg_193_1.actors_[var_196_14.prefab_name] ~= nil then
						local var_196_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_14.prefab_name].transform, "story_v_out_321102", "321102047", "story_v_out_321102.awb")

						arg_193_1:RecordAudio("321102047", var_196_20)
						arg_193_1:RecordAudio("321102047", var_196_20)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_321102", "321102047", "story_v_out_321102.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_321102", "321102047", "story_v_out_321102.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_21 = math.max(var_196_12, arg_193_1.talkMaxDuration)

			if var_196_11 <= arg_193_1.time_ and arg_193_1.time_ < var_196_11 + var_196_21 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_11) / var_196_21

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_11 + var_196_21 and arg_193_1.time_ < var_196_11 + var_196_21 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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
	Play321102048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 321102048
		arg_197_1.duration_ = 9.8

		local var_197_0 = {
			zh = 7.9,
			ja = 9.8
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
				arg_197_0:Play321102049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = arg_197_1.actors_["1011ui_story"].transform
			local var_200_1 = 0

			if var_200_1 < arg_197_1.time_ and arg_197_1.time_ <= var_200_1 + arg_200_0 then
				arg_197_1.var_.moveOldPos1011ui_story = var_200_0.localPosition
			end

			local var_200_2 = 0.001

			if var_200_1 <= arg_197_1.time_ and arg_197_1.time_ < var_200_1 + var_200_2 then
				local var_200_3 = (arg_197_1.time_ - var_200_1) / var_200_2
				local var_200_4 = Vector3.New(0.7, -0.71, -6)

				var_200_0.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1011ui_story, var_200_4, var_200_3)

				local var_200_5 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_5.x, var_200_5.y, var_200_5.z)

				local var_200_6 = var_200_0.localEulerAngles

				var_200_6.z = 0
				var_200_6.x = 0
				var_200_0.localEulerAngles = var_200_6
			end

			if arg_197_1.time_ >= var_200_1 + var_200_2 and arg_197_1.time_ < var_200_1 + var_200_2 + arg_200_0 then
				var_200_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_200_7 = manager.ui.mainCamera.transform.position - var_200_0.position

				var_200_0.forward = Vector3.New(var_200_7.x, var_200_7.y, var_200_7.z)

				local var_200_8 = var_200_0.localEulerAngles

				var_200_8.z = 0
				var_200_8.x = 0
				var_200_0.localEulerAngles = var_200_8
			end

			local var_200_9 = arg_197_1.actors_["1011ui_story"]
			local var_200_10 = 0

			if var_200_10 < arg_197_1.time_ and arg_197_1.time_ <= var_200_10 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1011ui_story == nil then
				arg_197_1.var_.characterEffect1011ui_story = var_200_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_11 = 0.200000002980232

			if var_200_10 <= arg_197_1.time_ and arg_197_1.time_ < var_200_10 + var_200_11 and not isNil(var_200_9) then
				local var_200_12 = (arg_197_1.time_ - var_200_10) / var_200_11

				if arg_197_1.var_.characterEffect1011ui_story and not isNil(var_200_9) then
					arg_197_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= var_200_10 + var_200_11 and arg_197_1.time_ < var_200_10 + var_200_11 + arg_200_0 and not isNil(var_200_9) and arg_197_1.var_.characterEffect1011ui_story then
				arg_197_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_200_13 = arg_197_1.actors_["1156ui_story"]
			local var_200_14 = 0

			if var_200_14 < arg_197_1.time_ and arg_197_1.time_ <= var_200_14 + arg_200_0 and not isNil(var_200_13) and arg_197_1.var_.characterEffect1156ui_story == nil then
				arg_197_1.var_.characterEffect1156ui_story = var_200_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_15 = 0.200000002980232

			if var_200_14 <= arg_197_1.time_ and arg_197_1.time_ < var_200_14 + var_200_15 and not isNil(var_200_13) then
				local var_200_16 = (arg_197_1.time_ - var_200_14) / var_200_15

				if arg_197_1.var_.characterEffect1156ui_story and not isNil(var_200_13) then
					local var_200_17 = Mathf.Lerp(0, 0.5, var_200_16)

					arg_197_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1156ui_story.fillRatio = var_200_17
				end
			end

			if arg_197_1.time_ >= var_200_14 + var_200_15 and arg_197_1.time_ < var_200_14 + var_200_15 + arg_200_0 and not isNil(var_200_13) and arg_197_1.var_.characterEffect1156ui_story then
				local var_200_18 = 0.5

				arg_197_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1156ui_story.fillRatio = var_200_18
			end

			local var_200_19 = 0

			if var_200_19 < arg_197_1.time_ and arg_197_1.time_ <= var_200_19 + arg_200_0 then
				arg_197_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_200_20 = 0

			if var_200_20 < arg_197_1.time_ and arg_197_1.time_ <= var_200_20 + arg_200_0 then
				arg_197_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_200_21 = 0
			local var_200_22 = 0.9

			if var_200_21 < arg_197_1.time_ and arg_197_1.time_ <= var_200_21 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_23 = arg_197_1:FormatText(StoryNameCfg[37].name)

				arg_197_1.leftNameTxt_.text = var_200_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_24 = arg_197_1:GetWordFromCfg(321102048)
				local var_200_25 = arg_197_1:FormatText(var_200_24.content)

				arg_197_1.text_.text = var_200_25

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_26 = 36
				local var_200_27 = utf8.len(var_200_25)
				local var_200_28 = var_200_26 <= 0 and var_200_22 or var_200_22 * (var_200_27 / var_200_26)

				if var_200_28 > 0 and var_200_22 < var_200_28 then
					arg_197_1.talkMaxDuration = var_200_28

					if var_200_28 + var_200_21 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_28 + var_200_21
					end
				end

				arg_197_1.text_.text = var_200_25
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102048", "story_v_out_321102.awb") ~= 0 then
					local var_200_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102048", "story_v_out_321102.awb") / 1000

					if var_200_29 + var_200_21 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_29 + var_200_21
					end

					if var_200_24.prefab_name ~= "" and arg_197_1.actors_[var_200_24.prefab_name] ~= nil then
						local var_200_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_24.prefab_name].transform, "story_v_out_321102", "321102048", "story_v_out_321102.awb")

						arg_197_1:RecordAudio("321102048", var_200_30)
						arg_197_1:RecordAudio("321102048", var_200_30)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_321102", "321102048", "story_v_out_321102.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_321102", "321102048", "story_v_out_321102.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_31 = math.max(var_200_22, arg_197_1.talkMaxDuration)

			if var_200_21 <= arg_197_1.time_ and arg_197_1.time_ < var_200_21 + var_200_31 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_21) / var_200_31

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_21 + var_200_31 and arg_197_1.time_ < var_200_21 + var_200_31 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321102049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 321102049
		arg_201_1.duration_ = 6.43

		local var_201_0 = {
			zh = 3.7,
			ja = 6.433
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
				arg_201_0:Play321102050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = arg_201_1.actors_["1156ui_story"].transform
			local var_204_1 = 0

			if var_204_1 < arg_201_1.time_ and arg_201_1.time_ <= var_204_1 + arg_204_0 then
				arg_201_1.var_.moveOldPos1156ui_story = var_204_0.localPosition
			end

			local var_204_2 = 0.001

			if var_204_1 <= arg_201_1.time_ and arg_201_1.time_ < var_204_1 + var_204_2 then
				local var_204_3 = (arg_201_1.time_ - var_204_1) / var_204_2
				local var_204_4 = Vector3.New(-0.9, -1.1, -6.18)

				var_204_0.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1156ui_story, var_204_4, var_204_3)

				local var_204_5 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_5.x, var_204_5.y, var_204_5.z)

				local var_204_6 = var_204_0.localEulerAngles

				var_204_6.z = 0
				var_204_6.x = 0
				var_204_0.localEulerAngles = var_204_6
			end

			if arg_201_1.time_ >= var_204_1 + var_204_2 and arg_201_1.time_ < var_204_1 + var_204_2 + arg_204_0 then
				var_204_0.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_204_7 = manager.ui.mainCamera.transform.position - var_204_0.position

				var_204_0.forward = Vector3.New(var_204_7.x, var_204_7.y, var_204_7.z)

				local var_204_8 = var_204_0.localEulerAngles

				var_204_8.z = 0
				var_204_8.x = 0
				var_204_0.localEulerAngles = var_204_8
			end

			local var_204_9 = arg_201_1.actors_["1156ui_story"]
			local var_204_10 = 0

			if var_204_10 < arg_201_1.time_ and arg_201_1.time_ <= var_204_10 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect1156ui_story == nil then
				arg_201_1.var_.characterEffect1156ui_story = var_204_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_11 = 0.200000002980232

			if var_204_10 <= arg_201_1.time_ and arg_201_1.time_ < var_204_10 + var_204_11 and not isNil(var_204_9) then
				local var_204_12 = (arg_201_1.time_ - var_204_10) / var_204_11

				if arg_201_1.var_.characterEffect1156ui_story and not isNil(var_204_9) then
					arg_201_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= var_204_10 + var_204_11 and arg_201_1.time_ < var_204_10 + var_204_11 + arg_204_0 and not isNil(var_204_9) and arg_201_1.var_.characterEffect1156ui_story then
				arg_201_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_204_13 = arg_201_1.actors_["1011ui_story"]
			local var_204_14 = 0

			if var_204_14 < arg_201_1.time_ and arg_201_1.time_ <= var_204_14 + arg_204_0 and not isNil(var_204_13) and arg_201_1.var_.characterEffect1011ui_story == nil then
				arg_201_1.var_.characterEffect1011ui_story = var_204_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_15 = 0.200000002980232

			if var_204_14 <= arg_201_1.time_ and arg_201_1.time_ < var_204_14 + var_204_15 and not isNil(var_204_13) then
				local var_204_16 = (arg_201_1.time_ - var_204_14) / var_204_15

				if arg_201_1.var_.characterEffect1011ui_story and not isNil(var_204_13) then
					local var_204_17 = Mathf.Lerp(0, 0.5, var_204_16)

					arg_201_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1011ui_story.fillRatio = var_204_17
				end
			end

			if arg_201_1.time_ >= var_204_14 + var_204_15 and arg_201_1.time_ < var_204_14 + var_204_15 + arg_204_0 and not isNil(var_204_13) and arg_201_1.var_.characterEffect1011ui_story then
				local var_204_18 = 0.5

				arg_201_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1011ui_story.fillRatio = var_204_18
			end

			local var_204_19 = 0

			if var_204_19 < arg_201_1.time_ and arg_201_1.time_ <= var_204_19 + arg_204_0 then
				arg_201_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action13_1")
			end

			local var_204_20 = 0

			if var_204_20 < arg_201_1.time_ and arg_201_1.time_ <= var_204_20 + arg_204_0 then
				arg_201_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_204_21 = 0
			local var_204_22 = 0.4

			if var_204_21 < arg_201_1.time_ and arg_201_1.time_ <= var_204_21 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_23 = arg_201_1:FormatText(StoryNameCfg[605].name)

				arg_201_1.leftNameTxt_.text = var_204_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_24 = arg_201_1:GetWordFromCfg(321102049)
				local var_204_25 = arg_201_1:FormatText(var_204_24.content)

				arg_201_1.text_.text = var_204_25

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_26 = 16
				local var_204_27 = utf8.len(var_204_25)
				local var_204_28 = var_204_26 <= 0 and var_204_22 or var_204_22 * (var_204_27 / var_204_26)

				if var_204_28 > 0 and var_204_22 < var_204_28 then
					arg_201_1.talkMaxDuration = var_204_28

					if var_204_28 + var_204_21 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_28 + var_204_21
					end
				end

				arg_201_1.text_.text = var_204_25
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102049", "story_v_out_321102.awb") ~= 0 then
					local var_204_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102049", "story_v_out_321102.awb") / 1000

					if var_204_29 + var_204_21 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_29 + var_204_21
					end

					if var_204_24.prefab_name ~= "" and arg_201_1.actors_[var_204_24.prefab_name] ~= nil then
						local var_204_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_24.prefab_name].transform, "story_v_out_321102", "321102049", "story_v_out_321102.awb")

						arg_201_1:RecordAudio("321102049", var_204_30)
						arg_201_1:RecordAudio("321102049", var_204_30)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_321102", "321102049", "story_v_out_321102.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_321102", "321102049", "story_v_out_321102.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_31 = math.max(var_204_22, arg_201_1.talkMaxDuration)

			if var_204_21 <= arg_201_1.time_ and arg_201_1.time_ < var_204_21 + var_204_31 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_21) / var_204_31

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_21 + var_204_31 and arg_201_1.time_ < var_204_21 + var_204_31 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play321102050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 321102050
		arg_205_1.duration_ = 9.43

		local var_205_0 = {
			zh = 5.966,
			ja = 9.433
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play321102051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = arg_205_1.actors_["1156ui_story"].transform
			local var_208_1 = 0

			if var_208_1 < arg_205_1.time_ and arg_205_1.time_ <= var_208_1 + arg_208_0 then
				arg_205_1.var_.moveOldPos1156ui_story = var_208_0.localPosition
			end

			local var_208_2 = 0.001

			if var_208_1 <= arg_205_1.time_ and arg_205_1.time_ < var_208_1 + var_208_2 then
				local var_208_3 = (arg_205_1.time_ - var_208_1) / var_208_2
				local var_208_4 = Vector3.New(-0.9, -1.1, -6.18)

				var_208_0.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1156ui_story, var_208_4, var_208_3)

				local var_208_5 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_5.x, var_208_5.y, var_208_5.z)

				local var_208_6 = var_208_0.localEulerAngles

				var_208_6.z = 0
				var_208_6.x = 0
				var_208_0.localEulerAngles = var_208_6
			end

			if arg_205_1.time_ >= var_208_1 + var_208_2 and arg_205_1.time_ < var_208_1 + var_208_2 + arg_208_0 then
				var_208_0.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_208_7 = manager.ui.mainCamera.transform.position - var_208_0.position

				var_208_0.forward = Vector3.New(var_208_7.x, var_208_7.y, var_208_7.z)

				local var_208_8 = var_208_0.localEulerAngles

				var_208_8.z = 0
				var_208_8.x = 0
				var_208_0.localEulerAngles = var_208_8
			end

			local var_208_9 = 0

			if var_208_9 < arg_205_1.time_ and arg_205_1.time_ <= var_208_9 + arg_208_0 then
				arg_205_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_208_10 = 0
			local var_208_11 = 0.8

			if var_208_10 < arg_205_1.time_ and arg_205_1.time_ <= var_208_10 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_12 = arg_205_1:FormatText(StoryNameCfg[605].name)

				arg_205_1.leftNameTxt_.text = var_208_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_13 = arg_205_1:GetWordFromCfg(321102050)
				local var_208_14 = arg_205_1:FormatText(var_208_13.content)

				arg_205_1.text_.text = var_208_14

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_15 = 32
				local var_208_16 = utf8.len(var_208_14)
				local var_208_17 = var_208_15 <= 0 and var_208_11 or var_208_11 * (var_208_16 / var_208_15)

				if var_208_17 > 0 and var_208_11 < var_208_17 then
					arg_205_1.talkMaxDuration = var_208_17

					if var_208_17 + var_208_10 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_17 + var_208_10
					end
				end

				arg_205_1.text_.text = var_208_14
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102050", "story_v_out_321102.awb") ~= 0 then
					local var_208_18 = manager.audio:GetVoiceLength("story_v_out_321102", "321102050", "story_v_out_321102.awb") / 1000

					if var_208_18 + var_208_10 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_18 + var_208_10
					end

					if var_208_13.prefab_name ~= "" and arg_205_1.actors_[var_208_13.prefab_name] ~= nil then
						local var_208_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_13.prefab_name].transform, "story_v_out_321102", "321102050", "story_v_out_321102.awb")

						arg_205_1:RecordAudio("321102050", var_208_19)
						arg_205_1:RecordAudio("321102050", var_208_19)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_321102", "321102050", "story_v_out_321102.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_321102", "321102050", "story_v_out_321102.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_20 = math.max(var_208_11, arg_205_1.talkMaxDuration)

			if var_208_10 <= arg_205_1.time_ and arg_205_1.time_ < var_208_10 + var_208_20 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_10) / var_208_20

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_10 + var_208_20 and arg_205_1.time_ < var_208_10 + var_208_20 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play321102051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 321102051
		arg_209_1.duration_ = 4.53

		local var_209_0 = {
			zh = 4.533,
			ja = 4.4
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
				arg_209_0:Play321102052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1011ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1011ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0.7, -0.71, -6)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1011ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = arg_209_1.actors_["1011ui_story"]
			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1011ui_story == nil then
				arg_209_1.var_.characterEffect1011ui_story = var_212_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_11 = 0.200000002980232

			if var_212_10 <= arg_209_1.time_ and arg_209_1.time_ < var_212_10 + var_212_11 and not isNil(var_212_9) then
				local var_212_12 = (arg_209_1.time_ - var_212_10) / var_212_11

				if arg_209_1.var_.characterEffect1011ui_story and not isNil(var_212_9) then
					arg_209_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_10 + var_212_11 and arg_209_1.time_ < var_212_10 + var_212_11 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1011ui_story then
				arg_209_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_212_13 = arg_209_1.actors_["1156ui_story"]
			local var_212_14 = 0

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 and not isNil(var_212_13) and arg_209_1.var_.characterEffect1156ui_story == nil then
				arg_209_1.var_.characterEffect1156ui_story = var_212_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_15 = 0.200000002980232

			if var_212_14 <= arg_209_1.time_ and arg_209_1.time_ < var_212_14 + var_212_15 and not isNil(var_212_13) then
				local var_212_16 = (arg_209_1.time_ - var_212_14) / var_212_15

				if arg_209_1.var_.characterEffect1156ui_story and not isNil(var_212_13) then
					local var_212_17 = Mathf.Lerp(0, 0.5, var_212_16)

					arg_209_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1156ui_story.fillRatio = var_212_17
				end
			end

			if arg_209_1.time_ >= var_212_14 + var_212_15 and arg_209_1.time_ < var_212_14 + var_212_15 + arg_212_0 and not isNil(var_212_13) and arg_209_1.var_.characterEffect1156ui_story then
				local var_212_18 = 0.5

				arg_209_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1156ui_story.fillRatio = var_212_18
			end

			local var_212_19 = 0

			if var_212_19 < arg_209_1.time_ and arg_209_1.time_ <= var_212_19 + arg_212_0 then
				arg_209_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_2")
			end

			local var_212_20 = 0

			if var_212_20 < arg_209_1.time_ and arg_209_1.time_ <= var_212_20 + arg_212_0 then
				arg_209_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_212_21 = 0
			local var_212_22 = 0.35

			if var_212_21 < arg_209_1.time_ and arg_209_1.time_ <= var_212_21 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_23 = arg_209_1:FormatText(StoryNameCfg[37].name)

				arg_209_1.leftNameTxt_.text = var_212_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_24 = arg_209_1:GetWordFromCfg(321102051)
				local var_212_25 = arg_209_1:FormatText(var_212_24.content)

				arg_209_1.text_.text = var_212_25

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_26 = 14
				local var_212_27 = utf8.len(var_212_25)
				local var_212_28 = var_212_26 <= 0 and var_212_22 or var_212_22 * (var_212_27 / var_212_26)

				if var_212_28 > 0 and var_212_22 < var_212_28 then
					arg_209_1.talkMaxDuration = var_212_28

					if var_212_28 + var_212_21 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_28 + var_212_21
					end
				end

				arg_209_1.text_.text = var_212_25
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102051", "story_v_out_321102.awb") ~= 0 then
					local var_212_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102051", "story_v_out_321102.awb") / 1000

					if var_212_29 + var_212_21 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_29 + var_212_21
					end

					if var_212_24.prefab_name ~= "" and arg_209_1.actors_[var_212_24.prefab_name] ~= nil then
						local var_212_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_24.prefab_name].transform, "story_v_out_321102", "321102051", "story_v_out_321102.awb")

						arg_209_1:RecordAudio("321102051", var_212_30)
						arg_209_1:RecordAudio("321102051", var_212_30)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_321102", "321102051", "story_v_out_321102.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_321102", "321102051", "story_v_out_321102.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_31 = math.max(var_212_22, arg_209_1.talkMaxDuration)

			if var_212_21 <= arg_209_1.time_ and arg_209_1.time_ < var_212_21 + var_212_31 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_21) / var_212_31

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_21 + var_212_31 and arg_209_1.time_ < var_212_21 + var_212_31 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321102052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 321102052
		arg_213_1.duration_ = 2

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play321102053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["1156ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos1156ui_story = var_216_0.localPosition
			end

			local var_216_2 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2
				local var_216_4 = Vector3.New(-0.9, -1.1, -6.18)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1156ui_story, var_216_4, var_216_3)

				local var_216_5 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_5.x, var_216_5.y, var_216_5.z)

				local var_216_6 = var_216_0.localEulerAngles

				var_216_6.z = 0
				var_216_6.x = 0
				var_216_0.localEulerAngles = var_216_6
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_216_7 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_7.x, var_216_7.y, var_216_7.z)

				local var_216_8 = var_216_0.localEulerAngles

				var_216_8.z = 0
				var_216_8.x = 0
				var_216_0.localEulerAngles = var_216_8
			end

			local var_216_9 = arg_213_1.actors_["1156ui_story"]
			local var_216_10 = 0

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1156ui_story == nil then
				arg_213_1.var_.characterEffect1156ui_story = var_216_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_11 = 0.200000002980232

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_11 and not isNil(var_216_9) then
				local var_216_12 = (arg_213_1.time_ - var_216_10) / var_216_11

				if arg_213_1.var_.characterEffect1156ui_story and not isNil(var_216_9) then
					arg_213_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= var_216_10 + var_216_11 and arg_213_1.time_ < var_216_10 + var_216_11 + arg_216_0 and not isNil(var_216_9) and arg_213_1.var_.characterEffect1156ui_story then
				arg_213_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_216_13 = arg_213_1.actors_["1011ui_story"]
			local var_216_14 = 0

			if var_216_14 < arg_213_1.time_ and arg_213_1.time_ <= var_216_14 + arg_216_0 and not isNil(var_216_13) and arg_213_1.var_.characterEffect1011ui_story == nil then
				arg_213_1.var_.characterEffect1011ui_story = var_216_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_15 = 0.200000002980232

			if var_216_14 <= arg_213_1.time_ and arg_213_1.time_ < var_216_14 + var_216_15 and not isNil(var_216_13) then
				local var_216_16 = (arg_213_1.time_ - var_216_14) / var_216_15

				if arg_213_1.var_.characterEffect1011ui_story and not isNil(var_216_13) then
					local var_216_17 = Mathf.Lerp(0, 0.5, var_216_16)

					arg_213_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1011ui_story.fillRatio = var_216_17
				end
			end

			if arg_213_1.time_ >= var_216_14 + var_216_15 and arg_213_1.time_ < var_216_14 + var_216_15 + arg_216_0 and not isNil(var_216_13) and arg_213_1.var_.characterEffect1011ui_story then
				local var_216_18 = 0.5

				arg_213_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1011ui_story.fillRatio = var_216_18
			end

			local var_216_19 = 0

			if var_216_19 < arg_213_1.time_ and arg_213_1.time_ <= var_216_19 + arg_216_0 then
				arg_213_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action13_2")
			end

			local var_216_20 = 0
			local var_216_21 = 0.125

			if var_216_20 < arg_213_1.time_ and arg_213_1.time_ <= var_216_20 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				local var_216_22 = arg_213_1:FormatText(StoryNameCfg[605].name)

				arg_213_1.leftNameTxt_.text = var_216_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_23 = arg_213_1:GetWordFromCfg(321102052)
				local var_216_24 = arg_213_1:FormatText(var_216_23.content)

				arg_213_1.text_.text = var_216_24

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_25 = 5
				local var_216_26 = utf8.len(var_216_24)
				local var_216_27 = var_216_25 <= 0 and var_216_21 or var_216_21 * (var_216_26 / var_216_25)

				if var_216_27 > 0 and var_216_21 < var_216_27 then
					arg_213_1.talkMaxDuration = var_216_27

					if var_216_27 + var_216_20 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_27 + var_216_20
					end
				end

				arg_213_1.text_.text = var_216_24
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102052", "story_v_out_321102.awb") ~= 0 then
					local var_216_28 = manager.audio:GetVoiceLength("story_v_out_321102", "321102052", "story_v_out_321102.awb") / 1000

					if var_216_28 + var_216_20 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_28 + var_216_20
					end

					if var_216_23.prefab_name ~= "" and arg_213_1.actors_[var_216_23.prefab_name] ~= nil then
						local var_216_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_23.prefab_name].transform, "story_v_out_321102", "321102052", "story_v_out_321102.awb")

						arg_213_1:RecordAudio("321102052", var_216_29)
						arg_213_1:RecordAudio("321102052", var_216_29)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_321102", "321102052", "story_v_out_321102.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_321102", "321102052", "story_v_out_321102.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_30 = math.max(var_216_21, arg_213_1.talkMaxDuration)

			if var_216_20 <= arg_213_1.time_ and arg_213_1.time_ < var_216_20 + var_216_30 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_20) / var_216_30

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_20 + var_216_30 and arg_213_1.time_ < var_216_20 + var_216_30 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play321102053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 321102053
		arg_217_1.duration_ = 5.93

		local var_217_0 = {
			zh = 5.4,
			ja = 5.933
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
				arg_217_0:Play321102054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1011ui_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos1011ui_story = var_220_0.localPosition
			end

			local var_220_2 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_2 then
				local var_220_3 = (arg_217_1.time_ - var_220_1) / var_220_2
				local var_220_4 = Vector3.New(0.7, -0.71, -6)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1011ui_story, var_220_4, var_220_3)

				local var_220_5 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_5.x, var_220_5.y, var_220_5.z)

				local var_220_6 = var_220_0.localEulerAngles

				var_220_6.z = 0
				var_220_6.x = 0
				var_220_0.localEulerAngles = var_220_6
			end

			if arg_217_1.time_ >= var_220_1 + var_220_2 and arg_217_1.time_ < var_220_1 + var_220_2 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_220_7 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_7.x, var_220_7.y, var_220_7.z)

				local var_220_8 = var_220_0.localEulerAngles

				var_220_8.z = 0
				var_220_8.x = 0
				var_220_0.localEulerAngles = var_220_8
			end

			local var_220_9 = arg_217_1.actors_["1011ui_story"]
			local var_220_10 = 0

			if var_220_10 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect1011ui_story == nil then
				arg_217_1.var_.characterEffect1011ui_story = var_220_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_11 = 0.200000002980232

			if var_220_10 <= arg_217_1.time_ and arg_217_1.time_ < var_220_10 + var_220_11 and not isNil(var_220_9) then
				local var_220_12 = (arg_217_1.time_ - var_220_10) / var_220_11

				if arg_217_1.var_.characterEffect1011ui_story and not isNil(var_220_9) then
					arg_217_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_10 + var_220_11 and arg_217_1.time_ < var_220_10 + var_220_11 + arg_220_0 and not isNil(var_220_9) and arg_217_1.var_.characterEffect1011ui_story then
				arg_217_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_220_13 = arg_217_1.actors_["1156ui_story"]
			local var_220_14 = 0

			if var_220_14 < arg_217_1.time_ and arg_217_1.time_ <= var_220_14 + arg_220_0 and not isNil(var_220_13) and arg_217_1.var_.characterEffect1156ui_story == nil then
				arg_217_1.var_.characterEffect1156ui_story = var_220_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_15 = 0.200000002980232

			if var_220_14 <= arg_217_1.time_ and arg_217_1.time_ < var_220_14 + var_220_15 and not isNil(var_220_13) then
				local var_220_16 = (arg_217_1.time_ - var_220_14) / var_220_15

				if arg_217_1.var_.characterEffect1156ui_story and not isNil(var_220_13) then
					local var_220_17 = Mathf.Lerp(0, 0.5, var_220_16)

					arg_217_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1156ui_story.fillRatio = var_220_17
				end
			end

			if arg_217_1.time_ >= var_220_14 + var_220_15 and arg_217_1.time_ < var_220_14 + var_220_15 + arg_220_0 and not isNil(var_220_13) and arg_217_1.var_.characterEffect1156ui_story then
				local var_220_18 = 0.5

				arg_217_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1156ui_story.fillRatio = var_220_18
			end

			local var_220_19 = 0

			if var_220_19 < arg_217_1.time_ and arg_217_1.time_ <= var_220_19 + arg_220_0 then
				arg_217_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_220_20 = 0
			local var_220_21 = 0.55

			if var_220_20 < arg_217_1.time_ and arg_217_1.time_ <= var_220_20 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_22 = arg_217_1:FormatText(StoryNameCfg[37].name)

				arg_217_1.leftNameTxt_.text = var_220_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_23 = arg_217_1:GetWordFromCfg(321102053)
				local var_220_24 = arg_217_1:FormatText(var_220_23.content)

				arg_217_1.text_.text = var_220_24

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_25 = 22
				local var_220_26 = utf8.len(var_220_24)
				local var_220_27 = var_220_25 <= 0 and var_220_21 or var_220_21 * (var_220_26 / var_220_25)

				if var_220_27 > 0 and var_220_21 < var_220_27 then
					arg_217_1.talkMaxDuration = var_220_27

					if var_220_27 + var_220_20 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_27 + var_220_20
					end
				end

				arg_217_1.text_.text = var_220_24
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102053", "story_v_out_321102.awb") ~= 0 then
					local var_220_28 = manager.audio:GetVoiceLength("story_v_out_321102", "321102053", "story_v_out_321102.awb") / 1000

					if var_220_28 + var_220_20 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_28 + var_220_20
					end

					if var_220_23.prefab_name ~= "" and arg_217_1.actors_[var_220_23.prefab_name] ~= nil then
						local var_220_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_23.prefab_name].transform, "story_v_out_321102", "321102053", "story_v_out_321102.awb")

						arg_217_1:RecordAudio("321102053", var_220_29)
						arg_217_1:RecordAudio("321102053", var_220_29)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_321102", "321102053", "story_v_out_321102.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_321102", "321102053", "story_v_out_321102.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_30 = math.max(var_220_21, arg_217_1.talkMaxDuration)

			if var_220_20 <= arg_217_1.time_ and arg_217_1.time_ < var_220_20 + var_220_30 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_20) / var_220_30

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_20 + var_220_30 and arg_217_1.time_ < var_220_20 + var_220_30 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play321102054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 321102054
		arg_221_1.duration_ = 10.07

		local var_221_0 = {
			zh = 7.63199999815226,
			ja = 10.0659999981523
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play321102055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = "L01h"

			if arg_221_1.bgs_[var_224_0] == nil then
				local var_224_1 = Object.Instantiate(arg_221_1.paintGo_)

				var_224_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_224_0)
				var_224_1.name = var_224_0
				var_224_1.transform.parent = arg_221_1.stage_.transform
				var_224_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_221_1.bgs_[var_224_0] = var_224_1
			end

			local var_224_2 = 1.96599999815226

			if var_224_2 < arg_221_1.time_ and arg_221_1.time_ <= var_224_2 + arg_224_0 then
				local var_224_3 = manager.ui.mainCamera.transform.localPosition
				local var_224_4 = Vector3.New(0, 0, 10) + Vector3.New(var_224_3.x, var_224_3.y, 0)
				local var_224_5 = arg_221_1.bgs_.L01h

				var_224_5.transform.localPosition = var_224_4
				var_224_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_224_6 = var_224_5:GetComponent("SpriteRenderer")

				if var_224_6 and var_224_6.sprite then
					local var_224_7 = (var_224_5.transform.localPosition - var_224_3).z
					local var_224_8 = manager.ui.mainCameraCom_
					local var_224_9 = 2 * var_224_7 * Mathf.Tan(var_224_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_224_10 = var_224_9 * var_224_8.aspect
					local var_224_11 = var_224_6.sprite.bounds.size.x
					local var_224_12 = var_224_6.sprite.bounds.size.y
					local var_224_13 = var_224_10 / var_224_11
					local var_224_14 = var_224_9 / var_224_12
					local var_224_15 = var_224_14 < var_224_13 and var_224_13 or var_224_14

					var_224_5.transform.localScale = Vector3.New(var_224_15, var_224_15, 0)
				end

				for iter_224_0, iter_224_1 in pairs(arg_221_1.bgs_) do
					if iter_224_0 ~= "L01h" then
						iter_224_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_224_16 = 4

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 then
				arg_221_1.allBtn_.enabled = false
			end

			local var_224_17 = 0.3

			if arg_221_1.time_ >= var_224_16 + var_224_17 and arg_221_1.time_ < var_224_16 + var_224_17 + arg_224_0 then
				arg_221_1.allBtn_.enabled = true
			end

			local var_224_18 = 0

			if var_224_18 < arg_221_1.time_ and arg_221_1.time_ <= var_224_18 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_19 = 2

			if var_224_18 <= arg_221_1.time_ and arg_221_1.time_ < var_224_18 + var_224_19 then
				local var_224_20 = (arg_221_1.time_ - var_224_18) / var_224_19
				local var_224_21 = Color.New(0, 0, 0)

				var_224_21.a = Mathf.Lerp(0, 1, var_224_20)
				arg_221_1.mask_.color = var_224_21
			end

			if arg_221_1.time_ >= var_224_18 + var_224_19 and arg_221_1.time_ < var_224_18 + var_224_19 + arg_224_0 then
				local var_224_22 = Color.New(0, 0, 0)

				var_224_22.a = 1
				arg_221_1.mask_.color = var_224_22
			end

			local var_224_23 = 2.00000000298023

			if var_224_23 < arg_221_1.time_ and arg_221_1.time_ <= var_224_23 + arg_224_0 then
				arg_221_1.mask_.enabled = true
				arg_221_1.mask_.raycastTarget = true

				arg_221_1:SetGaussion(false)
			end

			local var_224_24 = 2

			if var_224_23 <= arg_221_1.time_ and arg_221_1.time_ < var_224_23 + var_224_24 then
				local var_224_25 = (arg_221_1.time_ - var_224_23) / var_224_24
				local var_224_26 = Color.New(0, 0, 0)

				var_224_26.a = Mathf.Lerp(1, 0, var_224_25)
				arg_221_1.mask_.color = var_224_26
			end

			if arg_221_1.time_ >= var_224_23 + var_224_24 and arg_221_1.time_ < var_224_23 + var_224_24 + arg_224_0 then
				local var_224_27 = Color.New(0, 0, 0)
				local var_224_28 = 0

				arg_221_1.mask_.enabled = false
				var_224_27.a = var_224_28
				arg_221_1.mask_.color = var_224_27
			end

			local var_224_29 = arg_221_1.actors_["1011ui_story"].transform
			local var_224_30 = 1.96599999815226

			if var_224_30 < arg_221_1.time_ and arg_221_1.time_ <= var_224_30 + arg_224_0 then
				arg_221_1.var_.moveOldPos1011ui_story = var_224_29.localPosition
			end

			local var_224_31 = 0.001

			if var_224_30 <= arg_221_1.time_ and arg_221_1.time_ < var_224_30 + var_224_31 then
				local var_224_32 = (arg_221_1.time_ - var_224_30) / var_224_31
				local var_224_33 = Vector3.New(0, 100, 0)

				var_224_29.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1011ui_story, var_224_33, var_224_32)

				local var_224_34 = manager.ui.mainCamera.transform.position - var_224_29.position

				var_224_29.forward = Vector3.New(var_224_34.x, var_224_34.y, var_224_34.z)

				local var_224_35 = var_224_29.localEulerAngles

				var_224_35.z = 0
				var_224_35.x = 0
				var_224_29.localEulerAngles = var_224_35
			end

			if arg_221_1.time_ >= var_224_30 + var_224_31 and arg_221_1.time_ < var_224_30 + var_224_31 + arg_224_0 then
				var_224_29.localPosition = Vector3.New(0, 100, 0)

				local var_224_36 = manager.ui.mainCamera.transform.position - var_224_29.position

				var_224_29.forward = Vector3.New(var_224_36.x, var_224_36.y, var_224_36.z)

				local var_224_37 = var_224_29.localEulerAngles

				var_224_37.z = 0
				var_224_37.x = 0
				var_224_29.localEulerAngles = var_224_37
			end

			local var_224_38 = arg_221_1.actors_["1156ui_story"].transform
			local var_224_39 = 1.96599999815226

			if var_224_39 < arg_221_1.time_ and arg_221_1.time_ <= var_224_39 + arg_224_0 then
				arg_221_1.var_.moveOldPos1156ui_story = var_224_38.localPosition
			end

			local var_224_40 = 0.001

			if var_224_39 <= arg_221_1.time_ and arg_221_1.time_ < var_224_39 + var_224_40 then
				local var_224_41 = (arg_221_1.time_ - var_224_39) / var_224_40
				local var_224_42 = Vector3.New(0, 100, 0)

				var_224_38.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1156ui_story, var_224_42, var_224_41)

				local var_224_43 = manager.ui.mainCamera.transform.position - var_224_38.position

				var_224_38.forward = Vector3.New(var_224_43.x, var_224_43.y, var_224_43.z)

				local var_224_44 = var_224_38.localEulerAngles

				var_224_44.z = 0
				var_224_44.x = 0
				var_224_38.localEulerAngles = var_224_44
			end

			if arg_221_1.time_ >= var_224_39 + var_224_40 and arg_221_1.time_ < var_224_39 + var_224_40 + arg_224_0 then
				var_224_38.localPosition = Vector3.New(0, 100, 0)

				local var_224_45 = manager.ui.mainCamera.transform.position - var_224_38.position

				var_224_38.forward = Vector3.New(var_224_45.x, var_224_45.y, var_224_45.z)

				local var_224_46 = var_224_38.localEulerAngles

				var_224_46.z = 0
				var_224_46.x = 0
				var_224_38.localEulerAngles = var_224_46
			end

			local var_224_47 = "10100ui_story"

			if arg_221_1.actors_[var_224_47] == nil then
				local var_224_48 = Asset.Load("Char/" .. "10100ui_story")

				if not isNil(var_224_48) then
					local var_224_49 = Object.Instantiate(Asset.Load("Char/" .. "10100ui_story"), arg_221_1.stage_.transform)

					var_224_49.name = var_224_47
					var_224_49.transform.localPosition = Vector3.New(0, 100, 0)
					arg_221_1.actors_[var_224_47] = var_224_49

					local var_224_50 = var_224_49:GetComponentInChildren(typeof(CharacterEffect))

					var_224_50.enabled = true

					local var_224_51 = GameObjectTools.GetOrAddComponent(var_224_49, typeof(DynamicBoneHelper))

					if var_224_51 then
						var_224_51:EnableDynamicBone(false)
					end

					arg_221_1:ShowWeapon(var_224_50.transform, false)

					arg_221_1.var_[var_224_47 .. "Animator"] = var_224_50.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_221_1.var_[var_224_47 .. "Animator"].applyRootMotion = true
					arg_221_1.var_[var_224_47 .. "LipSync"] = var_224_50.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_224_52 = arg_221_1.actors_["10100ui_story"].transform
			local var_224_53 = 3.8

			if var_224_53 < arg_221_1.time_ and arg_221_1.time_ <= var_224_53 + arg_224_0 then
				arg_221_1.var_.moveOldPos10100ui_story = var_224_52.localPosition
			end

			local var_224_54 = 0.001

			if var_224_53 <= arg_221_1.time_ and arg_221_1.time_ < var_224_53 + var_224_54 then
				local var_224_55 = (arg_221_1.time_ - var_224_53) / var_224_54
				local var_224_56 = Vector3.New(0.7, -1.16, -6.25)

				var_224_52.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10100ui_story, var_224_56, var_224_55)

				local var_224_57 = manager.ui.mainCamera.transform.position - var_224_52.position

				var_224_52.forward = Vector3.New(var_224_57.x, var_224_57.y, var_224_57.z)

				local var_224_58 = var_224_52.localEulerAngles

				var_224_58.z = 0
				var_224_58.x = 0
				var_224_52.localEulerAngles = var_224_58
			end

			if arg_221_1.time_ >= var_224_53 + var_224_54 and arg_221_1.time_ < var_224_53 + var_224_54 + arg_224_0 then
				var_224_52.localPosition = Vector3.New(0.7, -1.16, -6.25)

				local var_224_59 = manager.ui.mainCamera.transform.position - var_224_52.position

				var_224_52.forward = Vector3.New(var_224_59.x, var_224_59.y, var_224_59.z)

				local var_224_60 = var_224_52.localEulerAngles

				var_224_60.z = 0
				var_224_60.x = 0
				var_224_52.localEulerAngles = var_224_60
			end

			local var_224_61 = arg_221_1.actors_["10100ui_story"]
			local var_224_62 = 3.8

			if var_224_62 < arg_221_1.time_ and arg_221_1.time_ <= var_224_62 + arg_224_0 and not isNil(var_224_61) and arg_221_1.var_.characterEffect10100ui_story == nil then
				arg_221_1.var_.characterEffect10100ui_story = var_224_61:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_63 = 0.200000002980232

			if var_224_62 <= arg_221_1.time_ and arg_221_1.time_ < var_224_62 + var_224_63 and not isNil(var_224_61) then
				local var_224_64 = (arg_221_1.time_ - var_224_62) / var_224_63

				if arg_221_1.var_.characterEffect10100ui_story and not isNil(var_224_61) then
					arg_221_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_62 + var_224_63 and arg_221_1.time_ < var_224_62 + var_224_63 + arg_224_0 and not isNil(var_224_61) and arg_221_1.var_.characterEffect10100ui_story then
				arg_221_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_224_65 = 3.8

			if var_224_65 < arg_221_1.time_ and arg_221_1.time_ <= var_224_65 + arg_224_0 then
				arg_221_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_1")
			end

			local var_224_66 = 1.96599999815226
			local var_224_67 = 1

			if var_224_66 < arg_221_1.time_ and arg_221_1.time_ <= var_224_66 + arg_224_0 then
				local var_224_68 = "play"
				local var_224_69 = "effect"

				arg_221_1:AudioAction(var_224_68, var_224_69, "se_story_140", "se_story_140_amb_chaos", "")
			end

			if arg_221_1.frameCnt_ <= 1 then
				arg_221_1.dialog_:SetActive(false)
			end

			local var_224_70 = 3.96599999815226
			local var_224_71 = 0.45

			if var_224_70 < arg_221_1.time_ and arg_221_1.time_ <= var_224_70 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0

				arg_221_1.dialog_:SetActive(true)

				arg_221_1.dialogCg_.alpha = 0

				local var_224_72 = LeanTween.value(arg_221_1.dialog_, 0, 1, 0.3)

				var_224_72:setOnUpdate(LuaHelper.FloatAction(function(arg_225_0)
					arg_221_1.dialogCg_.alpha = arg_225_0
				end))
				var_224_72:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_221_1.dialog_)
					var_224_72:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_221_1.duration_ = arg_221_1.duration_ + 0.3

				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_73 = arg_221_1:FormatText(StoryNameCfg[1021].name)

				arg_221_1.leftNameTxt_.text = var_224_73

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_74 = arg_221_1:GetWordFromCfg(321102054)
				local var_224_75 = arg_221_1:FormatText(var_224_74.content)

				arg_221_1.text_.text = var_224_75

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_76 = 18
				local var_224_77 = utf8.len(var_224_75)
				local var_224_78 = var_224_76 <= 0 and var_224_71 or var_224_71 * (var_224_77 / var_224_76)

				if var_224_78 > 0 and var_224_71 < var_224_78 then
					arg_221_1.talkMaxDuration = var_224_78
					var_224_70 = var_224_70 + 0.3

					if var_224_78 + var_224_70 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_78 + var_224_70
					end
				end

				arg_221_1.text_.text = var_224_75
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102054", "story_v_out_321102.awb") ~= 0 then
					local var_224_79 = manager.audio:GetVoiceLength("story_v_out_321102", "321102054", "story_v_out_321102.awb") / 1000

					if var_224_79 + var_224_70 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_79 + var_224_70
					end

					if var_224_74.prefab_name ~= "" and arg_221_1.actors_[var_224_74.prefab_name] ~= nil then
						local var_224_80 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_74.prefab_name].transform, "story_v_out_321102", "321102054", "story_v_out_321102.awb")

						arg_221_1:RecordAudio("321102054", var_224_80)
						arg_221_1:RecordAudio("321102054", var_224_80)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_321102", "321102054", "story_v_out_321102.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_321102", "321102054", "story_v_out_321102.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_81 = var_224_70 + 0.3
			local var_224_82 = math.max(var_224_71, arg_221_1.talkMaxDuration)

			if var_224_81 <= arg_221_1.time_ and arg_221_1.time_ < var_224_81 + var_224_82 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_81) / var_224_82

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_81 + var_224_82 and arg_221_1.time_ < var_224_81 + var_224_82 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play321102055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 321102055
		arg_227_1.duration_ = 13.2

		local var_227_0 = {
			zh = 6.9,
			ja = 13.2
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
				arg_227_0:Play321102056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = "1089ui_story"

			if arg_227_1.actors_[var_230_0] == nil then
				local var_230_1 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_230_1) then
					local var_230_2 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_227_1.stage_.transform)

					var_230_2.name = var_230_0
					var_230_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_227_1.actors_[var_230_0] = var_230_2

					local var_230_3 = var_230_2:GetComponentInChildren(typeof(CharacterEffect))

					var_230_3.enabled = true

					local var_230_4 = GameObjectTools.GetOrAddComponent(var_230_2, typeof(DynamicBoneHelper))

					if var_230_4 then
						var_230_4:EnableDynamicBone(false)
					end

					arg_227_1:ShowWeapon(var_230_3.transform, false)

					arg_227_1.var_[var_230_0 .. "Animator"] = var_230_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_227_1.var_[var_230_0 .. "Animator"].applyRootMotion = true
					arg_227_1.var_[var_230_0 .. "LipSync"] = var_230_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_230_5 = arg_227_1.actors_["1089ui_story"].transform
			local var_230_6 = 0

			if var_230_6 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.var_.moveOldPos1089ui_story = var_230_5.localPosition
			end

			local var_230_7 = 0.001

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_7 then
				local var_230_8 = (arg_227_1.time_ - var_230_6) / var_230_7
				local var_230_9 = Vector3.New(-0.7, -1.1, -6.17)

				var_230_5.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos1089ui_story, var_230_9, var_230_8)

				local var_230_10 = manager.ui.mainCamera.transform.position - var_230_5.position

				var_230_5.forward = Vector3.New(var_230_10.x, var_230_10.y, var_230_10.z)

				local var_230_11 = var_230_5.localEulerAngles

				var_230_11.z = 0
				var_230_11.x = 0
				var_230_5.localEulerAngles = var_230_11
			end

			if arg_227_1.time_ >= var_230_6 + var_230_7 and arg_227_1.time_ < var_230_6 + var_230_7 + arg_230_0 then
				var_230_5.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_230_12 = manager.ui.mainCamera.transform.position - var_230_5.position

				var_230_5.forward = Vector3.New(var_230_12.x, var_230_12.y, var_230_12.z)

				local var_230_13 = var_230_5.localEulerAngles

				var_230_13.z = 0
				var_230_13.x = 0
				var_230_5.localEulerAngles = var_230_13
			end

			local var_230_14 = arg_227_1.actors_["1089ui_story"]
			local var_230_15 = 0

			if var_230_15 < arg_227_1.time_ and arg_227_1.time_ <= var_230_15 + arg_230_0 and not isNil(var_230_14) and arg_227_1.var_.characterEffect1089ui_story == nil then
				arg_227_1.var_.characterEffect1089ui_story = var_230_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_16 = 0.200000002980232

			if var_230_15 <= arg_227_1.time_ and arg_227_1.time_ < var_230_15 + var_230_16 and not isNil(var_230_14) then
				local var_230_17 = (arg_227_1.time_ - var_230_15) / var_230_16

				if arg_227_1.var_.characterEffect1089ui_story and not isNil(var_230_14) then
					arg_227_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_15 + var_230_16 and arg_227_1.time_ < var_230_15 + var_230_16 + arg_230_0 and not isNil(var_230_14) and arg_227_1.var_.characterEffect1089ui_story then
				arg_227_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_230_18 = arg_227_1.actors_["10100ui_story"]
			local var_230_19 = 0

			if var_230_19 < arg_227_1.time_ and arg_227_1.time_ <= var_230_19 + arg_230_0 and not isNil(var_230_18) and arg_227_1.var_.characterEffect10100ui_story == nil then
				arg_227_1.var_.characterEffect10100ui_story = var_230_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_20 = 0.200000002980232

			if var_230_19 <= arg_227_1.time_ and arg_227_1.time_ < var_230_19 + var_230_20 and not isNil(var_230_18) then
				local var_230_21 = (arg_227_1.time_ - var_230_19) / var_230_20

				if arg_227_1.var_.characterEffect10100ui_story and not isNil(var_230_18) then
					local var_230_22 = Mathf.Lerp(0, 0.5, var_230_21)

					arg_227_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_227_1.var_.characterEffect10100ui_story.fillRatio = var_230_22
				end
			end

			if arg_227_1.time_ >= var_230_19 + var_230_20 and arg_227_1.time_ < var_230_19 + var_230_20 + arg_230_0 and not isNil(var_230_18) and arg_227_1.var_.characterEffect10100ui_story then
				local var_230_23 = 0.5

				arg_227_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_227_1.var_.characterEffect10100ui_story.fillRatio = var_230_23
			end

			local var_230_24 = 0

			if var_230_24 < arg_227_1.time_ and arg_227_1.time_ <= var_230_24 + arg_230_0 then
				arg_227_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_230_25 = 0

			if var_230_25 < arg_227_1.time_ and arg_227_1.time_ <= var_230_25 + arg_230_0 then
				arg_227_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_230_26 = 0
			local var_230_27 = 0.725

			if var_230_26 < arg_227_1.time_ and arg_227_1.time_ <= var_230_26 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_28 = arg_227_1:FormatText(StoryNameCfg[1031].name)

				arg_227_1.leftNameTxt_.text = var_230_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_29 = arg_227_1:GetWordFromCfg(321102055)
				local var_230_30 = arg_227_1:FormatText(var_230_29.content)

				arg_227_1.text_.text = var_230_30

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_31 = 29
				local var_230_32 = utf8.len(var_230_30)
				local var_230_33 = var_230_31 <= 0 and var_230_27 or var_230_27 * (var_230_32 / var_230_31)

				if var_230_33 > 0 and var_230_27 < var_230_33 then
					arg_227_1.talkMaxDuration = var_230_33

					if var_230_33 + var_230_26 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_33 + var_230_26
					end
				end

				arg_227_1.text_.text = var_230_30
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102055", "story_v_out_321102.awb") ~= 0 then
					local var_230_34 = manager.audio:GetVoiceLength("story_v_out_321102", "321102055", "story_v_out_321102.awb") / 1000

					if var_230_34 + var_230_26 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_34 + var_230_26
					end

					if var_230_29.prefab_name ~= "" and arg_227_1.actors_[var_230_29.prefab_name] ~= nil then
						local var_230_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_29.prefab_name].transform, "story_v_out_321102", "321102055", "story_v_out_321102.awb")

						arg_227_1:RecordAudio("321102055", var_230_35)
						arg_227_1:RecordAudio("321102055", var_230_35)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_321102", "321102055", "story_v_out_321102.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_321102", "321102055", "story_v_out_321102.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_36 = math.max(var_230_27, arg_227_1.talkMaxDuration)

			if var_230_26 <= arg_227_1.time_ and arg_227_1.time_ < var_230_26 + var_230_36 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_26) / var_230_36

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_26 + var_230_36 and arg_227_1.time_ < var_230_26 + var_230_36 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
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
	Play321102056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 321102056
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play321102057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["1089ui_story"].transform
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.var_.moveOldPos1089ui_story = var_234_0.localPosition
			end

			local var_234_2 = 0.001

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2
				local var_234_4 = Vector3.New(0, 100, 0)

				var_234_0.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos1089ui_story, var_234_4, var_234_3)

				local var_234_5 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_5.x, var_234_5.y, var_234_5.z)

				local var_234_6 = var_234_0.localEulerAngles

				var_234_6.z = 0
				var_234_6.x = 0
				var_234_0.localEulerAngles = var_234_6
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 then
				var_234_0.localPosition = Vector3.New(0, 100, 0)

				local var_234_7 = manager.ui.mainCamera.transform.position - var_234_0.position

				var_234_0.forward = Vector3.New(var_234_7.x, var_234_7.y, var_234_7.z)

				local var_234_8 = var_234_0.localEulerAngles

				var_234_8.z = 0
				var_234_8.x = 0
				var_234_0.localEulerAngles = var_234_8
			end

			local var_234_9 = arg_231_1.actors_["10100ui_story"].transform
			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1.var_.moveOldPos10100ui_story = var_234_9.localPosition
			end

			local var_234_11 = 0.001

			if var_234_10 <= arg_231_1.time_ and arg_231_1.time_ < var_234_10 + var_234_11 then
				local var_234_12 = (arg_231_1.time_ - var_234_10) / var_234_11
				local var_234_13 = Vector3.New(0, 100, 0)

				var_234_9.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos10100ui_story, var_234_13, var_234_12)

				local var_234_14 = manager.ui.mainCamera.transform.position - var_234_9.position

				var_234_9.forward = Vector3.New(var_234_14.x, var_234_14.y, var_234_14.z)

				local var_234_15 = var_234_9.localEulerAngles

				var_234_15.z = 0
				var_234_15.x = 0
				var_234_9.localEulerAngles = var_234_15
			end

			if arg_231_1.time_ >= var_234_10 + var_234_11 and arg_231_1.time_ < var_234_10 + var_234_11 + arg_234_0 then
				var_234_9.localPosition = Vector3.New(0, 100, 0)

				local var_234_16 = manager.ui.mainCamera.transform.position - var_234_9.position

				var_234_9.forward = Vector3.New(var_234_16.x, var_234_16.y, var_234_16.z)

				local var_234_17 = var_234_9.localEulerAngles

				var_234_17.z = 0
				var_234_17.x = 0
				var_234_9.localEulerAngles = var_234_17
			end

			local var_234_18 = arg_231_1.actors_["1089ui_story"]
			local var_234_19 = 0

			if var_234_19 < arg_231_1.time_ and arg_231_1.time_ <= var_234_19 + arg_234_0 and not isNil(var_234_18) and arg_231_1.var_.characterEffect1089ui_story == nil then
				arg_231_1.var_.characterEffect1089ui_story = var_234_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_20 = 0.200000002980232

			if var_234_19 <= arg_231_1.time_ and arg_231_1.time_ < var_234_19 + var_234_20 and not isNil(var_234_18) then
				local var_234_21 = (arg_231_1.time_ - var_234_19) / var_234_20

				if arg_231_1.var_.characterEffect1089ui_story and not isNil(var_234_18) then
					local var_234_22 = Mathf.Lerp(0, 0.5, var_234_21)

					arg_231_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1089ui_story.fillRatio = var_234_22
				end
			end

			if arg_231_1.time_ >= var_234_19 + var_234_20 and arg_231_1.time_ < var_234_19 + var_234_20 + arg_234_0 and not isNil(var_234_18) and arg_231_1.var_.characterEffect1089ui_story then
				local var_234_23 = 0.5

				arg_231_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1089ui_story.fillRatio = var_234_23
			end

			local var_234_24 = 0
			local var_234_25 = 0.975

			if var_234_24 < arg_231_1.time_ and arg_231_1.time_ <= var_234_24 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_26 = arg_231_1:GetWordFromCfg(321102056)
				local var_234_27 = arg_231_1:FormatText(var_234_26.content)

				arg_231_1.text_.text = var_234_27

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_28 = 39
				local var_234_29 = utf8.len(var_234_27)
				local var_234_30 = var_234_28 <= 0 and var_234_25 or var_234_25 * (var_234_29 / var_234_28)

				if var_234_30 > 0 and var_234_25 < var_234_30 then
					arg_231_1.talkMaxDuration = var_234_30

					if var_234_30 + var_234_24 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_30 + var_234_24
					end
				end

				arg_231_1.text_.text = var_234_27
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_31 = math.max(var_234_25, arg_231_1.talkMaxDuration)

			if var_234_24 <= arg_231_1.time_ and arg_231_1.time_ < var_234_24 + var_234_31 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_24) / var_234_31

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_24 + var_234_31 and arg_231_1.time_ < var_234_24 + var_234_31 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play321102057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 321102057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play321102058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0
			local var_238_1 = 1.225

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, false)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_2 = arg_235_1:GetWordFromCfg(321102057)
				local var_238_3 = arg_235_1:FormatText(var_238_2.content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_4 = 49
				local var_238_5 = utf8.len(var_238_3)
				local var_238_6 = var_238_4 <= 0 and var_238_1 or var_238_1 * (var_238_5 / var_238_4)

				if var_238_6 > 0 and var_238_1 < var_238_6 then
					arg_235_1.talkMaxDuration = var_238_6

					if var_238_6 + var_238_0 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_6 + var_238_0
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_7 = math.max(var_238_1, arg_235_1.talkMaxDuration)

			if var_238_0 <= arg_235_1.time_ and arg_235_1.time_ < var_238_0 + var_238_7 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_0) / var_238_7

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_0 + var_238_7 and arg_235_1.time_ < var_238_0 + var_238_7 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play321102058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 321102058
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play321102059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 1.25

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_2 = arg_239_1:GetWordFromCfg(321102058)
				local var_242_3 = arg_239_1:FormatText(var_242_2.content)

				arg_239_1.text_.text = var_242_3

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 50
				local var_242_5 = utf8.len(var_242_3)
				local var_242_6 = var_242_4 <= 0 and var_242_1 or var_242_1 * (var_242_5 / var_242_4)

				if var_242_6 > 0 and var_242_1 < var_242_6 then
					arg_239_1.talkMaxDuration = var_242_6

					if var_242_6 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_3
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_7 and arg_239_1.time_ < var_242_0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play321102059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 321102059
		arg_243_1.duration_ = 12.37

		local var_243_0 = {
			zh = 7.866,
			ja = 12.366
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play321102060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1089ui_story"].transform
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.var_.moveOldPos1089ui_story = var_246_0.localPosition
			end

			local var_246_2 = 0.001

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2
				local var_246_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_246_0.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos1089ui_story, var_246_4, var_246_3)

				local var_246_5 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_5.x, var_246_5.y, var_246_5.z)

				local var_246_6 = var_246_0.localEulerAngles

				var_246_6.z = 0
				var_246_6.x = 0
				var_246_0.localEulerAngles = var_246_6
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 then
				var_246_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_246_7 = manager.ui.mainCamera.transform.position - var_246_0.position

				var_246_0.forward = Vector3.New(var_246_7.x, var_246_7.y, var_246_7.z)

				local var_246_8 = var_246_0.localEulerAngles

				var_246_8.z = 0
				var_246_8.x = 0
				var_246_0.localEulerAngles = var_246_8
			end

			local var_246_9 = arg_243_1.actors_["1089ui_story"]
			local var_246_10 = 0

			if var_246_10 < arg_243_1.time_ and arg_243_1.time_ <= var_246_10 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1089ui_story == nil then
				arg_243_1.var_.characterEffect1089ui_story = var_246_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_11 = 0.200000002980232

			if var_246_10 <= arg_243_1.time_ and arg_243_1.time_ < var_246_10 + var_246_11 and not isNil(var_246_9) then
				local var_246_12 = (arg_243_1.time_ - var_246_10) / var_246_11

				if arg_243_1.var_.characterEffect1089ui_story and not isNil(var_246_9) then
					arg_243_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= var_246_10 + var_246_11 and arg_243_1.time_ < var_246_10 + var_246_11 + arg_246_0 and not isNil(var_246_9) and arg_243_1.var_.characterEffect1089ui_story then
				arg_243_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_246_13 = 0

			if var_246_13 < arg_243_1.time_ and arg_243_1.time_ <= var_246_13 + arg_246_0 then
				arg_243_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			local var_246_14 = 0

			if var_246_14 < arg_243_1.time_ and arg_243_1.time_ <= var_246_14 + arg_246_0 then
				arg_243_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_246_15 = 0
			local var_246_16 = 0.675

			if var_246_15 < arg_243_1.time_ and arg_243_1.time_ <= var_246_15 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_17 = arg_243_1:FormatText(StoryNameCfg[1031].name)

				arg_243_1.leftNameTxt_.text = var_246_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_18 = arg_243_1:GetWordFromCfg(321102059)
				local var_246_19 = arg_243_1:FormatText(var_246_18.content)

				arg_243_1.text_.text = var_246_19

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_20 = 27
				local var_246_21 = utf8.len(var_246_19)
				local var_246_22 = var_246_20 <= 0 and var_246_16 or var_246_16 * (var_246_21 / var_246_20)

				if var_246_22 > 0 and var_246_16 < var_246_22 then
					arg_243_1.talkMaxDuration = var_246_22

					if var_246_22 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_22 + var_246_15
					end
				end

				arg_243_1.text_.text = var_246_19
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102059", "story_v_out_321102.awb") ~= 0 then
					local var_246_23 = manager.audio:GetVoiceLength("story_v_out_321102", "321102059", "story_v_out_321102.awb") / 1000

					if var_246_23 + var_246_15 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_23 + var_246_15
					end

					if var_246_18.prefab_name ~= "" and arg_243_1.actors_[var_246_18.prefab_name] ~= nil then
						local var_246_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_18.prefab_name].transform, "story_v_out_321102", "321102059", "story_v_out_321102.awb")

						arg_243_1:RecordAudio("321102059", var_246_24)
						arg_243_1:RecordAudio("321102059", var_246_24)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_321102", "321102059", "story_v_out_321102.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_321102", "321102059", "story_v_out_321102.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_25 = math.max(var_246_16, arg_243_1.talkMaxDuration)

			if var_246_15 <= arg_243_1.time_ and arg_243_1.time_ < var_246_15 + var_246_25 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_15) / var_246_25

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_15 + var_246_25 and arg_243_1.time_ < var_246_15 + var_246_25 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play321102060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 321102060
		arg_247_1.duration_ = 9.07

		local var_247_0 = {
			zh = 6.7,
			ja = 9.066
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play321102061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10100ui_story"].transform
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 then
				arg_247_1.var_.moveOldPos10100ui_story = var_250_0.localPosition
			end

			local var_250_2 = 0.001

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2
				local var_250_4 = Vector3.New(0.7, -1.16, -6.25)

				var_250_0.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10100ui_story, var_250_4, var_250_3)

				local var_250_5 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_5.x, var_250_5.y, var_250_5.z)

				local var_250_6 = var_250_0.localEulerAngles

				var_250_6.z = 0
				var_250_6.x = 0
				var_250_0.localEulerAngles = var_250_6
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 then
				var_250_0.localPosition = Vector3.New(0.7, -1.16, -6.25)

				local var_250_7 = manager.ui.mainCamera.transform.position - var_250_0.position

				var_250_0.forward = Vector3.New(var_250_7.x, var_250_7.y, var_250_7.z)

				local var_250_8 = var_250_0.localEulerAngles

				var_250_8.z = 0
				var_250_8.x = 0
				var_250_0.localEulerAngles = var_250_8
			end

			local var_250_9 = arg_247_1.actors_["10100ui_story"]
			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect10100ui_story == nil then
				arg_247_1.var_.characterEffect10100ui_story = var_250_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_11 = 0.200000002980232

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_11 and not isNil(var_250_9) then
				local var_250_12 = (arg_247_1.time_ - var_250_10) / var_250_11

				if arg_247_1.var_.characterEffect10100ui_story and not isNil(var_250_9) then
					arg_247_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_10 + var_250_11 and arg_247_1.time_ < var_250_10 + var_250_11 + arg_250_0 and not isNil(var_250_9) and arg_247_1.var_.characterEffect10100ui_story then
				arg_247_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_250_13 = arg_247_1.actors_["1089ui_story"]
			local var_250_14 = 0

			if var_250_14 < arg_247_1.time_ and arg_247_1.time_ <= var_250_14 + arg_250_0 and not isNil(var_250_13) and arg_247_1.var_.characterEffect1089ui_story == nil then
				arg_247_1.var_.characterEffect1089ui_story = var_250_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_15 = 0.200000002980232

			if var_250_14 <= arg_247_1.time_ and arg_247_1.time_ < var_250_14 + var_250_15 and not isNil(var_250_13) then
				local var_250_16 = (arg_247_1.time_ - var_250_14) / var_250_15

				if arg_247_1.var_.characterEffect1089ui_story and not isNil(var_250_13) then
					local var_250_17 = Mathf.Lerp(0, 0.5, var_250_16)

					arg_247_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_247_1.var_.characterEffect1089ui_story.fillRatio = var_250_17
				end
			end

			if arg_247_1.time_ >= var_250_14 + var_250_15 and arg_247_1.time_ < var_250_14 + var_250_15 + arg_250_0 and not isNil(var_250_13) and arg_247_1.var_.characterEffect1089ui_story then
				local var_250_18 = 0.5

				arg_247_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_247_1.var_.characterEffect1089ui_story.fillRatio = var_250_18
			end

			local var_250_19 = 0

			if var_250_19 < arg_247_1.time_ and arg_247_1.time_ <= var_250_19 + arg_250_0 then
				arg_247_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action4_2")
			end

			local var_250_20 = 0

			if var_250_20 < arg_247_1.time_ and arg_247_1.time_ <= var_250_20 + arg_250_0 then
				arg_247_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_250_21 = 0
			local var_250_22 = 0.875

			if var_250_21 < arg_247_1.time_ and arg_247_1.time_ <= var_250_21 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_23 = arg_247_1:FormatText(StoryNameCfg[1021].name)

				arg_247_1.leftNameTxt_.text = var_250_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_24 = arg_247_1:GetWordFromCfg(321102060)
				local var_250_25 = arg_247_1:FormatText(var_250_24.content)

				arg_247_1.text_.text = var_250_25

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_26 = 35
				local var_250_27 = utf8.len(var_250_25)
				local var_250_28 = var_250_26 <= 0 and var_250_22 or var_250_22 * (var_250_27 / var_250_26)

				if var_250_28 > 0 and var_250_22 < var_250_28 then
					arg_247_1.talkMaxDuration = var_250_28

					if var_250_28 + var_250_21 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_28 + var_250_21
					end
				end

				arg_247_1.text_.text = var_250_25
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102060", "story_v_out_321102.awb") ~= 0 then
					local var_250_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102060", "story_v_out_321102.awb") / 1000

					if var_250_29 + var_250_21 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_29 + var_250_21
					end

					if var_250_24.prefab_name ~= "" and arg_247_1.actors_[var_250_24.prefab_name] ~= nil then
						local var_250_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_24.prefab_name].transform, "story_v_out_321102", "321102060", "story_v_out_321102.awb")

						arg_247_1:RecordAudio("321102060", var_250_30)
						arg_247_1:RecordAudio("321102060", var_250_30)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_321102", "321102060", "story_v_out_321102.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_321102", "321102060", "story_v_out_321102.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_31 = math.max(var_250_22, arg_247_1.talkMaxDuration)

			if var_250_21 <= arg_247_1.time_ and arg_247_1.time_ < var_250_21 + var_250_31 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_21) / var_250_31

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_21 + var_250_31 and arg_247_1.time_ < var_250_21 + var_250_31 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play321102061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 321102061
		arg_251_1.duration_ = 2.4

		local var_251_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play321102062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1089ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos1089ui_story = var_254_0.localPosition
			end

			local var_254_2 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2
				local var_254_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1089ui_story, var_254_4, var_254_3)

				local var_254_5 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_5.x, var_254_5.y, var_254_5.z)

				local var_254_6 = var_254_0.localEulerAngles

				var_254_6.z = 0
				var_254_6.x = 0
				var_254_0.localEulerAngles = var_254_6
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_254_7 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_7.x, var_254_7.y, var_254_7.z)

				local var_254_8 = var_254_0.localEulerAngles

				var_254_8.z = 0
				var_254_8.x = 0
				var_254_0.localEulerAngles = var_254_8
			end

			local var_254_9 = arg_251_1.actors_["1089ui_story"]
			local var_254_10 = 0

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect1089ui_story == nil then
				arg_251_1.var_.characterEffect1089ui_story = var_254_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_11 = 0.200000002980232

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_11 and not isNil(var_254_9) then
				local var_254_12 = (arg_251_1.time_ - var_254_10) / var_254_11

				if arg_251_1.var_.characterEffect1089ui_story and not isNil(var_254_9) then
					arg_251_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_10 + var_254_11 and arg_251_1.time_ < var_254_10 + var_254_11 + arg_254_0 and not isNil(var_254_9) and arg_251_1.var_.characterEffect1089ui_story then
				arg_251_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_254_13 = arg_251_1.actors_["10100ui_story"]
			local var_254_14 = 0

			if var_254_14 < arg_251_1.time_ and arg_251_1.time_ <= var_254_14 + arg_254_0 and not isNil(var_254_13) and arg_251_1.var_.characterEffect10100ui_story == nil then
				arg_251_1.var_.characterEffect10100ui_story = var_254_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_15 = 0.200000002980232

			if var_254_14 <= arg_251_1.time_ and arg_251_1.time_ < var_254_14 + var_254_15 and not isNil(var_254_13) then
				local var_254_16 = (arg_251_1.time_ - var_254_14) / var_254_15

				if arg_251_1.var_.characterEffect10100ui_story and not isNil(var_254_13) then
					local var_254_17 = Mathf.Lerp(0, 0.5, var_254_16)

					arg_251_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_251_1.var_.characterEffect10100ui_story.fillRatio = var_254_17
				end
			end

			if arg_251_1.time_ >= var_254_14 + var_254_15 and arg_251_1.time_ < var_254_14 + var_254_15 + arg_254_0 and not isNil(var_254_13) and arg_251_1.var_.characterEffect10100ui_story then
				local var_254_18 = 0.5

				arg_251_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_251_1.var_.characterEffect10100ui_story.fillRatio = var_254_18
			end

			local var_254_19 = 0

			if var_254_19 < arg_251_1.time_ and arg_251_1.time_ <= var_254_19 + arg_254_0 then
				arg_251_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_1")
			end

			local var_254_20 = 0

			if var_254_20 < arg_251_1.time_ and arg_251_1.time_ <= var_254_20 + arg_254_0 then
				arg_251_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_254_21 = 0
			local var_254_22 = 0.175

			if var_254_21 < arg_251_1.time_ and arg_251_1.time_ <= var_254_21 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_23 = arg_251_1:FormatText(StoryNameCfg[1031].name)

				arg_251_1.leftNameTxt_.text = var_254_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_24 = arg_251_1:GetWordFromCfg(321102061)
				local var_254_25 = arg_251_1:FormatText(var_254_24.content)

				arg_251_1.text_.text = var_254_25

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_26 = 7
				local var_254_27 = utf8.len(var_254_25)
				local var_254_28 = var_254_26 <= 0 and var_254_22 or var_254_22 * (var_254_27 / var_254_26)

				if var_254_28 > 0 and var_254_22 < var_254_28 then
					arg_251_1.talkMaxDuration = var_254_28

					if var_254_28 + var_254_21 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_28 + var_254_21
					end
				end

				arg_251_1.text_.text = var_254_25
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102061", "story_v_out_321102.awb") ~= 0 then
					local var_254_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102061", "story_v_out_321102.awb") / 1000

					if var_254_29 + var_254_21 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_29 + var_254_21
					end

					if var_254_24.prefab_name ~= "" and arg_251_1.actors_[var_254_24.prefab_name] ~= nil then
						local var_254_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_24.prefab_name].transform, "story_v_out_321102", "321102061", "story_v_out_321102.awb")

						arg_251_1:RecordAudio("321102061", var_254_30)
						arg_251_1:RecordAudio("321102061", var_254_30)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_321102", "321102061", "story_v_out_321102.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_321102", "321102061", "story_v_out_321102.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_31 = math.max(var_254_22, arg_251_1.talkMaxDuration)

			if var_254_21 <= arg_251_1.time_ and arg_251_1.time_ < var_254_21 + var_254_31 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_21) / var_254_31

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_21 + var_254_31 and arg_251_1.time_ < var_254_21 + var_254_31 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play321102062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 321102062
		arg_255_1.duration_ = 2

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play321102063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10100ui_story"].transform
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1.var_.moveOldPos10100ui_story = var_258_0.localPosition
			end

			local var_258_2 = 0.001

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2
				local var_258_4 = Vector3.New(0.7, -1.16, -6.25)

				var_258_0.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10100ui_story, var_258_4, var_258_3)

				local var_258_5 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_5.x, var_258_5.y, var_258_5.z)

				local var_258_6 = var_258_0.localEulerAngles

				var_258_6.z = 0
				var_258_6.x = 0
				var_258_0.localEulerAngles = var_258_6
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 then
				var_258_0.localPosition = Vector3.New(0.7, -1.16, -6.25)

				local var_258_7 = manager.ui.mainCamera.transform.position - var_258_0.position

				var_258_0.forward = Vector3.New(var_258_7.x, var_258_7.y, var_258_7.z)

				local var_258_8 = var_258_0.localEulerAngles

				var_258_8.z = 0
				var_258_8.x = 0
				var_258_0.localEulerAngles = var_258_8
			end

			local var_258_9 = arg_255_1.actors_["10100ui_story"]
			local var_258_10 = 0

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 and not isNil(var_258_9) and arg_255_1.var_.characterEffect10100ui_story == nil then
				arg_255_1.var_.characterEffect10100ui_story = var_258_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_11 = 0.200000002980232

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_11 and not isNil(var_258_9) then
				local var_258_12 = (arg_255_1.time_ - var_258_10) / var_258_11

				if arg_255_1.var_.characterEffect10100ui_story and not isNil(var_258_9) then
					arg_255_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_10 + var_258_11 and arg_255_1.time_ < var_258_10 + var_258_11 + arg_258_0 and not isNil(var_258_9) and arg_255_1.var_.characterEffect10100ui_story then
				arg_255_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_258_13 = arg_255_1.actors_["1089ui_story"]
			local var_258_14 = 0

			if var_258_14 < arg_255_1.time_ and arg_255_1.time_ <= var_258_14 + arg_258_0 and not isNil(var_258_13) and arg_255_1.var_.characterEffect1089ui_story == nil then
				arg_255_1.var_.characterEffect1089ui_story = var_258_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_15 = 0.200000002980232

			if var_258_14 <= arg_255_1.time_ and arg_255_1.time_ < var_258_14 + var_258_15 and not isNil(var_258_13) then
				local var_258_16 = (arg_255_1.time_ - var_258_14) / var_258_15

				if arg_255_1.var_.characterEffect1089ui_story and not isNil(var_258_13) then
					local var_258_17 = Mathf.Lerp(0, 0.5, var_258_16)

					arg_255_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_255_1.var_.characterEffect1089ui_story.fillRatio = var_258_17
				end
			end

			if arg_255_1.time_ >= var_258_14 + var_258_15 and arg_255_1.time_ < var_258_14 + var_258_15 + arg_258_0 and not isNil(var_258_13) and arg_255_1.var_.characterEffect1089ui_story then
				local var_258_18 = 0.5

				arg_255_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_255_1.var_.characterEffect1089ui_story.fillRatio = var_258_18
			end

			local var_258_19 = 0

			if var_258_19 < arg_255_1.time_ and arg_255_1.time_ <= var_258_19 + arg_258_0 then
				arg_255_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action3_1")
			end

			local var_258_20 = 0

			if var_258_20 < arg_255_1.time_ and arg_255_1.time_ <= var_258_20 + arg_258_0 then
				arg_255_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_258_21 = 0
			local var_258_22 = 0.175

			if var_258_21 < arg_255_1.time_ and arg_255_1.time_ <= var_258_21 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_23 = arg_255_1:FormatText(StoryNameCfg[1021].name)

				arg_255_1.leftNameTxt_.text = var_258_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_24 = arg_255_1:GetWordFromCfg(321102062)
				local var_258_25 = arg_255_1:FormatText(var_258_24.content)

				arg_255_1.text_.text = var_258_25

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_26 = 7
				local var_258_27 = utf8.len(var_258_25)
				local var_258_28 = var_258_26 <= 0 and var_258_22 or var_258_22 * (var_258_27 / var_258_26)

				if var_258_28 > 0 and var_258_22 < var_258_28 then
					arg_255_1.talkMaxDuration = var_258_28

					if var_258_28 + var_258_21 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_28 + var_258_21
					end
				end

				arg_255_1.text_.text = var_258_25
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102062", "story_v_out_321102.awb") ~= 0 then
					local var_258_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102062", "story_v_out_321102.awb") / 1000

					if var_258_29 + var_258_21 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_29 + var_258_21
					end

					if var_258_24.prefab_name ~= "" and arg_255_1.actors_[var_258_24.prefab_name] ~= nil then
						local var_258_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_24.prefab_name].transform, "story_v_out_321102", "321102062", "story_v_out_321102.awb")

						arg_255_1:RecordAudio("321102062", var_258_30)
						arg_255_1:RecordAudio("321102062", var_258_30)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_321102", "321102062", "story_v_out_321102.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_321102", "321102062", "story_v_out_321102.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_31 = math.max(var_258_22, arg_255_1.talkMaxDuration)

			if var_258_21 <= arg_255_1.time_ and arg_255_1.time_ < var_258_21 + var_258_31 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_21) / var_258_31

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_21 + var_258_31 and arg_255_1.time_ < var_258_21 + var_258_31 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play321102063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 321102063
		arg_259_1.duration_ = 20.27

		local var_259_0 = {
			zh = 12.1,
			ja = 20.266
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play321102064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["1089ui_story"].transform
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 then
				arg_259_1.var_.moveOldPos1089ui_story = var_262_0.localPosition
			end

			local var_262_2 = 0.001

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2
				local var_262_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_262_0.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos1089ui_story, var_262_4, var_262_3)

				local var_262_5 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_5.x, var_262_5.y, var_262_5.z)

				local var_262_6 = var_262_0.localEulerAngles

				var_262_6.z = 0
				var_262_6.x = 0
				var_262_0.localEulerAngles = var_262_6
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 then
				var_262_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_262_7 = manager.ui.mainCamera.transform.position - var_262_0.position

				var_262_0.forward = Vector3.New(var_262_7.x, var_262_7.y, var_262_7.z)

				local var_262_8 = var_262_0.localEulerAngles

				var_262_8.z = 0
				var_262_8.x = 0
				var_262_0.localEulerAngles = var_262_8
			end

			local var_262_9 = arg_259_1.actors_["1089ui_story"]
			local var_262_10 = 0

			if var_262_10 < arg_259_1.time_ and arg_259_1.time_ <= var_262_10 + arg_262_0 and not isNil(var_262_9) and arg_259_1.var_.characterEffect1089ui_story == nil then
				arg_259_1.var_.characterEffect1089ui_story = var_262_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_11 = 0.200000002980232

			if var_262_10 <= arg_259_1.time_ and arg_259_1.time_ < var_262_10 + var_262_11 and not isNil(var_262_9) then
				local var_262_12 = (arg_259_1.time_ - var_262_10) / var_262_11

				if arg_259_1.var_.characterEffect1089ui_story and not isNil(var_262_9) then
					arg_259_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_10 + var_262_11 and arg_259_1.time_ < var_262_10 + var_262_11 + arg_262_0 and not isNil(var_262_9) and arg_259_1.var_.characterEffect1089ui_story then
				arg_259_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_262_13 = arg_259_1.actors_["10100ui_story"]
			local var_262_14 = 0

			if var_262_14 < arg_259_1.time_ and arg_259_1.time_ <= var_262_14 + arg_262_0 and not isNil(var_262_13) and arg_259_1.var_.characterEffect10100ui_story == nil then
				arg_259_1.var_.characterEffect10100ui_story = var_262_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_15 = 0.200000002980232

			if var_262_14 <= arg_259_1.time_ and arg_259_1.time_ < var_262_14 + var_262_15 and not isNil(var_262_13) then
				local var_262_16 = (arg_259_1.time_ - var_262_14) / var_262_15

				if arg_259_1.var_.characterEffect10100ui_story and not isNil(var_262_13) then
					local var_262_17 = Mathf.Lerp(0, 0.5, var_262_16)

					arg_259_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_259_1.var_.characterEffect10100ui_story.fillRatio = var_262_17
				end
			end

			if arg_259_1.time_ >= var_262_14 + var_262_15 and arg_259_1.time_ < var_262_14 + var_262_15 + arg_262_0 and not isNil(var_262_13) and arg_259_1.var_.characterEffect10100ui_story then
				local var_262_18 = 0.5

				arg_259_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_259_1.var_.characterEffect10100ui_story.fillRatio = var_262_18
			end

			local var_262_19 = 0

			if var_262_19 < arg_259_1.time_ and arg_259_1.time_ <= var_262_19 + arg_262_0 then
				arg_259_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action7_2")
			end

			local var_262_20 = 0

			if var_262_20 < arg_259_1.time_ and arg_259_1.time_ <= var_262_20 + arg_262_0 then
				arg_259_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_262_21 = 0
			local var_262_22 = 1.3

			if var_262_21 < arg_259_1.time_ and arg_259_1.time_ <= var_262_21 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_23 = arg_259_1:FormatText(StoryNameCfg[1031].name)

				arg_259_1.leftNameTxt_.text = var_262_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_24 = arg_259_1:GetWordFromCfg(321102063)
				local var_262_25 = arg_259_1:FormatText(var_262_24.content)

				arg_259_1.text_.text = var_262_25

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_26 = 52
				local var_262_27 = utf8.len(var_262_25)
				local var_262_28 = var_262_26 <= 0 and var_262_22 or var_262_22 * (var_262_27 / var_262_26)

				if var_262_28 > 0 and var_262_22 < var_262_28 then
					arg_259_1.talkMaxDuration = var_262_28

					if var_262_28 + var_262_21 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_28 + var_262_21
					end
				end

				arg_259_1.text_.text = var_262_25
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102063", "story_v_out_321102.awb") ~= 0 then
					local var_262_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102063", "story_v_out_321102.awb") / 1000

					if var_262_29 + var_262_21 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_29 + var_262_21
					end

					if var_262_24.prefab_name ~= "" and arg_259_1.actors_[var_262_24.prefab_name] ~= nil then
						local var_262_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_24.prefab_name].transform, "story_v_out_321102", "321102063", "story_v_out_321102.awb")

						arg_259_1:RecordAudio("321102063", var_262_30)
						arg_259_1:RecordAudio("321102063", var_262_30)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_321102", "321102063", "story_v_out_321102.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_321102", "321102063", "story_v_out_321102.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_31 = math.max(var_262_22, arg_259_1.talkMaxDuration)

			if var_262_21 <= arg_259_1.time_ and arg_259_1.time_ < var_262_21 + var_262_31 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_21) / var_262_31

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_21 + var_262_31 and arg_259_1.time_ < var_262_21 + var_262_31 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play321102064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 321102064
		arg_263_1.duration_ = 10.2

		local var_263_0 = {
			zh = 5.7,
			ja = 10.2
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play321102065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 0.7

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_2 = arg_263_1:FormatText(StoryNameCfg[1031].name)

				arg_263_1.leftNameTxt_.text = var_266_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_3 = arg_263_1:GetWordFromCfg(321102064)
				local var_266_4 = arg_263_1:FormatText(var_266_3.content)

				arg_263_1.text_.text = var_266_4

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_5 = 28
				local var_266_6 = utf8.len(var_266_4)
				local var_266_7 = var_266_5 <= 0 and var_266_1 or var_266_1 * (var_266_6 / var_266_5)

				if var_266_7 > 0 and var_266_1 < var_266_7 then
					arg_263_1.talkMaxDuration = var_266_7

					if var_266_7 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_7 + var_266_0
					end
				end

				arg_263_1.text_.text = var_266_4
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102064", "story_v_out_321102.awb") ~= 0 then
					local var_266_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102064", "story_v_out_321102.awb") / 1000

					if var_266_8 + var_266_0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_8 + var_266_0
					end

					if var_266_3.prefab_name ~= "" and arg_263_1.actors_[var_266_3.prefab_name] ~= nil then
						local var_266_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_3.prefab_name].transform, "story_v_out_321102", "321102064", "story_v_out_321102.awb")

						arg_263_1:RecordAudio("321102064", var_266_9)
						arg_263_1:RecordAudio("321102064", var_266_9)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_321102", "321102064", "story_v_out_321102.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_321102", "321102064", "story_v_out_321102.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_10 = math.max(var_266_1, arg_263_1.talkMaxDuration)

			if var_266_0 <= arg_263_1.time_ and arg_263_1.time_ < var_266_0 + var_266_10 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_0) / var_266_10

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_0 + var_266_10 and arg_263_1.time_ < var_266_0 + var_266_10 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play321102065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 321102065
		arg_267_1.duration_ = 4.13

		local var_267_0 = {
			zh = 1.999999999999,
			ja = 4.133
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play321102066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["10100ui_story"].transform
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 then
				arg_267_1.var_.moveOldPos10100ui_story = var_270_0.localPosition
			end

			local var_270_2 = 0.001

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2
				local var_270_4 = Vector3.New(0.7, -1.16, -6.25)

				var_270_0.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos10100ui_story, var_270_4, var_270_3)

				local var_270_5 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_5.x, var_270_5.y, var_270_5.z)

				local var_270_6 = var_270_0.localEulerAngles

				var_270_6.z = 0
				var_270_6.x = 0
				var_270_0.localEulerAngles = var_270_6
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 then
				var_270_0.localPosition = Vector3.New(0.7, -1.16, -6.25)

				local var_270_7 = manager.ui.mainCamera.transform.position - var_270_0.position

				var_270_0.forward = Vector3.New(var_270_7.x, var_270_7.y, var_270_7.z)

				local var_270_8 = var_270_0.localEulerAngles

				var_270_8.z = 0
				var_270_8.x = 0
				var_270_0.localEulerAngles = var_270_8
			end

			local var_270_9 = arg_267_1.actors_["10100ui_story"]
			local var_270_10 = 0

			if var_270_10 < arg_267_1.time_ and arg_267_1.time_ <= var_270_10 + arg_270_0 and not isNil(var_270_9) and arg_267_1.var_.characterEffect10100ui_story == nil then
				arg_267_1.var_.characterEffect10100ui_story = var_270_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_11 = 0.200000002980232

			if var_270_10 <= arg_267_1.time_ and arg_267_1.time_ < var_270_10 + var_270_11 and not isNil(var_270_9) then
				local var_270_12 = (arg_267_1.time_ - var_270_10) / var_270_11

				if arg_267_1.var_.characterEffect10100ui_story and not isNil(var_270_9) then
					arg_267_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_10 + var_270_11 and arg_267_1.time_ < var_270_10 + var_270_11 + arg_270_0 and not isNil(var_270_9) and arg_267_1.var_.characterEffect10100ui_story then
				arg_267_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_270_13 = arg_267_1.actors_["1089ui_story"]
			local var_270_14 = 0

			if var_270_14 < arg_267_1.time_ and arg_267_1.time_ <= var_270_14 + arg_270_0 and not isNil(var_270_13) and arg_267_1.var_.characterEffect1089ui_story == nil then
				arg_267_1.var_.characterEffect1089ui_story = var_270_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_15 = 0.200000002980232

			if var_270_14 <= arg_267_1.time_ and arg_267_1.time_ < var_270_14 + var_270_15 and not isNil(var_270_13) then
				local var_270_16 = (arg_267_1.time_ - var_270_14) / var_270_15

				if arg_267_1.var_.characterEffect1089ui_story and not isNil(var_270_13) then
					local var_270_17 = Mathf.Lerp(0, 0.5, var_270_16)

					arg_267_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_267_1.var_.characterEffect1089ui_story.fillRatio = var_270_17
				end
			end

			if arg_267_1.time_ >= var_270_14 + var_270_15 and arg_267_1.time_ < var_270_14 + var_270_15 + arg_270_0 and not isNil(var_270_13) and arg_267_1.var_.characterEffect1089ui_story then
				local var_270_18 = 0.5

				arg_267_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_267_1.var_.characterEffect1089ui_story.fillRatio = var_270_18
			end

			local var_270_19 = 0

			if var_270_19 < arg_267_1.time_ and arg_267_1.time_ <= var_270_19 + arg_270_0 then
				arg_267_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action434")
			end

			local var_270_20 = 0

			if var_270_20 < arg_267_1.time_ and arg_267_1.time_ <= var_270_20 + arg_270_0 then
				arg_267_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_270_21 = 0
			local var_270_22 = 0.175

			if var_270_21 < arg_267_1.time_ and arg_267_1.time_ <= var_270_21 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_23 = arg_267_1:FormatText(StoryNameCfg[1021].name)

				arg_267_1.leftNameTxt_.text = var_270_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_24 = arg_267_1:GetWordFromCfg(321102065)
				local var_270_25 = arg_267_1:FormatText(var_270_24.content)

				arg_267_1.text_.text = var_270_25

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_26 = 7
				local var_270_27 = utf8.len(var_270_25)
				local var_270_28 = var_270_26 <= 0 and var_270_22 or var_270_22 * (var_270_27 / var_270_26)

				if var_270_28 > 0 and var_270_22 < var_270_28 then
					arg_267_1.talkMaxDuration = var_270_28

					if var_270_28 + var_270_21 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_28 + var_270_21
					end
				end

				arg_267_1.text_.text = var_270_25
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102065", "story_v_out_321102.awb") ~= 0 then
					local var_270_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102065", "story_v_out_321102.awb") / 1000

					if var_270_29 + var_270_21 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_29 + var_270_21
					end

					if var_270_24.prefab_name ~= "" and arg_267_1.actors_[var_270_24.prefab_name] ~= nil then
						local var_270_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_24.prefab_name].transform, "story_v_out_321102", "321102065", "story_v_out_321102.awb")

						arg_267_1:RecordAudio("321102065", var_270_30)
						arg_267_1:RecordAudio("321102065", var_270_30)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_321102", "321102065", "story_v_out_321102.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_321102", "321102065", "story_v_out_321102.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_31 = math.max(var_270_22, arg_267_1.talkMaxDuration)

			if var_270_21 <= arg_267_1.time_ and arg_267_1.time_ < var_270_21 + var_270_31 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_21) / var_270_31

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_21 + var_270_31 and arg_267_1.time_ < var_270_21 + var_270_31 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play321102066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 321102066
		arg_271_1.duration_ = 4.23

		local var_271_0 = {
			zh = 3.2,
			ja = 4.233
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play321102067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["1089ui_story"].transform
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 then
				arg_271_1.var_.moveOldPos1089ui_story = var_274_0.localPosition
			end

			local var_274_2 = 0.001

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2
				local var_274_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_274_0.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos1089ui_story, var_274_4, var_274_3)

				local var_274_5 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_5.x, var_274_5.y, var_274_5.z)

				local var_274_6 = var_274_0.localEulerAngles

				var_274_6.z = 0
				var_274_6.x = 0
				var_274_0.localEulerAngles = var_274_6
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 then
				var_274_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_274_7 = manager.ui.mainCamera.transform.position - var_274_0.position

				var_274_0.forward = Vector3.New(var_274_7.x, var_274_7.y, var_274_7.z)

				local var_274_8 = var_274_0.localEulerAngles

				var_274_8.z = 0
				var_274_8.x = 0
				var_274_0.localEulerAngles = var_274_8
			end

			local var_274_9 = arg_271_1.actors_["1089ui_story"]
			local var_274_10 = 0

			if var_274_10 < arg_271_1.time_ and arg_271_1.time_ <= var_274_10 + arg_274_0 and not isNil(var_274_9) and arg_271_1.var_.characterEffect1089ui_story == nil then
				arg_271_1.var_.characterEffect1089ui_story = var_274_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_11 = 0.200000002980232

			if var_274_10 <= arg_271_1.time_ and arg_271_1.time_ < var_274_10 + var_274_11 and not isNil(var_274_9) then
				local var_274_12 = (arg_271_1.time_ - var_274_10) / var_274_11

				if arg_271_1.var_.characterEffect1089ui_story and not isNil(var_274_9) then
					arg_271_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_10 + var_274_11 and arg_271_1.time_ < var_274_10 + var_274_11 + arg_274_0 and not isNil(var_274_9) and arg_271_1.var_.characterEffect1089ui_story then
				arg_271_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_274_13 = arg_271_1.actors_["10100ui_story"]
			local var_274_14 = 0

			if var_274_14 < arg_271_1.time_ and arg_271_1.time_ <= var_274_14 + arg_274_0 and not isNil(var_274_13) and arg_271_1.var_.characterEffect10100ui_story == nil then
				arg_271_1.var_.characterEffect10100ui_story = var_274_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_15 = 0.200000002980232

			if var_274_14 <= arg_271_1.time_ and arg_271_1.time_ < var_274_14 + var_274_15 and not isNil(var_274_13) then
				local var_274_16 = (arg_271_1.time_ - var_274_14) / var_274_15

				if arg_271_1.var_.characterEffect10100ui_story and not isNil(var_274_13) then
					local var_274_17 = Mathf.Lerp(0, 0.5, var_274_16)

					arg_271_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_271_1.var_.characterEffect10100ui_story.fillRatio = var_274_17
				end
			end

			if arg_271_1.time_ >= var_274_14 + var_274_15 and arg_271_1.time_ < var_274_14 + var_274_15 + arg_274_0 and not isNil(var_274_13) and arg_271_1.var_.characterEffect10100ui_story then
				local var_274_18 = 0.5

				arg_271_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_271_1.var_.characterEffect10100ui_story.fillRatio = var_274_18
			end

			local var_274_19 = 0

			if var_274_19 < arg_271_1.time_ and arg_271_1.time_ <= var_274_19 + arg_274_0 then
				arg_271_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			local var_274_20 = 0

			if var_274_20 < arg_271_1.time_ and arg_271_1.time_ <= var_274_20 + arg_274_0 then
				arg_271_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_274_21 = 0
			local var_274_22 = 0.25

			if var_274_21 < arg_271_1.time_ and arg_271_1.time_ <= var_274_21 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_23 = arg_271_1:FormatText(StoryNameCfg[1031].name)

				arg_271_1.leftNameTxt_.text = var_274_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_24 = arg_271_1:GetWordFromCfg(321102066)
				local var_274_25 = arg_271_1:FormatText(var_274_24.content)

				arg_271_1.text_.text = var_274_25

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_26 = 10
				local var_274_27 = utf8.len(var_274_25)
				local var_274_28 = var_274_26 <= 0 and var_274_22 or var_274_22 * (var_274_27 / var_274_26)

				if var_274_28 > 0 and var_274_22 < var_274_28 then
					arg_271_1.talkMaxDuration = var_274_28

					if var_274_28 + var_274_21 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_28 + var_274_21
					end
				end

				arg_271_1.text_.text = var_274_25
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102066", "story_v_out_321102.awb") ~= 0 then
					local var_274_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102066", "story_v_out_321102.awb") / 1000

					if var_274_29 + var_274_21 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_29 + var_274_21
					end

					if var_274_24.prefab_name ~= "" and arg_271_1.actors_[var_274_24.prefab_name] ~= nil then
						local var_274_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_24.prefab_name].transform, "story_v_out_321102", "321102066", "story_v_out_321102.awb")

						arg_271_1:RecordAudio("321102066", var_274_30)
						arg_271_1:RecordAudio("321102066", var_274_30)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_321102", "321102066", "story_v_out_321102.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_321102", "321102066", "story_v_out_321102.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_31 = math.max(var_274_22, arg_271_1.talkMaxDuration)

			if var_274_21 <= arg_271_1.time_ and arg_271_1.time_ < var_274_21 + var_274_31 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_21) / var_274_31

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_21 + var_274_31 and arg_271_1.time_ < var_274_21 + var_274_31 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play321102067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 321102067
		arg_275_1.duration_ = 5

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play321102068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1089ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1089ui_story == nil then
				arg_275_1.var_.characterEffect1089ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect1089ui_story and not isNil(var_278_0) then
					local var_278_4 = Mathf.Lerp(0, 0.5, var_278_3)

					arg_275_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_275_1.var_.characterEffect1089ui_story.fillRatio = var_278_4
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1089ui_story then
				local var_278_5 = 0.5

				arg_275_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_275_1.var_.characterEffect1089ui_story.fillRatio = var_278_5
			end

			local var_278_6 = 0
			local var_278_7 = 0.7

			if var_278_6 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, false)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_8 = arg_275_1:GetWordFromCfg(321102067)
				local var_278_9 = arg_275_1:FormatText(var_278_8.content)

				arg_275_1.text_.text = var_278_9

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_10 = 28
				local var_278_11 = utf8.len(var_278_9)
				local var_278_12 = var_278_10 <= 0 and var_278_7 or var_278_7 * (var_278_11 / var_278_10)

				if var_278_12 > 0 and var_278_7 < var_278_12 then
					arg_275_1.talkMaxDuration = var_278_12

					if var_278_12 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_12 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_9
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)
				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_13 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_13 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_13

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_13 and arg_275_1.time_ < var_278_6 + var_278_13 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play321102068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 321102068
		arg_279_1.duration_ = 8.5

		local var_279_0 = {
			zh = 6.866,
			ja = 8.5
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
				arg_279_0:Play321102069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["1089ui_story"].transform
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.var_.moveOldPos1089ui_story = var_282_0.localPosition
			end

			local var_282_2 = 0.001

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2
				local var_282_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_282_0.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos1089ui_story, var_282_4, var_282_3)

				local var_282_5 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_5.x, var_282_5.y, var_282_5.z)

				local var_282_6 = var_282_0.localEulerAngles

				var_282_6.z = 0
				var_282_6.x = 0
				var_282_0.localEulerAngles = var_282_6
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 then
				var_282_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_282_7 = manager.ui.mainCamera.transform.position - var_282_0.position

				var_282_0.forward = Vector3.New(var_282_7.x, var_282_7.y, var_282_7.z)

				local var_282_8 = var_282_0.localEulerAngles

				var_282_8.z = 0
				var_282_8.x = 0
				var_282_0.localEulerAngles = var_282_8
			end

			local var_282_9 = arg_279_1.actors_["1089ui_story"]
			local var_282_10 = 0

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect1089ui_story == nil then
				arg_279_1.var_.characterEffect1089ui_story = var_282_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_11 = 0.200000002980232

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_11 and not isNil(var_282_9) then
				local var_282_12 = (arg_279_1.time_ - var_282_10) / var_282_11

				if arg_279_1.var_.characterEffect1089ui_story and not isNil(var_282_9) then
					arg_279_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_10 + var_282_11 and arg_279_1.time_ < var_282_10 + var_282_11 + arg_282_0 and not isNil(var_282_9) and arg_279_1.var_.characterEffect1089ui_story then
				arg_279_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_282_13 = 0
			local var_282_14 = 0.775

			if var_282_13 < arg_279_1.time_ and arg_279_1.time_ <= var_282_13 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_15 = arg_279_1:FormatText(StoryNameCfg[1031].name)

				arg_279_1.leftNameTxt_.text = var_282_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_16 = arg_279_1:GetWordFromCfg(321102068)
				local var_282_17 = arg_279_1:FormatText(var_282_16.content)

				arg_279_1.text_.text = var_282_17

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_18 = 31
				local var_282_19 = utf8.len(var_282_17)
				local var_282_20 = var_282_18 <= 0 and var_282_14 or var_282_14 * (var_282_19 / var_282_18)

				if var_282_20 > 0 and var_282_14 < var_282_20 then
					arg_279_1.talkMaxDuration = var_282_20

					if var_282_20 + var_282_13 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_20 + var_282_13
					end
				end

				arg_279_1.text_.text = var_282_17
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102068", "story_v_out_321102.awb") ~= 0 then
					local var_282_21 = manager.audio:GetVoiceLength("story_v_out_321102", "321102068", "story_v_out_321102.awb") / 1000

					if var_282_21 + var_282_13 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_21 + var_282_13
					end

					if var_282_16.prefab_name ~= "" and arg_279_1.actors_[var_282_16.prefab_name] ~= nil then
						local var_282_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_16.prefab_name].transform, "story_v_out_321102", "321102068", "story_v_out_321102.awb")

						arg_279_1:RecordAudio("321102068", var_282_22)
						arg_279_1:RecordAudio("321102068", var_282_22)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_321102", "321102068", "story_v_out_321102.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_321102", "321102068", "story_v_out_321102.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_23 = math.max(var_282_14, arg_279_1.talkMaxDuration)

			if var_282_13 <= arg_279_1.time_ and arg_279_1.time_ < var_282_13 + var_282_23 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_13) / var_282_23

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_13 + var_282_23 and arg_279_1.time_ < var_282_13 + var_282_23 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_279_1:InitPlayNodeList()
	end,
	Play321102069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 321102069
		arg_283_1.duration_ = 4.47

		local var_283_0 = {
			zh = 2.766,
			ja = 4.466
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
				arg_283_0:Play321102070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = arg_283_1.actors_["10100ui_story"].transform
			local var_286_1 = 0

			if var_286_1 < arg_283_1.time_ and arg_283_1.time_ <= var_286_1 + arg_286_0 then
				arg_283_1.var_.moveOldPos10100ui_story = var_286_0.localPosition
			end

			local var_286_2 = 0.001

			if var_286_1 <= arg_283_1.time_ and arg_283_1.time_ < var_286_1 + var_286_2 then
				local var_286_3 = (arg_283_1.time_ - var_286_1) / var_286_2
				local var_286_4 = Vector3.New(0.7, -1.16, -6.25)

				var_286_0.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos10100ui_story, var_286_4, var_286_3)

				local var_286_5 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_5.x, var_286_5.y, var_286_5.z)

				local var_286_6 = var_286_0.localEulerAngles

				var_286_6.z = 0
				var_286_6.x = 0
				var_286_0.localEulerAngles = var_286_6
			end

			if arg_283_1.time_ >= var_286_1 + var_286_2 and arg_283_1.time_ < var_286_1 + var_286_2 + arg_286_0 then
				var_286_0.localPosition = Vector3.New(0.7, -1.16, -6.25)

				local var_286_7 = manager.ui.mainCamera.transform.position - var_286_0.position

				var_286_0.forward = Vector3.New(var_286_7.x, var_286_7.y, var_286_7.z)

				local var_286_8 = var_286_0.localEulerAngles

				var_286_8.z = 0
				var_286_8.x = 0
				var_286_0.localEulerAngles = var_286_8
			end

			local var_286_9 = arg_283_1.actors_["10100ui_story"]
			local var_286_10 = 0

			if var_286_10 < arg_283_1.time_ and arg_283_1.time_ <= var_286_10 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect10100ui_story == nil then
				arg_283_1.var_.characterEffect10100ui_story = var_286_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_11 = 0.200000002980232

			if var_286_10 <= arg_283_1.time_ and arg_283_1.time_ < var_286_10 + var_286_11 and not isNil(var_286_9) then
				local var_286_12 = (arg_283_1.time_ - var_286_10) / var_286_11

				if arg_283_1.var_.characterEffect10100ui_story and not isNil(var_286_9) then
					arg_283_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= var_286_10 + var_286_11 and arg_283_1.time_ < var_286_10 + var_286_11 + arg_286_0 and not isNil(var_286_9) and arg_283_1.var_.characterEffect10100ui_story then
				arg_283_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_286_13 = arg_283_1.actors_["1089ui_story"]
			local var_286_14 = 0

			if var_286_14 < arg_283_1.time_ and arg_283_1.time_ <= var_286_14 + arg_286_0 and not isNil(var_286_13) and arg_283_1.var_.characterEffect1089ui_story == nil then
				arg_283_1.var_.characterEffect1089ui_story = var_286_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_15 = 0.200000002980232

			if var_286_14 <= arg_283_1.time_ and arg_283_1.time_ < var_286_14 + var_286_15 and not isNil(var_286_13) then
				local var_286_16 = (arg_283_1.time_ - var_286_14) / var_286_15

				if arg_283_1.var_.characterEffect1089ui_story and not isNil(var_286_13) then
					local var_286_17 = Mathf.Lerp(0, 0.5, var_286_16)

					arg_283_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_283_1.var_.characterEffect1089ui_story.fillRatio = var_286_17
				end
			end

			if arg_283_1.time_ >= var_286_14 + var_286_15 and arg_283_1.time_ < var_286_14 + var_286_15 + arg_286_0 and not isNil(var_286_13) and arg_283_1.var_.characterEffect1089ui_story then
				local var_286_18 = 0.5

				arg_283_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_283_1.var_.characterEffect1089ui_story.fillRatio = var_286_18
			end

			local var_286_19 = 0

			if var_286_19 < arg_283_1.time_ and arg_283_1.time_ <= var_286_19 + arg_286_0 then
				arg_283_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053actionlink/10053action442")
			end

			local var_286_20 = 0

			if var_286_20 < arg_283_1.time_ and arg_283_1.time_ <= var_286_20 + arg_286_0 then
				arg_283_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_286_21 = 0
			local var_286_22 = 0.3

			if var_286_21 < arg_283_1.time_ and arg_283_1.time_ <= var_286_21 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_23 = arg_283_1:FormatText(StoryNameCfg[1021].name)

				arg_283_1.leftNameTxt_.text = var_286_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_24 = arg_283_1:GetWordFromCfg(321102069)
				local var_286_25 = arg_283_1:FormatText(var_286_24.content)

				arg_283_1.text_.text = var_286_25

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_26 = 12
				local var_286_27 = utf8.len(var_286_25)
				local var_286_28 = var_286_26 <= 0 and var_286_22 or var_286_22 * (var_286_27 / var_286_26)

				if var_286_28 > 0 and var_286_22 < var_286_28 then
					arg_283_1.talkMaxDuration = var_286_28

					if var_286_28 + var_286_21 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_28 + var_286_21
					end
				end

				arg_283_1.text_.text = var_286_25
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102069", "story_v_out_321102.awb") ~= 0 then
					local var_286_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102069", "story_v_out_321102.awb") / 1000

					if var_286_29 + var_286_21 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_29 + var_286_21
					end

					if var_286_24.prefab_name ~= "" and arg_283_1.actors_[var_286_24.prefab_name] ~= nil then
						local var_286_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_24.prefab_name].transform, "story_v_out_321102", "321102069", "story_v_out_321102.awb")

						arg_283_1:RecordAudio("321102069", var_286_30)
						arg_283_1:RecordAudio("321102069", var_286_30)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_321102", "321102069", "story_v_out_321102.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_321102", "321102069", "story_v_out_321102.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_31 = math.max(var_286_22, arg_283_1.talkMaxDuration)

			if var_286_21 <= arg_283_1.time_ and arg_283_1.time_ < var_286_21 + var_286_31 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_21) / var_286_31

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_21 + var_286_31 and arg_283_1.time_ < var_286_21 + var_286_31 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
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
	Play321102070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 321102070
		arg_287_1.duration_ = 3

		local var_287_0 = {
			zh = 2.3,
			ja = 3
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
				arg_287_0:Play321102071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = arg_287_1.actors_["1089ui_story"].transform
			local var_290_1 = 0

			if var_290_1 < arg_287_1.time_ and arg_287_1.time_ <= var_290_1 + arg_290_0 then
				arg_287_1.var_.moveOldPos1089ui_story = var_290_0.localPosition
			end

			local var_290_2 = 0.001

			if var_290_1 <= arg_287_1.time_ and arg_287_1.time_ < var_290_1 + var_290_2 then
				local var_290_3 = (arg_287_1.time_ - var_290_1) / var_290_2
				local var_290_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_290_0.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos1089ui_story, var_290_4, var_290_3)

				local var_290_5 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_5.x, var_290_5.y, var_290_5.z)

				local var_290_6 = var_290_0.localEulerAngles

				var_290_6.z = 0
				var_290_6.x = 0
				var_290_0.localEulerAngles = var_290_6
			end

			if arg_287_1.time_ >= var_290_1 + var_290_2 and arg_287_1.time_ < var_290_1 + var_290_2 + arg_290_0 then
				var_290_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_290_7 = manager.ui.mainCamera.transform.position - var_290_0.position

				var_290_0.forward = Vector3.New(var_290_7.x, var_290_7.y, var_290_7.z)

				local var_290_8 = var_290_0.localEulerAngles

				var_290_8.z = 0
				var_290_8.x = 0
				var_290_0.localEulerAngles = var_290_8
			end

			local var_290_9 = arg_287_1.actors_["1089ui_story"]
			local var_290_10 = 0

			if var_290_10 < arg_287_1.time_ and arg_287_1.time_ <= var_290_10 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1089ui_story == nil then
				arg_287_1.var_.characterEffect1089ui_story = var_290_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_11 = 0.200000002980232

			if var_290_10 <= arg_287_1.time_ and arg_287_1.time_ < var_290_10 + var_290_11 and not isNil(var_290_9) then
				local var_290_12 = (arg_287_1.time_ - var_290_10) / var_290_11

				if arg_287_1.var_.characterEffect1089ui_story and not isNil(var_290_9) then
					arg_287_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= var_290_10 + var_290_11 and arg_287_1.time_ < var_290_10 + var_290_11 + arg_290_0 and not isNil(var_290_9) and arg_287_1.var_.characterEffect1089ui_story then
				arg_287_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_290_13 = arg_287_1.actors_["10100ui_story"]
			local var_290_14 = 0

			if var_290_14 < arg_287_1.time_ and arg_287_1.time_ <= var_290_14 + arg_290_0 and not isNil(var_290_13) and arg_287_1.var_.characterEffect10100ui_story == nil then
				arg_287_1.var_.characterEffect10100ui_story = var_290_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_15 = 0.200000002980232

			if var_290_14 <= arg_287_1.time_ and arg_287_1.time_ < var_290_14 + var_290_15 and not isNil(var_290_13) then
				local var_290_16 = (arg_287_1.time_ - var_290_14) / var_290_15

				if arg_287_1.var_.characterEffect10100ui_story and not isNil(var_290_13) then
					local var_290_17 = Mathf.Lerp(0, 0.5, var_290_16)

					arg_287_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_287_1.var_.characterEffect10100ui_story.fillRatio = var_290_17
				end
			end

			if arg_287_1.time_ >= var_290_14 + var_290_15 and arg_287_1.time_ < var_290_14 + var_290_15 + arg_290_0 and not isNil(var_290_13) and arg_287_1.var_.characterEffect10100ui_story then
				local var_290_18 = 0.5

				arg_287_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_287_1.var_.characterEffect10100ui_story.fillRatio = var_290_18
			end

			local var_290_19 = 0

			if var_290_19 < arg_287_1.time_ and arg_287_1.time_ <= var_290_19 + arg_290_0 then
				arg_287_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action434")
			end

			local var_290_20 = 0
			local var_290_21 = 0.175

			if var_290_20 < arg_287_1.time_ and arg_287_1.time_ <= var_290_20 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_22 = arg_287_1:FormatText(StoryNameCfg[1031].name)

				arg_287_1.leftNameTxt_.text = var_290_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_23 = arg_287_1:GetWordFromCfg(321102070)
				local var_290_24 = arg_287_1:FormatText(var_290_23.content)

				arg_287_1.text_.text = var_290_24

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_25 = 7
				local var_290_26 = utf8.len(var_290_24)
				local var_290_27 = var_290_25 <= 0 and var_290_21 or var_290_21 * (var_290_26 / var_290_25)

				if var_290_27 > 0 and var_290_21 < var_290_27 then
					arg_287_1.talkMaxDuration = var_290_27

					if var_290_27 + var_290_20 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_27 + var_290_20
					end
				end

				arg_287_1.text_.text = var_290_24
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102070", "story_v_out_321102.awb") ~= 0 then
					local var_290_28 = manager.audio:GetVoiceLength("story_v_out_321102", "321102070", "story_v_out_321102.awb") / 1000

					if var_290_28 + var_290_20 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_28 + var_290_20
					end

					if var_290_23.prefab_name ~= "" and arg_287_1.actors_[var_290_23.prefab_name] ~= nil then
						local var_290_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_23.prefab_name].transform, "story_v_out_321102", "321102070", "story_v_out_321102.awb")

						arg_287_1:RecordAudio("321102070", var_290_29)
						arg_287_1:RecordAudio("321102070", var_290_29)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_321102", "321102070", "story_v_out_321102.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_321102", "321102070", "story_v_out_321102.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_30 = math.max(var_290_21, arg_287_1.talkMaxDuration)

			if var_290_20 <= arg_287_1.time_ and arg_287_1.time_ < var_290_20 + var_290_30 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_20) / var_290_30

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_20 + var_290_30 and arg_287_1.time_ < var_290_20 + var_290_30 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
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
	Play321102071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 321102071
		arg_291_1.duration_ = 4.27

		local var_291_0 = {
			zh = 3.133,
			ja = 4.266
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
				arg_291_0:Play321102072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["10100ui_story"].transform
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.var_.moveOldPos10100ui_story = var_294_0.localPosition
			end

			local var_294_2 = 0.001

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2
				local var_294_4 = Vector3.New(0.7, -1.16, -6.25)

				var_294_0.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos10100ui_story, var_294_4, var_294_3)

				local var_294_5 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_5.x, var_294_5.y, var_294_5.z)

				local var_294_6 = var_294_0.localEulerAngles

				var_294_6.z = 0
				var_294_6.x = 0
				var_294_0.localEulerAngles = var_294_6
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 then
				var_294_0.localPosition = Vector3.New(0.7, -1.16, -6.25)

				local var_294_7 = manager.ui.mainCamera.transform.position - var_294_0.position

				var_294_0.forward = Vector3.New(var_294_7.x, var_294_7.y, var_294_7.z)

				local var_294_8 = var_294_0.localEulerAngles

				var_294_8.z = 0
				var_294_8.x = 0
				var_294_0.localEulerAngles = var_294_8
			end

			local var_294_9 = arg_291_1.actors_["10100ui_story"]
			local var_294_10 = 0

			if var_294_10 < arg_291_1.time_ and arg_291_1.time_ <= var_294_10 + arg_294_0 and not isNil(var_294_9) and arg_291_1.var_.characterEffect10100ui_story == nil then
				arg_291_1.var_.characterEffect10100ui_story = var_294_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_11 = 0.200000002980232

			if var_294_10 <= arg_291_1.time_ and arg_291_1.time_ < var_294_10 + var_294_11 and not isNil(var_294_9) then
				local var_294_12 = (arg_291_1.time_ - var_294_10) / var_294_11

				if arg_291_1.var_.characterEffect10100ui_story and not isNil(var_294_9) then
					arg_291_1.var_.characterEffect10100ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_10 + var_294_11 and arg_291_1.time_ < var_294_10 + var_294_11 + arg_294_0 and not isNil(var_294_9) and arg_291_1.var_.characterEffect10100ui_story then
				arg_291_1.var_.characterEffect10100ui_story.fillFlat = false
			end

			local var_294_13 = arg_291_1.actors_["1089ui_story"]
			local var_294_14 = 0

			if var_294_14 < arg_291_1.time_ and arg_291_1.time_ <= var_294_14 + arg_294_0 and not isNil(var_294_13) and arg_291_1.var_.characterEffect1089ui_story == nil then
				arg_291_1.var_.characterEffect1089ui_story = var_294_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_15 = 0.200000002980232

			if var_294_14 <= arg_291_1.time_ and arg_291_1.time_ < var_294_14 + var_294_15 and not isNil(var_294_13) then
				local var_294_16 = (arg_291_1.time_ - var_294_14) / var_294_15

				if arg_291_1.var_.characterEffect1089ui_story and not isNil(var_294_13) then
					local var_294_17 = Mathf.Lerp(0, 0.5, var_294_16)

					arg_291_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_291_1.var_.characterEffect1089ui_story.fillRatio = var_294_17
				end
			end

			if arg_291_1.time_ >= var_294_14 + var_294_15 and arg_291_1.time_ < var_294_14 + var_294_15 + arg_294_0 and not isNil(var_294_13) and arg_291_1.var_.characterEffect1089ui_story then
				local var_294_18 = 0.5

				arg_291_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_291_1.var_.characterEffect1089ui_story.fillRatio = var_294_18
			end

			local var_294_19 = 0

			if var_294_19 < arg_291_1.time_ and arg_291_1.time_ <= var_294_19 + arg_294_0 then
				arg_291_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/story10053/story10053action/10053action2_2")
			end

			local var_294_20 = 0

			if var_294_20 < arg_291_1.time_ and arg_291_1.time_ <= var_294_20 + arg_294_0 then
				arg_291_1:PlayTimeline("10100ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_294_21 = 0
			local var_294_22 = 0.3

			if var_294_21 < arg_291_1.time_ and arg_291_1.time_ <= var_294_21 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_23 = arg_291_1:FormatText(StoryNameCfg[1021].name)

				arg_291_1.leftNameTxt_.text = var_294_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_24 = arg_291_1:GetWordFromCfg(321102071)
				local var_294_25 = arg_291_1:FormatText(var_294_24.content)

				arg_291_1.text_.text = var_294_25

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_26 = 12
				local var_294_27 = utf8.len(var_294_25)
				local var_294_28 = var_294_26 <= 0 and var_294_22 or var_294_22 * (var_294_27 / var_294_26)

				if var_294_28 > 0 and var_294_22 < var_294_28 then
					arg_291_1.talkMaxDuration = var_294_28

					if var_294_28 + var_294_21 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_28 + var_294_21
					end
				end

				arg_291_1.text_.text = var_294_25
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102071", "story_v_out_321102.awb") ~= 0 then
					local var_294_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102071", "story_v_out_321102.awb") / 1000

					if var_294_29 + var_294_21 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_29 + var_294_21
					end

					if var_294_24.prefab_name ~= "" and arg_291_1.actors_[var_294_24.prefab_name] ~= nil then
						local var_294_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_24.prefab_name].transform, "story_v_out_321102", "321102071", "story_v_out_321102.awb")

						arg_291_1:RecordAudio("321102071", var_294_30)
						arg_291_1:RecordAudio("321102071", var_294_30)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_321102", "321102071", "story_v_out_321102.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_321102", "321102071", "story_v_out_321102.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_31 = math.max(var_294_22, arg_291_1.talkMaxDuration)

			if var_294_21 <= arg_291_1.time_ and arg_291_1.time_ < var_294_21 + var_294_31 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_21) / var_294_31

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_21 + var_294_31 and arg_291_1.time_ < var_294_21 + var_294_31 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play321102072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 321102072
		arg_295_1.duration_ = 2.53

		local var_295_0 = {
			zh = 2.4,
			ja = 2.533
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
				arg_295_0:Play321102073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["1089ui_story"].transform
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 then
				arg_295_1.var_.moveOldPos1089ui_story = var_298_0.localPosition
			end

			local var_298_2 = 0.001

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2
				local var_298_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_298_0.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos1089ui_story, var_298_4, var_298_3)

				local var_298_5 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_5.x, var_298_5.y, var_298_5.z)

				local var_298_6 = var_298_0.localEulerAngles

				var_298_6.z = 0
				var_298_6.x = 0
				var_298_0.localEulerAngles = var_298_6
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 then
				var_298_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_298_7 = manager.ui.mainCamera.transform.position - var_298_0.position

				var_298_0.forward = Vector3.New(var_298_7.x, var_298_7.y, var_298_7.z)

				local var_298_8 = var_298_0.localEulerAngles

				var_298_8.z = 0
				var_298_8.x = 0
				var_298_0.localEulerAngles = var_298_8
			end

			local var_298_9 = arg_295_1.actors_["1089ui_story"]
			local var_298_10 = 0

			if var_298_10 < arg_295_1.time_ and arg_295_1.time_ <= var_298_10 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1089ui_story == nil then
				arg_295_1.var_.characterEffect1089ui_story = var_298_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_11 = 0.200000002980232

			if var_298_10 <= arg_295_1.time_ and arg_295_1.time_ < var_298_10 + var_298_11 and not isNil(var_298_9) then
				local var_298_12 = (arg_295_1.time_ - var_298_10) / var_298_11

				if arg_295_1.var_.characterEffect1089ui_story and not isNil(var_298_9) then
					arg_295_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= var_298_10 + var_298_11 and arg_295_1.time_ < var_298_10 + var_298_11 + arg_298_0 and not isNil(var_298_9) and arg_295_1.var_.characterEffect1089ui_story then
				arg_295_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_298_13 = arg_295_1.actors_["10100ui_story"]
			local var_298_14 = 0

			if var_298_14 < arg_295_1.time_ and arg_295_1.time_ <= var_298_14 + arg_298_0 and not isNil(var_298_13) and arg_295_1.var_.characterEffect10100ui_story == nil then
				arg_295_1.var_.characterEffect10100ui_story = var_298_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_15 = 0.200000002980232

			if var_298_14 <= arg_295_1.time_ and arg_295_1.time_ < var_298_14 + var_298_15 and not isNil(var_298_13) then
				local var_298_16 = (arg_295_1.time_ - var_298_14) / var_298_15

				if arg_295_1.var_.characterEffect10100ui_story and not isNil(var_298_13) then
					local var_298_17 = Mathf.Lerp(0, 0.5, var_298_16)

					arg_295_1.var_.characterEffect10100ui_story.fillFlat = true
					arg_295_1.var_.characterEffect10100ui_story.fillRatio = var_298_17
				end
			end

			if arg_295_1.time_ >= var_298_14 + var_298_15 and arg_295_1.time_ < var_298_14 + var_298_15 + arg_298_0 and not isNil(var_298_13) and arg_295_1.var_.characterEffect10100ui_story then
				local var_298_18 = 0.5

				arg_295_1.var_.characterEffect10100ui_story.fillFlat = true
				arg_295_1.var_.characterEffect10100ui_story.fillRatio = var_298_18
			end

			local var_298_19 = 0

			if var_298_19 < arg_295_1.time_ and arg_295_1.time_ <= var_298_19 + arg_298_0 then
				arg_295_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action445")
			end

			local var_298_20 = 0
			local var_298_21 = 0.25

			if var_298_20 < arg_295_1.time_ and arg_295_1.time_ <= var_298_20 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_22 = arg_295_1:FormatText(StoryNameCfg[1031].name)

				arg_295_1.leftNameTxt_.text = var_298_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_23 = arg_295_1:GetWordFromCfg(321102072)
				local var_298_24 = arg_295_1:FormatText(var_298_23.content)

				arg_295_1.text_.text = var_298_24

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_25 = 10
				local var_298_26 = utf8.len(var_298_24)
				local var_298_27 = var_298_25 <= 0 and var_298_21 or var_298_21 * (var_298_26 / var_298_25)

				if var_298_27 > 0 and var_298_21 < var_298_27 then
					arg_295_1.talkMaxDuration = var_298_27

					if var_298_27 + var_298_20 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_27 + var_298_20
					end
				end

				arg_295_1.text_.text = var_298_24
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102072", "story_v_out_321102.awb") ~= 0 then
					local var_298_28 = manager.audio:GetVoiceLength("story_v_out_321102", "321102072", "story_v_out_321102.awb") / 1000

					if var_298_28 + var_298_20 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_28 + var_298_20
					end

					if var_298_23.prefab_name ~= "" and arg_295_1.actors_[var_298_23.prefab_name] ~= nil then
						local var_298_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_23.prefab_name].transform, "story_v_out_321102", "321102072", "story_v_out_321102.awb")

						arg_295_1:RecordAudio("321102072", var_298_29)
						arg_295_1:RecordAudio("321102072", var_298_29)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_321102", "321102072", "story_v_out_321102.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_321102", "321102072", "story_v_out_321102.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_30 = math.max(var_298_21, arg_295_1.talkMaxDuration)

			if var_298_20 <= arg_295_1.time_ and arg_295_1.time_ < var_298_20 + var_298_30 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_20) / var_298_30

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_20 + var_298_30 and arg_295_1.time_ < var_298_20 + var_298_30 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_295_1:InitPlayNodeList()
	end,
	Play321102073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 321102073
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play321102074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1089ui_story"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1089ui_story == nil then
				arg_299_1.var_.characterEffect1089ui_story = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.characterEffect1089ui_story and not isNil(var_302_0) then
					local var_302_4 = Mathf.Lerp(0, 0.5, var_302_3)

					arg_299_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_299_1.var_.characterEffect1089ui_story.fillRatio = var_302_4
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1089ui_story then
				local var_302_5 = 0.5

				arg_299_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_299_1.var_.characterEffect1089ui_story.fillRatio = var_302_5
			end

			local var_302_6 = 0
			local var_302_7 = 0.85

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

				local var_302_8 = arg_299_1:GetWordFromCfg(321102073)
				local var_302_9 = arg_299_1:FormatText(var_302_8.content)

				arg_299_1.text_.text = var_302_9

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_10 = 34
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
	Play321102074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 321102074
		arg_303_1.duration_ = 4.67

		local var_303_0 = {
			zh = 3.9,
			ja = 4.666
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
				arg_303_0:Play321102075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["1089ui_story"].transform
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.var_.moveOldPos1089ui_story = var_306_0.localPosition
			end

			local var_306_2 = 0.001

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2
				local var_306_4 = Vector3.New(-0.7, -1.1, -6.17)

				var_306_0.localPosition = Vector3.Lerp(arg_303_1.var_.moveOldPos1089ui_story, var_306_4, var_306_3)

				local var_306_5 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_5.x, var_306_5.y, var_306_5.z)

				local var_306_6 = var_306_0.localEulerAngles

				var_306_6.z = 0
				var_306_6.x = 0
				var_306_0.localEulerAngles = var_306_6
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 then
				var_306_0.localPosition = Vector3.New(-0.7, -1.1, -6.17)

				local var_306_7 = manager.ui.mainCamera.transform.position - var_306_0.position

				var_306_0.forward = Vector3.New(var_306_7.x, var_306_7.y, var_306_7.z)

				local var_306_8 = var_306_0.localEulerAngles

				var_306_8.z = 0
				var_306_8.x = 0
				var_306_0.localEulerAngles = var_306_8
			end

			local var_306_9 = arg_303_1.actors_["1089ui_story"]
			local var_306_10 = 0

			if var_306_10 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 and not isNil(var_306_9) and arg_303_1.var_.characterEffect1089ui_story == nil then
				arg_303_1.var_.characterEffect1089ui_story = var_306_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_11 = 0.200000002980232

			if var_306_10 <= arg_303_1.time_ and arg_303_1.time_ < var_306_10 + var_306_11 and not isNil(var_306_9) then
				local var_306_12 = (arg_303_1.time_ - var_306_10) / var_306_11

				if arg_303_1.var_.characterEffect1089ui_story and not isNil(var_306_9) then
					arg_303_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_10 + var_306_11 and arg_303_1.time_ < var_306_10 + var_306_11 + arg_306_0 and not isNil(var_306_9) and arg_303_1.var_.characterEffect1089ui_story then
				arg_303_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_306_13 = 0

			if var_306_13 < arg_303_1.time_ and arg_303_1.time_ <= var_306_13 + arg_306_0 then
				arg_303_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			local var_306_14 = 0

			if var_306_14 < arg_303_1.time_ and arg_303_1.time_ <= var_306_14 + arg_306_0 then
				arg_303_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_306_15 = 0
			local var_306_16 = 0.2

			if var_306_15 < arg_303_1.time_ and arg_303_1.time_ <= var_306_15 + arg_306_0 then
				local var_306_17 = "play"
				local var_306_18 = "music"

				arg_303_1:AudioAction(var_306_17, var_306_18, "ui_battle", "ui_battle_stopbgm", "")

				local var_306_19 = ""
				local var_306_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_306_20 ~= "" then
					if arg_303_1.bgmTxt_.text ~= var_306_20 and arg_303_1.bgmTxt_.text ~= "" then
						if arg_303_1.bgmTxt2_.text ~= "" then
							arg_303_1.bgmTxt_.text = arg_303_1.bgmTxt2_.text
						end

						arg_303_1.bgmTxt2_.text = var_306_20

						arg_303_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_303_1.bgmTxt_.text = var_306_20
						arg_303_1.bgmTxt2_.text = var_306_20
					end

					if arg_303_1.bgmTimer then
						arg_303_1.bgmTimer:Stop()

						arg_303_1.bgmTimer = nil
					end

					if arg_303_1.settingData.show_music_name == 1 then
						arg_303_1.musicController:SetSelectedState("show")
						arg_303_1.musicAnimator_:Play("open", 0, 0)

						if arg_303_1.settingData.music_time ~= 0 then
							arg_303_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_303_1.settingData.music_time), function()
								if arg_303_1 == nil or isNil(arg_303_1.bgmTxt_) then
									return
								end

								arg_303_1.musicController:SetSelectedState("hide")
								arg_303_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_306_21 = 0
			local var_306_22 = 0.4

			if var_306_21 < arg_303_1.time_ and arg_303_1.time_ <= var_306_21 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_23 = arg_303_1:FormatText(StoryNameCfg[1031].name)

				arg_303_1.leftNameTxt_.text = var_306_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_24 = arg_303_1:GetWordFromCfg(321102074)
				local var_306_25 = arg_303_1:FormatText(var_306_24.content)

				arg_303_1.text_.text = var_306_25

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_26 = 16
				local var_306_27 = utf8.len(var_306_25)
				local var_306_28 = var_306_26 <= 0 and var_306_22 or var_306_22 * (var_306_27 / var_306_26)

				if var_306_28 > 0 and var_306_22 < var_306_28 then
					arg_303_1.talkMaxDuration = var_306_28

					if var_306_28 + var_306_21 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_28 + var_306_21
					end
				end

				arg_303_1.text_.text = var_306_25
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102074", "story_v_out_321102.awb") ~= 0 then
					local var_306_29 = manager.audio:GetVoiceLength("story_v_out_321102", "321102074", "story_v_out_321102.awb") / 1000

					if var_306_29 + var_306_21 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_29 + var_306_21
					end

					if var_306_24.prefab_name ~= "" and arg_303_1.actors_[var_306_24.prefab_name] ~= nil then
						local var_306_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_24.prefab_name].transform, "story_v_out_321102", "321102074", "story_v_out_321102.awb")

						arg_303_1:RecordAudio("321102074", var_306_30)
						arg_303_1:RecordAudio("321102074", var_306_30)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_321102", "321102074", "story_v_out_321102.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_321102", "321102074", "story_v_out_321102.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_31 = math.max(var_306_22, arg_303_1.talkMaxDuration)

			if var_306_21 <= arg_303_1.time_ and arg_303_1.time_ < var_306_21 + var_306_31 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_21) / var_306_31

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_21 + var_306_31 and arg_303_1.time_ < var_306_21 + var_306_31 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_303_1:InitPlayNodeList()
	end,
	Play321102075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 321102075
		arg_308_1.duration_ = 12.53

		local var_308_0 = {
			zh = 11.3,
			ja = 12.533
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play321102076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = "ST0504"

			if arg_308_1.bgs_[var_311_0] == nil then
				local var_311_1 = Object.Instantiate(arg_308_1.paintGo_)

				var_311_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_311_0)
				var_311_1.name = var_311_0
				var_311_1.transform.parent = arg_308_1.stage_.transform
				var_311_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_308_1.bgs_[var_311_0] = var_311_1
			end

			local var_311_2 = 2

			if var_311_2 < arg_308_1.time_ and arg_308_1.time_ <= var_311_2 + arg_311_0 then
				local var_311_3 = manager.ui.mainCamera.transform.localPosition
				local var_311_4 = Vector3.New(0, 0, 10) + Vector3.New(var_311_3.x, var_311_3.y, 0)
				local var_311_5 = arg_308_1.bgs_.ST0504

				var_311_5.transform.localPosition = var_311_4
				var_311_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_311_6 = var_311_5:GetComponent("SpriteRenderer")

				if var_311_6 and var_311_6.sprite then
					local var_311_7 = (var_311_5.transform.localPosition - var_311_3).z
					local var_311_8 = manager.ui.mainCameraCom_
					local var_311_9 = 2 * var_311_7 * Mathf.Tan(var_311_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_311_10 = var_311_9 * var_311_8.aspect
					local var_311_11 = var_311_6.sprite.bounds.size.x
					local var_311_12 = var_311_6.sprite.bounds.size.y
					local var_311_13 = var_311_10 / var_311_11
					local var_311_14 = var_311_9 / var_311_12
					local var_311_15 = var_311_14 < var_311_13 and var_311_13 or var_311_14

					var_311_5.transform.localScale = Vector3.New(var_311_15, var_311_15, 0)
				end

				for iter_311_0, iter_311_1 in pairs(arg_308_1.bgs_) do
					if iter_311_0 ~= "ST0504" then
						iter_311_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_311_16 = 3.999999999999

			if var_311_16 < arg_308_1.time_ and arg_308_1.time_ <= var_311_16 + arg_311_0 then
				arg_308_1.allBtn_.enabled = false
			end

			local var_311_17 = 0.3

			if arg_308_1.time_ >= var_311_16 + var_311_17 and arg_308_1.time_ < var_311_16 + var_311_17 + arg_311_0 then
				arg_308_1.allBtn_.enabled = true
			end

			local var_311_18 = 0

			if var_311_18 < arg_308_1.time_ and arg_308_1.time_ <= var_311_18 + arg_311_0 then
				arg_308_1.mask_.enabled = true
				arg_308_1.mask_.raycastTarget = true

				arg_308_1:SetGaussion(false)
			end

			local var_311_19 = 2

			if var_311_18 <= arg_308_1.time_ and arg_308_1.time_ < var_311_18 + var_311_19 then
				local var_311_20 = (arg_308_1.time_ - var_311_18) / var_311_19
				local var_311_21 = Color.New(0, 0, 0)

				var_311_21.a = Mathf.Lerp(0, 1, var_311_20)
				arg_308_1.mask_.color = var_311_21
			end

			if arg_308_1.time_ >= var_311_18 + var_311_19 and arg_308_1.time_ < var_311_18 + var_311_19 + arg_311_0 then
				local var_311_22 = Color.New(0, 0, 0)

				var_311_22.a = 1
				arg_308_1.mask_.color = var_311_22
			end

			local var_311_23 = 2

			if var_311_23 < arg_308_1.time_ and arg_308_1.time_ <= var_311_23 + arg_311_0 then
				arg_308_1.mask_.enabled = true
				arg_308_1.mask_.raycastTarget = true

				arg_308_1:SetGaussion(false)
			end

			local var_311_24 = 2

			if var_311_23 <= arg_308_1.time_ and arg_308_1.time_ < var_311_23 + var_311_24 then
				local var_311_25 = (arg_308_1.time_ - var_311_23) / var_311_24
				local var_311_26 = Color.New(0, 0, 0)

				var_311_26.a = Mathf.Lerp(1, 0, var_311_25)
				arg_308_1.mask_.color = var_311_26
			end

			if arg_308_1.time_ >= var_311_23 + var_311_24 and arg_308_1.time_ < var_311_23 + var_311_24 + arg_311_0 then
				local var_311_27 = Color.New(0, 0, 0)
				local var_311_28 = 0

				arg_308_1.mask_.enabled = false
				var_311_27.a = var_311_28
				arg_308_1.mask_.color = var_311_27
			end

			local var_311_29 = arg_308_1.actors_["1089ui_story"].transform
			local var_311_30 = 1.96599999815226

			if var_311_30 < arg_308_1.time_ and arg_308_1.time_ <= var_311_30 + arg_311_0 then
				arg_308_1.var_.moveOldPos1089ui_story = var_311_29.localPosition
			end

			local var_311_31 = 0.001

			if var_311_30 <= arg_308_1.time_ and arg_308_1.time_ < var_311_30 + var_311_31 then
				local var_311_32 = (arg_308_1.time_ - var_311_30) / var_311_31
				local var_311_33 = Vector3.New(0, 100, 0)

				var_311_29.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1089ui_story, var_311_33, var_311_32)

				local var_311_34 = manager.ui.mainCamera.transform.position - var_311_29.position

				var_311_29.forward = Vector3.New(var_311_34.x, var_311_34.y, var_311_34.z)

				local var_311_35 = var_311_29.localEulerAngles

				var_311_35.z = 0
				var_311_35.x = 0
				var_311_29.localEulerAngles = var_311_35
			end

			if arg_308_1.time_ >= var_311_30 + var_311_31 and arg_308_1.time_ < var_311_30 + var_311_31 + arg_311_0 then
				var_311_29.localPosition = Vector3.New(0, 100, 0)

				local var_311_36 = manager.ui.mainCamera.transform.position - var_311_29.position

				var_311_29.forward = Vector3.New(var_311_36.x, var_311_36.y, var_311_36.z)

				local var_311_37 = var_311_29.localEulerAngles

				var_311_37.z = 0
				var_311_37.x = 0
				var_311_29.localEulerAngles = var_311_37
			end

			local var_311_38 = arg_308_1.actors_["10100ui_story"].transform
			local var_311_39 = 1.96599999815226

			if var_311_39 < arg_308_1.time_ and arg_308_1.time_ <= var_311_39 + arg_311_0 then
				arg_308_1.var_.moveOldPos10100ui_story = var_311_38.localPosition
			end

			local var_311_40 = 0.001

			if var_311_39 <= arg_308_1.time_ and arg_308_1.time_ < var_311_39 + var_311_40 then
				local var_311_41 = (arg_308_1.time_ - var_311_39) / var_311_40
				local var_311_42 = Vector3.New(0, 100, 0)

				var_311_38.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10100ui_story, var_311_42, var_311_41)

				local var_311_43 = manager.ui.mainCamera.transform.position - var_311_38.position

				var_311_38.forward = Vector3.New(var_311_43.x, var_311_43.y, var_311_43.z)

				local var_311_44 = var_311_38.localEulerAngles

				var_311_44.z = 0
				var_311_44.x = 0
				var_311_38.localEulerAngles = var_311_44
			end

			if arg_308_1.time_ >= var_311_39 + var_311_40 and arg_308_1.time_ < var_311_39 + var_311_40 + arg_311_0 then
				var_311_38.localPosition = Vector3.New(0, 100, 0)

				local var_311_45 = manager.ui.mainCamera.transform.position - var_311_38.position

				var_311_38.forward = Vector3.New(var_311_45.x, var_311_45.y, var_311_45.z)

				local var_311_46 = var_311_38.localEulerAngles

				var_311_46.z = 0
				var_311_46.x = 0
				var_311_38.localEulerAngles = var_311_46
			end

			local var_311_47 = arg_308_1.actors_["1089ui_story"]
			local var_311_48 = 1.96599999815226

			if var_311_48 < arg_308_1.time_ and arg_308_1.time_ <= var_311_48 + arg_311_0 and not isNil(var_311_47) and arg_308_1.var_.characterEffect1089ui_story == nil then
				arg_308_1.var_.characterEffect1089ui_story = var_311_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_49 = 0.034000001847744

			if var_311_48 <= arg_308_1.time_ and arg_308_1.time_ < var_311_48 + var_311_49 and not isNil(var_311_47) then
				local var_311_50 = (arg_308_1.time_ - var_311_48) / var_311_49

				if arg_308_1.var_.characterEffect1089ui_story and not isNil(var_311_47) then
					local var_311_51 = Mathf.Lerp(0, 0.5, var_311_50)

					arg_308_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1089ui_story.fillRatio = var_311_51
				end
			end

			if arg_308_1.time_ >= var_311_48 + var_311_49 and arg_308_1.time_ < var_311_48 + var_311_49 + arg_311_0 and not isNil(var_311_47) and arg_308_1.var_.characterEffect1089ui_story then
				local var_311_52 = 0.5

				arg_308_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1089ui_story.fillRatio = var_311_52
			end

			local var_311_53 = 0
			local var_311_54 = 0.2

			if var_311_53 < arg_308_1.time_ and arg_308_1.time_ <= var_311_53 + arg_311_0 then
				local var_311_55 = "play"
				local var_311_56 = "music"

				arg_308_1:AudioAction(var_311_55, var_311_56, "ui_battle", "ui_battle_stopbgm", "")

				local var_311_57 = ""
				local var_311_58 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_311_58 ~= "" then
					if arg_308_1.bgmTxt_.text ~= var_311_58 and arg_308_1.bgmTxt_.text ~= "" then
						if arg_308_1.bgmTxt2_.text ~= "" then
							arg_308_1.bgmTxt_.text = arg_308_1.bgmTxt2_.text
						end

						arg_308_1.bgmTxt2_.text = var_311_58

						arg_308_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_308_1.bgmTxt_.text = var_311_58
						arg_308_1.bgmTxt2_.text = var_311_58
					end

					if arg_308_1.bgmTimer then
						arg_308_1.bgmTimer:Stop()

						arg_308_1.bgmTimer = nil
					end

					if arg_308_1.settingData.show_music_name == 1 then
						arg_308_1.musicController:SetSelectedState("show")
						arg_308_1.musicAnimator_:Play("open", 0, 0)

						if arg_308_1.settingData.music_time ~= 0 then
							arg_308_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_308_1.settingData.music_time), function()
								if arg_308_1 == nil or isNil(arg_308_1.bgmTxt_) then
									return
								end

								arg_308_1.musicController:SetSelectedState("hide")
								arg_308_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_311_59 = 1.8
			local var_311_60 = 1

			if var_311_59 < arg_308_1.time_ and arg_308_1.time_ <= var_311_59 + arg_311_0 then
				local var_311_61 = "play"
				local var_311_62 = "music"

				arg_308_1:AudioAction(var_311_61, var_311_62, "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_311_63 = ""
				local var_311_64 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

				if var_311_64 ~= "" then
					if arg_308_1.bgmTxt_.text ~= var_311_64 and arg_308_1.bgmTxt_.text ~= "" then
						if arg_308_1.bgmTxt2_.text ~= "" then
							arg_308_1.bgmTxt_.text = arg_308_1.bgmTxt2_.text
						end

						arg_308_1.bgmTxt2_.text = var_311_64

						arg_308_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_308_1.bgmTxt_.text = var_311_64
						arg_308_1.bgmTxt2_.text = var_311_64
					end

					if arg_308_1.bgmTimer then
						arg_308_1.bgmTimer:Stop()

						arg_308_1.bgmTimer = nil
					end

					if arg_308_1.settingData.show_music_name == 1 then
						arg_308_1.musicController:SetSelectedState("show")
						arg_308_1.musicAnimator_:Play("open", 0, 0)

						if arg_308_1.settingData.music_time ~= 0 then
							arg_308_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_308_1.settingData.music_time), function()
								if arg_308_1 == nil or isNil(arg_308_1.bgmTxt_) then
									return
								end

								arg_308_1.musicController:SetSelectedState("hide")
								arg_308_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_311_65 = 0.366666666666667
			local var_311_66 = 1

			if var_311_65 < arg_308_1.time_ and arg_308_1.time_ <= var_311_65 + arg_311_0 then
				local var_311_67 = "stop"
				local var_311_68 = "effect"

				arg_308_1:AudioAction(var_311_67, var_311_68, "se_story_140", "se_story_140_amb_chaos", "")
			end

			if arg_308_1.frameCnt_ <= 1 then
				arg_308_1.dialog_:SetActive(false)
			end

			local var_311_69 = 4
			local var_311_70 = 0.975

			if var_311_69 < arg_308_1.time_ and arg_308_1.time_ <= var_311_69 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0

				arg_308_1.dialog_:SetActive(true)

				arg_308_1.dialogCg_.alpha = 0

				local var_311_71 = LeanTween.value(arg_308_1.dialog_, 0, 1, 0.3)

				var_311_71:setOnUpdate(LuaHelper.FloatAction(function(arg_314_0)
					arg_308_1.dialogCg_.alpha = arg_314_0
				end))
				var_311_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_308_1.dialog_)
					var_311_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_308_1.duration_ = arg_308_1.duration_ + 0.3

				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_72 = arg_308_1:FormatText(StoryNameCfg[1176].name)

				arg_308_1.leftNameTxt_.text = var_311_72

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, true)
				arg_308_1.iconController_:SetSelectedState("hero")

				arg_308_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_308_1.callingController_:SetSelectedState("normal")

				arg_308_1.keyicon_.color = Color.New(1, 1, 1)
				arg_308_1.icon_.color = Color.New(1, 1, 1)

				local var_311_73 = arg_308_1:GetWordFromCfg(321102075)
				local var_311_74 = arg_308_1:FormatText(var_311_73.content)

				arg_308_1.text_.text = var_311_74

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_75 = 39
				local var_311_76 = utf8.len(var_311_74)
				local var_311_77 = var_311_75 <= 0 and var_311_70 or var_311_70 * (var_311_76 / var_311_75)

				if var_311_77 > 0 and var_311_70 < var_311_77 then
					arg_308_1.talkMaxDuration = var_311_77
					var_311_69 = var_311_69 + 0.3

					if var_311_77 + var_311_69 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_77 + var_311_69
					end
				end

				arg_308_1.text_.text = var_311_74
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102075", "story_v_out_321102.awb") ~= 0 then
					local var_311_78 = manager.audio:GetVoiceLength("story_v_out_321102", "321102075", "story_v_out_321102.awb") / 1000

					if var_311_78 + var_311_69 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_78 + var_311_69
					end

					if var_311_73.prefab_name ~= "" and arg_308_1.actors_[var_311_73.prefab_name] ~= nil then
						local var_311_79 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_73.prefab_name].transform, "story_v_out_321102", "321102075", "story_v_out_321102.awb")

						arg_308_1:RecordAudio("321102075", var_311_79)
						arg_308_1:RecordAudio("321102075", var_311_79)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_321102", "321102075", "story_v_out_321102.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_321102", "321102075", "story_v_out_321102.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_80 = var_311_69 + 0.3
			local var_311_81 = math.max(var_311_70, arg_308_1.talkMaxDuration)

			if var_311_80 <= arg_308_1.time_ and arg_308_1.time_ < var_311_80 + var_311_81 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_80) / var_311_81

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_80 + var_311_81 and arg_308_1.time_ < var_311_80 + var_311_81 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10100ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play321102076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 321102076
		arg_316_1.duration_ = 3.6

		local var_316_0 = {
			zh = 3,
			ja = 3.6
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play321102077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 0.425

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_2 = arg_316_1:FormatText(StoryNameCfg[1176].name)

				arg_316_1.leftNameTxt_.text = var_319_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_3 = arg_316_1:GetWordFromCfg(321102076)
				local var_319_4 = arg_316_1:FormatText(var_319_3.content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 17
				local var_319_6 = utf8.len(var_319_4)
				local var_319_7 = var_319_5 <= 0 and var_319_1 or var_319_1 * (var_319_6 / var_319_5)

				if var_319_7 > 0 and var_319_1 < var_319_7 then
					arg_316_1.talkMaxDuration = var_319_7

					if var_319_7 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_4
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102076", "story_v_out_321102.awb") ~= 0 then
					local var_319_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102076", "story_v_out_321102.awb") / 1000

					if var_319_8 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_8 + var_319_0
					end

					if var_319_3.prefab_name ~= "" and arg_316_1.actors_[var_319_3.prefab_name] ~= nil then
						local var_319_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_3.prefab_name].transform, "story_v_out_321102", "321102076", "story_v_out_321102.awb")

						arg_316_1:RecordAudio("321102076", var_319_9)
						arg_316_1:RecordAudio("321102076", var_319_9)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_321102", "321102076", "story_v_out_321102.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_321102", "321102076", "story_v_out_321102.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_10 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_10 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_10

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_10 and arg_316_1.time_ < var_319_0 + var_319_10 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play321102077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 321102077
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play321102078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 1.15

			if var_323_0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_0 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_2 = arg_320_1:GetWordFromCfg(321102077)
				local var_323_3 = arg_320_1:FormatText(var_323_2.content)

				arg_320_1.text_.text = var_323_3

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 46
				local var_323_5 = utf8.len(var_323_3)
				local var_323_6 = var_323_4 <= 0 and var_323_1 or var_323_1 * (var_323_5 / var_323_4)

				if var_323_6 > 0 and var_323_1 < var_323_6 then
					arg_320_1.talkMaxDuration = var_323_6

					if var_323_6 + var_323_0 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_6 + var_323_0
					end
				end

				arg_320_1.text_.text = var_323_3
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_7 = math.max(var_323_1, arg_320_1.talkMaxDuration)

			if var_323_0 <= arg_320_1.time_ and arg_320_1.time_ < var_323_0 + var_323_7 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_0) / var_323_7

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_0 + var_323_7 and arg_320_1.time_ < var_323_0 + var_323_7 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play321102078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 321102078
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play321102079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 1.2

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_2 = arg_324_1:GetWordFromCfg(321102078)
				local var_327_3 = arg_324_1:FormatText(var_327_2.content)

				arg_324_1.text_.text = var_327_3

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_4 = 48
				local var_327_5 = utf8.len(var_327_3)
				local var_327_6 = var_327_4 <= 0 and var_327_1 or var_327_1 * (var_327_5 / var_327_4)

				if var_327_6 > 0 and var_327_1 < var_327_6 then
					arg_324_1.talkMaxDuration = var_327_6

					if var_327_6 + var_327_0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_6 + var_327_0
					end
				end

				arg_324_1.text_.text = var_327_3
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_7 = math.max(var_327_1, arg_324_1.talkMaxDuration)

			if var_327_0 <= arg_324_1.time_ and arg_324_1.time_ < var_327_0 + var_327_7 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_0) / var_327_7

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_0 + var_327_7 and arg_324_1.time_ < var_327_0 + var_327_7 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play321102079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 321102079
		arg_328_1.duration_ = 10.57

		local var_328_0 = {
			zh = 6.4,
			ja = 10.566
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play321102080(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0
			local var_331_1 = 0.95

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_2 = arg_328_1:FormatText(StoryNameCfg[1176].name)

				arg_328_1.leftNameTxt_.text = var_331_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_3 = arg_328_1:GetWordFromCfg(321102079)
				local var_331_4 = arg_328_1:FormatText(var_331_3.content)

				arg_328_1.text_.text = var_331_4

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_5 = 38
				local var_331_6 = utf8.len(var_331_4)
				local var_331_7 = var_331_5 <= 0 and var_331_1 or var_331_1 * (var_331_6 / var_331_5)

				if var_331_7 > 0 and var_331_1 < var_331_7 then
					arg_328_1.talkMaxDuration = var_331_7

					if var_331_7 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_7 + var_331_0
					end
				end

				arg_328_1.text_.text = var_331_4
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102079", "story_v_out_321102.awb") ~= 0 then
					local var_331_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102079", "story_v_out_321102.awb") / 1000

					if var_331_8 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_8 + var_331_0
					end

					if var_331_3.prefab_name ~= "" and arg_328_1.actors_[var_331_3.prefab_name] ~= nil then
						local var_331_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_3.prefab_name].transform, "story_v_out_321102", "321102079", "story_v_out_321102.awb")

						arg_328_1:RecordAudio("321102079", var_331_9)
						arg_328_1:RecordAudio("321102079", var_331_9)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_321102", "321102079", "story_v_out_321102.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_321102", "321102079", "story_v_out_321102.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_10 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_10 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_10

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_10 and arg_328_1.time_ < var_331_0 + var_331_10 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play321102080 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 321102080
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play321102081(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = 0
			local var_335_1 = 0.85

			if var_335_0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_0 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_2 = arg_332_1:GetWordFromCfg(321102080)
				local var_335_3 = arg_332_1:FormatText(var_335_2.content)

				arg_332_1.text_.text = var_335_3

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_4 = 34
				local var_335_5 = utf8.len(var_335_3)
				local var_335_6 = var_335_4 <= 0 and var_335_1 or var_335_1 * (var_335_5 / var_335_4)

				if var_335_6 > 0 and var_335_1 < var_335_6 then
					arg_332_1.talkMaxDuration = var_335_6

					if var_335_6 + var_335_0 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_6 + var_335_0
					end
				end

				arg_332_1.text_.text = var_335_3
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_7 = math.max(var_335_1, arg_332_1.talkMaxDuration)

			if var_335_0 <= arg_332_1.time_ and arg_332_1.time_ < var_335_0 + var_335_7 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_0) / var_335_7

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_0 + var_335_7 and arg_332_1.time_ < var_335_0 + var_335_7 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play321102081 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 321102081
		arg_336_1.duration_ = 9.43

		local var_336_0 = {
			zh = 5.1,
			ja = 9.433
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play321102082(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = "1061ui_story"

			if arg_336_1.actors_[var_339_0] == nil then
				local var_339_1 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_339_1) then
					local var_339_2 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_336_1.stage_.transform)

					var_339_2.name = var_339_0
					var_339_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_336_1.actors_[var_339_0] = var_339_2

					local var_339_3 = var_339_2:GetComponentInChildren(typeof(CharacterEffect))

					var_339_3.enabled = true

					local var_339_4 = GameObjectTools.GetOrAddComponent(var_339_2, typeof(DynamicBoneHelper))

					if var_339_4 then
						var_339_4:EnableDynamicBone(false)
					end

					arg_336_1:ShowWeapon(var_339_3.transform, false)

					arg_336_1.var_[var_339_0 .. "Animator"] = var_339_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_336_1.var_[var_339_0 .. "Animator"].applyRootMotion = true
					arg_336_1.var_[var_339_0 .. "LipSync"] = var_339_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_339_5 = arg_336_1.actors_["1061ui_story"].transform
			local var_339_6 = 0

			if var_339_6 < arg_336_1.time_ and arg_336_1.time_ <= var_339_6 + arg_339_0 then
				arg_336_1.var_.moveOldPos1061ui_story = var_339_5.localPosition
			end

			local var_339_7 = 0.001

			if var_339_6 <= arg_336_1.time_ and arg_336_1.time_ < var_339_6 + var_339_7 then
				local var_339_8 = (arg_336_1.time_ - var_339_6) / var_339_7
				local var_339_9 = Vector3.New(0, -1.18, -6.15)

				var_339_5.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos1061ui_story, var_339_9, var_339_8)

				local var_339_10 = manager.ui.mainCamera.transform.position - var_339_5.position

				var_339_5.forward = Vector3.New(var_339_10.x, var_339_10.y, var_339_10.z)

				local var_339_11 = var_339_5.localEulerAngles

				var_339_11.z = 0
				var_339_11.x = 0
				var_339_5.localEulerAngles = var_339_11
			end

			if arg_336_1.time_ >= var_339_6 + var_339_7 and arg_336_1.time_ < var_339_6 + var_339_7 + arg_339_0 then
				var_339_5.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_339_12 = manager.ui.mainCamera.transform.position - var_339_5.position

				var_339_5.forward = Vector3.New(var_339_12.x, var_339_12.y, var_339_12.z)

				local var_339_13 = var_339_5.localEulerAngles

				var_339_13.z = 0
				var_339_13.x = 0
				var_339_5.localEulerAngles = var_339_13
			end

			local var_339_14 = arg_336_1.actors_["1061ui_story"]
			local var_339_15 = 0

			if var_339_15 < arg_336_1.time_ and arg_336_1.time_ <= var_339_15 + arg_339_0 and not isNil(var_339_14) and arg_336_1.var_.characterEffect1061ui_story == nil then
				arg_336_1.var_.characterEffect1061ui_story = var_339_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_16 = 0.200000002980232

			if var_339_15 <= arg_336_1.time_ and arg_336_1.time_ < var_339_15 + var_339_16 and not isNil(var_339_14) then
				local var_339_17 = (arg_336_1.time_ - var_339_15) / var_339_16

				if arg_336_1.var_.characterEffect1061ui_story and not isNil(var_339_14) then
					arg_336_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= var_339_15 + var_339_16 and arg_336_1.time_ < var_339_15 + var_339_16 + arg_339_0 and not isNil(var_339_14) and arg_336_1.var_.characterEffect1061ui_story then
				arg_336_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_339_18 = 0

			if var_339_18 < arg_336_1.time_ and arg_336_1.time_ <= var_339_18 + arg_339_0 then
				arg_336_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_339_19 = 0

			if var_339_19 < arg_336_1.time_ and arg_336_1.time_ <= var_339_19 + arg_339_0 then
				arg_336_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_339_20 = 0
			local var_339_21 = 0.55

			if var_339_20 < arg_336_1.time_ and arg_336_1.time_ <= var_339_20 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_22 = arg_336_1:FormatText(StoryNameCfg[612].name)

				arg_336_1.leftNameTxt_.text = var_339_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_23 = arg_336_1:GetWordFromCfg(321102081)
				local var_339_24 = arg_336_1:FormatText(var_339_23.content)

				arg_336_1.text_.text = var_339_24

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_25 = 22
				local var_339_26 = utf8.len(var_339_24)
				local var_339_27 = var_339_25 <= 0 and var_339_21 or var_339_21 * (var_339_26 / var_339_25)

				if var_339_27 > 0 and var_339_21 < var_339_27 then
					arg_336_1.talkMaxDuration = var_339_27

					if var_339_27 + var_339_20 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_27 + var_339_20
					end
				end

				arg_336_1.text_.text = var_339_24
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102081", "story_v_out_321102.awb") ~= 0 then
					local var_339_28 = manager.audio:GetVoiceLength("story_v_out_321102", "321102081", "story_v_out_321102.awb") / 1000

					if var_339_28 + var_339_20 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_28 + var_339_20
					end

					if var_339_23.prefab_name ~= "" and arg_336_1.actors_[var_339_23.prefab_name] ~= nil then
						local var_339_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_23.prefab_name].transform, "story_v_out_321102", "321102081", "story_v_out_321102.awb")

						arg_336_1:RecordAudio("321102081", var_339_29)
						arg_336_1:RecordAudio("321102081", var_339_29)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_321102", "321102081", "story_v_out_321102.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_321102", "321102081", "story_v_out_321102.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_30 = math.max(var_339_21, arg_336_1.talkMaxDuration)

			if var_339_20 <= arg_336_1.time_ and arg_336_1.time_ < var_339_20 + var_339_30 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_20) / var_339_30

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_20 + var_339_30 and arg_336_1.time_ < var_339_20 + var_339_30 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play321102082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 321102082
		arg_340_1.duration_ = 3.9

		local var_340_0 = {
			zh = 3.166,
			ja = 3.9
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
				arg_340_0:Play321102083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["1061ui_story"]
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect1061ui_story == nil then
				arg_340_1.var_.characterEffect1061ui_story = var_343_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_2 = 0.200000002980232

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 and not isNil(var_343_0) then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2

				if arg_340_1.var_.characterEffect1061ui_story and not isNil(var_343_0) then
					local var_343_4 = Mathf.Lerp(0, 0.5, var_343_3)

					arg_340_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1061ui_story.fillRatio = var_343_4
				end
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 and not isNil(var_343_0) and arg_340_1.var_.characterEffect1061ui_story then
				local var_343_5 = 0.5

				arg_340_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1061ui_story.fillRatio = var_343_5
			end

			local var_343_6 = 0
			local var_343_7 = 0.4

			if var_343_6 < arg_340_1.time_ and arg_340_1.time_ <= var_343_6 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				local var_343_8 = arg_340_1:FormatText(StoryNameCfg[1176].name)

				arg_340_1.leftNameTxt_.text = var_343_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, true)
				arg_340_1.iconController_:SetSelectedState("hero")

				arg_340_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_340_1.callingController_:SetSelectedState("normal")

				arg_340_1.keyicon_.color = Color.New(1, 1, 1)
				arg_340_1.icon_.color = Color.New(1, 1, 1)

				local var_343_9 = arg_340_1:GetWordFromCfg(321102082)
				local var_343_10 = arg_340_1:FormatText(var_343_9.content)

				arg_340_1.text_.text = var_343_10

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_11 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102082", "story_v_out_321102.awb") ~= 0 then
					local var_343_14 = manager.audio:GetVoiceLength("story_v_out_321102", "321102082", "story_v_out_321102.awb") / 1000

					if var_343_14 + var_343_6 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_14 + var_343_6
					end

					if var_343_9.prefab_name ~= "" and arg_340_1.actors_[var_343_9.prefab_name] ~= nil then
						local var_343_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_9.prefab_name].transform, "story_v_out_321102", "321102082", "story_v_out_321102.awb")

						arg_340_1:RecordAudio("321102082", var_343_15)
						arg_340_1:RecordAudio("321102082", var_343_15)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_321102", "321102082", "story_v_out_321102.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_321102", "321102082", "story_v_out_321102.awb")
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
	Play321102083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 321102083
		arg_344_1.duration_ = 12.2

		local var_344_0 = {
			zh = 7,
			ja = 12.2
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
				arg_344_0:Play321102084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0
			local var_347_1 = 0.775

			if var_347_0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_2 = arg_344_1:FormatText(StoryNameCfg[1176].name)

				arg_344_1.leftNameTxt_.text = var_347_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, true)
				arg_344_1.iconController_:SetSelectedState("hero")

				arg_344_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_344_1.callingController_:SetSelectedState("normal")

				arg_344_1.keyicon_.color = Color.New(1, 1, 1)
				arg_344_1.icon_.color = Color.New(1, 1, 1)

				local var_347_3 = arg_344_1:GetWordFromCfg(321102083)
				local var_347_4 = arg_344_1:FormatText(var_347_3.content)

				arg_344_1.text_.text = var_347_4

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102083", "story_v_out_321102.awb") ~= 0 then
					local var_347_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102083", "story_v_out_321102.awb") / 1000

					if var_347_8 + var_347_0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_8 + var_347_0
					end

					if var_347_3.prefab_name ~= "" and arg_344_1.actors_[var_347_3.prefab_name] ~= nil then
						local var_347_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_3.prefab_name].transform, "story_v_out_321102", "321102083", "story_v_out_321102.awb")

						arg_344_1:RecordAudio("321102083", var_347_9)
						arg_344_1:RecordAudio("321102083", var_347_9)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_321102", "321102083", "story_v_out_321102.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_321102", "321102083", "story_v_out_321102.awb")
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
	Play321102084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 321102084
		arg_348_1.duration_ = 4.47

		local var_348_0 = {
			zh = 3.066,
			ja = 4.466
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
				arg_348_0:Play321102085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = arg_348_1.actors_["1061ui_story"].transform
			local var_351_1 = 0

			if var_351_1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_1 + arg_351_0 then
				arg_348_1.var_.moveOldPos1061ui_story = var_351_0.localPosition
			end

			local var_351_2 = 0.001

			if var_351_1 <= arg_348_1.time_ and arg_348_1.time_ < var_351_1 + var_351_2 then
				local var_351_3 = (arg_348_1.time_ - var_351_1) / var_351_2
				local var_351_4 = Vector3.New(0, -1.18, -6.15)

				var_351_0.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos1061ui_story, var_351_4, var_351_3)

				local var_351_5 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_5.x, var_351_5.y, var_351_5.z)

				local var_351_6 = var_351_0.localEulerAngles

				var_351_6.z = 0
				var_351_6.x = 0
				var_351_0.localEulerAngles = var_351_6
			end

			if arg_348_1.time_ >= var_351_1 + var_351_2 and arg_348_1.time_ < var_351_1 + var_351_2 + arg_351_0 then
				var_351_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_351_7 = manager.ui.mainCamera.transform.position - var_351_0.position

				var_351_0.forward = Vector3.New(var_351_7.x, var_351_7.y, var_351_7.z)

				local var_351_8 = var_351_0.localEulerAngles

				var_351_8.z = 0
				var_351_8.x = 0
				var_351_0.localEulerAngles = var_351_8
			end

			local var_351_9 = arg_348_1.actors_["1061ui_story"]
			local var_351_10 = 0

			if var_351_10 < arg_348_1.time_ and arg_348_1.time_ <= var_351_10 + arg_351_0 and not isNil(var_351_9) and arg_348_1.var_.characterEffect1061ui_story == nil then
				arg_348_1.var_.characterEffect1061ui_story = var_351_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_351_11 = 0.200000002980232

			if var_351_10 <= arg_348_1.time_ and arg_348_1.time_ < var_351_10 + var_351_11 and not isNil(var_351_9) then
				local var_351_12 = (arg_348_1.time_ - var_351_10) / var_351_11

				if arg_348_1.var_.characterEffect1061ui_story and not isNil(var_351_9) then
					arg_348_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_348_1.time_ >= var_351_10 + var_351_11 and arg_348_1.time_ < var_351_10 + var_351_11 + arg_351_0 and not isNil(var_351_9) and arg_348_1.var_.characterEffect1061ui_story then
				arg_348_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_351_13 = 0

			if var_351_13 < arg_348_1.time_ and arg_348_1.time_ <= var_351_13 + arg_351_0 then
				arg_348_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061actionlink/1061action423")
			end

			local var_351_14 = 0

			if var_351_14 < arg_348_1.time_ and arg_348_1.time_ <= var_351_14 + arg_351_0 then
				arg_348_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_351_15 = 0
			local var_351_16 = 0.425

			if var_351_15 < arg_348_1.time_ and arg_348_1.time_ <= var_351_15 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_17 = arg_348_1:FormatText(StoryNameCfg[612].name)

				arg_348_1.leftNameTxt_.text = var_351_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_18 = arg_348_1:GetWordFromCfg(321102084)
				local var_351_19 = arg_348_1:FormatText(var_351_18.content)

				arg_348_1.text_.text = var_351_19

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_20 = 17
				local var_351_21 = utf8.len(var_351_19)
				local var_351_22 = var_351_20 <= 0 and var_351_16 or var_351_16 * (var_351_21 / var_351_20)

				if var_351_22 > 0 and var_351_16 < var_351_22 then
					arg_348_1.talkMaxDuration = var_351_22

					if var_351_22 + var_351_15 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_22 + var_351_15
					end
				end

				arg_348_1.text_.text = var_351_19
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102084", "story_v_out_321102.awb") ~= 0 then
					local var_351_23 = manager.audio:GetVoiceLength("story_v_out_321102", "321102084", "story_v_out_321102.awb") / 1000

					if var_351_23 + var_351_15 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_23 + var_351_15
					end

					if var_351_18.prefab_name ~= "" and arg_348_1.actors_[var_351_18.prefab_name] ~= nil then
						local var_351_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_18.prefab_name].transform, "story_v_out_321102", "321102084", "story_v_out_321102.awb")

						arg_348_1:RecordAudio("321102084", var_351_24)
						arg_348_1:RecordAudio("321102084", var_351_24)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_321102", "321102084", "story_v_out_321102.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_321102", "321102084", "story_v_out_321102.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_25 = math.max(var_351_16, arg_348_1.talkMaxDuration)

			if var_351_15 <= arg_348_1.time_ and arg_348_1.time_ < var_351_15 + var_351_25 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_15) / var_351_25

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_15 + var_351_25 and arg_348_1.time_ < var_351_15 + var_351_25 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play321102085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 321102085
		arg_352_1.duration_ = 5.8

		local var_352_0 = {
			zh = 4.633,
			ja = 5.8
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
				arg_352_0:Play321102086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1061ui_story"]
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1061ui_story == nil then
				arg_352_1.var_.characterEffect1061ui_story = var_355_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_2 = 0.200000002980232

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 and not isNil(var_355_0) then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2

				if arg_352_1.var_.characterEffect1061ui_story and not isNil(var_355_0) then
					local var_355_4 = Mathf.Lerp(0, 0.5, var_355_3)

					arg_352_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1061ui_story.fillRatio = var_355_4
				end
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 and not isNil(var_355_0) and arg_352_1.var_.characterEffect1061ui_story then
				local var_355_5 = 0.5

				arg_352_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1061ui_story.fillRatio = var_355_5
			end

			local var_355_6 = 0
			local var_355_7 = 0.575

			if var_355_6 < arg_352_1.time_ and arg_352_1.time_ <= var_355_6 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_8 = arg_352_1:FormatText(StoryNameCfg[1176].name)

				arg_352_1.leftNameTxt_.text = var_355_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, true)
				arg_352_1.iconController_:SetSelectedState("hero")

				arg_352_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_352_1.callingController_:SetSelectedState("normal")

				arg_352_1.keyicon_.color = Color.New(1, 1, 1)
				arg_352_1.icon_.color = Color.New(1, 1, 1)

				local var_355_9 = arg_352_1:GetWordFromCfg(321102085)
				local var_355_10 = arg_352_1:FormatText(var_355_9.content)

				arg_352_1.text_.text = var_355_10

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_11 = 23
				local var_355_12 = utf8.len(var_355_10)
				local var_355_13 = var_355_11 <= 0 and var_355_7 or var_355_7 * (var_355_12 / var_355_11)

				if var_355_13 > 0 and var_355_7 < var_355_13 then
					arg_352_1.talkMaxDuration = var_355_13

					if var_355_13 + var_355_6 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_13 + var_355_6
					end
				end

				arg_352_1.text_.text = var_355_10
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102085", "story_v_out_321102.awb") ~= 0 then
					local var_355_14 = manager.audio:GetVoiceLength("story_v_out_321102", "321102085", "story_v_out_321102.awb") / 1000

					if var_355_14 + var_355_6 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_14 + var_355_6
					end

					if var_355_9.prefab_name ~= "" and arg_352_1.actors_[var_355_9.prefab_name] ~= nil then
						local var_355_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_9.prefab_name].transform, "story_v_out_321102", "321102085", "story_v_out_321102.awb")

						arg_352_1:RecordAudio("321102085", var_355_15)
						arg_352_1:RecordAudio("321102085", var_355_15)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_321102", "321102085", "story_v_out_321102.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_321102", "321102085", "story_v_out_321102.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_16 = math.max(var_355_7, arg_352_1.talkMaxDuration)

			if var_355_6 <= arg_352_1.time_ and arg_352_1.time_ < var_355_6 + var_355_16 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_6) / var_355_16

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_6 + var_355_16 and arg_352_1.time_ < var_355_6 + var_355_16 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play321102086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 321102086
		arg_356_1.duration_ = 11.1

		local var_356_0 = {
			zh = 7.466,
			ja = 11.1
		}
		local var_356_1 = manager.audio:GetLocalizationFlag()

		if var_356_0[var_356_1] ~= nil then
			arg_356_1.duration_ = var_356_0[var_356_1]
		end

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play321102087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 0
			local var_359_1 = 0.925

			if var_359_0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, true)

				local var_359_2 = arg_356_1:FormatText(StoryNameCfg[1176].name)

				arg_356_1.leftNameTxt_.text = var_359_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_356_1.leftNameTxt_.transform)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1.leftNameTxt_.text)
				SetActive(arg_356_1.iconTrs_.gameObject, true)
				arg_356_1.iconController_:SetSelectedState("hero")

				arg_356_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_356_1.callingController_:SetSelectedState("normal")

				arg_356_1.keyicon_.color = Color.New(1, 1, 1)
				arg_356_1.icon_.color = Color.New(1, 1, 1)

				local var_359_3 = arg_356_1:GetWordFromCfg(321102086)
				local var_359_4 = arg_356_1:FormatText(var_359_3.content)

				arg_356_1.text_.text = var_359_4

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_5 = 37
				local var_359_6 = utf8.len(var_359_4)
				local var_359_7 = var_359_5 <= 0 and var_359_1 or var_359_1 * (var_359_6 / var_359_5)

				if var_359_7 > 0 and var_359_1 < var_359_7 then
					arg_356_1.talkMaxDuration = var_359_7

					if var_359_7 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_7 + var_359_0
					end
				end

				arg_356_1.text_.text = var_359_4
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102086", "story_v_out_321102.awb") ~= 0 then
					local var_359_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102086", "story_v_out_321102.awb") / 1000

					if var_359_8 + var_359_0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_8 + var_359_0
					end

					if var_359_3.prefab_name ~= "" and arg_356_1.actors_[var_359_3.prefab_name] ~= nil then
						local var_359_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_356_1.actors_[var_359_3.prefab_name].transform, "story_v_out_321102", "321102086", "story_v_out_321102.awb")

						arg_356_1:RecordAudio("321102086", var_359_9)
						arg_356_1:RecordAudio("321102086", var_359_9)
					else
						arg_356_1:AudioAction("play", "voice", "story_v_out_321102", "321102086", "story_v_out_321102.awb")
					end

					arg_356_1:RecordHistoryTalkVoice("story_v_out_321102", "321102086", "story_v_out_321102.awb")
				end

				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_10 = math.max(var_359_1, arg_356_1.talkMaxDuration)

			if var_359_0 <= arg_356_1.time_ and arg_356_1.time_ < var_359_0 + var_359_10 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_0) / var_359_10

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_0 + var_359_10 and arg_356_1.time_ < var_359_0 + var_359_10 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play321102087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 321102087
		arg_360_1.duration_ = 8.1

		local var_360_0 = {
			zh = 4.066,
			ja = 8.1
		}
		local var_360_1 = manager.audio:GetLocalizationFlag()

		if var_360_0[var_360_1] ~= nil then
			arg_360_1.duration_ = var_360_0[var_360_1]
		end

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play321102088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = arg_360_1.actors_["1061ui_story"].transform
			local var_363_1 = 0

			if var_363_1 < arg_360_1.time_ and arg_360_1.time_ <= var_363_1 + arg_363_0 then
				arg_360_1.var_.moveOldPos1061ui_story = var_363_0.localPosition
			end

			local var_363_2 = 0.001

			if var_363_1 <= arg_360_1.time_ and arg_360_1.time_ < var_363_1 + var_363_2 then
				local var_363_3 = (arg_360_1.time_ - var_363_1) / var_363_2
				local var_363_4 = Vector3.New(0, -1.18, -6.15)

				var_363_0.localPosition = Vector3.Lerp(arg_360_1.var_.moveOldPos1061ui_story, var_363_4, var_363_3)

				local var_363_5 = manager.ui.mainCamera.transform.position - var_363_0.position

				var_363_0.forward = Vector3.New(var_363_5.x, var_363_5.y, var_363_5.z)

				local var_363_6 = var_363_0.localEulerAngles

				var_363_6.z = 0
				var_363_6.x = 0
				var_363_0.localEulerAngles = var_363_6
			end

			if arg_360_1.time_ >= var_363_1 + var_363_2 and arg_360_1.time_ < var_363_1 + var_363_2 + arg_363_0 then
				var_363_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_363_7 = manager.ui.mainCamera.transform.position - var_363_0.position

				var_363_0.forward = Vector3.New(var_363_7.x, var_363_7.y, var_363_7.z)

				local var_363_8 = var_363_0.localEulerAngles

				var_363_8.z = 0
				var_363_8.x = 0
				var_363_0.localEulerAngles = var_363_8
			end

			local var_363_9 = arg_360_1.actors_["1061ui_story"]
			local var_363_10 = 0

			if var_363_10 < arg_360_1.time_ and arg_360_1.time_ <= var_363_10 + arg_363_0 and not isNil(var_363_9) and arg_360_1.var_.characterEffect1061ui_story == nil then
				arg_360_1.var_.characterEffect1061ui_story = var_363_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_363_11 = 0.200000002980232

			if var_363_10 <= arg_360_1.time_ and arg_360_1.time_ < var_363_10 + var_363_11 and not isNil(var_363_9) then
				local var_363_12 = (arg_360_1.time_ - var_363_10) / var_363_11

				if arg_360_1.var_.characterEffect1061ui_story and not isNil(var_363_9) then
					arg_360_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_360_1.time_ >= var_363_10 + var_363_11 and arg_360_1.time_ < var_363_10 + var_363_11 + arg_363_0 and not isNil(var_363_9) and arg_360_1.var_.characterEffect1061ui_story then
				arg_360_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_363_13 = 0

			if var_363_13 < arg_360_1.time_ and arg_360_1.time_ <= var_363_13 + arg_363_0 then
				arg_360_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_363_14 = 0

			if var_363_14 < arg_360_1.time_ and arg_360_1.time_ <= var_363_14 + arg_363_0 then
				arg_360_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_363_15 = 0
			local var_363_16 = 0.525

			if var_363_15 < arg_360_1.time_ and arg_360_1.time_ <= var_363_15 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, true)

				local var_363_17 = arg_360_1:FormatText(StoryNameCfg[612].name)

				arg_360_1.leftNameTxt_.text = var_363_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_360_1.leftNameTxt_.transform)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1.leftNameTxt_.text)
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_18 = arg_360_1:GetWordFromCfg(321102087)
				local var_363_19 = arg_360_1:FormatText(var_363_18.content)

				arg_360_1.text_.text = var_363_19

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_20 = 21
				local var_363_21 = utf8.len(var_363_19)
				local var_363_22 = var_363_20 <= 0 and var_363_16 or var_363_16 * (var_363_21 / var_363_20)

				if var_363_22 > 0 and var_363_16 < var_363_22 then
					arg_360_1.talkMaxDuration = var_363_22

					if var_363_22 + var_363_15 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_22 + var_363_15
					end
				end

				arg_360_1.text_.text = var_363_19
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102087", "story_v_out_321102.awb") ~= 0 then
					local var_363_23 = manager.audio:GetVoiceLength("story_v_out_321102", "321102087", "story_v_out_321102.awb") / 1000

					if var_363_23 + var_363_15 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_23 + var_363_15
					end

					if var_363_18.prefab_name ~= "" and arg_360_1.actors_[var_363_18.prefab_name] ~= nil then
						local var_363_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_360_1.actors_[var_363_18.prefab_name].transform, "story_v_out_321102", "321102087", "story_v_out_321102.awb")

						arg_360_1:RecordAudio("321102087", var_363_24)
						arg_360_1:RecordAudio("321102087", var_363_24)
					else
						arg_360_1:AudioAction("play", "voice", "story_v_out_321102", "321102087", "story_v_out_321102.awb")
					end

					arg_360_1:RecordHistoryTalkVoice("story_v_out_321102", "321102087", "story_v_out_321102.awb")
				end

				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_25 = math.max(var_363_16, arg_360_1.talkMaxDuration)

			if var_363_15 <= arg_360_1.time_ and arg_360_1.time_ < var_363_15 + var_363_25 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_15) / var_363_25

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_15 + var_363_25 and arg_360_1.time_ < var_363_15 + var_363_25 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_360_1:InitPlayNodeList()
	end,
	Play321102088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 321102088
		arg_364_1.duration_ = 9.1

		local var_364_0 = {
			zh = 6.133,
			ja = 9.1
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
				arg_364_0:Play321102089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = arg_364_1.actors_["1061ui_story"]
			local var_367_1 = 0

			if var_367_1 < arg_364_1.time_ and arg_364_1.time_ <= var_367_1 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect1061ui_story == nil then
				arg_364_1.var_.characterEffect1061ui_story = var_367_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_367_2 = 0.200000002980232

			if var_367_1 <= arg_364_1.time_ and arg_364_1.time_ < var_367_1 + var_367_2 and not isNil(var_367_0) then
				local var_367_3 = (arg_364_1.time_ - var_367_1) / var_367_2

				if arg_364_1.var_.characterEffect1061ui_story and not isNil(var_367_0) then
					local var_367_4 = Mathf.Lerp(0, 0.5, var_367_3)

					arg_364_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_364_1.var_.characterEffect1061ui_story.fillRatio = var_367_4
				end
			end

			if arg_364_1.time_ >= var_367_1 + var_367_2 and arg_364_1.time_ < var_367_1 + var_367_2 + arg_367_0 and not isNil(var_367_0) and arg_364_1.var_.characterEffect1061ui_story then
				local var_367_5 = 0.5

				arg_364_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_364_1.var_.characterEffect1061ui_story.fillRatio = var_367_5
			end

			local var_367_6 = 0
			local var_367_7 = 0.825

			if var_367_6 < arg_364_1.time_ and arg_364_1.time_ <= var_367_6 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				local var_367_8 = arg_364_1:FormatText(StoryNameCfg[1176].name)

				arg_364_1.leftNameTxt_.text = var_367_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, true)
				arg_364_1.iconController_:SetSelectedState("hero")

				arg_364_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_364_1.callingController_:SetSelectedState("normal")

				arg_364_1.keyicon_.color = Color.New(1, 1, 1)
				arg_364_1.icon_.color = Color.New(1, 1, 1)

				local var_367_9 = arg_364_1:GetWordFromCfg(321102088)
				local var_367_10 = arg_364_1:FormatText(var_367_9.content)

				arg_364_1.text_.text = var_367_10

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_11 = 33
				local var_367_12 = utf8.len(var_367_10)
				local var_367_13 = var_367_11 <= 0 and var_367_7 or var_367_7 * (var_367_12 / var_367_11)

				if var_367_13 > 0 and var_367_7 < var_367_13 then
					arg_364_1.talkMaxDuration = var_367_13

					if var_367_13 + var_367_6 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_13 + var_367_6
					end
				end

				arg_364_1.text_.text = var_367_10
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102088", "story_v_out_321102.awb") ~= 0 then
					local var_367_14 = manager.audio:GetVoiceLength("story_v_out_321102", "321102088", "story_v_out_321102.awb") / 1000

					if var_367_14 + var_367_6 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_14 + var_367_6
					end

					if var_367_9.prefab_name ~= "" and arg_364_1.actors_[var_367_9.prefab_name] ~= nil then
						local var_367_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_9.prefab_name].transform, "story_v_out_321102", "321102088", "story_v_out_321102.awb")

						arg_364_1:RecordAudio("321102088", var_367_15)
						arg_364_1:RecordAudio("321102088", var_367_15)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_321102", "321102088", "story_v_out_321102.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_321102", "321102088", "story_v_out_321102.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_16 = math.max(var_367_7, arg_364_1.talkMaxDuration)

			if var_367_6 <= arg_364_1.time_ and arg_364_1.time_ < var_367_6 + var_367_16 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_6) / var_367_16

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_6 + var_367_16 and arg_364_1.time_ < var_367_6 + var_367_16 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play321102089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 321102089
		arg_368_1.duration_ = 9.07

		local var_368_0 = {
			zh = 5.6,
			ja = 9.066
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
				arg_368_0:Play321102090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 0.65

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				local var_371_2 = arg_368_1:FormatText(StoryNameCfg[1176].name)

				arg_368_1.leftNameTxt_.text = var_371_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, true)
				arg_368_1.iconController_:SetSelectedState("hero")

				arg_368_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_368_1.callingController_:SetSelectedState("normal")

				arg_368_1.keyicon_.color = Color.New(1, 1, 1)
				arg_368_1.icon_.color = Color.New(1, 1, 1)

				local var_371_3 = arg_368_1:GetWordFromCfg(321102089)
				local var_371_4 = arg_368_1:FormatText(var_371_3.content)

				arg_368_1.text_.text = var_371_4

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_5 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102089", "story_v_out_321102.awb") ~= 0 then
					local var_371_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102089", "story_v_out_321102.awb") / 1000

					if var_371_8 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_8 + var_371_0
					end

					if var_371_3.prefab_name ~= "" and arg_368_1.actors_[var_371_3.prefab_name] ~= nil then
						local var_371_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_3.prefab_name].transform, "story_v_out_321102", "321102089", "story_v_out_321102.awb")

						arg_368_1:RecordAudio("321102089", var_371_9)
						arg_368_1:RecordAudio("321102089", var_371_9)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_321102", "321102089", "story_v_out_321102.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_321102", "321102089", "story_v_out_321102.awb")
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
	Play321102090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 321102090
		arg_372_1.duration_ = 3.77

		local var_372_0 = {
			zh = 2.233,
			ja = 3.766
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
				arg_372_0:Play321102091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["1061ui_story"].transform
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.var_.moveOldPos1061ui_story = var_375_0.localPosition
			end

			local var_375_2 = 0.001

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2
				local var_375_4 = Vector3.New(0, -1.18, -6.15)

				var_375_0.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos1061ui_story, var_375_4, var_375_3)

				local var_375_5 = manager.ui.mainCamera.transform.position - var_375_0.position

				var_375_0.forward = Vector3.New(var_375_5.x, var_375_5.y, var_375_5.z)

				local var_375_6 = var_375_0.localEulerAngles

				var_375_6.z = 0
				var_375_6.x = 0
				var_375_0.localEulerAngles = var_375_6
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 then
				var_375_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_375_7 = manager.ui.mainCamera.transform.position - var_375_0.position

				var_375_0.forward = Vector3.New(var_375_7.x, var_375_7.y, var_375_7.z)

				local var_375_8 = var_375_0.localEulerAngles

				var_375_8.z = 0
				var_375_8.x = 0
				var_375_0.localEulerAngles = var_375_8
			end

			local var_375_9 = arg_372_1.actors_["1061ui_story"]
			local var_375_10 = 0

			if var_375_10 < arg_372_1.time_ and arg_372_1.time_ <= var_375_10 + arg_375_0 and not isNil(var_375_9) and arg_372_1.var_.characterEffect1061ui_story == nil then
				arg_372_1.var_.characterEffect1061ui_story = var_375_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_11 = 0.200000002980232

			if var_375_10 <= arg_372_1.time_ and arg_372_1.time_ < var_375_10 + var_375_11 and not isNil(var_375_9) then
				local var_375_12 = (arg_372_1.time_ - var_375_10) / var_375_11

				if arg_372_1.var_.characterEffect1061ui_story and not isNil(var_375_9) then
					arg_372_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= var_375_10 + var_375_11 and arg_372_1.time_ < var_375_10 + var_375_11 + arg_375_0 and not isNil(var_375_9) and arg_372_1.var_.characterEffect1061ui_story then
				arg_372_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_375_13 = 0

			if var_375_13 < arg_372_1.time_ and arg_372_1.time_ <= var_375_13 + arg_375_0 then
				arg_372_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			local var_375_14 = 0

			if var_375_14 < arg_372_1.time_ and arg_372_1.time_ <= var_375_14 + arg_375_0 then
				arg_372_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva", "EmotionTimelineAnimator")
			end

			local var_375_15 = 0
			local var_375_16 = 0.3

			if var_375_15 < arg_372_1.time_ and arg_372_1.time_ <= var_375_15 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_17 = arg_372_1:FormatText(StoryNameCfg[612].name)

				arg_372_1.leftNameTxt_.text = var_375_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_18 = arg_372_1:GetWordFromCfg(321102090)
				local var_375_19 = arg_372_1:FormatText(var_375_18.content)

				arg_372_1.text_.text = var_375_19

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_20 = 12
				local var_375_21 = utf8.len(var_375_19)
				local var_375_22 = var_375_20 <= 0 and var_375_16 or var_375_16 * (var_375_21 / var_375_20)

				if var_375_22 > 0 and var_375_16 < var_375_22 then
					arg_372_1.talkMaxDuration = var_375_22

					if var_375_22 + var_375_15 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_22 + var_375_15
					end
				end

				arg_372_1.text_.text = var_375_19
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102090", "story_v_out_321102.awb") ~= 0 then
					local var_375_23 = manager.audio:GetVoiceLength("story_v_out_321102", "321102090", "story_v_out_321102.awb") / 1000

					if var_375_23 + var_375_15 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_23 + var_375_15
					end

					if var_375_18.prefab_name ~= "" and arg_372_1.actors_[var_375_18.prefab_name] ~= nil then
						local var_375_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_18.prefab_name].transform, "story_v_out_321102", "321102090", "story_v_out_321102.awb")

						arg_372_1:RecordAudio("321102090", var_375_24)
						arg_372_1:RecordAudio("321102090", var_375_24)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_321102", "321102090", "story_v_out_321102.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_321102", "321102090", "story_v_out_321102.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_25 = math.max(var_375_16, arg_372_1.talkMaxDuration)

			if var_375_15 <= arg_372_1.time_ and arg_372_1.time_ < var_375_15 + var_375_25 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_15) / var_375_25

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_15 + var_375_25 and arg_372_1.time_ < var_375_15 + var_375_25 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play321102091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 321102091
		arg_376_1.duration_ = 9.13

		local var_376_0 = {
			zh = 7.6,
			ja = 9.133
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
				arg_376_0:Play321102092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["1061ui_story"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect1061ui_story == nil then
				arg_376_1.var_.characterEffect1061ui_story = var_379_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.200000002980232

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.characterEffect1061ui_story and not isNil(var_379_0) then
					local var_379_4 = Mathf.Lerp(0, 0.5, var_379_3)

					arg_376_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_376_1.var_.characterEffect1061ui_story.fillRatio = var_379_4
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect1061ui_story then
				local var_379_5 = 0.5

				arg_376_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_376_1.var_.characterEffect1061ui_story.fillRatio = var_379_5
			end

			local var_379_6 = 0
			local var_379_7 = 1.025

			if var_379_6 < arg_376_1.time_ and arg_376_1.time_ <= var_379_6 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_8 = arg_376_1:FormatText(StoryNameCfg[1176].name)

				arg_376_1.leftNameTxt_.text = var_379_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_9 = arg_376_1:GetWordFromCfg(321102091)
				local var_379_10 = arg_376_1:FormatText(var_379_9.content)

				arg_376_1.text_.text = var_379_10

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_11 = 41
				local var_379_12 = utf8.len(var_379_10)
				local var_379_13 = var_379_11 <= 0 and var_379_7 or var_379_7 * (var_379_12 / var_379_11)

				if var_379_13 > 0 and var_379_7 < var_379_13 then
					arg_376_1.talkMaxDuration = var_379_13

					if var_379_13 + var_379_6 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_13 + var_379_6
					end
				end

				arg_376_1.text_.text = var_379_10
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102091", "story_v_out_321102.awb") ~= 0 then
					local var_379_14 = manager.audio:GetVoiceLength("story_v_out_321102", "321102091", "story_v_out_321102.awb") / 1000

					if var_379_14 + var_379_6 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_14 + var_379_6
					end

					if var_379_9.prefab_name ~= "" and arg_376_1.actors_[var_379_9.prefab_name] ~= nil then
						local var_379_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_9.prefab_name].transform, "story_v_out_321102", "321102091", "story_v_out_321102.awb")

						arg_376_1:RecordAudio("321102091", var_379_15)
						arg_376_1:RecordAudio("321102091", var_379_15)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_321102", "321102091", "story_v_out_321102.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_321102", "321102091", "story_v_out_321102.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_16 = math.max(var_379_7, arg_376_1.talkMaxDuration)

			if var_379_6 <= arg_376_1.time_ and arg_376_1.time_ < var_379_6 + var_379_16 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_6) / var_379_16

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_6 + var_379_16 and arg_376_1.time_ < var_379_6 + var_379_16 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play321102092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 321102092
		arg_380_1.duration_ = 4.5

		local var_380_0 = {
			zh = 2.866,
			ja = 4.5
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play321102093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0
			local var_383_1 = 0.3

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_2 = arg_380_1:FormatText(StoryNameCfg[1176].name)

				arg_380_1.leftNameTxt_.text = var_383_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, true)
				arg_380_1.iconController_:SetSelectedState("hero")

				arg_380_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bernard")

				arg_380_1.callingController_:SetSelectedState("normal")

				arg_380_1.keyicon_.color = Color.New(1, 1, 1)
				arg_380_1.icon_.color = Color.New(1, 1, 1)

				local var_383_3 = arg_380_1:GetWordFromCfg(321102092)
				local var_383_4 = arg_380_1:FormatText(var_383_3.content)

				arg_380_1.text_.text = var_383_4

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_5 = 12
				local var_383_6 = utf8.len(var_383_4)
				local var_383_7 = var_383_5 <= 0 and var_383_1 or var_383_1 * (var_383_6 / var_383_5)

				if var_383_7 > 0 and var_383_1 < var_383_7 then
					arg_380_1.talkMaxDuration = var_383_7

					if var_383_7 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_7 + var_383_0
					end
				end

				arg_380_1.text_.text = var_383_4
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102092", "story_v_out_321102.awb") ~= 0 then
					local var_383_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102092", "story_v_out_321102.awb") / 1000

					if var_383_8 + var_383_0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_8 + var_383_0
					end

					if var_383_3.prefab_name ~= "" and arg_380_1.actors_[var_383_3.prefab_name] ~= nil then
						local var_383_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_3.prefab_name].transform, "story_v_out_321102", "321102092", "story_v_out_321102.awb")

						arg_380_1:RecordAudio("321102092", var_383_9)
						arg_380_1:RecordAudio("321102092", var_383_9)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_321102", "321102092", "story_v_out_321102.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_321102", "321102092", "story_v_out_321102.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_10 = math.max(var_383_1, arg_380_1.talkMaxDuration)

			if var_383_0 <= arg_380_1.time_ and arg_380_1.time_ < var_383_0 + var_383_10 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_0) / var_383_10

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_0 + var_383_10 and arg_380_1.time_ < var_383_0 + var_383_10 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play321102093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 321102093
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play321102094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["1061ui_story"].transform
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 then
				arg_384_1.var_.moveOldPos1061ui_story = var_387_0.localPosition
			end

			local var_387_2 = 0.001

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2
				local var_387_4 = Vector3.New(0, 100, 0)

				var_387_0.localPosition = Vector3.Lerp(arg_384_1.var_.moveOldPos1061ui_story, var_387_4, var_387_3)

				local var_387_5 = manager.ui.mainCamera.transform.position - var_387_0.position

				var_387_0.forward = Vector3.New(var_387_5.x, var_387_5.y, var_387_5.z)

				local var_387_6 = var_387_0.localEulerAngles

				var_387_6.z = 0
				var_387_6.x = 0
				var_387_0.localEulerAngles = var_387_6
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 then
				var_387_0.localPosition = Vector3.New(0, 100, 0)

				local var_387_7 = manager.ui.mainCamera.transform.position - var_387_0.position

				var_387_0.forward = Vector3.New(var_387_7.x, var_387_7.y, var_387_7.z)

				local var_387_8 = var_387_0.localEulerAngles

				var_387_8.z = 0
				var_387_8.x = 0
				var_387_0.localEulerAngles = var_387_8
			end

			local var_387_9 = 1
			local var_387_10 = 1

			if var_387_9 < arg_384_1.time_ and arg_384_1.time_ <= var_387_9 + arg_387_0 then
				local var_387_11 = "play"
				local var_387_12 = "effect"

				arg_384_1:AudioAction(var_387_11, var_387_12, "se_story_1311", "se_story_1311_ui", "")
			end

			local var_387_13 = 0
			local var_387_14 = 1.05

			if var_387_13 < arg_384_1.time_ and arg_384_1.time_ <= var_387_13 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, false)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_15 = arg_384_1:GetWordFromCfg(321102093)
				local var_387_16 = arg_384_1:FormatText(var_387_15.content)

				arg_384_1.text_.text = var_387_16

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_17 = 42
				local var_387_18 = utf8.len(var_387_16)
				local var_387_19 = var_387_17 <= 0 and var_387_14 or var_387_14 * (var_387_18 / var_387_17)

				if var_387_19 > 0 and var_387_14 < var_387_19 then
					arg_384_1.talkMaxDuration = var_387_19

					if var_387_19 + var_387_13 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_19 + var_387_13
					end
				end

				arg_384_1.text_.text = var_387_16
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_20 = math.max(var_387_14, arg_384_1.talkMaxDuration)

			if var_387_13 <= arg_384_1.time_ and arg_384_1.time_ < var_387_13 + var_387_20 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_13) / var_387_20

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_13 + var_387_20 and arg_384_1.time_ < var_387_13 + var_387_20 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_384_1:InitPlayNodeList()
	end,
	Play321102094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 321102094
		arg_388_1.duration_ = 16.5

		local var_388_0 = {
			zh = 11.333,
			ja = 16.5
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
				arg_388_0:Play321102095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1061ui_story"].transform
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.var_.moveOldPos1061ui_story = var_391_0.localPosition
			end

			local var_391_2 = 0.001

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2
				local var_391_4 = Vector3.New(0, -1.18, -6.15)

				var_391_0.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1061ui_story, var_391_4, var_391_3)

				local var_391_5 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_5.x, var_391_5.y, var_391_5.z)

				local var_391_6 = var_391_0.localEulerAngles

				var_391_6.z = 0
				var_391_6.x = 0
				var_391_0.localEulerAngles = var_391_6
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 then
				var_391_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_391_7 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_7.x, var_391_7.y, var_391_7.z)

				local var_391_8 = var_391_0.localEulerAngles

				var_391_8.z = 0
				var_391_8.x = 0
				var_391_0.localEulerAngles = var_391_8
			end

			local var_391_9 = arg_388_1.actors_["1061ui_story"]
			local var_391_10 = 0

			if var_391_10 < arg_388_1.time_ and arg_388_1.time_ <= var_391_10 + arg_391_0 and not isNil(var_391_9) and arg_388_1.var_.characterEffect1061ui_story == nil then
				arg_388_1.var_.characterEffect1061ui_story = var_391_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_391_11 = 0.200000002980232

			if var_391_10 <= arg_388_1.time_ and arg_388_1.time_ < var_391_10 + var_391_11 and not isNil(var_391_9) then
				local var_391_12 = (arg_388_1.time_ - var_391_10) / var_391_11

				if arg_388_1.var_.characterEffect1061ui_story and not isNil(var_391_9) then
					arg_388_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_388_1.time_ >= var_391_10 + var_391_11 and arg_388_1.time_ < var_391_10 + var_391_11 + arg_391_0 and not isNil(var_391_9) and arg_388_1.var_.characterEffect1061ui_story then
				arg_388_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_391_13 = 0

			if var_391_13 < arg_388_1.time_ and arg_388_1.time_ <= var_391_13 + arg_391_0 then
				arg_388_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			local var_391_14 = 0

			if var_391_14 < arg_388_1.time_ and arg_388_1.time_ <= var_391_14 + arg_391_0 then
				arg_388_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_391_15 = 0
			local var_391_16 = 1.5

			if var_391_15 < arg_388_1.time_ and arg_388_1.time_ <= var_391_15 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_17 = arg_388_1:FormatText(StoryNameCfg[612].name)

				arg_388_1.leftNameTxt_.text = var_391_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_18 = arg_388_1:GetWordFromCfg(321102094)
				local var_391_19 = arg_388_1:FormatText(var_391_18.content)

				arg_388_1.text_.text = var_391_19

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_20 = 60
				local var_391_21 = utf8.len(var_391_19)
				local var_391_22 = var_391_20 <= 0 and var_391_16 or var_391_16 * (var_391_21 / var_391_20)

				if var_391_22 > 0 and var_391_16 < var_391_22 then
					arg_388_1.talkMaxDuration = var_391_22

					if var_391_22 + var_391_15 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_22 + var_391_15
					end
				end

				arg_388_1.text_.text = var_391_19
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102094", "story_v_out_321102.awb") ~= 0 then
					local var_391_23 = manager.audio:GetVoiceLength("story_v_out_321102", "321102094", "story_v_out_321102.awb") / 1000

					if var_391_23 + var_391_15 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_23 + var_391_15
					end

					if var_391_18.prefab_name ~= "" and arg_388_1.actors_[var_391_18.prefab_name] ~= nil then
						local var_391_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_18.prefab_name].transform, "story_v_out_321102", "321102094", "story_v_out_321102.awb")

						arg_388_1:RecordAudio("321102094", var_391_24)
						arg_388_1:RecordAudio("321102094", var_391_24)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_321102", "321102094", "story_v_out_321102.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_321102", "321102094", "story_v_out_321102.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_25 = math.max(var_391_16, arg_388_1.talkMaxDuration)

			if var_391_15 <= arg_388_1.time_ and arg_388_1.time_ < var_391_15 + var_391_25 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_15) / var_391_25

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_15 + var_391_25 and arg_388_1.time_ < var_391_15 + var_391_25 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_388_1:InitPlayNodeList()
	end,
	Play321102095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 321102095
		arg_392_1.duration_ = 9.93

		local var_392_0 = {
			zh = 6.1,
			ja = 9.933
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
				arg_392_0:Play321102096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1061ui_story"].transform
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.var_.moveOldPos1061ui_story = var_395_0.localPosition
			end

			local var_395_2 = 0.001

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2
				local var_395_4 = Vector3.New(0, -1.18, -6.15)

				var_395_0.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1061ui_story, var_395_4, var_395_3)

				local var_395_5 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_5.x, var_395_5.y, var_395_5.z)

				local var_395_6 = var_395_0.localEulerAngles

				var_395_6.z = 0
				var_395_6.x = 0
				var_395_0.localEulerAngles = var_395_6
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 then
				var_395_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_395_7 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_7.x, var_395_7.y, var_395_7.z)

				local var_395_8 = var_395_0.localEulerAngles

				var_395_8.z = 0
				var_395_8.x = 0
				var_395_0.localEulerAngles = var_395_8
			end

			local var_395_9 = 0
			local var_395_10 = 0.8

			if var_395_9 < arg_392_1.time_ and arg_392_1.time_ <= var_395_9 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_11 = arg_392_1:FormatText(StoryNameCfg[612].name)

				arg_392_1.leftNameTxt_.text = var_395_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_12 = arg_392_1:GetWordFromCfg(321102095)
				local var_395_13 = arg_392_1:FormatText(var_395_12.content)

				arg_392_1.text_.text = var_395_13

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_14 = 32
				local var_395_15 = utf8.len(var_395_13)
				local var_395_16 = var_395_14 <= 0 and var_395_10 or var_395_10 * (var_395_15 / var_395_14)

				if var_395_16 > 0 and var_395_10 < var_395_16 then
					arg_392_1.talkMaxDuration = var_395_16

					if var_395_16 + var_395_9 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_16 + var_395_9
					end
				end

				arg_392_1.text_.text = var_395_13
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102095", "story_v_out_321102.awb") ~= 0 then
					local var_395_17 = manager.audio:GetVoiceLength("story_v_out_321102", "321102095", "story_v_out_321102.awb") / 1000

					if var_395_17 + var_395_9 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_17 + var_395_9
					end

					if var_395_12.prefab_name ~= "" and arg_392_1.actors_[var_395_12.prefab_name] ~= nil then
						local var_395_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_12.prefab_name].transform, "story_v_out_321102", "321102095", "story_v_out_321102.awb")

						arg_392_1:RecordAudio("321102095", var_395_18)
						arg_392_1:RecordAudio("321102095", var_395_18)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_321102", "321102095", "story_v_out_321102.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_321102", "321102095", "story_v_out_321102.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_19 = math.max(var_395_10, arg_392_1.talkMaxDuration)

			if var_395_9 <= arg_392_1.time_ and arg_392_1.time_ < var_395_9 + var_395_19 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_9) / var_395_19

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_9 + var_395_19 and arg_392_1.time_ < var_395_9 + var_395_19 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_392_1:InitPlayNodeList()
	end,
	Play321102096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 321102096
		arg_396_1.duration_ = 10.77

		local var_396_0 = {
			zh = 7.133,
			ja = 10.766
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
				arg_396_0:Play321102097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0
			local var_399_1 = 0.875

			if var_399_0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_2 = arg_396_1:FormatText(StoryNameCfg[612].name)

				arg_396_1.leftNameTxt_.text = var_399_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_3 = arg_396_1:GetWordFromCfg(321102096)
				local var_399_4 = arg_396_1:FormatText(var_399_3.content)

				arg_396_1.text_.text = var_399_4

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_5 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102096", "story_v_out_321102.awb") ~= 0 then
					local var_399_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102096", "story_v_out_321102.awb") / 1000

					if var_399_8 + var_399_0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_8 + var_399_0
					end

					if var_399_3.prefab_name ~= "" and arg_396_1.actors_[var_399_3.prefab_name] ~= nil then
						local var_399_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_3.prefab_name].transform, "story_v_out_321102", "321102096", "story_v_out_321102.awb")

						arg_396_1:RecordAudio("321102096", var_399_9)
						arg_396_1:RecordAudio("321102096", var_399_9)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_321102", "321102096", "story_v_out_321102.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_321102", "321102096", "story_v_out_321102.awb")
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
	Play321102097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 321102097
		arg_400_1.duration_ = 7.47

		local var_400_0 = {
			zh = 7.466,
			ja = 6.2
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
				arg_400_0:Play321102098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = "ST0505a"

			if arg_400_1.bgs_[var_403_0] == nil then
				local var_403_1 = Object.Instantiate(arg_400_1.paintGo_)

				var_403_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_403_0)
				var_403_1.name = var_403_0
				var_403_1.transform.parent = arg_400_1.stage_.transform
				var_403_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_400_1.bgs_[var_403_0] = var_403_1
			end

			local var_403_2 = 2

			if var_403_2 < arg_400_1.time_ and arg_400_1.time_ <= var_403_2 + arg_403_0 then
				local var_403_3 = manager.ui.mainCamera.transform.localPosition
				local var_403_4 = Vector3.New(0, 0, 10) + Vector3.New(var_403_3.x, var_403_3.y, 0)
				local var_403_5 = arg_400_1.bgs_.ST0505a

				var_403_5.transform.localPosition = var_403_4
				var_403_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_403_6 = var_403_5:GetComponent("SpriteRenderer")

				if var_403_6 and var_403_6.sprite then
					local var_403_7 = (var_403_5.transform.localPosition - var_403_3).z
					local var_403_8 = manager.ui.mainCameraCom_
					local var_403_9 = 2 * var_403_7 * Mathf.Tan(var_403_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_403_10 = var_403_9 * var_403_8.aspect
					local var_403_11 = var_403_6.sprite.bounds.size.x
					local var_403_12 = var_403_6.sprite.bounds.size.y
					local var_403_13 = var_403_10 / var_403_11
					local var_403_14 = var_403_9 / var_403_12
					local var_403_15 = var_403_14 < var_403_13 and var_403_13 or var_403_14

					var_403_5.transform.localScale = Vector3.New(var_403_15, var_403_15, 0)
				end

				for iter_403_0, iter_403_1 in pairs(arg_400_1.bgs_) do
					if iter_403_0 ~= "ST0505a" then
						iter_403_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_403_16 = 4

			if var_403_16 < arg_400_1.time_ and arg_400_1.time_ <= var_403_16 + arg_403_0 then
				arg_400_1.allBtn_.enabled = false
			end

			local var_403_17 = 0.3

			if arg_400_1.time_ >= var_403_16 + var_403_17 and arg_400_1.time_ < var_403_16 + var_403_17 + arg_403_0 then
				arg_400_1.allBtn_.enabled = true
			end

			local var_403_18 = 0

			if var_403_18 < arg_400_1.time_ and arg_400_1.time_ <= var_403_18 + arg_403_0 then
				arg_400_1.mask_.enabled = true
				arg_400_1.mask_.raycastTarget = true

				arg_400_1:SetGaussion(false)
			end

			local var_403_19 = 2

			if var_403_18 <= arg_400_1.time_ and arg_400_1.time_ < var_403_18 + var_403_19 then
				local var_403_20 = (arg_400_1.time_ - var_403_18) / var_403_19
				local var_403_21 = Color.New(0, 0, 0)

				var_403_21.a = Mathf.Lerp(0, 1, var_403_20)
				arg_400_1.mask_.color = var_403_21
			end

			if arg_400_1.time_ >= var_403_18 + var_403_19 and arg_400_1.time_ < var_403_18 + var_403_19 + arg_403_0 then
				local var_403_22 = Color.New(0, 0, 0)

				var_403_22.a = 1
				arg_400_1.mask_.color = var_403_22
			end

			local var_403_23 = 2

			if var_403_23 < arg_400_1.time_ and arg_400_1.time_ <= var_403_23 + arg_403_0 then
				arg_400_1.mask_.enabled = true
				arg_400_1.mask_.raycastTarget = true

				arg_400_1:SetGaussion(false)
			end

			local var_403_24 = 2

			if var_403_23 <= arg_400_1.time_ and arg_400_1.time_ < var_403_23 + var_403_24 then
				local var_403_25 = (arg_400_1.time_ - var_403_23) / var_403_24
				local var_403_26 = Color.New(0, 0, 0)

				var_403_26.a = Mathf.Lerp(1, 0, var_403_25)
				arg_400_1.mask_.color = var_403_26
			end

			if arg_400_1.time_ >= var_403_23 + var_403_24 and arg_400_1.time_ < var_403_23 + var_403_24 + arg_403_0 then
				local var_403_27 = Color.New(0, 0, 0)
				local var_403_28 = 0

				arg_400_1.mask_.enabled = false
				var_403_27.a = var_403_28
				arg_400_1.mask_.color = var_403_27
			end

			local var_403_29 = arg_400_1.actors_["1061ui_story"].transform
			local var_403_30 = 1.96599999815226

			if var_403_30 < arg_400_1.time_ and arg_400_1.time_ <= var_403_30 + arg_403_0 then
				arg_400_1.var_.moveOldPos1061ui_story = var_403_29.localPosition
			end

			local var_403_31 = 0.001

			if var_403_30 <= arg_400_1.time_ and arg_400_1.time_ < var_403_30 + var_403_31 then
				local var_403_32 = (arg_400_1.time_ - var_403_30) / var_403_31
				local var_403_33 = Vector3.New(0, 100, 0)

				var_403_29.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1061ui_story, var_403_33, var_403_32)

				local var_403_34 = manager.ui.mainCamera.transform.position - var_403_29.position

				var_403_29.forward = Vector3.New(var_403_34.x, var_403_34.y, var_403_34.z)

				local var_403_35 = var_403_29.localEulerAngles

				var_403_35.z = 0
				var_403_35.x = 0
				var_403_29.localEulerAngles = var_403_35
			end

			if arg_400_1.time_ >= var_403_30 + var_403_31 and arg_400_1.time_ < var_403_30 + var_403_31 + arg_403_0 then
				var_403_29.localPosition = Vector3.New(0, 100, 0)

				local var_403_36 = manager.ui.mainCamera.transform.position - var_403_29.position

				var_403_29.forward = Vector3.New(var_403_36.x, var_403_36.y, var_403_36.z)

				local var_403_37 = var_403_29.localEulerAngles

				var_403_37.z = 0
				var_403_37.x = 0
				var_403_29.localEulerAngles = var_403_37
			end

			local var_403_38 = arg_400_1.actors_["1061ui_story"]
			local var_403_39 = 1.96599999815226

			if var_403_39 < arg_400_1.time_ and arg_400_1.time_ <= var_403_39 + arg_403_0 and not isNil(var_403_38) and arg_400_1.var_.characterEffect1061ui_story == nil then
				arg_400_1.var_.characterEffect1061ui_story = var_403_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_40 = 0.034000001847744

			if var_403_39 <= arg_400_1.time_ and arg_400_1.time_ < var_403_39 + var_403_40 and not isNil(var_403_38) then
				local var_403_41 = (arg_400_1.time_ - var_403_39) / var_403_40

				if arg_400_1.var_.characterEffect1061ui_story and not isNil(var_403_38) then
					local var_403_42 = Mathf.Lerp(0, 0.5, var_403_41)

					arg_400_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_400_1.var_.characterEffect1061ui_story.fillRatio = var_403_42
				end
			end

			if arg_400_1.time_ >= var_403_39 + var_403_40 and arg_400_1.time_ < var_403_39 + var_403_40 + arg_403_0 and not isNil(var_403_38) and arg_400_1.var_.characterEffect1061ui_story then
				local var_403_43 = 0.5

				arg_400_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_400_1.var_.characterEffect1061ui_story.fillRatio = var_403_43
			end

			if arg_400_1.frameCnt_ <= 1 then
				arg_400_1.dialog_:SetActive(false)
			end

			local var_403_44 = 4
			local var_403_45 = 0.3

			if var_403_44 < arg_400_1.time_ and arg_400_1.time_ <= var_403_44 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0

				arg_400_1.dialog_:SetActive(true)

				arg_400_1.dialogCg_.alpha = 0

				local var_403_46 = LeanTween.value(arg_400_1.dialog_, 0, 1, 0.3)

				var_403_46:setOnUpdate(LuaHelper.FloatAction(function(arg_404_0)
					arg_400_1.dialogCg_.alpha = arg_404_0
				end))
				var_403_46:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_400_1.dialog_)
					var_403_46:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_400_1.duration_ = arg_400_1.duration_ + 0.3

				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_47 = arg_400_1:FormatText(StoryNameCfg[672].name)

				arg_400_1.leftNameTxt_.text = var_403_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, true)
				arg_400_1.iconController_:SetSelectedState("hero")

				arg_400_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_400_1.callingController_:SetSelectedState("normal")

				arg_400_1.keyicon_.color = Color.New(1, 1, 1)
				arg_400_1.icon_.color = Color.New(1, 1, 1)

				local var_403_48 = arg_400_1:GetWordFromCfg(321102097)
				local var_403_49 = arg_400_1:FormatText(var_403_48.content)

				arg_400_1.text_.text = var_403_49

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_50 = 12
				local var_403_51 = utf8.len(var_403_49)
				local var_403_52 = var_403_50 <= 0 and var_403_45 or var_403_45 * (var_403_51 / var_403_50)

				if var_403_52 > 0 and var_403_45 < var_403_52 then
					arg_400_1.talkMaxDuration = var_403_52
					var_403_44 = var_403_44 + 0.3

					if var_403_52 + var_403_44 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_52 + var_403_44
					end
				end

				arg_400_1.text_.text = var_403_49
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102097", "story_v_out_321102.awb") ~= 0 then
					local var_403_53 = manager.audio:GetVoiceLength("story_v_out_321102", "321102097", "story_v_out_321102.awb") / 1000

					if var_403_53 + var_403_44 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_53 + var_403_44
					end

					if var_403_48.prefab_name ~= "" and arg_400_1.actors_[var_403_48.prefab_name] ~= nil then
						local var_403_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_48.prefab_name].transform, "story_v_out_321102", "321102097", "story_v_out_321102.awb")

						arg_400_1:RecordAudio("321102097", var_403_54)
						arg_400_1:RecordAudio("321102097", var_403_54)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_321102", "321102097", "story_v_out_321102.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_321102", "321102097", "story_v_out_321102.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_55 = var_403_44 + 0.3
			local var_403_56 = math.max(var_403_45, arg_400_1.talkMaxDuration)

			if var_403_55 <= arg_400_1.time_ and arg_400_1.time_ < var_403_55 + var_403_56 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_55) / var_403_56

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_55 + var_403_56 and arg_400_1.time_ < var_403_55 + var_403_56 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play321102098 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 321102098
		arg_406_1.duration_ = 6.03

		local var_406_0 = {
			zh = 5.933,
			ja = 6.033
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play321102099(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0
			local var_409_1 = 0.65

			if var_409_0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				local var_409_2 = arg_406_1:FormatText(StoryNameCfg[672].name)

				arg_406_1.leftNameTxt_.text = var_409_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_3 = arg_406_1:GetWordFromCfg(321102098)
				local var_409_4 = arg_406_1:FormatText(var_409_3.content)

				arg_406_1.text_.text = var_409_4

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_5 = 26
				local var_409_6 = utf8.len(var_409_4)
				local var_409_7 = var_409_5 <= 0 and var_409_1 or var_409_1 * (var_409_6 / var_409_5)

				if var_409_7 > 0 and var_409_1 < var_409_7 then
					arg_406_1.talkMaxDuration = var_409_7

					if var_409_7 + var_409_0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_7 + var_409_0
					end
				end

				arg_406_1.text_.text = var_409_4
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102098", "story_v_out_321102.awb") ~= 0 then
					local var_409_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102098", "story_v_out_321102.awb") / 1000

					if var_409_8 + var_409_0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_8 + var_409_0
					end

					if var_409_3.prefab_name ~= "" and arg_406_1.actors_[var_409_3.prefab_name] ~= nil then
						local var_409_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_3.prefab_name].transform, "story_v_out_321102", "321102098", "story_v_out_321102.awb")

						arg_406_1:RecordAudio("321102098", var_409_9)
						arg_406_1:RecordAudio("321102098", var_409_9)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_321102", "321102098", "story_v_out_321102.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_321102", "321102098", "story_v_out_321102.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_10 = math.max(var_409_1, arg_406_1.talkMaxDuration)

			if var_409_0 <= arg_406_1.time_ and arg_406_1.time_ < var_409_0 + var_409_10 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_0) / var_409_10

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_0 + var_409_10 and arg_406_1.time_ < var_409_0 + var_409_10 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play321102099 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 321102099
		arg_410_1.duration_ = 13.33

		local var_410_0 = {
			zh = 7.9,
			ja = 13.333
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play321102100(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			local var_413_0 = 0
			local var_413_1 = 0.85

			if var_413_0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				local var_413_2 = arg_410_1:FormatText(StoryNameCfg[672].name)

				arg_410_1.leftNameTxt_.text = var_413_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, true)
				arg_410_1.iconController_:SetSelectedState("hero")

				arg_410_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_410_1.callingController_:SetSelectedState("normal")

				arg_410_1.keyicon_.color = Color.New(1, 1, 1)
				arg_410_1.icon_.color = Color.New(1, 1, 1)

				local var_413_3 = arg_410_1:GetWordFromCfg(321102099)
				local var_413_4 = arg_410_1:FormatText(var_413_3.content)

				arg_410_1.text_.text = var_413_4

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 34
				local var_413_6 = utf8.len(var_413_4)
				local var_413_7 = var_413_5 <= 0 and var_413_1 or var_413_1 * (var_413_6 / var_413_5)

				if var_413_7 > 0 and var_413_1 < var_413_7 then
					arg_410_1.talkMaxDuration = var_413_7

					if var_413_7 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_7 + var_413_0
					end
				end

				arg_410_1.text_.text = var_413_4
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102099", "story_v_out_321102.awb") ~= 0 then
					local var_413_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102099", "story_v_out_321102.awb") / 1000

					if var_413_8 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_8 + var_413_0
					end

					if var_413_3.prefab_name ~= "" and arg_410_1.actors_[var_413_3.prefab_name] ~= nil then
						local var_413_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_3.prefab_name].transform, "story_v_out_321102", "321102099", "story_v_out_321102.awb")

						arg_410_1:RecordAudio("321102099", var_413_9)
						arg_410_1:RecordAudio("321102099", var_413_9)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_321102", "321102099", "story_v_out_321102.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_321102", "321102099", "story_v_out_321102.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_10 = math.max(var_413_1, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_10 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_0) / var_413_10

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_10 and arg_410_1.time_ < var_413_0 + var_413_10 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play321102100 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 321102100
		arg_414_1.duration_ = 5.6

		local var_414_0 = {
			zh = 5.6,
			ja = 5.466
		}
		local var_414_1 = manager.audio:GetLocalizationFlag()

		if var_414_0[var_414_1] ~= nil then
			arg_414_1.duration_ = var_414_0[var_414_1]
		end

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play321102101(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			local var_417_0 = 0
			local var_417_1 = 0.575

			if var_417_0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_0 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, true)

				local var_417_2 = arg_414_1:FormatText(StoryNameCfg[672].name)

				arg_414_1.leftNameTxt_.text = var_417_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_414_1.leftNameTxt_.transform)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1.leftNameTxt_.text)
				SetActive(arg_414_1.iconTrs_.gameObject, true)
				arg_414_1.iconController_:SetSelectedState("hero")

				arg_414_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_414_1.callingController_:SetSelectedState("normal")

				arg_414_1.keyicon_.color = Color.New(1, 1, 1)
				arg_414_1.icon_.color = Color.New(1, 1, 1)

				local var_417_3 = arg_414_1:GetWordFromCfg(321102100)
				local var_417_4 = arg_414_1:FormatText(var_417_3.content)

				arg_414_1.text_.text = var_417_4

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_5 = 23
				local var_417_6 = utf8.len(var_417_4)
				local var_417_7 = var_417_5 <= 0 and var_417_1 or var_417_1 * (var_417_6 / var_417_5)

				if var_417_7 > 0 and var_417_1 < var_417_7 then
					arg_414_1.talkMaxDuration = var_417_7

					if var_417_7 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_7 + var_417_0
					end
				end

				arg_414_1.text_.text = var_417_4
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102100", "story_v_out_321102.awb") ~= 0 then
					local var_417_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102100", "story_v_out_321102.awb") / 1000

					if var_417_8 + var_417_0 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_8 + var_417_0
					end

					if var_417_3.prefab_name ~= "" and arg_414_1.actors_[var_417_3.prefab_name] ~= nil then
						local var_417_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_414_1.actors_[var_417_3.prefab_name].transform, "story_v_out_321102", "321102100", "story_v_out_321102.awb")

						arg_414_1:RecordAudio("321102100", var_417_9)
						arg_414_1:RecordAudio("321102100", var_417_9)
					else
						arg_414_1:AudioAction("play", "voice", "story_v_out_321102", "321102100", "story_v_out_321102.awb")
					end

					arg_414_1:RecordHistoryTalkVoice("story_v_out_321102", "321102100", "story_v_out_321102.awb")
				end

				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_10 = math.max(var_417_1, arg_414_1.talkMaxDuration)

			if var_417_0 <= arg_414_1.time_ and arg_414_1.time_ < var_417_0 + var_417_10 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_0) / var_417_10

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_0 + var_417_10 and arg_414_1.time_ < var_417_0 + var_417_10 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {}

		arg_414_1:InitPlayNodeList()
	end,
	Play321102101 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 321102101
		arg_418_1.duration_ = 5

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play321102102(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			local var_421_0 = 0
			local var_421_1 = 0.55

			if var_421_0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_0 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, false)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_2 = arg_418_1:GetWordFromCfg(321102101)
				local var_421_3 = arg_418_1:FormatText(var_421_2.content)

				arg_418_1.text_.text = var_421_3

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_4 = 22
				local var_421_5 = utf8.len(var_421_3)
				local var_421_6 = var_421_4 <= 0 and var_421_1 or var_421_1 * (var_421_5 / var_421_4)

				if var_421_6 > 0 and var_421_1 < var_421_6 then
					arg_418_1.talkMaxDuration = var_421_6

					if var_421_6 + var_421_0 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_6 + var_421_0
					end
				end

				arg_418_1.text_.text = var_421_3
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)
				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_7 = math.max(var_421_1, arg_418_1.talkMaxDuration)

			if var_421_0 <= arg_418_1.time_ and arg_418_1.time_ < var_421_0 + var_421_7 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_0) / var_421_7

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_0 + var_421_7 and arg_418_1.time_ < var_421_0 + var_421_7 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {}

		arg_418_1:InitPlayNodeList()
	end,
	Play321102102 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 321102102
		arg_422_1.duration_ = 5

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play321102103(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			local var_425_0 = 0
			local var_425_1 = 0.825

			if var_425_0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_0 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, false)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_422_1.iconTrs_.gameObject, false)
				arg_422_1.callingController_:SetSelectedState("normal")

				local var_425_2 = arg_422_1:GetWordFromCfg(321102102)
				local var_425_3 = arg_422_1:FormatText(var_425_2.content)

				arg_422_1.text_.text = var_425_3

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_4 = 33
				local var_425_5 = utf8.len(var_425_3)
				local var_425_6 = var_425_4 <= 0 and var_425_1 or var_425_1 * (var_425_5 / var_425_4)

				if var_425_6 > 0 and var_425_1 < var_425_6 then
					arg_422_1.talkMaxDuration = var_425_6

					if var_425_6 + var_425_0 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_6 + var_425_0
					end
				end

				arg_422_1.text_.text = var_425_3
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)
				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_7 = math.max(var_425_1, arg_422_1.talkMaxDuration)

			if var_425_0 <= arg_422_1.time_ and arg_422_1.time_ < var_425_0 + var_425_7 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_0) / var_425_7

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_0 + var_425_7 and arg_422_1.time_ < var_425_0 + var_425_7 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play321102103 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 321102103
		arg_426_1.duration_ = 5.23

		local var_426_0 = {
			zh = 5.033,
			ja = 5.233
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play321102104(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			local var_429_0 = "1085ui_story"

			if arg_426_1.actors_[var_429_0] == nil then
				local var_429_1 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_429_1) then
					local var_429_2 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_426_1.stage_.transform)

					var_429_2.name = var_429_0
					var_429_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_426_1.actors_[var_429_0] = var_429_2

					local var_429_3 = var_429_2:GetComponentInChildren(typeof(CharacterEffect))

					var_429_3.enabled = true

					local var_429_4 = GameObjectTools.GetOrAddComponent(var_429_2, typeof(DynamicBoneHelper))

					if var_429_4 then
						var_429_4:EnableDynamicBone(false)
					end

					arg_426_1:ShowWeapon(var_429_3.transform, false)

					arg_426_1.var_[var_429_0 .. "Animator"] = var_429_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_426_1.var_[var_429_0 .. "Animator"].applyRootMotion = true
					arg_426_1.var_[var_429_0 .. "LipSync"] = var_429_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_429_5 = arg_426_1.actors_["1085ui_story"].transform
			local var_429_6 = 0

			if var_429_6 < arg_426_1.time_ and arg_426_1.time_ <= var_429_6 + arg_429_0 then
				arg_426_1.var_.moveOldPos1085ui_story = var_429_5.localPosition
			end

			local var_429_7 = 0.001

			if var_429_6 <= arg_426_1.time_ and arg_426_1.time_ < var_429_6 + var_429_7 then
				local var_429_8 = (arg_426_1.time_ - var_429_6) / var_429_7
				local var_429_9 = Vector3.New(0, -1.01, -5.83)

				var_429_5.localPosition = Vector3.Lerp(arg_426_1.var_.moveOldPos1085ui_story, var_429_9, var_429_8)

				local var_429_10 = manager.ui.mainCamera.transform.position - var_429_5.position

				var_429_5.forward = Vector3.New(var_429_10.x, var_429_10.y, var_429_10.z)

				local var_429_11 = var_429_5.localEulerAngles

				var_429_11.z = 0
				var_429_11.x = 0
				var_429_5.localEulerAngles = var_429_11
			end

			if arg_426_1.time_ >= var_429_6 + var_429_7 and arg_426_1.time_ < var_429_6 + var_429_7 + arg_429_0 then
				var_429_5.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_429_12 = manager.ui.mainCamera.transform.position - var_429_5.position

				var_429_5.forward = Vector3.New(var_429_12.x, var_429_12.y, var_429_12.z)

				local var_429_13 = var_429_5.localEulerAngles

				var_429_13.z = 0
				var_429_13.x = 0
				var_429_5.localEulerAngles = var_429_13
			end

			local var_429_14 = arg_426_1.actors_["1085ui_story"]
			local var_429_15 = 0

			if var_429_15 < arg_426_1.time_ and arg_426_1.time_ <= var_429_15 + arg_429_0 and not isNil(var_429_14) and arg_426_1.var_.characterEffect1085ui_story == nil then
				arg_426_1.var_.characterEffect1085ui_story = var_429_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_16 = 0.200000002980232

			if var_429_15 <= arg_426_1.time_ and arg_426_1.time_ < var_429_15 + var_429_16 and not isNil(var_429_14) then
				local var_429_17 = (arg_426_1.time_ - var_429_15) / var_429_16

				if arg_426_1.var_.characterEffect1085ui_story and not isNil(var_429_14) then
					arg_426_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= var_429_15 + var_429_16 and arg_426_1.time_ < var_429_15 + var_429_16 + arg_429_0 and not isNil(var_429_14) and arg_426_1.var_.characterEffect1085ui_story then
				arg_426_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_429_18 = 0

			if var_429_18 < arg_426_1.time_ and arg_426_1.time_ <= var_429_18 + arg_429_0 then
				arg_426_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_429_19 = 0

			if var_429_19 < arg_426_1.time_ and arg_426_1.time_ <= var_429_19 + arg_429_0 then
				arg_426_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_429_20 = 0
			local var_429_21 = 0.35

			if var_429_20 < arg_426_1.time_ and arg_426_1.time_ <= var_429_20 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				local var_429_22 = arg_426_1:FormatText(StoryNameCfg[328].name)

				arg_426_1.leftNameTxt_.text = var_429_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_23 = arg_426_1:GetWordFromCfg(321102103)
				local var_429_24 = arg_426_1:FormatText(var_429_23.content)

				arg_426_1.text_.text = var_429_24

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_25 = 14
				local var_429_26 = utf8.len(var_429_24)
				local var_429_27 = var_429_25 <= 0 and var_429_21 or var_429_21 * (var_429_26 / var_429_25)

				if var_429_27 > 0 and var_429_21 < var_429_27 then
					arg_426_1.talkMaxDuration = var_429_27

					if var_429_27 + var_429_20 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_27 + var_429_20
					end
				end

				arg_426_1.text_.text = var_429_24
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102103", "story_v_out_321102.awb") ~= 0 then
					local var_429_28 = manager.audio:GetVoiceLength("story_v_out_321102", "321102103", "story_v_out_321102.awb") / 1000

					if var_429_28 + var_429_20 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_28 + var_429_20
					end

					if var_429_23.prefab_name ~= "" and arg_426_1.actors_[var_429_23.prefab_name] ~= nil then
						local var_429_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_23.prefab_name].transform, "story_v_out_321102", "321102103", "story_v_out_321102.awb")

						arg_426_1:RecordAudio("321102103", var_429_29)
						arg_426_1:RecordAudio("321102103", var_429_29)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_321102", "321102103", "story_v_out_321102.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_321102", "321102103", "story_v_out_321102.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_30 = math.max(var_429_21, arg_426_1.talkMaxDuration)

			if var_429_20 <= arg_426_1.time_ and arg_426_1.time_ < var_429_20 + var_429_30 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_20) / var_429_30

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_20 + var_429_30 and arg_426_1.time_ < var_429_20 + var_429_30 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_426_1:InitPlayNodeList()
	end,
	Play321102104 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 321102104
		arg_430_1.duration_ = 9.63

		local var_430_0 = {
			zh = 7.5,
			ja = 9.633
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play321102105(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = arg_430_1.actors_["1085ui_story"].transform
			local var_433_1 = 0

			if var_433_1 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 then
				arg_430_1.var_.moveOldPos1085ui_story = var_433_0.localPosition
			end

			local var_433_2 = 0.001

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_2 then
				local var_433_3 = (arg_430_1.time_ - var_433_1) / var_433_2
				local var_433_4 = Vector3.New(0, -1.01, -5.83)

				var_433_0.localPosition = Vector3.Lerp(arg_430_1.var_.moveOldPos1085ui_story, var_433_4, var_433_3)

				local var_433_5 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_5.x, var_433_5.y, var_433_5.z)

				local var_433_6 = var_433_0.localEulerAngles

				var_433_6.z = 0
				var_433_6.x = 0
				var_433_0.localEulerAngles = var_433_6
			end

			if arg_430_1.time_ >= var_433_1 + var_433_2 and arg_430_1.time_ < var_433_1 + var_433_2 + arg_433_0 then
				var_433_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_433_7 = manager.ui.mainCamera.transform.position - var_433_0.position

				var_433_0.forward = Vector3.New(var_433_7.x, var_433_7.y, var_433_7.z)

				local var_433_8 = var_433_0.localEulerAngles

				var_433_8.z = 0
				var_433_8.x = 0
				var_433_0.localEulerAngles = var_433_8
			end

			local var_433_9 = 0

			if var_433_9 < arg_430_1.time_ and arg_430_1.time_ <= var_433_9 + arg_433_0 then
				arg_430_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_433_10 = 0
			local var_433_11 = 0.6

			if var_433_10 < arg_430_1.time_ and arg_430_1.time_ <= var_433_10 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				local var_433_12 = arg_430_1:FormatText(StoryNameCfg[328].name)

				arg_430_1.leftNameTxt_.text = var_433_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_13 = arg_430_1:GetWordFromCfg(321102104)
				local var_433_14 = arg_430_1:FormatText(var_433_13.content)

				arg_430_1.text_.text = var_433_14

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_15 = 24
				local var_433_16 = utf8.len(var_433_14)
				local var_433_17 = var_433_15 <= 0 and var_433_11 or var_433_11 * (var_433_16 / var_433_15)

				if var_433_17 > 0 and var_433_11 < var_433_17 then
					arg_430_1.talkMaxDuration = var_433_17

					if var_433_17 + var_433_10 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_17 + var_433_10
					end
				end

				arg_430_1.text_.text = var_433_14
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102104", "story_v_out_321102.awb") ~= 0 then
					local var_433_18 = manager.audio:GetVoiceLength("story_v_out_321102", "321102104", "story_v_out_321102.awb") / 1000

					if var_433_18 + var_433_10 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_18 + var_433_10
					end

					if var_433_13.prefab_name ~= "" and arg_430_1.actors_[var_433_13.prefab_name] ~= nil then
						local var_433_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_13.prefab_name].transform, "story_v_out_321102", "321102104", "story_v_out_321102.awb")

						arg_430_1:RecordAudio("321102104", var_433_19)
						arg_430_1:RecordAudio("321102104", var_433_19)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_321102", "321102104", "story_v_out_321102.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_321102", "321102104", "story_v_out_321102.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_20 = math.max(var_433_11, arg_430_1.talkMaxDuration)

			if var_433_10 <= arg_430_1.time_ and arg_430_1.time_ < var_433_10 + var_433_20 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_10) / var_433_20

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_10 + var_433_20 and arg_430_1.time_ < var_433_10 + var_433_20 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_430_1:InitPlayNodeList()
	end,
	Play321102105 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 321102105
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play321102106(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = arg_434_1.actors_["1085ui_story"]
			local var_437_1 = 0

			if var_437_1 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect1085ui_story == nil then
				arg_434_1.var_.characterEffect1085ui_story = var_437_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_437_2 = 0.200000002980232

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_2 and not isNil(var_437_0) then
				local var_437_3 = (arg_434_1.time_ - var_437_1) / var_437_2

				if arg_434_1.var_.characterEffect1085ui_story and not isNil(var_437_0) then
					local var_437_4 = Mathf.Lerp(0, 0.5, var_437_3)

					arg_434_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_434_1.var_.characterEffect1085ui_story.fillRatio = var_437_4
				end
			end

			if arg_434_1.time_ >= var_437_1 + var_437_2 and arg_434_1.time_ < var_437_1 + var_437_2 + arg_437_0 and not isNil(var_437_0) and arg_434_1.var_.characterEffect1085ui_story then
				local var_437_5 = 0.5

				arg_434_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_434_1.var_.characterEffect1085ui_story.fillRatio = var_437_5
			end

			local var_437_6 = 0.05
			local var_437_7 = 1

			if var_437_6 < arg_434_1.time_ and arg_434_1.time_ <= var_437_6 + arg_437_0 then
				local var_437_8 = "play"
				local var_437_9 = "effect"

				arg_434_1:AudioAction(var_437_8, var_437_9, "se_story_140", "se_story_140_cat", "")
			end

			local var_437_10 = 0
			local var_437_11 = 1.125

			if var_437_10 < arg_434_1.time_ and arg_434_1.time_ <= var_437_10 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_12 = arg_434_1:GetWordFromCfg(321102105)
				local var_437_13 = arg_434_1:FormatText(var_437_12.content)

				arg_434_1.text_.text = var_437_13

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_14 = 45
				local var_437_15 = utf8.len(var_437_13)
				local var_437_16 = var_437_14 <= 0 and var_437_11 or var_437_11 * (var_437_15 / var_437_14)

				if var_437_16 > 0 and var_437_11 < var_437_16 then
					arg_434_1.talkMaxDuration = var_437_16

					if var_437_16 + var_437_10 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_16 + var_437_10
					end
				end

				arg_434_1.text_.text = var_437_13
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_17 = math.max(var_437_11, arg_434_1.talkMaxDuration)

			if var_437_10 <= arg_434_1.time_ and arg_434_1.time_ < var_437_10 + var_437_17 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_10) / var_437_17

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_10 + var_437_17 and arg_434_1.time_ < var_437_10 + var_437_17 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play321102106 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 321102106
		arg_438_1.duration_ = 4.97

		local var_438_0 = {
			zh = 4.966,
			ja = 4.466
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
				arg_438_0:Play321102107(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0
			local var_441_1 = 0.4

			if var_441_0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_2 = arg_438_1:FormatText(StoryNameCfg[1168].name)

				arg_438_1.leftNameTxt_.text = var_441_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_nainai")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_3 = arg_438_1:GetWordFromCfg(321102106)
				local var_441_4 = arg_438_1:FormatText(var_441_3.content)

				arg_438_1.text_.text = var_441_4

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_5 = 16
				local var_441_6 = utf8.len(var_441_4)
				local var_441_7 = var_441_5 <= 0 and var_441_1 or var_441_1 * (var_441_6 / var_441_5)

				if var_441_7 > 0 and var_441_1 < var_441_7 then
					arg_438_1.talkMaxDuration = var_441_7

					if var_441_7 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_7 + var_441_0
					end
				end

				arg_438_1.text_.text = var_441_4
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102106", "story_v_out_321102.awb") ~= 0 then
					local var_441_8 = manager.audio:GetVoiceLength("story_v_out_321102", "321102106", "story_v_out_321102.awb") / 1000

					if var_441_8 + var_441_0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_8 + var_441_0
					end

					if var_441_3.prefab_name ~= "" and arg_438_1.actors_[var_441_3.prefab_name] ~= nil then
						local var_441_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_3.prefab_name].transform, "story_v_out_321102", "321102106", "story_v_out_321102.awb")

						arg_438_1:RecordAudio("321102106", var_441_9)
						arg_438_1:RecordAudio("321102106", var_441_9)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_321102", "321102106", "story_v_out_321102.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_321102", "321102106", "story_v_out_321102.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_10 = math.max(var_441_1, arg_438_1.talkMaxDuration)

			if var_441_0 <= arg_438_1.time_ and arg_438_1.time_ < var_441_0 + var_441_10 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_0) / var_441_10

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_0 + var_441_10 and arg_438_1.time_ < var_441_0 + var_441_10 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play321102107 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 321102107
		arg_442_1.duration_ = 3.27

		local var_442_0 = {
			zh = 2.266,
			ja = 3.266
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
				arg_442_0:Play321102108(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = arg_442_1.actors_["1085ui_story"].transform
			local var_445_1 = 0

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 then
				arg_442_1.var_.moveOldPos1085ui_story = var_445_0.localPosition
			end

			local var_445_2 = 0.001

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_2 then
				local var_445_3 = (arg_442_1.time_ - var_445_1) / var_445_2
				local var_445_4 = Vector3.New(0, -1.01, -5.83)

				var_445_0.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1085ui_story, var_445_4, var_445_3)

				local var_445_5 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_5.x, var_445_5.y, var_445_5.z)

				local var_445_6 = var_445_0.localEulerAngles

				var_445_6.z = 0
				var_445_6.x = 0
				var_445_0.localEulerAngles = var_445_6
			end

			if arg_442_1.time_ >= var_445_1 + var_445_2 and arg_442_1.time_ < var_445_1 + var_445_2 + arg_445_0 then
				var_445_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_445_7 = manager.ui.mainCamera.transform.position - var_445_0.position

				var_445_0.forward = Vector3.New(var_445_7.x, var_445_7.y, var_445_7.z)

				local var_445_8 = var_445_0.localEulerAngles

				var_445_8.z = 0
				var_445_8.x = 0
				var_445_0.localEulerAngles = var_445_8
			end

			local var_445_9 = arg_442_1.actors_["1085ui_story"]
			local var_445_10 = 0

			if var_445_10 < arg_442_1.time_ and arg_442_1.time_ <= var_445_10 + arg_445_0 and not isNil(var_445_9) and arg_442_1.var_.characterEffect1085ui_story == nil then
				arg_442_1.var_.characterEffect1085ui_story = var_445_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_11 = 0.200000002980232

			if var_445_10 <= arg_442_1.time_ and arg_442_1.time_ < var_445_10 + var_445_11 and not isNil(var_445_9) then
				local var_445_12 = (arg_442_1.time_ - var_445_10) / var_445_11

				if arg_442_1.var_.characterEffect1085ui_story and not isNil(var_445_9) then
					arg_442_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= var_445_10 + var_445_11 and arg_442_1.time_ < var_445_10 + var_445_11 + arg_445_0 and not isNil(var_445_9) and arg_442_1.var_.characterEffect1085ui_story then
				arg_442_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_445_13 = 0

			if var_445_13 < arg_442_1.time_ and arg_442_1.time_ <= var_445_13 + arg_445_0 then
				arg_442_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action449")
			end

			local var_445_14 = 0

			if var_445_14 < arg_442_1.time_ and arg_442_1.time_ <= var_445_14 + arg_445_0 then
				arg_442_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_445_15 = 0
			local var_445_16 = 0.275

			if var_445_15 < arg_442_1.time_ and arg_442_1.time_ <= var_445_15 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_17 = arg_442_1:FormatText(StoryNameCfg[328].name)

				arg_442_1.leftNameTxt_.text = var_445_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_18 = arg_442_1:GetWordFromCfg(321102107)
				local var_445_19 = arg_442_1:FormatText(var_445_18.content)

				arg_442_1.text_.text = var_445_19

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_20 = 11
				local var_445_21 = utf8.len(var_445_19)
				local var_445_22 = var_445_20 <= 0 and var_445_16 or var_445_16 * (var_445_21 / var_445_20)

				if var_445_22 > 0 and var_445_16 < var_445_22 then
					arg_442_1.talkMaxDuration = var_445_22

					if var_445_22 + var_445_15 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_22 + var_445_15
					end
				end

				arg_442_1.text_.text = var_445_19
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102107", "story_v_out_321102.awb") ~= 0 then
					local var_445_23 = manager.audio:GetVoiceLength("story_v_out_321102", "321102107", "story_v_out_321102.awb") / 1000

					if var_445_23 + var_445_15 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_23 + var_445_15
					end

					if var_445_18.prefab_name ~= "" and arg_442_1.actors_[var_445_18.prefab_name] ~= nil then
						local var_445_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_18.prefab_name].transform, "story_v_out_321102", "321102107", "story_v_out_321102.awb")

						arg_442_1:RecordAudio("321102107", var_445_24)
						arg_442_1:RecordAudio("321102107", var_445_24)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_321102", "321102107", "story_v_out_321102.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_321102", "321102107", "story_v_out_321102.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_25 = math.max(var_445_16, arg_442_1.talkMaxDuration)

			if var_445_15 <= arg_442_1.time_ and arg_442_1.time_ < var_445_15 + var_445_25 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_15) / var_445_25

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_15 + var_445_25 and arg_442_1.time_ < var_445_15 + var_445_25 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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
	Play321102108 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 321102108
		arg_446_1.duration_ = 9

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play321102109(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 2

			if var_449_0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				local var_449_1 = manager.ui.mainCamera.transform.localPosition
				local var_449_2 = Vector3.New(0, 0, 10) + Vector3.New(var_449_1.x, var_449_1.y, 0)
				local var_449_3 = arg_446_1.bgs_.L01h

				var_449_3.transform.localPosition = var_449_2
				var_449_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_449_4 = var_449_3:GetComponent("SpriteRenderer")

				if var_449_4 and var_449_4.sprite then
					local var_449_5 = (var_449_3.transform.localPosition - var_449_1).z
					local var_449_6 = manager.ui.mainCameraCom_
					local var_449_7 = 2 * var_449_5 * Mathf.Tan(var_449_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_449_8 = var_449_7 * var_449_6.aspect
					local var_449_9 = var_449_4.sprite.bounds.size.x
					local var_449_10 = var_449_4.sprite.bounds.size.y
					local var_449_11 = var_449_8 / var_449_9
					local var_449_12 = var_449_7 / var_449_10
					local var_449_13 = var_449_12 < var_449_11 and var_449_11 or var_449_12

					var_449_3.transform.localScale = Vector3.New(var_449_13, var_449_13, 0)
				end

				for iter_449_0, iter_449_1 in pairs(arg_446_1.bgs_) do
					if iter_449_0 ~= "L01h" then
						iter_449_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_449_14 = 3.999999999999

			if var_449_14 < arg_446_1.time_ and arg_446_1.time_ <= var_449_14 + arg_449_0 then
				arg_446_1.allBtn_.enabled = false
			end

			local var_449_15 = 0.3

			if arg_446_1.time_ >= var_449_14 + var_449_15 and arg_446_1.time_ < var_449_14 + var_449_15 + arg_449_0 then
				arg_446_1.allBtn_.enabled = true
			end

			local var_449_16 = 0

			if var_449_16 < arg_446_1.time_ and arg_446_1.time_ <= var_449_16 + arg_449_0 then
				arg_446_1.mask_.enabled = true
				arg_446_1.mask_.raycastTarget = true

				arg_446_1:SetGaussion(false)
			end

			local var_449_17 = 2

			if var_449_16 <= arg_446_1.time_ and arg_446_1.time_ < var_449_16 + var_449_17 then
				local var_449_18 = (arg_446_1.time_ - var_449_16) / var_449_17
				local var_449_19 = Color.New(0, 0, 0)

				var_449_19.a = Mathf.Lerp(0, 1, var_449_18)
				arg_446_1.mask_.color = var_449_19
			end

			if arg_446_1.time_ >= var_449_16 + var_449_17 and arg_446_1.time_ < var_449_16 + var_449_17 + arg_449_0 then
				local var_449_20 = Color.New(0, 0, 0)

				var_449_20.a = 1
				arg_446_1.mask_.color = var_449_20
			end

			local var_449_21 = 2

			if var_449_21 < arg_446_1.time_ and arg_446_1.time_ <= var_449_21 + arg_449_0 then
				arg_446_1.mask_.enabled = true
				arg_446_1.mask_.raycastTarget = true

				arg_446_1:SetGaussion(false)
			end

			local var_449_22 = 2

			if var_449_21 <= arg_446_1.time_ and arg_446_1.time_ < var_449_21 + var_449_22 then
				local var_449_23 = (arg_446_1.time_ - var_449_21) / var_449_22
				local var_449_24 = Color.New(0, 0, 0)

				var_449_24.a = Mathf.Lerp(1, 0, var_449_23)
				arg_446_1.mask_.color = var_449_24
			end

			if arg_446_1.time_ >= var_449_21 + var_449_22 and arg_446_1.time_ < var_449_21 + var_449_22 + arg_449_0 then
				local var_449_25 = Color.New(0, 0, 0)
				local var_449_26 = 0

				arg_446_1.mask_.enabled = false
				var_449_25.a = var_449_26
				arg_446_1.mask_.color = var_449_25
			end

			local var_449_27 = arg_446_1.actors_["1085ui_story"].transform
			local var_449_28 = 1.96599999815226

			if var_449_28 < arg_446_1.time_ and arg_446_1.time_ <= var_449_28 + arg_449_0 then
				arg_446_1.var_.moveOldPos1085ui_story = var_449_27.localPosition
			end

			local var_449_29 = 0.001

			if var_449_28 <= arg_446_1.time_ and arg_446_1.time_ < var_449_28 + var_449_29 then
				local var_449_30 = (arg_446_1.time_ - var_449_28) / var_449_29
				local var_449_31 = Vector3.New(0, 100, 0)

				var_449_27.localPosition = Vector3.Lerp(arg_446_1.var_.moveOldPos1085ui_story, var_449_31, var_449_30)

				local var_449_32 = manager.ui.mainCamera.transform.position - var_449_27.position

				var_449_27.forward = Vector3.New(var_449_32.x, var_449_32.y, var_449_32.z)

				local var_449_33 = var_449_27.localEulerAngles

				var_449_33.z = 0
				var_449_33.x = 0
				var_449_27.localEulerAngles = var_449_33
			end

			if arg_446_1.time_ >= var_449_28 + var_449_29 and arg_446_1.time_ < var_449_28 + var_449_29 + arg_449_0 then
				var_449_27.localPosition = Vector3.New(0, 100, 0)

				local var_449_34 = manager.ui.mainCamera.transform.position - var_449_27.position

				var_449_27.forward = Vector3.New(var_449_34.x, var_449_34.y, var_449_34.z)

				local var_449_35 = var_449_27.localEulerAngles

				var_449_35.z = 0
				var_449_35.x = 0
				var_449_27.localEulerAngles = var_449_35
			end

			local var_449_36 = arg_446_1.actors_["1085ui_story"]
			local var_449_37 = 1.96599999815226

			if var_449_37 < arg_446_1.time_ and arg_446_1.time_ <= var_449_37 + arg_449_0 and not isNil(var_449_36) and arg_446_1.var_.characterEffect1085ui_story == nil then
				arg_446_1.var_.characterEffect1085ui_story = var_449_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_38 = 0.034000001847744

			if var_449_37 <= arg_446_1.time_ and arg_446_1.time_ < var_449_37 + var_449_38 and not isNil(var_449_36) then
				local var_449_39 = (arg_446_1.time_ - var_449_37) / var_449_38

				if arg_446_1.var_.characterEffect1085ui_story and not isNil(var_449_36) then
					local var_449_40 = Mathf.Lerp(0, 0.5, var_449_39)

					arg_446_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_446_1.var_.characterEffect1085ui_story.fillRatio = var_449_40
				end
			end

			if arg_446_1.time_ >= var_449_37 + var_449_38 and arg_446_1.time_ < var_449_37 + var_449_38 + arg_449_0 and not isNil(var_449_36) and arg_446_1.var_.characterEffect1085ui_story then
				local var_449_41 = 0.5

				arg_446_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_446_1.var_.characterEffect1085ui_story.fillRatio = var_449_41
			end

			if arg_446_1.frameCnt_ <= 1 then
				arg_446_1.dialog_:SetActive(false)
			end

			local var_449_42 = 3.999999999999
			local var_449_43 = 1.35

			if var_449_42 < arg_446_1.time_ and arg_446_1.time_ <= var_449_42 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0

				arg_446_1.dialog_:SetActive(true)

				arg_446_1.dialogCg_.alpha = 0

				local var_449_44 = LeanTween.value(arg_446_1.dialog_, 0, 1, 0.3)

				var_449_44:setOnUpdate(LuaHelper.FloatAction(function(arg_450_0)
					arg_446_1.dialogCg_.alpha = arg_450_0
				end))
				var_449_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_446_1.dialog_)
					var_449_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_446_1.duration_ = arg_446_1.duration_ + 0.3

				SetActive(arg_446_1.leftNameGo_, false)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_45 = arg_446_1:GetWordFromCfg(321102108)
				local var_449_46 = arg_446_1:FormatText(var_449_45.content)

				arg_446_1.text_.text = var_449_46

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_47 = 54
				local var_449_48 = utf8.len(var_449_46)
				local var_449_49 = var_449_47 <= 0 and var_449_43 or var_449_43 * (var_449_48 / var_449_47)

				if var_449_49 > 0 and var_449_43 < var_449_49 then
					arg_446_1.talkMaxDuration = var_449_49
					var_449_42 = var_449_42 + 0.3

					if var_449_49 + var_449_42 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_49 + var_449_42
					end
				end

				arg_446_1.text_.text = var_449_46
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)
				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_50 = var_449_42 + 0.3
			local var_449_51 = math.max(var_449_43, arg_446_1.talkMaxDuration)

			if var_449_50 <= arg_446_1.time_ and arg_446_1.time_ < var_449_50 + var_449_51 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_50) / var_449_51

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_50 + var_449_51 and arg_446_1.time_ < var_449_50 + var_449_51 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_446_1:InitPlayNodeList()
	end,
	Play321102109 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 321102109
		arg_452_1.duration_ = 3.47

		local var_452_0 = {
			zh = 2.9,
			ja = 3.466
		}
		local var_452_1 = manager.audio:GetLocalizationFlag()

		if var_452_0[var_452_1] ~= nil then
			arg_452_1.duration_ = var_452_0[var_452_1]
		end

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
		end

		function arg_452_1.playNext_(arg_454_0)
			if arg_454_0 == 1 then
				arg_452_0:Play321102110(arg_452_1)
			end
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			local var_455_0 = arg_452_1.actors_["1085ui_story"].transform
			local var_455_1 = 0

			if var_455_1 < arg_452_1.time_ and arg_452_1.time_ <= var_455_1 + arg_455_0 then
				arg_452_1.var_.moveOldPos1085ui_story = var_455_0.localPosition
			end

			local var_455_2 = 0.001

			if var_455_1 <= arg_452_1.time_ and arg_452_1.time_ < var_455_1 + var_455_2 then
				local var_455_3 = (arg_452_1.time_ - var_455_1) / var_455_2
				local var_455_4 = Vector3.New(0, -1.01, -5.83)

				var_455_0.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos1085ui_story, var_455_4, var_455_3)

				local var_455_5 = manager.ui.mainCamera.transform.position - var_455_0.position

				var_455_0.forward = Vector3.New(var_455_5.x, var_455_5.y, var_455_5.z)

				local var_455_6 = var_455_0.localEulerAngles

				var_455_6.z = 0
				var_455_6.x = 0
				var_455_0.localEulerAngles = var_455_6
			end

			if arg_452_1.time_ >= var_455_1 + var_455_2 and arg_452_1.time_ < var_455_1 + var_455_2 + arg_455_0 then
				var_455_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_455_7 = manager.ui.mainCamera.transform.position - var_455_0.position

				var_455_0.forward = Vector3.New(var_455_7.x, var_455_7.y, var_455_7.z)

				local var_455_8 = var_455_0.localEulerAngles

				var_455_8.z = 0
				var_455_8.x = 0
				var_455_0.localEulerAngles = var_455_8
			end

			local var_455_9 = arg_452_1.actors_["1085ui_story"]
			local var_455_10 = 0

			if var_455_10 < arg_452_1.time_ and arg_452_1.time_ <= var_455_10 + arg_455_0 and not isNil(var_455_9) and arg_452_1.var_.characterEffect1085ui_story == nil then
				arg_452_1.var_.characterEffect1085ui_story = var_455_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_455_11 = 0.200000002980232

			if var_455_10 <= arg_452_1.time_ and arg_452_1.time_ < var_455_10 + var_455_11 and not isNil(var_455_9) then
				local var_455_12 = (arg_452_1.time_ - var_455_10) / var_455_11

				if arg_452_1.var_.characterEffect1085ui_story and not isNil(var_455_9) then
					arg_452_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_452_1.time_ >= var_455_10 + var_455_11 and arg_452_1.time_ < var_455_10 + var_455_11 + arg_455_0 and not isNil(var_455_9) and arg_452_1.var_.characterEffect1085ui_story then
				arg_452_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_455_13 = 0

			if var_455_13 < arg_452_1.time_ and arg_452_1.time_ <= var_455_13 + arg_455_0 then
				arg_452_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action497")
			end

			local var_455_14 = 0

			if var_455_14 < arg_452_1.time_ and arg_452_1.time_ <= var_455_14 + arg_455_0 then
				arg_452_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_455_15 = 0
			local var_455_16 = 0.275

			if var_455_15 < arg_452_1.time_ and arg_452_1.time_ <= var_455_15 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				local var_455_17 = arg_452_1:FormatText(StoryNameCfg[328].name)

				arg_452_1.leftNameTxt_.text = var_455_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_18 = arg_452_1:GetWordFromCfg(321102109)
				local var_455_19 = arg_452_1:FormatText(var_455_18.content)

				arg_452_1.text_.text = var_455_19

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_20 = 11
				local var_455_21 = utf8.len(var_455_19)
				local var_455_22 = var_455_20 <= 0 and var_455_16 or var_455_16 * (var_455_21 / var_455_20)

				if var_455_22 > 0 and var_455_16 < var_455_22 then
					arg_452_1.talkMaxDuration = var_455_22

					if var_455_22 + var_455_15 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_22 + var_455_15
					end
				end

				arg_452_1.text_.text = var_455_19
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321102", "321102109", "story_v_out_321102.awb") ~= 0 then
					local var_455_23 = manager.audio:GetVoiceLength("story_v_out_321102", "321102109", "story_v_out_321102.awb") / 1000

					if var_455_23 + var_455_15 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_23 + var_455_15
					end

					if var_455_18.prefab_name ~= "" and arg_452_1.actors_[var_455_18.prefab_name] ~= nil then
						local var_455_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_18.prefab_name].transform, "story_v_out_321102", "321102109", "story_v_out_321102.awb")

						arg_452_1:RecordAudio("321102109", var_455_24)
						arg_452_1:RecordAudio("321102109", var_455_24)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_321102", "321102109", "story_v_out_321102.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_321102", "321102109", "story_v_out_321102.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_25 = math.max(var_455_16, arg_452_1.talkMaxDuration)

			if var_455_15 <= arg_452_1.time_ and arg_452_1.time_ < var_455_15 + var_455_25 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_15) / var_455_25

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_15 + var_455_25 and arg_452_1.time_ < var_455_15 + var_455_25 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	Play321102110 = function(arg_456_0, arg_456_1)
		arg_456_1.time_ = 0
		arg_456_1.frameCnt_ = 0
		arg_456_1.state_ = "playing"
		arg_456_1.curTalkId_ = 321102110
		arg_456_1.duration_ = 5

		SetActive(arg_456_1.tipsGo_, false)

		function arg_456_1.onSingleLineFinish_()
			arg_456_1.onSingleLineUpdate_ = nil
			arg_456_1.onSingleLineFinish_ = nil
			arg_456_1.state_ = "waiting"
		end

		function arg_456_1.playNext_(arg_458_0)
			if arg_458_0 == 1 then
				arg_456_0:Play321102111(arg_456_1)
			end
		end

		function arg_456_1.onSingleLineUpdate_(arg_459_0)
			local var_459_0 = arg_456_1.actors_["1085ui_story"].transform
			local var_459_1 = 0

			if var_459_1 < arg_456_1.time_ and arg_456_1.time_ <= var_459_1 + arg_459_0 then
				arg_456_1.var_.moveOldPos1085ui_story = var_459_0.localPosition
			end

			local var_459_2 = 0.001

			if var_459_1 <= arg_456_1.time_ and arg_456_1.time_ < var_459_1 + var_459_2 then
				local var_459_3 = (arg_456_1.time_ - var_459_1) / var_459_2
				local var_459_4 = Vector3.New(0, 100, 0)

				var_459_0.localPosition = Vector3.Lerp(arg_456_1.var_.moveOldPos1085ui_story, var_459_4, var_459_3)

				local var_459_5 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_5.x, var_459_5.y, var_459_5.z)

				local var_459_6 = var_459_0.localEulerAngles

				var_459_6.z = 0
				var_459_6.x = 0
				var_459_0.localEulerAngles = var_459_6
			end

			if arg_456_1.time_ >= var_459_1 + var_459_2 and arg_456_1.time_ < var_459_1 + var_459_2 + arg_459_0 then
				var_459_0.localPosition = Vector3.New(0, 100, 0)

				local var_459_7 = manager.ui.mainCamera.transform.position - var_459_0.position

				var_459_0.forward = Vector3.New(var_459_7.x, var_459_7.y, var_459_7.z)

				local var_459_8 = var_459_0.localEulerAngles

				var_459_8.z = 0
				var_459_8.x = 0
				var_459_0.localEulerAngles = var_459_8
			end

			local var_459_9 = arg_456_1.actors_["1085ui_story"]
			local var_459_10 = 0

			if var_459_10 < arg_456_1.time_ and arg_456_1.time_ <= var_459_10 + arg_459_0 and not isNil(var_459_9) and arg_456_1.var_.characterEffect1085ui_story == nil then
				arg_456_1.var_.characterEffect1085ui_story = var_459_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_459_11 = 0.200000002980232

			if var_459_10 <= arg_456_1.time_ and arg_456_1.time_ < var_459_10 + var_459_11 and not isNil(var_459_9) then
				local var_459_12 = (arg_456_1.time_ - var_459_10) / var_459_11

				if arg_456_1.var_.characterEffect1085ui_story and not isNil(var_459_9) then
					local var_459_13 = Mathf.Lerp(0, 0.5, var_459_12)

					arg_456_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_456_1.var_.characterEffect1085ui_story.fillRatio = var_459_13
				end
			end

			if arg_456_1.time_ >= var_459_10 + var_459_11 and arg_456_1.time_ < var_459_10 + var_459_11 + arg_459_0 and not isNil(var_459_9) and arg_456_1.var_.characterEffect1085ui_story then
				local var_459_14 = 0.5

				arg_456_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_456_1.var_.characterEffect1085ui_story.fillRatio = var_459_14
			end

			local var_459_15 = 0
			local var_459_16 = 0.8

			if var_459_15 < arg_456_1.time_ and arg_456_1.time_ <= var_459_15 + arg_459_0 then
				arg_456_1.talkMaxDuration = 0
				arg_456_1.dialogCg_.alpha = 1

				arg_456_1.dialog_:SetActive(true)
				SetActive(arg_456_1.leftNameGo_, false)

				arg_456_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_456_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_456_1:RecordName(arg_456_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_456_1.iconTrs_.gameObject, false)
				arg_456_1.callingController_:SetSelectedState("normal")

				local var_459_17 = arg_456_1:GetWordFromCfg(321102110)
				local var_459_18 = arg_456_1:FormatText(var_459_17.content)

				arg_456_1.text_.text = var_459_18

				LuaForUtil.ClearLinePrefixSymbol(arg_456_1.text_)

				local var_459_19 = 32
				local var_459_20 = utf8.len(var_459_18)
				local var_459_21 = var_459_19 <= 0 and var_459_16 or var_459_16 * (var_459_20 / var_459_19)

				if var_459_21 > 0 and var_459_16 < var_459_21 then
					arg_456_1.talkMaxDuration = var_459_21

					if var_459_21 + var_459_15 > arg_456_1.duration_ then
						arg_456_1.duration_ = var_459_21 + var_459_15
					end
				end

				arg_456_1.text_.text = var_459_18
				arg_456_1.typewritter.percent = 0

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(false)
				arg_456_1:RecordContent(arg_456_1.text_.text)
			end

			local var_459_22 = math.max(var_459_16, arg_456_1.talkMaxDuration)

			if var_459_15 <= arg_456_1.time_ and arg_456_1.time_ < var_459_15 + var_459_22 then
				arg_456_1.typewritter.percent = (arg_456_1.time_ - var_459_15) / var_459_22

				arg_456_1.typewritter:SetDirty()
			end

			if arg_456_1.time_ >= var_459_15 + var_459_22 and arg_456_1.time_ < var_459_15 + var_459_22 + arg_459_0 then
				arg_456_1.typewritter.percent = 1

				arg_456_1.typewritter:SetDirty()
				arg_456_1:ShowNextGo(true)
			end
		end

		arg_456_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_456_1:InitPlayNodeList()
	end,
	Play321102111 = function(arg_460_0, arg_460_1)
		arg_460_1.time_ = 0
		arg_460_1.frameCnt_ = 0
		arg_460_1.state_ = "playing"
		arg_460_1.curTalkId_ = 321102111
		arg_460_1.duration_ = 5

		SetActive(arg_460_1.tipsGo_, false)

		function arg_460_1.onSingleLineFinish_()
			arg_460_1.onSingleLineUpdate_ = nil
			arg_460_1.onSingleLineFinish_ = nil
			arg_460_1.state_ = "waiting"
		end

		function arg_460_1.playNext_(arg_462_0)
			if arg_462_0 == 1 then
				arg_460_0:Play321102112(arg_460_1)
			end
		end

		function arg_460_1.onSingleLineUpdate_(arg_463_0)
			local var_463_0 = 0
			local var_463_1 = 1.475

			if var_463_0 < arg_460_1.time_ and arg_460_1.time_ <= var_463_0 + arg_463_0 then
				arg_460_1.talkMaxDuration = 0
				arg_460_1.dialogCg_.alpha = 1

				arg_460_1.dialog_:SetActive(true)
				SetActive(arg_460_1.leftNameGo_, false)

				arg_460_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_460_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_460_1:RecordName(arg_460_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_460_1.iconTrs_.gameObject, false)
				arg_460_1.callingController_:SetSelectedState("normal")

				local var_463_2 = arg_460_1:GetWordFromCfg(321102111)
				local var_463_3 = arg_460_1:FormatText(var_463_2.content)

				arg_460_1.text_.text = var_463_3

				LuaForUtil.ClearLinePrefixSymbol(arg_460_1.text_)

				local var_463_4 = 59
				local var_463_5 = utf8.len(var_463_3)
				local var_463_6 = var_463_4 <= 0 and var_463_1 or var_463_1 * (var_463_5 / var_463_4)

				if var_463_6 > 0 and var_463_1 < var_463_6 then
					arg_460_1.talkMaxDuration = var_463_6

					if var_463_6 + var_463_0 > arg_460_1.duration_ then
						arg_460_1.duration_ = var_463_6 + var_463_0
					end
				end

				arg_460_1.text_.text = var_463_3
				arg_460_1.typewritter.percent = 0

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(false)
				arg_460_1:RecordContent(arg_460_1.text_.text)
			end

			local var_463_7 = math.max(var_463_1, arg_460_1.talkMaxDuration)

			if var_463_0 <= arg_460_1.time_ and arg_460_1.time_ < var_463_0 + var_463_7 then
				arg_460_1.typewritter.percent = (arg_460_1.time_ - var_463_0) / var_463_7

				arg_460_1.typewritter:SetDirty()
			end

			if arg_460_1.time_ >= var_463_0 + var_463_7 and arg_460_1.time_ < var_463_0 + var_463_7 + arg_463_0 then
				arg_460_1.typewritter.percent = 1

				arg_460_1.typewritter:SetDirty()
				arg_460_1:ShowNextGo(true)
			end
		end

		arg_460_1.nodeConfigList_ = {}

		arg_460_1:InitPlayNodeList()
	end,
	Play321102112 = function(arg_464_0, arg_464_1)
		arg_464_1.time_ = 0
		arg_464_1.frameCnt_ = 0
		arg_464_1.state_ = "playing"
		arg_464_1.curTalkId_ = 321102112
		arg_464_1.duration_ = 5

		SetActive(arg_464_1.tipsGo_, false)

		function arg_464_1.onSingleLineFinish_()
			arg_464_1.onSingleLineUpdate_ = nil
			arg_464_1.onSingleLineFinish_ = nil
			arg_464_1.state_ = "waiting"
			arg_464_1.auto_ = false
		end

		function arg_464_1.playNext_(arg_466_0)
			arg_464_1.onStoryFinished_()
		end

		function arg_464_1.onSingleLineUpdate_(arg_467_0)
			local var_467_0 = 0
			local var_467_1 = 0.375

			if var_467_0 < arg_464_1.time_ and arg_464_1.time_ <= var_467_0 + arg_467_0 then
				arg_464_1.talkMaxDuration = 0
				arg_464_1.dialogCg_.alpha = 1

				arg_464_1.dialog_:SetActive(true)
				SetActive(arg_464_1.leftNameGo_, false)

				arg_464_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_464_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_464_1:RecordName(arg_464_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_464_1.iconTrs_.gameObject, false)
				arg_464_1.callingController_:SetSelectedState("normal")

				local var_467_2 = arg_464_1:GetWordFromCfg(321102112)
				local var_467_3 = arg_464_1:FormatText(var_467_2.content)

				arg_464_1.text_.text = var_467_3

				LuaForUtil.ClearLinePrefixSymbol(arg_464_1.text_)

				local var_467_4 = 15
				local var_467_5 = utf8.len(var_467_3)
				local var_467_6 = var_467_4 <= 0 and var_467_1 or var_467_1 * (var_467_5 / var_467_4)

				if var_467_6 > 0 and var_467_1 < var_467_6 then
					arg_464_1.talkMaxDuration = var_467_6

					if var_467_6 + var_467_0 > arg_464_1.duration_ then
						arg_464_1.duration_ = var_467_6 + var_467_0
					end
				end

				arg_464_1.text_.text = var_467_3
				arg_464_1.typewritter.percent = 0

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(false)
				arg_464_1:RecordContent(arg_464_1.text_.text)
			end

			local var_467_7 = math.max(var_467_1, arg_464_1.talkMaxDuration)

			if var_467_0 <= arg_464_1.time_ and arg_464_1.time_ < var_467_0 + var_467_7 then
				arg_464_1.typewritter.percent = (arg_464_1.time_ - var_467_0) / var_467_7

				arg_464_1.typewritter:SetDirty()
			end

			if arg_464_1.time_ >= var_467_0 + var_467_7 and arg_464_1.time_ < var_467_0 + var_467_7 + arg_467_0 then
				arg_464_1.typewritter.percent = 1

				arg_464_1.typewritter:SetDirty()
				arg_464_1:ShowNextGo(true)
			end
		end

		arg_464_1.nodeConfigList_ = {}

		arg_464_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L10f",
		"TextureConfig/Background/L10g",
		"TextureConfig/Background/L01h",
		"TextureConfig/Background/ST0504",
		"TextureConfig/Background/ST0505a"
	},
	voices = {
		"story_v_out_321102.awb"
	}
}
