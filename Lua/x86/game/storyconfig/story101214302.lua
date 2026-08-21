return {
	Play121432001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 121432001
		arg_1_1.duration_ = 11.27

		local var_1_0 = {
			ja = 11.266,
			ko = 8.2,
			zh = 8.2
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
				arg_1_0:Play121432002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "J03f"

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
				local var_4_5 = arg_1_1.bgs_.J03f

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
					if iter_4_0 ~= "J03f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = "1072ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "1072ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "1072ui_story"), arg_1_1.stage_.transform)

					var_4_24.name = var_4_22
					var_4_24.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_22] = var_4_24

					local var_4_25 = var_4_24:GetComponentInChildren(typeof(CharacterEffect))

					var_4_25.enabled = true

					local var_4_26 = GameObjectTools.GetOrAddComponent(var_4_24, typeof(DynamicBoneHelper))

					if var_4_26 then
						var_4_26:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_25.transform, false)

					arg_1_1.var_[var_4_22 .. "Animator"] = var_4_25.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_22 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_22 .. "LipSync"] = var_4_25.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_27 = arg_1_1.actors_["1072ui_story"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos1072ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(-0.7, -0.71, -6)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1072ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["1072ui_story"]
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1072ui_story == nil then
				arg_1_1.var_.characterEffect1072ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect1072ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect1072ui_story then
				arg_1_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_4_40 = 1.8

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_4_42 = "1074ui_story"

			if arg_1_1.actors_[var_4_42] == nil then
				local var_4_43 = Asset.Load("Char/" .. "1074ui_story")

				if not isNil(var_4_43) then
					local var_4_44 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_1_1.stage_.transform)

					var_4_44.name = var_4_42
					var_4_44.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_42] = var_4_44

					local var_4_45 = var_4_44:GetComponentInChildren(typeof(CharacterEffect))

					var_4_45.enabled = true

					local var_4_46 = GameObjectTools.GetOrAddComponent(var_4_44, typeof(DynamicBoneHelper))

					if var_4_46 then
						var_4_46:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_45.transform, false)

					arg_1_1.var_[var_4_42 .. "Animator"] = var_4_45.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_42 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_42 .. "LipSync"] = var_4_45.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_47 = arg_1_1.actors_["1074ui_story"].transform
			local var_4_48 = 1.8

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				arg_1_1.var_.moveOldPos1074ui_story = var_4_47.localPosition
			end

			local var_4_49 = 0.001

			if var_4_48 <= arg_1_1.time_ and arg_1_1.time_ < var_4_48 + var_4_49 then
				local var_4_50 = (arg_1_1.time_ - var_4_48) / var_4_49
				local var_4_51 = Vector3.New(0.7, -1.055, -6.12)

				var_4_47.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1074ui_story, var_4_51, var_4_50)

				local var_4_52 = manager.ui.mainCamera.transform.position - var_4_47.position

				var_4_47.forward = Vector3.New(var_4_52.x, var_4_52.y, var_4_52.z)

				local var_4_53 = var_4_47.localEulerAngles

				var_4_53.z = 0
				var_4_53.x = 0
				var_4_47.localEulerAngles = var_4_53
			end

			if arg_1_1.time_ >= var_4_48 + var_4_49 and arg_1_1.time_ < var_4_48 + var_4_49 + arg_4_0 then
				var_4_47.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_4_54 = manager.ui.mainCamera.transform.position - var_4_47.position

				var_4_47.forward = Vector3.New(var_4_54.x, var_4_54.y, var_4_54.z)

				local var_4_55 = var_4_47.localEulerAngles

				var_4_55.z = 0
				var_4_55.x = 0
				var_4_47.localEulerAngles = var_4_55
			end

			local var_4_56 = 1.8

			if var_4_56 < arg_1_1.time_ and arg_1_1.time_ <= var_4_56 + arg_4_0 then
				arg_1_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_4_57 = 1.8

			if var_4_57 < arg_1_1.time_ and arg_1_1.time_ <= var_4_57 + arg_4_0 then
				arg_1_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_4_58 = arg_1_1.actors_["1074ui_story"]
			local var_4_59 = 0

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 and not isNil(var_4_58) and arg_1_1.var_.characterEffect1074ui_story == nil then
				arg_1_1.var_.characterEffect1074ui_story = var_4_58:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_60 = 0.0166666666666667

			if var_4_59 <= arg_1_1.time_ and arg_1_1.time_ < var_4_59 + var_4_60 and not isNil(var_4_58) then
				local var_4_61 = (arg_1_1.time_ - var_4_59) / var_4_60

				if arg_1_1.var_.characterEffect1074ui_story and not isNil(var_4_58) then
					local var_4_62 = Mathf.Lerp(0, 0.5, var_4_61)

					arg_1_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_1_1.var_.characterEffect1074ui_story.fillRatio = var_4_62
				end
			end

			if arg_1_1.time_ >= var_4_59 + var_4_60 and arg_1_1.time_ < var_4_59 + var_4_60 + arg_4_0 and not isNil(var_4_58) and arg_1_1.var_.characterEffect1074ui_story then
				local var_4_63 = 0.5

				arg_1_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_1_1.var_.characterEffect1074ui_story.fillRatio = var_4_63
			end

			local var_4_64 = 0
			local var_4_65 = 1

			if var_4_64 < arg_1_1.time_ and arg_1_1.time_ <= var_4_64 + arg_4_0 then
				local var_4_66 = "play"
				local var_4_67 = "music"

				arg_1_1:AudioAction(var_4_66, var_4_67, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_68 = ""
				local var_4_69 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_69 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_69 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_69

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_69
						arg_1_1.bgmTxt2_.text = var_4_69
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

			local var_4_70 = 0.571222096681595
			local var_4_71 = 1

			if var_4_70 < arg_1_1.time_ and arg_1_1.time_ <= var_4_70 + arg_4_0 then
				local var_4_72 = "play"
				local var_4_73 = "music"

				arg_1_1:AudioAction(var_4_72, var_4_73, "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu.awb")

				local var_4_74 = ""
				local var_4_75 = manager.audio:GetAudioName("bgm_activity_2_0_story_jingdu", "bgm_activity_2_0_story_jingdu")

				if var_4_75 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_75 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_75

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_75
						arg_1_1.bgmTxt2_.text = var_4_75
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

			local var_4_76 = 2
			local var_4_77 = 0.65

			if var_4_76 < arg_1_1.time_ and arg_1_1.time_ <= var_4_76 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_78 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_78:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_78:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_78:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_79 = arg_1_1:FormatText(StoryNameCfg[379].name)

				arg_1_1.leftNameTxt_.text = var_4_79

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_80 = arg_1_1:GetWordFromCfg(121432001)
				local var_4_81 = arg_1_1:FormatText(var_4_80.content)

				arg_1_1.text_.text = var_4_81

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_82 = 26
				local var_4_83 = utf8.len(var_4_81)
				local var_4_84 = var_4_82 <= 0 and var_4_77 or var_4_77 * (var_4_83 / var_4_82)

				if var_4_84 > 0 and var_4_77 < var_4_84 then
					arg_1_1.talkMaxDuration = var_4_84
					var_4_76 = var_4_76 + 0.3

					if var_4_84 + var_4_76 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_84 + var_4_76
					end
				end

				arg_1_1.text_.text = var_4_81
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432001", "story_v_out_121432.awb") ~= 0 then
					local var_4_85 = manager.audio:GetVoiceLength("story_v_out_121432", "121432001", "story_v_out_121432.awb") / 1000

					if var_4_85 + var_4_76 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_85 + var_4_76
					end

					if var_4_80.prefab_name ~= "" and arg_1_1.actors_[var_4_80.prefab_name] ~= nil then
						local var_4_86 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_80.prefab_name].transform, "story_v_out_121432", "121432001", "story_v_out_121432.awb")

						arg_1_1:RecordAudio("121432001", var_4_86)
						arg_1_1:RecordAudio("121432001", var_4_86)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_121432", "121432001", "story_v_out_121432.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_121432", "121432001", "story_v_out_121432.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_87 = var_4_76 + 0.3
			local var_4_88 = math.max(var_4_77, arg_1_1.talkMaxDuration)

			if var_4_87 <= arg_1_1.time_ and arg_1_1.time_ < var_4_87 + var_4_88 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_87) / var_4_88

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_87 + var_4_88 and arg_1_1.time_ < var_4_87 + var_4_88 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play121432002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 121432002
		arg_9_1.duration_ = 3.27

		local var_9_0 = {
			ja = 2.533,
			ko = 3.266,
			zh = 3.266
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
				arg_9_0:Play121432003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["1072ui_story"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos1072ui_story = var_12_0.localPosition
			end

			local var_12_2 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2
				local var_12_4 = Vector3.New(-0.7, -0.71, -6)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1072ui_story, var_12_4, var_12_3)

				local var_12_5 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_5.x, var_12_5.y, var_12_5.z)

				local var_12_6 = var_12_0.localEulerAngles

				var_12_6.z = 0
				var_12_6.x = 0
				var_12_0.localEulerAngles = var_12_6
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_12_7 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_7.x, var_12_7.y, var_12_7.z)

				local var_12_8 = var_12_0.localEulerAngles

				var_12_8.z = 0
				var_12_8.x = 0
				var_12_0.localEulerAngles = var_12_8
			end

			local var_12_9 = 0

			if var_12_9 < arg_9_1.time_ and arg_9_1.time_ <= var_12_9 + arg_12_0 then
				arg_9_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_12_10 = 0

			if var_12_10 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_12_11 = 0
			local var_12_12 = 0.425

			if var_12_11 < arg_9_1.time_ and arg_9_1.time_ <= var_12_11 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_13 = arg_9_1:FormatText(StoryNameCfg[379].name)

				arg_9_1.leftNameTxt_.text = var_12_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_14 = arg_9_1:GetWordFromCfg(121432002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_16 = 17
				local var_12_17 = utf8.len(var_12_15)
				local var_12_18 = var_12_16 <= 0 and var_12_12 or var_12_12 * (var_12_17 / var_12_16)

				if var_12_18 > 0 and var_12_12 < var_12_18 then
					arg_9_1.talkMaxDuration = var_12_18

					if var_12_18 + var_12_11 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_11
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432002", "story_v_out_121432.awb") ~= 0 then
					local var_12_19 = manager.audio:GetVoiceLength("story_v_out_121432", "121432002", "story_v_out_121432.awb") / 1000

					if var_12_19 + var_12_11 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_19 + var_12_11
					end

					if var_12_14.prefab_name ~= "" and arg_9_1.actors_[var_12_14.prefab_name] ~= nil then
						local var_12_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_14.prefab_name].transform, "story_v_out_121432", "121432002", "story_v_out_121432.awb")

						arg_9_1:RecordAudio("121432002", var_12_20)
						arg_9_1:RecordAudio("121432002", var_12_20)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_121432", "121432002", "story_v_out_121432.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_121432", "121432002", "story_v_out_121432.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_21 = math.max(var_12_12, arg_9_1.talkMaxDuration)

			if var_12_11 <= arg_9_1.time_ and arg_9_1.time_ < var_12_11 + var_12_21 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_11) / var_12_21

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_11 + var_12_21 and arg_9_1.time_ < var_12_11 + var_12_21 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play121432003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 121432003
		arg_13_1.duration_ = 12.27

		local var_13_0 = {
			ja = 12.266,
			ko = 4.266,
			zh = 4.266
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
				arg_13_0:Play121432004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["1074ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1074ui_story == nil then
				arg_13_1.var_.characterEffect1074ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect1074ui_story and not isNil(var_16_0) then
					arg_13_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect1074ui_story then
				arg_13_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_16_4 = 0

			if var_16_4 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_16_5 = 0

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_16_6 = arg_13_1.actors_["1072ui_story"]
			local var_16_7 = 0

			if var_16_7 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 and not isNil(var_16_6) and arg_13_1.var_.characterEffect1072ui_story == nil then
				arg_13_1.var_.characterEffect1072ui_story = var_16_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_8 = 0.200000002980232

			if var_16_7 <= arg_13_1.time_ and arg_13_1.time_ < var_16_7 + var_16_8 and not isNil(var_16_6) then
				local var_16_9 = (arg_13_1.time_ - var_16_7) / var_16_8

				if arg_13_1.var_.characterEffect1072ui_story and not isNil(var_16_6) then
					local var_16_10 = Mathf.Lerp(0, 0.5, var_16_9)

					arg_13_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1072ui_story.fillRatio = var_16_10
				end
			end

			if arg_13_1.time_ >= var_16_7 + var_16_8 and arg_13_1.time_ < var_16_7 + var_16_8 + arg_16_0 and not isNil(var_16_6) and arg_13_1.var_.characterEffect1072ui_story then
				local var_16_11 = 0.5

				arg_13_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1072ui_story.fillRatio = var_16_11
			end

			local var_16_12 = 0
			local var_16_13 = 0.6

			if var_16_12 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_14 = arg_13_1:FormatText(StoryNameCfg[410].name)

				arg_13_1.leftNameTxt_.text = var_16_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_15 = arg_13_1:GetWordFromCfg(121432003)
				local var_16_16 = arg_13_1:FormatText(var_16_15.content)

				arg_13_1.text_.text = var_16_16

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_17 = 24
				local var_16_18 = utf8.len(var_16_16)
				local var_16_19 = var_16_17 <= 0 and var_16_13 or var_16_13 * (var_16_18 / var_16_17)

				if var_16_19 > 0 and var_16_13 < var_16_19 then
					arg_13_1.talkMaxDuration = var_16_19

					if var_16_19 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_19 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_16
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432003", "story_v_out_121432.awb") ~= 0 then
					local var_16_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432003", "story_v_out_121432.awb") / 1000

					if var_16_20 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_20 + var_16_12
					end

					if var_16_15.prefab_name ~= "" and arg_13_1.actors_[var_16_15.prefab_name] ~= nil then
						local var_16_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_15.prefab_name].transform, "story_v_out_121432", "121432003", "story_v_out_121432.awb")

						arg_13_1:RecordAudio("121432003", var_16_21)
						arg_13_1:RecordAudio("121432003", var_16_21)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_121432", "121432003", "story_v_out_121432.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_121432", "121432003", "story_v_out_121432.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_22 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_22 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_22

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_22 and arg_13_1.time_ < var_16_12 + var_16_22 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play121432004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 121432004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play121432005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1072ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1072ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1072ui_story, var_20_4, var_20_3)

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

			local var_20_9 = arg_17_1.actors_["1072ui_story"]
			local var_20_10 = 0

			if var_20_10 < arg_17_1.time_ and arg_17_1.time_ <= var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1072ui_story == nil then
				arg_17_1.var_.characterEffect1072ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_11 = 0.200000002980232

			if var_20_10 <= arg_17_1.time_ and arg_17_1.time_ < var_20_10 + var_20_11 and not isNil(var_20_9) then
				local var_20_12 = (arg_17_1.time_ - var_20_10) / var_20_11

				if arg_17_1.var_.characterEffect1072ui_story and not isNil(var_20_9) then
					local var_20_13 = Mathf.Lerp(0, 0.5, var_20_12)

					arg_17_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1072ui_story.fillRatio = var_20_13
				end
			end

			if arg_17_1.time_ >= var_20_10 + var_20_11 and arg_17_1.time_ < var_20_10 + var_20_11 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1072ui_story then
				local var_20_14 = 0.5

				arg_17_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1072ui_story.fillRatio = var_20_14
			end

			local var_20_15 = arg_17_1.actors_["1074ui_story"].transform
			local var_20_16 = 0

			if var_20_16 < arg_17_1.time_ and arg_17_1.time_ <= var_20_16 + arg_20_0 then
				arg_17_1.var_.moveOldPos1074ui_story = var_20_15.localPosition
			end

			local var_20_17 = 0.001

			if var_20_16 <= arg_17_1.time_ and arg_17_1.time_ < var_20_16 + var_20_17 then
				local var_20_18 = (arg_17_1.time_ - var_20_16) / var_20_17
				local var_20_19 = Vector3.New(0, 100, 0)

				var_20_15.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1074ui_story, var_20_19, var_20_18)

				local var_20_20 = manager.ui.mainCamera.transform.position - var_20_15.position

				var_20_15.forward = Vector3.New(var_20_20.x, var_20_20.y, var_20_20.z)

				local var_20_21 = var_20_15.localEulerAngles

				var_20_21.z = 0
				var_20_21.x = 0
				var_20_15.localEulerAngles = var_20_21
			end

			if arg_17_1.time_ >= var_20_16 + var_20_17 and arg_17_1.time_ < var_20_16 + var_20_17 + arg_20_0 then
				var_20_15.localPosition = Vector3.New(0, 100, 0)

				local var_20_22 = manager.ui.mainCamera.transform.position - var_20_15.position

				var_20_15.forward = Vector3.New(var_20_22.x, var_20_22.y, var_20_22.z)

				local var_20_23 = var_20_15.localEulerAngles

				var_20_23.z = 0
				var_20_23.x = 0
				var_20_15.localEulerAngles = var_20_23
			end

			local var_20_24 = arg_17_1.actors_["1074ui_story"]
			local var_20_25 = 0

			if var_20_25 < arg_17_1.time_ and arg_17_1.time_ <= var_20_25 + arg_20_0 and not isNil(var_20_24) and arg_17_1.var_.characterEffect1074ui_story == nil then
				arg_17_1.var_.characterEffect1074ui_story = var_20_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_26 = 0.200000002980232

			if var_20_25 <= arg_17_1.time_ and arg_17_1.time_ < var_20_25 + var_20_26 and not isNil(var_20_24) then
				local var_20_27 = (arg_17_1.time_ - var_20_25) / var_20_26

				if arg_17_1.var_.characterEffect1074ui_story and not isNil(var_20_24) then
					local var_20_28 = Mathf.Lerp(0, 0.5, var_20_27)

					arg_17_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1074ui_story.fillRatio = var_20_28
				end
			end

			if arg_17_1.time_ >= var_20_25 + var_20_26 and arg_17_1.time_ < var_20_25 + var_20_26 + arg_20_0 and not isNil(var_20_24) and arg_17_1.var_.characterEffect1074ui_story then
				local var_20_29 = 0.5

				arg_17_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1074ui_story.fillRatio = var_20_29
			end

			local var_20_30 = 0
			local var_20_31 = 0.7

			if var_20_30 < arg_17_1.time_ and arg_17_1.time_ <= var_20_30 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_32 = arg_17_1:GetWordFromCfg(121432004)
				local var_20_33 = arg_17_1:FormatText(var_20_32.content)

				arg_17_1.text_.text = var_20_33

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_34 = 28
				local var_20_35 = utf8.len(var_20_33)
				local var_20_36 = var_20_34 <= 0 and var_20_31 or var_20_31 * (var_20_35 / var_20_34)

				if var_20_36 > 0 and var_20_31 < var_20_36 then
					arg_17_1.talkMaxDuration = var_20_36

					if var_20_36 + var_20_30 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_36 + var_20_30
					end
				end

				arg_17_1.text_.text = var_20_33
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_37 = math.max(var_20_31, arg_17_1.talkMaxDuration)

			if var_20_30 <= arg_17_1.time_ and arg_17_1.time_ < var_20_30 + var_20_37 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_30) / var_20_37

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_30 + var_20_37 and arg_17_1.time_ < var_20_30 + var_20_37 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play121432005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 121432005
		arg_21_1.duration_ = 9.47

		local var_21_0 = {
			ja = 9.466,
			ko = 7.5,
			zh = 7.5
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
				arg_21_0:Play121432006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = arg_21_1.actors_["1072ui_story"].transform
			local var_24_1 = 0

			if var_24_1 < arg_21_1.time_ and arg_21_1.time_ <= var_24_1 + arg_24_0 then
				arg_21_1.var_.moveOldPos1072ui_story = var_24_0.localPosition
			end

			local var_24_2 = 0.001

			if var_24_1 <= arg_21_1.time_ and arg_21_1.time_ < var_24_1 + var_24_2 then
				local var_24_3 = (arg_21_1.time_ - var_24_1) / var_24_2
				local var_24_4 = Vector3.New(-0.7, -0.71, -6)

				var_24_0.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1072ui_story, var_24_4, var_24_3)

				local var_24_5 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_5.x, var_24_5.y, var_24_5.z)

				local var_24_6 = var_24_0.localEulerAngles

				var_24_6.z = 0
				var_24_6.x = 0
				var_24_0.localEulerAngles = var_24_6
			end

			if arg_21_1.time_ >= var_24_1 + var_24_2 and arg_21_1.time_ < var_24_1 + var_24_2 + arg_24_0 then
				var_24_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_24_7 = manager.ui.mainCamera.transform.position - var_24_0.position

				var_24_0.forward = Vector3.New(var_24_7.x, var_24_7.y, var_24_7.z)

				local var_24_8 = var_24_0.localEulerAngles

				var_24_8.z = 0
				var_24_8.x = 0
				var_24_0.localEulerAngles = var_24_8
			end

			local var_24_9 = arg_21_1.actors_["1072ui_story"]
			local var_24_10 = 0

			if var_24_10 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1072ui_story == nil then
				arg_21_1.var_.characterEffect1072ui_story = var_24_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.200000002980232

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_11 and not isNil(var_24_9) then
				local var_24_12 = (arg_21_1.time_ - var_24_10) / var_24_11

				if arg_21_1.var_.characterEffect1072ui_story and not isNil(var_24_9) then
					local var_24_13 = Mathf.Lerp(0, 0.5, var_24_12)

					arg_21_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1072ui_story.fillRatio = var_24_13
				end
			end

			if arg_21_1.time_ >= var_24_10 + var_24_11 and arg_21_1.time_ < var_24_10 + var_24_11 + arg_24_0 and not isNil(var_24_9) and arg_21_1.var_.characterEffect1072ui_story then
				local var_24_14 = 0.5

				arg_21_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1072ui_story.fillRatio = var_24_14
			end

			local var_24_15 = arg_21_1.actors_["1074ui_story"].transform
			local var_24_16 = 0

			if var_24_16 < arg_21_1.time_ and arg_21_1.time_ <= var_24_16 + arg_24_0 then
				arg_21_1.var_.moveOldPos1074ui_story = var_24_15.localPosition
			end

			local var_24_17 = 0.001

			if var_24_16 <= arg_21_1.time_ and arg_21_1.time_ < var_24_16 + var_24_17 then
				local var_24_18 = (arg_21_1.time_ - var_24_16) / var_24_17
				local var_24_19 = Vector3.New(0.7, -1.055, -6.12)

				var_24_15.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1074ui_story, var_24_19, var_24_18)

				local var_24_20 = manager.ui.mainCamera.transform.position - var_24_15.position

				var_24_15.forward = Vector3.New(var_24_20.x, var_24_20.y, var_24_20.z)

				local var_24_21 = var_24_15.localEulerAngles

				var_24_21.z = 0
				var_24_21.x = 0
				var_24_15.localEulerAngles = var_24_21
			end

			if arg_21_1.time_ >= var_24_16 + var_24_17 and arg_21_1.time_ < var_24_16 + var_24_17 + arg_24_0 then
				var_24_15.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_24_22 = manager.ui.mainCamera.transform.position - var_24_15.position

				var_24_15.forward = Vector3.New(var_24_22.x, var_24_22.y, var_24_22.z)

				local var_24_23 = var_24_15.localEulerAngles

				var_24_23.z = 0
				var_24_23.x = 0
				var_24_15.localEulerAngles = var_24_23
			end

			local var_24_24 = arg_21_1.actors_["1074ui_story"]
			local var_24_25 = 0

			if var_24_25 < arg_21_1.time_ and arg_21_1.time_ <= var_24_25 + arg_24_0 and not isNil(var_24_24) and arg_21_1.var_.characterEffect1074ui_story == nil then
				arg_21_1.var_.characterEffect1074ui_story = var_24_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_26 = 0.200000002980232

			if var_24_25 <= arg_21_1.time_ and arg_21_1.time_ < var_24_25 + var_24_26 and not isNil(var_24_24) then
				local var_24_27 = (arg_21_1.time_ - var_24_25) / var_24_26

				if arg_21_1.var_.characterEffect1074ui_story and not isNil(var_24_24) then
					arg_21_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= var_24_25 + var_24_26 and arg_21_1.time_ < var_24_25 + var_24_26 + arg_24_0 and not isNil(var_24_24) and arg_21_1.var_.characterEffect1074ui_story then
				arg_21_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_24_28 = 0

			if var_24_28 < arg_21_1.time_ and arg_21_1.time_ <= var_24_28 + arg_24_0 then
				arg_21_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_24_29 = 0

			if var_24_29 < arg_21_1.time_ and arg_21_1.time_ <= var_24_29 + arg_24_0 then
				arg_21_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_24_30 = 0
			local var_24_31 = 0.925

			if var_24_30 < arg_21_1.time_ and arg_21_1.time_ <= var_24_30 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				local var_24_32 = arg_21_1:FormatText(StoryNameCfg[410].name)

				arg_21_1.leftNameTxt_.text = var_24_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_33 = arg_21_1:GetWordFromCfg(121432005)
				local var_24_34 = arg_21_1:FormatText(var_24_33.content)

				arg_21_1.text_.text = var_24_34

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_35 = 37
				local var_24_36 = utf8.len(var_24_34)
				local var_24_37 = var_24_35 <= 0 and var_24_31 or var_24_31 * (var_24_36 / var_24_35)

				if var_24_37 > 0 and var_24_31 < var_24_37 then
					arg_21_1.talkMaxDuration = var_24_37

					if var_24_37 + var_24_30 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_37 + var_24_30
					end
				end

				arg_21_1.text_.text = var_24_34
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432005", "story_v_out_121432.awb") ~= 0 then
					local var_24_38 = manager.audio:GetVoiceLength("story_v_out_121432", "121432005", "story_v_out_121432.awb") / 1000

					if var_24_38 + var_24_30 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_38 + var_24_30
					end

					if var_24_33.prefab_name ~= "" and arg_21_1.actors_[var_24_33.prefab_name] ~= nil then
						local var_24_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_33.prefab_name].transform, "story_v_out_121432", "121432005", "story_v_out_121432.awb")

						arg_21_1:RecordAudio("121432005", var_24_39)
						arg_21_1:RecordAudio("121432005", var_24_39)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_121432", "121432005", "story_v_out_121432.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_121432", "121432005", "story_v_out_121432.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_40 = math.max(var_24_31, arg_21_1.talkMaxDuration)

			if var_24_30 <= arg_21_1.time_ and arg_21_1.time_ < var_24_30 + var_24_40 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_30) / var_24_40

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_30 + var_24_40 and arg_21_1.time_ < var_24_30 + var_24_40 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play121432006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 121432006
		arg_25_1.duration_ = 2.53

		local var_25_0 = {
			ja = 2.133,
			ko = 2.533,
			zh = 2.533
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
				arg_25_0:Play121432007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1072ui_story"]
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1072ui_story == nil then
				arg_25_1.var_.characterEffect1072ui_story = var_28_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 and not isNil(var_28_0) then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2

				if arg_25_1.var_.characterEffect1072ui_story and not isNil(var_28_0) then
					arg_25_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 and not isNil(var_28_0) and arg_25_1.var_.characterEffect1072ui_story then
				arg_25_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_28_4 = 0

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_28_5 = 0

			if var_28_5 < arg_25_1.time_ and arg_25_1.time_ <= var_28_5 + arg_28_0 then
				arg_25_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_28_6 = arg_25_1.actors_["1074ui_story"]
			local var_28_7 = 0

			if var_28_7 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect1074ui_story == nil then
				arg_25_1.var_.characterEffect1074ui_story = var_28_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_8 = 0.200000002980232

			if var_28_7 <= arg_25_1.time_ and arg_25_1.time_ < var_28_7 + var_28_8 and not isNil(var_28_6) then
				local var_28_9 = (arg_25_1.time_ - var_28_7) / var_28_8

				if arg_25_1.var_.characterEffect1074ui_story and not isNil(var_28_6) then
					local var_28_10 = Mathf.Lerp(0, 0.5, var_28_9)

					arg_25_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1074ui_story.fillRatio = var_28_10
				end
			end

			if arg_25_1.time_ >= var_28_7 + var_28_8 and arg_25_1.time_ < var_28_7 + var_28_8 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect1074ui_story then
				local var_28_11 = 0.5

				arg_25_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1074ui_story.fillRatio = var_28_11
			end

			local var_28_12 = 0
			local var_28_13 = 0.2

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_14 = arg_25_1:FormatText(StoryNameCfg[379].name)

				arg_25_1.leftNameTxt_.text = var_28_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_15 = arg_25_1:GetWordFromCfg(121432006)
				local var_28_16 = arg_25_1:FormatText(var_28_15.content)

				arg_25_1.text_.text = var_28_16

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_17 = 8
				local var_28_18 = utf8.len(var_28_16)
				local var_28_19 = var_28_17 <= 0 and var_28_13 or var_28_13 * (var_28_18 / var_28_17)

				if var_28_19 > 0 and var_28_13 < var_28_19 then
					arg_25_1.talkMaxDuration = var_28_19

					if var_28_19 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_19 + var_28_12
					end
				end

				arg_25_1.text_.text = var_28_16
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432006", "story_v_out_121432.awb") ~= 0 then
					local var_28_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432006", "story_v_out_121432.awb") / 1000

					if var_28_20 + var_28_12 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_20 + var_28_12
					end

					if var_28_15.prefab_name ~= "" and arg_25_1.actors_[var_28_15.prefab_name] ~= nil then
						local var_28_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_15.prefab_name].transform, "story_v_out_121432", "121432006", "story_v_out_121432.awb")

						arg_25_1:RecordAudio("121432006", var_28_21)
						arg_25_1:RecordAudio("121432006", var_28_21)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_121432", "121432006", "story_v_out_121432.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_121432", "121432006", "story_v_out_121432.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_22 = math.max(var_28_13, arg_25_1.talkMaxDuration)

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_22 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_12) / var_28_22

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_12 + var_28_22 and arg_25_1.time_ < var_28_12 + var_28_22 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play121432007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 121432007
		arg_29_1.duration_ = 7.47

		local var_29_0 = {
			ja = 7.466,
			ko = 4.6,
			zh = 4.6
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
				arg_29_0:Play121432008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1074ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos1074ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0.7, -1.055, -6.12)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1074ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["1074ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1074ui_story == nil then
				arg_29_1.var_.characterEffect1074ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect1074ui_story and not isNil(var_32_9) then
					arg_29_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect1074ui_story then
				arg_29_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_32_13 = 0

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_32_15 = arg_29_1.actors_["1072ui_story"]
			local var_32_16 = 0

			if var_32_16 < arg_29_1.time_ and arg_29_1.time_ <= var_32_16 + arg_32_0 and not isNil(var_32_15) and arg_29_1.var_.characterEffect1072ui_story == nil then
				arg_29_1.var_.characterEffect1072ui_story = var_32_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_17 = 0.200000002980232

			if var_32_16 <= arg_29_1.time_ and arg_29_1.time_ < var_32_16 + var_32_17 and not isNil(var_32_15) then
				local var_32_18 = (arg_29_1.time_ - var_32_16) / var_32_17

				if arg_29_1.var_.characterEffect1072ui_story and not isNil(var_32_15) then
					local var_32_19 = Mathf.Lerp(0, 0.5, var_32_18)

					arg_29_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1072ui_story.fillRatio = var_32_19
				end
			end

			if arg_29_1.time_ >= var_32_16 + var_32_17 and arg_29_1.time_ < var_32_16 + var_32_17 + arg_32_0 and not isNil(var_32_15) and arg_29_1.var_.characterEffect1072ui_story then
				local var_32_20 = 0.5

				arg_29_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1072ui_story.fillRatio = var_32_20
			end

			local var_32_21 = 0
			local var_32_22 = 0.5

			if var_32_21 < arg_29_1.time_ and arg_29_1.time_ <= var_32_21 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_23 = arg_29_1:FormatText(StoryNameCfg[410].name)

				arg_29_1.leftNameTxt_.text = var_32_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_24 = arg_29_1:GetWordFromCfg(121432007)
				local var_32_25 = arg_29_1:FormatText(var_32_24.content)

				arg_29_1.text_.text = var_32_25

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_26 = 20
				local var_32_27 = utf8.len(var_32_25)
				local var_32_28 = var_32_26 <= 0 and var_32_22 or var_32_22 * (var_32_27 / var_32_26)

				if var_32_28 > 0 and var_32_22 < var_32_28 then
					arg_29_1.talkMaxDuration = var_32_28

					if var_32_28 + var_32_21 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_28 + var_32_21
					end
				end

				arg_29_1.text_.text = var_32_25
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432007", "story_v_out_121432.awb") ~= 0 then
					local var_32_29 = manager.audio:GetVoiceLength("story_v_out_121432", "121432007", "story_v_out_121432.awb") / 1000

					if var_32_29 + var_32_21 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_29 + var_32_21
					end

					if var_32_24.prefab_name ~= "" and arg_29_1.actors_[var_32_24.prefab_name] ~= nil then
						local var_32_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_24.prefab_name].transform, "story_v_out_121432", "121432007", "story_v_out_121432.awb")

						arg_29_1:RecordAudio("121432007", var_32_30)
						arg_29_1:RecordAudio("121432007", var_32_30)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_121432", "121432007", "story_v_out_121432.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_121432", "121432007", "story_v_out_121432.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_31 = math.max(var_32_22, arg_29_1.talkMaxDuration)

			if var_32_21 <= arg_29_1.time_ and arg_29_1.time_ < var_32_21 + var_32_31 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_21) / var_32_31

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_21 + var_32_31 and arg_29_1.time_ < var_32_21 + var_32_31 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play121432008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 121432008
		arg_33_1.duration_ = 10.2

		local var_33_0 = {
			ja = 10.2,
			ko = 7.633,
			zh = 7.633
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play121432009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0
			local var_36_1 = 0.875

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_2 = arg_33_1:FormatText(StoryNameCfg[410].name)

				arg_33_1.leftNameTxt_.text = var_36_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:GetWordFromCfg(121432008)
				local var_36_4 = arg_33_1:FormatText(var_36_3.content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 35
				local var_36_6 = utf8.len(var_36_4)
				local var_36_7 = var_36_5 <= 0 and var_36_1 or var_36_1 * (var_36_6 / var_36_5)

				if var_36_7 > 0 and var_36_1 < var_36_7 then
					arg_33_1.talkMaxDuration = var_36_7

					if var_36_7 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_7 + var_36_0
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432008", "story_v_out_121432.awb") ~= 0 then
					local var_36_8 = manager.audio:GetVoiceLength("story_v_out_121432", "121432008", "story_v_out_121432.awb") / 1000

					if var_36_8 + var_36_0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_0
					end

					if var_36_3.prefab_name ~= "" and arg_33_1.actors_[var_36_3.prefab_name] ~= nil then
						local var_36_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_3.prefab_name].transform, "story_v_out_121432", "121432008", "story_v_out_121432.awb")

						arg_33_1:RecordAudio("121432008", var_36_9)
						arg_33_1:RecordAudio("121432008", var_36_9)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_121432", "121432008", "story_v_out_121432.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_121432", "121432008", "story_v_out_121432.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_10 = math.max(var_36_1, arg_33_1.talkMaxDuration)

			if var_36_0 <= arg_33_1.time_ and arg_33_1.time_ < var_36_0 + var_36_10 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_0) / var_36_10

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_0 + var_36_10 and arg_33_1.time_ < var_36_0 + var_36_10 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play121432009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 121432009
		arg_37_1.duration_ = 3.87

		local var_37_0 = {
			ja = 3.866,
			ko = 2.066,
			zh = 2.066
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
				arg_37_0:Play121432010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1072ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1072ui_story == nil then
				arg_37_1.var_.characterEffect1072ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1072ui_story and not isNil(var_40_0) then
					arg_37_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1072ui_story then
				arg_37_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_40_4 = 0

			if var_40_4 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_1")
			end

			local var_40_5 = 0

			if var_40_5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_40_6 = 0
			local var_40_7 = 0.175

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[379].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_9 = arg_37_1:GetWordFromCfg(121432009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 7
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

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432009", "story_v_out_121432.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_121432", "121432009", "story_v_out_121432.awb") / 1000

					if var_40_14 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_6
					end

					if var_40_9.prefab_name ~= "" and arg_37_1.actors_[var_40_9.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_9.prefab_name].transform, "story_v_out_121432", "121432009", "story_v_out_121432.awb")

						arg_37_1:RecordAudio("121432009", var_40_15)
						arg_37_1:RecordAudio("121432009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_121432", "121432009", "story_v_out_121432.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_121432", "121432009", "story_v_out_121432.awb")
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
	Play121432010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 121432010
		arg_41_1.duration_ = 12.47

		local var_41_0 = {
			ja = 12.466,
			ko = 12.3,
			zh = 12.3
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
				arg_41_0:Play121432011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["1074ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1074ui_story == nil then
				arg_41_1.var_.characterEffect1074ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect1074ui_story and not isNil(var_44_0) then
					arg_41_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect1074ui_story then
				arg_41_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_44_4 = 0

			if var_44_4 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_44_5 = 0

			if var_44_5 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_44_6 = arg_41_1.actors_["1072ui_story"]
			local var_44_7 = 0

			if var_44_7 < arg_41_1.time_ and arg_41_1.time_ <= var_44_7 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1072ui_story == nil then
				arg_41_1.var_.characterEffect1072ui_story = var_44_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_8 = 0.200000002980232

			if var_44_7 <= arg_41_1.time_ and arg_41_1.time_ < var_44_7 + var_44_8 and not isNil(var_44_6) then
				local var_44_9 = (arg_41_1.time_ - var_44_7) / var_44_8

				if arg_41_1.var_.characterEffect1072ui_story and not isNil(var_44_6) then
					local var_44_10 = Mathf.Lerp(0, 0.5, var_44_9)

					arg_41_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1072ui_story.fillRatio = var_44_10
				end
			end

			if arg_41_1.time_ >= var_44_7 + var_44_8 and arg_41_1.time_ < var_44_7 + var_44_8 + arg_44_0 and not isNil(var_44_6) and arg_41_1.var_.characterEffect1072ui_story then
				local var_44_11 = 0.5

				arg_41_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1072ui_story.fillRatio = var_44_11
			end

			local var_44_12 = 0
			local var_44_13 = 1.375

			if var_44_12 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_14 = arg_41_1:FormatText(StoryNameCfg[410].name)

				arg_41_1.leftNameTxt_.text = var_44_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_15 = arg_41_1:GetWordFromCfg(121432010)
				local var_44_16 = arg_41_1:FormatText(var_44_15.content)

				arg_41_1.text_.text = var_44_16

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 55
				local var_44_18 = utf8.len(var_44_16)
				local var_44_19 = var_44_17 <= 0 and var_44_13 or var_44_13 * (var_44_18 / var_44_17)

				if var_44_19 > 0 and var_44_13 < var_44_19 then
					arg_41_1.talkMaxDuration = var_44_19

					if var_44_19 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_19 + var_44_12
					end
				end

				arg_41_1.text_.text = var_44_16
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432010", "story_v_out_121432.awb") ~= 0 then
					local var_44_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432010", "story_v_out_121432.awb") / 1000

					if var_44_20 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_20 + var_44_12
					end

					if var_44_15.prefab_name ~= "" and arg_41_1.actors_[var_44_15.prefab_name] ~= nil then
						local var_44_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_15.prefab_name].transform, "story_v_out_121432", "121432010", "story_v_out_121432.awb")

						arg_41_1:RecordAudio("121432010", var_44_21)
						arg_41_1:RecordAudio("121432010", var_44_21)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_121432", "121432010", "story_v_out_121432.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_121432", "121432010", "story_v_out_121432.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_22 = math.max(var_44_13, arg_41_1.talkMaxDuration)

			if var_44_12 <= arg_41_1.time_ and arg_41_1.time_ < var_44_12 + var_44_22 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_12) / var_44_22

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_12 + var_44_22 and arg_41_1.time_ < var_44_12 + var_44_22 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play121432011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 121432011
		arg_45_1.duration_ = 6.13

		local var_45_0 = {
			ja = 6.133,
			ko = 4.5,
			zh = 4.5
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
				arg_45_0:Play121432012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = arg_45_1.actors_["1072ui_story"]
			local var_48_1 = 0

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1072ui_story == nil then
				arg_45_1.var_.characterEffect1072ui_story = var_48_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_2 and not isNil(var_48_0) then
				local var_48_3 = (arg_45_1.time_ - var_48_1) / var_48_2

				if arg_45_1.var_.characterEffect1072ui_story and not isNil(var_48_0) then
					arg_45_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= var_48_1 + var_48_2 and arg_45_1.time_ < var_48_1 + var_48_2 + arg_48_0 and not isNil(var_48_0) and arg_45_1.var_.characterEffect1072ui_story then
				arg_45_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_48_4 = 0

			if var_48_4 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_2")
			end

			local var_48_5 = 0

			if var_48_5 < arg_45_1.time_ and arg_45_1.time_ <= var_48_5 + arg_48_0 then
				arg_45_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_48_6 = arg_45_1.actors_["1074ui_story"]
			local var_48_7 = 0

			if var_48_7 < arg_45_1.time_ and arg_45_1.time_ <= var_48_7 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1074ui_story == nil then
				arg_45_1.var_.characterEffect1074ui_story = var_48_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_8 = 0.200000002980232

			if var_48_7 <= arg_45_1.time_ and arg_45_1.time_ < var_48_7 + var_48_8 and not isNil(var_48_6) then
				local var_48_9 = (arg_45_1.time_ - var_48_7) / var_48_8

				if arg_45_1.var_.characterEffect1074ui_story and not isNil(var_48_6) then
					local var_48_10 = Mathf.Lerp(0, 0.5, var_48_9)

					arg_45_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_45_1.var_.characterEffect1074ui_story.fillRatio = var_48_10
				end
			end

			if arg_45_1.time_ >= var_48_7 + var_48_8 and arg_45_1.time_ < var_48_7 + var_48_8 + arg_48_0 and not isNil(var_48_6) and arg_45_1.var_.characterEffect1074ui_story then
				local var_48_11 = 0.5

				arg_45_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_45_1.var_.characterEffect1074ui_story.fillRatio = var_48_11
			end

			local var_48_12 = 0
			local var_48_13 = 0.475

			if var_48_12 < arg_45_1.time_ and arg_45_1.time_ <= var_48_12 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_14 = arg_45_1:FormatText(StoryNameCfg[379].name)

				arg_45_1.leftNameTxt_.text = var_48_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_15 = arg_45_1:GetWordFromCfg(121432011)
				local var_48_16 = arg_45_1:FormatText(var_48_15.content)

				arg_45_1.text_.text = var_48_16

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_17 = 19
				local var_48_18 = utf8.len(var_48_16)
				local var_48_19 = var_48_17 <= 0 and var_48_13 or var_48_13 * (var_48_18 / var_48_17)

				if var_48_19 > 0 and var_48_13 < var_48_19 then
					arg_45_1.talkMaxDuration = var_48_19

					if var_48_19 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_19 + var_48_12
					end
				end

				arg_45_1.text_.text = var_48_16
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432011", "story_v_out_121432.awb") ~= 0 then
					local var_48_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432011", "story_v_out_121432.awb") / 1000

					if var_48_20 + var_48_12 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_20 + var_48_12
					end

					if var_48_15.prefab_name ~= "" and arg_45_1.actors_[var_48_15.prefab_name] ~= nil then
						local var_48_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_15.prefab_name].transform, "story_v_out_121432", "121432011", "story_v_out_121432.awb")

						arg_45_1:RecordAudio("121432011", var_48_21)
						arg_45_1:RecordAudio("121432011", var_48_21)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_121432", "121432011", "story_v_out_121432.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_121432", "121432011", "story_v_out_121432.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_22 = math.max(var_48_13, arg_45_1.talkMaxDuration)

			if var_48_12 <= arg_45_1.time_ and arg_45_1.time_ < var_48_12 + var_48_22 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_12) / var_48_22

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_12 + var_48_22 and arg_45_1.time_ < var_48_12 + var_48_22 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play121432012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 121432012
		arg_49_1.duration_ = 12.17

		local var_49_0 = {
			ja = 12.166,
			ko = 6.766,
			zh = 6.766
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
				arg_49_0:Play121432013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1074ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1074ui_story == nil then
				arg_49_1.var_.characterEffect1074ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect1074ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect1074ui_story then
				arg_49_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_52_4 = 0

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action6_1")
			end

			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_52_6 = arg_49_1.actors_["1072ui_story"]
			local var_52_7 = 0

			if var_52_7 < arg_49_1.time_ and arg_49_1.time_ <= var_52_7 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1072ui_story == nil then
				arg_49_1.var_.characterEffect1072ui_story = var_52_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_8 = 0.200000002980232

			if var_52_7 <= arg_49_1.time_ and arg_49_1.time_ < var_52_7 + var_52_8 and not isNil(var_52_6) then
				local var_52_9 = (arg_49_1.time_ - var_52_7) / var_52_8

				if arg_49_1.var_.characterEffect1072ui_story and not isNil(var_52_6) then
					local var_52_10 = Mathf.Lerp(0, 0.5, var_52_9)

					arg_49_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1072ui_story.fillRatio = var_52_10
				end
			end

			if arg_49_1.time_ >= var_52_7 + var_52_8 and arg_49_1.time_ < var_52_7 + var_52_8 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect1072ui_story then
				local var_52_11 = 0.5

				arg_49_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1072ui_story.fillRatio = var_52_11
			end

			local var_52_12 = 0
			local var_52_13 = 0.725

			if var_52_12 < arg_49_1.time_ and arg_49_1.time_ <= var_52_12 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_14 = arg_49_1:FormatText(StoryNameCfg[410].name)

				arg_49_1.leftNameTxt_.text = var_52_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_15 = arg_49_1:GetWordFromCfg(121432012)
				local var_52_16 = arg_49_1:FormatText(var_52_15.content)

				arg_49_1.text_.text = var_52_16

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_17 = 29
				local var_52_18 = utf8.len(var_52_16)
				local var_52_19 = var_52_17 <= 0 and var_52_13 or var_52_13 * (var_52_18 / var_52_17)

				if var_52_19 > 0 and var_52_13 < var_52_19 then
					arg_49_1.talkMaxDuration = var_52_19

					if var_52_19 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_19 + var_52_12
					end
				end

				arg_49_1.text_.text = var_52_16
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432012", "story_v_out_121432.awb") ~= 0 then
					local var_52_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432012", "story_v_out_121432.awb") / 1000

					if var_52_20 + var_52_12 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_20 + var_52_12
					end

					if var_52_15.prefab_name ~= "" and arg_49_1.actors_[var_52_15.prefab_name] ~= nil then
						local var_52_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_15.prefab_name].transform, "story_v_out_121432", "121432012", "story_v_out_121432.awb")

						arg_49_1:RecordAudio("121432012", var_52_21)
						arg_49_1:RecordAudio("121432012", var_52_21)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_121432", "121432012", "story_v_out_121432.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_121432", "121432012", "story_v_out_121432.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_22 = math.max(var_52_13, arg_49_1.talkMaxDuration)

			if var_52_12 <= arg_49_1.time_ and arg_49_1.time_ < var_52_12 + var_52_22 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_12) / var_52_22

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_12 + var_52_22 and arg_49_1.time_ < var_52_12 + var_52_22 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play121432013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 121432013
		arg_53_1.duration_ = 7.63

		local var_53_0 = {
			ja = 7.633,
			ko = 6.266,
			zh = 6.266
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
				arg_53_0:Play121432014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = arg_53_1.actors_["1072ui_story"]
			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1072ui_story == nil then
				arg_53_1.var_.characterEffect1072ui_story = var_56_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_2 = 0.200000002980232

			if var_56_1 <= arg_53_1.time_ and arg_53_1.time_ < var_56_1 + var_56_2 and not isNil(var_56_0) then
				local var_56_3 = (arg_53_1.time_ - var_56_1) / var_56_2

				if arg_53_1.var_.characterEffect1072ui_story and not isNil(var_56_0) then
					arg_53_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_1 + var_56_2 and arg_53_1.time_ < var_56_1 + var_56_2 + arg_56_0 and not isNil(var_56_0) and arg_53_1.var_.characterEffect1072ui_story then
				arg_53_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_56_4 = 0

			if var_56_4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_56_5 = 0

			if var_56_5 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_56_6 = arg_53_1.actors_["1074ui_story"]
			local var_56_7 = 0

			if var_56_7 < arg_53_1.time_ and arg_53_1.time_ <= var_56_7 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1074ui_story == nil then
				arg_53_1.var_.characterEffect1074ui_story = var_56_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_8 = 0.200000002980232

			if var_56_7 <= arg_53_1.time_ and arg_53_1.time_ < var_56_7 + var_56_8 and not isNil(var_56_6) then
				local var_56_9 = (arg_53_1.time_ - var_56_7) / var_56_8

				if arg_53_1.var_.characterEffect1074ui_story and not isNil(var_56_6) then
					local var_56_10 = Mathf.Lerp(0, 0.5, var_56_9)

					arg_53_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_53_1.var_.characterEffect1074ui_story.fillRatio = var_56_10
				end
			end

			if arg_53_1.time_ >= var_56_7 + var_56_8 and arg_53_1.time_ < var_56_7 + var_56_8 + arg_56_0 and not isNil(var_56_6) and arg_53_1.var_.characterEffect1074ui_story then
				local var_56_11 = 0.5

				arg_53_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_53_1.var_.characterEffect1074ui_story.fillRatio = var_56_11
			end

			local var_56_12 = 0
			local var_56_13 = 0.7

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_14 = arg_53_1:FormatText(StoryNameCfg[379].name)

				arg_53_1.leftNameTxt_.text = var_56_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_15 = arg_53_1:GetWordFromCfg(121432013)
				local var_56_16 = arg_53_1:FormatText(var_56_15.content)

				arg_53_1.text_.text = var_56_16

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_17 = 28
				local var_56_18 = utf8.len(var_56_16)
				local var_56_19 = var_56_17 <= 0 and var_56_13 or var_56_13 * (var_56_18 / var_56_17)

				if var_56_19 > 0 and var_56_13 < var_56_19 then
					arg_53_1.talkMaxDuration = var_56_19

					if var_56_19 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_19 + var_56_12
					end
				end

				arg_53_1.text_.text = var_56_16
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432013", "story_v_out_121432.awb") ~= 0 then
					local var_56_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432013", "story_v_out_121432.awb") / 1000

					if var_56_20 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_20 + var_56_12
					end

					if var_56_15.prefab_name ~= "" and arg_53_1.actors_[var_56_15.prefab_name] ~= nil then
						local var_56_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_15.prefab_name].transform, "story_v_out_121432", "121432013", "story_v_out_121432.awb")

						arg_53_1:RecordAudio("121432013", var_56_21)
						arg_53_1:RecordAudio("121432013", var_56_21)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_121432", "121432013", "story_v_out_121432.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_121432", "121432013", "story_v_out_121432.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_22 = math.max(var_56_13, arg_53_1.talkMaxDuration)

			if var_56_12 <= arg_53_1.time_ and arg_53_1.time_ < var_56_12 + var_56_22 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_12) / var_56_22

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_12 + var_56_22 and arg_53_1.time_ < var_56_12 + var_56_22 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play121432014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 121432014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play121432015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = arg_57_1.actors_["1072ui_story"].transform
			local var_60_1 = 0

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.var_.moveOldPos1072ui_story = var_60_0.localPosition
			end

			local var_60_2 = 0.001

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_2 then
				local var_60_3 = (arg_57_1.time_ - var_60_1) / var_60_2
				local var_60_4 = Vector3.New(0, 100, 0)

				var_60_0.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1072ui_story, var_60_4, var_60_3)

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

			local var_60_9 = arg_57_1.actors_["1072ui_story"]
			local var_60_10 = 0

			if var_60_10 < arg_57_1.time_ and arg_57_1.time_ <= var_60_10 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1072ui_story == nil then
				arg_57_1.var_.characterEffect1072ui_story = var_60_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_11 = 0.200000002980232

			if var_60_10 <= arg_57_1.time_ and arg_57_1.time_ < var_60_10 + var_60_11 and not isNil(var_60_9) then
				local var_60_12 = (arg_57_1.time_ - var_60_10) / var_60_11

				if arg_57_1.var_.characterEffect1072ui_story and not isNil(var_60_9) then
					local var_60_13 = Mathf.Lerp(0, 0.5, var_60_12)

					arg_57_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1072ui_story.fillRatio = var_60_13
				end
			end

			if arg_57_1.time_ >= var_60_10 + var_60_11 and arg_57_1.time_ < var_60_10 + var_60_11 + arg_60_0 and not isNil(var_60_9) and arg_57_1.var_.characterEffect1072ui_story then
				local var_60_14 = 0.5

				arg_57_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1072ui_story.fillRatio = var_60_14
			end

			local var_60_15 = arg_57_1.actors_["1074ui_story"].transform
			local var_60_16 = 0

			if var_60_16 < arg_57_1.time_ and arg_57_1.time_ <= var_60_16 + arg_60_0 then
				arg_57_1.var_.moveOldPos1074ui_story = var_60_15.localPosition
			end

			local var_60_17 = 0.001

			if var_60_16 <= arg_57_1.time_ and arg_57_1.time_ < var_60_16 + var_60_17 then
				local var_60_18 = (arg_57_1.time_ - var_60_16) / var_60_17
				local var_60_19 = Vector3.New(0, 100, 0)

				var_60_15.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1074ui_story, var_60_19, var_60_18)

				local var_60_20 = manager.ui.mainCamera.transform.position - var_60_15.position

				var_60_15.forward = Vector3.New(var_60_20.x, var_60_20.y, var_60_20.z)

				local var_60_21 = var_60_15.localEulerAngles

				var_60_21.z = 0
				var_60_21.x = 0
				var_60_15.localEulerAngles = var_60_21
			end

			if arg_57_1.time_ >= var_60_16 + var_60_17 and arg_57_1.time_ < var_60_16 + var_60_17 + arg_60_0 then
				var_60_15.localPosition = Vector3.New(0, 100, 0)

				local var_60_22 = manager.ui.mainCamera.transform.position - var_60_15.position

				var_60_15.forward = Vector3.New(var_60_22.x, var_60_22.y, var_60_22.z)

				local var_60_23 = var_60_15.localEulerAngles

				var_60_23.z = 0
				var_60_23.x = 0
				var_60_15.localEulerAngles = var_60_23
			end

			local var_60_24 = arg_57_1.actors_["1074ui_story"]
			local var_60_25 = 0

			if var_60_25 < arg_57_1.time_ and arg_57_1.time_ <= var_60_25 + arg_60_0 and not isNil(var_60_24) and arg_57_1.var_.characterEffect1074ui_story == nil then
				arg_57_1.var_.characterEffect1074ui_story = var_60_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_26 = 0.200000002980232

			if var_60_25 <= arg_57_1.time_ and arg_57_1.time_ < var_60_25 + var_60_26 and not isNil(var_60_24) then
				local var_60_27 = (arg_57_1.time_ - var_60_25) / var_60_26

				if arg_57_1.var_.characterEffect1074ui_story and not isNil(var_60_24) then
					local var_60_28 = Mathf.Lerp(0, 0.5, var_60_27)

					arg_57_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1074ui_story.fillRatio = var_60_28
				end
			end

			if arg_57_1.time_ >= var_60_25 + var_60_26 and arg_57_1.time_ < var_60_25 + var_60_26 + arg_60_0 and not isNil(var_60_24) and arg_57_1.var_.characterEffect1074ui_story then
				local var_60_29 = 0.5

				arg_57_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1074ui_story.fillRatio = var_60_29
			end

			local var_60_30 = 0
			local var_60_31 = 1.4

			if var_60_30 < arg_57_1.time_ and arg_57_1.time_ <= var_60_30 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, false)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_32 = arg_57_1:GetWordFromCfg(121432014)
				local var_60_33 = arg_57_1:FormatText(var_60_32.content)

				arg_57_1.text_.text = var_60_33

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_34 = 56
				local var_60_35 = utf8.len(var_60_33)
				local var_60_36 = var_60_34 <= 0 and var_60_31 or var_60_31 * (var_60_35 / var_60_34)

				if var_60_36 > 0 and var_60_31 < var_60_36 then
					arg_57_1.talkMaxDuration = var_60_36

					if var_60_36 + var_60_30 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_36 + var_60_30
					end
				end

				arg_57_1.text_.text = var_60_33
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_37 = math.max(var_60_31, arg_57_1.talkMaxDuration)

			if var_60_30 <= arg_57_1.time_ and arg_57_1.time_ < var_60_30 + var_60_37 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_30) / var_60_37

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_30 + var_60_37 and arg_57_1.time_ < var_60_30 + var_60_37 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play121432015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 121432015
		arg_61_1.duration_ = 12.77

		local var_61_0 = {
			ja = 12.766,
			ko = 9.733,
			zh = 9.733
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
				arg_61_0:Play121432016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = arg_61_1.actors_["1072ui_story"].transform
			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1.var_.moveOldPos1072ui_story = var_64_0.localPosition
			end

			local var_64_2 = 0.001

			if var_64_1 <= arg_61_1.time_ and arg_61_1.time_ < var_64_1 + var_64_2 then
				local var_64_3 = (arg_61_1.time_ - var_64_1) / var_64_2
				local var_64_4 = Vector3.New(-0.7, -0.71, -6)

				var_64_0.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1072ui_story, var_64_4, var_64_3)

				local var_64_5 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_5.x, var_64_5.y, var_64_5.z)

				local var_64_6 = var_64_0.localEulerAngles

				var_64_6.z = 0
				var_64_6.x = 0
				var_64_0.localEulerAngles = var_64_6
			end

			if arg_61_1.time_ >= var_64_1 + var_64_2 and arg_61_1.time_ < var_64_1 + var_64_2 + arg_64_0 then
				var_64_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_64_7 = manager.ui.mainCamera.transform.position - var_64_0.position

				var_64_0.forward = Vector3.New(var_64_7.x, var_64_7.y, var_64_7.z)

				local var_64_8 = var_64_0.localEulerAngles

				var_64_8.z = 0
				var_64_8.x = 0
				var_64_0.localEulerAngles = var_64_8
			end

			local var_64_9 = arg_61_1.actors_["1072ui_story"]
			local var_64_10 = 0

			if var_64_10 < arg_61_1.time_ and arg_61_1.time_ <= var_64_10 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1072ui_story == nil then
				arg_61_1.var_.characterEffect1072ui_story = var_64_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_11 = 0.200000002980232

			if var_64_10 <= arg_61_1.time_ and arg_61_1.time_ < var_64_10 + var_64_11 and not isNil(var_64_9) then
				local var_64_12 = (arg_61_1.time_ - var_64_10) / var_64_11

				if arg_61_1.var_.characterEffect1072ui_story and not isNil(var_64_9) then
					local var_64_13 = Mathf.Lerp(0, 0.5, var_64_12)

					arg_61_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1072ui_story.fillRatio = var_64_13
				end
			end

			if arg_61_1.time_ >= var_64_10 + var_64_11 and arg_61_1.time_ < var_64_10 + var_64_11 + arg_64_0 and not isNil(var_64_9) and arg_61_1.var_.characterEffect1072ui_story then
				local var_64_14 = 0.5

				arg_61_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1072ui_story.fillRatio = var_64_14
			end

			local var_64_15 = arg_61_1.actors_["1074ui_story"].transform
			local var_64_16 = 0

			if var_64_16 < arg_61_1.time_ and arg_61_1.time_ <= var_64_16 + arg_64_0 then
				arg_61_1.var_.moveOldPos1074ui_story = var_64_15.localPosition
			end

			local var_64_17 = 0.001

			if var_64_16 <= arg_61_1.time_ and arg_61_1.time_ < var_64_16 + var_64_17 then
				local var_64_18 = (arg_61_1.time_ - var_64_16) / var_64_17
				local var_64_19 = Vector3.New(0.7, -1.055, -6.12)

				var_64_15.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1074ui_story, var_64_19, var_64_18)

				local var_64_20 = manager.ui.mainCamera.transform.position - var_64_15.position

				var_64_15.forward = Vector3.New(var_64_20.x, var_64_20.y, var_64_20.z)

				local var_64_21 = var_64_15.localEulerAngles

				var_64_21.z = 0
				var_64_21.x = 0
				var_64_15.localEulerAngles = var_64_21
			end

			if arg_61_1.time_ >= var_64_16 + var_64_17 and arg_61_1.time_ < var_64_16 + var_64_17 + arg_64_0 then
				var_64_15.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_64_22 = manager.ui.mainCamera.transform.position - var_64_15.position

				var_64_15.forward = Vector3.New(var_64_22.x, var_64_22.y, var_64_22.z)

				local var_64_23 = var_64_15.localEulerAngles

				var_64_23.z = 0
				var_64_23.x = 0
				var_64_15.localEulerAngles = var_64_23
			end

			local var_64_24 = arg_61_1.actors_["1074ui_story"]
			local var_64_25 = 0

			if var_64_25 < arg_61_1.time_ and arg_61_1.time_ <= var_64_25 + arg_64_0 and not isNil(var_64_24) and arg_61_1.var_.characterEffect1074ui_story == nil then
				arg_61_1.var_.characterEffect1074ui_story = var_64_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_26 = 0.200000002980232

			if var_64_25 <= arg_61_1.time_ and arg_61_1.time_ < var_64_25 + var_64_26 and not isNil(var_64_24) then
				local var_64_27 = (arg_61_1.time_ - var_64_25) / var_64_26

				if arg_61_1.var_.characterEffect1074ui_story and not isNil(var_64_24) then
					arg_61_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_25 + var_64_26 and arg_61_1.time_ < var_64_25 + var_64_26 + arg_64_0 and not isNil(var_64_24) and arg_61_1.var_.characterEffect1074ui_story then
				arg_61_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_64_28 = 0

			if var_64_28 < arg_61_1.time_ and arg_61_1.time_ <= var_64_28 + arg_64_0 then
				arg_61_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_64_29 = 0

			if var_64_29 < arg_61_1.time_ and arg_61_1.time_ <= var_64_29 + arg_64_0 then
				arg_61_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_64_30 = 0
			local var_64_31 = 1.1

			if var_64_30 < arg_61_1.time_ and arg_61_1.time_ <= var_64_30 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_32 = arg_61_1:FormatText(StoryNameCfg[410].name)

				arg_61_1.leftNameTxt_.text = var_64_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_33 = arg_61_1:GetWordFromCfg(121432015)
				local var_64_34 = arg_61_1:FormatText(var_64_33.content)

				arg_61_1.text_.text = var_64_34

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_35 = 44
				local var_64_36 = utf8.len(var_64_34)
				local var_64_37 = var_64_35 <= 0 and var_64_31 or var_64_31 * (var_64_36 / var_64_35)

				if var_64_37 > 0 and var_64_31 < var_64_37 then
					arg_61_1.talkMaxDuration = var_64_37

					if var_64_37 + var_64_30 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_37 + var_64_30
					end
				end

				arg_61_1.text_.text = var_64_34
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432015", "story_v_out_121432.awb") ~= 0 then
					local var_64_38 = manager.audio:GetVoiceLength("story_v_out_121432", "121432015", "story_v_out_121432.awb") / 1000

					if var_64_38 + var_64_30 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_38 + var_64_30
					end

					if var_64_33.prefab_name ~= "" and arg_61_1.actors_[var_64_33.prefab_name] ~= nil then
						local var_64_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_33.prefab_name].transform, "story_v_out_121432", "121432015", "story_v_out_121432.awb")

						arg_61_1:RecordAudio("121432015", var_64_39)
						arg_61_1:RecordAudio("121432015", var_64_39)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_121432", "121432015", "story_v_out_121432.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_121432", "121432015", "story_v_out_121432.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_40 = math.max(var_64_31, arg_61_1.talkMaxDuration)

			if var_64_30 <= arg_61_1.time_ and arg_61_1.time_ < var_64_30 + var_64_40 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_30) / var_64_40

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_30 + var_64_40 and arg_61_1.time_ < var_64_30 + var_64_40 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
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
	Play121432016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 121432016
		arg_65_1.duration_ = 7.07

		local var_65_0 = {
			ja = 7.066,
			ko = 5.4,
			zh = 5.4
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
				arg_65_0:Play121432017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["1072ui_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos1072ui_story = var_68_0.localPosition
			end

			local var_68_2 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2
				local var_68_4 = Vector3.New(-0.7, -0.71, -6)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1072ui_story, var_68_4, var_68_3)

				local var_68_5 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_5.x, var_68_5.y, var_68_5.z)

				local var_68_6 = var_68_0.localEulerAngles

				var_68_6.z = 0
				var_68_6.x = 0
				var_68_0.localEulerAngles = var_68_6
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_68_7 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_7.x, var_68_7.y, var_68_7.z)

				local var_68_8 = var_68_0.localEulerAngles

				var_68_8.z = 0
				var_68_8.x = 0
				var_68_0.localEulerAngles = var_68_8
			end

			local var_68_9 = arg_65_1.actors_["1072ui_story"]
			local var_68_10 = 0

			if var_68_10 < arg_65_1.time_ and arg_65_1.time_ <= var_68_10 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1072ui_story == nil then
				arg_65_1.var_.characterEffect1072ui_story = var_68_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_11 = 0.200000002980232

			if var_68_10 <= arg_65_1.time_ and arg_65_1.time_ < var_68_10 + var_68_11 and not isNil(var_68_9) then
				local var_68_12 = (arg_65_1.time_ - var_68_10) / var_68_11

				if arg_65_1.var_.characterEffect1072ui_story and not isNil(var_68_9) then
					arg_65_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_10 + var_68_11 and arg_65_1.time_ < var_68_10 + var_68_11 + arg_68_0 and not isNil(var_68_9) and arg_65_1.var_.characterEffect1072ui_story then
				arg_65_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_68_13 = 0

			if var_68_13 < arg_65_1.time_ and arg_65_1.time_ <= var_68_13 + arg_68_0 then
				arg_65_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_68_14 = 0

			if var_68_14 < arg_65_1.time_ and arg_65_1.time_ <= var_68_14 + arg_68_0 then
				arg_65_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_68_15 = arg_65_1.actors_["1074ui_story"]
			local var_68_16 = 0

			if var_68_16 < arg_65_1.time_ and arg_65_1.time_ <= var_68_16 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.characterEffect1074ui_story == nil then
				arg_65_1.var_.characterEffect1074ui_story = var_68_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_17 = 0.200000002980232

			if var_68_16 <= arg_65_1.time_ and arg_65_1.time_ < var_68_16 + var_68_17 and not isNil(var_68_15) then
				local var_68_18 = (arg_65_1.time_ - var_68_16) / var_68_17

				if arg_65_1.var_.characterEffect1074ui_story and not isNil(var_68_15) then
					local var_68_19 = Mathf.Lerp(0, 0.5, var_68_18)

					arg_65_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1074ui_story.fillRatio = var_68_19
				end
			end

			if arg_65_1.time_ >= var_68_16 + var_68_17 and arg_65_1.time_ < var_68_16 + var_68_17 + arg_68_0 and not isNil(var_68_15) and arg_65_1.var_.characterEffect1074ui_story then
				local var_68_20 = 0.5

				arg_65_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1074ui_story.fillRatio = var_68_20
			end

			local var_68_21 = 0
			local var_68_22 = 0.525

			if var_68_21 < arg_65_1.time_ and arg_65_1.time_ <= var_68_21 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_23 = arg_65_1:FormatText(StoryNameCfg[379].name)

				arg_65_1.leftNameTxt_.text = var_68_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_24 = arg_65_1:GetWordFromCfg(121432016)
				local var_68_25 = arg_65_1:FormatText(var_68_24.content)

				arg_65_1.text_.text = var_68_25

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_26 = 21
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

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432016", "story_v_out_121432.awb") ~= 0 then
					local var_68_29 = manager.audio:GetVoiceLength("story_v_out_121432", "121432016", "story_v_out_121432.awb") / 1000

					if var_68_29 + var_68_21 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_29 + var_68_21
					end

					if var_68_24.prefab_name ~= "" and arg_65_1.actors_[var_68_24.prefab_name] ~= nil then
						local var_68_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_24.prefab_name].transform, "story_v_out_121432", "121432016", "story_v_out_121432.awb")

						arg_65_1:RecordAudio("121432016", var_68_30)
						arg_65_1:RecordAudio("121432016", var_68_30)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_121432", "121432016", "story_v_out_121432.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_121432", "121432016", "story_v_out_121432.awb")
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
				actorName = "1072ui_story",
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
	Play121432017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 121432017
		arg_69_1.duration_ = 5.1

		local var_69_0 = {
			ja = 5.1,
			ko = 3.3,
			zh = 3.3
		}
		local var_69_1 = manager.audio:GetLocalizationFlag()

		if var_69_0[var_69_1] ~= nil then
			arg_69_1.duration_ = var_69_0[var_69_1]
		end

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play121432018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1074ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1074ui_story == nil then
				arg_69_1.var_.characterEffect1074ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1074ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1074ui_story then
				arg_69_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_72_4 = 0

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_72_5 = 0

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_72_6 = arg_69_1.actors_["1072ui_story"]
			local var_72_7 = 0

			if var_72_7 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect1072ui_story == nil then
				arg_69_1.var_.characterEffect1072ui_story = var_72_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_8 = 0.200000002980232

			if var_72_7 <= arg_69_1.time_ and arg_69_1.time_ < var_72_7 + var_72_8 and not isNil(var_72_6) then
				local var_72_9 = (arg_69_1.time_ - var_72_7) / var_72_8

				if arg_69_1.var_.characterEffect1072ui_story and not isNil(var_72_6) then
					local var_72_10 = Mathf.Lerp(0, 0.5, var_72_9)

					arg_69_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1072ui_story.fillRatio = var_72_10
				end
			end

			if arg_69_1.time_ >= var_72_7 + var_72_8 and arg_69_1.time_ < var_72_7 + var_72_8 + arg_72_0 and not isNil(var_72_6) and arg_69_1.var_.characterEffect1072ui_story then
				local var_72_11 = 0.5

				arg_69_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1072ui_story.fillRatio = var_72_11
			end

			local var_72_12 = 0
			local var_72_13 = 0.4

			if var_72_12 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_14 = arg_69_1:FormatText(StoryNameCfg[410].name)

				arg_69_1.leftNameTxt_.text = var_72_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_15 = arg_69_1:GetWordFromCfg(121432017)
				local var_72_16 = arg_69_1:FormatText(var_72_15.content)

				arg_69_1.text_.text = var_72_16

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_17 = 16
				local var_72_18 = utf8.len(var_72_16)
				local var_72_19 = var_72_17 <= 0 and var_72_13 or var_72_13 * (var_72_18 / var_72_17)

				if var_72_19 > 0 and var_72_13 < var_72_19 then
					arg_69_1.talkMaxDuration = var_72_19

					if var_72_19 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_19 + var_72_12
					end
				end

				arg_69_1.text_.text = var_72_16
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432017", "story_v_out_121432.awb") ~= 0 then
					local var_72_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432017", "story_v_out_121432.awb") / 1000

					if var_72_20 + var_72_12 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_20 + var_72_12
					end

					if var_72_15.prefab_name ~= "" and arg_69_1.actors_[var_72_15.prefab_name] ~= nil then
						local var_72_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_15.prefab_name].transform, "story_v_out_121432", "121432017", "story_v_out_121432.awb")

						arg_69_1:RecordAudio("121432017", var_72_21)
						arg_69_1:RecordAudio("121432017", var_72_21)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_121432", "121432017", "story_v_out_121432.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_121432", "121432017", "story_v_out_121432.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_22 = math.max(var_72_13, arg_69_1.talkMaxDuration)

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_22 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_12) / var_72_22

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_12 + var_72_22 and arg_69_1.time_ < var_72_12 + var_72_22 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play121432018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 121432018
		arg_73_1.duration_ = 4.77

		local var_73_0 = {
			ja = 4.766,
			ko = 3.7,
			zh = 3.7
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
				arg_73_0:Play121432019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["1072ui_story"].transform
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.var_.moveOldPos1072ui_story = var_76_0.localPosition
			end

			local var_76_2 = 0.001

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2
				local var_76_4 = Vector3.New(-0.7, -0.71, -6)

				var_76_0.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1072ui_story, var_76_4, var_76_3)

				local var_76_5 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_5.x, var_76_5.y, var_76_5.z)

				local var_76_6 = var_76_0.localEulerAngles

				var_76_6.z = 0
				var_76_6.x = 0
				var_76_0.localEulerAngles = var_76_6
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 then
				var_76_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_76_7 = manager.ui.mainCamera.transform.position - var_76_0.position

				var_76_0.forward = Vector3.New(var_76_7.x, var_76_7.y, var_76_7.z)

				local var_76_8 = var_76_0.localEulerAngles

				var_76_8.z = 0
				var_76_8.x = 0
				var_76_0.localEulerAngles = var_76_8
			end

			local var_76_9 = arg_73_1.actors_["1072ui_story"]
			local var_76_10 = 0

			if var_76_10 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1072ui_story == nil then
				arg_73_1.var_.characterEffect1072ui_story = var_76_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_11 = 0.200000002980232

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_11 and not isNil(var_76_9) then
				local var_76_12 = (arg_73_1.time_ - var_76_10) / var_76_11

				if arg_73_1.var_.characterEffect1072ui_story and not isNil(var_76_9) then
					arg_73_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_10 + var_76_11 and arg_73_1.time_ < var_76_10 + var_76_11 + arg_76_0 and not isNil(var_76_9) and arg_73_1.var_.characterEffect1072ui_story then
				arg_73_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_76_13 = 0

			if var_76_13 < arg_73_1.time_ and arg_73_1.time_ <= var_76_13 + arg_76_0 then
				arg_73_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_76_14 = 0

			if var_76_14 < arg_73_1.time_ and arg_73_1.time_ <= var_76_14 + arg_76_0 then
				arg_73_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_76_15 = arg_73_1.actors_["1074ui_story"]
			local var_76_16 = 0

			if var_76_16 < arg_73_1.time_ and arg_73_1.time_ <= var_76_16 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.characterEffect1074ui_story == nil then
				arg_73_1.var_.characterEffect1074ui_story = var_76_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_17 = 0.200000002980232

			if var_76_16 <= arg_73_1.time_ and arg_73_1.time_ < var_76_16 + var_76_17 and not isNil(var_76_15) then
				local var_76_18 = (arg_73_1.time_ - var_76_16) / var_76_17

				if arg_73_1.var_.characterEffect1074ui_story and not isNil(var_76_15) then
					local var_76_19 = Mathf.Lerp(0, 0.5, var_76_18)

					arg_73_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1074ui_story.fillRatio = var_76_19
				end
			end

			if arg_73_1.time_ >= var_76_16 + var_76_17 and arg_73_1.time_ < var_76_16 + var_76_17 + arg_76_0 and not isNil(var_76_15) and arg_73_1.var_.characterEffect1074ui_story then
				local var_76_20 = 0.5

				arg_73_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1074ui_story.fillRatio = var_76_20
			end

			local var_76_21 = 0
			local var_76_22 = 0.225

			if var_76_21 < arg_73_1.time_ and arg_73_1.time_ <= var_76_21 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_23 = arg_73_1:FormatText(StoryNameCfg[379].name)

				arg_73_1.leftNameTxt_.text = var_76_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_24 = arg_73_1:GetWordFromCfg(121432018)
				local var_76_25 = arg_73_1:FormatText(var_76_24.content)

				arg_73_1.text_.text = var_76_25

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_26 = 9
				local var_76_27 = utf8.len(var_76_25)
				local var_76_28 = var_76_26 <= 0 and var_76_22 or var_76_22 * (var_76_27 / var_76_26)

				if var_76_28 > 0 and var_76_22 < var_76_28 then
					arg_73_1.talkMaxDuration = var_76_28

					if var_76_28 + var_76_21 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_28 + var_76_21
					end
				end

				arg_73_1.text_.text = var_76_25
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432018", "story_v_out_121432.awb") ~= 0 then
					local var_76_29 = manager.audio:GetVoiceLength("story_v_out_121432", "121432018", "story_v_out_121432.awb") / 1000

					if var_76_29 + var_76_21 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_29 + var_76_21
					end

					if var_76_24.prefab_name ~= "" and arg_73_1.actors_[var_76_24.prefab_name] ~= nil then
						local var_76_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_24.prefab_name].transform, "story_v_out_121432", "121432018", "story_v_out_121432.awb")

						arg_73_1:RecordAudio("121432018", var_76_30)
						arg_73_1:RecordAudio("121432018", var_76_30)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_121432", "121432018", "story_v_out_121432.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_121432", "121432018", "story_v_out_121432.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_31 = math.max(var_76_22, arg_73_1.talkMaxDuration)

			if var_76_21 <= arg_73_1.time_ and arg_73_1.time_ < var_76_21 + var_76_31 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_21) / var_76_31

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_21 + var_76_31 and arg_73_1.time_ < var_76_21 + var_76_31 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play121432019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 121432019
		arg_77_1.duration_ = 12.77

		local var_77_0 = {
			ja = 12.766,
			ko = 10.633,
			zh = 10.633
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play121432020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 1.225

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[379].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_3 = arg_77_1:GetWordFromCfg(121432019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 49
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

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432019", "story_v_out_121432.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_121432", "121432019", "story_v_out_121432.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_121432", "121432019", "story_v_out_121432.awb")

						arg_77_1:RecordAudio("121432019", var_80_9)
						arg_77_1:RecordAudio("121432019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_121432", "121432019", "story_v_out_121432.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_121432", "121432019", "story_v_out_121432.awb")
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
	Play121432020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 121432020
		arg_81_1.duration_ = 9.27

		local var_81_0 = {
			ja = 8.1,
			ko = 9.266,
			zh = 9.266
		}
		local var_81_1 = manager.audio:GetLocalizationFlag()

		if var_81_0[var_81_1] ~= nil then
			arg_81_1.duration_ = var_81_0[var_81_1]
		end

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play121432021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["1074ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1074ui_story == nil then
				arg_81_1.var_.characterEffect1074ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect1074ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect1074ui_story then
				arg_81_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_84_4 = 0

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_84_6 = arg_81_1.actors_["1072ui_story"]
			local var_84_7 = 0

			if var_84_7 < arg_81_1.time_ and arg_81_1.time_ <= var_84_7 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect1072ui_story == nil then
				arg_81_1.var_.characterEffect1072ui_story = var_84_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_8 = 0.200000002980232

			if var_84_7 <= arg_81_1.time_ and arg_81_1.time_ < var_84_7 + var_84_8 and not isNil(var_84_6) then
				local var_84_9 = (arg_81_1.time_ - var_84_7) / var_84_8

				if arg_81_1.var_.characterEffect1072ui_story and not isNil(var_84_6) then
					local var_84_10 = Mathf.Lerp(0, 0.5, var_84_9)

					arg_81_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_81_1.var_.characterEffect1072ui_story.fillRatio = var_84_10
				end
			end

			if arg_81_1.time_ >= var_84_7 + var_84_8 and arg_81_1.time_ < var_84_7 + var_84_8 + arg_84_0 and not isNil(var_84_6) and arg_81_1.var_.characterEffect1072ui_story then
				local var_84_11 = 0.5

				arg_81_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_81_1.var_.characterEffect1072ui_story.fillRatio = var_84_11
			end

			local var_84_12 = 0
			local var_84_13 = 1.075

			if var_84_12 < arg_81_1.time_ and arg_81_1.time_ <= var_84_12 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_14 = arg_81_1:FormatText(StoryNameCfg[410].name)

				arg_81_1.leftNameTxt_.text = var_84_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_15 = arg_81_1:GetWordFromCfg(121432020)
				local var_84_16 = arg_81_1:FormatText(var_84_15.content)

				arg_81_1.text_.text = var_84_16

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_17 = 43
				local var_84_18 = utf8.len(var_84_16)
				local var_84_19 = var_84_17 <= 0 and var_84_13 or var_84_13 * (var_84_18 / var_84_17)

				if var_84_19 > 0 and var_84_13 < var_84_19 then
					arg_81_1.talkMaxDuration = var_84_19

					if var_84_19 + var_84_12 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_19 + var_84_12
					end
				end

				arg_81_1.text_.text = var_84_16
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432020", "story_v_out_121432.awb") ~= 0 then
					local var_84_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432020", "story_v_out_121432.awb") / 1000

					if var_84_20 + var_84_12 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_20 + var_84_12
					end

					if var_84_15.prefab_name ~= "" and arg_81_1.actors_[var_84_15.prefab_name] ~= nil then
						local var_84_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_15.prefab_name].transform, "story_v_out_121432", "121432020", "story_v_out_121432.awb")

						arg_81_1:RecordAudio("121432020", var_84_21)
						arg_81_1:RecordAudio("121432020", var_84_21)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_121432", "121432020", "story_v_out_121432.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_121432", "121432020", "story_v_out_121432.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_22 = math.max(var_84_13, arg_81_1.talkMaxDuration)

			if var_84_12 <= arg_81_1.time_ and arg_81_1.time_ < var_84_12 + var_84_22 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_12) / var_84_22

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_12 + var_84_22 and arg_81_1.time_ < var_84_12 + var_84_22 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play121432021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 121432021
		arg_85_1.duration_ = 5.5

		local var_85_0 = {
			ja = 5.5,
			ko = 2.866,
			zh = 2.866
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play121432022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.35

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[410].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(121432021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 14
				local var_88_6 = utf8.len(var_88_4)
				local var_88_7 = var_88_5 <= 0 and var_88_1 or var_88_1 * (var_88_6 / var_88_5)

				if var_88_7 > 0 and var_88_1 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_4
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432021", "story_v_out_121432.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_121432", "121432021", "story_v_out_121432.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_121432", "121432021", "story_v_out_121432.awb")

						arg_85_1:RecordAudio("121432021", var_88_9)
						arg_85_1:RecordAudio("121432021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_121432", "121432021", "story_v_out_121432.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_121432", "121432021", "story_v_out_121432.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_10 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_10 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_10

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_10 and arg_85_1.time_ < var_88_0 + var_88_10 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play121432022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 121432022
		arg_89_1.duration_ = 5.8

		local var_89_0 = {
			ja = 5.8,
			ko = 2.7,
			zh = 2.7
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play121432023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["1072ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1072ui_story == nil then
				arg_89_1.var_.characterEffect1072ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect1072ui_story and not isNil(var_92_0) then
					arg_89_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect1072ui_story then
				arg_89_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_92_4 = 0

			if var_92_4 < arg_89_1.time_ and arg_89_1.time_ <= var_92_4 + arg_92_0 then
				arg_89_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_92_5 = 0

			if var_92_5 < arg_89_1.time_ and arg_89_1.time_ <= var_92_5 + arg_92_0 then
				arg_89_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_92_6 = arg_89_1.actors_["1074ui_story"]
			local var_92_7 = 0

			if var_92_7 < arg_89_1.time_ and arg_89_1.time_ <= var_92_7 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1074ui_story == nil then
				arg_89_1.var_.characterEffect1074ui_story = var_92_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_8 = 0.200000002980232

			if var_92_7 <= arg_89_1.time_ and arg_89_1.time_ < var_92_7 + var_92_8 and not isNil(var_92_6) then
				local var_92_9 = (arg_89_1.time_ - var_92_7) / var_92_8

				if arg_89_1.var_.characterEffect1074ui_story and not isNil(var_92_6) then
					local var_92_10 = Mathf.Lerp(0, 0.5, var_92_9)

					arg_89_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1074ui_story.fillRatio = var_92_10
				end
			end

			if arg_89_1.time_ >= var_92_7 + var_92_8 and arg_89_1.time_ < var_92_7 + var_92_8 + arg_92_0 and not isNil(var_92_6) and arg_89_1.var_.characterEffect1074ui_story then
				local var_92_11 = 0.5

				arg_89_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1074ui_story.fillRatio = var_92_11
			end

			local var_92_12 = 0
			local var_92_13 = 0.325

			if var_92_12 < arg_89_1.time_ and arg_89_1.time_ <= var_92_12 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_14 = arg_89_1:FormatText(StoryNameCfg[379].name)

				arg_89_1.leftNameTxt_.text = var_92_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_15 = arg_89_1:GetWordFromCfg(121432022)
				local var_92_16 = arg_89_1:FormatText(var_92_15.content)

				arg_89_1.text_.text = var_92_16

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_17 = 13
				local var_92_18 = utf8.len(var_92_16)
				local var_92_19 = var_92_17 <= 0 and var_92_13 or var_92_13 * (var_92_18 / var_92_17)

				if var_92_19 > 0 and var_92_13 < var_92_19 then
					arg_89_1.talkMaxDuration = var_92_19

					if var_92_19 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_19 + var_92_12
					end
				end

				arg_89_1.text_.text = var_92_16
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432022", "story_v_out_121432.awb") ~= 0 then
					local var_92_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432022", "story_v_out_121432.awb") / 1000

					if var_92_20 + var_92_12 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_20 + var_92_12
					end

					if var_92_15.prefab_name ~= "" and arg_89_1.actors_[var_92_15.prefab_name] ~= nil then
						local var_92_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_15.prefab_name].transform, "story_v_out_121432", "121432022", "story_v_out_121432.awb")

						arg_89_1:RecordAudio("121432022", var_92_21)
						arg_89_1:RecordAudio("121432022", var_92_21)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_121432", "121432022", "story_v_out_121432.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_121432", "121432022", "story_v_out_121432.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_22 = math.max(var_92_13, arg_89_1.talkMaxDuration)

			if var_92_12 <= arg_89_1.time_ and arg_89_1.time_ < var_92_12 + var_92_22 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_12) / var_92_22

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_12 + var_92_22 and arg_89_1.time_ < var_92_12 + var_92_22 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play121432023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 121432023
		arg_93_1.duration_ = 3.97

		local var_93_0 = {
			ja = 3.966,
			ko = 3.933,
			zh = 3.933
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play121432024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["1074ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1074ui_story == nil then
				arg_93_1.var_.characterEffect1074ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect1074ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect1074ui_story then
				arg_93_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_96_4 = 0

			if var_96_4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_96_5 = 0

			if var_96_5 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_96_6 = arg_93_1.actors_["1072ui_story"]
			local var_96_7 = 0

			if var_96_7 < arg_93_1.time_ and arg_93_1.time_ <= var_96_7 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect1072ui_story == nil then
				arg_93_1.var_.characterEffect1072ui_story = var_96_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_8 = 0.200000002980232

			if var_96_7 <= arg_93_1.time_ and arg_93_1.time_ < var_96_7 + var_96_8 and not isNil(var_96_6) then
				local var_96_9 = (arg_93_1.time_ - var_96_7) / var_96_8

				if arg_93_1.var_.characterEffect1072ui_story and not isNil(var_96_6) then
					local var_96_10 = Mathf.Lerp(0, 0.5, var_96_9)

					arg_93_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_93_1.var_.characterEffect1072ui_story.fillRatio = var_96_10
				end
			end

			if arg_93_1.time_ >= var_96_7 + var_96_8 and arg_93_1.time_ < var_96_7 + var_96_8 + arg_96_0 and not isNil(var_96_6) and arg_93_1.var_.characterEffect1072ui_story then
				local var_96_11 = 0.5

				arg_93_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_93_1.var_.characterEffect1072ui_story.fillRatio = var_96_11
			end

			local var_96_12 = 0
			local var_96_13 = 0.25

			if var_96_12 < arg_93_1.time_ and arg_93_1.time_ <= var_96_12 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_14 = arg_93_1:FormatText(StoryNameCfg[410].name)

				arg_93_1.leftNameTxt_.text = var_96_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_15 = arg_93_1:GetWordFromCfg(121432023)
				local var_96_16 = arg_93_1:FormatText(var_96_15.content)

				arg_93_1.text_.text = var_96_16

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_17 = 10
				local var_96_18 = utf8.len(var_96_16)
				local var_96_19 = var_96_17 <= 0 and var_96_13 or var_96_13 * (var_96_18 / var_96_17)

				if var_96_19 > 0 and var_96_13 < var_96_19 then
					arg_93_1.talkMaxDuration = var_96_19

					if var_96_19 + var_96_12 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_19 + var_96_12
					end
				end

				arg_93_1.text_.text = var_96_16
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432023", "story_v_out_121432.awb") ~= 0 then
					local var_96_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432023", "story_v_out_121432.awb") / 1000

					if var_96_20 + var_96_12 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_20 + var_96_12
					end

					if var_96_15.prefab_name ~= "" and arg_93_1.actors_[var_96_15.prefab_name] ~= nil then
						local var_96_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_15.prefab_name].transform, "story_v_out_121432", "121432023", "story_v_out_121432.awb")

						arg_93_1:RecordAudio("121432023", var_96_21)
						arg_93_1:RecordAudio("121432023", var_96_21)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_121432", "121432023", "story_v_out_121432.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_121432", "121432023", "story_v_out_121432.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_22 = math.max(var_96_13, arg_93_1.talkMaxDuration)

			if var_96_12 <= arg_93_1.time_ and arg_93_1.time_ < var_96_12 + var_96_22 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_12) / var_96_22

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_12 + var_96_22 and arg_93_1.time_ < var_96_12 + var_96_22 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play121432024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 121432024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play121432025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1074ui_story"]
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1074ui_story == nil then
				arg_97_1.var_.characterEffect1074ui_story = var_100_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 and not isNil(var_100_0) then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2

				if arg_97_1.var_.characterEffect1074ui_story and not isNil(var_100_0) then
					local var_100_4 = Mathf.Lerp(0, 0.5, var_100_3)

					arg_97_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1074ui_story.fillRatio = var_100_4
				end
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 and not isNil(var_100_0) and arg_97_1.var_.characterEffect1074ui_story then
				local var_100_5 = 0.5

				arg_97_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1074ui_story.fillRatio = var_100_5
			end

			local var_100_6 = 0
			local var_100_7 = 0.525

			if var_100_6 < arg_97_1.time_ and arg_97_1.time_ <= var_100_6 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:GetWordFromCfg(121432024)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 21
				local var_100_11 = utf8.len(var_100_9)
				local var_100_12 = var_100_10 <= 0 and var_100_7 or var_100_7 * (var_100_11 / var_100_10)

				if var_100_12 > 0 and var_100_7 < var_100_12 then
					arg_97_1.talkMaxDuration = var_100_12

					if var_100_12 + var_100_6 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_6
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_13 = math.max(var_100_7, arg_97_1.talkMaxDuration)

			if var_100_6 <= arg_97_1.time_ and arg_97_1.time_ < var_100_6 + var_100_13 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_6) / var_100_13

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_6 + var_100_13 and arg_97_1.time_ < var_100_6 + var_100_13 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play121432025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 121432025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play121432026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.433333333333333

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				local var_104_2 = "play"
				local var_104_3 = "effect"

				arg_101_1:AudioAction(var_104_2, var_104_3, "se_story_15", "se_story_15_blast02", "")
			end

			local var_104_4 = 0
			local var_104_5 = 0.075

			if var_104_4 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(121432025)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_8 = 3
				local var_104_9 = utf8.len(var_104_7)
				local var_104_10 = var_104_8 <= 0 and var_104_5 or var_104_5 * (var_104_9 / var_104_8)

				if var_104_10 > 0 and var_104_5 < var_104_10 then
					arg_101_1.talkMaxDuration = var_104_10

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_11 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_11 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_11

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_11 and arg_101_1.time_ < var_104_4 + var_104_11 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play121432026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 121432026
		arg_105_1.duration_ = 3.97

		local var_105_0 = {
			ja = 3.966,
			ko = 2.233,
			zh = 2.233
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
				arg_105_0:Play121432027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1072ui_story"]
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1072ui_story == nil then
				arg_105_1.var_.characterEffect1072ui_story = var_108_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 and not isNil(var_108_0) then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2

				if arg_105_1.var_.characterEffect1072ui_story and not isNil(var_108_0) then
					arg_105_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 and not isNil(var_108_0) and arg_105_1.var_.characterEffect1072ui_story then
				arg_105_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_108_4 = 0

			if var_108_4 < arg_105_1.time_ and arg_105_1.time_ <= var_108_4 + arg_108_0 then
				arg_105_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_108_5 = 0

			if var_108_5 < arg_105_1.time_ and arg_105_1.time_ <= var_108_5 + arg_108_0 then
				arg_105_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_108_6 = 0
			local var_108_7 = 0.225

			if var_108_6 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_8 = arg_105_1:FormatText(StoryNameCfg[379].name)

				arg_105_1.leftNameTxt_.text = var_108_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_9 = arg_105_1:GetWordFromCfg(121432026)
				local var_108_10 = arg_105_1:FormatText(var_108_9.content)

				arg_105_1.text_.text = var_108_10

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 9
				local var_108_12 = utf8.len(var_108_10)
				local var_108_13 = var_108_11 <= 0 and var_108_7 or var_108_7 * (var_108_12 / var_108_11)

				if var_108_13 > 0 and var_108_7 < var_108_13 then
					arg_105_1.talkMaxDuration = var_108_13

					if var_108_13 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_13 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_10
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432026", "story_v_out_121432.awb") ~= 0 then
					local var_108_14 = manager.audio:GetVoiceLength("story_v_out_121432", "121432026", "story_v_out_121432.awb") / 1000

					if var_108_14 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_14 + var_108_6
					end

					if var_108_9.prefab_name ~= "" and arg_105_1.actors_[var_108_9.prefab_name] ~= nil then
						local var_108_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_9.prefab_name].transform, "story_v_out_121432", "121432026", "story_v_out_121432.awb")

						arg_105_1:RecordAudio("121432026", var_108_15)
						arg_105_1:RecordAudio("121432026", var_108_15)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_121432", "121432026", "story_v_out_121432.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_121432", "121432026", "story_v_out_121432.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_16 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_16 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_16

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_16 and arg_105_1.time_ < var_108_6 + var_108_16 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play121432027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 121432027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play121432028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1072ui_story"]
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1072ui_story == nil then
				arg_109_1.var_.characterEffect1072ui_story = var_112_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 and not isNil(var_112_0) then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2

				if arg_109_1.var_.characterEffect1072ui_story and not isNil(var_112_0) then
					local var_112_4 = Mathf.Lerp(0, 0.5, var_112_3)

					arg_109_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1072ui_story.fillRatio = var_112_4
				end
			end

			if arg_109_1.time_ >= var_112_1 + var_112_2 and arg_109_1.time_ < var_112_1 + var_112_2 + arg_112_0 and not isNil(var_112_0) and arg_109_1.var_.characterEffect1072ui_story then
				local var_112_5 = 0.5

				arg_109_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1072ui_story.fillRatio = var_112_5
			end

			local var_112_6 = 0
			local var_112_7 = 0.95

			if var_112_6 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_8 = arg_109_1:GetWordFromCfg(121432027)
				local var_112_9 = arg_109_1:FormatText(var_112_8.content)

				arg_109_1.text_.text = var_112_9

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_10 = 38
				local var_112_11 = utf8.len(var_112_9)
				local var_112_12 = var_112_10 <= 0 and var_112_7 or var_112_7 * (var_112_11 / var_112_10)

				if var_112_12 > 0 and var_112_7 < var_112_12 then
					arg_109_1.talkMaxDuration = var_112_12

					if var_112_12 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_9
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_13 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_13 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_13

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_13 and arg_109_1.time_ < var_112_6 + var_112_13 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play121432028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 121432028
		arg_113_1.duration_ = 11.77

		local var_113_0 = {
			ja = 11.766,
			ko = 5.4,
			zh = 5.4
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play121432029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = arg_113_1.actors_["1074ui_story"]
			local var_116_1 = 0

			if var_116_1 < arg_113_1.time_ and arg_113_1.time_ <= var_116_1 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1074ui_story == nil then
				arg_113_1.var_.characterEffect1074ui_story = var_116_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if var_116_1 <= arg_113_1.time_ and arg_113_1.time_ < var_116_1 + var_116_2 and not isNil(var_116_0) then
				local var_116_3 = (arg_113_1.time_ - var_116_1) / var_116_2

				if arg_113_1.var_.characterEffect1074ui_story and not isNil(var_116_0) then
					arg_113_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= var_116_1 + var_116_2 and arg_113_1.time_ < var_116_1 + var_116_2 + arg_116_0 and not isNil(var_116_0) and arg_113_1.var_.characterEffect1074ui_story then
				arg_113_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_116_4 = 0

			if var_116_4 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_116_5 = 0

			if var_116_5 < arg_113_1.time_ and arg_113_1.time_ <= var_116_5 + arg_116_0 then
				arg_113_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_116_6 = 0
			local var_116_7 = 0.55

			if var_116_6 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				local var_116_8 = arg_113_1:FormatText(StoryNameCfg[410].name)

				arg_113_1.leftNameTxt_.text = var_116_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_9 = arg_113_1:GetWordFromCfg(121432028)
				local var_116_10 = arg_113_1:FormatText(var_116_9.content)

				arg_113_1.text_.text = var_116_10

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 22
				local var_116_12 = utf8.len(var_116_10)
				local var_116_13 = var_116_11 <= 0 and var_116_7 or var_116_7 * (var_116_12 / var_116_11)

				if var_116_13 > 0 and var_116_7 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_10
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432028", "story_v_out_121432.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_121432", "121432028", "story_v_out_121432.awb") / 1000

					if var_116_14 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_6
					end

					if var_116_9.prefab_name ~= "" and arg_113_1.actors_[var_116_9.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_9.prefab_name].transform, "story_v_out_121432", "121432028", "story_v_out_121432.awb")

						arg_113_1:RecordAudio("121432028", var_116_15)
						arg_113_1:RecordAudio("121432028", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_121432", "121432028", "story_v_out_121432.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_121432", "121432028", "story_v_out_121432.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_16 and arg_113_1.time_ < var_116_6 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play121432029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 121432029
		arg_117_1.duration_ = 8.97

		local var_117_0 = {
			ja = 8.966,
			ko = 4.133,
			zh = 4.133
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
				arg_117_0:Play121432030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = arg_117_1.actors_["1072ui_story"]
			local var_120_1 = 0

			if var_120_1 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1072ui_story == nil then
				arg_117_1.var_.characterEffect1072ui_story = var_120_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_2 and not isNil(var_120_0) then
				local var_120_3 = (arg_117_1.time_ - var_120_1) / var_120_2

				if arg_117_1.var_.characterEffect1072ui_story and not isNil(var_120_0) then
					arg_117_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= var_120_1 + var_120_2 and arg_117_1.time_ < var_120_1 + var_120_2 + arg_120_0 and not isNil(var_120_0) and arg_117_1.var_.characterEffect1072ui_story then
				arg_117_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_120_4 = 0

			if var_120_4 < arg_117_1.time_ and arg_117_1.time_ <= var_120_4 + arg_120_0 then
				arg_117_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_1")
			end

			local var_120_5 = 0

			if var_120_5 < arg_117_1.time_ and arg_117_1.time_ <= var_120_5 + arg_120_0 then
				arg_117_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_120_6 = arg_117_1.actors_["1074ui_story"]
			local var_120_7 = 0

			if var_120_7 < arg_117_1.time_ and arg_117_1.time_ <= var_120_7 + arg_120_0 and not isNil(var_120_6) and arg_117_1.var_.characterEffect1074ui_story == nil then
				arg_117_1.var_.characterEffect1074ui_story = var_120_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_8 = 0.200000002980232

			if var_120_7 <= arg_117_1.time_ and arg_117_1.time_ < var_120_7 + var_120_8 and not isNil(var_120_6) then
				local var_120_9 = (arg_117_1.time_ - var_120_7) / var_120_8

				if arg_117_1.var_.characterEffect1074ui_story and not isNil(var_120_6) then
					local var_120_10 = Mathf.Lerp(0, 0.5, var_120_9)

					arg_117_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1074ui_story.fillRatio = var_120_10
				end
			end

			if arg_117_1.time_ >= var_120_7 + var_120_8 and arg_117_1.time_ < var_120_7 + var_120_8 + arg_120_0 and not isNil(var_120_6) and arg_117_1.var_.characterEffect1074ui_story then
				local var_120_11 = 0.5

				arg_117_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1074ui_story.fillRatio = var_120_11
			end

			local var_120_12 = 0
			local var_120_13 = 0.55

			if var_120_12 < arg_117_1.time_ and arg_117_1.time_ <= var_120_12 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				local var_120_14 = arg_117_1:FormatText(StoryNameCfg[379].name)

				arg_117_1.leftNameTxt_.text = var_120_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_15 = arg_117_1:GetWordFromCfg(121432029)
				local var_120_16 = arg_117_1:FormatText(var_120_15.content)

				arg_117_1.text_.text = var_120_16

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_17 = 22
				local var_120_18 = utf8.len(var_120_16)
				local var_120_19 = var_120_17 <= 0 and var_120_13 or var_120_13 * (var_120_18 / var_120_17)

				if var_120_19 > 0 and var_120_13 < var_120_19 then
					arg_117_1.talkMaxDuration = var_120_19

					if var_120_19 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_19 + var_120_12
					end
				end

				arg_117_1.text_.text = var_120_16
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432029", "story_v_out_121432.awb") ~= 0 then
					local var_120_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432029", "story_v_out_121432.awb") / 1000

					if var_120_20 + var_120_12 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_20 + var_120_12
					end

					if var_120_15.prefab_name ~= "" and arg_117_1.actors_[var_120_15.prefab_name] ~= nil then
						local var_120_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_15.prefab_name].transform, "story_v_out_121432", "121432029", "story_v_out_121432.awb")

						arg_117_1:RecordAudio("121432029", var_120_21)
						arg_117_1:RecordAudio("121432029", var_120_21)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_121432", "121432029", "story_v_out_121432.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_121432", "121432029", "story_v_out_121432.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_22 = math.max(var_120_13, arg_117_1.talkMaxDuration)

			if var_120_12 <= arg_117_1.time_ and arg_117_1.time_ < var_120_12 + var_120_22 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_12) / var_120_22

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_12 + var_120_22 and arg_117_1.time_ < var_120_12 + var_120_22 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play121432030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 121432030
		arg_121_1.duration_ = 4.27

		local var_121_0 = {
			ja = 4.266,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play121432031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1074ui_story"]
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1074ui_story == nil then
				arg_121_1.var_.characterEffect1074ui_story = var_124_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 and not isNil(var_124_0) then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2

				if arg_121_1.var_.characterEffect1074ui_story and not isNil(var_124_0) then
					arg_121_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 and not isNil(var_124_0) and arg_121_1.var_.characterEffect1074ui_story then
				arg_121_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_124_4 = 0

			if var_124_4 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_124_5 = 0

			if var_124_5 < arg_121_1.time_ and arg_121_1.time_ <= var_124_5 + arg_124_0 then
				arg_121_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_124_6 = arg_121_1.actors_["1072ui_story"]
			local var_124_7 = 0

			if var_124_7 < arg_121_1.time_ and arg_121_1.time_ <= var_124_7 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1072ui_story == nil then
				arg_121_1.var_.characterEffect1072ui_story = var_124_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_8 = 0.200000002980232

			if var_124_7 <= arg_121_1.time_ and arg_121_1.time_ < var_124_7 + var_124_8 and not isNil(var_124_6) then
				local var_124_9 = (arg_121_1.time_ - var_124_7) / var_124_8

				if arg_121_1.var_.characterEffect1072ui_story and not isNil(var_124_6) then
					local var_124_10 = Mathf.Lerp(0, 0.5, var_124_9)

					arg_121_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1072ui_story.fillRatio = var_124_10
				end
			end

			if arg_121_1.time_ >= var_124_7 + var_124_8 and arg_121_1.time_ < var_124_7 + var_124_8 + arg_124_0 and not isNil(var_124_6) and arg_121_1.var_.characterEffect1072ui_story then
				local var_124_11 = 0.5

				arg_121_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1072ui_story.fillRatio = var_124_11
			end

			local var_124_12 = 0
			local var_124_13 = 0.15

			if var_124_12 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_14 = arg_121_1:FormatText(StoryNameCfg[410].name)

				arg_121_1.leftNameTxt_.text = var_124_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_15 = arg_121_1:GetWordFromCfg(121432030)
				local var_124_16 = arg_121_1:FormatText(var_124_15.content)

				arg_121_1.text_.text = var_124_16

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_17 = 6
				local var_124_18 = utf8.len(var_124_16)
				local var_124_19 = var_124_17 <= 0 and var_124_13 or var_124_13 * (var_124_18 / var_124_17)

				if var_124_19 > 0 and var_124_13 < var_124_19 then
					arg_121_1.talkMaxDuration = var_124_19

					if var_124_19 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_19 + var_124_12
					end
				end

				arg_121_1.text_.text = var_124_16
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432030", "story_v_out_121432.awb") ~= 0 then
					local var_124_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432030", "story_v_out_121432.awb") / 1000

					if var_124_20 + var_124_12 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_20 + var_124_12
					end

					if var_124_15.prefab_name ~= "" and arg_121_1.actors_[var_124_15.prefab_name] ~= nil then
						local var_124_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_15.prefab_name].transform, "story_v_out_121432", "121432030", "story_v_out_121432.awb")

						arg_121_1:RecordAudio("121432030", var_124_21)
						arg_121_1:RecordAudio("121432030", var_124_21)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_121432", "121432030", "story_v_out_121432.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_121432", "121432030", "story_v_out_121432.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_22 = math.max(var_124_13, arg_121_1.talkMaxDuration)

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_22 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_12) / var_124_22

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_12 + var_124_22 and arg_121_1.time_ < var_124_12 + var_124_22 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play121432031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 121432031
		arg_125_1.duration_ = 3.1

		local var_125_0 = {
			ja = 3.1,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_125_0:Play121432032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1072ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1072ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(-0.7, -0.71, -6)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1072ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = arg_125_1.actors_["1072ui_story"]
			local var_128_10 = 0

			if var_128_10 < arg_125_1.time_ and arg_125_1.time_ <= var_128_10 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1072ui_story == nil then
				arg_125_1.var_.characterEffect1072ui_story = var_128_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_11 = 0.200000002980232

			if var_128_10 <= arg_125_1.time_ and arg_125_1.time_ < var_128_10 + var_128_11 and not isNil(var_128_9) then
				local var_128_12 = (arg_125_1.time_ - var_128_10) / var_128_11

				if arg_125_1.var_.characterEffect1072ui_story and not isNil(var_128_9) then
					arg_125_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= var_128_10 + var_128_11 and arg_125_1.time_ < var_128_10 + var_128_11 + arg_128_0 and not isNil(var_128_9) and arg_125_1.var_.characterEffect1072ui_story then
				arg_125_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_128_13 = 0

			if var_128_13 < arg_125_1.time_ and arg_125_1.time_ <= var_128_13 + arg_128_0 then
				arg_125_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action3_2")
			end

			local var_128_14 = 0

			if var_128_14 < arg_125_1.time_ and arg_125_1.time_ <= var_128_14 + arg_128_0 then
				arg_125_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_128_15 = arg_125_1.actors_["1074ui_story"]
			local var_128_16 = 0

			if var_128_16 < arg_125_1.time_ and arg_125_1.time_ <= var_128_16 + arg_128_0 and not isNil(var_128_15) and arg_125_1.var_.characterEffect1074ui_story == nil then
				arg_125_1.var_.characterEffect1074ui_story = var_128_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_17 = 0.200000002980232

			if var_128_16 <= arg_125_1.time_ and arg_125_1.time_ < var_128_16 + var_128_17 and not isNil(var_128_15) then
				local var_128_18 = (arg_125_1.time_ - var_128_16) / var_128_17

				if arg_125_1.var_.characterEffect1074ui_story and not isNil(var_128_15) then
					local var_128_19 = Mathf.Lerp(0, 0.5, var_128_18)

					arg_125_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1074ui_story.fillRatio = var_128_19
				end
			end

			if arg_125_1.time_ >= var_128_16 + var_128_17 and arg_125_1.time_ < var_128_16 + var_128_17 + arg_128_0 and not isNil(var_128_15) and arg_125_1.var_.characterEffect1074ui_story then
				local var_128_20 = 0.5

				arg_125_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1074ui_story.fillRatio = var_128_20
			end

			local var_128_21 = 0
			local var_128_22 = 0.1

			if var_128_21 < arg_125_1.time_ and arg_125_1.time_ <= var_128_21 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				local var_128_23 = arg_125_1:FormatText(StoryNameCfg[379].name)

				arg_125_1.leftNameTxt_.text = var_128_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_24 = arg_125_1:GetWordFromCfg(121432031)
				local var_128_25 = arg_125_1:FormatText(var_128_24.content)

				arg_125_1.text_.text = var_128_25

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_26 = 4
				local var_128_27 = utf8.len(var_128_25)
				local var_128_28 = var_128_26 <= 0 and var_128_22 or var_128_22 * (var_128_27 / var_128_26)

				if var_128_28 > 0 and var_128_22 < var_128_28 then
					arg_125_1.talkMaxDuration = var_128_28

					if var_128_28 + var_128_21 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_28 + var_128_21
					end
				end

				arg_125_1.text_.text = var_128_25
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432031", "story_v_out_121432.awb") ~= 0 then
					local var_128_29 = manager.audio:GetVoiceLength("story_v_out_121432", "121432031", "story_v_out_121432.awb") / 1000

					if var_128_29 + var_128_21 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_29 + var_128_21
					end

					if var_128_24.prefab_name ~= "" and arg_125_1.actors_[var_128_24.prefab_name] ~= nil then
						local var_128_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_24.prefab_name].transform, "story_v_out_121432", "121432031", "story_v_out_121432.awb")

						arg_125_1:RecordAudio("121432031", var_128_30)
						arg_125_1:RecordAudio("121432031", var_128_30)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_121432", "121432031", "story_v_out_121432.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_121432", "121432031", "story_v_out_121432.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_31 = math.max(var_128_22, arg_125_1.talkMaxDuration)

			if var_128_21 <= arg_125_1.time_ and arg_125_1.time_ < var_128_21 + var_128_31 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_21) / var_128_31

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_21 + var_128_31 and arg_125_1.time_ < var_128_21 + var_128_31 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play121432032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 121432032
		arg_129_1.duration_ = 3.27

		local var_129_0 = {
			ja = 3.266,
			ko = 2.266,
			zh = 2.266
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play121432033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = arg_129_1.actors_["1074ui_story"]
			local var_132_1 = 0

			if var_132_1 < arg_129_1.time_ and arg_129_1.time_ <= var_132_1 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1074ui_story == nil then
				arg_129_1.var_.characterEffect1074ui_story = var_132_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if var_132_1 <= arg_129_1.time_ and arg_129_1.time_ < var_132_1 + var_132_2 and not isNil(var_132_0) then
				local var_132_3 = (arg_129_1.time_ - var_132_1) / var_132_2

				if arg_129_1.var_.characterEffect1074ui_story and not isNil(var_132_0) then
					arg_129_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= var_132_1 + var_132_2 and arg_129_1.time_ < var_132_1 + var_132_2 + arg_132_0 and not isNil(var_132_0) and arg_129_1.var_.characterEffect1074ui_story then
				arg_129_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_132_4 = 0

			if var_132_4 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_132_5 = 0

			if var_132_5 < arg_129_1.time_ and arg_129_1.time_ <= var_132_5 + arg_132_0 then
				arg_129_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_132_6 = arg_129_1.actors_["1072ui_story"]
			local var_132_7 = 0

			if var_132_7 < arg_129_1.time_ and arg_129_1.time_ <= var_132_7 + arg_132_0 and not isNil(var_132_6) and arg_129_1.var_.characterEffect1072ui_story == nil then
				arg_129_1.var_.characterEffect1072ui_story = var_132_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_8 = 0.200000002980232

			if var_132_7 <= arg_129_1.time_ and arg_129_1.time_ < var_132_7 + var_132_8 and not isNil(var_132_6) then
				local var_132_9 = (arg_129_1.time_ - var_132_7) / var_132_8

				if arg_129_1.var_.characterEffect1072ui_story and not isNil(var_132_6) then
					local var_132_10 = Mathf.Lerp(0, 0.5, var_132_9)

					arg_129_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1072ui_story.fillRatio = var_132_10
				end
			end

			if arg_129_1.time_ >= var_132_7 + var_132_8 and arg_129_1.time_ < var_132_7 + var_132_8 + arg_132_0 and not isNil(var_132_6) and arg_129_1.var_.characterEffect1072ui_story then
				local var_132_11 = 0.5

				arg_129_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1072ui_story.fillRatio = var_132_11
			end

			local var_132_12 = 0
			local var_132_13 = 0.2

			if var_132_12 < arg_129_1.time_ and arg_129_1.time_ <= var_132_12 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				local var_132_14 = arg_129_1:FormatText(StoryNameCfg[410].name)

				arg_129_1.leftNameTxt_.text = var_132_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_15 = arg_129_1:GetWordFromCfg(121432032)
				local var_132_16 = arg_129_1:FormatText(var_132_15.content)

				arg_129_1.text_.text = var_132_16

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_17 = 8
				local var_132_18 = utf8.len(var_132_16)
				local var_132_19 = var_132_17 <= 0 and var_132_13 or var_132_13 * (var_132_18 / var_132_17)

				if var_132_19 > 0 and var_132_13 < var_132_19 then
					arg_129_1.talkMaxDuration = var_132_19

					if var_132_19 + var_132_12 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_19 + var_132_12
					end
				end

				arg_129_1.text_.text = var_132_16
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432032", "story_v_out_121432.awb") ~= 0 then
					local var_132_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432032", "story_v_out_121432.awb") / 1000

					if var_132_20 + var_132_12 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_20 + var_132_12
					end

					if var_132_15.prefab_name ~= "" and arg_129_1.actors_[var_132_15.prefab_name] ~= nil then
						local var_132_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_15.prefab_name].transform, "story_v_out_121432", "121432032", "story_v_out_121432.awb")

						arg_129_1:RecordAudio("121432032", var_132_21)
						arg_129_1:RecordAudio("121432032", var_132_21)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_121432", "121432032", "story_v_out_121432.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_121432", "121432032", "story_v_out_121432.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_22 = math.max(var_132_13, arg_129_1.talkMaxDuration)

			if var_132_12 <= arg_129_1.time_ and arg_129_1.time_ < var_132_12 + var_132_22 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_12) / var_132_22

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_12 + var_132_22 and arg_129_1.time_ < var_132_12 + var_132_22 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play121432033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 121432033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play121432034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = arg_133_1.actors_["1074ui_story"]
			local var_136_1 = 0

			if var_136_1 < arg_133_1.time_ and arg_133_1.time_ <= var_136_1 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1074ui_story == nil then
				arg_133_1.var_.characterEffect1074ui_story = var_136_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if var_136_1 <= arg_133_1.time_ and arg_133_1.time_ < var_136_1 + var_136_2 and not isNil(var_136_0) then
				local var_136_3 = (arg_133_1.time_ - var_136_1) / var_136_2

				if arg_133_1.var_.characterEffect1074ui_story and not isNil(var_136_0) then
					local var_136_4 = Mathf.Lerp(0, 0.5, var_136_3)

					arg_133_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1074ui_story.fillRatio = var_136_4
				end
			end

			if arg_133_1.time_ >= var_136_1 + var_136_2 and arg_133_1.time_ < var_136_1 + var_136_2 + arg_136_0 and not isNil(var_136_0) and arg_133_1.var_.characterEffect1074ui_story then
				local var_136_5 = 0.5

				arg_133_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1074ui_story.fillRatio = var_136_5
			end

			local var_136_6 = 0
			local var_136_7 = 1.2

			if var_136_6 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:GetWordFromCfg(121432033)
				local var_136_9 = arg_133_1:FormatText(var_136_8.content)

				arg_133_1.text_.text = var_136_9

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_10 = 48
				local var_136_11 = utf8.len(var_136_9)
				local var_136_12 = var_136_10 <= 0 and var_136_7 or var_136_7 * (var_136_11 / var_136_10)

				if var_136_12 > 0 and var_136_7 < var_136_12 then
					arg_133_1.talkMaxDuration = var_136_12

					if var_136_12 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_9
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_13 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_13 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_13

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_13 and arg_133_1.time_ < var_136_6 + var_136_13 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play121432034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 121432034
		arg_137_1.duration_ = 11.6

		local var_137_0 = {
			ja = 11.6,
			ko = 6.233,
			zh = 6.233
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
				arg_137_0:Play121432035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			local var_140_0 = arg_137_1.actors_["1072ui_story"]
			local var_140_1 = 0

			if var_140_1 < arg_137_1.time_ and arg_137_1.time_ <= var_140_1 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1072ui_story == nil then
				arg_137_1.var_.characterEffect1072ui_story = var_140_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if var_140_1 <= arg_137_1.time_ and arg_137_1.time_ < var_140_1 + var_140_2 and not isNil(var_140_0) then
				local var_140_3 = (arg_137_1.time_ - var_140_1) / var_140_2

				if arg_137_1.var_.characterEffect1072ui_story and not isNil(var_140_0) then
					arg_137_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= var_140_1 + var_140_2 and arg_137_1.time_ < var_140_1 + var_140_2 + arg_140_0 and not isNil(var_140_0) and arg_137_1.var_.characterEffect1072ui_story then
				arg_137_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_140_4 = 0

			if var_140_4 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action1_1")
			end

			local var_140_5 = 0

			if var_140_5 < arg_137_1.time_ and arg_137_1.time_ <= var_140_5 + arg_140_0 then
				arg_137_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_140_6 = 0
			local var_140_7 = 0.775

			if var_140_6 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				local var_140_8 = arg_137_1:FormatText(StoryNameCfg[379].name)

				arg_137_1.leftNameTxt_.text = var_140_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_9 = arg_137_1:GetWordFromCfg(121432034)
				local var_140_10 = arg_137_1:FormatText(var_140_9.content)

				arg_137_1.text_.text = var_140_10

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 31
				local var_140_12 = utf8.len(var_140_10)
				local var_140_13 = var_140_11 <= 0 and var_140_7 or var_140_7 * (var_140_12 / var_140_11)

				if var_140_13 > 0 and var_140_7 < var_140_13 then
					arg_137_1.talkMaxDuration = var_140_13

					if var_140_13 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_13 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_10
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432034", "story_v_out_121432.awb") ~= 0 then
					local var_140_14 = manager.audio:GetVoiceLength("story_v_out_121432", "121432034", "story_v_out_121432.awb") / 1000

					if var_140_14 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_14 + var_140_6
					end

					if var_140_9.prefab_name ~= "" and arg_137_1.actors_[var_140_9.prefab_name] ~= nil then
						local var_140_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_9.prefab_name].transform, "story_v_out_121432", "121432034", "story_v_out_121432.awb")

						arg_137_1:RecordAudio("121432034", var_140_15)
						arg_137_1:RecordAudio("121432034", var_140_15)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_121432", "121432034", "story_v_out_121432.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_121432", "121432034", "story_v_out_121432.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_16 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_16 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_16

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_16 and arg_137_1.time_ < var_140_6 + var_140_16 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {}

		arg_137_1:InitPlayNodeList()
	end,
	Play121432035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 121432035
		arg_141_1.duration_ = 13.7

		local var_141_0 = {
			ja = 13.7,
			ko = 10.666,
			zh = 10.666
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
				arg_141_0:Play121432036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			local var_144_0 = 0
			local var_144_1 = 1.125

			if var_144_0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_0 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				local var_144_2 = arg_141_1:FormatText(StoryNameCfg[379].name)

				arg_141_1.leftNameTxt_.text = var_144_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(121432035)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 45
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

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432035", "story_v_out_121432.awb") ~= 0 then
					local var_144_8 = manager.audio:GetVoiceLength("story_v_out_121432", "121432035", "story_v_out_121432.awb") / 1000

					if var_144_8 + var_144_0 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_8 + var_144_0
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_121432", "121432035", "story_v_out_121432.awb")

						arg_141_1:RecordAudio("121432035", var_144_9)
						arg_141_1:RecordAudio("121432035", var_144_9)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_121432", "121432035", "story_v_out_121432.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_121432", "121432035", "story_v_out_121432.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_10 = math.max(var_144_1, arg_141_1.talkMaxDuration)

			if var_144_0 <= arg_141_1.time_ and arg_141_1.time_ < var_144_0 + var_144_10 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_0) / var_144_10

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_0 + var_144_10 and arg_141_1.time_ < var_144_0 + var_144_10 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play121432036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 121432036
		arg_145_1.duration_ = 8.8

		local var_145_0 = {
			ja = 8.8,
			ko = 3.466,
			zh = 3.466
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
				arg_145_0:Play121432037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["1074ui_story"]
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1074ui_story == nil then
				arg_145_1.var_.characterEffect1074ui_story = var_148_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 and not isNil(var_148_0) then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2

				if arg_145_1.var_.characterEffect1074ui_story and not isNil(var_148_0) then
					arg_145_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 and not isNil(var_148_0) and arg_145_1.var_.characterEffect1074ui_story then
				arg_145_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_148_4 = 0

			if var_148_4 < arg_145_1.time_ and arg_145_1.time_ <= var_148_4 + arg_148_0 then
				arg_145_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_148_5 = 0

			if var_148_5 < arg_145_1.time_ and arg_145_1.time_ <= var_148_5 + arg_148_0 then
				arg_145_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_148_6 = arg_145_1.actors_["1072ui_story"]
			local var_148_7 = 0

			if var_148_7 < arg_145_1.time_ and arg_145_1.time_ <= var_148_7 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1072ui_story == nil then
				arg_145_1.var_.characterEffect1072ui_story = var_148_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_8 = 0.200000002980232

			if var_148_7 <= arg_145_1.time_ and arg_145_1.time_ < var_148_7 + var_148_8 and not isNil(var_148_6) then
				local var_148_9 = (arg_145_1.time_ - var_148_7) / var_148_8

				if arg_145_1.var_.characterEffect1072ui_story and not isNil(var_148_6) then
					local var_148_10 = Mathf.Lerp(0, 0.5, var_148_9)

					arg_145_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1072ui_story.fillRatio = var_148_10
				end
			end

			if arg_145_1.time_ >= var_148_7 + var_148_8 and arg_145_1.time_ < var_148_7 + var_148_8 + arg_148_0 and not isNil(var_148_6) and arg_145_1.var_.characterEffect1072ui_story then
				local var_148_11 = 0.5

				arg_145_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1072ui_story.fillRatio = var_148_11
			end

			local var_148_12 = 0
			local var_148_13 = 0.425

			if var_148_12 < arg_145_1.time_ and arg_145_1.time_ <= var_148_12 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_14 = arg_145_1:FormatText(StoryNameCfg[410].name)

				arg_145_1.leftNameTxt_.text = var_148_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_15 = arg_145_1:GetWordFromCfg(121432036)
				local var_148_16 = arg_145_1:FormatText(var_148_15.content)

				arg_145_1.text_.text = var_148_16

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_17 = 17
				local var_148_18 = utf8.len(var_148_16)
				local var_148_19 = var_148_17 <= 0 and var_148_13 or var_148_13 * (var_148_18 / var_148_17)

				if var_148_19 > 0 and var_148_13 < var_148_19 then
					arg_145_1.talkMaxDuration = var_148_19

					if var_148_19 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_19 + var_148_12
					end
				end

				arg_145_1.text_.text = var_148_16
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432036", "story_v_out_121432.awb") ~= 0 then
					local var_148_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432036", "story_v_out_121432.awb") / 1000

					if var_148_20 + var_148_12 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_20 + var_148_12
					end

					if var_148_15.prefab_name ~= "" and arg_145_1.actors_[var_148_15.prefab_name] ~= nil then
						local var_148_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_15.prefab_name].transform, "story_v_out_121432", "121432036", "story_v_out_121432.awb")

						arg_145_1:RecordAudio("121432036", var_148_21)
						arg_145_1:RecordAudio("121432036", var_148_21)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_121432", "121432036", "story_v_out_121432.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_121432", "121432036", "story_v_out_121432.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_22 = math.max(var_148_13, arg_145_1.talkMaxDuration)

			if var_148_12 <= arg_145_1.time_ and arg_145_1.time_ < var_148_12 + var_148_22 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_12) / var_148_22

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_12 + var_148_22 and arg_145_1.time_ < var_148_12 + var_148_22 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play121432037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 121432037
		arg_149_1.duration_ = 10.53

		local var_149_0 = {
			ja = 10.533,
			ko = 8.6,
			zh = 8.6
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
				arg_149_0:Play121432038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["1072ui_story"]
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1072ui_story == nil then
				arg_149_1.var_.characterEffect1072ui_story = var_152_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 and not isNil(var_152_0) then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2

				if arg_149_1.var_.characterEffect1072ui_story and not isNil(var_152_0) then
					arg_149_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 and not isNil(var_152_0) and arg_149_1.var_.characterEffect1072ui_story then
				arg_149_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_152_4 = 0

			if var_152_4 < arg_149_1.time_ and arg_149_1.time_ <= var_152_4 + arg_152_0 then
				arg_149_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_1")
			end

			local var_152_5 = 0

			if var_152_5 < arg_149_1.time_ and arg_149_1.time_ <= var_152_5 + arg_152_0 then
				arg_149_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_152_6 = arg_149_1.actors_["1074ui_story"]
			local var_152_7 = 0

			if var_152_7 < arg_149_1.time_ and arg_149_1.time_ <= var_152_7 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect1074ui_story == nil then
				arg_149_1.var_.characterEffect1074ui_story = var_152_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_8 = 0.200000002980232

			if var_152_7 <= arg_149_1.time_ and arg_149_1.time_ < var_152_7 + var_152_8 and not isNil(var_152_6) then
				local var_152_9 = (arg_149_1.time_ - var_152_7) / var_152_8

				if arg_149_1.var_.characterEffect1074ui_story and not isNil(var_152_6) then
					local var_152_10 = Mathf.Lerp(0, 0.5, var_152_9)

					arg_149_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_149_1.var_.characterEffect1074ui_story.fillRatio = var_152_10
				end
			end

			if arg_149_1.time_ >= var_152_7 + var_152_8 and arg_149_1.time_ < var_152_7 + var_152_8 + arg_152_0 and not isNil(var_152_6) and arg_149_1.var_.characterEffect1074ui_story then
				local var_152_11 = 0.5

				arg_149_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_149_1.var_.characterEffect1074ui_story.fillRatio = var_152_11
			end

			local var_152_12 = 0
			local var_152_13 = 0.775

			if var_152_12 < arg_149_1.time_ and arg_149_1.time_ <= var_152_12 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				local var_152_14 = arg_149_1:FormatText(StoryNameCfg[379].name)

				arg_149_1.leftNameTxt_.text = var_152_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_15 = arg_149_1:GetWordFromCfg(121432037)
				local var_152_16 = arg_149_1:FormatText(var_152_15.content)

				arg_149_1.text_.text = var_152_16

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_17 = 34
				local var_152_18 = utf8.len(var_152_16)
				local var_152_19 = var_152_17 <= 0 and var_152_13 or var_152_13 * (var_152_18 / var_152_17)

				if var_152_19 > 0 and var_152_13 < var_152_19 then
					arg_149_1.talkMaxDuration = var_152_19

					if var_152_19 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_19 + var_152_12
					end
				end

				arg_149_1.text_.text = var_152_16
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432037", "story_v_out_121432.awb") ~= 0 then
					local var_152_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432037", "story_v_out_121432.awb") / 1000

					if var_152_20 + var_152_12 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_20 + var_152_12
					end

					if var_152_15.prefab_name ~= "" and arg_149_1.actors_[var_152_15.prefab_name] ~= nil then
						local var_152_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_15.prefab_name].transform, "story_v_out_121432", "121432037", "story_v_out_121432.awb")

						arg_149_1:RecordAudio("121432037", var_152_21)
						arg_149_1:RecordAudio("121432037", var_152_21)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_121432", "121432037", "story_v_out_121432.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_121432", "121432037", "story_v_out_121432.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_22 = math.max(var_152_13, arg_149_1.talkMaxDuration)

			if var_152_12 <= arg_149_1.time_ and arg_149_1.time_ < var_152_12 + var_152_22 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_12) / var_152_22

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_12 + var_152_22 and arg_149_1.time_ < var_152_12 + var_152_22 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play121432038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 121432038
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play121432039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = arg_153_1.actors_["1072ui_story"]
			local var_156_1 = 0

			if var_156_1 < arg_153_1.time_ and arg_153_1.time_ <= var_156_1 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1072ui_story == nil then
				arg_153_1.var_.characterEffect1072ui_story = var_156_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.0166666666666667

			if var_156_1 <= arg_153_1.time_ and arg_153_1.time_ < var_156_1 + var_156_2 and not isNil(var_156_0) then
				local var_156_3 = (arg_153_1.time_ - var_156_1) / var_156_2

				if arg_153_1.var_.characterEffect1072ui_story and not isNil(var_156_0) then
					local var_156_4 = Mathf.Lerp(0, 0.5, var_156_3)

					arg_153_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_153_1.var_.characterEffect1072ui_story.fillRatio = var_156_4
				end
			end

			if arg_153_1.time_ >= var_156_1 + var_156_2 and arg_153_1.time_ < var_156_1 + var_156_2 + arg_156_0 and not isNil(var_156_0) and arg_153_1.var_.characterEffect1072ui_story then
				local var_156_5 = 0.5

				arg_153_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_153_1.var_.characterEffect1072ui_story.fillRatio = var_156_5
			end

			local var_156_6 = 0.133333333333333
			local var_156_7 = 0.366666666666667

			if var_156_6 < arg_153_1.time_ and arg_153_1.time_ <= var_156_6 + arg_156_0 then
				local var_156_8 = "play"
				local var_156_9 = "effect"

				arg_153_1:AudioAction(var_156_8, var_156_9, "se_story_7", "se_story_7_blast", "")
			end

			local var_156_10 = 0.7
			local var_156_11 = 0.366666666666667

			if var_156_10 < arg_153_1.time_ and arg_153_1.time_ <= var_156_10 + arg_156_0 then
				local var_156_12 = "play"
				local var_156_13 = "effect"

				arg_153_1:AudioAction(var_156_12, var_156_13, "se_story_7", "se_story_7_blast", "")
			end

			local var_156_14 = arg_153_1.actors_["1072ui_story"].transform
			local var_156_15 = 0

			if var_156_15 < arg_153_1.time_ and arg_153_1.time_ <= var_156_15 + arg_156_0 then
				arg_153_1.var_.moveOldPos1072ui_story = var_156_14.localPosition
			end

			local var_156_16 = 0.001

			if var_156_15 <= arg_153_1.time_ and arg_153_1.time_ < var_156_15 + var_156_16 then
				local var_156_17 = (arg_153_1.time_ - var_156_15) / var_156_16
				local var_156_18 = Vector3.New(0, 100, 0)

				var_156_14.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1072ui_story, var_156_18, var_156_17)

				local var_156_19 = manager.ui.mainCamera.transform.position - var_156_14.position

				var_156_14.forward = Vector3.New(var_156_19.x, var_156_19.y, var_156_19.z)

				local var_156_20 = var_156_14.localEulerAngles

				var_156_20.z = 0
				var_156_20.x = 0
				var_156_14.localEulerAngles = var_156_20
			end

			if arg_153_1.time_ >= var_156_15 + var_156_16 and arg_153_1.time_ < var_156_15 + var_156_16 + arg_156_0 then
				var_156_14.localPosition = Vector3.New(0, 100, 0)

				local var_156_21 = manager.ui.mainCamera.transform.position - var_156_14.position

				var_156_14.forward = Vector3.New(var_156_21.x, var_156_21.y, var_156_21.z)

				local var_156_22 = var_156_14.localEulerAngles

				var_156_22.z = 0
				var_156_22.x = 0
				var_156_14.localEulerAngles = var_156_22
			end

			local var_156_23 = arg_153_1.actors_["1074ui_story"].transform
			local var_156_24 = 0

			if var_156_24 < arg_153_1.time_ and arg_153_1.time_ <= var_156_24 + arg_156_0 then
				arg_153_1.var_.moveOldPos1074ui_story = var_156_23.localPosition
			end

			local var_156_25 = 0.001

			if var_156_24 <= arg_153_1.time_ and arg_153_1.time_ < var_156_24 + var_156_25 then
				local var_156_26 = (arg_153_1.time_ - var_156_24) / var_156_25
				local var_156_27 = Vector3.New(0, 100, 0)

				var_156_23.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1074ui_story, var_156_27, var_156_26)

				local var_156_28 = manager.ui.mainCamera.transform.position - var_156_23.position

				var_156_23.forward = Vector3.New(var_156_28.x, var_156_28.y, var_156_28.z)

				local var_156_29 = var_156_23.localEulerAngles

				var_156_29.z = 0
				var_156_29.x = 0
				var_156_23.localEulerAngles = var_156_29
			end

			if arg_153_1.time_ >= var_156_24 + var_156_25 and arg_153_1.time_ < var_156_24 + var_156_25 + arg_156_0 then
				var_156_23.localPosition = Vector3.New(0, 100, 0)

				local var_156_30 = manager.ui.mainCamera.transform.position - var_156_23.position

				var_156_23.forward = Vector3.New(var_156_30.x, var_156_30.y, var_156_30.z)

				local var_156_31 = var_156_23.localEulerAngles

				var_156_31.z = 0
				var_156_31.x = 0
				var_156_23.localEulerAngles = var_156_31
			end

			local var_156_32 = manager.ui.mainCamera.transform
			local var_156_33 = 0.133333333333333

			if var_156_33 < arg_153_1.time_ and arg_153_1.time_ <= var_156_33 + arg_156_0 then
				arg_153_1.var_.shakeOldPos = var_156_32.localPosition
			end

			local var_156_34 = 0.6

			if var_156_33 <= arg_153_1.time_ and arg_153_1.time_ < var_156_33 + var_156_34 then
				local var_156_35 = (arg_153_1.time_ - var_156_33) / 0.066
				local var_156_36, var_156_37 = math.modf(var_156_35)

				var_156_32.localPosition = Vector3.New(var_156_37 * 0.13, var_156_37 * 0.13, var_156_37 * 0.13) + arg_153_1.var_.shakeOldPos
			end

			if arg_153_1.time_ >= var_156_33 + var_156_34 and arg_153_1.time_ < var_156_33 + var_156_34 + arg_156_0 then
				var_156_32.localPosition = arg_153_1.var_.shakeOldPos
			end

			local var_156_38 = 0
			local var_156_39 = 1.25

			if var_156_38 < arg_153_1.time_ and arg_153_1.time_ <= var_156_38 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, false)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_40 = arg_153_1:GetWordFromCfg(121432038)
				local var_156_41 = arg_153_1:FormatText(var_156_40.content)

				arg_153_1.text_.text = var_156_41

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_42 = 50
				local var_156_43 = utf8.len(var_156_41)
				local var_156_44 = var_156_42 <= 0 and var_156_39 or var_156_39 * (var_156_43 / var_156_42)

				if var_156_44 > 0 and var_156_39 < var_156_44 then
					arg_153_1.talkMaxDuration = var_156_44

					if var_156_44 + var_156_38 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_44 + var_156_38
					end
				end

				arg_153_1.text_.text = var_156_41
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_45 = math.max(var_156_39, arg_153_1.talkMaxDuration)

			if var_156_38 <= arg_153_1.time_ and arg_153_1.time_ < var_156_38 + var_156_45 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_38) / var_156_45

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_38 + var_156_45 and arg_153_1.time_ < var_156_38 + var_156_45 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play121432039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 121432039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play121432040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = 0
			local var_160_1 = 0.625

			if var_160_0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_0 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_2 = arg_157_1:GetWordFromCfg(121432039)
				local var_160_3 = arg_157_1:FormatText(var_160_2.content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_4 = 25
				local var_160_5 = utf8.len(var_160_3)
				local var_160_6 = var_160_4 <= 0 and var_160_1 or var_160_1 * (var_160_5 / var_160_4)

				if var_160_6 > 0 and var_160_1 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_0 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_0
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_7 = math.max(var_160_1, arg_157_1.talkMaxDuration)

			if var_160_0 <= arg_157_1.time_ and arg_157_1.time_ < var_160_0 + var_160_7 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_0) / var_160_7

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_0 + var_160_7 and arg_157_1.time_ < var_160_0 + var_160_7 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play121432040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 121432040
		arg_161_1.duration_ = 2.5

		local var_161_0 = {
			ja = 2.5,
			ko = 2.366,
			zh = 2.366
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
				arg_161_0:Play121432041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = arg_161_1.actors_["1074ui_story"].transform
			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1.var_.moveOldPos1074ui_story = var_164_0.localPosition
			end

			local var_164_2 = 0.001

			if var_164_1 <= arg_161_1.time_ and arg_161_1.time_ < var_164_1 + var_164_2 then
				local var_164_3 = (arg_161_1.time_ - var_164_1) / var_164_2
				local var_164_4 = Vector3.New(0.7, -1.055, -6.12)

				var_164_0.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1074ui_story, var_164_4, var_164_3)

				local var_164_5 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_5.x, var_164_5.y, var_164_5.z)

				local var_164_6 = var_164_0.localEulerAngles

				var_164_6.z = 0
				var_164_6.x = 0
				var_164_0.localEulerAngles = var_164_6
			end

			if arg_161_1.time_ >= var_164_1 + var_164_2 and arg_161_1.time_ < var_164_1 + var_164_2 + arg_164_0 then
				var_164_0.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_164_7 = manager.ui.mainCamera.transform.position - var_164_0.position

				var_164_0.forward = Vector3.New(var_164_7.x, var_164_7.y, var_164_7.z)

				local var_164_8 = var_164_0.localEulerAngles

				var_164_8.z = 0
				var_164_8.x = 0
				var_164_0.localEulerAngles = var_164_8
			end

			local var_164_9 = arg_161_1.actors_["1074ui_story"]
			local var_164_10 = 0

			if var_164_10 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect1074ui_story == nil then
				arg_161_1.var_.characterEffect1074ui_story = var_164_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_11 = 0.200000002980232

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_11 and not isNil(var_164_9) then
				local var_164_12 = (arg_161_1.time_ - var_164_10) / var_164_11

				if arg_161_1.var_.characterEffect1074ui_story and not isNil(var_164_9) then
					arg_161_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= var_164_10 + var_164_11 and arg_161_1.time_ < var_164_10 + var_164_11 + arg_164_0 and not isNil(var_164_9) and arg_161_1.var_.characterEffect1074ui_story then
				arg_161_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_164_13 = 0

			if var_164_13 < arg_161_1.time_ and arg_161_1.time_ <= var_164_13 + arg_164_0 then
				arg_161_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_164_14 = 0

			if var_164_14 < arg_161_1.time_ and arg_161_1.time_ <= var_164_14 + arg_164_0 then
				arg_161_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_164_15 = 0
			local var_164_16 = 0.7

			if var_164_15 < arg_161_1.time_ and arg_161_1.time_ <= var_164_15 + arg_164_0 then
				local var_164_17 = "play"
				local var_164_18 = "effect"

				arg_161_1:AudioAction(var_164_17, var_164_18, "se_story_121_04", "se_story_121_04_roar_loop", "")
			end

			local var_164_19 = arg_161_1.actors_["1072ui_story"].transform
			local var_164_20 = 0

			if var_164_20 < arg_161_1.time_ and arg_161_1.time_ <= var_164_20 + arg_164_0 then
				arg_161_1.var_.moveOldPos1072ui_story = var_164_19.localPosition
			end

			local var_164_21 = 0.001

			if var_164_20 <= arg_161_1.time_ and arg_161_1.time_ < var_164_20 + var_164_21 then
				local var_164_22 = (arg_161_1.time_ - var_164_20) / var_164_21
				local var_164_23 = Vector3.New(-0.7, -0.71, -6)

				var_164_19.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1072ui_story, var_164_23, var_164_22)

				local var_164_24 = manager.ui.mainCamera.transform.position - var_164_19.position

				var_164_19.forward = Vector3.New(var_164_24.x, var_164_24.y, var_164_24.z)

				local var_164_25 = var_164_19.localEulerAngles

				var_164_25.z = 0
				var_164_25.x = 0
				var_164_19.localEulerAngles = var_164_25
			end

			if arg_161_1.time_ >= var_164_20 + var_164_21 and arg_161_1.time_ < var_164_20 + var_164_21 + arg_164_0 then
				var_164_19.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_164_26 = manager.ui.mainCamera.transform.position - var_164_19.position

				var_164_19.forward = Vector3.New(var_164_26.x, var_164_26.y, var_164_26.z)

				local var_164_27 = var_164_19.localEulerAngles

				var_164_27.z = 0
				var_164_27.x = 0
				var_164_19.localEulerAngles = var_164_27
			end

			local var_164_28 = 0
			local var_164_29 = 0.15

			if var_164_28 < arg_161_1.time_ and arg_161_1.time_ <= var_164_28 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_30 = arg_161_1:FormatText(StoryNameCfg[410].name)

				arg_161_1.leftNameTxt_.text = var_164_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_31 = arg_161_1:GetWordFromCfg(121432040)
				local var_164_32 = arg_161_1:FormatText(var_164_31.content)

				arg_161_1.text_.text = var_164_32

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_33 = 6
				local var_164_34 = utf8.len(var_164_32)
				local var_164_35 = var_164_33 <= 0 and var_164_29 or var_164_29 * (var_164_34 / var_164_33)

				if var_164_35 > 0 and var_164_29 < var_164_35 then
					arg_161_1.talkMaxDuration = var_164_35

					if var_164_35 + var_164_28 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_35 + var_164_28
					end
				end

				arg_161_1.text_.text = var_164_32
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432040", "story_v_out_121432.awb") ~= 0 then
					local var_164_36 = manager.audio:GetVoiceLength("story_v_out_121432", "121432040", "story_v_out_121432.awb") / 1000

					if var_164_36 + var_164_28 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_36 + var_164_28
					end

					if var_164_31.prefab_name ~= "" and arg_161_1.actors_[var_164_31.prefab_name] ~= nil then
						local var_164_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_31.prefab_name].transform, "story_v_out_121432", "121432040", "story_v_out_121432.awb")

						arg_161_1:RecordAudio("121432040", var_164_37)
						arg_161_1:RecordAudio("121432040", var_164_37)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_121432", "121432040", "story_v_out_121432.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_121432", "121432040", "story_v_out_121432.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_38 = math.max(var_164_29, arg_161_1.talkMaxDuration)

			if var_164_28 <= arg_161_1.time_ and arg_161_1.time_ < var_164_28 + var_164_38 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_28) / var_164_38

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_28 + var_164_38 and arg_161_1.time_ < var_164_28 + var_164_38 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
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
	Play121432041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 121432041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play121432042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["1074ui_story"]
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1074ui_story == nil then
				arg_165_1.var_.characterEffect1074ui_story = var_168_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 and not isNil(var_168_0) then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2

				if arg_165_1.var_.characterEffect1074ui_story and not isNil(var_168_0) then
					local var_168_4 = Mathf.Lerp(0, 0.5, var_168_3)

					arg_165_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1074ui_story.fillRatio = var_168_4
				end
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 and not isNil(var_168_0) and arg_165_1.var_.characterEffect1074ui_story then
				local var_168_5 = 0.5

				arg_165_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1074ui_story.fillRatio = var_168_5
			end

			local var_168_6 = 0
			local var_168_7 = 1.075

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

				local var_168_8 = arg_165_1:GetWordFromCfg(121432041)
				local var_168_9 = arg_165_1:FormatText(var_168_8.content)

				arg_165_1.text_.text = var_168_9

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 43
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
	Play121432042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 121432042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play121432043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 0.466666666666667

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				local var_172_2 = "play"
				local var_172_3 = "effect"

				arg_169_1:AudioAction(var_172_2, var_172_3, "se_story_121_04", "se_story_121_04_rock", "")
			end

			local var_172_4 = 0.466666666666667
			local var_172_5 = 0.533333333333333

			if var_172_4 < arg_169_1.time_ and arg_169_1.time_ <= var_172_4 + arg_172_0 then
				local var_172_6 = "stop"
				local var_172_7 = "music"

				arg_169_1:AudioAction(var_172_6, var_172_7, "se_story_121_04", "se_story_121_04_roar_loop", "")

				local var_172_8 = ""
				local var_172_9 = manager.audio:GetAudioName("se_story_121_04", "se_story_121_04_roar_loop")

				if var_172_9 ~= "" then
					if arg_169_1.bgmTxt_.text ~= var_172_9 and arg_169_1.bgmTxt_.text ~= "" then
						if arg_169_1.bgmTxt2_.text ~= "" then
							arg_169_1.bgmTxt_.text = arg_169_1.bgmTxt2_.text
						end

						arg_169_1.bgmTxt2_.text = var_172_9

						arg_169_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_169_1.bgmTxt_.text = var_172_9
						arg_169_1.bgmTxt2_.text = var_172_9
					end

					if arg_169_1.bgmTimer then
						arg_169_1.bgmTimer:Stop()

						arg_169_1.bgmTimer = nil
					end

					if arg_169_1.settingData.show_music_name == 1 then
						arg_169_1.musicController:SetSelectedState("show")
						arg_169_1.musicAnimator_:Play("open", 0, 0)

						if arg_169_1.settingData.music_time ~= 0 then
							arg_169_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_169_1.settingData.music_time), function()
								if arg_169_1 == nil or isNil(arg_169_1.bgmTxt_) then
									return
								end

								arg_169_1.musicController:SetSelectedState("hide")
								arg_169_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_172_10 = arg_169_1.actors_["1072ui_story"].transform
			local var_172_11 = 0

			if var_172_11 < arg_169_1.time_ and arg_169_1.time_ <= var_172_11 + arg_172_0 then
				arg_169_1.var_.moveOldPos1072ui_story = var_172_10.localPosition
			end

			local var_172_12 = 0.001

			if var_172_11 <= arg_169_1.time_ and arg_169_1.time_ < var_172_11 + var_172_12 then
				local var_172_13 = (arg_169_1.time_ - var_172_11) / var_172_12
				local var_172_14 = Vector3.New(0, 100, 0)

				var_172_10.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1072ui_story, var_172_14, var_172_13)

				local var_172_15 = manager.ui.mainCamera.transform.position - var_172_10.position

				var_172_10.forward = Vector3.New(var_172_15.x, var_172_15.y, var_172_15.z)

				local var_172_16 = var_172_10.localEulerAngles

				var_172_16.z = 0
				var_172_16.x = 0
				var_172_10.localEulerAngles = var_172_16
			end

			if arg_169_1.time_ >= var_172_11 + var_172_12 and arg_169_1.time_ < var_172_11 + var_172_12 + arg_172_0 then
				var_172_10.localPosition = Vector3.New(0, 100, 0)

				local var_172_17 = manager.ui.mainCamera.transform.position - var_172_10.position

				var_172_10.forward = Vector3.New(var_172_17.x, var_172_17.y, var_172_17.z)

				local var_172_18 = var_172_10.localEulerAngles

				var_172_18.z = 0
				var_172_18.x = 0
				var_172_10.localEulerAngles = var_172_18
			end

			local var_172_19 = arg_169_1.actors_["1074ui_story"].transform
			local var_172_20 = 0

			if var_172_20 < arg_169_1.time_ and arg_169_1.time_ <= var_172_20 + arg_172_0 then
				arg_169_1.var_.moveOldPos1074ui_story = var_172_19.localPosition
			end

			local var_172_21 = 0.001

			if var_172_20 <= arg_169_1.time_ and arg_169_1.time_ < var_172_20 + var_172_21 then
				local var_172_22 = (arg_169_1.time_ - var_172_20) / var_172_21
				local var_172_23 = Vector3.New(0, 100, 0)

				var_172_19.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1074ui_story, var_172_23, var_172_22)

				local var_172_24 = manager.ui.mainCamera.transform.position - var_172_19.position

				var_172_19.forward = Vector3.New(var_172_24.x, var_172_24.y, var_172_24.z)

				local var_172_25 = var_172_19.localEulerAngles

				var_172_25.z = 0
				var_172_25.x = 0
				var_172_19.localEulerAngles = var_172_25
			end

			if arg_169_1.time_ >= var_172_20 + var_172_21 and arg_169_1.time_ < var_172_20 + var_172_21 + arg_172_0 then
				var_172_19.localPosition = Vector3.New(0, 100, 0)

				local var_172_26 = manager.ui.mainCamera.transform.position - var_172_19.position

				var_172_19.forward = Vector3.New(var_172_26.x, var_172_26.y, var_172_26.z)

				local var_172_27 = var_172_19.localEulerAngles

				var_172_27.z = 0
				var_172_27.x = 0
				var_172_19.localEulerAngles = var_172_27
			end

			local var_172_28 = 0
			local var_172_29 = 1.125

			if var_172_28 < arg_169_1.time_ and arg_169_1.time_ <= var_172_28 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_30 = arg_169_1:GetWordFromCfg(121432042)
				local var_172_31 = arg_169_1:FormatText(var_172_30.content)

				arg_169_1.text_.text = var_172_31

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_32 = 45
				local var_172_33 = utf8.len(var_172_31)
				local var_172_34 = var_172_32 <= 0 and var_172_29 or var_172_29 * (var_172_33 / var_172_32)

				if var_172_34 > 0 and var_172_29 < var_172_34 then
					arg_169_1.talkMaxDuration = var_172_34

					if var_172_34 + var_172_28 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_34 + var_172_28
					end
				end

				arg_169_1.text_.text = var_172_31
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_35 = math.max(var_172_29, arg_169_1.talkMaxDuration)

			if var_172_28 <= arg_169_1.time_ and arg_169_1.time_ < var_172_28 + var_172_35 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_28) / var_172_35

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_28 + var_172_35 and arg_169_1.time_ < var_172_28 + var_172_35 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play121432043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 121432043
		arg_174_1.duration_ = 6.7

		local var_174_0 = {
			ja = 6.7,
			ko = 3.5,
			zh = 3.5
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play121432044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = arg_174_1.actors_["1074ui_story"].transform
			local var_177_1 = 0

			if var_177_1 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.var_.moveOldPos1074ui_story = var_177_0.localPosition
			end

			local var_177_2 = 0.001

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_2 then
				local var_177_3 = (arg_174_1.time_ - var_177_1) / var_177_2
				local var_177_4 = Vector3.New(0.7, -1.055, -6.12)

				var_177_0.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1074ui_story, var_177_4, var_177_3)

				local var_177_5 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_5.x, var_177_5.y, var_177_5.z)

				local var_177_6 = var_177_0.localEulerAngles

				var_177_6.z = 0
				var_177_6.x = 0
				var_177_0.localEulerAngles = var_177_6
			end

			if arg_174_1.time_ >= var_177_1 + var_177_2 and arg_174_1.time_ < var_177_1 + var_177_2 + arg_177_0 then
				var_177_0.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_177_7 = manager.ui.mainCamera.transform.position - var_177_0.position

				var_177_0.forward = Vector3.New(var_177_7.x, var_177_7.y, var_177_7.z)

				local var_177_8 = var_177_0.localEulerAngles

				var_177_8.z = 0
				var_177_8.x = 0
				var_177_0.localEulerAngles = var_177_8
			end

			local var_177_9 = arg_174_1.actors_["1074ui_story"]
			local var_177_10 = 0

			if var_177_10 < arg_174_1.time_ and arg_174_1.time_ <= var_177_10 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect1074ui_story == nil then
				arg_174_1.var_.characterEffect1074ui_story = var_177_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_11 = 0.200000002980232

			if var_177_10 <= arg_174_1.time_ and arg_174_1.time_ < var_177_10 + var_177_11 and not isNil(var_177_9) then
				local var_177_12 = (arg_174_1.time_ - var_177_10) / var_177_11

				if arg_174_1.var_.characterEffect1074ui_story and not isNil(var_177_9) then
					arg_174_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_174_1.time_ >= var_177_10 + var_177_11 and arg_174_1.time_ < var_177_10 + var_177_11 + arg_177_0 and not isNil(var_177_9) and arg_174_1.var_.characterEffect1074ui_story then
				arg_174_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_177_13 = 0

			if var_177_13 < arg_174_1.time_ and arg_174_1.time_ <= var_177_13 + arg_177_0 then
				arg_174_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_177_14 = 0

			if var_177_14 < arg_174_1.time_ and arg_174_1.time_ <= var_177_14 + arg_177_0 then
				arg_174_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_177_15 = arg_174_1.actors_["1072ui_story"].transform
			local var_177_16 = 0

			if var_177_16 < arg_174_1.time_ and arg_174_1.time_ <= var_177_16 + arg_177_0 then
				arg_174_1.var_.moveOldPos1072ui_story = var_177_15.localPosition
			end

			local var_177_17 = 0.001

			if var_177_16 <= arg_174_1.time_ and arg_174_1.time_ < var_177_16 + var_177_17 then
				local var_177_18 = (arg_174_1.time_ - var_177_16) / var_177_17
				local var_177_19 = Vector3.New(-0.7, -0.71, -6)

				var_177_15.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1072ui_story, var_177_19, var_177_18)

				local var_177_20 = manager.ui.mainCamera.transform.position - var_177_15.position

				var_177_15.forward = Vector3.New(var_177_20.x, var_177_20.y, var_177_20.z)

				local var_177_21 = var_177_15.localEulerAngles

				var_177_21.z = 0
				var_177_21.x = 0
				var_177_15.localEulerAngles = var_177_21
			end

			if arg_174_1.time_ >= var_177_16 + var_177_17 and arg_174_1.time_ < var_177_16 + var_177_17 + arg_177_0 then
				var_177_15.localPosition = Vector3.New(-0.7, -0.71, -6)

				local var_177_22 = manager.ui.mainCamera.transform.position - var_177_15.position

				var_177_15.forward = Vector3.New(var_177_22.x, var_177_22.y, var_177_22.z)

				local var_177_23 = var_177_15.localEulerAngles

				var_177_23.z = 0
				var_177_23.x = 0
				var_177_15.localEulerAngles = var_177_23
			end

			local var_177_24 = arg_174_1.actors_["1072ui_story"]
			local var_177_25 = 0

			if var_177_25 < arg_174_1.time_ and arg_174_1.time_ <= var_177_25 + arg_177_0 and not isNil(var_177_24) and arg_174_1.var_.characterEffect1072ui_story == nil then
				arg_174_1.var_.characterEffect1072ui_story = var_177_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_26 = 0.034000001847744

			if var_177_25 <= arg_174_1.time_ and arg_174_1.time_ < var_177_25 + var_177_26 and not isNil(var_177_24) then
				local var_177_27 = (arg_174_1.time_ - var_177_25) / var_177_26

				if arg_174_1.var_.characterEffect1072ui_story and not isNil(var_177_24) then
					local var_177_28 = Mathf.Lerp(0, 0.5, var_177_27)

					arg_174_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_174_1.var_.characterEffect1072ui_story.fillRatio = var_177_28
				end
			end

			if arg_174_1.time_ >= var_177_25 + var_177_26 and arg_174_1.time_ < var_177_25 + var_177_26 + arg_177_0 and not isNil(var_177_24) and arg_174_1.var_.characterEffect1072ui_story then
				local var_177_29 = 0.5

				arg_174_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_174_1.var_.characterEffect1072ui_story.fillRatio = var_177_29
			end

			local var_177_30 = 0
			local var_177_31 = 0.5

			if var_177_30 < arg_174_1.time_ and arg_174_1.time_ <= var_177_30 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				local var_177_32 = arg_174_1:FormatText(StoryNameCfg[410].name)

				arg_174_1.leftNameTxt_.text = var_177_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_33 = arg_174_1:GetWordFromCfg(121432043)
				local var_177_34 = arg_174_1:FormatText(var_177_33.content)

				arg_174_1.text_.text = var_177_34

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_35 = 20
				local var_177_36 = utf8.len(var_177_34)
				local var_177_37 = var_177_35 <= 0 and var_177_31 or var_177_31 * (var_177_36 / var_177_35)

				if var_177_37 > 0 and var_177_31 < var_177_37 then
					arg_174_1.talkMaxDuration = var_177_37

					if var_177_37 + var_177_30 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_37 + var_177_30
					end
				end

				arg_174_1.text_.text = var_177_34
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432043", "story_v_out_121432.awb") ~= 0 then
					local var_177_38 = manager.audio:GetVoiceLength("story_v_out_121432", "121432043", "story_v_out_121432.awb") / 1000

					if var_177_38 + var_177_30 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_38 + var_177_30
					end

					if var_177_33.prefab_name ~= "" and arg_174_1.actors_[var_177_33.prefab_name] ~= nil then
						local var_177_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_33.prefab_name].transform, "story_v_out_121432", "121432043", "story_v_out_121432.awb")

						arg_174_1:RecordAudio("121432043", var_177_39)
						arg_174_1:RecordAudio("121432043", var_177_39)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_121432", "121432043", "story_v_out_121432.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_121432", "121432043", "story_v_out_121432.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_40 = math.max(var_177_31, arg_174_1.talkMaxDuration)

			if var_177_30 <= arg_174_1.time_ and arg_174_1.time_ < var_177_30 + var_177_40 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_30) / var_177_40

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_30 + var_177_40 and arg_174_1.time_ < var_177_30 + var_177_40 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play121432044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 121432044
		arg_178_1.duration_ = 6.8

		local var_178_0 = {
			ja = 6.8,
			ko = 4.866,
			zh = 4.866
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play121432045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0

			if var_181_0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_0 + arg_181_0 then
				arg_178_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_181_1 = 0

			if var_181_1 < arg_178_1.time_ and arg_178_1.time_ <= var_181_1 + arg_181_0 then
				arg_178_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_181_2 = 0
			local var_181_3 = 0.55

			if var_181_2 < arg_178_1.time_ and arg_178_1.time_ <= var_181_2 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				local var_181_4 = arg_178_1:FormatText(StoryNameCfg[410].name)

				arg_178_1.leftNameTxt_.text = var_181_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_5 = arg_178_1:GetWordFromCfg(121432044)
				local var_181_6 = arg_178_1:FormatText(var_181_5.content)

				arg_178_1.text_.text = var_181_6

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_7 = 22
				local var_181_8 = utf8.len(var_181_6)
				local var_181_9 = var_181_7 <= 0 and var_181_3 or var_181_3 * (var_181_8 / var_181_7)

				if var_181_9 > 0 and var_181_3 < var_181_9 then
					arg_178_1.talkMaxDuration = var_181_9

					if var_181_9 + var_181_2 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_9 + var_181_2
					end
				end

				arg_178_1.text_.text = var_181_6
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432044", "story_v_out_121432.awb") ~= 0 then
					local var_181_10 = manager.audio:GetVoiceLength("story_v_out_121432", "121432044", "story_v_out_121432.awb") / 1000

					if var_181_10 + var_181_2 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_10 + var_181_2
					end

					if var_181_5.prefab_name ~= "" and arg_178_1.actors_[var_181_5.prefab_name] ~= nil then
						local var_181_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_5.prefab_name].transform, "story_v_out_121432", "121432044", "story_v_out_121432.awb")

						arg_178_1:RecordAudio("121432044", var_181_11)
						arg_178_1:RecordAudio("121432044", var_181_11)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_121432", "121432044", "story_v_out_121432.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_121432", "121432044", "story_v_out_121432.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_12 = math.max(var_181_3, arg_178_1.talkMaxDuration)

			if var_181_2 <= arg_178_1.time_ and arg_178_1.time_ < var_181_2 + var_181_12 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_2) / var_181_12

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_2 + var_181_12 and arg_178_1.time_ < var_181_2 + var_181_12 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play121432045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 121432045
		arg_182_1.duration_ = 2.93

		local var_182_0 = {
			ja = 2.933,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play121432046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = arg_182_1.actors_["1072ui_story"]
			local var_185_1 = 0

			if var_185_1 < arg_182_1.time_ and arg_182_1.time_ <= var_185_1 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1072ui_story == nil then
				arg_182_1.var_.characterEffect1072ui_story = var_185_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if var_185_1 <= arg_182_1.time_ and arg_182_1.time_ < var_185_1 + var_185_2 and not isNil(var_185_0) then
				local var_185_3 = (arg_182_1.time_ - var_185_1) / var_185_2

				if arg_182_1.var_.characterEffect1072ui_story and not isNil(var_185_0) then
					arg_182_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_182_1.time_ >= var_185_1 + var_185_2 and arg_182_1.time_ < var_185_1 + var_185_2 + arg_185_0 and not isNil(var_185_0) and arg_182_1.var_.characterEffect1072ui_story then
				arg_182_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_185_4 = 0

			if var_185_4 < arg_182_1.time_ and arg_182_1.time_ <= var_185_4 + arg_185_0 then
				arg_182_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action6_2")
			end

			local var_185_5 = 0

			if var_185_5 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 then
				arg_182_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_185_6 = arg_182_1.actors_["1074ui_story"]
			local var_185_7 = 0

			if var_185_7 < arg_182_1.time_ and arg_182_1.time_ <= var_185_7 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect1074ui_story == nil then
				arg_182_1.var_.characterEffect1074ui_story = var_185_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_8 = 0.200000002980232

			if var_185_7 <= arg_182_1.time_ and arg_182_1.time_ < var_185_7 + var_185_8 and not isNil(var_185_6) then
				local var_185_9 = (arg_182_1.time_ - var_185_7) / var_185_8

				if arg_182_1.var_.characterEffect1074ui_story and not isNil(var_185_6) then
					local var_185_10 = Mathf.Lerp(0, 0.5, var_185_9)

					arg_182_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1074ui_story.fillRatio = var_185_10
				end
			end

			if arg_182_1.time_ >= var_185_7 + var_185_8 and arg_182_1.time_ < var_185_7 + var_185_8 + arg_185_0 and not isNil(var_185_6) and arg_182_1.var_.characterEffect1074ui_story then
				local var_185_11 = 0.5

				arg_182_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1074ui_story.fillRatio = var_185_11
			end

			local var_185_12 = 0
			local var_185_13 = 0.175

			if var_185_12 < arg_182_1.time_ and arg_182_1.time_ <= var_185_12 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				local var_185_14 = arg_182_1:FormatText(StoryNameCfg[379].name)

				arg_182_1.leftNameTxt_.text = var_185_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_15 = arg_182_1:GetWordFromCfg(121432045)
				local var_185_16 = arg_182_1:FormatText(var_185_15.content)

				arg_182_1.text_.text = var_185_16

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_17 = 7
				local var_185_18 = utf8.len(var_185_16)
				local var_185_19 = var_185_17 <= 0 and var_185_13 or var_185_13 * (var_185_18 / var_185_17)

				if var_185_19 > 0 and var_185_13 < var_185_19 then
					arg_182_1.talkMaxDuration = var_185_19

					if var_185_19 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_19 + var_185_12
					end
				end

				arg_182_1.text_.text = var_185_16
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432045", "story_v_out_121432.awb") ~= 0 then
					local var_185_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432045", "story_v_out_121432.awb") / 1000

					if var_185_20 + var_185_12 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_20 + var_185_12
					end

					if var_185_15.prefab_name ~= "" and arg_182_1.actors_[var_185_15.prefab_name] ~= nil then
						local var_185_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_15.prefab_name].transform, "story_v_out_121432", "121432045", "story_v_out_121432.awb")

						arg_182_1:RecordAudio("121432045", var_185_21)
						arg_182_1:RecordAudio("121432045", var_185_21)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_121432", "121432045", "story_v_out_121432.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_121432", "121432045", "story_v_out_121432.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_22 = math.max(var_185_13, arg_182_1.talkMaxDuration)

			if var_185_12 <= arg_182_1.time_ and arg_182_1.time_ < var_185_12 + var_185_22 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_12) / var_185_22

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_12 + var_185_22 and arg_182_1.time_ < var_185_12 + var_185_22 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play121432046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 121432046
		arg_186_1.duration_ = 2

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play121432047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = arg_186_1.actors_["1074ui_story"]
			local var_189_1 = 0

			if var_189_1 < arg_186_1.time_ and arg_186_1.time_ <= var_189_1 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1074ui_story == nil then
				arg_186_1.var_.characterEffect1074ui_story = var_189_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_2 = 0.200000002980232

			if var_189_1 <= arg_186_1.time_ and arg_186_1.time_ < var_189_1 + var_189_2 and not isNil(var_189_0) then
				local var_189_3 = (arg_186_1.time_ - var_189_1) / var_189_2

				if arg_186_1.var_.characterEffect1074ui_story and not isNil(var_189_0) then
					arg_186_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= var_189_1 + var_189_2 and arg_186_1.time_ < var_189_1 + var_189_2 + arg_189_0 and not isNil(var_189_0) and arg_186_1.var_.characterEffect1074ui_story then
				arg_186_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_189_4 = 0

			if var_189_4 < arg_186_1.time_ and arg_186_1.time_ <= var_189_4 + arg_189_0 then
				arg_186_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_189_5 = 0

			if var_189_5 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_189_6 = arg_186_1.actors_["1072ui_story"]
			local var_189_7 = 0

			if var_189_7 < arg_186_1.time_ and arg_186_1.time_ <= var_189_7 + arg_189_0 and not isNil(var_189_6) and arg_186_1.var_.characterEffect1072ui_story == nil then
				arg_186_1.var_.characterEffect1072ui_story = var_189_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_8 = 0.200000002980232

			if var_189_7 <= arg_186_1.time_ and arg_186_1.time_ < var_189_7 + var_189_8 and not isNil(var_189_6) then
				local var_189_9 = (arg_186_1.time_ - var_189_7) / var_189_8

				if arg_186_1.var_.characterEffect1072ui_story and not isNil(var_189_6) then
					local var_189_10 = Mathf.Lerp(0, 0.5, var_189_9)

					arg_186_1.var_.characterEffect1072ui_story.fillFlat = true
					arg_186_1.var_.characterEffect1072ui_story.fillRatio = var_189_10
				end
			end

			if arg_186_1.time_ >= var_189_7 + var_189_8 and arg_186_1.time_ < var_189_7 + var_189_8 + arg_189_0 and not isNil(var_189_6) and arg_186_1.var_.characterEffect1072ui_story then
				local var_189_11 = 0.5

				arg_186_1.var_.characterEffect1072ui_story.fillFlat = true
				arg_186_1.var_.characterEffect1072ui_story.fillRatio = var_189_11
			end

			local var_189_12 = 0
			local var_189_13 = 0.05

			if var_189_12 < arg_186_1.time_ and arg_186_1.time_ <= var_189_12 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_14 = arg_186_1:FormatText(StoryNameCfg[410].name)

				arg_186_1.leftNameTxt_.text = var_189_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_15 = arg_186_1:GetWordFromCfg(121432046)
				local var_189_16 = arg_186_1:FormatText(var_189_15.content)

				arg_186_1.text_.text = var_189_16

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_17 = 2
				local var_189_18 = utf8.len(var_189_16)
				local var_189_19 = var_189_17 <= 0 and var_189_13 or var_189_13 * (var_189_18 / var_189_17)

				if var_189_19 > 0 and var_189_13 < var_189_19 then
					arg_186_1.talkMaxDuration = var_189_19

					if var_189_19 + var_189_12 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_19 + var_189_12
					end
				end

				arg_186_1.text_.text = var_189_16
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432046", "story_v_out_121432.awb") ~= 0 then
					local var_189_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432046", "story_v_out_121432.awb") / 1000

					if var_189_20 + var_189_12 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_20 + var_189_12
					end

					if var_189_15.prefab_name ~= "" and arg_186_1.actors_[var_189_15.prefab_name] ~= nil then
						local var_189_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_15.prefab_name].transform, "story_v_out_121432", "121432046", "story_v_out_121432.awb")

						arg_186_1:RecordAudio("121432046", var_189_21)
						arg_186_1:RecordAudio("121432046", var_189_21)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_121432", "121432046", "story_v_out_121432.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_121432", "121432046", "story_v_out_121432.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_22 = math.max(var_189_13, arg_186_1.talkMaxDuration)

			if var_189_12 <= arg_186_1.time_ and arg_186_1.time_ < var_189_12 + var_189_22 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_12) / var_189_22

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_12 + var_189_22 and arg_186_1.time_ < var_189_12 + var_189_22 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play121432047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 121432047
		arg_190_1.duration_ = 9.83

		local var_190_0 = {
			ja = 9.833,
			ko = 5.166,
			zh = 5.166
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play121432048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["1072ui_story"]
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1072ui_story == nil then
				arg_190_1.var_.characterEffect1072ui_story = var_193_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_2 = 0.200000002980232

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 and not isNil(var_193_0) then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2

				if arg_190_1.var_.characterEffect1072ui_story and not isNil(var_193_0) then
					arg_190_1.var_.characterEffect1072ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 and not isNil(var_193_0) and arg_190_1.var_.characterEffect1072ui_story then
				arg_190_1.var_.characterEffect1072ui_story.fillFlat = false
			end

			local var_193_4 = 0

			if var_193_4 < arg_190_1.time_ and arg_190_1.time_ <= var_193_4 + arg_193_0 then
				arg_190_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/story1072/story1072action/1072action5_1")
			end

			local var_193_5 = 0

			if var_193_5 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 then
				arg_190_1:PlayTimeline("1072ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_193_6 = arg_190_1.actors_["1074ui_story"]
			local var_193_7 = 0

			if var_193_7 < arg_190_1.time_ and arg_190_1.time_ <= var_193_7 + arg_193_0 and not isNil(var_193_6) and arg_190_1.var_.characterEffect1074ui_story == nil then
				arg_190_1.var_.characterEffect1074ui_story = var_193_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_8 = 0.200000002980232

			if var_193_7 <= arg_190_1.time_ and arg_190_1.time_ < var_193_7 + var_193_8 and not isNil(var_193_6) then
				local var_193_9 = (arg_190_1.time_ - var_193_7) / var_193_8

				if arg_190_1.var_.characterEffect1074ui_story and not isNil(var_193_6) then
					local var_193_10 = Mathf.Lerp(0, 0.5, var_193_9)

					arg_190_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1074ui_story.fillRatio = var_193_10
				end
			end

			if arg_190_1.time_ >= var_193_7 + var_193_8 and arg_190_1.time_ < var_193_7 + var_193_8 + arg_193_0 and not isNil(var_193_6) and arg_190_1.var_.characterEffect1074ui_story then
				local var_193_11 = 0.5

				arg_190_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1074ui_story.fillRatio = var_193_11
			end

			local var_193_12 = 0
			local var_193_13 = 0.525

			if var_193_12 < arg_190_1.time_ and arg_190_1.time_ <= var_193_12 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_14 = arg_190_1:FormatText(StoryNameCfg[379].name)

				arg_190_1.leftNameTxt_.text = var_193_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_15 = arg_190_1:GetWordFromCfg(121432047)
				local var_193_16 = arg_190_1:FormatText(var_193_15.content)

				arg_190_1.text_.text = var_193_16

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_17 = 21
				local var_193_18 = utf8.len(var_193_16)
				local var_193_19 = var_193_17 <= 0 and var_193_13 or var_193_13 * (var_193_18 / var_193_17)

				if var_193_19 > 0 and var_193_13 < var_193_19 then
					arg_190_1.talkMaxDuration = var_193_19

					if var_193_19 + var_193_12 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_19 + var_193_12
					end
				end

				arg_190_1.text_.text = var_193_16
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432047", "story_v_out_121432.awb") ~= 0 then
					local var_193_20 = manager.audio:GetVoiceLength("story_v_out_121432", "121432047", "story_v_out_121432.awb") / 1000

					if var_193_20 + var_193_12 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_20 + var_193_12
					end

					if var_193_15.prefab_name ~= "" and arg_190_1.actors_[var_193_15.prefab_name] ~= nil then
						local var_193_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_15.prefab_name].transform, "story_v_out_121432", "121432047", "story_v_out_121432.awb")

						arg_190_1:RecordAudio("121432047", var_193_21)
						arg_190_1:RecordAudio("121432047", var_193_21)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_121432", "121432047", "story_v_out_121432.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_121432", "121432047", "story_v_out_121432.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_22 = math.max(var_193_13, arg_190_1.talkMaxDuration)

			if var_193_12 <= arg_190_1.time_ and arg_190_1.time_ < var_193_12 + var_193_22 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_12) / var_193_22

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_12 + var_193_22 and arg_190_1.time_ < var_193_12 + var_193_22 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play121432048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 121432048
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play121432049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = arg_194_1.actors_["1072ui_story"].transform
			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1.var_.moveOldPos1072ui_story = var_197_0.localPosition
			end

			local var_197_2 = 0.001

			if var_197_1 <= arg_194_1.time_ and arg_194_1.time_ < var_197_1 + var_197_2 then
				local var_197_3 = (arg_194_1.time_ - var_197_1) / var_197_2
				local var_197_4 = Vector3.New(0, 100, 0)

				var_197_0.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1072ui_story, var_197_4, var_197_3)

				local var_197_5 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_5.x, var_197_5.y, var_197_5.z)

				local var_197_6 = var_197_0.localEulerAngles

				var_197_6.z = 0
				var_197_6.x = 0
				var_197_0.localEulerAngles = var_197_6
			end

			if arg_194_1.time_ >= var_197_1 + var_197_2 and arg_194_1.time_ < var_197_1 + var_197_2 + arg_197_0 then
				var_197_0.localPosition = Vector3.New(0, 100, 0)

				local var_197_7 = manager.ui.mainCamera.transform.position - var_197_0.position

				var_197_0.forward = Vector3.New(var_197_7.x, var_197_7.y, var_197_7.z)

				local var_197_8 = var_197_0.localEulerAngles

				var_197_8.z = 0
				var_197_8.x = 0
				var_197_0.localEulerAngles = var_197_8
			end

			local var_197_9 = arg_194_1.actors_["1074ui_story"].transform
			local var_197_10 = 0

			if var_197_10 < arg_194_1.time_ and arg_194_1.time_ <= var_197_10 + arg_197_0 then
				arg_194_1.var_.moveOldPos1074ui_story = var_197_9.localPosition
			end

			local var_197_11 = 0.001

			if var_197_10 <= arg_194_1.time_ and arg_194_1.time_ < var_197_10 + var_197_11 then
				local var_197_12 = (arg_194_1.time_ - var_197_10) / var_197_11
				local var_197_13 = Vector3.New(0, 100, 0)

				var_197_9.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1074ui_story, var_197_13, var_197_12)

				local var_197_14 = manager.ui.mainCamera.transform.position - var_197_9.position

				var_197_9.forward = Vector3.New(var_197_14.x, var_197_14.y, var_197_14.z)

				local var_197_15 = var_197_9.localEulerAngles

				var_197_15.z = 0
				var_197_15.x = 0
				var_197_9.localEulerAngles = var_197_15
			end

			if arg_194_1.time_ >= var_197_10 + var_197_11 and arg_194_1.time_ < var_197_10 + var_197_11 + arg_197_0 then
				var_197_9.localPosition = Vector3.New(0, 100, 0)

				local var_197_16 = manager.ui.mainCamera.transform.position - var_197_9.position

				var_197_9.forward = Vector3.New(var_197_16.x, var_197_16.y, var_197_16.z)

				local var_197_17 = var_197_9.localEulerAngles

				var_197_17.z = 0
				var_197_17.x = 0
				var_197_9.localEulerAngles = var_197_17
			end

			local var_197_18 = 0
			local var_197_19 = 1.025

			if var_197_18 < arg_194_1.time_ and arg_194_1.time_ <= var_197_18 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, false)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_20 = arg_194_1:GetWordFromCfg(121432048)
				local var_197_21 = arg_194_1:FormatText(var_197_20.content)

				arg_194_1.text_.text = var_197_21

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_22 = 41
				local var_197_23 = utf8.len(var_197_21)
				local var_197_24 = var_197_22 <= 0 and var_197_19 or var_197_19 * (var_197_23 / var_197_22)

				if var_197_24 > 0 and var_197_19 < var_197_24 then
					arg_194_1.talkMaxDuration = var_197_24

					if var_197_24 + var_197_18 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_24 + var_197_18
					end
				end

				arg_194_1.text_.text = var_197_21
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_25 = math.max(var_197_19, arg_194_1.talkMaxDuration)

			if var_197_18 <= arg_194_1.time_ and arg_194_1.time_ < var_197_18 + var_197_25 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_18) / var_197_25

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_18 + var_197_25 and arg_194_1.time_ < var_197_18 + var_197_25 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1072ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play121432049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 121432049
		arg_198_1.duration_ = 9.4

		local var_198_0 = {
			ja = 9.4,
			ko = 6.433,
			zh = 6.433
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play121432050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0
			local var_201_1 = 0.825

			if var_201_0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_0 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_2 = arg_198_1:FormatText(StoryNameCfg[379].name)

				arg_198_1.leftNameTxt_.text = var_201_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_3 = arg_198_1:GetWordFromCfg(121432049)
				local var_201_4 = arg_198_1:FormatText(var_201_3.content)

				arg_198_1.text_.text = var_201_4

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 33
				local var_201_6 = utf8.len(var_201_4)
				local var_201_7 = var_201_5 <= 0 and var_201_1 or var_201_1 * (var_201_6 / var_201_5)

				if var_201_7 > 0 and var_201_1 < var_201_7 then
					arg_198_1.talkMaxDuration = var_201_7

					if var_201_7 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_7 + var_201_0
					end
				end

				arg_198_1.text_.text = var_201_4
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432049", "story_v_out_121432.awb") ~= 0 then
					local var_201_8 = manager.audio:GetVoiceLength("story_v_out_121432", "121432049", "story_v_out_121432.awb") / 1000

					if var_201_8 + var_201_0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_8 + var_201_0
					end

					if var_201_3.prefab_name ~= "" and arg_198_1.actors_[var_201_3.prefab_name] ~= nil then
						local var_201_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_3.prefab_name].transform, "story_v_out_121432", "121432049", "story_v_out_121432.awb")

						arg_198_1:RecordAudio("121432049", var_201_9)
						arg_198_1:RecordAudio("121432049", var_201_9)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_121432", "121432049", "story_v_out_121432.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_121432", "121432049", "story_v_out_121432.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_10 = math.max(var_201_1, arg_198_1.talkMaxDuration)

			if var_201_0 <= arg_198_1.time_ and arg_198_1.time_ < var_201_0 + var_201_10 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_0) / var_201_10

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_0 + var_201_10 and arg_198_1.time_ < var_201_0 + var_201_10 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play121432050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 121432050
		arg_202_1.duration_ = 7.2

		local var_202_0 = {
			ja = 7.2,
			ko = 3.8,
			zh = 3.8
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
			arg_202_1.auto_ = false
		end

		function arg_202_1.playNext_(arg_204_0)
			arg_202_1.onStoryFinished_()
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0
			local var_205_1 = 0.475

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_2 = arg_202_1:FormatText(StoryNameCfg[379].name)

				arg_202_1.leftNameTxt_.text = var_205_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1072")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_3 = arg_202_1:GetWordFromCfg(121432050)
				local var_205_4 = arg_202_1:FormatText(var_205_3.content)

				arg_202_1.text_.text = var_205_4

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_5 = 19
				local var_205_6 = utf8.len(var_205_4)
				local var_205_7 = var_205_5 <= 0 and var_205_1 or var_205_1 * (var_205_6 / var_205_5)

				if var_205_7 > 0 and var_205_1 < var_205_7 then
					arg_202_1.talkMaxDuration = var_205_7

					if var_205_7 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_7 + var_205_0
					end
				end

				arg_202_1.text_.text = var_205_4
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_121432", "121432050", "story_v_out_121432.awb") ~= 0 then
					local var_205_8 = manager.audio:GetVoiceLength("story_v_out_121432", "121432050", "story_v_out_121432.awb") / 1000

					if var_205_8 + var_205_0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_8 + var_205_0
					end

					if var_205_3.prefab_name ~= "" and arg_202_1.actors_[var_205_3.prefab_name] ~= nil then
						local var_205_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_3.prefab_name].transform, "story_v_out_121432", "121432050", "story_v_out_121432.awb")

						arg_202_1:RecordAudio("121432050", var_205_9)
						arg_202_1:RecordAudio("121432050", var_205_9)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_121432", "121432050", "story_v_out_121432.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_121432", "121432050", "story_v_out_121432.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_10 = math.max(var_205_1, arg_202_1.talkMaxDuration)

			if var_205_0 <= arg_202_1.time_ and arg_202_1.time_ < var_205_0 + var_205_10 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_0) / var_205_10

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_0 + var_205_10 and arg_202_1.time_ < var_205_0 + var_205_10 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J03f"
	},
	voices = {
		"story_v_out_121432.awb"
	}
}
