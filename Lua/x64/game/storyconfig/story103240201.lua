return {
	Play324021001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324021001
		arg_1_1.duration_ = 8.53

		local var_1_0 = {
			zh = 6.66733333518,
			ja = 8.533
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
				arg_1_0:Play324021002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST2003"

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
				local var_4_5 = arg_1_1.bgs_.ST2003

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
					if iter_4_0 ~= "ST2003" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

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

			local var_4_24 = "10171ui_story"

			if arg_1_1.actors_[var_4_24] == nil then
				local var_4_25 = Asset.Load("Char/" .. "10171ui_story")

				if not isNil(var_4_25) then
					local var_4_26 = Object.Instantiate(Asset.Load("Char/" .. "10171ui_story"), arg_1_1.stage_.transform)

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

			local var_4_29 = arg_1_1.actors_["10171ui_story"].transform
			local var_4_30 = 1.63333333333333

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.var_.moveOldPos10171ui_story = var_4_29.localPosition

				local var_4_31 = GameObjectTools.GetOrAddComponent(var_4_29.gameObject, typeof(DynamicBoneHelper))

				if var_4_31 then
					var_4_31:EnableDynamicBone(false)
				end
			end

			local var_4_32 = 0.001

			if var_4_30 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_32 then
				local var_4_33 = (arg_1_1.time_ - var_4_30) / var_4_32
				local var_4_34 = Vector3.New(0, -0.95, -6.05)

				var_4_29.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10171ui_story, var_4_34, var_4_33)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_29.position

				var_4_29.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_29.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_29.localEulerAngles = var_4_36
			end

			if arg_1_1.time_ >= var_4_30 + var_4_32 and arg_1_1.time_ < var_4_30 + var_4_32 + arg_4_0 then
				var_4_29.localPosition = Vector3.New(0, -0.95, -6.05)

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

			local var_4_40 = arg_1_1.actors_["10171ui_story"]
			local var_4_41 = 1.63333333333333

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect10171ui_story == nil then
				arg_1_1.var_.characterEffect10171ui_story = var_4_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_42 = 0.200000002980232

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.characterEffect10171ui_story and not isNil(var_4_40) then
					arg_1_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect10171ui_story then
				arg_1_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_4_44 = 1.63333333333333

			if var_4_44 < arg_1_1.time_ and arg_1_1.time_ <= var_4_44 + arg_4_0 then
				arg_1_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			local var_4_45 = 1.63333333333333

			if var_4_45 < arg_1_1.time_ and arg_1_1.time_ <= var_4_45 + arg_4_0 then
				arg_1_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_4_46 = arg_1_1.actors_["10171ui_story"]
			local var_4_47 = 1.63333333333333
			local var_4_48 = 5

			if var_4_47 < arg_1_1.time_ and arg_1_1.time_ <= var_4_47 + arg_4_0 then
				if arg_1_1.var_.characterEffect10171ui_story == nil then
					arg_1_1.var_.characterEffect10171ui_story = var_4_46:GetComponentInChildren(typeof(CharacterEffect))
				end

				arg_1_1.var_.characterEffect10171ui_story.imageEffect:turnOn(false)
			end

			local var_4_49 = arg_1_1.actors_["10171ui_story"]
			local var_4_50 = 1.66733333518108

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				if arg_1_1.var_.characterEffect10171ui_story == nil then
					arg_1_1.var_.characterEffect10171ui_story = var_4_49:GetComponentInChildren(typeof(CharacterEffect))
				end

				local var_4_51 = arg_1_1.var_.characterEffect10171ui_story

				var_4_51.imageEffect:turnOff()

				var_4_51.interferenceEffect.enabled = true
				var_4_51.interferenceEffect.noise = 0.001
				var_4_51.interferenceEffect.simTimeScale = 1
				var_4_51.interferenceEffect.geometryOutlineColor = Color.New(0.3725, 0.88, 1, 1)
			end

			local var_4_52 = 0.1
			local var_4_53 = 1

			if var_4_52 < arg_1_1.time_ and arg_1_1.time_ <= var_4_52 + arg_4_0 then
				local var_4_54 = "play"
				local var_4_55 = "effect"

				arg_1_1:AudioAction(var_4_54, var_4_55, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_4_56 = 0
			local var_4_57 = 1

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				local var_4_58 = "play"
				local var_4_59 = "effect"

				arg_1_1:AudioAction(var_4_58, var_4_59, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_60 = 1
			local var_4_61 = 1

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				local var_4_62 = "play"
				local var_4_63 = "music"

				arg_1_1:AudioAction(var_4_62, var_4_63, "bgm_activity_4_8_story_ruomugong", "bgm_activity_4_8_story_ruomugong", "bgm_activity_4_8_story_ruomugong.awb")

				local var_4_64 = ""
				local var_4_65 = manager.audio:GetAudioName("bgm_activity_4_8_story_ruomugong", "bgm_activity_4_8_story_ruomugong")

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

			local var_4_66 = 1.9
			local var_4_67 = 0.475

			if var_4_66 < arg_1_1.time_ and arg_1_1.time_ <= var_4_66 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_68 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_68:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_68:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_68:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_69 = arg_1_1:FormatText(StoryNameCfg[1451].name)

				arg_1_1.leftNameTxt_.text = var_4_69

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_70 = arg_1_1:GetWordFromCfg(324021001)
				local var_4_71 = arg_1_1:FormatText(var_4_70.content)

				arg_1_1.text_.text = var_4_71

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_72 = 19
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

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021001", "story_v_out_324021.awb") ~= 0 then
					local var_4_75 = manager.audio:GetVoiceLength("story_v_out_324021", "324021001", "story_v_out_324021.awb") / 1000

					if var_4_75 + var_4_66 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_75 + var_4_66
					end

					if var_4_70.prefab_name ~= "" and arg_1_1.actors_[var_4_70.prefab_name] ~= nil then
						local var_4_76 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_70.prefab_name].transform, "story_v_out_324021", "324021001", "story_v_out_324021.awb")

						arg_1_1:RecordAudio("324021001", var_4_76)
						arg_1_1:RecordAudio("324021001", var_4_76)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324021", "324021001", "story_v_out_324021.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324021", "324021001", "story_v_out_324021.awb")
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
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.63333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play324021002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324021002
		arg_8_1.duration_ = 11.57

		local var_8_0 = {
			zh = 6.366,
			ja = 11.566
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324021003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["10171ui_story"].transform
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.var_.moveOldPos10171ui_story = var_11_0.localPosition

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0.gameObject, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end
			end

			local var_11_3 = 0.001

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_3 then
				local var_11_4 = (arg_8_1.time_ - var_11_1) / var_11_3
				local var_11_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_11_0.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10171ui_story, var_11_5, var_11_4)

				local var_11_6 = manager.ui.mainCamera.transform.position - var_11_0.position

				var_11_0.forward = Vector3.New(var_11_6.x, var_11_6.y, var_11_6.z)

				local var_11_7 = var_11_0.localEulerAngles

				var_11_7.z = 0
				var_11_7.x = 0
				var_11_0.localEulerAngles = var_11_7
			end

			if arg_8_1.time_ >= var_11_1 + var_11_3 and arg_8_1.time_ < var_11_1 + var_11_3 + arg_11_0 then
				var_11_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_11_8 = manager.ui.mainCamera.transform.position - var_11_0.position

				var_11_0.forward = Vector3.New(var_11_8.x, var_11_8.y, var_11_8.z)

				local var_11_9 = var_11_0.localEulerAngles

				var_11_9.z = 0
				var_11_9.x = 0
				var_11_0.localEulerAngles = var_11_9

				local var_11_10 = GameObjectTools.GetOrAddComponent(var_11_0.gameObject, typeof(DynamicBoneHelper))

				if var_11_10 then
					var_11_10:EnableDynamicBone(true)
				end
			end

			local var_11_11 = "1070ui_story"

			if arg_8_1.actors_[var_11_11] == nil then
				local var_11_12 = Asset.Load("Char/" .. "1070ui_story")

				if not isNil(var_11_12) then
					local var_11_13 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_8_1.stage_.transform)

					var_11_13.name = var_11_11
					var_11_13.transform.localPosition = Vector3.New(0, 100, 0)
					arg_8_1.actors_[var_11_11] = var_11_13

					local var_11_14 = var_11_13:GetComponentInChildren(typeof(CharacterEffect))

					var_11_14.enabled = true

					local var_11_15 = GameObjectTools.GetOrAddComponent(var_11_13, typeof(DynamicBoneHelper))

					if var_11_15 then
						var_11_15:EnableDynamicBone(false)
					end

					arg_8_1:ShowWeapon(var_11_14.transform, false)

					arg_8_1.var_[var_11_11 .. "Animator"] = var_11_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_8_1.var_[var_11_11 .. "Animator"].applyRootMotion = true
					arg_8_1.var_[var_11_11 .. "LipSync"] = var_11_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_11_16 = arg_8_1.actors_["1070ui_story"].transform
			local var_11_17 = 0

			if var_11_17 < arg_8_1.time_ and arg_8_1.time_ <= var_11_17 + arg_11_0 then
				arg_8_1.var_.moveOldPos1070ui_story = var_11_16.localPosition
			end

			local var_11_18 = 0.001

			if var_11_17 <= arg_8_1.time_ and arg_8_1.time_ < var_11_17 + var_11_18 then
				local var_11_19 = (arg_8_1.time_ - var_11_17) / var_11_18
				local var_11_20 = Vector3.New(0.7, -0.95, -6.05)

				var_11_16.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1070ui_story, var_11_20, var_11_19)

				local var_11_21 = manager.ui.mainCamera.transform.position - var_11_16.position

				var_11_16.forward = Vector3.New(var_11_21.x, var_11_21.y, var_11_21.z)

				local var_11_22 = var_11_16.localEulerAngles

				var_11_22.z = 0
				var_11_22.x = 0
				var_11_16.localEulerAngles = var_11_22
			end

			if arg_8_1.time_ >= var_11_17 + var_11_18 and arg_8_1.time_ < var_11_17 + var_11_18 + arg_11_0 then
				var_11_16.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_11_23 = manager.ui.mainCamera.transform.position - var_11_16.position

				var_11_16.forward = Vector3.New(var_11_23.x, var_11_23.y, var_11_23.z)

				local var_11_24 = var_11_16.localEulerAngles

				var_11_24.z = 0
				var_11_24.x = 0
				var_11_16.localEulerAngles = var_11_24
			end

			local var_11_25 = arg_8_1.actors_["1070ui_story"]
			local var_11_26 = 0

			if var_11_26 < arg_8_1.time_ and arg_8_1.time_ <= var_11_26 + arg_11_0 and not isNil(var_11_25) and arg_8_1.var_.characterEffect1070ui_story == nil then
				arg_8_1.var_.characterEffect1070ui_story = var_11_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_27 = 0.200000002980232

			if var_11_26 <= arg_8_1.time_ and arg_8_1.time_ < var_11_26 + var_11_27 and not isNil(var_11_25) then
				local var_11_28 = (arg_8_1.time_ - var_11_26) / var_11_27

				if arg_8_1.var_.characterEffect1070ui_story and not isNil(var_11_25) then
					arg_8_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= var_11_26 + var_11_27 and arg_8_1.time_ < var_11_26 + var_11_27 + arg_11_0 and not isNil(var_11_25) and arg_8_1.var_.characterEffect1070ui_story then
				arg_8_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_11_29 = arg_8_1.actors_["10171ui_story"]
			local var_11_30 = 0

			if var_11_30 < arg_8_1.time_ and arg_8_1.time_ <= var_11_30 + arg_11_0 and not isNil(var_11_29) and arg_8_1.var_.characterEffect10171ui_story == nil then
				arg_8_1.var_.characterEffect10171ui_story = var_11_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_31 = 0.200000002980232

			if var_11_30 <= arg_8_1.time_ and arg_8_1.time_ < var_11_30 + var_11_31 and not isNil(var_11_29) then
				local var_11_32 = (arg_8_1.time_ - var_11_30) / var_11_31

				if arg_8_1.var_.characterEffect10171ui_story and not isNil(var_11_29) then
					local var_11_33 = Mathf.Lerp(0, 0.5, var_11_32)

					arg_8_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_8_1.var_.characterEffect10171ui_story.fillRatio = var_11_33
				end
			end

			if arg_8_1.time_ >= var_11_30 + var_11_31 and arg_8_1.time_ < var_11_30 + var_11_31 + arg_11_0 and not isNil(var_11_29) and arg_8_1.var_.characterEffect10171ui_story then
				local var_11_34 = 0.5

				arg_8_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_8_1.var_.characterEffect10171ui_story.fillRatio = var_11_34
			end

			local var_11_35 = 0

			if var_11_35 < arg_8_1.time_ and arg_8_1.time_ <= var_11_35 + arg_11_0 then
				arg_8_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			local var_11_36 = 0

			if var_11_36 < arg_8_1.time_ and arg_8_1.time_ <= var_11_36 + arg_11_0 then
				arg_8_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_11_37 = 0
			local var_11_38 = 0.9

			if var_11_37 < arg_8_1.time_ and arg_8_1.time_ <= var_11_37 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_39 = arg_8_1:FormatText(StoryNameCfg[318].name)

				arg_8_1.leftNameTxt_.text = var_11_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_40 = arg_8_1:GetWordFromCfg(324021002)
				local var_11_41 = arg_8_1:FormatText(var_11_40.content)

				arg_8_1.text_.text = var_11_41

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_42 = 36
				local var_11_43 = utf8.len(var_11_41)
				local var_11_44 = var_11_42 <= 0 and var_11_38 or var_11_38 * (var_11_43 / var_11_42)

				if var_11_44 > 0 and var_11_38 < var_11_44 then
					arg_8_1.talkMaxDuration = var_11_44

					if var_11_44 + var_11_37 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_44 + var_11_37
					end
				end

				arg_8_1.text_.text = var_11_41
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021002", "story_v_out_324021.awb") ~= 0 then
					local var_11_45 = manager.audio:GetVoiceLength("story_v_out_324021", "324021002", "story_v_out_324021.awb") / 1000

					if var_11_45 + var_11_37 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_45 + var_11_37
					end

					if var_11_40.prefab_name ~= "" and arg_8_1.actors_[var_11_40.prefab_name] ~= nil then
						local var_11_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_40.prefab_name].transform, "story_v_out_324021", "324021002", "story_v_out_324021.awb")

						arg_8_1:RecordAudio("324021002", var_11_46)
						arg_8_1:RecordAudio("324021002", var_11_46)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324021", "324021002", "story_v_out_324021.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324021", "324021002", "story_v_out_324021.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_47 = math.max(var_11_38, arg_8_1.talkMaxDuration)

			if var_11_37 <= arg_8_1.time_ and arg_8_1.time_ < var_11_37 + var_11_47 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_37) / var_11_47

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_37 + var_11_47 and arg_8_1.time_ < var_11_37 + var_11_47 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play324021003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324021003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324021004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["1070ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1070ui_story == nil then
				arg_12_1.var_.characterEffect1070ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.200000002980232

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect1070ui_story and not isNil(var_15_0) then
					local var_15_4 = Mathf.Lerp(0, 0.5, var_15_3)

					arg_12_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1070ui_story.fillRatio = var_15_4
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect1070ui_story then
				local var_15_5 = 0.5

				arg_12_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1070ui_story.fillRatio = var_15_5
			end

			local var_15_6 = 0
			local var_15_7 = 0.8

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_8 = arg_12_1:GetWordFromCfg(324021003)
				local var_15_9 = arg_12_1:FormatText(var_15_8.content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_10 = 32
				local var_15_11 = utf8.len(var_15_9)
				local var_15_12 = var_15_10 <= 0 and var_15_7 or var_15_7 * (var_15_11 / var_15_10)

				if var_15_12 > 0 and var_15_7 < var_15_12 then
					arg_12_1.talkMaxDuration = var_15_12

					if var_15_12 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_9
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_13 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_13 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_13

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_13 and arg_12_1.time_ < var_15_6 + var_15_13 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324021004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324021004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324021005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10171ui_story"].transform
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.var_.moveOldPos10171ui_story = var_19_0.localPosition

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end
			end

			local var_19_3 = 0.001

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_3 then
				local var_19_4 = (arg_16_1.time_ - var_19_1) / var_19_3
				local var_19_5 = Vector3.New(0, 100, 0)

				var_19_0.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10171ui_story, var_19_5, var_19_4)

				local var_19_6 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_6.x, var_19_6.y, var_19_6.z)

				local var_19_7 = var_19_0.localEulerAngles

				var_19_7.z = 0
				var_19_7.x = 0
				var_19_0.localEulerAngles = var_19_7
			end

			if arg_16_1.time_ >= var_19_1 + var_19_3 and arg_16_1.time_ < var_19_1 + var_19_3 + arg_19_0 then
				var_19_0.localPosition = Vector3.New(0, 100, 0)

				local var_19_8 = manager.ui.mainCamera.transform.position - var_19_0.position

				var_19_0.forward = Vector3.New(var_19_8.x, var_19_8.y, var_19_8.z)

				local var_19_9 = var_19_0.localEulerAngles

				var_19_9.z = 0
				var_19_9.x = 0
				var_19_0.localEulerAngles = var_19_9

				local var_19_10 = GameObjectTools.GetOrAddComponent(var_19_0.gameObject, typeof(DynamicBoneHelper))

				if var_19_10 then
					var_19_10:EnableDynamicBone(true)
				end
			end

			local var_19_11 = arg_16_1.actors_["1070ui_story"].transform
			local var_19_12 = 0

			if var_19_12 < arg_16_1.time_ and arg_16_1.time_ <= var_19_12 + arg_19_0 then
				arg_16_1.var_.moveOldPos1070ui_story = var_19_11.localPosition
			end

			local var_19_13 = 0.001

			if var_19_12 <= arg_16_1.time_ and arg_16_1.time_ < var_19_12 + var_19_13 then
				local var_19_14 = (arg_16_1.time_ - var_19_12) / var_19_13
				local var_19_15 = Vector3.New(0, 100, 0)

				var_19_11.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1070ui_story, var_19_15, var_19_14)

				local var_19_16 = manager.ui.mainCamera.transform.position - var_19_11.position

				var_19_11.forward = Vector3.New(var_19_16.x, var_19_16.y, var_19_16.z)

				local var_19_17 = var_19_11.localEulerAngles

				var_19_17.z = 0
				var_19_17.x = 0
				var_19_11.localEulerAngles = var_19_17
			end

			if arg_16_1.time_ >= var_19_12 + var_19_13 and arg_16_1.time_ < var_19_12 + var_19_13 + arg_19_0 then
				var_19_11.localPosition = Vector3.New(0, 100, 0)

				local var_19_18 = manager.ui.mainCamera.transform.position - var_19_11.position

				var_19_11.forward = Vector3.New(var_19_18.x, var_19_18.y, var_19_18.z)

				local var_19_19 = var_19_11.localEulerAngles

				var_19_19.z = 0
				var_19_19.x = 0
				var_19_11.localEulerAngles = var_19_19
			end

			local var_19_20 = 0
			local var_19_21 = 1.075

			if var_19_20 < arg_16_1.time_ and arg_16_1.time_ <= var_19_20 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_22 = arg_16_1:GetWordFromCfg(324021004)
				local var_19_23 = arg_16_1:FormatText(var_19_22.content)

				arg_16_1.text_.text = var_19_23

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_24 = 43
				local var_19_25 = utf8.len(var_19_23)
				local var_19_26 = var_19_24 <= 0 and var_19_21 or var_19_21 * (var_19_25 / var_19_24)

				if var_19_26 > 0 and var_19_21 < var_19_26 then
					arg_16_1.talkMaxDuration = var_19_26

					if var_19_26 + var_19_20 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_26 + var_19_20
					end
				end

				arg_16_1.text_.text = var_19_23
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_27 = math.max(var_19_21, arg_16_1.talkMaxDuration)

			if var_19_20 <= arg_16_1.time_ and arg_16_1.time_ < var_19_20 + var_19_27 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_20) / var_19_27

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_20 + var_19_27 and arg_16_1.time_ < var_19_20 + var_19_27 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play324021005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324021005
		arg_20_1.duration_ = 7.37

		local var_20_0 = {
			zh = 6.3,
			ja = 7.366
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324021006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = arg_20_1.actors_["1070ui_story"].transform
			local var_23_1 = 0

			if var_23_1 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.var_.moveOldPos1070ui_story = var_23_0.localPosition
			end

			local var_23_2 = 0.001

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_2 then
				local var_23_3 = (arg_20_1.time_ - var_23_1) / var_23_2
				local var_23_4 = Vector3.New(0.7, -0.95, -6.05)

				var_23_0.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1070ui_story, var_23_4, var_23_3)

				local var_23_5 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_5.x, var_23_5.y, var_23_5.z)

				local var_23_6 = var_23_0.localEulerAngles

				var_23_6.z = 0
				var_23_6.x = 0
				var_23_0.localEulerAngles = var_23_6
			end

			if arg_20_1.time_ >= var_23_1 + var_23_2 and arg_20_1.time_ < var_23_1 + var_23_2 + arg_23_0 then
				var_23_0.localPosition = Vector3.New(0.7, -0.95, -6.05)

				local var_23_7 = manager.ui.mainCamera.transform.position - var_23_0.position

				var_23_0.forward = Vector3.New(var_23_7.x, var_23_7.y, var_23_7.z)

				local var_23_8 = var_23_0.localEulerAngles

				var_23_8.z = 0
				var_23_8.x = 0
				var_23_0.localEulerAngles = var_23_8
			end

			local var_23_9 = arg_20_1.actors_["1070ui_story"]
			local var_23_10 = 0

			if var_23_10 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1070ui_story == nil then
				arg_20_1.var_.characterEffect1070ui_story = var_23_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_11 = 0.200000002980232

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_11 and not isNil(var_23_9) then
				local var_23_12 = (arg_20_1.time_ - var_23_10) / var_23_11

				if arg_20_1.var_.characterEffect1070ui_story and not isNil(var_23_9) then
					arg_20_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= var_23_10 + var_23_11 and arg_20_1.time_ < var_23_10 + var_23_11 + arg_23_0 and not isNil(var_23_9) and arg_20_1.var_.characterEffect1070ui_story then
				arg_20_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_23_13 = 0

			if var_23_13 < arg_20_1.time_ and arg_20_1.time_ <= var_23_13 + arg_23_0 then
				arg_20_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_23_14 = 0

			if var_23_14 < arg_20_1.time_ and arg_20_1.time_ <= var_23_14 + arg_23_0 then
				arg_20_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_23_15 = 0
			local var_23_16 = 0.65

			if var_23_15 < arg_20_1.time_ and arg_20_1.time_ <= var_23_15 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_17 = arg_20_1:FormatText(StoryNameCfg[318].name)

				arg_20_1.leftNameTxt_.text = var_23_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_18 = arg_20_1:GetWordFromCfg(324021005)
				local var_23_19 = arg_20_1:FormatText(var_23_18.content)

				arg_20_1.text_.text = var_23_19

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_20 = 26
				local var_23_21 = utf8.len(var_23_19)
				local var_23_22 = var_23_20 <= 0 and var_23_16 or var_23_16 * (var_23_21 / var_23_20)

				if var_23_22 > 0 and var_23_16 < var_23_22 then
					arg_20_1.talkMaxDuration = var_23_22

					if var_23_22 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_22 + var_23_15
					end
				end

				arg_20_1.text_.text = var_23_19
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021005", "story_v_out_324021.awb") ~= 0 then
					local var_23_23 = manager.audio:GetVoiceLength("story_v_out_324021", "324021005", "story_v_out_324021.awb") / 1000

					if var_23_23 + var_23_15 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_23 + var_23_15
					end

					if var_23_18.prefab_name ~= "" and arg_20_1.actors_[var_23_18.prefab_name] ~= nil then
						local var_23_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_18.prefab_name].transform, "story_v_out_324021", "324021005", "story_v_out_324021.awb")

						arg_20_1:RecordAudio("324021005", var_23_24)
						arg_20_1:RecordAudio("324021005", var_23_24)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_324021", "324021005", "story_v_out_324021.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_324021", "324021005", "story_v_out_324021.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_25 = math.max(var_23_16, arg_20_1.talkMaxDuration)

			if var_23_15 <= arg_20_1.time_ and arg_20_1.time_ < var_23_15 + var_23_25 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_15) / var_23_25

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_15 + var_23_25 and arg_20_1.time_ < var_23_15 + var_23_25 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play324021006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324021006
		arg_24_1.duration_ = 3.03

		local var_24_0 = {
			zh = 2.633,
			ja = 3.033
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
				arg_24_0:Play324021007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10171ui_story"].transform
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.var_.moveOldPos10171ui_story = var_27_0.localPosition

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end
			end

			local var_27_3 = 0.001

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_3 then
				local var_27_4 = (arg_24_1.time_ - var_27_1) / var_27_3
				local var_27_5 = Vector3.New(-0.7, -0.95, -6.05)

				var_27_0.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10171ui_story, var_27_5, var_27_4)

				local var_27_6 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_6.x, var_27_6.y, var_27_6.z)

				local var_27_7 = var_27_0.localEulerAngles

				var_27_7.z = 0
				var_27_7.x = 0
				var_27_0.localEulerAngles = var_27_7
			end

			if arg_24_1.time_ >= var_27_1 + var_27_3 and arg_24_1.time_ < var_27_1 + var_27_3 + arg_27_0 then
				var_27_0.localPosition = Vector3.New(-0.7, -0.95, -6.05)

				local var_27_8 = manager.ui.mainCamera.transform.position - var_27_0.position

				var_27_0.forward = Vector3.New(var_27_8.x, var_27_8.y, var_27_8.z)

				local var_27_9 = var_27_0.localEulerAngles

				var_27_9.z = 0
				var_27_9.x = 0
				var_27_0.localEulerAngles = var_27_9

				local var_27_10 = GameObjectTools.GetOrAddComponent(var_27_0.gameObject, typeof(DynamicBoneHelper))

				if var_27_10 then
					var_27_10:EnableDynamicBone(true)
				end
			end

			local var_27_11 = arg_24_1.actors_["10171ui_story"]
			local var_27_12 = 0

			if var_27_12 < arg_24_1.time_ and arg_24_1.time_ <= var_27_12 + arg_27_0 and not isNil(var_27_11) and arg_24_1.var_.characterEffect10171ui_story == nil then
				arg_24_1.var_.characterEffect10171ui_story = var_27_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_13 = 0.200000002980232

			if var_27_12 <= arg_24_1.time_ and arg_24_1.time_ < var_27_12 + var_27_13 and not isNil(var_27_11) then
				local var_27_14 = (arg_24_1.time_ - var_27_12) / var_27_13

				if arg_24_1.var_.characterEffect10171ui_story and not isNil(var_27_11) then
					arg_24_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_12 + var_27_13 and arg_24_1.time_ < var_27_12 + var_27_13 + arg_27_0 and not isNil(var_27_11) and arg_24_1.var_.characterEffect10171ui_story then
				arg_24_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_27_15 = arg_24_1.actors_["1070ui_story"]
			local var_27_16 = 0

			if var_27_16 < arg_24_1.time_ and arg_24_1.time_ <= var_27_16 + arg_27_0 and not isNil(var_27_15) and arg_24_1.var_.characterEffect1070ui_story == nil then
				arg_24_1.var_.characterEffect1070ui_story = var_27_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_17 = 0.200000002980232

			if var_27_16 <= arg_24_1.time_ and arg_24_1.time_ < var_27_16 + var_27_17 and not isNil(var_27_15) then
				local var_27_18 = (arg_24_1.time_ - var_27_16) / var_27_17

				if arg_24_1.var_.characterEffect1070ui_story and not isNil(var_27_15) then
					local var_27_19 = Mathf.Lerp(0, 0.5, var_27_18)

					arg_24_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1070ui_story.fillRatio = var_27_19
				end
			end

			if arg_24_1.time_ >= var_27_16 + var_27_17 and arg_24_1.time_ < var_27_16 + var_27_17 + arg_27_0 and not isNil(var_27_15) and arg_24_1.var_.characterEffect1070ui_story then
				local var_27_20 = 0.5

				arg_24_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1070ui_story.fillRatio = var_27_20
			end

			local var_27_21 = 0

			if var_27_21 < arg_24_1.time_ and arg_24_1.time_ <= var_27_21 + arg_27_0 then
				arg_24_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_1")
			end

			local var_27_22 = 0

			if var_27_22 < arg_24_1.time_ and arg_24_1.time_ <= var_27_22 + arg_27_0 then
				arg_24_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_27_23 = 0
			local var_27_24 = 0.325

			if var_27_23 < arg_24_1.time_ and arg_24_1.time_ <= var_27_23 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_25 = arg_24_1:FormatText(StoryNameCfg[1451].name)

				arg_24_1.leftNameTxt_.text = var_27_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_26 = arg_24_1:GetWordFromCfg(324021006)
				local var_27_27 = arg_24_1:FormatText(var_27_26.content)

				arg_24_1.text_.text = var_27_27

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_28 = 13
				local var_27_29 = utf8.len(var_27_27)
				local var_27_30 = var_27_28 <= 0 and var_27_24 or var_27_24 * (var_27_29 / var_27_28)

				if var_27_30 > 0 and var_27_24 < var_27_30 then
					arg_24_1.talkMaxDuration = var_27_30

					if var_27_30 + var_27_23 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_30 + var_27_23
					end
				end

				arg_24_1.text_.text = var_27_27
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021006", "story_v_out_324021.awb") ~= 0 then
					local var_27_31 = manager.audio:GetVoiceLength("story_v_out_324021", "324021006", "story_v_out_324021.awb") / 1000

					if var_27_31 + var_27_23 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_31 + var_27_23
					end

					if var_27_26.prefab_name ~= "" and arg_24_1.actors_[var_27_26.prefab_name] ~= nil then
						local var_27_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_26.prefab_name].transform, "story_v_out_324021", "324021006", "story_v_out_324021.awb")

						arg_24_1:RecordAudio("324021006", var_27_32)
						arg_24_1:RecordAudio("324021006", var_27_32)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_324021", "324021006", "story_v_out_324021.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_324021", "324021006", "story_v_out_324021.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_33 = math.max(var_27_24, arg_24_1.talkMaxDuration)

			if var_27_23 <= arg_24_1.time_ and arg_24_1.time_ < var_27_23 + var_27_33 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_23) / var_27_33

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_23 + var_27_33 and arg_24_1.time_ < var_27_23 + var_27_33 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play324021007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324021007
		arg_28_1.duration_ = 8

		local var_28_0 = {
			zh = 8,
			ja = 7.366
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
				arg_28_0:Play324021008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["1070ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1070ui_story == nil then
				arg_28_1.var_.characterEffect1070ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect1070ui_story and not isNil(var_31_0) then
					arg_28_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect1070ui_story then
				arg_28_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_31_4 = arg_28_1.actors_["10171ui_story"]
			local var_31_5 = 0

			if var_31_5 < arg_28_1.time_ and arg_28_1.time_ <= var_31_5 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect10171ui_story == nil then
				arg_28_1.var_.characterEffect10171ui_story = var_31_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_6 = 0.200000002980232

			if var_31_5 <= arg_28_1.time_ and arg_28_1.time_ < var_31_5 + var_31_6 and not isNil(var_31_4) then
				local var_31_7 = (arg_28_1.time_ - var_31_5) / var_31_6

				if arg_28_1.var_.characterEffect10171ui_story and not isNil(var_31_4) then
					local var_31_8 = Mathf.Lerp(0, 0.5, var_31_7)

					arg_28_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10171ui_story.fillRatio = var_31_8
				end
			end

			if arg_28_1.time_ >= var_31_5 + var_31_6 and arg_28_1.time_ < var_31_5 + var_31_6 + arg_31_0 and not isNil(var_31_4) and arg_28_1.var_.characterEffect10171ui_story then
				local var_31_9 = 0.5

				arg_28_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10171ui_story.fillRatio = var_31_9
			end

			local var_31_10 = 0
			local var_31_11 = 0.9

			if var_31_10 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_12 = arg_28_1:FormatText(StoryNameCfg[318].name)

				arg_28_1.leftNameTxt_.text = var_31_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_13 = arg_28_1:GetWordFromCfg(324021007)
				local var_31_14 = arg_28_1:FormatText(var_31_13.content)

				arg_28_1.text_.text = var_31_14

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 36
				local var_31_16 = utf8.len(var_31_14)
				local var_31_17 = var_31_15 <= 0 and var_31_11 or var_31_11 * (var_31_16 / var_31_15)

				if var_31_17 > 0 and var_31_11 < var_31_17 then
					arg_28_1.talkMaxDuration = var_31_17

					if var_31_17 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_17 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_14
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021007", "story_v_out_324021.awb") ~= 0 then
					local var_31_18 = manager.audio:GetVoiceLength("story_v_out_324021", "324021007", "story_v_out_324021.awb") / 1000

					if var_31_18 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_10
					end

					if var_31_13.prefab_name ~= "" and arg_28_1.actors_[var_31_13.prefab_name] ~= nil then
						local var_31_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_13.prefab_name].transform, "story_v_out_324021", "324021007", "story_v_out_324021.awb")

						arg_28_1:RecordAudio("324021007", var_31_19)
						arg_28_1:RecordAudio("324021007", var_31_19)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324021", "324021007", "story_v_out_324021.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324021", "324021007", "story_v_out_324021.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_20 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_20 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_20

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_20 and arg_28_1.time_ < var_31_10 + var_31_20 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324021008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324021008
		arg_32_1.duration_ = 5.07

		local var_32_0 = {
			zh = 3.2,
			ja = 5.066
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
				arg_32_0:Play324021009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			local var_35_1 = 0

			if var_35_1 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_35_2 = 0
			local var_35_3 = 0.4

			if var_35_2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				local var_35_4 = arg_32_1:FormatText(StoryNameCfg[318].name)

				arg_32_1.leftNameTxt_.text = var_35_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_5 = arg_32_1:GetWordFromCfg(324021008)
				local var_35_6 = arg_32_1:FormatText(var_35_5.content)

				arg_32_1.text_.text = var_35_6

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 16
				local var_35_8 = utf8.len(var_35_6)
				local var_35_9 = var_35_7 <= 0 and var_35_3 or var_35_3 * (var_35_8 / var_35_7)

				if var_35_9 > 0 and var_35_3 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_2
					end
				end

				arg_32_1.text_.text = var_35_6
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021008", "story_v_out_324021.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_324021", "324021008", "story_v_out_324021.awb") / 1000

					if var_35_10 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_2
					end

					if var_35_5.prefab_name ~= "" and arg_32_1.actors_[var_35_5.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_5.prefab_name].transform, "story_v_out_324021", "324021008", "story_v_out_324021.awb")

						arg_32_1:RecordAudio("324021008", var_35_11)
						arg_32_1:RecordAudio("324021008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_324021", "324021008", "story_v_out_324021.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_324021", "324021008", "story_v_out_324021.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_3, arg_32_1.talkMaxDuration)

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_2) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_2 + var_35_12 and arg_32_1.time_ < var_35_2 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play324021009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324021009
		arg_36_1.duration_ = 7.2

		local var_36_0 = {
			zh = 7.2,
			ja = 7.066
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
				arg_36_0:Play324021010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10171ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10171ui_story == nil then
				arg_36_1.var_.characterEffect10171ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect10171ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10171ui_story then
				arg_36_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_39_4 = arg_36_1.actors_["1070ui_story"]
			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1070ui_story == nil then
				arg_36_1.var_.characterEffect1070ui_story = var_39_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_6 = 0.200000002980232

			if var_39_5 <= arg_36_1.time_ and arg_36_1.time_ < var_39_5 + var_39_6 and not isNil(var_39_4) then
				local var_39_7 = (arg_36_1.time_ - var_39_5) / var_39_6

				if arg_36_1.var_.characterEffect1070ui_story and not isNil(var_39_4) then
					local var_39_8 = Mathf.Lerp(0, 0.5, var_39_7)

					arg_36_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1070ui_story.fillRatio = var_39_8
				end
			end

			if arg_36_1.time_ >= var_39_5 + var_39_6 and arg_36_1.time_ < var_39_5 + var_39_6 + arg_39_0 and not isNil(var_39_4) and arg_36_1.var_.characterEffect1070ui_story then
				local var_39_9 = 0.5

				arg_36_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1070ui_story.fillRatio = var_39_9
			end

			local var_39_10 = 0

			if var_39_10 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_2")
			end

			local var_39_11 = 0

			if var_39_11 < arg_36_1.time_ and arg_36_1.time_ <= var_39_11 + arg_39_0 then
				arg_36_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_39_12 = 0
			local var_39_13 = 0.8

			if var_39_12 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_14 = arg_36_1:FormatText(StoryNameCfg[1451].name)

				arg_36_1.leftNameTxt_.text = var_39_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_15 = arg_36_1:GetWordFromCfg(324021009)
				local var_39_16 = arg_36_1:FormatText(var_39_15.content)

				arg_36_1.text_.text = var_39_16

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_17 = 32
				local var_39_18 = utf8.len(var_39_16)
				local var_39_19 = var_39_17 <= 0 and var_39_13 or var_39_13 * (var_39_18 / var_39_17)

				if var_39_19 > 0 and var_39_13 < var_39_19 then
					arg_36_1.talkMaxDuration = var_39_19

					if var_39_19 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_19 + var_39_12
					end
				end

				arg_36_1.text_.text = var_39_16
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021009", "story_v_out_324021.awb") ~= 0 then
					local var_39_20 = manager.audio:GetVoiceLength("story_v_out_324021", "324021009", "story_v_out_324021.awb") / 1000

					if var_39_20 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_20 + var_39_12
					end

					if var_39_15.prefab_name ~= "" and arg_36_1.actors_[var_39_15.prefab_name] ~= nil then
						local var_39_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_15.prefab_name].transform, "story_v_out_324021", "324021009", "story_v_out_324021.awb")

						arg_36_1:RecordAudio("324021009", var_39_21)
						arg_36_1:RecordAudio("324021009", var_39_21)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324021", "324021009", "story_v_out_324021.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324021", "324021009", "story_v_out_324021.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_22 = math.max(var_39_13, arg_36_1.talkMaxDuration)

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_22 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_12) / var_39_22

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_12 + var_39_22 and arg_36_1.time_ < var_39_12 + var_39_22 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play324021010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324021010
		arg_40_1.duration_ = 8.9

		local var_40_0 = {
			zh = 8.3,
			ja = 8.9
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
				arg_40_0:Play324021011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["1070ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1070ui_story == nil then
				arg_40_1.var_.characterEffect1070ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect1070ui_story and not isNil(var_43_0) then
					arg_40_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect1070ui_story then
				arg_40_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_43_4 = arg_40_1.actors_["10171ui_story"]
			local var_43_5 = 0

			if var_43_5 < arg_40_1.time_ and arg_40_1.time_ <= var_43_5 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect10171ui_story == nil then
				arg_40_1.var_.characterEffect10171ui_story = var_43_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_6 = 0.200000002980232

			if var_43_5 <= arg_40_1.time_ and arg_40_1.time_ < var_43_5 + var_43_6 and not isNil(var_43_4) then
				local var_43_7 = (arg_40_1.time_ - var_43_5) / var_43_6

				if arg_40_1.var_.characterEffect10171ui_story and not isNil(var_43_4) then
					local var_43_8 = Mathf.Lerp(0, 0.5, var_43_7)

					arg_40_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10171ui_story.fillRatio = var_43_8
				end
			end

			if arg_40_1.time_ >= var_43_5 + var_43_6 and arg_40_1.time_ < var_43_5 + var_43_6 + arg_43_0 and not isNil(var_43_4) and arg_40_1.var_.characterEffect10171ui_story then
				local var_43_9 = 0.5

				arg_40_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10171ui_story.fillRatio = var_43_9
			end

			local var_43_10 = 0

			if var_43_10 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action464")
			end

			local var_43_11 = 0

			if var_43_11 < arg_40_1.time_ and arg_40_1.time_ <= var_43_11 + arg_43_0 then
				arg_40_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_12 = 0
			local var_43_13 = 0.975

			if var_43_12 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_14 = arg_40_1:FormatText(StoryNameCfg[318].name)

				arg_40_1.leftNameTxt_.text = var_43_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_15 = arg_40_1:GetWordFromCfg(324021010)
				local var_43_16 = arg_40_1:FormatText(var_43_15.content)

				arg_40_1.text_.text = var_43_16

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 39
				local var_43_18 = utf8.len(var_43_16)
				local var_43_19 = var_43_17 <= 0 and var_43_13 or var_43_13 * (var_43_18 / var_43_17)

				if var_43_19 > 0 and var_43_13 < var_43_19 then
					arg_40_1.talkMaxDuration = var_43_19

					if var_43_19 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_19 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_16
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021010", "story_v_out_324021.awb") ~= 0 then
					local var_43_20 = manager.audio:GetVoiceLength("story_v_out_324021", "324021010", "story_v_out_324021.awb") / 1000

					if var_43_20 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_20 + var_43_12
					end

					if var_43_15.prefab_name ~= "" and arg_40_1.actors_[var_43_15.prefab_name] ~= nil then
						local var_43_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_15.prefab_name].transform, "story_v_out_324021", "324021010", "story_v_out_324021.awb")

						arg_40_1:RecordAudio("324021010", var_43_21)
						arg_40_1:RecordAudio("324021010", var_43_21)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_324021", "324021010", "story_v_out_324021.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_324021", "324021010", "story_v_out_324021.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_22 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_22 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_12) / var_43_22

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_12 + var_43_22 and arg_40_1.time_ < var_43_12 + var_43_22 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play324021011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324021011
		arg_44_1.duration_ = 15.63

		local var_44_0 = {
			zh = 9.33333333333333,
			ja = 15.6333333333333
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
				arg_44_0:Play324021012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = "J16f"

			if arg_44_1.bgs_[var_47_0] == nil then
				local var_47_1 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_47_0)
				var_47_1.name = var_47_0
				var_47_1.transform.parent = arg_44_1.stage_.transform
				var_47_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_[var_47_0] = var_47_1
			end

			local var_47_2 = 1.7

			if var_47_2 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				local var_47_3 = manager.ui.mainCamera.transform.localPosition
				local var_47_4 = Vector3.New(0, 0, 10) + Vector3.New(var_47_3.x, var_47_3.y, 0)
				local var_47_5 = arg_44_1.bgs_.J16f

				var_47_5.transform.localPosition = var_47_4
				var_47_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_6 = var_47_5:GetComponent("SpriteRenderer")

				if var_47_6 and var_47_6.sprite then
					local var_47_7 = (var_47_5.transform.localPosition - var_47_3).z
					local var_47_8 = manager.ui.mainCameraCom_
					local var_47_9 = 2 * var_47_7 * Mathf.Tan(var_47_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_47_10 = var_47_9 * var_47_8.aspect
					local var_47_11 = var_47_6.sprite.bounds.size.x
					local var_47_12 = var_47_6.sprite.bounds.size.y
					local var_47_13 = var_47_10 / var_47_11
					local var_47_14 = var_47_9 / var_47_12
					local var_47_15 = var_47_14 < var_47_13 and var_47_13 or var_47_14

					var_47_5.transform.localScale = Vector3.New(var_47_15, var_47_15, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "J16f" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_16 = 0

			if var_47_16 < arg_44_1.time_ and arg_44_1.time_ <= var_47_16 + arg_47_0 then
				arg_44_1.allBtn_.enabled = false
			end

			local var_47_17 = 0.3

			if arg_44_1.time_ >= var_47_16 + var_47_17 and arg_44_1.time_ < var_47_16 + var_47_17 + arg_47_0 then
				arg_44_1.allBtn_.enabled = true
			end

			local var_47_18 = 0

			if var_47_18 < arg_44_1.time_ and arg_44_1.time_ <= var_47_18 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_19 = 1.7

			if var_47_18 <= arg_44_1.time_ and arg_44_1.time_ < var_47_18 + var_47_19 then
				local var_47_20 = (arg_44_1.time_ - var_47_18) / var_47_19
				local var_47_21 = Color.New(0, 0, 0)

				var_47_21.a = Mathf.Lerp(0, 1, var_47_20)
				arg_44_1.mask_.color = var_47_21
			end

			if arg_44_1.time_ >= var_47_18 + var_47_19 and arg_44_1.time_ < var_47_18 + var_47_19 + arg_47_0 then
				local var_47_22 = Color.New(0, 0, 0)

				var_47_22.a = 1
				arg_44_1.mask_.color = var_47_22
			end

			local var_47_23 = 1.7

			if var_47_23 < arg_44_1.time_ and arg_44_1.time_ <= var_47_23 + arg_47_0 then
				arg_44_1.mask_.enabled = true
				arg_44_1.mask_.raycastTarget = true

				arg_44_1:SetGaussion(false)
			end

			local var_47_24 = 1.7

			if var_47_23 <= arg_44_1.time_ and arg_44_1.time_ < var_47_23 + var_47_24 then
				local var_47_25 = (arg_44_1.time_ - var_47_23) / var_47_24
				local var_47_26 = Color.New(0, 0, 0)

				var_47_26.a = Mathf.Lerp(1, 0, var_47_25)
				arg_44_1.mask_.color = var_47_26
			end

			if arg_44_1.time_ >= var_47_23 + var_47_24 and arg_44_1.time_ < var_47_23 + var_47_24 + arg_47_0 then
				local var_47_27 = Color.New(0, 0, 0)
				local var_47_28 = 0

				arg_44_1.mask_.enabled = false
				var_47_27.a = var_47_28
				arg_44_1.mask_.color = var_47_27
			end

			local var_47_29 = arg_44_1.actors_["10171ui_story"].transform
			local var_47_30 = 1.66599999815226

			if var_47_30 < arg_44_1.time_ and arg_44_1.time_ <= var_47_30 + arg_47_0 then
				arg_44_1.var_.moveOldPos10171ui_story = var_47_29.localPosition

				local var_47_31 = GameObjectTools.GetOrAddComponent(var_47_29.gameObject, typeof(DynamicBoneHelper))

				if var_47_31 then
					var_47_31:EnableDynamicBone(false)
				end
			end

			local var_47_32 = 0.001

			if var_47_30 <= arg_44_1.time_ and arg_44_1.time_ < var_47_30 + var_47_32 then
				local var_47_33 = (arg_44_1.time_ - var_47_30) / var_47_32
				local var_47_34 = Vector3.New(0, 100, 0)

				var_47_29.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos10171ui_story, var_47_34, var_47_33)

				local var_47_35 = manager.ui.mainCamera.transform.position - var_47_29.position

				var_47_29.forward = Vector3.New(var_47_35.x, var_47_35.y, var_47_35.z)

				local var_47_36 = var_47_29.localEulerAngles

				var_47_36.z = 0
				var_47_36.x = 0
				var_47_29.localEulerAngles = var_47_36
			end

			if arg_44_1.time_ >= var_47_30 + var_47_32 and arg_44_1.time_ < var_47_30 + var_47_32 + arg_47_0 then
				var_47_29.localPosition = Vector3.New(0, 100, 0)

				local var_47_37 = manager.ui.mainCamera.transform.position - var_47_29.position

				var_47_29.forward = Vector3.New(var_47_37.x, var_47_37.y, var_47_37.z)

				local var_47_38 = var_47_29.localEulerAngles

				var_47_38.z = 0
				var_47_38.x = 0
				var_47_29.localEulerAngles = var_47_38

				local var_47_39 = GameObjectTools.GetOrAddComponent(var_47_29.gameObject, typeof(DynamicBoneHelper))

				if var_47_39 then
					var_47_39:EnableDynamicBone(true)
				end
			end

			local var_47_40 = arg_44_1.actors_["1070ui_story"].transform
			local var_47_41 = 1.66599999815226

			if var_47_41 < arg_44_1.time_ and arg_44_1.time_ <= var_47_41 + arg_47_0 then
				arg_44_1.var_.moveOldPos1070ui_story = var_47_40.localPosition
			end

			local var_47_42 = 0.001

			if var_47_41 <= arg_44_1.time_ and arg_44_1.time_ < var_47_41 + var_47_42 then
				local var_47_43 = (arg_44_1.time_ - var_47_41) / var_47_42
				local var_47_44 = Vector3.New(0, 100, 0)

				var_47_40.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1070ui_story, var_47_44, var_47_43)

				local var_47_45 = manager.ui.mainCamera.transform.position - var_47_40.position

				var_47_40.forward = Vector3.New(var_47_45.x, var_47_45.y, var_47_45.z)

				local var_47_46 = var_47_40.localEulerAngles

				var_47_46.z = 0
				var_47_46.x = 0
				var_47_40.localEulerAngles = var_47_46
			end

			if arg_44_1.time_ >= var_47_41 + var_47_42 and arg_44_1.time_ < var_47_41 + var_47_42 + arg_47_0 then
				var_47_40.localPosition = Vector3.New(0, 100, 0)

				local var_47_47 = manager.ui.mainCamera.transform.position - var_47_40.position

				var_47_40.forward = Vector3.New(var_47_47.x, var_47_47.y, var_47_47.z)

				local var_47_48 = var_47_40.localEulerAngles

				var_47_48.z = 0
				var_47_48.x = 0
				var_47_40.localEulerAngles = var_47_48
			end

			local var_47_49 = 1.2
			local var_47_50 = 1

			if var_47_49 < arg_44_1.time_ and arg_44_1.time_ <= var_47_49 + arg_47_0 then
				local var_47_51 = "play"
				local var_47_52 = "effect"

				arg_44_1:AudioAction(var_47_51, var_47_52, "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			local var_47_53 = 0.1
			local var_47_54 = 1

			if var_47_53 < arg_44_1.time_ and arg_44_1.time_ <= var_47_53 + arg_47_0 then
				local var_47_55 = "stop"
				local var_47_56 = "effect"

				arg_44_1:AudioAction(var_47_55, var_47_56, "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			local var_47_57 = 0
			local var_47_58 = 1

			if var_47_57 < arg_44_1.time_ and arg_44_1.time_ <= var_47_57 + arg_47_0 then
				local var_47_59 = "play"
				local var_47_60 = "effect"

				arg_44_1:AudioAction(var_47_59, var_47_60, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_47_61 = 1
			local var_47_62 = 1

			if var_47_61 < arg_44_1.time_ and arg_44_1.time_ <= var_47_61 + arg_47_0 then
				local var_47_63 = "play"
				local var_47_64 = "music"

				arg_44_1:AudioAction(var_47_63, var_47_64, "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain.awb")

				local var_47_65 = ""
				local var_47_66 = manager.audio:GetAudioName("bgm_activity_4_8_story_mountain", "bgm_activity_4_8_story_mountain")

				if var_47_66 ~= "" then
					if arg_44_1.bgmTxt_.text ~= var_47_66 and arg_44_1.bgmTxt_.text ~= "" then
						if arg_44_1.bgmTxt2_.text ~= "" then
							arg_44_1.bgmTxt_.text = arg_44_1.bgmTxt2_.text
						end

						arg_44_1.bgmTxt2_.text = var_47_66

						arg_44_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_44_1.bgmTxt_.text = var_47_66
						arg_44_1.bgmTxt2_.text = var_47_66
					end

					if arg_44_1.bgmTimer then
						arg_44_1.bgmTimer:Stop()

						arg_44_1.bgmTimer = nil
					end

					if arg_44_1.settingData.show_music_name == 1 then
						arg_44_1.musicController:SetSelectedState("show")
						arg_44_1.musicAnimator_:Play("open", 0, 0)

						if arg_44_1.settingData.music_time ~= 0 then
							arg_44_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_44_1.settingData.music_time), function()
								if arg_44_1 == nil or isNil(arg_44_1.bgmTxt_) then
									return
								end

								arg_44_1.musicController:SetSelectedState("hide")
								arg_44_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_44_1.frameCnt_ <= 1 then
				arg_44_1.dialog_:SetActive(false)
			end

			local var_47_67 = 3.03333333333333
			local var_47_68 = 0.825

			if var_47_67 < arg_44_1.time_ and arg_44_1.time_ <= var_47_67 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0

				arg_44_1.dialog_:SetActive(true)

				arg_44_1.dialogCg_.alpha = 0

				local var_47_69 = LeanTween.value(arg_44_1.dialog_, 0, 1, 0.3)

				var_47_69:setOnUpdate(LuaHelper.FloatAction(function(arg_49_0)
					arg_44_1.dialogCg_.alpha = arg_49_0
				end))
				var_47_69:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_44_1.dialog_)
					var_47_69:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_44_1.duration_ = arg_44_1.duration_ + 0.3

				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_70 = arg_44_1:FormatText(StoryNameCfg[318].name)

				arg_44_1.leftNameTxt_.text = var_47_70

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_71 = arg_44_1:GetWordFromCfg(324021011)
				local var_47_72 = arg_44_1:FormatText(var_47_71.content)

				arg_44_1.text_.text = var_47_72

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_73 = 33
				local var_47_74 = utf8.len(var_47_72)
				local var_47_75 = var_47_73 <= 0 and var_47_68 or var_47_68 * (var_47_74 / var_47_73)

				if var_47_75 > 0 and var_47_68 < var_47_75 then
					arg_44_1.talkMaxDuration = var_47_75
					var_47_67 = var_47_67 + 0.3

					if var_47_75 + var_47_67 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_75 + var_47_67
					end
				end

				arg_44_1.text_.text = var_47_72
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021011", "story_v_out_324021.awb") ~= 0 then
					local var_47_76 = manager.audio:GetVoiceLength("story_v_out_324021", "324021011", "story_v_out_324021.awb") / 1000

					if var_47_76 + var_47_67 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_76 + var_47_67
					end

					if var_47_71.prefab_name ~= "" and arg_44_1.actors_[var_47_71.prefab_name] ~= nil then
						local var_47_77 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_71.prefab_name].transform, "story_v_out_324021", "324021011", "story_v_out_324021.awb")

						arg_44_1:RecordAudio("324021011", var_47_77)
						arg_44_1:RecordAudio("324021011", var_47_77)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_324021", "324021011", "story_v_out_324021.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_324021", "324021011", "story_v_out_324021.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_78 = var_47_67 + 0.3
			local var_47_79 = math.max(var_47_68, arg_44_1.talkMaxDuration)

			if var_47_78 <= arg_44_1.time_ and arg_44_1.time_ < var_47_78 + var_47_79 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_78) / var_47_79

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_78 + var_47_79 and arg_44_1.time_ < var_47_78 + var_47_79 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.66599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play324021012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 324021012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play324021013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = arg_51_1.actors_["1070ui_story"]
			local var_54_1 = 0

			if var_54_1 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1070ui_story == nil then
				arg_51_1.var_.characterEffect1070ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_2 and not isNil(var_54_0) then
				local var_54_3 = (arg_51_1.time_ - var_54_1) / var_54_2

				if arg_51_1.var_.characterEffect1070ui_story and not isNil(var_54_0) then
					local var_54_4 = Mathf.Lerp(0, 0.5, var_54_3)

					arg_51_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1070ui_story.fillRatio = var_54_4
				end
			end

			if arg_51_1.time_ >= var_54_1 + var_54_2 and arg_51_1.time_ < var_54_1 + var_54_2 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1070ui_story then
				local var_54_5 = 0.5

				arg_51_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1070ui_story.fillRatio = var_54_5
			end

			local var_54_6 = 0
			local var_54_7 = 1.025

			if var_54_6 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, false)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_8 = arg_51_1:GetWordFromCfg(324021012)
				local var_54_9 = arg_51_1:FormatText(var_54_8.content)

				arg_51_1.text_.text = var_54_9

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_10 = 41
				local var_54_11 = utf8.len(var_54_9)
				local var_54_12 = var_54_10 <= 0 and var_54_7 or var_54_7 * (var_54_11 / var_54_10)

				if var_54_12 > 0 and var_54_7 < var_54_12 then
					arg_51_1.talkMaxDuration = var_54_12

					if var_54_12 + var_54_6 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_12 + var_54_6
					end
				end

				arg_51_1.text_.text = var_54_9
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_13 = math.max(var_54_7, arg_51_1.talkMaxDuration)

			if var_54_6 <= arg_51_1.time_ and arg_51_1.time_ < var_54_6 + var_54_13 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_6) / var_54_13

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_6 + var_54_13 and arg_51_1.time_ < var_54_6 + var_54_13 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play324021013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 324021013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play324021014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0
			local var_58_1 = 0.9

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

				local var_58_2 = arg_55_1:GetWordFromCfg(324021013)
				local var_58_3 = arg_55_1:FormatText(var_58_2.content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_4 = 36
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
	Play324021014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 324021014
		arg_59_1.duration_ = 6.6

		local var_59_0 = {
			zh = 6.6,
			ja = 5.933
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
				arg_59_0:Play324021015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = arg_59_1.actors_["1070ui_story"].transform
			local var_62_1 = 0

			if var_62_1 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.var_.moveOldPos1070ui_story = var_62_0.localPosition
			end

			local var_62_2 = 0.001

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_2 then
				local var_62_3 = (arg_59_1.time_ - var_62_1) / var_62_2
				local var_62_4 = Vector3.New(0, -0.95, -6.05)

				var_62_0.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1070ui_story, var_62_4, var_62_3)

				local var_62_5 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_5.x, var_62_5.y, var_62_5.z)

				local var_62_6 = var_62_0.localEulerAngles

				var_62_6.z = 0
				var_62_6.x = 0
				var_62_0.localEulerAngles = var_62_6
			end

			if arg_59_1.time_ >= var_62_1 + var_62_2 and arg_59_1.time_ < var_62_1 + var_62_2 + arg_62_0 then
				var_62_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_62_7 = manager.ui.mainCamera.transform.position - var_62_0.position

				var_62_0.forward = Vector3.New(var_62_7.x, var_62_7.y, var_62_7.z)

				local var_62_8 = var_62_0.localEulerAngles

				var_62_8.z = 0
				var_62_8.x = 0
				var_62_0.localEulerAngles = var_62_8
			end

			local var_62_9 = arg_59_1.actors_["1070ui_story"]
			local var_62_10 = 0

			if var_62_10 < arg_59_1.time_ and arg_59_1.time_ <= var_62_10 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect1070ui_story == nil then
				arg_59_1.var_.characterEffect1070ui_story = var_62_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_11 = 0.200000002980232

			if var_62_10 <= arg_59_1.time_ and arg_59_1.time_ < var_62_10 + var_62_11 and not isNil(var_62_9) then
				local var_62_12 = (arg_59_1.time_ - var_62_10) / var_62_11

				if arg_59_1.var_.characterEffect1070ui_story and not isNil(var_62_9) then
					arg_59_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= var_62_10 + var_62_11 and arg_59_1.time_ < var_62_10 + var_62_11 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect1070ui_story then
				arg_59_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_62_13 = 0

			if var_62_13 < arg_59_1.time_ and arg_59_1.time_ <= var_62_13 + arg_62_0 then
				arg_59_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			local var_62_14 = 0

			if var_62_14 < arg_59_1.time_ and arg_59_1.time_ <= var_62_14 + arg_62_0 then
				arg_59_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_62_15 = 0
			local var_62_16 = 0.55

			if var_62_15 < arg_59_1.time_ and arg_59_1.time_ <= var_62_15 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				local var_62_17 = arg_59_1:FormatText(StoryNameCfg[318].name)

				arg_59_1.leftNameTxt_.text = var_62_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_18 = arg_59_1:GetWordFromCfg(324021014)
				local var_62_19 = arg_59_1:FormatText(var_62_18.content)

				arg_59_1.text_.text = var_62_19

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_20 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021014", "story_v_out_324021.awb") ~= 0 then
					local var_62_23 = manager.audio:GetVoiceLength("story_v_out_324021", "324021014", "story_v_out_324021.awb") / 1000

					if var_62_23 + var_62_15 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_23 + var_62_15
					end

					if var_62_18.prefab_name ~= "" and arg_59_1.actors_[var_62_18.prefab_name] ~= nil then
						local var_62_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_18.prefab_name].transform, "story_v_out_324021", "324021014", "story_v_out_324021.awb")

						arg_59_1:RecordAudio("324021014", var_62_24)
						arg_59_1:RecordAudio("324021014", var_62_24)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_324021", "324021014", "story_v_out_324021.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_324021", "324021014", "story_v_out_324021.awb")
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
				actorName = "1070ui_story",
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
	Play324021015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 324021015
		arg_63_1.duration_ = 8.53

		local var_63_0 = {
			zh = 7.7,
			ja = 8.533
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
				arg_63_0:Play324021016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = arg_63_1.actors_["1070ui_story"]
			local var_66_1 = 0

			if var_66_1 < arg_63_1.time_ and arg_63_1.time_ <= var_66_1 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1070ui_story == nil then
				arg_63_1.var_.characterEffect1070ui_story = var_66_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if var_66_1 <= arg_63_1.time_ and arg_63_1.time_ < var_66_1 + var_66_2 and not isNil(var_66_0) then
				local var_66_3 = (arg_63_1.time_ - var_66_1) / var_66_2

				if arg_63_1.var_.characterEffect1070ui_story and not isNil(var_66_0) then
					local var_66_4 = Mathf.Lerp(0, 0.5, var_66_3)

					arg_63_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1070ui_story.fillRatio = var_66_4
				end
			end

			if arg_63_1.time_ >= var_66_1 + var_66_2 and arg_63_1.time_ < var_66_1 + var_66_2 + arg_66_0 and not isNil(var_66_0) and arg_63_1.var_.characterEffect1070ui_story then
				local var_66_5 = 0.5

				arg_63_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1070ui_story.fillRatio = var_66_5
			end

			local var_66_6 = 0
			local var_66_7 = 0.55

			if var_66_6 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_8 = arg_63_1:FormatText(StoryNameCfg[36].name)

				arg_63_1.leftNameTxt_.text = var_66_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_9 = arg_63_1:GetWordFromCfg(324021015)
				local var_66_10 = arg_63_1:FormatText(var_66_9.content)

				arg_63_1.text_.text = var_66_10

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 22
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

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021015", "story_v_out_324021.awb") ~= 0 then
					local var_66_14 = manager.audio:GetVoiceLength("story_v_out_324021", "324021015", "story_v_out_324021.awb") / 1000

					if var_66_14 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_14 + var_66_6
					end

					if var_66_9.prefab_name ~= "" and arg_63_1.actors_[var_66_9.prefab_name] ~= nil then
						local var_66_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_9.prefab_name].transform, "story_v_out_324021", "324021015", "story_v_out_324021.awb")

						arg_63_1:RecordAudio("324021015", var_66_15)
						arg_63_1:RecordAudio("324021015", var_66_15)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_324021", "324021015", "story_v_out_324021.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_324021", "324021015", "story_v_out_324021.awb")
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
	Play324021016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 324021016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play324021017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = arg_67_1.actors_["1070ui_story"].transform
			local var_70_1 = 0

			if var_70_1 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.var_.moveOldPos1070ui_story = var_70_0.localPosition
			end

			local var_70_2 = 0.001

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_2 then
				local var_70_3 = (arg_67_1.time_ - var_70_1) / var_70_2
				local var_70_4 = Vector3.New(0, 100, 0)

				var_70_0.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1070ui_story, var_70_4, var_70_3)

				local var_70_5 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_5.x, var_70_5.y, var_70_5.z)

				local var_70_6 = var_70_0.localEulerAngles

				var_70_6.z = 0
				var_70_6.x = 0
				var_70_0.localEulerAngles = var_70_6
			end

			if arg_67_1.time_ >= var_70_1 + var_70_2 and arg_67_1.time_ < var_70_1 + var_70_2 + arg_70_0 then
				var_70_0.localPosition = Vector3.New(0, 100, 0)

				local var_70_7 = manager.ui.mainCamera.transform.position - var_70_0.position

				var_70_0.forward = Vector3.New(var_70_7.x, var_70_7.y, var_70_7.z)

				local var_70_8 = var_70_0.localEulerAngles

				var_70_8.z = 0
				var_70_8.x = 0
				var_70_0.localEulerAngles = var_70_8
			end

			local var_70_9 = 0
			local var_70_10 = 1.325

			if var_70_9 < arg_67_1.time_ and arg_67_1.time_ <= var_70_9 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_11 = arg_67_1:GetWordFromCfg(324021016)
				local var_70_12 = arg_67_1:FormatText(var_70_11.content)

				arg_67_1.text_.text = var_70_12

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_13 = 53
				local var_70_14 = utf8.len(var_70_12)
				local var_70_15 = var_70_13 <= 0 and var_70_10 or var_70_10 * (var_70_14 / var_70_13)

				if var_70_15 > 0 and var_70_10 < var_70_15 then
					arg_67_1.talkMaxDuration = var_70_15

					if var_70_15 + var_70_9 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_15 + var_70_9
					end
				end

				arg_67_1.text_.text = var_70_12
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_16 = math.max(var_70_10, arg_67_1.talkMaxDuration)

			if var_70_9 <= arg_67_1.time_ and arg_67_1.time_ < var_70_9 + var_70_16 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_9) / var_70_16

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_9 + var_70_16 and arg_67_1.time_ < var_70_9 + var_70_16 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play324021017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 324021017
		arg_71_1.duration_ = 6.6

		local var_71_0 = {
			zh = 3.1,
			ja = 6.6
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
				arg_71_0:Play324021018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["1070ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos1070ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, -0.95, -6.05)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1070ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -0.95, -6.05)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = arg_71_1.actors_["1070ui_story"]
			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1070ui_story == nil then
				arg_71_1.var_.characterEffect1070ui_story = var_74_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_11 = 0.200000002980232

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_11 and not isNil(var_74_9) then
				local var_74_12 = (arg_71_1.time_ - var_74_10) / var_74_11

				if arg_71_1.var_.characterEffect1070ui_story and not isNil(var_74_9) then
					arg_71_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_10 + var_74_11 and arg_71_1.time_ < var_74_10 + var_74_11 + arg_74_0 and not isNil(var_74_9) and arg_71_1.var_.characterEffect1070ui_story then
				arg_71_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_74_13 = 0
			local var_74_14 = 0.325

			if var_74_13 < arg_71_1.time_ and arg_71_1.time_ <= var_74_13 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_15 = arg_71_1:FormatText(StoryNameCfg[318].name)

				arg_71_1.leftNameTxt_.text = var_74_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_16 = arg_71_1:GetWordFromCfg(324021017)
				local var_74_17 = arg_71_1:FormatText(var_74_16.content)

				arg_71_1.text_.text = var_74_17

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_18 = 13
				local var_74_19 = utf8.len(var_74_17)
				local var_74_20 = var_74_18 <= 0 and var_74_14 or var_74_14 * (var_74_19 / var_74_18)

				if var_74_20 > 0 and var_74_14 < var_74_20 then
					arg_71_1.talkMaxDuration = var_74_20

					if var_74_20 + var_74_13 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_20 + var_74_13
					end
				end

				arg_71_1.text_.text = var_74_17
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021017", "story_v_out_324021.awb") ~= 0 then
					local var_74_21 = manager.audio:GetVoiceLength("story_v_out_324021", "324021017", "story_v_out_324021.awb") / 1000

					if var_74_21 + var_74_13 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_21 + var_74_13
					end

					if var_74_16.prefab_name ~= "" and arg_71_1.actors_[var_74_16.prefab_name] ~= nil then
						local var_74_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_16.prefab_name].transform, "story_v_out_324021", "324021017", "story_v_out_324021.awb")

						arg_71_1:RecordAudio("324021017", var_74_22)
						arg_71_1:RecordAudio("324021017", var_74_22)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_324021", "324021017", "story_v_out_324021.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_324021", "324021017", "story_v_out_324021.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_23 = math.max(var_74_14, arg_71_1.talkMaxDuration)

			if var_74_13 <= arg_71_1.time_ and arg_71_1.time_ < var_74_13 + var_74_23 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_13) / var_74_23

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_13 + var_74_23 and arg_71_1.time_ < var_74_13 + var_74_23 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play324021018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 324021018
		arg_75_1.duration_ = 9.77

		local var_75_0 = {
			zh = 9.2,
			ja = 9.766
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
				arg_75_0:Play324021019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = arg_75_1.actors_["1070ui_story"]
			local var_78_1 = 0

			if var_78_1 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1070ui_story == nil then
				arg_75_1.var_.characterEffect1070ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_2 and not isNil(var_78_0) then
				local var_78_3 = (arg_75_1.time_ - var_78_1) / var_78_2

				if arg_75_1.var_.characterEffect1070ui_story and not isNil(var_78_0) then
					local var_78_4 = Mathf.Lerp(0, 0.5, var_78_3)

					arg_75_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1070ui_story.fillRatio = var_78_4
				end
			end

			if arg_75_1.time_ >= var_78_1 + var_78_2 and arg_75_1.time_ < var_78_1 + var_78_2 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1070ui_story then
				local var_78_5 = 0.5

				arg_75_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1070ui_story.fillRatio = var_78_5
			end

			local var_78_6 = 0
			local var_78_7 = 0.85

			if var_78_6 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_8 = arg_75_1:FormatText(StoryNameCfg[36].name)

				arg_75_1.leftNameTxt_.text = var_78_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_9 = arg_75_1:GetWordFromCfg(324021018)
				local var_78_10 = arg_75_1:FormatText(var_78_9.content)

				arg_75_1.text_.text = var_78_10

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_11 = 34
				local var_78_12 = utf8.len(var_78_10)
				local var_78_13 = var_78_11 <= 0 and var_78_7 or var_78_7 * (var_78_12 / var_78_11)

				if var_78_13 > 0 and var_78_7 < var_78_13 then
					arg_75_1.talkMaxDuration = var_78_13

					if var_78_13 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_13 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_10
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021018", "story_v_out_324021.awb") ~= 0 then
					local var_78_14 = manager.audio:GetVoiceLength("story_v_out_324021", "324021018", "story_v_out_324021.awb") / 1000

					if var_78_14 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_14 + var_78_6
					end

					if var_78_9.prefab_name ~= "" and arg_75_1.actors_[var_78_9.prefab_name] ~= nil then
						local var_78_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_9.prefab_name].transform, "story_v_out_324021", "324021018", "story_v_out_324021.awb")

						arg_75_1:RecordAudio("324021018", var_78_15)
						arg_75_1:RecordAudio("324021018", var_78_15)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_324021", "324021018", "story_v_out_324021.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_324021", "324021018", "story_v_out_324021.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_16 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_16 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_16

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_16 and arg_75_1.time_ < var_78_6 + var_78_16 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play324021019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 324021019
		arg_79_1.duration_ = 3.57

		local var_79_0 = {
			zh = 2.8,
			ja = 3.566
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play324021020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["1070ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1070ui_story == nil then
				arg_79_1.var_.characterEffect1070ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 and not isNil(var_82_0) then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect1070ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1070ui_story then
				arg_79_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_82_4 = 0

			if var_82_4 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_2")
			end

			local var_82_5 = 0

			if var_82_5 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
				arg_79_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_82_6 = 0
			local var_82_7 = 0.225

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				local var_82_8 = arg_79_1:FormatText(StoryNameCfg[318].name)

				arg_79_1.leftNameTxt_.text = var_82_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_9 = arg_79_1:GetWordFromCfg(324021019)
				local var_82_10 = arg_79_1:FormatText(var_82_9.content)

				arg_79_1.text_.text = var_82_10

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_11 = 9
				local var_82_12 = utf8.len(var_82_10)
				local var_82_13 = var_82_11 <= 0 and var_82_7 or var_82_7 * (var_82_12 / var_82_11)

				if var_82_13 > 0 and var_82_7 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_10
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021019", "story_v_out_324021.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_324021", "324021019", "story_v_out_324021.awb") / 1000

					if var_82_14 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_6
					end

					if var_82_9.prefab_name ~= "" and arg_79_1.actors_[var_82_9.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_9.prefab_name].transform, "story_v_out_324021", "324021019", "story_v_out_324021.awb")

						arg_79_1:RecordAudio("324021019", var_82_15)
						arg_79_1:RecordAudio("324021019", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_324021", "324021019", "story_v_out_324021.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_324021", "324021019", "story_v_out_324021.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_16 and arg_79_1.time_ < var_82_6 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play324021020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 324021020
		arg_83_1.duration_ = 9.63

		local var_83_0 = {
			zh = 9.2,
			ja = 9.633
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
				arg_83_0:Play324021021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = arg_83_1.actors_["1070ui_story"]
			local var_86_1 = 0

			if var_86_1 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1070ui_story == nil then
				arg_83_1.var_.characterEffect1070ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_2 and not isNil(var_86_0) then
				local var_86_3 = (arg_83_1.time_ - var_86_1) / var_86_2

				if arg_83_1.var_.characterEffect1070ui_story and not isNil(var_86_0) then
					local var_86_4 = Mathf.Lerp(0, 0.5, var_86_3)

					arg_83_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1070ui_story.fillRatio = var_86_4
				end
			end

			if arg_83_1.time_ >= var_86_1 + var_86_2 and arg_83_1.time_ < var_86_1 + var_86_2 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1070ui_story then
				local var_86_5 = 0.5

				arg_83_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1070ui_story.fillRatio = var_86_5
			end

			local var_86_6
			local var_86_7 = 0

			if var_86_7 < arg_83_1.time_ and arg_83_1.time_ <= var_86_7 + arg_86_0 then
				local var_86_8 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_86_8 then
					var_86_8.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_86_8.radialBlurScale = 0
					var_86_8.radialBlurGradient = 1
					var_86_8.radialBlurIntensity = 1

					if var_86_6 then
						var_86_8.radialBlurTarget = var_86_6.transform
					end
				end
			end

			local var_86_9 = 2.06666666666667

			if var_86_7 <= arg_83_1.time_ and arg_83_1.time_ < var_86_7 + var_86_9 then
				local var_86_10 = (arg_83_1.time_ - var_86_7) / var_86_9
				local var_86_11 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_86_11 then
					var_86_11.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_86_11.radialBlurScale = Mathf.Lerp(0, 0.521, var_86_10)
					var_86_11.radialBlurGradient = Mathf.Lerp(1, 1, var_86_10)
					var_86_11.radialBlurIntensity = Mathf.Lerp(1, 1, var_86_10)
				end
			end

			if arg_83_1.time_ >= var_86_7 + var_86_9 and arg_83_1.time_ < var_86_7 + var_86_9 + arg_86_0 then
				local var_86_12 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_86_12 then
					var_86_12.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_86_12.radialBlurScale = 0.521
					var_86_12.radialBlurGradient = 1
					var_86_12.radialBlurIntensity = 1
				end
			end

			local var_86_13 = 0
			local var_86_14 = 0.875

			if var_86_13 < arg_83_1.time_ and arg_83_1.time_ <= var_86_13 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				local var_86_15 = arg_83_1:FormatText(StoryNameCfg[36].name)

				arg_83_1.leftNameTxt_.text = var_86_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_16 = arg_83_1:GetWordFromCfg(324021020)
				local var_86_17 = arg_83_1:FormatText(var_86_16.content)

				arg_83_1.text_.text = var_86_17

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_18 = 35
				local var_86_19 = utf8.len(var_86_17)
				local var_86_20 = var_86_18 <= 0 and var_86_14 or var_86_14 * (var_86_19 / var_86_18)

				if var_86_20 > 0 and var_86_14 < var_86_20 then
					arg_83_1.talkMaxDuration = var_86_20

					if var_86_20 + var_86_13 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_20 + var_86_13
					end
				end

				arg_83_1.text_.text = var_86_17
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021020", "story_v_out_324021.awb") ~= 0 then
					local var_86_21 = manager.audio:GetVoiceLength("story_v_out_324021", "324021020", "story_v_out_324021.awb") / 1000

					if var_86_21 + var_86_13 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_21 + var_86_13
					end

					if var_86_16.prefab_name ~= "" and arg_83_1.actors_[var_86_16.prefab_name] ~= nil then
						local var_86_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_16.prefab_name].transform, "story_v_out_324021", "324021020", "story_v_out_324021.awb")

						arg_83_1:RecordAudio("324021020", var_86_22)
						arg_83_1:RecordAudio("324021020", var_86_22)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_324021", "324021020", "story_v_out_324021.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_324021", "324021020", "story_v_out_324021.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_23 = math.max(var_86_14, arg_83_1.talkMaxDuration)

			if var_86_13 <= arg_83_1.time_ and arg_83_1.time_ < var_86_13 + var_86_23 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_13) / var_86_23

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_13 + var_86_23 and arg_83_1.time_ < var_86_13 + var_86_23 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play324021021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 324021021
		arg_87_1.duration_ = 8.8

		local var_87_0 = {
			zh = 8.8,
			ja = 8.433
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
				arg_87_0:Play324021022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = 0
			local var_90_1 = 0.825

			if var_90_0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_2 = arg_87_1:FormatText(StoryNameCfg[36].name)

				arg_87_1.leftNameTxt_.text = var_90_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_3 = arg_87_1:GetWordFromCfg(324021021)
				local var_90_4 = arg_87_1:FormatText(var_90_3.content)

				arg_87_1.text_.text = var_90_4

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021021", "story_v_out_324021.awb") ~= 0 then
					local var_90_8 = manager.audio:GetVoiceLength("story_v_out_324021", "324021021", "story_v_out_324021.awb") / 1000

					if var_90_8 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_8 + var_90_0
					end

					if var_90_3.prefab_name ~= "" and arg_87_1.actors_[var_90_3.prefab_name] ~= nil then
						local var_90_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_3.prefab_name].transform, "story_v_out_324021", "324021021", "story_v_out_324021.awb")

						arg_87_1:RecordAudio("324021021", var_90_9)
						arg_87_1:RecordAudio("324021021", var_90_9)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_324021", "324021021", "story_v_out_324021.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_324021", "324021021", "story_v_out_324021.awb")
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
	Play324021022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 324021022
		arg_91_1.duration_ = 12.53

		local var_91_0 = {
			zh = 10.2,
			ja = 12.533
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play324021023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			local var_94_0 = 0
			local var_94_1 = 0.95

			if var_94_0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				local var_94_2 = arg_91_1:FormatText(StoryNameCfg[36].name)

				arg_91_1.leftNameTxt_.text = var_94_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:GetWordFromCfg(324021022)
				local var_94_4 = arg_91_1:FormatText(var_94_3.content)

				arg_91_1.text_.text = var_94_4

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 38
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

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021022", "story_v_out_324021.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_324021", "324021022", "story_v_out_324021.awb") / 1000

					if var_94_8 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_0
					end

					if var_94_3.prefab_name ~= "" and arg_91_1.actors_[var_94_3.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_3.prefab_name].transform, "story_v_out_324021", "324021022", "story_v_out_324021.awb")

						arg_91_1:RecordAudio("324021022", var_94_9)
						arg_91_1:RecordAudio("324021022", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_324021", "324021022", "story_v_out_324021.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_324021", "324021022", "story_v_out_324021.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_10 and arg_91_1.time_ < var_94_0 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play324021023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 324021023
		arg_95_1.duration_ = 2.3

		local var_95_0 = {
			zh = 2,
			ja = 2.3
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
				arg_95_0:Play324021024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = arg_95_1.actors_["1070ui_story"]
			local var_98_1 = 0

			if var_98_1 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1070ui_story == nil then
				arg_95_1.var_.characterEffect1070ui_story = var_98_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_2 and not isNil(var_98_0) then
				local var_98_3 = (arg_95_1.time_ - var_98_1) / var_98_2

				if arg_95_1.var_.characterEffect1070ui_story and not isNil(var_98_0) then
					arg_95_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= var_98_1 + var_98_2 and arg_95_1.time_ < var_98_1 + var_98_2 + arg_98_0 and not isNil(var_98_0) and arg_95_1.var_.characterEffect1070ui_story then
				arg_95_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_98_4 = 0

			if var_98_4 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			local var_98_5 = 0

			if var_98_5 < arg_95_1.time_ and arg_95_1.time_ <= var_98_5 + arg_98_0 then
				arg_95_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_98_6 = 0
			local var_98_7 = 0.125

			if var_98_6 < arg_95_1.time_ and arg_95_1.time_ <= var_98_6 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				local var_98_8 = arg_95_1:FormatText(StoryNameCfg[318].name)

				arg_95_1.leftNameTxt_.text = var_98_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_9 = arg_95_1:GetWordFromCfg(324021023)
				local var_98_10 = arg_95_1:FormatText(var_98_9.content)

				arg_95_1.text_.text = var_98_10

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_11 = 5
				local var_98_12 = utf8.len(var_98_10)
				local var_98_13 = var_98_11 <= 0 and var_98_7 or var_98_7 * (var_98_12 / var_98_11)

				if var_98_13 > 0 and var_98_7 < var_98_13 then
					arg_95_1.talkMaxDuration = var_98_13

					if var_98_13 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_13 + var_98_6
					end
				end

				arg_95_1.text_.text = var_98_10
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021023", "story_v_out_324021.awb") ~= 0 then
					local var_98_14 = manager.audio:GetVoiceLength("story_v_out_324021", "324021023", "story_v_out_324021.awb") / 1000

					if var_98_14 + var_98_6 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_14 + var_98_6
					end

					if var_98_9.prefab_name ~= "" and arg_95_1.actors_[var_98_9.prefab_name] ~= nil then
						local var_98_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_9.prefab_name].transform, "story_v_out_324021", "324021023", "story_v_out_324021.awb")

						arg_95_1:RecordAudio("324021023", var_98_15)
						arg_95_1:RecordAudio("324021023", var_98_15)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_324021", "324021023", "story_v_out_324021.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_324021", "324021023", "story_v_out_324021.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_16 = math.max(var_98_7, arg_95_1.talkMaxDuration)

			if var_98_6 <= arg_95_1.time_ and arg_95_1.time_ < var_98_6 + var_98_16 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_6) / var_98_16

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_6 + var_98_16 and arg_95_1.time_ < var_98_6 + var_98_16 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play324021024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 324021024
		arg_99_1.duration_ = 7.47

		local var_99_0 = {
			zh = 7.466,
			ja = 4.633
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
				arg_99_0:Play324021025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = arg_99_1.actors_["1070ui_story"]
			local var_102_1 = 0

			if var_102_1 < arg_99_1.time_ and arg_99_1.time_ <= var_102_1 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1070ui_story == nil then
				arg_99_1.var_.characterEffect1070ui_story = var_102_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if var_102_1 <= arg_99_1.time_ and arg_99_1.time_ < var_102_1 + var_102_2 and not isNil(var_102_0) then
				local var_102_3 = (arg_99_1.time_ - var_102_1) / var_102_2

				if arg_99_1.var_.characterEffect1070ui_story and not isNil(var_102_0) then
					local var_102_4 = Mathf.Lerp(0, 0.5, var_102_3)

					arg_99_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1070ui_story.fillRatio = var_102_4
				end
			end

			if arg_99_1.time_ >= var_102_1 + var_102_2 and arg_99_1.time_ < var_102_1 + var_102_2 + arg_102_0 and not isNil(var_102_0) and arg_99_1.var_.characterEffect1070ui_story then
				local var_102_5 = 0.5

				arg_99_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1070ui_story.fillRatio = var_102_5
			end

			local var_102_6 = 0
			local var_102_7 = 0.625

			if var_102_6 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				local var_102_8 = arg_99_1:FormatText(StoryNameCfg[36].name)

				arg_99_1.leftNameTxt_.text = var_102_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_9 = arg_99_1:GetWordFromCfg(324021024)
				local var_102_10 = arg_99_1:FormatText(var_102_9.content)

				arg_99_1.text_.text = var_102_10

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_11 = 25
				local var_102_12 = utf8.len(var_102_10)
				local var_102_13 = var_102_11 <= 0 and var_102_7 or var_102_7 * (var_102_12 / var_102_11)

				if var_102_13 > 0 and var_102_7 < var_102_13 then
					arg_99_1.talkMaxDuration = var_102_13

					if var_102_13 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_13 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_10
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021024", "story_v_out_324021.awb") ~= 0 then
					local var_102_14 = manager.audio:GetVoiceLength("story_v_out_324021", "324021024", "story_v_out_324021.awb") / 1000

					if var_102_14 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_14 + var_102_6
					end

					if var_102_9.prefab_name ~= "" and arg_99_1.actors_[var_102_9.prefab_name] ~= nil then
						local var_102_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_9.prefab_name].transform, "story_v_out_324021", "324021024", "story_v_out_324021.awb")

						arg_99_1:RecordAudio("324021024", var_102_15)
						arg_99_1:RecordAudio("324021024", var_102_15)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_324021", "324021024", "story_v_out_324021.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_324021", "324021024", "story_v_out_324021.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_16 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_16 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_16

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_16 and arg_99_1.time_ < var_102_6 + var_102_16 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play324021025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 324021025
		arg_103_1.duration_ = 15.83

		local var_103_0 = {
			zh = 13.766,
			ja = 15.833
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play324021026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			local var_106_0 = 0
			local var_106_1 = 1.425

			if var_106_0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_0 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				local var_106_2 = arg_103_1:FormatText(StoryNameCfg[36].name)

				arg_103_1.leftNameTxt_.text = var_106_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:GetWordFromCfg(324021025)
				local var_106_4 = arg_103_1:FormatText(var_106_3.content)

				arg_103_1.text_.text = var_106_4

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 57
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

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021025", "story_v_out_324021.awb") ~= 0 then
					local var_106_8 = manager.audio:GetVoiceLength("story_v_out_324021", "324021025", "story_v_out_324021.awb") / 1000

					if var_106_8 + var_106_0 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_8 + var_106_0
					end

					if var_106_3.prefab_name ~= "" and arg_103_1.actors_[var_106_3.prefab_name] ~= nil then
						local var_106_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_3.prefab_name].transform, "story_v_out_324021", "324021025", "story_v_out_324021.awb")

						arg_103_1:RecordAudio("324021025", var_106_9)
						arg_103_1:RecordAudio("324021025", var_106_9)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_324021", "324021025", "story_v_out_324021.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_324021", "324021025", "story_v_out_324021.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_10 = math.max(var_106_1, arg_103_1.talkMaxDuration)

			if var_106_0 <= arg_103_1.time_ and arg_103_1.time_ < var_106_0 + var_106_10 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_0) / var_106_10

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_0 + var_106_10 and arg_103_1.time_ < var_106_0 + var_106_10 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play324021026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 324021026
		arg_107_1.duration_ = 13.5

		local var_107_0 = {
			zh = 10.2,
			ja = 13.5
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
				arg_107_0:Play324021027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0
			local var_110_1 = 1

			if var_110_0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				local var_110_2 = arg_107_1:FormatText(StoryNameCfg[36].name)

				arg_107_1.leftNameTxt_.text = var_110_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_3 = arg_107_1:GetWordFromCfg(324021026)
				local var_110_4 = arg_107_1:FormatText(var_110_3.content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_5 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021026", "story_v_out_324021.awb") ~= 0 then
					local var_110_8 = manager.audio:GetVoiceLength("story_v_out_324021", "324021026", "story_v_out_324021.awb") / 1000

					if var_110_8 + var_110_0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_8 + var_110_0
					end

					if var_110_3.prefab_name ~= "" and arg_107_1.actors_[var_110_3.prefab_name] ~= nil then
						local var_110_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_3.prefab_name].transform, "story_v_out_324021", "324021026", "story_v_out_324021.awb")

						arg_107_1:RecordAudio("324021026", var_110_9)
						arg_107_1:RecordAudio("324021026", var_110_9)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_324021", "324021026", "story_v_out_324021.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_324021", "324021026", "story_v_out_324021.awb")
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
	Play324021027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 324021027
		arg_111_1.duration_ = 5.87

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play324021028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["1070ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos1070ui_story = var_114_0.localPosition
			end

			local var_114_2 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2
				local var_114_4 = Vector3.New(0, 100, 0)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1070ui_story, var_114_4, var_114_3)

				local var_114_5 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_5.x, var_114_5.y, var_114_5.z)

				local var_114_6 = var_114_0.localEulerAngles

				var_114_6.z = 0
				var_114_6.x = 0
				var_114_0.localEulerAngles = var_114_6
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(0, 100, 0)

				local var_114_7 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_7.x, var_114_7.y, var_114_7.z)

				local var_114_8 = var_114_0.localEulerAngles

				var_114_8.z = 0
				var_114_8.x = 0
				var_114_0.localEulerAngles = var_114_8
			end

			local var_114_9 = manager.ui.mainCamera.transform
			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 then
				local var_114_11 = arg_111_1.var_.effect3233
				local var_114_12
				local var_114_13 = var_114_9

				if not var_114_11 then
					var_114_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), var_114_13)
					var_114_11.name = "3233"
					arg_111_1.var_.effect3233 = var_114_11
				else
					var_114_11.transform:SetParent(var_114_13)
				end

				var_114_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_114_11.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_114_14 = 1.7777777777777777
				local var_114_15 = Screen.width / Screen.height
				local var_114_16 = var_114_15 / var_114_14
				local var_114_17 = Mathf.Max(var_114_14 / var_114_15, 1)

				var_114_11.transform.localScale = Vector3.New(var_114_11.transform.localScale.x * var_114_16, var_114_11.transform.localScale.y * var_114_17, var_114_11.transform.localScale.z)
			end

			local var_114_18 = manager.ui.mainCamera.transform
			local var_114_19 = 1.26666666666667

			if var_114_19 < arg_111_1.time_ and arg_111_1.time_ <= var_114_19 + arg_114_0 then
				local var_114_20 = arg_111_1.var_.effect3233

				if var_114_20 then
					Object.Destroy(var_114_20)

					arg_111_1.var_.effect3233 = nil
				end
			end

			local var_114_21 = 0

			if var_114_21 < arg_111_1.time_ and arg_111_1.time_ <= var_114_21 + arg_114_0 then
				arg_111_1.allBtn_.enabled = false
			end

			local var_114_22 = 1.26666666666667

			if arg_111_1.time_ >= var_114_21 + var_114_22 and arg_111_1.time_ < var_114_21 + var_114_22 + arg_114_0 then
				arg_111_1.allBtn_.enabled = true
			end

			local var_114_23
			local var_114_24 = 0

			if var_114_24 < arg_111_1.time_ and arg_111_1.time_ <= var_114_24 + arg_114_0 then
				local var_114_25 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_114_25 then
					var_114_25.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_114_25.radialBlurScale = 0.521
					var_114_25.radialBlurGradient = 1
					var_114_25.radialBlurIntensity = 1

					if var_114_23 then
						var_114_25.radialBlurTarget = var_114_23.transform
					end
				end
			end

			local var_114_26 = 0.633333333333333

			if var_114_24 <= arg_111_1.time_ and arg_111_1.time_ < var_114_24 + var_114_26 then
				local var_114_27 = (arg_111_1.time_ - var_114_24) / var_114_26
				local var_114_28 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_114_28 then
					var_114_28.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_114_28.radialBlurScale = Mathf.Lerp(0.521, 0, var_114_27)
					var_114_28.radialBlurGradient = Mathf.Lerp(1, 1, var_114_27)
					var_114_28.radialBlurIntensity = Mathf.Lerp(1, 1, var_114_27)
				end
			end

			if arg_111_1.time_ >= var_114_24 + var_114_26 and arg_111_1.time_ < var_114_24 + var_114_26 + arg_114_0 then
				local var_114_29 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_114_29 then
					var_114_29.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_114_29.radialBlurScale = 0
					var_114_29.radialBlurGradient = 1
					var_114_29.radialBlurIntensity = 1
				end
			end

			if arg_111_1.frameCnt_ <= 1 then
				arg_111_1.dialog_:SetActive(false)
			end

			local var_114_30 = 0.866666666666667
			local var_114_31 = 0.95

			if var_114_30 < arg_111_1.time_ and arg_111_1.time_ <= var_114_30 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0

				arg_111_1.dialog_:SetActive(true)

				arg_111_1.dialogCg_.alpha = 0

				local var_114_32 = LeanTween.value(arg_111_1.dialog_, 0, 1, 0.3)

				var_114_32:setOnUpdate(LuaHelper.FloatAction(function(arg_115_0)
					arg_111_1.dialogCg_.alpha = arg_115_0
				end))
				var_114_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_111_1.dialog_)
					var_114_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_111_1.duration_ = arg_111_1.duration_ + 0.3

				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_33 = arg_111_1:GetWordFromCfg(324021027)
				local var_114_34 = arg_111_1:FormatText(var_114_33.content)

				arg_111_1.text_.text = var_114_34

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_35 = 38
				local var_114_36 = utf8.len(var_114_34)
				local var_114_37 = var_114_35 <= 0 and var_114_31 or var_114_31 * (var_114_36 / var_114_35)

				if var_114_37 > 0 and var_114_31 < var_114_37 then
					arg_111_1.talkMaxDuration = var_114_37
					var_114_30 = var_114_30 + 0.3

					if var_114_37 + var_114_30 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_37 + var_114_30
					end
				end

				arg_111_1.text_.text = var_114_34
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_38 = var_114_30 + 0.3
			local var_114_39 = math.max(var_114_31, arg_111_1.talkMaxDuration)

			if var_114_38 <= arg_111_1.time_ and arg_111_1.time_ < var_114_38 + var_114_39 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_38) / var_114_39

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_38 + var_114_39 and arg_111_1.time_ < var_114_38 + var_114_39 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play324021028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 324021028
		arg_117_1.duration_ = 2.47

		local var_117_0 = {
			zh = 2.2,
			ja = 2.466
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
				arg_117_0:Play324021029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1070ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1070ui_story == nil then
				arg_117_1.var_.characterEffect1070ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1070ui_story and not isNil(var_120_0) then
					arg_117_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1070ui_story then
				arg_117_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_120_4 = 0
			local var_120_5 = 0.325

			if var_120_4 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_6 = arg_117_1:FormatText(StoryNameCfg[318].name)

				arg_117_1.leftNameTxt_.text = var_120_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, true)
				arg_117_1.iconController_:SetSelectedState("hero")

				arg_117_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_117_1.callingController_:SetSelectedState("normal")

				arg_117_1.keyicon_.color = Color.New(1, 1, 1)
				arg_117_1.icon_.color = Color.New(1, 1, 1)

				local var_120_7 = arg_117_1:GetWordFromCfg(324021028)
				local var_120_8 = arg_117_1:FormatText(var_120_7.content)

				arg_117_1.text_.text = var_120_8

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_9 = 13
				local var_120_10 = utf8.len(var_120_8)
				local var_120_11 = var_120_9 <= 0 and var_120_5 or var_120_5 * (var_120_10 / var_120_9)

				if var_120_11 > 0 and var_120_5 < var_120_11 then
					arg_117_1.talkMaxDuration = var_120_11

					if var_120_11 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_4
					end
				end

				arg_117_1.text_.text = var_120_8
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324021", "324021028", "story_v_out_324021.awb") ~= 0 then
					local var_120_12 = manager.audio:GetVoiceLength("story_v_out_324021", "324021028", "story_v_out_324021.awb") / 1000

					if var_120_12 + var_120_4 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_4
					end

					if var_120_7.prefab_name ~= "" and arg_117_1.actors_[var_120_7.prefab_name] ~= nil then
						local var_120_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_7.prefab_name].transform, "story_v_out_324021", "324021028", "story_v_out_324021.awb")

						arg_117_1:RecordAudio("324021028", var_120_13)
						arg_117_1:RecordAudio("324021028", var_120_13)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_324021", "324021028", "story_v_out_324021.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_324021", "324021028", "story_v_out_324021.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_5, arg_117_1.talkMaxDuration)

			if var_120_4 <= arg_117_1.time_ and arg_117_1.time_ < var_120_4 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_4) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_4 + var_120_14 and arg_117_1.time_ < var_120_4 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play324021029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 324021029
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
			arg_121_1.auto_ = false
		end

		function arg_121_1.playNext_(arg_123_0)
			arg_121_1.onStoryFinished_()
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1070ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1070ui_story == nil then
				arg_121_1.var_.characterEffect1070ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1070ui_story and not isNil(var_124_0) then
					local var_124_4 = Mathf.Lerp(0, 0.5, var_124_3)

					arg_121_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1070ui_story.fillRatio = var_124_4
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1070ui_story then
				local var_124_5 = 0.5

				arg_121_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1070ui_story.fillRatio = var_124_5
			end

			local var_124_6 = 0
			local var_124_7 = 1

			if var_124_6 < arg_121_1.time_ and arg_121_1.time_ <= var_124_6 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, false)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_8 = arg_121_1:GetWordFromCfg(324021029)
				local var_124_9 = arg_121_1:FormatText(var_124_8.content)

				arg_121_1.text_.text = var_124_9

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_10 = 40
				local var_124_11 = utf8.len(var_124_9)
				local var_124_12 = var_124_10 <= 0 and var_124_7 or var_124_7 * (var_124_11 / var_124_10)

				if var_124_12 > 0 and var_124_7 < var_124_12 then
					arg_121_1.talkMaxDuration = var_124_12

					if var_124_12 + var_124_6 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_12 + var_124_6
					end
				end

				arg_121_1.text_.text = var_124_9
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_13 = math.max(var_124_7, arg_121_1.talkMaxDuration)

			if var_124_6 <= arg_121_1.time_ and arg_121_1.time_ < var_124_6 + var_124_13 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_6) / var_124_13

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_6 + var_124_13 and arg_121_1.time_ < var_124_6 + var_124_13 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2003",
		"TextureConfig/Background/J16f"
	},
	voices = {
		"story_v_out_324021.awb"
	}
}
