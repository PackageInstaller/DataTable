return {
	Play322072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322072001
		arg_1_1.duration_ = 4.13

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322072002(arg_1_1)
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

			local var_4_17 = 0.166666666666667

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

			local var_4_24 = "10152ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "10152ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "10152ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["10152ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos10152ui_story = var_4_29.localPosition

				local var_4_31 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_31 then
					var_4_31:EnableDynamicBone(false)
				end
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(0, -1.73, -5.5)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10152ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1.73, -5.5)

				local var_4_37 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_37.x, var_4_37.y, var_4_37.z)

				local var_4_38 = var_4_29.localEulerAngles

				var_4_38.z = 0
				var_4_38.x = 0
				var_4_29.localEulerAngles = var_4_38

				local var_4_39 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_39 then
					var_4_39:EnableDynamicBone(true)
				end
			end

			local var_4_40 = arg_1_1.actors_["10152ui_story"]
			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect10152ui_story == nil then
				arg_1_1.var_.characterEffect10152ui_story = var_4_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_42 = 0.200000002980232

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.characterEffect10152ui_story and not isNil(var_4_40) then
					arg_1_1.var_.characterEffect10152ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect10152ui_story then
				arg_1_1.var_.characterEffect10152ui_story.fillFlat = false
			end

			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("10152ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			local var_4_45 = 1.8

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("10152ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_4_46 = 0
			local var_4_47 = 0.200000002980232

			if var_4_46 < arg_1_1.time_ and arg_1_1.time_ <= var_4_46 + arg_4_0 then
				local var_4_48 = "play"
				local var_4_49 = "music"

				arg_1_1:AudioAction(var_4_48, var_4_49, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_50 = ""
				local var_4_51 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_51 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_51 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_51

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_51
						arg_1_1.bgmTxt2_.text = var_4_51
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

			local var_4_52 = 0.3
			local var_4_53 = 1

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				local var_4_54 = "play"
				local var_4_55 = "music"

				arg_1_1:AudioAction(var_4_54, var_4_55, "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled.awb")

				local var_4_56 = ""
				local var_4_57 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_unsettled", "bgm_activity_4_0_story_quake_unsettled")

				if var_4_57 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_57 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_57

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_57
						arg_1_1.bgmTxt2_.text = var_4_57
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

			local var_4_58 = 0.200000002980232
			local var_4_59 = 1

			if var_4_58 < arg_1_1.time_ and arg_1_1.time_ <= var_4_58 + arg_4_0 then
				local var_4_60 = "play"
				local var_4_61 = "effect"

				arg_1_1:AudioAction(var_4_60, var_4_61, "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_4_62 = 2.00000000298023
			local var_4_63 = 0.0666666636864348

			if var_4_62 < arg_1_1.time_ and arg_1_1.time_ <= var_4_62 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[1361].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(322072001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 2
				local var_4_68 = utf8.len(var_4_66)
				local var_4_69 = var_4_67 <= 0 and var_4_63 or var_4_63 * (var_4_68 / var_4_67)

				if var_4_69 > 0 and var_4_63 < var_4_69 then
					arg_1_1.talkMaxDuration = var_4_69

					if var_4_69 + var_4_62 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_62
					end
				end

				arg_1_1.text_.text = var_4_66
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072001", "story_v_out_322072.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_322072", "322072001", "story_v_out_322072.awb") / 1000

					if var_4_70 + var_4_62 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_62
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_322072", "322072001", "story_v_out_322072.awb")

						arg_1_1:RecordAudio("322072001", var_4_71)
						arg_1_1:RecordAudio("322072001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322072", "322072001", "story_v_out_322072.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322072", "322072001", "story_v_out_322072.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_72 = math.max(var_4_63, arg_1_1.talkMaxDuration)

			if var_4_62 <= arg_1_1.time_ and arg_1_1.time_ < var_4_62 + var_4_72 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_62) / var_4_72

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_62 + var_4_72 and arg_1_1.time_ < var_4_62 + var_4_72 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10152ui_story",
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
	Play322072002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 322072002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play322072003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = arg_7_1.actors_["10152ui_story"].transform
			local var_10_1 = 0

			if var_10_1 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 then
				arg_7_1.var_.moveOldPos10152ui_story = var_10_0.localPosition

				local var_10_2 = GameObjectTools.GetOrAddComponent(var_10_0.gameObject, typeof(DynamicBoneHelper))

				if var_10_2 then
					var_10_2:EnableDynamicBone(false)
				end
			end

			local var_10_3 = 0.001

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_3 then
				local var_10_4 = (arg_7_1.time_ - var_10_1) / var_10_3
				local var_10_5 = Vector3.New(0, 100, 0)

				var_10_0.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos10152ui_story, var_10_5, var_10_4)

				local var_10_6 = manager.ui.mainCamera.transform.position - var_10_0.position

				var_10_0.forward = Vector3.New(var_10_6.x, var_10_6.y, var_10_6.z)

				local var_10_7 = var_10_0.localEulerAngles

				var_10_7.z = 0
				var_10_7.x = 0
				var_10_0.localEulerAngles = var_10_7
			end

			if arg_7_1.time_ >= var_10_1 + var_10_3 and arg_7_1.time_ < var_10_1 + var_10_3 + arg_10_0 then
				var_10_0.localPosition = Vector3.New(0, 100, 0)

				local var_10_8 = manager.ui.mainCamera.transform.position - var_10_0.position

				var_10_0.forward = Vector3.New(var_10_8.x, var_10_8.y, var_10_8.z)

				local var_10_9 = var_10_0.localEulerAngles

				var_10_9.z = 0
				var_10_9.x = 0
				var_10_0.localEulerAngles = var_10_9

				local var_10_10 = GameObjectTools.GetOrAddComponent(var_10_0.gameObject, typeof(DynamicBoneHelper))

				if var_10_10 then
					var_10_10:EnableDynamicBone(true)
				end
			end

			local var_10_11 = 0
			local var_10_12 = 1.175

			if var_10_11 < arg_7_1.time_ and arg_7_1.time_ <= var_10_11 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_13 = arg_7_1:GetWordFromCfg(322072002)
				local var_10_14 = arg_7_1:FormatText(var_10_13.content)

				arg_7_1.text_.text = var_10_14

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_15 = 47
				local var_10_16 = utf8.len(var_10_14)
				local var_10_17 = var_10_15 <= 0 and var_10_12 or var_10_12 * (var_10_16 / var_10_15)

				if var_10_17 > 0 and var_10_12 < var_10_17 then
					arg_7_1.talkMaxDuration = var_10_17

					if var_10_17 + var_10_11 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_17 + var_10_11
					end
				end

				arg_7_1.text_.text = var_10_14
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_18 = math.max(var_10_12, arg_7_1.talkMaxDuration)

			if var_10_11 <= arg_7_1.time_ and arg_7_1.time_ < var_10_11 + var_10_18 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_11) / var_10_18

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_11 + var_10_18 and arg_7_1.time_ < var_10_11 + var_10_18 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10152ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play322072003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 322072003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play322072004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0.233333333333333
			local var_14_1 = 1

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				local var_14_2 = "play"
				local var_14_3 = "effect"

				arg_11_1:AudioAction(var_14_2, var_14_3, "se_story_side_1094", "se_story_1094_run", "")
			end

			local var_14_4 = 1
			local var_14_5 = 1

			if var_14_4 < arg_11_1.time_ and arg_11_1.time_ <= var_14_4 + arg_14_0 then
				local var_14_6 = "play"
				local var_14_7 = "effect"

				arg_11_1:AudioAction(var_14_6, var_14_7, "se_story_10", "se_story_10_monster", "")
			end

			local var_14_8 = manager.ui.mainCamera.transform
			local var_14_9 = 1.03333333333333

			if var_14_9 < arg_11_1.time_ and arg_11_1.time_ <= var_14_9 + arg_14_0 then
				arg_11_1.var_.shakeOldPos = var_14_8.localPosition
			end

			local var_14_10 = 0.966666666665666

			if var_14_9 <= arg_11_1.time_ and arg_11_1.time_ < var_14_9 + var_14_10 then
				local var_14_11 = (arg_11_1.time_ - var_14_9) / 0.066
				local var_14_12, var_14_13 = math.modf(var_14_11)

				var_14_8.localPosition = Vector3.New(var_14_13 * 0.13, var_14_13 * 0.13, var_14_13 * 0.13) + arg_11_1.var_.shakeOldPos
			end

			if arg_11_1.time_ >= var_14_9 + var_14_10 and arg_11_1.time_ < var_14_9 + var_14_10 + arg_14_0 then
				var_14_8.localPosition = arg_11_1.var_.shakeOldPos
			end

			local var_14_14 = 0
			local var_14_15 = 1.725

			if var_14_14 < arg_11_1.time_ and arg_11_1.time_ <= var_14_14 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_16 = arg_11_1:GetWordFromCfg(322072003)
				local var_14_17 = arg_11_1:FormatText(var_14_16.content)

				arg_11_1.text_.text = var_14_17

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_18 = 69
				local var_14_19 = utf8.len(var_14_17)
				local var_14_20 = var_14_18 <= 0 and var_14_15 or var_14_15 * (var_14_19 / var_14_18)

				if var_14_20 > 0 and var_14_15 < var_14_20 then
					arg_11_1.talkMaxDuration = var_14_20

					if var_14_20 + var_14_14 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_20 + var_14_14
					end
				end

				arg_11_1.text_.text = var_14_17
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_21 = math.max(var_14_15, arg_11_1.talkMaxDuration)

			if var_14_14 <= arg_11_1.time_ and arg_11_1.time_ < var_14_14 + var_14_21 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_14) / var_14_21

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_14 + var_14_21 and arg_11_1.time_ < var_14_14 + var_14_21 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play322072004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 322072004
		arg_15_1.duration_ = 2.07

		local var_15_0 = {
			zh = 1.999999999999,
			ja = 2.066
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
				arg_15_0:Play322072005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = "1156ui_story"

			if arg_15_1.actors_[var_18_0] == nil then
				local var_18_1 = Asset.Load("Char/" .. "1156ui_story")

				if not isNil(var_18_1) then
					local var_18_2 = Object.Instantiate(Asset.Load("Char/" .. "1156ui_story"), arg_15_1.stage_.transform)

					var_18_2.name = var_18_0
					var_18_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_15_1.actors_[var_18_0] = var_18_2

					local var_18_3 = var_18_2:GetComponentInChildren(typeof(CharacterEffect))

					var_18_3.enabled = true

					local var_18_4 = GameObjectTools.GetOrAddComponent(var_18_2, typeof(DynamicBoneHelper))

					if var_18_4 then
						var_18_4:EnableDynamicBone(false)
					end

					arg_15_1:ShowWeapon(var_18_3.transform, false)

					arg_15_1.var_[var_18_0 .. "Animator"] = var_18_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_15_1.var_[var_18_0 .. "Animator"].applyRootMotion = true
					arg_15_1.var_[var_18_0 .. "LipSync"] = var_18_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_18_5 = arg_15_1.actors_["1156ui_story"].transform
			local var_18_6 = 0

			if var_18_6 < arg_15_1.time_ and arg_15_1.time_ <= var_18_6 + arg_18_0 then
				arg_15_1.var_.moveOldPos1156ui_story = var_18_5.localPosition
			end

			local var_18_7 = 0.001

			if var_18_6 <= arg_15_1.time_ and arg_15_1.time_ < var_18_6 + var_18_7 then
				local var_18_8 = (arg_15_1.time_ - var_18_6) / var_18_7
				local var_18_9 = Vector3.New(-0.9, -1.1, -6.18)

				var_18_5.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1156ui_story, var_18_9, var_18_8)

				local var_18_10 = manager.ui.mainCamera.transform.position - var_18_5.position

				var_18_5.forward = Vector3.New(var_18_10.x, var_18_10.y, var_18_10.z)

				local var_18_11 = var_18_5.localEulerAngles

				var_18_11.z = 0
				var_18_11.x = 0
				var_18_5.localEulerAngles = var_18_11
			end

			if arg_15_1.time_ >= var_18_6 + var_18_7 and arg_15_1.time_ < var_18_6 + var_18_7 + arg_18_0 then
				var_18_5.localPosition = Vector3.New(-0.9, -1.1, -6.18)

				local var_18_12 = manager.ui.mainCamera.transform.position - var_18_5.position

				var_18_5.forward = Vector3.New(var_18_12.x, var_18_12.y, var_18_12.z)

				local var_18_13 = var_18_5.localEulerAngles

				var_18_13.z = 0
				var_18_13.x = 0
				var_18_5.localEulerAngles = var_18_13
			end

			local var_18_14 = arg_15_1.actors_["1156ui_story"]
			local var_18_15 = 0

			if var_18_15 < arg_15_1.time_ and arg_15_1.time_ <= var_18_15 + arg_18_0 and not isNil(var_18_14) and arg_15_1.var_.characterEffect1156ui_story == nil then
				arg_15_1.var_.characterEffect1156ui_story = var_18_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_16 = 0.200000002980232

			if var_18_15 <= arg_15_1.time_ and arg_15_1.time_ < var_18_15 + var_18_16 and not isNil(var_18_14) then
				local var_18_17 = (arg_15_1.time_ - var_18_15) / var_18_16

				if arg_15_1.var_.characterEffect1156ui_story and not isNil(var_18_14) then
					arg_15_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= var_18_15 + var_18_16 and arg_15_1.time_ < var_18_15 + var_18_16 + arg_18_0 and not isNil(var_18_14) and arg_15_1.var_.characterEffect1156ui_story then
				arg_15_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_18_18 = 0

			if var_18_18 < arg_15_1.time_ and arg_15_1.time_ <= var_18_18 + arg_18_0 then
				arg_15_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_18_19 = 0

			if var_18_19 < arg_15_1.time_ and arg_15_1.time_ <= var_18_19 + arg_18_0 then
				arg_15_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_18_20 = 0
			local var_18_21 = 0.15

			if var_18_20 < arg_15_1.time_ and arg_15_1.time_ <= var_18_20 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				local var_18_22 = arg_15_1:FormatText(StoryNameCfg[605].name)

				arg_15_1.leftNameTxt_.text = var_18_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_23 = arg_15_1:GetWordFromCfg(322072004)
				local var_18_24 = arg_15_1:FormatText(var_18_23.content)

				arg_15_1.text_.text = var_18_24

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_25 = 6
				local var_18_26 = utf8.len(var_18_24)
				local var_18_27 = var_18_25 <= 0 and var_18_21 or var_18_21 * (var_18_26 / var_18_25)

				if var_18_27 > 0 and var_18_21 < var_18_27 then
					arg_15_1.talkMaxDuration = var_18_27

					if var_18_27 + var_18_20 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_27 + var_18_20
					end
				end

				arg_15_1.text_.text = var_18_24
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072004", "story_v_out_322072.awb") ~= 0 then
					local var_18_28 = manager.audio:GetVoiceLength("story_v_out_322072", "322072004", "story_v_out_322072.awb") / 1000

					if var_18_28 + var_18_20 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_28 + var_18_20
					end

					if var_18_23.prefab_name ~= "" and arg_15_1.actors_[var_18_23.prefab_name] ~= nil then
						local var_18_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_23.prefab_name].transform, "story_v_out_322072", "322072004", "story_v_out_322072.awb")

						arg_15_1:RecordAudio("322072004", var_18_29)
						arg_15_1:RecordAudio("322072004", var_18_29)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_322072", "322072004", "story_v_out_322072.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_322072", "322072004", "story_v_out_322072.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_30 = math.max(var_18_21, arg_15_1.talkMaxDuration)

			if var_18_20 <= arg_15_1.time_ and arg_15_1.time_ < var_18_20 + var_18_30 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_20) / var_18_30

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_20 + var_18_30 and arg_15_1.time_ < var_18_20 + var_18_30 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
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

		arg_15_1:InitPlayNodeList()
	end,
	Play322072005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 322072005
		arg_19_1.duration_ = 6.37

		local var_19_0 = {
			zh = 6.366,
			ja = 3.766
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
				arg_19_0:Play322072006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = "404001ui_story"

			if arg_19_1.actors_[var_22_0] == nil then
				local var_22_1 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_22_1) then
					local var_22_2 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_19_1.stage_.transform)

					var_22_2.name = var_22_0
					var_22_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_19_1.actors_[var_22_0] = var_22_2

					local var_22_3 = var_22_2:GetComponentInChildren(typeof(CharacterEffect))

					var_22_3.enabled = true

					local var_22_4 = GameObjectTools.GetOrAddComponent(var_22_2, typeof(DynamicBoneHelper))

					if var_22_4 then
						var_22_4:EnableDynamicBone(false)
					end

					arg_19_1:ShowWeapon(var_22_3.transform, false)

					arg_19_1.var_[var_22_0 .. "Animator"] = var_22_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_19_1.var_[var_22_0 .. "Animator"].applyRootMotion = true
					arg_19_1.var_[var_22_0 .. "LipSync"] = var_22_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_22_5 = arg_19_1.actors_["404001ui_story"].transform
			local var_22_6 = 0

			if var_22_6 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 then
				arg_19_1.var_.moveOldPos404001ui_story = var_22_5.localPosition
			end

			local var_22_7 = 0.001

			if var_22_6 <= arg_19_1.time_ and arg_19_1.time_ < var_22_6 + var_22_7 then
				local var_22_8 = (arg_19_1.time_ - var_22_6) / var_22_7
				local var_22_9 = Vector3.New(0.8, -1.55, -5.5)

				var_22_5.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos404001ui_story, var_22_9, var_22_8)

				local var_22_10 = manager.ui.mainCamera.transform.position - var_22_5.position

				var_22_5.forward = Vector3.New(var_22_10.x, var_22_10.y, var_22_10.z)

				local var_22_11 = var_22_5.localEulerAngles

				var_22_11.z = 0
				var_22_11.x = 0
				var_22_5.localEulerAngles = var_22_11
			end

			if arg_19_1.time_ >= var_22_6 + var_22_7 and arg_19_1.time_ < var_22_6 + var_22_7 + arg_22_0 then
				var_22_5.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_22_12 = manager.ui.mainCamera.transform.position - var_22_5.position

				var_22_5.forward = Vector3.New(var_22_12.x, var_22_12.y, var_22_12.z)

				local var_22_13 = var_22_5.localEulerAngles

				var_22_13.z = 0
				var_22_13.x = 0
				var_22_5.localEulerAngles = var_22_13
			end

			local var_22_14 = arg_19_1.actors_["404001ui_story"]
			local var_22_15 = 0

			if var_22_15 < arg_19_1.time_ and arg_19_1.time_ <= var_22_15 + arg_22_0 and not isNil(var_22_14) and arg_19_1.var_.characterEffect404001ui_story == nil then
				arg_19_1.var_.characterEffect404001ui_story = var_22_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_16 = 0.200000002980232

			if var_22_15 <= arg_19_1.time_ and arg_19_1.time_ < var_22_15 + var_22_16 and not isNil(var_22_14) then
				local var_22_17 = (arg_19_1.time_ - var_22_15) / var_22_16

				if arg_19_1.var_.characterEffect404001ui_story and not isNil(var_22_14) then
					arg_19_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= var_22_15 + var_22_16 and arg_19_1.time_ < var_22_15 + var_22_16 + arg_22_0 and not isNil(var_22_14) and arg_19_1.var_.characterEffect404001ui_story then
				arg_19_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_22_18 = arg_19_1.actors_["1156ui_story"]
			local var_22_19 = 0

			if var_22_19 < arg_19_1.time_ and arg_19_1.time_ <= var_22_19 + arg_22_0 and not isNil(var_22_18) and arg_19_1.var_.characterEffect1156ui_story == nil then
				arg_19_1.var_.characterEffect1156ui_story = var_22_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_20 = 0.200000002980232

			if var_22_19 <= arg_19_1.time_ and arg_19_1.time_ < var_22_19 + var_22_20 and not isNil(var_22_18) then
				local var_22_21 = (arg_19_1.time_ - var_22_19) / var_22_20

				if arg_19_1.var_.characterEffect1156ui_story and not isNil(var_22_18) then
					local var_22_22 = Mathf.Lerp(0, 0.5, var_22_21)

					arg_19_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_19_1.var_.characterEffect1156ui_story.fillRatio = var_22_22
				end
			end

			if arg_19_1.time_ >= var_22_19 + var_22_20 and arg_19_1.time_ < var_22_19 + var_22_20 + arg_22_0 and not isNil(var_22_18) and arg_19_1.var_.characterEffect1156ui_story then
				local var_22_23 = 0.5

				arg_19_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_19_1.var_.characterEffect1156ui_story.fillRatio = var_22_23
			end

			local var_22_24 = 0

			if var_22_24 < arg_19_1.time_ and arg_19_1.time_ <= var_22_24 + arg_22_0 then
				arg_19_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			local var_22_25 = 0

			if var_22_25 < arg_19_1.time_ and arg_19_1.time_ <= var_22_25 + arg_22_0 then
				arg_19_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_22_26 = 0
			local var_22_27 = 0.475

			if var_22_26 < arg_19_1.time_ and arg_19_1.time_ <= var_22_26 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				local var_22_28 = arg_19_1:FormatText(StoryNameCfg[668].name)

				arg_19_1.leftNameTxt_.text = var_22_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_29 = arg_19_1:GetWordFromCfg(322072005)
				local var_22_30 = arg_19_1:FormatText(var_22_29.content)

				arg_19_1.text_.text = var_22_30

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_31 = 19
				local var_22_32 = utf8.len(var_22_30)
				local var_22_33 = var_22_31 <= 0 and var_22_27 or var_22_27 * (var_22_32 / var_22_31)

				if var_22_33 > 0 and var_22_27 < var_22_33 then
					arg_19_1.talkMaxDuration = var_22_33

					if var_22_33 + var_22_26 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_33 + var_22_26
					end
				end

				arg_19_1.text_.text = var_22_30
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072005", "story_v_out_322072.awb") ~= 0 then
					local var_22_34 = manager.audio:GetVoiceLength("story_v_out_322072", "322072005", "story_v_out_322072.awb") / 1000

					if var_22_34 + var_22_26 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_34 + var_22_26
					end

					if var_22_29.prefab_name ~= "" and arg_19_1.actors_[var_22_29.prefab_name] ~= nil then
						local var_22_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_29.prefab_name].transform, "story_v_out_322072", "322072005", "story_v_out_322072.awb")

						arg_19_1:RecordAudio("322072005", var_22_35)
						arg_19_1:RecordAudio("322072005", var_22_35)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_322072", "322072005", "story_v_out_322072.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_322072", "322072005", "story_v_out_322072.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_36 = math.max(var_22_27, arg_19_1.talkMaxDuration)

			if var_22_26 <= arg_19_1.time_ and arg_19_1.time_ < var_22_26 + var_22_36 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_26) / var_22_36

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_26 + var_22_36 and arg_19_1.time_ < var_22_26 + var_22_36 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
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

		arg_19_1:InitPlayNodeList()
	end,
	Play322072006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 322072006
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play322072007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = arg_23_1.actors_["404001ui_story"].transform
			local var_26_1 = 0

			if var_26_1 < arg_23_1.time_ and arg_23_1.time_ <= var_26_1 + arg_26_0 then
				arg_23_1.var_.moveOldPos404001ui_story = var_26_0.localPosition
			end

			local var_26_2 = 0.001

			if var_26_1 <= arg_23_1.time_ and arg_23_1.time_ < var_26_1 + var_26_2 then
				local var_26_3 = (arg_23_1.time_ - var_26_1) / var_26_2
				local var_26_4 = Vector3.New(0, 100, 0)

				var_26_0.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos404001ui_story, var_26_4, var_26_3)

				local var_26_5 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_5.x, var_26_5.y, var_26_5.z)

				local var_26_6 = var_26_0.localEulerAngles

				var_26_6.z = 0
				var_26_6.x = 0
				var_26_0.localEulerAngles = var_26_6
			end

			if arg_23_1.time_ >= var_26_1 + var_26_2 and arg_23_1.time_ < var_26_1 + var_26_2 + arg_26_0 then
				var_26_0.localPosition = Vector3.New(0, 100, 0)

				local var_26_7 = manager.ui.mainCamera.transform.position - var_26_0.position

				var_26_0.forward = Vector3.New(var_26_7.x, var_26_7.y, var_26_7.z)

				local var_26_8 = var_26_0.localEulerAngles

				var_26_8.z = 0
				var_26_8.x = 0
				var_26_0.localEulerAngles = var_26_8
			end

			local var_26_9 = arg_23_1.actors_["1156ui_story"].transform
			local var_26_10 = 0

			if var_26_10 < arg_23_1.time_ and arg_23_1.time_ <= var_26_10 + arg_26_0 then
				arg_23_1.var_.moveOldPos1156ui_story = var_26_9.localPosition
			end

			local var_26_11 = 0.001

			if var_26_10 <= arg_23_1.time_ and arg_23_1.time_ < var_26_10 + var_26_11 then
				local var_26_12 = (arg_23_1.time_ - var_26_10) / var_26_11
				local var_26_13 = Vector3.New(0, 100, 0)

				var_26_9.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1156ui_story, var_26_13, var_26_12)

				local var_26_14 = manager.ui.mainCamera.transform.position - var_26_9.position

				var_26_9.forward = Vector3.New(var_26_14.x, var_26_14.y, var_26_14.z)

				local var_26_15 = var_26_9.localEulerAngles

				var_26_15.z = 0
				var_26_15.x = 0
				var_26_9.localEulerAngles = var_26_15
			end

			if arg_23_1.time_ >= var_26_10 + var_26_11 and arg_23_1.time_ < var_26_10 + var_26_11 + arg_26_0 then
				var_26_9.localPosition = Vector3.New(0, 100, 0)

				local var_26_16 = manager.ui.mainCamera.transform.position - var_26_9.position

				var_26_9.forward = Vector3.New(var_26_16.x, var_26_16.y, var_26_16.z)

				local var_26_17 = var_26_9.localEulerAngles

				var_26_17.z = 0
				var_26_17.x = 0
				var_26_9.localEulerAngles = var_26_17
			end

			local var_26_18 = arg_23_1.actors_["404001ui_story"]
			local var_26_19 = 0

			if var_26_19 < arg_23_1.time_ and arg_23_1.time_ <= var_26_19 + arg_26_0 and not isNil(var_26_18) and arg_23_1.var_.characterEffect404001ui_story == nil then
				arg_23_1.var_.characterEffect404001ui_story = var_26_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_20 = 0.200000002980232

			if var_26_19 <= arg_23_1.time_ and arg_23_1.time_ < var_26_19 + var_26_20 and not isNil(var_26_18) then
				local var_26_21 = (arg_23_1.time_ - var_26_19) / var_26_20

				if arg_23_1.var_.characterEffect404001ui_story and not isNil(var_26_18) then
					local var_26_22 = Mathf.Lerp(0, 0.5, var_26_21)

					arg_23_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_23_1.var_.characterEffect404001ui_story.fillRatio = var_26_22
				end
			end

			if arg_23_1.time_ >= var_26_19 + var_26_20 and arg_23_1.time_ < var_26_19 + var_26_20 + arg_26_0 and not isNil(var_26_18) and arg_23_1.var_.characterEffect404001ui_story then
				local var_26_23 = 0.5

				arg_23_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_23_1.var_.characterEffect404001ui_story.fillRatio = var_26_23
			end

			local var_26_24 = 0.466666666666667
			local var_26_25 = 1

			if var_26_24 < arg_23_1.time_ and arg_23_1.time_ <= var_26_24 + arg_26_0 then
				local var_26_26 = "play"
				local var_26_27 = "effect"

				arg_23_1:AudioAction(var_26_26, var_26_27, "se_story_145", "se_story_145_fire01", "")
			end

			local var_26_28 = 0
			local var_26_29 = 1.2

			if var_26_28 < arg_23_1.time_ and arg_23_1.time_ <= var_26_28 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_30 = arg_23_1:GetWordFromCfg(322072006)
				local var_26_31 = arg_23_1:FormatText(var_26_30.content)

				arg_23_1.text_.text = var_26_31

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_32 = 48
				local var_26_33 = utf8.len(var_26_31)
				local var_26_34 = var_26_32 <= 0 and var_26_29 or var_26_29 * (var_26_33 / var_26_32)

				if var_26_34 > 0 and var_26_29 < var_26_34 then
					arg_23_1.talkMaxDuration = var_26_34

					if var_26_34 + var_26_28 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_34 + var_26_28
					end
				end

				arg_23_1.text_.text = var_26_31
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_35 = math.max(var_26_29, arg_23_1.talkMaxDuration)

			if var_26_28 <= arg_23_1.time_ and arg_23_1.time_ < var_26_28 + var_26_35 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_28) / var_26_35

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_28 + var_26_35 and arg_23_1.time_ < var_26_28 + var_26_35 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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
				actorName = "1156ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play322072007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 322072007
		arg_27_1.duration_ = 3.47

		local var_27_0 = {
			zh = 2.866,
			ja = 3.466
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play322072008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = "1284ui_story"

			if arg_27_1.actors_[var_30_0] == nil then
				local var_30_1 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_30_1) then
					local var_30_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_27_1.stage_.transform)

					var_30_2.name = var_30_0
					var_30_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_27_1.actors_[var_30_0] = var_30_2

					local var_30_3 = var_30_2:GetComponentInChildren(typeof(CharacterEffect))

					var_30_3.enabled = true

					local var_30_4 = GameObjectTools.GetOrAddComponent(var_30_2, typeof(DynamicBoneHelper))

					if var_30_4 then
						var_30_4:EnableDynamicBone(false)
					end

					arg_27_1:ShowWeapon(var_30_3.transform, false)

					arg_27_1.var_[var_30_0 .. "Animator"] = var_30_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_27_1.var_[var_30_0 .. "Animator"].applyRootMotion = true
					arg_27_1.var_[var_30_0 .. "LipSync"] = var_30_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_30_5 = arg_27_1.actors_["1284ui_story"].transform
			local var_30_6 = 0

			if var_30_6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_6 + arg_30_0 then
				arg_27_1.var_.moveOldPos1284ui_story = var_30_5.localPosition
			end

			local var_30_7 = 0.001

			if var_30_6 <= arg_27_1.time_ and arg_27_1.time_ < var_30_6 + var_30_7 then
				local var_30_8 = (arg_27_1.time_ - var_30_6) / var_30_7
				local var_30_9 = Vector3.New(-0.7, -0.985, -6.22)

				var_30_5.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1284ui_story, var_30_9, var_30_8)

				local var_30_10 = manager.ui.mainCamera.transform.position - var_30_5.position

				var_30_5.forward = Vector3.New(var_30_10.x, var_30_10.y, var_30_10.z)

				local var_30_11 = var_30_5.localEulerAngles

				var_30_11.z = 0
				var_30_11.x = 0
				var_30_5.localEulerAngles = var_30_11
			end

			if arg_27_1.time_ >= var_30_6 + var_30_7 and arg_27_1.time_ < var_30_6 + var_30_7 + arg_30_0 then
				var_30_5.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_30_12 = manager.ui.mainCamera.transform.position - var_30_5.position

				var_30_5.forward = Vector3.New(var_30_12.x, var_30_12.y, var_30_12.z)

				local var_30_13 = var_30_5.localEulerAngles

				var_30_13.z = 0
				var_30_13.x = 0
				var_30_5.localEulerAngles = var_30_13
			end

			local var_30_14 = arg_27_1.actors_["1284ui_story"]
			local var_30_15 = 0

			if var_30_15 < arg_27_1.time_ and arg_27_1.time_ <= var_30_15 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.characterEffect1284ui_story == nil then
				arg_27_1.var_.characterEffect1284ui_story = var_30_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_16 = 0.200000002980232

			if var_30_15 <= arg_27_1.time_ and arg_27_1.time_ < var_30_15 + var_30_16 and not isNil(var_30_14) then
				local var_30_17 = (arg_27_1.time_ - var_30_15) / var_30_16

				if arg_27_1.var_.characterEffect1284ui_story and not isNil(var_30_14) then
					arg_27_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= var_30_15 + var_30_16 and arg_27_1.time_ < var_30_15 + var_30_16 + arg_30_0 and not isNil(var_30_14) and arg_27_1.var_.characterEffect1284ui_story then
				arg_27_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_30_18 = 0

			if var_30_18 < arg_27_1.time_ and arg_27_1.time_ <= var_30_18 + arg_30_0 then
				arg_27_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_30_19 = 0

			if var_30_19 < arg_27_1.time_ and arg_27_1.time_ <= var_30_19 + arg_30_0 then
				arg_27_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_30_20 = 0
			local var_30_21 = 0.4

			if var_30_20 < arg_27_1.time_ and arg_27_1.time_ <= var_30_20 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				local var_30_22 = arg_27_1:FormatText(StoryNameCfg[6].name)

				arg_27_1.leftNameTxt_.text = var_30_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_23 = arg_27_1:GetWordFromCfg(322072007)
				local var_30_24 = arg_27_1:FormatText(var_30_23.content)

				arg_27_1.text_.text = var_30_24

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_25 = 16
				local var_30_26 = utf8.len(var_30_24)
				local var_30_27 = var_30_25 <= 0 and var_30_21 or var_30_21 * (var_30_26 / var_30_25)

				if var_30_27 > 0 and var_30_21 < var_30_27 then
					arg_27_1.talkMaxDuration = var_30_27

					if var_30_27 + var_30_20 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_27 + var_30_20
					end
				end

				arg_27_1.text_.text = var_30_24
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072007", "story_v_out_322072.awb") ~= 0 then
					local var_30_28 = manager.audio:GetVoiceLength("story_v_out_322072", "322072007", "story_v_out_322072.awb") / 1000

					if var_30_28 + var_30_20 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_28 + var_30_20
					end

					if var_30_23.prefab_name ~= "" and arg_27_1.actors_[var_30_23.prefab_name] ~= nil then
						local var_30_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_23.prefab_name].transform, "story_v_out_322072", "322072007", "story_v_out_322072.awb")

						arg_27_1:RecordAudio("322072007", var_30_29)
						arg_27_1:RecordAudio("322072007", var_30_29)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_322072", "322072007", "story_v_out_322072.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_322072", "322072007", "story_v_out_322072.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_30 = math.max(var_30_21, arg_27_1.talkMaxDuration)

			if var_30_20 <= arg_27_1.time_ and arg_27_1.time_ < var_30_20 + var_30_30 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_20) / var_30_30

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_20 + var_30_30 and arg_27_1.time_ < var_30_20 + var_30_30 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play322072008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 322072008
		arg_31_1.duration_ = 3.97

		local var_31_0 = {
			zh = 3.333,
			ja = 3.966
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
				arg_31_0:Play322072009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = arg_31_1.actors_["404001ui_story"].transform
			local var_34_1 = 0

			if var_34_1 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.var_.moveOldPos404001ui_story = var_34_0.localPosition
			end

			local var_34_2 = 0.001

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_2 then
				local var_34_3 = (arg_31_1.time_ - var_34_1) / var_34_2
				local var_34_4 = Vector3.New(0.8, -1.55, -5.5)

				var_34_0.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos404001ui_story, var_34_4, var_34_3)

				local var_34_5 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_5.x, var_34_5.y, var_34_5.z)

				local var_34_6 = var_34_0.localEulerAngles

				var_34_6.z = 0
				var_34_6.x = 0
				var_34_0.localEulerAngles = var_34_6
			end

			if arg_31_1.time_ >= var_34_1 + var_34_2 and arg_31_1.time_ < var_34_1 + var_34_2 + arg_34_0 then
				var_34_0.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_34_7 = manager.ui.mainCamera.transform.position - var_34_0.position

				var_34_0.forward = Vector3.New(var_34_7.x, var_34_7.y, var_34_7.z)

				local var_34_8 = var_34_0.localEulerAngles

				var_34_8.z = 0
				var_34_8.x = 0
				var_34_0.localEulerAngles = var_34_8
			end

			local var_34_9 = arg_31_1.actors_["404001ui_story"]
			local var_34_10 = 0

			if var_34_10 < arg_31_1.time_ and arg_31_1.time_ <= var_34_10 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect404001ui_story == nil then
				arg_31_1.var_.characterEffect404001ui_story = var_34_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_11 = 0.200000002980232

			if var_34_10 <= arg_31_1.time_ and arg_31_1.time_ < var_34_10 + var_34_11 and not isNil(var_34_9) then
				local var_34_12 = (arg_31_1.time_ - var_34_10) / var_34_11

				if arg_31_1.var_.characterEffect404001ui_story and not isNil(var_34_9) then
					arg_31_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= var_34_10 + var_34_11 and arg_31_1.time_ < var_34_10 + var_34_11 + arg_34_0 and not isNil(var_34_9) and arg_31_1.var_.characterEffect404001ui_story then
				arg_31_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_34_13 = arg_31_1.actors_["1284ui_story"]
			local var_34_14 = 0

			if var_34_14 < arg_31_1.time_ and arg_31_1.time_ <= var_34_14 + arg_34_0 and not isNil(var_34_13) and arg_31_1.var_.characterEffect1284ui_story == nil then
				arg_31_1.var_.characterEffect1284ui_story = var_34_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_15 = 0.200000002980232

			if var_34_14 <= arg_31_1.time_ and arg_31_1.time_ < var_34_14 + var_34_15 and not isNil(var_34_13) then
				local var_34_16 = (arg_31_1.time_ - var_34_14) / var_34_15

				if arg_31_1.var_.characterEffect1284ui_story and not isNil(var_34_13) then
					local var_34_17 = Mathf.Lerp(0, 0.5, var_34_16)

					arg_31_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1284ui_story.fillRatio = var_34_17
				end
			end

			if arg_31_1.time_ >= var_34_14 + var_34_15 and arg_31_1.time_ < var_34_14 + var_34_15 + arg_34_0 and not isNil(var_34_13) and arg_31_1.var_.characterEffect1284ui_story then
				local var_34_18 = 0.5

				arg_31_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1284ui_story.fillRatio = var_34_18
			end

			local var_34_19 = 0

			if var_34_19 < arg_31_1.time_ and arg_31_1.time_ <= var_34_19 + arg_34_0 then
				arg_31_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action5_1")
			end

			local var_34_20 = 0

			if var_34_20 < arg_31_1.time_ and arg_31_1.time_ <= var_34_20 + arg_34_0 then
				arg_31_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_34_21 = 0
			local var_34_22 = 0.4

			if var_34_21 < arg_31_1.time_ and arg_31_1.time_ <= var_34_21 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				local var_34_23 = arg_31_1:FormatText(StoryNameCfg[668].name)

				arg_31_1.leftNameTxt_.text = var_34_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_24 = arg_31_1:GetWordFromCfg(322072008)
				local var_34_25 = arg_31_1:FormatText(var_34_24.content)

				arg_31_1.text_.text = var_34_25

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_26 = 16
				local var_34_27 = utf8.len(var_34_25)
				local var_34_28 = var_34_26 <= 0 and var_34_22 or var_34_22 * (var_34_27 / var_34_26)

				if var_34_28 > 0 and var_34_22 < var_34_28 then
					arg_31_1.talkMaxDuration = var_34_28

					if var_34_28 + var_34_21 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_28 + var_34_21
					end
				end

				arg_31_1.text_.text = var_34_25
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072008", "story_v_out_322072.awb") ~= 0 then
					local var_34_29 = manager.audio:GetVoiceLength("story_v_out_322072", "322072008", "story_v_out_322072.awb") / 1000

					if var_34_29 + var_34_21 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_29 + var_34_21
					end

					if var_34_24.prefab_name ~= "" and arg_31_1.actors_[var_34_24.prefab_name] ~= nil then
						local var_34_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_24.prefab_name].transform, "story_v_out_322072", "322072008", "story_v_out_322072.awb")

						arg_31_1:RecordAudio("322072008", var_34_30)
						arg_31_1:RecordAudio("322072008", var_34_30)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_322072", "322072008", "story_v_out_322072.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_322072", "322072008", "story_v_out_322072.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_31 = math.max(var_34_22, arg_31_1.talkMaxDuration)

			if var_34_21 <= arg_31_1.time_ and arg_31_1.time_ < var_34_21 + var_34_31 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_21) / var_34_31

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_21 + var_34_31 and arg_31_1.time_ < var_34_21 + var_34_31 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play322072009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 322072009
		arg_35_1.duration_ = 2

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play322072010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = arg_35_1.actors_["1156ui_story"].transform
			local var_38_1 = 0

			if var_38_1 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.var_.moveOldPos1156ui_story = var_38_0.localPosition
			end

			local var_38_2 = 0.001

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_2 then
				local var_38_3 = (arg_35_1.time_ - var_38_1) / var_38_2
				local var_38_4 = Vector3.New(0, -1.1, -6.18)

				var_38_0.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1156ui_story, var_38_4, var_38_3)

				local var_38_5 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_5.x, var_38_5.y, var_38_5.z)

				local var_38_6 = var_38_0.localEulerAngles

				var_38_6.z = 0
				var_38_6.x = 0
				var_38_0.localEulerAngles = var_38_6
			end

			if arg_35_1.time_ >= var_38_1 + var_38_2 and arg_35_1.time_ < var_38_1 + var_38_2 + arg_38_0 then
				var_38_0.localPosition = Vector3.New(0, -1.1, -6.18)

				local var_38_7 = manager.ui.mainCamera.transform.position - var_38_0.position

				var_38_0.forward = Vector3.New(var_38_7.x, var_38_7.y, var_38_7.z)

				local var_38_8 = var_38_0.localEulerAngles

				var_38_8.z = 0
				var_38_8.x = 0
				var_38_0.localEulerAngles = var_38_8
			end

			local var_38_9 = arg_35_1.actors_["404001ui_story"].transform
			local var_38_10 = 0

			if var_38_10 < arg_35_1.time_ and arg_35_1.time_ <= var_38_10 + arg_38_0 then
				arg_35_1.var_.moveOldPos404001ui_story = var_38_9.localPosition
			end

			local var_38_11 = 0.001

			if var_38_10 <= arg_35_1.time_ and arg_35_1.time_ < var_38_10 + var_38_11 then
				local var_38_12 = (arg_35_1.time_ - var_38_10) / var_38_11
				local var_38_13 = Vector3.New(0, 100, 0)

				var_38_9.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos404001ui_story, var_38_13, var_38_12)

				local var_38_14 = manager.ui.mainCamera.transform.position - var_38_9.position

				var_38_9.forward = Vector3.New(var_38_14.x, var_38_14.y, var_38_14.z)

				local var_38_15 = var_38_9.localEulerAngles

				var_38_15.z = 0
				var_38_15.x = 0
				var_38_9.localEulerAngles = var_38_15
			end

			if arg_35_1.time_ >= var_38_10 + var_38_11 and arg_35_1.time_ < var_38_10 + var_38_11 + arg_38_0 then
				var_38_9.localPosition = Vector3.New(0, 100, 0)

				local var_38_16 = manager.ui.mainCamera.transform.position - var_38_9.position

				var_38_9.forward = Vector3.New(var_38_16.x, var_38_16.y, var_38_16.z)

				local var_38_17 = var_38_9.localEulerAngles

				var_38_17.z = 0
				var_38_17.x = 0
				var_38_9.localEulerAngles = var_38_17
			end

			local var_38_18 = arg_35_1.actors_["1284ui_story"].transform
			local var_38_19 = 0

			if var_38_19 < arg_35_1.time_ and arg_35_1.time_ <= var_38_19 + arg_38_0 then
				arg_35_1.var_.moveOldPos1284ui_story = var_38_18.localPosition
			end

			local var_38_20 = 0.001

			if var_38_19 <= arg_35_1.time_ and arg_35_1.time_ < var_38_19 + var_38_20 then
				local var_38_21 = (arg_35_1.time_ - var_38_19) / var_38_20
				local var_38_22 = Vector3.New(0, 100, 0)

				var_38_18.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1284ui_story, var_38_22, var_38_21)

				local var_38_23 = manager.ui.mainCamera.transform.position - var_38_18.position

				var_38_18.forward = Vector3.New(var_38_23.x, var_38_23.y, var_38_23.z)

				local var_38_24 = var_38_18.localEulerAngles

				var_38_24.z = 0
				var_38_24.x = 0
				var_38_18.localEulerAngles = var_38_24
			end

			if arg_35_1.time_ >= var_38_19 + var_38_20 and arg_35_1.time_ < var_38_19 + var_38_20 + arg_38_0 then
				var_38_18.localPosition = Vector3.New(0, 100, 0)

				local var_38_25 = manager.ui.mainCamera.transform.position - var_38_18.position

				var_38_18.forward = Vector3.New(var_38_25.x, var_38_25.y, var_38_25.z)

				local var_38_26 = var_38_18.localEulerAngles

				var_38_26.z = 0
				var_38_26.x = 0
				var_38_18.localEulerAngles = var_38_26
			end

			local var_38_27 = arg_35_1.actors_["1156ui_story"]
			local var_38_28 = 0

			if var_38_28 < arg_35_1.time_ and arg_35_1.time_ <= var_38_28 + arg_38_0 and not isNil(var_38_27) and arg_35_1.var_.characterEffect1156ui_story == nil then
				arg_35_1.var_.characterEffect1156ui_story = var_38_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_29 = 0.200000002980232

			if var_38_28 <= arg_35_1.time_ and arg_35_1.time_ < var_38_28 + var_38_29 and not isNil(var_38_27) then
				local var_38_30 = (arg_35_1.time_ - var_38_28) / var_38_29

				if arg_35_1.var_.characterEffect1156ui_story and not isNil(var_38_27) then
					arg_35_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= var_38_28 + var_38_29 and arg_35_1.time_ < var_38_28 + var_38_29 + arg_38_0 and not isNil(var_38_27) and arg_35_1.var_.characterEffect1156ui_story then
				arg_35_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_38_31 = arg_35_1.actors_["404001ui_story"]
			local var_38_32 = 0

			if var_38_32 < arg_35_1.time_ and arg_35_1.time_ <= var_38_32 + arg_38_0 and not isNil(var_38_31) and arg_35_1.var_.characterEffect404001ui_story == nil then
				arg_35_1.var_.characterEffect404001ui_story = var_38_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_33 = 0.200000002980232

			if var_38_32 <= arg_35_1.time_ and arg_35_1.time_ < var_38_32 + var_38_33 and not isNil(var_38_31) then
				local var_38_34 = (arg_35_1.time_ - var_38_32) / var_38_33

				if arg_35_1.var_.characterEffect404001ui_story and not isNil(var_38_31) then
					local var_38_35 = Mathf.Lerp(0, 0.5, var_38_34)

					arg_35_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_35_1.var_.characterEffect404001ui_story.fillRatio = var_38_35
				end
			end

			if arg_35_1.time_ >= var_38_32 + var_38_33 and arg_35_1.time_ < var_38_32 + var_38_33 + arg_38_0 and not isNil(var_38_31) and arg_35_1.var_.characterEffect404001ui_story then
				local var_38_36 = 0.5

				arg_35_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_35_1.var_.characterEffect404001ui_story.fillRatio = var_38_36
			end

			local var_38_37 = 0

			if var_38_37 < arg_35_1.time_ and arg_35_1.time_ <= var_38_37 + arg_38_0 then
				arg_35_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action6_1")
			end

			local var_38_38 = 0

			if var_38_38 < arg_35_1.time_ and arg_35_1.time_ <= var_38_38 + arg_38_0 then
				arg_35_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_38_39 = 0
			local var_38_40 = 0.15

			if var_38_39 < arg_35_1.time_ and arg_35_1.time_ <= var_38_39 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				local var_38_41 = arg_35_1:FormatText(StoryNameCfg[605].name)

				arg_35_1.leftNameTxt_.text = var_38_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_42 = arg_35_1:GetWordFromCfg(322072009)
				local var_38_43 = arg_35_1:FormatText(var_38_42.content)

				arg_35_1.text_.text = var_38_43

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_44 = 6
				local var_38_45 = utf8.len(var_38_43)
				local var_38_46 = var_38_44 <= 0 and var_38_40 or var_38_40 * (var_38_45 / var_38_44)

				if var_38_46 > 0 and var_38_40 < var_38_46 then
					arg_35_1.talkMaxDuration = var_38_46

					if var_38_46 + var_38_39 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_46 + var_38_39
					end
				end

				arg_35_1.text_.text = var_38_43
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072009", "story_v_out_322072.awb") ~= 0 then
					local var_38_47 = manager.audio:GetVoiceLength("story_v_out_322072", "322072009", "story_v_out_322072.awb") / 1000

					if var_38_47 + var_38_39 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_47 + var_38_39
					end

					if var_38_42.prefab_name ~= "" and arg_35_1.actors_[var_38_42.prefab_name] ~= nil then
						local var_38_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_42.prefab_name].transform, "story_v_out_322072", "322072009", "story_v_out_322072.awb")

						arg_35_1:RecordAudio("322072009", var_38_48)
						arg_35_1:RecordAudio("322072009", var_38_48)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_322072", "322072009", "story_v_out_322072.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_322072", "322072009", "story_v_out_322072.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_49 = math.max(var_38_40, arg_35_1.talkMaxDuration)

			if var_38_39 <= arg_35_1.time_ and arg_35_1.time_ < var_38_39 + var_38_49 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_39) / var_38_49

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_39 + var_38_49 and arg_35_1.time_ < var_38_39 + var_38_49 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1156ui_story",
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

		arg_35_1:InitPlayNodeList()
	end,
	Play322072010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 322072010
		arg_39_1.duration_ = 9

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play322072011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = "L19f"

			if arg_39_1.bgs_[var_42_0] == nil then
				local var_42_1 = Object.Instantiate(arg_39_1.paintGo_)

				var_42_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_42_0)
				var_42_1.name = var_42_0
				var_42_1.transform.parent = arg_39_1.stage_.transform
				var_42_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_39_1.bgs_[var_42_0] = var_42_1
			end

			local var_42_2 = 2

			if var_42_2 < arg_39_1.time_ and arg_39_1.time_ <= var_42_2 + arg_42_0 then
				local var_42_3 = manager.ui.mainCamera.transform.localPosition
				local var_42_4 = Vector3.New(0, 0, 10) + Vector3.New(var_42_3.x, var_42_3.y, 0)
				local var_42_5 = arg_39_1.bgs_.L19f

				var_42_5.transform.localPosition = var_42_4
				var_42_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_42_6 = var_42_5:GetComponent("SpriteRenderer")

				if var_42_6 and var_42_6.sprite then
					local var_42_7 = (var_42_5.transform.localPosition - var_42_3).z
					local var_42_8 = manager.ui.mainCameraCom_
					local var_42_9 = 2 * var_42_7 * Mathf.Tan(var_42_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_42_10 = var_42_9 * var_42_8.aspect
					local var_42_11 = var_42_6.sprite.bounds.size.x
					local var_42_12 = var_42_6.sprite.bounds.size.y
					local var_42_13 = var_42_10 / var_42_11
					local var_42_14 = var_42_9 / var_42_12
					local var_42_15 = var_42_14 < var_42_13 and var_42_13 or var_42_14

					var_42_5.transform.localScale = Vector3.New(var_42_15, var_42_15, 0)
				end

				for iter_42_0, iter_42_1 in pairs(arg_39_1.bgs_) do
					if iter_42_0 ~= "L19f" then
						iter_42_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_42_16 = 4

			if var_42_16 < arg_39_1.time_ and arg_39_1.time_ <= var_42_16 + arg_42_0 then
				arg_39_1.allBtn_.enabled = false
			end

			local var_42_17 = 0.3

			if arg_39_1.time_ >= var_42_16 + var_42_17 and arg_39_1.time_ < var_42_16 + var_42_17 + arg_42_0 then
				arg_39_1.allBtn_.enabled = true
			end

			local var_42_18 = 0

			if var_42_18 < arg_39_1.time_ and arg_39_1.time_ <= var_42_18 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_19 = 2

			if var_42_18 <= arg_39_1.time_ and arg_39_1.time_ < var_42_18 + var_42_19 then
				local var_42_20 = (arg_39_1.time_ - var_42_18) / var_42_19
				local var_42_21 = Color.New(0, 0, 0)

				var_42_21.a = Mathf.Lerp(0, 1, var_42_20)
				arg_39_1.mask_.color = var_42_21
			end

			if arg_39_1.time_ >= var_42_18 + var_42_19 and arg_39_1.time_ < var_42_18 + var_42_19 + arg_42_0 then
				local var_42_22 = Color.New(0, 0, 0)

				var_42_22.a = 1
				arg_39_1.mask_.color = var_42_22
			end

			local var_42_23 = 2

			if var_42_23 < arg_39_1.time_ and arg_39_1.time_ <= var_42_23 + arg_42_0 then
				arg_39_1.mask_.enabled = true
				arg_39_1.mask_.raycastTarget = true

				arg_39_1:SetGaussion(false)
			end

			local var_42_24 = 2

			if var_42_23 <= arg_39_1.time_ and arg_39_1.time_ < var_42_23 + var_42_24 then
				local var_42_25 = (arg_39_1.time_ - var_42_23) / var_42_24
				local var_42_26 = Color.New(0, 0, 0)

				var_42_26.a = Mathf.Lerp(1, 0, var_42_25)
				arg_39_1.mask_.color = var_42_26
			end

			if arg_39_1.time_ >= var_42_23 + var_42_24 and arg_39_1.time_ < var_42_23 + var_42_24 + arg_42_0 then
				local var_42_27 = Color.New(0, 0, 0)
				local var_42_28 = 0

				arg_39_1.mask_.enabled = false
				var_42_27.a = var_42_28
				arg_39_1.mask_.color = var_42_27
			end

			local var_42_29 = arg_39_1.actors_["1156ui_story"].transform
			local var_42_30 = 1.96599999815226

			if var_42_30 < arg_39_1.time_ and arg_39_1.time_ <= var_42_30 + arg_42_0 then
				arg_39_1.var_.moveOldPos1156ui_story = var_42_29.localPosition
			end

			local var_42_31 = 0.001

			if var_42_30 <= arg_39_1.time_ and arg_39_1.time_ < var_42_30 + var_42_31 then
				local var_42_32 = (arg_39_1.time_ - var_42_30) / var_42_31
				local var_42_33 = Vector3.New(0, 100, 0)

				var_42_29.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1156ui_story, var_42_33, var_42_32)

				local var_42_34 = manager.ui.mainCamera.transform.position - var_42_29.position

				var_42_29.forward = Vector3.New(var_42_34.x, var_42_34.y, var_42_34.z)

				local var_42_35 = var_42_29.localEulerAngles

				var_42_35.z = 0
				var_42_35.x = 0
				var_42_29.localEulerAngles = var_42_35
			end

			if arg_39_1.time_ >= var_42_30 + var_42_31 and arg_39_1.time_ < var_42_30 + var_42_31 + arg_42_0 then
				var_42_29.localPosition = Vector3.New(0, 100, 0)

				local var_42_36 = manager.ui.mainCamera.transform.position - var_42_29.position

				var_42_29.forward = Vector3.New(var_42_36.x, var_42_36.y, var_42_36.z)

				local var_42_37 = var_42_29.localEulerAngles

				var_42_37.z = 0
				var_42_37.x = 0
				var_42_29.localEulerAngles = var_42_37
			end

			local var_42_38 = arg_39_1.actors_["1156ui_story"]
			local var_42_39 = 1.96599999815226

			if var_42_39 < arg_39_1.time_ and arg_39_1.time_ <= var_42_39 + arg_42_0 and not isNil(var_42_38) and arg_39_1.var_.characterEffect1156ui_story == nil then
				arg_39_1.var_.characterEffect1156ui_story = var_42_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_40 = 0.034000001847744

			if var_42_39 <= arg_39_1.time_ and arg_39_1.time_ < var_42_39 + var_42_40 and not isNil(var_42_38) then
				local var_42_41 = (arg_39_1.time_ - var_42_39) / var_42_40

				if arg_39_1.var_.characterEffect1156ui_story and not isNil(var_42_38) then
					local var_42_42 = Mathf.Lerp(0, 0.5, var_42_41)

					arg_39_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1156ui_story.fillRatio = var_42_42
				end
			end

			if arg_39_1.time_ >= var_42_39 + var_42_40 and arg_39_1.time_ < var_42_39 + var_42_40 + arg_42_0 and not isNil(var_42_38) and arg_39_1.var_.characterEffect1156ui_story then
				local var_42_43 = 0.5

				arg_39_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1156ui_story.fillRatio = var_42_43
			end

			local var_42_44 = 2.5
			local var_42_45 = 1

			if var_42_44 < arg_39_1.time_ and arg_39_1.time_ <= var_42_44 + arg_42_0 then
				local var_42_46 = "play"
				local var_42_47 = "effect"

				arg_39_1:AudioAction(var_42_46, var_42_47, "se_story_8", "se_story_8_fire05", "")
			end

			local var_42_48 = 0.2
			local var_42_49 = 1

			if var_42_48 < arg_39_1.time_ and arg_39_1.time_ <= var_42_48 + arg_42_0 then
				local var_42_50 = "stop"
				local var_42_51 = "effect"

				arg_39_1:AudioAction(var_42_50, var_42_51, "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_42_52 = 1.5
			local var_42_53 = 1

			if var_42_52 < arg_39_1.time_ and arg_39_1.time_ <= var_42_52 + arg_42_0 then
				local var_42_54 = "play"
				local var_42_55 = "effect"

				arg_39_1:AudioAction(var_42_54, var_42_55, "se_story_145", "se_story_145_amb_stone_l19f", "")
			end

			local var_42_56 = manager.ui.mainCamera.transform
			local var_42_57 = 2.5

			if var_42_57 < arg_39_1.time_ and arg_39_1.time_ <= var_42_57 + arg_42_0 then
				local var_42_58 = arg_39_1.var_.effect2010
				local var_42_59
				local var_42_60 = var_42_56

				if not var_42_58 then
					var_42_58 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), var_42_60)
					var_42_58.name = "2010"
					arg_39_1.var_.effect2010 = var_42_58
				else
					var_42_58.transform:SetParent(var_42_60)
				end

				var_42_58.transform.localPosition = Vector3.New(0, 0, -3.86)
				var_42_58.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_42_61 = arg_39_1.bgs_.L19f.transform
			local var_42_62 = 2

			if var_42_62 < arg_39_1.time_ and arg_39_1.time_ <= var_42_62 + arg_42_0 then
				arg_39_1.var_.moveOldPosL19f = var_42_61.localPosition
			end

			local var_42_63 = 0.001

			if var_42_62 <= arg_39_1.time_ and arg_39_1.time_ < var_42_62 + var_42_63 then
				local var_42_64 = (arg_39_1.time_ - var_42_62) / var_42_63
				local var_42_65 = Vector3.New(0, 1, 10)

				var_42_61.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPosL19f, var_42_65, var_42_64)
			end

			if arg_39_1.time_ >= var_42_62 + var_42_63 and arg_39_1.time_ < var_42_62 + var_42_63 + arg_42_0 then
				var_42_61.localPosition = Vector3.New(0, 1, 10)
			end

			local var_42_66 = arg_39_1.bgs_.L19f.transform
			local var_42_67 = 2.034

			if var_42_67 < arg_39_1.time_ and arg_39_1.time_ <= var_42_67 + arg_42_0 then
				arg_39_1.var_.moveOldPosL19f = var_42_66.localPosition
			end

			local var_42_68 = 1.466

			if var_42_67 <= arg_39_1.time_ and arg_39_1.time_ < var_42_67 + var_42_68 then
				local var_42_69 = (arg_39_1.time_ - var_42_67) / var_42_68
				local var_42_70 = Vector3.New(0, 1, 8)

				var_42_66.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPosL19f, var_42_70, var_42_69)
			end

			if arg_39_1.time_ >= var_42_67 + var_42_68 and arg_39_1.time_ < var_42_67 + var_42_68 + arg_42_0 then
				var_42_66.localPosition = Vector3.New(0, 1, 8)
			end

			if arg_39_1.frameCnt_ <= 1 then
				arg_39_1.dialog_:SetActive(false)
			end

			local var_42_71 = 4
			local var_42_72 = 1.6

			if var_42_71 < arg_39_1.time_ and arg_39_1.time_ <= var_42_71 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				arg_39_1.dialog_:SetActive(true)

				arg_39_1.dialogCg_.alpha = 0

				local var_42_73 = LeanTween.value(arg_39_1.dialog_, 0, 1, 0.3)

				var_42_73:setOnUpdate(LuaHelper.FloatAction(function(arg_43_0)
					arg_39_1.dialogCg_.alpha = arg_43_0
				end))
				var_42_73:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_39_1.dialog_)
					var_42_73:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_39_1.duration_ = arg_39_1.duration_ + 0.3

				SetActive(arg_39_1.leftNameGo_, false)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_74 = arg_39_1:GetWordFromCfg(322072010)
				local var_42_75 = arg_39_1:FormatText(var_42_74.content)

				arg_39_1.text_.text = var_42_75

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_76 = 64
				local var_42_77 = utf8.len(var_42_75)
				local var_42_78 = var_42_76 <= 0 and var_42_72 or var_42_72 * (var_42_77 / var_42_76)

				if var_42_78 > 0 and var_42_72 < var_42_78 then
					arg_39_1.talkMaxDuration = var_42_78
					var_42_71 = var_42_71 + 0.3

					if var_42_78 + var_42_71 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_78 + var_42_71
					end
				end

				arg_39_1.text_.text = var_42_75
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_79 = var_42_71 + 0.3
			local var_42_80 = math.max(var_42_72, arg_39_1.talkMaxDuration)

			if var_42_79 <= arg_39_1.time_ and arg_39_1.time_ < var_42_79 + var_42_80 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_79) / var_42_80

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_79 + var_42_80 and arg_39_1.time_ < var_42_79 + var_42_80 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
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
				actorName = "L19f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "L19f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.466,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play322072011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322072011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play322072012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0.1
			local var_48_1 = 1

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				local var_48_2 = "play"
				local var_48_3 = "effect"

				arg_45_1:AudioAction(var_48_2, var_48_3, "se_story_123_01", "se_story_123_01_explosion", "")
			end

			local var_48_4 = manager.ui.mainCamera.transform
			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				local var_48_6 = arg_45_1.var_.effect2011
				local var_48_7
				local var_48_8 = var_48_4

				if not var_48_6 then
					var_48_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_rockfall"), var_48_8)
					var_48_6.name = "2011"
					arg_45_1.var_.effect2011 = var_48_6
				else
					var_48_6.transform:SetParent(var_48_8)
				end

				var_48_6.transform.localPosition = Vector3.New(0, 0, -8.33)
				var_48_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_48_9 = manager.ui.mainCameraCom_
				local var_48_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_48_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_48_11 = var_48_6.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_48_12 = 15
				local var_48_13 = 2 * var_48_12 * Mathf.Tan(var_48_9.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_48_9.aspect
				local var_48_14 = 1
				local var_48_15 = 1.7777777777777777

				if var_48_15 < var_48_9.aspect then
					var_48_14 = var_48_13 / (2 * var_48_12 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_48_15)
				end

				for iter_48_0, iter_48_1 in ipairs(var_48_11) do
					local var_48_16 = iter_48_1.transform.localScale

					iter_48_1.transform.localScale = Vector3.New(var_48_16.x / var_48_10 * var_48_14, var_48_16.y / var_48_10, var_48_16.z)
				end
			end

			local var_48_17 = manager.ui.mainCamera.transform
			local var_48_18 = 0

			if var_48_18 < arg_45_1.time_ and arg_45_1.time_ <= var_48_18 + arg_48_0 then
				local var_48_19 = arg_45_1.var_.effect2010

				if var_48_19 then
					Object.Destroy(var_48_19)

					arg_45_1.var_.effect2010 = nil
				end
			end

			local var_48_20 = manager.ui.mainCamera.transform
			local var_48_21 = 0.1

			if var_48_21 < arg_45_1.time_ and arg_45_1.time_ <= var_48_21 + arg_48_0 then
				arg_45_1.var_.shakeOldPos = var_48_20.localPosition
			end

			local var_48_22 = 0.9

			if var_48_21 <= arg_45_1.time_ and arg_45_1.time_ < var_48_21 + var_48_22 then
				local var_48_23 = (arg_45_1.time_ - var_48_21) / 0.066
				local var_48_24, var_48_25 = math.modf(var_48_23)

				var_48_20.localPosition = Vector3.New(var_48_25 * 0.13, var_48_25 * 0.13, var_48_25 * 0.13) + arg_45_1.var_.shakeOldPos
			end

			if arg_45_1.time_ >= var_48_21 + var_48_22 and arg_45_1.time_ < var_48_21 + var_48_22 + arg_48_0 then
				var_48_20.localPosition = arg_45_1.var_.shakeOldPos
			end

			local var_48_26 = 0
			local var_48_27 = 1.25

			if var_48_26 < arg_45_1.time_ and arg_45_1.time_ <= var_48_26 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_28 = arg_45_1:GetWordFromCfg(322072011)
				local var_48_29 = arg_45_1:FormatText(var_48_28.content)

				arg_45_1.text_.text = var_48_29

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_30 = 50
				local var_48_31 = utf8.len(var_48_29)
				local var_48_32 = var_48_30 <= 0 and var_48_27 or var_48_27 * (var_48_31 / var_48_30)

				if var_48_32 > 0 and var_48_27 < var_48_32 then
					arg_45_1.talkMaxDuration = var_48_32

					if var_48_32 + var_48_26 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_32 + var_48_26
					end
				end

				arg_45_1.text_.text = var_48_29
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_33 = math.max(var_48_27, arg_45_1.talkMaxDuration)

			if var_48_26 <= arg_45_1.time_ and arg_45_1.time_ < var_48_26 + var_48_33 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_26) / var_48_33

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_26 + var_48_33 and arg_45_1.time_ < var_48_26 + var_48_33 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play322072012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322072012
		arg_49_1.duration_ = 5.33

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play322072013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = manager.ui.mainCamera.transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				local var_52_2 = arg_49_1.var_.effect2011

				if var_52_2 then
					Object.Destroy(var_52_2)

					arg_49_1.var_.effect2011 = nil
				end
			end

			local var_52_3 = 0

			if var_52_3 < arg_49_1.time_ and arg_49_1.time_ <= var_52_3 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_4 = 0.333333333333333

			if var_52_3 <= arg_49_1.time_ and arg_49_1.time_ < var_52_3 + var_52_4 then
				local var_52_5 = (arg_49_1.time_ - var_52_3) / var_52_4
				local var_52_6 = Color.New(0, 0, 0)

				var_52_6.a = Mathf.Lerp(0, 1, var_52_5)
				arg_49_1.mask_.color = var_52_6
			end

			if arg_49_1.time_ >= var_52_3 + var_52_4 and arg_49_1.time_ < var_52_3 + var_52_4 + arg_52_0 then
				local var_52_7 = Color.New(0, 0, 0)

				var_52_7.a = 1
				arg_49_1.mask_.color = var_52_7
			end

			local var_52_8 = 0.333333333333333

			if var_52_8 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.mask_.enabled = true
				arg_49_1.mask_.raycastTarget = true

				arg_49_1:SetGaussion(false)
			end

			local var_52_9 = 0.333333333333333

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_9 then
				local var_52_10 = (arg_49_1.time_ - var_52_8) / var_52_9
				local var_52_11 = Color.New(0, 0, 0)

				var_52_11.a = Mathf.Lerp(1, 0, var_52_10)
				arg_49_1.mask_.color = var_52_11
			end

			if arg_49_1.time_ >= var_52_8 + var_52_9 and arg_49_1.time_ < var_52_8 + var_52_9 + arg_52_0 then
				local var_52_12 = Color.New(0, 0, 0)
				local var_52_13 = 0

				arg_49_1.mask_.enabled = false
				var_52_12.a = var_52_13
				arg_49_1.mask_.color = var_52_12
			end

			if arg_49_1.frameCnt_ <= 1 then
				arg_49_1.dialog_:SetActive(false)
			end

			local var_52_14 = 0.333333333333333
			local var_52_15 = 1.05

			if var_52_14 < arg_49_1.time_ and arg_49_1.time_ <= var_52_14 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0

				arg_49_1.dialog_:SetActive(true)

				arg_49_1.dialogCg_.alpha = 0

				local var_52_16 = LeanTween.value(arg_49_1.dialog_, 0, 1, 0.3)

				var_52_16:setOnUpdate(LuaHelper.FloatAction(function(arg_53_0)
					arg_49_1.dialogCg_.alpha = arg_53_0
				end))
				var_52_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_49_1.dialog_)
					var_52_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_49_1.duration_ = arg_49_1.duration_ + 0.3

				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_17 = arg_49_1:GetWordFromCfg(322072012)
				local var_52_18 = arg_49_1:FormatText(var_52_17.content)

				arg_49_1.text_.text = var_52_18

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_19 = 42
				local var_52_20 = utf8.len(var_52_18)
				local var_52_21 = var_52_19 <= 0 and var_52_15 or var_52_15 * (var_52_20 / var_52_19)

				if var_52_21 > 0 and var_52_15 < var_52_21 then
					arg_49_1.talkMaxDuration = var_52_21
					var_52_14 = var_52_14 + 0.3

					if var_52_21 + var_52_14 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_21 + var_52_14
					end
				end

				arg_49_1.text_.text = var_52_18
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_22 = var_52_14 + 0.3
			local var_52_23 = math.max(var_52_15, arg_49_1.talkMaxDuration)

			if var_52_22 <= arg_49_1.time_ and arg_49_1.time_ < var_52_22 + var_52_23 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_22) / var_52_23

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_22 + var_52_23 and arg_49_1.time_ < var_52_22 + var_52_23 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play322072013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 322072013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play322072014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.1
			local var_58_1 = 1

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				local var_58_2 = "play"
				local var_58_3 = "effect"

				arg_55_1:AudioAction(var_58_2, var_58_3, "se_story_145", "se_story_145_monster_scream01", "")
			end

			local var_58_4 = manager.ui.mainCamera.transform
			local var_58_5 = 0.125

			if var_58_5 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 then
				arg_55_1.var_.shakeOldPos = var_58_4.localPosition
			end

			local var_58_6 = 0.541666666666667

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_6 then
				local var_58_7 = (arg_55_1.time_ - var_58_5) / 0.066
				local var_58_8, var_58_9 = math.modf(var_58_7)

				var_58_4.localPosition = Vector3.New(var_58_9 * 0.13, var_58_9 * 0.13, var_58_9 * 0.13) + arg_55_1.var_.shakeOldPos
			end

			if arg_55_1.time_ >= var_58_5 + var_58_6 and arg_55_1.time_ < var_58_5 + var_58_6 + arg_58_0 then
				var_58_4.localPosition = arg_55_1.var_.shakeOldPos
			end

			local var_58_10 = 0
			local var_58_11 = 0.125

			if var_58_10 < arg_55_1.time_ and arg_55_1.time_ <= var_58_10 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				local var_58_12 = arg_55_1:FormatText(StoryNameCfg[1363].name)

				arg_55_1.leftNameTxt_.text = var_58_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, true)
				arg_55_1.iconController_:SetSelectedState("hero")

				arg_55_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4052")

				arg_55_1.callingController_:SetSelectedState("normal")

				arg_55_1.keyicon_.color = Color.New(1, 1, 1)
				arg_55_1.icon_.color = Color.New(1, 1, 1)

				local var_58_13 = arg_55_1:GetWordFromCfg(322072013)
				local var_58_14 = arg_55_1:FormatText(var_58_13.content)

				arg_55_1.text_.text = var_58_14

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_15 = 5
				local var_58_16 = utf8.len(var_58_14)
				local var_58_17 = var_58_15 <= 0 and var_58_11 or var_58_11 * (var_58_16 / var_58_15)

				if var_58_17 > 0 and var_58_11 < var_58_17 then
					arg_55_1.talkMaxDuration = var_58_17

					if var_58_17 + var_58_10 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_17 + var_58_10
					end
				end

				arg_55_1.text_.text = var_58_14
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_18 = math.max(var_58_11, arg_55_1.talkMaxDuration)

			if var_58_10 <= arg_55_1.time_ and arg_55_1.time_ < var_58_10 + var_58_18 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_10) / var_58_18

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_10 + var_58_18 and arg_55_1.time_ < var_58_10 + var_58_18 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play322072014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 322072014
		arg_59_1.duration_ = 6.2

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play322072015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.5
			local var_62_1 = 1

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				local var_62_2 = "play"
				local var_62_3 = "effect"

				arg_59_1:AudioAction(var_62_2, var_62_3, "se_story_141", "se_story_141_snake07", "")
			end

			local var_62_4 = manager.ui.mainCamera.transform
			local var_62_5 = 0.5

			if var_62_5 < arg_59_1.time_ and arg_59_1.time_ <= var_62_5 + arg_62_0 then
				local var_62_6 = arg_59_1.var_.effect2014
				local var_62_7
				local var_62_8 = var_62_4

				if not var_62_6 then
					var_62_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_zhua"), var_62_8)
					var_62_6.name = "2014"
					arg_59_1.var_.effect2014 = var_62_6
				else
					var_62_6.transform:SetParent(var_62_8)
				end

				var_62_6.transform.localPosition = Vector3.New(-0.42, 0, -6.04)
				var_62_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_62_9 = manager.ui.mainCamera.transform
			local var_62_10 = 3.96666666666667

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 then
				local var_62_11 = arg_59_1.var_.effect2014

				if var_62_11 then
					Object.Destroy(var_62_11)

					arg_59_1.var_.effect2014 = nil
				end
			end

			local var_62_12 = manager.ui.mainCamera.transform
			local var_62_13 = 0.5

			if var_62_13 < arg_59_1.time_ and arg_59_1.time_ <= var_62_13 + arg_62_0 then
				arg_59_1.var_.shakeOldPos = var_62_12.localPosition
			end

			local var_62_14 = 0.45

			if var_62_13 <= arg_59_1.time_ and arg_59_1.time_ < var_62_13 + var_62_14 then
				local var_62_15 = (arg_59_1.time_ - var_62_13) / 0.066
				local var_62_16, var_62_17 = math.modf(var_62_15)

				var_62_12.localPosition = Vector3.New(var_62_17 * 0.13, var_62_17 * 0.13, var_62_17 * 0.13) + arg_59_1.var_.shakeOldPos
			end

			if arg_59_1.time_ >= var_62_13 + var_62_14 and arg_59_1.time_ < var_62_13 + var_62_14 + arg_62_0 then
				var_62_12.localPosition = arg_59_1.var_.shakeOldPos
			end

			local var_62_18 = 0.566666666666667

			if var_62_18 < arg_59_1.time_ and arg_59_1.time_ <= var_62_18 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = false

				arg_59_1:SetGaussion(false)
			end

			local var_62_19 = 0.0666666666666667

			if var_62_18 <= arg_59_1.time_ and arg_59_1.time_ < var_62_18 + var_62_19 then
				local var_62_20 = (arg_59_1.time_ - var_62_18) / var_62_19
				local var_62_21 = Color.New(1, 0.3820755, 0.3968858)

				var_62_21.a = Mathf.Lerp(1, 0, var_62_20)
				arg_59_1.mask_.color = var_62_21
			end

			if arg_59_1.time_ >= var_62_18 + var_62_19 and arg_59_1.time_ < var_62_18 + var_62_19 + arg_62_0 then
				local var_62_22 = Color.New(1, 0.3820755, 0.3968858)
				local var_62_23 = 0

				arg_59_1.mask_.enabled = false
				var_62_22.a = var_62_23
				arg_59_1.mask_.color = var_62_22
			end

			local var_62_24 = 0
			local var_62_25 = 0.95

			if var_62_24 < arg_59_1.time_ and arg_59_1.time_ <= var_62_24 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_26 = arg_59_1:GetWordFromCfg(322072014)
				local var_62_27 = arg_59_1:FormatText(var_62_26.content)

				arg_59_1.text_.text = var_62_27

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_28 = 38
				local var_62_29 = utf8.len(var_62_27)
				local var_62_30 = var_62_28 <= 0 and var_62_25 or var_62_25 * (var_62_29 / var_62_28)

				if var_62_30 > 0 and var_62_25 < var_62_30 then
					arg_59_1.talkMaxDuration = var_62_30

					if var_62_30 + var_62_24 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_30 + var_62_24
					end
				end

				arg_59_1.text_.text = var_62_27
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_31 = math.max(var_62_25, arg_59_1.talkMaxDuration)

			if var_62_24 <= arg_59_1.time_ and arg_59_1.time_ < var_62_24 + var_62_31 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_24) / var_62_31

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_24 + var_62_31 and arg_59_1.time_ < var_62_24 + var_62_31 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play322072015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 322072015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play322072016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.1
			local var_66_1 = 1

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				local var_66_2 = "play"
				local var_66_3 = "effect"

				arg_63_1:AudioAction(var_66_2, var_66_3, "se_story_145", "se_story_145_star_movement_wobble02", "")
			end

			local var_66_4 = 0
			local var_66_5 = 1.55

			if var_66_4 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(322072015)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_8 = 62
				local var_66_9 = utf8.len(var_66_7)
				local var_66_10 = var_66_8 <= 0 and var_66_5 or var_66_5 * (var_66_9 / var_66_8)

				if var_66_10 > 0 and var_66_5 < var_66_10 then
					arg_63_1.talkMaxDuration = var_66_10

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_11 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_11 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_11

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_11 and arg_63_1.time_ < var_66_4 + var_66_11 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play322072016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 322072016
		arg_67_1.duration_ = 2.63

		local var_67_0 = {
			zh = 1.466,
			ja = 2.633
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
				arg_67_0:Play322072017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.175

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[1361].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10150")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_3 = arg_67_1:GetWordFromCfg(322072016)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 7
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072016", "story_v_out_322072.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_322072", "322072016", "story_v_out_322072.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_322072", "322072016", "story_v_out_322072.awb")

						arg_67_1:RecordAudio("322072016", var_70_9)
						arg_67_1:RecordAudio("322072016", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_322072", "322072016", "story_v_out_322072.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_322072", "322072016", "story_v_out_322072.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play322072017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 322072017
		arg_71_1.duration_ = 11.23

		local var_71_0 = {
			zh = 9.166,
			ja = 11.233
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
				arg_71_0:Play322072018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = "ST61a"

			if arg_71_1.bgs_[var_74_0] == nil then
				local var_74_1 = Object.Instantiate(arg_71_1.paintGo_)

				var_74_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_74_0)
				var_74_1.name = var_74_0
				var_74_1.transform.parent = arg_71_1.stage_.transform
				var_74_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.bgs_[var_74_0] = var_74_1
			end

			local var_74_2 = 2

			if var_74_2 < arg_71_1.time_ and arg_71_1.time_ <= var_74_2 + arg_74_0 then
				local var_74_3 = manager.ui.mainCamera.transform.localPosition
				local var_74_4 = Vector3.New(0, 0, 10) + Vector3.New(var_74_3.x, var_74_3.y, 0)
				local var_74_5 = arg_71_1.bgs_.ST61a

				var_74_5.transform.localPosition = var_74_4
				var_74_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_74_6 = var_74_5:GetComponent("SpriteRenderer")

				if var_74_6 and var_74_6.sprite then
					local var_74_7 = (var_74_5.transform.localPosition - var_74_3).z
					local var_74_8 = manager.ui.mainCameraCom_
					local var_74_9 = 2 * var_74_7 * Mathf.Tan(var_74_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_74_10 = var_74_9 * var_74_8.aspect
					local var_74_11 = var_74_6.sprite.bounds.size.x
					local var_74_12 = var_74_6.sprite.bounds.size.y
					local var_74_13 = var_74_10 / var_74_11
					local var_74_14 = var_74_9 / var_74_12
					local var_74_15 = var_74_14 < var_74_13 and var_74_13 or var_74_14

					var_74_5.transform.localScale = Vector3.New(var_74_15, var_74_15, 0)
				end

				for iter_74_0, iter_74_1 in pairs(arg_71_1.bgs_) do
					if iter_74_0 ~= "ST61a" then
						iter_74_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_74_16 = 3.999999999999

			if var_74_16 < arg_71_1.time_ and arg_71_1.time_ <= var_74_16 + arg_74_0 then
				arg_71_1.allBtn_.enabled = false
			end

			local var_74_17 = 0.3

			if arg_71_1.time_ >= var_74_16 + var_74_17 and arg_71_1.time_ < var_74_16 + var_74_17 + arg_74_0 then
				arg_71_1.allBtn_.enabled = true
			end

			local var_74_18 = 0

			if var_74_18 < arg_71_1.time_ and arg_71_1.time_ <= var_74_18 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_19 = 2

			if var_74_18 <= arg_71_1.time_ and arg_71_1.time_ < var_74_18 + var_74_19 then
				local var_74_20 = (arg_71_1.time_ - var_74_18) / var_74_19
				local var_74_21 = Color.New(0, 0, 0)

				var_74_21.a = Mathf.Lerp(0, 1, var_74_20)
				arg_71_1.mask_.color = var_74_21
			end

			if arg_71_1.time_ >= var_74_18 + var_74_19 and arg_71_1.time_ < var_74_18 + var_74_19 + arg_74_0 then
				local var_74_22 = Color.New(0, 0, 0)

				var_74_22.a = 1
				arg_71_1.mask_.color = var_74_22
			end

			local var_74_23 = 2

			if var_74_23 < arg_71_1.time_ and arg_71_1.time_ <= var_74_23 + arg_74_0 then
				arg_71_1.mask_.enabled = true
				arg_71_1.mask_.raycastTarget = true

				arg_71_1:SetGaussion(false)
			end

			local var_74_24 = 2

			if var_74_23 <= arg_71_1.time_ and arg_71_1.time_ < var_74_23 + var_74_24 then
				local var_74_25 = (arg_71_1.time_ - var_74_23) / var_74_24
				local var_74_26 = Color.New(0, 0, 0)

				var_74_26.a = Mathf.Lerp(1, 0, var_74_25)
				arg_71_1.mask_.color = var_74_26
			end

			if arg_71_1.time_ >= var_74_23 + var_74_24 and arg_71_1.time_ < var_74_23 + var_74_24 + arg_74_0 then
				local var_74_27 = Color.New(0, 0, 0)
				local var_74_28 = 0

				arg_71_1.mask_.enabled = false
				var_74_27.a = var_74_28
				arg_71_1.mask_.color = var_74_27
			end

			local var_74_29 = "1089ui_story"

			if arg_71_1.actors_[var_74_29] == nil then
				local var_74_30 = Asset.Load("Char/" .. "1089ui_story")

				if not isNil(var_74_30) then
					local var_74_31 = Object.Instantiate(Asset.Load("Char/" .. "1089ui_story"), arg_71_1.stage_.transform)

					var_74_31.name = var_74_29
					var_74_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_71_1.actors_[var_74_29] = var_74_31

					local var_74_32 = var_74_31:GetComponentInChildren(typeof(CharacterEffect))

					var_74_32.enabled = true

					local var_74_33 = GameObjectTools.GetOrAddComponent(var_74_31, typeof(DynamicBoneHelper))

					if var_74_33 then
						var_74_33:EnableDynamicBone(false)
					end

					arg_71_1:ShowWeapon(var_74_32.transform, false)

					arg_71_1.var_[var_74_29 .. "Animator"] = var_74_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_71_1.var_[var_74_29 .. "Animator"].applyRootMotion = true
					arg_71_1.var_[var_74_29 .. "LipSync"] = var_74_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_74_34 = arg_71_1.actors_["1089ui_story"].transform
			local var_74_35 = 3.8

			if var_74_35 < arg_71_1.time_ and arg_71_1.time_ <= var_74_35 + arg_74_0 then
				arg_71_1.var_.moveOldPos1089ui_story = var_74_34.localPosition
			end

			local var_74_36 = 0.001

			if var_74_35 <= arg_71_1.time_ and arg_71_1.time_ < var_74_35 + var_74_36 then
				local var_74_37 = (arg_71_1.time_ - var_74_35) / var_74_36
				local var_74_38 = Vector3.New(0, -1.1, -6.17)

				var_74_34.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1089ui_story, var_74_38, var_74_37)

				local var_74_39 = manager.ui.mainCamera.transform.position - var_74_34.position

				var_74_34.forward = Vector3.New(var_74_39.x, var_74_39.y, var_74_39.z)

				local var_74_40 = var_74_34.localEulerAngles

				var_74_40.z = 0
				var_74_40.x = 0
				var_74_34.localEulerAngles = var_74_40
			end

			if arg_71_1.time_ >= var_74_35 + var_74_36 and arg_71_1.time_ < var_74_35 + var_74_36 + arg_74_0 then
				var_74_34.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_74_41 = manager.ui.mainCamera.transform.position - var_74_34.position

				var_74_34.forward = Vector3.New(var_74_41.x, var_74_41.y, var_74_41.z)

				local var_74_42 = var_74_34.localEulerAngles

				var_74_42.z = 0
				var_74_42.x = 0
				var_74_34.localEulerAngles = var_74_42
			end

			local var_74_43 = arg_71_1.actors_["1089ui_story"]
			local var_74_44 = 3.8

			if var_74_44 < arg_71_1.time_ and arg_71_1.time_ <= var_74_44 + arg_74_0 and not isNil(var_74_43) and arg_71_1.var_.characterEffect1089ui_story == nil then
				arg_71_1.var_.characterEffect1089ui_story = var_74_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_45 = 0.200000002980232

			if var_74_44 <= arg_71_1.time_ and arg_71_1.time_ < var_74_44 + var_74_45 and not isNil(var_74_43) then
				local var_74_46 = (arg_71_1.time_ - var_74_44) / var_74_45

				if arg_71_1.var_.characterEffect1089ui_story and not isNil(var_74_43) then
					arg_71_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_44 + var_74_45 and arg_71_1.time_ < var_74_44 + var_74_45 + arg_74_0 and not isNil(var_74_43) and arg_71_1.var_.characterEffect1089ui_story then
				arg_71_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_74_47 = 3.8

			if var_74_47 < arg_71_1.time_ and arg_71_1.time_ <= var_74_47 + arg_74_0 then
				arg_71_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_74_48 = 3.8

			if var_74_48 < arg_71_1.time_ and arg_71_1.time_ <= var_74_48 + arg_74_0 then
				arg_71_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_74_49 = 0
			local var_74_50 = 0.200000002980232

			if var_74_49 < arg_71_1.time_ and arg_71_1.time_ <= var_74_49 + arg_74_0 then
				local var_74_51 = "play"
				local var_74_52 = "music"

				arg_71_1:AudioAction(var_74_51, var_74_52, "ui_battle", "ui_battle_stopbgm", "")

				local var_74_53 = ""
				local var_74_54 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_74_54 ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_54 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_54

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_54
						arg_71_1.bgmTxt2_.text = var_74_54
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_74_55 = 0.366666666666667
			local var_74_56 = 1

			if var_74_55 < arg_71_1.time_ and arg_71_1.time_ <= var_74_55 + arg_74_0 then
				local var_74_57 = "play"
				local var_74_58 = "music"

				arg_71_1:AudioAction(var_74_57, var_74_58, "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious.awb")

				local var_74_59 = ""
				local var_74_60 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "bgm_activity_4_5_story_serious")

				if var_74_60 ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_60 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_60

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_60
						arg_71_1.bgmTxt2_.text = var_74_60
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_74_61 = 0.200000002980232
			local var_74_62 = 1

			if var_74_61 < arg_71_1.time_ and arg_71_1.time_ <= var_74_61 + arg_74_0 then
				local var_74_63 = "stop"
				local var_74_64 = "effect"

				arg_71_1:AudioAction(var_74_63, var_74_64, "se_story_145", "se_story_145_amb_stone_l19f", "")
			end

			local var_74_65 = 1.5
			local var_74_66 = 1

			if var_74_65 < arg_71_1.time_ and arg_71_1.time_ <= var_74_65 + arg_74_0 then
				local var_74_67 = "play"
				local var_74_68 = "effect"

				arg_71_1:AudioAction(var_74_67, var_74_68, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_74_69 = 0.37
			local var_74_70 = 1

			if var_74_69 < arg_71_1.time_ and arg_71_1.time_ <= var_74_69 + arg_74_0 then
				local var_74_71 = "play"
				local var_74_72 = "music"

				arg_71_1:AudioAction(var_74_71, var_74_72, "bgm_activity_4_5_story_serious", "init_story", "bgm_activity_4_5_story_serious.awb")

				local var_74_73 = ""
				local var_74_74 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "init_story")

				if var_74_74 ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_74 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_74

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_74
						arg_71_1.bgmTxt2_.text = var_74_74
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_71_1.frameCnt_ <= 1 then
				arg_71_1.dialog_:SetActive(false)
			end

			local var_74_75 = 4
			local var_74_76 = 0.625

			if var_74_75 < arg_71_1.time_ and arg_71_1.time_ <= var_74_75 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0

				arg_71_1.dialog_:SetActive(true)

				arg_71_1.dialogCg_.alpha = 0

				local var_74_77 = LeanTween.value(arg_71_1.dialog_, 0, 1, 0.3)

				var_74_77:setOnUpdate(LuaHelper.FloatAction(function(arg_78_0)
					arg_71_1.dialogCg_.alpha = arg_78_0
				end))
				var_74_77:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_71_1.dialog_)
					var_74_77:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_71_1.duration_ = arg_71_1.duration_ + 0.3

				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_78 = arg_71_1:FormatText(StoryNameCfg[1031].name)

				arg_71_1.leftNameTxt_.text = var_74_78

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_79 = arg_71_1:GetWordFromCfg(322072017)
				local var_74_80 = arg_71_1:FormatText(var_74_79.content)

				arg_71_1.text_.text = var_74_80

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_81 = 25
				local var_74_82 = utf8.len(var_74_80)
				local var_74_83 = var_74_81 <= 0 and var_74_76 or var_74_76 * (var_74_82 / var_74_81)

				if var_74_83 > 0 and var_74_76 < var_74_83 then
					arg_71_1.talkMaxDuration = var_74_83
					var_74_75 = var_74_75 + 0.3

					if var_74_83 + var_74_75 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_83 + var_74_75
					end
				end

				arg_71_1.text_.text = var_74_80
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072017", "story_v_out_322072.awb") ~= 0 then
					local var_74_84 = manager.audio:GetVoiceLength("story_v_out_322072", "322072017", "story_v_out_322072.awb") / 1000

					if var_74_84 + var_74_75 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_84 + var_74_75
					end

					if var_74_79.prefab_name ~= "" and arg_71_1.actors_[var_74_79.prefab_name] ~= nil then
						local var_74_85 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_79.prefab_name].transform, "story_v_out_322072", "322072017", "story_v_out_322072.awb")

						arg_71_1:RecordAudio("322072017", var_74_85)
						arg_71_1:RecordAudio("322072017", var_74_85)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_322072", "322072017", "story_v_out_322072.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_322072", "322072017", "story_v_out_322072.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_86 = var_74_75 + 0.3
			local var_74_87 = math.max(var_74_76, arg_71_1.talkMaxDuration)

			if var_74_86 <= arg_71_1.time_ and arg_71_1.time_ < var_74_86 + var_74_87 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_86) / var_74_87

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_86 + var_74_87 and arg_71_1.time_ < var_74_86 + var_74_87 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play322072018 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 322072018
		arg_80_1.duration_ = 5.1

		local var_80_0 = {
			zh = 3.9,
			ja = 5.1
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
				arg_80_0:Play322072019(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0

			if var_83_0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_0 + arg_83_0 then
				arg_80_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_83_2 = 0
			local var_83_3 = 0.475

			if var_83_2 < arg_80_1.time_ and arg_80_1.time_ <= var_83_2 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_4 = arg_80_1:FormatText(StoryNameCfg[1031].name)

				arg_80_1.leftNameTxt_.text = var_83_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_5 = arg_80_1:GetWordFromCfg(322072018)
				local var_83_6 = arg_80_1:FormatText(var_83_5.content)

				arg_80_1.text_.text = var_83_6

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_7 = 19
				local var_83_8 = utf8.len(var_83_6)
				local var_83_9 = var_83_7 <= 0 and var_83_3 or var_83_3 * (var_83_8 / var_83_7)

				if var_83_9 > 0 and var_83_3 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_2
					end
				end

				arg_80_1.text_.text = var_83_6
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072018", "story_v_out_322072.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_322072", "322072018", "story_v_out_322072.awb") / 1000

					if var_83_10 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_2
					end

					if var_83_5.prefab_name ~= "" and arg_80_1.actors_[var_83_5.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_5.prefab_name].transform, "story_v_out_322072", "322072018", "story_v_out_322072.awb")

						arg_80_1:RecordAudio("322072018", var_83_11)
						arg_80_1:RecordAudio("322072018", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_322072", "322072018", "story_v_out_322072.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_322072", "322072018", "story_v_out_322072.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = math.max(var_83_3, arg_80_1.talkMaxDuration)

			if var_83_2 <= arg_80_1.time_ and arg_80_1.time_ < var_83_2 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_2) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_2 + var_83_12 and arg_80_1.time_ < var_83_2 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play322072019 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 322072019
		arg_84_1.duration_ = 11.2

		local var_84_0 = {
			zh = 6.8,
			ja = 11.2
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
				arg_84_0:Play322072020(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["1089ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1089ui_story == nil then
				arg_84_1.var_.characterEffect1089ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.200000002980232

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect1089ui_story and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1089ui_story.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect1089ui_story then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1089ui_story.fillRatio = var_87_5
			end

			local var_87_6 = 0
			local var_87_7 = 0.8

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_8 = arg_84_1:FormatText(StoryNameCfg[1214].name)

				arg_84_1.leftNameTxt_.text = var_87_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_84_1.callingController_:SetSelectedState("calling")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_9 = arg_84_1:GetWordFromCfg(322072019)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 32
				local var_87_12 = utf8.len(var_87_10)
				local var_87_13 = var_87_11 <= 0 and var_87_7 or var_87_7 * (var_87_12 / var_87_11)

				if var_87_13 > 0 and var_87_7 < var_87_13 then
					arg_84_1.talkMaxDuration = var_87_13

					if var_87_13 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_13 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_10
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072019", "story_v_out_322072.awb") ~= 0 then
					local var_87_14 = manager.audio:GetVoiceLength("story_v_out_322072", "322072019", "story_v_out_322072.awb") / 1000

					if var_87_14 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_6
					end

					if var_87_9.prefab_name ~= "" and arg_84_1.actors_[var_87_9.prefab_name] ~= nil then
						local var_87_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_9.prefab_name].transform, "story_v_out_322072", "322072019", "story_v_out_322072.awb")

						arg_84_1:RecordAudio("322072019", var_87_15)
						arg_84_1:RecordAudio("322072019", var_87_15)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_322072", "322072019", "story_v_out_322072.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_322072", "322072019", "story_v_out_322072.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_16 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_16 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_16

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_16 and arg_84_1.time_ < var_87_6 + var_87_16 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play322072020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 322072020
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play322072021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["1089ui_story"].transform
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 then
				arg_88_1.var_.moveOldPos1089ui_story = var_91_0.localPosition
			end

			local var_91_2 = 0.001

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2
				local var_91_4 = Vector3.New(0, 100, 0)

				var_91_0.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1089ui_story, var_91_4, var_91_3)

				local var_91_5 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_5.x, var_91_5.y, var_91_5.z)

				local var_91_6 = var_91_0.localEulerAngles

				var_91_6.z = 0
				var_91_6.x = 0
				var_91_0.localEulerAngles = var_91_6
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 then
				var_91_0.localPosition = Vector3.New(0, 100, 0)

				local var_91_7 = manager.ui.mainCamera.transform.position - var_91_0.position

				var_91_0.forward = Vector3.New(var_91_7.x, var_91_7.y, var_91_7.z)

				local var_91_8 = var_91_0.localEulerAngles

				var_91_8.z = 0
				var_91_8.x = 0
				var_91_0.localEulerAngles = var_91_8
			end

			local var_91_9 = "10103ui_story"

			if arg_88_1.actors_[var_91_9] == nil then
				local var_91_10 = Asset.Load("Char/" .. "10103ui_story")

				if not isNil(var_91_10) then
					local var_91_11 = Object.Instantiate(Asset.Load("Char/" .. "10103ui_story"), arg_88_1.stage_.transform)

					var_91_11.name = var_91_9
					var_91_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_88_1.actors_[var_91_9] = var_91_11

					local var_91_12 = var_91_11:GetComponentInChildren(typeof(CharacterEffect))

					var_91_12.enabled = true

					local var_91_13 = GameObjectTools.GetOrAddComponent(var_91_11, typeof(DynamicBoneHelper))

					if var_91_13 then
						var_91_13:EnableDynamicBone(false)
					end

					arg_88_1:ShowWeapon(var_91_12.transform, false)

					arg_88_1.var_[var_91_9 .. "Animator"] = var_91_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_88_1.var_[var_91_9 .. "Animator"].applyRootMotion = true
					arg_88_1.var_[var_91_9 .. "LipSync"] = var_91_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_91_14 = arg_88_1.actors_["10103ui_story"].transform
			local var_91_15 = 0

			if var_91_15 < arg_88_1.time_ and arg_88_1.time_ <= var_91_15 + arg_91_0 then
				arg_88_1.var_.moveOldPos10103ui_story = var_91_14.localPosition

				local var_91_16 = GameObjectTools.GetOrAddComponent(var_91_14.gameObject, typeof(DynamicBoneHelper))

				if var_91_16 then
					var_91_16:EnableDynamicBone(false)
				end
			end

			local var_91_17 = 0.001

			if var_91_15 <= arg_88_1.time_ and arg_88_1.time_ < var_91_15 + var_91_17 then
				local var_91_18 = (arg_88_1.time_ - var_91_15) / var_91_17
				local var_91_19 = Vector3.New(0, 100, 0)

				var_91_14.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10103ui_story, var_91_19, var_91_18)

				local var_91_20 = manager.ui.mainCamera.transform.position - var_91_14.position

				var_91_14.forward = Vector3.New(var_91_20.x, var_91_20.y, var_91_20.z)

				local var_91_21 = var_91_14.localEulerAngles

				var_91_21.z = 0
				var_91_21.x = 0
				var_91_14.localEulerAngles = var_91_21
			end

			if arg_88_1.time_ >= var_91_15 + var_91_17 and arg_88_1.time_ < var_91_15 + var_91_17 + arg_91_0 then
				var_91_14.localPosition = Vector3.New(0, 100, 0)

				local var_91_22 = manager.ui.mainCamera.transform.position - var_91_14.position

				var_91_14.forward = Vector3.New(var_91_22.x, var_91_22.y, var_91_22.z)

				local var_91_23 = var_91_14.localEulerAngles

				var_91_23.z = 0
				var_91_23.x = 0
				var_91_14.localEulerAngles = var_91_23

				local var_91_24 = GameObjectTools.GetOrAddComponent(var_91_14.gameObject, typeof(DynamicBoneHelper))

				if var_91_24 then
					var_91_24:EnableDynamicBone(true)
				end
			end

			local var_91_25 = 0.1
			local var_91_26 = 1

			if var_91_25 < arg_88_1.time_ and arg_88_1.time_ <= var_91_25 + arg_91_0 then
				local var_91_27 = "play"
				local var_91_28 = "effect"

				arg_88_1:AudioAction(var_91_27, var_91_28, "se_story_141", "se_story_141_footstep_upstairs", "")
			end

			local var_91_29 = 0
			local var_91_30 = 1.075

			if var_91_29 < arg_88_1.time_ and arg_88_1.time_ <= var_91_29 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_31 = arg_88_1:GetWordFromCfg(322072020)
				local var_91_32 = arg_88_1:FormatText(var_91_31.content)

				arg_88_1.text_.text = var_91_32

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_33 = 43
				local var_91_34 = utf8.len(var_91_32)
				local var_91_35 = var_91_33 <= 0 and var_91_30 or var_91_30 * (var_91_34 / var_91_33)

				if var_91_35 > 0 and var_91_30 < var_91_35 then
					arg_88_1.talkMaxDuration = var_91_35

					if var_91_35 + var_91_29 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_35 + var_91_29
					end
				end

				arg_88_1.text_.text = var_91_32
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_36 = math.max(var_91_30, arg_88_1.talkMaxDuration)

			if var_91_29 <= arg_88_1.time_ and arg_88_1.time_ < var_91_29 + var_91_36 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_29) / var_91_36

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_29 + var_91_36 and arg_88_1.time_ < var_91_29 + var_91_36 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play322072021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 322072021
		arg_92_1.duration_ = 2.1

		local var_92_0 = {
			zh = 1.8,
			ja = 2.1
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
				arg_92_0:Play322072022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0
			local var_95_1 = 0.225

			if var_95_0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				local var_95_2 = arg_92_1:FormatText(StoryNameCfg[1214].name)

				arg_92_1.leftNameTxt_.text = var_95_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_92_1.callingController_:SetSelectedState("calling")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(322072021)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 9
				local var_95_6 = utf8.len(var_95_4)
				local var_95_7 = var_95_5 <= 0 and var_95_1 or var_95_1 * (var_95_6 / var_95_5)

				if var_95_7 > 0 and var_95_1 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072021", "story_v_out_322072.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_322072", "322072021", "story_v_out_322072.awb") / 1000

					if var_95_8 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_0
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_322072", "322072021", "story_v_out_322072.awb")

						arg_92_1:RecordAudio("322072021", var_95_9)
						arg_92_1:RecordAudio("322072021", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_322072", "322072021", "story_v_out_322072.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_322072", "322072021", "story_v_out_322072.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_10 and arg_92_1.time_ < var_95_0 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play322072022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 322072022
		arg_96_1.duration_ = 2

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play322072023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = arg_96_1.actors_["1089ui_story"].transform
			local var_99_1 = 0

			if var_99_1 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.var_.moveOldPos1089ui_story = var_99_0.localPosition
			end

			local var_99_2 = 0.001

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_2 then
				local var_99_3 = (arg_96_1.time_ - var_99_1) / var_99_2
				local var_99_4 = Vector3.New(0, -1.1, -6.17)

				var_99_0.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1089ui_story, var_99_4, var_99_3)

				local var_99_5 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_5.x, var_99_5.y, var_99_5.z)

				local var_99_6 = var_99_0.localEulerAngles

				var_99_6.z = 0
				var_99_6.x = 0
				var_99_0.localEulerAngles = var_99_6
			end

			if arg_96_1.time_ >= var_99_1 + var_99_2 and arg_96_1.time_ < var_99_1 + var_99_2 + arg_99_0 then
				var_99_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_99_7 = manager.ui.mainCamera.transform.position - var_99_0.position

				var_99_0.forward = Vector3.New(var_99_7.x, var_99_7.y, var_99_7.z)

				local var_99_8 = var_99_0.localEulerAngles

				var_99_8.z = 0
				var_99_8.x = 0
				var_99_0.localEulerAngles = var_99_8
			end

			local var_99_9 = arg_96_1.actors_["1089ui_story"]
			local var_99_10 = 0

			if var_99_10 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect1089ui_story == nil then
				arg_96_1.var_.characterEffect1089ui_story = var_99_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_11 = 0.200000002980232

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_11 and not isNil(var_99_9) then
				local var_99_12 = (arg_96_1.time_ - var_99_10) / var_99_11

				if arg_96_1.var_.characterEffect1089ui_story and not isNil(var_99_9) then
					arg_96_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= var_99_10 + var_99_11 and arg_96_1.time_ < var_99_10 + var_99_11 + arg_99_0 and not isNil(var_99_9) and arg_96_1.var_.characterEffect1089ui_story then
				arg_96_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_99_13 = 0

			if var_99_13 < arg_96_1.time_ and arg_96_1.time_ <= var_99_13 + arg_99_0 then
				arg_96_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			local var_99_14 = 0

			if var_99_14 < arg_96_1.time_ and arg_96_1.time_ <= var_99_14 + arg_99_0 then
				arg_96_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_99_15 = 0
			local var_99_16 = 0.05

			if var_99_15 < arg_96_1.time_ and arg_96_1.time_ <= var_99_15 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_17 = arg_96_1:FormatText(StoryNameCfg[1031].name)

				arg_96_1.leftNameTxt_.text = var_99_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_18 = arg_96_1:GetWordFromCfg(322072022)
				local var_99_19 = arg_96_1:FormatText(var_99_18.content)

				arg_96_1.text_.text = var_99_19

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_20 = 2
				local var_99_21 = utf8.len(var_99_19)
				local var_99_22 = var_99_20 <= 0 and var_99_16 or var_99_16 * (var_99_21 / var_99_20)

				if var_99_22 > 0 and var_99_16 < var_99_22 then
					arg_96_1.talkMaxDuration = var_99_22

					if var_99_22 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_22 + var_99_15
					end
				end

				arg_96_1.text_.text = var_99_19
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072022", "story_v_out_322072.awb") ~= 0 then
					local var_99_23 = manager.audio:GetVoiceLength("story_v_out_322072", "322072022", "story_v_out_322072.awb") / 1000

					if var_99_23 + var_99_15 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_23 + var_99_15
					end

					if var_99_18.prefab_name ~= "" and arg_96_1.actors_[var_99_18.prefab_name] ~= nil then
						local var_99_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_18.prefab_name].transform, "story_v_out_322072", "322072022", "story_v_out_322072.awb")

						arg_96_1:RecordAudio("322072022", var_99_24)
						arg_96_1:RecordAudio("322072022", var_99_24)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_322072", "322072022", "story_v_out_322072.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_322072", "322072022", "story_v_out_322072.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_25 = math.max(var_99_16, arg_96_1.talkMaxDuration)

			if var_99_15 <= arg_96_1.time_ and arg_96_1.time_ < var_99_15 + var_99_25 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_15) / var_99_25

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_15 + var_99_25 and arg_96_1.time_ < var_99_15 + var_99_25 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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

		arg_96_1:InitPlayNodeList()
	end,
	Play322072023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 322072023
		arg_100_1.duration_ = 7.97

		local var_100_0 = {
			zh = 5.766,
			ja = 7.966
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
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play322072024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = arg_100_1.actors_["1089ui_story"]
			local var_103_1 = 0

			if var_103_1 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1089ui_story == nil then
				arg_100_1.var_.characterEffect1089ui_story = var_103_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_2 = 0.200000002980232

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_2 and not isNil(var_103_0) then
				local var_103_3 = (arg_100_1.time_ - var_103_1) / var_103_2

				if arg_100_1.var_.characterEffect1089ui_story and not isNil(var_103_0) then
					local var_103_4 = Mathf.Lerp(0, 0.5, var_103_3)

					arg_100_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1089ui_story.fillRatio = var_103_4
				end
			end

			if arg_100_1.time_ >= var_103_1 + var_103_2 and arg_100_1.time_ < var_103_1 + var_103_2 + arg_103_0 and not isNil(var_103_0) and arg_100_1.var_.characterEffect1089ui_story then
				local var_103_5 = 0.5

				arg_100_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1089ui_story.fillRatio = var_103_5
			end

			local var_103_6 = 0
			local var_103_7 = 0.575

			if var_103_6 < arg_100_1.time_ and arg_100_1.time_ <= var_103_6 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_8 = arg_100_1:FormatText(StoryNameCfg[1214].name)

				arg_100_1.leftNameTxt_.text = var_103_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_100_1.callingController_:SetSelectedState("calling")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_9 = arg_100_1:GetWordFromCfg(322072023)
				local var_103_10 = arg_100_1:FormatText(var_103_9.content)

				arg_100_1.text_.text = var_103_10

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_11 = 23
				local var_103_12 = utf8.len(var_103_10)
				local var_103_13 = var_103_11 <= 0 and var_103_7 or var_103_7 * (var_103_12 / var_103_11)

				if var_103_13 > 0 and var_103_7 < var_103_13 then
					arg_100_1.talkMaxDuration = var_103_13

					if var_103_13 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_13 + var_103_6
					end
				end

				arg_100_1.text_.text = var_103_10
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072023", "story_v_out_322072.awb") ~= 0 then
					local var_103_14 = manager.audio:GetVoiceLength("story_v_out_322072", "322072023", "story_v_out_322072.awb") / 1000

					if var_103_14 + var_103_6 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_14 + var_103_6
					end

					if var_103_9.prefab_name ~= "" and arg_100_1.actors_[var_103_9.prefab_name] ~= nil then
						local var_103_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_9.prefab_name].transform, "story_v_out_322072", "322072023", "story_v_out_322072.awb")

						arg_100_1:RecordAudio("322072023", var_103_15)
						arg_100_1:RecordAudio("322072023", var_103_15)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_322072", "322072023", "story_v_out_322072.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_322072", "322072023", "story_v_out_322072.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_16 = math.max(var_103_7, arg_100_1.talkMaxDuration)

			if var_103_6 <= arg_100_1.time_ and arg_100_1.time_ < var_103_6 + var_103_16 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_6) / var_103_16

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_6 + var_103_16 and arg_100_1.time_ < var_103_6 + var_103_16 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play322072024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 322072024
		arg_104_1.duration_ = 3.5

		local var_104_0 = {
			zh = 1.999999999999,
			ja = 3.5
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
				arg_104_0:Play322072025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["1089ui_story"].transform
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 then
				arg_104_1.var_.moveOldPos1089ui_story = var_107_0.localPosition

				local var_107_2 = "1089ui_story"

				arg_104_1:ShowWeapon(arg_104_1.var_[var_107_2 .. "Animator"].transform, false)
			end

			local var_107_3 = 0.001

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_3 then
				local var_107_4 = (arg_104_1.time_ - var_107_1) / var_107_3
				local var_107_5 = Vector3.New(0, -1.1, -6.17)

				var_107_0.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1089ui_story, var_107_5, var_107_4)

				local var_107_6 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_6.x, var_107_6.y, var_107_6.z)

				local var_107_7 = var_107_0.localEulerAngles

				var_107_7.z = 0
				var_107_7.x = 0
				var_107_0.localEulerAngles = var_107_7
			end

			if arg_104_1.time_ >= var_107_1 + var_107_3 and arg_104_1.time_ < var_107_1 + var_107_3 + arg_107_0 then
				var_107_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_107_8 = manager.ui.mainCamera.transform.position - var_107_0.position

				var_107_0.forward = Vector3.New(var_107_8.x, var_107_8.y, var_107_8.z)

				local var_107_9 = var_107_0.localEulerAngles

				var_107_9.z = 0
				var_107_9.x = 0
				var_107_0.localEulerAngles = var_107_9
			end

			local var_107_10 = arg_104_1.actors_["1089ui_story"]
			local var_107_11 = 0

			if var_107_11 < arg_104_1.time_ and arg_104_1.time_ <= var_107_11 + arg_107_0 and not isNil(var_107_10) and arg_104_1.var_.characterEffect1089ui_story == nil then
				arg_104_1.var_.characterEffect1089ui_story = var_107_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_12 = 0.200000002980232

			if var_107_11 <= arg_104_1.time_ and arg_104_1.time_ < var_107_11 + var_107_12 and not isNil(var_107_10) then
				local var_107_13 = (arg_104_1.time_ - var_107_11) / var_107_12

				if arg_104_1.var_.characterEffect1089ui_story and not isNil(var_107_10) then
					arg_104_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_11 + var_107_12 and arg_104_1.time_ < var_107_11 + var_107_12 + arg_107_0 and not isNil(var_107_10) and arg_104_1.var_.characterEffect1089ui_story then
				arg_104_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_107_14 = 0

			if var_107_14 < arg_104_1.time_ and arg_104_1.time_ <= var_107_14 + arg_107_0 then
				arg_104_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			local var_107_15 = 0

			if var_107_15 < arg_104_1.time_ and arg_104_1.time_ <= var_107_15 + arg_107_0 then
				arg_104_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_107_16 = 0
			local var_107_17 = 0.125

			if var_107_16 < arg_104_1.time_ and arg_104_1.time_ <= var_107_16 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_18 = arg_104_1:FormatText(StoryNameCfg[1031].name)

				arg_104_1.leftNameTxt_.text = var_107_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_19 = arg_104_1:GetWordFromCfg(322072024)
				local var_107_20 = arg_104_1:FormatText(var_107_19.content)

				arg_104_1.text_.text = var_107_20

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_21 = 5
				local var_107_22 = utf8.len(var_107_20)
				local var_107_23 = var_107_21 <= 0 and var_107_17 or var_107_17 * (var_107_22 / var_107_21)

				if var_107_23 > 0 and var_107_17 < var_107_23 then
					arg_104_1.talkMaxDuration = var_107_23

					if var_107_23 + var_107_16 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_23 + var_107_16
					end
				end

				arg_104_1.text_.text = var_107_20
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072024", "story_v_out_322072.awb") ~= 0 then
					local var_107_24 = manager.audio:GetVoiceLength("story_v_out_322072", "322072024", "story_v_out_322072.awb") / 1000

					if var_107_24 + var_107_16 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_24 + var_107_16
					end

					if var_107_19.prefab_name ~= "" and arg_104_1.actors_[var_107_19.prefab_name] ~= nil then
						local var_107_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_19.prefab_name].transform, "story_v_out_322072", "322072024", "story_v_out_322072.awb")

						arg_104_1:RecordAudio("322072024", var_107_25)
						arg_104_1:RecordAudio("322072024", var_107_25)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_322072", "322072024", "story_v_out_322072.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_322072", "322072024", "story_v_out_322072.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_26 = math.max(var_107_17, arg_104_1.talkMaxDuration)

			if var_107_16 <= arg_104_1.time_ and arg_104_1.time_ < var_107_16 + var_107_26 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_16) / var_107_26

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_16 + var_107_26 and arg_104_1.time_ < var_107_16 + var_107_26 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
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

		arg_104_1:InitPlayNodeList()
	end,
	Play322072025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 322072025
		arg_108_1.duration_ = 4.8

		local var_108_0 = {
			zh = 2.866,
			ja = 4.8
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play322072026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["1089ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1089ui_story == nil then
				arg_108_1.var_.characterEffect1089ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect1089ui_story and not isNil(var_111_0) then
					local var_111_4 = Mathf.Lerp(0, 0.5, var_111_3)

					arg_108_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1089ui_story.fillRatio = var_111_4
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1089ui_story then
				local var_111_5 = 0.5

				arg_108_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1089ui_story.fillRatio = var_111_5
			end

			local var_111_6 = 0
			local var_111_7 = 0.25

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_8 = arg_108_1:FormatText(StoryNameCfg[1214].name)

				arg_108_1.leftNameTxt_.text = var_111_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_108_1.callingController_:SetSelectedState("calling")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_9 = arg_108_1:GetWordFromCfg(322072025)
				local var_111_10 = arg_108_1:FormatText(var_111_9.content)

				arg_108_1.text_.text = var_111_10

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 10
				local var_111_12 = utf8.len(var_111_10)
				local var_111_13 = var_111_11 <= 0 and var_111_7 or var_111_7 * (var_111_12 / var_111_11)

				if var_111_13 > 0 and var_111_7 < var_111_13 then
					arg_108_1.talkMaxDuration = var_111_13

					if var_111_13 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_13 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_10
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072025", "story_v_out_322072.awb") ~= 0 then
					local var_111_14 = manager.audio:GetVoiceLength("story_v_out_322072", "322072025", "story_v_out_322072.awb") / 1000

					if var_111_14 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_14 + var_111_6
					end

					if var_111_9.prefab_name ~= "" and arg_108_1.actors_[var_111_9.prefab_name] ~= nil then
						local var_111_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_9.prefab_name].transform, "story_v_out_322072", "322072025", "story_v_out_322072.awb")

						arg_108_1:RecordAudio("322072025", var_111_15)
						arg_108_1:RecordAudio("322072025", var_111_15)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_322072", "322072025", "story_v_out_322072.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_322072", "322072025", "story_v_out_322072.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_16 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_16 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_16

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_16 and arg_108_1.time_ < var_111_6 + var_111_16 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play322072026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 322072026
		arg_112_1.duration_ = 5.3

		local var_112_0 = {
			zh = 4.033,
			ja = 5.3
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play322072027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = arg_112_1.actors_["1089ui_story"]
			local var_115_1 = 0

			if var_115_1 < arg_112_1.time_ and arg_112_1.time_ <= var_115_1 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1089ui_story == nil then
				arg_112_1.var_.characterEffect1089ui_story = var_115_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if var_115_1 <= arg_112_1.time_ and arg_112_1.time_ < var_115_1 + var_115_2 and not isNil(var_115_0) then
				local var_115_3 = (arg_112_1.time_ - var_115_1) / var_115_2

				if arg_112_1.var_.characterEffect1089ui_story and not isNil(var_115_0) then
					arg_112_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= var_115_1 + var_115_2 and arg_112_1.time_ < var_115_1 + var_115_2 + arg_115_0 and not isNil(var_115_0) and arg_112_1.var_.characterEffect1089ui_story then
				arg_112_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_115_4 = 0

			if var_115_4 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_2")
			end

			local var_115_5 = 0

			if var_115_5 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 then
				arg_112_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_115_6 = 0
			local var_115_7 = 0.475

			if var_115_6 < arg_112_1.time_ and arg_112_1.time_ <= var_115_6 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				local var_115_8 = arg_112_1:FormatText(StoryNameCfg[1031].name)

				arg_112_1.leftNameTxt_.text = var_115_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_9 = arg_112_1:GetWordFromCfg(322072026)
				local var_115_10 = arg_112_1:FormatText(var_115_9.content)

				arg_112_1.text_.text = var_115_10

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_11 = 19
				local var_115_12 = utf8.len(var_115_10)
				local var_115_13 = var_115_11 <= 0 and var_115_7 or var_115_7 * (var_115_12 / var_115_11)

				if var_115_13 > 0 and var_115_7 < var_115_13 then
					arg_112_1.talkMaxDuration = var_115_13

					if var_115_13 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_6
					end
				end

				arg_112_1.text_.text = var_115_10
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072026", "story_v_out_322072.awb") ~= 0 then
					local var_115_14 = manager.audio:GetVoiceLength("story_v_out_322072", "322072026", "story_v_out_322072.awb") / 1000

					if var_115_14 + var_115_6 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_14 + var_115_6
					end

					if var_115_9.prefab_name ~= "" and arg_112_1.actors_[var_115_9.prefab_name] ~= nil then
						local var_115_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_9.prefab_name].transform, "story_v_out_322072", "322072026", "story_v_out_322072.awb")

						arg_112_1:RecordAudio("322072026", var_115_15)
						arg_112_1:RecordAudio("322072026", var_115_15)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_322072", "322072026", "story_v_out_322072.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_322072", "322072026", "story_v_out_322072.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_16 = math.max(var_115_7, arg_112_1.talkMaxDuration)

			if var_115_6 <= arg_112_1.time_ and arg_112_1.time_ < var_115_6 + var_115_16 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_6) / var_115_16

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_6 + var_115_16 and arg_112_1.time_ < var_115_6 + var_115_16 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play322072027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 322072027
		arg_116_1.duration_ = 6.13

		local var_116_0 = {
			zh = 3.366,
			ja = 6.133
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play322072028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0

			if var_119_0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_0 + arg_119_0 then
				arg_116_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_119_1 = 0
			local var_119_2 = 0.3

			if var_119_1 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				local var_119_3 = arg_116_1:FormatText(StoryNameCfg[1031].name)

				arg_116_1.leftNameTxt_.text = var_119_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_4 = arg_116_1:GetWordFromCfg(322072027)
				local var_119_5 = arg_116_1:FormatText(var_119_4.content)

				arg_116_1.text_.text = var_119_5

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_6 = 12
				local var_119_7 = utf8.len(var_119_5)
				local var_119_8 = var_119_6 <= 0 and var_119_2 or var_119_2 * (var_119_7 / var_119_6)

				if var_119_8 > 0 and var_119_2 < var_119_8 then
					arg_116_1.talkMaxDuration = var_119_8

					if var_119_8 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_8 + var_119_1
					end
				end

				arg_116_1.text_.text = var_119_5
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072027", "story_v_out_322072.awb") ~= 0 then
					local var_119_9 = manager.audio:GetVoiceLength("story_v_out_322072", "322072027", "story_v_out_322072.awb") / 1000

					if var_119_9 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_1
					end

					if var_119_4.prefab_name ~= "" and arg_116_1.actors_[var_119_4.prefab_name] ~= nil then
						local var_119_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_4.prefab_name].transform, "story_v_out_322072", "322072027", "story_v_out_322072.awb")

						arg_116_1:RecordAudio("322072027", var_119_10)
						arg_116_1:RecordAudio("322072027", var_119_10)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_322072", "322072027", "story_v_out_322072.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_322072", "322072027", "story_v_out_322072.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_11 = math.max(var_119_2, arg_116_1.talkMaxDuration)

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_11 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_1) / var_119_11

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_1 + var_119_11 and arg_116_1.time_ < var_119_1 + var_119_11 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play322072028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 322072028
		arg_120_1.duration_ = 1.9

		local var_120_0 = {
			zh = 1.033,
			ja = 1.9
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
				arg_120_0:Play322072029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = arg_120_1.actors_["1089ui_story"]
			local var_123_1 = 0

			if var_123_1 < arg_120_1.time_ and arg_120_1.time_ <= var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1089ui_story == nil then
				arg_120_1.var_.characterEffect1089ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_2 = 0.200000002980232

			if var_123_1 <= arg_120_1.time_ and arg_120_1.time_ < var_123_1 + var_123_2 and not isNil(var_123_0) then
				local var_123_3 = (arg_120_1.time_ - var_123_1) / var_123_2

				if arg_120_1.var_.characterEffect1089ui_story and not isNil(var_123_0) then
					local var_123_4 = Mathf.Lerp(0, 0.5, var_123_3)

					arg_120_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1089ui_story.fillRatio = var_123_4
				end
			end

			if arg_120_1.time_ >= var_123_1 + var_123_2 and arg_120_1.time_ < var_123_1 + var_123_2 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1089ui_story then
				local var_123_5 = 0.5

				arg_120_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1089ui_story.fillRatio = var_123_5
			end

			local var_123_6 = 0
			local var_123_7 = 0.075

			if var_123_6 < arg_120_1.time_ and arg_120_1.time_ <= var_123_6 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				local var_123_8 = arg_120_1:FormatText(StoryNameCfg[1214].name)

				arg_120_1.leftNameTxt_.text = var_123_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_120_1.callingController_:SetSelectedState("calling")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_9 = arg_120_1:GetWordFromCfg(322072028)
				local var_123_10 = arg_120_1:FormatText(var_123_9.content)

				arg_120_1.text_.text = var_123_10

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_11 = 3
				local var_123_12 = utf8.len(var_123_10)
				local var_123_13 = var_123_11 <= 0 and var_123_7 or var_123_7 * (var_123_12 / var_123_11)

				if var_123_13 > 0 and var_123_7 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_6
					end
				end

				arg_120_1.text_.text = var_123_10
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072028", "story_v_out_322072.awb") ~= 0 then
					local var_123_14 = manager.audio:GetVoiceLength("story_v_out_322072", "322072028", "story_v_out_322072.awb") / 1000

					if var_123_14 + var_123_6 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_14 + var_123_6
					end

					if var_123_9.prefab_name ~= "" and arg_120_1.actors_[var_123_9.prefab_name] ~= nil then
						local var_123_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_9.prefab_name].transform, "story_v_out_322072", "322072028", "story_v_out_322072.awb")

						arg_120_1:RecordAudio("322072028", var_123_15)
						arg_120_1:RecordAudio("322072028", var_123_15)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_322072", "322072028", "story_v_out_322072.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_322072", "322072028", "story_v_out_322072.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_16 = math.max(var_123_7, arg_120_1.talkMaxDuration)

			if var_123_6 <= arg_120_1.time_ and arg_120_1.time_ < var_123_6 + var_123_16 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_6) / var_123_16

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_6 + var_123_16 and arg_120_1.time_ < var_123_6 + var_123_16 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play322072029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 322072029
		arg_124_1.duration_ = 11.23

		local var_124_0 = {
			zh = 6.8,
			ja = 11.233
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play322072030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = arg_124_1.actors_["1089ui_story"]
			local var_127_1 = 0

			if var_127_1 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1089ui_story == nil then
				arg_124_1.var_.characterEffect1089ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_2 and not isNil(var_127_0) then
				local var_127_3 = (arg_124_1.time_ - var_127_1) / var_127_2

				if arg_124_1.var_.characterEffect1089ui_story and not isNil(var_127_0) then
					arg_124_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= var_127_1 + var_127_2 and arg_124_1.time_ < var_127_1 + var_127_2 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1089ui_story then
				arg_124_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_127_4 = 0

			if var_127_4 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_127_5 = 0

			if var_127_5 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 then
				arg_124_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action3_1")
			end

			local var_127_6 = 0
			local var_127_7 = 0.825

			if var_127_6 < arg_124_1.time_ and arg_124_1.time_ <= var_127_6 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				local var_127_8 = arg_124_1:FormatText(StoryNameCfg[1031].name)

				arg_124_1.leftNameTxt_.text = var_127_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_9 = arg_124_1:GetWordFromCfg(322072029)
				local var_127_10 = arg_124_1:FormatText(var_127_9.content)

				arg_124_1.text_.text = var_127_10

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_11 = 33
				local var_127_12 = utf8.len(var_127_10)
				local var_127_13 = var_127_11 <= 0 and var_127_7 or var_127_7 * (var_127_12 / var_127_11)

				if var_127_13 > 0 and var_127_7 < var_127_13 then
					arg_124_1.talkMaxDuration = var_127_13

					if var_127_13 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_13 + var_127_6
					end
				end

				arg_124_1.text_.text = var_127_10
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072029", "story_v_out_322072.awb") ~= 0 then
					local var_127_14 = manager.audio:GetVoiceLength("story_v_out_322072", "322072029", "story_v_out_322072.awb") / 1000

					if var_127_14 + var_127_6 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_14 + var_127_6
					end

					if var_127_9.prefab_name ~= "" and arg_124_1.actors_[var_127_9.prefab_name] ~= nil then
						local var_127_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_9.prefab_name].transform, "story_v_out_322072", "322072029", "story_v_out_322072.awb")

						arg_124_1:RecordAudio("322072029", var_127_15)
						arg_124_1:RecordAudio("322072029", var_127_15)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_322072", "322072029", "story_v_out_322072.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_322072", "322072029", "story_v_out_322072.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_7, arg_124_1.talkMaxDuration)

			if var_127_6 <= arg_124_1.time_ and arg_124_1.time_ < var_127_6 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_6) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_6 + var_127_16 and arg_124_1.time_ < var_127_6 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play322072030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 322072030
		arg_128_1.duration_ = 8.3

		local var_128_0 = {
			zh = 8.3,
			ja = 7.833
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
				arg_128_0:Play322072031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			local var_131_0 = 0

			if var_131_0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_0 + arg_131_0 then
				arg_128_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action437")
			end

			local var_131_1 = 0
			local var_131_2 = 1.05

			if var_131_1 < arg_128_1.time_ and arg_128_1.time_ <= var_131_1 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				local var_131_3 = arg_128_1:FormatText(StoryNameCfg[1031].name)

				arg_128_1.leftNameTxt_.text = var_131_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_4 = arg_128_1:GetWordFromCfg(322072030)
				local var_131_5 = arg_128_1:FormatText(var_131_4.content)

				arg_128_1.text_.text = var_131_5

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_6 = 42
				local var_131_7 = utf8.len(var_131_5)
				local var_131_8 = var_131_6 <= 0 and var_131_2 or var_131_2 * (var_131_7 / var_131_6)

				if var_131_8 > 0 and var_131_2 < var_131_8 then
					arg_128_1.talkMaxDuration = var_131_8

					if var_131_8 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_1
					end
				end

				arg_128_1.text_.text = var_131_5
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072030", "story_v_out_322072.awb") ~= 0 then
					local var_131_9 = manager.audio:GetVoiceLength("story_v_out_322072", "322072030", "story_v_out_322072.awb") / 1000

					if var_131_9 + var_131_1 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_1
					end

					if var_131_4.prefab_name ~= "" and arg_128_1.actors_[var_131_4.prefab_name] ~= nil then
						local var_131_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_4.prefab_name].transform, "story_v_out_322072", "322072030", "story_v_out_322072.awb")

						arg_128_1:RecordAudio("322072030", var_131_10)
						arg_128_1:RecordAudio("322072030", var_131_10)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_322072", "322072030", "story_v_out_322072.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_322072", "322072030", "story_v_out_322072.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_11 = math.max(var_131_2, arg_128_1.talkMaxDuration)

			if var_131_1 <= arg_128_1.time_ and arg_128_1.time_ < var_131_1 + var_131_11 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_1) / var_131_11

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_1 + var_131_11 and arg_128_1.time_ < var_131_1 + var_131_11 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play322072031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 322072031
		arg_132_1.duration_ = 4.07

		local var_132_0 = {
			zh = 4.066,
			ja = 3.1
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
				arg_132_0:Play322072032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = arg_132_1.actors_["1089ui_story"]
			local var_135_1 = 0

			if var_135_1 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1089ui_story == nil then
				arg_132_1.var_.characterEffect1089ui_story = var_135_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_2 and not isNil(var_135_0) then
				local var_135_3 = (arg_132_1.time_ - var_135_1) / var_135_2

				if arg_132_1.var_.characterEffect1089ui_story and not isNil(var_135_0) then
					local var_135_4 = Mathf.Lerp(0, 0.5, var_135_3)

					arg_132_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1089ui_story.fillRatio = var_135_4
				end
			end

			if arg_132_1.time_ >= var_135_1 + var_135_2 and arg_132_1.time_ < var_135_1 + var_135_2 + arg_135_0 and not isNil(var_135_0) and arg_132_1.var_.characterEffect1089ui_story then
				local var_135_5 = 0.5

				arg_132_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1089ui_story.fillRatio = var_135_5
			end

			local var_135_6 = 0
			local var_135_7 = 0.45

			if var_135_6 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				local var_135_8 = arg_132_1:FormatText(StoryNameCfg[1214].name)

				arg_132_1.leftNameTxt_.text = var_135_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_132_1.callingController_:SetSelectedState("calling")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_9 = arg_132_1:GetWordFromCfg(322072031)
				local var_135_10 = arg_132_1:FormatText(var_135_9.content)

				arg_132_1.text_.text = var_135_10

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_11 = 18
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

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072031", "story_v_out_322072.awb") ~= 0 then
					local var_135_14 = manager.audio:GetVoiceLength("story_v_out_322072", "322072031", "story_v_out_322072.awb") / 1000

					if var_135_14 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_14 + var_135_6
					end

					if var_135_9.prefab_name ~= "" and arg_132_1.actors_[var_135_9.prefab_name] ~= nil then
						local var_135_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_9.prefab_name].transform, "story_v_out_322072", "322072031", "story_v_out_322072.awb")

						arg_132_1:RecordAudio("322072031", var_135_15)
						arg_132_1:RecordAudio("322072031", var_135_15)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_322072", "322072031", "story_v_out_322072.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_322072", "322072031", "story_v_out_322072.awb")
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
	Play322072032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 322072032
		arg_136_1.duration_ = 11.4

		local var_136_0 = {
			zh = 8.866,
			ja = 11.4
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
				arg_136_0:Play322072033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = arg_136_1.actors_["1089ui_story"].transform
			local var_139_1 = 0

			if var_139_1 < arg_136_1.time_ and arg_136_1.time_ <= var_139_1 + arg_139_0 then
				arg_136_1.var_.moveOldPos1089ui_story = var_139_0.localPosition
			end

			local var_139_2 = 0.001

			if var_139_1 <= arg_136_1.time_ and arg_136_1.time_ < var_139_1 + var_139_2 then
				local var_139_3 = (arg_136_1.time_ - var_139_1) / var_139_2
				local var_139_4 = Vector3.New(0, -1.1, -6.17)

				var_139_0.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1089ui_story, var_139_4, var_139_3)

				local var_139_5 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_5.x, var_139_5.y, var_139_5.z)

				local var_139_6 = var_139_0.localEulerAngles

				var_139_6.z = 0
				var_139_6.x = 0
				var_139_0.localEulerAngles = var_139_6
			end

			if arg_136_1.time_ >= var_139_1 + var_139_2 and arg_136_1.time_ < var_139_1 + var_139_2 + arg_139_0 then
				var_139_0.localPosition = Vector3.New(0, -1.1, -6.17)

				local var_139_7 = manager.ui.mainCamera.transform.position - var_139_0.position

				var_139_0.forward = Vector3.New(var_139_7.x, var_139_7.y, var_139_7.z)

				local var_139_8 = var_139_0.localEulerAngles

				var_139_8.z = 0
				var_139_8.x = 0
				var_139_0.localEulerAngles = var_139_8
			end

			local var_139_9 = arg_136_1.actors_["1089ui_story"]
			local var_139_10 = 0

			if var_139_10 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect1089ui_story == nil then
				arg_136_1.var_.characterEffect1089ui_story = var_139_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_11 = 0.200000002980232

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_11 and not isNil(var_139_9) then
				local var_139_12 = (arg_136_1.time_ - var_139_10) / var_139_11

				if arg_136_1.var_.characterEffect1089ui_story and not isNil(var_139_9) then
					arg_136_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= var_139_10 + var_139_11 and arg_136_1.time_ < var_139_10 + var_139_11 + arg_139_0 and not isNil(var_139_9) and arg_136_1.var_.characterEffect1089ui_story then
				arg_136_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_139_13 = 0

			if var_139_13 < arg_136_1.time_ and arg_136_1.time_ <= var_139_13 + arg_139_0 then
				arg_136_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089actionlink/1089action474")
			end

			local var_139_14 = 0

			if var_139_14 < arg_136_1.time_ and arg_136_1.time_ <= var_139_14 + arg_139_0 then
				arg_136_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_139_15 = 0

			if var_139_15 < arg_136_1.time_ and arg_136_1.time_ <= var_139_15 + arg_139_0 then
				arg_136_1.allBtn_.enabled = false
			end

			local var_139_16 = 2

			if arg_136_1.time_ >= var_139_15 + var_139_16 and arg_136_1.time_ < var_139_15 + var_139_16 + arg_139_0 then
				arg_136_1.allBtn_.enabled = true
			end

			local var_139_17 = 0
			local var_139_18 = 0.95

			if var_139_17 < arg_136_1.time_ and arg_136_1.time_ <= var_139_17 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				local var_139_19 = arg_136_1:FormatText(StoryNameCfg[1031].name)

				arg_136_1.leftNameTxt_.text = var_139_19

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_20 = arg_136_1:GetWordFromCfg(322072032)
				local var_139_21 = arg_136_1:FormatText(var_139_20.content)

				arg_136_1.text_.text = var_139_21

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_22 = 38
				local var_139_23 = utf8.len(var_139_21)
				local var_139_24 = var_139_22 <= 0 and var_139_18 or var_139_18 * (var_139_23 / var_139_22)

				if var_139_24 > 0 and var_139_18 < var_139_24 then
					arg_136_1.talkMaxDuration = var_139_24

					if var_139_24 + var_139_17 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_24 + var_139_17
					end
				end

				arg_136_1.text_.text = var_139_21
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072032", "story_v_out_322072.awb") ~= 0 then
					local var_139_25 = manager.audio:GetVoiceLength("story_v_out_322072", "322072032", "story_v_out_322072.awb") / 1000

					if var_139_25 + var_139_17 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_25 + var_139_17
					end

					if var_139_20.prefab_name ~= "" and arg_136_1.actors_[var_139_20.prefab_name] ~= nil then
						local var_139_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_20.prefab_name].transform, "story_v_out_322072", "322072032", "story_v_out_322072.awb")

						arg_136_1:RecordAudio("322072032", var_139_26)
						arg_136_1:RecordAudio("322072032", var_139_26)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_322072", "322072032", "story_v_out_322072.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_322072", "322072032", "story_v_out_322072.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_27 = math.max(var_139_18, arg_136_1.talkMaxDuration)

			if var_139_17 <= arg_136_1.time_ and arg_136_1.time_ < var_139_17 + var_139_27 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_17) / var_139_27

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_17 + var_139_27 and arg_136_1.time_ < var_139_17 + var_139_27 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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

		arg_136_1:InitPlayNodeList()
	end,
	Play322072033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 322072033
		arg_140_1.duration_ = 4.73

		local var_140_0 = {
			zh = 4.2,
			ja = 4.733
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
				arg_140_0:Play322072034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0

			if var_143_0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_0 + arg_143_0 then
				arg_140_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action4_2")
			end

			local var_143_1 = 0

			if var_143_1 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_143_2 = 0

			if var_143_2 < arg_140_1.time_ and arg_140_1.time_ <= var_143_2 + arg_143_0 then
				arg_140_1.allBtn_.enabled = false
			end

			local var_143_3 = 2

			if arg_140_1.time_ >= var_143_2 + var_143_3 and arg_140_1.time_ < var_143_2 + var_143_3 + arg_143_0 then
				arg_140_1.allBtn_.enabled = true
			end

			local var_143_4 = 0
			local var_143_5 = 0.5

			if var_143_4 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				local var_143_6 = arg_140_1:FormatText(StoryNameCfg[1031].name)

				arg_140_1.leftNameTxt_.text = var_143_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_7 = arg_140_1:GetWordFromCfg(322072033)
				local var_143_8 = arg_140_1:FormatText(var_143_7.content)

				arg_140_1.text_.text = var_143_8

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 20
				local var_143_10 = utf8.len(var_143_8)
				local var_143_11 = var_143_9 <= 0 and var_143_5 or var_143_5 * (var_143_10 / var_143_9)

				if var_143_11 > 0 and var_143_5 < var_143_11 then
					arg_140_1.talkMaxDuration = var_143_11

					if var_143_11 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_11 + var_143_4
					end
				end

				arg_140_1.text_.text = var_143_8
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072033", "story_v_out_322072.awb") ~= 0 then
					local var_143_12 = manager.audio:GetVoiceLength("story_v_out_322072", "322072033", "story_v_out_322072.awb") / 1000

					if var_143_12 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_12 + var_143_4
					end

					if var_143_7.prefab_name ~= "" and arg_140_1.actors_[var_143_7.prefab_name] ~= nil then
						local var_143_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_7.prefab_name].transform, "story_v_out_322072", "322072033", "story_v_out_322072.awb")

						arg_140_1:RecordAudio("322072033", var_143_13)
						arg_140_1:RecordAudio("322072033", var_143_13)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_322072", "322072033", "story_v_out_322072.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_322072", "322072033", "story_v_out_322072.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_14 = math.max(var_143_5, arg_140_1.talkMaxDuration)

			if var_143_4 <= arg_140_1.time_ and arg_140_1.time_ < var_143_4 + var_143_14 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_4) / var_143_14

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_4 + var_143_14 and arg_140_1.time_ < var_143_4 + var_143_14 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play322072034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 322072034
		arg_144_1.duration_ = 9.43

		local var_144_0 = {
			zh = 4.266,
			ja = 9.433
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
				arg_144_0:Play322072035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = arg_144_1.actors_["1089ui_story"]
			local var_147_1 = 0

			if var_147_1 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1089ui_story == nil then
				arg_144_1.var_.characterEffect1089ui_story = var_147_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_2 and not isNil(var_147_0) then
				local var_147_3 = (arg_144_1.time_ - var_147_1) / var_147_2

				if arg_144_1.var_.characterEffect1089ui_story and not isNil(var_147_0) then
					local var_147_4 = Mathf.Lerp(0, 0.5, var_147_3)

					arg_144_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1089ui_story.fillRatio = var_147_4
				end
			end

			if arg_144_1.time_ >= var_147_1 + var_147_2 and arg_144_1.time_ < var_147_1 + var_147_2 + arg_147_0 and not isNil(var_147_0) and arg_144_1.var_.characterEffect1089ui_story then
				local var_147_5 = 0.5

				arg_144_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1089ui_story.fillRatio = var_147_5
			end

			local var_147_6 = 0
			local var_147_7 = 0.425

			if var_147_6 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				local var_147_8 = arg_144_1:FormatText(StoryNameCfg[1214].name)

				arg_144_1.leftNameTxt_.text = var_147_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10103")

				arg_144_1.callingController_:SetSelectedState("calling")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_9 = arg_144_1:GetWordFromCfg(322072034)
				local var_147_10 = arg_144_1:FormatText(var_147_9.content)

				arg_144_1.text_.text = var_147_10

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_11 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072034", "story_v_out_322072.awb") ~= 0 then
					local var_147_14 = manager.audio:GetVoiceLength("story_v_out_322072", "322072034", "story_v_out_322072.awb") / 1000

					if var_147_14 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_14 + var_147_6
					end

					if var_147_9.prefab_name ~= "" and arg_144_1.actors_[var_147_9.prefab_name] ~= nil then
						local var_147_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_9.prefab_name].transform, "story_v_out_322072", "322072034", "story_v_out_322072.awb")

						arg_144_1:RecordAudio("322072034", var_147_15)
						arg_144_1:RecordAudio("322072034", var_147_15)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_322072", "322072034", "story_v_out_322072.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_322072", "322072034", "story_v_out_322072.awb")
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
	Play322072035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 322072035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play322072036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = arg_148_1.actors_["1089ui_story"].transform
			local var_151_1 = 0

			if var_151_1 < arg_148_1.time_ and arg_148_1.time_ <= var_151_1 + arg_151_0 then
				arg_148_1.var_.moveOldPos1089ui_story = var_151_0.localPosition
			end

			local var_151_2 = 0.001

			if var_151_1 <= arg_148_1.time_ and arg_148_1.time_ < var_151_1 + var_151_2 then
				local var_151_3 = (arg_148_1.time_ - var_151_1) / var_151_2
				local var_151_4 = Vector3.New(0, 100, 0)

				var_151_0.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1089ui_story, var_151_4, var_151_3)

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

			local var_151_9 = 0.4
			local var_151_10 = 1

			if var_151_9 < arg_148_1.time_ and arg_148_1.time_ <= var_151_9 + arg_151_0 then
				local var_151_11 = "play"
				local var_151_12 = "effect"

				arg_148_1:AudioAction(var_151_11, var_151_12, "se_story_144", "se_story_144_door_open", "")
			end

			local var_151_13 = 1
			local var_151_14 = 1

			if var_151_13 < arg_148_1.time_ and arg_148_1.time_ <= var_151_13 + arg_151_0 then
				local var_151_15 = "play"
				local var_151_16 = "effect"

				arg_148_1:AudioAction(var_151_15, var_151_16, "se_story_144", "se_story_144_foley_gun02", "")
			end

			local var_151_17 = 0
			local var_151_18 = 1.4

			if var_151_17 < arg_148_1.time_ and arg_148_1.time_ <= var_151_17 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_19 = arg_148_1:GetWordFromCfg(322072035)
				local var_151_20 = arg_148_1:FormatText(var_151_19.content)

				arg_148_1.text_.text = var_151_20

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_21 = 56
				local var_151_22 = utf8.len(var_151_20)
				local var_151_23 = var_151_21 <= 0 and var_151_18 or var_151_18 * (var_151_22 / var_151_21)

				if var_151_23 > 0 and var_151_18 < var_151_23 then
					arg_148_1.talkMaxDuration = var_151_23

					if var_151_23 + var_151_17 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_23 + var_151_17
					end
				end

				arg_148_1.text_.text = var_151_20
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_24 = math.max(var_151_18, arg_148_1.talkMaxDuration)

			if var_151_17 <= arg_148_1.time_ and arg_148_1.time_ < var_151_17 + var_151_24 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_17) / var_151_24

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_17 + var_151_24 and arg_148_1.time_ < var_151_17 + var_151_24 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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

		arg_148_1:InitPlayNodeList()
	end,
	Play322072036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 322072036
		arg_152_1.duration_ = 4.03

		local var_152_0 = {
			zh = 2.7,
			ja = 4.033
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
				arg_152_0:Play322072037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = arg_152_1.actors_["10103ui_story"].transform
			local var_155_1 = 0

			if var_155_1 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.var_.moveOldPos10103ui_story = var_155_0.localPosition

				local var_155_2 = GameObjectTools.GetOrAddComponent(var_155_0.gameObject, typeof(DynamicBoneHelper))

				if var_155_2 then
					var_155_2:EnableDynamicBone(false)
				end
			end

			local var_155_3 = 0.001

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_3 then
				local var_155_4 = (arg_152_1.time_ - var_155_1) / var_155_3
				local var_155_5 = Vector3.New(-0.7, -0.95, -6.2)

				var_155_0.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos10103ui_story, var_155_5, var_155_4)

				local var_155_6 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_6.x, var_155_6.y, var_155_6.z)

				local var_155_7 = var_155_0.localEulerAngles

				var_155_7.z = 0
				var_155_7.x = 0
				var_155_0.localEulerAngles = var_155_7
			end

			if arg_152_1.time_ >= var_155_1 + var_155_3 and arg_152_1.time_ < var_155_1 + var_155_3 + arg_155_0 then
				var_155_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_155_8 = manager.ui.mainCamera.transform.position - var_155_0.position

				var_155_0.forward = Vector3.New(var_155_8.x, var_155_8.y, var_155_8.z)

				local var_155_9 = var_155_0.localEulerAngles

				var_155_9.z = 0
				var_155_9.x = 0
				var_155_0.localEulerAngles = var_155_9

				local var_155_10 = GameObjectTools.GetOrAddComponent(var_155_0.gameObject, typeof(DynamicBoneHelper))

				if var_155_10 then
					var_155_10:EnableDynamicBone(true)
				end
			end

			local var_155_11 = arg_152_1.actors_["10103ui_story"]
			local var_155_12 = 0

			if var_155_12 < arg_152_1.time_ and arg_152_1.time_ <= var_155_12 + arg_155_0 and not isNil(var_155_11) and arg_152_1.var_.characterEffect10103ui_story == nil then
				arg_152_1.var_.characterEffect10103ui_story = var_155_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_13 = 0.200000002980232

			if var_155_12 <= arg_152_1.time_ and arg_152_1.time_ < var_155_12 + var_155_13 and not isNil(var_155_11) then
				local var_155_14 = (arg_152_1.time_ - var_155_12) / var_155_13

				if arg_152_1.var_.characterEffect10103ui_story and not isNil(var_155_11) then
					arg_152_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= var_155_12 + var_155_13 and arg_152_1.time_ < var_155_12 + var_155_13 + arg_155_0 and not isNil(var_155_11) and arg_152_1.var_.characterEffect10103ui_story then
				arg_152_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_155_15 = 0

			if var_155_15 < arg_152_1.time_ and arg_152_1.time_ <= var_155_15 + arg_155_0 then
				arg_152_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			local var_155_16 = 0

			if var_155_16 < arg_152_1.time_ and arg_152_1.time_ <= var_155_16 + arg_155_0 then
				arg_152_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_155_17 = 0

			if var_155_17 < arg_152_1.time_ and arg_152_1.time_ <= var_155_17 + arg_155_0 then
				local var_155_18 = arg_152_1.actors_["10103ui_story"]

				if not isNil(var_155_18) then
					local var_155_19 = GameObjectTools.GetOrAddComponent(var_155_18, typeof(DynamicBoneHelper))

					if var_155_19 then
						var_155_19:EnableDynamicBone(true)
					end
				end
			end

			local var_155_20 = 0
			local var_155_21 = 0.075

			if var_155_20 < arg_152_1.time_ and arg_152_1.time_ <= var_155_20 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				local var_155_22 = arg_152_1:FormatText(StoryNameCfg[1214].name)

				arg_152_1.leftNameTxt_.text = var_155_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_23 = arg_152_1:GetWordFromCfg(322072036)
				local var_155_24 = arg_152_1:FormatText(var_155_23.content)

				arg_152_1.text_.text = var_155_24

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_25 = 3
				local var_155_26 = utf8.len(var_155_24)
				local var_155_27 = var_155_25 <= 0 and var_155_21 or var_155_21 * (var_155_26 / var_155_25)

				if var_155_27 > 0 and var_155_21 < var_155_27 then
					arg_152_1.talkMaxDuration = var_155_27

					if var_155_27 + var_155_20 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_27 + var_155_20
					end
				end

				arg_152_1.text_.text = var_155_24
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072036", "story_v_out_322072.awb") ~= 0 then
					local var_155_28 = manager.audio:GetVoiceLength("story_v_out_322072", "322072036", "story_v_out_322072.awb") / 1000

					if var_155_28 + var_155_20 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_28 + var_155_20
					end

					if var_155_23.prefab_name ~= "" and arg_152_1.actors_[var_155_23.prefab_name] ~= nil then
						local var_155_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_23.prefab_name].transform, "story_v_out_322072", "322072036", "story_v_out_322072.awb")

						arg_152_1:RecordAudio("322072036", var_155_29)
						arg_152_1:RecordAudio("322072036", var_155_29)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_322072", "322072036", "story_v_out_322072.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_322072", "322072036", "story_v_out_322072.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_30 = math.max(var_155_21, arg_152_1.talkMaxDuration)

			if var_155_20 <= arg_152_1.time_ and arg_152_1.time_ < var_155_20 + var_155_30 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_20) / var_155_30

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_20 + var_155_30 and arg_152_1.time_ < var_155_20 + var_155_30 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play322072037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 322072037
		arg_156_1.duration_ = 8.4

		local var_156_0 = {
			zh = 6.233,
			ja = 8.4
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
				arg_156_0:Play322072038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = arg_156_1.actors_["1089ui_story"].transform
			local var_159_1 = 0

			if var_159_1 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.var_.moveOldPos1089ui_story = var_159_0.localPosition
			end

			local var_159_2 = 0.001

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_2 then
				local var_159_3 = (arg_156_1.time_ - var_159_1) / var_159_2
				local var_159_4 = Vector3.New(0.7, -1.1, -6.17)

				var_159_0.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1089ui_story, var_159_4, var_159_3)

				local var_159_5 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_5.x, var_159_5.y, var_159_5.z)

				local var_159_6 = var_159_0.localEulerAngles

				var_159_6.z = 0
				var_159_6.x = 0
				var_159_0.localEulerAngles = var_159_6
			end

			if arg_156_1.time_ >= var_159_1 + var_159_2 and arg_156_1.time_ < var_159_1 + var_159_2 + arg_159_0 then
				var_159_0.localPosition = Vector3.New(0.7, -1.1, -6.17)

				local var_159_7 = manager.ui.mainCamera.transform.position - var_159_0.position

				var_159_0.forward = Vector3.New(var_159_7.x, var_159_7.y, var_159_7.z)

				local var_159_8 = var_159_0.localEulerAngles

				var_159_8.z = 0
				var_159_8.x = 0
				var_159_0.localEulerAngles = var_159_8
			end

			local var_159_9 = arg_156_1.actors_["1089ui_story"]
			local var_159_10 = 0

			if var_159_10 < arg_156_1.time_ and arg_156_1.time_ <= var_159_10 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1089ui_story == nil then
				arg_156_1.var_.characterEffect1089ui_story = var_159_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_11 = 0.200000002980232

			if var_159_10 <= arg_156_1.time_ and arg_156_1.time_ < var_159_10 + var_159_11 and not isNil(var_159_9) then
				local var_159_12 = (arg_156_1.time_ - var_159_10) / var_159_11

				if arg_156_1.var_.characterEffect1089ui_story and not isNil(var_159_9) then
					arg_156_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= var_159_10 + var_159_11 and arg_156_1.time_ < var_159_10 + var_159_11 + arg_159_0 and not isNil(var_159_9) and arg_156_1.var_.characterEffect1089ui_story then
				arg_156_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_159_13 = arg_156_1.actors_["10103ui_story"]
			local var_159_14 = 0

			if var_159_14 < arg_156_1.time_ and arg_156_1.time_ <= var_159_14 + arg_159_0 and not isNil(var_159_13) and arg_156_1.var_.characterEffect10103ui_story == nil then
				arg_156_1.var_.characterEffect10103ui_story = var_159_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_15 = 0.200000002980232

			if var_159_14 <= arg_156_1.time_ and arg_156_1.time_ < var_159_14 + var_159_15 and not isNil(var_159_13) then
				local var_159_16 = (arg_156_1.time_ - var_159_14) / var_159_15

				if arg_156_1.var_.characterEffect10103ui_story and not isNil(var_159_13) then
					local var_159_17 = Mathf.Lerp(0, 0.5, var_159_16)

					arg_156_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_156_1.var_.characterEffect10103ui_story.fillRatio = var_159_17
				end
			end

			if arg_156_1.time_ >= var_159_14 + var_159_15 and arg_156_1.time_ < var_159_14 + var_159_15 + arg_159_0 and not isNil(var_159_13) and arg_156_1.var_.characterEffect10103ui_story then
				local var_159_18 = 0.5

				arg_156_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_156_1.var_.characterEffect10103ui_story.fillRatio = var_159_18
			end

			local var_159_19 = 0

			if var_159_19 < arg_156_1.time_ and arg_156_1.time_ <= var_159_19 + arg_159_0 then
				arg_156_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			local var_159_20 = 0

			if var_159_20 < arg_156_1.time_ and arg_156_1.time_ <= var_159_20 + arg_159_0 then
				arg_156_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_159_21 = 0
			local var_159_22 = 0.55

			if var_159_21 < arg_156_1.time_ and arg_156_1.time_ <= var_159_21 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				local var_159_23 = arg_156_1:FormatText(StoryNameCfg[1031].name)

				arg_156_1.leftNameTxt_.text = var_159_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_24 = arg_156_1:GetWordFromCfg(322072037)
				local var_159_25 = arg_156_1:FormatText(var_159_24.content)

				arg_156_1.text_.text = var_159_25

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_26 = 22
				local var_159_27 = utf8.len(var_159_25)
				local var_159_28 = var_159_26 <= 0 and var_159_22 or var_159_22 * (var_159_27 / var_159_26)

				if var_159_28 > 0 and var_159_22 < var_159_28 then
					arg_156_1.talkMaxDuration = var_159_28

					if var_159_28 + var_159_21 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_28 + var_159_21
					end
				end

				arg_156_1.text_.text = var_159_25
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072037", "story_v_out_322072.awb") ~= 0 then
					local var_159_29 = manager.audio:GetVoiceLength("story_v_out_322072", "322072037", "story_v_out_322072.awb") / 1000

					if var_159_29 + var_159_21 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_29 + var_159_21
					end

					if var_159_24.prefab_name ~= "" and arg_156_1.actors_[var_159_24.prefab_name] ~= nil then
						local var_159_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_24.prefab_name].transform, "story_v_out_322072", "322072037", "story_v_out_322072.awb")

						arg_156_1:RecordAudio("322072037", var_159_30)
						arg_156_1:RecordAudio("322072037", var_159_30)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_322072", "322072037", "story_v_out_322072.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_322072", "322072037", "story_v_out_322072.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_31 = math.max(var_159_22, arg_156_1.talkMaxDuration)

			if var_159_21 <= arg_156_1.time_ and arg_156_1.time_ < var_159_21 + var_159_31 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_21) / var_159_31

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_21 + var_159_31 and arg_156_1.time_ < var_159_21 + var_159_31 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
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

		arg_156_1:InitPlayNodeList()
	end,
	Play322072038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 322072038
		arg_160_1.duration_ = 13.9

		local var_160_0 = {
			zh = 8.8,
			ja = 13.9
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
				arg_160_0:Play322072039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = arg_160_1.actors_["10103ui_story"].transform
			local var_163_1 = 0

			if var_163_1 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.var_.moveOldPos10103ui_story = var_163_0.localPosition

				local var_163_2 = GameObjectTools.GetOrAddComponent(var_163_0.gameObject, typeof(DynamicBoneHelper))

				if var_163_2 then
					var_163_2:EnableDynamicBone(false)
				end
			end

			local var_163_3 = 0.001

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_3 then
				local var_163_4 = (arg_160_1.time_ - var_163_1) / var_163_3
				local var_163_5 = Vector3.New(-0.7, -0.95, -6.2)

				var_163_0.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos10103ui_story, var_163_5, var_163_4)

				local var_163_6 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_6.x, var_163_6.y, var_163_6.z)

				local var_163_7 = var_163_0.localEulerAngles

				var_163_7.z = 0
				var_163_7.x = 0
				var_163_0.localEulerAngles = var_163_7
			end

			if arg_160_1.time_ >= var_163_1 + var_163_3 and arg_160_1.time_ < var_163_1 + var_163_3 + arg_163_0 then
				var_163_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_163_8 = manager.ui.mainCamera.transform.position - var_163_0.position

				var_163_0.forward = Vector3.New(var_163_8.x, var_163_8.y, var_163_8.z)

				local var_163_9 = var_163_0.localEulerAngles

				var_163_9.z = 0
				var_163_9.x = 0
				var_163_0.localEulerAngles = var_163_9

				local var_163_10 = GameObjectTools.GetOrAddComponent(var_163_0.gameObject, typeof(DynamicBoneHelper))

				if var_163_10 then
					var_163_10:EnableDynamicBone(true)
				end
			end

			local var_163_11 = arg_160_1.actors_["10103ui_story"]
			local var_163_12 = 0

			if var_163_12 < arg_160_1.time_ and arg_160_1.time_ <= var_163_12 + arg_163_0 and not isNil(var_163_11) and arg_160_1.var_.characterEffect10103ui_story == nil then
				arg_160_1.var_.characterEffect10103ui_story = var_163_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_13 = 0.200000002980232

			if var_163_12 <= arg_160_1.time_ and arg_160_1.time_ < var_163_12 + var_163_13 and not isNil(var_163_11) then
				local var_163_14 = (arg_160_1.time_ - var_163_12) / var_163_13

				if arg_160_1.var_.characterEffect10103ui_story and not isNil(var_163_11) then
					arg_160_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= var_163_12 + var_163_13 and arg_160_1.time_ < var_163_12 + var_163_13 + arg_163_0 and not isNil(var_163_11) and arg_160_1.var_.characterEffect10103ui_story then
				arg_160_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_163_15 = arg_160_1.actors_["1089ui_story"]
			local var_163_16 = 0

			if var_163_16 < arg_160_1.time_ and arg_160_1.time_ <= var_163_16 + arg_163_0 and not isNil(var_163_15) and arg_160_1.var_.characterEffect1089ui_story == nil then
				arg_160_1.var_.characterEffect1089ui_story = var_163_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_17 = 0.200000002980232

			if var_163_16 <= arg_160_1.time_ and arg_160_1.time_ < var_163_16 + var_163_17 and not isNil(var_163_15) then
				local var_163_18 = (arg_160_1.time_ - var_163_16) / var_163_17

				if arg_160_1.var_.characterEffect1089ui_story and not isNil(var_163_15) then
					local var_163_19 = Mathf.Lerp(0, 0.5, var_163_18)

					arg_160_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1089ui_story.fillRatio = var_163_19
				end
			end

			if arg_160_1.time_ >= var_163_16 + var_163_17 and arg_160_1.time_ < var_163_16 + var_163_17 + arg_163_0 and not isNil(var_163_15) and arg_160_1.var_.characterEffect1089ui_story then
				local var_163_20 = 0.5

				arg_160_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1089ui_story.fillRatio = var_163_20
			end

			local var_163_21 = 0

			if var_163_21 < arg_160_1.time_ and arg_160_1.time_ <= var_163_21 + arg_163_0 then
				arg_160_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action4_1")
			end

			local var_163_22 = 0

			if var_163_22 < arg_160_1.time_ and arg_160_1.time_ <= var_163_22 + arg_163_0 then
				arg_160_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_163_23 = 0

			if var_163_23 < arg_160_1.time_ and arg_160_1.time_ <= var_163_23 + arg_163_0 then
				local var_163_24 = arg_160_1.actors_["10103ui_story"]

				if not isNil(var_163_24) then
					local var_163_25 = GameObjectTools.GetOrAddComponent(var_163_24, typeof(DynamicBoneHelper))

					if var_163_25 then
						var_163_25:EnableDynamicBone(true)
					end
				end
			end

			local var_163_26 = 0
			local var_163_27 = 1

			if var_163_26 < arg_160_1.time_ and arg_160_1.time_ <= var_163_26 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				local var_163_28 = arg_160_1:FormatText(StoryNameCfg[1214].name)

				arg_160_1.leftNameTxt_.text = var_163_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_29 = arg_160_1:GetWordFromCfg(322072038)
				local var_163_30 = arg_160_1:FormatText(var_163_29.content)

				arg_160_1.text_.text = var_163_30

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_31 = 40
				local var_163_32 = utf8.len(var_163_30)
				local var_163_33 = var_163_31 <= 0 and var_163_27 or var_163_27 * (var_163_32 / var_163_31)

				if var_163_33 > 0 and var_163_27 < var_163_33 then
					arg_160_1.talkMaxDuration = var_163_33

					if var_163_33 + var_163_26 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_33 + var_163_26
					end
				end

				arg_160_1.text_.text = var_163_30
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072038", "story_v_out_322072.awb") ~= 0 then
					local var_163_34 = manager.audio:GetVoiceLength("story_v_out_322072", "322072038", "story_v_out_322072.awb") / 1000

					if var_163_34 + var_163_26 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_34 + var_163_26
					end

					if var_163_29.prefab_name ~= "" and arg_160_1.actors_[var_163_29.prefab_name] ~= nil then
						local var_163_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_29.prefab_name].transform, "story_v_out_322072", "322072038", "story_v_out_322072.awb")

						arg_160_1:RecordAudio("322072038", var_163_35)
						arg_160_1:RecordAudio("322072038", var_163_35)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_322072", "322072038", "story_v_out_322072.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_322072", "322072038", "story_v_out_322072.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_36 = math.max(var_163_27, arg_160_1.talkMaxDuration)

			if var_163_26 <= arg_160_1.time_ and arg_160_1.time_ < var_163_26 + var_163_36 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_26) / var_163_36

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_26 + var_163_36 and arg_160_1.time_ < var_163_26 + var_163_36 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play322072039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 322072039
		arg_164_1.duration_ = 11.77

		local var_164_0 = {
			zh = 7.2,
			ja = 11.766
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
				arg_164_0:Play322072040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = "L15f"

			if arg_164_1.bgs_[var_167_0] == nil then
				local var_167_1 = Object.Instantiate(arg_164_1.paintGo_)

				var_167_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_167_0)
				var_167_1.name = var_167_0
				var_167_1.transform.parent = arg_164_1.stage_.transform
				var_167_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_164_1.bgs_[var_167_0] = var_167_1
			end

			local var_167_2 = 2

			if var_167_2 < arg_164_1.time_ and arg_164_1.time_ <= var_167_2 + arg_167_0 then
				local var_167_3 = manager.ui.mainCamera.transform.localPosition
				local var_167_4 = Vector3.New(0, 0, 10) + Vector3.New(var_167_3.x, var_167_3.y, 0)
				local var_167_5 = arg_164_1.bgs_.L15f

				var_167_5.transform.localPosition = var_167_4
				var_167_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_167_6 = var_167_5:GetComponent("SpriteRenderer")

				if var_167_6 and var_167_6.sprite then
					local var_167_7 = (var_167_5.transform.localPosition - var_167_3).z
					local var_167_8 = manager.ui.mainCameraCom_
					local var_167_9 = 2 * var_167_7 * Mathf.Tan(var_167_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_167_10 = var_167_9 * var_167_8.aspect
					local var_167_11 = var_167_6.sprite.bounds.size.x
					local var_167_12 = var_167_6.sprite.bounds.size.y
					local var_167_13 = var_167_10 / var_167_11
					local var_167_14 = var_167_9 / var_167_12
					local var_167_15 = var_167_14 < var_167_13 and var_167_13 or var_167_14

					var_167_5.transform.localScale = Vector3.New(var_167_15, var_167_15, 0)
				end

				for iter_167_0, iter_167_1 in pairs(arg_164_1.bgs_) do
					if iter_167_0 ~= "L15f" then
						iter_167_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_167_16 = 4

			if var_167_16 < arg_164_1.time_ and arg_164_1.time_ <= var_167_16 + arg_167_0 then
				arg_164_1.allBtn_.enabled = false
			end

			local var_167_17 = 0.3

			if arg_164_1.time_ >= var_167_16 + var_167_17 and arg_164_1.time_ < var_167_16 + var_167_17 + arg_167_0 then
				arg_164_1.allBtn_.enabled = true
			end

			local var_167_18 = 0

			if var_167_18 < arg_164_1.time_ and arg_164_1.time_ <= var_167_18 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_19 = 2

			if var_167_18 <= arg_164_1.time_ and arg_164_1.time_ < var_167_18 + var_167_19 then
				local var_167_20 = (arg_164_1.time_ - var_167_18) / var_167_19
				local var_167_21 = Color.New(0, 0, 0)

				var_167_21.a = Mathf.Lerp(0, 1, var_167_20)
				arg_164_1.mask_.color = var_167_21
			end

			if arg_164_1.time_ >= var_167_18 + var_167_19 and arg_164_1.time_ < var_167_18 + var_167_19 + arg_167_0 then
				local var_167_22 = Color.New(0, 0, 0)

				var_167_22.a = 1
				arg_164_1.mask_.color = var_167_22
			end

			local var_167_23 = 2

			if var_167_23 < arg_164_1.time_ and arg_164_1.time_ <= var_167_23 + arg_167_0 then
				arg_164_1.mask_.enabled = true
				arg_164_1.mask_.raycastTarget = true

				arg_164_1:SetGaussion(false)
			end

			local var_167_24 = 2

			if var_167_23 <= arg_164_1.time_ and arg_164_1.time_ < var_167_23 + var_167_24 then
				local var_167_25 = (arg_164_1.time_ - var_167_23) / var_167_24
				local var_167_26 = Color.New(0, 0, 0)

				var_167_26.a = Mathf.Lerp(1, 0, var_167_25)
				arg_164_1.mask_.color = var_167_26
			end

			if arg_164_1.time_ >= var_167_23 + var_167_24 and arg_164_1.time_ < var_167_23 + var_167_24 + arg_167_0 then
				local var_167_27 = Color.New(0, 0, 0)
				local var_167_28 = 0

				arg_164_1.mask_.enabled = false
				var_167_27.a = var_167_28
				arg_164_1.mask_.color = var_167_27
			end

			local var_167_29 = arg_164_1.actors_["10103ui_story"].transform
			local var_167_30 = 1.96599999815226

			if var_167_30 < arg_164_1.time_ and arg_164_1.time_ <= var_167_30 + arg_167_0 then
				arg_164_1.var_.moveOldPos10103ui_story = var_167_29.localPosition

				local var_167_31 = GameObjectTools.GetOrAddComponent(var_167_29.gameObject, typeof(DynamicBoneHelper))

				if var_167_31 then
					var_167_31:EnableDynamicBone(false)
				end
			end

			local var_167_32 = 0.001

			if var_167_30 <= arg_164_1.time_ and arg_164_1.time_ < var_167_30 + var_167_32 then
				local var_167_33 = (arg_164_1.time_ - var_167_30) / var_167_32
				local var_167_34 = Vector3.New(0, 100, 0)

				var_167_29.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10103ui_story, var_167_34, var_167_33)

				local var_167_35 = manager.ui.mainCamera.transform.position - var_167_29.position

				var_167_29.forward = Vector3.New(var_167_35.x, var_167_35.y, var_167_35.z)

				local var_167_36 = var_167_29.localEulerAngles

				var_167_36.z = 0
				var_167_36.x = 0
				var_167_29.localEulerAngles = var_167_36
			end

			if arg_164_1.time_ >= var_167_30 + var_167_32 and arg_164_1.time_ < var_167_30 + var_167_32 + arg_167_0 then
				var_167_29.localPosition = Vector3.New(0, 100, 0)

				local var_167_37 = manager.ui.mainCamera.transform.position - var_167_29.position

				var_167_29.forward = Vector3.New(var_167_37.x, var_167_37.y, var_167_37.z)

				local var_167_38 = var_167_29.localEulerAngles

				var_167_38.z = 0
				var_167_38.x = 0
				var_167_29.localEulerAngles = var_167_38

				local var_167_39 = GameObjectTools.GetOrAddComponent(var_167_29.gameObject, typeof(DynamicBoneHelper))

				if var_167_39 then
					var_167_39:EnableDynamicBone(true)
				end
			end

			local var_167_40 = arg_164_1.actors_["10103ui_story"].transform
			local var_167_41 = 3.8

			if var_167_41 < arg_164_1.time_ and arg_164_1.time_ <= var_167_41 + arg_167_0 then
				arg_164_1.var_.moveOldPos10103ui_story = var_167_40.localPosition

				local var_167_42 = GameObjectTools.GetOrAddComponent(var_167_40.gameObject, typeof(DynamicBoneHelper))

				if var_167_42 then
					var_167_42:EnableDynamicBone(false)
				end
			end

			local var_167_43 = 0.001

			if var_167_41 <= arg_164_1.time_ and arg_164_1.time_ < var_167_41 + var_167_43 then
				local var_167_44 = (arg_164_1.time_ - var_167_41) / var_167_43
				local var_167_45 = Vector3.New(0, -0.95, -6.2)

				var_167_40.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10103ui_story, var_167_45, var_167_44)

				local var_167_46 = manager.ui.mainCamera.transform.position - var_167_40.position

				var_167_40.forward = Vector3.New(var_167_46.x, var_167_46.y, var_167_46.z)

				local var_167_47 = var_167_40.localEulerAngles

				var_167_47.z = 0
				var_167_47.x = 0
				var_167_40.localEulerAngles = var_167_47
			end

			if arg_164_1.time_ >= var_167_41 + var_167_43 and arg_164_1.time_ < var_167_41 + var_167_43 + arg_167_0 then
				var_167_40.localPosition = Vector3.New(0, -0.95, -6.2)

				local var_167_48 = manager.ui.mainCamera.transform.position - var_167_40.position

				var_167_40.forward = Vector3.New(var_167_48.x, var_167_48.y, var_167_48.z)

				local var_167_49 = var_167_40.localEulerAngles

				var_167_49.z = 0
				var_167_49.x = 0
				var_167_40.localEulerAngles = var_167_49

				local var_167_50 = GameObjectTools.GetOrAddComponent(var_167_40.gameObject, typeof(DynamicBoneHelper))

				if var_167_50 then
					var_167_50:EnableDynamicBone(true)
				end
			end

			local var_167_51 = arg_164_1.actors_["1089ui_story"].transform
			local var_167_52 = 1.96599999815226

			if var_167_52 < arg_164_1.time_ and arg_164_1.time_ <= var_167_52 + arg_167_0 then
				arg_164_1.var_.moveOldPos1089ui_story = var_167_51.localPosition
			end

			local var_167_53 = 0.001

			if var_167_52 <= arg_164_1.time_ and arg_164_1.time_ < var_167_52 + var_167_53 then
				local var_167_54 = (arg_164_1.time_ - var_167_52) / var_167_53
				local var_167_55 = Vector3.New(0, 100, 0)

				var_167_51.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1089ui_story, var_167_55, var_167_54)

				local var_167_56 = manager.ui.mainCamera.transform.position - var_167_51.position

				var_167_51.forward = Vector3.New(var_167_56.x, var_167_56.y, var_167_56.z)

				local var_167_57 = var_167_51.localEulerAngles

				var_167_57.z = 0
				var_167_57.x = 0
				var_167_51.localEulerAngles = var_167_57
			end

			if arg_164_1.time_ >= var_167_52 + var_167_53 and arg_164_1.time_ < var_167_52 + var_167_53 + arg_167_0 then
				var_167_51.localPosition = Vector3.New(0, 100, 0)

				local var_167_58 = manager.ui.mainCamera.transform.position - var_167_51.position

				var_167_51.forward = Vector3.New(var_167_58.x, var_167_58.y, var_167_58.z)

				local var_167_59 = var_167_51.localEulerAngles

				var_167_59.z = 0
				var_167_59.x = 0
				var_167_51.localEulerAngles = var_167_59
			end

			local var_167_60 = arg_164_1.actors_["10103ui_story"]
			local var_167_61 = 3.8

			if var_167_61 < arg_164_1.time_ and arg_164_1.time_ <= var_167_61 + arg_167_0 and not isNil(var_167_60) and arg_164_1.var_.characterEffect10103ui_story == nil then
				arg_164_1.var_.characterEffect10103ui_story = var_167_60:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_62 = 0.2

			if var_167_61 <= arg_164_1.time_ and arg_164_1.time_ < var_167_61 + var_167_62 and not isNil(var_167_60) then
				local var_167_63 = (arg_164_1.time_ - var_167_61) / var_167_62

				if arg_164_1.var_.characterEffect10103ui_story and not isNil(var_167_60) then
					arg_164_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_61 + var_167_62 and arg_164_1.time_ < var_167_61 + var_167_62 + arg_167_0 and not isNil(var_167_60) and arg_164_1.var_.characterEffect10103ui_story then
				arg_164_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_167_64 = 3.8

			if var_167_64 < arg_164_1.time_ and arg_164_1.time_ <= var_167_64 + arg_167_0 then
				arg_164_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			local var_167_65 = 3.8

			if var_167_65 < arg_164_1.time_ and arg_164_1.time_ <= var_167_65 + arg_167_0 then
				arg_164_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_167_66 = 0.2
			local var_167_67 = 1

			if var_167_66 < arg_164_1.time_ and arg_164_1.time_ <= var_167_66 + arg_167_0 then
				local var_167_68 = "stop"
				local var_167_69 = "effect"

				arg_164_1:AudioAction(var_167_68, var_167_69, "se_story_141", "se_story_141_amb_street_night02", "")
			end

			local var_167_70 = 1.56666666666667
			local var_167_71 = 1

			if var_167_70 < arg_164_1.time_ and arg_164_1.time_ <= var_167_70 + arg_167_0 then
				local var_167_72 = "play"
				local var_167_73 = "effect"

				arg_164_1:AudioAction(var_167_72, var_167_73, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_167_74 = 1.96599999815226

			arg_164_1.isInRecall_ = false

			if var_167_74 < arg_164_1.time_ and arg_164_1.time_ <= var_167_74 + arg_167_0 then
				arg_164_1.screenFilterGo_:SetActive(true)

				arg_164_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_167_2, iter_167_3 in pairs(arg_164_1.actors_) do
					local var_167_75 = iter_167_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_167_4, iter_167_5 in ipairs(var_167_75) do
						if iter_167_5.color.r > 0.51 then
							iter_167_5.color = Color.New(1, 1, 1)
						else
							iter_167_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_167_76 = 0.0166666666666667

			if var_167_74 <= arg_164_1.time_ and arg_164_1.time_ < var_167_74 + var_167_76 then
				local var_167_77 = (arg_164_1.time_ - var_167_74) / var_167_76

				arg_164_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, var_167_77)
			end

			if arg_164_1.time_ >= var_167_74 + var_167_76 and arg_164_1.time_ < var_167_74 + var_167_76 + arg_167_0 then
				arg_164_1.screenFilterEffect_.weight = 1
			end

			local var_167_78 = 3.8

			if var_167_78 < arg_164_1.time_ and arg_164_1.time_ <= var_167_78 + arg_167_0 then
				local var_167_79 = arg_164_1.actors_["10103ui_story"]

				if not isNil(var_167_79) then
					local var_167_80 = GameObjectTools.GetOrAddComponent(var_167_79, typeof(DynamicBoneHelper))

					if var_167_80 then
						var_167_80:EnableDynamicBone(true)
					end
				end
			end

			if arg_164_1.frameCnt_ <= 1 then
				arg_164_1.dialog_:SetActive(false)
			end

			local var_167_81 = 4
			local var_167_82 = 0.425

			if var_167_81 < arg_164_1.time_ and arg_164_1.time_ <= var_167_81 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0

				arg_164_1.dialog_:SetActive(true)

				arg_164_1.dialogCg_.alpha = 0

				local var_167_83 = LeanTween.value(arg_164_1.dialog_, 0, 1, 0.3)

				var_167_83:setOnUpdate(LuaHelper.FloatAction(function(arg_168_0)
					arg_164_1.dialogCg_.alpha = arg_168_0
				end))
				var_167_83:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_164_1.dialog_)
					var_167_83:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_164_1.duration_ = arg_164_1.duration_ + 0.3

				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_84 = arg_164_1:FormatText(StoryNameCfg[1214].name)

				arg_164_1.leftNameTxt_.text = var_167_84

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_85 = arg_164_1:GetWordFromCfg(322072039)
				local var_167_86 = arg_164_1:FormatText(var_167_85.content)

				arg_164_1.text_.text = var_167_86

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_87 = 17
				local var_167_88 = utf8.len(var_167_86)
				local var_167_89 = var_167_87 <= 0 and var_167_82 or var_167_82 * (var_167_88 / var_167_87)

				if var_167_89 > 0 and var_167_82 < var_167_89 then
					arg_164_1.talkMaxDuration = var_167_89
					var_167_81 = var_167_81 + 0.3

					if var_167_89 + var_167_81 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_89 + var_167_81
					end
				end

				arg_164_1.text_.text = var_167_86
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072039", "story_v_out_322072.awb") ~= 0 then
					local var_167_90 = manager.audio:GetVoiceLength("story_v_out_322072", "322072039", "story_v_out_322072.awb") / 1000

					if var_167_90 + var_167_81 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_90 + var_167_81
					end

					if var_167_85.prefab_name ~= "" and arg_164_1.actors_[var_167_85.prefab_name] ~= nil then
						local var_167_91 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_85.prefab_name].transform, "story_v_out_322072", "322072039", "story_v_out_322072.awb")

						arg_164_1:RecordAudio("322072039", var_167_91)
						arg_164_1:RecordAudio("322072039", var_167_91)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_322072", "322072039", "story_v_out_322072.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_322072", "322072039", "story_v_out_322072.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_92 = var_167_81 + 0.3
			local var_167_93 = math.max(var_167_82, arg_164_1.talkMaxDuration)

			if var_167_92 <= arg_164_1.time_ and arg_164_1.time_ < var_167_92 + var_167_93 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_92) / var_167_93

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_92 + var_167_93 and arg_164_1.time_ < var_167_92 + var_167_93 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1089ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play322072040 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 322072040
		arg_170_1.duration_ = 5.87

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play322072041(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			local var_173_0 = arg_170_1.actors_["10103ui_story"].transform
			local var_173_1 = 0

			if var_173_1 < arg_170_1.time_ and arg_170_1.time_ <= var_173_1 + arg_173_0 then
				arg_170_1.var_.moveOldPos10103ui_story = var_173_0.localPosition

				local var_173_2 = GameObjectTools.GetOrAddComponent(var_173_0.gameObject, typeof(DynamicBoneHelper))

				if var_173_2 then
					var_173_2:EnableDynamicBone(false)
				end
			end

			local var_173_3 = 0.001

			if var_173_1 <= arg_170_1.time_ and arg_170_1.time_ < var_173_1 + var_173_3 then
				local var_173_4 = (arg_170_1.time_ - var_173_1) / var_173_3
				local var_173_5 = Vector3.New(0, 100, 0)

				var_173_0.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos10103ui_story, var_173_5, var_173_4)

				local var_173_6 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_6.x, var_173_6.y, var_173_6.z)

				local var_173_7 = var_173_0.localEulerAngles

				var_173_7.z = 0
				var_173_7.x = 0
				var_173_0.localEulerAngles = var_173_7
			end

			if arg_170_1.time_ >= var_173_1 + var_173_3 and arg_170_1.time_ < var_173_1 + var_173_3 + arg_173_0 then
				var_173_0.localPosition = Vector3.New(0, 100, 0)

				local var_173_8 = manager.ui.mainCamera.transform.position - var_173_0.position

				var_173_0.forward = Vector3.New(var_173_8.x, var_173_8.y, var_173_8.z)

				local var_173_9 = var_173_0.localEulerAngles

				var_173_9.z = 0
				var_173_9.x = 0
				var_173_0.localEulerAngles = var_173_9

				local var_173_10 = GameObjectTools.GetOrAddComponent(var_173_0.gameObject, typeof(DynamicBoneHelper))

				if var_173_10 then
					var_173_10:EnableDynamicBone(true)
				end
			end

			local var_173_11 = 0.200000002980232
			local var_173_12 = 1

			if var_173_11 < arg_170_1.time_ and arg_170_1.time_ <= var_173_11 + arg_173_0 then
				local var_173_13 = "play"
				local var_173_14 = "effect"

				arg_170_1:AudioAction(var_173_13, var_173_14, "se_story_1311", "se_story_1311_car02", "")
			end

			local var_173_15 = manager.ui.mainCamera.transform
			local var_173_16 = 0.200000002980232

			if var_173_16 < arg_170_1.time_ and arg_170_1.time_ <= var_173_16 + arg_173_0 then
				local var_173_17 = arg_170_1.var_.effect2040
				local var_173_18
				local var_173_19 = var_173_15

				if not var_173_17 then
					var_173_17 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian01_in_keep"), var_173_19)
					var_173_17.name = "2040"
					arg_170_1.var_.effect2040 = var_173_17
				else
					var_173_17.transform:SetParent(var_173_19)
				end

				var_173_17.transform.localPosition = Vector3.New(0, 0, -3.11)
				var_173_17.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_170_1.frameCnt_ <= 1 then
				arg_170_1.dialog_:SetActive(false)
			end

			local var_173_20 = 0.866666669646899
			local var_173_21 = 1.65

			if var_173_20 < arg_170_1.time_ and arg_170_1.time_ <= var_173_20 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0

				arg_170_1.dialog_:SetActive(true)

				arg_170_1.dialogCg_.alpha = 0

				local var_173_22 = LeanTween.value(arg_170_1.dialog_, 0, 1, 0.3)

				var_173_22:setOnUpdate(LuaHelper.FloatAction(function(arg_174_0)
					arg_170_1.dialogCg_.alpha = arg_174_0
				end))
				var_173_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_170_1.dialog_)
					var_173_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_170_1.duration_ = arg_170_1.duration_ + 0.3

				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_23 = arg_170_1:GetWordFromCfg(322072040)
				local var_173_24 = arg_170_1:FormatText(var_173_23.content)

				arg_170_1.text_.text = var_173_24

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_25 = 66
				local var_173_26 = utf8.len(var_173_24)
				local var_173_27 = var_173_25 <= 0 and var_173_21 or var_173_21 * (var_173_26 / var_173_25)

				if var_173_27 > 0 and var_173_21 < var_173_27 then
					arg_170_1.talkMaxDuration = var_173_27
					var_173_20 = var_173_20 + 0.3

					if var_173_27 + var_173_20 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_27 + var_173_20
					end
				end

				arg_170_1.text_.text = var_173_24
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_28 = var_173_20 + 0.3
			local var_173_29 = math.max(var_173_21, arg_170_1.talkMaxDuration)

			if var_173_28 <= arg_170_1.time_ and arg_170_1.time_ < var_173_28 + var_173_29 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_28) / var_173_29

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_28 + var_173_29 and arg_170_1.time_ < var_173_28 + var_173_29 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play322072041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 322072041
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play322072042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = manager.ui.mainCamera.transform
			local var_179_1 = 0

			if var_179_1 < arg_176_1.time_ and arg_176_1.time_ <= var_179_1 + arg_179_0 then
				local var_179_2 = arg_176_1.var_.effect2040

				if var_179_2 then
					Object.Destroy(var_179_2)

					arg_176_1.var_.effect2040 = nil
				end
			end

			local var_179_3 = 0
			local var_179_4 = 1.15

			if var_179_3 < arg_176_1.time_ and arg_176_1.time_ <= var_179_3 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_5 = arg_176_1:GetWordFromCfg(322072041)
				local var_179_6 = arg_176_1:FormatText(var_179_5.content)

				arg_176_1.text_.text = var_179_6

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_7 = 46
				local var_179_8 = utf8.len(var_179_6)
				local var_179_9 = var_179_7 <= 0 and var_179_4 or var_179_4 * (var_179_8 / var_179_7)

				if var_179_9 > 0 and var_179_4 < var_179_9 then
					arg_176_1.talkMaxDuration = var_179_9

					if var_179_9 + var_179_3 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_9 + var_179_3
					end
				end

				arg_176_1.text_.text = var_179_6
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_10 = math.max(var_179_4, arg_176_1.talkMaxDuration)

			if var_179_3 <= arg_176_1.time_ and arg_176_1.time_ < var_179_3 + var_179_10 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_3) / var_179_10

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_3 + var_179_10 and arg_176_1.time_ < var_179_3 + var_179_10 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play322072042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 322072042
		arg_180_1.duration_ = 11.33

		local var_180_0 = {
			zh = 7.766,
			ja = 11.333
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play322072043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = arg_180_1.actors_["10103ui_story"].transform
			local var_183_1 = 0

			if var_183_1 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.var_.moveOldPos10103ui_story = var_183_0.localPosition

				local var_183_2 = GameObjectTools.GetOrAddComponent(var_183_0.gameObject, typeof(DynamicBoneHelper))

				if var_183_2 then
					var_183_2:EnableDynamicBone(false)
				end
			end

			local var_183_3 = 0.001

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_3 then
				local var_183_4 = (arg_180_1.time_ - var_183_1) / var_183_3
				local var_183_5 = Vector3.New(0, -0.95, -6.2)

				var_183_0.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10103ui_story, var_183_5, var_183_4)

				local var_183_6 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_6.x, var_183_6.y, var_183_6.z)

				local var_183_7 = var_183_0.localEulerAngles

				var_183_7.z = 0
				var_183_7.x = 0
				var_183_0.localEulerAngles = var_183_7
			end

			if arg_180_1.time_ >= var_183_1 + var_183_3 and arg_180_1.time_ < var_183_1 + var_183_3 + arg_183_0 then
				var_183_0.localPosition = Vector3.New(0, -0.95, -6.2)

				local var_183_8 = manager.ui.mainCamera.transform.position - var_183_0.position

				var_183_0.forward = Vector3.New(var_183_8.x, var_183_8.y, var_183_8.z)

				local var_183_9 = var_183_0.localEulerAngles

				var_183_9.z = 0
				var_183_9.x = 0
				var_183_0.localEulerAngles = var_183_9

				local var_183_10 = GameObjectTools.GetOrAddComponent(var_183_0.gameObject, typeof(DynamicBoneHelper))

				if var_183_10 then
					var_183_10:EnableDynamicBone(true)
				end
			end

			local var_183_11 = arg_180_1.actors_["10103ui_story"]
			local var_183_12 = 0

			if var_183_12 < arg_180_1.time_ and arg_180_1.time_ <= var_183_12 + arg_183_0 and not isNil(var_183_11) and arg_180_1.var_.characterEffect10103ui_story == nil then
				arg_180_1.var_.characterEffect10103ui_story = var_183_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_13 = 0.2

			if var_183_12 <= arg_180_1.time_ and arg_180_1.time_ < var_183_12 + var_183_13 and not isNil(var_183_11) then
				local var_183_14 = (arg_180_1.time_ - var_183_12) / var_183_13

				if arg_180_1.var_.characterEffect10103ui_story and not isNil(var_183_11) then
					arg_180_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= var_183_12 + var_183_13 and arg_180_1.time_ < var_183_12 + var_183_13 + arg_183_0 and not isNil(var_183_11) and arg_180_1.var_.characterEffect10103ui_story then
				arg_180_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_183_15 = 0

			if var_183_15 < arg_180_1.time_ and arg_180_1.time_ <= var_183_15 + arg_183_0 then
				arg_180_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action9_1")
			end

			local var_183_16 = 0

			if var_183_16 < arg_180_1.time_ and arg_180_1.time_ <= var_183_16 + arg_183_0 then
				arg_180_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_183_17 = 0

			if var_183_17 < arg_180_1.time_ and arg_180_1.time_ <= var_183_17 + arg_183_0 then
				local var_183_18 = arg_180_1.actors_["10103ui_story"]

				if not isNil(var_183_18) then
					local var_183_19 = GameObjectTools.GetOrAddComponent(var_183_18, typeof(DynamicBoneHelper))

					if var_183_19 then
						var_183_19:EnableDynamicBone(true)
					end
				end
			end

			local var_183_20 = 0
			local var_183_21 = 0.725

			if var_183_20 < arg_180_1.time_ and arg_180_1.time_ <= var_183_20 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				local var_183_22 = arg_180_1:FormatText(StoryNameCfg[1214].name)

				arg_180_1.leftNameTxt_.text = var_183_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_23 = arg_180_1:GetWordFromCfg(322072042)
				local var_183_24 = arg_180_1:FormatText(var_183_23.content)

				arg_180_1.text_.text = var_183_24

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_25 = 29
				local var_183_26 = utf8.len(var_183_24)
				local var_183_27 = var_183_25 <= 0 and var_183_21 or var_183_21 * (var_183_26 / var_183_25)

				if var_183_27 > 0 and var_183_21 < var_183_27 then
					arg_180_1.talkMaxDuration = var_183_27

					if var_183_27 + var_183_20 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_27 + var_183_20
					end
				end

				arg_180_1.text_.text = var_183_24
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072042", "story_v_out_322072.awb") ~= 0 then
					local var_183_28 = manager.audio:GetVoiceLength("story_v_out_322072", "322072042", "story_v_out_322072.awb") / 1000

					if var_183_28 + var_183_20 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_28 + var_183_20
					end

					if var_183_23.prefab_name ~= "" and arg_180_1.actors_[var_183_23.prefab_name] ~= nil then
						local var_183_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_23.prefab_name].transform, "story_v_out_322072", "322072042", "story_v_out_322072.awb")

						arg_180_1:RecordAudio("322072042", var_183_29)
						arg_180_1:RecordAudio("322072042", var_183_29)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_322072", "322072042", "story_v_out_322072.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_322072", "322072042", "story_v_out_322072.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_30 = math.max(var_183_21, arg_180_1.talkMaxDuration)

			if var_183_20 <= arg_180_1.time_ and arg_180_1.time_ < var_183_20 + var_183_30 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_20) / var_183_30

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_20 + var_183_30 and arg_180_1.time_ < var_183_20 + var_183_30 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play322072043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 322072043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play322072044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = arg_184_1.actors_["10103ui_story"].transform
			local var_187_1 = 0

			if var_187_1 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.var_.moveOldPos10103ui_story = var_187_0.localPosition

				local var_187_2 = GameObjectTools.GetOrAddComponent(var_187_0.gameObject, typeof(DynamicBoneHelper))

				if var_187_2 then
					var_187_2:EnableDynamicBone(false)
				end
			end

			local var_187_3 = 0.001

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_3 then
				local var_187_4 = (arg_184_1.time_ - var_187_1) / var_187_3
				local var_187_5 = Vector3.New(0, 100, 0)

				var_187_0.localPosition = Vector3.Lerp(arg_184_1.var_.moveOldPos10103ui_story, var_187_5, var_187_4)

				local var_187_6 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_6.x, var_187_6.y, var_187_6.z)

				local var_187_7 = var_187_0.localEulerAngles

				var_187_7.z = 0
				var_187_7.x = 0
				var_187_0.localEulerAngles = var_187_7
			end

			if arg_184_1.time_ >= var_187_1 + var_187_3 and arg_184_1.time_ < var_187_1 + var_187_3 + arg_187_0 then
				var_187_0.localPosition = Vector3.New(0, 100, 0)

				local var_187_8 = manager.ui.mainCamera.transform.position - var_187_0.position

				var_187_0.forward = Vector3.New(var_187_8.x, var_187_8.y, var_187_8.z)

				local var_187_9 = var_187_0.localEulerAngles

				var_187_9.z = 0
				var_187_9.x = 0
				var_187_0.localEulerAngles = var_187_9

				local var_187_10 = GameObjectTools.GetOrAddComponent(var_187_0.gameObject, typeof(DynamicBoneHelper))

				if var_187_10 then
					var_187_10:EnableDynamicBone(true)
				end
			end

			local var_187_11 = 0.466666666666
			local var_187_12 = 1

			if var_187_11 < arg_184_1.time_ and arg_184_1.time_ <= var_187_11 + arg_187_0 then
				local var_187_13 = "play"
				local var_187_14 = "effect"

				arg_184_1:AudioAction(var_187_13, var_187_14, "se_story_145", "se_story_145_sword", "")
			end

			local var_187_15 = 0
			local var_187_16 = 1.225

			if var_187_15 < arg_184_1.time_ and arg_184_1.time_ <= var_187_15 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, false)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_17 = arg_184_1:GetWordFromCfg(322072043)
				local var_187_18 = arg_184_1:FormatText(var_187_17.content)

				arg_184_1.text_.text = var_187_18

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_19 = 49
				local var_187_20 = utf8.len(var_187_18)
				local var_187_21 = var_187_19 <= 0 and var_187_16 or var_187_16 * (var_187_20 / var_187_19)

				if var_187_21 > 0 and var_187_16 < var_187_21 then
					arg_184_1.talkMaxDuration = var_187_21

					if var_187_21 + var_187_15 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_21 + var_187_15
					end
				end

				arg_184_1.text_.text = var_187_18
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_22 = math.max(var_187_16, arg_184_1.talkMaxDuration)

			if var_187_15 <= arg_184_1.time_ and arg_184_1.time_ < var_187_15 + var_187_22 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_15) / var_187_22

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_15 + var_187_22 and arg_184_1.time_ < var_187_15 + var_187_22 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_184_1:InitPlayNodeList()
	end,
	Play322072044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 322072044
		arg_188_1.duration_ = 5.3

		local var_188_0 = {
			zh = 1.999999999999,
			ja = 5.3
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play322072045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_0 = arg_188_1.actors_["10103ui_story"].transform
			local var_191_1 = 0

			if var_191_1 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.var_.moveOldPos10103ui_story = var_191_0.localPosition

				local var_191_2 = GameObjectTools.GetOrAddComponent(var_191_0.gameObject, typeof(DynamicBoneHelper))

				if var_191_2 then
					var_191_2:EnableDynamicBone(false)
				end
			end

			local var_191_3 = 0.001

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_3 then
				local var_191_4 = (arg_188_1.time_ - var_191_1) / var_191_3
				local var_191_5 = Vector3.New(0, -0.95, -6.2)

				var_191_0.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos10103ui_story, var_191_5, var_191_4)

				local var_191_6 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_6.x, var_191_6.y, var_191_6.z)

				local var_191_7 = var_191_0.localEulerAngles

				var_191_7.z = 0
				var_191_7.x = 0
				var_191_0.localEulerAngles = var_191_7
			end

			if arg_188_1.time_ >= var_191_1 + var_191_3 and arg_188_1.time_ < var_191_1 + var_191_3 + arg_191_0 then
				var_191_0.localPosition = Vector3.New(0, -0.95, -6.2)

				local var_191_8 = manager.ui.mainCamera.transform.position - var_191_0.position

				var_191_0.forward = Vector3.New(var_191_8.x, var_191_8.y, var_191_8.z)

				local var_191_9 = var_191_0.localEulerAngles

				var_191_9.z = 0
				var_191_9.x = 0
				var_191_0.localEulerAngles = var_191_9

				local var_191_10 = GameObjectTools.GetOrAddComponent(var_191_0.gameObject, typeof(DynamicBoneHelper))

				if var_191_10 then
					var_191_10:EnableDynamicBone(true)
				end
			end

			local var_191_11 = arg_188_1.actors_["10103ui_story"]
			local var_191_12 = 0

			if var_191_12 < arg_188_1.time_ and arg_188_1.time_ <= var_191_12 + arg_191_0 and not isNil(var_191_11) and arg_188_1.var_.characterEffect10103ui_story == nil then
				arg_188_1.var_.characterEffect10103ui_story = var_191_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_13 = 0.200000002980232

			if var_191_12 <= arg_188_1.time_ and arg_188_1.time_ < var_191_12 + var_191_13 and not isNil(var_191_11) then
				local var_191_14 = (arg_188_1.time_ - var_191_12) / var_191_13

				if arg_188_1.var_.characterEffect10103ui_story and not isNil(var_191_11) then
					arg_188_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= var_191_12 + var_191_13 and arg_188_1.time_ < var_191_12 + var_191_13 + arg_191_0 and not isNil(var_191_11) and arg_188_1.var_.characterEffect10103ui_story then
				arg_188_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_191_15 = 0

			if var_191_15 < arg_188_1.time_ and arg_188_1.time_ <= var_191_15 + arg_191_0 then
				arg_188_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action9_2")
			end

			local var_191_16 = 0

			if var_191_16 < arg_188_1.time_ and arg_188_1.time_ <= var_191_16 + arg_191_0 then
				arg_188_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_191_17 = 0

			if var_191_17 < arg_188_1.time_ and arg_188_1.time_ <= var_191_17 + arg_191_0 then
				local var_191_18 = arg_188_1.actors_["10103ui_story"]

				if not isNil(var_191_18) then
					local var_191_19 = GameObjectTools.GetOrAddComponent(var_191_18, typeof(DynamicBoneHelper))

					if var_191_19 then
						var_191_19:EnableDynamicBone(true)
					end
				end
			end

			local var_191_20 = 0
			local var_191_21 = 0.2

			if var_191_20 < arg_188_1.time_ and arg_188_1.time_ <= var_191_20 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				local var_191_22 = arg_188_1:FormatText(StoryNameCfg[1214].name)

				arg_188_1.leftNameTxt_.text = var_191_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_23 = arg_188_1:GetWordFromCfg(322072044)
				local var_191_24 = arg_188_1:FormatText(var_191_23.content)

				arg_188_1.text_.text = var_191_24

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_25 = 8
				local var_191_26 = utf8.len(var_191_24)
				local var_191_27 = var_191_25 <= 0 and var_191_21 or var_191_21 * (var_191_26 / var_191_25)

				if var_191_27 > 0 and var_191_21 < var_191_27 then
					arg_188_1.talkMaxDuration = var_191_27

					if var_191_27 + var_191_20 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_27 + var_191_20
					end
				end

				arg_188_1.text_.text = var_191_24
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072044", "story_v_out_322072.awb") ~= 0 then
					local var_191_28 = manager.audio:GetVoiceLength("story_v_out_322072", "322072044", "story_v_out_322072.awb") / 1000

					if var_191_28 + var_191_20 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_28 + var_191_20
					end

					if var_191_23.prefab_name ~= "" and arg_188_1.actors_[var_191_23.prefab_name] ~= nil then
						local var_191_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_23.prefab_name].transform, "story_v_out_322072", "322072044", "story_v_out_322072.awb")

						arg_188_1:RecordAudio("322072044", var_191_29)
						arg_188_1:RecordAudio("322072044", var_191_29)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_322072", "322072044", "story_v_out_322072.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_322072", "322072044", "story_v_out_322072.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_30 = math.max(var_191_21, arg_188_1.talkMaxDuration)

			if var_191_20 <= arg_188_1.time_ and arg_188_1.time_ < var_191_20 + var_191_30 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_20) / var_191_30

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_20 + var_191_30 and arg_188_1.time_ < var_191_20 + var_191_30 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
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
	Play322072045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 322072045
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play322072046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = arg_192_1.actors_["10103ui_story"].transform
			local var_195_1 = 0

			if var_195_1 < arg_192_1.time_ and arg_192_1.time_ <= var_195_1 + arg_195_0 then
				arg_192_1.var_.moveOldPos10103ui_story = var_195_0.localPosition

				local var_195_2 = GameObjectTools.GetOrAddComponent(var_195_0.gameObject, typeof(DynamicBoneHelper))

				if var_195_2 then
					var_195_2:EnableDynamicBone(false)
				end
			end

			local var_195_3 = 0.001

			if var_195_1 <= arg_192_1.time_ and arg_192_1.time_ < var_195_1 + var_195_3 then
				local var_195_4 = (arg_192_1.time_ - var_195_1) / var_195_3
				local var_195_5 = Vector3.New(0, 100, 0)

				var_195_0.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10103ui_story, var_195_5, var_195_4)

				local var_195_6 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_6.x, var_195_6.y, var_195_6.z)

				local var_195_7 = var_195_0.localEulerAngles

				var_195_7.z = 0
				var_195_7.x = 0
				var_195_0.localEulerAngles = var_195_7
			end

			if arg_192_1.time_ >= var_195_1 + var_195_3 and arg_192_1.time_ < var_195_1 + var_195_3 + arg_195_0 then
				var_195_0.localPosition = Vector3.New(0, 100, 0)

				local var_195_8 = manager.ui.mainCamera.transform.position - var_195_0.position

				var_195_0.forward = Vector3.New(var_195_8.x, var_195_8.y, var_195_8.z)

				local var_195_9 = var_195_0.localEulerAngles

				var_195_9.z = 0
				var_195_9.x = 0
				var_195_0.localEulerAngles = var_195_9

				local var_195_10 = GameObjectTools.GetOrAddComponent(var_195_0.gameObject, typeof(DynamicBoneHelper))

				if var_195_10 then
					var_195_10:EnableDynamicBone(true)
				end
			end

			local var_195_11 = 0.6
			local var_195_12 = 1

			if var_195_11 < arg_192_1.time_ and arg_192_1.time_ <= var_195_11 + arg_195_0 then
				local var_195_13 = "play"
				local var_195_14 = "effect"

				arg_192_1:AudioAction(var_195_13, var_195_14, "se_story_128", "se_story_128_metal", "")
			end

			local var_195_15 = 0
			local var_195_16 = 1.075

			if var_195_15 < arg_192_1.time_ and arg_192_1.time_ <= var_195_15 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_17 = arg_192_1:GetWordFromCfg(322072045)
				local var_195_18 = arg_192_1:FormatText(var_195_17.content)

				arg_192_1.text_.text = var_195_18

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_19 = 43
				local var_195_20 = utf8.len(var_195_18)
				local var_195_21 = var_195_19 <= 0 and var_195_16 or var_195_16 * (var_195_20 / var_195_19)

				if var_195_21 > 0 and var_195_16 < var_195_21 then
					arg_192_1.talkMaxDuration = var_195_21

					if var_195_21 + var_195_15 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_21 + var_195_15
					end
				end

				arg_192_1.text_.text = var_195_18
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_22 = math.max(var_195_16, arg_192_1.talkMaxDuration)

			if var_195_15 <= arg_192_1.time_ and arg_192_1.time_ < var_195_15 + var_195_22 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_15) / var_195_22

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_15 + var_195_22 and arg_192_1.time_ < var_195_15 + var_195_22 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play322072046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 322072046
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play322072047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0.2
			local var_199_1 = 1

			if var_199_0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_0 + arg_199_0 then
				local var_199_2 = "play"
				local var_199_3 = "effect"

				arg_196_1:AudioAction(var_199_2, var_199_3, "se_story_145", "se_story_145_fire02", "")
			end

			local var_199_4 = manager.ui.mainCamera.transform
			local var_199_5 = 0.2

			if var_199_5 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 then
				arg_196_1.var_.shakeOldPos = var_199_4.localPosition
			end

			local var_199_6 = 0.6

			if var_199_5 <= arg_196_1.time_ and arg_196_1.time_ < var_199_5 + var_199_6 then
				local var_199_7 = (arg_196_1.time_ - var_199_5) / 0.066
				local var_199_8, var_199_9 = math.modf(var_199_7)

				var_199_4.localPosition = Vector3.New(var_199_9 * 0.13, var_199_9 * 0.13, var_199_9 * 0.13) + arg_196_1.var_.shakeOldPos
			end

			if arg_196_1.time_ >= var_199_5 + var_199_6 and arg_196_1.time_ < var_199_5 + var_199_6 + arg_199_0 then
				var_199_4.localPosition = arg_196_1.var_.shakeOldPos
			end

			local var_199_10 = 0
			local var_199_11 = 1.4

			if var_199_10 < arg_196_1.time_ and arg_196_1.time_ <= var_199_10 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_12 = arg_196_1:GetWordFromCfg(322072046)
				local var_199_13 = arg_196_1:FormatText(var_199_12.content)

				arg_196_1.text_.text = var_199_13

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_14 = 56
				local var_199_15 = utf8.len(var_199_13)
				local var_199_16 = var_199_14 <= 0 and var_199_11 or var_199_11 * (var_199_15 / var_199_14)

				if var_199_16 > 0 and var_199_11 < var_199_16 then
					arg_196_1.talkMaxDuration = var_199_16

					if var_199_16 + var_199_10 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_16 + var_199_10
					end
				end

				arg_196_1.text_.text = var_199_13
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_17 = math.max(var_199_11, arg_196_1.talkMaxDuration)

			if var_199_10 <= arg_196_1.time_ and arg_196_1.time_ < var_199_10 + var_199_17 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_10) / var_199_17

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_10 + var_199_17 and arg_196_1.time_ < var_199_10 + var_199_17 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play322072047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 322072047
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play322072048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0.175
			local var_203_1 = 1

			if var_203_0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_0 + arg_203_0 then
				local var_203_2 = "play"
				local var_203_3 = "effect"

				arg_200_1:AudioAction(var_203_2, var_203_3, "se_story_145", "se_story_145_machanical_arm", "")
			end

			local var_203_4 = 0
			local var_203_5 = 1.175

			if var_203_4 < arg_200_1.time_ and arg_200_1.time_ <= var_203_4 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_6 = arg_200_1:GetWordFromCfg(322072047)
				local var_203_7 = arg_200_1:FormatText(var_203_6.content)

				arg_200_1.text_.text = var_203_7

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_8 = 47
				local var_203_9 = utf8.len(var_203_7)
				local var_203_10 = var_203_8 <= 0 and var_203_5 or var_203_5 * (var_203_9 / var_203_8)

				if var_203_10 > 0 and var_203_5 < var_203_10 then
					arg_200_1.talkMaxDuration = var_203_10

					if var_203_10 + var_203_4 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_4
					end
				end

				arg_200_1.text_.text = var_203_7
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_11 = math.max(var_203_5, arg_200_1.talkMaxDuration)

			if var_203_4 <= arg_200_1.time_ and arg_200_1.time_ < var_203_4 + var_203_11 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_4) / var_203_11

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_4 + var_203_11 and arg_200_1.time_ < var_203_4 + var_203_11 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play322072048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 322072048
		arg_204_1.duration_ = 2

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play322072049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = "10150ui_story"

			if arg_204_1.actors_[var_207_0] == nil then
				local var_207_1 = Asset.Load("Char/" .. "10150ui_story")

				if not isNil(var_207_1) then
					local var_207_2 = Object.Instantiate(Asset.Load("Char/" .. "10150ui_story"), arg_204_1.stage_.transform)

					var_207_2.name = var_207_0
					var_207_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_204_1.actors_[var_207_0] = var_207_2

					local var_207_3 = var_207_2:GetComponentInChildren(typeof(CharacterEffect))

					var_207_3.enabled = true

					local var_207_4 = GameObjectTools.GetOrAddComponent(var_207_2, typeof(DynamicBoneHelper))

					if var_207_4 then
						var_207_4:EnableDynamicBone(false)
					end

					arg_204_1:ShowWeapon(var_207_3.transform, false)

					arg_204_1.var_[var_207_0 .. "Animator"] = var_207_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_204_1.var_[var_207_0 .. "Animator"].applyRootMotion = true
					arg_204_1.var_[var_207_0 .. "LipSync"] = var_207_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_207_5 = arg_204_1.actors_["10150ui_story"].transform
			local var_207_6 = 0

			if var_207_6 < arg_204_1.time_ and arg_204_1.time_ <= var_207_6 + arg_207_0 then
				arg_204_1.var_.moveOldPos10150ui_story = var_207_5.localPosition

				local var_207_7 = GameObjectTools.GetOrAddComponent(var_207_5.gameObject, typeof(DynamicBoneHelper))

				if var_207_7 then
					var_207_7:EnableDynamicBone(false)
				end
			end

			local var_207_8 = 0.001

			if var_207_6 <= arg_204_1.time_ and arg_204_1.time_ < var_207_6 + var_207_8 then
				local var_207_9 = (arg_204_1.time_ - var_207_6) / var_207_8
				local var_207_10 = Vector3.New(-0.9, -1.73, -5.5)

				var_207_5.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10150ui_story, var_207_10, var_207_9)

				local var_207_11 = manager.ui.mainCamera.transform.position - var_207_5.position

				var_207_5.forward = Vector3.New(var_207_11.x, var_207_11.y, var_207_11.z)

				local var_207_12 = var_207_5.localEulerAngles

				var_207_12.z = 0
				var_207_12.x = 0
				var_207_5.localEulerAngles = var_207_12
			end

			if arg_204_1.time_ >= var_207_6 + var_207_8 and arg_204_1.time_ < var_207_6 + var_207_8 + arg_207_0 then
				var_207_5.localPosition = Vector3.New(-0.9, -1.73, -5.5)

				local var_207_13 = manager.ui.mainCamera.transform.position - var_207_5.position

				var_207_5.forward = Vector3.New(var_207_13.x, var_207_13.y, var_207_13.z)

				local var_207_14 = var_207_5.localEulerAngles

				var_207_14.z = 0
				var_207_14.x = 0
				var_207_5.localEulerAngles = var_207_14

				local var_207_15 = GameObjectTools.GetOrAddComponent(var_207_5.gameObject, typeof(DynamicBoneHelper))

				if var_207_15 then
					var_207_15:EnableDynamicBone(true)
				end
			end

			local var_207_16 = arg_204_1.actors_["10150ui_story"]
			local var_207_17 = 0

			if var_207_17 < arg_204_1.time_ and arg_204_1.time_ <= var_207_17 + arg_207_0 and not isNil(var_207_16) and arg_204_1.var_.characterEffect10150ui_story == nil then
				arg_204_1.var_.characterEffect10150ui_story = var_207_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_18 = 0.200000002980232

			if var_207_17 <= arg_204_1.time_ and arg_204_1.time_ < var_207_17 + var_207_18 and not isNil(var_207_16) then
				local var_207_19 = (arg_204_1.time_ - var_207_17) / var_207_18

				if arg_204_1.var_.characterEffect10150ui_story and not isNil(var_207_16) then
					arg_204_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= var_207_17 + var_207_18 and arg_204_1.time_ < var_207_17 + var_207_18 + arg_207_0 and not isNil(var_207_16) and arg_204_1.var_.characterEffect10150ui_story then
				arg_204_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_207_20 = 0

			if var_207_20 < arg_204_1.time_ and arg_204_1.time_ <= var_207_20 + arg_207_0 then
				arg_204_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action3_1")
			end

			local var_207_21 = 0

			if var_207_21 < arg_204_1.time_ and arg_204_1.time_ <= var_207_21 + arg_207_0 then
				arg_204_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_207_22 = 0
			local var_207_23 = 0.125

			if var_207_22 < arg_204_1.time_ and arg_204_1.time_ <= var_207_22 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				local var_207_24 = arg_204_1:FormatText(StoryNameCfg[1361].name)

				arg_204_1.leftNameTxt_.text = var_207_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_25 = arg_204_1:GetWordFromCfg(322072048)
				local var_207_26 = arg_204_1:FormatText(var_207_25.content)

				arg_204_1.text_.text = var_207_26

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_27 = 5
				local var_207_28 = utf8.len(var_207_26)
				local var_207_29 = var_207_27 <= 0 and var_207_23 or var_207_23 * (var_207_28 / var_207_27)

				if var_207_29 > 0 and var_207_23 < var_207_29 then
					arg_204_1.talkMaxDuration = var_207_29

					if var_207_29 + var_207_22 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_29 + var_207_22
					end
				end

				arg_204_1.text_.text = var_207_26
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072048", "story_v_out_322072.awb") ~= 0 then
					local var_207_30 = manager.audio:GetVoiceLength("story_v_out_322072", "322072048", "story_v_out_322072.awb") / 1000

					if var_207_30 + var_207_22 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_30 + var_207_22
					end

					if var_207_25.prefab_name ~= "" and arg_204_1.actors_[var_207_25.prefab_name] ~= nil then
						local var_207_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_25.prefab_name].transform, "story_v_out_322072", "322072048", "story_v_out_322072.awb")

						arg_204_1:RecordAudio("322072048", var_207_31)
						arg_204_1:RecordAudio("322072048", var_207_31)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_322072", "322072048", "story_v_out_322072.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_322072", "322072048", "story_v_out_322072.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_32 = math.max(var_207_23, arg_204_1.talkMaxDuration)

			if var_207_22 <= arg_204_1.time_ and arg_204_1.time_ < var_207_22 + var_207_32 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_22) / var_207_32

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_22 + var_207_32 and arg_204_1.time_ < var_207_22 + var_207_32 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play322072049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 322072049
		arg_208_1.duration_ = 8.17

		local var_208_0 = {
			zh = 6.866,
			ja = 8.166
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play322072050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = arg_208_1.actors_["10103ui_story"].transform
			local var_211_1 = 0

			if var_211_1 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.var_.moveOldPos10103ui_story = var_211_0.localPosition

				local var_211_2 = GameObjectTools.GetOrAddComponent(var_211_0.gameObject, typeof(DynamicBoneHelper))

				if var_211_2 then
					var_211_2:EnableDynamicBone(false)
				end
			end

			local var_211_3 = 0.001

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_3 then
				local var_211_4 = (arg_208_1.time_ - var_211_1) / var_211_3
				local var_211_5 = Vector3.New(0.7, -0.95, -6.2)

				var_211_0.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10103ui_story, var_211_5, var_211_4)

				local var_211_6 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_6.x, var_211_6.y, var_211_6.z)

				local var_211_7 = var_211_0.localEulerAngles

				var_211_7.z = 0
				var_211_7.x = 0
				var_211_0.localEulerAngles = var_211_7
			end

			if arg_208_1.time_ >= var_211_1 + var_211_3 and arg_208_1.time_ < var_211_1 + var_211_3 + arg_211_0 then
				var_211_0.localPosition = Vector3.New(0.7, -0.95, -6.2)

				local var_211_8 = manager.ui.mainCamera.transform.position - var_211_0.position

				var_211_0.forward = Vector3.New(var_211_8.x, var_211_8.y, var_211_8.z)

				local var_211_9 = var_211_0.localEulerAngles

				var_211_9.z = 0
				var_211_9.x = 0
				var_211_0.localEulerAngles = var_211_9

				local var_211_10 = GameObjectTools.GetOrAddComponent(var_211_0.gameObject, typeof(DynamicBoneHelper))

				if var_211_10 then
					var_211_10:EnableDynamicBone(true)
				end
			end

			local var_211_11 = arg_208_1.actors_["10103ui_story"]
			local var_211_12 = 0

			if var_211_12 < arg_208_1.time_ and arg_208_1.time_ <= var_211_12 + arg_211_0 and not isNil(var_211_11) and arg_208_1.var_.characterEffect10103ui_story == nil then
				arg_208_1.var_.characterEffect10103ui_story = var_211_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_13 = 0.200000002980232

			if var_211_12 <= arg_208_1.time_ and arg_208_1.time_ < var_211_12 + var_211_13 and not isNil(var_211_11) then
				local var_211_14 = (arg_208_1.time_ - var_211_12) / var_211_13

				if arg_208_1.var_.characterEffect10103ui_story and not isNil(var_211_11) then
					arg_208_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= var_211_12 + var_211_13 and arg_208_1.time_ < var_211_12 + var_211_13 + arg_211_0 and not isNil(var_211_11) and arg_208_1.var_.characterEffect10103ui_story then
				arg_208_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_211_15 = arg_208_1.actors_["10150ui_story"]
			local var_211_16 = 0

			if var_211_16 < arg_208_1.time_ and arg_208_1.time_ <= var_211_16 + arg_211_0 and not isNil(var_211_15) and arg_208_1.var_.characterEffect10150ui_story == nil then
				arg_208_1.var_.characterEffect10150ui_story = var_211_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_17 = 0.200000002980232

			if var_211_16 <= arg_208_1.time_ and arg_208_1.time_ < var_211_16 + var_211_17 and not isNil(var_211_15) then
				local var_211_18 = (arg_208_1.time_ - var_211_16) / var_211_17

				if arg_208_1.var_.characterEffect10150ui_story and not isNil(var_211_15) then
					local var_211_19 = Mathf.Lerp(0, 0.5, var_211_18)

					arg_208_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_208_1.var_.characterEffect10150ui_story.fillRatio = var_211_19
				end
			end

			if arg_208_1.time_ >= var_211_16 + var_211_17 and arg_208_1.time_ < var_211_16 + var_211_17 + arg_211_0 and not isNil(var_211_15) and arg_208_1.var_.characterEffect10150ui_story then
				local var_211_20 = 0.5

				arg_208_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_208_1.var_.characterEffect10150ui_story.fillRatio = var_211_20
			end

			local var_211_21 = 0

			if var_211_21 < arg_208_1.time_ and arg_208_1.time_ <= var_211_21 + arg_211_0 then
				arg_208_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_1")
			end

			local var_211_22 = 0

			if var_211_22 < arg_208_1.time_ and arg_208_1.time_ <= var_211_22 + arg_211_0 then
				arg_208_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_211_23 = 0

			if var_211_23 < arg_208_1.time_ and arg_208_1.time_ <= var_211_23 + arg_211_0 then
				local var_211_24 = arg_208_1.actors_["10103ui_story"]

				if not isNil(var_211_24) then
					local var_211_25 = GameObjectTools.GetOrAddComponent(var_211_24, typeof(DynamicBoneHelper))

					if var_211_25 then
						var_211_25:EnableDynamicBone(true)
					end
				end
			end

			local var_211_26 = 0
			local var_211_27 = 0.75

			if var_211_26 < arg_208_1.time_ and arg_208_1.time_ <= var_211_26 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				local var_211_28 = arg_208_1:FormatText(StoryNameCfg[1214].name)

				arg_208_1.leftNameTxt_.text = var_211_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_29 = arg_208_1:GetWordFromCfg(322072049)
				local var_211_30 = arg_208_1:FormatText(var_211_29.content)

				arg_208_1.text_.text = var_211_30

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_31 = 30
				local var_211_32 = utf8.len(var_211_30)
				local var_211_33 = var_211_31 <= 0 and var_211_27 or var_211_27 * (var_211_32 / var_211_31)

				if var_211_33 > 0 and var_211_27 < var_211_33 then
					arg_208_1.talkMaxDuration = var_211_33

					if var_211_33 + var_211_26 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_33 + var_211_26
					end
				end

				arg_208_1.text_.text = var_211_30
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072049", "story_v_out_322072.awb") ~= 0 then
					local var_211_34 = manager.audio:GetVoiceLength("story_v_out_322072", "322072049", "story_v_out_322072.awb") / 1000

					if var_211_34 + var_211_26 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_34 + var_211_26
					end

					if var_211_29.prefab_name ~= "" and arg_208_1.actors_[var_211_29.prefab_name] ~= nil then
						local var_211_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_29.prefab_name].transform, "story_v_out_322072", "322072049", "story_v_out_322072.awb")

						arg_208_1:RecordAudio("322072049", var_211_35)
						arg_208_1:RecordAudio("322072049", var_211_35)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_322072", "322072049", "story_v_out_322072.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_322072", "322072049", "story_v_out_322072.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_36 = math.max(var_211_27, arg_208_1.talkMaxDuration)

			if var_211_26 <= arg_208_1.time_ and arg_208_1.time_ < var_211_26 + var_211_36 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_26) / var_211_36

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_26 + var_211_36 and arg_208_1.time_ < var_211_26 + var_211_36 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play322072050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 322072050
		arg_212_1.duration_ = 4

		local var_212_0 = {
			zh = 1.999999999999,
			ja = 4
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play322072051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = arg_212_1.actors_["10150ui_story"].transform
			local var_215_1 = 0

			if var_215_1 < arg_212_1.time_ and arg_212_1.time_ <= var_215_1 + arg_215_0 then
				arg_212_1.var_.moveOldPos10150ui_story = var_215_0.localPosition

				local var_215_2 = GameObjectTools.GetOrAddComponent(var_215_0.gameObject, typeof(DynamicBoneHelper))

				if var_215_2 then
					var_215_2:EnableDynamicBone(false)
				end
			end

			local var_215_3 = 0.001

			if var_215_1 <= arg_212_1.time_ and arg_212_1.time_ < var_215_1 + var_215_3 then
				local var_215_4 = (arg_212_1.time_ - var_215_1) / var_215_3
				local var_215_5 = Vector3.New(-0.9, -1.73, -5.5)

				var_215_0.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10150ui_story, var_215_5, var_215_4)

				local var_215_6 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_6.x, var_215_6.y, var_215_6.z)

				local var_215_7 = var_215_0.localEulerAngles

				var_215_7.z = 0
				var_215_7.x = 0
				var_215_0.localEulerAngles = var_215_7
			end

			if arg_212_1.time_ >= var_215_1 + var_215_3 and arg_212_1.time_ < var_215_1 + var_215_3 + arg_215_0 then
				var_215_0.localPosition = Vector3.New(-0.9, -1.73, -5.5)

				local var_215_8 = manager.ui.mainCamera.transform.position - var_215_0.position

				var_215_0.forward = Vector3.New(var_215_8.x, var_215_8.y, var_215_8.z)

				local var_215_9 = var_215_0.localEulerAngles

				var_215_9.z = 0
				var_215_9.x = 0
				var_215_0.localEulerAngles = var_215_9

				local var_215_10 = GameObjectTools.GetOrAddComponent(var_215_0.gameObject, typeof(DynamicBoneHelper))

				if var_215_10 then
					var_215_10:EnableDynamicBone(true)
				end
			end

			local var_215_11 = arg_212_1.actors_["10150ui_story"]
			local var_215_12 = 0

			if var_215_12 < arg_212_1.time_ and arg_212_1.time_ <= var_215_12 + arg_215_0 and not isNil(var_215_11) and arg_212_1.var_.characterEffect10150ui_story == nil then
				arg_212_1.var_.characterEffect10150ui_story = var_215_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_13 = 0.200000002980232

			if var_215_12 <= arg_212_1.time_ and arg_212_1.time_ < var_215_12 + var_215_13 and not isNil(var_215_11) then
				local var_215_14 = (arg_212_1.time_ - var_215_12) / var_215_13

				if arg_212_1.var_.characterEffect10150ui_story and not isNil(var_215_11) then
					arg_212_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= var_215_12 + var_215_13 and arg_212_1.time_ < var_215_12 + var_215_13 + arg_215_0 and not isNil(var_215_11) and arg_212_1.var_.characterEffect10150ui_story then
				arg_212_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_215_15 = arg_212_1.actors_["10103ui_story"]
			local var_215_16 = 0

			if var_215_16 < arg_212_1.time_ and arg_212_1.time_ <= var_215_16 + arg_215_0 and not isNil(var_215_15) and arg_212_1.var_.characterEffect10103ui_story == nil then
				arg_212_1.var_.characterEffect10103ui_story = var_215_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_17 = 0.200000002980232

			if var_215_16 <= arg_212_1.time_ and arg_212_1.time_ < var_215_16 + var_215_17 and not isNil(var_215_15) then
				local var_215_18 = (arg_212_1.time_ - var_215_16) / var_215_17

				if arg_212_1.var_.characterEffect10103ui_story and not isNil(var_215_15) then
					local var_215_19 = Mathf.Lerp(0, 0.5, var_215_18)

					arg_212_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_212_1.var_.characterEffect10103ui_story.fillRatio = var_215_19
				end
			end

			if arg_212_1.time_ >= var_215_16 + var_215_17 and arg_212_1.time_ < var_215_16 + var_215_17 + arg_215_0 and not isNil(var_215_15) and arg_212_1.var_.characterEffect10103ui_story then
				local var_215_20 = 0.5

				arg_212_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_212_1.var_.characterEffect10103ui_story.fillRatio = var_215_20
			end

			local var_215_21 = 0

			if var_215_21 < arg_212_1.time_ and arg_212_1.time_ <= var_215_21 + arg_215_0 then
				arg_212_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action3_2")
			end

			local var_215_22 = 0

			if var_215_22 < arg_212_1.time_ and arg_212_1.time_ <= var_215_22 + arg_215_0 then
				arg_212_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_215_23 = 0
			local var_215_24 = 0.2

			if var_215_23 < arg_212_1.time_ and arg_212_1.time_ <= var_215_23 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				local var_215_25 = arg_212_1:FormatText(StoryNameCfg[1361].name)

				arg_212_1.leftNameTxt_.text = var_215_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_26 = arg_212_1:GetWordFromCfg(322072050)
				local var_215_27 = arg_212_1:FormatText(var_215_26.content)

				arg_212_1.text_.text = var_215_27

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_28 = 8
				local var_215_29 = utf8.len(var_215_27)
				local var_215_30 = var_215_28 <= 0 and var_215_24 or var_215_24 * (var_215_29 / var_215_28)

				if var_215_30 > 0 and var_215_24 < var_215_30 then
					arg_212_1.talkMaxDuration = var_215_30

					if var_215_30 + var_215_23 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_30 + var_215_23
					end
				end

				arg_212_1.text_.text = var_215_27
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072050", "story_v_out_322072.awb") ~= 0 then
					local var_215_31 = manager.audio:GetVoiceLength("story_v_out_322072", "322072050", "story_v_out_322072.awb") / 1000

					if var_215_31 + var_215_23 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_31 + var_215_23
					end

					if var_215_26.prefab_name ~= "" and arg_212_1.actors_[var_215_26.prefab_name] ~= nil then
						local var_215_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_26.prefab_name].transform, "story_v_out_322072", "322072050", "story_v_out_322072.awb")

						arg_212_1:RecordAudio("322072050", var_215_32)
						arg_212_1:RecordAudio("322072050", var_215_32)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_322072", "322072050", "story_v_out_322072.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_322072", "322072050", "story_v_out_322072.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_33 = math.max(var_215_24, arg_212_1.talkMaxDuration)

			if var_215_23 <= arg_212_1.time_ and arg_212_1.time_ < var_215_23 + var_215_33 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_23) / var_215_33

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_23 + var_215_33 and arg_212_1.time_ < var_215_23 + var_215_33 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play322072051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 322072051
		arg_216_1.duration_ = 7.8

		local var_216_0 = {
			zh = 5.866,
			ja = 7.8
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play322072052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = arg_216_1.actors_["10103ui_story"].transform
			local var_219_1 = 0

			if var_219_1 < arg_216_1.time_ and arg_216_1.time_ <= var_219_1 + arg_219_0 then
				arg_216_1.var_.moveOldPos10103ui_story = var_219_0.localPosition

				local var_219_2 = GameObjectTools.GetOrAddComponent(var_219_0.gameObject, typeof(DynamicBoneHelper))

				if var_219_2 then
					var_219_2:EnableDynamicBone(false)
				end
			end

			local var_219_3 = 0.001

			if var_219_1 <= arg_216_1.time_ and arg_216_1.time_ < var_219_1 + var_219_3 then
				local var_219_4 = (arg_216_1.time_ - var_219_1) / var_219_3
				local var_219_5 = Vector3.New(0.7, -0.95, -6.2)

				var_219_0.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10103ui_story, var_219_5, var_219_4)

				local var_219_6 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_6.x, var_219_6.y, var_219_6.z)

				local var_219_7 = var_219_0.localEulerAngles

				var_219_7.z = 0
				var_219_7.x = 0
				var_219_0.localEulerAngles = var_219_7
			end

			if arg_216_1.time_ >= var_219_1 + var_219_3 and arg_216_1.time_ < var_219_1 + var_219_3 + arg_219_0 then
				var_219_0.localPosition = Vector3.New(0.7, -0.95, -6.2)

				local var_219_8 = manager.ui.mainCamera.transform.position - var_219_0.position

				var_219_0.forward = Vector3.New(var_219_8.x, var_219_8.y, var_219_8.z)

				local var_219_9 = var_219_0.localEulerAngles

				var_219_9.z = 0
				var_219_9.x = 0
				var_219_0.localEulerAngles = var_219_9

				local var_219_10 = GameObjectTools.GetOrAddComponent(var_219_0.gameObject, typeof(DynamicBoneHelper))

				if var_219_10 then
					var_219_10:EnableDynamicBone(true)
				end
			end

			local var_219_11 = arg_216_1.actors_["10103ui_story"]
			local var_219_12 = 0

			if var_219_12 < arg_216_1.time_ and arg_216_1.time_ <= var_219_12 + arg_219_0 and not isNil(var_219_11) and arg_216_1.var_.characterEffect10103ui_story == nil then
				arg_216_1.var_.characterEffect10103ui_story = var_219_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_13 = 0.200000002980232

			if var_219_12 <= arg_216_1.time_ and arg_216_1.time_ < var_219_12 + var_219_13 and not isNil(var_219_11) then
				local var_219_14 = (arg_216_1.time_ - var_219_12) / var_219_13

				if arg_216_1.var_.characterEffect10103ui_story and not isNil(var_219_11) then
					arg_216_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= var_219_12 + var_219_13 and arg_216_1.time_ < var_219_12 + var_219_13 + arg_219_0 and not isNil(var_219_11) and arg_216_1.var_.characterEffect10103ui_story then
				arg_216_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_219_15 = arg_216_1.actors_["10150ui_story"]
			local var_219_16 = 0

			if var_219_16 < arg_216_1.time_ and arg_216_1.time_ <= var_219_16 + arg_219_0 and not isNil(var_219_15) and arg_216_1.var_.characterEffect10150ui_story == nil then
				arg_216_1.var_.characterEffect10150ui_story = var_219_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_17 = 0.200000002980232

			if var_219_16 <= arg_216_1.time_ and arg_216_1.time_ < var_219_16 + var_219_17 and not isNil(var_219_15) then
				local var_219_18 = (arg_216_1.time_ - var_219_16) / var_219_17

				if arg_216_1.var_.characterEffect10150ui_story and not isNil(var_219_15) then
					local var_219_19 = Mathf.Lerp(0, 0.5, var_219_18)

					arg_216_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10150ui_story.fillRatio = var_219_19
				end
			end

			if arg_216_1.time_ >= var_219_16 + var_219_17 and arg_216_1.time_ < var_219_16 + var_219_17 + arg_219_0 and not isNil(var_219_15) and arg_216_1.var_.characterEffect10150ui_story then
				local var_219_20 = 0.5

				arg_216_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10150ui_story.fillRatio = var_219_20
			end

			local var_219_21 = 0

			if var_219_21 < arg_216_1.time_ and arg_216_1.time_ <= var_219_21 + arg_219_0 then
				arg_216_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_2")
			end

			local var_219_22 = 0

			if var_219_22 < arg_216_1.time_ and arg_216_1.time_ <= var_219_22 + arg_219_0 then
				local var_219_23 = arg_216_1.actors_["10103ui_story"]

				if not isNil(var_219_23) then
					local var_219_24 = GameObjectTools.GetOrAddComponent(var_219_23, typeof(DynamicBoneHelper))

					if var_219_24 then
						var_219_24:EnableDynamicBone(true)
					end
				end
			end

			local var_219_25 = 0
			local var_219_26 = 0.7

			if var_219_25 < arg_216_1.time_ and arg_216_1.time_ <= var_219_25 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				local var_219_27 = arg_216_1:FormatText(StoryNameCfg[1214].name)

				arg_216_1.leftNameTxt_.text = var_219_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_28 = arg_216_1:GetWordFromCfg(322072051)
				local var_219_29 = arg_216_1:FormatText(var_219_28.content)

				arg_216_1.text_.text = var_219_29

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_30 = 28
				local var_219_31 = utf8.len(var_219_29)
				local var_219_32 = var_219_30 <= 0 and var_219_26 or var_219_26 * (var_219_31 / var_219_30)

				if var_219_32 > 0 and var_219_26 < var_219_32 then
					arg_216_1.talkMaxDuration = var_219_32

					if var_219_32 + var_219_25 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_32 + var_219_25
					end
				end

				arg_216_1.text_.text = var_219_29
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072051", "story_v_out_322072.awb") ~= 0 then
					local var_219_33 = manager.audio:GetVoiceLength("story_v_out_322072", "322072051", "story_v_out_322072.awb") / 1000

					if var_219_33 + var_219_25 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_33 + var_219_25
					end

					if var_219_28.prefab_name ~= "" and arg_216_1.actors_[var_219_28.prefab_name] ~= nil then
						local var_219_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_28.prefab_name].transform, "story_v_out_322072", "322072051", "story_v_out_322072.awb")

						arg_216_1:RecordAudio("322072051", var_219_34)
						arg_216_1:RecordAudio("322072051", var_219_34)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_322072", "322072051", "story_v_out_322072.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_322072", "322072051", "story_v_out_322072.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_35 = math.max(var_219_26, arg_216_1.talkMaxDuration)

			if var_219_25 <= arg_216_1.time_ and arg_216_1.time_ < var_219_25 + var_219_35 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_25) / var_219_35

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_25 + var_219_35 and arg_216_1.time_ < var_219_25 + var_219_35 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play322072052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 322072052
		arg_220_1.duration_ = 8.77

		local var_220_0 = {
			zh = 5.433,
			ja = 8.766
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play322072053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			local var_223_0 = 0
			local var_223_1 = 0.575

			if var_223_0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_0 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				local var_223_2 = arg_220_1:FormatText(StoryNameCfg[1214].name)

				arg_220_1.leftNameTxt_.text = var_223_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_3 = arg_220_1:GetWordFromCfg(322072052)
				local var_223_4 = arg_220_1:FormatText(var_223_3.content)

				arg_220_1.text_.text = var_223_4

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_5 = 23
				local var_223_6 = utf8.len(var_223_4)
				local var_223_7 = var_223_5 <= 0 and var_223_1 or var_223_1 * (var_223_6 / var_223_5)

				if var_223_7 > 0 and var_223_1 < var_223_7 then
					arg_220_1.talkMaxDuration = var_223_7

					if var_223_7 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_7 + var_223_0
					end
				end

				arg_220_1.text_.text = var_223_4
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072052", "story_v_out_322072.awb") ~= 0 then
					local var_223_8 = manager.audio:GetVoiceLength("story_v_out_322072", "322072052", "story_v_out_322072.awb") / 1000

					if var_223_8 + var_223_0 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_8 + var_223_0
					end

					if var_223_3.prefab_name ~= "" and arg_220_1.actors_[var_223_3.prefab_name] ~= nil then
						local var_223_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_3.prefab_name].transform, "story_v_out_322072", "322072052", "story_v_out_322072.awb")

						arg_220_1:RecordAudio("322072052", var_223_9)
						arg_220_1:RecordAudio("322072052", var_223_9)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_322072", "322072052", "story_v_out_322072.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_322072", "322072052", "story_v_out_322072.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_10 = math.max(var_223_1, arg_220_1.talkMaxDuration)

			if var_223_0 <= arg_220_1.time_ and arg_220_1.time_ < var_223_0 + var_223_10 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_0) / var_223_10

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_0 + var_223_10 and arg_220_1.time_ < var_223_0 + var_223_10 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play322072053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 322072053
		arg_224_1.duration_ = 8.27

		local var_224_0 = {
			zh = 8.266,
			ja = 7.366
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play322072054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 0
			local var_227_1 = 0.75

			if var_227_0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				local var_227_2 = arg_224_1:FormatText(StoryNameCfg[1214].name)

				arg_224_1.leftNameTxt_.text = var_227_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_3 = arg_224_1:GetWordFromCfg(322072053)
				local var_227_4 = arg_224_1:FormatText(var_227_3.content)

				arg_224_1.text_.text = var_227_4

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 30
				local var_227_6 = utf8.len(var_227_4)
				local var_227_7 = var_227_5 <= 0 and var_227_1 or var_227_1 * (var_227_6 / var_227_5)

				if var_227_7 > 0 and var_227_1 < var_227_7 then
					arg_224_1.talkMaxDuration = var_227_7

					if var_227_7 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_7 + var_227_0
					end
				end

				arg_224_1.text_.text = var_227_4
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072053", "story_v_out_322072.awb") ~= 0 then
					local var_227_8 = manager.audio:GetVoiceLength("story_v_out_322072", "322072053", "story_v_out_322072.awb") / 1000

					if var_227_8 + var_227_0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_8 + var_227_0
					end

					if var_227_3.prefab_name ~= "" and arg_224_1.actors_[var_227_3.prefab_name] ~= nil then
						local var_227_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_3.prefab_name].transform, "story_v_out_322072", "322072053", "story_v_out_322072.awb")

						arg_224_1:RecordAudio("322072053", var_227_9)
						arg_224_1:RecordAudio("322072053", var_227_9)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_322072", "322072053", "story_v_out_322072.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_322072", "322072053", "story_v_out_322072.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_10 = math.max(var_227_1, arg_224_1.talkMaxDuration)

			if var_227_0 <= arg_224_1.time_ and arg_224_1.time_ < var_227_0 + var_227_10 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_0) / var_227_10

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_0 + var_227_10 and arg_224_1.time_ < var_227_0 + var_227_10 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play322072054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 322072054
		arg_228_1.duration_ = 2.07

		local var_228_0 = {
			zh = 2.066,
			ja = 2.033
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play322072055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = arg_228_1.actors_["10150ui_story"].transform
			local var_231_1 = 0

			if var_231_1 < arg_228_1.time_ and arg_228_1.time_ <= var_231_1 + arg_231_0 then
				arg_228_1.var_.moveOldPos10150ui_story = var_231_0.localPosition

				local var_231_2 = GameObjectTools.GetOrAddComponent(var_231_0.gameObject, typeof(DynamicBoneHelper))

				if var_231_2 then
					var_231_2:EnableDynamicBone(false)
				end
			end

			local var_231_3 = 0.001

			if var_231_1 <= arg_228_1.time_ and arg_228_1.time_ < var_231_1 + var_231_3 then
				local var_231_4 = (arg_228_1.time_ - var_231_1) / var_231_3
				local var_231_5 = Vector3.New(-0.9, -1.73, -5.5)

				var_231_0.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos10150ui_story, var_231_5, var_231_4)

				local var_231_6 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_6.x, var_231_6.y, var_231_6.z)

				local var_231_7 = var_231_0.localEulerAngles

				var_231_7.z = 0
				var_231_7.x = 0
				var_231_0.localEulerAngles = var_231_7
			end

			if arg_228_1.time_ >= var_231_1 + var_231_3 and arg_228_1.time_ < var_231_1 + var_231_3 + arg_231_0 then
				var_231_0.localPosition = Vector3.New(-0.9, -1.73, -5.5)

				local var_231_8 = manager.ui.mainCamera.transform.position - var_231_0.position

				var_231_0.forward = Vector3.New(var_231_8.x, var_231_8.y, var_231_8.z)

				local var_231_9 = var_231_0.localEulerAngles

				var_231_9.z = 0
				var_231_9.x = 0
				var_231_0.localEulerAngles = var_231_9

				local var_231_10 = GameObjectTools.GetOrAddComponent(var_231_0.gameObject, typeof(DynamicBoneHelper))

				if var_231_10 then
					var_231_10:EnableDynamicBone(true)
				end
			end

			local var_231_11 = arg_228_1.actors_["10150ui_story"]
			local var_231_12 = 0

			if var_231_12 < arg_228_1.time_ and arg_228_1.time_ <= var_231_12 + arg_231_0 and not isNil(var_231_11) and arg_228_1.var_.characterEffect10150ui_story == nil then
				arg_228_1.var_.characterEffect10150ui_story = var_231_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_13 = 0.200000002980232

			if var_231_12 <= arg_228_1.time_ and arg_228_1.time_ < var_231_12 + var_231_13 and not isNil(var_231_11) then
				local var_231_14 = (arg_228_1.time_ - var_231_12) / var_231_13

				if arg_228_1.var_.characterEffect10150ui_story and not isNil(var_231_11) then
					arg_228_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= var_231_12 + var_231_13 and arg_228_1.time_ < var_231_12 + var_231_13 + arg_231_0 and not isNil(var_231_11) and arg_228_1.var_.characterEffect10150ui_story then
				arg_228_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_231_15 = arg_228_1.actors_["10103ui_story"]
			local var_231_16 = 0

			if var_231_16 < arg_228_1.time_ and arg_228_1.time_ <= var_231_16 + arg_231_0 and not isNil(var_231_15) and arg_228_1.var_.characterEffect10103ui_story == nil then
				arg_228_1.var_.characterEffect10103ui_story = var_231_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_17 = 0.200000002980232

			if var_231_16 <= arg_228_1.time_ and arg_228_1.time_ < var_231_16 + var_231_17 and not isNil(var_231_15) then
				local var_231_18 = (arg_228_1.time_ - var_231_16) / var_231_17

				if arg_228_1.var_.characterEffect10103ui_story and not isNil(var_231_15) then
					local var_231_19 = Mathf.Lerp(0, 0.5, var_231_18)

					arg_228_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_228_1.var_.characterEffect10103ui_story.fillRatio = var_231_19
				end
			end

			if arg_228_1.time_ >= var_231_16 + var_231_17 and arg_228_1.time_ < var_231_16 + var_231_17 + arg_231_0 and not isNil(var_231_15) and arg_228_1.var_.characterEffect10103ui_story then
				local var_231_20 = 0.5

				arg_228_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_228_1.var_.characterEffect10103ui_story.fillRatio = var_231_20
			end

			local var_231_21 = 0

			if var_231_21 < arg_228_1.time_ and arg_228_1.time_ <= var_231_21 + arg_231_0 then
				arg_228_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_1")
			end

			local var_231_22 = 0

			if var_231_22 < arg_228_1.time_ and arg_228_1.time_ <= var_231_22 + arg_231_0 then
				arg_228_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_231_23 = 0
			local var_231_24 = 0.175

			if var_231_23 < arg_228_1.time_ and arg_228_1.time_ <= var_231_23 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				local var_231_25 = arg_228_1:FormatText(StoryNameCfg[1361].name)

				arg_228_1.leftNameTxt_.text = var_231_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_26 = arg_228_1:GetWordFromCfg(322072054)
				local var_231_27 = arg_228_1:FormatText(var_231_26.content)

				arg_228_1.text_.text = var_231_27

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_28 = 7
				local var_231_29 = utf8.len(var_231_27)
				local var_231_30 = var_231_28 <= 0 and var_231_24 or var_231_24 * (var_231_29 / var_231_28)

				if var_231_30 > 0 and var_231_24 < var_231_30 then
					arg_228_1.talkMaxDuration = var_231_30

					if var_231_30 + var_231_23 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_30 + var_231_23
					end
				end

				arg_228_1.text_.text = var_231_27
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072054", "story_v_out_322072.awb") ~= 0 then
					local var_231_31 = manager.audio:GetVoiceLength("story_v_out_322072", "322072054", "story_v_out_322072.awb") / 1000

					if var_231_31 + var_231_23 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_31 + var_231_23
					end

					if var_231_26.prefab_name ~= "" and arg_228_1.actors_[var_231_26.prefab_name] ~= nil then
						local var_231_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_26.prefab_name].transform, "story_v_out_322072", "322072054", "story_v_out_322072.awb")

						arg_228_1:RecordAudio("322072054", var_231_32)
						arg_228_1:RecordAudio("322072054", var_231_32)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_322072", "322072054", "story_v_out_322072.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_322072", "322072054", "story_v_out_322072.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_33 = math.max(var_231_24, arg_228_1.talkMaxDuration)

			if var_231_23 <= arg_228_1.time_ and arg_228_1.time_ < var_231_23 + var_231_33 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_23) / var_231_33

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_23 + var_231_33 and arg_228_1.time_ < var_231_23 + var_231_33 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play322072055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 322072055
		arg_232_1.duration_ = 9.6

		local var_232_0 = {
			zh = 4.166,
			ja = 9.6
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play322072056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = arg_232_1.actors_["10103ui_story"].transform
			local var_235_1 = 0

			if var_235_1 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.var_.moveOldPos10103ui_story = var_235_0.localPosition

				local var_235_2 = GameObjectTools.GetOrAddComponent(var_235_0.gameObject, typeof(DynamicBoneHelper))

				if var_235_2 then
					var_235_2:EnableDynamicBone(false)
				end
			end

			local var_235_3 = 0.001

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_3 then
				local var_235_4 = (arg_232_1.time_ - var_235_1) / var_235_3
				local var_235_5 = Vector3.New(0.7, -0.95, -6.2)

				var_235_0.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos10103ui_story, var_235_5, var_235_4)

				local var_235_6 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_6.x, var_235_6.y, var_235_6.z)

				local var_235_7 = var_235_0.localEulerAngles

				var_235_7.z = 0
				var_235_7.x = 0
				var_235_0.localEulerAngles = var_235_7
			end

			if arg_232_1.time_ >= var_235_1 + var_235_3 and arg_232_1.time_ < var_235_1 + var_235_3 + arg_235_0 then
				var_235_0.localPosition = Vector3.New(0.7, -0.95, -6.2)

				local var_235_8 = manager.ui.mainCamera.transform.position - var_235_0.position

				var_235_0.forward = Vector3.New(var_235_8.x, var_235_8.y, var_235_8.z)

				local var_235_9 = var_235_0.localEulerAngles

				var_235_9.z = 0
				var_235_9.x = 0
				var_235_0.localEulerAngles = var_235_9

				local var_235_10 = GameObjectTools.GetOrAddComponent(var_235_0.gameObject, typeof(DynamicBoneHelper))

				if var_235_10 then
					var_235_10:EnableDynamicBone(true)
				end
			end

			local var_235_11 = arg_232_1.actors_["10103ui_story"]
			local var_235_12 = 0

			if var_235_12 < arg_232_1.time_ and arg_232_1.time_ <= var_235_12 + arg_235_0 and not isNil(var_235_11) and arg_232_1.var_.characterEffect10103ui_story == nil then
				arg_232_1.var_.characterEffect10103ui_story = var_235_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_13 = 0.200000002980232

			if var_235_12 <= arg_232_1.time_ and arg_232_1.time_ < var_235_12 + var_235_13 and not isNil(var_235_11) then
				local var_235_14 = (arg_232_1.time_ - var_235_12) / var_235_13

				if arg_232_1.var_.characterEffect10103ui_story and not isNil(var_235_11) then
					arg_232_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_232_1.time_ >= var_235_12 + var_235_13 and arg_232_1.time_ < var_235_12 + var_235_13 + arg_235_0 and not isNil(var_235_11) and arg_232_1.var_.characterEffect10103ui_story then
				arg_232_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_235_15 = arg_232_1.actors_["10150ui_story"]
			local var_235_16 = 0

			if var_235_16 < arg_232_1.time_ and arg_232_1.time_ <= var_235_16 + arg_235_0 and not isNil(var_235_15) and arg_232_1.var_.characterEffect10150ui_story == nil then
				arg_232_1.var_.characterEffect10150ui_story = var_235_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_17 = 0.200000002980232

			if var_235_16 <= arg_232_1.time_ and arg_232_1.time_ < var_235_16 + var_235_17 and not isNil(var_235_15) then
				local var_235_18 = (arg_232_1.time_ - var_235_16) / var_235_17

				if arg_232_1.var_.characterEffect10150ui_story and not isNil(var_235_15) then
					local var_235_19 = Mathf.Lerp(0, 0.5, var_235_18)

					arg_232_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_232_1.var_.characterEffect10150ui_story.fillRatio = var_235_19
				end
			end

			if arg_232_1.time_ >= var_235_16 + var_235_17 and arg_232_1.time_ < var_235_16 + var_235_17 + arg_235_0 and not isNil(var_235_15) and arg_232_1.var_.characterEffect10150ui_story then
				local var_235_20 = 0.5

				arg_232_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_232_1.var_.characterEffect10150ui_story.fillRatio = var_235_20
			end

			local var_235_21 = 0

			if var_235_21 < arg_232_1.time_ and arg_232_1.time_ <= var_235_21 + arg_235_0 then
				arg_232_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action4_1")
			end

			local var_235_22 = 0

			if var_235_22 < arg_232_1.time_ and arg_232_1.time_ <= var_235_22 + arg_235_0 then
				local var_235_23 = arg_232_1.actors_["10103ui_story"]

				if not isNil(var_235_23) then
					local var_235_24 = GameObjectTools.GetOrAddComponent(var_235_23, typeof(DynamicBoneHelper))

					if var_235_24 then
						var_235_24:EnableDynamicBone(true)
					end
				end
			end

			local var_235_25 = 0
			local var_235_26 = 0.55

			if var_235_25 < arg_232_1.time_ and arg_232_1.time_ <= var_235_25 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				local var_235_27 = arg_232_1:FormatText(StoryNameCfg[1214].name)

				arg_232_1.leftNameTxt_.text = var_235_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_28 = arg_232_1:GetWordFromCfg(322072055)
				local var_235_29 = arg_232_1:FormatText(var_235_28.content)

				arg_232_1.text_.text = var_235_29

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_30 = 22
				local var_235_31 = utf8.len(var_235_29)
				local var_235_32 = var_235_30 <= 0 and var_235_26 or var_235_26 * (var_235_31 / var_235_30)

				if var_235_32 > 0 and var_235_26 < var_235_32 then
					arg_232_1.talkMaxDuration = var_235_32

					if var_235_32 + var_235_25 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_32 + var_235_25
					end
				end

				arg_232_1.text_.text = var_235_29
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072055", "story_v_out_322072.awb") ~= 0 then
					local var_235_33 = manager.audio:GetVoiceLength("story_v_out_322072", "322072055", "story_v_out_322072.awb") / 1000

					if var_235_33 + var_235_25 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_33 + var_235_25
					end

					if var_235_28.prefab_name ~= "" and arg_232_1.actors_[var_235_28.prefab_name] ~= nil then
						local var_235_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_28.prefab_name].transform, "story_v_out_322072", "322072055", "story_v_out_322072.awb")

						arg_232_1:RecordAudio("322072055", var_235_34)
						arg_232_1:RecordAudio("322072055", var_235_34)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_322072", "322072055", "story_v_out_322072.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_322072", "322072055", "story_v_out_322072.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_35 = math.max(var_235_26, arg_232_1.talkMaxDuration)

			if var_235_25 <= arg_232_1.time_ and arg_232_1.time_ < var_235_25 + var_235_35 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_25) / var_235_35

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_25 + var_235_35 and arg_232_1.time_ < var_235_25 + var_235_35 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play322072056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 322072056
		arg_236_1.duration_ = 6.13

		local var_236_0 = {
			zh = 4.966,
			ja = 6.133
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play322072057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = arg_236_1.actors_["10150ui_story"].transform
			local var_239_1 = 0

			if var_239_1 < arg_236_1.time_ and arg_236_1.time_ <= var_239_1 + arg_239_0 then
				arg_236_1.var_.moveOldPos10150ui_story = var_239_0.localPosition

				local var_239_2 = GameObjectTools.GetOrAddComponent(var_239_0.gameObject, typeof(DynamicBoneHelper))

				if var_239_2 then
					var_239_2:EnableDynamicBone(false)
				end
			end

			local var_239_3 = 0.001

			if var_239_1 <= arg_236_1.time_ and arg_236_1.time_ < var_239_1 + var_239_3 then
				local var_239_4 = (arg_236_1.time_ - var_239_1) / var_239_3
				local var_239_5 = Vector3.New(-0.9, -1.73, -5.5)

				var_239_0.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos10150ui_story, var_239_5, var_239_4)

				local var_239_6 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_6.x, var_239_6.y, var_239_6.z)

				local var_239_7 = var_239_0.localEulerAngles

				var_239_7.z = 0
				var_239_7.x = 0
				var_239_0.localEulerAngles = var_239_7
			end

			if arg_236_1.time_ >= var_239_1 + var_239_3 and arg_236_1.time_ < var_239_1 + var_239_3 + arg_239_0 then
				var_239_0.localPosition = Vector3.New(-0.9, -1.73, -5.5)

				local var_239_8 = manager.ui.mainCamera.transform.position - var_239_0.position

				var_239_0.forward = Vector3.New(var_239_8.x, var_239_8.y, var_239_8.z)

				local var_239_9 = var_239_0.localEulerAngles

				var_239_9.z = 0
				var_239_9.x = 0
				var_239_0.localEulerAngles = var_239_9

				local var_239_10 = GameObjectTools.GetOrAddComponent(var_239_0.gameObject, typeof(DynamicBoneHelper))

				if var_239_10 then
					var_239_10:EnableDynamicBone(true)
				end
			end

			local var_239_11 = arg_236_1.actors_["10150ui_story"]
			local var_239_12 = 0

			if var_239_12 < arg_236_1.time_ and arg_236_1.time_ <= var_239_12 + arg_239_0 and not isNil(var_239_11) and arg_236_1.var_.characterEffect10150ui_story == nil then
				arg_236_1.var_.characterEffect10150ui_story = var_239_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_13 = 0.200000002980232

			if var_239_12 <= arg_236_1.time_ and arg_236_1.time_ < var_239_12 + var_239_13 and not isNil(var_239_11) then
				local var_239_14 = (arg_236_1.time_ - var_239_12) / var_239_13

				if arg_236_1.var_.characterEffect10150ui_story and not isNil(var_239_11) then
					arg_236_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= var_239_12 + var_239_13 and arg_236_1.time_ < var_239_12 + var_239_13 + arg_239_0 and not isNil(var_239_11) and arg_236_1.var_.characterEffect10150ui_story then
				arg_236_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_239_15 = arg_236_1.actors_["10103ui_story"]
			local var_239_16 = 0

			if var_239_16 < arg_236_1.time_ and arg_236_1.time_ <= var_239_16 + arg_239_0 and not isNil(var_239_15) and arg_236_1.var_.characterEffect10103ui_story == nil then
				arg_236_1.var_.characterEffect10103ui_story = var_239_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_17 = 0.200000002980232

			if var_239_16 <= arg_236_1.time_ and arg_236_1.time_ < var_239_16 + var_239_17 and not isNil(var_239_15) then
				local var_239_18 = (arg_236_1.time_ - var_239_16) / var_239_17

				if arg_236_1.var_.characterEffect10103ui_story and not isNil(var_239_15) then
					local var_239_19 = Mathf.Lerp(0, 0.5, var_239_18)

					arg_236_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_236_1.var_.characterEffect10103ui_story.fillRatio = var_239_19
				end
			end

			if arg_236_1.time_ >= var_239_16 + var_239_17 and arg_236_1.time_ < var_239_16 + var_239_17 + arg_239_0 and not isNil(var_239_15) and arg_236_1.var_.characterEffect10103ui_story then
				local var_239_20 = 0.5

				arg_236_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_236_1.var_.characterEffect10103ui_story.fillRatio = var_239_20
			end

			local var_239_21 = 0

			if var_239_21 < arg_236_1.time_ and arg_236_1.time_ <= var_239_21 + arg_239_0 then
				arg_236_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action5_2")
			end

			local var_239_22 = 0

			if var_239_22 < arg_236_1.time_ and arg_236_1.time_ <= var_239_22 + arg_239_0 then
				arg_236_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_239_23 = 0
			local var_239_24 = 0.325

			if var_239_23 < arg_236_1.time_ and arg_236_1.time_ <= var_239_23 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				local var_239_25 = arg_236_1:FormatText(StoryNameCfg[1361].name)

				arg_236_1.leftNameTxt_.text = var_239_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_26 = arg_236_1:GetWordFromCfg(322072056)
				local var_239_27 = arg_236_1:FormatText(var_239_26.content)

				arg_236_1.text_.text = var_239_27

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_28 = 13
				local var_239_29 = utf8.len(var_239_27)
				local var_239_30 = var_239_28 <= 0 and var_239_24 or var_239_24 * (var_239_29 / var_239_28)

				if var_239_30 > 0 and var_239_24 < var_239_30 then
					arg_236_1.talkMaxDuration = var_239_30

					if var_239_30 + var_239_23 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_30 + var_239_23
					end
				end

				arg_236_1.text_.text = var_239_27
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072056", "story_v_out_322072.awb") ~= 0 then
					local var_239_31 = manager.audio:GetVoiceLength("story_v_out_322072", "322072056", "story_v_out_322072.awb") / 1000

					if var_239_31 + var_239_23 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_31 + var_239_23
					end

					if var_239_26.prefab_name ~= "" and arg_236_1.actors_[var_239_26.prefab_name] ~= nil then
						local var_239_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_26.prefab_name].transform, "story_v_out_322072", "322072056", "story_v_out_322072.awb")

						arg_236_1:RecordAudio("322072056", var_239_32)
						arg_236_1:RecordAudio("322072056", var_239_32)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_322072", "322072056", "story_v_out_322072.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_322072", "322072056", "story_v_out_322072.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_33 = math.max(var_239_24, arg_236_1.talkMaxDuration)

			if var_239_23 <= arg_236_1.time_ and arg_236_1.time_ < var_239_23 + var_239_33 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_23) / var_239_33

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_23 + var_239_33 and arg_236_1.time_ < var_239_23 + var_239_33 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play322072057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 322072057
		arg_240_1.duration_ = 9.2

		local var_240_0 = {
			zh = 5.733,
			ja = 9.2
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play322072058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			local var_243_0 = arg_240_1.actors_["10103ui_story"].transform
			local var_243_1 = 0

			if var_243_1 < arg_240_1.time_ and arg_240_1.time_ <= var_243_1 + arg_243_0 then
				arg_240_1.var_.moveOldPos10103ui_story = var_243_0.localPosition

				local var_243_2 = GameObjectTools.GetOrAddComponent(var_243_0.gameObject, typeof(DynamicBoneHelper))

				if var_243_2 then
					var_243_2:EnableDynamicBone(false)
				end
			end

			local var_243_3 = 0.001

			if var_243_1 <= arg_240_1.time_ and arg_240_1.time_ < var_243_1 + var_243_3 then
				local var_243_4 = (arg_240_1.time_ - var_243_1) / var_243_3
				local var_243_5 = Vector3.New(0.7, -0.95, -6.2)

				var_243_0.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10103ui_story, var_243_5, var_243_4)

				local var_243_6 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_6.x, var_243_6.y, var_243_6.z)

				local var_243_7 = var_243_0.localEulerAngles

				var_243_7.z = 0
				var_243_7.x = 0
				var_243_0.localEulerAngles = var_243_7
			end

			if arg_240_1.time_ >= var_243_1 + var_243_3 and arg_240_1.time_ < var_243_1 + var_243_3 + arg_243_0 then
				var_243_0.localPosition = Vector3.New(0.7, -0.95, -6.2)

				local var_243_8 = manager.ui.mainCamera.transform.position - var_243_0.position

				var_243_0.forward = Vector3.New(var_243_8.x, var_243_8.y, var_243_8.z)

				local var_243_9 = var_243_0.localEulerAngles

				var_243_9.z = 0
				var_243_9.x = 0
				var_243_0.localEulerAngles = var_243_9

				local var_243_10 = GameObjectTools.GetOrAddComponent(var_243_0.gameObject, typeof(DynamicBoneHelper))

				if var_243_10 then
					var_243_10:EnableDynamicBone(true)
				end
			end

			local var_243_11 = arg_240_1.actors_["10103ui_story"]
			local var_243_12 = 0

			if var_243_12 < arg_240_1.time_ and arg_240_1.time_ <= var_243_12 + arg_243_0 and not isNil(var_243_11) and arg_240_1.var_.characterEffect10103ui_story == nil then
				arg_240_1.var_.characterEffect10103ui_story = var_243_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_13 = 0.200000002980232

			if var_243_12 <= arg_240_1.time_ and arg_240_1.time_ < var_243_12 + var_243_13 and not isNil(var_243_11) then
				local var_243_14 = (arg_240_1.time_ - var_243_12) / var_243_13

				if arg_240_1.var_.characterEffect10103ui_story and not isNil(var_243_11) then
					arg_240_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= var_243_12 + var_243_13 and arg_240_1.time_ < var_243_12 + var_243_13 + arg_243_0 and not isNil(var_243_11) and arg_240_1.var_.characterEffect10103ui_story then
				arg_240_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_243_15 = arg_240_1.actors_["10150ui_story"]
			local var_243_16 = 0

			if var_243_16 < arg_240_1.time_ and arg_240_1.time_ <= var_243_16 + arg_243_0 and not isNil(var_243_15) and arg_240_1.var_.characterEffect10150ui_story == nil then
				arg_240_1.var_.characterEffect10150ui_story = var_243_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_17 = 0.200000002980232

			if var_243_16 <= arg_240_1.time_ and arg_240_1.time_ < var_243_16 + var_243_17 and not isNil(var_243_15) then
				local var_243_18 = (arg_240_1.time_ - var_243_16) / var_243_17

				if arg_240_1.var_.characterEffect10150ui_story and not isNil(var_243_15) then
					local var_243_19 = Mathf.Lerp(0, 0.5, var_243_18)

					arg_240_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_240_1.var_.characterEffect10150ui_story.fillRatio = var_243_19
				end
			end

			if arg_240_1.time_ >= var_243_16 + var_243_17 and arg_240_1.time_ < var_243_16 + var_243_17 + arg_243_0 and not isNil(var_243_15) and arg_240_1.var_.characterEffect10150ui_story then
				local var_243_20 = 0.5

				arg_240_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_240_1.var_.characterEffect10150ui_story.fillRatio = var_243_20
			end

			local var_243_21 = 0

			if var_243_21 < arg_240_1.time_ and arg_240_1.time_ <= var_243_21 + arg_243_0 then
				arg_240_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action4_2")
			end

			local var_243_22 = 0

			if var_243_22 < arg_240_1.time_ and arg_240_1.time_ <= var_243_22 + arg_243_0 then
				local var_243_23 = arg_240_1.actors_["10103ui_story"]

				if not isNil(var_243_23) then
					local var_243_24 = GameObjectTools.GetOrAddComponent(var_243_23, typeof(DynamicBoneHelper))

					if var_243_24 then
						var_243_24:EnableDynamicBone(true)
					end
				end
			end

			local var_243_25 = 0

			if var_243_25 < arg_240_1.time_ and arg_240_1.time_ <= var_243_25 + arg_243_0 then
				arg_240_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_243_26 = 0
			local var_243_27 = 0.525

			if var_243_26 < arg_240_1.time_ and arg_240_1.time_ <= var_243_26 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				local var_243_28 = arg_240_1:FormatText(StoryNameCfg[1214].name)

				arg_240_1.leftNameTxt_.text = var_243_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_29 = arg_240_1:GetWordFromCfg(322072057)
				local var_243_30 = arg_240_1:FormatText(var_243_29.content)

				arg_240_1.text_.text = var_243_30

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_31 = 21
				local var_243_32 = utf8.len(var_243_30)
				local var_243_33 = var_243_31 <= 0 and var_243_27 or var_243_27 * (var_243_32 / var_243_31)

				if var_243_33 > 0 and var_243_27 < var_243_33 then
					arg_240_1.talkMaxDuration = var_243_33

					if var_243_33 + var_243_26 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_33 + var_243_26
					end
				end

				arg_240_1.text_.text = var_243_30
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072057", "story_v_out_322072.awb") ~= 0 then
					local var_243_34 = manager.audio:GetVoiceLength("story_v_out_322072", "322072057", "story_v_out_322072.awb") / 1000

					if var_243_34 + var_243_26 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_34 + var_243_26
					end

					if var_243_29.prefab_name ~= "" and arg_240_1.actors_[var_243_29.prefab_name] ~= nil then
						local var_243_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_29.prefab_name].transform, "story_v_out_322072", "322072057", "story_v_out_322072.awb")

						arg_240_1:RecordAudio("322072057", var_243_35)
						arg_240_1:RecordAudio("322072057", var_243_35)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_322072", "322072057", "story_v_out_322072.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_322072", "322072057", "story_v_out_322072.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_36 = math.max(var_243_27, arg_240_1.talkMaxDuration)

			if var_243_26 <= arg_240_1.time_ and arg_240_1.time_ < var_243_26 + var_243_36 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_26) / var_243_36

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_26 + var_243_36 and arg_240_1.time_ < var_243_26 + var_243_36 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play322072058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 322072058
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play322072059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = 0.1
			local var_247_1 = 1

			if var_247_0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_0 + arg_247_0 then
				local var_247_2 = "play"
				local var_247_3 = "effect"

				arg_244_1:AudioAction(var_247_2, var_247_3, "se_story_136", "se_story_136_carengine", "")
			end

			local var_247_4 = arg_244_1.actors_["10150ui_story"].transform
			local var_247_5 = 0

			if var_247_5 < arg_244_1.time_ and arg_244_1.time_ <= var_247_5 + arg_247_0 then
				arg_244_1.var_.moveOldPos10150ui_story = var_247_4.localPosition

				local var_247_6 = GameObjectTools.GetOrAddComponent(var_247_4.gameObject, typeof(DynamicBoneHelper))

				if var_247_6 then
					var_247_6:EnableDynamicBone(false)
				end
			end

			local var_247_7 = 0.001

			if var_247_5 <= arg_244_1.time_ and arg_244_1.time_ < var_247_5 + var_247_7 then
				local var_247_8 = (arg_244_1.time_ - var_247_5) / var_247_7
				local var_247_9 = Vector3.New(0, 100, 0)

				var_247_4.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10150ui_story, var_247_9, var_247_8)

				local var_247_10 = manager.ui.mainCamera.transform.position - var_247_4.position

				var_247_4.forward = Vector3.New(var_247_10.x, var_247_10.y, var_247_10.z)

				local var_247_11 = var_247_4.localEulerAngles

				var_247_11.z = 0
				var_247_11.x = 0
				var_247_4.localEulerAngles = var_247_11
			end

			if arg_244_1.time_ >= var_247_5 + var_247_7 and arg_244_1.time_ < var_247_5 + var_247_7 + arg_247_0 then
				var_247_4.localPosition = Vector3.New(0, 100, 0)

				local var_247_12 = manager.ui.mainCamera.transform.position - var_247_4.position

				var_247_4.forward = Vector3.New(var_247_12.x, var_247_12.y, var_247_12.z)

				local var_247_13 = var_247_4.localEulerAngles

				var_247_13.z = 0
				var_247_13.x = 0
				var_247_4.localEulerAngles = var_247_13

				local var_247_14 = GameObjectTools.GetOrAddComponent(var_247_4.gameObject, typeof(DynamicBoneHelper))

				if var_247_14 then
					var_247_14:EnableDynamicBone(true)
				end
			end

			local var_247_15 = arg_244_1.actors_["10103ui_story"].transform
			local var_247_16 = 0

			if var_247_16 < arg_244_1.time_ and arg_244_1.time_ <= var_247_16 + arg_247_0 then
				arg_244_1.var_.moveOldPos10103ui_story = var_247_15.localPosition

				local var_247_17 = GameObjectTools.GetOrAddComponent(var_247_15.gameObject, typeof(DynamicBoneHelper))

				if var_247_17 then
					var_247_17:EnableDynamicBone(false)
				end
			end

			local var_247_18 = 0.001

			if var_247_16 <= arg_244_1.time_ and arg_244_1.time_ < var_247_16 + var_247_18 then
				local var_247_19 = (arg_244_1.time_ - var_247_16) / var_247_18
				local var_247_20 = Vector3.New(0, 100, 0)

				var_247_15.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10103ui_story, var_247_20, var_247_19)

				local var_247_21 = manager.ui.mainCamera.transform.position - var_247_15.position

				var_247_15.forward = Vector3.New(var_247_21.x, var_247_21.y, var_247_21.z)

				local var_247_22 = var_247_15.localEulerAngles

				var_247_22.z = 0
				var_247_22.x = 0
				var_247_15.localEulerAngles = var_247_22
			end

			if arg_244_1.time_ >= var_247_16 + var_247_18 and arg_244_1.time_ < var_247_16 + var_247_18 + arg_247_0 then
				var_247_15.localPosition = Vector3.New(0, 100, 0)

				local var_247_23 = manager.ui.mainCamera.transform.position - var_247_15.position

				var_247_15.forward = Vector3.New(var_247_23.x, var_247_23.y, var_247_23.z)

				local var_247_24 = var_247_15.localEulerAngles

				var_247_24.z = 0
				var_247_24.x = 0
				var_247_15.localEulerAngles = var_247_24

				local var_247_25 = GameObjectTools.GetOrAddComponent(var_247_15.gameObject, typeof(DynamicBoneHelper))

				if var_247_25 then
					var_247_25:EnableDynamicBone(true)
				end
			end

			local var_247_26 = 0
			local var_247_27 = 1.2

			if var_247_26 < arg_244_1.time_ and arg_244_1.time_ <= var_247_26 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, false)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_28 = arg_244_1:GetWordFromCfg(322072058)
				local var_247_29 = arg_244_1:FormatText(var_247_28.content)

				arg_244_1.text_.text = var_247_29

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_30 = 48
				local var_247_31 = utf8.len(var_247_29)
				local var_247_32 = var_247_30 <= 0 and var_247_27 or var_247_27 * (var_247_31 / var_247_30)

				if var_247_32 > 0 and var_247_27 < var_247_32 then
					arg_244_1.talkMaxDuration = var_247_32

					if var_247_32 + var_247_26 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_32 + var_247_26
					end
				end

				arg_244_1.text_.text = var_247_29
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_33 = math.max(var_247_27, arg_244_1.talkMaxDuration)

			if var_247_26 <= arg_244_1.time_ and arg_244_1.time_ < var_247_26 + var_247_33 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_26) / var_247_33

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_26 + var_247_33 and arg_244_1.time_ < var_247_26 + var_247_33 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play322072059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 322072059
		arg_248_1.duration_ = 16.43

		local var_248_0 = {
			zh = 8.7,
			ja = 16.433
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play322072060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			local var_251_0 = arg_248_1.actors_["10103ui_story"].transform
			local var_251_1 = 0

			if var_251_1 < arg_248_1.time_ and arg_248_1.time_ <= var_251_1 + arg_251_0 then
				arg_248_1.var_.moveOldPos10103ui_story = var_251_0.localPosition

				local var_251_2 = GameObjectTools.GetOrAddComponent(var_251_0.gameObject, typeof(DynamicBoneHelper))

				if var_251_2 then
					var_251_2:EnableDynamicBone(false)
				end
			end

			local var_251_3 = 0.001

			if var_251_1 <= arg_248_1.time_ and arg_248_1.time_ < var_251_1 + var_251_3 then
				local var_251_4 = (arg_248_1.time_ - var_251_1) / var_251_3
				local var_251_5 = Vector3.New(0, -0.95, -6.2)

				var_251_0.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10103ui_story, var_251_5, var_251_4)

				local var_251_6 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_6.x, var_251_6.y, var_251_6.z)

				local var_251_7 = var_251_0.localEulerAngles

				var_251_7.z = 0
				var_251_7.x = 0
				var_251_0.localEulerAngles = var_251_7
			end

			if arg_248_1.time_ >= var_251_1 + var_251_3 and arg_248_1.time_ < var_251_1 + var_251_3 + arg_251_0 then
				var_251_0.localPosition = Vector3.New(0, -0.95, -6.2)

				local var_251_8 = manager.ui.mainCamera.transform.position - var_251_0.position

				var_251_0.forward = Vector3.New(var_251_8.x, var_251_8.y, var_251_8.z)

				local var_251_9 = var_251_0.localEulerAngles

				var_251_9.z = 0
				var_251_9.x = 0
				var_251_0.localEulerAngles = var_251_9

				local var_251_10 = GameObjectTools.GetOrAddComponent(var_251_0.gameObject, typeof(DynamicBoneHelper))

				if var_251_10 then
					var_251_10:EnableDynamicBone(true)
				end
			end

			local var_251_11 = arg_248_1.actors_["10103ui_story"]
			local var_251_12 = 0

			if var_251_12 < arg_248_1.time_ and arg_248_1.time_ <= var_251_12 + arg_251_0 and not isNil(var_251_11) and arg_248_1.var_.characterEffect10103ui_story == nil then
				arg_248_1.var_.characterEffect10103ui_story = var_251_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_13 = 0.200000002980232

			if var_251_12 <= arg_248_1.time_ and arg_248_1.time_ < var_251_12 + var_251_13 and not isNil(var_251_11) then
				local var_251_14 = (arg_248_1.time_ - var_251_12) / var_251_13

				if arg_248_1.var_.characterEffect10103ui_story and not isNil(var_251_11) then
					arg_248_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= var_251_12 + var_251_13 and arg_248_1.time_ < var_251_12 + var_251_13 + arg_251_0 and not isNil(var_251_11) and arg_248_1.var_.characterEffect10103ui_story then
				arg_248_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_251_15 = 0

			if var_251_15 < arg_248_1.time_ and arg_248_1.time_ <= var_251_15 + arg_251_0 then
				arg_248_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			local var_251_16 = 0

			if var_251_16 < arg_248_1.time_ and arg_248_1.time_ <= var_251_16 + arg_251_0 then
				arg_248_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_251_17 = 0

			if var_251_17 < arg_248_1.time_ and arg_248_1.time_ <= var_251_17 + arg_251_0 then
				local var_251_18 = arg_248_1.actors_["10103ui_story"]

				if not isNil(var_251_18) then
					local var_251_19 = GameObjectTools.GetOrAddComponent(var_251_18, typeof(DynamicBoneHelper))

					if var_251_19 then
						var_251_19:EnableDynamicBone(true)
					end
				end
			end

			local var_251_20 = 0
			local var_251_21 = 1.125

			if var_251_20 < arg_248_1.time_ and arg_248_1.time_ <= var_251_20 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				local var_251_22 = arg_248_1:FormatText(StoryNameCfg[1214].name)

				arg_248_1.leftNameTxt_.text = var_251_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_23 = arg_248_1:GetWordFromCfg(322072059)
				local var_251_24 = arg_248_1:FormatText(var_251_23.content)

				arg_248_1.text_.text = var_251_24

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_25 = 45
				local var_251_26 = utf8.len(var_251_24)
				local var_251_27 = var_251_25 <= 0 and var_251_21 or var_251_21 * (var_251_26 / var_251_25)

				if var_251_27 > 0 and var_251_21 < var_251_27 then
					arg_248_1.talkMaxDuration = var_251_27

					if var_251_27 + var_251_20 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_27 + var_251_20
					end
				end

				arg_248_1.text_.text = var_251_24
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072059", "story_v_out_322072.awb") ~= 0 then
					local var_251_28 = manager.audio:GetVoiceLength("story_v_out_322072", "322072059", "story_v_out_322072.awb") / 1000

					if var_251_28 + var_251_20 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_28 + var_251_20
					end

					if var_251_23.prefab_name ~= "" and arg_248_1.actors_[var_251_23.prefab_name] ~= nil then
						local var_251_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_23.prefab_name].transform, "story_v_out_322072", "322072059", "story_v_out_322072.awb")

						arg_248_1:RecordAudio("322072059", var_251_29)
						arg_248_1:RecordAudio("322072059", var_251_29)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_322072", "322072059", "story_v_out_322072.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_322072", "322072059", "story_v_out_322072.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_30 = math.max(var_251_21, arg_248_1.talkMaxDuration)

			if var_251_20 <= arg_248_1.time_ and arg_248_1.time_ < var_251_20 + var_251_30 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_20) / var_251_30

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_20 + var_251_30 and arg_248_1.time_ < var_251_20 + var_251_30 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play322072060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 322072060
		arg_252_1.duration_ = 7.1

		local var_252_0 = {
			zh = 3.766,
			ja = 7.1
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play322072061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 0

			if var_255_0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_0 + arg_255_0 then
				arg_252_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action9_1")
			end

			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 then
				local var_255_2 = arg_252_1.actors_["10103ui_story"]

				if not isNil(var_255_2) then
					local var_255_3 = GameObjectTools.GetOrAddComponent(var_255_2, typeof(DynamicBoneHelper))

					if var_255_3 then
						var_255_3:EnableDynamicBone(true)
					end
				end
			end

			local var_255_4 = 0
			local var_255_5 = 0.4

			if var_255_4 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_6 = arg_252_1:FormatText(StoryNameCfg[1214].name)

				arg_252_1.leftNameTxt_.text = var_255_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_7 = arg_252_1:GetWordFromCfg(322072060)
				local var_255_8 = arg_252_1:FormatText(var_255_7.content)

				arg_252_1.text_.text = var_255_8

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_9 = 16
				local var_255_10 = utf8.len(var_255_8)
				local var_255_11 = var_255_9 <= 0 and var_255_5 or var_255_5 * (var_255_10 / var_255_9)

				if var_255_11 > 0 and var_255_5 < var_255_11 then
					arg_252_1.talkMaxDuration = var_255_11

					if var_255_11 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_11 + var_255_4
					end
				end

				arg_252_1.text_.text = var_255_8
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072060", "story_v_out_322072.awb") ~= 0 then
					local var_255_12 = manager.audio:GetVoiceLength("story_v_out_322072", "322072060", "story_v_out_322072.awb") / 1000

					if var_255_12 + var_255_4 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_12 + var_255_4
					end

					if var_255_7.prefab_name ~= "" and arg_252_1.actors_[var_255_7.prefab_name] ~= nil then
						local var_255_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_7.prefab_name].transform, "story_v_out_322072", "322072060", "story_v_out_322072.awb")

						arg_252_1:RecordAudio("322072060", var_255_13)
						arg_252_1:RecordAudio("322072060", var_255_13)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_322072", "322072060", "story_v_out_322072.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_322072", "322072060", "story_v_out_322072.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_14 = math.max(var_255_5, arg_252_1.talkMaxDuration)

			if var_255_4 <= arg_252_1.time_ and arg_252_1.time_ < var_255_4 + var_255_14 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_4) / var_255_14

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_4 + var_255_14 and arg_252_1.time_ < var_255_4 + var_255_14 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play322072061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 322072061
		arg_256_1.duration_ = 2

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play322072062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["10150ui_story"].transform
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.var_.moveOldPos10150ui_story = var_259_0.localPosition

				local var_259_2 = GameObjectTools.GetOrAddComponent(var_259_0.gameObject, typeof(DynamicBoneHelper))

				if var_259_2 then
					var_259_2:EnableDynamicBone(false)
				end
			end

			local var_259_3 = 0.001

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_3 then
				local var_259_4 = (arg_256_1.time_ - var_259_1) / var_259_3
				local var_259_5 = Vector3.New(-0.9, -1.73, -5.5)

				var_259_0.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10150ui_story, var_259_5, var_259_4)

				local var_259_6 = manager.ui.mainCamera.transform.position - var_259_0.position

				var_259_0.forward = Vector3.New(var_259_6.x, var_259_6.y, var_259_6.z)

				local var_259_7 = var_259_0.localEulerAngles

				var_259_7.z = 0
				var_259_7.x = 0
				var_259_0.localEulerAngles = var_259_7
			end

			if arg_256_1.time_ >= var_259_1 + var_259_3 and arg_256_1.time_ < var_259_1 + var_259_3 + arg_259_0 then
				var_259_0.localPosition = Vector3.New(-0.9, -1.73, -5.5)

				local var_259_8 = manager.ui.mainCamera.transform.position - var_259_0.position

				var_259_0.forward = Vector3.New(var_259_8.x, var_259_8.y, var_259_8.z)

				local var_259_9 = var_259_0.localEulerAngles

				var_259_9.z = 0
				var_259_9.x = 0
				var_259_0.localEulerAngles = var_259_9

				local var_259_10 = GameObjectTools.GetOrAddComponent(var_259_0.gameObject, typeof(DynamicBoneHelper))

				if var_259_10 then
					var_259_10:EnableDynamicBone(true)
				end
			end

			local var_259_11 = arg_256_1.actors_["10150ui_story"]
			local var_259_12 = 0

			if var_259_12 < arg_256_1.time_ and arg_256_1.time_ <= var_259_12 + arg_259_0 and not isNil(var_259_11) and arg_256_1.var_.characterEffect10150ui_story == nil then
				arg_256_1.var_.characterEffect10150ui_story = var_259_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_13 = 0.200000002980232

			if var_259_12 <= arg_256_1.time_ and arg_256_1.time_ < var_259_12 + var_259_13 and not isNil(var_259_11) then
				local var_259_14 = (arg_256_1.time_ - var_259_12) / var_259_13

				if arg_256_1.var_.characterEffect10150ui_story and not isNil(var_259_11) then
					arg_256_1.var_.characterEffect10150ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_12 + var_259_13 and arg_256_1.time_ < var_259_12 + var_259_13 + arg_259_0 and not isNil(var_259_11) and arg_256_1.var_.characterEffect10150ui_story then
				arg_256_1.var_.characterEffect10150ui_story.fillFlat = false
			end

			local var_259_15 = arg_256_1.actors_["10103ui_story"]
			local var_259_16 = 0

			if var_259_16 < arg_256_1.time_ and arg_256_1.time_ <= var_259_16 + arg_259_0 and not isNil(var_259_15) and arg_256_1.var_.characterEffect10103ui_story == nil then
				arg_256_1.var_.characterEffect10103ui_story = var_259_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_17 = 0.200000002980232

			if var_259_16 <= arg_256_1.time_ and arg_256_1.time_ < var_259_16 + var_259_17 and not isNil(var_259_15) then
				local var_259_18 = (arg_256_1.time_ - var_259_16) / var_259_17

				if arg_256_1.var_.characterEffect10103ui_story and not isNil(var_259_15) then
					local var_259_19 = Mathf.Lerp(0, 0.5, var_259_18)

					arg_256_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_256_1.var_.characterEffect10103ui_story.fillRatio = var_259_19
				end
			end

			if arg_256_1.time_ >= var_259_16 + var_259_17 and arg_256_1.time_ < var_259_16 + var_259_17 + arg_259_0 and not isNil(var_259_15) and arg_256_1.var_.characterEffect10103ui_story then
				local var_259_20 = 0.5

				arg_256_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_256_1.var_.characterEffect10103ui_story.fillRatio = var_259_20
			end

			local var_259_21 = 0

			if var_259_21 < arg_256_1.time_ and arg_256_1.time_ <= var_259_21 + arg_259_0 then
				arg_256_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/story10150/story10150action/10150action1_1")
			end

			local var_259_22 = 0

			if var_259_22 < arg_256_1.time_ and arg_256_1.time_ <= var_259_22 + arg_259_0 then
				arg_256_1:PlayTimeline("10150ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_259_23 = arg_256_1.actors_["10103ui_story"].transform
			local var_259_24 = 0

			if var_259_24 < arg_256_1.time_ and arg_256_1.time_ <= var_259_24 + arg_259_0 then
				arg_256_1.var_.moveOldPos10103ui_story = var_259_23.localPosition

				local var_259_25 = GameObjectTools.GetOrAddComponent(var_259_23.gameObject, typeof(DynamicBoneHelper))

				if var_259_25 then
					var_259_25:EnableDynamicBone(false)
				end
			end

			local var_259_26 = 0.001

			if var_259_24 <= arg_256_1.time_ and arg_256_1.time_ < var_259_24 + var_259_26 then
				local var_259_27 = (arg_256_1.time_ - var_259_24) / var_259_26
				local var_259_28 = Vector3.New(0.7, -0.95, -6.2)

				var_259_23.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos10103ui_story, var_259_28, var_259_27)

				local var_259_29 = manager.ui.mainCamera.transform.position - var_259_23.position

				var_259_23.forward = Vector3.New(var_259_29.x, var_259_29.y, var_259_29.z)

				local var_259_30 = var_259_23.localEulerAngles

				var_259_30.z = 0
				var_259_30.x = 0
				var_259_23.localEulerAngles = var_259_30
			end

			if arg_256_1.time_ >= var_259_24 + var_259_26 and arg_256_1.time_ < var_259_24 + var_259_26 + arg_259_0 then
				var_259_23.localPosition = Vector3.New(0.7, -0.95, -6.2)

				local var_259_31 = manager.ui.mainCamera.transform.position - var_259_23.position

				var_259_23.forward = Vector3.New(var_259_31.x, var_259_31.y, var_259_31.z)

				local var_259_32 = var_259_23.localEulerAngles

				var_259_32.z = 0
				var_259_32.x = 0
				var_259_23.localEulerAngles = var_259_32

				local var_259_33 = GameObjectTools.GetOrAddComponent(var_259_23.gameObject, typeof(DynamicBoneHelper))

				if var_259_33 then
					var_259_33:EnableDynamicBone(true)
				end
			end

			local var_259_34 = 0
			local var_259_35 = 0.1

			if var_259_34 < arg_256_1.time_ and arg_256_1.time_ <= var_259_34 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_36 = arg_256_1:FormatText(StoryNameCfg[1361].name)

				arg_256_1.leftNameTxt_.text = var_259_36

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_37 = arg_256_1:GetWordFromCfg(322072061)
				local var_259_38 = arg_256_1:FormatText(var_259_37.content)

				arg_256_1.text_.text = var_259_38

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_39 = 4
				local var_259_40 = utf8.len(var_259_38)
				local var_259_41 = var_259_39 <= 0 and var_259_35 or var_259_35 * (var_259_40 / var_259_39)

				if var_259_41 > 0 and var_259_35 < var_259_41 then
					arg_256_1.talkMaxDuration = var_259_41

					if var_259_41 + var_259_34 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_41 + var_259_34
					end
				end

				arg_256_1.text_.text = var_259_38
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072061", "story_v_out_322072.awb") ~= 0 then
					local var_259_42 = manager.audio:GetVoiceLength("story_v_out_322072", "322072061", "story_v_out_322072.awb") / 1000

					if var_259_42 + var_259_34 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_42 + var_259_34
					end

					if var_259_37.prefab_name ~= "" and arg_256_1.actors_[var_259_37.prefab_name] ~= nil then
						local var_259_43 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_37.prefab_name].transform, "story_v_out_322072", "322072061", "story_v_out_322072.awb")

						arg_256_1:RecordAudio("322072061", var_259_43)
						arg_256_1:RecordAudio("322072061", var_259_43)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_322072", "322072061", "story_v_out_322072.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_322072", "322072061", "story_v_out_322072.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_44 = math.max(var_259_35, arg_256_1.talkMaxDuration)

			if var_259_34 <= arg_256_1.time_ and arg_256_1.time_ < var_259_34 + var_259_44 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_34) / var_259_44

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_34 + var_259_44 and arg_256_1.time_ < var_259_34 + var_259_44 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play322072062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 322072062
		arg_260_1.duration_ = 6.77

		local var_260_0 = {
			zh = 4.633,
			ja = 6.766
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play322072063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["10103ui_story"].transform
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.var_.moveOldPos10103ui_story = var_263_0.localPosition

				local var_263_2 = GameObjectTools.GetOrAddComponent(var_263_0.gameObject, typeof(DynamicBoneHelper))

				if var_263_2 then
					var_263_2:EnableDynamicBone(false)
				end
			end

			local var_263_3 = 0.001

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_3 then
				local var_263_4 = (arg_260_1.time_ - var_263_1) / var_263_3
				local var_263_5 = Vector3.New(0.7, -0.95, -6.2)

				var_263_0.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10103ui_story, var_263_5, var_263_4)

				local var_263_6 = manager.ui.mainCamera.transform.position - var_263_0.position

				var_263_0.forward = Vector3.New(var_263_6.x, var_263_6.y, var_263_6.z)

				local var_263_7 = var_263_0.localEulerAngles

				var_263_7.z = 0
				var_263_7.x = 0
				var_263_0.localEulerAngles = var_263_7
			end

			if arg_260_1.time_ >= var_263_1 + var_263_3 and arg_260_1.time_ < var_263_1 + var_263_3 + arg_263_0 then
				var_263_0.localPosition = Vector3.New(0.7, -0.95, -6.2)

				local var_263_8 = manager.ui.mainCamera.transform.position - var_263_0.position

				var_263_0.forward = Vector3.New(var_263_8.x, var_263_8.y, var_263_8.z)

				local var_263_9 = var_263_0.localEulerAngles

				var_263_9.z = 0
				var_263_9.x = 0
				var_263_0.localEulerAngles = var_263_9

				local var_263_10 = GameObjectTools.GetOrAddComponent(var_263_0.gameObject, typeof(DynamicBoneHelper))

				if var_263_10 then
					var_263_10:EnableDynamicBone(true)
				end
			end

			local var_263_11 = arg_260_1.actors_["10103ui_story"]
			local var_263_12 = 0

			if var_263_12 < arg_260_1.time_ and arg_260_1.time_ <= var_263_12 + arg_263_0 and not isNil(var_263_11) and arg_260_1.var_.characterEffect10103ui_story == nil then
				arg_260_1.var_.characterEffect10103ui_story = var_263_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_13 = 0.200000002980232

			if var_263_12 <= arg_260_1.time_ and arg_260_1.time_ < var_263_12 + var_263_13 and not isNil(var_263_11) then
				local var_263_14 = (arg_260_1.time_ - var_263_12) / var_263_13

				if arg_260_1.var_.characterEffect10103ui_story and not isNil(var_263_11) then
					arg_260_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= var_263_12 + var_263_13 and arg_260_1.time_ < var_263_12 + var_263_13 + arg_263_0 and not isNil(var_263_11) and arg_260_1.var_.characterEffect10103ui_story then
				arg_260_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_263_15 = arg_260_1.actors_["10150ui_story"]
			local var_263_16 = 0

			if var_263_16 < arg_260_1.time_ and arg_260_1.time_ <= var_263_16 + arg_263_0 and not isNil(var_263_15) and arg_260_1.var_.characterEffect10150ui_story == nil then
				arg_260_1.var_.characterEffect10150ui_story = var_263_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_17 = 0.200000002980232

			if var_263_16 <= arg_260_1.time_ and arg_260_1.time_ < var_263_16 + var_263_17 and not isNil(var_263_15) then
				local var_263_18 = (arg_260_1.time_ - var_263_16) / var_263_17

				if arg_260_1.var_.characterEffect10150ui_story and not isNil(var_263_15) then
					local var_263_19 = Mathf.Lerp(0, 0.5, var_263_18)

					arg_260_1.var_.characterEffect10150ui_story.fillFlat = true
					arg_260_1.var_.characterEffect10150ui_story.fillRatio = var_263_19
				end
			end

			if arg_260_1.time_ >= var_263_16 + var_263_17 and arg_260_1.time_ < var_263_16 + var_263_17 + arg_263_0 and not isNil(var_263_15) and arg_260_1.var_.characterEffect10150ui_story then
				local var_263_20 = 0.5

				arg_260_1.var_.characterEffect10150ui_story.fillFlat = true
				arg_260_1.var_.characterEffect10150ui_story.fillRatio = var_263_20
			end

			local var_263_21 = 0

			if var_263_21 < arg_260_1.time_ and arg_260_1.time_ <= var_263_21 + arg_263_0 then
				arg_260_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action9_2")
			end

			local var_263_22 = 0

			if var_263_22 < arg_260_1.time_ and arg_260_1.time_ <= var_263_22 + arg_263_0 then
				local var_263_23 = arg_260_1.actors_["10103ui_story"]

				if not isNil(var_263_23) then
					local var_263_24 = GameObjectTools.GetOrAddComponent(var_263_23, typeof(DynamicBoneHelper))

					if var_263_24 then
						var_263_24:EnableDynamicBone(true)
					end
				end
			end

			local var_263_25 = 0
			local var_263_26 = 0.475

			if var_263_25 < arg_260_1.time_ and arg_260_1.time_ <= var_263_25 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				local var_263_27 = arg_260_1:FormatText(StoryNameCfg[1214].name)

				arg_260_1.leftNameTxt_.text = var_263_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_28 = arg_260_1:GetWordFromCfg(322072062)
				local var_263_29 = arg_260_1:FormatText(var_263_28.content)

				arg_260_1.text_.text = var_263_29

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_30 = 19
				local var_263_31 = utf8.len(var_263_29)
				local var_263_32 = var_263_30 <= 0 and var_263_26 or var_263_26 * (var_263_31 / var_263_30)

				if var_263_32 > 0 and var_263_26 < var_263_32 then
					arg_260_1.talkMaxDuration = var_263_32

					if var_263_32 + var_263_25 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_32 + var_263_25
					end
				end

				arg_260_1.text_.text = var_263_29
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072062", "story_v_out_322072.awb") ~= 0 then
					local var_263_33 = manager.audio:GetVoiceLength("story_v_out_322072", "322072062", "story_v_out_322072.awb") / 1000

					if var_263_33 + var_263_25 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_33 + var_263_25
					end

					if var_263_28.prefab_name ~= "" and arg_260_1.actors_[var_263_28.prefab_name] ~= nil then
						local var_263_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_28.prefab_name].transform, "story_v_out_322072", "322072062", "story_v_out_322072.awb")

						arg_260_1:RecordAudio("322072062", var_263_34)
						arg_260_1:RecordAudio("322072062", var_263_34)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_322072", "322072062", "story_v_out_322072.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_322072", "322072062", "story_v_out_322072.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_35 = math.max(var_263_26, arg_260_1.talkMaxDuration)

			if var_263_25 <= arg_260_1.time_ and arg_260_1.time_ < var_263_25 + var_263_35 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_25) / var_263_35

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_25 + var_263_35 and arg_260_1.time_ < var_263_25 + var_263_35 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play322072063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 322072063
		arg_264_1.duration_ = 15.3

		local var_264_0 = {
			zh = 13.733,
			ja = 15.3
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play322072064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = "ST0510"

			if arg_264_1.bgs_[var_267_0] == nil then
				local var_267_1 = Object.Instantiate(arg_264_1.paintGo_)

				var_267_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_267_0)
				var_267_1.name = var_267_0
				var_267_1.transform.parent = arg_264_1.stage_.transform
				var_267_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_264_1.bgs_[var_267_0] = var_267_1
			end

			local var_267_2 = 2

			if var_267_2 < arg_264_1.time_ and arg_264_1.time_ <= var_267_2 + arg_267_0 then
				local var_267_3 = manager.ui.mainCamera.transform.localPosition
				local var_267_4 = Vector3.New(0, 0, 10) + Vector3.New(var_267_3.x, var_267_3.y, 0)
				local var_267_5 = arg_264_1.bgs_.ST0510

				var_267_5.transform.localPosition = var_267_4
				var_267_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_267_6 = var_267_5:GetComponent("SpriteRenderer")

				if var_267_6 and var_267_6.sprite then
					local var_267_7 = (var_267_5.transform.localPosition - var_267_3).z
					local var_267_8 = manager.ui.mainCameraCom_
					local var_267_9 = 2 * var_267_7 * Mathf.Tan(var_267_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_267_10 = var_267_9 * var_267_8.aspect
					local var_267_11 = var_267_6.sprite.bounds.size.x
					local var_267_12 = var_267_6.sprite.bounds.size.y
					local var_267_13 = var_267_10 / var_267_11
					local var_267_14 = var_267_9 / var_267_12
					local var_267_15 = var_267_14 < var_267_13 and var_267_13 or var_267_14

					var_267_5.transform.localScale = Vector3.New(var_267_15, var_267_15, 0)
				end

				for iter_267_0, iter_267_1 in pairs(arg_264_1.bgs_) do
					if iter_267_0 ~= "ST0510" then
						iter_267_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_267_16 = 4

			if var_267_16 < arg_264_1.time_ and arg_264_1.time_ <= var_267_16 + arg_267_0 then
				arg_264_1.allBtn_.enabled = false
			end

			local var_267_17 = 0.3

			if arg_264_1.time_ >= var_267_16 + var_267_17 and arg_264_1.time_ < var_267_16 + var_267_17 + arg_267_0 then
				arg_264_1.allBtn_.enabled = true
			end

			local var_267_18 = 0

			if var_267_18 < arg_264_1.time_ and arg_264_1.time_ <= var_267_18 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_19 = 2

			if var_267_18 <= arg_264_1.time_ and arg_264_1.time_ < var_267_18 + var_267_19 then
				local var_267_20 = (arg_264_1.time_ - var_267_18) / var_267_19
				local var_267_21 = Color.New(0, 0, 0)

				var_267_21.a = Mathf.Lerp(0, 1, var_267_20)
				arg_264_1.mask_.color = var_267_21
			end

			if arg_264_1.time_ >= var_267_18 + var_267_19 and arg_264_1.time_ < var_267_18 + var_267_19 + arg_267_0 then
				local var_267_22 = Color.New(0, 0, 0)

				var_267_22.a = 1
				arg_264_1.mask_.color = var_267_22
			end

			local var_267_23 = 2

			if var_267_23 < arg_264_1.time_ and arg_264_1.time_ <= var_267_23 + arg_267_0 then
				arg_264_1.mask_.enabled = true
				arg_264_1.mask_.raycastTarget = true

				arg_264_1:SetGaussion(false)
			end

			local var_267_24 = 2

			if var_267_23 <= arg_264_1.time_ and arg_264_1.time_ < var_267_23 + var_267_24 then
				local var_267_25 = (arg_264_1.time_ - var_267_23) / var_267_24
				local var_267_26 = Color.New(0, 0, 0)

				var_267_26.a = Mathf.Lerp(1, 0, var_267_25)
				arg_264_1.mask_.color = var_267_26
			end

			if arg_264_1.time_ >= var_267_23 + var_267_24 and arg_264_1.time_ < var_267_23 + var_267_24 + arg_267_0 then
				local var_267_27 = Color.New(0, 0, 0)
				local var_267_28 = 0

				arg_264_1.mask_.enabled = false
				var_267_27.a = var_267_28
				arg_264_1.mask_.color = var_267_27
			end

			local var_267_29 = arg_264_1.actors_["10103ui_story"].transform
			local var_267_30 = 1.96599999815226

			if var_267_30 < arg_264_1.time_ and arg_264_1.time_ <= var_267_30 + arg_267_0 then
				arg_264_1.var_.moveOldPos10103ui_story = var_267_29.localPosition

				local var_267_31 = GameObjectTools.GetOrAddComponent(var_267_29.gameObject, typeof(DynamicBoneHelper))

				if var_267_31 then
					var_267_31:EnableDynamicBone(false)
				end
			end

			local var_267_32 = 0.001

			if var_267_30 <= arg_264_1.time_ and arg_264_1.time_ < var_267_30 + var_267_32 then
				local var_267_33 = (arg_264_1.time_ - var_267_30) / var_267_32
				local var_267_34 = Vector3.New(0, 100, 0)

				var_267_29.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10103ui_story, var_267_34, var_267_33)

				local var_267_35 = manager.ui.mainCamera.transform.position - var_267_29.position

				var_267_29.forward = Vector3.New(var_267_35.x, var_267_35.y, var_267_35.z)

				local var_267_36 = var_267_29.localEulerAngles

				var_267_36.z = 0
				var_267_36.x = 0
				var_267_29.localEulerAngles = var_267_36
			end

			if arg_264_1.time_ >= var_267_30 + var_267_32 and arg_264_1.time_ < var_267_30 + var_267_32 + arg_267_0 then
				var_267_29.localPosition = Vector3.New(0, 100, 0)

				local var_267_37 = manager.ui.mainCamera.transform.position - var_267_29.position

				var_267_29.forward = Vector3.New(var_267_37.x, var_267_37.y, var_267_37.z)

				local var_267_38 = var_267_29.localEulerAngles

				var_267_38.z = 0
				var_267_38.x = 0
				var_267_29.localEulerAngles = var_267_38

				local var_267_39 = GameObjectTools.GetOrAddComponent(var_267_29.gameObject, typeof(DynamicBoneHelper))

				if var_267_39 then
					var_267_39:EnableDynamicBone(true)
				end
			end

			local var_267_40 = arg_264_1.actors_["10103ui_story"].transform
			local var_267_41 = 3.8

			if var_267_41 < arg_264_1.time_ and arg_264_1.time_ <= var_267_41 + arg_267_0 then
				arg_264_1.var_.moveOldPos10103ui_story = var_267_40.localPosition

				local var_267_42 = GameObjectTools.GetOrAddComponent(var_267_40.gameObject, typeof(DynamicBoneHelper))

				if var_267_42 then
					var_267_42:EnableDynamicBone(false)
				end
			end

			local var_267_43 = 0.001

			if var_267_41 <= arg_264_1.time_ and arg_264_1.time_ < var_267_41 + var_267_43 then
				local var_267_44 = (arg_264_1.time_ - var_267_41) / var_267_43
				local var_267_45 = Vector3.New(0, -0.95, -6.2)

				var_267_40.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10103ui_story, var_267_45, var_267_44)

				local var_267_46 = manager.ui.mainCamera.transform.position - var_267_40.position

				var_267_40.forward = Vector3.New(var_267_46.x, var_267_46.y, var_267_46.z)

				local var_267_47 = var_267_40.localEulerAngles

				var_267_47.z = 0
				var_267_47.x = 0
				var_267_40.localEulerAngles = var_267_47
			end

			if arg_264_1.time_ >= var_267_41 + var_267_43 and arg_264_1.time_ < var_267_41 + var_267_43 + arg_267_0 then
				var_267_40.localPosition = Vector3.New(0, -0.95, -6.2)

				local var_267_48 = manager.ui.mainCamera.transform.position - var_267_40.position

				var_267_40.forward = Vector3.New(var_267_48.x, var_267_48.y, var_267_48.z)

				local var_267_49 = var_267_40.localEulerAngles

				var_267_49.z = 0
				var_267_49.x = 0
				var_267_40.localEulerAngles = var_267_49

				local var_267_50 = GameObjectTools.GetOrAddComponent(var_267_40.gameObject, typeof(DynamicBoneHelper))

				if var_267_50 then
					var_267_50:EnableDynamicBone(true)
				end
			end

			local var_267_51 = arg_264_1.actors_["10150ui_story"].transform
			local var_267_52 = 1.96599999815226

			if var_267_52 < arg_264_1.time_ and arg_264_1.time_ <= var_267_52 + arg_267_0 then
				arg_264_1.var_.moveOldPos10150ui_story = var_267_51.localPosition

				local var_267_53 = GameObjectTools.GetOrAddComponent(var_267_51.gameObject, typeof(DynamicBoneHelper))

				if var_267_53 then
					var_267_53:EnableDynamicBone(false)
				end
			end

			local var_267_54 = 0.001

			if var_267_52 <= arg_264_1.time_ and arg_264_1.time_ < var_267_52 + var_267_54 then
				local var_267_55 = (arg_264_1.time_ - var_267_52) / var_267_54
				local var_267_56 = Vector3.New(0, 100, 0)

				var_267_51.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10150ui_story, var_267_56, var_267_55)

				local var_267_57 = manager.ui.mainCamera.transform.position - var_267_51.position

				var_267_51.forward = Vector3.New(var_267_57.x, var_267_57.y, var_267_57.z)

				local var_267_58 = var_267_51.localEulerAngles

				var_267_58.z = 0
				var_267_58.x = 0
				var_267_51.localEulerAngles = var_267_58
			end

			if arg_264_1.time_ >= var_267_52 + var_267_54 and arg_264_1.time_ < var_267_52 + var_267_54 + arg_267_0 then
				var_267_51.localPosition = Vector3.New(0, 100, 0)

				local var_267_59 = manager.ui.mainCamera.transform.position - var_267_51.position

				var_267_51.forward = Vector3.New(var_267_59.x, var_267_59.y, var_267_59.z)

				local var_267_60 = var_267_51.localEulerAngles

				var_267_60.z = 0
				var_267_60.x = 0
				var_267_51.localEulerAngles = var_267_60

				local var_267_61 = GameObjectTools.GetOrAddComponent(var_267_51.gameObject, typeof(DynamicBoneHelper))

				if var_267_61 then
					var_267_61:EnableDynamicBone(true)
				end
			end

			local var_267_62 = 3.8

			if var_267_62 < arg_264_1.time_ and arg_264_1.time_ <= var_267_62 + arg_267_0 then
				arg_264_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action1_1")
			end

			local var_267_63 = 3.8

			if var_267_63 < arg_264_1.time_ and arg_264_1.time_ <= var_267_63 + arg_267_0 then
				arg_264_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_267_64 = 0.2
			local var_267_65 = 1

			if var_267_64 < arg_264_1.time_ and arg_264_1.time_ <= var_267_64 + arg_267_0 then
				local var_267_66 = "stop"
				local var_267_67 = "effect"

				arg_264_1:AudioAction(var_267_66, var_267_67, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_267_68 = 1.56666666666667
			local var_267_69 = 1

			if var_267_68 < arg_264_1.time_ and arg_264_1.time_ <= var_267_68 + arg_267_0 then
				local var_267_70 = "play"
				local var_267_71 = "effect"

				arg_264_1:AudioAction(var_267_70, var_267_71, "se_story_145", "se_story_145_amb_data", "")
			end

			local var_267_72 = 1.96599999815226

			arg_264_1.isInRecall_ = false

			if var_267_72 < arg_264_1.time_ and arg_264_1.time_ <= var_267_72 + arg_267_0 then
				arg_264_1.screenFilterGo_:SetActive(false)

				for iter_267_2, iter_267_3 in pairs(arg_264_1.actors_) do
					local var_267_73 = iter_267_3:GetComponentsInChildren(typeof(Image), true):ToTable()

					for iter_267_4, iter_267_5 in ipairs(var_267_73) do
						if iter_267_5.color.r > 0.51 then
							iter_267_5.color = Color.New(1, 1, 1)
						else
							iter_267_5.color = Color.New(0.5, 0.5, 0.5)
						end
					end
				end
			end

			local var_267_74 = 0.0166666666666667

			if var_267_72 <= arg_264_1.time_ and arg_264_1.time_ < var_267_72 + var_267_74 then
				local var_267_75 = (arg_264_1.time_ - var_267_72) / var_267_74

				arg_264_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, var_267_75)
			end

			if arg_264_1.time_ >= var_267_72 + var_267_74 and arg_264_1.time_ < var_267_72 + var_267_74 + arg_267_0 then
				arg_264_1.screenFilterEffect_.weight = 0
			end

			local var_267_76 = arg_264_1.actors_["10103ui_story"]
			local var_267_77 = 3.83400000184774

			if var_267_77 < arg_264_1.time_ and arg_264_1.time_ <= var_267_77 + arg_267_0 and not isNil(var_267_76) and arg_264_1.var_.characterEffect10103ui_story == nil then
				arg_264_1.var_.characterEffect10103ui_story = var_267_76:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_78 = 0.200000002980232

			if var_267_77 <= arg_264_1.time_ and arg_264_1.time_ < var_267_77 + var_267_78 and not isNil(var_267_76) then
				local var_267_79 = (arg_264_1.time_ - var_267_77) / var_267_78

				if arg_264_1.var_.characterEffect10103ui_story and not isNil(var_267_76) then
					arg_264_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= var_267_77 + var_267_78 and arg_264_1.time_ < var_267_77 + var_267_78 + arg_267_0 and not isNil(var_267_76) and arg_264_1.var_.characterEffect10103ui_story then
				arg_264_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_267_80 = 3.83400000184774

			if var_267_80 < arg_264_1.time_ and arg_264_1.time_ <= var_267_80 + arg_267_0 then
				local var_267_81 = arg_264_1.actors_["10103ui_story"]

				if not isNil(var_267_81) then
					local var_267_82 = GameObjectTools.GetOrAddComponent(var_267_81, typeof(DynamicBoneHelper))

					if var_267_82 then
						var_267_82:EnableDynamicBone(true)
					end
				end
			end

			if arg_264_1.frameCnt_ <= 1 then
				arg_264_1.dialog_:SetActive(false)
			end

			local var_267_83 = 4
			local var_267_84 = 1.1

			if var_267_83 < arg_264_1.time_ and arg_264_1.time_ <= var_267_83 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0

				arg_264_1.dialog_:SetActive(true)

				arg_264_1.dialogCg_.alpha = 0

				local var_267_85 = LeanTween.value(arg_264_1.dialog_, 0, 1, 0.3)

				var_267_85:setOnUpdate(LuaHelper.FloatAction(function(arg_268_0)
					arg_264_1.dialogCg_.alpha = arg_268_0
				end))
				var_267_85:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_264_1.dialog_)
					var_267_85:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_264_1.duration_ = arg_264_1.duration_ + 0.3

				SetActive(arg_264_1.leftNameGo_, true)

				local var_267_86 = arg_264_1:FormatText(StoryNameCfg[1214].name)

				arg_264_1.leftNameTxt_.text = var_267_86

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_87 = arg_264_1:GetWordFromCfg(322072063)
				local var_267_88 = arg_264_1:FormatText(var_267_87.content)

				arg_264_1.text_.text = var_267_88

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_89 = 44
				local var_267_90 = utf8.len(var_267_88)
				local var_267_91 = var_267_89 <= 0 and var_267_84 or var_267_84 * (var_267_90 / var_267_89)

				if var_267_91 > 0 and var_267_84 < var_267_91 then
					arg_264_1.talkMaxDuration = var_267_91
					var_267_83 = var_267_83 + 0.3

					if var_267_91 + var_267_83 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_91 + var_267_83
					end
				end

				arg_264_1.text_.text = var_267_88
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072063", "story_v_out_322072.awb") ~= 0 then
					local var_267_92 = manager.audio:GetVoiceLength("story_v_out_322072", "322072063", "story_v_out_322072.awb") / 1000

					if var_267_92 + var_267_83 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_92 + var_267_83
					end

					if var_267_87.prefab_name ~= "" and arg_264_1.actors_[var_267_87.prefab_name] ~= nil then
						local var_267_93 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_87.prefab_name].transform, "story_v_out_322072", "322072063", "story_v_out_322072.awb")

						arg_264_1:RecordAudio("322072063", var_267_93)
						arg_264_1:RecordAudio("322072063", var_267_93)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_322072", "322072063", "story_v_out_322072.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_322072", "322072063", "story_v_out_322072.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_94 = var_267_83 + 0.3
			local var_267_95 = math.max(var_267_84, arg_264_1.talkMaxDuration)

			if var_267_94 <= arg_264_1.time_ and arg_264_1.time_ < var_267_94 + var_267_95 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_94) / var_267_95

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_94 + var_267_95 and arg_264_1.time_ < var_267_94 + var_267_95 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10150ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play322072064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 322072064
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play322072065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0.1
			local var_273_1 = 1

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				local var_273_2 = "play"
				local var_273_3 = "effect"

				arg_270_1:AudioAction(var_273_2, var_273_3, "se_story_145", "se_story_145_footstep03", "")
			end

			local var_273_4 = arg_270_1.actors_["10103ui_story"].transform
			local var_273_5 = 0

			if var_273_5 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 then
				arg_270_1.var_.moveOldPos10103ui_story = var_273_4.localPosition

				local var_273_6 = GameObjectTools.GetOrAddComponent(var_273_4.gameObject, typeof(DynamicBoneHelper))

				if var_273_6 then
					var_273_6:EnableDynamicBone(false)
				end
			end

			local var_273_7 = 0.001

			if var_273_5 <= arg_270_1.time_ and arg_270_1.time_ < var_273_5 + var_273_7 then
				local var_273_8 = (arg_270_1.time_ - var_273_5) / var_273_7
				local var_273_9 = Vector3.New(0, 100, 0)

				var_273_4.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos10103ui_story, var_273_9, var_273_8)

				local var_273_10 = manager.ui.mainCamera.transform.position - var_273_4.position

				var_273_4.forward = Vector3.New(var_273_10.x, var_273_10.y, var_273_10.z)

				local var_273_11 = var_273_4.localEulerAngles

				var_273_11.z = 0
				var_273_11.x = 0
				var_273_4.localEulerAngles = var_273_11
			end

			if arg_270_1.time_ >= var_273_5 + var_273_7 and arg_270_1.time_ < var_273_5 + var_273_7 + arg_273_0 then
				var_273_4.localPosition = Vector3.New(0, 100, 0)

				local var_273_12 = manager.ui.mainCamera.transform.position - var_273_4.position

				var_273_4.forward = Vector3.New(var_273_12.x, var_273_12.y, var_273_12.z)

				local var_273_13 = var_273_4.localEulerAngles

				var_273_13.z = 0
				var_273_13.x = 0
				var_273_4.localEulerAngles = var_273_13

				local var_273_14 = GameObjectTools.GetOrAddComponent(var_273_4.gameObject, typeof(DynamicBoneHelper))

				if var_273_14 then
					var_273_14:EnableDynamicBone(true)
				end
			end

			local var_273_15 = 0
			local var_273_16 = 1.1

			if var_273_15 < arg_270_1.time_ and arg_270_1.time_ <= var_273_15 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_17 = arg_270_1:GetWordFromCfg(322072064)
				local var_273_18 = arg_270_1:FormatText(var_273_17.content)

				arg_270_1.text_.text = var_273_18

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_19 = 44
				local var_273_20 = utf8.len(var_273_18)
				local var_273_21 = var_273_19 <= 0 and var_273_16 or var_273_16 * (var_273_20 / var_273_19)

				if var_273_21 > 0 and var_273_16 < var_273_21 then
					arg_270_1.talkMaxDuration = var_273_21

					if var_273_21 + var_273_15 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_21 + var_273_15
					end
				end

				arg_270_1.text_.text = var_273_18
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_22 = math.max(var_273_16, arg_270_1.talkMaxDuration)

			if var_273_15 <= arg_270_1.time_ and arg_270_1.time_ < var_273_15 + var_273_22 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_15) / var_273_22

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_15 + var_273_22 and arg_270_1.time_ < var_273_15 + var_273_22 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play322072065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 322072065
		arg_274_1.duration_ = 6.3

		local var_274_0 = {
			zh = 6.3,
			ja = 6.1
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play322072066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = arg_274_1.actors_["10103ui_story"].transform
			local var_277_1 = 0

			if var_277_1 < arg_274_1.time_ and arg_274_1.time_ <= var_277_1 + arg_277_0 then
				arg_274_1.var_.moveOldPos10103ui_story = var_277_0.localPosition

				local var_277_2 = GameObjectTools.GetOrAddComponent(var_277_0.gameObject, typeof(DynamicBoneHelper))

				if var_277_2 then
					var_277_2:EnableDynamicBone(false)
				end
			end

			local var_277_3 = 0.001

			if var_277_1 <= arg_274_1.time_ and arg_274_1.time_ < var_277_1 + var_277_3 then
				local var_277_4 = (arg_274_1.time_ - var_277_1) / var_277_3
				local var_277_5 = Vector3.New(0, -0.95, -6.2)

				var_277_0.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos10103ui_story, var_277_5, var_277_4)

				local var_277_6 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_6.x, var_277_6.y, var_277_6.z)

				local var_277_7 = var_277_0.localEulerAngles

				var_277_7.z = 0
				var_277_7.x = 0
				var_277_0.localEulerAngles = var_277_7
			end

			if arg_274_1.time_ >= var_277_1 + var_277_3 and arg_274_1.time_ < var_277_1 + var_277_3 + arg_277_0 then
				var_277_0.localPosition = Vector3.New(0, -0.95, -6.2)

				local var_277_8 = manager.ui.mainCamera.transform.position - var_277_0.position

				var_277_0.forward = Vector3.New(var_277_8.x, var_277_8.y, var_277_8.z)

				local var_277_9 = var_277_0.localEulerAngles

				var_277_9.z = 0
				var_277_9.x = 0
				var_277_0.localEulerAngles = var_277_9

				local var_277_10 = GameObjectTools.GetOrAddComponent(var_277_0.gameObject, typeof(DynamicBoneHelper))

				if var_277_10 then
					var_277_10:EnableDynamicBone(true)
				end
			end

			local var_277_11 = arg_274_1.actors_["10103ui_story"]
			local var_277_12 = 0

			if var_277_12 < arg_274_1.time_ and arg_274_1.time_ <= var_277_12 + arg_277_0 and not isNil(var_277_11) and arg_274_1.var_.characterEffect10103ui_story == nil then
				arg_274_1.var_.characterEffect10103ui_story = var_277_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_13 = 0.200000002980232

			if var_277_12 <= arg_274_1.time_ and arg_274_1.time_ < var_277_12 + var_277_13 and not isNil(var_277_11) then
				local var_277_14 = (arg_274_1.time_ - var_277_12) / var_277_13

				if arg_274_1.var_.characterEffect10103ui_story and not isNil(var_277_11) then
					arg_274_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= var_277_12 + var_277_13 and arg_274_1.time_ < var_277_12 + var_277_13 + arg_277_0 and not isNil(var_277_11) and arg_274_1.var_.characterEffect10103ui_story then
				arg_274_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_277_15 = 0

			if var_277_15 < arg_274_1.time_ and arg_274_1.time_ <= var_277_15 + arg_277_0 then
				arg_274_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_1")
			end

			local var_277_16 = 0

			if var_277_16 < arg_274_1.time_ and arg_274_1.time_ <= var_277_16 + arg_277_0 then
				arg_274_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileD", "EmotionTimelineAnimator")
			end

			local var_277_17 = 0

			if var_277_17 < arg_274_1.time_ and arg_274_1.time_ <= var_277_17 + arg_277_0 then
				local var_277_18 = arg_274_1.actors_["10103ui_story"]

				if not isNil(var_277_18) then
					local var_277_19 = GameObjectTools.GetOrAddComponent(var_277_18, typeof(DynamicBoneHelper))

					if var_277_19 then
						var_277_19:EnableDynamicBone(true)
					end
				end
			end

			local var_277_20 = 0
			local var_277_21 = 0.375

			if var_277_20 < arg_274_1.time_ and arg_274_1.time_ <= var_277_20 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_22 = arg_274_1:FormatText(StoryNameCfg[1214].name)

				arg_274_1.leftNameTxt_.text = var_277_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_23 = arg_274_1:GetWordFromCfg(322072065)
				local var_277_24 = arg_274_1:FormatText(var_277_23.content)

				arg_274_1.text_.text = var_277_24

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_25 = 15
				local var_277_26 = utf8.len(var_277_24)
				local var_277_27 = var_277_25 <= 0 and var_277_21 or var_277_21 * (var_277_26 / var_277_25)

				if var_277_27 > 0 and var_277_21 < var_277_27 then
					arg_274_1.talkMaxDuration = var_277_27

					if var_277_27 + var_277_20 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_27 + var_277_20
					end
				end

				arg_274_1.text_.text = var_277_24
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072065", "story_v_out_322072.awb") ~= 0 then
					local var_277_28 = manager.audio:GetVoiceLength("story_v_out_322072", "322072065", "story_v_out_322072.awb") / 1000

					if var_277_28 + var_277_20 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_28 + var_277_20
					end

					if var_277_23.prefab_name ~= "" and arg_274_1.actors_[var_277_23.prefab_name] ~= nil then
						local var_277_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_23.prefab_name].transform, "story_v_out_322072", "322072065", "story_v_out_322072.awb")

						arg_274_1:RecordAudio("322072065", var_277_29)
						arg_274_1:RecordAudio("322072065", var_277_29)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_322072", "322072065", "story_v_out_322072.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_322072", "322072065", "story_v_out_322072.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_30 = math.max(var_277_21, arg_274_1.talkMaxDuration)

			if var_277_20 <= arg_274_1.time_ and arg_274_1.time_ < var_277_20 + var_277_30 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_20) / var_277_30

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_20 + var_277_30 and arg_274_1.time_ < var_277_20 + var_277_30 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play322072066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 322072066
		arg_278_1.duration_ = 15.47

		local var_278_0 = {
			zh = 10.966,
			ja = 15.466
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play322072067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_281_1 = 0
			local var_281_2 = 1.2

			if var_281_1 < arg_278_1.time_ and arg_278_1.time_ <= var_281_1 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_3 = arg_278_1:FormatText(StoryNameCfg[1214].name)

				arg_278_1.leftNameTxt_.text = var_281_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_4 = arg_278_1:GetWordFromCfg(322072066)
				local var_281_5 = arg_278_1:FormatText(var_281_4.content)

				arg_278_1.text_.text = var_281_5

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_6 = 48
				local var_281_7 = utf8.len(var_281_5)
				local var_281_8 = var_281_6 <= 0 and var_281_2 or var_281_2 * (var_281_7 / var_281_6)

				if var_281_8 > 0 and var_281_2 < var_281_8 then
					arg_278_1.talkMaxDuration = var_281_8

					if var_281_8 + var_281_1 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_1
					end
				end

				arg_278_1.text_.text = var_281_5
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072066", "story_v_out_322072.awb") ~= 0 then
					local var_281_9 = manager.audio:GetVoiceLength("story_v_out_322072", "322072066", "story_v_out_322072.awb") / 1000

					if var_281_9 + var_281_1 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_9 + var_281_1
					end

					if var_281_4.prefab_name ~= "" and arg_278_1.actors_[var_281_4.prefab_name] ~= nil then
						local var_281_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_4.prefab_name].transform, "story_v_out_322072", "322072066", "story_v_out_322072.awb")

						arg_278_1:RecordAudio("322072066", var_281_10)
						arg_278_1:RecordAudio("322072066", var_281_10)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_322072", "322072066", "story_v_out_322072.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_322072", "322072066", "story_v_out_322072.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_11 = math.max(var_281_2, arg_278_1.talkMaxDuration)

			if var_281_1 <= arg_278_1.time_ and arg_278_1.time_ < var_281_1 + var_281_11 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_1) / var_281_11

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_1 + var_281_11 and arg_278_1.time_ < var_281_1 + var_281_11 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play322072067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 322072067
		arg_282_1.duration_ = 11.27

		local var_282_0 = {
			zh = 11.266,
			ja = 10.366
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play322072068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_2")
			end

			local var_285_1 = 0

			if var_285_1 < arg_282_1.time_ and arg_282_1.time_ <= var_285_1 + arg_285_0 then
				arg_282_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_285_2 = 0

			if var_285_2 < arg_282_1.time_ and arg_282_1.time_ <= var_285_2 + arg_285_0 then
				local var_285_3 = arg_282_1.actors_["10103ui_story"]

				if not isNil(var_285_3) then
					local var_285_4 = GameObjectTools.GetOrAddComponent(var_285_3, typeof(DynamicBoneHelper))

					if var_285_4 then
						var_285_4:EnableDynamicBone(true)
					end
				end
			end

			local var_285_5 = 0
			local var_285_6 = 0.95

			if var_285_5 < arg_282_1.time_ and arg_282_1.time_ <= var_285_5 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_7 = arg_282_1:FormatText(StoryNameCfg[1214].name)

				arg_282_1.leftNameTxt_.text = var_285_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_8 = arg_282_1:GetWordFromCfg(322072067)
				local var_285_9 = arg_282_1:FormatText(var_285_8.content)

				arg_282_1.text_.text = var_285_9

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_10 = 38
				local var_285_11 = utf8.len(var_285_9)
				local var_285_12 = var_285_10 <= 0 and var_285_6 or var_285_6 * (var_285_11 / var_285_10)

				if var_285_12 > 0 and var_285_6 < var_285_12 then
					arg_282_1.talkMaxDuration = var_285_12

					if var_285_12 + var_285_5 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_12 + var_285_5
					end
				end

				arg_282_1.text_.text = var_285_9
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072067", "story_v_out_322072.awb") ~= 0 then
					local var_285_13 = manager.audio:GetVoiceLength("story_v_out_322072", "322072067", "story_v_out_322072.awb") / 1000

					if var_285_13 + var_285_5 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_13 + var_285_5
					end

					if var_285_8.prefab_name ~= "" and arg_282_1.actors_[var_285_8.prefab_name] ~= nil then
						local var_285_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_8.prefab_name].transform, "story_v_out_322072", "322072067", "story_v_out_322072.awb")

						arg_282_1:RecordAudio("322072067", var_285_14)
						arg_282_1:RecordAudio("322072067", var_285_14)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_322072", "322072067", "story_v_out_322072.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_322072", "322072067", "story_v_out_322072.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_15 = math.max(var_285_6, arg_282_1.talkMaxDuration)

			if var_285_5 <= arg_282_1.time_ and arg_282_1.time_ < var_285_5 + var_285_15 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_5) / var_285_15

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_5 + var_285_15 and arg_282_1.time_ < var_285_5 + var_285_15 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play322072068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 322072068
		arg_286_1.duration_ = 6.33

		local var_286_0 = {
			zh = 5.166,
			ja = 6.333
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play322072069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_289_1 = 0
			local var_289_2 = 0.625

			if var_289_1 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_3 = arg_286_1:FormatText(StoryNameCfg[1214].name)

				arg_286_1.leftNameTxt_.text = var_289_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_4 = arg_286_1:GetWordFromCfg(322072068)
				local var_289_5 = arg_286_1:FormatText(var_289_4.content)

				arg_286_1.text_.text = var_289_5

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_6 = 25
				local var_289_7 = utf8.len(var_289_5)
				local var_289_8 = var_289_6 <= 0 and var_289_2 or var_289_2 * (var_289_7 / var_289_6)

				if var_289_8 > 0 and var_289_2 < var_289_8 then
					arg_286_1.talkMaxDuration = var_289_8

					if var_289_8 + var_289_1 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_1
					end
				end

				arg_286_1.text_.text = var_289_5
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072068", "story_v_out_322072.awb") ~= 0 then
					local var_289_9 = manager.audio:GetVoiceLength("story_v_out_322072", "322072068", "story_v_out_322072.awb") / 1000

					if var_289_9 + var_289_1 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_9 + var_289_1
					end

					if var_289_4.prefab_name ~= "" and arg_286_1.actors_[var_289_4.prefab_name] ~= nil then
						local var_289_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_4.prefab_name].transform, "story_v_out_322072", "322072068", "story_v_out_322072.awb")

						arg_286_1:RecordAudio("322072068", var_289_10)
						arg_286_1:RecordAudio("322072068", var_289_10)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_322072", "322072068", "story_v_out_322072.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_322072", "322072068", "story_v_out_322072.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_11 = math.max(var_289_2, arg_286_1.talkMaxDuration)

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_11 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_1) / var_289_11

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_1 + var_289_11 and arg_286_1.time_ < var_289_1 + var_289_11 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play322072069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 322072069
		arg_290_1.duration_ = 2.7

		local var_290_0 = {
			zh = 2.7,
			ja = 2.266
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play322072070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = arg_290_1.actors_["1089ui_story"].transform
			local var_293_1 = 0

			if var_293_1 < arg_290_1.time_ and arg_290_1.time_ <= var_293_1 + arg_293_0 then
				arg_290_1.var_.moveOldPos1089ui_story = var_293_0.localPosition
			end

			local var_293_2 = 0.001

			if var_293_1 <= arg_290_1.time_ and arg_290_1.time_ < var_293_1 + var_293_2 then
				local var_293_3 = (arg_290_1.time_ - var_293_1) / var_293_2
				local var_293_4 = Vector3.New(0.7, -1.1, -6.17)

				var_293_0.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1089ui_story, var_293_4, var_293_3)

				local var_293_5 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_5.x, var_293_5.y, var_293_5.z)

				local var_293_6 = var_293_0.localEulerAngles

				var_293_6.z = 0
				var_293_6.x = 0
				var_293_0.localEulerAngles = var_293_6
			end

			if arg_290_1.time_ >= var_293_1 + var_293_2 and arg_290_1.time_ < var_293_1 + var_293_2 + arg_293_0 then
				var_293_0.localPosition = Vector3.New(0.7, -1.1, -6.17)

				local var_293_7 = manager.ui.mainCamera.transform.position - var_293_0.position

				var_293_0.forward = Vector3.New(var_293_7.x, var_293_7.y, var_293_7.z)

				local var_293_8 = var_293_0.localEulerAngles

				var_293_8.z = 0
				var_293_8.x = 0
				var_293_0.localEulerAngles = var_293_8
			end

			local var_293_9 = arg_290_1.actors_["10103ui_story"].transform
			local var_293_10 = 0

			if var_293_10 < arg_290_1.time_ and arg_290_1.time_ <= var_293_10 + arg_293_0 then
				arg_290_1.var_.moveOldPos10103ui_story = var_293_9.localPosition

				local var_293_11 = GameObjectTools.GetOrAddComponent(var_293_9.gameObject, typeof(DynamicBoneHelper))

				if var_293_11 then
					var_293_11:EnableDynamicBone(false)
				end
			end

			local var_293_12 = 0.001

			if var_293_10 <= arg_290_1.time_ and arg_290_1.time_ < var_293_10 + var_293_12 then
				local var_293_13 = (arg_290_1.time_ - var_293_10) / var_293_12
				local var_293_14 = Vector3.New(-0.7, -0.95, -6.2)

				var_293_9.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos10103ui_story, var_293_14, var_293_13)

				local var_293_15 = manager.ui.mainCamera.transform.position - var_293_9.position

				var_293_9.forward = Vector3.New(var_293_15.x, var_293_15.y, var_293_15.z)

				local var_293_16 = var_293_9.localEulerAngles

				var_293_16.z = 0
				var_293_16.x = 0
				var_293_9.localEulerAngles = var_293_16
			end

			if arg_290_1.time_ >= var_293_10 + var_293_12 and arg_290_1.time_ < var_293_10 + var_293_12 + arg_293_0 then
				var_293_9.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_293_17 = manager.ui.mainCamera.transform.position - var_293_9.position

				var_293_9.forward = Vector3.New(var_293_17.x, var_293_17.y, var_293_17.z)

				local var_293_18 = var_293_9.localEulerAngles

				var_293_18.z = 0
				var_293_18.x = 0
				var_293_9.localEulerAngles = var_293_18

				local var_293_19 = GameObjectTools.GetOrAddComponent(var_293_9.gameObject, typeof(DynamicBoneHelper))

				if var_293_19 then
					var_293_19:EnableDynamicBone(true)
				end
			end

			local var_293_20 = arg_290_1.actors_["1089ui_story"]
			local var_293_21 = 0

			if var_293_21 < arg_290_1.time_ and arg_290_1.time_ <= var_293_21 + arg_293_0 and not isNil(var_293_20) and arg_290_1.var_.characterEffect1089ui_story == nil then
				arg_290_1.var_.characterEffect1089ui_story = var_293_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_22 = 0.200000002980232

			if var_293_21 <= arg_290_1.time_ and arg_290_1.time_ < var_293_21 + var_293_22 and not isNil(var_293_20) then
				local var_293_23 = (arg_290_1.time_ - var_293_21) / var_293_22

				if arg_290_1.var_.characterEffect1089ui_story and not isNil(var_293_20) then
					arg_290_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= var_293_21 + var_293_22 and arg_290_1.time_ < var_293_21 + var_293_22 + arg_293_0 and not isNil(var_293_20) and arg_290_1.var_.characterEffect1089ui_story then
				arg_290_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_293_24 = arg_290_1.actors_["10103ui_story"]
			local var_293_25 = 0

			if var_293_25 < arg_290_1.time_ and arg_290_1.time_ <= var_293_25 + arg_293_0 and not isNil(var_293_24) and arg_290_1.var_.characterEffect10103ui_story == nil then
				arg_290_1.var_.characterEffect10103ui_story = var_293_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_26 = 0.200000002980232

			if var_293_25 <= arg_290_1.time_ and arg_290_1.time_ < var_293_25 + var_293_26 and not isNil(var_293_24) then
				local var_293_27 = (arg_290_1.time_ - var_293_25) / var_293_26

				if arg_290_1.var_.characterEffect10103ui_story and not isNil(var_293_24) then
					local var_293_28 = Mathf.Lerp(0, 0.5, var_293_27)

					arg_290_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_290_1.var_.characterEffect10103ui_story.fillRatio = var_293_28
				end
			end

			if arg_290_1.time_ >= var_293_25 + var_293_26 and arg_290_1.time_ < var_293_25 + var_293_26 + arg_293_0 and not isNil(var_293_24) and arg_290_1.var_.characterEffect10103ui_story then
				local var_293_29 = 0.5

				arg_290_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_290_1.var_.characterEffect10103ui_story.fillRatio = var_293_29
			end

			local var_293_30 = 0

			if var_293_30 < arg_290_1.time_ and arg_290_1.time_ <= var_293_30 + arg_293_0 then
				arg_290_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_293_31 = 0

			if var_293_31 < arg_290_1.time_ and arg_290_1.time_ <= var_293_31 + arg_293_0 then
				arg_290_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_293_32 = 0
			local var_293_33 = 0.25

			if var_293_32 < arg_290_1.time_ and arg_290_1.time_ <= var_293_32 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				local var_293_34 = arg_290_1:FormatText(StoryNameCfg[1031].name)

				arg_290_1.leftNameTxt_.text = var_293_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_35 = arg_290_1:GetWordFromCfg(322072069)
				local var_293_36 = arg_290_1:FormatText(var_293_35.content)

				arg_290_1.text_.text = var_293_36

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_37 = 10
				local var_293_38 = utf8.len(var_293_36)
				local var_293_39 = var_293_37 <= 0 and var_293_33 or var_293_33 * (var_293_38 / var_293_37)

				if var_293_39 > 0 and var_293_33 < var_293_39 then
					arg_290_1.talkMaxDuration = var_293_39

					if var_293_39 + var_293_32 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_39 + var_293_32
					end
				end

				arg_290_1.text_.text = var_293_36
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072069", "story_v_out_322072.awb") ~= 0 then
					local var_293_40 = manager.audio:GetVoiceLength("story_v_out_322072", "322072069", "story_v_out_322072.awb") / 1000

					if var_293_40 + var_293_32 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_40 + var_293_32
					end

					if var_293_35.prefab_name ~= "" and arg_290_1.actors_[var_293_35.prefab_name] ~= nil then
						local var_293_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_35.prefab_name].transform, "story_v_out_322072", "322072069", "story_v_out_322072.awb")

						arg_290_1:RecordAudio("322072069", var_293_41)
						arg_290_1:RecordAudio("322072069", var_293_41)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_322072", "322072069", "story_v_out_322072.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_322072", "322072069", "story_v_out_322072.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_42 = math.max(var_293_33, arg_290_1.talkMaxDuration)

			if var_293_32 <= arg_290_1.time_ and arg_290_1.time_ < var_293_32 + var_293_42 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_32) / var_293_42

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_32 + var_293_42 and arg_290_1.time_ < var_293_32 + var_293_42 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
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
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play322072070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 322072070
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play322072071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			local var_297_0 = arg_294_1.actors_["1089ui_story"].transform
			local var_297_1 = 0

			if var_297_1 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.var_.moveOldPos1089ui_story = var_297_0.localPosition
			end

			local var_297_2 = 0.001

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_2 then
				local var_297_3 = (arg_294_1.time_ - var_297_1) / var_297_2
				local var_297_4 = Vector3.New(0, 100, 0)

				var_297_0.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos1089ui_story, var_297_4, var_297_3)

				local var_297_5 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_5.x, var_297_5.y, var_297_5.z)

				local var_297_6 = var_297_0.localEulerAngles

				var_297_6.z = 0
				var_297_6.x = 0
				var_297_0.localEulerAngles = var_297_6
			end

			if arg_294_1.time_ >= var_297_1 + var_297_2 and arg_294_1.time_ < var_297_1 + var_297_2 + arg_297_0 then
				var_297_0.localPosition = Vector3.New(0, 100, 0)

				local var_297_7 = manager.ui.mainCamera.transform.position - var_297_0.position

				var_297_0.forward = Vector3.New(var_297_7.x, var_297_7.y, var_297_7.z)

				local var_297_8 = var_297_0.localEulerAngles

				var_297_8.z = 0
				var_297_8.x = 0
				var_297_0.localEulerAngles = var_297_8
			end

			local var_297_9 = arg_294_1.actors_["10103ui_story"].transform
			local var_297_10 = 0

			if var_297_10 < arg_294_1.time_ and arg_294_1.time_ <= var_297_10 + arg_297_0 then
				arg_294_1.var_.moveOldPos10103ui_story = var_297_9.localPosition

				local var_297_11 = GameObjectTools.GetOrAddComponent(var_297_9.gameObject, typeof(DynamicBoneHelper))

				if var_297_11 then
					var_297_11:EnableDynamicBone(false)
				end
			end

			local var_297_12 = 0.001

			if var_297_10 <= arg_294_1.time_ and arg_294_1.time_ < var_297_10 + var_297_12 then
				local var_297_13 = (arg_294_1.time_ - var_297_10) / var_297_12
				local var_297_14 = Vector3.New(0, 100, 0)

				var_297_9.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos10103ui_story, var_297_14, var_297_13)

				local var_297_15 = manager.ui.mainCamera.transform.position - var_297_9.position

				var_297_9.forward = Vector3.New(var_297_15.x, var_297_15.y, var_297_15.z)

				local var_297_16 = var_297_9.localEulerAngles

				var_297_16.z = 0
				var_297_16.x = 0
				var_297_9.localEulerAngles = var_297_16
			end

			if arg_294_1.time_ >= var_297_10 + var_297_12 and arg_294_1.time_ < var_297_10 + var_297_12 + arg_297_0 then
				var_297_9.localPosition = Vector3.New(0, 100, 0)

				local var_297_17 = manager.ui.mainCamera.transform.position - var_297_9.position

				var_297_9.forward = Vector3.New(var_297_17.x, var_297_17.y, var_297_17.z)

				local var_297_18 = var_297_9.localEulerAngles

				var_297_18.z = 0
				var_297_18.x = 0
				var_297_9.localEulerAngles = var_297_18

				local var_297_19 = GameObjectTools.GetOrAddComponent(var_297_9.gameObject, typeof(DynamicBoneHelper))

				if var_297_19 then
					var_297_19:EnableDynamicBone(true)
				end
			end

			local var_297_20 = 0
			local var_297_21 = 1.175

			if var_297_20 < arg_294_1.time_ and arg_294_1.time_ <= var_297_20 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, false)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_22 = arg_294_1:GetWordFromCfg(322072070)
				local var_297_23 = arg_294_1:FormatText(var_297_22.content)

				arg_294_1.text_.text = var_297_23

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_24 = 47
				local var_297_25 = utf8.len(var_297_23)
				local var_297_26 = var_297_24 <= 0 and var_297_21 or var_297_21 * (var_297_25 / var_297_24)

				if var_297_26 > 0 and var_297_21 < var_297_26 then
					arg_294_1.talkMaxDuration = var_297_26

					if var_297_26 + var_297_20 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_26 + var_297_20
					end
				end

				arg_294_1.text_.text = var_297_23
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_27 = math.max(var_297_21, arg_294_1.talkMaxDuration)

			if var_297_20 <= arg_294_1.time_ and arg_294_1.time_ < var_297_20 + var_297_27 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_20) / var_297_27

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_20 + var_297_27 and arg_294_1.time_ < var_297_20 + var_297_27 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
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
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play322072071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 322072071
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play322072072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.1
			local var_301_1 = 1

			if var_301_0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_0 + arg_301_0 then
				local var_301_2 = "play"
				local var_301_3 = "effect"

				arg_298_1:AudioAction(var_301_2, var_301_3, "se_story_1310", "se_story_1310_scan", "")
			end

			local var_301_4 = manager.ui.mainCamera.transform
			local var_301_5 = 0.1

			if var_301_5 < arg_298_1.time_ and arg_298_1.time_ <= var_301_5 + arg_301_0 then
				local var_301_6 = arg_298_1.var_.effect2071
				local var_301_7
				local var_301_8 = var_301_4

				if not var_301_6 then
					var_301_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_scan_in_out"), var_301_8)
					var_301_6.name = "2071"
					arg_298_1.var_.effect2071 = var_301_6
				else
					var_301_6.transform:SetParent(var_301_8)
				end

				var_301_6.transform.localPosition = Vector3.New(0, 0, -2.25)
				var_301_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_301_9 = manager.ui.mainCameraCom_
				local var_301_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_301_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_301_11 = var_301_6.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_301_12 = 15
				local var_301_13 = 2 * var_301_12 * Mathf.Tan(var_301_9.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_301_9.aspect
				local var_301_14 = 1
				local var_301_15 = 1.7777777777777777

				if var_301_15 < var_301_9.aspect then
					var_301_14 = var_301_13 / (2 * var_301_12 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_301_15)
				end

				for iter_301_0, iter_301_1 in ipairs(var_301_11) do
					local var_301_16 = iter_301_1.transform.localScale

					iter_301_1.transform.localScale = Vector3.New(var_301_16.x / var_301_10 * var_301_14, var_301_16.y / var_301_10, var_301_16.z)
				end
			end

			local var_301_17 = 0
			local var_301_18 = 1.2

			if var_301_17 < arg_298_1.time_ and arg_298_1.time_ <= var_301_17 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, false)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_19 = arg_298_1:GetWordFromCfg(322072071)
				local var_301_20 = arg_298_1:FormatText(var_301_19.content)

				arg_298_1.text_.text = var_301_20

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_21 = 48
				local var_301_22 = utf8.len(var_301_20)
				local var_301_23 = var_301_21 <= 0 and var_301_18 or var_301_18 * (var_301_22 / var_301_21)

				if var_301_23 > 0 and var_301_18 < var_301_23 then
					arg_298_1.talkMaxDuration = var_301_23

					if var_301_23 + var_301_17 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_23 + var_301_17
					end
				end

				arg_298_1.text_.text = var_301_20
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_24 = math.max(var_301_18, arg_298_1.talkMaxDuration)

			if var_301_17 <= arg_298_1.time_ and arg_298_1.time_ < var_301_17 + var_301_24 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_17) / var_301_24

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_17 + var_301_24 and arg_298_1.time_ < var_301_17 + var_301_24 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play322072072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 322072072
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play322072073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 0.1
			local var_305_1 = 1

			if var_305_0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_0 + arg_305_0 then
				local var_305_2 = "play"
				local var_305_3 = "effect"

				arg_302_1:AudioAction(var_305_2, var_305_3, "se_story_145", "se_story_145_summon_launcher", "")
			end

			local var_305_4 = manager.ui.mainCamera.transform
			local var_305_5 = 0

			if var_305_5 < arg_302_1.time_ and arg_302_1.time_ <= var_305_5 + arg_305_0 then
				local var_305_6 = arg_302_1.var_.effect2071

				if var_305_6 then
					Object.Destroy(var_305_6)

					arg_302_1.var_.effect2071 = nil
				end
			end

			local var_305_7 = 0
			local var_305_8 = 1.4

			if var_305_7 < arg_302_1.time_ and arg_302_1.time_ <= var_305_7 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_9 = arg_302_1:GetWordFromCfg(322072072)
				local var_305_10 = arg_302_1:FormatText(var_305_9.content)

				arg_302_1.text_.text = var_305_10

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_11 = 56
				local var_305_12 = utf8.len(var_305_10)
				local var_305_13 = var_305_11 <= 0 and var_305_8 or var_305_8 * (var_305_12 / var_305_11)

				if var_305_13 > 0 and var_305_8 < var_305_13 then
					arg_302_1.talkMaxDuration = var_305_13

					if var_305_13 + var_305_7 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_13 + var_305_7
					end
				end

				arg_302_1.text_.text = var_305_10
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_14 = math.max(var_305_8, arg_302_1.talkMaxDuration)

			if var_305_7 <= arg_302_1.time_ and arg_302_1.time_ < var_305_7 + var_305_14 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_7) / var_305_14

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_7 + var_305_14 and arg_302_1.time_ < var_305_7 + var_305_14 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play322072073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 322072073
		arg_306_1.duration_ = 2.13

		local var_306_0 = {
			zh = 1.999999999999,
			ja = 2.133
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play322072074(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = arg_306_1.actors_["10103ui_story"].transform
			local var_309_1 = 0

			if var_309_1 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.var_.moveOldPos10103ui_story = var_309_0.localPosition

				local var_309_2 = GameObjectTools.GetOrAddComponent(var_309_0.gameObject, typeof(DynamicBoneHelper))

				if var_309_2 then
					var_309_2:EnableDynamicBone(false)
				end
			end

			local var_309_3 = 0.001

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_3 then
				local var_309_4 = (arg_306_1.time_ - var_309_1) / var_309_3
				local var_309_5 = Vector3.New(-0.7, -0.95, -6.2)

				var_309_0.localPosition = Vector3.Lerp(arg_306_1.var_.moveOldPos10103ui_story, var_309_5, var_309_4)

				local var_309_6 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_6.x, var_309_6.y, var_309_6.z)

				local var_309_7 = var_309_0.localEulerAngles

				var_309_7.z = 0
				var_309_7.x = 0
				var_309_0.localEulerAngles = var_309_7
			end

			if arg_306_1.time_ >= var_309_1 + var_309_3 and arg_306_1.time_ < var_309_1 + var_309_3 + arg_309_0 then
				var_309_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_309_8 = manager.ui.mainCamera.transform.position - var_309_0.position

				var_309_0.forward = Vector3.New(var_309_8.x, var_309_8.y, var_309_8.z)

				local var_309_9 = var_309_0.localEulerAngles

				var_309_9.z = 0
				var_309_9.x = 0
				var_309_0.localEulerAngles = var_309_9

				local var_309_10 = GameObjectTools.GetOrAddComponent(var_309_0.gameObject, typeof(DynamicBoneHelper))

				if var_309_10 then
					var_309_10:EnableDynamicBone(true)
				end
			end

			local var_309_11 = arg_306_1.actors_["10103ui_story"]
			local var_309_12 = 0

			if var_309_12 < arg_306_1.time_ and arg_306_1.time_ <= var_309_12 + arg_309_0 and not isNil(var_309_11) and arg_306_1.var_.characterEffect10103ui_story == nil then
				arg_306_1.var_.characterEffect10103ui_story = var_309_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_13 = 0.200000002980232

			if var_309_12 <= arg_306_1.time_ and arg_306_1.time_ < var_309_12 + var_309_13 and not isNil(var_309_11) then
				local var_309_14 = (arg_306_1.time_ - var_309_12) / var_309_13

				if arg_306_1.var_.characterEffect10103ui_story and not isNil(var_309_11) then
					arg_306_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= var_309_12 + var_309_13 and arg_306_1.time_ < var_309_12 + var_309_13 + arg_309_0 and not isNil(var_309_11) and arg_306_1.var_.characterEffect10103ui_story then
				arg_306_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_309_15 = 0

			if var_309_15 < arg_306_1.time_ and arg_306_1.time_ <= var_309_15 + arg_309_0 then
				arg_306_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_1")
			end

			local var_309_16 = 0

			if var_309_16 < arg_306_1.time_ and arg_306_1.time_ <= var_309_16 + arg_309_0 then
				arg_306_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_309_17 = 0

			if var_309_17 < arg_306_1.time_ and arg_306_1.time_ <= var_309_17 + arg_309_0 then
				local var_309_18 = arg_306_1.actors_["10103ui_story"]

				if not isNil(var_309_18) then
					local var_309_19 = GameObjectTools.GetOrAddComponent(var_309_18, typeof(DynamicBoneHelper))

					if var_309_19 then
						var_309_19:EnableDynamicBone(true)
					end
				end
			end

			local var_309_20 = 0
			local var_309_21 = 0.125

			if var_309_20 < arg_306_1.time_ and arg_306_1.time_ <= var_309_20 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				local var_309_22 = arg_306_1:FormatText(StoryNameCfg[1214].name)

				arg_306_1.leftNameTxt_.text = var_309_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_23 = arg_306_1:GetWordFromCfg(322072073)
				local var_309_24 = arg_306_1:FormatText(var_309_23.content)

				arg_306_1.text_.text = var_309_24

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_25 = 5
				local var_309_26 = utf8.len(var_309_24)
				local var_309_27 = var_309_25 <= 0 and var_309_21 or var_309_21 * (var_309_26 / var_309_25)

				if var_309_27 > 0 and var_309_21 < var_309_27 then
					arg_306_1.talkMaxDuration = var_309_27

					if var_309_27 + var_309_20 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_27 + var_309_20
					end
				end

				arg_306_1.text_.text = var_309_24
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072073", "story_v_out_322072.awb") ~= 0 then
					local var_309_28 = manager.audio:GetVoiceLength("story_v_out_322072", "322072073", "story_v_out_322072.awb") / 1000

					if var_309_28 + var_309_20 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_28 + var_309_20
					end

					if var_309_23.prefab_name ~= "" and arg_306_1.actors_[var_309_23.prefab_name] ~= nil then
						local var_309_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_23.prefab_name].transform, "story_v_out_322072", "322072073", "story_v_out_322072.awb")

						arg_306_1:RecordAudio("322072073", var_309_29)
						arg_306_1:RecordAudio("322072073", var_309_29)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_322072", "322072073", "story_v_out_322072.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_322072", "322072073", "story_v_out_322072.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_30 = math.max(var_309_21, arg_306_1.talkMaxDuration)

			if var_309_20 <= arg_306_1.time_ and arg_306_1.time_ < var_309_20 + var_309_30 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_20) / var_309_30

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_20 + var_309_30 and arg_306_1.time_ < var_309_20 + var_309_30 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_306_1:InitPlayNodeList()
	end,
	Play322072074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 322072074
		arg_310_1.duration_ = 17.87

		local var_310_0 = {
			zh = 9.633,
			ja = 17.866
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play322072075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = arg_310_1.actors_["1089ui_story"].transform
			local var_313_1 = 0

			if var_313_1 < arg_310_1.time_ and arg_310_1.time_ <= var_313_1 + arg_313_0 then
				arg_310_1.var_.moveOldPos1089ui_story = var_313_0.localPosition
			end

			local var_313_2 = 0.001

			if var_313_1 <= arg_310_1.time_ and arg_310_1.time_ < var_313_1 + var_313_2 then
				local var_313_3 = (arg_310_1.time_ - var_313_1) / var_313_2
				local var_313_4 = Vector3.New(0.7, -1.1, -6.17)

				var_313_0.localPosition = Vector3.Lerp(arg_310_1.var_.moveOldPos1089ui_story, var_313_4, var_313_3)

				local var_313_5 = manager.ui.mainCamera.transform.position - var_313_0.position

				var_313_0.forward = Vector3.New(var_313_5.x, var_313_5.y, var_313_5.z)

				local var_313_6 = var_313_0.localEulerAngles

				var_313_6.z = 0
				var_313_6.x = 0
				var_313_0.localEulerAngles = var_313_6
			end

			if arg_310_1.time_ >= var_313_1 + var_313_2 and arg_310_1.time_ < var_313_1 + var_313_2 + arg_313_0 then
				var_313_0.localPosition = Vector3.New(0.7, -1.1, -6.17)

				local var_313_7 = manager.ui.mainCamera.transform.position - var_313_0.position

				var_313_0.forward = Vector3.New(var_313_7.x, var_313_7.y, var_313_7.z)

				local var_313_8 = var_313_0.localEulerAngles

				var_313_8.z = 0
				var_313_8.x = 0
				var_313_0.localEulerAngles = var_313_8
			end

			local var_313_9 = arg_310_1.actors_["1089ui_story"]
			local var_313_10 = 0

			if var_313_10 < arg_310_1.time_ and arg_310_1.time_ <= var_313_10 + arg_313_0 and not isNil(var_313_9) and arg_310_1.var_.characterEffect1089ui_story == nil then
				arg_310_1.var_.characterEffect1089ui_story = var_313_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_11 = 0.200000002980232

			if var_313_10 <= arg_310_1.time_ and arg_310_1.time_ < var_313_10 + var_313_11 and not isNil(var_313_9) then
				local var_313_12 = (arg_310_1.time_ - var_313_10) / var_313_11

				if arg_310_1.var_.characterEffect1089ui_story and not isNil(var_313_9) then
					arg_310_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= var_313_10 + var_313_11 and arg_310_1.time_ < var_313_10 + var_313_11 + arg_313_0 and not isNil(var_313_9) and arg_310_1.var_.characterEffect1089ui_story then
				arg_310_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_313_13 = arg_310_1.actors_["10103ui_story"]
			local var_313_14 = 0

			if var_313_14 < arg_310_1.time_ and arg_310_1.time_ <= var_313_14 + arg_313_0 and not isNil(var_313_13) and arg_310_1.var_.characterEffect10103ui_story == nil then
				arg_310_1.var_.characterEffect10103ui_story = var_313_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_15 = 0.200000002980232

			if var_313_14 <= arg_310_1.time_ and arg_310_1.time_ < var_313_14 + var_313_15 and not isNil(var_313_13) then
				local var_313_16 = (arg_310_1.time_ - var_313_14) / var_313_15

				if arg_310_1.var_.characterEffect10103ui_story and not isNil(var_313_13) then
					local var_313_17 = Mathf.Lerp(0, 0.5, var_313_16)

					arg_310_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_310_1.var_.characterEffect10103ui_story.fillRatio = var_313_17
				end
			end

			if arg_310_1.time_ >= var_313_14 + var_313_15 and arg_310_1.time_ < var_313_14 + var_313_15 + arg_313_0 and not isNil(var_313_13) and arg_310_1.var_.characterEffect10103ui_story then
				local var_313_18 = 0.5

				arg_310_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_310_1.var_.characterEffect10103ui_story.fillRatio = var_313_18
			end

			local var_313_19 = 0

			if var_313_19 < arg_310_1.time_ and arg_310_1.time_ <= var_313_19 + arg_313_0 then
				arg_310_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action1_1")
			end

			local var_313_20 = 0

			if var_313_20 < arg_310_1.time_ and arg_310_1.time_ <= var_313_20 + arg_313_0 then
				arg_310_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_313_21 = 0
			local var_313_22 = 1.125

			if var_313_21 < arg_310_1.time_ and arg_310_1.time_ <= var_313_21 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				local var_313_23 = arg_310_1:FormatText(StoryNameCfg[1031].name)

				arg_310_1.leftNameTxt_.text = var_313_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_24 = arg_310_1:GetWordFromCfg(322072074)
				local var_313_25 = arg_310_1:FormatText(var_313_24.content)

				arg_310_1.text_.text = var_313_25

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_26 = 45
				local var_313_27 = utf8.len(var_313_25)
				local var_313_28 = var_313_26 <= 0 and var_313_22 or var_313_22 * (var_313_27 / var_313_26)

				if var_313_28 > 0 and var_313_22 < var_313_28 then
					arg_310_1.talkMaxDuration = var_313_28

					if var_313_28 + var_313_21 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_28 + var_313_21
					end
				end

				arg_310_1.text_.text = var_313_25
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072074", "story_v_out_322072.awb") ~= 0 then
					local var_313_29 = manager.audio:GetVoiceLength("story_v_out_322072", "322072074", "story_v_out_322072.awb") / 1000

					if var_313_29 + var_313_21 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_29 + var_313_21
					end

					if var_313_24.prefab_name ~= "" and arg_310_1.actors_[var_313_24.prefab_name] ~= nil then
						local var_313_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_24.prefab_name].transform, "story_v_out_322072", "322072074", "story_v_out_322072.awb")

						arg_310_1:RecordAudio("322072074", var_313_30)
						arg_310_1:RecordAudio("322072074", var_313_30)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_322072", "322072074", "story_v_out_322072.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_322072", "322072074", "story_v_out_322072.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_31 = math.max(var_313_22, arg_310_1.talkMaxDuration)

			if var_313_21 <= arg_310_1.time_ and arg_310_1.time_ < var_313_21 + var_313_31 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_21) / var_313_31

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_21 + var_313_31 and arg_310_1.time_ < var_313_21 + var_313_31 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {
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

		arg_310_1:InitPlayNodeList()
	end,
	Play322072075 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 322072075
		arg_314_1.duration_ = 10.7

		local var_314_0 = {
			zh = 5.466,
			ja = 10.7
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play322072076(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0
			local var_317_1 = 0.625

			if var_317_0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				local var_317_2 = arg_314_1:FormatText(StoryNameCfg[1031].name)

				arg_314_1.leftNameTxt_.text = var_317_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_3 = arg_314_1:GetWordFromCfg(322072075)
				local var_317_4 = arg_314_1:FormatText(var_317_3.content)

				arg_314_1.text_.text = var_317_4

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_5 = 25
				local var_317_6 = utf8.len(var_317_4)
				local var_317_7 = var_317_5 <= 0 and var_317_1 or var_317_1 * (var_317_6 / var_317_5)

				if var_317_7 > 0 and var_317_1 < var_317_7 then
					arg_314_1.talkMaxDuration = var_317_7

					if var_317_7 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_7 + var_317_0
					end
				end

				arg_314_1.text_.text = var_317_4
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072075", "story_v_out_322072.awb") ~= 0 then
					local var_317_8 = manager.audio:GetVoiceLength("story_v_out_322072", "322072075", "story_v_out_322072.awb") / 1000

					if var_317_8 + var_317_0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_8 + var_317_0
					end

					if var_317_3.prefab_name ~= "" and arg_314_1.actors_[var_317_3.prefab_name] ~= nil then
						local var_317_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_3.prefab_name].transform, "story_v_out_322072", "322072075", "story_v_out_322072.awb")

						arg_314_1:RecordAudio("322072075", var_317_9)
						arg_314_1:RecordAudio("322072075", var_317_9)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_322072", "322072075", "story_v_out_322072.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_322072", "322072075", "story_v_out_322072.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_10 = math.max(var_317_1, arg_314_1.talkMaxDuration)

			if var_317_0 <= arg_314_1.time_ and arg_314_1.time_ < var_317_0 + var_317_10 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_0) / var_317_10

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_0 + var_317_10 and arg_314_1.time_ < var_317_0 + var_317_10 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play322072076 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 322072076
		arg_318_1.duration_ = 13.87

		local var_318_0 = {
			zh = 9.2,
			ja = 13.866
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play322072077(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			local var_321_0 = 0

			if var_321_0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_0 + arg_321_0 then
				arg_318_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_1")
			end

			local var_321_1 = 0

			if var_321_1 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_321_2 = 0
			local var_321_3 = 0.975

			if var_321_2 < arg_318_1.time_ and arg_318_1.time_ <= var_321_2 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				local var_321_4 = arg_318_1:FormatText(StoryNameCfg[1031].name)

				arg_318_1.leftNameTxt_.text = var_321_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_5 = arg_318_1:GetWordFromCfg(322072076)
				local var_321_6 = arg_318_1:FormatText(var_321_5.content)

				arg_318_1.text_.text = var_321_6

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_7 = 39
				local var_321_8 = utf8.len(var_321_6)
				local var_321_9 = var_321_7 <= 0 and var_321_3 or var_321_3 * (var_321_8 / var_321_7)

				if var_321_9 > 0 and var_321_3 < var_321_9 then
					arg_318_1.talkMaxDuration = var_321_9

					if var_321_9 + var_321_2 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_9 + var_321_2
					end
				end

				arg_318_1.text_.text = var_321_6
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072076", "story_v_out_322072.awb") ~= 0 then
					local var_321_10 = manager.audio:GetVoiceLength("story_v_out_322072", "322072076", "story_v_out_322072.awb") / 1000

					if var_321_10 + var_321_2 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_10 + var_321_2
					end

					if var_321_5.prefab_name ~= "" and arg_318_1.actors_[var_321_5.prefab_name] ~= nil then
						local var_321_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_5.prefab_name].transform, "story_v_out_322072", "322072076", "story_v_out_322072.awb")

						arg_318_1:RecordAudio("322072076", var_321_11)
						arg_318_1:RecordAudio("322072076", var_321_11)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_322072", "322072076", "story_v_out_322072.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_322072", "322072076", "story_v_out_322072.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_12 = math.max(var_321_3, arg_318_1.talkMaxDuration)

			if var_321_2 <= arg_318_1.time_ and arg_318_1.time_ < var_321_2 + var_321_12 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_2) / var_321_12

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_2 + var_321_12 and arg_318_1.time_ < var_321_2 + var_321_12 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play322072077 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 322072077
		arg_322_1.duration_ = 10.9

		local var_322_0 = {
			zh = 8.533,
			ja = 10.9
		}
		local var_322_1 = manager.audio:GetLocalizationFlag()

		if var_322_0[var_322_1] ~= nil then
			arg_322_1.duration_ = var_322_0[var_322_1]
		end

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play322072078(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = arg_322_1.actors_["10103ui_story"].transform
			local var_325_1 = 0

			if var_325_1 < arg_322_1.time_ and arg_322_1.time_ <= var_325_1 + arg_325_0 then
				arg_322_1.var_.moveOldPos10103ui_story = var_325_0.localPosition

				local var_325_2 = GameObjectTools.GetOrAddComponent(var_325_0.gameObject, typeof(DynamicBoneHelper))

				if var_325_2 then
					var_325_2:EnableDynamicBone(false)
				end
			end

			local var_325_3 = 0.001

			if var_325_1 <= arg_322_1.time_ and arg_322_1.time_ < var_325_1 + var_325_3 then
				local var_325_4 = (arg_322_1.time_ - var_325_1) / var_325_3
				local var_325_5 = Vector3.New(-0.7, -0.95, -6.2)

				var_325_0.localPosition = Vector3.Lerp(arg_322_1.var_.moveOldPos10103ui_story, var_325_5, var_325_4)

				local var_325_6 = manager.ui.mainCamera.transform.position - var_325_0.position

				var_325_0.forward = Vector3.New(var_325_6.x, var_325_6.y, var_325_6.z)

				local var_325_7 = var_325_0.localEulerAngles

				var_325_7.z = 0
				var_325_7.x = 0
				var_325_0.localEulerAngles = var_325_7
			end

			if arg_322_1.time_ >= var_325_1 + var_325_3 and arg_322_1.time_ < var_325_1 + var_325_3 + arg_325_0 then
				var_325_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_325_8 = manager.ui.mainCamera.transform.position - var_325_0.position

				var_325_0.forward = Vector3.New(var_325_8.x, var_325_8.y, var_325_8.z)

				local var_325_9 = var_325_0.localEulerAngles

				var_325_9.z = 0
				var_325_9.x = 0
				var_325_0.localEulerAngles = var_325_9

				local var_325_10 = GameObjectTools.GetOrAddComponent(var_325_0.gameObject, typeof(DynamicBoneHelper))

				if var_325_10 then
					var_325_10:EnableDynamicBone(true)
				end
			end

			local var_325_11 = arg_322_1.actors_["10103ui_story"]
			local var_325_12 = 0

			if var_325_12 < arg_322_1.time_ and arg_322_1.time_ <= var_325_12 + arg_325_0 and not isNil(var_325_11) and arg_322_1.var_.characterEffect10103ui_story == nil then
				arg_322_1.var_.characterEffect10103ui_story = var_325_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_13 = 0.200000002980232

			if var_325_12 <= arg_322_1.time_ and arg_322_1.time_ < var_325_12 + var_325_13 and not isNil(var_325_11) then
				local var_325_14 = (arg_322_1.time_ - var_325_12) / var_325_13

				if arg_322_1.var_.characterEffect10103ui_story and not isNil(var_325_11) then
					arg_322_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_322_1.time_ >= var_325_12 + var_325_13 and arg_322_1.time_ < var_325_12 + var_325_13 + arg_325_0 and not isNil(var_325_11) and arg_322_1.var_.characterEffect10103ui_story then
				arg_322_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_325_15 = arg_322_1.actors_["1089ui_story"]
			local var_325_16 = 0

			if var_325_16 < arg_322_1.time_ and arg_322_1.time_ <= var_325_16 + arg_325_0 and not isNil(var_325_15) and arg_322_1.var_.characterEffect1089ui_story == nil then
				arg_322_1.var_.characterEffect1089ui_story = var_325_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_325_17 = 0.200000002980232

			if var_325_16 <= arg_322_1.time_ and arg_322_1.time_ < var_325_16 + var_325_17 and not isNil(var_325_15) then
				local var_325_18 = (arg_322_1.time_ - var_325_16) / var_325_17

				if arg_322_1.var_.characterEffect1089ui_story and not isNil(var_325_15) then
					local var_325_19 = Mathf.Lerp(0, 0.5, var_325_18)

					arg_322_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_322_1.var_.characterEffect1089ui_story.fillRatio = var_325_19
				end
			end

			if arg_322_1.time_ >= var_325_16 + var_325_17 and arg_322_1.time_ < var_325_16 + var_325_17 + arg_325_0 and not isNil(var_325_15) and arg_322_1.var_.characterEffect1089ui_story then
				local var_325_20 = 0.5

				arg_322_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_322_1.var_.characterEffect1089ui_story.fillRatio = var_325_20
			end

			local var_325_21 = 0

			if var_325_21 < arg_322_1.time_ and arg_322_1.time_ <= var_325_21 + arg_325_0 then
				arg_322_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action8_2")
			end

			local var_325_22 = 0

			if var_325_22 < arg_322_1.time_ and arg_322_1.time_ <= var_325_22 + arg_325_0 then
				arg_322_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_325_23 = 0

			if var_325_23 < arg_322_1.time_ and arg_322_1.time_ <= var_325_23 + arg_325_0 then
				local var_325_24 = arg_322_1.actors_["10103ui_story"]

				if not isNil(var_325_24) then
					local var_325_25 = GameObjectTools.GetOrAddComponent(var_325_24, typeof(DynamicBoneHelper))

					if var_325_25 then
						var_325_25:EnableDynamicBone(true)
					end
				end
			end

			local var_325_26 = 0
			local var_325_27 = 0.775

			if var_325_26 < arg_322_1.time_ and arg_322_1.time_ <= var_325_26 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, true)

				local var_325_28 = arg_322_1:FormatText(StoryNameCfg[1214].name)

				arg_322_1.leftNameTxt_.text = var_325_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_322_1.leftNameTxt_.transform)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1.leftNameTxt_.text)
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_29 = arg_322_1:GetWordFromCfg(322072077)
				local var_325_30 = arg_322_1:FormatText(var_325_29.content)

				arg_322_1.text_.text = var_325_30

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_31 = 31
				local var_325_32 = utf8.len(var_325_30)
				local var_325_33 = var_325_31 <= 0 and var_325_27 or var_325_27 * (var_325_32 / var_325_31)

				if var_325_33 > 0 and var_325_27 < var_325_33 then
					arg_322_1.talkMaxDuration = var_325_33

					if var_325_33 + var_325_26 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_33 + var_325_26
					end
				end

				arg_322_1.text_.text = var_325_30
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072077", "story_v_out_322072.awb") ~= 0 then
					local var_325_34 = manager.audio:GetVoiceLength("story_v_out_322072", "322072077", "story_v_out_322072.awb") / 1000

					if var_325_34 + var_325_26 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_34 + var_325_26
					end

					if var_325_29.prefab_name ~= "" and arg_322_1.actors_[var_325_29.prefab_name] ~= nil then
						local var_325_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_322_1.actors_[var_325_29.prefab_name].transform, "story_v_out_322072", "322072077", "story_v_out_322072.awb")

						arg_322_1:RecordAudio("322072077", var_325_35)
						arg_322_1:RecordAudio("322072077", var_325_35)
					else
						arg_322_1:AudioAction("play", "voice", "story_v_out_322072", "322072077", "story_v_out_322072.awb")
					end

					arg_322_1:RecordHistoryTalkVoice("story_v_out_322072", "322072077", "story_v_out_322072.awb")
				end

				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_36 = math.max(var_325_27, arg_322_1.talkMaxDuration)

			if var_325_26 <= arg_322_1.time_ and arg_322_1.time_ < var_325_26 + var_325_36 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_26) / var_325_36

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_26 + var_325_36 and arg_322_1.time_ < var_325_26 + var_325_36 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_322_1:InitPlayNodeList()
	end,
	Play322072078 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 322072078
		arg_326_1.duration_ = 10.7

		local var_326_0 = {
			zh = 7.8,
			ja = 10.7
		}
		local var_326_1 = manager.audio:GetLocalizationFlag()

		if var_326_0[var_326_1] ~= nil then
			arg_326_1.duration_ = var_326_0[var_326_1]
		end

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play322072079(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = arg_326_1.actors_["1089ui_story"].transform
			local var_329_1 = 0

			if var_329_1 < arg_326_1.time_ and arg_326_1.time_ <= var_329_1 + arg_329_0 then
				arg_326_1.var_.moveOldPos1089ui_story = var_329_0.localPosition
			end

			local var_329_2 = 0.001

			if var_329_1 <= arg_326_1.time_ and arg_326_1.time_ < var_329_1 + var_329_2 then
				local var_329_3 = (arg_326_1.time_ - var_329_1) / var_329_2
				local var_329_4 = Vector3.New(0.7, -1.1, -6.17)

				var_329_0.localPosition = Vector3.Lerp(arg_326_1.var_.moveOldPos1089ui_story, var_329_4, var_329_3)

				local var_329_5 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_5.x, var_329_5.y, var_329_5.z)

				local var_329_6 = var_329_0.localEulerAngles

				var_329_6.z = 0
				var_329_6.x = 0
				var_329_0.localEulerAngles = var_329_6
			end

			if arg_326_1.time_ >= var_329_1 + var_329_2 and arg_326_1.time_ < var_329_1 + var_329_2 + arg_329_0 then
				var_329_0.localPosition = Vector3.New(0.7, -1.1, -6.17)

				local var_329_7 = manager.ui.mainCamera.transform.position - var_329_0.position

				var_329_0.forward = Vector3.New(var_329_7.x, var_329_7.y, var_329_7.z)

				local var_329_8 = var_329_0.localEulerAngles

				var_329_8.z = 0
				var_329_8.x = 0
				var_329_0.localEulerAngles = var_329_8
			end

			local var_329_9 = arg_326_1.actors_["1089ui_story"]
			local var_329_10 = 0

			if var_329_10 < arg_326_1.time_ and arg_326_1.time_ <= var_329_10 + arg_329_0 and not isNil(var_329_9) and arg_326_1.var_.characterEffect1089ui_story == nil then
				arg_326_1.var_.characterEffect1089ui_story = var_329_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_11 = 0.200000002980232

			if var_329_10 <= arg_326_1.time_ and arg_326_1.time_ < var_329_10 + var_329_11 and not isNil(var_329_9) then
				local var_329_12 = (arg_326_1.time_ - var_329_10) / var_329_11

				if arg_326_1.var_.characterEffect1089ui_story and not isNil(var_329_9) then
					arg_326_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_326_1.time_ >= var_329_10 + var_329_11 and arg_326_1.time_ < var_329_10 + var_329_11 + arg_329_0 and not isNil(var_329_9) and arg_326_1.var_.characterEffect1089ui_story then
				arg_326_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_329_13 = arg_326_1.actors_["10103ui_story"]
			local var_329_14 = 0

			if var_329_14 < arg_326_1.time_ and arg_326_1.time_ <= var_329_14 + arg_329_0 and not isNil(var_329_13) and arg_326_1.var_.characterEffect10103ui_story == nil then
				arg_326_1.var_.characterEffect10103ui_story = var_329_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_329_15 = 0.200000002980232

			if var_329_14 <= arg_326_1.time_ and arg_326_1.time_ < var_329_14 + var_329_15 and not isNil(var_329_13) then
				local var_329_16 = (arg_326_1.time_ - var_329_14) / var_329_15

				if arg_326_1.var_.characterEffect10103ui_story and not isNil(var_329_13) then
					local var_329_17 = Mathf.Lerp(0, 0.5, var_329_16)

					arg_326_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_326_1.var_.characterEffect10103ui_story.fillRatio = var_329_17
				end
			end

			if arg_326_1.time_ >= var_329_14 + var_329_15 and arg_326_1.time_ < var_329_14 + var_329_15 + arg_329_0 and not isNil(var_329_13) and arg_326_1.var_.characterEffect10103ui_story then
				local var_329_18 = 0.5

				arg_326_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_326_1.var_.characterEffect10103ui_story.fillRatio = var_329_18
			end

			local var_329_19 = 0

			if var_329_19 < arg_326_1.time_ and arg_326_1.time_ <= var_329_19 + arg_329_0 then
				arg_326_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action2_2")
			end

			local var_329_20 = 0

			if var_329_20 < arg_326_1.time_ and arg_326_1.time_ <= var_329_20 + arg_329_0 then
				arg_326_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_329_21 = 0
			local var_329_22 = 0.85

			if var_329_21 < arg_326_1.time_ and arg_326_1.time_ <= var_329_21 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, true)

				local var_329_23 = arg_326_1:FormatText(StoryNameCfg[1031].name)

				arg_326_1.leftNameTxt_.text = var_329_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_326_1.leftNameTxt_.transform)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1.leftNameTxt_.text)
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_24 = arg_326_1:GetWordFromCfg(322072078)
				local var_329_25 = arg_326_1:FormatText(var_329_24.content)

				arg_326_1.text_.text = var_329_25

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_26 = 34
				local var_329_27 = utf8.len(var_329_25)
				local var_329_28 = var_329_26 <= 0 and var_329_22 or var_329_22 * (var_329_27 / var_329_26)

				if var_329_28 > 0 and var_329_22 < var_329_28 then
					arg_326_1.talkMaxDuration = var_329_28

					if var_329_28 + var_329_21 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_28 + var_329_21
					end
				end

				arg_326_1.text_.text = var_329_25
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072078", "story_v_out_322072.awb") ~= 0 then
					local var_329_29 = manager.audio:GetVoiceLength("story_v_out_322072", "322072078", "story_v_out_322072.awb") / 1000

					if var_329_29 + var_329_21 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_29 + var_329_21
					end

					if var_329_24.prefab_name ~= "" and arg_326_1.actors_[var_329_24.prefab_name] ~= nil then
						local var_329_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_326_1.actors_[var_329_24.prefab_name].transform, "story_v_out_322072", "322072078", "story_v_out_322072.awb")

						arg_326_1:RecordAudio("322072078", var_329_30)
						arg_326_1:RecordAudio("322072078", var_329_30)
					else
						arg_326_1:AudioAction("play", "voice", "story_v_out_322072", "322072078", "story_v_out_322072.awb")
					end

					arg_326_1:RecordHistoryTalkVoice("story_v_out_322072", "322072078", "story_v_out_322072.awb")
				end

				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_31 = math.max(var_329_22, arg_326_1.talkMaxDuration)

			if var_329_21 <= arg_326_1.time_ and arg_326_1.time_ < var_329_21 + var_329_31 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - var_329_21) / var_329_31

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= var_329_21 + var_329_31 and arg_326_1.time_ < var_329_21 + var_329_31 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {
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

		arg_326_1:InitPlayNodeList()
	end,
	Play322072079 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 322072079
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play322072080(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = arg_330_1.actors_["1089ui_story"]
			local var_333_1 = 0

			if var_333_1 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect1089ui_story == nil then
				arg_330_1.var_.characterEffect1089ui_story = var_333_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_333_2 = 0.200000002980232

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_2 and not isNil(var_333_0) then
				local var_333_3 = (arg_330_1.time_ - var_333_1) / var_333_2

				if arg_330_1.var_.characterEffect1089ui_story and not isNil(var_333_0) then
					local var_333_4 = Mathf.Lerp(0, 0.5, var_333_3)

					arg_330_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_330_1.var_.characterEffect1089ui_story.fillRatio = var_333_4
				end
			end

			if arg_330_1.time_ >= var_333_1 + var_333_2 and arg_330_1.time_ < var_333_1 + var_333_2 + arg_333_0 and not isNil(var_333_0) and arg_330_1.var_.characterEffect1089ui_story then
				local var_333_5 = 0.5

				arg_330_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_330_1.var_.characterEffect1089ui_story.fillRatio = var_333_5
			end

			local var_333_6 = 0
			local var_333_7 = 0.775

			if var_333_6 < arg_330_1.time_ and arg_330_1.time_ <= var_333_6 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_8 = arg_330_1:GetWordFromCfg(322072079)
				local var_333_9 = arg_330_1:FormatText(var_333_8.content)

				arg_330_1.text_.text = var_333_9

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_10 = 31
				local var_333_11 = utf8.len(var_333_9)
				local var_333_12 = var_333_10 <= 0 and var_333_7 or var_333_7 * (var_333_11 / var_333_10)

				if var_333_12 > 0 and var_333_7 < var_333_12 then
					arg_330_1.talkMaxDuration = var_333_12

					if var_333_12 + var_333_6 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_12 + var_333_6
					end
				end

				arg_330_1.text_.text = var_333_9
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_13 = math.max(var_333_7, arg_330_1.talkMaxDuration)

			if var_333_6 <= arg_330_1.time_ and arg_330_1.time_ < var_333_6 + var_333_13 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_6) / var_333_13

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_6 + var_333_13 and arg_330_1.time_ < var_333_6 + var_333_13 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play322072080 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 322072080
		arg_334_1.duration_ = 8.93

		local var_334_0 = {
			zh = 6.4,
			ja = 8.933
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play322072081(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			local var_337_0 = arg_334_1.actors_["10103ui_story"].transform
			local var_337_1 = 0

			if var_337_1 < arg_334_1.time_ and arg_334_1.time_ <= var_337_1 + arg_337_0 then
				arg_334_1.var_.moveOldPos10103ui_story = var_337_0.localPosition

				local var_337_2 = GameObjectTools.GetOrAddComponent(var_337_0.gameObject, typeof(DynamicBoneHelper))

				if var_337_2 then
					var_337_2:EnableDynamicBone(false)
				end
			end

			local var_337_3 = 0.001

			if var_337_1 <= arg_334_1.time_ and arg_334_1.time_ < var_337_1 + var_337_3 then
				local var_337_4 = (arg_334_1.time_ - var_337_1) / var_337_3
				local var_337_5 = Vector3.New(-0.7, -0.95, -6.2)

				var_337_0.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos10103ui_story, var_337_5, var_337_4)

				local var_337_6 = manager.ui.mainCamera.transform.position - var_337_0.position

				var_337_0.forward = Vector3.New(var_337_6.x, var_337_6.y, var_337_6.z)

				local var_337_7 = var_337_0.localEulerAngles

				var_337_7.z = 0
				var_337_7.x = 0
				var_337_0.localEulerAngles = var_337_7
			end

			if arg_334_1.time_ >= var_337_1 + var_337_3 and arg_334_1.time_ < var_337_1 + var_337_3 + arg_337_0 then
				var_337_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_337_8 = manager.ui.mainCamera.transform.position - var_337_0.position

				var_337_0.forward = Vector3.New(var_337_8.x, var_337_8.y, var_337_8.z)

				local var_337_9 = var_337_0.localEulerAngles

				var_337_9.z = 0
				var_337_9.x = 0
				var_337_0.localEulerAngles = var_337_9

				local var_337_10 = GameObjectTools.GetOrAddComponent(var_337_0.gameObject, typeof(DynamicBoneHelper))

				if var_337_10 then
					var_337_10:EnableDynamicBone(true)
				end
			end

			local var_337_11 = arg_334_1.actors_["10103ui_story"]
			local var_337_12 = 0

			if var_337_12 < arg_334_1.time_ and arg_334_1.time_ <= var_337_12 + arg_337_0 and not isNil(var_337_11) and arg_334_1.var_.characterEffect10103ui_story == nil then
				arg_334_1.var_.characterEffect10103ui_story = var_337_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_13 = 0.200000002980232

			if var_337_12 <= arg_334_1.time_ and arg_334_1.time_ < var_337_12 + var_337_13 and not isNil(var_337_11) then
				local var_337_14 = (arg_334_1.time_ - var_337_12) / var_337_13

				if arg_334_1.var_.characterEffect10103ui_story and not isNil(var_337_11) then
					arg_334_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= var_337_12 + var_337_13 and arg_334_1.time_ < var_337_12 + var_337_13 + arg_337_0 and not isNil(var_337_11) and arg_334_1.var_.characterEffect10103ui_story then
				arg_334_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_337_15 = 0

			if var_337_15 < arg_334_1.time_ and arg_334_1.time_ <= var_337_15 + arg_337_0 then
				arg_334_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action9_1")
			end

			local var_337_16 = 0

			if var_337_16 < arg_334_1.time_ and arg_334_1.time_ <= var_337_16 + arg_337_0 then
				local var_337_17 = arg_334_1.actors_["10103ui_story"]

				if not isNil(var_337_17) then
					local var_337_18 = GameObjectTools.GetOrAddComponent(var_337_17, typeof(DynamicBoneHelper))

					if var_337_18 then
						var_337_18:EnableDynamicBone(true)
					end
				end
			end

			local var_337_19 = 0
			local var_337_20 = 0.525

			if var_337_19 < arg_334_1.time_ and arg_334_1.time_ <= var_337_19 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				local var_337_21 = arg_334_1:FormatText(StoryNameCfg[1214].name)

				arg_334_1.leftNameTxt_.text = var_337_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_22 = arg_334_1:GetWordFromCfg(322072080)
				local var_337_23 = arg_334_1:FormatText(var_337_22.content)

				arg_334_1.text_.text = var_337_23

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_24 = 21
				local var_337_25 = utf8.len(var_337_23)
				local var_337_26 = var_337_24 <= 0 and var_337_20 or var_337_20 * (var_337_25 / var_337_24)

				if var_337_26 > 0 and var_337_20 < var_337_26 then
					arg_334_1.talkMaxDuration = var_337_26

					if var_337_26 + var_337_19 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_26 + var_337_19
					end
				end

				arg_334_1.text_.text = var_337_23
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072080", "story_v_out_322072.awb") ~= 0 then
					local var_337_27 = manager.audio:GetVoiceLength("story_v_out_322072", "322072080", "story_v_out_322072.awb") / 1000

					if var_337_27 + var_337_19 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_27 + var_337_19
					end

					if var_337_22.prefab_name ~= "" and arg_334_1.actors_[var_337_22.prefab_name] ~= nil then
						local var_337_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_22.prefab_name].transform, "story_v_out_322072", "322072080", "story_v_out_322072.awb")

						arg_334_1:RecordAudio("322072080", var_337_28)
						arg_334_1:RecordAudio("322072080", var_337_28)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_322072", "322072080", "story_v_out_322072.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_322072", "322072080", "story_v_out_322072.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_29 = math.max(var_337_20, arg_334_1.talkMaxDuration)

			if var_337_19 <= arg_334_1.time_ and arg_334_1.time_ < var_337_19 + var_337_29 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_19) / var_337_29

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_19 + var_337_29 and arg_334_1.time_ < var_337_19 + var_337_29 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play322072081 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 322072081
		arg_338_1.duration_ = 12.2

		local var_338_0 = {
			zh = 7.7,
			ja = 12.2
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play322072082(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["10103ui_story"]
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect10103ui_story == nil then
				arg_338_1.var_.characterEffect10103ui_story = var_341_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 and not isNil(var_341_0) then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2

				if arg_338_1.var_.characterEffect10103ui_story and not isNil(var_341_0) then
					arg_338_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 and not isNil(var_341_0) and arg_338_1.var_.characterEffect10103ui_story then
				arg_338_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_341_4 = 0
			local var_341_5 = 0.9

			if var_341_4 < arg_338_1.time_ and arg_338_1.time_ <= var_341_4 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_6 = arg_338_1:FormatText(StoryNameCfg[1214].name)

				arg_338_1.leftNameTxt_.text = var_341_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_7 = arg_338_1:GetWordFromCfg(322072081)
				local var_341_8 = arg_338_1:FormatText(var_341_7.content)

				arg_338_1.text_.text = var_341_8

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_9 = 36
				local var_341_10 = utf8.len(var_341_8)
				local var_341_11 = var_341_9 <= 0 and var_341_5 or var_341_5 * (var_341_10 / var_341_9)

				if var_341_11 > 0 and var_341_5 < var_341_11 then
					arg_338_1.talkMaxDuration = var_341_11

					if var_341_11 + var_341_4 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_11 + var_341_4
					end
				end

				arg_338_1.text_.text = var_341_8
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072081", "story_v_out_322072.awb") ~= 0 then
					local var_341_12 = manager.audio:GetVoiceLength("story_v_out_322072", "322072081", "story_v_out_322072.awb") / 1000

					if var_341_12 + var_341_4 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_12 + var_341_4
					end

					if var_341_7.prefab_name ~= "" and arg_338_1.actors_[var_341_7.prefab_name] ~= nil then
						local var_341_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_7.prefab_name].transform, "story_v_out_322072", "322072081", "story_v_out_322072.awb")

						arg_338_1:RecordAudio("322072081", var_341_13)
						arg_338_1:RecordAudio("322072081", var_341_13)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_322072", "322072081", "story_v_out_322072.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_322072", "322072081", "story_v_out_322072.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_14 = math.max(var_341_5, arg_338_1.talkMaxDuration)

			if var_341_4 <= arg_338_1.time_ and arg_338_1.time_ < var_341_4 + var_341_14 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_4) / var_341_14

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_4 + var_341_14 and arg_338_1.time_ < var_341_4 + var_341_14 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play322072082 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 322072082
		arg_342_1.duration_ = 3.33

		local var_342_0 = {
			zh = 2.766,
			ja = 3.333
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play322072083(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1089ui_story"].transform
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.var_.moveOldPos1089ui_story = var_345_0.localPosition
			end

			local var_345_2 = 0.001

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2
				local var_345_4 = Vector3.New(0.7, -1.1, -6.17)

				var_345_0.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1089ui_story, var_345_4, var_345_3)

				local var_345_5 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_5.x, var_345_5.y, var_345_5.z)

				local var_345_6 = var_345_0.localEulerAngles

				var_345_6.z = 0
				var_345_6.x = 0
				var_345_0.localEulerAngles = var_345_6
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 then
				var_345_0.localPosition = Vector3.New(0.7, -1.1, -6.17)

				local var_345_7 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_7.x, var_345_7.y, var_345_7.z)

				local var_345_8 = var_345_0.localEulerAngles

				var_345_8.z = 0
				var_345_8.x = 0
				var_345_0.localEulerAngles = var_345_8
			end

			local var_345_9 = arg_342_1.actors_["1089ui_story"]
			local var_345_10 = 0

			if var_345_10 < arg_342_1.time_ and arg_342_1.time_ <= var_345_10 + arg_345_0 and not isNil(var_345_9) and arg_342_1.var_.characterEffect1089ui_story == nil then
				arg_342_1.var_.characterEffect1089ui_story = var_345_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_11 = 0.200000002980232

			if var_345_10 <= arg_342_1.time_ and arg_342_1.time_ < var_345_10 + var_345_11 and not isNil(var_345_9) then
				local var_345_12 = (arg_342_1.time_ - var_345_10) / var_345_11

				if arg_342_1.var_.characterEffect1089ui_story and not isNil(var_345_9) then
					arg_342_1.var_.characterEffect1089ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= var_345_10 + var_345_11 and arg_342_1.time_ < var_345_10 + var_345_11 + arg_345_0 and not isNil(var_345_9) and arg_342_1.var_.characterEffect1089ui_story then
				arg_342_1.var_.characterEffect1089ui_story.fillFlat = false
			end

			local var_345_13 = arg_342_1.actors_["10103ui_story"]
			local var_345_14 = 0

			if var_345_14 < arg_342_1.time_ and arg_342_1.time_ <= var_345_14 + arg_345_0 and not isNil(var_345_13) and arg_342_1.var_.characterEffect10103ui_story == nil then
				arg_342_1.var_.characterEffect10103ui_story = var_345_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_15 = 0.200000002980232

			if var_345_14 <= arg_342_1.time_ and arg_342_1.time_ < var_345_14 + var_345_15 and not isNil(var_345_13) then
				local var_345_16 = (arg_342_1.time_ - var_345_14) / var_345_15

				if arg_342_1.var_.characterEffect10103ui_story and not isNil(var_345_13) then
					local var_345_17 = Mathf.Lerp(0, 0.5, var_345_16)

					arg_342_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_342_1.var_.characterEffect10103ui_story.fillRatio = var_345_17
				end
			end

			if arg_342_1.time_ >= var_345_14 + var_345_15 and arg_342_1.time_ < var_345_14 + var_345_15 + arg_345_0 and not isNil(var_345_13) and arg_342_1.var_.characterEffect10103ui_story then
				local var_345_18 = 0.5

				arg_342_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_342_1.var_.characterEffect10103ui_story.fillRatio = var_345_18
			end

			local var_345_19 = 0

			if var_345_19 < arg_342_1.time_ and arg_342_1.time_ <= var_345_19 + arg_345_0 then
				arg_342_1:PlayTimeline("1089ui_story", "StoryTimeline/CharAction/story1089/story1089action/1089action5_1")
			end

			local var_345_20 = 0
			local var_345_21 = 0.3

			if var_345_20 < arg_342_1.time_ and arg_342_1.time_ <= var_345_20 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_22 = arg_342_1:FormatText(StoryNameCfg[1031].name)

				arg_342_1.leftNameTxt_.text = var_345_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_23 = arg_342_1:GetWordFromCfg(322072082)
				local var_345_24 = arg_342_1:FormatText(var_345_23.content)

				arg_342_1.text_.text = var_345_24

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_25 = 12
				local var_345_26 = utf8.len(var_345_24)
				local var_345_27 = var_345_25 <= 0 and var_345_21 or var_345_21 * (var_345_26 / var_345_25)

				if var_345_27 > 0 and var_345_21 < var_345_27 then
					arg_342_1.talkMaxDuration = var_345_27

					if var_345_27 + var_345_20 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_27 + var_345_20
					end
				end

				arg_342_1.text_.text = var_345_24
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072082", "story_v_out_322072.awb") ~= 0 then
					local var_345_28 = manager.audio:GetVoiceLength("story_v_out_322072", "322072082", "story_v_out_322072.awb") / 1000

					if var_345_28 + var_345_20 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_28 + var_345_20
					end

					if var_345_23.prefab_name ~= "" and arg_342_1.actors_[var_345_23.prefab_name] ~= nil then
						local var_345_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_23.prefab_name].transform, "story_v_out_322072", "322072082", "story_v_out_322072.awb")

						arg_342_1:RecordAudio("322072082", var_345_29)
						arg_342_1:RecordAudio("322072082", var_345_29)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_322072", "322072082", "story_v_out_322072.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_322072", "322072082", "story_v_out_322072.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_30 = math.max(var_345_21, arg_342_1.talkMaxDuration)

			if var_345_20 <= arg_342_1.time_ and arg_342_1.time_ < var_345_20 + var_345_30 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_20) / var_345_30

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_20 + var_345_30 and arg_342_1.time_ < var_345_20 + var_345_30 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
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

		arg_342_1:InitPlayNodeList()
	end,
	Play322072083 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 322072083
		arg_346_1.duration_ = 7

		local var_346_0 = {
			zh = 2.833,
			ja = 7
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play322072084(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = arg_346_1.actors_["10103ui_story"].transform
			local var_349_1 = 0

			if var_349_1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_1 + arg_349_0 then
				arg_346_1.var_.moveOldPos10103ui_story = var_349_0.localPosition

				local var_349_2 = GameObjectTools.GetOrAddComponent(var_349_0.gameObject, typeof(DynamicBoneHelper))

				if var_349_2 then
					var_349_2:EnableDynamicBone(false)
				end
			end

			local var_349_3 = 0.001

			if var_349_1 <= arg_346_1.time_ and arg_346_1.time_ < var_349_1 + var_349_3 then
				local var_349_4 = (arg_346_1.time_ - var_349_1) / var_349_3
				local var_349_5 = Vector3.New(-0.7, -0.95, -6.2)

				var_349_0.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos10103ui_story, var_349_5, var_349_4)

				local var_349_6 = manager.ui.mainCamera.transform.position - var_349_0.position

				var_349_0.forward = Vector3.New(var_349_6.x, var_349_6.y, var_349_6.z)

				local var_349_7 = var_349_0.localEulerAngles

				var_349_7.z = 0
				var_349_7.x = 0
				var_349_0.localEulerAngles = var_349_7
			end

			if arg_346_1.time_ >= var_349_1 + var_349_3 and arg_346_1.time_ < var_349_1 + var_349_3 + arg_349_0 then
				var_349_0.localPosition = Vector3.New(-0.7, -0.95, -6.2)

				local var_349_8 = manager.ui.mainCamera.transform.position - var_349_0.position

				var_349_0.forward = Vector3.New(var_349_8.x, var_349_8.y, var_349_8.z)

				local var_349_9 = var_349_0.localEulerAngles

				var_349_9.z = 0
				var_349_9.x = 0
				var_349_0.localEulerAngles = var_349_9

				local var_349_10 = GameObjectTools.GetOrAddComponent(var_349_0.gameObject, typeof(DynamicBoneHelper))

				if var_349_10 then
					var_349_10:EnableDynamicBone(true)
				end
			end

			local var_349_11 = arg_346_1.actors_["10103ui_story"]
			local var_349_12 = 0

			if var_349_12 < arg_346_1.time_ and arg_346_1.time_ <= var_349_12 + arg_349_0 and not isNil(var_349_11) and arg_346_1.var_.characterEffect10103ui_story == nil then
				arg_346_1.var_.characterEffect10103ui_story = var_349_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_13 = 0.200000002980232

			if var_349_12 <= arg_346_1.time_ and arg_346_1.time_ < var_349_12 + var_349_13 and not isNil(var_349_11) then
				local var_349_14 = (arg_346_1.time_ - var_349_12) / var_349_13

				if arg_346_1.var_.characterEffect10103ui_story and not isNil(var_349_11) then
					arg_346_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= var_349_12 + var_349_13 and arg_346_1.time_ < var_349_12 + var_349_13 + arg_349_0 and not isNil(var_349_11) and arg_346_1.var_.characterEffect10103ui_story then
				arg_346_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_349_15 = arg_346_1.actors_["1089ui_story"]
			local var_349_16 = 0

			if var_349_16 < arg_346_1.time_ and arg_346_1.time_ <= var_349_16 + arg_349_0 and not isNil(var_349_15) and arg_346_1.var_.characterEffect1089ui_story == nil then
				arg_346_1.var_.characterEffect1089ui_story = var_349_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_17 = 0.200000002980232

			if var_349_16 <= arg_346_1.time_ and arg_346_1.time_ < var_349_16 + var_349_17 and not isNil(var_349_15) then
				local var_349_18 = (arg_346_1.time_ - var_349_16) / var_349_17

				if arg_346_1.var_.characterEffect1089ui_story and not isNil(var_349_15) then
					local var_349_19 = Mathf.Lerp(0, 0.5, var_349_18)

					arg_346_1.var_.characterEffect1089ui_story.fillFlat = true
					arg_346_1.var_.characterEffect1089ui_story.fillRatio = var_349_19
				end
			end

			if arg_346_1.time_ >= var_349_16 + var_349_17 and arg_346_1.time_ < var_349_16 + var_349_17 + arg_349_0 and not isNil(var_349_15) and arg_346_1.var_.characterEffect1089ui_story then
				local var_349_20 = 0.5

				arg_346_1.var_.characterEffect1089ui_story.fillFlat = true
				arg_346_1.var_.characterEffect1089ui_story.fillRatio = var_349_20
			end

			local var_349_21 = 0

			if var_349_21 < arg_346_1.time_ and arg_346_1.time_ <= var_349_21 + arg_349_0 then
				arg_346_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action9_2")
			end

			local var_349_22 = 0

			if var_349_22 < arg_346_1.time_ and arg_346_1.time_ <= var_349_22 + arg_349_0 then
				arg_346_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_349_23 = 0

			if var_349_23 < arg_346_1.time_ and arg_346_1.time_ <= var_349_23 + arg_349_0 then
				local var_349_24 = arg_346_1.actors_["10103ui_story"]

				if not isNil(var_349_24) then
					local var_349_25 = GameObjectTools.GetOrAddComponent(var_349_24, typeof(DynamicBoneHelper))

					if var_349_25 then
						var_349_25:EnableDynamicBone(true)
					end
				end
			end

			local var_349_26 = 0
			local var_349_27 = 0.325

			if var_349_26 < arg_346_1.time_ and arg_346_1.time_ <= var_349_26 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				local var_349_28 = arg_346_1:FormatText(StoryNameCfg[1214].name)

				arg_346_1.leftNameTxt_.text = var_349_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_29 = arg_346_1:GetWordFromCfg(322072083)
				local var_349_30 = arg_346_1:FormatText(var_349_29.content)

				arg_346_1.text_.text = var_349_30

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_31 = 13
				local var_349_32 = utf8.len(var_349_30)
				local var_349_33 = var_349_31 <= 0 and var_349_27 or var_349_27 * (var_349_32 / var_349_31)

				if var_349_33 > 0 and var_349_27 < var_349_33 then
					arg_346_1.talkMaxDuration = var_349_33

					if var_349_33 + var_349_26 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_33 + var_349_26
					end
				end

				arg_346_1.text_.text = var_349_30
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072083", "story_v_out_322072.awb") ~= 0 then
					local var_349_34 = manager.audio:GetVoiceLength("story_v_out_322072", "322072083", "story_v_out_322072.awb") / 1000

					if var_349_34 + var_349_26 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_34 + var_349_26
					end

					if var_349_29.prefab_name ~= "" and arg_346_1.actors_[var_349_29.prefab_name] ~= nil then
						local var_349_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_29.prefab_name].transform, "story_v_out_322072", "322072083", "story_v_out_322072.awb")

						arg_346_1:RecordAudio("322072083", var_349_35)
						arg_346_1:RecordAudio("322072083", var_349_35)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_322072", "322072083", "story_v_out_322072.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_322072", "322072083", "story_v_out_322072.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_36 = math.max(var_349_27, arg_346_1.talkMaxDuration)

			if var_349_26 <= arg_346_1.time_ and arg_346_1.time_ < var_349_26 + var_349_36 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_26) / var_349_36

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_26 + var_349_36 and arg_346_1.time_ < var_349_26 + var_349_36 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play322072084 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 322072084
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play322072085(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = arg_350_1.actors_["10103ui_story"].transform
			local var_353_1 = 0

			if var_353_1 < arg_350_1.time_ and arg_350_1.time_ <= var_353_1 + arg_353_0 then
				arg_350_1.var_.moveOldPos10103ui_story = var_353_0.localPosition

				local var_353_2 = GameObjectTools.GetOrAddComponent(var_353_0.gameObject, typeof(DynamicBoneHelper))

				if var_353_2 then
					var_353_2:EnableDynamicBone(false)
				end
			end

			local var_353_3 = 0.001

			if var_353_1 <= arg_350_1.time_ and arg_350_1.time_ < var_353_1 + var_353_3 then
				local var_353_4 = (arg_350_1.time_ - var_353_1) / var_353_3
				local var_353_5 = Vector3.New(0, 100, 0)

				var_353_0.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos10103ui_story, var_353_5, var_353_4)

				local var_353_6 = manager.ui.mainCamera.transform.position - var_353_0.position

				var_353_0.forward = Vector3.New(var_353_6.x, var_353_6.y, var_353_6.z)

				local var_353_7 = var_353_0.localEulerAngles

				var_353_7.z = 0
				var_353_7.x = 0
				var_353_0.localEulerAngles = var_353_7
			end

			if arg_350_1.time_ >= var_353_1 + var_353_3 and arg_350_1.time_ < var_353_1 + var_353_3 + arg_353_0 then
				var_353_0.localPosition = Vector3.New(0, 100, 0)

				local var_353_8 = manager.ui.mainCamera.transform.position - var_353_0.position

				var_353_0.forward = Vector3.New(var_353_8.x, var_353_8.y, var_353_8.z)

				local var_353_9 = var_353_0.localEulerAngles

				var_353_9.z = 0
				var_353_9.x = 0
				var_353_0.localEulerAngles = var_353_9

				local var_353_10 = GameObjectTools.GetOrAddComponent(var_353_0.gameObject, typeof(DynamicBoneHelper))

				if var_353_10 then
					var_353_10:EnableDynamicBone(true)
				end
			end

			local var_353_11 = arg_350_1.actors_["1089ui_story"].transform
			local var_353_12 = 0

			if var_353_12 < arg_350_1.time_ and arg_350_1.time_ <= var_353_12 + arg_353_0 then
				arg_350_1.var_.moveOldPos1089ui_story = var_353_11.localPosition
			end

			local var_353_13 = 0.001

			if var_353_12 <= arg_350_1.time_ and arg_350_1.time_ < var_353_12 + var_353_13 then
				local var_353_14 = (arg_350_1.time_ - var_353_12) / var_353_13
				local var_353_15 = Vector3.New(0, 100, 0)

				var_353_11.localPosition = Vector3.Lerp(arg_350_1.var_.moveOldPos1089ui_story, var_353_15, var_353_14)

				local var_353_16 = manager.ui.mainCamera.transform.position - var_353_11.position

				var_353_11.forward = Vector3.New(var_353_16.x, var_353_16.y, var_353_16.z)

				local var_353_17 = var_353_11.localEulerAngles

				var_353_17.z = 0
				var_353_17.x = 0
				var_353_11.localEulerAngles = var_353_17
			end

			if arg_350_1.time_ >= var_353_12 + var_353_13 and arg_350_1.time_ < var_353_12 + var_353_13 + arg_353_0 then
				var_353_11.localPosition = Vector3.New(0, 100, 0)

				local var_353_18 = manager.ui.mainCamera.transform.position - var_353_11.position

				var_353_11.forward = Vector3.New(var_353_18.x, var_353_18.y, var_353_18.z)

				local var_353_19 = var_353_11.localEulerAngles

				var_353_19.z = 0
				var_353_19.x = 0
				var_353_11.localEulerAngles = var_353_19
			end

			local var_353_20 = 0.1
			local var_353_21 = 1

			if var_353_20 < arg_350_1.time_ and arg_350_1.time_ <= var_353_20 + arg_353_0 then
				local var_353_22 = "play"
				local var_353_23 = "effect"

				arg_350_1:AudioAction(var_353_22, var_353_23, "se_story_145", "se_story_145_summon_barrier", "")
			end

			local var_353_24 = 0
			local var_353_25 = 1.3

			if var_353_24 < arg_350_1.time_ and arg_350_1.time_ <= var_353_24 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_26 = arg_350_1:GetWordFromCfg(322072084)
				local var_353_27 = arg_350_1:FormatText(var_353_26.content)

				arg_350_1.text_.text = var_353_27

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_28 = 52
				local var_353_29 = utf8.len(var_353_27)
				local var_353_30 = var_353_28 <= 0 and var_353_25 or var_353_25 * (var_353_29 / var_353_28)

				if var_353_30 > 0 and var_353_25 < var_353_30 then
					arg_350_1.talkMaxDuration = var_353_30

					if var_353_30 + var_353_24 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_30 + var_353_24
					end
				end

				arg_350_1.text_.text = var_353_27
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_31 = math.max(var_353_25, arg_350_1.talkMaxDuration)

			if var_353_24 <= arg_350_1.time_ and arg_350_1.time_ < var_353_24 + var_353_31 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_24) / var_353_31

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_24 + var_353_31 and arg_350_1.time_ < var_353_24 + var_353_31 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_350_1:InitPlayNodeList()
	end,
	Play322072085 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 322072085
		arg_354_1.duration_ = 13.77

		local var_354_0 = {
			zh = 7.4,
			ja = 13.766
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play322072086(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = arg_354_1.actors_["10103ui_story"].transform
			local var_357_1 = 0

			if var_357_1 < arg_354_1.time_ and arg_354_1.time_ <= var_357_1 + arg_357_0 then
				arg_354_1.var_.moveOldPos10103ui_story = var_357_0.localPosition

				local var_357_2 = GameObjectTools.GetOrAddComponent(var_357_0.gameObject, typeof(DynamicBoneHelper))

				if var_357_2 then
					var_357_2:EnableDynamicBone(false)
				end
			end

			local var_357_3 = 0.001

			if var_357_1 <= arg_354_1.time_ and arg_354_1.time_ < var_357_1 + var_357_3 then
				local var_357_4 = (arg_354_1.time_ - var_357_1) / var_357_3
				local var_357_5 = Vector3.New(0, -0.95, -6.2)

				var_357_0.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10103ui_story, var_357_5, var_357_4)

				local var_357_6 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_6.x, var_357_6.y, var_357_6.z)

				local var_357_7 = var_357_0.localEulerAngles

				var_357_7.z = 0
				var_357_7.x = 0
				var_357_0.localEulerAngles = var_357_7
			end

			if arg_354_1.time_ >= var_357_1 + var_357_3 and arg_354_1.time_ < var_357_1 + var_357_3 + arg_357_0 then
				var_357_0.localPosition = Vector3.New(0, -0.95, -6.2)

				local var_357_8 = manager.ui.mainCamera.transform.position - var_357_0.position

				var_357_0.forward = Vector3.New(var_357_8.x, var_357_8.y, var_357_8.z)

				local var_357_9 = var_357_0.localEulerAngles

				var_357_9.z = 0
				var_357_9.x = 0
				var_357_0.localEulerAngles = var_357_9

				local var_357_10 = GameObjectTools.GetOrAddComponent(var_357_0.gameObject, typeof(DynamicBoneHelper))

				if var_357_10 then
					var_357_10:EnableDynamicBone(true)
				end
			end

			local var_357_11 = arg_354_1.actors_["10103ui_story"]
			local var_357_12 = 0

			if var_357_12 < arg_354_1.time_ and arg_354_1.time_ <= var_357_12 + arg_357_0 and not isNil(var_357_11) and arg_354_1.var_.characterEffect10103ui_story == nil then
				arg_354_1.var_.characterEffect10103ui_story = var_357_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_13 = 0.200000002980232

			if var_357_12 <= arg_354_1.time_ and arg_354_1.time_ < var_357_12 + var_357_13 and not isNil(var_357_11) then
				local var_357_14 = (arg_354_1.time_ - var_357_12) / var_357_13

				if arg_354_1.var_.characterEffect10103ui_story and not isNil(var_357_11) then
					arg_354_1.var_.characterEffect10103ui_story.fillFlat = false
				end
			end

			if arg_354_1.time_ >= var_357_12 + var_357_13 and arg_354_1.time_ < var_357_12 + var_357_13 + arg_357_0 and not isNil(var_357_11) and arg_354_1.var_.characterEffect10103ui_story then
				arg_354_1.var_.characterEffect10103ui_story.fillFlat = false
			end

			local var_357_15 = 0

			if var_357_15 < arg_354_1.time_ and arg_354_1.time_ <= var_357_15 + arg_357_0 then
				arg_354_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/story10103/story10103action/10103action3_1")
			end

			local var_357_16 = 0

			if var_357_16 < arg_354_1.time_ and arg_354_1.time_ <= var_357_16 + arg_357_0 then
				arg_354_1:PlayTimeline("10103ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_357_17 = 0

			if var_357_17 < arg_354_1.time_ and arg_354_1.time_ <= var_357_17 + arg_357_0 then
				local var_357_18 = arg_354_1.actors_["10103ui_story"]

				if not isNil(var_357_18) then
					local var_357_19 = GameObjectTools.GetOrAddComponent(var_357_18, typeof(DynamicBoneHelper))

					if var_357_19 then
						var_357_19:EnableDynamicBone(true)
					end
				end
			end

			local var_357_20 = 0
			local var_357_21 = 0.8

			if var_357_20 < arg_354_1.time_ and arg_354_1.time_ <= var_357_20 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_22 = arg_354_1:FormatText(StoryNameCfg[1214].name)

				arg_354_1.leftNameTxt_.text = var_357_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_23 = arg_354_1:GetWordFromCfg(322072085)
				local var_357_24 = arg_354_1:FormatText(var_357_23.content)

				arg_354_1.text_.text = var_357_24

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_25 = 32
				local var_357_26 = utf8.len(var_357_24)
				local var_357_27 = var_357_25 <= 0 and var_357_21 or var_357_21 * (var_357_26 / var_357_25)

				if var_357_27 > 0 and var_357_21 < var_357_27 then
					arg_354_1.talkMaxDuration = var_357_27

					if var_357_27 + var_357_20 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_27 + var_357_20
					end
				end

				arg_354_1.text_.text = var_357_24
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072085", "story_v_out_322072.awb") ~= 0 then
					local var_357_28 = manager.audio:GetVoiceLength("story_v_out_322072", "322072085", "story_v_out_322072.awb") / 1000

					if var_357_28 + var_357_20 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_28 + var_357_20
					end

					if var_357_23.prefab_name ~= "" and arg_354_1.actors_[var_357_23.prefab_name] ~= nil then
						local var_357_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_23.prefab_name].transform, "story_v_out_322072", "322072085", "story_v_out_322072.awb")

						arg_354_1:RecordAudio("322072085", var_357_29)
						arg_354_1:RecordAudio("322072085", var_357_29)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_322072", "322072085", "story_v_out_322072.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_322072", "322072085", "story_v_out_322072.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_30 = math.max(var_357_21, arg_354_1.talkMaxDuration)

			if var_357_20 <= arg_354_1.time_ and arg_354_1.time_ < var_357_20 + var_357_30 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_20) / var_357_30

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_20 + var_357_30 and arg_354_1.time_ < var_357_20 + var_357_30 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play322072086 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 322072086
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play322072087(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = arg_358_1.actors_["10103ui_story"].transform
			local var_361_1 = 0

			if var_361_1 < arg_358_1.time_ and arg_358_1.time_ <= var_361_1 + arg_361_0 then
				arg_358_1.var_.moveOldPos10103ui_story = var_361_0.localPosition

				local var_361_2 = GameObjectTools.GetOrAddComponent(var_361_0.gameObject, typeof(DynamicBoneHelper))

				if var_361_2 then
					var_361_2:EnableDynamicBone(false)
				end
			end

			local var_361_3 = 0.001

			if var_361_1 <= arg_358_1.time_ and arg_358_1.time_ < var_361_1 + var_361_3 then
				local var_361_4 = (arg_358_1.time_ - var_361_1) / var_361_3
				local var_361_5 = Vector3.New(0, 100, 0)

				var_361_0.localPosition = Vector3.Lerp(arg_358_1.var_.moveOldPos10103ui_story, var_361_5, var_361_4)

				local var_361_6 = manager.ui.mainCamera.transform.position - var_361_0.position

				var_361_0.forward = Vector3.New(var_361_6.x, var_361_6.y, var_361_6.z)

				local var_361_7 = var_361_0.localEulerAngles

				var_361_7.z = 0
				var_361_7.x = 0
				var_361_0.localEulerAngles = var_361_7
			end

			if arg_358_1.time_ >= var_361_1 + var_361_3 and arg_358_1.time_ < var_361_1 + var_361_3 + arg_361_0 then
				var_361_0.localPosition = Vector3.New(0, 100, 0)

				local var_361_8 = manager.ui.mainCamera.transform.position - var_361_0.position

				var_361_0.forward = Vector3.New(var_361_8.x, var_361_8.y, var_361_8.z)

				local var_361_9 = var_361_0.localEulerAngles

				var_361_9.z = 0
				var_361_9.x = 0
				var_361_0.localEulerAngles = var_361_9

				local var_361_10 = GameObjectTools.GetOrAddComponent(var_361_0.gameObject, typeof(DynamicBoneHelper))

				if var_361_10 then
					var_361_10:EnableDynamicBone(true)
				end
			end

			local var_361_11 = arg_358_1.actors_["10103ui_story"]
			local var_361_12 = 0

			if var_361_12 < arg_358_1.time_ and arg_358_1.time_ <= var_361_12 + arg_361_0 and not isNil(var_361_11) and arg_358_1.var_.characterEffect10103ui_story == nil then
				arg_358_1.var_.characterEffect10103ui_story = var_361_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_361_13 = 0.200000002980232

			if var_361_12 <= arg_358_1.time_ and arg_358_1.time_ < var_361_12 + var_361_13 and not isNil(var_361_11) then
				local var_361_14 = (arg_358_1.time_ - var_361_12) / var_361_13

				if arg_358_1.var_.characterEffect10103ui_story and not isNil(var_361_11) then
					local var_361_15 = Mathf.Lerp(0, 0.5, var_361_14)

					arg_358_1.var_.characterEffect10103ui_story.fillFlat = true
					arg_358_1.var_.characterEffect10103ui_story.fillRatio = var_361_15
				end
			end

			if arg_358_1.time_ >= var_361_12 + var_361_13 and arg_358_1.time_ < var_361_12 + var_361_13 + arg_361_0 and not isNil(var_361_11) and arg_358_1.var_.characterEffect10103ui_story then
				local var_361_16 = 0.5

				arg_358_1.var_.characterEffect10103ui_story.fillFlat = true
				arg_358_1.var_.characterEffect10103ui_story.fillRatio = var_361_16
			end

			local var_361_17 = 0.1
			local var_361_18 = 1

			if var_361_17 < arg_358_1.time_ and arg_358_1.time_ <= var_361_17 + arg_361_0 then
				local var_361_19 = "play"
				local var_361_20 = "effect"

				arg_358_1:AudioAction(var_361_19, var_361_20, "se_story_121_04", "se_story_121_04_scan", "")
			end

			local var_361_21 = manager.ui.mainCamera.transform
			local var_361_22 = 0.1

			if var_361_22 < arg_358_1.time_ and arg_358_1.time_ <= var_361_22 + arg_361_0 then
				local var_361_23 = arg_358_1.var_.effect2086
				local var_361_24
				local var_361_25 = var_361_21

				if not var_361_23 then
					var_361_23 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_scan_in_out"), var_361_25)
					var_361_23.name = "2086"
					arg_358_1.var_.effect2086 = var_361_23
				else
					var_361_23.transform:SetParent(var_361_25)
				end

				var_361_23.transform.localPosition = Vector3.New(0, 0, 0)
				var_361_23.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_361_26 = manager.ui.mainCameraCom_
				local var_361_27 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_361_26.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_361_28 = var_361_23.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_361_29 = 15
				local var_361_30 = 2 * var_361_29 * Mathf.Tan(var_361_26.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_361_26.aspect
				local var_361_31 = 1
				local var_361_32 = 1.7777777777777777

				if var_361_32 < var_361_26.aspect then
					var_361_31 = var_361_30 / (2 * var_361_29 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_361_32)
				end

				for iter_361_0, iter_361_1 in ipairs(var_361_28) do
					local var_361_33 = iter_361_1.transform.localScale

					iter_361_1.transform.localScale = Vector3.New(var_361_33.x / var_361_27 * var_361_31, var_361_33.y / var_361_27, var_361_33.z)
				end
			end

			local var_361_34 = 0
			local var_361_35 = 0.925

			if var_361_34 < arg_358_1.time_ and arg_358_1.time_ <= var_361_34 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_36 = arg_358_1:GetWordFromCfg(322072086)
				local var_361_37 = arg_358_1:FormatText(var_361_36.content)

				arg_358_1.text_.text = var_361_37

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_38 = 37
				local var_361_39 = utf8.len(var_361_37)
				local var_361_40 = var_361_38 <= 0 and var_361_35 or var_361_35 * (var_361_39 / var_361_38)

				if var_361_40 > 0 and var_361_35 < var_361_40 then
					arg_358_1.talkMaxDuration = var_361_40

					if var_361_40 + var_361_34 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_40 + var_361_34
					end
				end

				arg_358_1.text_.text = var_361_37
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_41 = math.max(var_361_35, arg_358_1.talkMaxDuration)

			if var_361_34 <= arg_358_1.time_ and arg_358_1.time_ < var_361_34 + var_361_41 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - var_361_34) / var_361_41

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= var_361_34 + var_361_41 and arg_358_1.time_ < var_361_34 + var_361_41 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10103ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_358_1:InitPlayNodeList()
	end,
	Play322072087 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 322072087
		arg_362_1.duration_ = 9

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play322072088(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 1.999999999999

			if var_365_0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_0 + arg_365_0 then
				local var_365_1 = manager.ui.mainCamera.transform.localPosition
				local var_365_2 = Vector3.New(0, 0, 10) + Vector3.New(var_365_1.x, var_365_1.y, 0)
				local var_365_3 = arg_362_1.bgs_.L17f

				var_365_3.transform.localPosition = var_365_2
				var_365_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_365_4 = var_365_3:GetComponent("SpriteRenderer")

				if var_365_4 and var_365_4.sprite then
					local var_365_5 = (var_365_3.transform.localPosition - var_365_1).z
					local var_365_6 = manager.ui.mainCameraCom_
					local var_365_7 = 2 * var_365_5 * Mathf.Tan(var_365_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_365_8 = var_365_7 * var_365_6.aspect
					local var_365_9 = var_365_4.sprite.bounds.size.x
					local var_365_10 = var_365_4.sprite.bounds.size.y
					local var_365_11 = var_365_8 / var_365_9
					local var_365_12 = var_365_7 / var_365_10
					local var_365_13 = var_365_12 < var_365_11 and var_365_11 or var_365_12

					var_365_3.transform.localScale = Vector3.New(var_365_13, var_365_13, 0)
				end

				for iter_365_0, iter_365_1 in pairs(arg_362_1.bgs_) do
					if iter_365_0 ~= "L17f" then
						iter_365_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_365_14 = 3.999999999999

			if var_365_14 < arg_362_1.time_ and arg_362_1.time_ <= var_365_14 + arg_365_0 then
				arg_362_1.allBtn_.enabled = false
			end

			local var_365_15 = 0.3

			if arg_362_1.time_ >= var_365_14 + var_365_15 and arg_362_1.time_ < var_365_14 + var_365_15 + arg_365_0 then
				arg_362_1.allBtn_.enabled = true
			end

			local var_365_16 = 0

			if var_365_16 < arg_362_1.time_ and arg_362_1.time_ <= var_365_16 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_17 = 2

			if var_365_16 <= arg_362_1.time_ and arg_362_1.time_ < var_365_16 + var_365_17 then
				local var_365_18 = (arg_362_1.time_ - var_365_16) / var_365_17
				local var_365_19 = Color.New(0, 0, 0)

				var_365_19.a = Mathf.Lerp(0, 1, var_365_18)
				arg_362_1.mask_.color = var_365_19
			end

			if arg_362_1.time_ >= var_365_16 + var_365_17 and arg_362_1.time_ < var_365_16 + var_365_17 + arg_365_0 then
				local var_365_20 = Color.New(0, 0, 0)

				var_365_20.a = 1
				arg_362_1.mask_.color = var_365_20
			end

			local var_365_21 = 2

			if var_365_21 < arg_362_1.time_ and arg_362_1.time_ <= var_365_21 + arg_365_0 then
				arg_362_1.mask_.enabled = true
				arg_362_1.mask_.raycastTarget = true

				arg_362_1:SetGaussion(false)
			end

			local var_365_22 = 2

			if var_365_21 <= arg_362_1.time_ and arg_362_1.time_ < var_365_21 + var_365_22 then
				local var_365_23 = (arg_362_1.time_ - var_365_21) / var_365_22
				local var_365_24 = Color.New(0, 0, 0)

				var_365_24.a = Mathf.Lerp(1, 0, var_365_23)
				arg_362_1.mask_.color = var_365_24
			end

			if arg_362_1.time_ >= var_365_21 + var_365_22 and arg_362_1.time_ < var_365_21 + var_365_22 + arg_365_0 then
				local var_365_25 = Color.New(0, 0, 0)
				local var_365_26 = 0

				arg_362_1.mask_.enabled = false
				var_365_25.a = var_365_26
				arg_362_1.mask_.color = var_365_25
			end

			local var_365_27 = 0.233333333333333
			local var_365_28 = 1

			if var_365_27 < arg_362_1.time_ and arg_362_1.time_ <= var_365_27 + arg_365_0 then
				local var_365_29 = "stop"
				local var_365_30 = "effect"

				arg_362_1:AudioAction(var_365_29, var_365_30, "se_story_145", "se_story_145_amb_data", "")
			end

			local var_365_31 = 1.6
			local var_365_32 = 1

			if var_365_31 < arg_362_1.time_ and arg_362_1.time_ <= var_365_31 + arg_365_0 then
				local var_365_33 = "play"
				local var_365_34 = "effect"

				arg_362_1:AudioAction(var_365_33, var_365_34, "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_365_35 = manager.ui.mainCamera.transform
			local var_365_36 = 1.999999999999

			if var_365_36 < arg_362_1.time_ and arg_362_1.time_ <= var_365_36 + arg_365_0 then
				local var_365_37 = arg_362_1.var_.effect2086

				if var_365_37 then
					Object.Destroy(var_365_37)

					arg_362_1.var_.effect2086 = nil
				end
			end

			local var_365_38 = manager.ui.mainCamera.transform
			local var_365_39 = 2.01666666666567

			if var_365_39 < arg_362_1.time_ and arg_362_1.time_ <= var_365_39 + arg_365_0 then
				local var_365_40 = arg_362_1.var_.effect2086

				if var_365_40 then
					Object.Destroy(var_365_40)

					arg_362_1.var_.effect2086 = nil
				end
			end

			local var_365_41 = 1.6
			local var_365_42 = 1

			if var_365_41 < arg_362_1.time_ and arg_362_1.time_ <= var_365_41 + arg_365_0 then
				local var_365_43 = "play"
				local var_365_44 = "music"

				arg_362_1:AudioAction(var_365_43, var_365_44, "bgm_activity_4_5_story_serious", "battle", "bgm_activity_4_5_story_serious.awb")

				local var_365_45 = ""
				local var_365_46 = manager.audio:GetAudioName("bgm_activity_4_5_story_serious", "battle")

				if var_365_46 ~= "" then
					if arg_362_1.bgmTxt_.text ~= var_365_46 and arg_362_1.bgmTxt_.text ~= "" then
						if arg_362_1.bgmTxt2_.text ~= "" then
							arg_362_1.bgmTxt_.text = arg_362_1.bgmTxt2_.text
						end

						arg_362_1.bgmTxt2_.text = var_365_46

						arg_362_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_362_1.bgmTxt_.text = var_365_46
						arg_362_1.bgmTxt2_.text = var_365_46
					end

					if arg_362_1.bgmTimer then
						arg_362_1.bgmTimer:Stop()

						arg_362_1.bgmTimer = nil
					end

					if arg_362_1.settingData.show_music_name == 1 then
						arg_362_1.musicController:SetSelectedState("show")
						arg_362_1.musicAnimator_:Play("open", 0, 0)

						if arg_362_1.settingData.music_time ~= 0 then
							arg_362_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_362_1.settingData.music_time), function()
								if arg_362_1 == nil or isNil(arg_362_1.bgmTxt_) then
									return
								end

								arg_362_1.musicController:SetSelectedState("hide")
								arg_362_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_362_1.frameCnt_ <= 1 then
				arg_362_1.dialog_:SetActive(false)
			end

			local var_365_47 = 4
			local var_365_48 = 0.925

			if var_365_47 < arg_362_1.time_ and arg_362_1.time_ <= var_365_47 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0

				arg_362_1.dialog_:SetActive(true)

				arg_362_1.dialogCg_.alpha = 0

				local var_365_49 = LeanTween.value(arg_362_1.dialog_, 0, 1, 0.3)

				var_365_49:setOnUpdate(LuaHelper.FloatAction(function(arg_367_0)
					arg_362_1.dialogCg_.alpha = arg_367_0
				end))
				var_365_49:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_362_1.dialog_)
					var_365_49:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_362_1.duration_ = arg_362_1.duration_ + 0.3

				SetActive(arg_362_1.leftNameGo_, false)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_50 = arg_362_1:GetWordFromCfg(322072087)
				local var_365_51 = arg_362_1:FormatText(var_365_50.content)

				arg_362_1.text_.text = var_365_51

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_52 = 37
				local var_365_53 = utf8.len(var_365_51)
				local var_365_54 = var_365_52 <= 0 and var_365_48 or var_365_48 * (var_365_53 / var_365_52)

				if var_365_54 > 0 and var_365_48 < var_365_54 then
					arg_362_1.talkMaxDuration = var_365_54
					var_365_47 = var_365_47 + 0.3

					if var_365_54 + var_365_47 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_54 + var_365_47
					end
				end

				arg_362_1.text_.text = var_365_51
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)
				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_55 = var_365_47 + 0.3
			local var_365_56 = math.max(var_365_48, arg_362_1.talkMaxDuration)

			if var_365_55 <= arg_362_1.time_ and arg_362_1.time_ < var_365_55 + var_365_56 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_55) / var_365_56

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_55 + var_365_56 and arg_362_1.time_ < var_365_55 + var_365_56 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play322072088 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 322072088
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play322072089(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = 0
			local var_372_1 = 1.65

			if var_372_0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_0 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_2 = arg_369_1:GetWordFromCfg(322072088)
				local var_372_3 = arg_369_1:FormatText(var_372_2.content)

				arg_369_1.text_.text = var_372_3

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_4 = 66
				local var_372_5 = utf8.len(var_372_3)
				local var_372_6 = var_372_4 <= 0 and var_372_1 or var_372_1 * (var_372_5 / var_372_4)

				if var_372_6 > 0 and var_372_1 < var_372_6 then
					arg_369_1.talkMaxDuration = var_372_6

					if var_372_6 + var_372_0 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_6 + var_372_0
					end
				end

				arg_369_1.text_.text = var_372_3
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_7 = math.max(var_372_1, arg_369_1.talkMaxDuration)

			if var_372_0 <= arg_369_1.time_ and arg_369_1.time_ < var_372_0 + var_372_7 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_0) / var_372_7

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_0 + var_372_7 and arg_369_1.time_ < var_372_0 + var_372_7 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play322072089 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 322072089
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play322072090(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			local var_376_0 = 0
			local var_376_1 = 1.475

			if var_376_0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_0 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, false)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_2 = arg_373_1:GetWordFromCfg(322072089)
				local var_376_3 = arg_373_1:FormatText(var_376_2.content)

				arg_373_1.text_.text = var_376_3

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_4 = 59
				local var_376_5 = utf8.len(var_376_3)
				local var_376_6 = var_376_4 <= 0 and var_376_1 or var_376_1 * (var_376_5 / var_376_4)

				if var_376_6 > 0 and var_376_1 < var_376_6 then
					arg_373_1.talkMaxDuration = var_376_6

					if var_376_6 + var_376_0 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_6 + var_376_0
					end
				end

				arg_373_1.text_.text = var_376_3
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_7 = math.max(var_376_1, arg_373_1.talkMaxDuration)

			if var_376_0 <= arg_373_1.time_ and arg_373_1.time_ < var_376_0 + var_376_7 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_0) / var_376_7

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_0 + var_376_7 and arg_373_1.time_ < var_376_0 + var_376_7 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play322072090 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 322072090
		arg_377_1.duration_ = 4.17

		local var_377_0 = {
			zh = 4.066,
			ja = 4.166
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play322072091(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			local var_380_0 = arg_377_1.actors_["1284ui_story"].transform
			local var_380_1 = 0

			if var_380_1 < arg_377_1.time_ and arg_377_1.time_ <= var_380_1 + arg_380_0 then
				arg_377_1.var_.moveOldPos1284ui_story = var_380_0.localPosition
			end

			local var_380_2 = 0.001

			if var_380_1 <= arg_377_1.time_ and arg_377_1.time_ < var_380_1 + var_380_2 then
				local var_380_3 = (arg_377_1.time_ - var_380_1) / var_380_2
				local var_380_4 = Vector3.New(-0.7, -0.985, -6.22)

				var_380_0.localPosition = Vector3.Lerp(arg_377_1.var_.moveOldPos1284ui_story, var_380_4, var_380_3)

				local var_380_5 = manager.ui.mainCamera.transform.position - var_380_0.position

				var_380_0.forward = Vector3.New(var_380_5.x, var_380_5.y, var_380_5.z)

				local var_380_6 = var_380_0.localEulerAngles

				var_380_6.z = 0
				var_380_6.x = 0
				var_380_0.localEulerAngles = var_380_6
			end

			if arg_377_1.time_ >= var_380_1 + var_380_2 and arg_377_1.time_ < var_380_1 + var_380_2 + arg_380_0 then
				var_380_0.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_380_7 = manager.ui.mainCamera.transform.position - var_380_0.position

				var_380_0.forward = Vector3.New(var_380_7.x, var_380_7.y, var_380_7.z)

				local var_380_8 = var_380_0.localEulerAngles

				var_380_8.z = 0
				var_380_8.x = 0
				var_380_0.localEulerAngles = var_380_8
			end

			local var_380_9 = arg_377_1.actors_["1284ui_story"]
			local var_380_10 = 0

			if var_380_10 < arg_377_1.time_ and arg_377_1.time_ <= var_380_10 + arg_380_0 and not isNil(var_380_9) and arg_377_1.var_.characterEffect1284ui_story == nil then
				arg_377_1.var_.characterEffect1284ui_story = var_380_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_11 = 0.200000002980232

			if var_380_10 <= arg_377_1.time_ and arg_377_1.time_ < var_380_10 + var_380_11 and not isNil(var_380_9) then
				local var_380_12 = (arg_377_1.time_ - var_380_10) / var_380_11

				if arg_377_1.var_.characterEffect1284ui_story and not isNil(var_380_9) then
					arg_377_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= var_380_10 + var_380_11 and arg_377_1.time_ < var_380_10 + var_380_11 + arg_380_0 and not isNil(var_380_9) and arg_377_1.var_.characterEffect1284ui_story then
				arg_377_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_380_13 = 0

			if var_380_13 < arg_377_1.time_ and arg_377_1.time_ <= var_380_13 + arg_380_0 then
				arg_377_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_380_14 = 0

			if var_380_14 < arg_377_1.time_ and arg_377_1.time_ <= var_380_14 + arg_380_0 then
				arg_377_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_380_15 = 0
			local var_380_16 = 0.325

			if var_380_15 < arg_377_1.time_ and arg_377_1.time_ <= var_380_15 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				local var_380_17 = arg_377_1:FormatText(StoryNameCfg[6].name)

				arg_377_1.leftNameTxt_.text = var_380_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_18 = arg_377_1:GetWordFromCfg(322072090)
				local var_380_19 = arg_377_1:FormatText(var_380_18.content)

				arg_377_1.text_.text = var_380_19

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_20 = 13
				local var_380_21 = utf8.len(var_380_19)
				local var_380_22 = var_380_20 <= 0 and var_380_16 or var_380_16 * (var_380_21 / var_380_20)

				if var_380_22 > 0 and var_380_16 < var_380_22 then
					arg_377_1.talkMaxDuration = var_380_22

					if var_380_22 + var_380_15 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_22 + var_380_15
					end
				end

				arg_377_1.text_.text = var_380_19
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072090", "story_v_out_322072.awb") ~= 0 then
					local var_380_23 = manager.audio:GetVoiceLength("story_v_out_322072", "322072090", "story_v_out_322072.awb") / 1000

					if var_380_23 + var_380_15 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_23 + var_380_15
					end

					if var_380_18.prefab_name ~= "" and arg_377_1.actors_[var_380_18.prefab_name] ~= nil then
						local var_380_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_18.prefab_name].transform, "story_v_out_322072", "322072090", "story_v_out_322072.awb")

						arg_377_1:RecordAudio("322072090", var_380_24)
						arg_377_1:RecordAudio("322072090", var_380_24)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_322072", "322072090", "story_v_out_322072.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_322072", "322072090", "story_v_out_322072.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_25 = math.max(var_380_16, arg_377_1.talkMaxDuration)

			if var_380_15 <= arg_377_1.time_ and arg_377_1.time_ < var_380_15 + var_380_25 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_15) / var_380_25

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_15 + var_380_25 and arg_377_1.time_ < var_380_15 + var_380_25 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {
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

		arg_377_1:InitPlayNodeList()
	end,
	Play322072091 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 322072091
		arg_381_1.duration_ = 5.83

		local var_381_0 = {
			zh = 5.833,
			ja = 5.533
		}
		local var_381_1 = manager.audio:GetLocalizationFlag()

		if var_381_0[var_381_1] ~= nil then
			arg_381_1.duration_ = var_381_0[var_381_1]
		end

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play322072092(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			local var_384_0 = arg_381_1.actors_["1156ui_story"].transform
			local var_384_1 = 0

			if var_384_1 < arg_381_1.time_ and arg_381_1.time_ <= var_384_1 + arg_384_0 then
				arg_381_1.var_.moveOldPos1156ui_story = var_384_0.localPosition
			end

			local var_384_2 = 0.001

			if var_384_1 <= arg_381_1.time_ and arg_381_1.time_ < var_384_1 + var_384_2 then
				local var_384_3 = (arg_381_1.time_ - var_384_1) / var_384_2
				local var_384_4 = Vector3.New(0.9, -1.1, -6.18)

				var_384_0.localPosition = Vector3.Lerp(arg_381_1.var_.moveOldPos1156ui_story, var_384_4, var_384_3)

				local var_384_5 = manager.ui.mainCamera.transform.position - var_384_0.position

				var_384_0.forward = Vector3.New(var_384_5.x, var_384_5.y, var_384_5.z)

				local var_384_6 = var_384_0.localEulerAngles

				var_384_6.z = 0
				var_384_6.x = 0
				var_384_0.localEulerAngles = var_384_6
			end

			if arg_381_1.time_ >= var_384_1 + var_384_2 and arg_381_1.time_ < var_384_1 + var_384_2 + arg_384_0 then
				var_384_0.localPosition = Vector3.New(0.9, -1.1, -6.18)

				local var_384_7 = manager.ui.mainCamera.transform.position - var_384_0.position

				var_384_0.forward = Vector3.New(var_384_7.x, var_384_7.y, var_384_7.z)

				local var_384_8 = var_384_0.localEulerAngles

				var_384_8.z = 0
				var_384_8.x = 0
				var_384_0.localEulerAngles = var_384_8
			end

			local var_384_9 = arg_381_1.actors_["1156ui_story"]
			local var_384_10 = 0

			if var_384_10 < arg_381_1.time_ and arg_381_1.time_ <= var_384_10 + arg_384_0 and not isNil(var_384_9) and arg_381_1.var_.characterEffect1156ui_story == nil then
				arg_381_1.var_.characterEffect1156ui_story = var_384_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_11 = 0.200000002980232

			if var_384_10 <= arg_381_1.time_ and arg_381_1.time_ < var_384_10 + var_384_11 and not isNil(var_384_9) then
				local var_384_12 = (arg_381_1.time_ - var_384_10) / var_384_11

				if arg_381_1.var_.characterEffect1156ui_story and not isNil(var_384_9) then
					arg_381_1.var_.characterEffect1156ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= var_384_10 + var_384_11 and arg_381_1.time_ < var_384_10 + var_384_11 + arg_384_0 and not isNil(var_384_9) and arg_381_1.var_.characterEffect1156ui_story then
				arg_381_1.var_.characterEffect1156ui_story.fillFlat = false
			end

			local var_384_13 = arg_381_1.actors_["1284ui_story"]
			local var_384_14 = 0

			if var_384_14 < arg_381_1.time_ and arg_381_1.time_ <= var_384_14 + arg_384_0 and not isNil(var_384_13) and arg_381_1.var_.characterEffect1284ui_story == nil then
				arg_381_1.var_.characterEffect1284ui_story = var_384_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_15 = 0.200000002980232

			if var_384_14 <= arg_381_1.time_ and arg_381_1.time_ < var_384_14 + var_384_15 and not isNil(var_384_13) then
				local var_384_16 = (arg_381_1.time_ - var_384_14) / var_384_15

				if arg_381_1.var_.characterEffect1284ui_story and not isNil(var_384_13) then
					local var_384_17 = Mathf.Lerp(0, 0.5, var_384_16)

					arg_381_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_381_1.var_.characterEffect1284ui_story.fillRatio = var_384_17
				end
			end

			if arg_381_1.time_ >= var_384_14 + var_384_15 and arg_381_1.time_ < var_384_14 + var_384_15 + arg_384_0 and not isNil(var_384_13) and arg_381_1.var_.characterEffect1284ui_story then
				local var_384_18 = 0.5

				arg_381_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_381_1.var_.characterEffect1284ui_story.fillRatio = var_384_18
			end

			local var_384_19 = 0

			if var_384_19 < arg_381_1.time_ and arg_381_1.time_ <= var_384_19 + arg_384_0 then
				arg_381_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/story1156/story1156action/1156action1_1")
			end

			local var_384_20 = 0

			if var_384_20 < arg_381_1.time_ and arg_381_1.time_ <= var_384_20 + arg_384_0 then
				arg_381_1:PlayTimeline("1156ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_384_21 = 0
			local var_384_22 = 0.725

			if var_384_21 < arg_381_1.time_ and arg_381_1.time_ <= var_384_21 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				local var_384_23 = arg_381_1:FormatText(StoryNameCfg[605].name)

				arg_381_1.leftNameTxt_.text = var_384_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_24 = arg_381_1:GetWordFromCfg(322072091)
				local var_384_25 = arg_381_1:FormatText(var_384_24.content)

				arg_381_1.text_.text = var_384_25

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_26 = 29
				local var_384_27 = utf8.len(var_384_25)
				local var_384_28 = var_384_26 <= 0 and var_384_22 or var_384_22 * (var_384_27 / var_384_26)

				if var_384_28 > 0 and var_384_22 < var_384_28 then
					arg_381_1.talkMaxDuration = var_384_28

					if var_384_28 + var_384_21 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_28 + var_384_21
					end
				end

				arg_381_1.text_.text = var_384_25
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072091", "story_v_out_322072.awb") ~= 0 then
					local var_384_29 = manager.audio:GetVoiceLength("story_v_out_322072", "322072091", "story_v_out_322072.awb") / 1000

					if var_384_29 + var_384_21 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_29 + var_384_21
					end

					if var_384_24.prefab_name ~= "" and arg_381_1.actors_[var_384_24.prefab_name] ~= nil then
						local var_384_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_24.prefab_name].transform, "story_v_out_322072", "322072091", "story_v_out_322072.awb")

						arg_381_1:RecordAudio("322072091", var_384_30)
						arg_381_1:RecordAudio("322072091", var_384_30)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_322072", "322072091", "story_v_out_322072.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_322072", "322072091", "story_v_out_322072.awb")
				end

				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_31 = math.max(var_384_22, arg_381_1.talkMaxDuration)

			if var_384_21 <= arg_381_1.time_ and arg_381_1.time_ < var_384_21 + var_384_31 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_21) / var_384_31

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_21 + var_384_31 and arg_381_1.time_ < var_384_21 + var_384_31 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {
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

		arg_381_1:InitPlayNodeList()
	end,
	Play322072092 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 322072092
		arg_385_1.duration_ = 4.73

		local var_385_0 = {
			zh = 4.733,
			ja = 4.533
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
				arg_385_0:Play322072093(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = arg_385_1.actors_["404001ui_story"].transform
			local var_388_1 = 0

			if var_388_1 < arg_385_1.time_ and arg_385_1.time_ <= var_388_1 + arg_388_0 then
				arg_385_1.var_.moveOldPos404001ui_story = var_388_0.localPosition
			end

			local var_388_2 = 0.001

			if var_388_1 <= arg_385_1.time_ and arg_385_1.time_ < var_388_1 + var_388_2 then
				local var_388_3 = (arg_385_1.time_ - var_388_1) / var_388_2
				local var_388_4 = Vector3.New(0.8, -1.55, -5.5)

				var_388_0.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos404001ui_story, var_388_4, var_388_3)

				local var_388_5 = manager.ui.mainCamera.transform.position - var_388_0.position

				var_388_0.forward = Vector3.New(var_388_5.x, var_388_5.y, var_388_5.z)

				local var_388_6 = var_388_0.localEulerAngles

				var_388_6.z = 0
				var_388_6.x = 0
				var_388_0.localEulerAngles = var_388_6
			end

			if arg_385_1.time_ >= var_388_1 + var_388_2 and arg_385_1.time_ < var_388_1 + var_388_2 + arg_388_0 then
				var_388_0.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_388_7 = manager.ui.mainCamera.transform.position - var_388_0.position

				var_388_0.forward = Vector3.New(var_388_7.x, var_388_7.y, var_388_7.z)

				local var_388_8 = var_388_0.localEulerAngles

				var_388_8.z = 0
				var_388_8.x = 0
				var_388_0.localEulerAngles = var_388_8
			end

			local var_388_9 = arg_385_1.actors_["1156ui_story"].transform
			local var_388_10 = 0

			if var_388_10 < arg_385_1.time_ and arg_385_1.time_ <= var_388_10 + arg_388_0 then
				arg_385_1.var_.moveOldPos1156ui_story = var_388_9.localPosition
			end

			local var_388_11 = 0.001

			if var_388_10 <= arg_385_1.time_ and arg_385_1.time_ < var_388_10 + var_388_11 then
				local var_388_12 = (arg_385_1.time_ - var_388_10) / var_388_11
				local var_388_13 = Vector3.New(0, 100, 0)

				var_388_9.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1156ui_story, var_388_13, var_388_12)

				local var_388_14 = manager.ui.mainCamera.transform.position - var_388_9.position

				var_388_9.forward = Vector3.New(var_388_14.x, var_388_14.y, var_388_14.z)

				local var_388_15 = var_388_9.localEulerAngles

				var_388_15.z = 0
				var_388_15.x = 0
				var_388_9.localEulerAngles = var_388_15
			end

			if arg_385_1.time_ >= var_388_10 + var_388_11 and arg_385_1.time_ < var_388_10 + var_388_11 + arg_388_0 then
				var_388_9.localPosition = Vector3.New(0, 100, 0)

				local var_388_16 = manager.ui.mainCamera.transform.position - var_388_9.position

				var_388_9.forward = Vector3.New(var_388_16.x, var_388_16.y, var_388_16.z)

				local var_388_17 = var_388_9.localEulerAngles

				var_388_17.z = 0
				var_388_17.x = 0
				var_388_9.localEulerAngles = var_388_17
			end

			local var_388_18 = arg_385_1.actors_["404001ui_story"]
			local var_388_19 = 0

			if var_388_19 < arg_385_1.time_ and arg_385_1.time_ <= var_388_19 + arg_388_0 and not isNil(var_388_18) and arg_385_1.var_.characterEffect404001ui_story == nil then
				arg_385_1.var_.characterEffect404001ui_story = var_388_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_20 = 0.200000002980232

			if var_388_19 <= arg_385_1.time_ and arg_385_1.time_ < var_388_19 + var_388_20 and not isNil(var_388_18) then
				local var_388_21 = (arg_385_1.time_ - var_388_19) / var_388_20

				if arg_385_1.var_.characterEffect404001ui_story and not isNil(var_388_18) then
					arg_385_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= var_388_19 + var_388_20 and arg_385_1.time_ < var_388_19 + var_388_20 + arg_388_0 and not isNil(var_388_18) and arg_385_1.var_.characterEffect404001ui_story then
				arg_385_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_388_22 = arg_385_1.actors_["1156ui_story"]
			local var_388_23 = 0

			if var_388_23 < arg_385_1.time_ and arg_385_1.time_ <= var_388_23 + arg_388_0 and not isNil(var_388_22) and arg_385_1.var_.characterEffect1156ui_story == nil then
				arg_385_1.var_.characterEffect1156ui_story = var_388_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_24 = 0.200000002980232

			if var_388_23 <= arg_385_1.time_ and arg_385_1.time_ < var_388_23 + var_388_24 and not isNil(var_388_22) then
				local var_388_25 = (arg_385_1.time_ - var_388_23) / var_388_24

				if arg_385_1.var_.characterEffect1156ui_story and not isNil(var_388_22) then
					local var_388_26 = Mathf.Lerp(0, 0.5, var_388_25)

					arg_385_1.var_.characterEffect1156ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1156ui_story.fillRatio = var_388_26
				end
			end

			if arg_385_1.time_ >= var_388_23 + var_388_24 and arg_385_1.time_ < var_388_23 + var_388_24 + arg_388_0 and not isNil(var_388_22) and arg_385_1.var_.characterEffect1156ui_story then
				local var_388_27 = 0.5

				arg_385_1.var_.characterEffect1156ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1156ui_story.fillRatio = var_388_27
			end

			local var_388_28 = 0

			if var_388_28 < arg_385_1.time_ and arg_385_1.time_ <= var_388_28 + arg_388_0 then
				arg_385_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_1")
			end

			local var_388_29 = 0

			if var_388_29 < arg_385_1.time_ and arg_385_1.time_ <= var_388_29 + arg_388_0 then
				arg_385_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_388_30 = 0
			local var_388_31 = 0.675

			if var_388_30 < arg_385_1.time_ and arg_385_1.time_ <= var_388_30 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				local var_388_32 = arg_385_1:FormatText(StoryNameCfg[668].name)

				arg_385_1.leftNameTxt_.text = var_388_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_33 = arg_385_1:GetWordFromCfg(322072092)
				local var_388_34 = arg_385_1:FormatText(var_388_33.content)

				arg_385_1.text_.text = var_388_34

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_35 = 27
				local var_388_36 = utf8.len(var_388_34)
				local var_388_37 = var_388_35 <= 0 and var_388_31 or var_388_31 * (var_388_36 / var_388_35)

				if var_388_37 > 0 and var_388_31 < var_388_37 then
					arg_385_1.talkMaxDuration = var_388_37

					if var_388_37 + var_388_30 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_37 + var_388_30
					end
				end

				arg_385_1.text_.text = var_388_34
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072092", "story_v_out_322072.awb") ~= 0 then
					local var_388_38 = manager.audio:GetVoiceLength("story_v_out_322072", "322072092", "story_v_out_322072.awb") / 1000

					if var_388_38 + var_388_30 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_38 + var_388_30
					end

					if var_388_33.prefab_name ~= "" and arg_385_1.actors_[var_388_33.prefab_name] ~= nil then
						local var_388_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_33.prefab_name].transform, "story_v_out_322072", "322072092", "story_v_out_322072.awb")

						arg_385_1:RecordAudio("322072092", var_388_39)
						arg_385_1:RecordAudio("322072092", var_388_39)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_322072", "322072092", "story_v_out_322072.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_322072", "322072092", "story_v_out_322072.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_40 = math.max(var_388_31, arg_385_1.talkMaxDuration)

			if var_388_30 <= arg_385_1.time_ and arg_385_1.time_ < var_388_30 + var_388_40 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_30) / var_388_40

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_30 + var_388_40 and arg_385_1.time_ < var_388_30 + var_388_40 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
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
				actorName = "1156ui_story",
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
	Play322072093 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 322072093
		arg_389_1.duration_ = 5.6

		local var_389_0 = {
			zh = 4.766,
			ja = 5.6
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
				arg_389_0:Play322072094(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0

			if var_392_0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_0 + arg_392_0 then
				arg_389_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action4_2")
			end

			local var_392_1 = 0
			local var_392_2 = 0.55

			if var_392_1 < arg_389_1.time_ and arg_389_1.time_ <= var_392_1 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				local var_392_3 = arg_389_1:FormatText(StoryNameCfg[668].name)

				arg_389_1.leftNameTxt_.text = var_392_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_4 = arg_389_1:GetWordFromCfg(322072093)
				local var_392_5 = arg_389_1:FormatText(var_392_4.content)

				arg_389_1.text_.text = var_392_5

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_6 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072093", "story_v_out_322072.awb") ~= 0 then
					local var_392_9 = manager.audio:GetVoiceLength("story_v_out_322072", "322072093", "story_v_out_322072.awb") / 1000

					if var_392_9 + var_392_1 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_9 + var_392_1
					end

					if var_392_4.prefab_name ~= "" and arg_389_1.actors_[var_392_4.prefab_name] ~= nil then
						local var_392_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_4.prefab_name].transform, "story_v_out_322072", "322072093", "story_v_out_322072.awb")

						arg_389_1:RecordAudio("322072093", var_392_10)
						arg_389_1:RecordAudio("322072093", var_392_10)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_322072", "322072093", "story_v_out_322072.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_322072", "322072093", "story_v_out_322072.awb")
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
	Play322072094 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 322072094
		arg_393_1.duration_ = 4.27

		local var_393_0 = {
			zh = 3.533,
			ja = 4.266
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
				arg_393_0:Play322072095(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = arg_393_1.actors_["1284ui_story"].transform
			local var_396_1 = 0

			if var_396_1 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.var_.moveOldPos1284ui_story = var_396_0.localPosition

				local var_396_2 = "1284ui_story"

				arg_393_1:ShowWeapon(arg_393_1.var_[var_396_2 .. "Animator"].transform, false)
			end

			local var_396_3 = 0.001

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_3 then
				local var_396_4 = (arg_393_1.time_ - var_396_1) / var_396_3
				local var_396_5 = Vector3.New(-0.7, -0.985, -6.22)

				var_396_0.localPosition = Vector3.Lerp(arg_393_1.var_.moveOldPos1284ui_story, var_396_5, var_396_4)

				local var_396_6 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_6.x, var_396_6.y, var_396_6.z)

				local var_396_7 = var_396_0.localEulerAngles

				var_396_7.z = 0
				var_396_7.x = 0
				var_396_0.localEulerAngles = var_396_7
			end

			if arg_393_1.time_ >= var_396_1 + var_396_3 and arg_393_1.time_ < var_396_1 + var_396_3 + arg_396_0 then
				var_396_0.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_396_8 = manager.ui.mainCamera.transform.position - var_396_0.position

				var_396_0.forward = Vector3.New(var_396_8.x, var_396_8.y, var_396_8.z)

				local var_396_9 = var_396_0.localEulerAngles

				var_396_9.z = 0
				var_396_9.x = 0
				var_396_0.localEulerAngles = var_396_9
			end

			local var_396_10 = arg_393_1.actors_["1284ui_story"]
			local var_396_11 = 0

			if var_396_11 < arg_393_1.time_ and arg_393_1.time_ <= var_396_11 + arg_396_0 and not isNil(var_396_10) and arg_393_1.var_.characterEffect1284ui_story == nil then
				arg_393_1.var_.characterEffect1284ui_story = var_396_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_12 = 0.200000002980232

			if var_396_11 <= arg_393_1.time_ and arg_393_1.time_ < var_396_11 + var_396_12 and not isNil(var_396_10) then
				local var_396_13 = (arg_393_1.time_ - var_396_11) / var_396_12

				if arg_393_1.var_.characterEffect1284ui_story and not isNil(var_396_10) then
					arg_393_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_393_1.time_ >= var_396_11 + var_396_12 and arg_393_1.time_ < var_396_11 + var_396_12 + arg_396_0 and not isNil(var_396_10) and arg_393_1.var_.characterEffect1284ui_story then
				arg_393_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_396_14 = arg_393_1.actors_["404001ui_story"]
			local var_396_15 = 0

			if var_396_15 < arg_393_1.time_ and arg_393_1.time_ <= var_396_15 + arg_396_0 and not isNil(var_396_14) and arg_393_1.var_.characterEffect404001ui_story == nil then
				arg_393_1.var_.characterEffect404001ui_story = var_396_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_16 = 0.200000002980232

			if var_396_15 <= arg_393_1.time_ and arg_393_1.time_ < var_396_15 + var_396_16 and not isNil(var_396_14) then
				local var_396_17 = (arg_393_1.time_ - var_396_15) / var_396_16

				if arg_393_1.var_.characterEffect404001ui_story and not isNil(var_396_14) then
					local var_396_18 = Mathf.Lerp(0, 0.5, var_396_17)

					arg_393_1.var_.characterEffect404001ui_story.fillFlat = true
					arg_393_1.var_.characterEffect404001ui_story.fillRatio = var_396_18
				end
			end

			if arg_393_1.time_ >= var_396_15 + var_396_16 and arg_393_1.time_ < var_396_15 + var_396_16 + arg_396_0 and not isNil(var_396_14) and arg_393_1.var_.characterEffect404001ui_story then
				local var_396_19 = 0.5

				arg_393_1.var_.characterEffect404001ui_story.fillFlat = true
				arg_393_1.var_.characterEffect404001ui_story.fillRatio = var_396_19
			end

			local var_396_20 = 0

			if var_396_20 < arg_393_1.time_ and arg_393_1.time_ <= var_396_20 + arg_396_0 then
				arg_393_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			local var_396_21 = 0

			if var_396_21 < arg_393_1.time_ and arg_393_1.time_ <= var_396_21 + arg_396_0 then
				arg_393_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_396_22 = 0
			local var_396_23 = 0.35

			if var_396_22 < arg_393_1.time_ and arg_393_1.time_ <= var_396_22 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				local var_396_24 = arg_393_1:FormatText(StoryNameCfg[6].name)

				arg_393_1.leftNameTxt_.text = var_396_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_25 = arg_393_1:GetWordFromCfg(322072094)
				local var_396_26 = arg_393_1:FormatText(var_396_25.content)

				arg_393_1.text_.text = var_396_26

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_27 = 14
				local var_396_28 = utf8.len(var_396_26)
				local var_396_29 = var_396_27 <= 0 and var_396_23 or var_396_23 * (var_396_28 / var_396_27)

				if var_396_29 > 0 and var_396_23 < var_396_29 then
					arg_393_1.talkMaxDuration = var_396_29

					if var_396_29 + var_396_22 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_29 + var_396_22
					end
				end

				arg_393_1.text_.text = var_396_26
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072094", "story_v_out_322072.awb") ~= 0 then
					local var_396_30 = manager.audio:GetVoiceLength("story_v_out_322072", "322072094", "story_v_out_322072.awb") / 1000

					if var_396_30 + var_396_22 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_30 + var_396_22
					end

					if var_396_25.prefab_name ~= "" and arg_393_1.actors_[var_396_25.prefab_name] ~= nil then
						local var_396_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_25.prefab_name].transform, "story_v_out_322072", "322072094", "story_v_out_322072.awb")

						arg_393_1:RecordAudio("322072094", var_396_31)
						arg_393_1:RecordAudio("322072094", var_396_31)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_322072", "322072094", "story_v_out_322072.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_322072", "322072094", "story_v_out_322072.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_32 = math.max(var_396_23, arg_393_1.talkMaxDuration)

			if var_396_22 <= arg_393_1.time_ and arg_393_1.time_ < var_396_22 + var_396_32 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_22) / var_396_32

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_22 + var_396_32 and arg_393_1.time_ < var_396_22 + var_396_32 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {
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

		arg_393_1:InitPlayNodeList()
	end,
	Play322072095 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 322072095
		arg_397_1.duration_ = 9

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play322072096(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = "MS2202"

			if arg_397_1.bgs_[var_400_0] == nil then
				local var_400_1 = Object.Instantiate(arg_397_1.paintGo_)

				var_400_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_400_0)
				var_400_1.name = var_400_0
				var_400_1.transform.parent = arg_397_1.stage_.transform
				var_400_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_397_1.bgs_[var_400_0] = var_400_1
			end

			local var_400_2 = 2

			if var_400_2 < arg_397_1.time_ and arg_397_1.time_ <= var_400_2 + arg_400_0 then
				local var_400_3 = manager.ui.mainCamera.transform.localPosition
				local var_400_4 = Vector3.New(0, 0, 10) + Vector3.New(var_400_3.x, var_400_3.y, 0)
				local var_400_5 = arg_397_1.bgs_.MS2202

				var_400_5.transform.localPosition = var_400_4
				var_400_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_400_6 = var_400_5:GetComponent("SpriteRenderer")

				if var_400_6 and var_400_6.sprite then
					local var_400_7 = (var_400_5.transform.localPosition - var_400_3).z
					local var_400_8 = manager.ui.mainCameraCom_
					local var_400_9 = 2 * var_400_7 * Mathf.Tan(var_400_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_400_10 = var_400_9 * var_400_8.aspect
					local var_400_11 = var_400_6.sprite.bounds.size.x
					local var_400_12 = var_400_6.sprite.bounds.size.y
					local var_400_13 = var_400_10 / var_400_11
					local var_400_14 = var_400_9 / var_400_12
					local var_400_15 = var_400_14 < var_400_13 and var_400_13 or var_400_14

					var_400_5.transform.localScale = Vector3.New(var_400_15, var_400_15, 0)
				end

				for iter_400_0, iter_400_1 in pairs(arg_397_1.bgs_) do
					if iter_400_0 ~= "MS2202" then
						iter_400_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_400_16 = 4

			if var_400_16 < arg_397_1.time_ and arg_397_1.time_ <= var_400_16 + arg_400_0 then
				arg_397_1.allBtn_.enabled = false
			end

			local var_400_17 = 0.3

			if arg_397_1.time_ >= var_400_16 + var_400_17 and arg_397_1.time_ < var_400_16 + var_400_17 + arg_400_0 then
				arg_397_1.allBtn_.enabled = true
			end

			local var_400_18 = 0

			if var_400_18 < arg_397_1.time_ and arg_397_1.time_ <= var_400_18 + arg_400_0 then
				arg_397_1.mask_.enabled = true
				arg_397_1.mask_.raycastTarget = true

				arg_397_1:SetGaussion(false)
			end

			local var_400_19 = 2

			if var_400_18 <= arg_397_1.time_ and arg_397_1.time_ < var_400_18 + var_400_19 then
				local var_400_20 = (arg_397_1.time_ - var_400_18) / var_400_19
				local var_400_21 = Color.New(0, 0, 0)

				var_400_21.a = Mathf.Lerp(0, 1, var_400_20)
				arg_397_1.mask_.color = var_400_21
			end

			if arg_397_1.time_ >= var_400_18 + var_400_19 and arg_397_1.time_ < var_400_18 + var_400_19 + arg_400_0 then
				local var_400_22 = Color.New(0, 0, 0)

				var_400_22.a = 1
				arg_397_1.mask_.color = var_400_22
			end

			local var_400_23 = 2

			if var_400_23 < arg_397_1.time_ and arg_397_1.time_ <= var_400_23 + arg_400_0 then
				arg_397_1.mask_.enabled = true
				arg_397_1.mask_.raycastTarget = true

				arg_397_1:SetGaussion(false)
			end

			local var_400_24 = 2

			if var_400_23 <= arg_397_1.time_ and arg_397_1.time_ < var_400_23 + var_400_24 then
				local var_400_25 = (arg_397_1.time_ - var_400_23) / var_400_24
				local var_400_26 = Color.New(0, 0, 0)

				var_400_26.a = Mathf.Lerp(1, 0, var_400_25)
				arg_397_1.mask_.color = var_400_26
			end

			if arg_397_1.time_ >= var_400_23 + var_400_24 and arg_397_1.time_ < var_400_23 + var_400_24 + arg_400_0 then
				local var_400_27 = Color.New(0, 0, 0)
				local var_400_28 = 0

				arg_397_1.mask_.enabled = false
				var_400_27.a = var_400_28
				arg_397_1.mask_.color = var_400_27
			end

			local var_400_29 = arg_397_1.actors_["1284ui_story"].transform
			local var_400_30 = 1.96599999815226

			if var_400_30 < arg_397_1.time_ and arg_397_1.time_ <= var_400_30 + arg_400_0 then
				arg_397_1.var_.moveOldPos1284ui_story = var_400_29.localPosition
			end

			local var_400_31 = 0.001

			if var_400_30 <= arg_397_1.time_ and arg_397_1.time_ < var_400_30 + var_400_31 then
				local var_400_32 = (arg_397_1.time_ - var_400_30) / var_400_31
				local var_400_33 = Vector3.New(0, 100, 0)

				var_400_29.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1284ui_story, var_400_33, var_400_32)

				local var_400_34 = manager.ui.mainCamera.transform.position - var_400_29.position

				var_400_29.forward = Vector3.New(var_400_34.x, var_400_34.y, var_400_34.z)

				local var_400_35 = var_400_29.localEulerAngles

				var_400_35.z = 0
				var_400_35.x = 0
				var_400_29.localEulerAngles = var_400_35
			end

			if arg_397_1.time_ >= var_400_30 + var_400_31 and arg_397_1.time_ < var_400_30 + var_400_31 + arg_400_0 then
				var_400_29.localPosition = Vector3.New(0, 100, 0)

				local var_400_36 = manager.ui.mainCamera.transform.position - var_400_29.position

				var_400_29.forward = Vector3.New(var_400_36.x, var_400_36.y, var_400_36.z)

				local var_400_37 = var_400_29.localEulerAngles

				var_400_37.z = 0
				var_400_37.x = 0
				var_400_29.localEulerAngles = var_400_37
			end

			local var_400_38 = arg_397_1.actors_["404001ui_story"].transform
			local var_400_39 = 1.96599999815226

			if var_400_39 < arg_397_1.time_ and arg_397_1.time_ <= var_400_39 + arg_400_0 then
				arg_397_1.var_.moveOldPos404001ui_story = var_400_38.localPosition
			end

			local var_400_40 = 0.001

			if var_400_39 <= arg_397_1.time_ and arg_397_1.time_ < var_400_39 + var_400_40 then
				local var_400_41 = (arg_397_1.time_ - var_400_39) / var_400_40
				local var_400_42 = Vector3.New(0, 100, 0)

				var_400_38.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos404001ui_story, var_400_42, var_400_41)

				local var_400_43 = manager.ui.mainCamera.transform.position - var_400_38.position

				var_400_38.forward = Vector3.New(var_400_43.x, var_400_43.y, var_400_43.z)

				local var_400_44 = var_400_38.localEulerAngles

				var_400_44.z = 0
				var_400_44.x = 0
				var_400_38.localEulerAngles = var_400_44
			end

			if arg_397_1.time_ >= var_400_39 + var_400_40 and arg_397_1.time_ < var_400_39 + var_400_40 + arg_400_0 then
				var_400_38.localPosition = Vector3.New(0, 100, 0)

				local var_400_45 = manager.ui.mainCamera.transform.position - var_400_38.position

				var_400_38.forward = Vector3.New(var_400_45.x, var_400_45.y, var_400_45.z)

				local var_400_46 = var_400_38.localEulerAngles

				var_400_46.z = 0
				var_400_46.x = 0
				var_400_38.localEulerAngles = var_400_46
			end

			local var_400_47 = 0.2
			local var_400_48 = 1

			if var_400_47 < arg_397_1.time_ and arg_397_1.time_ <= var_400_47 + arg_400_0 then
				local var_400_49 = "stop"
				local var_400_50 = "effect"

				arg_397_1:AudioAction(var_400_49, var_400_50, "se_story_145", "se_story_145_amb_battle_L17f", "")
			end

			local var_400_51 = 1.6
			local var_400_52 = 1

			if var_400_51 < arg_397_1.time_ and arg_397_1.time_ <= var_400_51 + arg_400_0 then
				local var_400_53 = "play"
				local var_400_54 = "effect"

				arg_397_1:AudioAction(var_400_53, var_400_54, "se_story_145", "se_story_145_amb_stone_l19f", "")
			end

			local var_400_55 = 4.2
			local var_400_56 = 1

			if var_400_55 < arg_397_1.time_ and arg_397_1.time_ <= var_400_55 + arg_400_0 then
				local var_400_57 = "play"
				local var_400_58 = "effect"

				arg_397_1:AudioAction(var_400_57, var_400_58, "se_story_145", "se_story_145_summon_energy", "")
			end

			if arg_397_1.frameCnt_ <= 1 then
				arg_397_1.dialog_:SetActive(false)
			end

			local var_400_59 = 4
			local var_400_60 = 1.625

			if var_400_59 < arg_397_1.time_ and arg_397_1.time_ <= var_400_59 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0

				arg_397_1.dialog_:SetActive(true)

				arg_397_1.dialogCg_.alpha = 0

				local var_400_61 = LeanTween.value(arg_397_1.dialog_, 0, 1, 0.3)

				var_400_61:setOnUpdate(LuaHelper.FloatAction(function(arg_401_0)
					arg_397_1.dialogCg_.alpha = arg_401_0
				end))
				var_400_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_397_1.dialog_)
					var_400_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_397_1.duration_ = arg_397_1.duration_ + 0.3

				SetActive(arg_397_1.leftNameGo_, false)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_62 = arg_397_1:GetWordFromCfg(322072095)
				local var_400_63 = arg_397_1:FormatText(var_400_62.content)

				arg_397_1.text_.text = var_400_63

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_64 = 65
				local var_400_65 = utf8.len(var_400_63)
				local var_400_66 = var_400_64 <= 0 and var_400_60 or var_400_60 * (var_400_65 / var_400_64)

				if var_400_66 > 0 and var_400_60 < var_400_66 then
					arg_397_1.talkMaxDuration = var_400_66
					var_400_59 = var_400_59 + 0.3

					if var_400_66 + var_400_59 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_66 + var_400_59
					end
				end

				arg_397_1.text_.text = var_400_63
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_67 = var_400_59 + 0.3
			local var_400_68 = math.max(var_400_60, arg_397_1.talkMaxDuration)

			if var_400_67 <= arg_397_1.time_ and arg_397_1.time_ < var_400_67 + var_400_68 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_67) / var_400_68

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_67 + var_400_68 and arg_397_1.time_ < var_400_67 + var_400_68 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "404001ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play322072096 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 322072096
		arg_403_1.duration_ = 5

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play322072097(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0
			local var_406_1 = 1.2

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, false)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_2 = arg_403_1:GetWordFromCfg(322072096)
				local var_406_3 = arg_403_1:FormatText(var_406_2.content)

				arg_403_1.text_.text = var_406_3

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_4 = 48
				local var_406_5 = utf8.len(var_406_3)
				local var_406_6 = var_406_4 <= 0 and var_406_1 or var_406_1 * (var_406_5 / var_406_4)

				if var_406_6 > 0 and var_406_1 < var_406_6 then
					arg_403_1.talkMaxDuration = var_406_6

					if var_406_6 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_6 + var_406_0
					end
				end

				arg_403_1.text_.text = var_406_3
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)
				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_7 = math.max(var_406_1, arg_403_1.talkMaxDuration)

			if var_406_0 <= arg_403_1.time_ and arg_403_1.time_ < var_406_0 + var_406_7 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_0) / var_406_7

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_0 + var_406_7 and arg_403_1.time_ < var_406_0 + var_406_7 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play322072097 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 322072097
		arg_407_1.duration_ = 5

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play322072098(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0.8
			local var_410_1 = 1

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				local var_410_2 = "play"
				local var_410_3 = "effect"

				arg_407_1:AudioAction(var_410_2, var_410_3, "se_story_141", "se_story_141_sword_aim", "")
			end

			local var_410_4 = 0
			local var_410_5 = 1.35

			if var_410_4 < arg_407_1.time_ and arg_407_1.time_ <= var_410_4 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, false)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_6 = arg_407_1:GetWordFromCfg(322072097)
				local var_410_7 = arg_407_1:FormatText(var_410_6.content)

				arg_407_1.text_.text = var_410_7

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_8 = 54
				local var_410_9 = utf8.len(var_410_7)
				local var_410_10 = var_410_8 <= 0 and var_410_5 or var_410_5 * (var_410_9 / var_410_8)

				if var_410_10 > 0 and var_410_5 < var_410_10 then
					arg_407_1.talkMaxDuration = var_410_10

					if var_410_10 + var_410_4 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_10 + var_410_4
					end
				end

				arg_407_1.text_.text = var_410_7
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)
				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_11 = math.max(var_410_5, arg_407_1.talkMaxDuration)

			if var_410_4 <= arg_407_1.time_ and arg_407_1.time_ < var_410_4 + var_410_11 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_4) / var_410_11

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_4 + var_410_11 and arg_407_1.time_ < var_410_4 + var_410_11 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play322072098 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 322072098
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play322072099(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0.6
			local var_414_1 = 1

			if var_414_0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				local var_414_2 = "play"
				local var_414_3 = "effect"

				arg_411_1:AudioAction(var_414_2, var_414_3, "se_story_121_04", "se_story_121_04_fireanergy1", "")
			end

			local var_414_4 = 0
			local var_414_5 = 1.35

			if var_414_4 < arg_411_1.time_ and arg_411_1.time_ <= var_414_4 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_6 = arg_411_1:GetWordFromCfg(322072098)
				local var_414_7 = arg_411_1:FormatText(var_414_6.content)

				arg_411_1.text_.text = var_414_7

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_8 = 54
				local var_414_9 = utf8.len(var_414_7)
				local var_414_10 = var_414_8 <= 0 and var_414_5 or var_414_5 * (var_414_9 / var_414_8)

				if var_414_10 > 0 and var_414_5 < var_414_10 then
					arg_411_1.talkMaxDuration = var_414_10

					if var_414_10 + var_414_4 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_10 + var_414_4
					end
				end

				arg_411_1.text_.text = var_414_7
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_11 = math.max(var_414_5, arg_411_1.talkMaxDuration)

			if var_414_4 <= arg_411_1.time_ and arg_411_1.time_ < var_414_4 + var_414_11 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_4) / var_414_11

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_4 + var_414_11 and arg_411_1.time_ < var_414_4 + var_414_11 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play322072099 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 322072099
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play322072100(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.1
			local var_418_1 = 1

			if var_418_0 < arg_415_1.time_ and arg_415_1.time_ <= var_418_0 + arg_418_0 then
				local var_418_2 = "play"
				local var_418_3 = "effect"

				arg_415_1:AudioAction(var_418_2, var_418_3, "se_story_145", "se_story_145_monster_scream03", "")
			end

			local var_418_4 = manager.ui.mainCamera.transform
			local var_418_5 = 0.1

			if var_418_5 < arg_415_1.time_ and arg_415_1.time_ <= var_418_5 + arg_418_0 then
				arg_415_1.var_.shakeOldPos = var_418_4.localPosition
			end

			local var_418_6 = 0.533333333333333

			if var_418_5 <= arg_415_1.time_ and arg_415_1.time_ < var_418_5 + var_418_6 then
				local var_418_7 = (arg_415_1.time_ - var_418_5) / 0.066
				local var_418_8, var_418_9 = math.modf(var_418_7)

				var_418_4.localPosition = Vector3.New(var_418_9 * 0.13, var_418_9 * 0.13, var_418_9 * 0.13) + arg_415_1.var_.shakeOldPos
			end

			if arg_415_1.time_ >= var_418_5 + var_418_6 and arg_415_1.time_ < var_418_5 + var_418_6 + arg_418_0 then
				var_418_4.localPosition = arg_415_1.var_.shakeOldPos
			end

			local var_418_10 = 0
			local var_418_11 = 0.075

			if var_418_10 < arg_415_1.time_ and arg_415_1.time_ <= var_418_10 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_12 = arg_415_1:FormatText(StoryNameCfg[1363].name)

				arg_415_1.leftNameTxt_.text = var_418_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4052")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_13 = arg_415_1:GetWordFromCfg(322072099)
				local var_418_14 = arg_415_1:FormatText(var_418_13.content)

				arg_415_1.text_.text = var_418_14

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_15 = 3
				local var_418_16 = utf8.len(var_418_14)
				local var_418_17 = var_418_15 <= 0 and var_418_11 or var_418_11 * (var_418_16 / var_418_15)

				if var_418_17 > 0 and var_418_11 < var_418_17 then
					arg_415_1.talkMaxDuration = var_418_17

					if var_418_17 + var_418_10 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_17 + var_418_10
					end
				end

				arg_415_1.text_.text = var_418_14
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_18 = math.max(var_418_11, arg_415_1.talkMaxDuration)

			if var_418_10 <= arg_415_1.time_ and arg_415_1.time_ < var_418_10 + var_418_18 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_10) / var_418_18

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_10 + var_418_18 and arg_415_1.time_ < var_418_10 + var_418_18 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play322072100 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 322072100
		arg_419_1.duration_ = 3.8

		local var_419_0 = {
			zh = 3.5,
			ja = 3.8
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play322072101(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0
			local var_422_1 = 0.2

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_2 = arg_419_1:FormatText(StoryNameCfg[1361].name)

				arg_419_1.leftNameTxt_.text = var_422_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, true)
				arg_419_1.iconController_:SetSelectedState("hero")

				arg_419_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3055")

				arg_419_1.callingController_:SetSelectedState("normal")

				arg_419_1.keyicon_.color = Color.New(1, 1, 1)
				arg_419_1.icon_.color = Color.New(1, 1, 1)

				local var_422_3 = arg_419_1:GetWordFromCfg(322072100)
				local var_422_4 = arg_419_1:FormatText(var_422_3.content)

				arg_419_1.text_.text = var_422_4

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 8
				local var_422_6 = utf8.len(var_422_4)
				local var_422_7 = var_422_5 <= 0 and var_422_1 or var_422_1 * (var_422_6 / var_422_5)

				if var_422_7 > 0 and var_422_1 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_4
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072100", "story_v_out_322072.awb") ~= 0 then
					local var_422_8 = manager.audio:GetVoiceLength("story_v_out_322072", "322072100", "story_v_out_322072.awb") / 1000

					if var_422_8 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_0
					end

					if var_422_3.prefab_name ~= "" and arg_419_1.actors_[var_422_3.prefab_name] ~= nil then
						local var_422_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_3.prefab_name].transform, "story_v_out_322072", "322072100", "story_v_out_322072.awb")

						arg_419_1:RecordAudio("322072100", var_422_9)
						arg_419_1:RecordAudio("322072100", var_422_9)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_322072", "322072100", "story_v_out_322072.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_322072", "322072100", "story_v_out_322072.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_10 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_10 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_10

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_10 and arg_419_1.time_ < var_422_0 + var_422_10 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play322072101 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 322072101
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play322072102(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 0.2
			local var_426_1 = 1

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				local var_426_2 = "play"
				local var_426_3 = "effect"

				arg_423_1:AudioAction(var_426_2, var_426_3, "se_story_122_03", "se_story_122_03_swordlight", "")
			end

			local var_426_4 = manager.ui.mainCamera.transform
			local var_426_5 = 0.6

			if var_426_5 < arg_423_1.time_ and arg_423_1.time_ <= var_426_5 + arg_426_0 then
				local var_426_6 = arg_423_1.var_.effect72101
				local var_426_7
				local var_426_8 = var_426_4

				if not var_426_6 then
					var_426_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xdaoguang"), var_426_8)
					var_426_6.name = "72101"
					arg_423_1.var_.effect72101 = var_426_6
				else
					var_426_6.transform:SetParent(var_426_8)
				end

				var_426_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_426_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_426_9 = 0
			local var_426_10 = 1.45

			if var_426_9 < arg_423_1.time_ and arg_423_1.time_ <= var_426_9 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_11 = arg_423_1:GetWordFromCfg(322072101)
				local var_426_12 = arg_423_1:FormatText(var_426_11.content)

				arg_423_1.text_.text = var_426_12

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_13 = 58
				local var_426_14 = utf8.len(var_426_12)
				local var_426_15 = var_426_13 <= 0 and var_426_10 or var_426_10 * (var_426_14 / var_426_13)

				if var_426_15 > 0 and var_426_10 < var_426_15 then
					arg_423_1.talkMaxDuration = var_426_15

					if var_426_15 + var_426_9 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_15 + var_426_9
					end
				end

				arg_423_1.text_.text = var_426_12
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_16 = math.max(var_426_10, arg_423_1.talkMaxDuration)

			if var_426_9 <= arg_423_1.time_ and arg_423_1.time_ < var_426_9 + var_426_16 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_9) / var_426_16

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_9 + var_426_16 and arg_423_1.time_ < var_426_9 + var_426_16 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play322072102 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 322072102
		arg_427_1.duration_ = 5

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play322072103(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = 0
			local var_430_1 = 1.075

			if var_430_0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_0 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, false)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_2 = arg_427_1:GetWordFromCfg(322072102)
				local var_430_3 = arg_427_1:FormatText(var_430_2.content)

				arg_427_1.text_.text = var_430_3

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_4 = 43
				local var_430_5 = utf8.len(var_430_3)
				local var_430_6 = var_430_4 <= 0 and var_430_1 or var_430_1 * (var_430_5 / var_430_4)

				if var_430_6 > 0 and var_430_1 < var_430_6 then
					arg_427_1.talkMaxDuration = var_430_6

					if var_430_6 + var_430_0 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_6 + var_430_0
					end
				end

				arg_427_1.text_.text = var_430_3
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_7 = math.max(var_430_1, arg_427_1.talkMaxDuration)

			if var_430_0 <= arg_427_1.time_ and arg_427_1.time_ < var_430_0 + var_430_7 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_0) / var_430_7

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_0 + var_430_7 and arg_427_1.time_ < var_430_0 + var_430_7 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play322072103 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 322072103
		arg_431_1.duration_ = 5

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play322072104(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = 0.3
			local var_434_1 = 1

			if var_434_0 < arg_431_1.time_ and arg_431_1.time_ <= var_434_0 + arg_434_0 then
				local var_434_2 = "play"
				local var_434_3 = "effect"

				arg_431_1:AudioAction(var_434_2, var_434_3, "se_story_145", "se_story_145_ding", "")
			end

			local var_434_4 = 0
			local var_434_5 = 1.125

			if var_434_4 < arg_431_1.time_ and arg_431_1.time_ <= var_434_4 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, false)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_431_1.iconTrs_.gameObject, false)
				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_6 = arg_431_1:GetWordFromCfg(322072103)
				local var_434_7 = arg_431_1:FormatText(var_434_6.content)

				arg_431_1.text_.text = var_434_7

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_8 = 45
				local var_434_9 = utf8.len(var_434_7)
				local var_434_10 = var_434_8 <= 0 and var_434_5 or var_434_5 * (var_434_9 / var_434_8)

				if var_434_10 > 0 and var_434_5 < var_434_10 then
					arg_431_1.talkMaxDuration = var_434_10

					if var_434_10 + var_434_4 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_10 + var_434_4
					end
				end

				arg_431_1.text_.text = var_434_7
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)
				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_11 = math.max(var_434_5, arg_431_1.talkMaxDuration)

			if var_434_4 <= arg_431_1.time_ and arg_431_1.time_ < var_434_4 + var_434_11 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_4) / var_434_11

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_4 + var_434_11 and arg_431_1.time_ < var_434_4 + var_434_11 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end

		arg_431_1.nodeConfigList_ = {}

		arg_431_1:InitPlayNodeList()
	end,
	Play322072104 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 322072104
		arg_435_1.duration_ = 3

		local var_435_0 = {
			zh = 2.266,
			ja = 3
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play322072105(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0
			local var_438_1 = 0.2

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_2 = arg_435_1:FormatText(StoryNameCfg[612].name)

				arg_435_1.leftNameTxt_.text = var_438_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1061_split_1")

				arg_435_1.callingController_:SetSelectedState("calling")

				arg_435_1.keyicon_.color = Color.New(1, 1, 1)
				arg_435_1.icon_.color = Color.New(1, 1, 1)

				local var_438_3 = arg_435_1:GetWordFromCfg(322072104)
				local var_438_4 = arg_435_1:FormatText(var_438_3.content)

				arg_435_1.text_.text = var_438_4

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 8
				local var_438_6 = utf8.len(var_438_4)
				local var_438_7 = var_438_5 <= 0 and var_438_1 or var_438_1 * (var_438_6 / var_438_5)

				if var_438_7 > 0 and var_438_1 < var_438_7 then
					arg_435_1.talkMaxDuration = var_438_7

					if var_438_7 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_7 + var_438_0
					end
				end

				arg_435_1.text_.text = var_438_4
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072104", "story_v_out_322072.awb") ~= 0 then
					local var_438_8 = manager.audio:GetVoiceLength("story_v_out_322072", "322072104", "story_v_out_322072.awb") / 1000

					if var_438_8 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_8 + var_438_0
					end

					if var_438_3.prefab_name ~= "" and arg_435_1.actors_[var_438_3.prefab_name] ~= nil then
						local var_438_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_3.prefab_name].transform, "story_v_out_322072", "322072104", "story_v_out_322072.awb")

						arg_435_1:RecordAudio("322072104", var_438_9)
						arg_435_1:RecordAudio("322072104", var_438_9)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_322072", "322072104", "story_v_out_322072.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_322072", "322072104", "story_v_out_322072.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_10 = math.max(var_438_1, arg_435_1.talkMaxDuration)

			if var_438_0 <= arg_435_1.time_ and arg_435_1.time_ < var_438_0 + var_438_10 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_0) / var_438_10

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_0 + var_438_10 and arg_435_1.time_ < var_438_0 + var_438_10 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end

		arg_435_1.nodeConfigList_ = {}

		arg_435_1:InitPlayNodeList()
	end,
	Play322072105 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 322072105
		arg_439_1.duration_ = 7

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play322072106(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = "1061ui_story"

			if arg_439_1.actors_[var_442_0] == nil then
				local var_442_1 = Asset.Load("Char/" .. "1061ui_story")

				if not isNil(var_442_1) then
					local var_442_2 = Object.Instantiate(Asset.Load("Char/" .. "1061ui_story"), arg_439_1.stage_.transform)

					var_442_2.name = var_442_0
					var_442_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_439_1.actors_[var_442_0] = var_442_2

					local var_442_3 = var_442_2:GetComponentInChildren(typeof(CharacterEffect))

					var_442_3.enabled = true

					local var_442_4 = GameObjectTools.GetOrAddComponent(var_442_2, typeof(DynamicBoneHelper))

					if var_442_4 then
						var_442_4:EnableDynamicBone(false)
					end

					arg_439_1:ShowWeapon(var_442_3.transform, false)

					arg_439_1.var_[var_442_0 .. "Animator"] = var_442_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_439_1.var_[var_442_0 .. "Animator"].applyRootMotion = true
					arg_439_1.var_[var_442_0 .. "LipSync"] = var_442_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_442_5 = arg_439_1.actors_["1061ui_story"].transform
			local var_442_6 = 0

			if var_442_6 < arg_439_1.time_ and arg_439_1.time_ <= var_442_6 + arg_442_0 then
				arg_439_1.var_.moveOldPos1061ui_story = var_442_5.localPosition
			end

			local var_442_7 = 0.001

			if var_442_6 <= arg_439_1.time_ and arg_439_1.time_ < var_442_6 + var_442_7 then
				local var_442_8 = (arg_439_1.time_ - var_442_6) / var_442_7
				local var_442_9 = Vector3.New(0, 100, 0)

				var_442_5.localPosition = Vector3.Lerp(arg_439_1.var_.moveOldPos1061ui_story, var_442_9, var_442_8)

				local var_442_10 = manager.ui.mainCamera.transform.position - var_442_5.position

				var_442_5.forward = Vector3.New(var_442_10.x, var_442_10.y, var_442_10.z)

				local var_442_11 = var_442_5.localEulerAngles

				var_442_11.z = 0
				var_442_11.x = 0
				var_442_5.localEulerAngles = var_442_11
			end

			if arg_439_1.time_ >= var_442_6 + var_442_7 and arg_439_1.time_ < var_442_6 + var_442_7 + arg_442_0 then
				var_442_5.localPosition = Vector3.New(0, 100, 0)

				local var_442_12 = manager.ui.mainCamera.transform.position - var_442_5.position

				var_442_5.forward = Vector3.New(var_442_12.x, var_442_12.y, var_442_12.z)

				local var_442_13 = var_442_5.localEulerAngles

				var_442_13.z = 0
				var_442_13.x = 0
				var_442_5.localEulerAngles = var_442_13
			end

			local var_442_14 = arg_439_1.actors_["1061ui_story"]
			local var_442_15 = 0

			if var_442_15 < arg_439_1.time_ and arg_439_1.time_ <= var_442_15 + arg_442_0 and not isNil(var_442_14) and arg_439_1.var_.characterEffect1061ui_story == nil then
				arg_439_1.var_.characterEffect1061ui_story = var_442_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_442_16 = 0.200000002980232

			if var_442_15 <= arg_439_1.time_ and arg_439_1.time_ < var_442_15 + var_442_16 and not isNil(var_442_14) then
				local var_442_17 = (arg_439_1.time_ - var_442_15) / var_442_16

				if arg_439_1.var_.characterEffect1061ui_story and not isNil(var_442_14) then
					local var_442_18 = Mathf.Lerp(0, 0.5, var_442_17)

					arg_439_1.var_.characterEffect1061ui_story.fillFlat = true
					arg_439_1.var_.characterEffect1061ui_story.fillRatio = var_442_18
				end
			end

			if arg_439_1.time_ >= var_442_15 + var_442_16 and arg_439_1.time_ < var_442_15 + var_442_16 + arg_442_0 and not isNil(var_442_14) and arg_439_1.var_.characterEffect1061ui_story then
				local var_442_19 = 0.5

				arg_439_1.var_.characterEffect1061ui_story.fillFlat = true
				arg_439_1.var_.characterEffect1061ui_story.fillRatio = var_442_19
			end

			local var_442_20 = 0.200000002980232
			local var_442_21 = 1

			if var_442_20 < arg_439_1.time_ and arg_439_1.time_ <= var_442_20 + arg_442_0 then
				local var_442_22 = "play"
				local var_442_23 = "effect"

				arg_439_1:AudioAction(var_442_22, var_442_23, "se_story_140", "se_story_140_explosion04", "")
			end

			local var_442_24 = manager.ui.mainCamera.transform
			local var_442_25 = 0.366666666666667

			if var_442_25 < arg_439_1.time_ and arg_439_1.time_ <= var_442_25 + arg_442_0 then
				local var_442_26 = arg_439_1.var_.effect2105
				local var_442_27
				local var_442_28 = var_442_24

				if not var_442_26 then
					var_442_26 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boom"), var_442_28)
					var_442_26.name = "2105"
					arg_439_1.var_.effect2105 = var_442_26
				else
					var_442_26.transform:SetParent(var_442_28)
				end

				var_442_26.transform.localPosition = Vector3.New(0, 0, -2.64)
				var_442_26.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_442_29 = manager.ui.mainCameraCom_
				local var_442_30 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_442_29.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_442_31 = var_442_26.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_442_32 = 15
				local var_442_33 = 2 * var_442_32 * Mathf.Tan(var_442_29.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_442_29.aspect
				local var_442_34 = 1
				local var_442_35 = 1.7777777777777777

				if var_442_35 < var_442_29.aspect then
					var_442_34 = var_442_33 / (2 * var_442_32 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_442_35)
				end

				for iter_442_0, iter_442_1 in ipairs(var_442_31) do
					local var_442_36 = iter_442_1.transform.localScale

					iter_442_1.transform.localScale = Vector3.New(var_442_36.x / var_442_30 * var_442_34, var_442_36.y / var_442_30, var_442_36.z)
				end
			end

			local var_442_37 = manager.ui.mainCamera.transform
			local var_442_38 = 3.525

			if var_442_38 < arg_439_1.time_ and arg_439_1.time_ <= var_442_38 + arg_442_0 then
				local var_442_39 = arg_439_1.var_.effect2105

				if var_442_39 then
					Object.Destroy(var_442_39)

					arg_439_1.var_.effect2105 = nil
				end
			end

			local var_442_40 = manager.ui.mainCamera.transform
			local var_442_41 = 0.366666666666667

			if var_442_41 < arg_439_1.time_ and arg_439_1.time_ <= var_442_41 + arg_442_0 then
				local var_442_42 = arg_439_1.var_.effect21051
				local var_442_43
				local var_442_44 = var_442_40

				if not var_442_42 then
					var_442_42 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), var_442_44)
					var_442_42.name = "21051"
					arg_439_1.var_.effect21051 = var_442_42
				else
					var_442_42.transform:SetParent(var_442_44)
				end

				var_442_42.transform.localPosition = Vector3.New(0, 0, -10)
				var_442_42.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_442_45 = manager.ui.mainCameraCom_
				local var_442_46 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_442_45.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_442_47 = var_442_42.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_442_48 = 15
				local var_442_49 = 2 * var_442_48 * Mathf.Tan(var_442_45.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_442_45.aspect
				local var_442_50 = 1
				local var_442_51 = 1.7777777777777777

				if var_442_51 < var_442_45.aspect then
					var_442_50 = var_442_49 / (2 * var_442_48 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_442_51)
				end

				for iter_442_2, iter_442_3 in ipairs(var_442_47) do
					local var_442_52 = iter_442_3.transform.localScale

					iter_442_3.transform.localScale = Vector3.New(var_442_52.x / var_442_46 * var_442_50, var_442_52.y / var_442_46, var_442_52.z)
				end
			end

			local var_442_53 = manager.ui.mainCamera.transform
			local var_442_54 = 3.53333333333333

			if var_442_54 < arg_439_1.time_ and arg_439_1.time_ <= var_442_54 + arg_442_0 then
				local var_442_55 = arg_439_1.var_.effect21051

				if var_442_55 then
					Object.Destroy(var_442_55)

					arg_439_1.var_.effect21051 = nil
				end
			end

			local var_442_56 = manager.ui.mainCamera.transform
			local var_442_57 = 0.366666666666667

			if var_442_57 < arg_439_1.time_ and arg_439_1.time_ <= var_442_57 + arg_442_0 then
				arg_439_1.var_.shakeOldPos = var_442_56.localPosition
			end

			local var_442_58 = 1.8

			if var_442_57 <= arg_439_1.time_ and arg_439_1.time_ < var_442_57 + var_442_58 then
				local var_442_59 = (arg_439_1.time_ - var_442_57) / 0.066
				local var_442_60, var_442_61 = math.modf(var_442_59)

				var_442_56.localPosition = Vector3.New(var_442_61 * 0.13, var_442_61 * 0.13, var_442_61 * 0.13) + arg_439_1.var_.shakeOldPos
			end

			if arg_439_1.time_ >= var_442_57 + var_442_58 and arg_439_1.time_ < var_442_57 + var_442_58 + arg_442_0 then
				var_442_56.localPosition = arg_439_1.var_.shakeOldPos
			end

			if arg_439_1.frameCnt_ <= 1 then
				arg_439_1.dialog_:SetActive(false)
			end

			local var_442_62 = 2
			local var_442_63 = 1.525

			if var_442_62 < arg_439_1.time_ and arg_439_1.time_ <= var_442_62 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0

				arg_439_1.dialog_:SetActive(true)

				arg_439_1.dialogCg_.alpha = 0

				local var_442_64 = LeanTween.value(arg_439_1.dialog_, 0, 1, 0.3)

				var_442_64:setOnUpdate(LuaHelper.FloatAction(function(arg_443_0)
					arg_439_1.dialogCg_.alpha = arg_443_0
				end))
				var_442_64:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_439_1.dialog_)
					var_442_64:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_439_1.duration_ = arg_439_1.duration_ + 0.3

				SetActive(arg_439_1.leftNameGo_, false)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_439_1.iconTrs_.gameObject, false)
				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_65 = arg_439_1:GetWordFromCfg(322072105)
				local var_442_66 = arg_439_1:FormatText(var_442_65.content)

				arg_439_1.text_.text = var_442_66

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_67 = 61
				local var_442_68 = utf8.len(var_442_66)
				local var_442_69 = var_442_67 <= 0 and var_442_63 or var_442_63 * (var_442_68 / var_442_67)

				if var_442_69 > 0 and var_442_63 < var_442_69 then
					arg_439_1.talkMaxDuration = var_442_69
					var_442_62 = var_442_62 + 0.3

					if var_442_69 + var_442_62 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_69 + var_442_62
					end
				end

				arg_439_1.text_.text = var_442_66
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)
				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_70 = var_442_62 + 0.3
			local var_442_71 = math.max(var_442_63, arg_439_1.talkMaxDuration)

			if var_442_70 <= arg_439_1.time_ and arg_439_1.time_ < var_442_70 + var_442_71 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_70) / var_442_71

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_70 + var_442_71 and arg_439_1.time_ < var_442_70 + var_442_71 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end

		arg_439_1.nodeConfigList_ = {
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

		arg_439_1:InitPlayNodeList()
	end,
	Play322072106 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 322072106
		arg_445_1.duration_ = 5

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play322072107(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = manager.ui.mainCamera.transform
			local var_448_1 = 0

			if var_448_1 < arg_445_1.time_ and arg_445_1.time_ <= var_448_1 + arg_448_0 then
				local var_448_2 = arg_445_1.var_.effect2105

				if var_448_2 then
					Object.Destroy(var_448_2)

					arg_445_1.var_.effect2105 = nil
				end
			end

			local var_448_3 = 0
			local var_448_4 = 1.125

			if var_448_3 < arg_445_1.time_ and arg_445_1.time_ <= var_448_3 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, false)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_5 = arg_445_1:GetWordFromCfg(322072106)
				local var_448_6 = arg_445_1:FormatText(var_448_5.content)

				arg_445_1.text_.text = var_448_6

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_7 = 45
				local var_448_8 = utf8.len(var_448_6)
				local var_448_9 = var_448_7 <= 0 and var_448_4 or var_448_4 * (var_448_8 / var_448_7)

				if var_448_9 > 0 and var_448_4 < var_448_9 then
					arg_445_1.talkMaxDuration = var_448_9

					if var_448_9 + var_448_3 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_9 + var_448_3
					end
				end

				arg_445_1.text_.text = var_448_6
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)
				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_10 = math.max(var_448_4, arg_445_1.talkMaxDuration)

			if var_448_3 <= arg_445_1.time_ and arg_445_1.time_ < var_448_3 + var_448_10 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_3) / var_448_10

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_3 + var_448_10 and arg_445_1.time_ < var_448_3 + var_448_10 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play322072107 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 322072107
		arg_449_1.duration_ = 5

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play322072108(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0.1
			local var_452_1 = 1

			if var_452_0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_0 + arg_452_0 then
				local var_452_2 = "play"
				local var_452_3 = "effect"

				arg_449_1:AudioAction(var_452_2, var_452_3, "se_story_145", "se_story_145_monster_roar1", "")
			end

			local var_452_4 = manager.ui.mainCamera.transform
			local var_452_5 = 0.1

			if var_452_5 < arg_449_1.time_ and arg_449_1.time_ <= var_452_5 + arg_452_0 then
				arg_449_1.var_.shakeOldPos = var_452_4.localPosition
			end

			local var_452_6 = 0.6

			if var_452_5 <= arg_449_1.time_ and arg_449_1.time_ < var_452_5 + var_452_6 then
				local var_452_7 = (arg_449_1.time_ - var_452_5) / 0.066
				local var_452_8, var_452_9 = math.modf(var_452_7)

				var_452_4.localPosition = Vector3.New(var_452_9 * 0.13, var_452_9 * 0.13, var_452_9 * 0.13) + arg_449_1.var_.shakeOldPos
			end

			if arg_449_1.time_ >= var_452_5 + var_452_6 and arg_449_1.time_ < var_452_5 + var_452_6 + arg_452_0 then
				var_452_4.localPosition = arg_449_1.var_.shakeOldPos
			end

			local var_452_10 = 0
			local var_452_11 = 0.1

			if var_452_10 < arg_449_1.time_ and arg_449_1.time_ <= var_452_10 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				local var_452_12 = arg_449_1:FormatText(StoryNameCfg[1363].name)

				arg_449_1.leftNameTxt_.text = var_452_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, true)
				arg_449_1.iconController_:SetSelectedState("hero")

				arg_449_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4052")

				arg_449_1.callingController_:SetSelectedState("normal")

				arg_449_1.keyicon_.color = Color.New(1, 1, 1)
				arg_449_1.icon_.color = Color.New(1, 1, 1)

				local var_452_13 = arg_449_1:GetWordFromCfg(322072107)
				local var_452_14 = arg_449_1:FormatText(var_452_13.content)

				arg_449_1.text_.text = var_452_14

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_15 = 4
				local var_452_16 = utf8.len(var_452_14)
				local var_452_17 = var_452_15 <= 0 and var_452_11 or var_452_11 * (var_452_16 / var_452_15)

				if var_452_17 > 0 and var_452_11 < var_452_17 then
					arg_449_1.talkMaxDuration = var_452_17

					if var_452_17 + var_452_10 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_17 + var_452_10
					end
				end

				arg_449_1.text_.text = var_452_14
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)
				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_18 = math.max(var_452_11, arg_449_1.talkMaxDuration)

			if var_452_10 <= arg_449_1.time_ and arg_449_1.time_ < var_452_10 + var_452_18 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_10) / var_452_18

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_10 + var_452_18 and arg_449_1.time_ < var_452_10 + var_452_18 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play322072108 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 322072108
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play322072109(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = 0.233333333333333
			local var_456_1 = 1

			if var_456_0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_0 + arg_456_0 then
				local var_456_2 = "play"
				local var_456_3 = "effect"

				arg_453_1:AudioAction(var_456_2, var_456_3, "se_story_140", "se_story_140_scythe4", "")
			end

			local var_456_4 = manager.ui.mainCamera.transform
			local var_456_5 = 0.233333333333333

			if var_456_5 < arg_453_1.time_ and arg_453_1.time_ <= var_456_5 + arg_456_0 then
				local var_456_6 = arg_453_1.var_.effect2108
				local var_456_7
				local var_456_8 = var_456_4

				if not var_456_6 then
					var_456_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), var_456_8)
					var_456_6.name = "2108"
					arg_453_1.var_.effect2108 = var_456_6
				else
					var_456_6.transform:SetParent(var_456_8)
				end

				var_456_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_456_6.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_456_9 = manager.ui.mainCameraCom_
				local var_456_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_456_9.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_456_11 = var_456_6.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_456_12 = 15
				local var_456_13 = 2 * var_456_12 * Mathf.Tan(var_456_9.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_456_9.aspect
				local var_456_14 = 1
				local var_456_15 = 1.7777777777777777

				if var_456_15 < var_456_9.aspect then
					var_456_14 = var_456_13 / (2 * var_456_12 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_456_15)
				end

				for iter_456_0, iter_456_1 in ipairs(var_456_11) do
					local var_456_16 = iter_456_1.transform.localScale

					iter_456_1.transform.localScale = Vector3.New(var_456_16.x / var_456_10 * var_456_14, var_456_16.y / var_456_10, var_456_16.z)
				end
			end

			local var_456_17 = manager.ui.mainCamera.transform
			local var_456_18 = 1.43333333333333

			if var_456_18 < arg_453_1.time_ and arg_453_1.time_ <= var_456_18 + arg_456_0 then
				local var_456_19 = arg_453_1.var_.effect2108

				if var_456_19 then
					Object.Destroy(var_456_19)

					arg_453_1.var_.effect2108 = nil
				end
			end

			local var_456_20 = manager.ui.mainCamera.transform
			local var_456_21 = 0.233333333333333

			if var_456_21 < arg_453_1.time_ and arg_453_1.time_ <= var_456_21 + arg_456_0 then
				arg_453_1.var_.shakeOldPos = var_456_20.localPosition
			end

			local var_456_22 = 0.166666666666667

			if var_456_21 <= arg_453_1.time_ and arg_453_1.time_ < var_456_21 + var_456_22 then
				local var_456_23 = (arg_453_1.time_ - var_456_21) / 0.066
				local var_456_24, var_456_25 = math.modf(var_456_23)

				var_456_20.localPosition = Vector3.New(var_456_25 * 0.13, var_456_25 * 0.13, var_456_25 * 0.13) + arg_453_1.var_.shakeOldPos
			end

			if arg_453_1.time_ >= var_456_21 + var_456_22 and arg_453_1.time_ < var_456_21 + var_456_22 + arg_456_0 then
				var_456_20.localPosition = arg_453_1.var_.shakeOldPos
			end

			local var_456_26 = 0
			local var_456_27 = 1.75

			if var_456_26 < arg_453_1.time_ and arg_453_1.time_ <= var_456_26 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, false)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_28 = arg_453_1:GetWordFromCfg(322072108)
				local var_456_29 = arg_453_1:FormatText(var_456_28.content)

				arg_453_1.text_.text = var_456_29

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_30 = 70
				local var_456_31 = utf8.len(var_456_29)
				local var_456_32 = var_456_30 <= 0 and var_456_27 or var_456_27 * (var_456_31 / var_456_30)

				if var_456_32 > 0 and var_456_27 < var_456_32 then
					arg_453_1.talkMaxDuration = var_456_32

					if var_456_32 + var_456_26 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_32 + var_456_26
					end
				end

				arg_453_1.text_.text = var_456_29
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)
				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_33 = math.max(var_456_27, arg_453_1.talkMaxDuration)

			if var_456_26 <= arg_453_1.time_ and arg_453_1.time_ < var_456_26 + var_456_33 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_26) / var_456_33

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_26 + var_456_33 and arg_453_1.time_ < var_456_26 + var_456_33 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {}

		arg_453_1:InitPlayNodeList()
	end,
	Play322072109 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 322072109
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play322072110(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 0.166666666666667
			local var_460_1 = 1

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				local var_460_2 = "play"
				local var_460_3 = "effect"

				arg_457_1:AudioAction(var_460_2, var_460_3, "se_story_145", "se_story_145_drone_drop", "")
			end

			local var_460_4 = 0
			local var_460_5 = 1.1

			if var_460_4 < arg_457_1.time_ and arg_457_1.time_ <= var_460_4 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_6 = arg_457_1:GetWordFromCfg(322072109)
				local var_460_7 = arg_457_1:FormatText(var_460_6.content)

				arg_457_1.text_.text = var_460_7

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_8 = 44
				local var_460_9 = utf8.len(var_460_7)
				local var_460_10 = var_460_8 <= 0 and var_460_5 or var_460_5 * (var_460_9 / var_460_8)

				if var_460_10 > 0 and var_460_5 < var_460_10 then
					arg_457_1.talkMaxDuration = var_460_10

					if var_460_10 + var_460_4 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_10 + var_460_4
					end
				end

				arg_457_1.text_.text = var_460_7
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_11 = math.max(var_460_5, arg_457_1.talkMaxDuration)

			if var_460_4 <= arg_457_1.time_ and arg_457_1.time_ < var_460_4 + var_460_11 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_4) / var_460_11

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_4 + var_460_11 and arg_457_1.time_ < var_460_4 + var_460_11 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play322072110 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 322072110
		arg_461_1.duration_ = 6.97

		local var_461_0 = {
			zh = 6.166,
			ja = 6.966
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play322072111(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			local var_464_0 = 0
			local var_464_1 = 0.8

			if var_464_0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_0 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				local var_464_2 = arg_461_1:FormatText(StoryNameCfg[668].name)

				arg_461_1.leftNameTxt_.text = var_464_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, true)
				arg_461_1.iconController_:SetSelectedState("hero")

				arg_461_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4040")

				arg_461_1.callingController_:SetSelectedState("normal")

				arg_461_1.keyicon_.color = Color.New(1, 1, 1)
				arg_461_1.icon_.color = Color.New(1, 1, 1)

				local var_464_3 = arg_461_1:GetWordFromCfg(322072110)
				local var_464_4 = arg_461_1:FormatText(var_464_3.content)

				arg_461_1.text_.text = var_464_4

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_5 = 32
				local var_464_6 = utf8.len(var_464_4)
				local var_464_7 = var_464_5 <= 0 and var_464_1 or var_464_1 * (var_464_6 / var_464_5)

				if var_464_7 > 0 and var_464_1 < var_464_7 then
					arg_461_1.talkMaxDuration = var_464_7

					if var_464_7 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_7 + var_464_0
					end
				end

				arg_461_1.text_.text = var_464_4
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072110", "story_v_out_322072.awb") ~= 0 then
					local var_464_8 = manager.audio:GetVoiceLength("story_v_out_322072", "322072110", "story_v_out_322072.awb") / 1000

					if var_464_8 + var_464_0 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_8 + var_464_0
					end

					if var_464_3.prefab_name ~= "" and arg_461_1.actors_[var_464_3.prefab_name] ~= nil then
						local var_464_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_3.prefab_name].transform, "story_v_out_322072", "322072110", "story_v_out_322072.awb")

						arg_461_1:RecordAudio("322072110", var_464_9)
						arg_461_1:RecordAudio("322072110", var_464_9)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_322072", "322072110", "story_v_out_322072.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_322072", "322072110", "story_v_out_322072.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_10 = math.max(var_464_1, arg_461_1.talkMaxDuration)

			if var_464_0 <= arg_461_1.time_ and arg_461_1.time_ < var_464_0 + var_464_10 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_0) / var_464_10

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_0 + var_464_10 and arg_461_1.time_ < var_464_0 + var_464_10 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {}

		arg_461_1:InitPlayNodeList()
	end,
	Play322072111 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 322072111
		arg_465_1.duration_ = 4.8

		local var_465_0 = {
			zh = 3.2,
			ja = 4.8
		}
		local var_465_1 = manager.audio:GetLocalizationFlag()

		if var_465_0[var_465_1] ~= nil then
			arg_465_1.duration_ = var_465_0[var_465_1]
		end

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play322072112(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0
			local var_468_1 = 0.4

			if var_468_0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_0 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, true)

				local var_468_2 = arg_465_1:FormatText(StoryNameCfg[37].name)

				arg_465_1.leftNameTxt_.text = var_468_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_465_1.leftNameTxt_.transform)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1.leftNameTxt_.text)
				SetActive(arg_465_1.iconTrs_.gameObject, true)
				arg_465_1.iconController_:SetSelectedState("hero")

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1211")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_3 = arg_465_1:GetWordFromCfg(322072111)
				local var_468_4 = arg_465_1:FormatText(var_468_3.content)

				arg_465_1.text_.text = var_468_4

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_5 = 16
				local var_468_6 = utf8.len(var_468_4)
				local var_468_7 = var_468_5 <= 0 and var_468_1 or var_468_1 * (var_468_6 / var_468_5)

				if var_468_7 > 0 and var_468_1 < var_468_7 then
					arg_465_1.talkMaxDuration = var_468_7

					if var_468_7 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_7 + var_468_0
					end
				end

				arg_465_1.text_.text = var_468_4
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072111", "story_v_out_322072.awb") ~= 0 then
					local var_468_8 = manager.audio:GetVoiceLength("story_v_out_322072", "322072111", "story_v_out_322072.awb") / 1000

					if var_468_8 + var_468_0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_8 + var_468_0
					end

					if var_468_3.prefab_name ~= "" and arg_465_1.actors_[var_468_3.prefab_name] ~= nil then
						local var_468_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_465_1.actors_[var_468_3.prefab_name].transform, "story_v_out_322072", "322072111", "story_v_out_322072.awb")

						arg_465_1:RecordAudio("322072111", var_468_9)
						arg_465_1:RecordAudio("322072111", var_468_9)
					else
						arg_465_1:AudioAction("play", "voice", "story_v_out_322072", "322072111", "story_v_out_322072.awb")
					end

					arg_465_1:RecordHistoryTalkVoice("story_v_out_322072", "322072111", "story_v_out_322072.awb")
				end

				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_10 = math.max(var_468_1, arg_465_1.talkMaxDuration)

			if var_468_0 <= arg_465_1.time_ and arg_465_1.time_ < var_468_0 + var_468_10 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_0) / var_468_10

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_0 + var_468_10 and arg_465_1.time_ < var_468_0 + var_468_10 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play322072112 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 322072112
		arg_469_1.duration_ = 5

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play322072113(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			local var_472_0 = "1211ui_story"

			if arg_469_1.actors_[var_472_0] == nil then
				local var_472_1 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_472_1) then
					local var_472_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_469_1.stage_.transform)

					var_472_2.name = var_472_0
					var_472_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_469_1.actors_[var_472_0] = var_472_2

					local var_472_3 = var_472_2:GetComponentInChildren(typeof(CharacterEffect))

					var_472_3.enabled = true

					local var_472_4 = GameObjectTools.GetOrAddComponent(var_472_2, typeof(DynamicBoneHelper))

					if var_472_4 then
						var_472_4:EnableDynamicBone(false)
					end

					arg_469_1:ShowWeapon(var_472_3.transform, false)

					arg_469_1.var_[var_472_0 .. "Animator"] = var_472_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_469_1.var_[var_472_0 .. "Animator"].applyRootMotion = true
					arg_469_1.var_[var_472_0 .. "LipSync"] = var_472_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_472_5 = arg_469_1.actors_["1211ui_story"].transform
			local var_472_6 = 0

			if var_472_6 < arg_469_1.time_ and arg_469_1.time_ <= var_472_6 + arg_472_0 then
				arg_469_1.var_.moveOldPos1211ui_story = var_472_5.localPosition
			end

			local var_472_7 = 0.001

			if var_472_6 <= arg_469_1.time_ and arg_469_1.time_ < var_472_6 + var_472_7 then
				local var_472_8 = (arg_469_1.time_ - var_472_6) / var_472_7
				local var_472_9 = Vector3.New(0, 100, 0)

				var_472_5.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos1211ui_story, var_472_9, var_472_8)

				local var_472_10 = manager.ui.mainCamera.transform.position - var_472_5.position

				var_472_5.forward = Vector3.New(var_472_10.x, var_472_10.y, var_472_10.z)

				local var_472_11 = var_472_5.localEulerAngles

				var_472_11.z = 0
				var_472_11.x = 0
				var_472_5.localEulerAngles = var_472_11
			end

			if arg_469_1.time_ >= var_472_6 + var_472_7 and arg_469_1.time_ < var_472_6 + var_472_7 + arg_472_0 then
				var_472_5.localPosition = Vector3.New(0, 100, 0)

				local var_472_12 = manager.ui.mainCamera.transform.position - var_472_5.position

				var_472_5.forward = Vector3.New(var_472_12.x, var_472_12.y, var_472_12.z)

				local var_472_13 = var_472_5.localEulerAngles

				var_472_13.z = 0
				var_472_13.x = 0
				var_472_5.localEulerAngles = var_472_13
			end

			local var_472_14 = arg_469_1.actors_["404001ui_story"].transform
			local var_472_15 = 0

			if var_472_15 < arg_469_1.time_ and arg_469_1.time_ <= var_472_15 + arg_472_0 then
				arg_469_1.var_.moveOldPos404001ui_story = var_472_14.localPosition
			end

			local var_472_16 = 0.001

			if var_472_15 <= arg_469_1.time_ and arg_469_1.time_ < var_472_15 + var_472_16 then
				local var_472_17 = (arg_469_1.time_ - var_472_15) / var_472_16
				local var_472_18 = Vector3.New(0, 100, 0)

				var_472_14.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos404001ui_story, var_472_18, var_472_17)

				local var_472_19 = manager.ui.mainCamera.transform.position - var_472_14.position

				var_472_14.forward = Vector3.New(var_472_19.x, var_472_19.y, var_472_19.z)

				local var_472_20 = var_472_14.localEulerAngles

				var_472_20.z = 0
				var_472_20.x = 0
				var_472_14.localEulerAngles = var_472_20
			end

			if arg_469_1.time_ >= var_472_15 + var_472_16 and arg_469_1.time_ < var_472_15 + var_472_16 + arg_472_0 then
				var_472_14.localPosition = Vector3.New(0, 100, 0)

				local var_472_21 = manager.ui.mainCamera.transform.position - var_472_14.position

				var_472_14.forward = Vector3.New(var_472_21.x, var_472_21.y, var_472_21.z)

				local var_472_22 = var_472_14.localEulerAngles

				var_472_22.z = 0
				var_472_22.x = 0
				var_472_14.localEulerAngles = var_472_22
			end

			local var_472_23 = arg_469_1.actors_["1211ui_story"]
			local var_472_24 = 0

			if var_472_24 < arg_469_1.time_ and arg_469_1.time_ <= var_472_24 + arg_472_0 and not isNil(var_472_23) and arg_469_1.var_.characterEffect1211ui_story == nil then
				arg_469_1.var_.characterEffect1211ui_story = var_472_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_25 = 0.200000002980232

			if var_472_24 <= arg_469_1.time_ and arg_469_1.time_ < var_472_24 + var_472_25 and not isNil(var_472_23) then
				local var_472_26 = (arg_469_1.time_ - var_472_24) / var_472_25

				if arg_469_1.var_.characterEffect1211ui_story and not isNil(var_472_23) then
					local var_472_27 = Mathf.Lerp(0, 0.5, var_472_26)

					arg_469_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_469_1.var_.characterEffect1211ui_story.fillRatio = var_472_27
				end
			end

			if arg_469_1.time_ >= var_472_24 + var_472_25 and arg_469_1.time_ < var_472_24 + var_472_25 + arg_472_0 and not isNil(var_472_23) and arg_469_1.var_.characterEffect1211ui_story then
				local var_472_28 = 0.5

				arg_469_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_469_1.var_.characterEffect1211ui_story.fillRatio = var_472_28
			end

			local var_472_29 = 0.566666666666667
			local var_472_30 = 1

			if var_472_29 < arg_469_1.time_ and arg_469_1.time_ <= var_472_29 + arg_472_0 then
				local var_472_31 = "play"
				local var_472_32 = "effect"

				arg_469_1:AudioAction(var_472_31, var_472_32, "se_story_145", "se_story_145_summon_stars", "")
			end

			local var_472_33 = 0
			local var_472_34 = 1.775

			if var_472_33 < arg_469_1.time_ and arg_469_1.time_ <= var_472_33 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, false)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_35 = arg_469_1:GetWordFromCfg(322072112)
				local var_472_36 = arg_469_1:FormatText(var_472_35.content)

				arg_469_1.text_.text = var_472_36

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_37 = 71
				local var_472_38 = utf8.len(var_472_36)
				local var_472_39 = var_472_37 <= 0 and var_472_34 or var_472_34 * (var_472_38 / var_472_37)

				if var_472_39 > 0 and var_472_34 < var_472_39 then
					arg_469_1.talkMaxDuration = var_472_39

					if var_472_39 + var_472_33 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_39 + var_472_33
					end
				end

				arg_469_1.text_.text = var_472_36
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)
				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_40 = math.max(var_472_34, arg_469_1.talkMaxDuration)

			if var_472_33 <= arg_469_1.time_ and arg_469_1.time_ < var_472_33 + var_472_40 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_33) / var_472_40

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_33 + var_472_40 and arg_469_1.time_ < var_472_33 + var_472_40 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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

		arg_469_1:InitPlayNodeList()
	end,
	Play322072113 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 322072113
		arg_473_1.duration_ = 5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play322072114(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0
			local var_476_1 = 1.275

			if var_476_0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, false)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_2 = arg_473_1:GetWordFromCfg(322072113)
				local var_476_3 = arg_473_1:FormatText(var_476_2.content)

				arg_473_1.text_.text = var_476_3

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_4 = 51
				local var_476_5 = utf8.len(var_476_3)
				local var_476_6 = var_476_4 <= 0 and var_476_1 or var_476_1 * (var_476_5 / var_476_4)

				if var_476_6 > 0 and var_476_1 < var_476_6 then
					arg_473_1.talkMaxDuration = var_476_6

					if var_476_6 + var_476_0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_6 + var_476_0
					end
				end

				arg_473_1.text_.text = var_476_3
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)
				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_1, arg_473_1.talkMaxDuration)

			if var_476_0 <= arg_473_1.time_ and arg_473_1.time_ < var_476_0 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_0) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_0 + var_476_7 and arg_473_1.time_ < var_476_0 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play322072114 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 322072114
		arg_477_1.duration_ = 2.27

		local var_477_0 = {
			zh = 1.9,
			ja = 2.266
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play322072115(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			local var_480_0 = 0
			local var_480_1 = 0.225

			if var_480_0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_0 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				local var_480_2 = arg_477_1:FormatText(StoryNameCfg[6].name)

				arg_477_1.leftNameTxt_.text = var_480_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, true)
				arg_477_1.iconController_:SetSelectedState("hero")

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_3 = arg_477_1:GetWordFromCfg(322072114)
				local var_480_4 = arg_477_1:FormatText(var_480_3.content)

				arg_477_1.text_.text = var_480_4

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_5 = 9
				local var_480_6 = utf8.len(var_480_4)
				local var_480_7 = var_480_5 <= 0 and var_480_1 or var_480_1 * (var_480_6 / var_480_5)

				if var_480_7 > 0 and var_480_1 < var_480_7 then
					arg_477_1.talkMaxDuration = var_480_7

					if var_480_7 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_7 + var_480_0
					end
				end

				arg_477_1.text_.text = var_480_4
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322072", "322072114", "story_v_out_322072.awb") ~= 0 then
					local var_480_8 = manager.audio:GetVoiceLength("story_v_out_322072", "322072114", "story_v_out_322072.awb") / 1000

					if var_480_8 + var_480_0 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_8 + var_480_0
					end

					if var_480_3.prefab_name ~= "" and arg_477_1.actors_[var_480_3.prefab_name] ~= nil then
						local var_480_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_3.prefab_name].transform, "story_v_out_322072", "322072114", "story_v_out_322072.awb")

						arg_477_1:RecordAudio("322072114", var_480_9)
						arg_477_1:RecordAudio("322072114", var_480_9)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_322072", "322072114", "story_v_out_322072.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_322072", "322072114", "story_v_out_322072.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_10 = math.max(var_480_1, arg_477_1.talkMaxDuration)

			if var_480_0 <= arg_477_1.time_ and arg_477_1.time_ < var_480_0 + var_480_10 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_0) / var_480_10

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_0 + var_480_10 and arg_477_1.time_ < var_480_0 + var_480_10 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {}

		arg_477_1:InitPlayNodeList()
	end,
	Play322072115 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 322072115
		arg_481_1.duration_ = 6.43

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play322072116(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = 0.433333333333333
			local var_484_1 = 1

			if var_484_0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_0 + arg_484_0 then
				local var_484_2 = "play"
				local var_484_3 = "effect"

				arg_481_1:AudioAction(var_484_2, var_484_3, "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_484_4 = manager.ui.mainCamera.transform
			local var_484_5 = 0

			if var_484_5 < arg_481_1.time_ and arg_481_1.time_ <= var_484_5 + arg_484_0 then
				local var_484_6 = arg_481_1.var_.effect2115
				local var_484_7
				local var_484_8 = var_484_4

				if not var_484_6 then
					var_484_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), var_484_8)
					var_484_6.name = "2115"
					arg_481_1.var_.effect2115 = var_484_6
				else
					var_484_6.transform:SetParent(var_484_8)
				end

				var_484_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_484_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_484_9 = manager.ui.mainCamera.transform
			local var_484_10 = 2.83333333333333

			if var_484_10 < arg_481_1.time_ and arg_481_1.time_ <= var_484_10 + arg_484_0 then
				local var_484_11 = arg_481_1.var_.effect2115

				if var_484_11 then
					Object.Destroy(var_484_11)

					arg_481_1.var_.effect2115 = nil
				end
			end

			if arg_481_1.frameCnt_ <= 1 then
				arg_481_1.dialog_:SetActive(false)
			end

			local var_484_12 = 1.43333333333333
			local var_484_13 = 0.175

			if var_484_12 < arg_481_1.time_ and arg_481_1.time_ <= var_484_12 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0

				arg_481_1.dialog_:SetActive(true)

				arg_481_1.dialogCg_.alpha = 0

				local var_484_14 = LeanTween.value(arg_481_1.dialog_, 0, 1, 0.3)

				var_484_14:setOnUpdate(LuaHelper.FloatAction(function(arg_485_0)
					arg_481_1.dialogCg_.alpha = arg_485_0
				end))
				var_484_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_481_1.dialog_)
					var_484_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_481_1.duration_ = arg_481_1.duration_ + 0.3

				SetActive(arg_481_1.leftNameGo_, false)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_15 = arg_481_1:GetWordFromCfg(322072115)
				local var_484_16 = arg_481_1:FormatText(var_484_15.content)

				arg_481_1.text_.text = var_484_16

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_17 = 7
				local var_484_18 = utf8.len(var_484_16)
				local var_484_19 = var_484_17 <= 0 and var_484_13 or var_484_13 * (var_484_18 / var_484_17)

				if var_484_19 > 0 and var_484_13 < var_484_19 then
					arg_481_1.talkMaxDuration = var_484_19
					var_484_12 = var_484_12 + 0.3

					if var_484_19 + var_484_12 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_19 + var_484_12
					end
				end

				arg_481_1.text_.text = var_484_16
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)
				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_20 = var_484_12 + 0.3
			local var_484_21 = math.max(var_484_13, arg_481_1.talkMaxDuration)

			if var_484_20 <= arg_481_1.time_ and arg_481_1.time_ < var_484_20 + var_484_21 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_20) / var_484_21

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_20 + var_484_21 and arg_481_1.time_ < var_484_20 + var_484_21 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {}

		arg_481_1:InitPlayNodeList()
	end,
	Play322072116 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 322072116
		arg_487_1.duration_ = 5

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play322072117(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = 0
			local var_490_1 = 1.025

			if var_490_0 < arg_487_1.time_ and arg_487_1.time_ <= var_490_0 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, false)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_2 = arg_487_1:GetWordFromCfg(322072116)
				local var_490_3 = arg_487_1:FormatText(var_490_2.content)

				arg_487_1.text_.text = var_490_3

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_4 = 41
				local var_490_5 = utf8.len(var_490_3)
				local var_490_6 = var_490_4 <= 0 and var_490_1 or var_490_1 * (var_490_5 / var_490_4)

				if var_490_6 > 0 and var_490_1 < var_490_6 then
					arg_487_1.talkMaxDuration = var_490_6

					if var_490_6 + var_490_0 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_6 + var_490_0
					end
				end

				arg_487_1.text_.text = var_490_3
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)
				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_7 = math.max(var_490_1, arg_487_1.talkMaxDuration)

			if var_490_0 <= arg_487_1.time_ and arg_487_1.time_ < var_490_0 + var_490_7 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_0) / var_490_7

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_0 + var_490_7 and arg_487_1.time_ < var_490_0 + var_490_7 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end

		arg_487_1.nodeConfigList_ = {}

		arg_487_1:InitPlayNodeList()
	end,
	Play322072117 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 322072117
		arg_491_1.duration_ = 5

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play322072118(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = 0
			local var_494_1 = 0.85

			if var_494_0 < arg_491_1.time_ and arg_491_1.time_ <= var_494_0 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, false)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_491_1.iconTrs_.gameObject, false)
				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_2 = arg_491_1:GetWordFromCfg(322072117)
				local var_494_3 = arg_491_1:FormatText(var_494_2.content)

				arg_491_1.text_.text = var_494_3

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_4 = 34
				local var_494_5 = utf8.len(var_494_3)
				local var_494_6 = var_494_4 <= 0 and var_494_1 or var_494_1 * (var_494_5 / var_494_4)

				if var_494_6 > 0 and var_494_1 < var_494_6 then
					arg_491_1.talkMaxDuration = var_494_6

					if var_494_6 + var_494_0 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_6 + var_494_0
					end
				end

				arg_491_1.text_.text = var_494_3
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)
				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_7 = math.max(var_494_1, arg_491_1.talkMaxDuration)

			if var_494_0 <= arg_491_1.time_ and arg_491_1.time_ < var_494_0 + var_494_7 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_0) / var_494_7

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_0 + var_494_7 and arg_491_1.time_ < var_494_0 + var_494_7 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end

		arg_491_1.nodeConfigList_ = {}

		arg_491_1:InitPlayNodeList()
	end,
	Play322072118 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 322072118
		arg_495_1.duration_ = 3.7

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play322072119(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = "STblack"

			if arg_495_1.bgs_[var_498_0] == nil then
				local var_498_1 = Object.Instantiate(arg_495_1.paintGo_)

				var_498_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_498_0)
				var_498_1.name = var_498_0
				var_498_1.transform.parent = arg_495_1.stage_.transform
				var_498_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_495_1.bgs_[var_498_0] = var_498_1
			end

			local var_498_2 = 1

			if var_498_2 < arg_495_1.time_ and arg_495_1.time_ <= var_498_2 + arg_498_0 then
				local var_498_3 = manager.ui.mainCamera.transform.localPosition
				local var_498_4 = Vector3.New(0, 0, 10) + Vector3.New(var_498_3.x, var_498_3.y, 0)
				local var_498_5 = arg_495_1.bgs_.STblack

				var_498_5.transform.localPosition = var_498_4
				var_498_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_498_6 = var_498_5:GetComponent("SpriteRenderer")

				if var_498_6 and var_498_6.sprite then
					local var_498_7 = (var_498_5.transform.localPosition - var_498_3).z
					local var_498_8 = manager.ui.mainCameraCom_
					local var_498_9 = 2 * var_498_7 * Mathf.Tan(var_498_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_498_10 = var_498_9 * var_498_8.aspect
					local var_498_11 = var_498_6.sprite.bounds.size.x
					local var_498_12 = var_498_6.sprite.bounds.size.y
					local var_498_13 = var_498_10 / var_498_11
					local var_498_14 = var_498_9 / var_498_12
					local var_498_15 = var_498_14 < var_498_13 and var_498_13 or var_498_14

					var_498_5.transform.localScale = Vector3.New(var_498_15, var_498_15, 0)
				end

				for iter_498_0, iter_498_1 in pairs(arg_495_1.bgs_) do
					if iter_498_0 ~= "STblack" then
						iter_498_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_498_16 = 1

			if var_498_16 < arg_495_1.time_ and arg_495_1.time_ <= var_498_16 + arg_498_0 then
				arg_495_1.allBtn_.enabled = false
			end

			local var_498_17 = 0.933333333332

			if arg_495_1.time_ >= var_498_16 + var_498_17 and arg_495_1.time_ < var_498_16 + var_498_17 + arg_498_0 then
				arg_495_1.allBtn_.enabled = true
			end

			local var_498_18 = 0

			if var_498_18 < arg_495_1.time_ and arg_495_1.time_ <= var_498_18 + arg_498_0 then
				arg_495_1.mask_.enabled = true
				arg_495_1.mask_.raycastTarget = true

				arg_495_1:SetGaussion(false)
			end

			local var_498_19 = 1

			if var_498_18 <= arg_495_1.time_ and arg_495_1.time_ < var_498_18 + var_498_19 then
				local var_498_20 = (arg_495_1.time_ - var_498_18) / var_498_19
				local var_498_21 = Color.New(1, 1, 1)

				var_498_21.a = Mathf.Lerp(1, 0, var_498_20)
				arg_495_1.mask_.color = var_498_21
			end

			if arg_495_1.time_ >= var_498_18 + var_498_19 and arg_495_1.time_ < var_498_18 + var_498_19 + arg_498_0 then
				local var_498_22 = Color.New(1, 1, 1)
				local var_498_23 = 0

				arg_495_1.mask_.enabled = false
				var_498_22.a = var_498_23
				arg_495_1.mask_.color = var_498_22
			end

			local var_498_24 = 0.1
			local var_498_25 = 1

			if var_498_24 < arg_495_1.time_ and arg_495_1.time_ <= var_498_24 + arg_498_0 then
				local var_498_26 = "play"
				local var_498_27 = "effect"

				arg_495_1:AudioAction(var_498_26, var_498_27, "se_story_1311", "se_story_1311_cannon", "")
			end

			local var_498_28 = 1
			local var_498_29 = 2.7
			local var_498_30 = manager.audio:GetVoiceLength("story_v_out_322072", "322072118", "story_v_out_322072.awb") / 1000

			if var_498_30 > 0 and var_498_29 < var_498_30 and var_498_30 + var_498_28 > arg_495_1.duration_ then
				local var_498_31 = var_498_30

				arg_495_1.duration_ = var_498_30 + var_498_28
			end

			if var_498_28 < arg_495_1.time_ and arg_495_1.time_ <= var_498_28 + arg_498_0 then
				local var_498_32 = "play"
				local var_498_33 = "voice"

				arg_495_1:AudioAction(var_498_32, var_498_33, "story_v_out_322072", "322072118", "story_v_out_322072.awb")
			end
		end

		arg_495_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322072118,
				charCount = 14,
				enableLayoutChange = true,
				duration = 0.933333333333333,
				groupID = "2118",
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
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			}
		}

		arg_495_1:InitPlayNodeList()
	end,
	Play322072119 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 322072119
		arg_499_1.duration_ = 1

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
			arg_499_1.auto_ = false
		end

		function arg_499_1.playNext_(arg_501_0)
			arg_499_1.onStoryFinished_()
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = 0

			if var_502_0 < arg_499_1.time_ and arg_499_1.time_ <= var_502_0 + arg_502_0 then
				local var_502_1 = arg_499_1.fswbg_.transform:Find("textbox/adapt/content") or arg_499_1.fswbg_.transform:Find("textbox/content")
				local var_502_2 = arg_499_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_502_3 = var_502_1:GetComponent("Text")
				local var_502_4 = var_502_1:GetComponent("RectTransform")

				var_502_3.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_502_4.offsetMin = Vector2.New(0, 0)
				var_502_4.offsetMax = Vector2.New(0, 0)
			end

			local var_502_5 = 0
			local var_502_6 = 1
			local var_502_7 = manager.audio:GetVoiceLength("story_v_out_322072", "322072119", "story_v_out_322072.awb") / 1000

			if var_502_7 > 0 and var_502_6 < var_502_7 and var_502_7 + var_502_5 > arg_499_1.duration_ then
				local var_502_8 = var_502_7

				arg_499_1.duration_ = var_502_7 + var_502_5
			end

			if var_502_5 < arg_499_1.time_ and arg_499_1.time_ <= var_502_5 + arg_502_0 then
				local var_502_9 = "play"
				local var_502_10 = "voice"

				arg_499_1:AudioAction(var_502_9, var_502_10, "story_v_out_322072", "322072119", "story_v_out_322072.awb")
			end
		end

		arg_499_1.nodeConfigList_ = {
			{
				displayDialog = false,
				enableBgChange = false,
				enableTextPropertyChange = true,
				className = "StoryTextGroupNode",
				enableEffect = true,
				contentID = 322072119,
				charCount = 7,
				enableLayoutChange = true,
				duration = 0.466666666666667,
				groupID = "2119",
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
					paragraphAlignment = UnityEngine.TextAnchor.MiddleLeft
				},
				textComProperty = {
					fontSize = 36,
					fontAssetPath = "Fonts/SourceHanSans",
					lineSpacing = 1,
					textColor = Color.New(1, 1, 1, 1),
					textAlignment = UnityEngine.TextAnchor.UpperCenter
				},
				effectData = {
					textEffectType = StoryPlayerConst.TEXT_GROUP_EFFECT_TYPE.TYPE_WRITER
				}
			},
			{
				groupID = "2118",
				duration = 0.933333333333333,
				className = "StoryTextGroupNode",
				startTime = 0,
				TEXT_GROUP_NODE_TYPE = StoryPlayerConst.TEXT_GROUP_NODE_TYPE.DESTROY_TEXT_GROUP
			}
		}

		arg_499_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L17f",
		"TextureConfig/Background/L19f",
		"TextureConfig/Background/ST61a",
		"TextureConfig/Background/L15f",
		"TextureConfig/Background/ST0510",
		"TextureConfig/Background/MS2202",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_322072.awb"
	}
}
