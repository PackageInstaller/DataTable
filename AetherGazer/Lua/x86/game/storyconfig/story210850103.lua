return {
	Play1108503001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 1108503001
		arg_1_1.duration_ = 11.27

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play1108503002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST20"

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
				local var_4_5 = arg_1_1.bgs_.ST20

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
					if iter_4_0 ~= "ST20" then
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

			local var_4_24 = "1037ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1037ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1037ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1037ui_story = var_4_29.localPosition
			end

			local var_4_31 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				local var_4_32 = (arg_1_1.time_ - var_4_30) / var_4_31
				local var_4_33 = Vector3.New(0, -1.09, -5.81)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1037ui_story, var_4_33, var_4_32)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_29.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_29.localEulerAngles = var_4_35
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_4_36 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_36.x, var_4_36.y, var_4_36.z)

				local var_4_37 = var_4_29.localEulerAngles

				var_4_37.z = 0
				var_4_37.x = 0
				var_4_29.localEulerAngles = var_4_37
			end

			local var_4_38 = arg_1_1.actors_["1037ui_story"]
			local var_4_39 = 1.8

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1037ui_story == nil then
				arg_1_1.var_.characterEffect1037ui_story = var_4_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_40 = 0.200000002980232

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 and not isNil(var_4_38) then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40

				if arg_1_1.var_.characterEffect1037ui_story and not isNil(var_4_38) then
					arg_1_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 and not isNil(var_4_38) and arg_1_1.var_.characterEffect1037ui_story then
				arg_1_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_4_42 = 1.8

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				arg_1_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
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

				arg_1_1:AudioAction(var_4_52, var_4_53, "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_4_54 = ""
				local var_4_55 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

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

			local var_4_56 = 0.3
			local var_4_57 = 1

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				local var_4_58 = "play"
				local var_4_59 = "effect"

				arg_1_1:AudioAction(var_4_58, var_4_59, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_60 = 2
			local var_4_61 = 0.8

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_62 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_62:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_62:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_62:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_63 = arg_1_1:FormatText(StoryNameCfg[15].name)

				arg_1_1.leftNameTxt_.text = var_4_63

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_64 = arg_1_1:GetWordFromCfg(1108503001)
				local var_4_65 = arg_1_1:FormatText(var_4_64.content)

				arg_1_1.text_.text = var_4_65

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_66 = 32
				local var_4_67 = utf8.len(var_4_65)
				local var_4_68 = var_4_66 <= 0 and var_4_61 or var_4_61 * (var_4_67 / var_4_66)

				if var_4_68 > 0 and var_4_61 < var_4_68 then
					arg_1_1.talkMaxDuration = var_4_68
					var_4_60 = var_4_60 + 0.3

					if var_4_68 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_68 + var_4_60
					end
				end

				arg_1_1.text_.text = var_4_65
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503001", "story_v_side_new_1108503.awb") ~= 0 then
					local var_4_69 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503001", "story_v_side_new_1108503.awb") / 1000

					if var_4_69 + var_4_60 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_60
					end

					if var_4_64.prefab_name ~= "" and arg_1_1.actors_[var_4_64.prefab_name] ~= nil then
						local var_4_70 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_64.prefab_name].transform, "story_v_side_new_1108503", "1108503001", "story_v_side_new_1108503.awb")

						arg_1_1:RecordAudio("1108503001", var_4_70)
						arg_1_1:RecordAudio("1108503001", var_4_70)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503001", "story_v_side_new_1108503.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503001", "story_v_side_new_1108503.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_71 = var_4_60 + 0.3
			local var_4_72 = math.max(var_4_61, arg_1_1.talkMaxDuration)

			if var_4_71 <= arg_1_1.time_ and arg_1_1.time_ < var_4_71 + var_4_72 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_71) / var_4_72

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_71 + var_4_72 and arg_1_1.time_ < var_4_71 + var_4_72 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play1108503002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 1108503002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play1108503003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1037ui_story"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos1037ui_story = var_12_0.localPosition
			end

			local var_12_2 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2
				local var_12_4 = Vector3.New(0, 100, 0)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1037ui_story, var_12_4, var_12_3)

				local var_12_5 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_5.x, var_12_5.y, var_12_5.z)

				local var_12_6 = var_12_0.localEulerAngles

				var_12_6.z = 0
				var_12_6.x = 0
				var_12_0.localEulerAngles = var_12_6
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, 100, 0)

				local var_12_7 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_7.x, var_12_7.y, var_12_7.z)

				local var_12_8 = var_12_0.localEulerAngles

				var_12_8.z = 0
				var_12_8.x = 0
				var_12_0.localEulerAngles = var_12_8
			end

			local var_12_9 = arg_9_1.actors_["1037ui_story"]
			local var_12_10 = 0

			if var_12_10 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 and not isNil(var_12_9) and arg_9_1.var_.characterEffect1037ui_story == nil then
				arg_9_1.var_.characterEffect1037ui_story = var_12_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_11 = 0.200000002980232

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_11 and not isNil(var_12_9) then
				local var_12_12 = (arg_9_1.time_ - var_12_10) / var_12_11

				if arg_9_1.var_.characterEffect1037ui_story and not isNil(var_12_9) then
					local var_12_13 = Mathf.Lerp(0, 0.5, var_12_12)

					arg_9_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1037ui_story.fillRatio = var_12_13
				end
			end

			if arg_9_1.time_ >= var_12_10 + var_12_11 and arg_9_1.time_ < var_12_10 + var_12_11 + arg_12_0 and not isNil(var_12_9) and arg_9_1.var_.characterEffect1037ui_story then
				local var_12_14 = 0.5

				arg_9_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1037ui_story.fillRatio = var_12_14
			end

			local var_12_15 = 0.433333333333333
			local var_12_16 = 1

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 then
				local var_12_17 = "play"
				local var_12_18 = "effect"

				arg_9_1:AudioAction(var_12_17, var_12_18, "se_story_144", "se_story_144_door_open", "")
			end

			local var_12_19 = 0
			local var_12_20 = 0.825

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_21 = arg_9_1:GetWordFromCfg(1108503002)
				local var_12_22 = arg_9_1:FormatText(var_12_21.content)

				arg_9_1.text_.text = var_12_22

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_23 = 33
				local var_12_24 = utf8.len(var_12_22)
				local var_12_25 = var_12_23 <= 0 and var_12_20 or var_12_20 * (var_12_24 / var_12_23)

				if var_12_25 > 0 and var_12_20 < var_12_25 then
					arg_9_1.talkMaxDuration = var_12_25

					if var_12_25 + var_12_19 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_25 + var_12_19
					end
				end

				arg_9_1.text_.text = var_12_22
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_26 = math.max(var_12_20, arg_9_1.talkMaxDuration)

			if var_12_19 <= arg_9_1.time_ and arg_9_1.time_ < var_12_19 + var_12_26 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_19) / var_12_26

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_19 + var_12_26 and arg_9_1.time_ < var_12_19 + var_12_26 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
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
	Play1108503003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 1108503003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play1108503004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0
			local var_16_1 = 0.175

			if var_16_0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_2 = arg_13_1:FormatText(StoryNameCfg[7].name)

				arg_13_1.leftNameTxt_.text = var_16_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:GetWordFromCfg(1108503003)
				local var_16_4 = arg_13_1:FormatText(var_16_3.content)

				arg_13_1.text_.text = var_16_4

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 7
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
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_8 and arg_13_1.time_ < var_16_0 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play1108503004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 1108503004
		arg_17_1.duration_ = 5.1

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play1108503005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1037ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1037ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, -1.09, -5.81)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1037ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1037ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1037ui_story == nil then
				arg_17_1.var_.characterEffect1037ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect1037ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1037ui_story then
				arg_17_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_20_13 = 0

			if var_20_13 < arg_17_1.time_ and arg_17_1.time_ <= var_20_13 + arg_20_0 then
				arg_17_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			local var_20_14 = 0

			if var_20_14 < arg_17_1.time_ and arg_17_1.time_ <= var_20_14 + arg_20_0 then
				arg_17_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_20_15 = 0
			local var_20_16 = 0.625

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				local var_20_17 = arg_17_1:FormatText(StoryNameCfg[15].name)

				arg_17_1.leftNameTxt_.text = var_20_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_18 = arg_17_1:GetWordFromCfg(1108503004)
				local var_20_19 = arg_17_1:FormatText(var_20_18.content)

				arg_17_1.text_.text = var_20_19

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_20 = 25
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503004", "story_v_side_new_1108503.awb") ~= 0 then
					local var_20_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503004", "story_v_side_new_1108503.awb") / 1000

					if var_20_23 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_23 + var_20_15
					end

					if var_20_18.prefab_name ~= "" and arg_17_1.actors_[var_20_18.prefab_name] ~= nil then
						local var_20_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_18.prefab_name].transform, "story_v_side_new_1108503", "1108503004", "story_v_side_new_1108503.awb")

						arg_17_1:RecordAudio("1108503004", var_20_24)
						arg_17_1:RecordAudio("1108503004", var_20_24)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503004", "story_v_side_new_1108503.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503004", "story_v_side_new_1108503.awb")
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
				actorName = "1037ui_story",
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
	Play1108503005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 1108503005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play1108503006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1037ui_story"]
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1037ui_story == nil then
				arg_21_1.var_.characterEffect1037ui_story = var_24_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 and not isNil(var_24_0) then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2

				if arg_21_1.var_.characterEffect1037ui_story and not isNil(var_24_0) then
					local var_24_4 = Mathf.Lerp(0, 0.5, var_24_3)

					arg_21_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1037ui_story.fillRatio = var_24_4
				end
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 and not isNil(var_24_0) and arg_21_1.var_.characterEffect1037ui_story then
				local var_24_5 = 0.5

				arg_21_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1037ui_story.fillRatio = var_24_5
			end

			local var_24_6 = 0
			local var_24_7 = 0.55

			if var_24_6 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_8 = arg_21_1:FormatText(StoryNameCfg[7].name)

				arg_21_1.leftNameTxt_.text = var_24_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_9 = arg_21_1:GetWordFromCfg(1108503005)
				local var_24_10 = arg_21_1:FormatText(var_24_9.content)

				arg_21_1.text_.text = var_24_10

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_11 = 22
				local var_24_12 = utf8.len(var_24_10)
				local var_24_13 = var_24_11 <= 0 and var_24_7 or var_24_7 * (var_24_12 / var_24_11)

				if var_24_13 > 0 and var_24_7 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_10
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_14 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_14 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_14

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_14 and arg_21_1.time_ < var_24_6 + var_24_14 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play1108503006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 1108503006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play1108503007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 0.275

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_2 = arg_25_1:FormatText(StoryNameCfg[7].name)

				arg_25_1.leftNameTxt_.text = var_28_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(1108503006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_5 = 11
				local var_28_6 = utf8.len(var_28_4)
				local var_28_7 = var_28_5 <= 0 and var_28_1 or var_28_1 * (var_28_6 / var_28_5)

				if var_28_7 > 0 and var_28_1 < var_28_7 then
					arg_25_1.talkMaxDuration = var_28_7

					if var_28_7 + var_28_0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_0
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_8 = math.max(var_28_1, arg_25_1.talkMaxDuration)

			if var_28_0 <= arg_25_1.time_ and arg_25_1.time_ < var_28_0 + var_28_8 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_0) / var_28_8

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_0 + var_28_8 and arg_25_1.time_ < var_28_0 + var_28_8 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play1108503007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 1108503007
		arg_29_1.duration_ = 5.93

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play1108503008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1037ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1037ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0, -1.09, -5.81)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1037ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["1037ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1037ui_story == nil then
				arg_29_1.var_.characterEffect1037ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect1037ui_story and not isNil(var_32_9) then
					arg_29_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1037ui_story then
				arg_29_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_32_13 = 0

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_32_15 = 0
			local var_32_16 = 0.625

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_17 = arg_29_1:FormatText(StoryNameCfg[15].name)

				arg_29_1.leftNameTxt_.text = var_32_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(1108503007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_20 = 25
				local var_32_21 = utf8.len(var_32_19)
				local var_32_22 = var_32_20 <= 0 and var_32_16 or var_32_16 * (var_32_21 / var_32_20)

				if var_32_22 > 0 and var_32_16 < var_32_22 then
					arg_29_1.talkMaxDuration = var_32_22

					if var_32_22 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_22 + var_32_15
					end
				end

				arg_29_1.text_.text = var_32_19
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503007", "story_v_side_new_1108503.awb") ~= 0 then
					local var_32_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503007", "story_v_side_new_1108503.awb") / 1000

					if var_32_23 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_15
					end

					if var_32_18.prefab_name ~= "" and arg_29_1.actors_[var_32_18.prefab_name] ~= nil then
						local var_32_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_18.prefab_name].transform, "story_v_side_new_1108503", "1108503007", "story_v_side_new_1108503.awb")

						arg_29_1:RecordAudio("1108503007", var_32_24)
						arg_29_1:RecordAudio("1108503007", var_32_24)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503007", "story_v_side_new_1108503.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503007", "story_v_side_new_1108503.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_25 = math.max(var_32_16, arg_29_1.talkMaxDuration)

			if var_32_15 <= arg_29_1.time_ and arg_29_1.time_ < var_32_15 + var_32_25 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_15) / var_32_25

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_15 + var_32_25 and arg_29_1.time_ < var_32_15 + var_32_25 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play1108503008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 1108503008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play1108503009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = arg_33_1.actors_["1037ui_story"]
			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1037ui_story == nil then
				arg_33_1.var_.characterEffect1037ui_story = var_36_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_2 and not isNil(var_36_0) then
				local var_36_3 = (arg_33_1.time_ - var_36_1) / var_36_2

				if arg_33_1.var_.characterEffect1037ui_story and not isNil(var_36_0) then
					local var_36_4 = Mathf.Lerp(0, 0.5, var_36_3)

					arg_33_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1037ui_story.fillRatio = var_36_4
				end
			end

			if arg_33_1.time_ >= var_36_1 + var_36_2 and arg_33_1.time_ < var_36_1 + var_36_2 + arg_36_0 and not isNil(var_36_0) and arg_33_1.var_.characterEffect1037ui_story then
				local var_36_5 = 0.5

				arg_33_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1037ui_story.fillRatio = var_36_5
			end

			local var_36_6 = 0
			local var_36_7 = 0.775

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[7].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_9 = arg_33_1:GetWordFromCfg(1108503008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 31
				local var_36_12 = utf8.len(var_36_10)
				local var_36_13 = var_36_11 <= 0 and var_36_7 or var_36_7 * (var_36_12 / var_36_11)

				if var_36_13 > 0 and var_36_7 < var_36_13 then
					arg_33_1.talkMaxDuration = var_36_13

					if var_36_13 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_13 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_10
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play1108503009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 1108503009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play1108503010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1037ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1037ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(0, 100, 0)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1037ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(0, 100, 0)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = 0
			local var_40_10 = 0.625

			if var_40_9 < arg_37_1.time_ and arg_37_1.time_ <= var_40_9 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_11 = arg_37_1:GetWordFromCfg(1108503009)
				local var_40_12 = arg_37_1:FormatText(var_40_11.content)

				arg_37_1.text_.text = var_40_12

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_13 = 25
				local var_40_14 = utf8.len(var_40_12)
				local var_40_15 = var_40_13 <= 0 and var_40_10 or var_40_10 * (var_40_14 / var_40_13)

				if var_40_15 > 0 and var_40_10 < var_40_15 then
					arg_37_1.talkMaxDuration = var_40_15

					if var_40_15 + var_40_9 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_15 + var_40_9
					end
				end

				arg_37_1.text_.text = var_40_12
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = math.max(var_40_10, arg_37_1.talkMaxDuration)

			if var_40_9 <= arg_37_1.time_ and arg_37_1.time_ < var_40_9 + var_40_16 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_9) / var_40_16

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_9 + var_40_16 and arg_37_1.time_ < var_40_9 + var_40_16 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play1108503010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 1108503010
		arg_41_1.duration_ = 9.17

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play1108503011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1037ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1037ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(-0.7, -1.09, -5.81)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1037ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(-0.7, -1.09, -5.81)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["1037ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1037ui_story == nil then
				arg_41_1.var_.characterEffect1037ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect1037ui_story and not isNil(var_44_9) then
					arg_41_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1037ui_story then
				arg_41_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_44_13 = 0

			if var_44_13 < arg_41_1.time_ and arg_41_1.time_ <= var_44_13 + arg_44_0 then
				arg_41_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action4_1")
			end

			local var_44_14 = 0

			if var_44_14 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 then
				arg_41_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_44_15 = 0
			local var_44_16 = 0.875

			if var_44_15 < arg_41_1.time_ and arg_41_1.time_ <= var_44_15 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_17 = arg_41_1:FormatText(StoryNameCfg[15].name)

				arg_41_1.leftNameTxt_.text = var_44_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_18 = arg_41_1:GetWordFromCfg(1108503010)
				local var_44_19 = arg_41_1:FormatText(var_44_18.content)

				arg_41_1.text_.text = var_44_19

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_20 = 35
				local var_44_21 = utf8.len(var_44_19)
				local var_44_22 = var_44_20 <= 0 and var_44_16 or var_44_16 * (var_44_21 / var_44_20)

				if var_44_22 > 0 and var_44_16 < var_44_22 then
					arg_41_1.talkMaxDuration = var_44_22

					if var_44_22 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_22 + var_44_15
					end
				end

				arg_41_1.text_.text = var_44_19
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503010", "story_v_side_new_1108503.awb") ~= 0 then
					local var_44_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503010", "story_v_side_new_1108503.awb") / 1000

					if var_44_23 + var_44_15 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_15
					end

					if var_44_18.prefab_name ~= "" and arg_41_1.actors_[var_44_18.prefab_name] ~= nil then
						local var_44_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_18.prefab_name].transform, "story_v_side_new_1108503", "1108503010", "story_v_side_new_1108503.awb")

						arg_41_1:RecordAudio("1108503010", var_44_24)
						arg_41_1:RecordAudio("1108503010", var_44_24)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503010", "story_v_side_new_1108503.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503010", "story_v_side_new_1108503.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_25 = math.max(var_44_16, arg_41_1.talkMaxDuration)

			if var_44_15 <= arg_41_1.time_ and arg_41_1.time_ < var_44_15 + var_44_25 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_15) / var_44_25

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_15 + var_44_25 and arg_41_1.time_ < var_44_15 + var_44_25 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play1108503011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 1108503011
		arg_45_1.duration_ = 3.57

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play1108503012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = "1085ui_story"

			if arg_45_1.actors_[var_48_0] == nil then
				local var_48_1 = Asset.Load("Char/" .. "1085ui_story")

				if not isNil(var_48_1) then
					local var_48_2 = Object.Instantiate(Asset.Load("Char/" .. "1085ui_story"), arg_45_1.stage_.transform)

					var_48_2.name = var_48_0
					var_48_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_45_1.actors_[var_48_0] = var_48_2

					local var_48_3 = var_48_2:GetComponentInChildren(typeof(CharacterEffect))

					var_48_3.enabled = true

					local var_48_4 = GameObjectTools.GetOrAddComponent(var_48_2, typeof(DynamicBoneHelper))

					if var_48_4 then
						var_48_4:EnableDynamicBone(false)
					end

					arg_45_1:ShowWeapon(var_48_3.transform, false)

					arg_45_1.var_[var_48_0 .. "Animator"] = var_48_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_45_1.var_[var_48_0 .. "Animator"].applyRootMotion = true
					arg_45_1.var_[var_48_0 .. "LipSync"] = var_48_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_48_5 = arg_45_1.actors_["1085ui_story"].transform
			local var_48_6 = 0

			if var_48_6 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.var_.moveOldPos1085ui_story = var_48_5.localPosition
			end

			local var_48_7 = 0.001

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_7 then
				local var_48_8 = (arg_45_1.time_ - var_48_6) / var_48_7
				local var_48_9 = Vector3.New(0.75, -1.01, -5.83)

				var_48_5.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1085ui_story, var_48_9, var_48_8)

				local var_48_10 = manager.ui.mainCamera.transform.position - var_48_5.position

				var_48_5.forward = Vector3.New(var_48_10.x, var_48_10.y, var_48_10.z)

				local var_48_11 = var_48_5.localEulerAngles

				var_48_11.z = 0
				var_48_11.x = 0
				var_48_5.localEulerAngles = var_48_11
			end

			if arg_45_1.time_ >= var_48_6 + var_48_7 and arg_45_1.time_ < var_48_6 + var_48_7 + arg_48_0 then
				var_48_5.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_48_12 = manager.ui.mainCamera.transform.position - var_48_5.position

				var_48_5.forward = Vector3.New(var_48_12.x, var_48_12.y, var_48_12.z)

				local var_48_13 = var_48_5.localEulerAngles

				var_48_13.z = 0
				var_48_13.x = 0
				var_48_5.localEulerAngles = var_48_13
			end

			local var_48_14 = arg_45_1.actors_["1085ui_story"]
			local var_48_15 = 0

			if var_48_15 < arg_45_1.time_ and arg_45_1.time_ <= var_48_15 + arg_48_0 and not isNil(var_48_14) and arg_45_1.var_.characterEffect1085ui_story == nil then
				arg_45_1.var_.characterEffect1085ui_story = var_48_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_16 = 0.200000002980232

			if var_48_15 <= arg_45_1.time_ and arg_45_1.time_ < var_48_15 + var_48_16 and not isNil(var_48_14) then
				local var_48_17 = (arg_45_1.time_ - var_48_15) / var_48_16

				if arg_45_1.var_.characterEffect1085ui_story and not isNil(var_48_14) then
					arg_45_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_15 + var_48_16 and arg_45_1.time_ < var_48_15 + var_48_16 + arg_48_0 and not isNil(var_48_14) and arg_45_1.var_.characterEffect1085ui_story then
				arg_45_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_48_18 = arg_45_1.actors_["1037ui_story"]
			local var_48_19 = 0

			if var_48_19 < arg_45_1.time_ and arg_45_1.time_ <= var_48_19 + arg_48_0 and not isNil(var_48_18) and arg_45_1.var_.characterEffect1037ui_story == nil then
				arg_45_1.var_.characterEffect1037ui_story = var_48_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_20 = 0.200000002980232

			if var_48_19 <= arg_45_1.time_ and arg_45_1.time_ < var_48_19 + var_48_20 and not isNil(var_48_18) then
				local var_48_21 = (arg_45_1.time_ - var_48_19) / var_48_20

				if arg_45_1.var_.characterEffect1037ui_story and not isNil(var_48_18) then
					local var_48_22 = Mathf.Lerp(0, 0.5, var_48_21)

					arg_45_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1037ui_story.fillRatio = var_48_22
				end
			end

			if arg_45_1.time_ >= var_48_19 + var_48_20 and arg_45_1.time_ < var_48_19 + var_48_20 + arg_48_0 and not isNil(var_48_18) and arg_45_1.var_.characterEffect1037ui_story then
				local var_48_23 = 0.5

				arg_45_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1037ui_story.fillRatio = var_48_23
			end

			local var_48_24 = 0

			if var_48_24 < arg_45_1.time_ and arg_45_1.time_ <= var_48_24 + arg_48_0 then
				arg_45_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_48_25 = 0

			if var_48_25 < arg_45_1.time_ and arg_45_1.time_ <= var_48_25 + arg_48_0 then
				arg_45_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_48_26 = 0
			local var_48_27 = 0.25

			if var_48_26 < arg_45_1.time_ and arg_45_1.time_ <= var_48_26 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_28 = arg_45_1:FormatText(StoryNameCfg[328].name)

				arg_45_1.leftNameTxt_.text = var_48_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_29 = arg_45_1:GetWordFromCfg(1108503011)
				local var_48_30 = arg_45_1:FormatText(var_48_29.content)

				arg_45_1.text_.text = var_48_30

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_31 = 10
				local var_48_32 = utf8.len(var_48_30)
				local var_48_33 = var_48_31 <= 0 and var_48_27 or var_48_27 * (var_48_32 / var_48_31)

				if var_48_33 > 0 and var_48_27 < var_48_33 then
					arg_45_1.talkMaxDuration = var_48_33

					if var_48_33 + var_48_26 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_33 + var_48_26
					end
				end

				arg_45_1.text_.text = var_48_30
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503011", "story_v_side_new_1108503.awb") ~= 0 then
					local var_48_34 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503011", "story_v_side_new_1108503.awb") / 1000

					if var_48_34 + var_48_26 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_34 + var_48_26
					end

					if var_48_29.prefab_name ~= "" and arg_45_1.actors_[var_48_29.prefab_name] ~= nil then
						local var_48_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_29.prefab_name].transform, "story_v_side_new_1108503", "1108503011", "story_v_side_new_1108503.awb")

						arg_45_1:RecordAudio("1108503011", var_48_35)
						arg_45_1:RecordAudio("1108503011", var_48_35)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503011", "story_v_side_new_1108503.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503011", "story_v_side_new_1108503.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_36 = math.max(var_48_27, arg_45_1.talkMaxDuration)

			if var_48_26 <= arg_45_1.time_ and arg_45_1.time_ < var_48_26 + var_48_36 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_26) / var_48_36

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_26 + var_48_36 and arg_45_1.time_ < var_48_26 + var_48_36 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play1108503012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 1108503012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play1108503013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1085ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1085ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0, 100, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1085ui_story, var_52_4, var_52_3)

				local var_52_5 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_5.x, var_52_5.y, var_52_5.z)

				local var_52_6 = var_52_0.localEulerAngles

				var_52_6.z = 0
				var_52_6.x = 0
				var_52_0.localEulerAngles = var_52_6
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 then
				var_52_0.localPosition = Vector3.New(0, 100, 0)

				local var_52_7 = manager.ui.mainCamera.transform.position - var_52_0.position

				var_52_0.forward = Vector3.New(var_52_7.x, var_52_7.y, var_52_7.z)

				local var_52_8 = var_52_0.localEulerAngles

				var_52_8.z = 0
				var_52_8.x = 0
				var_52_0.localEulerAngles = var_52_8
			end

			local var_52_9 = arg_49_1.actors_["1037ui_story"].transform
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.var_.moveOldPos1037ui_story = var_52_9.localPosition
			end

			local var_52_11 = 0.001

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_11 then
				local var_52_12 = (arg_49_1.time_ - var_52_10) / var_52_11
				local var_52_13 = Vector3.New(0, 100, 0)

				var_52_9.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1037ui_story, var_52_13, var_52_12)

				local var_52_14 = manager.ui.mainCamera.transform.position - var_52_9.position

				var_52_9.forward = Vector3.New(var_52_14.x, var_52_14.y, var_52_14.z)

				local var_52_15 = var_52_9.localEulerAngles

				var_52_15.z = 0
				var_52_15.x = 0
				var_52_9.localEulerAngles = var_52_15
			end

			if arg_49_1.time_ >= var_52_10 + var_52_11 and arg_49_1.time_ < var_52_10 + var_52_11 + arg_52_0 then
				var_52_9.localPosition = Vector3.New(0, 100, 0)

				local var_52_16 = manager.ui.mainCamera.transform.position - var_52_9.position

				var_52_9.forward = Vector3.New(var_52_16.x, var_52_16.y, var_52_16.z)

				local var_52_17 = var_52_9.localEulerAngles

				var_52_17.z = 0
				var_52_17.x = 0
				var_52_9.localEulerAngles = var_52_17
			end

			local var_52_18 = arg_49_1.actors_["1085ui_story"]
			local var_52_19 = 0

			if var_52_19 < arg_49_1.time_ and arg_49_1.time_ <= var_52_19 + arg_52_0 and not isNil(var_52_18) and arg_49_1.var_.characterEffect1085ui_story == nil then
				arg_49_1.var_.characterEffect1085ui_story = var_52_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_20 = 0.200000002980232

			if var_52_19 <= arg_49_1.time_ and arg_49_1.time_ < var_52_19 + var_52_20 and not isNil(var_52_18) then
				local var_52_21 = (arg_49_1.time_ - var_52_19) / var_52_20

				if arg_49_1.var_.characterEffect1085ui_story and not isNil(var_52_18) then
					local var_52_22 = Mathf.Lerp(0, 0.5, var_52_21)

					arg_49_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1085ui_story.fillRatio = var_52_22
				end
			end

			if arg_49_1.time_ >= var_52_19 + var_52_20 and arg_49_1.time_ < var_52_19 + var_52_20 + arg_52_0 and not isNil(var_52_18) and arg_49_1.var_.characterEffect1085ui_story then
				local var_52_23 = 0.5

				arg_49_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1085ui_story.fillRatio = var_52_23
			end

			local var_52_24 = 0
			local var_52_25 = 0.625

			if var_52_24 < arg_49_1.time_ and arg_49_1.time_ <= var_52_24 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, false)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_26 = arg_49_1:GetWordFromCfg(1108503012)
				local var_52_27 = arg_49_1:FormatText(var_52_26.content)

				arg_49_1.text_.text = var_52_27

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_28 = 25
				local var_52_29 = utf8.len(var_52_27)
				local var_52_30 = var_52_28 <= 0 and var_52_25 or var_52_25 * (var_52_29 / var_52_28)

				if var_52_30 > 0 and var_52_25 < var_52_30 then
					arg_49_1.talkMaxDuration = var_52_30

					if var_52_30 + var_52_24 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_30 + var_52_24
					end
				end

				arg_49_1.text_.text = var_52_27
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_31 = math.max(var_52_25, arg_49_1.talkMaxDuration)

			if var_52_24 <= arg_49_1.time_ and arg_49_1.time_ < var_52_24 + var_52_31 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_24) / var_52_31

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_24 + var_52_31 and arg_49_1.time_ < var_52_24 + var_52_31 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play1108503013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 1108503013
		arg_53_1.duration_ = 2.93

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play1108503014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1085ui_story"].transform
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1.var_.moveOldPos1085ui_story = var_56_0.localPosition
			end

			local var_56_2 = 0.001

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2
				local var_56_4 = Vector3.New(0.75, -1.01, -5.83)

				var_56_0.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1085ui_story, var_56_4, var_56_3)

				local var_56_5 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_5.x, var_56_5.y, var_56_5.z)

				local var_56_6 = var_56_0.localEulerAngles

				var_56_6.z = 0
				var_56_6.x = 0
				var_56_0.localEulerAngles = var_56_6
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 then
				var_56_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_56_7 = manager.ui.mainCamera.transform.position - var_56_0.position

				var_56_0.forward = Vector3.New(var_56_7.x, var_56_7.y, var_56_7.z)

				local var_56_8 = var_56_0.localEulerAngles

				var_56_8.z = 0
				var_56_8.x = 0
				var_56_0.localEulerAngles = var_56_8
			end

			local var_56_9 = arg_53_1.actors_["1085ui_story"]
			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1085ui_story == nil then
				arg_53_1.var_.characterEffect1085ui_story = var_56_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_11 = 0.200000002980232

			if var_56_10 <= arg_53_1.time_ and arg_53_1.time_ < var_56_10 + var_56_11 and not isNil(var_56_9) then
				local var_56_12 = (arg_53_1.time_ - var_56_10) / var_56_11

				if arg_53_1.var_.characterEffect1085ui_story and not isNil(var_56_9) then
					arg_53_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_10 + var_56_11 and arg_53_1.time_ < var_56_10 + var_56_11 + arg_56_0 and not isNil(var_56_9) and arg_53_1.var_.characterEffect1085ui_story then
				arg_53_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_56_13 = 0

			if var_56_13 < arg_53_1.time_ and arg_53_1.time_ <= var_56_13 + arg_56_0 then
				arg_53_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_56_14 = 0

			if var_56_14 < arg_53_1.time_ and arg_53_1.time_ <= var_56_14 + arg_56_0 then
				arg_53_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_56_15 = 0
			local var_56_16 = 0.1

			if var_56_15 < arg_53_1.time_ and arg_53_1.time_ <= var_56_15 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_17 = arg_53_1:FormatText(StoryNameCfg[328].name)

				arg_53_1.leftNameTxt_.text = var_56_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_18 = arg_53_1:GetWordFromCfg(1108503013)
				local var_56_19 = arg_53_1:FormatText(var_56_18.content)

				arg_53_1.text_.text = var_56_19

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_20 = 4
				local var_56_21 = utf8.len(var_56_19)
				local var_56_22 = var_56_20 <= 0 and var_56_16 or var_56_16 * (var_56_21 / var_56_20)

				if var_56_22 > 0 and var_56_16 < var_56_22 then
					arg_53_1.talkMaxDuration = var_56_22

					if var_56_22 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_22 + var_56_15
					end
				end

				arg_53_1.text_.text = var_56_19
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503013", "story_v_side_new_1108503.awb") ~= 0 then
					local var_56_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503013", "story_v_side_new_1108503.awb") / 1000

					if var_56_23 + var_56_15 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_23 + var_56_15
					end

					if var_56_18.prefab_name ~= "" and arg_53_1.actors_[var_56_18.prefab_name] ~= nil then
						local var_56_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_18.prefab_name].transform, "story_v_side_new_1108503", "1108503013", "story_v_side_new_1108503.awb")

						arg_53_1:RecordAudio("1108503013", var_56_24)
						arg_53_1:RecordAudio("1108503013", var_56_24)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503013", "story_v_side_new_1108503.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503013", "story_v_side_new_1108503.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_25 = math.max(var_56_16, arg_53_1.talkMaxDuration)

			if var_56_15 <= arg_53_1.time_ and arg_53_1.time_ < var_56_15 + var_56_25 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_15) / var_56_25

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_15 + var_56_25 and arg_53_1.time_ < var_56_15 + var_56_25 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
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

		arg_53_1:InitPlayNodeList()
	end,
	Play1108503014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 1108503014
		arg_57_1.duration_ = 8

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play1108503015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1037ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1037ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(-0.7, -1.09, -5.81)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1037ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(-0.7, -1.09, -5.81)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["1037ui_story"]
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1037ui_story == nil then
				arg_57_1.var_.characterEffect1037ui_story = var_60_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.200000002980232

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 and not isNil(var_60_9) then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.characterEffect1037ui_story and not isNil(var_60_9) then
					arg_57_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1037ui_story then
				arg_57_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_60_13 = arg_57_1.actors_["1085ui_story"]
			local var_60_14 = 0

			if var_60_14 < arg_57_1.time_ and arg_57_1.time_ <= var_60_14 + arg_60_0 and not isNil(var_60_13) and arg_57_1.var_.characterEffect1085ui_story == nil then
				arg_57_1.var_.characterEffect1085ui_story = var_60_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_15 = 0.200000002980232

			if var_60_14 <= arg_57_1.time_ and arg_57_1.time_ < var_60_14 + var_60_15 and not isNil(var_60_13) then
				local var_60_16 = (arg_57_1.time_ - var_60_14) / var_60_15

				if arg_57_1.var_.characterEffect1085ui_story and not isNil(var_60_13) then
					local var_60_17 = Mathf.Lerp(0, 0.5, var_60_16)

					arg_57_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1085ui_story.fillRatio = var_60_17
				end
			end

			if arg_57_1.time_ >= var_60_14 + var_60_15 and arg_57_1.time_ < var_60_14 + var_60_15 + arg_60_0 and not isNil(var_60_13) and arg_57_1.var_.characterEffect1085ui_story then
				local var_60_18 = 0.5

				arg_57_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1085ui_story.fillRatio = var_60_18
			end

			local var_60_19 = 0

			if var_60_19 < arg_57_1.time_ and arg_57_1.time_ <= var_60_19 + arg_60_0 then
				arg_57_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_60_20 = 0

			if var_60_20 < arg_57_1.time_ and arg_57_1.time_ <= var_60_20 + arg_60_0 then
				arg_57_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_60_21 = 0
			local var_60_22 = 1.025

			if var_60_21 < arg_57_1.time_ and arg_57_1.time_ <= var_60_21 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_23 = arg_57_1:FormatText(StoryNameCfg[15].name)

				arg_57_1.leftNameTxt_.text = var_60_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_24 = arg_57_1:GetWordFromCfg(1108503014)
				local var_60_25 = arg_57_1:FormatText(var_60_24.content)

				arg_57_1.text_.text = var_60_25

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_26 = 41
				local var_60_27 = utf8.len(var_60_25)
				local var_60_28 = var_60_26 <= 0 and var_60_22 or var_60_22 * (var_60_27 / var_60_26)

				if var_60_28 > 0 and var_60_22 < var_60_28 then
					arg_57_1.talkMaxDuration = var_60_28

					if var_60_28 + var_60_21 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_28 + var_60_21
					end
				end

				arg_57_1.text_.text = var_60_25
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503014", "story_v_side_new_1108503.awb") ~= 0 then
					local var_60_29 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503014", "story_v_side_new_1108503.awb") / 1000

					if var_60_29 + var_60_21 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_29 + var_60_21
					end

					if var_60_24.prefab_name ~= "" and arg_57_1.actors_[var_60_24.prefab_name] ~= nil then
						local var_60_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_24.prefab_name].transform, "story_v_side_new_1108503", "1108503014", "story_v_side_new_1108503.awb")

						arg_57_1:RecordAudio("1108503014", var_60_30)
						arg_57_1:RecordAudio("1108503014", var_60_30)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503014", "story_v_side_new_1108503.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503014", "story_v_side_new_1108503.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_31 = math.max(var_60_22, arg_57_1.talkMaxDuration)

			if var_60_21 <= arg_57_1.time_ and arg_57_1.time_ < var_60_21 + var_60_31 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_21) / var_60_31

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_21 + var_60_31 and arg_57_1.time_ < var_60_21 + var_60_31 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play1108503015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 1108503015
		arg_61_1.duration_ = 7.93

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play1108503016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1037ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1037ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(-0.7, -1.09, -5.81)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1037ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(-0.7, -1.09, -5.81)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = 0

			if var_64_9 < arg_61_1.time_ and arg_61_1.time_ <= var_64_9 + arg_64_0 then
				arg_61_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_2")
			end

			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 then
				arg_61_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_64_11 = 0
			local var_64_12 = 1

			if var_64_11 < arg_61_1.time_ and arg_61_1.time_ <= var_64_11 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_13 = arg_61_1:FormatText(StoryNameCfg[15].name)

				arg_61_1.leftNameTxt_.text = var_64_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_14 = arg_61_1:GetWordFromCfg(1108503015)
				local var_64_15 = arg_61_1:FormatText(var_64_14.content)

				arg_61_1.text_.text = var_64_15

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_16 = 40
				local var_64_17 = utf8.len(var_64_15)
				local var_64_18 = var_64_16 <= 0 and var_64_12 or var_64_12 * (var_64_17 / var_64_16)

				if var_64_18 > 0 and var_64_12 < var_64_18 then
					arg_61_1.talkMaxDuration = var_64_18

					if var_64_18 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_18 + var_64_11
					end
				end

				arg_61_1.text_.text = var_64_15
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503015", "story_v_side_new_1108503.awb") ~= 0 then
					local var_64_19 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503015", "story_v_side_new_1108503.awb") / 1000

					if var_64_19 + var_64_11 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_19 + var_64_11
					end

					if var_64_14.prefab_name ~= "" and arg_61_1.actors_[var_64_14.prefab_name] ~= nil then
						local var_64_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_14.prefab_name].transform, "story_v_side_new_1108503", "1108503015", "story_v_side_new_1108503.awb")

						arg_61_1:RecordAudio("1108503015", var_64_20)
						arg_61_1:RecordAudio("1108503015", var_64_20)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503015", "story_v_side_new_1108503.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503015", "story_v_side_new_1108503.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_21 = math.max(var_64_12, arg_61_1.talkMaxDuration)

			if var_64_11 <= arg_61_1.time_ and arg_61_1.time_ < var_64_11 + var_64_21 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_11) / var_64_21

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_11 + var_64_21 and arg_61_1.time_ < var_64_11 + var_64_21 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play1108503016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 1108503016
		arg_65_1.duration_ = 2

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play1108503017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1085ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1085ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0.75, -1.01, -5.83)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1085ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["1085ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1085ui_story == nil then
				arg_65_1.var_.characterEffect1085ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect1085ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1085ui_story then
				arg_65_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_68_13 = arg_65_1.actors_["1037ui_story"]
			local var_68_14 = 0

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 and not isNil(var_68_13) and arg_65_1.var_.characterEffect1037ui_story == nil then
				arg_65_1.var_.characterEffect1037ui_story = var_68_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_15 = 0.200000002980232

			if var_68_14 <= arg_65_1.time_ and arg_65_1.time_ < var_68_14 + var_68_15 and not isNil(var_68_13) then
				local var_68_16 = (arg_65_1.time_ - var_68_14) / var_68_15

				if arg_65_1.var_.characterEffect1037ui_story and not isNil(var_68_13) then
					local var_68_17 = Mathf.Lerp(0, 0.5, var_68_16)

					arg_65_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1037ui_story.fillRatio = var_68_17
				end
			end

			if arg_65_1.time_ >= var_68_14 + var_68_15 and arg_65_1.time_ < var_68_14 + var_68_15 + arg_68_0 and not isNil(var_68_13) and arg_65_1.var_.characterEffect1037ui_story then
				local var_68_18 = 0.5

				arg_65_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1037ui_story.fillRatio = var_68_18
			end

			local var_68_19 = 0

			if var_68_19 < arg_65_1.time_ and arg_65_1.time_ <= var_68_19 + arg_68_0 then
				arg_65_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action423")
			end

			local var_68_20 = 0

			if var_68_20 < arg_65_1.time_ and arg_65_1.time_ <= var_68_20 + arg_68_0 then
				arg_65_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_68_21 = 0
			local var_68_22 = 0.125

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_23 = arg_65_1:FormatText(StoryNameCfg[328].name)

				arg_65_1.leftNameTxt_.text = var_68_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_24 = arg_65_1:GetWordFromCfg(1108503016)
				local var_68_25 = arg_65_1:FormatText(var_68_24.content)

				arg_65_1.text_.text = var_68_25

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_26 = 5
				local var_68_27 = utf8.len(var_68_25)
				local var_68_28 = var_68_26 <= 0 and var_68_22 or var_68_22 * (var_68_27 / var_68_26)

				if var_68_28 > 0 and var_68_22 < var_68_28 then
					arg_65_1.talkMaxDuration = var_68_28

					if var_68_28 + var_68_21 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_28 + var_68_21
					end
				end

				arg_65_1.text_.text = var_68_25
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503016", "story_v_side_new_1108503.awb") ~= 0 then
					local var_68_29 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503016", "story_v_side_new_1108503.awb") / 1000

					if var_68_29 + var_68_21 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_29 + var_68_21
					end

					if var_68_24.prefab_name ~= "" and arg_65_1.actors_[var_68_24.prefab_name] ~= nil then
						local var_68_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_24.prefab_name].transform, "story_v_side_new_1108503", "1108503016", "story_v_side_new_1108503.awb")

						arg_65_1:RecordAudio("1108503016", var_68_30)
						arg_65_1:RecordAudio("1108503016", var_68_30)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503016", "story_v_side_new_1108503.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503016", "story_v_side_new_1108503.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_31 = math.max(var_68_22, arg_65_1.talkMaxDuration)

			if var_68_21 <= arg_65_1.time_ and arg_65_1.time_ < var_68_21 + var_68_31 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_21) / var_68_31

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_21 + var_68_31 and arg_65_1.time_ < var_68_21 + var_68_31 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play1108503017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 1108503017
		arg_69_1.duration_ = 5.33

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play1108503018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1037ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos1037ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(-0.7, -1.09, -5.81)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1037ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(-0.7, -1.09, -5.81)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["1037ui_story"]
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1037ui_story == nil then
				arg_69_1.var_.characterEffect1037ui_story = var_72_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 and not isNil(var_72_9) then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11

				if arg_69_1.var_.characterEffect1037ui_story and not isNil(var_72_9) then
					arg_69_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect1037ui_story then
				arg_69_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_72_13 = arg_69_1.actors_["1085ui_story"]
			local var_72_14 = 0

			if var_72_14 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 and not isNil(var_72_13) and arg_69_1.var_.characterEffect1085ui_story == nil then
				arg_69_1.var_.characterEffect1085ui_story = var_72_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_15 = 0.200000002980232

			if var_72_14 <= arg_69_1.time_ and arg_69_1.time_ < var_72_14 + var_72_15 and not isNil(var_72_13) then
				local var_72_16 = (arg_69_1.time_ - var_72_14) / var_72_15

				if arg_69_1.var_.characterEffect1085ui_story and not isNil(var_72_13) then
					local var_72_17 = Mathf.Lerp(0, 0.5, var_72_16)

					arg_69_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1085ui_story.fillRatio = var_72_17
				end
			end

			if arg_69_1.time_ >= var_72_14 + var_72_15 and arg_69_1.time_ < var_72_14 + var_72_15 + arg_72_0 and not isNil(var_72_13) and arg_69_1.var_.characterEffect1085ui_story then
				local var_72_18 = 0.5

				arg_69_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1085ui_story.fillRatio = var_72_18
			end

			local var_72_19 = 0

			if var_72_19 < arg_69_1.time_ and arg_69_1.time_ <= var_72_19 + arg_72_0 then
				arg_69_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_72_20 = 0

			if var_72_20 < arg_69_1.time_ and arg_69_1.time_ <= var_72_20 + arg_72_0 then
				arg_69_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_72_21 = 0
			local var_72_22 = 0.575

			if var_72_21 < arg_69_1.time_ and arg_69_1.time_ <= var_72_21 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_23 = arg_69_1:FormatText(StoryNameCfg[15].name)

				arg_69_1.leftNameTxt_.text = var_72_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_24 = arg_69_1:GetWordFromCfg(1108503017)
				local var_72_25 = arg_69_1:FormatText(var_72_24.content)

				arg_69_1.text_.text = var_72_25

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_26 = 23
				local var_72_27 = utf8.len(var_72_25)
				local var_72_28 = var_72_26 <= 0 and var_72_22 or var_72_22 * (var_72_27 / var_72_26)

				if var_72_28 > 0 and var_72_22 < var_72_28 then
					arg_69_1.talkMaxDuration = var_72_28

					if var_72_28 + var_72_21 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_28 + var_72_21
					end
				end

				arg_69_1.text_.text = var_72_25
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503017", "story_v_side_new_1108503.awb") ~= 0 then
					local var_72_29 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503017", "story_v_side_new_1108503.awb") / 1000

					if var_72_29 + var_72_21 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_29 + var_72_21
					end

					if var_72_24.prefab_name ~= "" and arg_69_1.actors_[var_72_24.prefab_name] ~= nil then
						local var_72_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_24.prefab_name].transform, "story_v_side_new_1108503", "1108503017", "story_v_side_new_1108503.awb")

						arg_69_1:RecordAudio("1108503017", var_72_30)
						arg_69_1:RecordAudio("1108503017", var_72_30)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503017", "story_v_side_new_1108503.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503017", "story_v_side_new_1108503.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_31 = math.max(var_72_22, arg_69_1.talkMaxDuration)

			if var_72_21 <= arg_69_1.time_ and arg_69_1.time_ < var_72_21 + var_72_31 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_21) / var_72_31

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_21 + var_72_31 and arg_69_1.time_ < var_72_21 + var_72_31 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play1108503018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 1108503018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play1108503019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1085ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1085ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0, 100, 0)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1085ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0, 100, 0)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["1037ui_story"].transform
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 then
				arg_73_1.var_.moveOldPos1037ui_story = var_76_9.localPosition
			end

			local var_76_11 = 0.001

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11
				local var_76_13 = Vector3.New(0, 100, 0)

				var_76_9.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1037ui_story, var_76_13, var_76_12)

				local var_76_14 = manager.ui.mainCamera.transform.position - var_76_9.position

				var_76_9.forward = Vector3.New(var_76_14.x, var_76_14.y, var_76_14.z)

				local var_76_15 = var_76_9.localEulerAngles

				var_76_15.z = 0
				var_76_15.x = 0
				var_76_9.localEulerAngles = var_76_15
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 then
				var_76_9.localPosition = Vector3.New(0, 100, 0)

				local var_76_16 = manager.ui.mainCamera.transform.position - var_76_9.position

				var_76_9.forward = Vector3.New(var_76_16.x, var_76_16.y, var_76_16.z)

				local var_76_17 = var_76_9.localEulerAngles

				var_76_17.z = 0
				var_76_17.x = 0
				var_76_9.localEulerAngles = var_76_17
			end

			local var_76_18 = arg_73_1.actors_["1037ui_story"]
			local var_76_19 = 0

			if var_76_19 < arg_73_1.time_ and arg_73_1.time_ <= var_76_19 + arg_76_0 and not isNil(var_76_18) and arg_73_1.var_.characterEffect1037ui_story == nil then
				arg_73_1.var_.characterEffect1037ui_story = var_76_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_20 = 0.200000002980232

			if var_76_19 <= arg_73_1.time_ and arg_73_1.time_ < var_76_19 + var_76_20 and not isNil(var_76_18) then
				local var_76_21 = (arg_73_1.time_ - var_76_19) / var_76_20

				if arg_73_1.var_.characterEffect1037ui_story and not isNil(var_76_18) then
					local var_76_22 = Mathf.Lerp(0, 0.5, var_76_21)

					arg_73_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1037ui_story.fillRatio = var_76_22
				end
			end

			if arg_73_1.time_ >= var_76_19 + var_76_20 and arg_73_1.time_ < var_76_19 + var_76_20 + arg_76_0 and not isNil(var_76_18) and arg_73_1.var_.characterEffect1037ui_story then
				local var_76_23 = 0.5

				arg_73_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1037ui_story.fillRatio = var_76_23
			end

			local var_76_24 = 0
			local var_76_25 = 1.025

			if var_76_24 < arg_73_1.time_ and arg_73_1.time_ <= var_76_24 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_26 = arg_73_1:GetWordFromCfg(1108503018)
				local var_76_27 = arg_73_1:FormatText(var_76_26.content)

				arg_73_1.text_.text = var_76_27

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_28 = 41
				local var_76_29 = utf8.len(var_76_27)
				local var_76_30 = var_76_28 <= 0 and var_76_25 or var_76_25 * (var_76_29 / var_76_28)

				if var_76_30 > 0 and var_76_25 < var_76_30 then
					arg_73_1.talkMaxDuration = var_76_30

					if var_76_30 + var_76_24 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_30 + var_76_24
					end
				end

				arg_73_1.text_.text = var_76_27
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_31 = math.max(var_76_25, arg_73_1.talkMaxDuration)

			if var_76_24 <= arg_73_1.time_ and arg_73_1.time_ < var_76_24 + var_76_31 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_24) / var_76_31

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_24 + var_76_31 and arg_73_1.time_ < var_76_24 + var_76_31 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play1108503019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 1108503019
		arg_77_1.duration_ = 1

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"

			SetActive(arg_77_1.choicesGo_, true)

			for iter_78_0, iter_78_1 in ipairs(arg_77_1.choices_) do
				local var_78_0 = iter_78_0 <= 1

				SetActive(iter_78_1.go, var_78_0)
			end

			arg_77_1.choices_[1].txt.text = arg_77_1:FormatText(StoryChoiceCfg[1635].name)
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play1108503020(arg_77_1)
			end

			arg_77_1:RecordChoiceLog(1108503019, 1635)
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			local var_80_1 = 0.6

			if arg_77_1.time_ >= var_80_0 + var_80_1 and arg_77_1.time_ < var_80_0 + var_80_1 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play1108503020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 1108503020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play1108503021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = 0.2
			local var_84_1 = 1

			if var_84_0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				local var_84_2 = "play"
				local var_84_3 = "effect"

				arg_81_1:AudioAction(var_84_2, var_84_3, "se_story_140", "se_story_140_catch", "")
			end

			local var_84_4 = 0
			local var_84_5 = 0.8

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(1108503020)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_8 = 32
				local var_84_9 = utf8.len(var_84_7)
				local var_84_10 = var_84_8 <= 0 and var_84_5 or var_84_5 * (var_84_9 / var_84_8)

				if var_84_10 > 0 and var_84_5 < var_84_10 then
					arg_81_1.talkMaxDuration = var_84_10

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_11 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_11 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_11

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_11 and arg_81_1.time_ < var_84_4 + var_84_11 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play1108503021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 1108503021
		arg_85_1.duration_ = 6.87

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play1108503022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = arg_85_1.actors_["1085ui_story"].transform
			local var_88_1 = 0

			if var_88_1 < arg_85_1.time_ and arg_85_1.time_ <= var_88_1 + arg_88_0 then
				arg_85_1.var_.moveOldPos1085ui_story = var_88_0.localPosition
			end

			local var_88_2 = 0.001

			if var_88_1 <= arg_85_1.time_ and arg_85_1.time_ < var_88_1 + var_88_2 then
				local var_88_3 = (arg_85_1.time_ - var_88_1) / var_88_2
				local var_88_4 = Vector3.New(-0.75, -1.01, -5.83)

				var_88_0.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1085ui_story, var_88_4, var_88_3)

				local var_88_5 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_5.x, var_88_5.y, var_88_5.z)

				local var_88_6 = var_88_0.localEulerAngles

				var_88_6.z = 0
				var_88_6.x = 0
				var_88_0.localEulerAngles = var_88_6
			end

			if arg_85_1.time_ >= var_88_1 + var_88_2 and arg_85_1.time_ < var_88_1 + var_88_2 + arg_88_0 then
				var_88_0.localPosition = Vector3.New(-0.75, -1.01, -5.83)

				local var_88_7 = manager.ui.mainCamera.transform.position - var_88_0.position

				var_88_0.forward = Vector3.New(var_88_7.x, var_88_7.y, var_88_7.z)

				local var_88_8 = var_88_0.localEulerAngles

				var_88_8.z = 0
				var_88_8.x = 0
				var_88_0.localEulerAngles = var_88_8
			end

			local var_88_9 = arg_85_1.actors_["1085ui_story"]
			local var_88_10 = 0

			if var_88_10 < arg_85_1.time_ and arg_85_1.time_ <= var_88_10 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1085ui_story == nil then
				arg_85_1.var_.characterEffect1085ui_story = var_88_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_11 = 0.200000002980232

			if var_88_10 <= arg_85_1.time_ and arg_85_1.time_ < var_88_10 + var_88_11 and not isNil(var_88_9) then
				local var_88_12 = (arg_85_1.time_ - var_88_10) / var_88_11

				if arg_85_1.var_.characterEffect1085ui_story and not isNil(var_88_9) then
					arg_85_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_10 + var_88_11 and arg_85_1.time_ < var_88_10 + var_88_11 + arg_88_0 and not isNil(var_88_9) and arg_85_1.var_.characterEffect1085ui_story then
				arg_85_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_88_13 = 0

			if var_88_13 < arg_85_1.time_ and arg_85_1.time_ <= var_88_13 + arg_88_0 then
				arg_85_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_88_14 = 0

			if var_88_14 < arg_85_1.time_ and arg_85_1.time_ <= var_88_14 + arg_88_0 then
				arg_85_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_88_15 = 0
			local var_88_16 = 0.475

			if var_88_15 < arg_85_1.time_ and arg_85_1.time_ <= var_88_15 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_17 = arg_85_1:FormatText(StoryNameCfg[328].name)

				arg_85_1.leftNameTxt_.text = var_88_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_18 = arg_85_1:GetWordFromCfg(1108503021)
				local var_88_19 = arg_85_1:FormatText(var_88_18.content)

				arg_85_1.text_.text = var_88_19

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_20 = 19
				local var_88_21 = utf8.len(var_88_19)
				local var_88_22 = var_88_20 <= 0 and var_88_16 or var_88_16 * (var_88_21 / var_88_20)

				if var_88_22 > 0 and var_88_16 < var_88_22 then
					arg_85_1.talkMaxDuration = var_88_22

					if var_88_22 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_22 + var_88_15
					end
				end

				arg_85_1.text_.text = var_88_19
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503021", "story_v_side_new_1108503.awb") ~= 0 then
					local var_88_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503021", "story_v_side_new_1108503.awb") / 1000

					if var_88_23 + var_88_15 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_23 + var_88_15
					end

					if var_88_18.prefab_name ~= "" and arg_85_1.actors_[var_88_18.prefab_name] ~= nil then
						local var_88_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_18.prefab_name].transform, "story_v_side_new_1108503", "1108503021", "story_v_side_new_1108503.awb")

						arg_85_1:RecordAudio("1108503021", var_88_24)
						arg_85_1:RecordAudio("1108503021", var_88_24)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503021", "story_v_side_new_1108503.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503021", "story_v_side_new_1108503.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_25 = math.max(var_88_16, arg_85_1.talkMaxDuration)

			if var_88_15 <= arg_85_1.time_ and arg_85_1.time_ < var_88_15 + var_88_25 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_15) / var_88_25

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_15 + var_88_25 and arg_85_1.time_ < var_88_15 + var_88_25 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
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

		arg_85_1:InitPlayNodeList()
	end,
	Play1108503022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 1108503022
		arg_89_1.duration_ = 3.3

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play1108503023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1037ui_story"].transform
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.var_.moveOldPos1037ui_story = var_92_0.localPosition
			end

			local var_92_2 = 0.001

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2
				local var_92_4 = Vector3.New(0.7, -1.09, -5.81)

				var_92_0.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1037ui_story, var_92_4, var_92_3)

				local var_92_5 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_5.x, var_92_5.y, var_92_5.z)

				local var_92_6 = var_92_0.localEulerAngles

				var_92_6.z = 0
				var_92_6.x = 0
				var_92_0.localEulerAngles = var_92_6
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 then
				var_92_0.localPosition = Vector3.New(0.7, -1.09, -5.81)

				local var_92_7 = manager.ui.mainCamera.transform.position - var_92_0.position

				var_92_0.forward = Vector3.New(var_92_7.x, var_92_7.y, var_92_7.z)

				local var_92_8 = var_92_0.localEulerAngles

				var_92_8.z = 0
				var_92_8.x = 0
				var_92_0.localEulerAngles = var_92_8
			end

			local var_92_9 = arg_89_1.actors_["1037ui_story"]
			local var_92_10 = 0

			if var_92_10 < arg_89_1.time_ and arg_89_1.time_ <= var_92_10 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1037ui_story == nil then
				arg_89_1.var_.characterEffect1037ui_story = var_92_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_11 = 0.200000002980232

			if var_92_10 <= arg_89_1.time_ and arg_89_1.time_ < var_92_10 + var_92_11 and not isNil(var_92_9) then
				local var_92_12 = (arg_89_1.time_ - var_92_10) / var_92_11

				if arg_89_1.var_.characterEffect1037ui_story and not isNil(var_92_9) then
					arg_89_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_10 + var_92_11 and arg_89_1.time_ < var_92_10 + var_92_11 + arg_92_0 and not isNil(var_92_9) and arg_89_1.var_.characterEffect1037ui_story then
				arg_89_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_92_13 = arg_89_1.actors_["1085ui_story"]
			local var_92_14 = 0

			if var_92_14 < arg_89_1.time_ and arg_89_1.time_ <= var_92_14 + arg_92_0 and not isNil(var_92_13) and arg_89_1.var_.characterEffect1085ui_story == nil then
				arg_89_1.var_.characterEffect1085ui_story = var_92_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_15 = 0.200000002980232

			if var_92_14 <= arg_89_1.time_ and arg_89_1.time_ < var_92_14 + var_92_15 and not isNil(var_92_13) then
				local var_92_16 = (arg_89_1.time_ - var_92_14) / var_92_15

				if arg_89_1.var_.characterEffect1085ui_story and not isNil(var_92_13) then
					local var_92_17 = Mathf.Lerp(0, 0.5, var_92_16)

					arg_89_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1085ui_story.fillRatio = var_92_17
				end
			end

			if arg_89_1.time_ >= var_92_14 + var_92_15 and arg_89_1.time_ < var_92_14 + var_92_15 + arg_92_0 and not isNil(var_92_13) and arg_89_1.var_.characterEffect1085ui_story then
				local var_92_18 = 0.5

				arg_89_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1085ui_story.fillRatio = var_92_18
			end

			local var_92_19 = 0

			if var_92_19 < arg_89_1.time_ and arg_89_1.time_ <= var_92_19 + arg_92_0 then
				arg_89_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action3_1")
			end

			local var_92_20 = 0

			if var_92_20 < arg_89_1.time_ and arg_89_1.time_ <= var_92_20 + arg_92_0 then
				arg_89_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_92_21 = 0
			local var_92_22 = 0.45

			if var_92_21 < arg_89_1.time_ and arg_89_1.time_ <= var_92_21 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_23 = arg_89_1:FormatText(StoryNameCfg[15].name)

				arg_89_1.leftNameTxt_.text = var_92_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_24 = arg_89_1:GetWordFromCfg(1108503022)
				local var_92_25 = arg_89_1:FormatText(var_92_24.content)

				arg_89_1.text_.text = var_92_25

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_26 = 18
				local var_92_27 = utf8.len(var_92_25)
				local var_92_28 = var_92_26 <= 0 and var_92_22 or var_92_22 * (var_92_27 / var_92_26)

				if var_92_28 > 0 and var_92_22 < var_92_28 then
					arg_89_1.talkMaxDuration = var_92_28

					if var_92_28 + var_92_21 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_28 + var_92_21
					end
				end

				arg_89_1.text_.text = var_92_25
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503022", "story_v_side_new_1108503.awb") ~= 0 then
					local var_92_29 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503022", "story_v_side_new_1108503.awb") / 1000

					if var_92_29 + var_92_21 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_29 + var_92_21
					end

					if var_92_24.prefab_name ~= "" and arg_89_1.actors_[var_92_24.prefab_name] ~= nil then
						local var_92_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_24.prefab_name].transform, "story_v_side_new_1108503", "1108503022", "story_v_side_new_1108503.awb")

						arg_89_1:RecordAudio("1108503022", var_92_30)
						arg_89_1:RecordAudio("1108503022", var_92_30)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503022", "story_v_side_new_1108503.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503022", "story_v_side_new_1108503.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_31 = math.max(var_92_22, arg_89_1.talkMaxDuration)

			if var_92_21 <= arg_89_1.time_ and arg_89_1.time_ < var_92_21 + var_92_31 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_21) / var_92_31

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_21 + var_92_31 and arg_89_1.time_ < var_92_21 + var_92_31 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play1108503023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 1108503023
		arg_93_1.duration_ = 2

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play1108503024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1085ui_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos1085ui_story = var_96_0.localPosition
			end

			local var_96_2 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2
				local var_96_4 = Vector3.New(-0.75, -1.01, -5.83)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1085ui_story, var_96_4, var_96_3)

				local var_96_5 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_5.x, var_96_5.y, var_96_5.z)

				local var_96_6 = var_96_0.localEulerAngles

				var_96_6.z = 0
				var_96_6.x = 0
				var_96_0.localEulerAngles = var_96_6
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(-0.75, -1.01, -5.83)

				local var_96_7 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_7.x, var_96_7.y, var_96_7.z)

				local var_96_8 = var_96_0.localEulerAngles

				var_96_8.z = 0
				var_96_8.x = 0
				var_96_0.localEulerAngles = var_96_8
			end

			local var_96_9 = arg_93_1.actors_["1085ui_story"]
			local var_96_10 = 0

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1085ui_story == nil then
				arg_93_1.var_.characterEffect1085ui_story = var_96_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_11 = 0.200000002980232

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_11 and not isNil(var_96_9) then
				local var_96_12 = (arg_93_1.time_ - var_96_10) / var_96_11

				if arg_93_1.var_.characterEffect1085ui_story and not isNil(var_96_9) then
					arg_93_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_10 + var_96_11 and arg_93_1.time_ < var_96_10 + var_96_11 + arg_96_0 and not isNil(var_96_9) and arg_93_1.var_.characterEffect1085ui_story then
				arg_93_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_96_13 = arg_93_1.actors_["1037ui_story"]
			local var_96_14 = 0

			if var_96_14 < arg_93_1.time_ and arg_93_1.time_ <= var_96_14 + arg_96_0 and not isNil(var_96_13) and arg_93_1.var_.characterEffect1037ui_story == nil then
				arg_93_1.var_.characterEffect1037ui_story = var_96_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_15 = 0.200000002980232

			if var_96_14 <= arg_93_1.time_ and arg_93_1.time_ < var_96_14 + var_96_15 and not isNil(var_96_13) then
				local var_96_16 = (arg_93_1.time_ - var_96_14) / var_96_15

				if arg_93_1.var_.characterEffect1037ui_story and not isNil(var_96_13) then
					local var_96_17 = Mathf.Lerp(0, 0.5, var_96_16)

					arg_93_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1037ui_story.fillRatio = var_96_17
				end
			end

			if arg_93_1.time_ >= var_96_14 + var_96_15 and arg_93_1.time_ < var_96_14 + var_96_15 + arg_96_0 and not isNil(var_96_13) and arg_93_1.var_.characterEffect1037ui_story then
				local var_96_18 = 0.5

				arg_93_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1037ui_story.fillRatio = var_96_18
			end

			local var_96_19 = 0

			if var_96_19 < arg_93_1.time_ and arg_93_1.time_ <= var_96_19 + arg_96_0 then
				arg_93_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_96_20 = 0

			if var_96_20 < arg_93_1.time_ and arg_93_1.time_ <= var_96_20 + arg_96_0 then
				arg_93_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_96_21 = 0
			local var_96_22 = 0.075

			if var_96_21 < arg_93_1.time_ and arg_93_1.time_ <= var_96_21 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_23 = arg_93_1:FormatText(StoryNameCfg[328].name)

				arg_93_1.leftNameTxt_.text = var_96_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_24 = arg_93_1:GetWordFromCfg(1108503023)
				local var_96_25 = arg_93_1:FormatText(var_96_24.content)

				arg_93_1.text_.text = var_96_25

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_26 = 3
				local var_96_27 = utf8.len(var_96_25)
				local var_96_28 = var_96_26 <= 0 and var_96_22 or var_96_22 * (var_96_27 / var_96_26)

				if var_96_28 > 0 and var_96_22 < var_96_28 then
					arg_93_1.talkMaxDuration = var_96_28

					if var_96_28 + var_96_21 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_28 + var_96_21
					end
				end

				arg_93_1.text_.text = var_96_25
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503023", "story_v_side_new_1108503.awb") ~= 0 then
					local var_96_29 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503023", "story_v_side_new_1108503.awb") / 1000

					if var_96_29 + var_96_21 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_29 + var_96_21
					end

					if var_96_24.prefab_name ~= "" and arg_93_1.actors_[var_96_24.prefab_name] ~= nil then
						local var_96_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_24.prefab_name].transform, "story_v_side_new_1108503", "1108503023", "story_v_side_new_1108503.awb")

						arg_93_1:RecordAudio("1108503023", var_96_30)
						arg_93_1:RecordAudio("1108503023", var_96_30)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503023", "story_v_side_new_1108503.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503023", "story_v_side_new_1108503.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_31 = math.max(var_96_22, arg_93_1.talkMaxDuration)

			if var_96_21 <= arg_93_1.time_ and arg_93_1.time_ < var_96_21 + var_96_31 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_21) / var_96_31

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_21 + var_96_31 and arg_93_1.time_ < var_96_21 + var_96_31 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play1108503024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 1108503024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play1108503025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1085ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1085ui_story == nil then
				arg_97_1.var_.characterEffect1085ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1085ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1085ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1085ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1085ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0
			local var_100_7 = 0.775

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_8 = arg_97_1:FormatText(StoryNameCfg[7].name)

				arg_97_1.leftNameTxt_.text = var_100_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_9 = arg_97_1:GetWordFromCfg(1108503024)
				local var_100_10 = arg_97_1:FormatText(var_100_9.content)

				arg_97_1.text_.text = var_100_10

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_11 = 31
				local var_100_12 = utf8.len(var_100_10)
				local var_100_13 = var_100_11 <= 0 and var_100_7 or var_100_7 * (var_100_12 / var_100_11)

				if var_100_13 > 0 and var_100_7 < var_100_13 then
					arg_97_1.talkMaxDuration = var_100_13

					if var_100_13 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_10
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_14 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_14 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_14

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_14 and arg_97_1.time_ < var_100_6 + var_100_14 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play1108503025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 1108503025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play1108503026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.575

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[7].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, true)
				arg_101_1.iconController_:SetSelectedState("hero")

				arg_101_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_101_1.callingController_:SetSelectedState("normal")

				arg_101_1.keyicon_.color = Color.New(1, 1, 1)
				arg_101_1.icon_.color = Color.New(1, 1, 1)

				local var_104_3 = arg_101_1:GetWordFromCfg(1108503025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 23
				local var_104_6 = utf8.len(var_104_4)
				local var_104_7 = var_104_5 <= 0 and var_104_1 or var_104_1 * (var_104_6 / var_104_5)

				if var_104_7 > 0 and var_104_1 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_0
					end
				end

				arg_101_1.text_.text = var_104_4
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_8 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_8 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_8

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_8 and arg_101_1.time_ < var_104_0 + var_104_8 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play1108503026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 1108503026
		arg_105_1.duration_ = 4.5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play1108503027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1037ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1037ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0.7, -1.09, -5.81)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1037ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0.7, -1.09, -5.81)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = arg_105_1.actors_["1037ui_story"]
			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect1037ui_story == nil then
				arg_105_1.var_.characterEffect1037ui_story = var_108_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_11 = 0.200000002980232

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_11 and not isNil(var_108_9) then
				local var_108_12 = (arg_105_1.time_ - var_108_10) / var_108_11

				if arg_105_1.var_.characterEffect1037ui_story and not isNil(var_108_9) then
					arg_105_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_10 + var_108_11 and arg_105_1.time_ < var_108_10 + var_108_11 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect1037ui_story then
				arg_105_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_108_13 = 0

			if var_108_13 < arg_105_1.time_ and arg_105_1.time_ <= var_108_13 + arg_108_0 then
				arg_105_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_1")
			end

			local var_108_14 = 0

			if var_108_14 < arg_105_1.time_ and arg_105_1.time_ <= var_108_14 + arg_108_0 then
				arg_105_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_108_15 = 0
			local var_108_16 = 0.4

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_17 = arg_105_1:FormatText(StoryNameCfg[15].name)

				arg_105_1.leftNameTxt_.text = var_108_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_18 = arg_105_1:GetWordFromCfg(1108503026)
				local var_108_19 = arg_105_1:FormatText(var_108_18.content)

				arg_105_1.text_.text = var_108_19

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_20 = 16
				local var_108_21 = utf8.len(var_108_19)
				local var_108_22 = var_108_20 <= 0 and var_108_16 or var_108_16 * (var_108_21 / var_108_20)

				if var_108_22 > 0 and var_108_16 < var_108_22 then
					arg_105_1.talkMaxDuration = var_108_22

					if var_108_22 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_22 + var_108_15
					end
				end

				arg_105_1.text_.text = var_108_19
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503026", "story_v_side_new_1108503.awb") ~= 0 then
					local var_108_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503026", "story_v_side_new_1108503.awb") / 1000

					if var_108_23 + var_108_15 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_23 + var_108_15
					end

					if var_108_18.prefab_name ~= "" and arg_105_1.actors_[var_108_18.prefab_name] ~= nil then
						local var_108_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_18.prefab_name].transform, "story_v_side_new_1108503", "1108503026", "story_v_side_new_1108503.awb")

						arg_105_1:RecordAudio("1108503026", var_108_24)
						arg_105_1:RecordAudio("1108503026", var_108_24)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503026", "story_v_side_new_1108503.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503026", "story_v_side_new_1108503.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_25 = math.max(var_108_16, arg_105_1.talkMaxDuration)

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_25 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_15) / var_108_25

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_15 + var_108_25 and arg_105_1.time_ < var_108_15 + var_108_25 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play1108503027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 1108503027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play1108503028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1037ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1037ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, 100, 0)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1037ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0, 100, 0)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["1085ui_story"].transform
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 then
				arg_109_1.var_.moveOldPos1085ui_story = var_112_9.localPosition
			end

			local var_112_11 = 0.001

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11
				local var_112_13 = Vector3.New(0, 100, 0)

				var_112_9.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1085ui_story, var_112_13, var_112_12)

				local var_112_14 = manager.ui.mainCamera.transform.position - var_112_9.position

				var_112_9.forward = Vector3.New(var_112_14.x, var_112_14.y, var_112_14.z)

				local var_112_15 = var_112_9.localEulerAngles

				var_112_15.z = 0
				var_112_15.x = 0
				var_112_9.localEulerAngles = var_112_15
			end

			if arg_109_1.time_ >= var_112_10 + var_112_11 and arg_109_1.time_ < var_112_10 + var_112_11 + arg_112_0 then
				var_112_9.localPosition = Vector3.New(0, 100, 0)

				local var_112_16 = manager.ui.mainCamera.transform.position - var_112_9.position

				var_112_9.forward = Vector3.New(var_112_16.x, var_112_16.y, var_112_16.z)

				local var_112_17 = var_112_9.localEulerAngles

				var_112_17.z = 0
				var_112_17.x = 0
				var_112_9.localEulerAngles = var_112_17
			end

			local var_112_18 = arg_109_1.actors_["1037ui_story"]
			local var_112_19 = 0

			if var_112_19 < arg_109_1.time_ and arg_109_1.time_ <= var_112_19 + arg_112_0 and not isNil(var_112_18) and arg_109_1.var_.characterEffect1037ui_story == nil then
				arg_109_1.var_.characterEffect1037ui_story = var_112_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_20 = 0.200000002980232

			if var_112_19 <= arg_109_1.time_ and arg_109_1.time_ < var_112_19 + var_112_20 and not isNil(var_112_18) then
				local var_112_21 = (arg_109_1.time_ - var_112_19) / var_112_20

				if arg_109_1.var_.characterEffect1037ui_story and not isNil(var_112_18) then
					local var_112_22 = Mathf.Lerp(0, 0.5, var_112_21)

					arg_109_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1037ui_story.fillRatio = var_112_22
				end
			end

			if arg_109_1.time_ >= var_112_19 + var_112_20 and arg_109_1.time_ < var_112_19 + var_112_20 + arg_112_0 and not isNil(var_112_18) and arg_109_1.var_.characterEffect1037ui_story then
				local var_112_23 = 0.5

				arg_109_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1037ui_story.fillRatio = var_112_23
			end

			local var_112_24 = 0
			local var_112_25 = 0.5

			if var_112_24 < arg_109_1.time_ and arg_109_1.time_ <= var_112_24 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_26 = arg_109_1:GetWordFromCfg(1108503027)
				local var_112_27 = arg_109_1:FormatText(var_112_26.content)

				arg_109_1.text_.text = var_112_27

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_28 = 20
				local var_112_29 = utf8.len(var_112_27)
				local var_112_30 = var_112_28 <= 0 and var_112_25 or var_112_25 * (var_112_29 / var_112_28)

				if var_112_30 > 0 and var_112_25 < var_112_30 then
					arg_109_1.talkMaxDuration = var_112_30

					if var_112_30 + var_112_24 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_30 + var_112_24
					end
				end

				arg_109_1.text_.text = var_112_27
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_31 = math.max(var_112_25, arg_109_1.talkMaxDuration)

			if var_112_24 <= arg_109_1.time_ and arg_109_1.time_ < var_112_24 + var_112_31 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_24) / var_112_31

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_24 + var_112_31 and arg_109_1.time_ < var_112_24 + var_112_31 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_109_1:InitPlayNodeList()
	end,
	Play1108503028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 1108503028
		arg_113_1.duration_ = 7.03

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play1108503029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1037ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1037ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0, -1.09, -5.81)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1037ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = arg_113_1.actors_["1037ui_story"]
			local var_116_10 = 0

			if var_116_10 < arg_113_1.time_ and arg_113_1.time_ <= var_116_10 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1037ui_story == nil then
				arg_113_1.var_.characterEffect1037ui_story = var_116_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_11 = 0.200000002980232

			if var_116_10 <= arg_113_1.time_ and arg_113_1.time_ < var_116_10 + var_116_11 and not isNil(var_116_9) then
				local var_116_12 = (arg_113_1.time_ - var_116_10) / var_116_11

				if arg_113_1.var_.characterEffect1037ui_story and not isNil(var_116_9) then
					arg_113_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_10 + var_116_11 and arg_113_1.time_ < var_116_10 + var_116_11 + arg_116_0 and not isNil(var_116_9) and arg_113_1.var_.characterEffect1037ui_story then
				arg_113_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_116_13 = 0

			if var_116_13 < arg_113_1.time_ and arg_113_1.time_ <= var_116_13 + arg_116_0 then
				arg_113_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_116_14 = 0

			if var_116_14 < arg_113_1.time_ and arg_113_1.time_ <= var_116_14 + arg_116_0 then
				arg_113_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_116_15 = 0
			local var_116_16 = 0.875

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_17 = arg_113_1:FormatText(StoryNameCfg[15].name)

				arg_113_1.leftNameTxt_.text = var_116_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_18 = arg_113_1:GetWordFromCfg(1108503028)
				local var_116_19 = arg_113_1:FormatText(var_116_18.content)

				arg_113_1.text_.text = var_116_19

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_20 = 35
				local var_116_21 = utf8.len(var_116_19)
				local var_116_22 = var_116_20 <= 0 and var_116_16 or var_116_16 * (var_116_21 / var_116_20)

				if var_116_22 > 0 and var_116_16 < var_116_22 then
					arg_113_1.talkMaxDuration = var_116_22

					if var_116_22 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_22 + var_116_15
					end
				end

				arg_113_1.text_.text = var_116_19
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503028", "story_v_side_new_1108503.awb") ~= 0 then
					local var_116_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503028", "story_v_side_new_1108503.awb") / 1000

					if var_116_23 + var_116_15 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_23 + var_116_15
					end

					if var_116_18.prefab_name ~= "" and arg_113_1.actors_[var_116_18.prefab_name] ~= nil then
						local var_116_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_18.prefab_name].transform, "story_v_side_new_1108503", "1108503028", "story_v_side_new_1108503.awb")

						arg_113_1:RecordAudio("1108503028", var_116_24)
						arg_113_1:RecordAudio("1108503028", var_116_24)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503028", "story_v_side_new_1108503.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503028", "story_v_side_new_1108503.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_25 = math.max(var_116_16, arg_113_1.talkMaxDuration)

			if var_116_15 <= arg_113_1.time_ and arg_113_1.time_ < var_116_15 + var_116_25 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_15) / var_116_25

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_15 + var_116_25 and arg_113_1.time_ < var_116_15 + var_116_25 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play1108503029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 1108503029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play1108503030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1037ui_story"].transform
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.var_.moveOldPos1037ui_story = var_120_0.localPosition
			end

			local var_120_2 = 0.001

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2
				local var_120_4 = Vector3.New(0, 100, 0)

				var_120_0.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1037ui_story, var_120_4, var_120_3)

				local var_120_5 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_5.x, var_120_5.y, var_120_5.z)

				local var_120_6 = var_120_0.localEulerAngles

				var_120_6.z = 0
				var_120_6.x = 0
				var_120_0.localEulerAngles = var_120_6
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 then
				var_120_0.localPosition = Vector3.New(0, 100, 0)

				local var_120_7 = manager.ui.mainCamera.transform.position - var_120_0.position

				var_120_0.forward = Vector3.New(var_120_7.x, var_120_7.y, var_120_7.z)

				local var_120_8 = var_120_0.localEulerAngles

				var_120_8.z = 0
				var_120_8.x = 0
				var_120_0.localEulerAngles = var_120_8
			end

			local var_120_9 = arg_117_1.actors_["1037ui_story"]
			local var_120_10 = 0

			if var_120_10 < arg_117_1.time_ and arg_117_1.time_ <= var_120_10 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1037ui_story == nil then
				arg_117_1.var_.characterEffect1037ui_story = var_120_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_11 = 0.200000002980232

			if var_120_10 <= arg_117_1.time_ and arg_117_1.time_ < var_120_10 + var_120_11 and not isNil(var_120_9) then
				local var_120_12 = (arg_117_1.time_ - var_120_10) / var_120_11

				if arg_117_1.var_.characterEffect1037ui_story and not isNil(var_120_9) then
					local var_120_13 = Mathf.Lerp(0, 0.5, var_120_12)

					arg_117_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1037ui_story.fillRatio = var_120_13
				end
			end

			if arg_117_1.time_ >= var_120_10 + var_120_11 and arg_117_1.time_ < var_120_10 + var_120_11 + arg_120_0 and not isNil(var_120_9) and arg_117_1.var_.characterEffect1037ui_story then
				local var_120_14 = 0.5

				arg_117_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1037ui_story.fillRatio = var_120_14
			end

			local var_120_15 = 0
			local var_120_16 = 0.525

			if var_120_15 < arg_117_1.time_ and arg_117_1.time_ <= var_120_15 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_17 = arg_117_1:GetWordFromCfg(1108503029)
				local var_120_18 = arg_117_1:FormatText(var_120_17.content)

				arg_117_1.text_.text = var_120_18

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_19 = 21
				local var_120_20 = utf8.len(var_120_18)
				local var_120_21 = var_120_19 <= 0 and var_120_16 or var_120_16 * (var_120_20 / var_120_19)

				if var_120_21 > 0 and var_120_16 < var_120_21 then
					arg_117_1.talkMaxDuration = var_120_21

					if var_120_21 + var_120_15 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_21 + var_120_15
					end
				end

				arg_117_1.text_.text = var_120_18
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_22 = math.max(var_120_16, arg_117_1.talkMaxDuration)

			if var_120_15 <= arg_117_1.time_ and arg_117_1.time_ < var_120_15 + var_120_22 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_15) / var_120_22

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_15 + var_120_22 and arg_117_1.time_ < var_120_15 + var_120_22 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play1108503030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 1108503030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play1108503031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = 0
			local var_124_1 = 0.575

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

				arg_121_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_121_1.callingController_:SetSelectedState("normal")

				arg_121_1.keyicon_.color = Color.New(1, 1, 1)
				arg_121_1.icon_.color = Color.New(1, 1, 1)

				local var_124_3 = arg_121_1:GetWordFromCfg(1108503030)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_5 = 23
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
	Play1108503031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 1108503031
		arg_125_1.duration_ = 5.77

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play1108503032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1037ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1037ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, -1.09, -5.81)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1037ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["1037ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1037ui_story == nil then
				arg_125_1.var_.characterEffect1037ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect1037ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1037ui_story then
				arg_125_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_128_13 = 0

			if var_128_13 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action2_1")
			end

			local var_128_14 = 0

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 then
				arg_125_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_128_15 = 0
			local var_128_16 = 0.8

			if var_128_15 < arg_125_1.time_ and arg_125_1.time_ <= var_128_15 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_17 = arg_125_1:FormatText(StoryNameCfg[15].name)

				arg_125_1.leftNameTxt_.text = var_128_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_18 = arg_125_1:GetWordFromCfg(1108503031)
				local var_128_19 = arg_125_1:FormatText(var_128_18.content)

				arg_125_1.text_.text = var_128_19

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_20 = 32
				local var_128_21 = utf8.len(var_128_19)
				local var_128_22 = var_128_20 <= 0 and var_128_16 or var_128_16 * (var_128_21 / var_128_20)

				if var_128_22 > 0 and var_128_16 < var_128_22 then
					arg_125_1.talkMaxDuration = var_128_22

					if var_128_22 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_22 + var_128_15
					end
				end

				arg_125_1.text_.text = var_128_19
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503031", "story_v_side_new_1108503.awb") ~= 0 then
					local var_128_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503031", "story_v_side_new_1108503.awb") / 1000

					if var_128_23 + var_128_15 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_23 + var_128_15
					end

					if var_128_18.prefab_name ~= "" and arg_125_1.actors_[var_128_18.prefab_name] ~= nil then
						local var_128_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_18.prefab_name].transform, "story_v_side_new_1108503", "1108503031", "story_v_side_new_1108503.awb")

						arg_125_1:RecordAudio("1108503031", var_128_24)
						arg_125_1:RecordAudio("1108503031", var_128_24)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503031", "story_v_side_new_1108503.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503031", "story_v_side_new_1108503.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_25 = math.max(var_128_16, arg_125_1.talkMaxDuration)

			if var_128_15 <= arg_125_1.time_ and arg_125_1.time_ < var_128_15 + var_128_25 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_15) / var_128_25

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_15 + var_128_25 and arg_125_1.time_ < var_128_15 + var_128_25 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play1108503032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 1108503032
		arg_129_1.duration_ = 2.9

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play1108503033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1037ui_story"].transform
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 then
				arg_129_1.var_.moveOldPos1037ui_story = var_132_0.localPosition
			end

			local var_132_2 = 0.001

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2
				local var_132_4 = Vector3.New(0, -1.09, -5.81)

				var_132_0.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1037ui_story, var_132_4, var_132_3)

				local var_132_5 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_5.x, var_132_5.y, var_132_5.z)

				local var_132_6 = var_132_0.localEulerAngles

				var_132_6.z = 0
				var_132_6.x = 0
				var_132_0.localEulerAngles = var_132_6
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 then
				var_132_0.localPosition = Vector3.New(0, -1.09, -5.81)

				local var_132_7 = manager.ui.mainCamera.transform.position - var_132_0.position

				var_132_0.forward = Vector3.New(var_132_7.x, var_132_7.y, var_132_7.z)

				local var_132_8 = var_132_0.localEulerAngles

				var_132_8.z = 0
				var_132_8.x = 0
				var_132_0.localEulerAngles = var_132_8
			end

			local var_132_9 = 0

			if var_132_9 < arg_129_1.time_ and arg_129_1.time_ <= var_132_9 + arg_132_0 then
				arg_129_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action425")
			end

			local var_132_10 = 0

			if var_132_10 < arg_129_1.time_ and arg_129_1.time_ <= var_132_10 + arg_132_0 then
				arg_129_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_132_11 = 0
			local var_132_12 = 0.325

			if var_132_11 < arg_129_1.time_ and arg_129_1.time_ <= var_132_11 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_13 = arg_129_1:FormatText(StoryNameCfg[15].name)

				arg_129_1.leftNameTxt_.text = var_132_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_14 = arg_129_1:GetWordFromCfg(1108503032)
				local var_132_15 = arg_129_1:FormatText(var_132_14.content)

				arg_129_1.text_.text = var_132_15

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_16 = 13
				local var_132_17 = utf8.len(var_132_15)
				local var_132_18 = var_132_16 <= 0 and var_132_12 or var_132_12 * (var_132_17 / var_132_16)

				if var_132_18 > 0 and var_132_12 < var_132_18 then
					arg_129_1.talkMaxDuration = var_132_18

					if var_132_18 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_18 + var_132_11
					end
				end

				arg_129_1.text_.text = var_132_15
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503032", "story_v_side_new_1108503.awb") ~= 0 then
					local var_132_19 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503032", "story_v_side_new_1108503.awb") / 1000

					if var_132_19 + var_132_11 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_19 + var_132_11
					end

					if var_132_14.prefab_name ~= "" and arg_129_1.actors_[var_132_14.prefab_name] ~= nil then
						local var_132_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_14.prefab_name].transform, "story_v_side_new_1108503", "1108503032", "story_v_side_new_1108503.awb")

						arg_129_1:RecordAudio("1108503032", var_132_20)
						arg_129_1:RecordAudio("1108503032", var_132_20)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503032", "story_v_side_new_1108503.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503032", "story_v_side_new_1108503.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_21 = math.max(var_132_12, arg_129_1.talkMaxDuration)

			if var_132_11 <= arg_129_1.time_ and arg_129_1.time_ < var_132_11 + var_132_21 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_11) / var_132_21

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_11 + var_132_21 and arg_129_1.time_ < var_132_11 + var_132_21 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play1108503033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 1108503033
		arg_133_1.duration_ = 9

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play1108503034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1037ui_story"].transform
			local var_136_1 = 1.96599999815226

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 then
				arg_133_1.var_.moveOldPos1037ui_story = var_136_0.localPosition
			end

			local var_136_2 = 0.001

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2
				local var_136_4 = Vector3.New(0, 100, 0)

				var_136_0.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1037ui_story, var_136_4, var_136_3)

				local var_136_5 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_5.x, var_136_5.y, var_136_5.z)

				local var_136_6 = var_136_0.localEulerAngles

				var_136_6.z = 0
				var_136_6.x = 0
				var_136_0.localEulerAngles = var_136_6
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 then
				var_136_0.localPosition = Vector3.New(0, 100, 0)

				local var_136_7 = manager.ui.mainCamera.transform.position - var_136_0.position

				var_136_0.forward = Vector3.New(var_136_7.x, var_136_7.y, var_136_7.z)

				local var_136_8 = var_136_0.localEulerAngles

				var_136_8.z = 0
				var_136_8.x = 0
				var_136_0.localEulerAngles = var_136_8
			end

			local var_136_9 = arg_133_1.actors_["1037ui_story"]
			local var_136_10 = 1.96599999815226

			if var_136_10 < arg_133_1.time_ and arg_133_1.time_ <= var_136_10 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1037ui_story == nil then
				arg_133_1.var_.characterEffect1037ui_story = var_136_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_11 = 0.034000001847744

			if var_136_10 <= arg_133_1.time_ and arg_133_1.time_ < var_136_10 + var_136_11 and not isNil(var_136_9) then
				local var_136_12 = (arg_133_1.time_ - var_136_10) / var_136_11

				if arg_133_1.var_.characterEffect1037ui_story and not isNil(var_136_9) then
					local var_136_13 = Mathf.Lerp(0, 0.5, var_136_12)

					arg_133_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1037ui_story.fillRatio = var_136_13
				end
			end

			if arg_133_1.time_ >= var_136_10 + var_136_11 and arg_133_1.time_ < var_136_10 + var_136_11 + arg_136_0 and not isNil(var_136_9) and arg_133_1.var_.characterEffect1037ui_story then
				local var_136_14 = 0.5

				arg_133_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1037ui_story.fillRatio = var_136_14
			end

			local var_136_15 = 0

			if var_136_15 < arg_133_1.time_ and arg_133_1.time_ <= var_136_15 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_16 = 2

			if var_136_15 <= arg_133_1.time_ and arg_133_1.time_ < var_136_15 + var_136_16 then
				local var_136_17 = (arg_133_1.time_ - var_136_15) / var_136_16
				local var_136_18 = Color.New(0, 0, 0)

				var_136_18.a = Mathf.Lerp(0, 1, var_136_17)
				arg_133_1.mask_.color = var_136_18
			end

			if arg_133_1.time_ >= var_136_15 + var_136_16 and arg_133_1.time_ < var_136_15 + var_136_16 + arg_136_0 then
				local var_136_19 = Color.New(0, 0, 0)

				var_136_19.a = 1
				arg_133_1.mask_.color = var_136_19
			end

			local var_136_20 = 2

			if var_136_20 < arg_133_1.time_ and arg_133_1.time_ <= var_136_20 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_21 = 2

			if var_136_20 <= arg_133_1.time_ and arg_133_1.time_ < var_136_20 + var_136_21 then
				local var_136_22 = (arg_133_1.time_ - var_136_20) / var_136_21
				local var_136_23 = Color.New(0, 0, 0)

				var_136_23.a = Mathf.Lerp(1, 0, var_136_22)
				arg_133_1.mask_.color = var_136_23
			end

			if arg_133_1.time_ >= var_136_20 + var_136_21 and arg_133_1.time_ < var_136_20 + var_136_21 + arg_136_0 then
				local var_136_24 = Color.New(0, 0, 0)
				local var_136_25 = 0

				arg_133_1.mask_.enabled = false
				var_136_24.a = var_136_25
				arg_133_1.mask_.color = var_136_24
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_26 = 4
			local var_136_27 = 0.875

			if var_136_26 < arg_133_1.time_ and arg_133_1.time_ <= var_136_26 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_28 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_28:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_29 = arg_133_1:GetWordFromCfg(1108503033)
				local var_136_30 = arg_133_1:FormatText(var_136_29.content)

				arg_133_1.text_.text = var_136_30

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_31 = 35
				local var_136_32 = utf8.len(var_136_30)
				local var_136_33 = var_136_31 <= 0 and var_136_27 or var_136_27 * (var_136_32 / var_136_31)

				if var_136_33 > 0 and var_136_27 < var_136_33 then
					arg_133_1.talkMaxDuration = var_136_33
					var_136_26 = var_136_26 + 0.3

					if var_136_33 + var_136_26 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_33 + var_136_26
					end
				end

				arg_133_1.text_.text = var_136_30
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_34 = var_136_26 + 0.3
			local var_136_35 = math.max(var_136_27, arg_133_1.talkMaxDuration)

			if var_136_34 <= arg_133_1.time_ and arg_133_1.time_ < var_136_34 + var_136_35 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_34) / var_136_35

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_34 + var_136_35 and arg_133_1.time_ < var_136_34 + var_136_35 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play1108503034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 1108503034
		arg_139_1.duration_ = 4.87

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play1108503035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["1037ui_story"].transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.moveOldPos1037ui_story = var_142_0.localPosition
			end

			local var_142_2 = 0.001

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2
				local var_142_4 = Vector3.New(-0.7, -1.09, -5.81)

				var_142_0.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1037ui_story, var_142_4, var_142_3)

				local var_142_5 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_5.x, var_142_5.y, var_142_5.z)

				local var_142_6 = var_142_0.localEulerAngles

				var_142_6.z = 0
				var_142_6.x = 0
				var_142_0.localEulerAngles = var_142_6
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = Vector3.New(-0.7, -1.09, -5.81)

				local var_142_7 = manager.ui.mainCamera.transform.position - var_142_0.position

				var_142_0.forward = Vector3.New(var_142_7.x, var_142_7.y, var_142_7.z)

				local var_142_8 = var_142_0.localEulerAngles

				var_142_8.z = 0
				var_142_8.x = 0
				var_142_0.localEulerAngles = var_142_8
			end

			local var_142_9 = arg_139_1.actors_["1037ui_story"]
			local var_142_10 = 0

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1037ui_story == nil then
				arg_139_1.var_.characterEffect1037ui_story = var_142_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_11 = 0.200000002980232

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_11 and not isNil(var_142_9) then
				local var_142_12 = (arg_139_1.time_ - var_142_10) / var_142_11

				if arg_139_1.var_.characterEffect1037ui_story and not isNil(var_142_9) then
					arg_139_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_10 + var_142_11 and arg_139_1.time_ < var_142_10 + var_142_11 + arg_142_0 and not isNil(var_142_9) and arg_139_1.var_.characterEffect1037ui_story then
				arg_139_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_142_13 = 0

			if var_142_13 < arg_139_1.time_ and arg_139_1.time_ <= var_142_13 + arg_142_0 then
				arg_139_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action1_1")
			end

			local var_142_14 = 0

			if var_142_14 < arg_139_1.time_ and arg_139_1.time_ <= var_142_14 + arg_142_0 then
				arg_139_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_142_15 = 0
			local var_142_16 = 0.6

			if var_142_15 < arg_139_1.time_ and arg_139_1.time_ <= var_142_15 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_17 = arg_139_1:FormatText(StoryNameCfg[15].name)

				arg_139_1.leftNameTxt_.text = var_142_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_18 = arg_139_1:GetWordFromCfg(1108503034)
				local var_142_19 = arg_139_1:FormatText(var_142_18.content)

				arg_139_1.text_.text = var_142_19

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_20 = 24
				local var_142_21 = utf8.len(var_142_19)
				local var_142_22 = var_142_20 <= 0 and var_142_16 or var_142_16 * (var_142_21 / var_142_20)

				if var_142_22 > 0 and var_142_16 < var_142_22 then
					arg_139_1.talkMaxDuration = var_142_22

					if var_142_22 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_22 + var_142_15
					end
				end

				arg_139_1.text_.text = var_142_19
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503034", "story_v_side_new_1108503.awb") ~= 0 then
					local var_142_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503034", "story_v_side_new_1108503.awb") / 1000

					if var_142_23 + var_142_15 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_23 + var_142_15
					end

					if var_142_18.prefab_name ~= "" and arg_139_1.actors_[var_142_18.prefab_name] ~= nil then
						local var_142_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_18.prefab_name].transform, "story_v_side_new_1108503", "1108503034", "story_v_side_new_1108503.awb")

						arg_139_1:RecordAudio("1108503034", var_142_24)
						arg_139_1:RecordAudio("1108503034", var_142_24)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503034", "story_v_side_new_1108503.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503034", "story_v_side_new_1108503.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_25 = math.max(var_142_16, arg_139_1.talkMaxDuration)

			if var_142_15 <= arg_139_1.time_ and arg_139_1.time_ < var_142_15 + var_142_25 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_15) / var_142_25

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_15 + var_142_25 and arg_139_1.time_ < var_142_15 + var_142_25 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play1108503035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 1108503035
		arg_143_1.duration_ = 2.9

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play1108503036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = arg_143_1.actors_["1085ui_story"].transform
			local var_146_1 = 0

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.var_.moveOldPos1085ui_story = var_146_0.localPosition
			end

			local var_146_2 = 0.001

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_2 then
				local var_146_3 = (arg_143_1.time_ - var_146_1) / var_146_2
				local var_146_4 = Vector3.New(0.75, -1.01, -5.83)

				var_146_0.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1085ui_story, var_146_4, var_146_3)

				local var_146_5 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_5.x, var_146_5.y, var_146_5.z)

				local var_146_6 = var_146_0.localEulerAngles

				var_146_6.z = 0
				var_146_6.x = 0
				var_146_0.localEulerAngles = var_146_6
			end

			if arg_143_1.time_ >= var_146_1 + var_146_2 and arg_143_1.time_ < var_146_1 + var_146_2 + arg_146_0 then
				var_146_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_146_7 = manager.ui.mainCamera.transform.position - var_146_0.position

				var_146_0.forward = Vector3.New(var_146_7.x, var_146_7.y, var_146_7.z)

				local var_146_8 = var_146_0.localEulerAngles

				var_146_8.z = 0
				var_146_8.x = 0
				var_146_0.localEulerAngles = var_146_8
			end

			local var_146_9 = arg_143_1.actors_["1085ui_story"]
			local var_146_10 = 0

			if var_146_10 < arg_143_1.time_ and arg_143_1.time_ <= var_146_10 + arg_146_0 and not isNil(var_146_9) and arg_143_1.var_.characterEffect1085ui_story == nil then
				arg_143_1.var_.characterEffect1085ui_story = var_146_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_11 = 0.200000002980232

			if var_146_10 <= arg_143_1.time_ and arg_143_1.time_ < var_146_10 + var_146_11 and not isNil(var_146_9) then
				local var_146_12 = (arg_143_1.time_ - var_146_10) / var_146_11

				if arg_143_1.var_.characterEffect1085ui_story and not isNil(var_146_9) then
					arg_143_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= var_146_10 + var_146_11 and arg_143_1.time_ < var_146_10 + var_146_11 + arg_146_0 and not isNil(var_146_9) and arg_143_1.var_.characterEffect1085ui_story then
				arg_143_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_146_13 = arg_143_1.actors_["1037ui_story"]
			local var_146_14 = 0

			if var_146_14 < arg_143_1.time_ and arg_143_1.time_ <= var_146_14 + arg_146_0 and not isNil(var_146_13) and arg_143_1.var_.characterEffect1037ui_story == nil then
				arg_143_1.var_.characterEffect1037ui_story = var_146_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_15 = 0.200000002980232

			if var_146_14 <= arg_143_1.time_ and arg_143_1.time_ < var_146_14 + var_146_15 and not isNil(var_146_13) then
				local var_146_16 = (arg_143_1.time_ - var_146_14) / var_146_15

				if arg_143_1.var_.characterEffect1037ui_story and not isNil(var_146_13) then
					local var_146_17 = Mathf.Lerp(0, 0.5, var_146_16)

					arg_143_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1037ui_story.fillRatio = var_146_17
				end
			end

			if arg_143_1.time_ >= var_146_14 + var_146_15 and arg_143_1.time_ < var_146_14 + var_146_15 + arg_146_0 and not isNil(var_146_13) and arg_143_1.var_.characterEffect1037ui_story then
				local var_146_18 = 0.5

				arg_143_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1037ui_story.fillRatio = var_146_18
			end

			local var_146_19 = 0

			if var_146_19 < arg_143_1.time_ and arg_143_1.time_ <= var_146_19 + arg_146_0 then
				arg_143_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_146_20 = 0

			if var_146_20 < arg_143_1.time_ and arg_143_1.time_ <= var_146_20 + arg_146_0 then
				arg_143_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_146_21 = 0
			local var_146_22 = 0.15

			if var_146_21 < arg_143_1.time_ and arg_143_1.time_ <= var_146_21 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_23 = arg_143_1:FormatText(StoryNameCfg[328].name)

				arg_143_1.leftNameTxt_.text = var_146_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_24 = arg_143_1:GetWordFromCfg(1108503035)
				local var_146_25 = arg_143_1:FormatText(var_146_24.content)

				arg_143_1.text_.text = var_146_25

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_26 = 6
				local var_146_27 = utf8.len(var_146_25)
				local var_146_28 = var_146_26 <= 0 and var_146_22 or var_146_22 * (var_146_27 / var_146_26)

				if var_146_28 > 0 and var_146_22 < var_146_28 then
					arg_143_1.talkMaxDuration = var_146_28

					if var_146_28 + var_146_21 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_28 + var_146_21
					end
				end

				arg_143_1.text_.text = var_146_25
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503035", "story_v_side_new_1108503.awb") ~= 0 then
					local var_146_29 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503035", "story_v_side_new_1108503.awb") / 1000

					if var_146_29 + var_146_21 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_29 + var_146_21
					end

					if var_146_24.prefab_name ~= "" and arg_143_1.actors_[var_146_24.prefab_name] ~= nil then
						local var_146_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_24.prefab_name].transform, "story_v_side_new_1108503", "1108503035", "story_v_side_new_1108503.awb")

						arg_143_1:RecordAudio("1108503035", var_146_30)
						arg_143_1:RecordAudio("1108503035", var_146_30)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503035", "story_v_side_new_1108503.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503035", "story_v_side_new_1108503.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_31 = math.max(var_146_22, arg_143_1.talkMaxDuration)

			if var_146_21 <= arg_143_1.time_ and arg_143_1.time_ < var_146_21 + var_146_31 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_21) / var_146_31

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_21 + var_146_31 and arg_143_1.time_ < var_146_21 + var_146_31 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play1108503036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 1108503036
		arg_147_1.duration_ = 9

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play1108503037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = "B13"

			if arg_147_1.bgs_[var_150_0] == nil then
				local var_150_1 = Object.Instantiate(arg_147_1.paintGo_)

				var_150_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_150_0)
				var_150_1.name = var_150_0
				var_150_1.transform.parent = arg_147_1.stage_.transform
				var_150_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_147_1.bgs_[var_150_0] = var_150_1
			end

			local var_150_2 = 1.999999999999

			if var_150_2 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				local var_150_3 = manager.ui.mainCamera.transform.localPosition
				local var_150_4 = Vector3.New(0, 0, 10) + Vector3.New(var_150_3.x, var_150_3.y, 0)
				local var_150_5 = arg_147_1.bgs_.B13

				var_150_5.transform.localPosition = var_150_4
				var_150_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_150_6 = var_150_5:GetComponent("SpriteRenderer")

				if var_150_6 and var_150_6.sprite then
					local var_150_7 = (var_150_5.transform.localPosition - var_150_3).z
					local var_150_8 = manager.ui.mainCameraCom_
					local var_150_9 = 2 * var_150_7 * Mathf.Tan(var_150_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_150_10 = var_150_9 * var_150_8.aspect
					local var_150_11 = var_150_6.sprite.bounds.size.x
					local var_150_12 = var_150_6.sprite.bounds.size.y
					local var_150_13 = var_150_10 / var_150_11
					local var_150_14 = var_150_9 / var_150_12
					local var_150_15 = var_150_14 < var_150_13 and var_150_13 or var_150_14

					var_150_5.transform.localScale = Vector3.New(var_150_15, var_150_15, 0)
				end

				for iter_150_0, iter_150_1 in pairs(arg_147_1.bgs_) do
					if iter_150_0 ~= "B13" then
						iter_150_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_150_16 = 3.999999999999

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 then
				arg_147_1.allBtn_.enabled = false
			end

			local var_150_17 = 0.3

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 then
				arg_147_1.allBtn_.enabled = true
			end

			local var_150_18 = 0

			if var_150_18 < arg_147_1.time_ and arg_147_1.time_ <= var_150_18 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_19 = 2

			if var_150_18 <= arg_147_1.time_ and arg_147_1.time_ < var_150_18 + var_150_19 then
				local var_150_20 = (arg_147_1.time_ - var_150_18) / var_150_19
				local var_150_21 = Color.New(0, 0, 0)

				var_150_21.a = Mathf.Lerp(0, 1, var_150_20)
				arg_147_1.mask_.color = var_150_21
			end

			if arg_147_1.time_ >= var_150_18 + var_150_19 and arg_147_1.time_ < var_150_18 + var_150_19 + arg_150_0 then
				local var_150_22 = Color.New(0, 0, 0)

				var_150_22.a = 1
				arg_147_1.mask_.color = var_150_22
			end

			local var_150_23 = 2

			if var_150_23 < arg_147_1.time_ and arg_147_1.time_ <= var_150_23 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = true

				arg_147_1:SetGaussion(false)
			end

			local var_150_24 = 2

			if var_150_23 <= arg_147_1.time_ and arg_147_1.time_ < var_150_23 + var_150_24 then
				local var_150_25 = (arg_147_1.time_ - var_150_23) / var_150_24
				local var_150_26 = Color.New(0, 0, 0)

				var_150_26.a = Mathf.Lerp(1, 0, var_150_25)
				arg_147_1.mask_.color = var_150_26
			end

			if arg_147_1.time_ >= var_150_23 + var_150_24 and arg_147_1.time_ < var_150_23 + var_150_24 + arg_150_0 then
				local var_150_27 = Color.New(0, 0, 0)
				local var_150_28 = 0

				arg_147_1.mask_.enabled = false
				var_150_27.a = var_150_28
				arg_147_1.mask_.color = var_150_27
			end

			local var_150_29 = arg_147_1.actors_["1085ui_story"].transform
			local var_150_30 = 1.96599999815226

			if var_150_30 < arg_147_1.time_ and arg_147_1.time_ <= var_150_30 + arg_150_0 then
				arg_147_1.var_.moveOldPos1085ui_story = var_150_29.localPosition
			end

			local var_150_31 = 0.001

			if var_150_30 <= arg_147_1.time_ and arg_147_1.time_ < var_150_30 + var_150_31 then
				local var_150_32 = (arg_147_1.time_ - var_150_30) / var_150_31
				local var_150_33 = Vector3.New(0, 100, 0)

				var_150_29.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1085ui_story, var_150_33, var_150_32)

				local var_150_34 = manager.ui.mainCamera.transform.position - var_150_29.position

				var_150_29.forward = Vector3.New(var_150_34.x, var_150_34.y, var_150_34.z)

				local var_150_35 = var_150_29.localEulerAngles

				var_150_35.z = 0
				var_150_35.x = 0
				var_150_29.localEulerAngles = var_150_35
			end

			if arg_147_1.time_ >= var_150_30 + var_150_31 and arg_147_1.time_ < var_150_30 + var_150_31 + arg_150_0 then
				var_150_29.localPosition = Vector3.New(0, 100, 0)

				local var_150_36 = manager.ui.mainCamera.transform.position - var_150_29.position

				var_150_29.forward = Vector3.New(var_150_36.x, var_150_36.y, var_150_36.z)

				local var_150_37 = var_150_29.localEulerAngles

				var_150_37.z = 0
				var_150_37.x = 0
				var_150_29.localEulerAngles = var_150_37
			end

			local var_150_38 = arg_147_1.actors_["1037ui_story"].transform
			local var_150_39 = 1.96599999815226

			if var_150_39 < arg_147_1.time_ and arg_147_1.time_ <= var_150_39 + arg_150_0 then
				arg_147_1.var_.moveOldPos1037ui_story = var_150_38.localPosition
			end

			local var_150_40 = 0.001

			if var_150_39 <= arg_147_1.time_ and arg_147_1.time_ < var_150_39 + var_150_40 then
				local var_150_41 = (arg_147_1.time_ - var_150_39) / var_150_40
				local var_150_42 = Vector3.New(0, 100, 0)

				var_150_38.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1037ui_story, var_150_42, var_150_41)

				local var_150_43 = manager.ui.mainCamera.transform.position - var_150_38.position

				var_150_38.forward = Vector3.New(var_150_43.x, var_150_43.y, var_150_43.z)

				local var_150_44 = var_150_38.localEulerAngles

				var_150_44.z = 0
				var_150_44.x = 0
				var_150_38.localEulerAngles = var_150_44
			end

			if arg_147_1.time_ >= var_150_39 + var_150_40 and arg_147_1.time_ < var_150_39 + var_150_40 + arg_150_0 then
				var_150_38.localPosition = Vector3.New(0, 100, 0)

				local var_150_45 = manager.ui.mainCamera.transform.position - var_150_38.position

				var_150_38.forward = Vector3.New(var_150_45.x, var_150_45.y, var_150_45.z)

				local var_150_46 = var_150_38.localEulerAngles

				var_150_46.z = 0
				var_150_46.x = 0
				var_150_38.localEulerAngles = var_150_46
			end

			local var_150_47 = arg_147_1.actors_["1085ui_story"]
			local var_150_48 = 1.96599999815226

			if var_150_48 < arg_147_1.time_ and arg_147_1.time_ <= var_150_48 + arg_150_0 and not isNil(var_150_47) and arg_147_1.var_.characterEffect1085ui_story == nil then
				arg_147_1.var_.characterEffect1085ui_story = var_150_47:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_49 = 0.034000001847744

			if var_150_48 <= arg_147_1.time_ and arg_147_1.time_ < var_150_48 + var_150_49 and not isNil(var_150_47) then
				local var_150_50 = (arg_147_1.time_ - var_150_48) / var_150_49

				if arg_147_1.var_.characterEffect1085ui_story and not isNil(var_150_47) then
					local var_150_51 = Mathf.Lerp(0, 0.5, var_150_50)

					arg_147_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1085ui_story.fillRatio = var_150_51
				end
			end

			if arg_147_1.time_ >= var_150_48 + var_150_49 and arg_147_1.time_ < var_150_48 + var_150_49 + arg_150_0 and not isNil(var_150_47) and arg_147_1.var_.characterEffect1085ui_story then
				local var_150_52 = 0.5

				arg_147_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1085ui_story.fillRatio = var_150_52
			end

			local var_150_53 = 0.266666666666667
			local var_150_54 = 0.3

			if var_150_53 < arg_147_1.time_ and arg_147_1.time_ <= var_150_53 + arg_150_0 then
				local var_150_55 = "play"
				local var_150_56 = "music"

				arg_147_1:AudioAction(var_150_55, var_150_56, "ui_battle", "ui_battle_stopbgm", "")

				local var_150_57 = ""
				local var_150_58 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_150_58 ~= "" then
					if arg_147_1.bgmTxt_.text ~= var_150_58 and arg_147_1.bgmTxt_.text ~= "" then
						if arg_147_1.bgmTxt2_.text ~= "" then
							arg_147_1.bgmTxt_.text = arg_147_1.bgmTxt2_.text
						end

						arg_147_1.bgmTxt2_.text = var_150_58

						arg_147_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_147_1.bgmTxt_.text = var_150_58
						arg_147_1.bgmTxt2_.text = var_150_58
					end

					if arg_147_1.bgmTimer then
						arg_147_1.bgmTimer:Stop()

						arg_147_1.bgmTimer = nil
					end

					if arg_147_1.settingData.show_music_name == 1 then
						arg_147_1.musicController:SetSelectedState("show")
						arg_147_1.musicAnimator_:Play("open", 0, 0)

						if arg_147_1.settingData.music_time ~= 0 then
							arg_147_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_147_1.settingData.music_time), function()
								if arg_147_1 == nil or isNil(arg_147_1.bgmTxt_) then
									return
								end

								arg_147_1.musicController:SetSelectedState("hide")
								arg_147_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_150_59 = 1.66666666666667
			local var_150_60 = 1

			if var_150_59 < arg_147_1.time_ and arg_147_1.time_ <= var_150_59 + arg_150_0 then
				local var_150_61 = "play"
				local var_150_62 = "music"

				arg_147_1:AudioAction(var_150_61, var_150_62, "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily.awb")

				local var_150_63 = ""
				local var_150_64 = manager.audio:GetAudioName("bgm_activity_4_0_story_daily", "bgm_activity_4_0_story_daily")

				if var_150_64 ~= "" then
					if arg_147_1.bgmTxt_.text ~= var_150_64 and arg_147_1.bgmTxt_.text ~= "" then
						if arg_147_1.bgmTxt2_.text ~= "" then
							arg_147_1.bgmTxt_.text = arg_147_1.bgmTxt2_.text
						end

						arg_147_1.bgmTxt2_.text = var_150_64

						arg_147_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_147_1.bgmTxt_.text = var_150_64
						arg_147_1.bgmTxt2_.text = var_150_64
					end

					if arg_147_1.bgmTimer then
						arg_147_1.bgmTimer:Stop()

						arg_147_1.bgmTimer = nil
					end

					if arg_147_1.settingData.show_music_name == 1 then
						arg_147_1.musicController:SetSelectedState("show")
						arg_147_1.musicAnimator_:Play("open", 0, 0)

						if arg_147_1.settingData.music_time ~= 0 then
							arg_147_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_147_1.settingData.music_time), function()
								if arg_147_1 == nil or isNil(arg_147_1.bgmTxt_) then
									return
								end

								arg_147_1.musicController:SetSelectedState("hide")
								arg_147_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_150_65 = 0.266666666666667
			local var_150_66 = 1

			if var_150_65 < arg_147_1.time_ and arg_147_1.time_ <= var_150_65 + arg_150_0 then
				local var_150_67 = "stop"
				local var_150_68 = "effect"

				arg_147_1:AudioAction(var_150_67, var_150_68, "se_story_birthday4", "se_story_birthday4_amb_room_tone_1", "")
			end

			local var_150_69 = 1.66666666666667
			local var_150_70 = 1

			if var_150_69 < arg_147_1.time_ and arg_147_1.time_ <= var_150_69 + arg_150_0 then
				local var_150_71 = "play"
				local var_150_72 = "effect"

				arg_147_1:AudioAction(var_150_71, var_150_72, "se_story_143", "se_story_143_amb_room", "")
			end

			local var_150_73 = 4.5
			local var_150_74 = 1

			if var_150_73 < arg_147_1.time_ and arg_147_1.time_ <= var_150_73 + arg_150_0 then
				local var_150_75 = "play"
				local var_150_76 = "effect"

				arg_147_1:AudioAction(var_150_75, var_150_76, "se_story_122_02", "se_story_122_02_footstep", "")
			end

			if arg_147_1.frameCnt_ <= 1 then
				arg_147_1.dialog_:SetActive(false)
			end

			local var_150_77 = 3.999999999999
			local var_150_78 = 0.675

			if var_150_77 < arg_147_1.time_ and arg_147_1.time_ <= var_150_77 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0

				arg_147_1.dialog_:SetActive(true)

				arg_147_1.dialogCg_.alpha = 0

				local var_150_79 = LeanTween.value(arg_147_1.dialog_, 0, 1, 0.3)

				var_150_79:setOnUpdate(LuaHelper.FloatAction(function(arg_153_0)
					arg_147_1.dialogCg_.alpha = arg_153_0
				end))
				var_150_79:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_147_1.dialog_)
					var_150_79:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_147_1.duration_ = arg_147_1.duration_ + 0.3

				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_80 = arg_147_1:GetWordFromCfg(1108503036)
				local var_150_81 = arg_147_1:FormatText(var_150_80.content)

				arg_147_1.text_.text = var_150_81

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_82 = 27
				local var_150_83 = utf8.len(var_150_81)
				local var_150_84 = var_150_82 <= 0 and var_150_78 or var_150_78 * (var_150_83 / var_150_82)

				if var_150_84 > 0 and var_150_78 < var_150_84 then
					arg_147_1.talkMaxDuration = var_150_84
					var_150_77 = var_150_77 + 0.3

					if var_150_84 + var_150_77 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_84 + var_150_77
					end
				end

				arg_147_1.text_.text = var_150_81
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_85 = var_150_77 + 0.3
			local var_150_86 = math.max(var_150_78, arg_147_1.talkMaxDuration)

			if var_150_85 <= arg_147_1.time_ and arg_147_1.time_ < var_150_85 + var_150_86 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_85) / var_150_86

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_85 + var_150_86 and arg_147_1.time_ < var_150_85 + var_150_86 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play1108503037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 1108503037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play1108503038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.125

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_2 = arg_155_1:FormatText(StoryNameCfg[7].name)

				arg_155_1.leftNameTxt_.text = var_158_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_3 = arg_155_1:GetWordFromCfg(1108503037)
				local var_158_4 = arg_155_1:FormatText(var_158_3.content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_5 = 5
				local var_158_6 = utf8.len(var_158_4)
				local var_158_7 = var_158_5 <= 0 and var_158_1 or var_158_1 * (var_158_6 / var_158_5)

				if var_158_7 > 0 and var_158_1 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_8 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_8 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_8

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_8 and arg_155_1.time_ < var_158_0 + var_158_8 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play1108503038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 1108503038
		arg_159_1.duration_ = 7.1

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play1108503039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = arg_159_1.actors_["1085ui_story"].transform
			local var_162_1 = 0

			if var_162_1 < arg_159_1.time_ and arg_159_1.time_ <= var_162_1 + arg_162_0 then
				arg_159_1.var_.moveOldPos1085ui_story = var_162_0.localPosition
			end

			local var_162_2 = 0.001

			if var_162_1 <= arg_159_1.time_ and arg_159_1.time_ < var_162_1 + var_162_2 then
				local var_162_3 = (arg_159_1.time_ - var_162_1) / var_162_2
				local var_162_4 = Vector3.New(0, -1.01, -5.83)

				var_162_0.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1085ui_story, var_162_4, var_162_3)

				local var_162_5 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_5.x, var_162_5.y, var_162_5.z)

				local var_162_6 = var_162_0.localEulerAngles

				var_162_6.z = 0
				var_162_6.x = 0
				var_162_0.localEulerAngles = var_162_6
			end

			if arg_159_1.time_ >= var_162_1 + var_162_2 and arg_159_1.time_ < var_162_1 + var_162_2 + arg_162_0 then
				var_162_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_162_7 = manager.ui.mainCamera.transform.position - var_162_0.position

				var_162_0.forward = Vector3.New(var_162_7.x, var_162_7.y, var_162_7.z)

				local var_162_8 = var_162_0.localEulerAngles

				var_162_8.z = 0
				var_162_8.x = 0
				var_162_0.localEulerAngles = var_162_8
			end

			local var_162_9 = arg_159_1.actors_["1085ui_story"]
			local var_162_10 = 0

			if var_162_10 < arg_159_1.time_ and arg_159_1.time_ <= var_162_10 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1085ui_story == nil then
				arg_159_1.var_.characterEffect1085ui_story = var_162_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_11 = 0.200000002980232

			if var_162_10 <= arg_159_1.time_ and arg_159_1.time_ < var_162_10 + var_162_11 and not isNil(var_162_9) then
				local var_162_12 = (arg_159_1.time_ - var_162_10) / var_162_11

				if arg_159_1.var_.characterEffect1085ui_story and not isNil(var_162_9) then
					arg_159_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= var_162_10 + var_162_11 and arg_159_1.time_ < var_162_10 + var_162_11 + arg_162_0 and not isNil(var_162_9) and arg_159_1.var_.characterEffect1085ui_story then
				arg_159_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_162_13 = 0

			if var_162_13 < arg_159_1.time_ and arg_159_1.time_ <= var_162_13 + arg_162_0 then
				arg_159_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_162_14 = 0

			if var_162_14 < arg_159_1.time_ and arg_159_1.time_ <= var_162_14 + arg_162_0 then
				arg_159_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_162_15 = 0
			local var_162_16 = 0.475

			if var_162_15 < arg_159_1.time_ and arg_159_1.time_ <= var_162_15 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_17 = arg_159_1:FormatText(StoryNameCfg[328].name)

				arg_159_1.leftNameTxt_.text = var_162_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_18 = arg_159_1:GetWordFromCfg(1108503038)
				local var_162_19 = arg_159_1:FormatText(var_162_18.content)

				arg_159_1.text_.text = var_162_19

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_20 = 19
				local var_162_21 = utf8.len(var_162_19)
				local var_162_22 = var_162_20 <= 0 and var_162_16 or var_162_16 * (var_162_21 / var_162_20)

				if var_162_22 > 0 and var_162_16 < var_162_22 then
					arg_159_1.talkMaxDuration = var_162_22

					if var_162_22 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_22 + var_162_15
					end
				end

				arg_159_1.text_.text = var_162_19
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503038", "story_v_side_new_1108503.awb") ~= 0 then
					local var_162_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503038", "story_v_side_new_1108503.awb") / 1000

					if var_162_23 + var_162_15 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_23 + var_162_15
					end

					if var_162_18.prefab_name ~= "" and arg_159_1.actors_[var_162_18.prefab_name] ~= nil then
						local var_162_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_18.prefab_name].transform, "story_v_side_new_1108503", "1108503038", "story_v_side_new_1108503.awb")

						arg_159_1:RecordAudio("1108503038", var_162_24)
						arg_159_1:RecordAudio("1108503038", var_162_24)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503038", "story_v_side_new_1108503.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503038", "story_v_side_new_1108503.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_25 = math.max(var_162_16, arg_159_1.talkMaxDuration)

			if var_162_15 <= arg_159_1.time_ and arg_159_1.time_ < var_162_15 + var_162_25 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_15) / var_162_25

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_15 + var_162_25 and arg_159_1.time_ < var_162_15 + var_162_25 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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

		arg_159_1:InitPlayNodeList()
	end,
	Play1108503039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 1108503039
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play1108503040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["1085ui_story"]
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1085ui_story == nil then
				arg_163_1.var_.characterEffect1085ui_story = var_166_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 and not isNil(var_166_0) then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2

				if arg_163_1.var_.characterEffect1085ui_story and not isNil(var_166_0) then
					local var_166_4 = Mathf.Lerp(0, 0.5, var_166_3)

					arg_163_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1085ui_story.fillRatio = var_166_4
				end
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 and not isNil(var_166_0) and arg_163_1.var_.characterEffect1085ui_story then
				local var_166_5 = 0.5

				arg_163_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1085ui_story.fillRatio = var_166_5
			end

			local var_166_6 = 0
			local var_166_7 = 0.45

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

				local var_166_9 = arg_163_1:GetWordFromCfg(1108503039)
				local var_166_10 = arg_163_1:FormatText(var_166_9.content)

				arg_163_1.text_.text = var_166_10

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_11 = 18
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
	Play1108503040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 1108503040
		arg_167_1.duration_ = 10.37

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play1108503041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["1085ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1085ui_story == nil then
				arg_167_1.var_.characterEffect1085ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 and not isNil(var_170_0) then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect1085ui_story and not isNil(var_170_0) then
					arg_167_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and not isNil(var_170_0) and arg_167_1.var_.characterEffect1085ui_story then
				arg_167_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_170_4 = 0

			if var_170_4 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action434")
			end

			local var_170_5 = 0

			if var_170_5 < arg_167_1.time_ and arg_167_1.time_ <= var_170_5 + arg_170_0 then
				arg_167_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_170_6 = 0
			local var_170_7 = 0.8

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_8 = arg_167_1:FormatText(StoryNameCfg[328].name)

				arg_167_1.leftNameTxt_.text = var_170_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_9 = arg_167_1:GetWordFromCfg(1108503040)
				local var_170_10 = arg_167_1:FormatText(var_170_9.content)

				arg_167_1.text_.text = var_170_10

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_11 = 32
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

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503040", "story_v_side_new_1108503.awb") ~= 0 then
					local var_170_14 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503040", "story_v_side_new_1108503.awb") / 1000

					if var_170_14 + var_170_6 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_14 + var_170_6
					end

					if var_170_9.prefab_name ~= "" and arg_167_1.actors_[var_170_9.prefab_name] ~= nil then
						local var_170_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_9.prefab_name].transform, "story_v_side_new_1108503", "1108503040", "story_v_side_new_1108503.awb")

						arg_167_1:RecordAudio("1108503040", var_170_15)
						arg_167_1:RecordAudio("1108503040", var_170_15)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503040", "story_v_side_new_1108503.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503040", "story_v_side_new_1108503.awb")
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
	Play1108503041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 1108503041
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play1108503042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["1085ui_story"]
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1085ui_story == nil then
				arg_171_1.var_.characterEffect1085ui_story = var_174_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 and not isNil(var_174_0) then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2

				if arg_171_1.var_.characterEffect1085ui_story and not isNil(var_174_0) then
					local var_174_4 = Mathf.Lerp(0, 0.5, var_174_3)

					arg_171_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1085ui_story.fillRatio = var_174_4
				end
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 and not isNil(var_174_0) and arg_171_1.var_.characterEffect1085ui_story then
				local var_174_5 = 0.5

				arg_171_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1085ui_story.fillRatio = var_174_5
			end

			local var_174_6 = 0
			local var_174_7 = 0.75

			if var_174_6 < arg_171_1.time_ and arg_171_1.time_ <= var_174_6 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_8 = arg_171_1:FormatText(StoryNameCfg[7].name)

				arg_171_1.leftNameTxt_.text = var_174_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_9 = arg_171_1:GetWordFromCfg(1108503041)
				local var_174_10 = arg_171_1:FormatText(var_174_9.content)

				arg_171_1.text_.text = var_174_10

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_11 = 30
				local var_174_12 = utf8.len(var_174_10)
				local var_174_13 = var_174_11 <= 0 and var_174_7 or var_174_7 * (var_174_12 / var_174_11)

				if var_174_13 > 0 and var_174_7 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_6 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_6
					end
				end

				arg_171_1.text_.text = var_174_10
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_14 = math.max(var_174_7, arg_171_1.talkMaxDuration)

			if var_174_6 <= arg_171_1.time_ and arg_171_1.time_ < var_174_6 + var_174_14 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_6) / var_174_14

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_6 + var_174_14 and arg_171_1.time_ < var_174_6 + var_174_14 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play1108503042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 1108503042
		arg_175_1.duration_ = 3.87

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play1108503043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1085ui_story"].transform
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.var_.moveOldPos1085ui_story = var_178_0.localPosition
			end

			local var_178_2 = 0.001

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2
				local var_178_4 = Vector3.New(0, -1.01, -5.83)

				var_178_0.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1085ui_story, var_178_4, var_178_3)

				local var_178_5 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_5.x, var_178_5.y, var_178_5.z)

				local var_178_6 = var_178_0.localEulerAngles

				var_178_6.z = 0
				var_178_6.x = 0
				var_178_0.localEulerAngles = var_178_6
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				var_178_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_178_7 = manager.ui.mainCamera.transform.position - var_178_0.position

				var_178_0.forward = Vector3.New(var_178_7.x, var_178_7.y, var_178_7.z)

				local var_178_8 = var_178_0.localEulerAngles

				var_178_8.z = 0
				var_178_8.x = 0
				var_178_0.localEulerAngles = var_178_8
			end

			local var_178_9 = arg_175_1.actors_["1085ui_story"]
			local var_178_10 = 0

			if var_178_10 < arg_175_1.time_ and arg_175_1.time_ <= var_178_10 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect1085ui_story == nil then
				arg_175_1.var_.characterEffect1085ui_story = var_178_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_11 = 0.200000002980232

			if var_178_10 <= arg_175_1.time_ and arg_175_1.time_ < var_178_10 + var_178_11 and not isNil(var_178_9) then
				local var_178_12 = (arg_175_1.time_ - var_178_10) / var_178_11

				if arg_175_1.var_.characterEffect1085ui_story and not isNil(var_178_9) then
					arg_175_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_10 + var_178_11 and arg_175_1.time_ < var_178_10 + var_178_11 + arg_178_0 and not isNil(var_178_9) and arg_175_1.var_.characterEffect1085ui_story then
				arg_175_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_178_13 = 0

			if var_178_13 < arg_175_1.time_ and arg_175_1.time_ <= var_178_13 + arg_178_0 then
				arg_175_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			local var_178_14 = 0

			if var_178_14 < arg_175_1.time_ and arg_175_1.time_ <= var_178_14 + arg_178_0 then
				arg_175_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_178_15 = 0
			local var_178_16 = 0.325

			if var_178_15 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_17 = arg_175_1:FormatText(StoryNameCfg[328].name)

				arg_175_1.leftNameTxt_.text = var_178_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_18 = arg_175_1:GetWordFromCfg(1108503042)
				local var_178_19 = arg_175_1:FormatText(var_178_18.content)

				arg_175_1.text_.text = var_178_19

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_20 = 13
				local var_178_21 = utf8.len(var_178_19)
				local var_178_22 = var_178_20 <= 0 and var_178_16 or var_178_16 * (var_178_21 / var_178_20)

				if var_178_22 > 0 and var_178_16 < var_178_22 then
					arg_175_1.talkMaxDuration = var_178_22

					if var_178_22 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_22 + var_178_15
					end
				end

				arg_175_1.text_.text = var_178_19
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503042", "story_v_side_new_1108503.awb") ~= 0 then
					local var_178_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503042", "story_v_side_new_1108503.awb") / 1000

					if var_178_23 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_23 + var_178_15
					end

					if var_178_18.prefab_name ~= "" and arg_175_1.actors_[var_178_18.prefab_name] ~= nil then
						local var_178_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_18.prefab_name].transform, "story_v_side_new_1108503", "1108503042", "story_v_side_new_1108503.awb")

						arg_175_1:RecordAudio("1108503042", var_178_24)
						arg_175_1:RecordAudio("1108503042", var_178_24)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503042", "story_v_side_new_1108503.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503042", "story_v_side_new_1108503.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_25 = math.max(var_178_16, arg_175_1.talkMaxDuration)

			if var_178_15 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_25 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_15) / var_178_25

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_15 + var_178_25 and arg_175_1.time_ < var_178_15 + var_178_25 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play1108503043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 1108503043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play1108503044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1085ui_story"].transform
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.var_.moveOldPos1085ui_story = var_182_0.localPosition
			end

			local var_182_2 = 0.001

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2
				local var_182_4 = Vector3.New(0, 100, 0)

				var_182_0.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1085ui_story, var_182_4, var_182_3)

				local var_182_5 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_5.x, var_182_5.y, var_182_5.z)

				local var_182_6 = var_182_0.localEulerAngles

				var_182_6.z = 0
				var_182_6.x = 0
				var_182_0.localEulerAngles = var_182_6
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 then
				var_182_0.localPosition = Vector3.New(0, 100, 0)

				local var_182_7 = manager.ui.mainCamera.transform.position - var_182_0.position

				var_182_0.forward = Vector3.New(var_182_7.x, var_182_7.y, var_182_7.z)

				local var_182_8 = var_182_0.localEulerAngles

				var_182_8.z = 0
				var_182_8.x = 0
				var_182_0.localEulerAngles = var_182_8
			end

			local var_182_9 = arg_179_1.actors_["1085ui_story"]
			local var_182_10 = 0

			if var_182_10 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 and not isNil(var_182_9) and arg_179_1.var_.characterEffect1085ui_story == nil then
				arg_179_1.var_.characterEffect1085ui_story = var_182_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_11 = 0.200000002980232

			if var_182_10 <= arg_179_1.time_ and arg_179_1.time_ < var_182_10 + var_182_11 and not isNil(var_182_9) then
				local var_182_12 = (arg_179_1.time_ - var_182_10) / var_182_11

				if arg_179_1.var_.characterEffect1085ui_story and not isNil(var_182_9) then
					local var_182_13 = Mathf.Lerp(0, 0.5, var_182_12)

					arg_179_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1085ui_story.fillRatio = var_182_13
				end
			end

			if arg_179_1.time_ >= var_182_10 + var_182_11 and arg_179_1.time_ < var_182_10 + var_182_11 + arg_182_0 and not isNil(var_182_9) and arg_179_1.var_.characterEffect1085ui_story then
				local var_182_14 = 0.5

				arg_179_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1085ui_story.fillRatio = var_182_14
			end

			local var_182_15 = 0
			local var_182_16 = 0.75

			if var_182_15 < arg_179_1.time_ and arg_179_1.time_ <= var_182_15 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_17 = arg_179_1:GetWordFromCfg(1108503043)
				local var_182_18 = arg_179_1:FormatText(var_182_17.content)

				arg_179_1.text_.text = var_182_18

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_19 = 30
				local var_182_20 = utf8.len(var_182_18)
				local var_182_21 = var_182_19 <= 0 and var_182_16 or var_182_16 * (var_182_20 / var_182_19)

				if var_182_21 > 0 and var_182_16 < var_182_21 then
					arg_179_1.talkMaxDuration = var_182_21

					if var_182_21 + var_182_15 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_21 + var_182_15
					end
				end

				arg_179_1.text_.text = var_182_18
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_22 = math.max(var_182_16, arg_179_1.talkMaxDuration)

			if var_182_15 <= arg_179_1.time_ and arg_179_1.time_ < var_182_15 + var_182_22 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_15) / var_182_22

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_15 + var_182_22 and arg_179_1.time_ < var_182_15 + var_182_22 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play1108503044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 1108503044
		arg_183_1.duration_ = 2.63

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play1108503045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["1085ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos1085ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0, -1.01, -5.83)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1085ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["1085ui_story"]
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1085ui_story == nil then
				arg_183_1.var_.characterEffect1085ui_story = var_186_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 and not isNil(var_186_9) then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11

				if arg_183_1.var_.characterEffect1085ui_story and not isNil(var_186_9) then
					arg_183_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 and not isNil(var_186_9) and arg_183_1.var_.characterEffect1085ui_story then
				arg_183_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_186_13 = 0

			if var_186_13 < arg_183_1.time_ and arg_183_1.time_ <= var_186_13 + arg_186_0 then
				arg_183_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_186_14 = 0

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_186_15 = 0
			local var_186_16 = 0.125

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_17 = arg_183_1:FormatText(StoryNameCfg[328].name)

				arg_183_1.leftNameTxt_.text = var_186_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_18 = arg_183_1:GetWordFromCfg(1108503044)
				local var_186_19 = arg_183_1:FormatText(var_186_18.content)

				arg_183_1.text_.text = var_186_19

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 5
				local var_186_21 = utf8.len(var_186_19)
				local var_186_22 = var_186_20 <= 0 and var_186_16 or var_186_16 * (var_186_21 / var_186_20)

				if var_186_22 > 0 and var_186_16 < var_186_22 then
					arg_183_1.talkMaxDuration = var_186_22

					if var_186_22 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_22 + var_186_15
					end
				end

				arg_183_1.text_.text = var_186_19
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503044", "story_v_side_new_1108503.awb") ~= 0 then
					local var_186_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503044", "story_v_side_new_1108503.awb") / 1000

					if var_186_23 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_15
					end

					if var_186_18.prefab_name ~= "" and arg_183_1.actors_[var_186_18.prefab_name] ~= nil then
						local var_186_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_18.prefab_name].transform, "story_v_side_new_1108503", "1108503044", "story_v_side_new_1108503.awb")

						arg_183_1:RecordAudio("1108503044", var_186_24)
						arg_183_1:RecordAudio("1108503044", var_186_24)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503044", "story_v_side_new_1108503.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503044", "story_v_side_new_1108503.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_25 = math.max(var_186_16, arg_183_1.talkMaxDuration)

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_25 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_15) / var_186_25

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_15 + var_186_25 and arg_183_1.time_ < var_186_15 + var_186_25 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play1108503045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 1108503045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play1108503046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1085ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1085ui_story == nil then
				arg_187_1.var_.characterEffect1085ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1085ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1085ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1085ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1085ui_story.fillRatio = var_190_5
			end

			local var_190_6 = 0
			local var_190_7 = 0.575

			if var_190_6 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_8 = arg_187_1:FormatText(StoryNameCfg[7].name)

				arg_187_1.leftNameTxt_.text = var_190_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, true)
				arg_187_1.iconController_:SetSelectedState("hero")

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_9 = arg_187_1:GetWordFromCfg(1108503045)
				local var_190_10 = arg_187_1:FormatText(var_190_9.content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 23
				local var_190_12 = utf8.len(var_190_10)
				local var_190_13 = var_190_11 <= 0 and var_190_7 or var_190_7 * (var_190_12 / var_190_11)

				if var_190_13 > 0 and var_190_7 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_6 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_6
					end
				end

				arg_187_1.text_.text = var_190_10
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_14 = math.max(var_190_7, arg_187_1.talkMaxDuration)

			if var_190_6 <= arg_187_1.time_ and arg_187_1.time_ < var_190_6 + var_190_14 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_6) / var_190_14

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_6 + var_190_14 and arg_187_1.time_ < var_190_6 + var_190_14 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play1108503046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 1108503046
		arg_191_1.duration_ = 5

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play1108503047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.775

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

				local var_194_3 = arg_191_1:GetWordFromCfg(1108503046)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 31
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
	Play1108503047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 1108503047
		arg_195_1.duration_ = 6.4

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play1108503048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1085ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1085ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.001

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(0, -1.01, -5.83)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1085ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = arg_195_1.actors_["1085ui_story"]
			local var_198_10 = 0

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1085ui_story == nil then
				arg_195_1.var_.characterEffect1085ui_story = var_198_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_11 = 0.200000002980232

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_11 and not isNil(var_198_9) then
				local var_198_12 = (arg_195_1.time_ - var_198_10) / var_198_11

				if arg_195_1.var_.characterEffect1085ui_story and not isNil(var_198_9) then
					arg_195_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_10 + var_198_11 and arg_195_1.time_ < var_198_10 + var_198_11 + arg_198_0 and not isNil(var_198_9) and arg_195_1.var_.characterEffect1085ui_story then
				arg_195_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_198_13 = 0

			if var_198_13 < arg_195_1.time_ and arg_195_1.time_ <= var_198_13 + arg_198_0 then
				arg_195_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_198_14 = 0

			if var_198_14 < arg_195_1.time_ and arg_195_1.time_ <= var_198_14 + arg_198_0 then
				arg_195_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_198_15 = 0
			local var_198_16 = 0.325

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_17 = arg_195_1:FormatText(StoryNameCfg[328].name)

				arg_195_1.leftNameTxt_.text = var_198_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_18 = arg_195_1:GetWordFromCfg(1108503047)
				local var_198_19 = arg_195_1:FormatText(var_198_18.content)

				arg_195_1.text_.text = var_198_19

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_20 = 13
				local var_198_21 = utf8.len(var_198_19)
				local var_198_22 = var_198_20 <= 0 and var_198_16 or var_198_16 * (var_198_21 / var_198_20)

				if var_198_22 > 0 and var_198_16 < var_198_22 then
					arg_195_1.talkMaxDuration = var_198_22

					if var_198_22 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_22 + var_198_15
					end
				end

				arg_195_1.text_.text = var_198_19
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503047", "story_v_side_new_1108503.awb") ~= 0 then
					local var_198_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503047", "story_v_side_new_1108503.awb") / 1000

					if var_198_23 + var_198_15 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_23 + var_198_15
					end

					if var_198_18.prefab_name ~= "" and arg_195_1.actors_[var_198_18.prefab_name] ~= nil then
						local var_198_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_18.prefab_name].transform, "story_v_side_new_1108503", "1108503047", "story_v_side_new_1108503.awb")

						arg_195_1:RecordAudio("1108503047", var_198_24)
						arg_195_1:RecordAudio("1108503047", var_198_24)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503047", "story_v_side_new_1108503.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503047", "story_v_side_new_1108503.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_25 = math.max(var_198_16, arg_195_1.talkMaxDuration)

			if var_198_15 <= arg_195_1.time_ and arg_195_1.time_ < var_198_15 + var_198_25 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_15) / var_198_25

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_15 + var_198_25 and arg_195_1.time_ < var_198_15 + var_198_25 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
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

		arg_195_1:InitPlayNodeList()
	end,
	Play1108503048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 1108503048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play1108503049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["1085ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1085ui_story == nil then
				arg_199_1.var_.characterEffect1085ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 and not isNil(var_202_0) then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect1085ui_story and not isNil(var_202_0) then
					local var_202_4 = Mathf.Lerp(0, 0.5, var_202_3)

					arg_199_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_199_1.var_.characterEffect1085ui_story.fillRatio = var_202_4
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and not isNil(var_202_0) and arg_199_1.var_.characterEffect1085ui_story then
				local var_202_5 = 0.5

				arg_199_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_199_1.var_.characterEffect1085ui_story.fillRatio = var_202_5
			end

			local var_202_6 = 0
			local var_202_7 = 0.2

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

				local var_202_9 = arg_199_1:GetWordFromCfg(1108503048)
				local var_202_10 = arg_199_1:FormatText(var_202_9.content)

				arg_199_1.text_.text = var_202_10

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_11 = 8
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
	Play1108503049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 1108503049
		arg_203_1.duration_ = 6.07

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play1108503050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = "ST07a"

			if arg_203_1.bgs_[var_206_0] == nil then
				local var_206_1 = Object.Instantiate(arg_203_1.paintGo_)

				var_206_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_206_0)
				var_206_1.name = var_206_0
				var_206_1.transform.parent = arg_203_1.stage_.transform
				var_206_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_203_1.bgs_[var_206_0] = var_206_1
			end

			local var_206_2 = 2

			if var_206_2 < arg_203_1.time_ and arg_203_1.time_ <= var_206_2 + arg_206_0 then
				local var_206_3 = manager.ui.mainCamera.transform.localPosition
				local var_206_4 = Vector3.New(0, 0, 10) + Vector3.New(var_206_3.x, var_206_3.y, 0)
				local var_206_5 = arg_203_1.bgs_.ST07a

				var_206_5.transform.localPosition = var_206_4
				var_206_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_206_6 = var_206_5:GetComponent("SpriteRenderer")

				if var_206_6 and var_206_6.sprite then
					local var_206_7 = (var_206_5.transform.localPosition - var_206_3).z
					local var_206_8 = manager.ui.mainCameraCom_
					local var_206_9 = 2 * var_206_7 * Mathf.Tan(var_206_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_206_10 = var_206_9 * var_206_8.aspect
					local var_206_11 = var_206_6.sprite.bounds.size.x
					local var_206_12 = var_206_6.sprite.bounds.size.y
					local var_206_13 = var_206_10 / var_206_11
					local var_206_14 = var_206_9 / var_206_12
					local var_206_15 = var_206_14 < var_206_13 and var_206_13 or var_206_14

					var_206_5.transform.localScale = Vector3.New(var_206_15, var_206_15, 0)
				end

				for iter_206_0, iter_206_1 in pairs(arg_203_1.bgs_) do
					if iter_206_0 ~= "ST07a" then
						iter_206_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_206_16 = 4

			if var_206_16 < arg_203_1.time_ and arg_203_1.time_ <= var_206_16 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			local var_206_17 = 0.3

			if arg_203_1.time_ >= var_206_16 + var_206_17 and arg_203_1.time_ < var_206_16 + var_206_17 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			local var_206_18 = 0

			if var_206_18 < arg_203_1.time_ and arg_203_1.time_ <= var_206_18 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_19 = 2

			if var_206_18 <= arg_203_1.time_ and arg_203_1.time_ < var_206_18 + var_206_19 then
				local var_206_20 = (arg_203_1.time_ - var_206_18) / var_206_19
				local var_206_21 = Color.New(0, 0, 0)

				var_206_21.a = Mathf.Lerp(0, 1, var_206_20)
				arg_203_1.mask_.color = var_206_21
			end

			if arg_203_1.time_ >= var_206_18 + var_206_19 and arg_203_1.time_ < var_206_18 + var_206_19 + arg_206_0 then
				local var_206_22 = Color.New(0, 0, 0)

				var_206_22.a = 1
				arg_203_1.mask_.color = var_206_22
			end

			local var_206_23 = 2

			if var_206_23 < arg_203_1.time_ and arg_203_1.time_ <= var_206_23 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_24 = 2

			if var_206_23 <= arg_203_1.time_ and arg_203_1.time_ < var_206_23 + var_206_24 then
				local var_206_25 = (arg_203_1.time_ - var_206_23) / var_206_24
				local var_206_26 = Color.New(0, 0, 0)

				var_206_26.a = Mathf.Lerp(1, 0, var_206_25)
				arg_203_1.mask_.color = var_206_26
			end

			if arg_203_1.time_ >= var_206_23 + var_206_24 and arg_203_1.time_ < var_206_23 + var_206_24 + arg_206_0 then
				local var_206_27 = Color.New(0, 0, 0)
				local var_206_28 = 0

				arg_203_1.mask_.enabled = false
				var_206_27.a = var_206_28
				arg_203_1.mask_.color = var_206_27
			end

			local var_206_29 = "10066ui_story"

			if arg_203_1.actors_[var_206_29] == nil then
				local var_206_30 = Asset.Load("Char/" .. "10066ui_story")

				if not isNil(var_206_30) then
					local var_206_31 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_203_1.stage_.transform)

					var_206_31.name = var_206_29
					var_206_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_203_1.actors_[var_206_29] = var_206_31

					local var_206_32 = var_206_31:GetComponentInChildren(typeof(CharacterEffect))

					var_206_32.enabled = true

					local var_206_33 = GameObjectTools.GetOrAddComponent(var_206_31, typeof(DynamicBoneHelper))

					if var_206_33 then
						var_206_33:EnableDynamicBone(false)
					end

					arg_203_1:ShowWeapon(var_206_32.transform, false)

					arg_203_1.var_[var_206_29 .. "Animator"] = var_206_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_203_1.var_[var_206_29 .. "Animator"].applyRootMotion = true
					arg_203_1.var_[var_206_29 .. "LipSync"] = var_206_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_206_34 = arg_203_1.actors_["10066ui_story"].transform
			local var_206_35 = 3.8

			if var_206_35 < arg_203_1.time_ and arg_203_1.time_ <= var_206_35 + arg_206_0 then
				arg_203_1.var_.moveOldPos10066ui_story = var_206_34.localPosition
			end

			local var_206_36 = 0.001

			if var_206_35 <= arg_203_1.time_ and arg_203_1.time_ < var_206_35 + var_206_36 then
				local var_206_37 = (arg_203_1.time_ - var_206_35) / var_206_36
				local var_206_38 = Vector3.New(0, -0.99, -5.83)

				var_206_34.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10066ui_story, var_206_38, var_206_37)

				local var_206_39 = manager.ui.mainCamera.transform.position - var_206_34.position

				var_206_34.forward = Vector3.New(var_206_39.x, var_206_39.y, var_206_39.z)

				local var_206_40 = var_206_34.localEulerAngles

				var_206_40.z = 0
				var_206_40.x = 0
				var_206_34.localEulerAngles = var_206_40
			end

			if arg_203_1.time_ >= var_206_35 + var_206_36 and arg_203_1.time_ < var_206_35 + var_206_36 + arg_206_0 then
				var_206_34.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_206_41 = manager.ui.mainCamera.transform.position - var_206_34.position

				var_206_34.forward = Vector3.New(var_206_41.x, var_206_41.y, var_206_41.z)

				local var_206_42 = var_206_34.localEulerAngles

				var_206_42.z = 0
				var_206_42.x = 0
				var_206_34.localEulerAngles = var_206_42
			end

			local var_206_43 = arg_203_1.actors_["10066ui_story"]
			local var_206_44 = 3.8

			if var_206_44 < arg_203_1.time_ and arg_203_1.time_ <= var_206_44 + arg_206_0 and not isNil(var_206_43) and arg_203_1.var_.characterEffect10066ui_story == nil then
				arg_203_1.var_.characterEffect10066ui_story = var_206_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_45 = 0.200000002980232

			if var_206_44 <= arg_203_1.time_ and arg_203_1.time_ < var_206_44 + var_206_45 and not isNil(var_206_43) then
				local var_206_46 = (arg_203_1.time_ - var_206_44) / var_206_45

				if arg_203_1.var_.characterEffect10066ui_story and not isNil(var_206_43) then
					arg_203_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= var_206_44 + var_206_45 and arg_203_1.time_ < var_206_44 + var_206_45 + arg_206_0 and not isNil(var_206_43) and arg_203_1.var_.characterEffect10066ui_story then
				arg_203_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_206_47 = 3.8

			if var_206_47 < arg_203_1.time_ and arg_203_1.time_ <= var_206_47 + arg_206_0 then
				arg_203_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_206_48 = 3.8

			if var_206_48 < arg_203_1.time_ and arg_203_1.time_ <= var_206_48 + arg_206_0 then
				arg_203_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_206_49 = arg_203_1.actors_["1085ui_story"].transform
			local var_206_50 = 1.96599999815226

			if var_206_50 < arg_203_1.time_ and arg_203_1.time_ <= var_206_50 + arg_206_0 then
				arg_203_1.var_.moveOldPos1085ui_story = var_206_49.localPosition
			end

			local var_206_51 = 0.001

			if var_206_50 <= arg_203_1.time_ and arg_203_1.time_ < var_206_50 + var_206_51 then
				local var_206_52 = (arg_203_1.time_ - var_206_50) / var_206_51
				local var_206_53 = Vector3.New(0, 100, 0)

				var_206_49.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1085ui_story, var_206_53, var_206_52)

				local var_206_54 = manager.ui.mainCamera.transform.position - var_206_49.position

				var_206_49.forward = Vector3.New(var_206_54.x, var_206_54.y, var_206_54.z)

				local var_206_55 = var_206_49.localEulerAngles

				var_206_55.z = 0
				var_206_55.x = 0
				var_206_49.localEulerAngles = var_206_55
			end

			if arg_203_1.time_ >= var_206_50 + var_206_51 and arg_203_1.time_ < var_206_50 + var_206_51 + arg_206_0 then
				var_206_49.localPosition = Vector3.New(0, 100, 0)

				local var_206_56 = manager.ui.mainCamera.transform.position - var_206_49.position

				var_206_49.forward = Vector3.New(var_206_56.x, var_206_56.y, var_206_56.z)

				local var_206_57 = var_206_49.localEulerAngles

				var_206_57.z = 0
				var_206_57.x = 0
				var_206_49.localEulerAngles = var_206_57
			end

			local var_206_58 = 0.266666666666667
			local var_206_59 = 1

			if var_206_58 < arg_203_1.time_ and arg_203_1.time_ <= var_206_58 + arg_206_0 then
				local var_206_60 = "stop"
				local var_206_61 = "effect"

				arg_203_1:AudioAction(var_206_60, var_206_61, "se_story_143", "se_story_143_amb_room", "")
			end

			local var_206_62 = 1.73333333333333
			local var_206_63 = 1

			if var_206_62 < arg_203_1.time_ and arg_203_1.time_ <= var_206_62 + arg_206_0 then
				local var_206_64 = "play"
				local var_206_65 = "effect"

				arg_203_1:AudioAction(var_206_64, var_206_65, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			if arg_203_1.frameCnt_ <= 1 then
				arg_203_1.dialog_:SetActive(false)
			end

			local var_206_66 = 4
			local var_206_67 = 0.25

			if var_206_66 < arg_203_1.time_ and arg_203_1.time_ <= var_206_66 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				arg_203_1.dialog_:SetActive(true)

				arg_203_1.dialogCg_.alpha = 0

				local var_206_68 = LeanTween.value(arg_203_1.dialog_, 0, 1, 0.3)

				var_206_68:setOnUpdate(LuaHelper.FloatAction(function(arg_207_0)
					arg_203_1.dialogCg_.alpha = arg_207_0
				end))
				var_206_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_203_1.dialog_)
					var_206_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_203_1.duration_ = arg_203_1.duration_ + 0.3

				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_69 = arg_203_1:FormatText(StoryNameCfg[640].name)

				arg_203_1.leftNameTxt_.text = var_206_69

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_70 = arg_203_1:GetWordFromCfg(1108503049)
				local var_206_71 = arg_203_1:FormatText(var_206_70.content)

				arg_203_1.text_.text = var_206_71

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_72 = 10
				local var_206_73 = utf8.len(var_206_71)
				local var_206_74 = var_206_72 <= 0 and var_206_67 or var_206_67 * (var_206_73 / var_206_72)

				if var_206_74 > 0 and var_206_67 < var_206_74 then
					arg_203_1.talkMaxDuration = var_206_74
					var_206_66 = var_206_66 + 0.3

					if var_206_74 + var_206_66 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_74 + var_206_66
					end
				end

				arg_203_1.text_.text = var_206_71
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503049", "story_v_side_new_1108503.awb") ~= 0 then
					local var_206_75 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503049", "story_v_side_new_1108503.awb") / 1000

					if var_206_75 + var_206_66 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_75 + var_206_66
					end

					if var_206_70.prefab_name ~= "" and arg_203_1.actors_[var_206_70.prefab_name] ~= nil then
						local var_206_76 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_70.prefab_name].transform, "story_v_side_new_1108503", "1108503049", "story_v_side_new_1108503.awb")

						arg_203_1:RecordAudio("1108503049", var_206_76)
						arg_203_1:RecordAudio("1108503049", var_206_76)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503049", "story_v_side_new_1108503.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503049", "story_v_side_new_1108503.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_77 = var_206_66 + 0.3
			local var_206_78 = math.max(var_206_67, arg_203_1.talkMaxDuration)

			if var_206_77 <= arg_203_1.time_ and arg_203_1.time_ < var_206_77 + var_206_78 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_77) / var_206_78

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_77 + var_206_78 and arg_203_1.time_ < var_206_77 + var_206_78 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_203_1:InitPlayNodeList()
	end,
	Play1108503050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 1108503050
		arg_209_1.duration_ = 2

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play1108503051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			local var_212_0 = arg_209_1.actors_["1085ui_story"].transform
			local var_212_1 = 0

			if var_212_1 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.var_.moveOldPos1085ui_story = var_212_0.localPosition
			end

			local var_212_2 = 0.001

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_2 then
				local var_212_3 = (arg_209_1.time_ - var_212_1) / var_212_2
				local var_212_4 = Vector3.New(0.75, -1.01, -5.83)

				var_212_0.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1085ui_story, var_212_4, var_212_3)

				local var_212_5 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_5.x, var_212_5.y, var_212_5.z)

				local var_212_6 = var_212_0.localEulerAngles

				var_212_6.z = 0
				var_212_6.x = 0
				var_212_0.localEulerAngles = var_212_6
			end

			if arg_209_1.time_ >= var_212_1 + var_212_2 and arg_209_1.time_ < var_212_1 + var_212_2 + arg_212_0 then
				var_212_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_212_7 = manager.ui.mainCamera.transform.position - var_212_0.position

				var_212_0.forward = Vector3.New(var_212_7.x, var_212_7.y, var_212_7.z)

				local var_212_8 = var_212_0.localEulerAngles

				var_212_8.z = 0
				var_212_8.x = 0
				var_212_0.localEulerAngles = var_212_8
			end

			local var_212_9 = arg_209_1.actors_["1085ui_story"]
			local var_212_10 = 0

			if var_212_10 < arg_209_1.time_ and arg_209_1.time_ <= var_212_10 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1085ui_story == nil then
				arg_209_1.var_.characterEffect1085ui_story = var_212_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_11 = 0.200000002980232

			if var_212_10 <= arg_209_1.time_ and arg_209_1.time_ < var_212_10 + var_212_11 and not isNil(var_212_9) then
				local var_212_12 = (arg_209_1.time_ - var_212_10) / var_212_11

				if arg_209_1.var_.characterEffect1085ui_story and not isNil(var_212_9) then
					arg_209_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= var_212_10 + var_212_11 and arg_209_1.time_ < var_212_10 + var_212_11 + arg_212_0 and not isNil(var_212_9) and arg_209_1.var_.characterEffect1085ui_story then
				arg_209_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_212_13 = arg_209_1.actors_["10066ui_story"]
			local var_212_14 = 0

			if var_212_14 < arg_209_1.time_ and arg_209_1.time_ <= var_212_14 + arg_212_0 and not isNil(var_212_13) and arg_209_1.var_.characterEffect10066ui_story == nil then
				arg_209_1.var_.characterEffect10066ui_story = var_212_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_15 = 0.200000002980232

			if var_212_14 <= arg_209_1.time_ and arg_209_1.time_ < var_212_14 + var_212_15 and not isNil(var_212_13) then
				local var_212_16 = (arg_209_1.time_ - var_212_14) / var_212_15

				if arg_209_1.var_.characterEffect10066ui_story and not isNil(var_212_13) then
					local var_212_17 = Mathf.Lerp(0, 0.5, var_212_16)

					arg_209_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_209_1.var_.characterEffect10066ui_story.fillRatio = var_212_17
				end
			end

			if arg_209_1.time_ >= var_212_14 + var_212_15 and arg_209_1.time_ < var_212_14 + var_212_15 + arg_212_0 and not isNil(var_212_13) and arg_209_1.var_.characterEffect10066ui_story then
				local var_212_18 = 0.5

				arg_209_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_209_1.var_.characterEffect10066ui_story.fillRatio = var_212_18
			end

			local var_212_19 = 0

			if var_212_19 < arg_209_1.time_ and arg_209_1.time_ <= var_212_19 + arg_212_0 then
				arg_209_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_212_20 = 0

			if var_212_20 < arg_209_1.time_ and arg_209_1.time_ <= var_212_20 + arg_212_0 then
				arg_209_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_212_21 = arg_209_1.actors_["10066ui_story"].transform
			local var_212_22 = 0

			if var_212_22 < arg_209_1.time_ and arg_209_1.time_ <= var_212_22 + arg_212_0 then
				arg_209_1.var_.moveOldPos10066ui_story = var_212_21.localPosition
			end

			local var_212_23 = 0.001

			if var_212_22 <= arg_209_1.time_ and arg_209_1.time_ < var_212_22 + var_212_23 then
				local var_212_24 = (arg_209_1.time_ - var_212_22) / var_212_23
				local var_212_25 = Vector3.New(-0.7, -0.99, -5.83)

				var_212_21.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos10066ui_story, var_212_25, var_212_24)

				local var_212_26 = manager.ui.mainCamera.transform.position - var_212_21.position

				var_212_21.forward = Vector3.New(var_212_26.x, var_212_26.y, var_212_26.z)

				local var_212_27 = var_212_21.localEulerAngles

				var_212_27.z = 0
				var_212_27.x = 0
				var_212_21.localEulerAngles = var_212_27
			end

			if arg_209_1.time_ >= var_212_22 + var_212_23 and arg_209_1.time_ < var_212_22 + var_212_23 + arg_212_0 then
				var_212_21.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_212_28 = manager.ui.mainCamera.transform.position - var_212_21.position

				var_212_21.forward = Vector3.New(var_212_28.x, var_212_28.y, var_212_28.z)

				local var_212_29 = var_212_21.localEulerAngles

				var_212_29.z = 0
				var_212_29.x = 0
				var_212_21.localEulerAngles = var_212_29
			end

			local var_212_30 = 0
			local var_212_31 = 0.175

			if var_212_30 < arg_209_1.time_ and arg_209_1.time_ <= var_212_30 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				local var_212_32 = arg_209_1:FormatText(StoryNameCfg[328].name)

				arg_209_1.leftNameTxt_.text = var_212_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_33 = arg_209_1:GetWordFromCfg(1108503050)
				local var_212_34 = arg_209_1:FormatText(var_212_33.content)

				arg_209_1.text_.text = var_212_34

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_35 = 7
				local var_212_36 = utf8.len(var_212_34)
				local var_212_37 = var_212_35 <= 0 and var_212_31 or var_212_31 * (var_212_36 / var_212_35)

				if var_212_37 > 0 and var_212_31 < var_212_37 then
					arg_209_1.talkMaxDuration = var_212_37

					if var_212_37 + var_212_30 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_37 + var_212_30
					end
				end

				arg_209_1.text_.text = var_212_34
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503050", "story_v_side_new_1108503.awb") ~= 0 then
					local var_212_38 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503050", "story_v_side_new_1108503.awb") / 1000

					if var_212_38 + var_212_30 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_38 + var_212_30
					end

					if var_212_33.prefab_name ~= "" and arg_209_1.actors_[var_212_33.prefab_name] ~= nil then
						local var_212_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_33.prefab_name].transform, "story_v_side_new_1108503", "1108503050", "story_v_side_new_1108503.awb")

						arg_209_1:RecordAudio("1108503050", var_212_39)
						arg_209_1:RecordAudio("1108503050", var_212_39)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503050", "story_v_side_new_1108503.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503050", "story_v_side_new_1108503.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_40 = math.max(var_212_31, arg_209_1.talkMaxDuration)

			if var_212_30 <= arg_209_1.time_ and arg_209_1.time_ < var_212_30 + var_212_40 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_30) / var_212_40

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_30 + var_212_40 and arg_209_1.time_ < var_212_30 + var_212_40 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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

		arg_209_1:InitPlayNodeList()
	end,
	Play1108503051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 1108503051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play1108503052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_0 = arg_213_1.actors_["10066ui_story"].transform
			local var_216_1 = 0

			if var_216_1 < arg_213_1.time_ and arg_213_1.time_ <= var_216_1 + arg_216_0 then
				arg_213_1.var_.moveOldPos10066ui_story = var_216_0.localPosition
			end

			local var_216_2 = 0.001

			if var_216_1 <= arg_213_1.time_ and arg_213_1.time_ < var_216_1 + var_216_2 then
				local var_216_3 = (arg_213_1.time_ - var_216_1) / var_216_2
				local var_216_4 = Vector3.New(0, 100, 0)

				var_216_0.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos10066ui_story, var_216_4, var_216_3)

				local var_216_5 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_5.x, var_216_5.y, var_216_5.z)

				local var_216_6 = var_216_0.localEulerAngles

				var_216_6.z = 0
				var_216_6.x = 0
				var_216_0.localEulerAngles = var_216_6
			end

			if arg_213_1.time_ >= var_216_1 + var_216_2 and arg_213_1.time_ < var_216_1 + var_216_2 + arg_216_0 then
				var_216_0.localPosition = Vector3.New(0, 100, 0)

				local var_216_7 = manager.ui.mainCamera.transform.position - var_216_0.position

				var_216_0.forward = Vector3.New(var_216_7.x, var_216_7.y, var_216_7.z)

				local var_216_8 = var_216_0.localEulerAngles

				var_216_8.z = 0
				var_216_8.x = 0
				var_216_0.localEulerAngles = var_216_8
			end

			local var_216_9 = arg_213_1.actors_["1085ui_story"].transform
			local var_216_10 = 0

			if var_216_10 < arg_213_1.time_ and arg_213_1.time_ <= var_216_10 + arg_216_0 then
				arg_213_1.var_.moveOldPos1085ui_story = var_216_9.localPosition
			end

			local var_216_11 = 0.001

			if var_216_10 <= arg_213_1.time_ and arg_213_1.time_ < var_216_10 + var_216_11 then
				local var_216_12 = (arg_213_1.time_ - var_216_10) / var_216_11
				local var_216_13 = Vector3.New(0, 100, 0)

				var_216_9.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1085ui_story, var_216_13, var_216_12)

				local var_216_14 = manager.ui.mainCamera.transform.position - var_216_9.position

				var_216_9.forward = Vector3.New(var_216_14.x, var_216_14.y, var_216_14.z)

				local var_216_15 = var_216_9.localEulerAngles

				var_216_15.z = 0
				var_216_15.x = 0
				var_216_9.localEulerAngles = var_216_15
			end

			if arg_213_1.time_ >= var_216_10 + var_216_11 and arg_213_1.time_ < var_216_10 + var_216_11 + arg_216_0 then
				var_216_9.localPosition = Vector3.New(0, 100, 0)

				local var_216_16 = manager.ui.mainCamera.transform.position - var_216_9.position

				var_216_9.forward = Vector3.New(var_216_16.x, var_216_16.y, var_216_16.z)

				local var_216_17 = var_216_9.localEulerAngles

				var_216_17.z = 0
				var_216_17.x = 0
				var_216_9.localEulerAngles = var_216_17
			end

			local var_216_18 = arg_213_1.actors_["1085ui_story"]
			local var_216_19 = 0

			if var_216_19 < arg_213_1.time_ and arg_213_1.time_ <= var_216_19 + arg_216_0 and not isNil(var_216_18) and arg_213_1.var_.characterEffect1085ui_story == nil then
				arg_213_1.var_.characterEffect1085ui_story = var_216_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_20 = 0.200000002980232

			if var_216_19 <= arg_213_1.time_ and arg_213_1.time_ < var_216_19 + var_216_20 and not isNil(var_216_18) then
				local var_216_21 = (arg_213_1.time_ - var_216_19) / var_216_20

				if arg_213_1.var_.characterEffect1085ui_story and not isNil(var_216_18) then
					local var_216_22 = Mathf.Lerp(0, 0.5, var_216_21)

					arg_213_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1085ui_story.fillRatio = var_216_22
				end
			end

			if arg_213_1.time_ >= var_216_19 + var_216_20 and arg_213_1.time_ < var_216_19 + var_216_20 + arg_216_0 and not isNil(var_216_18) and arg_213_1.var_.characterEffect1085ui_story then
				local var_216_23 = 0.5

				arg_213_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1085ui_story.fillRatio = var_216_23
			end

			local var_216_24 = 0
			local var_216_25 = 1.275

			if var_216_24 < arg_213_1.time_ and arg_213_1.time_ <= var_216_24 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_26 = arg_213_1:GetWordFromCfg(1108503051)
				local var_216_27 = arg_213_1:FormatText(var_216_26.content)

				arg_213_1.text_.text = var_216_27

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_28 = 51
				local var_216_29 = utf8.len(var_216_27)
				local var_216_30 = var_216_28 <= 0 and var_216_25 or var_216_25 * (var_216_29 / var_216_28)

				if var_216_30 > 0 and var_216_25 < var_216_30 then
					arg_213_1.talkMaxDuration = var_216_30

					if var_216_30 + var_216_24 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_30 + var_216_24
					end
				end

				arg_213_1.text_.text = var_216_27
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_31 = math.max(var_216_25, arg_213_1.talkMaxDuration)

			if var_216_24 <= arg_213_1.time_ and arg_213_1.time_ < var_216_24 + var_216_31 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_24) / var_216_31

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_24 + var_216_31 and arg_213_1.time_ < var_216_24 + var_216_31 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_213_1:InitPlayNodeList()
	end,
	Play1108503052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 1108503052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play1108503053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0
			local var_220_1 = 0.25

			if var_220_0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_2 = arg_217_1:FormatText(StoryNameCfg[7].name)

				arg_217_1.leftNameTxt_.text = var_220_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(1108503052)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_5 = 10
				local var_220_6 = utf8.len(var_220_4)
				local var_220_7 = var_220_5 <= 0 and var_220_1 or var_220_1 * (var_220_6 / var_220_5)

				if var_220_7 > 0 and var_220_1 < var_220_7 then
					arg_217_1.talkMaxDuration = var_220_7

					if var_220_7 + var_220_0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_0
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_8 = math.max(var_220_1, arg_217_1.talkMaxDuration)

			if var_220_0 <= arg_217_1.time_ and arg_217_1.time_ < var_220_0 + var_220_8 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_0) / var_220_8

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_0 + var_220_8 and arg_217_1.time_ < var_220_0 + var_220_8 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play1108503053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 1108503053
		arg_221_1.duration_ = 5.5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play1108503054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["10066ui_story"].transform
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.var_.moveOldPos10066ui_story = var_224_0.localPosition
			end

			local var_224_2 = 0.001

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2
				local var_224_4 = Vector3.New(0, -0.99, -5.83)

				var_224_0.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos10066ui_story, var_224_4, var_224_3)

				local var_224_5 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_5.x, var_224_5.y, var_224_5.z)

				local var_224_6 = var_224_0.localEulerAngles

				var_224_6.z = 0
				var_224_6.x = 0
				var_224_0.localEulerAngles = var_224_6
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 then
				var_224_0.localPosition = Vector3.New(0, -0.99, -5.83)

				local var_224_7 = manager.ui.mainCamera.transform.position - var_224_0.position

				var_224_0.forward = Vector3.New(var_224_7.x, var_224_7.y, var_224_7.z)

				local var_224_8 = var_224_0.localEulerAngles

				var_224_8.z = 0
				var_224_8.x = 0
				var_224_0.localEulerAngles = var_224_8
			end

			local var_224_9 = arg_221_1.actors_["10066ui_story"]
			local var_224_10 = 0

			if var_224_10 < arg_221_1.time_ and arg_221_1.time_ <= var_224_10 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect10066ui_story == nil then
				arg_221_1.var_.characterEffect10066ui_story = var_224_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_11 = 0.200000002980232

			if var_224_10 <= arg_221_1.time_ and arg_221_1.time_ < var_224_10 + var_224_11 and not isNil(var_224_9) then
				local var_224_12 = (arg_221_1.time_ - var_224_10) / var_224_11

				if arg_221_1.var_.characterEffect10066ui_story and not isNil(var_224_9) then
					arg_221_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_10 + var_224_11 and arg_221_1.time_ < var_224_10 + var_224_11 + arg_224_0 and not isNil(var_224_9) and arg_221_1.var_.characterEffect10066ui_story then
				arg_221_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_224_13 = 0

			if var_224_13 < arg_221_1.time_ and arg_221_1.time_ <= var_224_13 + arg_224_0 then
				arg_221_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action2_1")
			end

			local var_224_14 = 0

			if var_224_14 < arg_221_1.time_ and arg_221_1.time_ <= var_224_14 + arg_224_0 then
				arg_221_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_224_15 = 0
			local var_224_16 = 0.675

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_17 = arg_221_1:FormatText(StoryNameCfg[640].name)

				arg_221_1.leftNameTxt_.text = var_224_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_18 = arg_221_1:GetWordFromCfg(1108503053)
				local var_224_19 = arg_221_1:FormatText(var_224_18.content)

				arg_221_1.text_.text = var_224_19

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_20 = 27
				local var_224_21 = utf8.len(var_224_19)
				local var_224_22 = var_224_20 <= 0 and var_224_16 or var_224_16 * (var_224_21 / var_224_20)

				if var_224_22 > 0 and var_224_16 < var_224_22 then
					arg_221_1.talkMaxDuration = var_224_22

					if var_224_22 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_22 + var_224_15
					end
				end

				arg_221_1.text_.text = var_224_19
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503053", "story_v_side_new_1108503.awb") ~= 0 then
					local var_224_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503053", "story_v_side_new_1108503.awb") / 1000

					if var_224_23 + var_224_15 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_23 + var_224_15
					end

					if var_224_18.prefab_name ~= "" and arg_221_1.actors_[var_224_18.prefab_name] ~= nil then
						local var_224_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_18.prefab_name].transform, "story_v_side_new_1108503", "1108503053", "story_v_side_new_1108503.awb")

						arg_221_1:RecordAudio("1108503053", var_224_24)
						arg_221_1:RecordAudio("1108503053", var_224_24)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503053", "story_v_side_new_1108503.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503053", "story_v_side_new_1108503.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_25 = math.max(var_224_16, arg_221_1.talkMaxDuration)

			if var_224_15 <= arg_221_1.time_ and arg_221_1.time_ < var_224_15 + var_224_25 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_15) / var_224_25

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_15 + var_224_25 and arg_221_1.time_ < var_224_15 + var_224_25 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
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

		arg_221_1:InitPlayNodeList()
	end,
	Play1108503054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 1108503054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play1108503055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["10066ui_story"]
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect10066ui_story == nil then
				arg_225_1.var_.characterEffect10066ui_story = var_228_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_2 and not isNil(var_228_0) then
				local var_228_3 = (arg_225_1.time_ - var_228_1) / var_228_2

				if arg_225_1.var_.characterEffect10066ui_story and not isNil(var_228_0) then
					local var_228_4 = Mathf.Lerp(0, 0.5, var_228_3)

					arg_225_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_225_1.var_.characterEffect10066ui_story.fillRatio = var_228_4
				end
			end

			if arg_225_1.time_ >= var_228_1 + var_228_2 and arg_225_1.time_ < var_228_1 + var_228_2 + arg_228_0 and not isNil(var_228_0) and arg_225_1.var_.characterEffect10066ui_story then
				local var_228_5 = 0.5

				arg_225_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_225_1.var_.characterEffect10066ui_story.fillRatio = var_228_5
			end

			local var_228_6 = 0
			local var_228_7 = 0.15

			if var_228_6 < arg_225_1.time_ and arg_225_1.time_ <= var_228_6 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				local var_228_8 = arg_225_1:FormatText(StoryNameCfg[7].name)

				arg_225_1.leftNameTxt_.text = var_228_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, true)
				arg_225_1.iconController_:SetSelectedState("hero")

				arg_225_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_225_1.callingController_:SetSelectedState("normal")

				arg_225_1.keyicon_.color = Color.New(1, 1, 1)
				arg_225_1.icon_.color = Color.New(1, 1, 1)

				local var_228_9 = arg_225_1:GetWordFromCfg(1108503054)
				local var_228_10 = arg_225_1:FormatText(var_228_9.content)

				arg_225_1.text_.text = var_228_10

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_11 = 6
				local var_228_12 = utf8.len(var_228_10)
				local var_228_13 = var_228_11 <= 0 and var_228_7 or var_228_7 * (var_228_12 / var_228_11)

				if var_228_13 > 0 and var_228_7 < var_228_13 then
					arg_225_1.talkMaxDuration = var_228_13

					if var_228_13 + var_228_6 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_13 + var_228_6
					end
				end

				arg_225_1.text_.text = var_228_10
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_14 = math.max(var_228_7, arg_225_1.talkMaxDuration)

			if var_228_6 <= arg_225_1.time_ and arg_225_1.time_ < var_228_6 + var_228_14 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_6) / var_228_14

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_6 + var_228_14 and arg_225_1.time_ < var_228_6 + var_228_14 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play1108503055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 1108503055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play1108503056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 0
			local var_232_1 = 0.6

			if var_232_0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				local var_232_2 = arg_229_1:FormatText(StoryNameCfg[7].name)

				arg_229_1.leftNameTxt_.text = var_232_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, true)
				arg_229_1.iconController_:SetSelectedState("hero")

				arg_229_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_229_1.callingController_:SetSelectedState("normal")

				arg_229_1.keyicon_.color = Color.New(1, 1, 1)
				arg_229_1.icon_.color = Color.New(1, 1, 1)

				local var_232_3 = arg_229_1:GetWordFromCfg(1108503055)
				local var_232_4 = arg_229_1:FormatText(var_232_3.content)

				arg_229_1.text_.text = var_232_4

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_5 = 24
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
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_8 = math.max(var_232_1, arg_229_1.talkMaxDuration)

			if var_232_0 <= arg_229_1.time_ and arg_229_1.time_ < var_232_0 + var_232_8 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_0) / var_232_8

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_0 + var_232_8 and arg_229_1.time_ < var_232_0 + var_232_8 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play1108503056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 1108503056
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play1108503057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0

			if var_236_0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_0 + arg_236_0 then
				arg_233_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action2_2")
			end

			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_236_2 = 0
			local var_236_3 = 0.6

			if var_236_2 < arg_233_1.time_ and arg_233_1.time_ <= var_236_2 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, false)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_4 = arg_233_1:GetWordFromCfg(1108503056)
				local var_236_5 = arg_233_1:FormatText(var_236_4.content)

				arg_233_1.text_.text = var_236_5

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_6 = 24
				local var_236_7 = utf8.len(var_236_5)
				local var_236_8 = var_236_6 <= 0 and var_236_3 or var_236_3 * (var_236_7 / var_236_6)

				if var_236_8 > 0 and var_236_3 < var_236_8 then
					arg_233_1.talkMaxDuration = var_236_8

					if var_236_8 + var_236_2 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_2
					end
				end

				arg_233_1.text_.text = var_236_5
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_9 = math.max(var_236_3, arg_233_1.talkMaxDuration)

			if var_236_2 <= arg_233_1.time_ and arg_233_1.time_ < var_236_2 + var_236_9 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_2) / var_236_9

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_2 + var_236_9 and arg_233_1.time_ < var_236_2 + var_236_9 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play1108503057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 1108503057
		arg_237_1.duration_ = 8.97

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play1108503058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			local var_240_0 = arg_237_1.actors_["10066ui_story"].transform
			local var_240_1 = 0

			if var_240_1 < arg_237_1.time_ and arg_237_1.time_ <= var_240_1 + arg_240_0 then
				arg_237_1.var_.moveOldPos10066ui_story = var_240_0.localPosition
			end

			local var_240_2 = 0.001

			if var_240_1 <= arg_237_1.time_ and arg_237_1.time_ < var_240_1 + var_240_2 then
				local var_240_3 = (arg_237_1.time_ - var_240_1) / var_240_2
				local var_240_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_240_0.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10066ui_story, var_240_4, var_240_3)

				local var_240_5 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_5.x, var_240_5.y, var_240_5.z)

				local var_240_6 = var_240_0.localEulerAngles

				var_240_6.z = 0
				var_240_6.x = 0
				var_240_0.localEulerAngles = var_240_6
			end

			if arg_237_1.time_ >= var_240_1 + var_240_2 and arg_237_1.time_ < var_240_1 + var_240_2 + arg_240_0 then
				var_240_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_240_7 = manager.ui.mainCamera.transform.position - var_240_0.position

				var_240_0.forward = Vector3.New(var_240_7.x, var_240_7.y, var_240_7.z)

				local var_240_8 = var_240_0.localEulerAngles

				var_240_8.z = 0
				var_240_8.x = 0
				var_240_0.localEulerAngles = var_240_8
			end

			local var_240_9 = arg_237_1.actors_["10066ui_story"]
			local var_240_10 = 0

			if var_240_10 < arg_237_1.time_ and arg_237_1.time_ <= var_240_10 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect10066ui_story == nil then
				arg_237_1.var_.characterEffect10066ui_story = var_240_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_11 = 0.200000002980232

			if var_240_10 <= arg_237_1.time_ and arg_237_1.time_ < var_240_10 + var_240_11 and not isNil(var_240_9) then
				local var_240_12 = (arg_237_1.time_ - var_240_10) / var_240_11

				if arg_237_1.var_.characterEffect10066ui_story and not isNil(var_240_9) then
					arg_237_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= var_240_10 + var_240_11 and arg_237_1.time_ < var_240_10 + var_240_11 + arg_240_0 and not isNil(var_240_9) and arg_237_1.var_.characterEffect10066ui_story then
				arg_237_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_240_13 = 0

			if var_240_13 < arg_237_1.time_ and arg_237_1.time_ <= var_240_13 + arg_240_0 then
				arg_237_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			local var_240_14 = 0

			if var_240_14 < arg_237_1.time_ and arg_237_1.time_ <= var_240_14 + arg_240_0 then
				arg_237_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_240_15 = 0
			local var_240_16 = 1.075

			if var_240_15 < arg_237_1.time_ and arg_237_1.time_ <= var_240_15 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				local var_240_17 = arg_237_1:FormatText(StoryNameCfg[640].name)

				arg_237_1.leftNameTxt_.text = var_240_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_18 = arg_237_1:GetWordFromCfg(1108503057)
				local var_240_19 = arg_237_1:FormatText(var_240_18.content)

				arg_237_1.text_.text = var_240_19

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_20 = 43
				local var_240_21 = utf8.len(var_240_19)
				local var_240_22 = var_240_20 <= 0 and var_240_16 or var_240_16 * (var_240_21 / var_240_20)

				if var_240_22 > 0 and var_240_16 < var_240_22 then
					arg_237_1.talkMaxDuration = var_240_22

					if var_240_22 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_22 + var_240_15
					end
				end

				arg_237_1.text_.text = var_240_19
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503057", "story_v_side_new_1108503.awb") ~= 0 then
					local var_240_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503057", "story_v_side_new_1108503.awb") / 1000

					if var_240_23 + var_240_15 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_23 + var_240_15
					end

					if var_240_18.prefab_name ~= "" and arg_237_1.actors_[var_240_18.prefab_name] ~= nil then
						local var_240_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_18.prefab_name].transform, "story_v_side_new_1108503", "1108503057", "story_v_side_new_1108503.awb")

						arg_237_1:RecordAudio("1108503057", var_240_24)
						arg_237_1:RecordAudio("1108503057", var_240_24)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503057", "story_v_side_new_1108503.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503057", "story_v_side_new_1108503.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_25 = math.max(var_240_16, arg_237_1.talkMaxDuration)

			if var_240_15 <= arg_237_1.time_ and arg_237_1.time_ < var_240_15 + var_240_25 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_15) / var_240_25

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_15 + var_240_25 and arg_237_1.time_ < var_240_15 + var_240_25 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
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

		arg_237_1:InitPlayNodeList()
	end,
	Play1108503058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 1108503058
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play1108503059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			local var_244_0 = arg_241_1.actors_["10066ui_story"]
			local var_244_1 = 0

			if var_244_1 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect10066ui_story == nil then
				arg_241_1.var_.characterEffect10066ui_story = var_244_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_2 = 0.200000002980232

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_2 and not isNil(var_244_0) then
				local var_244_3 = (arg_241_1.time_ - var_244_1) / var_244_2

				if arg_241_1.var_.characterEffect10066ui_story and not isNil(var_244_0) then
					local var_244_4 = Mathf.Lerp(0, 0.5, var_244_3)

					arg_241_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_241_1.var_.characterEffect10066ui_story.fillRatio = var_244_4
				end
			end

			if arg_241_1.time_ >= var_244_1 + var_244_2 and arg_241_1.time_ < var_244_1 + var_244_2 + arg_244_0 and not isNil(var_244_0) and arg_241_1.var_.characterEffect10066ui_story then
				local var_244_5 = 0.5

				arg_241_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_241_1.var_.characterEffect10066ui_story.fillRatio = var_244_5
			end

			local var_244_6 = 0
			local var_244_7 = 0.675

			if var_244_6 < arg_241_1.time_ and arg_241_1.time_ <= var_244_6 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				local var_244_8 = arg_241_1:FormatText(StoryNameCfg[7].name)

				arg_241_1.leftNameTxt_.text = var_244_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, true)
				arg_241_1.iconController_:SetSelectedState("hero")

				arg_241_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_241_1.callingController_:SetSelectedState("normal")

				arg_241_1.keyicon_.color = Color.New(1, 1, 1)
				arg_241_1.icon_.color = Color.New(1, 1, 1)

				local var_244_9 = arg_241_1:GetWordFromCfg(1108503058)
				local var_244_10 = arg_241_1:FormatText(var_244_9.content)

				arg_241_1.text_.text = var_244_10

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_11 = 27
				local var_244_12 = utf8.len(var_244_10)
				local var_244_13 = var_244_11 <= 0 and var_244_7 or var_244_7 * (var_244_12 / var_244_11)

				if var_244_13 > 0 and var_244_7 < var_244_13 then
					arg_241_1.talkMaxDuration = var_244_13

					if var_244_13 + var_244_6 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_13 + var_244_6
					end
				end

				arg_241_1.text_.text = var_244_10
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_14 = math.max(var_244_7, arg_241_1.talkMaxDuration)

			if var_244_6 <= arg_241_1.time_ and arg_241_1.time_ < var_244_6 + var_244_14 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_6) / var_244_14

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_6 + var_244_14 and arg_241_1.time_ < var_244_6 + var_244_14 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play1108503059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 1108503059
		arg_245_1.duration_ = 2.07

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play1108503060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = arg_245_1.actors_["1085ui_story"].transform
			local var_248_1 = 0

			if var_248_1 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.var_.moveOldPos1085ui_story = var_248_0.localPosition
			end

			local var_248_2 = 0.001

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_2 then
				local var_248_3 = (arg_245_1.time_ - var_248_1) / var_248_2
				local var_248_4 = Vector3.New(0.75, -1.01, -5.83)

				var_248_0.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos1085ui_story, var_248_4, var_248_3)

				local var_248_5 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_5.x, var_248_5.y, var_248_5.z)

				local var_248_6 = var_248_0.localEulerAngles

				var_248_6.z = 0
				var_248_6.x = 0
				var_248_0.localEulerAngles = var_248_6
			end

			if arg_245_1.time_ >= var_248_1 + var_248_2 and arg_245_1.time_ < var_248_1 + var_248_2 + arg_248_0 then
				var_248_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_248_7 = manager.ui.mainCamera.transform.position - var_248_0.position

				var_248_0.forward = Vector3.New(var_248_7.x, var_248_7.y, var_248_7.z)

				local var_248_8 = var_248_0.localEulerAngles

				var_248_8.z = 0
				var_248_8.x = 0
				var_248_0.localEulerAngles = var_248_8
			end

			local var_248_9 = arg_245_1.actors_["10066ui_story"].transform
			local var_248_10 = 0

			if var_248_10 < arg_245_1.time_ and arg_245_1.time_ <= var_248_10 + arg_248_0 then
				arg_245_1.var_.moveOldPos10066ui_story = var_248_9.localPosition
			end

			local var_248_11 = 0.001

			if var_248_10 <= arg_245_1.time_ and arg_245_1.time_ < var_248_10 + var_248_11 then
				local var_248_12 = (arg_245_1.time_ - var_248_10) / var_248_11
				local var_248_13 = Vector3.New(-0.7, -0.99, -5.83)

				var_248_9.localPosition = Vector3.Lerp(arg_245_1.var_.moveOldPos10066ui_story, var_248_13, var_248_12)

				local var_248_14 = manager.ui.mainCamera.transform.position - var_248_9.position

				var_248_9.forward = Vector3.New(var_248_14.x, var_248_14.y, var_248_14.z)

				local var_248_15 = var_248_9.localEulerAngles

				var_248_15.z = 0
				var_248_15.x = 0
				var_248_9.localEulerAngles = var_248_15
			end

			if arg_245_1.time_ >= var_248_10 + var_248_11 and arg_245_1.time_ < var_248_10 + var_248_11 + arg_248_0 then
				var_248_9.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_248_16 = manager.ui.mainCamera.transform.position - var_248_9.position

				var_248_9.forward = Vector3.New(var_248_16.x, var_248_16.y, var_248_16.z)

				local var_248_17 = var_248_9.localEulerAngles

				var_248_17.z = 0
				var_248_17.x = 0
				var_248_9.localEulerAngles = var_248_17
			end

			local var_248_18 = arg_245_1.actors_["1085ui_story"]
			local var_248_19 = 0

			if var_248_19 < arg_245_1.time_ and arg_245_1.time_ <= var_248_19 + arg_248_0 and not isNil(var_248_18) and arg_245_1.var_.characterEffect1085ui_story == nil then
				arg_245_1.var_.characterEffect1085ui_story = var_248_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_20 = 0.200000002980232

			if var_248_19 <= arg_245_1.time_ and arg_245_1.time_ < var_248_19 + var_248_20 and not isNil(var_248_18) then
				local var_248_21 = (arg_245_1.time_ - var_248_19) / var_248_20

				if arg_245_1.var_.characterEffect1085ui_story and not isNil(var_248_18) then
					arg_245_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_245_1.time_ >= var_248_19 + var_248_20 and arg_245_1.time_ < var_248_19 + var_248_20 + arg_248_0 and not isNil(var_248_18) and arg_245_1.var_.characterEffect1085ui_story then
				arg_245_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_248_22 = 0

			if var_248_22 < arg_245_1.time_ and arg_245_1.time_ <= var_248_22 + arg_248_0 then
				arg_245_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_248_23 = 0

			if var_248_23 < arg_245_1.time_ and arg_245_1.time_ <= var_248_23 + arg_248_0 then
				arg_245_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_248_24 = 0
			local var_248_25 = 0.075

			if var_248_24 < arg_245_1.time_ and arg_245_1.time_ <= var_248_24 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				local var_248_26 = arg_245_1:FormatText(StoryNameCfg[328].name)

				arg_245_1.leftNameTxt_.text = var_248_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_27 = arg_245_1:GetWordFromCfg(1108503059)
				local var_248_28 = arg_245_1:FormatText(var_248_27.content)

				arg_245_1.text_.text = var_248_28

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_29 = 3
				local var_248_30 = utf8.len(var_248_28)
				local var_248_31 = var_248_29 <= 0 and var_248_25 or var_248_25 * (var_248_30 / var_248_29)

				if var_248_31 > 0 and var_248_25 < var_248_31 then
					arg_245_1.talkMaxDuration = var_248_31

					if var_248_31 + var_248_24 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_31 + var_248_24
					end
				end

				arg_245_1.text_.text = var_248_28
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503059", "story_v_side_new_1108503.awb") ~= 0 then
					local var_248_32 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503059", "story_v_side_new_1108503.awb") / 1000

					if var_248_32 + var_248_24 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_32 + var_248_24
					end

					if var_248_27.prefab_name ~= "" and arg_245_1.actors_[var_248_27.prefab_name] ~= nil then
						local var_248_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_27.prefab_name].transform, "story_v_side_new_1108503", "1108503059", "story_v_side_new_1108503.awb")

						arg_245_1:RecordAudio("1108503059", var_248_33)
						arg_245_1:RecordAudio("1108503059", var_248_33)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503059", "story_v_side_new_1108503.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503059", "story_v_side_new_1108503.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_34 = math.max(var_248_25, arg_245_1.talkMaxDuration)

			if var_248_24 <= arg_245_1.time_ and arg_245_1.time_ < var_248_24 + var_248_34 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_24) / var_248_34

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_24 + var_248_34 and arg_245_1.time_ < var_248_24 + var_248_34 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
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

		arg_245_1:InitPlayNodeList()
	end,
	Play1108503060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 1108503060
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play1108503061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = arg_249_1.actors_["1085ui_story"]
			local var_252_1 = 0

			if var_252_1 < arg_249_1.time_ and arg_249_1.time_ <= var_252_1 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1085ui_story == nil then
				arg_249_1.var_.characterEffect1085ui_story = var_252_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if var_252_1 <= arg_249_1.time_ and arg_249_1.time_ < var_252_1 + var_252_2 and not isNil(var_252_0) then
				local var_252_3 = (arg_249_1.time_ - var_252_1) / var_252_2

				if arg_249_1.var_.characterEffect1085ui_story and not isNil(var_252_0) then
					local var_252_4 = Mathf.Lerp(0, 0.5, var_252_3)

					arg_249_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_249_1.var_.characterEffect1085ui_story.fillRatio = var_252_4
				end
			end

			if arg_249_1.time_ >= var_252_1 + var_252_2 and arg_249_1.time_ < var_252_1 + var_252_2 + arg_252_0 and not isNil(var_252_0) and arg_249_1.var_.characterEffect1085ui_story then
				local var_252_5 = 0.5

				arg_249_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_249_1.var_.characterEffect1085ui_story.fillRatio = var_252_5
			end

			local var_252_6 = 0
			local var_252_7 = 0.775

			if var_252_6 < arg_249_1.time_ and arg_249_1.time_ <= var_252_6 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				local var_252_8 = arg_249_1:FormatText(StoryNameCfg[7].name)

				arg_249_1.leftNameTxt_.text = var_252_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, true)
				arg_249_1.iconController_:SetSelectedState("hero")

				arg_249_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_249_1.callingController_:SetSelectedState("normal")

				arg_249_1.keyicon_.color = Color.New(1, 1, 1)
				arg_249_1.icon_.color = Color.New(1, 1, 1)

				local var_252_9 = arg_249_1:GetWordFromCfg(1108503060)
				local var_252_10 = arg_249_1:FormatText(var_252_9.content)

				arg_249_1.text_.text = var_252_10

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_11 = 31
				local var_252_12 = utf8.len(var_252_10)
				local var_252_13 = var_252_11 <= 0 and var_252_7 or var_252_7 * (var_252_12 / var_252_11)

				if var_252_13 > 0 and var_252_7 < var_252_13 then
					arg_249_1.talkMaxDuration = var_252_13

					if var_252_13 + var_252_6 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_13 + var_252_6
					end
				end

				arg_249_1.text_.text = var_252_10
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_14 = math.max(var_252_7, arg_249_1.talkMaxDuration)

			if var_252_6 <= arg_249_1.time_ and arg_249_1.time_ < var_252_6 + var_252_14 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_6) / var_252_14

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_6 + var_252_14 and arg_249_1.time_ < var_252_6 + var_252_14 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play1108503061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 1108503061
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play1108503062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 0
			local var_256_1 = 1.15

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

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_3 = arg_253_1:GetWordFromCfg(1108503061)
				local var_256_4 = arg_253_1:FormatText(var_256_3.content)

				arg_253_1.text_.text = var_256_4

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_5 = 46
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
	Play1108503062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 1108503062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play1108503063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 0
			local var_260_1 = 1.125

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

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:GetWordFromCfg(1108503062)
				local var_260_4 = arg_257_1:FormatText(var_260_3.content)

				arg_257_1.text_.text = var_260_4

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 45
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
	Play1108503063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 1108503063
		arg_261_1.duration_ = 5.2

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play1108503064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = arg_261_1.actors_["1085ui_story"].transform
			local var_264_1 = 0

			if var_264_1 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.var_.moveOldPos1085ui_story = var_264_0.localPosition
			end

			local var_264_2 = 0.001

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_2 then
				local var_264_3 = (arg_261_1.time_ - var_264_1) / var_264_2
				local var_264_4 = Vector3.New(0.75, -1.01, -5.83)

				var_264_0.localPosition = Vector3.Lerp(arg_261_1.var_.moveOldPos1085ui_story, var_264_4, var_264_3)

				local var_264_5 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_5.x, var_264_5.y, var_264_5.z)

				local var_264_6 = var_264_0.localEulerAngles

				var_264_6.z = 0
				var_264_6.x = 0
				var_264_0.localEulerAngles = var_264_6
			end

			if arg_261_1.time_ >= var_264_1 + var_264_2 and arg_261_1.time_ < var_264_1 + var_264_2 + arg_264_0 then
				var_264_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_264_7 = manager.ui.mainCamera.transform.position - var_264_0.position

				var_264_0.forward = Vector3.New(var_264_7.x, var_264_7.y, var_264_7.z)

				local var_264_8 = var_264_0.localEulerAngles

				var_264_8.z = 0
				var_264_8.x = 0
				var_264_0.localEulerAngles = var_264_8
			end

			local var_264_9 = arg_261_1.actors_["1085ui_story"]
			local var_264_10 = 0

			if var_264_10 < arg_261_1.time_ and arg_261_1.time_ <= var_264_10 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1085ui_story == nil then
				arg_261_1.var_.characterEffect1085ui_story = var_264_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_11 = 0.200000002980232

			if var_264_10 <= arg_261_1.time_ and arg_261_1.time_ < var_264_10 + var_264_11 and not isNil(var_264_9) then
				local var_264_12 = (arg_261_1.time_ - var_264_10) / var_264_11

				if arg_261_1.var_.characterEffect1085ui_story and not isNil(var_264_9) then
					arg_261_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_261_1.time_ >= var_264_10 + var_264_11 and arg_261_1.time_ < var_264_10 + var_264_11 + arg_264_0 and not isNil(var_264_9) and arg_261_1.var_.characterEffect1085ui_story then
				arg_261_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_264_13 = 0

			if var_264_13 < arg_261_1.time_ and arg_261_1.time_ <= var_264_13 + arg_264_0 then
				arg_261_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_264_14 = 0.034000001847744

			if var_264_14 < arg_261_1.time_ and arg_261_1.time_ <= var_264_14 + arg_264_0 then
				arg_261_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_264_15 = 0
			local var_264_16 = 0.55

			if var_264_15 < arg_261_1.time_ and arg_261_1.time_ <= var_264_15 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				local var_264_17 = arg_261_1:FormatText(StoryNameCfg[328].name)

				arg_261_1.leftNameTxt_.text = var_264_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_18 = arg_261_1:GetWordFromCfg(1108503063)
				local var_264_19 = arg_261_1:FormatText(var_264_18.content)

				arg_261_1.text_.text = var_264_19

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_20 = 22
				local var_264_21 = utf8.len(var_264_19)
				local var_264_22 = var_264_20 <= 0 and var_264_16 or var_264_16 * (var_264_21 / var_264_20)

				if var_264_22 > 0 and var_264_16 < var_264_22 then
					arg_261_1.talkMaxDuration = var_264_22

					if var_264_22 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_22 + var_264_15
					end
				end

				arg_261_1.text_.text = var_264_19
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503063", "story_v_side_new_1108503.awb") ~= 0 then
					local var_264_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503063", "story_v_side_new_1108503.awb") / 1000

					if var_264_23 + var_264_15 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_23 + var_264_15
					end

					if var_264_18.prefab_name ~= "" and arg_261_1.actors_[var_264_18.prefab_name] ~= nil then
						local var_264_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_18.prefab_name].transform, "story_v_side_new_1108503", "1108503063", "story_v_side_new_1108503.awb")

						arg_261_1:RecordAudio("1108503063", var_264_24)
						arg_261_1:RecordAudio("1108503063", var_264_24)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503063", "story_v_side_new_1108503.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503063", "story_v_side_new_1108503.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_25 = math.max(var_264_16, arg_261_1.talkMaxDuration)

			if var_264_15 <= arg_261_1.time_ and arg_261_1.time_ < var_264_15 + var_264_25 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_15) / var_264_25

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_15 + var_264_25 and arg_261_1.time_ < var_264_15 + var_264_25 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {
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

		arg_261_1:InitPlayNodeList()
	end,
	Play1108503064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 1108503064
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play1108503065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = arg_265_1.actors_["1085ui_story"]
			local var_268_1 = 0

			if var_268_1 < arg_265_1.time_ and arg_265_1.time_ <= var_268_1 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1085ui_story == nil then
				arg_265_1.var_.characterEffect1085ui_story = var_268_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if var_268_1 <= arg_265_1.time_ and arg_265_1.time_ < var_268_1 + var_268_2 and not isNil(var_268_0) then
				local var_268_3 = (arg_265_1.time_ - var_268_1) / var_268_2

				if arg_265_1.var_.characterEffect1085ui_story and not isNil(var_268_0) then
					local var_268_4 = Mathf.Lerp(0, 0.5, var_268_3)

					arg_265_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_265_1.var_.characterEffect1085ui_story.fillRatio = var_268_4
				end
			end

			if arg_265_1.time_ >= var_268_1 + var_268_2 and arg_265_1.time_ < var_268_1 + var_268_2 + arg_268_0 and not isNil(var_268_0) and arg_265_1.var_.characterEffect1085ui_story then
				local var_268_5 = 0.5

				arg_265_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_265_1.var_.characterEffect1085ui_story.fillRatio = var_268_5
			end

			local var_268_6 = 0
			local var_268_7 = 0.55

			if var_268_6 < arg_265_1.time_ and arg_265_1.time_ <= var_268_6 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				local var_268_8 = arg_265_1:FormatText(StoryNameCfg[7].name)

				arg_265_1.leftNameTxt_.text = var_268_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_9 = arg_265_1:GetWordFromCfg(1108503064)
				local var_268_10 = arg_265_1:FormatText(var_268_9.content)

				arg_265_1.text_.text = var_268_10

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_11 = 22
				local var_268_12 = utf8.len(var_268_10)
				local var_268_13 = var_268_11 <= 0 and var_268_7 or var_268_7 * (var_268_12 / var_268_11)

				if var_268_13 > 0 and var_268_7 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13

					if var_268_13 + var_268_6 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_6
					end
				end

				arg_265_1.text_.text = var_268_10
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_14 = math.max(var_268_7, arg_265_1.talkMaxDuration)

			if var_268_6 <= arg_265_1.time_ and arg_265_1.time_ < var_268_6 + var_268_14 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_6) / var_268_14

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_6 + var_268_14 and arg_265_1.time_ < var_268_6 + var_268_14 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play1108503065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 1108503065
		arg_269_1.duration_ = 4.67

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play1108503066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = arg_269_1.actors_["1085ui_story"].transform
			local var_272_1 = 0

			if var_272_1 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.var_.moveOldPos1085ui_story = var_272_0.localPosition
			end

			local var_272_2 = 0.001

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_2 then
				local var_272_3 = (arg_269_1.time_ - var_272_1) / var_272_2
				local var_272_4 = Vector3.New(0.75, -1.01, -5.83)

				var_272_0.localPosition = Vector3.Lerp(arg_269_1.var_.moveOldPos1085ui_story, var_272_4, var_272_3)

				local var_272_5 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_5.x, var_272_5.y, var_272_5.z)

				local var_272_6 = var_272_0.localEulerAngles

				var_272_6.z = 0
				var_272_6.x = 0
				var_272_0.localEulerAngles = var_272_6
			end

			if arg_269_1.time_ >= var_272_1 + var_272_2 and arg_269_1.time_ < var_272_1 + var_272_2 + arg_272_0 then
				var_272_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_272_7 = manager.ui.mainCamera.transform.position - var_272_0.position

				var_272_0.forward = Vector3.New(var_272_7.x, var_272_7.y, var_272_7.z)

				local var_272_8 = var_272_0.localEulerAngles

				var_272_8.z = 0
				var_272_8.x = 0
				var_272_0.localEulerAngles = var_272_8
			end

			local var_272_9 = arg_269_1.actors_["1085ui_story"]
			local var_272_10 = 0

			if var_272_10 < arg_269_1.time_ and arg_269_1.time_ <= var_272_10 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1085ui_story == nil then
				arg_269_1.var_.characterEffect1085ui_story = var_272_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_11 = 0.200000002980232

			if var_272_10 <= arg_269_1.time_ and arg_269_1.time_ < var_272_10 + var_272_11 and not isNil(var_272_9) then
				local var_272_12 = (arg_269_1.time_ - var_272_10) / var_272_11

				if arg_269_1.var_.characterEffect1085ui_story and not isNil(var_272_9) then
					arg_269_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_269_1.time_ >= var_272_10 + var_272_11 and arg_269_1.time_ < var_272_10 + var_272_11 + arg_272_0 and not isNil(var_272_9) and arg_269_1.var_.characterEffect1085ui_story then
				arg_269_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_272_13 = 0

			if var_272_13 < arg_269_1.time_ and arg_269_1.time_ <= var_272_13 + arg_272_0 then
				arg_269_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_272_14 = 0

			if var_272_14 < arg_269_1.time_ and arg_269_1.time_ <= var_272_14 + arg_272_0 then
				arg_269_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_272_15 = 0
			local var_272_16 = 0.375

			if var_272_15 < arg_269_1.time_ and arg_269_1.time_ <= var_272_15 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				local var_272_17 = arg_269_1:FormatText(StoryNameCfg[328].name)

				arg_269_1.leftNameTxt_.text = var_272_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_18 = arg_269_1:GetWordFromCfg(1108503065)
				local var_272_19 = arg_269_1:FormatText(var_272_18.content)

				arg_269_1.text_.text = var_272_19

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_20 = 15
				local var_272_21 = utf8.len(var_272_19)
				local var_272_22 = var_272_20 <= 0 and var_272_16 or var_272_16 * (var_272_21 / var_272_20)

				if var_272_22 > 0 and var_272_16 < var_272_22 then
					arg_269_1.talkMaxDuration = var_272_22

					if var_272_22 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_22 + var_272_15
					end
				end

				arg_269_1.text_.text = var_272_19
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503065", "story_v_side_new_1108503.awb") ~= 0 then
					local var_272_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503065", "story_v_side_new_1108503.awb") / 1000

					if var_272_23 + var_272_15 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_23 + var_272_15
					end

					if var_272_18.prefab_name ~= "" and arg_269_1.actors_[var_272_18.prefab_name] ~= nil then
						local var_272_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_18.prefab_name].transform, "story_v_side_new_1108503", "1108503065", "story_v_side_new_1108503.awb")

						arg_269_1:RecordAudio("1108503065", var_272_24)
						arg_269_1:RecordAudio("1108503065", var_272_24)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503065", "story_v_side_new_1108503.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503065", "story_v_side_new_1108503.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_25 = math.max(var_272_16, arg_269_1.talkMaxDuration)

			if var_272_15 <= arg_269_1.time_ and arg_269_1.time_ < var_272_15 + var_272_25 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_15) / var_272_25

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_15 + var_272_25 and arg_269_1.time_ < var_272_15 + var_272_25 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {
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

		arg_269_1:InitPlayNodeList()
	end,
	Play1108503066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 1108503066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play1108503067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = arg_273_1.actors_["1085ui_story"]
			local var_276_1 = 0

			if var_276_1 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1085ui_story == nil then
				arg_273_1.var_.characterEffect1085ui_story = var_276_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_2 and not isNil(var_276_0) then
				local var_276_3 = (arg_273_1.time_ - var_276_1) / var_276_2

				if arg_273_1.var_.characterEffect1085ui_story and not isNil(var_276_0) then
					local var_276_4 = Mathf.Lerp(0, 0.5, var_276_3)

					arg_273_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1085ui_story.fillRatio = var_276_4
				end
			end

			if arg_273_1.time_ >= var_276_1 + var_276_2 and arg_273_1.time_ < var_276_1 + var_276_2 + arg_276_0 and not isNil(var_276_0) and arg_273_1.var_.characterEffect1085ui_story then
				local var_276_5 = 0.5

				arg_273_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1085ui_story.fillRatio = var_276_5
			end

			local var_276_6 = 0
			local var_276_7 = 0.5

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

				local var_276_9 = arg_273_1:GetWordFromCfg(1108503066)
				local var_276_10 = arg_273_1:FormatText(var_276_9.content)

				arg_273_1.text_.text = var_276_10

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_11 = 20
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
	Play1108503067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 1108503067
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play1108503068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.475

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_2 = arg_277_1:GetWordFromCfg(1108503067)
				local var_280_3 = arg_277_1:FormatText(var_280_2.content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_4 = 19
				local var_280_5 = utf8.len(var_280_3)
				local var_280_6 = var_280_4 <= 0 and var_280_1 or var_280_1 * (var_280_5 / var_280_4)

				if var_280_6 > 0 and var_280_1 < var_280_6 then
					arg_277_1.talkMaxDuration = var_280_6

					if var_280_6 + var_280_0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_6 + var_280_0
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_7 = math.max(var_280_1, arg_277_1.talkMaxDuration)

			if var_280_0 <= arg_277_1.time_ and arg_277_1.time_ < var_280_0 + var_280_7 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_0) / var_280_7

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_0 + var_280_7 and arg_277_1.time_ < var_280_0 + var_280_7 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play1108503068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 1108503068
		arg_281_1.duration_ = 7.97

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play1108503069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["10066ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos10066ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(-0.7, -0.99, -5.83)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10066ui_story, var_284_4, var_284_3)

				local var_284_5 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_5.x, var_284_5.y, var_284_5.z)

				local var_284_6 = var_284_0.localEulerAngles

				var_284_6.z = 0
				var_284_6.x = 0
				var_284_0.localEulerAngles = var_284_6
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(-0.7, -0.99, -5.83)

				local var_284_7 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_7.x, var_284_7.y, var_284_7.z)

				local var_284_8 = var_284_0.localEulerAngles

				var_284_8.z = 0
				var_284_8.x = 0
				var_284_0.localEulerAngles = var_284_8
			end

			local var_284_9 = arg_281_1.actors_["10066ui_story"]
			local var_284_10 = 0

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect10066ui_story == nil then
				arg_281_1.var_.characterEffect10066ui_story = var_284_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_11 = 0.200000002980232

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_11 and not isNil(var_284_9) then
				local var_284_12 = (arg_281_1.time_ - var_284_10) / var_284_11

				if arg_281_1.var_.characterEffect10066ui_story and not isNil(var_284_9) then
					arg_281_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_10 + var_284_11 and arg_281_1.time_ < var_284_10 + var_284_11 + arg_284_0 and not isNil(var_284_9) and arg_281_1.var_.characterEffect10066ui_story then
				arg_281_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_284_13 = 0

			if var_284_13 < arg_281_1.time_ and arg_281_1.time_ <= var_284_13 + arg_284_0 then
				arg_281_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_2")
			end

			local var_284_14 = 0

			if var_284_14 < arg_281_1.time_ and arg_281_1.time_ <= var_284_14 + arg_284_0 then
				arg_281_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_284_15 = 0
			local var_284_16 = 0.925

			if var_284_15 < arg_281_1.time_ and arg_281_1.time_ <= var_284_15 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_17 = arg_281_1:FormatText(StoryNameCfg[640].name)

				arg_281_1.leftNameTxt_.text = var_284_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_18 = arg_281_1:GetWordFromCfg(1108503068)
				local var_284_19 = arg_281_1:FormatText(var_284_18.content)

				arg_281_1.text_.text = var_284_19

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_20 = 37
				local var_284_21 = utf8.len(var_284_19)
				local var_284_22 = var_284_20 <= 0 and var_284_16 or var_284_16 * (var_284_21 / var_284_20)

				if var_284_22 > 0 and var_284_16 < var_284_22 then
					arg_281_1.talkMaxDuration = var_284_22

					if var_284_22 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_22 + var_284_15
					end
				end

				arg_281_1.text_.text = var_284_19
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503068", "story_v_side_new_1108503.awb") ~= 0 then
					local var_284_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503068", "story_v_side_new_1108503.awb") / 1000

					if var_284_23 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_23 + var_284_15
					end

					if var_284_18.prefab_name ~= "" and arg_281_1.actors_[var_284_18.prefab_name] ~= nil then
						local var_284_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_18.prefab_name].transform, "story_v_side_new_1108503", "1108503068", "story_v_side_new_1108503.awb")

						arg_281_1:RecordAudio("1108503068", var_284_24)
						arg_281_1:RecordAudio("1108503068", var_284_24)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503068", "story_v_side_new_1108503.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503068", "story_v_side_new_1108503.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_25 = math.max(var_284_16, arg_281_1.talkMaxDuration)

			if var_284_15 <= arg_281_1.time_ and arg_281_1.time_ < var_284_15 + var_284_25 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_15) / var_284_25

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_15 + var_284_25 and arg_281_1.time_ < var_284_15 + var_284_25 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {
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

		arg_281_1:InitPlayNodeList()
	end,
	Play1108503069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 1108503069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play1108503070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10066ui_story"].transform
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 then
				arg_285_1.var_.moveOldPos10066ui_story = var_288_0.localPosition
			end

			local var_288_2 = 0.001

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2
				local var_288_4 = Vector3.New(0, 100, 0)

				var_288_0.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos10066ui_story, var_288_4, var_288_3)

				local var_288_5 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_5.x, var_288_5.y, var_288_5.z)

				local var_288_6 = var_288_0.localEulerAngles

				var_288_6.z = 0
				var_288_6.x = 0
				var_288_0.localEulerAngles = var_288_6
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 then
				var_288_0.localPosition = Vector3.New(0, 100, 0)

				local var_288_7 = manager.ui.mainCamera.transform.position - var_288_0.position

				var_288_0.forward = Vector3.New(var_288_7.x, var_288_7.y, var_288_7.z)

				local var_288_8 = var_288_0.localEulerAngles

				var_288_8.z = 0
				var_288_8.x = 0
				var_288_0.localEulerAngles = var_288_8
			end

			local var_288_9 = arg_285_1.actors_["1085ui_story"].transform
			local var_288_10 = 0

			if var_288_10 < arg_285_1.time_ and arg_285_1.time_ <= var_288_10 + arg_288_0 then
				arg_285_1.var_.moveOldPos1085ui_story = var_288_9.localPosition
			end

			local var_288_11 = 0.001

			if var_288_10 <= arg_285_1.time_ and arg_285_1.time_ < var_288_10 + var_288_11 then
				local var_288_12 = (arg_285_1.time_ - var_288_10) / var_288_11
				local var_288_13 = Vector3.New(0, 100, 0)

				var_288_9.localPosition = Vector3.Lerp(arg_285_1.var_.moveOldPos1085ui_story, var_288_13, var_288_12)

				local var_288_14 = manager.ui.mainCamera.transform.position - var_288_9.position

				var_288_9.forward = Vector3.New(var_288_14.x, var_288_14.y, var_288_14.z)

				local var_288_15 = var_288_9.localEulerAngles

				var_288_15.z = 0
				var_288_15.x = 0
				var_288_9.localEulerAngles = var_288_15
			end

			if arg_285_1.time_ >= var_288_10 + var_288_11 and arg_285_1.time_ < var_288_10 + var_288_11 + arg_288_0 then
				var_288_9.localPosition = Vector3.New(0, 100, 0)

				local var_288_16 = manager.ui.mainCamera.transform.position - var_288_9.position

				var_288_9.forward = Vector3.New(var_288_16.x, var_288_16.y, var_288_16.z)

				local var_288_17 = var_288_9.localEulerAngles

				var_288_17.z = 0
				var_288_17.x = 0
				var_288_9.localEulerAngles = var_288_17
			end

			local var_288_18 = arg_285_1.actors_["10066ui_story"]
			local var_288_19 = 0

			if var_288_19 < arg_285_1.time_ and arg_285_1.time_ <= var_288_19 + arg_288_0 and not isNil(var_288_18) and arg_285_1.var_.characterEffect10066ui_story == nil then
				arg_285_1.var_.characterEffect10066ui_story = var_288_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_20 = 0.200000002980232

			if var_288_19 <= arg_285_1.time_ and arg_285_1.time_ < var_288_19 + var_288_20 and not isNil(var_288_18) then
				local var_288_21 = (arg_285_1.time_ - var_288_19) / var_288_20

				if arg_285_1.var_.characterEffect10066ui_story and not isNil(var_288_18) then
					local var_288_22 = Mathf.Lerp(0, 0.5, var_288_21)

					arg_285_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_285_1.var_.characterEffect10066ui_story.fillRatio = var_288_22
				end
			end

			if arg_285_1.time_ >= var_288_19 + var_288_20 and arg_285_1.time_ < var_288_19 + var_288_20 + arg_288_0 and not isNil(var_288_18) and arg_285_1.var_.characterEffect10066ui_story then
				local var_288_23 = 0.5

				arg_285_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_285_1.var_.characterEffect10066ui_story.fillRatio = var_288_23
			end

			local var_288_24 = 0
			local var_288_25 = 0.875

			if var_288_24 < arg_285_1.time_ and arg_285_1.time_ <= var_288_24 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_26 = arg_285_1:GetWordFromCfg(1108503069)
				local var_288_27 = arg_285_1:FormatText(var_288_26.content)

				arg_285_1.text_.text = var_288_27

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_28 = 35
				local var_288_29 = utf8.len(var_288_27)
				local var_288_30 = var_288_28 <= 0 and var_288_25 or var_288_25 * (var_288_29 / var_288_28)

				if var_288_30 > 0 and var_288_25 < var_288_30 then
					arg_285_1.talkMaxDuration = var_288_30

					if var_288_30 + var_288_24 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_30 + var_288_24
					end
				end

				arg_285_1.text_.text = var_288_27
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_31 = math.max(var_288_25, arg_285_1.talkMaxDuration)

			if var_288_24 <= arg_285_1.time_ and arg_285_1.time_ < var_288_24 + var_288_31 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_24) / var_288_31

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_24 + var_288_31 and arg_285_1.time_ < var_288_24 + var_288_31 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_285_1:InitPlayNodeList()
	end,
	Play1108503070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 1108503070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play1108503071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0
			local var_292_1 = 1.4

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

				local var_292_2 = arg_289_1:GetWordFromCfg(1108503070)
				local var_292_3 = arg_289_1:FormatText(var_292_2.content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 56
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
	Play1108503071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 1108503071
		arg_293_1.duration_ = 9

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play1108503072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = "ST12a"

			if arg_293_1.bgs_[var_296_0] == nil then
				local var_296_1 = Object.Instantiate(arg_293_1.paintGo_)

				var_296_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_296_0)
				var_296_1.name = var_296_0
				var_296_1.transform.parent = arg_293_1.stage_.transform
				var_296_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_293_1.bgs_[var_296_0] = var_296_1
			end

			local var_296_2 = 2

			if var_296_2 < arg_293_1.time_ and arg_293_1.time_ <= var_296_2 + arg_296_0 then
				local var_296_3 = manager.ui.mainCamera.transform.localPosition
				local var_296_4 = Vector3.New(0, 0, 10) + Vector3.New(var_296_3.x, var_296_3.y, 0)
				local var_296_5 = arg_293_1.bgs_.ST12a

				var_296_5.transform.localPosition = var_296_4
				var_296_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_296_6 = var_296_5:GetComponent("SpriteRenderer")

				if var_296_6 and var_296_6.sprite then
					local var_296_7 = (var_296_5.transform.localPosition - var_296_3).z
					local var_296_8 = manager.ui.mainCameraCom_
					local var_296_9 = 2 * var_296_7 * Mathf.Tan(var_296_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_296_10 = var_296_9 * var_296_8.aspect
					local var_296_11 = var_296_6.sprite.bounds.size.x
					local var_296_12 = var_296_6.sprite.bounds.size.y
					local var_296_13 = var_296_10 / var_296_11
					local var_296_14 = var_296_9 / var_296_12
					local var_296_15 = var_296_14 < var_296_13 and var_296_13 or var_296_14

					var_296_5.transform.localScale = Vector3.New(var_296_15, var_296_15, 0)
				end

				for iter_296_0, iter_296_1 in pairs(arg_293_1.bgs_) do
					if iter_296_0 ~= "ST12a" then
						iter_296_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_296_16 = 3.999999999999

			if var_296_16 < arg_293_1.time_ and arg_293_1.time_ <= var_296_16 + arg_296_0 then
				arg_293_1.allBtn_.enabled = false
			end

			local var_296_17 = 0.3

			if arg_293_1.time_ >= var_296_16 + var_296_17 and arg_293_1.time_ < var_296_16 + var_296_17 + arg_296_0 then
				arg_293_1.allBtn_.enabled = true
			end

			local var_296_18 = 0

			if var_296_18 < arg_293_1.time_ and arg_293_1.time_ <= var_296_18 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_19 = 2

			if var_296_18 <= arg_293_1.time_ and arg_293_1.time_ < var_296_18 + var_296_19 then
				local var_296_20 = (arg_293_1.time_ - var_296_18) / var_296_19
				local var_296_21 = Color.New(0, 0, 0)

				var_296_21.a = Mathf.Lerp(0, 1, var_296_20)
				arg_293_1.mask_.color = var_296_21
			end

			if arg_293_1.time_ >= var_296_18 + var_296_19 and arg_293_1.time_ < var_296_18 + var_296_19 + arg_296_0 then
				local var_296_22 = Color.New(0, 0, 0)

				var_296_22.a = 1
				arg_293_1.mask_.color = var_296_22
			end

			local var_296_23 = 2

			if var_296_23 < arg_293_1.time_ and arg_293_1.time_ <= var_296_23 + arg_296_0 then
				arg_293_1.mask_.enabled = true
				arg_293_1.mask_.raycastTarget = true

				arg_293_1:SetGaussion(false)
			end

			local var_296_24 = 2

			if var_296_23 <= arg_293_1.time_ and arg_293_1.time_ < var_296_23 + var_296_24 then
				local var_296_25 = (arg_293_1.time_ - var_296_23) / var_296_24
				local var_296_26 = Color.New(0, 0, 0)

				var_296_26.a = Mathf.Lerp(1, 0, var_296_25)
				arg_293_1.mask_.color = var_296_26
			end

			if arg_293_1.time_ >= var_296_23 + var_296_24 and arg_293_1.time_ < var_296_23 + var_296_24 + arg_296_0 then
				local var_296_27 = Color.New(0, 0, 0)
				local var_296_28 = 0

				arg_293_1.mask_.enabled = false
				var_296_27.a = var_296_28
				arg_293_1.mask_.color = var_296_27
			end

			local var_296_29 = 0.266666666666667
			local var_296_30 = 0.3

			if var_296_29 < arg_293_1.time_ and arg_293_1.time_ <= var_296_29 + arg_296_0 then
				local var_296_31 = "play"
				local var_296_32 = "music"

				arg_293_1:AudioAction(var_296_31, var_296_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_296_33 = ""
				local var_296_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_296_34 ~= "" then
					if arg_293_1.bgmTxt_.text ~= var_296_34 and arg_293_1.bgmTxt_.text ~= "" then
						if arg_293_1.bgmTxt2_.text ~= "" then
							arg_293_1.bgmTxt_.text = arg_293_1.bgmTxt2_.text
						end

						arg_293_1.bgmTxt2_.text = var_296_34

						arg_293_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_293_1.bgmTxt_.text = var_296_34
						arg_293_1.bgmTxt2_.text = var_296_34
					end

					if arg_293_1.bgmTimer then
						arg_293_1.bgmTimer:Stop()

						arg_293_1.bgmTimer = nil
					end

					if arg_293_1.settingData.show_music_name == 1 then
						arg_293_1.musicController:SetSelectedState("show")
						arg_293_1.musicAnimator_:Play("open", 0, 0)

						if arg_293_1.settingData.music_time ~= 0 then
							arg_293_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_293_1.settingData.music_time), function()
								if arg_293_1 == nil or isNil(arg_293_1.bgmTxt_) then
									return
								end

								arg_293_1.musicController:SetSelectedState("hide")
								arg_293_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_296_35 = 1.7
			local var_296_36 = 1

			if var_296_35 < arg_293_1.time_ and arg_293_1.time_ <= var_296_35 + arg_296_0 then
				local var_296_37 = "play"
				local var_296_38 = "music"

				arg_293_1:AudioAction(var_296_37, var_296_38, "bgm_story_quiet_1", "bgm_story_quiet_1", "bgm_story_quiet_1.awb")

				local var_296_39 = ""
				local var_296_40 = manager.audio:GetAudioName("bgm_story_quiet_1", "bgm_story_quiet_1")

				if var_296_40 ~= "" then
					if arg_293_1.bgmTxt_.text ~= var_296_40 and arg_293_1.bgmTxt_.text ~= "" then
						if arg_293_1.bgmTxt2_.text ~= "" then
							arg_293_1.bgmTxt_.text = arg_293_1.bgmTxt2_.text
						end

						arg_293_1.bgmTxt2_.text = var_296_40

						arg_293_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_293_1.bgmTxt_.text = var_296_40
						arg_293_1.bgmTxt2_.text = var_296_40
					end

					if arg_293_1.bgmTimer then
						arg_293_1.bgmTimer:Stop()

						arg_293_1.bgmTimer = nil
					end

					if arg_293_1.settingData.show_music_name == 1 then
						arg_293_1.musicController:SetSelectedState("show")
						arg_293_1.musicAnimator_:Play("open", 0, 0)

						if arg_293_1.settingData.music_time ~= 0 then
							arg_293_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_293_1.settingData.music_time), function()
								if arg_293_1 == nil or isNil(arg_293_1.bgmTxt_) then
									return
								end

								arg_293_1.musicController:SetSelectedState("hide")
								arg_293_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_296_41 = 0.266666666666667
			local var_296_42 = 1

			if var_296_41 < arg_293_1.time_ and arg_293_1.time_ <= var_296_41 + arg_296_0 then
				local var_296_43 = "stop"
				local var_296_44 = "effect"

				arg_293_1:AudioAction(var_296_43, var_296_44, "se_story_side_1075", "se_story_side_1075_morningloop", "")
			end

			local var_296_45 = 1.7
			local var_296_46 = 1

			if var_296_45 < arg_293_1.time_ and arg_293_1.time_ <= var_296_45 + arg_296_0 then
				local var_296_47 = "play"
				local var_296_48 = "effect"

				arg_293_1:AudioAction(var_296_47, var_296_48, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_293_1.frameCnt_ <= 1 then
				arg_293_1.dialog_:SetActive(false)
			end

			local var_296_49 = 4
			local var_296_50 = 0.375

			if var_296_49 < arg_293_1.time_ and arg_293_1.time_ <= var_296_49 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0

				arg_293_1.dialog_:SetActive(true)

				arg_293_1.dialogCg_.alpha = 0

				local var_296_51 = LeanTween.value(arg_293_1.dialog_, 0, 1, 0.3)

				var_296_51:setOnUpdate(LuaHelper.FloatAction(function(arg_299_0)
					arg_293_1.dialogCg_.alpha = arg_299_0
				end))
				var_296_51:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_293_1.dialog_)
					var_296_51:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_293_1.duration_ = arg_293_1.duration_ + 0.3

				SetActive(arg_293_1.leftNameGo_, true)

				local var_296_52 = arg_293_1:FormatText(StoryNameCfg[7].name)

				arg_293_1.leftNameTxt_.text = var_296_52

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_53 = arg_293_1:GetWordFromCfg(1108503071)
				local var_296_54 = arg_293_1:FormatText(var_296_53.content)

				arg_293_1.text_.text = var_296_54

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_55 = 15
				local var_296_56 = utf8.len(var_296_54)
				local var_296_57 = var_296_55 <= 0 and var_296_50 or var_296_50 * (var_296_56 / var_296_55)

				if var_296_57 > 0 and var_296_50 < var_296_57 then
					arg_293_1.talkMaxDuration = var_296_57
					var_296_49 = var_296_49 + 0.3

					if var_296_57 + var_296_49 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_57 + var_296_49
					end
				end

				arg_293_1.text_.text = var_296_54
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_58 = var_296_49 + 0.3
			local var_296_59 = math.max(var_296_50, arg_293_1.talkMaxDuration)

			if var_296_58 <= arg_293_1.time_ and arg_293_1.time_ < var_296_58 + var_296_59 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_58) / var_296_59

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_58 + var_296_59 and arg_293_1.time_ < var_296_58 + var_296_59 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play1108503072 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 1108503072
		arg_301_1.duration_ = 2

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play1108503073(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			local var_304_0 = arg_301_1.actors_["1085ui_story"].transform
			local var_304_1 = 0

			if var_304_1 < arg_301_1.time_ and arg_301_1.time_ <= var_304_1 + arg_304_0 then
				arg_301_1.var_.moveOldPos1085ui_story = var_304_0.localPosition
			end

			local var_304_2 = 0.001

			if var_304_1 <= arg_301_1.time_ and arg_301_1.time_ < var_304_1 + var_304_2 then
				local var_304_3 = (arg_301_1.time_ - var_304_1) / var_304_2
				local var_304_4 = Vector3.New(0, -1.01, -5.83)

				var_304_0.localPosition = Vector3.Lerp(arg_301_1.var_.moveOldPos1085ui_story, var_304_4, var_304_3)

				local var_304_5 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_5.x, var_304_5.y, var_304_5.z)

				local var_304_6 = var_304_0.localEulerAngles

				var_304_6.z = 0
				var_304_6.x = 0
				var_304_0.localEulerAngles = var_304_6
			end

			if arg_301_1.time_ >= var_304_1 + var_304_2 and arg_301_1.time_ < var_304_1 + var_304_2 + arg_304_0 then
				var_304_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_304_7 = manager.ui.mainCamera.transform.position - var_304_0.position

				var_304_0.forward = Vector3.New(var_304_7.x, var_304_7.y, var_304_7.z)

				local var_304_8 = var_304_0.localEulerAngles

				var_304_8.z = 0
				var_304_8.x = 0
				var_304_0.localEulerAngles = var_304_8
			end

			local var_304_9 = arg_301_1.actors_["1085ui_story"]
			local var_304_10 = 0

			if var_304_10 < arg_301_1.time_ and arg_301_1.time_ <= var_304_10 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1085ui_story == nil then
				arg_301_1.var_.characterEffect1085ui_story = var_304_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_11 = 0.200000002980232

			if var_304_10 <= arg_301_1.time_ and arg_301_1.time_ < var_304_10 + var_304_11 and not isNil(var_304_9) then
				local var_304_12 = (arg_301_1.time_ - var_304_10) / var_304_11

				if arg_301_1.var_.characterEffect1085ui_story and not isNil(var_304_9) then
					arg_301_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= var_304_10 + var_304_11 and arg_301_1.time_ < var_304_10 + var_304_11 + arg_304_0 and not isNil(var_304_9) and arg_301_1.var_.characterEffect1085ui_story then
				arg_301_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_304_13 = 0

			if var_304_13 < arg_301_1.time_ and arg_301_1.time_ <= var_304_13 + arg_304_0 then
				arg_301_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_304_14 = 0

			if var_304_14 < arg_301_1.time_ and arg_301_1.time_ <= var_304_14 + arg_304_0 then
				arg_301_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_304_15 = 0
			local var_304_16 = 0.15

			if var_304_15 < arg_301_1.time_ and arg_301_1.time_ <= var_304_15 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				local var_304_17 = arg_301_1:FormatText(StoryNameCfg[328].name)

				arg_301_1.leftNameTxt_.text = var_304_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_18 = arg_301_1:GetWordFromCfg(1108503072)
				local var_304_19 = arg_301_1:FormatText(var_304_18.content)

				arg_301_1.text_.text = var_304_19

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_20 = 6
				local var_304_21 = utf8.len(var_304_19)
				local var_304_22 = var_304_20 <= 0 and var_304_16 or var_304_16 * (var_304_21 / var_304_20)

				if var_304_22 > 0 and var_304_16 < var_304_22 then
					arg_301_1.talkMaxDuration = var_304_22

					if var_304_22 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_22 + var_304_15
					end
				end

				arg_301_1.text_.text = var_304_19
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503072", "story_v_side_new_1108503.awb") ~= 0 then
					local var_304_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503072", "story_v_side_new_1108503.awb") / 1000

					if var_304_23 + var_304_15 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_23 + var_304_15
					end

					if var_304_18.prefab_name ~= "" and arg_301_1.actors_[var_304_18.prefab_name] ~= nil then
						local var_304_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_301_1.actors_[var_304_18.prefab_name].transform, "story_v_side_new_1108503", "1108503072", "story_v_side_new_1108503.awb")

						arg_301_1:RecordAudio("1108503072", var_304_24)
						arg_301_1:RecordAudio("1108503072", var_304_24)
					else
						arg_301_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503072", "story_v_side_new_1108503.awb")
					end

					arg_301_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503072", "story_v_side_new_1108503.awb")
				end

				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_25 = math.max(var_304_16, arg_301_1.talkMaxDuration)

			if var_304_15 <= arg_301_1.time_ and arg_301_1.time_ < var_304_15 + var_304_25 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_15) / var_304_25

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_15 + var_304_25 and arg_301_1.time_ < var_304_15 + var_304_25 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {
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

		arg_301_1:InitPlayNodeList()
	end,
	Play1108503073 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 1108503073
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play1108503074(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			local var_308_0 = arg_305_1.actors_["1085ui_story"].transform
			local var_308_1 = 0

			if var_308_1 < arg_305_1.time_ and arg_305_1.time_ <= var_308_1 + arg_308_0 then
				arg_305_1.var_.moveOldPos1085ui_story = var_308_0.localPosition
			end

			local var_308_2 = 0.001

			if var_308_1 <= arg_305_1.time_ and arg_305_1.time_ < var_308_1 + var_308_2 then
				local var_308_3 = (arg_305_1.time_ - var_308_1) / var_308_2
				local var_308_4 = Vector3.New(0, 100, 0)

				var_308_0.localPosition = Vector3.Lerp(arg_305_1.var_.moveOldPos1085ui_story, var_308_4, var_308_3)

				local var_308_5 = manager.ui.mainCamera.transform.position - var_308_0.position

				var_308_0.forward = Vector3.New(var_308_5.x, var_308_5.y, var_308_5.z)

				local var_308_6 = var_308_0.localEulerAngles

				var_308_6.z = 0
				var_308_6.x = 0
				var_308_0.localEulerAngles = var_308_6
			end

			if arg_305_1.time_ >= var_308_1 + var_308_2 and arg_305_1.time_ < var_308_1 + var_308_2 + arg_308_0 then
				var_308_0.localPosition = Vector3.New(0, 100, 0)

				local var_308_7 = manager.ui.mainCamera.transform.position - var_308_0.position

				var_308_0.forward = Vector3.New(var_308_7.x, var_308_7.y, var_308_7.z)

				local var_308_8 = var_308_0.localEulerAngles

				var_308_8.z = 0
				var_308_8.x = 0
				var_308_0.localEulerAngles = var_308_8
			end

			local var_308_9 = arg_305_1.actors_["1085ui_story"]
			local var_308_10 = 0

			if var_308_10 < arg_305_1.time_ and arg_305_1.time_ <= var_308_10 + arg_308_0 and not isNil(var_308_9) and arg_305_1.var_.characterEffect1085ui_story == nil then
				arg_305_1.var_.characterEffect1085ui_story = var_308_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_308_11 = 0.200000002980232

			if var_308_10 <= arg_305_1.time_ and arg_305_1.time_ < var_308_10 + var_308_11 and not isNil(var_308_9) then
				local var_308_12 = (arg_305_1.time_ - var_308_10) / var_308_11

				if arg_305_1.var_.characterEffect1085ui_story and not isNil(var_308_9) then
					local var_308_13 = Mathf.Lerp(0, 0.5, var_308_12)

					arg_305_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_305_1.var_.characterEffect1085ui_story.fillRatio = var_308_13
				end
			end

			if arg_305_1.time_ >= var_308_10 + var_308_11 and arg_305_1.time_ < var_308_10 + var_308_11 + arg_308_0 and not isNil(var_308_9) and arg_305_1.var_.characterEffect1085ui_story then
				local var_308_14 = 0.5

				arg_305_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_305_1.var_.characterEffect1085ui_story.fillRatio = var_308_14
			end

			local var_308_15 = 0
			local var_308_16 = 0.45

			if var_308_15 < arg_305_1.time_ and arg_305_1.time_ <= var_308_15 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, false)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_17 = arg_305_1:GetWordFromCfg(1108503073)
				local var_308_18 = arg_305_1:FormatText(var_308_17.content)

				arg_305_1.text_.text = var_308_18

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_19 = 18
				local var_308_20 = utf8.len(var_308_18)
				local var_308_21 = var_308_19 <= 0 and var_308_16 or var_308_16 * (var_308_20 / var_308_19)

				if var_308_21 > 0 and var_308_16 < var_308_21 then
					arg_305_1.talkMaxDuration = var_308_21

					if var_308_21 + var_308_15 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_21 + var_308_15
					end
				end

				arg_305_1.text_.text = var_308_18
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_22 = math.max(var_308_16, arg_305_1.talkMaxDuration)

			if var_308_15 <= arg_305_1.time_ and arg_305_1.time_ < var_308_15 + var_308_22 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_15) / var_308_22

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_15 + var_308_22 and arg_305_1.time_ < var_308_15 + var_308_22 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {
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

		arg_305_1:InitPlayNodeList()
	end,
	Play1108503074 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 1108503074
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play1108503075(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			local var_312_0 = 0
			local var_312_1 = 0.45

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

				local var_312_3 = arg_309_1:GetWordFromCfg(1108503074)
				local var_312_4 = arg_309_1:FormatText(var_312_3.content)

				arg_309_1.text_.text = var_312_4

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_5 = 18
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
	Play1108503075 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 1108503075
		arg_313_1.duration_ = 8.93

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play1108503076(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			local var_316_0 = arg_313_1.actors_["1085ui_story"].transform
			local var_316_1 = 0

			if var_316_1 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.var_.moveOldPos1085ui_story = var_316_0.localPosition
			end

			local var_316_2 = 0.001

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_2 then
				local var_316_3 = (arg_313_1.time_ - var_316_1) / var_316_2
				local var_316_4 = Vector3.New(0, -1.01, -5.83)

				var_316_0.localPosition = Vector3.Lerp(arg_313_1.var_.moveOldPos1085ui_story, var_316_4, var_316_3)

				local var_316_5 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_5.x, var_316_5.y, var_316_5.z)

				local var_316_6 = var_316_0.localEulerAngles

				var_316_6.z = 0
				var_316_6.x = 0
				var_316_0.localEulerAngles = var_316_6
			end

			if arg_313_1.time_ >= var_316_1 + var_316_2 and arg_313_1.time_ < var_316_1 + var_316_2 + arg_316_0 then
				var_316_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_316_7 = manager.ui.mainCamera.transform.position - var_316_0.position

				var_316_0.forward = Vector3.New(var_316_7.x, var_316_7.y, var_316_7.z)

				local var_316_8 = var_316_0.localEulerAngles

				var_316_8.z = 0
				var_316_8.x = 0
				var_316_0.localEulerAngles = var_316_8
			end

			local var_316_9 = arg_313_1.actors_["1085ui_story"]
			local var_316_10 = 0

			if var_316_10 < arg_313_1.time_ and arg_313_1.time_ <= var_316_10 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1085ui_story == nil then
				arg_313_1.var_.characterEffect1085ui_story = var_316_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_11 = 0.200000002980232

			if var_316_10 <= arg_313_1.time_ and arg_313_1.time_ < var_316_10 + var_316_11 and not isNil(var_316_9) then
				local var_316_12 = (arg_313_1.time_ - var_316_10) / var_316_11

				if arg_313_1.var_.characterEffect1085ui_story and not isNil(var_316_9) then
					arg_313_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_313_1.time_ >= var_316_10 + var_316_11 and arg_313_1.time_ < var_316_10 + var_316_11 + arg_316_0 and not isNil(var_316_9) and arg_313_1.var_.characterEffect1085ui_story then
				arg_313_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_316_13 = 0

			if var_316_13 < arg_313_1.time_ and arg_313_1.time_ <= var_316_13 + arg_316_0 then
				arg_313_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_316_14 = 0

			if var_316_14 < arg_313_1.time_ and arg_313_1.time_ <= var_316_14 + arg_316_0 then
				arg_313_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_316_15 = 0
			local var_316_16 = 0.525

			if var_316_15 < arg_313_1.time_ and arg_313_1.time_ <= var_316_15 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, true)

				local var_316_17 = arg_313_1:FormatText(StoryNameCfg[328].name)

				arg_313_1.leftNameTxt_.text = var_316_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_313_1.leftNameTxt_.transform)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1.leftNameTxt_.text)
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_18 = arg_313_1:GetWordFromCfg(1108503075)
				local var_316_19 = arg_313_1:FormatText(var_316_18.content)

				arg_313_1.text_.text = var_316_19

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_20 = 21
				local var_316_21 = utf8.len(var_316_19)
				local var_316_22 = var_316_20 <= 0 and var_316_16 or var_316_16 * (var_316_21 / var_316_20)

				if var_316_22 > 0 and var_316_16 < var_316_22 then
					arg_313_1.talkMaxDuration = var_316_22

					if var_316_22 + var_316_15 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_22 + var_316_15
					end
				end

				arg_313_1.text_.text = var_316_19
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503075", "story_v_side_new_1108503.awb") ~= 0 then
					local var_316_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503075", "story_v_side_new_1108503.awb") / 1000

					if var_316_23 + var_316_15 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_23 + var_316_15
					end

					if var_316_18.prefab_name ~= "" and arg_313_1.actors_[var_316_18.prefab_name] ~= nil then
						local var_316_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_313_1.actors_[var_316_18.prefab_name].transform, "story_v_side_new_1108503", "1108503075", "story_v_side_new_1108503.awb")

						arg_313_1:RecordAudio("1108503075", var_316_24)
						arg_313_1:RecordAudio("1108503075", var_316_24)
					else
						arg_313_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503075", "story_v_side_new_1108503.awb")
					end

					arg_313_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503075", "story_v_side_new_1108503.awb")
				end

				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_25 = math.max(var_316_16, arg_313_1.talkMaxDuration)

			if var_316_15 <= arg_313_1.time_ and arg_313_1.time_ < var_316_15 + var_316_25 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_15) / var_316_25

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_15 + var_316_25 and arg_313_1.time_ < var_316_15 + var_316_25 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {
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

		arg_313_1:InitPlayNodeList()
	end,
	Play1108503076 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 1108503076
		arg_317_1.duration_ = 9.57

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play1108503077(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			local var_320_0 = arg_317_1.actors_["1085ui_story"].transform
			local var_320_1 = 0

			if var_320_1 < arg_317_1.time_ and arg_317_1.time_ <= var_320_1 + arg_320_0 then
				arg_317_1.var_.moveOldPos1085ui_story = var_320_0.localPosition
			end

			local var_320_2 = 0.001

			if var_320_1 <= arg_317_1.time_ and arg_317_1.time_ < var_320_1 + var_320_2 then
				local var_320_3 = (arg_317_1.time_ - var_320_1) / var_320_2
				local var_320_4 = Vector3.New(0, -1.01, -5.83)

				var_320_0.localPosition = Vector3.Lerp(arg_317_1.var_.moveOldPos1085ui_story, var_320_4, var_320_3)

				local var_320_5 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_5.x, var_320_5.y, var_320_5.z)

				local var_320_6 = var_320_0.localEulerAngles

				var_320_6.z = 0
				var_320_6.x = 0
				var_320_0.localEulerAngles = var_320_6
			end

			if arg_317_1.time_ >= var_320_1 + var_320_2 and arg_317_1.time_ < var_320_1 + var_320_2 + arg_320_0 then
				var_320_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_320_7 = manager.ui.mainCamera.transform.position - var_320_0.position

				var_320_0.forward = Vector3.New(var_320_7.x, var_320_7.y, var_320_7.z)

				local var_320_8 = var_320_0.localEulerAngles

				var_320_8.z = 0
				var_320_8.x = 0
				var_320_0.localEulerAngles = var_320_8
			end

			local var_320_9 = 0

			if var_320_9 < arg_317_1.time_ and arg_317_1.time_ <= var_320_9 + arg_320_0 then
				arg_317_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_320_10 = 0

			if var_320_10 < arg_317_1.time_ and arg_317_1.time_ <= var_320_10 + arg_320_0 then
				arg_317_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_320_11 = 0
			local var_320_12 = 0.75

			if var_320_11 < arg_317_1.time_ and arg_317_1.time_ <= var_320_11 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				local var_320_13 = arg_317_1:FormatText(StoryNameCfg[328].name)

				arg_317_1.leftNameTxt_.text = var_320_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_14 = arg_317_1:GetWordFromCfg(1108503076)
				local var_320_15 = arg_317_1:FormatText(var_320_14.content)

				arg_317_1.text_.text = var_320_15

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_16 = 30
				local var_320_17 = utf8.len(var_320_15)
				local var_320_18 = var_320_16 <= 0 and var_320_12 or var_320_12 * (var_320_17 / var_320_16)

				if var_320_18 > 0 and var_320_12 < var_320_18 then
					arg_317_1.talkMaxDuration = var_320_18

					if var_320_18 + var_320_11 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_18 + var_320_11
					end
				end

				arg_317_1.text_.text = var_320_15
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503076", "story_v_side_new_1108503.awb") ~= 0 then
					local var_320_19 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503076", "story_v_side_new_1108503.awb") / 1000

					if var_320_19 + var_320_11 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_19 + var_320_11
					end

					if var_320_14.prefab_name ~= "" and arg_317_1.actors_[var_320_14.prefab_name] ~= nil then
						local var_320_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_317_1.actors_[var_320_14.prefab_name].transform, "story_v_side_new_1108503", "1108503076", "story_v_side_new_1108503.awb")

						arg_317_1:RecordAudio("1108503076", var_320_20)
						arg_317_1:RecordAudio("1108503076", var_320_20)
					else
						arg_317_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503076", "story_v_side_new_1108503.awb")
					end

					arg_317_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503076", "story_v_side_new_1108503.awb")
				end

				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_21 = math.max(var_320_12, arg_317_1.talkMaxDuration)

			if var_320_11 <= arg_317_1.time_ and arg_317_1.time_ < var_320_11 + var_320_21 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_11) / var_320_21

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_11 + var_320_21 and arg_317_1.time_ < var_320_11 + var_320_21 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {
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

		arg_317_1:InitPlayNodeList()
	end,
	Play1108503077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 1108503077
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play1108503078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = arg_321_1.actors_["1085ui_story"]
			local var_324_1 = 0

			if var_324_1 < arg_321_1.time_ and arg_321_1.time_ <= var_324_1 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1085ui_story == nil then
				arg_321_1.var_.characterEffect1085ui_story = var_324_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_2 = 0.200000002980232

			if var_324_1 <= arg_321_1.time_ and arg_321_1.time_ < var_324_1 + var_324_2 and not isNil(var_324_0) then
				local var_324_3 = (arg_321_1.time_ - var_324_1) / var_324_2

				if arg_321_1.var_.characterEffect1085ui_story and not isNil(var_324_0) then
					local var_324_4 = Mathf.Lerp(0, 0.5, var_324_3)

					arg_321_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1085ui_story.fillRatio = var_324_4
				end
			end

			if arg_321_1.time_ >= var_324_1 + var_324_2 and arg_321_1.time_ < var_324_1 + var_324_2 + arg_324_0 and not isNil(var_324_0) and arg_321_1.var_.characterEffect1085ui_story then
				local var_324_5 = 0.5

				arg_321_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1085ui_story.fillRatio = var_324_5
			end

			local var_324_6 = 0
			local var_324_7 = 0.475

			if var_324_6 < arg_321_1.time_ and arg_321_1.time_ <= var_324_6 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				local var_324_8 = arg_321_1:FormatText(StoryNameCfg[7].name)

				arg_321_1.leftNameTxt_.text = var_324_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_9 = arg_321_1:GetWordFromCfg(1108503077)
				local var_324_10 = arg_321_1:FormatText(var_324_9.content)

				arg_321_1.text_.text = var_324_10

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_11 = 19
				local var_324_12 = utf8.len(var_324_10)
				local var_324_13 = var_324_11 <= 0 and var_324_7 or var_324_7 * (var_324_12 / var_324_11)

				if var_324_13 > 0 and var_324_7 < var_324_13 then
					arg_321_1.talkMaxDuration = var_324_13

					if var_324_13 + var_324_6 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_13 + var_324_6
					end
				end

				arg_321_1.text_.text = var_324_10
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_14 = math.max(var_324_7, arg_321_1.talkMaxDuration)

			if var_324_6 <= arg_321_1.time_ and arg_321_1.time_ < var_324_6 + var_324_14 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_6) / var_324_14

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_6 + var_324_14 and arg_321_1.time_ < var_324_6 + var_324_14 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play1108503078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 1108503078
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play1108503079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = arg_325_1.actors_["1085ui_story"].transform
			local var_328_1 = 0

			if var_328_1 < arg_325_1.time_ and arg_325_1.time_ <= var_328_1 + arg_328_0 then
				arg_325_1.var_.moveOldPos1085ui_story = var_328_0.localPosition
			end

			local var_328_2 = 0.001

			if var_328_1 <= arg_325_1.time_ and arg_325_1.time_ < var_328_1 + var_328_2 then
				local var_328_3 = (arg_325_1.time_ - var_328_1) / var_328_2
				local var_328_4 = Vector3.New(0, 100, 0)

				var_328_0.localPosition = Vector3.Lerp(arg_325_1.var_.moveOldPos1085ui_story, var_328_4, var_328_3)

				local var_328_5 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_5.x, var_328_5.y, var_328_5.z)

				local var_328_6 = var_328_0.localEulerAngles

				var_328_6.z = 0
				var_328_6.x = 0
				var_328_0.localEulerAngles = var_328_6
			end

			if arg_325_1.time_ >= var_328_1 + var_328_2 and arg_325_1.time_ < var_328_1 + var_328_2 + arg_328_0 then
				var_328_0.localPosition = Vector3.New(0, 100, 0)

				local var_328_7 = manager.ui.mainCamera.transform.position - var_328_0.position

				var_328_0.forward = Vector3.New(var_328_7.x, var_328_7.y, var_328_7.z)

				local var_328_8 = var_328_0.localEulerAngles

				var_328_8.z = 0
				var_328_8.x = 0
				var_328_0.localEulerAngles = var_328_8
			end

			local var_328_9 = 0
			local var_328_10 = 0.95

			if var_328_9 < arg_325_1.time_ and arg_325_1.time_ <= var_328_9 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, false)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_11 = arg_325_1:GetWordFromCfg(1108503078)
				local var_328_12 = arg_325_1:FormatText(var_328_11.content)

				arg_325_1.text_.text = var_328_12

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_13 = 38
				local var_328_14 = utf8.len(var_328_12)
				local var_328_15 = var_328_13 <= 0 and var_328_10 or var_328_10 * (var_328_14 / var_328_13)

				if var_328_15 > 0 and var_328_10 < var_328_15 then
					arg_325_1.talkMaxDuration = var_328_15

					if var_328_15 + var_328_9 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_15 + var_328_9
					end
				end

				arg_325_1.text_.text = var_328_12
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_16 = math.max(var_328_10, arg_325_1.talkMaxDuration)

			if var_328_9 <= arg_325_1.time_ and arg_325_1.time_ < var_328_9 + var_328_16 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_9) / var_328_16

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_9 + var_328_16 and arg_325_1.time_ < var_328_9 + var_328_16 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {
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

		arg_325_1:InitPlayNodeList()
	end,
	Play1108503079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 1108503079
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play1108503080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			local var_332_0 = 0
			local var_332_1 = 0.35

			if var_332_0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_0 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				local var_332_2 = arg_329_1:FormatText(StoryNameCfg[7].name)

				arg_329_1.leftNameTxt_.text = var_332_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, true)
				arg_329_1.iconController_:SetSelectedState("hero")

				arg_329_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_329_1.callingController_:SetSelectedState("normal")

				arg_329_1.keyicon_.color = Color.New(1, 1, 1)
				arg_329_1.icon_.color = Color.New(1, 1, 1)

				local var_332_3 = arg_329_1:GetWordFromCfg(1108503079)
				local var_332_4 = arg_329_1:FormatText(var_332_3.content)

				arg_329_1.text_.text = var_332_4

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 14
				local var_332_6 = utf8.len(var_332_4)
				local var_332_7 = var_332_5 <= 0 and var_332_1 or var_332_1 * (var_332_6 / var_332_5)

				if var_332_7 > 0 and var_332_1 < var_332_7 then
					arg_329_1.talkMaxDuration = var_332_7

					if var_332_7 + var_332_0 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_7 + var_332_0
					end
				end

				arg_329_1.text_.text = var_332_4
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_8 = math.max(var_332_1, arg_329_1.talkMaxDuration)

			if var_332_0 <= arg_329_1.time_ and arg_329_1.time_ < var_332_0 + var_332_8 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_0) / var_332_8

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_0 + var_332_8 and arg_329_1.time_ < var_332_0 + var_332_8 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play1108503080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 1108503080
		arg_333_1.duration_ = 14.97

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play1108503081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = arg_333_1.actors_["1085ui_story"].transform
			local var_336_1 = 0

			if var_336_1 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.var_.moveOldPos1085ui_story = var_336_0.localPosition
			end

			local var_336_2 = 0.001

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_2 then
				local var_336_3 = (arg_333_1.time_ - var_336_1) / var_336_2
				local var_336_4 = Vector3.New(0, -1.01, -5.83)

				var_336_0.localPosition = Vector3.Lerp(arg_333_1.var_.moveOldPos1085ui_story, var_336_4, var_336_3)

				local var_336_5 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_5.x, var_336_5.y, var_336_5.z)

				local var_336_6 = var_336_0.localEulerAngles

				var_336_6.z = 0
				var_336_6.x = 0
				var_336_0.localEulerAngles = var_336_6
			end

			if arg_333_1.time_ >= var_336_1 + var_336_2 and arg_333_1.time_ < var_336_1 + var_336_2 + arg_336_0 then
				var_336_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_336_7 = manager.ui.mainCamera.transform.position - var_336_0.position

				var_336_0.forward = Vector3.New(var_336_7.x, var_336_7.y, var_336_7.z)

				local var_336_8 = var_336_0.localEulerAngles

				var_336_8.z = 0
				var_336_8.x = 0
				var_336_0.localEulerAngles = var_336_8
			end

			local var_336_9 = arg_333_1.actors_["1085ui_story"]
			local var_336_10 = 0

			if var_336_10 < arg_333_1.time_ and arg_333_1.time_ <= var_336_10 + arg_336_0 and not isNil(var_336_9) and arg_333_1.var_.characterEffect1085ui_story == nil then
				arg_333_1.var_.characterEffect1085ui_story = var_336_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_11 = 0.200000002980232

			if var_336_10 <= arg_333_1.time_ and arg_333_1.time_ < var_336_10 + var_336_11 and not isNil(var_336_9) then
				local var_336_12 = (arg_333_1.time_ - var_336_10) / var_336_11

				if arg_333_1.var_.characterEffect1085ui_story and not isNil(var_336_9) then
					arg_333_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_333_1.time_ >= var_336_10 + var_336_11 and arg_333_1.time_ < var_336_10 + var_336_11 + arg_336_0 and not isNil(var_336_9) and arg_333_1.var_.characterEffect1085ui_story then
				arg_333_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_336_13 = 0

			if var_336_13 < arg_333_1.time_ and arg_333_1.time_ <= var_336_13 + arg_336_0 then
				arg_333_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085actionlink/1085action423")
			end

			local var_336_14 = 0

			if var_336_14 < arg_333_1.time_ and arg_333_1.time_ <= var_336_14 + arg_336_0 then
				arg_333_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_336_15 = 0
			local var_336_16 = 1.15

			if var_336_15 < arg_333_1.time_ and arg_333_1.time_ <= var_336_15 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				local var_336_17 = arg_333_1:FormatText(StoryNameCfg[328].name)

				arg_333_1.leftNameTxt_.text = var_336_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_18 = arg_333_1:GetWordFromCfg(1108503080)
				local var_336_19 = arg_333_1:FormatText(var_336_18.content)

				arg_333_1.text_.text = var_336_19

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_20 = 46
				local var_336_21 = utf8.len(var_336_19)
				local var_336_22 = var_336_20 <= 0 and var_336_16 or var_336_16 * (var_336_21 / var_336_20)

				if var_336_22 > 0 and var_336_16 < var_336_22 then
					arg_333_1.talkMaxDuration = var_336_22

					if var_336_22 + var_336_15 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_22 + var_336_15
					end
				end

				arg_333_1.text_.text = var_336_19
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503080", "story_v_side_new_1108503.awb") ~= 0 then
					local var_336_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503080", "story_v_side_new_1108503.awb") / 1000

					if var_336_23 + var_336_15 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_23 + var_336_15
					end

					if var_336_18.prefab_name ~= "" and arg_333_1.actors_[var_336_18.prefab_name] ~= nil then
						local var_336_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_18.prefab_name].transform, "story_v_side_new_1108503", "1108503080", "story_v_side_new_1108503.awb")

						arg_333_1:RecordAudio("1108503080", var_336_24)
						arg_333_1:RecordAudio("1108503080", var_336_24)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503080", "story_v_side_new_1108503.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503080", "story_v_side_new_1108503.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_25 = math.max(var_336_16, arg_333_1.talkMaxDuration)

			if var_336_15 <= arg_333_1.time_ and arg_333_1.time_ < var_336_15 + var_336_25 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_15) / var_336_25

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_15 + var_336_25 and arg_333_1.time_ < var_336_15 + var_336_25 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {
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

		arg_333_1:InitPlayNodeList()
	end,
	Play1108503081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 1108503081
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play1108503082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = arg_337_1.actors_["1085ui_story"]
			local var_340_1 = 0

			if var_340_1 < arg_337_1.time_ and arg_337_1.time_ <= var_340_1 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1085ui_story == nil then
				arg_337_1.var_.characterEffect1085ui_story = var_340_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_2 = 0.200000002980232

			if var_340_1 <= arg_337_1.time_ and arg_337_1.time_ < var_340_1 + var_340_2 and not isNil(var_340_0) then
				local var_340_3 = (arg_337_1.time_ - var_340_1) / var_340_2

				if arg_337_1.var_.characterEffect1085ui_story and not isNil(var_340_0) then
					local var_340_4 = Mathf.Lerp(0, 0.5, var_340_3)

					arg_337_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_337_1.var_.characterEffect1085ui_story.fillRatio = var_340_4
				end
			end

			if arg_337_1.time_ >= var_340_1 + var_340_2 and arg_337_1.time_ < var_340_1 + var_340_2 + arg_340_0 and not isNil(var_340_0) and arg_337_1.var_.characterEffect1085ui_story then
				local var_340_5 = 0.5

				arg_337_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_337_1.var_.characterEffect1085ui_story.fillRatio = var_340_5
			end

			local var_340_6 = 0
			local var_340_7 = 0.225

			if var_340_6 < arg_337_1.time_ and arg_337_1.time_ <= var_340_6 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				local var_340_8 = arg_337_1:FormatText(StoryNameCfg[7].name)

				arg_337_1.leftNameTxt_.text = var_340_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, true)
				arg_337_1.iconController_:SetSelectedState("hero")

				arg_337_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_337_1.callingController_:SetSelectedState("normal")

				arg_337_1.keyicon_.color = Color.New(1, 1, 1)
				arg_337_1.icon_.color = Color.New(1, 1, 1)

				local var_340_9 = arg_337_1:GetWordFromCfg(1108503081)
				local var_340_10 = arg_337_1:FormatText(var_340_9.content)

				arg_337_1.text_.text = var_340_10

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_11 = 9
				local var_340_12 = utf8.len(var_340_10)
				local var_340_13 = var_340_11 <= 0 and var_340_7 or var_340_7 * (var_340_12 / var_340_11)

				if var_340_13 > 0 and var_340_7 < var_340_13 then
					arg_337_1.talkMaxDuration = var_340_13

					if var_340_13 + var_340_6 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_13 + var_340_6
					end
				end

				arg_337_1.text_.text = var_340_10
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_14 = math.max(var_340_7, arg_337_1.talkMaxDuration)

			if var_340_6 <= arg_337_1.time_ and arg_337_1.time_ < var_340_6 + var_340_14 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_6) / var_340_14

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_6 + var_340_14 and arg_337_1.time_ < var_340_6 + var_340_14 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play1108503082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 1108503082
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play1108503083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			local var_344_0 = arg_341_1.actors_["1085ui_story"].transform
			local var_344_1 = 0

			if var_344_1 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.var_.moveOldPos1085ui_story = var_344_0.localPosition
			end

			local var_344_2 = 0.001

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_2 then
				local var_344_3 = (arg_341_1.time_ - var_344_1) / var_344_2
				local var_344_4 = Vector3.New(0, 100, 0)

				var_344_0.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1085ui_story, var_344_4, var_344_3)

				local var_344_5 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_5.x, var_344_5.y, var_344_5.z)

				local var_344_6 = var_344_0.localEulerAngles

				var_344_6.z = 0
				var_344_6.x = 0
				var_344_0.localEulerAngles = var_344_6
			end

			if arg_341_1.time_ >= var_344_1 + var_344_2 and arg_341_1.time_ < var_344_1 + var_344_2 + arg_344_0 then
				var_344_0.localPosition = Vector3.New(0, 100, 0)

				local var_344_7 = manager.ui.mainCamera.transform.position - var_344_0.position

				var_344_0.forward = Vector3.New(var_344_7.x, var_344_7.y, var_344_7.z)

				local var_344_8 = var_344_0.localEulerAngles

				var_344_8.z = 0
				var_344_8.x = 0
				var_344_0.localEulerAngles = var_344_8
			end

			local var_344_9 = 0
			local var_344_10 = 0.625

			if var_344_9 < arg_341_1.time_ and arg_341_1.time_ <= var_344_9 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_11 = arg_341_1:GetWordFromCfg(1108503082)
				local var_344_12 = arg_341_1:FormatText(var_344_11.content)

				arg_341_1.text_.text = var_344_12

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_13 = 25
				local var_344_14 = utf8.len(var_344_12)
				local var_344_15 = var_344_13 <= 0 and var_344_10 or var_344_10 * (var_344_14 / var_344_13)

				if var_344_15 > 0 and var_344_10 < var_344_15 then
					arg_341_1.talkMaxDuration = var_344_15

					if var_344_15 + var_344_9 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_15 + var_344_9
					end
				end

				arg_341_1.text_.text = var_344_12
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_16 = math.max(var_344_10, arg_341_1.talkMaxDuration)

			if var_344_9 <= arg_341_1.time_ and arg_341_1.time_ < var_344_9 + var_344_16 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_9) / var_344_16

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_9 + var_344_16 and arg_341_1.time_ < var_344_9 + var_344_16 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
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

		arg_341_1:InitPlayNodeList()
	end,
	Play1108503083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 1108503083
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play1108503084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			local var_348_0 = 0
			local var_348_1 = 0.775

			if var_348_0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_0 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_2 = arg_345_1:GetWordFromCfg(1108503083)
				local var_348_3 = arg_345_1:FormatText(var_348_2.content)

				arg_345_1.text_.text = var_348_3

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_4 = 31
				local var_348_5 = utf8.len(var_348_3)
				local var_348_6 = var_348_4 <= 0 and var_348_1 or var_348_1 * (var_348_5 / var_348_4)

				if var_348_6 > 0 and var_348_1 < var_348_6 then
					arg_345_1.talkMaxDuration = var_348_6

					if var_348_6 + var_348_0 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_6 + var_348_0
					end
				end

				arg_345_1.text_.text = var_348_3
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_7 = math.max(var_348_1, arg_345_1.talkMaxDuration)

			if var_348_0 <= arg_345_1.time_ and arg_345_1.time_ < var_348_0 + var_348_7 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_0) / var_348_7

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_0 + var_348_7 and arg_345_1.time_ < var_348_0 + var_348_7 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play1108503084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 1108503084
		arg_349_1.duration_ = 9.4

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play1108503085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			local var_352_0 = arg_349_1.actors_["1085ui_story"].transform
			local var_352_1 = 0

			if var_352_1 < arg_349_1.time_ and arg_349_1.time_ <= var_352_1 + arg_352_0 then
				arg_349_1.var_.moveOldPos1085ui_story = var_352_0.localPosition
			end

			local var_352_2 = 0.001

			if var_352_1 <= arg_349_1.time_ and arg_349_1.time_ < var_352_1 + var_352_2 then
				local var_352_3 = (arg_349_1.time_ - var_352_1) / var_352_2
				local var_352_4 = Vector3.New(0, -1.01, -5.83)

				var_352_0.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos1085ui_story, var_352_4, var_352_3)

				local var_352_5 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_5.x, var_352_5.y, var_352_5.z)

				local var_352_6 = var_352_0.localEulerAngles

				var_352_6.z = 0
				var_352_6.x = 0
				var_352_0.localEulerAngles = var_352_6
			end

			if arg_349_1.time_ >= var_352_1 + var_352_2 and arg_349_1.time_ < var_352_1 + var_352_2 + arg_352_0 then
				var_352_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_352_7 = manager.ui.mainCamera.transform.position - var_352_0.position

				var_352_0.forward = Vector3.New(var_352_7.x, var_352_7.y, var_352_7.z)

				local var_352_8 = var_352_0.localEulerAngles

				var_352_8.z = 0
				var_352_8.x = 0
				var_352_0.localEulerAngles = var_352_8
			end

			local var_352_9 = arg_349_1.actors_["1085ui_story"]
			local var_352_10 = 0

			if var_352_10 < arg_349_1.time_ and arg_349_1.time_ <= var_352_10 + arg_352_0 and not isNil(var_352_9) and arg_349_1.var_.characterEffect1085ui_story == nil then
				arg_349_1.var_.characterEffect1085ui_story = var_352_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_11 = 0.200000002980232

			if var_352_10 <= arg_349_1.time_ and arg_349_1.time_ < var_352_10 + var_352_11 and not isNil(var_352_9) then
				local var_352_12 = (arg_349_1.time_ - var_352_10) / var_352_11

				if arg_349_1.var_.characterEffect1085ui_story and not isNil(var_352_9) then
					arg_349_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= var_352_10 + var_352_11 and arg_349_1.time_ < var_352_10 + var_352_11 + arg_352_0 and not isNil(var_352_9) and arg_349_1.var_.characterEffect1085ui_story then
				arg_349_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_352_13 = 0

			if var_352_13 < arg_349_1.time_ and arg_349_1.time_ <= var_352_13 + arg_352_0 then
				arg_349_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action5_1")
			end

			local var_352_14 = 0

			if var_352_14 < arg_349_1.time_ and arg_349_1.time_ <= var_352_14 + arg_352_0 then
				arg_349_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_352_15 = 0
			local var_352_16 = 0.85

			if var_352_15 < arg_349_1.time_ and arg_349_1.time_ <= var_352_15 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				local var_352_17 = arg_349_1:FormatText(StoryNameCfg[328].name)

				arg_349_1.leftNameTxt_.text = var_352_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_18 = arg_349_1:GetWordFromCfg(1108503084)
				local var_352_19 = arg_349_1:FormatText(var_352_18.content)

				arg_349_1.text_.text = var_352_19

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_20 = 34
				local var_352_21 = utf8.len(var_352_19)
				local var_352_22 = var_352_20 <= 0 and var_352_16 or var_352_16 * (var_352_21 / var_352_20)

				if var_352_22 > 0 and var_352_16 < var_352_22 then
					arg_349_1.talkMaxDuration = var_352_22

					if var_352_22 + var_352_15 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_22 + var_352_15
					end
				end

				arg_349_1.text_.text = var_352_19
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503084", "story_v_side_new_1108503.awb") ~= 0 then
					local var_352_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503084", "story_v_side_new_1108503.awb") / 1000

					if var_352_23 + var_352_15 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_23 + var_352_15
					end

					if var_352_18.prefab_name ~= "" and arg_349_1.actors_[var_352_18.prefab_name] ~= nil then
						local var_352_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_18.prefab_name].transform, "story_v_side_new_1108503", "1108503084", "story_v_side_new_1108503.awb")

						arg_349_1:RecordAudio("1108503084", var_352_24)
						arg_349_1:RecordAudio("1108503084", var_352_24)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503084", "story_v_side_new_1108503.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503084", "story_v_side_new_1108503.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_25 = math.max(var_352_16, arg_349_1.talkMaxDuration)

			if var_352_15 <= arg_349_1.time_ and arg_349_1.time_ < var_352_15 + var_352_25 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_15) / var_352_25

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_15 + var_352_25 and arg_349_1.time_ < var_352_15 + var_352_25 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
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

		arg_349_1:InitPlayNodeList()
	end,
	Play1108503085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 1108503085
		arg_353_1.duration_ = 6.7

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play1108503086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			local var_356_0 = 0
			local var_356_1 = 0.6

			if var_356_0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				local var_356_2 = arg_353_1:FormatText(StoryNameCfg[328].name)

				arg_353_1.leftNameTxt_.text = var_356_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_3 = arg_353_1:GetWordFromCfg(1108503085)
				local var_356_4 = arg_353_1:FormatText(var_356_3.content)

				arg_353_1.text_.text = var_356_4

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_5 = 24
				local var_356_6 = utf8.len(var_356_4)
				local var_356_7 = var_356_5 <= 0 and var_356_1 or var_356_1 * (var_356_6 / var_356_5)

				if var_356_7 > 0 and var_356_1 < var_356_7 then
					arg_353_1.talkMaxDuration = var_356_7

					if var_356_7 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_7 + var_356_0
					end
				end

				arg_353_1.text_.text = var_356_4
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503085", "story_v_side_new_1108503.awb") ~= 0 then
					local var_356_8 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503085", "story_v_side_new_1108503.awb") / 1000

					if var_356_8 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_8 + var_356_0
					end

					if var_356_3.prefab_name ~= "" and arg_353_1.actors_[var_356_3.prefab_name] ~= nil then
						local var_356_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_3.prefab_name].transform, "story_v_side_new_1108503", "1108503085", "story_v_side_new_1108503.awb")

						arg_353_1:RecordAudio("1108503085", var_356_9)
						arg_353_1:RecordAudio("1108503085", var_356_9)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503085", "story_v_side_new_1108503.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503085", "story_v_side_new_1108503.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_10 = math.max(var_356_1, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_10 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_0) / var_356_10

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_10 and arg_353_1.time_ < var_356_0 + var_356_10 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play1108503086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 1108503086
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play1108503087(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			local var_360_0 = arg_357_1.actors_["1085ui_story"].transform
			local var_360_1 = 0

			if var_360_1 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.var_.moveOldPos1085ui_story = var_360_0.localPosition
			end

			local var_360_2 = 0.001

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_2 then
				local var_360_3 = (arg_357_1.time_ - var_360_1) / var_360_2
				local var_360_4 = Vector3.New(0, 100, 0)

				var_360_0.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1085ui_story, var_360_4, var_360_3)

				local var_360_5 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_5.x, var_360_5.y, var_360_5.z)

				local var_360_6 = var_360_0.localEulerAngles

				var_360_6.z = 0
				var_360_6.x = 0
				var_360_0.localEulerAngles = var_360_6
			end

			if arg_357_1.time_ >= var_360_1 + var_360_2 and arg_357_1.time_ < var_360_1 + var_360_2 + arg_360_0 then
				var_360_0.localPosition = Vector3.New(0, 100, 0)

				local var_360_7 = manager.ui.mainCamera.transform.position - var_360_0.position

				var_360_0.forward = Vector3.New(var_360_7.x, var_360_7.y, var_360_7.z)

				local var_360_8 = var_360_0.localEulerAngles

				var_360_8.z = 0
				var_360_8.x = 0
				var_360_0.localEulerAngles = var_360_8
			end

			local var_360_9 = arg_357_1.actors_["1085ui_story"]
			local var_360_10 = 0

			if var_360_10 < arg_357_1.time_ and arg_357_1.time_ <= var_360_10 + arg_360_0 and not isNil(var_360_9) and arg_357_1.var_.characterEffect1085ui_story == nil then
				arg_357_1.var_.characterEffect1085ui_story = var_360_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_11 = 0.200000002980232

			if var_360_10 <= arg_357_1.time_ and arg_357_1.time_ < var_360_10 + var_360_11 and not isNil(var_360_9) then
				local var_360_12 = (arg_357_1.time_ - var_360_10) / var_360_11

				if arg_357_1.var_.characterEffect1085ui_story and not isNil(var_360_9) then
					local var_360_13 = Mathf.Lerp(0, 0.5, var_360_12)

					arg_357_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_357_1.var_.characterEffect1085ui_story.fillRatio = var_360_13
				end
			end

			if arg_357_1.time_ >= var_360_10 + var_360_11 and arg_357_1.time_ < var_360_10 + var_360_11 + arg_360_0 and not isNil(var_360_9) and arg_357_1.var_.characterEffect1085ui_story then
				local var_360_14 = 0.5

				arg_357_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_357_1.var_.characterEffect1085ui_story.fillRatio = var_360_14
			end

			local var_360_15 = 0
			local var_360_16 = 1.075

			if var_360_15 < arg_357_1.time_ and arg_357_1.time_ <= var_360_15 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, false)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_17 = arg_357_1:GetWordFromCfg(1108503086)
				local var_360_18 = arg_357_1:FormatText(var_360_17.content)

				arg_357_1.text_.text = var_360_18

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_19 = 43
				local var_360_20 = utf8.len(var_360_18)
				local var_360_21 = var_360_19 <= 0 and var_360_16 or var_360_16 * (var_360_20 / var_360_19)

				if var_360_21 > 0 and var_360_16 < var_360_21 then
					arg_357_1.talkMaxDuration = var_360_21

					if var_360_21 + var_360_15 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_21 + var_360_15
					end
				end

				arg_357_1.text_.text = var_360_18
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_22 = math.max(var_360_16, arg_357_1.talkMaxDuration)

			if var_360_15 <= arg_357_1.time_ and arg_357_1.time_ < var_360_15 + var_360_22 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_15) / var_360_22

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_15 + var_360_22 and arg_357_1.time_ < var_360_15 + var_360_22 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
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

		arg_357_1:InitPlayNodeList()
	end,
	Play1108503087 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 1108503087
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play1108503088(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			local var_364_0 = 0
			local var_364_1 = 0.925

			if var_364_0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_0 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_2 = arg_361_1:GetWordFromCfg(1108503087)
				local var_364_3 = arg_361_1:FormatText(var_364_2.content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_4 = 37
				local var_364_5 = utf8.len(var_364_3)
				local var_364_6 = var_364_4 <= 0 and var_364_1 or var_364_1 * (var_364_5 / var_364_4)

				if var_364_6 > 0 and var_364_1 < var_364_6 then
					arg_361_1.talkMaxDuration = var_364_6

					if var_364_6 + var_364_0 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_6 + var_364_0
					end
				end

				arg_361_1.text_.text = var_364_3
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_7 = math.max(var_364_1, arg_361_1.talkMaxDuration)

			if var_364_0 <= arg_361_1.time_ and arg_361_1.time_ < var_364_0 + var_364_7 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_0) / var_364_7

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_0 + var_364_7 and arg_361_1.time_ < var_364_0 + var_364_7 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play1108503088 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 1108503088
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play1108503089(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			local var_368_0 = 0
			local var_368_1 = 0.25

			if var_368_0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_0 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				local var_368_2 = arg_365_1:FormatText(StoryNameCfg[7].name)

				arg_365_1.leftNameTxt_.text = var_368_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, true)
				arg_365_1.iconController_:SetSelectedState("hero")

				arg_365_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_365_1.callingController_:SetSelectedState("normal")

				arg_365_1.keyicon_.color = Color.New(1, 1, 1)
				arg_365_1.icon_.color = Color.New(1, 1, 1)

				local var_368_3 = arg_365_1:GetWordFromCfg(1108503088)
				local var_368_4 = arg_365_1:FormatText(var_368_3.content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_5 = 10
				local var_368_6 = utf8.len(var_368_4)
				local var_368_7 = var_368_5 <= 0 and var_368_1 or var_368_1 * (var_368_6 / var_368_5)

				if var_368_7 > 0 and var_368_1 < var_368_7 then
					arg_365_1.talkMaxDuration = var_368_7

					if var_368_7 + var_368_0 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_7 + var_368_0
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_8 = math.max(var_368_1, arg_365_1.talkMaxDuration)

			if var_368_0 <= arg_365_1.time_ and arg_365_1.time_ < var_368_0 + var_368_8 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_0) / var_368_8

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_0 + var_368_8 and arg_365_1.time_ < var_368_0 + var_368_8 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play1108503089 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 1108503089
		arg_369_1.duration_ = 9

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play1108503090(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			local var_372_0 = "ST12"

			if arg_369_1.bgs_[var_372_0] == nil then
				local var_372_1 = Object.Instantiate(arg_369_1.paintGo_)

				var_372_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_372_0)
				var_372_1.name = var_372_0
				var_372_1.transform.parent = arg_369_1.stage_.transform
				var_372_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_369_1.bgs_[var_372_0] = var_372_1
			end

			local var_372_2 = 2

			if var_372_2 < arg_369_1.time_ and arg_369_1.time_ <= var_372_2 + arg_372_0 then
				local var_372_3 = manager.ui.mainCamera.transform.localPosition
				local var_372_4 = Vector3.New(0, 0, 10) + Vector3.New(var_372_3.x, var_372_3.y, 0)
				local var_372_5 = arg_369_1.bgs_.ST12

				var_372_5.transform.localPosition = var_372_4
				var_372_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_372_6 = var_372_5:GetComponent("SpriteRenderer")

				if var_372_6 and var_372_6.sprite then
					local var_372_7 = (var_372_5.transform.localPosition - var_372_3).z
					local var_372_8 = manager.ui.mainCameraCom_
					local var_372_9 = 2 * var_372_7 * Mathf.Tan(var_372_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_372_10 = var_372_9 * var_372_8.aspect
					local var_372_11 = var_372_6.sprite.bounds.size.x
					local var_372_12 = var_372_6.sprite.bounds.size.y
					local var_372_13 = var_372_10 / var_372_11
					local var_372_14 = var_372_9 / var_372_12
					local var_372_15 = var_372_14 < var_372_13 and var_372_13 or var_372_14

					var_372_5.transform.localScale = Vector3.New(var_372_15, var_372_15, 0)
				end

				for iter_372_0, iter_372_1 in pairs(arg_369_1.bgs_) do
					if iter_372_0 ~= "ST12" then
						iter_372_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_372_16 = 4

			if var_372_16 < arg_369_1.time_ and arg_369_1.time_ <= var_372_16 + arg_372_0 then
				arg_369_1.allBtn_.enabled = false
			end

			local var_372_17 = 0.3

			if arg_369_1.time_ >= var_372_16 + var_372_17 and arg_369_1.time_ < var_372_16 + var_372_17 + arg_372_0 then
				arg_369_1.allBtn_.enabled = true
			end

			local var_372_18 = 0

			if var_372_18 < arg_369_1.time_ and arg_369_1.time_ <= var_372_18 + arg_372_0 then
				arg_369_1.mask_.enabled = true
				arg_369_1.mask_.raycastTarget = true

				arg_369_1:SetGaussion(false)
			end

			local var_372_19 = 2

			if var_372_18 <= arg_369_1.time_ and arg_369_1.time_ < var_372_18 + var_372_19 then
				local var_372_20 = (arg_369_1.time_ - var_372_18) / var_372_19
				local var_372_21 = Color.New(0, 0, 0)

				var_372_21.a = Mathf.Lerp(0, 1, var_372_20)
				arg_369_1.mask_.color = var_372_21
			end

			if arg_369_1.time_ >= var_372_18 + var_372_19 and arg_369_1.time_ < var_372_18 + var_372_19 + arg_372_0 then
				local var_372_22 = Color.New(0, 0, 0)

				var_372_22.a = 1
				arg_369_1.mask_.color = var_372_22
			end

			local var_372_23 = 2

			if var_372_23 < arg_369_1.time_ and arg_369_1.time_ <= var_372_23 + arg_372_0 then
				arg_369_1.mask_.enabled = true
				arg_369_1.mask_.raycastTarget = true

				arg_369_1:SetGaussion(false)
			end

			local var_372_24 = 2

			if var_372_23 <= arg_369_1.time_ and arg_369_1.time_ < var_372_23 + var_372_24 then
				local var_372_25 = (arg_369_1.time_ - var_372_23) / var_372_24
				local var_372_26 = Color.New(0, 0, 0)

				var_372_26.a = Mathf.Lerp(1, 0, var_372_25)
				arg_369_1.mask_.color = var_372_26
			end

			if arg_369_1.time_ >= var_372_23 + var_372_24 and arg_369_1.time_ < var_372_23 + var_372_24 + arg_372_0 then
				local var_372_27 = Color.New(0, 0, 0)
				local var_372_28 = 0

				arg_369_1.mask_.enabled = false
				var_372_27.a = var_372_28
				arg_369_1.mask_.color = var_372_27
			end

			local var_372_29 = 0.366666666666667
			local var_372_30 = 0.3

			if var_372_29 < arg_369_1.time_ and arg_369_1.time_ <= var_372_29 + arg_372_0 then
				local var_372_31 = "play"
				local var_372_32 = "music"

				arg_369_1:AudioAction(var_372_31, var_372_32, "ui_battle", "ui_battle_stopbgm", "")

				local var_372_33 = ""
				local var_372_34 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_372_34 ~= "" then
					if arg_369_1.bgmTxt_.text ~= var_372_34 and arg_369_1.bgmTxt_.text ~= "" then
						if arg_369_1.bgmTxt2_.text ~= "" then
							arg_369_1.bgmTxt_.text = arg_369_1.bgmTxt2_.text
						end

						arg_369_1.bgmTxt2_.text = var_372_34

						arg_369_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_369_1.bgmTxt_.text = var_372_34
						arg_369_1.bgmTxt2_.text = var_372_34
					end

					if arg_369_1.bgmTimer then
						arg_369_1.bgmTimer:Stop()

						arg_369_1.bgmTimer = nil
					end

					if arg_369_1.settingData.show_music_name == 1 then
						arg_369_1.musicController:SetSelectedState("show")
						arg_369_1.musicAnimator_:Play("open", 0, 0)

						if arg_369_1.settingData.music_time ~= 0 then
							arg_369_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_369_1.settingData.music_time), function()
								if arg_369_1 == nil or isNil(arg_369_1.bgmTxt_) then
									return
								end

								arg_369_1.musicController:SetSelectedState("hide")
								arg_369_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_369_1.frameCnt_ <= 1 then
				arg_369_1.dialog_:SetActive(false)
			end

			local var_372_35 = 4
			local var_372_36 = 0.675

			if var_372_35 < arg_369_1.time_ and arg_369_1.time_ <= var_372_35 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0

				arg_369_1.dialog_:SetActive(true)

				arg_369_1.dialogCg_.alpha = 0

				local var_372_37 = LeanTween.value(arg_369_1.dialog_, 0, 1, 0.3)

				var_372_37:setOnUpdate(LuaHelper.FloatAction(function(arg_374_0)
					arg_369_1.dialogCg_.alpha = arg_374_0
				end))
				var_372_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_369_1.dialog_)
					var_372_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_369_1.duration_ = arg_369_1.duration_ + 0.3

				SetActive(arg_369_1.leftNameGo_, false)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_38 = arg_369_1:GetWordFromCfg(1108503089)
				local var_372_39 = arg_369_1:FormatText(var_372_38.content)

				arg_369_1.text_.text = var_372_39

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_40 = 27
				local var_372_41 = utf8.len(var_372_39)
				local var_372_42 = var_372_40 <= 0 and var_372_36 or var_372_36 * (var_372_41 / var_372_40)

				if var_372_42 > 0 and var_372_36 < var_372_42 then
					arg_369_1.talkMaxDuration = var_372_42
					var_372_35 = var_372_35 + 0.3

					if var_372_42 + var_372_35 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_42 + var_372_35
					end
				end

				arg_369_1.text_.text = var_372_39
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_43 = var_372_35 + 0.3
			local var_372_44 = math.max(var_372_36, arg_369_1.talkMaxDuration)

			if var_372_43 <= arg_369_1.time_ and arg_369_1.time_ < var_372_43 + var_372_44 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_43) / var_372_44

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_43 + var_372_44 and arg_369_1.time_ < var_372_43 + var_372_44 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play1108503090 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 1108503090
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play1108503091(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0
			local var_379_1 = 1.2

			if var_379_0 < arg_376_1.time_ and arg_376_1.time_ <= var_379_0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, false)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_2 = arg_376_1:GetWordFromCfg(1108503090)
				local var_379_3 = arg_376_1:FormatText(var_379_2.content)

				arg_376_1.text_.text = var_379_3

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_4 = 48
				local var_379_5 = utf8.len(var_379_3)
				local var_379_6 = var_379_4 <= 0 and var_379_1 or var_379_1 * (var_379_5 / var_379_4)

				if var_379_6 > 0 and var_379_1 < var_379_6 then
					arg_376_1.talkMaxDuration = var_379_6

					if var_379_6 + var_379_0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_6 + var_379_0
					end
				end

				arg_376_1.text_.text = var_379_3
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_7 = math.max(var_379_1, arg_376_1.talkMaxDuration)

			if var_379_0 <= arg_376_1.time_ and arg_376_1.time_ < var_379_0 + var_379_7 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_0) / var_379_7

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_0 + var_379_7 and arg_376_1.time_ < var_379_0 + var_379_7 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play1108503091 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 1108503091
		arg_380_1.duration_ = 10.27

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play1108503092(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = "A00"

			if arg_380_1.bgs_[var_383_0] == nil then
				local var_383_1 = Object.Instantiate(arg_380_1.paintGo_)

				var_383_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_383_0)
				var_383_1.name = var_383_0
				var_383_1.transform.parent = arg_380_1.stage_.transform
				var_383_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_380_1.bgs_[var_383_0] = var_383_1
			end

			local var_383_2 = 2

			if var_383_2 < arg_380_1.time_ and arg_380_1.time_ <= var_383_2 + arg_383_0 then
				local var_383_3 = manager.ui.mainCamera.transform.localPosition
				local var_383_4 = Vector3.New(0, 0, 10) + Vector3.New(var_383_3.x, var_383_3.y, 0)
				local var_383_5 = arg_380_1.bgs_.A00

				var_383_5.transform.localPosition = var_383_4
				var_383_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_383_6 = var_383_5:GetComponent("SpriteRenderer")

				if var_383_6 and var_383_6.sprite then
					local var_383_7 = (var_383_5.transform.localPosition - var_383_3).z
					local var_383_8 = manager.ui.mainCameraCom_
					local var_383_9 = 2 * var_383_7 * Mathf.Tan(var_383_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_383_10 = var_383_9 * var_383_8.aspect
					local var_383_11 = var_383_6.sprite.bounds.size.x
					local var_383_12 = var_383_6.sprite.bounds.size.y
					local var_383_13 = var_383_10 / var_383_11
					local var_383_14 = var_383_9 / var_383_12
					local var_383_15 = var_383_14 < var_383_13 and var_383_13 or var_383_14

					var_383_5.transform.localScale = Vector3.New(var_383_15, var_383_15, 0)
				end

				for iter_383_0, iter_383_1 in pairs(arg_380_1.bgs_) do
					if iter_383_0 ~= "A00" then
						iter_383_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_383_16 = 4

			if var_383_16 < arg_380_1.time_ and arg_380_1.time_ <= var_383_16 + arg_383_0 then
				arg_380_1.allBtn_.enabled = false
			end

			local var_383_17 = 0.3

			if arg_380_1.time_ >= var_383_16 + var_383_17 and arg_380_1.time_ < var_383_16 + var_383_17 + arg_383_0 then
				arg_380_1.allBtn_.enabled = true
			end

			local var_383_18 = 0

			if var_383_18 < arg_380_1.time_ and arg_380_1.time_ <= var_383_18 + arg_383_0 then
				arg_380_1.mask_.enabled = true
				arg_380_1.mask_.raycastTarget = true

				arg_380_1:SetGaussion(false)
			end

			local var_383_19 = 2

			if var_383_18 <= arg_380_1.time_ and arg_380_1.time_ < var_383_18 + var_383_19 then
				local var_383_20 = (arg_380_1.time_ - var_383_18) / var_383_19
				local var_383_21 = Color.New(0, 0, 0)

				var_383_21.a = Mathf.Lerp(0, 1, var_383_20)
				arg_380_1.mask_.color = var_383_21
			end

			if arg_380_1.time_ >= var_383_18 + var_383_19 and arg_380_1.time_ < var_383_18 + var_383_19 + arg_383_0 then
				local var_383_22 = Color.New(0, 0, 0)

				var_383_22.a = 1
				arg_380_1.mask_.color = var_383_22
			end

			local var_383_23 = 2

			if var_383_23 < arg_380_1.time_ and arg_380_1.time_ <= var_383_23 + arg_383_0 then
				arg_380_1.mask_.enabled = true
				arg_380_1.mask_.raycastTarget = true

				arg_380_1:SetGaussion(false)
			end

			local var_383_24 = 2

			if var_383_23 <= arg_380_1.time_ and arg_380_1.time_ < var_383_23 + var_383_24 then
				local var_383_25 = (arg_380_1.time_ - var_383_23) / var_383_24
				local var_383_26 = Color.New(0, 0, 0)

				var_383_26.a = Mathf.Lerp(1, 0, var_383_25)
				arg_380_1.mask_.color = var_383_26
			end

			if arg_380_1.time_ >= var_383_23 + var_383_24 and arg_380_1.time_ < var_383_23 + var_383_24 + arg_383_0 then
				local var_383_27 = Color.New(0, 0, 0)
				local var_383_28 = 0

				arg_380_1.mask_.enabled = false
				var_383_27.a = var_383_28
				arg_380_1.mask_.color = var_383_27
			end

			local var_383_29 = "1083ui_story"

			if arg_380_1.actors_[var_383_29] == nil then
				local var_383_30 = Asset.Load("Char/" .. "1083ui_story")

				if not isNil(var_383_30) then
					local var_383_31 = Object.Instantiate(Asset.Load("Char/" .. "1083ui_story"), arg_380_1.stage_.transform)

					var_383_31.name = var_383_29
					var_383_31.transform.localPosition = Vector3.New(0, 100, 0)
					arg_380_1.actors_[var_383_29] = var_383_31

					local var_383_32 = var_383_31:GetComponentInChildren(typeof(CharacterEffect))

					var_383_32.enabled = true

					local var_383_33 = GameObjectTools.GetOrAddComponent(var_383_31, typeof(DynamicBoneHelper))

					if var_383_33 then
						var_383_33:EnableDynamicBone(false)
					end

					arg_380_1:ShowWeapon(var_383_32.transform, false)

					arg_380_1.var_[var_383_29 .. "Animator"] = var_383_32.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_380_1.var_[var_383_29 .. "Animator"].applyRootMotion = true
					arg_380_1.var_[var_383_29 .. "LipSync"] = var_383_32.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_383_34 = arg_380_1.actors_["1083ui_story"].transform
			local var_383_35 = 3.8

			if var_383_35 < arg_380_1.time_ and arg_380_1.time_ <= var_383_35 + arg_383_0 then
				arg_380_1.var_.moveOldPos1083ui_story = var_383_34.localPosition
			end

			local var_383_36 = 0.001

			if var_383_35 <= arg_380_1.time_ and arg_380_1.time_ < var_383_35 + var_383_36 then
				local var_383_37 = (arg_380_1.time_ - var_383_35) / var_383_36
				local var_383_38 = Vector3.New(0, -1.05, -6)

				var_383_34.localPosition = Vector3.Lerp(arg_380_1.var_.moveOldPos1083ui_story, var_383_38, var_383_37)

				local var_383_39 = manager.ui.mainCamera.transform.position - var_383_34.position

				var_383_34.forward = Vector3.New(var_383_39.x, var_383_39.y, var_383_39.z)

				local var_383_40 = var_383_34.localEulerAngles

				var_383_40.z = 0
				var_383_40.x = 0
				var_383_34.localEulerAngles = var_383_40
			end

			if arg_380_1.time_ >= var_383_35 + var_383_36 and arg_380_1.time_ < var_383_35 + var_383_36 + arg_383_0 then
				var_383_34.localPosition = Vector3.New(0, -1.05, -6)

				local var_383_41 = manager.ui.mainCamera.transform.position - var_383_34.position

				var_383_34.forward = Vector3.New(var_383_41.x, var_383_41.y, var_383_41.z)

				local var_383_42 = var_383_34.localEulerAngles

				var_383_42.z = 0
				var_383_42.x = 0
				var_383_34.localEulerAngles = var_383_42
			end

			local var_383_43 = arg_380_1.actors_["1083ui_story"]
			local var_383_44 = 3.8

			if var_383_44 < arg_380_1.time_ and arg_380_1.time_ <= var_383_44 + arg_383_0 and not isNil(var_383_43) and arg_380_1.var_.characterEffect1083ui_story == nil then
				arg_380_1.var_.characterEffect1083ui_story = var_383_43:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_45 = 0.200000002980232

			if var_383_44 <= arg_380_1.time_ and arg_380_1.time_ < var_383_44 + var_383_45 and not isNil(var_383_43) then
				local var_383_46 = (arg_380_1.time_ - var_383_44) / var_383_45

				if arg_380_1.var_.characterEffect1083ui_story and not isNil(var_383_43) then
					arg_380_1.var_.characterEffect1083ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= var_383_44 + var_383_45 and arg_380_1.time_ < var_383_44 + var_383_45 + arg_383_0 and not isNil(var_383_43) and arg_380_1.var_.characterEffect1083ui_story then
				arg_380_1.var_.characterEffect1083ui_story.fillFlat = false
			end

			local var_383_47 = 3.8

			if var_383_47 < arg_380_1.time_ and arg_380_1.time_ <= var_383_47 + arg_383_0 then
				arg_380_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action5_1")
			end

			local var_383_48 = 3.8

			if var_383_48 < arg_380_1.time_ and arg_380_1.time_ <= var_383_48 + arg_383_0 then
				arg_380_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_383_49 = 0.366666666666667
			local var_383_50 = 0.3

			if var_383_49 < arg_380_1.time_ and arg_380_1.time_ <= var_383_49 + arg_383_0 then
				local var_383_51 = "play"
				local var_383_52 = "music"

				arg_380_1:AudioAction(var_383_51, var_383_52, "ui_battle", "ui_battle_stopbgm", "")

				local var_383_53 = ""
				local var_383_54 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_383_54 ~= "" then
					if arg_380_1.bgmTxt_.text ~= var_383_54 and arg_380_1.bgmTxt_.text ~= "" then
						if arg_380_1.bgmTxt2_.text ~= "" then
							arg_380_1.bgmTxt_.text = arg_380_1.bgmTxt2_.text
						end

						arg_380_1.bgmTxt2_.text = var_383_54

						arg_380_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_380_1.bgmTxt_.text = var_383_54
						arg_380_1.bgmTxt2_.text = var_383_54
					end

					if arg_380_1.bgmTimer then
						arg_380_1.bgmTimer:Stop()

						arg_380_1.bgmTimer = nil
					end

					if arg_380_1.settingData.show_music_name == 1 then
						arg_380_1.musicController:SetSelectedState("show")
						arg_380_1.musicAnimator_:Play("open", 0, 0)

						if arg_380_1.settingData.music_time ~= 0 then
							arg_380_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_380_1.settingData.music_time), function()
								if arg_380_1 == nil or isNil(arg_380_1.bgmTxt_) then
									return
								end

								arg_380_1.musicController:SetSelectedState("hide")
								arg_380_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_383_55 = 1.8
			local var_383_56 = 1

			if var_383_55 < arg_380_1.time_ and arg_380_1.time_ <= var_383_55 + arg_383_0 then
				local var_383_57 = "play"
				local var_383_58 = "music"

				arg_380_1:AudioAction(var_383_57, var_383_58, "bgm_side_daily05", "bgm_side_daily05", "bgm_side_daily05.awb")

				local var_383_59 = ""
				local var_383_60 = manager.audio:GetAudioName("bgm_side_daily05", "bgm_side_daily05")

				if var_383_60 ~= "" then
					if arg_380_1.bgmTxt_.text ~= var_383_60 and arg_380_1.bgmTxt_.text ~= "" then
						if arg_380_1.bgmTxt2_.text ~= "" then
							arg_380_1.bgmTxt_.text = arg_380_1.bgmTxt2_.text
						end

						arg_380_1.bgmTxt2_.text = var_383_60

						arg_380_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_380_1.bgmTxt_.text = var_383_60
						arg_380_1.bgmTxt2_.text = var_383_60
					end

					if arg_380_1.bgmTimer then
						arg_380_1.bgmTimer:Stop()

						arg_380_1.bgmTimer = nil
					end

					if arg_380_1.settingData.show_music_name == 1 then
						arg_380_1.musicController:SetSelectedState("show")
						arg_380_1.musicAnimator_:Play("open", 0, 0)

						if arg_380_1.settingData.music_time ~= 0 then
							arg_380_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_380_1.settingData.music_time), function()
								if arg_380_1 == nil or isNil(arg_380_1.bgmTxt_) then
									return
								end

								arg_380_1.musicController:SetSelectedState("hide")
								arg_380_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_383_61 = 0.366666666666667
			local var_383_62 = 1

			if var_383_61 < arg_380_1.time_ and arg_380_1.time_ <= var_383_61 + arg_383_0 then
				local var_383_63 = "stop"
				local var_383_64 = "effect"

				arg_380_1:AudioAction(var_383_63, var_383_64, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			local var_383_65 = 1.8
			local var_383_66 = 1

			if var_383_65 < arg_380_1.time_ and arg_380_1.time_ <= var_383_65 + arg_383_0 then
				local var_383_67 = "play"
				local var_383_68 = "effect"

				arg_380_1:AudioAction(var_383_67, var_383_68, "se_story_142", "se_story_142_amb_commandroom", "")
			end

			if arg_380_1.frameCnt_ <= 1 then
				arg_380_1.dialog_:SetActive(false)
			end

			local var_383_69 = 4
			local var_383_70 = 0.65

			if var_383_69 < arg_380_1.time_ and arg_380_1.time_ <= var_383_69 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0

				arg_380_1.dialog_:SetActive(true)

				arg_380_1.dialogCg_.alpha = 0

				local var_383_71 = LeanTween.value(arg_380_1.dialog_, 0, 1, 0.3)

				var_383_71:setOnUpdate(LuaHelper.FloatAction(function(arg_386_0)
					arg_380_1.dialogCg_.alpha = arg_386_0
				end))
				var_383_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_380_1.dialog_)
					var_383_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_380_1.duration_ = arg_380_1.duration_ + 0.3

				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_72 = arg_380_1:FormatText(StoryNameCfg[1332].name)

				arg_380_1.leftNameTxt_.text = var_383_72

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_73 = arg_380_1:GetWordFromCfg(1108503091)
				local var_383_74 = arg_380_1:FormatText(var_383_73.content)

				arg_380_1.text_.text = var_383_74

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_75 = 26
				local var_383_76 = utf8.len(var_383_74)
				local var_383_77 = var_383_75 <= 0 and var_383_70 or var_383_70 * (var_383_76 / var_383_75)

				if var_383_77 > 0 and var_383_70 < var_383_77 then
					arg_380_1.talkMaxDuration = var_383_77
					var_383_69 = var_383_69 + 0.3

					if var_383_77 + var_383_69 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_77 + var_383_69
					end
				end

				arg_380_1.text_.text = var_383_74
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503091", "story_v_side_new_1108503.awb") ~= 0 then
					local var_383_78 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503091", "story_v_side_new_1108503.awb") / 1000

					if var_383_78 + var_383_69 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_78 + var_383_69
					end

					if var_383_73.prefab_name ~= "" and arg_380_1.actors_[var_383_73.prefab_name] ~= nil then
						local var_383_79 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_73.prefab_name].transform, "story_v_side_new_1108503", "1108503091", "story_v_side_new_1108503.awb")

						arg_380_1:RecordAudio("1108503091", var_383_79)
						arg_380_1:RecordAudio("1108503091", var_383_79)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503091", "story_v_side_new_1108503.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503091", "story_v_side_new_1108503.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_80 = var_383_69 + 0.3
			local var_383_81 = math.max(var_383_70, arg_380_1.talkMaxDuration)

			if var_383_80 <= arg_380_1.time_ and arg_380_1.time_ < var_383_80 + var_383_81 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_80) / var_383_81

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_80 + var_383_81 and arg_380_1.time_ < var_383_80 + var_383_81 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_380_1:InitPlayNodeList()
	end,
	Play1108503092 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 1108503092
		arg_388_1.duration_ = 9.33

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play1108503093(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = arg_388_1.actors_["1083ui_story"].transform
			local var_391_1 = 0

			if var_391_1 < arg_388_1.time_ and arg_388_1.time_ <= var_391_1 + arg_391_0 then
				arg_388_1.var_.moveOldPos1083ui_story = var_391_0.localPosition
			end

			local var_391_2 = 0.001

			if var_391_1 <= arg_388_1.time_ and arg_388_1.time_ < var_391_1 + var_391_2 then
				local var_391_3 = (arg_388_1.time_ - var_391_1) / var_391_2
				local var_391_4 = Vector3.New(0, -1.05, -6)

				var_391_0.localPosition = Vector3.Lerp(arg_388_1.var_.moveOldPos1083ui_story, var_391_4, var_391_3)

				local var_391_5 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_5.x, var_391_5.y, var_391_5.z)

				local var_391_6 = var_391_0.localEulerAngles

				var_391_6.z = 0
				var_391_6.x = 0
				var_391_0.localEulerAngles = var_391_6
			end

			if arg_388_1.time_ >= var_391_1 + var_391_2 and arg_388_1.time_ < var_391_1 + var_391_2 + arg_391_0 then
				var_391_0.localPosition = Vector3.New(0, -1.05, -6)

				local var_391_7 = manager.ui.mainCamera.transform.position - var_391_0.position

				var_391_0.forward = Vector3.New(var_391_7.x, var_391_7.y, var_391_7.z)

				local var_391_8 = var_391_0.localEulerAngles

				var_391_8.z = 0
				var_391_8.x = 0
				var_391_0.localEulerAngles = var_391_8
			end

			local var_391_9 = 0

			if var_391_9 < arg_388_1.time_ and arg_388_1.time_ <= var_391_9 + arg_391_0 then
				arg_388_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083actionlink/1083action452")
			end

			local var_391_10 = 0

			if var_391_10 < arg_388_1.time_ and arg_388_1.time_ <= var_391_10 + arg_391_0 then
				arg_388_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_391_11 = 0
			local var_391_12 = 1.1

			if var_391_11 < arg_388_1.time_ and arg_388_1.time_ <= var_391_11 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				local var_391_13 = arg_388_1:FormatText(StoryNameCfg[1332].name)

				arg_388_1.leftNameTxt_.text = var_391_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_14 = arg_388_1:GetWordFromCfg(1108503092)
				local var_391_15 = arg_388_1:FormatText(var_391_14.content)

				arg_388_1.text_.text = var_391_15

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_16 = 44
				local var_391_17 = utf8.len(var_391_15)
				local var_391_18 = var_391_16 <= 0 and var_391_12 or var_391_12 * (var_391_17 / var_391_16)

				if var_391_18 > 0 and var_391_12 < var_391_18 then
					arg_388_1.talkMaxDuration = var_391_18

					if var_391_18 + var_391_11 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_18 + var_391_11
					end
				end

				arg_388_1.text_.text = var_391_15
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503092", "story_v_side_new_1108503.awb") ~= 0 then
					local var_391_19 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503092", "story_v_side_new_1108503.awb") / 1000

					if var_391_19 + var_391_11 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_19 + var_391_11
					end

					if var_391_14.prefab_name ~= "" and arg_388_1.actors_[var_391_14.prefab_name] ~= nil then
						local var_391_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_14.prefab_name].transform, "story_v_side_new_1108503", "1108503092", "story_v_side_new_1108503.awb")

						arg_388_1:RecordAudio("1108503092", var_391_20)
						arg_388_1:RecordAudio("1108503092", var_391_20)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503092", "story_v_side_new_1108503.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503092", "story_v_side_new_1108503.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_21 = math.max(var_391_12, arg_388_1.talkMaxDuration)

			if var_391_11 <= arg_388_1.time_ and arg_388_1.time_ < var_391_11 + var_391_21 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_11) / var_391_21

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_11 + var_391_21 and arg_388_1.time_ < var_391_11 + var_391_21 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
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
	Play1108503093 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 1108503093
		arg_392_1.duration_ = 3.17

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play1108503094(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = arg_392_1.actors_["1085ui_story"].transform
			local var_395_1 = 0

			if var_395_1 < arg_392_1.time_ and arg_392_1.time_ <= var_395_1 + arg_395_0 then
				arg_392_1.var_.moveOldPos1085ui_story = var_395_0.localPosition
			end

			local var_395_2 = 0.001

			if var_395_1 <= arg_392_1.time_ and arg_392_1.time_ < var_395_1 + var_395_2 then
				local var_395_3 = (arg_392_1.time_ - var_395_1) / var_395_2
				local var_395_4 = Vector3.New(0.75, -1.01, -5.83)

				var_395_0.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1085ui_story, var_395_4, var_395_3)

				local var_395_5 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_5.x, var_395_5.y, var_395_5.z)

				local var_395_6 = var_395_0.localEulerAngles

				var_395_6.z = 0
				var_395_6.x = 0
				var_395_0.localEulerAngles = var_395_6
			end

			if arg_392_1.time_ >= var_395_1 + var_395_2 and arg_392_1.time_ < var_395_1 + var_395_2 + arg_395_0 then
				var_395_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_395_7 = manager.ui.mainCamera.transform.position - var_395_0.position

				var_395_0.forward = Vector3.New(var_395_7.x, var_395_7.y, var_395_7.z)

				local var_395_8 = var_395_0.localEulerAngles

				var_395_8.z = 0
				var_395_8.x = 0
				var_395_0.localEulerAngles = var_395_8
			end

			local var_395_9 = arg_392_1.actors_["1083ui_story"].transform
			local var_395_10 = 0

			if var_395_10 < arg_392_1.time_ and arg_392_1.time_ <= var_395_10 + arg_395_0 then
				arg_392_1.var_.moveOldPos1083ui_story = var_395_9.localPosition
			end

			local var_395_11 = 0.001

			if var_395_10 <= arg_392_1.time_ and arg_392_1.time_ < var_395_10 + var_395_11 then
				local var_395_12 = (arg_392_1.time_ - var_395_10) / var_395_11
				local var_395_13 = Vector3.New(-0.7, -1.05, -6)

				var_395_9.localPosition = Vector3.Lerp(arg_392_1.var_.moveOldPos1083ui_story, var_395_13, var_395_12)

				local var_395_14 = manager.ui.mainCamera.transform.position - var_395_9.position

				var_395_9.forward = Vector3.New(var_395_14.x, var_395_14.y, var_395_14.z)

				local var_395_15 = var_395_9.localEulerAngles

				var_395_15.z = 0
				var_395_15.x = 0
				var_395_9.localEulerAngles = var_395_15
			end

			if arg_392_1.time_ >= var_395_10 + var_395_11 and arg_392_1.time_ < var_395_10 + var_395_11 + arg_395_0 then
				var_395_9.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_395_16 = manager.ui.mainCamera.transform.position - var_395_9.position

				var_395_9.forward = Vector3.New(var_395_16.x, var_395_16.y, var_395_16.z)

				local var_395_17 = var_395_9.localEulerAngles

				var_395_17.z = 0
				var_395_17.x = 0
				var_395_9.localEulerAngles = var_395_17
			end

			local var_395_18 = arg_392_1.actors_["1085ui_story"]
			local var_395_19 = 0

			if var_395_19 < arg_392_1.time_ and arg_392_1.time_ <= var_395_19 + arg_395_0 and not isNil(var_395_18) and arg_392_1.var_.characterEffect1085ui_story == nil then
				arg_392_1.var_.characterEffect1085ui_story = var_395_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_20 = 0.200000002980232

			if var_395_19 <= arg_392_1.time_ and arg_392_1.time_ < var_395_19 + var_395_20 and not isNil(var_395_18) then
				local var_395_21 = (arg_392_1.time_ - var_395_19) / var_395_20

				if arg_392_1.var_.characterEffect1085ui_story and not isNil(var_395_18) then
					arg_392_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_392_1.time_ >= var_395_19 + var_395_20 and arg_392_1.time_ < var_395_19 + var_395_20 + arg_395_0 and not isNil(var_395_18) and arg_392_1.var_.characterEffect1085ui_story then
				arg_392_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_395_22 = arg_392_1.actors_["1083ui_story"]
			local var_395_23 = 0

			if var_395_23 < arg_392_1.time_ and arg_392_1.time_ <= var_395_23 + arg_395_0 and not isNil(var_395_22) and arg_392_1.var_.characterEffect1083ui_story == nil then
				arg_392_1.var_.characterEffect1083ui_story = var_395_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_395_24 = 0.200000002980232

			if var_395_23 <= arg_392_1.time_ and arg_392_1.time_ < var_395_23 + var_395_24 and not isNil(var_395_22) then
				local var_395_25 = (arg_392_1.time_ - var_395_23) / var_395_24

				if arg_392_1.var_.characterEffect1083ui_story and not isNil(var_395_22) then
					local var_395_26 = Mathf.Lerp(0, 0.5, var_395_25)

					arg_392_1.var_.characterEffect1083ui_story.fillFlat = true
					arg_392_1.var_.characterEffect1083ui_story.fillRatio = var_395_26
				end
			end

			if arg_392_1.time_ >= var_395_23 + var_395_24 and arg_392_1.time_ < var_395_23 + var_395_24 + arg_395_0 and not isNil(var_395_22) and arg_392_1.var_.characterEffect1083ui_story then
				local var_395_27 = 0.5

				arg_392_1.var_.characterEffect1083ui_story.fillFlat = true
				arg_392_1.var_.characterEffect1083ui_story.fillRatio = var_395_27
			end

			local var_395_28 = 0

			if var_395_28 < arg_392_1.time_ and arg_392_1.time_ <= var_395_28 + arg_395_0 then
				arg_392_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action1_1")
			end

			local var_395_29 = 0

			if var_395_29 < arg_392_1.time_ and arg_392_1.time_ <= var_395_29 + arg_395_0 then
				arg_392_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_395_30 = 0
			local var_395_31 = 0.325

			if var_395_30 < arg_392_1.time_ and arg_392_1.time_ <= var_395_30 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_32 = arg_392_1:FormatText(StoryNameCfg[328].name)

				arg_392_1.leftNameTxt_.text = var_395_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_33 = arg_392_1:GetWordFromCfg(1108503093)
				local var_395_34 = arg_392_1:FormatText(var_395_33.content)

				arg_392_1.text_.text = var_395_34

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_35 = 13
				local var_395_36 = utf8.len(var_395_34)
				local var_395_37 = var_395_35 <= 0 and var_395_31 or var_395_31 * (var_395_36 / var_395_35)

				if var_395_37 > 0 and var_395_31 < var_395_37 then
					arg_392_1.talkMaxDuration = var_395_37

					if var_395_37 + var_395_30 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_37 + var_395_30
					end
				end

				arg_392_1.text_.text = var_395_34
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503093", "story_v_side_new_1108503.awb") ~= 0 then
					local var_395_38 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503093", "story_v_side_new_1108503.awb") / 1000

					if var_395_38 + var_395_30 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_38 + var_395_30
					end

					if var_395_33.prefab_name ~= "" and arg_392_1.actors_[var_395_33.prefab_name] ~= nil then
						local var_395_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_33.prefab_name].transform, "story_v_side_new_1108503", "1108503093", "story_v_side_new_1108503.awb")

						arg_392_1:RecordAudio("1108503093", var_395_39)
						arg_392_1:RecordAudio("1108503093", var_395_39)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503093", "story_v_side_new_1108503.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503093", "story_v_side_new_1108503.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_40 = math.max(var_395_31, arg_392_1.talkMaxDuration)

			if var_395_30 <= arg_392_1.time_ and arg_392_1.time_ < var_395_30 + var_395_40 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_30) / var_395_40

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_30 + var_395_40 and arg_392_1.time_ < var_395_30 + var_395_40 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1083ui_story",
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
	Play1108503094 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 1108503094
		arg_396_1.duration_ = 7.3

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play1108503095(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = arg_396_1.actors_["1083ui_story"].transform
			local var_399_1 = 0

			if var_399_1 < arg_396_1.time_ and arg_396_1.time_ <= var_399_1 + arg_399_0 then
				arg_396_1.var_.moveOldPos1083ui_story = var_399_0.localPosition
			end

			local var_399_2 = 0.001

			if var_399_1 <= arg_396_1.time_ and arg_396_1.time_ < var_399_1 + var_399_2 then
				local var_399_3 = (arg_396_1.time_ - var_399_1) / var_399_2
				local var_399_4 = Vector3.New(-0.7, -1.05, -6)

				var_399_0.localPosition = Vector3.Lerp(arg_396_1.var_.moveOldPos1083ui_story, var_399_4, var_399_3)

				local var_399_5 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_5.x, var_399_5.y, var_399_5.z)

				local var_399_6 = var_399_0.localEulerAngles

				var_399_6.z = 0
				var_399_6.x = 0
				var_399_0.localEulerAngles = var_399_6
			end

			if arg_396_1.time_ >= var_399_1 + var_399_2 and arg_396_1.time_ < var_399_1 + var_399_2 + arg_399_0 then
				var_399_0.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_399_7 = manager.ui.mainCamera.transform.position - var_399_0.position

				var_399_0.forward = Vector3.New(var_399_7.x, var_399_7.y, var_399_7.z)

				local var_399_8 = var_399_0.localEulerAngles

				var_399_8.z = 0
				var_399_8.x = 0
				var_399_0.localEulerAngles = var_399_8
			end

			local var_399_9 = arg_396_1.actors_["1083ui_story"]
			local var_399_10 = 0

			if var_399_10 < arg_396_1.time_ and arg_396_1.time_ <= var_399_10 + arg_399_0 and not isNil(var_399_9) and arg_396_1.var_.characterEffect1083ui_story == nil then
				arg_396_1.var_.characterEffect1083ui_story = var_399_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_11 = 0.200000002980232

			if var_399_10 <= arg_396_1.time_ and arg_396_1.time_ < var_399_10 + var_399_11 and not isNil(var_399_9) then
				local var_399_12 = (arg_396_1.time_ - var_399_10) / var_399_11

				if arg_396_1.var_.characterEffect1083ui_story and not isNil(var_399_9) then
					arg_396_1.var_.characterEffect1083ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= var_399_10 + var_399_11 and arg_396_1.time_ < var_399_10 + var_399_11 + arg_399_0 and not isNil(var_399_9) and arg_396_1.var_.characterEffect1083ui_story then
				arg_396_1.var_.characterEffect1083ui_story.fillFlat = false
			end

			local var_399_13 = arg_396_1.actors_["1085ui_story"]
			local var_399_14 = 0

			if var_399_14 < arg_396_1.time_ and arg_396_1.time_ <= var_399_14 + arg_399_0 and not isNil(var_399_13) and arg_396_1.var_.characterEffect1085ui_story == nil then
				arg_396_1.var_.characterEffect1085ui_story = var_399_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_15 = 0.200000002980232

			if var_399_14 <= arg_396_1.time_ and arg_396_1.time_ < var_399_14 + var_399_15 and not isNil(var_399_13) then
				local var_399_16 = (arg_396_1.time_ - var_399_14) / var_399_15

				if arg_396_1.var_.characterEffect1085ui_story and not isNil(var_399_13) then
					local var_399_17 = Mathf.Lerp(0, 0.5, var_399_16)

					arg_396_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_396_1.var_.characterEffect1085ui_story.fillRatio = var_399_17
				end
			end

			if arg_396_1.time_ >= var_399_14 + var_399_15 and arg_396_1.time_ < var_399_14 + var_399_15 + arg_399_0 and not isNil(var_399_13) and arg_396_1.var_.characterEffect1085ui_story then
				local var_399_18 = 0.5

				arg_396_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_396_1.var_.characterEffect1085ui_story.fillRatio = var_399_18
			end

			local var_399_19 = 0

			if var_399_19 < arg_396_1.time_ and arg_396_1.time_ <= var_399_19 + arg_399_0 then
				arg_396_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action2_2")
			end

			local var_399_20 = 0

			if var_399_20 < arg_396_1.time_ and arg_396_1.time_ <= var_399_20 + arg_399_0 then
				arg_396_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_399_21 = 0
			local var_399_22 = 0.825

			if var_399_21 < arg_396_1.time_ and arg_396_1.time_ <= var_399_21 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_23 = arg_396_1:FormatText(StoryNameCfg[1332].name)

				arg_396_1.leftNameTxt_.text = var_399_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_24 = arg_396_1:GetWordFromCfg(1108503094)
				local var_399_25 = arg_396_1:FormatText(var_399_24.content)

				arg_396_1.text_.text = var_399_25

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_26 = 33
				local var_399_27 = utf8.len(var_399_25)
				local var_399_28 = var_399_26 <= 0 and var_399_22 or var_399_22 * (var_399_27 / var_399_26)

				if var_399_28 > 0 and var_399_22 < var_399_28 then
					arg_396_1.talkMaxDuration = var_399_28

					if var_399_28 + var_399_21 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_28 + var_399_21
					end
				end

				arg_396_1.text_.text = var_399_25
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503094", "story_v_side_new_1108503.awb") ~= 0 then
					local var_399_29 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503094", "story_v_side_new_1108503.awb") / 1000

					if var_399_29 + var_399_21 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_29 + var_399_21
					end

					if var_399_24.prefab_name ~= "" and arg_396_1.actors_[var_399_24.prefab_name] ~= nil then
						local var_399_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_24.prefab_name].transform, "story_v_side_new_1108503", "1108503094", "story_v_side_new_1108503.awb")

						arg_396_1:RecordAudio("1108503094", var_399_30)
						arg_396_1:RecordAudio("1108503094", var_399_30)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503094", "story_v_side_new_1108503.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503094", "story_v_side_new_1108503.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_31 = math.max(var_399_22, arg_396_1.talkMaxDuration)

			if var_399_21 <= arg_396_1.time_ and arg_396_1.time_ < var_399_21 + var_399_31 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_21) / var_399_31

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_21 + var_399_31 and arg_396_1.time_ < var_399_21 + var_399_31 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_396_1:InitPlayNodeList()
	end,
	Play1108503095 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 1108503095
		arg_400_1.duration_ = 3.33

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play1108503096(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["1083ui_story"].transform
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 then
				arg_400_1.var_.moveOldPos1083ui_story = var_403_0.localPosition
			end

			local var_403_2 = 0.001

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_2 then
				local var_403_3 = (arg_400_1.time_ - var_403_1) / var_403_2
				local var_403_4 = Vector3.New(-0.7, -1.05, -6)

				var_403_0.localPosition = Vector3.Lerp(arg_400_1.var_.moveOldPos1083ui_story, var_403_4, var_403_3)

				local var_403_5 = manager.ui.mainCamera.transform.position - var_403_0.position

				var_403_0.forward = Vector3.New(var_403_5.x, var_403_5.y, var_403_5.z)

				local var_403_6 = var_403_0.localEulerAngles

				var_403_6.z = 0
				var_403_6.x = 0
				var_403_0.localEulerAngles = var_403_6
			end

			if arg_400_1.time_ >= var_403_1 + var_403_2 and arg_400_1.time_ < var_403_1 + var_403_2 + arg_403_0 then
				var_403_0.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_403_7 = manager.ui.mainCamera.transform.position - var_403_0.position

				var_403_0.forward = Vector3.New(var_403_7.x, var_403_7.y, var_403_7.z)

				local var_403_8 = var_403_0.localEulerAngles

				var_403_8.z = 0
				var_403_8.x = 0
				var_403_0.localEulerAngles = var_403_8
			end

			local var_403_9 = 0

			if var_403_9 < arg_400_1.time_ and arg_400_1.time_ <= var_403_9 + arg_403_0 then
				arg_400_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action6_1")
			end

			local var_403_10 = 0

			if var_403_10 < arg_400_1.time_ and arg_400_1.time_ <= var_403_10 + arg_403_0 then
				arg_400_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_403_11 = 0
			local var_403_12 = 0.65

			if var_403_11 < arg_400_1.time_ and arg_400_1.time_ <= var_403_11 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				local var_403_13 = arg_400_1:FormatText(StoryNameCfg[1332].name)

				arg_400_1.leftNameTxt_.text = var_403_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_14 = arg_400_1:GetWordFromCfg(1108503095)
				local var_403_15 = arg_400_1:FormatText(var_403_14.content)

				arg_400_1.text_.text = var_403_15

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_16 = 26
				local var_403_17 = utf8.len(var_403_15)
				local var_403_18 = var_403_16 <= 0 and var_403_12 or var_403_12 * (var_403_17 / var_403_16)

				if var_403_18 > 0 and var_403_12 < var_403_18 then
					arg_400_1.talkMaxDuration = var_403_18

					if var_403_18 + var_403_11 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_18 + var_403_11
					end
				end

				arg_400_1.text_.text = var_403_15
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503095", "story_v_side_new_1108503.awb") ~= 0 then
					local var_403_19 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503095", "story_v_side_new_1108503.awb") / 1000

					if var_403_19 + var_403_11 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_19 + var_403_11
					end

					if var_403_14.prefab_name ~= "" and arg_400_1.actors_[var_403_14.prefab_name] ~= nil then
						local var_403_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_14.prefab_name].transform, "story_v_side_new_1108503", "1108503095", "story_v_side_new_1108503.awb")

						arg_400_1:RecordAudio("1108503095", var_403_20)
						arg_400_1:RecordAudio("1108503095", var_403_20)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503095", "story_v_side_new_1108503.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503095", "story_v_side_new_1108503.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_21 = math.max(var_403_12, arg_400_1.talkMaxDuration)

			if var_403_11 <= arg_400_1.time_ and arg_400_1.time_ < var_403_11 + var_403_21 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_11) / var_403_21

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_11 + var_403_21 and arg_400_1.time_ < var_403_11 + var_403_21 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_400_1:InitPlayNodeList()
	end,
	Play1108503096 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 1108503096
		arg_404_1.duration_ = 3.1

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play1108503097(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = arg_404_1.actors_["1085ui_story"].transform
			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 then
				arg_404_1.var_.moveOldPos1085ui_story = var_407_0.localPosition
			end

			local var_407_2 = 0.001

			if var_407_1 <= arg_404_1.time_ and arg_404_1.time_ < var_407_1 + var_407_2 then
				local var_407_3 = (arg_404_1.time_ - var_407_1) / var_407_2
				local var_407_4 = Vector3.New(0.75, -1.01, -5.83)

				var_407_0.localPosition = Vector3.Lerp(arg_404_1.var_.moveOldPos1085ui_story, var_407_4, var_407_3)

				local var_407_5 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_5.x, var_407_5.y, var_407_5.z)

				local var_407_6 = var_407_0.localEulerAngles

				var_407_6.z = 0
				var_407_6.x = 0
				var_407_0.localEulerAngles = var_407_6
			end

			if arg_404_1.time_ >= var_407_1 + var_407_2 and arg_404_1.time_ < var_407_1 + var_407_2 + arg_407_0 then
				var_407_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_407_7 = manager.ui.mainCamera.transform.position - var_407_0.position

				var_407_0.forward = Vector3.New(var_407_7.x, var_407_7.y, var_407_7.z)

				local var_407_8 = var_407_0.localEulerAngles

				var_407_8.z = 0
				var_407_8.x = 0
				var_407_0.localEulerAngles = var_407_8
			end

			local var_407_9 = arg_404_1.actors_["1085ui_story"]
			local var_407_10 = 0

			if var_407_10 < arg_404_1.time_ and arg_404_1.time_ <= var_407_10 + arg_407_0 and not isNil(var_407_9) and arg_404_1.var_.characterEffect1085ui_story == nil then
				arg_404_1.var_.characterEffect1085ui_story = var_407_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_11 = 0.200000002980232

			if var_407_10 <= arg_404_1.time_ and arg_404_1.time_ < var_407_10 + var_407_11 and not isNil(var_407_9) then
				local var_407_12 = (arg_404_1.time_ - var_407_10) / var_407_11

				if arg_404_1.var_.characterEffect1085ui_story and not isNil(var_407_9) then
					arg_404_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= var_407_10 + var_407_11 and arg_404_1.time_ < var_407_10 + var_407_11 + arg_407_0 and not isNil(var_407_9) and arg_404_1.var_.characterEffect1085ui_story then
				arg_404_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_407_13 = arg_404_1.actors_["1083ui_story"]
			local var_407_14 = 0

			if var_407_14 < arg_404_1.time_ and arg_404_1.time_ <= var_407_14 + arg_407_0 and not isNil(var_407_13) and arg_404_1.var_.characterEffect1083ui_story == nil then
				arg_404_1.var_.characterEffect1083ui_story = var_407_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_15 = 0.200000002980232

			if var_407_14 <= arg_404_1.time_ and arg_404_1.time_ < var_407_14 + var_407_15 and not isNil(var_407_13) then
				local var_407_16 = (arg_404_1.time_ - var_407_14) / var_407_15

				if arg_404_1.var_.characterEffect1083ui_story and not isNil(var_407_13) then
					local var_407_17 = Mathf.Lerp(0, 0.5, var_407_16)

					arg_404_1.var_.characterEffect1083ui_story.fillFlat = true
					arg_404_1.var_.characterEffect1083ui_story.fillRatio = var_407_17
				end
			end

			if arg_404_1.time_ >= var_407_14 + var_407_15 and arg_404_1.time_ < var_407_14 + var_407_15 + arg_407_0 and not isNil(var_407_13) and arg_404_1.var_.characterEffect1083ui_story then
				local var_407_18 = 0.5

				arg_404_1.var_.characterEffect1083ui_story.fillFlat = true
				arg_404_1.var_.characterEffect1083ui_story.fillRatio = var_407_18
			end

			local var_407_19 = 0

			if var_407_19 < arg_404_1.time_ and arg_404_1.time_ <= var_407_19 + arg_407_0 then
				arg_404_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_407_20 = 0

			if var_407_20 < arg_404_1.time_ and arg_404_1.time_ <= var_407_20 + arg_407_0 then
				arg_404_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_407_21 = 0
			local var_407_22 = 0.3

			if var_407_21 < arg_404_1.time_ and arg_404_1.time_ <= var_407_21 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_23 = arg_404_1:FormatText(StoryNameCfg[328].name)

				arg_404_1.leftNameTxt_.text = var_407_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_24 = arg_404_1:GetWordFromCfg(1108503096)
				local var_407_25 = arg_404_1:FormatText(var_407_24.content)

				arg_404_1.text_.text = var_407_25

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_26 = 12
				local var_407_27 = utf8.len(var_407_25)
				local var_407_28 = var_407_26 <= 0 and var_407_22 or var_407_22 * (var_407_27 / var_407_26)

				if var_407_28 > 0 and var_407_22 < var_407_28 then
					arg_404_1.talkMaxDuration = var_407_28

					if var_407_28 + var_407_21 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_28 + var_407_21
					end
				end

				arg_404_1.text_.text = var_407_25
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503096", "story_v_side_new_1108503.awb") ~= 0 then
					local var_407_29 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503096", "story_v_side_new_1108503.awb") / 1000

					if var_407_29 + var_407_21 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_29 + var_407_21
					end

					if var_407_24.prefab_name ~= "" and arg_404_1.actors_[var_407_24.prefab_name] ~= nil then
						local var_407_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_24.prefab_name].transform, "story_v_side_new_1108503", "1108503096", "story_v_side_new_1108503.awb")

						arg_404_1:RecordAudio("1108503096", var_407_30)
						arg_404_1:RecordAudio("1108503096", var_407_30)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503096", "story_v_side_new_1108503.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503096", "story_v_side_new_1108503.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_31 = math.max(var_407_22, arg_404_1.talkMaxDuration)

			if var_407_21 <= arg_404_1.time_ and arg_404_1.time_ < var_407_21 + var_407_31 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_21) / var_407_31

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_21 + var_407_31 and arg_404_1.time_ < var_407_21 + var_407_31 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {
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

		arg_404_1:InitPlayNodeList()
	end,
	Play1108503097 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 1108503097
		arg_408_1.duration_ = 3.6

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play1108503098(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["1083ui_story"].transform
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 then
				arg_408_1.var_.moveOldPos1083ui_story = var_411_0.localPosition
			end

			local var_411_2 = 0.001

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_2 then
				local var_411_3 = (arg_408_1.time_ - var_411_1) / var_411_2
				local var_411_4 = Vector3.New(-0.7, -1.05, -6)

				var_411_0.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos1083ui_story, var_411_4, var_411_3)

				local var_411_5 = manager.ui.mainCamera.transform.position - var_411_0.position

				var_411_0.forward = Vector3.New(var_411_5.x, var_411_5.y, var_411_5.z)

				local var_411_6 = var_411_0.localEulerAngles

				var_411_6.z = 0
				var_411_6.x = 0
				var_411_0.localEulerAngles = var_411_6
			end

			if arg_408_1.time_ >= var_411_1 + var_411_2 and arg_408_1.time_ < var_411_1 + var_411_2 + arg_411_0 then
				var_411_0.localPosition = Vector3.New(-0.7, -1.05, -6)

				local var_411_7 = manager.ui.mainCamera.transform.position - var_411_0.position

				var_411_0.forward = Vector3.New(var_411_7.x, var_411_7.y, var_411_7.z)

				local var_411_8 = var_411_0.localEulerAngles

				var_411_8.z = 0
				var_411_8.x = 0
				var_411_0.localEulerAngles = var_411_8
			end

			local var_411_9 = arg_408_1.actors_["1083ui_story"]
			local var_411_10 = 0

			if var_411_10 < arg_408_1.time_ and arg_408_1.time_ <= var_411_10 + arg_411_0 and not isNil(var_411_9) and arg_408_1.var_.characterEffect1083ui_story == nil then
				arg_408_1.var_.characterEffect1083ui_story = var_411_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_11 = 0.200000002980232

			if var_411_10 <= arg_408_1.time_ and arg_408_1.time_ < var_411_10 + var_411_11 and not isNil(var_411_9) then
				local var_411_12 = (arg_408_1.time_ - var_411_10) / var_411_11

				if arg_408_1.var_.characterEffect1083ui_story and not isNil(var_411_9) then
					arg_408_1.var_.characterEffect1083ui_story.fillFlat = false
				end
			end

			if arg_408_1.time_ >= var_411_10 + var_411_11 and arg_408_1.time_ < var_411_10 + var_411_11 + arg_411_0 and not isNil(var_411_9) and arg_408_1.var_.characterEffect1083ui_story then
				arg_408_1.var_.characterEffect1083ui_story.fillFlat = false
			end

			local var_411_13 = arg_408_1.actors_["1085ui_story"]
			local var_411_14 = 0

			if var_411_14 < arg_408_1.time_ and arg_408_1.time_ <= var_411_14 + arg_411_0 and not isNil(var_411_13) and arg_408_1.var_.characterEffect1085ui_story == nil then
				arg_408_1.var_.characterEffect1085ui_story = var_411_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_15 = 0.200000002980232

			if var_411_14 <= arg_408_1.time_ and arg_408_1.time_ < var_411_14 + var_411_15 and not isNil(var_411_13) then
				local var_411_16 = (arg_408_1.time_ - var_411_14) / var_411_15

				if arg_408_1.var_.characterEffect1085ui_story and not isNil(var_411_13) then
					local var_411_17 = Mathf.Lerp(0, 0.5, var_411_16)

					arg_408_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_408_1.var_.characterEffect1085ui_story.fillRatio = var_411_17
				end
			end

			if arg_408_1.time_ >= var_411_14 + var_411_15 and arg_408_1.time_ < var_411_14 + var_411_15 + arg_411_0 and not isNil(var_411_13) and arg_408_1.var_.characterEffect1085ui_story then
				local var_411_18 = 0.5

				arg_408_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_408_1.var_.characterEffect1085ui_story.fillRatio = var_411_18
			end

			local var_411_19 = 0

			if var_411_19 < arg_408_1.time_ and arg_408_1.time_ <= var_411_19 + arg_411_0 then
				arg_408_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action6_2")
			end

			local var_411_20 = 0

			if var_411_20 < arg_408_1.time_ and arg_408_1.time_ <= var_411_20 + arg_411_0 then
				arg_408_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_411_21 = 0
			local var_411_22 = 0.45

			if var_411_21 < arg_408_1.time_ and arg_408_1.time_ <= var_411_21 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				local var_411_23 = arg_408_1:FormatText(StoryNameCfg[1332].name)

				arg_408_1.leftNameTxt_.text = var_411_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_24 = arg_408_1:GetWordFromCfg(1108503097)
				local var_411_25 = arg_408_1:FormatText(var_411_24.content)

				arg_408_1.text_.text = var_411_25

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_26 = 18
				local var_411_27 = utf8.len(var_411_25)
				local var_411_28 = var_411_26 <= 0 and var_411_22 or var_411_22 * (var_411_27 / var_411_26)

				if var_411_28 > 0 and var_411_22 < var_411_28 then
					arg_408_1.talkMaxDuration = var_411_28

					if var_411_28 + var_411_21 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_28 + var_411_21
					end
				end

				arg_408_1.text_.text = var_411_25
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503097", "story_v_side_new_1108503.awb") ~= 0 then
					local var_411_29 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503097", "story_v_side_new_1108503.awb") / 1000

					if var_411_29 + var_411_21 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_29 + var_411_21
					end

					if var_411_24.prefab_name ~= "" and arg_408_1.actors_[var_411_24.prefab_name] ~= nil then
						local var_411_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_24.prefab_name].transform, "story_v_side_new_1108503", "1108503097", "story_v_side_new_1108503.awb")

						arg_408_1:RecordAudio("1108503097", var_411_30)
						arg_408_1:RecordAudio("1108503097", var_411_30)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503097", "story_v_side_new_1108503.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503097", "story_v_side_new_1108503.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_31 = math.max(var_411_22, arg_408_1.talkMaxDuration)

			if var_411_21 <= arg_408_1.time_ and arg_408_1.time_ < var_411_21 + var_411_31 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_21) / var_411_31

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_21 + var_411_31 and arg_408_1.time_ < var_411_21 + var_411_31 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_408_1:InitPlayNodeList()
	end,
	Play1108503098 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 1108503098
		arg_412_1.duration_ = 2.3

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play1108503099(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = "10145ui_story"

			if arg_412_1.actors_[var_415_0] == nil then
				local var_415_1 = Asset.Load("Char/" .. "10145ui_story")

				if not isNil(var_415_1) then
					local var_415_2 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_412_1.stage_.transform)

					var_415_2.name = var_415_0
					var_415_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_412_1.actors_[var_415_0] = var_415_2

					local var_415_3 = var_415_2:GetComponentInChildren(typeof(CharacterEffect))

					var_415_3.enabled = true

					local var_415_4 = GameObjectTools.GetOrAddComponent(var_415_2, typeof(DynamicBoneHelper))

					if var_415_4 then
						var_415_4:EnableDynamicBone(false)
					end

					arg_412_1:ShowWeapon(var_415_3.transform, false)

					arg_412_1.var_[var_415_0 .. "Animator"] = var_415_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_412_1.var_[var_415_0 .. "Animator"].applyRootMotion = true
					arg_412_1.var_[var_415_0 .. "LipSync"] = var_415_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_415_5 = arg_412_1.actors_["10145ui_story"].transform
			local var_415_6 = 0

			if var_415_6 < arg_412_1.time_ and arg_412_1.time_ <= var_415_6 + arg_415_0 then
				arg_412_1.var_.moveOldPos10145ui_story = var_415_5.localPosition
			end

			local var_415_7 = 0.001

			if var_415_6 <= arg_412_1.time_ and arg_412_1.time_ < var_415_6 + var_415_7 then
				local var_415_8 = (arg_412_1.time_ - var_415_6) / var_415_7
				local var_415_9 = Vector3.New(-0.65, -1, -6.2)

				var_415_5.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos10145ui_story, var_415_9, var_415_8)

				local var_415_10 = manager.ui.mainCamera.transform.position - var_415_5.position

				var_415_5.forward = Vector3.New(var_415_10.x, var_415_10.y, var_415_10.z)

				local var_415_11 = var_415_5.localEulerAngles

				var_415_11.z = 0
				var_415_11.x = 0
				var_415_5.localEulerAngles = var_415_11
			end

			if arg_412_1.time_ >= var_415_6 + var_415_7 and arg_412_1.time_ < var_415_6 + var_415_7 + arg_415_0 then
				var_415_5.localPosition = Vector3.New(-0.65, -1, -6.2)

				local var_415_12 = manager.ui.mainCamera.transform.position - var_415_5.position

				var_415_5.forward = Vector3.New(var_415_12.x, var_415_12.y, var_415_12.z)

				local var_415_13 = var_415_5.localEulerAngles

				var_415_13.z = 0
				var_415_13.x = 0
				var_415_5.localEulerAngles = var_415_13
			end

			local var_415_14 = arg_412_1.actors_["1083ui_story"].transform
			local var_415_15 = 0

			if var_415_15 < arg_412_1.time_ and arg_412_1.time_ <= var_415_15 + arg_415_0 then
				arg_412_1.var_.moveOldPos1083ui_story = var_415_14.localPosition
			end

			local var_415_16 = 0.001

			if var_415_15 <= arg_412_1.time_ and arg_412_1.time_ < var_415_15 + var_415_16 then
				local var_415_17 = (arg_412_1.time_ - var_415_15) / var_415_16
				local var_415_18 = Vector3.New(0, 100, 0)

				var_415_14.localPosition = Vector3.Lerp(arg_412_1.var_.moveOldPos1083ui_story, var_415_18, var_415_17)

				local var_415_19 = manager.ui.mainCamera.transform.position - var_415_14.position

				var_415_14.forward = Vector3.New(var_415_19.x, var_415_19.y, var_415_19.z)

				local var_415_20 = var_415_14.localEulerAngles

				var_415_20.z = 0
				var_415_20.x = 0
				var_415_14.localEulerAngles = var_415_20
			end

			if arg_412_1.time_ >= var_415_15 + var_415_16 and arg_412_1.time_ < var_415_15 + var_415_16 + arg_415_0 then
				var_415_14.localPosition = Vector3.New(0, 100, 0)

				local var_415_21 = manager.ui.mainCamera.transform.position - var_415_14.position

				var_415_14.forward = Vector3.New(var_415_21.x, var_415_21.y, var_415_21.z)

				local var_415_22 = var_415_14.localEulerAngles

				var_415_22.z = 0
				var_415_22.x = 0
				var_415_14.localEulerAngles = var_415_22
			end

			local var_415_23 = arg_412_1.actors_["10145ui_story"]
			local var_415_24 = 0

			if var_415_24 < arg_412_1.time_ and arg_412_1.time_ <= var_415_24 + arg_415_0 and not isNil(var_415_23) and arg_412_1.var_.characterEffect10145ui_story == nil then
				arg_412_1.var_.characterEffect10145ui_story = var_415_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_25 = 0.200000002980232

			if var_415_24 <= arg_412_1.time_ and arg_412_1.time_ < var_415_24 + var_415_25 and not isNil(var_415_23) then
				local var_415_26 = (arg_412_1.time_ - var_415_24) / var_415_25

				if arg_412_1.var_.characterEffect10145ui_story and not isNil(var_415_23) then
					arg_412_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_412_1.time_ >= var_415_24 + var_415_25 and arg_412_1.time_ < var_415_24 + var_415_25 + arg_415_0 and not isNil(var_415_23) and arg_412_1.var_.characterEffect10145ui_story then
				arg_412_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_415_27 = arg_412_1.actors_["1083ui_story"]
			local var_415_28 = 0

			if var_415_28 < arg_412_1.time_ and arg_412_1.time_ <= var_415_28 + arg_415_0 and not isNil(var_415_27) and arg_412_1.var_.characterEffect1083ui_story == nil then
				arg_412_1.var_.characterEffect1083ui_story = var_415_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_415_29 = 0.200000002980232

			if var_415_28 <= arg_412_1.time_ and arg_412_1.time_ < var_415_28 + var_415_29 and not isNil(var_415_27) then
				local var_415_30 = (arg_412_1.time_ - var_415_28) / var_415_29

				if arg_412_1.var_.characterEffect1083ui_story and not isNil(var_415_27) then
					local var_415_31 = Mathf.Lerp(0, 0.5, var_415_30)

					arg_412_1.var_.characterEffect1083ui_story.fillFlat = true
					arg_412_1.var_.characterEffect1083ui_story.fillRatio = var_415_31
				end
			end

			if arg_412_1.time_ >= var_415_28 + var_415_29 and arg_412_1.time_ < var_415_28 + var_415_29 + arg_415_0 and not isNil(var_415_27) and arg_412_1.var_.characterEffect1083ui_story then
				local var_415_32 = 0.5

				arg_412_1.var_.characterEffect1083ui_story.fillFlat = true
				arg_412_1.var_.characterEffect1083ui_story.fillRatio = var_415_32
			end

			local var_415_33 = 0

			if var_415_33 < arg_412_1.time_ and arg_412_1.time_ <= var_415_33 + arg_415_0 then
				arg_412_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			local var_415_34 = 0

			if var_415_34 < arg_412_1.time_ and arg_412_1.time_ <= var_415_34 + arg_415_0 then
				arg_412_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_415_35 = 0
			local var_415_36 = 0.3

			if var_415_35 < arg_412_1.time_ and arg_412_1.time_ <= var_415_35 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_37 = arg_412_1:FormatText(StoryNameCfg[1308].name)

				arg_412_1.leftNameTxt_.text = var_415_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_38 = arg_412_1:GetWordFromCfg(1108503098)
				local var_415_39 = arg_412_1:FormatText(var_415_38.content)

				arg_412_1.text_.text = var_415_39

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_40 = 12
				local var_415_41 = utf8.len(var_415_39)
				local var_415_42 = var_415_40 <= 0 and var_415_36 or var_415_36 * (var_415_41 / var_415_40)

				if var_415_42 > 0 and var_415_36 < var_415_42 then
					arg_412_1.talkMaxDuration = var_415_42

					if var_415_42 + var_415_35 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_42 + var_415_35
					end
				end

				arg_412_1.text_.text = var_415_39
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503098", "story_v_side_new_1108503.awb") ~= 0 then
					local var_415_43 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503098", "story_v_side_new_1108503.awb") / 1000

					if var_415_43 + var_415_35 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_43 + var_415_35
					end

					if var_415_38.prefab_name ~= "" and arg_412_1.actors_[var_415_38.prefab_name] ~= nil then
						local var_415_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_38.prefab_name].transform, "story_v_side_new_1108503", "1108503098", "story_v_side_new_1108503.awb")

						arg_412_1:RecordAudio("1108503098", var_415_44)
						arg_412_1:RecordAudio("1108503098", var_415_44)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503098", "story_v_side_new_1108503.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503098", "story_v_side_new_1108503.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_45 = math.max(var_415_36, arg_412_1.talkMaxDuration)

			if var_415_35 <= arg_412_1.time_ and arg_412_1.time_ < var_415_35 + var_415_45 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_35) / var_415_45

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_35 + var_415_45 and arg_412_1.time_ < var_415_35 + var_415_45 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_412_1:InitPlayNodeList()
	end,
	Play1108503099 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 1108503099
		arg_416_1.duration_ = 2.07

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play1108503100(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = arg_416_1.actors_["1085ui_story"].transform
			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 then
				arg_416_1.var_.moveOldPos1085ui_story = var_419_0.localPosition
			end

			local var_419_2 = 0.001

			if var_419_1 <= arg_416_1.time_ and arg_416_1.time_ < var_419_1 + var_419_2 then
				local var_419_3 = (arg_416_1.time_ - var_419_1) / var_419_2
				local var_419_4 = Vector3.New(0.75, -1.01, -5.83)

				var_419_0.localPosition = Vector3.Lerp(arg_416_1.var_.moveOldPos1085ui_story, var_419_4, var_419_3)

				local var_419_5 = manager.ui.mainCamera.transform.position - var_419_0.position

				var_419_0.forward = Vector3.New(var_419_5.x, var_419_5.y, var_419_5.z)

				local var_419_6 = var_419_0.localEulerAngles

				var_419_6.z = 0
				var_419_6.x = 0
				var_419_0.localEulerAngles = var_419_6
			end

			if arg_416_1.time_ >= var_419_1 + var_419_2 and arg_416_1.time_ < var_419_1 + var_419_2 + arg_419_0 then
				var_419_0.localPosition = Vector3.New(0.75, -1.01, -5.83)

				local var_419_7 = manager.ui.mainCamera.transform.position - var_419_0.position

				var_419_0.forward = Vector3.New(var_419_7.x, var_419_7.y, var_419_7.z)

				local var_419_8 = var_419_0.localEulerAngles

				var_419_8.z = 0
				var_419_8.x = 0
				var_419_0.localEulerAngles = var_419_8
			end

			local var_419_9 = arg_416_1.actors_["1085ui_story"]
			local var_419_10 = 0

			if var_419_10 < arg_416_1.time_ and arg_416_1.time_ <= var_419_10 + arg_419_0 and not isNil(var_419_9) and arg_416_1.var_.characterEffect1085ui_story == nil then
				arg_416_1.var_.characterEffect1085ui_story = var_419_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_11 = 0.200000002980232

			if var_419_10 <= arg_416_1.time_ and arg_416_1.time_ < var_419_10 + var_419_11 and not isNil(var_419_9) then
				local var_419_12 = (arg_416_1.time_ - var_419_10) / var_419_11

				if arg_416_1.var_.characterEffect1085ui_story and not isNil(var_419_9) then
					arg_416_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_416_1.time_ >= var_419_10 + var_419_11 and arg_416_1.time_ < var_419_10 + var_419_11 + arg_419_0 and not isNil(var_419_9) and arg_416_1.var_.characterEffect1085ui_story then
				arg_416_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_419_13 = arg_416_1.actors_["10145ui_story"]
			local var_419_14 = 0

			if var_419_14 < arg_416_1.time_ and arg_416_1.time_ <= var_419_14 + arg_419_0 and not isNil(var_419_13) and arg_416_1.var_.characterEffect10145ui_story == nil then
				arg_416_1.var_.characterEffect10145ui_story = var_419_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_15 = 0.200000002980232

			if var_419_14 <= arg_416_1.time_ and arg_416_1.time_ < var_419_14 + var_419_15 and not isNil(var_419_13) then
				local var_419_16 = (arg_416_1.time_ - var_419_14) / var_419_15

				if arg_416_1.var_.characterEffect10145ui_story and not isNil(var_419_13) then
					local var_419_17 = Mathf.Lerp(0, 0.5, var_419_16)

					arg_416_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_416_1.var_.characterEffect10145ui_story.fillRatio = var_419_17
				end
			end

			if arg_416_1.time_ >= var_419_14 + var_419_15 and arg_416_1.time_ < var_419_14 + var_419_15 + arg_419_0 and not isNil(var_419_13) and arg_416_1.var_.characterEffect10145ui_story then
				local var_419_18 = 0.5

				arg_416_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_416_1.var_.characterEffect10145ui_story.fillRatio = var_419_18
			end

			local var_419_19 = 0

			if var_419_19 < arg_416_1.time_ and arg_416_1.time_ <= var_419_19 + arg_419_0 then
				arg_416_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_419_20 = 0

			if var_419_20 < arg_416_1.time_ and arg_416_1.time_ <= var_419_20 + arg_419_0 then
				arg_416_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_419_21 = 0
			local var_419_22 = 0.125

			if var_419_21 < arg_416_1.time_ and arg_416_1.time_ <= var_419_21 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_23 = arg_416_1:FormatText(StoryNameCfg[328].name)

				arg_416_1.leftNameTxt_.text = var_419_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_24 = arg_416_1:GetWordFromCfg(1108503099)
				local var_419_25 = arg_416_1:FormatText(var_419_24.content)

				arg_416_1.text_.text = var_419_25

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_26 = 5
				local var_419_27 = utf8.len(var_419_25)
				local var_419_28 = var_419_26 <= 0 and var_419_22 or var_419_22 * (var_419_27 / var_419_26)

				if var_419_28 > 0 and var_419_22 < var_419_28 then
					arg_416_1.talkMaxDuration = var_419_28

					if var_419_28 + var_419_21 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_28 + var_419_21
					end
				end

				arg_416_1.text_.text = var_419_25
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503099", "story_v_side_new_1108503.awb") ~= 0 then
					local var_419_29 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503099", "story_v_side_new_1108503.awb") / 1000

					if var_419_29 + var_419_21 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_29 + var_419_21
					end

					if var_419_24.prefab_name ~= "" and arg_416_1.actors_[var_419_24.prefab_name] ~= nil then
						local var_419_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_24.prefab_name].transform, "story_v_side_new_1108503", "1108503099", "story_v_side_new_1108503.awb")

						arg_416_1:RecordAudio("1108503099", var_419_30)
						arg_416_1:RecordAudio("1108503099", var_419_30)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503099", "story_v_side_new_1108503.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503099", "story_v_side_new_1108503.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_31 = math.max(var_419_22, arg_416_1.talkMaxDuration)

			if var_419_21 <= arg_416_1.time_ and arg_416_1.time_ < var_419_21 + var_419_31 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_21) / var_419_31

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_21 + var_419_31 and arg_416_1.time_ < var_419_21 + var_419_31 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {
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

		arg_416_1:InitPlayNodeList()
	end,
	Play1108503100 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 1108503100
		arg_420_1.duration_ = 4.6

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play1108503101(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["1083ui_story"].transform
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 then
				arg_420_1.var_.moveOldPos1083ui_story = var_423_0.localPosition
			end

			local var_423_2 = 0.001

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2
				local var_423_4 = Vector3.New(0.7, -1.05, -6)

				var_423_0.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1083ui_story, var_423_4, var_423_3)

				local var_423_5 = manager.ui.mainCamera.transform.position - var_423_0.position

				var_423_0.forward = Vector3.New(var_423_5.x, var_423_5.y, var_423_5.z)

				local var_423_6 = var_423_0.localEulerAngles

				var_423_6.z = 0
				var_423_6.x = 0
				var_423_0.localEulerAngles = var_423_6
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 then
				var_423_0.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_423_7 = manager.ui.mainCamera.transform.position - var_423_0.position

				var_423_0.forward = Vector3.New(var_423_7.x, var_423_7.y, var_423_7.z)

				local var_423_8 = var_423_0.localEulerAngles

				var_423_8.z = 0
				var_423_8.x = 0
				var_423_0.localEulerAngles = var_423_8
			end

			local var_423_9 = arg_420_1.actors_["1085ui_story"].transform
			local var_423_10 = 0

			if var_423_10 < arg_420_1.time_ and arg_420_1.time_ <= var_423_10 + arg_423_0 then
				arg_420_1.var_.moveOldPos1085ui_story = var_423_9.localPosition
			end

			local var_423_11 = 0.001

			if var_423_10 <= arg_420_1.time_ and arg_420_1.time_ < var_423_10 + var_423_11 then
				local var_423_12 = (arg_420_1.time_ - var_423_10) / var_423_11
				local var_423_13 = Vector3.New(0, 100, 0)

				var_423_9.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPos1085ui_story, var_423_13, var_423_12)

				local var_423_14 = manager.ui.mainCamera.transform.position - var_423_9.position

				var_423_9.forward = Vector3.New(var_423_14.x, var_423_14.y, var_423_14.z)

				local var_423_15 = var_423_9.localEulerAngles

				var_423_15.z = 0
				var_423_15.x = 0
				var_423_9.localEulerAngles = var_423_15
			end

			if arg_420_1.time_ >= var_423_10 + var_423_11 and arg_420_1.time_ < var_423_10 + var_423_11 + arg_423_0 then
				var_423_9.localPosition = Vector3.New(0, 100, 0)

				local var_423_16 = manager.ui.mainCamera.transform.position - var_423_9.position

				var_423_9.forward = Vector3.New(var_423_16.x, var_423_16.y, var_423_16.z)

				local var_423_17 = var_423_9.localEulerAngles

				var_423_17.z = 0
				var_423_17.x = 0
				var_423_9.localEulerAngles = var_423_17
			end

			local var_423_18 = arg_420_1.actors_["1083ui_story"]
			local var_423_19 = 0

			if var_423_19 < arg_420_1.time_ and arg_420_1.time_ <= var_423_19 + arg_423_0 and not isNil(var_423_18) and arg_420_1.var_.characterEffect1083ui_story == nil then
				arg_420_1.var_.characterEffect1083ui_story = var_423_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_20 = 0.200000002980232

			if var_423_19 <= arg_420_1.time_ and arg_420_1.time_ < var_423_19 + var_423_20 and not isNil(var_423_18) then
				local var_423_21 = (arg_420_1.time_ - var_423_19) / var_423_20

				if arg_420_1.var_.characterEffect1083ui_story and not isNil(var_423_18) then
					arg_420_1.var_.characterEffect1083ui_story.fillFlat = false
				end
			end

			if arg_420_1.time_ >= var_423_19 + var_423_20 and arg_420_1.time_ < var_423_19 + var_423_20 + arg_423_0 and not isNil(var_423_18) and arg_420_1.var_.characterEffect1083ui_story then
				arg_420_1.var_.characterEffect1083ui_story.fillFlat = false
			end

			local var_423_22 = arg_420_1.actors_["1085ui_story"]
			local var_423_23 = 0

			if var_423_23 < arg_420_1.time_ and arg_420_1.time_ <= var_423_23 + arg_423_0 and not isNil(var_423_22) and arg_420_1.var_.characterEffect1085ui_story == nil then
				arg_420_1.var_.characterEffect1085ui_story = var_423_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_24 = 0.200000002980232

			if var_423_23 <= arg_420_1.time_ and arg_420_1.time_ < var_423_23 + var_423_24 and not isNil(var_423_22) then
				local var_423_25 = (arg_420_1.time_ - var_423_23) / var_423_24

				if arg_420_1.var_.characterEffect1085ui_story and not isNil(var_423_22) then
					local var_423_26 = Mathf.Lerp(0, 0.5, var_423_25)

					arg_420_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_420_1.var_.characterEffect1085ui_story.fillRatio = var_423_26
				end
			end

			if arg_420_1.time_ >= var_423_23 + var_423_24 and arg_420_1.time_ < var_423_23 + var_423_24 + arg_423_0 and not isNil(var_423_22) and arg_420_1.var_.characterEffect1085ui_story then
				local var_423_27 = 0.5

				arg_420_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_420_1.var_.characterEffect1085ui_story.fillRatio = var_423_27
			end

			local var_423_28 = 0

			if var_423_28 < arg_420_1.time_ and arg_420_1.time_ <= var_423_28 + arg_423_0 then
				arg_420_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action1_1")
			end

			local var_423_29 = 0

			if var_423_29 < arg_420_1.time_ and arg_420_1.time_ <= var_423_29 + arg_423_0 then
				arg_420_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_423_30 = 0
			local var_423_31 = 0.5

			if var_423_30 < arg_420_1.time_ and arg_420_1.time_ <= var_423_30 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_32 = arg_420_1:FormatText(StoryNameCfg[1332].name)

				arg_420_1.leftNameTxt_.text = var_423_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_33 = arg_420_1:GetWordFromCfg(1108503100)
				local var_423_34 = arg_420_1:FormatText(var_423_33.content)

				arg_420_1.text_.text = var_423_34

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_35 = 20
				local var_423_36 = utf8.len(var_423_34)
				local var_423_37 = var_423_35 <= 0 and var_423_31 or var_423_31 * (var_423_36 / var_423_35)

				if var_423_37 > 0 and var_423_31 < var_423_37 then
					arg_420_1.talkMaxDuration = var_423_37

					if var_423_37 + var_423_30 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_37 + var_423_30
					end
				end

				arg_420_1.text_.text = var_423_34
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503100", "story_v_side_new_1108503.awb") ~= 0 then
					local var_423_38 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503100", "story_v_side_new_1108503.awb") / 1000

					if var_423_38 + var_423_30 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_38 + var_423_30
					end

					if var_423_33.prefab_name ~= "" and arg_420_1.actors_[var_423_33.prefab_name] ~= nil then
						local var_423_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_33.prefab_name].transform, "story_v_side_new_1108503", "1108503100", "story_v_side_new_1108503.awb")

						arg_420_1:RecordAudio("1108503100", var_423_39)
						arg_420_1:RecordAudio("1108503100", var_423_39)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503100", "story_v_side_new_1108503.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503100", "story_v_side_new_1108503.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_40 = math.max(var_423_31, arg_420_1.talkMaxDuration)

			if var_423_30 <= arg_420_1.time_ and arg_420_1.time_ < var_423_30 + var_423_40 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_30) / var_423_40

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_30 + var_423_40 and arg_420_1.time_ < var_423_30 + var_423_40 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_420_1:InitPlayNodeList()
	end,
	Play1108503101 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 1108503101
		arg_424_1.duration_ = 4.73

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play1108503102(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = arg_424_1.actors_["10145ui_story"].transform
			local var_427_1 = 0

			if var_427_1 < arg_424_1.time_ and arg_424_1.time_ <= var_427_1 + arg_427_0 then
				arg_424_1.var_.moveOldPos10145ui_story = var_427_0.localPosition
			end

			local var_427_2 = 0.001

			if var_427_1 <= arg_424_1.time_ and arg_424_1.time_ < var_427_1 + var_427_2 then
				local var_427_3 = (arg_424_1.time_ - var_427_1) / var_427_2
				local var_427_4 = Vector3.New(-0.65, -1, -6.2)

				var_427_0.localPosition = Vector3.Lerp(arg_424_1.var_.moveOldPos10145ui_story, var_427_4, var_427_3)

				local var_427_5 = manager.ui.mainCamera.transform.position - var_427_0.position

				var_427_0.forward = Vector3.New(var_427_5.x, var_427_5.y, var_427_5.z)

				local var_427_6 = var_427_0.localEulerAngles

				var_427_6.z = 0
				var_427_6.x = 0
				var_427_0.localEulerAngles = var_427_6
			end

			if arg_424_1.time_ >= var_427_1 + var_427_2 and arg_424_1.time_ < var_427_1 + var_427_2 + arg_427_0 then
				var_427_0.localPosition = Vector3.New(-0.65, -1, -6.2)

				local var_427_7 = manager.ui.mainCamera.transform.position - var_427_0.position

				var_427_0.forward = Vector3.New(var_427_7.x, var_427_7.y, var_427_7.z)

				local var_427_8 = var_427_0.localEulerAngles

				var_427_8.z = 0
				var_427_8.x = 0
				var_427_0.localEulerAngles = var_427_8
			end

			local var_427_9 = arg_424_1.actors_["10145ui_story"]
			local var_427_10 = 0

			if var_427_10 < arg_424_1.time_ and arg_424_1.time_ <= var_427_10 + arg_427_0 and not isNil(var_427_9) and arg_424_1.var_.characterEffect10145ui_story == nil then
				arg_424_1.var_.characterEffect10145ui_story = var_427_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_11 = 0.200000002980232

			if var_427_10 <= arg_424_1.time_ and arg_424_1.time_ < var_427_10 + var_427_11 and not isNil(var_427_9) then
				local var_427_12 = (arg_424_1.time_ - var_427_10) / var_427_11

				if arg_424_1.var_.characterEffect10145ui_story and not isNil(var_427_9) then
					arg_424_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= var_427_10 + var_427_11 and arg_424_1.time_ < var_427_10 + var_427_11 + arg_427_0 and not isNil(var_427_9) and arg_424_1.var_.characterEffect10145ui_story then
				arg_424_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_427_13 = arg_424_1.actors_["1083ui_story"]
			local var_427_14 = 0

			if var_427_14 < arg_424_1.time_ and arg_424_1.time_ <= var_427_14 + arg_427_0 and not isNil(var_427_13) and arg_424_1.var_.characterEffect1083ui_story == nil then
				arg_424_1.var_.characterEffect1083ui_story = var_427_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_15 = 0.200000002980232

			if var_427_14 <= arg_424_1.time_ and arg_424_1.time_ < var_427_14 + var_427_15 and not isNil(var_427_13) then
				local var_427_16 = (arg_424_1.time_ - var_427_14) / var_427_15

				if arg_424_1.var_.characterEffect1083ui_story and not isNil(var_427_13) then
					local var_427_17 = Mathf.Lerp(0, 0.5, var_427_16)

					arg_424_1.var_.characterEffect1083ui_story.fillFlat = true
					arg_424_1.var_.characterEffect1083ui_story.fillRatio = var_427_17
				end
			end

			if arg_424_1.time_ >= var_427_14 + var_427_15 and arg_424_1.time_ < var_427_14 + var_427_15 + arg_427_0 and not isNil(var_427_13) and arg_424_1.var_.characterEffect1083ui_story then
				local var_427_18 = 0.5

				arg_424_1.var_.characterEffect1083ui_story.fillFlat = true
				arg_424_1.var_.characterEffect1083ui_story.fillRatio = var_427_18
			end

			local var_427_19 = 0

			if var_427_19 < arg_424_1.time_ and arg_424_1.time_ <= var_427_19 + arg_427_0 then
				arg_424_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_1")
			end

			local var_427_20 = 0

			if var_427_20 < arg_424_1.time_ and arg_424_1.time_ <= var_427_20 + arg_427_0 then
				arg_424_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_xinwei", "EmotionTimelineAnimator")
			end

			local var_427_21 = 0
			local var_427_22 = 0.65

			if var_427_21 < arg_424_1.time_ and arg_424_1.time_ <= var_427_21 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_23 = arg_424_1:FormatText(StoryNameCfg[1308].name)

				arg_424_1.leftNameTxt_.text = var_427_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_24 = arg_424_1:GetWordFromCfg(1108503101)
				local var_427_25 = arg_424_1:FormatText(var_427_24.content)

				arg_424_1.text_.text = var_427_25

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_26 = 26
				local var_427_27 = utf8.len(var_427_25)
				local var_427_28 = var_427_26 <= 0 and var_427_22 or var_427_22 * (var_427_27 / var_427_26)

				if var_427_28 > 0 and var_427_22 < var_427_28 then
					arg_424_1.talkMaxDuration = var_427_28

					if var_427_28 + var_427_21 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_28 + var_427_21
					end
				end

				arg_424_1.text_.text = var_427_25
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503101", "story_v_side_new_1108503.awb") ~= 0 then
					local var_427_29 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503101", "story_v_side_new_1108503.awb") / 1000

					if var_427_29 + var_427_21 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_29 + var_427_21
					end

					if var_427_24.prefab_name ~= "" and arg_424_1.actors_[var_427_24.prefab_name] ~= nil then
						local var_427_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_24.prefab_name].transform, "story_v_side_new_1108503", "1108503101", "story_v_side_new_1108503.awb")

						arg_424_1:RecordAudio("1108503101", var_427_30)
						arg_424_1:RecordAudio("1108503101", var_427_30)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503101", "story_v_side_new_1108503.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503101", "story_v_side_new_1108503.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_31 = math.max(var_427_22, arg_424_1.talkMaxDuration)

			if var_427_21 <= arg_424_1.time_ and arg_424_1.time_ < var_427_21 + var_427_31 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_21) / var_427_31

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_21 + var_427_31 and arg_424_1.time_ < var_427_21 + var_427_31 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_424_1:InitPlayNodeList()
	end,
	Play1108503102 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 1108503102
		arg_428_1.duration_ = 2

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play1108503103(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["1083ui_story"].transform
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 then
				arg_428_1.var_.moveOldPos1083ui_story = var_431_0.localPosition
			end

			local var_431_2 = 0.001

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2
				local var_431_4 = Vector3.New(0.7, -1.05, -6)

				var_431_0.localPosition = Vector3.Lerp(arg_428_1.var_.moveOldPos1083ui_story, var_431_4, var_431_3)

				local var_431_5 = manager.ui.mainCamera.transform.position - var_431_0.position

				var_431_0.forward = Vector3.New(var_431_5.x, var_431_5.y, var_431_5.z)

				local var_431_6 = var_431_0.localEulerAngles

				var_431_6.z = 0
				var_431_6.x = 0
				var_431_0.localEulerAngles = var_431_6
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 then
				var_431_0.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_431_7 = manager.ui.mainCamera.transform.position - var_431_0.position

				var_431_0.forward = Vector3.New(var_431_7.x, var_431_7.y, var_431_7.z)

				local var_431_8 = var_431_0.localEulerAngles

				var_431_8.z = 0
				var_431_8.x = 0
				var_431_0.localEulerAngles = var_431_8
			end

			local var_431_9 = arg_428_1.actors_["1083ui_story"]
			local var_431_10 = 0

			if var_431_10 < arg_428_1.time_ and arg_428_1.time_ <= var_431_10 + arg_431_0 and not isNil(var_431_9) and arg_428_1.var_.characterEffect1083ui_story == nil then
				arg_428_1.var_.characterEffect1083ui_story = var_431_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_11 = 0.200000002980232

			if var_431_10 <= arg_428_1.time_ and arg_428_1.time_ < var_431_10 + var_431_11 and not isNil(var_431_9) then
				local var_431_12 = (arg_428_1.time_ - var_431_10) / var_431_11

				if arg_428_1.var_.characterEffect1083ui_story and not isNil(var_431_9) then
					arg_428_1.var_.characterEffect1083ui_story.fillFlat = false
				end
			end

			if arg_428_1.time_ >= var_431_10 + var_431_11 and arg_428_1.time_ < var_431_10 + var_431_11 + arg_431_0 and not isNil(var_431_9) and arg_428_1.var_.characterEffect1083ui_story then
				arg_428_1.var_.characterEffect1083ui_story.fillFlat = false
			end

			local var_431_13 = arg_428_1.actors_["10145ui_story"]
			local var_431_14 = 0

			if var_431_14 < arg_428_1.time_ and arg_428_1.time_ <= var_431_14 + arg_431_0 and not isNil(var_431_13) and arg_428_1.var_.characterEffect10145ui_story == nil then
				arg_428_1.var_.characterEffect10145ui_story = var_431_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_15 = 0.200000002980232

			if var_431_14 <= arg_428_1.time_ and arg_428_1.time_ < var_431_14 + var_431_15 and not isNil(var_431_13) then
				local var_431_16 = (arg_428_1.time_ - var_431_14) / var_431_15

				if arg_428_1.var_.characterEffect10145ui_story and not isNil(var_431_13) then
					local var_431_17 = Mathf.Lerp(0, 0.5, var_431_16)

					arg_428_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_428_1.var_.characterEffect10145ui_story.fillRatio = var_431_17
				end
			end

			if arg_428_1.time_ >= var_431_14 + var_431_15 and arg_428_1.time_ < var_431_14 + var_431_15 + arg_431_0 and not isNil(var_431_13) and arg_428_1.var_.characterEffect10145ui_story then
				local var_431_18 = 0.5

				arg_428_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_428_1.var_.characterEffect10145ui_story.fillRatio = var_431_18
			end

			local var_431_19 = 0

			if var_431_19 < arg_428_1.time_ and arg_428_1.time_ <= var_431_19 + arg_431_0 then
				arg_428_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action8_1")
			end

			local var_431_20 = 0

			if var_431_20 < arg_428_1.time_ and arg_428_1.time_ <= var_431_20 + arg_431_0 then
				arg_428_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_431_21 = 0
			local var_431_22 = 0.175

			if var_431_21 < arg_428_1.time_ and arg_428_1.time_ <= var_431_21 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_23 = arg_428_1:FormatText(StoryNameCfg[1332].name)

				arg_428_1.leftNameTxt_.text = var_431_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_24 = arg_428_1:GetWordFromCfg(1108503102)
				local var_431_25 = arg_428_1:FormatText(var_431_24.content)

				arg_428_1.text_.text = var_431_25

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_26 = 7
				local var_431_27 = utf8.len(var_431_25)
				local var_431_28 = var_431_26 <= 0 and var_431_22 or var_431_22 * (var_431_27 / var_431_26)

				if var_431_28 > 0 and var_431_22 < var_431_28 then
					arg_428_1.talkMaxDuration = var_431_28

					if var_431_28 + var_431_21 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_28 + var_431_21
					end
				end

				arg_428_1.text_.text = var_431_25
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503102", "story_v_side_new_1108503.awb") ~= 0 then
					local var_431_29 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503102", "story_v_side_new_1108503.awb") / 1000

					if var_431_29 + var_431_21 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_29 + var_431_21
					end

					if var_431_24.prefab_name ~= "" and arg_428_1.actors_[var_431_24.prefab_name] ~= nil then
						local var_431_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_24.prefab_name].transform, "story_v_side_new_1108503", "1108503102", "story_v_side_new_1108503.awb")

						arg_428_1:RecordAudio("1108503102", var_431_30)
						arg_428_1:RecordAudio("1108503102", var_431_30)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503102", "story_v_side_new_1108503.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503102", "story_v_side_new_1108503.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_31 = math.max(var_431_22, arg_428_1.talkMaxDuration)

			if var_431_21 <= arg_428_1.time_ and arg_428_1.time_ < var_431_21 + var_431_31 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_21) / var_431_31

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_21 + var_431_31 and arg_428_1.time_ < var_431_21 + var_431_31 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_428_1:InitPlayNodeList()
	end,
	Play1108503103 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 1108503103
		arg_432_1.duration_ = 3.37

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play1108503104(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = arg_432_1.actors_["1085ui_story"].transform
			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 then
				arg_432_1.var_.moveOldPos1085ui_story = var_435_0.localPosition
			end

			local var_435_2 = 0.001

			if var_435_1 <= arg_432_1.time_ and arg_432_1.time_ < var_435_1 + var_435_2 then
				local var_435_3 = (arg_432_1.time_ - var_435_1) / var_435_2
				local var_435_4 = Vector3.New(-0.75, -1.01, -5.83)

				var_435_0.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos1085ui_story, var_435_4, var_435_3)

				local var_435_5 = manager.ui.mainCamera.transform.position - var_435_0.position

				var_435_0.forward = Vector3.New(var_435_5.x, var_435_5.y, var_435_5.z)

				local var_435_6 = var_435_0.localEulerAngles

				var_435_6.z = 0
				var_435_6.x = 0
				var_435_0.localEulerAngles = var_435_6
			end

			if arg_432_1.time_ >= var_435_1 + var_435_2 and arg_432_1.time_ < var_435_1 + var_435_2 + arg_435_0 then
				var_435_0.localPosition = Vector3.New(-0.75, -1.01, -5.83)

				local var_435_7 = manager.ui.mainCamera.transform.position - var_435_0.position

				var_435_0.forward = Vector3.New(var_435_7.x, var_435_7.y, var_435_7.z)

				local var_435_8 = var_435_0.localEulerAngles

				var_435_8.z = 0
				var_435_8.x = 0
				var_435_0.localEulerAngles = var_435_8
			end

			local var_435_9 = arg_432_1.actors_["10145ui_story"].transform
			local var_435_10 = 0

			if var_435_10 < arg_432_1.time_ and arg_432_1.time_ <= var_435_10 + arg_435_0 then
				arg_432_1.var_.moveOldPos10145ui_story = var_435_9.localPosition
			end

			local var_435_11 = 0.001

			if var_435_10 <= arg_432_1.time_ and arg_432_1.time_ < var_435_10 + var_435_11 then
				local var_435_12 = (arg_432_1.time_ - var_435_10) / var_435_11
				local var_435_13 = Vector3.New(0, 100, 0)

				var_435_9.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos10145ui_story, var_435_13, var_435_12)

				local var_435_14 = manager.ui.mainCamera.transform.position - var_435_9.position

				var_435_9.forward = Vector3.New(var_435_14.x, var_435_14.y, var_435_14.z)

				local var_435_15 = var_435_9.localEulerAngles

				var_435_15.z = 0
				var_435_15.x = 0
				var_435_9.localEulerAngles = var_435_15
			end

			if arg_432_1.time_ >= var_435_10 + var_435_11 and arg_432_1.time_ < var_435_10 + var_435_11 + arg_435_0 then
				var_435_9.localPosition = Vector3.New(0, 100, 0)

				local var_435_16 = manager.ui.mainCamera.transform.position - var_435_9.position

				var_435_9.forward = Vector3.New(var_435_16.x, var_435_16.y, var_435_16.z)

				local var_435_17 = var_435_9.localEulerAngles

				var_435_17.z = 0
				var_435_17.x = 0
				var_435_9.localEulerAngles = var_435_17
			end

			local var_435_18 = arg_432_1.actors_["1085ui_story"]
			local var_435_19 = 0

			if var_435_19 < arg_432_1.time_ and arg_432_1.time_ <= var_435_19 + arg_435_0 and not isNil(var_435_18) and arg_432_1.var_.characterEffect1085ui_story == nil then
				arg_432_1.var_.characterEffect1085ui_story = var_435_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_20 = 0.200000002980232

			if var_435_19 <= arg_432_1.time_ and arg_432_1.time_ < var_435_19 + var_435_20 and not isNil(var_435_18) then
				local var_435_21 = (arg_432_1.time_ - var_435_19) / var_435_20

				if arg_432_1.var_.characterEffect1085ui_story and not isNil(var_435_18) then
					arg_432_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_432_1.time_ >= var_435_19 + var_435_20 and arg_432_1.time_ < var_435_19 + var_435_20 + arg_435_0 and not isNil(var_435_18) and arg_432_1.var_.characterEffect1085ui_story then
				arg_432_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_435_22 = arg_432_1.actors_["1083ui_story"]
			local var_435_23 = 0

			if var_435_23 < arg_432_1.time_ and arg_432_1.time_ <= var_435_23 + arg_435_0 and not isNil(var_435_22) and arg_432_1.var_.characterEffect1083ui_story == nil then
				arg_432_1.var_.characterEffect1083ui_story = var_435_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_24 = 0.200000002980232

			if var_435_23 <= arg_432_1.time_ and arg_432_1.time_ < var_435_23 + var_435_24 and not isNil(var_435_22) then
				local var_435_25 = (arg_432_1.time_ - var_435_23) / var_435_24

				if arg_432_1.var_.characterEffect1083ui_story and not isNil(var_435_22) then
					local var_435_26 = Mathf.Lerp(0, 0.5, var_435_25)

					arg_432_1.var_.characterEffect1083ui_story.fillFlat = true
					arg_432_1.var_.characterEffect1083ui_story.fillRatio = var_435_26
				end
			end

			if arg_432_1.time_ >= var_435_23 + var_435_24 and arg_432_1.time_ < var_435_23 + var_435_24 + arg_435_0 and not isNil(var_435_22) and arg_432_1.var_.characterEffect1083ui_story then
				local var_435_27 = 0.5

				arg_432_1.var_.characterEffect1083ui_story.fillFlat = true
				arg_432_1.var_.characterEffect1083ui_story.fillRatio = var_435_27
			end

			local var_435_28 = 0

			if var_435_28 < arg_432_1.time_ and arg_432_1.time_ <= var_435_28 + arg_435_0 then
				arg_432_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_435_29 = 0

			if var_435_29 < arg_432_1.time_ and arg_432_1.time_ <= var_435_29 + arg_435_0 then
				arg_432_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_435_30 = 0
			local var_435_31 = 0.225

			if var_435_30 < arg_432_1.time_ and arg_432_1.time_ <= var_435_30 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_32 = arg_432_1:FormatText(StoryNameCfg[328].name)

				arg_432_1.leftNameTxt_.text = var_435_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_33 = arg_432_1:GetWordFromCfg(1108503103)
				local var_435_34 = arg_432_1:FormatText(var_435_33.content)

				arg_432_1.text_.text = var_435_34

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_35 = 9
				local var_435_36 = utf8.len(var_435_34)
				local var_435_37 = var_435_35 <= 0 and var_435_31 or var_435_31 * (var_435_36 / var_435_35)

				if var_435_37 > 0 and var_435_31 < var_435_37 then
					arg_432_1.talkMaxDuration = var_435_37

					if var_435_37 + var_435_30 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_37 + var_435_30
					end
				end

				arg_432_1.text_.text = var_435_34
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503103", "story_v_side_new_1108503.awb") ~= 0 then
					local var_435_38 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503103", "story_v_side_new_1108503.awb") / 1000

					if var_435_38 + var_435_30 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_38 + var_435_30
					end

					if var_435_33.prefab_name ~= "" and arg_432_1.actors_[var_435_33.prefab_name] ~= nil then
						local var_435_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_33.prefab_name].transform, "story_v_side_new_1108503", "1108503103", "story_v_side_new_1108503.awb")

						arg_432_1:RecordAudio("1108503103", var_435_39)
						arg_432_1:RecordAudio("1108503103", var_435_39)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503103", "story_v_side_new_1108503.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503103", "story_v_side_new_1108503.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_40 = math.max(var_435_31, arg_432_1.talkMaxDuration)

			if var_435_30 <= arg_432_1.time_ and arg_432_1.time_ < var_435_30 + var_435_40 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_30) / var_435_40

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_30 + var_435_40 and arg_432_1.time_ < var_435_30 + var_435_40 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play1108503104 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 1108503104
		arg_436_1.duration_ = 3.47

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play1108503105(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["1083ui_story"].transform
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 then
				arg_436_1.var_.moveOldPos1083ui_story = var_439_0.localPosition
			end

			local var_439_2 = 0.001

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2
				local var_439_4 = Vector3.New(0.7, -1.05, -6)

				var_439_0.localPosition = Vector3.Lerp(arg_436_1.var_.moveOldPos1083ui_story, var_439_4, var_439_3)

				local var_439_5 = manager.ui.mainCamera.transform.position - var_439_0.position

				var_439_0.forward = Vector3.New(var_439_5.x, var_439_5.y, var_439_5.z)

				local var_439_6 = var_439_0.localEulerAngles

				var_439_6.z = 0
				var_439_6.x = 0
				var_439_0.localEulerAngles = var_439_6
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 then
				var_439_0.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_439_7 = manager.ui.mainCamera.transform.position - var_439_0.position

				var_439_0.forward = Vector3.New(var_439_7.x, var_439_7.y, var_439_7.z)

				local var_439_8 = var_439_0.localEulerAngles

				var_439_8.z = 0
				var_439_8.x = 0
				var_439_0.localEulerAngles = var_439_8
			end

			local var_439_9 = arg_436_1.actors_["1083ui_story"]
			local var_439_10 = 0

			if var_439_10 < arg_436_1.time_ and arg_436_1.time_ <= var_439_10 + arg_439_0 and not isNil(var_439_9) and arg_436_1.var_.characterEffect1083ui_story == nil then
				arg_436_1.var_.characterEffect1083ui_story = var_439_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_11 = 0.200000002980232

			if var_439_10 <= arg_436_1.time_ and arg_436_1.time_ < var_439_10 + var_439_11 and not isNil(var_439_9) then
				local var_439_12 = (arg_436_1.time_ - var_439_10) / var_439_11

				if arg_436_1.var_.characterEffect1083ui_story and not isNil(var_439_9) then
					arg_436_1.var_.characterEffect1083ui_story.fillFlat = false
				end
			end

			if arg_436_1.time_ >= var_439_10 + var_439_11 and arg_436_1.time_ < var_439_10 + var_439_11 + arg_439_0 and not isNil(var_439_9) and arg_436_1.var_.characterEffect1083ui_story then
				arg_436_1.var_.characterEffect1083ui_story.fillFlat = false
			end

			local var_439_13 = arg_436_1.actors_["1085ui_story"]
			local var_439_14 = 0

			if var_439_14 < arg_436_1.time_ and arg_436_1.time_ <= var_439_14 + arg_439_0 and not isNil(var_439_13) and arg_436_1.var_.characterEffect1085ui_story == nil then
				arg_436_1.var_.characterEffect1085ui_story = var_439_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_15 = 0.200000002980232

			if var_439_14 <= arg_436_1.time_ and arg_436_1.time_ < var_439_14 + var_439_15 and not isNil(var_439_13) then
				local var_439_16 = (arg_436_1.time_ - var_439_14) / var_439_15

				if arg_436_1.var_.characterEffect1085ui_story and not isNil(var_439_13) then
					local var_439_17 = Mathf.Lerp(0, 0.5, var_439_16)

					arg_436_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_436_1.var_.characterEffect1085ui_story.fillRatio = var_439_17
				end
			end

			if arg_436_1.time_ >= var_439_14 + var_439_15 and arg_436_1.time_ < var_439_14 + var_439_15 + arg_439_0 and not isNil(var_439_13) and arg_436_1.var_.characterEffect1085ui_story then
				local var_439_18 = 0.5

				arg_436_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_436_1.var_.characterEffect1085ui_story.fillRatio = var_439_18
			end

			local var_439_19 = 0

			if var_439_19 < arg_436_1.time_ and arg_436_1.time_ <= var_439_19 + arg_439_0 then
				arg_436_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action8_2")
			end

			local var_439_20 = 0

			if var_439_20 < arg_436_1.time_ and arg_436_1.time_ <= var_439_20 + arg_439_0 then
				arg_436_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_439_21 = 0
			local var_439_22 = 0.325

			if var_439_21 < arg_436_1.time_ and arg_436_1.time_ <= var_439_21 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, true)

				local var_439_23 = arg_436_1:FormatText(StoryNameCfg[1332].name)

				arg_436_1.leftNameTxt_.text = var_439_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_436_1.leftNameTxt_.transform)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1.leftNameTxt_.text)
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_24 = arg_436_1:GetWordFromCfg(1108503104)
				local var_439_25 = arg_436_1:FormatText(var_439_24.content)

				arg_436_1.text_.text = var_439_25

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_26 = 13
				local var_439_27 = utf8.len(var_439_25)
				local var_439_28 = var_439_26 <= 0 and var_439_22 or var_439_22 * (var_439_27 / var_439_26)

				if var_439_28 > 0 and var_439_22 < var_439_28 then
					arg_436_1.talkMaxDuration = var_439_28

					if var_439_28 + var_439_21 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_28 + var_439_21
					end
				end

				arg_436_1.text_.text = var_439_25
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503104", "story_v_side_new_1108503.awb") ~= 0 then
					local var_439_29 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503104", "story_v_side_new_1108503.awb") / 1000

					if var_439_29 + var_439_21 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_29 + var_439_21
					end

					if var_439_24.prefab_name ~= "" and arg_436_1.actors_[var_439_24.prefab_name] ~= nil then
						local var_439_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_436_1.actors_[var_439_24.prefab_name].transform, "story_v_side_new_1108503", "1108503104", "story_v_side_new_1108503.awb")

						arg_436_1:RecordAudio("1108503104", var_439_30)
						arg_436_1:RecordAudio("1108503104", var_439_30)
					else
						arg_436_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503104", "story_v_side_new_1108503.awb")
					end

					arg_436_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503104", "story_v_side_new_1108503.awb")
				end

				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_31 = math.max(var_439_22, arg_436_1.talkMaxDuration)

			if var_439_21 <= arg_436_1.time_ and arg_436_1.time_ < var_439_21 + var_439_31 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_21) / var_439_31

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_21 + var_439_31 and arg_436_1.time_ < var_439_21 + var_439_31 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_436_1:InitPlayNodeList()
	end,
	Play1108503105 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 1108503105
		arg_440_1.duration_ = 7.9

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play1108503106(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = arg_440_1.actors_["1085ui_story"].transform
			local var_443_1 = 0

			if var_443_1 < arg_440_1.time_ and arg_440_1.time_ <= var_443_1 + arg_443_0 then
				arg_440_1.var_.moveOldPos1085ui_story = var_443_0.localPosition
			end

			local var_443_2 = 0.001

			if var_443_1 <= arg_440_1.time_ and arg_440_1.time_ < var_443_1 + var_443_2 then
				local var_443_3 = (arg_440_1.time_ - var_443_1) / var_443_2
				local var_443_4 = Vector3.New(-0.75, -1.01, -5.83)

				var_443_0.localPosition = Vector3.Lerp(arg_440_1.var_.moveOldPos1085ui_story, var_443_4, var_443_3)

				local var_443_5 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_5.x, var_443_5.y, var_443_5.z)

				local var_443_6 = var_443_0.localEulerAngles

				var_443_6.z = 0
				var_443_6.x = 0
				var_443_0.localEulerAngles = var_443_6
			end

			if arg_440_1.time_ >= var_443_1 + var_443_2 and arg_440_1.time_ < var_443_1 + var_443_2 + arg_443_0 then
				var_443_0.localPosition = Vector3.New(-0.75, -1.01, -5.83)

				local var_443_7 = manager.ui.mainCamera.transform.position - var_443_0.position

				var_443_0.forward = Vector3.New(var_443_7.x, var_443_7.y, var_443_7.z)

				local var_443_8 = var_443_0.localEulerAngles

				var_443_8.z = 0
				var_443_8.x = 0
				var_443_0.localEulerAngles = var_443_8
			end

			local var_443_9 = arg_440_1.actors_["1085ui_story"]
			local var_443_10 = 0

			if var_443_10 < arg_440_1.time_ and arg_440_1.time_ <= var_443_10 + arg_443_0 and not isNil(var_443_9) and arg_440_1.var_.characterEffect1085ui_story == nil then
				arg_440_1.var_.characterEffect1085ui_story = var_443_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_11 = 0.200000002980232

			if var_443_10 <= arg_440_1.time_ and arg_440_1.time_ < var_443_10 + var_443_11 and not isNil(var_443_9) then
				local var_443_12 = (arg_440_1.time_ - var_443_10) / var_443_11

				if arg_440_1.var_.characterEffect1085ui_story and not isNil(var_443_9) then
					arg_440_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_440_1.time_ >= var_443_10 + var_443_11 and arg_440_1.time_ < var_443_10 + var_443_11 + arg_443_0 and not isNil(var_443_9) and arg_440_1.var_.characterEffect1085ui_story then
				arg_440_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_443_13 = arg_440_1.actors_["1083ui_story"]
			local var_443_14 = 0

			if var_443_14 < arg_440_1.time_ and arg_440_1.time_ <= var_443_14 + arg_443_0 and not isNil(var_443_13) and arg_440_1.var_.characterEffect1083ui_story == nil then
				arg_440_1.var_.characterEffect1083ui_story = var_443_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_443_15 = 0.200000002980232

			if var_443_14 <= arg_440_1.time_ and arg_440_1.time_ < var_443_14 + var_443_15 and not isNil(var_443_13) then
				local var_443_16 = (arg_440_1.time_ - var_443_14) / var_443_15

				if arg_440_1.var_.characterEffect1083ui_story and not isNil(var_443_13) then
					local var_443_17 = Mathf.Lerp(0, 0.5, var_443_16)

					arg_440_1.var_.characterEffect1083ui_story.fillFlat = true
					arg_440_1.var_.characterEffect1083ui_story.fillRatio = var_443_17
				end
			end

			if arg_440_1.time_ >= var_443_14 + var_443_15 and arg_440_1.time_ < var_443_14 + var_443_15 + arg_443_0 and not isNil(var_443_13) and arg_440_1.var_.characterEffect1083ui_story then
				local var_443_18 = 0.5

				arg_440_1.var_.characterEffect1083ui_story.fillFlat = true
				arg_440_1.var_.characterEffect1083ui_story.fillRatio = var_443_18
			end

			local var_443_19 = 0

			if var_443_19 < arg_440_1.time_ and arg_440_1.time_ <= var_443_19 + arg_443_0 then
				arg_440_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_2")
			end

			local var_443_20 = 0

			if var_443_20 < arg_440_1.time_ and arg_440_1.time_ <= var_443_20 + arg_443_0 then
				arg_440_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_443_21 = 0
			local var_443_22 = 0.6

			if var_443_21 < arg_440_1.time_ and arg_440_1.time_ <= var_443_21 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				local var_443_23 = arg_440_1:FormatText(StoryNameCfg[328].name)

				arg_440_1.leftNameTxt_.text = var_443_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_24 = arg_440_1:GetWordFromCfg(1108503105)
				local var_443_25 = arg_440_1:FormatText(var_443_24.content)

				arg_440_1.text_.text = var_443_25

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_26 = 24
				local var_443_27 = utf8.len(var_443_25)
				local var_443_28 = var_443_26 <= 0 and var_443_22 or var_443_22 * (var_443_27 / var_443_26)

				if var_443_28 > 0 and var_443_22 < var_443_28 then
					arg_440_1.talkMaxDuration = var_443_28

					if var_443_28 + var_443_21 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_28 + var_443_21
					end
				end

				arg_440_1.text_.text = var_443_25
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503105", "story_v_side_new_1108503.awb") ~= 0 then
					local var_443_29 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503105", "story_v_side_new_1108503.awb") / 1000

					if var_443_29 + var_443_21 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_29 + var_443_21
					end

					if var_443_24.prefab_name ~= "" and arg_440_1.actors_[var_443_24.prefab_name] ~= nil then
						local var_443_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_24.prefab_name].transform, "story_v_side_new_1108503", "1108503105", "story_v_side_new_1108503.awb")

						arg_440_1:RecordAudio("1108503105", var_443_30)
						arg_440_1:RecordAudio("1108503105", var_443_30)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503105", "story_v_side_new_1108503.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503105", "story_v_side_new_1108503.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_31 = math.max(var_443_22, arg_440_1.talkMaxDuration)

			if var_443_21 <= arg_440_1.time_ and arg_440_1.time_ < var_443_21 + var_443_31 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_21) / var_443_31

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_21 + var_443_31 and arg_440_1.time_ < var_443_21 + var_443_31 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {
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

		arg_440_1:InitPlayNodeList()
	end,
	Play1108503106 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 1108503106
		arg_444_1.duration_ = 5.6

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play1108503107(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = arg_444_1.actors_["1085ui_story"].transform
			local var_447_1 = 0

			if var_447_1 < arg_444_1.time_ and arg_444_1.time_ <= var_447_1 + arg_447_0 then
				arg_444_1.var_.moveOldPos1085ui_story = var_447_0.localPosition
			end

			local var_447_2 = 0.001

			if var_447_1 <= arg_444_1.time_ and arg_444_1.time_ < var_447_1 + var_447_2 then
				local var_447_3 = (arg_444_1.time_ - var_447_1) / var_447_2
				local var_447_4 = Vector3.New(-0.75, -1.01, -5.83)

				var_447_0.localPosition = Vector3.Lerp(arg_444_1.var_.moveOldPos1085ui_story, var_447_4, var_447_3)

				local var_447_5 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_5.x, var_447_5.y, var_447_5.z)

				local var_447_6 = var_447_0.localEulerAngles

				var_447_6.z = 0
				var_447_6.x = 0
				var_447_0.localEulerAngles = var_447_6
			end

			if arg_444_1.time_ >= var_447_1 + var_447_2 and arg_444_1.time_ < var_447_1 + var_447_2 + arg_447_0 then
				var_447_0.localPosition = Vector3.New(-0.75, -1.01, -5.83)

				local var_447_7 = manager.ui.mainCamera.transform.position - var_447_0.position

				var_447_0.forward = Vector3.New(var_447_7.x, var_447_7.y, var_447_7.z)

				local var_447_8 = var_447_0.localEulerAngles

				var_447_8.z = 0
				var_447_8.x = 0
				var_447_0.localEulerAngles = var_447_8
			end

			local var_447_9 = 0

			if var_447_9 < arg_444_1.time_ and arg_444_1.time_ <= var_447_9 + arg_447_0 then
				arg_444_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_447_10 = 0

			if var_447_10 < arg_444_1.time_ and arg_444_1.time_ <= var_447_10 + arg_447_0 then
				arg_444_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_447_11 = 0
			local var_447_12 = 0.375

			if var_447_11 < arg_444_1.time_ and arg_444_1.time_ <= var_447_11 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, true)

				local var_447_13 = arg_444_1:FormatText(StoryNameCfg[328].name)

				arg_444_1.leftNameTxt_.text = var_447_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_444_1.leftNameTxt_.transform)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1.leftNameTxt_.text)
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_14 = arg_444_1:GetWordFromCfg(1108503106)
				local var_447_15 = arg_444_1:FormatText(var_447_14.content)

				arg_444_1.text_.text = var_447_15

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_16 = 15
				local var_447_17 = utf8.len(var_447_15)
				local var_447_18 = var_447_16 <= 0 and var_447_12 or var_447_12 * (var_447_17 / var_447_16)

				if var_447_18 > 0 and var_447_12 < var_447_18 then
					arg_444_1.talkMaxDuration = var_447_18

					if var_447_18 + var_447_11 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_18 + var_447_11
					end
				end

				arg_444_1.text_.text = var_447_15
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503106", "story_v_side_new_1108503.awb") ~= 0 then
					local var_447_19 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503106", "story_v_side_new_1108503.awb") / 1000

					if var_447_19 + var_447_11 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_19 + var_447_11
					end

					if var_447_14.prefab_name ~= "" and arg_444_1.actors_[var_447_14.prefab_name] ~= nil then
						local var_447_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_444_1.actors_[var_447_14.prefab_name].transform, "story_v_side_new_1108503", "1108503106", "story_v_side_new_1108503.awb")

						arg_444_1:RecordAudio("1108503106", var_447_20)
						arg_444_1:RecordAudio("1108503106", var_447_20)
					else
						arg_444_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503106", "story_v_side_new_1108503.awb")
					end

					arg_444_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503106", "story_v_side_new_1108503.awb")
				end

				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_21 = math.max(var_447_12, arg_444_1.talkMaxDuration)

			if var_447_11 <= arg_444_1.time_ and arg_444_1.time_ < var_447_11 + var_447_21 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_11) / var_447_21

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_11 + var_447_21 and arg_444_1.time_ < var_447_11 + var_447_21 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {
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

		arg_444_1:InitPlayNodeList()
	end,
	Play1108503107 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 1108503107
		arg_448_1.duration_ = 2.67

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play1108503108(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = arg_448_1.actors_["1083ui_story"].transform
			local var_451_1 = 0

			if var_451_1 < arg_448_1.time_ and arg_448_1.time_ <= var_451_1 + arg_451_0 then
				arg_448_1.var_.moveOldPos1083ui_story = var_451_0.localPosition
			end

			local var_451_2 = 0.001

			if var_451_1 <= arg_448_1.time_ and arg_448_1.time_ < var_451_1 + var_451_2 then
				local var_451_3 = (arg_448_1.time_ - var_451_1) / var_451_2
				local var_451_4 = Vector3.New(0.7, -1.05, -6)

				var_451_0.localPosition = Vector3.Lerp(arg_448_1.var_.moveOldPos1083ui_story, var_451_4, var_451_3)

				local var_451_5 = manager.ui.mainCamera.transform.position - var_451_0.position

				var_451_0.forward = Vector3.New(var_451_5.x, var_451_5.y, var_451_5.z)

				local var_451_6 = var_451_0.localEulerAngles

				var_451_6.z = 0
				var_451_6.x = 0
				var_451_0.localEulerAngles = var_451_6
			end

			if arg_448_1.time_ >= var_451_1 + var_451_2 and arg_448_1.time_ < var_451_1 + var_451_2 + arg_451_0 then
				var_451_0.localPosition = Vector3.New(0.7, -1.05, -6)

				local var_451_7 = manager.ui.mainCamera.transform.position - var_451_0.position

				var_451_0.forward = Vector3.New(var_451_7.x, var_451_7.y, var_451_7.z)

				local var_451_8 = var_451_0.localEulerAngles

				var_451_8.z = 0
				var_451_8.x = 0
				var_451_0.localEulerAngles = var_451_8
			end

			local var_451_9 = arg_448_1.actors_["1083ui_story"]
			local var_451_10 = 0

			if var_451_10 < arg_448_1.time_ and arg_448_1.time_ <= var_451_10 + arg_451_0 and not isNil(var_451_9) and arg_448_1.var_.characterEffect1083ui_story == nil then
				arg_448_1.var_.characterEffect1083ui_story = var_451_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_11 = 0.200000002980232

			if var_451_10 <= arg_448_1.time_ and arg_448_1.time_ < var_451_10 + var_451_11 and not isNil(var_451_9) then
				local var_451_12 = (arg_448_1.time_ - var_451_10) / var_451_11

				if arg_448_1.var_.characterEffect1083ui_story and not isNil(var_451_9) then
					arg_448_1.var_.characterEffect1083ui_story.fillFlat = false
				end
			end

			if arg_448_1.time_ >= var_451_10 + var_451_11 and arg_448_1.time_ < var_451_10 + var_451_11 + arg_451_0 and not isNil(var_451_9) and arg_448_1.var_.characterEffect1083ui_story then
				arg_448_1.var_.characterEffect1083ui_story.fillFlat = false
			end

			local var_451_13 = arg_448_1.actors_["1085ui_story"]
			local var_451_14 = 0

			if var_451_14 < arg_448_1.time_ and arg_448_1.time_ <= var_451_14 + arg_451_0 and not isNil(var_451_13) and arg_448_1.var_.characterEffect1085ui_story == nil then
				arg_448_1.var_.characterEffect1085ui_story = var_451_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_451_15 = 0.200000002980232

			if var_451_14 <= arg_448_1.time_ and arg_448_1.time_ < var_451_14 + var_451_15 and not isNil(var_451_13) then
				local var_451_16 = (arg_448_1.time_ - var_451_14) / var_451_15

				if arg_448_1.var_.characterEffect1085ui_story and not isNil(var_451_13) then
					local var_451_17 = Mathf.Lerp(0, 0.5, var_451_16)

					arg_448_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_448_1.var_.characterEffect1085ui_story.fillRatio = var_451_17
				end
			end

			if arg_448_1.time_ >= var_451_14 + var_451_15 and arg_448_1.time_ < var_451_14 + var_451_15 + arg_451_0 and not isNil(var_451_13) and arg_448_1.var_.characterEffect1085ui_story then
				local var_451_18 = 0.5

				arg_448_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_448_1.var_.characterEffect1085ui_story.fillRatio = var_451_18
			end

			local var_451_19 = 0

			if var_451_19 < arg_448_1.time_ and arg_448_1.time_ <= var_451_19 + arg_451_0 then
				arg_448_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/story1083/story1083action/1083action1_1")
			end

			local var_451_20 = 0

			if var_451_20 < arg_448_1.time_ and arg_448_1.time_ <= var_451_20 + arg_451_0 then
				arg_448_1:PlayTimeline("1083ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_451_21 = 0.200000002980232
			local var_451_22 = 0.3

			if var_451_21 < arg_448_1.time_ and arg_448_1.time_ <= var_451_21 + arg_451_0 then
				local var_451_23 = "play"
				local var_451_24 = "music"

				arg_448_1:AudioAction(var_451_23, var_451_24, "ui_battle", "ui_battle_stopbgm", "")

				local var_451_25 = ""
				local var_451_26 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_451_26 ~= "" then
					if arg_448_1.bgmTxt_.text ~= var_451_26 and arg_448_1.bgmTxt_.text ~= "" then
						if arg_448_1.bgmTxt2_.text ~= "" then
							arg_448_1.bgmTxt_.text = arg_448_1.bgmTxt2_.text
						end

						arg_448_1.bgmTxt2_.text = var_451_26

						arg_448_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_448_1.bgmTxt_.text = var_451_26
						arg_448_1.bgmTxt2_.text = var_451_26
					end

					if arg_448_1.bgmTimer then
						arg_448_1.bgmTimer:Stop()

						arg_448_1.bgmTimer = nil
					end

					if arg_448_1.settingData.show_music_name == 1 then
						arg_448_1.musicController:SetSelectedState("show")
						arg_448_1.musicAnimator_:Play("open", 0, 0)

						if arg_448_1.settingData.music_time ~= 0 then
							arg_448_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_448_1.settingData.music_time), function()
								if arg_448_1 == nil or isNil(arg_448_1.bgmTxt_) then
									return
								end

								arg_448_1.musicController:SetSelectedState("hide")
								arg_448_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_451_27 = 0
			local var_451_28 = 0.25

			if var_451_27 < arg_448_1.time_ and arg_448_1.time_ <= var_451_27 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				local var_451_29 = arg_448_1:FormatText(StoryNameCfg[1332].name)

				arg_448_1.leftNameTxt_.text = var_451_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, false)
				arg_448_1.callingController_:SetSelectedState("normal")

				local var_451_30 = arg_448_1:GetWordFromCfg(1108503107)
				local var_451_31 = arg_448_1:FormatText(var_451_30.content)

				arg_448_1.text_.text = var_451_31

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_32 = 10
				local var_451_33 = utf8.len(var_451_31)
				local var_451_34 = var_451_32 <= 0 and var_451_28 or var_451_28 * (var_451_33 / var_451_32)

				if var_451_34 > 0 and var_451_28 < var_451_34 then
					arg_448_1.talkMaxDuration = var_451_34

					if var_451_34 + var_451_27 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_34 + var_451_27
					end
				end

				arg_448_1.text_.text = var_451_31
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503107", "story_v_side_new_1108503.awb") ~= 0 then
					local var_451_35 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503107", "story_v_side_new_1108503.awb") / 1000

					if var_451_35 + var_451_27 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_35 + var_451_27
					end

					if var_451_30.prefab_name ~= "" and arg_448_1.actors_[var_451_30.prefab_name] ~= nil then
						local var_451_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_30.prefab_name].transform, "story_v_side_new_1108503", "1108503107", "story_v_side_new_1108503.awb")

						arg_448_1:RecordAudio("1108503107", var_451_36)
						arg_448_1:RecordAudio("1108503107", var_451_36)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503107", "story_v_side_new_1108503.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503107", "story_v_side_new_1108503.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_37 = math.max(var_451_28, arg_448_1.talkMaxDuration)

			if var_451_27 <= arg_448_1.time_ and arg_448_1.time_ < var_451_27 + var_451_37 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - var_451_27) / var_451_37

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= var_451_27 + var_451_37 and arg_448_1.time_ < var_451_27 + var_451_37 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_448_1:InitPlayNodeList()
	end,
	Play1108503108 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 1108503108
		arg_453_1.duration_ = 11.83

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play1108503109(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			local var_456_0 = arg_453_1.actors_["1085ui_story"].transform
			local var_456_1 = 0

			if var_456_1 < arg_453_1.time_ and arg_453_1.time_ <= var_456_1 + arg_456_0 then
				arg_453_1.var_.moveOldPos1085ui_story = var_456_0.localPosition
			end

			local var_456_2 = 0.001

			if var_456_1 <= arg_453_1.time_ and arg_453_1.time_ < var_456_1 + var_456_2 then
				local var_456_3 = (arg_453_1.time_ - var_456_1) / var_456_2
				local var_456_4 = Vector3.New(-0.75, -1.01, -5.83)

				var_456_0.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1085ui_story, var_456_4, var_456_3)

				local var_456_5 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_5.x, var_456_5.y, var_456_5.z)

				local var_456_6 = var_456_0.localEulerAngles

				var_456_6.z = 0
				var_456_6.x = 0
				var_456_0.localEulerAngles = var_456_6
			end

			if arg_453_1.time_ >= var_456_1 + var_456_2 and arg_453_1.time_ < var_456_1 + var_456_2 + arg_456_0 then
				var_456_0.localPosition = Vector3.New(-0.75, -1.01, -5.83)

				local var_456_7 = manager.ui.mainCamera.transform.position - var_456_0.position

				var_456_0.forward = Vector3.New(var_456_7.x, var_456_7.y, var_456_7.z)

				local var_456_8 = var_456_0.localEulerAngles

				var_456_8.z = 0
				var_456_8.x = 0
				var_456_0.localEulerAngles = var_456_8
			end

			local var_456_9 = arg_453_1.actors_["1085ui_story"]
			local var_456_10 = 0

			if var_456_10 < arg_453_1.time_ and arg_453_1.time_ <= var_456_10 + arg_456_0 and not isNil(var_456_9) and arg_453_1.var_.characterEffect1085ui_story == nil then
				arg_453_1.var_.characterEffect1085ui_story = var_456_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_11 = 0.200000002980232

			if var_456_10 <= arg_453_1.time_ and arg_453_1.time_ < var_456_10 + var_456_11 and not isNil(var_456_9) then
				local var_456_12 = (arg_453_1.time_ - var_456_10) / var_456_11

				if arg_453_1.var_.characterEffect1085ui_story and not isNil(var_456_9) then
					arg_453_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= var_456_10 + var_456_11 and arg_453_1.time_ < var_456_10 + var_456_11 + arg_456_0 and not isNil(var_456_9) and arg_453_1.var_.characterEffect1085ui_story then
				arg_453_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_456_13 = arg_453_1.actors_["1083ui_story"]
			local var_456_14 = 0

			if var_456_14 < arg_453_1.time_ and arg_453_1.time_ <= var_456_14 + arg_456_0 and not isNil(var_456_13) and arg_453_1.var_.characterEffect1083ui_story == nil then
				arg_453_1.var_.characterEffect1083ui_story = var_456_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_15 = 0.200000002980232

			if var_456_14 <= arg_453_1.time_ and arg_453_1.time_ < var_456_14 + var_456_15 and not isNil(var_456_13) then
				local var_456_16 = (arg_453_1.time_ - var_456_14) / var_456_15

				if arg_453_1.var_.characterEffect1083ui_story and not isNil(var_456_13) then
					local var_456_17 = Mathf.Lerp(0, 0.5, var_456_16)

					arg_453_1.var_.characterEffect1083ui_story.fillFlat = true
					arg_453_1.var_.characterEffect1083ui_story.fillRatio = var_456_17
				end
			end

			if arg_453_1.time_ >= var_456_14 + var_456_15 and arg_453_1.time_ < var_456_14 + var_456_15 + arg_456_0 and not isNil(var_456_13) and arg_453_1.var_.characterEffect1083ui_story then
				local var_456_18 = 0.5

				arg_453_1.var_.characterEffect1083ui_story.fillFlat = true
				arg_453_1.var_.characterEffect1083ui_story.fillRatio = var_456_18
			end

			local var_456_19 = 0

			if var_456_19 < arg_453_1.time_ and arg_453_1.time_ <= var_456_19 + arg_456_0 then
				arg_453_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_2")
			end

			local var_456_20 = 0

			if var_456_20 < arg_453_1.time_ and arg_453_1.time_ <= var_456_20 + arg_456_0 then
				arg_453_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_456_21 = 0
			local var_456_22 = 0.575

			if var_456_21 < arg_453_1.time_ and arg_453_1.time_ <= var_456_21 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				local var_456_23 = arg_453_1:FormatText(StoryNameCfg[328].name)

				arg_453_1.leftNameTxt_.text = var_456_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_24 = arg_453_1:GetWordFromCfg(1108503108)
				local var_456_25 = arg_453_1:FormatText(var_456_24.content)

				arg_453_1.text_.text = var_456_25

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_26 = 23
				local var_456_27 = utf8.len(var_456_25)
				local var_456_28 = var_456_26 <= 0 and var_456_22 or var_456_22 * (var_456_27 / var_456_26)

				if var_456_28 > 0 and var_456_22 < var_456_28 then
					arg_453_1.talkMaxDuration = var_456_28

					if var_456_28 + var_456_21 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_28 + var_456_21
					end
				end

				arg_453_1.text_.text = var_456_25
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503108", "story_v_side_new_1108503.awb") ~= 0 then
					local var_456_29 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503108", "story_v_side_new_1108503.awb") / 1000

					if var_456_29 + var_456_21 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_29 + var_456_21
					end

					if var_456_24.prefab_name ~= "" and arg_453_1.actors_[var_456_24.prefab_name] ~= nil then
						local var_456_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_24.prefab_name].transform, "story_v_side_new_1108503", "1108503108", "story_v_side_new_1108503.awb")

						arg_453_1:RecordAudio("1108503108", var_456_30)
						arg_453_1:RecordAudio("1108503108", var_456_30)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503108", "story_v_side_new_1108503.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503108", "story_v_side_new_1108503.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_31 = math.max(var_456_22, arg_453_1.talkMaxDuration)

			if var_456_21 <= arg_453_1.time_ and arg_453_1.time_ < var_456_21 + var_456_31 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_21) / var_456_31

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_21 + var_456_31 and arg_453_1.time_ < var_456_21 + var_456_31 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
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

		arg_453_1:InitPlayNodeList()
	end,
	Play1108503109 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 1108503109
		arg_457_1.duration_ = 9

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play1108503110(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			local var_460_0 = 2

			if var_460_0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_0 + arg_460_0 then
				local var_460_1 = manager.ui.mainCamera.transform.localPosition
				local var_460_2 = Vector3.New(0, 0, 10) + Vector3.New(var_460_1.x, var_460_1.y, 0)
				local var_460_3 = arg_457_1.bgs_.B13

				var_460_3.transform.localPosition = var_460_2
				var_460_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_460_4 = var_460_3:GetComponent("SpriteRenderer")

				if var_460_4 and var_460_4.sprite then
					local var_460_5 = (var_460_3.transform.localPosition - var_460_1).z
					local var_460_6 = manager.ui.mainCameraCom_
					local var_460_7 = 2 * var_460_5 * Mathf.Tan(var_460_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_460_8 = var_460_7 * var_460_6.aspect
					local var_460_9 = var_460_4.sprite.bounds.size.x
					local var_460_10 = var_460_4.sprite.bounds.size.y
					local var_460_11 = var_460_8 / var_460_9
					local var_460_12 = var_460_7 / var_460_10
					local var_460_13 = var_460_12 < var_460_11 and var_460_11 or var_460_12

					var_460_3.transform.localScale = Vector3.New(var_460_13, var_460_13, 0)
				end

				for iter_460_0, iter_460_1 in pairs(arg_457_1.bgs_) do
					if iter_460_0 ~= "B13" then
						iter_460_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_460_14 = 4

			if var_460_14 < arg_457_1.time_ and arg_457_1.time_ <= var_460_14 + arg_460_0 then
				arg_457_1.allBtn_.enabled = false
			end

			local var_460_15 = 0.3

			if arg_457_1.time_ >= var_460_14 + var_460_15 and arg_457_1.time_ < var_460_14 + var_460_15 + arg_460_0 then
				arg_457_1.allBtn_.enabled = true
			end

			local var_460_16 = 0

			if var_460_16 < arg_457_1.time_ and arg_457_1.time_ <= var_460_16 + arg_460_0 then
				arg_457_1.mask_.enabled = true
				arg_457_1.mask_.raycastTarget = true

				arg_457_1:SetGaussion(false)
			end

			local var_460_17 = 2

			if var_460_16 <= arg_457_1.time_ and arg_457_1.time_ < var_460_16 + var_460_17 then
				local var_460_18 = (arg_457_1.time_ - var_460_16) / var_460_17
				local var_460_19 = Color.New(0, 0, 0)

				var_460_19.a = Mathf.Lerp(0, 1, var_460_18)
				arg_457_1.mask_.color = var_460_19
			end

			if arg_457_1.time_ >= var_460_16 + var_460_17 and arg_457_1.time_ < var_460_16 + var_460_17 + arg_460_0 then
				local var_460_20 = Color.New(0, 0, 0)

				var_460_20.a = 1
				arg_457_1.mask_.color = var_460_20
			end

			local var_460_21 = 2

			if var_460_21 < arg_457_1.time_ and arg_457_1.time_ <= var_460_21 + arg_460_0 then
				arg_457_1.mask_.enabled = true
				arg_457_1.mask_.raycastTarget = true

				arg_457_1:SetGaussion(false)
			end

			local var_460_22 = 2

			if var_460_21 <= arg_457_1.time_ and arg_457_1.time_ < var_460_21 + var_460_22 then
				local var_460_23 = (arg_457_1.time_ - var_460_21) / var_460_22
				local var_460_24 = Color.New(0, 0, 0)

				var_460_24.a = Mathf.Lerp(1, 0, var_460_23)
				arg_457_1.mask_.color = var_460_24
			end

			if arg_457_1.time_ >= var_460_21 + var_460_22 and arg_457_1.time_ < var_460_21 + var_460_22 + arg_460_0 then
				local var_460_25 = Color.New(0, 0, 0)
				local var_460_26 = 0

				arg_457_1.mask_.enabled = false
				var_460_25.a = var_460_26
				arg_457_1.mask_.color = var_460_25
			end

			local var_460_27 = arg_457_1.actors_["1085ui_story"].transform
			local var_460_28 = 1.96599999815226

			if var_460_28 < arg_457_1.time_ and arg_457_1.time_ <= var_460_28 + arg_460_0 then
				arg_457_1.var_.moveOldPos1085ui_story = var_460_27.localPosition
			end

			local var_460_29 = 0.001

			if var_460_28 <= arg_457_1.time_ and arg_457_1.time_ < var_460_28 + var_460_29 then
				local var_460_30 = (arg_457_1.time_ - var_460_28) / var_460_29
				local var_460_31 = Vector3.New(0, 100, 0)

				var_460_27.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1085ui_story, var_460_31, var_460_30)

				local var_460_32 = manager.ui.mainCamera.transform.position - var_460_27.position

				var_460_27.forward = Vector3.New(var_460_32.x, var_460_32.y, var_460_32.z)

				local var_460_33 = var_460_27.localEulerAngles

				var_460_33.z = 0
				var_460_33.x = 0
				var_460_27.localEulerAngles = var_460_33
			end

			if arg_457_1.time_ >= var_460_28 + var_460_29 and arg_457_1.time_ < var_460_28 + var_460_29 + arg_460_0 then
				var_460_27.localPosition = Vector3.New(0, 100, 0)

				local var_460_34 = manager.ui.mainCamera.transform.position - var_460_27.position

				var_460_27.forward = Vector3.New(var_460_34.x, var_460_34.y, var_460_34.z)

				local var_460_35 = var_460_27.localEulerAngles

				var_460_35.z = 0
				var_460_35.x = 0
				var_460_27.localEulerAngles = var_460_35
			end

			local var_460_36 = arg_457_1.actors_["1083ui_story"].transform
			local var_460_37 = 1.96599999815226

			if var_460_37 < arg_457_1.time_ and arg_457_1.time_ <= var_460_37 + arg_460_0 then
				arg_457_1.var_.moveOldPos1083ui_story = var_460_36.localPosition
			end

			local var_460_38 = 0.001

			if var_460_37 <= arg_457_1.time_ and arg_457_1.time_ < var_460_37 + var_460_38 then
				local var_460_39 = (arg_457_1.time_ - var_460_37) / var_460_38
				local var_460_40 = Vector3.New(0, 100, 0)

				var_460_36.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos1083ui_story, var_460_40, var_460_39)

				local var_460_41 = manager.ui.mainCamera.transform.position - var_460_36.position

				var_460_36.forward = Vector3.New(var_460_41.x, var_460_41.y, var_460_41.z)

				local var_460_42 = var_460_36.localEulerAngles

				var_460_42.z = 0
				var_460_42.x = 0
				var_460_36.localEulerAngles = var_460_42
			end

			if arg_457_1.time_ >= var_460_37 + var_460_38 and arg_457_1.time_ < var_460_37 + var_460_38 + arg_460_0 then
				var_460_36.localPosition = Vector3.New(0, 100, 0)

				local var_460_43 = manager.ui.mainCamera.transform.position - var_460_36.position

				var_460_36.forward = Vector3.New(var_460_43.x, var_460_43.y, var_460_43.z)

				local var_460_44 = var_460_36.localEulerAngles

				var_460_44.z = 0
				var_460_44.x = 0
				var_460_36.localEulerAngles = var_460_44
			end

			local var_460_45 = arg_457_1.actors_["1085ui_story"]
			local var_460_46 = 1.96599999815226

			if var_460_46 < arg_457_1.time_ and arg_457_1.time_ <= var_460_46 + arg_460_0 and not isNil(var_460_45) and arg_457_1.var_.characterEffect1085ui_story == nil then
				arg_457_1.var_.characterEffect1085ui_story = var_460_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_47 = 0.034000001847744

			if var_460_46 <= arg_457_1.time_ and arg_457_1.time_ < var_460_46 + var_460_47 and not isNil(var_460_45) then
				local var_460_48 = (arg_457_1.time_ - var_460_46) / var_460_47

				if arg_457_1.var_.characterEffect1085ui_story and not isNil(var_460_45) then
					local var_460_49 = Mathf.Lerp(0, 0.5, var_460_48)

					arg_457_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_457_1.var_.characterEffect1085ui_story.fillRatio = var_460_49
				end
			end

			if arg_457_1.time_ >= var_460_46 + var_460_47 and arg_457_1.time_ < var_460_46 + var_460_47 + arg_460_0 and not isNil(var_460_45) and arg_457_1.var_.characterEffect1085ui_story then
				local var_460_50 = 0.5

				arg_457_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_457_1.var_.characterEffect1085ui_story.fillRatio = var_460_50
			end

			local var_460_51 = 0.333333333333333
			local var_460_52 = 1

			if var_460_51 < arg_457_1.time_ and arg_457_1.time_ <= var_460_51 + arg_460_0 then
				local var_460_53 = "stop"
				local var_460_54 = "effect"

				arg_457_1:AudioAction(var_460_53, var_460_54, "se_story_142", "se_story_142_amb_commandroom", "")
			end

			local var_460_55 = 1.63333333333333
			local var_460_56 = 1

			if var_460_55 < arg_457_1.time_ and arg_457_1.time_ <= var_460_55 + arg_460_0 then
				local var_460_57 = "play"
				local var_460_58 = "effect"

				arg_457_1:AudioAction(var_460_57, var_460_58, "se_story_143", "se_story_143_amb_room", "")
			end

			local var_460_59 = 4
			local var_460_60 = 1

			if var_460_59 < arg_457_1.time_ and arg_457_1.time_ <= var_460_59 + arg_460_0 then
				local var_460_61 = "play"
				local var_460_62 = "effect"

				arg_457_1:AudioAction(var_460_61, var_460_62, "se_story_side_1011", "se_story_side_1011_doorhandle", "")
			end

			if arg_457_1.frameCnt_ <= 1 then
				arg_457_1.dialog_:SetActive(false)
			end

			local var_460_63 = 4
			local var_460_64 = 1

			if var_460_63 < arg_457_1.time_ and arg_457_1.time_ <= var_460_63 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0

				arg_457_1.dialog_:SetActive(true)

				arg_457_1.dialogCg_.alpha = 0

				local var_460_65 = LeanTween.value(arg_457_1.dialog_, 0, 1, 0.3)

				var_460_65:setOnUpdate(LuaHelper.FloatAction(function(arg_461_0)
					arg_457_1.dialogCg_.alpha = arg_461_0
				end))
				var_460_65:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_457_1.dialog_)
					var_460_65:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_457_1.duration_ = arg_457_1.duration_ + 0.3

				SetActive(arg_457_1.leftNameGo_, false)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_66 = arg_457_1:GetWordFromCfg(1108503109)
				local var_460_67 = arg_457_1:FormatText(var_460_66.content)

				arg_457_1.text_.text = var_460_67

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_68 = 40
				local var_460_69 = utf8.len(var_460_67)
				local var_460_70 = var_460_68 <= 0 and var_460_64 or var_460_64 * (var_460_69 / var_460_68)

				if var_460_70 > 0 and var_460_64 < var_460_70 then
					arg_457_1.talkMaxDuration = var_460_70
					var_460_63 = var_460_63 + 0.3

					if var_460_70 + var_460_63 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_70 + var_460_63
					end
				end

				arg_457_1.text_.text = var_460_67
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_71 = var_460_63 + 0.3
			local var_460_72 = math.max(var_460_64, arg_457_1.talkMaxDuration)

			if var_460_71 <= arg_457_1.time_ and arg_457_1.time_ < var_460_71 + var_460_72 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_71) / var_460_72

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_71 + var_460_72 and arg_457_1.time_ < var_460_71 + var_460_72 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_457_1:InitPlayNodeList()
	end,
	Play1108503110 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 1108503110
		arg_463_1.duration_ = 5

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play1108503111(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = 0
			local var_466_1 = 0.875

			if var_466_0 < arg_463_1.time_ and arg_463_1.time_ <= var_466_0 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, false)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_2 = arg_463_1:GetWordFromCfg(1108503110)
				local var_466_3 = arg_463_1:FormatText(var_466_2.content)

				arg_463_1.text_.text = var_466_3

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_4 = 35
				local var_466_5 = utf8.len(var_466_3)
				local var_466_6 = var_466_4 <= 0 and var_466_1 or var_466_1 * (var_466_5 / var_466_4)

				if var_466_6 > 0 and var_466_1 < var_466_6 then
					arg_463_1.talkMaxDuration = var_466_6

					if var_466_6 + var_466_0 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_6 + var_466_0
					end
				end

				arg_463_1.text_.text = var_466_3
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)
				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_7 = math.max(var_466_1, arg_463_1.talkMaxDuration)

			if var_466_0 <= arg_463_1.time_ and arg_463_1.time_ < var_466_0 + var_466_7 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_0) / var_466_7

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_0 + var_466_7 and arg_463_1.time_ < var_466_0 + var_466_7 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end

		arg_463_1.nodeConfigList_ = {}

		arg_463_1:InitPlayNodeList()
	end,
	Play1108503111 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 1108503111
		arg_467_1.duration_ = 5

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play1108503112(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0
			local var_470_1 = 0.65

			if var_470_0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_2 = arg_467_1:FormatText(StoryNameCfg[7].name)

				arg_467_1.leftNameTxt_.text = var_470_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, true)
				arg_467_1.iconController_:SetSelectedState("hero")

				arg_467_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_467_1.callingController_:SetSelectedState("normal")

				arg_467_1.keyicon_.color = Color.New(1, 1, 1)
				arg_467_1.icon_.color = Color.New(1, 1, 1)

				local var_470_3 = arg_467_1:GetWordFromCfg(1108503111)
				local var_470_4 = arg_467_1:FormatText(var_470_3.content)

				arg_467_1.text_.text = var_470_4

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_5 = 26
				local var_470_6 = utf8.len(var_470_4)
				local var_470_7 = var_470_5 <= 0 and var_470_1 or var_470_1 * (var_470_6 / var_470_5)

				if var_470_7 > 0 and var_470_1 < var_470_7 then
					arg_467_1.talkMaxDuration = var_470_7

					if var_470_7 + var_470_0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_7 + var_470_0
					end
				end

				arg_467_1.text_.text = var_470_4
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)
				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_8 = math.max(var_470_1, arg_467_1.talkMaxDuration)

			if var_470_0 <= arg_467_1.time_ and arg_467_1.time_ < var_470_0 + var_470_8 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_0) / var_470_8

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_0 + var_470_8 and arg_467_1.time_ < var_470_0 + var_470_8 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end

		arg_467_1.nodeConfigList_ = {}

		arg_467_1:InitPlayNodeList()
	end,
	Play1108503112 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 1108503112
		arg_471_1.duration_ = 8.03

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play1108503113(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = arg_471_1.actors_["1085ui_story"].transform
			local var_474_1 = 0

			if var_474_1 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 then
				arg_471_1.var_.moveOldPos1085ui_story = var_474_0.localPosition
			end

			local var_474_2 = 0.001

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_2 then
				local var_474_3 = (arg_471_1.time_ - var_474_1) / var_474_2
				local var_474_4 = Vector3.New(0, -1.01, -5.83)

				var_474_0.localPosition = Vector3.Lerp(arg_471_1.var_.moveOldPos1085ui_story, var_474_4, var_474_3)

				local var_474_5 = manager.ui.mainCamera.transform.position - var_474_0.position

				var_474_0.forward = Vector3.New(var_474_5.x, var_474_5.y, var_474_5.z)

				local var_474_6 = var_474_0.localEulerAngles

				var_474_6.z = 0
				var_474_6.x = 0
				var_474_0.localEulerAngles = var_474_6
			end

			if arg_471_1.time_ >= var_474_1 + var_474_2 and arg_471_1.time_ < var_474_1 + var_474_2 + arg_474_0 then
				var_474_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_474_7 = manager.ui.mainCamera.transform.position - var_474_0.position

				var_474_0.forward = Vector3.New(var_474_7.x, var_474_7.y, var_474_7.z)

				local var_474_8 = var_474_0.localEulerAngles

				var_474_8.z = 0
				var_474_8.x = 0
				var_474_0.localEulerAngles = var_474_8
			end

			local var_474_9 = arg_471_1.actors_["1085ui_story"]
			local var_474_10 = 0

			if var_474_10 < arg_471_1.time_ and arg_471_1.time_ <= var_474_10 + arg_474_0 and not isNil(var_474_9) and arg_471_1.var_.characterEffect1085ui_story == nil then
				arg_471_1.var_.characterEffect1085ui_story = var_474_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_11 = 0.200000002980232

			if var_474_10 <= arg_471_1.time_ and arg_471_1.time_ < var_474_10 + var_474_11 and not isNil(var_474_9) then
				local var_474_12 = (arg_471_1.time_ - var_474_10) / var_474_11

				if arg_471_1.var_.characterEffect1085ui_story and not isNil(var_474_9) then
					arg_471_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_471_1.time_ >= var_474_10 + var_474_11 and arg_471_1.time_ < var_474_10 + var_474_11 + arg_474_0 and not isNil(var_474_9) and arg_471_1.var_.characterEffect1085ui_story then
				arg_471_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_474_13 = 0

			if var_474_13 < arg_471_1.time_ and arg_471_1.time_ <= var_474_13 + arg_474_0 then
				arg_471_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_474_14 = 0

			if var_474_14 < arg_471_1.time_ and arg_471_1.time_ <= var_474_14 + arg_474_0 then
				arg_471_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_474_15 = 0
			local var_474_16 = 0.5

			if var_474_15 < arg_471_1.time_ and arg_471_1.time_ <= var_474_15 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_17 = arg_471_1:FormatText(StoryNameCfg[328].name)

				arg_471_1.leftNameTxt_.text = var_474_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, false)
				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_18 = arg_471_1:GetWordFromCfg(1108503112)
				local var_474_19 = arg_471_1:FormatText(var_474_18.content)

				arg_471_1.text_.text = var_474_19

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_20 = 20
				local var_474_21 = utf8.len(var_474_19)
				local var_474_22 = var_474_20 <= 0 and var_474_16 or var_474_16 * (var_474_21 / var_474_20)

				if var_474_22 > 0 and var_474_16 < var_474_22 then
					arg_471_1.talkMaxDuration = var_474_22

					if var_474_22 + var_474_15 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_22 + var_474_15
					end
				end

				arg_471_1.text_.text = var_474_19
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503112", "story_v_side_new_1108503.awb") ~= 0 then
					local var_474_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503112", "story_v_side_new_1108503.awb") / 1000

					if var_474_23 + var_474_15 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_23 + var_474_15
					end

					if var_474_18.prefab_name ~= "" and arg_471_1.actors_[var_474_18.prefab_name] ~= nil then
						local var_474_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_18.prefab_name].transform, "story_v_side_new_1108503", "1108503112", "story_v_side_new_1108503.awb")

						arg_471_1:RecordAudio("1108503112", var_474_24)
						arg_471_1:RecordAudio("1108503112", var_474_24)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503112", "story_v_side_new_1108503.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503112", "story_v_side_new_1108503.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_25 = math.max(var_474_16, arg_471_1.talkMaxDuration)

			if var_474_15 <= arg_471_1.time_ and arg_471_1.time_ < var_474_15 + var_474_25 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_15) / var_474_25

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_15 + var_474_25 and arg_471_1.time_ < var_474_15 + var_474_25 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end

		arg_471_1.nodeConfigList_ = {
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

		arg_471_1:InitPlayNodeList()
	end,
	Play1108503113 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 1108503113
		arg_475_1.duration_ = 11.8

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play1108503114(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = 1.999999999999

			if var_478_0 < arg_475_1.time_ and arg_475_1.time_ <= var_478_0 + arg_478_0 then
				local var_478_1 = manager.ui.mainCamera.transform.localPosition
				local var_478_2 = Vector3.New(0, 0, 10) + Vector3.New(var_478_1.x, var_478_1.y, 0)
				local var_478_3 = arg_475_1.bgs_.ST12

				var_478_3.transform.localPosition = var_478_2
				var_478_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_478_4 = var_478_3:GetComponent("SpriteRenderer")

				if var_478_4 and var_478_4.sprite then
					local var_478_5 = (var_478_3.transform.localPosition - var_478_1).z
					local var_478_6 = manager.ui.mainCameraCom_
					local var_478_7 = 2 * var_478_5 * Mathf.Tan(var_478_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_478_8 = var_478_7 * var_478_6.aspect
					local var_478_9 = var_478_4.sprite.bounds.size.x
					local var_478_10 = var_478_4.sprite.bounds.size.y
					local var_478_11 = var_478_8 / var_478_9
					local var_478_12 = var_478_7 / var_478_10
					local var_478_13 = var_478_12 < var_478_11 and var_478_11 or var_478_12

					var_478_3.transform.localScale = Vector3.New(var_478_13, var_478_13, 0)
				end

				for iter_478_0, iter_478_1 in pairs(arg_475_1.bgs_) do
					if iter_478_0 ~= "ST12" then
						iter_478_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_478_14 = 3.999999999999

			if var_478_14 < arg_475_1.time_ and arg_475_1.time_ <= var_478_14 + arg_478_0 then
				arg_475_1.allBtn_.enabled = false
			end

			local var_478_15 = 0.3

			if arg_475_1.time_ >= var_478_14 + var_478_15 and arg_475_1.time_ < var_478_14 + var_478_15 + arg_478_0 then
				arg_475_1.allBtn_.enabled = true
			end

			local var_478_16 = 0

			if var_478_16 < arg_475_1.time_ and arg_475_1.time_ <= var_478_16 + arg_478_0 then
				arg_475_1.mask_.enabled = true
				arg_475_1.mask_.raycastTarget = true

				arg_475_1:SetGaussion(false)
			end

			local var_478_17 = 2

			if var_478_16 <= arg_475_1.time_ and arg_475_1.time_ < var_478_16 + var_478_17 then
				local var_478_18 = (arg_475_1.time_ - var_478_16) / var_478_17
				local var_478_19 = Color.New(0, 0, 0)

				var_478_19.a = Mathf.Lerp(0, 1, var_478_18)
				arg_475_1.mask_.color = var_478_19
			end

			if arg_475_1.time_ >= var_478_16 + var_478_17 and arg_475_1.time_ < var_478_16 + var_478_17 + arg_478_0 then
				local var_478_20 = Color.New(0, 0, 0)

				var_478_20.a = 1
				arg_475_1.mask_.color = var_478_20
			end

			local var_478_21 = 2

			if var_478_21 < arg_475_1.time_ and arg_475_1.time_ <= var_478_21 + arg_478_0 then
				arg_475_1.mask_.enabled = true
				arg_475_1.mask_.raycastTarget = true

				arg_475_1:SetGaussion(false)
			end

			local var_478_22 = 2

			if var_478_21 <= arg_475_1.time_ and arg_475_1.time_ < var_478_21 + var_478_22 then
				local var_478_23 = (arg_475_1.time_ - var_478_21) / var_478_22
				local var_478_24 = Color.New(0, 0, 0)

				var_478_24.a = Mathf.Lerp(1, 0, var_478_23)
				arg_475_1.mask_.color = var_478_24
			end

			if arg_475_1.time_ >= var_478_21 + var_478_22 and arg_475_1.time_ < var_478_21 + var_478_22 + arg_478_0 then
				local var_478_25 = Color.New(0, 0, 0)
				local var_478_26 = 0

				arg_475_1.mask_.enabled = false
				var_478_25.a = var_478_26
				arg_475_1.mask_.color = var_478_25
			end

			local var_478_27 = arg_475_1.actors_["1085ui_story"].transform
			local var_478_28 = 3.8

			if var_478_28 < arg_475_1.time_ and arg_475_1.time_ <= var_478_28 + arg_478_0 then
				arg_475_1.var_.moveOldPos1085ui_story = var_478_27.localPosition
			end

			local var_478_29 = 0.001

			if var_478_28 <= arg_475_1.time_ and arg_475_1.time_ < var_478_28 + var_478_29 then
				local var_478_30 = (arg_475_1.time_ - var_478_28) / var_478_29
				local var_478_31 = Vector3.New(0, -1.01, -5.83)

				var_478_27.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1085ui_story, var_478_31, var_478_30)

				local var_478_32 = manager.ui.mainCamera.transform.position - var_478_27.position

				var_478_27.forward = Vector3.New(var_478_32.x, var_478_32.y, var_478_32.z)

				local var_478_33 = var_478_27.localEulerAngles

				var_478_33.z = 0
				var_478_33.x = 0
				var_478_27.localEulerAngles = var_478_33
			end

			if arg_475_1.time_ >= var_478_28 + var_478_29 and arg_475_1.time_ < var_478_28 + var_478_29 + arg_478_0 then
				var_478_27.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_478_34 = manager.ui.mainCamera.transform.position - var_478_27.position

				var_478_27.forward = Vector3.New(var_478_34.x, var_478_34.y, var_478_34.z)

				local var_478_35 = var_478_27.localEulerAngles

				var_478_35.z = 0
				var_478_35.x = 0
				var_478_27.localEulerAngles = var_478_35
			end

			local var_478_36 = arg_475_1.actors_["1085ui_story"]
			local var_478_37 = 3.8

			if var_478_37 < arg_475_1.time_ and arg_475_1.time_ <= var_478_37 + arg_478_0 and not isNil(var_478_36) and arg_475_1.var_.characterEffect1085ui_story == nil then
				arg_475_1.var_.characterEffect1085ui_story = var_478_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_38 = 0.200000002980232

			if var_478_37 <= arg_475_1.time_ and arg_475_1.time_ < var_478_37 + var_478_38 and not isNil(var_478_36) then
				local var_478_39 = (arg_475_1.time_ - var_478_37) / var_478_38

				if arg_475_1.var_.characterEffect1085ui_story and not isNil(var_478_36) then
					arg_475_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= var_478_37 + var_478_38 and arg_475_1.time_ < var_478_37 + var_478_38 + arg_478_0 and not isNil(var_478_36) and arg_475_1.var_.characterEffect1085ui_story then
				arg_475_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_478_40 = 3.8

			if var_478_40 < arg_475_1.time_ and arg_475_1.time_ <= var_478_40 + arg_478_0 then
				arg_475_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_478_41 = 3.8

			if var_478_41 < arg_475_1.time_ and arg_475_1.time_ <= var_478_41 + arg_478_0 then
				arg_475_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_478_42 = arg_475_1.actors_["1085ui_story"].transform
			local var_478_43 = 1.96599999815226

			if var_478_43 < arg_475_1.time_ and arg_475_1.time_ <= var_478_43 + arg_478_0 then
				arg_475_1.var_.moveOldPos1085ui_story = var_478_42.localPosition
			end

			local var_478_44 = 0.001

			if var_478_43 <= arg_475_1.time_ and arg_475_1.time_ < var_478_43 + var_478_44 then
				local var_478_45 = (arg_475_1.time_ - var_478_43) / var_478_44
				local var_478_46 = Vector3.New(0, 100, 0)

				var_478_42.localPosition = Vector3.Lerp(arg_475_1.var_.moveOldPos1085ui_story, var_478_46, var_478_45)

				local var_478_47 = manager.ui.mainCamera.transform.position - var_478_42.position

				var_478_42.forward = Vector3.New(var_478_47.x, var_478_47.y, var_478_47.z)

				local var_478_48 = var_478_42.localEulerAngles

				var_478_48.z = 0
				var_478_48.x = 0
				var_478_42.localEulerAngles = var_478_48
			end

			if arg_475_1.time_ >= var_478_43 + var_478_44 and arg_475_1.time_ < var_478_43 + var_478_44 + arg_478_0 then
				var_478_42.localPosition = Vector3.New(0, 100, 0)

				local var_478_49 = manager.ui.mainCamera.transform.position - var_478_42.position

				var_478_42.forward = Vector3.New(var_478_49.x, var_478_49.y, var_478_49.z)

				local var_478_50 = var_478_42.localEulerAngles

				var_478_50.z = 0
				var_478_50.x = 0
				var_478_42.localEulerAngles = var_478_50
			end

			local var_478_51 = 0.333333333333333
			local var_478_52 = 1

			if var_478_51 < arg_475_1.time_ and arg_475_1.time_ <= var_478_51 + arg_478_0 then
				local var_478_53 = "stop"
				local var_478_54 = "effect"

				arg_475_1:AudioAction(var_478_53, var_478_54, "se_story_143", "se_story_143_amb_room", "")
			end

			local var_478_55 = 1.7
			local var_478_56 = 1

			if var_478_55 < arg_475_1.time_ and arg_475_1.time_ <= var_478_55 + arg_478_0 then
				local var_478_57 = "play"
				local var_478_58 = "effect"

				arg_475_1:AudioAction(var_478_57, var_478_58, "se_story_side_1020", "se_story_side_1020_amb_office", "")
			end

			if arg_475_1.frameCnt_ <= 1 then
				arg_475_1.dialog_:SetActive(false)
			end

			local var_478_59 = 4
			local var_478_60 = 0.65

			if var_478_59 < arg_475_1.time_ and arg_475_1.time_ <= var_478_59 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0

				arg_475_1.dialog_:SetActive(true)

				arg_475_1.dialogCg_.alpha = 0

				local var_478_61 = LeanTween.value(arg_475_1.dialog_, 0, 1, 0.3)

				var_478_61:setOnUpdate(LuaHelper.FloatAction(function(arg_479_0)
					arg_475_1.dialogCg_.alpha = arg_479_0
				end))
				var_478_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_475_1.dialog_)
					var_478_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_475_1.duration_ = arg_475_1.duration_ + 0.3

				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_62 = arg_475_1:FormatText(StoryNameCfg[328].name)

				arg_475_1.leftNameTxt_.text = var_478_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_63 = arg_475_1:GetWordFromCfg(1108503113)
				local var_478_64 = arg_475_1:FormatText(var_478_63.content)

				arg_475_1.text_.text = var_478_64

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_65 = 26
				local var_478_66 = utf8.len(var_478_64)
				local var_478_67 = var_478_65 <= 0 and var_478_60 or var_478_60 * (var_478_66 / var_478_65)

				if var_478_67 > 0 and var_478_60 < var_478_67 then
					arg_475_1.talkMaxDuration = var_478_67
					var_478_59 = var_478_59 + 0.3

					if var_478_67 + var_478_59 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_67 + var_478_59
					end
				end

				arg_475_1.text_.text = var_478_64
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503113", "story_v_side_new_1108503.awb") ~= 0 then
					local var_478_68 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503113", "story_v_side_new_1108503.awb") / 1000

					if var_478_68 + var_478_59 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_68 + var_478_59
					end

					if var_478_63.prefab_name ~= "" and arg_475_1.actors_[var_478_63.prefab_name] ~= nil then
						local var_478_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_63.prefab_name].transform, "story_v_side_new_1108503", "1108503113", "story_v_side_new_1108503.awb")

						arg_475_1:RecordAudio("1108503113", var_478_69)
						arg_475_1:RecordAudio("1108503113", var_478_69)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503113", "story_v_side_new_1108503.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503113", "story_v_side_new_1108503.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_70 = var_478_59 + 0.3
			local var_478_71 = math.max(var_478_60, arg_475_1.talkMaxDuration)

			if var_478_70 <= arg_475_1.time_ and arg_475_1.time_ < var_478_70 + var_478_71 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_70) / var_478_71

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_70 + var_478_71 and arg_475_1.time_ < var_478_70 + var_478_71 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end

		arg_475_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1085ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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

		arg_475_1:InitPlayNodeList()
	end,
	Play1108503114 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 1108503114
		arg_481_1.duration_ = 4.93

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play1108503115(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			local var_484_0 = arg_481_1.actors_["1085ui_story"].transform
			local var_484_1 = 0

			if var_484_1 < arg_481_1.time_ and arg_481_1.time_ <= var_484_1 + arg_484_0 then
				arg_481_1.var_.moveOldPos1085ui_story = var_484_0.localPosition
			end

			local var_484_2 = 0.001

			if var_484_1 <= arg_481_1.time_ and arg_481_1.time_ < var_484_1 + var_484_2 then
				local var_484_3 = (arg_481_1.time_ - var_484_1) / var_484_2
				local var_484_4 = Vector3.New(0, -1.01, -5.83)

				var_484_0.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1085ui_story, var_484_4, var_484_3)

				local var_484_5 = manager.ui.mainCamera.transform.position - var_484_0.position

				var_484_0.forward = Vector3.New(var_484_5.x, var_484_5.y, var_484_5.z)

				local var_484_6 = var_484_0.localEulerAngles

				var_484_6.z = 0
				var_484_6.x = 0
				var_484_0.localEulerAngles = var_484_6
			end

			if arg_481_1.time_ >= var_484_1 + var_484_2 and arg_481_1.time_ < var_484_1 + var_484_2 + arg_484_0 then
				var_484_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_484_7 = manager.ui.mainCamera.transform.position - var_484_0.position

				var_484_0.forward = Vector3.New(var_484_7.x, var_484_7.y, var_484_7.z)

				local var_484_8 = var_484_0.localEulerAngles

				var_484_8.z = 0
				var_484_8.x = 0
				var_484_0.localEulerAngles = var_484_8
			end

			local var_484_9 = 0

			if var_484_9 < arg_481_1.time_ and arg_481_1.time_ <= var_484_9 + arg_484_0 then
				arg_481_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action4_1")
			end

			local var_484_10 = 0

			if var_484_10 < arg_481_1.time_ and arg_481_1.time_ <= var_484_10 + arg_484_0 then
				arg_481_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_484_11 = 0
			local var_484_12 = 0.45

			if var_484_11 < arg_481_1.time_ and arg_481_1.time_ <= var_484_11 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				local var_484_13 = arg_481_1:FormatText(StoryNameCfg[328].name)

				arg_481_1.leftNameTxt_.text = var_484_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_14 = arg_481_1:GetWordFromCfg(1108503114)
				local var_484_15 = arg_481_1:FormatText(var_484_14.content)

				arg_481_1.text_.text = var_484_15

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_16 = 18
				local var_484_17 = utf8.len(var_484_15)
				local var_484_18 = var_484_16 <= 0 and var_484_12 or var_484_12 * (var_484_17 / var_484_16)

				if var_484_18 > 0 and var_484_12 < var_484_18 then
					arg_481_1.talkMaxDuration = var_484_18

					if var_484_18 + var_484_11 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_18 + var_484_11
					end
				end

				arg_481_1.text_.text = var_484_15
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503114", "story_v_side_new_1108503.awb") ~= 0 then
					local var_484_19 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503114", "story_v_side_new_1108503.awb") / 1000

					if var_484_19 + var_484_11 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_19 + var_484_11
					end

					if var_484_14.prefab_name ~= "" and arg_481_1.actors_[var_484_14.prefab_name] ~= nil then
						local var_484_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_14.prefab_name].transform, "story_v_side_new_1108503", "1108503114", "story_v_side_new_1108503.awb")

						arg_481_1:RecordAudio("1108503114", var_484_20)
						arg_481_1:RecordAudio("1108503114", var_484_20)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503114", "story_v_side_new_1108503.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503114", "story_v_side_new_1108503.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_21 = math.max(var_484_12, arg_481_1.talkMaxDuration)

			if var_484_11 <= arg_481_1.time_ and arg_481_1.time_ < var_484_11 + var_484_21 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_11) / var_484_21

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_11 + var_484_21 and arg_481_1.time_ < var_484_11 + var_484_21 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
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

		arg_481_1:InitPlayNodeList()
	end,
	Play1108503115 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 1108503115
		arg_485_1.duration_ = 5

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play1108503116(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = arg_485_1.actors_["1085ui_story"].transform
			local var_488_1 = 0

			if var_488_1 < arg_485_1.time_ and arg_485_1.time_ <= var_488_1 + arg_488_0 then
				arg_485_1.var_.moveOldPos1085ui_story = var_488_0.localPosition
			end

			local var_488_2 = 0.001

			if var_488_1 <= arg_485_1.time_ and arg_485_1.time_ < var_488_1 + var_488_2 then
				local var_488_3 = (arg_485_1.time_ - var_488_1) / var_488_2
				local var_488_4 = Vector3.New(0, 100, 0)

				var_488_0.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1085ui_story, var_488_4, var_488_3)

				local var_488_5 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_5.x, var_488_5.y, var_488_5.z)

				local var_488_6 = var_488_0.localEulerAngles

				var_488_6.z = 0
				var_488_6.x = 0
				var_488_0.localEulerAngles = var_488_6
			end

			if arg_485_1.time_ >= var_488_1 + var_488_2 and arg_485_1.time_ < var_488_1 + var_488_2 + arg_488_0 then
				var_488_0.localPosition = Vector3.New(0, 100, 0)

				local var_488_7 = manager.ui.mainCamera.transform.position - var_488_0.position

				var_488_0.forward = Vector3.New(var_488_7.x, var_488_7.y, var_488_7.z)

				local var_488_8 = var_488_0.localEulerAngles

				var_488_8.z = 0
				var_488_8.x = 0
				var_488_0.localEulerAngles = var_488_8
			end

			local var_488_9 = arg_485_1.actors_["1085ui_story"]
			local var_488_10 = 0

			if var_488_10 < arg_485_1.time_ and arg_485_1.time_ <= var_488_10 + arg_488_0 and not isNil(var_488_9) and arg_485_1.var_.characterEffect1085ui_story == nil then
				arg_485_1.var_.characterEffect1085ui_story = var_488_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_11 = 0.200000002980232

			if var_488_10 <= arg_485_1.time_ and arg_485_1.time_ < var_488_10 + var_488_11 and not isNil(var_488_9) then
				local var_488_12 = (arg_485_1.time_ - var_488_10) / var_488_11

				if arg_485_1.var_.characterEffect1085ui_story and not isNil(var_488_9) then
					local var_488_13 = Mathf.Lerp(0, 0.5, var_488_12)

					arg_485_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_485_1.var_.characterEffect1085ui_story.fillRatio = var_488_13
				end
			end

			if arg_485_1.time_ >= var_488_10 + var_488_11 and arg_485_1.time_ < var_488_10 + var_488_11 + arg_488_0 and not isNil(var_488_9) and arg_485_1.var_.characterEffect1085ui_story then
				local var_488_14 = 0.5

				arg_485_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_485_1.var_.characterEffect1085ui_story.fillRatio = var_488_14
			end

			local var_488_15 = 0
			local var_488_16 = 0.55

			if var_488_15 < arg_485_1.time_ and arg_485_1.time_ <= var_488_15 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, false)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_17 = arg_485_1:GetWordFromCfg(1108503115)
				local var_488_18 = arg_485_1:FormatText(var_488_17.content)

				arg_485_1.text_.text = var_488_18

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_19 = 22
				local var_488_20 = utf8.len(var_488_18)
				local var_488_21 = var_488_19 <= 0 and var_488_16 or var_488_16 * (var_488_20 / var_488_19)

				if var_488_21 > 0 and var_488_16 < var_488_21 then
					arg_485_1.talkMaxDuration = var_488_21

					if var_488_21 + var_488_15 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_21 + var_488_15
					end
				end

				arg_485_1.text_.text = var_488_18
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)
				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_22 = math.max(var_488_16, arg_485_1.talkMaxDuration)

			if var_488_15 <= arg_485_1.time_ and arg_485_1.time_ < var_488_15 + var_488_22 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_15) / var_488_22

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_15 + var_488_22 and arg_485_1.time_ < var_488_15 + var_488_22 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
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

		arg_485_1:InitPlayNodeList()
	end,
	Play1108503116 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 1108503116
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play1108503117(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0
			local var_492_1 = 0.3

			if var_492_0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_0 + arg_492_0 then
				local var_492_2 = "play"
				local var_492_3 = "music"

				arg_489_1:AudioAction(var_492_2, var_492_3, "ui_battle", "ui_battle_stopbgm", "")

				local var_492_4 = ""
				local var_492_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_492_5 ~= "" then
					if arg_489_1.bgmTxt_.text ~= var_492_5 and arg_489_1.bgmTxt_.text ~= "" then
						if arg_489_1.bgmTxt2_.text ~= "" then
							arg_489_1.bgmTxt_.text = arg_489_1.bgmTxt2_.text
						end

						arg_489_1.bgmTxt2_.text = var_492_5

						arg_489_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_489_1.bgmTxt_.text = var_492_5
						arg_489_1.bgmTxt2_.text = var_492_5
					end

					if arg_489_1.bgmTimer then
						arg_489_1.bgmTimer:Stop()

						arg_489_1.bgmTimer = nil
					end

					if arg_489_1.settingData.show_music_name == 1 then
						arg_489_1.musicController:SetSelectedState("show")
						arg_489_1.musicAnimator_:Play("open", 0, 0)

						if arg_489_1.settingData.music_time ~= 0 then
							arg_489_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_489_1.settingData.music_time), function()
								if arg_489_1 == nil or isNil(arg_489_1.bgmTxt_) then
									return
								end

								arg_489_1.musicController:SetSelectedState("hide")
								arg_489_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_492_6 = 0.3
			local var_492_7 = 1

			if var_492_6 < arg_489_1.time_ and arg_489_1.time_ <= var_492_6 + arg_492_0 then
				local var_492_8 = "play"
				local var_492_9 = "music"

				arg_489_1:AudioAction(var_492_8, var_492_9, "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet.awb")

				local var_492_10 = ""
				local var_492_11 = manager.audio:GetAudioName("bgm_activity_3_0_story_quiet", "bgm_activity_3_0_story_quiet")

				if var_492_11 ~= "" then
					if arg_489_1.bgmTxt_.text ~= var_492_11 and arg_489_1.bgmTxt_.text ~= "" then
						if arg_489_1.bgmTxt2_.text ~= "" then
							arg_489_1.bgmTxt_.text = arg_489_1.bgmTxt2_.text
						end

						arg_489_1.bgmTxt2_.text = var_492_11

						arg_489_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_489_1.bgmTxt_.text = var_492_11
						arg_489_1.bgmTxt2_.text = var_492_11
					end

					if arg_489_1.bgmTimer then
						arg_489_1.bgmTimer:Stop()

						arg_489_1.bgmTimer = nil
					end

					if arg_489_1.settingData.show_music_name == 1 then
						arg_489_1.musicController:SetSelectedState("show")
						arg_489_1.musicAnimator_:Play("open", 0, 0)

						if arg_489_1.settingData.music_time ~= 0 then
							arg_489_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_489_1.settingData.music_time), function()
								if arg_489_1 == nil or isNil(arg_489_1.bgmTxt_) then
									return
								end

								arg_489_1.musicController:SetSelectedState("hide")
								arg_489_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_492_12 = 0
			local var_492_13 = 0.5

			if var_492_12 < arg_489_1.time_ and arg_489_1.time_ <= var_492_12 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				local var_492_14 = arg_489_1:FormatText(StoryNameCfg[7].name)

				arg_489_1.leftNameTxt_.text = var_492_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, true)
				arg_489_1.iconController_:SetSelectedState("hero")

				arg_489_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_489_1.callingController_:SetSelectedState("normal")

				arg_489_1.keyicon_.color = Color.New(1, 1, 1)
				arg_489_1.icon_.color = Color.New(1, 1, 1)

				local var_492_15 = arg_489_1:GetWordFromCfg(1108503116)
				local var_492_16 = arg_489_1:FormatText(var_492_15.content)

				arg_489_1.text_.text = var_492_16

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_17 = 20
				local var_492_18 = utf8.len(var_492_16)
				local var_492_19 = var_492_17 <= 0 and var_492_13 or var_492_13 * (var_492_18 / var_492_17)

				if var_492_19 > 0 and var_492_13 < var_492_19 then
					arg_489_1.talkMaxDuration = var_492_19

					if var_492_19 + var_492_12 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_19 + var_492_12
					end
				end

				arg_489_1.text_.text = var_492_16
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_20 = math.max(var_492_13, arg_489_1.talkMaxDuration)

			if var_492_12 <= arg_489_1.time_ and arg_489_1.time_ < var_492_12 + var_492_20 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_12) / var_492_20

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_12 + var_492_20 and arg_489_1.time_ < var_492_12 + var_492_20 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play1108503117 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 1108503117
		arg_495_1.duration_ = 5

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play1108503118(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = 0
			local var_498_1 = 0.75

			if var_498_0 < arg_495_1.time_ and arg_495_1.time_ <= var_498_0 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_2 = arg_495_1:FormatText(StoryNameCfg[7].name)

				arg_495_1.leftNameTxt_.text = var_498_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, true)
				arg_495_1.iconController_:SetSelectedState("hero")

				arg_495_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_495_1.callingController_:SetSelectedState("normal")

				arg_495_1.keyicon_.color = Color.New(1, 1, 1)
				arg_495_1.icon_.color = Color.New(1, 1, 1)

				local var_498_3 = arg_495_1:GetWordFromCfg(1108503117)
				local var_498_4 = arg_495_1:FormatText(var_498_3.content)

				arg_495_1.text_.text = var_498_4

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_5 = 30
				local var_498_6 = utf8.len(var_498_4)
				local var_498_7 = var_498_5 <= 0 and var_498_1 or var_498_1 * (var_498_6 / var_498_5)

				if var_498_7 > 0 and var_498_1 < var_498_7 then
					arg_495_1.talkMaxDuration = var_498_7

					if var_498_7 + var_498_0 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_7 + var_498_0
					end
				end

				arg_495_1.text_.text = var_498_4
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)
				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_8 = math.max(var_498_1, arg_495_1.talkMaxDuration)

			if var_498_0 <= arg_495_1.time_ and arg_495_1.time_ < var_498_0 + var_498_8 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_0) / var_498_8

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_0 + var_498_8 and arg_495_1.time_ < var_498_0 + var_498_8 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end

		arg_495_1.nodeConfigList_ = {}

		arg_495_1:InitPlayNodeList()
	end,
	Play1108503118 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 1108503118
		arg_499_1.duration_ = 9.3

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play1108503119(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["1085ui_story"].transform
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 then
				arg_499_1.var_.moveOldPos1085ui_story = var_502_0.localPosition
			end

			local var_502_2 = 0.001

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2
				local var_502_4 = Vector3.New(0, -1.01, -5.83)

				var_502_0.localPosition = Vector3.Lerp(arg_499_1.var_.moveOldPos1085ui_story, var_502_4, var_502_3)

				local var_502_5 = manager.ui.mainCamera.transform.position - var_502_0.position

				var_502_0.forward = Vector3.New(var_502_5.x, var_502_5.y, var_502_5.z)

				local var_502_6 = var_502_0.localEulerAngles

				var_502_6.z = 0
				var_502_6.x = 0
				var_502_0.localEulerAngles = var_502_6
			end

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 then
				var_502_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_502_7 = manager.ui.mainCamera.transform.position - var_502_0.position

				var_502_0.forward = Vector3.New(var_502_7.x, var_502_7.y, var_502_7.z)

				local var_502_8 = var_502_0.localEulerAngles

				var_502_8.z = 0
				var_502_8.x = 0
				var_502_0.localEulerAngles = var_502_8
			end

			local var_502_9 = arg_499_1.actors_["1085ui_story"]
			local var_502_10 = 0

			if var_502_10 < arg_499_1.time_ and arg_499_1.time_ <= var_502_10 + arg_502_0 and not isNil(var_502_9) and arg_499_1.var_.characterEffect1085ui_story == nil then
				arg_499_1.var_.characterEffect1085ui_story = var_502_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_11 = 0.200000002980232

			if var_502_10 <= arg_499_1.time_ and arg_499_1.time_ < var_502_10 + var_502_11 and not isNil(var_502_9) then
				local var_502_12 = (arg_499_1.time_ - var_502_10) / var_502_11

				if arg_499_1.var_.characterEffect1085ui_story and not isNil(var_502_9) then
					arg_499_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_499_1.time_ >= var_502_10 + var_502_11 and arg_499_1.time_ < var_502_10 + var_502_11 + arg_502_0 and not isNil(var_502_9) and arg_499_1.var_.characterEffect1085ui_story then
				arg_499_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_502_13 = 0

			if var_502_13 < arg_499_1.time_ and arg_499_1.time_ <= var_502_13 + arg_502_0 then
				arg_499_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_502_14 = 0

			if var_502_14 < arg_499_1.time_ and arg_499_1.time_ <= var_502_14 + arg_502_0 then
				arg_499_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_502_15 = 0
			local var_502_16 = 0.875

			if var_502_15 < arg_499_1.time_ and arg_499_1.time_ <= var_502_15 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_17 = arg_499_1:FormatText(StoryNameCfg[328].name)

				arg_499_1.leftNameTxt_.text = var_502_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, false)
				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_18 = arg_499_1:GetWordFromCfg(1108503118)
				local var_502_19 = arg_499_1:FormatText(var_502_18.content)

				arg_499_1.text_.text = var_502_19

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_20 = 35
				local var_502_21 = utf8.len(var_502_19)
				local var_502_22 = var_502_20 <= 0 and var_502_16 or var_502_16 * (var_502_21 / var_502_20)

				if var_502_22 > 0 and var_502_16 < var_502_22 then
					arg_499_1.talkMaxDuration = var_502_22

					if var_502_22 + var_502_15 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_22 + var_502_15
					end
				end

				arg_499_1.text_.text = var_502_19
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503118", "story_v_side_new_1108503.awb") ~= 0 then
					local var_502_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503118", "story_v_side_new_1108503.awb") / 1000

					if var_502_23 + var_502_15 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_23 + var_502_15
					end

					if var_502_18.prefab_name ~= "" and arg_499_1.actors_[var_502_18.prefab_name] ~= nil then
						local var_502_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_18.prefab_name].transform, "story_v_side_new_1108503", "1108503118", "story_v_side_new_1108503.awb")

						arg_499_1:RecordAudio("1108503118", var_502_24)
						arg_499_1:RecordAudio("1108503118", var_502_24)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503118", "story_v_side_new_1108503.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503118", "story_v_side_new_1108503.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_25 = math.max(var_502_16, arg_499_1.talkMaxDuration)

			if var_502_15 <= arg_499_1.time_ and arg_499_1.time_ < var_502_15 + var_502_25 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_15) / var_502_25

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_15 + var_502_25 and arg_499_1.time_ < var_502_15 + var_502_25 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end

		arg_499_1.nodeConfigList_ = {
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

		arg_499_1:InitPlayNodeList()
	end,
	Play1108503119 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 1108503119
		arg_503_1.duration_ = 5

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play1108503120(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = arg_503_1.actors_["1085ui_story"]
			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.characterEffect1085ui_story == nil then
				arg_503_1.var_.characterEffect1085ui_story = var_506_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_2 = 0.200000002980232

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_2 and not isNil(var_506_0) then
				local var_506_3 = (arg_503_1.time_ - var_506_1) / var_506_2

				if arg_503_1.var_.characterEffect1085ui_story and not isNil(var_506_0) then
					local var_506_4 = Mathf.Lerp(0, 0.5, var_506_3)

					arg_503_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_503_1.var_.characterEffect1085ui_story.fillRatio = var_506_4
				end
			end

			if arg_503_1.time_ >= var_506_1 + var_506_2 and arg_503_1.time_ < var_506_1 + var_506_2 + arg_506_0 and not isNil(var_506_0) and arg_503_1.var_.characterEffect1085ui_story then
				local var_506_5 = 0.5

				arg_503_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_503_1.var_.characterEffect1085ui_story.fillRatio = var_506_5
			end

			local var_506_6 = 0
			local var_506_7 = 0.5

			if var_506_6 < arg_503_1.time_ and arg_503_1.time_ <= var_506_6 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_8 = arg_503_1:FormatText(StoryNameCfg[7].name)

				arg_503_1.leftNameTxt_.text = var_506_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, true)
				arg_503_1.iconController_:SetSelectedState("hero")

				arg_503_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_503_1.callingController_:SetSelectedState("normal")

				arg_503_1.keyicon_.color = Color.New(1, 1, 1)
				arg_503_1.icon_.color = Color.New(1, 1, 1)

				local var_506_9 = arg_503_1:GetWordFromCfg(1108503119)
				local var_506_10 = arg_503_1:FormatText(var_506_9.content)

				arg_503_1.text_.text = var_506_10

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_11 = 20
				local var_506_12 = utf8.len(var_506_10)
				local var_506_13 = var_506_11 <= 0 and var_506_7 or var_506_7 * (var_506_12 / var_506_11)

				if var_506_13 > 0 and var_506_7 < var_506_13 then
					arg_503_1.talkMaxDuration = var_506_13

					if var_506_13 + var_506_6 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_13 + var_506_6
					end
				end

				arg_503_1.text_.text = var_506_10
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)
				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_14 = math.max(var_506_7, arg_503_1.talkMaxDuration)

			if var_506_6 <= arg_503_1.time_ and arg_503_1.time_ < var_506_6 + var_506_14 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_6) / var_506_14

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_6 + var_506_14 and arg_503_1.time_ < var_506_6 + var_506_14 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end

		arg_503_1.nodeConfigList_ = {}

		arg_503_1:InitPlayNodeList()
	end,
	Play1108503120 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 1108503120
		arg_507_1.duration_ = 12.4

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play1108503121(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = arg_507_1.actors_["1085ui_story"].transform
			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 then
				arg_507_1.var_.moveOldPos1085ui_story = var_510_0.localPosition
			end

			local var_510_2 = 0.001

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_2 then
				local var_510_3 = (arg_507_1.time_ - var_510_1) / var_510_2
				local var_510_4 = Vector3.New(0, -1.01, -5.83)

				var_510_0.localPosition = Vector3.Lerp(arg_507_1.var_.moveOldPos1085ui_story, var_510_4, var_510_3)

				local var_510_5 = manager.ui.mainCamera.transform.position - var_510_0.position

				var_510_0.forward = Vector3.New(var_510_5.x, var_510_5.y, var_510_5.z)

				local var_510_6 = var_510_0.localEulerAngles

				var_510_6.z = 0
				var_510_6.x = 0
				var_510_0.localEulerAngles = var_510_6
			end

			if arg_507_1.time_ >= var_510_1 + var_510_2 and arg_507_1.time_ < var_510_1 + var_510_2 + arg_510_0 then
				var_510_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_510_7 = manager.ui.mainCamera.transform.position - var_510_0.position

				var_510_0.forward = Vector3.New(var_510_7.x, var_510_7.y, var_510_7.z)

				local var_510_8 = var_510_0.localEulerAngles

				var_510_8.z = 0
				var_510_8.x = 0
				var_510_0.localEulerAngles = var_510_8
			end

			local var_510_9 = arg_507_1.actors_["1085ui_story"]
			local var_510_10 = 0

			if var_510_10 < arg_507_1.time_ and arg_507_1.time_ <= var_510_10 + arg_510_0 and not isNil(var_510_9) and arg_507_1.var_.characterEffect1085ui_story == nil then
				arg_507_1.var_.characterEffect1085ui_story = var_510_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_11 = 0.200000002980232

			if var_510_10 <= arg_507_1.time_ and arg_507_1.time_ < var_510_10 + var_510_11 and not isNil(var_510_9) then
				local var_510_12 = (arg_507_1.time_ - var_510_10) / var_510_11

				if arg_507_1.var_.characterEffect1085ui_story and not isNil(var_510_9) then
					arg_507_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_507_1.time_ >= var_510_10 + var_510_11 and arg_507_1.time_ < var_510_10 + var_510_11 + arg_510_0 and not isNil(var_510_9) and arg_507_1.var_.characterEffect1085ui_story then
				arg_507_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_510_13 = 0

			if var_510_13 < arg_507_1.time_ and arg_507_1.time_ <= var_510_13 + arg_510_0 then
				arg_507_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_2")
			end

			local var_510_14 = 0

			if var_510_14 < arg_507_1.time_ and arg_507_1.time_ <= var_510_14 + arg_510_0 then
				arg_507_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_510_15 = 0
			local var_510_16 = 1.025

			if var_510_15 < arg_507_1.time_ and arg_507_1.time_ <= var_510_15 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_17 = arg_507_1:FormatText(StoryNameCfg[328].name)

				arg_507_1.leftNameTxt_.text = var_510_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, false)
				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_18 = arg_507_1:GetWordFromCfg(1108503120)
				local var_510_19 = arg_507_1:FormatText(var_510_18.content)

				arg_507_1.text_.text = var_510_19

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_20 = 41
				local var_510_21 = utf8.len(var_510_19)
				local var_510_22 = var_510_20 <= 0 and var_510_16 or var_510_16 * (var_510_21 / var_510_20)

				if var_510_22 > 0 and var_510_16 < var_510_22 then
					arg_507_1.talkMaxDuration = var_510_22

					if var_510_22 + var_510_15 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_22 + var_510_15
					end
				end

				arg_507_1.text_.text = var_510_19
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503120", "story_v_side_new_1108503.awb") ~= 0 then
					local var_510_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503120", "story_v_side_new_1108503.awb") / 1000

					if var_510_23 + var_510_15 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_23 + var_510_15
					end

					if var_510_18.prefab_name ~= "" and arg_507_1.actors_[var_510_18.prefab_name] ~= nil then
						local var_510_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_18.prefab_name].transform, "story_v_side_new_1108503", "1108503120", "story_v_side_new_1108503.awb")

						arg_507_1:RecordAudio("1108503120", var_510_24)
						arg_507_1:RecordAudio("1108503120", var_510_24)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503120", "story_v_side_new_1108503.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503120", "story_v_side_new_1108503.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_25 = math.max(var_510_16, arg_507_1.talkMaxDuration)

			if var_510_15 <= arg_507_1.time_ and arg_507_1.time_ < var_510_15 + var_510_25 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_15) / var_510_25

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_15 + var_510_25 and arg_507_1.time_ < var_510_15 + var_510_25 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end

		arg_507_1.nodeConfigList_ = {
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

		arg_507_1:InitPlayNodeList()
	end,
	Play1108503121 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 1108503121
		arg_511_1.duration_ = 7.83

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play1108503122(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = arg_511_1.actors_["1085ui_story"].transform
			local var_514_1 = 0

			if var_514_1 < arg_511_1.time_ and arg_511_1.time_ <= var_514_1 + arg_514_0 then
				arg_511_1.var_.moveOldPos1085ui_story = var_514_0.localPosition
			end

			local var_514_2 = 0.001

			if var_514_1 <= arg_511_1.time_ and arg_511_1.time_ < var_514_1 + var_514_2 then
				local var_514_3 = (arg_511_1.time_ - var_514_1) / var_514_2
				local var_514_4 = Vector3.New(0, -1.01, -5.83)

				var_514_0.localPosition = Vector3.Lerp(arg_511_1.var_.moveOldPos1085ui_story, var_514_4, var_514_3)

				local var_514_5 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_5.x, var_514_5.y, var_514_5.z)

				local var_514_6 = var_514_0.localEulerAngles

				var_514_6.z = 0
				var_514_6.x = 0
				var_514_0.localEulerAngles = var_514_6
			end

			if arg_511_1.time_ >= var_514_1 + var_514_2 and arg_511_1.time_ < var_514_1 + var_514_2 + arg_514_0 then
				var_514_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_514_7 = manager.ui.mainCamera.transform.position - var_514_0.position

				var_514_0.forward = Vector3.New(var_514_7.x, var_514_7.y, var_514_7.z)

				local var_514_8 = var_514_0.localEulerAngles

				var_514_8.z = 0
				var_514_8.x = 0
				var_514_0.localEulerAngles = var_514_8
			end

			local var_514_9 = 0

			if var_514_9 < arg_511_1.time_ and arg_511_1.time_ <= var_514_9 + arg_514_0 then
				arg_511_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action3_1")
			end

			local var_514_10 = 0

			if var_514_10 < arg_511_1.time_ and arg_511_1.time_ <= var_514_10 + arg_514_0 then
				arg_511_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_514_11 = 0
			local var_514_12 = 0.45

			if var_514_11 < arg_511_1.time_ and arg_511_1.time_ <= var_514_11 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_13 = arg_511_1:FormatText(StoryNameCfg[328].name)

				arg_511_1.leftNameTxt_.text = var_514_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, false)
				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_14 = arg_511_1:GetWordFromCfg(1108503121)
				local var_514_15 = arg_511_1:FormatText(var_514_14.content)

				arg_511_1.text_.text = var_514_15

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_16 = 18
				local var_514_17 = utf8.len(var_514_15)
				local var_514_18 = var_514_16 <= 0 and var_514_12 or var_514_12 * (var_514_17 / var_514_16)

				if var_514_18 > 0 and var_514_12 < var_514_18 then
					arg_511_1.talkMaxDuration = var_514_18

					if var_514_18 + var_514_11 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_18 + var_514_11
					end
				end

				arg_511_1.text_.text = var_514_15
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503121", "story_v_side_new_1108503.awb") ~= 0 then
					local var_514_19 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503121", "story_v_side_new_1108503.awb") / 1000

					if var_514_19 + var_514_11 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_19 + var_514_11
					end

					if var_514_14.prefab_name ~= "" and arg_511_1.actors_[var_514_14.prefab_name] ~= nil then
						local var_514_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_14.prefab_name].transform, "story_v_side_new_1108503", "1108503121", "story_v_side_new_1108503.awb")

						arg_511_1:RecordAudio("1108503121", var_514_20)
						arg_511_1:RecordAudio("1108503121", var_514_20)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503121", "story_v_side_new_1108503.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503121", "story_v_side_new_1108503.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_21 = math.max(var_514_12, arg_511_1.talkMaxDuration)

			if var_514_11 <= arg_511_1.time_ and arg_511_1.time_ < var_514_11 + var_514_21 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_11) / var_514_21

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_11 + var_514_21 and arg_511_1.time_ < var_514_11 + var_514_21 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end

		arg_511_1.nodeConfigList_ = {
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

		arg_511_1:InitPlayNodeList()
	end,
	Play1108503122 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 1108503122
		arg_515_1.duration_ = 5

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play1108503123(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["1085ui_story"].transform
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 then
				arg_515_1.var_.moveOldPos1085ui_story = var_518_0.localPosition
			end

			local var_518_2 = 0.001

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2
				local var_518_4 = Vector3.New(0, 100, 0)

				var_518_0.localPosition = Vector3.Lerp(arg_515_1.var_.moveOldPos1085ui_story, var_518_4, var_518_3)

				local var_518_5 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_5.x, var_518_5.y, var_518_5.z)

				local var_518_6 = var_518_0.localEulerAngles

				var_518_6.z = 0
				var_518_6.x = 0
				var_518_0.localEulerAngles = var_518_6
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 then
				var_518_0.localPosition = Vector3.New(0, 100, 0)

				local var_518_7 = manager.ui.mainCamera.transform.position - var_518_0.position

				var_518_0.forward = Vector3.New(var_518_7.x, var_518_7.y, var_518_7.z)

				local var_518_8 = var_518_0.localEulerAngles

				var_518_8.z = 0
				var_518_8.x = 0
				var_518_0.localEulerAngles = var_518_8
			end

			local var_518_9 = arg_515_1.actors_["1085ui_story"]
			local var_518_10 = 0

			if var_518_10 < arg_515_1.time_ and arg_515_1.time_ <= var_518_10 + arg_518_0 and not isNil(var_518_9) and arg_515_1.var_.characterEffect1085ui_story == nil then
				arg_515_1.var_.characterEffect1085ui_story = var_518_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_11 = 0.200000002980232

			if var_518_10 <= arg_515_1.time_ and arg_515_1.time_ < var_518_10 + var_518_11 and not isNil(var_518_9) then
				local var_518_12 = (arg_515_1.time_ - var_518_10) / var_518_11

				if arg_515_1.var_.characterEffect1085ui_story and not isNil(var_518_9) then
					local var_518_13 = Mathf.Lerp(0, 0.5, var_518_12)

					arg_515_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_515_1.var_.characterEffect1085ui_story.fillRatio = var_518_13
				end
			end

			if arg_515_1.time_ >= var_518_10 + var_518_11 and arg_515_1.time_ < var_518_10 + var_518_11 + arg_518_0 and not isNil(var_518_9) and arg_515_1.var_.characterEffect1085ui_story then
				local var_518_14 = 0.5

				arg_515_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_515_1.var_.characterEffect1085ui_story.fillRatio = var_518_14
			end

			local var_518_15 = 0
			local var_518_16 = 0.95

			if var_518_15 < arg_515_1.time_ and arg_515_1.time_ <= var_518_15 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, false)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_17 = arg_515_1:GetWordFromCfg(1108503122)
				local var_518_18 = arg_515_1:FormatText(var_518_17.content)

				arg_515_1.text_.text = var_518_18

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_19 = 38
				local var_518_20 = utf8.len(var_518_18)
				local var_518_21 = var_518_19 <= 0 and var_518_16 or var_518_16 * (var_518_20 / var_518_19)

				if var_518_21 > 0 and var_518_16 < var_518_21 then
					arg_515_1.talkMaxDuration = var_518_21

					if var_518_21 + var_518_15 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_21 + var_518_15
					end
				end

				arg_515_1.text_.text = var_518_18
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)
				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_22 = math.max(var_518_16, arg_515_1.talkMaxDuration)

			if var_518_15 <= arg_515_1.time_ and arg_515_1.time_ < var_518_15 + var_518_22 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_15) / var_518_22

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_15 + var_518_22 and arg_515_1.time_ < var_518_15 + var_518_22 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end

		arg_515_1.nodeConfigList_ = {
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

		arg_515_1:InitPlayNodeList()
	end,
	Play1108503123 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 1108503123
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play1108503124(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0
			local var_522_1 = 0.425

			if var_522_0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, false)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_2 = arg_519_1:GetWordFromCfg(1108503123)
				local var_522_3 = arg_519_1:FormatText(var_522_2.content)

				arg_519_1.text_.text = var_522_3

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_4 = 17
				local var_522_5 = utf8.len(var_522_3)
				local var_522_6 = var_522_4 <= 0 and var_522_1 or var_522_1 * (var_522_5 / var_522_4)

				if var_522_6 > 0 and var_522_1 < var_522_6 then
					arg_519_1.talkMaxDuration = var_522_6

					if var_522_6 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_6 + var_522_0
					end
				end

				arg_519_1.text_.text = var_522_3
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_7 = math.max(var_522_1, arg_519_1.talkMaxDuration)

			if var_522_0 <= arg_519_1.time_ and arg_519_1.time_ < var_522_0 + var_522_7 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_0) / var_522_7

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_0 + var_522_7 and arg_519_1.time_ < var_522_0 + var_522_7 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play1108503124 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 1108503124
		arg_523_1.duration_ = 5

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
		end

		function arg_523_1.playNext_(arg_525_0)
			if arg_525_0 == 1 then
				arg_523_0:Play1108503125(arg_523_1)
			end
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = 0
			local var_526_1 = 0.4

			if var_526_0 < arg_523_1.time_ and arg_523_1.time_ <= var_526_0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_2 = arg_523_1:FormatText(StoryNameCfg[7].name)

				arg_523_1.leftNameTxt_.text = var_526_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_3 = arg_523_1:GetWordFromCfg(1108503124)
				local var_526_4 = arg_523_1:FormatText(var_526_3.content)

				arg_523_1.text_.text = var_526_4

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_5 = 16
				local var_526_6 = utf8.len(var_526_4)
				local var_526_7 = var_526_5 <= 0 and var_526_1 or var_526_1 * (var_526_6 / var_526_5)

				if var_526_7 > 0 and var_526_1 < var_526_7 then
					arg_523_1.talkMaxDuration = var_526_7

					if var_526_7 + var_526_0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_7 + var_526_0
					end
				end

				arg_523_1.text_.text = var_526_4
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_8 = math.max(var_526_1, arg_523_1.talkMaxDuration)

			if var_526_0 <= arg_523_1.time_ and arg_523_1.time_ < var_526_0 + var_526_8 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_0) / var_526_8

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_0 + var_526_8 and arg_523_1.time_ < var_526_0 + var_526_8 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play1108503125 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 1108503125
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play1108503126(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0.466666666666667
			local var_530_1 = 1

			if var_530_0 < arg_527_1.time_ and arg_527_1.time_ <= var_530_0 + arg_530_0 then
				local var_530_2 = "play"
				local var_530_3 = "effect"

				arg_527_1:AudioAction(var_530_2, var_530_3, "se_story_140", "se_story_140_hug02", "")
			end

			local var_530_4 = 0
			local var_530_5 = 1.025

			if var_530_4 < arg_527_1.time_ and arg_527_1.time_ <= var_530_4 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, false)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_527_1.iconTrs_.gameObject, false)
				arg_527_1.callingController_:SetSelectedState("normal")

				local var_530_6 = arg_527_1:GetWordFromCfg(1108503125)
				local var_530_7 = arg_527_1:FormatText(var_530_6.content)

				arg_527_1.text_.text = var_530_7

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_8 = 41
				local var_530_9 = utf8.len(var_530_7)
				local var_530_10 = var_530_8 <= 0 and var_530_5 or var_530_5 * (var_530_9 / var_530_8)

				if var_530_10 > 0 and var_530_5 < var_530_10 then
					arg_527_1.talkMaxDuration = var_530_10

					if var_530_10 + var_530_4 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_10 + var_530_4
					end
				end

				arg_527_1.text_.text = var_530_7
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_11 = math.max(var_530_5, arg_527_1.talkMaxDuration)

			if var_530_4 <= arg_527_1.time_ and arg_527_1.time_ < var_530_4 + var_530_11 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - var_530_4) / var_530_11

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= var_530_4 + var_530_11 and arg_527_1.time_ < var_530_4 + var_530_11 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	Play1108503126 = function(arg_531_0, arg_531_1)
		arg_531_1.time_ = 0
		arg_531_1.frameCnt_ = 0
		arg_531_1.state_ = "playing"
		arg_531_1.curTalkId_ = 1108503126
		arg_531_1.duration_ = 5

		SetActive(arg_531_1.tipsGo_, false)

		function arg_531_1.onSingleLineFinish_()
			arg_531_1.onSingleLineUpdate_ = nil
			arg_531_1.onSingleLineFinish_ = nil
			arg_531_1.state_ = "waiting"
		end

		function arg_531_1.playNext_(arg_533_0)
			if arg_533_0 == 1 then
				arg_531_0:Play1108503127(arg_531_1)
			end
		end

		function arg_531_1.onSingleLineUpdate_(arg_534_0)
			local var_534_0 = 0
			local var_534_1 = 0.25

			if var_534_0 < arg_531_1.time_ and arg_531_1.time_ <= var_534_0 + arg_534_0 then
				arg_531_1.talkMaxDuration = 0
				arg_531_1.dialogCg_.alpha = 1

				arg_531_1.dialog_:SetActive(true)
				SetActive(arg_531_1.leftNameGo_, true)

				local var_534_2 = arg_531_1:FormatText(StoryNameCfg[7].name)

				arg_531_1.leftNameTxt_.text = var_534_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_531_1.leftNameTxt_.transform)

				arg_531_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_531_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_531_1:RecordName(arg_531_1.leftNameTxt_.text)
				SetActive(arg_531_1.iconTrs_.gameObject, true)
				arg_531_1.iconController_:SetSelectedState("hero")

				arg_531_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_531_1.callingController_:SetSelectedState("normal")

				arg_531_1.keyicon_.color = Color.New(1, 1, 1)
				arg_531_1.icon_.color = Color.New(1, 1, 1)

				local var_534_3 = arg_531_1:GetWordFromCfg(1108503126)
				local var_534_4 = arg_531_1:FormatText(var_534_3.content)

				arg_531_1.text_.text = var_534_4

				LuaForUtil.ClearLinePrefixSymbol(arg_531_1.text_)

				local var_534_5 = 10
				local var_534_6 = utf8.len(var_534_4)
				local var_534_7 = var_534_5 <= 0 and var_534_1 or var_534_1 * (var_534_6 / var_534_5)

				if var_534_7 > 0 and var_534_1 < var_534_7 then
					arg_531_1.talkMaxDuration = var_534_7

					if var_534_7 + var_534_0 > arg_531_1.duration_ then
						arg_531_1.duration_ = var_534_7 + var_534_0
					end
				end

				arg_531_1.text_.text = var_534_4
				arg_531_1.typewritter.percent = 0

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(false)
				arg_531_1:RecordContent(arg_531_1.text_.text)
			end

			local var_534_8 = math.max(var_534_1, arg_531_1.talkMaxDuration)

			if var_534_0 <= arg_531_1.time_ and arg_531_1.time_ < var_534_0 + var_534_8 then
				arg_531_1.typewritter.percent = (arg_531_1.time_ - var_534_0) / var_534_8

				arg_531_1.typewritter:SetDirty()
			end

			if arg_531_1.time_ >= var_534_0 + var_534_8 and arg_531_1.time_ < var_534_0 + var_534_8 + arg_534_0 then
				arg_531_1.typewritter.percent = 1

				arg_531_1.typewritter:SetDirty()
				arg_531_1:ShowNextGo(true)
			end
		end

		arg_531_1.nodeConfigList_ = {}

		arg_531_1:InitPlayNodeList()
	end,
	Play1108503127 = function(arg_535_0, arg_535_1)
		arg_535_1.time_ = 0
		arg_535_1.frameCnt_ = 0
		arg_535_1.state_ = "playing"
		arg_535_1.curTalkId_ = 1108503127
		arg_535_1.duration_ = 5

		SetActive(arg_535_1.tipsGo_, false)

		function arg_535_1.onSingleLineFinish_()
			arg_535_1.onSingleLineUpdate_ = nil
			arg_535_1.onSingleLineFinish_ = nil
			arg_535_1.state_ = "waiting"
		end

		function arg_535_1.playNext_(arg_537_0)
			if arg_537_0 == 1 then
				arg_535_0:Play1108503128(arg_535_1)
			end
		end

		function arg_535_1.onSingleLineUpdate_(arg_538_0)
			local var_538_0 = 0
			local var_538_1 = 0.925

			if var_538_0 < arg_535_1.time_ and arg_535_1.time_ <= var_538_0 + arg_538_0 then
				arg_535_1.talkMaxDuration = 0
				arg_535_1.dialogCg_.alpha = 1

				arg_535_1.dialog_:SetActive(true)
				SetActive(arg_535_1.leftNameGo_, true)

				local var_538_2 = arg_535_1:FormatText(StoryNameCfg[7].name)

				arg_535_1.leftNameTxt_.text = var_538_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_535_1.leftNameTxt_.transform)

				arg_535_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_535_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_535_1:RecordName(arg_535_1.leftNameTxt_.text)
				SetActive(arg_535_1.iconTrs_.gameObject, true)
				arg_535_1.iconController_:SetSelectedState("hero")

				arg_535_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_535_1.callingController_:SetSelectedState("normal")

				arg_535_1.keyicon_.color = Color.New(1, 1, 1)
				arg_535_1.icon_.color = Color.New(1, 1, 1)

				local var_538_3 = arg_535_1:GetWordFromCfg(1108503127)
				local var_538_4 = arg_535_1:FormatText(var_538_3.content)

				arg_535_1.text_.text = var_538_4

				LuaForUtil.ClearLinePrefixSymbol(arg_535_1.text_)

				local var_538_5 = 37
				local var_538_6 = utf8.len(var_538_4)
				local var_538_7 = var_538_5 <= 0 and var_538_1 or var_538_1 * (var_538_6 / var_538_5)

				if var_538_7 > 0 and var_538_1 < var_538_7 then
					arg_535_1.talkMaxDuration = var_538_7

					if var_538_7 + var_538_0 > arg_535_1.duration_ then
						arg_535_1.duration_ = var_538_7 + var_538_0
					end
				end

				arg_535_1.text_.text = var_538_4
				arg_535_1.typewritter.percent = 0

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(false)
				arg_535_1:RecordContent(arg_535_1.text_.text)
			end

			local var_538_8 = math.max(var_538_1, arg_535_1.talkMaxDuration)

			if var_538_0 <= arg_535_1.time_ and arg_535_1.time_ < var_538_0 + var_538_8 then
				arg_535_1.typewritter.percent = (arg_535_1.time_ - var_538_0) / var_538_8

				arg_535_1.typewritter:SetDirty()
			end

			if arg_535_1.time_ >= var_538_0 + var_538_8 and arg_535_1.time_ < var_538_0 + var_538_8 + arg_538_0 then
				arg_535_1.typewritter.percent = 1

				arg_535_1.typewritter:SetDirty()
				arg_535_1:ShowNextGo(true)
			end
		end

		arg_535_1.nodeConfigList_ = {}

		arg_535_1:InitPlayNodeList()
	end,
	Play1108503128 = function(arg_539_0, arg_539_1)
		arg_539_1.time_ = 0
		arg_539_1.frameCnt_ = 0
		arg_539_1.state_ = "playing"
		arg_539_1.curTalkId_ = 1108503128
		arg_539_1.duration_ = 5

		SetActive(arg_539_1.tipsGo_, false)

		function arg_539_1.onSingleLineFinish_()
			arg_539_1.onSingleLineUpdate_ = nil
			arg_539_1.onSingleLineFinish_ = nil
			arg_539_1.state_ = "waiting"
		end

		function arg_539_1.playNext_(arg_541_0)
			if arg_541_0 == 1 then
				arg_539_0:Play1108503129(arg_539_1)
			end
		end

		function arg_539_1.onSingleLineUpdate_(arg_542_0)
			local var_542_0 = 0
			local var_542_1 = 0.6

			if var_542_0 < arg_539_1.time_ and arg_539_1.time_ <= var_542_0 + arg_542_0 then
				arg_539_1.talkMaxDuration = 0
				arg_539_1.dialogCg_.alpha = 1

				arg_539_1.dialog_:SetActive(true)
				SetActive(arg_539_1.leftNameGo_, true)

				local var_542_2 = arg_539_1:FormatText(StoryNameCfg[7].name)

				arg_539_1.leftNameTxt_.text = var_542_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_539_1.leftNameTxt_.transform)

				arg_539_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_539_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_539_1:RecordName(arg_539_1.leftNameTxt_.text)
				SetActive(arg_539_1.iconTrs_.gameObject, true)
				arg_539_1.iconController_:SetSelectedState("hero")

				arg_539_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_539_1.callingController_:SetSelectedState("normal")

				arg_539_1.keyicon_.color = Color.New(1, 1, 1)
				arg_539_1.icon_.color = Color.New(1, 1, 1)

				local var_542_3 = arg_539_1:GetWordFromCfg(1108503128)
				local var_542_4 = arg_539_1:FormatText(var_542_3.content)

				arg_539_1.text_.text = var_542_4

				LuaForUtil.ClearLinePrefixSymbol(arg_539_1.text_)

				local var_542_5 = 24
				local var_542_6 = utf8.len(var_542_4)
				local var_542_7 = var_542_5 <= 0 and var_542_1 or var_542_1 * (var_542_6 / var_542_5)

				if var_542_7 > 0 and var_542_1 < var_542_7 then
					arg_539_1.talkMaxDuration = var_542_7

					if var_542_7 + var_542_0 > arg_539_1.duration_ then
						arg_539_1.duration_ = var_542_7 + var_542_0
					end
				end

				arg_539_1.text_.text = var_542_4
				arg_539_1.typewritter.percent = 0

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(false)
				arg_539_1:RecordContent(arg_539_1.text_.text)
			end

			local var_542_8 = math.max(var_542_1, arg_539_1.talkMaxDuration)

			if var_542_0 <= arg_539_1.time_ and arg_539_1.time_ < var_542_0 + var_542_8 then
				arg_539_1.typewritter.percent = (arg_539_1.time_ - var_542_0) / var_542_8

				arg_539_1.typewritter:SetDirty()
			end

			if arg_539_1.time_ >= var_542_0 + var_542_8 and arg_539_1.time_ < var_542_0 + var_542_8 + arg_542_0 then
				arg_539_1.typewritter.percent = 1

				arg_539_1.typewritter:SetDirty()
				arg_539_1:ShowNextGo(true)
			end
		end

		arg_539_1.nodeConfigList_ = {}

		arg_539_1:InitPlayNodeList()
	end,
	Play1108503129 = function(arg_543_0, arg_543_1)
		arg_543_1.time_ = 0
		arg_543_1.frameCnt_ = 0
		arg_543_1.state_ = "playing"
		arg_543_1.curTalkId_ = 1108503129
		arg_543_1.duration_ = 2

		SetActive(arg_543_1.tipsGo_, false)

		function arg_543_1.onSingleLineFinish_()
			arg_543_1.onSingleLineUpdate_ = nil
			arg_543_1.onSingleLineFinish_ = nil
			arg_543_1.state_ = "waiting"
		end

		function arg_543_1.playNext_(arg_545_0)
			if arg_545_0 == 1 then
				arg_543_0:Play1108503130(arg_543_1)
			end
		end

		function arg_543_1.onSingleLineUpdate_(arg_546_0)
			local var_546_0 = arg_543_1.actors_["1085ui_story"].transform
			local var_546_1 = 0

			if var_546_1 < arg_543_1.time_ and arg_543_1.time_ <= var_546_1 + arg_546_0 then
				arg_543_1.var_.moveOldPos1085ui_story = var_546_0.localPosition
			end

			local var_546_2 = 0.001

			if var_546_1 <= arg_543_1.time_ and arg_543_1.time_ < var_546_1 + var_546_2 then
				local var_546_3 = (arg_543_1.time_ - var_546_1) / var_546_2
				local var_546_4 = Vector3.New(0, -1.01, -5.83)

				var_546_0.localPosition = Vector3.Lerp(arg_543_1.var_.moveOldPos1085ui_story, var_546_4, var_546_3)

				local var_546_5 = manager.ui.mainCamera.transform.position - var_546_0.position

				var_546_0.forward = Vector3.New(var_546_5.x, var_546_5.y, var_546_5.z)

				local var_546_6 = var_546_0.localEulerAngles

				var_546_6.z = 0
				var_546_6.x = 0
				var_546_0.localEulerAngles = var_546_6
			end

			if arg_543_1.time_ >= var_546_1 + var_546_2 and arg_543_1.time_ < var_546_1 + var_546_2 + arg_546_0 then
				var_546_0.localPosition = Vector3.New(0, -1.01, -5.83)

				local var_546_7 = manager.ui.mainCamera.transform.position - var_546_0.position

				var_546_0.forward = Vector3.New(var_546_7.x, var_546_7.y, var_546_7.z)

				local var_546_8 = var_546_0.localEulerAngles

				var_546_8.z = 0
				var_546_8.x = 0
				var_546_0.localEulerAngles = var_546_8
			end

			local var_546_9 = arg_543_1.actors_["1085ui_story"]
			local var_546_10 = 0

			if var_546_10 < arg_543_1.time_ and arg_543_1.time_ <= var_546_10 + arg_546_0 and not isNil(var_546_9) and arg_543_1.var_.characterEffect1085ui_story == nil then
				arg_543_1.var_.characterEffect1085ui_story = var_546_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_546_11 = 0.200000002980232

			if var_546_10 <= arg_543_1.time_ and arg_543_1.time_ < var_546_10 + var_546_11 and not isNil(var_546_9) then
				local var_546_12 = (arg_543_1.time_ - var_546_10) / var_546_11

				if arg_543_1.var_.characterEffect1085ui_story and not isNil(var_546_9) then
					arg_543_1.var_.characterEffect1085ui_story.fillFlat = false
				end
			end

			if arg_543_1.time_ >= var_546_10 + var_546_11 and arg_543_1.time_ < var_546_10 + var_546_11 + arg_546_0 and not isNil(var_546_9) and arg_543_1.var_.characterEffect1085ui_story then
				arg_543_1.var_.characterEffect1085ui_story.fillFlat = false
			end

			local var_546_13 = 0

			if var_546_13 < arg_543_1.time_ and arg_543_1.time_ <= var_546_13 + arg_546_0 then
				arg_543_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/story1085/story1085action/1085action2_1")
			end

			local var_546_14 = 0

			if var_546_14 < arg_543_1.time_ and arg_543_1.time_ <= var_546_14 + arg_546_0 then
				arg_543_1:PlayTimeline("1085ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_546_15 = 0
			local var_546_16 = 0.1

			if var_546_15 < arg_543_1.time_ and arg_543_1.time_ <= var_546_15 + arg_546_0 then
				arg_543_1.talkMaxDuration = 0
				arg_543_1.dialogCg_.alpha = 1

				arg_543_1.dialog_:SetActive(true)
				SetActive(arg_543_1.leftNameGo_, true)

				local var_546_17 = arg_543_1:FormatText(StoryNameCfg[328].name)

				arg_543_1.leftNameTxt_.text = var_546_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_543_1.leftNameTxt_.transform)

				arg_543_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_543_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_543_1:RecordName(arg_543_1.leftNameTxt_.text)
				SetActive(arg_543_1.iconTrs_.gameObject, false)
				arg_543_1.callingController_:SetSelectedState("normal")

				local var_546_18 = arg_543_1:GetWordFromCfg(1108503129)
				local var_546_19 = arg_543_1:FormatText(var_546_18.content)

				arg_543_1.text_.text = var_546_19

				LuaForUtil.ClearLinePrefixSymbol(arg_543_1.text_)

				local var_546_20 = 4
				local var_546_21 = utf8.len(var_546_19)
				local var_546_22 = var_546_20 <= 0 and var_546_16 or var_546_16 * (var_546_21 / var_546_20)

				if var_546_22 > 0 and var_546_16 < var_546_22 then
					arg_543_1.talkMaxDuration = var_546_22

					if var_546_22 + var_546_15 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_22 + var_546_15
					end
				end

				arg_543_1.text_.text = var_546_19
				arg_543_1.typewritter.percent = 0

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503129", "story_v_side_new_1108503.awb") ~= 0 then
					local var_546_23 = manager.audio:GetVoiceLength("story_v_side_new_1108503", "1108503129", "story_v_side_new_1108503.awb") / 1000

					if var_546_23 + var_546_15 > arg_543_1.duration_ then
						arg_543_1.duration_ = var_546_23 + var_546_15
					end

					if var_546_18.prefab_name ~= "" and arg_543_1.actors_[var_546_18.prefab_name] ~= nil then
						local var_546_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_543_1.actors_[var_546_18.prefab_name].transform, "story_v_side_new_1108503", "1108503129", "story_v_side_new_1108503.awb")

						arg_543_1:RecordAudio("1108503129", var_546_24)
						arg_543_1:RecordAudio("1108503129", var_546_24)
					else
						arg_543_1:AudioAction("play", "voice", "story_v_side_new_1108503", "1108503129", "story_v_side_new_1108503.awb")
					end

					arg_543_1:RecordHistoryTalkVoice("story_v_side_new_1108503", "1108503129", "story_v_side_new_1108503.awb")
				end

				arg_543_1:RecordContent(arg_543_1.text_.text)
			end

			local var_546_25 = math.max(var_546_16, arg_543_1.talkMaxDuration)

			if var_546_15 <= arg_543_1.time_ and arg_543_1.time_ < var_546_15 + var_546_25 then
				arg_543_1.typewritter.percent = (arg_543_1.time_ - var_546_15) / var_546_25

				arg_543_1.typewritter:SetDirty()
			end

			if arg_543_1.time_ >= var_546_15 + var_546_25 and arg_543_1.time_ < var_546_15 + var_546_25 + arg_546_0 then
				arg_543_1.typewritter.percent = 1

				arg_543_1.typewritter:SetDirty()
				arg_543_1:ShowNextGo(true)
			end
		end

		arg_543_1.nodeConfigList_ = {
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

		arg_543_1:InitPlayNodeList()
	end,
	Play1108503130 = function(arg_547_0, arg_547_1)
		arg_547_1.time_ = 0
		arg_547_1.frameCnt_ = 0
		arg_547_1.state_ = "playing"
		arg_547_1.curTalkId_ = 1108503130
		arg_547_1.duration_ = 5

		SetActive(arg_547_1.tipsGo_, false)

		function arg_547_1.onSingleLineFinish_()
			arg_547_1.onSingleLineUpdate_ = nil
			arg_547_1.onSingleLineFinish_ = nil
			arg_547_1.state_ = "waiting"
		end

		function arg_547_1.playNext_(arg_549_0)
			if arg_549_0 == 1 then
				arg_547_0:Play1108503131(arg_547_1)
			end
		end

		function arg_547_1.onSingleLineUpdate_(arg_550_0)
			local var_550_0 = arg_547_1.actors_["1085ui_story"]
			local var_550_1 = 0

			if var_550_1 < arg_547_1.time_ and arg_547_1.time_ <= var_550_1 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.characterEffect1085ui_story == nil then
				arg_547_1.var_.characterEffect1085ui_story = var_550_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_550_2 = 0.200000002980232

			if var_550_1 <= arg_547_1.time_ and arg_547_1.time_ < var_550_1 + var_550_2 and not isNil(var_550_0) then
				local var_550_3 = (arg_547_1.time_ - var_550_1) / var_550_2

				if arg_547_1.var_.characterEffect1085ui_story and not isNil(var_550_0) then
					local var_550_4 = Mathf.Lerp(0, 0.5, var_550_3)

					arg_547_1.var_.characterEffect1085ui_story.fillFlat = true
					arg_547_1.var_.characterEffect1085ui_story.fillRatio = var_550_4
				end
			end

			if arg_547_1.time_ >= var_550_1 + var_550_2 and arg_547_1.time_ < var_550_1 + var_550_2 + arg_550_0 and not isNil(var_550_0) and arg_547_1.var_.characterEffect1085ui_story then
				local var_550_5 = 0.5

				arg_547_1.var_.characterEffect1085ui_story.fillFlat = true
				arg_547_1.var_.characterEffect1085ui_story.fillRatio = var_550_5
			end

			local var_550_6 = 0
			local var_550_7 = 0.975

			if var_550_6 < arg_547_1.time_ and arg_547_1.time_ <= var_550_6 + arg_550_0 then
				arg_547_1.talkMaxDuration = 0
				arg_547_1.dialogCg_.alpha = 1

				arg_547_1.dialog_:SetActive(true)
				SetActive(arg_547_1.leftNameGo_, true)

				local var_550_8 = arg_547_1:FormatText(StoryNameCfg[7].name)

				arg_547_1.leftNameTxt_.text = var_550_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_547_1.leftNameTxt_.transform)

				arg_547_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_547_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_547_1:RecordName(arg_547_1.leftNameTxt_.text)
				SetActive(arg_547_1.iconTrs_.gameObject, true)
				arg_547_1.iconController_:SetSelectedState("hero")

				arg_547_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_547_1.callingController_:SetSelectedState("normal")

				arg_547_1.keyicon_.color = Color.New(1, 1, 1)
				arg_547_1.icon_.color = Color.New(1, 1, 1)

				local var_550_9 = arg_547_1:GetWordFromCfg(1108503130)
				local var_550_10 = arg_547_1:FormatText(var_550_9.content)

				arg_547_1.text_.text = var_550_10

				LuaForUtil.ClearLinePrefixSymbol(arg_547_1.text_)

				local var_550_11 = 39
				local var_550_12 = utf8.len(var_550_10)
				local var_550_13 = var_550_11 <= 0 and var_550_7 or var_550_7 * (var_550_12 / var_550_11)

				if var_550_13 > 0 and var_550_7 < var_550_13 then
					arg_547_1.talkMaxDuration = var_550_13

					if var_550_13 + var_550_6 > arg_547_1.duration_ then
						arg_547_1.duration_ = var_550_13 + var_550_6
					end
				end

				arg_547_1.text_.text = var_550_10
				arg_547_1.typewritter.percent = 0

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(false)
				arg_547_1:RecordContent(arg_547_1.text_.text)
			end

			local var_550_14 = math.max(var_550_7, arg_547_1.talkMaxDuration)

			if var_550_6 <= arg_547_1.time_ and arg_547_1.time_ < var_550_6 + var_550_14 then
				arg_547_1.typewritter.percent = (arg_547_1.time_ - var_550_6) / var_550_14

				arg_547_1.typewritter:SetDirty()
			end

			if arg_547_1.time_ >= var_550_6 + var_550_14 and arg_547_1.time_ < var_550_6 + var_550_14 + arg_550_0 then
				arg_547_1.typewritter.percent = 1

				arg_547_1.typewritter:SetDirty()
				arg_547_1:ShowNextGo(true)
			end
		end

		arg_547_1.nodeConfigList_ = {}

		arg_547_1:InitPlayNodeList()
	end,
	Play1108503131 = function(arg_551_0, arg_551_1)
		arg_551_1.time_ = 0
		arg_551_1.frameCnt_ = 0
		arg_551_1.state_ = "playing"
		arg_551_1.curTalkId_ = 1108503131
		arg_551_1.duration_ = 5

		SetActive(arg_551_1.tipsGo_, false)

		function arg_551_1.onSingleLineFinish_()
			arg_551_1.onSingleLineUpdate_ = nil
			arg_551_1.onSingleLineFinish_ = nil
			arg_551_1.state_ = "waiting"
		end

		function arg_551_1.playNext_(arg_553_0)
			if arg_553_0 == 1 then
				arg_551_0:Play1108503132(arg_551_1)
			end
		end

		function arg_551_1.onSingleLineUpdate_(arg_554_0)
			local var_554_0 = 0
			local var_554_1 = 0.5

			if var_554_0 < arg_551_1.time_ and arg_551_1.time_ <= var_554_0 + arg_554_0 then
				arg_551_1.talkMaxDuration = 0
				arg_551_1.dialogCg_.alpha = 1

				arg_551_1.dialog_:SetActive(true)
				SetActive(arg_551_1.leftNameGo_, true)

				local var_554_2 = arg_551_1:FormatText(StoryNameCfg[7].name)

				arg_551_1.leftNameTxt_.text = var_554_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_551_1.leftNameTxt_.transform)

				arg_551_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_551_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_551_1:RecordName(arg_551_1.leftNameTxt_.text)
				SetActive(arg_551_1.iconTrs_.gameObject, true)
				arg_551_1.iconController_:SetSelectedState("hero")

				arg_551_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_551_1.callingController_:SetSelectedState("normal")

				arg_551_1.keyicon_.color = Color.New(1, 1, 1)
				arg_551_1.icon_.color = Color.New(1, 1, 1)

				local var_554_3 = arg_551_1:GetWordFromCfg(1108503131)
				local var_554_4 = arg_551_1:FormatText(var_554_3.content)

				arg_551_1.text_.text = var_554_4

				LuaForUtil.ClearLinePrefixSymbol(arg_551_1.text_)

				local var_554_5 = 20
				local var_554_6 = utf8.len(var_554_4)
				local var_554_7 = var_554_5 <= 0 and var_554_1 or var_554_1 * (var_554_6 / var_554_5)

				if var_554_7 > 0 and var_554_1 < var_554_7 then
					arg_551_1.talkMaxDuration = var_554_7

					if var_554_7 + var_554_0 > arg_551_1.duration_ then
						arg_551_1.duration_ = var_554_7 + var_554_0
					end
				end

				arg_551_1.text_.text = var_554_4
				arg_551_1.typewritter.percent = 0

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(false)
				arg_551_1:RecordContent(arg_551_1.text_.text)
			end

			local var_554_8 = math.max(var_554_1, arg_551_1.talkMaxDuration)

			if var_554_0 <= arg_551_1.time_ and arg_551_1.time_ < var_554_0 + var_554_8 then
				arg_551_1.typewritter.percent = (arg_551_1.time_ - var_554_0) / var_554_8

				arg_551_1.typewritter:SetDirty()
			end

			if arg_551_1.time_ >= var_554_0 + var_554_8 and arg_551_1.time_ < var_554_0 + var_554_8 + arg_554_0 then
				arg_551_1.typewritter.percent = 1

				arg_551_1.typewritter:SetDirty()
				arg_551_1:ShowNextGo(true)
			end
		end

		arg_551_1.nodeConfigList_ = {}

		arg_551_1:InitPlayNodeList()
	end,
	Play1108503132 = function(arg_555_0, arg_555_1)
		arg_555_1.time_ = 0
		arg_555_1.frameCnt_ = 0
		arg_555_1.state_ = "playing"
		arg_555_1.curTalkId_ = 1108503132
		arg_555_1.duration_ = 5

		SetActive(arg_555_1.tipsGo_, false)

		function arg_555_1.onSingleLineFinish_()
			arg_555_1.onSingleLineUpdate_ = nil
			arg_555_1.onSingleLineFinish_ = nil
			arg_555_1.state_ = "waiting"
			arg_555_1.auto_ = false
		end

		function arg_555_1.playNext_(arg_557_0)
			arg_555_1.onStoryFinished_()
		end

		function arg_555_1.onSingleLineUpdate_(arg_558_0)
			local var_558_0 = arg_555_1.actors_["1085ui_story"].transform
			local var_558_1 = 0

			if var_558_1 < arg_555_1.time_ and arg_555_1.time_ <= var_558_1 + arg_558_0 then
				arg_555_1.var_.moveOldPos1085ui_story = var_558_0.localPosition
			end

			local var_558_2 = 0.001

			if var_558_1 <= arg_555_1.time_ and arg_555_1.time_ < var_558_1 + var_558_2 then
				local var_558_3 = (arg_555_1.time_ - var_558_1) / var_558_2
				local var_558_4 = Vector3.New(0, 100, 0)

				var_558_0.localPosition = Vector3.Lerp(arg_555_1.var_.moveOldPos1085ui_story, var_558_4, var_558_3)

				local var_558_5 = manager.ui.mainCamera.transform.position - var_558_0.position

				var_558_0.forward = Vector3.New(var_558_5.x, var_558_5.y, var_558_5.z)

				local var_558_6 = var_558_0.localEulerAngles

				var_558_6.z = 0
				var_558_6.x = 0
				var_558_0.localEulerAngles = var_558_6
			end

			if arg_555_1.time_ >= var_558_1 + var_558_2 and arg_555_1.time_ < var_558_1 + var_558_2 + arg_558_0 then
				var_558_0.localPosition = Vector3.New(0, 100, 0)

				local var_558_7 = manager.ui.mainCamera.transform.position - var_558_0.position

				var_558_0.forward = Vector3.New(var_558_7.x, var_558_7.y, var_558_7.z)

				local var_558_8 = var_558_0.localEulerAngles

				var_558_8.z = 0
				var_558_8.x = 0
				var_558_0.localEulerAngles = var_558_8
			end

			local var_558_9 = 0.274999999999
			local var_558_10 = 1

			if var_558_9 < arg_555_1.time_ and arg_555_1.time_ <= var_558_9 + arg_558_0 then
				local var_558_11 = "play"
				local var_558_12 = "effect"

				arg_555_1:AudioAction(var_558_11, var_558_12, "se_story_148", "se_story_148_hold", "")
			end

			local var_558_13 = 0
			local var_558_14 = 1.275

			if var_558_13 < arg_555_1.time_ and arg_555_1.time_ <= var_558_13 + arg_558_0 then
				arg_555_1.talkMaxDuration = 0
				arg_555_1.dialogCg_.alpha = 1

				arg_555_1.dialog_:SetActive(true)
				SetActive(arg_555_1.leftNameGo_, false)

				arg_555_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_555_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_555_1:RecordName(arg_555_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_555_1.iconTrs_.gameObject, false)
				arg_555_1.callingController_:SetSelectedState("normal")

				local var_558_15 = arg_555_1:GetWordFromCfg(1108503132)
				local var_558_16 = arg_555_1:FormatText(var_558_15.content)

				arg_555_1.text_.text = var_558_16

				LuaForUtil.ClearLinePrefixSymbol(arg_555_1.text_)

				local var_558_17 = 51
				local var_558_18 = utf8.len(var_558_16)
				local var_558_19 = var_558_17 <= 0 and var_558_14 or var_558_14 * (var_558_18 / var_558_17)

				if var_558_19 > 0 and var_558_14 < var_558_19 then
					arg_555_1.talkMaxDuration = var_558_19

					if var_558_19 + var_558_13 > arg_555_1.duration_ then
						arg_555_1.duration_ = var_558_19 + var_558_13
					end
				end

				arg_555_1.text_.text = var_558_16
				arg_555_1.typewritter.percent = 0

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(false)
				arg_555_1:RecordContent(arg_555_1.text_.text)
			end

			local var_558_20 = math.max(var_558_14, arg_555_1.talkMaxDuration)

			if var_558_13 <= arg_555_1.time_ and arg_555_1.time_ < var_558_13 + var_558_20 then
				arg_555_1.typewritter.percent = (arg_555_1.time_ - var_558_13) / var_558_20

				arg_555_1.typewritter:SetDirty()
			end

			if arg_555_1.time_ >= var_558_13 + var_558_20 and arg_555_1.time_ < var_558_13 + var_558_20 + arg_558_0 then
				arg_555_1.typewritter.percent = 1

				arg_555_1.typewritter:SetDirty()
				arg_555_1:ShowNextGo(true)
			end
		end

		arg_555_1.nodeConfigList_ = {
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

		arg_555_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST20",
		"TextureConfig/Background/B13",
		"TextureConfig/Background/ST07a",
		"TextureConfig/Background/ST12a",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_side_new_1108503.awb"
	}
}
