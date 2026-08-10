return {
	Play322211001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322211001
		arg_1_1.duration_ = 4.27

		local var_1_0 = {
			zh = 4.266,
			ja = 4.133
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
				arg_1_0:Play322211002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = 2

			if var_4_0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_0 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_1 = 0.2

			if arg_1_1.time_ >= var_4_0 + var_4_1 and arg_1_1.time_ < var_4_0 + var_4_1 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_2 = "L09f"

			if arg_1_1.bgs_[var_4_2] == nil then
				local var_4_3 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_3:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_2)
				var_4_3.name = var_4_2
				var_4_3.transform.parent = arg_1_1.stage_.transform
				var_4_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_2] = var_4_3
			end

			local var_4_4 = 0

			if var_4_4 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				local var_4_5 = manager.ui.mainCamera.transform.localPosition
				local var_4_6 = Vector3.New(0, 0, 10) + Vector3.New(var_4_5.x, var_4_5.y, 0)
				local var_4_7 = arg_1_1.bgs_.L09f

				var_4_7.transform.localPosition = var_4_6
				var_4_7.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_8 = var_4_7:GetComponent("SpriteRenderer")

				if var_4_8 and var_4_8.sprite then
					local var_4_9 = (var_4_7.transform.localPosition - var_4_5).z
					local var_4_10 = manager.ui.mainCameraCom_
					local var_4_11 = 2 * var_4_9 * Mathf.Tan(var_4_10.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_12 = var_4_11 * var_4_10.aspect
					local var_4_13 = var_4_8.sprite.bounds.size.x
					local var_4_14 = var_4_8.sprite.bounds.size.y
					local var_4_15 = var_4_12 / var_4_13
					local var_4_16 = var_4_11 / var_4_14
					local var_4_17 = var_4_16 < var_4_15 and var_4_15 or var_4_16

					var_4_7.transform.localScale = Vector3.New(var_4_17, var_4_17, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L09f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			local var_4_24 = "1111ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1111ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1111ui_story"].transform
			local var_4_30 = 2

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1111ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -0.87, -5.7)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1111ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1111ui_story"]
			local var_4_39 = 2

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1111ui_story == nil then
				arg_1_1.var_.characterEffect1111ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1111ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1111ui_story then
				arg_1_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_4_42 = 2

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_4_43 = 2

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_4_44 = 0.2
			local var_4_45 = 1

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				local var_4_46 = "play"
				local var_4_47 = "effect"

				arg_1_1:AudioAction(var_4_46, var_4_47, "se_story_145", "se_story_145_amb_dark_L09", "")
			end

			local var_4_48 = 0
			local var_4_49 = 0.3

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			local var_4_54 = 0.466666666666667
			local var_4_55 = 1

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				local var_4_56 = "play"
				local var_4_57 = "music"

				arg_1_1:AudioAction(var_4_56, var_4_57, "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source.awb")

				local var_4_58 = ""
				local var_4_59 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "bgm_activity_4_5_story_source")

				if var_4_59 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_59 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_59

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_59
						arg_1_1.bgmTxt2_.text = var_4_59
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

			local var_4_60 = 0.47
			local var_4_61 = 1

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				local var_4_62 = "play"
				local var_4_63 = "music"

				arg_1_1:AudioAction(var_4_62, var_4_63, "bgm_activity_4_5_story_source", "init_story", "bgm_activity_4_5_story_source.awb")

				local var_4_64 = ""
				local var_4_65 = manager.audio:GetAudioName("bgm_activity_4_5_story_source", "init_story")

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

			local var_4_66 = 2
			local var_4_67 = 0.2

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

				local var_4_69 = arg_1_1:FormatText(StoryNameCfg[67].name)

				arg_1_1.leftNameTxt_.text = var_4_69

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_70 = arg_1_1:GetWordFromCfg(322211001)
				local var_4_71 = arg_1_1:FormatText(var_4_70.content)

				arg_1_1.text_.text = var_4_71

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_72 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211001", "story_v_out_322211.awb") ~= 0 then
					local var_4_75 = manager.audio:GetVoiceLength("story_v_out_322211", "322211001", "story_v_out_322211.awb") / 1000

					if var_4_75 + var_4_66 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_75 + var_4_66
					end

					if var_4_70.prefab_name ~= "" and arg_1_1.actors_[var_4_70.prefab_name] ~= nil then
						local var_4_76 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_70.prefab_name].transform, "story_v_out_322211", "322211001", "story_v_out_322211.awb")

						arg_1_1:RecordAudio("322211001", var_4_76)
						arg_1_1:RecordAudio("322211001", var_4_76)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322211", "322211001", "story_v_out_322211.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322211", "322211001", "story_v_out_322211.awb")
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
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play322211002 = function(arg_10_0, arg_10_1)
		arg_10_1.time_ = 0
		arg_10_1.frameCnt_ = 0
		arg_10_1.state_ = "playing"
		arg_10_1.curTalkId_ = 322211002
		arg_10_1.duration_ = 5

		SetActive(arg_10_1.tipsGo_, false)

		function arg_10_1.onSingleLineFinish_()
			arg_10_1.onSingleLineUpdate_ = nil
			arg_10_1.onSingleLineFinish_ = nil
			arg_10_1.state_ = "waiting"
		end

		function arg_10_1.playNext_(arg_12_0)
			if arg_12_0 == 1 then
				arg_10_0:Play322211003(arg_10_1)
			end
		end

		function arg_10_1.onSingleLineUpdate_(arg_13_0)
			local var_13_0 = arg_10_1.actors_["1111ui_story"].transform
			local var_13_1 = 0

			if var_13_1 < arg_10_1.time_ and arg_10_1.time_ <= var_13_1 + arg_13_0 then
				arg_10_1.var_.moveOldPos1111ui_story = var_13_0.localPosition
			end

			local var_13_2 = 0.001

			if var_13_1 <= arg_10_1.time_ and arg_10_1.time_ < var_13_1 + var_13_2 then
				local var_13_3 = (arg_10_1.time_ - var_13_1) / var_13_2
				local var_13_4 = Vector3.New(0, 100, 0)

				var_13_0.localPosition = Vector3.Lerp(arg_10_1.var_.moveOldPos1111ui_story, var_13_4, var_13_3)

				local var_13_5 = manager.ui.mainCamera.transform.position - var_13_0.position

				var_13_0.forward = Vector3.New(var_13_5.x, var_13_5.y, var_13_5.z)

				local var_13_6 = var_13_0.localEulerAngles

				var_13_6.z = 0
				var_13_6.x = 0
				var_13_0.localEulerAngles = var_13_6
			end

			if arg_10_1.time_ >= var_13_1 + var_13_2 and arg_10_1.time_ < var_13_1 + var_13_2 + arg_13_0 then
				var_13_0.localPosition = Vector3.New(0, 100, 0)

				local var_13_7 = manager.ui.mainCamera.transform.position - var_13_0.position

				var_13_0.forward = Vector3.New(var_13_7.x, var_13_7.y, var_13_7.z)

				local var_13_8 = var_13_0.localEulerAngles

				var_13_8.z = 0
				var_13_8.x = 0
				var_13_0.localEulerAngles = var_13_8
			end

			local var_13_9 = 0
			local var_13_10 = 1.225

			if var_13_9 < arg_10_1.time_ and arg_10_1.time_ <= var_13_9 + arg_13_0 then
				arg_10_1.talkMaxDuration = 0
				arg_10_1.dialogCg_.alpha = 1

				arg_10_1.dialog_:SetActive(true)
				SetActive(arg_10_1.leftNameGo_, false)

				arg_10_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_10_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_10_1:RecordName(arg_10_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_10_1.iconTrs_.gameObject, false)
				arg_10_1.callingController_:SetSelectedState("normal")

				local var_13_11 = arg_10_1:GetWordFromCfg(322211002)
				local var_13_12 = arg_10_1:FormatText(var_13_11.content)

				arg_10_1.text_.text = var_13_12

				LuaForUtil.ClearLinePrefixSymbol(arg_10_1.text_)

				local var_13_13 = 49
				local var_13_14 = utf8.len(var_13_12)
				local var_13_15 = var_13_13 <= 0 and var_13_10 or var_13_10 * (var_13_14 / var_13_13)

				if var_13_15 > 0 and var_13_10 < var_13_15 then
					arg_10_1.talkMaxDuration = var_13_15

					if var_13_15 + var_13_9 > arg_10_1.duration_ then
						arg_10_1.duration_ = var_13_15 + var_13_9
					end
				end

				arg_10_1.text_.text = var_13_12
				arg_10_1.typewritter.percent = 0

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(false)
				arg_10_1:RecordContent(arg_10_1.text_.text)
			end

			local var_13_16 = math.max(var_13_10, arg_10_1.talkMaxDuration)

			if var_13_9 <= arg_10_1.time_ and arg_10_1.time_ < var_13_9 + var_13_16 then
				arg_10_1.typewritter.percent = (arg_10_1.time_ - var_13_9) / var_13_16

				arg_10_1.typewritter:SetDirty()
			end

			if arg_10_1.time_ >= var_13_9 + var_13_16 and arg_10_1.time_ < var_13_9 + var_13_16 + arg_13_0 then
				arg_10_1.typewritter.percent = 1

				arg_10_1.typewritter:SetDirty()
				arg_10_1:ShowNextGo(true)
			end
		end

		arg_10_1.nodeConfigList_ = {
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
	Play322211003 = function(arg_14_0, arg_14_1)
		arg_14_1.time_ = 0
		arg_14_1.frameCnt_ = 0
		arg_14_1.state_ = "playing"
		arg_14_1.curTalkId_ = 322211003
		arg_14_1.duration_ = 6.3

		local var_14_0 = {
			zh = 4.5,
			ja = 6.3
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
				arg_14_0:Play322211004(arg_14_1)
			end
		end

		function arg_14_1.onSingleLineUpdate_(arg_17_0)
			local var_17_0 = arg_14_1.actors_["1111ui_story"].transform
			local var_17_1 = 0

			if var_17_1 < arg_14_1.time_ and arg_14_1.time_ <= var_17_1 + arg_17_0 then
				arg_14_1.var_.moveOldPos1111ui_story = var_17_0.localPosition
			end

			local var_17_2 = 0.001

			if var_17_1 <= arg_14_1.time_ and arg_14_1.time_ < var_17_1 + var_17_2 then
				local var_17_3 = (arg_14_1.time_ - var_17_1) / var_17_2
				local var_17_4 = Vector3.New(0, -0.87, -5.7)

				var_17_0.localPosition = Vector3.Lerp(arg_14_1.var_.moveOldPos1111ui_story, var_17_4, var_17_3)

				local var_17_5 = manager.ui.mainCamera.transform.position - var_17_0.position

				var_17_0.forward = Vector3.New(var_17_5.x, var_17_5.y, var_17_5.z)

				local var_17_6 = var_17_0.localEulerAngles

				var_17_6.z = 0
				var_17_6.x = 0
				var_17_0.localEulerAngles = var_17_6
			end

			if arg_14_1.time_ >= var_17_1 + var_17_2 and arg_14_1.time_ < var_17_1 + var_17_2 + arg_17_0 then
				var_17_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_17_7 = manager.ui.mainCamera.transform.position - var_17_0.position

				var_17_0.forward = Vector3.New(var_17_7.x, var_17_7.y, var_17_7.z)

				local var_17_8 = var_17_0.localEulerAngles

				var_17_8.z = 0
				var_17_8.x = 0
				var_17_0.localEulerAngles = var_17_8
			end

			local var_17_9 = arg_14_1.actors_["1111ui_story"]
			local var_17_10 = 0

			if var_17_10 < arg_14_1.time_ and arg_14_1.time_ <= var_17_10 + arg_17_0 and not isNil(var_17_9) and arg_14_1.var_.characterEffect1111ui_story == nil then
				arg_14_1.var_.characterEffect1111ui_story = var_17_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_17_11 = 0.200000002980232

			if var_17_10 <= arg_14_1.time_ and arg_14_1.time_ < var_17_10 + var_17_11 and not isNil(var_17_9) then
				local var_17_12 = (arg_14_1.time_ - var_17_10) / var_17_11

				if arg_14_1.var_.characterEffect1111ui_story and not isNil(var_17_9) then
					arg_14_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_14_1.time_ >= var_17_10 + var_17_11 and arg_14_1.time_ < var_17_10 + var_17_11 + arg_17_0 and not isNil(var_17_9) and arg_14_1.var_.characterEffect1111ui_story then
				arg_14_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_17_13 = 0

			if var_17_13 < arg_14_1.time_ and arg_14_1.time_ <= var_17_13 + arg_17_0 then
				arg_14_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_17_14 = 0

			if var_17_14 < arg_14_1.time_ and arg_14_1.time_ <= var_17_14 + arg_17_0 then
				arg_14_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_17_15 = 0
			local var_17_16 = 0.525

			if var_17_15 < arg_14_1.time_ and arg_14_1.time_ <= var_17_15 + arg_17_0 then
				arg_14_1.talkMaxDuration = 0
				arg_14_1.dialogCg_.alpha = 1

				arg_14_1.dialog_:SetActive(true)
				SetActive(arg_14_1.leftNameGo_, true)

				local var_17_17 = arg_14_1:FormatText(StoryNameCfg[67].name)

				arg_14_1.leftNameTxt_.text = var_17_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_14_1.leftNameTxt_.transform)

				arg_14_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_14_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_14_1:RecordName(arg_14_1.leftNameTxt_.text)
				SetActive(arg_14_1.iconTrs_.gameObject, false)
				arg_14_1.callingController_:SetSelectedState("normal")

				local var_17_18 = arg_14_1:GetWordFromCfg(322211003)
				local var_17_19 = arg_14_1:FormatText(var_17_18.content)

				arg_14_1.text_.text = var_17_19

				LuaForUtil.ClearLinePrefixSymbol(arg_14_1.text_)

				local var_17_20 = 21
				local var_17_21 = utf8.len(var_17_19)
				local var_17_22 = var_17_20 <= 0 and var_17_16 or var_17_16 * (var_17_21 / var_17_20)

				if var_17_22 > 0 and var_17_16 < var_17_22 then
					arg_14_1.talkMaxDuration = var_17_22

					if var_17_22 + var_17_15 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_22 + var_17_15
					end
				end

				arg_14_1.text_.text = var_17_19
				arg_14_1.typewritter.percent = 0

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211003", "story_v_out_322211.awb") ~= 0 then
					local var_17_23 = manager.audio:GetVoiceLength("story_v_out_322211", "322211003", "story_v_out_322211.awb") / 1000

					if var_17_23 + var_17_15 > arg_14_1.duration_ then
						arg_14_1.duration_ = var_17_23 + var_17_15
					end

					if var_17_18.prefab_name ~= "" and arg_14_1.actors_[var_17_18.prefab_name] ~= nil then
						local var_17_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_14_1.actors_[var_17_18.prefab_name].transform, "story_v_out_322211", "322211003", "story_v_out_322211.awb")

						arg_14_1:RecordAudio("322211003", var_17_24)
						arg_14_1:RecordAudio("322211003", var_17_24)
					else
						arg_14_1:AudioAction("play", "voice", "story_v_out_322211", "322211003", "story_v_out_322211.awb")
					end

					arg_14_1:RecordHistoryTalkVoice("story_v_out_322211", "322211003", "story_v_out_322211.awb")
				end

				arg_14_1:RecordContent(arg_14_1.text_.text)
			end

			local var_17_25 = math.max(var_17_16, arg_14_1.talkMaxDuration)

			if var_17_15 <= arg_14_1.time_ and arg_14_1.time_ < var_17_15 + var_17_25 then
				arg_14_1.typewritter.percent = (arg_14_1.time_ - var_17_15) / var_17_25

				arg_14_1.typewritter:SetDirty()
			end

			if arg_14_1.time_ >= var_17_15 + var_17_25 and arg_14_1.time_ < var_17_15 + var_17_25 + arg_17_0 then
				arg_14_1.typewritter.percent = 1

				arg_14_1.typewritter:SetDirty()
				arg_14_1:ShowNextGo(true)
			end
		end

		arg_14_1.nodeConfigList_ = {
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

		arg_14_1:InitPlayNodeList()
	end,
	Play322211004 = function(arg_18_0, arg_18_1)
		arg_18_1.time_ = 0
		arg_18_1.frameCnt_ = 0
		arg_18_1.state_ = "playing"
		arg_18_1.curTalkId_ = 322211004
		arg_18_1.duration_ = 2.97

		local var_18_0 = {
			zh = 2.966,
			ja = 2.133
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
				arg_18_0:Play322211005(arg_18_1)
			end
		end

		function arg_18_1.onSingleLineUpdate_(arg_21_0)
			local var_21_0 = "10131ui_story"

			if arg_18_1.actors_[var_21_0] == nil then
				local var_21_1 = Asset.Load("Char/" .. "10131ui_story")

				if not isNil(var_21_1) then
					local var_21_2 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_18_1.stage_.transform)

					var_21_2.name = var_21_0
					var_21_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_18_1.actors_[var_21_0] = var_21_2

					local var_21_3 = var_21_2:GetComponentInChildren(typeof(CharacterEffect))

					var_21_3.enabled = true

					local var_21_4 = GameObjectTools.GetOrAddComponent(var_21_2, typeof(DynamicBoneHelper))

					if var_21_4 then
						var_21_4:EnableDynamicBone(false)
					end

					arg_18_1:ShowWeapon(var_21_3.transform, false)

					arg_18_1.var_[var_21_0 .. "Animator"] = var_21_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_18_1.var_[var_21_0 .. "Animator"].applyRootMotion = true
					arg_18_1.var_[var_21_0 .. "LipSync"] = var_21_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_21_5 = arg_18_1.actors_["10131ui_story"].transform
			local var_21_6 = 0

			if var_21_6 < arg_18_1.time_ and arg_18_1.time_ <= var_21_6 + arg_21_0 then
				arg_18_1.var_.moveOldPos10131ui_story = var_21_5.localPosition
			end

			local var_21_7 = 0.001

			if var_21_6 <= arg_18_1.time_ and arg_18_1.time_ < var_21_6 + var_21_7 then
				local var_21_8 = (arg_18_1.time_ - var_21_6) / var_21_7
				local var_21_9 = Vector3.New(0.83, -0.96, -5.8)

				var_21_5.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos10131ui_story, var_21_9, var_21_8)

				local var_21_10 = manager.ui.mainCamera.transform.position - var_21_5.position

				var_21_5.forward = Vector3.New(var_21_10.x, var_21_10.y, var_21_10.z)

				local var_21_11 = var_21_5.localEulerAngles

				var_21_11.z = 0
				var_21_11.x = 0
				var_21_5.localEulerAngles = var_21_11
			end

			if arg_18_1.time_ >= var_21_6 + var_21_7 and arg_18_1.time_ < var_21_6 + var_21_7 + arg_21_0 then
				var_21_5.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_21_12 = manager.ui.mainCamera.transform.position - var_21_5.position

				var_21_5.forward = Vector3.New(var_21_12.x, var_21_12.y, var_21_12.z)

				local var_21_13 = var_21_5.localEulerAngles

				var_21_13.z = 0
				var_21_13.x = 0
				var_21_5.localEulerAngles = var_21_13
			end

			local var_21_14 = arg_18_1.actors_["1111ui_story"].transform
			local var_21_15 = 0

			if var_21_15 < arg_18_1.time_ and arg_18_1.time_ <= var_21_15 + arg_21_0 then
				arg_18_1.var_.moveOldPos1111ui_story = var_21_14.localPosition
			end

			local var_21_16 = 0.001

			if var_21_15 <= arg_18_1.time_ and arg_18_1.time_ < var_21_15 + var_21_16 then
				local var_21_17 = (arg_18_1.time_ - var_21_15) / var_21_16
				local var_21_18 = Vector3.New(-0.79, -0.87, -5.7)

				var_21_14.localPosition = Vector3.Lerp(arg_18_1.var_.moveOldPos1111ui_story, var_21_18, var_21_17)

				local var_21_19 = manager.ui.mainCamera.transform.position - var_21_14.position

				var_21_14.forward = Vector3.New(var_21_19.x, var_21_19.y, var_21_19.z)

				local var_21_20 = var_21_14.localEulerAngles

				var_21_20.z = 0
				var_21_20.x = 0
				var_21_14.localEulerAngles = var_21_20
			end

			if arg_18_1.time_ >= var_21_15 + var_21_16 and arg_18_1.time_ < var_21_15 + var_21_16 + arg_21_0 then
				var_21_14.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_21_21 = manager.ui.mainCamera.transform.position - var_21_14.position

				var_21_14.forward = Vector3.New(var_21_21.x, var_21_21.y, var_21_21.z)

				local var_21_22 = var_21_14.localEulerAngles

				var_21_22.z = 0
				var_21_22.x = 0
				var_21_14.localEulerAngles = var_21_22
			end

			local var_21_23 = arg_18_1.actors_["10131ui_story"]
			local var_21_24 = 0

			if var_21_24 < arg_18_1.time_ and arg_18_1.time_ <= var_21_24 + arg_21_0 and not isNil(var_21_23) and arg_18_1.var_.characterEffect10131ui_story == nil then
				arg_18_1.var_.characterEffect10131ui_story = var_21_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_25 = 0.200000002980232

			if var_21_24 <= arg_18_1.time_ and arg_18_1.time_ < var_21_24 + var_21_25 and not isNil(var_21_23) then
				local var_21_26 = (arg_18_1.time_ - var_21_24) / var_21_25

				if arg_18_1.var_.characterEffect10131ui_story and not isNil(var_21_23) then
					arg_18_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_18_1.time_ >= var_21_24 + var_21_25 and arg_18_1.time_ < var_21_24 + var_21_25 + arg_21_0 and not isNil(var_21_23) and arg_18_1.var_.characterEffect10131ui_story then
				arg_18_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_21_27 = arg_18_1.actors_["1111ui_story"]
			local var_21_28 = 0

			if var_21_28 < arg_18_1.time_ and arg_18_1.time_ <= var_21_28 + arg_21_0 and not isNil(var_21_27) and arg_18_1.var_.characterEffect1111ui_story == nil then
				arg_18_1.var_.characterEffect1111ui_story = var_21_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_21_29 = 0.200000002980232

			if var_21_28 <= arg_18_1.time_ and arg_18_1.time_ < var_21_28 + var_21_29 and not isNil(var_21_27) then
				local var_21_30 = (arg_18_1.time_ - var_21_28) / var_21_29

				if arg_18_1.var_.characterEffect1111ui_story and not isNil(var_21_27) then
					local var_21_31 = Mathf.Lerp(0, 0.5, var_21_30)

					arg_18_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_18_1.var_.characterEffect1111ui_story.fillRatio = var_21_31
				end
			end

			if arg_18_1.time_ >= var_21_28 + var_21_29 and arg_18_1.time_ < var_21_28 + var_21_29 + arg_21_0 and not isNil(var_21_27) and arg_18_1.var_.characterEffect1111ui_story then
				local var_21_32 = 0.5

				arg_18_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_18_1.var_.characterEffect1111ui_story.fillRatio = var_21_32
			end

			local var_21_33 = 0

			if var_21_33 < arg_18_1.time_ and arg_18_1.time_ <= var_21_33 + arg_21_0 then
				arg_18_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_21_34 = 0

			if var_21_34 < arg_18_1.time_ and arg_18_1.time_ <= var_21_34 + arg_21_0 then
				arg_18_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_21_35 = 0
			local var_21_36 = 0.2

			if var_21_35 < arg_18_1.time_ and arg_18_1.time_ <= var_21_35 + arg_21_0 then
				arg_18_1.talkMaxDuration = 0
				arg_18_1.dialogCg_.alpha = 1

				arg_18_1.dialog_:SetActive(true)
				SetActive(arg_18_1.leftNameGo_, true)

				local var_21_37 = arg_18_1:FormatText(StoryNameCfg[1178].name)

				arg_18_1.leftNameTxt_.text = var_21_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_18_1.leftNameTxt_.transform)

				arg_18_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_18_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_18_1:RecordName(arg_18_1.leftNameTxt_.text)
				SetActive(arg_18_1.iconTrs_.gameObject, false)
				arg_18_1.callingController_:SetSelectedState("normal")

				local var_21_38 = arg_18_1:GetWordFromCfg(322211004)
				local var_21_39 = arg_18_1:FormatText(var_21_38.content)

				arg_18_1.text_.text = var_21_39

				LuaForUtil.ClearLinePrefixSymbol(arg_18_1.text_)

				local var_21_40 = 8
				local var_21_41 = utf8.len(var_21_39)
				local var_21_42 = var_21_40 <= 0 and var_21_36 or var_21_36 * (var_21_41 / var_21_40)

				if var_21_42 > 0 and var_21_36 < var_21_42 then
					arg_18_1.talkMaxDuration = var_21_42

					if var_21_42 + var_21_35 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_42 + var_21_35
					end
				end

				arg_18_1.text_.text = var_21_39
				arg_18_1.typewritter.percent = 0

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211004", "story_v_out_322211.awb") ~= 0 then
					local var_21_43 = manager.audio:GetVoiceLength("story_v_out_322211", "322211004", "story_v_out_322211.awb") / 1000

					if var_21_43 + var_21_35 > arg_18_1.duration_ then
						arg_18_1.duration_ = var_21_43 + var_21_35
					end

					if var_21_38.prefab_name ~= "" and arg_18_1.actors_[var_21_38.prefab_name] ~= nil then
						local var_21_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_18_1.actors_[var_21_38.prefab_name].transform, "story_v_out_322211", "322211004", "story_v_out_322211.awb")

						arg_18_1:RecordAudio("322211004", var_21_44)
						arg_18_1:RecordAudio("322211004", var_21_44)
					else
						arg_18_1:AudioAction("play", "voice", "story_v_out_322211", "322211004", "story_v_out_322211.awb")
					end

					arg_18_1:RecordHistoryTalkVoice("story_v_out_322211", "322211004", "story_v_out_322211.awb")
				end

				arg_18_1:RecordContent(arg_18_1.text_.text)
			end

			local var_21_45 = math.max(var_21_36, arg_18_1.talkMaxDuration)

			if var_21_35 <= arg_18_1.time_ and arg_18_1.time_ < var_21_35 + var_21_45 then
				arg_18_1.typewritter.percent = (arg_18_1.time_ - var_21_35) / var_21_45

				arg_18_1.typewritter:SetDirty()
			end

			if arg_18_1.time_ >= var_21_35 + var_21_45 and arg_18_1.time_ < var_21_35 + var_21_45 + arg_21_0 then
				arg_18_1.typewritter.percent = 1

				arg_18_1.typewritter:SetDirty()
				arg_18_1:ShowNextGo(true)
			end
		end

		arg_18_1.nodeConfigList_ = {
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

		arg_18_1:InitPlayNodeList()
	end,
	Play322211005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 322211005
		arg_22_1.duration_ = 3.3

		local var_22_0 = {
			zh = 2.633,
			ja = 3.3
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
				arg_22_0:Play322211006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = arg_22_1.actors_["1111ui_story"]
			local var_25_1 = 0

			if var_25_1 < arg_22_1.time_ and arg_22_1.time_ <= var_25_1 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1111ui_story == nil then
				arg_22_1.var_.characterEffect1111ui_story = var_25_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_2 = 0.200000002980232

			if var_25_1 <= arg_22_1.time_ and arg_22_1.time_ < var_25_1 + var_25_2 and not isNil(var_25_0) then
				local var_25_3 = (arg_22_1.time_ - var_25_1) / var_25_2

				if arg_22_1.var_.characterEffect1111ui_story and not isNil(var_25_0) then
					arg_22_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_22_1.time_ >= var_25_1 + var_25_2 and arg_22_1.time_ < var_25_1 + var_25_2 + arg_25_0 and not isNil(var_25_0) and arg_22_1.var_.characterEffect1111ui_story then
				arg_22_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_25_4 = arg_22_1.actors_["10131ui_story"]
			local var_25_5 = 0

			if var_25_5 < arg_22_1.time_ and arg_22_1.time_ <= var_25_5 + arg_25_0 and not isNil(var_25_4) and arg_22_1.var_.characterEffect10131ui_story == nil then
				arg_22_1.var_.characterEffect10131ui_story = var_25_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_25_6 = 0.200000002980232

			if var_25_5 <= arg_22_1.time_ and arg_22_1.time_ < var_25_5 + var_25_6 and not isNil(var_25_4) then
				local var_25_7 = (arg_22_1.time_ - var_25_5) / var_25_6

				if arg_22_1.var_.characterEffect10131ui_story and not isNil(var_25_4) then
					local var_25_8 = Mathf.Lerp(0, 0.5, var_25_7)

					arg_22_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_22_1.var_.characterEffect10131ui_story.fillRatio = var_25_8
				end
			end

			if arg_22_1.time_ >= var_25_5 + var_25_6 and arg_22_1.time_ < var_25_5 + var_25_6 + arg_25_0 and not isNil(var_25_4) and arg_22_1.var_.characterEffect10131ui_story then
				local var_25_9 = 0.5

				arg_22_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_22_1.var_.characterEffect10131ui_story.fillRatio = var_25_9
			end

			local var_25_10 = 0

			if var_25_10 < arg_22_1.time_ and arg_22_1.time_ <= var_25_10 + arg_25_0 then
				arg_22_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_25_11 = 0
			local var_25_12 = 0.2

			if var_25_11 < arg_22_1.time_ and arg_22_1.time_ <= var_25_11 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_13 = arg_22_1:FormatText(StoryNameCfg[67].name)

				arg_22_1.leftNameTxt_.text = var_25_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_14 = arg_22_1:GetWordFromCfg(322211005)
				local var_25_15 = arg_22_1:FormatText(var_25_14.content)

				arg_22_1.text_.text = var_25_15

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_16 = 8
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

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211005", "story_v_out_322211.awb") ~= 0 then
					local var_25_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211005", "story_v_out_322211.awb") / 1000

					if var_25_19 + var_25_11 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_19 + var_25_11
					end

					if var_25_14.prefab_name ~= "" and arg_22_1.actors_[var_25_14.prefab_name] ~= nil then
						local var_25_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_14.prefab_name].transform, "story_v_out_322211", "322211005", "story_v_out_322211.awb")

						arg_22_1:RecordAudio("322211005", var_25_20)
						arg_22_1:RecordAudio("322211005", var_25_20)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_322211", "322211005", "story_v_out_322211.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_322211", "322211005", "story_v_out_322211.awb")
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
	Play322211006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 322211006
		arg_26_1.duration_ = 10.13

		local var_26_0 = {
			zh = 7.933,
			ja = 10.133
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
				arg_26_0:Play322211007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0

			if var_29_0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_0 + arg_29_0 then
				arg_26_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva", "EmotionTimelineAnimator")
			end

			local var_29_1 = 0
			local var_29_2 = 0.875

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_3 = arg_26_1:FormatText(StoryNameCfg[67].name)

				arg_26_1.leftNameTxt_.text = var_29_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_4 = arg_26_1:GetWordFromCfg(322211006)
				local var_29_5 = arg_26_1:FormatText(var_29_4.content)

				arg_26_1.text_.text = var_29_5

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_6 = 35
				local var_29_7 = utf8.len(var_29_5)
				local var_29_8 = var_29_6 <= 0 and var_29_2 or var_29_2 * (var_29_7 / var_29_6)

				if var_29_8 > 0 and var_29_2 < var_29_8 then
					arg_26_1.talkMaxDuration = var_29_8

					if var_29_8 + var_29_1 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_8 + var_29_1
					end
				end

				arg_26_1.text_.text = var_29_5
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211006", "story_v_out_322211.awb") ~= 0 then
					local var_29_9 = manager.audio:GetVoiceLength("story_v_out_322211", "322211006", "story_v_out_322211.awb") / 1000

					if var_29_9 + var_29_1 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_9 + var_29_1
					end

					if var_29_4.prefab_name ~= "" and arg_26_1.actors_[var_29_4.prefab_name] ~= nil then
						local var_29_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_4.prefab_name].transform, "story_v_out_322211", "322211006", "story_v_out_322211.awb")

						arg_26_1:RecordAudio("322211006", var_29_10)
						arg_26_1:RecordAudio("322211006", var_29_10)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_322211", "322211006", "story_v_out_322211.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_322211", "322211006", "story_v_out_322211.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_11 = math.max(var_29_2, arg_26_1.talkMaxDuration)

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_11 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_1) / var_29_11

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_1 + var_29_11 and arg_26_1.time_ < var_29_1 + var_29_11 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play322211007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 322211007
		arg_30_1.duration_ = 8.53

		local var_30_0 = {
			zh = 4.633,
			ja = 8.533
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
				arg_30_0:Play322211008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = 0
			local var_33_1 = 0.55

			if var_33_0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_0 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_2 = arg_30_1:FormatText(StoryNameCfg[67].name)

				arg_30_1.leftNameTxt_.text = var_33_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_3 = arg_30_1:GetWordFromCfg(322211007)
				local var_33_4 = arg_30_1:FormatText(var_33_3.content)

				arg_30_1.text_.text = var_33_4

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_5 = 22
				local var_33_6 = utf8.len(var_33_4)
				local var_33_7 = var_33_5 <= 0 and var_33_1 or var_33_1 * (var_33_6 / var_33_5)

				if var_33_7 > 0 and var_33_1 < var_33_7 then
					arg_30_1.talkMaxDuration = var_33_7

					if var_33_7 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_7 + var_33_0
					end
				end

				arg_30_1.text_.text = var_33_4
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211007", "story_v_out_322211.awb") ~= 0 then
					local var_33_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211007", "story_v_out_322211.awb") / 1000

					if var_33_8 + var_33_0 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_8 + var_33_0
					end

					if var_33_3.prefab_name ~= "" and arg_30_1.actors_[var_33_3.prefab_name] ~= nil then
						local var_33_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_3.prefab_name].transform, "story_v_out_322211", "322211007", "story_v_out_322211.awb")

						arg_30_1:RecordAudio("322211007", var_33_9)
						arg_30_1:RecordAudio("322211007", var_33_9)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_322211", "322211007", "story_v_out_322211.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_322211", "322211007", "story_v_out_322211.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_10 = math.max(var_33_1, arg_30_1.talkMaxDuration)

			if var_33_0 <= arg_30_1.time_ and arg_30_1.time_ < var_33_0 + var_33_10 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_0) / var_33_10

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_0 + var_33_10 and arg_30_1.time_ < var_33_0 + var_33_10 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play322211008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 322211008
		arg_34_1.duration_ = 3.83

		local var_34_0 = {
			zh = 3.133,
			ja = 3.833
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
				arg_34_0:Play322211009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["10131ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect10131ui_story == nil then
				arg_34_1.var_.characterEffect10131ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.200000002980232

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect10131ui_story and not isNil(var_37_0) then
					arg_34_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect10131ui_story then
				arg_34_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_37_4 = arg_34_1.actors_["1111ui_story"]
			local var_37_5 = 0

			if var_37_5 < arg_34_1.time_ and arg_34_1.time_ <= var_37_5 + arg_37_0 and not isNil(var_37_4) and arg_34_1.var_.characterEffect1111ui_story == nil then
				arg_34_1.var_.characterEffect1111ui_story = var_37_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_6 = 0.200000002980232

			if var_37_5 <= arg_34_1.time_ and arg_34_1.time_ < var_37_5 + var_37_6 and not isNil(var_37_4) then
				local var_37_7 = (arg_34_1.time_ - var_37_5) / var_37_6

				if arg_34_1.var_.characterEffect1111ui_story and not isNil(var_37_4) then
					local var_37_8 = Mathf.Lerp(0, 0.5, var_37_7)

					arg_34_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1111ui_story.fillRatio = var_37_8
				end
			end

			if arg_34_1.time_ >= var_37_5 + var_37_6 and arg_34_1.time_ < var_37_5 + var_37_6 + arg_37_0 and not isNil(var_37_4) and arg_34_1.var_.characterEffect1111ui_story then
				local var_37_9 = 0.5

				arg_34_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1111ui_story.fillRatio = var_37_9
			end

			local var_37_10 = 0

			if var_37_10 < arg_34_1.time_ and arg_34_1.time_ <= var_37_10 + arg_37_0 then
				arg_34_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_37_11 = 0

			if var_37_11 < arg_34_1.time_ and arg_34_1.time_ <= var_37_11 + arg_37_0 then
				arg_34_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_37_12 = 0
			local var_37_13 = 0.3

			if var_37_12 < arg_34_1.time_ and arg_34_1.time_ <= var_37_12 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_14 = arg_34_1:FormatText(StoryNameCfg[1178].name)

				arg_34_1.leftNameTxt_.text = var_37_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_15 = arg_34_1:GetWordFromCfg(322211008)
				local var_37_16 = arg_34_1:FormatText(var_37_15.content)

				arg_34_1.text_.text = var_37_16

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_17 = 12
				local var_37_18 = utf8.len(var_37_16)
				local var_37_19 = var_37_17 <= 0 and var_37_13 or var_37_13 * (var_37_18 / var_37_17)

				if var_37_19 > 0 and var_37_13 < var_37_19 then
					arg_34_1.talkMaxDuration = var_37_19

					if var_37_19 + var_37_12 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_19 + var_37_12
					end
				end

				arg_34_1.text_.text = var_37_16
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211008", "story_v_out_322211.awb") ~= 0 then
					local var_37_20 = manager.audio:GetVoiceLength("story_v_out_322211", "322211008", "story_v_out_322211.awb") / 1000

					if var_37_20 + var_37_12 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_20 + var_37_12
					end

					if var_37_15.prefab_name ~= "" and arg_34_1.actors_[var_37_15.prefab_name] ~= nil then
						local var_37_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_15.prefab_name].transform, "story_v_out_322211", "322211008", "story_v_out_322211.awb")

						arg_34_1:RecordAudio("322211008", var_37_21)
						arg_34_1:RecordAudio("322211008", var_37_21)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_322211", "322211008", "story_v_out_322211.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_322211", "322211008", "story_v_out_322211.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_22 = math.max(var_37_13, arg_34_1.talkMaxDuration)

			if var_37_12 <= arg_34_1.time_ and arg_34_1.time_ < var_37_12 + var_37_22 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_12) / var_37_22

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_12 + var_37_22 and arg_34_1.time_ < var_37_12 + var_37_22 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play322211009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 322211009
		arg_38_1.duration_ = 6.43

		local var_38_0 = {
			zh = 6.2,
			ja = 6.433
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
				arg_38_0:Play322211010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1111ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1111ui_story == nil then
				arg_38_1.var_.characterEffect1111ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.200000002980232

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect1111ui_story and not isNil(var_41_0) then
					arg_38_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1111ui_story then
				arg_38_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_41_4 = arg_38_1.actors_["10131ui_story"]
			local var_41_5 = 0

			if var_41_5 < arg_38_1.time_ and arg_38_1.time_ <= var_41_5 + arg_41_0 and not isNil(var_41_4) and arg_38_1.var_.characterEffect10131ui_story == nil then
				arg_38_1.var_.characterEffect10131ui_story = var_41_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_6 = 0.200000002980232

			if var_41_5 <= arg_38_1.time_ and arg_38_1.time_ < var_41_5 + var_41_6 and not isNil(var_41_4) then
				local var_41_7 = (arg_38_1.time_ - var_41_5) / var_41_6

				if arg_38_1.var_.characterEffect10131ui_story and not isNil(var_41_4) then
					local var_41_8 = Mathf.Lerp(0, 0.5, var_41_7)

					arg_38_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_38_1.var_.characterEffect10131ui_story.fillRatio = var_41_8
				end
			end

			if arg_38_1.time_ >= var_41_5 + var_41_6 and arg_38_1.time_ < var_41_5 + var_41_6 + arg_41_0 and not isNil(var_41_4) and arg_38_1.var_.characterEffect10131ui_story then
				local var_41_9 = 0.5

				arg_38_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_38_1.var_.characterEffect10131ui_story.fillRatio = var_41_9
			end

			local var_41_10 = 0

			if var_41_10 < arg_38_1.time_ and arg_38_1.time_ <= var_41_10 + arg_41_0 then
				arg_38_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_41_11 = 0
			local var_41_12 = 0.475

			if var_41_11 < arg_38_1.time_ and arg_38_1.time_ <= var_41_11 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_13 = arg_38_1:FormatText(StoryNameCfg[67].name)

				arg_38_1.leftNameTxt_.text = var_41_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_14 = arg_38_1:GetWordFromCfg(322211009)
				local var_41_15 = arg_38_1:FormatText(var_41_14.content)

				arg_38_1.text_.text = var_41_15

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_16 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211009", "story_v_out_322211.awb") ~= 0 then
					local var_41_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211009", "story_v_out_322211.awb") / 1000

					if var_41_19 + var_41_11 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_19 + var_41_11
					end

					if var_41_14.prefab_name ~= "" and arg_38_1.actors_[var_41_14.prefab_name] ~= nil then
						local var_41_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_14.prefab_name].transform, "story_v_out_322211", "322211009", "story_v_out_322211.awb")

						arg_38_1:RecordAudio("322211009", var_41_20)
						arg_38_1:RecordAudio("322211009", var_41_20)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_322211", "322211009", "story_v_out_322211.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_322211", "322211009", "story_v_out_322211.awb")
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
	Play322211010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 322211010
		arg_42_1.duration_ = 7.4

		local var_42_0 = {
			zh = 4.6,
			ja = 7.4
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
				arg_42_0:Play322211011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = arg_42_1.actors_["10131ui_story"]
			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect10131ui_story == nil then
				arg_42_1.var_.characterEffect10131ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.200000002980232

			if var_45_1 <= arg_42_1.time_ and arg_42_1.time_ < var_45_1 + var_45_2 and not isNil(var_45_0) then
				local var_45_3 = (arg_42_1.time_ - var_45_1) / var_45_2

				if arg_42_1.var_.characterEffect10131ui_story and not isNil(var_45_0) then
					arg_42_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_1 + var_45_2 and arg_42_1.time_ < var_45_1 + var_45_2 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect10131ui_story then
				arg_42_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_45_4 = arg_42_1.actors_["1111ui_story"]
			local var_45_5 = 0

			if var_45_5 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.characterEffect1111ui_story == nil then
				arg_42_1.var_.characterEffect1111ui_story = var_45_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_6 = 0.200000002980232

			if var_45_5 <= arg_42_1.time_ and arg_42_1.time_ < var_45_5 + var_45_6 and not isNil(var_45_4) then
				local var_45_7 = (arg_42_1.time_ - var_45_5) / var_45_6

				if arg_42_1.var_.characterEffect1111ui_story and not isNil(var_45_4) then
					local var_45_8 = Mathf.Lerp(0, 0.5, var_45_7)

					arg_42_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1111ui_story.fillRatio = var_45_8
				end
			end

			if arg_42_1.time_ >= var_45_5 + var_45_6 and arg_42_1.time_ < var_45_5 + var_45_6 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.characterEffect1111ui_story then
				local var_45_9 = 0.5

				arg_42_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1111ui_story.fillRatio = var_45_9
			end

			local var_45_10 = 0
			local var_45_11 = 0.425

			if var_45_10 < arg_42_1.time_ and arg_42_1.time_ <= var_45_10 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_12 = arg_42_1:FormatText(StoryNameCfg[1178].name)

				arg_42_1.leftNameTxt_.text = var_45_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_13 = arg_42_1:GetWordFromCfg(322211010)
				local var_45_14 = arg_42_1:FormatText(var_45_13.content)

				arg_42_1.text_.text = var_45_14

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_15 = 17
				local var_45_16 = utf8.len(var_45_14)
				local var_45_17 = var_45_15 <= 0 and var_45_11 or var_45_11 * (var_45_16 / var_45_15)

				if var_45_17 > 0 and var_45_11 < var_45_17 then
					arg_42_1.talkMaxDuration = var_45_17

					if var_45_17 + var_45_10 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_17 + var_45_10
					end
				end

				arg_42_1.text_.text = var_45_14
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211010", "story_v_out_322211.awb") ~= 0 then
					local var_45_18 = manager.audio:GetVoiceLength("story_v_out_322211", "322211010", "story_v_out_322211.awb") / 1000

					if var_45_18 + var_45_10 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_18 + var_45_10
					end

					if var_45_13.prefab_name ~= "" and arg_42_1.actors_[var_45_13.prefab_name] ~= nil then
						local var_45_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_13.prefab_name].transform, "story_v_out_322211", "322211010", "story_v_out_322211.awb")

						arg_42_1:RecordAudio("322211010", var_45_19)
						arg_42_1:RecordAudio("322211010", var_45_19)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_322211", "322211010", "story_v_out_322211.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_322211", "322211010", "story_v_out_322211.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_20 = math.max(var_45_11, arg_42_1.talkMaxDuration)

			if var_45_10 <= arg_42_1.time_ and arg_42_1.time_ < var_45_10 + var_45_20 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_10) / var_45_20

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_10 + var_45_20 and arg_42_1.time_ < var_45_10 + var_45_20 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play322211011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 322211011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play322211012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["10131ui_story"].transform
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 then
				arg_46_1.var_.moveOldPos10131ui_story = var_49_0.localPosition
			end

			local var_49_2 = 0.001

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2
				local var_49_4 = Vector3.New(0, 100, 0)

				var_49_0.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos10131ui_story, var_49_4, var_49_3)

				local var_49_5 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_5.x, var_49_5.y, var_49_5.z)

				local var_49_6 = var_49_0.localEulerAngles

				var_49_6.z = 0
				var_49_6.x = 0
				var_49_0.localEulerAngles = var_49_6
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 then
				var_49_0.localPosition = Vector3.New(0, 100, 0)

				local var_49_7 = manager.ui.mainCamera.transform.position - var_49_0.position

				var_49_0.forward = Vector3.New(var_49_7.x, var_49_7.y, var_49_7.z)

				local var_49_8 = var_49_0.localEulerAngles

				var_49_8.z = 0
				var_49_8.x = 0
				var_49_0.localEulerAngles = var_49_8
			end

			local var_49_9 = arg_46_1.actors_["1111ui_story"].transform
			local var_49_10 = 0

			if var_49_10 < arg_46_1.time_ and arg_46_1.time_ <= var_49_10 + arg_49_0 then
				arg_46_1.var_.moveOldPos1111ui_story = var_49_9.localPosition
			end

			local var_49_11 = 0.001

			if var_49_10 <= arg_46_1.time_ and arg_46_1.time_ < var_49_10 + var_49_11 then
				local var_49_12 = (arg_46_1.time_ - var_49_10) / var_49_11
				local var_49_13 = Vector3.New(0, 100, 0)

				var_49_9.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1111ui_story, var_49_13, var_49_12)

				local var_49_14 = manager.ui.mainCamera.transform.position - var_49_9.position

				var_49_9.forward = Vector3.New(var_49_14.x, var_49_14.y, var_49_14.z)

				local var_49_15 = var_49_9.localEulerAngles

				var_49_15.z = 0
				var_49_15.x = 0
				var_49_9.localEulerAngles = var_49_15
			end

			if arg_46_1.time_ >= var_49_10 + var_49_11 and arg_46_1.time_ < var_49_10 + var_49_11 + arg_49_0 then
				var_49_9.localPosition = Vector3.New(0, 100, 0)

				local var_49_16 = manager.ui.mainCamera.transform.position - var_49_9.position

				var_49_9.forward = Vector3.New(var_49_16.x, var_49_16.y, var_49_16.z)

				local var_49_17 = var_49_9.localEulerAngles

				var_49_17.z = 0
				var_49_17.x = 0
				var_49_9.localEulerAngles = var_49_17
			end

			local var_49_18 = 0.533333333333333
			local var_49_19 = 1

			if var_49_18 < arg_46_1.time_ and arg_46_1.time_ <= var_49_18 + arg_49_0 then
				local var_49_20 = "play"
				local var_49_21 = "effect"

				arg_46_1:AudioAction(var_49_20, var_49_21, "se_story_141", "se_story_141_footstep_upstairs", "")
			end

			local var_49_22 = 0
			local var_49_23 = 1.175

			if var_49_22 < arg_46_1.time_ and arg_46_1.time_ <= var_49_22 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_24 = arg_46_1:GetWordFromCfg(322211011)
				local var_49_25 = arg_46_1:FormatText(var_49_24.content)

				arg_46_1.text_.text = var_49_25

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_26 = 47
				local var_49_27 = utf8.len(var_49_25)
				local var_49_28 = var_49_26 <= 0 and var_49_23 or var_49_23 * (var_49_27 / var_49_26)

				if var_49_28 > 0 and var_49_23 < var_49_28 then
					arg_46_1.talkMaxDuration = var_49_28

					if var_49_28 + var_49_22 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_28 + var_49_22
					end
				end

				arg_46_1.text_.text = var_49_25
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_29 = math.max(var_49_23, arg_46_1.talkMaxDuration)

			if var_49_22 <= arg_46_1.time_ and arg_46_1.time_ < var_49_22 + var_49_29 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_22) / var_49_29

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_22 + var_49_29 and arg_46_1.time_ < var_49_22 + var_49_29 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
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

		arg_46_1:InitPlayNodeList()
	end,
	Play322211012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 322211012
		arg_50_1.duration_ = 2

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play322211013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = arg_50_1.actors_["1111ui_story"].transform
			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1.var_.moveOldPos1111ui_story = var_53_0.localPosition
			end

			local var_53_2 = 0.001

			if var_53_1 <= arg_50_1.time_ and arg_50_1.time_ < var_53_1 + var_53_2 then
				local var_53_3 = (arg_50_1.time_ - var_53_1) / var_53_2
				local var_53_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_53_0.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1111ui_story, var_53_4, var_53_3)

				local var_53_5 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_5.x, var_53_5.y, var_53_5.z)

				local var_53_6 = var_53_0.localEulerAngles

				var_53_6.z = 0
				var_53_6.x = 0
				var_53_0.localEulerAngles = var_53_6
			end

			if arg_50_1.time_ >= var_53_1 + var_53_2 and arg_50_1.time_ < var_53_1 + var_53_2 + arg_53_0 then
				var_53_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_53_7 = manager.ui.mainCamera.transform.position - var_53_0.position

				var_53_0.forward = Vector3.New(var_53_7.x, var_53_7.y, var_53_7.z)

				local var_53_8 = var_53_0.localEulerAngles

				var_53_8.z = 0
				var_53_8.x = 0
				var_53_0.localEulerAngles = var_53_8
			end

			local var_53_9 = arg_50_1.actors_["1111ui_story"]
			local var_53_10 = 0

			if var_53_10 < arg_50_1.time_ and arg_50_1.time_ <= var_53_10 + arg_53_0 and not isNil(var_53_9) and arg_50_1.var_.characterEffect1111ui_story == nil then
				arg_50_1.var_.characterEffect1111ui_story = var_53_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_11 = 0.200000002980232

			if var_53_10 <= arg_50_1.time_ and arg_50_1.time_ < var_53_10 + var_53_11 and not isNil(var_53_9) then
				local var_53_12 = (arg_50_1.time_ - var_53_10) / var_53_11

				if arg_50_1.var_.characterEffect1111ui_story and not isNil(var_53_9) then
					arg_50_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_10 + var_53_11 and arg_50_1.time_ < var_53_10 + var_53_11 + arg_53_0 and not isNil(var_53_9) and arg_50_1.var_.characterEffect1111ui_story then
				arg_50_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_53_13 = 0

			if var_53_13 < arg_50_1.time_ and arg_50_1.time_ <= var_53_13 + arg_53_0 then
				arg_50_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			local var_53_14 = 0

			if var_53_14 < arg_50_1.time_ and arg_50_1.time_ <= var_53_14 + arg_53_0 then
				arg_50_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_53_15 = 0
			local var_53_16 = 0.125

			if var_53_15 < arg_50_1.time_ and arg_50_1.time_ <= var_53_15 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_17 = arg_50_1:FormatText(StoryNameCfg[67].name)

				arg_50_1.leftNameTxt_.text = var_53_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_18 = arg_50_1:GetWordFromCfg(322211012)
				local var_53_19 = arg_50_1:FormatText(var_53_18.content)

				arg_50_1.text_.text = var_53_19

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_20 = 5
				local var_53_21 = utf8.len(var_53_19)
				local var_53_22 = var_53_20 <= 0 and var_53_16 or var_53_16 * (var_53_21 / var_53_20)

				if var_53_22 > 0 and var_53_16 < var_53_22 then
					arg_50_1.talkMaxDuration = var_53_22

					if var_53_22 + var_53_15 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_22 + var_53_15
					end
				end

				arg_50_1.text_.text = var_53_19
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211012", "story_v_out_322211.awb") ~= 0 then
					local var_53_23 = manager.audio:GetVoiceLength("story_v_out_322211", "322211012", "story_v_out_322211.awb") / 1000

					if var_53_23 + var_53_15 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_23 + var_53_15
					end

					if var_53_18.prefab_name ~= "" and arg_50_1.actors_[var_53_18.prefab_name] ~= nil then
						local var_53_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_18.prefab_name].transform, "story_v_out_322211", "322211012", "story_v_out_322211.awb")

						arg_50_1:RecordAudio("322211012", var_53_24)
						arg_50_1:RecordAudio("322211012", var_53_24)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_322211", "322211012", "story_v_out_322211.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_322211", "322211012", "story_v_out_322211.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_25 = math.max(var_53_16, arg_50_1.talkMaxDuration)

			if var_53_15 <= arg_50_1.time_ and arg_50_1.time_ < var_53_15 + var_53_25 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_15) / var_53_25

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_15 + var_53_25 and arg_50_1.time_ < var_53_15 + var_53_25 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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

		arg_50_1:InitPlayNodeList()
	end,
	Play322211013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 322211013
		arg_54_1.duration_ = 3.67

		local var_54_0 = {
			zh = 2.533,
			ja = 3.666
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
				arg_54_0:Play322211014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = "4037ui_story"

			if arg_54_1.actors_[var_57_0] == nil then
				local var_57_1 = Asset.Load("Char/" .. "4037ui_story")

				if not isNil(var_57_1) then
					local var_57_2 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_54_1.stage_.transform)

					var_57_2.name = var_57_0
					var_57_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_54_1.actors_[var_57_0] = var_57_2

					local var_57_3 = var_57_2:GetComponentInChildren(typeof(CharacterEffect))

					var_57_3.enabled = true

					local var_57_4 = GameObjectTools.GetOrAddComponent(var_57_2, typeof(DynamicBoneHelper))

					if var_57_4 then
						var_57_4:EnableDynamicBone(false)
					end

					arg_54_1:ShowWeapon(var_57_3.transform, false)

					arg_54_1.var_[var_57_0 .. "Animator"] = var_57_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_54_1.var_[var_57_0 .. "Animator"].applyRootMotion = true
					arg_54_1.var_[var_57_0 .. "LipSync"] = var_57_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_57_5 = arg_54_1.actors_["4037ui_story"].transform
			local var_57_6 = 0

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.var_.moveOldPos4037ui_story = var_57_5.localPosition
			end

			local var_57_7 = 0.001

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_7 then
				local var_57_8 = (arg_54_1.time_ - var_57_6) / var_57_7
				local var_57_9 = Vector3.New(0.7, -1.12, -6.2)

				var_57_5.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos4037ui_story, var_57_9, var_57_8)

				local var_57_10 = manager.ui.mainCamera.transform.position - var_57_5.position

				var_57_5.forward = Vector3.New(var_57_10.x, var_57_10.y, var_57_10.z)

				local var_57_11 = var_57_5.localEulerAngles

				var_57_11.z = 0
				var_57_11.x = 0
				var_57_5.localEulerAngles = var_57_11
			end

			if arg_54_1.time_ >= var_57_6 + var_57_7 and arg_54_1.time_ < var_57_6 + var_57_7 + arg_57_0 then
				var_57_5.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_57_12 = manager.ui.mainCamera.transform.position - var_57_5.position

				var_57_5.forward = Vector3.New(var_57_12.x, var_57_12.y, var_57_12.z)

				local var_57_13 = var_57_5.localEulerAngles

				var_57_13.z = 0
				var_57_13.x = 0
				var_57_5.localEulerAngles = var_57_13
			end

			local var_57_14 = arg_54_1.actors_["4037ui_story"]
			local var_57_15 = 0

			if var_57_15 < arg_54_1.time_ and arg_54_1.time_ <= var_57_15 + arg_57_0 and not isNil(var_57_14) and arg_54_1.var_.characterEffect4037ui_story == nil then
				arg_54_1.var_.characterEffect4037ui_story = var_57_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_16 = 0.200000002980232

			if var_57_15 <= arg_54_1.time_ and arg_54_1.time_ < var_57_15 + var_57_16 and not isNil(var_57_14) then
				local var_57_17 = (arg_54_1.time_ - var_57_15) / var_57_16

				if arg_54_1.var_.characterEffect4037ui_story and not isNil(var_57_14) then
					arg_54_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= var_57_15 + var_57_16 and arg_54_1.time_ < var_57_15 + var_57_16 + arg_57_0 and not isNil(var_57_14) and arg_54_1.var_.characterEffect4037ui_story then
				arg_54_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_57_18 = arg_54_1.actors_["1111ui_story"]
			local var_57_19 = 0

			if var_57_19 < arg_54_1.time_ and arg_54_1.time_ <= var_57_19 + arg_57_0 and not isNil(var_57_18) and arg_54_1.var_.characterEffect1111ui_story == nil then
				arg_54_1.var_.characterEffect1111ui_story = var_57_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_20 = 0.200000002980232

			if var_57_19 <= arg_54_1.time_ and arg_54_1.time_ < var_57_19 + var_57_20 and not isNil(var_57_18) then
				local var_57_21 = (arg_54_1.time_ - var_57_19) / var_57_20

				if arg_54_1.var_.characterEffect1111ui_story and not isNil(var_57_18) then
					local var_57_22 = Mathf.Lerp(0, 0.5, var_57_21)

					arg_54_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1111ui_story.fillRatio = var_57_22
				end
			end

			if arg_54_1.time_ >= var_57_19 + var_57_20 and arg_54_1.time_ < var_57_19 + var_57_20 + arg_57_0 and not isNil(var_57_18) and arg_54_1.var_.characterEffect1111ui_story then
				local var_57_23 = 0.5

				arg_54_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1111ui_story.fillRatio = var_57_23
			end

			local var_57_24 = 0

			if var_57_24 < arg_54_1.time_ and arg_54_1.time_ <= var_57_24 + arg_57_0 then
				arg_54_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action4_1")
			end

			local var_57_25 = 0

			if var_57_25 < arg_54_1.time_ and arg_54_1.time_ <= var_57_25 + arg_57_0 then
				arg_54_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_57_26 = 0
			local var_57_27 = 0.175

			if var_57_26 < arg_54_1.time_ and arg_54_1.time_ <= var_57_26 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_28 = arg_54_1:FormatText(StoryNameCfg[453].name)

				arg_54_1.leftNameTxt_.text = var_57_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_29 = arg_54_1:GetWordFromCfg(322211013)
				local var_57_30 = arg_54_1:FormatText(var_57_29.content)

				arg_54_1.text_.text = var_57_30

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_31 = 7
				local var_57_32 = utf8.len(var_57_30)
				local var_57_33 = var_57_31 <= 0 and var_57_27 or var_57_27 * (var_57_32 / var_57_31)

				if var_57_33 > 0 and var_57_27 < var_57_33 then
					arg_54_1.talkMaxDuration = var_57_33

					if var_57_33 + var_57_26 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_33 + var_57_26
					end
				end

				arg_54_1.text_.text = var_57_30
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211013", "story_v_out_322211.awb") ~= 0 then
					local var_57_34 = manager.audio:GetVoiceLength("story_v_out_322211", "322211013", "story_v_out_322211.awb") / 1000

					if var_57_34 + var_57_26 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_34 + var_57_26
					end

					if var_57_29.prefab_name ~= "" and arg_54_1.actors_[var_57_29.prefab_name] ~= nil then
						local var_57_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_29.prefab_name].transform, "story_v_out_322211", "322211013", "story_v_out_322211.awb")

						arg_54_1:RecordAudio("322211013", var_57_35)
						arg_54_1:RecordAudio("322211013", var_57_35)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_322211", "322211013", "story_v_out_322211.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_322211", "322211013", "story_v_out_322211.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_36 = math.max(var_57_27, arg_54_1.talkMaxDuration)

			if var_57_26 <= arg_54_1.time_ and arg_54_1.time_ < var_57_26 + var_57_36 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_26) / var_57_36

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_26 + var_57_36 and arg_54_1.time_ < var_57_26 + var_57_36 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play322211014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 322211014
		arg_58_1.duration_ = 4.37

		local var_58_0 = {
			zh = 4,
			ja = 4.366
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play322211015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = arg_58_1.actors_["1111ui_story"]
			local var_61_1 = 0

			if var_61_1 < arg_58_1.time_ and arg_58_1.time_ <= var_61_1 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1111ui_story == nil then
				arg_58_1.var_.characterEffect1111ui_story = var_61_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if var_61_1 <= arg_58_1.time_ and arg_58_1.time_ < var_61_1 + var_61_2 and not isNil(var_61_0) then
				local var_61_3 = (arg_58_1.time_ - var_61_1) / var_61_2

				if arg_58_1.var_.characterEffect1111ui_story and not isNil(var_61_0) then
					arg_58_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_1 + var_61_2 and arg_58_1.time_ < var_61_1 + var_61_2 + arg_61_0 and not isNil(var_61_0) and arg_58_1.var_.characterEffect1111ui_story then
				arg_58_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_61_4 = arg_58_1.actors_["4037ui_story"]
			local var_61_5 = 0

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect4037ui_story == nil then
				arg_58_1.var_.characterEffect4037ui_story = var_61_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_6 = 0.200000002980232

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_6 and not isNil(var_61_4) then
				local var_61_7 = (arg_58_1.time_ - var_61_5) / var_61_6

				if arg_58_1.var_.characterEffect4037ui_story and not isNil(var_61_4) then
					local var_61_8 = Mathf.Lerp(0, 0.5, var_61_7)

					arg_58_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_58_1.var_.characterEffect4037ui_story.fillRatio = var_61_8
				end
			end

			if arg_58_1.time_ >= var_61_5 + var_61_6 and arg_58_1.time_ < var_61_5 + var_61_6 + arg_61_0 and not isNil(var_61_4) and arg_58_1.var_.characterEffect4037ui_story then
				local var_61_9 = 0.5

				arg_58_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_58_1.var_.characterEffect4037ui_story.fillRatio = var_61_9
			end

			local var_61_10 = 0

			if var_61_10 < arg_58_1.time_ and arg_58_1.time_ <= var_61_10 + arg_61_0 then
				arg_58_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_61_11 = 0
			local var_61_12 = 0.4

			if var_61_11 < arg_58_1.time_ and arg_58_1.time_ <= var_61_11 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_13 = arg_58_1:FormatText(StoryNameCfg[67].name)

				arg_58_1.leftNameTxt_.text = var_61_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_14 = arg_58_1:GetWordFromCfg(322211014)
				local var_61_15 = arg_58_1:FormatText(var_61_14.content)

				arg_58_1.text_.text = var_61_15

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_16 = 16
				local var_61_17 = utf8.len(var_61_15)
				local var_61_18 = var_61_16 <= 0 and var_61_12 or var_61_12 * (var_61_17 / var_61_16)

				if var_61_18 > 0 and var_61_12 < var_61_18 then
					arg_58_1.talkMaxDuration = var_61_18

					if var_61_18 + var_61_11 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_18 + var_61_11
					end
				end

				arg_58_1.text_.text = var_61_15
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211014", "story_v_out_322211.awb") ~= 0 then
					local var_61_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211014", "story_v_out_322211.awb") / 1000

					if var_61_19 + var_61_11 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_19 + var_61_11
					end

					if var_61_14.prefab_name ~= "" and arg_58_1.actors_[var_61_14.prefab_name] ~= nil then
						local var_61_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_14.prefab_name].transform, "story_v_out_322211", "322211014", "story_v_out_322211.awb")

						arg_58_1:RecordAudio("322211014", var_61_20)
						arg_58_1:RecordAudio("322211014", var_61_20)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_322211", "322211014", "story_v_out_322211.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_322211", "322211014", "story_v_out_322211.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_21 = math.max(var_61_12, arg_58_1.talkMaxDuration)

			if var_61_11 <= arg_58_1.time_ and arg_58_1.time_ < var_61_11 + var_61_21 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_11) / var_61_21

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_11 + var_61_21 and arg_58_1.time_ < var_61_11 + var_61_21 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play322211015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 322211015
		arg_62_1.duration_ = 2.67

		local var_62_0 = {
			zh = 2.666,
			ja = 2.633
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play322211016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["4037ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect4037ui_story == nil then
				arg_62_1.var_.characterEffect4037ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect4037ui_story and not isNil(var_65_0) then
					arg_62_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect4037ui_story then
				arg_62_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_65_4 = arg_62_1.actors_["1111ui_story"]
			local var_65_5 = 0

			if var_65_5 < arg_62_1.time_ and arg_62_1.time_ <= var_65_5 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect1111ui_story == nil then
				arg_62_1.var_.characterEffect1111ui_story = var_65_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_6 = 0.200000002980232

			if var_65_5 <= arg_62_1.time_ and arg_62_1.time_ < var_65_5 + var_65_6 and not isNil(var_65_4) then
				local var_65_7 = (arg_62_1.time_ - var_65_5) / var_65_6

				if arg_62_1.var_.characterEffect1111ui_story and not isNil(var_65_4) then
					local var_65_8 = Mathf.Lerp(0, 0.5, var_65_7)

					arg_62_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1111ui_story.fillRatio = var_65_8
				end
			end

			if arg_62_1.time_ >= var_65_5 + var_65_6 and arg_62_1.time_ < var_65_5 + var_65_6 + arg_65_0 and not isNil(var_65_4) and arg_62_1.var_.characterEffect1111ui_story then
				local var_65_9 = 0.5

				arg_62_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1111ui_story.fillRatio = var_65_9
			end

			local var_65_10 = 0

			if var_65_10 < arg_62_1.time_ and arg_62_1.time_ <= var_65_10 + arg_65_0 then
				arg_62_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action4_2")
			end

			local var_65_11 = 0
			local var_65_12 = 0.275

			if var_65_11 < arg_62_1.time_ and arg_62_1.time_ <= var_65_11 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				local var_65_13 = arg_62_1:FormatText(StoryNameCfg[453].name)

				arg_62_1.leftNameTxt_.text = var_65_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_14 = arg_62_1:GetWordFromCfg(322211015)
				local var_65_15 = arg_62_1:FormatText(var_65_14.content)

				arg_62_1.text_.text = var_65_15

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_16 = 11
				local var_65_17 = utf8.len(var_65_15)
				local var_65_18 = var_65_16 <= 0 and var_65_12 or var_65_12 * (var_65_17 / var_65_16)

				if var_65_18 > 0 and var_65_12 < var_65_18 then
					arg_62_1.talkMaxDuration = var_65_18

					if var_65_18 + var_65_11 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_18 + var_65_11
					end
				end

				arg_62_1.text_.text = var_65_15
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211015", "story_v_out_322211.awb") ~= 0 then
					local var_65_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211015", "story_v_out_322211.awb") / 1000

					if var_65_19 + var_65_11 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_19 + var_65_11
					end

					if var_65_14.prefab_name ~= "" and arg_62_1.actors_[var_65_14.prefab_name] ~= nil then
						local var_65_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_14.prefab_name].transform, "story_v_out_322211", "322211015", "story_v_out_322211.awb")

						arg_62_1:RecordAudio("322211015", var_65_20)
						arg_62_1:RecordAudio("322211015", var_65_20)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_322211", "322211015", "story_v_out_322211.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_322211", "322211015", "story_v_out_322211.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_21 = math.max(var_65_12, arg_62_1.talkMaxDuration)

			if var_65_11 <= arg_62_1.time_ and arg_62_1.time_ < var_65_11 + var_65_21 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_11) / var_65_21

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_11 + var_65_21 and arg_62_1.time_ < var_65_11 + var_65_21 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play322211016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 322211016
		arg_66_1.duration_ = 11.4

		local var_66_0 = {
			zh = 9.6,
			ja = 11.4
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
				arg_66_0:Play322211017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = arg_66_1.actors_["1111ui_story"]
			local var_69_1 = 0

			if var_69_1 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1111ui_story == nil then
				arg_66_1.var_.characterEffect1111ui_story = var_69_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.200000002980232

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_2 and not isNil(var_69_0) then
				local var_69_3 = (arg_66_1.time_ - var_69_1) / var_69_2

				if arg_66_1.var_.characterEffect1111ui_story and not isNil(var_69_0) then
					arg_66_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= var_69_1 + var_69_2 and arg_66_1.time_ < var_69_1 + var_69_2 + arg_69_0 and not isNil(var_69_0) and arg_66_1.var_.characterEffect1111ui_story then
				arg_66_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_69_4 = arg_66_1.actors_["4037ui_story"]
			local var_69_5 = 0

			if var_69_5 < arg_66_1.time_ and arg_66_1.time_ <= var_69_5 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect4037ui_story == nil then
				arg_66_1.var_.characterEffect4037ui_story = var_69_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_6 = 0.200000002980232

			if var_69_5 <= arg_66_1.time_ and arg_66_1.time_ < var_69_5 + var_69_6 and not isNil(var_69_4) then
				local var_69_7 = (arg_66_1.time_ - var_69_5) / var_69_6

				if arg_66_1.var_.characterEffect4037ui_story and not isNil(var_69_4) then
					local var_69_8 = Mathf.Lerp(0, 0.5, var_69_7)

					arg_66_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_66_1.var_.characterEffect4037ui_story.fillRatio = var_69_8
				end
			end

			if arg_66_1.time_ >= var_69_5 + var_69_6 and arg_66_1.time_ < var_69_5 + var_69_6 + arg_69_0 and not isNil(var_69_4) and arg_66_1.var_.characterEffect4037ui_story then
				local var_69_9 = 0.5

				arg_66_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_66_1.var_.characterEffect4037ui_story.fillRatio = var_69_9
			end

			local var_69_10 = 0
			local var_69_11 = 1.025

			if var_69_10 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				local var_69_12 = arg_66_1:FormatText(StoryNameCfg[67].name)

				arg_66_1.leftNameTxt_.text = var_69_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_13 = arg_66_1:GetWordFromCfg(322211016)
				local var_69_14 = arg_66_1:FormatText(var_69_13.content)

				arg_66_1.text_.text = var_69_14

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_15 = 41
				local var_69_16 = utf8.len(var_69_14)
				local var_69_17 = var_69_15 <= 0 and var_69_11 or var_69_11 * (var_69_16 / var_69_15)

				if var_69_17 > 0 and var_69_11 < var_69_17 then
					arg_66_1.talkMaxDuration = var_69_17

					if var_69_17 + var_69_10 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_17 + var_69_10
					end
				end

				arg_66_1.text_.text = var_69_14
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211016", "story_v_out_322211.awb") ~= 0 then
					local var_69_18 = manager.audio:GetVoiceLength("story_v_out_322211", "322211016", "story_v_out_322211.awb") / 1000

					if var_69_18 + var_69_10 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_18 + var_69_10
					end

					if var_69_13.prefab_name ~= "" and arg_66_1.actors_[var_69_13.prefab_name] ~= nil then
						local var_69_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_13.prefab_name].transform, "story_v_out_322211", "322211016", "story_v_out_322211.awb")

						arg_66_1:RecordAudio("322211016", var_69_19)
						arg_66_1:RecordAudio("322211016", var_69_19)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_322211", "322211016", "story_v_out_322211.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_322211", "322211016", "story_v_out_322211.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_20 = math.max(var_69_11, arg_66_1.talkMaxDuration)

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_20 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_10) / var_69_20

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_10 + var_69_20 and arg_66_1.time_ < var_69_10 + var_69_20 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play322211017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 322211017
		arg_70_1.duration_ = 9.87

		local var_70_0 = {
			zh = 7.1,
			ja = 9.866
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
				arg_70_0:Play322211018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = arg_70_1.actors_["4037ui_story"]
			local var_73_1 = 0

			if var_73_1 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect4037ui_story == nil then
				arg_70_1.var_.characterEffect4037ui_story = var_73_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_2 and not isNil(var_73_0) then
				local var_73_3 = (arg_70_1.time_ - var_73_1) / var_73_2

				if arg_70_1.var_.characterEffect4037ui_story and not isNil(var_73_0) then
					arg_70_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= var_73_1 + var_73_2 and arg_70_1.time_ < var_73_1 + var_73_2 + arg_73_0 and not isNil(var_73_0) and arg_70_1.var_.characterEffect4037ui_story then
				arg_70_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_73_4 = arg_70_1.actors_["1111ui_story"]
			local var_73_5 = 0

			if var_73_5 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1111ui_story == nil then
				arg_70_1.var_.characterEffect1111ui_story = var_73_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_6 = 0.200000002980232

			if var_73_5 <= arg_70_1.time_ and arg_70_1.time_ < var_73_5 + var_73_6 and not isNil(var_73_4) then
				local var_73_7 = (arg_70_1.time_ - var_73_5) / var_73_6

				if arg_70_1.var_.characterEffect1111ui_story and not isNil(var_73_4) then
					local var_73_8 = Mathf.Lerp(0, 0.5, var_73_7)

					arg_70_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1111ui_story.fillRatio = var_73_8
				end
			end

			if arg_70_1.time_ >= var_73_5 + var_73_6 and arg_70_1.time_ < var_73_5 + var_73_6 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect1111ui_story then
				local var_73_9 = 0.5

				arg_70_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1111ui_story.fillRatio = var_73_9
			end

			local var_73_10 = 0
			local var_73_11 = 0.65

			if var_73_10 < arg_70_1.time_ and arg_70_1.time_ <= var_73_10 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				local var_73_12 = arg_70_1:FormatText(StoryNameCfg[453].name)

				arg_70_1.leftNameTxt_.text = var_73_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_13 = arg_70_1:GetWordFromCfg(322211017)
				local var_73_14 = arg_70_1:FormatText(var_73_13.content)

				arg_70_1.text_.text = var_73_14

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_15 = 26
				local var_73_16 = utf8.len(var_73_14)
				local var_73_17 = var_73_15 <= 0 and var_73_11 or var_73_11 * (var_73_16 / var_73_15)

				if var_73_17 > 0 and var_73_11 < var_73_17 then
					arg_70_1.talkMaxDuration = var_73_17

					if var_73_17 + var_73_10 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_17 + var_73_10
					end
				end

				arg_70_1.text_.text = var_73_14
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211017", "story_v_out_322211.awb") ~= 0 then
					local var_73_18 = manager.audio:GetVoiceLength("story_v_out_322211", "322211017", "story_v_out_322211.awb") / 1000

					if var_73_18 + var_73_10 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_18 + var_73_10
					end

					if var_73_13.prefab_name ~= "" and arg_70_1.actors_[var_73_13.prefab_name] ~= nil then
						local var_73_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_13.prefab_name].transform, "story_v_out_322211", "322211017", "story_v_out_322211.awb")

						arg_70_1:RecordAudio("322211017", var_73_19)
						arg_70_1:RecordAudio("322211017", var_73_19)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_322211", "322211017", "story_v_out_322211.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_322211", "322211017", "story_v_out_322211.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_20 = math.max(var_73_11, arg_70_1.talkMaxDuration)

			if var_73_10 <= arg_70_1.time_ and arg_70_1.time_ < var_73_10 + var_73_20 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_10) / var_73_20

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_10 + var_73_20 and arg_70_1.time_ < var_73_10 + var_73_20 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play322211018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 322211018
		arg_74_1.duration_ = 3.1

		local var_74_0 = {
			zh = 2.8,
			ja = 3.1
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
				arg_74_0:Play322211019(arg_74_1)
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

			local var_77_4 = arg_74_1.actors_["4037ui_story"]
			local var_77_5 = 0

			if var_77_5 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect4037ui_story == nil then
				arg_74_1.var_.characterEffect4037ui_story = var_77_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_6 = 0.200000002980232

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_6 and not isNil(var_77_4) then
				local var_77_7 = (arg_74_1.time_ - var_77_5) / var_77_6

				if arg_74_1.var_.characterEffect4037ui_story and not isNil(var_77_4) then
					local var_77_8 = Mathf.Lerp(0, 0.5, var_77_7)

					arg_74_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_74_1.var_.characterEffect4037ui_story.fillRatio = var_77_8
				end
			end

			if arg_74_1.time_ >= var_77_5 + var_77_6 and arg_74_1.time_ < var_77_5 + var_77_6 + arg_77_0 and not isNil(var_77_4) and arg_74_1.var_.characterEffect4037ui_story then
				local var_77_9 = 0.5

				arg_74_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_74_1.var_.characterEffect4037ui_story.fillRatio = var_77_9
			end

			local var_77_10 = 0

			if var_77_10 < arg_74_1.time_ and arg_74_1.time_ <= var_77_10 + arg_77_0 then
				arg_74_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_77_11 = 0
			local var_77_12 = 0.35

			if var_77_11 < arg_74_1.time_ and arg_74_1.time_ <= var_77_11 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				local var_77_13 = arg_74_1:FormatText(StoryNameCfg[67].name)

				arg_74_1.leftNameTxt_.text = var_77_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_14 = arg_74_1:GetWordFromCfg(322211018)
				local var_77_15 = arg_74_1:FormatText(var_77_14.content)

				arg_74_1.text_.text = var_77_15

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_16 = 14
				local var_77_17 = utf8.len(var_77_15)
				local var_77_18 = var_77_16 <= 0 and var_77_12 or var_77_12 * (var_77_17 / var_77_16)

				if var_77_18 > 0 and var_77_12 < var_77_18 then
					arg_74_1.talkMaxDuration = var_77_18

					if var_77_18 + var_77_11 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_18 + var_77_11
					end
				end

				arg_74_1.text_.text = var_77_15
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211018", "story_v_out_322211.awb") ~= 0 then
					local var_77_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211018", "story_v_out_322211.awb") / 1000

					if var_77_19 + var_77_11 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_19 + var_77_11
					end

					if var_77_14.prefab_name ~= "" and arg_74_1.actors_[var_77_14.prefab_name] ~= nil then
						local var_77_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_14.prefab_name].transform, "story_v_out_322211", "322211018", "story_v_out_322211.awb")

						arg_74_1:RecordAudio("322211018", var_77_20)
						arg_74_1:RecordAudio("322211018", var_77_20)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_322211", "322211018", "story_v_out_322211.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_322211", "322211018", "story_v_out_322211.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_21 = math.max(var_77_12, arg_74_1.talkMaxDuration)

			if var_77_11 <= arg_74_1.time_ and arg_74_1.time_ < var_77_11 + var_77_21 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_11) / var_77_21

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_11 + var_77_21 and arg_74_1.time_ < var_77_11 + var_77_21 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play322211019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 322211019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play322211020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = arg_78_1.actors_["1111ui_story"].transform
			local var_81_1 = 0

			if var_81_1 < arg_78_1.time_ and arg_78_1.time_ <= var_81_1 + arg_81_0 then
				arg_78_1.var_.moveOldPos1111ui_story = var_81_0.localPosition
			end

			local var_81_2 = 0.001

			if var_81_1 <= arg_78_1.time_ and arg_78_1.time_ < var_81_1 + var_81_2 then
				local var_81_3 = (arg_78_1.time_ - var_81_1) / var_81_2
				local var_81_4 = Vector3.New(0, 100, 0)

				var_81_0.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1111ui_story, var_81_4, var_81_3)

				local var_81_5 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_5.x, var_81_5.y, var_81_5.z)

				local var_81_6 = var_81_0.localEulerAngles

				var_81_6.z = 0
				var_81_6.x = 0
				var_81_0.localEulerAngles = var_81_6
			end

			if arg_78_1.time_ >= var_81_1 + var_81_2 and arg_78_1.time_ < var_81_1 + var_81_2 + arg_81_0 then
				var_81_0.localPosition = Vector3.New(0, 100, 0)

				local var_81_7 = manager.ui.mainCamera.transform.position - var_81_0.position

				var_81_0.forward = Vector3.New(var_81_7.x, var_81_7.y, var_81_7.z)

				local var_81_8 = var_81_0.localEulerAngles

				var_81_8.z = 0
				var_81_8.x = 0
				var_81_0.localEulerAngles = var_81_8
			end

			local var_81_9 = arg_78_1.actors_["4037ui_story"].transform
			local var_81_10 = 0

			if var_81_10 < arg_78_1.time_ and arg_78_1.time_ <= var_81_10 + arg_81_0 then
				arg_78_1.var_.moveOldPos4037ui_story = var_81_9.localPosition
			end

			local var_81_11 = 0.001

			if var_81_10 <= arg_78_1.time_ and arg_78_1.time_ < var_81_10 + var_81_11 then
				local var_81_12 = (arg_78_1.time_ - var_81_10) / var_81_11
				local var_81_13 = Vector3.New(0, 100, 0)

				var_81_9.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos4037ui_story, var_81_13, var_81_12)

				local var_81_14 = manager.ui.mainCamera.transform.position - var_81_9.position

				var_81_9.forward = Vector3.New(var_81_14.x, var_81_14.y, var_81_14.z)

				local var_81_15 = var_81_9.localEulerAngles

				var_81_15.z = 0
				var_81_15.x = 0
				var_81_9.localEulerAngles = var_81_15
			end

			if arg_78_1.time_ >= var_81_10 + var_81_11 and arg_78_1.time_ < var_81_10 + var_81_11 + arg_81_0 then
				var_81_9.localPosition = Vector3.New(0, 100, 0)

				local var_81_16 = manager.ui.mainCamera.transform.position - var_81_9.position

				var_81_9.forward = Vector3.New(var_81_16.x, var_81_16.y, var_81_16.z)

				local var_81_17 = var_81_9.localEulerAngles

				var_81_17.z = 0
				var_81_17.x = 0
				var_81_9.localEulerAngles = var_81_17
			end

			local var_81_18 = 0
			local var_81_19 = 1.45

			if var_81_18 < arg_78_1.time_ and arg_78_1.time_ <= var_81_18 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_20 = arg_78_1:GetWordFromCfg(322211019)
				local var_81_21 = arg_78_1:FormatText(var_81_20.content)

				arg_78_1.text_.text = var_81_21

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_22 = 58
				local var_81_23 = utf8.len(var_81_21)
				local var_81_24 = var_81_22 <= 0 and var_81_19 or var_81_19 * (var_81_23 / var_81_22)

				if var_81_24 > 0 and var_81_19 < var_81_24 then
					arg_78_1.talkMaxDuration = var_81_24

					if var_81_24 + var_81_18 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_24 + var_81_18
					end
				end

				arg_78_1.text_.text = var_81_21
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_25 = math.max(var_81_19, arg_78_1.talkMaxDuration)

			if var_81_18 <= arg_78_1.time_ and arg_78_1.time_ < var_81_18 + var_81_25 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_18) / var_81_25

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_18 + var_81_25 and arg_78_1.time_ < var_81_18 + var_81_25 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play322211020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 322211020
		arg_82_1.duration_ = 3.8

		local var_82_0 = {
			zh = 2.433,
			ja = 3.8
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
				arg_82_0:Play322211021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = arg_82_1.actors_["4037ui_story"].transform
			local var_85_1 = 0

			if var_85_1 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.var_.moveOldPos4037ui_story = var_85_0.localPosition
			end

			local var_85_2 = 0.001

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_2 then
				local var_85_3 = (arg_82_1.time_ - var_85_1) / var_85_2
				local var_85_4 = Vector3.New(0, -1.12, -6.2)

				var_85_0.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos4037ui_story, var_85_4, var_85_3)

				local var_85_5 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_5.x, var_85_5.y, var_85_5.z)

				local var_85_6 = var_85_0.localEulerAngles

				var_85_6.z = 0
				var_85_6.x = 0
				var_85_0.localEulerAngles = var_85_6
			end

			if arg_82_1.time_ >= var_85_1 + var_85_2 and arg_82_1.time_ < var_85_1 + var_85_2 + arg_85_0 then
				var_85_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_85_7 = manager.ui.mainCamera.transform.position - var_85_0.position

				var_85_0.forward = Vector3.New(var_85_7.x, var_85_7.y, var_85_7.z)

				local var_85_8 = var_85_0.localEulerAngles

				var_85_8.z = 0
				var_85_8.x = 0
				var_85_0.localEulerAngles = var_85_8
			end

			local var_85_9 = arg_82_1.actors_["4037ui_story"]
			local var_85_10 = 0

			if var_85_10 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 and not isNil(var_85_9) and arg_82_1.var_.characterEffect4037ui_story == nil then
				arg_82_1.var_.characterEffect4037ui_story = var_85_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_11 = 0.200000002980232

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_11 and not isNil(var_85_9) then
				local var_85_12 = (arg_82_1.time_ - var_85_10) / var_85_11

				if arg_82_1.var_.characterEffect4037ui_story and not isNil(var_85_9) then
					arg_82_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= var_85_10 + var_85_11 and arg_82_1.time_ < var_85_10 + var_85_11 + arg_85_0 and not isNil(var_85_9) and arg_82_1.var_.characterEffect4037ui_story then
				arg_82_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_85_13 = 0

			if var_85_13 < arg_82_1.time_ and arg_82_1.time_ <= var_85_13 + arg_85_0 then
				arg_82_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_85_14 = 0

			if var_85_14 < arg_82_1.time_ and arg_82_1.time_ <= var_85_14 + arg_85_0 then
				arg_82_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_85_15 = 0
			local var_85_16 = 0.25

			if var_85_15 < arg_82_1.time_ and arg_82_1.time_ <= var_85_15 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				local var_85_17 = arg_82_1:FormatText(StoryNameCfg[453].name)

				arg_82_1.leftNameTxt_.text = var_85_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_18 = arg_82_1:GetWordFromCfg(322211020)
				local var_85_19 = arg_82_1:FormatText(var_85_18.content)

				arg_82_1.text_.text = var_85_19

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_20 = 10
				local var_85_21 = utf8.len(var_85_19)
				local var_85_22 = var_85_20 <= 0 and var_85_16 or var_85_16 * (var_85_21 / var_85_20)

				if var_85_22 > 0 and var_85_16 < var_85_22 then
					arg_82_1.talkMaxDuration = var_85_22

					if var_85_22 + var_85_15 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_22 + var_85_15
					end
				end

				arg_82_1.text_.text = var_85_19
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211020", "story_v_out_322211.awb") ~= 0 then
					local var_85_23 = manager.audio:GetVoiceLength("story_v_out_322211", "322211020", "story_v_out_322211.awb") / 1000

					if var_85_23 + var_85_15 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_23 + var_85_15
					end

					if var_85_18.prefab_name ~= "" and arg_82_1.actors_[var_85_18.prefab_name] ~= nil then
						local var_85_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_18.prefab_name].transform, "story_v_out_322211", "322211020", "story_v_out_322211.awb")

						arg_82_1:RecordAudio("322211020", var_85_24)
						arg_82_1:RecordAudio("322211020", var_85_24)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_322211", "322211020", "story_v_out_322211.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_322211", "322211020", "story_v_out_322211.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_25 = math.max(var_85_16, arg_82_1.talkMaxDuration)

			if var_85_15 <= arg_82_1.time_ and arg_82_1.time_ < var_85_15 + var_85_25 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_15) / var_85_25

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_15 + var_85_25 and arg_82_1.time_ < var_85_15 + var_85_25 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play322211021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 322211021
		arg_86_1.duration_ = 3.5

		local var_86_0 = {
			zh = 2.866,
			ja = 3.5
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
				arg_86_0:Play322211022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = arg_86_1.actors_["1111ui_story"].transform
			local var_89_1 = 0

			if var_89_1 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
				arg_86_1.var_.moveOldPos1111ui_story = var_89_0.localPosition
			end

			local var_89_2 = 0.001

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_2 then
				local var_89_3 = (arg_86_1.time_ - var_89_1) / var_89_2
				local var_89_4 = Vector3.New(0, -0.87, -5.7)

				var_89_0.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1111ui_story, var_89_4, var_89_3)

				local var_89_5 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_5.x, var_89_5.y, var_89_5.z)

				local var_89_6 = var_89_0.localEulerAngles

				var_89_6.z = 0
				var_89_6.x = 0
				var_89_0.localEulerAngles = var_89_6
			end

			if arg_86_1.time_ >= var_89_1 + var_89_2 and arg_86_1.time_ < var_89_1 + var_89_2 + arg_89_0 then
				var_89_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_89_7 = manager.ui.mainCamera.transform.position - var_89_0.position

				var_89_0.forward = Vector3.New(var_89_7.x, var_89_7.y, var_89_7.z)

				local var_89_8 = var_89_0.localEulerAngles

				var_89_8.z = 0
				var_89_8.x = 0
				var_89_0.localEulerAngles = var_89_8
			end

			local var_89_9 = arg_86_1.actors_["4037ui_story"].transform
			local var_89_10 = 0

			if var_89_10 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.var_.moveOldPos4037ui_story = var_89_9.localPosition
			end

			local var_89_11 = 0.001

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_11 then
				local var_89_12 = (arg_86_1.time_ - var_89_10) / var_89_11
				local var_89_13 = Vector3.New(0, 100, 0)

				var_89_9.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos4037ui_story, var_89_13, var_89_12)

				local var_89_14 = manager.ui.mainCamera.transform.position - var_89_9.position

				var_89_9.forward = Vector3.New(var_89_14.x, var_89_14.y, var_89_14.z)

				local var_89_15 = var_89_9.localEulerAngles

				var_89_15.z = 0
				var_89_15.x = 0
				var_89_9.localEulerAngles = var_89_15
			end

			if arg_86_1.time_ >= var_89_10 + var_89_11 and arg_86_1.time_ < var_89_10 + var_89_11 + arg_89_0 then
				var_89_9.localPosition = Vector3.New(0, 100, 0)

				local var_89_16 = manager.ui.mainCamera.transform.position - var_89_9.position

				var_89_9.forward = Vector3.New(var_89_16.x, var_89_16.y, var_89_16.z)

				local var_89_17 = var_89_9.localEulerAngles

				var_89_17.z = 0
				var_89_17.x = 0
				var_89_9.localEulerAngles = var_89_17
			end

			local var_89_18 = arg_86_1.actors_["1111ui_story"]
			local var_89_19 = 0

			if var_89_19 < arg_86_1.time_ and arg_86_1.time_ <= var_89_19 + arg_89_0 and not isNil(var_89_18) and arg_86_1.var_.characterEffect1111ui_story == nil then
				arg_86_1.var_.characterEffect1111ui_story = var_89_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_20 = 0.200000002980232

			if var_89_19 <= arg_86_1.time_ and arg_86_1.time_ < var_89_19 + var_89_20 and not isNil(var_89_18) then
				local var_89_21 = (arg_86_1.time_ - var_89_19) / var_89_20

				if arg_86_1.var_.characterEffect1111ui_story and not isNil(var_89_18) then
					arg_86_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= var_89_19 + var_89_20 and arg_86_1.time_ < var_89_19 + var_89_20 + arg_89_0 and not isNil(var_89_18) and arg_86_1.var_.characterEffect1111ui_story then
				arg_86_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_89_22 = arg_86_1.actors_["4037ui_story"]
			local var_89_23 = 0

			if var_89_23 < arg_86_1.time_ and arg_86_1.time_ <= var_89_23 + arg_89_0 and not isNil(var_89_22) and arg_86_1.var_.characterEffect4037ui_story == nil then
				arg_86_1.var_.characterEffect4037ui_story = var_89_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_24 = 0.200000002980232

			if var_89_23 <= arg_86_1.time_ and arg_86_1.time_ < var_89_23 + var_89_24 and not isNil(var_89_22) then
				local var_89_25 = (arg_86_1.time_ - var_89_23) / var_89_24

				if arg_86_1.var_.characterEffect4037ui_story and not isNil(var_89_22) then
					local var_89_26 = Mathf.Lerp(0, 0.5, var_89_25)

					arg_86_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_86_1.var_.characterEffect4037ui_story.fillRatio = var_89_26
				end
			end

			if arg_86_1.time_ >= var_89_23 + var_89_24 and arg_86_1.time_ < var_89_23 + var_89_24 + arg_89_0 and not isNil(var_89_22) and arg_86_1.var_.characterEffect4037ui_story then
				local var_89_27 = 0.5

				arg_86_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_86_1.var_.characterEffect4037ui_story.fillRatio = var_89_27
			end

			local var_89_28 = 0

			if var_89_28 < arg_86_1.time_ and arg_86_1.time_ <= var_89_28 + arg_89_0 then
				arg_86_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action3_1")
			end

			local var_89_29 = 0
			local var_89_30 = 0.3

			if var_89_29 < arg_86_1.time_ and arg_86_1.time_ <= var_89_29 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				local var_89_31 = arg_86_1:FormatText(StoryNameCfg[67].name)

				arg_86_1.leftNameTxt_.text = var_89_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_32 = arg_86_1:GetWordFromCfg(322211021)
				local var_89_33 = arg_86_1:FormatText(var_89_32.content)

				arg_86_1.text_.text = var_89_33

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_34 = 12
				local var_89_35 = utf8.len(var_89_33)
				local var_89_36 = var_89_34 <= 0 and var_89_30 or var_89_30 * (var_89_35 / var_89_34)

				if var_89_36 > 0 and var_89_30 < var_89_36 then
					arg_86_1.talkMaxDuration = var_89_36

					if var_89_36 + var_89_29 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_36 + var_89_29
					end
				end

				arg_86_1.text_.text = var_89_33
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211021", "story_v_out_322211.awb") ~= 0 then
					local var_89_37 = manager.audio:GetVoiceLength("story_v_out_322211", "322211021", "story_v_out_322211.awb") / 1000

					if var_89_37 + var_89_29 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_37 + var_89_29
					end

					if var_89_32.prefab_name ~= "" and arg_86_1.actors_[var_89_32.prefab_name] ~= nil then
						local var_89_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_32.prefab_name].transform, "story_v_out_322211", "322211021", "story_v_out_322211.awb")

						arg_86_1:RecordAudio("322211021", var_89_38)
						arg_86_1:RecordAudio("322211021", var_89_38)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_322211", "322211021", "story_v_out_322211.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_322211", "322211021", "story_v_out_322211.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_39 = math.max(var_89_30, arg_86_1.talkMaxDuration)

			if var_89_29 <= arg_86_1.time_ and arg_86_1.time_ < var_89_29 + var_89_39 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_29) / var_89_39

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_29 + var_89_39 and arg_86_1.time_ < var_89_29 + var_89_39 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play322211022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 322211022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play322211023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = arg_90_1.actors_["1111ui_story"].transform
			local var_93_1 = 0

			if var_93_1 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.var_.moveOldPos1111ui_story = var_93_0.localPosition
			end

			local var_93_2 = 0.001

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_2 then
				local var_93_3 = (arg_90_1.time_ - var_93_1) / var_93_2
				local var_93_4 = Vector3.New(0, 100, 0)

				var_93_0.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1111ui_story, var_93_4, var_93_3)

				local var_93_5 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_5.x, var_93_5.y, var_93_5.z)

				local var_93_6 = var_93_0.localEulerAngles

				var_93_6.z = 0
				var_93_6.x = 0
				var_93_0.localEulerAngles = var_93_6
			end

			if arg_90_1.time_ >= var_93_1 + var_93_2 and arg_90_1.time_ < var_93_1 + var_93_2 + arg_93_0 then
				var_93_0.localPosition = Vector3.New(0, 100, 0)

				local var_93_7 = manager.ui.mainCamera.transform.position - var_93_0.position

				var_93_0.forward = Vector3.New(var_93_7.x, var_93_7.y, var_93_7.z)

				local var_93_8 = var_93_0.localEulerAngles

				var_93_8.z = 0
				var_93_8.x = 0
				var_93_0.localEulerAngles = var_93_8
			end

			local var_93_9 = 0
			local var_93_10 = 1.25

			if var_93_9 < arg_90_1.time_ and arg_90_1.time_ <= var_93_9 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_11 = arg_90_1:GetWordFromCfg(322211022)
				local var_93_12 = arg_90_1:FormatText(var_93_11.content)

				arg_90_1.text_.text = var_93_12

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_13 = 50
				local var_93_14 = utf8.len(var_93_12)
				local var_93_15 = var_93_13 <= 0 and var_93_10 or var_93_10 * (var_93_14 / var_93_13)

				if var_93_15 > 0 and var_93_10 < var_93_15 then
					arg_90_1.talkMaxDuration = var_93_15

					if var_93_15 + var_93_9 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_15 + var_93_9
					end
				end

				arg_90_1.text_.text = var_93_12
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_16 = math.max(var_93_10, arg_90_1.talkMaxDuration)

			if var_93_9 <= arg_90_1.time_ and arg_90_1.time_ < var_93_9 + var_93_16 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_9) / var_93_16

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_9 + var_93_16 and arg_90_1.time_ < var_93_9 + var_93_16 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play322211023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 322211023
		arg_94_1.duration_ = 5.6

		local var_94_0 = {
			zh = 4.1,
			ja = 5.6
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
				arg_94_0:Play322211024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = arg_94_1.actors_["1111ui_story"].transform
			local var_97_1 = 0

			if var_97_1 < arg_94_1.time_ and arg_94_1.time_ <= var_97_1 + arg_97_0 then
				arg_94_1.var_.moveOldPos1111ui_story = var_97_0.localPosition
			end

			local var_97_2 = 0.001

			if var_97_1 <= arg_94_1.time_ and arg_94_1.time_ < var_97_1 + var_97_2 then
				local var_97_3 = (arg_94_1.time_ - var_97_1) / var_97_2
				local var_97_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_97_0.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1111ui_story, var_97_4, var_97_3)

				local var_97_5 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_5.x, var_97_5.y, var_97_5.z)

				local var_97_6 = var_97_0.localEulerAngles

				var_97_6.z = 0
				var_97_6.x = 0
				var_97_0.localEulerAngles = var_97_6
			end

			if arg_94_1.time_ >= var_97_1 + var_97_2 and arg_94_1.time_ < var_97_1 + var_97_2 + arg_97_0 then
				var_97_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_97_7 = manager.ui.mainCamera.transform.position - var_97_0.position

				var_97_0.forward = Vector3.New(var_97_7.x, var_97_7.y, var_97_7.z)

				local var_97_8 = var_97_0.localEulerAngles

				var_97_8.z = 0
				var_97_8.x = 0
				var_97_0.localEulerAngles = var_97_8
			end

			local var_97_9 = arg_94_1.actors_["1111ui_story"]
			local var_97_10 = 0

			if var_97_10 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 and not isNil(var_97_9) and arg_94_1.var_.characterEffect1111ui_story == nil then
				arg_94_1.var_.characterEffect1111ui_story = var_97_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_11 = 0.200000002980232

			if var_97_10 <= arg_94_1.time_ and arg_94_1.time_ < var_97_10 + var_97_11 and not isNil(var_97_9) then
				local var_97_12 = (arg_94_1.time_ - var_97_10) / var_97_11

				if arg_94_1.var_.characterEffect1111ui_story and not isNil(var_97_9) then
					arg_94_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= var_97_10 + var_97_11 and arg_94_1.time_ < var_97_10 + var_97_11 + arg_97_0 and not isNil(var_97_9) and arg_94_1.var_.characterEffect1111ui_story then
				arg_94_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_97_13 = 0

			if var_97_13 < arg_94_1.time_ and arg_94_1.time_ <= var_97_13 + arg_97_0 then
				arg_94_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_97_14 = 0
			local var_97_15 = 0.45

			if var_97_14 < arg_94_1.time_ and arg_94_1.time_ <= var_97_14 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				local var_97_16 = arg_94_1:FormatText(StoryNameCfg[67].name)

				arg_94_1.leftNameTxt_.text = var_97_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_17 = arg_94_1:GetWordFromCfg(322211023)
				local var_97_18 = arg_94_1:FormatText(var_97_17.content)

				arg_94_1.text_.text = var_97_18

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_19 = 18
				local var_97_20 = utf8.len(var_97_18)
				local var_97_21 = var_97_19 <= 0 and var_97_15 or var_97_15 * (var_97_20 / var_97_19)

				if var_97_21 > 0 and var_97_15 < var_97_21 then
					arg_94_1.talkMaxDuration = var_97_21

					if var_97_21 + var_97_14 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_21 + var_97_14
					end
				end

				arg_94_1.text_.text = var_97_18
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211023", "story_v_out_322211.awb") ~= 0 then
					local var_97_22 = manager.audio:GetVoiceLength("story_v_out_322211", "322211023", "story_v_out_322211.awb") / 1000

					if var_97_22 + var_97_14 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_22 + var_97_14
					end

					if var_97_17.prefab_name ~= "" and arg_94_1.actors_[var_97_17.prefab_name] ~= nil then
						local var_97_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_17.prefab_name].transform, "story_v_out_322211", "322211023", "story_v_out_322211.awb")

						arg_94_1:RecordAudio("322211023", var_97_23)
						arg_94_1:RecordAudio("322211023", var_97_23)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_322211", "322211023", "story_v_out_322211.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_322211", "322211023", "story_v_out_322211.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_24 = math.max(var_97_15, arg_94_1.talkMaxDuration)

			if var_97_14 <= arg_94_1.time_ and arg_94_1.time_ < var_97_14 + var_97_24 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_14) / var_97_24

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_14 + var_97_24 and arg_94_1.time_ < var_97_14 + var_97_24 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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

		arg_94_1:InitPlayNodeList()
	end,
	Play322211024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 322211024
		arg_98_1.duration_ = 2.5

		local var_98_0 = {
			zh = 2.5,
			ja = 2.4
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
				arg_98_0:Play322211025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = arg_98_1.actors_["4037ui_story"].transform
			local var_101_1 = 0

			if var_101_1 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.var_.moveOldPos4037ui_story = var_101_0.localPosition
			end

			local var_101_2 = 0.001

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_2 then
				local var_101_3 = (arg_98_1.time_ - var_101_1) / var_101_2
				local var_101_4 = Vector3.New(0.7, -1.12, -6.2)

				var_101_0.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos4037ui_story, var_101_4, var_101_3)

				local var_101_5 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_5.x, var_101_5.y, var_101_5.z)

				local var_101_6 = var_101_0.localEulerAngles

				var_101_6.z = 0
				var_101_6.x = 0
				var_101_0.localEulerAngles = var_101_6
			end

			if arg_98_1.time_ >= var_101_1 + var_101_2 and arg_98_1.time_ < var_101_1 + var_101_2 + arg_101_0 then
				var_101_0.localPosition = Vector3.New(0.7, -1.12, -6.2)

				local var_101_7 = manager.ui.mainCamera.transform.position - var_101_0.position

				var_101_0.forward = Vector3.New(var_101_7.x, var_101_7.y, var_101_7.z)

				local var_101_8 = var_101_0.localEulerAngles

				var_101_8.z = 0
				var_101_8.x = 0
				var_101_0.localEulerAngles = var_101_8
			end

			local var_101_9 = arg_98_1.actors_["4037ui_story"]
			local var_101_10 = 0

			if var_101_10 < arg_98_1.time_ and arg_98_1.time_ <= var_101_10 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect4037ui_story == nil then
				arg_98_1.var_.characterEffect4037ui_story = var_101_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_11 = 0.200000002980232

			if var_101_10 <= arg_98_1.time_ and arg_98_1.time_ < var_101_10 + var_101_11 and not isNil(var_101_9) then
				local var_101_12 = (arg_98_1.time_ - var_101_10) / var_101_11

				if arg_98_1.var_.characterEffect4037ui_story and not isNil(var_101_9) then
					arg_98_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= var_101_10 + var_101_11 and arg_98_1.time_ < var_101_10 + var_101_11 + arg_101_0 and not isNil(var_101_9) and arg_98_1.var_.characterEffect4037ui_story then
				arg_98_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_101_13 = arg_98_1.actors_["1111ui_story"]
			local var_101_14 = 0

			if var_101_14 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 and not isNil(var_101_13) and arg_98_1.var_.characterEffect1111ui_story == nil then
				arg_98_1.var_.characterEffect1111ui_story = var_101_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_15 = 0.200000002980232

			if var_101_14 <= arg_98_1.time_ and arg_98_1.time_ < var_101_14 + var_101_15 and not isNil(var_101_13) then
				local var_101_16 = (arg_98_1.time_ - var_101_14) / var_101_15

				if arg_98_1.var_.characterEffect1111ui_story and not isNil(var_101_13) then
					local var_101_17 = Mathf.Lerp(0, 0.5, var_101_16)

					arg_98_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1111ui_story.fillRatio = var_101_17
				end
			end

			if arg_98_1.time_ >= var_101_14 + var_101_15 and arg_98_1.time_ < var_101_14 + var_101_15 + arg_101_0 and not isNil(var_101_13) and arg_98_1.var_.characterEffect1111ui_story then
				local var_101_18 = 0.5

				arg_98_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1111ui_story.fillRatio = var_101_18
			end

			local var_101_19 = 0
			local var_101_20 = 0.225

			if var_101_19 < arg_98_1.time_ and arg_98_1.time_ <= var_101_19 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				local var_101_21 = arg_98_1:FormatText(StoryNameCfg[453].name)

				arg_98_1.leftNameTxt_.text = var_101_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_22 = arg_98_1:GetWordFromCfg(322211024)
				local var_101_23 = arg_98_1:FormatText(var_101_22.content)

				arg_98_1.text_.text = var_101_23

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_24 = 9
				local var_101_25 = utf8.len(var_101_23)
				local var_101_26 = var_101_24 <= 0 and var_101_20 or var_101_20 * (var_101_25 / var_101_24)

				if var_101_26 > 0 and var_101_20 < var_101_26 then
					arg_98_1.talkMaxDuration = var_101_26

					if var_101_26 + var_101_19 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_26 + var_101_19
					end
				end

				arg_98_1.text_.text = var_101_23
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211024", "story_v_out_322211.awb") ~= 0 then
					local var_101_27 = manager.audio:GetVoiceLength("story_v_out_322211", "322211024", "story_v_out_322211.awb") / 1000

					if var_101_27 + var_101_19 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_27 + var_101_19
					end

					if var_101_22.prefab_name ~= "" and arg_98_1.actors_[var_101_22.prefab_name] ~= nil then
						local var_101_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_22.prefab_name].transform, "story_v_out_322211", "322211024", "story_v_out_322211.awb")

						arg_98_1:RecordAudio("322211024", var_101_28)
						arg_98_1:RecordAudio("322211024", var_101_28)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_322211", "322211024", "story_v_out_322211.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_322211", "322211024", "story_v_out_322211.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_29 = math.max(var_101_20, arg_98_1.talkMaxDuration)

			if var_101_19 <= arg_98_1.time_ and arg_98_1.time_ < var_101_19 + var_101_29 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_19) / var_101_29

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_19 + var_101_29 and arg_98_1.time_ < var_101_19 + var_101_29 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play322211025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 322211025
		arg_102_1.duration_ = 6.1

		local var_102_0 = {
			zh = 6.1,
			ja = 5.966
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
				arg_102_0:Play322211026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = arg_102_1.actors_["1111ui_story"]
			local var_105_1 = 0

			if var_105_1 < arg_102_1.time_ and arg_102_1.time_ <= var_105_1 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1111ui_story == nil then
				arg_102_1.var_.characterEffect1111ui_story = var_105_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.200000002980232

			if var_105_1 <= arg_102_1.time_ and arg_102_1.time_ < var_105_1 + var_105_2 and not isNil(var_105_0) then
				local var_105_3 = (arg_102_1.time_ - var_105_1) / var_105_2

				if arg_102_1.var_.characterEffect1111ui_story and not isNil(var_105_0) then
					arg_102_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= var_105_1 + var_105_2 and arg_102_1.time_ < var_105_1 + var_105_2 + arg_105_0 and not isNil(var_105_0) and arg_102_1.var_.characterEffect1111ui_story then
				arg_102_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_105_4 = arg_102_1.actors_["4037ui_story"]
			local var_105_5 = 0

			if var_105_5 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect4037ui_story == nil then
				arg_102_1.var_.characterEffect4037ui_story = var_105_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_6 = 0.200000002980232

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_6 and not isNil(var_105_4) then
				local var_105_7 = (arg_102_1.time_ - var_105_5) / var_105_6

				if arg_102_1.var_.characterEffect4037ui_story and not isNil(var_105_4) then
					local var_105_8 = Mathf.Lerp(0, 0.5, var_105_7)

					arg_102_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_102_1.var_.characterEffect4037ui_story.fillRatio = var_105_8
				end
			end

			if arg_102_1.time_ >= var_105_5 + var_105_6 and arg_102_1.time_ < var_105_5 + var_105_6 + arg_105_0 and not isNil(var_105_4) and arg_102_1.var_.characterEffect4037ui_story then
				local var_105_9 = 0.5

				arg_102_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_102_1.var_.characterEffect4037ui_story.fillRatio = var_105_9
			end

			local var_105_10 = 0

			if var_105_10 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_105_11 = 0
			local var_105_12 = 0.6

			if var_105_11 < arg_102_1.time_ and arg_102_1.time_ <= var_105_11 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				local var_105_13 = arg_102_1:FormatText(StoryNameCfg[67].name)

				arg_102_1.leftNameTxt_.text = var_105_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_14 = arg_102_1:GetWordFromCfg(322211025)
				local var_105_15 = arg_102_1:FormatText(var_105_14.content)

				arg_102_1.text_.text = var_105_15

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_16 = 24
				local var_105_17 = utf8.len(var_105_15)
				local var_105_18 = var_105_16 <= 0 and var_105_12 or var_105_12 * (var_105_17 / var_105_16)

				if var_105_18 > 0 and var_105_12 < var_105_18 then
					arg_102_1.talkMaxDuration = var_105_18

					if var_105_18 + var_105_11 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_18 + var_105_11
					end
				end

				arg_102_1.text_.text = var_105_15
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211025", "story_v_out_322211.awb") ~= 0 then
					local var_105_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211025", "story_v_out_322211.awb") / 1000

					if var_105_19 + var_105_11 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_19 + var_105_11
					end

					if var_105_14.prefab_name ~= "" and arg_102_1.actors_[var_105_14.prefab_name] ~= nil then
						local var_105_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_14.prefab_name].transform, "story_v_out_322211", "322211025", "story_v_out_322211.awb")

						arg_102_1:RecordAudio("322211025", var_105_20)
						arg_102_1:RecordAudio("322211025", var_105_20)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_322211", "322211025", "story_v_out_322211.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_322211", "322211025", "story_v_out_322211.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_21 = math.max(var_105_12, arg_102_1.talkMaxDuration)

			if var_105_11 <= arg_102_1.time_ and arg_102_1.time_ < var_105_11 + var_105_21 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_11) / var_105_21

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_11 + var_105_21 and arg_102_1.time_ < var_105_11 + var_105_21 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play322211026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 322211026
		arg_106_1.duration_ = 9.7

		local var_106_0 = {
			zh = 7.766,
			ja = 9.7
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
				arg_106_0:Play322211027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0
			local var_109_1 = 0.85

			if var_109_0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				local var_109_2 = arg_106_1:FormatText(StoryNameCfg[67].name)

				arg_106_1.leftNameTxt_.text = var_109_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_3 = arg_106_1:GetWordFromCfg(322211026)
				local var_109_4 = arg_106_1:FormatText(var_109_3.content)

				arg_106_1.text_.text = var_109_4

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 34
				local var_109_6 = utf8.len(var_109_4)
				local var_109_7 = var_109_5 <= 0 and var_109_1 or var_109_1 * (var_109_6 / var_109_5)

				if var_109_7 > 0 and var_109_1 < var_109_7 then
					arg_106_1.talkMaxDuration = var_109_7

					if var_109_7 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_7 + var_109_0
					end
				end

				arg_106_1.text_.text = var_109_4
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211026", "story_v_out_322211.awb") ~= 0 then
					local var_109_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211026", "story_v_out_322211.awb") / 1000

					if var_109_8 + var_109_0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_8 + var_109_0
					end

					if var_109_3.prefab_name ~= "" and arg_106_1.actors_[var_109_3.prefab_name] ~= nil then
						local var_109_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_3.prefab_name].transform, "story_v_out_322211", "322211026", "story_v_out_322211.awb")

						arg_106_1:RecordAudio("322211026", var_109_9)
						arg_106_1:RecordAudio("322211026", var_109_9)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_322211", "322211026", "story_v_out_322211.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_322211", "322211026", "story_v_out_322211.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_10 = math.max(var_109_1, arg_106_1.talkMaxDuration)

			if var_109_0 <= arg_106_1.time_ and arg_106_1.time_ < var_109_0 + var_109_10 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_0) / var_109_10

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_0 + var_109_10 and arg_106_1.time_ < var_109_0 + var_109_10 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play322211027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 322211027
		arg_110_1.duration_ = 3.1

		local var_110_0 = {
			zh = 2.566,
			ja = 3.1
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
				arg_110_0:Play322211028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = arg_110_1.actors_["4037ui_story"]
			local var_113_1 = 0

			if var_113_1 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect4037ui_story == nil then
				arg_110_1.var_.characterEffect4037ui_story = var_113_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_2 = 0.200000002980232

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_2 and not isNil(var_113_0) then
				local var_113_3 = (arg_110_1.time_ - var_113_1) / var_113_2

				if arg_110_1.var_.characterEffect4037ui_story and not isNil(var_113_0) then
					arg_110_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= var_113_1 + var_113_2 and arg_110_1.time_ < var_113_1 + var_113_2 + arg_113_0 and not isNil(var_113_0) and arg_110_1.var_.characterEffect4037ui_story then
				arg_110_1.var_.characterEffect4037ui_story.fillFlat = false
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
				arg_110_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			local var_113_11 = 0
			local var_113_12 = 0.275

			if var_113_11 < arg_110_1.time_ and arg_110_1.time_ <= var_113_11 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				local var_113_13 = arg_110_1:FormatText(StoryNameCfg[453].name)

				arg_110_1.leftNameTxt_.text = var_113_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_14 = arg_110_1:GetWordFromCfg(322211027)
				local var_113_15 = arg_110_1:FormatText(var_113_14.content)

				arg_110_1.text_.text = var_113_15

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_16 = 11
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

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211027", "story_v_out_322211.awb") ~= 0 then
					local var_113_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211027", "story_v_out_322211.awb") / 1000

					if var_113_19 + var_113_11 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_19 + var_113_11
					end

					if var_113_14.prefab_name ~= "" and arg_110_1.actors_[var_113_14.prefab_name] ~= nil then
						local var_113_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_14.prefab_name].transform, "story_v_out_322211", "322211027", "story_v_out_322211.awb")

						arg_110_1:RecordAudio("322211027", var_113_20)
						arg_110_1:RecordAudio("322211027", var_113_20)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_322211", "322211027", "story_v_out_322211.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_322211", "322211027", "story_v_out_322211.awb")
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
	Play322211028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 322211028
		arg_114_1.duration_ = 7.57

		local var_114_0 = {
			zh = 4.8,
			ja = 7.566
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
				arg_114_0:Play322211029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = arg_114_1.actors_["1111ui_story"]
			local var_117_1 = 0

			if var_117_1 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1111ui_story == nil then
				arg_114_1.var_.characterEffect1111ui_story = var_117_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_2 = 0.200000002980232

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_2 and not isNil(var_117_0) then
				local var_117_3 = (arg_114_1.time_ - var_117_1) / var_117_2

				if arg_114_1.var_.characterEffect1111ui_story and not isNil(var_117_0) then
					arg_114_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= var_117_1 + var_117_2 and arg_114_1.time_ < var_117_1 + var_117_2 + arg_117_0 and not isNil(var_117_0) and arg_114_1.var_.characterEffect1111ui_story then
				arg_114_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_117_4 = arg_114_1.actors_["4037ui_story"]
			local var_117_5 = 0

			if var_117_5 < arg_114_1.time_ and arg_114_1.time_ <= var_117_5 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect4037ui_story == nil then
				arg_114_1.var_.characterEffect4037ui_story = var_117_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.200000002980232

			if var_117_5 <= arg_114_1.time_ and arg_114_1.time_ < var_117_5 + var_117_6 and not isNil(var_117_4) then
				local var_117_7 = (arg_114_1.time_ - var_117_5) / var_117_6

				if arg_114_1.var_.characterEffect4037ui_story and not isNil(var_117_4) then
					local var_117_8 = Mathf.Lerp(0, 0.5, var_117_7)

					arg_114_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_114_1.var_.characterEffect4037ui_story.fillRatio = var_117_8
				end
			end

			if arg_114_1.time_ >= var_117_5 + var_117_6 and arg_114_1.time_ < var_117_5 + var_117_6 + arg_117_0 and not isNil(var_117_4) and arg_114_1.var_.characterEffect4037ui_story then
				local var_117_9 = 0.5

				arg_114_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_114_1.var_.characterEffect4037ui_story.fillRatio = var_117_9
			end

			local var_117_10 = 0

			if var_117_10 < arg_114_1.time_ and arg_114_1.time_ <= var_117_10 + arg_117_0 then
				arg_114_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_117_11 = 0
			local var_117_12 = 0.425

			if var_117_11 < arg_114_1.time_ and arg_114_1.time_ <= var_117_11 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				local var_117_13 = arg_114_1:FormatText(StoryNameCfg[67].name)

				arg_114_1.leftNameTxt_.text = var_117_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_14 = arg_114_1:GetWordFromCfg(322211028)
				local var_117_15 = arg_114_1:FormatText(var_117_14.content)

				arg_114_1.text_.text = var_117_15

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_16 = 17
				local var_117_17 = utf8.len(var_117_15)
				local var_117_18 = var_117_16 <= 0 and var_117_12 or var_117_12 * (var_117_17 / var_117_16)

				if var_117_18 > 0 and var_117_12 < var_117_18 then
					arg_114_1.talkMaxDuration = var_117_18

					if var_117_18 + var_117_11 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_18 + var_117_11
					end
				end

				arg_114_1.text_.text = var_117_15
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211028", "story_v_out_322211.awb") ~= 0 then
					local var_117_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211028", "story_v_out_322211.awb") / 1000

					if var_117_19 + var_117_11 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_19 + var_117_11
					end

					if var_117_14.prefab_name ~= "" and arg_114_1.actors_[var_117_14.prefab_name] ~= nil then
						local var_117_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_14.prefab_name].transform, "story_v_out_322211", "322211028", "story_v_out_322211.awb")

						arg_114_1:RecordAudio("322211028", var_117_20)
						arg_114_1:RecordAudio("322211028", var_117_20)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_322211", "322211028", "story_v_out_322211.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_322211", "322211028", "story_v_out_322211.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_21 = math.max(var_117_12, arg_114_1.talkMaxDuration)

			if var_117_11 <= arg_114_1.time_ and arg_114_1.time_ < var_117_11 + var_117_21 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_11) / var_117_21

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_11 + var_117_21 and arg_114_1.time_ < var_117_11 + var_117_21 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play322211029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 322211029
		arg_118_1.duration_ = 1.93

		local var_118_0 = {
			zh = 1.933,
			ja = 1.666
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
				arg_118_0:Play322211030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = arg_118_1.actors_["4037ui_story"]
			local var_121_1 = 0

			if var_121_1 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect4037ui_story == nil then
				arg_118_1.var_.characterEffect4037ui_story = var_121_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if var_121_1 <= arg_118_1.time_ and arg_118_1.time_ < var_121_1 + var_121_2 and not isNil(var_121_0) then
				local var_121_3 = (arg_118_1.time_ - var_121_1) / var_121_2

				if arg_118_1.var_.characterEffect4037ui_story and not isNil(var_121_0) then
					arg_118_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_1 + var_121_2 and arg_118_1.time_ < var_121_1 + var_121_2 + arg_121_0 and not isNil(var_121_0) and arg_118_1.var_.characterEffect4037ui_story then
				arg_118_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_121_4 = arg_118_1.actors_["1111ui_story"]
			local var_121_5 = 0

			if var_121_5 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect1111ui_story == nil then
				arg_118_1.var_.characterEffect1111ui_story = var_121_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_6 = 0.200000002980232

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 and not isNil(var_121_4) then
				local var_121_7 = (arg_118_1.time_ - var_121_5) / var_121_6

				if arg_118_1.var_.characterEffect1111ui_story and not isNil(var_121_4) then
					local var_121_8 = Mathf.Lerp(0, 0.5, var_121_7)

					arg_118_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1111ui_story.fillRatio = var_121_8
				end
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 and not isNil(var_121_4) and arg_118_1.var_.characterEffect1111ui_story then
				local var_121_9 = 0.5

				arg_118_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1111ui_story.fillRatio = var_121_9
			end

			local var_121_10 = 0
			local var_121_11 = 0.175

			if var_121_10 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_12 = arg_118_1:FormatText(StoryNameCfg[453].name)

				arg_118_1.leftNameTxt_.text = var_121_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_13 = arg_118_1:GetWordFromCfg(322211029)
				local var_121_14 = arg_118_1:FormatText(var_121_13.content)

				arg_118_1.text_.text = var_121_14

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_15 = 7
				local var_121_16 = utf8.len(var_121_14)
				local var_121_17 = var_121_15 <= 0 and var_121_11 or var_121_11 * (var_121_16 / var_121_15)

				if var_121_17 > 0 and var_121_11 < var_121_17 then
					arg_118_1.talkMaxDuration = var_121_17

					if var_121_17 + var_121_10 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_17 + var_121_10
					end
				end

				arg_118_1.text_.text = var_121_14
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211029", "story_v_out_322211.awb") ~= 0 then
					local var_121_18 = manager.audio:GetVoiceLength("story_v_out_322211", "322211029", "story_v_out_322211.awb") / 1000

					if var_121_18 + var_121_10 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_18 + var_121_10
					end

					if var_121_13.prefab_name ~= "" and arg_118_1.actors_[var_121_13.prefab_name] ~= nil then
						local var_121_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_13.prefab_name].transform, "story_v_out_322211", "322211029", "story_v_out_322211.awb")

						arg_118_1:RecordAudio("322211029", var_121_19)
						arg_118_1:RecordAudio("322211029", var_121_19)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_322211", "322211029", "story_v_out_322211.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_322211", "322211029", "story_v_out_322211.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_20 = math.max(var_121_11, arg_118_1.talkMaxDuration)

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_20 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_10) / var_121_20

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_10 + var_121_20 and arg_118_1.time_ < var_121_10 + var_121_20 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play322211030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 322211030
		arg_122_1.duration_ = 3.93

		local var_122_0 = {
			zh = 2.833,
			ja = 3.933
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
				arg_122_0:Play322211031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 0

			if var_125_0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_0 + arg_125_0 then
				arg_122_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_2")
			end

			local var_125_1 = 0
			local var_125_2 = 0.2

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_3 = arg_122_1:FormatText(StoryNameCfg[453].name)

				arg_122_1.leftNameTxt_.text = var_125_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_4 = arg_122_1:GetWordFromCfg(322211030)
				local var_125_5 = arg_122_1:FormatText(var_125_4.content)

				arg_122_1.text_.text = var_125_5

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_6 = 8
				local var_125_7 = utf8.len(var_125_5)
				local var_125_8 = var_125_6 <= 0 and var_125_2 or var_125_2 * (var_125_7 / var_125_6)

				if var_125_8 > 0 and var_125_2 < var_125_8 then
					arg_122_1.talkMaxDuration = var_125_8

					if var_125_8 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_8 + var_125_1
					end
				end

				arg_122_1.text_.text = var_125_5
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211030", "story_v_out_322211.awb") ~= 0 then
					local var_125_9 = manager.audio:GetVoiceLength("story_v_out_322211", "322211030", "story_v_out_322211.awb") / 1000

					if var_125_9 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_9 + var_125_1
					end

					if var_125_4.prefab_name ~= "" and arg_122_1.actors_[var_125_4.prefab_name] ~= nil then
						local var_125_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_4.prefab_name].transform, "story_v_out_322211", "322211030", "story_v_out_322211.awb")

						arg_122_1:RecordAudio("322211030", var_125_10)
						arg_122_1:RecordAudio("322211030", var_125_10)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_322211", "322211030", "story_v_out_322211.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_322211", "322211030", "story_v_out_322211.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_11 = math.max(var_125_2, arg_122_1.talkMaxDuration)

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_11 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_1) / var_125_11

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_1 + var_125_11 and arg_122_1.time_ < var_125_1 + var_125_11 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play322211031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 322211031
		arg_126_1.duration_ = 5.52

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play322211032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1111ui_story"].transform
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 then
				arg_126_1.var_.moveOldPos1111ui_story = var_129_0.localPosition
			end

			local var_129_2 = 0.001

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2
				local var_129_4 = Vector3.New(0, 100, 0)

				var_129_0.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1111ui_story, var_129_4, var_129_3)

				local var_129_5 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_5.x, var_129_5.y, var_129_5.z)

				local var_129_6 = var_129_0.localEulerAngles

				var_129_6.z = 0
				var_129_6.x = 0
				var_129_0.localEulerAngles = var_129_6
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 then
				var_129_0.localPosition = Vector3.New(0, 100, 0)

				local var_129_7 = manager.ui.mainCamera.transform.position - var_129_0.position

				var_129_0.forward = Vector3.New(var_129_7.x, var_129_7.y, var_129_7.z)

				local var_129_8 = var_129_0.localEulerAngles

				var_129_8.z = 0
				var_129_8.x = 0
				var_129_0.localEulerAngles = var_129_8
			end

			local var_129_9 = arg_126_1.actors_["4037ui_story"].transform
			local var_129_10 = 0

			if var_129_10 < arg_126_1.time_ and arg_126_1.time_ <= var_129_10 + arg_129_0 then
				arg_126_1.var_.moveOldPos4037ui_story = var_129_9.localPosition
			end

			local var_129_11 = 0.001

			if var_129_10 <= arg_126_1.time_ and arg_126_1.time_ < var_129_10 + var_129_11 then
				local var_129_12 = (arg_126_1.time_ - var_129_10) / var_129_11
				local var_129_13 = Vector3.New(0, 100, 0)

				var_129_9.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos4037ui_story, var_129_13, var_129_12)

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

			local var_129_18 = manager.ui.mainCamera.transform
			local var_129_19 = 0

			if var_129_19 < arg_126_1.time_ and arg_126_1.time_ <= var_129_19 + arg_129_0 then
				local var_129_20 = arg_126_1.var_.effect1031
				local var_129_21
				local var_129_22 = var_129_18

				if not var_129_20 then
					var_129_20 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue"), var_129_22)
					var_129_20.name = "1031"
					arg_126_1.var_.effect1031 = var_129_20
				else
					var_129_20.transform:SetParent(var_129_22)
				end

				var_129_20.transform.localPosition = Vector3.New(0, 0.45, -5.83)
				var_129_20.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_129_23 = manager.ui.mainCamera.transform
			local var_129_24 = 0

			if var_129_24 < arg_126_1.time_ and arg_126_1.time_ <= var_129_24 + arg_129_0 then
				arg_126_1.var_.shakeOldPos = var_129_23.localPosition
			end

			local var_129_25 = 0.3

			if var_129_24 <= arg_126_1.time_ and arg_126_1.time_ < var_129_24 + var_129_25 then
				local var_129_26 = (arg_126_1.time_ - var_129_24) / 0.066
				local var_129_27, var_129_28 = math.modf(var_129_26)

				var_129_23.localPosition = Vector3.New(var_129_28 * 0.13, var_129_28 * 0.13, var_129_28 * 0.13) + arg_126_1.var_.shakeOldPos
			end

			if arg_126_1.time_ >= var_129_24 + var_129_25 and arg_126_1.time_ < var_129_24 + var_129_25 + arg_129_0 then
				var_129_23.localPosition = arg_126_1.var_.shakeOldPos
			end

			local var_129_29 = 0
			local var_129_30 = 1

			if var_129_29 < arg_126_1.time_ and arg_126_1.time_ <= var_129_29 + arg_129_0 then
				local var_129_31 = "play"
				local var_129_32 = "effect"

				arg_126_1:AudioAction(var_129_31, var_129_32, "se_story_122_02", "se_story_122_02_broken", "")
			end

			local var_129_33 = manager.ui.mainCamera.transform
			local var_129_34 = 0.1

			if var_129_34 < arg_126_1.time_ and arg_126_1.time_ <= var_129_34 + arg_129_0 then
				local var_129_35 = arg_126_1.var_.effect10311
				local var_129_36
				local var_129_37 = var_129_33

				if not var_129_35 then
					var_129_35 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_posui3"), var_129_37)
					var_129_35.name = "10311"
					arg_126_1.var_.effect10311 = var_129_35
				else
					var_129_35.transform:SetParent(var_129_37)
				end

				var_129_35.transform.localPosition = Vector3.New(0, 0, 1.49)
				var_129_35.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_129_38 = manager.ui.mainCamera.transform
			local var_129_39 = 3.16666666666667

			if var_129_39 < arg_126_1.time_ and arg_126_1.time_ <= var_129_39 + arg_129_0 then
				local var_129_40 = arg_126_1.var_.effect10311

				if var_129_40 then
					Object.Destroy(var_129_40)

					arg_126_1.var_.effect10311 = nil
				end
			end

			local var_129_41 = 0

			if var_129_41 < arg_126_1.time_ and arg_126_1.time_ <= var_129_41 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = false

				arg_126_1:SetGaussion(false)
			end

			local var_129_42 = 0.166666666666667

			if var_129_41 <= arg_126_1.time_ and arg_126_1.time_ < var_129_41 + var_129_42 then
				local var_129_43 = (arg_126_1.time_ - var_129_41) / var_129_42
				local var_129_44 = Color.New(1, 1, 1)

				var_129_44.a = Mathf.Lerp(1, 0, var_129_43)
				arg_126_1.mask_.color = var_129_44
			end

			if arg_126_1.time_ >= var_129_41 + var_129_42 and arg_126_1.time_ < var_129_41 + var_129_42 + arg_129_0 then
				local var_129_45 = Color.New(1, 1, 1)
				local var_129_46 = 0

				arg_126_1.mask_.enabled = false
				var_129_45.a = var_129_46
				arg_126_1.mask_.color = var_129_45
			end

			if arg_126_1.frameCnt_ <= 1 then
				arg_126_1.dialog_:SetActive(false)
			end

			local var_129_47 = 0.521887199487537
			local var_129_48 = 1.725

			if var_129_47 < arg_126_1.time_ and arg_126_1.time_ <= var_129_47 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_49 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_49:setOnUpdate(LuaHelper.FloatAction(function(arg_130_0)
					arg_126_1.dialogCg_.alpha = arg_130_0
				end))
				var_129_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, false)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_50 = arg_126_1:GetWordFromCfg(322211031)
				local var_129_51 = arg_126_1:FormatText(var_129_50.content)

				arg_126_1.text_.text = var_129_51

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_52 = 69
				local var_129_53 = utf8.len(var_129_51)
				local var_129_54 = var_129_52 <= 0 and var_129_48 or var_129_48 * (var_129_53 / var_129_52)

				if var_129_54 > 0 and var_129_48 < var_129_54 then
					arg_126_1.talkMaxDuration = var_129_54
					var_129_47 = var_129_47 + 0.3

					if var_129_54 + var_129_47 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_54 + var_129_47
					end
				end

				arg_126_1.text_.text = var_129_51
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_55 = var_129_47 + 0.3
			local var_129_56 = math.max(var_129_48, arg_126_1.talkMaxDuration)

			if var_129_55 <= arg_126_1.time_ and arg_126_1.time_ < var_129_55 + var_129_56 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_55) / var_129_56

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_55 + var_129_56 and arg_126_1.time_ < var_129_55 + var_129_56 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play322211032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 322211032
		arg_132_1.duration_ = 2.13

		local var_132_0 = {
			zh = 1.999999999999,
			ja = 2.133
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
				arg_132_0:Play322211033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["4037ui_story"].transform
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.var_.moveOldPos4037ui_story = var_135_0.localPosition
			end

			local var_135_2 = 0.001

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2
				local var_135_4 = Vector3.New(0, -1.12, -6.2)

				var_135_0.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos4037ui_story, var_135_4, var_135_3)

				local var_135_5 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_5.x, var_135_5.y, var_135_5.z)

				local var_135_6 = var_135_0.localEulerAngles

				var_135_6.z = 0
				var_135_6.x = 0
				var_135_0.localEulerAngles = var_135_6
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 then
				var_135_0.localPosition = Vector3.New(0, -1.12, -6.2)

				local var_135_7 = manager.ui.mainCamera.transform.position - var_135_0.position

				var_135_0.forward = Vector3.New(var_135_7.x, var_135_7.y, var_135_7.z)

				local var_135_8 = var_135_0.localEulerAngles

				var_135_8.z = 0
				var_135_8.x = 0
				var_135_0.localEulerAngles = var_135_8
			end

			local var_135_9 = arg_132_1.actors_["4037ui_story"]
			local var_135_10 = 0

			if var_135_10 < arg_132_1.time_ and arg_132_1.time_ <= var_135_10 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect4037ui_story == nil then
				arg_132_1.var_.characterEffect4037ui_story = var_135_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_11 = 0.200000002980232

			if var_135_10 <= arg_132_1.time_ and arg_132_1.time_ < var_135_10 + var_135_11 and not isNil(var_135_9) then
				local var_135_12 = (arg_132_1.time_ - var_135_10) / var_135_11

				if arg_132_1.var_.characterEffect4037ui_story and not isNil(var_135_9) then
					arg_132_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= var_135_10 + var_135_11 and arg_132_1.time_ < var_135_10 + var_135_11 + arg_135_0 and not isNil(var_135_9) and arg_132_1.var_.characterEffect4037ui_story then
				arg_132_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_135_13 = 0

			if var_135_13 < arg_132_1.time_ and arg_132_1.time_ <= var_135_13 + arg_135_0 then
				arg_132_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_135_14 = 0

			if var_135_14 < arg_132_1.time_ and arg_132_1.time_ <= var_135_14 + arg_135_0 then
				arg_132_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_135_15 = manager.ui.mainCamera.transform
			local var_135_16 = 0

			if var_135_16 < arg_132_1.time_ and arg_132_1.time_ <= var_135_16 + arg_135_0 then
				local var_135_17 = arg_132_1.var_.effect1031

				if var_135_17 then
					Object.Destroy(var_135_17)

					arg_132_1.var_.effect1031 = nil
				end
			end

			local var_135_18 = 0
			local var_135_19 = 0.175

			if var_135_18 < arg_132_1.time_ and arg_132_1.time_ <= var_135_18 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_20 = arg_132_1:FormatText(StoryNameCfg[453].name)

				arg_132_1.leftNameTxt_.text = var_135_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_21 = arg_132_1:GetWordFromCfg(322211032)
				local var_135_22 = arg_132_1:FormatText(var_135_21.content)

				arg_132_1.text_.text = var_135_22

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_23 = 7
				local var_135_24 = utf8.len(var_135_22)
				local var_135_25 = var_135_23 <= 0 and var_135_19 or var_135_19 * (var_135_24 / var_135_23)

				if var_135_25 > 0 and var_135_19 < var_135_25 then
					arg_132_1.talkMaxDuration = var_135_25

					if var_135_25 + var_135_18 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_25 + var_135_18
					end
				end

				arg_132_1.text_.text = var_135_22
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211032", "story_v_out_322211.awb") ~= 0 then
					local var_135_26 = manager.audio:GetVoiceLength("story_v_out_322211", "322211032", "story_v_out_322211.awb") / 1000

					if var_135_26 + var_135_18 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_26 + var_135_18
					end

					if var_135_21.prefab_name ~= "" and arg_132_1.actors_[var_135_21.prefab_name] ~= nil then
						local var_135_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_21.prefab_name].transform, "story_v_out_322211", "322211032", "story_v_out_322211.awb")

						arg_132_1:RecordAudio("322211032", var_135_27)
						arg_132_1:RecordAudio("322211032", var_135_27)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_322211", "322211032", "story_v_out_322211.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_322211", "322211032", "story_v_out_322211.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_28 = math.max(var_135_19, arg_132_1.talkMaxDuration)

			if var_135_18 <= arg_132_1.time_ and arg_132_1.time_ < var_135_18 + var_135_28 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_18) / var_135_28

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_18 + var_135_28 and arg_132_1.time_ < var_135_18 + var_135_28 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play322211033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 322211033
		arg_136_1.duration_ = 5.9

		local var_136_0 = {
			zh = 4.4,
			ja = 5.9
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
				arg_136_0:Play322211034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1111ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos1111ui_story = var_139_0.localPosition
			end

			local var_139_2 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2
				local var_139_4 = Vector3.New(0, -0.87, -5.7)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1111ui_story, var_139_4, var_139_3)

				local var_139_5 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_5.x, var_139_5.y, var_139_5.z)

				local var_139_6 = var_139_0.localEulerAngles

				var_139_6.z = 0
				var_139_6.x = 0
				var_139_0.localEulerAngles = var_139_6
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_139_7 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_7.x, var_139_7.y, var_139_7.z)

				local var_139_8 = var_139_0.localEulerAngles

				var_139_8.z = 0
				var_139_8.x = 0
				var_139_0.localEulerAngles = var_139_8
			end

			local var_139_9 = arg_136_1.actors_["1111ui_story"]
			local var_139_10 = 0

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect1111ui_story == nil then
				arg_136_1.var_.characterEffect1111ui_story = var_139_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_11 = 0.200000002980232

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_11 and not isNil(var_139_9) then
				local var_139_12 = (arg_136_1.time_ - var_139_10) / var_139_11

				if arg_136_1.var_.characterEffect1111ui_story and not isNil(var_139_9) then
					arg_136_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_10 + var_139_11 and arg_136_1.time_ < var_139_10 + var_139_11 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect1111ui_story then
				arg_136_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_139_13 = arg_136_1.actors_["4037ui_story"]
			local var_139_14 = 0

			if var_139_14 < arg_136_1.time_ and arg_136_1.time_ <= var_139_14 + arg_139_0 and not isNil(var_139_13) and arg_136_1.var_.characterEffect4037ui_story == nil then
				arg_136_1.var_.characterEffect4037ui_story = var_139_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_15 = 0.200000002980232

			if var_139_14 <= arg_136_1.time_ and arg_136_1.time_ < var_139_14 + var_139_15 and not isNil(var_139_13) then
				local var_139_16 = (arg_136_1.time_ - var_139_14) / var_139_15

				if arg_136_1.var_.characterEffect4037ui_story and not isNil(var_139_13) then
					local var_139_17 = Mathf.Lerp(0, 0.5, var_139_16)

					arg_136_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_136_1.var_.characterEffect4037ui_story.fillRatio = var_139_17
				end
			end

			if arg_136_1.time_ >= var_139_14 + var_139_15 and arg_136_1.time_ < var_139_14 + var_139_15 + arg_139_0 and not isNil(var_139_13) and arg_136_1.var_.characterEffect4037ui_story then
				local var_139_18 = 0.5

				arg_136_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_136_1.var_.characterEffect4037ui_story.fillRatio = var_139_18
			end

			local var_139_19 = 0

			if var_139_19 < arg_136_1.time_ and arg_136_1.time_ <= var_139_19 + arg_139_0 then
				arg_136_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action9_1")
			end

			local var_139_20 = arg_136_1.actors_["4037ui_story"].transform
			local var_139_21 = 0

			if var_139_21 < arg_136_1.time_ and arg_136_1.time_ <= var_139_21 + arg_139_0 then
				arg_136_1.var_.moveOldPos4037ui_story = var_139_20.localPosition
			end

			local var_139_22 = 0.001

			if var_139_21 <= arg_136_1.time_ and arg_136_1.time_ < var_139_21 + var_139_22 then
				local var_139_23 = (arg_136_1.time_ - var_139_21) / var_139_22
				local var_139_24 = Vector3.New(0, 100, 0)

				var_139_20.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos4037ui_story, var_139_24, var_139_23)

				local var_139_25 = manager.ui.mainCamera.transform.position - var_139_20.position

				var_139_20.forward = Vector3.New(var_139_25.x, var_139_25.y, var_139_25.z)

				local var_139_26 = var_139_20.localEulerAngles

				var_139_26.z = 0
				var_139_26.x = 0
				var_139_20.localEulerAngles = var_139_26
			end

			if arg_136_1.time_ >= var_139_21 + var_139_22 and arg_136_1.time_ < var_139_21 + var_139_22 + arg_139_0 then
				var_139_20.localPosition = Vector3.New(0, 100, 0)

				local var_139_27 = manager.ui.mainCamera.transform.position - var_139_20.position

				var_139_20.forward = Vector3.New(var_139_27.x, var_139_27.y, var_139_27.z)

				local var_139_28 = var_139_20.localEulerAngles

				var_139_28.z = 0
				var_139_28.x = 0
				var_139_20.localEulerAngles = var_139_28
			end

			local var_139_29 = 0
			local var_139_30 = 0.35

			if var_139_29 < arg_136_1.time_ and arg_136_1.time_ <= var_139_29 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_31 = arg_136_1:FormatText(StoryNameCfg[67].name)

				arg_136_1.leftNameTxt_.text = var_139_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_32 = arg_136_1:GetWordFromCfg(322211033)
				local var_139_33 = arg_136_1:FormatText(var_139_32.content)

				arg_136_1.text_.text = var_139_33

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_34 = 14
				local var_139_35 = utf8.len(var_139_33)
				local var_139_36 = var_139_34 <= 0 and var_139_30 or var_139_30 * (var_139_35 / var_139_34)

				if var_139_36 > 0 and var_139_30 < var_139_36 then
					arg_136_1.talkMaxDuration = var_139_36

					if var_139_36 + var_139_29 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_36 + var_139_29
					end
				end

				arg_136_1.text_.text = var_139_33
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211033", "story_v_out_322211.awb") ~= 0 then
					local var_139_37 = manager.audio:GetVoiceLength("story_v_out_322211", "322211033", "story_v_out_322211.awb") / 1000

					if var_139_37 + var_139_29 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_37 + var_139_29
					end

					if var_139_32.prefab_name ~= "" and arg_136_1.actors_[var_139_32.prefab_name] ~= nil then
						local var_139_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_32.prefab_name].transform, "story_v_out_322211", "322211033", "story_v_out_322211.awb")

						arg_136_1:RecordAudio("322211033", var_139_38)
						arg_136_1:RecordAudio("322211033", var_139_38)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_322211", "322211033", "story_v_out_322211.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_322211", "322211033", "story_v_out_322211.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_39 = math.max(var_139_30, arg_136_1.talkMaxDuration)

			if var_139_29 <= arg_136_1.time_ and arg_136_1.time_ < var_139_29 + var_139_39 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_29) / var_139_39

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_29 + var_139_39 and arg_136_1.time_ < var_139_29 + var_139_39 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play322211034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 322211034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play322211035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = arg_140_1.actors_["1111ui_story"].transform
			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.var_.moveOldPos1111ui_story = var_143_0.localPosition
			end

			local var_143_2 = 0.001

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_2 then
				local var_143_3 = (arg_140_1.time_ - var_143_1) / var_143_2
				local var_143_4 = Vector3.New(0, 100, 0)

				var_143_0.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1111ui_story, var_143_4, var_143_3)

				local var_143_5 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_5.x, var_143_5.y, var_143_5.z)

				local var_143_6 = var_143_0.localEulerAngles

				var_143_6.z = 0
				var_143_6.x = 0
				var_143_0.localEulerAngles = var_143_6
			end

			if arg_140_1.time_ >= var_143_1 + var_143_2 and arg_140_1.time_ < var_143_1 + var_143_2 + arg_143_0 then
				var_143_0.localPosition = Vector3.New(0, 100, 0)

				local var_143_7 = manager.ui.mainCamera.transform.position - var_143_0.position

				var_143_0.forward = Vector3.New(var_143_7.x, var_143_7.y, var_143_7.z)

				local var_143_8 = var_143_0.localEulerAngles

				var_143_8.z = 0
				var_143_8.x = 0
				var_143_0.localEulerAngles = var_143_8
			end

			local var_143_9 = 0
			local var_143_10 = 1.25

			if var_143_9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_11 = arg_140_1:GetWordFromCfg(322211034)
				local var_143_12 = arg_140_1:FormatText(var_143_11.content)

				arg_140_1.text_.text = var_143_12

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_13 = 50
				local var_143_14 = utf8.len(var_143_12)
				local var_143_15 = var_143_13 <= 0 and var_143_10 or var_143_10 * (var_143_14 / var_143_13)

				if var_143_15 > 0 and var_143_10 < var_143_15 then
					arg_140_1.talkMaxDuration = var_143_15

					if var_143_15 + var_143_9 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_15 + var_143_9
					end
				end

				arg_140_1.text_.text = var_143_12
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_16 = math.max(var_143_10, arg_140_1.talkMaxDuration)

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_16 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_9) / var_143_16

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_9 + var_143_16 and arg_140_1.time_ < var_143_9 + var_143_16 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
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

		arg_140_1:InitPlayNodeList()
	end,
	Play322211035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 322211035
		arg_144_1.duration_ = 6.4

		local var_144_0 = {
			zh = 3.133,
			ja = 6.4
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
				arg_144_0:Play322211036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1111ui_story"].transform
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.var_.moveOldPos1111ui_story = var_147_0.localPosition
			end

			local var_147_2 = 0.001

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2
				local var_147_4 = Vector3.New(0, -0.87, -5.7)

				var_147_0.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1111ui_story, var_147_4, var_147_3)

				local var_147_5 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_5.x, var_147_5.y, var_147_5.z)

				local var_147_6 = var_147_0.localEulerAngles

				var_147_6.z = 0
				var_147_6.x = 0
				var_147_0.localEulerAngles = var_147_6
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 then
				var_147_0.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_147_7 = manager.ui.mainCamera.transform.position - var_147_0.position

				var_147_0.forward = Vector3.New(var_147_7.x, var_147_7.y, var_147_7.z)

				local var_147_8 = var_147_0.localEulerAngles

				var_147_8.z = 0
				var_147_8.x = 0
				var_147_0.localEulerAngles = var_147_8
			end

			local var_147_9 = arg_144_1.actors_["1111ui_story"]
			local var_147_10 = 0

			if var_147_10 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 and not isNil(var_147_9) and arg_144_1.var_.characterEffect1111ui_story == nil then
				arg_144_1.var_.characterEffect1111ui_story = var_147_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_11 = 0.200000002980232

			if var_147_10 <= arg_144_1.time_ and arg_144_1.time_ < var_147_10 + var_147_11 and not isNil(var_147_9) then
				local var_147_12 = (arg_144_1.time_ - var_147_10) / var_147_11

				if arg_144_1.var_.characterEffect1111ui_story and not isNil(var_147_9) then
					arg_144_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= var_147_10 + var_147_11 and arg_144_1.time_ < var_147_10 + var_147_11 + arg_147_0 and not isNil(var_147_9) and arg_144_1.var_.characterEffect1111ui_story then
				arg_144_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_147_13 = 0
			local var_147_14 = 0.3

			if var_147_13 < arg_144_1.time_ and arg_144_1.time_ <= var_147_13 + arg_147_0 then
				local var_147_15 = "play"
				local var_147_16 = "music"

				arg_144_1:AudioAction(var_147_15, var_147_16, "ui_battle", "ui_battle_stopbgm", "")

				local var_147_17 = ""
				local var_147_18 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_147_18 ~= "" then
					if arg_144_1.bgmTxt_.text ~= var_147_18 and arg_144_1.bgmTxt_.text ~= "" then
						if arg_144_1.bgmTxt2_.text ~= "" then
							arg_144_1.bgmTxt_.text = arg_144_1.bgmTxt2_.text
						end

						arg_144_1.bgmTxt2_.text = var_147_18

						arg_144_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_144_1.bgmTxt_.text = var_147_18
						arg_144_1.bgmTxt2_.text = var_147_18
					end

					if arg_144_1.bgmTimer then
						arg_144_1.bgmTimer:Stop()

						arg_144_1.bgmTimer = nil
					end

					if arg_144_1.settingData.show_music_name == 1 then
						arg_144_1.musicController:SetSelectedState("show")
						arg_144_1.musicAnimator_:Play("open", 0, 0)

						if arg_144_1.settingData.music_time ~= 0 then
							arg_144_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_144_1.settingData.music_time), function()
								if arg_144_1 == nil or isNil(arg_144_1.bgmTxt_) then
									return
								end

								arg_144_1.musicController:SetSelectedState("hide")
								arg_144_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_147_19 = 0
			local var_147_20 = 0.35

			if var_147_19 < arg_144_1.time_ and arg_144_1.time_ <= var_147_19 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_21 = arg_144_1:FormatText(StoryNameCfg[67].name)

				arg_144_1.leftNameTxt_.text = var_147_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_22 = arg_144_1:GetWordFromCfg(322211035)
				local var_147_23 = arg_144_1:FormatText(var_147_22.content)

				arg_144_1.text_.text = var_147_23

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_24 = 14
				local var_147_25 = utf8.len(var_147_23)
				local var_147_26 = var_147_24 <= 0 and var_147_20 or var_147_20 * (var_147_25 / var_147_24)

				if var_147_26 > 0 and var_147_20 < var_147_26 then
					arg_144_1.talkMaxDuration = var_147_26

					if var_147_26 + var_147_19 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_26 + var_147_19
					end
				end

				arg_144_1.text_.text = var_147_23
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211035", "story_v_out_322211.awb") ~= 0 then
					local var_147_27 = manager.audio:GetVoiceLength("story_v_out_322211", "322211035", "story_v_out_322211.awb") / 1000

					if var_147_27 + var_147_19 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_27 + var_147_19
					end

					if var_147_22.prefab_name ~= "" and arg_144_1.actors_[var_147_22.prefab_name] ~= nil then
						local var_147_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_22.prefab_name].transform, "story_v_out_322211", "322211035", "story_v_out_322211.awb")

						arg_144_1:RecordAudio("322211035", var_147_28)
						arg_144_1:RecordAudio("322211035", var_147_28)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_322211", "322211035", "story_v_out_322211.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_322211", "322211035", "story_v_out_322211.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_29 = math.max(var_147_20, arg_144_1.talkMaxDuration)

			if var_147_19 <= arg_144_1.time_ and arg_144_1.time_ < var_147_19 + var_147_29 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_19) / var_147_29

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_19 + var_147_29 and arg_144_1.time_ < var_147_19 + var_147_29 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
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

		arg_144_1:InitPlayNodeList()
	end,
	Play322211036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 322211036
		arg_149_1.duration_ = 13.43

		local var_149_0 = {
			zh = 10.5,
			ja = 13.433
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
				arg_149_0:Play322211037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1111ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos1111ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(-0.79, -0.87, -5.7)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1111ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["10131ui_story"].transform
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 then
				arg_149_1.var_.moveOldPos10131ui_story = var_152_9.localPosition
			end

			local var_152_11 = 0.001

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11
				local var_152_13 = Vector3.New(0.83, -0.96, -5.8)

				var_152_9.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10131ui_story, var_152_13, var_152_12)

				local var_152_14 = manager.ui.mainCamera.transform.position - var_152_9.position

				var_152_9.forward = Vector3.New(var_152_14.x, var_152_14.y, var_152_14.z)

				local var_152_15 = var_152_9.localEulerAngles

				var_152_15.z = 0
				var_152_15.x = 0
				var_152_9.localEulerAngles = var_152_15
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 then
				var_152_9.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_152_16 = manager.ui.mainCamera.transform.position - var_152_9.position

				var_152_9.forward = Vector3.New(var_152_16.x, var_152_16.y, var_152_16.z)

				local var_152_17 = var_152_9.localEulerAngles

				var_152_17.z = 0
				var_152_17.x = 0
				var_152_9.localEulerAngles = var_152_17
			end

			local var_152_18 = arg_149_1.actors_["10131ui_story"]
			local var_152_19 = 0

			if var_152_19 < arg_149_1.time_ and arg_149_1.time_ <= var_152_19 + arg_152_0 and not isNil(var_152_18) and arg_149_1.var_.characterEffect10131ui_story == nil then
				arg_149_1.var_.characterEffect10131ui_story = var_152_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_20 = 0.200000002980232

			if var_152_19 <= arg_149_1.time_ and arg_149_1.time_ < var_152_19 + var_152_20 and not isNil(var_152_18) then
				local var_152_21 = (arg_149_1.time_ - var_152_19) / var_152_20

				if arg_149_1.var_.characterEffect10131ui_story and not isNil(var_152_18) then
					arg_149_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_19 + var_152_20 and arg_149_1.time_ < var_152_19 + var_152_20 + arg_152_0 and not isNil(var_152_18) and arg_149_1.var_.characterEffect10131ui_story then
				arg_149_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_152_22 = arg_149_1.actors_["1111ui_story"]
			local var_152_23 = 0

			if var_152_23 < arg_149_1.time_ and arg_149_1.time_ <= var_152_23 + arg_152_0 and not isNil(var_152_22) and arg_149_1.var_.characterEffect1111ui_story == nil then
				arg_149_1.var_.characterEffect1111ui_story = var_152_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_24 = 0.200000002980232

			if var_152_23 <= arg_149_1.time_ and arg_149_1.time_ < var_152_23 + var_152_24 and not isNil(var_152_22) then
				local var_152_25 = (arg_149_1.time_ - var_152_23) / var_152_24

				if arg_149_1.var_.characterEffect1111ui_story and not isNil(var_152_22) then
					local var_152_26 = Mathf.Lerp(0, 0.5, var_152_25)

					arg_149_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1111ui_story.fillRatio = var_152_26
				end
			end

			if arg_149_1.time_ >= var_152_23 + var_152_24 and arg_149_1.time_ < var_152_23 + var_152_24 + arg_152_0 and not isNil(var_152_22) and arg_149_1.var_.characterEffect1111ui_story then
				local var_152_27 = 0.5

				arg_149_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1111ui_story.fillRatio = var_152_27
			end

			local var_152_28 = 0

			if var_152_28 < arg_149_1.time_ and arg_149_1.time_ <= var_152_28 + arg_152_0 then
				arg_149_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			local var_152_29 = 0

			if var_152_29 < arg_149_1.time_ and arg_149_1.time_ <= var_152_29 + arg_152_0 then
				arg_149_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_152_30 = 0
			local var_152_31 = 1.15

			if var_152_30 < arg_149_1.time_ and arg_149_1.time_ <= var_152_30 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_32 = arg_149_1:FormatText(StoryNameCfg[1178].name)

				arg_149_1.leftNameTxt_.text = var_152_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_33 = arg_149_1:GetWordFromCfg(322211036)
				local var_152_34 = arg_149_1:FormatText(var_152_33.content)

				arg_149_1.text_.text = var_152_34

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_35 = 46
				local var_152_36 = utf8.len(var_152_34)
				local var_152_37 = var_152_35 <= 0 and var_152_31 or var_152_31 * (var_152_36 / var_152_35)

				if var_152_37 > 0 and var_152_31 < var_152_37 then
					arg_149_1.talkMaxDuration = var_152_37

					if var_152_37 + var_152_30 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_37 + var_152_30
					end
				end

				arg_149_1.text_.text = var_152_34
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211036", "story_v_out_322211.awb") ~= 0 then
					local var_152_38 = manager.audio:GetVoiceLength("story_v_out_322211", "322211036", "story_v_out_322211.awb") / 1000

					if var_152_38 + var_152_30 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_38 + var_152_30
					end

					if var_152_33.prefab_name ~= "" and arg_149_1.actors_[var_152_33.prefab_name] ~= nil then
						local var_152_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_33.prefab_name].transform, "story_v_out_322211", "322211036", "story_v_out_322211.awb")

						arg_149_1:RecordAudio("322211036", var_152_39)
						arg_149_1:RecordAudio("322211036", var_152_39)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_322211", "322211036", "story_v_out_322211.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_322211", "322211036", "story_v_out_322211.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_40 = math.max(var_152_31, arg_149_1.talkMaxDuration)

			if var_152_30 <= arg_149_1.time_ and arg_149_1.time_ < var_152_30 + var_152_40 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_30) / var_152_40

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_30 + var_152_40 and arg_149_1.time_ < var_152_30 + var_152_40 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
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
	Play322211037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 322211037
		arg_153_1.duration_ = 2.8

		local var_153_0 = {
			zh = 2,
			ja = 2.8
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
				arg_153_0:Play322211038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1111ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1111ui_story == nil then
				arg_153_1.var_.characterEffect1111ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect1111ui_story and not isNil(var_156_0) then
					arg_153_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1111ui_story then
				arg_153_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_156_4 = arg_153_1.actors_["10131ui_story"]
			local var_156_5 = 0

			if var_156_5 < arg_153_1.time_ and arg_153_1.time_ <= var_156_5 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect10131ui_story == nil then
				arg_153_1.var_.characterEffect10131ui_story = var_156_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_6 = 0.200000002980232

			if var_156_5 <= arg_153_1.time_ and arg_153_1.time_ < var_156_5 + var_156_6 and not isNil(var_156_4) then
				local var_156_7 = (arg_153_1.time_ - var_156_5) / var_156_6

				if arg_153_1.var_.characterEffect10131ui_story and not isNil(var_156_4) then
					local var_156_8 = Mathf.Lerp(0, 0.5, var_156_7)

					arg_153_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_153_1.var_.characterEffect10131ui_story.fillRatio = var_156_8
				end
			end

			if arg_153_1.time_ >= var_156_5 + var_156_6 and arg_153_1.time_ < var_156_5 + var_156_6 + arg_156_0 and not isNil(var_156_4) and arg_153_1.var_.characterEffect10131ui_story then
				local var_156_9 = 0.5

				arg_153_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_153_1.var_.characterEffect10131ui_story.fillRatio = var_156_9
			end

			local var_156_10 = 0
			local var_156_11 = 0.225

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				local var_156_12 = arg_153_1:FormatText(StoryNameCfg[67].name)

				arg_153_1.leftNameTxt_.text = var_156_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_13 = arg_153_1:GetWordFromCfg(322211037)
				local var_156_14 = arg_153_1:FormatText(var_156_13.content)

				arg_153_1.text_.text = var_156_14

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_15 = 9
				local var_156_16 = utf8.len(var_156_14)
				local var_156_17 = var_156_15 <= 0 and var_156_11 or var_156_11 * (var_156_16 / var_156_15)

				if var_156_17 > 0 and var_156_11 < var_156_17 then
					arg_153_1.talkMaxDuration = var_156_17

					if var_156_17 + var_156_10 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_17 + var_156_10
					end
				end

				arg_153_1.text_.text = var_156_14
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211037", "story_v_out_322211.awb") ~= 0 then
					local var_156_18 = manager.audio:GetVoiceLength("story_v_out_322211", "322211037", "story_v_out_322211.awb") / 1000

					if var_156_18 + var_156_10 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_18 + var_156_10
					end

					if var_156_13.prefab_name ~= "" and arg_153_1.actors_[var_156_13.prefab_name] ~= nil then
						local var_156_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_13.prefab_name].transform, "story_v_out_322211", "322211037", "story_v_out_322211.awb")

						arg_153_1:RecordAudio("322211037", var_156_19)
						arg_153_1:RecordAudio("322211037", var_156_19)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_322211", "322211037", "story_v_out_322211.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_322211", "322211037", "story_v_out_322211.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_20 = math.max(var_156_11, arg_153_1.talkMaxDuration)

			if var_156_10 <= arg_153_1.time_ and arg_153_1.time_ < var_156_10 + var_156_20 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_10) / var_156_20

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_10 + var_156_20 and arg_153_1.time_ < var_156_10 + var_156_20 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play322211038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 322211038
		arg_157_1.duration_ = 3

		local var_157_0 = {
			zh = 2.566,
			ja = 3
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
				arg_157_0:Play322211039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10131ui_story"]
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect10131ui_story == nil then
				arg_157_1.var_.characterEffect10131ui_story = var_160_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 and not isNil(var_160_0) then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2

				if arg_157_1.var_.characterEffect10131ui_story and not isNil(var_160_0) then
					arg_157_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 and not isNil(var_160_0) and arg_157_1.var_.characterEffect10131ui_story then
				arg_157_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_160_4 = arg_157_1.actors_["1111ui_story"]
			local var_160_5 = 0

			if var_160_5 < arg_157_1.time_ and arg_157_1.time_ <= var_160_5 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1111ui_story == nil then
				arg_157_1.var_.characterEffect1111ui_story = var_160_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_6 = 0.200000002980232

			if var_160_5 <= arg_157_1.time_ and arg_157_1.time_ < var_160_5 + var_160_6 and not isNil(var_160_4) then
				local var_160_7 = (arg_157_1.time_ - var_160_5) / var_160_6

				if arg_157_1.var_.characterEffect1111ui_story and not isNil(var_160_4) then
					local var_160_8 = Mathf.Lerp(0, 0.5, var_160_7)

					arg_157_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1111ui_story.fillRatio = var_160_8
				end
			end

			if arg_157_1.time_ >= var_160_5 + var_160_6 and arg_157_1.time_ < var_160_5 + var_160_6 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1111ui_story then
				local var_160_9 = 0.5

				arg_157_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1111ui_story.fillRatio = var_160_9
			end

			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 then
				arg_157_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_1")
			end

			local var_160_11 = 0

			if var_160_11 < arg_157_1.time_ and arg_157_1.time_ <= var_160_11 + arg_160_0 then
				arg_157_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_160_12 = 0
			local var_160_13 = 0.175

			if var_160_12 < arg_157_1.time_ and arg_157_1.time_ <= var_160_12 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_14 = arg_157_1:FormatText(StoryNameCfg[1178].name)

				arg_157_1.leftNameTxt_.text = var_160_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_15 = arg_157_1:GetWordFromCfg(322211038)
				local var_160_16 = arg_157_1:FormatText(var_160_15.content)

				arg_157_1.text_.text = var_160_16

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_17 = 7
				local var_160_18 = utf8.len(var_160_16)
				local var_160_19 = var_160_17 <= 0 and var_160_13 or var_160_13 * (var_160_18 / var_160_17)

				if var_160_19 > 0 and var_160_13 < var_160_19 then
					arg_157_1.talkMaxDuration = var_160_19

					if var_160_19 + var_160_12 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_19 + var_160_12
					end
				end

				arg_157_1.text_.text = var_160_16
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211038", "story_v_out_322211.awb") ~= 0 then
					local var_160_20 = manager.audio:GetVoiceLength("story_v_out_322211", "322211038", "story_v_out_322211.awb") / 1000

					if var_160_20 + var_160_12 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_20 + var_160_12
					end

					if var_160_15.prefab_name ~= "" and arg_157_1.actors_[var_160_15.prefab_name] ~= nil then
						local var_160_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_15.prefab_name].transform, "story_v_out_322211", "322211038", "story_v_out_322211.awb")

						arg_157_1:RecordAudio("322211038", var_160_21)
						arg_157_1:RecordAudio("322211038", var_160_21)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_322211", "322211038", "story_v_out_322211.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_322211", "322211038", "story_v_out_322211.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_22 = math.max(var_160_13, arg_157_1.talkMaxDuration)

			if var_160_12 <= arg_157_1.time_ and arg_157_1.time_ < var_160_12 + var_160_22 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_12) / var_160_22

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_12 + var_160_22 and arg_157_1.time_ < var_160_12 + var_160_22 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play322211039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 322211039
		arg_161_1.duration_ = 4.03

		local var_161_0 = {
			zh = 3.7,
			ja = 4.033
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
				arg_161_0:Play322211040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1111ui_story"]
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1111ui_story == nil then
				arg_161_1.var_.characterEffect1111ui_story = var_164_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 and not isNil(var_164_0) then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2

				if arg_161_1.var_.characterEffect1111ui_story and not isNil(var_164_0) then
					arg_161_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 and not isNil(var_164_0) and arg_161_1.var_.characterEffect1111ui_story then
				arg_161_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_164_4 = arg_161_1.actors_["10131ui_story"]
			local var_164_5 = 0

			if var_164_5 < arg_161_1.time_ and arg_161_1.time_ <= var_164_5 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect10131ui_story == nil then
				arg_161_1.var_.characterEffect10131ui_story = var_164_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if var_164_5 <= arg_161_1.time_ and arg_161_1.time_ < var_164_5 + var_164_6 and not isNil(var_164_4) then
				local var_164_7 = (arg_161_1.time_ - var_164_5) / var_164_6

				if arg_161_1.var_.characterEffect10131ui_story and not isNil(var_164_4) then
					local var_164_8 = Mathf.Lerp(0, 0.5, var_164_7)

					arg_161_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_161_1.var_.characterEffect10131ui_story.fillRatio = var_164_8
				end
			end

			if arg_161_1.time_ >= var_164_5 + var_164_6 and arg_161_1.time_ < var_164_5 + var_164_6 + arg_164_0 and not isNil(var_164_4) and arg_161_1.var_.characterEffect10131ui_story then
				local var_164_9 = 0.5

				arg_161_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_161_1.var_.characterEffect10131ui_story.fillRatio = var_164_9
			end

			local var_164_10 = 0
			local var_164_11 = 0.425

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_12 = arg_161_1:FormatText(StoryNameCfg[67].name)

				arg_161_1.leftNameTxt_.text = var_164_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_13 = arg_161_1:GetWordFromCfg(322211039)
				local var_164_14 = arg_161_1:FormatText(var_164_13.content)

				arg_161_1.text_.text = var_164_14

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_15 = 17
				local var_164_16 = utf8.len(var_164_14)
				local var_164_17 = var_164_15 <= 0 and var_164_11 or var_164_11 * (var_164_16 / var_164_15)

				if var_164_17 > 0 and var_164_11 < var_164_17 then
					arg_161_1.talkMaxDuration = var_164_17

					if var_164_17 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_17 + var_164_10
					end
				end

				arg_161_1.text_.text = var_164_14
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211039", "story_v_out_322211.awb") ~= 0 then
					local var_164_18 = manager.audio:GetVoiceLength("story_v_out_322211", "322211039", "story_v_out_322211.awb") / 1000

					if var_164_18 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_18 + var_164_10
					end

					if var_164_13.prefab_name ~= "" and arg_161_1.actors_[var_164_13.prefab_name] ~= nil then
						local var_164_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_13.prefab_name].transform, "story_v_out_322211", "322211039", "story_v_out_322211.awb")

						arg_161_1:RecordAudio("322211039", var_164_19)
						arg_161_1:RecordAudio("322211039", var_164_19)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_322211", "322211039", "story_v_out_322211.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_322211", "322211039", "story_v_out_322211.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_20 = math.max(var_164_11, arg_161_1.talkMaxDuration)

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_20 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_10) / var_164_20

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_10 + var_164_20 and arg_161_1.time_ < var_164_10 + var_164_20 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play322211040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 322211040
		arg_165_1.duration_ = 4.97

		local var_165_0 = {
			zh = 3.433,
			ja = 4.966
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play322211041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 0

			if var_168_0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_0 + arg_168_0 then
				arg_165_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action9_2")
			end

			local var_168_1 = 0
			local var_168_2 = 0.425

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				local var_168_3 = arg_165_1:FormatText(StoryNameCfg[67].name)

				arg_165_1.leftNameTxt_.text = var_168_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_4 = arg_165_1:GetWordFromCfg(322211040)
				local var_168_5 = arg_165_1:FormatText(var_168_4.content)

				arg_165_1.text_.text = var_168_5

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_6 = 17
				local var_168_7 = utf8.len(var_168_5)
				local var_168_8 = var_168_6 <= 0 and var_168_2 or var_168_2 * (var_168_7 / var_168_6)

				if var_168_8 > 0 and var_168_2 < var_168_8 then
					arg_165_1.talkMaxDuration = var_168_8

					if var_168_8 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_8 + var_168_1
					end
				end

				arg_165_1.text_.text = var_168_5
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211040", "story_v_out_322211.awb") ~= 0 then
					local var_168_9 = manager.audio:GetVoiceLength("story_v_out_322211", "322211040", "story_v_out_322211.awb") / 1000

					if var_168_9 + var_168_1 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_1
					end

					if var_168_4.prefab_name ~= "" and arg_165_1.actors_[var_168_4.prefab_name] ~= nil then
						local var_168_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_4.prefab_name].transform, "story_v_out_322211", "322211040", "story_v_out_322211.awb")

						arg_165_1:RecordAudio("322211040", var_168_10)
						arg_165_1:RecordAudio("322211040", var_168_10)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_322211", "322211040", "story_v_out_322211.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_322211", "322211040", "story_v_out_322211.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_11 = math.max(var_168_2, arg_165_1.talkMaxDuration)

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_11 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_1) / var_168_11

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_1 + var_168_11 and arg_165_1.time_ < var_168_1 + var_168_11 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play322211041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 322211041
		arg_169_1.duration_ = 5.4

		local var_169_0 = {
			zh = 3,
			ja = 5.4
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
				arg_169_0:Play322211042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = arg_169_1.actors_["10131ui_story"]
			local var_172_1 = 0

			if var_172_1 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect10131ui_story == nil then
				arg_169_1.var_.characterEffect10131ui_story = var_172_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_2 = 0.200000002980232

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_2 and not isNil(var_172_0) then
				local var_172_3 = (arg_169_1.time_ - var_172_1) / var_172_2

				if arg_169_1.var_.characterEffect10131ui_story and not isNil(var_172_0) then
					arg_169_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_169_1.time_ >= var_172_1 + var_172_2 and arg_169_1.time_ < var_172_1 + var_172_2 + arg_172_0 and not isNil(var_172_0) and arg_169_1.var_.characterEffect10131ui_story then
				arg_169_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_172_4 = arg_169_1.actors_["1111ui_story"]
			local var_172_5 = 0

			if var_172_5 < arg_169_1.time_ and arg_169_1.time_ <= var_172_5 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect1111ui_story == nil then
				arg_169_1.var_.characterEffect1111ui_story = var_172_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_172_6 = 0.200000002980232

			if var_172_5 <= arg_169_1.time_ and arg_169_1.time_ < var_172_5 + var_172_6 and not isNil(var_172_4) then
				local var_172_7 = (arg_169_1.time_ - var_172_5) / var_172_6

				if arg_169_1.var_.characterEffect1111ui_story and not isNil(var_172_4) then
					local var_172_8 = Mathf.Lerp(0, 0.5, var_172_7)

					arg_169_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_169_1.var_.characterEffect1111ui_story.fillRatio = var_172_8
				end
			end

			if arg_169_1.time_ >= var_172_5 + var_172_6 and arg_169_1.time_ < var_172_5 + var_172_6 + arg_172_0 and not isNil(var_172_4) and arg_169_1.var_.characterEffect1111ui_story then
				local var_172_9 = 0.5

				arg_169_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_169_1.var_.characterEffect1111ui_story.fillRatio = var_172_9
			end

			local var_172_10 = 0

			if var_172_10 < arg_169_1.time_ and arg_169_1.time_ <= var_172_10 + arg_172_0 then
				arg_169_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_2")
			end

			local var_172_11 = 0
			local var_172_12 = 0.35

			if var_172_11 < arg_169_1.time_ and arg_169_1.time_ <= var_172_11 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				local var_172_13 = arg_169_1:FormatText(StoryNameCfg[1178].name)

				arg_169_1.leftNameTxt_.text = var_172_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_14 = arg_169_1:GetWordFromCfg(322211041)
				local var_172_15 = arg_169_1:FormatText(var_172_14.content)

				arg_169_1.text_.text = var_172_15

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_16 = 14
				local var_172_17 = utf8.len(var_172_15)
				local var_172_18 = var_172_16 <= 0 and var_172_12 or var_172_12 * (var_172_17 / var_172_16)

				if var_172_18 > 0 and var_172_12 < var_172_18 then
					arg_169_1.talkMaxDuration = var_172_18

					if var_172_18 + var_172_11 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_18 + var_172_11
					end
				end

				arg_169_1.text_.text = var_172_15
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211041", "story_v_out_322211.awb") ~= 0 then
					local var_172_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211041", "story_v_out_322211.awb") / 1000

					if var_172_19 + var_172_11 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_19 + var_172_11
					end

					if var_172_14.prefab_name ~= "" and arg_169_1.actors_[var_172_14.prefab_name] ~= nil then
						local var_172_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_14.prefab_name].transform, "story_v_out_322211", "322211041", "story_v_out_322211.awb")

						arg_169_1:RecordAudio("322211041", var_172_20)
						arg_169_1:RecordAudio("322211041", var_172_20)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_322211", "322211041", "story_v_out_322211.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_322211", "322211041", "story_v_out_322211.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_21 = math.max(var_172_12, arg_169_1.talkMaxDuration)

			if var_172_11 <= arg_169_1.time_ and arg_169_1.time_ < var_172_11 + var_172_21 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_11) / var_172_21

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_11 + var_172_21 and arg_169_1.time_ < var_172_11 + var_172_21 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play322211042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 322211042
		arg_173_1.duration_ = 6.6

		local var_173_0 = {
			zh = 4.233,
			ja = 6.6
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
				arg_173_0:Play322211043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["1111ui_story"]
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1111ui_story == nil then
				arg_173_1.var_.characterEffect1111ui_story = var_176_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 and not isNil(var_176_0) then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2

				if arg_173_1.var_.characterEffect1111ui_story and not isNil(var_176_0) then
					arg_173_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 and not isNil(var_176_0) and arg_173_1.var_.characterEffect1111ui_story then
				arg_173_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_176_4 = arg_173_1.actors_["10131ui_story"]
			local var_176_5 = 0

			if var_176_5 < arg_173_1.time_ and arg_173_1.time_ <= var_176_5 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect10131ui_story == nil then
				arg_173_1.var_.characterEffect10131ui_story = var_176_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_6 = 0.200000002980232

			if var_176_5 <= arg_173_1.time_ and arg_173_1.time_ < var_176_5 + var_176_6 and not isNil(var_176_4) then
				local var_176_7 = (arg_173_1.time_ - var_176_5) / var_176_6

				if arg_173_1.var_.characterEffect10131ui_story and not isNil(var_176_4) then
					local var_176_8 = Mathf.Lerp(0, 0.5, var_176_7)

					arg_173_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_173_1.var_.characterEffect10131ui_story.fillRatio = var_176_8
				end
			end

			if arg_173_1.time_ >= var_176_5 + var_176_6 and arg_173_1.time_ < var_176_5 + var_176_6 + arg_176_0 and not isNil(var_176_4) and arg_173_1.var_.characterEffect10131ui_story then
				local var_176_9 = 0.5

				arg_173_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_173_1.var_.characterEffect10131ui_story.fillRatio = var_176_9
			end

			local var_176_10 = 0
			local var_176_11 = 0.45

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_12 = arg_173_1:FormatText(StoryNameCfg[67].name)

				arg_173_1.leftNameTxt_.text = var_176_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_13 = arg_173_1:GetWordFromCfg(322211042)
				local var_176_14 = arg_173_1:FormatText(var_176_13.content)

				arg_173_1.text_.text = var_176_14

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_15 = 18
				local var_176_16 = utf8.len(var_176_14)
				local var_176_17 = var_176_15 <= 0 and var_176_11 or var_176_11 * (var_176_16 / var_176_15)

				if var_176_17 > 0 and var_176_11 < var_176_17 then
					arg_173_1.talkMaxDuration = var_176_17

					if var_176_17 + var_176_10 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_17 + var_176_10
					end
				end

				arg_173_1.text_.text = var_176_14
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211042", "story_v_out_322211.awb") ~= 0 then
					local var_176_18 = manager.audio:GetVoiceLength("story_v_out_322211", "322211042", "story_v_out_322211.awb") / 1000

					if var_176_18 + var_176_10 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_18 + var_176_10
					end

					if var_176_13.prefab_name ~= "" and arg_173_1.actors_[var_176_13.prefab_name] ~= nil then
						local var_176_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_13.prefab_name].transform, "story_v_out_322211", "322211042", "story_v_out_322211.awb")

						arg_173_1:RecordAudio("322211042", var_176_19)
						arg_173_1:RecordAudio("322211042", var_176_19)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_322211", "322211042", "story_v_out_322211.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_322211", "322211042", "story_v_out_322211.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_20 = math.max(var_176_11, arg_173_1.talkMaxDuration)

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_20 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_10) / var_176_20

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_10 + var_176_20 and arg_173_1.time_ < var_176_10 + var_176_20 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {}

		arg_173_1:InitPlayNodeList()
	end,
	Play322211043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 322211043
		arg_177_1.duration_ = 7.17

		local var_177_0 = {
			zh = 3.8,
			ja = 7.166
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
				arg_177_0:Play322211044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = 0
			local var_180_1 = 0.525

			if var_180_0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_0 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_2 = arg_177_1:FormatText(StoryNameCfg[67].name)

				arg_177_1.leftNameTxt_.text = var_180_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_3 = arg_177_1:GetWordFromCfg(322211043)
				local var_180_4 = arg_177_1:FormatText(var_180_3.content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211043", "story_v_out_322211.awb") ~= 0 then
					local var_180_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211043", "story_v_out_322211.awb") / 1000

					if var_180_8 + var_180_0 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_8 + var_180_0
					end

					if var_180_3.prefab_name ~= "" and arg_177_1.actors_[var_180_3.prefab_name] ~= nil then
						local var_180_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_3.prefab_name].transform, "story_v_out_322211", "322211043", "story_v_out_322211.awb")

						arg_177_1:RecordAudio("322211043", var_180_9)
						arg_177_1:RecordAudio("322211043", var_180_9)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_322211", "322211043", "story_v_out_322211.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_322211", "322211043", "story_v_out_322211.awb")
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
	Play322211044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 322211044
		arg_181_1.duration_ = 8.3

		local var_181_0 = {
			zh = 6.1,
			ja = 8.3
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
				arg_181_0:Play322211045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = arg_181_1.actors_["10131ui_story"]
			local var_184_1 = 0

			if var_184_1 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect10131ui_story == nil then
				arg_181_1.var_.characterEffect10131ui_story = var_184_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_2 and not isNil(var_184_0) then
				local var_184_3 = (arg_181_1.time_ - var_184_1) / var_184_2

				if arg_181_1.var_.characterEffect10131ui_story and not isNil(var_184_0) then
					arg_181_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= var_184_1 + var_184_2 and arg_181_1.time_ < var_184_1 + var_184_2 + arg_184_0 and not isNil(var_184_0) and arg_181_1.var_.characterEffect10131ui_story then
				arg_181_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_184_4 = arg_181_1.actors_["1111ui_story"]
			local var_184_5 = 0

			if var_184_5 < arg_181_1.time_ and arg_181_1.time_ <= var_184_5 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1111ui_story == nil then
				arg_181_1.var_.characterEffect1111ui_story = var_184_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_6 = 0.200000002980232

			if var_184_5 <= arg_181_1.time_ and arg_181_1.time_ < var_184_5 + var_184_6 and not isNil(var_184_4) then
				local var_184_7 = (arg_181_1.time_ - var_184_5) / var_184_6

				if arg_181_1.var_.characterEffect1111ui_story and not isNil(var_184_4) then
					local var_184_8 = Mathf.Lerp(0, 0.5, var_184_7)

					arg_181_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1111ui_story.fillRatio = var_184_8
				end
			end

			if arg_181_1.time_ >= var_184_5 + var_184_6 and arg_181_1.time_ < var_184_5 + var_184_6 + arg_184_0 and not isNil(var_184_4) and arg_181_1.var_.characterEffect1111ui_story then
				local var_184_9 = 0.5

				arg_181_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1111ui_story.fillRatio = var_184_9
			end

			local var_184_10 = 0

			if var_184_10 < arg_181_1.time_ and arg_181_1.time_ <= var_184_10 + arg_184_0 then
				arg_181_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_184_11 = 0
			local var_184_12 = 0.3

			if var_184_11 < arg_181_1.time_ and arg_181_1.time_ <= var_184_11 + arg_184_0 then
				local var_184_13 = "play"
				local var_184_14 = "music"

				arg_181_1:AudioAction(var_184_13, var_184_14, "ui_battle", "ui_battle_stopbgm", "")

				local var_184_15 = ""
				local var_184_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_184_16 ~= "" then
					if arg_181_1.bgmTxt_.text ~= var_184_16 and arg_181_1.bgmTxt_.text ~= "" then
						if arg_181_1.bgmTxt2_.text ~= "" then
							arg_181_1.bgmTxt_.text = arg_181_1.bgmTxt2_.text
						end

						arg_181_1.bgmTxt2_.text = var_184_16

						arg_181_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_181_1.bgmTxt_.text = var_184_16
						arg_181_1.bgmTxt2_.text = var_184_16
					end

					if arg_181_1.bgmTimer then
						arg_181_1.bgmTimer:Stop()

						arg_181_1.bgmTimer = nil
					end

					if arg_181_1.settingData.show_music_name == 1 then
						arg_181_1.musicController:SetSelectedState("show")
						arg_181_1.musicAnimator_:Play("open", 0, 0)

						if arg_181_1.settingData.music_time ~= 0 then
							arg_181_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_181_1.settingData.music_time), function()
								if arg_181_1 == nil or isNil(arg_181_1.bgmTxt_) then
									return
								end

								arg_181_1.musicController:SetSelectedState("hide")
								arg_181_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_184_17 = 0.466666666666667
			local var_184_18 = 1

			if var_184_17 < arg_181_1.time_ and arg_181_1.time_ <= var_184_17 + arg_184_0 then
				local var_184_19 = "play"
				local var_184_20 = "music"

				arg_181_1:AudioAction(var_184_19, var_184_20, "bgm_activity_4_5_story_ra_piano", "bgm_activity_4_5_story_ra_piano", "bgm_activity_4_5_story_ra_piano.awb")

				local var_184_21 = ""
				local var_184_22 = manager.audio:GetAudioName("bgm_activity_4_5_story_ra_piano", "bgm_activity_4_5_story_ra_piano")

				if var_184_22 ~= "" then
					if arg_181_1.bgmTxt_.text ~= var_184_22 and arg_181_1.bgmTxt_.text ~= "" then
						if arg_181_1.bgmTxt2_.text ~= "" then
							arg_181_1.bgmTxt_.text = arg_181_1.bgmTxt2_.text
						end

						arg_181_1.bgmTxt2_.text = var_184_22

						arg_181_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_181_1.bgmTxt_.text = var_184_22
						arg_181_1.bgmTxt2_.text = var_184_22
					end

					if arg_181_1.bgmTimer then
						arg_181_1.bgmTimer:Stop()

						arg_181_1.bgmTimer = nil
					end

					if arg_181_1.settingData.show_music_name == 1 then
						arg_181_1.musicController:SetSelectedState("show")
						arg_181_1.musicAnimator_:Play("open", 0, 0)

						if arg_181_1.settingData.music_time ~= 0 then
							arg_181_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_181_1.settingData.music_time), function()
								if arg_181_1 == nil or isNil(arg_181_1.bgmTxt_) then
									return
								end

								arg_181_1.musicController:SetSelectedState("hide")
								arg_181_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_184_23 = 0
			local var_184_24 = 0.5

			if var_184_23 < arg_181_1.time_ and arg_181_1.time_ <= var_184_23 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				local var_184_25 = arg_181_1:FormatText(StoryNameCfg[1178].name)

				arg_181_1.leftNameTxt_.text = var_184_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_26 = arg_181_1:GetWordFromCfg(322211044)
				local var_184_27 = arg_181_1:FormatText(var_184_26.content)

				arg_181_1.text_.text = var_184_27

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_28 = 20
				local var_184_29 = utf8.len(var_184_27)
				local var_184_30 = var_184_28 <= 0 and var_184_24 or var_184_24 * (var_184_29 / var_184_28)

				if var_184_30 > 0 and var_184_24 < var_184_30 then
					arg_181_1.talkMaxDuration = var_184_30

					if var_184_30 + var_184_23 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_30 + var_184_23
					end
				end

				arg_181_1.text_.text = var_184_27
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211044", "story_v_out_322211.awb") ~= 0 then
					local var_184_31 = manager.audio:GetVoiceLength("story_v_out_322211", "322211044", "story_v_out_322211.awb") / 1000

					if var_184_31 + var_184_23 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_31 + var_184_23
					end

					if var_184_26.prefab_name ~= "" and arg_181_1.actors_[var_184_26.prefab_name] ~= nil then
						local var_184_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_26.prefab_name].transform, "story_v_out_322211", "322211044", "story_v_out_322211.awb")

						arg_181_1:RecordAudio("322211044", var_184_32)
						arg_181_1:RecordAudio("322211044", var_184_32)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_322211", "322211044", "story_v_out_322211.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_322211", "322211044", "story_v_out_322211.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_33 = math.max(var_184_24, arg_181_1.talkMaxDuration)

			if var_184_23 <= arg_181_1.time_ and arg_181_1.time_ < var_184_23 + var_184_33 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_23) / var_184_33

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_23 + var_184_33 and arg_181_1.time_ < var_184_23 + var_184_33 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play322211045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 322211045
		arg_187_1.duration_ = 4.97

		local var_187_0 = {
			zh = 3.366,
			ja = 4.966
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play322211046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1111ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1111ui_story == nil then
				arg_187_1.var_.characterEffect1111ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1111ui_story and not isNil(var_190_0) then
					arg_187_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1111ui_story then
				arg_187_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_190_4 = arg_187_1.actors_["10131ui_story"]
			local var_190_5 = 0

			if var_190_5 < arg_187_1.time_ and arg_187_1.time_ <= var_190_5 + arg_190_0 and not isNil(var_190_4) and arg_187_1.var_.characterEffect10131ui_story == nil then
				arg_187_1.var_.characterEffect10131ui_story = var_190_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_6 = 0.200000002980232

			if var_190_5 <= arg_187_1.time_ and arg_187_1.time_ < var_190_5 + var_190_6 and not isNil(var_190_4) then
				local var_190_7 = (arg_187_1.time_ - var_190_5) / var_190_6

				if arg_187_1.var_.characterEffect10131ui_story and not isNil(var_190_4) then
					local var_190_8 = Mathf.Lerp(0, 0.5, var_190_7)

					arg_187_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10131ui_story.fillRatio = var_190_8
				end
			end

			if arg_187_1.time_ >= var_190_5 + var_190_6 and arg_187_1.time_ < var_190_5 + var_190_6 + arg_190_0 and not isNil(var_190_4) and arg_187_1.var_.characterEffect10131ui_story then
				local var_190_9 = 0.5

				arg_187_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10131ui_story.fillRatio = var_190_9
			end

			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 then
				arg_187_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_190_11 = 0

			if var_190_11 < arg_187_1.time_ and arg_187_1.time_ <= var_190_11 + arg_190_0 then
				arg_187_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_190_12 = 0
			local var_190_13 = 0.2

			if var_190_12 < arg_187_1.time_ and arg_187_1.time_ <= var_190_12 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_14 = arg_187_1:FormatText(StoryNameCfg[67].name)

				arg_187_1.leftNameTxt_.text = var_190_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_15 = arg_187_1:GetWordFromCfg(322211045)
				local var_190_16 = arg_187_1:FormatText(var_190_15.content)

				arg_187_1.text_.text = var_190_16

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_17 = 8
				local var_190_18 = utf8.len(var_190_16)
				local var_190_19 = var_190_17 <= 0 and var_190_13 or var_190_13 * (var_190_18 / var_190_17)

				if var_190_19 > 0 and var_190_13 < var_190_19 then
					arg_187_1.talkMaxDuration = var_190_19

					if var_190_19 + var_190_12 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_19 + var_190_12
					end
				end

				arg_187_1.text_.text = var_190_16
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211045", "story_v_out_322211.awb") ~= 0 then
					local var_190_20 = manager.audio:GetVoiceLength("story_v_out_322211", "322211045", "story_v_out_322211.awb") / 1000

					if var_190_20 + var_190_12 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_20 + var_190_12
					end

					if var_190_15.prefab_name ~= "" and arg_187_1.actors_[var_190_15.prefab_name] ~= nil then
						local var_190_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_15.prefab_name].transform, "story_v_out_322211", "322211045", "story_v_out_322211.awb")

						arg_187_1:RecordAudio("322211045", var_190_21)
						arg_187_1:RecordAudio("322211045", var_190_21)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_322211", "322211045", "story_v_out_322211.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_322211", "322211045", "story_v_out_322211.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_22 = math.max(var_190_13, arg_187_1.talkMaxDuration)

			if var_190_12 <= arg_187_1.time_ and arg_187_1.time_ < var_190_12 + var_190_22 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_12) / var_190_22

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_12 + var_190_22 and arg_187_1.time_ < var_190_12 + var_190_22 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play322211046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 322211046
		arg_191_1.duration_ = 3.9

		local var_191_0 = {
			zh = 2.8,
			ja = 3.9
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play322211047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10131ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect10131ui_story == nil then
				arg_191_1.var_.characterEffect10131ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 and not isNil(var_194_0) then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect10131ui_story and not isNil(var_194_0) then
					arg_191_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and not isNil(var_194_0) and arg_191_1.var_.characterEffect10131ui_story then
				arg_191_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_194_4 = arg_191_1.actors_["1111ui_story"]
			local var_194_5 = 0

			if var_194_5 < arg_191_1.time_ and arg_191_1.time_ <= var_194_5 + arg_194_0 and not isNil(var_194_4) and arg_191_1.var_.characterEffect1111ui_story == nil then
				arg_191_1.var_.characterEffect1111ui_story = var_194_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_6 = 0.200000002980232

			if var_194_5 <= arg_191_1.time_ and arg_191_1.time_ < var_194_5 + var_194_6 and not isNil(var_194_4) then
				local var_194_7 = (arg_191_1.time_ - var_194_5) / var_194_6

				if arg_191_1.var_.characterEffect1111ui_story and not isNil(var_194_4) then
					local var_194_8 = Mathf.Lerp(0, 0.5, var_194_7)

					arg_191_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_191_1.var_.characterEffect1111ui_story.fillRatio = var_194_8
				end
			end

			if arg_191_1.time_ >= var_194_5 + var_194_6 and arg_191_1.time_ < var_194_5 + var_194_6 + arg_194_0 and not isNil(var_194_4) and arg_191_1.var_.characterEffect1111ui_story then
				local var_194_9 = 0.5

				arg_191_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_191_1.var_.characterEffect1111ui_story.fillRatio = var_194_9
			end

			local var_194_10 = 0
			local var_194_11 = 0.35

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_12 = arg_191_1:FormatText(StoryNameCfg[1178].name)

				arg_191_1.leftNameTxt_.text = var_194_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_13 = arg_191_1:GetWordFromCfg(322211046)
				local var_194_14 = arg_191_1:FormatText(var_194_13.content)

				arg_191_1.text_.text = var_194_14

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_15 = 14
				local var_194_16 = utf8.len(var_194_14)
				local var_194_17 = var_194_15 <= 0 and var_194_11 or var_194_11 * (var_194_16 / var_194_15)

				if var_194_17 > 0 and var_194_11 < var_194_17 then
					arg_191_1.talkMaxDuration = var_194_17

					if var_194_17 + var_194_10 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_17 + var_194_10
					end
				end

				arg_191_1.text_.text = var_194_14
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211046", "story_v_out_322211.awb") ~= 0 then
					local var_194_18 = manager.audio:GetVoiceLength("story_v_out_322211", "322211046", "story_v_out_322211.awb") / 1000

					if var_194_18 + var_194_10 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_18 + var_194_10
					end

					if var_194_13.prefab_name ~= "" and arg_191_1.actors_[var_194_13.prefab_name] ~= nil then
						local var_194_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_13.prefab_name].transform, "story_v_out_322211", "322211046", "story_v_out_322211.awb")

						arg_191_1:RecordAudio("322211046", var_194_19)
						arg_191_1:RecordAudio("322211046", var_194_19)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_322211", "322211046", "story_v_out_322211.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_322211", "322211046", "story_v_out_322211.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_20 = math.max(var_194_11, arg_191_1.talkMaxDuration)

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_20 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_10) / var_194_20

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_10 + var_194_20 and arg_191_1.time_ < var_194_10 + var_194_20 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play322211047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 322211047
		arg_195_1.duration_ = 12.17

		local var_195_0 = {
			zh = 9.733,
			ja = 12.166
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play322211048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = 0
			local var_198_1 = 1.075

			if var_198_0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_0 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_2 = arg_195_1:FormatText(StoryNameCfg[1178].name)

				arg_195_1.leftNameTxt_.text = var_198_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_3 = arg_195_1:GetWordFromCfg(322211047)
				local var_198_4 = arg_195_1:FormatText(var_198_3.content)

				arg_195_1.text_.text = var_198_4

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 43
				local var_198_6 = utf8.len(var_198_4)
				local var_198_7 = var_198_5 <= 0 and var_198_1 or var_198_1 * (var_198_6 / var_198_5)

				if var_198_7 > 0 and var_198_1 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_0
					end
				end

				arg_195_1.text_.text = var_198_4
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211047", "story_v_out_322211.awb") ~= 0 then
					local var_198_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211047", "story_v_out_322211.awb") / 1000

					if var_198_8 + var_198_0 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_8 + var_198_0
					end

					if var_198_3.prefab_name ~= "" and arg_195_1.actors_[var_198_3.prefab_name] ~= nil then
						local var_198_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_3.prefab_name].transform, "story_v_out_322211", "322211047", "story_v_out_322211.awb")

						arg_195_1:RecordAudio("322211047", var_198_9)
						arg_195_1:RecordAudio("322211047", var_198_9)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_322211", "322211047", "story_v_out_322211.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_322211", "322211047", "story_v_out_322211.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_10 = math.max(var_198_1, arg_195_1.talkMaxDuration)

			if var_198_0 <= arg_195_1.time_ and arg_195_1.time_ < var_198_0 + var_198_10 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_0) / var_198_10

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_0 + var_198_10 and arg_195_1.time_ < var_198_0 + var_198_10 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play322211048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 322211048
		arg_199_1.duration_ = 12.13

		local var_199_0 = {
			zh = 9.633,
			ja = 12.133
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play322211049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0
			local var_202_1 = 1.025

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_2 = arg_199_1:FormatText(StoryNameCfg[1178].name)

				arg_199_1.leftNameTxt_.text = var_202_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:GetWordFromCfg(322211048)
				local var_202_4 = arg_199_1:FormatText(var_202_3.content)

				arg_199_1.text_.text = var_202_4

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 41
				local var_202_6 = utf8.len(var_202_4)
				local var_202_7 = var_202_5 <= 0 and var_202_1 or var_202_1 * (var_202_6 / var_202_5)

				if var_202_7 > 0 and var_202_1 < var_202_7 then
					arg_199_1.talkMaxDuration = var_202_7

					if var_202_7 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_7 + var_202_0
					end
				end

				arg_199_1.text_.text = var_202_4
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211048", "story_v_out_322211.awb") ~= 0 then
					local var_202_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211048", "story_v_out_322211.awb") / 1000

					if var_202_8 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_0
					end

					if var_202_3.prefab_name ~= "" and arg_199_1.actors_[var_202_3.prefab_name] ~= nil then
						local var_202_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_3.prefab_name].transform, "story_v_out_322211", "322211048", "story_v_out_322211.awb")

						arg_199_1:RecordAudio("322211048", var_202_9)
						arg_199_1:RecordAudio("322211048", var_202_9)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_322211", "322211048", "story_v_out_322211.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_322211", "322211048", "story_v_out_322211.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_10 = math.max(var_202_1, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_10 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_0) / var_202_10

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_10 and arg_199_1.time_ < var_202_0 + var_202_10 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play322211049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 322211049
		arg_203_1.duration_ = 13.97

		local var_203_0 = {
			zh = 11.033,
			ja = 13.966
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play322211050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_206_2 = 0
			local var_206_3 = 1.075

			if var_206_2 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_4 = arg_203_1:FormatText(StoryNameCfg[1178].name)

				arg_203_1.leftNameTxt_.text = var_206_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_5 = arg_203_1:GetWordFromCfg(322211049)
				local var_206_6 = arg_203_1:FormatText(var_206_5.content)

				arg_203_1.text_.text = var_206_6

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_7 = 43
				local var_206_8 = utf8.len(var_206_6)
				local var_206_9 = var_206_7 <= 0 and var_206_3 or var_206_3 * (var_206_8 / var_206_7)

				if var_206_9 > 0 and var_206_3 < var_206_9 then
					arg_203_1.talkMaxDuration = var_206_9

					if var_206_9 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_9 + var_206_2
					end
				end

				arg_203_1.text_.text = var_206_6
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211049", "story_v_out_322211.awb") ~= 0 then
					local var_206_10 = manager.audio:GetVoiceLength("story_v_out_322211", "322211049", "story_v_out_322211.awb") / 1000

					if var_206_10 + var_206_2 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_10 + var_206_2
					end

					if var_206_5.prefab_name ~= "" and arg_203_1.actors_[var_206_5.prefab_name] ~= nil then
						local var_206_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_5.prefab_name].transform, "story_v_out_322211", "322211049", "story_v_out_322211.awb")

						arg_203_1:RecordAudio("322211049", var_206_11)
						arg_203_1:RecordAudio("322211049", var_206_11)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_322211", "322211049", "story_v_out_322211.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_322211", "322211049", "story_v_out_322211.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_12 = math.max(var_206_3, arg_203_1.talkMaxDuration)

			if var_206_2 <= arg_203_1.time_ and arg_203_1.time_ < var_206_2 + var_206_12 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_2) / var_206_12

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_2 + var_206_12 and arg_203_1.time_ < var_206_2 + var_206_12 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play322211050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 322211050
		arg_207_1.duration_ = 2.47

		local var_207_0 = {
			zh = 2.166,
			ja = 2.466
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play322211051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["1111ui_story"]
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1111ui_story == nil then
				arg_207_1.var_.characterEffect1111ui_story = var_210_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 and not isNil(var_210_0) then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2

				if arg_207_1.var_.characterEffect1111ui_story and not isNil(var_210_0) then
					arg_207_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 and not isNil(var_210_0) and arg_207_1.var_.characterEffect1111ui_story then
				arg_207_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_210_4 = arg_207_1.actors_["10131ui_story"]
			local var_210_5 = 0

			if var_210_5 < arg_207_1.time_ and arg_207_1.time_ <= var_210_5 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect10131ui_story == nil then
				arg_207_1.var_.characterEffect10131ui_story = var_210_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_6 = 0.200000002980232

			if var_210_5 <= arg_207_1.time_ and arg_207_1.time_ < var_210_5 + var_210_6 and not isNil(var_210_4) then
				local var_210_7 = (arg_207_1.time_ - var_210_5) / var_210_6

				if arg_207_1.var_.characterEffect10131ui_story and not isNil(var_210_4) then
					local var_210_8 = Mathf.Lerp(0, 0.5, var_210_7)

					arg_207_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10131ui_story.fillRatio = var_210_8
				end
			end

			if arg_207_1.time_ >= var_210_5 + var_210_6 and arg_207_1.time_ < var_210_5 + var_210_6 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect10131ui_story then
				local var_210_9 = 0.5

				arg_207_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10131ui_story.fillRatio = var_210_9
			end

			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 then
				arg_207_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_210_11 = 0
			local var_210_12 = 0.225

			if var_210_11 < arg_207_1.time_ and arg_207_1.time_ <= var_210_11 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_13 = arg_207_1:FormatText(StoryNameCfg[67].name)

				arg_207_1.leftNameTxt_.text = var_210_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_14 = arg_207_1:GetWordFromCfg(322211050)
				local var_210_15 = arg_207_1:FormatText(var_210_14.content)

				arg_207_1.text_.text = var_210_15

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_16 = 9
				local var_210_17 = utf8.len(var_210_15)
				local var_210_18 = var_210_16 <= 0 and var_210_12 or var_210_12 * (var_210_17 / var_210_16)

				if var_210_18 > 0 and var_210_12 < var_210_18 then
					arg_207_1.talkMaxDuration = var_210_18

					if var_210_18 + var_210_11 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_18 + var_210_11
					end
				end

				arg_207_1.text_.text = var_210_15
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211050", "story_v_out_322211.awb") ~= 0 then
					local var_210_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211050", "story_v_out_322211.awb") / 1000

					if var_210_19 + var_210_11 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_19 + var_210_11
					end

					if var_210_14.prefab_name ~= "" and arg_207_1.actors_[var_210_14.prefab_name] ~= nil then
						local var_210_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_14.prefab_name].transform, "story_v_out_322211", "322211050", "story_v_out_322211.awb")

						arg_207_1:RecordAudio("322211050", var_210_20)
						arg_207_1:RecordAudio("322211050", var_210_20)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_322211", "322211050", "story_v_out_322211.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_322211", "322211050", "story_v_out_322211.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_21 = math.max(var_210_12, arg_207_1.talkMaxDuration)

			if var_210_11 <= arg_207_1.time_ and arg_207_1.time_ < var_210_11 + var_210_21 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_11) / var_210_21

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_11 + var_210_21 and arg_207_1.time_ < var_210_11 + var_210_21 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play322211051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 322211051
		arg_211_1.duration_ = 7.43

		local var_211_0 = {
			zh = 5.233,
			ja = 7.433
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play322211052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10131ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect10131ui_story == nil then
				arg_211_1.var_.characterEffect10131ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect10131ui_story and not isNil(var_214_0) then
					arg_211_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect10131ui_story then
				arg_211_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_214_4 = arg_211_1.actors_["1111ui_story"]
			local var_214_5 = 0

			if var_214_5 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect1111ui_story == nil then
				arg_211_1.var_.characterEffect1111ui_story = var_214_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_6 = 0.200000002980232

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_6 and not isNil(var_214_4) then
				local var_214_7 = (arg_211_1.time_ - var_214_5) / var_214_6

				if arg_211_1.var_.characterEffect1111ui_story and not isNil(var_214_4) then
					local var_214_8 = Mathf.Lerp(0, 0.5, var_214_7)

					arg_211_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1111ui_story.fillRatio = var_214_8
				end
			end

			if arg_211_1.time_ >= var_214_5 + var_214_6 and arg_211_1.time_ < var_214_5 + var_214_6 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect1111ui_story then
				local var_214_9 = 0.5

				arg_211_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1111ui_story.fillRatio = var_214_9
			end

			local var_214_10 = 0
			local var_214_11 = 0.6

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_12 = arg_211_1:FormatText(StoryNameCfg[1178].name)

				arg_211_1.leftNameTxt_.text = var_214_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_13 = arg_211_1:GetWordFromCfg(322211051)
				local var_214_14 = arg_211_1:FormatText(var_214_13.content)

				arg_211_1.text_.text = var_214_14

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_15 = 24
				local var_214_16 = utf8.len(var_214_14)
				local var_214_17 = var_214_15 <= 0 and var_214_11 or var_214_11 * (var_214_16 / var_214_15)

				if var_214_17 > 0 and var_214_11 < var_214_17 then
					arg_211_1.talkMaxDuration = var_214_17

					if var_214_17 + var_214_10 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_17 + var_214_10
					end
				end

				arg_211_1.text_.text = var_214_14
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211051", "story_v_out_322211.awb") ~= 0 then
					local var_214_18 = manager.audio:GetVoiceLength("story_v_out_322211", "322211051", "story_v_out_322211.awb") / 1000

					if var_214_18 + var_214_10 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_18 + var_214_10
					end

					if var_214_13.prefab_name ~= "" and arg_211_1.actors_[var_214_13.prefab_name] ~= nil then
						local var_214_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_13.prefab_name].transform, "story_v_out_322211", "322211051", "story_v_out_322211.awb")

						arg_211_1:RecordAudio("322211051", var_214_19)
						arg_211_1:RecordAudio("322211051", var_214_19)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_322211", "322211051", "story_v_out_322211.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_322211", "322211051", "story_v_out_322211.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_20 = math.max(var_214_11, arg_211_1.talkMaxDuration)

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_20 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_10) / var_214_20

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_10 + var_214_20 and arg_211_1.time_ < var_214_10 + var_214_20 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play322211052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 322211052
		arg_215_1.duration_ = 8

		local var_215_0 = {
			zh = 5.8,
			ja = 8
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play322211053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1111ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1111ui_story == nil then
				arg_215_1.var_.characterEffect1111ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect1111ui_story and not isNil(var_218_0) then
					arg_215_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1111ui_story then
				arg_215_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_218_4 = arg_215_1.actors_["10131ui_story"]
			local var_218_5 = 0

			if var_218_5 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect10131ui_story == nil then
				arg_215_1.var_.characterEffect10131ui_story = var_218_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_6 = 0.200000002980232

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_6 and not isNil(var_218_4) then
				local var_218_7 = (arg_215_1.time_ - var_218_5) / var_218_6

				if arg_215_1.var_.characterEffect10131ui_story and not isNil(var_218_4) then
					local var_218_8 = Mathf.Lerp(0, 0.5, var_218_7)

					arg_215_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_215_1.var_.characterEffect10131ui_story.fillRatio = var_218_8
				end
			end

			if arg_215_1.time_ >= var_218_5 + var_218_6 and arg_215_1.time_ < var_218_5 + var_218_6 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect10131ui_story then
				local var_218_9 = 0.5

				arg_215_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_215_1.var_.characterEffect10131ui_story.fillRatio = var_218_9
			end

			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 then
				arg_215_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_2")
			end

			local var_218_11 = 0
			local var_218_12 = 0.7

			if var_218_11 < arg_215_1.time_ and arg_215_1.time_ <= var_218_11 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_13 = arg_215_1:FormatText(StoryNameCfg[67].name)

				arg_215_1.leftNameTxt_.text = var_218_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_14 = arg_215_1:GetWordFromCfg(322211052)
				local var_218_15 = arg_215_1:FormatText(var_218_14.content)

				arg_215_1.text_.text = var_218_15

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_16 = 28
				local var_218_17 = utf8.len(var_218_15)
				local var_218_18 = var_218_16 <= 0 and var_218_12 or var_218_12 * (var_218_17 / var_218_16)

				if var_218_18 > 0 and var_218_12 < var_218_18 then
					arg_215_1.talkMaxDuration = var_218_18

					if var_218_18 + var_218_11 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_18 + var_218_11
					end
				end

				arg_215_1.text_.text = var_218_15
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211052", "story_v_out_322211.awb") ~= 0 then
					local var_218_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211052", "story_v_out_322211.awb") / 1000

					if var_218_19 + var_218_11 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_19 + var_218_11
					end

					if var_218_14.prefab_name ~= "" and arg_215_1.actors_[var_218_14.prefab_name] ~= nil then
						local var_218_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_14.prefab_name].transform, "story_v_out_322211", "322211052", "story_v_out_322211.awb")

						arg_215_1:RecordAudio("322211052", var_218_20)
						arg_215_1:RecordAudio("322211052", var_218_20)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_322211", "322211052", "story_v_out_322211.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_322211", "322211052", "story_v_out_322211.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_21 = math.max(var_218_12, arg_215_1.talkMaxDuration)

			if var_218_11 <= arg_215_1.time_ and arg_215_1.time_ < var_218_11 + var_218_21 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_11) / var_218_21

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_11 + var_218_21 and arg_215_1.time_ < var_218_11 + var_218_21 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play322211053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 322211053
		arg_219_1.duration_ = 8.8

		local var_219_0 = {
			zh = 6.133,
			ja = 8.8
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play322211054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["10131ui_story"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect10131ui_story == nil then
				arg_219_1.var_.characterEffect10131ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.characterEffect10131ui_story and not isNil(var_222_0) then
					arg_219_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect10131ui_story then
				arg_219_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_222_4 = arg_219_1.actors_["1111ui_story"]
			local var_222_5 = 0

			if var_222_5 < arg_219_1.time_ and arg_219_1.time_ <= var_222_5 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect1111ui_story == nil then
				arg_219_1.var_.characterEffect1111ui_story = var_222_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_6 = 0.200000002980232

			if var_222_5 <= arg_219_1.time_ and arg_219_1.time_ < var_222_5 + var_222_6 and not isNil(var_222_4) then
				local var_222_7 = (arg_219_1.time_ - var_222_5) / var_222_6

				if arg_219_1.var_.characterEffect1111ui_story and not isNil(var_222_4) then
					local var_222_8 = Mathf.Lerp(0, 0.5, var_222_7)

					arg_219_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1111ui_story.fillRatio = var_222_8
				end
			end

			if arg_219_1.time_ >= var_222_5 + var_222_6 and arg_219_1.time_ < var_222_5 + var_222_6 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect1111ui_story then
				local var_222_9 = 0.5

				arg_219_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1111ui_story.fillRatio = var_222_9
			end

			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 then
				arg_219_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_222_11 = 0

			if var_222_11 < arg_219_1.time_ and arg_219_1.time_ <= var_222_11 + arg_222_0 then
				arg_219_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_222_12 = 0
			local var_222_13 = 0.7

			if var_222_12 < arg_219_1.time_ and arg_219_1.time_ <= var_222_12 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_14 = arg_219_1:FormatText(StoryNameCfg[1178].name)

				arg_219_1.leftNameTxt_.text = var_222_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_15 = arg_219_1:GetWordFromCfg(322211053)
				local var_222_16 = arg_219_1:FormatText(var_222_15.content)

				arg_219_1.text_.text = var_222_16

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_17 = 28
				local var_222_18 = utf8.len(var_222_16)
				local var_222_19 = var_222_17 <= 0 and var_222_13 or var_222_13 * (var_222_18 / var_222_17)

				if var_222_19 > 0 and var_222_13 < var_222_19 then
					arg_219_1.talkMaxDuration = var_222_19

					if var_222_19 + var_222_12 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_19 + var_222_12
					end
				end

				arg_219_1.text_.text = var_222_16
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211053", "story_v_out_322211.awb") ~= 0 then
					local var_222_20 = manager.audio:GetVoiceLength("story_v_out_322211", "322211053", "story_v_out_322211.awb") / 1000

					if var_222_20 + var_222_12 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_20 + var_222_12
					end

					if var_222_15.prefab_name ~= "" and arg_219_1.actors_[var_222_15.prefab_name] ~= nil then
						local var_222_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_15.prefab_name].transform, "story_v_out_322211", "322211053", "story_v_out_322211.awb")

						arg_219_1:RecordAudio("322211053", var_222_21)
						arg_219_1:RecordAudio("322211053", var_222_21)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_322211", "322211053", "story_v_out_322211.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_322211", "322211053", "story_v_out_322211.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_22 = math.max(var_222_13, arg_219_1.talkMaxDuration)

			if var_222_12 <= arg_219_1.time_ and arg_219_1.time_ < var_222_12 + var_222_22 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_12) / var_222_22

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_12 + var_222_22 and arg_219_1.time_ < var_222_12 + var_222_22 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play322211054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 322211054
		arg_223_1.duration_ = 5.6

		local var_223_0 = {
			zh = 5.6,
			ja = 5.566
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play322211055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["1111ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1111ui_story == nil then
				arg_223_1.var_.characterEffect1111ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 and not isNil(var_226_0) then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect1111ui_story and not isNil(var_226_0) then
					arg_223_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and not isNil(var_226_0) and arg_223_1.var_.characterEffect1111ui_story then
				arg_223_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_226_4 = arg_223_1.actors_["10131ui_story"]
			local var_226_5 = 0

			if var_226_5 < arg_223_1.time_ and arg_223_1.time_ <= var_226_5 + arg_226_0 and not isNil(var_226_4) and arg_223_1.var_.characterEffect10131ui_story == nil then
				arg_223_1.var_.characterEffect10131ui_story = var_226_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_6 = 0.200000002980232

			if var_226_5 <= arg_223_1.time_ and arg_223_1.time_ < var_226_5 + var_226_6 and not isNil(var_226_4) then
				local var_226_7 = (arg_223_1.time_ - var_226_5) / var_226_6

				if arg_223_1.var_.characterEffect10131ui_story and not isNil(var_226_4) then
					local var_226_8 = Mathf.Lerp(0, 0.5, var_226_7)

					arg_223_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_223_1.var_.characterEffect10131ui_story.fillRatio = var_226_8
				end
			end

			if arg_223_1.time_ >= var_226_5 + var_226_6 and arg_223_1.time_ < var_226_5 + var_226_6 + arg_226_0 and not isNil(var_226_4) and arg_223_1.var_.characterEffect10131ui_story then
				local var_226_9 = 0.5

				arg_223_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_223_1.var_.characterEffect10131ui_story.fillRatio = var_226_9
			end

			local var_226_10 = 0
			local var_226_11 = 0.5

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_12 = arg_223_1:FormatText(StoryNameCfg[67].name)

				arg_223_1.leftNameTxt_.text = var_226_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_13 = arg_223_1:GetWordFromCfg(322211054)
				local var_226_14 = arg_223_1:FormatText(var_226_13.content)

				arg_223_1.text_.text = var_226_14

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_15 = 20
				local var_226_16 = utf8.len(var_226_14)
				local var_226_17 = var_226_15 <= 0 and var_226_11 or var_226_11 * (var_226_16 / var_226_15)

				if var_226_17 > 0 and var_226_11 < var_226_17 then
					arg_223_1.talkMaxDuration = var_226_17

					if var_226_17 + var_226_10 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_17 + var_226_10
					end
				end

				arg_223_1.text_.text = var_226_14
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211054", "story_v_out_322211.awb") ~= 0 then
					local var_226_18 = manager.audio:GetVoiceLength("story_v_out_322211", "322211054", "story_v_out_322211.awb") / 1000

					if var_226_18 + var_226_10 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_18 + var_226_10
					end

					if var_226_13.prefab_name ~= "" and arg_223_1.actors_[var_226_13.prefab_name] ~= nil then
						local var_226_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_13.prefab_name].transform, "story_v_out_322211", "322211054", "story_v_out_322211.awb")

						arg_223_1:RecordAudio("322211054", var_226_19)
						arg_223_1:RecordAudio("322211054", var_226_19)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_322211", "322211054", "story_v_out_322211.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_322211", "322211054", "story_v_out_322211.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_20 = math.max(var_226_11, arg_223_1.talkMaxDuration)

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_20 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_10) / var_226_20

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_10 + var_226_20 and arg_223_1.time_ < var_226_10 + var_226_20 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play322211055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 322211055
		arg_227_1.duration_ = 6.4

		local var_227_0 = {
			zh = 3.633,
			ja = 6.4
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
				arg_227_0:Play322211056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.425

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[67].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_3 = arg_227_1:GetWordFromCfg(322211055)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 17
				local var_230_6 = utf8.len(var_230_4)
				local var_230_7 = var_230_5 <= 0 and var_230_1 or var_230_1 * (var_230_6 / var_230_5)

				if var_230_7 > 0 and var_230_1 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211055", "story_v_out_322211.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211055", "story_v_out_322211.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_322211", "322211055", "story_v_out_322211.awb")

						arg_227_1:RecordAudio("322211055", var_230_9)
						arg_227_1:RecordAudio("322211055", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_322211", "322211055", "story_v_out_322211.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_322211", "322211055", "story_v_out_322211.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_10 and arg_227_1.time_ < var_230_0 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play322211056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 322211056
		arg_231_1.duration_ = 5.6

		local var_231_0 = {
			zh = 3.3,
			ja = 5.6
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play322211057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10131ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect10131ui_story == nil then
				arg_231_1.var_.characterEffect10131ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 and not isNil(var_234_0) then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect10131ui_story and not isNil(var_234_0) then
					arg_231_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and not isNil(var_234_0) and arg_231_1.var_.characterEffect10131ui_story then
				arg_231_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_234_4 = arg_231_1.actors_["1111ui_story"]
			local var_234_5 = 0

			if var_234_5 < arg_231_1.time_ and arg_231_1.time_ <= var_234_5 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect1111ui_story == nil then
				arg_231_1.var_.characterEffect1111ui_story = var_234_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_6 = 0.200000002980232

			if var_234_5 <= arg_231_1.time_ and arg_231_1.time_ < var_234_5 + var_234_6 and not isNil(var_234_4) then
				local var_234_7 = (arg_231_1.time_ - var_234_5) / var_234_6

				if arg_231_1.var_.characterEffect1111ui_story and not isNil(var_234_4) then
					local var_234_8 = Mathf.Lerp(0, 0.5, var_234_7)

					arg_231_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_231_1.var_.characterEffect1111ui_story.fillRatio = var_234_8
				end
			end

			if arg_231_1.time_ >= var_234_5 + var_234_6 and arg_231_1.time_ < var_234_5 + var_234_6 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect1111ui_story then
				local var_234_9 = 0.5

				arg_231_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_231_1.var_.characterEffect1111ui_story.fillRatio = var_234_9
			end

			local var_234_10 = 0

			if var_234_10 < arg_231_1.time_ and arg_231_1.time_ <= var_234_10 + arg_234_0 then
				arg_231_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_234_11 = 0

			if var_234_11 < arg_231_1.time_ and arg_231_1.time_ <= var_234_11 + arg_234_0 then
				arg_231_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_234_12 = 0
			local var_234_13 = 0.3

			if var_234_12 < arg_231_1.time_ and arg_231_1.time_ <= var_234_12 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_14 = arg_231_1:FormatText(StoryNameCfg[1178].name)

				arg_231_1.leftNameTxt_.text = var_234_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_15 = arg_231_1:GetWordFromCfg(322211056)
				local var_234_16 = arg_231_1:FormatText(var_234_15.content)

				arg_231_1.text_.text = var_234_16

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_17 = 12
				local var_234_18 = utf8.len(var_234_16)
				local var_234_19 = var_234_17 <= 0 and var_234_13 or var_234_13 * (var_234_18 / var_234_17)

				if var_234_19 > 0 and var_234_13 < var_234_19 then
					arg_231_1.talkMaxDuration = var_234_19

					if var_234_19 + var_234_12 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_19 + var_234_12
					end
				end

				arg_231_1.text_.text = var_234_16
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211056", "story_v_out_322211.awb") ~= 0 then
					local var_234_20 = manager.audio:GetVoiceLength("story_v_out_322211", "322211056", "story_v_out_322211.awb") / 1000

					if var_234_20 + var_234_12 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_20 + var_234_12
					end

					if var_234_15.prefab_name ~= "" and arg_231_1.actors_[var_234_15.prefab_name] ~= nil then
						local var_234_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_15.prefab_name].transform, "story_v_out_322211", "322211056", "story_v_out_322211.awb")

						arg_231_1:RecordAudio("322211056", var_234_21)
						arg_231_1:RecordAudio("322211056", var_234_21)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_322211", "322211056", "story_v_out_322211.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_322211", "322211056", "story_v_out_322211.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_22 = math.max(var_234_13, arg_231_1.talkMaxDuration)

			if var_234_12 <= arg_231_1.time_ and arg_231_1.time_ < var_234_12 + var_234_22 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_12) / var_234_22

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_12 + var_234_22 and arg_231_1.time_ < var_234_12 + var_234_22 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play322211057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 322211057
		arg_235_1.duration_ = 2.87

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play322211058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["1111ui_story"]
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1111ui_story == nil then
				arg_235_1.var_.characterEffect1111ui_story = var_238_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 and not isNil(var_238_0) then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2

				if arg_235_1.var_.characterEffect1111ui_story and not isNil(var_238_0) then
					arg_235_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 and not isNil(var_238_0) and arg_235_1.var_.characterEffect1111ui_story then
				arg_235_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_238_4 = arg_235_1.actors_["10131ui_story"]
			local var_238_5 = 0

			if var_238_5 < arg_235_1.time_ and arg_235_1.time_ <= var_238_5 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect10131ui_story == nil then
				arg_235_1.var_.characterEffect10131ui_story = var_238_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_6 = 0.200000002980232

			if var_238_5 <= arg_235_1.time_ and arg_235_1.time_ < var_238_5 + var_238_6 and not isNil(var_238_4) then
				local var_238_7 = (arg_235_1.time_ - var_238_5) / var_238_6

				if arg_235_1.var_.characterEffect10131ui_story and not isNil(var_238_4) then
					local var_238_8 = Mathf.Lerp(0, 0.5, var_238_7)

					arg_235_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_235_1.var_.characterEffect10131ui_story.fillRatio = var_238_8
				end
			end

			if arg_235_1.time_ >= var_238_5 + var_238_6 and arg_235_1.time_ < var_238_5 + var_238_6 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect10131ui_story then
				local var_238_9 = 0.5

				arg_235_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_235_1.var_.characterEffect10131ui_story.fillRatio = var_238_9
			end

			local var_238_10 = 0

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 then
				arg_235_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_1")
			end

			local var_238_11 = 0

			if var_238_11 < arg_235_1.time_ and arg_235_1.time_ <= var_238_11 + arg_238_0 then
				arg_235_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_238_12 = 0
			local var_238_13 = 0.3

			if var_238_12 < arg_235_1.time_ and arg_235_1.time_ <= var_238_12 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_14 = arg_235_1:FormatText(StoryNameCfg[67].name)

				arg_235_1.leftNameTxt_.text = var_238_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_15 = arg_235_1:GetWordFromCfg(322211057)
				local var_238_16 = arg_235_1:FormatText(var_238_15.content)

				arg_235_1.text_.text = var_238_16

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_17 = 12
				local var_238_18 = utf8.len(var_238_16)
				local var_238_19 = var_238_17 <= 0 and var_238_13 or var_238_13 * (var_238_18 / var_238_17)

				if var_238_19 > 0 and var_238_13 < var_238_19 then
					arg_235_1.talkMaxDuration = var_238_19

					if var_238_19 + var_238_12 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_19 + var_238_12
					end
				end

				arg_235_1.text_.text = var_238_16
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211057", "story_v_out_322211.awb") ~= 0 then
					local var_238_20 = manager.audio:GetVoiceLength("story_v_out_322211", "322211057", "story_v_out_322211.awb") / 1000

					if var_238_20 + var_238_12 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_20 + var_238_12
					end

					if var_238_15.prefab_name ~= "" and arg_235_1.actors_[var_238_15.prefab_name] ~= nil then
						local var_238_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_15.prefab_name].transform, "story_v_out_322211", "322211057", "story_v_out_322211.awb")

						arg_235_1:RecordAudio("322211057", var_238_21)
						arg_235_1:RecordAudio("322211057", var_238_21)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_322211", "322211057", "story_v_out_322211.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_322211", "322211057", "story_v_out_322211.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_22 = math.max(var_238_13, arg_235_1.talkMaxDuration)

			if var_238_12 <= arg_235_1.time_ and arg_235_1.time_ < var_238_12 + var_238_22 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_12) / var_238_22

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_12 + var_238_22 and arg_235_1.time_ < var_238_12 + var_238_22 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play322211058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 322211058
		arg_239_1.duration_ = 3.53

		local var_239_0 = {
			zh = 2.933,
			ja = 3.533
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play322211059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = arg_239_1.actors_["10131ui_story"]
			local var_242_1 = 0

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect10131ui_story == nil then
				arg_239_1.var_.characterEffect10131ui_story = var_242_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_2 and not isNil(var_242_0) then
				local var_242_3 = (arg_239_1.time_ - var_242_1) / var_242_2

				if arg_239_1.var_.characterEffect10131ui_story and not isNil(var_242_0) then
					arg_239_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= var_242_1 + var_242_2 and arg_239_1.time_ < var_242_1 + var_242_2 + arg_242_0 and not isNil(var_242_0) and arg_239_1.var_.characterEffect10131ui_story then
				arg_239_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_242_4 = arg_239_1.actors_["1111ui_story"]
			local var_242_5 = 0

			if var_242_5 < arg_239_1.time_ and arg_239_1.time_ <= var_242_5 + arg_242_0 and not isNil(var_242_4) and arg_239_1.var_.characterEffect1111ui_story == nil then
				arg_239_1.var_.characterEffect1111ui_story = var_242_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_6 = 0.200000002980232

			if var_242_5 <= arg_239_1.time_ and arg_239_1.time_ < var_242_5 + var_242_6 and not isNil(var_242_4) then
				local var_242_7 = (arg_239_1.time_ - var_242_5) / var_242_6

				if arg_239_1.var_.characterEffect1111ui_story and not isNil(var_242_4) then
					local var_242_8 = Mathf.Lerp(0, 0.5, var_242_7)

					arg_239_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_239_1.var_.characterEffect1111ui_story.fillRatio = var_242_8
				end
			end

			if arg_239_1.time_ >= var_242_5 + var_242_6 and arg_239_1.time_ < var_242_5 + var_242_6 + arg_242_0 and not isNil(var_242_4) and arg_239_1.var_.characterEffect1111ui_story then
				local var_242_9 = 0.5

				arg_239_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_239_1.var_.characterEffect1111ui_story.fillRatio = var_242_9
			end

			local var_242_10 = 0

			if var_242_10 < arg_239_1.time_ and arg_239_1.time_ <= var_242_10 + arg_242_0 then
				arg_239_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_242_11 = 0
			local var_242_12 = 0.4

			if var_242_11 < arg_239_1.time_ and arg_239_1.time_ <= var_242_11 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_13 = arg_239_1:FormatText(StoryNameCfg[1178].name)

				arg_239_1.leftNameTxt_.text = var_242_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_14 = arg_239_1:GetWordFromCfg(322211058)
				local var_242_15 = arg_239_1:FormatText(var_242_14.content)

				arg_239_1.text_.text = var_242_15

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_16 = 16
				local var_242_17 = utf8.len(var_242_15)
				local var_242_18 = var_242_16 <= 0 and var_242_12 or var_242_12 * (var_242_17 / var_242_16)

				if var_242_18 > 0 and var_242_12 < var_242_18 then
					arg_239_1.talkMaxDuration = var_242_18

					if var_242_18 + var_242_11 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_18 + var_242_11
					end
				end

				arg_239_1.text_.text = var_242_15
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211058", "story_v_out_322211.awb") ~= 0 then
					local var_242_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211058", "story_v_out_322211.awb") / 1000

					if var_242_19 + var_242_11 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_19 + var_242_11
					end

					if var_242_14.prefab_name ~= "" and arg_239_1.actors_[var_242_14.prefab_name] ~= nil then
						local var_242_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_14.prefab_name].transform, "story_v_out_322211", "322211058", "story_v_out_322211.awb")

						arg_239_1:RecordAudio("322211058", var_242_20)
						arg_239_1:RecordAudio("322211058", var_242_20)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_322211", "322211058", "story_v_out_322211.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_322211", "322211058", "story_v_out_322211.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_21 = math.max(var_242_12, arg_239_1.talkMaxDuration)

			if var_242_11 <= arg_239_1.time_ and arg_239_1.time_ < var_242_11 + var_242_21 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_11) / var_242_21

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_11 + var_242_21 and arg_239_1.time_ < var_242_11 + var_242_21 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play322211059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 322211059
		arg_243_1.duration_ = 12.57

		local var_243_0 = {
			zh = 10,
			ja = 12.566
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
				arg_243_0:Play322211060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_1")
			end

			local var_246_1 = 0
			local var_246_2 = 1.05

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_3 = arg_243_1:FormatText(StoryNameCfg[1178].name)

				arg_243_1.leftNameTxt_.text = var_246_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_4 = arg_243_1:GetWordFromCfg(322211059)
				local var_246_5 = arg_243_1:FormatText(var_246_4.content)

				arg_243_1.text_.text = var_246_5

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_6 = 42
				local var_246_7 = utf8.len(var_246_5)
				local var_246_8 = var_246_6 <= 0 and var_246_2 or var_246_2 * (var_246_7 / var_246_6)

				if var_246_8 > 0 and var_246_2 < var_246_8 then
					arg_243_1.talkMaxDuration = var_246_8

					if var_246_8 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_5
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211059", "story_v_out_322211.awb") ~= 0 then
					local var_246_9 = manager.audio:GetVoiceLength("story_v_out_322211", "322211059", "story_v_out_322211.awb") / 1000

					if var_246_9 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_1
					end

					if var_246_4.prefab_name ~= "" and arg_243_1.actors_[var_246_4.prefab_name] ~= nil then
						local var_246_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_4.prefab_name].transform, "story_v_out_322211", "322211059", "story_v_out_322211.awb")

						arg_243_1:RecordAudio("322211059", var_246_10)
						arg_243_1:RecordAudio("322211059", var_246_10)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_322211", "322211059", "story_v_out_322211.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_322211", "322211059", "story_v_out_322211.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_11 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_11 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_11

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_11 and arg_243_1.time_ < var_246_1 + var_246_11 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play322211060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 322211060
		arg_247_1.duration_ = 4.77

		local var_247_0 = {
			zh = 3.666,
			ja = 4.766
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
				arg_247_0:Play322211061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1111ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1111ui_story == nil then
				arg_247_1.var_.characterEffect1111ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect1111ui_story and not isNil(var_250_0) then
					arg_247_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1111ui_story then
				arg_247_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_250_4 = arg_247_1.actors_["10131ui_story"]
			local var_250_5 = 0

			if var_250_5 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect10131ui_story == nil then
				arg_247_1.var_.characterEffect10131ui_story = var_250_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_6 = 0.200000002980232

			if var_250_5 <= arg_247_1.time_ and arg_247_1.time_ < var_250_5 + var_250_6 and not isNil(var_250_4) then
				local var_250_7 = (arg_247_1.time_ - var_250_5) / var_250_6

				if arg_247_1.var_.characterEffect10131ui_story and not isNil(var_250_4) then
					local var_250_8 = Mathf.Lerp(0, 0.5, var_250_7)

					arg_247_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_247_1.var_.characterEffect10131ui_story.fillRatio = var_250_8
				end
			end

			if arg_247_1.time_ >= var_250_5 + var_250_6 and arg_247_1.time_ < var_250_5 + var_250_6 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect10131ui_story then
				local var_250_9 = 0.5

				arg_247_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_247_1.var_.characterEffect10131ui_story.fillRatio = var_250_9
			end

			local var_250_10 = 0

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 then
				arg_247_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_250_11 = 0

			if var_250_11 < arg_247_1.time_ and arg_247_1.time_ <= var_250_11 + arg_250_0 then
				arg_247_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_250_12 = 0
			local var_250_13 = 0.45

			if var_250_12 < arg_247_1.time_ and arg_247_1.time_ <= var_250_12 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_14 = arg_247_1:FormatText(StoryNameCfg[67].name)

				arg_247_1.leftNameTxt_.text = var_250_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_15 = arg_247_1:GetWordFromCfg(322211060)
				local var_250_16 = arg_247_1:FormatText(var_250_15.content)

				arg_247_1.text_.text = var_250_16

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_17 = 18
				local var_250_18 = utf8.len(var_250_16)
				local var_250_19 = var_250_17 <= 0 and var_250_13 or var_250_13 * (var_250_18 / var_250_17)

				if var_250_19 > 0 and var_250_13 < var_250_19 then
					arg_247_1.talkMaxDuration = var_250_19

					if var_250_19 + var_250_12 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_19 + var_250_12
					end
				end

				arg_247_1.text_.text = var_250_16
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211060", "story_v_out_322211.awb") ~= 0 then
					local var_250_20 = manager.audio:GetVoiceLength("story_v_out_322211", "322211060", "story_v_out_322211.awb") / 1000

					if var_250_20 + var_250_12 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_20 + var_250_12
					end

					if var_250_15.prefab_name ~= "" and arg_247_1.actors_[var_250_15.prefab_name] ~= nil then
						local var_250_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_15.prefab_name].transform, "story_v_out_322211", "322211060", "story_v_out_322211.awb")

						arg_247_1:RecordAudio("322211060", var_250_21)
						arg_247_1:RecordAudio("322211060", var_250_21)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_322211", "322211060", "story_v_out_322211.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_322211", "322211060", "story_v_out_322211.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_22 = math.max(var_250_13, arg_247_1.talkMaxDuration)

			if var_250_12 <= arg_247_1.time_ and arg_247_1.time_ < var_250_12 + var_250_22 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_12) / var_250_22

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_12 + var_250_22 and arg_247_1.time_ < var_250_12 + var_250_22 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play322211061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 322211061
		arg_251_1.duration_ = 4.77

		local var_251_0 = {
			zh = 4.533,
			ja = 4.766
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
				arg_251_0:Play322211062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10131ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect10131ui_story == nil then
				arg_251_1.var_.characterEffect10131ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect10131ui_story and not isNil(var_254_0) then
					arg_251_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect10131ui_story then
				arg_251_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_254_4 = arg_251_1.actors_["1111ui_story"]
			local var_254_5 = 0

			if var_254_5 < arg_251_1.time_ and arg_251_1.time_ <= var_254_5 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect1111ui_story == nil then
				arg_251_1.var_.characterEffect1111ui_story = var_254_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_6 = 0.200000002980232

			if var_254_5 <= arg_251_1.time_ and arg_251_1.time_ < var_254_5 + var_254_6 and not isNil(var_254_4) then
				local var_254_7 = (arg_251_1.time_ - var_254_5) / var_254_6

				if arg_251_1.var_.characterEffect1111ui_story and not isNil(var_254_4) then
					local var_254_8 = Mathf.Lerp(0, 0.5, var_254_7)

					arg_251_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1111ui_story.fillRatio = var_254_8
				end
			end

			if arg_251_1.time_ >= var_254_5 + var_254_6 and arg_251_1.time_ < var_254_5 + var_254_6 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect1111ui_story then
				local var_254_9 = 0.5

				arg_251_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1111ui_story.fillRatio = var_254_9
			end

			local var_254_10 = 0

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 then
				arg_251_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action5_2")
			end

			local var_254_11 = 0
			local var_254_12 = 0.5

			if var_254_11 < arg_251_1.time_ and arg_251_1.time_ <= var_254_11 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_13 = arg_251_1:FormatText(StoryNameCfg[1178].name)

				arg_251_1.leftNameTxt_.text = var_254_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_14 = arg_251_1:GetWordFromCfg(322211061)
				local var_254_15 = arg_251_1:FormatText(var_254_14.content)

				arg_251_1.text_.text = var_254_15

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_16 = 20
				local var_254_17 = utf8.len(var_254_15)
				local var_254_18 = var_254_16 <= 0 and var_254_12 or var_254_12 * (var_254_17 / var_254_16)

				if var_254_18 > 0 and var_254_12 < var_254_18 then
					arg_251_1.talkMaxDuration = var_254_18

					if var_254_18 + var_254_11 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_18 + var_254_11
					end
				end

				arg_251_1.text_.text = var_254_15
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211061", "story_v_out_322211.awb") ~= 0 then
					local var_254_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211061", "story_v_out_322211.awb") / 1000

					if var_254_19 + var_254_11 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_19 + var_254_11
					end

					if var_254_14.prefab_name ~= "" and arg_251_1.actors_[var_254_14.prefab_name] ~= nil then
						local var_254_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_14.prefab_name].transform, "story_v_out_322211", "322211061", "story_v_out_322211.awb")

						arg_251_1:RecordAudio("322211061", var_254_20)
						arg_251_1:RecordAudio("322211061", var_254_20)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_322211", "322211061", "story_v_out_322211.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_322211", "322211061", "story_v_out_322211.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_21 = math.max(var_254_12, arg_251_1.talkMaxDuration)

			if var_254_11 <= arg_251_1.time_ and arg_251_1.time_ < var_254_11 + var_254_21 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_11) / var_254_21

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_11 + var_254_21 and arg_251_1.time_ < var_254_11 + var_254_21 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play322211062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 322211062
		arg_255_1.duration_ = 15.1

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play322211063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = "STblack"

			if arg_255_1.bgs_[var_258_0] == nil then
				local var_258_1 = Object.Instantiate(arg_255_1.paintGo_)

				var_258_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_258_0)
				var_258_1.name = var_258_0
				var_258_1.transform.parent = arg_255_1.stage_.transform
				var_258_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_255_1.bgs_[var_258_0] = var_258_1
			end

			local var_258_2 = 1

			if var_258_2 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				local var_258_3 = manager.ui.mainCamera.transform.localPosition
				local var_258_4 = Vector3.New(0, 0, 10) + Vector3.New(var_258_3.x, var_258_3.y, 0)
				local var_258_5 = arg_255_1.bgs_.STblack

				var_258_5.transform.localPosition = var_258_4
				var_258_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_258_6 = var_258_5:GetComponent("SpriteRenderer")

				if var_258_6 and var_258_6.sprite then
					local var_258_7 = (var_258_5.transform.localPosition - var_258_3).z
					local var_258_8 = manager.ui.mainCameraCom_
					local var_258_9 = 2 * var_258_7 * Mathf.Tan(var_258_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_258_10 = var_258_9 * var_258_8.aspect
					local var_258_11 = var_258_6.sprite.bounds.size.x
					local var_258_12 = var_258_6.sprite.bounds.size.y
					local var_258_13 = var_258_10 / var_258_11
					local var_258_14 = var_258_9 / var_258_12
					local var_258_15 = var_258_14 < var_258_13 and var_258_13 or var_258_14

					var_258_5.transform.localScale = Vector3.New(var_258_15, var_258_15, 0)
				end

				for iter_258_0, iter_258_1 in pairs(arg_255_1.bgs_) do
					if iter_258_0 ~= "STblack" then
						iter_258_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_258_16 = 0

			if var_258_16 < arg_255_1.time_ and arg_255_1.time_ <= var_258_16 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_17 = 1

			if var_258_16 <= arg_255_1.time_ and arg_255_1.time_ < var_258_16 + var_258_17 then
				local var_258_18 = (arg_255_1.time_ - var_258_16) / var_258_17
				local var_258_19 = Color.New(0, 0, 0)

				var_258_19.a = Mathf.Lerp(0, 1, var_258_18)
				arg_255_1.mask_.color = var_258_19
			end

			if arg_255_1.time_ >= var_258_16 + var_258_17 and arg_255_1.time_ < var_258_16 + var_258_17 + arg_258_0 then
				local var_258_20 = Color.New(0, 0, 0)

				var_258_20.a = 1
				arg_255_1.mask_.color = var_258_20
			end

			local var_258_21 = 1

			if var_258_21 < arg_255_1.time_ and arg_255_1.time_ <= var_258_21 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_22 = 1

			if var_258_21 <= arg_255_1.time_ and arg_255_1.time_ < var_258_21 + var_258_22 then
				local var_258_23 = (arg_255_1.time_ - var_258_21) / var_258_22
				local var_258_24 = Color.New(0, 0, 0)

				var_258_24.a = Mathf.Lerp(1, 0, var_258_23)
				arg_255_1.mask_.color = var_258_24
			end

			if arg_255_1.time_ >= var_258_21 + var_258_22 and arg_255_1.time_ < var_258_21 + var_258_22 + arg_258_0 then
				local var_258_25 = Color.New(0, 0, 0)
				local var_258_26 = 0

				arg_255_1.mask_.enabled = false
				var_258_25.a = var_258_26
				arg_255_1.mask_.color = var_258_25
			end

			local var_258_27 = arg_255_1.actors_["1111ui_story"].transform
			local var_258_28 = 1

			if var_258_28 < arg_255_1.time_ and arg_255_1.time_ <= var_258_28 + arg_258_0 then
				arg_255_1.var_.moveOldPos1111ui_story = var_258_27.localPosition
			end

			local var_258_29 = 0.001

			if var_258_28 <= arg_255_1.time_ and arg_255_1.time_ < var_258_28 + var_258_29 then
				local var_258_30 = (arg_255_1.time_ - var_258_28) / var_258_29
				local var_258_31 = Vector3.New(0, 100, 0)

				var_258_27.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1111ui_story, var_258_31, var_258_30)

				local var_258_32 = manager.ui.mainCamera.transform.position - var_258_27.position

				var_258_27.forward = Vector3.New(var_258_32.x, var_258_32.y, var_258_32.z)

				local var_258_33 = var_258_27.localEulerAngles

				var_258_33.z = 0
				var_258_33.x = 0
				var_258_27.localEulerAngles = var_258_33
			end

			if arg_255_1.time_ >= var_258_28 + var_258_29 and arg_255_1.time_ < var_258_28 + var_258_29 + arg_258_0 then
				var_258_27.localPosition = Vector3.New(0, 100, 0)

				local var_258_34 = manager.ui.mainCamera.transform.position - var_258_27.position

				var_258_27.forward = Vector3.New(var_258_34.x, var_258_34.y, var_258_34.z)

				local var_258_35 = var_258_27.localEulerAngles

				var_258_35.z = 0
				var_258_35.x = 0
				var_258_27.localEulerAngles = var_258_35
			end

			local var_258_36 = arg_255_1.actors_["10131ui_story"].transform
			local var_258_37 = 1

			if var_258_37 < arg_255_1.time_ and arg_255_1.time_ <= var_258_37 + arg_258_0 then
				arg_255_1.var_.moveOldPos10131ui_story = var_258_36.localPosition
			end

			local var_258_38 = 0.001

			if var_258_37 <= arg_255_1.time_ and arg_255_1.time_ < var_258_37 + var_258_38 then
				local var_258_39 = (arg_255_1.time_ - var_258_37) / var_258_38
				local var_258_40 = Vector3.New(0, 100, 0)

				var_258_36.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10131ui_story, var_258_40, var_258_39)

				local var_258_41 = manager.ui.mainCamera.transform.position - var_258_36.position

				var_258_36.forward = Vector3.New(var_258_41.x, var_258_41.y, var_258_41.z)

				local var_258_42 = var_258_36.localEulerAngles

				var_258_42.z = 0
				var_258_42.x = 0
				var_258_36.localEulerAngles = var_258_42
			end

			if arg_255_1.time_ >= var_258_37 + var_258_38 and arg_255_1.time_ < var_258_37 + var_258_38 + arg_258_0 then
				var_258_36.localPosition = Vector3.New(0, 100, 0)

				local var_258_43 = manager.ui.mainCamera.transform.position - var_258_36.position

				var_258_36.forward = Vector3.New(var_258_43.x, var_258_43.y, var_258_43.z)

				local var_258_44 = var_258_36.localEulerAngles

				var_258_44.z = 0
				var_258_44.x = 0
				var_258_36.localEulerAngles = var_258_44
			end

			local var_258_45 = 2
			local var_258_46 = 13.1
			local var_258_47 = manager.audio:GetVoiceLength("story_v_out_322211", "322211062", "story_v_out_322211.awb") / 1000

			if var_258_47 > 0 and var_258_46 < var_258_47 and var_258_47 + var_258_45 > arg_255_1.duration_ then
				local var_258_48 = var_258_47

				arg_255_1.duration_ = var_258_47 + var_258_45
			end

			if var_258_45 < arg_255_1.time_ and arg_255_1.time_ <= var_258_45 + arg_258_0 then
				local var_258_49 = "play"
				local var_258_50 = "voice"

				arg_255_1:AudioAction(var_258_49, var_258_50, "story_v_out_322211", "322211062", "story_v_out_322211.awb")
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = false,
				contentID = 419169,
				charCount = 1,
				enableLayoutChange = true,
				duration = 1,
				groupID = "1062",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				textComProperty = {
					fontSize = 110,
					fontAssetPath = "Fonts/SourceHanSerifCN-Bold-3.0",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.MiddleCenter
				}
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322211062,
				charCount = 59,
				enableLayoutChange = true,
				duration = 3.93333333333333,
				groupID = "10621",
				startTime = 1.96666666666667,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play322211063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 322211063
		arg_259_1.duration_ = 8.33

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play322211064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 0
			local var_262_1 = 8.333
			local var_262_2 = manager.audio:GetVoiceLength("story_v_out_322211", "322211063", "story_v_out_322211.awb") / 1000

			if var_262_2 > 0 and var_262_1 < var_262_2 and var_262_2 + var_262_0 > arg_259_1.duration_ then
				local var_262_3 = var_262_2

				arg_259_1.duration_ = var_262_2 + var_262_0
			end

			if var_262_0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_0 + arg_262_0 then
				local var_262_4 = "play"
				local var_262_5 = "voice"

				arg_259_1:AudioAction(var_262_4, var_262_5, "story_v_out_322211", "322211063", "story_v_out_322211.awb")
			end
		end

		arg_259_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322211063,
				charCount = 40,
				enableLayoutChange = true,
				duration = 2.66666666666667,
				groupID = "1063",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "10621",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_259_1:InitPlayNodeList()
	end,
	Play322211064 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 322211064
		arg_263_1.duration_ = 8

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play322211065(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0
			local var_266_1 = 8
			local var_266_2 = manager.audio:GetVoiceLength("story_v_out_322211", "322211064", "story_v_out_322211.awb") / 1000

			if var_266_2 > 0 and var_266_1 < var_266_2 and var_266_2 + var_266_0 > arg_263_1.duration_ then
				local var_266_3 = var_266_2

				arg_263_1.duration_ = var_266_2 + var_266_0
			end

			if var_266_0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_0 + arg_266_0 then
				local var_266_4 = "play"
				local var_266_5 = "voice"

				arg_263_1:AudioAction(var_266_4, var_266_5, "story_v_out_322211", "322211064", "story_v_out_322211.awb")
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322211064,
				charCount = 32,
				enableLayoutChange = true,
				duration = 2.13333333333333,
				groupID = "1064",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "1063",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play322211065 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 322211065
		arg_267_1.duration_ = 6.47

		local var_267_0 = {
			zh = 5.9,
			ja = 6.466
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
				arg_267_0:Play322211066(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = 0

			if var_270_0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_0 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_1 = 1

			if var_270_0 <= arg_267_1.time_ and arg_267_1.time_ < var_270_0 + var_270_1 then
				local var_270_2 = (arg_267_1.time_ - var_270_0) / var_270_1
				local var_270_3 = Color.New(0, 0, 0)

				var_270_3.a = Mathf.Lerp(0, 1, var_270_2)
				arg_267_1.mask_.color = var_270_3
			end

			if arg_267_1.time_ >= var_270_0 + var_270_1 and arg_267_1.time_ < var_270_0 + var_270_1 + arg_270_0 then
				local var_270_4 = Color.New(0, 0, 0)

				var_270_4.a = 1
				arg_267_1.mask_.color = var_270_4
			end

			local var_270_5 = 1

			if var_270_5 < arg_267_1.time_ and arg_267_1.time_ <= var_270_5 + arg_270_0 then
				arg_267_1.mask_.enabled = true
				arg_267_1.mask_.raycastTarget = true

				arg_267_1:SetGaussion(false)
			end

			local var_270_6 = 1

			if var_270_5 <= arg_267_1.time_ and arg_267_1.time_ < var_270_5 + var_270_6 then
				local var_270_7 = (arg_267_1.time_ - var_270_5) / var_270_6
				local var_270_8 = Color.New(0, 0, 0)

				var_270_8.a = Mathf.Lerp(1, 0, var_270_7)
				arg_267_1.mask_.color = var_270_8
			end

			if arg_267_1.time_ >= var_270_5 + var_270_6 and arg_267_1.time_ < var_270_5 + var_270_6 + arg_270_0 then
				local var_270_9 = Color.New(0, 0, 0)
				local var_270_10 = 0

				arg_267_1.mask_.enabled = false
				var_270_9.a = var_270_10
				arg_267_1.mask_.color = var_270_9
			end

			local var_270_11 = 1

			if var_270_11 < arg_267_1.time_ and arg_267_1.time_ <= var_270_11 + arg_270_0 then
				local var_270_12 = manager.ui.mainCamera.transform.localPosition
				local var_270_13 = Vector3.New(0, 0, 10) + Vector3.New(var_270_12.x, var_270_12.y, 0)
				local var_270_14 = arg_267_1.bgs_.L09f

				var_270_14.transform.localPosition = var_270_13
				var_270_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_270_15 = var_270_14:GetComponent("SpriteRenderer")

				if var_270_15 and var_270_15.sprite then
					local var_270_16 = (var_270_14.transform.localPosition - var_270_12).z
					local var_270_17 = manager.ui.mainCameraCom_
					local var_270_18 = 2 * var_270_16 * Mathf.Tan(var_270_17.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_270_19 = var_270_18 * var_270_17.aspect
					local var_270_20 = var_270_15.sprite.bounds.size.x
					local var_270_21 = var_270_15.sprite.bounds.size.y
					local var_270_22 = var_270_19 / var_270_20
					local var_270_23 = var_270_18 / var_270_21
					local var_270_24 = var_270_23 < var_270_22 and var_270_22 or var_270_23

					var_270_14.transform.localScale = Vector3.New(var_270_24, var_270_24, 0)
				end

				for iter_270_0, iter_270_1 in pairs(arg_267_1.bgs_) do
					if iter_270_0 ~= "L09f" then
						iter_270_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_270_25 = arg_267_1.actors_["1111ui_story"].transform
			local var_270_26 = 2

			if var_270_26 < arg_267_1.time_ and arg_267_1.time_ <= var_270_26 + arg_270_0 then
				arg_267_1.var_.moveOldPos1111ui_story = var_270_25.localPosition
			end

			local var_270_27 = 0.001

			if var_270_26 <= arg_267_1.time_ and arg_267_1.time_ < var_270_26 + var_270_27 then
				local var_270_28 = (arg_267_1.time_ - var_270_26) / var_270_27
				local var_270_29 = Vector3.New(-0.79, -0.87, -5.7)

				var_270_25.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos1111ui_story, var_270_29, var_270_28)

				local var_270_30 = manager.ui.mainCamera.transform.position - var_270_25.position

				var_270_25.forward = Vector3.New(var_270_30.x, var_270_30.y, var_270_30.z)

				local var_270_31 = var_270_25.localEulerAngles

				var_270_31.z = 0
				var_270_31.x = 0
				var_270_25.localEulerAngles = var_270_31
			end

			if arg_267_1.time_ >= var_270_26 + var_270_27 and arg_267_1.time_ < var_270_26 + var_270_27 + arg_270_0 then
				var_270_25.localPosition = Vector3.New(-0.79, -0.87, -5.7)

				local var_270_32 = manager.ui.mainCamera.transform.position - var_270_25.position

				var_270_25.forward = Vector3.New(var_270_32.x, var_270_32.y, var_270_32.z)

				local var_270_33 = var_270_25.localEulerAngles

				var_270_33.z = 0
				var_270_33.x = 0
				var_270_25.localEulerAngles = var_270_33
			end

			local var_270_34 = arg_267_1.actors_["1111ui_story"]
			local var_270_35 = 2

			if var_270_35 < arg_267_1.time_ and arg_267_1.time_ <= var_270_35 + arg_270_0 and not isNil(var_270_34) and arg_267_1.var_.characterEffect1111ui_story == nil then
				arg_267_1.var_.characterEffect1111ui_story = var_270_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_36 = 0.200000002980232

			if var_270_35 <= arg_267_1.time_ and arg_267_1.time_ < var_270_35 + var_270_36 and not isNil(var_270_34) then
				local var_270_37 = (arg_267_1.time_ - var_270_35) / var_270_36

				if arg_267_1.var_.characterEffect1111ui_story and not isNil(var_270_34) then
					arg_267_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_35 + var_270_36 and arg_267_1.time_ < var_270_35 + var_270_36 + arg_270_0 and not isNil(var_270_34) and arg_267_1.var_.characterEffect1111ui_story then
				arg_267_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_270_38 = 2

			if var_270_38 < arg_267_1.time_ and arg_267_1.time_ <= var_270_38 + arg_270_0 then
				arg_267_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_270_39 = 2

			if var_270_39 < arg_267_1.time_ and arg_267_1.time_ <= var_270_39 + arg_270_0 then
				arg_267_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_270_40 = 2
			local var_270_41 = 0.35

			if var_270_40 < arg_267_1.time_ and arg_267_1.time_ <= var_270_40 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_42 = arg_267_1:FormatText(StoryNameCfg[67].name)

				arg_267_1.leftNameTxt_.text = var_270_42

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_43 = arg_267_1:GetWordFromCfg(322211065)
				local var_270_44 = arg_267_1:FormatText(var_270_43.content)

				arg_267_1.text_.text = var_270_44

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_45 = 14
				local var_270_46 = utf8.len(var_270_44)
				local var_270_47 = var_270_45 <= 0 and var_270_41 or var_270_41 * (var_270_46 / var_270_45)

				if var_270_47 > 0 and var_270_41 < var_270_47 then
					arg_267_1.talkMaxDuration = var_270_47

					if var_270_47 + var_270_40 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_47 + var_270_40
					end
				end

				arg_267_1.text_.text = var_270_44
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211065", "story_v_out_322211.awb") ~= 0 then
					local var_270_48 = manager.audio:GetVoiceLength("story_v_out_322211", "322211065", "story_v_out_322211.awb") / 1000

					if var_270_48 + var_270_40 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_48 + var_270_40
					end

					if var_270_43.prefab_name ~= "" and arg_267_1.actors_[var_270_43.prefab_name] ~= nil then
						local var_270_49 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_43.prefab_name].transform, "story_v_out_322211", "322211065", "story_v_out_322211.awb")

						arg_267_1:RecordAudio("322211065", var_270_49)
						arg_267_1:RecordAudio("322211065", var_270_49)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_322211", "322211065", "story_v_out_322211.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_322211", "322211065", "story_v_out_322211.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_50 = math.max(var_270_41, arg_267_1.talkMaxDuration)

			if var_270_40 <= arg_267_1.time_ and arg_267_1.time_ < var_270_40 + var_270_50 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_40) / var_270_50

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_40 + var_270_50 and arg_267_1.time_ < var_270_40 + var_270_50 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				groupID = "1062",
				duration = 0.0166666666666668,
				className = "StoryTextGroupNode",
				startTime = 0.983333333333334,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				groupID = "1064",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
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
				groupID = "1064",
				duration = 0.0166666666666666,
				className = "StoryTextGroupNode",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play322211066 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 322211066
		arg_271_1.duration_ = 14.8

		local var_271_0 = {
			zh = 10.866,
			ja = 14.8
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
				arg_271_0:Play322211067(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = arg_271_1.actors_["10131ui_story"]
			local var_274_1 = 0

			if var_274_1 < arg_271_1.time_ and arg_271_1.time_ <= var_274_1 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect10131ui_story == nil then
				arg_271_1.var_.characterEffect10131ui_story = var_274_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if var_274_1 <= arg_271_1.time_ and arg_271_1.time_ < var_274_1 + var_274_2 and not isNil(var_274_0) then
				local var_274_3 = (arg_271_1.time_ - var_274_1) / var_274_2

				if arg_271_1.var_.characterEffect10131ui_story and not isNil(var_274_0) then
					arg_271_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= var_274_1 + var_274_2 and arg_271_1.time_ < var_274_1 + var_274_2 + arg_274_0 and not isNil(var_274_0) and arg_271_1.var_.characterEffect10131ui_story then
				arg_271_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_274_4 = arg_271_1.actors_["1111ui_story"]
			local var_274_5 = 0

			if var_274_5 < arg_271_1.time_ and arg_271_1.time_ <= var_274_5 + arg_274_0 and not isNil(var_274_4) and arg_271_1.var_.characterEffect1111ui_story == nil then
				arg_271_1.var_.characterEffect1111ui_story = var_274_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_6 = 0.200000002980232

			if var_274_5 <= arg_271_1.time_ and arg_271_1.time_ < var_274_5 + var_274_6 and not isNil(var_274_4) then
				local var_274_7 = (arg_271_1.time_ - var_274_5) / var_274_6

				if arg_271_1.var_.characterEffect1111ui_story and not isNil(var_274_4) then
					local var_274_8 = Mathf.Lerp(0, 0.5, var_274_7)

					arg_271_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_271_1.var_.characterEffect1111ui_story.fillRatio = var_274_8
				end
			end

			if arg_271_1.time_ >= var_274_5 + var_274_6 and arg_271_1.time_ < var_274_5 + var_274_6 + arg_274_0 and not isNil(var_274_4) and arg_271_1.var_.characterEffect1111ui_story then
				local var_274_9 = 0.5

				arg_271_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_271_1.var_.characterEffect1111ui_story.fillRatio = var_274_9
			end

			local var_274_10 = 0

			if var_274_10 < arg_271_1.time_ and arg_271_1.time_ <= var_274_10 + arg_274_0 then
				arg_271_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action8_1")
			end

			local var_274_11 = 0

			if var_274_11 < arg_271_1.time_ and arg_271_1.time_ <= var_274_11 + arg_274_0 then
				arg_271_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_274_12 = arg_271_1.actors_["10131ui_story"].transform
			local var_274_13 = 0

			if var_274_13 < arg_271_1.time_ and arg_271_1.time_ <= var_274_13 + arg_274_0 then
				arg_271_1.var_.moveOldPos10131ui_story = var_274_12.localPosition
			end

			local var_274_14 = 0.001

			if var_274_13 <= arg_271_1.time_ and arg_271_1.time_ < var_274_13 + var_274_14 then
				local var_274_15 = (arg_271_1.time_ - var_274_13) / var_274_14
				local var_274_16 = Vector3.New(0.83, -0.96, -5.8)

				var_274_12.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10131ui_story, var_274_16, var_274_15)

				local var_274_17 = manager.ui.mainCamera.transform.position - var_274_12.position

				var_274_12.forward = Vector3.New(var_274_17.x, var_274_17.y, var_274_17.z)

				local var_274_18 = var_274_12.localEulerAngles

				var_274_18.z = 0
				var_274_18.x = 0
				var_274_12.localEulerAngles = var_274_18
			end

			if arg_271_1.time_ >= var_274_13 + var_274_14 and arg_271_1.time_ < var_274_13 + var_274_14 + arg_274_0 then
				var_274_12.localPosition = Vector3.New(0.83, -0.96, -5.8)

				local var_274_19 = manager.ui.mainCamera.transform.position - var_274_12.position

				var_274_12.forward = Vector3.New(var_274_19.x, var_274_19.y, var_274_19.z)

				local var_274_20 = var_274_12.localEulerAngles

				var_274_20.z = 0
				var_274_20.x = 0
				var_274_12.localEulerAngles = var_274_20
			end

			local var_274_21 = 0
			local var_274_22 = 1.2

			if var_274_21 < arg_271_1.time_ and arg_271_1.time_ <= var_274_21 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				local var_274_23 = arg_271_1:FormatText(StoryNameCfg[1178].name)

				arg_271_1.leftNameTxt_.text = var_274_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_24 = arg_271_1:GetWordFromCfg(322211066)
				local var_274_25 = arg_271_1:FormatText(var_274_24.content)

				arg_271_1.text_.text = var_274_25

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_26 = 48
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

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211066", "story_v_out_322211.awb") ~= 0 then
					local var_274_29 = manager.audio:GetVoiceLength("story_v_out_322211", "322211066", "story_v_out_322211.awb") / 1000

					if var_274_29 + var_274_21 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_29 + var_274_21
					end

					if var_274_24.prefab_name ~= "" and arg_271_1.actors_[var_274_24.prefab_name] ~= nil then
						local var_274_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_24.prefab_name].transform, "story_v_out_322211", "322211066", "story_v_out_322211.awb")

						arg_271_1:RecordAudio("322211066", var_274_30)
						arg_271_1:RecordAudio("322211066", var_274_30)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_322211", "322211066", "story_v_out_322211.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_322211", "322211066", "story_v_out_322211.awb")
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
				actorName = "10131ui_story",
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
	Play322211067 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 322211067
		arg_275_1.duration_ = 3.4

		local var_275_0 = {
			zh = 3.4,
			ja = 3.133
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play322211068(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = arg_275_1.actors_["1111ui_story"]
			local var_278_1 = 0

			if var_278_1 < arg_275_1.time_ and arg_275_1.time_ <= var_278_1 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1111ui_story == nil then
				arg_275_1.var_.characterEffect1111ui_story = var_278_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if var_278_1 <= arg_275_1.time_ and arg_275_1.time_ < var_278_1 + var_278_2 and not isNil(var_278_0) then
				local var_278_3 = (arg_275_1.time_ - var_278_1) / var_278_2

				if arg_275_1.var_.characterEffect1111ui_story and not isNil(var_278_0) then
					arg_275_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= var_278_1 + var_278_2 and arg_275_1.time_ < var_278_1 + var_278_2 + arg_278_0 and not isNil(var_278_0) and arg_275_1.var_.characterEffect1111ui_story then
				arg_275_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_278_4 = arg_275_1.actors_["10131ui_story"]
			local var_278_5 = 0

			if var_278_5 < arg_275_1.time_ and arg_275_1.time_ <= var_278_5 + arg_278_0 and not isNil(var_278_4) and arg_275_1.var_.characterEffect10131ui_story == nil then
				arg_275_1.var_.characterEffect10131ui_story = var_278_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_6 = 0.200000002980232

			if var_278_5 <= arg_275_1.time_ and arg_275_1.time_ < var_278_5 + var_278_6 and not isNil(var_278_4) then
				local var_278_7 = (arg_275_1.time_ - var_278_5) / var_278_6

				if arg_275_1.var_.characterEffect10131ui_story and not isNil(var_278_4) then
					local var_278_8 = Mathf.Lerp(0, 0.5, var_278_7)

					arg_275_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_275_1.var_.characterEffect10131ui_story.fillRatio = var_278_8
				end
			end

			if arg_275_1.time_ >= var_278_5 + var_278_6 and arg_275_1.time_ < var_278_5 + var_278_6 + arg_278_0 and not isNil(var_278_4) and arg_275_1.var_.characterEffect10131ui_story then
				local var_278_9 = 0.5

				arg_275_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_275_1.var_.characterEffect10131ui_story.fillRatio = var_278_9
			end

			local var_278_10 = 0

			if var_278_10 < arg_275_1.time_ and arg_275_1.time_ <= var_278_10 + arg_278_0 then
				arg_275_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_1")
			end

			local var_278_11 = 0

			if var_278_11 < arg_275_1.time_ and arg_275_1.time_ <= var_278_11 + arg_278_0 then
				arg_275_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_278_12 = 0
			local var_278_13 = 0.325

			if var_278_12 < arg_275_1.time_ and arg_275_1.time_ <= var_278_12 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				local var_278_14 = arg_275_1:FormatText(StoryNameCfg[67].name)

				arg_275_1.leftNameTxt_.text = var_278_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_15 = arg_275_1:GetWordFromCfg(322211067)
				local var_278_16 = arg_275_1:FormatText(var_278_15.content)

				arg_275_1.text_.text = var_278_16

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_17 = 13
				local var_278_18 = utf8.len(var_278_16)
				local var_278_19 = var_278_17 <= 0 and var_278_13 or var_278_13 * (var_278_18 / var_278_17)

				if var_278_19 > 0 and var_278_13 < var_278_19 then
					arg_275_1.talkMaxDuration = var_278_19

					if var_278_19 + var_278_12 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_19 + var_278_12
					end
				end

				arg_275_1.text_.text = var_278_16
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211067", "story_v_out_322211.awb") ~= 0 then
					local var_278_20 = manager.audio:GetVoiceLength("story_v_out_322211", "322211067", "story_v_out_322211.awb") / 1000

					if var_278_20 + var_278_12 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_20 + var_278_12
					end

					if var_278_15.prefab_name ~= "" and arg_275_1.actors_[var_278_15.prefab_name] ~= nil then
						local var_278_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_15.prefab_name].transform, "story_v_out_322211", "322211067", "story_v_out_322211.awb")

						arg_275_1:RecordAudio("322211067", var_278_21)
						arg_275_1:RecordAudio("322211067", var_278_21)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_322211", "322211067", "story_v_out_322211.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_322211", "322211067", "story_v_out_322211.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_22 = math.max(var_278_13, arg_275_1.talkMaxDuration)

			if var_278_12 <= arg_275_1.time_ and arg_275_1.time_ < var_278_12 + var_278_22 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_12) / var_278_22

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_12 + var_278_22 and arg_275_1.time_ < var_278_12 + var_278_22 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play322211068 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 322211068
		arg_279_1.duration_ = 4.43

		local var_279_0 = {
			zh = 4.433,
			ja = 4.266
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
				arg_279_0:Play322211069(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = arg_279_1.actors_["10131ui_story"]
			local var_282_1 = 0

			if var_282_1 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect10131ui_story == nil then
				arg_279_1.var_.characterEffect10131ui_story = var_282_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_2 = 0.200000002980232

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_2 and not isNil(var_282_0) then
				local var_282_3 = (arg_279_1.time_ - var_282_1) / var_282_2

				if arg_279_1.var_.characterEffect10131ui_story and not isNil(var_282_0) then
					arg_279_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_279_1.time_ >= var_282_1 + var_282_2 and arg_279_1.time_ < var_282_1 + var_282_2 + arg_282_0 and not isNil(var_282_0) and arg_279_1.var_.characterEffect10131ui_story then
				arg_279_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_282_4 = arg_279_1.actors_["1111ui_story"]
			local var_282_5 = 0

			if var_282_5 < arg_279_1.time_ and arg_279_1.time_ <= var_282_5 + arg_282_0 and not isNil(var_282_4) and arg_279_1.var_.characterEffect1111ui_story == nil then
				arg_279_1.var_.characterEffect1111ui_story = var_282_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_6 = 0.200000002980232

			if var_282_5 <= arg_279_1.time_ and arg_279_1.time_ < var_282_5 + var_282_6 and not isNil(var_282_4) then
				local var_282_7 = (arg_279_1.time_ - var_282_5) / var_282_6

				if arg_279_1.var_.characterEffect1111ui_story and not isNil(var_282_4) then
					local var_282_8 = Mathf.Lerp(0, 0.5, var_282_7)

					arg_279_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_279_1.var_.characterEffect1111ui_story.fillRatio = var_282_8
				end
			end

			if arg_279_1.time_ >= var_282_5 + var_282_6 and arg_279_1.time_ < var_282_5 + var_282_6 + arg_282_0 and not isNil(var_282_4) and arg_279_1.var_.characterEffect1111ui_story then
				local var_282_9 = 0.5

				arg_279_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_279_1.var_.characterEffect1111ui_story.fillRatio = var_282_9
			end

			local var_282_10 = 0
			local var_282_11 = 0.4

			if var_282_10 < arg_279_1.time_ and arg_279_1.time_ <= var_282_10 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				local var_282_12 = arg_279_1:FormatText(StoryNameCfg[1178].name)

				arg_279_1.leftNameTxt_.text = var_282_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_13 = arg_279_1:GetWordFromCfg(322211068)
				local var_282_14 = arg_279_1:FormatText(var_282_13.content)

				arg_279_1.text_.text = var_282_14

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_15 = 16
				local var_282_16 = utf8.len(var_282_14)
				local var_282_17 = var_282_15 <= 0 and var_282_11 or var_282_11 * (var_282_16 / var_282_15)

				if var_282_17 > 0 and var_282_11 < var_282_17 then
					arg_279_1.talkMaxDuration = var_282_17

					if var_282_17 + var_282_10 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_17 + var_282_10
					end
				end

				arg_279_1.text_.text = var_282_14
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211068", "story_v_out_322211.awb") ~= 0 then
					local var_282_18 = manager.audio:GetVoiceLength("story_v_out_322211", "322211068", "story_v_out_322211.awb") / 1000

					if var_282_18 + var_282_10 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_18 + var_282_10
					end

					if var_282_13.prefab_name ~= "" and arg_279_1.actors_[var_282_13.prefab_name] ~= nil then
						local var_282_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_13.prefab_name].transform, "story_v_out_322211", "322211068", "story_v_out_322211.awb")

						arg_279_1:RecordAudio("322211068", var_282_19)
						arg_279_1:RecordAudio("322211068", var_282_19)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_322211", "322211068", "story_v_out_322211.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_322211", "322211068", "story_v_out_322211.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_20 = math.max(var_282_11, arg_279_1.talkMaxDuration)

			if var_282_10 <= arg_279_1.time_ and arg_279_1.time_ < var_282_10 + var_282_20 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_10) / var_282_20

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_10 + var_282_20 and arg_279_1.time_ < var_282_10 + var_282_20 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play322211069 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 322211069
		arg_283_1.duration_ = 14.27

		local var_283_0 = {
			zh = 10.5,
			ja = 14.266
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
				arg_283_0:Play322211070(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			local var_286_0 = 0
			local var_286_1 = 1.2

			if var_286_0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_0 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				local var_286_2 = arg_283_1:FormatText(StoryNameCfg[1178].name)

				arg_283_1.leftNameTxt_.text = var_286_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_3 = arg_283_1:GetWordFromCfg(322211069)
				local var_286_4 = arg_283_1:FormatText(var_286_3.content)

				arg_283_1.text_.text = var_286_4

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_5 = 48
				local var_286_6 = utf8.len(var_286_4)
				local var_286_7 = var_286_5 <= 0 and var_286_1 or var_286_1 * (var_286_6 / var_286_5)

				if var_286_7 > 0 and var_286_1 < var_286_7 then
					arg_283_1.talkMaxDuration = var_286_7

					if var_286_7 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_7 + var_286_0
					end
				end

				arg_283_1.text_.text = var_286_4
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211069", "story_v_out_322211.awb") ~= 0 then
					local var_286_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211069", "story_v_out_322211.awb") / 1000

					if var_286_8 + var_286_0 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_8 + var_286_0
					end

					if var_286_3.prefab_name ~= "" and arg_283_1.actors_[var_286_3.prefab_name] ~= nil then
						local var_286_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_3.prefab_name].transform, "story_v_out_322211", "322211069", "story_v_out_322211.awb")

						arg_283_1:RecordAudio("322211069", var_286_9)
						arg_283_1:RecordAudio("322211069", var_286_9)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_322211", "322211069", "story_v_out_322211.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_322211", "322211069", "story_v_out_322211.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_10 = math.max(var_286_1, arg_283_1.talkMaxDuration)

			if var_286_0 <= arg_283_1.time_ and arg_283_1.time_ < var_286_0 + var_286_10 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_0) / var_286_10

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_0 + var_286_10 and arg_283_1.time_ < var_286_0 + var_286_10 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {}

		arg_283_1:InitPlayNodeList()
	end,
	Play322211070 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 322211070
		arg_287_1.duration_ = 10.33

		local var_287_0 = {
			zh = 5.833,
			ja = 10.333
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
				arg_287_0:Play322211071(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0
			local var_290_1 = 0.7

			if var_290_0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				local var_290_2 = arg_287_1:FormatText(StoryNameCfg[1178].name)

				arg_287_1.leftNameTxt_.text = var_290_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_3 = arg_287_1:GetWordFromCfg(322211070)
				local var_290_4 = arg_287_1:FormatText(var_290_3.content)

				arg_287_1.text_.text = var_290_4

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_5 = 28
				local var_290_6 = utf8.len(var_290_4)
				local var_290_7 = var_290_5 <= 0 and var_290_1 or var_290_1 * (var_290_6 / var_290_5)

				if var_290_7 > 0 and var_290_1 < var_290_7 then
					arg_287_1.talkMaxDuration = var_290_7

					if var_290_7 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_7 + var_290_0
					end
				end

				arg_287_1.text_.text = var_290_4
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211070", "story_v_out_322211.awb") ~= 0 then
					local var_290_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211070", "story_v_out_322211.awb") / 1000

					if var_290_8 + var_290_0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_8 + var_290_0
					end

					if var_290_3.prefab_name ~= "" and arg_287_1.actors_[var_290_3.prefab_name] ~= nil then
						local var_290_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_3.prefab_name].transform, "story_v_out_322211", "322211070", "story_v_out_322211.awb")

						arg_287_1:RecordAudio("322211070", var_290_9)
						arg_287_1:RecordAudio("322211070", var_290_9)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_322211", "322211070", "story_v_out_322211.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_322211", "322211070", "story_v_out_322211.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_10 = math.max(var_290_1, arg_287_1.talkMaxDuration)

			if var_290_0 <= arg_287_1.time_ and arg_287_1.time_ < var_290_0 + var_290_10 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_0) / var_290_10

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_0 + var_290_10 and arg_287_1.time_ < var_290_0 + var_290_10 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play322211071 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 322211071
		arg_291_1.duration_ = 4.47

		local var_291_0 = {
			zh = 3.333,
			ja = 4.466
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
				arg_291_0:Play322211072(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			local var_294_0 = arg_291_1.actors_["1111ui_story"]
			local var_294_1 = 0

			if var_294_1 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1111ui_story == nil then
				arg_291_1.var_.characterEffect1111ui_story = var_294_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_2 and not isNil(var_294_0) then
				local var_294_3 = (arg_291_1.time_ - var_294_1) / var_294_2

				if arg_291_1.var_.characterEffect1111ui_story and not isNil(var_294_0) then
					arg_291_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= var_294_1 + var_294_2 and arg_291_1.time_ < var_294_1 + var_294_2 + arg_294_0 and not isNil(var_294_0) and arg_291_1.var_.characterEffect1111ui_story then
				arg_291_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_294_4 = arg_291_1.actors_["10131ui_story"]
			local var_294_5 = 0

			if var_294_5 < arg_291_1.time_ and arg_291_1.time_ <= var_294_5 + arg_294_0 and not isNil(var_294_4) and arg_291_1.var_.characterEffect10131ui_story == nil then
				arg_291_1.var_.characterEffect10131ui_story = var_294_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_6 = 0.200000002980232

			if var_294_5 <= arg_291_1.time_ and arg_291_1.time_ < var_294_5 + var_294_6 and not isNil(var_294_4) then
				local var_294_7 = (arg_291_1.time_ - var_294_5) / var_294_6

				if arg_291_1.var_.characterEffect10131ui_story and not isNil(var_294_4) then
					local var_294_8 = Mathf.Lerp(0, 0.5, var_294_7)

					arg_291_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_291_1.var_.characterEffect10131ui_story.fillRatio = var_294_8
				end
			end

			if arg_291_1.time_ >= var_294_5 + var_294_6 and arg_291_1.time_ < var_294_5 + var_294_6 + arg_294_0 and not isNil(var_294_4) and arg_291_1.var_.characterEffect10131ui_story then
				local var_294_9 = 0.5

				arg_291_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_291_1.var_.characterEffect10131ui_story.fillRatio = var_294_9
			end

			local var_294_10 = 0

			if var_294_10 < arg_291_1.time_ and arg_291_1.time_ <= var_294_10 + arg_294_0 then
				arg_291_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action2_2")
			end

			local var_294_11 = 0
			local var_294_12 = 0.35

			if var_294_11 < arg_291_1.time_ and arg_291_1.time_ <= var_294_11 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				local var_294_13 = arg_291_1:FormatText(StoryNameCfg[67].name)

				arg_291_1.leftNameTxt_.text = var_294_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_14 = arg_291_1:GetWordFromCfg(322211071)
				local var_294_15 = arg_291_1:FormatText(var_294_14.content)

				arg_291_1.text_.text = var_294_15

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_16 = 14
				local var_294_17 = utf8.len(var_294_15)
				local var_294_18 = var_294_16 <= 0 and var_294_12 or var_294_12 * (var_294_17 / var_294_16)

				if var_294_18 > 0 and var_294_12 < var_294_18 then
					arg_291_1.talkMaxDuration = var_294_18

					if var_294_18 + var_294_11 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_18 + var_294_11
					end
				end

				arg_291_1.text_.text = var_294_15
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211071", "story_v_out_322211.awb") ~= 0 then
					local var_294_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211071", "story_v_out_322211.awb") / 1000

					if var_294_19 + var_294_11 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_19 + var_294_11
					end

					if var_294_14.prefab_name ~= "" and arg_291_1.actors_[var_294_14.prefab_name] ~= nil then
						local var_294_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_14.prefab_name].transform, "story_v_out_322211", "322211071", "story_v_out_322211.awb")

						arg_291_1:RecordAudio("322211071", var_294_20)
						arg_291_1:RecordAudio("322211071", var_294_20)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_322211", "322211071", "story_v_out_322211.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_322211", "322211071", "story_v_out_322211.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_21 = math.max(var_294_12, arg_291_1.talkMaxDuration)

			if var_294_11 <= arg_291_1.time_ and arg_291_1.time_ < var_294_11 + var_294_21 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_11) / var_294_21

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_11 + var_294_21 and arg_291_1.time_ < var_294_11 + var_294_21 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play322211072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 322211072
		arg_295_1.duration_ = 7.3

		local var_295_0 = {
			zh = 6,
			ja = 7.3
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
				arg_295_0:Play322211073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = arg_295_1.actors_["10131ui_story"]
			local var_298_1 = 0

			if var_298_1 < arg_295_1.time_ and arg_295_1.time_ <= var_298_1 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect10131ui_story == nil then
				arg_295_1.var_.characterEffect10131ui_story = var_298_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if var_298_1 <= arg_295_1.time_ and arg_295_1.time_ < var_298_1 + var_298_2 and not isNil(var_298_0) then
				local var_298_3 = (arg_295_1.time_ - var_298_1) / var_298_2

				if arg_295_1.var_.characterEffect10131ui_story and not isNil(var_298_0) then
					arg_295_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= var_298_1 + var_298_2 and arg_295_1.time_ < var_298_1 + var_298_2 + arg_298_0 and not isNil(var_298_0) and arg_295_1.var_.characterEffect10131ui_story then
				arg_295_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_298_4 = arg_295_1.actors_["1111ui_story"]
			local var_298_5 = 0

			if var_298_5 < arg_295_1.time_ and arg_295_1.time_ <= var_298_5 + arg_298_0 and not isNil(var_298_4) and arg_295_1.var_.characterEffect1111ui_story == nil then
				arg_295_1.var_.characterEffect1111ui_story = var_298_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_6 = 0.200000002980232

			if var_298_5 <= arg_295_1.time_ and arg_295_1.time_ < var_298_5 + var_298_6 and not isNil(var_298_4) then
				local var_298_7 = (arg_295_1.time_ - var_298_5) / var_298_6

				if arg_295_1.var_.characterEffect1111ui_story and not isNil(var_298_4) then
					local var_298_8 = Mathf.Lerp(0, 0.5, var_298_7)

					arg_295_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_295_1.var_.characterEffect1111ui_story.fillRatio = var_298_8
				end
			end

			if arg_295_1.time_ >= var_298_5 + var_298_6 and arg_295_1.time_ < var_298_5 + var_298_6 + arg_298_0 and not isNil(var_298_4) and arg_295_1.var_.characterEffect1111ui_story then
				local var_298_9 = 0.5

				arg_295_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_295_1.var_.characterEffect1111ui_story.fillRatio = var_298_9
			end

			local var_298_10 = 0

			if var_298_10 < arg_295_1.time_ and arg_295_1.time_ <= var_298_10 + arg_298_0 then
				arg_295_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action8_2")
			end

			local var_298_11 = 0
			local var_298_12 = 0.5

			if var_298_11 < arg_295_1.time_ and arg_295_1.time_ <= var_298_11 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				local var_298_13 = arg_295_1:FormatText(StoryNameCfg[1178].name)

				arg_295_1.leftNameTxt_.text = var_298_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_14 = arg_295_1:GetWordFromCfg(322211072)
				local var_298_15 = arg_295_1:FormatText(var_298_14.content)

				arg_295_1.text_.text = var_298_15

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_16 = 20
				local var_298_17 = utf8.len(var_298_15)
				local var_298_18 = var_298_16 <= 0 and var_298_12 or var_298_12 * (var_298_17 / var_298_16)

				if var_298_18 > 0 and var_298_12 < var_298_18 then
					arg_295_1.talkMaxDuration = var_298_18

					if var_298_18 + var_298_11 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_18 + var_298_11
					end
				end

				arg_295_1.text_.text = var_298_15
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211072", "story_v_out_322211.awb") ~= 0 then
					local var_298_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211072", "story_v_out_322211.awb") / 1000

					if var_298_19 + var_298_11 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_19 + var_298_11
					end

					if var_298_14.prefab_name ~= "" and arg_295_1.actors_[var_298_14.prefab_name] ~= nil then
						local var_298_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_14.prefab_name].transform, "story_v_out_322211", "322211072", "story_v_out_322211.awb")

						arg_295_1:RecordAudio("322211072", var_298_20)
						arg_295_1:RecordAudio("322211072", var_298_20)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_322211", "322211072", "story_v_out_322211.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_322211", "322211072", "story_v_out_322211.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_21 = math.max(var_298_12, arg_295_1.talkMaxDuration)

			if var_298_11 <= arg_295_1.time_ and arg_295_1.time_ < var_298_11 + var_298_21 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_11) / var_298_21

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_11 + var_298_21 and arg_295_1.time_ < var_298_11 + var_298_21 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play322211073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 322211073
		arg_299_1.duration_ = 4

		local var_299_0 = {
			zh = 1.766,
			ja = 4
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play322211074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = arg_299_1.actors_["1111ui_story"]
			local var_302_1 = 0

			if var_302_1 < arg_299_1.time_ and arg_299_1.time_ <= var_302_1 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1111ui_story == nil then
				arg_299_1.var_.characterEffect1111ui_story = var_302_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if var_302_1 <= arg_299_1.time_ and arg_299_1.time_ < var_302_1 + var_302_2 and not isNil(var_302_0) then
				local var_302_3 = (arg_299_1.time_ - var_302_1) / var_302_2

				if arg_299_1.var_.characterEffect1111ui_story and not isNil(var_302_0) then
					arg_299_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_299_1.time_ >= var_302_1 + var_302_2 and arg_299_1.time_ < var_302_1 + var_302_2 + arg_302_0 and not isNil(var_302_0) and arg_299_1.var_.characterEffect1111ui_story then
				arg_299_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_302_4 = arg_299_1.actors_["10131ui_story"]
			local var_302_5 = 0

			if var_302_5 < arg_299_1.time_ and arg_299_1.time_ <= var_302_5 + arg_302_0 and not isNil(var_302_4) and arg_299_1.var_.characterEffect10131ui_story == nil then
				arg_299_1.var_.characterEffect10131ui_story = var_302_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_6 = 0.200000002980232

			if var_302_5 <= arg_299_1.time_ and arg_299_1.time_ < var_302_5 + var_302_6 and not isNil(var_302_4) then
				local var_302_7 = (arg_299_1.time_ - var_302_5) / var_302_6

				if arg_299_1.var_.characterEffect10131ui_story and not isNil(var_302_4) then
					local var_302_8 = Mathf.Lerp(0, 0.5, var_302_7)

					arg_299_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_299_1.var_.characterEffect10131ui_story.fillRatio = var_302_8
				end
			end

			if arg_299_1.time_ >= var_302_5 + var_302_6 and arg_299_1.time_ < var_302_5 + var_302_6 + arg_302_0 and not isNil(var_302_4) and arg_299_1.var_.characterEffect10131ui_story then
				local var_302_9 = 0.5

				arg_299_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_299_1.var_.characterEffect10131ui_story.fillRatio = var_302_9
			end

			local var_302_10 = 0
			local var_302_11 = 0.175

			if var_302_10 < arg_299_1.time_ and arg_299_1.time_ <= var_302_10 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_12 = arg_299_1:FormatText(StoryNameCfg[67].name)

				arg_299_1.leftNameTxt_.text = var_302_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_13 = arg_299_1:GetWordFromCfg(322211073)
				local var_302_14 = arg_299_1:FormatText(var_302_13.content)

				arg_299_1.text_.text = var_302_14

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_15 = 7
				local var_302_16 = utf8.len(var_302_14)
				local var_302_17 = var_302_15 <= 0 and var_302_11 or var_302_11 * (var_302_16 / var_302_15)

				if var_302_17 > 0 and var_302_11 < var_302_17 then
					arg_299_1.talkMaxDuration = var_302_17

					if var_302_17 + var_302_10 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_17 + var_302_10
					end
				end

				arg_299_1.text_.text = var_302_14
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211073", "story_v_out_322211.awb") ~= 0 then
					local var_302_18 = manager.audio:GetVoiceLength("story_v_out_322211", "322211073", "story_v_out_322211.awb") / 1000

					if var_302_18 + var_302_10 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_18 + var_302_10
					end

					if var_302_13.prefab_name ~= "" and arg_299_1.actors_[var_302_13.prefab_name] ~= nil then
						local var_302_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_13.prefab_name].transform, "story_v_out_322211", "322211073", "story_v_out_322211.awb")

						arg_299_1:RecordAudio("322211073", var_302_19)
						arg_299_1:RecordAudio("322211073", var_302_19)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_322211", "322211073", "story_v_out_322211.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_322211", "322211073", "story_v_out_322211.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_20 = math.max(var_302_11, arg_299_1.talkMaxDuration)

			if var_302_10 <= arg_299_1.time_ and arg_299_1.time_ < var_302_10 + var_302_20 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_10) / var_302_20

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_10 + var_302_20 and arg_299_1.time_ < var_302_10 + var_302_20 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play322211074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 322211074
		arg_303_1.duration_ = 14.13

		local var_303_0 = {
			zh = 10.5,
			ja = 14.133
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
				arg_303_0:Play322211075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = arg_303_1.actors_["10131ui_story"]
			local var_306_1 = 0

			if var_306_1 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect10131ui_story == nil then
				arg_303_1.var_.characterEffect10131ui_story = var_306_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_2 = 0.200000002980232

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_2 and not isNil(var_306_0) then
				local var_306_3 = (arg_303_1.time_ - var_306_1) / var_306_2

				if arg_303_1.var_.characterEffect10131ui_story and not isNil(var_306_0) then
					arg_303_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_303_1.time_ >= var_306_1 + var_306_2 and arg_303_1.time_ < var_306_1 + var_306_2 + arg_306_0 and not isNil(var_306_0) and arg_303_1.var_.characterEffect10131ui_story then
				arg_303_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_306_4 = arg_303_1.actors_["1111ui_story"]
			local var_306_5 = 0

			if var_306_5 < arg_303_1.time_ and arg_303_1.time_ <= var_306_5 + arg_306_0 and not isNil(var_306_4) and arg_303_1.var_.characterEffect1111ui_story == nil then
				arg_303_1.var_.characterEffect1111ui_story = var_306_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_306_6 = 0.200000002980232

			if var_306_5 <= arg_303_1.time_ and arg_303_1.time_ < var_306_5 + var_306_6 and not isNil(var_306_4) then
				local var_306_7 = (arg_303_1.time_ - var_306_5) / var_306_6

				if arg_303_1.var_.characterEffect1111ui_story and not isNil(var_306_4) then
					local var_306_8 = Mathf.Lerp(0, 0.5, var_306_7)

					arg_303_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_303_1.var_.characterEffect1111ui_story.fillRatio = var_306_8
				end
			end

			if arg_303_1.time_ >= var_306_5 + var_306_6 and arg_303_1.time_ < var_306_5 + var_306_6 + arg_306_0 and not isNil(var_306_4) and arg_303_1.var_.characterEffect1111ui_story then
				local var_306_9 = 0.5

				arg_303_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_303_1.var_.characterEffect1111ui_story.fillRatio = var_306_9
			end

			local var_306_10 = 0
			local var_306_11 = 1.2

			if var_306_10 < arg_303_1.time_ and arg_303_1.time_ <= var_306_10 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_12 = arg_303_1:FormatText(StoryNameCfg[1178].name)

				arg_303_1.leftNameTxt_.text = var_306_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_13 = arg_303_1:GetWordFromCfg(322211074)
				local var_306_14 = arg_303_1:FormatText(var_306_13.content)

				arg_303_1.text_.text = var_306_14

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_15 = 48
				local var_306_16 = utf8.len(var_306_14)
				local var_306_17 = var_306_15 <= 0 and var_306_11 or var_306_11 * (var_306_16 / var_306_15)

				if var_306_17 > 0 and var_306_11 < var_306_17 then
					arg_303_1.talkMaxDuration = var_306_17

					if var_306_17 + var_306_10 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_17 + var_306_10
					end
				end

				arg_303_1.text_.text = var_306_14
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211074", "story_v_out_322211.awb") ~= 0 then
					local var_306_18 = manager.audio:GetVoiceLength("story_v_out_322211", "322211074", "story_v_out_322211.awb") / 1000

					if var_306_18 + var_306_10 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_18 + var_306_10
					end

					if var_306_13.prefab_name ~= "" and arg_303_1.actors_[var_306_13.prefab_name] ~= nil then
						local var_306_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_13.prefab_name].transform, "story_v_out_322211", "322211074", "story_v_out_322211.awb")

						arg_303_1:RecordAudio("322211074", var_306_19)
						arg_303_1:RecordAudio("322211074", var_306_19)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_322211", "322211074", "story_v_out_322211.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_322211", "322211074", "story_v_out_322211.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_20 = math.max(var_306_11, arg_303_1.talkMaxDuration)

			if var_306_10 <= arg_303_1.time_ and arg_303_1.time_ < var_306_10 + var_306_20 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_10) / var_306_20

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_10 + var_306_20 and arg_303_1.time_ < var_306_10 + var_306_20 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play322211075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 322211075
		arg_307_1.duration_ = 3.23

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play322211076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = arg_307_1.actors_["1111ui_story"]
			local var_310_1 = 0

			if var_310_1 < arg_307_1.time_ and arg_307_1.time_ <= var_310_1 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1111ui_story == nil then
				arg_307_1.var_.characterEffect1111ui_story = var_310_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if var_310_1 <= arg_307_1.time_ and arg_307_1.time_ < var_310_1 + var_310_2 and not isNil(var_310_0) then
				local var_310_3 = (arg_307_1.time_ - var_310_1) / var_310_2

				if arg_307_1.var_.characterEffect1111ui_story and not isNil(var_310_0) then
					arg_307_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= var_310_1 + var_310_2 and arg_307_1.time_ < var_310_1 + var_310_2 + arg_310_0 and not isNil(var_310_0) and arg_307_1.var_.characterEffect1111ui_story then
				arg_307_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_310_4 = arg_307_1.actors_["10131ui_story"]
			local var_310_5 = 0

			if var_310_5 < arg_307_1.time_ and arg_307_1.time_ <= var_310_5 + arg_310_0 and not isNil(var_310_4) and arg_307_1.var_.characterEffect10131ui_story == nil then
				arg_307_1.var_.characterEffect10131ui_story = var_310_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_6 = 0.200000002980232

			if var_310_5 <= arg_307_1.time_ and arg_307_1.time_ < var_310_5 + var_310_6 and not isNil(var_310_4) then
				local var_310_7 = (arg_307_1.time_ - var_310_5) / var_310_6

				if arg_307_1.var_.characterEffect10131ui_story and not isNil(var_310_4) then
					local var_310_8 = Mathf.Lerp(0, 0.5, var_310_7)

					arg_307_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_307_1.var_.characterEffect10131ui_story.fillRatio = var_310_8
				end
			end

			if arg_307_1.time_ >= var_310_5 + var_310_6 and arg_307_1.time_ < var_310_5 + var_310_6 + arg_310_0 and not isNil(var_310_4) and arg_307_1.var_.characterEffect10131ui_story then
				local var_310_9 = 0.5

				arg_307_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_307_1.var_.characterEffect10131ui_story.fillRatio = var_310_9
			end

			local var_310_10 = 0

			if var_310_10 < arg_307_1.time_ and arg_307_1.time_ <= var_310_10 + arg_310_0 then
				arg_307_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action8_1")
			end

			local var_310_11 = 0
			local var_310_12 = 0.325

			if var_310_11 < arg_307_1.time_ and arg_307_1.time_ <= var_310_11 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				local var_310_13 = arg_307_1:FormatText(StoryNameCfg[67].name)

				arg_307_1.leftNameTxt_.text = var_310_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_14 = arg_307_1:GetWordFromCfg(322211075)
				local var_310_15 = arg_307_1:FormatText(var_310_14.content)

				arg_307_1.text_.text = var_310_15

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_16 = 13
				local var_310_17 = utf8.len(var_310_15)
				local var_310_18 = var_310_16 <= 0 and var_310_12 or var_310_12 * (var_310_17 / var_310_16)

				if var_310_18 > 0 and var_310_12 < var_310_18 then
					arg_307_1.talkMaxDuration = var_310_18

					if var_310_18 + var_310_11 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_18 + var_310_11
					end
				end

				arg_307_1.text_.text = var_310_15
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211075", "story_v_out_322211.awb") ~= 0 then
					local var_310_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211075", "story_v_out_322211.awb") / 1000

					if var_310_19 + var_310_11 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_19 + var_310_11
					end

					if var_310_14.prefab_name ~= "" and arg_307_1.actors_[var_310_14.prefab_name] ~= nil then
						local var_310_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_14.prefab_name].transform, "story_v_out_322211", "322211075", "story_v_out_322211.awb")

						arg_307_1:RecordAudio("322211075", var_310_20)
						arg_307_1:RecordAudio("322211075", var_310_20)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_322211", "322211075", "story_v_out_322211.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_322211", "322211075", "story_v_out_322211.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_21 = math.max(var_310_12, arg_307_1.talkMaxDuration)

			if var_310_11 <= arg_307_1.time_ and arg_307_1.time_ < var_310_11 + var_310_21 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_11) / var_310_21

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_11 + var_310_21 and arg_307_1.time_ < var_310_11 + var_310_21 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play322211076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 322211076
		arg_311_1.duration_ = 15.93

		local var_311_0 = {
			zh = 11.7,
			ja = 15.933
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play322211077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = arg_311_1.actors_["10131ui_story"]
			local var_314_1 = 0

			if var_314_1 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect10131ui_story == nil then
				arg_311_1.var_.characterEffect10131ui_story = var_314_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_2 and not isNil(var_314_0) then
				local var_314_3 = (arg_311_1.time_ - var_314_1) / var_314_2

				if arg_311_1.var_.characterEffect10131ui_story and not isNil(var_314_0) then
					arg_311_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= var_314_1 + var_314_2 and arg_311_1.time_ < var_314_1 + var_314_2 + arg_314_0 and not isNil(var_314_0) and arg_311_1.var_.characterEffect10131ui_story then
				arg_311_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_314_4 = arg_311_1.actors_["1111ui_story"]
			local var_314_5 = 0

			if var_314_5 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 and not isNil(var_314_4) and arg_311_1.var_.characterEffect1111ui_story == nil then
				arg_311_1.var_.characterEffect1111ui_story = var_314_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_6 = 0.200000002980232

			if var_314_5 <= arg_311_1.time_ and arg_311_1.time_ < var_314_5 + var_314_6 and not isNil(var_314_4) then
				local var_314_7 = (arg_311_1.time_ - var_314_5) / var_314_6

				if arg_311_1.var_.characterEffect1111ui_story and not isNil(var_314_4) then
					local var_314_8 = Mathf.Lerp(0, 0.5, var_314_7)

					arg_311_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_311_1.var_.characterEffect1111ui_story.fillRatio = var_314_8
				end
			end

			if arg_311_1.time_ >= var_314_5 + var_314_6 and arg_311_1.time_ < var_314_5 + var_314_6 + arg_314_0 and not isNil(var_314_4) and arg_311_1.var_.characterEffect1111ui_story then
				local var_314_9 = 0.5

				arg_311_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_311_1.var_.characterEffect1111ui_story.fillRatio = var_314_9
			end

			local var_314_10 = 0
			local var_314_11 = 1.15

			if var_314_10 < arg_311_1.time_ and arg_311_1.time_ <= var_314_10 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				local var_314_12 = arg_311_1:FormatText(StoryNameCfg[1178].name)

				arg_311_1.leftNameTxt_.text = var_314_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_13 = arg_311_1:GetWordFromCfg(322211076)
				local var_314_14 = arg_311_1:FormatText(var_314_13.content)

				arg_311_1.text_.text = var_314_14

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_15 = 46
				local var_314_16 = utf8.len(var_314_14)
				local var_314_17 = var_314_15 <= 0 and var_314_11 or var_314_11 * (var_314_16 / var_314_15)

				if var_314_17 > 0 and var_314_11 < var_314_17 then
					arg_311_1.talkMaxDuration = var_314_17

					if var_314_17 + var_314_10 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_17 + var_314_10
					end
				end

				arg_311_1.text_.text = var_314_14
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211076", "story_v_out_322211.awb") ~= 0 then
					local var_314_18 = manager.audio:GetVoiceLength("story_v_out_322211", "322211076", "story_v_out_322211.awb") / 1000

					if var_314_18 + var_314_10 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_18 + var_314_10
					end

					if var_314_13.prefab_name ~= "" and arg_311_1.actors_[var_314_13.prefab_name] ~= nil then
						local var_314_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_13.prefab_name].transform, "story_v_out_322211", "322211076", "story_v_out_322211.awb")

						arg_311_1:RecordAudio("322211076", var_314_19)
						arg_311_1:RecordAudio("322211076", var_314_19)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_322211", "322211076", "story_v_out_322211.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_322211", "322211076", "story_v_out_322211.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_20 = math.max(var_314_11, arg_311_1.talkMaxDuration)

			if var_314_10 <= arg_311_1.time_ and arg_311_1.time_ < var_314_10 + var_314_20 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_10) / var_314_20

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_10 + var_314_20 and arg_311_1.time_ < var_314_10 + var_314_20 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play322211077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 322211077
		arg_315_1.duration_ = 18.77

		local var_315_0 = {
			zh = 13.8,
			ja = 18.766
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play322211078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 1.425

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_2 = arg_315_1:FormatText(StoryNameCfg[1178].name)

				arg_315_1.leftNameTxt_.text = var_318_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_3 = arg_315_1:GetWordFromCfg(322211077)
				local var_318_4 = arg_315_1:FormatText(var_318_3.content)

				arg_315_1.text_.text = var_318_4

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 58
				local var_318_6 = utf8.len(var_318_4)
				local var_318_7 = var_318_5 <= 0 and var_318_1 or var_318_1 * (var_318_6 / var_318_5)

				if var_318_7 > 0 and var_318_1 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_0
					end
				end

				arg_315_1.text_.text = var_318_4
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211077", "story_v_out_322211.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211077", "story_v_out_322211.awb") / 1000

					if var_318_8 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_0
					end

					if var_318_3.prefab_name ~= "" and arg_315_1.actors_[var_318_3.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_3.prefab_name].transform, "story_v_out_322211", "322211077", "story_v_out_322211.awb")

						arg_315_1:RecordAudio("322211077", var_318_9)
						arg_315_1:RecordAudio("322211077", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_322211", "322211077", "story_v_out_322211.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_322211", "322211077", "story_v_out_322211.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_1, arg_315_1.talkMaxDuration)

			if var_318_0 <= arg_315_1.time_ and arg_315_1.time_ < var_318_0 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_0) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_0 + var_318_10 and arg_315_1.time_ < var_318_0 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play322211078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 322211078
		arg_319_1.duration_ = 13.67

		local var_319_0 = {
			zh = 9.133,
			ja = 13.666
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play322211079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0
			local var_322_1 = 1.05

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				local var_322_2 = arg_319_1:FormatText(StoryNameCfg[1178].name)

				arg_319_1.leftNameTxt_.text = var_322_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_3 = arg_319_1:GetWordFromCfg(322211078)
				local var_322_4 = arg_319_1:FormatText(var_322_3.content)

				arg_319_1.text_.text = var_322_4

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_5 = 42
				local var_322_6 = utf8.len(var_322_4)
				local var_322_7 = var_322_5 <= 0 and var_322_1 or var_322_1 * (var_322_6 / var_322_5)

				if var_322_7 > 0 and var_322_1 < var_322_7 then
					arg_319_1.talkMaxDuration = var_322_7

					if var_322_7 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_7 + var_322_0
					end
				end

				arg_319_1.text_.text = var_322_4
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211078", "story_v_out_322211.awb") ~= 0 then
					local var_322_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211078", "story_v_out_322211.awb") / 1000

					if var_322_8 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_8 + var_322_0
					end

					if var_322_3.prefab_name ~= "" and arg_319_1.actors_[var_322_3.prefab_name] ~= nil then
						local var_322_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_3.prefab_name].transform, "story_v_out_322211", "322211078", "story_v_out_322211.awb")

						arg_319_1:RecordAudio("322211078", var_322_9)
						arg_319_1:RecordAudio("322211078", var_322_9)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_322211", "322211078", "story_v_out_322211.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_322211", "322211078", "story_v_out_322211.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_10 = math.max(var_322_1, arg_319_1.talkMaxDuration)

			if var_322_0 <= arg_319_1.time_ and arg_319_1.time_ < var_322_0 + var_322_10 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_0) / var_322_10

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_0 + var_322_10 and arg_319_1.time_ < var_322_0 + var_322_10 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play322211079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 322211079
		arg_323_1.duration_ = 8.17

		local var_323_0 = {
			zh = 5.433,
			ja = 8.166
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play322211080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = arg_323_1.actors_["1111ui_story"]
			local var_326_1 = 0

			if var_326_1 < arg_323_1.time_ and arg_323_1.time_ <= var_326_1 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1111ui_story == nil then
				arg_323_1.var_.characterEffect1111ui_story = var_326_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if var_326_1 <= arg_323_1.time_ and arg_323_1.time_ < var_326_1 + var_326_2 and not isNil(var_326_0) then
				local var_326_3 = (arg_323_1.time_ - var_326_1) / var_326_2

				if arg_323_1.var_.characterEffect1111ui_story and not isNil(var_326_0) then
					arg_323_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_1 + var_326_2 and arg_323_1.time_ < var_326_1 + var_326_2 + arg_326_0 and not isNil(var_326_0) and arg_323_1.var_.characterEffect1111ui_story then
				arg_323_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_326_4 = arg_323_1.actors_["10131ui_story"]
			local var_326_5 = 0

			if var_326_5 < arg_323_1.time_ and arg_323_1.time_ <= var_326_5 + arg_326_0 and not isNil(var_326_4) and arg_323_1.var_.characterEffect10131ui_story == nil then
				arg_323_1.var_.characterEffect10131ui_story = var_326_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_6 = 0.200000002980232

			if var_326_5 <= arg_323_1.time_ and arg_323_1.time_ < var_326_5 + var_326_6 and not isNil(var_326_4) then
				local var_326_7 = (arg_323_1.time_ - var_326_5) / var_326_6

				if arg_323_1.var_.characterEffect10131ui_story and not isNil(var_326_4) then
					local var_326_8 = Mathf.Lerp(0, 0.5, var_326_7)

					arg_323_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_323_1.var_.characterEffect10131ui_story.fillRatio = var_326_8
				end
			end

			if arg_323_1.time_ >= var_326_5 + var_326_6 and arg_323_1.time_ < var_326_5 + var_326_6 + arg_326_0 and not isNil(var_326_4) and arg_323_1.var_.characterEffect10131ui_story then
				local var_326_9 = 0.5

				arg_323_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_323_1.var_.characterEffect10131ui_story.fillRatio = var_326_9
			end

			local var_326_10 = 0

			if var_326_10 < arg_323_1.time_ and arg_323_1.time_ <= var_326_10 + arg_326_0 then
				arg_323_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111actionlink/1111action486")
			end

			local var_326_11 = 0

			if var_326_11 < arg_323_1.time_ and arg_323_1.time_ <= var_326_11 + arg_326_0 then
				arg_323_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_326_12 = 0
			local var_326_13 = 0.725

			if var_326_12 < arg_323_1.time_ and arg_323_1.time_ <= var_326_12 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_14 = arg_323_1:FormatText(StoryNameCfg[67].name)

				arg_323_1.leftNameTxt_.text = var_326_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_15 = arg_323_1:GetWordFromCfg(322211079)
				local var_326_16 = arg_323_1:FormatText(var_326_15.content)

				arg_323_1.text_.text = var_326_16

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_17 = 29
				local var_326_18 = utf8.len(var_326_16)
				local var_326_19 = var_326_17 <= 0 and var_326_13 or var_326_13 * (var_326_18 / var_326_17)

				if var_326_19 > 0 and var_326_13 < var_326_19 then
					arg_323_1.talkMaxDuration = var_326_19

					if var_326_19 + var_326_12 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_19 + var_326_12
					end
				end

				arg_323_1.text_.text = var_326_16
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211079", "story_v_out_322211.awb") ~= 0 then
					local var_326_20 = manager.audio:GetVoiceLength("story_v_out_322211", "322211079", "story_v_out_322211.awb") / 1000

					if var_326_20 + var_326_12 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_20 + var_326_12
					end

					if var_326_15.prefab_name ~= "" and arg_323_1.actors_[var_326_15.prefab_name] ~= nil then
						local var_326_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_15.prefab_name].transform, "story_v_out_322211", "322211079", "story_v_out_322211.awb")

						arg_323_1:RecordAudio("322211079", var_326_21)
						arg_323_1:RecordAudio("322211079", var_326_21)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_322211", "322211079", "story_v_out_322211.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_322211", "322211079", "story_v_out_322211.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_22 = math.max(var_326_13, arg_323_1.talkMaxDuration)

			if var_326_12 <= arg_323_1.time_ and arg_323_1.time_ < var_326_12 + var_326_22 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_12) / var_326_22

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_12 + var_326_22 and arg_323_1.time_ < var_326_12 + var_326_22 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play322211080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 322211080
		arg_327_1.duration_ = 12.27

		local var_327_0 = {
			zh = 9.366,
			ja = 12.266
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play322211081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["10131ui_story"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect10131ui_story == nil then
				arg_327_1.var_.characterEffect10131ui_story = var_330_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 and not isNil(var_330_0) then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.characterEffect10131ui_story and not isNil(var_330_0) then
					arg_327_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and not isNil(var_330_0) and arg_327_1.var_.characterEffect10131ui_story then
				arg_327_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_330_4 = arg_327_1.actors_["1111ui_story"]
			local var_330_5 = 0

			if var_330_5 < arg_327_1.time_ and arg_327_1.time_ <= var_330_5 + arg_330_0 and not isNil(var_330_4) and arg_327_1.var_.characterEffect1111ui_story == nil then
				arg_327_1.var_.characterEffect1111ui_story = var_330_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_6 = 0.200000002980232

			if var_330_5 <= arg_327_1.time_ and arg_327_1.time_ < var_330_5 + var_330_6 and not isNil(var_330_4) then
				local var_330_7 = (arg_327_1.time_ - var_330_5) / var_330_6

				if arg_327_1.var_.characterEffect1111ui_story and not isNil(var_330_4) then
					local var_330_8 = Mathf.Lerp(0, 0.5, var_330_7)

					arg_327_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1111ui_story.fillRatio = var_330_8
				end
			end

			if arg_327_1.time_ >= var_330_5 + var_330_6 and arg_327_1.time_ < var_330_5 + var_330_6 + arg_330_0 and not isNil(var_330_4) and arg_327_1.var_.characterEffect1111ui_story then
				local var_330_9 = 0.5

				arg_327_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1111ui_story.fillRatio = var_330_9
			end

			local var_330_10 = 0

			if var_330_10 < arg_327_1.time_ and arg_327_1.time_ <= var_330_10 + arg_330_0 then
				arg_327_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_1")
			end

			local var_330_11 = 0
			local var_330_12 = 0.9

			if var_330_11 < arg_327_1.time_ and arg_327_1.time_ <= var_330_11 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_13 = arg_327_1:FormatText(StoryNameCfg[1178].name)

				arg_327_1.leftNameTxt_.text = var_330_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_14 = arg_327_1:GetWordFromCfg(322211080)
				local var_330_15 = arg_327_1:FormatText(var_330_14.content)

				arg_327_1.text_.text = var_330_15

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_16 = 36
				local var_330_17 = utf8.len(var_330_15)
				local var_330_18 = var_330_16 <= 0 and var_330_12 or var_330_12 * (var_330_17 / var_330_16)

				if var_330_18 > 0 and var_330_12 < var_330_18 then
					arg_327_1.talkMaxDuration = var_330_18

					if var_330_18 + var_330_11 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_18 + var_330_11
					end
				end

				arg_327_1.text_.text = var_330_15
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211080", "story_v_out_322211.awb") ~= 0 then
					local var_330_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211080", "story_v_out_322211.awb") / 1000

					if var_330_19 + var_330_11 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_19 + var_330_11
					end

					if var_330_14.prefab_name ~= "" and arg_327_1.actors_[var_330_14.prefab_name] ~= nil then
						local var_330_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_14.prefab_name].transform, "story_v_out_322211", "322211080", "story_v_out_322211.awb")

						arg_327_1:RecordAudio("322211080", var_330_20)
						arg_327_1:RecordAudio("322211080", var_330_20)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_322211", "322211080", "story_v_out_322211.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_322211", "322211080", "story_v_out_322211.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_21 = math.max(var_330_12, arg_327_1.talkMaxDuration)

			if var_330_11 <= arg_327_1.time_ and arg_327_1.time_ < var_330_11 + var_330_21 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_11) / var_330_21

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_11 + var_330_21 and arg_327_1.time_ < var_330_11 + var_330_21 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play322211081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 322211081
		arg_331_1.duration_ = 12.5

		local var_331_0 = {
			zh = 8.133,
			ja = 12.5
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play322211082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1111ui_story"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1111ui_story == nil then
				arg_331_1.var_.characterEffect1111ui_story = var_334_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 and not isNil(var_334_0) then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.characterEffect1111ui_story and not isNil(var_334_0) then
					arg_331_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and not isNil(var_334_0) and arg_331_1.var_.characterEffect1111ui_story then
				arg_331_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_334_4 = arg_331_1.actors_["10131ui_story"]
			local var_334_5 = 0

			if var_334_5 < arg_331_1.time_ and arg_331_1.time_ <= var_334_5 + arg_334_0 and not isNil(var_334_4) and arg_331_1.var_.characterEffect10131ui_story == nil then
				arg_331_1.var_.characterEffect10131ui_story = var_334_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_6 = 0.200000002980232

			if var_334_5 <= arg_331_1.time_ and arg_331_1.time_ < var_334_5 + var_334_6 and not isNil(var_334_4) then
				local var_334_7 = (arg_331_1.time_ - var_334_5) / var_334_6

				if arg_331_1.var_.characterEffect10131ui_story and not isNil(var_334_4) then
					local var_334_8 = Mathf.Lerp(0, 0.5, var_334_7)

					arg_331_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_331_1.var_.characterEffect10131ui_story.fillRatio = var_334_8
				end
			end

			if arg_331_1.time_ >= var_334_5 + var_334_6 and arg_331_1.time_ < var_334_5 + var_334_6 + arg_334_0 and not isNil(var_334_4) and arg_331_1.var_.characterEffect10131ui_story then
				local var_334_9 = 0.5

				arg_331_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_331_1.var_.characterEffect10131ui_story.fillRatio = var_334_9
			end

			local var_334_10 = 0

			if var_334_10 < arg_331_1.time_ and arg_331_1.time_ <= var_334_10 + arg_334_0 then
				arg_331_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action6_2")
			end

			local var_334_11 = 0

			if var_334_11 < arg_331_1.time_ and arg_331_1.time_ <= var_334_11 + arg_334_0 then
				arg_331_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_334_12 = 0
			local var_334_13 = 0.875

			if var_334_12 < arg_331_1.time_ and arg_331_1.time_ <= var_334_12 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_14 = arg_331_1:FormatText(StoryNameCfg[67].name)

				arg_331_1.leftNameTxt_.text = var_334_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_15 = arg_331_1:GetWordFromCfg(322211081)
				local var_334_16 = arg_331_1:FormatText(var_334_15.content)

				arg_331_1.text_.text = var_334_16

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_17 = 35
				local var_334_18 = utf8.len(var_334_16)
				local var_334_19 = var_334_17 <= 0 and var_334_13 or var_334_13 * (var_334_18 / var_334_17)

				if var_334_19 > 0 and var_334_13 < var_334_19 then
					arg_331_1.talkMaxDuration = var_334_19

					if var_334_19 + var_334_12 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_19 + var_334_12
					end
				end

				arg_331_1.text_.text = var_334_16
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211081", "story_v_out_322211.awb") ~= 0 then
					local var_334_20 = manager.audio:GetVoiceLength("story_v_out_322211", "322211081", "story_v_out_322211.awb") / 1000

					if var_334_20 + var_334_12 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_20 + var_334_12
					end

					if var_334_15.prefab_name ~= "" and arg_331_1.actors_[var_334_15.prefab_name] ~= nil then
						local var_334_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_15.prefab_name].transform, "story_v_out_322211", "322211081", "story_v_out_322211.awb")

						arg_331_1:RecordAudio("322211081", var_334_21)
						arg_331_1:RecordAudio("322211081", var_334_21)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_322211", "322211081", "story_v_out_322211.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_322211", "322211081", "story_v_out_322211.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_22 = math.max(var_334_13, arg_331_1.talkMaxDuration)

			if var_334_12 <= arg_331_1.time_ and arg_331_1.time_ < var_334_12 + var_334_22 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_12) / var_334_22

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_12 + var_334_22 and arg_331_1.time_ < var_334_12 + var_334_22 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play322211082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 322211082
		arg_335_1.duration_ = 9.3

		local var_335_0 = {
			zh = 8.2,
			ja = 9.3
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play322211083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0
			local var_338_1 = 0.8

			if var_338_0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				local var_338_2 = arg_335_1:FormatText(StoryNameCfg[67].name)

				arg_335_1.leftNameTxt_.text = var_338_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_3 = arg_335_1:GetWordFromCfg(322211082)
				local var_338_4 = arg_335_1:FormatText(var_338_3.content)

				arg_335_1.text_.text = var_338_4

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_5 = 32
				local var_338_6 = utf8.len(var_338_4)
				local var_338_7 = var_338_5 <= 0 and var_338_1 or var_338_1 * (var_338_6 / var_338_5)

				if var_338_7 > 0 and var_338_1 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_0
					end
				end

				arg_335_1.text_.text = var_338_4
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211082", "story_v_out_322211.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211082", "story_v_out_322211.awb") / 1000

					if var_338_8 + var_338_0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_0
					end

					if var_338_3.prefab_name ~= "" and arg_335_1.actors_[var_338_3.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_3.prefab_name].transform, "story_v_out_322211", "322211082", "story_v_out_322211.awb")

						arg_335_1:RecordAudio("322211082", var_338_9)
						arg_335_1:RecordAudio("322211082", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_322211", "322211082", "story_v_out_322211.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_322211", "322211082", "story_v_out_322211.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_10 = math.max(var_338_1, arg_335_1.talkMaxDuration)

			if var_338_0 <= arg_335_1.time_ and arg_335_1.time_ < var_338_0 + var_338_10 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_0) / var_338_10

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_0 + var_338_10 and arg_335_1.time_ < var_338_0 + var_338_10 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play322211083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 322211083
		arg_339_1.duration_ = 7.17

		local var_339_0 = {
			zh = 5.533,
			ja = 7.166
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play322211084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["10131ui_story"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect10131ui_story == nil then
				arg_339_1.var_.characterEffect10131ui_story = var_342_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 and not isNil(var_342_0) then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.characterEffect10131ui_story and not isNil(var_342_0) then
					arg_339_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and not isNil(var_342_0) and arg_339_1.var_.characterEffect10131ui_story then
				arg_339_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_342_4 = arg_339_1.actors_["1111ui_story"]
			local var_342_5 = 0

			if var_342_5 < arg_339_1.time_ and arg_339_1.time_ <= var_342_5 + arg_342_0 and not isNil(var_342_4) and arg_339_1.var_.characterEffect1111ui_story == nil then
				arg_339_1.var_.characterEffect1111ui_story = var_342_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_6 = 0.200000002980232

			if var_342_5 <= arg_339_1.time_ and arg_339_1.time_ < var_342_5 + var_342_6 and not isNil(var_342_4) then
				local var_342_7 = (arg_339_1.time_ - var_342_5) / var_342_6

				if arg_339_1.var_.characterEffect1111ui_story and not isNil(var_342_4) then
					local var_342_8 = Mathf.Lerp(0, 0.5, var_342_7)

					arg_339_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_339_1.var_.characterEffect1111ui_story.fillRatio = var_342_8
				end
			end

			if arg_339_1.time_ >= var_342_5 + var_342_6 and arg_339_1.time_ < var_342_5 + var_342_6 + arg_342_0 and not isNil(var_342_4) and arg_339_1.var_.characterEffect1111ui_story then
				local var_342_9 = 0.5

				arg_339_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_339_1.var_.characterEffect1111ui_story.fillRatio = var_342_9
			end

			local var_342_10 = 0

			if var_342_10 < arg_339_1.time_ and arg_339_1.time_ <= var_342_10 + arg_342_0 then
				arg_339_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action2_2")
			end

			local var_342_11 = 0
			local var_342_12 = 0.475

			if var_342_11 < arg_339_1.time_ and arg_339_1.time_ <= var_342_11 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_13 = arg_339_1:FormatText(StoryNameCfg[1178].name)

				arg_339_1.leftNameTxt_.text = var_342_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_14 = arg_339_1:GetWordFromCfg(322211083)
				local var_342_15 = arg_339_1:FormatText(var_342_14.content)

				arg_339_1.text_.text = var_342_15

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_16 = 19
				local var_342_17 = utf8.len(var_342_15)
				local var_342_18 = var_342_16 <= 0 and var_342_12 or var_342_12 * (var_342_17 / var_342_16)

				if var_342_18 > 0 and var_342_12 < var_342_18 then
					arg_339_1.talkMaxDuration = var_342_18

					if var_342_18 + var_342_11 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_18 + var_342_11
					end
				end

				arg_339_1.text_.text = var_342_15
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211083", "story_v_out_322211.awb") ~= 0 then
					local var_342_19 = manager.audio:GetVoiceLength("story_v_out_322211", "322211083", "story_v_out_322211.awb") / 1000

					if var_342_19 + var_342_11 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_19 + var_342_11
					end

					if var_342_14.prefab_name ~= "" and arg_339_1.actors_[var_342_14.prefab_name] ~= nil then
						local var_342_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_14.prefab_name].transform, "story_v_out_322211", "322211083", "story_v_out_322211.awb")

						arg_339_1:RecordAudio("322211083", var_342_20)
						arg_339_1:RecordAudio("322211083", var_342_20)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_322211", "322211083", "story_v_out_322211.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_322211", "322211083", "story_v_out_322211.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_21 = math.max(var_342_12, arg_339_1.talkMaxDuration)

			if var_342_11 <= arg_339_1.time_ and arg_339_1.time_ < var_342_11 + var_342_21 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_11) / var_342_21

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_11 + var_342_21 and arg_339_1.time_ < var_342_11 + var_342_21 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play322211084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 322211084
		arg_343_1.duration_ = 17.53

		local var_343_0 = {
			zh = 11.966,
			ja = 17.533
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play322211085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 1.25

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_2 = arg_343_1:FormatText(StoryNameCfg[1178].name)

				arg_343_1.leftNameTxt_.text = var_346_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_3 = arg_343_1:GetWordFromCfg(322211084)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 50
				local var_346_6 = utf8.len(var_346_4)
				local var_346_7 = var_346_5 <= 0 and var_346_1 or var_346_1 * (var_346_6 / var_346_5)

				if var_346_7 > 0 and var_346_1 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211084", "story_v_out_322211.awb") ~= 0 then
					local var_346_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211084", "story_v_out_322211.awb") / 1000

					if var_346_8 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_0
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_out_322211", "322211084", "story_v_out_322211.awb")

						arg_343_1:RecordAudio("322211084", var_346_9)
						arg_343_1:RecordAudio("322211084", var_346_9)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_322211", "322211084", "story_v_out_322211.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_322211", "322211084", "story_v_out_322211.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_10 and arg_343_1.time_ < var_346_0 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play322211085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 322211085
		arg_347_1.duration_ = 9.97

		local var_347_0 = {
			zh = 8.2,
			ja = 9.966
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play322211086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0
			local var_350_1 = 0.8

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_2 = arg_347_1:FormatText(StoryNameCfg[1178].name)

				arg_347_1.leftNameTxt_.text = var_350_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_3 = arg_347_1:GetWordFromCfg(322211085)
				local var_350_4 = arg_347_1:FormatText(var_350_3.content)

				arg_347_1.text_.text = var_350_4

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_5 = 32
				local var_350_6 = utf8.len(var_350_4)
				local var_350_7 = var_350_5 <= 0 and var_350_1 or var_350_1 * (var_350_6 / var_350_5)

				if var_350_7 > 0 and var_350_1 < var_350_7 then
					arg_347_1.talkMaxDuration = var_350_7

					if var_350_7 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_7 + var_350_0
					end
				end

				arg_347_1.text_.text = var_350_4
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211085", "story_v_out_322211.awb") ~= 0 then
					local var_350_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211085", "story_v_out_322211.awb") / 1000

					if var_350_8 + var_350_0 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_8 + var_350_0
					end

					if var_350_3.prefab_name ~= "" and arg_347_1.actors_[var_350_3.prefab_name] ~= nil then
						local var_350_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_3.prefab_name].transform, "story_v_out_322211", "322211085", "story_v_out_322211.awb")

						arg_347_1:RecordAudio("322211085", var_350_9)
						arg_347_1:RecordAudio("322211085", var_350_9)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_322211", "322211085", "story_v_out_322211.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_322211", "322211085", "story_v_out_322211.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_10 = math.max(var_350_1, arg_347_1.talkMaxDuration)

			if var_350_0 <= arg_347_1.time_ and arg_347_1.time_ < var_350_0 + var_350_10 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_0) / var_350_10

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_0 + var_350_10 and arg_347_1.time_ < var_350_0 + var_350_10 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play322211086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 322211086
		arg_351_1.duration_ = 2.33

		local var_351_0 = {
			zh = 1.999999999999,
			ja = 2.333
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play322211087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1111ui_story"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1111ui_story == nil then
				arg_351_1.var_.characterEffect1111ui_story = var_354_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.characterEffect1111ui_story and not isNil(var_354_0) then
					arg_351_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1111ui_story then
				arg_351_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_354_4 = arg_351_1.actors_["10131ui_story"]
			local var_354_5 = 0

			if var_354_5 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 and not isNil(var_354_4) and arg_351_1.var_.characterEffect10131ui_story == nil then
				arg_351_1.var_.characterEffect10131ui_story = var_354_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_6 = 0.200000002980232

			if var_354_5 <= arg_351_1.time_ and arg_351_1.time_ < var_354_5 + var_354_6 and not isNil(var_354_4) then
				local var_354_7 = (arg_351_1.time_ - var_354_5) / var_354_6

				if arg_351_1.var_.characterEffect10131ui_story and not isNil(var_354_4) then
					local var_354_8 = Mathf.Lerp(0, 0.5, var_354_7)

					arg_351_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_351_1.var_.characterEffect10131ui_story.fillRatio = var_354_8
				end
			end

			if arg_351_1.time_ >= var_354_5 + var_354_6 and arg_351_1.time_ < var_354_5 + var_354_6 + arg_354_0 and not isNil(var_354_4) and arg_351_1.var_.characterEffect10131ui_story then
				local var_354_9 = 0.5

				arg_351_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_351_1.var_.characterEffect10131ui_story.fillRatio = var_354_9
			end

			local var_354_10 = 0

			if var_354_10 < arg_351_1.time_ and arg_351_1.time_ <= var_354_10 + arg_354_0 then
				arg_351_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action4_1")
			end

			local var_354_11 = 0

			if var_354_11 < arg_351_1.time_ and arg_351_1.time_ <= var_354_11 + arg_354_0 then
				arg_351_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_354_12 = 0
			local var_354_13 = 0.125

			if var_354_12 < arg_351_1.time_ and arg_351_1.time_ <= var_354_12 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_14 = arg_351_1:FormatText(StoryNameCfg[67].name)

				arg_351_1.leftNameTxt_.text = var_354_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_15 = arg_351_1:GetWordFromCfg(322211086)
				local var_354_16 = arg_351_1:FormatText(var_354_15.content)

				arg_351_1.text_.text = var_354_16

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_17 = 5
				local var_354_18 = utf8.len(var_354_16)
				local var_354_19 = var_354_17 <= 0 and var_354_13 or var_354_13 * (var_354_18 / var_354_17)

				if var_354_19 > 0 and var_354_13 < var_354_19 then
					arg_351_1.talkMaxDuration = var_354_19

					if var_354_19 + var_354_12 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_19 + var_354_12
					end
				end

				arg_351_1.text_.text = var_354_16
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211086", "story_v_out_322211.awb") ~= 0 then
					local var_354_20 = manager.audio:GetVoiceLength("story_v_out_322211", "322211086", "story_v_out_322211.awb") / 1000

					if var_354_20 + var_354_12 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_20 + var_354_12
					end

					if var_354_15.prefab_name ~= "" and arg_351_1.actors_[var_354_15.prefab_name] ~= nil then
						local var_354_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_15.prefab_name].transform, "story_v_out_322211", "322211086", "story_v_out_322211.awb")

						arg_351_1:RecordAudio("322211086", var_354_21)
						arg_351_1:RecordAudio("322211086", var_354_21)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_322211", "322211086", "story_v_out_322211.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_322211", "322211086", "story_v_out_322211.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_22 = math.max(var_354_13, arg_351_1.talkMaxDuration)

			if var_354_12 <= arg_351_1.time_ and arg_351_1.time_ < var_354_12 + var_354_22 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_12) / var_354_22

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_12 + var_354_22 and arg_351_1.time_ < var_354_12 + var_354_22 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play322211087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 322211087
		arg_355_1.duration_ = 4.7

		local var_355_0 = {
			zh = 4.433,
			ja = 4.7
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play322211088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["10131ui_story"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect10131ui_story == nil then
				arg_355_1.var_.characterEffect10131ui_story = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 and not isNil(var_358_0) then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.characterEffect10131ui_story and not isNil(var_358_0) then
					arg_355_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and not isNil(var_358_0) and arg_355_1.var_.characterEffect10131ui_story then
				arg_355_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_358_4 = arg_355_1.actors_["1111ui_story"]
			local var_358_5 = 0

			if var_358_5 < arg_355_1.time_ and arg_355_1.time_ <= var_358_5 + arg_358_0 and not isNil(var_358_4) and arg_355_1.var_.characterEffect1111ui_story == nil then
				arg_355_1.var_.characterEffect1111ui_story = var_358_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_6 = 0.200000002980232

			if var_358_5 <= arg_355_1.time_ and arg_355_1.time_ < var_358_5 + var_358_6 and not isNil(var_358_4) then
				local var_358_7 = (arg_355_1.time_ - var_358_5) / var_358_6

				if arg_355_1.var_.characterEffect1111ui_story and not isNil(var_358_4) then
					local var_358_8 = Mathf.Lerp(0, 0.5, var_358_7)

					arg_355_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1111ui_story.fillRatio = var_358_8
				end
			end

			if arg_355_1.time_ >= var_358_5 + var_358_6 and arg_355_1.time_ < var_358_5 + var_358_6 + arg_358_0 and not isNil(var_358_4) and arg_355_1.var_.characterEffect1111ui_story then
				local var_358_9 = 0.5

				arg_355_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1111ui_story.fillRatio = var_358_9
			end

			local var_358_10 = 0
			local var_358_11 = 0.575

			if var_358_10 < arg_355_1.time_ and arg_355_1.time_ <= var_358_10 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_12 = arg_355_1:FormatText(StoryNameCfg[1178].name)

				arg_355_1.leftNameTxt_.text = var_358_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_13 = arg_355_1:GetWordFromCfg(322211087)
				local var_358_14 = arg_355_1:FormatText(var_358_13.content)

				arg_355_1.text_.text = var_358_14

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_15 = 23
				local var_358_16 = utf8.len(var_358_14)
				local var_358_17 = var_358_15 <= 0 and var_358_11 or var_358_11 * (var_358_16 / var_358_15)

				if var_358_17 > 0 and var_358_11 < var_358_17 then
					arg_355_1.talkMaxDuration = var_358_17

					if var_358_17 + var_358_10 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_17 + var_358_10
					end
				end

				arg_355_1.text_.text = var_358_14
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211087", "story_v_out_322211.awb") ~= 0 then
					local var_358_18 = manager.audio:GetVoiceLength("story_v_out_322211", "322211087", "story_v_out_322211.awb") / 1000

					if var_358_18 + var_358_10 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_18 + var_358_10
					end

					if var_358_13.prefab_name ~= "" and arg_355_1.actors_[var_358_13.prefab_name] ~= nil then
						local var_358_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_13.prefab_name].transform, "story_v_out_322211", "322211087", "story_v_out_322211.awb")

						arg_355_1:RecordAudio("322211087", var_358_19)
						arg_355_1:RecordAudio("322211087", var_358_19)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_322211", "322211087", "story_v_out_322211.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_322211", "322211087", "story_v_out_322211.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_20 = math.max(var_358_11, arg_355_1.talkMaxDuration)

			if var_358_10 <= arg_355_1.time_ and arg_355_1.time_ < var_358_10 + var_358_20 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_10) / var_358_20

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_10 + var_358_20 and arg_355_1.time_ < var_358_10 + var_358_20 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play322211088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 322211088
		arg_359_1.duration_ = 14.7

		local var_359_0 = {
			zh = 8.566,
			ja = 14.7
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play322211089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0
			local var_362_1 = 0.9

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_2 = arg_359_1:FormatText(StoryNameCfg[1178].name)

				arg_359_1.leftNameTxt_.text = var_362_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_3 = arg_359_1:GetWordFromCfg(322211088)
				local var_362_4 = arg_359_1:FormatText(var_362_3.content)

				arg_359_1.text_.text = var_362_4

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_5 = 36
				local var_362_6 = utf8.len(var_362_4)
				local var_362_7 = var_362_5 <= 0 and var_362_1 or var_362_1 * (var_362_6 / var_362_5)

				if var_362_7 > 0 and var_362_1 < var_362_7 then
					arg_359_1.talkMaxDuration = var_362_7

					if var_362_7 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_7 + var_362_0
					end
				end

				arg_359_1.text_.text = var_362_4
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211088", "story_v_out_322211.awb") ~= 0 then
					local var_362_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211088", "story_v_out_322211.awb") / 1000

					if var_362_8 + var_362_0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_0
					end

					if var_362_3.prefab_name ~= "" and arg_359_1.actors_[var_362_3.prefab_name] ~= nil then
						local var_362_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_3.prefab_name].transform, "story_v_out_322211", "322211088", "story_v_out_322211.awb")

						arg_359_1:RecordAudio("322211088", var_362_9)
						arg_359_1:RecordAudio("322211088", var_362_9)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_322211", "322211088", "story_v_out_322211.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_322211", "322211088", "story_v_out_322211.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_10 = math.max(var_362_1, arg_359_1.talkMaxDuration)

			if var_362_0 <= arg_359_1.time_ and arg_359_1.time_ < var_362_0 + var_362_10 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_0) / var_362_10

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_0 + var_362_10 and arg_359_1.time_ < var_362_0 + var_362_10 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play322211089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 322211089
		arg_363_1.duration_ = 9.4

		local var_363_0 = {
			zh = 7.833,
			ja = 9.4
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play322211090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0
			local var_366_1 = 0.725

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_2 = arg_363_1:FormatText(StoryNameCfg[1178].name)

				arg_363_1.leftNameTxt_.text = var_366_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_3 = arg_363_1:GetWordFromCfg(322211089)
				local var_366_4 = arg_363_1:FormatText(var_366_3.content)

				arg_363_1.text_.text = var_366_4

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 29
				local var_366_6 = utf8.len(var_366_4)
				local var_366_7 = var_366_5 <= 0 and var_366_1 or var_366_1 * (var_366_6 / var_366_5)

				if var_366_7 > 0 and var_366_1 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_0
					end
				end

				arg_363_1.text_.text = var_366_4
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211089", "story_v_out_322211.awb") ~= 0 then
					local var_366_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211089", "story_v_out_322211.awb") / 1000

					if var_366_8 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_0
					end

					if var_366_3.prefab_name ~= "" and arg_363_1.actors_[var_366_3.prefab_name] ~= nil then
						local var_366_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_3.prefab_name].transform, "story_v_out_322211", "322211089", "story_v_out_322211.awb")

						arg_363_1:RecordAudio("322211089", var_366_9)
						arg_363_1:RecordAudio("322211089", var_366_9)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_322211", "322211089", "story_v_out_322211.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_322211", "322211089", "story_v_out_322211.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_10 = math.max(var_366_1, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_10 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_0) / var_366_10

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_10 and arg_363_1.time_ < var_366_0 + var_366_10 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play322211090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 322211090
		arg_367_1.duration_ = 14.07

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play322211091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 1

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				local var_370_1 = manager.ui.mainCamera.transform.localPosition
				local var_370_2 = Vector3.New(0, 0, 10) + Vector3.New(var_370_1.x, var_370_1.y, 0)
				local var_370_3 = arg_367_1.bgs_.STblack

				var_370_3.transform.localPosition = var_370_2
				var_370_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_370_4 = var_370_3:GetComponent("SpriteRenderer")

				if var_370_4 and var_370_4.sprite then
					local var_370_5 = (var_370_3.transform.localPosition - var_370_1).z
					local var_370_6 = manager.ui.mainCameraCom_
					local var_370_7 = 2 * var_370_5 * Mathf.Tan(var_370_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_370_8 = var_370_7 * var_370_6.aspect
					local var_370_9 = var_370_4.sprite.bounds.size.x
					local var_370_10 = var_370_4.sprite.bounds.size.y
					local var_370_11 = var_370_8 / var_370_9
					local var_370_12 = var_370_7 / var_370_10
					local var_370_13 = var_370_12 < var_370_11 and var_370_11 or var_370_12

					var_370_3.transform.localScale = Vector3.New(var_370_13, var_370_13, 0)
				end

				for iter_370_0, iter_370_1 in pairs(arg_367_1.bgs_) do
					if iter_370_0 ~= "STblack" then
						iter_370_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_370_14 = 0

			if var_370_14 < arg_367_1.time_ and arg_367_1.time_ <= var_370_14 + arg_370_0 then
				arg_367_1.mask_.enabled = true
				arg_367_1.mask_.raycastTarget = true

				arg_367_1:SetGaussion(false)
			end

			local var_370_15 = 1

			if var_370_14 <= arg_367_1.time_ and arg_367_1.time_ < var_370_14 + var_370_15 then
				local var_370_16 = (arg_367_1.time_ - var_370_14) / var_370_15
				local var_370_17 = Color.New(0, 0, 0)

				var_370_17.a = Mathf.Lerp(0, 1, var_370_16)
				arg_367_1.mask_.color = var_370_17
			end

			if arg_367_1.time_ >= var_370_14 + var_370_15 and arg_367_1.time_ < var_370_14 + var_370_15 + arg_370_0 then
				local var_370_18 = Color.New(0, 0, 0)

				var_370_18.a = 1
				arg_367_1.mask_.color = var_370_18
			end

			local var_370_19 = 1

			if var_370_19 < arg_367_1.time_ and arg_367_1.time_ <= var_370_19 + arg_370_0 then
				arg_367_1.mask_.enabled = true
				arg_367_1.mask_.raycastTarget = true

				arg_367_1:SetGaussion(false)
			end

			local var_370_20 = 1

			if var_370_19 <= arg_367_1.time_ and arg_367_1.time_ < var_370_19 + var_370_20 then
				local var_370_21 = (arg_367_1.time_ - var_370_19) / var_370_20
				local var_370_22 = Color.New(0, 0, 0)

				var_370_22.a = Mathf.Lerp(1, 0, var_370_21)
				arg_367_1.mask_.color = var_370_22
			end

			if arg_367_1.time_ >= var_370_19 + var_370_20 and arg_367_1.time_ < var_370_19 + var_370_20 + arg_370_0 then
				local var_370_23 = Color.New(0, 0, 0)
				local var_370_24 = 0

				arg_367_1.mask_.enabled = false
				var_370_23.a = var_370_24
				arg_367_1.mask_.color = var_370_23
			end

			local var_370_25 = arg_367_1.actors_["1111ui_story"].transform
			local var_370_26 = 1

			if var_370_26 < arg_367_1.time_ and arg_367_1.time_ <= var_370_26 + arg_370_0 then
				arg_367_1.var_.moveOldPos1111ui_story = var_370_25.localPosition
			end

			local var_370_27 = 0.001

			if var_370_26 <= arg_367_1.time_ and arg_367_1.time_ < var_370_26 + var_370_27 then
				local var_370_28 = (arg_367_1.time_ - var_370_26) / var_370_27
				local var_370_29 = Vector3.New(0, 100, 0)

				var_370_25.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos1111ui_story, var_370_29, var_370_28)

				local var_370_30 = manager.ui.mainCamera.transform.position - var_370_25.position

				var_370_25.forward = Vector3.New(var_370_30.x, var_370_30.y, var_370_30.z)

				local var_370_31 = var_370_25.localEulerAngles

				var_370_31.z = 0
				var_370_31.x = 0
				var_370_25.localEulerAngles = var_370_31
			end

			if arg_367_1.time_ >= var_370_26 + var_370_27 and arg_367_1.time_ < var_370_26 + var_370_27 + arg_370_0 then
				var_370_25.localPosition = Vector3.New(0, 100, 0)

				local var_370_32 = manager.ui.mainCamera.transform.position - var_370_25.position

				var_370_25.forward = Vector3.New(var_370_32.x, var_370_32.y, var_370_32.z)

				local var_370_33 = var_370_25.localEulerAngles

				var_370_33.z = 0
				var_370_33.x = 0
				var_370_25.localEulerAngles = var_370_33
			end

			local var_370_34 = arg_367_1.actors_["10131ui_story"].transform
			local var_370_35 = 1

			if var_370_35 < arg_367_1.time_ and arg_367_1.time_ <= var_370_35 + arg_370_0 then
				arg_367_1.var_.moveOldPos10131ui_story = var_370_34.localPosition
			end

			local var_370_36 = 0.001

			if var_370_35 <= arg_367_1.time_ and arg_367_1.time_ < var_370_35 + var_370_36 then
				local var_370_37 = (arg_367_1.time_ - var_370_35) / var_370_36
				local var_370_38 = Vector3.New(0, 100, 0)

				var_370_34.localPosition = Vector3.Lerp(arg_367_1.var_.moveOldPos10131ui_story, var_370_38, var_370_37)

				local var_370_39 = manager.ui.mainCamera.transform.position - var_370_34.position

				var_370_34.forward = Vector3.New(var_370_39.x, var_370_39.y, var_370_39.z)

				local var_370_40 = var_370_34.localEulerAngles

				var_370_40.z = 0
				var_370_40.x = 0
				var_370_34.localEulerAngles = var_370_40
			end

			if arg_367_1.time_ >= var_370_35 + var_370_36 and arg_367_1.time_ < var_370_35 + var_370_36 + arg_370_0 then
				var_370_34.localPosition = Vector3.New(0, 100, 0)

				local var_370_41 = manager.ui.mainCamera.transform.position - var_370_34.position

				var_370_34.forward = Vector3.New(var_370_41.x, var_370_41.y, var_370_41.z)

				local var_370_42 = var_370_34.localEulerAngles

				var_370_42.z = 0
				var_370_42.x = 0
				var_370_34.localEulerAngles = var_370_42
			end

			local var_370_43 = 2
			local var_370_44 = 12.066
			local var_370_45 = manager.audio:GetVoiceLength("story_v_out_322211", "322211090", "story_v_out_322211.awb") / 1000

			if var_370_45 > 0 and var_370_44 < var_370_45 and var_370_45 + var_370_43 > arg_367_1.duration_ then
				local var_370_46 = var_370_45

				arg_367_1.duration_ = var_370_45 + var_370_43
			end

			if var_370_43 < arg_367_1.time_ and arg_367_1.time_ <= var_370_43 + arg_370_0 then
				local var_370_47 = "play"
				local var_370_48 = "voice"

				arg_367_1:AudioAction(var_370_47, var_370_48, "story_v_out_322211", "322211090", "story_v_out_322211.awb")
			end
		end

		arg_367_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = false,
				contentID = 419170,
				charCount = 3,
				enableLayoutChange = true,
				duration = 1,
				groupID = "1090",
				startTime = 1,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.MiddleCenter
				},
				textComProperty = {
					fontSize = 110,
					fontAssetPath = "Fonts/SourceHanSerifCN-Bold-3.0",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.MiddleCenter
				}
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322211090,
				charCount = 49,
				enableLayoutChange = true,
				duration = 3.26666666666667,
				groupID = "10901",
				startTime = 2,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_367_1:InitPlayNodeList()
	end,
	Play322211091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 322211091
		arg_371_1.duration_ = 8.23

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play322211092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0
			local var_374_1 = 8.233
			local var_374_2 = manager.audio:GetVoiceLength("story_v_out_322211", "322211091", "story_v_out_322211.awb") / 1000

			if var_374_2 > 0 and var_374_1 < var_374_2 and var_374_2 + var_374_0 > arg_371_1.duration_ then
				local var_374_3 = var_374_2

				arg_371_1.duration_ = var_374_2 + var_374_0
			end

			if var_374_0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_0 + arg_374_0 then
				local var_374_4 = "play"
				local var_374_5 = "voice"

				arg_371_1:AudioAction(var_374_4, var_374_5, "story_v_out_322211", "322211091", "story_v_out_322211.awb")
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322211091,
				charCount = 37,
				enableLayoutChange = true,
				duration = 2.46666666666667,
				groupID = "1091",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "10901",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play322211092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 322211092
		arg_375_1.duration_ = 12.9

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play322211093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0
			local var_378_1 = 12.9
			local var_378_2 = manager.audio:GetVoiceLength("story_v_out_322211", "322211092", "story_v_out_322211.awb") / 1000

			if var_378_2 > 0 and var_378_1 < var_378_2 and var_378_2 + var_378_0 > arg_375_1.duration_ then
				local var_378_3 = var_378_2

				arg_375_1.duration_ = var_378_2 + var_378_0
			end

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				local var_378_4 = "play"
				local var_378_5 = "voice"

				arg_375_1:AudioAction(var_378_4, var_378_5, "story_v_out_322211", "322211092", "story_v_out_322211.awb")
			end
		end

		arg_375_1.nodeConfigList_ = {
			{
				groupID = "1091",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322211092,
				charCount = 47,
				enableLayoutChange = true,
				duration = 3.13333333333333,
				groupID = "1092",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.CREATE_TEXT_GROUP,
				layoutData = {
					topPadding = 0,
					bottomPadding = 0,
					rightPadding = 0,
					leftPadding = 0,
					paragraphSpacing = 0,
					offsetMin = Vector2.New(100, 256),
					offsetMax = Vector2.New(-100, -140),
					paragraphAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.LowerCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_375_1:InitPlayNodeList()
	end,
	Play322211093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 322211093
		arg_379_1.duration_ = 4.93

		local var_379_0 = {
			zh = 4.933,
			ja = 4.566
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play322211094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.6

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				local var_382_1 = manager.ui.mainCamera.transform.localPosition
				local var_382_2 = Vector3.New(0, 0, 10) + Vector3.New(var_382_1.x, var_382_1.y, 0)
				local var_382_3 = arg_379_1.bgs_.L09f

				var_382_3.transform.localPosition = var_382_2
				var_382_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_382_4 = var_382_3:GetComponent("SpriteRenderer")

				if var_382_4 and var_382_4.sprite then
					local var_382_5 = (var_382_3.transform.localPosition - var_382_1).z
					local var_382_6 = manager.ui.mainCameraCom_
					local var_382_7 = 2 * var_382_5 * Mathf.Tan(var_382_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_382_8 = var_382_7 * var_382_6.aspect
					local var_382_9 = var_382_4.sprite.bounds.size.x
					local var_382_10 = var_382_4.sprite.bounds.size.y
					local var_382_11 = var_382_8 / var_382_9
					local var_382_12 = var_382_7 / var_382_10
					local var_382_13 = var_382_12 < var_382_11 and var_382_11 or var_382_12

					var_382_3.transform.localScale = Vector3.New(var_382_13, var_382_13, 0)
				end

				for iter_382_0, iter_382_1 in pairs(arg_379_1.bgs_) do
					if iter_382_0 ~= "L09f" then
						iter_382_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_382_14 = 0

			if var_382_14 < arg_379_1.time_ and arg_379_1.time_ <= var_382_14 + arg_382_0 then
				arg_379_1.mask_.enabled = true
				arg_379_1.mask_.raycastTarget = true

				arg_379_1:SetGaussion(false)
			end

			local var_382_15 = 0.6

			if var_382_14 <= arg_379_1.time_ and arg_379_1.time_ < var_382_14 + var_382_15 then
				local var_382_16 = (arg_379_1.time_ - var_382_14) / var_382_15
				local var_382_17 = Color.New(0, 0, 0)

				var_382_17.a = Mathf.Lerp(0, 1, var_382_16)
				arg_379_1.mask_.color = var_382_17
			end

			if arg_379_1.time_ >= var_382_14 + var_382_15 and arg_379_1.time_ < var_382_14 + var_382_15 + arg_382_0 then
				local var_382_18 = Color.New(0, 0, 0)

				var_382_18.a = 1
				arg_379_1.mask_.color = var_382_18
			end

			local var_382_19 = 0.6

			if var_382_19 < arg_379_1.time_ and arg_379_1.time_ <= var_382_19 + arg_382_0 then
				arg_379_1.mask_.enabled = true
				arg_379_1.mask_.raycastTarget = true

				arg_379_1:SetGaussion(false)
			end

			local var_382_20 = 1

			if var_382_19 <= arg_379_1.time_ and arg_379_1.time_ < var_382_19 + var_382_20 then
				local var_382_21 = (arg_379_1.time_ - var_382_19) / var_382_20
				local var_382_22 = Color.New(0, 0, 0)

				var_382_22.a = Mathf.Lerp(1, 0, var_382_21)
				arg_379_1.mask_.color = var_382_22
			end

			if arg_379_1.time_ >= var_382_19 + var_382_20 and arg_379_1.time_ < var_382_19 + var_382_20 + arg_382_0 then
				local var_382_23 = Color.New(0, 0, 0)
				local var_382_24 = 0

				arg_379_1.mask_.enabled = false
				var_382_23.a = var_382_24
				arg_379_1.mask_.color = var_382_23
			end

			local var_382_25 = arg_379_1.actors_["1111ui_story"].transform
			local var_382_26 = 1.6

			if var_382_26 < arg_379_1.time_ and arg_379_1.time_ <= var_382_26 + arg_382_0 then
				arg_379_1.var_.moveOldPos1111ui_story = var_382_25.localPosition
			end

			local var_382_27 = 0.001

			if var_382_26 <= arg_379_1.time_ and arg_379_1.time_ < var_382_26 + var_382_27 then
				local var_382_28 = (arg_379_1.time_ - var_382_26) / var_382_27
				local var_382_29 = Vector3.New(0, -0.87, -5.7)

				var_382_25.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos1111ui_story, var_382_29, var_382_28)

				local var_382_30 = manager.ui.mainCamera.transform.position - var_382_25.position

				var_382_25.forward = Vector3.New(var_382_30.x, var_382_30.y, var_382_30.z)

				local var_382_31 = var_382_25.localEulerAngles

				var_382_31.z = 0
				var_382_31.x = 0
				var_382_25.localEulerAngles = var_382_31
			end

			if arg_379_1.time_ >= var_382_26 + var_382_27 and arg_379_1.time_ < var_382_26 + var_382_27 + arg_382_0 then
				var_382_25.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_382_32 = manager.ui.mainCamera.transform.position - var_382_25.position

				var_382_25.forward = Vector3.New(var_382_32.x, var_382_32.y, var_382_32.z)

				local var_382_33 = var_382_25.localEulerAngles

				var_382_33.z = 0
				var_382_33.x = 0
				var_382_25.localEulerAngles = var_382_33
			end

			local var_382_34 = arg_379_1.actors_["1111ui_story"]
			local var_382_35 = 1.6

			if var_382_35 < arg_379_1.time_ and arg_379_1.time_ <= var_382_35 + arg_382_0 and not isNil(var_382_34) and arg_379_1.var_.characterEffect1111ui_story == nil then
				arg_379_1.var_.characterEffect1111ui_story = var_382_34:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_36 = 0.200000002980232

			if var_382_35 <= arg_379_1.time_ and arg_379_1.time_ < var_382_35 + var_382_36 and not isNil(var_382_34) then
				local var_382_37 = (arg_379_1.time_ - var_382_35) / var_382_36

				if arg_379_1.var_.characterEffect1111ui_story and not isNil(var_382_34) then
					arg_379_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= var_382_35 + var_382_36 and arg_379_1.time_ < var_382_35 + var_382_36 + arg_382_0 and not isNil(var_382_34) and arg_379_1.var_.characterEffect1111ui_story then
				arg_379_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_382_38 = 1.6

			if var_382_38 < arg_379_1.time_ and arg_379_1.time_ <= var_382_38 + arg_382_0 then
				arg_379_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action1_1")
			end

			local var_382_39 = 1.6

			if var_382_39 < arg_379_1.time_ and arg_379_1.time_ <= var_382_39 + arg_382_0 then
				arg_379_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva", "EmotionTimelineAnimator")
			end

			if arg_379_1.frameCnt_ <= 1 then
				arg_379_1.dialog_:SetActive(false)
			end

			local var_382_40 = 1.6
			local var_382_41 = 0.275

			if var_382_40 < arg_379_1.time_ and arg_379_1.time_ <= var_382_40 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0

				arg_379_1.dialog_:SetActive(true)

				arg_379_1.dialogCg_.alpha = 0

				local var_382_42 = LeanTween.value(arg_379_1.dialog_, 0, 1, 0.3)

				var_382_42:setOnUpdate(LuaHelper.FloatAction(function(arg_383_0)
					arg_379_1.dialogCg_.alpha = arg_383_0
				end))
				var_382_42:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_379_1.dialog_)
					var_382_42:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_379_1.duration_ = arg_379_1.duration_ + 0.3

				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_43 = arg_379_1:FormatText(StoryNameCfg[67].name)

				arg_379_1.leftNameTxt_.text = var_382_43

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_44 = arg_379_1:GetWordFromCfg(322211093)
				local var_382_45 = arg_379_1:FormatText(var_382_44.content)

				arg_379_1.text_.text = var_382_45

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_46 = 11
				local var_382_47 = utf8.len(var_382_45)
				local var_382_48 = var_382_46 <= 0 and var_382_41 or var_382_41 * (var_382_47 / var_382_46)

				if var_382_48 > 0 and var_382_41 < var_382_48 then
					arg_379_1.talkMaxDuration = var_382_48
					var_382_40 = var_382_40 + 0.3

					if var_382_48 + var_382_40 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_48 + var_382_40
					end
				end

				arg_379_1.text_.text = var_382_45
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211093", "story_v_out_322211.awb") ~= 0 then
					local var_382_49 = manager.audio:GetVoiceLength("story_v_out_322211", "322211093", "story_v_out_322211.awb") / 1000

					if var_382_49 + var_382_40 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_49 + var_382_40
					end

					if var_382_44.prefab_name ~= "" and arg_379_1.actors_[var_382_44.prefab_name] ~= nil then
						local var_382_50 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_44.prefab_name].transform, "story_v_out_322211", "322211093", "story_v_out_322211.awb")

						arg_379_1:RecordAudio("322211093", var_382_50)
						arg_379_1:RecordAudio("322211093", var_382_50)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_322211", "322211093", "story_v_out_322211.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_322211", "322211093", "story_v_out_322211.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_51 = var_382_40 + 0.3
			local var_382_52 = math.max(var_382_41, arg_379_1.talkMaxDuration)

			if var_382_51 <= arg_379_1.time_ and arg_379_1.time_ < var_382_51 + var_382_52 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_51) / var_382_52

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_51 + var_382_52 and arg_379_1.time_ < var_382_51 + var_382_52 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				groupID = "1090",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0.6,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			},
			{
				groupID = "1092",
				duration = 0.0166666666666667,
				className = "StoryTextGroupNode",
				startTime = 0.6,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play322211094 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 322211094
		arg_385_1.duration_ = 7.2

		local var_385_0 = {
			zh = 6.033,
			ja = 7.2
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play322211095(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["10131ui_story"]
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect10131ui_story == nil then
				arg_385_1.var_.characterEffect10131ui_story = var_388_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_2 = 0.200000002980232

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 and not isNil(var_388_0) then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2

				if arg_385_1.var_.characterEffect10131ui_story and not isNil(var_388_0) then
					arg_385_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 and not isNil(var_388_0) and arg_385_1.var_.characterEffect10131ui_story then
				arg_385_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_388_4 = 0

			if var_388_4 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action1_1")
			end

			local var_388_5 = 0

			if var_388_5 < arg_385_1.time_ and arg_385_1.time_ <= var_388_5 + arg_388_0 then
				arg_385_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_388_6 = arg_385_1.actors_["1111ui_story"].transform
			local var_388_7 = 0

			if var_388_7 < arg_385_1.time_ and arg_385_1.time_ <= var_388_7 + arg_388_0 then
				arg_385_1.var_.moveOldPos1111ui_story = var_388_6.localPosition
			end

			local var_388_8 = 0.001

			if var_388_7 <= arg_385_1.time_ and arg_385_1.time_ < var_388_7 + var_388_8 then
				local var_388_9 = (arg_385_1.time_ - var_388_7) / var_388_8
				local var_388_10 = Vector3.New(0, 100, 0)

				var_388_6.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1111ui_story, var_388_10, var_388_9)

				local var_388_11 = manager.ui.mainCamera.transform.position - var_388_6.position

				var_388_6.forward = Vector3.New(var_388_11.x, var_388_11.y, var_388_11.z)

				local var_388_12 = var_388_6.localEulerAngles

				var_388_12.z = 0
				var_388_12.x = 0
				var_388_6.localEulerAngles = var_388_12
			end

			if arg_385_1.time_ >= var_388_7 + var_388_8 and arg_385_1.time_ < var_388_7 + var_388_8 + arg_388_0 then
				var_388_6.localPosition = Vector3.New(0, 100, 0)

				local var_388_13 = manager.ui.mainCamera.transform.position - var_388_6.position

				var_388_6.forward = Vector3.New(var_388_13.x, var_388_13.y, var_388_13.z)

				local var_388_14 = var_388_6.localEulerAngles

				var_388_14.z = 0
				var_388_14.x = 0
				var_388_6.localEulerAngles = var_388_14
			end

			local var_388_15 = arg_385_1.actors_["10131ui_story"].transform
			local var_388_16 = 0

			if var_388_16 < arg_385_1.time_ and arg_385_1.time_ <= var_388_16 + arg_388_0 then
				arg_385_1.var_.moveOldPos10131ui_story = var_388_15.localPosition
			end

			local var_388_17 = 0.001

			if var_388_16 <= arg_385_1.time_ and arg_385_1.time_ < var_388_16 + var_388_17 then
				local var_388_18 = (arg_385_1.time_ - var_388_16) / var_388_17
				local var_388_19 = Vector3.New(0.05, -0.96, -5.8)

				var_388_15.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos10131ui_story, var_388_19, var_388_18)

				local var_388_20 = manager.ui.mainCamera.transform.position - var_388_15.position

				var_388_15.forward = Vector3.New(var_388_20.x, var_388_20.y, var_388_20.z)

				local var_388_21 = var_388_15.localEulerAngles

				var_388_21.z = 0
				var_388_21.x = 0
				var_388_15.localEulerAngles = var_388_21
			end

			if arg_385_1.time_ >= var_388_16 + var_388_17 and arg_385_1.time_ < var_388_16 + var_388_17 + arg_388_0 then
				var_388_15.localPosition = Vector3.New(0.05, -0.96, -5.8)

				local var_388_22 = manager.ui.mainCamera.transform.position - var_388_15.position

				var_388_15.forward = Vector3.New(var_388_22.x, var_388_22.y, var_388_22.z)

				local var_388_23 = var_388_15.localEulerAngles

				var_388_23.z = 0
				var_388_23.x = 0
				var_388_15.localEulerAngles = var_388_23
			end

			local var_388_24 = 0
			local var_388_25 = 0.675

			if var_388_24 < arg_385_1.time_ and arg_385_1.time_ <= var_388_24 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_26 = arg_385_1:FormatText(StoryNameCfg[1178].name)

				arg_385_1.leftNameTxt_.text = var_388_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_27 = arg_385_1:GetWordFromCfg(322211094)
				local var_388_28 = arg_385_1:FormatText(var_388_27.content)

				arg_385_1.text_.text = var_388_28

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_29 = 27
				local var_388_30 = utf8.len(var_388_28)
				local var_388_31 = var_388_29 <= 0 and var_388_25 or var_388_25 * (var_388_30 / var_388_29)

				if var_388_31 > 0 and var_388_25 < var_388_31 then
					arg_385_1.talkMaxDuration = var_388_31

					if var_388_31 + var_388_24 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_31 + var_388_24
					end
				end

				arg_385_1.text_.text = var_388_28
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211094", "story_v_out_322211.awb") ~= 0 then
					local var_388_32 = manager.audio:GetVoiceLength("story_v_out_322211", "322211094", "story_v_out_322211.awb") / 1000

					if var_388_32 + var_388_24 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_32 + var_388_24
					end

					if var_388_27.prefab_name ~= "" and arg_385_1.actors_[var_388_27.prefab_name] ~= nil then
						local var_388_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_27.prefab_name].transform, "story_v_out_322211", "322211094", "story_v_out_322211.awb")

						arg_385_1:RecordAudio("322211094", var_388_33)
						arg_385_1:RecordAudio("322211094", var_388_33)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_322211", "322211094", "story_v_out_322211.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_322211", "322211094", "story_v_out_322211.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_34 = math.max(var_388_25, arg_385_1.talkMaxDuration)

			if var_388_24 <= arg_385_1.time_ and arg_385_1.time_ < var_388_24 + var_388_34 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_24) / var_388_34

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_24 + var_388_34 and arg_385_1.time_ < var_388_24 + var_388_34 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play322211095 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 322211095
		arg_389_1.duration_ = 14.03

		local var_389_0 = {
			zh = 10.533,
			ja = 14.033
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play322211096(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_392_1 = 0
			local var_392_2 = 1.15

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_3 = arg_389_1:FormatText(StoryNameCfg[1178].name)

				arg_389_1.leftNameTxt_.text = var_392_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_4 = arg_389_1:GetWordFromCfg(322211095)
				local var_392_5 = arg_389_1:FormatText(var_392_4.content)

				arg_389_1.text_.text = var_392_5

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_6 = 46
				local var_392_7 = utf8.len(var_392_5)
				local var_392_8 = var_392_6 <= 0 and var_392_2 or var_392_2 * (var_392_7 / var_392_6)

				if var_392_8 > 0 and var_392_2 < var_392_8 then
					arg_389_1.talkMaxDuration = var_392_8

					if var_392_8 + var_392_1 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_8 + var_392_1
					end
				end

				arg_389_1.text_.text = var_392_5
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211095", "story_v_out_322211.awb") ~= 0 then
					local var_392_9 = manager.audio:GetVoiceLength("story_v_out_322211", "322211095", "story_v_out_322211.awb") / 1000

					if var_392_9 + var_392_1 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_9 + var_392_1
					end

					if var_392_4.prefab_name ~= "" and arg_389_1.actors_[var_392_4.prefab_name] ~= nil then
						local var_392_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_4.prefab_name].transform, "story_v_out_322211", "322211095", "story_v_out_322211.awb")

						arg_389_1:RecordAudio("322211095", var_392_10)
						arg_389_1:RecordAudio("322211095", var_392_10)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_322211", "322211095", "story_v_out_322211.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_322211", "322211095", "story_v_out_322211.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_11 = math.max(var_392_2, arg_389_1.talkMaxDuration)

			if var_392_1 <= arg_389_1.time_ and arg_389_1.time_ < var_392_1 + var_392_11 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_1) / var_392_11

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_1 + var_392_11 and arg_389_1.time_ < var_392_1 + var_392_11 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play322211096 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 322211096
		arg_393_1.duration_ = 15.43

		local var_393_0 = {
			zh = 9.766,
			ja = 15.433
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play322211097(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0
			local var_396_1 = 1.025

			if var_396_0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_2 = arg_393_1:FormatText(StoryNameCfg[1178].name)

				arg_393_1.leftNameTxt_.text = var_396_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_3 = arg_393_1:GetWordFromCfg(322211096)
				local var_396_4 = arg_393_1:FormatText(var_396_3.content)

				arg_393_1.text_.text = var_396_4

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 41
				local var_396_6 = utf8.len(var_396_4)
				local var_396_7 = var_396_5 <= 0 and var_396_1 or var_396_1 * (var_396_6 / var_396_5)

				if var_396_7 > 0 and var_396_1 < var_396_7 then
					arg_393_1.talkMaxDuration = var_396_7

					if var_396_7 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_7 + var_396_0
					end
				end

				arg_393_1.text_.text = var_396_4
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211096", "story_v_out_322211.awb") ~= 0 then
					local var_396_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211096", "story_v_out_322211.awb") / 1000

					if var_396_8 + var_396_0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_8 + var_396_0
					end

					if var_396_3.prefab_name ~= "" and arg_393_1.actors_[var_396_3.prefab_name] ~= nil then
						local var_396_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_3.prefab_name].transform, "story_v_out_322211", "322211096", "story_v_out_322211.awb")

						arg_393_1:RecordAudio("322211096", var_396_9)
						arg_393_1:RecordAudio("322211096", var_396_9)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_322211", "322211096", "story_v_out_322211.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_322211", "322211096", "story_v_out_322211.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_10 = math.max(var_396_1, arg_393_1.talkMaxDuration)

			if var_396_0 <= arg_393_1.time_ and arg_393_1.time_ < var_396_0 + var_396_10 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_0) / var_396_10

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_0 + var_396_10 and arg_393_1.time_ < var_396_0 + var_396_10 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play322211097 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 322211097
		arg_397_1.duration_ = 12.87

		local var_397_0 = {
			zh = 10.233,
			ja = 12.866
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play322211098(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = 0
			local var_400_1 = 1.125

			if var_400_0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_0 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_2 = arg_397_1:FormatText(StoryNameCfg[1178].name)

				arg_397_1.leftNameTxt_.text = var_400_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_3 = arg_397_1:GetWordFromCfg(322211097)
				local var_400_4 = arg_397_1:FormatText(var_400_3.content)

				arg_397_1.text_.text = var_400_4

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_5 = 45
				local var_400_6 = utf8.len(var_400_4)
				local var_400_7 = var_400_5 <= 0 and var_400_1 or var_400_1 * (var_400_6 / var_400_5)

				if var_400_7 > 0 and var_400_1 < var_400_7 then
					arg_397_1.talkMaxDuration = var_400_7

					if var_400_7 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_7 + var_400_0
					end
				end

				arg_397_1.text_.text = var_400_4
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211097", "story_v_out_322211.awb") ~= 0 then
					local var_400_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211097", "story_v_out_322211.awb") / 1000

					if var_400_8 + var_400_0 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_8 + var_400_0
					end

					if var_400_3.prefab_name ~= "" and arg_397_1.actors_[var_400_3.prefab_name] ~= nil then
						local var_400_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_3.prefab_name].transform, "story_v_out_322211", "322211097", "story_v_out_322211.awb")

						arg_397_1:RecordAudio("322211097", var_400_9)
						arg_397_1:RecordAudio("322211097", var_400_9)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_322211", "322211097", "story_v_out_322211.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_322211", "322211097", "story_v_out_322211.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_10 = math.max(var_400_1, arg_397_1.talkMaxDuration)

			if var_400_0 <= arg_397_1.time_ and arg_397_1.time_ < var_400_0 + var_400_10 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_0) / var_400_10

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_0 + var_400_10 and arg_397_1.time_ < var_400_0 + var_400_10 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play322211098 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 322211098
		arg_401_1.duration_ = 19

		local var_401_0 = {
			zh = 10.666,
			ja = 19
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play322211099(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 0
			local var_404_1 = 1.15

			if var_404_0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_2 = arg_401_1:FormatText(StoryNameCfg[1178].name)

				arg_401_1.leftNameTxt_.text = var_404_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_3 = arg_401_1:GetWordFromCfg(322211098)
				local var_404_4 = arg_401_1:FormatText(var_404_3.content)

				arg_401_1.text_.text = var_404_4

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_5 = 46
				local var_404_6 = utf8.len(var_404_4)
				local var_404_7 = var_404_5 <= 0 and var_404_1 or var_404_1 * (var_404_6 / var_404_5)

				if var_404_7 > 0 and var_404_1 < var_404_7 then
					arg_401_1.talkMaxDuration = var_404_7

					if var_404_7 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_7 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_4
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211098", "story_v_out_322211.awb") ~= 0 then
					local var_404_8 = manager.audio:GetVoiceLength("story_v_out_322211", "322211098", "story_v_out_322211.awb") / 1000

					if var_404_8 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_8 + var_404_0
					end

					if var_404_3.prefab_name ~= "" and arg_401_1.actors_[var_404_3.prefab_name] ~= nil then
						local var_404_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_3.prefab_name].transform, "story_v_out_322211", "322211098", "story_v_out_322211.awb")

						arg_401_1:RecordAudio("322211098", var_404_9)
						arg_401_1:RecordAudio("322211098", var_404_9)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_322211", "322211098", "story_v_out_322211.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_322211", "322211098", "story_v_out_322211.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_10 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_10 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_10

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_10 and arg_401_1.time_ < var_404_0 + var_404_10 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play322211099 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 322211099
		arg_405_1.duration_ = 3.6

		local var_405_0 = {
			zh = 2.033,
			ja = 3.6
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play322211100(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = arg_405_1.actors_["1111ui_story"]
			local var_408_1 = 0

			if var_408_1 < arg_405_1.time_ and arg_405_1.time_ <= var_408_1 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect1111ui_story == nil then
				arg_405_1.var_.characterEffect1111ui_story = var_408_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_2 = 0.200000002980232

			if var_408_1 <= arg_405_1.time_ and arg_405_1.time_ < var_408_1 + var_408_2 and not isNil(var_408_0) then
				local var_408_3 = (arg_405_1.time_ - var_408_1) / var_408_2

				if arg_405_1.var_.characterEffect1111ui_story and not isNil(var_408_0) then
					arg_405_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_405_1.time_ >= var_408_1 + var_408_2 and arg_405_1.time_ < var_408_1 + var_408_2 + arg_408_0 and not isNil(var_408_0) and arg_405_1.var_.characterEffect1111ui_story then
				arg_405_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_408_4 = arg_405_1.actors_["10131ui_story"]
			local var_408_5 = 0

			if var_408_5 < arg_405_1.time_ and arg_405_1.time_ <= var_408_5 + arg_408_0 and not isNil(var_408_4) and arg_405_1.var_.characterEffect10131ui_story == nil then
				arg_405_1.var_.characterEffect10131ui_story = var_408_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_408_6 = 0.200000002980232

			if var_408_5 <= arg_405_1.time_ and arg_405_1.time_ < var_408_5 + var_408_6 and not isNil(var_408_4) then
				local var_408_7 = (arg_405_1.time_ - var_408_5) / var_408_6

				if arg_405_1.var_.characterEffect10131ui_story and not isNil(var_408_4) then
					local var_408_8 = Mathf.Lerp(0, 0.5, var_408_7)

					arg_405_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_405_1.var_.characterEffect10131ui_story.fillRatio = var_408_8
				end
			end

			if arg_405_1.time_ >= var_408_5 + var_408_6 and arg_405_1.time_ < var_408_5 + var_408_6 + arg_408_0 and not isNil(var_408_4) and arg_405_1.var_.characterEffect10131ui_story then
				local var_408_9 = 0.5

				arg_405_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_405_1.var_.characterEffect10131ui_story.fillRatio = var_408_9
			end

			local var_408_10 = arg_405_1.actors_["1111ui_story"].transform
			local var_408_11 = 0

			if var_408_11 < arg_405_1.time_ and arg_405_1.time_ <= var_408_11 + arg_408_0 then
				arg_405_1.var_.moveOldPos1111ui_story = var_408_10.localPosition
			end

			local var_408_12 = 0.001

			if var_408_11 <= arg_405_1.time_ and arg_405_1.time_ < var_408_11 + var_408_12 then
				local var_408_13 = (arg_405_1.time_ - var_408_11) / var_408_12
				local var_408_14 = Vector3.New(0, -0.87, -5.7)

				var_408_10.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos1111ui_story, var_408_14, var_408_13)

				local var_408_15 = manager.ui.mainCamera.transform.position - var_408_10.position

				var_408_10.forward = Vector3.New(var_408_15.x, var_408_15.y, var_408_15.z)

				local var_408_16 = var_408_10.localEulerAngles

				var_408_16.z = 0
				var_408_16.x = 0
				var_408_10.localEulerAngles = var_408_16
			end

			if arg_405_1.time_ >= var_408_11 + var_408_12 and arg_405_1.time_ < var_408_11 + var_408_12 + arg_408_0 then
				var_408_10.localPosition = Vector3.New(0, -0.87, -5.7)

				local var_408_17 = manager.ui.mainCamera.transform.position - var_408_10.position

				var_408_10.forward = Vector3.New(var_408_17.x, var_408_17.y, var_408_17.z)

				local var_408_18 = var_408_10.localEulerAngles

				var_408_18.z = 0
				var_408_18.x = 0
				var_408_10.localEulerAngles = var_408_18
			end

			local var_408_19 = arg_405_1.actors_["10131ui_story"].transform
			local var_408_20 = 0

			if var_408_20 < arg_405_1.time_ and arg_405_1.time_ <= var_408_20 + arg_408_0 then
				arg_405_1.var_.moveOldPos10131ui_story = var_408_19.localPosition
			end

			local var_408_21 = 0.001

			if var_408_20 <= arg_405_1.time_ and arg_405_1.time_ < var_408_20 + var_408_21 then
				local var_408_22 = (arg_405_1.time_ - var_408_20) / var_408_21
				local var_408_23 = Vector3.New(0, 100, 0)

				var_408_19.localPosition = Vector3.Lerp(arg_405_1.var_.moveOldPos10131ui_story, var_408_23, var_408_22)

				local var_408_24 = manager.ui.mainCamera.transform.position - var_408_19.position

				var_408_19.forward = Vector3.New(var_408_24.x, var_408_24.y, var_408_24.z)

				local var_408_25 = var_408_19.localEulerAngles

				var_408_25.z = 0
				var_408_25.x = 0
				var_408_19.localEulerAngles = var_408_25
			end

			if arg_405_1.time_ >= var_408_20 + var_408_21 and arg_405_1.time_ < var_408_20 + var_408_21 + arg_408_0 then
				var_408_19.localPosition = Vector3.New(0, 100, 0)

				local var_408_26 = manager.ui.mainCamera.transform.position - var_408_19.position

				var_408_19.forward = Vector3.New(var_408_26.x, var_408_26.y, var_408_26.z)

				local var_408_27 = var_408_19.localEulerAngles

				var_408_27.z = 0
				var_408_27.x = 0
				var_408_19.localEulerAngles = var_408_27
			end

			local var_408_28 = 0

			if var_408_28 < arg_405_1.time_ and arg_405_1.time_ <= var_408_28 + arg_408_0 then
				arg_405_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_408_29 = 0
			local var_408_30 = 0.2

			if var_408_29 < arg_405_1.time_ and arg_405_1.time_ <= var_408_29 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				local var_408_31 = arg_405_1:FormatText(StoryNameCfg[67].name)

				arg_405_1.leftNameTxt_.text = var_408_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_32 = arg_405_1:GetWordFromCfg(322211099)
				local var_408_33 = arg_405_1:FormatText(var_408_32.content)

				arg_405_1.text_.text = var_408_33

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_34 = 8
				local var_408_35 = utf8.len(var_408_33)
				local var_408_36 = var_408_34 <= 0 and var_408_30 or var_408_30 * (var_408_35 / var_408_34)

				if var_408_36 > 0 and var_408_30 < var_408_36 then
					arg_405_1.talkMaxDuration = var_408_36

					if var_408_36 + var_408_29 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_36 + var_408_29
					end
				end

				arg_405_1.text_.text = var_408_33
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211099", "story_v_out_322211.awb") ~= 0 then
					local var_408_37 = manager.audio:GetVoiceLength("story_v_out_322211", "322211099", "story_v_out_322211.awb") / 1000

					if var_408_37 + var_408_29 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_37 + var_408_29
					end

					if var_408_32.prefab_name ~= "" and arg_405_1.actors_[var_408_32.prefab_name] ~= nil then
						local var_408_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_32.prefab_name].transform, "story_v_out_322211", "322211099", "story_v_out_322211.awb")

						arg_405_1:RecordAudio("322211099", var_408_38)
						arg_405_1:RecordAudio("322211099", var_408_38)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_322211", "322211099", "story_v_out_322211.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_322211", "322211099", "story_v_out_322211.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_39 = math.max(var_408_30, arg_405_1.talkMaxDuration)

			if var_408_29 <= arg_405_1.time_ and arg_405_1.time_ < var_408_29 + var_408_39 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_29) / var_408_39

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_29 + var_408_39 and arg_405_1.time_ < var_408_29 + var_408_39 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1111ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_405_1:InitPlayNodeList()
	end,
	Play322211100 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 322211100
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play322211101(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = arg_409_1.actors_["10131ui_story"].transform
			local var_412_1 = 0

			if var_412_1 < arg_409_1.time_ and arg_409_1.time_ <= var_412_1 + arg_412_0 then
				arg_409_1.var_.moveOldPos10131ui_story = var_412_0.localPosition
			end

			local var_412_2 = 0.001

			if var_412_1 <= arg_409_1.time_ and arg_409_1.time_ < var_412_1 + var_412_2 then
				local var_412_3 = (arg_409_1.time_ - var_412_1) / var_412_2
				local var_412_4 = Vector3.New(0, 100, 0)

				var_412_0.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos10131ui_story, var_412_4, var_412_3)

				local var_412_5 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_5.x, var_412_5.y, var_412_5.z)

				local var_412_6 = var_412_0.localEulerAngles

				var_412_6.z = 0
				var_412_6.x = 0
				var_412_0.localEulerAngles = var_412_6
			end

			if arg_409_1.time_ >= var_412_1 + var_412_2 and arg_409_1.time_ < var_412_1 + var_412_2 + arg_412_0 then
				var_412_0.localPosition = Vector3.New(0, 100, 0)

				local var_412_7 = manager.ui.mainCamera.transform.position - var_412_0.position

				var_412_0.forward = Vector3.New(var_412_7.x, var_412_7.y, var_412_7.z)

				local var_412_8 = var_412_0.localEulerAngles

				var_412_8.z = 0
				var_412_8.x = 0
				var_412_0.localEulerAngles = var_412_8
			end

			local var_412_9 = arg_409_1.actors_["1111ui_story"].transform
			local var_412_10 = 0

			if var_412_10 < arg_409_1.time_ and arg_409_1.time_ <= var_412_10 + arg_412_0 then
				arg_409_1.var_.moveOldPos1111ui_story = var_412_9.localPosition
			end

			local var_412_11 = 0.001

			if var_412_10 <= arg_409_1.time_ and arg_409_1.time_ < var_412_10 + var_412_11 then
				local var_412_12 = (arg_409_1.time_ - var_412_10) / var_412_11
				local var_412_13 = Vector3.New(0, 100, 0)

				var_412_9.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1111ui_story, var_412_13, var_412_12)

				local var_412_14 = manager.ui.mainCamera.transform.position - var_412_9.position

				var_412_9.forward = Vector3.New(var_412_14.x, var_412_14.y, var_412_14.z)

				local var_412_15 = var_412_9.localEulerAngles

				var_412_15.z = 0
				var_412_15.x = 0
				var_412_9.localEulerAngles = var_412_15
			end

			if arg_409_1.time_ >= var_412_10 + var_412_11 and arg_409_1.time_ < var_412_10 + var_412_11 + arg_412_0 then
				var_412_9.localPosition = Vector3.New(0, 100, 0)

				local var_412_16 = manager.ui.mainCamera.transform.position - var_412_9.position

				var_412_9.forward = Vector3.New(var_412_16.x, var_412_16.y, var_412_16.z)

				local var_412_17 = var_412_9.localEulerAngles

				var_412_17.z = 0
				var_412_17.x = 0
				var_412_9.localEulerAngles = var_412_17
			end

			local var_412_18 = 0
			local var_412_19 = 1.025

			if var_412_18 < arg_409_1.time_ and arg_409_1.time_ <= var_412_18 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, false)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_20 = arg_409_1:GetWordFromCfg(322211100)
				local var_412_21 = arg_409_1:FormatText(var_412_20.content)

				arg_409_1.text_.text = var_412_21

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_22 = 41
				local var_412_23 = utf8.len(var_412_21)
				local var_412_24 = var_412_22 <= 0 and var_412_19 or var_412_19 * (var_412_23 / var_412_22)

				if var_412_24 > 0 and var_412_19 < var_412_24 then
					arg_409_1.talkMaxDuration = var_412_24

					if var_412_24 + var_412_18 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_24 + var_412_18
					end
				end

				arg_409_1.text_.text = var_412_21
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_25 = math.max(var_412_19, arg_409_1.talkMaxDuration)

			if var_412_18 <= arg_409_1.time_ and arg_409_1.time_ < var_412_18 + var_412_25 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_18) / var_412_25

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_18 + var_412_25 and arg_409_1.time_ < var_412_18 + var_412_25 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
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

		arg_409_1:InitPlayNodeList()
	end,
	Play322211101 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 322211101
		arg_413_1.duration_ = 6.17

		local var_413_0 = {
			zh = 3.9,
			ja = 6.166
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
			arg_413_1.auto_ = false
		end

		function arg_413_1.playNext_(arg_415_0)
			arg_413_1.onStoryFinished_()
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			local var_416_0 = arg_413_1.actors_["10131ui_story"].transform
			local var_416_1 = 0

			if var_416_1 < arg_413_1.time_ and arg_413_1.time_ <= var_416_1 + arg_416_0 then
				arg_413_1.var_.moveOldPos10131ui_story = var_416_0.localPosition
			end

			local var_416_2 = 0.001

			if var_416_1 <= arg_413_1.time_ and arg_413_1.time_ < var_416_1 + var_416_2 then
				local var_416_3 = (arg_413_1.time_ - var_416_1) / var_416_2
				local var_416_4 = Vector3.New(0.05, -0.96, -5.8)

				var_416_0.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos10131ui_story, var_416_4, var_416_3)

				local var_416_5 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_5.x, var_416_5.y, var_416_5.z)

				local var_416_6 = var_416_0.localEulerAngles

				var_416_6.z = 0
				var_416_6.x = 0
				var_416_0.localEulerAngles = var_416_6
			end

			if arg_413_1.time_ >= var_416_1 + var_416_2 and arg_413_1.time_ < var_416_1 + var_416_2 + arg_416_0 then
				var_416_0.localPosition = Vector3.New(0.05, -0.96, -5.8)

				local var_416_7 = manager.ui.mainCamera.transform.position - var_416_0.position

				var_416_0.forward = Vector3.New(var_416_7.x, var_416_7.y, var_416_7.z)

				local var_416_8 = var_416_0.localEulerAngles

				var_416_8.z = 0
				var_416_8.x = 0
				var_416_0.localEulerAngles = var_416_8
			end

			local var_416_9 = arg_413_1.actors_["10131ui_story"]
			local var_416_10 = 0

			if var_416_10 < arg_413_1.time_ and arg_413_1.time_ <= var_416_10 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect10131ui_story == nil then
				arg_413_1.var_.characterEffect10131ui_story = var_416_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_11 = 0.200000002980232

			if var_416_10 <= arg_413_1.time_ and arg_413_1.time_ < var_416_10 + var_416_11 and not isNil(var_416_9) then
				local var_416_12 = (arg_413_1.time_ - var_416_10) / var_416_11

				if arg_413_1.var_.characterEffect10131ui_story and not isNil(var_416_9) then
					arg_413_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= var_416_10 + var_416_11 and arg_413_1.time_ < var_416_10 + var_416_11 + arg_416_0 and not isNil(var_416_9) and arg_413_1.var_.characterEffect10131ui_story then
				arg_413_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_416_13 = 0

			if var_416_13 < arg_413_1.time_ and arg_413_1.time_ <= var_416_13 + arg_416_0 then
				arg_413_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_416_14 = 0
			local var_416_15 = 0.375

			if var_416_14 < arg_413_1.time_ and arg_413_1.time_ <= var_416_14 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				local var_416_16 = arg_413_1:FormatText(StoryNameCfg[1366].name)

				arg_413_1.leftNameTxt_.text = var_416_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_17 = arg_413_1:GetWordFromCfg(322211101)
				local var_416_18 = arg_413_1:FormatText(var_416_17.content)

				arg_413_1.text_.text = var_416_18

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_19 = 15
				local var_416_20 = utf8.len(var_416_18)
				local var_416_21 = var_416_19 <= 0 and var_416_15 or var_416_15 * (var_416_20 / var_416_19)

				if var_416_21 > 0 and var_416_15 < var_416_21 then
					arg_413_1.talkMaxDuration = var_416_21

					if var_416_21 + var_416_14 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_21 + var_416_14
					end
				end

				arg_413_1.text_.text = var_416_18
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322211", "322211101", "story_v_out_322211.awb") ~= 0 then
					local var_416_22 = manager.audio:GetVoiceLength("story_v_out_322211", "322211101", "story_v_out_322211.awb") / 1000

					if var_416_22 + var_416_14 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_22 + var_416_14
					end

					if var_416_17.prefab_name ~= "" and arg_413_1.actors_[var_416_17.prefab_name] ~= nil then
						local var_416_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_17.prefab_name].transform, "story_v_out_322211", "322211101", "story_v_out_322211.awb")

						arg_413_1:RecordAudio("322211101", var_416_23)
						arg_413_1:RecordAudio("322211101", var_416_23)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_322211", "322211101", "story_v_out_322211.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_322211", "322211101", "story_v_out_322211.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_24 = math.max(var_416_15, arg_413_1.talkMaxDuration)

			if var_416_14 <= arg_413_1.time_ and arg_413_1.time_ < var_416_14 + var_416_24 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_14) / var_416_24

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_14 + var_416_24 and arg_413_1.time_ < var_416_14 + var_416_24 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10131ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L09f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_322211.awb"
	}
}
