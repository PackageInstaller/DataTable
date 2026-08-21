return {
	Play1103404001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1103404001
		arg_1_1.duration_ = 3.9

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1103404002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I11p"

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
				local var_4_5 = arg_1_1.bgs_.I11p

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
					if iter_4_0 ~= "I11p" then
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

			local var_4_24 = "1034ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1034ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1034ui_story"].transform
			local var_4_30 = 0

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1034ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, 100, 0)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1034ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, 100, 0)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1034ui_story"].transform
			local var_4_39 = 1.8

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.var_.moveOldPos1034ui_story = var_4_38.localPosition
			end

			local var_4_40 = 0.001

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40
				local var_4_42 = Vector3.New(0, -0.93, -6)

				var_4_38.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1034ui_story, var_4_42, var_4_41)

				local var_4_43 = manager.ui.mainCamera.transform.position - var_4_38.position

				var_4_38.forward = Vector3.New(var_4_43.x, var_4_43.y, var_4_43.z)

				local var_4_44 = var_4_38.localEulerAngles

				var_4_44.z = 0
				var_4_44.x = 0
				var_4_38.localEulerAngles = var_4_44
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				var_4_38.localPosition = Vector3.New(0, -0.93, -6)

				local var_4_45 = manager.ui.mainCamera.transform.position - var_4_38.position

				var_4_38.forward = Vector3.New(var_4_45.x, var_4_45.y, var_4_45.z)

				local var_4_46 = var_4_38.localEulerAngles

				var_4_46.z = 0
				var_4_46.x = 0
				var_4_38.localEulerAngles = var_4_46
			end

			local var_4_47 = arg_1_1.actors_["1034ui_story"]
			local var_4_48 = 1.8

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 and not isNil(var_4_47) and arg_1_1.var_.characterEffect1034ui_story == nil then
				arg_1_1.var_.characterEffect1034ui_story = var_4_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_49 = 0.200000002980232

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 and not isNil(var_4_47) then
				local var_4_50 = (arg_1_1.time_ - var_4_48) / var_4_49

				if arg_1_1.var_.characterEffect1034ui_story and not isNil(var_4_47) then
					arg_1_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 and not isNil(var_4_47) and arg_1_1.var_.characterEffect1034ui_story then
				arg_1_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_4_51 = 1.8

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				arg_1_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_4_52 = 1.8

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				arg_1_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_4_53 = 0.2
			local var_4_54 = 1

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "effect"

				arg_1_1:AudioAction(var_4_55, var_4_56, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_4_57 = 0
			local var_4_58 = 0.3

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				local var_4_59 = "play"
				local var_4_60 = "music"

				arg_1_1:AudioAction(var_4_59, var_4_60, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_61 = ""
				local var_4_62 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_62 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_62 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_62

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_62
						arg_1_1.bgmTxt2_.text = var_4_62
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

			local var_4_63 = 0.433333333333333
			local var_4_64 = 1

			if var_4_63 < arg_1_1.time_ and arg_1_1.time_ <= var_4_63 + arg_4_0 then
				local var_4_65 = "play"
				local var_4_66 = "music"

				arg_1_1:AudioAction(var_4_65, var_4_66, "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_67 = ""
				local var_4_68 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

				if var_4_68 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_68 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_68

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_68
						arg_1_1.bgmTxt2_.text = var_4_68
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

			local var_4_69 = 2
			local var_4_70 = 0.25

			if var_4_69 < arg_1_1.time_ and arg_1_1.time_ <= var_4_69 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_71 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_71:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_72 = arg_1_1:FormatText(StoryNameCfg[1109].name)

				arg_1_1.leftNameTxt_.text = var_4_72

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_73 = arg_1_1:GetWordFromCfg(1103404001)
				local var_4_74 = arg_1_1:FormatText(var_4_73.content)

				arg_1_1.text_.text = var_4_74

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_75 = 10
				local var_4_76 = utf8.len(var_4_74)
				local var_4_77 = var_4_75 <= 0 and var_4_70 or var_4_70 * (var_4_76 / var_4_75)

				if var_4_77 > 0 and var_4_70 < var_4_77 then
					arg_1_1.talkMaxDuration = var_4_77
					var_4_69 = var_4_69 + 0.3

					if var_4_77 + var_4_69 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_77 + var_4_69
					end
				end

				arg_1_1.text_.text = var_4_74
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404001", "story_v_side_new_1103404.awb") ~= 0 then
					local var_4_78 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404001", "story_v_side_new_1103404.awb") / 1000

					if var_4_78 + var_4_69 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_78 + var_4_69
					end

					if var_4_73.prefab_name ~= "" and arg_1_1.actors_[var_4_73.prefab_name] ~= nil then
						local var_4_79 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_73.prefab_name].transform, "story_v_side_new_1103404", "1103404001", "story_v_side_new_1103404.awb")

						arg_1_1:RecordAudio("1103404001", var_4_79)
						arg_1_1:RecordAudio("1103404001", var_4_79)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404001", "story_v_side_new_1103404.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404001", "story_v_side_new_1103404.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_80 = var_4_69 + 0.3
			local var_4_81 = math.max(var_4_70, arg_1_1.talkMaxDuration)

			if var_4_80 <= arg_1_1.time_ and arg_1_1.time_ < var_4_80 + var_4_81 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_80) / var_4_81

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_80 + var_4_81 and arg_1_1.time_ < var_4_80 + var_4_81 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1034ui_story",
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
	Play1103404002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1103404002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1103404003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1034ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1034ui_story == nil then
				arg_9_1.var_.characterEffect1034ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect1034ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1034ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect1034ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1034ui_story.fillRatio = var_12_5
			end

			local var_12_6 = 0
			local var_12_7 = 1.65

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_8 = arg_9_1:GetWordFromCfg(1103404002)
				local var_12_9 = arg_9_1:FormatText(var_12_8.content)

				arg_9_1.text_.text = var_12_9

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_10 = 66
				local var_12_11 = utf8.len(var_12_9)
				local var_12_12 = var_12_10 <= 0 and var_12_7 or var_12_7 * (var_12_11 / var_12_10)

				if var_12_12 > 0 and var_12_7 < var_12_12 then
					arg_9_1.talkMaxDuration = var_12_12

					if var_12_12 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_12 + var_12_6
					end
				end

				arg_9_1.text_.text = var_12_9
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_13 = math.max(var_12_7, arg_9_1.talkMaxDuration)

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_13 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_6) / var_12_13

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_6 + var_12_13 and arg_9_1.time_ < var_12_6 + var_12_13 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play1103404003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1103404003
		arg_13_1.duration_ = 6.13

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1103404004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.55

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[690].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(1103404003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 22
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

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404003", "story_v_side_new_1103404.awb") ~= 0 then
					local var_16_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404003", "story_v_side_new_1103404.awb") / 1000

					if var_16_8 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_8 + var_16_0
					end

					if var_16_3.prefab_name ~= "" and arg_13_1.actors_[var_16_3.prefab_name] ~= nil then
						local var_16_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_3.prefab_name].transform, "story_v_side_new_1103404", "1103404003", "story_v_side_new_1103404.awb")

						arg_13_1:RecordAudio("1103404003", var_16_9)
						arg_13_1:RecordAudio("1103404003", var_16_9)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404003", "story_v_side_new_1103404.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404003", "story_v_side_new_1103404.awb")
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
	Play1103404004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1103404004
		arg_17_1.duration_ = 2.4

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1103404005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1034ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1034ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, -0.93, -6)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1034ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -0.93, -6)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1034ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1034ui_story == nil then
				arg_17_1.var_.characterEffect1034ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect1034ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1034ui_story then
				arg_17_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			local var_20_14 = 0

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_20_15 = 0
			local var_20_16 = 0.325

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_17 = arg_17_1:FormatText(StoryNameCfg[1109].name)

				arg_17_1.leftNameTxt_.text = var_20_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_18 = arg_17_1:GetWordFromCfg(1103404004)
				local var_20_19 = arg_17_1:FormatText(var_20_18.content)

				arg_17_1.text_.text = var_20_19

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_20 = 13
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

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404004", "story_v_side_new_1103404.awb") ~= 0 then
					local var_20_23 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404004", "story_v_side_new_1103404.awb") / 1000

					if var_20_23 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_15
					end

					if var_20_18.prefab_name ~= "" and arg_17_1.actors_[var_20_18.prefab_name] ~= nil then
						local var_20_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_18.prefab_name].transform, "story_v_side_new_1103404", "1103404004", "story_v_side_new_1103404.awb")

						arg_17_1:RecordAudio("1103404004", var_20_24)
						arg_17_1:RecordAudio("1103404004", var_20_24)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404004", "story_v_side_new_1103404.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404004", "story_v_side_new_1103404.awb")
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
				actorName = "1034ui_story",
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
	Play1103404005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1103404005
		arg_21_1.duration_ = 5.93

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1103404006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1034ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1034ui_story == nil then
				arg_21_1.var_.characterEffect1034ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1034ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1034ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1034ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1034ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			local var_24_7 = 0
			local var_24_8 = 0.65

			if var_24_7 < arg_21_1.time_ and arg_21_1.time_ <= var_24_7 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_9 = arg_21_1:FormatText(StoryNameCfg[690].name)

				arg_21_1.leftNameTxt_.text = var_24_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_10 = arg_21_1:GetWordFromCfg(1103404005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_12 = 26
				local var_24_13 = utf8.len(var_24_11)
				local var_24_14 = var_24_12 <= 0 and var_24_8 or var_24_8 * (var_24_13 / var_24_12)

				if var_24_14 > 0 and var_24_8 < var_24_14 then
					arg_21_1.talkMaxDuration = var_24_14

					if var_24_14 + var_24_7 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_7
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404005", "story_v_side_new_1103404.awb") ~= 0 then
					local var_24_15 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404005", "story_v_side_new_1103404.awb") / 1000

					if var_24_15 + var_24_7 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_7
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_side_new_1103404", "1103404005", "story_v_side_new_1103404.awb")

						arg_21_1:RecordAudio("1103404005", var_24_16)
						arg_21_1:RecordAudio("1103404005", var_24_16)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404005", "story_v_side_new_1103404.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404005", "story_v_side_new_1103404.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_17 = math.max(var_24_8, arg_21_1.talkMaxDuration)

			if var_24_7 <= arg_21_1.time_ and arg_21_1.time_ < var_24_7 + var_24_17 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_7) / var_24_17

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_7 + var_24_17 and arg_21_1.time_ < var_24_7 + var_24_17 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1103404006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1103404006
		arg_25_1.duration_ = 5.43

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1103404007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1034ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1034ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, -0.93, -6)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1034ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -0.93, -6)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = arg_25_1.actors_["1034ui_story"]
			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1034ui_story == nil then
				arg_25_1.var_.characterEffect1034ui_story = var_28_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_11 = 0.200000002980232

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 and not isNil(var_28_9) then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / var_28_11

				if arg_25_1.var_.characterEffect1034ui_story and not isNil(var_28_9) then
					arg_25_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 and not isNil(var_28_9) and arg_25_1.var_.characterEffect1034ui_story then
				arg_25_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_28_13 = 0

			if var_28_13 < arg_25_1.time_ and arg_25_1.time_ <= var_28_13 + arg_28_0 then
				arg_25_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_28_14 = 0
			local var_28_15 = 0.7

			if var_28_14 < arg_25_1.time_ and arg_25_1.time_ <= var_28_14 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_16 = arg_25_1:FormatText(StoryNameCfg[1109].name)

				arg_25_1.leftNameTxt_.text = var_28_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_17 = arg_25_1:GetWordFromCfg(1103404006)
				local var_28_18 = arg_25_1:FormatText(var_28_17.content)

				arg_25_1.text_.text = var_28_18

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_19 = 28
				local var_28_20 = utf8.len(var_28_18)
				local var_28_21 = var_28_19 <= 0 and var_28_15 or var_28_15 * (var_28_20 / var_28_19)

				if var_28_21 > 0 and var_28_15 < var_28_21 then
					arg_25_1.talkMaxDuration = var_28_21

					if var_28_21 + var_28_14 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_21 + var_28_14
					end
				end

				arg_25_1.text_.text = var_28_18
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404006", "story_v_side_new_1103404.awb") ~= 0 then
					local var_28_22 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404006", "story_v_side_new_1103404.awb") / 1000

					if var_28_22 + var_28_14 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_14
					end

					if var_28_17.prefab_name ~= "" and arg_25_1.actors_[var_28_17.prefab_name] ~= nil then
						local var_28_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_17.prefab_name].transform, "story_v_side_new_1103404", "1103404006", "story_v_side_new_1103404.awb")

						arg_25_1:RecordAudio("1103404006", var_28_23)
						arg_25_1:RecordAudio("1103404006", var_28_23)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404006", "story_v_side_new_1103404.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404006", "story_v_side_new_1103404.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_24 = math.max(var_28_15, arg_25_1.talkMaxDuration)

			if var_28_14 <= arg_25_1.time_ and arg_25_1.time_ < var_28_14 + var_28_24 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_14) / var_28_24

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_14 + var_28_24 and arg_25_1.time_ < var_28_14 + var_28_24 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play1103404007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1103404007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1103404008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1034ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1034ui_story == nil then
				arg_29_1.var_.characterEffect1034ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1034ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1034ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1034ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1034ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_32_7 = 0
			local var_32_8 = 1.15

			if var_32_7 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:GetWordFromCfg(1103404007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 46
				local var_32_12 = utf8.len(var_32_10)
				local var_32_13 = var_32_11 <= 0 and var_32_8 or var_32_8 * (var_32_12 / var_32_11)

				if var_32_13 > 0 and var_32_8 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_7
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_8, arg_29_1.talkMaxDuration)

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_7) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_7 + var_32_14 and arg_29_1.time_ < var_32_7 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play1103404008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1103404008
		arg_33_1.duration_ = 3.27

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1103404009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1034ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1034ui_story == nil then
				arg_33_1.var_.characterEffect1034ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1034ui_story and not isNil(var_36_0) then
					arg_33_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1034ui_story then
				arg_33_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_36_4 = 0

			if var_36_4 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_36_5 = 0
			local var_36_6 = 0.4

			if var_36_5 < arg_33_1.time_ and arg_33_1.time_ <= var_36_5 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_7 = arg_33_1:FormatText(StoryNameCfg[1109].name)

				arg_33_1.leftNameTxt_.text = var_36_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(1103404008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 16
				local var_36_11 = utf8.len(var_36_9)
				local var_36_12 = var_36_10 <= 0 and var_36_6 or var_36_6 * (var_36_11 / var_36_10)

				if var_36_12 > 0 and var_36_6 < var_36_12 then
					arg_33_1.talkMaxDuration = var_36_12

					if var_36_12 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_5
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404008", "story_v_side_new_1103404.awb") ~= 0 then
					local var_36_13 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404008", "story_v_side_new_1103404.awb") / 1000

					if var_36_13 + var_36_5 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_5
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_side_new_1103404", "1103404008", "story_v_side_new_1103404.awb")

						arg_33_1:RecordAudio("1103404008", var_36_14)
						arg_33_1:RecordAudio("1103404008", var_36_14)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404008", "story_v_side_new_1103404.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404008", "story_v_side_new_1103404.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_15 = math.max(var_36_6, arg_33_1.talkMaxDuration)

			if var_36_5 <= arg_33_1.time_ and arg_33_1.time_ < var_36_5 + var_36_15 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_5) / var_36_15

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_5 + var_36_15 and arg_33_1.time_ < var_36_5 + var_36_15 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1103404009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1103404009
		arg_37_1.duration_ = 7.13

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1103404010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1034ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1034ui_story == nil then
				arg_37_1.var_.characterEffect1034ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1034ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1034ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1034ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1034ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 0.65

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[690].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwc")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_9 = arg_37_1:GetWordFromCfg(1103404009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 26
				local var_40_12 = utf8.len(var_40_10)
				local var_40_13 = var_40_11 <= 0 and var_40_7 or var_40_7 * (var_40_12 / var_40_11)

				if var_40_13 > 0 and var_40_7 < var_40_13 then
					arg_37_1.talkMaxDuration = var_40_13

					if var_40_13 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_13 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_10
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404009", "story_v_side_new_1103404.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404009", "story_v_side_new_1103404.awb") / 1000

					if var_40_14 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_6
					end

					if var_40_9.prefab_name ~= "" and arg_37_1.actors_[var_40_9.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_9.prefab_name].transform, "story_v_side_new_1103404", "1103404009", "story_v_side_new_1103404.awb")

						arg_37_1:RecordAudio("1103404009", var_40_15)
						arg_37_1:RecordAudio("1103404009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404009", "story_v_side_new_1103404.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404009", "story_v_side_new_1103404.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_16 and arg_37_1.time_ < var_40_6 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play1103404010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1103404010
		arg_41_1.duration_ = 5.57

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1103404011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1034ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1034ui_story == nil then
				arg_41_1.var_.characterEffect1034ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1034ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1034ui_story then
				arg_41_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_44_6 = 0
			local var_44_7 = 0.7

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[1109].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_9 = arg_41_1:GetWordFromCfg(1103404010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 28
				local var_44_12 = utf8.len(var_44_10)
				local var_44_13 = var_44_11 <= 0 and var_44_7 or var_44_7 * (var_44_12 / var_44_11)

				if var_44_13 > 0 and var_44_7 < var_44_13 then
					arg_41_1.talkMaxDuration = var_44_13

					if var_44_13 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_13 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_10
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404010", "story_v_side_new_1103404.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404010", "story_v_side_new_1103404.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_side_new_1103404", "1103404010", "story_v_side_new_1103404.awb")

						arg_41_1:RecordAudio("1103404010", var_44_15)
						arg_41_1:RecordAudio("1103404010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404010", "story_v_side_new_1103404.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404010", "story_v_side_new_1103404.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_16 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_16 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_16

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_16 and arg_41_1.time_ < var_44_6 + var_44_16 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play1103404011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1103404011
		arg_45_1.duration_ = 5.83

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1103404012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.775

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[1109].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:GetWordFromCfg(1103404011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 31
				local var_48_6 = utf8.len(var_48_4)
				local var_48_7 = var_48_5 <= 0 and var_48_1 or var_48_1 * (var_48_6 / var_48_5)

				if var_48_7 > 0 and var_48_1 < var_48_7 then
					arg_45_1.talkMaxDuration = var_48_7

					if var_48_7 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_7 + var_48_0
					end
				end

				arg_45_1.text_.text = var_48_4
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404011", "story_v_side_new_1103404.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404011", "story_v_side_new_1103404.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_side_new_1103404", "1103404011", "story_v_side_new_1103404.awb")

						arg_45_1:RecordAudio("1103404011", var_48_9)
						arg_45_1:RecordAudio("1103404011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404011", "story_v_side_new_1103404.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404011", "story_v_side_new_1103404.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_10 = math.max(var_48_1, arg_45_1.talkMaxDuration)

			if var_48_0 <= arg_45_1.time_ and arg_45_1.time_ < var_48_0 + var_48_10 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_0) / var_48_10

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_0 + var_48_10 and arg_45_1.time_ < var_48_0 + var_48_10 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play1103404012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1103404012
		arg_49_1.duration_ = 2

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1103404013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0

			if var_52_0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_0 + arg_52_0 then
				arg_49_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_52_1 = 0
			local var_52_2 = 0.1

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_3 = arg_49_1:FormatText(StoryNameCfg[1109].name)

				arg_49_1.leftNameTxt_.text = var_52_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_4 = arg_49_1:GetWordFromCfg(1103404012)
				local var_52_5 = arg_49_1:FormatText(var_52_4.content)

				arg_49_1.text_.text = var_52_5

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_6 = 4
				local var_52_7 = utf8.len(var_52_5)
				local var_52_8 = var_52_6 <= 0 and var_52_2 or var_52_2 * (var_52_7 / var_52_6)

				if var_52_8 > 0 and var_52_2 < var_52_8 then
					arg_49_1.talkMaxDuration = var_52_8

					if var_52_8 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_8 + var_52_1
					end
				end

				arg_49_1.text_.text = var_52_5
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404012", "story_v_side_new_1103404.awb") ~= 0 then
					local var_52_9 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404012", "story_v_side_new_1103404.awb") / 1000

					if var_52_9 + var_52_1 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_1
					end

					if var_52_4.prefab_name ~= "" and arg_49_1.actors_[var_52_4.prefab_name] ~= nil then
						local var_52_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_4.prefab_name].transform, "story_v_side_new_1103404", "1103404012", "story_v_side_new_1103404.awb")

						arg_49_1:RecordAudio("1103404012", var_52_10)
						arg_49_1:RecordAudio("1103404012", var_52_10)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404012", "story_v_side_new_1103404.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404012", "story_v_side_new_1103404.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_11 = math.max(var_52_2, arg_49_1.talkMaxDuration)

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_11 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_1) / var_52_11

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_1 + var_52_11 and arg_49_1.time_ < var_52_1 + var_52_11 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play1103404013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1103404013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1103404014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1034ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1034ui_story == nil then
				arg_53_1.var_.characterEffect1034ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1034ui_story and not isNil(var_56_0) then
					local var_56_4 = Mathf.Lerp(0, 0.5, var_56_3)

					arg_53_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1034ui_story.fillRatio = var_56_4
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1034ui_story then
				local var_56_5 = 0.5

				arg_53_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1034ui_story.fillRatio = var_56_5
			end

			local var_56_6 = 0
			local var_56_7 = 1.225

			if var_56_6 < arg_53_1.time_ and arg_53_1.time_ <= var_56_6 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_8 = arg_53_1:GetWordFromCfg(1103404013)
				local var_56_9 = arg_53_1:FormatText(var_56_8.content)

				arg_53_1.text_.text = var_56_9

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_10 = 49
				local var_56_11 = utf8.len(var_56_9)
				local var_56_12 = var_56_10 <= 0 and var_56_7 or var_56_7 * (var_56_11 / var_56_10)

				if var_56_12 > 0 and var_56_7 < var_56_12 then
					arg_53_1.talkMaxDuration = var_56_12

					if var_56_12 + var_56_6 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_12 + var_56_6
					end
				end

				arg_53_1.text_.text = var_56_9
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_13 = math.max(var_56_7, arg_53_1.talkMaxDuration)

			if var_56_6 <= arg_53_1.time_ and arg_53_1.time_ < var_56_6 + var_56_13 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_6) / var_56_13

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_6 + var_56_13 and arg_53_1.time_ < var_56_6 + var_56_13 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play1103404014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1103404014
		arg_57_1.duration_ = 2

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1103404015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1034ui_story"]
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1034ui_story == nil then
				arg_57_1.var_.characterEffect1034ui_story = var_60_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 and not isNil(var_60_0) then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2

				if arg_57_1.var_.characterEffect1034ui_story and not isNil(var_60_0) then
					arg_57_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 and not isNil(var_60_0) and arg_57_1.var_.characterEffect1034ui_story then
				arg_57_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_60_4 = 0

			if var_60_4 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_60_5 = 0

			if var_60_5 < arg_57_1.time_ and arg_57_1.time_ <= var_60_5 + arg_60_0 then
				arg_57_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			local var_60_6 = 0
			local var_60_7 = 0.25

			if var_60_6 < arg_57_1.time_ and arg_57_1.time_ <= var_60_6 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_8 = arg_57_1:FormatText(StoryNameCfg[1109].name)

				arg_57_1.leftNameTxt_.text = var_60_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_9 = arg_57_1:GetWordFromCfg(1103404014)
				local var_60_10 = arg_57_1:FormatText(var_60_9.content)

				arg_57_1.text_.text = var_60_10

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_11 = 10
				local var_60_12 = utf8.len(var_60_10)
				local var_60_13 = var_60_11 <= 0 and var_60_7 or var_60_7 * (var_60_12 / var_60_11)

				if var_60_13 > 0 and var_60_7 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_6
					end
				end

				arg_57_1.text_.text = var_60_10
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404014", "story_v_side_new_1103404.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404014", "story_v_side_new_1103404.awb") / 1000

					if var_60_14 + var_60_6 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_6
					end

					if var_60_9.prefab_name ~= "" and arg_57_1.actors_[var_60_9.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_9.prefab_name].transform, "story_v_side_new_1103404", "1103404014", "story_v_side_new_1103404.awb")

						arg_57_1:RecordAudio("1103404014", var_60_15)
						arg_57_1:RecordAudio("1103404014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404014", "story_v_side_new_1103404.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404014", "story_v_side_new_1103404.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_7, arg_57_1.talkMaxDuration)

			if var_60_6 <= arg_57_1.time_ and arg_57_1.time_ < var_60_6 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_6) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_6 + var_60_16 and arg_57_1.time_ < var_60_6 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play1103404015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1103404015
		arg_61_1.duration_ = 4.9

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1103404016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1034ui_story"]
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1034ui_story == nil then
				arg_61_1.var_.characterEffect1034ui_story = var_64_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 and not isNil(var_64_0) then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2

				if arg_61_1.var_.characterEffect1034ui_story and not isNil(var_64_0) then
					local var_64_4 = Mathf.Lerp(0, 0.5, var_64_3)

					arg_61_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1034ui_story.fillRatio = var_64_4
				end
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 and not isNil(var_64_0) and arg_61_1.var_.characterEffect1034ui_story then
				local var_64_5 = 0.5

				arg_61_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1034ui_story.fillRatio = var_64_5
			end

			local var_64_6 = 0
			local var_64_7 = 0.4

			if var_64_6 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_8 = arg_61_1:FormatText(StoryNameCfg[171].name)

				arg_61_1.leftNameTxt_.text = var_64_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_9 = arg_61_1:GetWordFromCfg(1103404015)
				local var_64_10 = arg_61_1:FormatText(var_64_9.content)

				arg_61_1.text_.text = var_64_10

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 16
				local var_64_12 = utf8.len(var_64_10)
				local var_64_13 = var_64_11 <= 0 and var_64_7 or var_64_7 * (var_64_12 / var_64_11)

				if var_64_13 > 0 and var_64_7 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_10
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404015", "story_v_side_new_1103404.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404015", "story_v_side_new_1103404.awb") / 1000

					if var_64_14 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_6
					end

					if var_64_9.prefab_name ~= "" and arg_61_1.actors_[var_64_9.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_9.prefab_name].transform, "story_v_side_new_1103404", "1103404015", "story_v_side_new_1103404.awb")

						arg_61_1:RecordAudio("1103404015", var_64_15)
						arg_61_1:RecordAudio("1103404015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404015", "story_v_side_new_1103404.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404015", "story_v_side_new_1103404.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_16 and arg_61_1.time_ < var_64_6 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play1103404016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1103404016
		arg_65_1.duration_ = 2

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1103404017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1034ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1034ui_story == nil then
				arg_65_1.var_.characterEffect1034ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect1034ui_story and not isNil(var_68_0) then
					arg_65_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect1034ui_story then
				arg_65_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_68_4 = 0

			if var_68_4 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_68_5 = 0

			if var_68_5 < arg_65_1.time_ and arg_65_1.time_ <= var_68_5 + arg_68_0 then
				arg_65_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			local var_68_6 = 0
			local var_68_7 = 0.125

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[1109].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_9 = arg_65_1:GetWordFromCfg(1103404016)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 5
				local var_68_12 = utf8.len(var_68_10)
				local var_68_13 = var_68_11 <= 0 and var_68_7 or var_68_7 * (var_68_12 / var_68_11)

				if var_68_13 > 0 and var_68_7 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_10
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404016", "story_v_side_new_1103404.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404016", "story_v_side_new_1103404.awb") / 1000

					if var_68_14 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_6
					end

					if var_68_9.prefab_name ~= "" and arg_65_1.actors_[var_68_9.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_9.prefab_name].transform, "story_v_side_new_1103404", "1103404016", "story_v_side_new_1103404.awb")

						arg_65_1:RecordAudio("1103404016", var_68_15)
						arg_65_1:RecordAudio("1103404016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404016", "story_v_side_new_1103404.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404016", "story_v_side_new_1103404.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_16 and arg_65_1.time_ < var_68_6 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play1103404017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1103404017
		arg_69_1.duration_ = 5.27

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1103404018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1034ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1034ui_story == nil then
				arg_69_1.var_.characterEffect1034ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1034ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1034ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1034ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1034ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.425

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[171].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_9 = arg_69_1:GetWordFromCfg(1103404017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 17
				local var_72_12 = utf8.len(var_72_10)
				local var_72_13 = var_72_11 <= 0 and var_72_7 or var_72_7 * (var_72_12 / var_72_11)

				if var_72_13 > 0 and var_72_7 < var_72_13 then
					arg_69_1.talkMaxDuration = var_72_13

					if var_72_13 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_13 + var_72_6
					end
				end

				arg_69_1.text_.text = var_72_10
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404017", "story_v_side_new_1103404.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404017", "story_v_side_new_1103404.awb") / 1000

					if var_72_14 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_6
					end

					if var_72_9.prefab_name ~= "" and arg_69_1.actors_[var_72_9.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_9.prefab_name].transform, "story_v_side_new_1103404", "1103404017", "story_v_side_new_1103404.awb")

						arg_69_1:RecordAudio("1103404017", var_72_15)
						arg_69_1:RecordAudio("1103404017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404017", "story_v_side_new_1103404.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404017", "story_v_side_new_1103404.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_16 = math.max(var_72_7, arg_69_1.talkMaxDuration)

			if var_72_6 <= arg_69_1.time_ and arg_69_1.time_ < var_72_6 + var_72_16 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_6) / var_72_16

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_6 + var_72_16 and arg_69_1.time_ < var_72_6 + var_72_16 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play1103404018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1103404018
		arg_73_1.duration_ = 7.1

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1103404019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1034ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1034ui_story == nil then
				arg_73_1.var_.characterEffect1034ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect1034ui_story and not isNil(var_76_0) then
					arg_73_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect1034ui_story then
				arg_73_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_76_4 = 0

			if var_76_4 < arg_73_1.time_ and arg_73_1.time_ <= var_76_4 + arg_76_0 then
				arg_73_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			local var_76_5 = 0

			if var_76_5 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_76_6 = 0
			local var_76_7 = 0.75

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[1109].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_9 = arg_73_1:GetWordFromCfg(1103404018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 30
				local var_76_12 = utf8.len(var_76_10)
				local var_76_13 = var_76_11 <= 0 and var_76_7 or var_76_7 * (var_76_12 / var_76_11)

				if var_76_13 > 0 and var_76_7 < var_76_13 then
					arg_73_1.talkMaxDuration = var_76_13

					if var_76_13 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_13 + var_76_6
					end
				end

				arg_73_1.text_.text = var_76_10
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404018", "story_v_side_new_1103404.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404018", "story_v_side_new_1103404.awb") / 1000

					if var_76_14 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_6
					end

					if var_76_9.prefab_name ~= "" and arg_73_1.actors_[var_76_9.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_9.prefab_name].transform, "story_v_side_new_1103404", "1103404018", "story_v_side_new_1103404.awb")

						arg_73_1:RecordAudio("1103404018", var_76_15)
						arg_73_1:RecordAudio("1103404018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404018", "story_v_side_new_1103404.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404018", "story_v_side_new_1103404.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_16 = math.max(var_76_7, arg_73_1.talkMaxDuration)

			if var_76_6 <= arg_73_1.time_ and arg_73_1.time_ < var_76_6 + var_76_16 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_6) / var_76_16

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_6 + var_76_16 and arg_73_1.time_ < var_76_6 + var_76_16 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play1103404019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1103404019
		arg_77_1.duration_ = 6.27

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1103404020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.85

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[1109].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(1103404019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 34
				local var_80_6 = utf8.len(var_80_4)
				local var_80_7 = var_80_5 <= 0 and var_80_1 or var_80_1 * (var_80_6 / var_80_5)

				if var_80_7 > 0 and var_80_1 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_0
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404019", "story_v_side_new_1103404.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404019", "story_v_side_new_1103404.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_side_new_1103404", "1103404019", "story_v_side_new_1103404.awb")

						arg_77_1:RecordAudio("1103404019", var_80_9)
						arg_77_1:RecordAudio("1103404019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404019", "story_v_side_new_1103404.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404019", "story_v_side_new_1103404.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_10 = math.max(var_80_1, arg_77_1.talkMaxDuration)

			if var_80_0 <= arg_77_1.time_ and arg_77_1.time_ < var_80_0 + var_80_10 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_0) / var_80_10

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_0 + var_80_10 and arg_77_1.time_ < var_80_0 + var_80_10 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1103404020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1103404020
		arg_81_1.duration_ = 5.67

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1103404021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1034ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1034ui_story == nil then
				arg_81_1.var_.characterEffect1034ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.366666666666667

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1034ui_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1034ui_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1034ui_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1034ui_story.fillRatio = var_84_5
			end

			local var_84_6 = 0

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			local var_84_7 = 0

			if var_84_7 < arg_81_1.time_ and arg_81_1.time_ <= var_84_7 + arg_84_0 then
				arg_81_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_84_8 = 0
			local var_84_9 = 0.5

			if var_84_8 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_10 = arg_81_1:FormatText(StoryNameCfg[171].name)

				arg_81_1.leftNameTxt_.text = var_84_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_lolic")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_11 = arg_81_1:GetWordFromCfg(1103404020)
				local var_84_12 = arg_81_1:FormatText(var_84_11.content)

				arg_81_1.text_.text = var_84_12

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 20
				local var_84_14 = utf8.len(var_84_12)
				local var_84_15 = var_84_13 <= 0 and var_84_9 or var_84_9 * (var_84_14 / var_84_13)

				if var_84_15 > 0 and var_84_9 < var_84_15 then
					arg_81_1.talkMaxDuration = var_84_15

					if var_84_15 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_15 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_12
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404020", "story_v_side_new_1103404.awb") ~= 0 then
					local var_84_16 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404020", "story_v_side_new_1103404.awb") / 1000

					if var_84_16 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_16 + var_84_8
					end

					if var_84_11.prefab_name ~= "" and arg_81_1.actors_[var_84_11.prefab_name] ~= nil then
						local var_84_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_11.prefab_name].transform, "story_v_side_new_1103404", "1103404020", "story_v_side_new_1103404.awb")

						arg_81_1:RecordAudio("1103404020", var_84_17)
						arg_81_1:RecordAudio("1103404020", var_84_17)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404020", "story_v_side_new_1103404.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404020", "story_v_side_new_1103404.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_18 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_18 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_18

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_18 and arg_81_1.time_ < var_84_8 + var_84_18 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1103404021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1103404021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1103404022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_88_1 = 0
			local var_88_2 = 1.375

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(1103404021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 55
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_2 or var_88_2 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_2 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_1 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_1
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_2, arg_85_1.talkMaxDuration)

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_1) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_1 + var_88_8 and arg_85_1.time_ < var_88_1 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play1103404022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1103404022
		arg_89_1.duration_ = 2.9

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1103404023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1034ui_story"].transform
			local var_92_1 = 0.0173333351810773

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1034ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0, -0.93, -6)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1034ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0, -0.93, -6)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["1034ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1034ui_story == nil then
				arg_89_1.var_.characterEffect1034ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect1034ui_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1034ui_story then
				arg_89_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_92_13 = 0

			if var_92_13 < arg_89_1.time_ and arg_89_1.time_ <= var_92_13 + arg_92_0 then
				arg_89_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_1")
			end

			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 then
				arg_89_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_92_15 = 0
			local var_92_16 = 0.4

			if var_92_15 < arg_89_1.time_ and arg_89_1.time_ <= var_92_15 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_17 = arg_89_1:FormatText(StoryNameCfg[1109].name)

				arg_89_1.leftNameTxt_.text = var_92_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_18 = arg_89_1:GetWordFromCfg(1103404022)
				local var_92_19 = arg_89_1:FormatText(var_92_18.content)

				arg_89_1.text_.text = var_92_19

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_20 = 16
				local var_92_21 = utf8.len(var_92_19)
				local var_92_22 = var_92_20 <= 0 and var_92_16 or var_92_16 * (var_92_21 / var_92_20)

				if var_92_22 > 0 and var_92_16 < var_92_22 then
					arg_89_1.talkMaxDuration = var_92_22

					if var_92_22 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_22 + var_92_15
					end
				end

				arg_89_1.text_.text = var_92_19
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404022", "story_v_side_new_1103404.awb") ~= 0 then
					local var_92_23 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404022", "story_v_side_new_1103404.awb") / 1000

					if var_92_23 + var_92_15 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_23 + var_92_15
					end

					if var_92_18.prefab_name ~= "" and arg_89_1.actors_[var_92_18.prefab_name] ~= nil then
						local var_92_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_18.prefab_name].transform, "story_v_side_new_1103404", "1103404022", "story_v_side_new_1103404.awb")

						arg_89_1:RecordAudio("1103404022", var_92_24)
						arg_89_1:RecordAudio("1103404022", var_92_24)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404022", "story_v_side_new_1103404.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404022", "story_v_side_new_1103404.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_25 = math.max(var_92_16, arg_89_1.talkMaxDuration)

			if var_92_15 <= arg_89_1.time_ and arg_89_1.time_ < var_92_15 + var_92_25 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_15) / var_92_25

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_15 + var_92_25 and arg_89_1.time_ < var_92_15 + var_92_25 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.0173333351810773,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play1103404023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1103404023
		arg_93_1.duration_ = 9

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1103404024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 2

			if var_96_0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_0 + arg_96_0 then
				local var_96_1 = manager.ui.mainCamera.transform.localPosition
				local var_96_2 = Vector3.New(0, 0, 10) + Vector3.New(var_96_1.x, var_96_1.y, 0)
				local var_96_3 = arg_93_1.bgs_.I11p

				var_96_3.transform.localPosition = var_96_2
				var_96_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_96_4 = var_96_3:GetComponent("SpriteRenderer")

				if var_96_4 and var_96_4.sprite then
					local var_96_5 = (var_96_3.transform.localPosition - var_96_1).z
					local var_96_6 = manager.ui.mainCameraCom_
					local var_96_7 = 2 * var_96_5 * Mathf.Tan(var_96_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_96_8 = var_96_7 * var_96_6.aspect
					local var_96_9 = var_96_4.sprite.bounds.size.x
					local var_96_10 = var_96_4.sprite.bounds.size.y
					local var_96_11 = var_96_8 / var_96_9
					local var_96_12 = var_96_7 / var_96_10
					local var_96_13 = var_96_12 < var_96_11 and var_96_11 or var_96_12

					var_96_3.transform.localScale = Vector3.New(var_96_13, var_96_13, 0)
				end

				for iter_96_0, iter_96_1 in pairs(arg_93_1.bgs_) do
					if iter_96_0 ~= "I11p" then
						iter_96_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_96_14 = 4

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 then
				arg_93_1.allBtn_.enabled = false
			end

			local var_96_15 = 0.3

			if arg_93_1.time_ >= var_96_14 + var_96_15 and arg_93_1.time_ < var_96_14 + var_96_15 + arg_96_0 then
				arg_93_1.allBtn_.enabled = true
			end

			local var_96_16 = 0

			if var_96_16 < arg_93_1.time_ and arg_93_1.time_ <= var_96_16 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_17 = 2

			if var_96_16 <= arg_93_1.time_ and arg_93_1.time_ < var_96_16 + var_96_17 then
				local var_96_18 = (arg_93_1.time_ - var_96_16) / var_96_17
				local var_96_19 = Color.New(0, 0, 0)

				var_96_19.a = Mathf.Lerp(0, 1, var_96_18)
				arg_93_1.mask_.color = var_96_19
			end

			if arg_93_1.time_ >= var_96_16 + var_96_17 and arg_93_1.time_ < var_96_16 + var_96_17 + arg_96_0 then
				local var_96_20 = Color.New(0, 0, 0)

				var_96_20.a = 1
				arg_93_1.mask_.color = var_96_20
			end

			local var_96_21 = 2

			if var_96_21 < arg_93_1.time_ and arg_93_1.time_ <= var_96_21 + arg_96_0 then
				arg_93_1.mask_.enabled = true
				arg_93_1.mask_.raycastTarget = true

				arg_93_1:SetGaussion(false)
			end

			local var_96_22 = 2

			if var_96_21 <= arg_93_1.time_ and arg_93_1.time_ < var_96_21 + var_96_22 then
				local var_96_23 = (arg_93_1.time_ - var_96_21) / var_96_22
				local var_96_24 = Color.New(0, 0, 0)

				var_96_24.a = Mathf.Lerp(1, 0, var_96_23)
				arg_93_1.mask_.color = var_96_24
			end

			if arg_93_1.time_ >= var_96_21 + var_96_22 and arg_93_1.time_ < var_96_21 + var_96_22 + arg_96_0 then
				local var_96_25 = Color.New(0, 0, 0)
				local var_96_26 = 0

				arg_93_1.mask_.enabled = false
				var_96_25.a = var_96_26
				arg_93_1.mask_.color = var_96_25
			end

			local var_96_27 = arg_93_1.actors_["1034ui_story"]
			local var_96_28 = 0

			if var_96_28 < arg_93_1.time_ and arg_93_1.time_ <= var_96_28 + arg_96_0 and not isNil(var_96_27) and arg_93_1.var_.characterEffect1034ui_story == nil then
				arg_93_1.var_.characterEffect1034ui_story = var_96_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_29 = 0.200000002980232

			if var_96_28 <= arg_93_1.time_ and arg_93_1.time_ < var_96_28 + var_96_29 and not isNil(var_96_27) then
				local var_96_30 = (arg_93_1.time_ - var_96_28) / var_96_29

				if arg_93_1.var_.characterEffect1034ui_story and not isNil(var_96_27) then
					local var_96_31 = Mathf.Lerp(0, 0.5, var_96_30)

					arg_93_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1034ui_story.fillRatio = var_96_31
				end
			end

			if arg_93_1.time_ >= var_96_28 + var_96_29 and arg_93_1.time_ < var_96_28 + var_96_29 + arg_96_0 and not isNil(var_96_27) and arg_93_1.var_.characterEffect1034ui_story then
				local var_96_32 = 0.5

				arg_93_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1034ui_story.fillRatio = var_96_32
			end

			local var_96_33 = arg_93_1.actors_["1034ui_story"].transform
			local var_96_34 = 1.98333333333333

			if var_96_34 < arg_93_1.time_ and arg_93_1.time_ <= var_96_34 + arg_96_0 then
				arg_93_1.var_.moveOldPos1034ui_story = var_96_33.localPosition
			end

			local var_96_35 = 0.001

			if var_96_34 <= arg_93_1.time_ and arg_93_1.time_ < var_96_34 + var_96_35 then
				local var_96_36 = (arg_93_1.time_ - var_96_34) / var_96_35
				local var_96_37 = Vector3.New(0, 100, 0)

				var_96_33.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1034ui_story, var_96_37, var_96_36)

				local var_96_38 = manager.ui.mainCamera.transform.position - var_96_33.position

				var_96_33.forward = Vector3.New(var_96_38.x, var_96_38.y, var_96_38.z)

				local var_96_39 = var_96_33.localEulerAngles

				var_96_39.z = 0
				var_96_39.x = 0
				var_96_33.localEulerAngles = var_96_39
			end

			if arg_93_1.time_ >= var_96_34 + var_96_35 and arg_93_1.time_ < var_96_34 + var_96_35 + arg_96_0 then
				var_96_33.localPosition = Vector3.New(0, 100, 0)

				local var_96_40 = manager.ui.mainCamera.transform.position - var_96_33.position

				var_96_33.forward = Vector3.New(var_96_40.x, var_96_40.y, var_96_40.z)

				local var_96_41 = var_96_33.localEulerAngles

				var_96_41.z = 0
				var_96_41.x = 0
				var_96_33.localEulerAngles = var_96_41
			end

			if arg_93_1.frameCnt_ <= 1 then
				arg_93_1.dialog_:SetActive(false)
			end

			local var_96_42 = 4
			local var_96_43 = 1.475

			if var_96_42 < arg_93_1.time_ and arg_93_1.time_ <= var_96_42 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0

				arg_93_1.dialog_:SetActive(true)

				arg_93_1.dialogCg_.alpha = 0

				local var_96_44 = LeanTween.value(arg_93_1.dialog_, 0, 1, 0.3)

				var_96_44:setOnUpdate(LuaHelper.FloatAction(function(arg_97_0)
					arg_93_1.dialogCg_.alpha = arg_97_0
				end))
				var_96_44:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_93_1.dialog_)
					var_96_44:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_93_1.duration_ = arg_93_1.duration_ + 0.3

				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_45 = arg_93_1:GetWordFromCfg(1103404023)
				local var_96_46 = arg_93_1:FormatText(var_96_45.content)

				arg_93_1.text_.text = var_96_46

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_47 = 59
				local var_96_48 = utf8.len(var_96_46)
				local var_96_49 = var_96_47 <= 0 and var_96_43 or var_96_43 * (var_96_48 / var_96_47)

				if var_96_49 > 0 and var_96_43 < var_96_49 then
					arg_93_1.talkMaxDuration = var_96_49
					var_96_42 = var_96_42 + 0.3

					if var_96_49 + var_96_42 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_49 + var_96_42
					end
				end

				arg_93_1.text_.text = var_96_46
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_50 = var_96_42 + 0.3
			local var_96_51 = math.max(var_96_43, arg_93_1.talkMaxDuration)

			if var_96_50 <= arg_93_1.time_ and arg_93_1.time_ < var_96_50 + var_96_51 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_50) / var_96_51

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_50 + var_96_51 and arg_93_1.time_ < var_96_50 + var_96_51 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play1103404024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 1103404024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play1103404025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0
			local var_102_1 = 0.275

			if var_102_0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_2 = arg_99_1:FormatText(StoryNameCfg[7].name)

				arg_99_1.leftNameTxt_.text = var_102_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_3 = arg_99_1:GetWordFromCfg(1103404024)
				local var_102_4 = arg_99_1:FormatText(var_102_3.content)

				arg_99_1.text_.text = var_102_4

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_5 = 11
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
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_1, arg_99_1.talkMaxDuration)

			if var_102_0 <= arg_99_1.time_ and arg_99_1.time_ < var_102_0 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_0) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_0 + var_102_8 and arg_99_1.time_ < var_102_0 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play1103404025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 1103404025
		arg_103_1.duration_ = 3.8

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play1103404026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = arg_103_1.actors_["1034ui_story"].transform
			local var_106_1 = 0

			if var_106_1 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.var_.moveOldPos1034ui_story = var_106_0.localPosition
			end

			local var_106_2 = 0.001

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_2 then
				local var_106_3 = (arg_103_1.time_ - var_106_1) / var_106_2
				local var_106_4 = Vector3.New(0, -0.93, -6)

				var_106_0.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1034ui_story, var_106_4, var_106_3)

				local var_106_5 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_5.x, var_106_5.y, var_106_5.z)

				local var_106_6 = var_106_0.localEulerAngles

				var_106_6.z = 0
				var_106_6.x = 0
				var_106_0.localEulerAngles = var_106_6
			end

			if arg_103_1.time_ >= var_106_1 + var_106_2 and arg_103_1.time_ < var_106_1 + var_106_2 + arg_106_0 then
				var_106_0.localPosition = Vector3.New(0, -0.93, -6)

				local var_106_7 = manager.ui.mainCamera.transform.position - var_106_0.position

				var_106_0.forward = Vector3.New(var_106_7.x, var_106_7.y, var_106_7.z)

				local var_106_8 = var_106_0.localEulerAngles

				var_106_8.z = 0
				var_106_8.x = 0
				var_106_0.localEulerAngles = var_106_8
			end

			local var_106_9 = arg_103_1.actors_["1034ui_story"]
			local var_106_10 = 0

			if var_106_10 < arg_103_1.time_ and arg_103_1.time_ <= var_106_10 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1034ui_story == nil then
				arg_103_1.var_.characterEffect1034ui_story = var_106_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_11 = 0.200000002980232

			if var_106_10 <= arg_103_1.time_ and arg_103_1.time_ < var_106_10 + var_106_11 and not isNil(var_106_9) then
				local var_106_12 = (arg_103_1.time_ - var_106_10) / var_106_11

				if arg_103_1.var_.characterEffect1034ui_story and not isNil(var_106_9) then
					arg_103_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= var_106_10 + var_106_11 and arg_103_1.time_ < var_106_10 + var_106_11 + arg_106_0 and not isNil(var_106_9) and arg_103_1.var_.characterEffect1034ui_story then
				arg_103_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_106_13 = 0

			if var_106_13 < arg_103_1.time_ and arg_103_1.time_ <= var_106_13 + arg_106_0 then
				arg_103_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action4_1")
			end

			local var_106_14 = 0

			if var_106_14 < arg_103_1.time_ and arg_103_1.time_ <= var_106_14 + arg_106_0 then
				arg_103_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_106_15 = 0
			local var_106_16 = 0.325

			if var_106_15 < arg_103_1.time_ and arg_103_1.time_ <= var_106_15 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_17 = arg_103_1:FormatText(StoryNameCfg[1109].name)

				arg_103_1.leftNameTxt_.text = var_106_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_18 = arg_103_1:GetWordFromCfg(1103404025)
				local var_106_19 = arg_103_1:FormatText(var_106_18.content)

				arg_103_1.text_.text = var_106_19

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_20 = 13
				local var_106_21 = utf8.len(var_106_19)
				local var_106_22 = var_106_20 <= 0 and var_106_16 or var_106_16 * (var_106_21 / var_106_20)

				if var_106_22 > 0 and var_106_16 < var_106_22 then
					arg_103_1.talkMaxDuration = var_106_22

					if var_106_22 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_22 + var_106_15
					end
				end

				arg_103_1.text_.text = var_106_19
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404025", "story_v_side_new_1103404.awb") ~= 0 then
					local var_106_23 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404025", "story_v_side_new_1103404.awb") / 1000

					if var_106_23 + var_106_15 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_23 + var_106_15
					end

					if var_106_18.prefab_name ~= "" and arg_103_1.actors_[var_106_18.prefab_name] ~= nil then
						local var_106_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_18.prefab_name].transform, "story_v_side_new_1103404", "1103404025", "story_v_side_new_1103404.awb")

						arg_103_1:RecordAudio("1103404025", var_106_24)
						arg_103_1:RecordAudio("1103404025", var_106_24)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404025", "story_v_side_new_1103404.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404025", "story_v_side_new_1103404.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_25 = math.max(var_106_16, arg_103_1.talkMaxDuration)

			if var_106_15 <= arg_103_1.time_ and arg_103_1.time_ < var_106_15 + var_106_25 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_15) / var_106_25

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_15 + var_106_25 and arg_103_1.time_ < var_106_15 + var_106_25 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
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
	Play1103404026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 1103404026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play1103404027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = arg_107_1.actors_["1034ui_story"]
			local var_110_1 = 0

			if var_110_1 < arg_107_1.time_ and arg_107_1.time_ <= var_110_1 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1034ui_story == nil then
				arg_107_1.var_.characterEffect1034ui_story = var_110_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_2 = 0.200000002980232

			if var_110_1 <= arg_107_1.time_ and arg_107_1.time_ < var_110_1 + var_110_2 and not isNil(var_110_0) then
				local var_110_3 = (arg_107_1.time_ - var_110_1) / var_110_2

				if arg_107_1.var_.characterEffect1034ui_story and not isNil(var_110_0) then
					local var_110_4 = Mathf.Lerp(0, 0.5, var_110_3)

					arg_107_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1034ui_story.fillRatio = var_110_4
				end
			end

			if arg_107_1.time_ >= var_110_1 + var_110_2 and arg_107_1.time_ < var_110_1 + var_110_2 + arg_110_0 and not isNil(var_110_0) and arg_107_1.var_.characterEffect1034ui_story then
				local var_110_5 = 0.5

				arg_107_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1034ui_story.fillRatio = var_110_5
			end

			local var_110_6 = 0
			local var_110_7 = 0.15

			if var_110_6 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_8 = arg_107_1:FormatText(StoryNameCfg[7].name)

				arg_107_1.leftNameTxt_.text = var_110_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_9 = arg_107_1:GetWordFromCfg(1103404026)
				local var_110_10 = arg_107_1:FormatText(var_110_9.content)

				arg_107_1.text_.text = var_110_10

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 6
				local var_110_12 = utf8.len(var_110_10)
				local var_110_13 = var_110_11 <= 0 and var_110_7 or var_110_7 * (var_110_12 / var_110_11)

				if var_110_13 > 0 and var_110_7 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_10
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_14 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_14 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_14

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_14 and arg_107_1.time_ < var_110_6 + var_110_14 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play1103404027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 1103404027
		arg_111_1.duration_ = 7.5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play1103404028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1034ui_story"]
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1034ui_story == nil then
				arg_111_1.var_.characterEffect1034ui_story = var_114_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.200000002980232

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 and not isNil(var_114_0) then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2

				if arg_111_1.var_.characterEffect1034ui_story and not isNil(var_114_0) then
					arg_111_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 and not isNil(var_114_0) and arg_111_1.var_.characterEffect1034ui_story then
				arg_111_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_114_4 = 0

			if var_114_4 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action446")
			end

			local var_114_5 = 0

			if var_114_5 < arg_111_1.time_ and arg_111_1.time_ <= var_114_5 + arg_114_0 then
				arg_111_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_114_6 = 0
			local var_114_7 = 0.9

			if var_114_6 < arg_111_1.time_ and arg_111_1.time_ <= var_114_6 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_8 = arg_111_1:FormatText(StoryNameCfg[1109].name)

				arg_111_1.leftNameTxt_.text = var_114_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_9 = arg_111_1:GetWordFromCfg(1103404027)
				local var_114_10 = arg_111_1:FormatText(var_114_9.content)

				arg_111_1.text_.text = var_114_10

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_11 = 36
				local var_114_12 = utf8.len(var_114_10)
				local var_114_13 = var_114_11 <= 0 and var_114_7 or var_114_7 * (var_114_12 / var_114_11)

				if var_114_13 > 0 and var_114_7 < var_114_13 then
					arg_111_1.talkMaxDuration = var_114_13

					if var_114_13 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_13 + var_114_6
					end
				end

				arg_111_1.text_.text = var_114_10
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404027", "story_v_side_new_1103404.awb") ~= 0 then
					local var_114_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404027", "story_v_side_new_1103404.awb") / 1000

					if var_114_14 + var_114_6 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_14 + var_114_6
					end

					if var_114_9.prefab_name ~= "" and arg_111_1.actors_[var_114_9.prefab_name] ~= nil then
						local var_114_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_9.prefab_name].transform, "story_v_side_new_1103404", "1103404027", "story_v_side_new_1103404.awb")

						arg_111_1:RecordAudio("1103404027", var_114_15)
						arg_111_1:RecordAudio("1103404027", var_114_15)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404027", "story_v_side_new_1103404.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404027", "story_v_side_new_1103404.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_16 = math.max(var_114_7, arg_111_1.talkMaxDuration)

			if var_114_6 <= arg_111_1.time_ and arg_111_1.time_ < var_114_6 + var_114_16 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_6) / var_114_16

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_6 + var_114_16 and arg_111_1.time_ < var_114_6 + var_114_16 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play1103404028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 1103404028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play1103404029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["1034ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1034ui_story == nil then
				arg_115_1.var_.characterEffect1034ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 and not isNil(var_118_0) then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect1034ui_story and not isNil(var_118_0) then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_115_1.var_.characterEffect1034ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and not isNil(var_118_0) and arg_115_1.var_.characterEffect1034ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_115_1.var_.characterEffect1034ui_story.fillRatio = var_118_5
			end

			local var_118_6 = 0
			local var_118_7 = 0.325

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_8 = arg_115_1:FormatText(StoryNameCfg[7].name)

				arg_115_1.leftNameTxt_.text = var_118_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, true)
				arg_115_1.iconController_:SetSelectedState("hero")

				arg_115_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_115_1.callingController_:SetSelectedState("normal")

				arg_115_1.keyicon_.color = Color.New(1, 1, 1)
				arg_115_1.icon_.color = Color.New(1, 1, 1)

				local var_118_9 = arg_115_1:GetWordFromCfg(1103404028)
				local var_118_10 = arg_115_1:FormatText(var_118_9.content)

				arg_115_1.text_.text = var_118_10

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_11 = 13
				local var_118_12 = utf8.len(var_118_10)
				local var_118_13 = var_118_11 <= 0 and var_118_7 or var_118_7 * (var_118_12 / var_118_11)

				if var_118_13 > 0 and var_118_7 < var_118_13 then
					arg_115_1.talkMaxDuration = var_118_13

					if var_118_13 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_13 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_10
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_14 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_14 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_14

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_14 and arg_115_1.time_ < var_118_6 + var_118_14 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play1103404029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 1103404029
		arg_119_1.duration_ = 7.27

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play1103404030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = arg_119_1.actors_["1034ui_story"]
			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1034ui_story == nil then
				arg_119_1.var_.characterEffect1034ui_story = var_122_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if var_122_1 <= arg_119_1.time_ and arg_119_1.time_ < var_122_1 + var_122_2 and not isNil(var_122_0) then
				local var_122_3 = (arg_119_1.time_ - var_122_1) / var_122_2

				if arg_119_1.var_.characterEffect1034ui_story and not isNil(var_122_0) then
					arg_119_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= var_122_1 + var_122_2 and arg_119_1.time_ < var_122_1 + var_122_2 + arg_122_0 and not isNil(var_122_0) and arg_119_1.var_.characterEffect1034ui_story then
				arg_119_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_122_4 = 0

			if var_122_4 < arg_119_1.time_ and arg_119_1.time_ <= var_122_4 + arg_122_0 then
				arg_119_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			local var_122_5 = 0

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_122_6 = 0
			local var_122_7 = 0.825

			if var_122_6 < arg_119_1.time_ and arg_119_1.time_ <= var_122_6 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_8 = arg_119_1:FormatText(StoryNameCfg[1109].name)

				arg_119_1.leftNameTxt_.text = var_122_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_9 = arg_119_1:GetWordFromCfg(1103404029)
				local var_122_10 = arg_119_1:FormatText(var_122_9.content)

				arg_119_1.text_.text = var_122_10

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_11 = 33
				local var_122_12 = utf8.len(var_122_10)
				local var_122_13 = var_122_11 <= 0 and var_122_7 or var_122_7 * (var_122_12 / var_122_11)

				if var_122_13 > 0 and var_122_7 < var_122_13 then
					arg_119_1.talkMaxDuration = var_122_13

					if var_122_13 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_13 + var_122_6
					end
				end

				arg_119_1.text_.text = var_122_10
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404029", "story_v_side_new_1103404.awb") ~= 0 then
					local var_122_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404029", "story_v_side_new_1103404.awb") / 1000

					if var_122_14 + var_122_6 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_14 + var_122_6
					end

					if var_122_9.prefab_name ~= "" and arg_119_1.actors_[var_122_9.prefab_name] ~= nil then
						local var_122_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_9.prefab_name].transform, "story_v_side_new_1103404", "1103404029", "story_v_side_new_1103404.awb")

						arg_119_1:RecordAudio("1103404029", var_122_15)
						arg_119_1:RecordAudio("1103404029", var_122_15)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404029", "story_v_side_new_1103404.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404029", "story_v_side_new_1103404.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_16 = math.max(var_122_7, arg_119_1.talkMaxDuration)

			if var_122_6 <= arg_119_1.time_ and arg_119_1.time_ < var_122_6 + var_122_16 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_6) / var_122_16

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_6 + var_122_16 and arg_119_1.time_ < var_122_6 + var_122_16 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play1103404030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 1103404030
		arg_123_1.duration_ = 6.47

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play1103404031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_126_1 = 0
			local var_126_2 = 0.725

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_3 = arg_123_1:FormatText(StoryNameCfg[1109].name)

				arg_123_1.leftNameTxt_.text = var_126_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_4 = arg_123_1:GetWordFromCfg(1103404030)
				local var_126_5 = arg_123_1:FormatText(var_126_4.content)

				arg_123_1.text_.text = var_126_5

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_6 = 29
				local var_126_7 = utf8.len(var_126_5)
				local var_126_8 = var_126_6 <= 0 and var_126_2 or var_126_2 * (var_126_7 / var_126_6)

				if var_126_8 > 0 and var_126_2 < var_126_8 then
					arg_123_1.talkMaxDuration = var_126_8

					if var_126_8 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_8 + var_126_1
					end
				end

				arg_123_1.text_.text = var_126_5
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404030", "story_v_side_new_1103404.awb") ~= 0 then
					local var_126_9 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404030", "story_v_side_new_1103404.awb") / 1000

					if var_126_9 + var_126_1 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_9 + var_126_1
					end

					if var_126_4.prefab_name ~= "" and arg_123_1.actors_[var_126_4.prefab_name] ~= nil then
						local var_126_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_4.prefab_name].transform, "story_v_side_new_1103404", "1103404030", "story_v_side_new_1103404.awb")

						arg_123_1:RecordAudio("1103404030", var_126_10)
						arg_123_1:RecordAudio("1103404030", var_126_10)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404030", "story_v_side_new_1103404.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404030", "story_v_side_new_1103404.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_11 = math.max(var_126_2, arg_123_1.talkMaxDuration)

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_11 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_1) / var_126_11

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_1 + var_126_11 and arg_123_1.time_ < var_126_1 + var_126_11 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play1103404031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 1103404031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play1103404032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["1034ui_story"]
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1034ui_story == nil then
				arg_127_1.var_.characterEffect1034ui_story = var_130_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 and not isNil(var_130_0) then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2

				if arg_127_1.var_.characterEffect1034ui_story and not isNil(var_130_0) then
					local var_130_4 = Mathf.Lerp(0, 0.5, var_130_3)

					arg_127_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1034ui_story.fillRatio = var_130_4
				end
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 and not isNil(var_130_0) and arg_127_1.var_.characterEffect1034ui_story then
				local var_130_5 = 0.5

				arg_127_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1034ui_story.fillRatio = var_130_5
			end

			local var_130_6 = 0
			local var_130_7 = 0.7

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_8 = arg_127_1:FormatText(StoryNameCfg[7].name)

				arg_127_1.leftNameTxt_.text = var_130_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_9 = arg_127_1:GetWordFromCfg(1103404031)
				local var_130_10 = arg_127_1:FormatText(var_130_9.content)

				arg_127_1.text_.text = var_130_10

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_11 = 28
				local var_130_12 = utf8.len(var_130_10)
				local var_130_13 = var_130_11 <= 0 and var_130_7 or var_130_7 * (var_130_12 / var_130_11)

				if var_130_13 > 0 and var_130_7 < var_130_13 then
					arg_127_1.talkMaxDuration = var_130_13

					if var_130_13 + var_130_6 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_6
					end
				end

				arg_127_1.text_.text = var_130_10
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_14 = math.max(var_130_7, arg_127_1.talkMaxDuration)

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_14 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_6) / var_130_14

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_6 + var_130_14 and arg_127_1.time_ < var_130_6 + var_130_14 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play1103404032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 1103404032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play1103404033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0
			local var_134_1 = 0.875

			if var_134_0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_2 = arg_131_1:FormatText(StoryNameCfg[7].name)

				arg_131_1.leftNameTxt_.text = var_134_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_3 = arg_131_1:GetWordFromCfg(1103404032)
				local var_134_4 = arg_131_1:FormatText(var_134_3.content)

				arg_131_1.text_.text = var_134_4

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 35
				local var_134_6 = utf8.len(var_134_4)
				local var_134_7 = var_134_5 <= 0 and var_134_1 or var_134_1 * (var_134_6 / var_134_5)

				if var_134_7 > 0 and var_134_1 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_0
					end
				end

				arg_131_1.text_.text = var_134_4
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_8 = math.max(var_134_1, arg_131_1.talkMaxDuration)

			if var_134_0 <= arg_131_1.time_ and arg_131_1.time_ < var_134_0 + var_134_8 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_0) / var_134_8

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_0 + var_134_8 and arg_131_1.time_ < var_134_0 + var_134_8 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play1103404033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 1103404033
		arg_135_1.duration_ = 6.37

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play1103404034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1034ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1034ui_story == nil then
				arg_135_1.var_.characterEffect1034ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 and not isNil(var_138_0) then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect1034ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1034ui_story then
				arg_135_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_138_4 = 0

			if var_138_4 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action4_1")
			end

			local var_138_5 = 0

			if var_138_5 < arg_135_1.time_ and arg_135_1.time_ <= var_138_5 + arg_138_0 then
				arg_135_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_138_6 = 0
			local var_138_7 = 0.725

			if var_138_6 < arg_135_1.time_ and arg_135_1.time_ <= var_138_6 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_8 = arg_135_1:FormatText(StoryNameCfg[1109].name)

				arg_135_1.leftNameTxt_.text = var_138_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_9 = arg_135_1:GetWordFromCfg(1103404033)
				local var_138_10 = arg_135_1:FormatText(var_138_9.content)

				arg_135_1.text_.text = var_138_10

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_11 = 29
				local var_138_12 = utf8.len(var_138_10)
				local var_138_13 = var_138_11 <= 0 and var_138_7 or var_138_7 * (var_138_12 / var_138_11)

				if var_138_13 > 0 and var_138_7 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_6
					end
				end

				arg_135_1.text_.text = var_138_10
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404033", "story_v_side_new_1103404.awb") ~= 0 then
					local var_138_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404033", "story_v_side_new_1103404.awb") / 1000

					if var_138_14 + var_138_6 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_6
					end

					if var_138_9.prefab_name ~= "" and arg_135_1.actors_[var_138_9.prefab_name] ~= nil then
						local var_138_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_9.prefab_name].transform, "story_v_side_new_1103404", "1103404033", "story_v_side_new_1103404.awb")

						arg_135_1:RecordAudio("1103404033", var_138_15)
						arg_135_1:RecordAudio("1103404033", var_138_15)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404033", "story_v_side_new_1103404.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404033", "story_v_side_new_1103404.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = math.max(var_138_7, arg_135_1.talkMaxDuration)

			if var_138_6 <= arg_135_1.time_ and arg_135_1.time_ < var_138_6 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_6) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_6 + var_138_16 and arg_135_1.time_ < var_138_6 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play1103404034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1103404034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1103404035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1034ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1034ui_story == nil then
				arg_139_1.var_.characterEffect1034ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 and not isNil(var_142_0) then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect1034ui_story and not isNil(var_142_0) then
					local var_142_4 = Mathf.Lerp(0, 0.5, var_142_3)

					arg_139_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1034ui_story.fillRatio = var_142_4
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and not isNil(var_142_0) and arg_139_1.var_.characterEffect1034ui_story then
				local var_142_5 = 0.5

				arg_139_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1034ui_story.fillRatio = var_142_5
			end

			local var_142_6 = 0
			local var_142_7 = 0.35

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_8 = arg_139_1:FormatText(StoryNameCfg[7].name)

				arg_139_1.leftNameTxt_.text = var_142_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, true)
				arg_139_1.iconController_:SetSelectedState("hero")

				arg_139_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_139_1.callingController_:SetSelectedState("normal")

				arg_139_1.keyicon_.color = Color.New(1, 1, 1)
				arg_139_1.icon_.color = Color.New(1, 1, 1)

				local var_142_9 = arg_139_1:GetWordFromCfg(1103404034)
				local var_142_10 = arg_139_1:FormatText(var_142_9.content)

				arg_139_1.text_.text = var_142_10

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_11 = 14
				local var_142_12 = utf8.len(var_142_10)
				local var_142_13 = var_142_11 <= 0 and var_142_7 or var_142_7 * (var_142_12 / var_142_11)

				if var_142_13 > 0 and var_142_7 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_6 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_6
					end
				end

				arg_139_1.text_.text = var_142_10
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_14 = math.max(var_142_7, arg_139_1.talkMaxDuration)

			if var_142_6 <= arg_139_1.time_ and arg_139_1.time_ < var_142_6 + var_142_14 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_6) / var_142_14

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_6 + var_142_14 and arg_139_1.time_ < var_142_6 + var_142_14 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play1103404035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1103404035
		arg_143_1.duration_ = 3.37

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1103404036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1034ui_story"]
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1034ui_story == nil then
				arg_143_1.var_.characterEffect1034ui_story = var_146_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 and not isNil(var_146_0) then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2

				if arg_143_1.var_.characterEffect1034ui_story and not isNil(var_146_0) then
					arg_143_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 and not isNil(var_146_0) and arg_143_1.var_.characterEffect1034ui_story then
				arg_143_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_146_4 = 0

			if var_146_4 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action447")
			end

			local var_146_5 = 0

			if var_146_5 < arg_143_1.time_ and arg_143_1.time_ <= var_146_5 + arg_146_0 then
				arg_143_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_146_6 = 0
			local var_146_7 = 0.375

			if var_146_6 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_8 = arg_143_1:FormatText(StoryNameCfg[1109].name)

				arg_143_1.leftNameTxt_.text = var_146_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_9 = arg_143_1:GetWordFromCfg(1103404035)
				local var_146_10 = arg_143_1:FormatText(var_146_9.content)

				arg_143_1.text_.text = var_146_10

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_11 = 15
				local var_146_12 = utf8.len(var_146_10)
				local var_146_13 = var_146_11 <= 0 and var_146_7 or var_146_7 * (var_146_12 / var_146_11)

				if var_146_13 > 0 and var_146_7 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_10
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404035", "story_v_side_new_1103404.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404035", "story_v_side_new_1103404.awb") / 1000

					if var_146_14 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_6
					end

					if var_146_9.prefab_name ~= "" and arg_143_1.actors_[var_146_9.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_9.prefab_name].transform, "story_v_side_new_1103404", "1103404035", "story_v_side_new_1103404.awb")

						arg_143_1:RecordAudio("1103404035", var_146_15)
						arg_143_1:RecordAudio("1103404035", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404035", "story_v_side_new_1103404.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404035", "story_v_side_new_1103404.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_16 and arg_143_1.time_ < var_146_6 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play1103404036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1103404036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1103404037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["1034ui_story"]
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1034ui_story == nil then
				arg_147_1.var_.characterEffect1034ui_story = var_150_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 and not isNil(var_150_0) then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2

				if arg_147_1.var_.characterEffect1034ui_story and not isNil(var_150_0) then
					local var_150_4 = Mathf.Lerp(0, 0.5, var_150_3)

					arg_147_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1034ui_story.fillRatio = var_150_4
				end
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 and not isNil(var_150_0) and arg_147_1.var_.characterEffect1034ui_story then
				local var_150_5 = 0.5

				arg_147_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1034ui_story.fillRatio = var_150_5
			end

			local var_150_6 = 0
			local var_150_7 = 0.7

			if var_150_6 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_8 = arg_147_1:FormatText(StoryNameCfg[7].name)

				arg_147_1.leftNameTxt_.text = var_150_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_9 = arg_147_1:GetWordFromCfg(1103404036)
				local var_150_10 = arg_147_1:FormatText(var_150_9.content)

				arg_147_1.text_.text = var_150_10

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_11 = 28
				local var_150_12 = utf8.len(var_150_10)
				local var_150_13 = var_150_11 <= 0 and var_150_7 or var_150_7 * (var_150_12 / var_150_11)

				if var_150_13 > 0 and var_150_7 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_10
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_14 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_14 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_14

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_14 and arg_147_1.time_ < var_150_6 + var_150_14 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play1103404037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 1103404037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play1103404038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_154_2 = 0
			local var_154_3 = 0.525

			if var_154_2 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_4 = arg_151_1:FormatText(StoryNameCfg[7].name)

				arg_151_1.leftNameTxt_.text = var_154_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_5 = arg_151_1:GetWordFromCfg(1103404037)
				local var_154_6 = arg_151_1:FormatText(var_154_5.content)

				arg_151_1.text_.text = var_154_6

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_7 = 21
				local var_154_8 = utf8.len(var_154_6)
				local var_154_9 = var_154_7 <= 0 and var_154_3 or var_154_3 * (var_154_8 / var_154_7)

				if var_154_9 > 0 and var_154_3 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_6
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_10 and arg_151_1.time_ < var_154_2 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play1103404038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1103404038
		arg_155_1.duration_ = 6.27

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1103404039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["1034ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1034ui_story == nil then
				arg_155_1.var_.characterEffect1034ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 and not isNil(var_158_0) then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect1034ui_story and not isNil(var_158_0) then
					arg_155_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and not isNil(var_158_0) and arg_155_1.var_.characterEffect1034ui_story then
				arg_155_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_158_4 = 0

			if var_158_4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			local var_158_5 = 0

			if var_158_5 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 then
				arg_155_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_158_6 = 0
			local var_158_7 = 0.6

			if var_158_6 < arg_155_1.time_ and arg_155_1.time_ <= var_158_6 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_8 = arg_155_1:FormatText(StoryNameCfg[1109].name)

				arg_155_1.leftNameTxt_.text = var_158_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_9 = arg_155_1:GetWordFromCfg(1103404038)
				local var_158_10 = arg_155_1:FormatText(var_158_9.content)

				arg_155_1.text_.text = var_158_10

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_11 = 24
				local var_158_12 = utf8.len(var_158_10)
				local var_158_13 = var_158_11 <= 0 and var_158_7 or var_158_7 * (var_158_12 / var_158_11)

				if var_158_13 > 0 and var_158_7 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_6
					end
				end

				arg_155_1.text_.text = var_158_10
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404038", "story_v_side_new_1103404.awb") ~= 0 then
					local var_158_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404038", "story_v_side_new_1103404.awb") / 1000

					if var_158_14 + var_158_6 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_14 + var_158_6
					end

					if var_158_9.prefab_name ~= "" and arg_155_1.actors_[var_158_9.prefab_name] ~= nil then
						local var_158_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_9.prefab_name].transform, "story_v_side_new_1103404", "1103404038", "story_v_side_new_1103404.awb")

						arg_155_1:RecordAudio("1103404038", var_158_15)
						arg_155_1:RecordAudio("1103404038", var_158_15)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404038", "story_v_side_new_1103404.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404038", "story_v_side_new_1103404.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_16 = math.max(var_158_7, arg_155_1.talkMaxDuration)

			if var_158_6 <= arg_155_1.time_ and arg_155_1.time_ < var_158_6 + var_158_16 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_6) / var_158_16

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_6 + var_158_16 and arg_155_1.time_ < var_158_6 + var_158_16 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1103404039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1103404039
		arg_159_1.duration_ = 5.1

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1103404040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action426", "EmotionTimelineAnimator")
			end

			local var_162_2 = 0
			local var_162_3 = 0.675

			if var_162_2 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_4 = arg_159_1:FormatText(StoryNameCfg[1109].name)

				arg_159_1.leftNameTxt_.text = var_162_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_5 = arg_159_1:GetWordFromCfg(1103404039)
				local var_162_6 = arg_159_1:FormatText(var_162_5.content)

				arg_159_1.text_.text = var_162_6

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 27
				local var_162_8 = utf8.len(var_162_6)
				local var_162_9 = var_162_7 <= 0 and var_162_3 or var_162_3 * (var_162_8 / var_162_7)

				if var_162_9 > 0 and var_162_3 < var_162_9 then
					arg_159_1.talkMaxDuration = var_162_9

					if var_162_9 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_9 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_6
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404039", "story_v_side_new_1103404.awb") ~= 0 then
					local var_162_10 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404039", "story_v_side_new_1103404.awb") / 1000

					if var_162_10 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_10 + var_162_2
					end

					if var_162_5.prefab_name ~= "" and arg_159_1.actors_[var_162_5.prefab_name] ~= nil then
						local var_162_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_5.prefab_name].transform, "story_v_side_new_1103404", "1103404039", "story_v_side_new_1103404.awb")

						arg_159_1:RecordAudio("1103404039", var_162_11)
						arg_159_1:RecordAudio("1103404039", var_162_11)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404039", "story_v_side_new_1103404.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404039", "story_v_side_new_1103404.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_12 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_12 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_12

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_12 and arg_159_1.time_ < var_162_2 + var_162_12 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play1103404040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1103404040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1103404041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1034ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1034ui_story == nil then
				arg_163_1.var_.characterEffect1034ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1034ui_story and not isNil(var_166_0) then
					local var_166_4 = Mathf.Lerp(0, 0.5, var_166_3)

					arg_163_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1034ui_story.fillRatio = var_166_4
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1034ui_story then
				local var_166_5 = 0.5

				arg_163_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1034ui_story.fillRatio = var_166_5
			end

			local var_166_6 = 0
			local var_166_7 = 0.95

			if var_166_6 < arg_163_1.time_ and arg_163_1.time_ <= var_166_6 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_8 = arg_163_1:FormatText(StoryNameCfg[7].name)

				arg_163_1.leftNameTxt_.text = var_166_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_9 = arg_163_1:GetWordFromCfg(1103404040)
				local var_166_10 = arg_163_1:FormatText(var_166_9.content)

				arg_163_1.text_.text = var_166_10

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 38
				local var_166_12 = utf8.len(var_166_10)
				local var_166_13 = var_166_11 <= 0 and var_166_7 or var_166_7 * (var_166_12 / var_166_11)

				if var_166_13 > 0 and var_166_7 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_6 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_6
					end
				end

				arg_163_1.text_.text = var_166_10
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_7, arg_163_1.talkMaxDuration)

			if var_166_6 <= arg_163_1.time_ and arg_163_1.time_ < var_166_6 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_6) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_6 + var_166_14 and arg_163_1.time_ < var_166_6 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play1103404041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1103404041
		arg_167_1.duration_ = 6.63

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1103404042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1034ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1034ui_story == nil then
				arg_167_1.var_.characterEffect1034ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect1034ui_story and not isNil(var_170_0) then
					arg_167_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1034ui_story then
				arg_167_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_170_4 = 0

			if var_170_4 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action467")
			end

			local var_170_5 = 0

			if var_170_5 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_170_6 = 0
			local var_170_7 = 1.05

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_8 = arg_167_1:FormatText(StoryNameCfg[1109].name)

				arg_167_1.leftNameTxt_.text = var_170_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_9 = arg_167_1:GetWordFromCfg(1103404041)
				local var_170_10 = arg_167_1:FormatText(var_170_9.content)

				arg_167_1.text_.text = var_170_10

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 42
				local var_170_12 = utf8.len(var_170_10)
				local var_170_13 = var_170_11 <= 0 and var_170_7 or var_170_7 * (var_170_12 / var_170_11)

				if var_170_13 > 0 and var_170_7 < var_170_13 then
					arg_167_1.talkMaxDuration = var_170_13

					if var_170_13 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_13 + var_170_6
					end
				end

				arg_167_1.text_.text = var_170_10
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404041", "story_v_side_new_1103404.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404041", "story_v_side_new_1103404.awb") / 1000

					if var_170_14 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_6
					end

					if var_170_9.prefab_name ~= "" and arg_167_1.actors_[var_170_9.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_9.prefab_name].transform, "story_v_side_new_1103404", "1103404041", "story_v_side_new_1103404.awb")

						arg_167_1:RecordAudio("1103404041", var_170_15)
						arg_167_1:RecordAudio("1103404041", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404041", "story_v_side_new_1103404.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404041", "story_v_side_new_1103404.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_16 = math.max(var_170_7, arg_167_1.talkMaxDuration)

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_16 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_6) / var_170_16

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_6 + var_170_16 and arg_167_1.time_ < var_170_6 + var_170_16 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play1103404042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1103404042
		arg_171_1.duration_ = 4.4

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1103404043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiB", "EmotionTimelineAnimator")
			end

			local var_174_1 = 0
			local var_174_2 = 0.475

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_3 = arg_171_1:FormatText(StoryNameCfg[1109].name)

				arg_171_1.leftNameTxt_.text = var_174_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_4 = arg_171_1:GetWordFromCfg(1103404042)
				local var_174_5 = arg_171_1:FormatText(var_174_4.content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_6 = 19
				local var_174_7 = utf8.len(var_174_5)
				local var_174_8 = var_174_6 <= 0 and var_174_2 or var_174_2 * (var_174_7 / var_174_6)

				if var_174_8 > 0 and var_174_2 < var_174_8 then
					arg_171_1.talkMaxDuration = var_174_8

					if var_174_8 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_1
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404042", "story_v_side_new_1103404.awb") ~= 0 then
					local var_174_9 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404042", "story_v_side_new_1103404.awb") / 1000

					if var_174_9 + var_174_1 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_1
					end

					if var_174_4.prefab_name ~= "" and arg_171_1.actors_[var_174_4.prefab_name] ~= nil then
						local var_174_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_4.prefab_name].transform, "story_v_side_new_1103404", "1103404042", "story_v_side_new_1103404.awb")

						arg_171_1:RecordAudio("1103404042", var_174_10)
						arg_171_1:RecordAudio("1103404042", var_174_10)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404042", "story_v_side_new_1103404.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404042", "story_v_side_new_1103404.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_11 = math.max(var_174_2, arg_171_1.talkMaxDuration)

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_11 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_1) / var_174_11

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_1 + var_174_11 and arg_171_1.time_ < var_174_1 + var_174_11 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1103404043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1103404043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1103404044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1034ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1034ui_story == nil then
				arg_175_1.var_.characterEffect1034ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1034ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1034ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1034ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1034ui_story.fillRatio = var_178_5
			end

			local var_178_6 = 0

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_178_7 = 0
			local var_178_8 = 0.45

			if var_178_7 < arg_175_1.time_ and arg_175_1.time_ <= var_178_7 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_9 = arg_175_1:FormatText(StoryNameCfg[7].name)

				arg_175_1.leftNameTxt_.text = var_178_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_10 = arg_175_1:GetWordFromCfg(1103404043)
				local var_178_11 = arg_175_1:FormatText(var_178_10.content)

				arg_175_1.text_.text = var_178_11

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_12 = 18
				local var_178_13 = utf8.len(var_178_11)
				local var_178_14 = var_178_12 <= 0 and var_178_8 or var_178_8 * (var_178_13 / var_178_12)

				if var_178_14 > 0 and var_178_8 < var_178_14 then
					arg_175_1.talkMaxDuration = var_178_14

					if var_178_14 + var_178_7 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_14 + var_178_7
					end
				end

				arg_175_1.text_.text = var_178_11
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_15 = math.max(var_178_8, arg_175_1.talkMaxDuration)

			if var_178_7 <= arg_175_1.time_ and arg_175_1.time_ < var_178_7 + var_178_15 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_7) / var_178_15

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_7 + var_178_15 and arg_175_1.time_ < var_178_7 + var_178_15 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play1103404044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1103404044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1103404045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0

			if var_182_0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_0 + arg_182_0 then
				arg_179_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_182_2 = 0
			local var_182_3 = 1.075

			if var_182_2 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_4 = arg_179_1:FormatText(StoryNameCfg[7].name)

				arg_179_1.leftNameTxt_.text = var_182_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_5 = arg_179_1:GetWordFromCfg(1103404044)
				local var_182_6 = arg_179_1:FormatText(var_182_5.content)

				arg_179_1.text_.text = var_182_6

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_7 = 43
				local var_182_8 = utf8.len(var_182_6)
				local var_182_9 = var_182_7 <= 0 and var_182_3 or var_182_3 * (var_182_8 / var_182_7)

				if var_182_9 > 0 and var_182_3 < var_182_9 then
					arg_179_1.talkMaxDuration = var_182_9

					if var_182_9 + var_182_2 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_9 + var_182_2
					end
				end

				arg_179_1.text_.text = var_182_6
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_10 = math.max(var_182_3, arg_179_1.talkMaxDuration)

			if var_182_2 <= arg_179_1.time_ and arg_179_1.time_ < var_182_2 + var_182_10 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_2) / var_182_10

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_2 + var_182_10 and arg_179_1.time_ < var_182_2 + var_182_10 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play1103404045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1103404045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1103404046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0
			local var_186_1 = 0.975

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_2 = arg_183_1:FormatText(StoryNameCfg[7].name)

				arg_183_1.leftNameTxt_.text = var_186_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_3 = arg_183_1:GetWordFromCfg(1103404045)
				local var_186_4 = arg_183_1:FormatText(var_186_3.content)

				arg_183_1.text_.text = var_186_4

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 39
				local var_186_6 = utf8.len(var_186_4)
				local var_186_7 = var_186_5 <= 0 and var_186_1 or var_186_1 * (var_186_6 / var_186_5)

				if var_186_7 > 0 and var_186_1 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_0 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_0
					end
				end

				arg_183_1.text_.text = var_186_4
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_8 = math.max(var_186_1, arg_183_1.talkMaxDuration)

			if var_186_0 <= arg_183_1.time_ and arg_183_1.time_ < var_186_0 + var_186_8 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_0) / var_186_8

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_0 + var_186_8 and arg_183_1.time_ < var_186_0 + var_186_8 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play1103404046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1103404046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1103404047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0

			if var_190_0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_0 + arg_190_0 then
				arg_187_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_190_2 = 0
			local var_190_3 = 1.15

			if var_190_2 < arg_187_1.time_ and arg_187_1.time_ <= var_190_2 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_4 = arg_187_1:GetWordFromCfg(1103404046)
				local var_190_5 = arg_187_1:FormatText(var_190_4.content)

				arg_187_1.text_.text = var_190_5

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_6 = 46
				local var_190_7 = utf8.len(var_190_5)
				local var_190_8 = var_190_6 <= 0 and var_190_3 or var_190_3 * (var_190_7 / var_190_6)

				if var_190_8 > 0 and var_190_3 < var_190_8 then
					arg_187_1.talkMaxDuration = var_190_8

					if var_190_8 + var_190_2 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_8 + var_190_2
					end
				end

				arg_187_1.text_.text = var_190_5
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_9 = math.max(var_190_3, arg_187_1.talkMaxDuration)

			if var_190_2 <= arg_187_1.time_ and arg_187_1.time_ < var_190_2 + var_190_9 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_2) / var_190_9

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_2 + var_190_9 and arg_187_1.time_ < var_190_2 + var_190_9 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1103404047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1103404047
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1103404048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.15

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[7].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(1103404047)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 6
				local var_194_6 = utf8.len(var_194_4)
				local var_194_7 = var_194_5 <= 0 and var_194_1 or var_194_1 * (var_194_6 / var_194_5)

				if var_194_7 > 0 and var_194_1 < var_194_7 then
					arg_191_1.talkMaxDuration = var_194_7

					if var_194_7 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_7 + var_194_0
					end
				end

				arg_191_1.text_.text = var_194_4
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)
				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_8 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_8 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_8

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_8 and arg_191_1.time_ < var_194_0 + var_194_8 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play1103404048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1103404048
		arg_195_1.duration_ = 2

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1103404049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1034ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1034ui_story == nil then
				arg_195_1.var_.characterEffect1034ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 and not isNil(var_198_0) then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect1034ui_story and not isNil(var_198_0) then
					arg_195_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and not isNil(var_198_0) and arg_195_1.var_.characterEffect1034ui_story then
				arg_195_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_198_4 = 0

			if var_198_4 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_198_5 = 0

			if var_198_5 < arg_195_1.time_ and arg_195_1.time_ <= var_198_5 + arg_198_0 then
				arg_195_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_2", "EmotionTimelineAnimator")
			end

			local var_198_6 = 0
			local var_198_7 = 0.1

			if var_198_6 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_8 = arg_195_1:FormatText(StoryNameCfg[1109].name)

				arg_195_1.leftNameTxt_.text = var_198_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_9 = arg_195_1:GetWordFromCfg(1103404048)
				local var_198_10 = arg_195_1:FormatText(var_198_9.content)

				arg_195_1.text_.text = var_198_10

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 4
				local var_198_12 = utf8.len(var_198_10)
				local var_198_13 = var_198_11 <= 0 and var_198_7 or var_198_7 * (var_198_12 / var_198_11)

				if var_198_13 > 0 and var_198_7 < var_198_13 then
					arg_195_1.talkMaxDuration = var_198_13

					if var_198_13 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_13 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_10
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404048", "story_v_side_new_1103404.awb") ~= 0 then
					local var_198_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404048", "story_v_side_new_1103404.awb") / 1000

					if var_198_14 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_14 + var_198_6
					end

					if var_198_9.prefab_name ~= "" and arg_195_1.actors_[var_198_9.prefab_name] ~= nil then
						local var_198_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_9.prefab_name].transform, "story_v_side_new_1103404", "1103404048", "story_v_side_new_1103404.awb")

						arg_195_1:RecordAudio("1103404048", var_198_15)
						arg_195_1:RecordAudio("1103404048", var_198_15)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404048", "story_v_side_new_1103404.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404048", "story_v_side_new_1103404.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_16 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_16 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_16

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_16 and arg_195_1.time_ < var_198_6 + var_198_16 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play1103404049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1103404049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1103404050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1034ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1034ui_story == nil then
				arg_199_1.var_.characterEffect1034ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1034ui_story and not isNil(var_202_0) then
					local var_202_4 = Mathf.Lerp(0, 0.5, var_202_3)

					arg_199_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1034ui_story.fillRatio = var_202_4
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1034ui_story then
				local var_202_5 = 0.5

				arg_199_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1034ui_story.fillRatio = var_202_5
			end

			local var_202_6 = 0
			local var_202_7 = 0.675

			if var_202_6 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_8 = arg_199_1:FormatText(StoryNameCfg[7].name)

				arg_199_1.leftNameTxt_.text = var_202_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_9 = arg_199_1:GetWordFromCfg(1103404049)
				local var_202_10 = arg_199_1:FormatText(var_202_9.content)

				arg_199_1.text_.text = var_202_10

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_11 = 27
				local var_202_12 = utf8.len(var_202_10)
				local var_202_13 = var_202_11 <= 0 and var_202_7 or var_202_7 * (var_202_12 / var_202_11)

				if var_202_13 > 0 and var_202_7 < var_202_13 then
					arg_199_1.talkMaxDuration = var_202_13

					if var_202_13 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_10
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_14 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_14 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_14

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_14 and arg_199_1.time_ < var_202_6 + var_202_14 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play1103404050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1103404050
		arg_203_1.duration_ = 5.93

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1103404051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1034ui_story"]
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1034ui_story == nil then
				arg_203_1.var_.characterEffect1034ui_story = var_206_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 and not isNil(var_206_0) then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2

				if arg_203_1.var_.characterEffect1034ui_story and not isNil(var_206_0) then
					arg_203_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 and not isNil(var_206_0) and arg_203_1.var_.characterEffect1034ui_story then
				arg_203_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_206_4 = 0

			if var_206_4 < arg_203_1.time_ and arg_203_1.time_ <= var_206_4 + arg_206_0 then
				arg_203_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			local var_206_5 = 0

			if var_206_5 < arg_203_1.time_ and arg_203_1.time_ <= var_206_5 + arg_206_0 then
				arg_203_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_206_6 = 0
			local var_206_7 = 0.65

			if var_206_6 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_8 = arg_203_1:FormatText(StoryNameCfg[1109].name)

				arg_203_1.leftNameTxt_.text = var_206_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_9 = arg_203_1:GetWordFromCfg(1103404050)
				local var_206_10 = arg_203_1:FormatText(var_206_9.content)

				arg_203_1.text_.text = var_206_10

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 26
				local var_206_12 = utf8.len(var_206_10)
				local var_206_13 = var_206_11 <= 0 and var_206_7 or var_206_7 * (var_206_12 / var_206_11)

				if var_206_13 > 0 and var_206_7 < var_206_13 then
					arg_203_1.talkMaxDuration = var_206_13

					if var_206_13 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_13 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_10
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404050", "story_v_side_new_1103404.awb") ~= 0 then
					local var_206_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404050", "story_v_side_new_1103404.awb") / 1000

					if var_206_14 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_14 + var_206_6
					end

					if var_206_9.prefab_name ~= "" and arg_203_1.actors_[var_206_9.prefab_name] ~= nil then
						local var_206_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_9.prefab_name].transform, "story_v_side_new_1103404", "1103404050", "story_v_side_new_1103404.awb")

						arg_203_1:RecordAudio("1103404050", var_206_15)
						arg_203_1:RecordAudio("1103404050", var_206_15)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404050", "story_v_side_new_1103404.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404050", "story_v_side_new_1103404.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_16 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_16 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_16

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_16 and arg_203_1.time_ < var_206_6 + var_206_16 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play1103404051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 1103404051
		arg_207_1.duration_ = 5.7

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play1103404052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_210_1 = 0
			local var_210_2 = 0.775

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_3 = arg_207_1:FormatText(StoryNameCfg[1109].name)

				arg_207_1.leftNameTxt_.text = var_210_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_4 = arg_207_1:GetWordFromCfg(1103404051)
				local var_210_5 = arg_207_1:FormatText(var_210_4.content)

				arg_207_1.text_.text = var_210_5

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_6 = 31
				local var_210_7 = utf8.len(var_210_5)
				local var_210_8 = var_210_6 <= 0 and var_210_2 or var_210_2 * (var_210_7 / var_210_6)

				if var_210_8 > 0 and var_210_2 < var_210_8 then
					arg_207_1.talkMaxDuration = var_210_8

					if var_210_8 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_1
					end
				end

				arg_207_1.text_.text = var_210_5
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404051", "story_v_side_new_1103404.awb") ~= 0 then
					local var_210_9 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404051", "story_v_side_new_1103404.awb") / 1000

					if var_210_9 + var_210_1 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_1
					end

					if var_210_4.prefab_name ~= "" and arg_207_1.actors_[var_210_4.prefab_name] ~= nil then
						local var_210_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_4.prefab_name].transform, "story_v_side_new_1103404", "1103404051", "story_v_side_new_1103404.awb")

						arg_207_1:RecordAudio("1103404051", var_210_10)
						arg_207_1:RecordAudio("1103404051", var_210_10)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404051", "story_v_side_new_1103404.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404051", "story_v_side_new_1103404.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_11 = math.max(var_210_2, arg_207_1.talkMaxDuration)

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_11 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_1) / var_210_11

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_1 + var_210_11 and arg_207_1.time_ < var_210_1 + var_210_11 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play1103404052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 1103404052
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play1103404053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["1034ui_story"]
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1034ui_story == nil then
				arg_211_1.var_.characterEffect1034ui_story = var_214_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.2

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 and not isNil(var_214_0) then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2

				if arg_211_1.var_.characterEffect1034ui_story and not isNil(var_214_0) then
					local var_214_4 = Mathf.Lerp(0, 0.5, var_214_3)

					arg_211_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1034ui_story.fillRatio = var_214_4
				end
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 and not isNil(var_214_0) and arg_211_1.var_.characterEffect1034ui_story then
				local var_214_5 = 0.5

				arg_211_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1034ui_story.fillRatio = var_214_5
			end

			local var_214_6 = 0

			if var_214_6 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			local var_214_7 = 0

			if var_214_7 < arg_211_1.time_ and arg_211_1.time_ <= var_214_7 + arg_214_0 then
				arg_211_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_214_8 = 0
			local var_214_9 = 1

			if var_214_8 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_10 = arg_211_1:FormatText(StoryNameCfg[7].name)

				arg_211_1.leftNameTxt_.text = var_214_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_11 = arg_211_1:GetWordFromCfg(1103404052)
				local var_214_12 = arg_211_1:FormatText(var_214_11.content)

				arg_211_1.text_.text = var_214_12

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_13 = 40
				local var_214_14 = utf8.len(var_214_12)
				local var_214_15 = var_214_13 <= 0 and var_214_9 or var_214_9 * (var_214_14 / var_214_13)

				if var_214_15 > 0 and var_214_9 < var_214_15 then
					arg_211_1.talkMaxDuration = var_214_15

					if var_214_15 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_15 + var_214_8
					end
				end

				arg_211_1.text_.text = var_214_12
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_16 = math.max(var_214_9, arg_211_1.talkMaxDuration)

			if var_214_8 <= arg_211_1.time_ and arg_211_1.time_ < var_214_8 + var_214_16 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_8) / var_214_16

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_8 + var_214_16 and arg_211_1.time_ < var_214_8 + var_214_16 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play1103404053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 1103404053
		arg_215_1.duration_ = 15.83

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play1103404054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["1034ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1034ui_story == nil then
				arg_215_1.var_.characterEffect1034ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 and not isNil(var_218_0) then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect1034ui_story and not isNil(var_218_0) then
					arg_215_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and not isNil(var_218_0) and arg_215_1.var_.characterEffect1034ui_story then
				arg_215_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_218_4 = 0

			if var_218_4 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			local var_218_5 = 0

			if var_218_5 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuyuC", "EmotionTimelineAnimator")
			end

			local var_218_6 = 0
			local var_218_7 = 1.4

			if var_218_6 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				local var_218_8 = arg_215_1:FormatText(StoryNameCfg[1109].name)

				arg_215_1.leftNameTxt_.text = var_218_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_9 = arg_215_1:GetWordFromCfg(1103404053)
				local var_218_10 = arg_215_1:FormatText(var_218_9.content)

				arg_215_1.text_.text = var_218_10

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_11 = 56
				local var_218_12 = utf8.len(var_218_10)
				local var_218_13 = var_218_11 <= 0 and var_218_7 or var_218_7 * (var_218_12 / var_218_11)

				if var_218_13 > 0 and var_218_7 < var_218_13 then
					arg_215_1.talkMaxDuration = var_218_13

					if var_218_13 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_13 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_10
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404053", "story_v_side_new_1103404.awb") ~= 0 then
					local var_218_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404053", "story_v_side_new_1103404.awb") / 1000

					if var_218_14 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_14 + var_218_6
					end

					if var_218_9.prefab_name ~= "" and arg_215_1.actors_[var_218_9.prefab_name] ~= nil then
						local var_218_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_9.prefab_name].transform, "story_v_side_new_1103404", "1103404053", "story_v_side_new_1103404.awb")

						arg_215_1:RecordAudio("1103404053", var_218_15)
						arg_215_1:RecordAudio("1103404053", var_218_15)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404053", "story_v_side_new_1103404.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404053", "story_v_side_new_1103404.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_16 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_16 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_16

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_16 and arg_215_1.time_ < var_218_6 + var_218_16 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play1103404054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 1103404054
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play1103404055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["1034ui_story"]
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1034ui_story == nil then
				arg_219_1.var_.characterEffect1034ui_story = var_222_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 and not isNil(var_222_0) then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2

				if arg_219_1.var_.characterEffect1034ui_story and not isNil(var_222_0) then
					local var_222_4 = Mathf.Lerp(0, 0.5, var_222_3)

					arg_219_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1034ui_story.fillRatio = var_222_4
				end
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 and not isNil(var_222_0) and arg_219_1.var_.characterEffect1034ui_story then
				local var_222_5 = 0.5

				arg_219_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1034ui_story.fillRatio = var_222_5
			end

			local var_222_6 = 0
			local var_222_7 = 0.375

			if var_222_6 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_8 = arg_219_1:FormatText(StoryNameCfg[7].name)

				arg_219_1.leftNameTxt_.text = var_222_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_9 = arg_219_1:GetWordFromCfg(1103404054)
				local var_222_10 = arg_219_1:FormatText(var_222_9.content)

				arg_219_1.text_.text = var_222_10

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 15
				local var_222_12 = utf8.len(var_222_10)
				local var_222_13 = var_222_11 <= 0 and var_222_7 or var_222_7 * (var_222_12 / var_222_11)

				if var_222_13 > 0 and var_222_7 < var_222_13 then
					arg_219_1.talkMaxDuration = var_222_13

					if var_222_13 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_13 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_10
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_14 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_14 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_14

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_14 and arg_219_1.time_ < var_222_6 + var_222_14 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play1103404055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 1103404055
		arg_223_1.duration_ = 2

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"

			SetActive(arg_223_1.choicesGo_, true)

			for iter_224_0, iter_224_1 in ipairs(arg_223_1.choices_) do
				local var_224_0 = iter_224_0 <= 3

				SetActive(iter_224_1.go, var_224_0)
			end

			arg_223_1.choices_[1].txt.text = arg_223_1:FormatText(StoryChoiceCfg[1461].name)
			arg_223_1.choices_[2].txt.text = arg_223_1:FormatText(StoryChoiceCfg[1462].name)
			arg_223_1.choices_[3].txt.text = arg_223_1:FormatText(StoryChoiceCfg[1463].name)
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play1103404056(arg_223_1)
			end

			if arg_225_0 == 2 then
				arg_223_0:Play1103404058(arg_223_1)
			end

			if arg_225_0 == 3 then
				arg_223_0:Play1103404060(arg_223_1)
			end

			arg_223_1:RecordChoiceLog(1103404055, 1461, 1462, 1463)
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0

			if var_226_0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_0 + arg_226_0 then
				arg_223_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_2")
			end

			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_226_2 = 0

			if var_226_2 < arg_223_1.time_ and arg_223_1.time_ <= var_226_2 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			local var_226_3 = 2

			if arg_223_1.time_ >= var_226_2 + var_226_3 and arg_223_1.time_ < var_226_2 + var_226_3 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play1103404056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 1103404056
		arg_227_1.duration_ = 3.27

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play1103404057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = arg_227_1.actors_["1034ui_story"]
			local var_230_1 = 0

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1034ui_story == nil then
				arg_227_1.var_.characterEffect1034ui_story = var_230_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if var_230_1 <= arg_227_1.time_ and arg_227_1.time_ < var_230_1 + var_230_2 and not isNil(var_230_0) then
				local var_230_3 = (arg_227_1.time_ - var_230_1) / var_230_2

				if arg_227_1.var_.characterEffect1034ui_story and not isNil(var_230_0) then
					arg_227_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= var_230_1 + var_230_2 and arg_227_1.time_ < var_230_1 + var_230_2 + arg_230_0 and not isNil(var_230_0) and arg_227_1.var_.characterEffect1034ui_story then
				arg_227_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_230_4 = 0

			if var_230_4 < arg_227_1.time_ and arg_227_1.time_ <= var_230_4 + arg_230_0 then
				arg_227_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action9_1")
			end

			local var_230_5 = 0

			if var_230_5 < arg_227_1.time_ and arg_227_1.time_ <= var_230_5 + arg_230_0 then
				arg_227_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_230_6 = 0
			local var_230_7 = 0.55

			if var_230_6 < arg_227_1.time_ and arg_227_1.time_ <= var_230_6 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_8 = arg_227_1:FormatText(StoryNameCfg[1109].name)

				arg_227_1.leftNameTxt_.text = var_230_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_9 = arg_227_1:GetWordFromCfg(1103404056)
				local var_230_10 = arg_227_1:FormatText(var_230_9.content)

				arg_227_1.text_.text = var_230_10

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_11 = 22
				local var_230_12 = utf8.len(var_230_10)
				local var_230_13 = var_230_11 <= 0 and var_230_7 or var_230_7 * (var_230_12 / var_230_11)

				if var_230_13 > 0 and var_230_7 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_6
					end
				end

				arg_227_1.text_.text = var_230_10
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404056", "story_v_side_new_1103404.awb") ~= 0 then
					local var_230_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404056", "story_v_side_new_1103404.awb") / 1000

					if var_230_14 + var_230_6 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_14 + var_230_6
					end

					if var_230_9.prefab_name ~= "" and arg_227_1.actors_[var_230_9.prefab_name] ~= nil then
						local var_230_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_9.prefab_name].transform, "story_v_side_new_1103404", "1103404056", "story_v_side_new_1103404.awb")

						arg_227_1:RecordAudio("1103404056", var_230_15)
						arg_227_1:RecordAudio("1103404056", var_230_15)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404056", "story_v_side_new_1103404.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404056", "story_v_side_new_1103404.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_16 = math.max(var_230_7, arg_227_1.talkMaxDuration)

			if var_230_6 <= arg_227_1.time_ and arg_227_1.time_ < var_230_6 + var_230_16 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_6) / var_230_16

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_6 + var_230_16 and arg_227_1.time_ < var_230_6 + var_230_16 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play1103404057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 1103404057
		arg_231_1.duration_ = 5.7

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play1103404062(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = 0

			if var_234_0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_0 + arg_234_0 then
				arg_231_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiB", "EmotionTimelineAnimator")
			end

			local var_234_1 = 0
			local var_234_2 = 0.75

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_3 = arg_231_1:FormatText(StoryNameCfg[1109].name)

				arg_231_1.leftNameTxt_.text = var_234_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_4 = arg_231_1:GetWordFromCfg(1103404057)
				local var_234_5 = arg_231_1:FormatText(var_234_4.content)

				arg_231_1.text_.text = var_234_5

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_6 = 30
				local var_234_7 = utf8.len(var_234_5)
				local var_234_8 = var_234_6 <= 0 and var_234_2 or var_234_2 * (var_234_7 / var_234_6)

				if var_234_8 > 0 and var_234_2 < var_234_8 then
					arg_231_1.talkMaxDuration = var_234_8

					if var_234_8 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_1
					end
				end

				arg_231_1.text_.text = var_234_5
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404057", "story_v_side_new_1103404.awb") ~= 0 then
					local var_234_9 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404057", "story_v_side_new_1103404.awb") / 1000

					if var_234_9 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_9 + var_234_1
					end

					if var_234_4.prefab_name ~= "" and arg_231_1.actors_[var_234_4.prefab_name] ~= nil then
						local var_234_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_4.prefab_name].transform, "story_v_side_new_1103404", "1103404057", "story_v_side_new_1103404.awb")

						arg_231_1:RecordAudio("1103404057", var_234_10)
						arg_231_1:RecordAudio("1103404057", var_234_10)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404057", "story_v_side_new_1103404.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404057", "story_v_side_new_1103404.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_11 = math.max(var_234_2, arg_231_1.talkMaxDuration)

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_11 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_1) / var_234_11

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_1 + var_234_11 and arg_231_1.time_ < var_234_1 + var_234_11 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play1103404062 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 1103404062
		arg_235_1.duration_ = 2.73

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play1103404063(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = 0

			if var_238_0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_0 + arg_238_0 then
				arg_235_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action9_2")
			end

			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_238_2 = 0
			local var_238_3 = 0.275

			if var_238_2 < arg_235_1.time_ and arg_235_1.time_ <= var_238_2 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_4 = arg_235_1:FormatText(StoryNameCfg[1109].name)

				arg_235_1.leftNameTxt_.text = var_238_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_5 = arg_235_1:GetWordFromCfg(1103404062)
				local var_238_6 = arg_235_1:FormatText(var_238_5.content)

				arg_235_1.text_.text = var_238_6

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_7 = 11
				local var_238_8 = utf8.len(var_238_6)
				local var_238_9 = var_238_7 <= 0 and var_238_3 or var_238_3 * (var_238_8 / var_238_7)

				if var_238_9 > 0 and var_238_3 < var_238_9 then
					arg_235_1.talkMaxDuration = var_238_9

					if var_238_9 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_9 + var_238_2
					end
				end

				arg_235_1.text_.text = var_238_6
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404062", "story_v_side_new_1103404.awb") ~= 0 then
					local var_238_10 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404062", "story_v_side_new_1103404.awb") / 1000

					if var_238_10 + var_238_2 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_10 + var_238_2
					end

					if var_238_5.prefab_name ~= "" and arg_235_1.actors_[var_238_5.prefab_name] ~= nil then
						local var_238_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_5.prefab_name].transform, "story_v_side_new_1103404", "1103404062", "story_v_side_new_1103404.awb")

						arg_235_1:RecordAudio("1103404062", var_238_11)
						arg_235_1:RecordAudio("1103404062", var_238_11)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404062", "story_v_side_new_1103404.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404062", "story_v_side_new_1103404.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_12 = math.max(var_238_3, arg_235_1.talkMaxDuration)

			if var_238_2 <= arg_235_1.time_ and arg_235_1.time_ < var_238_2 + var_238_12 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_2) / var_238_12

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_2 + var_238_12 and arg_235_1.time_ < var_238_2 + var_238_12 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play1103404063 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 1103404063
		arg_239_1.duration_ = 4.53

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play1103404064(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_242_1 = 0
			local var_242_2 = 0.65

			if var_242_1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_1 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_3 = arg_239_1:FormatText(StoryNameCfg[1109].name)

				arg_239_1.leftNameTxt_.text = var_242_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_4 = arg_239_1:GetWordFromCfg(1103404063)
				local var_242_5 = arg_239_1:FormatText(var_242_4.content)

				arg_239_1.text_.text = var_242_5

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_6 = 26
				local var_242_7 = utf8.len(var_242_5)
				local var_242_8 = var_242_6 <= 0 and var_242_2 or var_242_2 * (var_242_7 / var_242_6)

				if var_242_8 > 0 and var_242_2 < var_242_8 then
					arg_239_1.talkMaxDuration = var_242_8

					if var_242_8 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_1
					end
				end

				arg_239_1.text_.text = var_242_5
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404063", "story_v_side_new_1103404.awb") ~= 0 then
					local var_242_9 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404063", "story_v_side_new_1103404.awb") / 1000

					if var_242_9 + var_242_1 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_1
					end

					if var_242_4.prefab_name ~= "" and arg_239_1.actors_[var_242_4.prefab_name] ~= nil then
						local var_242_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_4.prefab_name].transform, "story_v_side_new_1103404", "1103404063", "story_v_side_new_1103404.awb")

						arg_239_1:RecordAudio("1103404063", var_242_10)
						arg_239_1:RecordAudio("1103404063", var_242_10)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404063", "story_v_side_new_1103404.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404063", "story_v_side_new_1103404.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_11 = math.max(var_242_2, arg_239_1.talkMaxDuration)

			if var_242_1 <= arg_239_1.time_ and arg_239_1.time_ < var_242_1 + var_242_11 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_1) / var_242_11

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_1 + var_242_11 and arg_239_1.time_ < var_242_1 + var_242_11 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play1103404064 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 1103404064
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play1103404065(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = arg_243_1.actors_["1034ui_story"]
			local var_246_1 = 0

			if var_246_1 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1034ui_story == nil then
				arg_243_1.var_.characterEffect1034ui_story = var_246_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_2 and not isNil(var_246_0) then
				local var_246_3 = (arg_243_1.time_ - var_246_1) / var_246_2

				if arg_243_1.var_.characterEffect1034ui_story and not isNil(var_246_0) then
					local var_246_4 = Mathf.Lerp(0, 0.5, var_246_3)

					arg_243_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1034ui_story.fillRatio = var_246_4
				end
			end

			if arg_243_1.time_ >= var_246_1 + var_246_2 and arg_243_1.time_ < var_246_1 + var_246_2 + arg_246_0 and not isNil(var_246_0) and arg_243_1.var_.characterEffect1034ui_story then
				local var_246_5 = 0.5

				arg_243_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1034ui_story.fillRatio = var_246_5
			end

			local var_246_6 = 0
			local var_246_7 = 0.15

			if var_246_6 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_8 = arg_243_1:FormatText(StoryNameCfg[7].name)

				arg_243_1.leftNameTxt_.text = var_246_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_9 = arg_243_1:GetWordFromCfg(1103404064)
				local var_246_10 = arg_243_1:FormatText(var_246_9.content)

				arg_243_1.text_.text = var_246_10

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_11 = 6
				local var_246_12 = utf8.len(var_246_10)
				local var_246_13 = var_246_11 <= 0 and var_246_7 or var_246_7 * (var_246_12 / var_246_11)

				if var_246_13 > 0 and var_246_7 < var_246_13 then
					arg_243_1.talkMaxDuration = var_246_13

					if var_246_13 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_13 + var_246_6
					end
				end

				arg_243_1.text_.text = var_246_10
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_14 = math.max(var_246_7, arg_243_1.talkMaxDuration)

			if var_246_6 <= arg_243_1.time_ and arg_243_1.time_ < var_246_6 + var_246_14 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_6) / var_246_14

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_6 + var_246_14 and arg_243_1.time_ < var_246_6 + var_246_14 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play1103404065 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 1103404065
		arg_247_1.duration_ = 4.4

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play1103404066(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["1034ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1034ui_story == nil then
				arg_247_1.var_.characterEffect1034ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 and not isNil(var_250_0) then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect1034ui_story and not isNil(var_250_0) then
					arg_247_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and not isNil(var_250_0) and arg_247_1.var_.characterEffect1034ui_story then
				arg_247_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_250_4 = 0

			if var_250_4 < arg_247_1.time_ and arg_247_1.time_ <= var_250_4 + arg_250_0 then
				arg_247_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			local var_250_5 = 0

			if var_250_5 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_250_6 = 0
			local var_250_7 = 0.775

			if var_250_6 < arg_247_1.time_ and arg_247_1.time_ <= var_250_6 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_8 = arg_247_1:FormatText(StoryNameCfg[1109].name)

				arg_247_1.leftNameTxt_.text = var_250_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_9 = arg_247_1:GetWordFromCfg(1103404065)
				local var_250_10 = arg_247_1:FormatText(var_250_9.content)

				arg_247_1.text_.text = var_250_10

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_11 = 31
				local var_250_12 = utf8.len(var_250_10)
				local var_250_13 = var_250_11 <= 0 and var_250_7 or var_250_7 * (var_250_12 / var_250_11)

				if var_250_13 > 0 and var_250_7 < var_250_13 then
					arg_247_1.talkMaxDuration = var_250_13

					if var_250_13 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_13 + var_250_6
					end
				end

				arg_247_1.text_.text = var_250_10
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404065", "story_v_side_new_1103404.awb") ~= 0 then
					local var_250_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404065", "story_v_side_new_1103404.awb") / 1000

					if var_250_14 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_14 + var_250_6
					end

					if var_250_9.prefab_name ~= "" and arg_247_1.actors_[var_250_9.prefab_name] ~= nil then
						local var_250_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_9.prefab_name].transform, "story_v_side_new_1103404", "1103404065", "story_v_side_new_1103404.awb")

						arg_247_1:RecordAudio("1103404065", var_250_15)
						arg_247_1:RecordAudio("1103404065", var_250_15)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404065", "story_v_side_new_1103404.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404065", "story_v_side_new_1103404.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_16 = math.max(var_250_7, arg_247_1.talkMaxDuration)

			if var_250_6 <= arg_247_1.time_ and arg_247_1.time_ < var_250_6 + var_250_16 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_6) / var_250_16

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_6 + var_250_16 and arg_247_1.time_ < var_250_6 + var_250_16 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play1103404066 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 1103404066
		arg_251_1.duration_ = 5

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play1103404067(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["1034ui_story"]
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1034ui_story == nil then
				arg_251_1.var_.characterEffect1034ui_story = var_254_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 and not isNil(var_254_0) then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2

				if arg_251_1.var_.characterEffect1034ui_story and not isNil(var_254_0) then
					local var_254_4 = Mathf.Lerp(0, 0.5, var_254_3)

					arg_251_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_251_1.var_.characterEffect1034ui_story.fillRatio = var_254_4
				end
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 and not isNil(var_254_0) and arg_251_1.var_.characterEffect1034ui_story then
				local var_254_5 = 0.5

				arg_251_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_251_1.var_.characterEffect1034ui_story.fillRatio = var_254_5
			end

			local var_254_6 = 0
			local var_254_7 = 0.5

			if var_254_6 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_8 = arg_251_1:FormatText(StoryNameCfg[7].name)

				arg_251_1.leftNameTxt_.text = var_254_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, true)
				arg_251_1.iconController_:SetSelectedState("hero")

				arg_251_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_251_1.callingController_:SetSelectedState("normal")

				arg_251_1.keyicon_.color = Color.New(1, 1, 1)
				arg_251_1.icon_.color = Color.New(1, 1, 1)

				local var_254_9 = arg_251_1:GetWordFromCfg(1103404066)
				local var_254_10 = arg_251_1:FormatText(var_254_9.content)

				arg_251_1.text_.text = var_254_10

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 20
				local var_254_12 = utf8.len(var_254_10)
				local var_254_13 = var_254_11 <= 0 and var_254_7 or var_254_7 * (var_254_12 / var_254_11)

				if var_254_13 > 0 and var_254_7 < var_254_13 then
					arg_251_1.talkMaxDuration = var_254_13

					if var_254_13 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_13 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_10
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)
				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_14 = math.max(var_254_7, arg_251_1.talkMaxDuration)

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_14 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_6) / var_254_14

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_6 + var_254_14 and arg_251_1.time_ < var_254_6 + var_254_14 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {}

		arg_251_1:InitPlayNodeList()
	end,
	Play1103404067 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 1103404067
		arg_255_1.duration_ = 8.38

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play1103404068(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = 0

			if var_258_0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_0 + arg_258_0 then
				arg_255_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action467")
			end

			local var_258_1 = 2.4

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 then
				arg_255_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action474")
			end

			local var_258_2 = 0

			if var_258_2 < arg_255_1.time_ and arg_255_1.time_ <= var_258_2 + arg_258_0 then
				arg_255_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_258_3 = 2.4

			if var_258_3 < arg_255_1.time_ and arg_255_1.time_ <= var_258_3 + arg_258_0 then
				arg_255_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_258_4 = 0

			if var_258_4 < arg_255_1.time_ and arg_255_1.time_ <= var_258_4 + arg_258_0 then
				arg_255_1.allBtn_.enabled = false
			end

			local var_258_5 = 3.375

			if arg_255_1.time_ >= var_258_4 + var_258_5 and arg_255_1.time_ < var_258_4 + var_258_5 + arg_258_0 then
				arg_255_1.allBtn_.enabled = true
			end

			if arg_255_1.frameCnt_ <= 1 then
				arg_255_1.dialog_:SetActive(false)
			end

			local var_258_6 = 3.375
			local var_258_7 = 1.025

			if var_258_6 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0

				arg_255_1.dialog_:SetActive(true)

				arg_255_1.dialogCg_.alpha = 0

				local var_258_8 = LeanTween.value(arg_255_1.dialog_, 0, 1, 0.3)

				var_258_8:setOnUpdate(LuaHelper.FloatAction(function(arg_259_0)
					arg_255_1.dialogCg_.alpha = arg_259_0
				end))
				var_258_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_255_1.dialog_)
					var_258_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_255_1.duration_ = arg_255_1.duration_ + 0.3

				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_9 = arg_255_1:GetWordFromCfg(1103404067)
				local var_258_10 = arg_255_1:FormatText(var_258_9.content)

				arg_255_1.text_.text = var_258_10

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_11 = 41
				local var_258_12 = utf8.len(var_258_10)
				local var_258_13 = var_258_11 <= 0 and var_258_7 or var_258_7 * (var_258_12 / var_258_11)

				if var_258_13 > 0 and var_258_7 < var_258_13 then
					arg_255_1.talkMaxDuration = var_258_13
					var_258_6 = var_258_6 + 0.3

					if var_258_13 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_13 + var_258_6
					end
				end

				arg_255_1.text_.text = var_258_10
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_14 = var_258_6 + 0.3
			local var_258_15 = math.max(var_258_7, arg_255_1.talkMaxDuration)

			if var_258_14 <= arg_255_1.time_ and arg_255_1.time_ < var_258_14 + var_258_15 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_14) / var_258_15

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_14 + var_258_15 and arg_255_1.time_ < var_258_14 + var_258_15 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {}

		arg_255_1:InitPlayNodeList()
	end,
	Play1103404068 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1103404068
		arg_261_1.duration_ = 4.2

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1103404069(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1034ui_story"]
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1034ui_story == nil then
				arg_261_1.var_.characterEffect1034ui_story = var_264_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_2 = 0.200000002980232

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 and not isNil(var_264_0) then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2

				if arg_261_1.var_.characterEffect1034ui_story and not isNil(var_264_0) then
					arg_261_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 and not isNil(var_264_0) and arg_261_1.var_.characterEffect1034ui_story then
				arg_261_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_264_4 = 0
			local var_264_5 = 0.425

			if var_264_4 < arg_261_1.time_ and arg_261_1.time_ <= var_264_4 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_6 = arg_261_1:FormatText(StoryNameCfg[1109].name)

				arg_261_1.leftNameTxt_.text = var_264_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_7 = arg_261_1:GetWordFromCfg(1103404068)
				local var_264_8 = arg_261_1:FormatText(var_264_7.content)

				arg_261_1.text_.text = var_264_8

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_9 = 17
				local var_264_10 = utf8.len(var_264_8)
				local var_264_11 = var_264_9 <= 0 and var_264_5 or var_264_5 * (var_264_10 / var_264_9)

				if var_264_11 > 0 and var_264_5 < var_264_11 then
					arg_261_1.talkMaxDuration = var_264_11

					if var_264_11 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_11 + var_264_4
					end
				end

				arg_261_1.text_.text = var_264_8
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404068", "story_v_side_new_1103404.awb") ~= 0 then
					local var_264_12 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404068", "story_v_side_new_1103404.awb") / 1000

					if var_264_12 + var_264_4 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_12 + var_264_4
					end

					if var_264_7.prefab_name ~= "" and arg_261_1.actors_[var_264_7.prefab_name] ~= nil then
						local var_264_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_7.prefab_name].transform, "story_v_side_new_1103404", "1103404068", "story_v_side_new_1103404.awb")

						arg_261_1:RecordAudio("1103404068", var_264_13)
						arg_261_1:RecordAudio("1103404068", var_264_13)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404068", "story_v_side_new_1103404.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404068", "story_v_side_new_1103404.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_14 = math.max(var_264_5, arg_261_1.talkMaxDuration)

			if var_264_4 <= arg_261_1.time_ and arg_261_1.time_ < var_264_4 + var_264_14 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_4) / var_264_14

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_4 + var_264_14 and arg_261_1.time_ < var_264_4 + var_264_14 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play1103404069 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1103404069
		arg_265_1.duration_ = 7.93

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1103404070(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0

			if var_268_0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_0 + arg_268_0 then
				arg_265_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action4_2")
			end

			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 then
				arg_265_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_268_2 = 0
			local var_268_3 = 0.95

			if var_268_2 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_4 = arg_265_1:FormatText(StoryNameCfg[1109].name)

				arg_265_1.leftNameTxt_.text = var_268_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_5 = arg_265_1:GetWordFromCfg(1103404069)
				local var_268_6 = arg_265_1:FormatText(var_268_5.content)

				arg_265_1.text_.text = var_268_6

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_7 = 37
				local var_268_8 = utf8.len(var_268_6)
				local var_268_9 = var_268_7 <= 0 and var_268_3 or var_268_3 * (var_268_8 / var_268_7)

				if var_268_9 > 0 and var_268_3 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_2
					end
				end

				arg_265_1.text_.text = var_268_6
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404069", "story_v_side_new_1103404.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404069", "story_v_side_new_1103404.awb") / 1000

					if var_268_10 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_2
					end

					if var_268_5.prefab_name ~= "" and arg_265_1.actors_[var_268_5.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_5.prefab_name].transform, "story_v_side_new_1103404", "1103404069", "story_v_side_new_1103404.awb")

						arg_265_1:RecordAudio("1103404069", var_268_11)
						arg_265_1:RecordAudio("1103404069", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404069", "story_v_side_new_1103404.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404069", "story_v_side_new_1103404.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_3, arg_265_1.talkMaxDuration)

			if var_268_2 <= arg_265_1.time_ and arg_265_1.time_ < var_268_2 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_2) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_2 + var_268_12 and arg_265_1.time_ < var_268_2 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1103404070 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1103404070
		arg_269_1.duration_ = 8.67

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1103404071(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 0
			local var_272_1 = 1.05

			if var_272_0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_2 = arg_269_1:FormatText(StoryNameCfg[1109].name)

				arg_269_1.leftNameTxt_.text = var_272_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_3 = arg_269_1:GetWordFromCfg(1103404070)
				local var_272_4 = arg_269_1:FormatText(var_272_3.content)

				arg_269_1.text_.text = var_272_4

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 42
				local var_272_6 = utf8.len(var_272_4)
				local var_272_7 = var_272_5 <= 0 and var_272_1 or var_272_1 * (var_272_6 / var_272_5)

				if var_272_7 > 0 and var_272_1 < var_272_7 then
					arg_269_1.talkMaxDuration = var_272_7

					if var_272_7 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_7 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_4
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404070", "story_v_side_new_1103404.awb") ~= 0 then
					local var_272_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404070", "story_v_side_new_1103404.awb") / 1000

					if var_272_8 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_8 + var_272_0
					end

					if var_272_3.prefab_name ~= "" and arg_269_1.actors_[var_272_3.prefab_name] ~= nil then
						local var_272_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_3.prefab_name].transform, "story_v_side_new_1103404", "1103404070", "story_v_side_new_1103404.awb")

						arg_269_1:RecordAudio("1103404070", var_272_9)
						arg_269_1:RecordAudio("1103404070", var_272_9)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404070", "story_v_side_new_1103404.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404070", "story_v_side_new_1103404.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_10 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_10 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_10

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_10 and arg_269_1.time_ < var_272_0 + var_272_10 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play1103404071 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1103404071
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1103404072(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1034ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1034ui_story == nil then
				arg_273_1.var_.characterEffect1034ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1034ui_story and not isNil(var_276_0) then
					local var_276_4 = Mathf.Lerp(0, 0.5, var_276_3)

					arg_273_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1034ui_story.fillRatio = var_276_4
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1034ui_story then
				local var_276_5 = 0.5

				arg_273_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1034ui_story.fillRatio = var_276_5
			end

			local var_276_6 = 0
			local var_276_7 = 0.3

			if var_276_6 < arg_273_1.time_ and arg_273_1.time_ <= var_276_6 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				local var_276_8 = arg_273_1:FormatText(StoryNameCfg[7].name)

				arg_273_1.leftNameTxt_.text = var_276_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_9 = arg_273_1:GetWordFromCfg(1103404071)
				local var_276_10 = arg_273_1:FormatText(var_276_9.content)

				arg_273_1.text_.text = var_276_10

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 12
				local var_276_12 = utf8.len(var_276_10)
				local var_276_13 = var_276_11 <= 0 and var_276_7 or var_276_7 * (var_276_12 / var_276_11)

				if var_276_13 > 0 and var_276_7 < var_276_13 then
					arg_273_1.talkMaxDuration = var_276_13

					if var_276_13 + var_276_6 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_13 + var_276_6
					end
				end

				arg_273_1.text_.text = var_276_10
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_14 = math.max(var_276_7, arg_273_1.talkMaxDuration)

			if var_276_6 <= arg_273_1.time_ and arg_273_1.time_ < var_276_6 + var_276_14 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_6) / var_276_14

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_6 + var_276_14 and arg_273_1.time_ < var_276_6 + var_276_14 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play1103404072 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1103404072
		arg_277_1.duration_ = 3.1

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1103404073(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = arg_277_1.actors_["1034ui_story"]
			local var_280_1 = 0

			if var_280_1 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1034ui_story == nil then
				arg_277_1.var_.characterEffect1034ui_story = var_280_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_2 = 0.200000002980232

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_2 and not isNil(var_280_0) then
				local var_280_3 = (arg_277_1.time_ - var_280_1) / var_280_2

				if arg_277_1.var_.characterEffect1034ui_story and not isNil(var_280_0) then
					arg_277_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= var_280_1 + var_280_2 and arg_277_1.time_ < var_280_1 + var_280_2 + arg_280_0 and not isNil(var_280_0) and arg_277_1.var_.characterEffect1034ui_story then
				arg_277_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_280_4 = 0

			if var_280_4 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_1")
			end

			local var_280_5 = 0

			if var_280_5 < arg_277_1.time_ and arg_277_1.time_ <= var_280_5 + arg_280_0 then
				arg_277_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanR", "EmotionTimelineAnimator")
			end

			local var_280_6 = 0
			local var_280_7 = 0.375

			if var_280_6 < arg_277_1.time_ and arg_277_1.time_ <= var_280_6 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				local var_280_8 = arg_277_1:FormatText(StoryNameCfg[1109].name)

				arg_277_1.leftNameTxt_.text = var_280_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_9 = arg_277_1:GetWordFromCfg(1103404072)
				local var_280_10 = arg_277_1:FormatText(var_280_9.content)

				arg_277_1.text_.text = var_280_10

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_11 = 15
				local var_280_12 = utf8.len(var_280_10)
				local var_280_13 = var_280_11 <= 0 and var_280_7 or var_280_7 * (var_280_12 / var_280_11)

				if var_280_13 > 0 and var_280_7 < var_280_13 then
					arg_277_1.talkMaxDuration = var_280_13

					if var_280_13 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_13 + var_280_6
					end
				end

				arg_277_1.text_.text = var_280_10
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404072", "story_v_side_new_1103404.awb") ~= 0 then
					local var_280_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404072", "story_v_side_new_1103404.awb") / 1000

					if var_280_14 + var_280_6 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_14 + var_280_6
					end

					if var_280_9.prefab_name ~= "" and arg_277_1.actors_[var_280_9.prefab_name] ~= nil then
						local var_280_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_277_1.actors_[var_280_9.prefab_name].transform, "story_v_side_new_1103404", "1103404072", "story_v_side_new_1103404.awb")

						arg_277_1:RecordAudio("1103404072", var_280_15)
						arg_277_1:RecordAudio("1103404072", var_280_15)
					else
						arg_277_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404072", "story_v_side_new_1103404.awb")
					end

					arg_277_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404072", "story_v_side_new_1103404.awb")
				end

				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_16 = math.max(var_280_7, arg_277_1.talkMaxDuration)

			if var_280_6 <= arg_277_1.time_ and arg_277_1.time_ < var_280_6 + var_280_16 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_6) / var_280_16

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_6 + var_280_16 and arg_277_1.time_ < var_280_6 + var_280_16 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1103404073 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1103404073
		arg_281_1.duration_ = 9

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1103404074(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = "I11o"

			if arg_281_1.bgs_[var_284_0] == nil then
				local var_284_1 = Object.Instantiate(arg_281_1.paintGo_)

				var_284_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_284_0)
				var_284_1.name = var_284_0
				var_284_1.transform.parent = arg_281_1.stage_.transform
				var_284_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_281_1.bgs_[var_284_0] = var_284_1
			end

			local var_284_2 = 2

			if var_284_2 < arg_281_1.time_ and arg_281_1.time_ <= var_284_2 + arg_284_0 then
				local var_284_3 = manager.ui.mainCamera.transform.localPosition
				local var_284_4 = Vector3.New(0, 0, 10) + Vector3.New(var_284_3.x, var_284_3.y, 0)
				local var_284_5 = arg_281_1.bgs_.I11o

				var_284_5.transform.localPosition = var_284_4
				var_284_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_284_6 = var_284_5:GetComponent("SpriteRenderer")

				if var_284_6 and var_284_6.sprite then
					local var_284_7 = (var_284_5.transform.localPosition - var_284_3).z
					local var_284_8 = manager.ui.mainCameraCom_
					local var_284_9 = 2 * var_284_7 * Mathf.Tan(var_284_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_284_10 = var_284_9 * var_284_8.aspect
					local var_284_11 = var_284_6.sprite.bounds.size.x
					local var_284_12 = var_284_6.sprite.bounds.size.y
					local var_284_13 = var_284_10 / var_284_11
					local var_284_14 = var_284_9 / var_284_12
					local var_284_15 = var_284_14 < var_284_13 and var_284_13 or var_284_14

					var_284_5.transform.localScale = Vector3.New(var_284_15, var_284_15, 0)
				end

				for iter_284_0, iter_284_1 in pairs(arg_281_1.bgs_) do
					if iter_284_0 ~= "I11o" then
						iter_284_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_284_16 = 4

			if var_284_16 < arg_281_1.time_ and arg_281_1.time_ <= var_284_16 + arg_284_0 then
				arg_281_1.allBtn_.enabled = false
			end

			local var_284_17 = 0.3

			if arg_281_1.time_ >= var_284_16 + var_284_17 and arg_281_1.time_ < var_284_16 + var_284_17 + arg_284_0 then
				arg_281_1.allBtn_.enabled = true
			end

			local var_284_18 = 0

			if var_284_18 < arg_281_1.time_ and arg_281_1.time_ <= var_284_18 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_19 = 2

			if var_284_18 <= arg_281_1.time_ and arg_281_1.time_ < var_284_18 + var_284_19 then
				local var_284_20 = (arg_281_1.time_ - var_284_18) / var_284_19
				local var_284_21 = Color.New(0, 0, 0)

				var_284_21.a = Mathf.Lerp(0, 1, var_284_20)
				arg_281_1.mask_.color = var_284_21
			end

			if arg_281_1.time_ >= var_284_18 + var_284_19 and arg_281_1.time_ < var_284_18 + var_284_19 + arg_284_0 then
				local var_284_22 = Color.New(0, 0, 0)

				var_284_22.a = 1
				arg_281_1.mask_.color = var_284_22
			end

			local var_284_23 = 2

			if var_284_23 < arg_281_1.time_ and arg_281_1.time_ <= var_284_23 + arg_284_0 then
				arg_281_1.mask_.enabled = true
				arg_281_1.mask_.raycastTarget = true

				arg_281_1:SetGaussion(false)
			end

			local var_284_24 = 2

			if var_284_23 <= arg_281_1.time_ and arg_281_1.time_ < var_284_23 + var_284_24 then
				local var_284_25 = (arg_281_1.time_ - var_284_23) / var_284_24
				local var_284_26 = Color.New(0, 0, 0)

				var_284_26.a = Mathf.Lerp(1, 0, var_284_25)
				arg_281_1.mask_.color = var_284_26
			end

			if arg_281_1.time_ >= var_284_23 + var_284_24 and arg_281_1.time_ < var_284_23 + var_284_24 + arg_284_0 then
				local var_284_27 = Color.New(0, 0, 0)
				local var_284_28 = 0

				arg_281_1.mask_.enabled = false
				var_284_27.a = var_284_28
				arg_281_1.mask_.color = var_284_27
			end

			local var_284_29 = arg_281_1.actors_["1034ui_story"].transform
			local var_284_30 = 1.98333333333333

			if var_284_30 < arg_281_1.time_ and arg_281_1.time_ <= var_284_30 + arg_284_0 then
				arg_281_1.var_.moveOldPos1034ui_story = var_284_29.localPosition
			end

			local var_284_31 = 0.001

			if var_284_30 <= arg_281_1.time_ and arg_281_1.time_ < var_284_30 + var_284_31 then
				local var_284_32 = (arg_281_1.time_ - var_284_30) / var_284_31
				local var_284_33 = Vector3.New(0, 100, 0)

				var_284_29.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos1034ui_story, var_284_33, var_284_32)

				local var_284_34 = manager.ui.mainCamera.transform.position - var_284_29.position

				var_284_29.forward = Vector3.New(var_284_34.x, var_284_34.y, var_284_34.z)

				local var_284_35 = var_284_29.localEulerAngles

				var_284_35.z = 0
				var_284_35.x = 0
				var_284_29.localEulerAngles = var_284_35
			end

			if arg_281_1.time_ >= var_284_30 + var_284_31 and arg_281_1.time_ < var_284_30 + var_284_31 + arg_284_0 then
				var_284_29.localPosition = Vector3.New(0, 100, 0)

				local var_284_36 = manager.ui.mainCamera.transform.position - var_284_29.position

				var_284_29.forward = Vector3.New(var_284_36.x, var_284_36.y, var_284_36.z)

				local var_284_37 = var_284_29.localEulerAngles

				var_284_37.z = 0
				var_284_37.x = 0
				var_284_29.localEulerAngles = var_284_37
			end

			local var_284_38 = arg_281_1.actors_["1034ui_story"]
			local var_284_39 = 1.9

			if var_284_39 < arg_281_1.time_ and arg_281_1.time_ <= var_284_39 + arg_284_0 and not isNil(var_284_38) and arg_281_1.var_.characterEffect1034ui_story == nil then
				arg_281_1.var_.characterEffect1034ui_story = var_284_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_40 = 0.0833333333333335

			if var_284_39 <= arg_281_1.time_ and arg_281_1.time_ < var_284_39 + var_284_40 and not isNil(var_284_38) then
				local var_284_41 = (arg_281_1.time_ - var_284_39) / var_284_40

				if arg_281_1.var_.characterEffect1034ui_story and not isNil(var_284_38) then
					local var_284_42 = Mathf.Lerp(0, 0.5, var_284_41)

					arg_281_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1034ui_story.fillRatio = var_284_42
				end
			end

			if arg_281_1.time_ >= var_284_39 + var_284_40 and arg_281_1.time_ < var_284_39 + var_284_40 + arg_284_0 and not isNil(var_284_38) and arg_281_1.var_.characterEffect1034ui_story then
				local var_284_43 = 0.5

				arg_281_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1034ui_story.fillRatio = var_284_43
			end

			local var_284_44 = 0.133333333333333
			local var_284_45 = 0.3

			if var_284_44 < arg_281_1.time_ and arg_281_1.time_ <= var_284_44 + arg_284_0 then
				local var_284_46 = "play"
				local var_284_47 = "music"

				arg_281_1:AudioAction(var_284_46, var_284_47, "ui_battle", "ui_battle_stopbgm", "")

				local var_284_48 = ""
				local var_284_49 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_284_49 ~= "" then
					if arg_281_1.bgmTxt_.text ~= var_284_49 and arg_281_1.bgmTxt_.text ~= "" then
						if arg_281_1.bgmTxt2_.text ~= "" then
							arg_281_1.bgmTxt_.text = arg_281_1.bgmTxt2_.text
						end

						arg_281_1.bgmTxt2_.text = var_284_49

						arg_281_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_281_1.bgmTxt_.text = var_284_49
						arg_281_1.bgmTxt2_.text = var_284_49
					end

					if arg_281_1.bgmTimer then
						arg_281_1.bgmTimer:Stop()

						arg_281_1.bgmTimer = nil
					end

					if arg_281_1.settingData.show_music_name == 1 then
						arg_281_1.musicController:SetSelectedState("show")
						arg_281_1.musicAnimator_:Play("open", 0, 0)

						if arg_281_1.settingData.music_time ~= 0 then
							arg_281_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_281_1.settingData.music_time), function()
								if arg_281_1 == nil or isNil(arg_281_1.bgmTxt_) then
									return
								end

								arg_281_1.musicController:SetSelectedState("hide")
								arg_281_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_284_50 = 1.56666666666667
			local var_284_51 = 1

			if var_284_50 < arg_281_1.time_ and arg_281_1.time_ <= var_284_50 + arg_284_0 then
				local var_284_52 = "play"
				local var_284_53 = "music"

				arg_281_1:AudioAction(var_284_52, var_284_53, "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily.awb")

				local var_284_54 = ""
				local var_284_55 = manager.audio:GetAudioName("bgm_activity_3_10_story_daily", "bgm_activity_3_10_story_daily")

				if var_284_55 ~= "" then
					if arg_281_1.bgmTxt_.text ~= var_284_55 and arg_281_1.bgmTxt_.text ~= "" then
						if arg_281_1.bgmTxt2_.text ~= "" then
							arg_281_1.bgmTxt_.text = arg_281_1.bgmTxt2_.text
						end

						arg_281_1.bgmTxt2_.text = var_284_55

						arg_281_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_281_1.bgmTxt_.text = var_284_55
						arg_281_1.bgmTxt2_.text = var_284_55
					end

					if arg_281_1.bgmTimer then
						arg_281_1.bgmTimer:Stop()

						arg_281_1.bgmTimer = nil
					end

					if arg_281_1.settingData.show_music_name == 1 then
						arg_281_1.musicController:SetSelectedState("show")
						arg_281_1.musicAnimator_:Play("open", 0, 0)

						if arg_281_1.settingData.music_time ~= 0 then
							arg_281_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_281_1.settingData.music_time), function()
								if arg_281_1 == nil or isNil(arg_281_1.bgmTxt_) then
									return
								end

								arg_281_1.musicController:SetSelectedState("hide")
								arg_281_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_284_56 = 0.133333333333333
			local var_284_57 = 1

			if var_284_56 < arg_281_1.time_ and arg_281_1.time_ <= var_284_56 + arg_284_0 then
				local var_284_58 = "stop"
				local var_284_59 = "effect"

				arg_281_1:AudioAction(var_284_58, var_284_59, "se_story_1310", "se_story_1310_nightloop", "")
			end

			local var_284_60 = 1.56666666666667
			local var_284_61 = 1

			if var_284_60 < arg_281_1.time_ and arg_281_1.time_ <= var_284_60 + arg_284_0 then
				local var_284_62 = "play"
				local var_284_63 = "effect"

				arg_281_1:AudioAction(var_284_62, var_284_63, "se_story_16", "se_story_16_street_loop", "")
			end

			if arg_281_1.frameCnt_ <= 1 then
				arg_281_1.dialog_:SetActive(false)
			end

			local var_284_64 = 4
			local var_284_65 = 1.2

			if var_284_64 < arg_281_1.time_ and arg_281_1.time_ <= var_284_64 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0

				arg_281_1.dialog_:SetActive(true)

				arg_281_1.dialogCg_.alpha = 0

				local var_284_66 = LeanTween.value(arg_281_1.dialog_, 0, 1, 0.3)

				var_284_66:setOnUpdate(LuaHelper.FloatAction(function(arg_287_0)
					arg_281_1.dialogCg_.alpha = arg_287_0
				end))
				var_284_66:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_281_1.dialog_)
					var_284_66:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_281_1.duration_ = arg_281_1.duration_ + 0.3

				SetActive(arg_281_1.leftNameGo_, false)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_67 = arg_281_1:GetWordFromCfg(1103404073)
				local var_284_68 = arg_281_1:FormatText(var_284_67.content)

				arg_281_1.text_.text = var_284_68

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_69 = 48
				local var_284_70 = utf8.len(var_284_68)
				local var_284_71 = var_284_69 <= 0 and var_284_65 or var_284_65 * (var_284_70 / var_284_69)

				if var_284_71 > 0 and var_284_65 < var_284_71 then
					arg_281_1.talkMaxDuration = var_284_71
					var_284_64 = var_284_64 + 0.3

					if var_284_71 + var_284_64 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_71 + var_284_64
					end
				end

				arg_281_1.text_.text = var_284_68
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_72 = var_284_64 + 0.3
			local var_284_73 = math.max(var_284_65, arg_281_1.talkMaxDuration)

			if var_284_72 <= arg_281_1.time_ and arg_281_1.time_ < var_284_72 + var_284_73 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_72) / var_284_73

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_72 + var_284_73 and arg_281_1.time_ < var_284_72 + var_284_73 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_281_1:InitPlayNodeList()
	end,
	Play1103404074 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1103404074
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1103404075(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 1.25

			if var_292_0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_2 = arg_289_1:GetWordFromCfg(1103404074)
				local var_292_3 = arg_289_1:FormatText(var_292_2.content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 50
				local var_292_5 = utf8.len(var_292_3)
				local var_292_6 = var_292_4 <= 0 and var_292_1 or var_292_1 * (var_292_5 / var_292_4)

				if var_292_6 > 0 and var_292_1 < var_292_6 then
					arg_289_1.talkMaxDuration = var_292_6

					if var_292_6 + var_292_0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_6 + var_292_0
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_1, arg_289_1.talkMaxDuration)

			if var_292_0 <= arg_289_1.time_ and arg_289_1.time_ < var_292_0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_0 + var_292_7 and arg_289_1.time_ < var_292_0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play1103404075 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1103404075
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1103404076(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0
			local var_296_1 = 1.3

			if var_296_0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_2 = arg_293_1:GetWordFromCfg(1103404075)
				local var_296_3 = arg_293_1:FormatText(var_296_2.content)

				arg_293_1.text_.text = var_296_3

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 52
				local var_296_5 = utf8.len(var_296_3)
				local var_296_6 = var_296_4 <= 0 and var_296_1 or var_296_1 * (var_296_5 / var_296_4)

				if var_296_6 > 0 and var_296_1 < var_296_6 then
					arg_293_1.talkMaxDuration = var_296_6

					if var_296_6 + var_296_0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_6 + var_296_0
					end
				end

				arg_293_1.text_.text = var_296_3
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_1, arg_293_1.talkMaxDuration)

			if var_296_0 <= arg_293_1.time_ and arg_293_1.time_ < var_296_0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_0 + var_296_7 and arg_293_1.time_ < var_296_0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1103404076 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 1103404076
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play1103404077(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0
			local var_300_1 = 0.45

			if var_300_0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				local var_300_2 = arg_297_1:FormatText(StoryNameCfg[7].name)

				arg_297_1.leftNameTxt_.text = var_300_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_3 = arg_297_1:GetWordFromCfg(1103404076)
				local var_300_4 = arg_297_1:FormatText(var_300_3.content)

				arg_297_1.text_.text = var_300_4

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_5 = 18
				local var_300_6 = utf8.len(var_300_4)
				local var_300_7 = var_300_5 <= 0 and var_300_1 or var_300_1 * (var_300_6 / var_300_5)

				if var_300_7 > 0 and var_300_1 < var_300_7 then
					arg_297_1.talkMaxDuration = var_300_7

					if var_300_7 + var_300_0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_7 + var_300_0
					end
				end

				arg_297_1.text_.text = var_300_4
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_8 = math.max(var_300_1, arg_297_1.talkMaxDuration)

			if var_300_0 <= arg_297_1.time_ and arg_297_1.time_ < var_300_0 + var_300_8 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_0) / var_300_8

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_0 + var_300_8 and arg_297_1.time_ < var_300_0 + var_300_8 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play1103404077 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1103404077
		arg_301_1.duration_ = 2.2

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1103404078(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1034ui_story"]
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1034ui_story == nil then
				arg_301_1.var_.characterEffect1034ui_story = var_304_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_2 = 0.200000002980232

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 and not isNil(var_304_0) then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2

				if arg_301_1.var_.characterEffect1034ui_story and not isNil(var_304_0) then
					arg_301_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 and not isNil(var_304_0) and arg_301_1.var_.characterEffect1034ui_story then
				arg_301_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_304_4 = 0
			local var_304_5 = 0.25

			if var_304_4 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_6 = arg_301_1:FormatText(StoryNameCfg[1109].name)

				arg_301_1.leftNameTxt_.text = var_304_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, true)
				arg_301_1.iconController_:SetSelectedState("hero")

				arg_301_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_301_1.callingController_:SetSelectedState("calling")

				arg_301_1.keyicon_.color = Color.New(1, 1, 1)
				arg_301_1.icon_.color = Color.New(1, 1, 1)

				local var_304_7 = arg_301_1:GetWordFromCfg(1103404077)
				local var_304_8 = arg_301_1:FormatText(var_304_7.content)

				arg_301_1.text_.text = var_304_8

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_9 = 10
				local var_304_10 = utf8.len(var_304_8)
				local var_304_11 = var_304_9 <= 0 and var_304_5 or var_304_5 * (var_304_10 / var_304_9)

				if var_304_11 > 0 and var_304_5 < var_304_11 then
					arg_301_1.talkMaxDuration = var_304_11

					if var_304_11 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_11 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_8
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404077", "story_v_side_new_1103404.awb") ~= 0 then
					local var_304_12 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404077", "story_v_side_new_1103404.awb") / 1000

					if var_304_12 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_12 + var_304_4
					end

					if var_304_7.prefab_name ~= "" and arg_301_1.actors_[var_304_7.prefab_name] ~= nil then
						local var_304_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_7.prefab_name].transform, "story_v_side_new_1103404", "1103404077", "story_v_side_new_1103404.awb")

						arg_301_1:RecordAudio("1103404077", var_304_13)
						arg_301_1:RecordAudio("1103404077", var_304_13)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404077", "story_v_side_new_1103404.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404077", "story_v_side_new_1103404.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_14 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_14 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_14

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_14 and arg_301_1.time_ < var_304_4 + var_304_14 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play1103404078 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1103404078
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1103404079(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1034ui_story"]
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1034ui_story == nil then
				arg_305_1.var_.characterEffect1034ui_story = var_308_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_2 = 0.200000002980232

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 and not isNil(var_308_0) then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2

				if arg_305_1.var_.characterEffect1034ui_story and not isNil(var_308_0) then
					local var_308_4 = Mathf.Lerp(0, 0.5, var_308_3)

					arg_305_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1034ui_story.fillRatio = var_308_4
				end
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 and not isNil(var_308_0) and arg_305_1.var_.characterEffect1034ui_story then
				local var_308_5 = 0.5

				arg_305_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1034ui_story.fillRatio = var_308_5
			end

			local var_308_6 = 0
			local var_308_7 = 0.825

			if var_308_6 < arg_305_1.time_ and arg_305_1.time_ <= var_308_6 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				local var_308_8 = arg_305_1:FormatText(StoryNameCfg[7].name)

				arg_305_1.leftNameTxt_.text = var_308_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, true)
				arg_305_1.iconController_:SetSelectedState("hero")

				arg_305_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_305_1.callingController_:SetSelectedState("normal")

				arg_305_1.keyicon_.color = Color.New(1, 1, 1)
				arg_305_1.icon_.color = Color.New(1, 1, 1)

				local var_308_9 = arg_305_1:GetWordFromCfg(1103404078)
				local var_308_10 = arg_305_1:FormatText(var_308_9.content)

				arg_305_1.text_.text = var_308_10

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_11 = 33
				local var_308_12 = utf8.len(var_308_10)
				local var_308_13 = var_308_11 <= 0 and var_308_7 or var_308_7 * (var_308_12 / var_308_11)

				if var_308_13 > 0 and var_308_7 < var_308_13 then
					arg_305_1.talkMaxDuration = var_308_13

					if var_308_13 + var_308_6 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_13 + var_308_6
					end
				end

				arg_305_1.text_.text = var_308_10
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_14 = math.max(var_308_7, arg_305_1.talkMaxDuration)

			if var_308_6 <= arg_305_1.time_ and arg_305_1.time_ < var_308_6 + var_308_14 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_6) / var_308_14

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_6 + var_308_14 and arg_305_1.time_ < var_308_6 + var_308_14 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play1103404079 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1103404079
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1103404080(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.625

			if var_312_0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				local var_312_2 = arg_309_1:FormatText(StoryNameCfg[7].name)

				arg_309_1.leftNameTxt_.text = var_312_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, true)
				arg_309_1.iconController_:SetSelectedState("hero")

				arg_309_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_309_1.callingController_:SetSelectedState("normal")

				arg_309_1.keyicon_.color = Color.New(1, 1, 1)
				arg_309_1.icon_.color = Color.New(1, 1, 1)

				local var_312_3 = arg_309_1:GetWordFromCfg(1103404079)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 25
				local var_312_6 = utf8.len(var_312_4)
				local var_312_7 = var_312_5 <= 0 and var_312_1 or var_312_1 * (var_312_6 / var_312_5)

				if var_312_7 > 0 and var_312_1 < var_312_7 then
					arg_309_1.talkMaxDuration = var_312_7

					if var_312_7 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_7 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_4
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_8 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_8 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_8

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_8 and arg_309_1.time_ < var_312_0 + var_312_8 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play1103404080 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1103404080
		arg_313_1.duration_ = 5.97

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1103404081(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = 0
			local var_316_1 = 0.775

			if var_316_0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_0 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_2 = arg_313_1:FormatText(StoryNameCfg[1109].name)

				arg_313_1.leftNameTxt_.text = var_316_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, true)
				arg_313_1.iconController_:SetSelectedState("hero")

				arg_313_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_7")

				arg_313_1.callingController_:SetSelectedState("calling")

				arg_313_1.keyicon_.color = Color.New(1, 1, 1)
				arg_313_1.icon_.color = Color.New(1, 1, 1)

				local var_316_3 = arg_313_1:GetWordFromCfg(1103404080)
				local var_316_4 = arg_313_1:FormatText(var_316_3.content)

				arg_313_1.text_.text = var_316_4

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 31
				local var_316_6 = utf8.len(var_316_4)
				local var_316_7 = var_316_5 <= 0 and var_316_1 or var_316_1 * (var_316_6 / var_316_5)

				if var_316_7 > 0 and var_316_1 < var_316_7 then
					arg_313_1.talkMaxDuration = var_316_7

					if var_316_7 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_7 + var_316_0
					end
				end

				arg_313_1.text_.text = var_316_4
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404080", "story_v_side_new_1103404.awb") ~= 0 then
					local var_316_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404080", "story_v_side_new_1103404.awb") / 1000

					if var_316_8 + var_316_0 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_8 + var_316_0
					end

					if var_316_3.prefab_name ~= "" and arg_313_1.actors_[var_316_3.prefab_name] ~= nil then
						local var_316_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_3.prefab_name].transform, "story_v_side_new_1103404", "1103404080", "story_v_side_new_1103404.awb")

						arg_313_1:RecordAudio("1103404080", var_316_9)
						arg_313_1:RecordAudio("1103404080", var_316_9)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404080", "story_v_side_new_1103404.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404080", "story_v_side_new_1103404.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_10 = math.max(var_316_1, arg_313_1.talkMaxDuration)

			if var_316_0 <= arg_313_1.time_ and arg_313_1.time_ < var_316_0 + var_316_10 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_0) / var_316_10

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_0 + var_316_10 and arg_313_1.time_ < var_316_0 + var_316_10 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play1103404081 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1103404081
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1103404082(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = 0
			local var_320_1 = 0.566666666666667

			if var_320_0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_0 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_2 = arg_317_1:FormatText(StoryNameCfg[7].name)

				arg_317_1.leftNameTxt_.text = var_320_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, true)
				arg_317_1.iconController_:SetSelectedState("hero")

				arg_317_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_317_1.callingController_:SetSelectedState("normal")

				arg_317_1.keyicon_.color = Color.New(1, 1, 1)
				arg_317_1.icon_.color = Color.New(1, 1, 1)

				local var_320_3 = arg_317_1:GetWordFromCfg(1103404081)
				local var_320_4 = arg_317_1:FormatText(var_320_3.content)

				arg_317_1.text_.text = var_320_4

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_5 = 21
				local var_320_6 = utf8.len(var_320_4)
				local var_320_7 = var_320_5 <= 0 and var_320_1 or var_320_1 * (var_320_6 / var_320_5)

				if var_320_7 > 0 and var_320_1 < var_320_7 then
					arg_317_1.talkMaxDuration = var_320_7

					if var_320_7 + var_320_0 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_7 + var_320_0
					end
				end

				arg_317_1.text_.text = var_320_4
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_8 = math.max(var_320_1, arg_317_1.talkMaxDuration)

			if var_320_0 <= arg_317_1.time_ and arg_317_1.time_ < var_320_0 + var_320_8 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_0) / var_320_8

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_0 + var_320_8 and arg_317_1.time_ < var_320_0 + var_320_8 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play1103404082 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1103404082
		arg_321_1.duration_ = 4.03

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1103404083(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0
			local var_324_1 = 0.45

			if var_324_0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_2 = arg_321_1:FormatText(StoryNameCfg[1109].name)

				arg_321_1.leftNameTxt_.text = var_324_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034_split_1")

				arg_321_1.callingController_:SetSelectedState("calling")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_3 = arg_321_1:GetWordFromCfg(1103404082)
				local var_324_4 = arg_321_1:FormatText(var_324_3.content)

				arg_321_1.text_.text = var_324_4

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_5 = 18
				local var_324_6 = utf8.len(var_324_4)
				local var_324_7 = var_324_5 <= 0 and var_324_1 or var_324_1 * (var_324_6 / var_324_5)

				if var_324_7 > 0 and var_324_1 < var_324_7 then
					arg_321_1.talkMaxDuration = var_324_7

					if var_324_7 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_7 + var_324_0
					end
				end

				arg_321_1.text_.text = var_324_4
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404082", "story_v_side_new_1103404.awb") ~= 0 then
					local var_324_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404082", "story_v_side_new_1103404.awb") / 1000

					if var_324_8 + var_324_0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_0
					end

					if var_324_3.prefab_name ~= "" and arg_321_1.actors_[var_324_3.prefab_name] ~= nil then
						local var_324_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_3.prefab_name].transform, "story_v_side_new_1103404", "1103404082", "story_v_side_new_1103404.awb")

						arg_321_1:RecordAudio("1103404082", var_324_9)
						arg_321_1:RecordAudio("1103404082", var_324_9)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404082", "story_v_side_new_1103404.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404082", "story_v_side_new_1103404.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_10 = math.max(var_324_1, arg_321_1.talkMaxDuration)

			if var_324_0 <= arg_321_1.time_ and arg_321_1.time_ < var_324_0 + var_324_10 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_0) / var_324_10

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_0 + var_324_10 and arg_321_1.time_ < var_324_0 + var_324_10 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1103404083 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1103404083
		arg_325_1.duration_ = 5.43

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1103404084(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0
			local var_328_1 = 0.725

			if var_328_0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				local var_328_2 = arg_325_1:FormatText(StoryNameCfg[1109].name)

				arg_325_1.leftNameTxt_.text = var_328_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1034")

				arg_325_1.callingController_:SetSelectedState("calling")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_3 = arg_325_1:GetWordFromCfg(1103404083)
				local var_328_4 = arg_325_1:FormatText(var_328_3.content)

				arg_325_1.text_.text = var_328_4

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_5 = 29
				local var_328_6 = utf8.len(var_328_4)
				local var_328_7 = var_328_5 <= 0 and var_328_1 or var_328_1 * (var_328_6 / var_328_5)

				if var_328_7 > 0 and var_328_1 < var_328_7 then
					arg_325_1.talkMaxDuration = var_328_7

					if var_328_7 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_7 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_4
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404083", "story_v_side_new_1103404.awb") ~= 0 then
					local var_328_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404083", "story_v_side_new_1103404.awb") / 1000

					if var_328_8 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_8 + var_328_0
					end

					if var_328_3.prefab_name ~= "" and arg_325_1.actors_[var_328_3.prefab_name] ~= nil then
						local var_328_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_3.prefab_name].transform, "story_v_side_new_1103404", "1103404083", "story_v_side_new_1103404.awb")

						arg_325_1:RecordAudio("1103404083", var_328_9)
						arg_325_1:RecordAudio("1103404083", var_328_9)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404083", "story_v_side_new_1103404.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404083", "story_v_side_new_1103404.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_10 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_10 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_10

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_10 and arg_325_1.time_ < var_328_0 + var_328_10 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play1103404084 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1103404084
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1103404085(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = arg_329_1.actors_["1034ui_story"]
			local var_332_1 = 0

			if var_332_1 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1034ui_story == nil then
				arg_329_1.var_.characterEffect1034ui_story = var_332_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_2 = 0.200000002980232

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_2 and not isNil(var_332_0) then
				local var_332_3 = (arg_329_1.time_ - var_332_1) / var_332_2

				if arg_329_1.var_.characterEffect1034ui_story and not isNil(var_332_0) then
					local var_332_4 = Mathf.Lerp(0, 0.5, var_332_3)

					arg_329_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_329_1.var_.characterEffect1034ui_story.fillRatio = var_332_4
				end
			end

			if arg_329_1.time_ >= var_332_1 + var_332_2 and arg_329_1.time_ < var_332_1 + var_332_2 + arg_332_0 and not isNil(var_332_0) and arg_329_1.var_.characterEffect1034ui_story then
				local var_332_5 = 0.5

				arg_329_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_329_1.var_.characterEffect1034ui_story.fillRatio = var_332_5
			end

			local var_332_6 = 0

			if var_332_6 < arg_329_1.time_ and arg_329_1.time_ <= var_332_6 + arg_332_0 then
				arg_329_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_332_7 = 0

			if var_332_7 < arg_329_1.time_ and arg_329_1.time_ <= var_332_7 + arg_332_0 then
				arg_329_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_332_8 = 0
			local var_332_9 = 1.3

			if var_332_8 < arg_329_1.time_ and arg_329_1.time_ <= var_332_8 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_10 = arg_329_1:GetWordFromCfg(1103404084)
				local var_332_11 = arg_329_1:FormatText(var_332_10.content)

				arg_329_1.text_.text = var_332_11

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_12 = 52
				local var_332_13 = utf8.len(var_332_11)
				local var_332_14 = var_332_12 <= 0 and var_332_9 or var_332_9 * (var_332_13 / var_332_12)

				if var_332_14 > 0 and var_332_9 < var_332_14 then
					arg_329_1.talkMaxDuration = var_332_14

					if var_332_14 + var_332_8 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_14 + var_332_8
					end
				end

				arg_329_1.text_.text = var_332_11
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_15 = math.max(var_332_9, arg_329_1.talkMaxDuration)

			if var_332_8 <= arg_329_1.time_ and arg_329_1.time_ < var_332_8 + var_332_15 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_8) / var_332_15

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_8 + var_332_15 and arg_329_1.time_ < var_332_8 + var_332_15 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1103404085 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1103404085
		arg_333_1.duration_ = 3.2

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1103404086(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.bgs_.I11o.transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPosI11o = var_336_0.localPosition
			end

			local var_336_2 = 2.5

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2
				local var_336_4 = Vector3.New(0, 1, 9.5)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPosI11o, var_336_4, var_336_3)
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_336_5 = 0

			if var_336_5 < arg_333_1.time_ and arg_333_1.time_ <= var_336_5 + arg_336_0 then
				arg_333_1.allBtn_.enabled = false
			end

			local var_336_6 = 2.5

			if arg_333_1.time_ >= var_336_5 + var_336_6 and arg_333_1.time_ < var_336_5 + var_336_6 + arg_336_0 then
				arg_333_1.allBtn_.enabled = true
			end

			local var_336_7 = 0.0166666666666666
			local var_336_8 = 1

			if var_336_7 < arg_333_1.time_ and arg_333_1.time_ <= var_336_7 + arg_336_0 then
				local var_336_9 = "play"
				local var_336_10 = "effect"

				arg_333_1:AudioAction(var_336_9, var_336_10, "se_story_1310", "se_story_1310_footstep01", "")
			end

			local var_336_11 = arg_333_1.actors_["1034ui_story"].transform
			local var_336_12 = 0

			if var_336_12 < arg_333_1.time_ and arg_333_1.time_ <= var_336_12 + arg_336_0 then
				arg_333_1.var_.moveOldPos1034ui_story = var_336_11.localPosition
			end

			local var_336_13 = 0.001

			if var_336_12 <= arg_333_1.time_ and arg_333_1.time_ < var_336_12 + var_336_13 then
				local var_336_14 = (arg_333_1.time_ - var_336_12) / var_336_13
				local var_336_15 = Vector3.New(0, -0.93, -6)

				var_336_11.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1034ui_story, var_336_15, var_336_14)

				local var_336_16 = manager.ui.mainCamera.transform.position - var_336_11.position

				var_336_11.forward = Vector3.New(var_336_16.x, var_336_16.y, var_336_16.z)

				local var_336_17 = var_336_11.localEulerAngles

				var_336_17.z = 0
				var_336_17.x = 0
				var_336_11.localEulerAngles = var_336_17
			end

			if arg_333_1.time_ >= var_336_12 + var_336_13 and arg_333_1.time_ < var_336_12 + var_336_13 + arg_336_0 then
				var_336_11.localPosition = Vector3.New(0, -0.93, -6)

				local var_336_18 = manager.ui.mainCamera.transform.position - var_336_11.position

				var_336_11.forward = Vector3.New(var_336_18.x, var_336_18.y, var_336_18.z)

				local var_336_19 = var_336_11.localEulerAngles

				var_336_19.z = 0
				var_336_19.x = 0
				var_336_11.localEulerAngles = var_336_19
			end

			local var_336_20 = arg_333_1.actors_["1034ui_story"]
			local var_336_21 = 0

			if var_336_21 < arg_333_1.time_ and arg_333_1.time_ <= var_336_21 + arg_336_0 and not isNil(var_336_20) and arg_333_1.var_.characterEffect1034ui_story == nil then
				arg_333_1.var_.characterEffect1034ui_story = var_336_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_22 = 0.200000002980232

			if var_336_21 <= arg_333_1.time_ and arg_333_1.time_ < var_336_21 + var_336_22 and not isNil(var_336_20) then
				local var_336_23 = (arg_333_1.time_ - var_336_21) / var_336_22

				if arg_333_1.var_.characterEffect1034ui_story and not isNil(var_336_20) then
					arg_333_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_21 + var_336_22 and arg_333_1.time_ < var_336_21 + var_336_22 + arg_336_0 and not isNil(var_336_20) and arg_333_1.var_.characterEffect1034ui_story then
				arg_333_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_336_24 = 0
			local var_336_25 = 0.225

			if var_336_24 < arg_333_1.time_ and arg_333_1.time_ <= var_336_24 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0

				arg_333_1.dialog_:SetActive(true)

				arg_333_1.dialogCg_.alpha = 0

				local var_336_26 = LeanTween.value(arg_333_1.dialog_, 0, 1, 0.3)

				var_336_26:setOnUpdate(LuaHelper.FloatAction(function(arg_337_0)
					arg_333_1.dialogCg_.alpha = arg_337_0
				end))
				var_336_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_333_1.dialog_)
					var_336_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_333_1.duration_ = arg_333_1.duration_ + 0.3

				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_27 = arg_333_1:FormatText(StoryNameCfg[1109].name)

				arg_333_1.leftNameTxt_.text = var_336_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_28 = arg_333_1:GetWordFromCfg(1103404085)
				local var_336_29 = arg_333_1:FormatText(var_336_28.content)

				arg_333_1.text_.text = var_336_29

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_30 = 9
				local var_336_31 = utf8.len(var_336_29)
				local var_336_32 = var_336_30 <= 0 and var_336_25 or var_336_25 * (var_336_31 / var_336_30)

				if var_336_32 > 0 and var_336_25 < var_336_32 then
					arg_333_1.talkMaxDuration = var_336_32
					var_336_24 = var_336_24 + 0.3

					if var_336_32 + var_336_24 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_32 + var_336_24
					end
				end

				arg_333_1.text_.text = var_336_29
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404085", "story_v_side_new_1103404.awb") ~= 0 then
					local var_336_33 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404085", "story_v_side_new_1103404.awb") / 1000

					if var_336_33 + var_336_24 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_33 + var_336_24
					end

					if var_336_28.prefab_name ~= "" and arg_333_1.actors_[var_336_28.prefab_name] ~= nil then
						local var_336_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_28.prefab_name].transform, "story_v_side_new_1103404", "1103404085", "story_v_side_new_1103404.awb")

						arg_333_1:RecordAudio("1103404085", var_336_34)
						arg_333_1:RecordAudio("1103404085", var_336_34)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404085", "story_v_side_new_1103404.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404085", "story_v_side_new_1103404.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_35 = var_336_24 + 0.3
			local var_336_36 = math.max(var_336_25, arg_333_1.talkMaxDuration)

			if var_336_35 <= arg_333_1.time_ and arg_333_1.time_ < var_336_35 + var_336_36 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_35) / var_336_36

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_35 + var_336_36 and arg_333_1.time_ < var_336_35 + var_336_36 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "I11o",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2.5,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.linear
				}
			},
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_333_1:InitPlayNodeList()
	end,
	Play1103404086 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 1103404086
		arg_339_1.duration_ = 3.83

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play1103404087(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = 0
			local var_342_1 = 0.325

			if var_342_0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_0 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_2 = arg_339_1:FormatText(StoryNameCfg[714].name)

				arg_339_1.leftNameTxt_.text = var_342_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, true)
				arg_339_1.iconController_:SetSelectedState("hero")

				arg_339_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_339_1.callingController_:SetSelectedState("normal")

				arg_339_1.keyicon_.color = Color.New(1, 1, 1)
				arg_339_1.icon_.color = Color.New(1, 1, 1)

				local var_342_3 = arg_339_1:GetWordFromCfg(1103404086)
				local var_342_4 = arg_339_1:FormatText(var_342_3.content)

				arg_339_1.text_.text = var_342_4

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_5 = 13
				local var_342_6 = utf8.len(var_342_4)
				local var_342_7 = var_342_5 <= 0 and var_342_1 or var_342_1 * (var_342_6 / var_342_5)

				if var_342_7 > 0 and var_342_1 < var_342_7 then
					arg_339_1.talkMaxDuration = var_342_7

					if var_342_7 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_7 + var_342_0
					end
				end

				arg_339_1.text_.text = var_342_4
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404086", "story_v_side_new_1103404.awb") ~= 0 then
					local var_342_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404086", "story_v_side_new_1103404.awb") / 1000

					if var_342_8 + var_342_0 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_8 + var_342_0
					end

					if var_342_3.prefab_name ~= "" and arg_339_1.actors_[var_342_3.prefab_name] ~= nil then
						local var_342_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_3.prefab_name].transform, "story_v_side_new_1103404", "1103404086", "story_v_side_new_1103404.awb")

						arg_339_1:RecordAudio("1103404086", var_342_9)
						arg_339_1:RecordAudio("1103404086", var_342_9)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404086", "story_v_side_new_1103404.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404086", "story_v_side_new_1103404.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_10 = math.max(var_342_1, arg_339_1.talkMaxDuration)

			if var_342_0 <= arg_339_1.time_ and arg_339_1.time_ < var_342_0 + var_342_10 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_0) / var_342_10

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_0 + var_342_10 and arg_339_1.time_ < var_342_0 + var_342_10 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play1103404087 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 1103404087
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play1103404088(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 1.35

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_2 = arg_343_1:GetWordFromCfg(1103404087)
				local var_346_3 = arg_343_1:FormatText(var_346_2.content)

				arg_343_1.text_.text = var_346_3

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_4 = 54
				local var_346_5 = utf8.len(var_346_3)
				local var_346_6 = var_346_4 <= 0 and var_346_1 or var_346_1 * (var_346_5 / var_346_4)

				if var_346_6 > 0 and var_346_1 < var_346_6 then
					arg_343_1.talkMaxDuration = var_346_6

					if var_346_6 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_6 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_3
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_7 and arg_343_1.time_ < var_346_0 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play1103404088 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 1103404088
		arg_347_1.duration_ = 2.13

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play1103404089(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = 0

			if var_350_0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_0 + arg_350_0 then
				arg_347_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_1")
			end

			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 then
				arg_347_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_350_2 = arg_347_1.actors_["1034ui_story"].transform
			local var_350_3 = 0

			if var_350_3 < arg_347_1.time_ and arg_347_1.time_ <= var_350_3 + arg_350_0 then
				arg_347_1.var_.moveOldPos1034ui_story = var_350_2.localPosition
			end

			local var_350_4 = 0.001

			if var_350_3 <= arg_347_1.time_ and arg_347_1.time_ < var_350_3 + var_350_4 then
				local var_350_5 = (arg_347_1.time_ - var_350_3) / var_350_4
				local var_350_6 = Vector3.New(0, -0.93, -6)

				var_350_2.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos1034ui_story, var_350_6, var_350_5)

				local var_350_7 = manager.ui.mainCamera.transform.position - var_350_2.position

				var_350_2.forward = Vector3.New(var_350_7.x, var_350_7.y, var_350_7.z)

				local var_350_8 = var_350_2.localEulerAngles

				var_350_8.z = 0
				var_350_8.x = 0
				var_350_2.localEulerAngles = var_350_8
			end

			if arg_347_1.time_ >= var_350_3 + var_350_4 and arg_347_1.time_ < var_350_3 + var_350_4 + arg_350_0 then
				var_350_2.localPosition = Vector3.New(0, -0.93, -6)

				local var_350_9 = manager.ui.mainCamera.transform.position - var_350_2.position

				var_350_2.forward = Vector3.New(var_350_9.x, var_350_9.y, var_350_9.z)

				local var_350_10 = var_350_2.localEulerAngles

				var_350_10.z = 0
				var_350_10.x = 0
				var_350_2.localEulerAngles = var_350_10
			end

			local var_350_11 = arg_347_1.actors_["1034ui_story"]
			local var_350_12 = 0

			if var_350_12 < arg_347_1.time_ and arg_347_1.time_ <= var_350_12 + arg_350_0 and not isNil(var_350_11) and arg_347_1.var_.characterEffect1034ui_story == nil then
				arg_347_1.var_.characterEffect1034ui_story = var_350_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_13 = 0.200000002980232

			if var_350_12 <= arg_347_1.time_ and arg_347_1.time_ < var_350_12 + var_350_13 and not isNil(var_350_11) then
				local var_350_14 = (arg_347_1.time_ - var_350_12) / var_350_13

				if arg_347_1.var_.characterEffect1034ui_story and not isNil(var_350_11) then
					arg_347_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= var_350_12 + var_350_13 and arg_347_1.time_ < var_350_12 + var_350_13 + arg_350_0 and not isNil(var_350_11) and arg_347_1.var_.characterEffect1034ui_story then
				arg_347_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_350_15 = 0
			local var_350_16 = 0.15

			if var_350_15 < arg_347_1.time_ and arg_347_1.time_ <= var_350_15 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_17 = arg_347_1:FormatText(StoryNameCfg[1109].name)

				arg_347_1.leftNameTxt_.text = var_350_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_18 = arg_347_1:GetWordFromCfg(1103404088)
				local var_350_19 = arg_347_1:FormatText(var_350_18.content)

				arg_347_1.text_.text = var_350_19

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_20 = 6
				local var_350_21 = utf8.len(var_350_19)
				local var_350_22 = var_350_20 <= 0 and var_350_16 or var_350_16 * (var_350_21 / var_350_20)

				if var_350_22 > 0 and var_350_16 < var_350_22 then
					arg_347_1.talkMaxDuration = var_350_22

					if var_350_22 + var_350_15 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_22 + var_350_15
					end
				end

				arg_347_1.text_.text = var_350_19
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404088", "story_v_side_new_1103404.awb") ~= 0 then
					local var_350_23 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404088", "story_v_side_new_1103404.awb") / 1000

					if var_350_23 + var_350_15 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_23 + var_350_15
					end

					if var_350_18.prefab_name ~= "" and arg_347_1.actors_[var_350_18.prefab_name] ~= nil then
						local var_350_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_18.prefab_name].transform, "story_v_side_new_1103404", "1103404088", "story_v_side_new_1103404.awb")

						arg_347_1:RecordAudio("1103404088", var_350_24)
						arg_347_1:RecordAudio("1103404088", var_350_24)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404088", "story_v_side_new_1103404.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404088", "story_v_side_new_1103404.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_25 = math.max(var_350_16, arg_347_1.talkMaxDuration)

			if var_350_15 <= arg_347_1.time_ and arg_347_1.time_ < var_350_15 + var_350_25 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_15) / var_350_25

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_15 + var_350_25 and arg_347_1.time_ < var_350_15 + var_350_25 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_347_1:InitPlayNodeList()
	end,
	Play1103404089 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 1103404089
		arg_351_1.duration_ = 3.6

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play1103404090(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = arg_351_1.actors_["1034ui_story"]
			local var_354_1 = 0

			if var_354_1 < arg_351_1.time_ and arg_351_1.time_ <= var_354_1 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1034ui_story == nil then
				arg_351_1.var_.characterEffect1034ui_story = var_354_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if var_354_1 <= arg_351_1.time_ and arg_351_1.time_ < var_354_1 + var_354_2 and not isNil(var_354_0) then
				local var_354_3 = (arg_351_1.time_ - var_354_1) / var_354_2

				if arg_351_1.var_.characterEffect1034ui_story and not isNil(var_354_0) then
					local var_354_4 = Mathf.Lerp(0, 0.5, var_354_3)

					arg_351_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_351_1.var_.characterEffect1034ui_story.fillRatio = var_354_4
				end
			end

			if arg_351_1.time_ >= var_354_1 + var_354_2 and arg_351_1.time_ < var_354_1 + var_354_2 + arg_354_0 and not isNil(var_354_0) and arg_351_1.var_.characterEffect1034ui_story then
				local var_354_5 = 0.5

				arg_351_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_351_1.var_.characterEffect1034ui_story.fillRatio = var_354_5
			end

			local var_354_6 = 0
			local var_354_7 = 0.25

			if var_354_6 < arg_351_1.time_ and arg_351_1.time_ <= var_354_6 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_8 = arg_351_1:FormatText(StoryNameCfg[714].name)

				arg_351_1.leftNameTxt_.text = var_354_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, true)
				arg_351_1.iconController_:SetSelectedState("hero")

				arg_351_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_351_1.callingController_:SetSelectedState("normal")

				arg_351_1.keyicon_.color = Color.New(1, 1, 1)
				arg_351_1.icon_.color = Color.New(1, 1, 1)

				local var_354_9 = arg_351_1:GetWordFromCfg(1103404089)
				local var_354_10 = arg_351_1:FormatText(var_354_9.content)

				arg_351_1.text_.text = var_354_10

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_11 = 10
				local var_354_12 = utf8.len(var_354_10)
				local var_354_13 = var_354_11 <= 0 and var_354_7 or var_354_7 * (var_354_12 / var_354_11)

				if var_354_13 > 0 and var_354_7 < var_354_13 then
					arg_351_1.talkMaxDuration = var_354_13

					if var_354_13 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_13 + var_354_6
					end
				end

				arg_351_1.text_.text = var_354_10
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404089", "story_v_side_new_1103404.awb") ~= 0 then
					local var_354_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404089", "story_v_side_new_1103404.awb") / 1000

					if var_354_14 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_14 + var_354_6
					end

					if var_354_9.prefab_name ~= "" and arg_351_1.actors_[var_354_9.prefab_name] ~= nil then
						local var_354_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_9.prefab_name].transform, "story_v_side_new_1103404", "1103404089", "story_v_side_new_1103404.awb")

						arg_351_1:RecordAudio("1103404089", var_354_15)
						arg_351_1:RecordAudio("1103404089", var_354_15)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404089", "story_v_side_new_1103404.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404089", "story_v_side_new_1103404.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_16 = math.max(var_354_7, arg_351_1.talkMaxDuration)

			if var_354_6 <= arg_351_1.time_ and arg_351_1.time_ < var_354_6 + var_354_16 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_6) / var_354_16

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_6 + var_354_16 and arg_351_1.time_ < var_354_6 + var_354_16 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play1103404090 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 1103404090
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play1103404091(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = 0

			if var_358_0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_0 + arg_358_0 then
				arg_355_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action2_2")
			end

			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_358_2 = 0
			local var_358_3 = 1.65

			if var_358_2 < arg_355_1.time_ and arg_355_1.time_ <= var_358_2 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_4 = arg_355_1:GetWordFromCfg(1103404090)
				local var_358_5 = arg_355_1:FormatText(var_358_4.content)

				arg_355_1.text_.text = var_358_5

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_6 = 66
				local var_358_7 = utf8.len(var_358_5)
				local var_358_8 = var_358_6 <= 0 and var_358_3 or var_358_3 * (var_358_7 / var_358_6)

				if var_358_8 > 0 and var_358_3 < var_358_8 then
					arg_355_1.talkMaxDuration = var_358_8

					if var_358_8 + var_358_2 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_8 + var_358_2
					end
				end

				arg_355_1.text_.text = var_358_5
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_9 = math.max(var_358_3, arg_355_1.talkMaxDuration)

			if var_358_2 <= arg_355_1.time_ and arg_355_1.time_ < var_358_2 + var_358_9 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_2) / var_358_9

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_2 + var_358_9 and arg_355_1.time_ < var_358_2 + var_358_9 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play1103404091 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 1103404091
		arg_359_1.duration_ = 2.9

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play1103404092(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0

			if var_362_0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_0 + arg_362_0 then
				arg_359_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_362_1 = 0
			local var_362_2 = 0.225

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				local var_362_3 = arg_359_1:FormatText(StoryNameCfg[714].name)

				arg_359_1.leftNameTxt_.text = var_362_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, true)
				arg_359_1.iconController_:SetSelectedState("hero")

				arg_359_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_359_1.callingController_:SetSelectedState("normal")

				arg_359_1.keyicon_.color = Color.New(1, 1, 1)
				arg_359_1.icon_.color = Color.New(1, 1, 1)

				local var_362_4 = arg_359_1:GetWordFromCfg(1103404091)
				local var_362_5 = arg_359_1:FormatText(var_362_4.content)

				arg_359_1.text_.text = var_362_5

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_6 = 9
				local var_362_7 = utf8.len(var_362_5)
				local var_362_8 = var_362_6 <= 0 and var_362_2 or var_362_2 * (var_362_7 / var_362_6)

				if var_362_8 > 0 and var_362_2 < var_362_8 then
					arg_359_1.talkMaxDuration = var_362_8

					if var_362_8 + var_362_1 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_8 + var_362_1
					end
				end

				arg_359_1.text_.text = var_362_5
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404091", "story_v_side_new_1103404.awb") ~= 0 then
					local var_362_9 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404091", "story_v_side_new_1103404.awb") / 1000

					if var_362_9 + var_362_1 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_9 + var_362_1
					end

					if var_362_4.prefab_name ~= "" and arg_359_1.actors_[var_362_4.prefab_name] ~= nil then
						local var_362_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_4.prefab_name].transform, "story_v_side_new_1103404", "1103404091", "story_v_side_new_1103404.awb")

						arg_359_1:RecordAudio("1103404091", var_362_10)
						arg_359_1:RecordAudio("1103404091", var_362_10)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404091", "story_v_side_new_1103404.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404091", "story_v_side_new_1103404.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_11 = math.max(var_362_2, arg_359_1.talkMaxDuration)

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_11 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_1) / var_362_11

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_1 + var_362_11 and arg_359_1.time_ < var_362_1 + var_362_11 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play1103404092 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 1103404092
		arg_363_1.duration_ = 3.87

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play1103404093(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = arg_363_1.actors_["1034ui_story"]
			local var_366_1 = 0

			if var_366_1 < arg_363_1.time_ and arg_363_1.time_ <= var_366_1 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1034ui_story == nil then
				arg_363_1.var_.characterEffect1034ui_story = var_366_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_366_2 = 0.200000002980232

			if var_366_1 <= arg_363_1.time_ and arg_363_1.time_ < var_366_1 + var_366_2 and not isNil(var_366_0) then
				local var_366_3 = (arg_363_1.time_ - var_366_1) / var_366_2

				if arg_363_1.var_.characterEffect1034ui_story and not isNil(var_366_0) then
					arg_363_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_363_1.time_ >= var_366_1 + var_366_2 and arg_363_1.time_ < var_366_1 + var_366_2 + arg_366_0 and not isNil(var_366_0) and arg_363_1.var_.characterEffect1034ui_story then
				arg_363_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_366_4 = 0

			if var_366_4 < arg_363_1.time_ and arg_363_1.time_ <= var_366_4 + arg_366_0 then
				arg_363_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			local var_366_5 = 0

			if var_366_5 < arg_363_1.time_ and arg_363_1.time_ <= var_366_5 + arg_366_0 then
				arg_363_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_366_6 = 0
			local var_366_7 = 0.45

			if var_366_6 < arg_363_1.time_ and arg_363_1.time_ <= var_366_6 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_8 = arg_363_1:FormatText(StoryNameCfg[1109].name)

				arg_363_1.leftNameTxt_.text = var_366_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_9 = arg_363_1:GetWordFromCfg(1103404092)
				local var_366_10 = arg_363_1:FormatText(var_366_9.content)

				arg_363_1.text_.text = var_366_10

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_11 = 18
				local var_366_12 = utf8.len(var_366_10)
				local var_366_13 = var_366_11 <= 0 and var_366_7 or var_366_7 * (var_366_12 / var_366_11)

				if var_366_13 > 0 and var_366_7 < var_366_13 then
					arg_363_1.talkMaxDuration = var_366_13

					if var_366_13 + var_366_6 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_13 + var_366_6
					end
				end

				arg_363_1.text_.text = var_366_10
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404092", "story_v_side_new_1103404.awb") ~= 0 then
					local var_366_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404092", "story_v_side_new_1103404.awb") / 1000

					if var_366_14 + var_366_6 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_14 + var_366_6
					end

					if var_366_9.prefab_name ~= "" and arg_363_1.actors_[var_366_9.prefab_name] ~= nil then
						local var_366_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_9.prefab_name].transform, "story_v_side_new_1103404", "1103404092", "story_v_side_new_1103404.awb")

						arg_363_1:RecordAudio("1103404092", var_366_15)
						arg_363_1:RecordAudio("1103404092", var_366_15)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404092", "story_v_side_new_1103404.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404092", "story_v_side_new_1103404.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_16 = math.max(var_366_7, arg_363_1.talkMaxDuration)

			if var_366_6 <= arg_363_1.time_ and arg_363_1.time_ < var_366_6 + var_366_16 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_6) / var_366_16

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_6 + var_366_16 and arg_363_1.time_ < var_366_6 + var_366_16 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play1103404093 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 1103404093
		arg_367_1.duration_ = 2.33

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play1103404094(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0

			if var_370_0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_0 + arg_370_0 then
				arg_367_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action476")
			end

			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 then
				arg_367_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_370_2 = 0
			local var_370_3 = 0.2

			if var_370_2 < arg_367_1.time_ and arg_367_1.time_ <= var_370_2 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_4 = arg_367_1:FormatText(StoryNameCfg[1109].name)

				arg_367_1.leftNameTxt_.text = var_370_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_5 = arg_367_1:GetWordFromCfg(1103404093)
				local var_370_6 = arg_367_1:FormatText(var_370_5.content)

				arg_367_1.text_.text = var_370_6

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_7 = 8
				local var_370_8 = utf8.len(var_370_6)
				local var_370_9 = var_370_7 <= 0 and var_370_3 or var_370_3 * (var_370_8 / var_370_7)

				if var_370_9 > 0 and var_370_3 < var_370_9 then
					arg_367_1.talkMaxDuration = var_370_9

					if var_370_9 + var_370_2 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_9 + var_370_2
					end
				end

				arg_367_1.text_.text = var_370_6
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404093", "story_v_side_new_1103404.awb") ~= 0 then
					local var_370_10 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404093", "story_v_side_new_1103404.awb") / 1000

					if var_370_10 + var_370_2 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_2
					end

					if var_370_5.prefab_name ~= "" and arg_367_1.actors_[var_370_5.prefab_name] ~= nil then
						local var_370_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_5.prefab_name].transform, "story_v_side_new_1103404", "1103404093", "story_v_side_new_1103404.awb")

						arg_367_1:RecordAudio("1103404093", var_370_11)
						arg_367_1:RecordAudio("1103404093", var_370_11)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404093", "story_v_side_new_1103404.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404093", "story_v_side_new_1103404.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_12 = math.max(var_370_3, arg_367_1.talkMaxDuration)

			if var_370_2 <= arg_367_1.time_ and arg_367_1.time_ < var_370_2 + var_370_12 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_2) / var_370_12

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_2 + var_370_12 and arg_367_1.time_ < var_370_2 + var_370_12 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play1103404094 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 1103404094
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play1103404095(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1034ui_story"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1034ui_story == nil then
				arg_371_1.var_.characterEffect1034ui_story = var_374_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 and not isNil(var_374_0) then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.characterEffect1034ui_story and not isNil(var_374_0) then
					local var_374_4 = Mathf.Lerp(0, 0.5, var_374_3)

					arg_371_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1034ui_story.fillRatio = var_374_4
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and not isNil(var_374_0) and arg_371_1.var_.characterEffect1034ui_story then
				local var_374_5 = 0.5

				arg_371_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1034ui_story.fillRatio = var_374_5
			end

			local var_374_6 = 0

			if var_374_6 < arg_371_1.time_ and arg_371_1.time_ <= var_374_6 + arg_374_0 then
				arg_371_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			local var_374_7 = 0.566666666666667
			local var_374_8 = 1

			if var_374_7 < arg_371_1.time_ and arg_371_1.time_ <= var_374_7 + arg_374_0 then
				local var_374_9 = "play"
				local var_374_10 = "effect"

				arg_371_1:AudioAction(var_374_9, var_374_10, "se_story_128", "se_story_128_handcuffs", "")
			end

			local var_374_11 = 0
			local var_374_12 = 1.75

			if var_374_11 < arg_371_1.time_ and arg_371_1.time_ <= var_374_11 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_13 = arg_371_1:GetWordFromCfg(1103404094)
				local var_374_14 = arg_371_1:FormatText(var_374_13.content)

				arg_371_1.text_.text = var_374_14

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_15 = 70
				local var_374_16 = utf8.len(var_374_14)
				local var_374_17 = var_374_15 <= 0 and var_374_12 or var_374_12 * (var_374_16 / var_374_15)

				if var_374_17 > 0 and var_374_12 < var_374_17 then
					arg_371_1.talkMaxDuration = var_374_17

					if var_374_17 + var_374_11 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_17 + var_374_11
					end
				end

				arg_371_1.text_.text = var_374_14
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_18 = math.max(var_374_12, arg_371_1.talkMaxDuration)

			if var_374_11 <= arg_371_1.time_ and arg_371_1.time_ < var_374_11 + var_374_18 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_11) / var_374_18

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_11 + var_374_18 and arg_371_1.time_ < var_374_11 + var_374_18 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play1103404095 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 1103404095
		arg_375_1.duration_ = 6.33

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play1103404096(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0

			if var_378_0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_0 + arg_378_0 then
				arg_375_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_378_1 = 0
			local var_378_2 = 0.775

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_3 = arg_375_1:FormatText(StoryNameCfg[714].name)

				arg_375_1.leftNameTxt_.text = var_378_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, true)
				arg_375_1.iconController_:SetSelectedState("hero")

				arg_375_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_375_1.callingController_:SetSelectedState("normal")

				arg_375_1.keyicon_.color = Color.New(1, 1, 1)
				arg_375_1.icon_.color = Color.New(1, 1, 1)

				local var_378_4 = arg_375_1:GetWordFromCfg(1103404095)
				local var_378_5 = arg_375_1:FormatText(var_378_4.content)

				arg_375_1.text_.text = var_378_5

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_6 = 31
				local var_378_7 = utf8.len(var_378_5)
				local var_378_8 = var_378_6 <= 0 and var_378_2 or var_378_2 * (var_378_7 / var_378_6)

				if var_378_8 > 0 and var_378_2 < var_378_8 then
					arg_375_1.talkMaxDuration = var_378_8

					if var_378_8 + var_378_1 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_8 + var_378_1
					end
				end

				arg_375_1.text_.text = var_378_5
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404095", "story_v_side_new_1103404.awb") ~= 0 then
					local var_378_9 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404095", "story_v_side_new_1103404.awb") / 1000

					if var_378_9 + var_378_1 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_1
					end

					if var_378_4.prefab_name ~= "" and arg_375_1.actors_[var_378_4.prefab_name] ~= nil then
						local var_378_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_4.prefab_name].transform, "story_v_side_new_1103404", "1103404095", "story_v_side_new_1103404.awb")

						arg_375_1:RecordAudio("1103404095", var_378_10)
						arg_375_1:RecordAudio("1103404095", var_378_10)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404095", "story_v_side_new_1103404.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404095", "story_v_side_new_1103404.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_11 = math.max(var_378_2, arg_375_1.talkMaxDuration)

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_11 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_1) / var_378_11

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_1 + var_378_11 and arg_375_1.time_ < var_378_1 + var_378_11 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play1103404096 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 1103404096
		arg_379_1.duration_ = 2.83

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play1103404097(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0
			local var_382_1 = 0.325

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_2 = arg_379_1:FormatText(StoryNameCfg[714].name)

				arg_379_1.leftNameTxt_.text = var_382_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, true)
				arg_379_1.iconController_:SetSelectedState("hero")

				arg_379_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboya")

				arg_379_1.callingController_:SetSelectedState("normal")

				arg_379_1.keyicon_.color = Color.New(1, 1, 1)
				arg_379_1.icon_.color = Color.New(1, 1, 1)

				local var_382_3 = arg_379_1:GetWordFromCfg(1103404096)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 13
				local var_382_6 = utf8.len(var_382_4)
				local var_382_7 = var_382_5 <= 0 and var_382_1 or var_382_1 * (var_382_6 / var_382_5)

				if var_382_7 > 0 and var_382_1 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_0
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404096", "story_v_side_new_1103404.awb") ~= 0 then
					local var_382_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404096", "story_v_side_new_1103404.awb") / 1000

					if var_382_8 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_8 + var_382_0
					end

					if var_382_3.prefab_name ~= "" and arg_379_1.actors_[var_382_3.prefab_name] ~= nil then
						local var_382_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_3.prefab_name].transform, "story_v_side_new_1103404", "1103404096", "story_v_side_new_1103404.awb")

						arg_379_1:RecordAudio("1103404096", var_382_9)
						arg_379_1:RecordAudio("1103404096", var_382_9)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404096", "story_v_side_new_1103404.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404096", "story_v_side_new_1103404.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_10 = math.max(var_382_1, arg_379_1.talkMaxDuration)

			if var_382_0 <= arg_379_1.time_ and arg_379_1.time_ < var_382_0 + var_382_10 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_0) / var_382_10

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_0 + var_382_10 and arg_379_1.time_ < var_382_0 + var_382_10 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play1103404097 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 1103404097
		arg_383_1.duration_ = 3.8

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play1103404098(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1034ui_story"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1034ui_story == nil then
				arg_383_1.var_.characterEffect1034ui_story = var_386_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.2

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 and not isNil(var_386_0) then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.characterEffect1034ui_story and not isNil(var_386_0) then
					arg_383_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and not isNil(var_386_0) and arg_383_1.var_.characterEffect1034ui_story then
				arg_383_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_386_4 = 0

			if var_386_4 < arg_383_1.time_ and arg_383_1.time_ <= var_386_4 + arg_386_0 then
				arg_383_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			local var_386_5 = 0

			if var_386_5 < arg_383_1.time_ and arg_383_1.time_ <= var_386_5 + arg_386_0 then
				arg_383_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_386_6 = 0
			local var_386_7 = 0.5

			if var_386_6 < arg_383_1.time_ and arg_383_1.time_ <= var_386_6 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_8 = arg_383_1:FormatText(StoryNameCfg[1109].name)

				arg_383_1.leftNameTxt_.text = var_386_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, false)
				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_9 = arg_383_1:GetWordFromCfg(1103404097)
				local var_386_10 = arg_383_1:FormatText(var_386_9.content)

				arg_383_1.text_.text = var_386_10

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_11 = 20
				local var_386_12 = utf8.len(var_386_10)
				local var_386_13 = var_386_11 <= 0 and var_386_7 or var_386_7 * (var_386_12 / var_386_11)

				if var_386_13 > 0 and var_386_7 < var_386_13 then
					arg_383_1.talkMaxDuration = var_386_13

					if var_386_13 + var_386_6 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_13 + var_386_6
					end
				end

				arg_383_1.text_.text = var_386_10
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404097", "story_v_side_new_1103404.awb") ~= 0 then
					local var_386_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404097", "story_v_side_new_1103404.awb") / 1000

					if var_386_14 + var_386_6 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_14 + var_386_6
					end

					if var_386_9.prefab_name ~= "" and arg_383_1.actors_[var_386_9.prefab_name] ~= nil then
						local var_386_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_9.prefab_name].transform, "story_v_side_new_1103404", "1103404097", "story_v_side_new_1103404.awb")

						arg_383_1:RecordAudio("1103404097", var_386_15)
						arg_383_1:RecordAudio("1103404097", var_386_15)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404097", "story_v_side_new_1103404.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404097", "story_v_side_new_1103404.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_16 = math.max(var_386_7, arg_383_1.talkMaxDuration)

			if var_386_6 <= arg_383_1.time_ and arg_383_1.time_ < var_386_6 + var_386_16 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_6) / var_386_16

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_6 + var_386_16 and arg_383_1.time_ < var_386_6 + var_386_16 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play1103404098 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 1103404098
		arg_387_1.duration_ = 5.53

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play1103404099(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = 0

			if var_390_0 < arg_387_1.time_ and arg_387_1.time_ <= var_390_0 + arg_390_0 then
				arg_387_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 then
				arg_387_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			local var_390_2 = 0
			local var_390_3 = 0.675

			if var_390_2 < arg_387_1.time_ and arg_387_1.time_ <= var_390_2 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_4 = arg_387_1:FormatText(StoryNameCfg[1109].name)

				arg_387_1.leftNameTxt_.text = var_390_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_5 = arg_387_1:GetWordFromCfg(1103404098)
				local var_390_6 = arg_387_1:FormatText(var_390_5.content)

				arg_387_1.text_.text = var_390_6

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_7 = 27
				local var_390_8 = utf8.len(var_390_6)
				local var_390_9 = var_390_7 <= 0 and var_390_3 or var_390_3 * (var_390_8 / var_390_7)

				if var_390_9 > 0 and var_390_3 < var_390_9 then
					arg_387_1.talkMaxDuration = var_390_9

					if var_390_9 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_9 + var_390_2
					end
				end

				arg_387_1.text_.text = var_390_6
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404098", "story_v_side_new_1103404.awb") ~= 0 then
					local var_390_10 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404098", "story_v_side_new_1103404.awb") / 1000

					if var_390_10 + var_390_2 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_10 + var_390_2
					end

					if var_390_5.prefab_name ~= "" and arg_387_1.actors_[var_390_5.prefab_name] ~= nil then
						local var_390_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_5.prefab_name].transform, "story_v_side_new_1103404", "1103404098", "story_v_side_new_1103404.awb")

						arg_387_1:RecordAudio("1103404098", var_390_11)
						arg_387_1:RecordAudio("1103404098", var_390_11)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404098", "story_v_side_new_1103404.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404098", "story_v_side_new_1103404.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_12 = math.max(var_390_3, arg_387_1.talkMaxDuration)

			if var_390_2 <= arg_387_1.time_ and arg_387_1.time_ < var_390_2 + var_390_12 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_2) / var_390_12

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_2 + var_390_12 and arg_387_1.time_ < var_390_2 + var_390_12 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end

		arg_387_1.nodeConfigList_ = {}

		arg_387_1:InitPlayNodeList()
	end,
	Play1103404099 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 1103404099
		arg_391_1.duration_ = 5

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play1103404100(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1034ui_story"].transform
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 then
				arg_391_1.var_.moveOldPos1034ui_story = var_394_0.localPosition
			end

			local var_394_2 = 0.001

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2
				local var_394_4 = Vector3.New(0, 100, 0)

				var_394_0.localPosition = Vector3.Lerp(arg_391_1.var_.moveOldPos1034ui_story, var_394_4, var_394_3)

				local var_394_5 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_5.x, var_394_5.y, var_394_5.z)

				local var_394_6 = var_394_0.localEulerAngles

				var_394_6.z = 0
				var_394_6.x = 0
				var_394_0.localEulerAngles = var_394_6
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 then
				var_394_0.localPosition = Vector3.New(0, 100, 0)

				local var_394_7 = manager.ui.mainCamera.transform.position - var_394_0.position

				var_394_0.forward = Vector3.New(var_394_7.x, var_394_7.y, var_394_7.z)

				local var_394_8 = var_394_0.localEulerAngles

				var_394_8.z = 0
				var_394_8.x = 0
				var_394_0.localEulerAngles = var_394_8
			end

			local var_394_9 = 1

			if var_394_9 < arg_391_1.time_ and arg_391_1.time_ <= var_394_9 + arg_394_0 then
				arg_391_1.allBtn_.enabled = false
			end

			local var_394_10 = 0.4

			if arg_391_1.time_ >= var_394_9 + var_394_10 and arg_391_1.time_ < var_394_9 + var_394_10 + arg_394_0 then
				arg_391_1.allBtn_.enabled = true
			end

			local var_394_11 = 1
			local var_394_12 = 1

			if var_394_11 < arg_391_1.time_ and arg_391_1.time_ <= var_394_11 + arg_394_0 then
				local var_394_13 = "play"
				local var_394_14 = "effect"

				arg_391_1:AudioAction(var_394_13, var_394_14, "se_story_15", "se_story_15_kick", "")
			end

			local var_394_15 = 0
			local var_394_16 = 1.4

			if var_394_15 < arg_391_1.time_ and arg_391_1.time_ <= var_394_15 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0

				arg_391_1.dialog_:SetActive(true)

				arg_391_1.dialogCg_.alpha = 0

				local var_394_17 = LeanTween.value(arg_391_1.dialog_, 0, 1, 0.3)

				var_394_17:setOnUpdate(LuaHelper.FloatAction(function(arg_395_0)
					arg_391_1.dialogCg_.alpha = arg_395_0
				end))
				var_394_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_391_1.dialog_)
					var_394_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_391_1.duration_ = arg_391_1.duration_ + 0.3

				SetActive(arg_391_1.leftNameGo_, false)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_391_1.iconTrs_.gameObject, false)
				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_18 = arg_391_1:GetWordFromCfg(1103404099)
				local var_394_19 = arg_391_1:FormatText(var_394_18.content)

				arg_391_1.text_.text = var_394_19

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_20 = 56
				local var_394_21 = utf8.len(var_394_19)
				local var_394_22 = var_394_20 <= 0 and var_394_16 or var_394_16 * (var_394_21 / var_394_20)

				if var_394_22 > 0 and var_394_16 < var_394_22 then
					arg_391_1.talkMaxDuration = var_394_22
					var_394_15 = var_394_15 + 0.3

					if var_394_22 + var_394_15 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_22 + var_394_15
					end
				end

				arg_391_1.text_.text = var_394_19
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)
				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_23 = var_394_15 + 0.3
			local var_394_24 = math.max(var_394_16, arg_391_1.talkMaxDuration)

			if var_394_23 <= arg_391_1.time_ and arg_391_1.time_ < var_394_23 + var_394_24 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_23) / var_394_24

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_23 + var_394_24 and arg_391_1.time_ < var_394_23 + var_394_24 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end

		arg_391_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "I11o",
				frequency = 100,
				className = "StoryShakeNode",
				duration = 0.233333333333333,
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.BACKGROUND,
				offset = Vector3.New(0.2, 0.2, 0.2)
			}
		}

		arg_391_1:InitPlayNodeList()
	end,
	Play1103404100 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 1103404100
		arg_397_1.duration_ = 2.3

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play1103404101(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_0 = arg_397_1.actors_["1034ui_story"]
			local var_400_1 = 0

			if var_400_1 < arg_397_1.time_ and arg_397_1.time_ <= var_400_1 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1034ui_story == nil then
				arg_397_1.var_.characterEffect1034ui_story = var_400_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if var_400_1 <= arg_397_1.time_ and arg_397_1.time_ < var_400_1 + var_400_2 and not isNil(var_400_0) then
				local var_400_3 = (arg_397_1.time_ - var_400_1) / var_400_2

				if arg_397_1.var_.characterEffect1034ui_story and not isNil(var_400_0) then
					arg_397_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= var_400_1 + var_400_2 and arg_397_1.time_ < var_400_1 + var_400_2 + arg_400_0 and not isNil(var_400_0) and arg_397_1.var_.characterEffect1034ui_story then
				arg_397_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_400_4 = 0

			if var_400_4 < arg_397_1.time_ and arg_397_1.time_ <= var_400_4 + arg_400_0 then
				arg_397_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_400_5 = 0

			if var_400_5 < arg_397_1.time_ and arg_397_1.time_ <= var_400_5 + arg_400_0 then
				arg_397_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_400_6 = arg_397_1.actors_["1034ui_story"].transform
			local var_400_7 = 0

			if var_400_7 < arg_397_1.time_ and arg_397_1.time_ <= var_400_7 + arg_400_0 then
				arg_397_1.var_.moveOldPos1034ui_story = var_400_6.localPosition
			end

			local var_400_8 = 0.001

			if var_400_7 <= arg_397_1.time_ and arg_397_1.time_ < var_400_7 + var_400_8 then
				local var_400_9 = (arg_397_1.time_ - var_400_7) / var_400_8
				local var_400_10 = Vector3.New(0, -0.93, -6)

				var_400_6.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1034ui_story, var_400_10, var_400_9)

				local var_400_11 = manager.ui.mainCamera.transform.position - var_400_6.position

				var_400_6.forward = Vector3.New(var_400_11.x, var_400_11.y, var_400_11.z)

				local var_400_12 = var_400_6.localEulerAngles

				var_400_12.z = 0
				var_400_12.x = 0
				var_400_6.localEulerAngles = var_400_12
			end

			if arg_397_1.time_ >= var_400_7 + var_400_8 and arg_397_1.time_ < var_400_7 + var_400_8 + arg_400_0 then
				var_400_6.localPosition = Vector3.New(0, -0.93, -6)

				local var_400_13 = manager.ui.mainCamera.transform.position - var_400_6.position

				var_400_6.forward = Vector3.New(var_400_13.x, var_400_13.y, var_400_13.z)

				local var_400_14 = var_400_6.localEulerAngles

				var_400_14.z = 0
				var_400_14.x = 0
				var_400_6.localEulerAngles = var_400_14
			end

			local var_400_15 = 0
			local var_400_16 = 0.225

			if var_400_15 < arg_397_1.time_ and arg_397_1.time_ <= var_400_15 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				local var_400_17 = arg_397_1:FormatText(StoryNameCfg[1109].name)

				arg_397_1.leftNameTxt_.text = var_400_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_18 = arg_397_1:GetWordFromCfg(1103404100)
				local var_400_19 = arg_397_1:FormatText(var_400_18.content)

				arg_397_1.text_.text = var_400_19

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_20 = 9
				local var_400_21 = utf8.len(var_400_19)
				local var_400_22 = var_400_20 <= 0 and var_400_16 or var_400_16 * (var_400_21 / var_400_20)

				if var_400_22 > 0 and var_400_16 < var_400_22 then
					arg_397_1.talkMaxDuration = var_400_22

					if var_400_22 + var_400_15 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_22 + var_400_15
					end
				end

				arg_397_1.text_.text = var_400_19
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404100", "story_v_side_new_1103404.awb") ~= 0 then
					local var_400_23 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404100", "story_v_side_new_1103404.awb") / 1000

					if var_400_23 + var_400_15 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_23 + var_400_15
					end

					if var_400_18.prefab_name ~= "" and arg_397_1.actors_[var_400_18.prefab_name] ~= nil then
						local var_400_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_18.prefab_name].transform, "story_v_side_new_1103404", "1103404100", "story_v_side_new_1103404.awb")

						arg_397_1:RecordAudio("1103404100", var_400_24)
						arg_397_1:RecordAudio("1103404100", var_400_24)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404100", "story_v_side_new_1103404.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404100", "story_v_side_new_1103404.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_25 = math.max(var_400_16, arg_397_1.talkMaxDuration)

			if var_400_15 <= arg_397_1.time_ and arg_397_1.time_ < var_400_15 + var_400_25 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_15) / var_400_25

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_15 + var_400_25 and arg_397_1.time_ < var_400_15 + var_400_25 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play1103404101 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 1103404101
		arg_401_1.duration_ = 3.8

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play1103404102(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = arg_401_1.actors_["1034ui_story"].transform
			local var_404_1 = 0

			if var_404_1 < arg_401_1.time_ and arg_401_1.time_ <= var_404_1 + arg_404_0 then
				arg_401_1.var_.moveOldPos1034ui_story = var_404_0.localPosition
			end

			local var_404_2 = 0.001

			if var_404_1 <= arg_401_1.time_ and arg_401_1.time_ < var_404_1 + var_404_2 then
				local var_404_3 = (arg_401_1.time_ - var_404_1) / var_404_2
				local var_404_4 = Vector3.New(0, 100, 0)

				var_404_0.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1034ui_story, var_404_4, var_404_3)

				local var_404_5 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_5.x, var_404_5.y, var_404_5.z)

				local var_404_6 = var_404_0.localEulerAngles

				var_404_6.z = 0
				var_404_6.x = 0
				var_404_0.localEulerAngles = var_404_6
			end

			if arg_401_1.time_ >= var_404_1 + var_404_2 and arg_401_1.time_ < var_404_1 + var_404_2 + arg_404_0 then
				var_404_0.localPosition = Vector3.New(0, 100, 0)

				local var_404_7 = manager.ui.mainCamera.transform.position - var_404_0.position

				var_404_0.forward = Vector3.New(var_404_7.x, var_404_7.y, var_404_7.z)

				local var_404_8 = var_404_0.localEulerAngles

				var_404_8.z = 0
				var_404_8.x = 0
				var_404_0.localEulerAngles = var_404_8
			end

			local var_404_9 = arg_401_1.actors_["1034ui_story"].transform
			local var_404_10 = 0.533333333333333

			if var_404_10 < arg_401_1.time_ and arg_401_1.time_ <= var_404_10 + arg_404_0 then
				arg_401_1.var_.moveOldPos1034ui_story = var_404_9.localPosition
			end

			local var_404_11 = 0.001

			if var_404_10 <= arg_401_1.time_ and arg_401_1.time_ < var_404_10 + var_404_11 then
				local var_404_12 = (arg_401_1.time_ - var_404_10) / var_404_11
				local var_404_13 = Vector3.New(0, -0.93, -6)

				var_404_9.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1034ui_story, var_404_13, var_404_12)

				local var_404_14 = manager.ui.mainCamera.transform.position - var_404_9.position

				var_404_9.forward = Vector3.New(var_404_14.x, var_404_14.y, var_404_14.z)

				local var_404_15 = var_404_9.localEulerAngles

				var_404_15.z = 0
				var_404_15.x = 0
				var_404_9.localEulerAngles = var_404_15
			end

			if arg_401_1.time_ >= var_404_10 + var_404_11 and arg_401_1.time_ < var_404_10 + var_404_11 + arg_404_0 then
				var_404_9.localPosition = Vector3.New(0, -0.93, -6)

				local var_404_16 = manager.ui.mainCamera.transform.position - var_404_9.position

				var_404_9.forward = Vector3.New(var_404_16.x, var_404_16.y, var_404_16.z)

				local var_404_17 = var_404_9.localEulerAngles

				var_404_17.z = 0
				var_404_17.x = 0
				var_404_9.localEulerAngles = var_404_17
			end

			local var_404_18 = 0
			local var_404_19 = 1

			if var_404_18 < arg_401_1.time_ and arg_401_1.time_ <= var_404_18 + arg_404_0 then
				local var_404_20 = "play"
				local var_404_21 = "effect"

				arg_401_1:AudioAction(var_404_20, var_404_21, "se_story_120_04", "se_story_120_04_punch", "")
			end

			local var_404_22 = 0.533333333333333

			if var_404_22 < arg_401_1.time_ and arg_401_1.time_ <= var_404_22 + arg_404_0 then
				arg_401_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			local var_404_23 = 0.533333333333333

			if var_404_23 < arg_401_1.time_ and arg_401_1.time_ <= var_404_23 + arg_404_0 then
				arg_401_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			if arg_401_1.frameCnt_ <= 1 then
				arg_401_1.dialog_:SetActive(false)
			end

			local var_404_24 = 0.533333333333333
			local var_404_25 = 0.375

			if var_404_24 < arg_401_1.time_ and arg_401_1.time_ <= var_404_24 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0

				arg_401_1.dialog_:SetActive(true)

				arg_401_1.dialogCg_.alpha = 0

				local var_404_26 = LeanTween.value(arg_401_1.dialog_, 0, 1, 0.3)

				var_404_26:setOnUpdate(LuaHelper.FloatAction(function(arg_405_0)
					arg_401_1.dialogCg_.alpha = arg_405_0
				end))
				var_404_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_401_1.dialog_)
					var_404_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_401_1.duration_ = arg_401_1.duration_ + 0.3

				SetActive(arg_401_1.leftNameGo_, true)

				local var_404_27 = arg_401_1:FormatText(StoryNameCfg[1109].name)

				arg_401_1.leftNameTxt_.text = var_404_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_28 = arg_401_1:GetWordFromCfg(1103404101)
				local var_404_29 = arg_401_1:FormatText(var_404_28.content)

				arg_401_1.text_.text = var_404_29

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_30 = 15
				local var_404_31 = utf8.len(var_404_29)
				local var_404_32 = var_404_30 <= 0 and var_404_25 or var_404_25 * (var_404_31 / var_404_30)

				if var_404_32 > 0 and var_404_25 < var_404_32 then
					arg_401_1.talkMaxDuration = var_404_32
					var_404_24 = var_404_24 + 0.3

					if var_404_32 + var_404_24 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_32 + var_404_24
					end
				end

				arg_401_1.text_.text = var_404_29
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404101", "story_v_side_new_1103404.awb") ~= 0 then
					local var_404_33 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404101", "story_v_side_new_1103404.awb") / 1000

					if var_404_33 + var_404_24 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_33 + var_404_24
					end

					if var_404_28.prefab_name ~= "" and arg_401_1.actors_[var_404_28.prefab_name] ~= nil then
						local var_404_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_28.prefab_name].transform, "story_v_side_new_1103404", "1103404101", "story_v_side_new_1103404.awb")

						arg_401_1:RecordAudio("1103404101", var_404_34)
						arg_401_1:RecordAudio("1103404101", var_404_34)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404101", "story_v_side_new_1103404.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404101", "story_v_side_new_1103404.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_35 = var_404_24 + 0.3
			local var_404_36 = math.max(var_404_25, arg_401_1.talkMaxDuration)

			if var_404_35 <= arg_401_1.time_ and arg_401_1.time_ < var_404_35 + var_404_36 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_35) / var_404_36

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_35 + var_404_36 and arg_401_1.time_ < var_404_35 + var_404_36 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.533333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "I11o",
				frequency = 100,
				className = "StoryShakeNode",
				duration = 0.1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.BACKGROUND,
				offset = Vector3.New(0.2, 0.2, 0.2)
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play1103404102 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 1103404102
		arg_407_1.duration_ = 5.2

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play1103404103(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = 0
			local var_410_1 = 0.675

			if var_410_0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_0 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_2 = arg_407_1:FormatText(StoryNameCfg[1109].name)

				arg_407_1.leftNameTxt_.text = var_410_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_3 = arg_407_1:GetWordFromCfg(1103404102)
				local var_410_4 = arg_407_1:FormatText(var_410_3.content)

				arg_407_1.text_.text = var_410_4

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_5 = 27
				local var_410_6 = utf8.len(var_410_4)
				local var_410_7 = var_410_5 <= 0 and var_410_1 or var_410_1 * (var_410_6 / var_410_5)

				if var_410_7 > 0 and var_410_1 < var_410_7 then
					arg_407_1.talkMaxDuration = var_410_7

					if var_410_7 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_0
					end
				end

				arg_407_1.text_.text = var_410_4
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404102", "story_v_side_new_1103404.awb") ~= 0 then
					local var_410_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404102", "story_v_side_new_1103404.awb") / 1000

					if var_410_8 + var_410_0 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_8 + var_410_0
					end

					if var_410_3.prefab_name ~= "" and arg_407_1.actors_[var_410_3.prefab_name] ~= nil then
						local var_410_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_3.prefab_name].transform, "story_v_side_new_1103404", "1103404102", "story_v_side_new_1103404.awb")

						arg_407_1:RecordAudio("1103404102", var_410_9)
						arg_407_1:RecordAudio("1103404102", var_410_9)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404102", "story_v_side_new_1103404.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404102", "story_v_side_new_1103404.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_10 = math.max(var_410_1, arg_407_1.talkMaxDuration)

			if var_410_0 <= arg_407_1.time_ and arg_407_1.time_ < var_410_0 + var_410_10 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_0) / var_410_10

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_0 + var_410_10 and arg_407_1.time_ < var_410_0 + var_410_10 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play1103404103 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 1103404103
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play1103404104(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = 0

			if var_414_0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_0 + arg_414_0 then
				arg_411_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action465")
			end

			local var_414_1 = 1.17961196366423e-16

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 then
				arg_411_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_414_2 = 0
			local var_414_3 = 1.5

			if var_414_2 < arg_411_1.time_ and arg_411_1.time_ <= var_414_2 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, false)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_411_1.iconTrs_.gameObject, false)
				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_4 = arg_411_1:GetWordFromCfg(1103404103)
				local var_414_5 = arg_411_1:FormatText(var_414_4.content)

				arg_411_1.text_.text = var_414_5

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_6 = 60
				local var_414_7 = utf8.len(var_414_5)
				local var_414_8 = var_414_6 <= 0 and var_414_3 or var_414_3 * (var_414_7 / var_414_6)

				if var_414_8 > 0 and var_414_3 < var_414_8 then
					arg_411_1.talkMaxDuration = var_414_8

					if var_414_8 + var_414_2 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_8 + var_414_2
					end
				end

				arg_411_1.text_.text = var_414_5
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_9 = math.max(var_414_3, arg_411_1.talkMaxDuration)

			if var_414_2 <= arg_411_1.time_ and arg_411_1.time_ < var_414_2 + var_414_9 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_2) / var_414_9

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_2 + var_414_9 and arg_411_1.time_ < var_414_2 + var_414_9 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play1103404104 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 1103404104
		arg_415_1.duration_ = 2

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play1103404105(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["1034ui_story"]
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect1034ui_story == nil then
				arg_415_1.var_.characterEffect1034ui_story = var_418_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.200000002980232

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 and not isNil(var_418_0) then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2

				if arg_415_1.var_.characterEffect1034ui_story and not isNil(var_418_0) then
					arg_415_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 and not isNil(var_418_0) and arg_415_1.var_.characterEffect1034ui_story then
				arg_415_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_418_4 = 0

			if var_418_4 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_418_5 = arg_415_1.actors_["1034ui_story"].transform
			local var_418_6 = 0

			if var_418_6 < arg_415_1.time_ and arg_415_1.time_ <= var_418_6 + arg_418_0 then
				arg_415_1.var_.moveOldPos1034ui_story = var_418_5.localPosition
			end

			local var_418_7 = 0.001

			if var_418_6 <= arg_415_1.time_ and arg_415_1.time_ < var_418_6 + var_418_7 then
				local var_418_8 = (arg_415_1.time_ - var_418_6) / var_418_7
				local var_418_9 = Vector3.New(0, -0.93, -6)

				var_418_5.localPosition = Vector3.Lerp(arg_415_1.var_.moveOldPos1034ui_story, var_418_9, var_418_8)

				local var_418_10 = manager.ui.mainCamera.transform.position - var_418_5.position

				var_418_5.forward = Vector3.New(var_418_10.x, var_418_10.y, var_418_10.z)

				local var_418_11 = var_418_5.localEulerAngles

				var_418_11.z = 0
				var_418_11.x = 0
				var_418_5.localEulerAngles = var_418_11
			end

			if arg_415_1.time_ >= var_418_6 + var_418_7 and arg_415_1.time_ < var_418_6 + var_418_7 + arg_418_0 then
				var_418_5.localPosition = Vector3.New(0, -0.93, -6)

				local var_418_12 = manager.ui.mainCamera.transform.position - var_418_5.position

				var_418_5.forward = Vector3.New(var_418_12.x, var_418_12.y, var_418_12.z)

				local var_418_13 = var_418_5.localEulerAngles

				var_418_13.z = 0
				var_418_13.x = 0
				var_418_5.localEulerAngles = var_418_13
			end

			local var_418_14 = 0
			local var_418_15 = 0.425

			if var_418_14 < arg_415_1.time_ and arg_415_1.time_ <= var_418_14 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_16 = arg_415_1:FormatText(StoryNameCfg[1109].name)

				arg_415_1.leftNameTxt_.text = var_418_16

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_17 = arg_415_1:GetWordFromCfg(1103404104)
				local var_418_18 = arg_415_1:FormatText(var_418_17.content)

				arg_415_1.text_.text = var_418_18

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_19 = 17
				local var_418_20 = utf8.len(var_418_18)
				local var_418_21 = var_418_19 <= 0 and var_418_15 or var_418_15 * (var_418_20 / var_418_19)

				if var_418_21 > 0 and var_418_15 < var_418_21 then
					arg_415_1.talkMaxDuration = var_418_21

					if var_418_21 + var_418_14 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_21 + var_418_14
					end
				end

				arg_415_1.text_.text = var_418_18
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404104", "story_v_side_new_1103404.awb") ~= 0 then
					local var_418_22 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404104", "story_v_side_new_1103404.awb") / 1000

					if var_418_22 + var_418_14 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_22 + var_418_14
					end

					if var_418_17.prefab_name ~= "" and arg_415_1.actors_[var_418_17.prefab_name] ~= nil then
						local var_418_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_17.prefab_name].transform, "story_v_side_new_1103404", "1103404104", "story_v_side_new_1103404.awb")

						arg_415_1:RecordAudio("1103404104", var_418_23)
						arg_415_1:RecordAudio("1103404104", var_418_23)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404104", "story_v_side_new_1103404.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404104", "story_v_side_new_1103404.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_24 = math.max(var_418_15, arg_415_1.talkMaxDuration)

			if var_418_14 <= arg_415_1.time_ and arg_415_1.time_ < var_418_14 + var_418_24 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_14) / var_418_24

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_14 + var_418_24 and arg_415_1.time_ < var_418_14 + var_418_24 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_415_1:InitPlayNodeList()
	end,
	Play1103404105 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 1103404105
		arg_419_1.duration_ = 3.37

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play1103404106(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_422_1 = 0
			local var_422_2 = 0.35

			if var_422_1 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_3 = arg_419_1:FormatText(StoryNameCfg[1109].name)

				arg_419_1.leftNameTxt_.text = var_422_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_4 = arg_419_1:GetWordFromCfg(1103404105)
				local var_422_5 = arg_419_1:FormatText(var_422_4.content)

				arg_419_1.text_.text = var_422_5

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_6 = 14
				local var_422_7 = utf8.len(var_422_5)
				local var_422_8 = var_422_6 <= 0 and var_422_2 or var_422_2 * (var_422_7 / var_422_6)

				if var_422_8 > 0 and var_422_2 < var_422_8 then
					arg_419_1.talkMaxDuration = var_422_8

					if var_422_8 + var_422_1 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_1
					end
				end

				arg_419_1.text_.text = var_422_5
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404105", "story_v_side_new_1103404.awb") ~= 0 then
					local var_422_9 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404105", "story_v_side_new_1103404.awb") / 1000

					if var_422_9 + var_422_1 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_9 + var_422_1
					end

					if var_422_4.prefab_name ~= "" and arg_419_1.actors_[var_422_4.prefab_name] ~= nil then
						local var_422_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_4.prefab_name].transform, "story_v_side_new_1103404", "1103404105", "story_v_side_new_1103404.awb")

						arg_419_1:RecordAudio("1103404105", var_422_10)
						arg_419_1:RecordAudio("1103404105", var_422_10)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404105", "story_v_side_new_1103404.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404105", "story_v_side_new_1103404.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_11 = math.max(var_422_2, arg_419_1.talkMaxDuration)

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_11 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_1) / var_422_11

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_1 + var_422_11 and arg_419_1.time_ < var_422_1 + var_422_11 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play1103404106 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 1103404106
		arg_423_1.duration_ = 9

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play1103404107(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = 2

			if var_426_0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_0 + arg_426_0 then
				local var_426_1 = manager.ui.mainCamera.transform.localPosition
				local var_426_2 = Vector3.New(0, 0, 10) + Vector3.New(var_426_1.x, var_426_1.y, 0)
				local var_426_3 = arg_423_1.bgs_.I11p

				var_426_3.transform.localPosition = var_426_2
				var_426_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_426_4 = var_426_3:GetComponent("SpriteRenderer")

				if var_426_4 and var_426_4.sprite then
					local var_426_5 = (var_426_3.transform.localPosition - var_426_1).z
					local var_426_6 = manager.ui.mainCameraCom_
					local var_426_7 = 2 * var_426_5 * Mathf.Tan(var_426_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_426_8 = var_426_7 * var_426_6.aspect
					local var_426_9 = var_426_4.sprite.bounds.size.x
					local var_426_10 = var_426_4.sprite.bounds.size.y
					local var_426_11 = var_426_8 / var_426_9
					local var_426_12 = var_426_7 / var_426_10
					local var_426_13 = var_426_12 < var_426_11 and var_426_11 or var_426_12

					var_426_3.transform.localScale = Vector3.New(var_426_13, var_426_13, 0)
				end

				for iter_426_0, iter_426_1 in pairs(arg_423_1.bgs_) do
					if iter_426_0 ~= "I11p" then
						iter_426_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_426_14 = 4

			if var_426_14 < arg_423_1.time_ and arg_423_1.time_ <= var_426_14 + arg_426_0 then
				arg_423_1.allBtn_.enabled = false
			end

			local var_426_15 = 0.3

			if arg_423_1.time_ >= var_426_14 + var_426_15 and arg_423_1.time_ < var_426_14 + var_426_15 + arg_426_0 then
				arg_423_1.allBtn_.enabled = true
			end

			local var_426_16 = 0

			if var_426_16 < arg_423_1.time_ and arg_423_1.time_ <= var_426_16 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_17 = 2

			if var_426_16 <= arg_423_1.time_ and arg_423_1.time_ < var_426_16 + var_426_17 then
				local var_426_18 = (arg_423_1.time_ - var_426_16) / var_426_17
				local var_426_19 = Color.New(0, 0, 0)

				var_426_19.a = Mathf.Lerp(0, 1, var_426_18)
				arg_423_1.mask_.color = var_426_19
			end

			if arg_423_1.time_ >= var_426_16 + var_426_17 and arg_423_1.time_ < var_426_16 + var_426_17 + arg_426_0 then
				local var_426_20 = Color.New(0, 0, 0)

				var_426_20.a = 1
				arg_423_1.mask_.color = var_426_20
			end

			local var_426_21 = 2

			if var_426_21 < arg_423_1.time_ and arg_423_1.time_ <= var_426_21 + arg_426_0 then
				arg_423_1.mask_.enabled = true
				arg_423_1.mask_.raycastTarget = true

				arg_423_1:SetGaussion(false)
			end

			local var_426_22 = 2

			if var_426_21 <= arg_423_1.time_ and arg_423_1.time_ < var_426_21 + var_426_22 then
				local var_426_23 = (arg_423_1.time_ - var_426_21) / var_426_22
				local var_426_24 = Color.New(0, 0, 0)

				var_426_24.a = Mathf.Lerp(1, 0, var_426_23)
				arg_423_1.mask_.color = var_426_24
			end

			if arg_423_1.time_ >= var_426_21 + var_426_22 and arg_423_1.time_ < var_426_21 + var_426_22 + arg_426_0 then
				local var_426_25 = Color.New(0, 0, 0)
				local var_426_26 = 0

				arg_423_1.mask_.enabled = false
				var_426_25.a = var_426_26
				arg_423_1.mask_.color = var_426_25
			end

			local var_426_27 = arg_423_1.actors_["1034ui_story"].transform
			local var_426_28 = 1.96599999815226

			if var_426_28 < arg_423_1.time_ and arg_423_1.time_ <= var_426_28 + arg_426_0 then
				arg_423_1.var_.moveOldPos1034ui_story = var_426_27.localPosition
			end

			local var_426_29 = 0.001

			if var_426_28 <= arg_423_1.time_ and arg_423_1.time_ < var_426_28 + var_426_29 then
				local var_426_30 = (arg_423_1.time_ - var_426_28) / var_426_29
				local var_426_31 = Vector3.New(0, 100, 0)

				var_426_27.localPosition = Vector3.Lerp(arg_423_1.var_.moveOldPos1034ui_story, var_426_31, var_426_30)

				local var_426_32 = manager.ui.mainCamera.transform.position - var_426_27.position

				var_426_27.forward = Vector3.New(var_426_32.x, var_426_32.y, var_426_32.z)

				local var_426_33 = var_426_27.localEulerAngles

				var_426_33.z = 0
				var_426_33.x = 0
				var_426_27.localEulerAngles = var_426_33
			end

			if arg_423_1.time_ >= var_426_28 + var_426_29 and arg_423_1.time_ < var_426_28 + var_426_29 + arg_426_0 then
				var_426_27.localPosition = Vector3.New(0, 100, 0)

				local var_426_34 = manager.ui.mainCamera.transform.position - var_426_27.position

				var_426_27.forward = Vector3.New(var_426_34.x, var_426_34.y, var_426_34.z)

				local var_426_35 = var_426_27.localEulerAngles

				var_426_35.z = 0
				var_426_35.x = 0
				var_426_27.localEulerAngles = var_426_35
			end

			local var_426_36 = arg_423_1.actors_["1034ui_story"]
			local var_426_37 = 1.96599999815226

			if var_426_37 < arg_423_1.time_ and arg_423_1.time_ <= var_426_37 + arg_426_0 and not isNil(var_426_36) and arg_423_1.var_.characterEffect1034ui_story == nil then
				arg_423_1.var_.characterEffect1034ui_story = var_426_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_38 = 0.034000001847744

			if var_426_37 <= arg_423_1.time_ and arg_423_1.time_ < var_426_37 + var_426_38 and not isNil(var_426_36) then
				local var_426_39 = (arg_423_1.time_ - var_426_37) / var_426_38

				if arg_423_1.var_.characterEffect1034ui_story and not isNil(var_426_36) then
					local var_426_40 = Mathf.Lerp(0, 0.5, var_426_39)

					arg_423_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1034ui_story.fillRatio = var_426_40
				end
			end

			if arg_423_1.time_ >= var_426_37 + var_426_38 and arg_423_1.time_ < var_426_37 + var_426_38 + arg_426_0 and not isNil(var_426_36) and arg_423_1.var_.characterEffect1034ui_story then
				local var_426_41 = 0.5

				arg_423_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1034ui_story.fillRatio = var_426_41
			end

			local var_426_42 = 0.233333333333333
			local var_426_43 = 0.3

			if var_426_42 < arg_423_1.time_ and arg_423_1.time_ <= var_426_42 + arg_426_0 then
				local var_426_44 = "play"
				local var_426_45 = "music"

				arg_423_1:AudioAction(var_426_44, var_426_45, "ui_battle", "ui_battle_stopbgm", "")

				local var_426_46 = ""
				local var_426_47 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_426_47 ~= "" then
					if arg_423_1.bgmTxt_.text ~= var_426_47 and arg_423_1.bgmTxt_.text ~= "" then
						if arg_423_1.bgmTxt2_.text ~= "" then
							arg_423_1.bgmTxt_.text = arg_423_1.bgmTxt2_.text
						end

						arg_423_1.bgmTxt2_.text = var_426_47

						arg_423_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_423_1.bgmTxt_.text = var_426_47
						arg_423_1.bgmTxt2_.text = var_426_47
					end

					if arg_423_1.bgmTimer then
						arg_423_1.bgmTimer:Stop()

						arg_423_1.bgmTimer = nil
					end

					if arg_423_1.settingData.show_music_name == 1 then
						arg_423_1.musicController:SetSelectedState("show")
						arg_423_1.musicAnimator_:Play("open", 0, 0)

						if arg_423_1.settingData.music_time ~= 0 then
							arg_423_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_423_1.settingData.music_time), function()
								if arg_423_1 == nil or isNil(arg_423_1.bgmTxt_) then
									return
								end

								arg_423_1.musicController:SetSelectedState("hide")
								arg_423_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_426_48 = 0.233333333333333
			local var_426_49 = 1

			if var_426_48 < arg_423_1.time_ and arg_423_1.time_ <= var_426_48 + arg_426_0 then
				local var_426_50 = "stop"
				local var_426_51 = "effect"

				arg_423_1:AudioAction(var_426_50, var_426_51, "se_story_16", "se_story_16_street_loop", "")
			end

			local var_426_52 = 1.56666666666667
			local var_426_53 = 1

			if var_426_52 < arg_423_1.time_ and arg_423_1.time_ <= var_426_52 + arg_426_0 then
				local var_426_54 = "play"
				local var_426_55 = "effect"

				arg_423_1:AudioAction(var_426_54, var_426_55, "se_story_1310", "se_story_1310_nightloop", "")
			end

			if arg_423_1.frameCnt_ <= 1 then
				arg_423_1.dialog_:SetActive(false)
			end

			local var_426_56 = 4
			local var_426_57 = 1.65

			if var_426_56 < arg_423_1.time_ and arg_423_1.time_ <= var_426_56 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0

				arg_423_1.dialog_:SetActive(true)

				arg_423_1.dialogCg_.alpha = 0

				local var_426_58 = LeanTween.value(arg_423_1.dialog_, 0, 1, 0.3)

				var_426_58:setOnUpdate(LuaHelper.FloatAction(function(arg_428_0)
					arg_423_1.dialogCg_.alpha = arg_428_0
				end))
				var_426_58:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_423_1.dialog_)
					var_426_58:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_423_1.duration_ = arg_423_1.duration_ + 0.3

				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_59 = arg_423_1:GetWordFromCfg(1103404106)
				local var_426_60 = arg_423_1:FormatText(var_426_59.content)

				arg_423_1.text_.text = var_426_60

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_61 = 66
				local var_426_62 = utf8.len(var_426_60)
				local var_426_63 = var_426_61 <= 0 and var_426_57 or var_426_57 * (var_426_62 / var_426_61)

				if var_426_63 > 0 and var_426_57 < var_426_63 then
					arg_423_1.talkMaxDuration = var_426_63
					var_426_56 = var_426_56 + 0.3

					if var_426_63 + var_426_56 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_63 + var_426_56
					end
				end

				arg_423_1.text_.text = var_426_60
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_64 = var_426_56 + 0.3
			local var_426_65 = math.max(var_426_57, arg_423_1.talkMaxDuration)

			if var_426_64 <= arg_423_1.time_ and arg_423_1.time_ < var_426_64 + var_426_65 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_64) / var_426_65

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_64 + var_426_65 and arg_423_1.time_ < var_426_64 + var_426_65 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_423_1:InitPlayNodeList()
	end,
	Play1103404107 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 1103404107
		arg_430_1.duration_ = 5

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play1103404108(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			local var_433_0 = 0
			local var_433_1 = 1.35

			if var_433_0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_0 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, false)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_430_1.iconTrs_.gameObject, false)
				arg_430_1.callingController_:SetSelectedState("normal")

				local var_433_2 = arg_430_1:GetWordFromCfg(1103404107)
				local var_433_3 = arg_430_1:FormatText(var_433_2.content)

				arg_430_1.text_.text = var_433_3

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_4 = 54
				local var_433_5 = utf8.len(var_433_3)
				local var_433_6 = var_433_4 <= 0 and var_433_1 or var_433_1 * (var_433_5 / var_433_4)

				if var_433_6 > 0 and var_433_1 < var_433_6 then
					arg_430_1.talkMaxDuration = var_433_6

					if var_433_6 + var_433_0 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_6 + var_433_0
					end
				end

				arg_430_1.text_.text = var_433_3
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)
				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_7 = math.max(var_433_1, arg_430_1.talkMaxDuration)

			if var_433_0 <= arg_430_1.time_ and arg_430_1.time_ < var_433_0 + var_433_7 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_0) / var_433_7

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_0 + var_433_7 and arg_430_1.time_ < var_433_0 + var_433_7 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play1103404108 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 1103404108
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play1103404109(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 0
			local var_437_1 = 0.525

			if var_437_0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, true)

				local var_437_2 = arg_434_1:FormatText(StoryNameCfg[7].name)

				arg_434_1.leftNameTxt_.text = var_437_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_434_1.leftNameTxt_.transform)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1.leftNameTxt_.text)
				SetActive(arg_434_1.iconTrs_.gameObject, true)
				arg_434_1.iconController_:SetSelectedState("hero")

				arg_434_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_434_1.callingController_:SetSelectedState("normal")

				arg_434_1.keyicon_.color = Color.New(1, 1, 1)
				arg_434_1.icon_.color = Color.New(1, 1, 1)

				local var_437_3 = arg_434_1:GetWordFromCfg(1103404108)
				local var_437_4 = arg_434_1:FormatText(var_437_3.content)

				arg_434_1.text_.text = var_437_4

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 21
				local var_437_6 = utf8.len(var_437_4)
				local var_437_7 = var_437_5 <= 0 and var_437_1 or var_437_1 * (var_437_6 / var_437_5)

				if var_437_7 > 0 and var_437_1 < var_437_7 then
					arg_434_1.talkMaxDuration = var_437_7

					if var_437_7 + var_437_0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_7 + var_437_0
					end
				end

				arg_434_1.text_.text = var_437_4
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_8 = math.max(var_437_1, arg_434_1.talkMaxDuration)

			if var_437_0 <= arg_434_1.time_ and arg_434_1.time_ < var_437_0 + var_437_8 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_0) / var_437_8

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_0 + var_437_8 and arg_434_1.time_ < var_437_0 + var_437_8 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play1103404109 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 1103404109
		arg_438_1.duration_ = 5.4

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play1103404110(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = arg_438_1.actors_["1034ui_story"].transform
			local var_441_1 = 0

			if var_441_1 < arg_438_1.time_ and arg_438_1.time_ <= var_441_1 + arg_441_0 then
				arg_438_1.var_.moveOldPos1034ui_story = var_441_0.localPosition
			end

			local var_441_2 = 0.001

			if var_441_1 <= arg_438_1.time_ and arg_438_1.time_ < var_441_1 + var_441_2 then
				local var_441_3 = (arg_438_1.time_ - var_441_1) / var_441_2
				local var_441_4 = Vector3.New(0, -0.93, -6)

				var_441_0.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1034ui_story, var_441_4, var_441_3)

				local var_441_5 = manager.ui.mainCamera.transform.position - var_441_0.position

				var_441_0.forward = Vector3.New(var_441_5.x, var_441_5.y, var_441_5.z)

				local var_441_6 = var_441_0.localEulerAngles

				var_441_6.z = 0
				var_441_6.x = 0
				var_441_0.localEulerAngles = var_441_6
			end

			if arg_438_1.time_ >= var_441_1 + var_441_2 and arg_438_1.time_ < var_441_1 + var_441_2 + arg_441_0 then
				var_441_0.localPosition = Vector3.New(0, -0.93, -6)

				local var_441_7 = manager.ui.mainCamera.transform.position - var_441_0.position

				var_441_0.forward = Vector3.New(var_441_7.x, var_441_7.y, var_441_7.z)

				local var_441_8 = var_441_0.localEulerAngles

				var_441_8.z = 0
				var_441_8.x = 0
				var_441_0.localEulerAngles = var_441_8
			end

			local var_441_9 = arg_438_1.actors_["1034ui_story"]
			local var_441_10 = 0

			if var_441_10 < arg_438_1.time_ and arg_438_1.time_ <= var_441_10 + arg_441_0 and not isNil(var_441_9) and arg_438_1.var_.characterEffect1034ui_story == nil then
				arg_438_1.var_.characterEffect1034ui_story = var_441_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_11 = 0.200000002980232

			if var_441_10 <= arg_438_1.time_ and arg_438_1.time_ < var_441_10 + var_441_11 and not isNil(var_441_9) then
				local var_441_12 = (arg_438_1.time_ - var_441_10) / var_441_11

				if arg_438_1.var_.characterEffect1034ui_story and not isNil(var_441_9) then
					arg_438_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= var_441_10 + var_441_11 and arg_438_1.time_ < var_441_10 + var_441_11 + arg_441_0 and not isNil(var_441_9) and arg_438_1.var_.characterEffect1034ui_story then
				arg_438_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_441_13 = 0

			if var_441_13 < arg_438_1.time_ and arg_438_1.time_ <= var_441_13 + arg_441_0 then
				arg_438_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			local var_441_14 = 0

			if var_441_14 < arg_438_1.time_ and arg_438_1.time_ <= var_441_14 + arg_441_0 then
				arg_438_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_441_15 = 0
			local var_441_16 = 0.45

			if var_441_15 < arg_438_1.time_ and arg_438_1.time_ <= var_441_15 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				local var_441_17 = arg_438_1:FormatText(StoryNameCfg[1109].name)

				arg_438_1.leftNameTxt_.text = var_441_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_18 = arg_438_1:GetWordFromCfg(1103404109)
				local var_441_19 = arg_438_1:FormatText(var_441_18.content)

				arg_438_1.text_.text = var_441_19

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_20 = 18
				local var_441_21 = utf8.len(var_441_19)
				local var_441_22 = var_441_20 <= 0 and var_441_16 or var_441_16 * (var_441_21 / var_441_20)

				if var_441_22 > 0 and var_441_16 < var_441_22 then
					arg_438_1.talkMaxDuration = var_441_22

					if var_441_22 + var_441_15 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_22 + var_441_15
					end
				end

				arg_438_1.text_.text = var_441_19
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404109", "story_v_side_new_1103404.awb") ~= 0 then
					local var_441_23 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404109", "story_v_side_new_1103404.awb") / 1000

					if var_441_23 + var_441_15 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_23 + var_441_15
					end

					if var_441_18.prefab_name ~= "" and arg_438_1.actors_[var_441_18.prefab_name] ~= nil then
						local var_441_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_18.prefab_name].transform, "story_v_side_new_1103404", "1103404109", "story_v_side_new_1103404.awb")

						arg_438_1:RecordAudio("1103404109", var_441_24)
						arg_438_1:RecordAudio("1103404109", var_441_24)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404109", "story_v_side_new_1103404.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404109", "story_v_side_new_1103404.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_25 = math.max(var_441_16, arg_438_1.talkMaxDuration)

			if var_441_15 <= arg_438_1.time_ and arg_438_1.time_ < var_441_15 + var_441_25 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_15) / var_441_25

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_15 + var_441_25 and arg_438_1.time_ < var_441_15 + var_441_25 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_438_1:InitPlayNodeList()
	end,
	Play1103404110 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 1103404110
		arg_442_1.duration_ = 5.27

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play1103404111(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0

			if var_445_0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_0 + arg_445_0 then
				arg_442_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_445_1 = 0
			local var_445_2 = 0.625

			if var_445_1 < arg_442_1.time_ and arg_442_1.time_ <= var_445_1 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				local var_445_3 = arg_442_1:FormatText(StoryNameCfg[1109].name)

				arg_442_1.leftNameTxt_.text = var_445_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_4 = arg_442_1:GetWordFromCfg(1103404110)
				local var_445_5 = arg_442_1:FormatText(var_445_4.content)

				arg_442_1.text_.text = var_445_5

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_6 = 25
				local var_445_7 = utf8.len(var_445_5)
				local var_445_8 = var_445_6 <= 0 and var_445_2 or var_445_2 * (var_445_7 / var_445_6)

				if var_445_8 > 0 and var_445_2 < var_445_8 then
					arg_442_1.talkMaxDuration = var_445_8

					if var_445_8 + var_445_1 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_8 + var_445_1
					end
				end

				arg_442_1.text_.text = var_445_5
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404110", "story_v_side_new_1103404.awb") ~= 0 then
					local var_445_9 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404110", "story_v_side_new_1103404.awb") / 1000

					if var_445_9 + var_445_1 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_9 + var_445_1
					end

					if var_445_4.prefab_name ~= "" and arg_442_1.actors_[var_445_4.prefab_name] ~= nil then
						local var_445_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_4.prefab_name].transform, "story_v_side_new_1103404", "1103404110", "story_v_side_new_1103404.awb")

						arg_442_1:RecordAudio("1103404110", var_445_10)
						arg_442_1:RecordAudio("1103404110", var_445_10)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404110", "story_v_side_new_1103404.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404110", "story_v_side_new_1103404.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_11 = math.max(var_445_2, arg_442_1.talkMaxDuration)

			if var_445_1 <= arg_442_1.time_ and arg_442_1.time_ < var_445_1 + var_445_11 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_1) / var_445_11

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_1 + var_445_11 and arg_442_1.time_ < var_445_1 + var_445_11 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play1103404111 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 1103404111
		arg_446_1.duration_ = 3.5

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play1103404112(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0

			if var_449_0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_0 + arg_449_0 then
				arg_446_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action467")
			end

			local var_449_1 = 0

			if var_449_1 < arg_446_1.time_ and arg_446_1.time_ <= var_449_1 + arg_449_0 then
				arg_446_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_449_2 = 0
			local var_449_3 = 0.5

			if var_449_2 < arg_446_1.time_ and arg_446_1.time_ <= var_449_2 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				local var_449_4 = arg_446_1:FormatText(StoryNameCfg[1109].name)

				arg_446_1.leftNameTxt_.text = var_449_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_5 = arg_446_1:GetWordFromCfg(1103404111)
				local var_449_6 = arg_446_1:FormatText(var_449_5.content)

				arg_446_1.text_.text = var_449_6

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_7 = 20
				local var_449_8 = utf8.len(var_449_6)
				local var_449_9 = var_449_7 <= 0 and var_449_3 or var_449_3 * (var_449_8 / var_449_7)

				if var_449_9 > 0 and var_449_3 < var_449_9 then
					arg_446_1.talkMaxDuration = var_449_9

					if var_449_9 + var_449_2 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_9 + var_449_2
					end
				end

				arg_446_1.text_.text = var_449_6
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404111", "story_v_side_new_1103404.awb") ~= 0 then
					local var_449_10 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404111", "story_v_side_new_1103404.awb") / 1000

					if var_449_10 + var_449_2 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_10 + var_449_2
					end

					if var_449_5.prefab_name ~= "" and arg_446_1.actors_[var_449_5.prefab_name] ~= nil then
						local var_449_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_5.prefab_name].transform, "story_v_side_new_1103404", "1103404111", "story_v_side_new_1103404.awb")

						arg_446_1:RecordAudio("1103404111", var_449_11)
						arg_446_1:RecordAudio("1103404111", var_449_11)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404111", "story_v_side_new_1103404.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404111", "story_v_side_new_1103404.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_12 = math.max(var_449_3, arg_446_1.talkMaxDuration)

			if var_449_2 <= arg_446_1.time_ and arg_446_1.time_ < var_449_2 + var_449_12 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_2) / var_449_12

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_2 + var_449_12 and arg_446_1.time_ < var_449_2 + var_449_12 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play1103404112 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 1103404112
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play1103404113(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = arg_450_1.actors_["1034ui_story"]
			local var_453_1 = 0

			if var_453_1 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.characterEffect1034ui_story == nil then
				arg_450_1.var_.characterEffect1034ui_story = var_453_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_2 = 0.200000002980232

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_2 and not isNil(var_453_0) then
				local var_453_3 = (arg_450_1.time_ - var_453_1) / var_453_2

				if arg_450_1.var_.characterEffect1034ui_story and not isNil(var_453_0) then
					local var_453_4 = Mathf.Lerp(0, 0.5, var_453_3)

					arg_450_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_450_1.var_.characterEffect1034ui_story.fillRatio = var_453_4
				end
			end

			if arg_450_1.time_ >= var_453_1 + var_453_2 and arg_450_1.time_ < var_453_1 + var_453_2 + arg_453_0 and not isNil(var_453_0) and arg_450_1.var_.characterEffect1034ui_story then
				local var_453_5 = 0.5

				arg_450_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_450_1.var_.characterEffect1034ui_story.fillRatio = var_453_5
			end

			local var_453_6 = 0
			local var_453_7 = 0.4

			if var_453_6 < arg_450_1.time_ and arg_450_1.time_ <= var_453_6 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				local var_453_8 = arg_450_1:FormatText(StoryNameCfg[7].name)

				arg_450_1.leftNameTxt_.text = var_453_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_9 = arg_450_1:GetWordFromCfg(1103404112)
				local var_453_10 = arg_450_1:FormatText(var_453_9.content)

				arg_450_1.text_.text = var_453_10

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_11 = 16
				local var_453_12 = utf8.len(var_453_10)
				local var_453_13 = var_453_11 <= 0 and var_453_7 or var_453_7 * (var_453_12 / var_453_11)

				if var_453_13 > 0 and var_453_7 < var_453_13 then
					arg_450_1.talkMaxDuration = var_453_13

					if var_453_13 + var_453_6 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_13 + var_453_6
					end
				end

				arg_450_1.text_.text = var_453_10
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_14 = math.max(var_453_7, arg_450_1.talkMaxDuration)

			if var_453_6 <= arg_450_1.time_ and arg_450_1.time_ < var_453_6 + var_453_14 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_6) / var_453_14

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_6 + var_453_14 and arg_450_1.time_ < var_453_6 + var_453_14 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play1103404113 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 1103404113
		arg_454_1.duration_ = 8

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play1103404114(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			local var_457_0 = arg_454_1.actors_["1034ui_story"]
			local var_457_1 = 0

			if var_457_1 < arg_454_1.time_ and arg_454_1.time_ <= var_457_1 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1034ui_story == nil then
				arg_454_1.var_.characterEffect1034ui_story = var_457_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_2 = 0.200000002980232

			if var_457_1 <= arg_454_1.time_ and arg_454_1.time_ < var_457_1 + var_457_2 and not isNil(var_457_0) then
				local var_457_3 = (arg_454_1.time_ - var_457_1) / var_457_2

				if arg_454_1.var_.characterEffect1034ui_story and not isNil(var_457_0) then
					arg_454_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= var_457_1 + var_457_2 and arg_454_1.time_ < var_457_1 + var_457_2 + arg_457_0 and not isNil(var_457_0) and arg_454_1.var_.characterEffect1034ui_story then
				arg_454_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_457_4 = 0

			if var_457_4 < arg_454_1.time_ and arg_454_1.time_ <= var_457_4 + arg_457_0 then
				arg_454_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_457_5 = 0
			local var_457_6 = 1.075

			if var_457_5 < arg_454_1.time_ and arg_454_1.time_ <= var_457_5 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				local var_457_7 = arg_454_1:FormatText(StoryNameCfg[1109].name)

				arg_454_1.leftNameTxt_.text = var_457_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, false)
				arg_454_1.callingController_:SetSelectedState("normal")

				local var_457_8 = arg_454_1:GetWordFromCfg(1103404113)
				local var_457_9 = arg_454_1:FormatText(var_457_8.content)

				arg_454_1.text_.text = var_457_9

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_10 = 43
				local var_457_11 = utf8.len(var_457_9)
				local var_457_12 = var_457_10 <= 0 and var_457_6 or var_457_6 * (var_457_11 / var_457_10)

				if var_457_12 > 0 and var_457_6 < var_457_12 then
					arg_454_1.talkMaxDuration = var_457_12

					if var_457_12 + var_457_5 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_12 + var_457_5
					end
				end

				arg_454_1.text_.text = var_457_9
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404113", "story_v_side_new_1103404.awb") ~= 0 then
					local var_457_13 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404113", "story_v_side_new_1103404.awb") / 1000

					if var_457_13 + var_457_5 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_13 + var_457_5
					end

					if var_457_8.prefab_name ~= "" and arg_454_1.actors_[var_457_8.prefab_name] ~= nil then
						local var_457_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_8.prefab_name].transform, "story_v_side_new_1103404", "1103404113", "story_v_side_new_1103404.awb")

						arg_454_1:RecordAudio("1103404113", var_457_14)
						arg_454_1:RecordAudio("1103404113", var_457_14)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404113", "story_v_side_new_1103404.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404113", "story_v_side_new_1103404.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_15 = math.max(var_457_6, arg_454_1.talkMaxDuration)

			if var_457_5 <= arg_454_1.time_ and arg_454_1.time_ < var_457_5 + var_457_15 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_5) / var_457_15

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_5 + var_457_15 and arg_454_1.time_ < var_457_5 + var_457_15 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play1103404114 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 1103404114
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play1103404115(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			local var_461_0 = arg_458_1.actors_["1034ui_story"]
			local var_461_1 = 0

			if var_461_1 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1034ui_story == nil then
				arg_458_1.var_.characterEffect1034ui_story = var_461_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_2 = 0.200000002980232

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_2 and not isNil(var_461_0) then
				local var_461_3 = (arg_458_1.time_ - var_461_1) / var_461_2

				if arg_458_1.var_.characterEffect1034ui_story and not isNil(var_461_0) then
					local var_461_4 = Mathf.Lerp(0, 0.5, var_461_3)

					arg_458_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1034ui_story.fillRatio = var_461_4
				end
			end

			if arg_458_1.time_ >= var_461_1 + var_461_2 and arg_458_1.time_ < var_461_1 + var_461_2 + arg_461_0 and not isNil(var_461_0) and arg_458_1.var_.characterEffect1034ui_story then
				local var_461_5 = 0.5

				arg_458_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1034ui_story.fillRatio = var_461_5
			end

			local var_461_6 = 0

			if var_461_6 < arg_458_1.time_ and arg_458_1.time_ <= var_461_6 + arg_461_0 then
				arg_458_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action475")
			end

			local var_461_7 = 0

			if var_461_7 < arg_458_1.time_ and arg_458_1.time_ <= var_461_7 + arg_461_0 then
				arg_458_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_461_8 = 2.77555756156289e-17
			local var_461_9 = 1

			if var_461_8 < arg_458_1.time_ and arg_458_1.time_ <= var_461_8 + arg_461_0 then
				local var_461_10 = "play"
				local var_461_11 = "effect"

				arg_458_1:AudioAction(var_461_10, var_461_11, "se_story_side_1199", "se_story_1199_clap", "")
			end

			local var_461_12 = 0
			local var_461_13 = 0.925

			if var_461_12 < arg_458_1.time_ and arg_458_1.time_ <= var_461_12 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_14 = arg_458_1:GetWordFromCfg(1103404114)
				local var_461_15 = arg_458_1:FormatText(var_461_14.content)

				arg_458_1.text_.text = var_461_15

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_16 = 37
				local var_461_17 = utf8.len(var_461_15)
				local var_461_18 = var_461_16 <= 0 and var_461_13 or var_461_13 * (var_461_17 / var_461_16)

				if var_461_18 > 0 and var_461_13 < var_461_18 then
					arg_458_1.talkMaxDuration = var_461_18

					if var_461_18 + var_461_12 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_18 + var_461_12
					end
				end

				arg_458_1.text_.text = var_461_15
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_19 = math.max(var_461_13, arg_458_1.talkMaxDuration)

			if var_461_12 <= arg_458_1.time_ and arg_458_1.time_ < var_461_12 + var_461_19 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_12) / var_461_19

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_12 + var_461_19 and arg_458_1.time_ < var_461_12 + var_461_19 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play1103404115 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 1103404115
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play1103404116(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 0
			local var_465_1 = 0.225

			if var_465_0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, true)

				local var_465_2 = arg_462_1:FormatText(StoryNameCfg[7].name)

				arg_462_1.leftNameTxt_.text = var_465_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_462_1.leftNameTxt_.transform)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1.leftNameTxt_.text)
				SetActive(arg_462_1.iconTrs_.gameObject, true)
				arg_462_1.iconController_:SetSelectedState("hero")

				arg_462_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_462_1.callingController_:SetSelectedState("normal")

				arg_462_1.keyicon_.color = Color.New(1, 1, 1)
				arg_462_1.icon_.color = Color.New(1, 1, 1)

				local var_465_3 = arg_462_1:GetWordFromCfg(1103404115)
				local var_465_4 = arg_462_1:FormatText(var_465_3.content)

				arg_462_1.text_.text = var_465_4

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_5 = 9
				local var_465_6 = utf8.len(var_465_4)
				local var_465_7 = var_465_5 <= 0 and var_465_1 or var_465_1 * (var_465_6 / var_465_5)

				if var_465_7 > 0 and var_465_1 < var_465_7 then
					arg_462_1.talkMaxDuration = var_465_7

					if var_465_7 + var_465_0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_7 + var_465_0
					end
				end

				arg_462_1.text_.text = var_465_4
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_8 = math.max(var_465_1, arg_462_1.talkMaxDuration)

			if var_465_0 <= arg_462_1.time_ and arg_462_1.time_ < var_465_0 + var_465_8 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - var_465_0) / var_465_8

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= var_465_0 + var_465_8 and arg_462_1.time_ < var_465_0 + var_465_8 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play1103404116 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 1103404116
		arg_466_1.duration_ = 5.4

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play1103404117(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			local var_469_0 = arg_466_1.actors_["1034ui_story"]
			local var_469_1 = 0

			if var_469_1 < arg_466_1.time_ and arg_466_1.time_ <= var_469_1 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1034ui_story == nil then
				arg_466_1.var_.characterEffect1034ui_story = var_469_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_2 = 0.200000002980232

			if var_469_1 <= arg_466_1.time_ and arg_466_1.time_ < var_469_1 + var_469_2 and not isNil(var_469_0) then
				local var_469_3 = (arg_466_1.time_ - var_469_1) / var_469_2

				if arg_466_1.var_.characterEffect1034ui_story and not isNil(var_469_0) then
					arg_466_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= var_469_1 + var_469_2 and arg_466_1.time_ < var_469_1 + var_469_2 + arg_469_0 and not isNil(var_469_0) and arg_466_1.var_.characterEffect1034ui_story then
				arg_466_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_469_4 = 0

			if var_469_4 < arg_466_1.time_ and arg_466_1.time_ <= var_469_4 + arg_469_0 then
				arg_466_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action5_2")
			end

			local var_469_5 = 0

			if var_469_5 < arg_466_1.time_ and arg_466_1.time_ <= var_469_5 + arg_469_0 then
				arg_466_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_469_6 = 0
			local var_469_7 = 0.825

			if var_469_6 < arg_466_1.time_ and arg_466_1.time_ <= var_469_6 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				local var_469_8 = arg_466_1:FormatText(StoryNameCfg[1109].name)

				arg_466_1.leftNameTxt_.text = var_469_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, false)
				arg_466_1.callingController_:SetSelectedState("normal")

				local var_469_9 = arg_466_1:GetWordFromCfg(1103404116)
				local var_469_10 = arg_466_1:FormatText(var_469_9.content)

				arg_466_1.text_.text = var_469_10

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_11 = 30
				local var_469_12 = utf8.len(var_469_10)
				local var_469_13 = var_469_11 <= 0 and var_469_7 or var_469_7 * (var_469_12 / var_469_11)

				if var_469_13 > 0 and var_469_7 < var_469_13 then
					arg_466_1.talkMaxDuration = var_469_13

					if var_469_13 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_13 + var_469_6
					end
				end

				arg_466_1.text_.text = var_469_10
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404116", "story_v_side_new_1103404.awb") ~= 0 then
					local var_469_14 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404116", "story_v_side_new_1103404.awb") / 1000

					if var_469_14 + var_469_6 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_14 + var_469_6
					end

					if var_469_9.prefab_name ~= "" and arg_466_1.actors_[var_469_9.prefab_name] ~= nil then
						local var_469_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_9.prefab_name].transform, "story_v_side_new_1103404", "1103404116", "story_v_side_new_1103404.awb")

						arg_466_1:RecordAudio("1103404116", var_469_15)
						arg_466_1:RecordAudio("1103404116", var_469_15)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404116", "story_v_side_new_1103404.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404116", "story_v_side_new_1103404.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_16 = math.max(var_469_7, arg_466_1.talkMaxDuration)

			if var_469_6 <= arg_466_1.time_ and arg_466_1.time_ < var_469_6 + var_469_16 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_6) / var_469_16

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_6 + var_469_16 and arg_466_1.time_ < var_469_6 + var_469_16 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play1103404117 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 1103404117
		arg_470_1.duration_ = 2.8

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play1103404118(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			local var_473_0 = 0

			if var_473_0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_0 + arg_473_0 then
				arg_470_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_1")
			end

			local var_473_1 = 0

			if var_473_1 < arg_470_1.time_ and arg_470_1.time_ <= var_473_1 + arg_473_0 then
				arg_470_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_473_2 = 0
			local var_473_3 = 0.35

			if var_473_2 < arg_470_1.time_ and arg_470_1.time_ <= var_473_2 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				local var_473_4 = arg_470_1:FormatText(StoryNameCfg[1109].name)

				arg_470_1.leftNameTxt_.text = var_473_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_5 = arg_470_1:GetWordFromCfg(1103404117)
				local var_473_6 = arg_470_1:FormatText(var_473_5.content)

				arg_470_1.text_.text = var_473_6

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_7 = 14
				local var_473_8 = utf8.len(var_473_6)
				local var_473_9 = var_473_7 <= 0 and var_473_3 or var_473_3 * (var_473_8 / var_473_7)

				if var_473_9 > 0 and var_473_3 < var_473_9 then
					arg_470_1.talkMaxDuration = var_473_9

					if var_473_9 + var_473_2 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_9 + var_473_2
					end
				end

				arg_470_1.text_.text = var_473_6
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404117", "story_v_side_new_1103404.awb") ~= 0 then
					local var_473_10 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404117", "story_v_side_new_1103404.awb") / 1000

					if var_473_10 + var_473_2 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_10 + var_473_2
					end

					if var_473_5.prefab_name ~= "" and arg_470_1.actors_[var_473_5.prefab_name] ~= nil then
						local var_473_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_5.prefab_name].transform, "story_v_side_new_1103404", "1103404117", "story_v_side_new_1103404.awb")

						arg_470_1:RecordAudio("1103404117", var_473_11)
						arg_470_1:RecordAudio("1103404117", var_473_11)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404117", "story_v_side_new_1103404.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404117", "story_v_side_new_1103404.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_12 = math.max(var_473_3, arg_470_1.talkMaxDuration)

			if var_473_2 <= arg_470_1.time_ and arg_470_1.time_ < var_473_2 + var_473_12 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_2) / var_473_12

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_2 + var_473_12 and arg_470_1.time_ < var_473_2 + var_473_12 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play1103404118 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 1103404118
		arg_474_1.duration_ = 9

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play1103404119(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = "R3401"

			if arg_474_1.bgs_[var_477_0] == nil then
				local var_477_1 = Object.Instantiate(arg_474_1.paintGo_)

				var_477_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_477_0)
				var_477_1.name = var_477_0
				var_477_1.transform.parent = arg_474_1.stage_.transform
				var_477_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_474_1.bgs_[var_477_0] = var_477_1
			end

			local var_477_2 = 1.98333333333333

			if var_477_2 < arg_474_1.time_ and arg_474_1.time_ <= var_477_2 + arg_477_0 then
				local var_477_3 = manager.ui.mainCamera.transform.localPosition
				local var_477_4 = Vector3.New(0, 0, 10) + Vector3.New(var_477_3.x, var_477_3.y, 0)
				local var_477_5 = arg_474_1.bgs_.R3401

				var_477_5.transform.localPosition = var_477_4
				var_477_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_477_6 = var_477_5:GetComponent("SpriteRenderer")

				if var_477_6 and var_477_6.sprite then
					local var_477_7 = (var_477_5.transform.localPosition - var_477_3).z
					local var_477_8 = manager.ui.mainCameraCom_
					local var_477_9 = 2 * var_477_7 * Mathf.Tan(var_477_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_477_10 = var_477_9 * var_477_8.aspect
					local var_477_11 = var_477_6.sprite.bounds.size.x
					local var_477_12 = var_477_6.sprite.bounds.size.y
					local var_477_13 = var_477_10 / var_477_11
					local var_477_14 = var_477_9 / var_477_12
					local var_477_15 = var_477_14 < var_477_13 and var_477_13 or var_477_14

					var_477_5.transform.localScale = Vector3.New(var_477_15, var_477_15, 0)
				end

				for iter_477_0, iter_477_1 in pairs(arg_474_1.bgs_) do
					if iter_477_0 ~= "R3401" then
						iter_477_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_477_16 = 2

			if var_477_16 < arg_474_1.time_ and arg_474_1.time_ <= var_477_16 + arg_477_0 then
				arg_474_1.mask_.enabled = true
				arg_474_1.mask_.raycastTarget = true

				arg_474_1:SetGaussion(false)
			end

			local var_477_17 = 2

			if var_477_16 <= arg_474_1.time_ and arg_474_1.time_ < var_477_16 + var_477_17 then
				local var_477_18 = (arg_474_1.time_ - var_477_16) / var_477_17
				local var_477_19 = Color.New(0, 0, 0)

				var_477_19.a = Mathf.Lerp(1, 0, var_477_18)
				arg_474_1.mask_.color = var_477_19
			end

			if arg_474_1.time_ >= var_477_16 + var_477_17 and arg_474_1.time_ < var_477_16 + var_477_17 + arg_477_0 then
				local var_477_20 = Color.New(0, 0, 0)
				local var_477_21 = 0

				arg_474_1.mask_.enabled = false
				var_477_20.a = var_477_21
				arg_474_1.mask_.color = var_477_20
			end

			local var_477_22 = 0

			if var_477_22 < arg_474_1.time_ and arg_474_1.time_ <= var_477_22 + arg_477_0 then
				arg_474_1.mask_.enabled = true
				arg_474_1.mask_.raycastTarget = true

				arg_474_1:SetGaussion(false)
			end

			local var_477_23 = 2

			if var_477_22 <= arg_474_1.time_ and arg_474_1.time_ < var_477_22 + var_477_23 then
				local var_477_24 = (arg_474_1.time_ - var_477_22) / var_477_23
				local var_477_25 = Color.New(0, 0, 0)

				var_477_25.a = Mathf.Lerp(0, 1, var_477_24)
				arg_474_1.mask_.color = var_477_25
			end

			if arg_474_1.time_ >= var_477_22 + var_477_23 and arg_474_1.time_ < var_477_22 + var_477_23 + arg_477_0 then
				local var_477_26 = Color.New(0, 0, 0)

				var_477_26.a = 1
				arg_474_1.mask_.color = var_477_26
			end

			local var_477_27 = arg_474_1.actors_["1034ui_story"].transform
			local var_477_28 = 1.96599999815226

			if var_477_28 < arg_474_1.time_ and arg_474_1.time_ <= var_477_28 + arg_477_0 then
				arg_474_1.var_.moveOldPos1034ui_story = var_477_27.localPosition
			end

			local var_477_29 = 0.001

			if var_477_28 <= arg_474_1.time_ and arg_474_1.time_ < var_477_28 + var_477_29 then
				local var_477_30 = (arg_474_1.time_ - var_477_28) / var_477_29
				local var_477_31 = Vector3.New(0, 100, 0)

				var_477_27.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPos1034ui_story, var_477_31, var_477_30)

				local var_477_32 = manager.ui.mainCamera.transform.position - var_477_27.position

				var_477_27.forward = Vector3.New(var_477_32.x, var_477_32.y, var_477_32.z)

				local var_477_33 = var_477_27.localEulerAngles

				var_477_33.z = 0
				var_477_33.x = 0
				var_477_27.localEulerAngles = var_477_33
			end

			if arg_474_1.time_ >= var_477_28 + var_477_29 and arg_474_1.time_ < var_477_28 + var_477_29 + arg_477_0 then
				var_477_27.localPosition = Vector3.New(0, 100, 0)

				local var_477_34 = manager.ui.mainCamera.transform.position - var_477_27.position

				var_477_27.forward = Vector3.New(var_477_34.x, var_477_34.y, var_477_34.z)

				local var_477_35 = var_477_27.localEulerAngles

				var_477_35.z = 0
				var_477_35.x = 0
				var_477_27.localEulerAngles = var_477_35
			end

			local var_477_36 = arg_474_1.actors_["1034ui_story"]
			local var_477_37 = 1.96599999815226

			if var_477_37 < arg_474_1.time_ and arg_474_1.time_ <= var_477_37 + arg_477_0 and not isNil(var_477_36) and arg_474_1.var_.characterEffect1034ui_story == nil then
				arg_474_1.var_.characterEffect1034ui_story = var_477_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_477_38 = 0.0340000018477442

			if var_477_37 <= arg_474_1.time_ and arg_474_1.time_ < var_477_37 + var_477_38 and not isNil(var_477_36) then
				local var_477_39 = (arg_474_1.time_ - var_477_37) / var_477_38

				if arg_474_1.var_.characterEffect1034ui_story and not isNil(var_477_36) then
					local var_477_40 = Mathf.Lerp(0, 0.5, var_477_39)

					arg_474_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_474_1.var_.characterEffect1034ui_story.fillRatio = var_477_40
				end
			end

			if arg_474_1.time_ >= var_477_37 + var_477_38 and arg_474_1.time_ < var_477_37 + var_477_38 + arg_477_0 and not isNil(var_477_36) and arg_474_1.var_.characterEffect1034ui_story then
				local var_477_41 = 0.5

				arg_474_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_474_1.var_.characterEffect1034ui_story.fillRatio = var_477_41
			end

			local var_477_42 = arg_474_1.bgs_.R3401.transform
			local var_477_43 = 1.98333333333333

			if var_477_43 < arg_474_1.time_ and arg_474_1.time_ <= var_477_43 + arg_477_0 then
				arg_474_1.var_.moveOldPosR3401 = var_477_42.localPosition
			end

			local var_477_44 = 0.001

			if var_477_43 <= arg_474_1.time_ and arg_474_1.time_ < var_477_43 + var_477_44 then
				local var_477_45 = (arg_474_1.time_ - var_477_43) / var_477_44
				local var_477_46 = Vector3.New(0, 1, 8)

				var_477_42.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPosR3401, var_477_46, var_477_45)
			end

			if arg_474_1.time_ >= var_477_43 + var_477_44 and arg_474_1.time_ < var_477_43 + var_477_44 + arg_477_0 then
				var_477_42.localPosition = Vector3.New(0, 1, 8)
			end

			local var_477_47 = arg_474_1.bgs_.R3401.transform
			local var_477_48 = 2

			if var_477_48 < arg_474_1.time_ and arg_474_1.time_ <= var_477_48 + arg_477_0 then
				arg_474_1.var_.moveOldPosR3401 = var_477_47.localPosition
			end

			local var_477_49 = 2

			if var_477_48 <= arg_474_1.time_ and arg_474_1.time_ < var_477_48 + var_477_49 then
				local var_477_50 = (arg_474_1.time_ - var_477_48) / var_477_49
				local var_477_51 = Vector3.New(0, 1, 10)

				var_477_47.localPosition = Vector3.Lerp(arg_474_1.var_.moveOldPosR3401, var_477_51, var_477_50)
			end

			if arg_474_1.time_ >= var_477_48 + var_477_49 and arg_474_1.time_ < var_477_48 + var_477_49 + arg_477_0 then
				var_477_47.localPosition = Vector3.New(0, 1, 10)
			end

			local var_477_52 = 2

			if var_477_52 < arg_474_1.time_ and arg_474_1.time_ <= var_477_52 + arg_477_0 then
				arg_474_1.allBtn_.enabled = false
			end

			local var_477_53 = 2.23333333333333

			if arg_474_1.time_ >= var_477_52 + var_477_53 and arg_474_1.time_ < var_477_52 + var_477_53 + arg_477_0 then
				arg_474_1.allBtn_.enabled = true
			end

			local var_477_54 = 0.3
			local var_477_55 = 0.3

			if var_477_54 < arg_474_1.time_ and arg_474_1.time_ <= var_477_54 + arg_477_0 then
				local var_477_56 = "play"
				local var_477_57 = "music"

				arg_474_1:AudioAction(var_477_56, var_477_57, "ui_battle", "ui_battle_stopbgm", "")

				local var_477_58 = ""
				local var_477_59 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_477_59 ~= "" then
					if arg_474_1.bgmTxt_.text ~= var_477_59 and arg_474_1.bgmTxt_.text ~= "" then
						if arg_474_1.bgmTxt2_.text ~= "" then
							arg_474_1.bgmTxt_.text = arg_474_1.bgmTxt2_.text
						end

						arg_474_1.bgmTxt2_.text = var_477_59

						arg_474_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_474_1.bgmTxt_.text = var_477_59
						arg_474_1.bgmTxt2_.text = var_477_59
					end

					if arg_474_1.bgmTimer then
						arg_474_1.bgmTimer:Stop()

						arg_474_1.bgmTimer = nil
					end

					if arg_474_1.settingData.show_music_name == 1 then
						arg_474_1.musicController:SetSelectedState("show")
						arg_474_1.musicAnimator_:Play("open", 0, 0)

						if arg_474_1.settingData.music_time ~= 0 then
							arg_474_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_474_1.settingData.music_time), function()
								if arg_474_1 == nil or isNil(arg_474_1.bgmTxt_) then
									return
								end

								arg_474_1.musicController:SetSelectedState("hide")
								arg_474_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_477_60 = 1.5
			local var_477_61 = 1

			if var_477_60 < arg_474_1.time_ and arg_474_1.time_ <= var_477_60 + arg_477_0 then
				local var_477_62 = "play"
				local var_477_63 = "music"

				arg_474_1:AudioAction(var_477_62, var_477_63, "bgm_side_daily10", "bgm_side_daily10", "bgm_side_daily10.awb")

				local var_477_64 = ""
				local var_477_65 = manager.audio:GetAudioName("bgm_side_daily10", "bgm_side_daily10")

				if var_477_65 ~= "" then
					if arg_474_1.bgmTxt_.text ~= var_477_65 and arg_474_1.bgmTxt_.text ~= "" then
						if arg_474_1.bgmTxt2_.text ~= "" then
							arg_474_1.bgmTxt_.text = arg_474_1.bgmTxt2_.text
						end

						arg_474_1.bgmTxt2_.text = var_477_65

						arg_474_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_474_1.bgmTxt_.text = var_477_65
						arg_474_1.bgmTxt2_.text = var_477_65
					end

					if arg_474_1.bgmTimer then
						arg_474_1.bgmTimer:Stop()

						arg_474_1.bgmTimer = nil
					end

					if arg_474_1.settingData.show_music_name == 1 then
						arg_474_1.musicController:SetSelectedState("show")
						arg_474_1.musicAnimator_:Play("open", 0, 0)

						if arg_474_1.settingData.music_time ~= 0 then
							arg_474_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_474_1.settingData.music_time), function()
								if arg_474_1 == nil or isNil(arg_474_1.bgmTxt_) then
									return
								end

								arg_474_1.musicController:SetSelectedState("hide")
								arg_474_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_474_1.frameCnt_ <= 1 then
				arg_474_1.dialog_:SetActive(false)
			end

			local var_477_66 = 4
			local var_477_67 = 1.225

			if var_477_66 < arg_474_1.time_ and arg_474_1.time_ <= var_477_66 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0

				arg_474_1.dialog_:SetActive(true)

				arg_474_1.dialogCg_.alpha = 0

				local var_477_68 = LeanTween.value(arg_474_1.dialog_, 0, 1, 0.3)

				var_477_68:setOnUpdate(LuaHelper.FloatAction(function(arg_480_0)
					arg_474_1.dialogCg_.alpha = arg_480_0
				end))
				var_477_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_474_1.dialog_)
					var_477_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_474_1.duration_ = arg_474_1.duration_ + 0.3

				SetActive(arg_474_1.leftNameGo_, false)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_69 = arg_474_1:GetWordFromCfg(1103404118)
				local var_477_70 = arg_474_1:FormatText(var_477_69.content)

				arg_474_1.text_.text = var_477_70

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_71 = 49
				local var_477_72 = utf8.len(var_477_70)
				local var_477_73 = var_477_71 <= 0 and var_477_67 or var_477_67 * (var_477_72 / var_477_71)

				if var_477_73 > 0 and var_477_67 < var_477_73 then
					arg_474_1.talkMaxDuration = var_477_73
					var_477_66 = var_477_66 + 0.3

					if var_477_73 + var_477_66 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_73 + var_477_66
					end
				end

				arg_474_1.text_.text = var_477_70
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)
				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_74 = var_477_66 + 0.3
			local var_477_75 = math.max(var_477_67, arg_474_1.talkMaxDuration)

			if var_477_74 <= arg_474_1.time_ and arg_474_1.time_ < var_477_74 + var_477_75 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_74) / var_477_75

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_74 + var_477_75 and arg_474_1.time_ < var_477_74 + var_477_75 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "R3401",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "R3401",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_474_1:InitPlayNodeList()
	end,
	Play1103404119 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 1103404119
		arg_482_1.duration_ = 5

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play1103404120(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0
			local var_485_1 = 1.8

			if var_485_0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, false)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_2 = arg_482_1:GetWordFromCfg(1103404119)
				local var_485_3 = arg_482_1:FormatText(var_485_2.content)

				arg_482_1.text_.text = var_485_3

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_4 = 72
				local var_485_5 = utf8.len(var_485_3)
				local var_485_6 = var_485_4 <= 0 and var_485_1 or var_485_1 * (var_485_5 / var_485_4)

				if var_485_6 > 0 and var_485_1 < var_485_6 then
					arg_482_1.talkMaxDuration = var_485_6

					if var_485_6 + var_485_0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_6 + var_485_0
					end
				end

				arg_482_1.text_.text = var_485_3
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)
				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_7 = math.max(var_485_1, arg_482_1.talkMaxDuration)

			if var_485_0 <= arg_482_1.time_ and arg_482_1.time_ < var_485_0 + var_485_7 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_0) / var_485_7

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_0 + var_485_7 and arg_482_1.time_ < var_485_0 + var_485_7 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play1103404120 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 1103404120
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play1103404121(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0
			local var_489_1 = 1.7

			if var_489_0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, false)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_2 = arg_486_1:GetWordFromCfg(1103404120)
				local var_489_3 = arg_486_1:FormatText(var_489_2.content)

				arg_486_1.text_.text = var_489_3

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_4 = 68
				local var_489_5 = utf8.len(var_489_3)
				local var_489_6 = var_489_4 <= 0 and var_489_1 or var_489_1 * (var_489_5 / var_489_4)

				if var_489_6 > 0 and var_489_1 < var_489_6 then
					arg_486_1.talkMaxDuration = var_489_6

					if var_489_6 + var_489_0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_6 + var_489_0
					end
				end

				arg_486_1.text_.text = var_489_3
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_7 = math.max(var_489_1, arg_486_1.talkMaxDuration)

			if var_489_0 <= arg_486_1.time_ and arg_486_1.time_ < var_489_0 + var_489_7 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_0) / var_489_7

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_0 + var_489_7 and arg_486_1.time_ < var_489_0 + var_489_7 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play1103404121 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 1103404121
		arg_490_1.duration_ = 6.93

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play1103404122(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			local var_493_0 = 0
			local var_493_1 = 0.975

			if var_493_0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_0 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				local var_493_2 = arg_490_1:FormatText(StoryNameCfg[1109].name)

				arg_490_1.leftNameTxt_.text = var_493_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_3 = arg_490_1:GetWordFromCfg(1103404121)
				local var_493_4 = arg_490_1:FormatText(var_493_3.content)

				arg_490_1.text_.text = var_493_4

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_5 = 39
				local var_493_6 = utf8.len(var_493_4)
				local var_493_7 = var_493_5 <= 0 and var_493_1 or var_493_1 * (var_493_6 / var_493_5)

				if var_493_7 > 0 and var_493_1 < var_493_7 then
					arg_490_1.talkMaxDuration = var_493_7

					if var_493_7 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_7 + var_493_0
					end
				end

				arg_490_1.text_.text = var_493_4
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404121", "story_v_side_new_1103404.awb") ~= 0 then
					local var_493_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404121", "story_v_side_new_1103404.awb") / 1000

					if var_493_8 + var_493_0 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_8 + var_493_0
					end

					if var_493_3.prefab_name ~= "" and arg_490_1.actors_[var_493_3.prefab_name] ~= nil then
						local var_493_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_3.prefab_name].transform, "story_v_side_new_1103404", "1103404121", "story_v_side_new_1103404.awb")

						arg_490_1:RecordAudio("1103404121", var_493_9)
						arg_490_1:RecordAudio("1103404121", var_493_9)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404121", "story_v_side_new_1103404.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404121", "story_v_side_new_1103404.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_10 = math.max(var_493_1, arg_490_1.talkMaxDuration)

			if var_493_0 <= arg_490_1.time_ and arg_490_1.time_ < var_493_0 + var_493_10 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_0) / var_493_10

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_0 + var_493_10 and arg_490_1.time_ < var_493_0 + var_493_10 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play1103404122 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 1103404122
		arg_494_1.duration_ = 5

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play1103404123(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			local var_497_0 = arg_494_1.actors_["1034ui_story"]
			local var_497_1 = 0

			if var_497_1 < arg_494_1.time_ and arg_494_1.time_ <= var_497_1 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.characterEffect1034ui_story == nil then
				arg_494_1.var_.characterEffect1034ui_story = var_497_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_2 = 0.200000002980232

			if var_497_1 <= arg_494_1.time_ and arg_494_1.time_ < var_497_1 + var_497_2 and not isNil(var_497_0) then
				local var_497_3 = (arg_494_1.time_ - var_497_1) / var_497_2

				if arg_494_1.var_.characterEffect1034ui_story and not isNil(var_497_0) then
					local var_497_4 = Mathf.Lerp(0, 0.5, var_497_3)

					arg_494_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_494_1.var_.characterEffect1034ui_story.fillRatio = var_497_4
				end
			end

			if arg_494_1.time_ >= var_497_1 + var_497_2 and arg_494_1.time_ < var_497_1 + var_497_2 + arg_497_0 and not isNil(var_497_0) and arg_494_1.var_.characterEffect1034ui_story then
				local var_497_5 = 0.5

				arg_494_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_494_1.var_.characterEffect1034ui_story.fillRatio = var_497_5
			end

			local var_497_6 = 0
			local var_497_7 = 0.475

			if var_497_6 < arg_494_1.time_ and arg_494_1.time_ <= var_497_6 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				local var_497_8 = arg_494_1:FormatText(StoryNameCfg[7].name)

				arg_494_1.leftNameTxt_.text = var_497_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, true)
				arg_494_1.iconController_:SetSelectedState("hero")

				arg_494_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_494_1.callingController_:SetSelectedState("normal")

				arg_494_1.keyicon_.color = Color.New(1, 1, 1)
				arg_494_1.icon_.color = Color.New(1, 1, 1)

				local var_497_9 = arg_494_1:GetWordFromCfg(1103404122)
				local var_497_10 = arg_494_1:FormatText(var_497_9.content)

				arg_494_1.text_.text = var_497_10

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_11 = 19
				local var_497_12 = utf8.len(var_497_10)
				local var_497_13 = var_497_11 <= 0 and var_497_7 or var_497_7 * (var_497_12 / var_497_11)

				if var_497_13 > 0 and var_497_7 < var_497_13 then
					arg_494_1.talkMaxDuration = var_497_13

					if var_497_13 + var_497_6 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_13 + var_497_6
					end
				end

				arg_494_1.text_.text = var_497_10
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)
				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_14 = math.max(var_497_7, arg_494_1.talkMaxDuration)

			if var_497_6 <= arg_494_1.time_ and arg_494_1.time_ < var_497_6 + var_497_14 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_6) / var_497_14

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_6 + var_497_14 and arg_494_1.time_ < var_497_6 + var_497_14 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play1103404123 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 1103404123
		arg_498_1.duration_ = 4.2

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play1103404124(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			local var_501_0 = arg_498_1.actors_["1034ui_story"]
			local var_501_1 = 0

			if var_501_1 < arg_498_1.time_ and arg_498_1.time_ <= var_501_1 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect1034ui_story == nil then
				arg_498_1.var_.characterEffect1034ui_story = var_501_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_2 = 0.200000002980232

			if var_501_1 <= arg_498_1.time_ and arg_498_1.time_ < var_501_1 + var_501_2 and not isNil(var_501_0) then
				local var_501_3 = (arg_498_1.time_ - var_501_1) / var_501_2

				if arg_498_1.var_.characterEffect1034ui_story and not isNil(var_501_0) then
					arg_498_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= var_501_1 + var_501_2 and arg_498_1.time_ < var_501_1 + var_501_2 + arg_501_0 and not isNil(var_501_0) and arg_498_1.var_.characterEffect1034ui_story then
				arg_498_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_501_4 = 0
			local var_501_5 = 0.45

			if var_501_4 < arg_498_1.time_ and arg_498_1.time_ <= var_501_4 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				local var_501_6 = arg_498_1:FormatText(StoryNameCfg[1109].name)

				arg_498_1.leftNameTxt_.text = var_501_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_7 = arg_498_1:GetWordFromCfg(1103404123)
				local var_501_8 = arg_498_1:FormatText(var_501_7.content)

				arg_498_1.text_.text = var_501_8

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_9 = 18
				local var_501_10 = utf8.len(var_501_8)
				local var_501_11 = var_501_9 <= 0 and var_501_5 or var_501_5 * (var_501_10 / var_501_9)

				if var_501_11 > 0 and var_501_5 < var_501_11 then
					arg_498_1.talkMaxDuration = var_501_11

					if var_501_11 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_11 + var_501_4
					end
				end

				arg_498_1.text_.text = var_501_8
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404123", "story_v_side_new_1103404.awb") ~= 0 then
					local var_501_12 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404123", "story_v_side_new_1103404.awb") / 1000

					if var_501_12 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_12 + var_501_4
					end

					if var_501_7.prefab_name ~= "" and arg_498_1.actors_[var_501_7.prefab_name] ~= nil then
						local var_501_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_7.prefab_name].transform, "story_v_side_new_1103404", "1103404123", "story_v_side_new_1103404.awb")

						arg_498_1:RecordAudio("1103404123", var_501_13)
						arg_498_1:RecordAudio("1103404123", var_501_13)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404123", "story_v_side_new_1103404.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404123", "story_v_side_new_1103404.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_14 = math.max(var_501_5, arg_498_1.talkMaxDuration)

			if var_501_4 <= arg_498_1.time_ and arg_498_1.time_ < var_501_4 + var_501_14 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_4) / var_501_14

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_4 + var_501_14 and arg_498_1.time_ < var_501_4 + var_501_14 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play1103404124 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 1103404124
		arg_502_1.duration_ = 1.57

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play1103404125(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			local var_505_0 = 0
			local var_505_1 = 0.05

			if var_505_0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_0 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				local var_505_2 = arg_502_1:FormatText(StoryNameCfg[1109].name)

				arg_502_1.leftNameTxt_.text = var_505_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_3 = arg_502_1:GetWordFromCfg(1103404124)
				local var_505_4 = arg_502_1:FormatText(var_505_3.content)

				arg_502_1.text_.text = var_505_4

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_5 = 2
				local var_505_6 = utf8.len(var_505_4)
				local var_505_7 = var_505_5 <= 0 and var_505_1 or var_505_1 * (var_505_6 / var_505_5)

				if var_505_7 > 0 and var_505_1 < var_505_7 then
					arg_502_1.talkMaxDuration = var_505_7

					if var_505_7 + var_505_0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_7 + var_505_0
					end
				end

				arg_502_1.text_.text = var_505_4
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404124", "story_v_side_new_1103404.awb") ~= 0 then
					local var_505_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404124", "story_v_side_new_1103404.awb") / 1000

					if var_505_8 + var_505_0 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_8 + var_505_0
					end

					if var_505_3.prefab_name ~= "" and arg_502_1.actors_[var_505_3.prefab_name] ~= nil then
						local var_505_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_3.prefab_name].transform, "story_v_side_new_1103404", "1103404124", "story_v_side_new_1103404.awb")

						arg_502_1:RecordAudio("1103404124", var_505_9)
						arg_502_1:RecordAudio("1103404124", var_505_9)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404124", "story_v_side_new_1103404.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404124", "story_v_side_new_1103404.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_10 = math.max(var_505_1, arg_502_1.talkMaxDuration)

			if var_505_0 <= arg_502_1.time_ and arg_502_1.time_ < var_505_0 + var_505_10 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_0) / var_505_10

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_0 + var_505_10 and arg_502_1.time_ < var_505_0 + var_505_10 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play1103404125 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 1103404125
		arg_506_1.duration_ = 4.4

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play1103404126(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			local var_509_0 = 0
			local var_509_1 = 0.4

			if var_509_0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_0 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				local var_509_2 = arg_506_1:FormatText(StoryNameCfg[1109].name)

				arg_506_1.leftNameTxt_.text = var_509_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_3 = arg_506_1:GetWordFromCfg(1103404125)
				local var_509_4 = arg_506_1:FormatText(var_509_3.content)

				arg_506_1.text_.text = var_509_4

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_5 = 16
				local var_509_6 = utf8.len(var_509_4)
				local var_509_7 = var_509_5 <= 0 and var_509_1 or var_509_1 * (var_509_6 / var_509_5)

				if var_509_7 > 0 and var_509_1 < var_509_7 then
					arg_506_1.talkMaxDuration = var_509_7

					if var_509_7 + var_509_0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_7 + var_509_0
					end
				end

				arg_506_1.text_.text = var_509_4
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404125", "story_v_side_new_1103404.awb") ~= 0 then
					local var_509_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404125", "story_v_side_new_1103404.awb") / 1000

					if var_509_8 + var_509_0 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_8 + var_509_0
					end

					if var_509_3.prefab_name ~= "" and arg_506_1.actors_[var_509_3.prefab_name] ~= nil then
						local var_509_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_3.prefab_name].transform, "story_v_side_new_1103404", "1103404125", "story_v_side_new_1103404.awb")

						arg_506_1:RecordAudio("1103404125", var_509_9)
						arg_506_1:RecordAudio("1103404125", var_509_9)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404125", "story_v_side_new_1103404.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404125", "story_v_side_new_1103404.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_10 = math.max(var_509_1, arg_506_1.talkMaxDuration)

			if var_509_0 <= arg_506_1.time_ and arg_506_1.time_ < var_509_0 + var_509_10 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_0) / var_509_10

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_0 + var_509_10 and arg_506_1.time_ < var_509_0 + var_509_10 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play1103404126 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 1103404126
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play1103404127(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			local var_513_0 = arg_510_1.actors_["1034ui_story"]
			local var_513_1 = 0

			if var_513_1 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.characterEffect1034ui_story == nil then
				arg_510_1.var_.characterEffect1034ui_story = var_513_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_2 = 0.200000002980232

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_2 and not isNil(var_513_0) then
				local var_513_3 = (arg_510_1.time_ - var_513_1) / var_513_2

				if arg_510_1.var_.characterEffect1034ui_story and not isNil(var_513_0) then
					local var_513_4 = Mathf.Lerp(0, 0.5, var_513_3)

					arg_510_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_510_1.var_.characterEffect1034ui_story.fillRatio = var_513_4
				end
			end

			if arg_510_1.time_ >= var_513_1 + var_513_2 and arg_510_1.time_ < var_513_1 + var_513_2 + arg_513_0 and not isNil(var_513_0) and arg_510_1.var_.characterEffect1034ui_story then
				local var_513_5 = 0.5

				arg_510_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_510_1.var_.characterEffect1034ui_story.fillRatio = var_513_5
			end

			local var_513_6 = 0
			local var_513_7 = 0.95

			if var_513_6 < arg_510_1.time_ and arg_510_1.time_ <= var_513_6 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				local var_513_8 = arg_510_1:FormatText(StoryNameCfg[7].name)

				arg_510_1.leftNameTxt_.text = var_513_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, true)
				arg_510_1.iconController_:SetSelectedState("hero")

				arg_510_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_510_1.callingController_:SetSelectedState("normal")

				arg_510_1.keyicon_.color = Color.New(1, 1, 1)
				arg_510_1.icon_.color = Color.New(1, 1, 1)

				local var_513_9 = arg_510_1:GetWordFromCfg(1103404126)
				local var_513_10 = arg_510_1:FormatText(var_513_9.content)

				arg_510_1.text_.text = var_513_10

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_11 = 38
				local var_513_12 = utf8.len(var_513_10)
				local var_513_13 = var_513_11 <= 0 and var_513_7 or var_513_7 * (var_513_12 / var_513_11)

				if var_513_13 > 0 and var_513_7 < var_513_13 then
					arg_510_1.talkMaxDuration = var_513_13

					if var_513_13 + var_513_6 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_13 + var_513_6
					end
				end

				arg_510_1.text_.text = var_513_10
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_14 = math.max(var_513_7, arg_510_1.talkMaxDuration)

			if var_513_6 <= arg_510_1.time_ and arg_510_1.time_ < var_513_6 + var_513_14 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_6) / var_513_14

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_6 + var_513_14 and arg_510_1.time_ < var_513_6 + var_513_14 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play1103404127 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 1103404127
		arg_514_1.duration_ = 6.17

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play1103404128(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			local var_517_0 = arg_514_1.actors_["1034ui_story"]
			local var_517_1 = 0

			if var_517_1 < arg_514_1.time_ and arg_514_1.time_ <= var_517_1 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.characterEffect1034ui_story == nil then
				arg_514_1.var_.characterEffect1034ui_story = var_517_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_2 = 0.200000002980232

			if var_517_1 <= arg_514_1.time_ and arg_514_1.time_ < var_517_1 + var_517_2 and not isNil(var_517_0) then
				local var_517_3 = (arg_514_1.time_ - var_517_1) / var_517_2

				if arg_514_1.var_.characterEffect1034ui_story and not isNil(var_517_0) then
					arg_514_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= var_517_1 + var_517_2 and arg_514_1.time_ < var_517_1 + var_517_2 + arg_517_0 and not isNil(var_517_0) and arg_514_1.var_.characterEffect1034ui_story then
				arg_514_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_517_4 = 0
			local var_517_5 = 0.8

			if var_517_4 < arg_514_1.time_ and arg_514_1.time_ <= var_517_4 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				local var_517_6 = arg_514_1:FormatText(StoryNameCfg[1109].name)

				arg_514_1.leftNameTxt_.text = var_517_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_7 = arg_514_1:GetWordFromCfg(1103404127)
				local var_517_8 = arg_514_1:FormatText(var_517_7.content)

				arg_514_1.text_.text = var_517_8

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_9 = 32
				local var_517_10 = utf8.len(var_517_8)
				local var_517_11 = var_517_9 <= 0 and var_517_5 or var_517_5 * (var_517_10 / var_517_9)

				if var_517_11 > 0 and var_517_5 < var_517_11 then
					arg_514_1.talkMaxDuration = var_517_11

					if var_517_11 + var_517_4 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_11 + var_517_4
					end
				end

				arg_514_1.text_.text = var_517_8
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404127", "story_v_side_new_1103404.awb") ~= 0 then
					local var_517_12 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404127", "story_v_side_new_1103404.awb") / 1000

					if var_517_12 + var_517_4 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_12 + var_517_4
					end

					if var_517_7.prefab_name ~= "" and arg_514_1.actors_[var_517_7.prefab_name] ~= nil then
						local var_517_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_7.prefab_name].transform, "story_v_side_new_1103404", "1103404127", "story_v_side_new_1103404.awb")

						arg_514_1:RecordAudio("1103404127", var_517_13)
						arg_514_1:RecordAudio("1103404127", var_517_13)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404127", "story_v_side_new_1103404.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404127", "story_v_side_new_1103404.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_14 = math.max(var_517_5, arg_514_1.talkMaxDuration)

			if var_517_4 <= arg_514_1.time_ and arg_514_1.time_ < var_517_4 + var_517_14 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_4) / var_517_14

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_4 + var_517_14 and arg_514_1.time_ < var_517_4 + var_517_14 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play1103404128 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 1103404128
		arg_518_1.duration_ = 5

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play1103404129(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			local var_521_0 = arg_518_1.actors_["1034ui_story"]
			local var_521_1 = 0

			if var_521_1 < arg_518_1.time_ and arg_518_1.time_ <= var_521_1 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.characterEffect1034ui_story == nil then
				arg_518_1.var_.characterEffect1034ui_story = var_521_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_2 = 0.200000002980232

			if var_521_1 <= arg_518_1.time_ and arg_518_1.time_ < var_521_1 + var_521_2 and not isNil(var_521_0) then
				local var_521_3 = (arg_518_1.time_ - var_521_1) / var_521_2

				if arg_518_1.var_.characterEffect1034ui_story and not isNil(var_521_0) then
					local var_521_4 = Mathf.Lerp(0, 0.5, var_521_3)

					arg_518_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1034ui_story.fillRatio = var_521_4
				end
			end

			if arg_518_1.time_ >= var_521_1 + var_521_2 and arg_518_1.time_ < var_521_1 + var_521_2 + arg_521_0 and not isNil(var_521_0) and arg_518_1.var_.characterEffect1034ui_story then
				local var_521_5 = 0.5

				arg_518_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1034ui_story.fillRatio = var_521_5
			end

			local var_521_6 = 0
			local var_521_7 = 0.275

			if var_521_6 < arg_518_1.time_ and arg_518_1.time_ <= var_521_6 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				local var_521_8 = arg_518_1:FormatText(StoryNameCfg[7].name)

				arg_518_1.leftNameTxt_.text = var_521_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, true)
				arg_518_1.iconController_:SetSelectedState("hero")

				arg_518_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_518_1.callingController_:SetSelectedState("normal")

				arg_518_1.keyicon_.color = Color.New(1, 1, 1)
				arg_518_1.icon_.color = Color.New(1, 1, 1)

				local var_521_9 = arg_518_1:GetWordFromCfg(1103404128)
				local var_521_10 = arg_518_1:FormatText(var_521_9.content)

				arg_518_1.text_.text = var_521_10

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_11 = 11
				local var_521_12 = utf8.len(var_521_10)
				local var_521_13 = var_521_11 <= 0 and var_521_7 or var_521_7 * (var_521_12 / var_521_11)

				if var_521_13 > 0 and var_521_7 < var_521_13 then
					arg_518_1.talkMaxDuration = var_521_13

					if var_521_13 + var_521_6 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_13 + var_521_6
					end
				end

				arg_518_1.text_.text = var_521_10
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)
				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_14 = math.max(var_521_7, arg_518_1.talkMaxDuration)

			if var_521_6 <= arg_518_1.time_ and arg_518_1.time_ < var_521_6 + var_521_14 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_6) / var_521_14

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_6 + var_521_14 and arg_518_1.time_ < var_521_6 + var_521_14 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play1103404129 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 1103404129
		arg_522_1.duration_ = 4.4

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play1103404130(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			local var_525_0 = arg_522_1.actors_["1034ui_story"]
			local var_525_1 = 0

			if var_525_1 < arg_522_1.time_ and arg_522_1.time_ <= var_525_1 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.characterEffect1034ui_story == nil then
				arg_522_1.var_.characterEffect1034ui_story = var_525_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_2 = 0.200000002980232

			if var_525_1 <= arg_522_1.time_ and arg_522_1.time_ < var_525_1 + var_525_2 and not isNil(var_525_0) then
				local var_525_3 = (arg_522_1.time_ - var_525_1) / var_525_2

				if arg_522_1.var_.characterEffect1034ui_story and not isNil(var_525_0) then
					arg_522_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= var_525_1 + var_525_2 and arg_522_1.time_ < var_525_1 + var_525_2 + arg_525_0 and not isNil(var_525_0) and arg_522_1.var_.characterEffect1034ui_story then
				arg_522_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_525_4 = 0
			local var_525_5 = 0.575

			if var_525_4 < arg_522_1.time_ and arg_522_1.time_ <= var_525_4 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				local var_525_6 = arg_522_1:FormatText(StoryNameCfg[1109].name)

				arg_522_1.leftNameTxt_.text = var_525_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_7 = arg_522_1:GetWordFromCfg(1103404129)
				local var_525_8 = arg_522_1:FormatText(var_525_7.content)

				arg_522_1.text_.text = var_525_8

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_9 = 23
				local var_525_10 = utf8.len(var_525_8)
				local var_525_11 = var_525_9 <= 0 and var_525_5 or var_525_5 * (var_525_10 / var_525_9)

				if var_525_11 > 0 and var_525_5 < var_525_11 then
					arg_522_1.talkMaxDuration = var_525_11

					if var_525_11 + var_525_4 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_11 + var_525_4
					end
				end

				arg_522_1.text_.text = var_525_8
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404129", "story_v_side_new_1103404.awb") ~= 0 then
					local var_525_12 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404129", "story_v_side_new_1103404.awb") / 1000

					if var_525_12 + var_525_4 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_12 + var_525_4
					end

					if var_525_7.prefab_name ~= "" and arg_522_1.actors_[var_525_7.prefab_name] ~= nil then
						local var_525_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_7.prefab_name].transform, "story_v_side_new_1103404", "1103404129", "story_v_side_new_1103404.awb")

						arg_522_1:RecordAudio("1103404129", var_525_13)
						arg_522_1:RecordAudio("1103404129", var_525_13)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404129", "story_v_side_new_1103404.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404129", "story_v_side_new_1103404.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_14 = math.max(var_525_5, arg_522_1.talkMaxDuration)

			if var_525_4 <= arg_522_1.time_ and arg_522_1.time_ < var_525_4 + var_525_14 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_4) / var_525_14

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_4 + var_525_14 and arg_522_1.time_ < var_525_4 + var_525_14 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play1103404130 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 1103404130
		arg_526_1.duration_ = 5

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play1103404131(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			local var_529_0 = arg_526_1.actors_["1034ui_story"]
			local var_529_1 = 0

			if var_529_1 < arg_526_1.time_ and arg_526_1.time_ <= var_529_1 + arg_529_0 and not isNil(var_529_0) and arg_526_1.var_.characterEffect1034ui_story == nil then
				arg_526_1.var_.characterEffect1034ui_story = var_529_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_529_2 = 0.200000002980232

			if var_529_1 <= arg_526_1.time_ and arg_526_1.time_ < var_529_1 + var_529_2 and not isNil(var_529_0) then
				local var_529_3 = (arg_526_1.time_ - var_529_1) / var_529_2

				if arg_526_1.var_.characterEffect1034ui_story and not isNil(var_529_0) then
					local var_529_4 = Mathf.Lerp(0, 0.5, var_529_3)

					arg_526_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_526_1.var_.characterEffect1034ui_story.fillRatio = var_529_4
				end
			end

			if arg_526_1.time_ >= var_529_1 + var_529_2 and arg_526_1.time_ < var_529_1 + var_529_2 + arg_529_0 and not isNil(var_529_0) and arg_526_1.var_.characterEffect1034ui_story then
				local var_529_5 = 0.5

				arg_526_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_526_1.var_.characterEffect1034ui_story.fillRatio = var_529_5
			end

			local var_529_6 = 0

			if var_529_6 < arg_526_1.time_ and arg_526_1.time_ <= var_529_6 + arg_529_0 then
				arg_526_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			local var_529_7 = 0

			if var_529_7 < arg_526_1.time_ and arg_526_1.time_ <= var_529_7 + arg_529_0 then
				arg_526_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_529_8 = 0
			local var_529_9 = 0.475

			if var_529_8 < arg_526_1.time_ and arg_526_1.time_ <= var_529_8 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				local var_529_10 = arg_526_1:FormatText(StoryNameCfg[7].name)

				arg_526_1.leftNameTxt_.text = var_529_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, true)
				arg_526_1.iconController_:SetSelectedState("hero")

				arg_526_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_526_1.callingController_:SetSelectedState("normal")

				arg_526_1.keyicon_.color = Color.New(1, 1, 1)
				arg_526_1.icon_.color = Color.New(1, 1, 1)

				local var_529_11 = arg_526_1:GetWordFromCfg(1103404130)
				local var_529_12 = arg_526_1:FormatText(var_529_11.content)

				arg_526_1.text_.text = var_529_12

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_13 = 19
				local var_529_14 = utf8.len(var_529_12)
				local var_529_15 = var_529_13 <= 0 and var_529_9 or var_529_9 * (var_529_14 / var_529_13)

				if var_529_15 > 0 and var_529_9 < var_529_15 then
					arg_526_1.talkMaxDuration = var_529_15

					if var_529_15 + var_529_8 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_15 + var_529_8
					end
				end

				arg_526_1.text_.text = var_529_12
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)
				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_16 = math.max(var_529_9, arg_526_1.talkMaxDuration)

			if var_529_8 <= arg_526_1.time_ and arg_526_1.time_ < var_529_8 + var_529_16 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_8) / var_529_16

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_8 + var_529_16 and arg_526_1.time_ < var_529_8 + var_529_16 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play1103404131 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 1103404131
		arg_530_1.duration_ = 5.83

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play1103404132(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			local var_533_0 = arg_530_1.actors_["1034ui_story"]
			local var_533_1 = 0

			if var_533_1 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.characterEffect1034ui_story == nil then
				arg_530_1.var_.characterEffect1034ui_story = var_533_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_2 = 0.200000002980232

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_2 and not isNil(var_533_0) then
				local var_533_3 = (arg_530_1.time_ - var_533_1) / var_533_2

				if arg_530_1.var_.characterEffect1034ui_story and not isNil(var_533_0) then
					arg_530_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_530_1.time_ >= var_533_1 + var_533_2 and arg_530_1.time_ < var_533_1 + var_533_2 + arg_533_0 and not isNil(var_533_0) and arg_530_1.var_.characterEffect1034ui_story then
				arg_530_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_533_4 = 0
			local var_533_5 = 0.7

			if var_533_4 < arg_530_1.time_ and arg_530_1.time_ <= var_533_4 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, true)

				local var_533_6 = arg_530_1:FormatText(StoryNameCfg[1109].name)

				arg_530_1.leftNameTxt_.text = var_533_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_530_1.leftNameTxt_.transform)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1.leftNameTxt_.text)
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_7 = arg_530_1:GetWordFromCfg(1103404131)
				local var_533_8 = arg_530_1:FormatText(var_533_7.content)

				arg_530_1.text_.text = var_533_8

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_9 = 28
				local var_533_10 = utf8.len(var_533_8)
				local var_533_11 = var_533_9 <= 0 and var_533_5 or var_533_5 * (var_533_10 / var_533_9)

				if var_533_11 > 0 and var_533_5 < var_533_11 then
					arg_530_1.talkMaxDuration = var_533_11

					if var_533_11 + var_533_4 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_11 + var_533_4
					end
				end

				arg_530_1.text_.text = var_533_8
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404131", "story_v_side_new_1103404.awb") ~= 0 then
					local var_533_12 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404131", "story_v_side_new_1103404.awb") / 1000

					if var_533_12 + var_533_4 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_12 + var_533_4
					end

					if var_533_7.prefab_name ~= "" and arg_530_1.actors_[var_533_7.prefab_name] ~= nil then
						local var_533_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_530_1.actors_[var_533_7.prefab_name].transform, "story_v_side_new_1103404", "1103404131", "story_v_side_new_1103404.awb")

						arg_530_1:RecordAudio("1103404131", var_533_13)
						arg_530_1:RecordAudio("1103404131", var_533_13)
					else
						arg_530_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404131", "story_v_side_new_1103404.awb")
					end

					arg_530_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404131", "story_v_side_new_1103404.awb")
				end

				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_14 = math.max(var_533_5, arg_530_1.talkMaxDuration)

			if var_533_4 <= arg_530_1.time_ and arg_530_1.time_ < var_533_4 + var_533_14 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_4) / var_533_14

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_4 + var_533_14 and arg_530_1.time_ < var_533_4 + var_533_14 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play1103404132 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 1103404132
		arg_534_1.duration_ = 6.4

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play1103404133(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = 0
			local var_537_1 = 0.675

			if var_537_0 < arg_534_1.time_ and arg_534_1.time_ <= var_537_0 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, true)

				local var_537_2 = arg_534_1:FormatText(StoryNameCfg[1109].name)

				arg_534_1.leftNameTxt_.text = var_537_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_534_1.leftNameTxt_.transform)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1.leftNameTxt_.text)
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_3 = arg_534_1:GetWordFromCfg(1103404132)
				local var_537_4 = arg_534_1:FormatText(var_537_3.content)

				arg_534_1.text_.text = var_537_4

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_5 = 27
				local var_537_6 = utf8.len(var_537_4)
				local var_537_7 = var_537_5 <= 0 and var_537_1 or var_537_1 * (var_537_6 / var_537_5)

				if var_537_7 > 0 and var_537_1 < var_537_7 then
					arg_534_1.talkMaxDuration = var_537_7

					if var_537_7 + var_537_0 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_7 + var_537_0
					end
				end

				arg_534_1.text_.text = var_537_4
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404132", "story_v_side_new_1103404.awb") ~= 0 then
					local var_537_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404132", "story_v_side_new_1103404.awb") / 1000

					if var_537_8 + var_537_0 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_8 + var_537_0
					end

					if var_537_3.prefab_name ~= "" and arg_534_1.actors_[var_537_3.prefab_name] ~= nil then
						local var_537_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_534_1.actors_[var_537_3.prefab_name].transform, "story_v_side_new_1103404", "1103404132", "story_v_side_new_1103404.awb")

						arg_534_1:RecordAudio("1103404132", var_537_9)
						arg_534_1:RecordAudio("1103404132", var_537_9)
					else
						arg_534_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404132", "story_v_side_new_1103404.awb")
					end

					arg_534_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404132", "story_v_side_new_1103404.awb")
				end

				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_10 = math.max(var_537_1, arg_534_1.talkMaxDuration)

			if var_537_0 <= arg_534_1.time_ and arg_534_1.time_ < var_537_0 + var_537_10 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - var_537_0) / var_537_10

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= var_537_0 + var_537_10 and arg_534_1.time_ < var_537_0 + var_537_10 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play1103404133 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 1103404133
		arg_538_1.duration_ = 5

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play1103404134(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			local var_541_0 = arg_538_1.actors_["1034ui_story"]
			local var_541_1 = 0

			if var_541_1 < arg_538_1.time_ and arg_538_1.time_ <= var_541_1 + arg_541_0 and not isNil(var_541_0) and arg_538_1.var_.characterEffect1034ui_story == nil then
				arg_538_1.var_.characterEffect1034ui_story = var_541_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_2 = 0.200000002980232

			if var_541_1 <= arg_538_1.time_ and arg_538_1.time_ < var_541_1 + var_541_2 and not isNil(var_541_0) then
				local var_541_3 = (arg_538_1.time_ - var_541_1) / var_541_2

				if arg_538_1.var_.characterEffect1034ui_story and not isNil(var_541_0) then
					local var_541_4 = Mathf.Lerp(0, 0.5, var_541_3)

					arg_538_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_538_1.var_.characterEffect1034ui_story.fillRatio = var_541_4
				end
			end

			if arg_538_1.time_ >= var_541_1 + var_541_2 and arg_538_1.time_ < var_541_1 + var_541_2 + arg_541_0 and not isNil(var_541_0) and arg_538_1.var_.characterEffect1034ui_story then
				local var_541_5 = 0.5

				arg_538_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_538_1.var_.characterEffect1034ui_story.fillRatio = var_541_5
			end

			local var_541_6 = 0

			if var_541_6 < arg_538_1.time_ and arg_538_1.time_ <= var_541_6 + arg_541_0 then
				arg_538_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			local var_541_7 = 0
			local var_541_8 = 0.7

			if var_541_7 < arg_538_1.time_ and arg_538_1.time_ <= var_541_7 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				local var_541_9 = arg_538_1:FormatText(StoryNameCfg[7].name)

				arg_538_1.leftNameTxt_.text = var_541_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, true)
				arg_538_1.iconController_:SetSelectedState("hero")

				arg_538_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_538_1.callingController_:SetSelectedState("normal")

				arg_538_1.keyicon_.color = Color.New(1, 1, 1)
				arg_538_1.icon_.color = Color.New(1, 1, 1)

				local var_541_10 = arg_538_1:GetWordFromCfg(1103404133)
				local var_541_11 = arg_538_1:FormatText(var_541_10.content)

				arg_538_1.text_.text = var_541_11

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_12 = 28
				local var_541_13 = utf8.len(var_541_11)
				local var_541_14 = var_541_12 <= 0 and var_541_8 or var_541_8 * (var_541_13 / var_541_12)

				if var_541_14 > 0 and var_541_8 < var_541_14 then
					arg_538_1.talkMaxDuration = var_541_14

					if var_541_14 + var_541_7 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_14 + var_541_7
					end
				end

				arg_538_1.text_.text = var_541_11
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)
				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_15 = math.max(var_541_8, arg_538_1.talkMaxDuration)

			if var_541_7 <= arg_538_1.time_ and arg_538_1.time_ < var_541_7 + var_541_15 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_7) / var_541_15

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_7 + var_541_15 and arg_538_1.time_ < var_541_7 + var_541_15 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play1103404134 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 1103404134
		arg_542_1.duration_ = 2.67

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play1103404135(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = arg_542_1.actors_["1034ui_story"]
			local var_545_1 = 0

			if var_545_1 < arg_542_1.time_ and arg_542_1.time_ <= var_545_1 + arg_545_0 and not isNil(var_545_0) and arg_542_1.var_.characterEffect1034ui_story == nil then
				arg_542_1.var_.characterEffect1034ui_story = var_545_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_545_2 = 0.200000002980232

			if var_545_1 <= arg_542_1.time_ and arg_542_1.time_ < var_545_1 + var_545_2 and not isNil(var_545_0) then
				local var_545_3 = (arg_542_1.time_ - var_545_1) / var_545_2

				if arg_542_1.var_.characterEffect1034ui_story and not isNil(var_545_0) then
					arg_542_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_542_1.time_ >= var_545_1 + var_545_2 and arg_542_1.time_ < var_545_1 + var_545_2 + arg_545_0 and not isNil(var_545_0) and arg_542_1.var_.characterEffect1034ui_story then
				arg_542_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_545_4 = 0
			local var_545_5 = 0.2

			if var_545_4 < arg_542_1.time_ and arg_542_1.time_ <= var_545_4 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				local var_545_6 = arg_542_1:FormatText(StoryNameCfg[1109].name)

				arg_542_1.leftNameTxt_.text = var_545_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_7 = arg_542_1:GetWordFromCfg(1103404134)
				local var_545_8 = arg_542_1:FormatText(var_545_7.content)

				arg_542_1.text_.text = var_545_8

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_9 = 8
				local var_545_10 = utf8.len(var_545_8)
				local var_545_11 = var_545_9 <= 0 and var_545_5 or var_545_5 * (var_545_10 / var_545_9)

				if var_545_11 > 0 and var_545_5 < var_545_11 then
					arg_542_1.talkMaxDuration = var_545_11

					if var_545_11 + var_545_4 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_11 + var_545_4
					end
				end

				arg_542_1.text_.text = var_545_8
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404134", "story_v_side_new_1103404.awb") ~= 0 then
					local var_545_12 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404134", "story_v_side_new_1103404.awb") / 1000

					if var_545_12 + var_545_4 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_12 + var_545_4
					end

					if var_545_7.prefab_name ~= "" and arg_542_1.actors_[var_545_7.prefab_name] ~= nil then
						local var_545_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_542_1.actors_[var_545_7.prefab_name].transform, "story_v_side_new_1103404", "1103404134", "story_v_side_new_1103404.awb")

						arg_542_1:RecordAudio("1103404134", var_545_13)
						arg_542_1:RecordAudio("1103404134", var_545_13)
					else
						arg_542_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404134", "story_v_side_new_1103404.awb")
					end

					arg_542_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404134", "story_v_side_new_1103404.awb")
				end

				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_14 = math.max(var_545_5, arg_542_1.talkMaxDuration)

			if var_545_4 <= arg_542_1.time_ and arg_542_1.time_ < var_545_4 + var_545_14 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - var_545_4) / var_545_14

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= var_545_4 + var_545_14 and arg_542_1.time_ < var_545_4 + var_545_14 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play1103404135 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 1103404135
		arg_546_1.duration_ = 10.53

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play1103404136(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			local var_549_0 = 0
			local var_549_1 = 1.1

			if var_549_0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_0 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				local var_549_2 = arg_546_1:FormatText(StoryNameCfg[1109].name)

				arg_546_1.leftNameTxt_.text = var_549_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_3 = arg_546_1:GetWordFromCfg(1103404135)
				local var_549_4 = arg_546_1:FormatText(var_549_3.content)

				arg_546_1.text_.text = var_549_4

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_5 = 44
				local var_549_6 = utf8.len(var_549_4)
				local var_549_7 = var_549_5 <= 0 and var_549_1 or var_549_1 * (var_549_6 / var_549_5)

				if var_549_7 > 0 and var_549_1 < var_549_7 then
					arg_546_1.talkMaxDuration = var_549_7

					if var_549_7 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_7 + var_549_0
					end
				end

				arg_546_1.text_.text = var_549_4
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404135", "story_v_side_new_1103404.awb") ~= 0 then
					local var_549_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404135", "story_v_side_new_1103404.awb") / 1000

					if var_549_8 + var_549_0 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_8 + var_549_0
					end

					if var_549_3.prefab_name ~= "" and arg_546_1.actors_[var_549_3.prefab_name] ~= nil then
						local var_549_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_3.prefab_name].transform, "story_v_side_new_1103404", "1103404135", "story_v_side_new_1103404.awb")

						arg_546_1:RecordAudio("1103404135", var_549_9)
						arg_546_1:RecordAudio("1103404135", var_549_9)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404135", "story_v_side_new_1103404.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404135", "story_v_side_new_1103404.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_10 = math.max(var_549_1, arg_546_1.talkMaxDuration)

			if var_549_0 <= arg_546_1.time_ and arg_546_1.time_ < var_549_0 + var_549_10 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_0) / var_549_10

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_0 + var_549_10 and arg_546_1.time_ < var_549_0 + var_549_10 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play1103404136 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 1103404136
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play1103404137(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			local var_553_0 = arg_550_1.actors_["1034ui_story"]
			local var_553_1 = 0

			if var_553_1 < arg_550_1.time_ and arg_550_1.time_ <= var_553_1 + arg_553_0 and not isNil(var_553_0) and arg_550_1.var_.characterEffect1034ui_story == nil then
				arg_550_1.var_.characterEffect1034ui_story = var_553_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_553_2 = 0.200000002980232

			if var_553_1 <= arg_550_1.time_ and arg_550_1.time_ < var_553_1 + var_553_2 and not isNil(var_553_0) then
				local var_553_3 = (arg_550_1.time_ - var_553_1) / var_553_2

				if arg_550_1.var_.characterEffect1034ui_story and not isNil(var_553_0) then
					local var_553_4 = Mathf.Lerp(0, 0.5, var_553_3)

					arg_550_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_550_1.var_.characterEffect1034ui_story.fillRatio = var_553_4
				end
			end

			if arg_550_1.time_ >= var_553_1 + var_553_2 and arg_550_1.time_ < var_553_1 + var_553_2 + arg_553_0 and not isNil(var_553_0) and arg_550_1.var_.characterEffect1034ui_story then
				local var_553_5 = 0.5

				arg_550_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_550_1.var_.characterEffect1034ui_story.fillRatio = var_553_5
			end

			local var_553_6 = 0

			if var_553_6 < arg_550_1.time_ and arg_550_1.time_ <= var_553_6 + arg_553_0 then
				arg_550_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_553_7 = 0
			local var_553_8 = 0.375

			if var_553_7 < arg_550_1.time_ and arg_550_1.time_ <= var_553_7 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, true)

				local var_553_9 = arg_550_1:FormatText(StoryNameCfg[7].name)

				arg_550_1.leftNameTxt_.text = var_553_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_550_1.leftNameTxt_.transform)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1.leftNameTxt_.text)
				SetActive(arg_550_1.iconTrs_.gameObject, true)
				arg_550_1.iconController_:SetSelectedState("hero")

				arg_550_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_550_1.callingController_:SetSelectedState("normal")

				arg_550_1.keyicon_.color = Color.New(1, 1, 1)
				arg_550_1.icon_.color = Color.New(1, 1, 1)

				local var_553_10 = arg_550_1:GetWordFromCfg(1103404136)
				local var_553_11 = arg_550_1:FormatText(var_553_10.content)

				arg_550_1.text_.text = var_553_11

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_12 = 15
				local var_553_13 = utf8.len(var_553_11)
				local var_553_14 = var_553_12 <= 0 and var_553_8 or var_553_8 * (var_553_13 / var_553_12)

				if var_553_14 > 0 and var_553_8 < var_553_14 then
					arg_550_1.talkMaxDuration = var_553_14

					if var_553_14 + var_553_7 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_14 + var_553_7
					end
				end

				arg_550_1.text_.text = var_553_11
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_15 = math.max(var_553_8, arg_550_1.talkMaxDuration)

			if var_553_7 <= arg_550_1.time_ and arg_550_1.time_ < var_553_7 + var_553_15 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_7) / var_553_15

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_7 + var_553_15 and arg_550_1.time_ < var_553_7 + var_553_15 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play1103404137 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 1103404137
		arg_554_1.duration_ = 2.7

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play1103404138(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			local var_557_0 = 0
			local var_557_1 = 0.25

			if var_557_0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_0 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				local var_557_2 = arg_554_1:FormatText(StoryNameCfg[1109].name)

				arg_554_1.leftNameTxt_.text = var_557_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_3 = arg_554_1:GetWordFromCfg(1103404137)
				local var_557_4 = arg_554_1:FormatText(var_557_3.content)

				arg_554_1.text_.text = var_557_4

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_5 = 10
				local var_557_6 = utf8.len(var_557_4)
				local var_557_7 = var_557_5 <= 0 and var_557_1 or var_557_1 * (var_557_6 / var_557_5)

				if var_557_7 > 0 and var_557_1 < var_557_7 then
					arg_554_1.talkMaxDuration = var_557_7

					if var_557_7 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_7 + var_557_0
					end
				end

				arg_554_1.text_.text = var_557_4
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404137", "story_v_side_new_1103404.awb") ~= 0 then
					local var_557_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404137", "story_v_side_new_1103404.awb") / 1000

					if var_557_8 + var_557_0 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_8 + var_557_0
					end

					if var_557_3.prefab_name ~= "" and arg_554_1.actors_[var_557_3.prefab_name] ~= nil then
						local var_557_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_3.prefab_name].transform, "story_v_side_new_1103404", "1103404137", "story_v_side_new_1103404.awb")

						arg_554_1:RecordAudio("1103404137", var_557_9)
						arg_554_1:RecordAudio("1103404137", var_557_9)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404137", "story_v_side_new_1103404.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404137", "story_v_side_new_1103404.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_10 = math.max(var_557_1, arg_554_1.talkMaxDuration)

			if var_557_0 <= arg_554_1.time_ and arg_554_1.time_ < var_557_0 + var_557_10 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_0) / var_557_10

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_0 + var_557_10 and arg_554_1.time_ < var_557_0 + var_557_10 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play1103404138 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 1103404138
		arg_558_1.duration_ = 5

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
		end

		function arg_558_1.playNext_(arg_560_0)
			if arg_560_0 == 1 then
				arg_558_0:Play1103404139(arg_558_1)
			end
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = arg_558_1.actors_["1034ui_story"]
			local var_561_1 = 0

			if var_561_1 < arg_558_1.time_ and arg_558_1.time_ <= var_561_1 + arg_561_0 and not isNil(var_561_0) and arg_558_1.var_.characterEffect1034ui_story == nil then
				arg_558_1.var_.characterEffect1034ui_story = var_561_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_561_2 = 0.200000002980232

			if var_561_1 <= arg_558_1.time_ and arg_558_1.time_ < var_561_1 + var_561_2 and not isNil(var_561_0) then
				local var_561_3 = (arg_558_1.time_ - var_561_1) / var_561_2

				if arg_558_1.var_.characterEffect1034ui_story and not isNil(var_561_0) then
					local var_561_4 = Mathf.Lerp(0, 0.5, var_561_3)

					arg_558_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_558_1.var_.characterEffect1034ui_story.fillRatio = var_561_4
				end
			end

			if arg_558_1.time_ >= var_561_1 + var_561_2 and arg_558_1.time_ < var_561_1 + var_561_2 + arg_561_0 and not isNil(var_561_0) and arg_558_1.var_.characterEffect1034ui_story then
				local var_561_5 = 0.5

				arg_558_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_558_1.var_.characterEffect1034ui_story.fillRatio = var_561_5
			end

			local var_561_6 = 0

			if var_561_6 < arg_558_1.time_ and arg_558_1.time_ <= var_561_6 + arg_561_0 then
				arg_558_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action7_2")
			end

			local var_561_7 = 0

			if var_561_7 < arg_558_1.time_ and arg_558_1.time_ <= var_561_7 + arg_561_0 then
				arg_558_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_561_8 = 0
			local var_561_9 = 0.85

			if var_561_8 < arg_558_1.time_ and arg_558_1.time_ <= var_561_8 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				local var_561_10 = arg_558_1:FormatText(StoryNameCfg[7].name)

				arg_558_1.leftNameTxt_.text = var_561_10

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, true)
				arg_558_1.iconController_:SetSelectedState("hero")

				arg_558_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_558_1.callingController_:SetSelectedState("normal")

				arg_558_1.keyicon_.color = Color.New(1, 1, 1)
				arg_558_1.icon_.color = Color.New(1, 1, 1)

				local var_561_11 = arg_558_1:GetWordFromCfg(1103404138)
				local var_561_12 = arg_558_1:FormatText(var_561_11.content)

				arg_558_1.text_.text = var_561_12

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_13 = 34
				local var_561_14 = utf8.len(var_561_12)
				local var_561_15 = var_561_13 <= 0 and var_561_9 or var_561_9 * (var_561_14 / var_561_13)

				if var_561_15 > 0 and var_561_9 < var_561_15 then
					arg_558_1.talkMaxDuration = var_561_15

					if var_561_15 + var_561_8 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_15 + var_561_8
					end
				end

				arg_558_1.text_.text = var_561_12
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)
				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_16 = math.max(var_561_9, arg_558_1.talkMaxDuration)

			if var_561_8 <= arg_558_1.time_ and arg_558_1.time_ < var_561_8 + var_561_16 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - var_561_8) / var_561_16

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= var_561_8 + var_561_16 and arg_558_1.time_ < var_561_8 + var_561_16 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	Play1103404139 = function(arg_562_0, arg_562_1)
		arg_562_1.time_ = 0
		arg_562_1.frameCnt_ = 0
		arg_562_1.state_ = "playing"
		arg_562_1.curTalkId_ = 1103404139
		arg_562_1.duration_ = 5

		SetActive(arg_562_1.tipsGo_, false)

		function arg_562_1.onSingleLineFinish_()
			arg_562_1.onSingleLineUpdate_ = nil
			arg_562_1.onSingleLineFinish_ = nil
			arg_562_1.state_ = "waiting"
		end

		function arg_562_1.playNext_(arg_564_0)
			if arg_564_0 == 1 then
				arg_562_0:Play1103404140(arg_562_1)
			end
		end

		function arg_562_1.onSingleLineUpdate_(arg_565_0)
			local var_565_0 = 0

			if var_565_0 < arg_562_1.time_ and arg_562_1.time_ <= var_565_0 + arg_565_0 then
				arg_562_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_565_1 = 0

			if var_565_1 < arg_562_1.time_ and arg_562_1.time_ <= var_565_1 + arg_565_0 then
				arg_562_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_565_2 = 0
			local var_565_3 = 0.425

			if var_565_2 < arg_562_1.time_ and arg_562_1.time_ <= var_565_2 + arg_565_0 then
				arg_562_1.talkMaxDuration = 0
				arg_562_1.dialogCg_.alpha = 1

				arg_562_1.dialog_:SetActive(true)
				SetActive(arg_562_1.leftNameGo_, true)

				local var_565_4 = arg_562_1:FormatText(StoryNameCfg[7].name)

				arg_562_1.leftNameTxt_.text = var_565_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_562_1.leftNameTxt_.transform)

				arg_562_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_562_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_562_1:RecordName(arg_562_1.leftNameTxt_.text)
				SetActive(arg_562_1.iconTrs_.gameObject, true)
				arg_562_1.iconController_:SetSelectedState("hero")

				arg_562_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_562_1.callingController_:SetSelectedState("normal")

				arg_562_1.keyicon_.color = Color.New(1, 1, 1)
				arg_562_1.icon_.color = Color.New(1, 1, 1)

				local var_565_5 = arg_562_1:GetWordFromCfg(1103404139)
				local var_565_6 = arg_562_1:FormatText(var_565_5.content)

				arg_562_1.text_.text = var_565_6

				LuaForUtil.ClearLinePrefixSymbol(arg_562_1.text_)

				local var_565_7 = 17
				local var_565_8 = utf8.len(var_565_6)
				local var_565_9 = var_565_7 <= 0 and var_565_3 or var_565_3 * (var_565_8 / var_565_7)

				if var_565_9 > 0 and var_565_3 < var_565_9 then
					arg_562_1.talkMaxDuration = var_565_9

					if var_565_9 + var_565_2 > arg_562_1.duration_ then
						arg_562_1.duration_ = var_565_9 + var_565_2
					end
				end

				arg_562_1.text_.text = var_565_6
				arg_562_1.typewritter.percent = 0

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(false)
				arg_562_1:RecordContent(arg_562_1.text_.text)
			end

			local var_565_10 = math.max(var_565_3, arg_562_1.talkMaxDuration)

			if var_565_2 <= arg_562_1.time_ and arg_562_1.time_ < var_565_2 + var_565_10 then
				arg_562_1.typewritter.percent = (arg_562_1.time_ - var_565_2) / var_565_10

				arg_562_1.typewritter:SetDirty()
			end

			if arg_562_1.time_ >= var_565_2 + var_565_10 and arg_562_1.time_ < var_565_2 + var_565_10 + arg_565_0 then
				arg_562_1.typewritter.percent = 1

				arg_562_1.typewritter:SetDirty()
				arg_562_1:ShowNextGo(true)
			end
		end

		arg_562_1.nodeConfigList_ = {}

		arg_562_1:InitPlayNodeList()
	end,
	Play1103404140 = function(arg_566_0, arg_566_1)
		arg_566_1.time_ = 0
		arg_566_1.frameCnt_ = 0
		arg_566_1.state_ = "playing"
		arg_566_1.curTalkId_ = 1103404140
		arg_566_1.duration_ = 2.17

		SetActive(arg_566_1.tipsGo_, false)

		function arg_566_1.onSingleLineFinish_()
			arg_566_1.onSingleLineUpdate_ = nil
			arg_566_1.onSingleLineFinish_ = nil
			arg_566_1.state_ = "waiting"
		end

		function arg_566_1.playNext_(arg_568_0)
			if arg_568_0 == 1 then
				arg_566_0:Play1103404141(arg_566_1)
			end
		end

		function arg_566_1.onSingleLineUpdate_(arg_569_0)
			local var_569_0 = 0
			local var_569_1 = 0.225

			if var_569_0 < arg_566_1.time_ and arg_566_1.time_ <= var_569_0 + arg_569_0 then
				arg_566_1.talkMaxDuration = 0
				arg_566_1.dialogCg_.alpha = 1

				arg_566_1.dialog_:SetActive(true)
				SetActive(arg_566_1.leftNameGo_, true)

				local var_569_2 = arg_566_1:FormatText(StoryNameCfg[1109].name)

				arg_566_1.leftNameTxt_.text = var_569_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_566_1.leftNameTxt_.transform)

				arg_566_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_566_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_566_1:RecordName(arg_566_1.leftNameTxt_.text)
				SetActive(arg_566_1.iconTrs_.gameObject, false)
				arg_566_1.callingController_:SetSelectedState("normal")

				local var_569_3 = arg_566_1:GetWordFromCfg(1103404140)
				local var_569_4 = arg_566_1:FormatText(var_569_3.content)

				arg_566_1.text_.text = var_569_4

				LuaForUtil.ClearLinePrefixSymbol(arg_566_1.text_)

				local var_569_5 = 9
				local var_569_6 = utf8.len(var_569_4)
				local var_569_7 = var_569_5 <= 0 and var_569_1 or var_569_1 * (var_569_6 / var_569_5)

				if var_569_7 > 0 and var_569_1 < var_569_7 then
					arg_566_1.talkMaxDuration = var_569_7

					if var_569_7 + var_569_0 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_7 + var_569_0
					end
				end

				arg_566_1.text_.text = var_569_4
				arg_566_1.typewritter.percent = 0

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404140", "story_v_side_new_1103404.awb") ~= 0 then
					local var_569_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404140", "story_v_side_new_1103404.awb") / 1000

					if var_569_8 + var_569_0 > arg_566_1.duration_ then
						arg_566_1.duration_ = var_569_8 + var_569_0
					end

					if var_569_3.prefab_name ~= "" and arg_566_1.actors_[var_569_3.prefab_name] ~= nil then
						local var_569_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_566_1.actors_[var_569_3.prefab_name].transform, "story_v_side_new_1103404", "1103404140", "story_v_side_new_1103404.awb")

						arg_566_1:RecordAudio("1103404140", var_569_9)
						arg_566_1:RecordAudio("1103404140", var_569_9)
					else
						arg_566_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404140", "story_v_side_new_1103404.awb")
					end

					arg_566_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404140", "story_v_side_new_1103404.awb")
				end

				arg_566_1:RecordContent(arg_566_1.text_.text)
			end

			local var_569_10 = math.max(var_569_1, arg_566_1.talkMaxDuration)

			if var_569_0 <= arg_566_1.time_ and arg_566_1.time_ < var_569_0 + var_569_10 then
				arg_566_1.typewritter.percent = (arg_566_1.time_ - var_569_0) / var_569_10

				arg_566_1.typewritter:SetDirty()
			end

			if arg_566_1.time_ >= var_569_0 + var_569_10 and arg_566_1.time_ < var_569_0 + var_569_10 + arg_569_0 then
				arg_566_1.typewritter.percent = 1

				arg_566_1.typewritter:SetDirty()
				arg_566_1:ShowNextGo(true)
			end
		end

		arg_566_1.nodeConfigList_ = {}

		arg_566_1:InitPlayNodeList()
	end,
	Play1103404141 = function(arg_570_0, arg_570_1)
		arg_570_1.time_ = 0
		arg_570_1.frameCnt_ = 0
		arg_570_1.state_ = "playing"
		arg_570_1.curTalkId_ = 1103404141
		arg_570_1.duration_ = 5

		SetActive(arg_570_1.tipsGo_, false)

		function arg_570_1.onSingleLineFinish_()
			arg_570_1.onSingleLineUpdate_ = nil
			arg_570_1.onSingleLineFinish_ = nil
			arg_570_1.state_ = "waiting"
		end

		function arg_570_1.playNext_(arg_572_0)
			if arg_572_0 == 1 then
				arg_570_0:Play1103404142(arg_570_1)
			end
		end

		function arg_570_1.onSingleLineUpdate_(arg_573_0)
			local var_573_0 = arg_570_1.actors_["1034ui_story"]
			local var_573_1 = 0

			if var_573_1 < arg_570_1.time_ and arg_570_1.time_ <= var_573_1 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.characterEffect1034ui_story == nil then
				arg_570_1.var_.characterEffect1034ui_story = var_573_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_573_2 = 0.200000002980232

			if var_573_1 <= arg_570_1.time_ and arg_570_1.time_ < var_573_1 + var_573_2 and not isNil(var_573_0) then
				local var_573_3 = (arg_570_1.time_ - var_573_1) / var_573_2

				if arg_570_1.var_.characterEffect1034ui_story and not isNil(var_573_0) then
					local var_573_4 = Mathf.Lerp(0, 0.5, var_573_3)

					arg_570_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_570_1.var_.characterEffect1034ui_story.fillRatio = var_573_4
				end
			end

			if arg_570_1.time_ >= var_573_1 + var_573_2 and arg_570_1.time_ < var_573_1 + var_573_2 + arg_573_0 and not isNil(var_573_0) and arg_570_1.var_.characterEffect1034ui_story then
				local var_573_5 = 0.5

				arg_570_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_570_1.var_.characterEffect1034ui_story.fillRatio = var_573_5
			end

			local var_573_6 = arg_570_1.bgs_.R3401.transform
			local var_573_7 = 0

			if var_573_7 < arg_570_1.time_ and arg_570_1.time_ <= var_573_7 + arg_573_0 then
				arg_570_1.var_.moveOldPosR3401 = var_573_6.localPosition
			end

			local var_573_8 = 2

			if var_573_7 <= arg_570_1.time_ and arg_570_1.time_ < var_573_7 + var_573_8 then
				local var_573_9 = (arg_570_1.time_ - var_573_7) / var_573_8
				local var_573_10 = Vector3.New(0, 1, 9.5)

				var_573_6.localPosition = Vector3.Lerp(arg_570_1.var_.moveOldPosR3401, var_573_10, var_573_9)
			end

			if arg_570_1.time_ >= var_573_7 + var_573_8 and arg_570_1.time_ < var_573_7 + var_573_8 + arg_573_0 then
				var_573_6.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_573_11 = 0
			local var_573_12 = 1.375

			if var_573_11 < arg_570_1.time_ and arg_570_1.time_ <= var_573_11 + arg_573_0 then
				arg_570_1.talkMaxDuration = 0
				arg_570_1.dialogCg_.alpha = 1

				arg_570_1.dialog_:SetActive(true)
				SetActive(arg_570_1.leftNameGo_, false)

				arg_570_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_570_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_570_1:RecordName(arg_570_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_570_1.iconTrs_.gameObject, false)
				arg_570_1.callingController_:SetSelectedState("normal")

				local var_573_13 = arg_570_1:GetWordFromCfg(1103404141)
				local var_573_14 = arg_570_1:FormatText(var_573_13.content)

				arg_570_1.text_.text = var_573_14

				LuaForUtil.ClearLinePrefixSymbol(arg_570_1.text_)

				local var_573_15 = 55
				local var_573_16 = utf8.len(var_573_14)
				local var_573_17 = var_573_15 <= 0 and var_573_12 or var_573_12 * (var_573_16 / var_573_15)

				if var_573_17 > 0 and var_573_12 < var_573_17 then
					arg_570_1.talkMaxDuration = var_573_17

					if var_573_17 + var_573_11 > arg_570_1.duration_ then
						arg_570_1.duration_ = var_573_17 + var_573_11
					end
				end

				arg_570_1.text_.text = var_573_14
				arg_570_1.typewritter.percent = 0

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(false)
				arg_570_1:RecordContent(arg_570_1.text_.text)
			end

			local var_573_18 = math.max(var_573_12, arg_570_1.talkMaxDuration)

			if var_573_11 <= arg_570_1.time_ and arg_570_1.time_ < var_573_11 + var_573_18 then
				arg_570_1.typewritter.percent = (arg_570_1.time_ - var_573_11) / var_573_18

				arg_570_1.typewritter:SetDirty()
			end

			if arg_570_1.time_ >= var_573_11 + var_573_18 and arg_570_1.time_ < var_573_11 + var_573_18 + arg_573_0 then
				arg_570_1.typewritter.percent = 1

				arg_570_1.typewritter:SetDirty()
				arg_570_1:ShowNextGo(true)
			end
		end

		arg_570_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R3401",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_570_1:InitPlayNodeList()
	end,
	Play1103404142 = function(arg_574_0, arg_574_1)
		arg_574_1.time_ = 0
		arg_574_1.frameCnt_ = 0
		arg_574_1.state_ = "playing"
		arg_574_1.curTalkId_ = 1103404142
		arg_574_1.duration_ = 5

		SetActive(arg_574_1.tipsGo_, false)

		function arg_574_1.onSingleLineFinish_()
			arg_574_1.onSingleLineUpdate_ = nil
			arg_574_1.onSingleLineFinish_ = nil
			arg_574_1.state_ = "waiting"
		end

		function arg_574_1.playNext_(arg_576_0)
			if arg_576_0 == 1 then
				arg_574_0:Play1103404143(arg_574_1)
			end
		end

		function arg_574_1.onSingleLineUpdate_(arg_577_0)
			local var_577_0 = 0
			local var_577_1 = 0.15

			if var_577_0 < arg_574_1.time_ and arg_574_1.time_ <= var_577_0 + arg_577_0 then
				arg_574_1.talkMaxDuration = 0
				arg_574_1.dialogCg_.alpha = 1

				arg_574_1.dialog_:SetActive(true)
				SetActive(arg_574_1.leftNameGo_, true)

				local var_577_2 = arg_574_1:FormatText(StoryNameCfg[7].name)

				arg_574_1.leftNameTxt_.text = var_577_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_574_1.leftNameTxt_.transform)

				arg_574_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_574_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_574_1:RecordName(arg_574_1.leftNameTxt_.text)
				SetActive(arg_574_1.iconTrs_.gameObject, true)
				arg_574_1.iconController_:SetSelectedState("hero")

				arg_574_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_574_1.callingController_:SetSelectedState("normal")

				arg_574_1.keyicon_.color = Color.New(1, 1, 1)
				arg_574_1.icon_.color = Color.New(1, 1, 1)

				local var_577_3 = arg_574_1:GetWordFromCfg(1103404142)
				local var_577_4 = arg_574_1:FormatText(var_577_3.content)

				arg_574_1.text_.text = var_577_4

				LuaForUtil.ClearLinePrefixSymbol(arg_574_1.text_)

				local var_577_5 = 6
				local var_577_6 = utf8.len(var_577_4)
				local var_577_7 = var_577_5 <= 0 and var_577_1 or var_577_1 * (var_577_6 / var_577_5)

				if var_577_7 > 0 and var_577_1 < var_577_7 then
					arg_574_1.talkMaxDuration = var_577_7

					if var_577_7 + var_577_0 > arg_574_1.duration_ then
						arg_574_1.duration_ = var_577_7 + var_577_0
					end
				end

				arg_574_1.text_.text = var_577_4
				arg_574_1.typewritter.percent = 0

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(false)
				arg_574_1:RecordContent(arg_574_1.text_.text)
			end

			local var_577_8 = math.max(var_577_1, arg_574_1.talkMaxDuration)

			if var_577_0 <= arg_574_1.time_ and arg_574_1.time_ < var_577_0 + var_577_8 then
				arg_574_1.typewritter.percent = (arg_574_1.time_ - var_577_0) / var_577_8

				arg_574_1.typewritter:SetDirty()
			end

			if arg_574_1.time_ >= var_577_0 + var_577_8 and arg_574_1.time_ < var_577_0 + var_577_8 + arg_577_0 then
				arg_574_1.typewritter.percent = 1

				arg_574_1.typewritter:SetDirty()
				arg_574_1:ShowNextGo(true)
			end
		end

		arg_574_1.nodeConfigList_ = {}

		arg_574_1:InitPlayNodeList()
	end,
	Play1103404143 = function(arg_578_0, arg_578_1)
		arg_578_1.time_ = 0
		arg_578_1.frameCnt_ = 0
		arg_578_1.state_ = "playing"
		arg_578_1.curTalkId_ = 1103404143
		arg_578_1.duration_ = 2.93

		SetActive(arg_578_1.tipsGo_, false)

		function arg_578_1.onSingleLineFinish_()
			arg_578_1.onSingleLineUpdate_ = nil
			arg_578_1.onSingleLineFinish_ = nil
			arg_578_1.state_ = "waiting"
		end

		function arg_578_1.playNext_(arg_580_0)
			if arg_580_0 == 1 then
				arg_578_0:Play1103404144(arg_578_1)
			end
		end

		function arg_578_1.onSingleLineUpdate_(arg_581_0)
			local var_581_0 = 0
			local var_581_1 = 0.45

			if var_581_0 < arg_578_1.time_ and arg_578_1.time_ <= var_581_0 + arg_581_0 then
				arg_578_1.talkMaxDuration = 0
				arg_578_1.dialogCg_.alpha = 1

				arg_578_1.dialog_:SetActive(true)
				SetActive(arg_578_1.leftNameGo_, true)

				local var_581_2 = arg_578_1:FormatText(StoryNameCfg[1109].name)

				arg_578_1.leftNameTxt_.text = var_581_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_578_1.leftNameTxt_.transform)

				arg_578_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_578_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_578_1:RecordName(arg_578_1.leftNameTxt_.text)
				SetActive(arg_578_1.iconTrs_.gameObject, false)
				arg_578_1.callingController_:SetSelectedState("normal")

				local var_581_3 = arg_578_1:GetWordFromCfg(1103404143)
				local var_581_4 = arg_578_1:FormatText(var_581_3.content)

				arg_578_1.text_.text = var_581_4

				LuaForUtil.ClearLinePrefixSymbol(arg_578_1.text_)

				local var_581_5 = 18
				local var_581_6 = utf8.len(var_581_4)
				local var_581_7 = var_581_5 <= 0 and var_581_1 or var_581_1 * (var_581_6 / var_581_5)

				if var_581_7 > 0 and var_581_1 < var_581_7 then
					arg_578_1.talkMaxDuration = var_581_7

					if var_581_7 + var_581_0 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_7 + var_581_0
					end
				end

				arg_578_1.text_.text = var_581_4
				arg_578_1.typewritter.percent = 0

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404143", "story_v_side_new_1103404.awb") ~= 0 then
					local var_581_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404143", "story_v_side_new_1103404.awb") / 1000

					if var_581_8 + var_581_0 > arg_578_1.duration_ then
						arg_578_1.duration_ = var_581_8 + var_581_0
					end

					if var_581_3.prefab_name ~= "" and arg_578_1.actors_[var_581_3.prefab_name] ~= nil then
						local var_581_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_578_1.actors_[var_581_3.prefab_name].transform, "story_v_side_new_1103404", "1103404143", "story_v_side_new_1103404.awb")

						arg_578_1:RecordAudio("1103404143", var_581_9)
						arg_578_1:RecordAudio("1103404143", var_581_9)
					else
						arg_578_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404143", "story_v_side_new_1103404.awb")
					end

					arg_578_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404143", "story_v_side_new_1103404.awb")
				end

				arg_578_1:RecordContent(arg_578_1.text_.text)
			end

			local var_581_10 = math.max(var_581_1, arg_578_1.talkMaxDuration)

			if var_581_0 <= arg_578_1.time_ and arg_578_1.time_ < var_581_0 + var_581_10 then
				arg_578_1.typewritter.percent = (arg_578_1.time_ - var_581_0) / var_581_10

				arg_578_1.typewritter:SetDirty()
			end

			if arg_578_1.time_ >= var_581_0 + var_581_10 and arg_578_1.time_ < var_581_0 + var_581_10 + arg_581_0 then
				arg_578_1.typewritter.percent = 1

				arg_578_1.typewritter:SetDirty()
				arg_578_1:ShowNextGo(true)
			end
		end

		arg_578_1.nodeConfigList_ = {}

		arg_578_1:InitPlayNodeList()
	end,
	Play1103404144 = function(arg_582_0, arg_582_1)
		arg_582_1.time_ = 0
		arg_582_1.frameCnt_ = 0
		arg_582_1.state_ = "playing"
		arg_582_1.curTalkId_ = 1103404144
		arg_582_1.duration_ = 3.97

		SetActive(arg_582_1.tipsGo_, false)

		function arg_582_1.onSingleLineFinish_()
			arg_582_1.onSingleLineUpdate_ = nil
			arg_582_1.onSingleLineFinish_ = nil
			arg_582_1.state_ = "waiting"
		end

		function arg_582_1.playNext_(arg_584_0)
			if arg_584_0 == 1 then
				arg_582_0:Play1103404145(arg_582_1)
			end
		end

		function arg_582_1.onSingleLineUpdate_(arg_585_0)
			local var_585_0 = 0
			local var_585_1 = 0.425

			if var_585_0 < arg_582_1.time_ and arg_582_1.time_ <= var_585_0 + arg_585_0 then
				arg_582_1.talkMaxDuration = 0
				arg_582_1.dialogCg_.alpha = 1

				arg_582_1.dialog_:SetActive(true)
				SetActive(arg_582_1.leftNameGo_, true)

				local var_585_2 = arg_582_1:FormatText(StoryNameCfg[1109].name)

				arg_582_1.leftNameTxt_.text = var_585_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_582_1.leftNameTxt_.transform)

				arg_582_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_582_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_582_1:RecordName(arg_582_1.leftNameTxt_.text)
				SetActive(arg_582_1.iconTrs_.gameObject, false)
				arg_582_1.callingController_:SetSelectedState("normal")

				local var_585_3 = arg_582_1:GetWordFromCfg(1103404144)
				local var_585_4 = arg_582_1:FormatText(var_585_3.content)

				arg_582_1.text_.text = var_585_4

				LuaForUtil.ClearLinePrefixSymbol(arg_582_1.text_)

				local var_585_5 = 17
				local var_585_6 = utf8.len(var_585_4)
				local var_585_7 = var_585_5 <= 0 and var_585_1 or var_585_1 * (var_585_6 / var_585_5)

				if var_585_7 > 0 and var_585_1 < var_585_7 then
					arg_582_1.talkMaxDuration = var_585_7

					if var_585_7 + var_585_0 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_7 + var_585_0
					end
				end

				arg_582_1.text_.text = var_585_4
				arg_582_1.typewritter.percent = 0

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404144", "story_v_side_new_1103404.awb") ~= 0 then
					local var_585_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404144", "story_v_side_new_1103404.awb") / 1000

					if var_585_8 + var_585_0 > arg_582_1.duration_ then
						arg_582_1.duration_ = var_585_8 + var_585_0
					end

					if var_585_3.prefab_name ~= "" and arg_582_1.actors_[var_585_3.prefab_name] ~= nil then
						local var_585_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_582_1.actors_[var_585_3.prefab_name].transform, "story_v_side_new_1103404", "1103404144", "story_v_side_new_1103404.awb")

						arg_582_1:RecordAudio("1103404144", var_585_9)
						arg_582_1:RecordAudio("1103404144", var_585_9)
					else
						arg_582_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404144", "story_v_side_new_1103404.awb")
					end

					arg_582_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404144", "story_v_side_new_1103404.awb")
				end

				arg_582_1:RecordContent(arg_582_1.text_.text)
			end

			local var_585_10 = math.max(var_585_1, arg_582_1.talkMaxDuration)

			if var_585_0 <= arg_582_1.time_ and arg_582_1.time_ < var_585_0 + var_585_10 then
				arg_582_1.typewritter.percent = (arg_582_1.time_ - var_585_0) / var_585_10

				arg_582_1.typewritter:SetDirty()
			end

			if arg_582_1.time_ >= var_585_0 + var_585_10 and arg_582_1.time_ < var_585_0 + var_585_10 + arg_585_0 then
				arg_582_1.typewritter.percent = 1

				arg_582_1.typewritter:SetDirty()
				arg_582_1:ShowNextGo(true)
			end
		end

		arg_582_1.nodeConfigList_ = {}

		arg_582_1:InitPlayNodeList()
	end,
	Play1103404145 = function(arg_586_0, arg_586_1)
		arg_586_1.time_ = 0
		arg_586_1.frameCnt_ = 0
		arg_586_1.state_ = "playing"
		arg_586_1.curTalkId_ = 1103404145
		arg_586_1.duration_ = 5

		SetActive(arg_586_1.tipsGo_, false)

		function arg_586_1.onSingleLineFinish_()
			arg_586_1.onSingleLineUpdate_ = nil
			arg_586_1.onSingleLineFinish_ = nil
			arg_586_1.state_ = "waiting"
		end

		function arg_586_1.playNext_(arg_588_0)
			if arg_588_0 == 1 then
				arg_586_0:Play1103404146(arg_586_1)
			end
		end

		function arg_586_1.onSingleLineUpdate_(arg_589_0)
			local var_589_0 = arg_586_1.actors_["1034ui_story"]
			local var_589_1 = 0

			if var_589_1 < arg_586_1.time_ and arg_586_1.time_ <= var_589_1 + arg_589_0 and not isNil(var_589_0) and arg_586_1.var_.characterEffect1034ui_story == nil then
				arg_586_1.var_.characterEffect1034ui_story = var_589_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_589_2 = 0.200000002980232

			if var_589_1 <= arg_586_1.time_ and arg_586_1.time_ < var_589_1 + var_589_2 and not isNil(var_589_0) then
				local var_589_3 = (arg_586_1.time_ - var_589_1) / var_589_2

				if arg_586_1.var_.characterEffect1034ui_story and not isNil(var_589_0) then
					local var_589_4 = Mathf.Lerp(0, 0.5, var_589_3)

					arg_586_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_586_1.var_.characterEffect1034ui_story.fillRatio = var_589_4
				end
			end

			if arg_586_1.time_ >= var_589_1 + var_589_2 and arg_586_1.time_ < var_589_1 + var_589_2 + arg_589_0 and not isNil(var_589_0) and arg_586_1.var_.characterEffect1034ui_story then
				local var_589_5 = 0.5

				arg_586_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_586_1.var_.characterEffect1034ui_story.fillRatio = var_589_5
			end

			local var_589_6 = 0
			local var_589_7 = 1.375

			if var_589_6 < arg_586_1.time_ and arg_586_1.time_ <= var_589_6 + arg_589_0 then
				arg_586_1.talkMaxDuration = 0
				arg_586_1.dialogCg_.alpha = 1

				arg_586_1.dialog_:SetActive(true)
				SetActive(arg_586_1.leftNameGo_, false)

				arg_586_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_586_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_586_1:RecordName(arg_586_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_586_1.iconTrs_.gameObject, false)
				arg_586_1.callingController_:SetSelectedState("normal")

				local var_589_8 = arg_586_1:GetWordFromCfg(1103404145)
				local var_589_9 = arg_586_1:FormatText(var_589_8.content)

				arg_586_1.text_.text = var_589_9

				LuaForUtil.ClearLinePrefixSymbol(arg_586_1.text_)

				local var_589_10 = 55
				local var_589_11 = utf8.len(var_589_9)
				local var_589_12 = var_589_10 <= 0 and var_589_7 or var_589_7 * (var_589_11 / var_589_10)

				if var_589_12 > 0 and var_589_7 < var_589_12 then
					arg_586_1.talkMaxDuration = var_589_12

					if var_589_12 + var_589_6 > arg_586_1.duration_ then
						arg_586_1.duration_ = var_589_12 + var_589_6
					end
				end

				arg_586_1.text_.text = var_589_9
				arg_586_1.typewritter.percent = 0

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(false)
				arg_586_1:RecordContent(arg_586_1.text_.text)
			end

			local var_589_13 = math.max(var_589_7, arg_586_1.talkMaxDuration)

			if var_589_6 <= arg_586_1.time_ and arg_586_1.time_ < var_589_6 + var_589_13 then
				arg_586_1.typewritter.percent = (arg_586_1.time_ - var_589_6) / var_589_13

				arg_586_1.typewritter:SetDirty()
			end

			if arg_586_1.time_ >= var_589_6 + var_589_13 and arg_586_1.time_ < var_589_6 + var_589_13 + arg_589_0 then
				arg_586_1.typewritter.percent = 1

				arg_586_1.typewritter:SetDirty()
				arg_586_1:ShowNextGo(true)
			end
		end

		arg_586_1.nodeConfigList_ = {}

		arg_586_1:InitPlayNodeList()
	end,
	Play1103404146 = function(arg_590_0, arg_590_1)
		arg_590_1.time_ = 0
		arg_590_1.frameCnt_ = 0
		arg_590_1.state_ = "playing"
		arg_590_1.curTalkId_ = 1103404146
		arg_590_1.duration_ = 5

		SetActive(arg_590_1.tipsGo_, false)

		function arg_590_1.onSingleLineFinish_()
			arg_590_1.onSingleLineUpdate_ = nil
			arg_590_1.onSingleLineFinish_ = nil
			arg_590_1.state_ = "waiting"
		end

		function arg_590_1.playNext_(arg_592_0)
			if arg_592_0 == 1 then
				arg_590_0:Play1103404147(arg_590_1)
			end
		end

		function arg_590_1.onSingleLineUpdate_(arg_593_0)
			local var_593_0 = 0

			if var_593_0 < arg_590_1.time_ and arg_590_1.time_ <= var_593_0 + arg_593_0 then
				arg_590_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileF_biyan", "EmotionTimelineAnimator")
			end

			local var_593_1 = 0
			local var_593_2 = 1.425

			if var_593_1 < arg_590_1.time_ and arg_590_1.time_ <= var_593_1 + arg_593_0 then
				arg_590_1.talkMaxDuration = 0
				arg_590_1.dialogCg_.alpha = 1

				arg_590_1.dialog_:SetActive(true)
				SetActive(arg_590_1.leftNameGo_, false)

				arg_590_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_590_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_590_1:RecordName(arg_590_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_590_1.iconTrs_.gameObject, false)
				arg_590_1.callingController_:SetSelectedState("normal")

				local var_593_3 = arg_590_1:GetWordFromCfg(1103404146)
				local var_593_4 = arg_590_1:FormatText(var_593_3.content)

				arg_590_1.text_.text = var_593_4

				LuaForUtil.ClearLinePrefixSymbol(arg_590_1.text_)

				local var_593_5 = 57
				local var_593_6 = utf8.len(var_593_4)
				local var_593_7 = var_593_5 <= 0 and var_593_2 or var_593_2 * (var_593_6 / var_593_5)

				if var_593_7 > 0 and var_593_2 < var_593_7 then
					arg_590_1.talkMaxDuration = var_593_7

					if var_593_7 + var_593_1 > arg_590_1.duration_ then
						arg_590_1.duration_ = var_593_7 + var_593_1
					end
				end

				arg_590_1.text_.text = var_593_4
				arg_590_1.typewritter.percent = 0

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(false)
				arg_590_1:RecordContent(arg_590_1.text_.text)
			end

			local var_593_8 = math.max(var_593_2, arg_590_1.talkMaxDuration)

			if var_593_1 <= arg_590_1.time_ and arg_590_1.time_ < var_593_1 + var_593_8 then
				arg_590_1.typewritter.percent = (arg_590_1.time_ - var_593_1) / var_593_8

				arg_590_1.typewritter:SetDirty()
			end

			if arg_590_1.time_ >= var_593_1 + var_593_8 and arg_590_1.time_ < var_593_1 + var_593_8 + arg_593_0 then
				arg_590_1.typewritter.percent = 1

				arg_590_1.typewritter:SetDirty()
				arg_590_1:ShowNextGo(true)
			end
		end

		arg_590_1.nodeConfigList_ = {}

		arg_590_1:InitPlayNodeList()
	end,
	Play1103404147 = function(arg_594_0, arg_594_1)
		arg_594_1.time_ = 0
		arg_594_1.frameCnt_ = 0
		arg_594_1.state_ = "playing"
		arg_594_1.curTalkId_ = 1103404147
		arg_594_1.duration_ = 4.5

		SetActive(arg_594_1.tipsGo_, false)

		function arg_594_1.onSingleLineFinish_()
			arg_594_1.onSingleLineUpdate_ = nil
			arg_594_1.onSingleLineFinish_ = nil
			arg_594_1.state_ = "waiting"
		end

		function arg_594_1.playNext_(arg_596_0)
			if arg_596_0 == 1 then
				arg_594_0:Play1103404148(arg_594_1)
			end
		end

		function arg_594_1.onSingleLineUpdate_(arg_597_0)
			local var_597_0 = arg_594_1.bgs_.R3401.transform
			local var_597_1 = 0

			if var_597_1 < arg_594_1.time_ and arg_594_1.time_ <= var_597_1 + arg_597_0 then
				arg_594_1.var_.moveOldPosR3401 = var_597_0.localPosition
			end

			local var_597_2 = 2

			if var_597_1 <= arg_594_1.time_ and arg_594_1.time_ < var_597_1 + var_597_2 then
				local var_597_3 = (arg_594_1.time_ - var_597_1) / var_597_2
				local var_597_4 = Vector3.New(0, 1, 10)

				var_597_0.localPosition = Vector3.Lerp(arg_594_1.var_.moveOldPosR3401, var_597_4, var_597_3)
			end

			if arg_594_1.time_ >= var_597_1 + var_597_2 and arg_594_1.time_ < var_597_1 + var_597_2 + arg_597_0 then
				var_597_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_597_5 = 0
			local var_597_6 = 0.525

			if var_597_5 < arg_594_1.time_ and arg_594_1.time_ <= var_597_5 + arg_597_0 then
				arg_594_1.talkMaxDuration = 0
				arg_594_1.dialogCg_.alpha = 1

				arg_594_1.dialog_:SetActive(true)
				SetActive(arg_594_1.leftNameGo_, true)

				local var_597_7 = arg_594_1:FormatText(StoryNameCfg[1109].name)

				arg_594_1.leftNameTxt_.text = var_597_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_594_1.leftNameTxt_.transform)

				arg_594_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_594_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_594_1:RecordName(arg_594_1.leftNameTxt_.text)
				SetActive(arg_594_1.iconTrs_.gameObject, false)
				arg_594_1.callingController_:SetSelectedState("normal")

				local var_597_8 = arg_594_1:GetWordFromCfg(1103404147)
				local var_597_9 = arg_594_1:FormatText(var_597_8.content)

				arg_594_1.text_.text = var_597_9

				LuaForUtil.ClearLinePrefixSymbol(arg_594_1.text_)

				local var_597_10 = 21
				local var_597_11 = utf8.len(var_597_9)
				local var_597_12 = var_597_10 <= 0 and var_597_6 or var_597_6 * (var_597_11 / var_597_10)

				if var_597_12 > 0 and var_597_6 < var_597_12 then
					arg_594_1.talkMaxDuration = var_597_12

					if var_597_12 + var_597_5 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_12 + var_597_5
					end
				end

				arg_594_1.text_.text = var_597_9
				arg_594_1.typewritter.percent = 0

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404147", "story_v_side_new_1103404.awb") ~= 0 then
					local var_597_13 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404147", "story_v_side_new_1103404.awb") / 1000

					if var_597_13 + var_597_5 > arg_594_1.duration_ then
						arg_594_1.duration_ = var_597_13 + var_597_5
					end

					if var_597_8.prefab_name ~= "" and arg_594_1.actors_[var_597_8.prefab_name] ~= nil then
						local var_597_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_594_1.actors_[var_597_8.prefab_name].transform, "story_v_side_new_1103404", "1103404147", "story_v_side_new_1103404.awb")

						arg_594_1:RecordAudio("1103404147", var_597_14)
						arg_594_1:RecordAudio("1103404147", var_597_14)
					else
						arg_594_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404147", "story_v_side_new_1103404.awb")
					end

					arg_594_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404147", "story_v_side_new_1103404.awb")
				end

				arg_594_1:RecordContent(arg_594_1.text_.text)
			end

			local var_597_15 = math.max(var_597_6, arg_594_1.talkMaxDuration)

			if var_597_5 <= arg_594_1.time_ and arg_594_1.time_ < var_597_5 + var_597_15 then
				arg_594_1.typewritter.percent = (arg_594_1.time_ - var_597_5) / var_597_15

				arg_594_1.typewritter:SetDirty()
			end

			if arg_594_1.time_ >= var_597_5 + var_597_15 and arg_594_1.time_ < var_597_5 + var_597_15 + arg_597_0 then
				arg_594_1.typewritter.percent = 1

				arg_594_1.typewritter:SetDirty()
				arg_594_1:ShowNextGo(true)
			end
		end

		arg_594_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R3401",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_594_1:InitPlayNodeList()
	end,
	Play1103404148 = function(arg_598_0, arg_598_1)
		arg_598_1.time_ = 0
		arg_598_1.frameCnt_ = 0
		arg_598_1.state_ = "playing"
		arg_598_1.curTalkId_ = 1103404148
		arg_598_1.duration_ = 5

		SetActive(arg_598_1.tipsGo_, false)

		function arg_598_1.onSingleLineFinish_()
			arg_598_1.onSingleLineUpdate_ = nil
			arg_598_1.onSingleLineFinish_ = nil
			arg_598_1.state_ = "waiting"
		end

		function arg_598_1.playNext_(arg_600_0)
			if arg_600_0 == 1 then
				arg_598_0:Play1103404149(arg_598_1)
			end
		end

		function arg_598_1.onSingleLineUpdate_(arg_601_0)
			local var_601_0 = 0
			local var_601_1 = 0.625

			if var_601_0 < arg_598_1.time_ and arg_598_1.time_ <= var_601_0 + arg_601_0 then
				arg_598_1.talkMaxDuration = 0
				arg_598_1.dialogCg_.alpha = 1

				arg_598_1.dialog_:SetActive(true)
				SetActive(arg_598_1.leftNameGo_, true)

				local var_601_2 = arg_598_1:FormatText(StoryNameCfg[1109].name)

				arg_598_1.leftNameTxt_.text = var_601_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_598_1.leftNameTxt_.transform)

				arg_598_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_598_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_598_1:RecordName(arg_598_1.leftNameTxt_.text)
				SetActive(arg_598_1.iconTrs_.gameObject, false)
				arg_598_1.callingController_:SetSelectedState("normal")

				local var_601_3 = arg_598_1:GetWordFromCfg(1103404148)
				local var_601_4 = arg_598_1:FormatText(var_601_3.content)

				arg_598_1.text_.text = var_601_4

				LuaForUtil.ClearLinePrefixSymbol(arg_598_1.text_)

				local var_601_5 = 25
				local var_601_6 = utf8.len(var_601_4)
				local var_601_7 = var_601_5 <= 0 and var_601_1 or var_601_1 * (var_601_6 / var_601_5)

				if var_601_7 > 0 and var_601_1 < var_601_7 then
					arg_598_1.talkMaxDuration = var_601_7

					if var_601_7 + var_601_0 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_7 + var_601_0
					end
				end

				arg_598_1.text_.text = var_601_4
				arg_598_1.typewritter.percent = 0

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404148", "story_v_side_new_1103404.awb") ~= 0 then
					local var_601_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404148", "story_v_side_new_1103404.awb") / 1000

					if var_601_8 + var_601_0 > arg_598_1.duration_ then
						arg_598_1.duration_ = var_601_8 + var_601_0
					end

					if var_601_3.prefab_name ~= "" and arg_598_1.actors_[var_601_3.prefab_name] ~= nil then
						local var_601_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_598_1.actors_[var_601_3.prefab_name].transform, "story_v_side_new_1103404", "1103404148", "story_v_side_new_1103404.awb")

						arg_598_1:RecordAudio("1103404148", var_601_9)
						arg_598_1:RecordAudio("1103404148", var_601_9)
					else
						arg_598_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404148", "story_v_side_new_1103404.awb")
					end

					arg_598_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404148", "story_v_side_new_1103404.awb")
				end

				arg_598_1:RecordContent(arg_598_1.text_.text)
			end

			local var_601_10 = math.max(var_601_1, arg_598_1.talkMaxDuration)

			if var_601_0 <= arg_598_1.time_ and arg_598_1.time_ < var_601_0 + var_601_10 then
				arg_598_1.typewritter.percent = (arg_598_1.time_ - var_601_0) / var_601_10

				arg_598_1.typewritter:SetDirty()
			end

			if arg_598_1.time_ >= var_601_0 + var_601_10 and arg_598_1.time_ < var_601_0 + var_601_10 + arg_601_0 then
				arg_598_1.typewritter.percent = 1

				arg_598_1.typewritter:SetDirty()
				arg_598_1:ShowNextGo(true)
			end
		end

		arg_598_1.nodeConfigList_ = {}

		arg_598_1:InitPlayNodeList()
	end,
	Play1103404149 = function(arg_602_0, arg_602_1)
		arg_602_1.time_ = 0
		arg_602_1.frameCnt_ = 0
		arg_602_1.state_ = "playing"
		arg_602_1.curTalkId_ = 1103404149
		arg_602_1.duration_ = 5

		SetActive(arg_602_1.tipsGo_, false)

		function arg_602_1.onSingleLineFinish_()
			arg_602_1.onSingleLineUpdate_ = nil
			arg_602_1.onSingleLineFinish_ = nil
			arg_602_1.state_ = "waiting"
		end

		function arg_602_1.playNext_(arg_604_0)
			if arg_604_0 == 1 then
				arg_602_0:Play1103404150(arg_602_1)
			end
		end

		function arg_602_1.onSingleLineUpdate_(arg_605_0)
			local var_605_0 = arg_602_1.actors_["1034ui_story"]
			local var_605_1 = 0

			if var_605_1 < arg_602_1.time_ and arg_602_1.time_ <= var_605_1 + arg_605_0 and not isNil(var_605_0) and arg_602_1.var_.characterEffect1034ui_story == nil then
				arg_602_1.var_.characterEffect1034ui_story = var_605_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_605_2 = 0.200000002980232

			if var_605_1 <= arg_602_1.time_ and arg_602_1.time_ < var_605_1 + var_605_2 and not isNil(var_605_0) then
				local var_605_3 = (arg_602_1.time_ - var_605_1) / var_605_2

				if arg_602_1.var_.characterEffect1034ui_story and not isNil(var_605_0) then
					local var_605_4 = Mathf.Lerp(0, 0.5, var_605_3)

					arg_602_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_602_1.var_.characterEffect1034ui_story.fillRatio = var_605_4
				end
			end

			if arg_602_1.time_ >= var_605_1 + var_605_2 and arg_602_1.time_ < var_605_1 + var_605_2 + arg_605_0 and not isNil(var_605_0) and arg_602_1.var_.characterEffect1034ui_story then
				local var_605_5 = 0.5

				arg_602_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_602_1.var_.characterEffect1034ui_story.fillRatio = var_605_5
			end

			local var_605_6 = 0

			if var_605_6 < arg_602_1.time_ and arg_602_1.time_ <= var_605_6 + arg_605_0 then
				arg_602_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_605_7 = 0
			local var_605_8 = 0.6

			if var_605_7 < arg_602_1.time_ and arg_602_1.time_ <= var_605_7 + arg_605_0 then
				arg_602_1.talkMaxDuration = 0
				arg_602_1.dialogCg_.alpha = 1

				arg_602_1.dialog_:SetActive(true)
				SetActive(arg_602_1.leftNameGo_, true)

				local var_605_9 = arg_602_1:FormatText(StoryNameCfg[7].name)

				arg_602_1.leftNameTxt_.text = var_605_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_602_1.leftNameTxt_.transform)

				arg_602_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_602_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_602_1:RecordName(arg_602_1.leftNameTxt_.text)
				SetActive(arg_602_1.iconTrs_.gameObject, true)
				arg_602_1.iconController_:SetSelectedState("hero")

				arg_602_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_602_1.callingController_:SetSelectedState("normal")

				arg_602_1.keyicon_.color = Color.New(1, 1, 1)
				arg_602_1.icon_.color = Color.New(1, 1, 1)

				local var_605_10 = arg_602_1:GetWordFromCfg(1103404149)
				local var_605_11 = arg_602_1:FormatText(var_605_10.content)

				arg_602_1.text_.text = var_605_11

				LuaForUtil.ClearLinePrefixSymbol(arg_602_1.text_)

				local var_605_12 = 24
				local var_605_13 = utf8.len(var_605_11)
				local var_605_14 = var_605_12 <= 0 and var_605_8 or var_605_8 * (var_605_13 / var_605_12)

				if var_605_14 > 0 and var_605_8 < var_605_14 then
					arg_602_1.talkMaxDuration = var_605_14

					if var_605_14 + var_605_7 > arg_602_1.duration_ then
						arg_602_1.duration_ = var_605_14 + var_605_7
					end
				end

				arg_602_1.text_.text = var_605_11
				arg_602_1.typewritter.percent = 0

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(false)
				arg_602_1:RecordContent(arg_602_1.text_.text)
			end

			local var_605_15 = math.max(var_605_8, arg_602_1.talkMaxDuration)

			if var_605_7 <= arg_602_1.time_ and arg_602_1.time_ < var_605_7 + var_605_15 then
				arg_602_1.typewritter.percent = (arg_602_1.time_ - var_605_7) / var_605_15

				arg_602_1.typewritter:SetDirty()
			end

			if arg_602_1.time_ >= var_605_7 + var_605_15 and arg_602_1.time_ < var_605_7 + var_605_15 + arg_605_0 then
				arg_602_1.typewritter.percent = 1

				arg_602_1.typewritter:SetDirty()
				arg_602_1:ShowNextGo(true)
			end
		end

		arg_602_1.nodeConfigList_ = {}

		arg_602_1:InitPlayNodeList()
	end,
	Play1103404150 = function(arg_606_0, arg_606_1)
		arg_606_1.time_ = 0
		arg_606_1.frameCnt_ = 0
		arg_606_1.state_ = "playing"
		arg_606_1.curTalkId_ = 1103404150
		arg_606_1.duration_ = 6.07

		SetActive(arg_606_1.tipsGo_, false)

		function arg_606_1.onSingleLineFinish_()
			arg_606_1.onSingleLineUpdate_ = nil
			arg_606_1.onSingleLineFinish_ = nil
			arg_606_1.state_ = "waiting"
		end

		function arg_606_1.playNext_(arg_608_0)
			if arg_608_0 == 1 then
				arg_606_0:Play1103404151(arg_606_1)
			end
		end

		function arg_606_1.onSingleLineUpdate_(arg_609_0)
			local var_609_0 = 0
			local var_609_1 = 0.6

			if var_609_0 < arg_606_1.time_ and arg_606_1.time_ <= var_609_0 + arg_609_0 then
				arg_606_1.talkMaxDuration = 0
				arg_606_1.dialogCg_.alpha = 1

				arg_606_1.dialog_:SetActive(true)
				SetActive(arg_606_1.leftNameGo_, true)

				local var_609_2 = arg_606_1:FormatText(StoryNameCfg[1109].name)

				arg_606_1.leftNameTxt_.text = var_609_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_606_1.leftNameTxt_.transform)

				arg_606_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_606_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_606_1:RecordName(arg_606_1.leftNameTxt_.text)
				SetActive(arg_606_1.iconTrs_.gameObject, false)
				arg_606_1.callingController_:SetSelectedState("normal")

				local var_609_3 = arg_606_1:GetWordFromCfg(1103404150)
				local var_609_4 = arg_606_1:FormatText(var_609_3.content)

				arg_606_1.text_.text = var_609_4

				LuaForUtil.ClearLinePrefixSymbol(arg_606_1.text_)

				local var_609_5 = 24
				local var_609_6 = utf8.len(var_609_4)
				local var_609_7 = var_609_5 <= 0 and var_609_1 or var_609_1 * (var_609_6 / var_609_5)

				if var_609_7 > 0 and var_609_1 < var_609_7 then
					arg_606_1.talkMaxDuration = var_609_7

					if var_609_7 + var_609_0 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_7 + var_609_0
					end
				end

				arg_606_1.text_.text = var_609_4
				arg_606_1.typewritter.percent = 0

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404150", "story_v_side_new_1103404.awb") ~= 0 then
					local var_609_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404150", "story_v_side_new_1103404.awb") / 1000

					if var_609_8 + var_609_0 > arg_606_1.duration_ then
						arg_606_1.duration_ = var_609_8 + var_609_0
					end

					if var_609_3.prefab_name ~= "" and arg_606_1.actors_[var_609_3.prefab_name] ~= nil then
						local var_609_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_606_1.actors_[var_609_3.prefab_name].transform, "story_v_side_new_1103404", "1103404150", "story_v_side_new_1103404.awb")

						arg_606_1:RecordAudio("1103404150", var_609_9)
						arg_606_1:RecordAudio("1103404150", var_609_9)
					else
						arg_606_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404150", "story_v_side_new_1103404.awb")
					end

					arg_606_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404150", "story_v_side_new_1103404.awb")
				end

				arg_606_1:RecordContent(arg_606_1.text_.text)
			end

			local var_609_10 = math.max(var_609_1, arg_606_1.talkMaxDuration)

			if var_609_0 <= arg_606_1.time_ and arg_606_1.time_ < var_609_0 + var_609_10 then
				arg_606_1.typewritter.percent = (arg_606_1.time_ - var_609_0) / var_609_10

				arg_606_1.typewritter:SetDirty()
			end

			if arg_606_1.time_ >= var_609_0 + var_609_10 and arg_606_1.time_ < var_609_0 + var_609_10 + arg_609_0 then
				arg_606_1.typewritter.percent = 1

				arg_606_1.typewritter:SetDirty()
				arg_606_1:ShowNextGo(true)
			end
		end

		arg_606_1.nodeConfigList_ = {}

		arg_606_1:InitPlayNodeList()
	end,
	Play1103404151 = function(arg_610_0, arg_610_1)
		arg_610_1.time_ = 0
		arg_610_1.frameCnt_ = 0
		arg_610_1.state_ = "playing"
		arg_610_1.curTalkId_ = 1103404151
		arg_610_1.duration_ = 5

		SetActive(arg_610_1.tipsGo_, false)

		function arg_610_1.onSingleLineFinish_()
			arg_610_1.onSingleLineUpdate_ = nil
			arg_610_1.onSingleLineFinish_ = nil
			arg_610_1.state_ = "waiting"
		end

		function arg_610_1.playNext_(arg_612_0)
			if arg_612_0 == 1 then
				arg_610_0:Play1103404152(arg_610_1)
			end
		end

		function arg_610_1.onSingleLineUpdate_(arg_613_0)
			local var_613_0 = arg_610_1.actors_["1034ui_story"]
			local var_613_1 = 0

			if var_613_1 < arg_610_1.time_ and arg_610_1.time_ <= var_613_1 + arg_613_0 and not isNil(var_613_0) and arg_610_1.var_.characterEffect1034ui_story == nil then
				arg_610_1.var_.characterEffect1034ui_story = var_613_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_613_2 = 0.200000002980232

			if var_613_1 <= arg_610_1.time_ and arg_610_1.time_ < var_613_1 + var_613_2 and not isNil(var_613_0) then
				local var_613_3 = (arg_610_1.time_ - var_613_1) / var_613_2

				if arg_610_1.var_.characterEffect1034ui_story and not isNil(var_613_0) then
					local var_613_4 = Mathf.Lerp(0, 0.5, var_613_3)

					arg_610_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_610_1.var_.characterEffect1034ui_story.fillRatio = var_613_4
				end
			end

			if arg_610_1.time_ >= var_613_1 + var_613_2 and arg_610_1.time_ < var_613_1 + var_613_2 + arg_613_0 and not isNil(var_613_0) and arg_610_1.var_.characterEffect1034ui_story then
				local var_613_5 = 0.5

				arg_610_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_610_1.var_.characterEffect1034ui_story.fillRatio = var_613_5
			end

			local var_613_6 = 0

			if var_613_6 < arg_610_1.time_ and arg_610_1.time_ <= var_613_6 + arg_613_0 then
				arg_610_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_613_7 = 0
			local var_613_8 = 1.75

			if var_613_7 < arg_610_1.time_ and arg_610_1.time_ <= var_613_7 + arg_613_0 then
				arg_610_1.talkMaxDuration = 0
				arg_610_1.dialogCg_.alpha = 1

				arg_610_1.dialog_:SetActive(true)
				SetActive(arg_610_1.leftNameGo_, false)

				arg_610_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_610_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_610_1:RecordName(arg_610_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_610_1.iconTrs_.gameObject, false)
				arg_610_1.callingController_:SetSelectedState("normal")

				local var_613_9 = arg_610_1:GetWordFromCfg(1103404151)
				local var_613_10 = arg_610_1:FormatText(var_613_9.content)

				arg_610_1.text_.text = var_613_10

				LuaForUtil.ClearLinePrefixSymbol(arg_610_1.text_)

				local var_613_11 = 70
				local var_613_12 = utf8.len(var_613_10)
				local var_613_13 = var_613_11 <= 0 and var_613_8 or var_613_8 * (var_613_12 / var_613_11)

				if var_613_13 > 0 and var_613_8 < var_613_13 then
					arg_610_1.talkMaxDuration = var_613_13

					if var_613_13 + var_613_7 > arg_610_1.duration_ then
						arg_610_1.duration_ = var_613_13 + var_613_7
					end
				end

				arg_610_1.text_.text = var_613_10
				arg_610_1.typewritter.percent = 0

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(false)
				arg_610_1:RecordContent(arg_610_1.text_.text)
			end

			local var_613_14 = math.max(var_613_8, arg_610_1.talkMaxDuration)

			if var_613_7 <= arg_610_1.time_ and arg_610_1.time_ < var_613_7 + var_613_14 then
				arg_610_1.typewritter.percent = (arg_610_1.time_ - var_613_7) / var_613_14

				arg_610_1.typewritter:SetDirty()
			end

			if arg_610_1.time_ >= var_613_7 + var_613_14 and arg_610_1.time_ < var_613_7 + var_613_14 + arg_613_0 then
				arg_610_1.typewritter.percent = 1

				arg_610_1.typewritter:SetDirty()
				arg_610_1:ShowNextGo(true)
			end
		end

		arg_610_1.nodeConfigList_ = {}

		arg_610_1:InitPlayNodeList()
	end,
	Play1103404152 = function(arg_614_0, arg_614_1)
		arg_614_1.time_ = 0
		arg_614_1.frameCnt_ = 0
		arg_614_1.state_ = "playing"
		arg_614_1.curTalkId_ = 1103404152
		arg_614_1.duration_ = 8.98

		SetActive(arg_614_1.tipsGo_, false)

		function arg_614_1.onSingleLineFinish_()
			arg_614_1.onSingleLineUpdate_ = nil
			arg_614_1.onSingleLineFinish_ = nil
			arg_614_1.state_ = "waiting"
		end

		function arg_614_1.playNext_(arg_616_0)
			if arg_616_0 == 1 then
				arg_614_0:Play1103404153(arg_614_1)
			end
		end

		function arg_614_1.onSingleLineUpdate_(arg_617_0)
			local var_617_0 = "R3401a$naive"

			if arg_614_1.bgs_[var_617_0] == nil then
				local var_617_1 = Object.Instantiate(arg_614_1.paintGo_)

				var_617_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_617_0)
				var_617_1.name = var_617_0
				var_617_1.transform.parent = arg_614_1.stage_.transform
				var_617_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_614_1.bgs_[var_617_0] = var_617_1
			end

			local var_617_2 = 1.98333333333333

			if var_617_2 < arg_614_1.time_ and arg_614_1.time_ <= var_617_2 + arg_617_0 then
				local var_617_3 = manager.ui.mainCamera.transform.localPosition
				local var_617_4 = Vector3.New(0, 0, 10) + Vector3.New(var_617_3.x, var_617_3.y, 0)
				local var_617_5 = arg_614_1.bgs_["R3401a$naive"]

				var_617_5.transform.localPosition = var_617_4
				var_617_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_617_6 = var_617_5:GetComponent("SpriteRenderer")

				if var_617_6 and var_617_6.sprite then
					local var_617_7 = (var_617_5.transform.localPosition - var_617_3).z
					local var_617_8 = manager.ui.mainCameraCom_
					local var_617_9 = 2 * var_617_7 * Mathf.Tan(var_617_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_617_10 = var_617_9 * var_617_8.aspect
					local var_617_11 = var_617_6.sprite.bounds.size.x
					local var_617_12 = var_617_6.sprite.bounds.size.y
					local var_617_13 = var_617_10 / var_617_11
					local var_617_14 = var_617_9 / var_617_12
					local var_617_15 = var_617_14 < var_617_13 and var_617_13 or var_617_14

					var_617_5.transform.localScale = Vector3.New(var_617_15, var_617_15, 0)
				end

				for iter_617_0, iter_617_1 in pairs(arg_614_1.bgs_) do
					if iter_617_0 ~= "R3401a$naive" then
						iter_617_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_617_16 = 0

			if var_617_16 < arg_614_1.time_ and arg_614_1.time_ <= var_617_16 + arg_617_0 then
				arg_614_1.mask_.enabled = true
				arg_614_1.mask_.raycastTarget = true

				arg_614_1:SetGaussion(false)
			end

			local var_617_17 = 2

			if var_617_16 <= arg_614_1.time_ and arg_614_1.time_ < var_617_16 + var_617_17 then
				local var_617_18 = (arg_614_1.time_ - var_617_16) / var_617_17
				local var_617_19 = Color.New(0, 0, 0)

				var_617_19.a = Mathf.Lerp(0, 1, var_617_18)
				arg_614_1.mask_.color = var_617_19
			end

			if arg_614_1.time_ >= var_617_16 + var_617_17 and arg_614_1.time_ < var_617_16 + var_617_17 + arg_617_0 then
				local var_617_20 = Color.New(0, 0, 0)

				var_617_20.a = 1
				arg_614_1.mask_.color = var_617_20
			end

			local var_617_21 = 2

			if var_617_21 < arg_614_1.time_ and arg_614_1.time_ <= var_617_21 + arg_617_0 then
				arg_614_1.mask_.enabled = true
				arg_614_1.mask_.raycastTarget = true

				arg_614_1:SetGaussion(false)
			end

			local var_617_22 = 2

			if var_617_21 <= arg_614_1.time_ and arg_614_1.time_ < var_617_21 + var_617_22 then
				local var_617_23 = (arg_614_1.time_ - var_617_21) / var_617_22
				local var_617_24 = Color.New(0, 0, 0)

				var_617_24.a = Mathf.Lerp(1, 0, var_617_23)
				arg_614_1.mask_.color = var_617_24
			end

			if arg_614_1.time_ >= var_617_21 + var_617_22 and arg_614_1.time_ < var_617_21 + var_617_22 + arg_617_0 then
				local var_617_25 = Color.New(0, 0, 0)
				local var_617_26 = 0

				arg_614_1.mask_.enabled = false
				var_617_25.a = var_617_26
				arg_614_1.mask_.color = var_617_25
			end

			local var_617_27 = arg_614_1.actors_["1034ui_story"].transform
			local var_617_28 = 1.98333333333333

			if var_617_28 < arg_614_1.time_ and arg_614_1.time_ <= var_617_28 + arg_617_0 then
				arg_614_1.var_.moveOldPos1034ui_story = var_617_27.localPosition
			end

			local var_617_29 = 0.001

			if var_617_28 <= arg_614_1.time_ and arg_614_1.time_ < var_617_28 + var_617_29 then
				local var_617_30 = (arg_614_1.time_ - var_617_28) / var_617_29
				local var_617_31 = Vector3.New(0, 100, 0)

				var_617_27.localPosition = Vector3.Lerp(arg_614_1.var_.moveOldPos1034ui_story, var_617_31, var_617_30)

				local var_617_32 = manager.ui.mainCamera.transform.position - var_617_27.position

				var_617_27.forward = Vector3.New(var_617_32.x, var_617_32.y, var_617_32.z)

				local var_617_33 = var_617_27.localEulerAngles

				var_617_33.z = 0
				var_617_33.x = 0
				var_617_27.localEulerAngles = var_617_33
			end

			if arg_614_1.time_ >= var_617_28 + var_617_29 and arg_614_1.time_ < var_617_28 + var_617_29 + arg_617_0 then
				var_617_27.localPosition = Vector3.New(0, 100, 0)

				local var_617_34 = manager.ui.mainCamera.transform.position - var_617_27.position

				var_617_27.forward = Vector3.New(var_617_34.x, var_617_34.y, var_617_34.z)

				local var_617_35 = var_617_27.localEulerAngles

				var_617_35.z = 0
				var_617_35.x = 0
				var_617_27.localEulerAngles = var_617_35
			end

			local var_617_36 = "R3401a"

			if arg_614_1.bgs_[var_617_36] == nil then
				local var_617_37 = Object.Instantiate(arg_614_1.paintGo_)

				var_617_37:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_617_36)
				var_617_37.name = var_617_36
				var_617_37.transform.parent = arg_614_1.stage_.transform
				var_617_37.transform.localPosition = Vector3.New(0, 100, 0)
				arg_614_1.bgs_[var_617_36] = var_617_37
			end

			local var_617_38 = arg_614_1.bgs_.R3401a.transform
			local var_617_39 = 1.98333333333333

			if var_617_39 < arg_614_1.time_ and arg_614_1.time_ <= var_617_39 + arg_617_0 then
				arg_614_1.var_.moveOldPosR3401a = var_617_38.localPosition
			end

			local var_617_40 = 0.001

			if var_617_39 <= arg_614_1.time_ and arg_614_1.time_ < var_617_39 + var_617_40 then
				local var_617_41 = (arg_614_1.time_ - var_617_39) / var_617_40
				local var_617_42 = Vector3.New(0, 1, 8)

				var_617_38.localPosition = Vector3.Lerp(arg_614_1.var_.moveOldPosR3401a, var_617_42, var_617_41)
			end

			if arg_614_1.time_ >= var_617_39 + var_617_40 and arg_614_1.time_ < var_617_39 + var_617_40 + arg_617_0 then
				var_617_38.localPosition = Vector3.New(0, 1, 8)
			end

			local var_617_43 = arg_614_1.bgs_.R3401a.transform
			local var_617_44 = 2

			if var_617_44 < arg_614_1.time_ and arg_614_1.time_ <= var_617_44 + arg_617_0 then
				arg_614_1.var_.moveOldPosR3401a = var_617_43.localPosition
			end

			local var_617_45 = 2

			if var_617_44 <= arg_614_1.time_ and arg_614_1.time_ < var_617_44 + var_617_45 then
				local var_617_46 = (arg_614_1.time_ - var_617_44) / var_617_45
				local var_617_47 = Vector3.New(0, 1, 9.5)

				var_617_43.localPosition = Vector3.Lerp(arg_614_1.var_.moveOldPosR3401a, var_617_47, var_617_46)
			end

			if arg_614_1.time_ >= var_617_44 + var_617_45 and arg_614_1.time_ < var_617_44 + var_617_45 + arg_617_0 then
				var_617_43.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_617_48 = 2

			if var_617_48 < arg_614_1.time_ and arg_614_1.time_ <= var_617_48 + arg_617_0 then
				arg_614_1.allBtn_.enabled = false
			end

			local var_617_49 = 1.98333333333333

			if arg_614_1.time_ >= var_617_48 + var_617_49 and arg_614_1.time_ < var_617_48 + var_617_49 + arg_617_0 then
				arg_614_1.allBtn_.enabled = true
			end

			if arg_614_1.frameCnt_ <= 1 then
				arg_614_1.dialog_:SetActive(false)
			end

			local var_617_50 = 3.98333333333333
			local var_617_51 = 1.8

			if var_617_50 < arg_614_1.time_ and arg_614_1.time_ <= var_617_50 + arg_617_0 then
				arg_614_1.talkMaxDuration = 0

				arg_614_1.dialog_:SetActive(true)

				arg_614_1.dialogCg_.alpha = 0

				local var_617_52 = LeanTween.value(arg_614_1.dialog_, 0, 1, 0.3)

				var_617_52:setOnUpdate(LuaHelper.FloatAction(function(arg_618_0)
					arg_614_1.dialogCg_.alpha = arg_618_0
				end))
				var_617_52:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_614_1.dialog_)
					var_617_52:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_614_1.duration_ = arg_614_1.duration_ + 0.3

				SetActive(arg_614_1.leftNameGo_, false)

				arg_614_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_614_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_614_1:RecordName(arg_614_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_614_1.iconTrs_.gameObject, false)
				arg_614_1.callingController_:SetSelectedState("normal")

				local var_617_53 = arg_614_1:GetWordFromCfg(1103404152)
				local var_617_54 = arg_614_1:FormatText(var_617_53.content)

				arg_614_1.text_.text = var_617_54

				LuaForUtil.ClearLinePrefixSymbol(arg_614_1.text_)

				local var_617_55 = 72
				local var_617_56 = utf8.len(var_617_54)
				local var_617_57 = var_617_55 <= 0 and var_617_51 or var_617_51 * (var_617_56 / var_617_55)

				if var_617_57 > 0 and var_617_51 < var_617_57 then
					arg_614_1.talkMaxDuration = var_617_57
					var_617_50 = var_617_50 + 0.3

					if var_617_57 + var_617_50 > arg_614_1.duration_ then
						arg_614_1.duration_ = var_617_57 + var_617_50
					end
				end

				arg_614_1.text_.text = var_617_54
				arg_614_1.typewritter.percent = 0

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(false)
				arg_614_1:RecordContent(arg_614_1.text_.text)
			end

			local var_617_58 = var_617_50 + 0.3
			local var_617_59 = math.max(var_617_51, arg_614_1.talkMaxDuration)

			if var_617_58 <= arg_614_1.time_ and arg_614_1.time_ < var_617_58 + var_617_59 then
				arg_614_1.typewritter.percent = (arg_614_1.time_ - var_617_58) / var_617_59

				arg_614_1.typewritter:SetDirty()
			end

			if arg_614_1.time_ >= var_617_58 + var_617_59 and arg_614_1.time_ < var_617_58 + var_617_59 + arg_617_0 then
				arg_614_1.typewritter.percent = 1

				arg_614_1.typewritter:SetDirty()
				arg_614_1:ShowNextGo(true)
			end
		end

		arg_614_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666666,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "R3401a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "R3401a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 2,
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_614_1:InitPlayNodeList()
	end,
	Play1103404153 = function(arg_620_0, arg_620_1)
		arg_620_1.time_ = 0
		arg_620_1.frameCnt_ = 0
		arg_620_1.state_ = "playing"
		arg_620_1.curTalkId_ = 1103404153
		arg_620_1.duration_ = 5

		SetActive(arg_620_1.tipsGo_, false)

		function arg_620_1.onSingleLineFinish_()
			arg_620_1.onSingleLineUpdate_ = nil
			arg_620_1.onSingleLineFinish_ = nil
			arg_620_1.state_ = "waiting"
		end

		function arg_620_1.playNext_(arg_622_0)
			if arg_622_0 == 1 then
				arg_620_0:Play1103404154(arg_620_1)
			end
		end

		function arg_620_1.onSingleLineUpdate_(arg_623_0)
			local var_623_0 = 0
			local var_623_1 = 1.55

			if var_623_0 < arg_620_1.time_ and arg_620_1.time_ <= var_623_0 + arg_623_0 then
				arg_620_1.talkMaxDuration = 0
				arg_620_1.dialogCg_.alpha = 1

				arg_620_1.dialog_:SetActive(true)
				SetActive(arg_620_1.leftNameGo_, false)

				arg_620_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_620_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_620_1:RecordName(arg_620_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_620_1.iconTrs_.gameObject, false)
				arg_620_1.callingController_:SetSelectedState("normal")

				local var_623_2 = arg_620_1:GetWordFromCfg(1103404153)
				local var_623_3 = arg_620_1:FormatText(var_623_2.content)

				arg_620_1.text_.text = var_623_3

				LuaForUtil.ClearLinePrefixSymbol(arg_620_1.text_)

				local var_623_4 = 62
				local var_623_5 = utf8.len(var_623_3)
				local var_623_6 = var_623_4 <= 0 and var_623_1 or var_623_1 * (var_623_5 / var_623_4)

				if var_623_6 > 0 and var_623_1 < var_623_6 then
					arg_620_1.talkMaxDuration = var_623_6

					if var_623_6 + var_623_0 > arg_620_1.duration_ then
						arg_620_1.duration_ = var_623_6 + var_623_0
					end
				end

				arg_620_1.text_.text = var_623_3
				arg_620_1.typewritter.percent = 0

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(false)
				arg_620_1:RecordContent(arg_620_1.text_.text)
			end

			local var_623_7 = math.max(var_623_1, arg_620_1.talkMaxDuration)

			if var_623_0 <= arg_620_1.time_ and arg_620_1.time_ < var_623_0 + var_623_7 then
				arg_620_1.typewritter.percent = (arg_620_1.time_ - var_623_0) / var_623_7

				arg_620_1.typewritter:SetDirty()
			end

			if arg_620_1.time_ >= var_623_0 + var_623_7 and arg_620_1.time_ < var_623_0 + var_623_7 + arg_623_0 then
				arg_620_1.typewritter.percent = 1

				arg_620_1.typewritter:SetDirty()
				arg_620_1:ShowNextGo(true)
			end
		end

		arg_620_1.nodeConfigList_ = {}

		arg_620_1:InitPlayNodeList()
	end,
	Play1103404154 = function(arg_624_0, arg_624_1)
		arg_624_1.time_ = 0
		arg_624_1.frameCnt_ = 0
		arg_624_1.state_ = "playing"
		arg_624_1.curTalkId_ = 1103404154
		arg_624_1.duration_ = 3.87

		SetActive(arg_624_1.tipsGo_, false)

		function arg_624_1.onSingleLineFinish_()
			arg_624_1.onSingleLineUpdate_ = nil
			arg_624_1.onSingleLineFinish_ = nil
			arg_624_1.state_ = "waiting"
		end

		function arg_624_1.playNext_(arg_626_0)
			if arg_626_0 == 1 then
				arg_624_0:Play1103404155(arg_624_1)
			end
		end

		function arg_624_1.onSingleLineUpdate_(arg_627_0)
			local var_627_0 = 0
			local var_627_1 = 0.6

			if var_627_0 < arg_624_1.time_ and arg_624_1.time_ <= var_627_0 + arg_627_0 then
				arg_624_1.talkMaxDuration = 0
				arg_624_1.dialogCg_.alpha = 1

				arg_624_1.dialog_:SetActive(true)
				SetActive(arg_624_1.leftNameGo_, true)

				local var_627_2 = arg_624_1:FormatText(StoryNameCfg[1109].name)

				arg_624_1.leftNameTxt_.text = var_627_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_624_1.leftNameTxt_.transform)

				arg_624_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_624_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_624_1:RecordName(arg_624_1.leftNameTxt_.text)
				SetActive(arg_624_1.iconTrs_.gameObject, false)
				arg_624_1.callingController_:SetSelectedState("normal")

				local var_627_3 = arg_624_1:GetWordFromCfg(1103404154)
				local var_627_4 = arg_624_1:FormatText(var_627_3.content)

				arg_624_1.text_.text = var_627_4

				LuaForUtil.ClearLinePrefixSymbol(arg_624_1.text_)

				local var_627_5 = 24
				local var_627_6 = utf8.len(var_627_4)
				local var_627_7 = var_627_5 <= 0 and var_627_1 or var_627_1 * (var_627_6 / var_627_5)

				if var_627_7 > 0 and var_627_1 < var_627_7 then
					arg_624_1.talkMaxDuration = var_627_7

					if var_627_7 + var_627_0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_7 + var_627_0
					end
				end

				arg_624_1.text_.text = var_627_4
				arg_624_1.typewritter.percent = 0

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404154", "story_v_side_new_1103404.awb") ~= 0 then
					local var_627_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404154", "story_v_side_new_1103404.awb") / 1000

					if var_627_8 + var_627_0 > arg_624_1.duration_ then
						arg_624_1.duration_ = var_627_8 + var_627_0
					end

					if var_627_3.prefab_name ~= "" and arg_624_1.actors_[var_627_3.prefab_name] ~= nil then
						local var_627_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_624_1.actors_[var_627_3.prefab_name].transform, "story_v_side_new_1103404", "1103404154", "story_v_side_new_1103404.awb")

						arg_624_1:RecordAudio("1103404154", var_627_9)
						arg_624_1:RecordAudio("1103404154", var_627_9)
					else
						arg_624_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404154", "story_v_side_new_1103404.awb")
					end

					arg_624_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404154", "story_v_side_new_1103404.awb")
				end

				arg_624_1:RecordContent(arg_624_1.text_.text)
			end

			local var_627_10 = math.max(var_627_1, arg_624_1.talkMaxDuration)

			if var_627_0 <= arg_624_1.time_ and arg_624_1.time_ < var_627_0 + var_627_10 then
				arg_624_1.typewritter.percent = (arg_624_1.time_ - var_627_0) / var_627_10

				arg_624_1.typewritter:SetDirty()
			end

			if arg_624_1.time_ >= var_627_0 + var_627_10 and arg_624_1.time_ < var_627_0 + var_627_10 + arg_627_0 then
				arg_624_1.typewritter.percent = 1

				arg_624_1.typewritter:SetDirty()
				arg_624_1:ShowNextGo(true)
			end
		end

		arg_624_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R3401a",
				frequency = 10,
				className = "StoryShakeNode",
				duration = 0.166666666666667,
				startTime = 0.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.BACKGROUND,
				offset = Vector3.New(0.05, 0.05, 0.05)
			}
		}

		arg_624_1:InitPlayNodeList()
	end,
	Play1103404155 = function(arg_628_0, arg_628_1)
		arg_628_1.time_ = 0
		arg_628_1.frameCnt_ = 0
		arg_628_1.state_ = "playing"
		arg_628_1.curTalkId_ = 1103404155
		arg_628_1.duration_ = 5

		SetActive(arg_628_1.tipsGo_, false)

		function arg_628_1.onSingleLineFinish_()
			arg_628_1.onSingleLineUpdate_ = nil
			arg_628_1.onSingleLineFinish_ = nil
			arg_628_1.state_ = "waiting"
		end

		function arg_628_1.playNext_(arg_630_0)
			if arg_630_0 == 1 then
				arg_628_0:Play1103404156(arg_628_1)
			end
		end

		function arg_628_1.onSingleLineUpdate_(arg_631_0)
			local var_631_0 = arg_628_1.actors_["1034ui_story"]
			local var_631_1 = 0

			if var_631_1 < arg_628_1.time_ and arg_628_1.time_ <= var_631_1 + arg_631_0 and not isNil(var_631_0) and arg_628_1.var_.characterEffect1034ui_story == nil then
				arg_628_1.var_.characterEffect1034ui_story = var_631_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_631_2 = 0.200000002980232

			if var_631_1 <= arg_628_1.time_ and arg_628_1.time_ < var_631_1 + var_631_2 and not isNil(var_631_0) then
				local var_631_3 = (arg_628_1.time_ - var_631_1) / var_631_2

				if arg_628_1.var_.characterEffect1034ui_story and not isNil(var_631_0) then
					local var_631_4 = Mathf.Lerp(0, 0.5, var_631_3)

					arg_628_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_628_1.var_.characterEffect1034ui_story.fillRatio = var_631_4
				end
			end

			if arg_628_1.time_ >= var_631_1 + var_631_2 and arg_628_1.time_ < var_631_1 + var_631_2 + arg_631_0 and not isNil(var_631_0) and arg_628_1.var_.characterEffect1034ui_story then
				local var_631_5 = 0.5

				arg_628_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_628_1.var_.characterEffect1034ui_story.fillRatio = var_631_5
			end

			local var_631_6 = 0
			local var_631_7 = 0.35

			if var_631_6 < arg_628_1.time_ and arg_628_1.time_ <= var_631_6 + arg_631_0 then
				arg_628_1.talkMaxDuration = 0
				arg_628_1.dialogCg_.alpha = 1

				arg_628_1.dialog_:SetActive(true)
				SetActive(arg_628_1.leftNameGo_, true)

				local var_631_8 = arg_628_1:FormatText(StoryNameCfg[7].name)

				arg_628_1.leftNameTxt_.text = var_631_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_628_1.leftNameTxt_.transform)

				arg_628_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_628_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_628_1:RecordName(arg_628_1.leftNameTxt_.text)
				SetActive(arg_628_1.iconTrs_.gameObject, true)
				arg_628_1.iconController_:SetSelectedState("hero")

				arg_628_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_628_1.callingController_:SetSelectedState("normal")

				arg_628_1.keyicon_.color = Color.New(1, 1, 1)
				arg_628_1.icon_.color = Color.New(1, 1, 1)

				local var_631_9 = arg_628_1:GetWordFromCfg(1103404155)
				local var_631_10 = arg_628_1:FormatText(var_631_9.content)

				arg_628_1.text_.text = var_631_10

				LuaForUtil.ClearLinePrefixSymbol(arg_628_1.text_)

				local var_631_11 = 14
				local var_631_12 = utf8.len(var_631_10)
				local var_631_13 = var_631_11 <= 0 and var_631_7 or var_631_7 * (var_631_12 / var_631_11)

				if var_631_13 > 0 and var_631_7 < var_631_13 then
					arg_628_1.talkMaxDuration = var_631_13

					if var_631_13 + var_631_6 > arg_628_1.duration_ then
						arg_628_1.duration_ = var_631_13 + var_631_6
					end
				end

				arg_628_1.text_.text = var_631_10
				arg_628_1.typewritter.percent = 0

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(false)
				arg_628_1:RecordContent(arg_628_1.text_.text)
			end

			local var_631_14 = math.max(var_631_7, arg_628_1.talkMaxDuration)

			if var_631_6 <= arg_628_1.time_ and arg_628_1.time_ < var_631_6 + var_631_14 then
				arg_628_1.typewritter.percent = (arg_628_1.time_ - var_631_6) / var_631_14

				arg_628_1.typewritter:SetDirty()
			end

			if arg_628_1.time_ >= var_631_6 + var_631_14 and arg_628_1.time_ < var_631_6 + var_631_14 + arg_631_0 then
				arg_628_1.typewritter.percent = 1

				arg_628_1.typewritter:SetDirty()
				arg_628_1:ShowNextGo(true)
			end
		end

		arg_628_1.nodeConfigList_ = {}

		arg_628_1:InitPlayNodeList()
	end,
	Play1103404156 = function(arg_632_0, arg_632_1)
		arg_632_1.time_ = 0
		arg_632_1.frameCnt_ = 0
		arg_632_1.state_ = "playing"
		arg_632_1.curTalkId_ = 1103404156
		arg_632_1.duration_ = 5

		SetActive(arg_632_1.tipsGo_, false)

		function arg_632_1.onSingleLineFinish_()
			arg_632_1.onSingleLineUpdate_ = nil
			arg_632_1.onSingleLineFinish_ = nil
			arg_632_1.state_ = "waiting"
		end

		function arg_632_1.playNext_(arg_634_0)
			if arg_634_0 == 1 then
				arg_632_0:Play1103404157(arg_632_1)
			end
		end

		function arg_632_1.onSingleLineUpdate_(arg_635_0)
			local var_635_0 = 0

			if var_635_0 < arg_632_1.time_ and arg_632_1.time_ <= var_635_0 + arg_635_0 then
				arg_632_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action9_2")
			end

			local var_635_1 = 0
			local var_635_2 = 0.45

			if var_635_1 < arg_632_1.time_ and arg_632_1.time_ <= var_635_1 + arg_635_0 then
				arg_632_1.talkMaxDuration = 0
				arg_632_1.dialogCg_.alpha = 1

				arg_632_1.dialog_:SetActive(true)
				SetActive(arg_632_1.leftNameGo_, true)

				local var_635_3 = arg_632_1:FormatText(StoryNameCfg[7].name)

				arg_632_1.leftNameTxt_.text = var_635_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_632_1.leftNameTxt_.transform)

				arg_632_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_632_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_632_1:RecordName(arg_632_1.leftNameTxt_.text)
				SetActive(arg_632_1.iconTrs_.gameObject, true)
				arg_632_1.iconController_:SetSelectedState("hero")

				arg_632_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_632_1.callingController_:SetSelectedState("normal")

				arg_632_1.keyicon_.color = Color.New(1, 1, 1)
				arg_632_1.icon_.color = Color.New(1, 1, 1)

				local var_635_4 = arg_632_1:GetWordFromCfg(1103404156)
				local var_635_5 = arg_632_1:FormatText(var_635_4.content)

				arg_632_1.text_.text = var_635_5

				LuaForUtil.ClearLinePrefixSymbol(arg_632_1.text_)

				local var_635_6 = 18
				local var_635_7 = utf8.len(var_635_5)
				local var_635_8 = var_635_6 <= 0 and var_635_2 or var_635_2 * (var_635_7 / var_635_6)

				if var_635_8 > 0 and var_635_2 < var_635_8 then
					arg_632_1.talkMaxDuration = var_635_8

					if var_635_8 + var_635_1 > arg_632_1.duration_ then
						arg_632_1.duration_ = var_635_8 + var_635_1
					end
				end

				arg_632_1.text_.text = var_635_5
				arg_632_1.typewritter.percent = 0

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(false)
				arg_632_1:RecordContent(arg_632_1.text_.text)
			end

			local var_635_9 = math.max(var_635_2, arg_632_1.talkMaxDuration)

			if var_635_1 <= arg_632_1.time_ and arg_632_1.time_ < var_635_1 + var_635_9 then
				arg_632_1.typewritter.percent = (arg_632_1.time_ - var_635_1) / var_635_9

				arg_632_1.typewritter:SetDirty()
			end

			if arg_632_1.time_ >= var_635_1 + var_635_9 and arg_632_1.time_ < var_635_1 + var_635_9 + arg_635_0 then
				arg_632_1.typewritter.percent = 1

				arg_632_1.typewritter:SetDirty()
				arg_632_1:ShowNextGo(true)
			end
		end

		arg_632_1.nodeConfigList_ = {}

		arg_632_1:InitPlayNodeList()
	end,
	Play1103404157 = function(arg_636_0, arg_636_1)
		arg_636_1.time_ = 0
		arg_636_1.frameCnt_ = 0
		arg_636_1.state_ = "playing"
		arg_636_1.curTalkId_ = 1103404157
		arg_636_1.duration_ = 2.27

		SetActive(arg_636_1.tipsGo_, false)

		function arg_636_1.onSingleLineFinish_()
			arg_636_1.onSingleLineUpdate_ = nil
			arg_636_1.onSingleLineFinish_ = nil
			arg_636_1.state_ = "waiting"
		end

		function arg_636_1.playNext_(arg_638_0)
			if arg_638_0 == 1 then
				arg_636_0:Play1103404158(arg_636_1)
			end
		end

		function arg_636_1.onSingleLineUpdate_(arg_639_0)
			local var_639_0 = 0
			local var_639_1 = 0.25

			if var_639_0 < arg_636_1.time_ and arg_636_1.time_ <= var_639_0 + arg_639_0 then
				arg_636_1.talkMaxDuration = 0
				arg_636_1.dialogCg_.alpha = 1

				arg_636_1.dialog_:SetActive(true)
				SetActive(arg_636_1.leftNameGo_, true)

				local var_639_2 = arg_636_1:FormatText(StoryNameCfg[1109].name)

				arg_636_1.leftNameTxt_.text = var_639_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_636_1.leftNameTxt_.transform)

				arg_636_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_636_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_636_1:RecordName(arg_636_1.leftNameTxt_.text)
				SetActive(arg_636_1.iconTrs_.gameObject, false)
				arg_636_1.callingController_:SetSelectedState("normal")

				local var_639_3 = arg_636_1:GetWordFromCfg(1103404157)
				local var_639_4 = arg_636_1:FormatText(var_639_3.content)

				arg_636_1.text_.text = var_639_4

				LuaForUtil.ClearLinePrefixSymbol(arg_636_1.text_)

				local var_639_5 = 10
				local var_639_6 = utf8.len(var_639_4)
				local var_639_7 = var_639_5 <= 0 and var_639_1 or var_639_1 * (var_639_6 / var_639_5)

				if var_639_7 > 0 and var_639_1 < var_639_7 then
					arg_636_1.talkMaxDuration = var_639_7

					if var_639_7 + var_639_0 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_7 + var_639_0
					end
				end

				arg_636_1.text_.text = var_639_4
				arg_636_1.typewritter.percent = 0

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404157", "story_v_side_new_1103404.awb") ~= 0 then
					local var_639_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404157", "story_v_side_new_1103404.awb") / 1000

					if var_639_8 + var_639_0 > arg_636_1.duration_ then
						arg_636_1.duration_ = var_639_8 + var_639_0
					end

					if var_639_3.prefab_name ~= "" and arg_636_1.actors_[var_639_3.prefab_name] ~= nil then
						local var_639_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_636_1.actors_[var_639_3.prefab_name].transform, "story_v_side_new_1103404", "1103404157", "story_v_side_new_1103404.awb")

						arg_636_1:RecordAudio("1103404157", var_639_9)
						arg_636_1:RecordAudio("1103404157", var_639_9)
					else
						arg_636_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404157", "story_v_side_new_1103404.awb")
					end

					arg_636_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404157", "story_v_side_new_1103404.awb")
				end

				arg_636_1:RecordContent(arg_636_1.text_.text)
			end

			local var_639_10 = math.max(var_639_1, arg_636_1.talkMaxDuration)

			if var_639_0 <= arg_636_1.time_ and arg_636_1.time_ < var_639_0 + var_639_10 then
				arg_636_1.typewritter.percent = (arg_636_1.time_ - var_639_0) / var_639_10

				arg_636_1.typewritter:SetDirty()
			end

			if arg_636_1.time_ >= var_639_0 + var_639_10 and arg_636_1.time_ < var_639_0 + var_639_10 + arg_639_0 then
				arg_636_1.typewritter.percent = 1

				arg_636_1.typewritter:SetDirty()
				arg_636_1:ShowNextGo(true)
			end
		end

		arg_636_1.nodeConfigList_ = {}

		arg_636_1:InitPlayNodeList()
	end,
	Play1103404158 = function(arg_640_0, arg_640_1)
		arg_640_1.time_ = 0
		arg_640_1.frameCnt_ = 0
		arg_640_1.state_ = "playing"
		arg_640_1.curTalkId_ = 1103404158
		arg_640_1.duration_ = 5

		SetActive(arg_640_1.tipsGo_, false)

		function arg_640_1.onSingleLineFinish_()
			arg_640_1.onSingleLineUpdate_ = nil
			arg_640_1.onSingleLineFinish_ = nil
			arg_640_1.state_ = "waiting"
		end

		function arg_640_1.playNext_(arg_642_0)
			if arg_642_0 == 1 then
				arg_640_0:Play1103404159(arg_640_1)
			end
		end

		function arg_640_1.onSingleLineUpdate_(arg_643_0)
			local var_643_0 = arg_640_1.actors_["1034ui_story"]
			local var_643_1 = 0

			if var_643_1 < arg_640_1.time_ and arg_640_1.time_ <= var_643_1 + arg_643_0 and not isNil(var_643_0) and arg_640_1.var_.characterEffect1034ui_story == nil then
				arg_640_1.var_.characterEffect1034ui_story = var_643_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_643_2 = 0.200000002980232

			if var_643_1 <= arg_640_1.time_ and arg_640_1.time_ < var_643_1 + var_643_2 and not isNil(var_643_0) then
				local var_643_3 = (arg_640_1.time_ - var_643_1) / var_643_2

				if arg_640_1.var_.characterEffect1034ui_story and not isNil(var_643_0) then
					local var_643_4 = Mathf.Lerp(0, 0.5, var_643_3)

					arg_640_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_640_1.var_.characterEffect1034ui_story.fillRatio = var_643_4
				end
			end

			if arg_640_1.time_ >= var_643_1 + var_643_2 and arg_640_1.time_ < var_643_1 + var_643_2 + arg_643_0 and not isNil(var_643_0) and arg_640_1.var_.characterEffect1034ui_story then
				local var_643_5 = 0.5

				arg_640_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_640_1.var_.characterEffect1034ui_story.fillRatio = var_643_5
			end

			local var_643_6 = 0

			if var_643_6 < arg_640_1.time_ and arg_640_1.time_ <= var_643_6 + arg_643_0 then
				arg_640_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			local var_643_7 = 0

			if var_643_7 < arg_640_1.time_ and arg_640_1.time_ <= var_643_7 + arg_643_0 then
				arg_640_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_643_8 = arg_640_1.bgs_.R3401a.transform
			local var_643_9 = 0

			if var_643_9 < arg_640_1.time_ and arg_640_1.time_ <= var_643_9 + arg_643_0 then
				arg_640_1.var_.moveOldPosR3401a = var_643_8.localPosition
			end

			local var_643_10 = 1.98333333333333

			if var_643_9 <= arg_640_1.time_ and arg_640_1.time_ < var_643_9 + var_643_10 then
				local var_643_11 = (arg_640_1.time_ - var_643_9) / var_643_10
				local var_643_12 = Vector3.New(0, 1, 9)

				var_643_8.localPosition = Vector3.Lerp(arg_640_1.var_.moveOldPosR3401a, var_643_12, var_643_11)
			end

			if arg_640_1.time_ >= var_643_9 + var_643_10 and arg_640_1.time_ < var_643_9 + var_643_10 + arg_643_0 then
				var_643_8.localPosition = Vector3.New(0, 1, 9)
			end

			local var_643_13 = 0

			if var_643_13 < arg_640_1.time_ and arg_640_1.time_ <= var_643_13 + arg_643_0 then
				arg_640_1.allBtn_.enabled = false
			end

			local var_643_14 = 1.98333333333333

			if arg_640_1.time_ >= var_643_13 + var_643_14 and arg_640_1.time_ < var_643_13 + var_643_14 + arg_643_0 then
				arg_640_1.allBtn_.enabled = true
			end

			local var_643_15 = 0
			local var_643_16 = 0.625

			if var_643_15 < arg_640_1.time_ and arg_640_1.time_ <= var_643_15 + arg_643_0 then
				arg_640_1.talkMaxDuration = 0
				arg_640_1.dialogCg_.alpha = 1

				arg_640_1.dialog_:SetActive(true)
				SetActive(arg_640_1.leftNameGo_, true)

				local var_643_17 = arg_640_1:FormatText(StoryNameCfg[7].name)

				arg_640_1.leftNameTxt_.text = var_643_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_640_1.leftNameTxt_.transform)

				arg_640_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_640_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_640_1:RecordName(arg_640_1.leftNameTxt_.text)
				SetActive(arg_640_1.iconTrs_.gameObject, true)
				arg_640_1.iconController_:SetSelectedState("hero")

				arg_640_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_640_1.callingController_:SetSelectedState("normal")

				arg_640_1.keyicon_.color = Color.New(1, 1, 1)
				arg_640_1.icon_.color = Color.New(1, 1, 1)

				local var_643_18 = arg_640_1:GetWordFromCfg(1103404158)
				local var_643_19 = arg_640_1:FormatText(var_643_18.content)

				arg_640_1.text_.text = var_643_19

				LuaForUtil.ClearLinePrefixSymbol(arg_640_1.text_)

				local var_643_20 = 25
				local var_643_21 = utf8.len(var_643_19)
				local var_643_22 = var_643_20 <= 0 and var_643_16 or var_643_16 * (var_643_21 / var_643_20)

				if var_643_22 > 0 and var_643_16 < var_643_22 then
					arg_640_1.talkMaxDuration = var_643_22

					if var_643_22 + var_643_15 > arg_640_1.duration_ then
						arg_640_1.duration_ = var_643_22 + var_643_15
					end
				end

				arg_640_1.text_.text = var_643_19
				arg_640_1.typewritter.percent = 0

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(false)
				arg_640_1:RecordContent(arg_640_1.text_.text)
			end

			local var_643_23 = math.max(var_643_16, arg_640_1.talkMaxDuration)

			if var_643_15 <= arg_640_1.time_ and arg_640_1.time_ < var_643_15 + var_643_23 then
				arg_640_1.typewritter.percent = (arg_640_1.time_ - var_643_15) / var_643_23

				arg_640_1.typewritter:SetDirty()
			end

			if arg_640_1.time_ >= var_643_15 + var_643_23 and arg_640_1.time_ < var_643_15 + var_643_23 + arg_643_0 then
				arg_640_1.typewritter.percent = 1

				arg_640_1.typewritter:SetDirty()
				arg_640_1:ShowNextGo(true)
			end
		end

		arg_640_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R3401a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.98333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9.5),
					endPos = Vector3.New(0, 1, 9),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_640_1:InitPlayNodeList()
	end,
	Play1103404159 = function(arg_644_0, arg_644_1)
		arg_644_1.time_ = 0
		arg_644_1.frameCnt_ = 0
		arg_644_1.state_ = "playing"
		arg_644_1.curTalkId_ = 1103404159
		arg_644_1.duration_ = 5

		SetActive(arg_644_1.tipsGo_, false)

		function arg_644_1.onSingleLineFinish_()
			arg_644_1.onSingleLineUpdate_ = nil
			arg_644_1.onSingleLineFinish_ = nil
			arg_644_1.state_ = "waiting"
		end

		function arg_644_1.playNext_(arg_646_0)
			if arg_646_0 == 1 then
				arg_644_0:Play1103404160(arg_644_1)
			end
		end

		function arg_644_1.onSingleLineUpdate_(arg_647_0)
			local var_647_0 = 0
			local var_647_1 = 0.4

			if var_647_0 < arg_644_1.time_ and arg_644_1.time_ <= var_647_0 + arg_647_0 then
				arg_644_1.talkMaxDuration = 0
				arg_644_1.dialogCg_.alpha = 1

				arg_644_1.dialog_:SetActive(true)
				SetActive(arg_644_1.leftNameGo_, true)

				local var_647_2 = arg_644_1:FormatText(StoryNameCfg[7].name)

				arg_644_1.leftNameTxt_.text = var_647_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_644_1.leftNameTxt_.transform)

				arg_644_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_644_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_644_1:RecordName(arg_644_1.leftNameTxt_.text)
				SetActive(arg_644_1.iconTrs_.gameObject, true)
				arg_644_1.iconController_:SetSelectedState("hero")

				arg_644_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_644_1.callingController_:SetSelectedState("normal")

				arg_644_1.keyicon_.color = Color.New(1, 1, 1)
				arg_644_1.icon_.color = Color.New(1, 1, 1)

				local var_647_3 = arg_644_1:GetWordFromCfg(1103404159)
				local var_647_4 = arg_644_1:FormatText(var_647_3.content)

				arg_644_1.text_.text = var_647_4

				LuaForUtil.ClearLinePrefixSymbol(arg_644_1.text_)

				local var_647_5 = 16
				local var_647_6 = utf8.len(var_647_4)
				local var_647_7 = var_647_5 <= 0 and var_647_1 or var_647_1 * (var_647_6 / var_647_5)

				if var_647_7 > 0 and var_647_1 < var_647_7 then
					arg_644_1.talkMaxDuration = var_647_7

					if var_647_7 + var_647_0 > arg_644_1.duration_ then
						arg_644_1.duration_ = var_647_7 + var_647_0
					end
				end

				arg_644_1.text_.text = var_647_4
				arg_644_1.typewritter.percent = 0

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(false)
				arg_644_1:RecordContent(arg_644_1.text_.text)
			end

			local var_647_8 = math.max(var_647_1, arg_644_1.talkMaxDuration)

			if var_647_0 <= arg_644_1.time_ and arg_644_1.time_ < var_647_0 + var_647_8 then
				arg_644_1.typewritter.percent = (arg_644_1.time_ - var_647_0) / var_647_8

				arg_644_1.typewritter:SetDirty()
			end

			if arg_644_1.time_ >= var_647_0 + var_647_8 and arg_644_1.time_ < var_647_0 + var_647_8 + arg_647_0 then
				arg_644_1.typewritter.percent = 1

				arg_644_1.typewritter:SetDirty()
				arg_644_1:ShowNextGo(true)
			end
		end

		arg_644_1.nodeConfigList_ = {}

		arg_644_1:InitPlayNodeList()
	end,
	Play1103404160 = function(arg_648_0, arg_648_1)
		arg_648_1.time_ = 0
		arg_648_1.frameCnt_ = 0
		arg_648_1.state_ = "playing"
		arg_648_1.curTalkId_ = 1103404160
		arg_648_1.duration_ = 5.27

		SetActive(arg_648_1.tipsGo_, false)

		function arg_648_1.onSingleLineFinish_()
			arg_648_1.onSingleLineUpdate_ = nil
			arg_648_1.onSingleLineFinish_ = nil
			arg_648_1.state_ = "waiting"
		end

		function arg_648_1.playNext_(arg_650_0)
			if arg_650_0 == 1 then
				arg_648_0:Play1103404161(arg_648_1)
			end
		end

		function arg_648_1.onSingleLineUpdate_(arg_651_0)
			local var_651_0 = arg_648_1.bgs_.R3401a.transform
			local var_651_1 = 0

			if var_651_1 < arg_648_1.time_ and arg_648_1.time_ <= var_651_1 + arg_651_0 then
				arg_648_1.var_.moveOldPosR3401a = var_651_0.localPosition
			end

			local var_651_2 = 0.333333333333333

			if var_651_1 <= arg_648_1.time_ and arg_648_1.time_ < var_651_1 + var_651_2 then
				local var_651_3 = (arg_648_1.time_ - var_651_1) / var_651_2
				local var_651_4 = Vector3.New(0, 1, 10)

				var_651_0.localPosition = Vector3.Lerp(arg_648_1.var_.moveOldPosR3401a, var_651_4, var_651_3)
			end

			if arg_648_1.time_ >= var_651_1 + var_651_2 and arg_648_1.time_ < var_651_1 + var_651_2 + arg_651_0 then
				var_651_0.localPosition = Vector3.New(0, 1, 10)
			end

			local var_651_5 = 0
			local var_651_6 = 0.5

			if var_651_5 < arg_648_1.time_ and arg_648_1.time_ <= var_651_5 + arg_651_0 then
				arg_648_1.talkMaxDuration = 0
				arg_648_1.dialogCg_.alpha = 1

				arg_648_1.dialog_:SetActive(true)
				SetActive(arg_648_1.leftNameGo_, true)

				local var_651_7 = arg_648_1:FormatText(StoryNameCfg[1109].name)

				arg_648_1.leftNameTxt_.text = var_651_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_648_1.leftNameTxt_.transform)

				arg_648_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_648_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_648_1:RecordName(arg_648_1.leftNameTxt_.text)
				SetActive(arg_648_1.iconTrs_.gameObject, false)
				arg_648_1.callingController_:SetSelectedState("normal")

				local var_651_8 = arg_648_1:GetWordFromCfg(1103404160)
				local var_651_9 = arg_648_1:FormatText(var_651_8.content)

				arg_648_1.text_.text = var_651_9

				LuaForUtil.ClearLinePrefixSymbol(arg_648_1.text_)

				local var_651_10 = 20
				local var_651_11 = utf8.len(var_651_9)
				local var_651_12 = var_651_10 <= 0 and var_651_6 or var_651_6 * (var_651_11 / var_651_10)

				if var_651_12 > 0 and var_651_6 < var_651_12 then
					arg_648_1.talkMaxDuration = var_651_12

					if var_651_12 + var_651_5 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_12 + var_651_5
					end
				end

				arg_648_1.text_.text = var_651_9
				arg_648_1.typewritter.percent = 0

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404160", "story_v_side_new_1103404.awb") ~= 0 then
					local var_651_13 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404160", "story_v_side_new_1103404.awb") / 1000

					if var_651_13 + var_651_5 > arg_648_1.duration_ then
						arg_648_1.duration_ = var_651_13 + var_651_5
					end

					if var_651_8.prefab_name ~= "" and arg_648_1.actors_[var_651_8.prefab_name] ~= nil then
						local var_651_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_648_1.actors_[var_651_8.prefab_name].transform, "story_v_side_new_1103404", "1103404160", "story_v_side_new_1103404.awb")

						arg_648_1:RecordAudio("1103404160", var_651_14)
						arg_648_1:RecordAudio("1103404160", var_651_14)
					else
						arg_648_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404160", "story_v_side_new_1103404.awb")
					end

					arg_648_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404160", "story_v_side_new_1103404.awb")
				end

				arg_648_1:RecordContent(arg_648_1.text_.text)
			end

			local var_651_15 = math.max(var_651_6, arg_648_1.talkMaxDuration)

			if var_651_5 <= arg_648_1.time_ and arg_648_1.time_ < var_651_5 + var_651_15 then
				arg_648_1.typewritter.percent = (arg_648_1.time_ - var_651_5) / var_651_15

				arg_648_1.typewritter:SetDirty()
			end

			if arg_648_1.time_ >= var_651_5 + var_651_15 and arg_648_1.time_ < var_651_5 + var_651_15 + arg_651_0 then
				arg_648_1.typewritter.percent = 1

				arg_648_1.typewritter:SetDirty()
				arg_648_1:ShowNextGo(true)
			end
		end

		arg_648_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "R3401a",
				frequency = 50,
				className = "StoryShakeNode",
				duration = 0.1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.BACKGROUND,
				offset = Vector3.New(0.1, 0.1, 0.1)
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "R3401a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.333333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_648_1:InitPlayNodeList()
	end,
	Play1103404161 = function(arg_652_0, arg_652_1)
		arg_652_1.time_ = 0
		arg_652_1.frameCnt_ = 0
		arg_652_1.state_ = "playing"
		arg_652_1.curTalkId_ = 1103404161
		arg_652_1.duration_ = 5

		SetActive(arg_652_1.tipsGo_, false)

		function arg_652_1.onSingleLineFinish_()
			arg_652_1.onSingleLineUpdate_ = nil
			arg_652_1.onSingleLineFinish_ = nil
			arg_652_1.state_ = "waiting"
		end

		function arg_652_1.playNext_(arg_654_0)
			if arg_654_0 == 1 then
				arg_652_0:Play1103404162(arg_652_1)
			end
		end

		function arg_652_1.onSingleLineUpdate_(arg_655_0)
			local var_655_0 = arg_652_1.actors_["1034ui_story"]
			local var_655_1 = 0

			if var_655_1 < arg_652_1.time_ and arg_652_1.time_ <= var_655_1 + arg_655_0 and not isNil(var_655_0) and arg_652_1.var_.characterEffect1034ui_story == nil then
				arg_652_1.var_.characterEffect1034ui_story = var_655_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_655_2 = 0.200000002980232

			if var_655_1 <= arg_652_1.time_ and arg_652_1.time_ < var_655_1 + var_655_2 and not isNil(var_655_0) then
				local var_655_3 = (arg_652_1.time_ - var_655_1) / var_655_2

				if arg_652_1.var_.characterEffect1034ui_story and not isNil(var_655_0) then
					local var_655_4 = Mathf.Lerp(0, 0.5, var_655_3)

					arg_652_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_652_1.var_.characterEffect1034ui_story.fillRatio = var_655_4
				end
			end

			if arg_652_1.time_ >= var_655_1 + var_655_2 and arg_652_1.time_ < var_655_1 + var_655_2 + arg_655_0 and not isNil(var_655_0) and arg_652_1.var_.characterEffect1034ui_story then
				local var_655_5 = 0.5

				arg_652_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_652_1.var_.characterEffect1034ui_story.fillRatio = var_655_5
			end

			local var_655_6 = 0
			local var_655_7 = 1.3

			if var_655_6 < arg_652_1.time_ and arg_652_1.time_ <= var_655_6 + arg_655_0 then
				arg_652_1.talkMaxDuration = 0
				arg_652_1.dialogCg_.alpha = 1

				arg_652_1.dialog_:SetActive(true)
				SetActive(arg_652_1.leftNameGo_, false)

				arg_652_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_652_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_652_1:RecordName(arg_652_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_652_1.iconTrs_.gameObject, false)
				arg_652_1.callingController_:SetSelectedState("normal")

				local var_655_8 = arg_652_1:GetWordFromCfg(1103404161)
				local var_655_9 = arg_652_1:FormatText(var_655_8.content)

				arg_652_1.text_.text = var_655_9

				LuaForUtil.ClearLinePrefixSymbol(arg_652_1.text_)

				local var_655_10 = 52
				local var_655_11 = utf8.len(var_655_9)
				local var_655_12 = var_655_10 <= 0 and var_655_7 or var_655_7 * (var_655_11 / var_655_10)

				if var_655_12 > 0 and var_655_7 < var_655_12 then
					arg_652_1.talkMaxDuration = var_655_12

					if var_655_12 + var_655_6 > arg_652_1.duration_ then
						arg_652_1.duration_ = var_655_12 + var_655_6
					end
				end

				arg_652_1.text_.text = var_655_9
				arg_652_1.typewritter.percent = 0

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(false)
				arg_652_1:RecordContent(arg_652_1.text_.text)
			end

			local var_655_13 = math.max(var_655_7, arg_652_1.talkMaxDuration)

			if var_655_6 <= arg_652_1.time_ and arg_652_1.time_ < var_655_6 + var_655_13 then
				arg_652_1.typewritter.percent = (arg_652_1.time_ - var_655_6) / var_655_13

				arg_652_1.typewritter:SetDirty()
			end

			if arg_652_1.time_ >= var_655_6 + var_655_13 and arg_652_1.time_ < var_655_6 + var_655_13 + arg_655_0 then
				arg_652_1.typewritter.percent = 1

				arg_652_1.typewritter:SetDirty()
				arg_652_1:ShowNextGo(true)
			end
		end

		arg_652_1.nodeConfigList_ = {}

		arg_652_1:InitPlayNodeList()
	end,
	Play1103404162 = function(arg_656_0, arg_656_1)
		arg_656_1.time_ = 0
		arg_656_1.frameCnt_ = 0
		arg_656_1.state_ = "playing"
		arg_656_1.curTalkId_ = 1103404162
		arg_656_1.duration_ = 5.07

		SetActive(arg_656_1.tipsGo_, false)

		function arg_656_1.onSingleLineFinish_()
			arg_656_1.onSingleLineUpdate_ = nil
			arg_656_1.onSingleLineFinish_ = nil
			arg_656_1.state_ = "waiting"
		end

		function arg_656_1.playNext_(arg_658_0)
			if arg_658_0 == 1 then
				arg_656_0:Play1103404163(arg_656_1)
			end
		end

		function arg_656_1.onSingleLineUpdate_(arg_659_0)
			local var_659_0 = 0
			local var_659_1 = 0.45

			if var_659_0 < arg_656_1.time_ and arg_656_1.time_ <= var_659_0 + arg_659_0 then
				arg_656_1.talkMaxDuration = 0
				arg_656_1.dialogCg_.alpha = 1

				arg_656_1.dialog_:SetActive(true)
				SetActive(arg_656_1.leftNameGo_, true)

				local var_659_2 = arg_656_1:FormatText(StoryNameCfg[1109].name)

				arg_656_1.leftNameTxt_.text = var_659_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_656_1.leftNameTxt_.transform)

				arg_656_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_656_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_656_1:RecordName(arg_656_1.leftNameTxt_.text)
				SetActive(arg_656_1.iconTrs_.gameObject, false)
				arg_656_1.callingController_:SetSelectedState("normal")

				local var_659_3 = arg_656_1:GetWordFromCfg(1103404162)
				local var_659_4 = arg_656_1:FormatText(var_659_3.content)

				arg_656_1.text_.text = var_659_4

				LuaForUtil.ClearLinePrefixSymbol(arg_656_1.text_)

				local var_659_5 = 18
				local var_659_6 = utf8.len(var_659_4)
				local var_659_7 = var_659_5 <= 0 and var_659_1 or var_659_1 * (var_659_6 / var_659_5)

				if var_659_7 > 0 and var_659_1 < var_659_7 then
					arg_656_1.talkMaxDuration = var_659_7

					if var_659_7 + var_659_0 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_7 + var_659_0
					end
				end

				arg_656_1.text_.text = var_659_4
				arg_656_1.typewritter.percent = 0

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404162", "story_v_side_new_1103404.awb") ~= 0 then
					local var_659_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404162", "story_v_side_new_1103404.awb") / 1000

					if var_659_8 + var_659_0 > arg_656_1.duration_ then
						arg_656_1.duration_ = var_659_8 + var_659_0
					end

					if var_659_3.prefab_name ~= "" and arg_656_1.actors_[var_659_3.prefab_name] ~= nil then
						local var_659_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_656_1.actors_[var_659_3.prefab_name].transform, "story_v_side_new_1103404", "1103404162", "story_v_side_new_1103404.awb")

						arg_656_1:RecordAudio("1103404162", var_659_9)
						arg_656_1:RecordAudio("1103404162", var_659_9)
					else
						arg_656_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404162", "story_v_side_new_1103404.awb")
					end

					arg_656_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404162", "story_v_side_new_1103404.awb")
				end

				arg_656_1:RecordContent(arg_656_1.text_.text)
			end

			local var_659_10 = math.max(var_659_1, arg_656_1.talkMaxDuration)

			if var_659_0 <= arg_656_1.time_ and arg_656_1.time_ < var_659_0 + var_659_10 then
				arg_656_1.typewritter.percent = (arg_656_1.time_ - var_659_0) / var_659_10

				arg_656_1.typewritter:SetDirty()
			end

			if arg_656_1.time_ >= var_659_0 + var_659_10 and arg_656_1.time_ < var_659_0 + var_659_10 + arg_659_0 then
				arg_656_1.typewritter.percent = 1

				arg_656_1.typewritter:SetDirty()
				arg_656_1:ShowNextGo(true)
			end
		end

		arg_656_1.nodeConfigList_ = {}

		arg_656_1:InitPlayNodeList()
	end,
	Play1103404163 = function(arg_660_0, arg_660_1)
		arg_660_1.time_ = 0
		arg_660_1.frameCnt_ = 0
		arg_660_1.state_ = "playing"
		arg_660_1.curTalkId_ = 1103404163
		arg_660_1.duration_ = 5

		SetActive(arg_660_1.tipsGo_, false)

		function arg_660_1.onSingleLineFinish_()
			arg_660_1.onSingleLineUpdate_ = nil
			arg_660_1.onSingleLineFinish_ = nil
			arg_660_1.state_ = "waiting"
		end

		function arg_660_1.playNext_(arg_662_0)
			if arg_662_0 == 1 then
				arg_660_0:Play1103404164(arg_660_1)
			end
		end

		function arg_660_1.onSingleLineUpdate_(arg_663_0)
			local var_663_0 = arg_660_1.actors_["1034ui_story"]
			local var_663_1 = 0

			if var_663_1 < arg_660_1.time_ and arg_660_1.time_ <= var_663_1 + arg_663_0 and not isNil(var_663_0) and arg_660_1.var_.characterEffect1034ui_story == nil then
				arg_660_1.var_.characterEffect1034ui_story = var_663_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_663_2 = 0.200000002980232

			if var_663_1 <= arg_660_1.time_ and arg_660_1.time_ < var_663_1 + var_663_2 and not isNil(var_663_0) then
				local var_663_3 = (arg_660_1.time_ - var_663_1) / var_663_2

				if arg_660_1.var_.characterEffect1034ui_story and not isNil(var_663_0) then
					local var_663_4 = Mathf.Lerp(0, 0.5, var_663_3)

					arg_660_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_660_1.var_.characterEffect1034ui_story.fillRatio = var_663_4
				end
			end

			if arg_660_1.time_ >= var_663_1 + var_663_2 and arg_660_1.time_ < var_663_1 + var_663_2 + arg_663_0 and not isNil(var_663_0) and arg_660_1.var_.characterEffect1034ui_story then
				local var_663_5 = 0.5

				arg_660_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_660_1.var_.characterEffect1034ui_story.fillRatio = var_663_5
			end

			local var_663_6 = 0
			local var_663_7 = 0.3

			if var_663_6 < arg_660_1.time_ and arg_660_1.time_ <= var_663_6 + arg_663_0 then
				arg_660_1.talkMaxDuration = 0
				arg_660_1.dialogCg_.alpha = 1

				arg_660_1.dialog_:SetActive(true)
				SetActive(arg_660_1.leftNameGo_, true)

				local var_663_8 = arg_660_1:FormatText(StoryNameCfg[7].name)

				arg_660_1.leftNameTxt_.text = var_663_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_660_1.leftNameTxt_.transform)

				arg_660_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_660_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_660_1:RecordName(arg_660_1.leftNameTxt_.text)
				SetActive(arg_660_1.iconTrs_.gameObject, true)
				arg_660_1.iconController_:SetSelectedState("hero")

				arg_660_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_660_1.callingController_:SetSelectedState("normal")

				arg_660_1.keyicon_.color = Color.New(1, 1, 1)
				arg_660_1.icon_.color = Color.New(1, 1, 1)

				local var_663_9 = arg_660_1:GetWordFromCfg(1103404163)
				local var_663_10 = arg_660_1:FormatText(var_663_9.content)

				arg_660_1.text_.text = var_663_10

				LuaForUtil.ClearLinePrefixSymbol(arg_660_1.text_)

				local var_663_11 = 12
				local var_663_12 = utf8.len(var_663_10)
				local var_663_13 = var_663_11 <= 0 and var_663_7 or var_663_7 * (var_663_12 / var_663_11)

				if var_663_13 > 0 and var_663_7 < var_663_13 then
					arg_660_1.talkMaxDuration = var_663_13

					if var_663_13 + var_663_6 > arg_660_1.duration_ then
						arg_660_1.duration_ = var_663_13 + var_663_6
					end
				end

				arg_660_1.text_.text = var_663_10
				arg_660_1.typewritter.percent = 0

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(false)
				arg_660_1:RecordContent(arg_660_1.text_.text)
			end

			local var_663_14 = math.max(var_663_7, arg_660_1.talkMaxDuration)

			if var_663_6 <= arg_660_1.time_ and arg_660_1.time_ < var_663_6 + var_663_14 then
				arg_660_1.typewritter.percent = (arg_660_1.time_ - var_663_6) / var_663_14

				arg_660_1.typewritter:SetDirty()
			end

			if arg_660_1.time_ >= var_663_6 + var_663_14 and arg_660_1.time_ < var_663_6 + var_663_14 + arg_663_0 then
				arg_660_1.typewritter.percent = 1

				arg_660_1.typewritter:SetDirty()
				arg_660_1:ShowNextGo(true)
			end
		end

		arg_660_1.nodeConfigList_ = {}

		arg_660_1:InitPlayNodeList()
	end,
	Play1103404164 = function(arg_664_0, arg_664_1)
		arg_664_1.time_ = 0
		arg_664_1.frameCnt_ = 0
		arg_664_1.state_ = "playing"
		arg_664_1.curTalkId_ = 1103404164
		arg_664_1.duration_ = 5.27

		SetActive(arg_664_1.tipsGo_, false)

		function arg_664_1.onSingleLineFinish_()
			arg_664_1.onSingleLineUpdate_ = nil
			arg_664_1.onSingleLineFinish_ = nil
			arg_664_1.state_ = "waiting"
		end

		function arg_664_1.playNext_(arg_666_0)
			if arg_666_0 == 1 then
				arg_664_0:Play1103404165(arg_664_1)
			end
		end

		function arg_664_1.onSingleLineUpdate_(arg_667_0)
			local var_667_0 = 0
			local var_667_1 = 0.425

			if var_667_0 < arg_664_1.time_ and arg_664_1.time_ <= var_667_0 + arg_667_0 then
				arg_664_1.talkMaxDuration = 0
				arg_664_1.dialogCg_.alpha = 1

				arg_664_1.dialog_:SetActive(true)
				SetActive(arg_664_1.leftNameGo_, true)

				local var_667_2 = arg_664_1:FormatText(StoryNameCfg[1109].name)

				arg_664_1.leftNameTxt_.text = var_667_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_664_1.leftNameTxt_.transform)

				arg_664_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_664_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_664_1:RecordName(arg_664_1.leftNameTxt_.text)
				SetActive(arg_664_1.iconTrs_.gameObject, false)
				arg_664_1.callingController_:SetSelectedState("normal")

				local var_667_3 = arg_664_1:GetWordFromCfg(1103404164)
				local var_667_4 = arg_664_1:FormatText(var_667_3.content)

				arg_664_1.text_.text = var_667_4

				LuaForUtil.ClearLinePrefixSymbol(arg_664_1.text_)

				local var_667_5 = 17
				local var_667_6 = utf8.len(var_667_4)
				local var_667_7 = var_667_5 <= 0 and var_667_1 or var_667_1 * (var_667_6 / var_667_5)

				if var_667_7 > 0 and var_667_1 < var_667_7 then
					arg_664_1.talkMaxDuration = var_667_7

					if var_667_7 + var_667_0 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_7 + var_667_0
					end
				end

				arg_664_1.text_.text = var_667_4
				arg_664_1.typewritter.percent = 0

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404164", "story_v_side_new_1103404.awb") ~= 0 then
					local var_667_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404164", "story_v_side_new_1103404.awb") / 1000

					if var_667_8 + var_667_0 > arg_664_1.duration_ then
						arg_664_1.duration_ = var_667_8 + var_667_0
					end

					if var_667_3.prefab_name ~= "" and arg_664_1.actors_[var_667_3.prefab_name] ~= nil then
						local var_667_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_664_1.actors_[var_667_3.prefab_name].transform, "story_v_side_new_1103404", "1103404164", "story_v_side_new_1103404.awb")

						arg_664_1:RecordAudio("1103404164", var_667_9)
						arg_664_1:RecordAudio("1103404164", var_667_9)
					else
						arg_664_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404164", "story_v_side_new_1103404.awb")
					end

					arg_664_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404164", "story_v_side_new_1103404.awb")
				end

				arg_664_1:RecordContent(arg_664_1.text_.text)
			end

			local var_667_10 = math.max(var_667_1, arg_664_1.talkMaxDuration)

			if var_667_0 <= arg_664_1.time_ and arg_664_1.time_ < var_667_0 + var_667_10 then
				arg_664_1.typewritter.percent = (arg_664_1.time_ - var_667_0) / var_667_10

				arg_664_1.typewritter:SetDirty()
			end

			if arg_664_1.time_ >= var_667_0 + var_667_10 and arg_664_1.time_ < var_667_0 + var_667_10 + arg_667_0 then
				arg_664_1.typewritter.percent = 1

				arg_664_1.typewritter:SetDirty()
				arg_664_1:ShowNextGo(true)
			end
		end

		arg_664_1.nodeConfigList_ = {}

		arg_664_1:InitPlayNodeList()
	end,
	Play1103404165 = function(arg_668_0, arg_668_1)
		arg_668_1.time_ = 0
		arg_668_1.frameCnt_ = 0
		arg_668_1.state_ = "playing"
		arg_668_1.curTalkId_ = 1103404165
		arg_668_1.duration_ = 8.37

		SetActive(arg_668_1.tipsGo_, false)

		function arg_668_1.onSingleLineFinish_()
			arg_668_1.onSingleLineUpdate_ = nil
			arg_668_1.onSingleLineFinish_ = nil
			arg_668_1.state_ = "waiting"
		end

		function arg_668_1.playNext_(arg_670_0)
			if arg_670_0 == 1 then
				arg_668_0:Play1103404166(arg_668_1)
			end
		end

		function arg_668_1.onSingleLineUpdate_(arg_671_0)
			local var_671_0 = 0
			local var_671_1 = 0.975

			if var_671_0 < arg_668_1.time_ and arg_668_1.time_ <= var_671_0 + arg_671_0 then
				arg_668_1.talkMaxDuration = 0
				arg_668_1.dialogCg_.alpha = 1

				arg_668_1.dialog_:SetActive(true)
				SetActive(arg_668_1.leftNameGo_, true)

				local var_671_2 = arg_668_1:FormatText(StoryNameCfg[1109].name)

				arg_668_1.leftNameTxt_.text = var_671_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_668_1.leftNameTxt_.transform)

				arg_668_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_668_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_668_1:RecordName(arg_668_1.leftNameTxt_.text)
				SetActive(arg_668_1.iconTrs_.gameObject, false)
				arg_668_1.callingController_:SetSelectedState("normal")

				local var_671_3 = arg_668_1:GetWordFromCfg(1103404165)
				local var_671_4 = arg_668_1:FormatText(var_671_3.content)

				arg_668_1.text_.text = var_671_4

				LuaForUtil.ClearLinePrefixSymbol(arg_668_1.text_)

				local var_671_5 = 39
				local var_671_6 = utf8.len(var_671_4)
				local var_671_7 = var_671_5 <= 0 and var_671_1 or var_671_1 * (var_671_6 / var_671_5)

				if var_671_7 > 0 and var_671_1 < var_671_7 then
					arg_668_1.talkMaxDuration = var_671_7

					if var_671_7 + var_671_0 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_7 + var_671_0
					end
				end

				arg_668_1.text_.text = var_671_4
				arg_668_1.typewritter.percent = 0

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404165", "story_v_side_new_1103404.awb") ~= 0 then
					local var_671_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404165", "story_v_side_new_1103404.awb") / 1000

					if var_671_8 + var_671_0 > arg_668_1.duration_ then
						arg_668_1.duration_ = var_671_8 + var_671_0
					end

					if var_671_3.prefab_name ~= "" and arg_668_1.actors_[var_671_3.prefab_name] ~= nil then
						local var_671_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_668_1.actors_[var_671_3.prefab_name].transform, "story_v_side_new_1103404", "1103404165", "story_v_side_new_1103404.awb")

						arg_668_1:RecordAudio("1103404165", var_671_9)
						arg_668_1:RecordAudio("1103404165", var_671_9)
					else
						arg_668_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404165", "story_v_side_new_1103404.awb")
					end

					arg_668_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404165", "story_v_side_new_1103404.awb")
				end

				arg_668_1:RecordContent(arg_668_1.text_.text)
			end

			local var_671_10 = math.max(var_671_1, arg_668_1.talkMaxDuration)

			if var_671_0 <= arg_668_1.time_ and arg_668_1.time_ < var_671_0 + var_671_10 then
				arg_668_1.typewritter.percent = (arg_668_1.time_ - var_671_0) / var_671_10

				arg_668_1.typewritter:SetDirty()
			end

			if arg_668_1.time_ >= var_671_0 + var_671_10 and arg_668_1.time_ < var_671_0 + var_671_10 + arg_671_0 then
				arg_668_1.typewritter.percent = 1

				arg_668_1.typewritter:SetDirty()
				arg_668_1:ShowNextGo(true)
			end
		end

		arg_668_1.nodeConfigList_ = {}

		arg_668_1:InitPlayNodeList()
	end,
	Play1103404166 = function(arg_672_0, arg_672_1)
		arg_672_1.time_ = 0
		arg_672_1.frameCnt_ = 0
		arg_672_1.state_ = "playing"
		arg_672_1.curTalkId_ = 1103404166
		arg_672_1.duration_ = 9.8

		SetActive(arg_672_1.tipsGo_, false)

		function arg_672_1.onSingleLineFinish_()
			arg_672_1.onSingleLineUpdate_ = nil
			arg_672_1.onSingleLineFinish_ = nil
			arg_672_1.state_ = "waiting"
		end

		function arg_672_1.playNext_(arg_674_0)
			if arg_674_0 == 1 then
				arg_672_0:Play1103404167(arg_672_1)
			end
		end

		function arg_672_1.onSingleLineUpdate_(arg_675_0)
			local var_675_0 = 0
			local var_675_1 = 0.975

			if var_675_0 < arg_672_1.time_ and arg_672_1.time_ <= var_675_0 + arg_675_0 then
				arg_672_1.talkMaxDuration = 0
				arg_672_1.dialogCg_.alpha = 1

				arg_672_1.dialog_:SetActive(true)
				SetActive(arg_672_1.leftNameGo_, true)

				local var_675_2 = arg_672_1:FormatText(StoryNameCfg[1109].name)

				arg_672_1.leftNameTxt_.text = var_675_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_672_1.leftNameTxt_.transform)

				arg_672_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_672_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_672_1:RecordName(arg_672_1.leftNameTxt_.text)
				SetActive(arg_672_1.iconTrs_.gameObject, false)
				arg_672_1.callingController_:SetSelectedState("normal")

				local var_675_3 = arg_672_1:GetWordFromCfg(1103404166)
				local var_675_4 = arg_672_1:FormatText(var_675_3.content)

				arg_672_1.text_.text = var_675_4

				LuaForUtil.ClearLinePrefixSymbol(arg_672_1.text_)

				local var_675_5 = 39
				local var_675_6 = utf8.len(var_675_4)
				local var_675_7 = var_675_5 <= 0 and var_675_1 or var_675_1 * (var_675_6 / var_675_5)

				if var_675_7 > 0 and var_675_1 < var_675_7 then
					arg_672_1.talkMaxDuration = var_675_7

					if var_675_7 + var_675_0 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_7 + var_675_0
					end
				end

				arg_672_1.text_.text = var_675_4
				arg_672_1.typewritter.percent = 0

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404166", "story_v_side_new_1103404.awb") ~= 0 then
					local var_675_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404166", "story_v_side_new_1103404.awb") / 1000

					if var_675_8 + var_675_0 > arg_672_1.duration_ then
						arg_672_1.duration_ = var_675_8 + var_675_0
					end

					if var_675_3.prefab_name ~= "" and arg_672_1.actors_[var_675_3.prefab_name] ~= nil then
						local var_675_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_672_1.actors_[var_675_3.prefab_name].transform, "story_v_side_new_1103404", "1103404166", "story_v_side_new_1103404.awb")

						arg_672_1:RecordAudio("1103404166", var_675_9)
						arg_672_1:RecordAudio("1103404166", var_675_9)
					else
						arg_672_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404166", "story_v_side_new_1103404.awb")
					end

					arg_672_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404166", "story_v_side_new_1103404.awb")
				end

				arg_672_1:RecordContent(arg_672_1.text_.text)
			end

			local var_675_10 = math.max(var_675_1, arg_672_1.talkMaxDuration)

			if var_675_0 <= arg_672_1.time_ and arg_672_1.time_ < var_675_0 + var_675_10 then
				arg_672_1.typewritter.percent = (arg_672_1.time_ - var_675_0) / var_675_10

				arg_672_1.typewritter:SetDirty()
			end

			if arg_672_1.time_ >= var_675_0 + var_675_10 and arg_672_1.time_ < var_675_0 + var_675_10 + arg_675_0 then
				arg_672_1.typewritter.percent = 1

				arg_672_1.typewritter:SetDirty()
				arg_672_1:ShowNextGo(true)
			end
		end

		arg_672_1.nodeConfigList_ = {}

		arg_672_1:InitPlayNodeList()
	end,
	Play1103404167 = function(arg_676_0, arg_676_1)
		arg_676_1.time_ = 0
		arg_676_1.frameCnt_ = 0
		arg_676_1.state_ = "playing"
		arg_676_1.curTalkId_ = 1103404167
		arg_676_1.duration_ = 1

		SetActive(arg_676_1.tipsGo_, false)

		function arg_676_1.onSingleLineFinish_()
			arg_676_1.onSingleLineUpdate_ = nil
			arg_676_1.onSingleLineFinish_ = nil
			arg_676_1.state_ = "waiting"

			SetActive(arg_676_1.choicesGo_, true)

			for iter_677_0, iter_677_1 in ipairs(arg_676_1.choices_) do
				local var_677_0 = iter_677_0 <= 2

				SetActive(iter_677_1.go, var_677_0)
			end

			arg_676_1.choices_[1].txt.text = arg_676_1:FormatText(StoryChoiceCfg[1464].name)
			arg_676_1.choices_[2].txt.text = arg_676_1:FormatText(StoryChoiceCfg[1465].name)
		end

		function arg_676_1.playNext_(arg_678_0)
			if arg_678_0 == 1 then
				arg_676_0:Play1103404168(arg_676_1)
			end

			if arg_678_0 == 2 then
				arg_676_0:Play1103404170(arg_676_1)
			end

			arg_676_1:RecordChoiceLog(1103404167, 1464, 1465)
		end

		function arg_676_1.onSingleLineUpdate_(arg_679_0)
			local var_679_0 = arg_676_1.actors_["1034ui_story"]
			local var_679_1 = 0

			if var_679_1 < arg_676_1.time_ and arg_676_1.time_ <= var_679_1 + arg_679_0 and not isNil(var_679_0) and arg_676_1.var_.characterEffect1034ui_story == nil then
				arg_676_1.var_.characterEffect1034ui_story = var_679_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_679_2 = 0.200000002980232

			if var_679_1 <= arg_676_1.time_ and arg_676_1.time_ < var_679_1 + var_679_2 and not isNil(var_679_0) then
				local var_679_3 = (arg_676_1.time_ - var_679_1) / var_679_2

				if arg_676_1.var_.characterEffect1034ui_story and not isNil(var_679_0) then
					local var_679_4 = Mathf.Lerp(0, 0.5, var_679_3)

					arg_676_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_676_1.var_.characterEffect1034ui_story.fillRatio = var_679_4
				end
			end

			if arg_676_1.time_ >= var_679_1 + var_679_2 and arg_676_1.time_ < var_679_1 + var_679_2 + arg_679_0 and not isNil(var_679_0) and arg_676_1.var_.characterEffect1034ui_story then
				local var_679_5 = 0.5

				arg_676_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_676_1.var_.characterEffect1034ui_story.fillRatio = var_679_5
			end

			local var_679_6 = 0

			if var_679_6 < arg_676_1.time_ and arg_676_1.time_ <= var_679_6 + arg_679_0 then
				arg_676_1.allBtn_.enabled = false
			end

			local var_679_7 = 1

			if arg_676_1.time_ >= var_679_6 + var_679_7 and arg_676_1.time_ < var_679_6 + var_679_7 + arg_679_0 then
				arg_676_1.allBtn_.enabled = true
			end
		end

		arg_676_1.nodeConfigList_ = {}

		arg_676_1:InitPlayNodeList()
	end,
	Play1103404168 = function(arg_680_0, arg_680_1)
		arg_680_1.time_ = 0
		arg_680_1.frameCnt_ = 0
		arg_680_1.state_ = "playing"
		arg_680_1.curTalkId_ = 1103404168
		arg_680_1.duration_ = 2.33

		SetActive(arg_680_1.tipsGo_, false)

		function arg_680_1.onSingleLineFinish_()
			arg_680_1.onSingleLineUpdate_ = nil
			arg_680_1.onSingleLineFinish_ = nil
			arg_680_1.state_ = "waiting"
		end

		function arg_680_1.playNext_(arg_682_0)
			if arg_682_0 == 1 then
				arg_680_0:Play1103404169(arg_680_1)
			end
		end

		function arg_680_1.onSingleLineUpdate_(arg_683_0)
			local var_683_0 = arg_680_1.actors_["1034ui_story"]
			local var_683_1 = 0

			if var_683_1 < arg_680_1.time_ and arg_680_1.time_ <= var_683_1 + arg_683_0 and not isNil(var_683_0) and arg_680_1.var_.characterEffect1034ui_story == nil then
				arg_680_1.var_.characterEffect1034ui_story = var_683_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_683_2 = 0.200000002980232

			if var_683_1 <= arg_680_1.time_ and arg_680_1.time_ < var_683_1 + var_683_2 and not isNil(var_683_0) then
				local var_683_3 = (arg_680_1.time_ - var_683_1) / var_683_2

				if arg_680_1.var_.characterEffect1034ui_story and not isNil(var_683_0) then
					arg_680_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_680_1.time_ >= var_683_1 + var_683_2 and arg_680_1.time_ < var_683_1 + var_683_2 + arg_683_0 and not isNil(var_683_0) and arg_680_1.var_.characterEffect1034ui_story then
				arg_680_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_683_4 = 0
			local var_683_5 = 0.275

			if var_683_4 < arg_680_1.time_ and arg_680_1.time_ <= var_683_4 + arg_683_0 then
				arg_680_1.talkMaxDuration = 0
				arg_680_1.dialogCg_.alpha = 1

				arg_680_1.dialog_:SetActive(true)
				SetActive(arg_680_1.leftNameGo_, true)

				local var_683_6 = arg_680_1:FormatText(StoryNameCfg[1109].name)

				arg_680_1.leftNameTxt_.text = var_683_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_680_1.leftNameTxt_.transform)

				arg_680_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_680_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_680_1:RecordName(arg_680_1.leftNameTxt_.text)
				SetActive(arg_680_1.iconTrs_.gameObject, false)
				arg_680_1.callingController_:SetSelectedState("normal")

				local var_683_7 = arg_680_1:GetWordFromCfg(1103404168)
				local var_683_8 = arg_680_1:FormatText(var_683_7.content)

				arg_680_1.text_.text = var_683_8

				LuaForUtil.ClearLinePrefixSymbol(arg_680_1.text_)

				local var_683_9 = 11
				local var_683_10 = utf8.len(var_683_8)
				local var_683_11 = var_683_9 <= 0 and var_683_5 or var_683_5 * (var_683_10 / var_683_9)

				if var_683_11 > 0 and var_683_5 < var_683_11 then
					arg_680_1.talkMaxDuration = var_683_11

					if var_683_11 + var_683_4 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_11 + var_683_4
					end
				end

				arg_680_1.text_.text = var_683_8
				arg_680_1.typewritter.percent = 0

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404168", "story_v_side_new_1103404.awb") ~= 0 then
					local var_683_12 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404168", "story_v_side_new_1103404.awb") / 1000

					if var_683_12 + var_683_4 > arg_680_1.duration_ then
						arg_680_1.duration_ = var_683_12 + var_683_4
					end

					if var_683_7.prefab_name ~= "" and arg_680_1.actors_[var_683_7.prefab_name] ~= nil then
						local var_683_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_680_1.actors_[var_683_7.prefab_name].transform, "story_v_side_new_1103404", "1103404168", "story_v_side_new_1103404.awb")

						arg_680_1:RecordAudio("1103404168", var_683_13)
						arg_680_1:RecordAudio("1103404168", var_683_13)
					else
						arg_680_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404168", "story_v_side_new_1103404.awb")
					end

					arg_680_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404168", "story_v_side_new_1103404.awb")
				end

				arg_680_1:RecordContent(arg_680_1.text_.text)
			end

			local var_683_14 = math.max(var_683_5, arg_680_1.talkMaxDuration)

			if var_683_4 <= arg_680_1.time_ and arg_680_1.time_ < var_683_4 + var_683_14 then
				arg_680_1.typewritter.percent = (arg_680_1.time_ - var_683_4) / var_683_14

				arg_680_1.typewritter:SetDirty()
			end

			if arg_680_1.time_ >= var_683_4 + var_683_14 and arg_680_1.time_ < var_683_4 + var_683_14 + arg_683_0 then
				arg_680_1.typewritter.percent = 1

				arg_680_1.typewritter:SetDirty()
				arg_680_1:ShowNextGo(true)
			end
		end

		arg_680_1.nodeConfigList_ = {}

		arg_680_1:InitPlayNodeList()
	end,
	Play1103404169 = function(arg_684_0, arg_684_1)
		arg_684_1.time_ = 0
		arg_684_1.frameCnt_ = 0
		arg_684_1.state_ = "playing"
		arg_684_1.curTalkId_ = 1103404169
		arg_684_1.duration_ = 5.13

		SetActive(arg_684_1.tipsGo_, false)

		function arg_684_1.onSingleLineFinish_()
			arg_684_1.onSingleLineUpdate_ = nil
			arg_684_1.onSingleLineFinish_ = nil
			arg_684_1.state_ = "waiting"
		end

		function arg_684_1.playNext_(arg_686_0)
			if arg_686_0 == 1 then
				arg_684_0:Play1103404172(arg_684_1)
			end
		end

		function arg_684_1.onSingleLineUpdate_(arg_687_0)
			local var_687_0 = 0
			local var_687_1 = 0.6

			if var_687_0 < arg_684_1.time_ and arg_684_1.time_ <= var_687_0 + arg_687_0 then
				arg_684_1.talkMaxDuration = 0
				arg_684_1.dialogCg_.alpha = 1

				arg_684_1.dialog_:SetActive(true)
				SetActive(arg_684_1.leftNameGo_, true)

				local var_687_2 = arg_684_1:FormatText(StoryNameCfg[1109].name)

				arg_684_1.leftNameTxt_.text = var_687_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_684_1.leftNameTxt_.transform)

				arg_684_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_684_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_684_1:RecordName(arg_684_1.leftNameTxt_.text)
				SetActive(arg_684_1.iconTrs_.gameObject, false)
				arg_684_1.callingController_:SetSelectedState("normal")

				local var_687_3 = arg_684_1:GetWordFromCfg(1103404169)
				local var_687_4 = arg_684_1:FormatText(var_687_3.content)

				arg_684_1.text_.text = var_687_4

				LuaForUtil.ClearLinePrefixSymbol(arg_684_1.text_)

				local var_687_5 = 24
				local var_687_6 = utf8.len(var_687_4)
				local var_687_7 = var_687_5 <= 0 and var_687_1 or var_687_1 * (var_687_6 / var_687_5)

				if var_687_7 > 0 and var_687_1 < var_687_7 then
					arg_684_1.talkMaxDuration = var_687_7

					if var_687_7 + var_687_0 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_7 + var_687_0
					end
				end

				arg_684_1.text_.text = var_687_4
				arg_684_1.typewritter.percent = 0

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404169", "story_v_side_new_1103404.awb") ~= 0 then
					local var_687_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404169", "story_v_side_new_1103404.awb") / 1000

					if var_687_8 + var_687_0 > arg_684_1.duration_ then
						arg_684_1.duration_ = var_687_8 + var_687_0
					end

					if var_687_3.prefab_name ~= "" and arg_684_1.actors_[var_687_3.prefab_name] ~= nil then
						local var_687_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_684_1.actors_[var_687_3.prefab_name].transform, "story_v_side_new_1103404", "1103404169", "story_v_side_new_1103404.awb")

						arg_684_1:RecordAudio("1103404169", var_687_9)
						arg_684_1:RecordAudio("1103404169", var_687_9)
					else
						arg_684_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404169", "story_v_side_new_1103404.awb")
					end

					arg_684_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404169", "story_v_side_new_1103404.awb")
				end

				arg_684_1:RecordContent(arg_684_1.text_.text)
			end

			local var_687_10 = math.max(var_687_1, arg_684_1.talkMaxDuration)

			if var_687_0 <= arg_684_1.time_ and arg_684_1.time_ < var_687_0 + var_687_10 then
				arg_684_1.typewritter.percent = (arg_684_1.time_ - var_687_0) / var_687_10

				arg_684_1.typewritter:SetDirty()
			end

			if arg_684_1.time_ >= var_687_0 + var_687_10 and arg_684_1.time_ < var_687_0 + var_687_10 + arg_687_0 then
				arg_684_1.typewritter.percent = 1

				arg_684_1.typewritter:SetDirty()
				arg_684_1:ShowNextGo(true)
			end
		end

		arg_684_1.nodeConfigList_ = {}

		arg_684_1:InitPlayNodeList()
	end,
	Play1103404172 = function(arg_688_0, arg_688_1)
		arg_688_1.time_ = 0
		arg_688_1.frameCnt_ = 0
		arg_688_1.state_ = "playing"
		arg_688_1.curTalkId_ = 1103404172
		arg_688_1.duration_ = 5

		SetActive(arg_688_1.tipsGo_, false)

		function arg_688_1.onSingleLineFinish_()
			arg_688_1.onSingleLineUpdate_ = nil
			arg_688_1.onSingleLineFinish_ = nil
			arg_688_1.state_ = "waiting"
		end

		function arg_688_1.playNext_(arg_690_0)
			if arg_690_0 == 1 then
				arg_688_0:Play1103404173(arg_688_1)
			end
		end

		function arg_688_1.onSingleLineUpdate_(arg_691_0)
			local var_691_0 = arg_688_1.actors_["1034ui_story"]
			local var_691_1 = 0

			if var_691_1 < arg_688_1.time_ and arg_688_1.time_ <= var_691_1 + arg_691_0 and not isNil(var_691_0) and arg_688_1.var_.characterEffect1034ui_story == nil then
				arg_688_1.var_.characterEffect1034ui_story = var_691_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_691_2 = 0.200000002980232

			if var_691_1 <= arg_688_1.time_ and arg_688_1.time_ < var_691_1 + var_691_2 and not isNil(var_691_0) then
				local var_691_3 = (arg_688_1.time_ - var_691_1) / var_691_2

				if arg_688_1.var_.characterEffect1034ui_story and not isNil(var_691_0) then
					local var_691_4 = Mathf.Lerp(0, 0.5, var_691_3)

					arg_688_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_688_1.var_.characterEffect1034ui_story.fillRatio = var_691_4
				end
			end

			if arg_688_1.time_ >= var_691_1 + var_691_2 and arg_688_1.time_ < var_691_1 + var_691_2 + arg_691_0 and not isNil(var_691_0) and arg_688_1.var_.characterEffect1034ui_story then
				local var_691_5 = 0.5

				arg_688_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_688_1.var_.characterEffect1034ui_story.fillRatio = var_691_5
			end

			local var_691_6 = 0
			local var_691_7 = 0.375

			if var_691_6 < arg_688_1.time_ and arg_688_1.time_ <= var_691_6 + arg_691_0 then
				arg_688_1.talkMaxDuration = 0
				arg_688_1.dialogCg_.alpha = 1

				arg_688_1.dialog_:SetActive(true)
				SetActive(arg_688_1.leftNameGo_, true)

				local var_691_8 = arg_688_1:FormatText(StoryNameCfg[7].name)

				arg_688_1.leftNameTxt_.text = var_691_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_688_1.leftNameTxt_.transform)

				arg_688_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_688_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_688_1:RecordName(arg_688_1.leftNameTxt_.text)
				SetActive(arg_688_1.iconTrs_.gameObject, true)
				arg_688_1.iconController_:SetSelectedState("hero")

				arg_688_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_688_1.callingController_:SetSelectedState("normal")

				arg_688_1.keyicon_.color = Color.New(1, 1, 1)
				arg_688_1.icon_.color = Color.New(1, 1, 1)

				local var_691_9 = arg_688_1:GetWordFromCfg(1103404172)
				local var_691_10 = arg_688_1:FormatText(var_691_9.content)

				arg_688_1.text_.text = var_691_10

				LuaForUtil.ClearLinePrefixSymbol(arg_688_1.text_)

				local var_691_11 = 15
				local var_691_12 = utf8.len(var_691_10)
				local var_691_13 = var_691_11 <= 0 and var_691_7 or var_691_7 * (var_691_12 / var_691_11)

				if var_691_13 > 0 and var_691_7 < var_691_13 then
					arg_688_1.talkMaxDuration = var_691_13

					if var_691_13 + var_691_6 > arg_688_1.duration_ then
						arg_688_1.duration_ = var_691_13 + var_691_6
					end
				end

				arg_688_1.text_.text = var_691_10
				arg_688_1.typewritter.percent = 0

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(false)
				arg_688_1:RecordContent(arg_688_1.text_.text)
			end

			local var_691_14 = math.max(var_691_7, arg_688_1.talkMaxDuration)

			if var_691_6 <= arg_688_1.time_ and arg_688_1.time_ < var_691_6 + var_691_14 then
				arg_688_1.typewritter.percent = (arg_688_1.time_ - var_691_6) / var_691_14

				arg_688_1.typewritter:SetDirty()
			end

			if arg_688_1.time_ >= var_691_6 + var_691_14 and arg_688_1.time_ < var_691_6 + var_691_14 + arg_691_0 then
				arg_688_1.typewritter.percent = 1

				arg_688_1.typewritter:SetDirty()
				arg_688_1:ShowNextGo(true)
			end
		end

		arg_688_1.nodeConfigList_ = {}

		arg_688_1:InitPlayNodeList()
	end,
	Play1103404173 = function(arg_692_0, arg_692_1)
		arg_692_1.time_ = 0
		arg_692_1.frameCnt_ = 0
		arg_692_1.state_ = "playing"
		arg_692_1.curTalkId_ = 1103404173
		arg_692_1.duration_ = 1.73

		SetActive(arg_692_1.tipsGo_, false)

		function arg_692_1.onSingleLineFinish_()
			arg_692_1.onSingleLineUpdate_ = nil
			arg_692_1.onSingleLineFinish_ = nil
			arg_692_1.state_ = "waiting"
		end

		function arg_692_1.playNext_(arg_694_0)
			if arg_694_0 == 1 then
				arg_692_0:Play1103404174(arg_692_1)
			end
		end

		function arg_692_1.onSingleLineUpdate_(arg_695_0)
			local var_695_0 = arg_692_1.actors_["1034ui_story"]
			local var_695_1 = 0

			if var_695_1 < arg_692_1.time_ and arg_692_1.time_ <= var_695_1 + arg_695_0 and not isNil(var_695_0) and arg_692_1.var_.characterEffect1034ui_story == nil then
				arg_692_1.var_.characterEffect1034ui_story = var_695_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_695_2 = 0.200000002980232

			if var_695_1 <= arg_692_1.time_ and arg_692_1.time_ < var_695_1 + var_695_2 and not isNil(var_695_0) then
				local var_695_3 = (arg_692_1.time_ - var_695_1) / var_695_2

				if arg_692_1.var_.characterEffect1034ui_story and not isNil(var_695_0) then
					arg_692_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_692_1.time_ >= var_695_1 + var_695_2 and arg_692_1.time_ < var_695_1 + var_695_2 + arg_695_0 and not isNil(var_695_0) and arg_692_1.var_.characterEffect1034ui_story then
				arg_692_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_695_4 = 0
			local var_695_5 = 0.125

			if var_695_4 < arg_692_1.time_ and arg_692_1.time_ <= var_695_4 + arg_695_0 then
				arg_692_1.talkMaxDuration = 0
				arg_692_1.dialogCg_.alpha = 1

				arg_692_1.dialog_:SetActive(true)
				SetActive(arg_692_1.leftNameGo_, true)

				local var_695_6 = arg_692_1:FormatText(StoryNameCfg[1109].name)

				arg_692_1.leftNameTxt_.text = var_695_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_692_1.leftNameTxt_.transform)

				arg_692_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_692_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_692_1:RecordName(arg_692_1.leftNameTxt_.text)
				SetActive(arg_692_1.iconTrs_.gameObject, false)
				arg_692_1.callingController_:SetSelectedState("normal")

				local var_695_7 = arg_692_1:GetWordFromCfg(1103404173)
				local var_695_8 = arg_692_1:FormatText(var_695_7.content)

				arg_692_1.text_.text = var_695_8

				LuaForUtil.ClearLinePrefixSymbol(arg_692_1.text_)

				local var_695_9 = 5
				local var_695_10 = utf8.len(var_695_8)
				local var_695_11 = var_695_9 <= 0 and var_695_5 or var_695_5 * (var_695_10 / var_695_9)

				if var_695_11 > 0 and var_695_5 < var_695_11 then
					arg_692_1.talkMaxDuration = var_695_11

					if var_695_11 + var_695_4 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_11 + var_695_4
					end
				end

				arg_692_1.text_.text = var_695_8
				arg_692_1.typewritter.percent = 0

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404173", "story_v_side_new_1103404.awb") ~= 0 then
					local var_695_12 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404173", "story_v_side_new_1103404.awb") / 1000

					if var_695_12 + var_695_4 > arg_692_1.duration_ then
						arg_692_1.duration_ = var_695_12 + var_695_4
					end

					if var_695_7.prefab_name ~= "" and arg_692_1.actors_[var_695_7.prefab_name] ~= nil then
						local var_695_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_692_1.actors_[var_695_7.prefab_name].transform, "story_v_side_new_1103404", "1103404173", "story_v_side_new_1103404.awb")

						arg_692_1:RecordAudio("1103404173", var_695_13)
						arg_692_1:RecordAudio("1103404173", var_695_13)
					else
						arg_692_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404173", "story_v_side_new_1103404.awb")
					end

					arg_692_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404173", "story_v_side_new_1103404.awb")
				end

				arg_692_1:RecordContent(arg_692_1.text_.text)
			end

			local var_695_14 = math.max(var_695_5, arg_692_1.talkMaxDuration)

			if var_695_4 <= arg_692_1.time_ and arg_692_1.time_ < var_695_4 + var_695_14 then
				arg_692_1.typewritter.percent = (arg_692_1.time_ - var_695_4) / var_695_14

				arg_692_1.typewritter:SetDirty()
			end

			if arg_692_1.time_ >= var_695_4 + var_695_14 and arg_692_1.time_ < var_695_4 + var_695_14 + arg_695_0 then
				arg_692_1.typewritter.percent = 1

				arg_692_1.typewritter:SetDirty()
				arg_692_1:ShowNextGo(true)
			end
		end

		arg_692_1.nodeConfigList_ = {}

		arg_692_1:InitPlayNodeList()
	end,
	Play1103404174 = function(arg_696_0, arg_696_1)
		arg_696_1.time_ = 0
		arg_696_1.frameCnt_ = 0
		arg_696_1.state_ = "playing"
		arg_696_1.curTalkId_ = 1103404174
		arg_696_1.duration_ = 5

		SetActive(arg_696_1.tipsGo_, false)

		function arg_696_1.onSingleLineFinish_()
			arg_696_1.onSingleLineUpdate_ = nil
			arg_696_1.onSingleLineFinish_ = nil
			arg_696_1.state_ = "waiting"
		end

		function arg_696_1.playNext_(arg_698_0)
			if arg_698_0 == 1 then
				arg_696_0:Play1103404175(arg_696_1)
			end
		end

		function arg_696_1.onSingleLineUpdate_(arg_699_0)
			local var_699_0 = arg_696_1.actors_["1034ui_story"]
			local var_699_1 = 0

			if var_699_1 < arg_696_1.time_ and arg_696_1.time_ <= var_699_1 + arg_699_0 and not isNil(var_699_0) and arg_696_1.var_.characterEffect1034ui_story == nil then
				arg_696_1.var_.characterEffect1034ui_story = var_699_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_699_2 = 0.200000002980232

			if var_699_1 <= arg_696_1.time_ and arg_696_1.time_ < var_699_1 + var_699_2 and not isNil(var_699_0) then
				local var_699_3 = (arg_696_1.time_ - var_699_1) / var_699_2

				if arg_696_1.var_.characterEffect1034ui_story and not isNil(var_699_0) then
					local var_699_4 = Mathf.Lerp(0, 0.5, var_699_3)

					arg_696_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_696_1.var_.characterEffect1034ui_story.fillRatio = var_699_4
				end
			end

			if arg_696_1.time_ >= var_699_1 + var_699_2 and arg_696_1.time_ < var_699_1 + var_699_2 + arg_699_0 and not isNil(var_699_0) and arg_696_1.var_.characterEffect1034ui_story then
				local var_699_5 = 0.5

				arg_696_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_696_1.var_.characterEffect1034ui_story.fillRatio = var_699_5
			end

			local var_699_6 = 0

			if var_699_6 < arg_696_1.time_ and arg_696_1.time_ <= var_699_6 + arg_699_0 then
				arg_696_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_699_7 = 0
			local var_699_8 = 1.2

			if var_699_7 < arg_696_1.time_ and arg_696_1.time_ <= var_699_7 + arg_699_0 then
				arg_696_1.talkMaxDuration = 0
				arg_696_1.dialogCg_.alpha = 1

				arg_696_1.dialog_:SetActive(true)
				SetActive(arg_696_1.leftNameGo_, false)

				arg_696_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_696_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_696_1:RecordName(arg_696_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_696_1.iconTrs_.gameObject, false)
				arg_696_1.callingController_:SetSelectedState("normal")

				local var_699_9 = arg_696_1:GetWordFromCfg(1103404174)
				local var_699_10 = arg_696_1:FormatText(var_699_9.content)

				arg_696_1.text_.text = var_699_10

				LuaForUtil.ClearLinePrefixSymbol(arg_696_1.text_)

				local var_699_11 = 48
				local var_699_12 = utf8.len(var_699_10)
				local var_699_13 = var_699_11 <= 0 and var_699_8 or var_699_8 * (var_699_12 / var_699_11)

				if var_699_13 > 0 and var_699_8 < var_699_13 then
					arg_696_1.talkMaxDuration = var_699_13

					if var_699_13 + var_699_7 > arg_696_1.duration_ then
						arg_696_1.duration_ = var_699_13 + var_699_7
					end
				end

				arg_696_1.text_.text = var_699_10
				arg_696_1.typewritter.percent = 0

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(false)
				arg_696_1:RecordContent(arg_696_1.text_.text)
			end

			local var_699_14 = math.max(var_699_8, arg_696_1.talkMaxDuration)

			if var_699_7 <= arg_696_1.time_ and arg_696_1.time_ < var_699_7 + var_699_14 then
				arg_696_1.typewritter.percent = (arg_696_1.time_ - var_699_7) / var_699_14

				arg_696_1.typewritter:SetDirty()
			end

			if arg_696_1.time_ >= var_699_7 + var_699_14 and arg_696_1.time_ < var_699_7 + var_699_14 + arg_699_0 then
				arg_696_1.typewritter.percent = 1

				arg_696_1.typewritter:SetDirty()
				arg_696_1:ShowNextGo(true)
			end
		end

		arg_696_1.nodeConfigList_ = {}

		arg_696_1:InitPlayNodeList()
	end,
	Play1103404175 = function(arg_700_0, arg_700_1)
		arg_700_1.time_ = 0
		arg_700_1.frameCnt_ = 0
		arg_700_1.state_ = "playing"
		arg_700_1.curTalkId_ = 1103404175
		arg_700_1.duration_ = 13.03

		SetActive(arg_700_1.tipsGo_, false)

		function arg_700_1.onSingleLineFinish_()
			arg_700_1.onSingleLineUpdate_ = nil
			arg_700_1.onSingleLineFinish_ = nil
			arg_700_1.state_ = "waiting"
		end

		function arg_700_1.playNext_(arg_702_0)
			if arg_702_0 == 1 then
				arg_700_0:Play1103404176(arg_700_1)
			end
		end

		function arg_700_1.onSingleLineUpdate_(arg_703_0)
			local var_703_0 = arg_700_1.actors_["1034ui_story"]
			local var_703_1 = 0

			if var_703_1 < arg_700_1.time_ and arg_700_1.time_ <= var_703_1 + arg_703_0 and not isNil(var_703_0) and arg_700_1.var_.characterEffect1034ui_story == nil then
				arg_700_1.var_.characterEffect1034ui_story = var_703_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_703_2 = 0.200000002980232

			if var_703_1 <= arg_700_1.time_ and arg_700_1.time_ < var_703_1 + var_703_2 and not isNil(var_703_0) then
				local var_703_3 = (arg_700_1.time_ - var_703_1) / var_703_2

				if arg_700_1.var_.characterEffect1034ui_story and not isNil(var_703_0) then
					arg_700_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_700_1.time_ >= var_703_1 + var_703_2 and arg_700_1.time_ < var_703_1 + var_703_2 + arg_703_0 and not isNil(var_703_0) and arg_700_1.var_.characterEffect1034ui_story then
				arg_700_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_703_4 = 0
			local var_703_5 = 1.65

			if var_703_4 < arg_700_1.time_ and arg_700_1.time_ <= var_703_4 + arg_703_0 then
				arg_700_1.talkMaxDuration = 0
				arg_700_1.dialogCg_.alpha = 1

				arg_700_1.dialog_:SetActive(true)
				SetActive(arg_700_1.leftNameGo_, true)

				local var_703_6 = arg_700_1:FormatText(StoryNameCfg[1109].name)

				arg_700_1.leftNameTxt_.text = var_703_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_700_1.leftNameTxt_.transform)

				arg_700_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_700_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_700_1:RecordName(arg_700_1.leftNameTxt_.text)
				SetActive(arg_700_1.iconTrs_.gameObject, false)
				arg_700_1.callingController_:SetSelectedState("normal")

				local var_703_7 = arg_700_1:GetWordFromCfg(1103404175)
				local var_703_8 = arg_700_1:FormatText(var_703_7.content)

				arg_700_1.text_.text = var_703_8

				LuaForUtil.ClearLinePrefixSymbol(arg_700_1.text_)

				local var_703_9 = 66
				local var_703_10 = utf8.len(var_703_8)
				local var_703_11 = var_703_9 <= 0 and var_703_5 or var_703_5 * (var_703_10 / var_703_9)

				if var_703_11 > 0 and var_703_5 < var_703_11 then
					arg_700_1.talkMaxDuration = var_703_11

					if var_703_11 + var_703_4 > arg_700_1.duration_ then
						arg_700_1.duration_ = var_703_11 + var_703_4
					end
				end

				arg_700_1.text_.text = var_703_8
				arg_700_1.typewritter.percent = 0

				arg_700_1.typewritter:SetDirty()
				arg_700_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404175", "story_v_side_new_1103404.awb") ~= 0 then
					local var_703_12 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404175", "story_v_side_new_1103404.awb") / 1000

					if var_703_12 + var_703_4 > arg_700_1.duration_ then
						arg_700_1.duration_ = var_703_12 + var_703_4
					end

					if var_703_7.prefab_name ~= "" and arg_700_1.actors_[var_703_7.prefab_name] ~= nil then
						local var_703_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_700_1.actors_[var_703_7.prefab_name].transform, "story_v_side_new_1103404", "1103404175", "story_v_side_new_1103404.awb")

						arg_700_1:RecordAudio("1103404175", var_703_13)
						arg_700_1:RecordAudio("1103404175", var_703_13)
					else
						arg_700_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404175", "story_v_side_new_1103404.awb")
					end

					arg_700_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404175", "story_v_side_new_1103404.awb")
				end

				arg_700_1:RecordContent(arg_700_1.text_.text)
			end

			local var_703_14 = math.max(var_703_5, arg_700_1.talkMaxDuration)

			if var_703_4 <= arg_700_1.time_ and arg_700_1.time_ < var_703_4 + var_703_14 then
				arg_700_1.typewritter.percent = (arg_700_1.time_ - var_703_4) / var_703_14

				arg_700_1.typewritter:SetDirty()
			end

			if arg_700_1.time_ >= var_703_4 + var_703_14 and arg_700_1.time_ < var_703_4 + var_703_14 + arg_703_0 then
				arg_700_1.typewritter.percent = 1

				arg_700_1.typewritter:SetDirty()
				arg_700_1:ShowNextGo(true)
			end
		end

		arg_700_1.nodeConfigList_ = {}

		arg_700_1:InitPlayNodeList()
	end,
	Play1103404176 = function(arg_704_0, arg_704_1)
		arg_704_1.time_ = 0
		arg_704_1.frameCnt_ = 0
		arg_704_1.state_ = "playing"
		arg_704_1.curTalkId_ = 1103404176
		arg_704_1.duration_ = 11.93

		SetActive(arg_704_1.tipsGo_, false)

		function arg_704_1.onSingleLineFinish_()
			arg_704_1.onSingleLineUpdate_ = nil
			arg_704_1.onSingleLineFinish_ = nil
			arg_704_1.state_ = "waiting"
		end

		function arg_704_1.playNext_(arg_706_0)
			if arg_706_0 == 1 then
				arg_704_0:Play1103404177(arg_704_1)
			end
		end

		function arg_704_1.onSingleLineUpdate_(arg_707_0)
			local var_707_0 = 0
			local var_707_1 = 1.175

			if var_707_0 < arg_704_1.time_ and arg_704_1.time_ <= var_707_0 + arg_707_0 then
				arg_704_1.talkMaxDuration = 0
				arg_704_1.dialogCg_.alpha = 1

				arg_704_1.dialog_:SetActive(true)
				SetActive(arg_704_1.leftNameGo_, true)

				local var_707_2 = arg_704_1:FormatText(StoryNameCfg[1109].name)

				arg_704_1.leftNameTxt_.text = var_707_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_704_1.leftNameTxt_.transform)

				arg_704_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_704_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_704_1:RecordName(arg_704_1.leftNameTxt_.text)
				SetActive(arg_704_1.iconTrs_.gameObject, false)
				arg_704_1.callingController_:SetSelectedState("normal")

				local var_707_3 = arg_704_1:GetWordFromCfg(1103404176)
				local var_707_4 = arg_704_1:FormatText(var_707_3.content)

				arg_704_1.text_.text = var_707_4

				LuaForUtil.ClearLinePrefixSymbol(arg_704_1.text_)

				local var_707_5 = 47
				local var_707_6 = utf8.len(var_707_4)
				local var_707_7 = var_707_5 <= 0 and var_707_1 or var_707_1 * (var_707_6 / var_707_5)

				if var_707_7 > 0 and var_707_1 < var_707_7 then
					arg_704_1.talkMaxDuration = var_707_7

					if var_707_7 + var_707_0 > arg_704_1.duration_ then
						arg_704_1.duration_ = var_707_7 + var_707_0
					end
				end

				arg_704_1.text_.text = var_707_4
				arg_704_1.typewritter.percent = 0

				arg_704_1.typewritter:SetDirty()
				arg_704_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404176", "story_v_side_new_1103404.awb") ~= 0 then
					local var_707_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404176", "story_v_side_new_1103404.awb") / 1000

					if var_707_8 + var_707_0 > arg_704_1.duration_ then
						arg_704_1.duration_ = var_707_8 + var_707_0
					end

					if var_707_3.prefab_name ~= "" and arg_704_1.actors_[var_707_3.prefab_name] ~= nil then
						local var_707_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_704_1.actors_[var_707_3.prefab_name].transform, "story_v_side_new_1103404", "1103404176", "story_v_side_new_1103404.awb")

						arg_704_1:RecordAudio("1103404176", var_707_9)
						arg_704_1:RecordAudio("1103404176", var_707_9)
					else
						arg_704_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404176", "story_v_side_new_1103404.awb")
					end

					arg_704_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404176", "story_v_side_new_1103404.awb")
				end

				arg_704_1:RecordContent(arg_704_1.text_.text)
			end

			local var_707_10 = math.max(var_707_1, arg_704_1.talkMaxDuration)

			if var_707_0 <= arg_704_1.time_ and arg_704_1.time_ < var_707_0 + var_707_10 then
				arg_704_1.typewritter.percent = (arg_704_1.time_ - var_707_0) / var_707_10

				arg_704_1.typewritter:SetDirty()
			end

			if arg_704_1.time_ >= var_707_0 + var_707_10 and arg_704_1.time_ < var_707_0 + var_707_10 + arg_707_0 then
				arg_704_1.typewritter.percent = 1

				arg_704_1.typewritter:SetDirty()
				arg_704_1:ShowNextGo(true)
			end
		end

		arg_704_1.nodeConfigList_ = {}

		arg_704_1:InitPlayNodeList()
	end,
	Play1103404177 = function(arg_708_0, arg_708_1)
		arg_708_1.time_ = 0
		arg_708_1.frameCnt_ = 0
		arg_708_1.state_ = "playing"
		arg_708_1.curTalkId_ = 1103404177
		arg_708_1.duration_ = 9.33

		SetActive(arg_708_1.tipsGo_, false)

		function arg_708_1.onSingleLineFinish_()
			arg_708_1.onSingleLineUpdate_ = nil
			arg_708_1.onSingleLineFinish_ = nil
			arg_708_1.state_ = "waiting"
		end

		function arg_708_1.playNext_(arg_710_0)
			if arg_710_0 == 1 then
				arg_708_0:Play1103404178(arg_708_1)
			end
		end

		function arg_708_1.onSingleLineUpdate_(arg_711_0)
			local var_711_0 = 0
			local var_711_1 = 1

			if var_711_0 < arg_708_1.time_ and arg_708_1.time_ <= var_711_0 + arg_711_0 then
				arg_708_1.talkMaxDuration = 0
				arg_708_1.dialogCg_.alpha = 1

				arg_708_1.dialog_:SetActive(true)
				SetActive(arg_708_1.leftNameGo_, true)

				local var_711_2 = arg_708_1:FormatText(StoryNameCfg[1109].name)

				arg_708_1.leftNameTxt_.text = var_711_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_708_1.leftNameTxt_.transform)

				arg_708_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_708_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_708_1:RecordName(arg_708_1.leftNameTxt_.text)
				SetActive(arg_708_1.iconTrs_.gameObject, false)
				arg_708_1.callingController_:SetSelectedState("normal")

				local var_711_3 = arg_708_1:GetWordFromCfg(1103404177)
				local var_711_4 = arg_708_1:FormatText(var_711_3.content)

				arg_708_1.text_.text = var_711_4

				LuaForUtil.ClearLinePrefixSymbol(arg_708_1.text_)

				local var_711_5 = 40
				local var_711_6 = utf8.len(var_711_4)
				local var_711_7 = var_711_5 <= 0 and var_711_1 or var_711_1 * (var_711_6 / var_711_5)

				if var_711_7 > 0 and var_711_1 < var_711_7 then
					arg_708_1.talkMaxDuration = var_711_7

					if var_711_7 + var_711_0 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_7 + var_711_0
					end
				end

				arg_708_1.text_.text = var_711_4
				arg_708_1.typewritter.percent = 0

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404177", "story_v_side_new_1103404.awb") ~= 0 then
					local var_711_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404177", "story_v_side_new_1103404.awb") / 1000

					if var_711_8 + var_711_0 > arg_708_1.duration_ then
						arg_708_1.duration_ = var_711_8 + var_711_0
					end

					if var_711_3.prefab_name ~= "" and arg_708_1.actors_[var_711_3.prefab_name] ~= nil then
						local var_711_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_708_1.actors_[var_711_3.prefab_name].transform, "story_v_side_new_1103404", "1103404177", "story_v_side_new_1103404.awb")

						arg_708_1:RecordAudio("1103404177", var_711_9)
						arg_708_1:RecordAudio("1103404177", var_711_9)
					else
						arg_708_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404177", "story_v_side_new_1103404.awb")
					end

					arg_708_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404177", "story_v_side_new_1103404.awb")
				end

				arg_708_1:RecordContent(arg_708_1.text_.text)
			end

			local var_711_10 = math.max(var_711_1, arg_708_1.talkMaxDuration)

			if var_711_0 <= arg_708_1.time_ and arg_708_1.time_ < var_711_0 + var_711_10 then
				arg_708_1.typewritter.percent = (arg_708_1.time_ - var_711_0) / var_711_10

				arg_708_1.typewritter:SetDirty()
			end

			if arg_708_1.time_ >= var_711_0 + var_711_10 and arg_708_1.time_ < var_711_0 + var_711_10 + arg_711_0 then
				arg_708_1.typewritter.percent = 1

				arg_708_1.typewritter:SetDirty()
				arg_708_1:ShowNextGo(true)
			end
		end

		arg_708_1.nodeConfigList_ = {}

		arg_708_1:InitPlayNodeList()
	end,
	Play1103404178 = function(arg_712_0, arg_712_1)
		arg_712_1.time_ = 0
		arg_712_1.frameCnt_ = 0
		arg_712_1.state_ = "playing"
		arg_712_1.curTalkId_ = 1103404178
		arg_712_1.duration_ = 7.67

		SetActive(arg_712_1.tipsGo_, false)

		function arg_712_1.onSingleLineFinish_()
			arg_712_1.onSingleLineUpdate_ = nil
			arg_712_1.onSingleLineFinish_ = nil
			arg_712_1.state_ = "waiting"
		end

		function arg_712_1.playNext_(arg_714_0)
			if arg_714_0 == 1 then
				arg_712_0:Play1103404179(arg_712_1)
			end
		end

		function arg_712_1.onSingleLineUpdate_(arg_715_0)
			local var_715_0 = 0
			local var_715_1 = 0.85

			if var_715_0 < arg_712_1.time_ and arg_712_1.time_ <= var_715_0 + arg_715_0 then
				arg_712_1.talkMaxDuration = 0
				arg_712_1.dialogCg_.alpha = 1

				arg_712_1.dialog_:SetActive(true)
				SetActive(arg_712_1.leftNameGo_, true)

				local var_715_2 = arg_712_1:FormatText(StoryNameCfg[1109].name)

				arg_712_1.leftNameTxt_.text = var_715_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_712_1.leftNameTxt_.transform)

				arg_712_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_712_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_712_1:RecordName(arg_712_1.leftNameTxt_.text)
				SetActive(arg_712_1.iconTrs_.gameObject, false)
				arg_712_1.callingController_:SetSelectedState("normal")

				local var_715_3 = arg_712_1:GetWordFromCfg(1103404178)
				local var_715_4 = arg_712_1:FormatText(var_715_3.content)

				arg_712_1.text_.text = var_715_4

				LuaForUtil.ClearLinePrefixSymbol(arg_712_1.text_)

				local var_715_5 = 34
				local var_715_6 = utf8.len(var_715_4)
				local var_715_7 = var_715_5 <= 0 and var_715_1 or var_715_1 * (var_715_6 / var_715_5)

				if var_715_7 > 0 and var_715_1 < var_715_7 then
					arg_712_1.talkMaxDuration = var_715_7

					if var_715_7 + var_715_0 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_7 + var_715_0
					end
				end

				arg_712_1.text_.text = var_715_4
				arg_712_1.typewritter.percent = 0

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404178", "story_v_side_new_1103404.awb") ~= 0 then
					local var_715_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404178", "story_v_side_new_1103404.awb") / 1000

					if var_715_8 + var_715_0 > arg_712_1.duration_ then
						arg_712_1.duration_ = var_715_8 + var_715_0
					end

					if var_715_3.prefab_name ~= "" and arg_712_1.actors_[var_715_3.prefab_name] ~= nil then
						local var_715_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_712_1.actors_[var_715_3.prefab_name].transform, "story_v_side_new_1103404", "1103404178", "story_v_side_new_1103404.awb")

						arg_712_1:RecordAudio("1103404178", var_715_9)
						arg_712_1:RecordAudio("1103404178", var_715_9)
					else
						arg_712_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404178", "story_v_side_new_1103404.awb")
					end

					arg_712_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404178", "story_v_side_new_1103404.awb")
				end

				arg_712_1:RecordContent(arg_712_1.text_.text)
			end

			local var_715_10 = math.max(var_715_1, arg_712_1.talkMaxDuration)

			if var_715_0 <= arg_712_1.time_ and arg_712_1.time_ < var_715_0 + var_715_10 then
				arg_712_1.typewritter.percent = (arg_712_1.time_ - var_715_0) / var_715_10

				arg_712_1.typewritter:SetDirty()
			end

			if arg_712_1.time_ >= var_715_0 + var_715_10 and arg_712_1.time_ < var_715_0 + var_715_10 + arg_715_0 then
				arg_712_1.typewritter.percent = 1

				arg_712_1.typewritter:SetDirty()
				arg_712_1:ShowNextGo(true)
			end
		end

		arg_712_1.nodeConfigList_ = {}

		arg_712_1:InitPlayNodeList()
	end,
	Play1103404179 = function(arg_716_0, arg_716_1)
		arg_716_1.time_ = 0
		arg_716_1.frameCnt_ = 0
		arg_716_1.state_ = "playing"
		arg_716_1.curTalkId_ = 1103404179
		arg_716_1.duration_ = 11.27

		SetActive(arg_716_1.tipsGo_, false)

		function arg_716_1.onSingleLineFinish_()
			arg_716_1.onSingleLineUpdate_ = nil
			arg_716_1.onSingleLineFinish_ = nil
			arg_716_1.state_ = "waiting"
		end

		function arg_716_1.playNext_(arg_718_0)
			if arg_718_0 == 1 then
				arg_716_0:Play1103404180(arg_716_1)
			end
		end

		function arg_716_1.onSingleLineUpdate_(arg_719_0)
			local var_719_0 = 0
			local var_719_1 = 0.9

			if var_719_0 < arg_716_1.time_ and arg_716_1.time_ <= var_719_0 + arg_719_0 then
				arg_716_1.talkMaxDuration = 0
				arg_716_1.dialogCg_.alpha = 1

				arg_716_1.dialog_:SetActive(true)
				SetActive(arg_716_1.leftNameGo_, true)

				local var_719_2 = arg_716_1:FormatText(StoryNameCfg[1109].name)

				arg_716_1.leftNameTxt_.text = var_719_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_716_1.leftNameTxt_.transform)

				arg_716_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_716_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_716_1:RecordName(arg_716_1.leftNameTxt_.text)
				SetActive(arg_716_1.iconTrs_.gameObject, false)
				arg_716_1.callingController_:SetSelectedState("normal")

				local var_719_3 = arg_716_1:GetWordFromCfg(1103404179)
				local var_719_4 = arg_716_1:FormatText(var_719_3.content)

				arg_716_1.text_.text = var_719_4

				LuaForUtil.ClearLinePrefixSymbol(arg_716_1.text_)

				local var_719_5 = 36
				local var_719_6 = utf8.len(var_719_4)
				local var_719_7 = var_719_5 <= 0 and var_719_1 or var_719_1 * (var_719_6 / var_719_5)

				if var_719_7 > 0 and var_719_1 < var_719_7 then
					arg_716_1.talkMaxDuration = var_719_7

					if var_719_7 + var_719_0 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_7 + var_719_0
					end
				end

				arg_716_1.text_.text = var_719_4
				arg_716_1.typewritter.percent = 0

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404179", "story_v_side_new_1103404.awb") ~= 0 then
					local var_719_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404179", "story_v_side_new_1103404.awb") / 1000

					if var_719_8 + var_719_0 > arg_716_1.duration_ then
						arg_716_1.duration_ = var_719_8 + var_719_0
					end

					if var_719_3.prefab_name ~= "" and arg_716_1.actors_[var_719_3.prefab_name] ~= nil then
						local var_719_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_716_1.actors_[var_719_3.prefab_name].transform, "story_v_side_new_1103404", "1103404179", "story_v_side_new_1103404.awb")

						arg_716_1:RecordAudio("1103404179", var_719_9)
						arg_716_1:RecordAudio("1103404179", var_719_9)
					else
						arg_716_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404179", "story_v_side_new_1103404.awb")
					end

					arg_716_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404179", "story_v_side_new_1103404.awb")
				end

				arg_716_1:RecordContent(arg_716_1.text_.text)
			end

			local var_719_10 = math.max(var_719_1, arg_716_1.talkMaxDuration)

			if var_719_0 <= arg_716_1.time_ and arg_716_1.time_ < var_719_0 + var_719_10 then
				arg_716_1.typewritter.percent = (arg_716_1.time_ - var_719_0) / var_719_10

				arg_716_1.typewritter:SetDirty()
			end

			if arg_716_1.time_ >= var_719_0 + var_719_10 and arg_716_1.time_ < var_719_0 + var_719_10 + arg_719_0 then
				arg_716_1.typewritter.percent = 1

				arg_716_1.typewritter:SetDirty()
				arg_716_1:ShowNextGo(true)
			end
		end

		arg_716_1.nodeConfigList_ = {}

		arg_716_1:InitPlayNodeList()
	end,
	Play1103404180 = function(arg_720_0, arg_720_1)
		arg_720_1.time_ = 0
		arg_720_1.frameCnt_ = 0
		arg_720_1.state_ = "playing"
		arg_720_1.curTalkId_ = 1103404180
		arg_720_1.duration_ = 5

		SetActive(arg_720_1.tipsGo_, false)

		function arg_720_1.onSingleLineFinish_()
			arg_720_1.onSingleLineUpdate_ = nil
			arg_720_1.onSingleLineFinish_ = nil
			arg_720_1.state_ = "waiting"
		end

		function arg_720_1.playNext_(arg_722_0)
			if arg_722_0 == 1 then
				arg_720_0:Play1103404181(arg_720_1)
			end
		end

		function arg_720_1.onSingleLineUpdate_(arg_723_0)
			local var_723_0 = 1.05

			if var_723_0 < arg_720_1.time_ and arg_720_1.time_ <= var_723_0 + arg_723_0 then
				local var_723_1 = manager.ui.mainCamera.transform.localPosition
				local var_723_2 = Vector3.New(0, 0, 10) + Vector3.New(var_723_1.x, var_723_1.y, 0)
				local var_723_3 = arg_720_1.bgs_.R3401

				var_723_3.transform.localPosition = var_723_2
				var_723_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_723_4 = var_723_3:GetComponent("SpriteRenderer")

				if var_723_4 and var_723_4.sprite then
					local var_723_5 = (var_723_3.transform.localPosition - var_723_1).z
					local var_723_6 = manager.ui.mainCameraCom_
					local var_723_7 = 2 * var_723_5 * Mathf.Tan(var_723_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_723_8 = var_723_7 * var_723_6.aspect
					local var_723_9 = var_723_4.sprite.bounds.size.x
					local var_723_10 = var_723_4.sprite.bounds.size.y
					local var_723_11 = var_723_8 / var_723_9
					local var_723_12 = var_723_7 / var_723_10
					local var_723_13 = var_723_12 < var_723_11 and var_723_11 or var_723_12

					var_723_3.transform.localScale = Vector3.New(var_723_13, var_723_13, 0)
				end

				for iter_723_0, iter_723_1 in pairs(arg_720_1.bgs_) do
					if iter_723_0 ~= "R3401" then
						iter_723_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_723_14 = 1.06666666666667

			if var_723_14 < arg_720_1.time_ and arg_720_1.time_ <= var_723_14 + arg_723_0 then
				local var_723_15 = manager.ui.mainCamera.transform.localPosition
				local var_723_16 = Vector3.New(0, 0, 10) + Vector3.New(var_723_15.x, var_723_15.y, 0)
				local var_723_17 = arg_720_1.bgs_.R3401

				var_723_17.transform.localPosition = var_723_16
				var_723_17.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_723_18 = var_723_17:GetComponent("SpriteRenderer")

				if var_723_18 and var_723_18.sprite then
					local var_723_19 = (var_723_17.transform.localPosition - var_723_15).z
					local var_723_20 = manager.ui.mainCameraCom_
					local var_723_21 = 2 * var_723_19 * Mathf.Tan(var_723_20.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_723_22 = var_723_21 * var_723_20.aspect
					local var_723_23 = var_723_18.sprite.bounds.size.x
					local var_723_24 = var_723_18.sprite.bounds.size.y
					local var_723_25 = var_723_22 / var_723_23
					local var_723_26 = var_723_21 / var_723_24
					local var_723_27 = var_723_26 < var_723_25 and var_723_25 or var_723_26

					var_723_17.transform.localScale = Vector3.New(var_723_27, var_723_27, 0)
				end

				for iter_723_2, iter_723_3 in pairs(arg_720_1.bgs_) do
					if iter_723_2 ~= "R3401" then
						iter_723_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_723_28 = arg_720_1.actors_["1034ui_story"]
			local var_723_29 = 0

			if var_723_29 < arg_720_1.time_ and arg_720_1.time_ <= var_723_29 + arg_723_0 and not isNil(var_723_28) and arg_720_1.var_.characterEffect1034ui_story == nil then
				arg_720_1.var_.characterEffect1034ui_story = var_723_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_723_30 = 0.200000002980232

			if var_723_29 <= arg_720_1.time_ and arg_720_1.time_ < var_723_29 + var_723_30 and not isNil(var_723_28) then
				local var_723_31 = (arg_720_1.time_ - var_723_29) / var_723_30

				if arg_720_1.var_.characterEffect1034ui_story and not isNil(var_723_28) then
					local var_723_32 = Mathf.Lerp(0, 0.5, var_723_31)

					arg_720_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_720_1.var_.characterEffect1034ui_story.fillRatio = var_723_32
				end
			end

			if arg_720_1.time_ >= var_723_29 + var_723_30 and arg_720_1.time_ < var_723_29 + var_723_30 + arg_723_0 and not isNil(var_723_28) and arg_720_1.var_.characterEffect1034ui_story then
				local var_723_33 = 0.5

				arg_720_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_720_1.var_.characterEffect1034ui_story.fillRatio = var_723_33
			end

			local var_723_34 = 0

			if var_723_34 < arg_720_1.time_ and arg_720_1.time_ <= var_723_34 + arg_723_0 then
				arg_720_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034actionlink/1034action427")
			end

			local var_723_35 = 0

			if var_723_35 < arg_720_1.time_ and arg_720_1.time_ <= var_723_35 + arg_723_0 then
				arg_720_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_723_36 = 0

			if var_723_36 < arg_720_1.time_ and arg_720_1.time_ <= var_723_36 + arg_723_0 then
				arg_720_1.mask_.enabled = true
				arg_720_1.mask_.raycastTarget = true

				arg_720_1:SetGaussion(false)
			end

			local var_723_37 = 0.933333333333333

			if var_723_36 <= arg_720_1.time_ and arg_720_1.time_ < var_723_36 + var_723_37 then
				local var_723_38 = (arg_720_1.time_ - var_723_36) / var_723_37
				local var_723_39 = Color.New(0, 0, 0)

				var_723_39.a = Mathf.Lerp(0, 1, var_723_38)
				arg_720_1.mask_.color = var_723_39
			end

			if arg_720_1.time_ >= var_723_36 + var_723_37 and arg_720_1.time_ < var_723_36 + var_723_37 + arg_723_0 then
				local var_723_40 = Color.New(0, 0, 0)

				var_723_40.a = 1
				arg_720_1.mask_.color = var_723_40
			end

			local var_723_41 = 1.06666666666667

			if var_723_41 < arg_720_1.time_ and arg_720_1.time_ <= var_723_41 + arg_723_0 then
				arg_720_1.mask_.enabled = true
				arg_720_1.mask_.raycastTarget = true

				arg_720_1:SetGaussion(false)
			end

			local var_723_42 = 0.933333333333333

			if var_723_41 <= arg_720_1.time_ and arg_720_1.time_ < var_723_41 + var_723_42 then
				local var_723_43 = (arg_720_1.time_ - var_723_41) / var_723_42
				local var_723_44 = Color.New(0, 0, 0)

				var_723_44.a = Mathf.Lerp(1, 0, var_723_43)
				arg_720_1.mask_.color = var_723_44
			end

			if arg_720_1.time_ >= var_723_41 + var_723_42 and arg_720_1.time_ < var_723_41 + var_723_42 + arg_723_0 then
				local var_723_45 = Color.New(0, 0, 0)
				local var_723_46 = 0

				arg_720_1.mask_.enabled = false
				var_723_45.a = var_723_46
				arg_720_1.mask_.color = var_723_45
			end

			local var_723_47 = arg_720_1.bgs_.R3401a.transform
			local var_723_48 = 0

			if var_723_48 < arg_720_1.time_ and arg_720_1.time_ <= var_723_48 + arg_723_0 then
				arg_720_1.var_.moveOldPosR3401a = var_723_47.localPosition
			end

			local var_723_49 = 0.933333333333333

			if var_723_48 <= arg_720_1.time_ and arg_720_1.time_ < var_723_48 + var_723_49 then
				local var_723_50 = (arg_720_1.time_ - var_723_48) / var_723_49
				local var_723_51 = Vector3.New(0, 1, 9.5)

				var_723_47.localPosition = Vector3.Lerp(arg_720_1.var_.moveOldPosR3401a, var_723_51, var_723_50)
			end

			if arg_720_1.time_ >= var_723_48 + var_723_49 and arg_720_1.time_ < var_723_48 + var_723_49 + arg_723_0 then
				var_723_47.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_723_52 = arg_720_1.bgs_.R3401.transform
			local var_723_53 = 1.05

			if var_723_53 < arg_720_1.time_ and arg_720_1.time_ <= var_723_53 + arg_723_0 then
				arg_720_1.var_.moveOldPosR3401 = var_723_52.localPosition
			end

			local var_723_54 = 0.001

			if var_723_53 <= arg_720_1.time_ and arg_720_1.time_ < var_723_53 + var_723_54 then
				local var_723_55 = (arg_720_1.time_ - var_723_53) / var_723_54
				local var_723_56 = Vector3.New(0, 1, 8)

				var_723_52.localPosition = Vector3.Lerp(arg_720_1.var_.moveOldPosR3401, var_723_56, var_723_55)
			end

			if arg_720_1.time_ >= var_723_53 + var_723_54 and arg_720_1.time_ < var_723_53 + var_723_54 + arg_723_0 then
				var_723_52.localPosition = Vector3.New(0, 1, 8)
			end

			local var_723_57 = arg_720_1.bgs_.R3401.transform
			local var_723_58 = 1.06666666666667

			if var_723_58 < arg_720_1.time_ and arg_720_1.time_ <= var_723_58 + arg_723_0 then
				arg_720_1.var_.moveOldPosR3401 = var_723_57.localPosition
			end

			local var_723_59 = 0.933333333333333

			if var_723_58 <= arg_720_1.time_ and arg_720_1.time_ < var_723_58 + var_723_59 then
				local var_723_60 = (arg_720_1.time_ - var_723_58) / var_723_59
				local var_723_61 = Vector3.New(0, 1, 10)

				var_723_57.localPosition = Vector3.Lerp(arg_720_1.var_.moveOldPosR3401, var_723_61, var_723_60)
			end

			if arg_720_1.time_ >= var_723_58 + var_723_59 and arg_720_1.time_ < var_723_58 + var_723_59 + arg_723_0 then
				var_723_57.localPosition = Vector3.New(0, 1, 10)
			end

			local var_723_62 = 0.533333333333333

			if var_723_62 < arg_720_1.time_ and arg_720_1.time_ <= var_723_62 + arg_723_0 then
				arg_720_1.allBtn_.enabled = false
			end

			local var_723_63 = 1

			if arg_720_1.time_ >= var_723_62 + var_723_63 and arg_720_1.time_ < var_723_62 + var_723_63 + arg_723_0 then
				arg_720_1.allBtn_.enabled = true
			end

			local var_723_64 = 0
			local var_723_65 = 1.625

			if var_723_64 < arg_720_1.time_ and arg_720_1.time_ <= var_723_64 + arg_723_0 then
				arg_720_1.talkMaxDuration = 0
				arg_720_1.dialogCg_.alpha = 1

				arg_720_1.dialog_:SetActive(true)
				SetActive(arg_720_1.leftNameGo_, false)

				arg_720_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_720_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_720_1:RecordName(arg_720_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_720_1.iconTrs_.gameObject, false)
				arg_720_1.callingController_:SetSelectedState("normal")

				local var_723_66 = arg_720_1:GetWordFromCfg(1103404180)
				local var_723_67 = arg_720_1:FormatText(var_723_66.content)

				arg_720_1.text_.text = var_723_67

				LuaForUtil.ClearLinePrefixSymbol(arg_720_1.text_)

				local var_723_68 = 65
				local var_723_69 = utf8.len(var_723_67)
				local var_723_70 = var_723_68 <= 0 and var_723_65 or var_723_65 * (var_723_69 / var_723_68)

				if var_723_70 > 0 and var_723_65 < var_723_70 then
					arg_720_1.talkMaxDuration = var_723_70

					if var_723_70 + var_723_64 > arg_720_1.duration_ then
						arg_720_1.duration_ = var_723_70 + var_723_64
					end
				end

				arg_720_1.text_.text = var_723_67
				arg_720_1.typewritter.percent = 0

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(false)
				arg_720_1:RecordContent(arg_720_1.text_.text)
			end

			local var_723_71 = math.max(var_723_65, arg_720_1.talkMaxDuration)

			if var_723_64 <= arg_720_1.time_ and arg_720_1.time_ < var_723_64 + var_723_71 then
				arg_720_1.typewritter.percent = (arg_720_1.time_ - var_723_64) / var_723_71

				arg_720_1.typewritter:SetDirty()
			end

			if arg_720_1.time_ >= var_723_64 + var_723_71 and arg_720_1.time_ < var_723_64 + var_723_71 + arg_723_0 then
				arg_720_1.typewritter.percent = 1

				arg_720_1.typewritter:SetDirty()
				arg_720_1:ShowNextGo(true)
			end
		end

		arg_720_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "R3401a",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.933333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.linear
				}
			},
			{
				assetPath = "",
				actorName = "R3401",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666668,
				className = "StoryMoveNode",
				startTime = 1.05,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "R3401",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.933333333333333,
				className = "StoryMoveNode",
				startTime = 1.06666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_720_1:InitPlayNodeList()
	end,
	Play1103404181 = function(arg_724_0, arg_724_1)
		arg_724_1.time_ = 0
		arg_724_1.frameCnt_ = 0
		arg_724_1.state_ = "playing"
		arg_724_1.curTalkId_ = 1103404181
		arg_724_1.duration_ = 6.13

		SetActive(arg_724_1.tipsGo_, false)

		function arg_724_1.onSingleLineFinish_()
			arg_724_1.onSingleLineUpdate_ = nil
			arg_724_1.onSingleLineFinish_ = nil
			arg_724_1.state_ = "waiting"
		end

		function arg_724_1.playNext_(arg_726_0)
			if arg_726_0 == 1 then
				arg_724_0:Play1103404182(arg_724_1)
			end
		end

		function arg_724_1.onSingleLineUpdate_(arg_727_0)
			local var_727_0 = arg_724_1.actors_["1034ui_story"]
			local var_727_1 = 0

			if var_727_1 < arg_724_1.time_ and arg_724_1.time_ <= var_727_1 + arg_727_0 and not isNil(var_727_0) and arg_724_1.var_.characterEffect1034ui_story == nil then
				arg_724_1.var_.characterEffect1034ui_story = var_727_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_727_2 = 0.200000002980232

			if var_727_1 <= arg_724_1.time_ and arg_724_1.time_ < var_727_1 + var_727_2 and not isNil(var_727_0) then
				local var_727_3 = (arg_724_1.time_ - var_727_1) / var_727_2

				if arg_724_1.var_.characterEffect1034ui_story and not isNil(var_727_0) then
					arg_724_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_724_1.time_ >= var_727_1 + var_727_2 and arg_724_1.time_ < var_727_1 + var_727_2 + arg_727_0 and not isNil(var_727_0) and arg_724_1.var_.characterEffect1034ui_story then
				arg_724_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_727_4 = 0
			local var_727_5 = 0.7

			if var_727_4 < arg_724_1.time_ and arg_724_1.time_ <= var_727_4 + arg_727_0 then
				arg_724_1.talkMaxDuration = 0
				arg_724_1.dialogCg_.alpha = 1

				arg_724_1.dialog_:SetActive(true)
				SetActive(arg_724_1.leftNameGo_, true)

				local var_727_6 = arg_724_1:FormatText(StoryNameCfg[1109].name)

				arg_724_1.leftNameTxt_.text = var_727_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_724_1.leftNameTxt_.transform)

				arg_724_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_724_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_724_1:RecordName(arg_724_1.leftNameTxt_.text)
				SetActive(arg_724_1.iconTrs_.gameObject, false)
				arg_724_1.callingController_:SetSelectedState("normal")

				local var_727_7 = arg_724_1:GetWordFromCfg(1103404181)
				local var_727_8 = arg_724_1:FormatText(var_727_7.content)

				arg_724_1.text_.text = var_727_8

				LuaForUtil.ClearLinePrefixSymbol(arg_724_1.text_)

				local var_727_9 = 28
				local var_727_10 = utf8.len(var_727_8)
				local var_727_11 = var_727_9 <= 0 and var_727_5 or var_727_5 * (var_727_10 / var_727_9)

				if var_727_11 > 0 and var_727_5 < var_727_11 then
					arg_724_1.talkMaxDuration = var_727_11

					if var_727_11 + var_727_4 > arg_724_1.duration_ then
						arg_724_1.duration_ = var_727_11 + var_727_4
					end
				end

				arg_724_1.text_.text = var_727_8
				arg_724_1.typewritter.percent = 0

				arg_724_1.typewritter:SetDirty()
				arg_724_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404181", "story_v_side_new_1103404.awb") ~= 0 then
					local var_727_12 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404181", "story_v_side_new_1103404.awb") / 1000

					if var_727_12 + var_727_4 > arg_724_1.duration_ then
						arg_724_1.duration_ = var_727_12 + var_727_4
					end

					if var_727_7.prefab_name ~= "" and arg_724_1.actors_[var_727_7.prefab_name] ~= nil then
						local var_727_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_724_1.actors_[var_727_7.prefab_name].transform, "story_v_side_new_1103404", "1103404181", "story_v_side_new_1103404.awb")

						arg_724_1:RecordAudio("1103404181", var_727_13)
						arg_724_1:RecordAudio("1103404181", var_727_13)
					else
						arg_724_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404181", "story_v_side_new_1103404.awb")
					end

					arg_724_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404181", "story_v_side_new_1103404.awb")
				end

				arg_724_1:RecordContent(arg_724_1.text_.text)
			end

			local var_727_14 = math.max(var_727_5, arg_724_1.talkMaxDuration)

			if var_727_4 <= arg_724_1.time_ and arg_724_1.time_ < var_727_4 + var_727_14 then
				arg_724_1.typewritter.percent = (arg_724_1.time_ - var_727_4) / var_727_14

				arg_724_1.typewritter:SetDirty()
			end

			if arg_724_1.time_ >= var_727_4 + var_727_14 and arg_724_1.time_ < var_727_4 + var_727_14 + arg_727_0 then
				arg_724_1.typewritter.percent = 1

				arg_724_1.typewritter:SetDirty()
				arg_724_1:ShowNextGo(true)
			end
		end

		arg_724_1.nodeConfigList_ = {}

		arg_724_1:InitPlayNodeList()
	end,
	Play1103404182 = function(arg_728_0, arg_728_1)
		arg_728_1.time_ = 0
		arg_728_1.frameCnt_ = 0
		arg_728_1.state_ = "playing"
		arg_728_1.curTalkId_ = 1103404182
		arg_728_1.duration_ = 5

		SetActive(arg_728_1.tipsGo_, false)

		function arg_728_1.onSingleLineFinish_()
			arg_728_1.onSingleLineUpdate_ = nil
			arg_728_1.onSingleLineFinish_ = nil
			arg_728_1.state_ = "waiting"
		end

		function arg_728_1.playNext_(arg_730_0)
			if arg_730_0 == 1 then
				arg_728_0:Play1103404183(arg_728_1)
			end
		end

		function arg_728_1.onSingleLineUpdate_(arg_731_0)
			local var_731_0 = arg_728_1.actors_["1034ui_story"]
			local var_731_1 = 0

			if var_731_1 < arg_728_1.time_ and arg_728_1.time_ <= var_731_1 + arg_731_0 and not isNil(var_731_0) and arg_728_1.var_.characterEffect1034ui_story == nil then
				arg_728_1.var_.characterEffect1034ui_story = var_731_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_731_2 = 0.200000002980232

			if var_731_1 <= arg_728_1.time_ and arg_728_1.time_ < var_731_1 + var_731_2 and not isNil(var_731_0) then
				local var_731_3 = (arg_728_1.time_ - var_731_1) / var_731_2

				if arg_728_1.var_.characterEffect1034ui_story and not isNil(var_731_0) then
					local var_731_4 = Mathf.Lerp(0, 0.5, var_731_3)

					arg_728_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_728_1.var_.characterEffect1034ui_story.fillRatio = var_731_4
				end
			end

			if arg_728_1.time_ >= var_731_1 + var_731_2 and arg_728_1.time_ < var_731_1 + var_731_2 + arg_731_0 and not isNil(var_731_0) and arg_728_1.var_.characterEffect1034ui_story then
				local var_731_5 = 0.5

				arg_728_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_728_1.var_.characterEffect1034ui_story.fillRatio = var_731_5
			end

			local var_731_6 = 0
			local var_731_7 = 0.275

			if var_731_6 < arg_728_1.time_ and arg_728_1.time_ <= var_731_6 + arg_731_0 then
				arg_728_1.talkMaxDuration = 0
				arg_728_1.dialogCg_.alpha = 1

				arg_728_1.dialog_:SetActive(true)
				SetActive(arg_728_1.leftNameGo_, true)

				local var_731_8 = arg_728_1:FormatText(StoryNameCfg[7].name)

				arg_728_1.leftNameTxt_.text = var_731_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_728_1.leftNameTxt_.transform)

				arg_728_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_728_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_728_1:RecordName(arg_728_1.leftNameTxt_.text)
				SetActive(arg_728_1.iconTrs_.gameObject, true)
				arg_728_1.iconController_:SetSelectedState("hero")

				arg_728_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_728_1.callingController_:SetSelectedState("normal")

				arg_728_1.keyicon_.color = Color.New(1, 1, 1)
				arg_728_1.icon_.color = Color.New(1, 1, 1)

				local var_731_9 = arg_728_1:GetWordFromCfg(1103404182)
				local var_731_10 = arg_728_1:FormatText(var_731_9.content)

				arg_728_1.text_.text = var_731_10

				LuaForUtil.ClearLinePrefixSymbol(arg_728_1.text_)

				local var_731_11 = 11
				local var_731_12 = utf8.len(var_731_10)
				local var_731_13 = var_731_11 <= 0 and var_731_7 or var_731_7 * (var_731_12 / var_731_11)

				if var_731_13 > 0 and var_731_7 < var_731_13 then
					arg_728_1.talkMaxDuration = var_731_13

					if var_731_13 + var_731_6 > arg_728_1.duration_ then
						arg_728_1.duration_ = var_731_13 + var_731_6
					end
				end

				arg_728_1.text_.text = var_731_10
				arg_728_1.typewritter.percent = 0

				arg_728_1.typewritter:SetDirty()
				arg_728_1:ShowNextGo(false)
				arg_728_1:RecordContent(arg_728_1.text_.text)
			end

			local var_731_14 = math.max(var_731_7, arg_728_1.talkMaxDuration)

			if var_731_6 <= arg_728_1.time_ and arg_728_1.time_ < var_731_6 + var_731_14 then
				arg_728_1.typewritter.percent = (arg_728_1.time_ - var_731_6) / var_731_14

				arg_728_1.typewritter:SetDirty()
			end

			if arg_728_1.time_ >= var_731_6 + var_731_14 and arg_728_1.time_ < var_731_6 + var_731_14 + arg_731_0 then
				arg_728_1.typewritter.percent = 1

				arg_728_1.typewritter:SetDirty()
				arg_728_1:ShowNextGo(true)
			end
		end

		arg_728_1.nodeConfigList_ = {}

		arg_728_1:InitPlayNodeList()
	end,
	Play1103404183 = function(arg_732_0, arg_732_1)
		arg_732_1.time_ = 0
		arg_732_1.frameCnt_ = 0
		arg_732_1.state_ = "playing"
		arg_732_1.curTalkId_ = 1103404183
		arg_732_1.duration_ = 5.03

		SetActive(arg_732_1.tipsGo_, false)

		function arg_732_1.onSingleLineFinish_()
			arg_732_1.onSingleLineUpdate_ = nil
			arg_732_1.onSingleLineFinish_ = nil
			arg_732_1.state_ = "waiting"
		end

		function arg_732_1.playNext_(arg_734_0)
			if arg_734_0 == 1 then
				arg_732_0:Play1103404184(arg_732_1)
			end
		end

		function arg_732_1.onSingleLineUpdate_(arg_735_0)
			local var_735_0 = arg_732_1.actors_["1034ui_story"]
			local var_735_1 = 0

			if var_735_1 < arg_732_1.time_ and arg_732_1.time_ <= var_735_1 + arg_735_0 and not isNil(var_735_0) and arg_732_1.var_.characterEffect1034ui_story == nil then
				arg_732_1.var_.characterEffect1034ui_story = var_735_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_735_2 = 0.200000002980232

			if var_735_1 <= arg_732_1.time_ and arg_732_1.time_ < var_735_1 + var_735_2 and not isNil(var_735_0) then
				local var_735_3 = (arg_732_1.time_ - var_735_1) / var_735_2

				if arg_732_1.var_.characterEffect1034ui_story and not isNil(var_735_0) then
					arg_732_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_732_1.time_ >= var_735_1 + var_735_2 and arg_732_1.time_ < var_735_1 + var_735_2 + arg_735_0 and not isNil(var_735_0) and arg_732_1.var_.characterEffect1034ui_story then
				arg_732_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_735_4 = 0
			local var_735_5 = 0.475

			if var_735_4 < arg_732_1.time_ and arg_732_1.time_ <= var_735_4 + arg_735_0 then
				arg_732_1.talkMaxDuration = 0
				arg_732_1.dialogCg_.alpha = 1

				arg_732_1.dialog_:SetActive(true)
				SetActive(arg_732_1.leftNameGo_, true)

				local var_735_6 = arg_732_1:FormatText(StoryNameCfg[1109].name)

				arg_732_1.leftNameTxt_.text = var_735_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_732_1.leftNameTxt_.transform)

				arg_732_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_732_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_732_1:RecordName(arg_732_1.leftNameTxt_.text)
				SetActive(arg_732_1.iconTrs_.gameObject, false)
				arg_732_1.callingController_:SetSelectedState("normal")

				local var_735_7 = arg_732_1:GetWordFromCfg(1103404183)
				local var_735_8 = arg_732_1:FormatText(var_735_7.content)

				arg_732_1.text_.text = var_735_8

				LuaForUtil.ClearLinePrefixSymbol(arg_732_1.text_)

				local var_735_9 = 19
				local var_735_10 = utf8.len(var_735_8)
				local var_735_11 = var_735_9 <= 0 and var_735_5 or var_735_5 * (var_735_10 / var_735_9)

				if var_735_11 > 0 and var_735_5 < var_735_11 then
					arg_732_1.talkMaxDuration = var_735_11

					if var_735_11 + var_735_4 > arg_732_1.duration_ then
						arg_732_1.duration_ = var_735_11 + var_735_4
					end
				end

				arg_732_1.text_.text = var_735_8
				arg_732_1.typewritter.percent = 0

				arg_732_1.typewritter:SetDirty()
				arg_732_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404183", "story_v_side_new_1103404.awb") ~= 0 then
					local var_735_12 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404183", "story_v_side_new_1103404.awb") / 1000

					if var_735_12 + var_735_4 > arg_732_1.duration_ then
						arg_732_1.duration_ = var_735_12 + var_735_4
					end

					if var_735_7.prefab_name ~= "" and arg_732_1.actors_[var_735_7.prefab_name] ~= nil then
						local var_735_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_732_1.actors_[var_735_7.prefab_name].transform, "story_v_side_new_1103404", "1103404183", "story_v_side_new_1103404.awb")

						arg_732_1:RecordAudio("1103404183", var_735_13)
						arg_732_1:RecordAudio("1103404183", var_735_13)
					else
						arg_732_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404183", "story_v_side_new_1103404.awb")
					end

					arg_732_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404183", "story_v_side_new_1103404.awb")
				end

				arg_732_1:RecordContent(arg_732_1.text_.text)
			end

			local var_735_14 = math.max(var_735_5, arg_732_1.talkMaxDuration)

			if var_735_4 <= arg_732_1.time_ and arg_732_1.time_ < var_735_4 + var_735_14 then
				arg_732_1.typewritter.percent = (arg_732_1.time_ - var_735_4) / var_735_14

				arg_732_1.typewritter:SetDirty()
			end

			if arg_732_1.time_ >= var_735_4 + var_735_14 and arg_732_1.time_ < var_735_4 + var_735_14 + arg_735_0 then
				arg_732_1.typewritter.percent = 1

				arg_732_1.typewritter:SetDirty()
				arg_732_1:ShowNextGo(true)
			end
		end

		arg_732_1.nodeConfigList_ = {}

		arg_732_1:InitPlayNodeList()
	end,
	Play1103404184 = function(arg_736_0, arg_736_1)
		arg_736_1.time_ = 0
		arg_736_1.frameCnt_ = 0
		arg_736_1.state_ = "playing"
		arg_736_1.curTalkId_ = 1103404184
		arg_736_1.duration_ = 5.13

		SetActive(arg_736_1.tipsGo_, false)

		function arg_736_1.onSingleLineFinish_()
			arg_736_1.onSingleLineUpdate_ = nil
			arg_736_1.onSingleLineFinish_ = nil
			arg_736_1.state_ = "waiting"
		end

		function arg_736_1.playNext_(arg_738_0)
			if arg_738_0 == 1 then
				arg_736_0:Play1103404185(arg_736_1)
			end
		end

		function arg_736_1.onSingleLineUpdate_(arg_739_0)
			local var_739_0 = 0
			local var_739_1 = 0.475

			if var_739_0 < arg_736_1.time_ and arg_736_1.time_ <= var_739_0 + arg_739_0 then
				arg_736_1.talkMaxDuration = 0
				arg_736_1.dialogCg_.alpha = 1

				arg_736_1.dialog_:SetActive(true)
				SetActive(arg_736_1.leftNameGo_, true)

				local var_739_2 = arg_736_1:FormatText(StoryNameCfg[1109].name)

				arg_736_1.leftNameTxt_.text = var_739_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_736_1.leftNameTxt_.transform)

				arg_736_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_736_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_736_1:RecordName(arg_736_1.leftNameTxt_.text)
				SetActive(arg_736_1.iconTrs_.gameObject, false)
				arg_736_1.callingController_:SetSelectedState("normal")

				local var_739_3 = arg_736_1:GetWordFromCfg(1103404184)
				local var_739_4 = arg_736_1:FormatText(var_739_3.content)

				arg_736_1.text_.text = var_739_4

				LuaForUtil.ClearLinePrefixSymbol(arg_736_1.text_)

				local var_739_5 = 19
				local var_739_6 = utf8.len(var_739_4)
				local var_739_7 = var_739_5 <= 0 and var_739_1 or var_739_1 * (var_739_6 / var_739_5)

				if var_739_7 > 0 and var_739_1 < var_739_7 then
					arg_736_1.talkMaxDuration = var_739_7

					if var_739_7 + var_739_0 > arg_736_1.duration_ then
						arg_736_1.duration_ = var_739_7 + var_739_0
					end
				end

				arg_736_1.text_.text = var_739_4
				arg_736_1.typewritter.percent = 0

				arg_736_1.typewritter:SetDirty()
				arg_736_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404184", "story_v_side_new_1103404.awb") ~= 0 then
					local var_739_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404184", "story_v_side_new_1103404.awb") / 1000

					if var_739_8 + var_739_0 > arg_736_1.duration_ then
						arg_736_1.duration_ = var_739_8 + var_739_0
					end

					if var_739_3.prefab_name ~= "" and arg_736_1.actors_[var_739_3.prefab_name] ~= nil then
						local var_739_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_736_1.actors_[var_739_3.prefab_name].transform, "story_v_side_new_1103404", "1103404184", "story_v_side_new_1103404.awb")

						arg_736_1:RecordAudio("1103404184", var_739_9)
						arg_736_1:RecordAudio("1103404184", var_739_9)
					else
						arg_736_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404184", "story_v_side_new_1103404.awb")
					end

					arg_736_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404184", "story_v_side_new_1103404.awb")
				end

				arg_736_1:RecordContent(arg_736_1.text_.text)
			end

			local var_739_10 = math.max(var_739_1, arg_736_1.talkMaxDuration)

			if var_739_0 <= arg_736_1.time_ and arg_736_1.time_ < var_739_0 + var_739_10 then
				arg_736_1.typewritter.percent = (arg_736_1.time_ - var_739_0) / var_739_10

				arg_736_1.typewritter:SetDirty()
			end

			if arg_736_1.time_ >= var_739_0 + var_739_10 and arg_736_1.time_ < var_739_0 + var_739_10 + arg_739_0 then
				arg_736_1.typewritter.percent = 1

				arg_736_1.typewritter:SetDirty()
				arg_736_1:ShowNextGo(true)
			end
		end

		arg_736_1.nodeConfigList_ = {}

		arg_736_1:InitPlayNodeList()
	end,
	Play1103404185 = function(arg_740_0, arg_740_1)
		arg_740_1.time_ = 0
		arg_740_1.frameCnt_ = 0
		arg_740_1.state_ = "playing"
		arg_740_1.curTalkId_ = 1103404185
		arg_740_1.duration_ = 4.67

		SetActive(arg_740_1.tipsGo_, false)

		function arg_740_1.onSingleLineFinish_()
			arg_740_1.onSingleLineUpdate_ = nil
			arg_740_1.onSingleLineFinish_ = nil
			arg_740_1.state_ = "waiting"
		end

		function arg_740_1.playNext_(arg_742_0)
			if arg_742_0 == 1 then
				arg_740_0:Play1103404186(arg_740_1)
			end
		end

		function arg_740_1.onSingleLineUpdate_(arg_743_0)
			local var_743_0 = 0
			local var_743_1 = 0.55

			if var_743_0 < arg_740_1.time_ and arg_740_1.time_ <= var_743_0 + arg_743_0 then
				arg_740_1.talkMaxDuration = 0
				arg_740_1.dialogCg_.alpha = 1

				arg_740_1.dialog_:SetActive(true)
				SetActive(arg_740_1.leftNameGo_, true)

				local var_743_2 = arg_740_1:FormatText(StoryNameCfg[1109].name)

				arg_740_1.leftNameTxt_.text = var_743_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_740_1.leftNameTxt_.transform)

				arg_740_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_740_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_740_1:RecordName(arg_740_1.leftNameTxt_.text)
				SetActive(arg_740_1.iconTrs_.gameObject, false)
				arg_740_1.callingController_:SetSelectedState("normal")

				local var_743_3 = arg_740_1:GetWordFromCfg(1103404185)
				local var_743_4 = arg_740_1:FormatText(var_743_3.content)

				arg_740_1.text_.text = var_743_4

				LuaForUtil.ClearLinePrefixSymbol(arg_740_1.text_)

				local var_743_5 = 22
				local var_743_6 = utf8.len(var_743_4)
				local var_743_7 = var_743_5 <= 0 and var_743_1 or var_743_1 * (var_743_6 / var_743_5)

				if var_743_7 > 0 and var_743_1 < var_743_7 then
					arg_740_1.talkMaxDuration = var_743_7

					if var_743_7 + var_743_0 > arg_740_1.duration_ then
						arg_740_1.duration_ = var_743_7 + var_743_0
					end
				end

				arg_740_1.text_.text = var_743_4
				arg_740_1.typewritter.percent = 0

				arg_740_1.typewritter:SetDirty()
				arg_740_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404185", "story_v_side_new_1103404.awb") ~= 0 then
					local var_743_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404185", "story_v_side_new_1103404.awb") / 1000

					if var_743_8 + var_743_0 > arg_740_1.duration_ then
						arg_740_1.duration_ = var_743_8 + var_743_0
					end

					if var_743_3.prefab_name ~= "" and arg_740_1.actors_[var_743_3.prefab_name] ~= nil then
						local var_743_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_740_1.actors_[var_743_3.prefab_name].transform, "story_v_side_new_1103404", "1103404185", "story_v_side_new_1103404.awb")

						arg_740_1:RecordAudio("1103404185", var_743_9)
						arg_740_1:RecordAudio("1103404185", var_743_9)
					else
						arg_740_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404185", "story_v_side_new_1103404.awb")
					end

					arg_740_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404185", "story_v_side_new_1103404.awb")
				end

				arg_740_1:RecordContent(arg_740_1.text_.text)
			end

			local var_743_10 = math.max(var_743_1, arg_740_1.talkMaxDuration)

			if var_743_0 <= arg_740_1.time_ and arg_740_1.time_ < var_743_0 + var_743_10 then
				arg_740_1.typewritter.percent = (arg_740_1.time_ - var_743_0) / var_743_10

				arg_740_1.typewritter:SetDirty()
			end

			if arg_740_1.time_ >= var_743_0 + var_743_10 and arg_740_1.time_ < var_743_0 + var_743_10 + arg_743_0 then
				arg_740_1.typewritter.percent = 1

				arg_740_1.typewritter:SetDirty()
				arg_740_1:ShowNextGo(true)
			end
		end

		arg_740_1.nodeConfigList_ = {}

		arg_740_1:InitPlayNodeList()
	end,
	Play1103404186 = function(arg_744_0, arg_744_1)
		arg_744_1.time_ = 0
		arg_744_1.frameCnt_ = 0
		arg_744_1.state_ = "playing"
		arg_744_1.curTalkId_ = 1103404186
		arg_744_1.duration_ = 5

		SetActive(arg_744_1.tipsGo_, false)

		function arg_744_1.onSingleLineFinish_()
			arg_744_1.onSingleLineUpdate_ = nil
			arg_744_1.onSingleLineFinish_ = nil
			arg_744_1.state_ = "waiting"
		end

		function arg_744_1.playNext_(arg_746_0)
			if arg_746_0 == 1 then
				arg_744_0:Play1103404187(arg_744_1)
			end
		end

		function arg_744_1.onSingleLineUpdate_(arg_747_0)
			local var_747_0 = arg_744_1.actors_["1034ui_story"]
			local var_747_1 = 0

			if var_747_1 < arg_744_1.time_ and arg_744_1.time_ <= var_747_1 + arg_747_0 and not isNil(var_747_0) and arg_744_1.var_.characterEffect1034ui_story == nil then
				arg_744_1.var_.characterEffect1034ui_story = var_747_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_747_2 = 0.200000002980232

			if var_747_1 <= arg_744_1.time_ and arg_744_1.time_ < var_747_1 + var_747_2 and not isNil(var_747_0) then
				local var_747_3 = (arg_744_1.time_ - var_747_1) / var_747_2

				if arg_744_1.var_.characterEffect1034ui_story and not isNil(var_747_0) then
					local var_747_4 = Mathf.Lerp(0, 0.5, var_747_3)

					arg_744_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_744_1.var_.characterEffect1034ui_story.fillRatio = var_747_4
				end
			end

			if arg_744_1.time_ >= var_747_1 + var_747_2 and arg_744_1.time_ < var_747_1 + var_747_2 + arg_747_0 and not isNil(var_747_0) and arg_744_1.var_.characterEffect1034ui_story then
				local var_747_5 = 0.5

				arg_744_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_744_1.var_.characterEffect1034ui_story.fillRatio = var_747_5
			end

			local var_747_6 = 0
			local var_747_7 = 0.475

			if var_747_6 < arg_744_1.time_ and arg_744_1.time_ <= var_747_6 + arg_747_0 then
				arg_744_1.talkMaxDuration = 0
				arg_744_1.dialogCg_.alpha = 1

				arg_744_1.dialog_:SetActive(true)
				SetActive(arg_744_1.leftNameGo_, true)

				local var_747_8 = arg_744_1:FormatText(StoryNameCfg[7].name)

				arg_744_1.leftNameTxt_.text = var_747_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_744_1.leftNameTxt_.transform)

				arg_744_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_744_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_744_1:RecordName(arg_744_1.leftNameTxt_.text)
				SetActive(arg_744_1.iconTrs_.gameObject, true)
				arg_744_1.iconController_:SetSelectedState("hero")

				arg_744_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_744_1.callingController_:SetSelectedState("normal")

				arg_744_1.keyicon_.color = Color.New(1, 1, 1)
				arg_744_1.icon_.color = Color.New(1, 1, 1)

				local var_747_9 = arg_744_1:GetWordFromCfg(1103404186)
				local var_747_10 = arg_744_1:FormatText(var_747_9.content)

				arg_744_1.text_.text = var_747_10

				LuaForUtil.ClearLinePrefixSymbol(arg_744_1.text_)

				local var_747_11 = 19
				local var_747_12 = utf8.len(var_747_10)
				local var_747_13 = var_747_11 <= 0 and var_747_7 or var_747_7 * (var_747_12 / var_747_11)

				if var_747_13 > 0 and var_747_7 < var_747_13 then
					arg_744_1.talkMaxDuration = var_747_13

					if var_747_13 + var_747_6 > arg_744_1.duration_ then
						arg_744_1.duration_ = var_747_13 + var_747_6
					end
				end

				arg_744_1.text_.text = var_747_10
				arg_744_1.typewritter.percent = 0

				arg_744_1.typewritter:SetDirty()
				arg_744_1:ShowNextGo(false)
				arg_744_1:RecordContent(arg_744_1.text_.text)
			end

			local var_747_14 = math.max(var_747_7, arg_744_1.talkMaxDuration)

			if var_747_6 <= arg_744_1.time_ and arg_744_1.time_ < var_747_6 + var_747_14 then
				arg_744_1.typewritter.percent = (arg_744_1.time_ - var_747_6) / var_747_14

				arg_744_1.typewritter:SetDirty()
			end

			if arg_744_1.time_ >= var_747_6 + var_747_14 and arg_744_1.time_ < var_747_6 + var_747_14 + arg_747_0 then
				arg_744_1.typewritter.percent = 1

				arg_744_1.typewritter:SetDirty()
				arg_744_1:ShowNextGo(true)
			end
		end

		arg_744_1.nodeConfigList_ = {}

		arg_744_1:InitPlayNodeList()
	end,
	Play1103404187 = function(arg_748_0, arg_748_1)
		arg_748_1.time_ = 0
		arg_748_1.frameCnt_ = 0
		arg_748_1.state_ = "playing"
		arg_748_1.curTalkId_ = 1103404187
		arg_748_1.duration_ = 6.63

		SetActive(arg_748_1.tipsGo_, false)

		function arg_748_1.onSingleLineFinish_()
			arg_748_1.onSingleLineUpdate_ = nil
			arg_748_1.onSingleLineFinish_ = nil
			arg_748_1.state_ = "waiting"
		end

		function arg_748_1.playNext_(arg_750_0)
			if arg_750_0 == 1 then
				arg_748_0:Play1103404188(arg_748_1)
			end
		end

		function arg_748_1.onSingleLineUpdate_(arg_751_0)
			local var_751_0 = arg_748_1.actors_["1034ui_story"]
			local var_751_1 = 0

			if var_751_1 < arg_748_1.time_ and arg_748_1.time_ <= var_751_1 + arg_751_0 and not isNil(var_751_0) and arg_748_1.var_.characterEffect1034ui_story == nil then
				arg_748_1.var_.characterEffect1034ui_story = var_751_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_751_2 = 0.200000002980232

			if var_751_1 <= arg_748_1.time_ and arg_748_1.time_ < var_751_1 + var_751_2 and not isNil(var_751_0) then
				local var_751_3 = (arg_748_1.time_ - var_751_1) / var_751_2

				if arg_748_1.var_.characterEffect1034ui_story and not isNil(var_751_0) then
					arg_748_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_748_1.time_ >= var_751_1 + var_751_2 and arg_748_1.time_ < var_751_1 + var_751_2 + arg_751_0 and not isNil(var_751_0) and arg_748_1.var_.characterEffect1034ui_story then
				arg_748_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_751_4 = 0
			local var_751_5 = 0.725

			if var_751_4 < arg_748_1.time_ and arg_748_1.time_ <= var_751_4 + arg_751_0 then
				arg_748_1.talkMaxDuration = 0
				arg_748_1.dialogCg_.alpha = 1

				arg_748_1.dialog_:SetActive(true)
				SetActive(arg_748_1.leftNameGo_, true)

				local var_751_6 = arg_748_1:FormatText(StoryNameCfg[1109].name)

				arg_748_1.leftNameTxt_.text = var_751_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_748_1.leftNameTxt_.transform)

				arg_748_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_748_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_748_1:RecordName(arg_748_1.leftNameTxt_.text)
				SetActive(arg_748_1.iconTrs_.gameObject, false)
				arg_748_1.callingController_:SetSelectedState("normal")

				local var_751_7 = arg_748_1:GetWordFromCfg(1103404187)
				local var_751_8 = arg_748_1:FormatText(var_751_7.content)

				arg_748_1.text_.text = var_751_8

				LuaForUtil.ClearLinePrefixSymbol(arg_748_1.text_)

				local var_751_9 = 29
				local var_751_10 = utf8.len(var_751_8)
				local var_751_11 = var_751_9 <= 0 and var_751_5 or var_751_5 * (var_751_10 / var_751_9)

				if var_751_11 > 0 and var_751_5 < var_751_11 then
					arg_748_1.talkMaxDuration = var_751_11

					if var_751_11 + var_751_4 > arg_748_1.duration_ then
						arg_748_1.duration_ = var_751_11 + var_751_4
					end
				end

				arg_748_1.text_.text = var_751_8
				arg_748_1.typewritter.percent = 0

				arg_748_1.typewritter:SetDirty()
				arg_748_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404187", "story_v_side_new_1103404.awb") ~= 0 then
					local var_751_12 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404187", "story_v_side_new_1103404.awb") / 1000

					if var_751_12 + var_751_4 > arg_748_1.duration_ then
						arg_748_1.duration_ = var_751_12 + var_751_4
					end

					if var_751_7.prefab_name ~= "" and arg_748_1.actors_[var_751_7.prefab_name] ~= nil then
						local var_751_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_748_1.actors_[var_751_7.prefab_name].transform, "story_v_side_new_1103404", "1103404187", "story_v_side_new_1103404.awb")

						arg_748_1:RecordAudio("1103404187", var_751_13)
						arg_748_1:RecordAudio("1103404187", var_751_13)
					else
						arg_748_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404187", "story_v_side_new_1103404.awb")
					end

					arg_748_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404187", "story_v_side_new_1103404.awb")
				end

				arg_748_1:RecordContent(arg_748_1.text_.text)
			end

			local var_751_14 = math.max(var_751_5, arg_748_1.talkMaxDuration)

			if var_751_4 <= arg_748_1.time_ and arg_748_1.time_ < var_751_4 + var_751_14 then
				arg_748_1.typewritter.percent = (arg_748_1.time_ - var_751_4) / var_751_14

				arg_748_1.typewritter:SetDirty()
			end

			if arg_748_1.time_ >= var_751_4 + var_751_14 and arg_748_1.time_ < var_751_4 + var_751_14 + arg_751_0 then
				arg_748_1.typewritter.percent = 1

				arg_748_1.typewritter:SetDirty()
				arg_748_1:ShowNextGo(true)
			end
		end

		arg_748_1.nodeConfigList_ = {}

		arg_748_1:InitPlayNodeList()
	end,
	Play1103404188 = function(arg_752_0, arg_752_1)
		arg_752_1.time_ = 0
		arg_752_1.frameCnt_ = 0
		arg_752_1.state_ = "playing"
		arg_752_1.curTalkId_ = 1103404188
		arg_752_1.duration_ = 4.2

		SetActive(arg_752_1.tipsGo_, false)

		function arg_752_1.onSingleLineFinish_()
			arg_752_1.onSingleLineUpdate_ = nil
			arg_752_1.onSingleLineFinish_ = nil
			arg_752_1.state_ = "waiting"
		end

		function arg_752_1.playNext_(arg_754_0)
			if arg_754_0 == 1 then
				arg_752_0:Play1103404189(arg_752_1)
			end
		end

		function arg_752_1.onSingleLineUpdate_(arg_755_0)
			local var_755_0 = 0
			local var_755_1 = 0.35

			if var_755_0 < arg_752_1.time_ and arg_752_1.time_ <= var_755_0 + arg_755_0 then
				arg_752_1.talkMaxDuration = 0
				arg_752_1.dialogCg_.alpha = 1

				arg_752_1.dialog_:SetActive(true)
				SetActive(arg_752_1.leftNameGo_, true)

				local var_755_2 = arg_752_1:FormatText(StoryNameCfg[1109].name)

				arg_752_1.leftNameTxt_.text = var_755_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_752_1.leftNameTxt_.transform)

				arg_752_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_752_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_752_1:RecordName(arg_752_1.leftNameTxt_.text)
				SetActive(arg_752_1.iconTrs_.gameObject, false)
				arg_752_1.callingController_:SetSelectedState("normal")

				local var_755_3 = arg_752_1:GetWordFromCfg(1103404188)
				local var_755_4 = arg_752_1:FormatText(var_755_3.content)

				arg_752_1.text_.text = var_755_4

				LuaForUtil.ClearLinePrefixSymbol(arg_752_1.text_)

				local var_755_5 = 14
				local var_755_6 = utf8.len(var_755_4)
				local var_755_7 = var_755_5 <= 0 and var_755_1 or var_755_1 * (var_755_6 / var_755_5)

				if var_755_7 > 0 and var_755_1 < var_755_7 then
					arg_752_1.talkMaxDuration = var_755_7

					if var_755_7 + var_755_0 > arg_752_1.duration_ then
						arg_752_1.duration_ = var_755_7 + var_755_0
					end
				end

				arg_752_1.text_.text = var_755_4
				arg_752_1.typewritter.percent = 0

				arg_752_1.typewritter:SetDirty()
				arg_752_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404188", "story_v_side_new_1103404.awb") ~= 0 then
					local var_755_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404188", "story_v_side_new_1103404.awb") / 1000

					if var_755_8 + var_755_0 > arg_752_1.duration_ then
						arg_752_1.duration_ = var_755_8 + var_755_0
					end

					if var_755_3.prefab_name ~= "" and arg_752_1.actors_[var_755_3.prefab_name] ~= nil then
						local var_755_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_752_1.actors_[var_755_3.prefab_name].transform, "story_v_side_new_1103404", "1103404188", "story_v_side_new_1103404.awb")

						arg_752_1:RecordAudio("1103404188", var_755_9)
						arg_752_1:RecordAudio("1103404188", var_755_9)
					else
						arg_752_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404188", "story_v_side_new_1103404.awb")
					end

					arg_752_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404188", "story_v_side_new_1103404.awb")
				end

				arg_752_1:RecordContent(arg_752_1.text_.text)
			end

			local var_755_10 = math.max(var_755_1, arg_752_1.talkMaxDuration)

			if var_755_0 <= arg_752_1.time_ and arg_752_1.time_ < var_755_0 + var_755_10 then
				arg_752_1.typewritter.percent = (arg_752_1.time_ - var_755_0) / var_755_10

				arg_752_1.typewritter:SetDirty()
			end

			if arg_752_1.time_ >= var_755_0 + var_755_10 and arg_752_1.time_ < var_755_0 + var_755_10 + arg_755_0 then
				arg_752_1.typewritter.percent = 1

				arg_752_1.typewritter:SetDirty()
				arg_752_1:ShowNextGo(true)
			end
		end

		arg_752_1.nodeConfigList_ = {}

		arg_752_1:InitPlayNodeList()
	end,
	Play1103404189 = function(arg_756_0, arg_756_1)
		arg_756_1.time_ = 0
		arg_756_1.frameCnt_ = 0
		arg_756_1.state_ = "playing"
		arg_756_1.curTalkId_ = 1103404189
		arg_756_1.duration_ = 5

		SetActive(arg_756_1.tipsGo_, false)

		function arg_756_1.onSingleLineFinish_()
			arg_756_1.onSingleLineUpdate_ = nil
			arg_756_1.onSingleLineFinish_ = nil
			arg_756_1.state_ = "waiting"
		end

		function arg_756_1.playNext_(arg_758_0)
			if arg_758_0 == 1 then
				arg_756_0:Play1103404190(arg_756_1)
			end
		end

		function arg_756_1.onSingleLineUpdate_(arg_759_0)
			local var_759_0 = arg_756_1.actors_["1034ui_story"]
			local var_759_1 = 0

			if var_759_1 < arg_756_1.time_ and arg_756_1.time_ <= var_759_1 + arg_759_0 and not isNil(var_759_0) and arg_756_1.var_.characterEffect1034ui_story == nil then
				arg_756_1.var_.characterEffect1034ui_story = var_759_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_759_2 = 0.200000002980232

			if var_759_1 <= arg_756_1.time_ and arg_756_1.time_ < var_759_1 + var_759_2 and not isNil(var_759_0) then
				local var_759_3 = (arg_756_1.time_ - var_759_1) / var_759_2

				if arg_756_1.var_.characterEffect1034ui_story and not isNil(var_759_0) then
					local var_759_4 = Mathf.Lerp(0, 0.5, var_759_3)

					arg_756_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_756_1.var_.characterEffect1034ui_story.fillRatio = var_759_4
				end
			end

			if arg_756_1.time_ >= var_759_1 + var_759_2 and arg_756_1.time_ < var_759_1 + var_759_2 + arg_759_0 and not isNil(var_759_0) and arg_756_1.var_.characterEffect1034ui_story then
				local var_759_5 = 0.5

				arg_756_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_756_1.var_.characterEffect1034ui_story.fillRatio = var_759_5
			end

			local var_759_6 = 0

			if var_759_6 < arg_756_1.time_ and arg_756_1.time_ <= var_759_6 + arg_759_0 then
				arg_756_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_759_7 = 0
			local var_759_8 = 1.45

			if var_759_7 < arg_756_1.time_ and arg_756_1.time_ <= var_759_7 + arg_759_0 then
				arg_756_1.talkMaxDuration = 0
				arg_756_1.dialogCg_.alpha = 1

				arg_756_1.dialog_:SetActive(true)
				SetActive(arg_756_1.leftNameGo_, false)

				arg_756_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_756_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_756_1:RecordName(arg_756_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_756_1.iconTrs_.gameObject, false)
				arg_756_1.callingController_:SetSelectedState("normal")

				local var_759_9 = arg_756_1:GetWordFromCfg(1103404189)
				local var_759_10 = arg_756_1:FormatText(var_759_9.content)

				arg_756_1.text_.text = var_759_10

				LuaForUtil.ClearLinePrefixSymbol(arg_756_1.text_)

				local var_759_11 = 58
				local var_759_12 = utf8.len(var_759_10)
				local var_759_13 = var_759_11 <= 0 and var_759_8 or var_759_8 * (var_759_12 / var_759_11)

				if var_759_13 > 0 and var_759_8 < var_759_13 then
					arg_756_1.talkMaxDuration = var_759_13

					if var_759_13 + var_759_7 > arg_756_1.duration_ then
						arg_756_1.duration_ = var_759_13 + var_759_7
					end
				end

				arg_756_1.text_.text = var_759_10
				arg_756_1.typewritter.percent = 0

				arg_756_1.typewritter:SetDirty()
				arg_756_1:ShowNextGo(false)
				arg_756_1:RecordContent(arg_756_1.text_.text)
			end

			local var_759_14 = math.max(var_759_8, arg_756_1.talkMaxDuration)

			if var_759_7 <= arg_756_1.time_ and arg_756_1.time_ < var_759_7 + var_759_14 then
				arg_756_1.typewritter.percent = (arg_756_1.time_ - var_759_7) / var_759_14

				arg_756_1.typewritter:SetDirty()
			end

			if arg_756_1.time_ >= var_759_7 + var_759_14 and arg_756_1.time_ < var_759_7 + var_759_14 + arg_759_0 then
				arg_756_1.typewritter.percent = 1

				arg_756_1.typewritter:SetDirty()
				arg_756_1:ShowNextGo(true)
			end
		end

		arg_756_1.nodeConfigList_ = {}

		arg_756_1:InitPlayNodeList()
	end,
	Play1103404190 = function(arg_760_0, arg_760_1)
		arg_760_1.time_ = 0
		arg_760_1.frameCnt_ = 0
		arg_760_1.state_ = "playing"
		arg_760_1.curTalkId_ = 1103404190
		arg_760_1.duration_ = 5.4

		SetActive(arg_760_1.tipsGo_, false)

		function arg_760_1.onSingleLineFinish_()
			arg_760_1.onSingleLineUpdate_ = nil
			arg_760_1.onSingleLineFinish_ = nil
			arg_760_1.state_ = "waiting"
			arg_760_1.auto_ = false
		end

		function arg_760_1.playNext_(arg_762_0)
			arg_760_1.onStoryFinished_()
		end

		function arg_760_1.onSingleLineUpdate_(arg_763_0)
			local var_763_0 = arg_760_1.actors_["1034ui_story"]
			local var_763_1 = 0

			if var_763_1 < arg_760_1.time_ and arg_760_1.time_ <= var_763_1 + arg_763_0 and not isNil(var_763_0) and arg_760_1.var_.characterEffect1034ui_story == nil then
				arg_760_1.var_.characterEffect1034ui_story = var_763_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_763_2 = 0.200000002980232

			if var_763_1 <= arg_760_1.time_ and arg_760_1.time_ < var_763_1 + var_763_2 and not isNil(var_763_0) then
				local var_763_3 = (arg_760_1.time_ - var_763_1) / var_763_2

				if arg_760_1.var_.characterEffect1034ui_story and not isNil(var_763_0) then
					arg_760_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_760_1.time_ >= var_763_1 + var_763_2 and arg_760_1.time_ < var_763_1 + var_763_2 + arg_763_0 and not isNil(var_763_0) and arg_760_1.var_.characterEffect1034ui_story then
				arg_760_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_763_4 = 0
			local var_763_5 = 0.775

			if var_763_4 < arg_760_1.time_ and arg_760_1.time_ <= var_763_4 + arg_763_0 then
				arg_760_1.talkMaxDuration = 0
				arg_760_1.dialogCg_.alpha = 1

				arg_760_1.dialog_:SetActive(true)
				SetActive(arg_760_1.leftNameGo_, true)

				local var_763_6 = arg_760_1:FormatText(StoryNameCfg[1109].name)

				arg_760_1.leftNameTxt_.text = var_763_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_760_1.leftNameTxt_.transform)

				arg_760_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_760_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_760_1:RecordName(arg_760_1.leftNameTxt_.text)
				SetActive(arg_760_1.iconTrs_.gameObject, false)
				arg_760_1.callingController_:SetSelectedState("normal")

				local var_763_7 = arg_760_1:GetWordFromCfg(1103404190)
				local var_763_8 = arg_760_1:FormatText(var_763_7.content)

				arg_760_1.text_.text = var_763_8

				LuaForUtil.ClearLinePrefixSymbol(arg_760_1.text_)

				local var_763_9 = 31
				local var_763_10 = utf8.len(var_763_8)
				local var_763_11 = var_763_9 <= 0 and var_763_5 or var_763_5 * (var_763_10 / var_763_9)

				if var_763_11 > 0 and var_763_5 < var_763_11 then
					arg_760_1.talkMaxDuration = var_763_11

					if var_763_11 + var_763_4 > arg_760_1.duration_ then
						arg_760_1.duration_ = var_763_11 + var_763_4
					end
				end

				arg_760_1.text_.text = var_763_8
				arg_760_1.typewritter.percent = 0

				arg_760_1.typewritter:SetDirty()
				arg_760_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404190", "story_v_side_new_1103404.awb") ~= 0 then
					local var_763_12 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404190", "story_v_side_new_1103404.awb") / 1000

					if var_763_12 + var_763_4 > arg_760_1.duration_ then
						arg_760_1.duration_ = var_763_12 + var_763_4
					end

					if var_763_7.prefab_name ~= "" and arg_760_1.actors_[var_763_7.prefab_name] ~= nil then
						local var_763_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_760_1.actors_[var_763_7.prefab_name].transform, "story_v_side_new_1103404", "1103404190", "story_v_side_new_1103404.awb")

						arg_760_1:RecordAudio("1103404190", var_763_13)
						arg_760_1:RecordAudio("1103404190", var_763_13)
					else
						arg_760_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404190", "story_v_side_new_1103404.awb")
					end

					arg_760_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404190", "story_v_side_new_1103404.awb")
				end

				arg_760_1:RecordContent(arg_760_1.text_.text)
			end

			local var_763_14 = math.max(var_763_5, arg_760_1.talkMaxDuration)

			if var_763_4 <= arg_760_1.time_ and arg_760_1.time_ < var_763_4 + var_763_14 then
				arg_760_1.typewritter.percent = (arg_760_1.time_ - var_763_4) / var_763_14

				arg_760_1.typewritter:SetDirty()
			end

			if arg_760_1.time_ >= var_763_4 + var_763_14 and arg_760_1.time_ < var_763_4 + var_763_14 + arg_763_0 then
				arg_760_1.typewritter.percent = 1

				arg_760_1.typewritter:SetDirty()
				arg_760_1:ShowNextGo(true)
			end
		end

		arg_760_1.nodeConfigList_ = {}

		arg_760_1:InitPlayNodeList()
	end,
	Play1103404170 = function(arg_764_0, arg_764_1)
		arg_764_1.time_ = 0
		arg_764_1.frameCnt_ = 0
		arg_764_1.state_ = "playing"
		arg_764_1.curTalkId_ = 1103404170
		arg_764_1.duration_ = 5

		SetActive(arg_764_1.tipsGo_, false)

		function arg_764_1.onSingleLineFinish_()
			arg_764_1.onSingleLineUpdate_ = nil
			arg_764_1.onSingleLineFinish_ = nil
			arg_764_1.state_ = "waiting"
		end

		function arg_764_1.playNext_(arg_766_0)
			if arg_766_0 == 1 then
				arg_764_0:Play1103404171(arg_764_1)
			end
		end

		function arg_764_1.onSingleLineUpdate_(arg_767_0)
			local var_767_0 = 0
			local var_767_1 = 0.55

			if var_767_0 < arg_764_1.time_ and arg_764_1.time_ <= var_767_0 + arg_767_0 then
				arg_764_1.talkMaxDuration = 0
				arg_764_1.dialogCg_.alpha = 1

				arg_764_1.dialog_:SetActive(true)
				SetActive(arg_764_1.leftNameGo_, true)

				local var_767_2 = arg_764_1:FormatText(StoryNameCfg[1109].name)

				arg_764_1.leftNameTxt_.text = var_767_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_764_1.leftNameTxt_.transform)

				arg_764_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_764_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_764_1:RecordName(arg_764_1.leftNameTxt_.text)
				SetActive(arg_764_1.iconTrs_.gameObject, false)
				arg_764_1.callingController_:SetSelectedState("normal")

				local var_767_3 = arg_764_1:GetWordFromCfg(1103404170)
				local var_767_4 = arg_764_1:FormatText(var_767_3.content)

				arg_764_1.text_.text = var_767_4

				LuaForUtil.ClearLinePrefixSymbol(arg_764_1.text_)

				local var_767_5 = 22
				local var_767_6 = utf8.len(var_767_4)
				local var_767_7 = var_767_5 <= 0 and var_767_1 or var_767_1 * (var_767_6 / var_767_5)

				if var_767_7 > 0 and var_767_1 < var_767_7 then
					arg_764_1.talkMaxDuration = var_767_7

					if var_767_7 + var_767_0 > arg_764_1.duration_ then
						arg_764_1.duration_ = var_767_7 + var_767_0
					end
				end

				arg_764_1.text_.text = var_767_4
				arg_764_1.typewritter.percent = 0

				arg_764_1.typewritter:SetDirty()
				arg_764_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404170", "story_v_side_new_1103404.awb") ~= 0 then
					local var_767_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404170", "story_v_side_new_1103404.awb") / 1000

					if var_767_8 + var_767_0 > arg_764_1.duration_ then
						arg_764_1.duration_ = var_767_8 + var_767_0
					end

					if var_767_3.prefab_name ~= "" and arg_764_1.actors_[var_767_3.prefab_name] ~= nil then
						local var_767_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_764_1.actors_[var_767_3.prefab_name].transform, "story_v_side_new_1103404", "1103404170", "story_v_side_new_1103404.awb")

						arg_764_1:RecordAudio("1103404170", var_767_9)
						arg_764_1:RecordAudio("1103404170", var_767_9)
					else
						arg_764_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404170", "story_v_side_new_1103404.awb")
					end

					arg_764_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404170", "story_v_side_new_1103404.awb")
				end

				arg_764_1:RecordContent(arg_764_1.text_.text)
			end

			local var_767_10 = math.max(var_767_1, arg_764_1.talkMaxDuration)

			if var_767_0 <= arg_764_1.time_ and arg_764_1.time_ < var_767_0 + var_767_10 then
				arg_764_1.typewritter.percent = (arg_764_1.time_ - var_767_0) / var_767_10

				arg_764_1.typewritter:SetDirty()
			end

			if arg_764_1.time_ >= var_767_0 + var_767_10 and arg_764_1.time_ < var_767_0 + var_767_10 + arg_767_0 then
				arg_764_1.typewritter.percent = 1

				arg_764_1.typewritter:SetDirty()
				arg_764_1:ShowNextGo(true)
			end
		end

		arg_764_1.nodeConfigList_ = {}

		arg_764_1:InitPlayNodeList()
	end,
	Play1103404171 = function(arg_768_0, arg_768_1)
		arg_768_1.time_ = 0
		arg_768_1.frameCnt_ = 0
		arg_768_1.state_ = "playing"
		arg_768_1.curTalkId_ = 1103404171
		arg_768_1.duration_ = 6.67

		SetActive(arg_768_1.tipsGo_, false)

		function arg_768_1.onSingleLineFinish_()
			arg_768_1.onSingleLineUpdate_ = nil
			arg_768_1.onSingleLineFinish_ = nil
			arg_768_1.state_ = "waiting"
		end

		function arg_768_1.playNext_(arg_770_0)
			if arg_770_0 == 1 then
				arg_768_0:Play1103404172(arg_768_1)
			end
		end

		function arg_768_1.onSingleLineUpdate_(arg_771_0)
			local var_771_0 = 0
			local var_771_1 = 0.7

			if var_771_0 < arg_768_1.time_ and arg_768_1.time_ <= var_771_0 + arg_771_0 then
				arg_768_1.talkMaxDuration = 0
				arg_768_1.dialogCg_.alpha = 1

				arg_768_1.dialog_:SetActive(true)
				SetActive(arg_768_1.leftNameGo_, true)

				local var_771_2 = arg_768_1:FormatText(StoryNameCfg[1109].name)

				arg_768_1.leftNameTxt_.text = var_771_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_768_1.leftNameTxt_.transform)

				arg_768_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_768_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_768_1:RecordName(arg_768_1.leftNameTxt_.text)
				SetActive(arg_768_1.iconTrs_.gameObject, false)
				arg_768_1.callingController_:SetSelectedState("normal")

				local var_771_3 = arg_768_1:GetWordFromCfg(1103404171)
				local var_771_4 = arg_768_1:FormatText(var_771_3.content)

				arg_768_1.text_.text = var_771_4

				LuaForUtil.ClearLinePrefixSymbol(arg_768_1.text_)

				local var_771_5 = 28
				local var_771_6 = utf8.len(var_771_4)
				local var_771_7 = var_771_5 <= 0 and var_771_1 or var_771_1 * (var_771_6 / var_771_5)

				if var_771_7 > 0 and var_771_1 < var_771_7 then
					arg_768_1.talkMaxDuration = var_771_7

					if var_771_7 + var_771_0 > arg_768_1.duration_ then
						arg_768_1.duration_ = var_771_7 + var_771_0
					end
				end

				arg_768_1.text_.text = var_771_4
				arg_768_1.typewritter.percent = 0

				arg_768_1.typewritter:SetDirty()
				arg_768_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404171", "story_v_side_new_1103404.awb") ~= 0 then
					local var_771_8 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404171", "story_v_side_new_1103404.awb") / 1000

					if var_771_8 + var_771_0 > arg_768_1.duration_ then
						arg_768_1.duration_ = var_771_8 + var_771_0
					end

					if var_771_3.prefab_name ~= "" and arg_768_1.actors_[var_771_3.prefab_name] ~= nil then
						local var_771_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_768_1.actors_[var_771_3.prefab_name].transform, "story_v_side_new_1103404", "1103404171", "story_v_side_new_1103404.awb")

						arg_768_1:RecordAudio("1103404171", var_771_9)
						arg_768_1:RecordAudio("1103404171", var_771_9)
					else
						arg_768_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404171", "story_v_side_new_1103404.awb")
					end

					arg_768_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404171", "story_v_side_new_1103404.awb")
				end

				arg_768_1:RecordContent(arg_768_1.text_.text)
			end

			local var_771_10 = math.max(var_771_1, arg_768_1.talkMaxDuration)

			if var_771_0 <= arg_768_1.time_ and arg_768_1.time_ < var_771_0 + var_771_10 then
				arg_768_1.typewritter.percent = (arg_768_1.time_ - var_771_0) / var_771_10

				arg_768_1.typewritter:SetDirty()
			end

			if arg_768_1.time_ >= var_771_0 + var_771_10 and arg_768_1.time_ < var_771_0 + var_771_10 + arg_771_0 then
				arg_768_1.typewritter.percent = 1

				arg_768_1.typewritter:SetDirty()
				arg_768_1:ShowNextGo(true)
			end
		end

		arg_768_1.nodeConfigList_ = {}

		arg_768_1:InitPlayNodeList()
	end,
	Play1103404058 = function(arg_772_0, arg_772_1)
		arg_772_1.time_ = 0
		arg_772_1.frameCnt_ = 0
		arg_772_1.state_ = "playing"
		arg_772_1.curTalkId_ = 1103404058
		arg_772_1.duration_ = 2.03

		SetActive(arg_772_1.tipsGo_, false)

		function arg_772_1.onSingleLineFinish_()
			arg_772_1.onSingleLineUpdate_ = nil
			arg_772_1.onSingleLineFinish_ = nil
			arg_772_1.state_ = "waiting"
		end

		function arg_772_1.playNext_(arg_774_0)
			if arg_774_0 == 1 then
				arg_772_0:Play1103404059(arg_772_1)
			end
		end

		function arg_772_1.onSingleLineUpdate_(arg_775_0)
			local var_775_0 = "1034ui_story"

			if arg_772_1.actors_[var_775_0] == nil then
				local var_775_1 = Asset.Load("Char/" .. "1034ui_story")

				if not isNil(var_775_1) then
					local var_775_2 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_772_1.stage_.transform)

					var_775_2.name = var_775_0
					var_775_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_772_1.actors_[var_775_0] = var_775_2

					local var_775_3 = var_775_2:GetComponentInChildren(typeof(CharacterEffect))

					var_775_3.enabled = true

					local var_775_4 = GameObjectTools.GetOrAddComponent(var_775_2, typeof(DynamicBoneHelper))

					if var_775_4 then
						var_775_4:EnableDynamicBone(false)
					end

					arg_772_1:ShowWeapon(var_775_3.transform, false)

					arg_772_1.var_[var_775_0 .. "Animator"] = var_775_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_772_1.var_[var_775_0 .. "Animator"].applyRootMotion = true
					arg_772_1.var_[var_775_0 .. "LipSync"] = var_775_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_775_5 = 0

			if var_775_5 < arg_772_1.time_ and arg_772_1.time_ <= var_775_5 + arg_775_0 then
				arg_772_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action9_1")
			end

			local var_775_6 = "1034ui_story"

			if arg_772_1.actors_[var_775_6] == nil then
				local var_775_7 = Asset.Load("Char/" .. "1034ui_story")

				if not isNil(var_775_7) then
					local var_775_8 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_772_1.stage_.transform)

					var_775_8.name = var_775_6
					var_775_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_772_1.actors_[var_775_6] = var_775_8

					local var_775_9 = var_775_8:GetComponentInChildren(typeof(CharacterEffect))

					var_775_9.enabled = true

					local var_775_10 = GameObjectTools.GetOrAddComponent(var_775_8, typeof(DynamicBoneHelper))

					if var_775_10 then
						var_775_10:EnableDynamicBone(false)
					end

					arg_772_1:ShowWeapon(var_775_9.transform, false)

					arg_772_1.var_[var_775_6 .. "Animator"] = var_775_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_772_1.var_[var_775_6 .. "Animator"].applyRootMotion = true
					arg_772_1.var_[var_775_6 .. "LipSync"] = var_775_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_775_11 = 0

			if var_775_11 < arg_772_1.time_ and arg_772_1.time_ <= var_775_11 + arg_775_0 then
				arg_772_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_775_12 = arg_772_1.actors_["1034ui_story"]
			local var_775_13 = 0

			if var_775_13 < arg_772_1.time_ and arg_772_1.time_ <= var_775_13 + arg_775_0 and not isNil(var_775_12) and arg_772_1.var_.characterEffect1034ui_story == nil then
				arg_772_1.var_.characterEffect1034ui_story = var_775_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_775_14 = 0.200000002980232

			if var_775_13 <= arg_772_1.time_ and arg_772_1.time_ < var_775_13 + var_775_14 and not isNil(var_775_12) then
				local var_775_15 = (arg_772_1.time_ - var_775_13) / var_775_14

				if arg_772_1.var_.characterEffect1034ui_story and not isNil(var_775_12) then
					arg_772_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_772_1.time_ >= var_775_13 + var_775_14 and arg_772_1.time_ < var_775_13 + var_775_14 + arg_775_0 and not isNil(var_775_12) and arg_772_1.var_.characterEffect1034ui_story then
				arg_772_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_775_16 = 0
			local var_775_17 = 0.225

			if var_775_16 < arg_772_1.time_ and arg_772_1.time_ <= var_775_16 + arg_775_0 then
				arg_772_1.talkMaxDuration = 0
				arg_772_1.dialogCg_.alpha = 1

				arg_772_1.dialog_:SetActive(true)
				SetActive(arg_772_1.leftNameGo_, true)

				local var_775_18 = arg_772_1:FormatText(StoryNameCfg[1109].name)

				arg_772_1.leftNameTxt_.text = var_775_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_772_1.leftNameTxt_.transform)

				arg_772_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_772_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_772_1:RecordName(arg_772_1.leftNameTxt_.text)
				SetActive(arg_772_1.iconTrs_.gameObject, false)
				arg_772_1.callingController_:SetSelectedState("normal")

				local var_775_19 = arg_772_1:GetWordFromCfg(1103404058)
				local var_775_20 = arg_772_1:FormatText(var_775_19.content)

				arg_772_1.text_.text = var_775_20

				LuaForUtil.ClearLinePrefixSymbol(arg_772_1.text_)

				local var_775_21 = 9
				local var_775_22 = utf8.len(var_775_20)
				local var_775_23 = var_775_21 <= 0 and var_775_17 or var_775_17 * (var_775_22 / var_775_21)

				if var_775_23 > 0 and var_775_17 < var_775_23 then
					arg_772_1.talkMaxDuration = var_775_23

					if var_775_23 + var_775_16 > arg_772_1.duration_ then
						arg_772_1.duration_ = var_775_23 + var_775_16
					end
				end

				arg_772_1.text_.text = var_775_20
				arg_772_1.typewritter.percent = 0

				arg_772_1.typewritter:SetDirty()
				arg_772_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404058", "story_v_side_new_1103404.awb") ~= 0 then
					local var_775_24 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404058", "story_v_side_new_1103404.awb") / 1000

					if var_775_24 + var_775_16 > arg_772_1.duration_ then
						arg_772_1.duration_ = var_775_24 + var_775_16
					end

					if var_775_19.prefab_name ~= "" and arg_772_1.actors_[var_775_19.prefab_name] ~= nil then
						local var_775_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_772_1.actors_[var_775_19.prefab_name].transform, "story_v_side_new_1103404", "1103404058", "story_v_side_new_1103404.awb")

						arg_772_1:RecordAudio("1103404058", var_775_25)
						arg_772_1:RecordAudio("1103404058", var_775_25)
					else
						arg_772_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404058", "story_v_side_new_1103404.awb")
					end

					arg_772_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404058", "story_v_side_new_1103404.awb")
				end

				arg_772_1:RecordContent(arg_772_1.text_.text)
			end

			local var_775_26 = math.max(var_775_17, arg_772_1.talkMaxDuration)

			if var_775_16 <= arg_772_1.time_ and arg_772_1.time_ < var_775_16 + var_775_26 then
				arg_772_1.typewritter.percent = (arg_772_1.time_ - var_775_16) / var_775_26

				arg_772_1.typewritter:SetDirty()
			end

			if arg_772_1.time_ >= var_775_16 + var_775_26 and arg_772_1.time_ < var_775_16 + var_775_26 + arg_775_0 then
				arg_772_1.typewritter.percent = 1

				arg_772_1.typewritter:SetDirty()
				arg_772_1:ShowNextGo(true)
			end
		end

		arg_772_1.nodeConfigList_ = {}

		arg_772_1:InitPlayNodeList()
	end,
	Play1103404059 = function(arg_776_0, arg_776_1)
		arg_776_1.time_ = 0
		arg_776_1.frameCnt_ = 0
		arg_776_1.state_ = "playing"
		arg_776_1.curTalkId_ = 1103404059
		arg_776_1.duration_ = 3.6

		SetActive(arg_776_1.tipsGo_, false)

		function arg_776_1.onSingleLineFinish_()
			arg_776_1.onSingleLineUpdate_ = nil
			arg_776_1.onSingleLineFinish_ = nil
			arg_776_1.state_ = "waiting"
		end

		function arg_776_1.playNext_(arg_778_0)
			if arg_778_0 == 1 then
				arg_776_0:Play1103404062(arg_776_1)
			end
		end

		function arg_776_1.onSingleLineUpdate_(arg_779_0)
			local var_779_0 = 0

			if var_779_0 < arg_776_1.time_ and arg_776_1.time_ <= var_779_0 + arg_779_0 then
				arg_776_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_779_1 = 0
			local var_779_2 = 0.45

			if var_779_1 < arg_776_1.time_ and arg_776_1.time_ <= var_779_1 + arg_779_0 then
				arg_776_1.talkMaxDuration = 0
				arg_776_1.dialogCg_.alpha = 1

				arg_776_1.dialog_:SetActive(true)
				SetActive(arg_776_1.leftNameGo_, true)

				local var_779_3 = arg_776_1:FormatText(StoryNameCfg[1109].name)

				arg_776_1.leftNameTxt_.text = var_779_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_776_1.leftNameTxt_.transform)

				arg_776_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_776_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_776_1:RecordName(arg_776_1.leftNameTxt_.text)
				SetActive(arg_776_1.iconTrs_.gameObject, false)
				arg_776_1.callingController_:SetSelectedState("normal")

				local var_779_4 = arg_776_1:GetWordFromCfg(1103404059)
				local var_779_5 = arg_776_1:FormatText(var_779_4.content)

				arg_776_1.text_.text = var_779_5

				LuaForUtil.ClearLinePrefixSymbol(arg_776_1.text_)

				local var_779_6 = 18
				local var_779_7 = utf8.len(var_779_5)
				local var_779_8 = var_779_6 <= 0 and var_779_2 or var_779_2 * (var_779_7 / var_779_6)

				if var_779_8 > 0 and var_779_2 < var_779_8 then
					arg_776_1.talkMaxDuration = var_779_8

					if var_779_8 + var_779_1 > arg_776_1.duration_ then
						arg_776_1.duration_ = var_779_8 + var_779_1
					end
				end

				arg_776_1.text_.text = var_779_5
				arg_776_1.typewritter.percent = 0

				arg_776_1.typewritter:SetDirty()
				arg_776_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404059", "story_v_side_new_1103404.awb") ~= 0 then
					local var_779_9 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404059", "story_v_side_new_1103404.awb") / 1000

					if var_779_9 + var_779_1 > arg_776_1.duration_ then
						arg_776_1.duration_ = var_779_9 + var_779_1
					end

					if var_779_4.prefab_name ~= "" and arg_776_1.actors_[var_779_4.prefab_name] ~= nil then
						local var_779_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_776_1.actors_[var_779_4.prefab_name].transform, "story_v_side_new_1103404", "1103404059", "story_v_side_new_1103404.awb")

						arg_776_1:RecordAudio("1103404059", var_779_10)
						arg_776_1:RecordAudio("1103404059", var_779_10)
					else
						arg_776_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404059", "story_v_side_new_1103404.awb")
					end

					arg_776_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404059", "story_v_side_new_1103404.awb")
				end

				arg_776_1:RecordContent(arg_776_1.text_.text)
			end

			local var_779_11 = math.max(var_779_2, arg_776_1.talkMaxDuration)

			if var_779_1 <= arg_776_1.time_ and arg_776_1.time_ < var_779_1 + var_779_11 then
				arg_776_1.typewritter.percent = (arg_776_1.time_ - var_779_1) / var_779_11

				arg_776_1.typewritter:SetDirty()
			end

			if arg_776_1.time_ >= var_779_1 + var_779_11 and arg_776_1.time_ < var_779_1 + var_779_11 + arg_779_0 then
				arg_776_1.typewritter.percent = 1

				arg_776_1.typewritter:SetDirty()
				arg_776_1:ShowNextGo(true)
			end
		end

		arg_776_1.nodeConfigList_ = {}

		arg_776_1:InitPlayNodeList()
	end,
	Play1103404060 = function(arg_780_0, arg_780_1)
		arg_780_1.time_ = 0
		arg_780_1.frameCnt_ = 0
		arg_780_1.state_ = "playing"
		arg_780_1.curTalkId_ = 1103404060
		arg_780_1.duration_ = 2.4

		SetActive(arg_780_1.tipsGo_, false)

		function arg_780_1.onSingleLineFinish_()
			arg_780_1.onSingleLineUpdate_ = nil
			arg_780_1.onSingleLineFinish_ = nil
			arg_780_1.state_ = "waiting"
		end

		function arg_780_1.playNext_(arg_782_0)
			if arg_782_0 == 1 then
				arg_780_0:Play1103404061(arg_780_1)
			end
		end

		function arg_780_1.onSingleLineUpdate_(arg_783_0)
			local var_783_0 = "1034ui_story"

			if arg_780_1.actors_[var_783_0] == nil then
				local var_783_1 = Asset.Load("Char/" .. "1034ui_story")

				if not isNil(var_783_1) then
					local var_783_2 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_780_1.stage_.transform)

					var_783_2.name = var_783_0
					var_783_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_780_1.actors_[var_783_0] = var_783_2

					local var_783_3 = var_783_2:GetComponentInChildren(typeof(CharacterEffect))

					var_783_3.enabled = true

					local var_783_4 = GameObjectTools.GetOrAddComponent(var_783_2, typeof(DynamicBoneHelper))

					if var_783_4 then
						var_783_4:EnableDynamicBone(false)
					end

					arg_780_1:ShowWeapon(var_783_3.transform, false)

					arg_780_1.var_[var_783_0 .. "Animator"] = var_783_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_780_1.var_[var_783_0 .. "Animator"].applyRootMotion = true
					arg_780_1.var_[var_783_0 .. "LipSync"] = var_783_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_783_5 = 0

			if var_783_5 < arg_780_1.time_ and arg_780_1.time_ <= var_783_5 + arg_783_0 then
				arg_780_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action9_1")
			end

			local var_783_6 = "1034ui_story"

			if arg_780_1.actors_[var_783_6] == nil then
				local var_783_7 = Asset.Load("Char/" .. "1034ui_story")

				if not isNil(var_783_7) then
					local var_783_8 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_780_1.stage_.transform)

					var_783_8.name = var_783_6
					var_783_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_780_1.actors_[var_783_6] = var_783_8

					local var_783_9 = var_783_8:GetComponentInChildren(typeof(CharacterEffect))

					var_783_9.enabled = true

					local var_783_10 = GameObjectTools.GetOrAddComponent(var_783_8, typeof(DynamicBoneHelper))

					if var_783_10 then
						var_783_10:EnableDynamicBone(false)
					end

					arg_780_1:ShowWeapon(var_783_9.transform, false)

					arg_780_1.var_[var_783_6 .. "Animator"] = var_783_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_780_1.var_[var_783_6 .. "Animator"].applyRootMotion = true
					arg_780_1.var_[var_783_6 .. "LipSync"] = var_783_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_783_11 = 0

			if var_783_11 < arg_780_1.time_ and arg_780_1.time_ <= var_783_11 + arg_783_0 then
				arg_780_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_783_12 = arg_780_1.actors_["1034ui_story"]
			local var_783_13 = 0

			if var_783_13 < arg_780_1.time_ and arg_780_1.time_ <= var_783_13 + arg_783_0 and not isNil(var_783_12) and arg_780_1.var_.characterEffect1034ui_story == nil then
				arg_780_1.var_.characterEffect1034ui_story = var_783_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_783_14 = 0.2

			if var_783_13 <= arg_780_1.time_ and arg_780_1.time_ < var_783_13 + var_783_14 and not isNil(var_783_12) then
				local var_783_15 = (arg_780_1.time_ - var_783_13) / var_783_14

				if arg_780_1.var_.characterEffect1034ui_story and not isNil(var_783_12) then
					arg_780_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_780_1.time_ >= var_783_13 + var_783_14 and arg_780_1.time_ < var_783_13 + var_783_14 + arg_783_0 and not isNil(var_783_12) and arg_780_1.var_.characterEffect1034ui_story then
				arg_780_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_783_16 = 0
			local var_783_17 = 0.275

			if var_783_16 < arg_780_1.time_ and arg_780_1.time_ <= var_783_16 + arg_783_0 then
				arg_780_1.talkMaxDuration = 0
				arg_780_1.dialogCg_.alpha = 1

				arg_780_1.dialog_:SetActive(true)
				SetActive(arg_780_1.leftNameGo_, true)

				local var_783_18 = arg_780_1:FormatText(StoryNameCfg[1109].name)

				arg_780_1.leftNameTxt_.text = var_783_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_780_1.leftNameTxt_.transform)

				arg_780_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_780_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_780_1:RecordName(arg_780_1.leftNameTxt_.text)
				SetActive(arg_780_1.iconTrs_.gameObject, false)
				arg_780_1.callingController_:SetSelectedState("normal")

				local var_783_19 = arg_780_1:GetWordFromCfg(1103404060)
				local var_783_20 = arg_780_1:FormatText(var_783_19.content)

				arg_780_1.text_.text = var_783_20

				LuaForUtil.ClearLinePrefixSymbol(arg_780_1.text_)

				local var_783_21 = 11
				local var_783_22 = utf8.len(var_783_20)
				local var_783_23 = var_783_21 <= 0 and var_783_17 or var_783_17 * (var_783_22 / var_783_21)

				if var_783_23 > 0 and var_783_17 < var_783_23 then
					arg_780_1.talkMaxDuration = var_783_23

					if var_783_23 + var_783_16 > arg_780_1.duration_ then
						arg_780_1.duration_ = var_783_23 + var_783_16
					end
				end

				arg_780_1.text_.text = var_783_20
				arg_780_1.typewritter.percent = 0

				arg_780_1.typewritter:SetDirty()
				arg_780_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404060", "story_v_side_new_1103404.awb") ~= 0 then
					local var_783_24 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404060", "story_v_side_new_1103404.awb") / 1000

					if var_783_24 + var_783_16 > arg_780_1.duration_ then
						arg_780_1.duration_ = var_783_24 + var_783_16
					end

					if var_783_19.prefab_name ~= "" and arg_780_1.actors_[var_783_19.prefab_name] ~= nil then
						local var_783_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_780_1.actors_[var_783_19.prefab_name].transform, "story_v_side_new_1103404", "1103404060", "story_v_side_new_1103404.awb")

						arg_780_1:RecordAudio("1103404060", var_783_25)
						arg_780_1:RecordAudio("1103404060", var_783_25)
					else
						arg_780_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404060", "story_v_side_new_1103404.awb")
					end

					arg_780_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404060", "story_v_side_new_1103404.awb")
				end

				arg_780_1:RecordContent(arg_780_1.text_.text)
			end

			local var_783_26 = math.max(var_783_17, arg_780_1.talkMaxDuration)

			if var_783_16 <= arg_780_1.time_ and arg_780_1.time_ < var_783_16 + var_783_26 then
				arg_780_1.typewritter.percent = (arg_780_1.time_ - var_783_16) / var_783_26

				arg_780_1.typewritter:SetDirty()
			end

			if arg_780_1.time_ >= var_783_16 + var_783_26 and arg_780_1.time_ < var_783_16 + var_783_26 + arg_783_0 then
				arg_780_1.typewritter.percent = 1

				arg_780_1.typewritter:SetDirty()
				arg_780_1:ShowNextGo(true)
			end
		end

		arg_780_1.nodeConfigList_ = {}

		arg_780_1:InitPlayNodeList()
	end,
	Play1103404061 = function(arg_784_0, arg_784_1)
		arg_784_1.time_ = 0
		arg_784_1.frameCnt_ = 0
		arg_784_1.state_ = "playing"
		arg_784_1.curTalkId_ = 1103404061
		arg_784_1.duration_ = 5.1

		SetActive(arg_784_1.tipsGo_, false)

		function arg_784_1.onSingleLineFinish_()
			arg_784_1.onSingleLineUpdate_ = nil
			arg_784_1.onSingleLineFinish_ = nil
			arg_784_1.state_ = "waiting"
		end

		function arg_784_1.playNext_(arg_786_0)
			if arg_786_0 == 1 then
				arg_784_0:Play1103404062(arg_784_1)
			end
		end

		function arg_784_1.onSingleLineUpdate_(arg_787_0)
			local var_787_0 = 0

			if var_787_0 < arg_784_1.time_ and arg_784_1.time_ <= var_787_0 + arg_787_0 then
				arg_784_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganC", "EmotionTimelineAnimator")
			end

			local var_787_1 = 0
			local var_787_2 = 0.65

			if var_787_1 < arg_784_1.time_ and arg_784_1.time_ <= var_787_1 + arg_787_0 then
				arg_784_1.talkMaxDuration = 0
				arg_784_1.dialogCg_.alpha = 1

				arg_784_1.dialog_:SetActive(true)
				SetActive(arg_784_1.leftNameGo_, true)

				local var_787_3 = arg_784_1:FormatText(StoryNameCfg[1109].name)

				arg_784_1.leftNameTxt_.text = var_787_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_784_1.leftNameTxt_.transform)

				arg_784_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_784_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_784_1:RecordName(arg_784_1.leftNameTxt_.text)
				SetActive(arg_784_1.iconTrs_.gameObject, false)
				arg_784_1.callingController_:SetSelectedState("normal")

				local var_787_4 = arg_784_1:GetWordFromCfg(1103404061)
				local var_787_5 = arg_784_1:FormatText(var_787_4.content)

				arg_784_1.text_.text = var_787_5

				LuaForUtil.ClearLinePrefixSymbol(arg_784_1.text_)

				local var_787_6 = 26
				local var_787_7 = utf8.len(var_787_5)
				local var_787_8 = var_787_6 <= 0 and var_787_2 or var_787_2 * (var_787_7 / var_787_6)

				if var_787_8 > 0 and var_787_2 < var_787_8 then
					arg_784_1.talkMaxDuration = var_787_8

					if var_787_8 + var_787_1 > arg_784_1.duration_ then
						arg_784_1.duration_ = var_787_8 + var_787_1
					end
				end

				arg_784_1.text_.text = var_787_5
				arg_784_1.typewritter.percent = 0

				arg_784_1.typewritter:SetDirty()
				arg_784_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404061", "story_v_side_new_1103404.awb") ~= 0 then
					local var_787_9 = manager.audio:GetVoiceLength("story_v_side_new_1103404", "1103404061", "story_v_side_new_1103404.awb") / 1000

					if var_787_9 + var_787_1 > arg_784_1.duration_ then
						arg_784_1.duration_ = var_787_9 + var_787_1
					end

					if var_787_4.prefab_name ~= "" and arg_784_1.actors_[var_787_4.prefab_name] ~= nil then
						local var_787_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_784_1.actors_[var_787_4.prefab_name].transform, "story_v_side_new_1103404", "1103404061", "story_v_side_new_1103404.awb")

						arg_784_1:RecordAudio("1103404061", var_787_10)
						arg_784_1:RecordAudio("1103404061", var_787_10)
					else
						arg_784_1:AudioAction("play", "voice", "story_v_side_new_1103404", "1103404061", "story_v_side_new_1103404.awb")
					end

					arg_784_1:RecordHistoryTalkVoice("story_v_side_new_1103404", "1103404061", "story_v_side_new_1103404.awb")
				end

				arg_784_1:RecordContent(arg_784_1.text_.text)
			end

			local var_787_11 = math.max(var_787_2, arg_784_1.talkMaxDuration)

			if var_787_1 <= arg_784_1.time_ and arg_784_1.time_ < var_787_1 + var_787_11 then
				arg_784_1.typewritter.percent = (arg_784_1.time_ - var_787_1) / var_787_11

				arg_784_1.typewritter:SetDirty()
			end

			if arg_784_1.time_ >= var_787_1 + var_787_11 and arg_784_1.time_ < var_787_1 + var_787_11 + arg_787_0 then
				arg_784_1.typewritter.percent = 1

				arg_784_1.typewritter:SetDirty()
				arg_784_1:ShowNextGo(true)
			end
		end

		arg_784_1.nodeConfigList_ = {}

		arg_784_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I11p",
		"TextureConfig/Background/I11o",
		"TextureConfig/Background/R3401",
		"TextureConfig/Background/R3401a$naive"
	},
	voices = {
		"story_v_side_new_1103404.awb"
	}
}
