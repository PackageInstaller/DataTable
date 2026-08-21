return {
	Play322181001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322181001
		arg_1_1.duration_ = 4.87

		local var_1_0 = {
			zh = 4.832999999999,
			ja = 4.865999999999
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
				arg_1_0:Play322181002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L09g"

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
				local var_4_5 = arg_1_1.bgs_.L09g

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
					if iter_4_0 ~= "L09g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2.024999999999

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

			local var_4_24 = "10131ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "10131ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["10131ui_story"].transform
			local var_4_30 = 1.999999999999

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos10131ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0.05, -0.96, -5.8)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10131ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0.05, -0.96, -5.8)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["10131ui_story"]
			local var_4_39 = 1.999999999999

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect10131ui_story == nil then
				arg_1_1.var_.characterEffect10131ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect10131ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect10131ui_story then
				arg_1_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_4_42 = 1.999999999999

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action8_1")
			end

			local var_4_43 = 1.999999999999

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_4_44 = 0
			local var_4_45 = 0.3

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

			local var_4_50 = 0.4
			local var_4_51 = 1

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				local var_4_52 = "play"
				local var_4_53 = "music"

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source")

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

			local var_4_56 = 0.166666666666667
			local var_4_57 = 1

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				local var_4_58 = "play"
				local var_4_59 = "effect"

				arg_1_1:AudioAction(var_4_58, var_4_59, "se_story_145", "se_story_145_amb_dark_L09", "")
			end

			local var_4_60 = 0.41
			local var_4_61 = 1

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				local var_4_62 = "play"
				local var_4_63 = "music"

				arg_1_1:AudioAction(var_4_62, var_4_63, "bgm_activity_4_5_story_serious", "init_story", "bgm_activity_4_5_story_serious.awb")

				local var_4_64 = ""
				local var_4_65 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "init_story")

				if var_4_65 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_65 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_65

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_65
						arg_1_1.bgmTxt2_.text = var_4_65
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

			local var_4_66 = 1.999999999999
			local var_4_67 = 0.325

			if var_4_66 < arg_1_1.time_ and arg_1_1.time_ <= var_4_66 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_68 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_68:setOnUpdate(LuaHelper.FloatAction(function(arg_8_0)
					arg_1_1.dialogCg_.alpha = arg_8_0
				end))
				var_4_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_69 = arg_1_1:FormatText(StoryNameCfg[1178].name)

				arg_1_1.leftNameTxt_.text = var_4_69

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_70 = arg_1_1:GetWordFromCfg(322181001)
				local var_4_71 = arg_1_1:FormatText(var_4_70.content)

				arg_1_1.text_.text = var_4_71

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_72 = 13
				local var_4_73 = utf8.len(var_4_71)
				local var_4_74 = var_4_72 <= 0 and var_4_67 or var_4_67 * (var_4_73 / var_4_72)

				if var_4_74 > 0 and var_4_67 < var_4_74 then
					arg_1_1.talkMaxDuration = var_4_74
					var_4_66 = var_4_66 + 0.3

					if var_4_74 + var_4_66 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_74 + var_4_66
					end
				end

				arg_1_1.text_.text = var_4_71
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181001", "story_v_out_322181.awb") ~= 0 then
					local var_4_75 = manager.audio:GetVoiceLength("story_v_out_322181", "322181001", "story_v_out_322181.awb") / 1000

					if var_4_75 + var_4_66 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_75 + var_4_66
					end

					if var_4_70.prefab_name ~= "" and arg_1_1.actors_[var_4_70.prefab_name] ~= nil then
						local var_4_76 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_70.prefab_name].transform, "story_v_out_322181", "322181001", "story_v_out_322181.awb")

						arg_1_1:RecordAudio("322181001", var_4_76)
						arg_1_1:RecordAudio("322181001", var_4_76)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322181", "322181001", "story_v_out_322181.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322181", "322181001", "story_v_out_322181.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_77 = var_4_66 + 0.3
			local var_4_78 = math.max(var_4_67, arg_1_1.talkMaxDuration)

			if var_4_77 <= arg_1_1.time_ and arg_1_1.time_ < var_4_77 + var_4_78 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_77) / var_4_78

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_77 + var_4_78 and arg_1_1.time_ < var_4_77 + var_4_78 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.999999999999,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322181002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 322181002
		arg_10_1.duration_ = 2.7

		local var_10_0 = {
			zh = 2.6,
			ja = 2.7
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
				arg_10_0:Play322181003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = arg_10_1.actors_["10131ui_story"].transform
			local var_13_1 = 0

			if var_13_1 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 then
				arg_10_1.var_.moveOldPos10131ui_story = var_13_0.localPosition
			end

			local var_13_2 = 0.001

			if var_13_1 <= arg_10_1.time_ and arg_10_1.time_ < var_13_1 + var_13_2 then
				local var_13_3 = (arg_10_1.time_ - var_13_1) / var_13_2
				local var_13_4 = Vector3.New(0.83, -0.96, -5.8)

				var_13_0.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos10131ui_story, var_13_4, var_13_3)

				local var_13_5 = manager.ui.mainCamera.transform.position - var_13_0.position

				var_13_0.forward = Vector3.New(var_13_5.x, var_13_5.y, var_13_5.z)

				local var_13_6 = var_13_0.localEulerAngles

				var_13_6.z = 0
				var_13_6.x = 0
				var_13_0.localEulerAngles = var_13_6
			end

			if arg_10_1.time_ >= var_13_1 + var_13_2 and arg_10_1.time_ < var_13_1 + var_13_2 + arg_13_0 then
				var_13_0.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_13_7 = manager.ui.mainCamera.transform.position - var_13_0.position

				var_13_0.forward = Vector3.New(var_13_7.x, var_13_7.y, var_13_7.z)

				local var_13_8 = var_13_0.localEulerAngles

				var_13_8.z = 0
				var_13_8.x = 0
				var_13_0.localEulerAngles = var_13_8
			end

			local var_13_9 = "1111ui_story"

			if arg_10_1.actors_[var_13_9] == nil then
				local var_13_10 = Asset.Load("Char/" .. "1111ui_story")

				if not isNil(var_13_10) then
					local var_13_11 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_10_1.stage_.transform)

					var_13_11.name = var_13_9
					var_13_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_10_1.actors_[var_13_9] = var_13_11

					local var_13_12 = var_13_11:GetComponentInChildren(typeof(CharacterEffect))

					var_13_12.enabled = true

					local var_13_13 = GameObjectTools.GetOrAddComponent(var_13_11, typeof(DynamicBoneHelper))

					if var_13_13 then
						var_13_13:EnableDynamicBone(false)
					end

					arg_10_1:ShowWeapon(var_13_12.transform, false)

					arg_10_1.var_[var_13_9 .. "Animator"] = var_13_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_10_1.var_[var_13_9 .. "Animator"].applyRootMotion = true
					arg_10_1.var_[var_13_9 .. "LipSync"] = var_13_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_13_14 = arg_10_1.actors_["1111ui_story"].transform
			local var_13_15 = 0

			if var_13_15 < arg_10_1.time_ and arg_10_1.time_ <= var_13_15 + arg_13_0 then
				arg_10_1.var_.moveOldPos1111ui_story = var_13_14.localPosition
			end

			local var_13_16 = 0.001

			if var_13_15 <= arg_10_1.time_ and arg_10_1.time_ < var_13_15 + var_13_16 then
				local var_13_17 = (arg_10_1.time_ - var_13_15) / var_13_16
				local var_13_18 = Vector3.New(-0.79, -0.87, -5.7)

				var_13_14.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1111ui_story, var_13_18, var_13_17)

				local var_13_19 = manager.ui.mainCamera.transform.position - var_13_14.position

				var_13_14.forward = Vector3.New(var_13_19.x, var_13_19.y, var_13_19.z)

				local var_13_20 = var_13_14.localEulerAngles

				var_13_20.z = 0
				var_13_20.x = 0
				var_13_14.localEulerAngles = var_13_20
			end

			if arg_10_1.time_ >= var_13_15 + var_13_16 and arg_10_1.time_ < var_13_15 + var_13_16 + arg_13_0 then
				var_13_14.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_13_21 = manager.ui.mainCamera.transform.position - var_13_14.position

				var_13_14.forward = Vector3.New(var_13_21.x, var_13_21.y, var_13_21.z)

				local var_13_22 = var_13_14.localEulerAngles

				var_13_22.z = 0
				var_13_22.x = 0
				var_13_14.localEulerAngles = var_13_22
			end

			local var_13_23 = arg_10_1.actors_["1111ui_story"]
			local var_13_24 = 0

			if var_13_24 < arg_10_1.time_ and arg_10_1.time_ <= var_13_24 + arg_13_0 and not isNil(var_13_23) and arg_10_1.var_.characterEffect1111ui_story == nil then
				arg_10_1.var_.characterEffect1111ui_story = var_13_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_25 = 0.200000002980232

			if var_13_24 <= arg_10_1.time_ and arg_10_1.time_ < var_13_24 + var_13_25 and not isNil(var_13_23) then
				local var_13_26 = (arg_10_1.time_ - var_13_24) / var_13_25

				if arg_10_1.var_.characterEffect1111ui_story and not isNil(var_13_23) then
					arg_10_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_10_1.time_ >= var_13_24 + var_13_25 and arg_10_1.time_ < var_13_24 + var_13_25 + arg_13_0 and not isNil(var_13_23) and arg_10_1.var_.characterEffect1111ui_story then
				arg_10_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_13_27 = 0

			if var_13_27 < arg_10_1.time_ and arg_10_1.time_ <= var_13_27 + arg_13_0 then
				arg_10_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_13_28 = 0

			if var_13_28 < arg_10_1.time_ and arg_10_1.time_ <= var_13_28 + arg_13_0 then
				arg_10_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_13_29 = arg_10_1.actors_["10131ui_story"]
			local var_13_30 = 0

			if var_13_30 < arg_10_1.time_ and arg_10_1.time_ <= var_13_30 + arg_13_0 and not isNil(var_13_29) and arg_10_1.var_.characterEffect10131ui_story == nil then
				arg_10_1.var_.characterEffect10131ui_story = var_13_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_13_31 = 0.200000002980232

			if var_13_30 <= arg_10_1.time_ and arg_10_1.time_ < var_13_30 + var_13_31 and not isNil(var_13_29) then
				local var_13_32 = (arg_10_1.time_ - var_13_30) / var_13_31

				if arg_10_1.var_.characterEffect10131ui_story and not isNil(var_13_29) then
					local var_13_33 = Mathf.Lerp(0, 0.5, var_13_32)

					arg_10_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_10_1.var_.characterEffect10131ui_story.fillRatio = var_13_33
				end
			end

			if arg_10_1.time_ >= var_13_30 + var_13_31 and arg_10_1.time_ < var_13_30 + var_13_31 + arg_13_0 and not isNil(var_13_29) and arg_10_1.var_.characterEffect10131ui_story then
				local var_13_34 = 0.5

				arg_10_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_10_1.var_.characterEffect10131ui_story.fillRatio = var_13_34
			end

			local var_13_35 = 0
			local var_13_36 = 0.225

			if var_13_35 < arg_10_1.time_ and arg_10_1.time_ <= var_13_35 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, true)

				local var_13_37 = arg_10_1:FormatText(StoryNameCfg[67].name)

				arg_10_1.leftNameTxt_.text = var_13_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_10_1.leftNameTxt_.transform)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1.leftNameTxt_.text)
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_38 = arg_10_1:GetWordFromCfg(322181002)
				local var_13_39 = arg_10_1:FormatText(var_13_38.content)

				arg_10_1.text_.text = var_13_39

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_40 = 9
				local var_13_41 = utf8.len(var_13_39)
				local var_13_42 = var_13_40 <= 0 and var_13_36 or var_13_36 * (var_13_41 / var_13_40)

				if var_13_42 > 0 and var_13_36 < var_13_42 then
					arg_10_1.talkMaxDuration = var_13_42

					if var_13_42 + var_13_35 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_42 + var_13_35
					end
				end

				arg_10_1.text_.text = var_13_39
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181002", "story_v_out_322181.awb") ~= 0 then
					local var_13_43 = manager.audio:GetVoiceLength("story_v_out_322181", "322181002", "story_v_out_322181.awb") / 1000

					if var_13_43 + var_13_35 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_43 + var_13_35
					end

					if var_13_38.prefab_name ~= "" and arg_10_1.actors_[var_13_38.prefab_name] ~= nil then
						local var_13_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_10_1.actors_[var_13_38.prefab_name].transform, "story_v_out_322181", "322181002", "story_v_out_322181.awb")

						arg_10_1:RecordAudio("322181002", var_13_44)
						arg_10_1:RecordAudio("322181002", var_13_44)
					else
						arg_10_1:AudioAction("play", "voice", "story_v_out_322181", "322181002", "story_v_out_322181.awb")
					end

					arg_10_1:RecordHistoryTalkVoice("story_v_out_322181", "322181002", "story_v_out_322181.awb")
				end

				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_45 = math.max(var_13_36, arg_10_1.talkMaxDuration)

			if var_13_35 <= arg_10_1.time_ and arg_10_1.time_ < var_13_35 + var_13_45 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_35) / var_13_45

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_35 + var_13_45 and arg_10_1.time_ < var_13_35 + var_13_45 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
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
	Play322181003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 322181003
		arg_14_1.duration_ = 6.9

		local var_14_0 = {
			zh = 6.133,
			ja = 6.9
		}
		local var_14_1 = manager.audio:GetLocalizationFlag()

		if var_14_0[var_14_1] ~= nil then
			arg_14_1.duration_ = var_14_0[var_14_1]
		end

		SetActive(arg_14_1.tipsGo_, false)

		function arg_14_1.onSingleLineFinish_()
			arg_14_1.onSingleLineUpdate_ = nil
			arg_14_1.onSingleLineFinish_ = nil
			arg_14_1.state_ = "waiting"
		end

		function arg_14_1.playNext_(arg_16_0)
			if arg_16_0 == 1 then
				arg_14_0:Play322181004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["10131ui_story"]
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.characterEffect10131ui_story == nil then
				arg_14_1.var_.characterEffect10131ui_story = var_17_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_2 = 0.200000002980232

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 and not isNil(var_17_0) then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2

				if arg_14_1.var_.characterEffect10131ui_story and not isNil(var_17_0) then
					arg_14_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 and not isNil(var_17_0) and arg_14_1.var_.characterEffect10131ui_story then
				arg_14_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_17_4 = arg_14_1.actors_["1111ui_story"]
			local var_17_5 = 0

			if var_17_5 < arg_14_1.time_ and arg_14_1.time_ <= var_17_5 + arg_17_0 and not isNil(var_17_4) and arg_14_1.var_.characterEffect1111ui_story == nil then
				arg_14_1.var_.characterEffect1111ui_story = var_17_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_6 = 0.200000002980232

			if var_17_5 <= arg_14_1.time_ and arg_14_1.time_ < var_17_5 + var_17_6 and not isNil(var_17_4) then
				local var_17_7 = (arg_14_1.time_ - var_17_5) / var_17_6

				if arg_14_1.var_.characterEffect1111ui_story and not isNil(var_17_4) then
					local var_17_8 = Mathf.Lerp(0, 0.5, var_17_7)

					arg_14_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_14_1.var_.characterEffect1111ui_story.fillRatio = var_17_8
				end
			end

			if arg_14_1.time_ >= var_17_5 + var_17_6 and arg_14_1.time_ < var_17_5 + var_17_6 + arg_17_0 and not isNil(var_17_4) and arg_14_1.var_.characterEffect1111ui_story then
				local var_17_9 = 0.5

				arg_14_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_14_1.var_.characterEffect1111ui_story.fillRatio = var_17_9
			end

			local var_17_10 = 0
			local var_17_11 = 0.675

			if var_17_10 < arg_14_1.time_ and arg_14_1.time_ <= var_17_10 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_12 = arg_14_1:FormatText(StoryNameCfg[1178].name)

				arg_14_1.leftNameTxt_.text = var_17_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_13 = arg_14_1:GetWordFromCfg(322181003)
				local var_17_14 = arg_14_1:FormatText(var_17_13.content)

				arg_14_1.text_.text = var_17_14

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_15 = 27
				local var_17_16 = utf8.len(var_17_14)
				local var_17_17 = var_17_15 <= 0 and var_17_11 or var_17_11 * (var_17_16 / var_17_15)

				if var_17_17 > 0 and var_17_11 < var_17_17 then
					arg_14_1.talkMaxDuration = var_17_17

					if var_17_17 + var_17_10 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_17 + var_17_10
					end
				end

				arg_14_1.text_.text = var_17_14
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181003", "story_v_out_322181.awb") ~= 0 then
					local var_17_18 = manager.audio:GetVoiceLength("story_v_out_322181", "322181003", "story_v_out_322181.awb") / 1000

					if var_17_18 + var_17_10 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_18 + var_17_10
					end

					if var_17_13.prefab_name ~= "" and arg_14_1.actors_[var_17_13.prefab_name] ~= nil then
						local var_17_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_13.prefab_name].transform, "story_v_out_322181", "322181003", "story_v_out_322181.awb")

						arg_14_1:RecordAudio("322181003", var_17_19)
						arg_14_1:RecordAudio("322181003", var_17_19)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_322181", "322181003", "story_v_out_322181.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_322181", "322181003", "story_v_out_322181.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_20 = math.max(var_17_11, arg_14_1.talkMaxDuration)

			if var_17_10 <= arg_14_1.time_ and arg_14_1.time_ < var_17_10 + var_17_20 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_10) / var_17_20

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_10 + var_17_20 and arg_14_1.time_ < var_17_10 + var_17_20 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {}

		arg_14_1:InitPlayNodeList()
	end,
	Play322181004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 322181004
		arg_18_1.duration_ = 3.2

		local var_18_0 = {
			zh = 3.2,
			ja = 3.1
		}
		local var_18_1 = manager.audio:GetLocalizationFlag()

		if var_18_0[var_18_1] ~= nil then
			arg_18_1.duration_ = var_18_0[var_18_1]
		end

		SetActive(arg_18_1.tipsGo_, false)

		function arg_18_1.onSingleLineFinish_()
			arg_18_1.onSingleLineUpdate_ = nil
			arg_18_1.onSingleLineFinish_ = nil
			arg_18_1.state_ = "waiting"
		end

		function arg_18_1.playNext_(arg_20_0)
			if arg_20_0 == 1 then
				arg_18_0:Play322181005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = arg_18_1.actors_["1111ui_story"]
			local var_21_1 = 0

			if var_21_1 < arg_18_1.time_ and arg_18_1.time_ <= var_21_1 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.characterEffect1111ui_story == nil then
				arg_18_1.var_.characterEffect1111ui_story = var_21_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_2 = 0.200000002980232

			if var_21_1 <= arg_18_1.time_ and arg_18_1.time_ < var_21_1 + var_21_2 and not isNil(var_21_0) then
				local var_21_3 = (arg_18_1.time_ - var_21_1) / var_21_2

				if arg_18_1.var_.characterEffect1111ui_story and not isNil(var_21_0) then
					arg_18_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= var_21_1 + var_21_2 and arg_18_1.time_ < var_21_1 + var_21_2 + arg_21_0 and not isNil(var_21_0) and arg_18_1.var_.characterEffect1111ui_story then
				arg_18_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_21_4 = arg_18_1.actors_["10131ui_story"]
			local var_21_5 = 0

			if var_21_5 < arg_18_1.time_ and arg_18_1.time_ <= var_21_5 + arg_21_0 and not isNil(var_21_4) and arg_18_1.var_.characterEffect10131ui_story == nil then
				arg_18_1.var_.characterEffect10131ui_story = var_21_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_6 = 0.200000002980232

			if var_21_5 <= arg_18_1.time_ and arg_18_1.time_ < var_21_5 + var_21_6 and not isNil(var_21_4) then
				local var_21_7 = (arg_18_1.time_ - var_21_5) / var_21_6

				if arg_18_1.var_.characterEffect10131ui_story and not isNil(var_21_4) then
					local var_21_8 = Mathf.Lerp(0, 0.5, var_21_7)

					arg_18_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_18_1.var_.characterEffect10131ui_story.fillRatio = var_21_8
				end
			end

			if arg_18_1.time_ >= var_21_5 + var_21_6 and arg_18_1.time_ < var_21_5 + var_21_6 + arg_21_0 and not isNil(var_21_4) and arg_18_1.var_.characterEffect10131ui_story then
				local var_21_9 = 0.5

				arg_18_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_18_1.var_.characterEffect10131ui_story.fillRatio = var_21_9
			end

			local var_21_10 = 0

			if var_21_10 < arg_18_1.time_ and arg_18_1.time_ <= var_21_10 + arg_21_0 then
				arg_18_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_21_11 = 0
			local var_21_12 = 0.35

			if var_21_11 < arg_18_1.time_ and arg_18_1.time_ <= var_21_11 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_13 = arg_18_1:FormatText(StoryNameCfg[67].name)

				arg_18_1.leftNameTxt_.text = var_21_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_14 = arg_18_1:GetWordFromCfg(322181004)
				local var_21_15 = arg_18_1:FormatText(var_21_14.content)

				arg_18_1.text_.text = var_21_15

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_16 = 14
				local var_21_17 = utf8.len(var_21_15)
				local var_21_18 = var_21_16 <= 0 and var_21_12 or var_21_12 * (var_21_17 / var_21_16)

				if var_21_18 > 0 and var_21_12 < var_21_18 then
					arg_18_1.talkMaxDuration = var_21_18

					if var_21_18 + var_21_11 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_18 + var_21_11
					end
				end

				arg_18_1.text_.text = var_21_15
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181004", "story_v_out_322181.awb") ~= 0 then
					local var_21_19 = manager.audio:GetVoiceLength("story_v_out_322181", "322181004", "story_v_out_322181.awb") / 1000

					if var_21_19 + var_21_11 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_19 + var_21_11
					end

					if var_21_14.prefab_name ~= "" and arg_18_1.actors_[var_21_14.prefab_name] ~= nil then
						local var_21_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_14.prefab_name].transform, "story_v_out_322181", "322181004", "story_v_out_322181.awb")

						arg_18_1:RecordAudio("322181004", var_21_20)
						arg_18_1:RecordAudio("322181004", var_21_20)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_322181", "322181004", "story_v_out_322181.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_322181", "322181004", "story_v_out_322181.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_21 = math.max(var_21_12, arg_18_1.talkMaxDuration)

			if var_21_11 <= arg_18_1.time_ and arg_18_1.time_ < var_21_11 + var_21_21 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_11) / var_21_21

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_11 + var_21_21 and arg_18_1.time_ < var_21_11 + var_21_21 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {}

		arg_18_1:InitPlayNodeList()
	end,
	Play322181005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 322181005
		arg_22_1.duration_ = 5.57

		local var_22_0 = {
			zh = 3.633,
			ja = 5.566
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play322181006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["10131ui_story"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect10131ui_story == nil then
				arg_22_1.var_.characterEffect10131ui_story = var_25_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_2 = 0.200000002980232

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.characterEffect10131ui_story and not isNil(var_25_0) then
					arg_22_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect10131ui_story then
				arg_22_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_25_4 = arg_22_1.actors_["1111ui_story"]
			local var_25_5 = 0

			if var_25_5 < arg_22_1.time_ and arg_22_1.time_ <= var_25_5 + arg_25_0 and not isNil(var_25_4) and arg_22_1.var_.characterEffect1111ui_story == nil then
				arg_22_1.var_.characterEffect1111ui_story = var_25_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_6 = 0.200000002980232

			if var_25_5 <= arg_22_1.time_ and arg_22_1.time_ < var_25_5 + var_25_6 and not isNil(var_25_4) then
				local var_25_7 = (arg_22_1.time_ - var_25_5) / var_25_6

				if arg_22_1.var_.characterEffect1111ui_story and not isNil(var_25_4) then
					local var_25_8 = Mathf.Lerp(0, 0.5, var_25_7)

					arg_22_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_22_1.var_.characterEffect1111ui_story.fillRatio = var_25_8
				end
			end

			if arg_22_1.time_ >= var_25_5 + var_25_6 and arg_22_1.time_ < var_25_5 + var_25_6 + arg_25_0 and not isNil(var_25_4) and arg_22_1.var_.characterEffect1111ui_story then
				local var_25_9 = 0.5

				arg_22_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_22_1.var_.characterEffect1111ui_story.fillRatio = var_25_9
			end

			local var_25_10 = 0

			if var_25_10 < arg_22_1.time_ and arg_22_1.time_ <= var_25_10 + arg_25_0 then
				arg_22_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action8_2")
			end

			local var_25_11 = 0
			local var_25_12 = 0.4

			if var_25_11 < arg_22_1.time_ and arg_22_1.time_ <= var_25_11 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_13 = arg_22_1:FormatText(StoryNameCfg[1178].name)

				arg_22_1.leftNameTxt_.text = var_25_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_14 = arg_22_1:GetWordFromCfg(322181005)
				local var_25_15 = arg_22_1:FormatText(var_25_14.content)

				arg_22_1.text_.text = var_25_15

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_16 = 16
				local var_25_17 = utf8.len(var_25_15)
				local var_25_18 = var_25_16 <= 0 and var_25_12 or var_25_12 * (var_25_17 / var_25_16)

				if var_25_18 > 0 and var_25_12 < var_25_18 then
					arg_22_1.talkMaxDuration = var_25_18

					if var_25_18 + var_25_11 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_18 + var_25_11
					end
				end

				arg_22_1.text_.text = var_25_15
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181005", "story_v_out_322181.awb") ~= 0 then
					local var_25_19 = manager.audio:GetVoiceLength("story_v_out_322181", "322181005", "story_v_out_322181.awb") / 1000

					if var_25_19 + var_25_11 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_19 + var_25_11
					end

					if var_25_14.prefab_name ~= "" and arg_22_1.actors_[var_25_14.prefab_name] ~= nil then
						local var_25_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_14.prefab_name].transform, "story_v_out_322181", "322181005", "story_v_out_322181.awb")

						arg_22_1:RecordAudio("322181005", var_25_20)
						arg_22_1:RecordAudio("322181005", var_25_20)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_322181", "322181005", "story_v_out_322181.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_322181", "322181005", "story_v_out_322181.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_21 = math.max(var_25_12, arg_22_1.talkMaxDuration)

			if var_25_11 <= arg_22_1.time_ and arg_22_1.time_ < var_25_11 + var_25_21 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_11) / var_25_21

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_11 + var_25_21 and arg_22_1.time_ < var_25_11 + var_25_21 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play322181006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 322181006
		arg_26_1.duration_ = 2.7

		local var_26_0 = {
			zh = 1.466,
			ja = 2.7
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play322181007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["1111ui_story"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1111ui_story == nil then
				arg_26_1.var_.characterEffect1111ui_story = var_29_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.200000002980232

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.characterEffect1111ui_story and not isNil(var_29_0) then
					arg_26_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1111ui_story then
				arg_26_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_29_4 = arg_26_1.actors_["10131ui_story"]
			local var_29_5 = 0

			if var_29_5 < arg_26_1.time_ and arg_26_1.time_ <= var_29_5 + arg_29_0 and not isNil(var_29_4) and arg_26_1.var_.characterEffect10131ui_story == nil then
				arg_26_1.var_.characterEffect10131ui_story = var_29_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_6 = 0.200000002980232

			if var_29_5 <= arg_26_1.time_ and arg_26_1.time_ < var_29_5 + var_29_6 and not isNil(var_29_4) then
				local var_29_7 = (arg_26_1.time_ - var_29_5) / var_29_6

				if arg_26_1.var_.characterEffect10131ui_story and not isNil(var_29_4) then
					local var_29_8 = Mathf.Lerp(0, 0.5, var_29_7)

					arg_26_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_26_1.var_.characterEffect10131ui_story.fillRatio = var_29_8
				end
			end

			if arg_26_1.time_ >= var_29_5 + var_29_6 and arg_26_1.time_ < var_29_5 + var_29_6 + arg_29_0 and not isNil(var_29_4) and arg_26_1.var_.characterEffect10131ui_story then
				local var_29_9 = 0.5

				arg_26_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_26_1.var_.characterEffect10131ui_story.fillRatio = var_29_9
			end

			local var_29_10 = 0
			local var_29_11 = 0.125

			if var_29_10 < arg_26_1.time_ and arg_26_1.time_ <= var_29_10 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_12 = arg_26_1:FormatText(StoryNameCfg[67].name)

				arg_26_1.leftNameTxt_.text = var_29_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_13 = arg_26_1:GetWordFromCfg(322181006)
				local var_29_14 = arg_26_1:FormatText(var_29_13.content)

				arg_26_1.text_.text = var_29_14

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_15 = 5
				local var_29_16 = utf8.len(var_29_14)
				local var_29_17 = var_29_15 <= 0 and var_29_11 or var_29_11 * (var_29_16 / var_29_15)

				if var_29_17 > 0 and var_29_11 < var_29_17 then
					arg_26_1.talkMaxDuration = var_29_17

					if var_29_17 + var_29_10 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_17 + var_29_10
					end
				end

				arg_26_1.text_.text = var_29_14
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181006", "story_v_out_322181.awb") ~= 0 then
					local var_29_18 = manager.audio:GetVoiceLength("story_v_out_322181", "322181006", "story_v_out_322181.awb") / 1000

					if var_29_18 + var_29_10 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_18 + var_29_10
					end

					if var_29_13.prefab_name ~= "" and arg_26_1.actors_[var_29_13.prefab_name] ~= nil then
						local var_29_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_13.prefab_name].transform, "story_v_out_322181", "322181006", "story_v_out_322181.awb")

						arg_26_1:RecordAudio("322181006", var_29_19)
						arg_26_1:RecordAudio("322181006", var_29_19)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_322181", "322181006", "story_v_out_322181.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_322181", "322181006", "story_v_out_322181.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_20 = math.max(var_29_11, arg_26_1.talkMaxDuration)

			if var_29_10 <= arg_26_1.time_ and arg_26_1.time_ < var_29_10 + var_29_20 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_10) / var_29_20

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_10 + var_29_20 and arg_26_1.time_ < var_29_10 + var_29_20 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play322181007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 322181007
		arg_30_1.duration_ = 4.87

		local var_30_0 = {
			zh = 4.166,
			ja = 4.866
		}
		local var_30_1 = manager.audio:GetLocalizationFlag()

		if var_30_0[var_30_1] ~= nil then
			arg_30_1.duration_ = var_30_0[var_30_1]
		end

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play322181008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["10131ui_story"]
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect10131ui_story == nil then
				arg_30_1.var_.characterEffect10131ui_story = var_33_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_2 = 0.200000002980232

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 and not isNil(var_33_0) then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2

				if arg_30_1.var_.characterEffect10131ui_story and not isNil(var_33_0) then
					arg_30_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 and not isNil(var_33_0) and arg_30_1.var_.characterEffect10131ui_story then
				arg_30_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_33_4 = arg_30_1.actors_["1111ui_story"]
			local var_33_5 = 0

			if var_33_5 < arg_30_1.time_ and arg_30_1.time_ <= var_33_5 + arg_33_0 and not isNil(var_33_4) and arg_30_1.var_.characterEffect1111ui_story == nil then
				arg_30_1.var_.characterEffect1111ui_story = var_33_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_6 = 0.200000002980232

			if var_33_5 <= arg_30_1.time_ and arg_30_1.time_ < var_33_5 + var_33_6 and not isNil(var_33_4) then
				local var_33_7 = (arg_30_1.time_ - var_33_5) / var_33_6

				if arg_30_1.var_.characterEffect1111ui_story and not isNil(var_33_4) then
					local var_33_8 = Mathf.Lerp(0, 0.5, var_33_7)

					arg_30_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_30_1.var_.characterEffect1111ui_story.fillRatio = var_33_8
				end
			end

			if arg_30_1.time_ >= var_33_5 + var_33_6 and arg_30_1.time_ < var_33_5 + var_33_6 + arg_33_0 and not isNil(var_33_4) and arg_30_1.var_.characterEffect1111ui_story then
				local var_33_9 = 0.5

				arg_30_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_30_1.var_.characterEffect1111ui_story.fillRatio = var_33_9
			end

			local var_33_10 = 0
			local var_33_11 = 0.375

			if var_33_10 < arg_30_1.time_ and arg_30_1.time_ <= var_33_10 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_12 = arg_30_1:FormatText(StoryNameCfg[1178].name)

				arg_30_1.leftNameTxt_.text = var_33_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_13 = arg_30_1:GetWordFromCfg(322181007)
				local var_33_14 = arg_30_1:FormatText(var_33_13.content)

				arg_30_1.text_.text = var_33_14

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_15 = 15
				local var_33_16 = utf8.len(var_33_14)
				local var_33_17 = var_33_15 <= 0 and var_33_11 or var_33_11 * (var_33_16 / var_33_15)

				if var_33_17 > 0 and var_33_11 < var_33_17 then
					arg_30_1.talkMaxDuration = var_33_17

					if var_33_17 + var_33_10 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_17 + var_33_10
					end
				end

				arg_30_1.text_.text = var_33_14
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181007", "story_v_out_322181.awb") ~= 0 then
					local var_33_18 = manager.audio:GetVoiceLength("story_v_out_322181", "322181007", "story_v_out_322181.awb") / 1000

					if var_33_18 + var_33_10 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_18 + var_33_10
					end

					if var_33_13.prefab_name ~= "" and arg_30_1.actors_[var_33_13.prefab_name] ~= nil then
						local var_33_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_13.prefab_name].transform, "story_v_out_322181", "322181007", "story_v_out_322181.awb")

						arg_30_1:RecordAudio("322181007", var_33_19)
						arg_30_1:RecordAudio("322181007", var_33_19)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_322181", "322181007", "story_v_out_322181.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_322181", "322181007", "story_v_out_322181.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_20 = math.max(var_33_11, arg_30_1.talkMaxDuration)

			if var_33_10 <= arg_30_1.time_ and arg_30_1.time_ < var_33_10 + var_33_20 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_10) / var_33_20

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_10 + var_33_20 and arg_30_1.time_ < var_33_10 + var_33_20 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play322181008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 322181008
		arg_34_1.duration_ = 2.57

		local var_34_0 = {
			zh = 1.999999999999,
			ja = 2.566
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play322181009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1111ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1111ui_story == nil then
				arg_34_1.var_.characterEffect1111ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect1111ui_story and not isNil(var_37_0) then
					arg_34_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1111ui_story then
				arg_34_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_37_4 = arg_34_1.actors_["10131ui_story"]
			local var_37_5 = 0

			if var_37_5 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 and not isNil(var_37_4) and arg_34_1.var_.characterEffect10131ui_story == nil then
				arg_34_1.var_.characterEffect10131ui_story = var_37_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_6 = 0.200000002980232

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_6 and not isNil(var_37_4) then
				local var_37_7 = (arg_34_1.time_ - var_37_5) / var_37_6

				if arg_34_1.var_.characterEffect10131ui_story and not isNil(var_37_4) then
					local var_37_8 = Mathf.Lerp(0, 0.5, var_37_7)

					arg_34_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_34_1.var_.characterEffect10131ui_story.fillRatio = var_37_8
				end
			end

			if arg_34_1.time_ >= var_37_5 + var_37_6 and arg_34_1.time_ < var_37_5 + var_37_6 + arg_37_0 and not isNil(var_37_4) and arg_34_1.var_.characterEffect10131ui_story then
				local var_37_9 = 0.5

				arg_34_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_34_1.var_.characterEffect10131ui_story.fillRatio = var_37_9
			end

			local var_37_10 = 0

			if var_37_10 < arg_34_1.time_ and arg_34_1.time_ <= var_37_10 + arg_37_0 then
				arg_34_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_37_11 = 0
			local var_37_12 = 0.1

			if var_37_11 < arg_34_1.time_ and arg_34_1.time_ <= var_37_11 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_13 = arg_34_1:FormatText(StoryNameCfg[67].name)

				arg_34_1.leftNameTxt_.text = var_37_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_14 = arg_34_1:GetWordFromCfg(322181008)
				local var_37_15 = arg_34_1:FormatText(var_37_14.content)

				arg_34_1.text_.text = var_37_15

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_16 = 4
				local var_37_17 = utf8.len(var_37_15)
				local var_37_18 = var_37_16 <= 0 and var_37_12 or var_37_12 * (var_37_17 / var_37_16)

				if var_37_18 > 0 and var_37_12 < var_37_18 then
					arg_34_1.talkMaxDuration = var_37_18

					if var_37_18 + var_37_11 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_18 + var_37_11
					end
				end

				arg_34_1.text_.text = var_37_15
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181008", "story_v_out_322181.awb") ~= 0 then
					local var_37_19 = manager.audio:GetVoiceLength("story_v_out_322181", "322181008", "story_v_out_322181.awb") / 1000

					if var_37_19 + var_37_11 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_19 + var_37_11
					end

					if var_37_14.prefab_name ~= "" and arg_34_1.actors_[var_37_14.prefab_name] ~= nil then
						local var_37_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_14.prefab_name].transform, "story_v_out_322181", "322181008", "story_v_out_322181.awb")

						arg_34_1:RecordAudio("322181008", var_37_20)
						arg_34_1:RecordAudio("322181008", var_37_20)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_322181", "322181008", "story_v_out_322181.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_322181", "322181008", "story_v_out_322181.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_21 = math.max(var_37_12, arg_34_1.talkMaxDuration)

			if var_37_11 <= arg_34_1.time_ and arg_34_1.time_ < var_37_11 + var_37_21 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_11) / var_37_21

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_11 + var_37_21 and arg_34_1.time_ < var_37_11 + var_37_21 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play322181009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 322181009
		arg_38_1.duration_ = 10.2

		local var_38_0 = {
			zh = 7.4,
			ja = 10.2
		}
		local var_38_1 = manager.audio:GetLocalizationFlag()

		if var_38_0[var_38_1] ~= nil then
			arg_38_1.duration_ = var_38_0[var_38_1]
		end

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play322181010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["10131ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect10131ui_story == nil then
				arg_38_1.var_.characterEffect10131ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect10131ui_story and not isNil(var_41_0) then
					arg_38_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect10131ui_story then
				arg_38_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_41_4 = arg_38_1.actors_["1111ui_story"]
			local var_41_5 = 0

			if var_41_5 < arg_38_1.time_ and arg_38_1.time_ <= var_41_5 + arg_41_0 and not isNil(var_41_4) and arg_38_1.var_.characterEffect1111ui_story == nil then
				arg_38_1.var_.characterEffect1111ui_story = var_41_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_6 = 0.200000002980232

			if var_41_5 <= arg_38_1.time_ and arg_38_1.time_ < var_41_5 + var_41_6 and not isNil(var_41_4) then
				local var_41_7 = (arg_38_1.time_ - var_41_5) / var_41_6

				if arg_38_1.var_.characterEffect1111ui_story and not isNil(var_41_4) then
					local var_41_8 = Mathf.Lerp(0, 0.5, var_41_7)

					arg_38_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1111ui_story.fillRatio = var_41_8
				end
			end

			if arg_38_1.time_ >= var_41_5 + var_41_6 and arg_38_1.time_ < var_41_5 + var_41_6 + arg_41_0 and not isNil(var_41_4) and arg_38_1.var_.characterEffect1111ui_story then
				local var_41_9 = 0.5

				arg_38_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1111ui_story.fillRatio = var_41_9
			end

			local var_41_10 = 0

			if var_41_10 < arg_38_1.time_ and arg_38_1.time_ <= var_41_10 + arg_41_0 then
				arg_38_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			local var_41_11 = 0
			local var_41_12 = 0.8

			if var_41_11 < arg_38_1.time_ and arg_38_1.time_ <= var_41_11 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_13 = arg_38_1:FormatText(StoryNameCfg[1178].name)

				arg_38_1.leftNameTxt_.text = var_41_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_14 = arg_38_1:GetWordFromCfg(322181009)
				local var_41_15 = arg_38_1:FormatText(var_41_14.content)

				arg_38_1.text_.text = var_41_15

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_16 = 32
				local var_41_17 = utf8.len(var_41_15)
				local var_41_18 = var_41_16 <= 0 and var_41_12 or var_41_12 * (var_41_17 / var_41_16)

				if var_41_18 > 0 and var_41_12 < var_41_18 then
					arg_38_1.talkMaxDuration = var_41_18

					if var_41_18 + var_41_11 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_18 + var_41_11
					end
				end

				arg_38_1.text_.text = var_41_15
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181009", "story_v_out_322181.awb") ~= 0 then
					local var_41_19 = manager.audio:GetVoiceLength("story_v_out_322181", "322181009", "story_v_out_322181.awb") / 1000

					if var_41_19 + var_41_11 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_19 + var_41_11
					end

					if var_41_14.prefab_name ~= "" and arg_38_1.actors_[var_41_14.prefab_name] ~= nil then
						local var_41_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_14.prefab_name].transform, "story_v_out_322181", "322181009", "story_v_out_322181.awb")

						arg_38_1:RecordAudio("322181009", var_41_20)
						arg_38_1:RecordAudio("322181009", var_41_20)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_322181", "322181009", "story_v_out_322181.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_322181", "322181009", "story_v_out_322181.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_21 = math.max(var_41_12, arg_38_1.talkMaxDuration)

			if var_41_11 <= arg_38_1.time_ and arg_38_1.time_ < var_41_11 + var_41_21 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_11) / var_41_21

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_11 + var_41_21 and arg_38_1.time_ < var_41_11 + var_41_21 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play322181010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 322181010
		arg_42_1.duration_ = 6.73

		local var_42_0 = {
			zh = 5.166,
			ja = 6.733
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
				arg_42_0:Play322181011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["1111ui_story"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1111ui_story == nil then
				arg_42_1.var_.characterEffect1111ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.200000002980232

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.characterEffect1111ui_story and not isNil(var_45_0) then
					arg_42_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1111ui_story then
				arg_42_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_45_4 = arg_42_1.actors_["10131ui_story"]
			local var_45_5 = 0

			if var_45_5 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.characterEffect10131ui_story == nil then
				arg_42_1.var_.characterEffect10131ui_story = var_45_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_6 = 0.200000002980232

			if var_45_5 <= arg_42_1.time_ and arg_42_1.time_ < var_45_5 + var_45_6 and not isNil(var_45_4) then
				local var_45_7 = (arg_42_1.time_ - var_45_5) / var_45_6

				if arg_42_1.var_.characterEffect10131ui_story and not isNil(var_45_4) then
					local var_45_8 = Mathf.Lerp(0, 0.5, var_45_7)

					arg_42_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10131ui_story.fillRatio = var_45_8
				end
			end

			if arg_42_1.time_ >= var_45_5 + var_45_6 and arg_42_1.time_ < var_45_5 + var_45_6 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.characterEffect10131ui_story then
				local var_45_9 = 0.5

				arg_42_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10131ui_story.fillRatio = var_45_9
			end

			local var_45_10 = 0

			if var_45_10 < arg_42_1.time_ and arg_42_1.time_ <= var_45_10 + arg_45_0 then
				arg_42_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_45_11 = 0

			if var_45_11 < arg_42_1.time_ and arg_42_1.time_ <= var_45_11 + arg_45_0 then
				arg_42_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_45_12 = 0
			local var_45_13 = 0.5

			if var_45_12 < arg_42_1.time_ and arg_42_1.time_ <= var_45_12 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_14 = arg_42_1:FormatText(StoryNameCfg[67].name)

				arg_42_1.leftNameTxt_.text = var_45_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_15 = arg_42_1:GetWordFromCfg(322181010)
				local var_45_16 = arg_42_1:FormatText(var_45_15.content)

				arg_42_1.text_.text = var_45_16

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_17 = 20
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

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181010", "story_v_out_322181.awb") ~= 0 then
					local var_45_20 = manager.audio:GetVoiceLength("story_v_out_322181", "322181010", "story_v_out_322181.awb") / 1000

					if var_45_20 + var_45_12 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_20 + var_45_12
					end

					if var_45_15.prefab_name ~= "" and arg_42_1.actors_[var_45_15.prefab_name] ~= nil then
						local var_45_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_15.prefab_name].transform, "story_v_out_322181", "322181010", "story_v_out_322181.awb")

						arg_42_1:RecordAudio("322181010", var_45_21)
						arg_42_1:RecordAudio("322181010", var_45_21)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_322181", "322181010", "story_v_out_322181.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_322181", "322181010", "story_v_out_322181.awb")
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
	Play322181011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 322181011
		arg_46_1.duration_ = 4.43

		local var_46_0 = {
			zh = 3.766,
			ja = 4.433
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
				arg_46_0:Play322181012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = 0
			local var_49_1 = 0.375

			if var_49_0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				local var_49_2 = arg_46_1:FormatText(StoryNameCfg[67].name)

				arg_46_1.leftNameTxt_.text = var_49_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_3 = arg_46_1:GetWordFromCfg(322181011)
				local var_49_4 = arg_46_1:FormatText(var_49_3.content)

				arg_46_1.text_.text = var_49_4

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 16
				local var_49_6 = utf8.len(var_49_4)
				local var_49_7 = var_49_5 <= 0 and var_49_1 or var_49_1 * (var_49_6 / var_49_5)

				if var_49_7 > 0 and var_49_1 < var_49_7 then
					arg_46_1.talkMaxDuration = var_49_7

					if var_49_7 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_7 + var_49_0
					end
				end

				arg_46_1.text_.text = var_49_4
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181011", "story_v_out_322181.awb") ~= 0 then
					local var_49_8 = manager.audio:GetVoiceLength("story_v_out_322181", "322181011", "story_v_out_322181.awb") / 1000

					if var_49_8 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_8 + var_49_0
					end

					if var_49_3.prefab_name ~= "" and arg_46_1.actors_[var_49_3.prefab_name] ~= nil then
						local var_49_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_3.prefab_name].transform, "story_v_out_322181", "322181011", "story_v_out_322181.awb")

						arg_46_1:RecordAudio("322181011", var_49_9)
						arg_46_1:RecordAudio("322181011", var_49_9)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_322181", "322181011", "story_v_out_322181.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_322181", "322181011", "story_v_out_322181.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_10 = math.max(var_49_1, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_10 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_0) / var_49_10

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_10 and arg_46_1.time_ < var_49_0 + var_49_10 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play322181012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 322181012
		arg_50_1.duration_ = 11

		local var_50_0 = {
			zh = 8.7,
			ja = 11
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
				arg_50_0:Play322181013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["10131ui_story"]
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect10131ui_story == nil then
				arg_50_1.var_.characterEffect10131ui_story = var_53_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_2 = 0.200000002980232

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 and not isNil(var_53_0) then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2

				if arg_50_1.var_.characterEffect10131ui_story and not isNil(var_53_0) then
					arg_50_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 and not isNil(var_53_0) and arg_50_1.var_.characterEffect10131ui_story then
				arg_50_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_53_4 = arg_50_1.actors_["1111ui_story"]
			local var_53_5 = 0

			if var_53_5 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 and not isNil(var_53_4) and arg_50_1.var_.characterEffect1111ui_story == nil then
				arg_50_1.var_.characterEffect1111ui_story = var_53_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_6 = 0.200000002980232

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_6 and not isNil(var_53_4) then
				local var_53_7 = (arg_50_1.time_ - var_53_5) / var_53_6

				if arg_50_1.var_.characterEffect1111ui_story and not isNil(var_53_4) then
					local var_53_8 = Mathf.Lerp(0, 0.5, var_53_7)

					arg_50_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1111ui_story.fillRatio = var_53_8
				end
			end

			if arg_50_1.time_ >= var_53_5 + var_53_6 and arg_50_1.time_ < var_53_5 + var_53_6 + arg_53_0 and not isNil(var_53_4) and arg_50_1.var_.characterEffect1111ui_story then
				local var_53_9 = 0.5

				arg_50_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1111ui_story.fillRatio = var_53_9
			end

			local var_53_10 = 0
			local var_53_11 = 0.9

			if var_53_10 < arg_50_1.time_ and arg_50_1.time_ <= var_53_10 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_12 = arg_50_1:FormatText(StoryNameCfg[1178].name)

				arg_50_1.leftNameTxt_.text = var_53_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_13 = arg_50_1:GetWordFromCfg(322181012)
				local var_53_14 = arg_50_1:FormatText(var_53_13.content)

				arg_50_1.text_.text = var_53_14

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_15 = 36
				local var_53_16 = utf8.len(var_53_14)
				local var_53_17 = var_53_15 <= 0 and var_53_11 or var_53_11 * (var_53_16 / var_53_15)

				if var_53_17 > 0 and var_53_11 < var_53_17 then
					arg_50_1.talkMaxDuration = var_53_17

					if var_53_17 + var_53_10 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_17 + var_53_10
					end
				end

				arg_50_1.text_.text = var_53_14
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181012", "story_v_out_322181.awb") ~= 0 then
					local var_53_18 = manager.audio:GetVoiceLength("story_v_out_322181", "322181012", "story_v_out_322181.awb") / 1000

					if var_53_18 + var_53_10 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_18 + var_53_10
					end

					if var_53_13.prefab_name ~= "" and arg_50_1.actors_[var_53_13.prefab_name] ~= nil then
						local var_53_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_13.prefab_name].transform, "story_v_out_322181", "322181012", "story_v_out_322181.awb")

						arg_50_1:RecordAudio("322181012", var_53_19)
						arg_50_1:RecordAudio("322181012", var_53_19)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_322181", "322181012", "story_v_out_322181.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_322181", "322181012", "story_v_out_322181.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_20 = math.max(var_53_11, arg_50_1.talkMaxDuration)

			if var_53_10 <= arg_50_1.time_ and arg_50_1.time_ < var_53_10 + var_53_20 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_10) / var_53_20

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_10 + var_53_20 and arg_50_1.time_ < var_53_10 + var_53_20 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play322181013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 322181013
		arg_54_1.duration_ = 11.4

		local var_54_0 = {
			zh = 6.966,
			ja = 11.4
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play322181014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1111ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1111ui_story == nil then
				arg_54_1.var_.characterEffect1111ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1111ui_story and not isNil(var_57_0) then
					arg_54_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1111ui_story then
				arg_54_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_57_4 = arg_54_1.actors_["10131ui_story"]
			local var_57_5 = 0

			if var_57_5 < arg_54_1.time_ and arg_54_1.time_ <= var_57_5 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.characterEffect10131ui_story == nil then
				arg_54_1.var_.characterEffect10131ui_story = var_57_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_6 = 0.200000002980232

			if var_57_5 <= arg_54_1.time_ and arg_54_1.time_ < var_57_5 + var_57_6 and not isNil(var_57_4) then
				local var_57_7 = (arg_54_1.time_ - var_57_5) / var_57_6

				if arg_54_1.var_.characterEffect10131ui_story and not isNil(var_57_4) then
					local var_57_8 = Mathf.Lerp(0, 0.5, var_57_7)

					arg_54_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_54_1.var_.characterEffect10131ui_story.fillRatio = var_57_8
				end
			end

			if arg_54_1.time_ >= var_57_5 + var_57_6 and arg_54_1.time_ < var_57_5 + var_57_6 + arg_57_0 and not isNil(var_57_4) and arg_54_1.var_.characterEffect10131ui_story then
				local var_57_9 = 0.5

				arg_54_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_54_1.var_.characterEffect10131ui_story.fillRatio = var_57_9
			end

			local var_57_10 = 0
			local var_57_11 = 0.925

			if var_57_10 < arg_54_1.time_ and arg_54_1.time_ <= var_57_10 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_12 = arg_54_1:FormatText(StoryNameCfg[67].name)

				arg_54_1.leftNameTxt_.text = var_57_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_13 = arg_54_1:GetWordFromCfg(322181013)
				local var_57_14 = arg_54_1:FormatText(var_57_13.content)

				arg_54_1.text_.text = var_57_14

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_15 = 37
				local var_57_16 = utf8.len(var_57_14)
				local var_57_17 = var_57_15 <= 0 and var_57_11 or var_57_11 * (var_57_16 / var_57_15)

				if var_57_17 > 0 and var_57_11 < var_57_17 then
					arg_54_1.talkMaxDuration = var_57_17

					if var_57_17 + var_57_10 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_17 + var_57_10
					end
				end

				arg_54_1.text_.text = var_57_14
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181013", "story_v_out_322181.awb") ~= 0 then
					local var_57_18 = manager.audio:GetVoiceLength("story_v_out_322181", "322181013", "story_v_out_322181.awb") / 1000

					if var_57_18 + var_57_10 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_18 + var_57_10
					end

					if var_57_13.prefab_name ~= "" and arg_54_1.actors_[var_57_13.prefab_name] ~= nil then
						local var_57_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_13.prefab_name].transform, "story_v_out_322181", "322181013", "story_v_out_322181.awb")

						arg_54_1:RecordAudio("322181013", var_57_19)
						arg_54_1:RecordAudio("322181013", var_57_19)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_322181", "322181013", "story_v_out_322181.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_322181", "322181013", "story_v_out_322181.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_20 = math.max(var_57_11, arg_54_1.talkMaxDuration)

			if var_57_10 <= arg_54_1.time_ and arg_54_1.time_ < var_57_10 + var_57_20 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_10) / var_57_20

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_10 + var_57_20 and arg_54_1.time_ < var_57_10 + var_57_20 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play322181014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 322181014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play322181015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["10131ui_story"].transform
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 then
				arg_58_1.var_.moveOldPos10131ui_story = var_61_0.localPosition
			end

			local var_61_2 = 0.001

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2
				local var_61_4 = Vector3.New(0, 100, 0)

				var_61_0.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10131ui_story, var_61_4, var_61_3)

				local var_61_5 = manager.ui.mainCamera.transform.position - var_61_0.position

				var_61_0.forward = Vector3.New(var_61_5.x, var_61_5.y, var_61_5.z)

				local var_61_6 = var_61_0.localEulerAngles

				var_61_6.z = 0
				var_61_6.x = 0
				var_61_0.localEulerAngles = var_61_6
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 then
				var_61_0.localPosition = Vector3.New(0, 100, 0)

				local var_61_7 = manager.ui.mainCamera.transform.position - var_61_0.position

				var_61_0.forward = Vector3.New(var_61_7.x, var_61_7.y, var_61_7.z)

				local var_61_8 = var_61_0.localEulerAngles

				var_61_8.z = 0
				var_61_8.x = 0
				var_61_0.localEulerAngles = var_61_8
			end

			local var_61_9 = arg_58_1.actors_["1111ui_story"].transform
			local var_61_10 = 0

			if var_61_10 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 then
				arg_58_1.var_.moveOldPos1111ui_story = var_61_9.localPosition
			end

			local var_61_11 = 0.001

			if var_61_10 <= arg_58_1.time_ and arg_58_1.time_ < var_61_10 + var_61_11 then
				local var_61_12 = (arg_58_1.time_ - var_61_10) / var_61_11
				local var_61_13 = Vector3.New(0, 100, 0)

				var_61_9.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1111ui_story, var_61_13, var_61_12)

				local var_61_14 = manager.ui.mainCamera.transform.position - var_61_9.position

				var_61_9.forward = Vector3.New(var_61_14.x, var_61_14.y, var_61_14.z)

				local var_61_15 = var_61_9.localEulerAngles

				var_61_15.z = 0
				var_61_15.x = 0
				var_61_9.localEulerAngles = var_61_15
			end

			if arg_58_1.time_ >= var_61_10 + var_61_11 and arg_58_1.time_ < var_61_10 + var_61_11 + arg_61_0 then
				var_61_9.localPosition = Vector3.New(0, 100, 0)

				local var_61_16 = manager.ui.mainCamera.transform.position - var_61_9.position

				var_61_9.forward = Vector3.New(var_61_16.x, var_61_16.y, var_61_16.z)

				local var_61_17 = var_61_9.localEulerAngles

				var_61_17.z = 0
				var_61_17.x = 0
				var_61_9.localEulerAngles = var_61_17
			end

			local var_61_18 = 0.3
			local var_61_19 = 1

			if var_61_18 < arg_58_1.time_ and arg_58_1.time_ <= var_61_18 + arg_61_0 then
				local var_61_20 = "play"
				local var_61_21 = "effect"

				arg_58_1:AudioAction(var_61_20, var_61_21, "se_story_121_04", "se_story_121_04_walk", "")
			end

			local var_61_22 = 0
			local var_61_23 = 1.5

			if var_61_22 < arg_58_1.time_ and arg_58_1.time_ <= var_61_22 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, false)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_24 = arg_58_1:GetWordFromCfg(322181014)
				local var_61_25 = arg_58_1:FormatText(var_61_24.content)

				arg_58_1.text_.text = var_61_25

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_26 = 60
				local var_61_27 = utf8.len(var_61_25)
				local var_61_28 = var_61_26 <= 0 and var_61_23 or var_61_23 * (var_61_27 / var_61_26)

				if var_61_28 > 0 and var_61_23 < var_61_28 then
					arg_58_1.talkMaxDuration = var_61_28

					if var_61_28 + var_61_22 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_28 + var_61_22
					end
				end

				arg_58_1.text_.text = var_61_25
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_29 = math.max(var_61_23, arg_58_1.talkMaxDuration)

			if var_61_22 <= arg_58_1.time_ and arg_58_1.time_ < var_61_22 + var_61_29 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_22) / var_61_29

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_22 + var_61_29 and arg_58_1.time_ < var_61_22 + var_61_29 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play322181015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 322181015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play322181016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0
			local var_65_1 = 0.875

			if var_65_0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_2 = arg_62_1:GetWordFromCfg(322181015)
				local var_65_3 = arg_62_1:FormatText(var_65_2.content)

				arg_62_1.text_.text = var_65_3

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 35
				local var_65_5 = utf8.len(var_65_3)
				local var_65_6 = var_65_4 <= 0 and var_65_1 or var_65_1 * (var_65_5 / var_65_4)

				if var_65_6 > 0 and var_65_1 < var_65_6 then
					arg_62_1.talkMaxDuration = var_65_6

					if var_65_6 + var_65_0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_6 + var_65_0
					end
				end

				arg_62_1.text_.text = var_65_3
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_1, arg_62_1.talkMaxDuration)

			if var_65_0 <= arg_62_1.time_ and arg_62_1.time_ < var_65_0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_0 + var_65_7 and arg_62_1.time_ < var_65_0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play322181016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 322181016
		arg_66_1.duration_ = 8.03

		local var_66_0 = {
			zh = 6.266,
			ja = 8.033
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play322181017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1111ui_story"].transform
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.var_.moveOldPos1111ui_story = var_69_0.localPosition
			end

			local var_69_2 = 0.001

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2
				local var_69_4 = Vector3.New(0, -0.87, -5.7)

				var_69_0.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos1111ui_story, var_69_4, var_69_3)

				local var_69_5 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_5.x, var_69_5.y, var_69_5.z)

				local var_69_6 = var_69_0.localEulerAngles

				var_69_6.z = 0
				var_69_6.x = 0
				var_69_0.localEulerAngles = var_69_6
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 then
				var_69_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_69_7 = manager.ui.mainCamera.transform.position - var_69_0.position

				var_69_0.forward = Vector3.New(var_69_7.x, var_69_7.y, var_69_7.z)

				local var_69_8 = var_69_0.localEulerAngles

				var_69_8.z = 0
				var_69_8.x = 0
				var_69_0.localEulerAngles = var_69_8
			end

			local var_69_9 = arg_66_1.actors_["1111ui_story"]
			local var_69_10 = 0

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 and not isNil(var_69_9) and arg_66_1.var_.characterEffect1111ui_story == nil then
				arg_66_1.var_.characterEffect1111ui_story = var_69_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_11 = 0.200000002980232

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_11 and not isNil(var_69_9) then
				local var_69_12 = (arg_66_1.time_ - var_69_10) / var_69_11

				if arg_66_1.var_.characterEffect1111ui_story and not isNil(var_69_9) then
					arg_66_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_10 + var_69_11 and arg_66_1.time_ < var_69_10 + var_69_11 + arg_69_0 and not isNil(var_69_9) and arg_66_1.var_.characterEffect1111ui_story then
				arg_66_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_69_13 = 0

			if var_69_13 < arg_66_1.time_ and arg_66_1.time_ <= var_69_13 + arg_69_0 then
				arg_66_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_69_14 = 0

			if var_69_14 < arg_66_1.time_ and arg_66_1.time_ <= var_69_14 + arg_69_0 then
				arg_66_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_69_15 = 0
			local var_69_16 = 0.675

			if var_69_15 < arg_66_1.time_ and arg_66_1.time_ <= var_69_15 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_17 = arg_66_1:FormatText(StoryNameCfg[67].name)

				arg_66_1.leftNameTxt_.text = var_69_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_18 = arg_66_1:GetWordFromCfg(322181016)
				local var_69_19 = arg_66_1:FormatText(var_69_18.content)

				arg_66_1.text_.text = var_69_19

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_20 = 27
				local var_69_21 = utf8.len(var_69_19)
				local var_69_22 = var_69_20 <= 0 and var_69_16 or var_69_16 * (var_69_21 / var_69_20)

				if var_69_22 > 0 and var_69_16 < var_69_22 then
					arg_66_1.talkMaxDuration = var_69_22

					if var_69_22 + var_69_15 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_22 + var_69_15
					end
				end

				arg_66_1.text_.text = var_69_19
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181016", "story_v_out_322181.awb") ~= 0 then
					local var_69_23 = manager.audio:GetVoiceLength("story_v_out_322181", "322181016", "story_v_out_322181.awb") / 1000

					if var_69_23 + var_69_15 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_23 + var_69_15
					end

					if var_69_18.prefab_name ~= "" and arg_66_1.actors_[var_69_18.prefab_name] ~= nil then
						local var_69_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_18.prefab_name].transform, "story_v_out_322181", "322181016", "story_v_out_322181.awb")

						arg_66_1:RecordAudio("322181016", var_69_24)
						arg_66_1:RecordAudio("322181016", var_69_24)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_322181", "322181016", "story_v_out_322181.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_322181", "322181016", "story_v_out_322181.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_25 = math.max(var_69_16, arg_66_1.talkMaxDuration)

			if var_69_15 <= arg_66_1.time_ and arg_66_1.time_ < var_69_15 + var_69_25 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_15) / var_69_25

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_15 + var_69_25 and arg_66_1.time_ < var_69_15 + var_69_25 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play322181017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 322181017
		arg_70_1.duration_ = 3.8

		local var_70_0 = {
			zh = 3.233,
			ja = 3.8
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play322181018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["10131ui_story"].transform
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.var_.moveOldPos10131ui_story = var_73_0.localPosition
			end

			local var_73_2 = 0.001

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2
				local var_73_4 = Vector3.New(0.83, -0.96, -5.8)

				var_73_0.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos10131ui_story, var_73_4, var_73_3)

				local var_73_5 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_5.x, var_73_5.y, var_73_5.z)

				local var_73_6 = var_73_0.localEulerAngles

				var_73_6.z = 0
				var_73_6.x = 0
				var_73_0.localEulerAngles = var_73_6
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 then
				var_73_0.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_73_7 = manager.ui.mainCamera.transform.position - var_73_0.position

				var_73_0.forward = Vector3.New(var_73_7.x, var_73_7.y, var_73_7.z)

				local var_73_8 = var_73_0.localEulerAngles

				var_73_8.z = 0
				var_73_8.x = 0
				var_73_0.localEulerAngles = var_73_8
			end

			local var_73_9 = arg_70_1.actors_["1111ui_story"].transform
			local var_73_10 = 0

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1.var_.moveOldPos1111ui_story = var_73_9.localPosition
			end

			local var_73_11 = 0.001

			if var_73_10 <= arg_70_1.time_ and arg_70_1.time_ < var_73_10 + var_73_11 then
				local var_73_12 = (arg_70_1.time_ - var_73_10) / var_73_11
				local var_73_13 = Vector3.New(-0.79, -0.87, -5.7)

				var_73_9.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1111ui_story, var_73_13, var_73_12)

				local var_73_14 = manager.ui.mainCamera.transform.position - var_73_9.position

				var_73_9.forward = Vector3.New(var_73_14.x, var_73_14.y, var_73_14.z)

				local var_73_15 = var_73_9.localEulerAngles

				var_73_15.z = 0
				var_73_15.x = 0
				var_73_9.localEulerAngles = var_73_15
			end

			if arg_70_1.time_ >= var_73_10 + var_73_11 and arg_70_1.time_ < var_73_10 + var_73_11 + arg_73_0 then
				var_73_9.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_73_16 = manager.ui.mainCamera.transform.position - var_73_9.position

				var_73_9.forward = Vector3.New(var_73_16.x, var_73_16.y, var_73_16.z)

				local var_73_17 = var_73_9.localEulerAngles

				var_73_17.z = 0
				var_73_17.x = 0
				var_73_9.localEulerAngles = var_73_17
			end

			local var_73_18 = arg_70_1.actors_["10131ui_story"]
			local var_73_19 = 0

			if var_73_19 < arg_70_1.time_ and arg_70_1.time_ <= var_73_19 + arg_73_0 and not isNil(var_73_18) and arg_70_1.var_.characterEffect10131ui_story == nil then
				arg_70_1.var_.characterEffect10131ui_story = var_73_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_20 = 0.200000002980232

			if var_73_19 <= arg_70_1.time_ and arg_70_1.time_ < var_73_19 + var_73_20 and not isNil(var_73_18) then
				local var_73_21 = (arg_70_1.time_ - var_73_19) / var_73_20

				if arg_70_1.var_.characterEffect10131ui_story and not isNil(var_73_18) then
					arg_70_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_19 + var_73_20 and arg_70_1.time_ < var_73_19 + var_73_20 + arg_73_0 and not isNil(var_73_18) and arg_70_1.var_.characterEffect10131ui_story then
				arg_70_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_73_22 = arg_70_1.actors_["1111ui_story"]
			local var_73_23 = 0

			if var_73_23 < arg_70_1.time_ and arg_70_1.time_ <= var_73_23 + arg_73_0 and not isNil(var_73_22) and arg_70_1.var_.characterEffect1111ui_story == nil then
				arg_70_1.var_.characterEffect1111ui_story = var_73_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_24 = 0.200000002980232

			if var_73_23 <= arg_70_1.time_ and arg_70_1.time_ < var_73_23 + var_73_24 and not isNil(var_73_22) then
				local var_73_25 = (arg_70_1.time_ - var_73_23) / var_73_24

				if arg_70_1.var_.characterEffect1111ui_story and not isNil(var_73_22) then
					local var_73_26 = Mathf.Lerp(0, 0.5, var_73_25)

					arg_70_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1111ui_story.fillRatio = var_73_26
				end
			end

			if arg_70_1.time_ >= var_73_23 + var_73_24 and arg_70_1.time_ < var_73_23 + var_73_24 + arg_73_0 and not isNil(var_73_22) and arg_70_1.var_.characterEffect1111ui_story then
				local var_73_27 = 0.5

				arg_70_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1111ui_story.fillRatio = var_73_27
			end

			local var_73_28 = 0

			if var_73_28 < arg_70_1.time_ and arg_70_1.time_ <= var_73_28 + arg_73_0 then
				arg_70_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_73_29 = 0

			if var_73_29 < arg_70_1.time_ and arg_70_1.time_ <= var_73_29 + arg_73_0 then
				arg_70_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_73_30 = 0
			local var_73_31 = 0.275

			if var_73_30 < arg_70_1.time_ and arg_70_1.time_ <= var_73_30 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_32 = arg_70_1:FormatText(StoryNameCfg[1178].name)

				arg_70_1.leftNameTxt_.text = var_73_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_33 = arg_70_1:GetWordFromCfg(322181017)
				local var_73_34 = arg_70_1:FormatText(var_73_33.content)

				arg_70_1.text_.text = var_73_34

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_35 = 11
				local var_73_36 = utf8.len(var_73_34)
				local var_73_37 = var_73_35 <= 0 and var_73_31 or var_73_31 * (var_73_36 / var_73_35)

				if var_73_37 > 0 and var_73_31 < var_73_37 then
					arg_70_1.talkMaxDuration = var_73_37

					if var_73_37 + var_73_30 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_37 + var_73_30
					end
				end

				arg_70_1.text_.text = var_73_34
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181017", "story_v_out_322181.awb") ~= 0 then
					local var_73_38 = manager.audio:GetVoiceLength("story_v_out_322181", "322181017", "story_v_out_322181.awb") / 1000

					if var_73_38 + var_73_30 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_38 + var_73_30
					end

					if var_73_33.prefab_name ~= "" and arg_70_1.actors_[var_73_33.prefab_name] ~= nil then
						local var_73_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_33.prefab_name].transform, "story_v_out_322181", "322181017", "story_v_out_322181.awb")

						arg_70_1:RecordAudio("322181017", var_73_39)
						arg_70_1:RecordAudio("322181017", var_73_39)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_322181", "322181017", "story_v_out_322181.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_322181", "322181017", "story_v_out_322181.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_40 = math.max(var_73_31, arg_70_1.talkMaxDuration)

			if var_73_30 <= arg_70_1.time_ and arg_70_1.time_ < var_73_30 + var_73_40 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_30) / var_73_40

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_30 + var_73_40 and arg_70_1.time_ < var_73_30 + var_73_40 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play322181018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 322181018
		arg_74_1.duration_ = 9.57

		local var_74_0 = {
			zh = 7.9,
			ja = 9.566
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play322181019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = arg_74_1.actors_["1111ui_story"]
			local var_77_1 = 0

			if var_77_1 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1111ui_story == nil then
				arg_74_1.var_.characterEffect1111ui_story = var_77_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.200000002980232

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_2 and not isNil(var_77_0) then
				local var_77_3 = (arg_74_1.time_ - var_77_1) / var_77_2

				if arg_74_1.var_.characterEffect1111ui_story and not isNil(var_77_0) then
					arg_74_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= var_77_1 + var_77_2 and arg_74_1.time_ < var_77_1 + var_77_2 + arg_77_0 and not isNil(var_77_0) and arg_74_1.var_.characterEffect1111ui_story then
				arg_74_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_77_4 = arg_74_1.actors_["10131ui_story"]
			local var_77_5 = 0

			if var_77_5 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect10131ui_story == nil then
				arg_74_1.var_.characterEffect10131ui_story = var_77_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_6 = 0.200000002980232

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_6 and not isNil(var_77_4) then
				local var_77_7 = (arg_74_1.time_ - var_77_5) / var_77_6

				if arg_74_1.var_.characterEffect10131ui_story and not isNil(var_77_4) then
					local var_77_8 = Mathf.Lerp(0, 0.5, var_77_7)

					arg_74_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_74_1.var_.characterEffect10131ui_story.fillRatio = var_77_8
				end
			end

			if arg_74_1.time_ >= var_77_5 + var_77_6 and arg_74_1.time_ < var_77_5 + var_77_6 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect10131ui_story then
				local var_77_9 = 0.5

				arg_74_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_74_1.var_.characterEffect10131ui_story.fillRatio = var_77_9
			end

			local var_77_10 = 0

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 then
				arg_74_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_77_11 = 0

			if var_77_11 < arg_74_1.time_ and arg_74_1.time_ <= var_77_11 + arg_77_0 then
				arg_74_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_77_12 = 0
			local var_77_13 = 0.95

			if var_77_12 < arg_74_1.time_ and arg_74_1.time_ <= var_77_12 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_14 = arg_74_1:FormatText(StoryNameCfg[67].name)

				arg_74_1.leftNameTxt_.text = var_77_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_15 = arg_74_1:GetWordFromCfg(322181018)
				local var_77_16 = arg_74_1:FormatText(var_77_15.content)

				arg_74_1.text_.text = var_77_16

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_17 = 38
				local var_77_18 = utf8.len(var_77_16)
				local var_77_19 = var_77_17 <= 0 and var_77_13 or var_77_13 * (var_77_18 / var_77_17)

				if var_77_19 > 0 and var_77_13 < var_77_19 then
					arg_74_1.talkMaxDuration = var_77_19

					if var_77_19 + var_77_12 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_19 + var_77_12
					end
				end

				arg_74_1.text_.text = var_77_16
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181018", "story_v_out_322181.awb") ~= 0 then
					local var_77_20 = manager.audio:GetVoiceLength("story_v_out_322181", "322181018", "story_v_out_322181.awb") / 1000

					if var_77_20 + var_77_12 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_20 + var_77_12
					end

					if var_77_15.prefab_name ~= "" and arg_74_1.actors_[var_77_15.prefab_name] ~= nil then
						local var_77_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_15.prefab_name].transform, "story_v_out_322181", "322181018", "story_v_out_322181.awb")

						arg_74_1:RecordAudio("322181018", var_77_21)
						arg_74_1:RecordAudio("322181018", var_77_21)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_322181", "322181018", "story_v_out_322181.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_322181", "322181018", "story_v_out_322181.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_22 = math.max(var_77_13, arg_74_1.talkMaxDuration)

			if var_77_12 <= arg_74_1.time_ and arg_74_1.time_ < var_77_12 + var_77_22 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_12) / var_77_22

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_12 + var_77_22 and arg_74_1.time_ < var_77_12 + var_77_22 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play322181019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 322181019
		arg_78_1.duration_ = 11.23

		local var_78_0 = {
			zh = 11.233,
			ja = 10.933
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
				arg_78_0:Play322181020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0
			local var_81_1 = 1.225

			if var_81_0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				local var_81_2 = arg_78_1:FormatText(StoryNameCfg[67].name)

				arg_78_1.leftNameTxt_.text = var_81_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_3 = arg_78_1:GetWordFromCfg(322181019)
				local var_81_4 = arg_78_1:FormatText(var_81_3.content)

				arg_78_1.text_.text = var_81_4

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_5 = 49
				local var_81_6 = utf8.len(var_81_4)
				local var_81_7 = var_81_5 <= 0 and var_81_1 or var_81_1 * (var_81_6 / var_81_5)

				if var_81_7 > 0 and var_81_1 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_0
					end
				end

				arg_78_1.text_.text = var_81_4
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181019", "story_v_out_322181.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_322181", "322181019", "story_v_out_322181.awb") / 1000

					if var_81_8 + var_81_0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_0
					end

					if var_81_3.prefab_name ~= "" and arg_78_1.actors_[var_81_3.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_3.prefab_name].transform, "story_v_out_322181", "322181019", "story_v_out_322181.awb")

						arg_78_1:RecordAudio("322181019", var_81_9)
						arg_78_1:RecordAudio("322181019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_322181", "322181019", "story_v_out_322181.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_322181", "322181019", "story_v_out_322181.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_1, arg_78_1.talkMaxDuration)

			if var_81_0 <= arg_78_1.time_ and arg_78_1.time_ < var_81_0 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_0) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_0 + var_81_10 and arg_78_1.time_ < var_81_0 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play322181020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 322181020
		arg_82_1.duration_ = 4.37

		local var_82_0 = {
			zh = 3.2,
			ja = 4.366
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
				arg_82_0:Play322181021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0
			local var_85_1 = 0.325

			if var_85_0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_2 = arg_82_1:FormatText(StoryNameCfg[67].name)

				arg_82_1.leftNameTxt_.text = var_85_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:GetWordFromCfg(322181020)
				local var_85_4 = arg_82_1:FormatText(var_85_3.content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 13
				local var_85_6 = utf8.len(var_85_4)
				local var_85_7 = var_85_5 <= 0 and var_85_1 or var_85_1 * (var_85_6 / var_85_5)

				if var_85_7 > 0 and var_85_1 < var_85_7 then
					arg_82_1.talkMaxDuration = var_85_7

					if var_85_7 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_7 + var_85_0
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181020", "story_v_out_322181.awb") ~= 0 then
					local var_85_8 = manager.audio:GetVoiceLength("story_v_out_322181", "322181020", "story_v_out_322181.awb") / 1000

					if var_85_8 + var_85_0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_8 + var_85_0
					end

					if var_85_3.prefab_name ~= "" and arg_82_1.actors_[var_85_3.prefab_name] ~= nil then
						local var_85_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_3.prefab_name].transform, "story_v_out_322181", "322181020", "story_v_out_322181.awb")

						arg_82_1:RecordAudio("322181020", var_85_9)
						arg_82_1:RecordAudio("322181020", var_85_9)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_322181", "322181020", "story_v_out_322181.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_322181", "322181020", "story_v_out_322181.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_10 = math.max(var_85_1, arg_82_1.talkMaxDuration)

			if var_85_0 <= arg_82_1.time_ and arg_82_1.time_ < var_85_0 + var_85_10 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_0) / var_85_10

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_0 + var_85_10 and arg_82_1.time_ < var_85_0 + var_85_10 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play322181021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 322181021
		arg_86_1.duration_ = 8.8

		local var_86_0 = {
			zh = 7,
			ja = 8.8
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
				arg_86_0:Play322181022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["10131ui_story"]
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10131ui_story == nil then
				arg_86_1.var_.characterEffect10131ui_story = var_89_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_2 = 0.200000002980232

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 and not isNil(var_89_0) then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2

				if arg_86_1.var_.characterEffect10131ui_story and not isNil(var_89_0) then
					arg_86_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 and not isNil(var_89_0) and arg_86_1.var_.characterEffect10131ui_story then
				arg_86_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_89_4 = arg_86_1.actors_["1111ui_story"]
			local var_89_5 = 0

			if var_89_5 < arg_86_1.time_ and arg_86_1.time_ <= var_89_5 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect1111ui_story == nil then
				arg_86_1.var_.characterEffect1111ui_story = var_89_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.200000002980232

			if var_89_5 <= arg_86_1.time_ and arg_86_1.time_ < var_89_5 + var_89_6 and not isNil(var_89_4) then
				local var_89_7 = (arg_86_1.time_ - var_89_5) / var_89_6

				if arg_86_1.var_.characterEffect1111ui_story and not isNil(var_89_4) then
					local var_89_8 = Mathf.Lerp(0, 0.5, var_89_7)

					arg_86_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1111ui_story.fillRatio = var_89_8
				end
			end

			if arg_86_1.time_ >= var_89_5 + var_89_6 and arg_86_1.time_ < var_89_5 + var_89_6 + arg_89_0 and not isNil(var_89_4) and arg_86_1.var_.characterEffect1111ui_story then
				local var_89_9 = 0.5

				arg_86_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1111ui_story.fillRatio = var_89_9
			end

			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131actionlink/10131action462")
			end

			local var_89_11 = 0

			if var_89_11 < arg_86_1.time_ and arg_86_1.time_ <= var_89_11 + arg_89_0 then
				arg_86_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_89_12 = 0
			local var_89_13 = 0.6

			if var_89_12 < arg_86_1.time_ and arg_86_1.time_ <= var_89_12 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_14 = arg_86_1:FormatText(StoryNameCfg[1178].name)

				arg_86_1.leftNameTxt_.text = var_89_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_15 = arg_86_1:GetWordFromCfg(322181021)
				local var_89_16 = arg_86_1:FormatText(var_89_15.content)

				arg_86_1.text_.text = var_89_16

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_17 = 24
				local var_89_18 = utf8.len(var_89_16)
				local var_89_19 = var_89_17 <= 0 and var_89_13 or var_89_13 * (var_89_18 / var_89_17)

				if var_89_19 > 0 and var_89_13 < var_89_19 then
					arg_86_1.talkMaxDuration = var_89_19

					if var_89_19 + var_89_12 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_19 + var_89_12
					end
				end

				arg_86_1.text_.text = var_89_16
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181021", "story_v_out_322181.awb") ~= 0 then
					local var_89_20 = manager.audio:GetVoiceLength("story_v_out_322181", "322181021", "story_v_out_322181.awb") / 1000

					if var_89_20 + var_89_12 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_20 + var_89_12
					end

					if var_89_15.prefab_name ~= "" and arg_86_1.actors_[var_89_15.prefab_name] ~= nil then
						local var_89_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_15.prefab_name].transform, "story_v_out_322181", "322181021", "story_v_out_322181.awb")

						arg_86_1:RecordAudio("322181021", var_89_21)
						arg_86_1:RecordAudio("322181021", var_89_21)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_322181", "322181021", "story_v_out_322181.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_322181", "322181021", "story_v_out_322181.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_22 = math.max(var_89_13, arg_86_1.talkMaxDuration)

			if var_89_12 <= arg_86_1.time_ and arg_86_1.time_ < var_89_12 + var_89_22 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_12) / var_89_22

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_12 + var_89_22 and arg_86_1.time_ < var_89_12 + var_89_22 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play322181022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 322181022
		arg_90_1.duration_ = 6.13

		local var_90_0 = {
			zh = 4.866,
			ja = 6.133
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
				arg_90_0:Play322181023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1111ui_story"]
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1111ui_story == nil then
				arg_90_1.var_.characterEffect1111ui_story = var_93_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.200000002980232

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 and not isNil(var_93_0) then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2

				if arg_90_1.var_.characterEffect1111ui_story and not isNil(var_93_0) then
					arg_90_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 and not isNil(var_93_0) and arg_90_1.var_.characterEffect1111ui_story then
				arg_90_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_93_4 = arg_90_1.actors_["10131ui_story"]
			local var_93_5 = 0

			if var_93_5 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect10131ui_story == nil then
				arg_90_1.var_.characterEffect10131ui_story = var_93_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_6 = 0.200000002980232

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_6 and not isNil(var_93_4) then
				local var_93_7 = (arg_90_1.time_ - var_93_5) / var_93_6

				if arg_90_1.var_.characterEffect10131ui_story and not isNil(var_93_4) then
					local var_93_8 = Mathf.Lerp(0, 0.5, var_93_7)

					arg_90_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_90_1.var_.characterEffect10131ui_story.fillRatio = var_93_8
				end
			end

			if arg_90_1.time_ >= var_93_5 + var_93_6 and arg_90_1.time_ < var_93_5 + var_93_6 + arg_93_0 and not isNil(var_93_4) and arg_90_1.var_.characterEffect10131ui_story then
				local var_93_9 = 0.5

				arg_90_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_90_1.var_.characterEffect10131ui_story.fillRatio = var_93_9
			end

			local var_93_10 = 0

			if var_93_10 < arg_90_1.time_ and arg_90_1.time_ <= var_93_10 + arg_93_0 then
				arg_90_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_93_11 = 0
			local var_93_12 = 0.575

			if var_93_11 < arg_90_1.time_ and arg_90_1.time_ <= var_93_11 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				local var_93_13 = arg_90_1:FormatText(StoryNameCfg[67].name)

				arg_90_1.leftNameTxt_.text = var_93_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_14 = arg_90_1:GetWordFromCfg(322181022)
				local var_93_15 = arg_90_1:FormatText(var_93_14.content)

				arg_90_1.text_.text = var_93_15

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_16 = 23
				local var_93_17 = utf8.len(var_93_15)
				local var_93_18 = var_93_16 <= 0 and var_93_12 or var_93_12 * (var_93_17 / var_93_16)

				if var_93_18 > 0 and var_93_12 < var_93_18 then
					arg_90_1.talkMaxDuration = var_93_18

					if var_93_18 + var_93_11 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_18 + var_93_11
					end
				end

				arg_90_1.text_.text = var_93_15
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181022", "story_v_out_322181.awb") ~= 0 then
					local var_93_19 = manager.audio:GetVoiceLength("story_v_out_322181", "322181022", "story_v_out_322181.awb") / 1000

					if var_93_19 + var_93_11 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_19 + var_93_11
					end

					if var_93_14.prefab_name ~= "" and arg_90_1.actors_[var_93_14.prefab_name] ~= nil then
						local var_93_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_14.prefab_name].transform, "story_v_out_322181", "322181022", "story_v_out_322181.awb")

						arg_90_1:RecordAudio("322181022", var_93_20)
						arg_90_1:RecordAudio("322181022", var_93_20)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_322181", "322181022", "story_v_out_322181.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_322181", "322181022", "story_v_out_322181.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_21 = math.max(var_93_12, arg_90_1.talkMaxDuration)

			if var_93_11 <= arg_90_1.time_ and arg_90_1.time_ < var_93_11 + var_93_21 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_11) / var_93_21

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_11 + var_93_21 and arg_90_1.time_ < var_93_11 + var_93_21 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play322181023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 322181023
		arg_94_1.duration_ = 4.53

		local var_94_0 = {
			zh = 3.733,
			ja = 4.533
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
				arg_94_0:Play322181024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["10131ui_story"]
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10131ui_story == nil then
				arg_94_1.var_.characterEffect10131ui_story = var_97_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 and not isNil(var_97_0) then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2

				if arg_94_1.var_.characterEffect10131ui_story and not isNil(var_97_0) then
					arg_94_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 and not isNil(var_97_0) and arg_94_1.var_.characterEffect10131ui_story then
				arg_94_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_97_4 = arg_94_1.actors_["1111ui_story"]
			local var_97_5 = 0

			if var_97_5 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect1111ui_story == nil then
				arg_94_1.var_.characterEffect1111ui_story = var_97_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_6 = 0.200000002980232

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 and not isNil(var_97_4) then
				local var_97_7 = (arg_94_1.time_ - var_97_5) / var_97_6

				if arg_94_1.var_.characterEffect1111ui_story and not isNil(var_97_4) then
					local var_97_8 = Mathf.Lerp(0, 0.5, var_97_7)

					arg_94_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_94_1.var_.characterEffect1111ui_story.fillRatio = var_97_8
				end
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 and not isNil(var_97_4) and arg_94_1.var_.characterEffect1111ui_story then
				local var_97_9 = 0.5

				arg_94_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_94_1.var_.characterEffect1111ui_story.fillRatio = var_97_9
			end

			local var_97_10 = 0

			if var_97_10 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 then
				arg_94_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_2")
			end

			local var_97_11 = 0

			if var_97_11 < arg_94_1.time_ and arg_94_1.time_ <= var_97_11 + arg_97_0 then
				arg_94_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_97_12 = 0
			local var_97_13 = 0.375

			if var_97_12 < arg_94_1.time_ and arg_94_1.time_ <= var_97_12 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_14 = arg_94_1:FormatText(StoryNameCfg[1178].name)

				arg_94_1.leftNameTxt_.text = var_97_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_15 = arg_94_1:GetWordFromCfg(322181023)
				local var_97_16 = arg_94_1:FormatText(var_97_15.content)

				arg_94_1.text_.text = var_97_16

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_17 = 15
				local var_97_18 = utf8.len(var_97_16)
				local var_97_19 = var_97_17 <= 0 and var_97_13 or var_97_13 * (var_97_18 / var_97_17)

				if var_97_19 > 0 and var_97_13 < var_97_19 then
					arg_94_1.talkMaxDuration = var_97_19

					if var_97_19 + var_97_12 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_19 + var_97_12
					end
				end

				arg_94_1.text_.text = var_97_16
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181023", "story_v_out_322181.awb") ~= 0 then
					local var_97_20 = manager.audio:GetVoiceLength("story_v_out_322181", "322181023", "story_v_out_322181.awb") / 1000

					if var_97_20 + var_97_12 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_20 + var_97_12
					end

					if var_97_15.prefab_name ~= "" and arg_94_1.actors_[var_97_15.prefab_name] ~= nil then
						local var_97_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_15.prefab_name].transform, "story_v_out_322181", "322181023", "story_v_out_322181.awb")

						arg_94_1:RecordAudio("322181023", var_97_21)
						arg_94_1:RecordAudio("322181023", var_97_21)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_322181", "322181023", "story_v_out_322181.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_322181", "322181023", "story_v_out_322181.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_22 = math.max(var_97_13, arg_94_1.talkMaxDuration)

			if var_97_12 <= arg_94_1.time_ and arg_94_1.time_ < var_97_12 + var_97_22 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_12) / var_97_22

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_12 + var_97_22 and arg_94_1.time_ < var_97_12 + var_97_22 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play322181024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 322181024
		arg_98_1.duration_ = 10.8

		local var_98_0 = {
			zh = 10.3,
			ja = 10.8
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
				arg_98_0:Play322181025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["1111ui_story"]
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1111ui_story == nil then
				arg_98_1.var_.characterEffect1111ui_story = var_101_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_2 = 0.200000002980232

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 and not isNil(var_101_0) then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2

				if arg_98_1.var_.characterEffect1111ui_story and not isNil(var_101_0) then
					arg_98_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 and not isNil(var_101_0) and arg_98_1.var_.characterEffect1111ui_story then
				arg_98_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_101_4 = arg_98_1.actors_["10131ui_story"]
			local var_101_5 = 0

			if var_101_5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_5 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect10131ui_story == nil then
				arg_98_1.var_.characterEffect10131ui_story = var_101_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_6 = 0.200000002980232

			if var_101_5 <= arg_98_1.time_ and arg_98_1.time_ < var_101_5 + var_101_6 and not isNil(var_101_4) then
				local var_101_7 = (arg_98_1.time_ - var_101_5) / var_101_6

				if arg_98_1.var_.characterEffect10131ui_story and not isNil(var_101_4) then
					local var_101_8 = Mathf.Lerp(0, 0.5, var_101_7)

					arg_98_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_98_1.var_.characterEffect10131ui_story.fillRatio = var_101_8
				end
			end

			if arg_98_1.time_ >= var_101_5 + var_101_6 and arg_98_1.time_ < var_101_5 + var_101_6 + arg_101_0 and not isNil(var_101_4) and arg_98_1.var_.characterEffect10131ui_story then
				local var_101_9 = 0.5

				arg_98_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_98_1.var_.characterEffect10131ui_story.fillRatio = var_101_9
			end

			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 then
				arg_98_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			local var_101_11 = 0

			if var_101_11 < arg_98_1.time_ and arg_98_1.time_ <= var_101_11 + arg_101_0 then
				arg_98_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_101_12 = 0
			local var_101_13 = 1.275

			if var_101_12 < arg_98_1.time_ and arg_98_1.time_ <= var_101_12 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_14 = arg_98_1:FormatText(StoryNameCfg[67].name)

				arg_98_1.leftNameTxt_.text = var_101_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_15 = arg_98_1:GetWordFromCfg(322181024)
				local var_101_16 = arg_98_1:FormatText(var_101_15.content)

				arg_98_1.text_.text = var_101_16

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_17 = 52
				local var_101_18 = utf8.len(var_101_16)
				local var_101_19 = var_101_17 <= 0 and var_101_13 or var_101_13 * (var_101_18 / var_101_17)

				if var_101_19 > 0 and var_101_13 < var_101_19 then
					arg_98_1.talkMaxDuration = var_101_19

					if var_101_19 + var_101_12 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_19 + var_101_12
					end
				end

				arg_98_1.text_.text = var_101_16
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181024", "story_v_out_322181.awb") ~= 0 then
					local var_101_20 = manager.audio:GetVoiceLength("story_v_out_322181", "322181024", "story_v_out_322181.awb") / 1000

					if var_101_20 + var_101_12 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_20 + var_101_12
					end

					if var_101_15.prefab_name ~= "" and arg_98_1.actors_[var_101_15.prefab_name] ~= nil then
						local var_101_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_15.prefab_name].transform, "story_v_out_322181", "322181024", "story_v_out_322181.awb")

						arg_98_1:RecordAudio("322181024", var_101_21)
						arg_98_1:RecordAudio("322181024", var_101_21)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_322181", "322181024", "story_v_out_322181.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_322181", "322181024", "story_v_out_322181.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_22 = math.max(var_101_13, arg_98_1.talkMaxDuration)

			if var_101_12 <= arg_98_1.time_ and arg_98_1.time_ < var_101_12 + var_101_22 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_12) / var_101_22

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_12 + var_101_22 and arg_98_1.time_ < var_101_12 + var_101_22 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play322181025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 322181025
		arg_102_1.duration_ = 11.87

		local var_102_0 = {
			zh = 7.833,
			ja = 11.866
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
				arg_102_0:Play322181026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 0
			local var_105_1 = 0.825

			if var_105_0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_2 = arg_102_1:FormatText(StoryNameCfg[67].name)

				arg_102_1.leftNameTxt_.text = var_105_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_3 = arg_102_1:GetWordFromCfg(322181025)
				local var_105_4 = arg_102_1:FormatText(var_105_3.content)

				arg_102_1.text_.text = var_105_4

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_5 = 33
				local var_105_6 = utf8.len(var_105_4)
				local var_105_7 = var_105_5 <= 0 and var_105_1 or var_105_1 * (var_105_6 / var_105_5)

				if var_105_7 > 0 and var_105_1 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_0
					end
				end

				arg_102_1.text_.text = var_105_4
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181025", "story_v_out_322181.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_322181", "322181025", "story_v_out_322181.awb") / 1000

					if var_105_8 + var_105_0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_0
					end

					if var_105_3.prefab_name ~= "" and arg_102_1.actors_[var_105_3.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_3.prefab_name].transform, "story_v_out_322181", "322181025", "story_v_out_322181.awb")

						arg_102_1:RecordAudio("322181025", var_105_9)
						arg_102_1:RecordAudio("322181025", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_322181", "322181025", "story_v_out_322181.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_322181", "322181025", "story_v_out_322181.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_1, arg_102_1.talkMaxDuration)

			if var_105_0 <= arg_102_1.time_ and arg_102_1.time_ < var_105_0 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_0) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_0 + var_105_10 and arg_102_1.time_ < var_105_0 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play322181026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 322181026
		arg_106_1.duration_ = 7.17

		local var_106_0 = {
			zh = 5.9,
			ja = 7.166
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
				arg_106_0:Play322181027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_109_1 = 0
			local var_109_2 = 0.675

			if var_109_1 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_3 = arg_106_1:FormatText(StoryNameCfg[67].name)

				arg_106_1.leftNameTxt_.text = var_109_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_4 = arg_106_1:GetWordFromCfg(322181026)
				local var_109_5 = arg_106_1:FormatText(var_109_4.content)

				arg_106_1.text_.text = var_109_5

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_6 = 27
				local var_109_7 = utf8.len(var_109_5)
				local var_109_8 = var_109_6 <= 0 and var_109_2 or var_109_2 * (var_109_7 / var_109_6)

				if var_109_8 > 0 and var_109_2 < var_109_8 then
					arg_106_1.talkMaxDuration = var_109_8

					if var_109_8 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_1
					end
				end

				arg_106_1.text_.text = var_109_5
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181026", "story_v_out_322181.awb") ~= 0 then
					local var_109_9 = manager.audio:GetVoiceLength("story_v_out_322181", "322181026", "story_v_out_322181.awb") / 1000

					if var_109_9 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_1
					end

					if var_109_4.prefab_name ~= "" and arg_106_1.actors_[var_109_4.prefab_name] ~= nil then
						local var_109_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_4.prefab_name].transform, "story_v_out_322181", "322181026", "story_v_out_322181.awb")

						arg_106_1:RecordAudio("322181026", var_109_10)
						arg_106_1:RecordAudio("322181026", var_109_10)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_322181", "322181026", "story_v_out_322181.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_322181", "322181026", "story_v_out_322181.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_11 = math.max(var_109_2, arg_106_1.talkMaxDuration)

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_11 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_1) / var_109_11

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_1 + var_109_11 and arg_106_1.time_ < var_109_1 + var_109_11 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play322181027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 322181027
		arg_110_1.duration_ = 10.9

		local var_110_0 = {
			zh = 7.5,
			ja = 10.9
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
				arg_110_0:Play322181028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["10131ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect10131ui_story == nil then
				arg_110_1.var_.characterEffect10131ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect10131ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect10131ui_story then
				arg_110_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_113_4 = arg_110_1.actors_["1111ui_story"]
			local var_113_5 = 0

			if var_113_5 < arg_110_1.time_ and arg_110_1.time_ <= var_113_5 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect1111ui_story == nil then
				arg_110_1.var_.characterEffect1111ui_story = var_113_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_6 = 0.200000002980232

			if var_113_5 <= arg_110_1.time_ and arg_110_1.time_ < var_113_5 + var_113_6 and not isNil(var_113_4) then
				local var_113_7 = (arg_110_1.time_ - var_113_5) / var_113_6

				if arg_110_1.var_.characterEffect1111ui_story and not isNil(var_113_4) then
					local var_113_8 = Mathf.Lerp(0, 0.5, var_113_7)

					arg_110_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1111ui_story.fillRatio = var_113_8
				end
			end

			if arg_110_1.time_ >= var_113_5 + var_113_6 and arg_110_1.time_ < var_113_5 + var_113_6 + arg_113_0 and not isNil(var_113_4) and arg_110_1.var_.characterEffect1111ui_story then
				local var_113_9 = 0.5

				arg_110_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1111ui_story.fillRatio = var_113_9
			end

			local var_113_10 = 0

			if var_113_10 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			local var_113_11 = 0
			local var_113_12 = 0.575

			if var_113_11 < arg_110_1.time_ and arg_110_1.time_ <= var_113_11 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_13 = arg_110_1:FormatText(StoryNameCfg[1178].name)

				arg_110_1.leftNameTxt_.text = var_113_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_14 = arg_110_1:GetWordFromCfg(322181027)
				local var_113_15 = arg_110_1:FormatText(var_113_14.content)

				arg_110_1.text_.text = var_113_15

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_16 = 23
				local var_113_17 = utf8.len(var_113_15)
				local var_113_18 = var_113_16 <= 0 and var_113_12 or var_113_12 * (var_113_17 / var_113_16)

				if var_113_18 > 0 and var_113_12 < var_113_18 then
					arg_110_1.talkMaxDuration = var_113_18

					if var_113_18 + var_113_11 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_18 + var_113_11
					end
				end

				arg_110_1.text_.text = var_113_15
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181027", "story_v_out_322181.awb") ~= 0 then
					local var_113_19 = manager.audio:GetVoiceLength("story_v_out_322181", "322181027", "story_v_out_322181.awb") / 1000

					if var_113_19 + var_113_11 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_19 + var_113_11
					end

					if var_113_14.prefab_name ~= "" and arg_110_1.actors_[var_113_14.prefab_name] ~= nil then
						local var_113_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_14.prefab_name].transform, "story_v_out_322181", "322181027", "story_v_out_322181.awb")

						arg_110_1:RecordAudio("322181027", var_113_20)
						arg_110_1:RecordAudio("322181027", var_113_20)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_322181", "322181027", "story_v_out_322181.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_322181", "322181027", "story_v_out_322181.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_21 = math.max(var_113_12, arg_110_1.talkMaxDuration)

			if var_113_11 <= arg_110_1.time_ and arg_110_1.time_ < var_113_11 + var_113_21 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_11) / var_113_21

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_11 + var_113_21 and arg_110_1.time_ < var_113_11 + var_113_21 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play322181028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 322181028
		arg_114_1.duration_ = 6.37

		local var_114_0 = {
			zh = 5.566,
			ja = 6.366
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
				arg_114_0:Play322181029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = "L09f"

			if arg_114_1.bgs_[var_117_0] == nil then
				local var_117_1 = Object.Instantiate(arg_114_1.paintGo_)

				var_117_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_117_0)
				var_117_1.name = var_117_0
				var_117_1.transform.parent = arg_114_1.stage_.transform
				var_117_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.bgs_[var_117_0] = var_117_1
			end

			local var_117_2 = 2

			if var_117_2 < arg_114_1.time_ and arg_114_1.time_ <= var_117_2 + arg_117_0 then
				local var_117_3 = manager.ui.mainCamera.transform.localPosition
				local var_117_4 = Vector3.New(0, 0, 10) + Vector3.New(var_117_3.x, var_117_3.y, 0)
				local var_117_5 = arg_114_1.bgs_.L09f

				var_117_5.transform.localPosition = var_117_4
				var_117_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_117_6 = var_117_5:GetComponent("SpriteRenderer")

				if var_117_6 and var_117_6.sprite then
					local var_117_7 = (var_117_5.transform.localPosition - var_117_3).z
					local var_117_8 = manager.ui.mainCameraCom_
					local var_117_9 = 2 * var_117_7 * Mathf.Tan(var_117_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_117_10 = var_117_9 * var_117_8.aspect
					local var_117_11 = var_117_6.sprite.bounds.size.x
					local var_117_12 = var_117_6.sprite.bounds.size.y
					local var_117_13 = var_117_10 / var_117_11
					local var_117_14 = var_117_9 / var_117_12
					local var_117_15 = var_117_14 < var_117_13 and var_117_13 or var_117_14

					var_117_5.transform.localScale = Vector3.New(var_117_15, var_117_15, 0)
				end

				for iter_117_0, iter_117_1 in pairs(arg_114_1.bgs_) do
					if iter_117_0 ~= "L09f" then
						iter_117_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_117_16 = 4

			if var_117_16 < arg_114_1.time_ and arg_114_1.time_ <= var_117_16 + arg_117_0 then
				arg_114_1.allBtn_.enabled = false
			end

			local var_117_17 = 0.125

			if arg_114_1.time_ >= var_117_16 + var_117_17 and arg_114_1.time_ < var_117_16 + var_117_17 + arg_117_0 then
				arg_114_1.allBtn_.enabled = true
			end

			local var_117_18 = 0

			if var_117_18 < arg_114_1.time_ and arg_114_1.time_ <= var_117_18 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_19 = 2

			if var_117_18 <= arg_114_1.time_ and arg_114_1.time_ < var_117_18 + var_117_19 then
				local var_117_20 = (arg_114_1.time_ - var_117_18) / var_117_19
				local var_117_21 = Color.New(0, 0, 0)

				var_117_21.a = Mathf.Lerp(0, 1, var_117_20)
				arg_114_1.mask_.color = var_117_21
			end

			if arg_114_1.time_ >= var_117_18 + var_117_19 and arg_114_1.time_ < var_117_18 + var_117_19 + arg_117_0 then
				local var_117_22 = Color.New(0, 0, 0)

				var_117_22.a = 1
				arg_114_1.mask_.color = var_117_22
			end

			local var_117_23 = 2

			if var_117_23 < arg_114_1.time_ and arg_114_1.time_ <= var_117_23 + arg_117_0 then
				arg_114_1.mask_.enabled = true
				arg_114_1.mask_.raycastTarget = true

				arg_114_1:SetGaussion(false)
			end

			local var_117_24 = 2

			if var_117_23 <= arg_114_1.time_ and arg_114_1.time_ < var_117_23 + var_117_24 then
				local var_117_25 = (arg_114_1.time_ - var_117_23) / var_117_24
				local var_117_26 = Color.New(0, 0, 0)

				var_117_26.a = Mathf.Lerp(1, 0, var_117_25)
				arg_114_1.mask_.color = var_117_26
			end

			if arg_114_1.time_ >= var_117_23 + var_117_24 and arg_114_1.time_ < var_117_23 + var_117_24 + arg_117_0 then
				local var_117_27 = Color.New(0, 0, 0)
				local var_117_28 = 0

				arg_114_1.mask_.enabled = false
				var_117_27.a = var_117_28
				arg_114_1.mask_.color = var_117_27
			end

			local var_117_29 = arg_114_1.actors_["1111ui_story"].transform
			local var_117_30 = 2

			if var_117_30 < arg_114_1.time_ and arg_114_1.time_ <= var_117_30 + arg_117_0 then
				arg_114_1.var_.moveOldPos1111ui_story = var_117_29.localPosition
			end

			local var_117_31 = 0.001

			if var_117_30 <= arg_114_1.time_ and arg_114_1.time_ < var_117_30 + var_117_31 then
				local var_117_32 = (arg_114_1.time_ - var_117_30) / var_117_31
				local var_117_33 = Vector3.New(0, 100, 0)

				var_117_29.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1111ui_story, var_117_33, var_117_32)

				local var_117_34 = manager.ui.mainCamera.transform.position - var_117_29.position

				var_117_29.forward = Vector3.New(var_117_34.x, var_117_34.y, var_117_34.z)

				local var_117_35 = var_117_29.localEulerAngles

				var_117_35.z = 0
				var_117_35.x = 0
				var_117_29.localEulerAngles = var_117_35
			end

			if arg_114_1.time_ >= var_117_30 + var_117_31 and arg_114_1.time_ < var_117_30 + var_117_31 + arg_117_0 then
				var_117_29.localPosition = Vector3.New(0, 100, 0)

				local var_117_36 = manager.ui.mainCamera.transform.position - var_117_29.position

				var_117_29.forward = Vector3.New(var_117_36.x, var_117_36.y, var_117_36.z)

				local var_117_37 = var_117_29.localEulerAngles

				var_117_37.z = 0
				var_117_37.x = 0
				var_117_29.localEulerAngles = var_117_37
			end

			local var_117_38 = arg_114_1.actors_["10131ui_story"].transform
			local var_117_39 = 2

			if var_117_39 < arg_114_1.time_ and arg_114_1.time_ <= var_117_39 + arg_117_0 then
				arg_114_1.var_.moveOldPos10131ui_story = var_117_38.localPosition
			end

			local var_117_40 = 0.001

			if var_117_39 <= arg_114_1.time_ and arg_114_1.time_ < var_117_39 + var_117_40 then
				local var_117_41 = (arg_114_1.time_ - var_117_39) / var_117_40
				local var_117_42 = Vector3.New(0, 100, 0)

				var_117_38.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10131ui_story, var_117_42, var_117_41)

				local var_117_43 = manager.ui.mainCamera.transform.position - var_117_38.position

				var_117_38.forward = Vector3.New(var_117_43.x, var_117_43.y, var_117_43.z)

				local var_117_44 = var_117_38.localEulerAngles

				var_117_44.z = 0
				var_117_44.x = 0
				var_117_38.localEulerAngles = var_117_44
			end

			if arg_114_1.time_ >= var_117_39 + var_117_40 and arg_114_1.time_ < var_117_39 + var_117_40 + arg_117_0 then
				var_117_38.localPosition = Vector3.New(0, 100, 0)

				local var_117_45 = manager.ui.mainCamera.transform.position - var_117_38.position

				var_117_38.forward = Vector3.New(var_117_45.x, var_117_45.y, var_117_45.z)

				local var_117_46 = var_117_38.localEulerAngles

				var_117_46.z = 0
				var_117_46.x = 0
				var_117_38.localEulerAngles = var_117_46
			end

			if arg_114_1.frameCnt_ <= 1 then
				arg_114_1.dialog_:SetActive(false)
			end

			local var_117_47 = 4
			local var_117_48 = 0.125

			if var_117_47 < arg_114_1.time_ and arg_114_1.time_ <= var_117_47 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0

				arg_114_1.dialog_:SetActive(true)

				arg_114_1.dialogCg_.alpha = 0

				local var_117_49 = LeanTween.value(arg_114_1.dialog_, 0, 1, 0.3)

				var_117_49:setOnUpdate(LuaHelper.FloatAction(function(arg_118_0)
					arg_114_1.dialogCg_.alpha = arg_118_0
				end))
				var_117_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_114_1.dialog_)
					var_117_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_114_1.duration_ = arg_114_1.duration_ + 0.3

				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_50 = arg_114_1:FormatText(StoryNameCfg[591].name)

				arg_114_1.leftNameTxt_.text = var_117_50

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_51 = arg_114_1:GetWordFromCfg(322181028)
				local var_117_52 = arg_114_1:FormatText(var_117_51.content)

				arg_114_1.text_.text = var_117_52

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_53 = 5
				local var_117_54 = utf8.len(var_117_52)
				local var_117_55 = var_117_53 <= 0 and var_117_48 or var_117_48 * (var_117_54 / var_117_53)

				if var_117_55 > 0 and var_117_48 < var_117_55 then
					arg_114_1.talkMaxDuration = var_117_55
					var_117_47 = var_117_47 + 0.3

					if var_117_55 + var_117_47 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_55 + var_117_47
					end
				end

				arg_114_1.text_.text = var_117_52
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181028", "story_v_out_322181.awb") ~= 0 then
					local var_117_56 = manager.audio:GetVoiceLength("story_v_out_322181", "322181028", "story_v_out_322181.awb") / 1000

					if var_117_56 + var_117_47 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_56 + var_117_47
					end

					if var_117_51.prefab_name ~= "" and arg_114_1.actors_[var_117_51.prefab_name] ~= nil then
						local var_117_57 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_51.prefab_name].transform, "story_v_out_322181", "322181028", "story_v_out_322181.awb")

						arg_114_1:RecordAudio("322181028", var_117_57)
						arg_114_1:RecordAudio("322181028", var_117_57)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_322181", "322181028", "story_v_out_322181.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_322181", "322181028", "story_v_out_322181.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_58 = var_117_47 + 0.3
			local var_117_59 = math.max(var_117_48, arg_114_1.talkMaxDuration)

			if var_117_58 <= arg_114_1.time_ and arg_114_1.time_ < var_117_58 + var_117_59 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_58) / var_117_59

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_58 + var_117_59 and arg_114_1.time_ < var_117_58 + var_117_59 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play322181029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 322181029
		arg_120_1.duration_ = 2.4

		local var_120_0 = {
			zh = 2.4,
			ja = 2.233
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
				arg_120_0:Play322181030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1111ui_story"].transform
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 then
				arg_120_1.var_.moveOldPos1111ui_story = var_123_0.localPosition
			end

			local var_123_2 = 0.001

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2
				local var_123_4 = Vector3.New(0, -0.87, -5.7)

				var_123_0.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1111ui_story, var_123_4, var_123_3)

				local var_123_5 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_5.x, var_123_5.y, var_123_5.z)

				local var_123_6 = var_123_0.localEulerAngles

				var_123_6.z = 0
				var_123_6.x = 0
				var_123_0.localEulerAngles = var_123_6
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 then
				var_123_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_123_7 = manager.ui.mainCamera.transform.position - var_123_0.position

				var_123_0.forward = Vector3.New(var_123_7.x, var_123_7.y, var_123_7.z)

				local var_123_8 = var_123_0.localEulerAngles

				var_123_8.z = 0
				var_123_8.x = 0
				var_123_0.localEulerAngles = var_123_8
			end

			local var_123_9 = arg_120_1.actors_["1111ui_story"]
			local var_123_10 = 0

			if var_123_10 < arg_120_1.time_ and arg_120_1.time_ <= var_123_10 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect1111ui_story == nil then
				arg_120_1.var_.characterEffect1111ui_story = var_123_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_11 = 0.200000002980232

			if var_123_10 <= arg_120_1.time_ and arg_120_1.time_ < var_123_10 + var_123_11 and not isNil(var_123_9) then
				local var_123_12 = (arg_120_1.time_ - var_123_10) / var_123_11

				if arg_120_1.var_.characterEffect1111ui_story and not isNil(var_123_9) then
					arg_120_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= var_123_10 + var_123_11 and arg_120_1.time_ < var_123_10 + var_123_11 + arg_123_0 and not isNil(var_123_9) and arg_120_1.var_.characterEffect1111ui_story then
				arg_120_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_123_13 = 0

			if var_123_13 < arg_120_1.time_ and arg_120_1.time_ <= var_123_13 + arg_123_0 then
				arg_120_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_123_14 = 0

			if var_123_14 < arg_120_1.time_ and arg_120_1.time_ <= var_123_14 + arg_123_0 then
				arg_120_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_123_15 = 0
			local var_123_16 = 0.15

			if var_123_15 < arg_120_1.time_ and arg_120_1.time_ <= var_123_15 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_17 = arg_120_1:FormatText(StoryNameCfg[67].name)

				arg_120_1.leftNameTxt_.text = var_123_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_18 = arg_120_1:GetWordFromCfg(322181029)
				local var_123_19 = arg_120_1:FormatText(var_123_18.content)

				arg_120_1.text_.text = var_123_19

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_20 = 6
				local var_123_21 = utf8.len(var_123_19)
				local var_123_22 = var_123_20 <= 0 and var_123_16 or var_123_16 * (var_123_21 / var_123_20)

				if var_123_22 > 0 and var_123_16 < var_123_22 then
					arg_120_1.talkMaxDuration = var_123_22

					if var_123_22 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_22 + var_123_15
					end
				end

				arg_120_1.text_.text = var_123_19
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181029", "story_v_out_322181.awb") ~= 0 then
					local var_123_23 = manager.audio:GetVoiceLength("story_v_out_322181", "322181029", "story_v_out_322181.awb") / 1000

					if var_123_23 + var_123_15 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_23 + var_123_15
					end

					if var_123_18.prefab_name ~= "" and arg_120_1.actors_[var_123_18.prefab_name] ~= nil then
						local var_123_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_18.prefab_name].transform, "story_v_out_322181", "322181029", "story_v_out_322181.awb")

						arg_120_1:RecordAudio("322181029", var_123_24)
						arg_120_1:RecordAudio("322181029", var_123_24)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_322181", "322181029", "story_v_out_322181.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_322181", "322181029", "story_v_out_322181.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_25 = math.max(var_123_16, arg_120_1.talkMaxDuration)

			if var_123_15 <= arg_120_1.time_ and arg_120_1.time_ < var_123_15 + var_123_25 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_15) / var_123_25

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_15 + var_123_25 and arg_120_1.time_ < var_123_15 + var_123_25 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play322181030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 322181030
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play322181031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1111ui_story"].transform
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.var_.moveOldPos1111ui_story = var_127_0.localPosition
			end

			local var_127_2 = 0.001

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2
				local var_127_4 = Vector3.New(0, 100, 0)

				var_127_0.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1111ui_story, var_127_4, var_127_3)

				local var_127_5 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_5.x, var_127_5.y, var_127_5.z)

				local var_127_6 = var_127_0.localEulerAngles

				var_127_6.z = 0
				var_127_6.x = 0
				var_127_0.localEulerAngles = var_127_6
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 then
				var_127_0.localPosition = Vector3.New(0, 100, 0)

				local var_127_7 = manager.ui.mainCamera.transform.position - var_127_0.position

				var_127_0.forward = Vector3.New(var_127_7.x, var_127_7.y, var_127_7.z)

				local var_127_8 = var_127_0.localEulerAngles

				var_127_8.z = 0
				var_127_8.x = 0
				var_127_0.localEulerAngles = var_127_8
			end

			local var_127_9 = 0.666666666666667
			local var_127_10 = 1

			if var_127_9 < arg_124_1.time_ and arg_124_1.time_ <= var_127_9 + arg_127_0 then
				local var_127_11 = "play"
				local var_127_12 = "effect"

				arg_124_1:AudioAction(var_127_11, var_127_12, "se_story_145", "se_story_145_hit", "")
			end

			local var_127_13 = 0
			local var_127_14 = 1.175

			if var_127_13 < arg_124_1.time_ and arg_124_1.time_ <= var_127_13 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_15 = arg_124_1:GetWordFromCfg(322181030)
				local var_127_16 = arg_124_1:FormatText(var_127_15.content)

				arg_124_1.text_.text = var_127_16

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_17 = 47
				local var_127_18 = utf8.len(var_127_16)
				local var_127_19 = var_127_17 <= 0 and var_127_14 or var_127_14 * (var_127_18 / var_127_17)

				if var_127_19 > 0 and var_127_14 < var_127_19 then
					arg_124_1.talkMaxDuration = var_127_19

					if var_127_19 + var_127_13 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_19 + var_127_13
					end
				end

				arg_124_1.text_.text = var_127_16
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_20 = math.max(var_127_14, arg_124_1.talkMaxDuration)

			if var_127_13 <= arg_124_1.time_ and arg_124_1.time_ < var_127_13 + var_127_20 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_13) / var_127_20

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_13 + var_127_20 and arg_124_1.time_ < var_127_13 + var_127_20 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	Play322181031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 322181031
		arg_128_1.duration_ = 5.1

		local var_128_0 = {
			zh = 4.133,
			ja = 5.1
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
				arg_128_0:Play322181032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = arg_128_1.actors_["1111ui_story"].transform
			local var_131_1 = 0

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.var_.moveOldPos1111ui_story = var_131_0.localPosition
			end

			local var_131_2 = 0.001

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_2 then
				local var_131_3 = (arg_128_1.time_ - var_131_1) / var_131_2
				local var_131_4 = Vector3.New(0, -0.87, -5.7)

				var_131_0.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1111ui_story, var_131_4, var_131_3)

				local var_131_5 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_5.x, var_131_5.y, var_131_5.z)

				local var_131_6 = var_131_0.localEulerAngles

				var_131_6.z = 0
				var_131_6.x = 0
				var_131_0.localEulerAngles = var_131_6
			end

			if arg_128_1.time_ >= var_131_1 + var_131_2 and arg_128_1.time_ < var_131_1 + var_131_2 + arg_131_0 then
				var_131_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_131_7 = manager.ui.mainCamera.transform.position - var_131_0.position

				var_131_0.forward = Vector3.New(var_131_7.x, var_131_7.y, var_131_7.z)

				local var_131_8 = var_131_0.localEulerAngles

				var_131_8.z = 0
				var_131_8.x = 0
				var_131_0.localEulerAngles = var_131_8
			end

			local var_131_9 = arg_128_1.actors_["1111ui_story"]
			local var_131_10 = 0

			if var_131_10 < arg_128_1.time_ and arg_128_1.time_ <= var_131_10 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect1111ui_story == nil then
				arg_128_1.var_.characterEffect1111ui_story = var_131_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_11 = 0.200000002980232

			if var_131_10 <= arg_128_1.time_ and arg_128_1.time_ < var_131_10 + var_131_11 and not isNil(var_131_9) then
				local var_131_12 = (arg_128_1.time_ - var_131_10) / var_131_11

				if arg_128_1.var_.characterEffect1111ui_story and not isNil(var_131_9) then
					arg_128_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= var_131_10 + var_131_11 and arg_128_1.time_ < var_131_10 + var_131_11 + arg_131_0 and not isNil(var_131_9) and arg_128_1.var_.characterEffect1111ui_story then
				arg_128_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_131_13 = 0

			if var_131_13 < arg_128_1.time_ and arg_128_1.time_ <= var_131_13 + arg_131_0 then
				arg_128_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_1")
			end

			local var_131_14 = 0

			if var_131_14 < arg_128_1.time_ and arg_128_1.time_ <= var_131_14 + arg_131_0 then
				arg_128_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_131_15 = 0
			local var_131_16 = 0.475

			if var_131_15 < arg_128_1.time_ and arg_128_1.time_ <= var_131_15 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_17 = arg_128_1:FormatText(StoryNameCfg[67].name)

				arg_128_1.leftNameTxt_.text = var_131_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_18 = arg_128_1:GetWordFromCfg(322181031)
				local var_131_19 = arg_128_1:FormatText(var_131_18.content)

				arg_128_1.text_.text = var_131_19

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_20 = 19
				local var_131_21 = utf8.len(var_131_19)
				local var_131_22 = var_131_20 <= 0 and var_131_16 or var_131_16 * (var_131_21 / var_131_20)

				if var_131_22 > 0 and var_131_16 < var_131_22 then
					arg_128_1.talkMaxDuration = var_131_22

					if var_131_22 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_22 + var_131_15
					end
				end

				arg_128_1.text_.text = var_131_19
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181031", "story_v_out_322181.awb") ~= 0 then
					local var_131_23 = manager.audio:GetVoiceLength("story_v_out_322181", "322181031", "story_v_out_322181.awb") / 1000

					if var_131_23 + var_131_15 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_23 + var_131_15
					end

					if var_131_18.prefab_name ~= "" and arg_128_1.actors_[var_131_18.prefab_name] ~= nil then
						local var_131_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_18.prefab_name].transform, "story_v_out_322181", "322181031", "story_v_out_322181.awb")

						arg_128_1:RecordAudio("322181031", var_131_24)
						arg_128_1:RecordAudio("322181031", var_131_24)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_322181", "322181031", "story_v_out_322181.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_322181", "322181031", "story_v_out_322181.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_25 = math.max(var_131_16, arg_128_1.talkMaxDuration)

			if var_131_15 <= arg_128_1.time_ and arg_128_1.time_ < var_131_15 + var_131_25 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_15) / var_131_25

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_15 + var_131_25 and arg_128_1.time_ < var_131_15 + var_131_25 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play322181032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 322181032
		arg_132_1.duration_ = 5.8

		local var_132_0 = {
			zh = 5.8,
			ja = 5.666
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
				arg_132_0:Play322181033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0
			local var_135_1 = 0.725

			if var_135_0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_2 = arg_132_1:FormatText(StoryNameCfg[67].name)

				arg_132_1.leftNameTxt_.text = var_135_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:GetWordFromCfg(322181032)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 29
				local var_135_6 = utf8.len(var_135_4)
				local var_135_7 = var_135_5 <= 0 and var_135_1 or var_135_1 * (var_135_6 / var_135_5)

				if var_135_7 > 0 and var_135_1 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_0
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181032", "story_v_out_322181.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_322181", "322181032", "story_v_out_322181.awb") / 1000

					if var_135_8 + var_135_0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_0
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_322181", "322181032", "story_v_out_322181.awb")

						arg_132_1:RecordAudio("322181032", var_135_9)
						arg_132_1:RecordAudio("322181032", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_322181", "322181032", "story_v_out_322181.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_322181", "322181032", "story_v_out_322181.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_1, arg_132_1.talkMaxDuration)

			if var_135_0 <= arg_132_1.time_ and arg_132_1.time_ < var_135_0 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_0) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_0 + var_135_10 and arg_132_1.time_ < var_135_0 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play322181033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 322181033
		arg_136_1.duration_ = 8.9

		local var_136_0 = {
			zh = 6.333,
			ja = 8.9
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
				arg_136_0:Play322181034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1111ui_story"]
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1111ui_story == nil then
				arg_136_1.var_.characterEffect1111ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 and not isNil(var_139_0) then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2

				if arg_136_1.var_.characterEffect1111ui_story and not isNil(var_139_0) then
					local var_139_4 = Mathf.Lerp(0, 0.5, var_139_3)

					arg_136_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1111ui_story.fillRatio = var_139_4
				end
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1111ui_story then
				local var_139_5 = 0.5

				arg_136_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1111ui_story.fillRatio = var_139_5
			end

			local var_139_6 = 0
			local var_139_7 = 0.65

			if var_139_6 < arg_136_1.time_ and arg_136_1.time_ <= var_139_6 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_8 = arg_136_1:FormatText(StoryNameCfg[1020].name)

				arg_136_1.leftNameTxt_.text = var_139_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_9 = arg_136_1:GetWordFromCfg(322181033)
				local var_139_10 = arg_136_1:FormatText(var_139_9.content)

				arg_136_1.text_.text = var_139_10

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_11 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181033", "story_v_out_322181.awb") ~= 0 then
					local var_139_14 = manager.audio:GetVoiceLength("story_v_out_322181", "322181033", "story_v_out_322181.awb") / 1000

					if var_139_14 + var_139_6 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_14 + var_139_6
					end

					if var_139_9.prefab_name ~= "" and arg_136_1.actors_[var_139_9.prefab_name] ~= nil then
						local var_139_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_9.prefab_name].transform, "story_v_out_322181", "322181033", "story_v_out_322181.awb")

						arg_136_1:RecordAudio("322181033", var_139_15)
						arg_136_1:RecordAudio("322181033", var_139_15)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_322181", "322181033", "story_v_out_322181.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_322181", "322181033", "story_v_out_322181.awb")
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
	Play322181034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 322181034
		arg_140_1.duration_ = 7.83

		local var_140_0 = {
			zh = 6.866,
			ja = 7.833
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play322181035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1111ui_story"]
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1111ui_story == nil then
				arg_140_1.var_.characterEffect1111ui_story = var_143_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 and not isNil(var_143_0) then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2

				if arg_140_1.var_.characterEffect1111ui_story and not isNil(var_143_0) then
					arg_140_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 and not isNil(var_143_0) and arg_140_1.var_.characterEffect1111ui_story then
				arg_140_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_143_4 = 0

			if var_143_4 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_2")
			end

			local var_143_5 = 0

			if var_143_5 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva", "EmotionTimelineAnimator")
			end

			local var_143_6 = 0
			local var_143_7 = 0.75

			if var_143_6 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_8 = arg_140_1:FormatText(StoryNameCfg[67].name)

				arg_140_1.leftNameTxt_.text = var_143_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_9 = arg_140_1:GetWordFromCfg(322181034)
				local var_143_10 = arg_140_1:FormatText(var_143_9.content)

				arg_140_1.text_.text = var_143_10

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 30
				local var_143_12 = utf8.len(var_143_10)
				local var_143_13 = var_143_11 <= 0 and var_143_7 or var_143_7 * (var_143_12 / var_143_11)

				if var_143_13 > 0 and var_143_7 < var_143_13 then
					arg_140_1.talkMaxDuration = var_143_13

					if var_143_13 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_13 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_10
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181034", "story_v_out_322181.awb") ~= 0 then
					local var_143_14 = manager.audio:GetVoiceLength("story_v_out_322181", "322181034", "story_v_out_322181.awb") / 1000

					if var_143_14 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_14 + var_143_6
					end

					if var_143_9.prefab_name ~= "" and arg_140_1.actors_[var_143_9.prefab_name] ~= nil then
						local var_143_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_9.prefab_name].transform, "story_v_out_322181", "322181034", "story_v_out_322181.awb")

						arg_140_1:RecordAudio("322181034", var_143_15)
						arg_140_1:RecordAudio("322181034", var_143_15)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_322181", "322181034", "story_v_out_322181.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_322181", "322181034", "story_v_out_322181.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_16 and arg_140_1.time_ < var_143_6 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play322181035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 322181035
		arg_144_1.duration_ = 2.43

		local var_144_0 = {
			zh = 0.999999999999,
			ja = 2.433
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play322181036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1111ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1111ui_story == nil then
				arg_144_1.var_.characterEffect1111ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1111ui_story and not isNil(var_147_0) then
					local var_147_4 = Mathf.Lerp(0, 0.5, var_147_3)

					arg_144_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1111ui_story.fillRatio = var_147_4
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1111ui_story then
				local var_147_5 = 0.5

				arg_144_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1111ui_story.fillRatio = var_147_5
			end

			local var_147_6 = 0
			local var_147_7 = 0.075

			if var_147_6 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_8 = arg_144_1:FormatText(StoryNameCfg[1020].name)

				arg_144_1.leftNameTxt_.text = var_147_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_9 = arg_144_1:GetWordFromCfg(322181035)
				local var_147_10 = arg_144_1:FormatText(var_147_9.content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_11 = 3
				local var_147_12 = utf8.len(var_147_10)
				local var_147_13 = var_147_11 <= 0 and var_147_7 or var_147_7 * (var_147_12 / var_147_11)

				if var_147_13 > 0 and var_147_7 < var_147_13 then
					arg_144_1.talkMaxDuration = var_147_13

					if var_147_13 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_13 + var_147_6
					end
				end

				arg_144_1.text_.text = var_147_10
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181035", "story_v_out_322181.awb") ~= 0 then
					local var_147_14 = manager.audio:GetVoiceLength("story_v_out_322181", "322181035", "story_v_out_322181.awb") / 1000

					if var_147_14 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_14 + var_147_6
					end

					if var_147_9.prefab_name ~= "" and arg_144_1.actors_[var_147_9.prefab_name] ~= nil then
						local var_147_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_9.prefab_name].transform, "story_v_out_322181", "322181035", "story_v_out_322181.awb")

						arg_144_1:RecordAudio("322181035", var_147_15)
						arg_144_1:RecordAudio("322181035", var_147_15)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_322181", "322181035", "story_v_out_322181.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_322181", "322181035", "story_v_out_322181.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_16 = math.max(var_147_7, arg_144_1.talkMaxDuration)

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_16 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_6) / var_147_16

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_6 + var_147_16 and arg_144_1.time_ < var_147_6 + var_147_16 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play322181036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 322181036
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play322181037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1111ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1111ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0, 100, 0)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1111ui_story, var_151_4, var_151_3)

				local var_151_5 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_5.x, var_151_5.y, var_151_5.z)

				local var_151_6 = var_151_0.localEulerAngles

				var_151_6.z = 0
				var_151_6.x = 0
				var_151_0.localEulerAngles = var_151_6
			end

			if arg_148_1.time_ >= var_151_1 + var_151_2 and arg_148_1.time_ < var_151_1 + var_151_2 + arg_151_0 then
				var_151_0.localPosition = Vector3.New(0, 100, 0)

				local var_151_7 = manager.ui.mainCamera.transform.position - var_151_0.position

				var_151_0.forward = Vector3.New(var_151_7.x, var_151_7.y, var_151_7.z)

				local var_151_8 = var_151_0.localEulerAngles

				var_151_8.z = 0
				var_151_8.x = 0
				var_151_0.localEulerAngles = var_151_8
			end

			local var_151_9 = 0
			local var_151_10 = 1.525

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_11 = arg_148_1:GetWordFromCfg(322181036)
				local var_151_12 = arg_148_1:FormatText(var_151_11.content)

				arg_148_1.text_.text = var_151_12

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_13 = 61
				local var_151_14 = utf8.len(var_151_12)
				local var_151_15 = var_151_13 <= 0 and var_151_10 or var_151_10 * (var_151_14 / var_151_13)

				if var_151_15 > 0 and var_151_10 < var_151_15 then
					arg_148_1.talkMaxDuration = var_151_15

					if var_151_15 + var_151_9 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_15 + var_151_9
					end
				end

				arg_148_1.text_.text = var_151_12
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_16 = math.max(var_151_10, arg_148_1.talkMaxDuration)

			if var_151_9 <= arg_148_1.time_ and arg_148_1.time_ < var_151_9 + var_151_16 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_9) / var_151_16

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_9 + var_151_16 and arg_148_1.time_ < var_151_9 + var_151_16 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play322181037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 322181037
		arg_152_1.duration_ = 10.47

		local var_152_0 = {
			zh = 8.433,
			ja = 10.466
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play322181038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0
			local var_155_1 = 1

			if var_155_0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_2 = arg_152_1:FormatText(StoryNameCfg[1020].name)

				arg_152_1.leftNameTxt_.text = var_155_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:GetWordFromCfg(322181037)
				local var_155_4 = arg_152_1:FormatText(var_155_3.content)

				arg_152_1.text_.text = var_155_4

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 40
				local var_155_6 = utf8.len(var_155_4)
				local var_155_7 = var_155_5 <= 0 and var_155_1 or var_155_1 * (var_155_6 / var_155_5)

				if var_155_7 > 0 and var_155_1 < var_155_7 then
					arg_152_1.talkMaxDuration = var_155_7

					if var_155_7 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_7 + var_155_0
					end
				end

				arg_152_1.text_.text = var_155_4
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181037", "story_v_out_322181.awb") ~= 0 then
					local var_155_8 = manager.audio:GetVoiceLength("story_v_out_322181", "322181037", "story_v_out_322181.awb") / 1000

					if var_155_8 + var_155_0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_8 + var_155_0
					end

					if var_155_3.prefab_name ~= "" and arg_152_1.actors_[var_155_3.prefab_name] ~= nil then
						local var_155_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_3.prefab_name].transform, "story_v_out_322181", "322181037", "story_v_out_322181.awb")

						arg_152_1:RecordAudio("322181037", var_155_9)
						arg_152_1:RecordAudio("322181037", var_155_9)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_322181", "322181037", "story_v_out_322181.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_322181", "322181037", "story_v_out_322181.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_10 = math.max(var_155_1, arg_152_1.talkMaxDuration)

			if var_155_0 <= arg_152_1.time_ and arg_152_1.time_ < var_155_0 + var_155_10 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_0) / var_155_10

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_0 + var_155_10 and arg_152_1.time_ < var_155_0 + var_155_10 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play322181038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 322181038
		arg_156_1.duration_ = 14.67

		local var_156_0 = {
			zh = 6.1,
			ja = 14.666
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play322181039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0
			local var_159_1 = 0.925

			if var_159_0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_2 = arg_156_1:FormatText(StoryNameCfg[1020].name)

				arg_156_1.leftNameTxt_.text = var_159_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_3 = arg_156_1:GetWordFromCfg(322181038)
				local var_159_4 = arg_156_1:FormatText(var_159_3.content)

				arg_156_1.text_.text = var_159_4

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 37
				local var_159_6 = utf8.len(var_159_4)
				local var_159_7 = var_159_5 <= 0 and var_159_1 or var_159_1 * (var_159_6 / var_159_5)

				if var_159_7 > 0 and var_159_1 < var_159_7 then
					arg_156_1.talkMaxDuration = var_159_7

					if var_159_7 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_7 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_4
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181038", "story_v_out_322181.awb") ~= 0 then
					local var_159_8 = manager.audio:GetVoiceLength("story_v_out_322181", "322181038", "story_v_out_322181.awb") / 1000

					if var_159_8 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_8 + var_159_0
					end

					if var_159_3.prefab_name ~= "" and arg_156_1.actors_[var_159_3.prefab_name] ~= nil then
						local var_159_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_3.prefab_name].transform, "story_v_out_322181", "322181038", "story_v_out_322181.awb")

						arg_156_1:RecordAudio("322181038", var_159_9)
						arg_156_1:RecordAudio("322181038", var_159_9)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_322181", "322181038", "story_v_out_322181.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_322181", "322181038", "story_v_out_322181.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_10 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_10 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_10

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_10 and arg_156_1.time_ < var_159_0 + var_159_10 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play322181039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 322181039
		arg_160_1.duration_ = 18.7

		local var_160_0 = {
			zh = 10.633,
			ja = 18.7
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play322181040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0
			local var_163_1 = 1.125

			if var_163_0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_2 = arg_160_1:FormatText(StoryNameCfg[591].name)

				arg_160_1.leftNameTxt_.text = var_163_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_3 = arg_160_1:GetWordFromCfg(322181039)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_5 = 45
				local var_163_6 = utf8.len(var_163_4)
				local var_163_7 = var_163_5 <= 0 and var_163_1 or var_163_1 * (var_163_6 / var_163_5)

				if var_163_7 > 0 and var_163_1 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_0
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181039", "story_v_out_322181.awb") ~= 0 then
					local var_163_8 = manager.audio:GetVoiceLength("story_v_out_322181", "322181039", "story_v_out_322181.awb") / 1000

					if var_163_8 + var_163_0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_0
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_out_322181", "322181039", "story_v_out_322181.awb")

						arg_160_1:RecordAudio("322181039", var_163_9)
						arg_160_1:RecordAudio("322181039", var_163_9)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_322181", "322181039", "story_v_out_322181.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_322181", "322181039", "story_v_out_322181.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_10 = math.max(var_163_1, arg_160_1.talkMaxDuration)

			if var_163_0 <= arg_160_1.time_ and arg_160_1.time_ < var_163_0 + var_163_10 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_0) / var_163_10

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_0 + var_163_10 and arg_160_1.time_ < var_163_0 + var_163_10 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play322181040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 322181040
		arg_164_1.duration_ = 7.5

		local var_164_0 = {
			zh = 7.033,
			ja = 7.5
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play322181041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0
			local var_167_1 = 0.875

			if var_167_0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_2 = arg_164_1:FormatText(StoryNameCfg[591].name)

				arg_164_1.leftNameTxt_.text = var_167_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10061")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_3 = arg_164_1:GetWordFromCfg(322181040)
				local var_167_4 = arg_164_1:FormatText(var_167_3.content)

				arg_164_1.text_.text = var_167_4

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 35
				local var_167_6 = utf8.len(var_167_4)
				local var_167_7 = var_167_5 <= 0 and var_167_1 or var_167_1 * (var_167_6 / var_167_5)

				if var_167_7 > 0 and var_167_1 < var_167_7 then
					arg_164_1.talkMaxDuration = var_167_7

					if var_167_7 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_7 + var_167_0
					end
				end

				arg_164_1.text_.text = var_167_4
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181040", "story_v_out_322181.awb") ~= 0 then
					local var_167_8 = manager.audio:GetVoiceLength("story_v_out_322181", "322181040", "story_v_out_322181.awb") / 1000

					if var_167_8 + var_167_0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_8 + var_167_0
					end

					if var_167_3.prefab_name ~= "" and arg_164_1.actors_[var_167_3.prefab_name] ~= nil then
						local var_167_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_3.prefab_name].transform, "story_v_out_322181", "322181040", "story_v_out_322181.awb")

						arg_164_1:RecordAudio("322181040", var_167_9)
						arg_164_1:RecordAudio("322181040", var_167_9)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_322181", "322181040", "story_v_out_322181.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_322181", "322181040", "story_v_out_322181.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_10 = math.max(var_167_1, arg_164_1.talkMaxDuration)

			if var_167_0 <= arg_164_1.time_ and arg_164_1.time_ < var_167_0 + var_167_10 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_0) / var_167_10

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_0 + var_167_10 and arg_164_1.time_ < var_167_0 + var_167_10 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play322181041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 322181041
		arg_168_1.duration_ = 7.03

		local var_168_0 = {
			zh = 6.3,
			ja = 7.033
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play322181042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["1111ui_story"].transform
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 then
				arg_168_1.var_.moveOldPos1111ui_story = var_171_0.localPosition
			end

			local var_171_2 = 0.001

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2
				local var_171_4 = Vector3.New(0, -0.87, -5.7)

				var_171_0.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1111ui_story, var_171_4, var_171_3)

				local var_171_5 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_5.x, var_171_5.y, var_171_5.z)

				local var_171_6 = var_171_0.localEulerAngles

				var_171_6.z = 0
				var_171_6.x = 0
				var_171_0.localEulerAngles = var_171_6
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 then
				var_171_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_171_7 = manager.ui.mainCamera.transform.position - var_171_0.position

				var_171_0.forward = Vector3.New(var_171_7.x, var_171_7.y, var_171_7.z)

				local var_171_8 = var_171_0.localEulerAngles

				var_171_8.z = 0
				var_171_8.x = 0
				var_171_0.localEulerAngles = var_171_8
			end

			local var_171_9 = arg_168_1.actors_["1111ui_story"]
			local var_171_10 = 0

			if var_171_10 < arg_168_1.time_ and arg_168_1.time_ <= var_171_10 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect1111ui_story == nil then
				arg_168_1.var_.characterEffect1111ui_story = var_171_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_11 = 0.200000002980232

			if var_171_10 <= arg_168_1.time_ and arg_168_1.time_ < var_171_10 + var_171_11 and not isNil(var_171_9) then
				local var_171_12 = (arg_168_1.time_ - var_171_10) / var_171_11

				if arg_168_1.var_.characterEffect1111ui_story and not isNil(var_171_9) then
					arg_168_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= var_171_10 + var_171_11 and arg_168_1.time_ < var_171_10 + var_171_11 + arg_171_0 and not isNil(var_171_9) and arg_168_1.var_.characterEffect1111ui_story then
				arg_168_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_171_13 = 0

			if var_171_13 < arg_168_1.time_ and arg_168_1.time_ <= var_171_13 + arg_171_0 then
				arg_168_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_171_14 = 0
			local var_171_15 = 0.55

			if var_171_14 < arg_168_1.time_ and arg_168_1.time_ <= var_171_14 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				local var_171_16 = arg_168_1:FormatText(StoryNameCfg[67].name)

				arg_168_1.leftNameTxt_.text = var_171_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_17 = arg_168_1:GetWordFromCfg(322181041)
				local var_171_18 = arg_168_1:FormatText(var_171_17.content)

				arg_168_1.text_.text = var_171_18

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_19 = 22
				local var_171_20 = utf8.len(var_171_18)
				local var_171_21 = var_171_19 <= 0 and var_171_15 or var_171_15 * (var_171_20 / var_171_19)

				if var_171_21 > 0 and var_171_15 < var_171_21 then
					arg_168_1.talkMaxDuration = var_171_21

					if var_171_21 + var_171_14 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_21 + var_171_14
					end
				end

				arg_168_1.text_.text = var_171_18
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181041", "story_v_out_322181.awb") ~= 0 then
					local var_171_22 = manager.audio:GetVoiceLength("story_v_out_322181", "322181041", "story_v_out_322181.awb") / 1000

					if var_171_22 + var_171_14 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_22 + var_171_14
					end

					if var_171_17.prefab_name ~= "" and arg_168_1.actors_[var_171_17.prefab_name] ~= nil then
						local var_171_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_17.prefab_name].transform, "story_v_out_322181", "322181041", "story_v_out_322181.awb")

						arg_168_1:RecordAudio("322181041", var_171_23)
						arg_168_1:RecordAudio("322181041", var_171_23)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_322181", "322181041", "story_v_out_322181.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_322181", "322181041", "story_v_out_322181.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_24 = math.max(var_171_15, arg_168_1.talkMaxDuration)

			if var_171_14 <= arg_168_1.time_ and arg_168_1.time_ < var_171_14 + var_171_24 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_14) / var_171_24

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_14 + var_171_24 and arg_168_1.time_ < var_171_14 + var_171_24 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play322181042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 322181042
		arg_172_1.duration_ = 2.37

		local var_172_0 = {
			zh = 1.6,
			ja = 2.366
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play322181043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = arg_172_1.actors_["1111ui_story"]
			local var_175_1 = 0

			if var_175_1 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1111ui_story == nil then
				arg_172_1.var_.characterEffect1111ui_story = var_175_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_2 and not isNil(var_175_0) then
				local var_175_3 = (arg_172_1.time_ - var_175_1) / var_175_2

				if arg_172_1.var_.characterEffect1111ui_story and not isNil(var_175_0) then
					local var_175_4 = Mathf.Lerp(0, 0.5, var_175_3)

					arg_172_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1111ui_story.fillRatio = var_175_4
				end
			end

			if arg_172_1.time_ >= var_175_1 + var_175_2 and arg_172_1.time_ < var_175_1 + var_175_2 + arg_175_0 and not isNil(var_175_0) and arg_172_1.var_.characterEffect1111ui_story then
				local var_175_5 = 0.5

				arg_172_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1111ui_story.fillRatio = var_175_5
			end

			local var_175_6 = 0
			local var_175_7 = 0.075

			if var_175_6 < arg_172_1.time_ and arg_172_1.time_ <= var_175_6 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_8 = arg_172_1:FormatText(StoryNameCfg[1020].name)

				arg_172_1.leftNameTxt_.text = var_175_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Goyle")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_9 = arg_172_1:GetWordFromCfg(322181042)
				local var_175_10 = arg_172_1:FormatText(var_175_9.content)

				arg_172_1.text_.text = var_175_10

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_11 = 3
				local var_175_12 = utf8.len(var_175_10)
				local var_175_13 = var_175_11 <= 0 and var_175_7 or var_175_7 * (var_175_12 / var_175_11)

				if var_175_13 > 0 and var_175_7 < var_175_13 then
					arg_172_1.talkMaxDuration = var_175_13

					if var_175_13 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_13 + var_175_6
					end
				end

				arg_172_1.text_.text = var_175_10
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181042", "story_v_out_322181.awb") ~= 0 then
					local var_175_14 = manager.audio:GetVoiceLength("story_v_out_322181", "322181042", "story_v_out_322181.awb") / 1000

					if var_175_14 + var_175_6 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_14 + var_175_6
					end

					if var_175_9.prefab_name ~= "" and arg_172_1.actors_[var_175_9.prefab_name] ~= nil then
						local var_175_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_9.prefab_name].transform, "story_v_out_322181", "322181042", "story_v_out_322181.awb")

						arg_172_1:RecordAudio("322181042", var_175_15)
						arg_172_1:RecordAudio("322181042", var_175_15)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_322181", "322181042", "story_v_out_322181.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_322181", "322181042", "story_v_out_322181.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_16 = math.max(var_175_7, arg_172_1.talkMaxDuration)

			if var_175_6 <= arg_172_1.time_ and arg_172_1.time_ < var_175_6 + var_175_16 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_6) / var_175_16

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_6 + var_175_16 and arg_172_1.time_ < var_175_6 + var_175_16 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play322181043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 322181043
		arg_176_1.duration_ = 5.57

		local var_176_0 = {
			zh = 4.366,
			ja = 5.566
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play322181044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = arg_176_1.actors_["1111ui_story"]
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1111ui_story == nil then
				arg_176_1.var_.characterEffect1111ui_story = var_179_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if var_179_1 <= arg_176_1.time_ and arg_176_1.time_ < var_179_1 + var_179_2 and not isNil(var_179_0) then
				local var_179_3 = (arg_176_1.time_ - var_179_1) / var_179_2

				if arg_176_1.var_.characterEffect1111ui_story and not isNil(var_179_0) then
					arg_176_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= var_179_1 + var_179_2 and arg_176_1.time_ < var_179_1 + var_179_2 + arg_179_0 and not isNil(var_179_0) and arg_176_1.var_.characterEffect1111ui_story then
				arg_176_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_179_4 = 0

			if var_179_4 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_179_5 = 0
			local var_179_6 = 0.4

			if var_179_5 < arg_176_1.time_ and arg_176_1.time_ <= var_179_5 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				local var_179_7 = arg_176_1:FormatText(StoryNameCfg[67].name)

				arg_176_1.leftNameTxt_.text = var_179_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_8 = arg_176_1:GetWordFromCfg(322181043)
				local var_179_9 = arg_176_1:FormatText(var_179_8.content)

				arg_176_1.text_.text = var_179_9

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_10 = 16
				local var_179_11 = utf8.len(var_179_9)
				local var_179_12 = var_179_10 <= 0 and var_179_6 or var_179_6 * (var_179_11 / var_179_10)

				if var_179_12 > 0 and var_179_6 < var_179_12 then
					arg_176_1.talkMaxDuration = var_179_12

					if var_179_12 + var_179_5 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_12 + var_179_5
					end
				end

				arg_176_1.text_.text = var_179_9
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181043", "story_v_out_322181.awb") ~= 0 then
					local var_179_13 = manager.audio:GetVoiceLength("story_v_out_322181", "322181043", "story_v_out_322181.awb") / 1000

					if var_179_13 + var_179_5 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_13 + var_179_5
					end

					if var_179_8.prefab_name ~= "" and arg_176_1.actors_[var_179_8.prefab_name] ~= nil then
						local var_179_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_8.prefab_name].transform, "story_v_out_322181", "322181043", "story_v_out_322181.awb")

						arg_176_1:RecordAudio("322181043", var_179_14)
						arg_176_1:RecordAudio("322181043", var_179_14)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_322181", "322181043", "story_v_out_322181.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_322181", "322181043", "story_v_out_322181.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_15 = math.max(var_179_6, arg_176_1.talkMaxDuration)

			if var_179_5 <= arg_176_1.time_ and arg_176_1.time_ < var_179_5 + var_179_15 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_5) / var_179_15

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_5 + var_179_15 and arg_176_1.time_ < var_179_5 + var_179_15 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play322181044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 322181044
		arg_180_1.duration_ = 5

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play322181045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["1111ui_story"]
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1111ui_story == nil then
				arg_180_1.var_.characterEffect1111ui_story = var_183_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_2 = 0.200000002980232

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_2 and not isNil(var_183_0) then
				local var_183_3 = (arg_180_1.time_ - var_183_1) / var_183_2

				if arg_180_1.var_.characterEffect1111ui_story and not isNil(var_183_0) then
					local var_183_4 = Mathf.Lerp(0, 0.5, var_183_3)

					arg_180_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1111ui_story.fillRatio = var_183_4
				end
			end

			if arg_180_1.time_ >= var_183_1 + var_183_2 and arg_180_1.time_ < var_183_1 + var_183_2 + arg_183_0 and not isNil(var_183_0) and arg_180_1.var_.characterEffect1111ui_story then
				local var_183_5 = 0.5

				arg_180_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1111ui_story.fillRatio = var_183_5
			end

			local var_183_6 = 0.1
			local var_183_7 = 1

			if var_183_6 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				local var_183_8 = "play"
				local var_183_9 = "effect"

				arg_180_1:AudioAction(var_183_8, var_183_9, "se_story_side_1022", "se_story_side_1022_crowd", "")
			end

			local var_183_10 = 0.766666666666667
			local var_183_11 = 1

			if var_183_10 < arg_180_1.time_ and arg_180_1.time_ <= var_183_10 + arg_183_0 then
				local var_183_12 = "play"
				local var_183_13 = "effect"

				arg_180_1:AudioAction(var_183_12, var_183_13, "se_story_145", "se_story_145_hit", "")
			end

			local var_183_14 = 0
			local var_183_15 = 1.225

			if var_183_14 < arg_180_1.time_ and arg_180_1.time_ <= var_183_14 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_16 = arg_180_1:GetWordFromCfg(322181044)
				local var_183_17 = arg_180_1:FormatText(var_183_16.content)

				arg_180_1.text_.text = var_183_17

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_18 = 49
				local var_183_19 = utf8.len(var_183_17)
				local var_183_20 = var_183_18 <= 0 and var_183_15 or var_183_15 * (var_183_19 / var_183_18)

				if var_183_20 > 0 and var_183_15 < var_183_20 then
					arg_180_1.talkMaxDuration = var_183_20

					if var_183_20 + var_183_14 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_20 + var_183_14
					end
				end

				arg_180_1.text_.text = var_183_17
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_21 = math.max(var_183_15, arg_180_1.talkMaxDuration)

			if var_183_14 <= arg_180_1.time_ and arg_180_1.time_ < var_183_14 + var_183_21 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_14) / var_183_21

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_14 + var_183_21 and arg_180_1.time_ < var_183_14 + var_183_21 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play322181045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 322181045
		arg_184_1.duration_ = 8.77

		local var_184_0 = {
			zh = 7.2,
			ja = 8.766
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play322181046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["1111ui_story"]
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1111ui_story == nil then
				arg_184_1.var_.characterEffect1111ui_story = var_187_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_2 = 0.200000002980232

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_2 and not isNil(var_187_0) then
				local var_187_3 = (arg_184_1.time_ - var_187_1) / var_187_2

				if arg_184_1.var_.characterEffect1111ui_story and not isNil(var_187_0) then
					arg_184_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= var_187_1 + var_187_2 and arg_184_1.time_ < var_187_1 + var_187_2 + arg_187_0 and not isNil(var_187_0) and arg_184_1.var_.characterEffect1111ui_story then
				arg_184_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_187_4 = 0

			if var_187_4 < arg_184_1.time_ and arg_184_1.time_ <= var_187_4 + arg_187_0 then
				arg_184_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_187_5 = 0
			local var_187_6 = 0.725

			if var_187_5 < arg_184_1.time_ and arg_184_1.time_ <= var_187_5 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				local var_187_7 = arg_184_1:FormatText(StoryNameCfg[67].name)

				arg_184_1.leftNameTxt_.text = var_187_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_8 = arg_184_1:GetWordFromCfg(322181045)
				local var_187_9 = arg_184_1:FormatText(var_187_8.content)

				arg_184_1.text_.text = var_187_9

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_10 = 29
				local var_187_11 = utf8.len(var_187_9)
				local var_187_12 = var_187_10 <= 0 and var_187_6 or var_187_6 * (var_187_11 / var_187_10)

				if var_187_12 > 0 and var_187_6 < var_187_12 then
					arg_184_1.talkMaxDuration = var_187_12

					if var_187_12 + var_187_5 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_12 + var_187_5
					end
				end

				arg_184_1.text_.text = var_187_9
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322181", "322181045", "story_v_out_322181.awb") ~= 0 then
					local var_187_13 = manager.audio:GetVoiceLength("story_v_out_322181", "322181045", "story_v_out_322181.awb") / 1000

					if var_187_13 + var_187_5 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_13 + var_187_5
					end

					if var_187_8.prefab_name ~= "" and arg_184_1.actors_[var_187_8.prefab_name] ~= nil then
						local var_187_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_8.prefab_name].transform, "story_v_out_322181", "322181045", "story_v_out_322181.awb")

						arg_184_1:RecordAudio("322181045", var_187_14)
						arg_184_1:RecordAudio("322181045", var_187_14)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_322181", "322181045", "story_v_out_322181.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_322181", "322181045", "story_v_out_322181.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_15 = math.max(var_187_6, arg_184_1.talkMaxDuration)

			if var_187_5 <= arg_184_1.time_ and arg_184_1.time_ < var_187_5 + var_187_15 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_5) / var_187_15

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_5 + var_187_15 and arg_184_1.time_ < var_187_5 + var_187_15 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play322181046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 322181046
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
			arg_188_1.auto_ = false
		end

		function arg_188_1.playNext_(arg_190_0)
			arg_188_1.onStoryFinished_()
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["1111ui_story"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos1111ui_story = var_191_0.localPosition
			end

			local var_191_2 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_2 then
				local var_191_3 = (arg_188_1.time_ - var_191_1) / var_191_2
				local var_191_4 = Vector3.New(0, 100, 0)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1111ui_story, var_191_4, var_191_3)

				local var_191_5 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_5.x, var_191_5.y, var_191_5.z)

				local var_191_6 = var_191_0.localEulerAngles

				var_191_6.z = 0
				var_191_6.x = 0
				var_191_0.localEulerAngles = var_191_6
			end

			if arg_188_1.time_ >= var_191_1 + var_191_2 and arg_188_1.time_ < var_191_1 + var_191_2 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(0, 100, 0)

				local var_191_7 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_7.x, var_191_7.y, var_191_7.z)

				local var_191_8 = var_191_0.localEulerAngles

				var_191_8.z = 0
				var_191_8.x = 0
				var_191_0.localEulerAngles = var_191_8
			end

			local var_191_9 = 0
			local var_191_10 = 1.4

			if var_191_9 < arg_188_1.time_ and arg_188_1.time_ <= var_191_9 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_11 = arg_188_1:GetWordFromCfg(322181046)
				local var_191_12 = arg_188_1:FormatText(var_191_11.content)

				arg_188_1.text_.text = var_191_12

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_13 = 56
				local var_191_14 = utf8.len(var_191_12)
				local var_191_15 = var_191_13 <= 0 and var_191_10 or var_191_10 * (var_191_14 / var_191_13)

				if var_191_15 > 0 and var_191_10 < var_191_15 then
					arg_188_1.talkMaxDuration = var_191_15

					if var_191_15 + var_191_9 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_15 + var_191_9
					end
				end

				arg_188_1.text_.text = var_191_12
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_16 = math.max(var_191_10, arg_188_1.talkMaxDuration)

			if var_191_9 <= arg_188_1.time_ and arg_188_1.time_ < var_191_9 + var_191_16 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_9) / var_191_16

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_9 + var_191_16 and arg_188_1.time_ < var_191_9 + var_191_16 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L09g",
		"TextureConfig/Background/L09f"
	},
	voices = {
		"story_v_out_322181.awb"
	}
}
