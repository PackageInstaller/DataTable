return {
	Play322071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322071001
		arg_1_1.duration_ = 4.4

		local var_1_0 = {
			zh = 3.799999999999,
			ja = 4.4
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
				arg_1_0:Play322071002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L17f"

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
				local var_4_5 = arg_1_1.bgs_.L17f

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
					if iter_4_0 ~= "L17f" then
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

			local var_4_24 = "1284ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1284ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1284ui_story = var_4_29.localPosition

				local var_4_31 = "1284ui_story"

				arg_1_1:ShowWeapon(arg_1_1.var_[var_4_31 .. "Animator"].transform, false)
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(-0.7, -0.985, -6.22)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1284ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_4_37 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_37.x, var_4_37.y, var_4_37.z)

				local var_4_38 = var_4_29.localEulerAngles

				var_4_38.z = 0
				var_4_38.x = 0
				var_4_29.localEulerAngles = var_4_38
			end

			local var_4_39 = arg_1_1.actors_["1284ui_story"]
			local var_4_40 = 1.8

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1284ui_story == nil then
				arg_1_1.var_.characterEffect1284ui_story = var_4_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_41 = 0.200000002980232

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 and not isNil(var_4_39) then
				local var_4_42 = (arg_1_1.time_ - var_4_40) / var_4_41

				if arg_1_1.var_.characterEffect1284ui_story and not isNil(var_4_39) then
					arg_1_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1284ui_story then
				arg_1_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_4_45 = 0.1
			local var_4_46 = 1

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "effect"

				arg_1_1:AudioAction(var_4_47, var_4_48, "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_4_49 = 0
			local var_4_50 = 0.200000002980232

			if var_4_49 < arg_1_1.time_ and arg_1_1.time_ <= var_4_49 + arg_4_0 then
				local var_4_51 = "play"
				local var_4_52 = "music"

				arg_1_1:AudioAction(var_4_51, var_4_52, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_53 = ""
				local var_4_54 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_54 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_54 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_54

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_54
						arg_1_1.bgmTxt2_.text = var_4_54
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

			local var_4_55 = 0.3
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "music"

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious")

				if var_4_60 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_60 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_60

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_60
						arg_1_1.bgmTxt2_.text = var_4_60
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

			local var_4_61 = 0.31
			local var_4_62 = 1

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				local var_4_63 = "play"
				local var_4_64 = "music"

				arg_1_1:AudioAction(var_4_63, var_4_64, "bgm_activity_4_5_story_serious", "init_battle", "bgm_activity_4_5_story_serious.awb")

				local var_4_65 = ""
				local var_4_66 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "init_battle")

				if var_4_66 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_66 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_66

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_66
						arg_1_1.bgmTxt2_.text = var_4_66
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

			local var_4_67 = 2
			local var_4_68 = 0.15

			if var_4_67 < arg_1_1.time_ and arg_1_1.time_ <= var_4_67 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_69 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_69:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_69:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_69:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_70 = arg_1_1:FormatText(StoryNameCfg[6].name)

				arg_1_1.leftNameTxt_.text = var_4_70

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_71 = arg_1_1:GetWordFromCfg(322071001)
				local var_4_72 = arg_1_1:FormatText(var_4_71.content)

				arg_1_1.text_.text = var_4_72

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_73 = 6
				local var_4_74 = utf8.len(var_4_72)
				local var_4_75 = var_4_73 <= 0 and var_4_68 or var_4_68 * (var_4_74 / var_4_73)

				if var_4_75 > 0 and var_4_68 < var_4_75 then
					arg_1_1.talkMaxDuration = var_4_75
					var_4_67 = var_4_67 + 0.3

					if var_4_75 + var_4_67 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_75 + var_4_67
					end
				end

				arg_1_1.text_.text = var_4_72
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071001", "story_v_out_322071.awb") ~= 0 then
					local var_4_76 = manager.audio:GetVoiceLength("story_v_out_322071", "322071001", "story_v_out_322071.awb") / 1000

					if var_4_76 + var_4_67 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_76 + var_4_67
					end

					if var_4_71.prefab_name ~= "" and arg_1_1.actors_[var_4_71.prefab_name] ~= nil then
						local var_4_77 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_71.prefab_name].transform, "story_v_out_322071", "322071001", "story_v_out_322071.awb")

						arg_1_1:RecordAudio("322071001", var_4_77)
						arg_1_1:RecordAudio("322071001", var_4_77)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322071", "322071001", "story_v_out_322071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322071", "322071001", "story_v_out_322071.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_78 = var_4_67 + 0.3
			local var_4_79 = math.max(var_4_68, arg_1_1.talkMaxDuration)

			if var_4_78 <= arg_1_1.time_ and arg_1_1.time_ < var_4_78 + var_4_79 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_78) / var_4_79

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_78 + var_4_79 and arg_1_1.time_ < var_4_78 + var_4_79 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play322071002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 322071002
		arg_10_1.duration_ = 6.2

		local var_10_0 = {
			zh = 3.566,
			ja = 6.2
		}
		local var_10_1 = manager.audio:GetLocalizationFlag()

		if var_10_0[var_10_1] ~= nil then
			arg_10_1.duration_ = var_10_0[var_10_1]
		end

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play322071003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = "404001ui_story"

			if arg_10_1.actors_[var_13_0] == nil then
				local var_13_1 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_13_1) then
					local var_13_2 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_10_1.stage_.transform)

					var_13_2.name = var_13_0
					var_13_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_10_1.actors_[var_13_0] = var_13_2

					local var_13_3 = var_13_2:GetComponentInChildren(typeof(CharacterEffect))

					var_13_3.enabled = true

					local var_13_4 = GameObjectTools.GetOrAddComponent(var_13_2, typeof(DynamicBoneHelper))

					if var_13_4 then
						var_13_4:EnableDynamicBone(false)
					end

					arg_10_1:ShowWeapon(var_13_3.transform, false)

					arg_10_1.var_[var_13_0 .. "Animator"] = var_13_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_10_1.var_[var_13_0 .. "Animator"].applyRootMotion = true
					arg_10_1.var_[var_13_0 .. "LipSync"] = var_13_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_13_5 = arg_10_1.actors_["404001ui_story"].transform
			local var_13_6 = 0

			if var_13_6 < arg_10_1.time_ and arg_10_1.time_ <= var_13_6 + arg_13_0 then
				arg_10_1.var_.moveOldPos404001ui_story = var_13_5.localPosition
			end

			local var_13_7 = 0.001

			if var_13_6 <= arg_10_1.time_ and arg_10_1.time_ < var_13_6 + var_13_7 then
				local var_13_8 = (arg_10_1.time_ - var_13_6) / var_13_7
				local var_13_9 = Vector3.New(0.8, -1.55, -5.5)

				var_13_5.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos404001ui_story, var_13_9, var_13_8)

				local var_13_10 = manager.ui.mainCamera.transform.position - var_13_5.position

				var_13_5.forward = Vector3.New(var_13_10.x, var_13_10.y, var_13_10.z)

				local var_13_11 = var_13_5.localEulerAngles

				var_13_11.z = 0
				var_13_11.x = 0
				var_13_5.localEulerAngles = var_13_11
			end

			if arg_10_1.time_ >= var_13_6 + var_13_7 and arg_10_1.time_ < var_13_6 + var_13_7 + arg_13_0 then
				var_13_5.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_13_12 = manager.ui.mainCamera.transform.position - var_13_5.position

				var_13_5.forward = Vector3.New(var_13_12.x, var_13_12.y, var_13_12.z)

				local var_13_13 = var_13_5.localEulerAngles

				var_13_13.z = 0
				var_13_13.x = 0
				var_13_5.localEulerAngles = var_13_13
			end

			local var_13_14 = arg_10_1.actors_["404001ui_story"]
			local var_13_15 = 0

			if var_13_15 < arg_10_1.time_ and arg_10_1.time_ <= var_13_15 + arg_13_0 and not isNil(var_13_14) and arg_10_1.var_.characterEffect404001ui_story == nil then
				arg_10_1.var_.characterEffect404001ui_story = var_13_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_16 = 0.200000002980232

			if var_13_15 <= arg_10_1.time_ and arg_10_1.time_ < var_13_15 + var_13_16 and not isNil(var_13_14) then
				local var_13_17 = (arg_10_1.time_ - var_13_15) / var_13_16

				if arg_10_1.var_.characterEffect404001ui_story and not isNil(var_13_14) then
					arg_10_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_10_1.time_ >= var_13_15 + var_13_16 and arg_10_1.time_ < var_13_15 + var_13_16 + arg_13_0 and not isNil(var_13_14) and arg_10_1.var_.characterEffect404001ui_story then
				arg_10_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_13_18 = arg_10_1.actors_["1284ui_story"]
			local var_13_19 = 0

			if var_13_19 < arg_10_1.time_ and arg_10_1.time_ <= var_13_19 + arg_13_0 and not isNil(var_13_18) and arg_10_1.var_.characterEffect1284ui_story == nil then
				arg_10_1.var_.characterEffect1284ui_story = var_13_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_20 = 0.200000002980232

			if var_13_19 <= arg_10_1.time_ and arg_10_1.time_ < var_13_19 + var_13_20 and not isNil(var_13_18) then
				local var_13_21 = (arg_10_1.time_ - var_13_19) / var_13_20

				if arg_10_1.var_.characterEffect1284ui_story and not isNil(var_13_18) then
					local var_13_22 = Mathf.Lerp(0, 0.5, var_13_21)

					arg_10_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_10_1.var_.characterEffect1284ui_story.fillRatio = var_13_22
				end
			end

			if arg_10_1.time_ >= var_13_19 + var_13_20 and arg_10_1.time_ < var_13_19 + var_13_20 + arg_13_0 and not isNil(var_13_18) and arg_10_1.var_.characterEffect1284ui_story then
				local var_13_23 = 0.5

				arg_10_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_10_1.var_.characterEffect1284ui_story.fillRatio = var_13_23
			end

			local var_13_24 = 0

			if var_13_24 < arg_10_1.time_ and arg_10_1.time_ <= var_13_24 + arg_13_0 then
				arg_10_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_13_25 = 0

			if var_13_25 < arg_10_1.time_ and arg_10_1.time_ <= var_13_25 + arg_13_0 then
				arg_10_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_13_26 = 0
			local var_13_27 = 0.325

			if var_13_26 < arg_10_1.time_ and arg_10_1.time_ <= var_13_26 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_28 = arg_10_1:FormatText(StoryNameCfg[668].name)

				arg_10_1.leftNameTxt_.text = var_13_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_29 = arg_10_1:GetWordFromCfg(322071002)
				local var_13_30 = arg_10_1:FormatText(var_13_29.content)

				arg_10_1.text_.text = var_13_30

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_31 = 13
				local var_13_32 = utf8.len(var_13_30)
				local var_13_33 = var_13_31 <= 0 and var_13_27 or var_13_27 * (var_13_32 / var_13_31)

				if var_13_33 > 0 and var_13_27 < var_13_33 then
					arg_10_1.talkMaxDuration = var_13_33

					if var_13_33 + var_13_26 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_33 + var_13_26
					end
				end

				arg_10_1.text_.text = var_13_30
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071002", "story_v_out_322071.awb") ~= 0 then
					local var_13_34 = manager.audio:GetVoiceLength("story_v_out_322071", "322071002", "story_v_out_322071.awb") / 1000

					if var_13_34 + var_13_26 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_34 + var_13_26
					end

					if var_13_29.prefab_name ~= "" and arg_10_1.actors_[var_13_29.prefab_name] ~= nil then
						local var_13_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_29.prefab_name].transform, "story_v_out_322071", "322071002", "story_v_out_322071.awb")

						arg_10_1:RecordAudio("322071002", var_13_35)
						arg_10_1:RecordAudio("322071002", var_13_35)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_322071", "322071002", "story_v_out_322071.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_322071", "322071002", "story_v_out_322071.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_36 = math.max(var_13_27, arg_10_1.talkMaxDuration)

			if var_13_26 <= arg_10_1.time_ and arg_10_1.time_ < var_13_26 + var_13_36 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_26) / var_13_36

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_26 + var_13_36 and arg_10_1.time_ < var_13_26 + var_13_36 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_10_1:InitPlayNodeList()
	end,
	Play322071003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 322071003
		arg_14_1.duration_ = 5

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play322071004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["404001ui_story"].transform
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.var_.moveOldPos404001ui_story = var_17_0.localPosition
			end

			local var_17_2 = 0.001

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2
				local var_17_4 = Vector3.New(0, 100, 0)

				var_17_0.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos404001ui_story, var_17_4, var_17_3)

				local var_17_5 = manager.ui.mainCamera.transform.position - var_17_0.position

				var_17_0.forward = Vector3.New(var_17_5.x, var_17_5.y, var_17_5.z)

				local var_17_6 = var_17_0.localEulerAngles

				var_17_6.z = 0
				var_17_6.x = 0
				var_17_0.localEulerAngles = var_17_6
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 then
				var_17_0.localPosition = Vector3.New(0, 100, 0)

				local var_17_7 = manager.ui.mainCamera.transform.position - var_17_0.position

				var_17_0.forward = Vector3.New(var_17_7.x, var_17_7.y, var_17_7.z)

				local var_17_8 = var_17_0.localEulerAngles

				var_17_8.z = 0
				var_17_8.x = 0
				var_17_0.localEulerAngles = var_17_8
			end

			local var_17_9 = arg_14_1.actors_["1284ui_story"].transform
			local var_17_10 = 0

			if var_17_10 < arg_14_1.time_ and arg_14_1.time_ <= var_17_10 + arg_17_0 then
				arg_14_1.var_.moveOldPos1284ui_story = var_17_9.localPosition
			end

			local var_17_11 = 0.001

			if var_17_10 <= arg_14_1.time_ and arg_14_1.time_ < var_17_10 + var_17_11 then
				local var_17_12 = (arg_14_1.time_ - var_17_10) / var_17_11
				local var_17_13 = Vector3.New(0, 100, 0)

				var_17_9.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1284ui_story, var_17_13, var_17_12)

				local var_17_14 = manager.ui.mainCamera.transform.position - var_17_9.position

				var_17_9.forward = Vector3.New(var_17_14.x, var_17_14.y, var_17_14.z)

				local var_17_15 = var_17_9.localEulerAngles

				var_17_15.z = 0
				var_17_15.x = 0
				var_17_9.localEulerAngles = var_17_15
			end

			if arg_14_1.time_ >= var_17_10 + var_17_11 and arg_14_1.time_ < var_17_10 + var_17_11 + arg_17_0 then
				var_17_9.localPosition = Vector3.New(0, 100, 0)

				local var_17_16 = manager.ui.mainCamera.transform.position - var_17_9.position

				var_17_9.forward = Vector3.New(var_17_16.x, var_17_16.y, var_17_16.z)

				local var_17_17 = var_17_9.localEulerAngles

				var_17_17.z = 0
				var_17_17.x = 0
				var_17_9.localEulerAngles = var_17_17
			end

			local var_17_18 = 0
			local var_17_19 = 1.675

			if var_17_18 < arg_14_1.time_ and arg_14_1.time_ <= var_17_18 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, false)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_20 = arg_14_1:GetWordFromCfg(322071003)
				local var_17_21 = arg_14_1:FormatText(var_17_20.content)

				arg_14_1.text_.text = var_17_21

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_22 = 67
				local var_17_23 = utf8.len(var_17_21)
				local var_17_24 = var_17_22 <= 0 and var_17_19 or var_17_19 * (var_17_23 / var_17_22)

				if var_17_24 > 0 and var_17_19 < var_17_24 then
					arg_14_1.talkMaxDuration = var_17_24

					if var_17_24 + var_17_18 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_24 + var_17_18
					end
				end

				arg_14_1.text_.text = var_17_21
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)
				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_25 = math.max(var_17_19, arg_14_1.talkMaxDuration)

			if var_17_18 <= arg_14_1.time_ and arg_14_1.time_ < var_17_18 + var_17_25 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_18) / var_17_25

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_18 + var_17_25 and arg_14_1.time_ < var_17_18 + var_17_25 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_14_1:InitPlayNodeList()
	end,
	Play322071004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 322071004
		arg_18_1.duration_ = 5

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play322071005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = 0
			local var_21_1 = 1.375

			if var_21_0 < arg_18_1.time_ and arg_18_1.time_ <= var_21_0 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, false)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_2 = arg_18_1:GetWordFromCfg(322071004)
				local var_21_3 = arg_18_1:FormatText(var_21_2.content)

				arg_18_1.text_.text = var_21_3

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_4 = 55
				local var_21_5 = utf8.len(var_21_3)
				local var_21_6 = var_21_4 <= 0 and var_21_1 or var_21_1 * (var_21_5 / var_21_4)

				if var_21_6 > 0 and var_21_1 < var_21_6 then
					arg_18_1.talkMaxDuration = var_21_6

					if var_21_6 + var_21_0 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_6 + var_21_0
					end
				end

				arg_18_1.text_.text = var_21_3
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)
				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_7 = math.max(var_21_1, arg_18_1.talkMaxDuration)

			if var_21_0 <= arg_18_1.time_ and arg_18_1.time_ < var_21_0 + var_21_7 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_0) / var_21_7

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_0 + var_21_7 and arg_18_1.time_ < var_21_0 + var_21_7 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play322071005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 322071005
		arg_22_1.duration_ = 9

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play322071006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = "MS2202"

			if arg_22_1.bgs_[var_25_0] == nil then
				local var_25_1 = Object.Instantiate(arg_22_1.paintGo_)

				var_25_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_25_0)
				var_25_1.name = var_25_0
				var_25_1.transform.parent = arg_22_1.stage_.transform
				var_25_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_22_1.bgs_[var_25_0] = var_25_1
			end

			local var_25_2 = 2

			if var_25_2 < arg_22_1.time_ and arg_22_1.time_ <= var_25_2 + arg_25_0 then
				local var_25_3 = manager.ui.mainCamera.transform.localPosition
				local var_25_4 = Vector3.New(0, 0, 10) + Vector3.New(var_25_3.x, var_25_3.y, 0)
				local var_25_5 = arg_22_1.bgs_.MS2202

				var_25_5.transform.localPosition = var_25_4
				var_25_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_25_6 = var_25_5:GetComponent("SpriteRenderer")

				if var_25_6 and var_25_6.sprite then
					local var_25_7 = (var_25_5.transform.localPosition - var_25_3).z
					local var_25_8 = manager.ui.mainCameraCom_
					local var_25_9 = 2 * var_25_7 * Mathf.Tan(var_25_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_25_10 = var_25_9 * var_25_8.aspect
					local var_25_11 = var_25_6.sprite.bounds.size.x
					local var_25_12 = var_25_6.sprite.bounds.size.y
					local var_25_13 = var_25_10 / var_25_11
					local var_25_14 = var_25_9 / var_25_12
					local var_25_15 = var_25_14 < var_25_13 and var_25_13 or var_25_14

					var_25_5.transform.localScale = Vector3.New(var_25_15, var_25_15, 0)
				end

				for iter_25_0, iter_25_1 in pairs(arg_22_1.bgs_) do
					if iter_25_0 ~= "MS2202" then
						iter_25_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_25_16 = 4

			if var_25_16 < arg_22_1.time_ and arg_22_1.time_ <= var_25_16 + arg_25_0 then
				arg_22_1.allBtn_.enabled = false
			end

			local var_25_17 = 0.3

			if arg_22_1.time_ >= var_25_16 + var_25_17 and arg_22_1.time_ < var_25_16 + var_25_17 + arg_25_0 then
				arg_22_1.allBtn_.enabled = true
			end

			local var_25_18 = 0

			if var_25_18 < arg_22_1.time_ and arg_22_1.time_ <= var_25_18 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_19 = 2

			if var_25_18 <= arg_22_1.time_ and arg_22_1.time_ < var_25_18 + var_25_19 then
				local var_25_20 = (arg_22_1.time_ - var_25_18) / var_25_19
				local var_25_21 = Color.New(0, 0, 0)

				var_25_21.a = Mathf.Lerp(0, 1, var_25_20)
				arg_22_1.mask_.color = var_25_21
			end

			if arg_22_1.time_ >= var_25_18 + var_25_19 and arg_22_1.time_ < var_25_18 + var_25_19 + arg_25_0 then
				local var_25_22 = Color.New(0, 0, 0)

				var_25_22.a = 1
				arg_22_1.mask_.color = var_25_22
			end

			local var_25_23 = 2

			if var_25_23 < arg_22_1.time_ and arg_22_1.time_ <= var_25_23 + arg_25_0 then
				arg_22_1.mask_.enabled = true
				arg_22_1.mask_.raycastTarget = true

				arg_22_1:SetGaussion(false)
			end

			local var_25_24 = 2

			if var_25_23 <= arg_22_1.time_ and arg_22_1.time_ < var_25_23 + var_25_24 then
				local var_25_25 = (arg_22_1.time_ - var_25_23) / var_25_24
				local var_25_26 = Color.New(0, 0, 0)

				var_25_26.a = Mathf.Lerp(1, 0, var_25_25)
				arg_22_1.mask_.color = var_25_26
			end

			if arg_22_1.time_ >= var_25_23 + var_25_24 and arg_22_1.time_ < var_25_23 + var_25_24 + arg_25_0 then
				local var_25_27 = Color.New(0, 0, 0)
				local var_25_28 = 0

				arg_22_1.mask_.enabled = false
				var_25_27.a = var_25_28
				arg_22_1.mask_.color = var_25_27
			end

			local var_25_29 = 0.1
			local var_25_30 = 1

			if var_25_29 < arg_22_1.time_ and arg_22_1.time_ <= var_25_29 + arg_25_0 then
				local var_25_31 = "stop"
				local var_25_32 = "effect"

				arg_22_1:AudioAction(var_25_31, var_25_32, "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_25_33 = 2
			local var_25_34 = 1

			if var_25_33 < arg_22_1.time_ and arg_22_1.time_ <= var_25_33 + arg_25_0 then
				local var_25_35 = "play"
				local var_25_36 = "effect"

				arg_22_1:AudioAction(var_25_35, var_25_36, "se_story_145", "se_story_145_amb_MS2202", "")
			end

			local var_25_37 = arg_22_1.bgs_.MS2202.transform
			local var_25_38 = 2

			if var_25_38 < arg_22_1.time_ and arg_22_1.time_ <= var_25_38 + arg_25_0 then
				arg_22_1.var_.moveOldPosMS2202 = var_25_37.localPosition
			end

			local var_25_39 = 0.001

			if var_25_38 <= arg_22_1.time_ and arg_22_1.time_ < var_25_38 + var_25_39 then
				local var_25_40 = (arg_22_1.time_ - var_25_38) / var_25_39
				local var_25_41 = Vector3.New(0, -0.5, 2.5)

				var_25_37.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPosMS2202, var_25_41, var_25_40)
			end

			if arg_22_1.time_ >= var_25_38 + var_25_39 and arg_22_1.time_ < var_25_38 + var_25_39 + arg_25_0 then
				var_25_37.localPosition = Vector3.New(0, -0.5, 2.5)
			end

			local var_25_42 = arg_22_1.bgs_.MS2202.transform
			local var_25_43 = 2.01666666666667

			if var_25_43 < arg_22_1.time_ and arg_22_1.time_ <= var_25_43 + arg_25_0 then
				arg_22_1.var_.moveOldPosMS2202 = var_25_42.localPosition
			end

			local var_25_44 = 1.98333333333333

			if var_25_43 <= arg_22_1.time_ and arg_22_1.time_ < var_25_43 + var_25_44 then
				local var_25_45 = (arg_22_1.time_ - var_25_43) / var_25_44
				local var_25_46 = Vector3.New(0, -0.5, 2)

				var_25_42.localPosition = Vector3.Lerp(arg_22_1.var_.moveOldPosMS2202, var_25_46, var_25_45)
			end

			if arg_22_1.time_ >= var_25_43 + var_25_44 and arg_22_1.time_ < var_25_43 + var_25_44 + arg_25_0 then
				var_25_42.localPosition = Vector3.New(0, -0.5, 2)
			end

			if arg_22_1.frameCnt_ <= 1 then
				arg_22_1.dialog_:SetActive(false)
			end

			local var_25_47 = 4
			local var_25_48 = 1.4

			if var_25_47 < arg_22_1.time_ and arg_22_1.time_ <= var_25_47 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0

				arg_22_1.dialog_:SetActive(true)

				arg_22_1.dialogCg_.alpha = 0

				local var_25_49 = LeanTween.value(arg_22_1.dialog_, 0, 1, 0.3)

				var_25_49:setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
					arg_22_1.dialogCg_.alpha = arg_26_0
				end))
				var_25_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_22_1.dialog_)
					var_25_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_22_1.duration_ = arg_22_1.duration_ + 0.3

				SetActive(arg_22_1.leftNameGo_, false)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_50 = arg_22_1:GetWordFromCfg(322071005)
				local var_25_51 = arg_22_1:FormatText(var_25_50.content)

				arg_22_1.text_.text = var_25_51

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_52 = 56
				local var_25_53 = utf8.len(var_25_51)
				local var_25_54 = var_25_52 <= 0 and var_25_48 or var_25_48 * (var_25_53 / var_25_52)

				if var_25_54 > 0 and var_25_48 < var_25_54 then
					arg_22_1.talkMaxDuration = var_25_54
					var_25_47 = var_25_47 + 0.3

					if var_25_54 + var_25_47 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_54 + var_25_47
					end
				end

				arg_22_1.text_.text = var_25_51
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)
				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_55 = var_25_47 + 0.3
			local var_25_56 = math.max(var_25_48, arg_22_1.talkMaxDuration)

			if var_25_55 <= arg_22_1.time_ and arg_22_1.time_ < var_25_55 + var_25_56 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_55) / var_25_56

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_55 + var_25_56 and arg_22_1.time_ < var_25_55 + var_25_56 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2202",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.98333333333333,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_22_1:InitPlayNodeList()
	end,
	Play322071006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 322071006
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play322071007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.1
			local var_31_1 = 1

			if var_31_0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				local var_31_2 = "play"
				local var_31_3 = "effect"

				arg_28_1:AudioAction(var_31_2, var_31_3, "se_story_145", "se_story_145_explosion04", "")
			end

			local var_31_4 = manager.ui.mainCamera.transform
			local var_31_5 = 0.1

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 then
				arg_28_1.var_.shakeOldPos = var_31_4.localPosition
			end

			local var_31_6 = 0.733333333333333

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / 0.066
				local var_31_8, var_31_9 = math.modf(var_31_7)

				var_31_4.localPosition = Vector3.New(var_31_9 * 0.13, var_31_9 * 0.13, var_31_9 * 0.13) + arg_28_1.var_.shakeOldPos
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 then
				var_31_4.localPosition = arg_28_1.var_.shakeOldPos
			end

			local var_31_10 = 0
			local var_31_11 = 1.6

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_12 = arg_28_1:GetWordFromCfg(322071006)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_14 = 64
				local var_31_15 = utf8.len(var_31_13)
				local var_31_16 = var_31_14 <= 0 and var_31_11 or var_31_11 * (var_31_15 / var_31_14)

				if var_31_16 > 0 and var_31_11 < var_31_16 then
					arg_28_1.talkMaxDuration = var_31_16

					if var_31_16 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_17 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_17 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_17

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_17 and arg_28_1.time_ < var_31_10 + var_31_17 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play322071007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 322071007
		arg_32_1.duration_ = 2.47

		local var_32_0 = {
			zh = 2.3,
			ja = 2.466
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
				arg_32_0:Play322071008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.3

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_2 = arg_32_1:FormatText(StoryNameCfg[668].name)

				arg_32_1.leftNameTxt_.text = var_35_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(322071007)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 12
				local var_35_6 = utf8.len(var_35_4)
				local var_35_7 = var_35_5 <= 0 and var_35_1 or var_35_1 * (var_35_6 / var_35_5)

				if var_35_7 > 0 and var_35_1 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071007", "story_v_out_322071.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_322071", "322071007", "story_v_out_322071.awb") / 1000

					if var_35_8 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_0
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_322071", "322071007", "story_v_out_322071.awb")

						arg_32_1:RecordAudio("322071007", var_35_9)
						arg_32_1:RecordAudio("322071007", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_322071", "322071007", "story_v_out_322071.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_322071", "322071007", "story_v_out_322071.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_10 and arg_32_1.time_ < var_35_0 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play322071008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 322071008
		arg_36_1.duration_ = 1.9

		local var_36_0 = {
			zh = 1.2,
			ja = 1.9
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
				arg_36_0:Play322071009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0
			local var_39_1 = 0.125

			if var_39_0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_2 = arg_36_1:FormatText(StoryNameCfg[1030].name)

				arg_36_1.leftNameTxt_.text = var_39_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_36_1.callingController_:SetSelectedState("calling")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:GetWordFromCfg(322071008)
				local var_39_4 = arg_36_1:FormatText(var_39_3.content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 5
				local var_39_6 = utf8.len(var_39_4)
				local var_39_7 = var_39_5 <= 0 and var_39_1 or var_39_1 * (var_39_6 / var_39_5)

				if var_39_7 > 0 and var_39_1 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_0
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071008", "story_v_out_322071.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_322071", "322071008", "story_v_out_322071.awb") / 1000

					if var_39_8 + var_39_0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_0
					end

					if var_39_3.prefab_name ~= "" and arg_36_1.actors_[var_39_3.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_3.prefab_name].transform, "story_v_out_322071", "322071008", "story_v_out_322071.awb")

						arg_36_1:RecordAudio("322071008", var_39_9)
						arg_36_1:RecordAudio("322071008", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_322071", "322071008", "story_v_out_322071.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_322071", "322071008", "story_v_out_322071.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_1, arg_36_1.talkMaxDuration)

			if var_39_0 <= arg_36_1.time_ and arg_36_1.time_ < var_39_0 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_0) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_0 + var_39_10 and arg_36_1.time_ < var_39_0 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play322071009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 322071009
		arg_40_1.duration_ = 6.87

		local var_40_0 = {
			zh = 4.866,
			ja = 6.866
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
				arg_40_0:Play322071010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0
			local var_43_1 = 0.55

			if var_43_0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_2 = arg_40_1:FormatText(StoryNameCfg[668].name)

				arg_40_1.leftNameTxt_.text = var_43_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(322071009)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 22
				local var_43_6 = utf8.len(var_43_4)
				local var_43_7 = var_43_5 <= 0 and var_43_1 or var_43_1 * (var_43_6 / var_43_5)

				if var_43_7 > 0 and var_43_1 < var_43_7 then
					arg_40_1.talkMaxDuration = var_43_7

					if var_43_7 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071009", "story_v_out_322071.awb") ~= 0 then
					local var_43_8 = manager.audio:GetVoiceLength("story_v_out_322071", "322071009", "story_v_out_322071.awb") / 1000

					if var_43_8 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_0
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_322071", "322071009", "story_v_out_322071.awb")

						arg_40_1:RecordAudio("322071009", var_43_9)
						arg_40_1:RecordAudio("322071009", var_43_9)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_322071", "322071009", "story_v_out_322071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_322071", "322071009", "story_v_out_322071.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_10 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_10 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_10

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_10 and arg_40_1.time_ < var_43_0 + var_43_10 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play322071010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 322071010
		arg_44_1.duration_ = 7.67

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play322071011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0
			local var_47_1 = 1.075

			if var_47_0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_2 = arg_44_1:FormatText(StoryNameCfg[668].name)

				arg_44_1.leftNameTxt_.text = var_47_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(322071010)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071010", "story_v_out_322071.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_322071", "322071010", "story_v_out_322071.awb") / 1000

					if var_47_8 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_0
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_322071", "322071010", "story_v_out_322071.awb")

						arg_44_1:RecordAudio("322071010", var_47_9)
						arg_44_1:RecordAudio("322071010", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_322071", "322071010", "story_v_out_322071.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_322071", "322071010", "story_v_out_322071.awb")
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
	Play322071011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 322071011
		arg_48_1.duration_ = 4

		local var_48_0 = {
			zh = 4,
			ja = 3.6
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
				arg_48_0:Play322071012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0
			local var_51_1 = 0.475

			if var_51_0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_2 = arg_48_1:FormatText(StoryNameCfg[668].name)

				arg_48_1.leftNameTxt_.text = var_51_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_3 = arg_48_1:GetWordFromCfg(322071011)
				local var_51_4 = arg_48_1:FormatText(var_51_3.content)

				arg_48_1.text_.text = var_51_4

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 19
				local var_51_6 = utf8.len(var_51_4)
				local var_51_7 = var_51_5 <= 0 and var_51_1 or var_51_1 * (var_51_6 / var_51_5)

				if var_51_7 > 0 and var_51_1 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_4
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071011", "story_v_out_322071.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_322071", "322071011", "story_v_out_322071.awb") / 1000

					if var_51_8 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_0
					end

					if var_51_3.prefab_name ~= "" and arg_48_1.actors_[var_51_3.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_3.prefab_name].transform, "story_v_out_322071", "322071011", "story_v_out_322071.awb")

						arg_48_1:RecordAudio("322071011", var_51_9)
						arg_48_1:RecordAudio("322071011", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_322071", "322071011", "story_v_out_322071.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_322071", "322071011", "story_v_out_322071.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_10 and arg_48_1.time_ < var_51_0 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play322071012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 322071012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play322071013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.1
			local var_55_1 = 1

			if var_55_0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				local var_55_2 = "play"
				local var_55_3 = "effect"

				arg_52_1:AudioAction(var_55_2, var_55_3, "se_story_145", "se_story_145_plane02", "")
			end

			local var_55_4 = 0
			local var_55_5 = 1.225

			if var_55_4 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(322071012)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_8 = 49
				local var_55_9 = utf8.len(var_55_7)
				local var_55_10 = var_55_8 <= 0 and var_55_5 or var_55_5 * (var_55_9 / var_55_8)

				if var_55_10 > 0 and var_55_5 < var_55_10 then
					arg_52_1.talkMaxDuration = var_55_10

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_11 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_11 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_11

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_11 and arg_52_1.time_ < var_55_4 + var_55_11 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play322071013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 322071013
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play322071014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = manager.ui.mainCamera.transform
			local var_59_1 = 0.624999999999

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				local var_59_2 = arg_56_1.var_.effect1013
				local var_59_3
				local var_59_4 = var_59_0

				if not var_59_2 then
					var_59_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), var_59_4)
					var_59_2.name = "1013"
					arg_56_1.var_.effect1013 = var_59_2
				else
					var_59_2.transform:SetParent(var_59_4)
				end

				var_59_2.transform.localPosition = Vector3.New(-1.63, 0.55, 3.1)
				var_59_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_59_5 = manager.ui.mainCamera.transform
			local var_59_6 = 3.53333333333333

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				local var_59_7 = arg_56_1.var_.effect1013

				if var_59_7 then
					Object.Destroy(var_59_7)

					arg_56_1.var_.effect1013 = nil
				end
			end

			local var_59_8 = manager.ui.mainCamera.transform
			local var_59_9 = 0.766666666666667

			if var_59_9 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				local var_59_10 = arg_56_1.var_.effect10131
				local var_59_11
				local var_59_12 = var_59_8

				if not var_59_10 then
					var_59_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), var_59_12)
					var_59_10.name = "10131"
					arg_56_1.var_.effect10131 = var_59_10
				else
					var_59_10.transform:SetParent(var_59_12)
				end

				var_59_10.transform.localPosition = Vector3.New(0.94, 0.15, 2)
				var_59_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_59_13 = manager.ui.mainCamera.transform
			local var_59_14 = 3.53333333333333

			if var_59_14 < arg_56_1.time_ and arg_56_1.time_ <= var_59_14 + arg_59_0 then
				local var_59_15 = arg_56_1.var_.effect10131

				if var_59_15 then
					Object.Destroy(var_59_15)

					arg_56_1.var_.effect10131 = nil
				end
			end

			local var_59_16 = manager.ui.mainCamera.transform
			local var_59_17 = 0.966666666666667

			if var_59_17 < arg_56_1.time_ and arg_56_1.time_ <= var_59_17 + arg_59_0 then
				local var_59_18 = arg_56_1.var_.effect10132
				local var_59_19
				local var_59_20 = var_59_16

				if not var_59_18 then
					var_59_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_ripple"), var_59_20)
					var_59_18.name = "10132"
					arg_56_1.var_.effect10132 = var_59_18
				else
					var_59_18.transform:SetParent(var_59_20)
				end

				var_59_18.transform.localPosition = Vector3.New(0, 0.11, 2.5)
				var_59_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_59_21 = manager.ui.mainCamera.transform
			local var_59_22 = 3.53333333333333

			if var_59_22 < arg_56_1.time_ and arg_56_1.time_ <= var_59_22 + arg_59_0 then
				local var_59_23 = arg_56_1.var_.effect10132

				if var_59_23 then
					Object.Destroy(var_59_23)

					arg_56_1.var_.effect10132 = nil
				end
			end

			local var_59_24 = manager.ui.mainCamera.transform
			local var_59_25 = 0.624999999999

			if var_59_25 < arg_56_1.time_ and arg_56_1.time_ <= var_59_25 + arg_59_0 then
				arg_56_1.var_.shakeOldPos = var_59_24.localPosition
			end

			local var_59_26 = 0.108333333334333

			if var_59_25 <= arg_56_1.time_ and arg_56_1.time_ < var_59_25 + var_59_26 then
				local var_59_27 = (arg_56_1.time_ - var_59_25) / 0.066
				local var_59_28, var_59_29 = math.modf(var_59_27)

				var_59_24.localPosition = Vector3.New(var_59_29 * 0.13, var_59_29 * 0.13, var_59_29 * 0.13) + arg_56_1.var_.shakeOldPos
			end

			if arg_56_1.time_ >= var_59_25 + var_59_26 and arg_56_1.time_ < var_59_25 + var_59_26 + arg_59_0 then
				var_59_24.localPosition = arg_56_1.var_.shakeOldPos
			end

			local var_59_30 = manager.ui.mainCamera.transform
			local var_59_31 = 0.766666666666667

			if var_59_31 < arg_56_1.time_ and arg_56_1.time_ <= var_59_31 + arg_59_0 then
				arg_56_1.var_.shakeOldPos = var_59_30.localPosition
			end

			local var_59_32 = 0.133333333333333

			if var_59_31 <= arg_56_1.time_ and arg_56_1.time_ < var_59_31 + var_59_32 then
				local var_59_33 = (arg_56_1.time_ - var_59_31) / 0.066
				local var_59_34, var_59_35 = math.modf(var_59_33)

				var_59_30.localPosition = Vector3.New(var_59_35 * 0.13, var_59_35 * 0.13, var_59_35 * 0.13) + arg_56_1.var_.shakeOldPos
			end

			if arg_56_1.time_ >= var_59_31 + var_59_32 and arg_56_1.time_ < var_59_31 + var_59_32 + arg_59_0 then
				var_59_30.localPosition = arg_56_1.var_.shakeOldPos
			end

			local var_59_36 = manager.ui.mainCamera.transform
			local var_59_37 = 0.966666666666667

			if var_59_37 < arg_56_1.time_ and arg_56_1.time_ <= var_59_37 + arg_59_0 then
				arg_56_1.var_.shakeOldPos = var_59_36.localPosition
			end

			local var_59_38 = 0.133333333333333

			if var_59_37 <= arg_56_1.time_ and arg_56_1.time_ < var_59_37 + var_59_38 then
				local var_59_39 = (arg_56_1.time_ - var_59_37) / 0.066
				local var_59_40, var_59_41 = math.modf(var_59_39)

				var_59_36.localPosition = Vector3.New(var_59_41 * 0.13, var_59_41 * 0.13, var_59_41 * 0.13) + arg_56_1.var_.shakeOldPos
			end

			if arg_56_1.time_ >= var_59_37 + var_59_38 and arg_56_1.time_ < var_59_37 + var_59_38 + arg_59_0 then
				var_59_36.localPosition = arg_56_1.var_.shakeOldPos
			end

			local var_59_42 = 0.606940297875553
			local var_59_43 = 1

			if var_59_42 < arg_56_1.time_ and arg_56_1.time_ <= var_59_42 + arg_59_0 then
				local var_59_44 = "play"
				local var_59_45 = "effect"

				arg_56_1:AudioAction(var_59_44, var_59_45, "se_story_145", "se_story_145_impact", "")
			end

			local var_59_46 = 0
			local var_59_47 = 1.625

			if var_59_46 < arg_56_1.time_ and arg_56_1.time_ <= var_59_46 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_48 = arg_56_1:GetWordFromCfg(322071013)
				local var_59_49 = arg_56_1:FormatText(var_59_48.content)

				arg_56_1.text_.text = var_59_49

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_50 = 65
				local var_59_51 = utf8.len(var_59_49)
				local var_59_52 = var_59_50 <= 0 and var_59_47 or var_59_47 * (var_59_51 / var_59_50)

				if var_59_52 > 0 and var_59_47 < var_59_52 then
					arg_56_1.talkMaxDuration = var_59_52

					if var_59_52 + var_59_46 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_52 + var_59_46
					end
				end

				arg_56_1.text_.text = var_59_49
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_53 = math.max(var_59_47, arg_56_1.talkMaxDuration)

			if var_59_46 <= arg_56_1.time_ and arg_56_1.time_ < var_59_46 + var_59_53 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_46) / var_59_53

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_46 + var_59_53 and arg_56_1.time_ < var_59_46 + var_59_53 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play322071014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 322071014
		arg_60_1.duration_ = 4.63

		local var_60_0 = {
			zh = 3.9,
			ja = 4.633
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
				arg_60_0:Play322071015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.5

			if var_63_0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_2 = arg_60_1:FormatText(StoryNameCfg[668].name)

				arg_60_1.leftNameTxt_.text = var_63_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_3 = arg_60_1:GetWordFromCfg(322071014)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 20
				local var_63_6 = utf8.len(var_63_4)
				local var_63_7 = var_63_5 <= 0 and var_63_1 or var_63_1 * (var_63_6 / var_63_5)

				if var_63_7 > 0 and var_63_1 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071014", "story_v_out_322071.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_322071", "322071014", "story_v_out_322071.awb") / 1000

					if var_63_8 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_322071", "322071014", "story_v_out_322071.awb")

						arg_60_1:RecordAudio("322071014", var_63_9)
						arg_60_1:RecordAudio("322071014", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_322071", "322071014", "story_v_out_322071.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_322071", "322071014", "story_v_out_322071.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_10 and arg_60_1.time_ < var_63_0 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play322071015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 322071015
		arg_64_1.duration_ = 6.47

		local var_64_0 = {
			zh = 3,
			ja = 6.466
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
				arg_64_0:Play322071016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0
			local var_67_1 = 0.35

			if var_67_0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_2 = arg_64_1:FormatText(StoryNameCfg[612].name)

				arg_64_1.leftNameTxt_.text = var_67_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061_split_1")

				arg_64_1.callingController_:SetSelectedState("calling")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(322071015)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 14
				local var_67_6 = utf8.len(var_67_4)
				local var_67_7 = var_67_5 <= 0 and var_67_1 or var_67_1 * (var_67_6 / var_67_5)

				if var_67_7 > 0 and var_67_1 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_0
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071015", "story_v_out_322071.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_322071", "322071015", "story_v_out_322071.awb") / 1000

					if var_67_8 + var_67_0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_0
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_out_322071", "322071015", "story_v_out_322071.awb")

						arg_64_1:RecordAudio("322071015", var_67_9)
						arg_64_1:RecordAudio("322071015", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_322071", "322071015", "story_v_out_322071.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_322071", "322071015", "story_v_out_322071.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_1, arg_64_1.talkMaxDuration)

			if var_67_0 <= arg_64_1.time_ and arg_64_1.time_ < var_67_0 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_0) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_0 + var_67_10 and arg_64_1.time_ < var_67_0 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play322071016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 322071016
		arg_68_1.duration_ = 1.57

		local var_68_0 = {
			zh = 1.333,
			ja = 1.566
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
				arg_68_0:Play322071017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0
			local var_71_1 = 0.125

			if var_71_0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_2 = arg_68_1:FormatText(StoryNameCfg[6].name)

				arg_68_1.leftNameTxt_.text = var_71_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:GetWordFromCfg(322071016)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 5
				local var_71_6 = utf8.len(var_71_4)
				local var_71_7 = var_71_5 <= 0 and var_71_1 or var_71_1 * (var_71_6 / var_71_5)

				if var_71_7 > 0 and var_71_1 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_0
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071016", "story_v_out_322071.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_322071", "322071016", "story_v_out_322071.awb") / 1000

					if var_71_8 + var_71_0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_0
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_322071", "322071016", "story_v_out_322071.awb")

						arg_68_1:RecordAudio("322071016", var_71_9)
						arg_68_1:RecordAudio("322071016", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_322071", "322071016", "story_v_out_322071.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_322071", "322071016", "story_v_out_322071.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_1, arg_68_1.talkMaxDuration)

			if var_71_0 <= arg_68_1.time_ and arg_68_1.time_ < var_71_0 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_0) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_0 + var_71_10 and arg_68_1.time_ < var_71_0 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play322071017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 322071017
		arg_72_1.duration_ = 8.8

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play322071018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 2

			if var_75_0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				local var_75_1 = manager.ui.mainCamera.transform.localPosition
				local var_75_2 = Vector3.New(0, 0, 10) + Vector3.New(var_75_1.x, var_75_1.y, 0)
				local var_75_3 = arg_72_1.bgs_.L17f

				var_75_3.transform.localPosition = var_75_2
				var_75_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_75_4 = var_75_3:GetComponent("SpriteRenderer")

				if var_75_4 and var_75_4.sprite then
					local var_75_5 = (var_75_3.transform.localPosition - var_75_1).z
					local var_75_6 = manager.ui.mainCameraCom_
					local var_75_7 = 2 * var_75_5 * Mathf.Tan(var_75_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_75_8 = var_75_7 * var_75_6.aspect
					local var_75_9 = var_75_4.sprite.bounds.size.x
					local var_75_10 = var_75_4.sprite.bounds.size.y
					local var_75_11 = var_75_8 / var_75_9
					local var_75_12 = var_75_7 / var_75_10
					local var_75_13 = var_75_12 < var_75_11 and var_75_11 or var_75_12

					var_75_3.transform.localScale = Vector3.New(var_75_13, var_75_13, 0)
				end

				for iter_75_0, iter_75_1 in pairs(arg_72_1.bgs_) do
					if iter_75_0 ~= "L17f" then
						iter_75_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_75_14 = 4

			if var_75_14 < arg_72_1.time_ and arg_72_1.time_ <= var_75_14 + arg_75_0 then
				arg_72_1.allBtn_.enabled = false
			end

			local var_75_15 = 0.3

			if arg_72_1.time_ >= var_75_14 + var_75_15 and arg_72_1.time_ < var_75_14 + var_75_15 + arg_75_0 then
				arg_72_1.allBtn_.enabled = true
			end

			local var_75_16 = 0

			if var_75_16 < arg_72_1.time_ and arg_72_1.time_ <= var_75_16 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_17 = 2

			if var_75_16 <= arg_72_1.time_ and arg_72_1.time_ < var_75_16 + var_75_17 then
				local var_75_18 = (arg_72_1.time_ - var_75_16) / var_75_17
				local var_75_19 = Color.New(0, 0, 0)

				var_75_19.a = Mathf.Lerp(0, 1, var_75_18)
				arg_72_1.mask_.color = var_75_19
			end

			if arg_72_1.time_ >= var_75_16 + var_75_17 and arg_72_1.time_ < var_75_16 + var_75_17 + arg_75_0 then
				local var_75_20 = Color.New(0, 0, 0)

				var_75_20.a = 1
				arg_72_1.mask_.color = var_75_20
			end

			local var_75_21 = 2

			if var_75_21 < arg_72_1.time_ and arg_72_1.time_ <= var_75_21 + arg_75_0 then
				arg_72_1.mask_.enabled = true
				arg_72_1.mask_.raycastTarget = true

				arg_72_1:SetGaussion(false)
			end

			local var_75_22 = 2

			if var_75_21 <= arg_72_1.time_ and arg_72_1.time_ < var_75_21 + var_75_22 then
				local var_75_23 = (arg_72_1.time_ - var_75_21) / var_75_22
				local var_75_24 = Color.New(0, 0, 0)

				var_75_24.a = Mathf.Lerp(1, 0, var_75_23)
				arg_72_1.mask_.color = var_75_24
			end

			if arg_72_1.time_ >= var_75_21 + var_75_22 and arg_72_1.time_ < var_75_21 + var_75_22 + arg_75_0 then
				local var_75_25 = Color.New(0, 0, 0)
				local var_75_26 = 0

				arg_72_1.mask_.enabled = false
				var_75_25.a = var_75_26
				arg_72_1.mask_.color = var_75_25
			end

			local var_75_27 = "1061ui_story"

			if arg_72_1.actors_[var_75_27] == nil then
				local var_75_28 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_75_28) then
					local var_75_29 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_72_1.stage_.transform)

					var_75_29.name = var_75_27
					var_75_29.transform.localPosition = Vector3.New(0, 100, 0)
					arg_72_1.actors_[var_75_27] = var_75_29

					local var_75_30 = var_75_29:GetComponentInChildren(typeof(CharacterEffect))

					var_75_30.enabled = true

					local var_75_31 = GameObjectTools.GetOrAddComponent(var_75_29, typeof(DynamicBoneHelper))

					if var_75_31 then
						var_75_31:EnableDynamicBone(false)
					end

					arg_72_1:ShowWeapon(var_75_30.transform, false)

					arg_72_1.var_[var_75_27 .. "Animator"] = var_75_30.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_72_1.var_[var_75_27 .. "Animator"].applyRootMotion = true
					arg_72_1.var_[var_75_27 .. "LipSync"] = var_75_30.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_75_32 = arg_72_1.actors_["1061ui_story"].transform
			local var_75_33 = 3.8

			if var_75_33 < arg_72_1.time_ and arg_72_1.time_ <= var_75_33 + arg_75_0 then
				arg_72_1.var_.moveOldPos1061ui_story = var_75_32.localPosition

				local var_75_34 = "1061ui_story"

				arg_72_1:ShowWeapon(arg_72_1.var_[var_75_34 .. "Animator"].transform, false)
			end

			local var_75_35 = 0.001

			if var_75_33 <= arg_72_1.time_ and arg_72_1.time_ < var_75_33 + var_75_35 then
				local var_75_36 = (arg_72_1.time_ - var_75_33) / var_75_35
				local var_75_37 = Vector3.New(0, -1.18, -6.15)

				var_75_32.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1061ui_story, var_75_37, var_75_36)

				local var_75_38 = manager.ui.mainCamera.transform.position - var_75_32.position

				var_75_32.forward = Vector3.New(var_75_38.x, var_75_38.y, var_75_38.z)

				local var_75_39 = var_75_32.localEulerAngles

				var_75_39.z = 0
				var_75_39.x = 0
				var_75_32.localEulerAngles = var_75_39
			end

			if arg_72_1.time_ >= var_75_33 + var_75_35 and arg_72_1.time_ < var_75_33 + var_75_35 + arg_75_0 then
				var_75_32.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_75_40 = manager.ui.mainCamera.transform.position - var_75_32.position

				var_75_32.forward = Vector3.New(var_75_40.x, var_75_40.y, var_75_40.z)

				local var_75_41 = var_75_32.localEulerAngles

				var_75_41.z = 0
				var_75_41.x = 0
				var_75_32.localEulerAngles = var_75_41
			end

			local var_75_42 = arg_72_1.actors_["1061ui_story"]
			local var_75_43 = 3.8

			if var_75_43 < arg_72_1.time_ and arg_72_1.time_ <= var_75_43 + arg_75_0 and not isNil(var_75_42) and arg_72_1.var_.characterEffect1061ui_story == nil then
				arg_72_1.var_.characterEffect1061ui_story = var_75_42:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_44 = 0.200000002980232

			if var_75_43 <= arg_72_1.time_ and arg_72_1.time_ < var_75_43 + var_75_44 and not isNil(var_75_42) then
				local var_75_45 = (arg_72_1.time_ - var_75_43) / var_75_44

				if arg_72_1.var_.characterEffect1061ui_story and not isNil(var_75_42) then
					arg_72_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= var_75_43 + var_75_44 and arg_72_1.time_ < var_75_43 + var_75_44 + arg_75_0 and not isNil(var_75_42) and arg_72_1.var_.characterEffect1061ui_story then
				arg_72_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_75_46 = 3.8

			if var_75_46 < arg_72_1.time_ and arg_72_1.time_ <= var_75_46 + arg_75_0 then
				arg_72_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_1")
			end

			local var_75_47 = 3.8

			if var_75_47 < arg_72_1.time_ and arg_72_1.time_ <= var_75_47 + arg_75_0 then
				arg_72_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_75_48 = 0.233333333333333
			local var_75_49 = 1

			if var_75_48 < arg_72_1.time_ and arg_72_1.time_ <= var_75_48 + arg_75_0 then
				local var_75_50 = "stop"
				local var_75_51 = "effect"

				arg_72_1:AudioAction(var_75_50, var_75_51, "se_story_145", "se_story_145_amb_MS2202", "")
			end

			local var_75_52 = 1.6
			local var_75_53 = 1

			if var_75_52 < arg_72_1.time_ and arg_72_1.time_ <= var_75_52 + arg_75_0 then
				local var_75_54 = "play"
				local var_75_55 = "effect"

				arg_72_1:AudioAction(var_75_54, var_75_55, "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_75_56 = arg_72_1.actors_["1061ui_story"]
			local var_75_57 = 3.8

			if var_75_57 < arg_72_1.time_ and arg_72_1.time_ <= var_75_57 + arg_75_0 then
				if arg_72_1.var_.characterEffect1061ui_story == nil then
					arg_72_1.var_.characterEffect1061ui_story = var_75_56:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_75_58 = arg_72_1.var_.characterEffect1061ui_story

				var_75_58.imageEffect:turnOff()

				var_75_58.interferenceEffect.enabled = true
				var_75_58.interferenceEffect.noise = 0.001
				var_75_58.interferenceEffect.simTimeScale = 1
				var_75_58.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_75_59 = arg_72_1.actors_["1061ui_story"]
			local var_75_60 = 3.8
			local var_75_61 = 5

			if var_75_60 < arg_72_1.time_ and arg_72_1.time_ <= var_75_60 + arg_75_0 then
				if arg_72_1.var_.characterEffect1061ui_story == nil then
					arg_72_1.var_.characterEffect1061ui_story = var_75_59:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_72_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			if arg_72_1.frameCnt_ <= 1 then
				arg_72_1.dialog_:SetActive(false)
			end

			local var_75_62 = 4
			local var_75_63 = 0.5

			if var_75_62 < arg_72_1.time_ and arg_72_1.time_ <= var_75_62 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0

				arg_72_1.dialog_:SetActive(true)

				arg_72_1.dialogCg_.alpha = 0

				local var_75_64 = LeanTween.value(arg_72_1.dialog_, 0, 1, 0.3)

				var_75_64:setOnUpdate(LuaHelper.FloatAction(function(arg_76_0)
					arg_72_1.dialogCg_.alpha = arg_76_0
				end))
				var_75_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_72_1.dialog_)
					var_75_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_72_1.duration_ = arg_72_1.duration_ + 0.3

				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_65 = arg_72_1:FormatText(StoryNameCfg[612].name)

				arg_72_1.leftNameTxt_.text = var_75_65

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_66 = arg_72_1:GetWordFromCfg(322071017)
				local var_75_67 = arg_72_1:FormatText(var_75_66.content)

				arg_72_1.text_.text = var_75_67

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_68 = 20
				local var_75_69 = utf8.len(var_75_67)
				local var_75_70 = var_75_68 <= 0 and var_75_63 or var_75_63 * (var_75_69 / var_75_68)

				if var_75_70 > 0 and var_75_63 < var_75_70 then
					arg_72_1.talkMaxDuration = var_75_70
					var_75_62 = var_75_62 + 0.3

					if var_75_70 + var_75_62 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_70 + var_75_62
					end
				end

				arg_72_1.text_.text = var_75_67
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071017", "story_v_out_322071.awb") ~= 0 then
					local var_75_71 = manager.audio:GetVoiceLength("story_v_out_322071", "322071017", "story_v_out_322071.awb") / 1000

					if var_75_71 + var_75_62 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_71 + var_75_62
					end

					if var_75_66.prefab_name ~= "" and arg_72_1.actors_[var_75_66.prefab_name] ~= nil then
						local var_75_72 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_66.prefab_name].transform, "story_v_out_322071", "322071017", "story_v_out_322071.awb")

						arg_72_1:RecordAudio("322071017", var_75_72)
						arg_72_1:RecordAudio("322071017", var_75_72)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_322071", "322071017", "story_v_out_322071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_322071", "322071017", "story_v_out_322071.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_73 = var_75_62 + 0.3
			local var_75_74 = math.max(var_75_63, arg_72_1.talkMaxDuration)

			if var_75_73 <= arg_72_1.time_ and arg_72_1.time_ < var_75_73 + var_75_74 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_73) / var_75_74

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_73 + var_75_74 and arg_72_1.time_ < var_75_73 + var_75_74 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play322071018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 322071018
		arg_78_1.duration_ = 13.2

		local var_78_0 = {
			zh = 10.033,
			ja = 13.2
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
				arg_78_0:Play322071019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1061ui_story"]
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				if arg_78_1.var_.characterEffect1061ui_story == nil then
					arg_78_1.var_.characterEffect1061ui_story = var_81_0:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_81_2 = arg_78_1.var_.characterEffect1061ui_story

				var_81_2.imageEffect:turnOff()

				var_81_2.interferenceEffect.enabled = true
				var_81_2.interferenceEffect.noise = 0.001
				var_81_2.interferenceEffect.simTimeScale = 1
				var_81_2.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_81_3 = arg_78_1.actors_["1061ui_story"]
			local var_81_4 = 0
			local var_81_5 = 5

			if var_81_4 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				if arg_78_1.var_.characterEffect1061ui_story == nil then
					arg_78_1.var_.characterEffect1061ui_story = var_81_3:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_78_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_81_6 = 0
			local var_81_7 = 1.25

			if var_81_6 < arg_78_1.time_ and arg_78_1.time_ <= var_81_6 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_8 = arg_78_1:FormatText(StoryNameCfg[612].name)

				arg_78_1.leftNameTxt_.text = var_81_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_9 = arg_78_1:GetWordFromCfg(322071018)
				local var_81_10 = arg_78_1:FormatText(var_81_9.content)

				arg_78_1.text_.text = var_81_10

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_11 = 50
				local var_81_12 = utf8.len(var_81_10)
				local var_81_13 = var_81_11 <= 0 and var_81_7 or var_81_7 * (var_81_12 / var_81_11)

				if var_81_13 > 0 and var_81_7 < var_81_13 then
					arg_78_1.talkMaxDuration = var_81_13

					if var_81_13 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_6
					end
				end

				arg_78_1.text_.text = var_81_10
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071018", "story_v_out_322071.awb") ~= 0 then
					local var_81_14 = manager.audio:GetVoiceLength("story_v_out_322071", "322071018", "story_v_out_322071.awb") / 1000

					if var_81_14 + var_81_6 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_14 + var_81_6
					end

					if var_81_9.prefab_name ~= "" and arg_78_1.actors_[var_81_9.prefab_name] ~= nil then
						local var_81_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_9.prefab_name].transform, "story_v_out_322071", "322071018", "story_v_out_322071.awb")

						arg_78_1:RecordAudio("322071018", var_81_15)
						arg_78_1:RecordAudio("322071018", var_81_15)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_322071", "322071018", "story_v_out_322071.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_322071", "322071018", "story_v_out_322071.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_16 = math.max(var_81_7, arg_78_1.talkMaxDuration)

			if var_81_6 <= arg_78_1.time_ and arg_78_1.time_ < var_81_6 + var_81_16 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_6) / var_81_16

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_6 + var_81_16 and arg_78_1.time_ < var_81_6 + var_81_16 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play322071019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 322071019
		arg_82_1.duration_ = 15.93

		local var_82_0 = {
			zh = 12.333,
			ja = 15.933
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play322071020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action3_2")
			end

			local var_85_1 = 0
			local var_85_2 = 1.475

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_3 = arg_82_1:FormatText(StoryNameCfg[612].name)

				arg_82_1.leftNameTxt_.text = var_85_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_4 = arg_82_1:GetWordFromCfg(322071019)
				local var_85_5 = arg_82_1:FormatText(var_85_4.content)

				arg_82_1.text_.text = var_85_5

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_6 = 59
				local var_85_7 = utf8.len(var_85_5)
				local var_85_8 = var_85_6 <= 0 and var_85_2 or var_85_2 * (var_85_7 / var_85_6)

				if var_85_8 > 0 and var_85_2 < var_85_8 then
					arg_82_1.talkMaxDuration = var_85_8

					if var_85_8 + var_85_1 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_1
					end
				end

				arg_82_1.text_.text = var_85_5
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071019", "story_v_out_322071.awb") ~= 0 then
					local var_85_9 = manager.audio:GetVoiceLength("story_v_out_322071", "322071019", "story_v_out_322071.awb") / 1000

					if var_85_9 + var_85_1 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_1
					end

					if var_85_4.prefab_name ~= "" and arg_82_1.actors_[var_85_4.prefab_name] ~= nil then
						local var_85_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_4.prefab_name].transform, "story_v_out_322071", "322071019", "story_v_out_322071.awb")

						arg_82_1:RecordAudio("322071019", var_85_10)
						arg_82_1:RecordAudio("322071019", var_85_10)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_322071", "322071019", "story_v_out_322071.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_322071", "322071019", "story_v_out_322071.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_11 = math.max(var_85_2, arg_82_1.talkMaxDuration)

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_11 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_1) / var_85_11

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_1 + var_85_11 and arg_82_1.time_ < var_85_1 + var_85_11 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play322071020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 322071020
		arg_86_1.duration_ = 8.67

		local var_86_0 = {
			zh = 5.766,
			ja = 8.666
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
				arg_86_0:Play322071021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["404001ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos404001ui_story = var_89_0.localPosition
			end

			local var_89_2 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2
				local var_89_4 = Vector3.New(0.8, -1.55, -5.5)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos404001ui_story, var_89_4, var_89_3)

				local var_89_5 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_5.x, var_89_5.y, var_89_5.z)

				local var_89_6 = var_89_0.localEulerAngles

				var_89_6.z = 0
				var_89_6.x = 0
				var_89_0.localEulerAngles = var_89_6
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_89_7 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_7.x, var_89_7.y, var_89_7.z)

				local var_89_8 = var_89_0.localEulerAngles

				var_89_8.z = 0
				var_89_8.x = 0
				var_89_0.localEulerAngles = var_89_8
			end

			local var_89_9 = arg_86_1.actors_["1061ui_story"].transform
			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.var_.moveOldPos1061ui_story = var_89_9.localPosition
			end

			local var_89_11 = 0.001

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_11 then
				local var_89_12 = (arg_86_1.time_ - var_89_10) / var_89_11
				local var_89_13 = Vector3.New(-0.7, -1.18, -6.15)

				var_89_9.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1061ui_story, var_89_13, var_89_12)

				local var_89_14 = manager.ui.mainCamera.transform.position - var_89_9.position

				var_89_9.forward = Vector3.New(var_89_14.x, var_89_14.y, var_89_14.z)

				local var_89_15 = var_89_9.localEulerAngles

				var_89_15.z = 0
				var_89_15.x = 0
				var_89_9.localEulerAngles = var_89_15
			end

			if arg_86_1.time_ >= var_89_10 + var_89_11 and arg_86_1.time_ < var_89_10 + var_89_11 + arg_89_0 then
				var_89_9.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_89_16 = manager.ui.mainCamera.transform.position - var_89_9.position

				var_89_9.forward = Vector3.New(var_89_16.x, var_89_16.y, var_89_16.z)

				local var_89_17 = var_89_9.localEulerAngles

				var_89_17.z = 0
				var_89_17.x = 0
				var_89_9.localEulerAngles = var_89_17
			end

			local var_89_18 = arg_86_1.actors_["404001ui_story"]
			local var_89_19 = 0

			if var_89_19 < arg_86_1.time_ and arg_86_1.time_ <= var_89_19 + arg_89_0 and not isNil(var_89_18) and arg_86_1.var_.characterEffect404001ui_story == nil then
				arg_86_1.var_.characterEffect404001ui_story = var_89_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_20 = 0.200000002980232

			if var_89_19 <= arg_86_1.time_ and arg_86_1.time_ < var_89_19 + var_89_20 and not isNil(var_89_18) then
				local var_89_21 = (arg_86_1.time_ - var_89_19) / var_89_20

				if arg_86_1.var_.characterEffect404001ui_story and not isNil(var_89_18) then
					arg_86_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_19 + var_89_20 and arg_86_1.time_ < var_89_19 + var_89_20 + arg_89_0 and not isNil(var_89_18) and arg_86_1.var_.characterEffect404001ui_story then
				arg_86_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_89_22 = arg_86_1.actors_["1061ui_story"]
			local var_89_23 = 0

			if var_89_23 < arg_86_1.time_ and arg_86_1.time_ <= var_89_23 + arg_89_0 and not isNil(var_89_22) and arg_86_1.var_.characterEffect1061ui_story == nil then
				arg_86_1.var_.characterEffect1061ui_story = var_89_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_24 = 0.200000002980232

			if var_89_23 <= arg_86_1.time_ and arg_86_1.time_ < var_89_23 + var_89_24 and not isNil(var_89_22) then
				local var_89_25 = (arg_86_1.time_ - var_89_23) / var_89_24

				if arg_86_1.var_.characterEffect1061ui_story and not isNil(var_89_22) then
					local var_89_26 = Mathf.Lerp(0, 0.5, var_89_25)

					arg_86_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1061ui_story.fillRatio = var_89_26
				end
			end

			if arg_86_1.time_ >= var_89_23 + var_89_24 and arg_86_1.time_ < var_89_23 + var_89_24 + arg_89_0 and not isNil(var_89_22) and arg_86_1.var_.characterEffect1061ui_story then
				local var_89_27 = 0.5

				arg_86_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1061ui_story.fillRatio = var_89_27
			end

			local var_89_28 = 0

			if var_89_28 < arg_86_1.time_ and arg_86_1.time_ <= var_89_28 + arg_89_0 then
				arg_86_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_89_29 = 0

			if var_89_29 < arg_86_1.time_ and arg_86_1.time_ <= var_89_29 + arg_89_0 then
				arg_86_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_89_30 = 0
			local var_89_31 = 0.575

			if var_89_30 < arg_86_1.time_ and arg_86_1.time_ <= var_89_30 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_32 = arg_86_1:FormatText(StoryNameCfg[668].name)

				arg_86_1.leftNameTxt_.text = var_89_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_33 = arg_86_1:GetWordFromCfg(322071020)
				local var_89_34 = arg_86_1:FormatText(var_89_33.content)

				arg_86_1.text_.text = var_89_34

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_35 = 23
				local var_89_36 = utf8.len(var_89_34)
				local var_89_37 = var_89_35 <= 0 and var_89_31 or var_89_31 * (var_89_36 / var_89_35)

				if var_89_37 > 0 and var_89_31 < var_89_37 then
					arg_86_1.talkMaxDuration = var_89_37

					if var_89_37 + var_89_30 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_37 + var_89_30
					end
				end

				arg_86_1.text_.text = var_89_34
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071020", "story_v_out_322071.awb") ~= 0 then
					local var_89_38 = manager.audio:GetVoiceLength("story_v_out_322071", "322071020", "story_v_out_322071.awb") / 1000

					if var_89_38 + var_89_30 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_38 + var_89_30
					end

					if var_89_33.prefab_name ~= "" and arg_86_1.actors_[var_89_33.prefab_name] ~= nil then
						local var_89_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_33.prefab_name].transform, "story_v_out_322071", "322071020", "story_v_out_322071.awb")

						arg_86_1:RecordAudio("322071020", var_89_39)
						arg_86_1:RecordAudio("322071020", var_89_39)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_322071", "322071020", "story_v_out_322071.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_322071", "322071020", "story_v_out_322071.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_40 = math.max(var_89_31, arg_86_1.talkMaxDuration)

			if var_89_30 <= arg_86_1.time_ and arg_86_1.time_ < var_89_30 + var_89_40 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_30) / var_89_40

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_30 + var_89_40 and arg_86_1.time_ < var_89_30 + var_89_40 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_86_1:InitPlayNodeList()
	end,
	Play322071021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 322071021
		arg_90_1.duration_ = 8.3

		local var_90_0 = {
			zh = 6.466,
			ja = 8.3
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
				arg_90_0:Play322071022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1061ui_story"].transform
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.var_.moveOldPos1061ui_story = var_93_0.localPosition
			end

			local var_93_2 = 0.001

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2
				local var_93_4 = Vector3.New(-0.7, -1.18, -6.15)

				var_93_0.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1061ui_story, var_93_4, var_93_3)

				local var_93_5 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_5.x, var_93_5.y, var_93_5.z)

				local var_93_6 = var_93_0.localEulerAngles

				var_93_6.z = 0
				var_93_6.x = 0
				var_93_0.localEulerAngles = var_93_6
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 then
				var_93_0.localPosition = Vector3.New(-0.7, -1.18, -6.15)

				local var_93_7 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_7.x, var_93_7.y, var_93_7.z)

				local var_93_8 = var_93_0.localEulerAngles

				var_93_8.z = 0
				var_93_8.x = 0
				var_93_0.localEulerAngles = var_93_8
			end

			local var_93_9 = arg_90_1.actors_["1061ui_story"]
			local var_93_10 = 0

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 and not isNil(var_93_9) and arg_90_1.var_.characterEffect1061ui_story == nil then
				arg_90_1.var_.characterEffect1061ui_story = var_93_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_11 = 0.200000002980232

			if var_93_10 <= arg_90_1.time_ and arg_90_1.time_ < var_93_10 + var_93_11 and not isNil(var_93_9) then
				local var_93_12 = (arg_90_1.time_ - var_93_10) / var_93_11

				if arg_90_1.var_.characterEffect1061ui_story and not isNil(var_93_9) then
					arg_90_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_10 + var_93_11 and arg_90_1.time_ < var_93_10 + var_93_11 + arg_93_0 and not isNil(var_93_9) and arg_90_1.var_.characterEffect1061ui_story then
				arg_90_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_93_13 = arg_90_1.actors_["404001ui_story"]
			local var_93_14 = 0

			if var_93_14 < arg_90_1.time_ and arg_90_1.time_ <= var_93_14 + arg_93_0 and not isNil(var_93_13) and arg_90_1.var_.characterEffect404001ui_story == nil then
				arg_90_1.var_.characterEffect404001ui_story = var_93_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_15 = 0.200000002980232

			if var_93_14 <= arg_90_1.time_ and arg_90_1.time_ < var_93_14 + var_93_15 and not isNil(var_93_13) then
				local var_93_16 = (arg_90_1.time_ - var_93_14) / var_93_15

				if arg_90_1.var_.characterEffect404001ui_story and not isNil(var_93_13) then
					local var_93_17 = Mathf.Lerp(0, 0.5, var_93_16)

					arg_90_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_90_1.var_.characterEffect404001ui_story.fillRatio = var_93_17
				end
			end

			if arg_90_1.time_ >= var_93_14 + var_93_15 and arg_90_1.time_ < var_93_14 + var_93_15 + arg_93_0 and not isNil(var_93_13) and arg_90_1.var_.characterEffect404001ui_story then
				local var_93_18 = 0.5

				arg_90_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_90_1.var_.characterEffect404001ui_story.fillRatio = var_93_18
			end

			local var_93_19 = 0

			if var_93_19 < arg_90_1.time_ and arg_90_1.time_ <= var_93_19 + arg_93_0 then
				arg_90_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_93_20 = 0

			if var_93_20 < arg_90_1.time_ and arg_90_1.time_ <= var_93_20 + arg_93_0 then
				arg_90_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_93_21 = arg_90_1.actors_["1061ui_story"]
			local var_93_22 = 0

			if var_93_22 < arg_90_1.time_ and arg_90_1.time_ <= var_93_22 + arg_93_0 then
				if arg_90_1.var_.characterEffect1061ui_story == nil then
					arg_90_1.var_.characterEffect1061ui_story = var_93_21:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_93_23 = arg_90_1.var_.characterEffect1061ui_story

				var_93_23.imageEffect:turnOff()

				var_93_23.interferenceEffect.enabled = true
				var_93_23.interferenceEffect.noise = 0.001
				var_93_23.interferenceEffect.simTimeScale = 1
				var_93_23.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_93_24 = arg_90_1.actors_["1061ui_story"]
			local var_93_25 = 0
			local var_93_26 = 5

			if var_93_25 < arg_90_1.time_ and arg_90_1.time_ <= var_93_25 + arg_93_0 then
				if arg_90_1.var_.characterEffect1061ui_story == nil then
					arg_90_1.var_.characterEffect1061ui_story = var_93_24:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_90_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_93_27 = 0
			local var_93_28 = 0.75

			if var_93_27 < arg_90_1.time_ and arg_90_1.time_ <= var_93_27 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_29 = arg_90_1:FormatText(StoryNameCfg[612].name)

				arg_90_1.leftNameTxt_.text = var_93_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_30 = arg_90_1:GetWordFromCfg(322071021)
				local var_93_31 = arg_90_1:FormatText(var_93_30.content)

				arg_90_1.text_.text = var_93_31

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_32 = 30
				local var_93_33 = utf8.len(var_93_31)
				local var_93_34 = var_93_32 <= 0 and var_93_28 or var_93_28 * (var_93_33 / var_93_32)

				if var_93_34 > 0 and var_93_28 < var_93_34 then
					arg_90_1.talkMaxDuration = var_93_34

					if var_93_34 + var_93_27 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_34 + var_93_27
					end
				end

				arg_90_1.text_.text = var_93_31
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071021", "story_v_out_322071.awb") ~= 0 then
					local var_93_35 = manager.audio:GetVoiceLength("story_v_out_322071", "322071021", "story_v_out_322071.awb") / 1000

					if var_93_35 + var_93_27 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_35 + var_93_27
					end

					if var_93_30.prefab_name ~= "" and arg_90_1.actors_[var_93_30.prefab_name] ~= nil then
						local var_93_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_30.prefab_name].transform, "story_v_out_322071", "322071021", "story_v_out_322071.awb")

						arg_90_1:RecordAudio("322071021", var_93_36)
						arg_90_1:RecordAudio("322071021", var_93_36)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_322071", "322071021", "story_v_out_322071.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_322071", "322071021", "story_v_out_322071.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_37 = math.max(var_93_28, arg_90_1.talkMaxDuration)

			if var_93_27 <= arg_90_1.time_ and arg_90_1.time_ < var_93_27 + var_93_37 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_27) / var_93_37

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_27 + var_93_37 and arg_90_1.time_ < var_93_27 + var_93_37 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play322071022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 322071022
		arg_94_1.duration_ = 13.93

		local var_94_0 = {
			zh = 10.833,
			ja = 13.933
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
				arg_94_0:Play322071023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0

			if var_97_0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_0 + arg_97_0 then
				arg_94_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_1")
			end

			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_97_2 = arg_94_1.actors_["1061ui_story"]
			local var_97_3 = 0

			if var_97_3 < arg_94_1.time_ and arg_94_1.time_ <= var_97_3 + arg_97_0 then
				if arg_94_1.var_.characterEffect1061ui_story == nil then
					arg_94_1.var_.characterEffect1061ui_story = var_97_2:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_97_4 = arg_94_1.var_.characterEffect1061ui_story

				var_97_4.imageEffect:turnOff()

				var_97_4.interferenceEffect.enabled = true
				var_97_4.interferenceEffect.noise = 0.001
				var_97_4.interferenceEffect.simTimeScale = 1
				var_97_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_97_5 = arg_94_1.actors_["1061ui_story"]
			local var_97_6 = 0
			local var_97_7 = 5

			if var_97_6 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				if arg_94_1.var_.characterEffect1061ui_story == nil then
					arg_94_1.var_.characterEffect1061ui_story = var_97_5:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_94_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_97_8 = 0
			local var_97_9 = 1.2

			if var_97_8 < arg_94_1.time_ and arg_94_1.time_ <= var_97_8 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_10 = arg_94_1:FormatText(StoryNameCfg[612].name)

				arg_94_1.leftNameTxt_.text = var_97_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_11 = arg_94_1:GetWordFromCfg(322071022)
				local var_97_12 = arg_94_1:FormatText(var_97_11.content)

				arg_94_1.text_.text = var_97_12

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_13 = 48
				local var_97_14 = utf8.len(var_97_12)
				local var_97_15 = var_97_13 <= 0 and var_97_9 or var_97_9 * (var_97_14 / var_97_13)

				if var_97_15 > 0 and var_97_9 < var_97_15 then
					arg_94_1.talkMaxDuration = var_97_15

					if var_97_15 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_15 + var_97_8
					end
				end

				arg_94_1.text_.text = var_97_12
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071022", "story_v_out_322071.awb") ~= 0 then
					local var_97_16 = manager.audio:GetVoiceLength("story_v_out_322071", "322071022", "story_v_out_322071.awb") / 1000

					if var_97_16 + var_97_8 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_16 + var_97_8
					end

					if var_97_11.prefab_name ~= "" and arg_94_1.actors_[var_97_11.prefab_name] ~= nil then
						local var_97_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_11.prefab_name].transform, "story_v_out_322071", "322071022", "story_v_out_322071.awb")

						arg_94_1:RecordAudio("322071022", var_97_17)
						arg_94_1:RecordAudio("322071022", var_97_17)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_322071", "322071022", "story_v_out_322071.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_322071", "322071022", "story_v_out_322071.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_18 = math.max(var_97_9, arg_94_1.talkMaxDuration)

			if var_97_8 <= arg_94_1.time_ and arg_94_1.time_ < var_97_8 + var_97_18 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_8) / var_97_18

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_8 + var_97_18 and arg_94_1.time_ < var_97_8 + var_97_18 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play322071023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 322071023
		arg_98_1.duration_ = 6.53

		local var_98_0 = {
			zh = 6.533,
			ja = 5.733
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play322071024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1061ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				if arg_98_1.var_.characterEffect1061ui_story == nil then
					arg_98_1.var_.characterEffect1061ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_101_2 = arg_98_1.var_.characterEffect1061ui_story

				var_101_2.imageEffect:turnOff()

				var_101_2.interferenceEffect.enabled = true
				var_101_2.interferenceEffect.noise = 0.001
				var_101_2.interferenceEffect.simTimeScale = 1
				var_101_2.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_101_3 = arg_98_1.actors_["1061ui_story"]
			local var_101_4 = 0
			local var_101_5 = 5

			if var_101_4 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				if arg_98_1.var_.characterEffect1061ui_story == nil then
					arg_98_1.var_.characterEffect1061ui_story = var_101_3:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_98_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_101_6 = 0
			local var_101_7 = 0.8

			if var_101_6 < arg_98_1.time_ and arg_98_1.time_ <= var_101_6 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_8 = arg_98_1:FormatText(StoryNameCfg[612].name)

				arg_98_1.leftNameTxt_.text = var_101_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_9 = arg_98_1:GetWordFromCfg(322071023)
				local var_101_10 = arg_98_1:FormatText(var_101_9.content)

				arg_98_1.text_.text = var_101_10

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_11 = 32
				local var_101_12 = utf8.len(var_101_10)
				local var_101_13 = var_101_11 <= 0 and var_101_7 or var_101_7 * (var_101_12 / var_101_11)

				if var_101_13 > 0 and var_101_7 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_6
					end
				end

				arg_98_1.text_.text = var_101_10
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071023", "story_v_out_322071.awb") ~= 0 then
					local var_101_14 = manager.audio:GetVoiceLength("story_v_out_322071", "322071023", "story_v_out_322071.awb") / 1000

					if var_101_14 + var_101_6 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_14 + var_101_6
					end

					if var_101_9.prefab_name ~= "" and arg_98_1.actors_[var_101_9.prefab_name] ~= nil then
						local var_101_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_9.prefab_name].transform, "story_v_out_322071", "322071023", "story_v_out_322071.awb")

						arg_98_1:RecordAudio("322071023", var_101_15)
						arg_98_1:RecordAudio("322071023", var_101_15)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_322071", "322071023", "story_v_out_322071.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_322071", "322071023", "story_v_out_322071.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_16 = math.max(var_101_7, arg_98_1.talkMaxDuration)

			if var_101_6 <= arg_98_1.time_ and arg_98_1.time_ < var_101_6 + var_101_16 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_6) / var_101_16

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_6 + var_101_16 and arg_98_1.time_ < var_101_6 + var_101_16 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play322071024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 322071024
		arg_102_1.duration_ = 5.57

		local var_102_0 = {
			zh = 3.7,
			ja = 5.566
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
				arg_102_0:Play322071025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["404001ui_story"].transform
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 then
				arg_102_1.var_.moveOldPos404001ui_story = var_105_0.localPosition
			end

			local var_105_2 = 0.001

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2
				local var_105_4 = Vector3.New(0.8, -1.55, -5.5)

				var_105_0.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos404001ui_story, var_105_4, var_105_3)

				local var_105_5 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_5.x, var_105_5.y, var_105_5.z)

				local var_105_6 = var_105_0.localEulerAngles

				var_105_6.z = 0
				var_105_6.x = 0
				var_105_0.localEulerAngles = var_105_6
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 then
				var_105_0.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_105_7 = manager.ui.mainCamera.transform.position - var_105_0.position

				var_105_0.forward = Vector3.New(var_105_7.x, var_105_7.y, var_105_7.z)

				local var_105_8 = var_105_0.localEulerAngles

				var_105_8.z = 0
				var_105_8.x = 0
				var_105_0.localEulerAngles = var_105_8
			end

			local var_105_9 = arg_102_1.actors_["404001ui_story"]
			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 and not isNil(var_105_9) and arg_102_1.var_.characterEffect404001ui_story == nil then
				arg_102_1.var_.characterEffect404001ui_story = var_105_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_11 = 0.200000002980232

			if var_105_10 <= arg_102_1.time_ and arg_102_1.time_ < var_105_10 + var_105_11 and not isNil(var_105_9) then
				local var_105_12 = (arg_102_1.time_ - var_105_10) / var_105_11

				if arg_102_1.var_.characterEffect404001ui_story and not isNil(var_105_9) then
					arg_102_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_10 + var_105_11 and arg_102_1.time_ < var_105_10 + var_105_11 + arg_105_0 and not isNil(var_105_9) and arg_102_1.var_.characterEffect404001ui_story then
				arg_102_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_105_13 = arg_102_1.actors_["1061ui_story"]
			local var_105_14 = 0

			if var_105_14 < arg_102_1.time_ and arg_102_1.time_ <= var_105_14 + arg_105_0 and not isNil(var_105_13) and arg_102_1.var_.characterEffect1061ui_story == nil then
				arg_102_1.var_.characterEffect1061ui_story = var_105_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_15 = 0.200000002980232

			if var_105_14 <= arg_102_1.time_ and arg_102_1.time_ < var_105_14 + var_105_15 and not isNil(var_105_13) then
				local var_105_16 = (arg_102_1.time_ - var_105_14) / var_105_15

				if arg_102_1.var_.characterEffect1061ui_story and not isNil(var_105_13) then
					local var_105_17 = Mathf.Lerp(0, 0.5, var_105_16)

					arg_102_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1061ui_story.fillRatio = var_105_17
				end
			end

			if arg_102_1.time_ >= var_105_14 + var_105_15 and arg_102_1.time_ < var_105_14 + var_105_15 + arg_105_0 and not isNil(var_105_13) and arg_102_1.var_.characterEffect1061ui_story then
				local var_105_18 = 0.5

				arg_102_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1061ui_story.fillRatio = var_105_18
			end

			local var_105_19 = 0

			if var_105_19 < arg_102_1.time_ and arg_102_1.time_ <= var_105_19 + arg_105_0 then
				arg_102_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_2")
			end

			local var_105_20 = 0

			if var_105_20 < arg_102_1.time_ and arg_102_1.time_ <= var_105_20 + arg_105_0 then
				arg_102_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_105_21 = 0
			local var_105_22 = 0.325

			if var_105_21 < arg_102_1.time_ and arg_102_1.time_ <= var_105_21 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_23 = arg_102_1:FormatText(StoryNameCfg[668].name)

				arg_102_1.leftNameTxt_.text = var_105_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_24 = arg_102_1:GetWordFromCfg(322071024)
				local var_105_25 = arg_102_1:FormatText(var_105_24.content)

				arg_102_1.text_.text = var_105_25

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_26 = 13
				local var_105_27 = utf8.len(var_105_25)
				local var_105_28 = var_105_26 <= 0 and var_105_22 or var_105_22 * (var_105_27 / var_105_26)

				if var_105_28 > 0 and var_105_22 < var_105_28 then
					arg_102_1.talkMaxDuration = var_105_28

					if var_105_28 + var_105_21 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_28 + var_105_21
					end
				end

				arg_102_1.text_.text = var_105_25
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071024", "story_v_out_322071.awb") ~= 0 then
					local var_105_29 = manager.audio:GetVoiceLength("story_v_out_322071", "322071024", "story_v_out_322071.awb") / 1000

					if var_105_29 + var_105_21 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_29 + var_105_21
					end

					if var_105_24.prefab_name ~= "" and arg_102_1.actors_[var_105_24.prefab_name] ~= nil then
						local var_105_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_24.prefab_name].transform, "story_v_out_322071", "322071024", "story_v_out_322071.awb")

						arg_102_1:RecordAudio("322071024", var_105_30)
						arg_102_1:RecordAudio("322071024", var_105_30)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_322071", "322071024", "story_v_out_322071.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_322071", "322071024", "story_v_out_322071.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_31 = math.max(var_105_22, arg_102_1.talkMaxDuration)

			if var_105_21 <= arg_102_1.time_ and arg_102_1.time_ < var_105_21 + var_105_31 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_21) / var_105_31

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_21 + var_105_31 and arg_102_1.time_ < var_105_21 + var_105_31 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play322071025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 322071025
		arg_106_1.duration_ = 8.57

		local var_106_0 = {
			zh = 8.566,
			ja = 7.866
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
				arg_106_0:Play322071026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = arg_106_1.actors_["1061ui_story"]
			local var_109_1 = 0

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1061ui_story == nil then
				arg_106_1.var_.characterEffect1061ui_story = var_109_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_2 = 0.200000002980232

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_2 and not isNil(var_109_0) then
				local var_109_3 = (arg_106_1.time_ - var_109_1) / var_109_2

				if arg_106_1.var_.characterEffect1061ui_story and not isNil(var_109_0) then
					arg_106_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= var_109_1 + var_109_2 and arg_106_1.time_ < var_109_1 + var_109_2 + arg_109_0 and not isNil(var_109_0) and arg_106_1.var_.characterEffect1061ui_story then
				arg_106_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_109_4 = arg_106_1.actors_["404001ui_story"]
			local var_109_5 = 0

			if var_109_5 < arg_106_1.time_ and arg_106_1.time_ <= var_109_5 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect404001ui_story == nil then
				arg_106_1.var_.characterEffect404001ui_story = var_109_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_6 = 0.200000002980232

			if var_109_5 <= arg_106_1.time_ and arg_106_1.time_ < var_109_5 + var_109_6 and not isNil(var_109_4) then
				local var_109_7 = (arg_106_1.time_ - var_109_5) / var_109_6

				if arg_106_1.var_.characterEffect404001ui_story and not isNil(var_109_4) then
					local var_109_8 = Mathf.Lerp(0, 0.5, var_109_7)

					arg_106_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_106_1.var_.characterEffect404001ui_story.fillRatio = var_109_8
				end
			end

			if arg_106_1.time_ >= var_109_5 + var_109_6 and arg_106_1.time_ < var_109_5 + var_109_6 + arg_109_0 and not isNil(var_109_4) and arg_106_1.var_.characterEffect404001ui_story then
				local var_109_9 = 0.5

				arg_106_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_106_1.var_.characterEffect404001ui_story.fillRatio = var_109_9
			end

			local var_109_10 = 0

			if var_109_10 < arg_106_1.time_ and arg_106_1.time_ <= var_109_10 + arg_109_0 then
				arg_106_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action5_2")
			end

			local var_109_11 = 0

			if var_109_11 < arg_106_1.time_ and arg_106_1.time_ <= var_109_11 + arg_109_0 then
				arg_106_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_109_12 = arg_106_1.actors_["1061ui_story"]
			local var_109_13 = 0

			if var_109_13 < arg_106_1.time_ and arg_106_1.time_ <= var_109_13 + arg_109_0 then
				if arg_106_1.var_.characterEffect1061ui_story == nil then
					arg_106_1.var_.characterEffect1061ui_story = var_109_12:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_109_14 = arg_106_1.var_.characterEffect1061ui_story

				var_109_14.imageEffect:turnOff()

				var_109_14.interferenceEffect.enabled = true
				var_109_14.interferenceEffect.noise = 0.001
				var_109_14.interferenceEffect.simTimeScale = 1
				var_109_14.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_109_15 = arg_106_1.actors_["1061ui_story"]
			local var_109_16 = 0
			local var_109_17 = 5

			if var_109_16 < arg_106_1.time_ and arg_106_1.time_ <= var_109_16 + arg_109_0 then
				if arg_106_1.var_.characterEffect1061ui_story == nil then
					arg_106_1.var_.characterEffect1061ui_story = var_109_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_106_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_109_18 = 0
			local var_109_19 = 1.05

			if var_109_18 < arg_106_1.time_ and arg_106_1.time_ <= var_109_18 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_20 = arg_106_1:FormatText(StoryNameCfg[612].name)

				arg_106_1.leftNameTxt_.text = var_109_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_21 = arg_106_1:GetWordFromCfg(322071025)
				local var_109_22 = arg_106_1:FormatText(var_109_21.content)

				arg_106_1.text_.text = var_109_22

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_23 = 42
				local var_109_24 = utf8.len(var_109_22)
				local var_109_25 = var_109_23 <= 0 and var_109_19 or var_109_19 * (var_109_24 / var_109_23)

				if var_109_25 > 0 and var_109_19 < var_109_25 then
					arg_106_1.talkMaxDuration = var_109_25

					if var_109_25 + var_109_18 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_25 + var_109_18
					end
				end

				arg_106_1.text_.text = var_109_22
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071025", "story_v_out_322071.awb") ~= 0 then
					local var_109_26 = manager.audio:GetVoiceLength("story_v_out_322071", "322071025", "story_v_out_322071.awb") / 1000

					if var_109_26 + var_109_18 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_26 + var_109_18
					end

					if var_109_21.prefab_name ~= "" and arg_106_1.actors_[var_109_21.prefab_name] ~= nil then
						local var_109_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_21.prefab_name].transform, "story_v_out_322071", "322071025", "story_v_out_322071.awb")

						arg_106_1:RecordAudio("322071025", var_109_27)
						arg_106_1:RecordAudio("322071025", var_109_27)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_322071", "322071025", "story_v_out_322071.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_322071", "322071025", "story_v_out_322071.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_28 = math.max(var_109_19, arg_106_1.talkMaxDuration)

			if var_109_18 <= arg_106_1.time_ and arg_106_1.time_ < var_109_18 + var_109_28 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_18) / var_109_28

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_18 + var_109_28 and arg_106_1.time_ < var_109_18 + var_109_28 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play322071026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 322071026
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play322071027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0

			if var_113_0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_0 + arg_113_0 then
				arg_110_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_113_2 = arg_110_1.actors_["1061ui_story"]
			local var_113_3 = 0

			if var_113_3 < arg_110_1.time_ and arg_110_1.time_ <= var_113_3 + arg_113_0 then
				if arg_110_1.var_.characterEffect1061ui_story == nil then
					arg_110_1.var_.characterEffect1061ui_story = var_113_2:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_113_4 = arg_110_1.var_.characterEffect1061ui_story

				var_113_4.imageEffect:turnOff()

				var_113_4.interferenceEffect.enabled = true
				var_113_4.interferenceEffect.noise = 0.001
				var_113_4.interferenceEffect.simTimeScale = 1
				var_113_4.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_113_5 = arg_110_1.actors_["1061ui_story"]
			local var_113_6 = 0
			local var_113_7 = 5

			if var_113_6 < arg_110_1.time_ and arg_110_1.time_ <= var_113_6 + arg_113_0 then
				if arg_110_1.var_.characterEffect1061ui_story == nil then
					arg_110_1.var_.characterEffect1061ui_story = var_113_5:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_110_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_113_8 = 0
			local var_113_9 = 0.2

			if var_113_8 < arg_110_1.time_ and arg_110_1.time_ <= var_113_8 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_10 = arg_110_1:FormatText(StoryNameCfg[612].name)

				arg_110_1.leftNameTxt_.text = var_113_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_11 = arg_110_1:GetWordFromCfg(322071026)
				local var_113_12 = arg_110_1:FormatText(var_113_11.content)

				arg_110_1.text_.text = var_113_12

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_13 = 8
				local var_113_14 = utf8.len(var_113_12)
				local var_113_15 = var_113_13 <= 0 and var_113_9 or var_113_9 * (var_113_14 / var_113_13)

				if var_113_15 > 0 and var_113_9 < var_113_15 then
					arg_110_1.talkMaxDuration = var_113_15

					if var_113_15 + var_113_8 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_15 + var_113_8
					end
				end

				arg_110_1.text_.text = var_113_12
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071026", "story_v_out_322071.awb") ~= 0 then
					local var_113_16 = manager.audio:GetVoiceLength("story_v_out_322071", "322071026", "story_v_out_322071.awb") / 1000

					if var_113_16 + var_113_8 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_16 + var_113_8
					end

					if var_113_11.prefab_name ~= "" and arg_110_1.actors_[var_113_11.prefab_name] ~= nil then
						local var_113_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_11.prefab_name].transform, "story_v_out_322071", "322071026", "story_v_out_322071.awb")

						arg_110_1:RecordAudio("322071026", var_113_17)
						arg_110_1:RecordAudio("322071026", var_113_17)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_322071", "322071026", "story_v_out_322071.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_322071", "322071026", "story_v_out_322071.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_18 = math.max(var_113_9, arg_110_1.talkMaxDuration)

			if var_113_8 <= arg_110_1.time_ and arg_110_1.time_ < var_113_8 + var_113_18 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_8) / var_113_18

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_8 + var_113_18 and arg_110_1.time_ < var_113_8 + var_113_18 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play322071027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 322071027
		arg_114_1.duration_ = 2.87

		local var_114_0 = {
			zh = 2,
			ja = 2.866
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
				arg_114_0:Play322071028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["404001ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect404001ui_story == nil then
				arg_114_1.var_.characterEffect404001ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect404001ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect404001ui_story then
				arg_114_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_117_4 = arg_114_1.actors_["1061ui_story"]
			local var_117_5 = 0

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1061ui_story == nil then
				arg_114_1.var_.characterEffect1061ui_story = var_117_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.200000002980232

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 and not isNil(var_117_4) then
				local var_117_7 = (arg_114_1.time_ - var_117_5) / var_117_6

				if arg_114_1.var_.characterEffect1061ui_story and not isNil(var_117_4) then
					local var_117_8 = Mathf.Lerp(0, 0.5, var_117_7)

					arg_114_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1061ui_story.fillRatio = var_117_8
				end
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect1061ui_story then
				local var_117_9 = 0.5

				arg_114_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1061ui_story.fillRatio = var_117_9
			end

			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_1")
			end

			local var_117_11 = 0

			if var_117_11 < arg_114_1.time_ and arg_114_1.time_ <= var_117_11 + arg_117_0 then
				arg_114_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_117_12 = 0
			local var_117_13 = 0.15

			if var_117_12 < arg_114_1.time_ and arg_114_1.time_ <= var_117_12 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_14 = arg_114_1:FormatText(StoryNameCfg[668].name)

				arg_114_1.leftNameTxt_.text = var_117_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_15 = arg_114_1:GetWordFromCfg(322071027)
				local var_117_16 = arg_114_1:FormatText(var_117_15.content)

				arg_114_1.text_.text = var_117_16

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_17 = 6
				local var_117_18 = utf8.len(var_117_16)
				local var_117_19 = var_117_17 <= 0 and var_117_13 or var_117_13 * (var_117_18 / var_117_17)

				if var_117_19 > 0 and var_117_13 < var_117_19 then
					arg_114_1.talkMaxDuration = var_117_19

					if var_117_19 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_19 + var_117_12
					end
				end

				arg_114_1.text_.text = var_117_16
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071027", "story_v_out_322071.awb") ~= 0 then
					local var_117_20 = manager.audio:GetVoiceLength("story_v_out_322071", "322071027", "story_v_out_322071.awb") / 1000

					if var_117_20 + var_117_12 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_20 + var_117_12
					end

					if var_117_15.prefab_name ~= "" and arg_114_1.actors_[var_117_15.prefab_name] ~= nil then
						local var_117_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_15.prefab_name].transform, "story_v_out_322071", "322071027", "story_v_out_322071.awb")

						arg_114_1:RecordAudio("322071027", var_117_21)
						arg_114_1:RecordAudio("322071027", var_117_21)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_322071", "322071027", "story_v_out_322071.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_322071", "322071027", "story_v_out_322071.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_22 = math.max(var_117_13, arg_114_1.talkMaxDuration)

			if var_117_12 <= arg_114_1.time_ and arg_114_1.time_ < var_117_12 + var_117_22 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_12) / var_117_22

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_12 + var_117_22 and arg_114_1.time_ < var_117_12 + var_117_22 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play322071028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 322071028
		arg_118_1.duration_ = 11.8

		local var_118_0 = {
			zh = 9.6,
			ja = 11.8
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
				arg_118_0:Play322071029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["1061ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1061ui_story == nil then
				arg_118_1.var_.characterEffect1061ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect1061ui_story and not isNil(var_121_0) then
					arg_118_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect1061ui_story then
				arg_118_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_121_4 = arg_118_1.actors_["404001ui_story"]
			local var_121_5 = 0

			if var_121_5 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect404001ui_story == nil then
				arg_118_1.var_.characterEffect404001ui_story = var_121_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_6 = 0.200000002980232

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 and not isNil(var_121_4) then
				local var_121_7 = (arg_118_1.time_ - var_121_5) / var_121_6

				if arg_118_1.var_.characterEffect404001ui_story and not isNil(var_121_4) then
					local var_121_8 = Mathf.Lerp(0, 0.5, var_121_7)

					arg_118_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_118_1.var_.characterEffect404001ui_story.fillRatio = var_121_8
				end
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect404001ui_story then
				local var_121_9 = 0.5

				arg_118_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_118_1.var_.characterEffect404001ui_story.fillRatio = var_121_9
			end

			local var_121_10 = 0

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_121_11 = 0

			if var_121_11 < arg_118_1.time_ and arg_118_1.time_ <= var_121_11 + arg_121_0 then
				arg_118_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_121_12 = arg_118_1.actors_["1061ui_story"]
			local var_121_13 = 0

			if var_121_13 < arg_118_1.time_ and arg_118_1.time_ <= var_121_13 + arg_121_0 then
				if arg_118_1.var_.characterEffect1061ui_story == nil then
					arg_118_1.var_.characterEffect1061ui_story = var_121_12:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_121_14 = arg_118_1.var_.characterEffect1061ui_story

				var_121_14.imageEffect:turnOff()

				var_121_14.interferenceEffect.enabled = true
				var_121_14.interferenceEffect.noise = 0.001
				var_121_14.interferenceEffect.simTimeScale = 1
				var_121_14.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_121_15 = arg_118_1.actors_["1061ui_story"]
			local var_121_16 = 0
			local var_121_17 = 5

			if var_121_16 < arg_118_1.time_ and arg_118_1.time_ <= var_121_16 + arg_121_0 then
				if arg_118_1.var_.characterEffect1061ui_story == nil then
					arg_118_1.var_.characterEffect1061ui_story = var_121_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_118_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_121_18 = 0
			local var_121_19 = 1.125

			if var_121_18 < arg_118_1.time_ and arg_118_1.time_ <= var_121_18 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_20 = arg_118_1:FormatText(StoryNameCfg[612].name)

				arg_118_1.leftNameTxt_.text = var_121_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_21 = arg_118_1:GetWordFromCfg(322071028)
				local var_121_22 = arg_118_1:FormatText(var_121_21.content)

				arg_118_1.text_.text = var_121_22

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_23 = 45
				local var_121_24 = utf8.len(var_121_22)
				local var_121_25 = var_121_23 <= 0 and var_121_19 or var_121_19 * (var_121_24 / var_121_23)

				if var_121_25 > 0 and var_121_19 < var_121_25 then
					arg_118_1.talkMaxDuration = var_121_25

					if var_121_25 + var_121_18 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_25 + var_121_18
					end
				end

				arg_118_1.text_.text = var_121_22
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071028", "story_v_out_322071.awb") ~= 0 then
					local var_121_26 = manager.audio:GetVoiceLength("story_v_out_322071", "322071028", "story_v_out_322071.awb") / 1000

					if var_121_26 + var_121_18 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_26 + var_121_18
					end

					if var_121_21.prefab_name ~= "" and arg_118_1.actors_[var_121_21.prefab_name] ~= nil then
						local var_121_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_21.prefab_name].transform, "story_v_out_322071", "322071028", "story_v_out_322071.awb")

						arg_118_1:RecordAudio("322071028", var_121_27)
						arg_118_1:RecordAudio("322071028", var_121_27)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_322071", "322071028", "story_v_out_322071.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_322071", "322071028", "story_v_out_322071.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_28 = math.max(var_121_19, arg_118_1.talkMaxDuration)

			if var_121_18 <= arg_118_1.time_ and arg_118_1.time_ < var_121_18 + var_121_28 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_18) / var_121_28

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_18 + var_121_28 and arg_118_1.time_ < var_121_18 + var_121_28 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play322071029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 322071029
		arg_122_1.duration_ = 5.9

		local var_122_0 = {
			zh = 4.999999999999,
			ja = 5.9
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
				arg_122_0:Play322071030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_125_1 = arg_122_1.actors_["1061ui_story"]
			local var_125_2 = 0

			if var_125_2 < arg_122_1.time_ and arg_122_1.time_ <= var_125_2 + arg_125_0 then
				if arg_122_1.var_.characterEffect1061ui_story == nil then
					arg_122_1.var_.characterEffect1061ui_story = var_125_1:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_125_3 = arg_122_1.var_.characterEffect1061ui_story

				var_125_3.imageEffect:turnOff()

				var_125_3.interferenceEffect.enabled = true
				var_125_3.interferenceEffect.noise = 0.001
				var_125_3.interferenceEffect.simTimeScale = 1
				var_125_3.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_125_4 = arg_122_1.actors_["1061ui_story"]
			local var_125_5 = 0
			local var_125_6 = 5

			if var_125_5 < arg_122_1.time_ and arg_122_1.time_ <= var_125_5 + arg_125_0 then
				if arg_122_1.var_.characterEffect1061ui_story == nil then
					arg_122_1.var_.characterEffect1061ui_story = var_125_4:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_122_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_125_7 = 0
			local var_125_8 = 0.675

			if var_125_7 < arg_122_1.time_ and arg_122_1.time_ <= var_125_7 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_9 = arg_122_1:FormatText(StoryNameCfg[612].name)

				arg_122_1.leftNameTxt_.text = var_125_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_10 = arg_122_1:GetWordFromCfg(322071029)
				local var_125_11 = arg_122_1:FormatText(var_125_10.content)

				arg_122_1.text_.text = var_125_11

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_12 = 27
				local var_125_13 = utf8.len(var_125_11)
				local var_125_14 = var_125_12 <= 0 and var_125_8 or var_125_8 * (var_125_13 / var_125_12)

				if var_125_14 > 0 and var_125_8 < var_125_14 then
					arg_122_1.talkMaxDuration = var_125_14

					if var_125_14 + var_125_7 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_7
					end
				end

				arg_122_1.text_.text = var_125_11
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071029", "story_v_out_322071.awb") ~= 0 then
					local var_125_15 = manager.audio:GetVoiceLength("story_v_out_322071", "322071029", "story_v_out_322071.awb") / 1000

					if var_125_15 + var_125_7 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_15 + var_125_7
					end

					if var_125_10.prefab_name ~= "" and arg_122_1.actors_[var_125_10.prefab_name] ~= nil then
						local var_125_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_10.prefab_name].transform, "story_v_out_322071", "322071029", "story_v_out_322071.awb")

						arg_122_1:RecordAudio("322071029", var_125_16)
						arg_122_1:RecordAudio("322071029", var_125_16)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_322071", "322071029", "story_v_out_322071.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_322071", "322071029", "story_v_out_322071.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_17 = math.max(var_125_8, arg_122_1.talkMaxDuration)

			if var_125_7 <= arg_122_1.time_ and arg_122_1.time_ < var_125_7 + var_125_17 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_7) / var_125_17

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_7 + var_125_17 and arg_122_1.time_ < var_125_7 + var_125_17 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play322071030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 322071030
		arg_126_1.duration_ = 4.4

		local var_126_0 = {
			zh = 4.4,
			ja = 4.366
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
				arg_126_0:Play322071031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1284ui_story"].transform
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.var_.moveOldPos1284ui_story = var_129_0.localPosition
			end

			local var_129_2 = 0.001

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2
				local var_129_4 = Vector3.New(0.7, -0.985, -6.22)

				var_129_0.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1284ui_story, var_129_4, var_129_3)

				local var_129_5 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_5.x, var_129_5.y, var_129_5.z)

				local var_129_6 = var_129_0.localEulerAngles

				var_129_6.z = 0
				var_129_6.x = 0
				var_129_0.localEulerAngles = var_129_6
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 then
				var_129_0.localPosition = Vector3.New(0.7, -0.985, -6.22)

				local var_129_7 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_7.x, var_129_7.y, var_129_7.z)

				local var_129_8 = var_129_0.localEulerAngles

				var_129_8.z = 0
				var_129_8.x = 0
				var_129_0.localEulerAngles = var_129_8
			end

			local var_129_9 = arg_126_1.actors_["404001ui_story"].transform
			local var_129_10 = 0

			if var_129_10 < arg_126_1.time_ and arg_126_1.time_ <= var_129_10 + arg_129_0 then
				arg_126_1.var_.moveOldPos404001ui_story = var_129_9.localPosition
			end

			local var_129_11 = 0.001

			if var_129_10 <= arg_126_1.time_ and arg_126_1.time_ < var_129_10 + var_129_11 then
				local var_129_12 = (arg_126_1.time_ - var_129_10) / var_129_11
				local var_129_13 = Vector3.New(0, 100, 0)

				var_129_9.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos404001ui_story, var_129_13, var_129_12)

				local var_129_14 = manager.ui.mainCamera.transform.position - var_129_9.position

				var_129_9.forward = Vector3.New(var_129_14.x, var_129_14.y, var_129_14.z)

				local var_129_15 = var_129_9.localEulerAngles

				var_129_15.z = 0
				var_129_15.x = 0
				var_129_9.localEulerAngles = var_129_15
			end

			if arg_126_1.time_ >= var_129_10 + var_129_11 and arg_126_1.time_ < var_129_10 + var_129_11 + arg_129_0 then
				var_129_9.localPosition = Vector3.New(0, 100, 0)

				local var_129_16 = manager.ui.mainCamera.transform.position - var_129_9.position

				var_129_9.forward = Vector3.New(var_129_16.x, var_129_16.y, var_129_16.z)

				local var_129_17 = var_129_9.localEulerAngles

				var_129_17.z = 0
				var_129_17.x = 0
				var_129_9.localEulerAngles = var_129_17
			end

			local var_129_18 = arg_126_1.actors_["1284ui_story"]
			local var_129_19 = 0

			if var_129_19 < arg_126_1.time_ and arg_126_1.time_ <= var_129_19 + arg_129_0 and not isNil(var_129_18) and arg_126_1.var_.characterEffect1284ui_story == nil then
				arg_126_1.var_.characterEffect1284ui_story = var_129_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_20 = 0.200000002980232

			if var_129_19 <= arg_126_1.time_ and arg_126_1.time_ < var_129_19 + var_129_20 and not isNil(var_129_18) then
				local var_129_21 = (arg_126_1.time_ - var_129_19) / var_129_20

				if arg_126_1.var_.characterEffect1284ui_story and not isNil(var_129_18) then
					arg_126_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_19 + var_129_20 and arg_126_1.time_ < var_129_19 + var_129_20 + arg_129_0 and not isNil(var_129_18) and arg_126_1.var_.characterEffect1284ui_story then
				arg_126_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_129_22 = arg_126_1.actors_["1061ui_story"]
			local var_129_23 = 0

			if var_129_23 < arg_126_1.time_ and arg_126_1.time_ <= var_129_23 + arg_129_0 and not isNil(var_129_22) and arg_126_1.var_.characterEffect1061ui_story == nil then
				arg_126_1.var_.characterEffect1061ui_story = var_129_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_24 = 0.200000002980232

			if var_129_23 <= arg_126_1.time_ and arg_126_1.time_ < var_129_23 + var_129_24 and not isNil(var_129_22) then
				local var_129_25 = (arg_126_1.time_ - var_129_23) / var_129_24

				if arg_126_1.var_.characterEffect1061ui_story and not isNil(var_129_22) then
					local var_129_26 = Mathf.Lerp(0, 0.5, var_129_25)

					arg_126_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1061ui_story.fillRatio = var_129_26
				end
			end

			if arg_126_1.time_ >= var_129_23 + var_129_24 and arg_126_1.time_ < var_129_23 + var_129_24 + arg_129_0 and not isNil(var_129_22) and arg_126_1.var_.characterEffect1061ui_story then
				local var_129_27 = 0.5

				arg_126_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1061ui_story.fillRatio = var_129_27
			end

			local var_129_28 = 0

			if var_129_28 < arg_126_1.time_ and arg_126_1.time_ <= var_129_28 + arg_129_0 then
				arg_126_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			local var_129_29 = 0

			if var_129_29 < arg_126_1.time_ and arg_126_1.time_ <= var_129_29 + arg_129_0 then
				arg_126_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_129_30 = 0
			local var_129_31 = 0.575

			if var_129_30 < arg_126_1.time_ and arg_126_1.time_ <= var_129_30 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_32 = arg_126_1:FormatText(StoryNameCfg[6].name)

				arg_126_1.leftNameTxt_.text = var_129_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_33 = arg_126_1:GetWordFromCfg(322071030)
				local var_129_34 = arg_126_1:FormatText(var_129_33.content)

				arg_126_1.text_.text = var_129_34

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_35 = 23
				local var_129_36 = utf8.len(var_129_34)
				local var_129_37 = var_129_35 <= 0 and var_129_31 or var_129_31 * (var_129_36 / var_129_35)

				if var_129_37 > 0 and var_129_31 < var_129_37 then
					arg_126_1.talkMaxDuration = var_129_37

					if var_129_37 + var_129_30 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_37 + var_129_30
					end
				end

				arg_126_1.text_.text = var_129_34
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071030", "story_v_out_322071.awb") ~= 0 then
					local var_129_38 = manager.audio:GetVoiceLength("story_v_out_322071", "322071030", "story_v_out_322071.awb") / 1000

					if var_129_38 + var_129_30 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_38 + var_129_30
					end

					if var_129_33.prefab_name ~= "" and arg_126_1.actors_[var_129_33.prefab_name] ~= nil then
						local var_129_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_33.prefab_name].transform, "story_v_out_322071", "322071030", "story_v_out_322071.awb")

						arg_126_1:RecordAudio("322071030", var_129_39)
						arg_126_1:RecordAudio("322071030", var_129_39)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_322071", "322071030", "story_v_out_322071.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_322071", "322071030", "story_v_out_322071.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_40 = math.max(var_129_31, arg_126_1.talkMaxDuration)

			if var_129_30 <= arg_126_1.time_ and arg_126_1.time_ < var_129_30 + var_129_40 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_30) / var_129_40

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_30 + var_129_40 and arg_126_1.time_ < var_129_30 + var_129_40 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play322071031 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 322071031
		arg_130_1.duration_ = 9.97

		local var_130_0 = {
			zh = 8,
			ja = 9.966
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
				arg_130_0:Play322071032(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = arg_130_1.actors_["1061ui_story"]
			local var_133_1 = 0

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1061ui_story == nil then
				arg_130_1.var_.characterEffect1061ui_story = var_133_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_2 = 0.200000002980232

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_2 and not isNil(var_133_0) then
				local var_133_3 = (arg_130_1.time_ - var_133_1) / var_133_2

				if arg_130_1.var_.characterEffect1061ui_story and not isNil(var_133_0) then
					arg_130_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= var_133_1 + var_133_2 and arg_130_1.time_ < var_133_1 + var_133_2 + arg_133_0 and not isNil(var_133_0) and arg_130_1.var_.characterEffect1061ui_story then
				arg_130_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_133_4 = arg_130_1.actors_["1284ui_story"]
			local var_133_5 = 0

			if var_133_5 < arg_130_1.time_ and arg_130_1.time_ <= var_133_5 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect1284ui_story == nil then
				arg_130_1.var_.characterEffect1284ui_story = var_133_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_6 = 0.200000002980232

			if var_133_5 <= arg_130_1.time_ and arg_130_1.time_ < var_133_5 + var_133_6 and not isNil(var_133_4) then
				local var_133_7 = (arg_130_1.time_ - var_133_5) / var_133_6

				if arg_130_1.var_.characterEffect1284ui_story and not isNil(var_133_4) then
					local var_133_8 = Mathf.Lerp(0, 0.5, var_133_7)

					arg_130_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_130_1.var_.characterEffect1284ui_story.fillRatio = var_133_8
				end
			end

			if arg_130_1.time_ >= var_133_5 + var_133_6 and arg_130_1.time_ < var_133_5 + var_133_6 + arg_133_0 and not isNil(var_133_4) and arg_130_1.var_.characterEffect1284ui_story then
				local var_133_9 = 0.5

				arg_130_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_130_1.var_.characterEffect1284ui_story.fillRatio = var_133_9
			end

			local var_133_10 = 0

			if var_133_10 < arg_130_1.time_ and arg_130_1.time_ <= var_133_10 + arg_133_0 then
				arg_130_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_133_11 = 0

			if var_133_11 < arg_130_1.time_ and arg_130_1.time_ <= var_133_11 + arg_133_0 then
				arg_130_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_133_12 = arg_130_1.actors_["1061ui_story"]
			local var_133_13 = 0

			if var_133_13 < arg_130_1.time_ and arg_130_1.time_ <= var_133_13 + arg_133_0 then
				if arg_130_1.var_.characterEffect1061ui_story == nil then
					arg_130_1.var_.characterEffect1061ui_story = var_133_12:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_133_14 = arg_130_1.var_.characterEffect1061ui_story

				var_133_14.imageEffect:turnOff()

				var_133_14.interferenceEffect.enabled = true
				var_133_14.interferenceEffect.noise = 0.001
				var_133_14.interferenceEffect.simTimeScale = 1
				var_133_14.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_133_15 = arg_130_1.actors_["1061ui_story"]
			local var_133_16 = 0
			local var_133_17 = 5

			if var_133_16 < arg_130_1.time_ and arg_130_1.time_ <= var_133_16 + arg_133_0 then
				if arg_130_1.var_.characterEffect1061ui_story == nil then
					arg_130_1.var_.characterEffect1061ui_story = var_133_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_130_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_133_18 = 0
			local var_133_19 = 0.85

			if var_133_18 < arg_130_1.time_ and arg_130_1.time_ <= var_133_18 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_20 = arg_130_1:FormatText(StoryNameCfg[612].name)

				arg_130_1.leftNameTxt_.text = var_133_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_21 = arg_130_1:GetWordFromCfg(322071031)
				local var_133_22 = arg_130_1:FormatText(var_133_21.content)

				arg_130_1.text_.text = var_133_22

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_23 = 34
				local var_133_24 = utf8.len(var_133_22)
				local var_133_25 = var_133_23 <= 0 and var_133_19 or var_133_19 * (var_133_24 / var_133_23)

				if var_133_25 > 0 and var_133_19 < var_133_25 then
					arg_130_1.talkMaxDuration = var_133_25

					if var_133_25 + var_133_18 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_25 + var_133_18
					end
				end

				arg_130_1.text_.text = var_133_22
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071031", "story_v_out_322071.awb") ~= 0 then
					local var_133_26 = manager.audio:GetVoiceLength("story_v_out_322071", "322071031", "story_v_out_322071.awb") / 1000

					if var_133_26 + var_133_18 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_26 + var_133_18
					end

					if var_133_21.prefab_name ~= "" and arg_130_1.actors_[var_133_21.prefab_name] ~= nil then
						local var_133_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_21.prefab_name].transform, "story_v_out_322071", "322071031", "story_v_out_322071.awb")

						arg_130_1:RecordAudio("322071031", var_133_27)
						arg_130_1:RecordAudio("322071031", var_133_27)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_322071", "322071031", "story_v_out_322071.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_322071", "322071031", "story_v_out_322071.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_28 = math.max(var_133_19, arg_130_1.talkMaxDuration)

			if var_133_18 <= arg_130_1.time_ and arg_130_1.time_ < var_133_18 + var_133_28 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_18) / var_133_28

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_18 + var_133_28 and arg_130_1.time_ < var_133_18 + var_133_28 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play322071032 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 322071032
		arg_134_1.duration_ = 3.43

		local var_134_0 = {
			zh = 1.999999999999,
			ja = 3.433
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play322071033(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = arg_134_1.actors_["404001ui_story"].transform
			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1.var_.moveOldPos404001ui_story = var_137_0.localPosition
			end

			local var_137_2 = 0.001

			if var_137_1 <= arg_134_1.time_ and arg_134_1.time_ < var_137_1 + var_137_2 then
				local var_137_3 = (arg_134_1.time_ - var_137_1) / var_137_2
				local var_137_4 = Vector3.New(0.8, -1.55, -5.5)

				var_137_0.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos404001ui_story, var_137_4, var_137_3)

				local var_137_5 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_5.x, var_137_5.y, var_137_5.z)

				local var_137_6 = var_137_0.localEulerAngles

				var_137_6.z = 0
				var_137_6.x = 0
				var_137_0.localEulerAngles = var_137_6
			end

			if arg_134_1.time_ >= var_137_1 + var_137_2 and arg_134_1.time_ < var_137_1 + var_137_2 + arg_137_0 then
				var_137_0.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_137_7 = manager.ui.mainCamera.transform.position - var_137_0.position

				var_137_0.forward = Vector3.New(var_137_7.x, var_137_7.y, var_137_7.z)

				local var_137_8 = var_137_0.localEulerAngles

				var_137_8.z = 0
				var_137_8.x = 0
				var_137_0.localEulerAngles = var_137_8
			end

			local var_137_9 = arg_134_1.actors_["1284ui_story"].transform
			local var_137_10 = 0

			if var_137_10 < arg_134_1.time_ and arg_134_1.time_ <= var_137_10 + arg_137_0 then
				arg_134_1.var_.moveOldPos1284ui_story = var_137_9.localPosition
			end

			local var_137_11 = 0.001

			if var_137_10 <= arg_134_1.time_ and arg_134_1.time_ < var_137_10 + var_137_11 then
				local var_137_12 = (arg_134_1.time_ - var_137_10) / var_137_11
				local var_137_13 = Vector3.New(0, 100, 0)

				var_137_9.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1284ui_story, var_137_13, var_137_12)

				local var_137_14 = manager.ui.mainCamera.transform.position - var_137_9.position

				var_137_9.forward = Vector3.New(var_137_14.x, var_137_14.y, var_137_14.z)

				local var_137_15 = var_137_9.localEulerAngles

				var_137_15.z = 0
				var_137_15.x = 0
				var_137_9.localEulerAngles = var_137_15
			end

			if arg_134_1.time_ >= var_137_10 + var_137_11 and arg_134_1.time_ < var_137_10 + var_137_11 + arg_137_0 then
				var_137_9.localPosition = Vector3.New(0, 100, 0)

				local var_137_16 = manager.ui.mainCamera.transform.position - var_137_9.position

				var_137_9.forward = Vector3.New(var_137_16.x, var_137_16.y, var_137_16.z)

				local var_137_17 = var_137_9.localEulerAngles

				var_137_17.z = 0
				var_137_17.x = 0
				var_137_9.localEulerAngles = var_137_17
			end

			local var_137_18 = arg_134_1.actors_["404001ui_story"]
			local var_137_19 = 0

			if var_137_19 < arg_134_1.time_ and arg_134_1.time_ <= var_137_19 + arg_137_0 and not isNil(var_137_18) and arg_134_1.var_.characterEffect404001ui_story == nil then
				arg_134_1.var_.characterEffect404001ui_story = var_137_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_20 = 0.200000002980232

			if var_137_19 <= arg_134_1.time_ and arg_134_1.time_ < var_137_19 + var_137_20 and not isNil(var_137_18) then
				local var_137_21 = (arg_134_1.time_ - var_137_19) / var_137_20

				if arg_134_1.var_.characterEffect404001ui_story and not isNil(var_137_18) then
					arg_134_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_19 + var_137_20 and arg_134_1.time_ < var_137_19 + var_137_20 + arg_137_0 and not isNil(var_137_18) and arg_134_1.var_.characterEffect404001ui_story then
				arg_134_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_137_22 = arg_134_1.actors_["1061ui_story"]
			local var_137_23 = 0

			if var_137_23 < arg_134_1.time_ and arg_134_1.time_ <= var_137_23 + arg_137_0 and not isNil(var_137_22) and arg_134_1.var_.characterEffect1061ui_story == nil then
				arg_134_1.var_.characterEffect1061ui_story = var_137_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_24 = 0.200000002980232

			if var_137_23 <= arg_134_1.time_ and arg_134_1.time_ < var_137_23 + var_137_24 and not isNil(var_137_22) then
				local var_137_25 = (arg_134_1.time_ - var_137_23) / var_137_24

				if arg_134_1.var_.characterEffect1061ui_story and not isNil(var_137_22) then
					local var_137_26 = Mathf.Lerp(0, 0.5, var_137_25)

					arg_134_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1061ui_story.fillRatio = var_137_26
				end
			end

			if arg_134_1.time_ >= var_137_23 + var_137_24 and arg_134_1.time_ < var_137_23 + var_137_24 + arg_137_0 and not isNil(var_137_22) and arg_134_1.var_.characterEffect1061ui_story then
				local var_137_27 = 0.5

				arg_134_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1061ui_story.fillRatio = var_137_27
			end

			local var_137_28 = 0

			if var_137_28 < arg_134_1.time_ and arg_134_1.time_ <= var_137_28 + arg_137_0 then
				arg_134_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_2")
			end

			local var_137_29 = 0

			if var_137_29 < arg_134_1.time_ and arg_134_1.time_ <= var_137_29 + arg_137_0 then
				arg_134_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_137_30 = 0
			local var_137_31 = 0.125

			if var_137_30 < arg_134_1.time_ and arg_134_1.time_ <= var_137_30 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_32 = arg_134_1:FormatText(StoryNameCfg[668].name)

				arg_134_1.leftNameTxt_.text = var_137_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_33 = arg_134_1:GetWordFromCfg(322071032)
				local var_137_34 = arg_134_1:FormatText(var_137_33.content)

				arg_134_1.text_.text = var_137_34

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_35 = 5
				local var_137_36 = utf8.len(var_137_34)
				local var_137_37 = var_137_35 <= 0 and var_137_31 or var_137_31 * (var_137_36 / var_137_35)

				if var_137_37 > 0 and var_137_31 < var_137_37 then
					arg_134_1.talkMaxDuration = var_137_37

					if var_137_37 + var_137_30 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_37 + var_137_30
					end
				end

				arg_134_1.text_.text = var_137_34
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071032", "story_v_out_322071.awb") ~= 0 then
					local var_137_38 = manager.audio:GetVoiceLength("story_v_out_322071", "322071032", "story_v_out_322071.awb") / 1000

					if var_137_38 + var_137_30 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_38 + var_137_30
					end

					if var_137_33.prefab_name ~= "" and arg_134_1.actors_[var_137_33.prefab_name] ~= nil then
						local var_137_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_33.prefab_name].transform, "story_v_out_322071", "322071032", "story_v_out_322071.awb")

						arg_134_1:RecordAudio("322071032", var_137_39)
						arg_134_1:RecordAudio("322071032", var_137_39)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_322071", "322071032", "story_v_out_322071.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_322071", "322071032", "story_v_out_322071.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_40 = math.max(var_137_31, arg_134_1.talkMaxDuration)

			if var_137_30 <= arg_134_1.time_ and arg_134_1.time_ < var_137_30 + var_137_40 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_30) / var_137_40

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_30 + var_137_40 and arg_134_1.time_ < var_137_30 + var_137_40 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play322071033 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 322071033
		arg_138_1.duration_ = 5

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
			local var_141_0 = arg_138_1.actors_["1061ui_story"]
			local var_141_1 = 0

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1061ui_story == nil then
				arg_138_1.var_.characterEffect1061ui_story = var_141_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_2 = 0.200000002980232

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_2 and not isNil(var_141_0) then
				local var_141_3 = (arg_138_1.time_ - var_141_1) / var_141_2

				if arg_138_1.var_.characterEffect1061ui_story and not isNil(var_141_0) then
					arg_138_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= var_141_1 + var_141_2 and arg_138_1.time_ < var_141_1 + var_141_2 + arg_141_0 and not isNil(var_141_0) and arg_138_1.var_.characterEffect1061ui_story then
				arg_138_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_141_4 = arg_138_1.actors_["404001ui_story"]
			local var_141_5 = 0

			if var_141_5 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect404001ui_story == nil then
				arg_138_1.var_.characterEffect404001ui_story = var_141_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_6 = 0.200000002980232

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_6 and not isNil(var_141_4) then
				local var_141_7 = (arg_138_1.time_ - var_141_5) / var_141_6

				if arg_138_1.var_.characterEffect404001ui_story and not isNil(var_141_4) then
					local var_141_8 = Mathf.Lerp(0, 0.5, var_141_7)

					arg_138_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_138_1.var_.characterEffect404001ui_story.fillRatio = var_141_8
				end
			end

			if arg_138_1.time_ >= var_141_5 + var_141_6 and arg_138_1.time_ < var_141_5 + var_141_6 + arg_141_0 and not isNil(var_141_4) and arg_138_1.var_.characterEffect404001ui_story then
				local var_141_9 = 0.5

				arg_138_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_138_1.var_.characterEffect404001ui_story.fillRatio = var_141_9
			end

			local var_141_10 = 0

			if var_141_10 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 then
				arg_138_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_2")
			end

			local var_141_11 = 0

			if var_141_11 < arg_138_1.time_ and arg_138_1.time_ <= var_141_11 + arg_141_0 then
				arg_138_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_141_12 = arg_138_1.actors_["1061ui_story"]
			local var_141_13 = 0

			if var_141_13 < arg_138_1.time_ and arg_138_1.time_ <= var_141_13 + arg_141_0 then
				if arg_138_1.var_.characterEffect1061ui_story == nil then
					arg_138_1.var_.characterEffect1061ui_story = var_141_12:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_141_14 = arg_138_1.var_.characterEffect1061ui_story

				var_141_14.imageEffect:turnOff()

				var_141_14.interferenceEffect.enabled = true
				var_141_14.interferenceEffect.noise = 0.001
				var_141_14.interferenceEffect.simTimeScale = 1
				var_141_14.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_141_15 = arg_138_1.actors_["1061ui_story"]
			local var_141_16 = 0
			local var_141_17 = 5

			if var_141_16 < arg_138_1.time_ and arg_138_1.time_ <= var_141_16 + arg_141_0 then
				if arg_138_1.var_.characterEffect1061ui_story == nil then
					arg_138_1.var_.characterEffect1061ui_story = var_141_15:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_138_1.var_.characterEffect1061ui_story.imageEffect:turnOn(false)
			end

			local var_141_18 = 0
			local var_141_19 = 0.125

			if var_141_18 < arg_138_1.time_ and arg_138_1.time_ <= var_141_18 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_20 = arg_138_1:FormatText(StoryNameCfg[612].name)

				arg_138_1.leftNameTxt_.text = var_141_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_21 = arg_138_1:GetWordFromCfg(322071033)
				local var_141_22 = arg_138_1:FormatText(var_141_21.content)

				arg_138_1.text_.text = var_141_22

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_23 = 5
				local var_141_24 = utf8.len(var_141_22)
				local var_141_25 = var_141_23 <= 0 and var_141_19 or var_141_19 * (var_141_24 / var_141_23)

				if var_141_25 > 0 and var_141_19 < var_141_25 then
					arg_138_1.talkMaxDuration = var_141_25

					if var_141_25 + var_141_18 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_25 + var_141_18
					end
				end

				arg_138_1.text_.text = var_141_22
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322071", "322071033", "story_v_out_322071.awb") ~= 0 then
					local var_141_26 = manager.audio:GetVoiceLength("story_v_out_322071", "322071033", "story_v_out_322071.awb") / 1000

					if var_141_26 + var_141_18 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_26 + var_141_18
					end

					if var_141_21.prefab_name ~= "" and arg_138_1.actors_[var_141_21.prefab_name] ~= nil then
						local var_141_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_21.prefab_name].transform, "story_v_out_322071", "322071033", "story_v_out_322071.awb")

						arg_138_1:RecordAudio("322071033", var_141_27)
						arg_138_1:RecordAudio("322071033", var_141_27)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_322071", "322071033", "story_v_out_322071.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_322071", "322071033", "story_v_out_322071.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_28 = math.max(var_141_19, arg_138_1.talkMaxDuration)

			if var_141_18 <= arg_138_1.time_ and arg_138_1.time_ < var_141_18 + var_141_28 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_18) / var_141_28

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_18 + var_141_28 and arg_138_1.time_ < var_141_18 + var_141_28 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L17f",
		"TextureConfig/Background/MS2202"
	},
	voices = {
		"story_v_out_322071.awb"
	}
}
