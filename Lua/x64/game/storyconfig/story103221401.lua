return {
	Play322141001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 322141001
		arg_1_1.duration_ = 3.8

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play322141002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "L19i"

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
				local var_4_5 = arg_1_1.bgs_.L19i

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
					if iter_4_0 ~= "L19i" then
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

			local var_4_24 = "1044ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "1044ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "1044ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["1044ui_story"].transform
			local var_4_30 = 1.8

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos1044ui_story = var_4_29.localPosition

				local var_4_31 = "1044ui_story"

				arg_1_1:ShowWeapon(arg_1_1.var_[var_4_31 .. "Animator"].transform, false)
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(-0.7, -1, -5.93)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1044ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_4_37 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_37.x, var_4_37.y, var_4_37.z)

				local var_4_38 = var_4_29.localEulerAngles

				var_4_38.z = 0
				var_4_38.x = 0
				var_4_29.localEulerAngles = var_4_38
			end

			local var_4_39 = arg_1_1.actors_["1044ui_story"]
			local var_4_40 = 1.8

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1044ui_story == nil then
				arg_1_1.var_.characterEffect1044ui_story = var_4_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_41 = 0.200000002980232

			if var_4_40 <= arg_1_1.time_ and arg_1_1.time_ < var_4_40 + var_4_41 and not isNil(var_4_39) then
				local var_4_42 = (arg_1_1.time_ - var_4_40) / var_4_41

				if arg_1_1.var_.characterEffect1044ui_story and not isNil(var_4_39) then
					arg_1_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_40 + var_4_41 and arg_1_1.time_ < var_4_40 + var_4_41 + arg_4_0 and not isNil(var_4_39) and arg_1_1.var_.characterEffect1044ui_story then
				arg_1_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_4_43 = 1.8

			if var_4_43 < arg_1_1.time_ and arg_1_1.time_ <= var_4_43 + arg_4_0 then
				arg_1_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_1")
			end

			local var_4_44 = 1.8

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_4_45 = 0.2
			local var_4_46 = 1

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				local var_4_47 = "play"
				local var_4_48 = "effect"

				arg_1_1:AudioAction(var_4_47, var_4_48, "se_story_145", "se_story_145_amb_stone_l19f", "")
			end

			local var_4_49 = 0
			local var_4_50 = 0.3

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

			local var_4_55 = 0.500666666666667
			local var_4_56 = 1

			if var_4_55 < arg_1_1.time_ and arg_1_1.time_ <= var_4_55 + arg_4_0 then
				local var_4_57 = "play"
				local var_4_58 = "music"

				arg_1_1:AudioAction(var_4_57, var_4_58, "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_4_59 = ""
				local var_4_60 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_61 = 2
			local var_4_62 = 0.125

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_63 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_63:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_63:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_63:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_64 = arg_1_1:FormatText(StoryNameCfg[67].name)

				arg_1_1.leftNameTxt_.text = var_4_64

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_65 = arg_1_1:GetWordFromCfg(322141001)
				local var_4_66 = arg_1_1:FormatText(var_4_65.content)

				arg_1_1.text_.text = var_4_66

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_67 = 5
				local var_4_68 = utf8.len(var_4_66)
				local var_4_69 = var_4_67 <= 0 and var_4_62 or var_4_62 * (var_4_68 / var_4_67)

				if var_4_69 > 0 and var_4_62 < var_4_69 then
					arg_1_1.talkMaxDuration = var_4_69
					var_4_61 = var_4_61 + 0.3

					if var_4_69 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_69 + var_4_61
					end
				end

				arg_1_1.text_.text = var_4_66
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141001", "story_v_out_322141.awb") ~= 0 then
					local var_4_70 = manager.audio:GetVoiceLength("story_v_out_322141", "322141001", "story_v_out_322141.awb") / 1000

					if var_4_70 + var_4_61 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_70 + var_4_61
					end

					if var_4_65.prefab_name ~= "" and arg_1_1.actors_[var_4_65.prefab_name] ~= nil then
						local var_4_71 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_65.prefab_name].transform, "story_v_out_322141", "322141001", "story_v_out_322141.awb")

						arg_1_1:RecordAudio("322141001", var_4_71)
						arg_1_1:RecordAudio("322141001", var_4_71)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_322141", "322141001", "story_v_out_322141.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_322141", "322141001", "story_v_out_322141.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_72 = var_4_61 + 0.3
			local var_4_73 = math.max(var_4_62, arg_1_1.talkMaxDuration)

			if var_4_72 <= arg_1_1.time_ and arg_1_1.time_ < var_4_72 + var_4_73 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_72) / var_4_73

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_72 + var_4_73 and arg_1_1.time_ < var_4_72 + var_4_73 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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
	Play322141002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 322141002
		arg_9_1.duration_ = 2

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play322141003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = "1043ui_story"

			if arg_9_1.actors_[var_12_0] == nil then
				local var_12_1 = Asset.Load("Char/" .. "1043ui_story")

				if not isNil(var_12_1) then
					local var_12_2 = Object.Instantiate(Asset.Load("Char/" .. "1043ui_story"), arg_9_1.stage_.transform)

					var_12_2.name = var_12_0
					var_12_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_9_1.actors_[var_12_0] = var_12_2

					local var_12_3 = var_12_2:GetComponentInChildren(typeof(CharacterEffect))

					var_12_3.enabled = true

					local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_2, typeof(DynamicBoneHelper))

					if var_12_4 then
						var_12_4:EnableDynamicBone(false)
					end

					arg_9_1:ShowWeapon(var_12_3.transform, false)

					arg_9_1.var_[var_12_0 .. "Animator"] = var_12_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_9_1.var_[var_12_0 .. "Animator"].applyRootMotion = true
					arg_9_1.var_[var_12_0 .. "LipSync"] = var_12_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_12_5 = arg_9_1.actors_["1043ui_story"].transform
			local var_12_6 = 0

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.var_.moveOldPos1043ui_story = var_12_5.localPosition
			end

			local var_12_7 = 0.001

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_7 then
				local var_12_8 = (arg_9_1.time_ - var_12_6) / var_12_7
				local var_12_9 = Vector3.New(0.81, -1.01, -5.73)

				var_12_5.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1043ui_story, var_12_9, var_12_8)

				local var_12_10 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_10.x, var_12_10.y, var_12_10.z)

				local var_12_11 = var_12_5.localEulerAngles

				var_12_11.z = 0
				var_12_11.x = 0
				var_12_5.localEulerAngles = var_12_11
			end

			if arg_9_1.time_ >= var_12_6 + var_12_7 and arg_9_1.time_ < var_12_6 + var_12_7 + arg_12_0 then
				var_12_5.localPosition = Vector3.New(0.81, -1.01, -5.73)

				local var_12_12 = manager.ui.mainCamera.transform.position - var_12_5.position

				var_12_5.forward = Vector3.New(var_12_12.x, var_12_12.y, var_12_12.z)

				local var_12_13 = var_12_5.localEulerAngles

				var_12_13.z = 0
				var_12_13.x = 0
				var_12_5.localEulerAngles = var_12_13
			end

			local var_12_14 = arg_9_1.actors_["1043ui_story"]
			local var_12_15 = 0

			if var_12_15 < arg_9_1.time_ and arg_9_1.time_ <= var_12_15 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1043ui_story == nil then
				arg_9_1.var_.characterEffect1043ui_story = var_12_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_16 = 0.200000002980232

			if var_12_15 <= arg_9_1.time_ and arg_9_1.time_ < var_12_15 + var_12_16 and not isNil(var_12_14) then
				local var_12_17 = (arg_9_1.time_ - var_12_15) / var_12_16

				if arg_9_1.var_.characterEffect1043ui_story and not isNil(var_12_14) then
					arg_9_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= var_12_15 + var_12_16 and arg_9_1.time_ < var_12_15 + var_12_16 + arg_12_0 and not isNil(var_12_14) and arg_9_1.var_.characterEffect1043ui_story then
				arg_9_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_12_18 = arg_9_1.actors_["1044ui_story"]
			local var_12_19 = 0

			if var_12_19 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 and not isNil(var_12_18) and arg_9_1.var_.characterEffect1044ui_story == nil then
				arg_9_1.var_.characterEffect1044ui_story = var_12_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_20 = 0.200000002980232

			if var_12_19 <= arg_9_1.time_ and arg_9_1.time_ < var_12_19 + var_12_20 and not isNil(var_12_18) then
				local var_12_21 = (arg_9_1.time_ - var_12_19) / var_12_20

				if arg_9_1.var_.characterEffect1044ui_story and not isNil(var_12_18) then
					local var_12_22 = Mathf.Lerp(0, 0.5, var_12_21)

					arg_9_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1044ui_story.fillRatio = var_12_22
				end
			end

			if arg_9_1.time_ >= var_12_19 + var_12_20 and arg_9_1.time_ < var_12_19 + var_12_20 + arg_12_0 and not isNil(var_12_18) and arg_9_1.var_.characterEffect1044ui_story then
				local var_12_23 = 0.5

				arg_9_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1044ui_story.fillRatio = var_12_23
			end

			local var_12_24 = 0

			if var_12_24 < arg_9_1.time_ and arg_9_1.time_ <= var_12_24 + arg_12_0 then
				arg_9_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_12_25 = 0

			if var_12_25 < arg_9_1.time_ and arg_9_1.time_ <= var_12_25 + arg_12_0 then
				arg_9_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_12_26 = 0
			local var_12_27 = 0.175

			if var_12_26 < arg_9_1.time_ and arg_9_1.time_ <= var_12_26 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_28 = arg_9_1:FormatText(StoryNameCfg[1156].name)

				arg_9_1.leftNameTxt_.text = var_12_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_29 = arg_9_1:GetWordFromCfg(322141002)
				local var_12_30 = arg_9_1:FormatText(var_12_29.content)

				arg_9_1.text_.text = var_12_30

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_31 = 7
				local var_12_32 = utf8.len(var_12_30)
				local var_12_33 = var_12_31 <= 0 and var_12_27 or var_12_27 * (var_12_32 / var_12_31)

				if var_12_33 > 0 and var_12_27 < var_12_33 then
					arg_9_1.talkMaxDuration = var_12_33

					if var_12_33 + var_12_26 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_33 + var_12_26
					end
				end

				arg_9_1.text_.text = var_12_30
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141002", "story_v_out_322141.awb") ~= 0 then
					local var_12_34 = manager.audio:GetVoiceLength("story_v_out_322141", "322141002", "story_v_out_322141.awb") / 1000

					if var_12_34 + var_12_26 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_34 + var_12_26
					end

					if var_12_29.prefab_name ~= "" and arg_9_1.actors_[var_12_29.prefab_name] ~= nil then
						local var_12_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_29.prefab_name].transform, "story_v_out_322141", "322141002", "story_v_out_322141.awb")

						arg_9_1:RecordAudio("322141002", var_12_35)
						arg_9_1:RecordAudio("322141002", var_12_35)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_322141", "322141002", "story_v_out_322141.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_322141", "322141002", "story_v_out_322141.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_36 = math.max(var_12_27, arg_9_1.talkMaxDuration)

			if var_12_26 <= arg_9_1.time_ and arg_9_1.time_ < var_12_26 + var_12_36 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_26) / var_12_36

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_26 + var_12_36 and arg_9_1.time_ < var_12_26 + var_12_36 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
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
	Play322141003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 322141003
		arg_13_1.duration_ = 4.17

		local var_13_0 = {
			zh = 4.166,
			ja = 3.066
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
				arg_13_0:Play322141004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1044ui_story"].transform
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.var_.moveOldPos1044ui_story = var_16_0.localPosition
			end

			local var_16_2 = 0.001

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2
				local var_16_4 = Vector3.New(-0.7, -1, -5.93)

				var_16_0.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1044ui_story, var_16_4, var_16_3)

				local var_16_5 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_5.x, var_16_5.y, var_16_5.z)

				local var_16_6 = var_16_0.localEulerAngles

				var_16_6.z = 0
				var_16_6.x = 0
				var_16_0.localEulerAngles = var_16_6
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 then
				var_16_0.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_16_7 = manager.ui.mainCamera.transform.position - var_16_0.position

				var_16_0.forward = Vector3.New(var_16_7.x, var_16_7.y, var_16_7.z)

				local var_16_8 = var_16_0.localEulerAngles

				var_16_8.z = 0
				var_16_8.x = 0
				var_16_0.localEulerAngles = var_16_8
			end

			local var_16_9 = arg_13_1.actors_["1044ui_story"]
			local var_16_10 = 0

			if var_16_10 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1044ui_story == nil then
				arg_13_1.var_.characterEffect1044ui_story = var_16_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_11 and not isNil(var_16_9) then
				local var_16_12 = (arg_13_1.time_ - var_16_10) / var_16_11

				if arg_13_1.var_.characterEffect1044ui_story and not isNil(var_16_9) then
					arg_13_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_10 + var_16_11 and arg_13_1.time_ < var_16_10 + var_16_11 + arg_16_0 and not isNil(var_16_9) and arg_13_1.var_.characterEffect1044ui_story then
				arg_13_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_16_13 = arg_13_1.actors_["1043ui_story"]
			local var_16_14 = 0

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 and not isNil(var_16_13) and arg_13_1.var_.characterEffect1043ui_story == nil then
				arg_13_1.var_.characterEffect1043ui_story = var_16_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_15 = 0.200000002980232

			if var_16_14 <= arg_13_1.time_ and arg_13_1.time_ < var_16_14 + var_16_15 and not isNil(var_16_13) then
				local var_16_16 = (arg_13_1.time_ - var_16_14) / var_16_15

				if arg_13_1.var_.characterEffect1043ui_story and not isNil(var_16_13) then
					local var_16_17 = Mathf.Lerp(0, 0.5, var_16_16)

					arg_13_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1043ui_story.fillRatio = var_16_17
				end
			end

			if arg_13_1.time_ >= var_16_14 + var_16_15 and arg_13_1.time_ < var_16_14 + var_16_15 + arg_16_0 and not isNil(var_16_13) and arg_13_1.var_.characterEffect1043ui_story then
				local var_16_18 = 0.5

				arg_13_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1043ui_story.fillRatio = var_16_18
			end

			local var_16_19 = 0

			if var_16_19 < arg_13_1.time_ and arg_13_1.time_ <= var_16_19 + arg_16_0 then
				arg_13_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_2")
			end

			local var_16_20 = 0
			local var_16_21 = 0.35

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[67].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(322141003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 14
				local var_16_26 = utf8.len(var_16_24)
				local var_16_27 = var_16_25 <= 0 and var_16_21 or var_16_21 * (var_16_26 / var_16_25)

				if var_16_27 > 0 and var_16_21 < var_16_27 then
					arg_13_1.talkMaxDuration = var_16_27

					if var_16_27 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_27 + var_16_20
					end
				end

				arg_13_1.text_.text = var_16_24
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141003", "story_v_out_322141.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_322141", "322141003", "story_v_out_322141.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_322141", "322141003", "story_v_out_322141.awb")

						arg_13_1:RecordAudio("322141003", var_16_29)
						arg_13_1:RecordAudio("322141003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_322141", "322141003", "story_v_out_322141.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_322141", "322141003", "story_v_out_322141.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_30 = math.max(var_16_21, arg_13_1.talkMaxDuration)

			if var_16_20 <= arg_13_1.time_ and arg_13_1.time_ < var_16_20 + var_16_30 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_20) / var_16_30

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_20 + var_16_30 and arg_13_1.time_ < var_16_20 + var_16_30 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play322141004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 322141004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play322141005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1043ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1043ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1043ui_story, var_20_4, var_20_3)

				local var_20_5 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_5.x, var_20_5.y, var_20_5.z)

				local var_20_6 = var_20_0.localEulerAngles

				var_20_6.z = 0
				var_20_6.x = 0
				var_20_0.localEulerAngles = var_20_6
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 then
				var_20_0.localPosition = Vector3.New(0, 100, 0)

				local var_20_7 = manager.ui.mainCamera.transform.position - var_20_0.position

				var_20_0.forward = Vector3.New(var_20_7.x, var_20_7.y, var_20_7.z)

				local var_20_8 = var_20_0.localEulerAngles

				var_20_8.z = 0
				var_20_8.x = 0
				var_20_0.localEulerAngles = var_20_8
			end

			local var_20_9 = arg_17_1.actors_["1044ui_story"].transform
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 then
				arg_17_1.var_.moveOldPos1044ui_story = var_20_9.localPosition
			end

			local var_20_11 = 0.001

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11
				local var_20_13 = Vector3.New(0, 100, 0)

				var_20_9.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1044ui_story, var_20_13, var_20_12)

				local var_20_14 = manager.ui.mainCamera.transform.position - var_20_9.position

				var_20_9.forward = Vector3.New(var_20_14.x, var_20_14.y, var_20_14.z)

				local var_20_15 = var_20_9.localEulerAngles

				var_20_15.z = 0
				var_20_15.x = 0
				var_20_9.localEulerAngles = var_20_15
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 then
				var_20_9.localPosition = Vector3.New(0, 100, 0)

				local var_20_16 = manager.ui.mainCamera.transform.position - var_20_9.position

				var_20_9.forward = Vector3.New(var_20_16.x, var_20_16.y, var_20_16.z)

				local var_20_17 = var_20_9.localEulerAngles

				var_20_17.z = 0
				var_20_17.x = 0
				var_20_9.localEulerAngles = var_20_17
			end

			local var_20_18 = 0
			local var_20_19 = 1.425

			if var_20_18 < arg_17_1.time_ and arg_17_1.time_ <= var_20_18 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_20 = arg_17_1:GetWordFromCfg(322141004)
				local var_20_21 = arg_17_1:FormatText(var_20_20.content)

				arg_17_1.text_.text = var_20_21

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_22 = 57
				local var_20_23 = utf8.len(var_20_21)
				local var_20_24 = var_20_22 <= 0 and var_20_19 or var_20_19 * (var_20_23 / var_20_22)

				if var_20_24 > 0 and var_20_19 < var_20_24 then
					arg_17_1.talkMaxDuration = var_20_24

					if var_20_24 + var_20_18 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_24 + var_20_18
					end
				end

				arg_17_1.text_.text = var_20_21
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_25 = math.max(var_20_19, arg_17_1.talkMaxDuration)

			if var_20_18 <= arg_17_1.time_ and arg_17_1.time_ < var_20_18 + var_20_25 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_18) / var_20_25

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_18 + var_20_25 and arg_17_1.time_ < var_20_18 + var_20_25 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1044ui_story",
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
	Play322141005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 322141005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play322141006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.1
			local var_24_1 = 1

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				local var_24_2 = "play"
				local var_24_3 = "effect"

				arg_21_1:AudioAction(var_24_2, var_24_3, "se_story_10", "se_story_10_sword", "")
			end

			local var_24_4 = manager.ui.mainCamera.transform
			local var_24_5 = 0.1

			if var_24_5 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.var_.shakeOldPos = var_24_4.localPosition
			end

			local var_24_6 = 0.433333333333333

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_6 then
				local var_24_7 = (arg_21_1.time_ - var_24_5) / 0.066
				local var_24_8, var_24_9 = math.modf(var_24_7)

				var_24_4.localPosition = Vector3.New(var_24_9 * 0.13, var_24_9 * 0.13, var_24_9 * 0.13) + arg_21_1.var_.shakeOldPos
			end

			if arg_21_1.time_ >= var_24_5 + var_24_6 and arg_21_1.time_ < var_24_5 + var_24_6 + arg_24_0 then
				var_24_4.localPosition = arg_21_1.var_.shakeOldPos
			end

			local var_24_10 = 0
			local var_24_11 = 0.675

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_12 = arg_21_1:GetWordFromCfg(322141005)
				local var_24_13 = arg_21_1:FormatText(var_24_12.content)

				arg_21_1.text_.text = var_24_13

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_14 = 27
				local var_24_15 = utf8.len(var_24_13)
				local var_24_16 = var_24_14 <= 0 and var_24_11 or var_24_11 * (var_24_15 / var_24_14)

				if var_24_16 > 0 and var_24_11 < var_24_16 then
					arg_21_1.talkMaxDuration = var_24_16

					if var_24_16 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_13
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_17 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_17 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_10) / var_24_17

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_10 + var_24_17 and arg_21_1.time_ < var_24_10 + var_24_17 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play322141006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 322141006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play322141007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.1
			local var_28_1 = 1

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				local var_28_2 = "play"
				local var_28_3 = "effect"

				arg_25_1:AudioAction(var_28_2, var_28_3, "se_story_122_03", "se_story_122_03_arrow2", "")
			end

			local var_28_4 = manager.ui.mainCamera.transform
			local var_28_5 = 0.1

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				local var_28_6 = arg_25_1.var_.effect1116
				local var_28_7
				local var_28_8 = var_28_4

				if not var_28_6 then
					var_28_6 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit_blue4"), var_28_8)
					var_28_6.name = "1116"
					arg_25_1.var_.effect1116 = var_28_6
				else
					var_28_6.transform:SetParent(var_28_8)
				end

				var_28_6.transform.localPosition = Vector3.New(0, 0, 0)
				var_28_6.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_28_9 = manager.ui.mainCamera.transform
			local var_28_10 = 0.1

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.var_.shakeOldPos = var_28_9.localPosition
			end

			local var_28_11 = 0.533333333333333

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_11 then
				local var_28_12 = (arg_25_1.time_ - var_28_10) / 0.132
				local var_28_13, var_28_14 = math.modf(var_28_12)

				var_28_9.localPosition = Vector3.New(var_28_14 * 0.13, var_28_14 * 0.13, var_28_14 * 0.13) + arg_25_1.var_.shakeOldPos
			end

			if arg_25_1.time_ >= var_28_10 + var_28_11 and arg_25_1.time_ < var_28_10 + var_28_11 + arg_28_0 then
				var_28_9.localPosition = arg_25_1.var_.shakeOldPos
			end

			local var_28_15 = 0
			local var_28_16 = 1.125

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_17 = arg_25_1:GetWordFromCfg(322141006)
				local var_28_18 = arg_25_1:FormatText(var_28_17.content)

				arg_25_1.text_.text = var_28_18

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_19 = 45
				local var_28_20 = utf8.len(var_28_18)
				local var_28_21 = var_28_19 <= 0 and var_28_16 or var_28_16 * (var_28_20 / var_28_19)

				if var_28_21 > 0 and var_28_16 < var_28_21 then
					arg_25_1.talkMaxDuration = var_28_21

					if var_28_21 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_21 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_18
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_22 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_22

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_22 and arg_25_1.time_ < var_28_15 + var_28_22 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play322141007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 322141007
		arg_29_1.duration_ = 3.9

		local var_29_0 = {
			zh = 2.866,
			ja = 3.9
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
				arg_29_0:Play322141008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = manager.ui.mainCamera.transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				local var_32_2 = arg_29_1.var_.effect1116

				if var_32_2 then
					Object.Destroy(var_32_2)

					arg_29_1.var_.effect1116 = nil
				end
			end

			local var_32_3 = 0
			local var_32_4 = 0.375

			if var_32_3 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_5 = arg_29_1:FormatText(StoryNameCfg[1165].name)

				arg_29_1.leftNameTxt_.text = var_32_5

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_6 = arg_29_1:GetWordFromCfg(322141007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_8 = 15
				local var_32_9 = utf8.len(var_32_7)
				local var_32_10 = var_32_8 <= 0 and var_32_4 or var_32_4 * (var_32_9 / var_32_8)

				if var_32_10 > 0 and var_32_4 < var_32_10 then
					arg_29_1.talkMaxDuration = var_32_10

					if var_32_10 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_3
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141007", "story_v_out_322141.awb") ~= 0 then
					local var_32_11 = manager.audio:GetVoiceLength("story_v_out_322141", "322141007", "story_v_out_322141.awb") / 1000

					if var_32_11 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_3
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_322141", "322141007", "story_v_out_322141.awb")

						arg_29_1:RecordAudio("322141007", var_32_12)
						arg_29_1:RecordAudio("322141007", var_32_12)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_322141", "322141007", "story_v_out_322141.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_322141", "322141007", "story_v_out_322141.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_13 = math.max(var_32_4, arg_29_1.talkMaxDuration)

			if var_32_3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_3 + var_32_13 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_3) / var_32_13

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_3 + var_32_13 and arg_29_1.time_ < var_32_3 + var_32_13 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play322141008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 322141008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play322141009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 1.35

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_2 = arg_33_1:GetWordFromCfg(322141008)
				local var_36_3 = arg_33_1:FormatText(var_36_2.content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_4 = 54
				local var_36_5 = utf8.len(var_36_3)
				local var_36_6 = var_36_4 <= 0 and var_36_1 or var_36_1 * (var_36_5 / var_36_4)

				if var_36_6 > 0 and var_36_1 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_7 and arg_33_1.time_ < var_36_0 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play322141009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 322141009
		arg_37_1.duration_ = 4.53

		local var_37_0 = {
			zh = 3.333,
			ja = 4.533
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
				arg_37_0:Play322141010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1043ui_story"].transform
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 then
				arg_37_1.var_.moveOldPos1043ui_story = var_40_0.localPosition
			end

			local var_40_2 = 0.001

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2
				local var_40_4 = Vector3.New(-0.92, -1.01, -5.73)

				var_40_0.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1043ui_story, var_40_4, var_40_3)

				local var_40_5 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_5.x, var_40_5.y, var_40_5.z)

				local var_40_6 = var_40_0.localEulerAngles

				var_40_6.z = 0
				var_40_6.x = 0
				var_40_0.localEulerAngles = var_40_6
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 then
				var_40_0.localPosition = Vector3.New(-0.92, -1.01, -5.73)

				local var_40_7 = manager.ui.mainCamera.transform.position - var_40_0.position

				var_40_0.forward = Vector3.New(var_40_7.x, var_40_7.y, var_40_7.z)

				local var_40_8 = var_40_0.localEulerAngles

				var_40_8.z = 0
				var_40_8.x = 0
				var_40_0.localEulerAngles = var_40_8
			end

			local var_40_9 = arg_37_1.actors_["1043ui_story"]
			local var_40_10 = 0

			if var_40_10 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1043ui_story == nil then
				arg_37_1.var_.characterEffect1043ui_story = var_40_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_11 = 0.200000002980232

			if var_40_10 <= arg_37_1.time_ and arg_37_1.time_ < var_40_10 + var_40_11 and not isNil(var_40_9) then
				local var_40_12 = (arg_37_1.time_ - var_40_10) / var_40_11

				if arg_37_1.var_.characterEffect1043ui_story and not isNil(var_40_9) then
					arg_37_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_10 + var_40_11 and arg_37_1.time_ < var_40_10 + var_40_11 + arg_40_0 and not isNil(var_40_9) and arg_37_1.var_.characterEffect1043ui_story then
				arg_37_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_40_13 = 0

			if var_40_13 < arg_37_1.time_ and arg_37_1.time_ <= var_40_13 + arg_40_0 then
				arg_37_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action4_1")
			end

			local var_40_14 = 0

			if var_40_14 < arg_37_1.time_ and arg_37_1.time_ <= var_40_14 + arg_40_0 then
				arg_37_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_40_15 = 0
			local var_40_16 = 0.425

			if var_40_15 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_17 = arg_37_1:FormatText(StoryNameCfg[1156].name)

				arg_37_1.leftNameTxt_.text = var_40_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_18 = arg_37_1:GetWordFromCfg(322141009)
				local var_40_19 = arg_37_1:FormatText(var_40_18.content)

				arg_37_1.text_.text = var_40_19

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 17
				local var_40_21 = utf8.len(var_40_19)
				local var_40_22 = var_40_20 <= 0 and var_40_16 or var_40_16 * (var_40_21 / var_40_20)

				if var_40_22 > 0 and var_40_16 < var_40_22 then
					arg_37_1.talkMaxDuration = var_40_22

					if var_40_22 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_22 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_19
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141009", "story_v_out_322141.awb") ~= 0 then
					local var_40_23 = manager.audio:GetVoiceLength("story_v_out_322141", "322141009", "story_v_out_322141.awb") / 1000

					if var_40_23 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_23 + var_40_15
					end

					if var_40_18.prefab_name ~= "" and arg_37_1.actors_[var_40_18.prefab_name] ~= nil then
						local var_40_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_18.prefab_name].transform, "story_v_out_322141", "322141009", "story_v_out_322141.awb")

						arg_37_1:RecordAudio("322141009", var_40_24)
						arg_37_1:RecordAudio("322141009", var_40_24)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_322141", "322141009", "story_v_out_322141.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_322141", "322141009", "story_v_out_322141.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_25 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_25 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_25

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_25 and arg_37_1.time_ < var_40_15 + var_40_25 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
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
	Play322141010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 322141010
		arg_41_1.duration_ = 3.73

		local var_41_0 = {
			zh = 3.733,
			ja = 2.7
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play322141011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1044ui_story"].transform
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1.var_.moveOldPos1044ui_story = var_44_0.localPosition
			end

			local var_44_2 = 0.001

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2
				local var_44_4 = Vector3.New(0.7, -1, -5.93)

				var_44_0.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1044ui_story, var_44_4, var_44_3)

				local var_44_5 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_5.x, var_44_5.y, var_44_5.z)

				local var_44_6 = var_44_0.localEulerAngles

				var_44_6.z = 0
				var_44_6.x = 0
				var_44_0.localEulerAngles = var_44_6
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 then
				var_44_0.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_44_7 = manager.ui.mainCamera.transform.position - var_44_0.position

				var_44_0.forward = Vector3.New(var_44_7.x, var_44_7.y, var_44_7.z)

				local var_44_8 = var_44_0.localEulerAngles

				var_44_8.z = 0
				var_44_8.x = 0
				var_44_0.localEulerAngles = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["1044ui_story"]
			local var_44_10 = 0

			if var_44_10 < arg_41_1.time_ and arg_41_1.time_ <= var_44_10 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1044ui_story == nil then
				arg_41_1.var_.characterEffect1044ui_story = var_44_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if var_44_10 <= arg_41_1.time_ and arg_41_1.time_ < var_44_10 + var_44_11 and not isNil(var_44_9) then
				local var_44_12 = (arg_41_1.time_ - var_44_10) / var_44_11

				if arg_41_1.var_.characterEffect1044ui_story and not isNil(var_44_9) then
					arg_41_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_10 + var_44_11 and arg_41_1.time_ < var_44_10 + var_44_11 + arg_44_0 and not isNil(var_44_9) and arg_41_1.var_.characterEffect1044ui_story then
				arg_41_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_44_13 = arg_41_1.actors_["1043ui_story"]
			local var_44_14 = 0

			if var_44_14 < arg_41_1.time_ and arg_41_1.time_ <= var_44_14 + arg_44_0 and not isNil(var_44_13) and arg_41_1.var_.characterEffect1043ui_story == nil then
				arg_41_1.var_.characterEffect1043ui_story = var_44_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_15 = 0.200000002980232

			if var_44_14 <= arg_41_1.time_ and arg_41_1.time_ < var_44_14 + var_44_15 and not isNil(var_44_13) then
				local var_44_16 = (arg_41_1.time_ - var_44_14) / var_44_15

				if arg_41_1.var_.characterEffect1043ui_story and not isNil(var_44_13) then
					local var_44_17 = Mathf.Lerp(0, 0.5, var_44_16)

					arg_41_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1043ui_story.fillRatio = var_44_17
				end
			end

			if arg_41_1.time_ >= var_44_14 + var_44_15 and arg_41_1.time_ < var_44_14 + var_44_15 + arg_44_0 and not isNil(var_44_13) and arg_41_1.var_.characterEffect1043ui_story then
				local var_44_18 = 0.5

				arg_41_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1043ui_story.fillRatio = var_44_18
			end

			local var_44_19 = 0

			if var_44_19 < arg_41_1.time_ and arg_41_1.time_ <= var_44_19 + arg_44_0 then
				arg_41_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action6_1")
			end

			local var_44_20 = 0
			local var_44_21 = 0.4

			if var_44_20 < arg_41_1.time_ and arg_41_1.time_ <= var_44_20 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_22 = arg_41_1:FormatText(StoryNameCfg[67].name)

				arg_41_1.leftNameTxt_.text = var_44_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_23 = arg_41_1:GetWordFromCfg(322141010)
				local var_44_24 = arg_41_1:FormatText(var_44_23.content)

				arg_41_1.text_.text = var_44_24

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_25 = 16
				local var_44_26 = utf8.len(var_44_24)
				local var_44_27 = var_44_25 <= 0 and var_44_21 or var_44_21 * (var_44_26 / var_44_25)

				if var_44_27 > 0 and var_44_21 < var_44_27 then
					arg_41_1.talkMaxDuration = var_44_27

					if var_44_27 + var_44_20 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_27 + var_44_20
					end
				end

				arg_41_1.text_.text = var_44_24
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141010", "story_v_out_322141.awb") ~= 0 then
					local var_44_28 = manager.audio:GetVoiceLength("story_v_out_322141", "322141010", "story_v_out_322141.awb") / 1000

					if var_44_28 + var_44_20 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_28 + var_44_20
					end

					if var_44_23.prefab_name ~= "" and arg_41_1.actors_[var_44_23.prefab_name] ~= nil then
						local var_44_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_23.prefab_name].transform, "story_v_out_322141", "322141010", "story_v_out_322141.awb")

						arg_41_1:RecordAudio("322141010", var_44_29)
						arg_41_1:RecordAudio("322141010", var_44_29)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_322141", "322141010", "story_v_out_322141.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_322141", "322141010", "story_v_out_322141.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_30 = math.max(var_44_21, arg_41_1.talkMaxDuration)

			if var_44_20 <= arg_41_1.time_ and arg_41_1.time_ < var_44_20 + var_44_30 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_20) / var_44_30

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_20 + var_44_30 and arg_41_1.time_ < var_44_20 + var_44_30 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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
	Play322141011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 322141011
		arg_45_1.duration_ = 2.53

		local var_45_0 = {
			zh = 2.533,
			ja = 2.133
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play322141012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044actionlink/1044action463")
			end

			local var_48_2 = 0
			local var_48_3 = 0.275

			if var_48_2 < arg_45_1.time_ and arg_45_1.time_ <= var_48_2 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_4 = arg_45_1:FormatText(StoryNameCfg[67].name)

				arg_45_1.leftNameTxt_.text = var_48_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_5 = arg_45_1:GetWordFromCfg(322141011)
				local var_48_6 = arg_45_1:FormatText(var_48_5.content)

				arg_45_1.text_.text = var_48_6

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_7 = 11
				local var_48_8 = utf8.len(var_48_6)
				local var_48_9 = var_48_7 <= 0 and var_48_3 or var_48_3 * (var_48_8 / var_48_7)

				if var_48_9 > 0 and var_48_3 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_2
					end
				end

				arg_45_1.text_.text = var_48_6
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141011", "story_v_out_322141.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_322141", "322141011", "story_v_out_322141.awb") / 1000

					if var_48_10 + var_48_2 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_2
					end

					if var_48_5.prefab_name ~= "" and arg_45_1.actors_[var_48_5.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_5.prefab_name].transform, "story_v_out_322141", "322141011", "story_v_out_322141.awb")

						arg_45_1:RecordAudio("322141011", var_48_11)
						arg_45_1:RecordAudio("322141011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_322141", "322141011", "story_v_out_322141.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_322141", "322141011", "story_v_out_322141.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_3, arg_45_1.talkMaxDuration)

			if var_48_2 <= arg_45_1.time_ and arg_45_1.time_ < var_48_2 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_2) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_2 + var_48_12 and arg_45_1.time_ < var_48_2 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play322141012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 322141012
		arg_49_1.duration_ = 6.83

		local var_49_0 = {
			zh = 6.833,
			ja = 5.533
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play322141013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = "10131ui_story"

			if arg_49_1.actors_[var_52_0] == nil then
				local var_52_1 = Asset.Load("Char/" .. "10131ui_story")

				if not isNil(var_52_1) then
					local var_52_2 = Object.Instantiate(Asset.Load("Char/" .. "10131ui_story"), arg_49_1.stage_.transform)

					var_52_2.name = var_52_0
					var_52_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_49_1.actors_[var_52_0] = var_52_2

					local var_52_3 = var_52_2:GetComponentInChildren(typeof(CharacterEffect))

					var_52_3.enabled = true

					local var_52_4 = GameObjectTools.GetOrAddComponent(var_52_2, typeof(DynamicBoneHelper))

					if var_52_4 then
						var_52_4:EnableDynamicBone(false)
					end

					arg_49_1:ShowWeapon(var_52_3.transform, false)

					arg_49_1.var_[var_52_0 .. "Animator"] = var_52_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_49_1.var_[var_52_0 .. "Animator"].applyRootMotion = true
					arg_49_1.var_[var_52_0 .. "LipSync"] = var_52_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_52_5 = arg_49_1.actors_["10131ui_story"].transform
			local var_52_6 = 0

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.var_.moveOldPos10131ui_story = var_52_5.localPosition
			end

			local var_52_7 = 0.001

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_7 then
				local var_52_8 = (arg_49_1.time_ - var_52_6) / var_52_7
				local var_52_9 = Vector3.New(-0.78, -0.96, -5.8)

				var_52_5.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10131ui_story, var_52_9, var_52_8)

				local var_52_10 = manager.ui.mainCamera.transform.position - var_52_5.position

				var_52_5.forward = Vector3.New(var_52_10.x, var_52_10.y, var_52_10.z)

				local var_52_11 = var_52_5.localEulerAngles

				var_52_11.z = 0
				var_52_11.x = 0
				var_52_5.localEulerAngles = var_52_11
			end

			if arg_49_1.time_ >= var_52_6 + var_52_7 and arg_49_1.time_ < var_52_6 + var_52_7 + arg_52_0 then
				var_52_5.localPosition = Vector3.New(-0.78, -0.96, -5.8)

				local var_52_12 = manager.ui.mainCamera.transform.position - var_52_5.position

				var_52_5.forward = Vector3.New(var_52_12.x, var_52_12.y, var_52_12.z)

				local var_52_13 = var_52_5.localEulerAngles

				var_52_13.z = 0
				var_52_13.x = 0
				var_52_5.localEulerAngles = var_52_13
			end

			local var_52_14 = arg_49_1.actors_["1043ui_story"].transform
			local var_52_15 = 0

			if var_52_15 < arg_49_1.time_ and arg_49_1.time_ <= var_52_15 + arg_52_0 then
				arg_49_1.var_.moveOldPos1043ui_story = var_52_14.localPosition
			end

			local var_52_16 = 0.001

			if var_52_15 <= arg_49_1.time_ and arg_49_1.time_ < var_52_15 + var_52_16 then
				local var_52_17 = (arg_49_1.time_ - var_52_15) / var_52_16
				local var_52_18 = Vector3.New(0, 100, 0)

				var_52_14.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1043ui_story, var_52_18, var_52_17)

				local var_52_19 = manager.ui.mainCamera.transform.position - var_52_14.position

				var_52_14.forward = Vector3.New(var_52_19.x, var_52_19.y, var_52_19.z)

				local var_52_20 = var_52_14.localEulerAngles

				var_52_20.z = 0
				var_52_20.x = 0
				var_52_14.localEulerAngles = var_52_20
			end

			if arg_49_1.time_ >= var_52_15 + var_52_16 and arg_49_1.time_ < var_52_15 + var_52_16 + arg_52_0 then
				var_52_14.localPosition = Vector3.New(0, 100, 0)

				local var_52_21 = manager.ui.mainCamera.transform.position - var_52_14.position

				var_52_14.forward = Vector3.New(var_52_21.x, var_52_21.y, var_52_21.z)

				local var_52_22 = var_52_14.localEulerAngles

				var_52_22.z = 0
				var_52_22.x = 0
				var_52_14.localEulerAngles = var_52_22
			end

			local var_52_23 = arg_49_1.actors_["10131ui_story"]
			local var_52_24 = 0

			if var_52_24 < arg_49_1.time_ and arg_49_1.time_ <= var_52_24 + arg_52_0 and not isNil(var_52_23) and arg_49_1.var_.characterEffect10131ui_story == nil then
				arg_49_1.var_.characterEffect10131ui_story = var_52_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_25 = 0.200000002980232

			if var_52_24 <= arg_49_1.time_ and arg_49_1.time_ < var_52_24 + var_52_25 and not isNil(var_52_23) then
				local var_52_26 = (arg_49_1.time_ - var_52_24) / var_52_25

				if arg_49_1.var_.characterEffect10131ui_story and not isNil(var_52_23) then
					arg_49_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_24 + var_52_25 and arg_49_1.time_ < var_52_24 + var_52_25 + arg_52_0 and not isNil(var_52_23) and arg_49_1.var_.characterEffect10131ui_story then
				arg_49_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_52_27 = arg_49_1.actors_["1044ui_story"]
			local var_52_28 = 0

			if var_52_28 < arg_49_1.time_ and arg_49_1.time_ <= var_52_28 + arg_52_0 and not isNil(var_52_27) and arg_49_1.var_.characterEffect1044ui_story == nil then
				arg_49_1.var_.characterEffect1044ui_story = var_52_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_29 = 0.200000002980232

			if var_52_28 <= arg_49_1.time_ and arg_49_1.time_ < var_52_28 + var_52_29 and not isNil(var_52_27) then
				local var_52_30 = (arg_49_1.time_ - var_52_28) / var_52_29

				if arg_49_1.var_.characterEffect1044ui_story and not isNil(var_52_27) then
					local var_52_31 = Mathf.Lerp(0, 0.5, var_52_30)

					arg_49_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1044ui_story.fillRatio = var_52_31
				end
			end

			if arg_49_1.time_ >= var_52_28 + var_52_29 and arg_49_1.time_ < var_52_28 + var_52_29 + arg_52_0 and not isNil(var_52_27) and arg_49_1.var_.characterEffect1044ui_story then
				local var_52_32 = 0.5

				arg_49_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1044ui_story.fillRatio = var_52_32
			end

			local var_52_33 = 0

			if var_52_33 < arg_49_1.time_ and arg_49_1.time_ <= var_52_33 + arg_52_0 then
				arg_49_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_1")
			end

			local var_52_34 = 0

			if var_52_34 < arg_49_1.time_ and arg_49_1.time_ <= var_52_34 + arg_52_0 then
				arg_49_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_52_35 = 0
			local var_52_36 = 0.7

			if var_52_35 < arg_49_1.time_ and arg_49_1.time_ <= var_52_35 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_37 = arg_49_1:FormatText(StoryNameCfg[1366].name)

				arg_49_1.leftNameTxt_.text = var_52_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_38 = arg_49_1:GetWordFromCfg(322141012)
				local var_52_39 = arg_49_1:FormatText(var_52_38.content)

				arg_49_1.text_.text = var_52_39

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_40 = 28
				local var_52_41 = utf8.len(var_52_39)
				local var_52_42 = var_52_40 <= 0 and var_52_36 or var_52_36 * (var_52_41 / var_52_40)

				if var_52_42 > 0 and var_52_36 < var_52_42 then
					arg_49_1.talkMaxDuration = var_52_42

					if var_52_42 + var_52_35 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_42 + var_52_35
					end
				end

				arg_49_1.text_.text = var_52_39
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141012", "story_v_out_322141.awb") ~= 0 then
					local var_52_43 = manager.audio:GetVoiceLength("story_v_out_322141", "322141012", "story_v_out_322141.awb") / 1000

					if var_52_43 + var_52_35 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_43 + var_52_35
					end

					if var_52_38.prefab_name ~= "" and arg_49_1.actors_[var_52_38.prefab_name] ~= nil then
						local var_52_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_38.prefab_name].transform, "story_v_out_322141", "322141012", "story_v_out_322141.awb")

						arg_49_1:RecordAudio("322141012", var_52_44)
						arg_49_1:RecordAudio("322141012", var_52_44)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_322141", "322141012", "story_v_out_322141.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_322141", "322141012", "story_v_out_322141.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_45 = math.max(var_52_36, arg_49_1.talkMaxDuration)

			if var_52_35 <= arg_49_1.time_ and arg_49_1.time_ < var_52_35 + var_52_45 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_35) / var_52_45

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_35 + var_52_45 and arg_49_1.time_ < var_52_35 + var_52_45 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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
				actorName = "1043ui_story",
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
	Play322141013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 322141013
		arg_53_1.duration_ = 4.6

		local var_53_0 = {
			zh = 3.9,
			ja = 4.6
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play322141014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1044ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1044ui_story == nil then
				arg_53_1.var_.characterEffect1044ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1044ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1044ui_story then
				arg_53_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_56_4 = arg_53_1.actors_["10131ui_story"]
			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect10131ui_story == nil then
				arg_53_1.var_.characterEffect10131ui_story = var_56_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_6 = 0.200000002980232

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_6 and not isNil(var_56_4) then
				local var_56_7 = (arg_53_1.time_ - var_56_5) / var_56_6

				if arg_53_1.var_.characterEffect10131ui_story and not isNil(var_56_4) then
					local var_56_8 = Mathf.Lerp(0, 0.5, var_56_7)

					arg_53_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10131ui_story.fillRatio = var_56_8
				end
			end

			if arg_53_1.time_ >= var_56_5 + var_56_6 and arg_53_1.time_ < var_56_5 + var_56_6 + arg_56_0 and not isNil(var_56_4) and arg_53_1.var_.characterEffect10131ui_story then
				local var_56_9 = 0.5

				arg_53_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10131ui_story.fillRatio = var_56_9
			end

			local var_56_10 = 0

			if var_56_10 < arg_53_1.time_ and arg_53_1.time_ <= var_56_10 + arg_56_0 then
				arg_53_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action3_2")
			end

			local var_56_11 = 0
			local var_56_12 = 0.35

			if var_56_11 < arg_53_1.time_ and arg_53_1.time_ <= var_56_11 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_13 = arg_53_1:FormatText(StoryNameCfg[67].name)

				arg_53_1.leftNameTxt_.text = var_56_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_14 = arg_53_1:GetWordFromCfg(322141013)
				local var_56_15 = arg_53_1:FormatText(var_56_14.content)

				arg_53_1.text_.text = var_56_15

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_16 = 14
				local var_56_17 = utf8.len(var_56_15)
				local var_56_18 = var_56_16 <= 0 and var_56_12 or var_56_12 * (var_56_17 / var_56_16)

				if var_56_18 > 0 and var_56_12 < var_56_18 then
					arg_53_1.talkMaxDuration = var_56_18

					if var_56_18 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_18 + var_56_11
					end
				end

				arg_53_1.text_.text = var_56_15
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141013", "story_v_out_322141.awb") ~= 0 then
					local var_56_19 = manager.audio:GetVoiceLength("story_v_out_322141", "322141013", "story_v_out_322141.awb") / 1000

					if var_56_19 + var_56_11 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_19 + var_56_11
					end

					if var_56_14.prefab_name ~= "" and arg_53_1.actors_[var_56_14.prefab_name] ~= nil then
						local var_56_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_14.prefab_name].transform, "story_v_out_322141", "322141013", "story_v_out_322141.awb")

						arg_53_1:RecordAudio("322141013", var_56_20)
						arg_53_1:RecordAudio("322141013", var_56_20)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_322141", "322141013", "story_v_out_322141.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_322141", "322141013", "story_v_out_322141.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_21 = math.max(var_56_12, arg_53_1.talkMaxDuration)

			if var_56_11 <= arg_53_1.time_ and arg_53_1.time_ < var_56_11 + var_56_21 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_11) / var_56_21

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_11 + var_56_21 and arg_53_1.time_ < var_56_11 + var_56_21 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play322141014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 322141014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play322141015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1044ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1044ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0, 100, 0)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1044ui_story, var_60_4, var_60_3)

				local var_60_5 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_5.x, var_60_5.y, var_60_5.z)

				local var_60_6 = var_60_0.localEulerAngles

				var_60_6.z = 0
				var_60_6.x = 0
				var_60_0.localEulerAngles = var_60_6
			end

			if arg_57_1.time_ >= var_60_1 + var_60_2 and arg_57_1.time_ < var_60_1 + var_60_2 + arg_60_0 then
				var_60_0.localPosition = Vector3.New(0, 100, 0)

				local var_60_7 = manager.ui.mainCamera.transform.position - var_60_0.position

				var_60_0.forward = Vector3.New(var_60_7.x, var_60_7.y, var_60_7.z)

				local var_60_8 = var_60_0.localEulerAngles

				var_60_8.z = 0
				var_60_8.x = 0
				var_60_0.localEulerAngles = var_60_8
			end

			local var_60_9 = arg_57_1.actors_["10131ui_story"].transform
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 then
				arg_57_1.var_.moveOldPos10131ui_story = var_60_9.localPosition
			end

			local var_60_11 = 0.001

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11
				local var_60_13 = Vector3.New(0, 100, 0)

				var_60_9.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10131ui_story, var_60_13, var_60_12)

				local var_60_14 = manager.ui.mainCamera.transform.position - var_60_9.position

				var_60_9.forward = Vector3.New(var_60_14.x, var_60_14.y, var_60_14.z)

				local var_60_15 = var_60_9.localEulerAngles

				var_60_15.z = 0
				var_60_15.x = 0
				var_60_9.localEulerAngles = var_60_15
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 then
				var_60_9.localPosition = Vector3.New(0, 100, 0)

				local var_60_16 = manager.ui.mainCamera.transform.position - var_60_9.position

				var_60_9.forward = Vector3.New(var_60_16.x, var_60_16.y, var_60_16.z)

				local var_60_17 = var_60_9.localEulerAngles

				var_60_17.z = 0
				var_60_17.x = 0
				var_60_9.localEulerAngles = var_60_17
			end

			local var_60_18 = 0
			local var_60_19 = 1.75

			if var_60_18 < arg_57_1.time_ and arg_57_1.time_ <= var_60_18 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_20 = arg_57_1:GetWordFromCfg(322141014)
				local var_60_21 = arg_57_1:FormatText(var_60_20.content)

				arg_57_1.text_.text = var_60_21

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_22 = 70
				local var_60_23 = utf8.len(var_60_21)
				local var_60_24 = var_60_22 <= 0 and var_60_19 or var_60_19 * (var_60_23 / var_60_22)

				if var_60_24 > 0 and var_60_19 < var_60_24 then
					arg_57_1.talkMaxDuration = var_60_24

					if var_60_24 + var_60_18 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_24 + var_60_18
					end
				end

				arg_57_1.text_.text = var_60_21
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_25 = math.max(var_60_19, arg_57_1.talkMaxDuration)

			if var_60_18 <= arg_57_1.time_ and arg_57_1.time_ < var_60_18 + var_60_25 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_18) / var_60_25

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_18 + var_60_25 and arg_57_1.time_ < var_60_18 + var_60_25 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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

		arg_57_1:InitPlayNodeList()
	end,
	Play322141015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 322141015
		arg_61_1.duration_ = 4.07

		local var_61_0 = {
			zh = 1.633,
			ja = 4.066
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play322141016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["10131ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos10131ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(-0.78, -0.96, -5.8)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10131ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(-0.78, -0.96, -5.8)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["10131ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect10131ui_story == nil then
				arg_61_1.var_.characterEffect10131ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect10131ui_story and not isNil(var_64_9) then
					arg_61_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect10131ui_story then
				arg_61_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_64_13 = 0
			local var_64_14 = 0.25

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_15 = arg_61_1:FormatText(StoryNameCfg[1366].name)

				arg_61_1.leftNameTxt_.text = var_64_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_16 = arg_61_1:GetWordFromCfg(322141015)
				local var_64_17 = arg_61_1:FormatText(var_64_16.content)

				arg_61_1.text_.text = var_64_17

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_18 = 10
				local var_64_19 = utf8.len(var_64_17)
				local var_64_20 = var_64_18 <= 0 and var_64_14 or var_64_14 * (var_64_19 / var_64_18)

				if var_64_20 > 0 and var_64_14 < var_64_20 then
					arg_61_1.talkMaxDuration = var_64_20

					if var_64_20 + var_64_13 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_20 + var_64_13
					end
				end

				arg_61_1.text_.text = var_64_17
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141015", "story_v_out_322141.awb") ~= 0 then
					local var_64_21 = manager.audio:GetVoiceLength("story_v_out_322141", "322141015", "story_v_out_322141.awb") / 1000

					if var_64_21 + var_64_13 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_21 + var_64_13
					end

					if var_64_16.prefab_name ~= "" and arg_61_1.actors_[var_64_16.prefab_name] ~= nil then
						local var_64_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_16.prefab_name].transform, "story_v_out_322141", "322141015", "story_v_out_322141.awb")

						arg_61_1:RecordAudio("322141015", var_64_22)
						arg_61_1:RecordAudio("322141015", var_64_22)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_322141", "322141015", "story_v_out_322141.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_322141", "322141015", "story_v_out_322141.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_23 = math.max(var_64_14, arg_61_1.talkMaxDuration)

			if var_64_13 <= arg_61_1.time_ and arg_61_1.time_ < var_64_13 + var_64_23 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_13) / var_64_23

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_13 + var_64_23 and arg_61_1.time_ < var_64_13 + var_64_23 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play322141016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 322141016
		arg_65_1.duration_ = 5.9

		local var_65_0 = {
			zh = 5.9,
			ja = 5.8
		}
		local var_65_1 = manager.audio:GetLocalizationFlag()

		if var_65_0[var_65_1] ~= nil then
			arg_65_1.duration_ = var_65_0[var_65_1]
		end

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play322141017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1044ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1044ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(0.7, -1, -5.93)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1044ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["1044ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1044ui_story == nil then
				arg_65_1.var_.characterEffect1044ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect1044ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1044ui_story then
				arg_65_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_68_13 = arg_65_1.actors_["10131ui_story"]
			local var_68_14 = 0

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 and not isNil(var_68_13) and arg_65_1.var_.characterEffect10131ui_story == nil then
				arg_65_1.var_.characterEffect10131ui_story = var_68_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_15 = 0.200000002980232

			if var_68_14 <= arg_65_1.time_ and arg_65_1.time_ < var_68_14 + var_68_15 and not isNil(var_68_13) then
				local var_68_16 = (arg_65_1.time_ - var_68_14) / var_68_15

				if arg_65_1.var_.characterEffect10131ui_story and not isNil(var_68_13) then
					local var_68_17 = Mathf.Lerp(0, 0.5, var_68_16)

					arg_65_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10131ui_story.fillRatio = var_68_17
				end
			end

			if arg_65_1.time_ >= var_68_14 + var_68_15 and arg_65_1.time_ < var_68_14 + var_68_15 + arg_68_0 and not isNil(var_68_13) and arg_65_1.var_.characterEffect10131ui_story then
				local var_68_18 = 0.5

				arg_65_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10131ui_story.fillRatio = var_68_18
			end

			local var_68_19 = 0

			if var_68_19 < arg_65_1.time_ and arg_65_1.time_ <= var_68_19 + arg_68_0 then
				arg_65_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_68_20 = 0

			if var_68_20 < arg_65_1.time_ and arg_65_1.time_ <= var_68_20 + arg_68_0 then
				arg_65_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action8_1")
			end

			local var_68_21 = 0
			local var_68_22 = 0.65

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_23 = arg_65_1:FormatText(StoryNameCfg[67].name)

				arg_65_1.leftNameTxt_.text = var_68_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_24 = arg_65_1:GetWordFromCfg(322141016)
				local var_68_25 = arg_65_1:FormatText(var_68_24.content)

				arg_65_1.text_.text = var_68_25

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_26 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141016", "story_v_out_322141.awb") ~= 0 then
					local var_68_29 = manager.audio:GetVoiceLength("story_v_out_322141", "322141016", "story_v_out_322141.awb") / 1000

					if var_68_29 + var_68_21 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_29 + var_68_21
					end

					if var_68_24.prefab_name ~= "" and arg_65_1.actors_[var_68_24.prefab_name] ~= nil then
						local var_68_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_24.prefab_name].transform, "story_v_out_322141", "322141016", "story_v_out_322141.awb")

						arg_65_1:RecordAudio("322141016", var_68_30)
						arg_65_1:RecordAudio("322141016", var_68_30)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_322141", "322141016", "story_v_out_322141.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_322141", "322141016", "story_v_out_322141.awb")
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
				actorName = "1044ui_story",
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
	Play322141017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 322141017
		arg_69_1.duration_ = 2

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play322141018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10131ui_story"].transform
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10131ui_story = var_72_0.localPosition
			end

			local var_72_2 = 0.001

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2
				local var_72_4 = Vector3.New(-0.78, -0.96, -5.8)

				var_72_0.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10131ui_story, var_72_4, var_72_3)

				local var_72_5 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_5.x, var_72_5.y, var_72_5.z)

				local var_72_6 = var_72_0.localEulerAngles

				var_72_6.z = 0
				var_72_6.x = 0
				var_72_0.localEulerAngles = var_72_6
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 then
				var_72_0.localPosition = Vector3.New(-0.78, -0.96, -5.8)

				local var_72_7 = manager.ui.mainCamera.transform.position - var_72_0.position

				var_72_0.forward = Vector3.New(var_72_7.x, var_72_7.y, var_72_7.z)

				local var_72_8 = var_72_0.localEulerAngles

				var_72_8.z = 0
				var_72_8.x = 0
				var_72_0.localEulerAngles = var_72_8
			end

			local var_72_9 = arg_69_1.actors_["10131ui_story"]
			local var_72_10 = 0

			if var_72_10 < arg_69_1.time_ and arg_69_1.time_ <= var_72_10 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect10131ui_story == nil then
				arg_69_1.var_.characterEffect10131ui_story = var_72_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_11 = 0.200000002980232

			if var_72_10 <= arg_69_1.time_ and arg_69_1.time_ < var_72_10 + var_72_11 and not isNil(var_72_9) then
				local var_72_12 = (arg_69_1.time_ - var_72_10) / var_72_11

				if arg_69_1.var_.characterEffect10131ui_story and not isNil(var_72_9) then
					arg_69_1.var_.characterEffect10131ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_10 + var_72_11 and arg_69_1.time_ < var_72_10 + var_72_11 + arg_72_0 and not isNil(var_72_9) and arg_69_1.var_.characterEffect10131ui_story then
				arg_69_1.var_.characterEffect10131ui_story.fillFlat = false
			end

			local var_72_13 = arg_69_1.actors_["1044ui_story"]
			local var_72_14 = 0

			if var_72_14 < arg_69_1.time_ and arg_69_1.time_ <= var_72_14 + arg_72_0 and not isNil(var_72_13) and arg_69_1.var_.characterEffect1044ui_story == nil then
				arg_69_1.var_.characterEffect1044ui_story = var_72_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_15 = 0.200000002980232

			if var_72_14 <= arg_69_1.time_ and arg_69_1.time_ < var_72_14 + var_72_15 and not isNil(var_72_13) then
				local var_72_16 = (arg_69_1.time_ - var_72_14) / var_72_15

				if arg_69_1.var_.characterEffect1044ui_story and not isNil(var_72_13) then
					local var_72_17 = Mathf.Lerp(0, 0.5, var_72_16)

					arg_69_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1044ui_story.fillRatio = var_72_17
				end
			end

			if arg_69_1.time_ >= var_72_14 + var_72_15 and arg_69_1.time_ < var_72_14 + var_72_15 + arg_72_0 and not isNil(var_72_13) and arg_69_1.var_.characterEffect1044ui_story then
				local var_72_18 = 0.5

				arg_69_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1044ui_story.fillRatio = var_72_18
			end

			local var_72_19 = 0

			if var_72_19 < arg_69_1.time_ and arg_69_1.time_ <= var_72_19 + arg_72_0 then
				arg_69_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/story10131/story10131action/10131action6_2")
			end

			local var_72_20 = 0

			if var_72_20 < arg_69_1.time_ and arg_69_1.time_ <= var_72_20 + arg_72_0 then
				arg_69_1:PlayTimeline("10131ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_72_21 = 0
			local var_72_22 = 0.125

			if var_72_21 < arg_69_1.time_ and arg_69_1.time_ <= var_72_21 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_23 = arg_69_1:FormatText(StoryNameCfg[1366].name)

				arg_69_1.leftNameTxt_.text = var_72_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_24 = arg_69_1:GetWordFromCfg(322141017)
				local var_72_25 = arg_69_1:FormatText(var_72_24.content)

				arg_69_1.text_.text = var_72_25

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_26 = 5
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

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141017", "story_v_out_322141.awb") ~= 0 then
					local var_72_29 = manager.audio:GetVoiceLength("story_v_out_322141", "322141017", "story_v_out_322141.awb") / 1000

					if var_72_29 + var_72_21 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_29 + var_72_21
					end

					if var_72_24.prefab_name ~= "" and arg_69_1.actors_[var_72_24.prefab_name] ~= nil then
						local var_72_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_24.prefab_name].transform, "story_v_out_322141", "322141017", "story_v_out_322141.awb")

						arg_69_1:RecordAudio("322141017", var_72_30)
						arg_69_1:RecordAudio("322141017", var_72_30)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_322141", "322141017", "story_v_out_322141.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_322141", "322141017", "story_v_out_322141.awb")
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
				actorName = "10131ui_story",
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
	Play322141018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 322141018
		arg_73_1.duration_ = 4.73

		local var_73_0 = {
			zh = 3.8,
			ja = 4.733
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play322141019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1044ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1044ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(0.7, -1, -5.93)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1044ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(0.7, -1, -5.93)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["1044ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1044ui_story == nil then
				arg_73_1.var_.characterEffect1044ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect1044ui_story and not isNil(var_76_9) then
					arg_73_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1044ui_story then
				arg_73_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_76_13 = arg_73_1.actors_["10131ui_story"]
			local var_76_14 = 0

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 and not isNil(var_76_13) and arg_73_1.var_.characterEffect10131ui_story == nil then
				arg_73_1.var_.characterEffect10131ui_story = var_76_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_15 = 0.200000002980232

			if var_76_14 <= arg_73_1.time_ and arg_73_1.time_ < var_76_14 + var_76_15 and not isNil(var_76_13) then
				local var_76_16 = (arg_73_1.time_ - var_76_14) / var_76_15

				if arg_73_1.var_.characterEffect10131ui_story and not isNil(var_76_13) then
					local var_76_17 = Mathf.Lerp(0, 0.5, var_76_16)

					arg_73_1.var_.characterEffect10131ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10131ui_story.fillRatio = var_76_17
				end
			end

			if arg_73_1.time_ >= var_76_14 + var_76_15 and arg_73_1.time_ < var_76_14 + var_76_15 + arg_76_0 and not isNil(var_76_13) and arg_73_1.var_.characterEffect10131ui_story then
				local var_76_18 = 0.5

				arg_73_1.var_.characterEffect10131ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10131ui_story.fillRatio = var_76_18
			end

			local var_76_19 = "1111ui_story"

			if arg_73_1.actors_[var_76_19] == nil then
				local var_76_20 = Asset.Load("Char/" .. "1111ui_story")

				if not isNil(var_76_20) then
					local var_76_21 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_73_1.stage_.transform)

					var_76_21.name = var_76_19
					var_76_21.transform.localPosition = Vector3.New(0, 100, 0)
					arg_73_1.actors_[var_76_19] = var_76_21

					local var_76_22 = var_76_21:GetComponentInChildren(typeof(CharacterEffect))

					var_76_22.enabled = true

					local var_76_23 = GameObjectTools.GetOrAddComponent(var_76_21, typeof(DynamicBoneHelper))

					if var_76_23 then
						var_76_23:EnableDynamicBone(false)
					end

					arg_73_1:ShowWeapon(var_76_22.transform, false)

					arg_73_1.var_[var_76_19 .. "Animator"] = var_76_22.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_73_1.var_[var_76_19 .. "Animator"].applyRootMotion = true
					arg_73_1.var_[var_76_19 .. "LipSync"] = var_76_22.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_76_24 = 0

			if var_76_24 < arg_73_1.time_ and arg_73_1.time_ <= var_76_24 + arg_76_0 then
				arg_73_1:PlayTimeline("1111ui_story", "StoryTimeline/CharAction/story1111/story1111action/1111action5_2")
			end

			local var_76_25 = 0
			local var_76_26 = 0.3

			if var_76_25 < arg_73_1.time_ and arg_73_1.time_ <= var_76_25 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_27 = arg_73_1:FormatText(StoryNameCfg[67].name)

				arg_73_1.leftNameTxt_.text = var_76_27

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_28 = arg_73_1:GetWordFromCfg(322141018)
				local var_76_29 = arg_73_1:FormatText(var_76_28.content)

				arg_73_1.text_.text = var_76_29

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_30 = 12
				local var_76_31 = utf8.len(var_76_29)
				local var_76_32 = var_76_30 <= 0 and var_76_26 or var_76_26 * (var_76_31 / var_76_30)

				if var_76_32 > 0 and var_76_26 < var_76_32 then
					arg_73_1.talkMaxDuration = var_76_32

					if var_76_32 + var_76_25 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_32 + var_76_25
					end
				end

				arg_73_1.text_.text = var_76_29
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141018", "story_v_out_322141.awb") ~= 0 then
					local var_76_33 = manager.audio:GetVoiceLength("story_v_out_322141", "322141018", "story_v_out_322141.awb") / 1000

					if var_76_33 + var_76_25 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_33 + var_76_25
					end

					if var_76_28.prefab_name ~= "" and arg_73_1.actors_[var_76_28.prefab_name] ~= nil then
						local var_76_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_28.prefab_name].transform, "story_v_out_322141", "322141018", "story_v_out_322141.awb")

						arg_73_1:RecordAudio("322141018", var_76_34)
						arg_73_1:RecordAudio("322141018", var_76_34)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_322141", "322141018", "story_v_out_322141.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_322141", "322141018", "story_v_out_322141.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_35 = math.max(var_76_26, arg_73_1.talkMaxDuration)

			if var_76_25 <= arg_73_1.time_ and arg_73_1.time_ < var_76_25 + var_76_35 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_25) / var_76_35

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_25 + var_76_35 and arg_73_1.time_ < var_76_25 + var_76_35 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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
	Play322141019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 322141019
		arg_77_1.duration_ = 5.43

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play322141020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1044ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1044ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, 100, 0)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1044ui_story, var_80_4, var_80_3)

				local var_80_5 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_5.x, var_80_5.y, var_80_5.z)

				local var_80_6 = var_80_0.localEulerAngles

				var_80_6.z = 0
				var_80_6.x = 0
				var_80_0.localEulerAngles = var_80_6
			end

			if arg_77_1.time_ >= var_80_1 + var_80_2 and arg_77_1.time_ < var_80_1 + var_80_2 + arg_80_0 then
				var_80_0.localPosition = Vector3.New(0, 100, 0)

				local var_80_7 = manager.ui.mainCamera.transform.position - var_80_0.position

				var_80_0.forward = Vector3.New(var_80_7.x, var_80_7.y, var_80_7.z)

				local var_80_8 = var_80_0.localEulerAngles

				var_80_8.z = 0
				var_80_8.x = 0
				var_80_0.localEulerAngles = var_80_8
			end

			local var_80_9 = arg_77_1.actors_["10131ui_story"].transform
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.var_.moveOldPos10131ui_story = var_80_9.localPosition
			end

			local var_80_11 = 0.001

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_11 then
				local var_80_12 = (arg_77_1.time_ - var_80_10) / var_80_11
				local var_80_13 = Vector3.New(0, 100, 0)

				var_80_9.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10131ui_story, var_80_13, var_80_12)

				local var_80_14 = manager.ui.mainCamera.transform.position - var_80_9.position

				var_80_9.forward = Vector3.New(var_80_14.x, var_80_14.y, var_80_14.z)

				local var_80_15 = var_80_9.localEulerAngles

				var_80_15.z = 0
				var_80_15.x = 0
				var_80_9.localEulerAngles = var_80_15
			end

			if arg_77_1.time_ >= var_80_10 + var_80_11 and arg_77_1.time_ < var_80_10 + var_80_11 + arg_80_0 then
				var_80_9.localPosition = Vector3.New(0, 100, 0)

				local var_80_16 = manager.ui.mainCamera.transform.position - var_80_9.position

				var_80_9.forward = Vector3.New(var_80_16.x, var_80_16.y, var_80_16.z)

				local var_80_17 = var_80_9.localEulerAngles

				var_80_17.z = 0
				var_80_17.x = 0
				var_80_9.localEulerAngles = var_80_17
			end

			local var_80_18 = 0.034000001847744
			local var_80_19 = 1

			if var_80_18 < arg_77_1.time_ and arg_77_1.time_ <= var_80_18 + arg_80_0 then
				local var_80_20 = "play"
				local var_80_21 = "effect"

				arg_77_1:AudioAction(var_80_20, var_80_21, "se_story_139", "se_story_139_5220115Talk1_4", "")
			end

			local var_80_22 = manager.ui.mainCamera.transform
			local var_80_23 = 0.034000001847744

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 then
				local var_80_24 = arg_77_1.var_.effect410192
				local var_80_25
				local var_80_26 = var_80_22

				if not var_80_24 then
					var_80_24 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang02"), var_80_26)
					var_80_24.name = "410192"
					arg_77_1.var_.effect410192 = var_80_24
				else
					var_80_24.transform:SetParent(var_80_26)
				end

				var_80_24.transform.localPosition = Vector3.New(0, 0, 0)
				var_80_24.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_80_27 = manager.ui.mainCamera.transform
			local var_80_28 = 0.034000001847744

			if var_80_28 < arg_77_1.time_ and arg_77_1.time_ <= var_80_28 + arg_80_0 then
				arg_77_1.var_.shakeOldPos = var_80_27.localPosition
			end

			local var_80_29 = 0.4

			if var_80_28 <= arg_77_1.time_ and arg_77_1.time_ < var_80_28 + var_80_29 then
				local var_80_30 = (arg_77_1.time_ - var_80_28) / 0.066
				local var_80_31, var_80_32 = math.modf(var_80_30)

				var_80_27.localPosition = Vector3.New(var_80_32 * 0.13, var_80_32 * 0.13, var_80_32 * 0.13) + arg_77_1.var_.shakeOldPos
			end

			if arg_77_1.time_ >= var_80_28 + var_80_29 and arg_77_1.time_ < var_80_28 + var_80_29 + arg_80_0 then
				var_80_27.localPosition = arg_77_1.var_.shakeOldPos
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_33 = 0.434000001847744
			local var_80_34 = 1

			if var_80_33 < arg_77_1.time_ and arg_77_1.time_ <= var_80_33 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_35 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_35:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_36 = arg_77_1:GetWordFromCfg(322141019)
				local var_80_37 = arg_77_1:FormatText(var_80_36.content)

				arg_77_1.text_.text = var_80_37

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_38 = 58
				local var_80_39 = utf8.len(var_80_37)
				local var_80_40 = var_80_38 <= 0 and var_80_34 or var_80_34 * (var_80_39 / var_80_38)

				if var_80_40 > 0 and var_80_34 < var_80_40 then
					arg_77_1.talkMaxDuration = var_80_40
					var_80_33 = var_80_33 + 0.3

					if var_80_40 + var_80_33 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_40 + var_80_33
					end
				end

				arg_77_1.text_.text = var_80_37
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_41 = var_80_33 + 0.3
			local var_80_42 = math.max(var_80_34, arg_77_1.talkMaxDuration)

			if var_80_41 <= arg_77_1.time_ and arg_77_1.time_ < var_80_41 + var_80_42 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_41) / var_80_42

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_41 + var_80_42 and arg_77_1.time_ < var_80_41 + var_80_42 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
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

		arg_77_1:InitPlayNodeList()
	end,
	Play322141020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 322141020
		arg_83_1.duration_ = 2

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play322141021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1043ui_story"].transform
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.var_.moveOldPos1043ui_story = var_86_0.localPosition
			end

			local var_86_2 = 0.001

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2
				local var_86_4 = Vector3.New(0.01, -1.01, -5.73)

				var_86_0.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1043ui_story, var_86_4, var_86_3)

				local var_86_5 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_5.x, var_86_5.y, var_86_5.z)

				local var_86_6 = var_86_0.localEulerAngles

				var_86_6.z = 0
				var_86_6.x = 0
				var_86_0.localEulerAngles = var_86_6
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 then
				var_86_0.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_86_7 = manager.ui.mainCamera.transform.position - var_86_0.position

				var_86_0.forward = Vector3.New(var_86_7.x, var_86_7.y, var_86_7.z)

				local var_86_8 = var_86_0.localEulerAngles

				var_86_8.z = 0
				var_86_8.x = 0
				var_86_0.localEulerAngles = var_86_8
			end

			local var_86_9 = arg_83_1.actors_["1043ui_story"]
			local var_86_10 = 0

			if var_86_10 < arg_83_1.time_ and arg_83_1.time_ <= var_86_10 + arg_86_0 and not isNil(var_86_9) and arg_83_1.var_.characterEffect1043ui_story == nil then
				arg_83_1.var_.characterEffect1043ui_story = var_86_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_11 = 0.200000002980232

			if var_86_10 <= arg_83_1.time_ and arg_83_1.time_ < var_86_10 + var_86_11 and not isNil(var_86_9) then
				local var_86_12 = (arg_83_1.time_ - var_86_10) / var_86_11

				if arg_83_1.var_.characterEffect1043ui_story and not isNil(var_86_9) then
					arg_83_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= var_86_10 + var_86_11 and arg_83_1.time_ < var_86_10 + var_86_11 + arg_86_0 and not isNil(var_86_9) and arg_83_1.var_.characterEffect1043ui_story then
				arg_83_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_86_13 = 0

			if var_86_13 < arg_83_1.time_ and arg_83_1.time_ <= var_86_13 + arg_86_0 then
				arg_83_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_86_14 = 0

			if var_86_14 < arg_83_1.time_ and arg_83_1.time_ <= var_86_14 + arg_86_0 then
				arg_83_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_86_15 = manager.ui.mainCamera.transform
			local var_86_16 = 0

			if var_86_16 < arg_83_1.time_ and arg_83_1.time_ <= var_86_16 + arg_86_0 then
				local var_86_17 = arg_83_1.var_.effect41019

				if var_86_17 then
					Object.Destroy(var_86_17)

					arg_83_1.var_.effect41019 = nil
				end
			end

			local var_86_18 = 0
			local var_86_19 = 0.075

			if var_86_18 < arg_83_1.time_ and arg_83_1.time_ <= var_86_18 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_20 = arg_83_1:FormatText(StoryNameCfg[1156].name)

				arg_83_1.leftNameTxt_.text = var_86_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_21 = arg_83_1:GetWordFromCfg(322141020)
				local var_86_22 = arg_83_1:FormatText(var_86_21.content)

				arg_83_1.text_.text = var_86_22

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_23 = 3
				local var_86_24 = utf8.len(var_86_22)
				local var_86_25 = var_86_23 <= 0 and var_86_19 or var_86_19 * (var_86_24 / var_86_23)

				if var_86_25 > 0 and var_86_19 < var_86_25 then
					arg_83_1.talkMaxDuration = var_86_25

					if var_86_25 + var_86_18 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_25 + var_86_18
					end
				end

				arg_83_1.text_.text = var_86_22
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141020", "story_v_out_322141.awb") ~= 0 then
					local var_86_26 = manager.audio:GetVoiceLength("story_v_out_322141", "322141020", "story_v_out_322141.awb") / 1000

					if var_86_26 + var_86_18 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_26 + var_86_18
					end

					if var_86_21.prefab_name ~= "" and arg_83_1.actors_[var_86_21.prefab_name] ~= nil then
						local var_86_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_21.prefab_name].transform, "story_v_out_322141", "322141020", "story_v_out_322141.awb")

						arg_83_1:RecordAudio("322141020", var_86_27)
						arg_83_1:RecordAudio("322141020", var_86_27)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_322141", "322141020", "story_v_out_322141.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_322141", "322141020", "story_v_out_322141.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_28 = math.max(var_86_19, arg_83_1.talkMaxDuration)

			if var_86_18 <= arg_83_1.time_ and arg_83_1.time_ < var_86_18 + var_86_28 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_18) / var_86_28

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_18 + var_86_28 and arg_83_1.time_ < var_86_18 + var_86_28 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
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
	Play322141021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 322141021
		arg_87_1.duration_ = 2.93

		local var_87_0 = {
			zh = 2.266,
			ja = 2.933
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
				arg_87_0:Play322141022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = arg_87_1.actors_["1043ui_story"].transform
			local var_90_1 = 0

			if var_90_1 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.var_.moveOldPos1043ui_story = var_90_0.localPosition
			end

			local var_90_2 = 0.001

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_2 then
				local var_90_3 = (arg_87_1.time_ - var_90_1) / var_90_2
				local var_90_4 = Vector3.New(0, 100, 0)

				var_90_0.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1043ui_story, var_90_4, var_90_3)

				local var_90_5 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_5.x, var_90_5.y, var_90_5.z)

				local var_90_6 = var_90_0.localEulerAngles

				var_90_6.z = 0
				var_90_6.x = 0
				var_90_0.localEulerAngles = var_90_6
			end

			if arg_87_1.time_ >= var_90_1 + var_90_2 and arg_87_1.time_ < var_90_1 + var_90_2 + arg_90_0 then
				var_90_0.localPosition = Vector3.New(0, 100, 0)

				local var_90_7 = manager.ui.mainCamera.transform.position - var_90_0.position

				var_90_0.forward = Vector3.New(var_90_7.x, var_90_7.y, var_90_7.z)

				local var_90_8 = var_90_0.localEulerAngles

				var_90_8.z = 0
				var_90_8.x = 0
				var_90_0.localEulerAngles = var_90_8
			end

			local var_90_9 = arg_87_1.actors_["1043ui_story"]
			local var_90_10 = 0

			if var_90_10 < arg_87_1.time_ and arg_87_1.time_ <= var_90_10 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect1043ui_story == nil then
				arg_87_1.var_.characterEffect1043ui_story = var_90_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_11 = 0.200000002980232

			if var_90_10 <= arg_87_1.time_ and arg_87_1.time_ < var_90_10 + var_90_11 and not isNil(var_90_9) then
				local var_90_12 = (arg_87_1.time_ - var_90_10) / var_90_11

				if arg_87_1.var_.characterEffect1043ui_story and not isNil(var_90_9) then
					local var_90_13 = Mathf.Lerp(0, 0.5, var_90_12)

					arg_87_1.var_.characterEffect1043ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1043ui_story.fillRatio = var_90_13
				end
			end

			if arg_87_1.time_ >= var_90_10 + var_90_11 and arg_87_1.time_ < var_90_10 + var_90_11 + arg_90_0 and not isNil(var_90_9) and arg_87_1.var_.characterEffect1043ui_story then
				local var_90_14 = 0.5

				arg_87_1.var_.characterEffect1043ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1043ui_story.fillRatio = var_90_14
			end

			local var_90_15 = 0
			local var_90_16 = 0.225

			if var_90_15 < arg_87_1.time_ and arg_87_1.time_ <= var_90_15 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_17 = arg_87_1:FormatText(StoryNameCfg[1165].name)

				arg_87_1.leftNameTxt_.text = var_90_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_naiti")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_18 = arg_87_1:GetWordFromCfg(322141021)
				local var_90_19 = arg_87_1:FormatText(var_90_18.content)

				arg_87_1.text_.text = var_90_19

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_20 = 9
				local var_90_21 = utf8.len(var_90_19)
				local var_90_22 = var_90_20 <= 0 and var_90_16 or var_90_16 * (var_90_21 / var_90_20)

				if var_90_22 > 0 and var_90_16 < var_90_22 then
					arg_87_1.talkMaxDuration = var_90_22

					if var_90_22 + var_90_15 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_22 + var_90_15
					end
				end

				arg_87_1.text_.text = var_90_19
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141021", "story_v_out_322141.awb") ~= 0 then
					local var_90_23 = manager.audio:GetVoiceLength("story_v_out_322141", "322141021", "story_v_out_322141.awb") / 1000

					if var_90_23 + var_90_15 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_23 + var_90_15
					end

					if var_90_18.prefab_name ~= "" and arg_87_1.actors_[var_90_18.prefab_name] ~= nil then
						local var_90_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_18.prefab_name].transform, "story_v_out_322141", "322141021", "story_v_out_322141.awb")

						arg_87_1:RecordAudio("322141021", var_90_24)
						arg_87_1:RecordAudio("322141021", var_90_24)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_322141", "322141021", "story_v_out_322141.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_322141", "322141021", "story_v_out_322141.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_25 = math.max(var_90_16, arg_87_1.talkMaxDuration)

			if var_90_15 <= arg_87_1.time_ and arg_87_1.time_ < var_90_15 + var_90_25 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_15) / var_90_25

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_15 + var_90_25 and arg_87_1.time_ < var_90_15 + var_90_25 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play322141022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 322141022
		arg_91_1.duration_ = 6.37

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play322141023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = manager.ui.mainCamera.transform
			local var_94_1 = 0

			if var_94_1 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				local var_94_2 = arg_91_1.var_.effect1022
				local var_94_3
				local var_94_4 = var_94_0

				if not var_94_2 then
					var_94_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boom"), var_94_4)
					var_94_2.name = "1022"
					arg_91_1.var_.effect1022 = var_94_2
				else
					var_94_2.transform:SetParent(var_94_4)
				end

				var_94_2.transform.localPosition = Vector3.New(0, 0, -4)
				var_94_2.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_94_5 = manager.ui.mainCameraCom_
				local var_94_6 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(var_94_5.fieldOfView * 0.5 * Mathf.Deg2Rad)
				local var_94_7 = var_94_2.transform:GetComponentsInChildren(typeof(Transform), true):ToTable()
				local var_94_8 = 15
				local var_94_9 = 2 * var_94_8 * Mathf.Tan(var_94_5.fieldOfView * 0.5 * Mathf.Deg2Rad) * var_94_5.aspect
				local var_94_10 = 1
				local var_94_11 = 1.7777777777777777

				if var_94_11 < var_94_5.aspect then
					var_94_10 = var_94_9 / (2 * var_94_8 * Mathf.Tan(15 * Mathf.Deg2Rad) * var_94_11)
				end

				for iter_94_0, iter_94_1 in ipairs(var_94_7) do
					local var_94_12 = iter_94_1.transform.localScale

					iter_94_1.transform.localScale = Vector3.New(var_94_12.x / var_94_6 * var_94_10, var_94_12.y / var_94_6, var_94_12.z)
				end
			end

			local var_94_13 = manager.ui.mainCamera.transform
			local var_94_14 = 0

			if var_94_14 < arg_91_1.time_ and arg_91_1.time_ <= var_94_14 + arg_94_0 then
				arg_91_1.var_.shakeOldPos = var_94_13.localPosition
			end

			local var_94_15 = 0.833333333333333

			if var_94_14 <= arg_91_1.time_ and arg_91_1.time_ < var_94_14 + var_94_15 then
				local var_94_16 = (arg_91_1.time_ - var_94_14) / 0.066
				local var_94_17, var_94_18 = math.modf(var_94_16)

				var_94_13.localPosition = Vector3.New(var_94_18 * 0.13, var_94_18 * 0.13, var_94_18 * 0.13) + arg_91_1.var_.shakeOldPos
			end

			if arg_91_1.time_ >= var_94_14 + var_94_15 and arg_91_1.time_ < var_94_14 + var_94_15 + arg_94_0 then
				var_94_13.localPosition = arg_91_1.var_.shakeOldPos
			end

			local var_94_19 = 0
			local var_94_20 = 1

			if var_94_19 < arg_91_1.time_ and arg_91_1.time_ <= var_94_19 + arg_94_0 then
				local var_94_21 = "play"
				local var_94_22 = "effect"

				arg_91_1:AudioAction(var_94_21, var_94_22, "se_story_140", "se_story_140_explosion05", "")
			end

			if arg_91_1.frameCnt_ <= 1 then
				arg_91_1.dialog_:SetActive(false)
			end

			local var_94_23 = 1.36666666666667
			local var_94_24 = 1.575

			if var_94_23 < arg_91_1.time_ and arg_91_1.time_ <= var_94_23 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				arg_91_1.dialog_:SetActive(true)

				arg_91_1.dialogCg_.alpha = 0

				local var_94_25 = LeanTween.value(arg_91_1.dialog_, 0, 1, 0.3)

				var_94_25:setOnUpdate(LuaHelper.FloatAction(function(arg_95_0)
					arg_91_1.dialogCg_.alpha = arg_95_0
				end))
				var_94_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_91_1.dialog_)
					var_94_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_91_1.duration_ = arg_91_1.duration_ + 0.3

				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_26 = arg_91_1:GetWordFromCfg(322141022)
				local var_94_27 = arg_91_1:FormatText(var_94_26.content)

				arg_91_1.text_.text = var_94_27

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_28 = 63
				local var_94_29 = utf8.len(var_94_27)
				local var_94_30 = var_94_28 <= 0 and var_94_24 or var_94_24 * (var_94_29 / var_94_28)

				if var_94_30 > 0 and var_94_24 < var_94_30 then
					arg_91_1.talkMaxDuration = var_94_30
					var_94_23 = var_94_23 + 0.3

					if var_94_30 + var_94_23 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_30 + var_94_23
					end
				end

				arg_91_1.text_.text = var_94_27
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_31 = var_94_23 + 0.3
			local var_94_32 = math.max(var_94_24, arg_91_1.talkMaxDuration)

			if var_94_31 <= arg_91_1.time_ and arg_91_1.time_ < var_94_31 + var_94_32 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_31) / var_94_32

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_31 + var_94_32 and arg_91_1.time_ < var_94_31 + var_94_32 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play322141023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 322141023
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play322141024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = manager.ui.mainCamera.transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				local var_100_2 = arg_97_1.var_.effect1022

				if var_100_2 then
					Object.Destroy(var_100_2)

					arg_97_1.var_.effect1022 = nil
				end
			end

			local var_100_3 = 0
			local var_100_4 = 1.275

			if var_100_3 < arg_97_1.time_ and arg_97_1.time_ <= var_100_3 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_5 = arg_97_1:GetWordFromCfg(322141023)
				local var_100_6 = arg_97_1:FormatText(var_100_5.content)

				arg_97_1.text_.text = var_100_6

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_7 = 51
				local var_100_8 = utf8.len(var_100_6)
				local var_100_9 = var_100_7 <= 0 and var_100_4 or var_100_4 * (var_100_8 / var_100_7)

				if var_100_9 > 0 and var_100_4 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_3 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_3
					end
				end

				arg_97_1.text_.text = var_100_6
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_4, arg_97_1.talkMaxDuration)

			if var_100_3 <= arg_97_1.time_ and arg_97_1.time_ < var_100_3 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_3) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_3 + var_100_10 and arg_97_1.time_ < var_100_3 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play322141024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 322141024
		arg_101_1.duration_ = 5.07

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play322141025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["1044ui_story"].transform
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 then
				arg_101_1.var_.moveOldPos1044ui_story = var_104_0.localPosition
			end

			local var_104_2 = 0.001

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2
				local var_104_4 = Vector3.New(-0.7, -1, -5.93)

				var_104_0.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1044ui_story, var_104_4, var_104_3)

				local var_104_5 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_5.x, var_104_5.y, var_104_5.z)

				local var_104_6 = var_104_0.localEulerAngles

				var_104_6.z = 0
				var_104_6.x = 0
				var_104_0.localEulerAngles = var_104_6
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 then
				var_104_0.localPosition = Vector3.New(-0.7, -1, -5.93)

				local var_104_7 = manager.ui.mainCamera.transform.position - var_104_0.position

				var_104_0.forward = Vector3.New(var_104_7.x, var_104_7.y, var_104_7.z)

				local var_104_8 = var_104_0.localEulerAngles

				var_104_8.z = 0
				var_104_8.x = 0
				var_104_0.localEulerAngles = var_104_8
			end

			local var_104_9 = arg_101_1.actors_["1044ui_story"]
			local var_104_10 = 0

			if var_104_10 < arg_101_1.time_ and arg_101_1.time_ <= var_104_10 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1044ui_story == nil then
				arg_101_1.var_.characterEffect1044ui_story = var_104_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_11 = 0.200000002980232

			if var_104_10 <= arg_101_1.time_ and arg_101_1.time_ < var_104_10 + var_104_11 and not isNil(var_104_9) then
				local var_104_12 = (arg_101_1.time_ - var_104_10) / var_104_11

				if arg_101_1.var_.characterEffect1044ui_story and not isNil(var_104_9) then
					arg_101_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_10 + var_104_11 and arg_101_1.time_ < var_104_10 + var_104_11 + arg_104_0 and not isNil(var_104_9) and arg_101_1.var_.characterEffect1044ui_story then
				arg_101_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_104_13 = 0

			if var_104_13 < arg_101_1.time_ and arg_101_1.time_ <= var_104_13 + arg_104_0 then
				arg_101_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_deyiA", "EmotionTimelineAnimator")
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action2_1")
			end

			local var_104_15 = 0
			local var_104_16 = 0.45

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_17 = arg_101_1:FormatText(StoryNameCfg[67].name)

				arg_101_1.leftNameTxt_.text = var_104_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_18 = arg_101_1:GetWordFromCfg(322141024)
				local var_104_19 = arg_101_1:FormatText(var_104_18.content)

				arg_101_1.text_.text = var_104_19

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_20 = 18
				local var_104_21 = utf8.len(var_104_19)
				local var_104_22 = var_104_20 <= 0 and var_104_16 or var_104_16 * (var_104_21 / var_104_20)

				if var_104_22 > 0 and var_104_16 < var_104_22 then
					arg_101_1.talkMaxDuration = var_104_22

					if var_104_22 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_22 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_19
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141024", "story_v_out_322141.awb") ~= 0 then
					local var_104_23 = manager.audio:GetVoiceLength("story_v_out_322141", "322141024", "story_v_out_322141.awb") / 1000

					if var_104_23 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_23 + var_104_15
					end

					if var_104_18.prefab_name ~= "" and arg_101_1.actors_[var_104_18.prefab_name] ~= nil then
						local var_104_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_18.prefab_name].transform, "story_v_out_322141", "322141024", "story_v_out_322141.awb")

						arg_101_1:RecordAudio("322141024", var_104_24)
						arg_101_1:RecordAudio("322141024", var_104_24)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_322141", "322141024", "story_v_out_322141.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_322141", "322141024", "story_v_out_322141.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_25 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_25 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_15) / var_104_25

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_15 + var_104_25 and arg_101_1.time_ < var_104_15 + var_104_25 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play322141025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 322141025
		arg_105_1.duration_ = 2.23

		local var_105_0 = {
			zh = 1.999999999999,
			ja = 2.233
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play322141026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = "1211ui_story"

			if arg_105_1.actors_[var_108_0] == nil then
				local var_108_1 = Asset.Load("Char/" .. "1211ui_story")

				if not isNil(var_108_1) then
					local var_108_2 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_105_1.stage_.transform)

					var_108_2.name = var_108_0
					var_108_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_105_1.actors_[var_108_0] = var_108_2

					local var_108_3 = var_108_2:GetComponentInChildren(typeof(CharacterEffect))

					var_108_3.enabled = true

					local var_108_4 = GameObjectTools.GetOrAddComponent(var_108_2, typeof(DynamicBoneHelper))

					if var_108_4 then
						var_108_4:EnableDynamicBone(false)
					end

					arg_105_1:ShowWeapon(var_108_3.transform, false)

					arg_105_1.var_[var_108_0 .. "Animator"] = var_108_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_105_1.var_[var_108_0 .. "Animator"].applyRootMotion = true
					arg_105_1.var_[var_108_0 .. "LipSync"] = var_108_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_108_5 = arg_105_1.actors_["1211ui_story"].transform
			local var_108_6 = 0

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.var_.moveOldPos1211ui_story = var_108_5.localPosition
			end

			local var_108_7 = 0.001

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_7 then
				local var_108_8 = (arg_105_1.time_ - var_108_6) / var_108_7
				local var_108_9 = Vector3.New(0.7, -0.67, -6.07)

				var_108_5.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1211ui_story, var_108_9, var_108_8)

				local var_108_10 = manager.ui.mainCamera.transform.position - var_108_5.position

				var_108_5.forward = Vector3.New(var_108_10.x, var_108_10.y, var_108_10.z)

				local var_108_11 = var_108_5.localEulerAngles

				var_108_11.z = 0
				var_108_11.x = 0
				var_108_5.localEulerAngles = var_108_11
			end

			if arg_105_1.time_ >= var_108_6 + var_108_7 and arg_105_1.time_ < var_108_6 + var_108_7 + arg_108_0 then
				var_108_5.localPosition = Vector3.New(0.7, -0.67, -6.07)

				local var_108_12 = manager.ui.mainCamera.transform.position - var_108_5.position

				var_108_5.forward = Vector3.New(var_108_12.x, var_108_12.y, var_108_12.z)

				local var_108_13 = var_108_5.localEulerAngles

				var_108_13.z = 0
				var_108_13.x = 0
				var_108_5.localEulerAngles = var_108_13
			end

			local var_108_14 = arg_105_1.actors_["1211ui_story"]
			local var_108_15 = 0

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 and not isNil(var_108_14) and arg_105_1.var_.characterEffect1211ui_story == nil then
				arg_105_1.var_.characterEffect1211ui_story = var_108_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_16 = 0.200000002980232

			if var_108_15 <= arg_105_1.time_ and arg_105_1.time_ < var_108_15 + var_108_16 and not isNil(var_108_14) then
				local var_108_17 = (arg_105_1.time_ - var_108_15) / var_108_16

				if arg_105_1.var_.characterEffect1211ui_story and not isNil(var_108_14) then
					arg_105_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_15 + var_108_16 and arg_105_1.time_ < var_108_15 + var_108_16 + arg_108_0 and not isNil(var_108_14) and arg_105_1.var_.characterEffect1211ui_story then
				arg_105_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_108_18 = arg_105_1.actors_["1044ui_story"]
			local var_108_19 = 0

			if var_108_19 < arg_105_1.time_ and arg_105_1.time_ <= var_108_19 + arg_108_0 and not isNil(var_108_18) and arg_105_1.var_.characterEffect1044ui_story == nil then
				arg_105_1.var_.characterEffect1044ui_story = var_108_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_20 = 0.200000002980232

			if var_108_19 <= arg_105_1.time_ and arg_105_1.time_ < var_108_19 + var_108_20 and not isNil(var_108_18) then
				local var_108_21 = (arg_105_1.time_ - var_108_19) / var_108_20

				if arg_105_1.var_.characterEffect1044ui_story and not isNil(var_108_18) then
					local var_108_22 = Mathf.Lerp(0, 0.5, var_108_21)

					arg_105_1.var_.characterEffect1044ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1044ui_story.fillRatio = var_108_22
				end
			end

			if arg_105_1.time_ >= var_108_19 + var_108_20 and arg_105_1.time_ < var_108_19 + var_108_20 + arg_108_0 and not isNil(var_108_18) and arg_105_1.var_.characterEffect1044ui_story then
				local var_108_23 = 0.5

				arg_105_1.var_.characterEffect1044ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1044ui_story.fillRatio = var_108_23
			end

			local var_108_24 = 0

			if var_108_24 < arg_105_1.time_ and arg_105_1.time_ <= var_108_24 + arg_108_0 then
				arg_105_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			local var_108_25 = 0

			if var_108_25 < arg_105_1.time_ and arg_105_1.time_ <= var_108_25 + arg_108_0 then
				arg_105_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_108_26 = 0
			local var_108_27 = 0.175

			if var_108_26 < arg_105_1.time_ and arg_105_1.time_ <= var_108_26 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_28 = arg_105_1:FormatText(StoryNameCfg[37].name)

				arg_105_1.leftNameTxt_.text = var_108_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_29 = arg_105_1:GetWordFromCfg(322141025)
				local var_108_30 = arg_105_1:FormatText(var_108_29.content)

				arg_105_1.text_.text = var_108_30

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_31 = 7
				local var_108_32 = utf8.len(var_108_30)
				local var_108_33 = var_108_31 <= 0 and var_108_27 or var_108_27 * (var_108_32 / var_108_31)

				if var_108_33 > 0 and var_108_27 < var_108_33 then
					arg_105_1.talkMaxDuration = var_108_33

					if var_108_33 + var_108_26 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_33 + var_108_26
					end
				end

				arg_105_1.text_.text = var_108_30
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141025", "story_v_out_322141.awb") ~= 0 then
					local var_108_34 = manager.audio:GetVoiceLength("story_v_out_322141", "322141025", "story_v_out_322141.awb") / 1000

					if var_108_34 + var_108_26 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_34 + var_108_26
					end

					if var_108_29.prefab_name ~= "" and arg_105_1.actors_[var_108_29.prefab_name] ~= nil then
						local var_108_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_29.prefab_name].transform, "story_v_out_322141", "322141025", "story_v_out_322141.awb")

						arg_105_1:RecordAudio("322141025", var_108_35)
						arg_105_1:RecordAudio("322141025", var_108_35)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_322141", "322141025", "story_v_out_322141.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_322141", "322141025", "story_v_out_322141.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_36 = math.max(var_108_27, arg_105_1.talkMaxDuration)

			if var_108_26 <= arg_105_1.time_ and arg_105_1.time_ < var_108_26 + var_108_36 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_26) / var_108_36

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_26 + var_108_36 and arg_105_1.time_ < var_108_26 + var_108_36 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play322141026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 322141026
		arg_109_1.duration_ = 2

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play322141027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1043ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1043ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0.01, -1.01, -5.73)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1043ui_story, var_112_4, var_112_3)

				local var_112_5 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_5.x, var_112_5.y, var_112_5.z)

				local var_112_6 = var_112_0.localEulerAngles

				var_112_6.z = 0
				var_112_6.x = 0
				var_112_0.localEulerAngles = var_112_6
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 then
				var_112_0.localPosition = Vector3.New(0.01, -1.01, -5.73)

				local var_112_7 = manager.ui.mainCamera.transform.position - var_112_0.position

				var_112_0.forward = Vector3.New(var_112_7.x, var_112_7.y, var_112_7.z)

				local var_112_8 = var_112_0.localEulerAngles

				var_112_8.z = 0
				var_112_8.x = 0
				var_112_0.localEulerAngles = var_112_8
			end

			local var_112_9 = arg_109_1.actors_["1211ui_story"].transform
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 then
				arg_109_1.var_.moveOldPos1211ui_story = var_112_9.localPosition
			end

			local var_112_11 = 0.001

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11
				local var_112_13 = Vector3.New(0, 100, 0)

				var_112_9.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1211ui_story, var_112_13, var_112_12)

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

			local var_112_18 = arg_109_1.actors_["1044ui_story"].transform
			local var_112_19 = 0

			if var_112_19 < arg_109_1.time_ and arg_109_1.time_ <= var_112_19 + arg_112_0 then
				arg_109_1.var_.moveOldPos1044ui_story = var_112_18.localPosition
			end

			local var_112_20 = 0.001

			if var_112_19 <= arg_109_1.time_ and arg_109_1.time_ < var_112_19 + var_112_20 then
				local var_112_21 = (arg_109_1.time_ - var_112_19) / var_112_20
				local var_112_22 = Vector3.New(0, 100, 0)

				var_112_18.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1044ui_story, var_112_22, var_112_21)

				local var_112_23 = manager.ui.mainCamera.transform.position - var_112_18.position

				var_112_18.forward = Vector3.New(var_112_23.x, var_112_23.y, var_112_23.z)

				local var_112_24 = var_112_18.localEulerAngles

				var_112_24.z = 0
				var_112_24.x = 0
				var_112_18.localEulerAngles = var_112_24
			end

			if arg_109_1.time_ >= var_112_19 + var_112_20 and arg_109_1.time_ < var_112_19 + var_112_20 + arg_112_0 then
				var_112_18.localPosition = Vector3.New(0, 100, 0)

				local var_112_25 = manager.ui.mainCamera.transform.position - var_112_18.position

				var_112_18.forward = Vector3.New(var_112_25.x, var_112_25.y, var_112_25.z)

				local var_112_26 = var_112_18.localEulerAngles

				var_112_26.z = 0
				var_112_26.x = 0
				var_112_18.localEulerAngles = var_112_26
			end

			local var_112_27 = arg_109_1.actors_["1043ui_story"]
			local var_112_28 = 0

			if var_112_28 < arg_109_1.time_ and arg_109_1.time_ <= var_112_28 + arg_112_0 and not isNil(var_112_27) and arg_109_1.var_.characterEffect1043ui_story == nil then
				arg_109_1.var_.characterEffect1043ui_story = var_112_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_29 = 0.200000002980232

			if var_112_28 <= arg_109_1.time_ and arg_109_1.time_ < var_112_28 + var_112_29 and not isNil(var_112_27) then
				local var_112_30 = (arg_109_1.time_ - var_112_28) / var_112_29

				if arg_109_1.var_.characterEffect1043ui_story and not isNil(var_112_27) then
					arg_109_1.var_.characterEffect1043ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= var_112_28 + var_112_29 and arg_109_1.time_ < var_112_28 + var_112_29 + arg_112_0 and not isNil(var_112_27) and arg_109_1.var_.characterEffect1043ui_story then
				arg_109_1.var_.characterEffect1043ui_story.fillFlat = false
			end

			local var_112_31 = arg_109_1.actors_["1211ui_story"]
			local var_112_32 = 0

			if var_112_32 < arg_109_1.time_ and arg_109_1.time_ <= var_112_32 + arg_112_0 and not isNil(var_112_31) and arg_109_1.var_.characterEffect1211ui_story == nil then
				arg_109_1.var_.characterEffect1211ui_story = var_112_31:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_33 = 0.200000002980232

			if var_112_32 <= arg_109_1.time_ and arg_109_1.time_ < var_112_32 + var_112_33 and not isNil(var_112_31) then
				local var_112_34 = (arg_109_1.time_ - var_112_32) / var_112_33

				if arg_109_1.var_.characterEffect1211ui_story and not isNil(var_112_31) then
					local var_112_35 = Mathf.Lerp(0, 0.5, var_112_34)

					arg_109_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1211ui_story.fillRatio = var_112_35
				end
			end

			if arg_109_1.time_ >= var_112_32 + var_112_33 and arg_109_1.time_ < var_112_32 + var_112_33 + arg_112_0 and not isNil(var_112_31) and arg_109_1.var_.characterEffect1211ui_story then
				local var_112_36 = 0.5

				arg_109_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1211ui_story.fillRatio = var_112_36
			end

			local var_112_37 = 0

			if var_112_37 < arg_109_1.time_ and arg_109_1.time_ <= var_112_37 + arg_112_0 then
				arg_109_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/story1043/story1043action/1043action1_1")
			end

			local var_112_38 = 0

			if var_112_38 < arg_109_1.time_ and arg_109_1.time_ <= var_112_38 + arg_112_0 then
				arg_109_1:PlayTimeline("1043ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_112_39 = 0
			local var_112_40 = 0.125

			if var_112_39 < arg_109_1.time_ and arg_109_1.time_ <= var_112_39 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				local var_112_41 = arg_109_1:FormatText(StoryNameCfg[1156].name)

				arg_109_1.leftNameTxt_.text = var_112_41

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_42 = arg_109_1:GetWordFromCfg(322141026)
				local var_112_43 = arg_109_1:FormatText(var_112_42.content)

				arg_109_1.text_.text = var_112_43

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_44 = 5
				local var_112_45 = utf8.len(var_112_43)
				local var_112_46 = var_112_44 <= 0 and var_112_40 or var_112_40 * (var_112_45 / var_112_44)

				if var_112_46 > 0 and var_112_40 < var_112_46 then
					arg_109_1.talkMaxDuration = var_112_46

					if var_112_46 + var_112_39 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_46 + var_112_39
					end
				end

				arg_109_1.text_.text = var_112_43
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141026", "story_v_out_322141.awb") ~= 0 then
					local var_112_47 = manager.audio:GetVoiceLength("story_v_out_322141", "322141026", "story_v_out_322141.awb") / 1000

					if var_112_47 + var_112_39 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_47 + var_112_39
					end

					if var_112_42.prefab_name ~= "" and arg_109_1.actors_[var_112_42.prefab_name] ~= nil then
						local var_112_48 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_42.prefab_name].transform, "story_v_out_322141", "322141026", "story_v_out_322141.awb")

						arg_109_1:RecordAudio("322141026", var_112_48)
						arg_109_1:RecordAudio("322141026", var_112_48)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_322141", "322141026", "story_v_out_322141.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_322141", "322141026", "story_v_out_322141.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_49 = math.max(var_112_40, arg_109_1.talkMaxDuration)

			if var_112_39 <= arg_109_1.time_ and arg_109_1.time_ < var_112_39 + var_112_49 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_39) / var_112_49

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_39 + var_112_49 and arg_109_1.time_ < var_112_39 + var_112_49 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
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
				actorName = "1044ui_story",
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
	Play322141027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 322141027
		arg_113_1.duration_ = 6.62

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play322141028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1043ui_story"].transform
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 then
				arg_113_1.var_.moveOldPos1043ui_story = var_116_0.localPosition
			end

			local var_116_2 = 0.001

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2
				local var_116_4 = Vector3.New(0, 100, 0)

				var_116_0.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1043ui_story, var_116_4, var_116_3)

				local var_116_5 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_5.x, var_116_5.y, var_116_5.z)

				local var_116_6 = var_116_0.localEulerAngles

				var_116_6.z = 0
				var_116_6.x = 0
				var_116_0.localEulerAngles = var_116_6
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 then
				var_116_0.localPosition = Vector3.New(0, 100, 0)

				local var_116_7 = manager.ui.mainCamera.transform.position - var_116_0.position

				var_116_0.forward = Vector3.New(var_116_7.x, var_116_7.y, var_116_7.z)

				local var_116_8 = var_116_0.localEulerAngles

				var_116_8.z = 0
				var_116_8.x = 0
				var_116_0.localEulerAngles = var_116_8
			end

			local var_116_9 = 0.733333333333333

			if var_116_9 < arg_113_1.time_ and arg_113_1.time_ <= var_116_9 + arg_116_0 then
				arg_113_1.var_.shakeOldPos = var_116_0.localPosition
			end

			local var_116_10 = 0.266666666666667

			if var_116_9 <= arg_113_1.time_ and arg_113_1.time_ < var_116_9 + var_116_10 then
				local var_116_11 = (arg_113_1.time_ - var_116_9) / 0.066
				local var_116_12, var_116_13 = math.modf(var_116_11)

				var_116_0.localPosition = Vector3.New(var_116_13 * 0.13, var_116_13 * 0.13, var_116_13 * 0.13) + arg_113_1.var_.shakeOldPos
			end

			if arg_113_1.time_ >= var_116_9 + var_116_10 and arg_113_1.time_ < var_116_9 + var_116_10 + arg_116_0 then
				var_116_0.localPosition = arg_113_1.var_.shakeOldPos
			end

			local var_116_14 = manager.ui.mainCamera.transform
			local var_116_15 = 0

			if var_116_15 < arg_113_1.time_ and arg_113_1.time_ <= var_116_15 + arg_116_0 then
				local var_116_16 = arg_113_1.var_.effect1027
				local var_116_17
				local var_116_18 = var_116_14

				if not var_116_16 then
					var_116_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xdaoguang"), var_116_18)
					var_116_16.name = "1027"
					arg_113_1.var_.effect1027 = var_116_16
				else
					var_116_16.transform:SetParent(var_116_18)
				end

				var_116_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_116_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_116_19 = manager.ui.mainCamera.transform
			local var_116_20 = 4.3

			if var_116_20 < arg_113_1.time_ and arg_113_1.time_ <= var_116_20 + arg_116_0 then
				local var_116_21 = arg_113_1.var_.effect1027

				if var_116_21 then
					Object.Destroy(var_116_21)

					arg_113_1.var_.effect1027 = nil
				end
			end

			local var_116_22 = 0
			local var_116_23 = 1

			if var_116_22 < arg_113_1.time_ and arg_113_1.time_ <= var_116_22 + arg_116_0 then
				local var_116_24 = "play"
				local var_116_25 = "effect"

				arg_113_1:AudioAction(var_116_24, var_116_25, "se_story_145", "se_story_145_combo", "")
			end

			if arg_113_1.frameCnt_ <= 1 then
				arg_113_1.dialog_:SetActive(false)
			end

			local var_116_26 = 1.61666666666667
			local var_116_27 = 1.325

			if var_116_26 < arg_113_1.time_ and arg_113_1.time_ <= var_116_26 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0

				arg_113_1.dialog_:SetActive(true)

				arg_113_1.dialogCg_.alpha = 0

				local var_116_28 = LeanTween.value(arg_113_1.dialog_, 0, 1, 0.3)

				var_116_28:setOnUpdate(LuaHelper.FloatAction(function(arg_117_0)
					arg_113_1.dialogCg_.alpha = arg_117_0
				end))
				var_116_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_113_1.dialog_)
					var_116_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_113_1.duration_ = arg_113_1.duration_ + 0.3

				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_29 = arg_113_1:GetWordFromCfg(322141027)
				local var_116_30 = arg_113_1:FormatText(var_116_29.content)

				arg_113_1.text_.text = var_116_30

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_31 = 53
				local var_116_32 = utf8.len(var_116_30)
				local var_116_33 = var_116_31 <= 0 and var_116_27 or var_116_27 * (var_116_32 / var_116_31)

				if var_116_33 > 0 and var_116_27 < var_116_33 then
					arg_113_1.talkMaxDuration = var_116_33
					var_116_26 = var_116_26 + 0.3

					if var_116_33 + var_116_26 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_33 + var_116_26
					end
				end

				arg_113_1.text_.text = var_116_30
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_34 = var_116_26 + 0.3
			local var_116_35 = math.max(var_116_27, arg_113_1.talkMaxDuration)

			if var_116_34 <= arg_113_1.time_ and arg_113_1.time_ < var_116_34 + var_116_35 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_34) / var_116_35

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_34 + var_116_35 and arg_113_1.time_ < var_116_34 + var_116_35 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1043ui_story",
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
	Play322141028 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 322141028
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play322141029(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0.1
			local var_122_1 = 1

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				local var_122_2 = "play"
				local var_122_3 = "effect"

				arg_119_1:AudioAction(var_122_2, var_122_3, "se_story_145", "se_story_145_laser", "")
			end

			local var_122_4 = manager.ui.mainCamera.transform
			local var_122_5 = 0.1

			if var_122_5 < arg_119_1.time_ and arg_119_1.time_ <= var_122_5 + arg_122_0 then
				arg_119_1.var_.shakeOldPos = var_122_4.localPosition
			end

			local var_122_6 = 0.366666666666667

			if var_122_5 <= arg_119_1.time_ and arg_119_1.time_ < var_122_5 + var_122_6 then
				local var_122_7 = (arg_119_1.time_ - var_122_5) / 0.099
				local var_122_8, var_122_9 = math.modf(var_122_7)

				var_122_4.localPosition = Vector3.New(var_122_9 * 0.13, var_122_9 * 0.13, var_122_9 * 0.13) + arg_119_1.var_.shakeOldPos
			end

			if arg_119_1.time_ >= var_122_5 + var_122_6 and arg_119_1.time_ < var_122_5 + var_122_6 + arg_122_0 then
				var_122_4.localPosition = arg_119_1.var_.shakeOldPos
			end

			local var_122_10 = 0
			local var_122_11 = 1.275

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

				local var_122_12 = arg_119_1:GetWordFromCfg(322141028)
				local var_122_13 = arg_119_1:FormatText(var_122_12.content)

				arg_119_1.text_.text = var_122_13

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_14 = 51
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
	Play322141029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 322141029
		arg_123_1.duration_ = 2.17

		local var_123_0 = {
			zh = 2.166,
			ja = 2.133
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
				arg_123_0:Play322141030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = "1284ui_story"

			if arg_123_1.actors_[var_126_0] == nil then
				local var_126_1 = Asset.Load("Char/" .. "1284ui_story")

				if not isNil(var_126_1) then
					local var_126_2 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_123_1.stage_.transform)

					var_126_2.name = var_126_0
					var_126_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_123_1.actors_[var_126_0] = var_126_2

					local var_126_3 = var_126_2:GetComponentInChildren(typeof(CharacterEffect))

					var_126_3.enabled = true

					local var_126_4 = GameObjectTools.GetOrAddComponent(var_126_2, typeof(DynamicBoneHelper))

					if var_126_4 then
						var_126_4:EnableDynamicBone(false)
					end

					arg_123_1:ShowWeapon(var_126_3.transform, false)

					arg_123_1.var_[var_126_0 .. "Animator"] = var_126_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_123_1.var_[var_126_0 .. "Animator"].applyRootMotion = true
					arg_123_1.var_[var_126_0 .. "LipSync"] = var_126_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_126_5 = arg_123_1.actors_["1284ui_story"].transform
			local var_126_6 = 0

			if var_126_6 < arg_123_1.time_ and arg_123_1.time_ <= var_126_6 + arg_126_0 then
				arg_123_1.var_.moveOldPos1284ui_story = var_126_5.localPosition

				local var_126_7 = "1284ui_story"

				arg_123_1:ShowWeapon(arg_123_1.var_[var_126_7 .. "Animator"].transform, false)
			end

			local var_126_8 = 0.001

			if var_126_6 <= arg_123_1.time_ and arg_123_1.time_ < var_126_6 + var_126_8 then
				local var_126_9 = (arg_123_1.time_ - var_126_6) / var_126_8
				local var_126_10 = Vector3.New(-0.7, -0.985, -6.22)

				var_126_5.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1284ui_story, var_126_10, var_126_9)

				local var_126_11 = manager.ui.mainCamera.transform.position - var_126_5.position

				var_126_5.forward = Vector3.New(var_126_11.x, var_126_11.y, var_126_11.z)

				local var_126_12 = var_126_5.localEulerAngles

				var_126_12.z = 0
				var_126_12.x = 0
				var_126_5.localEulerAngles = var_126_12
			end

			if arg_123_1.time_ >= var_126_6 + var_126_8 and arg_123_1.time_ < var_126_6 + var_126_8 + arg_126_0 then
				var_126_5.localPosition = Vector3.New(-0.7, -0.985, -6.22)

				local var_126_13 = manager.ui.mainCamera.transform.position - var_126_5.position

				var_126_5.forward = Vector3.New(var_126_13.x, var_126_13.y, var_126_13.z)

				local var_126_14 = var_126_5.localEulerAngles

				var_126_14.z = 0
				var_126_14.x = 0
				var_126_5.localEulerAngles = var_126_14
			end

			local var_126_15 = arg_123_1.actors_["1284ui_story"]
			local var_126_16 = 0

			if var_126_16 < arg_123_1.time_ and arg_123_1.time_ <= var_126_16 + arg_126_0 and not isNil(var_126_15) and arg_123_1.var_.characterEffect1284ui_story == nil then
				arg_123_1.var_.characterEffect1284ui_story = var_126_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_17 = 0.200000002980232

			if var_126_16 <= arg_123_1.time_ and arg_123_1.time_ < var_126_16 + var_126_17 and not isNil(var_126_15) then
				local var_126_18 = (arg_123_1.time_ - var_126_16) / var_126_17

				if arg_123_1.var_.characterEffect1284ui_story and not isNil(var_126_15) then
					arg_123_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= var_126_16 + var_126_17 and arg_123_1.time_ < var_126_16 + var_126_17 + arg_126_0 and not isNil(var_126_15) and arg_123_1.var_.characterEffect1284ui_story then
				arg_123_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_126_19 = 0

			if var_126_19 < arg_123_1.time_ and arg_123_1.time_ <= var_126_19 + arg_126_0 then
				arg_123_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			local var_126_20 = 0

			if var_126_20 < arg_123_1.time_ and arg_123_1.time_ <= var_126_20 + arg_126_0 then
				arg_123_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_126_21 = 0
			local var_126_22 = 0.25

			if var_126_21 < arg_123_1.time_ and arg_123_1.time_ <= var_126_21 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				local var_126_23 = arg_123_1:FormatText(StoryNameCfg[6].name)

				arg_123_1.leftNameTxt_.text = var_126_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_24 = arg_123_1:GetWordFromCfg(322141029)
				local var_126_25 = arg_123_1:FormatText(var_126_24.content)

				arg_123_1.text_.text = var_126_25

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_26 = 8
				local var_126_27 = utf8.len(var_126_25)
				local var_126_28 = var_126_26 <= 0 and var_126_22 or var_126_22 * (var_126_27 / var_126_26)

				if var_126_28 > 0 and var_126_22 < var_126_28 then
					arg_123_1.talkMaxDuration = var_126_28

					if var_126_28 + var_126_21 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_28 + var_126_21
					end
				end

				arg_123_1.text_.text = var_126_25
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141029", "story_v_out_322141.awb") ~= 0 then
					local var_126_29 = manager.audio:GetVoiceLength("story_v_out_322141", "322141029", "story_v_out_322141.awb") / 1000

					if var_126_29 + var_126_21 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_29 + var_126_21
					end

					if var_126_24.prefab_name ~= "" and arg_123_1.actors_[var_126_24.prefab_name] ~= nil then
						local var_126_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_24.prefab_name].transform, "story_v_out_322141", "322141029", "story_v_out_322141.awb")

						arg_123_1:RecordAudio("322141029", var_126_30)
						arg_123_1:RecordAudio("322141029", var_126_30)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_322141", "322141029", "story_v_out_322141.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_322141", "322141029", "story_v_out_322141.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_31 = math.max(var_126_22, arg_123_1.talkMaxDuration)

			if var_126_21 <= arg_123_1.time_ and arg_123_1.time_ < var_126_21 + var_126_31 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_21) / var_126_31

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_21 + var_126_31 and arg_123_1.time_ < var_126_21 + var_126_31 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
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

		arg_123_1:InitPlayNodeList()
	end,
	Play322141030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 322141030
		arg_127_1.duration_ = 4.7

		local var_127_0 = {
			zh = 4.2,
			ja = 4.7
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play322141031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = "404001ui_story"

			if arg_127_1.actors_[var_130_0] == nil then
				local var_130_1 = Asset.Load("Char/" .. "404001ui_story")

				if not isNil(var_130_1) then
					local var_130_2 = Object.Instantiate(Asset.Load("Char/" .. "404001ui_story"), arg_127_1.stage_.transform)

					var_130_2.name = var_130_0
					var_130_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_127_1.actors_[var_130_0] = var_130_2

					local var_130_3 = var_130_2:GetComponentInChildren(typeof(CharacterEffect))

					var_130_3.enabled = true

					local var_130_4 = GameObjectTools.GetOrAddComponent(var_130_2, typeof(DynamicBoneHelper))

					if var_130_4 then
						var_130_4:EnableDynamicBone(false)
					end

					arg_127_1:ShowWeapon(var_130_3.transform, false)

					arg_127_1.var_[var_130_0 .. "Animator"] = var_130_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_127_1.var_[var_130_0 .. "Animator"].applyRootMotion = true
					arg_127_1.var_[var_130_0 .. "LipSync"] = var_130_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_130_5 = arg_127_1.actors_["404001ui_story"].transform
			local var_130_6 = 0

			if var_130_6 < arg_127_1.time_ and arg_127_1.time_ <= var_130_6 + arg_130_0 then
				arg_127_1.var_.moveOldPos404001ui_story = var_130_5.localPosition
			end

			local var_130_7 = 0.001

			if var_130_6 <= arg_127_1.time_ and arg_127_1.time_ < var_130_6 + var_130_7 then
				local var_130_8 = (arg_127_1.time_ - var_130_6) / var_130_7
				local var_130_9 = Vector3.New(0.8, -1.55, -5.5)

				var_130_5.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos404001ui_story, var_130_9, var_130_8)

				local var_130_10 = manager.ui.mainCamera.transform.position - var_130_5.position

				var_130_5.forward = Vector3.New(var_130_10.x, var_130_10.y, var_130_10.z)

				local var_130_11 = var_130_5.localEulerAngles

				var_130_11.z = 0
				var_130_11.x = 0
				var_130_5.localEulerAngles = var_130_11
			end

			if arg_127_1.time_ >= var_130_6 + var_130_7 and arg_127_1.time_ < var_130_6 + var_130_7 + arg_130_0 then
				var_130_5.localPosition = Vector3.New(0.8, -1.55, -5.5)

				local var_130_12 = manager.ui.mainCamera.transform.position - var_130_5.position

				var_130_5.forward = Vector3.New(var_130_12.x, var_130_12.y, var_130_12.z)

				local var_130_13 = var_130_5.localEulerAngles

				var_130_13.z = 0
				var_130_13.x = 0
				var_130_5.localEulerAngles = var_130_13
			end

			local var_130_14 = arg_127_1.actors_["404001ui_story"]
			local var_130_15 = 0

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 and not isNil(var_130_14) and arg_127_1.var_.characterEffect404001ui_story == nil then
				arg_127_1.var_.characterEffect404001ui_story = var_130_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_16 = 0.200000002980232

			if var_130_15 <= arg_127_1.time_ and arg_127_1.time_ < var_130_15 + var_130_16 and not isNil(var_130_14) then
				local var_130_17 = (arg_127_1.time_ - var_130_15) / var_130_16

				if arg_127_1.var_.characterEffect404001ui_story and not isNil(var_130_14) then
					arg_127_1.var_.characterEffect404001ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_15 + var_130_16 and arg_127_1.time_ < var_130_15 + var_130_16 + arg_130_0 and not isNil(var_130_14) and arg_127_1.var_.characterEffect404001ui_story then
				arg_127_1.var_.characterEffect404001ui_story.fillFlat = false
			end

			local var_130_18 = arg_127_1.actors_["1284ui_story"]
			local var_130_19 = 0

			if var_130_19 < arg_127_1.time_ and arg_127_1.time_ <= var_130_19 + arg_130_0 and not isNil(var_130_18) and arg_127_1.var_.characterEffect1284ui_story == nil then
				arg_127_1.var_.characterEffect1284ui_story = var_130_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_20 = 0.200000002980232

			if var_130_19 <= arg_127_1.time_ and arg_127_1.time_ < var_130_19 + var_130_20 and not isNil(var_130_18) then
				local var_130_21 = (arg_127_1.time_ - var_130_19) / var_130_20

				if arg_127_1.var_.characterEffect1284ui_story and not isNil(var_130_18) then
					local var_130_22 = Mathf.Lerp(0, 0.5, var_130_21)

					arg_127_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1284ui_story.fillRatio = var_130_22
				end
			end

			if arg_127_1.time_ >= var_130_19 + var_130_20 and arg_127_1.time_ < var_130_19 + var_130_20 + arg_130_0 and not isNil(var_130_18) and arg_127_1.var_.characterEffect1284ui_story then
				local var_130_23 = 0.5

				arg_127_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1284ui_story.fillRatio = var_130_23
			end

			local var_130_24 = 0

			if var_130_24 < arg_127_1.time_ and arg_127_1.time_ <= var_130_24 + arg_130_0 then
				arg_127_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			local var_130_25 = 0

			if var_130_25 < arg_127_1.time_ and arg_127_1.time_ <= var_130_25 + arg_130_0 then
				arg_127_1:PlayTimeline("404001ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_130_26 = 0
			local var_130_27 = 0.45

			if var_130_26 < arg_127_1.time_ and arg_127_1.time_ <= var_130_26 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_28 = arg_127_1:FormatText(StoryNameCfg[668].name)

				arg_127_1.leftNameTxt_.text = var_130_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_29 = arg_127_1:GetWordFromCfg(322141030)
				local var_130_30 = arg_127_1:FormatText(var_130_29.content)

				arg_127_1.text_.text = var_130_30

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_31 = 18
				local var_130_32 = utf8.len(var_130_30)
				local var_130_33 = var_130_31 <= 0 and var_130_27 or var_130_27 * (var_130_32 / var_130_31)

				if var_130_33 > 0 and var_130_27 < var_130_33 then
					arg_127_1.talkMaxDuration = var_130_33

					if var_130_33 + var_130_26 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_33 + var_130_26
					end
				end

				arg_127_1.text_.text = var_130_30
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141030", "story_v_out_322141.awb") ~= 0 then
					local var_130_34 = manager.audio:GetVoiceLength("story_v_out_322141", "322141030", "story_v_out_322141.awb") / 1000

					if var_130_34 + var_130_26 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_34 + var_130_26
					end

					if var_130_29.prefab_name ~= "" and arg_127_1.actors_[var_130_29.prefab_name] ~= nil then
						local var_130_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_29.prefab_name].transform, "story_v_out_322141", "322141030", "story_v_out_322141.awb")

						arg_127_1:RecordAudio("322141030", var_130_35)
						arg_127_1:RecordAudio("322141030", var_130_35)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_322141", "322141030", "story_v_out_322141.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_322141", "322141030", "story_v_out_322141.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_36 = math.max(var_130_27, arg_127_1.talkMaxDuration)

			if var_130_26 <= arg_127_1.time_ and arg_127_1.time_ < var_130_26 + var_130_36 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_26) / var_130_36

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_26 + var_130_36 and arg_127_1.time_ < var_130_26 + var_130_36 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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

		arg_127_1:InitPlayNodeList()
	end,
	Play322141031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 322141031
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play322141032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["404001ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos404001ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0, 100, 0)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos404001ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, 100, 0)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["1284ui_story"].transform
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 then
				arg_131_1.var_.moveOldPos1284ui_story = var_134_9.localPosition
			end

			local var_134_11 = 0.001

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11
				local var_134_13 = Vector3.New(0, 100, 0)

				var_134_9.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1284ui_story, var_134_13, var_134_12)

				local var_134_14 = manager.ui.mainCamera.transform.position - var_134_9.position

				var_134_9.forward = Vector3.New(var_134_14.x, var_134_14.y, var_134_14.z)

				local var_134_15 = var_134_9.localEulerAngles

				var_134_15.z = 0
				var_134_15.x = 0
				var_134_9.localEulerAngles = var_134_15
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 then
				var_134_9.localPosition = Vector3.New(0, 100, 0)

				local var_134_16 = manager.ui.mainCamera.transform.position - var_134_9.position

				var_134_9.forward = Vector3.New(var_134_16.x, var_134_16.y, var_134_16.z)

				local var_134_17 = var_134_9.localEulerAngles

				var_134_17.z = 0
				var_134_17.x = 0
				var_134_9.localEulerAngles = var_134_17
			end

			local var_134_18 = 0
			local var_134_19 = 1.2

			if var_134_18 < arg_131_1.time_ and arg_131_1.time_ <= var_134_18 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_20 = arg_131_1:GetWordFromCfg(322141031)
				local var_134_21 = arg_131_1:FormatText(var_134_20.content)

				arg_131_1.text_.text = var_134_21

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_22 = 49
				local var_134_23 = utf8.len(var_134_21)
				local var_134_24 = var_134_22 <= 0 and var_134_19 or var_134_19 * (var_134_23 / var_134_22)

				if var_134_24 > 0 and var_134_19 < var_134_24 then
					arg_131_1.talkMaxDuration = var_134_24

					if var_134_24 + var_134_18 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_24 + var_134_18
					end
				end

				arg_131_1.text_.text = var_134_21
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_25 = math.max(var_134_19, arg_131_1.talkMaxDuration)

			if var_134_18 <= arg_131_1.time_ and arg_131_1.time_ < var_134_18 + var_134_25 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_18) / var_134_25

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_18 + var_134_25 and arg_131_1.time_ < var_134_18 + var_134_25 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play322141032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 322141032
		arg_135_1.duration_ = 4.17

		local var_135_0 = {
			zh = 4.166,
			ja = 3.9
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
			arg_135_1.auto_ = false
		end

		function arg_135_1.playNext_(arg_137_0)
			arg_135_1.onStoryFinished_()
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["1044ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos1044ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(0, -1, -5.93)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos1044ui_story, var_138_4, var_138_3)

				local var_138_5 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_5.x, var_138_5.y, var_138_5.z)

				local var_138_6 = var_138_0.localEulerAngles

				var_138_6.z = 0
				var_138_6.x = 0
				var_138_0.localEulerAngles = var_138_6
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0, -1, -5.93)

				local var_138_7 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_7.x, var_138_7.y, var_138_7.z)

				local var_138_8 = var_138_0.localEulerAngles

				var_138_8.z = 0
				var_138_8.x = 0
				var_138_0.localEulerAngles = var_138_8
			end

			local var_138_9 = arg_135_1.actors_["1044ui_story"]
			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 and not isNil(var_138_9) and arg_135_1.var_.characterEffect1044ui_story == nil then
				arg_135_1.var_.characterEffect1044ui_story = var_138_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_11 = 0.200000002980232

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_11 and not isNil(var_138_9) then
				local var_138_12 = (arg_135_1.time_ - var_138_10) / var_138_11

				if arg_135_1.var_.characterEffect1044ui_story and not isNil(var_138_9) then
					arg_135_1.var_.characterEffect1044ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_10 + var_138_11 and arg_135_1.time_ < var_138_10 + var_138_11 + arg_138_0 and not isNil(var_138_9) and arg_135_1.var_.characterEffect1044ui_story then
				arg_135_1.var_.characterEffect1044ui_story.fillFlat = false
			end

			local var_138_13 = 0

			if var_138_13 < arg_135_1.time_ and arg_135_1.time_ <= var_138_13 + arg_138_0 then
				arg_135_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_138_14 = 0

			if var_138_14 < arg_135_1.time_ and arg_135_1.time_ <= var_138_14 + arg_138_0 then
				arg_135_1:PlayTimeline("1044ui_story", "StoryTimeline/CharAction/story1044/story1044action/1044action6_1")
			end

			local var_138_15 = 0
			local var_138_16 = 0.3

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_17 = arg_135_1:FormatText(StoryNameCfg[67].name)

				arg_135_1.leftNameTxt_.text = var_138_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_18 = arg_135_1:GetWordFromCfg(322141032)
				local var_138_19 = arg_135_1:FormatText(var_138_18.content)

				arg_135_1.text_.text = var_138_19

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_20 = 12
				local var_138_21 = utf8.len(var_138_19)
				local var_138_22 = var_138_20 <= 0 and var_138_16 or var_138_16 * (var_138_21 / var_138_20)

				if var_138_22 > 0 and var_138_16 < var_138_22 then
					arg_135_1.talkMaxDuration = var_138_22

					if var_138_22 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_22 + var_138_15
					end
				end

				arg_135_1.text_.text = var_138_19
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_322141", "322141032", "story_v_out_322141.awb") ~= 0 then
					local var_138_23 = manager.audio:GetVoiceLength("story_v_out_322141", "322141032", "story_v_out_322141.awb") / 1000

					if var_138_23 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_23 + var_138_15
					end

					if var_138_18.prefab_name ~= "" and arg_135_1.actors_[var_138_18.prefab_name] ~= nil then
						local var_138_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_18.prefab_name].transform, "story_v_out_322141", "322141032", "story_v_out_322141.awb")

						arg_135_1:RecordAudio("322141032", var_138_24)
						arg_135_1:RecordAudio("322141032", var_138_24)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_322141", "322141032", "story_v_out_322141.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_322141", "322141032", "story_v_out_322141.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_25 = math.max(var_138_16, arg_135_1.talkMaxDuration)

			if var_138_15 <= arg_135_1.time_ and arg_135_1.time_ < var_138_15 + var_138_25 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_15) / var_138_25

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_15 + var_138_25 and arg_135_1.time_ < var_138_15 + var_138_25 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L19i"
	},
	voices = {
		"story_v_out_322141.awb"
	}
}
