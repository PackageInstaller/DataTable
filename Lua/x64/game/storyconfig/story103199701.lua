return {
	Play319971001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319971001
		arg_1_1.duration_ = 13.63

		local var_1_0 = {
			zh = 13.6330000029802,
			ja = 12.7000000029802
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
				arg_1_0:Play319971002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST07a"

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
				local var_4_5 = arg_1_1.bgs_.ST07a

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
					if iter_4_0 ~= "ST07a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 2.00000000298023

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

			local var_4_24 = "10066ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["10066ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos10066ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -0.99, -5.83)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10066ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["10066ui_story"]
			local var_4_39 = 1.8

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect10066ui_story == nil then
				arg_1_1.var_.characterEffect10066ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect10066ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect10066ui_story then
				arg_1_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_1")
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
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

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_activity_3_0_story_theme_piano", "bgm_activity_3_0_story_theme_piano", "bgm_activity_3_0_story_theme_piano.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_activity_3_0_story_theme_piano", "bgm_activity_3_0_story_theme_piano")

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
			local var_4_57 = 0.825

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

				local var_4_59 = arg_1_1:FormatText(StoryNameCfg[640].name)

				arg_1_1.leftNameTxt_.text = var_4_59

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_60 = arg_1_1:GetWordFromCfg(319971001)
				local var_4_61 = arg_1_1:FormatText(var_4_60.content)

				arg_1_1.text_.text = var_4_61

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_62 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971001", "story_v_out_319971.awb") ~= 0 then
					local var_4_65 = manager.audio:GetVoiceLength("story_v_out_319971", "319971001", "story_v_out_319971.awb") / 1000

					if var_4_65 + var_4_56 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_65 + var_4_56
					end

					if var_4_60.prefab_name ~= "" and arg_1_1.actors_[var_4_60.prefab_name] ~= nil then
						local var_4_66 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_60.prefab_name].transform, "story_v_out_319971", "319971001", "story_v_out_319971.awb")

						arg_1_1:RecordAudio("319971001", var_4_66)
						arg_1_1:RecordAudio("319971001", var_4_66)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319971", "319971001", "story_v_out_319971.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319971", "319971001", "story_v_out_319971.awb")
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
				actorName = "10066ui_story",
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
	Play319971002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319971002
		arg_9_1.duration_ = 3.93

		local var_9_0 = {
			zh = 3.766,
			ja = 3.933
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
				arg_9_0:Play319971003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0

			if var_12_0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_0 + arg_12_0 then
				arg_9_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_2")
			end

			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_12_2 = 0
			local var_12_3 = 0.2

			if var_12_2 < arg_9_1.time_ and arg_9_1.time_ <= var_12_2 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_4 = arg_9_1:FormatText(StoryNameCfg[640].name)

				arg_9_1.leftNameTxt_.text = var_12_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_5 = arg_9_1:GetWordFromCfg(319971002)
				local var_12_6 = arg_9_1:FormatText(var_12_5.content)

				arg_9_1.text_.text = var_12_6

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 8
				local var_12_8 = utf8.len(var_12_6)
				local var_12_9 = var_12_7 <= 0 and var_12_3 or var_12_3 * (var_12_8 / var_12_7)

				if var_12_9 > 0 and var_12_3 < var_12_9 then
					arg_9_1.talkMaxDuration = var_12_9

					if var_12_9 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_9 + var_12_2
					end
				end

				arg_9_1.text_.text = var_12_6
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971002", "story_v_out_319971.awb") ~= 0 then
					local var_12_10 = manager.audio:GetVoiceLength("story_v_out_319971", "319971002", "story_v_out_319971.awb") / 1000

					if var_12_10 + var_12_2 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_10 + var_12_2
					end

					if var_12_5.prefab_name ~= "" and arg_9_1.actors_[var_12_5.prefab_name] ~= nil then
						local var_12_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_5.prefab_name].transform, "story_v_out_319971", "319971002", "story_v_out_319971.awb")

						arg_9_1:RecordAudio("319971002", var_12_11)
						arg_9_1:RecordAudio("319971002", var_12_11)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319971", "319971002", "story_v_out_319971.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319971", "319971002", "story_v_out_319971.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_12 = math.max(var_12_3, arg_9_1.talkMaxDuration)

			if var_12_2 <= arg_9_1.time_ and arg_9_1.time_ < var_12_2 + var_12_12 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_2) / var_12_12

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_2 + var_12_12 and arg_9_1.time_ < var_12_2 + var_12_12 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play319971003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319971003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play319971004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10066ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect10066ui_story == nil then
				arg_13_1.var_.characterEffect10066ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.2

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect10066ui_story and not isNil(var_16_0) then
					local var_16_4 = Mathf.Lerp(0, 0.5, var_16_3)

					arg_13_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10066ui_story.fillRatio = var_16_4
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect10066ui_story then
				local var_16_5 = 0.5

				arg_13_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10066ui_story.fillRatio = var_16_5
			end

			local var_16_6 = 0
			local var_16_7 = 1.325

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:GetWordFromCfg(319971003)
				local var_16_9 = arg_13_1:FormatText(var_16_8.content)

				arg_13_1.text_.text = var_16_9

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 53
				local var_16_11 = utf8.len(var_16_9)
				local var_16_12 = var_16_10 <= 0 and var_16_7 or var_16_7 * (var_16_11 / var_16_10)

				if var_16_12 > 0 and var_16_7 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12

					if var_16_12 + var_16_6 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_6
					end
				end

				arg_13_1.text_.text = var_16_9
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_7, arg_13_1.talkMaxDuration)

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_6) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_6 + var_16_13 and arg_13_1.time_ < var_16_6 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play319971004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319971004
		arg_17_1.duration_ = 7.23

		local var_17_0 = {
			zh = 7.233,
			ja = 5.366
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
				arg_17_0:Play319971005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10066ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos10066ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, -0.99, -5.83)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10066ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["10066ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect10066ui_story == nil then
				arg_17_1.var_.characterEffect10066ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect10066ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect10066ui_story then
				arg_17_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			local var_20_14 = 0

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_20_15 = 0
			local var_20_16 = 0.75

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_17 = arg_17_1:FormatText(StoryNameCfg[640].name)

				arg_17_1.leftNameTxt_.text = var_20_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_18 = arg_17_1:GetWordFromCfg(319971004)
				local var_20_19 = arg_17_1:FormatText(var_20_18.content)

				arg_17_1.text_.text = var_20_19

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_20 = 30
				local var_20_21 = utf8.len(var_20_19)
				local var_20_22 = var_20_20 <= 0 and var_20_16 or var_20_16 * (var_20_21 / var_20_20)

				if var_20_22 > 0 and var_20_16 < var_20_22 then
					arg_17_1.talkMaxDuration = var_20_22

					if var_20_22 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_22 + var_20_15
					end
				end

				arg_17_1.text_.text = var_20_19
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971004", "story_v_out_319971.awb") ~= 0 then
					local var_20_23 = manager.audio:GetVoiceLength("story_v_out_319971", "319971004", "story_v_out_319971.awb") / 1000

					if var_20_23 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_15
					end

					if var_20_18.prefab_name ~= "" and arg_17_1.actors_[var_20_18.prefab_name] ~= nil then
						local var_20_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_18.prefab_name].transform, "story_v_out_319971", "319971004", "story_v_out_319971.awb")

						arg_17_1:RecordAudio("319971004", var_20_24)
						arg_17_1:RecordAudio("319971004", var_20_24)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319971", "319971004", "story_v_out_319971.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319971", "319971004", "story_v_out_319971.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_25 = math.max(var_20_16, arg_17_1.talkMaxDuration)

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_25 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_15) / var_20_25

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_15 + var_20_25 and arg_17_1.time_ < var_20_15 + var_20_25 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play319971005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319971005
		arg_21_1.duration_ = 5.63

		local var_21_0 = {
			zh = 2.9,
			ja = 5.633
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
				arg_21_0:Play319971006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = "1084ui_story"

			if arg_21_1.actors_[var_24_0] == nil then
				local var_24_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_24_1) then
					local var_24_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_21_1.stage_.transform)

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

			local var_24_5 = arg_21_1.actors_["1084ui_story"].transform
			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.var_.moveOldPos1084ui_story = var_24_5.localPosition
			end

			local var_24_7 = 0.001

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_7 then
				local var_24_8 = (arg_21_1.time_ - var_24_6) / var_24_7
				local var_24_9 = Vector3.New(0.7, -0.97, -6)

				var_24_5.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1084ui_story, var_24_9, var_24_8)

				local var_24_10 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_10.x, var_24_10.y, var_24_10.z)

				local var_24_11 = var_24_5.localEulerAngles

				var_24_11.z = 0
				var_24_11.x = 0
				var_24_5.localEulerAngles = var_24_11
			end

			if arg_21_1.time_ >= var_24_6 + var_24_7 and arg_21_1.time_ < var_24_6 + var_24_7 + arg_24_0 then
				var_24_5.localPosition = Vector3.New(0.7, -0.97, -6)

				local var_24_12 = manager.ui.mainCamera.transform.position - var_24_5.position

				var_24_5.forward = Vector3.New(var_24_12.x, var_24_12.y, var_24_12.z)

				local var_24_13 = var_24_5.localEulerAngles

				var_24_13.z = 0
				var_24_13.x = 0
				var_24_5.localEulerAngles = var_24_13
			end

			local var_24_14 = arg_21_1.actors_["1084ui_story"]
			local var_24_15 = 0

			if var_24_15 < arg_21_1.time_ and arg_21_1.time_ <= var_24_15 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect1084ui_story == nil then
				arg_21_1.var_.characterEffect1084ui_story = var_24_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_16 = 0.200000002980232

			if var_24_15 <= arg_21_1.time_ and arg_21_1.time_ < var_24_15 + var_24_16 and not isNil(var_24_14) then
				local var_24_17 = (arg_21_1.time_ - var_24_15) / var_24_16

				if arg_21_1.var_.characterEffect1084ui_story and not isNil(var_24_14) then
					arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_15 + var_24_16 and arg_21_1.time_ < var_24_15 + var_24_16 + arg_24_0 and not isNil(var_24_14) and arg_21_1.var_.characterEffect1084ui_story then
				arg_21_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_24_18 = 0

			if var_24_18 < arg_21_1.time_ and arg_21_1.time_ <= var_24_18 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			local var_24_19 = 0

			if var_24_19 < arg_21_1.time_ and arg_21_1.time_ <= var_24_19 + arg_24_0 then
				arg_21_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_24_20 = arg_21_1.actors_["10066ui_story"].transform
			local var_24_21 = 0

			if var_24_21 < arg_21_1.time_ and arg_21_1.time_ <= var_24_21 + arg_24_0 then
				arg_21_1.var_.moveOldPos10066ui_story = var_24_20.localPosition
			end

			local var_24_22 = 0.001

			if var_24_21 <= arg_21_1.time_ and arg_21_1.time_ < var_24_21 + var_24_22 then
				local var_24_23 = (arg_21_1.time_ - var_24_21) / var_24_22
				local var_24_24 = Vector3.New(-0.7, -0.99, -5.83)

				var_24_20.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10066ui_story, var_24_24, var_24_23)

				local var_24_25 = manager.ui.mainCamera.transform.position - var_24_20.position

				var_24_20.forward = Vector3.New(var_24_25.x, var_24_25.y, var_24_25.z)

				local var_24_26 = var_24_20.localEulerAngles

				var_24_26.z = 0
				var_24_26.x = 0
				var_24_20.localEulerAngles = var_24_26
			end

			if arg_21_1.time_ >= var_24_21 + var_24_22 and arg_21_1.time_ < var_24_21 + var_24_22 + arg_24_0 then
				var_24_20.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_24_27 = manager.ui.mainCamera.transform.position - var_24_20.position

				var_24_20.forward = Vector3.New(var_24_27.x, var_24_27.y, var_24_27.z)

				local var_24_28 = var_24_20.localEulerAngles

				var_24_28.z = 0
				var_24_28.x = 0
				var_24_20.localEulerAngles = var_24_28
			end

			local var_24_29 = arg_21_1.actors_["10066ui_story"]
			local var_24_30 = 0

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 and not isNil(var_24_29) and arg_21_1.var_.characterEffect10066ui_story == nil then
				arg_21_1.var_.characterEffect10066ui_story = var_24_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_31 = 0.200000002980232

			if var_24_30 <= arg_21_1.time_ and arg_21_1.time_ < var_24_30 + var_24_31 and not isNil(var_24_29) then
				local var_24_32 = (arg_21_1.time_ - var_24_30) / var_24_31

				if arg_21_1.var_.characterEffect10066ui_story and not isNil(var_24_29) then
					local var_24_33 = Mathf.Lerp(0, 0.5, var_24_32)

					arg_21_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10066ui_story.fillRatio = var_24_33
				end
			end

			if arg_21_1.time_ >= var_24_30 + var_24_31 and arg_21_1.time_ < var_24_30 + var_24_31 + arg_24_0 and not isNil(var_24_29) and arg_21_1.var_.characterEffect10066ui_story then
				local var_24_34 = 0.5

				arg_21_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10066ui_story.fillRatio = var_24_34
			end

			local var_24_35 = 0
			local var_24_36 = 0.325

			if var_24_35 < arg_21_1.time_ and arg_21_1.time_ <= var_24_35 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_37 = arg_21_1:FormatText(StoryNameCfg[6].name)

				arg_21_1.leftNameTxt_.text = var_24_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_38 = arg_21_1:GetWordFromCfg(319971005)
				local var_24_39 = arg_21_1:FormatText(var_24_38.content)

				arg_21_1.text_.text = var_24_39

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_40 = 13
				local var_24_41 = utf8.len(var_24_39)
				local var_24_42 = var_24_40 <= 0 and var_24_36 or var_24_36 * (var_24_41 / var_24_40)

				if var_24_42 > 0 and var_24_36 < var_24_42 then
					arg_21_1.talkMaxDuration = var_24_42

					if var_24_42 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_42 + var_24_35
					end
				end

				arg_21_1.text_.text = var_24_39
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971005", "story_v_out_319971.awb") ~= 0 then
					local var_24_43 = manager.audio:GetVoiceLength("story_v_out_319971", "319971005", "story_v_out_319971.awb") / 1000

					if var_24_43 + var_24_35 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_43 + var_24_35
					end

					if var_24_38.prefab_name ~= "" and arg_21_1.actors_[var_24_38.prefab_name] ~= nil then
						local var_24_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_38.prefab_name].transform, "story_v_out_319971", "319971005", "story_v_out_319971.awb")

						arg_21_1:RecordAudio("319971005", var_24_44)
						arg_21_1:RecordAudio("319971005", var_24_44)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319971", "319971005", "story_v_out_319971.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319971", "319971005", "story_v_out_319971.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_45 = math.max(var_24_36, arg_21_1.talkMaxDuration)

			if var_24_35 <= arg_21_1.time_ and arg_21_1.time_ < var_24_35 + var_24_45 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_35) / var_24_45

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_35 + var_24_45 and arg_21_1.time_ < var_24_35 + var_24_45 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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
				actorName = "10066ui_story",
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
	Play319971006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319971006
		arg_25_1.duration_ = 6.1

		local var_25_0 = {
			zh = 5.866,
			ja = 6.1
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
				arg_25_0:Play319971007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1084ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1084ui_story and not isNil(var_28_0) then
					local var_28_4 = Mathf.Lerp(0, 0.5, var_28_3)

					arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1084ui_story.fillRatio = var_28_4
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1084ui_story then
				local var_28_5 = 0.5

				arg_25_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1084ui_story.fillRatio = var_28_5
			end

			local var_28_6 = arg_25_1.actors_["10066ui_story"]
			local var_28_7 = 0

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect10066ui_story == nil then
				arg_25_1.var_.characterEffect10066ui_story = var_28_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_8 = 0.200000002980232

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_8 and not isNil(var_28_6) then
				local var_28_9 = (arg_25_1.time_ - var_28_7) / var_28_8

				if arg_25_1.var_.characterEffect10066ui_story and not isNil(var_28_6) then
					arg_25_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_7 + var_28_8 and arg_25_1.time_ < var_28_7 + var_28_8 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect10066ui_story then
				arg_25_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_28_10 = 0
			local var_28_11 = 0.575

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_12 = arg_25_1:FormatText(StoryNameCfg[640].name)

				arg_25_1.leftNameTxt_.text = var_28_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_13 = arg_25_1:GetWordFromCfg(319971006)
				local var_28_14 = arg_25_1:FormatText(var_28_13.content)

				arg_25_1.text_.text = var_28_14

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_15 = 23
				local var_28_16 = utf8.len(var_28_14)
				local var_28_17 = var_28_15 <= 0 and var_28_11 or var_28_11 * (var_28_16 / var_28_15)

				if var_28_17 > 0 and var_28_11 < var_28_17 then
					arg_25_1.talkMaxDuration = var_28_17

					if var_28_17 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_17 + var_28_10
					end
				end

				arg_25_1.text_.text = var_28_14
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971006", "story_v_out_319971.awb") ~= 0 then
					local var_28_18 = manager.audio:GetVoiceLength("story_v_out_319971", "319971006", "story_v_out_319971.awb") / 1000

					if var_28_18 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_18 + var_28_10
					end

					if var_28_13.prefab_name ~= "" and arg_25_1.actors_[var_28_13.prefab_name] ~= nil then
						local var_28_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_13.prefab_name].transform, "story_v_out_319971", "319971006", "story_v_out_319971.awb")

						arg_25_1:RecordAudio("319971006", var_28_19)
						arg_25_1:RecordAudio("319971006", var_28_19)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319971", "319971006", "story_v_out_319971.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319971", "319971006", "story_v_out_319971.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_20 = math.max(var_28_11, arg_25_1.talkMaxDuration)

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_20 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_10) / var_28_20

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_10 + var_28_20 and arg_25_1.time_ < var_28_10 + var_28_20 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319971007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319971007
		arg_29_1.duration_ = 2.03

		local var_29_0 = {
			zh = 1.533,
			ja = 2.033
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
				arg_29_0:Play319971008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1084ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1084ui_story == nil then
				arg_29_1.var_.characterEffect1084ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1084ui_story and not isNil(var_32_0) then
					arg_29_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1084ui_story then
				arg_29_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_32_4 = arg_29_1.actors_["10066ui_story"]
			local var_32_5 = 0

			if var_32_5 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect10066ui_story == nil then
				arg_29_1.var_.characterEffect10066ui_story = var_32_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 and not isNil(var_32_4) then
				local var_32_7 = (arg_29_1.time_ - var_32_5) / var_32_6

				if arg_29_1.var_.characterEffect10066ui_story and not isNil(var_32_4) then
					local var_32_8 = Mathf.Lerp(0, 0.5, var_32_7)

					arg_29_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10066ui_story.fillRatio = var_32_8
				end
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect10066ui_story then
				local var_32_9 = 0.5

				arg_29_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10066ui_story.fillRatio = var_32_9
			end

			local var_32_10 = 0
			local var_32_11 = 0.15

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_12 = arg_29_1:FormatText(StoryNameCfg[6].name)

				arg_29_1.leftNameTxt_.text = var_32_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_13 = arg_29_1:GetWordFromCfg(319971007)
				local var_32_14 = arg_29_1:FormatText(var_32_13.content)

				arg_29_1.text_.text = var_32_14

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_15 = 6
				local var_32_16 = utf8.len(var_32_14)
				local var_32_17 = var_32_15 <= 0 and var_32_11 or var_32_11 * (var_32_16 / var_32_15)

				if var_32_17 > 0 and var_32_11 < var_32_17 then
					arg_29_1.talkMaxDuration = var_32_17

					if var_32_17 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_17 + var_32_10
					end
				end

				arg_29_1.text_.text = var_32_14
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971007", "story_v_out_319971.awb") ~= 0 then
					local var_32_18 = manager.audio:GetVoiceLength("story_v_out_319971", "319971007", "story_v_out_319971.awb") / 1000

					if var_32_18 + var_32_10 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_18 + var_32_10
					end

					if var_32_13.prefab_name ~= "" and arg_29_1.actors_[var_32_13.prefab_name] ~= nil then
						local var_32_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_13.prefab_name].transform, "story_v_out_319971", "319971007", "story_v_out_319971.awb")

						arg_29_1:RecordAudio("319971007", var_32_19)
						arg_29_1:RecordAudio("319971007", var_32_19)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319971", "319971007", "story_v_out_319971.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319971", "319971007", "story_v_out_319971.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_20 = math.max(var_32_11, arg_29_1.talkMaxDuration)

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_20 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_10) / var_32_20

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_10 + var_32_20 and arg_29_1.time_ < var_32_10 + var_32_20 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319971008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319971008
		arg_33_1.duration_ = 2

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play319971009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["10066ui_story"].transform
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.var_.moveOldPos10066ui_story = var_36_0.localPosition
			end

			local var_36_2 = 0.001

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2
				local var_36_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_36_0.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10066ui_story, var_36_4, var_36_3)

				local var_36_5 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_5.x, var_36_5.y, var_36_5.z)

				local var_36_6 = var_36_0.localEulerAngles

				var_36_6.z = 0
				var_36_6.x = 0
				var_36_0.localEulerAngles = var_36_6
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 then
				var_36_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_36_7 = manager.ui.mainCamera.transform.position - var_36_0.position

				var_36_0.forward = Vector3.New(var_36_7.x, var_36_7.y, var_36_7.z)

				local var_36_8 = var_36_0.localEulerAngles

				var_36_8.z = 0
				var_36_8.x = 0
				var_36_0.localEulerAngles = var_36_8
			end

			local var_36_9 = arg_33_1.actors_["10066ui_story"]
			local var_36_10 = 0

			if var_36_10 < arg_33_1.time_ and arg_33_1.time_ <= var_36_10 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect10066ui_story == nil then
				arg_33_1.var_.characterEffect10066ui_story = var_36_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_11 = 0.200000002980232

			if var_36_10 <= arg_33_1.time_ and arg_33_1.time_ < var_36_10 + var_36_11 and not isNil(var_36_9) then
				local var_36_12 = (arg_33_1.time_ - var_36_10) / var_36_11

				if arg_33_1.var_.characterEffect10066ui_story and not isNil(var_36_9) then
					arg_33_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_10 + var_36_11 and arg_33_1.time_ < var_36_10 + var_36_11 + arg_36_0 and not isNil(var_36_9) and arg_33_1.var_.characterEffect10066ui_story then
				arg_33_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_36_13 = 0

			if var_36_13 < arg_33_1.time_ and arg_33_1.time_ <= var_36_13 + arg_36_0 then
				arg_33_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action1_1")
			end

			local var_36_14 = 0

			if var_36_14 < arg_33_1.time_ and arg_33_1.time_ <= var_36_14 + arg_36_0 then
				arg_33_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_15 = arg_33_1.actors_["1084ui_story"]
			local var_36_16 = 0

			if var_36_16 < arg_33_1.time_ and arg_33_1.time_ <= var_36_16 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.characterEffect1084ui_story == nil then
				arg_33_1.var_.characterEffect1084ui_story = var_36_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_17 = 0.200000002980232

			if var_36_16 <= arg_33_1.time_ and arg_33_1.time_ < var_36_16 + var_36_17 and not isNil(var_36_15) then
				local var_36_18 = (arg_33_1.time_ - var_36_16) / var_36_17

				if arg_33_1.var_.characterEffect1084ui_story and not isNil(var_36_15) then
					local var_36_19 = Mathf.Lerp(0, 0.5, var_36_18)

					arg_33_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1084ui_story.fillRatio = var_36_19
				end
			end

			if arg_33_1.time_ >= var_36_16 + var_36_17 and arg_33_1.time_ < var_36_16 + var_36_17 + arg_36_0 and not isNil(var_36_15) and arg_33_1.var_.characterEffect1084ui_story then
				local var_36_20 = 0.5

				arg_33_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1084ui_story.fillRatio = var_36_20
			end

			local var_36_21 = 0
			local var_36_22 = 0.05

			if var_36_21 < arg_33_1.time_ and arg_33_1.time_ <= var_36_21 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_23 = arg_33_1:FormatText(StoryNameCfg[640].name)

				arg_33_1.leftNameTxt_.text = var_36_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_24 = arg_33_1:GetWordFromCfg(319971008)
				local var_36_25 = arg_33_1:FormatText(var_36_24.content)

				arg_33_1.text_.text = var_36_25

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_26 = 2
				local var_36_27 = utf8.len(var_36_25)
				local var_36_28 = var_36_26 <= 0 and var_36_22 or var_36_22 * (var_36_27 / var_36_26)

				if var_36_28 > 0 and var_36_22 < var_36_28 then
					arg_33_1.talkMaxDuration = var_36_28

					if var_36_28 + var_36_21 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_28 + var_36_21
					end
				end

				arg_33_1.text_.text = var_36_25
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971008", "story_v_out_319971.awb") ~= 0 then
					local var_36_29 = manager.audio:GetVoiceLength("story_v_out_319971", "319971008", "story_v_out_319971.awb") / 1000

					if var_36_29 + var_36_21 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_29 + var_36_21
					end

					if var_36_24.prefab_name ~= "" and arg_33_1.actors_[var_36_24.prefab_name] ~= nil then
						local var_36_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_24.prefab_name].transform, "story_v_out_319971", "319971008", "story_v_out_319971.awb")

						arg_33_1:RecordAudio("319971008", var_36_30)
						arg_33_1:RecordAudio("319971008", var_36_30)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319971", "319971008", "story_v_out_319971.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319971", "319971008", "story_v_out_319971.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_31 = math.max(var_36_22, arg_33_1.talkMaxDuration)

			if var_36_21 <= arg_33_1.time_ and arg_33_1.time_ < var_36_21 + var_36_31 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_21) / var_36_31

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_21 + var_36_31 and arg_33_1.time_ < var_36_21 + var_36_31 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
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
	Play319971009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319971009
		arg_37_1.duration_ = 4.47

		local var_37_0 = {
			zh = 2.133,
			ja = 4.466
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
				arg_37_0:Play319971010(arg_37_1)
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
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action437")
			end

			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_6 = arg_37_1.actors_["10066ui_story"]
			local var_40_7 = 0

			if var_40_7 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect10066ui_story == nil then
				arg_37_1.var_.characterEffect10066ui_story = var_40_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_8 = 0.200000002980232

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_8 and not isNil(var_40_6) then
				local var_40_9 = (arg_37_1.time_ - var_40_7) / var_40_8

				if arg_37_1.var_.characterEffect10066ui_story and not isNil(var_40_6) then
					local var_40_10 = Mathf.Lerp(0, 0.5, var_40_9)

					arg_37_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10066ui_story.fillRatio = var_40_10
				end
			end

			if arg_37_1.time_ >= var_40_7 + var_40_8 and arg_37_1.time_ < var_40_7 + var_40_8 + arg_40_0 and not isNil(var_40_6) and arg_37_1.var_.characterEffect10066ui_story then
				local var_40_11 = 0.5

				arg_37_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10066ui_story.fillRatio = var_40_11
			end

			local var_40_12 = 0
			local var_40_13 = 0.3

			if var_40_12 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_14 = arg_37_1:FormatText(StoryNameCfg[6].name)

				arg_37_1.leftNameTxt_.text = var_40_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_15 = arg_37_1:GetWordFromCfg(319971009)
				local var_40_16 = arg_37_1:FormatText(var_40_15.content)

				arg_37_1.text_.text = var_40_16

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 12
				local var_40_18 = utf8.len(var_40_16)
				local var_40_19 = var_40_17 <= 0 and var_40_13 or var_40_13 * (var_40_18 / var_40_17)

				if var_40_19 > 0 and var_40_13 < var_40_19 then
					arg_37_1.talkMaxDuration = var_40_19

					if var_40_19 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_19 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_16
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971009", "story_v_out_319971.awb") ~= 0 then
					local var_40_20 = manager.audio:GetVoiceLength("story_v_out_319971", "319971009", "story_v_out_319971.awb") / 1000

					if var_40_20 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_12
					end

					if var_40_15.prefab_name ~= "" and arg_37_1.actors_[var_40_15.prefab_name] ~= nil then
						local var_40_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_15.prefab_name].transform, "story_v_out_319971", "319971009", "story_v_out_319971.awb")

						arg_37_1:RecordAudio("319971009", var_40_21)
						arg_37_1:RecordAudio("319971009", var_40_21)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319971", "319971009", "story_v_out_319971.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319971", "319971009", "story_v_out_319971.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_22 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 <= arg_37_1.time_ and arg_37_1.time_ < var_40_12 + var_40_22 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_12) / var_40_22

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_12 + var_40_22 and arg_37_1.time_ < var_40_12 + var_40_22 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play319971010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319971010
		arg_41_1.duration_ = 8.93

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play319971011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = "ML0210"

			if arg_41_1.bgs_[var_44_0] == nil then
				local var_44_1 = Object.Instantiate(arg_41_1.paintGo_)

				var_44_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_44_0)
				var_44_1.name = var_44_0
				var_44_1.transform.parent = arg_41_1.stage_.transform
				var_44_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.bgs_[var_44_0] = var_44_1
			end

			local var_44_2 = 1.98333333333333

			if var_44_2 < arg_41_1.time_ and arg_41_1.time_ <= var_44_2 + arg_44_0 then
				local var_44_3 = manager.ui.mainCamera.transform.localPosition
				local var_44_4 = Vector3.New(0, 0, 10) + Vector3.New(var_44_3.x, var_44_3.y, 0)
				local var_44_5 = arg_41_1.bgs_.ML0210

				var_44_5.transform.localPosition = var_44_4
				var_44_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_44_6 = var_44_5:GetComponent("SpriteRenderer")

				if var_44_6 and var_44_6.sprite then
					local var_44_7 = (var_44_5.transform.localPosition - var_44_3).z
					local var_44_8 = manager.ui.mainCameraCom_
					local var_44_9 = 2 * var_44_7 * Mathf.Tan(var_44_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_44_10 = var_44_9 * var_44_8.aspect
					local var_44_11 = var_44_6.sprite.bounds.size.x
					local var_44_12 = var_44_6.sprite.bounds.size.y
					local var_44_13 = var_44_10 / var_44_11
					local var_44_14 = var_44_9 / var_44_12
					local var_44_15 = var_44_14 < var_44_13 and var_44_13 or var_44_14

					var_44_5.transform.localScale = Vector3.New(var_44_15, var_44_15, 0)
				end

				for iter_44_0, iter_44_1 in pairs(arg_41_1.bgs_) do
					if iter_44_0 ~= "ML0210" then
						iter_44_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_44_16 = 4

			if var_44_16 < arg_41_1.time_ and arg_41_1.time_ <= var_44_16 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			local var_44_17 = 0.3

			if arg_41_1.time_ >= var_44_16 + var_44_17 and arg_41_1.time_ < var_44_16 + var_44_17 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			local var_44_18 = 0

			if var_44_18 < arg_41_1.time_ and arg_41_1.time_ <= var_44_18 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_19 = 2

			if var_44_18 <= arg_41_1.time_ and arg_41_1.time_ < var_44_18 + var_44_19 then
				local var_44_20 = (arg_41_1.time_ - var_44_18) / var_44_19
				local var_44_21 = Color.New(0, 0, 0)

				var_44_21.a = Mathf.Lerp(0, 1, var_44_20)
				arg_41_1.mask_.color = var_44_21
			end

			if arg_41_1.time_ >= var_44_18 + var_44_19 and arg_41_1.time_ < var_44_18 + var_44_19 + arg_44_0 then
				local var_44_22 = Color.New(0, 0, 0)

				var_44_22.a = 1
				arg_41_1.mask_.color = var_44_22
			end

			local var_44_23 = 2

			if var_44_23 < arg_41_1.time_ and arg_41_1.time_ <= var_44_23 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_24 = 2

			if var_44_23 <= arg_41_1.time_ and arg_41_1.time_ < var_44_23 + var_44_24 then
				local var_44_25 = (arg_41_1.time_ - var_44_23) / var_44_24
				local var_44_26 = Color.New(0, 0, 0)

				var_44_26.a = Mathf.Lerp(1, 0, var_44_25)
				arg_41_1.mask_.color = var_44_26
			end

			if arg_41_1.time_ >= var_44_23 + var_44_24 and arg_41_1.time_ < var_44_23 + var_44_24 + arg_44_0 then
				local var_44_27 = Color.New(0, 0, 0)
				local var_44_28 = 0

				arg_41_1.mask_.enabled = false
				var_44_27.a = var_44_28
				arg_41_1.mask_.color = var_44_27
			end

			local var_44_29 = arg_41_1.actors_["1084ui_story"].transform
			local var_44_30 = 1.96599999815226

			if var_44_30 < arg_41_1.time_ and arg_41_1.time_ <= var_44_30 + arg_44_0 then
				arg_41_1.var_.moveOldPos1084ui_story = var_44_29.localPosition
			end

			local var_44_31 = 0.001

			if var_44_30 <= arg_41_1.time_ and arg_41_1.time_ < var_44_30 + var_44_31 then
				local var_44_32 = (arg_41_1.time_ - var_44_30) / var_44_31
				local var_44_33 = Vector3.New(0, 100, 0)

				var_44_29.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1084ui_story, var_44_33, var_44_32)

				local var_44_34 = manager.ui.mainCamera.transform.position - var_44_29.position

				var_44_29.forward = Vector3.New(var_44_34.x, var_44_34.y, var_44_34.z)

				local var_44_35 = var_44_29.localEulerAngles

				var_44_35.z = 0
				var_44_35.x = 0
				var_44_29.localEulerAngles = var_44_35
			end

			if arg_41_1.time_ >= var_44_30 + var_44_31 and arg_41_1.time_ < var_44_30 + var_44_31 + arg_44_0 then
				var_44_29.localPosition = Vector3.New(0, 100, 0)

				local var_44_36 = manager.ui.mainCamera.transform.position - var_44_29.position

				var_44_29.forward = Vector3.New(var_44_36.x, var_44_36.y, var_44_36.z)

				local var_44_37 = var_44_29.localEulerAngles

				var_44_37.z = 0
				var_44_37.x = 0
				var_44_29.localEulerAngles = var_44_37
			end

			local var_44_38 = arg_41_1.actors_["1084ui_story"]
			local var_44_39 = 1.96599999815226

			if var_44_39 < arg_41_1.time_ and arg_41_1.time_ <= var_44_39 + arg_44_0 and not isNil(var_44_38) and arg_41_1.var_.characterEffect1084ui_story == nil then
				arg_41_1.var_.characterEffect1084ui_story = var_44_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_40 = 0.034000001847744

			if var_44_39 <= arg_41_1.time_ and arg_41_1.time_ < var_44_39 + var_44_40 and not isNil(var_44_38) then
				local var_44_41 = (arg_41_1.time_ - var_44_39) / var_44_40

				if arg_41_1.var_.characterEffect1084ui_story and not isNil(var_44_38) then
					local var_44_42 = Mathf.Lerp(0, 0.5, var_44_41)

					arg_41_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1084ui_story.fillRatio = var_44_42
				end
			end

			if arg_41_1.time_ >= var_44_39 + var_44_40 and arg_41_1.time_ < var_44_39 + var_44_40 + arg_44_0 and not isNil(var_44_38) and arg_41_1.var_.characterEffect1084ui_story then
				local var_44_43 = 0.5

				arg_41_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1084ui_story.fillRatio = var_44_43
			end

			local var_44_44 = arg_41_1.actors_["10066ui_story"].transform
			local var_44_45 = 1.96599999815226

			if var_44_45 < arg_41_1.time_ and arg_41_1.time_ <= var_44_45 + arg_44_0 then
				arg_41_1.var_.moveOldPos10066ui_story = var_44_44.localPosition
			end

			local var_44_46 = 0.001

			if var_44_45 <= arg_41_1.time_ and arg_41_1.time_ < var_44_45 + var_44_46 then
				local var_44_47 = (arg_41_1.time_ - var_44_45) / var_44_46
				local var_44_48 = Vector3.New(0, 100, 0)

				var_44_44.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10066ui_story, var_44_48, var_44_47)

				local var_44_49 = manager.ui.mainCamera.transform.position - var_44_44.position

				var_44_44.forward = Vector3.New(var_44_49.x, var_44_49.y, var_44_49.z)

				local var_44_50 = var_44_44.localEulerAngles

				var_44_50.z = 0
				var_44_50.x = 0
				var_44_44.localEulerAngles = var_44_50
			end

			if arg_41_1.time_ >= var_44_45 + var_44_46 and arg_41_1.time_ < var_44_45 + var_44_46 + arg_44_0 then
				var_44_44.localPosition = Vector3.New(0, 100, 0)

				local var_44_51 = manager.ui.mainCamera.transform.position - var_44_44.position

				var_44_44.forward = Vector3.New(var_44_51.x, var_44_51.y, var_44_51.z)

				local var_44_52 = var_44_44.localEulerAngles

				var_44_52.z = 0
				var_44_52.x = 0
				var_44_44.localEulerAngles = var_44_52
			end

			local var_44_53 = arg_41_1.actors_["10066ui_story"]
			local var_44_54 = 1.96599999815226

			if var_44_54 < arg_41_1.time_ and arg_41_1.time_ <= var_44_54 + arg_44_0 and not isNil(var_44_53) and arg_41_1.var_.characterEffect10066ui_story == nil then
				arg_41_1.var_.characterEffect10066ui_story = var_44_53:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_55 = 0.034000001847744

			if var_44_54 <= arg_41_1.time_ and arg_41_1.time_ < var_44_54 + var_44_55 and not isNil(var_44_53) then
				local var_44_56 = (arg_41_1.time_ - var_44_54) / var_44_55

				if arg_41_1.var_.characterEffect10066ui_story and not isNil(var_44_53) then
					local var_44_57 = Mathf.Lerp(0, 0.5, var_44_56)

					arg_41_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10066ui_story.fillRatio = var_44_57
				end
			end

			if arg_41_1.time_ >= var_44_54 + var_44_55 and arg_41_1.time_ < var_44_54 + var_44_55 + arg_44_0 and not isNil(var_44_53) and arg_41_1.var_.characterEffect10066ui_story then
				local var_44_58 = 0.5

				arg_41_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10066ui_story.fillRatio = var_44_58
			end

			local var_44_59 = arg_41_1.bgs_.ML0210.transform
			local var_44_60 = 2

			if var_44_60 < arg_41_1.time_ and arg_41_1.time_ <= var_44_60 + arg_44_0 then
				arg_41_1.var_.moveOldPosML0210 = var_44_59.localPosition
			end

			local var_44_61 = 0.001

			if var_44_60 <= arg_41_1.time_ and arg_41_1.time_ < var_44_60 + var_44_61 then
				local var_44_62 = (arg_41_1.time_ - var_44_60) / var_44_61
				local var_44_63 = Vector3.New(0, 0, 4)

				var_44_59.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPosML0210, var_44_63, var_44_62)
			end

			if arg_41_1.time_ >= var_44_60 + var_44_61 and arg_41_1.time_ < var_44_60 + var_44_61 + arg_44_0 then
				var_44_59.localPosition = Vector3.New(0, 0, 4)
			end

			local var_44_64 = arg_41_1.bgs_.ML0210.transform
			local var_44_65 = 2.01666666666667

			if var_44_65 < arg_41_1.time_ and arg_41_1.time_ <= var_44_65 + arg_44_0 then
				arg_41_1.var_.moveOldPosML0210 = var_44_64.localPosition
			end

			local var_44_66 = 5.48333333333333

			if var_44_65 <= arg_41_1.time_ and arg_41_1.time_ < var_44_65 + var_44_66 then
				local var_44_67 = (arg_41_1.time_ - var_44_65) / var_44_66
				local var_44_68 = Vector3.New(0, 0, 4.5)

				var_44_64.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPosML0210, var_44_68, var_44_67)
			end

			if arg_41_1.time_ >= var_44_65 + var_44_66 and arg_41_1.time_ < var_44_65 + var_44_66 + arg_44_0 then
				var_44_64.localPosition = Vector3.New(0, 0, 4.5)
			end

			local var_44_69 = 4

			if var_44_69 < arg_41_1.time_ and arg_41_1.time_ <= var_44_69 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			local var_44_70 = 3.51666666666667

			if arg_41_1.time_ >= var_44_69 + var_44_70 and arg_41_1.time_ < var_44_69 + var_44_70 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_71 = 3.93333333333333
			local var_44_72 = 0.5

			if var_44_71 < arg_41_1.time_ and arg_41_1.time_ <= var_44_71 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_73 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_73:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_73:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_73:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_74 = arg_41_1:FormatText(StoryNameCfg[7].name)

				arg_41_1.leftNameTxt_.text = var_44_74

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_75 = arg_41_1:GetWordFromCfg(319971010)
				local var_44_76 = arg_41_1:FormatText(var_44_75.content)

				arg_41_1.text_.text = var_44_76

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_77 = 20
				local var_44_78 = utf8.len(var_44_76)
				local var_44_79 = var_44_77 <= 0 and var_44_72 or var_44_72 * (var_44_78 / var_44_77)

				if var_44_79 > 0 and var_44_72 < var_44_79 then
					arg_41_1.talkMaxDuration = var_44_79
					var_44_71 = var_44_71 + 0.3

					if var_44_79 + var_44_71 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_79 + var_44_71
					end
				end

				arg_41_1.text_.text = var_44_76
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_80 = var_44_71 + 0.3
			local var_44_81 = math.max(var_44_72, arg_41_1.talkMaxDuration)

			if var_44_80 <= arg_41_1.time_ and arg_41_1.time_ < var_44_80 + var_44_81 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_80) / var_44_81

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_80 + var_44_81 and arg_41_1.time_ < var_44_80 + var_44_81 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ML0210",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0210",
				changeDisplayLayer = false,
				needEase = false,
				duration = 5.48333333333333,
				className = "StoryMoveNode",
				startTime = 2.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play319971011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319971011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play319971012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0
			local var_50_1 = 0.3

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				local var_50_2 = arg_47_1:FormatText(StoryNameCfg[7].name)

				arg_47_1.leftNameTxt_.text = var_50_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_3 = arg_47_1:GetWordFromCfg(319971011)
				local var_50_4 = arg_47_1:FormatText(var_50_3.content)

				arg_47_1.text_.text = var_50_4

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 12
				local var_50_6 = utf8.len(var_50_4)
				local var_50_7 = var_50_5 <= 0 and var_50_1 or var_50_1 * (var_50_6 / var_50_5)

				if var_50_7 > 0 and var_50_1 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_0
					end
				end

				arg_47_1.text_.text = var_50_4
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_8 = math.max(var_50_1, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_8 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_0) / var_50_8

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_8 and arg_47_1.time_ < var_50_0 + var_50_8 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play319971012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319971012
		arg_51_1.duration_ = 4.9

		local var_51_0 = {
			zh = 1.966,
			ja = 4.9
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
				arg_51_0:Play319971013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0
			local var_54_1 = 0.175

			if var_54_0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_2 = arg_51_1:FormatText(StoryNameCfg[6].name)

				arg_51_1.leftNameTxt_.text = var_54_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_3 = arg_51_1:GetWordFromCfg(319971012)
				local var_54_4 = arg_51_1:FormatText(var_54_3.content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971012", "story_v_out_319971.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971012", "story_v_out_319971.awb") / 1000

					if var_54_8 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_0
					end

					if var_54_3.prefab_name ~= "" and arg_51_1.actors_[var_54_3.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_3.prefab_name].transform, "story_v_out_319971", "319971012", "story_v_out_319971.awb")

						arg_51_1:RecordAudio("319971012", var_54_9)
						arg_51_1:RecordAudio("319971012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_319971", "319971012", "story_v_out_319971.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_319971", "319971012", "story_v_out_319971.awb")
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
	Play319971013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319971013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play319971014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["1084ui_story"].transform
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.var_.moveOldPos1084ui_story = var_58_0.localPosition
			end

			local var_58_2 = 0.001

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2
				local var_58_4 = Vector3.New(0, 100, 0)

				var_58_0.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1084ui_story, var_58_4, var_58_3)

				local var_58_5 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_5.x, var_58_5.y, var_58_5.z)

				local var_58_6 = var_58_0.localEulerAngles

				var_58_6.z = 0
				var_58_6.x = 0
				var_58_0.localEulerAngles = var_58_6
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 then
				var_58_0.localPosition = Vector3.New(0, 100, 0)

				local var_58_7 = manager.ui.mainCamera.transform.position - var_58_0.position

				var_58_0.forward = Vector3.New(var_58_7.x, var_58_7.y, var_58_7.z)

				local var_58_8 = var_58_0.localEulerAngles

				var_58_8.z = 0
				var_58_8.x = 0
				var_58_0.localEulerAngles = var_58_8
			end

			local var_58_9 = 0
			local var_58_10 = 1

			if var_58_9 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_11 = arg_55_1:GetWordFromCfg(319971013)
				local var_58_12 = arg_55_1:FormatText(var_58_11.content)

				arg_55_1.text_.text = var_58_12

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_13 = 40
				local var_58_14 = utf8.len(var_58_12)
				local var_58_15 = var_58_13 <= 0 and var_58_10 or var_58_10 * (var_58_14 / var_58_13)

				if var_58_15 > 0 and var_58_10 < var_58_15 then
					arg_55_1.talkMaxDuration = var_58_15

					if var_58_15 + var_58_9 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_15 + var_58_9
					end
				end

				arg_55_1.text_.text = var_58_12
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_16 = math.max(var_58_10, arg_55_1.talkMaxDuration)

			if var_58_9 <= arg_55_1.time_ and arg_55_1.time_ < var_58_9 + var_58_16 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_9) / var_58_16

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_9 + var_58_16 and arg_55_1.time_ < var_58_9 + var_58_16 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
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

		arg_55_1:InitPlayNodeList()
	end,
	Play319971014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319971014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play319971015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 1.1

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_2 = arg_59_1:GetWordFromCfg(319971014)
				local var_62_3 = arg_59_1:FormatText(var_62_2.content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 44
				local var_62_5 = utf8.len(var_62_3)
				local var_62_6 = var_62_4 <= 0 and var_62_1 or var_62_1 * (var_62_5 / var_62_4)

				if var_62_6 > 0 and var_62_1 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_7 and arg_59_1.time_ < var_62_0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play319971015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319971015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play319971016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 0.3

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[7].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_3 = arg_63_1:GetWordFromCfg(319971015)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 12
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_8 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_8 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_8

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_8 and arg_63_1.time_ < var_66_0 + var_66_8 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play319971016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319971016
		arg_67_1.duration_ = 0.5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"

			SetActive(arg_67_1.choicesGo_, true)

			for iter_68_0, iter_68_1 in ipairs(arg_67_1.choices_) do
				local var_68_0 = iter_68_0 <= 3

				SetActive(iter_68_1.go, var_68_0)
			end

			arg_67_1.choices_[1].txt.text = arg_67_1:FormatText(StoryChoiceCfg[807].name)
			arg_67_1.choices_[2].txt.text = arg_67_1:FormatText(StoryChoiceCfg[808].name)
			arg_67_1.choices_[3].txt.text = arg_67_1:FormatText(StoryChoiceCfg[809].name)
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play319971017(arg_67_1)
			end

			if arg_69_0 == 2 then
				arg_67_0:Play319971017(arg_67_1)
			end

			if arg_69_0 == 3 then
				arg_67_0:Play319971017(arg_67_1)
			end

			arg_67_1:RecordChoiceLog(319971016, 807, 808, 809)
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.allBtn_.enabled = false
			end

			local var_70_1 = 0.5

			if arg_67_1.time_ >= var_70_0 + var_70_1 and arg_67_1.time_ < var_70_0 + var_70_1 + arg_70_0 then
				arg_67_1.allBtn_.enabled = true
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play319971017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319971017
		arg_71_1.duration_ = 6.13

		local var_71_0 = {
			zh = 4.633,
			ja = 6.133
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
				arg_71_0:Play319971018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = 0
			local var_74_1 = 0.625

			if var_74_0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_0 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_2 = arg_71_1:FormatText(StoryNameCfg[6].name)

				arg_71_1.leftNameTxt_.text = var_74_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_3 = arg_71_1:GetWordFromCfg(319971017)
				local var_74_4 = arg_71_1:FormatText(var_74_3.content)

				arg_71_1.text_.text = var_74_4

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 25
				local var_74_6 = utf8.len(var_74_4)
				local var_74_7 = var_74_5 <= 0 and var_74_1 or var_74_1 * (var_74_6 / var_74_5)

				if var_74_7 > 0 and var_74_1 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_0
					end
				end

				arg_71_1.text_.text = var_74_4
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971017", "story_v_out_319971.awb") ~= 0 then
					local var_74_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971017", "story_v_out_319971.awb") / 1000

					if var_74_8 + var_74_0 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_8 + var_74_0
					end

					if var_74_3.prefab_name ~= "" and arg_71_1.actors_[var_74_3.prefab_name] ~= nil then
						local var_74_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_3.prefab_name].transform, "story_v_out_319971", "319971017", "story_v_out_319971.awb")

						arg_71_1:RecordAudio("319971017", var_74_9)
						arg_71_1:RecordAudio("319971017", var_74_9)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_319971", "319971017", "story_v_out_319971.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_319971", "319971017", "story_v_out_319971.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_10 = math.max(var_74_1, arg_71_1.talkMaxDuration)

			if var_74_0 <= arg_71_1.time_ and arg_71_1.time_ < var_74_0 + var_74_10 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_0) / var_74_10

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_0 + var_74_10 and arg_71_1.time_ < var_74_0 + var_74_10 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play319971018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 319971018
		arg_75_1.duration_ = 7.97

		local var_75_0 = {
			zh = 6.833,
			ja = 7.966
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
				arg_75_0:Play319971019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.625

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[6].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(319971018)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 25
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971018", "story_v_out_319971.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971018", "story_v_out_319971.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_319971", "319971018", "story_v_out_319971.awb")

						arg_75_1:RecordAudio("319971018", var_78_9)
						arg_75_1:RecordAudio("319971018", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_319971", "319971018", "story_v_out_319971.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_319971", "319971018", "story_v_out_319971.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_10 and arg_75_1.time_ < var_78_0 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play319971019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319971019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play319971020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = 0
			local var_82_1 = 0.55

			if var_82_0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_2 = arg_79_1:FormatText(StoryNameCfg[7].name)

				arg_79_1.leftNameTxt_.text = var_82_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_3 = arg_79_1:GetWordFromCfg(319971019)
				local var_82_4 = arg_79_1:FormatText(var_82_3.content)

				arg_79_1.text_.text = var_82_4

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 22
				local var_82_6 = utf8.len(var_82_4)
				local var_82_7 = var_82_5 <= 0 and var_82_1 or var_82_1 * (var_82_6 / var_82_5)

				if var_82_7 > 0 and var_82_1 < var_82_7 then
					arg_79_1.talkMaxDuration = var_82_7

					if var_82_7 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_7 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_4
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_8 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_8 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_8

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_8 and arg_79_1.time_ < var_82_0 + var_82_8 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play319971020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 319971020
		arg_83_1.duration_ = 4.73

		local var_83_0 = {
			zh = 2.166,
			ja = 4.733
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
				arg_83_0:Play319971021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.3

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_2 = arg_83_1:FormatText(StoryNameCfg[6].name)

				arg_83_1.leftNameTxt_.text = var_86_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:GetWordFromCfg(319971020)
				local var_86_4 = arg_83_1:FormatText(var_86_3.content)

				arg_83_1.text_.text = var_86_4

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 12
				local var_86_6 = utf8.len(var_86_4)
				local var_86_7 = var_86_5 <= 0 and var_86_1 or var_86_1 * (var_86_6 / var_86_5)

				if var_86_7 > 0 and var_86_1 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_4
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971020", "story_v_out_319971.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971020", "story_v_out_319971.awb") / 1000

					if var_86_8 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_0
					end

					if var_86_3.prefab_name ~= "" and arg_83_1.actors_[var_86_3.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_3.prefab_name].transform, "story_v_out_319971", "319971020", "story_v_out_319971.awb")

						arg_83_1:RecordAudio("319971020", var_86_9)
						arg_83_1:RecordAudio("319971020", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_319971", "319971020", "story_v_out_319971.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_319971", "319971020", "story_v_out_319971.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_10 and arg_83_1.time_ < var_86_0 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play319971021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 319971021
		arg_87_1.duration_ = 9.37

		local var_87_0 = {
			zh = 7.2,
			ja = 9.366
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
				arg_87_0:Play319971022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 1.025

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[6].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:GetWordFromCfg(319971021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 41
				local var_90_6 = utf8.len(var_90_4)
				local var_90_7 = var_90_5 <= 0 and var_90_1 or var_90_1 * (var_90_6 / var_90_5)

				if var_90_7 > 0 and var_90_1 < var_90_7 then
					arg_87_1.talkMaxDuration = var_90_7

					if var_90_7 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_7 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_4
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971021", "story_v_out_319971.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971021", "story_v_out_319971.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_319971", "319971021", "story_v_out_319971.awb")

						arg_87_1:RecordAudio("319971021", var_90_9)
						arg_87_1:RecordAudio("319971021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_319971", "319971021", "story_v_out_319971.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_319971", "319971021", "story_v_out_319971.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_10 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_10 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_10

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_10 and arg_87_1.time_ < var_90_0 + var_90_10 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play319971022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 319971022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play319971023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.5

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[7].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, true)
				arg_91_1.iconController_:SetSelectedState("hero")

				arg_91_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_91_1.callingController_:SetSelectedState("normal")

				arg_91_1.keyicon_.color = Color.New(1, 1, 1)
				arg_91_1.icon_.color = Color.New(1, 1, 1)

				local var_94_3 = arg_91_1:GetWordFromCfg(319971022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 20
				local var_94_6 = utf8.len(var_94_4)
				local var_94_7 = var_94_5 <= 0 and var_94_1 or var_94_1 * (var_94_6 / var_94_5)

				if var_94_7 > 0 and var_94_1 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_4
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_8 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_8 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_8

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_8 and arg_91_1.time_ < var_94_0 + var_94_8 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play319971023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 319971023
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play319971024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0
			local var_98_1 = 0.825

			if var_98_0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_2 = arg_95_1:FormatText(StoryNameCfg[7].name)

				arg_95_1.leftNameTxt_.text = var_98_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_3 = arg_95_1:GetWordFromCfg(319971023)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 33
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
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_8 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_8 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_8

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_8 and arg_95_1.time_ < var_98_0 + var_98_8 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play319971024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 319971024
		arg_99_1.duration_ = 3.83

		local var_99_0 = {
			zh = 3.566,
			ja = 3.833
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play319971025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.4

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[6].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_3 = arg_99_1:GetWordFromCfg(319971024)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 16
				local var_102_6 = utf8.len(var_102_4)
				local var_102_7 = var_102_5 <= 0 and var_102_1 or var_102_1 * (var_102_6 / var_102_5)

				if var_102_7 > 0 and var_102_1 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_0
					end
				end

				arg_99_1.text_.text = var_102_4
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971024", "story_v_out_319971.awb") ~= 0 then
					local var_102_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971024", "story_v_out_319971.awb") / 1000

					if var_102_8 + var_102_0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_8 + var_102_0
					end

					if var_102_3.prefab_name ~= "" and arg_99_1.actors_[var_102_3.prefab_name] ~= nil then
						local var_102_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_3.prefab_name].transform, "story_v_out_319971", "319971024", "story_v_out_319971.awb")

						arg_99_1:RecordAudio("319971024", var_102_9)
						arg_99_1:RecordAudio("319971024", var_102_9)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_319971", "319971024", "story_v_out_319971.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_319971", "319971024", "story_v_out_319971.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_10 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_10 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_10

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_10 and arg_99_1.time_ < var_102_0 + var_102_10 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play319971025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 319971025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play319971026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 0.275

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[7].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, true)
				arg_103_1.iconController_:SetSelectedState("hero")

				arg_103_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_103_1.callingController_:SetSelectedState("normal")

				arg_103_1.keyicon_.color = Color.New(1, 1, 1)
				arg_103_1.icon_.color = Color.New(1, 1, 1)

				local var_106_3 = arg_103_1:GetWordFromCfg(319971025)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 11
				local var_106_6 = utf8.len(var_106_4)
				local var_106_7 = var_106_5 <= 0 and var_106_1 or var_106_1 * (var_106_6 / var_106_5)

				if var_106_7 > 0 and var_106_1 < var_106_7 then
					arg_103_1.talkMaxDuration = var_106_7

					if var_106_7 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_7 + var_106_0
					end
				end

				arg_103_1.text_.text = var_106_4
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_8 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_8 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_8

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_8 and arg_103_1.time_ < var_106_0 + var_106_8 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play319971026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319971026
		arg_107_1.duration_ = 8.4

		local var_107_0 = {
			zh = 6.633,
			ja = 8.4
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
				arg_107_0:Play319971027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.mask_.enabled = true
				arg_107_1.mask_.raycastTarget = true

				arg_107_1:SetGaussion(false)
			end

			local var_110_1 = 1

			if var_110_0 <= arg_107_1.time_ and arg_107_1.time_ < var_110_0 + var_110_1 then
				local var_110_2 = (arg_107_1.time_ - var_110_0) / var_110_1
				local var_110_3 = Color.New(0, 0, 0)

				var_110_3.a = Mathf.Lerp(0, 1, var_110_2)
				arg_107_1.mask_.color = var_110_3
			end

			if arg_107_1.time_ >= var_110_0 + var_110_1 and arg_107_1.time_ < var_110_0 + var_110_1 + arg_110_0 then
				local var_110_4 = Color.New(0, 0, 0)

				var_110_4.a = 1
				arg_107_1.mask_.color = var_110_4
			end

			local var_110_5 = 1

			if var_110_5 < arg_107_1.time_ and arg_107_1.time_ <= var_110_5 + arg_110_0 then
				arg_107_1.mask_.enabled = true
				arg_107_1.mask_.raycastTarget = true

				arg_107_1:SetGaussion(false)
			end

			local var_110_6 = 1

			if var_110_5 <= arg_107_1.time_ and arg_107_1.time_ < var_110_5 + var_110_6 then
				local var_110_7 = (arg_107_1.time_ - var_110_5) / var_110_6
				local var_110_8 = Color.New(0, 0, 0)

				var_110_8.a = Mathf.Lerp(1, 0, var_110_7)
				arg_107_1.mask_.color = var_110_8
			end

			if arg_107_1.time_ >= var_110_5 + var_110_6 and arg_107_1.time_ < var_110_5 + var_110_6 + arg_110_0 then
				local var_110_9 = Color.New(0, 0, 0)
				local var_110_10 = 0

				arg_107_1.mask_.enabled = false
				var_110_9.a = var_110_10
				arg_107_1.mask_.color = var_110_9
			end

			local var_110_11 = arg_107_1.bgs_.ML0210.transform
			local var_110_12 = 1

			if var_110_12 < arg_107_1.time_ and arg_107_1.time_ <= var_110_12 + arg_110_0 then
				arg_107_1.var_.moveOldPosML0210 = var_110_11.localPosition
			end

			local var_110_13 = 0.001

			if var_110_12 <= arg_107_1.time_ and arg_107_1.time_ < var_110_12 + var_110_13 then
				local var_110_14 = (arg_107_1.time_ - var_110_12) / var_110_13
				local var_110_15 = Vector3.New(0, 1, 9.5)

				var_110_11.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPosML0210, var_110_15, var_110_14)
			end

			if arg_107_1.time_ >= var_110_12 + var_110_13 and arg_107_1.time_ < var_110_12 + var_110_13 + arg_110_0 then
				var_110_11.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_110_16 = arg_107_1.bgs_.ML0210.transform
			local var_110_17 = 1.01666666666667

			if var_110_17 < arg_107_1.time_ and arg_107_1.time_ <= var_110_17 + arg_110_0 then
				arg_107_1.var_.moveOldPosML0210 = var_110_16.localPosition
			end

			local var_110_18 = 3.5

			if var_110_17 <= arg_107_1.time_ and arg_107_1.time_ < var_110_17 + var_110_18 then
				local var_110_19 = (arg_107_1.time_ - var_110_17) / var_110_18
				local var_110_20 = Vector3.New(0, 1, 10)

				var_110_16.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPosML0210, var_110_20, var_110_19)
			end

			if arg_107_1.time_ >= var_110_17 + var_110_18 and arg_107_1.time_ < var_110_17 + var_110_18 + arg_110_0 then
				var_110_16.localPosition = Vector3.New(0, 1, 10)
			end

			local var_110_21 = 2

			if var_110_21 < arg_107_1.time_ and arg_107_1.time_ <= var_110_21 + arg_110_0 then
				arg_107_1.allBtn_.enabled = false
			end

			local var_110_22 = 2.5

			if arg_107_1.time_ >= var_110_21 + var_110_22 and arg_107_1.time_ < var_110_21 + var_110_22 + arg_110_0 then
				arg_107_1.allBtn_.enabled = true
			end

			if arg_107_1.frameCnt_ <= 1 then
				arg_107_1.dialog_:SetActive(false)
			end

			local var_110_23 = 2
			local var_110_24 = 0.5

			if var_110_23 < arg_107_1.time_ and arg_107_1.time_ <= var_110_23 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0

				arg_107_1.dialog_:SetActive(true)

				arg_107_1.dialogCg_.alpha = 0

				local var_110_25 = LeanTween.value(arg_107_1.dialog_, 0, 1, 0.3)

				var_110_25:setOnUpdate(LuaHelper.FloatAction(function(arg_111_0)
					arg_107_1.dialogCg_.alpha = arg_111_0
				end))
				var_110_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_107_1.dialog_)
					var_110_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_107_1.duration_ = arg_107_1.duration_ + 0.3

				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_26 = arg_107_1:FormatText(StoryNameCfg[6].name)

				arg_107_1.leftNameTxt_.text = var_110_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_27 = arg_107_1:GetWordFromCfg(319971026)
				local var_110_28 = arg_107_1:FormatText(var_110_27.content)

				arg_107_1.text_.text = var_110_28

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_29 = 20
				local var_110_30 = utf8.len(var_110_28)
				local var_110_31 = var_110_29 <= 0 and var_110_24 or var_110_24 * (var_110_30 / var_110_29)

				if var_110_31 > 0 and var_110_24 < var_110_31 then
					arg_107_1.talkMaxDuration = var_110_31
					var_110_23 = var_110_23 + 0.3

					if var_110_31 + var_110_23 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_31 + var_110_23
					end
				end

				arg_107_1.text_.text = var_110_28
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971026", "story_v_out_319971.awb") ~= 0 then
					local var_110_32 = manager.audio:GetVoiceLength("story_v_out_319971", "319971026", "story_v_out_319971.awb") / 1000

					if var_110_32 + var_110_23 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_32 + var_110_23
					end

					if var_110_27.prefab_name ~= "" and arg_107_1.actors_[var_110_27.prefab_name] ~= nil then
						local var_110_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_27.prefab_name].transform, "story_v_out_319971", "319971026", "story_v_out_319971.awb")

						arg_107_1:RecordAudio("319971026", var_110_33)
						arg_107_1:RecordAudio("319971026", var_110_33)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_319971", "319971026", "story_v_out_319971.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_319971", "319971026", "story_v_out_319971.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_34 = var_110_23 + 0.3
			local var_110_35 = math.max(var_110_24, arg_107_1.talkMaxDuration)

			if var_110_34 <= arg_107_1.time_ and arg_107_1.time_ < var_110_34 + var_110_35 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_34) / var_110_35

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_34 + var_110_35 and arg_107_1.time_ < var_110_34 + var_110_35 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0210",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0210",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3.5,
				className = "StoryMoveNode",
				startTime = 1.01666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play319971027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319971027
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play319971028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 0.375

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_2 = arg_113_1:FormatText(StoryNameCfg[7].name)

				arg_113_1.leftNameTxt_.text = var_116_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, true)
				arg_113_1.iconController_:SetSelectedState("hero")

				arg_113_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_113_1.callingController_:SetSelectedState("normal")

				arg_113_1.keyicon_.color = Color.New(1, 1, 1)
				arg_113_1.icon_.color = Color.New(1, 1, 1)

				local var_116_3 = arg_113_1:GetWordFromCfg(319971027)
				local var_116_4 = arg_113_1:FormatText(var_116_3.content)

				arg_113_1.text_.text = var_116_4

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_5 = 15
				local var_116_6 = utf8.len(var_116_4)
				local var_116_7 = var_116_5 <= 0 and var_116_1 or var_116_1 * (var_116_6 / var_116_5)

				if var_116_7 > 0 and var_116_1 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_4
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_8 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_8 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_8

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_8 and arg_113_1.time_ < var_116_0 + var_116_8 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play319971028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319971028
		arg_117_1.duration_ = 7.87

		local var_117_0 = {
			zh = 4.566,
			ja = 7.866
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play319971029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 0.475

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_2 = arg_117_1:FormatText(StoryNameCfg[6].name)

				arg_117_1.leftNameTxt_.text = var_120_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:GetWordFromCfg(319971028)
				local var_120_4 = arg_117_1:FormatText(var_120_3.content)

				arg_117_1.text_.text = var_120_4

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 19
				local var_120_6 = utf8.len(var_120_4)
				local var_120_7 = var_120_5 <= 0 and var_120_1 or var_120_1 * (var_120_6 / var_120_5)

				if var_120_7 > 0 and var_120_1 < var_120_7 then
					arg_117_1.talkMaxDuration = var_120_7

					if var_120_7 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_7 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_4
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971028", "story_v_out_319971.awb") ~= 0 then
					local var_120_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971028", "story_v_out_319971.awb") / 1000

					if var_120_8 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_8 + var_120_0
					end

					if var_120_3.prefab_name ~= "" and arg_117_1.actors_[var_120_3.prefab_name] ~= nil then
						local var_120_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_3.prefab_name].transform, "story_v_out_319971", "319971028", "story_v_out_319971.awb")

						arg_117_1:RecordAudio("319971028", var_120_9)
						arg_117_1:RecordAudio("319971028", var_120_9)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319971", "319971028", "story_v_out_319971.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319971", "319971028", "story_v_out_319971.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_10 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_10 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_10

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_10 and arg_117_1.time_ < var_120_0 + var_120_10 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play319971029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319971029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play319971030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.525

			if var_124_0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_0 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_2 = arg_121_1:FormatText(StoryNameCfg[7].name)

				arg_121_1.leftNameTxt_.text = var_124_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, true)
				arg_121_1.iconController_:SetSelectedState("hero")

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:GetWordFromCfg(319971029)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 21
				local var_124_6 = utf8.len(var_124_4)
				local var_124_7 = var_124_5 <= 0 and var_124_1 or var_124_1 * (var_124_6 / var_124_5)

				if var_124_7 > 0 and var_124_1 < var_124_7 then
					arg_121_1.talkMaxDuration = var_124_7

					if var_124_7 + var_124_0 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_0
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_8 = math.max(var_124_1, arg_121_1.talkMaxDuration)

			if var_124_0 <= arg_121_1.time_ and arg_121_1.time_ < var_124_0 + var_124_8 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_0) / var_124_8

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_0 + var_124_8 and arg_121_1.time_ < var_124_0 + var_124_8 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play319971030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319971030
		arg_125_1.duration_ = 7.43

		local var_125_0 = {
			zh = 7.433,
			ja = 5.5
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play319971031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = 0
			local var_128_1 = 1

			if var_128_0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_0 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_2 = arg_125_1:FormatText(StoryNameCfg[6].name)

				arg_125_1.leftNameTxt_.text = var_128_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:GetWordFromCfg(319971030)
				local var_128_4 = arg_125_1:FormatText(var_128_3.content)

				arg_125_1.text_.text = var_128_4

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 40
				local var_128_6 = utf8.len(var_128_4)
				local var_128_7 = var_128_5 <= 0 and var_128_1 or var_128_1 * (var_128_6 / var_128_5)

				if var_128_7 > 0 and var_128_1 < var_128_7 then
					arg_125_1.talkMaxDuration = var_128_7

					if var_128_7 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_7 + var_128_0
					end
				end

				arg_125_1.text_.text = var_128_4
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971030", "story_v_out_319971.awb") ~= 0 then
					local var_128_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971030", "story_v_out_319971.awb") / 1000

					if var_128_8 + var_128_0 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_8 + var_128_0
					end

					if var_128_3.prefab_name ~= "" and arg_125_1.actors_[var_128_3.prefab_name] ~= nil then
						local var_128_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_3.prefab_name].transform, "story_v_out_319971", "319971030", "story_v_out_319971.awb")

						arg_125_1:RecordAudio("319971030", var_128_9)
						arg_125_1:RecordAudio("319971030", var_128_9)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_319971", "319971030", "story_v_out_319971.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_319971", "319971030", "story_v_out_319971.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_10 = math.max(var_128_1, arg_125_1.talkMaxDuration)

			if var_128_0 <= arg_125_1.time_ and arg_125_1.time_ < var_128_0 + var_128_10 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_0) / var_128_10

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_0 + var_128_10 and arg_125_1.time_ < var_128_0 + var_128_10 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play319971031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319971031
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play319971032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.5

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_2 = arg_129_1:FormatText(StoryNameCfg[7].name)

				arg_129_1.leftNameTxt_.text = var_132_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, true)
				arg_129_1.iconController_:SetSelectedState("hero")

				arg_129_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_129_1.callingController_:SetSelectedState("normal")

				arg_129_1.keyicon_.color = Color.New(1, 1, 1)
				arg_129_1.icon_.color = Color.New(1, 1, 1)

				local var_132_3 = arg_129_1:GetWordFromCfg(319971031)
				local var_132_4 = arg_129_1:FormatText(var_132_3.content)

				arg_129_1.text_.text = var_132_4

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_5 = 20
				local var_132_6 = utf8.len(var_132_4)
				local var_132_7 = var_132_5 <= 0 and var_132_1 or var_132_1 * (var_132_6 / var_132_5)

				if var_132_7 > 0 and var_132_1 < var_132_7 then
					arg_129_1.talkMaxDuration = var_132_7

					if var_132_7 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_7 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_4
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_8 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_8 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_8

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_8 and arg_129_1.time_ < var_132_0 + var_132_8 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play319971032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319971032
		arg_133_1.duration_ = 5.03

		local var_133_0 = {
			zh = 2.133,
			ja = 5.033
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play319971033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = 0
			local var_136_1 = 0.2

			if var_136_0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_0 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_2 = arg_133_1:FormatText(StoryNameCfg[6].name)

				arg_133_1.leftNameTxt_.text = var_136_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_3 = arg_133_1:GetWordFromCfg(319971032)
				local var_136_4 = arg_133_1:FormatText(var_136_3.content)

				arg_133_1.text_.text = var_136_4

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_5 = 8
				local var_136_6 = utf8.len(var_136_4)
				local var_136_7 = var_136_5 <= 0 and var_136_1 or var_136_1 * (var_136_6 / var_136_5)

				if var_136_7 > 0 and var_136_1 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_0
					end
				end

				arg_133_1.text_.text = var_136_4
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971032", "story_v_out_319971.awb") ~= 0 then
					local var_136_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971032", "story_v_out_319971.awb") / 1000

					if var_136_8 + var_136_0 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_8 + var_136_0
					end

					if var_136_3.prefab_name ~= "" and arg_133_1.actors_[var_136_3.prefab_name] ~= nil then
						local var_136_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_3.prefab_name].transform, "story_v_out_319971", "319971032", "story_v_out_319971.awb")

						arg_133_1:RecordAudio("319971032", var_136_9)
						arg_133_1:RecordAudio("319971032", var_136_9)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_319971", "319971032", "story_v_out_319971.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_319971", "319971032", "story_v_out_319971.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_10 = math.max(var_136_1, arg_133_1.talkMaxDuration)

			if var_136_0 <= arg_133_1.time_ and arg_133_1.time_ < var_136_0 + var_136_10 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_0) / var_136_10

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_0 + var_136_10 and arg_133_1.time_ < var_136_0 + var_136_10 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play319971033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 319971033
		arg_137_1.duration_ = 5.9

		local var_137_0 = {
			zh = 2.766,
			ja = 5.9
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play319971034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = 0
			local var_140_1 = 0.3

			if var_140_0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_0 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_2 = arg_137_1:FormatText(StoryNameCfg[6].name)

				arg_137_1.leftNameTxt_.text = var_140_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_3 = arg_137_1:GetWordFromCfg(319971033)
				local var_140_4 = arg_137_1:FormatText(var_140_3.content)

				arg_137_1.text_.text = var_140_4

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_5 = 12
				local var_140_6 = utf8.len(var_140_4)
				local var_140_7 = var_140_5 <= 0 and var_140_1 or var_140_1 * (var_140_6 / var_140_5)

				if var_140_7 > 0 and var_140_1 < var_140_7 then
					arg_137_1.talkMaxDuration = var_140_7

					if var_140_7 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_7 + var_140_0
					end
				end

				arg_137_1.text_.text = var_140_4
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971033", "story_v_out_319971.awb") ~= 0 then
					local var_140_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971033", "story_v_out_319971.awb") / 1000

					if var_140_8 + var_140_0 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_0
					end

					if var_140_3.prefab_name ~= "" and arg_137_1.actors_[var_140_3.prefab_name] ~= nil then
						local var_140_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_3.prefab_name].transform, "story_v_out_319971", "319971033", "story_v_out_319971.awb")

						arg_137_1:RecordAudio("319971033", var_140_9)
						arg_137_1:RecordAudio("319971033", var_140_9)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_319971", "319971033", "story_v_out_319971.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_319971", "319971033", "story_v_out_319971.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_10 = math.max(var_140_1, arg_137_1.talkMaxDuration)

			if var_140_0 <= arg_137_1.time_ and arg_137_1.time_ < var_140_0 + var_140_10 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_0) / var_140_10

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_0 + var_140_10 and arg_137_1.time_ < var_140_0 + var_140_10 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play319971034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 319971034
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play319971035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 0.125

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[7].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:GetWordFromCfg(319971034)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 5
				local var_144_6 = utf8.len(var_144_4)
				local var_144_7 = var_144_5 <= 0 and var_144_1 or var_144_1 * (var_144_6 / var_144_5)

				if var_144_7 > 0 and var_144_1 < var_144_7 then
					arg_141_1.talkMaxDuration = var_144_7

					if var_144_7 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_0
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_8 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_8 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_8

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_8 and arg_141_1.time_ < var_144_0 + var_144_8 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play319971035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 319971035
		arg_145_1.duration_ = 6.53

		local var_145_0 = {
			zh = 3.2,
			ja = 6.533
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
				arg_145_0:Play319971036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0
			local var_148_1 = 0.275

			if var_148_0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_2 = arg_145_1:FormatText(StoryNameCfg[6].name)

				arg_145_1.leftNameTxt_.text = var_148_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:GetWordFromCfg(319971035)
				local var_148_4 = arg_145_1:FormatText(var_148_3.content)

				arg_145_1.text_.text = var_148_4

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 11
				local var_148_6 = utf8.len(var_148_4)
				local var_148_7 = var_148_5 <= 0 and var_148_1 or var_148_1 * (var_148_6 / var_148_5)

				if var_148_7 > 0 and var_148_1 < var_148_7 then
					arg_145_1.talkMaxDuration = var_148_7

					if var_148_7 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_7 + var_148_0
					end
				end

				arg_145_1.text_.text = var_148_4
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971035", "story_v_out_319971.awb") ~= 0 then
					local var_148_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971035", "story_v_out_319971.awb") / 1000

					if var_148_8 + var_148_0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_8 + var_148_0
					end

					if var_148_3.prefab_name ~= "" and arg_145_1.actors_[var_148_3.prefab_name] ~= nil then
						local var_148_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_3.prefab_name].transform, "story_v_out_319971", "319971035", "story_v_out_319971.awb")

						arg_145_1:RecordAudio("319971035", var_148_9)
						arg_145_1:RecordAudio("319971035", var_148_9)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_319971", "319971035", "story_v_out_319971.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_319971", "319971035", "story_v_out_319971.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_10 = math.max(var_148_1, arg_145_1.talkMaxDuration)

			if var_148_0 <= arg_145_1.time_ and arg_145_1.time_ < var_148_0 + var_148_10 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_0) / var_148_10

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_0 + var_148_10 and arg_145_1.time_ < var_148_0 + var_148_10 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play319971036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 319971036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play319971037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0
			local var_152_1 = 0.4

			if var_152_0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_2 = arg_149_1:FormatText(StoryNameCfg[7].name)

				arg_149_1.leftNameTxt_.text = var_152_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_3 = arg_149_1:GetWordFromCfg(319971036)
				local var_152_4 = arg_149_1:FormatText(var_152_3.content)

				arg_149_1.text_.text = var_152_4

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_5 = 16
				local var_152_6 = utf8.len(var_152_4)
				local var_152_7 = var_152_5 <= 0 and var_152_1 or var_152_1 * (var_152_6 / var_152_5)

				if var_152_7 > 0 and var_152_1 < var_152_7 then
					arg_149_1.talkMaxDuration = var_152_7

					if var_152_7 + var_152_0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_7 + var_152_0
					end
				end

				arg_149_1.text_.text = var_152_4
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_8 = math.max(var_152_1, arg_149_1.talkMaxDuration)

			if var_152_0 <= arg_149_1.time_ and arg_149_1.time_ < var_152_0 + var_152_8 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_0) / var_152_8

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_0 + var_152_8 and arg_149_1.time_ < var_152_0 + var_152_8 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play319971037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 319971037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play319971038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 1.1

			if var_156_0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_2 = arg_153_1:GetWordFromCfg(319971037)
				local var_156_3 = arg_153_1:FormatText(var_156_2.content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 44
				local var_156_5 = utf8.len(var_156_3)
				local var_156_6 = var_156_4 <= 0 and var_156_1 or var_156_1 * (var_156_5 / var_156_4)

				if var_156_6 > 0 and var_156_1 < var_156_6 then
					arg_153_1.talkMaxDuration = var_156_6

					if var_156_6 + var_156_0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_6 + var_156_0
					end
				end

				arg_153_1.text_.text = var_156_3
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_1, arg_153_1.talkMaxDuration)

			if var_156_0 <= arg_153_1.time_ and arg_153_1.time_ < var_156_0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_0 + var_156_7 and arg_153_1.time_ < var_156_0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play319971038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 319971038
		arg_157_1.duration_ = 1.2

		local var_157_0 = {
			zh = 1.2,
			ja = 1
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
				arg_157_0:Play319971039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.125

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_2 = arg_157_1:FormatText(StoryNameCfg[334].name)

				arg_157_1.leftNameTxt_.text = var_160_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(319971038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 5
				local var_160_6 = utf8.len(var_160_4)
				local var_160_7 = var_160_5 <= 0 and var_160_1 or var_160_1 * (var_160_6 / var_160_5)

				if var_160_7 > 0 and var_160_1 < var_160_7 then
					arg_157_1.talkMaxDuration = var_160_7

					if var_160_7 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971038", "story_v_out_319971.awb") ~= 0 then
					local var_160_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971038", "story_v_out_319971.awb") / 1000

					if var_160_8 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_8 + var_160_0
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_319971", "319971038", "story_v_out_319971.awb")

						arg_157_1:RecordAudio("319971038", var_160_9)
						arg_157_1:RecordAudio("319971038", var_160_9)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_319971", "319971038", "story_v_out_319971.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_319971", "319971038", "story_v_out_319971.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_10 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_10 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_10

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_10 and arg_157_1.time_ < var_160_0 + var_160_10 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play319971039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319971039
		arg_161_1.duration_ = 2.37

		local var_161_0 = {
			zh = 1.433,
			ja = 2.366
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
				arg_161_0:Play319971040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0
			local var_164_1 = 0.125

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_2 = arg_161_1:FormatText(StoryNameCfg[6].name)

				arg_161_1.leftNameTxt_.text = var_164_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_3 = arg_161_1:GetWordFromCfg(319971039)
				local var_164_4 = arg_161_1:FormatText(var_164_3.content)

				arg_161_1.text_.text = var_164_4

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_5 = 5
				local var_164_6 = utf8.len(var_164_4)
				local var_164_7 = var_164_5 <= 0 and var_164_1 or var_164_1 * (var_164_6 / var_164_5)

				if var_164_7 > 0 and var_164_1 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_0
					end
				end

				arg_161_1.text_.text = var_164_4
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971039", "story_v_out_319971.awb") ~= 0 then
					local var_164_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971039", "story_v_out_319971.awb") / 1000

					if var_164_8 + var_164_0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_8 + var_164_0
					end

					if var_164_3.prefab_name ~= "" and arg_161_1.actors_[var_164_3.prefab_name] ~= nil then
						local var_164_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_3.prefab_name].transform, "story_v_out_319971", "319971039", "story_v_out_319971.awb")

						arg_161_1:RecordAudio("319971039", var_164_9)
						arg_161_1:RecordAudio("319971039", var_164_9)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_319971", "319971039", "story_v_out_319971.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_319971", "319971039", "story_v_out_319971.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_10 = math.max(var_164_1, arg_161_1.talkMaxDuration)

			if var_164_0 <= arg_161_1.time_ and arg_161_1.time_ < var_164_0 + var_164_10 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_0) / var_164_10

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_0 + var_164_10 and arg_161_1.time_ < var_164_0 + var_164_10 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play319971040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319971040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play319971041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0
			local var_168_1 = 0.35

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_2 = arg_165_1:GetWordFromCfg(319971040)
				local var_168_3 = arg_165_1:FormatText(var_168_2.content)

				arg_165_1.text_.text = var_168_3

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_4 = 14
				local var_168_5 = utf8.len(var_168_3)
				local var_168_6 = var_168_4 <= 0 and var_168_1 or var_168_1 * (var_168_5 / var_168_4)

				if var_168_6 > 0 and var_168_1 < var_168_6 then
					arg_165_1.talkMaxDuration = var_168_6

					if var_168_6 + var_168_0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_6 + var_168_0
					end
				end

				arg_165_1.text_.text = var_168_3
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_7 = math.max(var_168_1, arg_165_1.talkMaxDuration)

			if var_168_0 <= arg_165_1.time_ and arg_165_1.time_ < var_168_0 + var_168_7 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_0) / var_168_7

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_0 + var_168_7 and arg_165_1.time_ < var_168_0 + var_168_7 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play319971041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319971041
		arg_169_1.duration_ = 0.8

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"

			SetActive(arg_169_1.choicesGo_, true)

			for iter_170_0, iter_170_1 in ipairs(arg_169_1.choices_) do
				local var_170_0 = iter_170_0 <= 1

				SetActive(iter_170_1.go, var_170_0)
			end

			arg_169_1.choices_[1].txt.text = arg_169_1:FormatText(StoryChoiceCfg[810].name)
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play319971042(arg_169_1)
			end

			arg_169_1:RecordChoiceLog(319971041, 810)
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.allBtn_.enabled = false
			end

			local var_172_1 = 0.6

			if arg_169_1.time_ >= var_172_0 + var_172_1 and arg_169_1.time_ < var_172_0 + var_172_1 + arg_172_0 then
				arg_169_1.allBtn_.enabled = true
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play319971042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319971042
		arg_173_1.duration_ = 0.8

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"

			SetActive(arg_173_1.choicesGo_, true)

			for iter_174_0, iter_174_1 in ipairs(arg_173_1.choices_) do
				local var_174_0 = iter_174_0 <= 2

				SetActive(iter_174_1.go, var_174_0)
			end

			arg_173_1.choices_[1].txt.text = arg_173_1:FormatText(StoryChoiceCfg[811].name)
			arg_173_1.choices_[2].txt.text = arg_173_1:FormatText(StoryChoiceCfg[812].name)
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play319971043(arg_173_1)
			end

			if arg_175_0 == 2 then
				arg_173_0:Play319971043(arg_173_1)
			end

			arg_173_1:RecordChoiceLog(319971042, 811, 812)
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = 0

			if var_176_0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_0 + arg_176_0 then
				arg_173_1.allBtn_.enabled = false
			end

			local var_176_1 = 0.6

			if arg_173_1.time_ >= var_176_0 + var_176_1 and arg_173_1.time_ < var_176_0 + var_176_1 + arg_176_0 then
				arg_173_1.allBtn_.enabled = true
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play319971043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319971043
		arg_177_1.duration_ = 3.7

		local var_177_0 = {
			zh = 1.733,
			ja = 3.7
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
				arg_177_0:Play319971044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.25

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[6].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(319971043)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 10
				local var_180_6 = utf8.len(var_180_4)
				local var_180_7 = var_180_5 <= 0 and var_180_1 or var_180_1 * (var_180_6 / var_180_5)

				if var_180_7 > 0 and var_180_1 < var_180_7 then
					arg_177_1.talkMaxDuration = var_180_7

					if var_180_7 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_7 + var_180_0
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971043", "story_v_out_319971.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971043", "story_v_out_319971.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_319971", "319971043", "story_v_out_319971.awb")

						arg_177_1:RecordAudio("319971043", var_180_9)
						arg_177_1:RecordAudio("319971043", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_319971", "319971043", "story_v_out_319971.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_319971", "319971043", "story_v_out_319971.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_10 = math.max(var_180_1, arg_177_1.talkMaxDuration)

			if var_180_0 <= arg_177_1.time_ and arg_177_1.time_ < var_180_0 + var_180_10 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_0) / var_180_10

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_0 + var_180_10 and arg_177_1.time_ < var_180_0 + var_180_10 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play319971044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319971044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play319971045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 0.675

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_2 = arg_181_1:FormatText(StoryNameCfg[7].name)

				arg_181_1.leftNameTxt_.text = var_184_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_3 = arg_181_1:GetWordFromCfg(319971044)
				local var_184_4 = arg_181_1:FormatText(var_184_3.content)

				arg_181_1.text_.text = var_184_4

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 27
				local var_184_6 = utf8.len(var_184_4)
				local var_184_7 = var_184_5 <= 0 and var_184_1 or var_184_1 * (var_184_6 / var_184_5)

				if var_184_7 > 0 and var_184_1 < var_184_7 then
					arg_181_1.talkMaxDuration = var_184_7

					if var_184_7 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_7 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_4
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_8 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_8 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_8

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_8 and arg_181_1.time_ < var_184_0 + var_184_8 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play319971045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319971045
		arg_185_1.duration_ = 5

		local var_185_0 = {
			zh = 2.3,
			ja = 5
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play319971046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 0.3

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				local var_188_2 = arg_185_1:FormatText(StoryNameCfg[6].name)

				arg_185_1.leftNameTxt_.text = var_188_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_3 = arg_185_1:GetWordFromCfg(319971045)
				local var_188_4 = arg_185_1:FormatText(var_188_3.content)

				arg_185_1.text_.text = var_188_4

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_5 = 12
				local var_188_6 = utf8.len(var_188_4)
				local var_188_7 = var_188_5 <= 0 and var_188_1 or var_188_1 * (var_188_6 / var_188_5)

				if var_188_7 > 0 and var_188_1 < var_188_7 then
					arg_185_1.talkMaxDuration = var_188_7

					if var_188_7 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_7 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_4
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971045", "story_v_out_319971.awb") ~= 0 then
					local var_188_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971045", "story_v_out_319971.awb") / 1000

					if var_188_8 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_0
					end

					if var_188_3.prefab_name ~= "" and arg_185_1.actors_[var_188_3.prefab_name] ~= nil then
						local var_188_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_3.prefab_name].transform, "story_v_out_319971", "319971045", "story_v_out_319971.awb")

						arg_185_1:RecordAudio("319971045", var_188_9)
						arg_185_1:RecordAudio("319971045", var_188_9)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_319971", "319971045", "story_v_out_319971.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_319971", "319971045", "story_v_out_319971.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_10 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_10 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_10

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_10 and arg_185_1.time_ < var_188_0 + var_188_10 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play319971046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319971046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play319971047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = 0
			local var_192_1 = 0.675

			if var_192_0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_0 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_2 = arg_189_1:GetWordFromCfg(319971046)
				local var_192_3 = arg_189_1:FormatText(var_192_2.content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_4 = 27
				local var_192_5 = utf8.len(var_192_3)
				local var_192_6 = var_192_4 <= 0 and var_192_1 or var_192_1 * (var_192_5 / var_192_4)

				if var_192_6 > 0 and var_192_1 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_0 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_0
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_1, arg_189_1.talkMaxDuration)

			if var_192_0 <= arg_189_1.time_ and arg_189_1.time_ < var_192_0 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_0) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_0 + var_192_7 and arg_189_1.time_ < var_192_0 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play319971047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319971047
		arg_193_1.duration_ = 7.57

		local var_193_0 = {
			zh = 4.1,
			ja = 7.566
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
				arg_193_0:Play319971048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = 0
			local var_196_1 = 0.625

			if var_196_0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_0 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_2 = arg_193_1:FormatText(StoryNameCfg[6].name)

				arg_193_1.leftNameTxt_.text = var_196_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_3 = arg_193_1:GetWordFromCfg(319971047)
				local var_196_4 = arg_193_1:FormatText(var_196_3.content)

				arg_193_1.text_.text = var_196_4

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_5 = 25
				local var_196_6 = utf8.len(var_196_4)
				local var_196_7 = var_196_5 <= 0 and var_196_1 or var_196_1 * (var_196_6 / var_196_5)

				if var_196_7 > 0 and var_196_1 < var_196_7 then
					arg_193_1.talkMaxDuration = var_196_7

					if var_196_7 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_7 + var_196_0
					end
				end

				arg_193_1.text_.text = var_196_4
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971047", "story_v_out_319971.awb") ~= 0 then
					local var_196_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971047", "story_v_out_319971.awb") / 1000

					if var_196_8 + var_196_0 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_0
					end

					if var_196_3.prefab_name ~= "" and arg_193_1.actors_[var_196_3.prefab_name] ~= nil then
						local var_196_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_3.prefab_name].transform, "story_v_out_319971", "319971047", "story_v_out_319971.awb")

						arg_193_1:RecordAudio("319971047", var_196_9)
						arg_193_1:RecordAudio("319971047", var_196_9)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_319971", "319971047", "story_v_out_319971.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_319971", "319971047", "story_v_out_319971.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_10 = math.max(var_196_1, arg_193_1.talkMaxDuration)

			if var_196_0 <= arg_193_1.time_ and arg_193_1.time_ < var_196_0 + var_196_10 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_0) / var_196_10

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_0 + var_196_10 and arg_193_1.time_ < var_196_0 + var_196_10 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play319971048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 319971048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play319971049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			local var_200_0 = 0
			local var_200_1 = 0.35

			if var_200_0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_0 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				local var_200_2 = arg_197_1:FormatText(StoryNameCfg[7].name)

				arg_197_1.leftNameTxt_.text = var_200_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, true)
				arg_197_1.iconController_:SetSelectedState("hero")

				arg_197_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_197_1.callingController_:SetSelectedState("normal")

				arg_197_1.keyicon_.color = Color.New(1, 1, 1)
				arg_197_1.icon_.color = Color.New(1, 1, 1)

				local var_200_3 = arg_197_1:GetWordFromCfg(319971048)
				local var_200_4 = arg_197_1:FormatText(var_200_3.content)

				arg_197_1.text_.text = var_200_4

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_5 = 14
				local var_200_6 = utf8.len(var_200_4)
				local var_200_7 = var_200_5 <= 0 and var_200_1 or var_200_1 * (var_200_6 / var_200_5)

				if var_200_7 > 0 and var_200_1 < var_200_7 then
					arg_197_1.talkMaxDuration = var_200_7

					if var_200_7 + var_200_0 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_7 + var_200_0
					end
				end

				arg_197_1.text_.text = var_200_4
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_8 = math.max(var_200_1, arg_197_1.talkMaxDuration)

			if var_200_0 <= arg_197_1.time_ and arg_197_1.time_ < var_200_0 + var_200_8 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_0) / var_200_8

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_0 + var_200_8 and arg_197_1.time_ < var_200_0 + var_200_8 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play319971049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 319971049
		arg_201_1.duration_ = 5.43

		local var_201_0 = {
			zh = 5.433,
			ja = 4.9
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
				arg_201_0:Play319971050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			local var_204_0 = 0
			local var_204_1 = 0.75

			if var_204_0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_0 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				local var_204_2 = arg_201_1:FormatText(StoryNameCfg[6].name)

				arg_201_1.leftNameTxt_.text = var_204_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_3 = arg_201_1:GetWordFromCfg(319971049)
				local var_204_4 = arg_201_1:FormatText(var_204_3.content)

				arg_201_1.text_.text = var_204_4

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_5 = 30
				local var_204_6 = utf8.len(var_204_4)
				local var_204_7 = var_204_5 <= 0 and var_204_1 or var_204_1 * (var_204_6 / var_204_5)

				if var_204_7 > 0 and var_204_1 < var_204_7 then
					arg_201_1.talkMaxDuration = var_204_7

					if var_204_7 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_7 + var_204_0
					end
				end

				arg_201_1.text_.text = var_204_4
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971049", "story_v_out_319971.awb") ~= 0 then
					local var_204_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971049", "story_v_out_319971.awb") / 1000

					if var_204_8 + var_204_0 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_0
					end

					if var_204_3.prefab_name ~= "" and arg_201_1.actors_[var_204_3.prefab_name] ~= nil then
						local var_204_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_201_1.actors_[var_204_3.prefab_name].transform, "story_v_out_319971", "319971049", "story_v_out_319971.awb")

						arg_201_1:RecordAudio("319971049", var_204_9)
						arg_201_1:RecordAudio("319971049", var_204_9)
					else
						arg_201_1:AudioAction("play", "voice", "story_v_out_319971", "319971049", "story_v_out_319971.awb")
					end

					arg_201_1:RecordHistoryTalkVoice("story_v_out_319971", "319971049", "story_v_out_319971.awb")
				end

				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_10 = math.max(var_204_1, arg_201_1.talkMaxDuration)

			if var_204_0 <= arg_201_1.time_ and arg_201_1.time_ < var_204_0 + var_204_10 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_0) / var_204_10

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_0 + var_204_10 and arg_201_1.time_ < var_204_0 + var_204_10 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play319971050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 319971050
		arg_205_1.duration_ = 9.4

		local var_205_0 = {
			zh = 4.1,
			ja = 9.4
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
				arg_205_0:Play319971051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			local var_208_0 = 0
			local var_208_1 = 0.55

			if var_208_0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_0 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				local var_208_2 = arg_205_1:FormatText(StoryNameCfg[6].name)

				arg_205_1.leftNameTxt_.text = var_208_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_3 = arg_205_1:GetWordFromCfg(319971050)
				local var_208_4 = arg_205_1:FormatText(var_208_3.content)

				arg_205_1.text_.text = var_208_4

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_5 = 22
				local var_208_6 = utf8.len(var_208_4)
				local var_208_7 = var_208_5 <= 0 and var_208_1 or var_208_1 * (var_208_6 / var_208_5)

				if var_208_7 > 0 and var_208_1 < var_208_7 then
					arg_205_1.talkMaxDuration = var_208_7

					if var_208_7 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_7 + var_208_0
					end
				end

				arg_205_1.text_.text = var_208_4
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971050", "story_v_out_319971.awb") ~= 0 then
					local var_208_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971050", "story_v_out_319971.awb") / 1000

					if var_208_8 + var_208_0 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_0
					end

					if var_208_3.prefab_name ~= "" and arg_205_1.actors_[var_208_3.prefab_name] ~= nil then
						local var_208_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_3.prefab_name].transform, "story_v_out_319971", "319971050", "story_v_out_319971.awb")

						arg_205_1:RecordAudio("319971050", var_208_9)
						arg_205_1:RecordAudio("319971050", var_208_9)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_319971", "319971050", "story_v_out_319971.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_319971", "319971050", "story_v_out_319971.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_10 = math.max(var_208_1, arg_205_1.talkMaxDuration)

			if var_208_0 <= arg_205_1.time_ and arg_205_1.time_ < var_208_0 + var_208_10 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_0) / var_208_10

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_0 + var_208_10 and arg_205_1.time_ < var_208_0 + var_208_10 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play319971051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 319971051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play319971052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = 0
			local var_212_1 = 0.375

			if var_212_0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_0 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_2 = arg_209_1:FormatText(StoryNameCfg[7].name)

				arg_209_1.leftNameTxt_.text = var_212_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(319971051)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 15
				local var_212_6 = utf8.len(var_212_4)
				local var_212_7 = var_212_5 <= 0 and var_212_1 or var_212_1 * (var_212_6 / var_212_5)

				if var_212_7 > 0 and var_212_1 < var_212_7 then
					arg_209_1.talkMaxDuration = var_212_7

					if var_212_7 + var_212_0 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_0
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_8 = math.max(var_212_1, arg_209_1.talkMaxDuration)

			if var_212_0 <= arg_209_1.time_ and arg_209_1.time_ < var_212_0 + var_212_8 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_0) / var_212_8

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_0 + var_212_8 and arg_209_1.time_ < var_212_0 + var_212_8 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play319971052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 319971052
		arg_213_1.duration_ = 4.37

		local var_213_0 = {
			zh = 3.066,
			ja = 4.366
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
				arg_213_0:Play319971053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = 0
			local var_216_1 = 0.3

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

				local var_216_3 = arg_213_1:GetWordFromCfg(319971052)
				local var_216_4 = arg_213_1:FormatText(var_216_3.content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_5 = 12
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

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971052", "story_v_out_319971.awb") ~= 0 then
					local var_216_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971052", "story_v_out_319971.awb") / 1000

					if var_216_8 + var_216_0 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_8 + var_216_0
					end

					if var_216_3.prefab_name ~= "" and arg_213_1.actors_[var_216_3.prefab_name] ~= nil then
						local var_216_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_3.prefab_name].transform, "story_v_out_319971", "319971052", "story_v_out_319971.awb")

						arg_213_1:RecordAudio("319971052", var_216_9)
						arg_213_1:RecordAudio("319971052", var_216_9)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_319971", "319971052", "story_v_out_319971.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_319971", "319971052", "story_v_out_319971.awb")
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
	Play319971053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 319971053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play319971054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.525

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, false)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_2 = arg_217_1:GetWordFromCfg(319971053)
				local var_220_3 = arg_217_1:FormatText(var_220_2.content)

				arg_217_1.text_.text = var_220_3

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_4 = 21
				local var_220_5 = utf8.len(var_220_3)
				local var_220_6 = var_220_4 <= 0 and var_220_1 or var_220_1 * (var_220_5 / var_220_4)

				if var_220_6 > 0 and var_220_1 < var_220_6 then
					arg_217_1.talkMaxDuration = var_220_6

					if var_220_6 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_3
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_7 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_7 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_7

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_7 and arg_217_1.time_ < var_220_0 + var_220_7 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play319971054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 319971054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play319971055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0
			local var_224_1 = 0.2

			if var_224_0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_2 = arg_221_1:FormatText(StoryNameCfg[7].name)

				arg_221_1.leftNameTxt_.text = var_224_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:GetWordFromCfg(319971054)
				local var_224_4 = arg_221_1:FormatText(var_224_3.content)

				arg_221_1.text_.text = var_224_4

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 8
				local var_224_6 = utf8.len(var_224_4)
				local var_224_7 = var_224_5 <= 0 and var_224_1 or var_224_1 * (var_224_6 / var_224_5)

				if var_224_7 > 0 and var_224_1 < var_224_7 then
					arg_221_1.talkMaxDuration = var_224_7

					if var_224_7 + var_224_0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_7 + var_224_0
					end
				end

				arg_221_1.text_.text = var_224_4
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_8 = math.max(var_224_1, arg_221_1.talkMaxDuration)

			if var_224_0 <= arg_221_1.time_ and arg_221_1.time_ < var_224_0 + var_224_8 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_0) / var_224_8

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_0 + var_224_8 and arg_221_1.time_ < var_224_0 + var_224_8 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play319971055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 319971055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play319971056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = 0
			local var_228_1 = 0.9

			if var_228_0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_0 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_2 = arg_225_1:GetWordFromCfg(319971055)
				local var_228_3 = arg_225_1:FormatText(var_228_2.content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_4 = 36
				local var_228_5 = utf8.len(var_228_3)
				local var_228_6 = var_228_4 <= 0 and var_228_1 or var_228_1 * (var_228_5 / var_228_4)

				if var_228_6 > 0 and var_228_1 < var_228_6 then
					arg_225_1.talkMaxDuration = var_228_6

					if var_228_6 + var_228_0 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_0
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_1, arg_225_1.talkMaxDuration)

			if var_228_0 <= arg_225_1.time_ and arg_225_1.time_ < var_228_0 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_0) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_0 + var_228_7 and arg_225_1.time_ < var_228_0 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play319971056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 319971056
		arg_229_1.duration_ = 4.23

		local var_229_0 = {
			zh = 2.233,
			ja = 4.233
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play319971057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.275

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[6].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_3 = arg_229_1:GetWordFromCfg(319971056)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 11
				local var_232_6 = utf8.len(var_232_4)
				local var_232_7 = var_232_5 <= 0 and var_232_1 or var_232_1 * (var_232_6 / var_232_5)

				if var_232_7 > 0 and var_232_1 < var_232_7 then
					arg_229_1.talkMaxDuration = var_232_7

					if var_232_7 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_7 + var_232_0
					end
				end

				arg_229_1.text_.text = var_232_4
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971056", "story_v_out_319971.awb") ~= 0 then
					local var_232_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971056", "story_v_out_319971.awb") / 1000

					if var_232_8 + var_232_0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_0
					end

					if var_232_3.prefab_name ~= "" and arg_229_1.actors_[var_232_3.prefab_name] ~= nil then
						local var_232_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_3.prefab_name].transform, "story_v_out_319971", "319971056", "story_v_out_319971.awb")

						arg_229_1:RecordAudio("319971056", var_232_9)
						arg_229_1:RecordAudio("319971056", var_232_9)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_319971", "319971056", "story_v_out_319971.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_319971", "319971056", "story_v_out_319971.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_10 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_10 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_10

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_10 and arg_229_1.time_ < var_232_0 + var_232_10 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play319971057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 319971057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play319971058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0
			local var_236_1 = 0.075

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_2 = arg_233_1:FormatText(StoryNameCfg[7].name)

				arg_233_1.leftNameTxt_.text = var_236_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_3 = arg_233_1:GetWordFromCfg(319971057)
				local var_236_4 = arg_233_1:FormatText(var_236_3.content)

				arg_233_1.text_.text = var_236_4

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_5 = 3
				local var_236_6 = utf8.len(var_236_4)
				local var_236_7 = var_236_5 <= 0 and var_236_1 or var_236_1 * (var_236_6 / var_236_5)

				if var_236_7 > 0 and var_236_1 < var_236_7 then
					arg_233_1.talkMaxDuration = var_236_7

					if var_236_7 + var_236_0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_7 + var_236_0
					end
				end

				arg_233_1.text_.text = var_236_4
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_8 = math.max(var_236_1, arg_233_1.talkMaxDuration)

			if var_236_0 <= arg_233_1.time_ and arg_233_1.time_ < var_236_0 + var_236_8 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_0) / var_236_8

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_0 + var_236_8 and arg_233_1.time_ < var_236_0 + var_236_8 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play319971058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 319971058
		arg_237_1.duration_ = 3.57

		local var_237_0 = {
			zh = 1.333,
			ja = 3.566
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play319971059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = 0
			local var_240_1 = 0.15

			if var_240_0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_0 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_2 = arg_237_1:FormatText(StoryNameCfg[6].name)

				arg_237_1.leftNameTxt_.text = var_240_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_3 = arg_237_1:GetWordFromCfg(319971058)
				local var_240_4 = arg_237_1:FormatText(var_240_3.content)

				arg_237_1.text_.text = var_240_4

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_5 = 6
				local var_240_6 = utf8.len(var_240_4)
				local var_240_7 = var_240_5 <= 0 and var_240_1 or var_240_1 * (var_240_6 / var_240_5)

				if var_240_7 > 0 and var_240_1 < var_240_7 then
					arg_237_1.talkMaxDuration = var_240_7

					if var_240_7 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_7 + var_240_0
					end
				end

				arg_237_1.text_.text = var_240_4
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971058", "story_v_out_319971.awb") ~= 0 then
					local var_240_8 = manager.audio:GetVoiceLength("story_v_out_319971", "319971058", "story_v_out_319971.awb") / 1000

					if var_240_8 + var_240_0 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_0
					end

					if var_240_3.prefab_name ~= "" and arg_237_1.actors_[var_240_3.prefab_name] ~= nil then
						local var_240_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_3.prefab_name].transform, "story_v_out_319971", "319971058", "story_v_out_319971.awb")

						arg_237_1:RecordAudio("319971058", var_240_9)
						arg_237_1:RecordAudio("319971058", var_240_9)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_319971", "319971058", "story_v_out_319971.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_319971", "319971058", "story_v_out_319971.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_10 = math.max(var_240_1, arg_237_1.talkMaxDuration)

			if var_240_0 <= arg_237_1.time_ and arg_237_1.time_ < var_240_0 + var_240_10 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_0) / var_240_10

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_0 + var_240_10 and arg_237_1.time_ < var_240_0 + var_240_10 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play319971059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 319971059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play319971060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = 0
			local var_244_1 = 0.2

			if var_244_0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_0 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_2 = arg_241_1:FormatText(StoryNameCfg[7].name)

				arg_241_1.leftNameTxt_.text = var_244_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_3 = arg_241_1:GetWordFromCfg(319971059)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_5 = 8
				local var_244_6 = utf8.len(var_244_4)
				local var_244_7 = var_244_5 <= 0 and var_244_1 or var_244_1 * (var_244_6 / var_244_5)

				if var_244_7 > 0 and var_244_1 < var_244_7 then
					arg_241_1.talkMaxDuration = var_244_7

					if var_244_7 + var_244_0 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_0
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_8 = math.max(var_244_1, arg_241_1.talkMaxDuration)

			if var_244_0 <= arg_241_1.time_ and arg_241_1.time_ < var_244_0 + var_244_8 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_0) / var_244_8

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_0 + var_244_8 and arg_241_1.time_ < var_244_0 + var_244_8 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play319971060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 319971060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play319971061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 0
			local var_248_1 = 0.625

			if var_248_0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_2 = arg_245_1:GetWordFromCfg(319971060)
				local var_248_3 = arg_245_1:FormatText(var_248_2.content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_4 = 25
				local var_248_5 = utf8.len(var_248_3)
				local var_248_6 = var_248_4 <= 0 and var_248_1 or var_248_1 * (var_248_5 / var_248_4)

				if var_248_6 > 0 and var_248_1 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_0
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_1, arg_245_1.talkMaxDuration)

			if var_248_0 <= arg_245_1.time_ and arg_245_1.time_ < var_248_0 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_0) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_0 + var_248_7 and arg_245_1.time_ < var_248_0 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play319971061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 319971061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play319971062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 0
			local var_252_1 = 0.675

			if var_252_0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, false)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_2 = arg_249_1:GetWordFromCfg(319971061)
				local var_252_3 = arg_249_1:FormatText(var_252_2.content)

				arg_249_1.text_.text = var_252_3

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 27
				local var_252_5 = utf8.len(var_252_3)
				local var_252_6 = var_252_4 <= 0 and var_252_1 or var_252_1 * (var_252_5 / var_252_4)

				if var_252_6 > 0 and var_252_1 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_0
					end
				end

				arg_249_1.text_.text = var_252_3
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_1, arg_249_1.talkMaxDuration)

			if var_252_0 <= arg_249_1.time_ and arg_249_1.time_ < var_252_0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_0 + var_252_7 and arg_249_1.time_ < var_252_0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play319971062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 319971062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play319971063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 0.4

			if var_256_0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				local var_256_2 = arg_253_1:FormatText(StoryNameCfg[7].name)

				arg_253_1.leftNameTxt_.text = var_256_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(319971062)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 16
				local var_256_6 = utf8.len(var_256_4)
				local var_256_7 = var_256_5 <= 0 and var_256_1 or var_256_1 * (var_256_6 / var_256_5)

				if var_256_7 > 0 and var_256_1 < var_256_7 then
					arg_253_1.talkMaxDuration = var_256_7

					if var_256_7 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_7 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_4
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_8 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_8 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_8

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_8 and arg_253_1.time_ < var_256_0 + var_256_8 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play319971063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 319971063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play319971064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 1.175

			if var_260_0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				local var_260_2 = arg_257_1:FormatText(StoryNameCfg[7].name)

				arg_257_1.leftNameTxt_.text = var_260_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(319971063)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 47
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
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_8 = math.max(var_260_1, arg_257_1.talkMaxDuration)

			if var_260_0 <= arg_257_1.time_ and arg_257_1.time_ < var_260_0 + var_260_8 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_0) / var_260_8

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_0 + var_260_8 and arg_257_1.time_ < var_260_0 + var_260_8 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play319971064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 319971064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play319971065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0
			local var_264_1 = 1.05

			if var_264_0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_2 = arg_261_1:FormatText(StoryNameCfg[7].name)

				arg_261_1.leftNameTxt_.text = var_264_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:GetWordFromCfg(319971064)
				local var_264_4 = arg_261_1:FormatText(var_264_3.content)

				arg_261_1.text_.text = var_264_4

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 42
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
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_8 = math.max(var_264_1, arg_261_1.talkMaxDuration)

			if var_264_0 <= arg_261_1.time_ and arg_261_1.time_ < var_264_0 + var_264_8 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_0) / var_264_8

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_0 + var_264_8 and arg_261_1.time_ < var_264_0 + var_264_8 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play319971065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 319971065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play319971066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0
			local var_268_1 = 1.2

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_2 = arg_265_1:FormatText(StoryNameCfg[7].name)

				arg_265_1.leftNameTxt_.text = var_268_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_3 = arg_265_1:GetWordFromCfg(319971065)
				local var_268_4 = arg_265_1:FormatText(var_268_3.content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_5 = 48
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
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_8 = math.max(var_268_1, arg_265_1.talkMaxDuration)

			if var_268_0 <= arg_265_1.time_ and arg_265_1.time_ < var_268_0 + var_268_8 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_0) / var_268_8

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_0 + var_268_8 and arg_265_1.time_ < var_268_0 + var_268_8 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play319971066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 319971066
		arg_269_1.duration_ = 0.8

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"

			SetActive(arg_269_1.choicesGo_, true)

			for iter_270_0, iter_270_1 in ipairs(arg_269_1.choices_) do
				local var_270_0 = iter_270_0 <= 1

				SetActive(iter_270_1.go, var_270_0)
			end

			arg_269_1.choices_[1].txt.text = arg_269_1:FormatText(StoryChoiceCfg[813].name)
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play319971067(arg_269_1)
			end

			arg_269_1:RecordChoiceLog(319971066, 813)
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.allBtn_.enabled = false
			end

			local var_272_1 = 0.6

			if arg_269_1.time_ >= var_272_0 + var_272_1 and arg_269_1.time_ < var_272_0 + var_272_1 + arg_272_0 then
				arg_269_1.allBtn_.enabled = true
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play319971067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 319971067
		arg_273_1.duration_ = 5.95

		local var_273_0 = {
			zh = 5.899999999999,
			ja = 5.95000000298023
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
				arg_273_0:Play319971068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = "L01f"

			if arg_273_1.bgs_[var_276_0] == nil then
				local var_276_1 = Object.Instantiate(arg_273_1.paintGo_)

				var_276_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_276_0)
				var_276_1.name = var_276_0
				var_276_1.transform.parent = arg_273_1.stage_.transform
				var_276_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.bgs_[var_276_0] = var_276_1
			end

			local var_276_2 = 2

			if var_276_2 < arg_273_1.time_ and arg_273_1.time_ <= var_276_2 + arg_276_0 then
				local var_276_3 = manager.ui.mainCamera.transform.localPosition
				local var_276_4 = Vector3.New(0, 0, 10) + Vector3.New(var_276_3.x, var_276_3.y, 0)
				local var_276_5 = arg_273_1.bgs_.L01f

				var_276_5.transform.localPosition = var_276_4
				var_276_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_276_6 = var_276_5:GetComponent("SpriteRenderer")

				if var_276_6 and var_276_6.sprite then
					local var_276_7 = (var_276_5.transform.localPosition - var_276_3).z
					local var_276_8 = manager.ui.mainCameraCom_
					local var_276_9 = 2 * var_276_7 * Mathf.Tan(var_276_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_276_10 = var_276_9 * var_276_8.aspect
					local var_276_11 = var_276_6.sprite.bounds.size.x
					local var_276_12 = var_276_6.sprite.bounds.size.y
					local var_276_13 = var_276_10 / var_276_11
					local var_276_14 = var_276_9 / var_276_12
					local var_276_15 = var_276_14 < var_276_13 and var_276_13 or var_276_14

					var_276_5.transform.localScale = Vector3.New(var_276_15, var_276_15, 0)
				end

				for iter_276_0, iter_276_1 in pairs(arg_273_1.bgs_) do
					if iter_276_0 ~= "L01f" then
						iter_276_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_276_16 = 3.9

			if var_276_16 < arg_273_1.time_ and arg_273_1.time_ <= var_276_16 + arg_276_0 then
				arg_273_1.allBtn_.enabled = false
			end

			local var_276_17 = 0.3

			if arg_273_1.time_ >= var_276_16 + var_276_17 and arg_273_1.time_ < var_276_16 + var_276_17 + arg_276_0 then
				arg_273_1.allBtn_.enabled = true
			end

			local var_276_18 = 0

			if var_276_18 < arg_273_1.time_ and arg_273_1.time_ <= var_276_18 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_19 = 2

			if var_276_18 <= arg_273_1.time_ and arg_273_1.time_ < var_276_18 + var_276_19 then
				local var_276_20 = (arg_273_1.time_ - var_276_18) / var_276_19
				local var_276_21 = Color.New(0, 0, 0)

				var_276_21.a = Mathf.Lerp(0, 1, var_276_20)
				arg_273_1.mask_.color = var_276_21
			end

			if arg_273_1.time_ >= var_276_18 + var_276_19 and arg_273_1.time_ < var_276_18 + var_276_19 + arg_276_0 then
				local var_276_22 = Color.New(0, 0, 0)

				var_276_22.a = 1
				arg_273_1.mask_.color = var_276_22
			end

			local var_276_23 = 2

			if var_276_23 < arg_273_1.time_ and arg_273_1.time_ <= var_276_23 + arg_276_0 then
				arg_273_1.mask_.enabled = true
				arg_273_1.mask_.raycastTarget = true

				arg_273_1:SetGaussion(false)
			end

			local var_276_24 = 2

			if var_276_23 <= arg_273_1.time_ and arg_273_1.time_ < var_276_23 + var_276_24 then
				local var_276_25 = (arg_273_1.time_ - var_276_23) / var_276_24
				local var_276_26 = Color.New(0, 0, 0)

				var_276_26.a = Mathf.Lerp(1, 0, var_276_25)
				arg_273_1.mask_.color = var_276_26
			end

			if arg_273_1.time_ >= var_276_23 + var_276_24 and arg_273_1.time_ < var_276_23 + var_276_24 + arg_276_0 then
				local var_276_27 = Color.New(0, 0, 0)
				local var_276_28 = 0

				arg_273_1.mask_.enabled = false
				var_276_27.a = var_276_28
				arg_273_1.mask_.color = var_276_27
			end

			local var_276_29 = "1061ui_story"

			if arg_273_1.actors_[var_276_29] == nil then
				local var_276_30 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_276_30) then
					local var_276_31 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_273_1.stage_.transform)

					var_276_31.name = var_276_29
					var_276_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_273_1.actors_[var_276_29] = var_276_31

					local var_276_32 = var_276_31:GetComponentInChildren(typeof(CharacterEffect))

					var_276_32.enabled = true

					local var_276_33 = GameObjectTools.GetOrAddComponent(var_276_31, typeof(DynamicBoneHelper))

					if var_276_33 then
						var_276_33:EnableDynamicBone(false)
					end

					arg_273_1:ShowWeapon(var_276_32.transform, false)

					arg_273_1.var_[var_276_29 .. "Animator"] = var_276_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_273_1.var_[var_276_29 .. "Animator"].applyRootMotion = true
					arg_273_1.var_[var_276_29 .. "LipSync"] = var_276_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_276_34 = arg_273_1.actors_["1061ui_story"].transform
			local var_276_35 = 3.9

			if var_276_35 < arg_273_1.time_ and arg_273_1.time_ <= var_276_35 + arg_276_0 then
				arg_273_1.var_.moveOldPos1061ui_story = var_276_34.localPosition

				local var_276_36 = "1061ui_story"

				arg_273_1:ShowWeapon(arg_273_1.var_[var_276_36 .. "Animator"].transform, false)
			end

			local var_276_37 = 0.001

			if var_276_35 <= arg_273_1.time_ and arg_273_1.time_ < var_276_35 + var_276_37 then
				local var_276_38 = (arg_273_1.time_ - var_276_35) / var_276_37
				local var_276_39 = Vector3.New(0, -1.18, -6.15)

				var_276_34.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1061ui_story, var_276_39, var_276_38)

				local var_276_40 = manager.ui.mainCamera.transform.position - var_276_34.position

				var_276_34.forward = Vector3.New(var_276_40.x, var_276_40.y, var_276_40.z)

				local var_276_41 = var_276_34.localEulerAngles

				var_276_41.z = 0
				var_276_41.x = 0
				var_276_34.localEulerAngles = var_276_41
			end

			if arg_273_1.time_ >= var_276_35 + var_276_37 and arg_273_1.time_ < var_276_35 + var_276_37 + arg_276_0 then
				var_276_34.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_276_42 = manager.ui.mainCamera.transform.position - var_276_34.position

				var_276_34.forward = Vector3.New(var_276_42.x, var_276_42.y, var_276_42.z)

				local var_276_43 = var_276_34.localEulerAngles

				var_276_43.z = 0
				var_276_43.x = 0
				var_276_34.localEulerAngles = var_276_43
			end

			local var_276_44 = arg_273_1.actors_["1061ui_story"]
			local var_276_45 = 3.9

			if var_276_45 < arg_273_1.time_ and arg_273_1.time_ <= var_276_45 + arg_276_0 and not isNil(var_276_44) and arg_273_1.var_.characterEffect1061ui_story == nil then
				arg_273_1.var_.characterEffect1061ui_story = var_276_44:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_46 = 0.200000002980232

			if var_276_45 <= arg_273_1.time_ and arg_273_1.time_ < var_276_45 + var_276_46 and not isNil(var_276_44) then
				local var_276_47 = (arg_273_1.time_ - var_276_45) / var_276_46

				if arg_273_1.var_.characterEffect1061ui_story and not isNil(var_276_44) then
					arg_273_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= var_276_45 + var_276_46 and arg_273_1.time_ < var_276_45 + var_276_46 + arg_276_0 and not isNil(var_276_44) and arg_273_1.var_.characterEffect1061ui_story then
				arg_273_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_276_48 = 3.9

			if var_276_48 < arg_273_1.time_ and arg_273_1.time_ <= var_276_48 + arg_276_0 then
				arg_273_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action1_1")
			end

			local var_276_49 = 3.9

			if var_276_49 < arg_273_1.time_ and arg_273_1.time_ <= var_276_49 + arg_276_0 then
				arg_273_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_276_50 = 0
			local var_276_51 = 0.2

			if var_276_50 < arg_273_1.time_ and arg_273_1.time_ <= var_276_50 + arg_276_0 then
				local var_276_52 = "play"
				local var_276_53 = "music"

				arg_273_1:AudioAction(var_276_52, var_276_53, "ui_battle", "ui_battle_stopbgm", "")

				local var_276_54 = ""
				local var_276_55 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_276_55 ~= "" then
					if arg_273_1.bgmTxt_.text ~= var_276_55 and arg_273_1.bgmTxt_.text ~= "" then
						if arg_273_1.bgmTxt2_.text ~= "" then
							arg_273_1.bgmTxt_.text = arg_273_1.bgmTxt2_.text
						end

						arg_273_1.bgmTxt2_.text = var_276_55

						arg_273_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_273_1.bgmTxt_.text = var_276_55
						arg_273_1.bgmTxt2_.text = var_276_55
					end

					if arg_273_1.bgmTimer then
						arg_273_1.bgmTimer:Stop()

						arg_273_1.bgmTimer = nil
					end

					if arg_273_1.settingData.show_music_name == 1 then
						arg_273_1.musicController:SetSelectedState("show")
						arg_273_1.musicAnimator_:Play("open", 0, 0)

						if arg_273_1.settingData.music_time ~= 0 then
							arg_273_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_273_1.settingData.music_time), function()
								if arg_273_1 == nil or isNil(arg_273_1.bgmTxt_) then
									return
								end

								arg_273_1.musicController:SetSelectedState("hide")
								arg_273_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_276_56 = 0
			local var_276_57 = 0.2

			if var_276_56 < arg_273_1.time_ and arg_273_1.time_ <= var_276_56 + arg_276_0 then
				local var_276_58 = "play"
				local var_276_59 = "effect"

				arg_273_1:AudioAction(var_276_58, var_276_59, "se_story_1210", "se_story_1210_loop_wind", "")
			end

			if arg_273_1.frameCnt_ <= 1 then
				arg_273_1.dialog_:SetActive(false)
			end

			local var_276_60 = 4.05000000298023
			local var_276_61 = 0.05

			if var_276_60 < arg_273_1.time_ and arg_273_1.time_ <= var_276_60 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0

				arg_273_1.dialog_:SetActive(true)

				arg_273_1.dialogCg_.alpha = 0

				local var_276_62 = LeanTween.value(arg_273_1.dialog_, 0, 1, 0.3)

				var_276_62:setOnUpdate(LuaHelper.FloatAction(function(arg_278_0)
					arg_273_1.dialogCg_.alpha = arg_278_0
				end))
				var_276_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_273_1.dialog_)
					var_276_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_273_1.duration_ = arg_273_1.duration_ + 0.3

				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_63 = arg_273_1:FormatText(StoryNameCfg[612].name)

				arg_273_1.leftNameTxt_.text = var_276_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_64 = arg_273_1:GetWordFromCfg(319971067)
				local var_276_65 = arg_273_1:FormatText(var_276_64.content)

				arg_273_1.text_.text = var_276_65

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_66 = 2
				local var_276_67 = utf8.len(var_276_65)
				local var_276_68 = var_276_66 <= 0 and var_276_61 or var_276_61 * (var_276_67 / var_276_66)

				if var_276_68 > 0 and var_276_61 < var_276_68 then
					arg_273_1.talkMaxDuration = var_276_68
					var_276_60 = var_276_60 + 0.3

					if var_276_68 + var_276_60 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_68 + var_276_60
					end
				end

				arg_273_1.text_.text = var_276_65
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971067", "story_v_out_319971.awb") ~= 0 then
					local var_276_69 = manager.audio:GetVoiceLength("story_v_out_319971", "319971067", "story_v_out_319971.awb") / 1000

					if var_276_69 + var_276_60 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_69 + var_276_60
					end

					if var_276_64.prefab_name ~= "" and arg_273_1.actors_[var_276_64.prefab_name] ~= nil then
						local var_276_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_64.prefab_name].transform, "story_v_out_319971", "319971067", "story_v_out_319971.awb")

						arg_273_1:RecordAudio("319971067", var_276_70)
						arg_273_1:RecordAudio("319971067", var_276_70)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_319971", "319971067", "story_v_out_319971.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_319971", "319971067", "story_v_out_319971.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_71 = var_276_60 + 0.3
			local var_276_72 = math.max(var_276_61, arg_273_1.talkMaxDuration)

			if var_276_71 <= arg_273_1.time_ and arg_273_1.time_ < var_276_71 + var_276_72 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_71) / var_276_72

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_71 + var_276_72 and arg_273_1.time_ < var_276_71 + var_276_72 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1061ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play319971068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 319971068
		arg_280_1.duration_ = 5

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play319971069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["1061ui_story"]
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1061ui_story == nil then
				arg_280_1.var_.characterEffect1061ui_story = var_283_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 and not isNil(var_283_0) then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2

				if arg_280_1.var_.characterEffect1061ui_story and not isNil(var_283_0) then
					local var_283_4 = Mathf.Lerp(0, 0.5, var_283_3)

					arg_280_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1061ui_story.fillRatio = var_283_4
				end
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect1061ui_story then
				local var_283_5 = 0.5

				arg_280_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1061ui_story.fillRatio = var_283_5
			end

			local var_283_6 = 0
			local var_283_7 = 0.95

			if var_283_6 < arg_280_1.time_ and arg_280_1.time_ <= var_283_6 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, false)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_8 = arg_280_1:GetWordFromCfg(319971068)
				local var_283_9 = arg_280_1:FormatText(var_283_8.content)

				arg_280_1.text_.text = var_283_9

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_10 = 38
				local var_283_11 = utf8.len(var_283_9)
				local var_283_12 = var_283_10 <= 0 and var_283_7 or var_283_7 * (var_283_11 / var_283_10)

				if var_283_12 > 0 and var_283_7 < var_283_12 then
					arg_280_1.talkMaxDuration = var_283_12

					if var_283_12 + var_283_6 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_12 + var_283_6
					end
				end

				arg_280_1.text_.text = var_283_9
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)
				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_13 = math.max(var_283_7, arg_280_1.talkMaxDuration)

			if var_283_6 <= arg_280_1.time_ and arg_280_1.time_ < var_283_6 + var_283_13 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_6) / var_283_13

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_6 + var_283_13 and arg_280_1.time_ < var_283_6 + var_283_13 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play319971069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 319971069
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play319971070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0
			local var_287_1 = 0.625

			if var_287_0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_2 = arg_284_1:GetWordFromCfg(319971069)
				local var_287_3 = arg_284_1:FormatText(var_287_2.content)

				arg_284_1.text_.text = var_287_3

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 25
				local var_287_5 = utf8.len(var_287_3)
				local var_287_6 = var_287_4 <= 0 and var_287_1 or var_287_1 * (var_287_5 / var_287_4)

				if var_287_6 > 0 and var_287_1 < var_287_6 then
					arg_284_1.talkMaxDuration = var_287_6

					if var_287_6 + var_287_0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_6 + var_287_0
					end
				end

				arg_284_1.text_.text = var_287_3
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_1, arg_284_1.talkMaxDuration)

			if var_287_0 <= arg_284_1.time_ and arg_284_1.time_ < var_287_0 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_0) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_0 + var_287_7 and arg_284_1.time_ < var_287_0 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play319971070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 319971070
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play319971071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0
			local var_291_1 = 0.825

			if var_291_0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_2 = arg_288_1:GetWordFromCfg(319971070)
				local var_291_3 = arg_288_1:FormatText(var_291_2.content)

				arg_288_1.text_.text = var_291_3

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_4 = 33
				local var_291_5 = utf8.len(var_291_3)
				local var_291_6 = var_291_4 <= 0 and var_291_1 or var_291_1 * (var_291_5 / var_291_4)

				if var_291_6 > 0 and var_291_1 < var_291_6 then
					arg_288_1.talkMaxDuration = var_291_6

					if var_291_6 + var_291_0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_6 + var_291_0
					end
				end

				arg_288_1.text_.text = var_291_3
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_7 = math.max(var_291_1, arg_288_1.talkMaxDuration)

			if var_291_0 <= arg_288_1.time_ and arg_288_1.time_ < var_291_0 + var_291_7 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_0) / var_291_7

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_0 + var_291_7 and arg_288_1.time_ < var_291_0 + var_291_7 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play319971071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 319971071
		arg_292_1.duration_ = 13.6

		local var_292_0 = {
			zh = 5.066,
			ja = 13.6
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play319971072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["1061ui_story"].transform
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.var_.moveOldPos1061ui_story = var_295_0.localPosition
			end

			local var_295_2 = 0.001

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2
				local var_295_4 = Vector3.New(0, -1.18, -6.15)

				var_295_0.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1061ui_story, var_295_4, var_295_3)

				local var_295_5 = manager.ui.mainCamera.transform.position - var_295_0.position

				var_295_0.forward = Vector3.New(var_295_5.x, var_295_5.y, var_295_5.z)

				local var_295_6 = var_295_0.localEulerAngles

				var_295_6.z = 0
				var_295_6.x = 0
				var_295_0.localEulerAngles = var_295_6
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 then
				var_295_0.localPosition = Vector3.New(0, -1.18, -6.15)

				local var_295_7 = manager.ui.mainCamera.transform.position - var_295_0.position

				var_295_0.forward = Vector3.New(var_295_7.x, var_295_7.y, var_295_7.z)

				local var_295_8 = var_295_0.localEulerAngles

				var_295_8.z = 0
				var_295_8.x = 0
				var_295_0.localEulerAngles = var_295_8
			end

			local var_295_9 = arg_292_1.actors_["1061ui_story"]
			local var_295_10 = 0

			if var_295_10 < arg_292_1.time_ and arg_292_1.time_ <= var_295_10 + arg_295_0 and not isNil(var_295_9) and arg_292_1.var_.characterEffect1061ui_story == nil then
				arg_292_1.var_.characterEffect1061ui_story = var_295_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_11 = 0.200000002980232

			if var_295_10 <= arg_292_1.time_ and arg_292_1.time_ < var_295_10 + var_295_11 and not isNil(var_295_9) then
				local var_295_12 = (arg_292_1.time_ - var_295_10) / var_295_11

				if arg_292_1.var_.characterEffect1061ui_story and not isNil(var_295_9) then
					arg_292_1.var_.characterEffect1061ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= var_295_10 + var_295_11 and arg_292_1.time_ < var_295_10 + var_295_11 + arg_295_0 and not isNil(var_295_9) and arg_292_1.var_.characterEffect1061ui_story then
				arg_292_1.var_.characterEffect1061ui_story.fillFlat = false
			end

			local var_295_13 = 0

			if var_295_13 < arg_292_1.time_ and arg_292_1.time_ <= var_295_13 + arg_295_0 then
				arg_292_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/story1061/story1061action/1061action2_1")
			end

			local var_295_14 = 0

			if var_295_14 < arg_292_1.time_ and arg_292_1.time_ <= var_295_14 + arg_295_0 then
				arg_292_1:PlayTimeline("1061ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_295_15 = 0
			local var_295_16 = 0.55

			if var_295_15 < arg_292_1.time_ and arg_292_1.time_ <= var_295_15 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				local var_295_17 = arg_292_1:FormatText(StoryNameCfg[612].name)

				arg_292_1.leftNameTxt_.text = var_295_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_18 = arg_292_1:GetWordFromCfg(319971071)
				local var_295_19 = arg_292_1:FormatText(var_295_18.content)

				arg_292_1.text_.text = var_295_19

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_20 = 22
				local var_295_21 = utf8.len(var_295_19)
				local var_295_22 = var_295_20 <= 0 and var_295_16 or var_295_16 * (var_295_21 / var_295_20)

				if var_295_22 > 0 and var_295_16 < var_295_22 then
					arg_292_1.talkMaxDuration = var_295_22

					if var_295_22 + var_295_15 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_22 + var_295_15
					end
				end

				arg_292_1.text_.text = var_295_19
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971071", "story_v_out_319971.awb") ~= 0 then
					local var_295_23 = manager.audio:GetVoiceLength("story_v_out_319971", "319971071", "story_v_out_319971.awb") / 1000

					if var_295_23 + var_295_15 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_23 + var_295_15
					end

					if var_295_18.prefab_name ~= "" and arg_292_1.actors_[var_295_18.prefab_name] ~= nil then
						local var_295_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_18.prefab_name].transform, "story_v_out_319971", "319971071", "story_v_out_319971.awb")

						arg_292_1:RecordAudio("319971071", var_295_24)
						arg_292_1:RecordAudio("319971071", var_295_24)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_319971", "319971071", "story_v_out_319971.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_319971", "319971071", "story_v_out_319971.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_25 = math.max(var_295_16, arg_292_1.talkMaxDuration)

			if var_295_15 <= arg_292_1.time_ and arg_292_1.time_ < var_295_15 + var_295_25 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_15) / var_295_25

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_15 + var_295_25 and arg_292_1.time_ < var_295_15 + var_295_25 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
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

		arg_292_1:InitPlayNodeList()
	end,
	Play319971072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 319971072
		arg_296_1.duration_ = 7

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play319971073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = "STblack"

			if arg_296_1.bgs_[var_299_0] == nil then
				local var_299_1 = Object.Instantiate(arg_296_1.paintGo_)

				var_299_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_299_0)
				var_299_1.name = var_299_0
				var_299_1.transform.parent = arg_296_1.stage_.transform
				var_299_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_296_1.bgs_[var_299_0] = var_299_1
			end

			local var_299_2 = 0

			if var_299_2 < arg_296_1.time_ and arg_296_1.time_ <= var_299_2 + arg_299_0 then
				local var_299_3 = manager.ui.mainCamera.transform.localPosition
				local var_299_4 = Vector3.New(0, 0, 10) + Vector3.New(var_299_3.x, var_299_3.y, 0)
				local var_299_5 = arg_296_1.bgs_.STblack

				var_299_5.transform.localPosition = var_299_4
				var_299_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_299_6 = var_299_5:GetComponent("SpriteRenderer")

				if var_299_6 and var_299_6.sprite then
					local var_299_7 = (var_299_5.transform.localPosition - var_299_3).z
					local var_299_8 = manager.ui.mainCameraCom_
					local var_299_9 = 2 * var_299_7 * Mathf.Tan(var_299_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_299_10 = var_299_9 * var_299_8.aspect
					local var_299_11 = var_299_6.sprite.bounds.size.x
					local var_299_12 = var_299_6.sprite.bounds.size.y
					local var_299_13 = var_299_10 / var_299_11
					local var_299_14 = var_299_9 / var_299_12
					local var_299_15 = var_299_14 < var_299_13 and var_299_13 or var_299_14

					var_299_5.transform.localScale = Vector3.New(var_299_15, var_299_15, 0)
				end

				for iter_299_0, iter_299_1 in pairs(arg_296_1.bgs_) do
					if iter_299_0 ~= "STblack" then
						iter_299_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_299_16 = 1.999999999999

			if var_299_16 < arg_296_1.time_ and arg_296_1.time_ <= var_299_16 + arg_299_0 then
				arg_296_1.allBtn_.enabled = false
			end

			local var_299_17 = 0.3

			if arg_296_1.time_ >= var_299_16 + var_299_17 and arg_296_1.time_ < var_299_16 + var_299_17 + arg_299_0 then
				arg_296_1.allBtn_.enabled = true
			end

			local var_299_18 = 0

			if var_299_18 < arg_296_1.time_ and arg_296_1.time_ <= var_299_18 + arg_299_0 then
				arg_296_1.mask_.enabled = true
				arg_296_1.mask_.raycastTarget = true

				arg_296_1:SetGaussion(false)
			end

			local var_299_19 = 2

			if var_299_18 <= arg_296_1.time_ and arg_296_1.time_ < var_299_18 + var_299_19 then
				local var_299_20 = (arg_296_1.time_ - var_299_18) / var_299_19
				local var_299_21 = Color.New(1, 1, 1)

				var_299_21.a = Mathf.Lerp(1, 0, var_299_20)
				arg_296_1.mask_.color = var_299_21
			end

			if arg_296_1.time_ >= var_299_18 + var_299_19 and arg_296_1.time_ < var_299_18 + var_299_19 + arg_299_0 then
				local var_299_22 = Color.New(1, 1, 1)
				local var_299_23 = 0

				arg_296_1.mask_.enabled = false
				var_299_22.a = var_299_23
				arg_296_1.mask_.color = var_299_22
			end

			local var_299_24 = arg_296_1.actors_["1061ui_story"].transform
			local var_299_25 = 0

			if var_299_25 < arg_296_1.time_ and arg_296_1.time_ <= var_299_25 + arg_299_0 then
				arg_296_1.var_.moveOldPos1061ui_story = var_299_24.localPosition
			end

			local var_299_26 = 0.001

			if var_299_25 <= arg_296_1.time_ and arg_296_1.time_ < var_299_25 + var_299_26 then
				local var_299_27 = (arg_296_1.time_ - var_299_25) / var_299_26
				local var_299_28 = Vector3.New(0, 100, 0)

				var_299_24.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1061ui_story, var_299_28, var_299_27)

				local var_299_29 = manager.ui.mainCamera.transform.position - var_299_24.position

				var_299_24.forward = Vector3.New(var_299_29.x, var_299_29.y, var_299_29.z)

				local var_299_30 = var_299_24.localEulerAngles

				var_299_30.z = 0
				var_299_30.x = 0
				var_299_24.localEulerAngles = var_299_30
			end

			if arg_296_1.time_ >= var_299_25 + var_299_26 and arg_296_1.time_ < var_299_25 + var_299_26 + arg_299_0 then
				var_299_24.localPosition = Vector3.New(0, 100, 0)

				local var_299_31 = manager.ui.mainCamera.transform.position - var_299_24.position

				var_299_24.forward = Vector3.New(var_299_31.x, var_299_31.y, var_299_31.z)

				local var_299_32 = var_299_24.localEulerAngles

				var_299_32.z = 0
				var_299_32.x = 0
				var_299_24.localEulerAngles = var_299_32
			end

			local var_299_33 = arg_296_1.actors_["1061ui_story"]
			local var_299_34 = 0

			if var_299_34 < arg_296_1.time_ and arg_296_1.time_ <= var_299_34 + arg_299_0 and not isNil(var_299_33) and arg_296_1.var_.characterEffect1061ui_story == nil then
				arg_296_1.var_.characterEffect1061ui_story = var_299_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_35 = 0.034000001847744

			if var_299_34 <= arg_296_1.time_ and arg_296_1.time_ < var_299_34 + var_299_35 and not isNil(var_299_33) then
				local var_299_36 = (arg_296_1.time_ - var_299_34) / var_299_35

				if arg_296_1.var_.characterEffect1061ui_story and not isNil(var_299_33) then
					local var_299_37 = Mathf.Lerp(0, 0.5, var_299_36)

					arg_296_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1061ui_story.fillRatio = var_299_37
				end
			end

			if arg_296_1.time_ >= var_299_34 + var_299_35 and arg_296_1.time_ < var_299_34 + var_299_35 + arg_299_0 and not isNil(var_299_33) and arg_296_1.var_.characterEffect1061ui_story then
				local var_299_38 = 0.5

				arg_296_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1061ui_story.fillRatio = var_299_38
			end

			if arg_296_1.frameCnt_ <= 1 then
				arg_296_1.dialog_:SetActive(false)
			end

			local var_299_39 = 1.999999999999
			local var_299_40 = 0.925

			if var_299_39 < arg_296_1.time_ and arg_296_1.time_ <= var_299_39 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0

				arg_296_1.dialog_:SetActive(true)

				arg_296_1.dialogCg_.alpha = 0

				local var_299_41 = LeanTween.value(arg_296_1.dialog_, 0, 1, 0.3)

				var_299_41:setOnUpdate(LuaHelper.FloatAction(function(arg_300_0)
					arg_296_1.dialogCg_.alpha = arg_300_0
				end))
				var_299_41:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_296_1.dialog_)
					var_299_41:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_296_1.duration_ = arg_296_1.duration_ + 0.3

				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_42 = arg_296_1:GetWordFromCfg(319971072)
				local var_299_43 = arg_296_1:FormatText(var_299_42.content)

				arg_296_1.text_.text = var_299_43

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_44 = 37
				local var_299_45 = utf8.len(var_299_43)
				local var_299_46 = var_299_44 <= 0 and var_299_40 or var_299_40 * (var_299_45 / var_299_44)

				if var_299_46 > 0 and var_299_40 < var_299_46 then
					arg_296_1.talkMaxDuration = var_299_46
					var_299_39 = var_299_39 + 0.3

					if var_299_46 + var_299_39 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_46 + var_299_39
					end
				end

				arg_296_1.text_.text = var_299_43
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_47 = var_299_39 + 0.3
			local var_299_48 = math.max(var_299_40, arg_296_1.talkMaxDuration)

			if var_299_47 <= arg_296_1.time_ and arg_296_1.time_ < var_299_47 + var_299_48 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_47) / var_299_48

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_47 + var_299_48 and arg_296_1.time_ < var_299_47 + var_299_48 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
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

		arg_296_1:InitPlayNodeList()
	end,
	Play319971073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 319971073
		arg_302_1.duration_ = 7

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play319971074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = "ST69"

			if arg_302_1.bgs_[var_305_0] == nil then
				local var_305_1 = Object.Instantiate(arg_302_1.paintGo_)

				var_305_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_305_0)
				var_305_1.name = var_305_0
				var_305_1.transform.parent = arg_302_1.stage_.transform
				var_305_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_302_1.bgs_[var_305_0] = var_305_1
			end

			local var_305_2 = 0

			if var_305_2 < arg_302_1.time_ and arg_302_1.time_ <= var_305_2 + arg_305_0 then
				local var_305_3 = manager.ui.mainCamera.transform.localPosition
				local var_305_4 = Vector3.New(0, 0, 10) + Vector3.New(var_305_3.x, var_305_3.y, 0)
				local var_305_5 = arg_302_1.bgs_.ST69

				var_305_5.transform.localPosition = var_305_4
				var_305_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_305_6 = var_305_5:GetComponent("SpriteRenderer")

				if var_305_6 and var_305_6.sprite then
					local var_305_7 = (var_305_5.transform.localPosition - var_305_3).z
					local var_305_8 = manager.ui.mainCameraCom_
					local var_305_9 = 2 * var_305_7 * Mathf.Tan(var_305_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_305_10 = var_305_9 * var_305_8.aspect
					local var_305_11 = var_305_6.sprite.bounds.size.x
					local var_305_12 = var_305_6.sprite.bounds.size.y
					local var_305_13 = var_305_10 / var_305_11
					local var_305_14 = var_305_9 / var_305_12
					local var_305_15 = var_305_14 < var_305_13 and var_305_13 or var_305_14

					var_305_5.transform.localScale = Vector3.New(var_305_15, var_305_15, 0)
				end

				for iter_305_0, iter_305_1 in pairs(arg_302_1.bgs_) do
					if iter_305_0 ~= "ST69" then
						iter_305_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_305_16 = 2

			if var_305_16 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 then
				arg_302_1.allBtn_.enabled = false
			end

			local var_305_17 = 0.3

			if arg_302_1.time_ >= var_305_16 + var_305_17 and arg_302_1.time_ < var_305_16 + var_305_17 + arg_305_0 then
				arg_302_1.allBtn_.enabled = true
			end

			local var_305_18 = 0

			if var_305_18 < arg_302_1.time_ and arg_302_1.time_ <= var_305_18 + arg_305_0 then
				arg_302_1.mask_.enabled = true
				arg_302_1.mask_.raycastTarget = true

				arg_302_1:SetGaussion(false)
			end

			local var_305_19 = 2

			if var_305_18 <= arg_302_1.time_ and arg_302_1.time_ < var_305_18 + var_305_19 then
				local var_305_20 = (arg_302_1.time_ - var_305_18) / var_305_19
				local var_305_21 = Color.New(0, 0, 0)

				var_305_21.a = Mathf.Lerp(1, 0, var_305_20)
				arg_302_1.mask_.color = var_305_21
			end

			if arg_302_1.time_ >= var_305_18 + var_305_19 and arg_302_1.time_ < var_305_18 + var_305_19 + arg_305_0 then
				local var_305_22 = Color.New(0, 0, 0)
				local var_305_23 = 0

				arg_302_1.mask_.enabled = false
				var_305_22.a = var_305_23
				arg_302_1.mask_.color = var_305_22
			end

			if arg_302_1.frameCnt_ <= 1 then
				arg_302_1.dialog_:SetActive(false)
			end

			local var_305_24 = 2
			local var_305_25 = 0.775

			if var_305_24 < arg_302_1.time_ and arg_302_1.time_ <= var_305_24 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0

				arg_302_1.dialog_:SetActive(true)

				arg_302_1.dialogCg_.alpha = 0

				local var_305_26 = LeanTween.value(arg_302_1.dialog_, 0, 1, 0.3)

				var_305_26:setOnUpdate(LuaHelper.FloatAction(function(arg_306_0)
					arg_302_1.dialogCg_.alpha = arg_306_0
				end))
				var_305_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_302_1.dialog_)
					var_305_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_302_1.duration_ = arg_302_1.duration_ + 0.3

				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_27 = arg_302_1:GetWordFromCfg(319971073)
				local var_305_28 = arg_302_1:FormatText(var_305_27.content)

				arg_302_1.text_.text = var_305_28

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_29 = 31
				local var_305_30 = utf8.len(var_305_28)
				local var_305_31 = var_305_29 <= 0 and var_305_25 or var_305_25 * (var_305_30 / var_305_29)

				if var_305_31 > 0 and var_305_25 < var_305_31 then
					arg_302_1.talkMaxDuration = var_305_31
					var_305_24 = var_305_24 + 0.3

					if var_305_31 + var_305_24 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_31 + var_305_24
					end
				end

				arg_302_1.text_.text = var_305_28
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_32 = var_305_24 + 0.3
			local var_305_33 = math.max(var_305_25, arg_302_1.talkMaxDuration)

			if var_305_32 <= arg_302_1.time_ and arg_302_1.time_ < var_305_32 + var_305_33 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_32) / var_305_33

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_32 + var_305_33 and arg_302_1.time_ < var_305_32 + var_305_33 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play319971074 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 319971074
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play319971075(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = 0
			local var_311_1 = 0.575

			if var_311_0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_0 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_2 = arg_308_1:GetWordFromCfg(319971074)
				local var_311_3 = arg_308_1:FormatText(var_311_2.content)

				arg_308_1.text_.text = var_311_3

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_4 = 23
				local var_311_5 = utf8.len(var_311_3)
				local var_311_6 = var_311_4 <= 0 and var_311_1 or var_311_1 * (var_311_5 / var_311_4)

				if var_311_6 > 0 and var_311_1 < var_311_6 then
					arg_308_1.talkMaxDuration = var_311_6

					if var_311_6 + var_311_0 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_6 + var_311_0
					end
				end

				arg_308_1.text_.text = var_311_3
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_7 = math.max(var_311_1, arg_308_1.talkMaxDuration)

			if var_311_0 <= arg_308_1.time_ and arg_308_1.time_ < var_311_0 + var_311_7 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_0) / var_311_7

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_0 + var_311_7 and arg_308_1.time_ < var_311_0 + var_311_7 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play319971075 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 319971075
		arg_312_1.duration_ = 5.3

		local var_312_0 = {
			zh = 5.3,
			ja = 4.533
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play319971076(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = "10014ui_story"

			if arg_312_1.actors_[var_315_0] == nil then
				local var_315_1 = Asset.Load("Char/" .. "10014ui_story")

				if not isNil(var_315_1) then
					local var_315_2 = Object.Instantiate(Asset.Load("Char/" .. "10014ui_story"), arg_312_1.stage_.transform)

					var_315_2.name = var_315_0
					var_315_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_312_1.actors_[var_315_0] = var_315_2

					local var_315_3 = var_315_2:GetComponentInChildren(typeof(CharacterEffect))

					var_315_3.enabled = true

					local var_315_4 = GameObjectTools.GetOrAddComponent(var_315_2, typeof(DynamicBoneHelper))

					if var_315_4 then
						var_315_4:EnableDynamicBone(false)
					end

					arg_312_1:ShowWeapon(var_315_3.transform, false)

					arg_312_1.var_[var_315_0 .. "Animator"] = var_315_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_312_1.var_[var_315_0 .. "Animator"].applyRootMotion = true
					arg_312_1.var_[var_315_0 .. "LipSync"] = var_315_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_315_5 = arg_312_1.actors_["10014ui_story"].transform
			local var_315_6 = 0

			if var_315_6 < arg_312_1.time_ and arg_312_1.time_ <= var_315_6 + arg_315_0 then
				arg_312_1.var_.moveOldPos10014ui_story = var_315_5.localPosition
			end

			local var_315_7 = 0.001

			if var_315_6 <= arg_312_1.time_ and arg_312_1.time_ < var_315_6 + var_315_7 then
				local var_315_8 = (arg_312_1.time_ - var_315_6) / var_315_7
				local var_315_9 = Vector3.New(0, -1.06, -6.2)

				var_315_5.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10014ui_story, var_315_9, var_315_8)

				local var_315_10 = manager.ui.mainCamera.transform.position - var_315_5.position

				var_315_5.forward = Vector3.New(var_315_10.x, var_315_10.y, var_315_10.z)

				local var_315_11 = var_315_5.localEulerAngles

				var_315_11.z = 0
				var_315_11.x = 0
				var_315_5.localEulerAngles = var_315_11
			end

			if arg_312_1.time_ >= var_315_6 + var_315_7 and arg_312_1.time_ < var_315_6 + var_315_7 + arg_315_0 then
				var_315_5.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_315_12 = manager.ui.mainCamera.transform.position - var_315_5.position

				var_315_5.forward = Vector3.New(var_315_12.x, var_315_12.y, var_315_12.z)

				local var_315_13 = var_315_5.localEulerAngles

				var_315_13.z = 0
				var_315_13.x = 0
				var_315_5.localEulerAngles = var_315_13
			end

			local var_315_14 = arg_312_1.actors_["10014ui_story"]
			local var_315_15 = 0

			if var_315_15 < arg_312_1.time_ and arg_312_1.time_ <= var_315_15 + arg_315_0 and not isNil(var_315_14) and arg_312_1.var_.characterEffect10014ui_story == nil then
				arg_312_1.var_.characterEffect10014ui_story = var_315_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_16 = 0.200000002980232

			if var_315_15 <= arg_312_1.time_ and arg_312_1.time_ < var_315_15 + var_315_16 and not isNil(var_315_14) then
				local var_315_17 = (arg_312_1.time_ - var_315_15) / var_315_16

				if arg_312_1.var_.characterEffect10014ui_story and not isNil(var_315_14) then
					arg_312_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= var_315_15 + var_315_16 and arg_312_1.time_ < var_315_15 + var_315_16 + arg_315_0 and not isNil(var_315_14) and arg_312_1.var_.characterEffect10014ui_story then
				arg_312_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_315_18 = 0

			if var_315_18 < arg_312_1.time_ and arg_312_1.time_ <= var_315_18 + arg_315_0 then
				arg_312_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			local var_315_19 = 0

			if var_315_19 < arg_312_1.time_ and arg_312_1.time_ <= var_315_19 + arg_315_0 then
				arg_312_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_315_20 = 0
			local var_315_21 = 0.275

			if var_315_20 < arg_312_1.time_ and arg_312_1.time_ <= var_315_20 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_22 = arg_312_1:FormatText(StoryNameCfg[264].name)

				arg_312_1.leftNameTxt_.text = var_315_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_23 = arg_312_1:GetWordFromCfg(319971075)
				local var_315_24 = arg_312_1:FormatText(var_315_23.content)

				arg_312_1.text_.text = var_315_24

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_25 = 11
				local var_315_26 = utf8.len(var_315_24)
				local var_315_27 = var_315_25 <= 0 and var_315_21 or var_315_21 * (var_315_26 / var_315_25)

				if var_315_27 > 0 and var_315_21 < var_315_27 then
					arg_312_1.talkMaxDuration = var_315_27

					if var_315_27 + var_315_20 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_27 + var_315_20
					end
				end

				arg_312_1.text_.text = var_315_24
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319971", "319971075", "story_v_out_319971.awb") ~= 0 then
					local var_315_28 = manager.audio:GetVoiceLength("story_v_out_319971", "319971075", "story_v_out_319971.awb") / 1000

					if var_315_28 + var_315_20 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_28 + var_315_20
					end

					if var_315_23.prefab_name ~= "" and arg_312_1.actors_[var_315_23.prefab_name] ~= nil then
						local var_315_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_23.prefab_name].transform, "story_v_out_319971", "319971075", "story_v_out_319971.awb")

						arg_312_1:RecordAudio("319971075", var_315_29)
						arg_312_1:RecordAudio("319971075", var_315_29)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_319971", "319971075", "story_v_out_319971.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_319971", "319971075", "story_v_out_319971.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_30 = math.max(var_315_21, arg_312_1.talkMaxDuration)

			if var_315_20 <= arg_312_1.time_ and arg_312_1.time_ < var_315_20 + var_315_30 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_20) / var_315_30

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_20 + var_315_30 and arg_312_1.time_ < var_315_20 + var_315_30 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10014ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play319971076 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 319971076
		arg_316_1.duration_ = 5

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play319971077(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = arg_316_1.actors_["10014ui_story"]
			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect10014ui_story == nil then
				arg_316_1.var_.characterEffect10014ui_story = var_319_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_2 = 0.200000002980232

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_2 and not isNil(var_319_0) then
				local var_319_3 = (arg_316_1.time_ - var_319_1) / var_319_2

				if arg_316_1.var_.characterEffect10014ui_story and not isNil(var_319_0) then
					local var_319_4 = Mathf.Lerp(0, 0.5, var_319_3)

					arg_316_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_316_1.var_.characterEffect10014ui_story.fillRatio = var_319_4
				end
			end

			if arg_316_1.time_ >= var_319_1 + var_319_2 and arg_316_1.time_ < var_319_1 + var_319_2 + arg_319_0 and not isNil(var_319_0) and arg_316_1.var_.characterEffect10014ui_story then
				local var_319_5 = 0.5

				arg_316_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_316_1.var_.characterEffect10014ui_story.fillRatio = var_319_5
			end

			local var_319_6 = 0
			local var_319_7 = 0.85

			if var_319_6 < arg_316_1.time_ and arg_316_1.time_ <= var_319_6 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, false)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_8 = arg_316_1:GetWordFromCfg(319971076)
				local var_319_9 = arg_316_1:FormatText(var_319_8.content)

				arg_316_1.text_.text = var_319_9

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_10 = 34
				local var_319_11 = utf8.len(var_319_9)
				local var_319_12 = var_319_10 <= 0 and var_319_7 or var_319_7 * (var_319_11 / var_319_10)

				if var_319_12 > 0 and var_319_7 < var_319_12 then
					arg_316_1.talkMaxDuration = var_319_12

					if var_319_12 + var_319_6 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_12 + var_319_6
					end
				end

				arg_316_1.text_.text = var_319_9
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)
				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_13 = math.max(var_319_7, arg_316_1.talkMaxDuration)

			if var_319_6 <= arg_316_1.time_ and arg_316_1.time_ < var_319_6 + var_319_13 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_6) / var_319_13

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_6 + var_319_13 and arg_316_1.time_ < var_319_6 + var_319_13 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play319971077 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 319971077
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play319971078(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = 0
			local var_323_1 = 0.775

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

				local var_323_2 = arg_320_1:GetWordFromCfg(319971077)
				local var_323_3 = arg_320_1:FormatText(var_323_2.content)

				arg_320_1.text_.text = var_323_3

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_4 = 31
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
	Play319971078 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 319971078
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play319971079(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0
			local var_327_1 = 1.475

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

				local var_327_2 = arg_324_1:GetWordFromCfg(319971078)
				local var_327_3 = arg_324_1:FormatText(var_327_2.content)

				arg_324_1.text_.text = var_327_3

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_4 = 59
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
	Play319971079 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 319971079
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
			arg_328_1.auto_ = false
		end

		function arg_328_1.playNext_(arg_330_0)
			arg_328_1.onStoryFinished_()
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = 0
			local var_331_1 = 0.7

			if var_331_0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_0 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, false)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_2 = arg_328_1:GetWordFromCfg(319971079)
				local var_331_3 = arg_328_1:FormatText(var_331_2.content)

				arg_328_1.text_.text = var_331_3

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_4 = 28
				local var_331_5 = utf8.len(var_331_3)
				local var_331_6 = var_331_4 <= 0 and var_331_1 or var_331_1 * (var_331_5 / var_331_4)

				if var_331_6 > 0 and var_331_1 < var_331_6 then
					arg_328_1.talkMaxDuration = var_331_6

					if var_331_6 + var_331_0 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_6 + var_331_0
					end
				end

				arg_328_1.text_.text = var_331_3
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_7 = math.max(var_331_1, arg_328_1.talkMaxDuration)

			if var_331_0 <= arg_328_1.time_ and arg_328_1.time_ < var_331_0 + var_331_7 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_0) / var_331_7

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_0 + var_331_7 and arg_328_1.time_ < var_331_0 + var_331_7 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST07a",
		"TextureConfig/Background/ML0210",
		"TextureConfig/Background/L01f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST69"
	},
	voices = {
		"story_v_out_319971.awb"
	}
}
