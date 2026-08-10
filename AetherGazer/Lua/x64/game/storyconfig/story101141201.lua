return {
	Play114121001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 114121001
		arg_1_1.duration_ = 6.37

		local var_1_0 = {
			ja = 6.366,
			ko = 4.666,
			zh = 5.833,
			en = 5.333
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
				arg_1_0:Play114121002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "F04"

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
				local var_4_5 = arg_1_1.bgs_.F04

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
					if iter_4_0 ~= "F04" then
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

			local var_4_22 = "6045_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "6045_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "6045_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["6045_story"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos6045_story = var_4_27.localPosition

				local var_4_29 = GameObjectTools.GetOrAddComponent(var_4_27.gameObject, typeof(DynamicBoneHelper))

				if var_4_29 then
					var_4_29:EnableDynamicBone(false)
				end
			end

			local var_4_30 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_30 then
				local var_4_31 = (arg_1_1.time_ - var_4_28) / var_4_30
				local var_4_32 = Vector3.New(-0.7, -0.5, -6.3)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos6045_story, var_4_32, var_4_31)

				local var_4_33 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_33.x, var_4_33.y, var_4_33.z)

				local var_4_34 = var_4_27.localEulerAngles

				var_4_34.z = 0
				var_4_34.x = 0
				var_4_27.localEulerAngles = var_4_34
			end

			if arg_1_1.time_ >= var_4_28 + var_4_30 and arg_1_1.time_ < var_4_28 + var_4_30 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_4_35 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_35.x, var_4_35.y, var_4_35.z)

				local var_4_36 = var_4_27.localEulerAngles

				var_4_36.z = 0
				var_4_36.x = 0
				var_4_27.localEulerAngles = var_4_36

				local var_4_37 = GameObjectTools.GetOrAddComponent(var_4_27.gameObject, typeof(DynamicBoneHelper))

				if var_4_37 then
					var_4_37:EnableDynamicBone(true)
				end
			end

			local var_4_38 = 1.8

			if var_4_38 < arg_1_1.time_ and arg_1_1.time_ <= var_4_38 + arg_4_0 then
				arg_1_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action3_1")
			end

			local var_4_39 = 1.8

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_4_40 = arg_1_1.actors_["6045_story"]
			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect6045_story == nil then
				arg_1_1.var_.characterEffect6045_story = var_4_40:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_42 = 0.2

			if var_4_41 <= arg_1_1.time_ and arg_1_1.time_ < var_4_41 + var_4_42 and not isNil(var_4_40) then
				local var_4_43 = (arg_1_1.time_ - var_4_41) / var_4_42

				if arg_1_1.var_.characterEffect6045_story and not isNil(var_4_40) then
					arg_1_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_41 + var_4_42 and arg_1_1.time_ < var_4_41 + var_4_42 + arg_4_0 and not isNil(var_4_40) and arg_1_1.var_.characterEffect6045_story then
				arg_1_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_4_44 = "6046_story"

			if arg_1_1.actors_[var_4_44] == nil then
				local var_4_45 = Asset.Load("Char/" .. "6046_story")

				if not isNil(var_4_45) then
					local var_4_46 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_1_1.stage_.transform)

					var_4_46.name = var_4_44
					var_4_46.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_44] = var_4_46

					local var_4_47 = var_4_46:GetComponentInChildren(typeof(CharacterEffect))

					var_4_47.enabled = true

					local var_4_48 = GameObjectTools.GetOrAddComponent(var_4_46, typeof(DynamicBoneHelper))

					if var_4_48 then
						var_4_48:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_47.transform, false)

					arg_1_1.var_[var_4_44 .. "Animator"] = var_4_47.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_44 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_44 .. "LipSync"] = var_4_47.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_49 = arg_1_1.actors_["6046_story"].transform
			local var_4_50 = 1.8

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				arg_1_1.var_.moveOldPos6046_story = var_4_49.localPosition

				local var_4_51 = GameObjectTools.GetOrAddComponent(var_4_49.gameObject, typeof(DynamicBoneHelper))

				if var_4_51 then
					var_4_51:EnableDynamicBone(false)
				end
			end

			local var_4_52 = 0.001

			if var_4_50 <= arg_1_1.time_ and arg_1_1.time_ < var_4_50 + var_4_52 then
				local var_4_53 = (arg_1_1.time_ - var_4_50) / var_4_52
				local var_4_54 = Vector3.New(0.7, -0.5, -6.3)

				var_4_49.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos6046_story, var_4_54, var_4_53)

				local var_4_55 = manager.ui.mainCamera.transform.position - var_4_49.position

				var_4_49.forward = Vector3.New(var_4_55.x, var_4_55.y, var_4_55.z)

				local var_4_56 = var_4_49.localEulerAngles

				var_4_56.z = 0
				var_4_56.x = 0
				var_4_49.localEulerAngles = var_4_56
			end

			if arg_1_1.time_ >= var_4_50 + var_4_52 and arg_1_1.time_ < var_4_50 + var_4_52 + arg_4_0 then
				var_4_49.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_4_57 = manager.ui.mainCamera.transform.position - var_4_49.position

				var_4_49.forward = Vector3.New(var_4_57.x, var_4_57.y, var_4_57.z)

				local var_4_58 = var_4_49.localEulerAngles

				var_4_58.z = 0
				var_4_58.x = 0
				var_4_49.localEulerAngles = var_4_58

				local var_4_59 = GameObjectTools.GetOrAddComponent(var_4_49.gameObject, typeof(DynamicBoneHelper))

				if var_4_59 then
					var_4_59:EnableDynamicBone(true)
				end
			end

			local var_4_60 = 1.8

			if var_4_60 < arg_1_1.time_ and arg_1_1.time_ <= var_4_60 + arg_4_0 then
				arg_1_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action3_1")
			end

			local var_4_61 = 1.8

			if var_4_61 < arg_1_1.time_ and arg_1_1.time_ <= var_4_61 + arg_4_0 then
				arg_1_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_4_62 = arg_1_1.actors_["6045_story"]
			local var_4_63 = 1.8

			if var_4_63 < arg_1_1.time_ and arg_1_1.time_ <= var_4_63 + arg_4_0 and not isNil(var_4_62) and arg_1_1.var_.characterEffect6045_story == nil then
				arg_1_1.var_.characterEffect6045_story = var_4_62:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_64 = 0.2

			if var_4_63 <= arg_1_1.time_ and arg_1_1.time_ < var_4_63 + var_4_64 and not isNil(var_4_62) then
				local var_4_65 = (arg_1_1.time_ - var_4_63) / var_4_64

				if arg_1_1.var_.characterEffect6045_story and not isNil(var_4_62) then
					arg_1_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_63 + var_4_64 and arg_1_1.time_ < var_4_63 + var_4_64 + arg_4_0 and not isNil(var_4_62) and arg_1_1.var_.characterEffect6045_story then
				arg_1_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_4_66 = 0
			local var_4_67 = 1

			if var_4_66 < arg_1_1.time_ and arg_1_1.time_ <= var_4_66 + arg_4_0 then
				local var_4_68 = "play"
				local var_4_69 = "music"

				arg_1_1:AudioAction(var_4_68, var_4_69, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_70 = ""
				local var_4_71 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_71 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_71 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_71

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_71
						arg_1_1.bgmTxt2_.text = var_4_71
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

			local var_4_72 = 2
			local var_4_73 = 1.8

			if var_4_72 < arg_1_1.time_ and arg_1_1.time_ <= var_4_72 + arg_4_0 then
				local var_4_74 = "play"
				local var_4_75 = "music"

				arg_1_1:AudioAction(var_4_74, var_4_75, "bgm_activity_1_4_story_surface", "bgm_activity_1_4_story_surface", "bgm_activity_1_4_story_surface.awb")

				local var_4_76 = ""
				local var_4_77 = manager.audio:GetAudioName("bgm_activity_1_4_story_surface", "bgm_activity_1_4_story_surface")

				if var_4_77 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_77 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_77

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_77
						arg_1_1.bgmTxt2_.text = var_4_77
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

			local var_4_78 = 2
			local var_4_79 = 0.325

			if var_4_78 < arg_1_1.time_ and arg_1_1.time_ <= var_4_78 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_80 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_80:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_80:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_80:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_81 = arg_1_1:FormatText(StoryNameCfg[233].name)

				arg_1_1.leftNameTxt_.text = var_4_81

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_82 = arg_1_1:GetWordFromCfg(114121001)
				local var_4_83 = arg_1_1:FormatText(var_4_82.content)

				arg_1_1.text_.text = var_4_83

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_84 = 13
				local var_4_85 = utf8.len(var_4_83)
				local var_4_86 = var_4_84 <= 0 and var_4_79 or var_4_79 * (var_4_85 / var_4_84)

				if var_4_86 > 0 and var_4_79 < var_4_86 then
					arg_1_1.talkMaxDuration = var_4_86
					var_4_78 = var_4_78 + 0.3

					if var_4_86 + var_4_78 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_86 + var_4_78
					end
				end

				arg_1_1.text_.text = var_4_83
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121001", "story_v_out_114121.awb") ~= 0 then
					local var_4_87 = manager.audio:GetVoiceLength("story_v_out_114121", "114121001", "story_v_out_114121.awb") / 1000

					if var_4_87 + var_4_78 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_87 + var_4_78
					end

					if var_4_82.prefab_name ~= "" and arg_1_1.actors_[var_4_82.prefab_name] ~= nil then
						local var_4_88 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_82.prefab_name].transform, "story_v_out_114121", "114121001", "story_v_out_114121.awb")

						arg_1_1:RecordAudio("114121001", var_4_88)
						arg_1_1:RecordAudio("114121001", var_4_88)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_114121", "114121001", "story_v_out_114121.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_114121", "114121001", "story_v_out_114121.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_89 = var_4_78 + 0.3
			local var_4_90 = math.max(var_4_79, arg_1_1.talkMaxDuration)

			if var_4_89 <= arg_1_1.time_ and arg_1_1.time_ < var_4_89 + var_4_90 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_89) / var_4_90

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_89 + var_4_90 and arg_1_1.time_ < var_4_89 + var_4_90 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play114121002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 114121002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play114121003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["6046_story"].transform
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.var_.moveOldPos6046_story = var_12_0.localPosition

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0.gameObject, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end
			end

			local var_12_3 = 0.001

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_3 then
				local var_12_4 = (arg_9_1.time_ - var_12_1) / var_12_3
				local var_12_5 = Vector3.New(0, 100, 0)

				var_12_0.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos6046_story, var_12_5, var_12_4)

				local var_12_6 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_6.x, var_12_6.y, var_12_6.z)

				local var_12_7 = var_12_0.localEulerAngles

				var_12_7.z = 0
				var_12_7.x = 0
				var_12_0.localEulerAngles = var_12_7
			end

			if arg_9_1.time_ >= var_12_1 + var_12_3 and arg_9_1.time_ < var_12_1 + var_12_3 + arg_12_0 then
				var_12_0.localPosition = Vector3.New(0, 100, 0)

				local var_12_8 = manager.ui.mainCamera.transform.position - var_12_0.position

				var_12_0.forward = Vector3.New(var_12_8.x, var_12_8.y, var_12_8.z)

				local var_12_9 = var_12_0.localEulerAngles

				var_12_9.z = 0
				var_12_9.x = 0
				var_12_0.localEulerAngles = var_12_9

				local var_12_10 = GameObjectTools.GetOrAddComponent(var_12_0.gameObject, typeof(DynamicBoneHelper))

				if var_12_10 then
					var_12_10:EnableDynamicBone(true)
				end
			end

			local var_12_11 = arg_9_1.actors_["6045_story"].transform
			local var_12_12 = 0

			if var_12_12 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.var_.moveOldPos6045_story = var_12_11.localPosition

				local var_12_13 = GameObjectTools.GetOrAddComponent(var_12_11.gameObject, typeof(DynamicBoneHelper))

				if var_12_13 then
					var_12_13:EnableDynamicBone(false)
				end
			end

			local var_12_14 = 0.001

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_14 then
				local var_12_15 = (arg_9_1.time_ - var_12_12) / var_12_14
				local var_12_16 = Vector3.New(0, 100, 0)

				var_12_11.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos6045_story, var_12_16, var_12_15)

				local var_12_17 = manager.ui.mainCamera.transform.position - var_12_11.position

				var_12_11.forward = Vector3.New(var_12_17.x, var_12_17.y, var_12_17.z)

				local var_12_18 = var_12_11.localEulerAngles

				var_12_18.z = 0
				var_12_18.x = 0
				var_12_11.localEulerAngles = var_12_18
			end

			if arg_9_1.time_ >= var_12_12 + var_12_14 and arg_9_1.time_ < var_12_12 + var_12_14 + arg_12_0 then
				var_12_11.localPosition = Vector3.New(0, 100, 0)

				local var_12_19 = manager.ui.mainCamera.transform.position - var_12_11.position

				var_12_11.forward = Vector3.New(var_12_19.x, var_12_19.y, var_12_19.z)

				local var_12_20 = var_12_11.localEulerAngles

				var_12_20.z = 0
				var_12_20.x = 0
				var_12_11.localEulerAngles = var_12_20

				local var_12_21 = GameObjectTools.GetOrAddComponent(var_12_11.gameObject, typeof(DynamicBoneHelper))

				if var_12_21 then
					var_12_21:EnableDynamicBone(true)
				end
			end

			local var_12_22 = 0
			local var_12_23 = 1.475

			if var_12_22 < arg_9_1.time_ and arg_9_1.time_ <= var_12_22 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_24 = arg_9_1:GetWordFromCfg(114121002)
				local var_12_25 = arg_9_1:FormatText(var_12_24.content)

				arg_9_1.text_.text = var_12_25

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_26 = 59
				local var_12_27 = utf8.len(var_12_25)
				local var_12_28 = var_12_26 <= 0 and var_12_23 or var_12_23 * (var_12_27 / var_12_26)

				if var_12_28 > 0 and var_12_23 < var_12_28 then
					arg_9_1.talkMaxDuration = var_12_28

					if var_12_28 + var_12_22 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_28 + var_12_22
					end
				end

				arg_9_1.text_.text = var_12_25
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_29 = math.max(var_12_23, arg_9_1.talkMaxDuration)

			if var_12_22 <= arg_9_1.time_ and arg_9_1.time_ < var_12_22 + var_12_29 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_22) / var_12_29

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_22 + var_12_29 and arg_9_1.time_ < var_12_22 + var_12_29 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play114121003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 114121003
		arg_13_1.duration_ = 8.1

		local var_13_0 = {
			ja = 6.866,
			ko = 6.466,
			zh = 6.866,
			en = 8.1
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
				arg_13_0:Play114121004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = "1042ui_story"

			if arg_13_1.actors_[var_16_0] == nil then
				local var_16_1 = Asset.Load("Char/" .. "1042ui_story")

				if not isNil(var_16_1) then
					local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_13_1.stage_.transform)

					var_16_2.name = var_16_0
					var_16_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_13_1.actors_[var_16_0] = var_16_2

					local var_16_3 = var_16_2:GetComponentInChildren(typeof(CharacterEffect))

					var_16_3.enabled = true

					local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_2, typeof(DynamicBoneHelper))

					if var_16_4 then
						var_16_4:EnableDynamicBone(false)
					end

					arg_13_1:ShowWeapon(var_16_3.transform, false)

					arg_13_1.var_[var_16_0 .. "Animator"] = var_16_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_13_1.var_[var_16_0 .. "Animator"].applyRootMotion = true
					arg_13_1.var_[var_16_0 .. "LipSync"] = var_16_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_16_5 = arg_13_1.actors_["1042ui_story"].transform
			local var_16_6 = 0

			if var_16_6 < arg_13_1.time_ and arg_13_1.time_ <= var_16_6 + arg_16_0 then
				arg_13_1.var_.moveOldPos1042ui_story = var_16_5.localPosition
			end

			local var_16_7 = 0.001

			if var_16_6 <= arg_13_1.time_ and arg_13_1.time_ < var_16_6 + var_16_7 then
				local var_16_8 = (arg_13_1.time_ - var_16_6) / var_16_7
				local var_16_9 = Vector3.New(0, -1.06, -6.2)

				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1042ui_story, var_16_9, var_16_8)

				local var_16_10 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_10.x, var_16_10.y, var_16_10.z)

				local var_16_11 = var_16_5.localEulerAngles

				var_16_11.z = 0
				var_16_11.x = 0
				var_16_5.localEulerAngles = var_16_11
			end

			if arg_13_1.time_ >= var_16_6 + var_16_7 and arg_13_1.time_ < var_16_6 + var_16_7 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_16_12 = manager.ui.mainCamera.transform.position - var_16_5.position

				var_16_5.forward = Vector3.New(var_16_12.x, var_16_12.y, var_16_12.z)

				local var_16_13 = var_16_5.localEulerAngles

				var_16_13.z = 0
				var_16_13.x = 0
				var_16_5.localEulerAngles = var_16_13
			end

			local var_16_14 = 0

			if var_16_14 < arg_13_1.time_ and arg_13_1.time_ <= var_16_14 + arg_16_0 then
				arg_13_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_16_15 = 0

			if var_16_15 < arg_13_1.time_ and arg_13_1.time_ <= var_16_15 + arg_16_0 then
				arg_13_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_16_16 = arg_13_1.actors_["1042ui_story"]
			local var_16_17 = 0

			if var_16_17 < arg_13_1.time_ and arg_13_1.time_ <= var_16_17 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect1042ui_story == nil then
				arg_13_1.var_.characterEffect1042ui_story = var_16_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_18 = 0.2

			if var_16_17 <= arg_13_1.time_ and arg_13_1.time_ < var_16_17 + var_16_18 and not isNil(var_16_16) then
				local var_16_19 = (arg_13_1.time_ - var_16_17) / var_16_18

				if arg_13_1.var_.characterEffect1042ui_story and not isNil(var_16_16) then
					arg_13_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_17 + var_16_18 and arg_13_1.time_ < var_16_17 + var_16_18 + arg_16_0 and not isNil(var_16_16) and arg_13_1.var_.characterEffect1042ui_story then
				arg_13_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_16_20 = 0
			local var_16_21 = 0.575

			if var_16_20 < arg_13_1.time_ and arg_13_1.time_ <= var_16_20 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_22 = arg_13_1:FormatText(StoryNameCfg[205].name)

				arg_13_1.leftNameTxt_.text = var_16_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_23 = arg_13_1:GetWordFromCfg(114121003)
				local var_16_24 = arg_13_1:FormatText(var_16_23.content)

				arg_13_1.text_.text = var_16_24

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_25 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121003", "story_v_out_114121.awb") ~= 0 then
					local var_16_28 = manager.audio:GetVoiceLength("story_v_out_114121", "114121003", "story_v_out_114121.awb") / 1000

					if var_16_28 + var_16_20 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_28 + var_16_20
					end

					if var_16_23.prefab_name ~= "" and arg_13_1.actors_[var_16_23.prefab_name] ~= nil then
						local var_16_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_23.prefab_name].transform, "story_v_out_114121", "114121003", "story_v_out_114121.awb")

						arg_13_1:RecordAudio("114121003", var_16_29)
						arg_13_1:RecordAudio("114121003", var_16_29)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_114121", "114121003", "story_v_out_114121.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_114121", "114121003", "story_v_out_114121.awb")
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
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play114121004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 114121004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play114121005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["1042ui_story"].transform
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.var_.moveOldPos1042ui_story = var_20_0.localPosition
			end

			local var_20_2 = 0.001

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2
				local var_20_4 = Vector3.New(0, 100, 0)

				var_20_0.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1042ui_story, var_20_4, var_20_3)

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

			local var_20_9 = 0
			local var_20_10 = 1.375

			if var_20_9 < arg_17_1.time_ and arg_17_1.time_ <= var_20_9 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_11 = arg_17_1:GetWordFromCfg(114121004)
				local var_20_12 = arg_17_1:FormatText(var_20_11.content)

				arg_17_1.text_.text = var_20_12

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 55
				local var_20_14 = utf8.len(var_20_12)
				local var_20_15 = var_20_13 <= 0 and var_20_10 or var_20_10 * (var_20_14 / var_20_13)

				if var_20_15 > 0 and var_20_10 < var_20_15 then
					arg_17_1.talkMaxDuration = var_20_15

					if var_20_15 + var_20_9 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_15 + var_20_9
					end
				end

				arg_17_1.text_.text = var_20_12
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_10, arg_17_1.talkMaxDuration)

			if var_20_9 <= arg_17_1.time_ and arg_17_1.time_ < var_20_9 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_9) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_9 + var_20_16 and arg_17_1.time_ < var_20_9 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play114121005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 114121005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play114121006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.7

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_2 = arg_21_1:GetWordFromCfg(114121005)
				local var_24_3 = arg_21_1:FormatText(var_24_2.content)

				arg_21_1.text_.text = var_24_3

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 28
				local var_24_5 = utf8.len(var_24_3)
				local var_24_6 = var_24_4 <= 0 and var_24_1 or var_24_1 * (var_24_5 / var_24_4)

				if var_24_6 > 0 and var_24_1 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_0
					end
				end

				arg_21_1.text_.text = var_24_3
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_1, arg_21_1.talkMaxDuration)

			if var_24_0 <= arg_21_1.time_ and arg_21_1.time_ < var_24_0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_0 + var_24_7 and arg_21_1.time_ < var_24_0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play114121006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 114121006
		arg_25_1.duration_ = 2.6

		local var_25_0 = {
			ja = 2.6,
			ko = 1.999999999999,
			zh = 2.266,
			en = 1.999999999999
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
				arg_25_0:Play114121007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = arg_25_1.actors_["1042ui_story"].transform
			local var_28_1 = 0

			if var_28_1 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.var_.moveOldPos1042ui_story = var_28_0.localPosition
			end

			local var_28_2 = 0.001

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_2 then
				local var_28_3 = (arg_25_1.time_ - var_28_1) / var_28_2
				local var_28_4 = Vector3.New(0, -1.06, -6.2)

				var_28_0.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1042ui_story, var_28_4, var_28_3)

				local var_28_5 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_5.x, var_28_5.y, var_28_5.z)

				local var_28_6 = var_28_0.localEulerAngles

				var_28_6.z = 0
				var_28_6.x = 0
				var_28_0.localEulerAngles = var_28_6
			end

			if arg_25_1.time_ >= var_28_1 + var_28_2 and arg_25_1.time_ < var_28_1 + var_28_2 + arg_28_0 then
				var_28_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_28_7 = manager.ui.mainCamera.transform.position - var_28_0.position

				var_28_0.forward = Vector3.New(var_28_7.x, var_28_7.y, var_28_7.z)

				local var_28_8 = var_28_0.localEulerAngles

				var_28_8.z = 0
				var_28_8.x = 0
				var_28_0.localEulerAngles = var_28_8
			end

			local var_28_9 = 0

			if var_28_9 < arg_25_1.time_ and arg_25_1.time_ <= var_28_9 + arg_28_0 then
				arg_25_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			local var_28_10 = 0

			if var_28_10 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_28_11 = arg_25_1.actors_["1042ui_story"]
			local var_28_12 = 0

			if var_28_12 < arg_25_1.time_ and arg_25_1.time_ <= var_28_12 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.characterEffect1042ui_story == nil then
				arg_25_1.var_.characterEffect1042ui_story = var_28_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_13 = 0.2

			if var_28_12 <= arg_25_1.time_ and arg_25_1.time_ < var_28_12 + var_28_13 and not isNil(var_28_11) then
				local var_28_14 = (arg_25_1.time_ - var_28_12) / var_28_13

				if arg_25_1.var_.characterEffect1042ui_story and not isNil(var_28_11) then
					arg_25_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= var_28_12 + var_28_13 and arg_25_1.time_ < var_28_12 + var_28_13 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.characterEffect1042ui_story then
				arg_25_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_28_15 = 0
			local var_28_16 = 0.225

			if var_28_15 < arg_25_1.time_ and arg_25_1.time_ <= var_28_15 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_17 = arg_25_1:FormatText(StoryNameCfg[205].name)

				arg_25_1.leftNameTxt_.text = var_28_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_18 = arg_25_1:GetWordFromCfg(114121006)
				local var_28_19 = arg_25_1:FormatText(var_28_18.content)

				arg_25_1.text_.text = var_28_19

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_20 = 9
				local var_28_21 = utf8.len(var_28_19)
				local var_28_22 = var_28_20 <= 0 and var_28_16 or var_28_16 * (var_28_21 / var_28_20)

				if var_28_22 > 0 and var_28_16 < var_28_22 then
					arg_25_1.talkMaxDuration = var_28_22

					if var_28_22 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_22 + var_28_15
					end
				end

				arg_25_1.text_.text = var_28_19
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121006", "story_v_out_114121.awb") ~= 0 then
					local var_28_23 = manager.audio:GetVoiceLength("story_v_out_114121", "114121006", "story_v_out_114121.awb") / 1000

					if var_28_23 + var_28_15 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_23 + var_28_15
					end

					if var_28_18.prefab_name ~= "" and arg_25_1.actors_[var_28_18.prefab_name] ~= nil then
						local var_28_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_18.prefab_name].transform, "story_v_out_114121", "114121006", "story_v_out_114121.awb")

						arg_25_1:RecordAudio("114121006", var_28_24)
						arg_25_1:RecordAudio("114121006", var_28_24)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_114121", "114121006", "story_v_out_114121.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_114121", "114121006", "story_v_out_114121.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_25 = math.max(var_28_16, arg_25_1.talkMaxDuration)

			if var_28_15 <= arg_25_1.time_ and arg_25_1.time_ < var_28_15 + var_28_25 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_15) / var_28_25

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_15 + var_28_25 and arg_25_1.time_ < var_28_15 + var_28_25 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play114121007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 114121007
		arg_29_1.duration_ = 7.43

		local var_29_0 = {
			ja = 7.433,
			ko = 4.9,
			zh = 7.1,
			en = 5.566
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
				arg_29_0:Play114121008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["1042ui_story"]
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1042ui_story == nil then
				arg_29_1.var_.characterEffect1042ui_story = var_32_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.2

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 and not isNil(var_32_0) then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2

				if arg_29_1.var_.characterEffect1042ui_story and not isNil(var_32_0) then
					local var_32_4 = Mathf.Lerp(0, 0.5, var_32_3)

					arg_29_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1042ui_story.fillRatio = var_32_4
				end
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 and not isNil(var_32_0) and arg_29_1.var_.characterEffect1042ui_story then
				local var_32_5 = 0.5

				arg_29_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1042ui_story.fillRatio = var_32_5
			end

			local var_32_6 = 0
			local var_32_7 = 0.6

			if var_32_6 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_8 = arg_29_1:FormatText(StoryNameCfg[215].name)

				arg_29_1.leftNameTxt_.text = var_32_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, true)
				arg_29_1.iconController_:SetSelectedState("hero")

				arg_29_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_29_1.callingController_:SetSelectedState("normal")

				arg_29_1.keyicon_.color = Color.New(1, 1, 1)
				arg_29_1.icon_.color = Color.New(1, 1, 1)

				local var_32_9 = arg_29_1:GetWordFromCfg(114121007)
				local var_32_10 = arg_29_1:FormatText(var_32_9.content)

				arg_29_1.text_.text = var_32_10

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 24
				local var_32_12 = utf8.len(var_32_10)
				local var_32_13 = var_32_11 <= 0 and var_32_7 or var_32_7 * (var_32_12 / var_32_11)

				if var_32_13 > 0 and var_32_7 < var_32_13 then
					arg_29_1.talkMaxDuration = var_32_13

					if var_32_13 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_13 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_10
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121007", "story_v_out_114121.awb") ~= 0 then
					local var_32_14 = manager.audio:GetVoiceLength("story_v_out_114121", "114121007", "story_v_out_114121.awb") / 1000

					if var_32_14 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_14 + var_32_6
					end

					if var_32_9.prefab_name ~= "" and arg_29_1.actors_[var_32_9.prefab_name] ~= nil then
						local var_32_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_9.prefab_name].transform, "story_v_out_114121", "114121007", "story_v_out_114121.awb")

						arg_29_1:RecordAudio("114121007", var_32_15)
						arg_29_1:RecordAudio("114121007", var_32_15)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_114121", "114121007", "story_v_out_114121.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_114121", "114121007", "story_v_out_114121.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_16 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_16 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_16

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_16 and arg_29_1.time_ < var_32_6 + var_32_16 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play114121008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 114121008
		arg_33_1.duration_ = 6.3

		local var_33_0 = {
			ja = 2.633,
			ko = 4.1,
			zh = 6.3,
			en = 4.1
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
				arg_33_0:Play114121009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_36_2 = arg_33_1.actors_["1042ui_story"]
			local var_36_3 = 0

			if var_36_3 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1042ui_story == nil then
				arg_33_1.var_.characterEffect1042ui_story = var_36_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_4 = 0.2

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_4 and not isNil(var_36_2) then
				local var_36_5 = (arg_33_1.time_ - var_36_3) / var_36_4

				if arg_33_1.var_.characterEffect1042ui_story and not isNil(var_36_2) then
					arg_33_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= var_36_3 + var_36_4 and arg_33_1.time_ < var_36_3 + var_36_4 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1042ui_story then
				arg_33_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_36_6 = 0
			local var_36_7 = 0.4

			if var_36_6 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_8 = arg_33_1:FormatText(StoryNameCfg[205].name)

				arg_33_1.leftNameTxt_.text = var_36_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_9 = arg_33_1:GetWordFromCfg(114121008)
				local var_36_10 = arg_33_1:FormatText(var_36_9.content)

				arg_33_1.text_.text = var_36_10

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 16
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

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121008", "story_v_out_114121.awb") ~= 0 then
					local var_36_14 = manager.audio:GetVoiceLength("story_v_out_114121", "114121008", "story_v_out_114121.awb") / 1000

					if var_36_14 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_14 + var_36_6
					end

					if var_36_9.prefab_name ~= "" and arg_33_1.actors_[var_36_9.prefab_name] ~= nil then
						local var_36_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_9.prefab_name].transform, "story_v_out_114121", "114121008", "story_v_out_114121.awb")

						arg_33_1:RecordAudio("114121008", var_36_15)
						arg_33_1:RecordAudio("114121008", var_36_15)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_114121", "114121008", "story_v_out_114121.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_114121", "114121008", "story_v_out_114121.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_16 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_16 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_16

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_16 and arg_33_1.time_ < var_36_6 + var_36_16 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play114121009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 114121009
		arg_37_1.duration_ = 4.53

		local var_37_0 = {
			ja = 2.6,
			ko = 3.3,
			zh = 4.533,
			en = 3
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
				arg_37_0:Play114121010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = arg_37_1.actors_["1042ui_story"]
			local var_40_1 = 0

			if var_40_1 < arg_37_1.time_ and arg_37_1.time_ <= var_40_1 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1042ui_story == nil then
				arg_37_1.var_.characterEffect1042ui_story = var_40_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.2

			if var_40_1 <= arg_37_1.time_ and arg_37_1.time_ < var_40_1 + var_40_2 and not isNil(var_40_0) then
				local var_40_3 = (arg_37_1.time_ - var_40_1) / var_40_2

				if arg_37_1.var_.characterEffect1042ui_story and not isNil(var_40_0) then
					local var_40_4 = Mathf.Lerp(0, 0.5, var_40_3)

					arg_37_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_37_1.var_.characterEffect1042ui_story.fillRatio = var_40_4
				end
			end

			if arg_37_1.time_ >= var_40_1 + var_40_2 and arg_37_1.time_ < var_40_1 + var_40_2 + arg_40_0 and not isNil(var_40_0) and arg_37_1.var_.characterEffect1042ui_story then
				local var_40_5 = 0.5

				arg_37_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_37_1.var_.characterEffect1042ui_story.fillRatio = var_40_5
			end

			local var_40_6 = 0
			local var_40_7 = 0.425

			if var_40_6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_8 = arg_37_1:FormatText(StoryNameCfg[214].name)

				arg_37_1.leftNameTxt_.text = var_40_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, true)
				arg_37_1.iconController_:SetSelectedState("hero")

				arg_37_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6046")

				arg_37_1.callingController_:SetSelectedState("normal")

				arg_37_1.keyicon_.color = Color.New(1, 1, 1)
				arg_37_1.icon_.color = Color.New(1, 1, 1)

				local var_40_9 = arg_37_1:GetWordFromCfg(114121009)
				local var_40_10 = arg_37_1:FormatText(var_40_9.content)

				arg_37_1.text_.text = var_40_10

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121009", "story_v_out_114121.awb") ~= 0 then
					local var_40_14 = manager.audio:GetVoiceLength("story_v_out_114121", "114121009", "story_v_out_114121.awb") / 1000

					if var_40_14 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_14 + var_40_6
					end

					if var_40_9.prefab_name ~= "" and arg_37_1.actors_[var_40_9.prefab_name] ~= nil then
						local var_40_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_9.prefab_name].transform, "story_v_out_114121", "114121009", "story_v_out_114121.awb")

						arg_37_1:RecordAudio("114121009", var_40_15)
						arg_37_1:RecordAudio("114121009", var_40_15)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_114121", "114121009", "story_v_out_114121.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_114121", "114121009", "story_v_out_114121.awb")
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
	Play114121010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 114121010
		arg_41_1.duration_ = 7.13

		local var_41_0 = {
			ja = 6.3,
			ko = 5.633,
			zh = 7.133,
			en = 5.266
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
				arg_41_0:Play114121011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0

			if var_44_0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action442")
			end

			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 then
				arg_41_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_44_2 = arg_41_1.actors_["1042ui_story"]
			local var_44_3 = 0

			if var_44_3 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1042ui_story == nil then
				arg_41_1.var_.characterEffect1042ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_4 = 0.2

			if var_44_3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_3 + var_44_4 and not isNil(var_44_2) then
				local var_44_5 = (arg_41_1.time_ - var_44_3) / var_44_4

				if arg_41_1.var_.characterEffect1042ui_story and not isNil(var_44_2) then
					arg_41_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= var_44_3 + var_44_4 and arg_41_1.time_ < var_44_3 + var_44_4 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1042ui_story then
				arg_41_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_44_6 = 0
			local var_44_7 = 0.65

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[205].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_9 = arg_41_1:GetWordFromCfg(114121010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 26
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

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121010", "story_v_out_114121.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_114121", "114121010", "story_v_out_114121.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_out_114121", "114121010", "story_v_out_114121.awb")

						arg_41_1:RecordAudio("114121010", var_44_15)
						arg_41_1:RecordAudio("114121010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_114121", "114121010", "story_v_out_114121.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_114121", "114121010", "story_v_out_114121.awb")
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
	Play114121011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 114121011
		arg_45_1.duration_ = 5.37

		local var_45_0 = {
			ja = 5.366,
			ko = 3.866,
			zh = 4.666,
			en = 3.366
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
				arg_45_0:Play114121012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_48_1 = 0
			local var_48_2 = 0.475

			if var_48_1 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_3 = arg_45_1:FormatText(StoryNameCfg[205].name)

				arg_45_1.leftNameTxt_.text = var_48_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_4 = arg_45_1:GetWordFromCfg(114121011)
				local var_48_5 = arg_45_1:FormatText(var_48_4.content)

				arg_45_1.text_.text = var_48_5

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_6 = 19
				local var_48_7 = utf8.len(var_48_5)
				local var_48_8 = var_48_6 <= 0 and var_48_2 or var_48_2 * (var_48_7 / var_48_6)

				if var_48_8 > 0 and var_48_2 < var_48_8 then
					arg_45_1.talkMaxDuration = var_48_8

					if var_48_8 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_5
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121011", "story_v_out_114121.awb") ~= 0 then
					local var_48_9 = manager.audio:GetVoiceLength("story_v_out_114121", "114121011", "story_v_out_114121.awb") / 1000

					if var_48_9 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_1
					end

					if var_48_4.prefab_name ~= "" and arg_45_1.actors_[var_48_4.prefab_name] ~= nil then
						local var_48_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_4.prefab_name].transform, "story_v_out_114121", "114121011", "story_v_out_114121.awb")

						arg_45_1:RecordAudio("114121011", var_48_10)
						arg_45_1:RecordAudio("114121011", var_48_10)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_114121", "114121011", "story_v_out_114121.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_114121", "114121011", "story_v_out_114121.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_11 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_11 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_11

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_11 and arg_45_1.time_ < var_48_1 + var_48_11 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play114121012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 114121012
		arg_49_1.duration_ = 4.23

		local var_49_0 = {
			ja = 4.233,
			ko = 2.1,
			zh = 3.533,
			en = 2.366
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
				arg_49_0:Play114121013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["1042ui_story"].transform
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 then
				arg_49_1.var_.moveOldPos1042ui_story = var_52_0.localPosition
			end

			local var_52_2 = 0.001

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2
				local var_52_4 = Vector3.New(0, 100, 0)

				var_52_0.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos1042ui_story, var_52_4, var_52_3)

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

			local var_52_9 = arg_49_1.actors_["6045_story"].transform
			local var_52_10 = 0

			if var_52_10 < arg_49_1.time_ and arg_49_1.time_ <= var_52_10 + arg_52_0 then
				arg_49_1.var_.moveOldPos6045_story = var_52_9.localPosition

				local var_52_11 = GameObjectTools.GetOrAddComponent(var_52_9.gameObject, typeof(DynamicBoneHelper))

				if var_52_11 then
					var_52_11:EnableDynamicBone(false)
				end
			end

			local var_52_12 = 0.001

			if var_52_10 <= arg_49_1.time_ and arg_49_1.time_ < var_52_10 + var_52_12 then
				local var_52_13 = (arg_49_1.time_ - var_52_10) / var_52_12
				local var_52_14 = Vector3.New(-0.7, -0.5, -6.3)

				var_52_9.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos6045_story, var_52_14, var_52_13)

				local var_52_15 = manager.ui.mainCamera.transform.position - var_52_9.position

				var_52_9.forward = Vector3.New(var_52_15.x, var_52_15.y, var_52_15.z)

				local var_52_16 = var_52_9.localEulerAngles

				var_52_16.z = 0
				var_52_16.x = 0
				var_52_9.localEulerAngles = var_52_16
			end

			if arg_49_1.time_ >= var_52_10 + var_52_12 and arg_49_1.time_ < var_52_10 + var_52_12 + arg_52_0 then
				var_52_9.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_52_17 = manager.ui.mainCamera.transform.position - var_52_9.position

				var_52_9.forward = Vector3.New(var_52_17.x, var_52_17.y, var_52_17.z)

				local var_52_18 = var_52_9.localEulerAngles

				var_52_18.z = 0
				var_52_18.x = 0
				var_52_9.localEulerAngles = var_52_18

				local var_52_19 = GameObjectTools.GetOrAddComponent(var_52_9.gameObject, typeof(DynamicBoneHelper))

				if var_52_19 then
					var_52_19:EnableDynamicBone(true)
				end
			end

			local var_52_20 = 0

			if var_52_20 < arg_49_1.time_ and arg_49_1.time_ <= var_52_20 + arg_52_0 then
				arg_49_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_1")
			end

			local var_52_21 = 0

			if var_52_21 < arg_49_1.time_ and arg_49_1.time_ <= var_52_21 + arg_52_0 then
				arg_49_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_52_22 = arg_49_1.actors_["6045_story"]
			local var_52_23 = 0

			if var_52_23 < arg_49_1.time_ and arg_49_1.time_ <= var_52_23 + arg_52_0 and not isNil(var_52_22) and arg_49_1.var_.characterEffect6045_story == nil then
				arg_49_1.var_.characterEffect6045_story = var_52_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_24 = 0.2

			if var_52_23 <= arg_49_1.time_ and arg_49_1.time_ < var_52_23 + var_52_24 and not isNil(var_52_22) then
				local var_52_25 = (arg_49_1.time_ - var_52_23) / var_52_24

				if arg_49_1.var_.characterEffect6045_story and not isNil(var_52_22) then
					arg_49_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_23 + var_52_24 and arg_49_1.time_ < var_52_23 + var_52_24 + arg_52_0 and not isNil(var_52_22) and arg_49_1.var_.characterEffect6045_story then
				arg_49_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_52_26 = arg_49_1.actors_["6046_story"].transform
			local var_52_27 = 0

			if var_52_27 < arg_49_1.time_ and arg_49_1.time_ <= var_52_27 + arg_52_0 then
				arg_49_1.var_.moveOldPos6046_story = var_52_26.localPosition

				local var_52_28 = GameObjectTools.GetOrAddComponent(var_52_26.gameObject, typeof(DynamicBoneHelper))

				if var_52_28 then
					var_52_28:EnableDynamicBone(false)
				end
			end

			local var_52_29 = 0.001

			if var_52_27 <= arg_49_1.time_ and arg_49_1.time_ < var_52_27 + var_52_29 then
				local var_52_30 = (arg_49_1.time_ - var_52_27) / var_52_29
				local var_52_31 = Vector3.New(0.7, -0.5, -6.3)

				var_52_26.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos6046_story, var_52_31, var_52_30)

				local var_52_32 = manager.ui.mainCamera.transform.position - var_52_26.position

				var_52_26.forward = Vector3.New(var_52_32.x, var_52_32.y, var_52_32.z)

				local var_52_33 = var_52_26.localEulerAngles

				var_52_33.z = 0
				var_52_33.x = 0
				var_52_26.localEulerAngles = var_52_33
			end

			if arg_49_1.time_ >= var_52_27 + var_52_29 and arg_49_1.time_ < var_52_27 + var_52_29 + arg_52_0 then
				var_52_26.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_52_34 = manager.ui.mainCamera.transform.position - var_52_26.position

				var_52_26.forward = Vector3.New(var_52_34.x, var_52_34.y, var_52_34.z)

				local var_52_35 = var_52_26.localEulerAngles

				var_52_35.z = 0
				var_52_35.x = 0
				var_52_26.localEulerAngles = var_52_35

				local var_52_36 = GameObjectTools.GetOrAddComponent(var_52_26.gameObject, typeof(DynamicBoneHelper))

				if var_52_36 then
					var_52_36:EnableDynamicBone(true)
				end
			end

			local var_52_37 = 0

			if var_52_37 < arg_49_1.time_ and arg_49_1.time_ <= var_52_37 + arg_52_0 then
				arg_49_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			local var_52_38 = arg_49_1.actors_["6046_story"]
			local var_52_39 = 0

			if var_52_39 < arg_49_1.time_ and arg_49_1.time_ <= var_52_39 + arg_52_0 and not isNil(var_52_38) and arg_49_1.var_.characterEffect6046_story == nil then
				arg_49_1.var_.characterEffect6046_story = var_52_38:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_40 = 0.2

			if var_52_39 <= arg_49_1.time_ and arg_49_1.time_ < var_52_39 + var_52_40 and not isNil(var_52_38) then
				local var_52_41 = (arg_49_1.time_ - var_52_39) / var_52_40

				if arg_49_1.var_.characterEffect6046_story and not isNil(var_52_38) then
					local var_52_42 = Mathf.Lerp(0, 0.5, var_52_41)

					arg_49_1.var_.characterEffect6046_story.fillFlat = true
					arg_49_1.var_.characterEffect6046_story.fillRatio = var_52_42
				end
			end

			if arg_49_1.time_ >= var_52_39 + var_52_40 and arg_49_1.time_ < var_52_39 + var_52_40 + arg_52_0 and not isNil(var_52_38) and arg_49_1.var_.characterEffect6046_story then
				local var_52_43 = 0.5

				arg_49_1.var_.characterEffect6046_story.fillFlat = true
				arg_49_1.var_.characterEffect6046_story.fillRatio = var_52_43
			end

			local var_52_44 = 0
			local var_52_45 = 0.225

			if var_52_44 < arg_49_1.time_ and arg_49_1.time_ <= var_52_44 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_46 = arg_49_1:FormatText(StoryNameCfg[215].name)

				arg_49_1.leftNameTxt_.text = var_52_46

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_47 = arg_49_1:GetWordFromCfg(114121012)
				local var_52_48 = arg_49_1:FormatText(var_52_47.content)

				arg_49_1.text_.text = var_52_48

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_49 = 9
				local var_52_50 = utf8.len(var_52_48)
				local var_52_51 = var_52_49 <= 0 and var_52_45 or var_52_45 * (var_52_50 / var_52_49)

				if var_52_51 > 0 and var_52_45 < var_52_51 then
					arg_49_1.talkMaxDuration = var_52_51

					if var_52_51 + var_52_44 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_51 + var_52_44
					end
				end

				arg_49_1.text_.text = var_52_48
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121012", "story_v_out_114121.awb") ~= 0 then
					local var_52_52 = manager.audio:GetVoiceLength("story_v_out_114121", "114121012", "story_v_out_114121.awb") / 1000

					if var_52_52 + var_52_44 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_52 + var_52_44
					end

					if var_52_47.prefab_name ~= "" and arg_49_1.actors_[var_52_47.prefab_name] ~= nil then
						local var_52_53 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_47.prefab_name].transform, "story_v_out_114121", "114121012", "story_v_out_114121.awb")

						arg_49_1:RecordAudio("114121012", var_52_53)
						arg_49_1:RecordAudio("114121012", var_52_53)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_114121", "114121012", "story_v_out_114121.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_114121", "114121012", "story_v_out_114121.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_54 = math.max(var_52_45, arg_49_1.talkMaxDuration)

			if var_52_44 <= arg_49_1.time_ and arg_49_1.time_ < var_52_44 + var_52_54 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_44) / var_52_54

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_44 + var_52_54 and arg_49_1.time_ < var_52_44 + var_52_54 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play114121013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 114121013
		arg_53_1.duration_ = 4.4

		local var_53_0 = {
			ja = 4.4,
			ko = 3.433,
			zh = 4.133,
			en = 2.966
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
				arg_53_0:Play114121014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_1")
			end

			local var_56_1 = 0

			if var_56_1 < arg_53_1.time_ and arg_53_1.time_ <= var_56_1 + arg_56_0 then
				arg_53_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_56_2 = arg_53_1.actors_["6045_story"]
			local var_56_3 = 0

			if var_56_3 < arg_53_1.time_ and arg_53_1.time_ <= var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect6045_story == nil then
				arg_53_1.var_.characterEffect6045_story = var_56_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_4 = 0.2

			if var_56_3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_3 + var_56_4 and not isNil(var_56_2) then
				local var_56_5 = (arg_53_1.time_ - var_56_3) / var_56_4

				if arg_53_1.var_.characterEffect6045_story and not isNil(var_56_2) then
					local var_56_6 = Mathf.Lerp(0, 0.5, var_56_5)

					arg_53_1.var_.characterEffect6045_story.fillFlat = true
					arg_53_1.var_.characterEffect6045_story.fillRatio = var_56_6
				end
			end

			if arg_53_1.time_ >= var_56_3 + var_56_4 and arg_53_1.time_ < var_56_3 + var_56_4 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect6045_story then
				local var_56_7 = 0.5

				arg_53_1.var_.characterEffect6045_story.fillFlat = true
				arg_53_1.var_.characterEffect6045_story.fillRatio = var_56_7
			end

			local var_56_8 = arg_53_1.actors_["6046_story"]
			local var_56_9 = 0

			if var_56_9 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.characterEffect6046_story == nil then
				arg_53_1.var_.characterEffect6046_story = var_56_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_10 = 0.2

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_10 and not isNil(var_56_8) then
				local var_56_11 = (arg_53_1.time_ - var_56_9) / var_56_10

				if arg_53_1.var_.characterEffect6046_story and not isNil(var_56_8) then
					arg_53_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= var_56_9 + var_56_10 and arg_53_1.time_ < var_56_9 + var_56_10 + arg_56_0 and not isNil(var_56_8) and arg_53_1.var_.characterEffect6046_story then
				arg_53_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_56_12 = 0
			local var_56_13 = 0.425

			if var_56_12 < arg_53_1.time_ and arg_53_1.time_ <= var_56_12 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_14 = arg_53_1:FormatText(StoryNameCfg[214].name)

				arg_53_1.leftNameTxt_.text = var_56_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_15 = arg_53_1:GetWordFromCfg(114121013)
				local var_56_16 = arg_53_1:FormatText(var_56_15.content)

				arg_53_1.text_.text = var_56_16

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_17 = 17
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

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121013", "story_v_out_114121.awb") ~= 0 then
					local var_56_20 = manager.audio:GetVoiceLength("story_v_out_114121", "114121013", "story_v_out_114121.awb") / 1000

					if var_56_20 + var_56_12 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_20 + var_56_12
					end

					if var_56_15.prefab_name ~= "" and arg_53_1.actors_[var_56_15.prefab_name] ~= nil then
						local var_56_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_15.prefab_name].transform, "story_v_out_114121", "114121013", "story_v_out_114121.awb")

						arg_53_1:RecordAudio("114121013", var_56_21)
						arg_53_1:RecordAudio("114121013", var_56_21)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_114121", "114121013", "story_v_out_114121.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_114121", "114121013", "story_v_out_114121.awb")
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
	Play114121014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 114121014
		arg_57_1.duration_ = 4.07

		local var_57_0 = {
			ja = 2.366,
			ko = 2.266,
			zh = 4.066,
			en = 2.7
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play114121015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_60_1 = 0
			local var_60_2 = 0.325

			if var_60_1 < arg_57_1.time_ and arg_57_1.time_ <= var_60_1 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_3 = arg_57_1:FormatText(StoryNameCfg[214].name)

				arg_57_1.leftNameTxt_.text = var_60_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_4 = arg_57_1:GetWordFromCfg(114121014)
				local var_60_5 = arg_57_1:FormatText(var_60_4.content)

				arg_57_1.text_.text = var_60_5

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_6 = 13
				local var_60_7 = utf8.len(var_60_5)
				local var_60_8 = var_60_6 <= 0 and var_60_2 or var_60_2 * (var_60_7 / var_60_6)

				if var_60_8 > 0 and var_60_2 < var_60_8 then
					arg_57_1.talkMaxDuration = var_60_8

					if var_60_8 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_1
					end
				end

				arg_57_1.text_.text = var_60_5
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121014", "story_v_out_114121.awb") ~= 0 then
					local var_60_9 = manager.audio:GetVoiceLength("story_v_out_114121", "114121014", "story_v_out_114121.awb") / 1000

					if var_60_9 + var_60_1 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_1
					end

					if var_60_4.prefab_name ~= "" and arg_57_1.actors_[var_60_4.prefab_name] ~= nil then
						local var_60_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_4.prefab_name].transform, "story_v_out_114121", "114121014", "story_v_out_114121.awb")

						arg_57_1:RecordAudio("114121014", var_60_10)
						arg_57_1:RecordAudio("114121014", var_60_10)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_114121", "114121014", "story_v_out_114121.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_114121", "114121014", "story_v_out_114121.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_11 = math.max(var_60_2, arg_57_1.talkMaxDuration)

			if var_60_1 <= arg_57_1.time_ and arg_57_1.time_ < var_60_1 + var_60_11 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_1) / var_60_11

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_1 + var_60_11 and arg_57_1.time_ < var_60_1 + var_60_11 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play114121015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 114121015
		arg_61_1.duration_ = 4.97

		local var_61_0 = {
			ja = 4.966,
			ko = 2.633,
			zh = 4.3,
			en = 3
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
				arg_61_0:Play114121016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action2_2")
			end

			local var_64_1 = 0

			if var_64_1 < arg_61_1.time_ and arg_61_1.time_ <= var_64_1 + arg_64_0 then
				arg_61_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action4_2")
			end

			local var_64_2 = 0

			if var_64_2 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_64_3 = arg_61_1.actors_["6045_story"]
			local var_64_4 = 0

			if var_64_4 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect6045_story == nil then
				arg_61_1.var_.characterEffect6045_story = var_64_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_5 = 0.2

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_5 and not isNil(var_64_3) then
				local var_64_6 = (arg_61_1.time_ - var_64_4) / var_64_5

				if arg_61_1.var_.characterEffect6045_story and not isNil(var_64_3) then
					arg_61_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= var_64_4 + var_64_5 and arg_61_1.time_ < var_64_4 + var_64_5 + arg_64_0 and not isNil(var_64_3) and arg_61_1.var_.characterEffect6045_story then
				arg_61_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_64_7 = arg_61_1.actors_["6046_story"]
			local var_64_8 = 0

			if var_64_8 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.characterEffect6046_story == nil then
				arg_61_1.var_.characterEffect6046_story = var_64_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_9 = 0.2

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_9 and not isNil(var_64_7) then
				local var_64_10 = (arg_61_1.time_ - var_64_8) / var_64_9

				if arg_61_1.var_.characterEffect6046_story and not isNil(var_64_7) then
					local var_64_11 = Mathf.Lerp(0, 0.5, var_64_10)

					arg_61_1.var_.characterEffect6046_story.fillFlat = true
					arg_61_1.var_.characterEffect6046_story.fillRatio = var_64_11
				end
			end

			if arg_61_1.time_ >= var_64_8 + var_64_9 and arg_61_1.time_ < var_64_8 + var_64_9 + arg_64_0 and not isNil(var_64_7) and arg_61_1.var_.characterEffect6046_story then
				local var_64_12 = 0.5

				arg_61_1.var_.characterEffect6046_story.fillFlat = true
				arg_61_1.var_.characterEffect6046_story.fillRatio = var_64_12
			end

			local var_64_13 = 0
			local var_64_14 = 0.25

			if var_64_13 < arg_61_1.time_ and arg_61_1.time_ <= var_64_13 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_15 = arg_61_1:FormatText(StoryNameCfg[215].name)

				arg_61_1.leftNameTxt_.text = var_64_15

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_16 = arg_61_1:GetWordFromCfg(114121015)
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

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121015", "story_v_out_114121.awb") ~= 0 then
					local var_64_21 = manager.audio:GetVoiceLength("story_v_out_114121", "114121015", "story_v_out_114121.awb") / 1000

					if var_64_21 + var_64_13 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_21 + var_64_13
					end

					if var_64_16.prefab_name ~= "" and arg_61_1.actors_[var_64_16.prefab_name] ~= nil then
						local var_64_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_16.prefab_name].transform, "story_v_out_114121", "114121015", "story_v_out_114121.awb")

						arg_61_1:RecordAudio("114121015", var_64_22)
						arg_61_1:RecordAudio("114121015", var_64_22)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_114121", "114121015", "story_v_out_114121.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_114121", "114121015", "story_v_out_114121.awb")
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

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play114121016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 114121016
		arg_65_1.duration_ = 6.87

		local var_65_0 = {
			ja = 6.866,
			ko = 3.833,
			zh = 4.833,
			en = 5.966
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
				arg_65_0:Play114121017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["6046_story"].transform
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.var_.moveOldPos6046_story = var_68_0.localPosition

				local var_68_2 = GameObjectTools.GetOrAddComponent(var_68_0.gameObject, typeof(DynamicBoneHelper))

				if var_68_2 then
					var_68_2:EnableDynamicBone(false)
				end
			end

			local var_68_3 = 0.001

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_3 then
				local var_68_4 = (arg_65_1.time_ - var_68_1) / var_68_3
				local var_68_5 = Vector3.New(0, 100, 0)

				var_68_0.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos6046_story, var_68_5, var_68_4)

				local var_68_6 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_6.x, var_68_6.y, var_68_6.z)

				local var_68_7 = var_68_0.localEulerAngles

				var_68_7.z = 0
				var_68_7.x = 0
				var_68_0.localEulerAngles = var_68_7
			end

			if arg_65_1.time_ >= var_68_1 + var_68_3 and arg_65_1.time_ < var_68_1 + var_68_3 + arg_68_0 then
				var_68_0.localPosition = Vector3.New(0, 100, 0)

				local var_68_8 = manager.ui.mainCamera.transform.position - var_68_0.position

				var_68_0.forward = Vector3.New(var_68_8.x, var_68_8.y, var_68_8.z)

				local var_68_9 = var_68_0.localEulerAngles

				var_68_9.z = 0
				var_68_9.x = 0
				var_68_0.localEulerAngles = var_68_9

				local var_68_10 = GameObjectTools.GetOrAddComponent(var_68_0.gameObject, typeof(DynamicBoneHelper))

				if var_68_10 then
					var_68_10:EnableDynamicBone(true)
				end
			end

			local var_68_11 = arg_65_1.actors_["6045_story"].transform
			local var_68_12 = 0

			if var_68_12 < arg_65_1.time_ and arg_65_1.time_ <= var_68_12 + arg_68_0 then
				arg_65_1.var_.moveOldPos6045_story = var_68_11.localPosition

				local var_68_13 = GameObjectTools.GetOrAddComponent(var_68_11.gameObject, typeof(DynamicBoneHelper))

				if var_68_13 then
					var_68_13:EnableDynamicBone(false)
				end
			end

			local var_68_14 = 0.001

			if var_68_12 <= arg_65_1.time_ and arg_65_1.time_ < var_68_12 + var_68_14 then
				local var_68_15 = (arg_65_1.time_ - var_68_12) / var_68_14
				local var_68_16 = Vector3.New(0, 100, 0)

				var_68_11.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos6045_story, var_68_16, var_68_15)

				local var_68_17 = manager.ui.mainCamera.transform.position - var_68_11.position

				var_68_11.forward = Vector3.New(var_68_17.x, var_68_17.y, var_68_17.z)

				local var_68_18 = var_68_11.localEulerAngles

				var_68_18.z = 0
				var_68_18.x = 0
				var_68_11.localEulerAngles = var_68_18
			end

			if arg_65_1.time_ >= var_68_12 + var_68_14 and arg_65_1.time_ < var_68_12 + var_68_14 + arg_68_0 then
				var_68_11.localPosition = Vector3.New(0, 100, 0)

				local var_68_19 = manager.ui.mainCamera.transform.position - var_68_11.position

				var_68_11.forward = Vector3.New(var_68_19.x, var_68_19.y, var_68_19.z)

				local var_68_20 = var_68_11.localEulerAngles

				var_68_20.z = 0
				var_68_20.x = 0
				var_68_11.localEulerAngles = var_68_20

				local var_68_21 = GameObjectTools.GetOrAddComponent(var_68_11.gameObject, typeof(DynamicBoneHelper))

				if var_68_21 then
					var_68_21:EnableDynamicBone(true)
				end
			end

			local var_68_22 = arg_65_1.actors_["1042ui_story"].transform
			local var_68_23 = 0

			if var_68_23 < arg_65_1.time_ and arg_65_1.time_ <= var_68_23 + arg_68_0 then
				arg_65_1.var_.moveOldPos1042ui_story = var_68_22.localPosition
			end

			local var_68_24 = 0.001

			if var_68_23 <= arg_65_1.time_ and arg_65_1.time_ < var_68_23 + var_68_24 then
				local var_68_25 = (arg_65_1.time_ - var_68_23) / var_68_24
				local var_68_26 = Vector3.New(0, -1.06, -6.2)

				var_68_22.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1042ui_story, var_68_26, var_68_25)

				local var_68_27 = manager.ui.mainCamera.transform.position - var_68_22.position

				var_68_22.forward = Vector3.New(var_68_27.x, var_68_27.y, var_68_27.z)

				local var_68_28 = var_68_22.localEulerAngles

				var_68_28.z = 0
				var_68_28.x = 0
				var_68_22.localEulerAngles = var_68_28
			end

			if arg_65_1.time_ >= var_68_23 + var_68_24 and arg_65_1.time_ < var_68_23 + var_68_24 + arg_68_0 then
				var_68_22.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_68_29 = manager.ui.mainCamera.transform.position - var_68_22.position

				var_68_22.forward = Vector3.New(var_68_29.x, var_68_29.y, var_68_29.z)

				local var_68_30 = var_68_22.localEulerAngles

				var_68_30.z = 0
				var_68_30.x = 0
				var_68_22.localEulerAngles = var_68_30
			end

			local var_68_31 = 0

			if var_68_31 < arg_65_1.time_ and arg_65_1.time_ <= var_68_31 + arg_68_0 then
				arg_65_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_68_32 = 0

			if var_68_32 < arg_65_1.time_ and arg_65_1.time_ <= var_68_32 + arg_68_0 then
				arg_65_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_68_33 = arg_65_1.actors_["1042ui_story"]
			local var_68_34 = 0

			if var_68_34 < arg_65_1.time_ and arg_65_1.time_ <= var_68_34 + arg_68_0 and not isNil(var_68_33) and arg_65_1.var_.characterEffect1042ui_story == nil then
				arg_65_1.var_.characterEffect1042ui_story = var_68_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_35 = 0.2

			if var_68_34 <= arg_65_1.time_ and arg_65_1.time_ < var_68_34 + var_68_35 and not isNil(var_68_33) then
				local var_68_36 = (arg_65_1.time_ - var_68_34) / var_68_35

				if arg_65_1.var_.characterEffect1042ui_story and not isNil(var_68_33) then
					arg_65_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= var_68_34 + var_68_35 and arg_65_1.time_ < var_68_34 + var_68_35 + arg_68_0 and not isNil(var_68_33) and arg_65_1.var_.characterEffect1042ui_story then
				arg_65_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_68_37 = 0
			local var_68_38 = 0.375

			if var_68_37 < arg_65_1.time_ and arg_65_1.time_ <= var_68_37 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_39 = arg_65_1:FormatText(StoryNameCfg[205].name)

				arg_65_1.leftNameTxt_.text = var_68_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_40 = arg_65_1:GetWordFromCfg(114121016)
				local var_68_41 = arg_65_1:FormatText(var_68_40.content)

				arg_65_1.text_.text = var_68_41

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_42 = 15
				local var_68_43 = utf8.len(var_68_41)
				local var_68_44 = var_68_42 <= 0 and var_68_38 or var_68_38 * (var_68_43 / var_68_42)

				if var_68_44 > 0 and var_68_38 < var_68_44 then
					arg_65_1.talkMaxDuration = var_68_44

					if var_68_44 + var_68_37 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_44 + var_68_37
					end
				end

				arg_65_1.text_.text = var_68_41
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121016", "story_v_out_114121.awb") ~= 0 then
					local var_68_45 = manager.audio:GetVoiceLength("story_v_out_114121", "114121016", "story_v_out_114121.awb") / 1000

					if var_68_45 + var_68_37 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_45 + var_68_37
					end

					if var_68_40.prefab_name ~= "" and arg_65_1.actors_[var_68_40.prefab_name] ~= nil then
						local var_68_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_40.prefab_name].transform, "story_v_out_114121", "114121016", "story_v_out_114121.awb")

						arg_65_1:RecordAudio("114121016", var_68_46)
						arg_65_1:RecordAudio("114121016", var_68_46)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_114121", "114121016", "story_v_out_114121.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_114121", "114121016", "story_v_out_114121.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_47 = math.max(var_68_38, arg_65_1.talkMaxDuration)

			if var_68_37 <= arg_65_1.time_ and arg_65_1.time_ < var_68_37 + var_68_47 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_37) / var_68_47

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_37 + var_68_47 and arg_65_1.time_ < var_68_37 + var_68_47 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play114121017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 114121017
		arg_69_1.duration_ = 3.47

		local var_69_0 = {
			ja = 2.5,
			ko = 2.1,
			zh = 3.466,
			en = 3.066
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
				arg_69_0:Play114121018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["1042ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1042ui_story == nil then
				arg_69_1.var_.characterEffect1042ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.2

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect1042ui_story and not isNil(var_72_0) then
					local var_72_4 = Mathf.Lerp(0, 0.5, var_72_3)

					arg_69_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1042ui_story.fillRatio = var_72_4
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect1042ui_story then
				local var_72_5 = 0.5

				arg_69_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1042ui_story.fillRatio = var_72_5
			end

			local var_72_6 = 0
			local var_72_7 = 0.225

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[215].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_9 = arg_69_1:GetWordFromCfg(114121017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 9
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

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121017", "story_v_out_114121.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_114121", "114121017", "story_v_out_114121.awb") / 1000

					if var_72_14 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_6
					end

					if var_72_9.prefab_name ~= "" and arg_69_1.actors_[var_72_9.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_9.prefab_name].transform, "story_v_out_114121", "114121017", "story_v_out_114121.awb")

						arg_69_1:RecordAudio("114121017", var_72_15)
						arg_69_1:RecordAudio("114121017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_114121", "114121017", "story_v_out_114121.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_114121", "114121017", "story_v_out_114121.awb")
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
	Play114121018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 114121018
		arg_73_1.duration_ = 8.3

		local var_73_0 = {
			ja = 8.3,
			ko = 3.8,
			zh = 5.133,
			en = 4.766
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
				arg_73_0:Play114121019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0

			if var_76_0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_0 + arg_76_0 then
				arg_73_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action426")
			end

			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_76_2 = arg_73_1.actors_["1042ui_story"]
			local var_76_3 = 0

			if var_76_3 < arg_73_1.time_ and arg_73_1.time_ <= var_76_3 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1042ui_story == nil then
				arg_73_1.var_.characterEffect1042ui_story = var_76_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_4 = 0.2

			if var_76_3 <= arg_73_1.time_ and arg_73_1.time_ < var_76_3 + var_76_4 and not isNil(var_76_2) then
				local var_76_5 = (arg_73_1.time_ - var_76_3) / var_76_4

				if arg_73_1.var_.characterEffect1042ui_story and not isNil(var_76_2) then
					arg_73_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= var_76_3 + var_76_4 and arg_73_1.time_ < var_76_3 + var_76_4 + arg_76_0 and not isNil(var_76_2) and arg_73_1.var_.characterEffect1042ui_story then
				arg_73_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_76_6 = 0
			local var_76_7 = 0.575

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[205].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_9 = arg_73_1:GetWordFromCfg(114121018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 23
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

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121018", "story_v_out_114121.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_114121", "114121018", "story_v_out_114121.awb") / 1000

					if var_76_14 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_6
					end

					if var_76_9.prefab_name ~= "" and arg_73_1.actors_[var_76_9.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_9.prefab_name].transform, "story_v_out_114121", "114121018", "story_v_out_114121.awb")

						arg_73_1:RecordAudio("114121018", var_76_15)
						arg_73_1:RecordAudio("114121018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_114121", "114121018", "story_v_out_114121.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_114121", "114121018", "story_v_out_114121.awb")
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
	Play114121019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 114121019
		arg_77_1.duration_ = 7.03

		local var_77_0 = {
			ja = 5.733,
			ko = 2.7,
			zh = 7.033,
			en = 4.833
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
				arg_77_0:Play114121020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = arg_77_1.actors_["1042ui_story"].transform
			local var_80_1 = 0

			if var_80_1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_1 + arg_80_0 then
				arg_77_1.var_.moveOldPos1042ui_story = var_80_0.localPosition
			end

			local var_80_2 = 0.001

			if var_80_1 <= arg_77_1.time_ and arg_77_1.time_ < var_80_1 + var_80_2 then
				local var_80_3 = (arg_77_1.time_ - var_80_1) / var_80_2
				local var_80_4 = Vector3.New(0, 100, 0)

				var_80_0.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1042ui_story, var_80_4, var_80_3)

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

			local var_80_9 = arg_77_1.actors_["6045_story"].transform
			local var_80_10 = 0

			if var_80_10 < arg_77_1.time_ and arg_77_1.time_ <= var_80_10 + arg_80_0 then
				arg_77_1.var_.moveOldPos6045_story = var_80_9.localPosition

				local var_80_11 = GameObjectTools.GetOrAddComponent(var_80_9.gameObject, typeof(DynamicBoneHelper))

				if var_80_11 then
					var_80_11:EnableDynamicBone(false)
				end
			end

			local var_80_12 = 0.001

			if var_80_10 <= arg_77_1.time_ and arg_77_1.time_ < var_80_10 + var_80_12 then
				local var_80_13 = (arg_77_1.time_ - var_80_10) / var_80_12
				local var_80_14 = Vector3.New(-0.7, -0.5, -6.3)

				var_80_9.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos6045_story, var_80_14, var_80_13)

				local var_80_15 = manager.ui.mainCamera.transform.position - var_80_9.position

				var_80_9.forward = Vector3.New(var_80_15.x, var_80_15.y, var_80_15.z)

				local var_80_16 = var_80_9.localEulerAngles

				var_80_16.z = 0
				var_80_16.x = 0
				var_80_9.localEulerAngles = var_80_16
			end

			if arg_77_1.time_ >= var_80_10 + var_80_12 and arg_77_1.time_ < var_80_10 + var_80_12 + arg_80_0 then
				var_80_9.localPosition = Vector3.New(-0.7, -0.5, -6.3)

				local var_80_17 = manager.ui.mainCamera.transform.position - var_80_9.position

				var_80_9.forward = Vector3.New(var_80_17.x, var_80_17.y, var_80_17.z)

				local var_80_18 = var_80_9.localEulerAngles

				var_80_18.z = 0
				var_80_18.x = 0
				var_80_9.localEulerAngles = var_80_18

				local var_80_19 = GameObjectTools.GetOrAddComponent(var_80_9.gameObject, typeof(DynamicBoneHelper))

				if var_80_19 then
					var_80_19:EnableDynamicBone(true)
				end
			end

			local var_80_20 = 0

			if var_80_20 < arg_77_1.time_ and arg_77_1.time_ <= var_80_20 + arg_80_0 then
				arg_77_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/story6045/story6045action/6045action1_1")
			end

			local var_80_21 = 0

			if var_80_21 < arg_77_1.time_ and arg_77_1.time_ <= var_80_21 + arg_80_0 then
				arg_77_1:PlayTimeline("6045_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_80_22 = arg_77_1.actors_["6045_story"]
			local var_80_23 = 0

			if var_80_23 < arg_77_1.time_ and arg_77_1.time_ <= var_80_23 + arg_80_0 and not isNil(var_80_22) and arg_77_1.var_.characterEffect6045_story == nil then
				arg_77_1.var_.characterEffect6045_story = var_80_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_24 = 0.2

			if var_80_23 <= arg_77_1.time_ and arg_77_1.time_ < var_80_23 + var_80_24 and not isNil(var_80_22) then
				local var_80_25 = (arg_77_1.time_ - var_80_23) / var_80_24

				if arg_77_1.var_.characterEffect6045_story and not isNil(var_80_22) then
					arg_77_1.var_.characterEffect6045_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= var_80_23 + var_80_24 and arg_77_1.time_ < var_80_23 + var_80_24 + arg_80_0 and not isNil(var_80_22) and arg_77_1.var_.characterEffect6045_story then
				arg_77_1.var_.characterEffect6045_story.fillFlat = false
			end

			local var_80_26 = arg_77_1.actors_["6046_story"].transform
			local var_80_27 = 0

			if var_80_27 < arg_77_1.time_ and arg_77_1.time_ <= var_80_27 + arg_80_0 then
				arg_77_1.var_.moveOldPos6046_story = var_80_26.localPosition

				local var_80_28 = GameObjectTools.GetOrAddComponent(var_80_26.gameObject, typeof(DynamicBoneHelper))

				if var_80_28 then
					var_80_28:EnableDynamicBone(false)
				end
			end

			local var_80_29 = 0.001

			if var_80_27 <= arg_77_1.time_ and arg_77_1.time_ < var_80_27 + var_80_29 then
				local var_80_30 = (arg_77_1.time_ - var_80_27) / var_80_29
				local var_80_31 = Vector3.New(0.7, -0.5, -6.3)

				var_80_26.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos6046_story, var_80_31, var_80_30)

				local var_80_32 = manager.ui.mainCamera.transform.position - var_80_26.position

				var_80_26.forward = Vector3.New(var_80_32.x, var_80_32.y, var_80_32.z)

				local var_80_33 = var_80_26.localEulerAngles

				var_80_33.z = 0
				var_80_33.x = 0
				var_80_26.localEulerAngles = var_80_33
			end

			if arg_77_1.time_ >= var_80_27 + var_80_29 and arg_77_1.time_ < var_80_27 + var_80_29 + arg_80_0 then
				var_80_26.localPosition = Vector3.New(0.7, -0.5, -6.3)

				local var_80_34 = manager.ui.mainCamera.transform.position - var_80_26.position

				var_80_26.forward = Vector3.New(var_80_34.x, var_80_34.y, var_80_34.z)

				local var_80_35 = var_80_26.localEulerAngles

				var_80_35.z = 0
				var_80_35.x = 0
				var_80_26.localEulerAngles = var_80_35

				local var_80_36 = GameObjectTools.GetOrAddComponent(var_80_26.gameObject, typeof(DynamicBoneHelper))

				if var_80_36 then
					var_80_36:EnableDynamicBone(true)
				end
			end

			local var_80_37 = arg_77_1.actors_["6046_story"]
			local var_80_38 = 0

			if var_80_38 < arg_77_1.time_ and arg_77_1.time_ <= var_80_38 + arg_80_0 and not isNil(var_80_37) and arg_77_1.var_.characterEffect6046_story == nil then
				arg_77_1.var_.characterEffect6046_story = var_80_37:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_39 = 0.2

			if var_80_38 <= arg_77_1.time_ and arg_77_1.time_ < var_80_38 + var_80_39 and not isNil(var_80_37) then
				local var_80_40 = (arg_77_1.time_ - var_80_38) / var_80_39

				if arg_77_1.var_.characterEffect6046_story and not isNil(var_80_37) then
					local var_80_41 = Mathf.Lerp(0, 0.5, var_80_40)

					arg_77_1.var_.characterEffect6046_story.fillFlat = true
					arg_77_1.var_.characterEffect6046_story.fillRatio = var_80_41
				end
			end

			if arg_77_1.time_ >= var_80_38 + var_80_39 and arg_77_1.time_ < var_80_38 + var_80_39 + arg_80_0 and not isNil(var_80_37) and arg_77_1.var_.characterEffect6046_story then
				local var_80_42 = 0.5

				arg_77_1.var_.characterEffect6046_story.fillFlat = true
				arg_77_1.var_.characterEffect6046_story.fillRatio = var_80_42
			end

			local var_80_43 = 0
			local var_80_44 = 0.375

			if var_80_43 < arg_77_1.time_ and arg_77_1.time_ <= var_80_43 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_45 = arg_77_1:FormatText(StoryNameCfg[215].name)

				arg_77_1.leftNameTxt_.text = var_80_45

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_46 = arg_77_1:GetWordFromCfg(114121019)
				local var_80_47 = arg_77_1:FormatText(var_80_46.content)

				arg_77_1.text_.text = var_80_47

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_48 = 15
				local var_80_49 = utf8.len(var_80_47)
				local var_80_50 = var_80_48 <= 0 and var_80_44 or var_80_44 * (var_80_49 / var_80_48)

				if var_80_50 > 0 and var_80_44 < var_80_50 then
					arg_77_1.talkMaxDuration = var_80_50

					if var_80_50 + var_80_43 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_50 + var_80_43
					end
				end

				arg_77_1.text_.text = var_80_47
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121019", "story_v_out_114121.awb") ~= 0 then
					local var_80_51 = manager.audio:GetVoiceLength("story_v_out_114121", "114121019", "story_v_out_114121.awb") / 1000

					if var_80_51 + var_80_43 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_51 + var_80_43
					end

					if var_80_46.prefab_name ~= "" and arg_77_1.actors_[var_80_46.prefab_name] ~= nil then
						local var_80_52 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_46.prefab_name].transform, "story_v_out_114121", "114121019", "story_v_out_114121.awb")

						arg_77_1:RecordAudio("114121019", var_80_52)
						arg_77_1:RecordAudio("114121019", var_80_52)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_114121", "114121019", "story_v_out_114121.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_114121", "114121019", "story_v_out_114121.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_53 = math.max(var_80_44, arg_77_1.talkMaxDuration)

			if var_80_43 <= arg_77_1.time_ and arg_77_1.time_ < var_80_43 + var_80_53 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_43) / var_80_53

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_43 + var_80_53 and arg_77_1.time_ < var_80_43 + var_80_53 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play114121020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 114121020
		arg_81_1.duration_ = 5.23

		local var_81_0 = {
			ja = 2.833,
			ko = 4.966,
			zh = 4.833,
			en = 5.233
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
				arg_81_0:Play114121021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["6045_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect6045_story == nil then
				arg_81_1.var_.characterEffect6045_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.2

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect6045_story and not isNil(var_84_0) then
					local var_84_4 = Mathf.Lerp(0, 0.5, var_84_3)

					arg_81_1.var_.characterEffect6045_story.fillFlat = true
					arg_81_1.var_.characterEffect6045_story.fillRatio = var_84_4
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect6045_story then
				local var_84_5 = 0.5

				arg_81_1.var_.characterEffect6045_story.fillFlat = true
				arg_81_1.var_.characterEffect6045_story.fillRatio = var_84_5
			end

			local var_84_6 = 0
			local var_84_7 = 0.4

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_8 = arg_81_1:FormatText(StoryNameCfg[205].name)

				arg_81_1.leftNameTxt_.text = var_84_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, true)
				arg_81_1.iconController_:SetSelectedState("hero")

				arg_81_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_81_1.callingController_:SetSelectedState("normal")

				arg_81_1.keyicon_.color = Color.New(1, 1, 1)
				arg_81_1.icon_.color = Color.New(1, 1, 1)

				local var_84_9 = arg_81_1:GetWordFromCfg(114121020)
				local var_84_10 = arg_81_1:FormatText(var_84_9.content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 16
				local var_84_12 = utf8.len(var_84_10)
				local var_84_13 = var_84_11 <= 0 and var_84_7 or var_84_7 * (var_84_12 / var_84_11)

				if var_84_13 > 0 and var_84_7 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_6
					end
				end

				arg_81_1.text_.text = var_84_10
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121020", "story_v_out_114121.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_114121", "114121020", "story_v_out_114121.awb") / 1000

					if var_84_14 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_6
					end

					if var_84_9.prefab_name ~= "" and arg_81_1.actors_[var_84_9.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_9.prefab_name].transform, "story_v_out_114121", "114121020", "story_v_out_114121.awb")

						arg_81_1:RecordAudio("114121020", var_84_15)
						arg_81_1:RecordAudio("114121020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_114121", "114121020", "story_v_out_114121.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_114121", "114121020", "story_v_out_114121.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_7, arg_81_1.talkMaxDuration)

			if var_84_6 <= arg_81_1.time_ and arg_81_1.time_ < var_84_6 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_6) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_6 + var_84_16 and arg_81_1.time_ < var_84_6 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play114121021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 114121021
		arg_85_1.duration_ = 5.7

		local var_85_0 = {
			ja = 5.7,
			ko = 3.9,
			zh = 3.533,
			en = 3.766
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
				arg_85_0:Play114121022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_88_1 = arg_85_1.actors_["6046_story"]
			local var_88_2 = 0

			if var_88_2 < arg_85_1.time_ and arg_85_1.time_ <= var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect6046_story == nil then
				arg_85_1.var_.characterEffect6046_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_3 = 0.2

			if var_88_2 <= arg_85_1.time_ and arg_85_1.time_ < var_88_2 + var_88_3 and not isNil(var_88_1) then
				local var_88_4 = (arg_85_1.time_ - var_88_2) / var_88_3

				if arg_85_1.var_.characterEffect6046_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= var_88_2 + var_88_3 and arg_85_1.time_ < var_88_2 + var_88_3 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect6046_story then
				arg_85_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_88_5 = 0

			if var_88_5 < arg_85_1.time_ and arg_85_1.time_ <= var_88_5 + arg_88_0 then
				arg_85_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			local var_88_6 = 0
			local var_88_7 = 0.275

			if var_88_6 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_8 = arg_85_1:FormatText(StoryNameCfg[214].name)

				arg_85_1.leftNameTxt_.text = var_88_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_9 = arg_85_1:GetWordFromCfg(114121021)
				local var_88_10 = arg_85_1:FormatText(var_88_9.content)

				arg_85_1.text_.text = var_88_10

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 11
				local var_88_12 = utf8.len(var_88_10)
				local var_88_13 = var_88_11 <= 0 and var_88_7 or var_88_7 * (var_88_12 / var_88_11)

				if var_88_13 > 0 and var_88_7 < var_88_13 then
					arg_85_1.talkMaxDuration = var_88_13

					if var_88_13 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_13 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_10
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121021", "story_v_out_114121.awb") ~= 0 then
					local var_88_14 = manager.audio:GetVoiceLength("story_v_out_114121", "114121021", "story_v_out_114121.awb") / 1000

					if var_88_14 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_14 + var_88_6
					end

					if var_88_9.prefab_name ~= "" and arg_85_1.actors_[var_88_9.prefab_name] ~= nil then
						local var_88_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_9.prefab_name].transform, "story_v_out_114121", "114121021", "story_v_out_114121.awb")

						arg_85_1:RecordAudio("114121021", var_88_15)
						arg_85_1:RecordAudio("114121021", var_88_15)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_114121", "114121021", "story_v_out_114121.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_114121", "114121021", "story_v_out_114121.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_16 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_16 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_16

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_16 and arg_85_1.time_ < var_88_6 + var_88_16 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play114121022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 114121022
		arg_89_1.duration_ = 4.3

		local var_89_0 = {
			ja = 4.3,
			ko = 2.766,
			zh = 2.466,
			en = 4.066
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
				arg_89_0:Play114121023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["6046_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect6046_story == nil then
				arg_89_1.var_.characterEffect6046_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.2

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect6046_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect6046_story.fillFlat = true
					arg_89_1.var_.characterEffect6046_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect6046_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect6046_story.fillFlat = true
				arg_89_1.var_.characterEffect6046_story.fillRatio = var_92_5
			end

			local var_92_6 = 0
			local var_92_7 = 0.275

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_8 = arg_89_1:FormatText(StoryNameCfg[205].name)

				arg_89_1.leftNameTxt_.text = var_92_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1042")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_9 = arg_89_1:GetWordFromCfg(114121022)
				local var_92_10 = arg_89_1:FormatText(var_92_9.content)

				arg_89_1.text_.text = var_92_10

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 11
				local var_92_12 = utf8.len(var_92_10)
				local var_92_13 = var_92_11 <= 0 and var_92_7 or var_92_7 * (var_92_12 / var_92_11)

				if var_92_13 > 0 and var_92_7 < var_92_13 then
					arg_89_1.talkMaxDuration = var_92_13

					if var_92_13 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_13 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_10
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121022", "story_v_out_114121.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_114121", "114121022", "story_v_out_114121.awb") / 1000

					if var_92_14 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_6
					end

					if var_92_9.prefab_name ~= "" and arg_89_1.actors_[var_92_9.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_9.prefab_name].transform, "story_v_out_114121", "114121022", "story_v_out_114121.awb")

						arg_89_1:RecordAudio("114121022", var_92_15)
						arg_89_1:RecordAudio("114121022", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_114121", "114121022", "story_v_out_114121.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_114121", "114121022", "story_v_out_114121.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_16 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_16 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_16

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_16 and arg_89_1.time_ < var_92_6 + var_92_16 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play114121023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 114121023
		arg_93_1.duration_ = 6.17

		local var_93_0 = {
			ja = 5.033,
			ko = 4.4,
			zh = 6.133,
			en = 6.166
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
				arg_93_0:Play114121024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["6046_story"].transform
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.var_.moveOldPos6046_story = var_96_0.localPosition

				local var_96_2 = GameObjectTools.GetOrAddComponent(var_96_0.gameObject, typeof(DynamicBoneHelper))

				if var_96_2 then
					var_96_2:EnableDynamicBone(false)
				end
			end

			local var_96_3 = 0.001

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_3 then
				local var_96_4 = (arg_93_1.time_ - var_96_1) / var_96_3
				local var_96_5 = Vector3.New(0, 100, 0)

				var_96_0.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos6046_story, var_96_5, var_96_4)

				local var_96_6 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_6.x, var_96_6.y, var_96_6.z)

				local var_96_7 = var_96_0.localEulerAngles

				var_96_7.z = 0
				var_96_7.x = 0
				var_96_0.localEulerAngles = var_96_7
			end

			if arg_93_1.time_ >= var_96_1 + var_96_3 and arg_93_1.time_ < var_96_1 + var_96_3 + arg_96_0 then
				var_96_0.localPosition = Vector3.New(0, 100, 0)

				local var_96_8 = manager.ui.mainCamera.transform.position - var_96_0.position

				var_96_0.forward = Vector3.New(var_96_8.x, var_96_8.y, var_96_8.z)

				local var_96_9 = var_96_0.localEulerAngles

				var_96_9.z = 0
				var_96_9.x = 0
				var_96_0.localEulerAngles = var_96_9

				local var_96_10 = GameObjectTools.GetOrAddComponent(var_96_0.gameObject, typeof(DynamicBoneHelper))

				if var_96_10 then
					var_96_10:EnableDynamicBone(true)
				end
			end

			local var_96_11 = arg_93_1.actors_["6045_story"].transform
			local var_96_12 = 0

			if var_96_12 < arg_93_1.time_ and arg_93_1.time_ <= var_96_12 + arg_96_0 then
				arg_93_1.var_.moveOldPos6045_story = var_96_11.localPosition

				local var_96_13 = GameObjectTools.GetOrAddComponent(var_96_11.gameObject, typeof(DynamicBoneHelper))

				if var_96_13 then
					var_96_13:EnableDynamicBone(false)
				end
			end

			local var_96_14 = 0.001

			if var_96_12 <= arg_93_1.time_ and arg_93_1.time_ < var_96_12 + var_96_14 then
				local var_96_15 = (arg_93_1.time_ - var_96_12) / var_96_14
				local var_96_16 = Vector3.New(0, 100, 0)

				var_96_11.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos6045_story, var_96_16, var_96_15)

				local var_96_17 = manager.ui.mainCamera.transform.position - var_96_11.position

				var_96_11.forward = Vector3.New(var_96_17.x, var_96_17.y, var_96_17.z)

				local var_96_18 = var_96_11.localEulerAngles

				var_96_18.z = 0
				var_96_18.x = 0
				var_96_11.localEulerAngles = var_96_18
			end

			if arg_93_1.time_ >= var_96_12 + var_96_14 and arg_93_1.time_ < var_96_12 + var_96_14 + arg_96_0 then
				var_96_11.localPosition = Vector3.New(0, 100, 0)

				local var_96_19 = manager.ui.mainCamera.transform.position - var_96_11.position

				var_96_11.forward = Vector3.New(var_96_19.x, var_96_19.y, var_96_19.z)

				local var_96_20 = var_96_11.localEulerAngles

				var_96_20.z = 0
				var_96_20.x = 0
				var_96_11.localEulerAngles = var_96_20

				local var_96_21 = GameObjectTools.GetOrAddComponent(var_96_11.gameObject, typeof(DynamicBoneHelper))

				if var_96_21 then
					var_96_21:EnableDynamicBone(true)
				end
			end

			local var_96_22 = arg_93_1.actors_["1042ui_story"].transform
			local var_96_23 = 0

			if var_96_23 < arg_93_1.time_ and arg_93_1.time_ <= var_96_23 + arg_96_0 then
				arg_93_1.var_.moveOldPos1042ui_story = var_96_22.localPosition
			end

			local var_96_24 = 0.001

			if var_96_23 <= arg_93_1.time_ and arg_93_1.time_ < var_96_23 + var_96_24 then
				local var_96_25 = (arg_93_1.time_ - var_96_23) / var_96_24
				local var_96_26 = Vector3.New(0, -1.06, -6.2)

				var_96_22.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1042ui_story, var_96_26, var_96_25)

				local var_96_27 = manager.ui.mainCamera.transform.position - var_96_22.position

				var_96_22.forward = Vector3.New(var_96_27.x, var_96_27.y, var_96_27.z)

				local var_96_28 = var_96_22.localEulerAngles

				var_96_28.z = 0
				var_96_28.x = 0
				var_96_22.localEulerAngles = var_96_28
			end

			if arg_93_1.time_ >= var_96_23 + var_96_24 and arg_93_1.time_ < var_96_23 + var_96_24 + arg_96_0 then
				var_96_22.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_96_29 = manager.ui.mainCamera.transform.position - var_96_22.position

				var_96_22.forward = Vector3.New(var_96_29.x, var_96_29.y, var_96_29.z)

				local var_96_30 = var_96_22.localEulerAngles

				var_96_30.z = 0
				var_96_30.x = 0
				var_96_22.localEulerAngles = var_96_30
			end

			local var_96_31 = 0

			if var_96_31 < arg_93_1.time_ and arg_93_1.time_ <= var_96_31 + arg_96_0 then
				arg_93_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_96_32 = 0

			if var_96_32 < arg_93_1.time_ and arg_93_1.time_ <= var_96_32 + arg_96_0 then
				arg_93_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_96_33 = arg_93_1.actors_["1042ui_story"]
			local var_96_34 = 0

			if var_96_34 < arg_93_1.time_ and arg_93_1.time_ <= var_96_34 + arg_96_0 and not isNil(var_96_33) and arg_93_1.var_.characterEffect1042ui_story == nil then
				arg_93_1.var_.characterEffect1042ui_story = var_96_33:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_35 = 0.2

			if var_96_34 <= arg_93_1.time_ and arg_93_1.time_ < var_96_34 + var_96_35 and not isNil(var_96_33) then
				local var_96_36 = (arg_93_1.time_ - var_96_34) / var_96_35

				if arg_93_1.var_.characterEffect1042ui_story and not isNil(var_96_33) then
					arg_93_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_34 + var_96_35 and arg_93_1.time_ < var_96_34 + var_96_35 + arg_96_0 and not isNil(var_96_33) and arg_93_1.var_.characterEffect1042ui_story then
				arg_93_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_96_37 = 0
			local var_96_38 = 0.475

			if var_96_37 < arg_93_1.time_ and arg_93_1.time_ <= var_96_37 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_39 = arg_93_1:FormatText(StoryNameCfg[205].name)

				arg_93_1.leftNameTxt_.text = var_96_39

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_40 = arg_93_1:GetWordFromCfg(114121023)
				local var_96_41 = arg_93_1:FormatText(var_96_40.content)

				arg_93_1.text_.text = var_96_41

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_42 = 19
				local var_96_43 = utf8.len(var_96_41)
				local var_96_44 = var_96_42 <= 0 and var_96_38 or var_96_38 * (var_96_43 / var_96_42)

				if var_96_44 > 0 and var_96_38 < var_96_44 then
					arg_93_1.talkMaxDuration = var_96_44

					if var_96_44 + var_96_37 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_44 + var_96_37
					end
				end

				arg_93_1.text_.text = var_96_41
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121023", "story_v_out_114121.awb") ~= 0 then
					local var_96_45 = manager.audio:GetVoiceLength("story_v_out_114121", "114121023", "story_v_out_114121.awb") / 1000

					if var_96_45 + var_96_37 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_45 + var_96_37
					end

					if var_96_40.prefab_name ~= "" and arg_93_1.actors_[var_96_40.prefab_name] ~= nil then
						local var_96_46 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_40.prefab_name].transform, "story_v_out_114121", "114121023", "story_v_out_114121.awb")

						arg_93_1:RecordAudio("114121023", var_96_46)
						arg_93_1:RecordAudio("114121023", var_96_46)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_114121", "114121023", "story_v_out_114121.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_114121", "114121023", "story_v_out_114121.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_47 = math.max(var_96_38, arg_93_1.talkMaxDuration)

			if var_96_37 <= arg_93_1.time_ and arg_93_1.time_ < var_96_37 + var_96_47 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_37) / var_96_47

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_37 + var_96_47 and arg_93_1.time_ < var_96_37 + var_96_47 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6045_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_93_1:InitPlayNodeList()
	end,
	Play114121024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 114121024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play114121025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = arg_97_1.actors_["1042ui_story"].transform
			local var_100_1 = 0

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.var_.moveOldPos1042ui_story = var_100_0.localPosition
			end

			local var_100_2 = 0.001

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_2 then
				local var_100_3 = (arg_97_1.time_ - var_100_1) / var_100_2
				local var_100_4 = Vector3.New(0, 100, 0)

				var_100_0.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos1042ui_story, var_100_4, var_100_3)

				local var_100_5 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_5.x, var_100_5.y, var_100_5.z)

				local var_100_6 = var_100_0.localEulerAngles

				var_100_6.z = 0
				var_100_6.x = 0
				var_100_0.localEulerAngles = var_100_6
			end

			if arg_97_1.time_ >= var_100_1 + var_100_2 and arg_97_1.time_ < var_100_1 + var_100_2 + arg_100_0 then
				var_100_0.localPosition = Vector3.New(0, 100, 0)

				local var_100_7 = manager.ui.mainCamera.transform.position - var_100_0.position

				var_100_0.forward = Vector3.New(var_100_7.x, var_100_7.y, var_100_7.z)

				local var_100_8 = var_100_0.localEulerAngles

				var_100_8.z = 0
				var_100_8.x = 0
				var_100_0.localEulerAngles = var_100_8
			end

			local var_100_9 = 0
			local var_100_10 = 0.925

			if var_100_9 < arg_97_1.time_ and arg_97_1.time_ <= var_100_9 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, false)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_11 = arg_97_1:GetWordFromCfg(114121024)
				local var_100_12 = arg_97_1:FormatText(var_100_11.content)

				arg_97_1.text_.text = var_100_12

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_13 = 37
				local var_100_14 = utf8.len(var_100_12)
				local var_100_15 = var_100_13 <= 0 and var_100_10 or var_100_10 * (var_100_14 / var_100_13)

				if var_100_15 > 0 and var_100_10 < var_100_15 then
					arg_97_1.talkMaxDuration = var_100_15

					if var_100_15 + var_100_9 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_15 + var_100_9
					end
				end

				arg_97_1.text_.text = var_100_12
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_16 = math.max(var_100_10, arg_97_1.talkMaxDuration)

			if var_100_9 <= arg_97_1.time_ and arg_97_1.time_ < var_100_9 + var_100_16 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_9) / var_100_16

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_9 + var_100_16 and arg_97_1.time_ < var_100_9 + var_100_16 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play114121025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 114121025
		arg_101_1.duration_ = 3.17

		local var_101_0 = {
			ja = 2.033,
			ko = 2.966,
			zh = 3.166,
			en = 2.4
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play114121026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = "1067ui_story"

			if arg_101_1.actors_[var_104_0] == nil then
				local var_104_1 = Asset.Load("Char/" .. "1067ui_story")

				if not isNil(var_104_1) then
					local var_104_2 = Object.Instantiate(Asset.Load("Char/" .. "1067ui_story"), arg_101_1.stage_.transform)

					var_104_2.name = var_104_0
					var_104_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_101_1.actors_[var_104_0] = var_104_2

					local var_104_3 = var_104_2:GetComponentInChildren(typeof(CharacterEffect))

					var_104_3.enabled = true

					local var_104_4 = GameObjectTools.GetOrAddComponent(var_104_2, typeof(DynamicBoneHelper))

					if var_104_4 then
						var_104_4:EnableDynamicBone(false)
					end

					arg_101_1:ShowWeapon(var_104_3.transform, false)

					arg_101_1.var_[var_104_0 .. "Animator"] = var_104_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_101_1.var_[var_104_0 .. "Animator"].applyRootMotion = true
					arg_101_1.var_[var_104_0 .. "LipSync"] = var_104_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_104_5 = arg_101_1.actors_["1067ui_story"].transform
			local var_104_6 = 0

			if var_104_6 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.var_.moveOldPos1067ui_story = var_104_5.localPosition
			end

			local var_104_7 = 0.001

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_7 then
				local var_104_8 = (arg_101_1.time_ - var_104_6) / var_104_7
				local var_104_9 = Vector3.New(-0.7, -1.06, -6.2)

				var_104_5.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1067ui_story, var_104_9, var_104_8)

				local var_104_10 = manager.ui.mainCamera.transform.position - var_104_5.position

				var_104_5.forward = Vector3.New(var_104_10.x, var_104_10.y, var_104_10.z)

				local var_104_11 = var_104_5.localEulerAngles

				var_104_11.z = 0
				var_104_11.x = 0
				var_104_5.localEulerAngles = var_104_11
			end

			if arg_101_1.time_ >= var_104_6 + var_104_7 and arg_101_1.time_ < var_104_6 + var_104_7 + arg_104_0 then
				var_104_5.localPosition = Vector3.New(-0.7, -1.06, -6.2)

				local var_104_12 = manager.ui.mainCamera.transform.position - var_104_5.position

				var_104_5.forward = Vector3.New(var_104_12.x, var_104_12.y, var_104_12.z)

				local var_104_13 = var_104_5.localEulerAngles

				var_104_13.z = 0
				var_104_13.x = 0
				var_104_5.localEulerAngles = var_104_13
			end

			local var_104_14 = 0

			if var_104_14 < arg_101_1.time_ and arg_101_1.time_ <= var_104_14 + arg_104_0 then
				arg_101_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/story1067/story1067action/1067action1_1")
			end

			local var_104_15 = 0

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1:PlayTimeline("1067ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_104_16 = arg_101_1.actors_["1067ui_story"]
			local var_104_17 = 0

			if var_104_17 < arg_101_1.time_ and arg_101_1.time_ <= var_104_17 + arg_104_0 and not isNil(var_104_16) and arg_101_1.var_.characterEffect1067ui_story == nil then
				arg_101_1.var_.characterEffect1067ui_story = var_104_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_18 = 0.2

			if var_104_17 <= arg_101_1.time_ and arg_101_1.time_ < var_104_17 + var_104_18 and not isNil(var_104_16) then
				local var_104_19 = (arg_101_1.time_ - var_104_17) / var_104_18

				if arg_101_1.var_.characterEffect1067ui_story and not isNil(var_104_16) then
					arg_101_1.var_.characterEffect1067ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= var_104_17 + var_104_18 and arg_101_1.time_ < var_104_17 + var_104_18 + arg_104_0 and not isNil(var_104_16) and arg_101_1.var_.characterEffect1067ui_story then
				arg_101_1.var_.characterEffect1067ui_story.fillFlat = false
			end

			local var_104_20 = 0
			local var_104_21 = 0.325

			if var_104_20 < arg_101_1.time_ and arg_101_1.time_ <= var_104_20 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_22 = arg_101_1:FormatText(StoryNameCfg[206].name)

				arg_101_1.leftNameTxt_.text = var_104_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_23 = arg_101_1:GetWordFromCfg(114121025)
				local var_104_24 = arg_101_1:FormatText(var_104_23.content)

				arg_101_1.text_.text = var_104_24

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_25 = 13
				local var_104_26 = utf8.len(var_104_24)
				local var_104_27 = var_104_25 <= 0 and var_104_21 or var_104_21 * (var_104_26 / var_104_25)

				if var_104_27 > 0 and var_104_21 < var_104_27 then
					arg_101_1.talkMaxDuration = var_104_27

					if var_104_27 + var_104_20 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_27 + var_104_20
					end
				end

				arg_101_1.text_.text = var_104_24
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121025", "story_v_out_114121.awb") ~= 0 then
					local var_104_28 = manager.audio:GetVoiceLength("story_v_out_114121", "114121025", "story_v_out_114121.awb") / 1000

					if var_104_28 + var_104_20 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_28 + var_104_20
					end

					if var_104_23.prefab_name ~= "" and arg_101_1.actors_[var_104_23.prefab_name] ~= nil then
						local var_104_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_23.prefab_name].transform, "story_v_out_114121", "114121025", "story_v_out_114121.awb")

						arg_101_1:RecordAudio("114121025", var_104_29)
						arg_101_1:RecordAudio("114121025", var_104_29)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_114121", "114121025", "story_v_out_114121.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_114121", "114121025", "story_v_out_114121.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_30 = math.max(var_104_21, arg_101_1.talkMaxDuration)

			if var_104_20 <= arg_101_1.time_ and arg_101_1.time_ < var_104_20 + var_104_30 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_20) / var_104_30

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_20 + var_104_30 and arg_101_1.time_ < var_104_20 + var_104_30 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play114121026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 114121026
		arg_105_1.duration_ = 10.9

		local var_105_0 = {
			ja = 9.166,
			ko = 8.933,
			zh = 10.9,
			en = 9.7
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
				arg_105_0:Play114121027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["1042ui_story"].transform
			local var_108_1 = 0

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos1042ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0.7, -1.06, -6.2)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1042ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = 0

			if var_108_9 < arg_105_1.time_ and arg_105_1.time_ <= var_108_9 + arg_108_0 then
				arg_105_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			local var_108_10 = 0

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 then
				arg_105_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_108_11 = arg_105_1.actors_["1042ui_story"]
			local var_108_12 = 0

			if var_108_12 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 and not isNil(var_108_11) and arg_105_1.var_.characterEffect1042ui_story == nil then
				arg_105_1.var_.characterEffect1042ui_story = var_108_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_13 = 0.2

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_13 and not isNil(var_108_11) then
				local var_108_14 = (arg_105_1.time_ - var_108_12) / var_108_13

				if arg_105_1.var_.characterEffect1042ui_story and not isNil(var_108_11) then
					arg_105_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= var_108_12 + var_108_13 and arg_105_1.time_ < var_108_12 + var_108_13 + arg_108_0 and not isNil(var_108_11) and arg_105_1.var_.characterEffect1042ui_story then
				arg_105_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_108_15 = arg_105_1.actors_["1067ui_story"]
			local var_108_16 = 0

			if var_108_16 < arg_105_1.time_ and arg_105_1.time_ <= var_108_16 + arg_108_0 and not isNil(var_108_15) and arg_105_1.var_.characterEffect1067ui_story == nil then
				arg_105_1.var_.characterEffect1067ui_story = var_108_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_17 = 0.2

			if var_108_16 <= arg_105_1.time_ and arg_105_1.time_ < var_108_16 + var_108_17 and not isNil(var_108_15) then
				local var_108_18 = (arg_105_1.time_ - var_108_16) / var_108_17

				if arg_105_1.var_.characterEffect1067ui_story and not isNil(var_108_15) then
					local var_108_19 = Mathf.Lerp(0, 0.5, var_108_18)

					arg_105_1.var_.characterEffect1067ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1067ui_story.fillRatio = var_108_19
				end
			end

			if arg_105_1.time_ >= var_108_16 + var_108_17 and arg_105_1.time_ < var_108_16 + var_108_17 + arg_108_0 and not isNil(var_108_15) and arg_105_1.var_.characterEffect1067ui_story then
				local var_108_20 = 0.5

				arg_105_1.var_.characterEffect1067ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1067ui_story.fillRatio = var_108_20
			end

			local var_108_21 = 0
			local var_108_22 = 1.025

			if var_108_21 < arg_105_1.time_ and arg_105_1.time_ <= var_108_21 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				local var_108_23 = arg_105_1:FormatText(StoryNameCfg[205].name)

				arg_105_1.leftNameTxt_.text = var_108_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_24 = arg_105_1:GetWordFromCfg(114121026)
				local var_108_25 = arg_105_1:FormatText(var_108_24.content)

				arg_105_1.text_.text = var_108_25

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_26 = 41
				local var_108_27 = utf8.len(var_108_25)
				local var_108_28 = var_108_26 <= 0 and var_108_22 or var_108_22 * (var_108_27 / var_108_26)

				if var_108_28 > 0 and var_108_22 < var_108_28 then
					arg_105_1.talkMaxDuration = var_108_28

					if var_108_28 + var_108_21 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_28 + var_108_21
					end
				end

				arg_105_1.text_.text = var_108_25
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121026", "story_v_out_114121.awb") ~= 0 then
					local var_108_29 = manager.audio:GetVoiceLength("story_v_out_114121", "114121026", "story_v_out_114121.awb") / 1000

					if var_108_29 + var_108_21 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_29 + var_108_21
					end

					if var_108_24.prefab_name ~= "" and arg_105_1.actors_[var_108_24.prefab_name] ~= nil then
						local var_108_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_24.prefab_name].transform, "story_v_out_114121", "114121026", "story_v_out_114121.awb")

						arg_105_1:RecordAudio("114121026", var_108_30)
						arg_105_1:RecordAudio("114121026", var_108_30)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_114121", "114121026", "story_v_out_114121.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_114121", "114121026", "story_v_out_114121.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_31 = math.max(var_108_22, arg_105_1.talkMaxDuration)

			if var_108_21 <= arg_105_1.time_ and arg_105_1.time_ < var_108_21 + var_108_31 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_21) / var_108_31

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_21 + var_108_31 and arg_105_1.time_ < var_108_21 + var_108_31 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play114121027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 114121027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play114121028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = arg_109_1.actors_["1042ui_story"].transform
			local var_112_1 = 0

			if var_112_1 < arg_109_1.time_ and arg_109_1.time_ <= var_112_1 + arg_112_0 then
				arg_109_1.var_.moveOldPos1042ui_story = var_112_0.localPosition
			end

			local var_112_2 = 0.001

			if var_112_1 <= arg_109_1.time_ and arg_109_1.time_ < var_112_1 + var_112_2 then
				local var_112_3 = (arg_109_1.time_ - var_112_1) / var_112_2
				local var_112_4 = Vector3.New(0, 100, 0)

				var_112_0.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1042ui_story, var_112_4, var_112_3)

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

			local var_112_9 = arg_109_1.actors_["1067ui_story"].transform
			local var_112_10 = 0

			if var_112_10 < arg_109_1.time_ and arg_109_1.time_ <= var_112_10 + arg_112_0 then
				arg_109_1.var_.moveOldPos1067ui_story = var_112_9.localPosition
			end

			local var_112_11 = 0.001

			if var_112_10 <= arg_109_1.time_ and arg_109_1.time_ < var_112_10 + var_112_11 then
				local var_112_12 = (arg_109_1.time_ - var_112_10) / var_112_11
				local var_112_13 = Vector3.New(0, 100, 0)

				var_112_9.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1067ui_story, var_112_13, var_112_12)

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

			local var_112_18 = 0
			local var_112_19 = 0.7

			if var_112_18 < arg_109_1.time_ and arg_109_1.time_ <= var_112_18 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_20 = arg_109_1:GetWordFromCfg(114121027)
				local var_112_21 = arg_109_1:FormatText(var_112_20.content)

				arg_109_1.text_.text = var_112_21

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_22 = 28
				local var_112_23 = utf8.len(var_112_21)
				local var_112_24 = var_112_22 <= 0 and var_112_19 or var_112_19 * (var_112_23 / var_112_22)

				if var_112_24 > 0 and var_112_19 < var_112_24 then
					arg_109_1.talkMaxDuration = var_112_24

					if var_112_24 + var_112_18 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_24 + var_112_18
					end
				end

				arg_109_1.text_.text = var_112_21
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_25 = math.max(var_112_19, arg_109_1.talkMaxDuration)

			if var_112_18 <= arg_109_1.time_ and arg_109_1.time_ < var_112_18 + var_112_25 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_18) / var_112_25

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_18 + var_112_25 and arg_109_1.time_ < var_112_18 + var_112_25 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1067ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play114121028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 114121028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play114121029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			local var_116_0 = 0
			local var_116_1 = 1.225

			if var_116_0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_0 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, false)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_2 = arg_113_1:GetWordFromCfg(114121028)
				local var_116_3 = arg_113_1:FormatText(var_116_2.content)

				arg_113_1.text_.text = var_116_3

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_4 = 49
				local var_116_5 = utf8.len(var_116_3)
				local var_116_6 = var_116_4 <= 0 and var_116_1 or var_116_1 * (var_116_5 / var_116_4)

				if var_116_6 > 0 and var_116_1 < var_116_6 then
					arg_113_1.talkMaxDuration = var_116_6

					if var_116_6 + var_116_0 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_6 + var_116_0
					end
				end

				arg_113_1.text_.text = var_116_3
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_7 = math.max(var_116_1, arg_113_1.talkMaxDuration)

			if var_116_0 <= arg_113_1.time_ and arg_113_1.time_ < var_116_0 + var_116_7 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_0) / var_116_7

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_0 + var_116_7 and arg_113_1.time_ < var_116_0 + var_116_7 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play114121029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 114121029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play114121030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0
			local var_120_1 = 1.325

			if var_120_0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_2 = arg_117_1:GetWordFromCfg(114121029)
				local var_120_3 = arg_117_1:FormatText(var_120_2.content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 53
				local var_120_5 = utf8.len(var_120_3)
				local var_120_6 = var_120_4 <= 0 and var_120_1 or var_120_1 * (var_120_5 / var_120_4)

				if var_120_6 > 0 and var_120_1 < var_120_6 then
					arg_117_1.talkMaxDuration = var_120_6

					if var_120_6 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_7 and arg_117_1.time_ < var_120_0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play114121030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 114121030
		arg_121_1.duration_ = 6.73

		local var_121_0 = {
			ja = 3.5,
			ko = 6.733,
			zh = 6.266,
			en = 5.9
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
				arg_121_0:Play114121031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			local var_124_0 = arg_121_1.actors_["1042ui_story"].transform
			local var_124_1 = 0

			if var_124_1 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.var_.moveOldPos1042ui_story = var_124_0.localPosition
			end

			local var_124_2 = 0.001

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_2 then
				local var_124_3 = (arg_121_1.time_ - var_124_1) / var_124_2
				local var_124_4 = Vector3.New(0, -1.06, -6.2)

				var_124_0.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1042ui_story, var_124_4, var_124_3)

				local var_124_5 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_5.x, var_124_5.y, var_124_5.z)

				local var_124_6 = var_124_0.localEulerAngles

				var_124_6.z = 0
				var_124_6.x = 0
				var_124_0.localEulerAngles = var_124_6
			end

			if arg_121_1.time_ >= var_124_1 + var_124_2 and arg_121_1.time_ < var_124_1 + var_124_2 + arg_124_0 then
				var_124_0.localPosition = Vector3.New(0, -1.06, -6.2)

				local var_124_7 = manager.ui.mainCamera.transform.position - var_124_0.position

				var_124_0.forward = Vector3.New(var_124_7.x, var_124_7.y, var_124_7.z)

				local var_124_8 = var_124_0.localEulerAngles

				var_124_8.z = 0
				var_124_8.x = 0
				var_124_0.localEulerAngles = var_124_8
			end

			local var_124_9 = 0

			if var_124_9 < arg_121_1.time_ and arg_121_1.time_ <= var_124_9 + arg_124_0 then
				arg_121_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			local var_124_10 = 0

			if var_124_10 < arg_121_1.time_ and arg_121_1.time_ <= var_124_10 + arg_124_0 then
				arg_121_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_124_11 = arg_121_1.actors_["1042ui_story"]
			local var_124_12 = 0

			if var_124_12 < arg_121_1.time_ and arg_121_1.time_ <= var_124_12 + arg_124_0 and not isNil(var_124_11) and arg_121_1.var_.characterEffect1042ui_story == nil then
				arg_121_1.var_.characterEffect1042ui_story = var_124_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_13 = 0.2

			if var_124_12 <= arg_121_1.time_ and arg_121_1.time_ < var_124_12 + var_124_13 and not isNil(var_124_11) then
				local var_124_14 = (arg_121_1.time_ - var_124_12) / var_124_13

				if arg_121_1.var_.characterEffect1042ui_story and not isNil(var_124_11) then
					arg_121_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= var_124_12 + var_124_13 and arg_121_1.time_ < var_124_12 + var_124_13 + arg_124_0 and not isNil(var_124_11) and arg_121_1.var_.characterEffect1042ui_story then
				arg_121_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_124_15 = 0
			local var_124_16 = 0.5

			if var_124_15 < arg_121_1.time_ and arg_121_1.time_ <= var_124_15 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				local var_124_17 = arg_121_1:FormatText(StoryNameCfg[205].name)

				arg_121_1.leftNameTxt_.text = var_124_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_18 = arg_121_1:GetWordFromCfg(114121030)
				local var_124_19 = arg_121_1:FormatText(var_124_18.content)

				arg_121_1.text_.text = var_124_19

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_20 = 20
				local var_124_21 = utf8.len(var_124_19)
				local var_124_22 = var_124_20 <= 0 and var_124_16 or var_124_16 * (var_124_21 / var_124_20)

				if var_124_22 > 0 and var_124_16 < var_124_22 then
					arg_121_1.talkMaxDuration = var_124_22

					if var_124_22 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_22 + var_124_15
					end
				end

				arg_121_1.text_.text = var_124_19
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121030", "story_v_out_114121.awb") ~= 0 then
					local var_124_23 = manager.audio:GetVoiceLength("story_v_out_114121", "114121030", "story_v_out_114121.awb") / 1000

					if var_124_23 + var_124_15 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_23 + var_124_15
					end

					if var_124_18.prefab_name ~= "" and arg_121_1.actors_[var_124_18.prefab_name] ~= nil then
						local var_124_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_18.prefab_name].transform, "story_v_out_114121", "114121030", "story_v_out_114121.awb")

						arg_121_1:RecordAudio("114121030", var_124_24)
						arg_121_1:RecordAudio("114121030", var_124_24)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_114121", "114121030", "story_v_out_114121.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_114121", "114121030", "story_v_out_114121.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_25 = math.max(var_124_16, arg_121_1.talkMaxDuration)

			if var_124_15 <= arg_121_1.time_ and arg_121_1.time_ < var_124_15 + var_124_25 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_15) / var_124_25

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_15 + var_124_25 and arg_121_1.time_ < var_124_15 + var_124_25 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play114121031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 114121031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play114121032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			local var_128_0 = arg_125_1.actors_["1042ui_story"].transform
			local var_128_1 = 0

			if var_128_1 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.var_.moveOldPos1042ui_story = var_128_0.localPosition
			end

			local var_128_2 = 0.001

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_2 then
				local var_128_3 = (arg_125_1.time_ - var_128_1) / var_128_2
				local var_128_4 = Vector3.New(0, 100, 0)

				var_128_0.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1042ui_story, var_128_4, var_128_3)

				local var_128_5 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_5.x, var_128_5.y, var_128_5.z)

				local var_128_6 = var_128_0.localEulerAngles

				var_128_6.z = 0
				var_128_6.x = 0
				var_128_0.localEulerAngles = var_128_6
			end

			if arg_125_1.time_ >= var_128_1 + var_128_2 and arg_125_1.time_ < var_128_1 + var_128_2 + arg_128_0 then
				var_128_0.localPosition = Vector3.New(0, 100, 0)

				local var_128_7 = manager.ui.mainCamera.transform.position - var_128_0.position

				var_128_0.forward = Vector3.New(var_128_7.x, var_128_7.y, var_128_7.z)

				local var_128_8 = var_128_0.localEulerAngles

				var_128_8.z = 0
				var_128_8.x = 0
				var_128_0.localEulerAngles = var_128_8
			end

			local var_128_9 = 0
			local var_128_10 = 1.125

			if var_128_9 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_11 = arg_125_1:GetWordFromCfg(114121031)
				local var_128_12 = arg_125_1:FormatText(var_128_11.content)

				arg_125_1.text_.text = var_128_12

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 45
				local var_128_14 = utf8.len(var_128_12)
				local var_128_15 = var_128_13 <= 0 and var_128_10 or var_128_10 * (var_128_14 / var_128_13)

				if var_128_15 > 0 and var_128_10 < var_128_15 then
					arg_125_1.talkMaxDuration = var_128_15

					if var_128_15 + var_128_9 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_15 + var_128_9
					end
				end

				arg_125_1.text_.text = var_128_12
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_10, arg_125_1.talkMaxDuration)

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_9) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_9 + var_128_16 and arg_125_1.time_ < var_128_9 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play114121032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 114121032
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play114121033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			local var_132_0 = 0
			local var_132_1 = 0.775

			if var_132_0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_0 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, false)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_2 = arg_129_1:GetWordFromCfg(114121032)
				local var_132_3 = arg_129_1:FormatText(var_132_2.content)

				arg_129_1.text_.text = var_132_3

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_4 = 31
				local var_132_5 = utf8.len(var_132_3)
				local var_132_6 = var_132_4 <= 0 and var_132_1 or var_132_1 * (var_132_5 / var_132_4)

				if var_132_6 > 0 and var_132_1 < var_132_6 then
					arg_129_1.talkMaxDuration = var_132_6

					if var_132_6 + var_132_0 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_6 + var_132_0
					end
				end

				arg_129_1.text_.text = var_132_3
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_7 = math.max(var_132_1, arg_129_1.talkMaxDuration)

			if var_132_0 <= arg_129_1.time_ and arg_129_1.time_ < var_132_0 + var_132_7 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_0) / var_132_7

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_0 + var_132_7 and arg_129_1.time_ < var_132_0 + var_132_7 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {}

		arg_129_1:InitPlayNodeList()
	end,
	Play114121033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 114121033
		arg_133_1.duration_ = 7.03

		local var_133_0 = {
			ja = 7.033,
			ko = 6.3,
			zh = 6.6,
			en = 6.2
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
				arg_133_0:Play114121034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			local var_136_0 = "F05_1"

			if arg_133_1.bgs_[var_136_0] == nil then
				local var_136_1 = Object.Instantiate(arg_133_1.paintGo_)

				var_136_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_136_0)
				var_136_1.name = var_136_0
				var_136_1.transform.parent = arg_133_1.stage_.transform
				var_136_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.bgs_[var_136_0] = var_136_1
			end

			local var_136_2 = 2

			if var_136_2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_2 + arg_136_0 then
				local var_136_3 = manager.ui.mainCamera.transform.localPosition
				local var_136_4 = Vector3.New(0, 0, 10) + Vector3.New(var_136_3.x, var_136_3.y, 0)
				local var_136_5 = arg_133_1.bgs_.F05_1

				var_136_5.transform.localPosition = var_136_4
				var_136_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_6 = var_136_5:GetComponent("SpriteRenderer")

				if var_136_6 and var_136_6.sprite then
					local var_136_7 = (var_136_5.transform.localPosition - var_136_3).z
					local var_136_8 = manager.ui.mainCameraCom_
					local var_136_9 = 2 * var_136_7 * Mathf.Tan(var_136_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_136_10 = var_136_9 * var_136_8.aspect
					local var_136_11 = var_136_6.sprite.bounds.size.x
					local var_136_12 = var_136_6.sprite.bounds.size.y
					local var_136_13 = var_136_10 / var_136_11
					local var_136_14 = var_136_9 / var_136_12
					local var_136_15 = var_136_14 < var_136_13 and var_136_13 or var_136_14

					var_136_5.transform.localScale = Vector3.New(var_136_15, var_136_15, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "F05_1" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_136_16 = 0

			if var_136_16 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_17 = 2

			if var_136_16 <= arg_133_1.time_ and arg_133_1.time_ < var_136_16 + var_136_17 then
				local var_136_18 = (arg_133_1.time_ - var_136_16) / var_136_17
				local var_136_19 = Color.New(0, 0, 0)

				var_136_19.a = Mathf.Lerp(0, 1, var_136_18)
				arg_133_1.mask_.color = var_136_19
			end

			if arg_133_1.time_ >= var_136_16 + var_136_17 and arg_133_1.time_ < var_136_16 + var_136_17 + arg_136_0 then
				local var_136_20 = Color.New(0, 0, 0)

				var_136_20.a = 1
				arg_133_1.mask_.color = var_136_20
			end

			local var_136_21 = 2

			if var_136_21 < arg_133_1.time_ and arg_133_1.time_ <= var_136_21 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_22 = 2

			if var_136_21 <= arg_133_1.time_ and arg_133_1.time_ < var_136_21 + var_136_22 then
				local var_136_23 = (arg_133_1.time_ - var_136_21) / var_136_22
				local var_136_24 = Color.New(0, 0, 0)

				var_136_24.a = Mathf.Lerp(1, 0, var_136_23)
				arg_133_1.mask_.color = var_136_24
			end

			if arg_133_1.time_ >= var_136_21 + var_136_22 and arg_133_1.time_ < var_136_21 + var_136_22 + arg_136_0 then
				local var_136_25 = Color.New(0, 0, 0)
				local var_136_26 = 0

				arg_133_1.mask_.enabled = false
				var_136_25.a = var_136_26
				arg_133_1.mask_.color = var_136_25
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_27 = 4
			local var_136_28 = 0.175

			if var_136_27 < arg_133_1.time_ and arg_133_1.time_ <= var_136_27 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_29 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_29:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, true)

				local var_136_30 = arg_133_1:FormatText(StoryNameCfg[212].name)

				arg_133_1.leftNameTxt_.text = var_136_30

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, true)
				arg_133_1.iconController_:SetSelectedState("hero")

				arg_133_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_133_1.callingController_:SetSelectedState("normal")

				arg_133_1.keyicon_.color = Color.New(1, 1, 1)
				arg_133_1.icon_.color = Color.New(1, 1, 1)

				local var_136_31 = arg_133_1:GetWordFromCfg(114121033)
				local var_136_32 = arg_133_1:FormatText(var_136_31.content)

				arg_133_1.text_.text = var_136_32

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_33 = 7
				local var_136_34 = utf8.len(var_136_32)
				local var_136_35 = var_136_33 <= 0 and var_136_28 or var_136_28 * (var_136_34 / var_136_33)

				if var_136_35 > 0 and var_136_28 < var_136_35 then
					arg_133_1.talkMaxDuration = var_136_35
					var_136_27 = var_136_27 + 0.3

					if var_136_35 + var_136_27 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_35 + var_136_27
					end
				end

				arg_133_1.text_.text = var_136_32
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121033", "story_v_out_114121.awb") ~= 0 then
					local var_136_36 = manager.audio:GetVoiceLength("story_v_out_114121", "114121033", "story_v_out_114121.awb") / 1000

					if var_136_36 + var_136_27 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_36 + var_136_27
					end

					if var_136_31.prefab_name ~= "" and arg_133_1.actors_[var_136_31.prefab_name] ~= nil then
						local var_136_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_31.prefab_name].transform, "story_v_out_114121", "114121033", "story_v_out_114121.awb")

						arg_133_1:RecordAudio("114121033", var_136_37)
						arg_133_1:RecordAudio("114121033", var_136_37)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_114121", "114121033", "story_v_out_114121.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_114121", "114121033", "story_v_out_114121.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_38 = var_136_27 + 0.3
			local var_136_39 = math.max(var_136_28, arg_133_1.talkMaxDuration)

			if var_136_38 <= arg_133_1.time_ and arg_133_1.time_ < var_136_38 + var_136_39 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_38) / var_136_39

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_38 + var_136_39 and arg_133_1.time_ < var_136_38 + var_136_39 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {}

		arg_133_1:InitPlayNodeList()
	end,
	Play114121034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 114121034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play114121035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = 0
			local var_142_1 = 1.1

			if var_142_0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_0 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_2 = arg_139_1:GetWordFromCfg(114121034)
				local var_142_3 = arg_139_1:FormatText(var_142_2.content)

				arg_139_1.text_.text = var_142_3

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_4 = 44
				local var_142_5 = utf8.len(var_142_3)
				local var_142_6 = var_142_4 <= 0 and var_142_1 or var_142_1 * (var_142_5 / var_142_4)

				if var_142_6 > 0 and var_142_1 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_0 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_0
					end
				end

				arg_139_1.text_.text = var_142_3
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_7 = math.max(var_142_1, arg_139_1.talkMaxDuration)

			if var_142_0 <= arg_139_1.time_ and arg_139_1.time_ < var_142_0 + var_142_7 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_0) / var_142_7

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_0 + var_142_7 and arg_139_1.time_ < var_142_0 + var_142_7 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play114121035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 114121035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play114121036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0
			local var_146_1 = 0.375

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_2 = arg_143_1:FormatText(StoryNameCfg[7].name)

				arg_143_1.leftNameTxt_.text = var_146_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(114121035)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 15
				local var_146_6 = utf8.len(var_146_4)
				local var_146_7 = var_146_5 <= 0 and var_146_1 or var_146_1 * (var_146_6 / var_146_5)

				if var_146_7 > 0 and var_146_1 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_0 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_0
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_8 = math.max(var_146_1, arg_143_1.talkMaxDuration)

			if var_146_0 <= arg_143_1.time_ and arg_143_1.time_ < var_146_0 + var_146_8 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_0) / var_146_8

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_0 + var_146_8 and arg_143_1.time_ < var_146_0 + var_146_8 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play114121036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 114121036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play114121037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = 0
			local var_150_1 = 0.4

			if var_150_0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_0 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_2 = arg_147_1:FormatText(StoryNameCfg[7].name)

				arg_147_1.leftNameTxt_.text = var_150_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, true)
				arg_147_1.iconController_:SetSelectedState("hero")

				arg_147_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_147_1.callingController_:SetSelectedState("normal")

				arg_147_1.keyicon_.color = Color.New(1, 1, 1)
				arg_147_1.icon_.color = Color.New(1, 1, 1)

				local var_150_3 = arg_147_1:GetWordFromCfg(114121036)
				local var_150_4 = arg_147_1:FormatText(var_150_3.content)

				arg_147_1.text_.text = var_150_4

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 16
				local var_150_6 = utf8.len(var_150_4)
				local var_150_7 = var_150_5 <= 0 and var_150_1 or var_150_1 * (var_150_6 / var_150_5)

				if var_150_7 > 0 and var_150_1 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_0 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_0
					end
				end

				arg_147_1.text_.text = var_150_4
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_8 = math.max(var_150_1, arg_147_1.talkMaxDuration)

			if var_150_0 <= arg_147_1.time_ and arg_147_1.time_ < var_150_0 + var_150_8 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_0) / var_150_8

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_0 + var_150_8 and arg_147_1.time_ < var_150_0 + var_150_8 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play114121037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 114121037
		arg_151_1.duration_ = 3.6

		local var_151_0 = {
			ja = 3.533,
			ko = 1.866,
			zh = 3.6,
			en = 2.733
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play114121038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0
			local var_154_1 = 0.15

			if var_154_0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_2 = arg_151_1:FormatText(StoryNameCfg[212].name)

				arg_151_1.leftNameTxt_.text = var_154_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:GetWordFromCfg(114121037)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 6
				local var_154_6 = utf8.len(var_154_4)
				local var_154_7 = var_154_5 <= 0 and var_154_1 or var_154_1 * (var_154_6 / var_154_5)

				if var_154_7 > 0 and var_154_1 < var_154_7 then
					arg_151_1.talkMaxDuration = var_154_7

					if var_154_7 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_0
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121037", "story_v_out_114121.awb") ~= 0 then
					local var_154_8 = manager.audio:GetVoiceLength("story_v_out_114121", "114121037", "story_v_out_114121.awb") / 1000

					if var_154_8 + var_154_0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_8 + var_154_0
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_114121", "114121037", "story_v_out_114121.awb")

						arg_151_1:RecordAudio("114121037", var_154_9)
						arg_151_1:RecordAudio("114121037", var_154_9)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_114121", "114121037", "story_v_out_114121.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_114121", "114121037", "story_v_out_114121.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_1, arg_151_1.talkMaxDuration)

			if var_154_0 <= arg_151_1.time_ and arg_151_1.time_ < var_154_0 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_0) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_0 + var_154_10 and arg_151_1.time_ < var_154_0 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play114121038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 114121038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play114121039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = 0
			local var_158_1 = 0.7

			if var_158_0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_2 = arg_155_1:GetWordFromCfg(114121038)
				local var_158_3 = arg_155_1:FormatText(var_158_2.content)

				arg_155_1.text_.text = var_158_3

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 28
				local var_158_5 = utf8.len(var_158_3)
				local var_158_6 = var_158_4 <= 0 and var_158_1 or var_158_1 * (var_158_5 / var_158_4)

				if var_158_6 > 0 and var_158_1 < var_158_6 then
					arg_155_1.talkMaxDuration = var_158_6

					if var_158_6 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_3
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_7 and arg_155_1.time_ < var_158_0 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play114121039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 114121039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play114121040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.475

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_2 = arg_159_1:GetWordFromCfg(114121039)
				local var_162_3 = arg_159_1:FormatText(var_162_2.content)

				arg_159_1.text_.text = var_162_3

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 19
				local var_162_5 = utf8.len(var_162_3)
				local var_162_6 = var_162_4 <= 0 and var_162_1 or var_162_1 * (var_162_5 / var_162_4)

				if var_162_6 > 0 and var_162_1 < var_162_6 then
					arg_159_1.talkMaxDuration = var_162_6

					if var_162_6 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_6 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_3
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_7 and arg_159_1.time_ < var_162_0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play114121040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 114121040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play114121041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 0
			local var_166_1 = 0.8

			if var_166_0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_2 = arg_163_1:GetWordFromCfg(114121040)
				local var_166_3 = arg_163_1:FormatText(var_166_2.content)

				arg_163_1.text_.text = var_166_3

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 32
				local var_166_5 = utf8.len(var_166_3)
				local var_166_6 = var_166_4 <= 0 and var_166_1 or var_166_1 * (var_166_5 / var_166_4)

				if var_166_6 > 0 and var_166_1 < var_166_6 then
					arg_163_1.talkMaxDuration = var_166_6

					if var_166_6 + var_166_0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_6 + var_166_0
					end
				end

				arg_163_1.text_.text = var_166_3
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_1, arg_163_1.talkMaxDuration)

			if var_166_0 <= arg_163_1.time_ and arg_163_1.time_ < var_166_0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_0 + var_166_7 and arg_163_1.time_ < var_166_0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play114121041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 114121041
		arg_167_1.duration_ = 6.1

		local var_167_0 = {
			ja = 5.2,
			ko = 6.1,
			zh = 5.233,
			en = 5.7
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play114121042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = "10006ui_story"

			if arg_167_1.actors_[var_170_0] == nil then
				local var_170_1 = Asset.Load("Char/" .. "10006ui_story")

				if not isNil(var_170_1) then
					local var_170_2 = Object.Instantiate(Asset.Load("Char/" .. "10006ui_story"), arg_167_1.stage_.transform)

					var_170_2.name = var_170_0
					var_170_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_167_1.actors_[var_170_0] = var_170_2

					local var_170_3 = var_170_2:GetComponentInChildren(typeof(CharacterEffect))

					var_170_3.enabled = true

					local var_170_4 = GameObjectTools.GetOrAddComponent(var_170_2, typeof(DynamicBoneHelper))

					if var_170_4 then
						var_170_4:EnableDynamicBone(false)
					end

					arg_167_1:ShowWeapon(var_170_3.transform, false)

					arg_167_1.var_[var_170_0 .. "Animator"] = var_170_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_167_1.var_[var_170_0 .. "Animator"].applyRootMotion = true
					arg_167_1.var_[var_170_0 .. "LipSync"] = var_170_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_170_5 = arg_167_1.actors_["10006ui_story"].transform
			local var_170_6 = 0

			if var_170_6 < arg_167_1.time_ and arg_167_1.time_ <= var_170_6 + arg_170_0 then
				arg_167_1.var_.moveOldPos10006ui_story = var_170_5.localPosition
			end

			local var_170_7 = 0.001

			if var_170_6 <= arg_167_1.time_ and arg_167_1.time_ < var_170_6 + var_170_7 then
				local var_170_8 = (arg_167_1.time_ - var_170_6) / var_170_7
				local var_170_9 = Vector3.New(0, -0.98, -5.65)

				var_170_5.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10006ui_story, var_170_9, var_170_8)

				local var_170_10 = manager.ui.mainCamera.transform.position - var_170_5.position

				var_170_5.forward = Vector3.New(var_170_10.x, var_170_10.y, var_170_10.z)

				local var_170_11 = var_170_5.localEulerAngles

				var_170_11.z = 0
				var_170_11.x = 0
				var_170_5.localEulerAngles = var_170_11
			end

			if arg_167_1.time_ >= var_170_6 + var_170_7 and arg_167_1.time_ < var_170_6 + var_170_7 + arg_170_0 then
				var_170_5.localPosition = Vector3.New(0, -0.98, -5.65)

				local var_170_12 = manager.ui.mainCamera.transform.position - var_170_5.position

				var_170_5.forward = Vector3.New(var_170_12.x, var_170_12.y, var_170_12.z)

				local var_170_13 = var_170_5.localEulerAngles

				var_170_13.z = 0
				var_170_13.x = 0
				var_170_5.localEulerAngles = var_170_13
			end

			local var_170_14 = 0

			if var_170_14 < arg_167_1.time_ and arg_167_1.time_ <= var_170_14 + arg_170_0 then
				arg_167_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/story10006/story10006action/10006action5_1")
			end

			local var_170_15 = 0

			if var_170_15 < arg_167_1.time_ and arg_167_1.time_ <= var_170_15 + arg_170_0 then
				arg_167_1:PlayTimeline("10006ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_170_16 = arg_167_1.actors_["10006ui_story"]
			local var_170_17 = 0

			if var_170_17 < arg_167_1.time_ and arg_167_1.time_ <= var_170_17 + arg_170_0 and not isNil(var_170_16) and arg_167_1.var_.characterEffect10006ui_story == nil then
				arg_167_1.var_.characterEffect10006ui_story = var_170_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_18 = 0.2

			if var_170_17 <= arg_167_1.time_ and arg_167_1.time_ < var_170_17 + var_170_18 and not isNil(var_170_16) then
				local var_170_19 = (arg_167_1.time_ - var_170_17) / var_170_18

				if arg_167_1.var_.characterEffect10006ui_story and not isNil(var_170_16) then
					arg_167_1.var_.characterEffect10006ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_17 + var_170_18 and arg_167_1.time_ < var_170_17 + var_170_18 + arg_170_0 and not isNil(var_170_16) and arg_167_1.var_.characterEffect10006ui_story then
				arg_167_1.var_.characterEffect10006ui_story.fillFlat = false
			end

			local var_170_20 = 0
			local var_170_21 = 0.6

			if var_170_20 < arg_167_1.time_ and arg_167_1.time_ <= var_170_20 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_22 = arg_167_1:FormatText(StoryNameCfg[212].name)

				arg_167_1.leftNameTxt_.text = var_170_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_23 = arg_167_1:GetWordFromCfg(114121041)
				local var_170_24 = arg_167_1:FormatText(var_170_23.content)

				arg_167_1.text_.text = var_170_24

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_25 = 24
				local var_170_26 = utf8.len(var_170_24)
				local var_170_27 = var_170_25 <= 0 and var_170_21 or var_170_21 * (var_170_26 / var_170_25)

				if var_170_27 > 0 and var_170_21 < var_170_27 then
					arg_167_1.talkMaxDuration = var_170_27

					if var_170_27 + var_170_20 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_27 + var_170_20
					end
				end

				arg_167_1.text_.text = var_170_24
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121041", "story_v_out_114121.awb") ~= 0 then
					local var_170_28 = manager.audio:GetVoiceLength("story_v_out_114121", "114121041", "story_v_out_114121.awb") / 1000

					if var_170_28 + var_170_20 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_28 + var_170_20
					end

					if var_170_23.prefab_name ~= "" and arg_167_1.actors_[var_170_23.prefab_name] ~= nil then
						local var_170_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_23.prefab_name].transform, "story_v_out_114121", "114121041", "story_v_out_114121.awb")

						arg_167_1:RecordAudio("114121041", var_170_29)
						arg_167_1:RecordAudio("114121041", var_170_29)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_114121", "114121041", "story_v_out_114121.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_114121", "114121041", "story_v_out_114121.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_30 = math.max(var_170_21, arg_167_1.talkMaxDuration)

			if var_170_20 <= arg_167_1.time_ and arg_167_1.time_ < var_170_20 + var_170_30 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_20) / var_170_30

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_20 + var_170_30 and arg_167_1.time_ < var_170_20 + var_170_30 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_167_1:InitPlayNodeList()
	end,
	Play114121042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 114121042
		arg_171_1.duration_ = 5.63

		local var_171_0 = {
			ja = 5.366,
			ko = 3,
			zh = 3.2,
			en = 5.633
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play114121043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = arg_171_1.actors_["10006ui_story"].transform
			local var_174_1 = 0

			if var_174_1 < arg_171_1.time_ and arg_171_1.time_ <= var_174_1 + arg_174_0 then
				arg_171_1.var_.moveOldPos10006ui_story = var_174_0.localPosition
			end

			local var_174_2 = 0.001

			if var_174_1 <= arg_171_1.time_ and arg_171_1.time_ < var_174_1 + var_174_2 then
				local var_174_3 = (arg_171_1.time_ - var_174_1) / var_174_2
				local var_174_4 = Vector3.New(0, 100, 0)

				var_174_0.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10006ui_story, var_174_4, var_174_3)

				local var_174_5 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_5.x, var_174_5.y, var_174_5.z)

				local var_174_6 = var_174_0.localEulerAngles

				var_174_6.z = 0
				var_174_6.x = 0
				var_174_0.localEulerAngles = var_174_6
			end

			if arg_171_1.time_ >= var_174_1 + var_174_2 and arg_171_1.time_ < var_174_1 + var_174_2 + arg_174_0 then
				var_174_0.localPosition = Vector3.New(0, 100, 0)

				local var_174_7 = manager.ui.mainCamera.transform.position - var_174_0.position

				var_174_0.forward = Vector3.New(var_174_7.x, var_174_7.y, var_174_7.z)

				local var_174_8 = var_174_0.localEulerAngles

				var_174_8.z = 0
				var_174_8.x = 0
				var_174_0.localEulerAngles = var_174_8
			end

			local var_174_9 = "1184ui_story"

			if arg_171_1.actors_[var_174_9] == nil then
				local var_174_10 = Asset.Load("Char/" .. "1184ui_story")

				if not isNil(var_174_10) then
					local var_174_11 = Object.Instantiate(Asset.Load("Char/" .. "1184ui_story"), arg_171_1.stage_.transform)

					var_174_11.name = var_174_9
					var_174_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_171_1.actors_[var_174_9] = var_174_11

					local var_174_12 = var_174_11:GetComponentInChildren(typeof(CharacterEffect))

					var_174_12.enabled = true

					local var_174_13 = GameObjectTools.GetOrAddComponent(var_174_11, typeof(DynamicBoneHelper))

					if var_174_13 then
						var_174_13:EnableDynamicBone(false)
					end

					arg_171_1:ShowWeapon(var_174_12.transform, false)

					arg_171_1.var_[var_174_9 .. "Animator"] = var_174_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_171_1.var_[var_174_9 .. "Animator"].applyRootMotion = true
					arg_171_1.var_[var_174_9 .. "LipSync"] = var_174_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_174_14 = arg_171_1.actors_["1184ui_story"].transform
			local var_174_15 = 0

			if var_174_15 < arg_171_1.time_ and arg_171_1.time_ <= var_174_15 + arg_174_0 then
				arg_171_1.var_.moveOldPos1184ui_story = var_174_14.localPosition
			end

			local var_174_16 = 0.001

			if var_174_15 <= arg_171_1.time_ and arg_171_1.time_ < var_174_15 + var_174_16 then
				local var_174_17 = (arg_171_1.time_ - var_174_15) / var_174_16
				local var_174_18 = Vector3.New(-0.7, -0.97, -6)

				var_174_14.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos1184ui_story, var_174_18, var_174_17)

				local var_174_19 = manager.ui.mainCamera.transform.position - var_174_14.position

				var_174_14.forward = Vector3.New(var_174_19.x, var_174_19.y, var_174_19.z)

				local var_174_20 = var_174_14.localEulerAngles

				var_174_20.z = 0
				var_174_20.x = 0
				var_174_14.localEulerAngles = var_174_20
			end

			if arg_171_1.time_ >= var_174_15 + var_174_16 and arg_171_1.time_ < var_174_15 + var_174_16 + arg_174_0 then
				var_174_14.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_174_21 = manager.ui.mainCamera.transform.position - var_174_14.position

				var_174_14.forward = Vector3.New(var_174_21.x, var_174_21.y, var_174_21.z)

				local var_174_22 = var_174_14.localEulerAngles

				var_174_22.z = 0
				var_174_22.x = 0
				var_174_14.localEulerAngles = var_174_22
			end

			local var_174_23 = 0

			if var_174_23 < arg_171_1.time_ and arg_171_1.time_ <= var_174_23 + arg_174_0 then
				arg_171_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_174_24 = 0

			if var_174_24 < arg_171_1.time_ and arg_171_1.time_ <= var_174_24 + arg_174_0 then
				arg_171_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_174_25 = arg_171_1.actors_["1184ui_story"]
			local var_174_26 = 0

			if var_174_26 < arg_171_1.time_ and arg_171_1.time_ <= var_174_26 + arg_174_0 and not isNil(var_174_25) and arg_171_1.var_.characterEffect1184ui_story == nil then
				arg_171_1.var_.characterEffect1184ui_story = var_174_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_27 = 0.2

			if var_174_26 <= arg_171_1.time_ and arg_171_1.time_ < var_174_26 + var_174_27 and not isNil(var_174_25) then
				local var_174_28 = (arg_171_1.time_ - var_174_26) / var_174_27

				if arg_171_1.var_.characterEffect1184ui_story and not isNil(var_174_25) then
					arg_171_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= var_174_26 + var_174_27 and arg_171_1.time_ < var_174_26 + var_174_27 + arg_174_0 and not isNil(var_174_25) and arg_171_1.var_.characterEffect1184ui_story then
				arg_171_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_174_29 = 0
			local var_174_30 = 0.35

			if var_174_29 < arg_171_1.time_ and arg_171_1.time_ <= var_174_29 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_31 = arg_171_1:FormatText(StoryNameCfg[6].name)

				arg_171_1.leftNameTxt_.text = var_174_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_32 = arg_171_1:GetWordFromCfg(114121042)
				local var_174_33 = arg_171_1:FormatText(var_174_32.content)

				arg_171_1.text_.text = var_174_33

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_34 = 14
				local var_174_35 = utf8.len(var_174_33)
				local var_174_36 = var_174_34 <= 0 and var_174_30 or var_174_30 * (var_174_35 / var_174_34)

				if var_174_36 > 0 and var_174_30 < var_174_36 then
					arg_171_1.talkMaxDuration = var_174_36

					if var_174_36 + var_174_29 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_36 + var_174_29
					end
				end

				arg_171_1.text_.text = var_174_33
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121042", "story_v_out_114121.awb") ~= 0 then
					local var_174_37 = manager.audio:GetVoiceLength("story_v_out_114121", "114121042", "story_v_out_114121.awb") / 1000

					if var_174_37 + var_174_29 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_37 + var_174_29
					end

					if var_174_32.prefab_name ~= "" and arg_171_1.actors_[var_174_32.prefab_name] ~= nil then
						local var_174_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_32.prefab_name].transform, "story_v_out_114121", "114121042", "story_v_out_114121.awb")

						arg_171_1:RecordAudio("114121042", var_174_38)
						arg_171_1:RecordAudio("114121042", var_174_38)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_114121", "114121042", "story_v_out_114121.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_114121", "114121042", "story_v_out_114121.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_39 = math.max(var_174_30, arg_171_1.talkMaxDuration)

			if var_174_29 <= arg_171_1.time_ and arg_171_1.time_ < var_174_29 + var_174_39 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_29) / var_174_39

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_29 + var_174_39 and arg_171_1.time_ < var_174_29 + var_174_39 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10006ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play114121043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 114121043
		arg_175_1.duration_ = 9.6

		local var_175_0 = {
			ja = 7.7,
			ko = 8.033,
			zh = 7.7,
			en = 9.6
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play114121044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = arg_175_1.actors_["1184ui_story"]
			local var_178_1 = 0

			if var_178_1 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1184ui_story == nil then
				arg_175_1.var_.characterEffect1184ui_story = var_178_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.2

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 and not isNil(var_178_0) then
				local var_178_3 = (arg_175_1.time_ - var_178_1) / var_178_2

				if arg_175_1.var_.characterEffect1184ui_story and not isNil(var_178_0) then
					local var_178_4 = Mathf.Lerp(0, 0.5, var_178_3)

					arg_175_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_175_1.var_.characterEffect1184ui_story.fillRatio = var_178_4
				end
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 and not isNil(var_178_0) and arg_175_1.var_.characterEffect1184ui_story then
				local var_178_5 = 0.5

				arg_175_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_175_1.var_.characterEffect1184ui_story.fillRatio = var_178_5
			end

			local var_178_6 = "1041ui_story"

			if arg_175_1.actors_[var_178_6] == nil then
				local var_178_7 = Asset.Load("Char/" .. "1041ui_story")

				if not isNil(var_178_7) then
					local var_178_8 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_175_1.stage_.transform)

					var_178_8.name = var_178_6
					var_178_8.transform.localPosition = Vector3.New(0, 100, 0)
					arg_175_1.actors_[var_178_6] = var_178_8

					local var_178_9 = var_178_8:GetComponentInChildren(typeof(CharacterEffect))

					var_178_9.enabled = true

					local var_178_10 = GameObjectTools.GetOrAddComponent(var_178_8, typeof(DynamicBoneHelper))

					if var_178_10 then
						var_178_10:EnableDynamicBone(false)
					end

					arg_175_1:ShowWeapon(var_178_9.transform, false)

					arg_175_1.var_[var_178_6 .. "Animator"] = var_178_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_175_1.var_[var_178_6 .. "Animator"].applyRootMotion = true
					arg_175_1.var_[var_178_6 .. "LipSync"] = var_178_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_178_11 = arg_175_1.actors_["1041ui_story"].transform
			local var_178_12 = 0

			if var_178_12 < arg_175_1.time_ and arg_175_1.time_ <= var_178_12 + arg_178_0 then
				arg_175_1.var_.moveOldPos1041ui_story = var_178_11.localPosition
			end

			local var_178_13 = 0.001

			if var_178_12 <= arg_175_1.time_ and arg_175_1.time_ < var_178_12 + var_178_13 then
				local var_178_14 = (arg_175_1.time_ - var_178_12) / var_178_13
				local var_178_15 = Vector3.New(0.7, -1.11, -5.9)

				var_178_11.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1041ui_story, var_178_15, var_178_14)

				local var_178_16 = manager.ui.mainCamera.transform.position - var_178_11.position

				var_178_11.forward = Vector3.New(var_178_16.x, var_178_16.y, var_178_16.z)

				local var_178_17 = var_178_11.localEulerAngles

				var_178_17.z = 0
				var_178_17.x = 0
				var_178_11.localEulerAngles = var_178_17
			end

			if arg_175_1.time_ >= var_178_12 + var_178_13 and arg_175_1.time_ < var_178_12 + var_178_13 + arg_178_0 then
				var_178_11.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_178_18 = manager.ui.mainCamera.transform.position - var_178_11.position

				var_178_11.forward = Vector3.New(var_178_18.x, var_178_18.y, var_178_18.z)

				local var_178_19 = var_178_11.localEulerAngles

				var_178_19.z = 0
				var_178_19.x = 0
				var_178_11.localEulerAngles = var_178_19
			end

			local var_178_20 = 0

			if var_178_20 < arg_175_1.time_ and arg_175_1.time_ <= var_178_20 + arg_178_0 then
				arg_175_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_178_21 = 0

			if var_178_21 < arg_175_1.time_ and arg_175_1.time_ <= var_178_21 + arg_178_0 then
				arg_175_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_178_22 = arg_175_1.actors_["1041ui_story"]
			local var_178_23 = 0

			if var_178_23 < arg_175_1.time_ and arg_175_1.time_ <= var_178_23 + arg_178_0 and not isNil(var_178_22) and arg_175_1.var_.characterEffect1041ui_story == nil then
				arg_175_1.var_.characterEffect1041ui_story = var_178_22:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_24 = 0.2

			if var_178_23 <= arg_175_1.time_ and arg_175_1.time_ < var_178_23 + var_178_24 and not isNil(var_178_22) then
				local var_178_25 = (arg_175_1.time_ - var_178_23) / var_178_24

				if arg_175_1.var_.characterEffect1041ui_story and not isNil(var_178_22) then
					arg_175_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= var_178_23 + var_178_24 and arg_175_1.time_ < var_178_23 + var_178_24 + arg_178_0 and not isNil(var_178_22) and arg_175_1.var_.characterEffect1041ui_story then
				arg_175_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_178_26 = 0
			local var_178_27 = 0.9

			if var_178_26 < arg_175_1.time_ and arg_175_1.time_ <= var_178_26 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_28 = arg_175_1:FormatText(StoryNameCfg[208].name)

				arg_175_1.leftNameTxt_.text = var_178_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_29 = arg_175_1:GetWordFromCfg(114121043)
				local var_178_30 = arg_175_1:FormatText(var_178_29.content)

				arg_175_1.text_.text = var_178_30

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_31 = 36
				local var_178_32 = utf8.len(var_178_30)
				local var_178_33 = var_178_31 <= 0 and var_178_27 or var_178_27 * (var_178_32 / var_178_31)

				if var_178_33 > 0 and var_178_27 < var_178_33 then
					arg_175_1.talkMaxDuration = var_178_33

					if var_178_33 + var_178_26 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_33 + var_178_26
					end
				end

				arg_175_1.text_.text = var_178_30
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121043", "story_v_out_114121.awb") ~= 0 then
					local var_178_34 = manager.audio:GetVoiceLength("story_v_out_114121", "114121043", "story_v_out_114121.awb") / 1000

					if var_178_34 + var_178_26 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_34 + var_178_26
					end

					if var_178_29.prefab_name ~= "" and arg_175_1.actors_[var_178_29.prefab_name] ~= nil then
						local var_178_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_29.prefab_name].transform, "story_v_out_114121", "114121043", "story_v_out_114121.awb")

						arg_175_1:RecordAudio("114121043", var_178_35)
						arg_175_1:RecordAudio("114121043", var_178_35)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_114121", "114121043", "story_v_out_114121.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_114121", "114121043", "story_v_out_114121.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_36 = math.max(var_178_27, arg_175_1.talkMaxDuration)

			if var_178_26 <= arg_175_1.time_ and arg_175_1.time_ < var_178_26 + var_178_36 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_26) / var_178_36

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_26 + var_178_36 and arg_175_1.time_ < var_178_26 + var_178_36 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play114121044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 114121044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play114121045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["1041ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1041ui_story == nil then
				arg_179_1.var_.characterEffect1041ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.2

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 and not isNil(var_182_0) then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect1041ui_story and not isNil(var_182_0) then
					local var_182_4 = Mathf.Lerp(0, 0.5, var_182_3)

					arg_179_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_179_1.var_.characterEffect1041ui_story.fillRatio = var_182_4
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and not isNil(var_182_0) and arg_179_1.var_.characterEffect1041ui_story then
				local var_182_5 = 0.5

				arg_179_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_179_1.var_.characterEffect1041ui_story.fillRatio = var_182_5
			end

			local var_182_6 = arg_179_1.actors_["1184ui_story"].transform
			local var_182_7 = 0

			if var_182_7 < arg_179_1.time_ and arg_179_1.time_ <= var_182_7 + arg_182_0 then
				arg_179_1.var_.moveOldPos1184ui_story = var_182_6.localPosition
			end

			local var_182_8 = 0.001

			if var_182_7 <= arg_179_1.time_ and arg_179_1.time_ < var_182_7 + var_182_8 then
				local var_182_9 = (arg_179_1.time_ - var_182_7) / var_182_8
				local var_182_10 = Vector3.New(0, 100, 0)

				var_182_6.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1184ui_story, var_182_10, var_182_9)

				local var_182_11 = manager.ui.mainCamera.transform.position - var_182_6.position

				var_182_6.forward = Vector3.New(var_182_11.x, var_182_11.y, var_182_11.z)

				local var_182_12 = var_182_6.localEulerAngles

				var_182_12.z = 0
				var_182_12.x = 0
				var_182_6.localEulerAngles = var_182_12
			end

			if arg_179_1.time_ >= var_182_7 + var_182_8 and arg_179_1.time_ < var_182_7 + var_182_8 + arg_182_0 then
				var_182_6.localPosition = Vector3.New(0, 100, 0)

				local var_182_13 = manager.ui.mainCamera.transform.position - var_182_6.position

				var_182_6.forward = Vector3.New(var_182_13.x, var_182_13.y, var_182_13.z)

				local var_182_14 = var_182_6.localEulerAngles

				var_182_14.z = 0
				var_182_14.x = 0
				var_182_6.localEulerAngles = var_182_14
			end

			local var_182_15 = arg_179_1.actors_["1041ui_story"].transform
			local var_182_16 = 0

			if var_182_16 < arg_179_1.time_ and arg_179_1.time_ <= var_182_16 + arg_182_0 then
				arg_179_1.var_.moveOldPos1041ui_story = var_182_15.localPosition
			end

			local var_182_17 = 0.001

			if var_182_16 <= arg_179_1.time_ and arg_179_1.time_ < var_182_16 + var_182_17 then
				local var_182_18 = (arg_179_1.time_ - var_182_16) / var_182_17
				local var_182_19 = Vector3.New(0, 100, 0)

				var_182_15.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1041ui_story, var_182_19, var_182_18)

				local var_182_20 = manager.ui.mainCamera.transform.position - var_182_15.position

				var_182_15.forward = Vector3.New(var_182_20.x, var_182_20.y, var_182_20.z)

				local var_182_21 = var_182_15.localEulerAngles

				var_182_21.z = 0
				var_182_21.x = 0
				var_182_15.localEulerAngles = var_182_21
			end

			if arg_179_1.time_ >= var_182_16 + var_182_17 and arg_179_1.time_ < var_182_16 + var_182_17 + arg_182_0 then
				var_182_15.localPosition = Vector3.New(0, 100, 0)

				local var_182_22 = manager.ui.mainCamera.transform.position - var_182_15.position

				var_182_15.forward = Vector3.New(var_182_22.x, var_182_22.y, var_182_22.z)

				local var_182_23 = var_182_15.localEulerAngles

				var_182_23.z = 0
				var_182_23.x = 0
				var_182_15.localEulerAngles = var_182_23
			end

			local var_182_24 = 0
			local var_182_25 = 0.525

			if var_182_24 < arg_179_1.time_ and arg_179_1.time_ <= var_182_24 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_26 = arg_179_1:FormatText(StoryNameCfg[7].name)

				arg_179_1.leftNameTxt_.text = var_182_26

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_27 = arg_179_1:GetWordFromCfg(114121044)
				local var_182_28 = arg_179_1:FormatText(var_182_27.content)

				arg_179_1.text_.text = var_182_28

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_29 = 21
				local var_182_30 = utf8.len(var_182_28)
				local var_182_31 = var_182_29 <= 0 and var_182_25 or var_182_25 * (var_182_30 / var_182_29)

				if var_182_31 > 0 and var_182_25 < var_182_31 then
					arg_179_1.talkMaxDuration = var_182_31

					if var_182_31 + var_182_24 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_31 + var_182_24
					end
				end

				arg_179_1.text_.text = var_182_28
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_32 = math.max(var_182_25, arg_179_1.talkMaxDuration)

			if var_182_24 <= arg_179_1.time_ and arg_179_1.time_ < var_182_24 + var_182_32 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_24) / var_182_32

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_24 + var_182_32 and arg_179_1.time_ < var_182_24 + var_182_32 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play114121045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 114121045
		arg_183_1.duration_ = 9.43

		local var_183_0 = {
			ja = 7.6,
			ko = 7.833,
			zh = 8.6,
			en = 9.433
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play114121046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = 0

			if var_186_0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_0 + arg_186_0 then
				arg_183_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_186_2 = arg_183_1.actors_["1041ui_story"]
			local var_186_3 = 0

			if var_186_3 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.characterEffect1041ui_story == nil then
				arg_183_1.var_.characterEffect1041ui_story = var_186_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_4 = 0.2

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_4 and not isNil(var_186_2) then
				local var_186_5 = (arg_183_1.time_ - var_186_3) / var_186_4

				if arg_183_1.var_.characterEffect1041ui_story and not isNil(var_186_2) then
					arg_183_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_3 + var_186_4 and arg_183_1.time_ < var_186_3 + var_186_4 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.characterEffect1041ui_story then
				arg_183_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_186_6 = arg_183_1.actors_["1041ui_story"].transform
			local var_186_7 = 0

			if var_186_7 < arg_183_1.time_ and arg_183_1.time_ <= var_186_7 + arg_186_0 then
				arg_183_1.var_.moveOldPos1041ui_story = var_186_6.localPosition
			end

			local var_186_8 = 0.001

			if var_186_7 <= arg_183_1.time_ and arg_183_1.time_ < var_186_7 + var_186_8 then
				local var_186_9 = (arg_183_1.time_ - var_186_7) / var_186_8
				local var_186_10 = Vector3.New(0, -1.11, -5.9)

				var_186_6.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1041ui_story, var_186_10, var_186_9)

				local var_186_11 = manager.ui.mainCamera.transform.position - var_186_6.position

				var_186_6.forward = Vector3.New(var_186_11.x, var_186_11.y, var_186_11.z)

				local var_186_12 = var_186_6.localEulerAngles

				var_186_12.z = 0
				var_186_12.x = 0
				var_186_6.localEulerAngles = var_186_12
			end

			if arg_183_1.time_ >= var_186_7 + var_186_8 and arg_183_1.time_ < var_186_7 + var_186_8 + arg_186_0 then
				var_186_6.localPosition = Vector3.New(0, -1.11, -5.9)

				local var_186_13 = manager.ui.mainCamera.transform.position - var_186_6.position

				var_186_6.forward = Vector3.New(var_186_13.x, var_186_13.y, var_186_13.z)

				local var_186_14 = var_186_6.localEulerAngles

				var_186_14.z = 0
				var_186_14.x = 0
				var_186_6.localEulerAngles = var_186_14
			end

			local var_186_15 = 0
			local var_186_16 = 0.875

			if var_186_15 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_17 = arg_183_1:FormatText(StoryNameCfg[208].name)

				arg_183_1.leftNameTxt_.text = var_186_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_18 = arg_183_1:GetWordFromCfg(114121045)
				local var_186_19 = arg_183_1:FormatText(var_186_18.content)

				arg_183_1.text_.text = var_186_19

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_20 = 35
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

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121045", "story_v_out_114121.awb") ~= 0 then
					local var_186_23 = manager.audio:GetVoiceLength("story_v_out_114121", "114121045", "story_v_out_114121.awb") / 1000

					if var_186_23 + var_186_15 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_23 + var_186_15
					end

					if var_186_18.prefab_name ~= "" and arg_183_1.actors_[var_186_18.prefab_name] ~= nil then
						local var_186_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_18.prefab_name].transform, "story_v_out_114121", "114121045", "story_v_out_114121.awb")

						arg_183_1:RecordAudio("114121045", var_186_24)
						arg_183_1:RecordAudio("114121045", var_186_24)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_114121", "114121045", "story_v_out_114121.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_114121", "114121045", "story_v_out_114121.awb")
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
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play114121046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 114121046
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play114121047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["1041ui_story"]
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1041ui_story == nil then
				arg_187_1.var_.characterEffect1041ui_story = var_190_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.2

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 and not isNil(var_190_0) then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2

				if arg_187_1.var_.characterEffect1041ui_story and not isNil(var_190_0) then
					local var_190_4 = Mathf.Lerp(0, 0.5, var_190_3)

					arg_187_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_187_1.var_.characterEffect1041ui_story.fillRatio = var_190_4
				end
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 and not isNil(var_190_0) and arg_187_1.var_.characterEffect1041ui_story then
				local var_190_5 = 0.5

				arg_187_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_187_1.var_.characterEffect1041ui_story.fillRatio = var_190_5
			end

			local var_190_6 = 0
			local var_190_7 = 1.2

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

				arg_187_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_187_1.callingController_:SetSelectedState("normal")

				arg_187_1.keyicon_.color = Color.New(1, 1, 1)
				arg_187_1.icon_.color = Color.New(1, 1, 1)

				local var_190_9 = arg_187_1:GetWordFromCfg(114121046)
				local var_190_10 = arg_187_1:FormatText(var_190_9.content)

				arg_187_1.text_.text = var_190_10

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_11 = 48
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
	Play114121047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 114121047
		arg_191_1.duration_ = 10.63

		local var_191_0 = {
			ja = 10.633,
			ko = 6.7,
			zh = 6.6,
			en = 7.833
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
				arg_191_0:Play114121048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 0
			local var_194_1 = 0.85

			if var_194_0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_2 = arg_191_1:FormatText(StoryNameCfg[10].name)

				arg_191_1.leftNameTxt_.text = var_194_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, true)
				arg_191_1.iconController_:SetSelectedState("hero")

				arg_191_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_191_1.callingController_:SetSelectedState("normal")

				arg_191_1.keyicon_.color = Color.New(1, 1, 1)
				arg_191_1.icon_.color = Color.New(1, 1, 1)

				local var_194_3 = arg_191_1:GetWordFromCfg(114121047)
				local var_194_4 = arg_191_1:FormatText(var_194_3.content)

				arg_191_1.text_.text = var_194_4

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121047", "story_v_out_114121.awb") ~= 0 then
					local var_194_8 = manager.audio:GetVoiceLength("story_v_out_114121", "114121047", "story_v_out_114121.awb") / 1000

					if var_194_8 + var_194_0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_8 + var_194_0
					end

					if var_194_3.prefab_name ~= "" and arg_191_1.actors_[var_194_3.prefab_name] ~= nil then
						local var_194_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_3.prefab_name].transform, "story_v_out_114121", "114121047", "story_v_out_114121.awb")

						arg_191_1:RecordAudio("114121047", var_194_9)
						arg_191_1:RecordAudio("114121047", var_194_9)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_114121", "114121047", "story_v_out_114121.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_114121", "114121047", "story_v_out_114121.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_10 = math.max(var_194_1, arg_191_1.talkMaxDuration)

			if var_194_0 <= arg_191_1.time_ and arg_191_1.time_ < var_194_0 + var_194_10 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_0) / var_194_10

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_0 + var_194_10 and arg_191_1.time_ < var_194_0 + var_194_10 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play114121048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 114121048
		arg_195_1.duration_ = 7.5

		local var_195_0 = {
			ja = 7.3,
			ko = 6.2,
			zh = 5.533,
			en = 7.5
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
				arg_195_0:Play114121049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["1041ui_story"].transform
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.var_.moveOldPos1041ui_story = var_198_0.localPosition
			end

			local var_198_2 = 0.5

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2
				local var_198_4 = Vector3.New(-0.7, -1.11, -5.9)

				var_198_0.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1041ui_story, var_198_4, var_198_3)

				local var_198_5 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_5.x, var_198_5.y, var_198_5.z)

				local var_198_6 = var_198_0.localEulerAngles

				var_198_6.z = 0
				var_198_6.x = 0
				var_198_0.localEulerAngles = var_198_6
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 then
				var_198_0.localPosition = Vector3.New(-0.7, -1.11, -5.9)

				local var_198_7 = manager.ui.mainCamera.transform.position - var_198_0.position

				var_198_0.forward = Vector3.New(var_198_7.x, var_198_7.y, var_198_7.z)

				local var_198_8 = var_198_0.localEulerAngles

				var_198_8.z = 0
				var_198_8.x = 0
				var_198_0.localEulerAngles = var_198_8
			end

			local var_198_9 = "1038ui_story"

			if arg_195_1.actors_[var_198_9] == nil then
				local var_198_10 = Asset.Load("Char/" .. "1038ui_story")

				if not isNil(var_198_10) then
					local var_198_11 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_195_1.stage_.transform)

					var_198_11.name = var_198_9
					var_198_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_195_1.actors_[var_198_9] = var_198_11

					local var_198_12 = var_198_11:GetComponentInChildren(typeof(CharacterEffect))

					var_198_12.enabled = true

					local var_198_13 = GameObjectTools.GetOrAddComponent(var_198_11, typeof(DynamicBoneHelper))

					if var_198_13 then
						var_198_13:EnableDynamicBone(false)
					end

					arg_195_1:ShowWeapon(var_198_12.transform, false)

					arg_195_1.var_[var_198_9 .. "Animator"] = var_198_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_195_1.var_[var_198_9 .. "Animator"].applyRootMotion = true
					arg_195_1.var_[var_198_9 .. "LipSync"] = var_198_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_198_14 = arg_195_1.actors_["1038ui_story"].transform
			local var_198_15 = 0

			if var_198_15 < arg_195_1.time_ and arg_195_1.time_ <= var_198_15 + arg_198_0 then
				arg_195_1.var_.moveOldPos1038ui_story = var_198_14.localPosition
			end

			local var_198_16 = 0.001

			if var_198_15 <= arg_195_1.time_ and arg_195_1.time_ < var_198_15 + var_198_16 then
				local var_198_17 = (arg_195_1.time_ - var_198_15) / var_198_16
				local var_198_18 = Vector3.New(0.7, -1.11, -5.9)

				var_198_14.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1038ui_story, var_198_18, var_198_17)

				local var_198_19 = manager.ui.mainCamera.transform.position - var_198_14.position

				var_198_14.forward = Vector3.New(var_198_19.x, var_198_19.y, var_198_19.z)

				local var_198_20 = var_198_14.localEulerAngles

				var_198_20.z = 0
				var_198_20.x = 0
				var_198_14.localEulerAngles = var_198_20
			end

			if arg_195_1.time_ >= var_198_15 + var_198_16 and arg_195_1.time_ < var_198_15 + var_198_16 + arg_198_0 then
				var_198_14.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_198_21 = manager.ui.mainCamera.transform.position - var_198_14.position

				var_198_14.forward = Vector3.New(var_198_21.x, var_198_21.y, var_198_21.z)

				local var_198_22 = var_198_14.localEulerAngles

				var_198_22.z = 0
				var_198_22.x = 0
				var_198_14.localEulerAngles = var_198_22
			end

			local var_198_23 = 0

			if var_198_23 < arg_195_1.time_ and arg_195_1.time_ <= var_198_23 + arg_198_0 then
				arg_195_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_198_24 = 0

			if var_198_24 < arg_195_1.time_ and arg_195_1.time_ <= var_198_24 + arg_198_0 then
				arg_195_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_198_25 = arg_195_1.actors_["1038ui_story"]
			local var_198_26 = 0

			if var_198_26 < arg_195_1.time_ and arg_195_1.time_ <= var_198_26 + arg_198_0 and not isNil(var_198_25) and arg_195_1.var_.characterEffect1038ui_story == nil then
				arg_195_1.var_.characterEffect1038ui_story = var_198_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_27 = 0.2

			if var_198_26 <= arg_195_1.time_ and arg_195_1.time_ < var_198_26 + var_198_27 and not isNil(var_198_25) then
				local var_198_28 = (arg_195_1.time_ - var_198_26) / var_198_27

				if arg_195_1.var_.characterEffect1038ui_story and not isNil(var_198_25) then
					arg_195_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_26 + var_198_27 and arg_195_1.time_ < var_198_26 + var_198_27 + arg_198_0 and not isNil(var_198_25) and arg_195_1.var_.characterEffect1038ui_story then
				arg_195_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_198_29 = 0
			local var_198_30 = 0.75

			if var_198_29 < arg_195_1.time_ and arg_195_1.time_ <= var_198_29 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_31 = arg_195_1:FormatText(StoryNameCfg[94].name)

				arg_195_1.leftNameTxt_.text = var_198_31

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_32 = arg_195_1:GetWordFromCfg(114121048)
				local var_198_33 = arg_195_1:FormatText(var_198_32.content)

				arg_195_1.text_.text = var_198_33

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_34 = 30
				local var_198_35 = utf8.len(var_198_33)
				local var_198_36 = var_198_34 <= 0 and var_198_30 or var_198_30 * (var_198_35 / var_198_34)

				if var_198_36 > 0 and var_198_30 < var_198_36 then
					arg_195_1.talkMaxDuration = var_198_36

					if var_198_36 + var_198_29 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_36 + var_198_29
					end
				end

				arg_195_1.text_.text = var_198_33
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121048", "story_v_out_114121.awb") ~= 0 then
					local var_198_37 = manager.audio:GetVoiceLength("story_v_out_114121", "114121048", "story_v_out_114121.awb") / 1000

					if var_198_37 + var_198_29 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_37 + var_198_29
					end

					if var_198_32.prefab_name ~= "" and arg_195_1.actors_[var_198_32.prefab_name] ~= nil then
						local var_198_38 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_32.prefab_name].transform, "story_v_out_114121", "114121048", "story_v_out_114121.awb")

						arg_195_1:RecordAudio("114121048", var_198_38)
						arg_195_1:RecordAudio("114121048", var_198_38)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_114121", "114121048", "story_v_out_114121.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_114121", "114121048", "story_v_out_114121.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_39 = math.max(var_198_30, arg_195_1.talkMaxDuration)

			if var_198_29 <= arg_195_1.time_ and arg_195_1.time_ < var_198_29 + var_198_39 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_29) / var_198_39

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_29 + var_198_39 and arg_195_1.time_ < var_198_29 + var_198_39 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play114121049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 114121049
		arg_199_1.duration_ = 10.4

		local var_199_0 = {
			ja = 8.4,
			ko = 9.766,
			zh = 7.066,
			en = 10.4
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
				arg_199_0:Play114121050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_202_1 = 0
			local var_202_2 = 1.05

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_3 = arg_199_1:FormatText(StoryNameCfg[94].name)

				arg_199_1.leftNameTxt_.text = var_202_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_4 = arg_199_1:GetWordFromCfg(114121049)
				local var_202_5 = arg_199_1:FormatText(var_202_4.content)

				arg_199_1.text_.text = var_202_5

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_6 = 42
				local var_202_7 = utf8.len(var_202_5)
				local var_202_8 = var_202_6 <= 0 and var_202_2 or var_202_2 * (var_202_7 / var_202_6)

				if var_202_8 > 0 and var_202_2 < var_202_8 then
					arg_199_1.talkMaxDuration = var_202_8

					if var_202_8 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_8 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_5
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121049", "story_v_out_114121.awb") ~= 0 then
					local var_202_9 = manager.audio:GetVoiceLength("story_v_out_114121", "114121049", "story_v_out_114121.awb") / 1000

					if var_202_9 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_1
					end

					if var_202_4.prefab_name ~= "" and arg_199_1.actors_[var_202_4.prefab_name] ~= nil then
						local var_202_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_4.prefab_name].transform, "story_v_out_114121", "114121049", "story_v_out_114121.awb")

						arg_199_1:RecordAudio("114121049", var_202_10)
						arg_199_1:RecordAudio("114121049", var_202_10)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_114121", "114121049", "story_v_out_114121.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_114121", "114121049", "story_v_out_114121.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_11 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_11 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_11

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_11 and arg_199_1.time_ < var_202_1 + var_202_11 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play114121050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 114121050
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play114121051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = arg_203_1.actors_["1038ui_story"].transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.moveOldPos1038ui_story = var_206_0.localPosition
			end

			local var_206_2 = 0.001

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / var_206_2
				local var_206_4 = Vector3.New(0, 100, 0)

				var_206_0.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1038ui_story, var_206_4, var_206_3)

				local var_206_5 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_5.x, var_206_5.y, var_206_5.z)

				local var_206_6 = var_206_0.localEulerAngles

				var_206_6.z = 0
				var_206_6.x = 0
				var_206_0.localEulerAngles = var_206_6
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = Vector3.New(0, 100, 0)

				local var_206_7 = manager.ui.mainCamera.transform.position - var_206_0.position

				var_206_0.forward = Vector3.New(var_206_7.x, var_206_7.y, var_206_7.z)

				local var_206_8 = var_206_0.localEulerAngles

				var_206_8.z = 0
				var_206_8.x = 0
				var_206_0.localEulerAngles = var_206_8
			end

			local var_206_9 = arg_203_1.actors_["1041ui_story"].transform
			local var_206_10 = 0

			if var_206_10 < arg_203_1.time_ and arg_203_1.time_ <= var_206_10 + arg_206_0 then
				arg_203_1.var_.moveOldPos1041ui_story = var_206_9.localPosition
			end

			local var_206_11 = 0.001

			if var_206_10 <= arg_203_1.time_ and arg_203_1.time_ < var_206_10 + var_206_11 then
				local var_206_12 = (arg_203_1.time_ - var_206_10) / var_206_11
				local var_206_13 = Vector3.New(0, 100, 0)

				var_206_9.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos1041ui_story, var_206_13, var_206_12)

				local var_206_14 = manager.ui.mainCamera.transform.position - var_206_9.position

				var_206_9.forward = Vector3.New(var_206_14.x, var_206_14.y, var_206_14.z)

				local var_206_15 = var_206_9.localEulerAngles

				var_206_15.z = 0
				var_206_15.x = 0
				var_206_9.localEulerAngles = var_206_15
			end

			if arg_203_1.time_ >= var_206_10 + var_206_11 and arg_203_1.time_ < var_206_10 + var_206_11 + arg_206_0 then
				var_206_9.localPosition = Vector3.New(0, 100, 0)

				local var_206_16 = manager.ui.mainCamera.transform.position - var_206_9.position

				var_206_9.forward = Vector3.New(var_206_16.x, var_206_16.y, var_206_16.z)

				local var_206_17 = var_206_9.localEulerAngles

				var_206_17.z = 0
				var_206_17.x = 0
				var_206_9.localEulerAngles = var_206_17
			end

			local var_206_18 = 0
			local var_206_19 = 0.325

			if var_206_18 < arg_203_1.time_ and arg_203_1.time_ <= var_206_18 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_20 = arg_203_1:FormatText(StoryNameCfg[7].name)

				arg_203_1.leftNameTxt_.text = var_206_20

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_21 = arg_203_1:GetWordFromCfg(114121050)
				local var_206_22 = arg_203_1:FormatText(var_206_21.content)

				arg_203_1.text_.text = var_206_22

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_23 = 13
				local var_206_24 = utf8.len(var_206_22)
				local var_206_25 = var_206_23 <= 0 and var_206_19 or var_206_19 * (var_206_24 / var_206_23)

				if var_206_25 > 0 and var_206_19 < var_206_25 then
					arg_203_1.talkMaxDuration = var_206_25

					if var_206_25 + var_206_18 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_25 + var_206_18
					end
				end

				arg_203_1.text_.text = var_206_22
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_26 = math.max(var_206_19, arg_203_1.talkMaxDuration)

			if var_206_18 <= arg_203_1.time_ and arg_203_1.time_ < var_206_18 + var_206_26 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_18) / var_206_26

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_18 + var_206_26 and arg_203_1.time_ < var_206_18 + var_206_26 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play114121051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 114121051
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play114121052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 0.675

			if var_210_0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_0 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_2 = arg_207_1:GetWordFromCfg(114121051)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 27
				local var_210_5 = utf8.len(var_210_3)
				local var_210_6 = var_210_4 <= 0 and var_210_1 or var_210_1 * (var_210_5 / var_210_4)

				if var_210_6 > 0 and var_210_1 < var_210_6 then
					arg_207_1.talkMaxDuration = var_210_6

					if var_210_6 + var_210_0 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_6 + var_210_0
					end
				end

				arg_207_1.text_.text = var_210_3
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_7 = math.max(var_210_1, arg_207_1.talkMaxDuration)

			if var_210_0 <= arg_207_1.time_ and arg_207_1.time_ < var_210_0 + var_210_7 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_0) / var_210_7

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_0 + var_210_7 and arg_207_1.time_ < var_210_0 + var_210_7 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play114121052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 114121052
		arg_211_1.duration_ = 6

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play114121053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = manager.ui.mainCamera.transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.shakeOldPos = var_214_0.localPosition
			end

			local var_214_2 = 1

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / 0.066
				local var_214_4, var_214_5 = math.modf(var_214_3)

				var_214_0.localPosition = Vector3.New(var_214_5 * 0.13, var_214_5 * 0.13, var_214_5 * 0.13) + arg_211_1.var_.shakeOldPos
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = arg_211_1.var_.shakeOldPos
			end

			local var_214_6 = 0

			if var_214_6 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.allBtn_.enabled = false
			end

			local var_214_7 = 1

			if arg_211_1.time_ >= var_214_6 + var_214_7 and arg_211_1.time_ < var_214_6 + var_214_7 + arg_214_0 then
				arg_211_1.allBtn_.enabled = true
			end

			if arg_211_1.frameCnt_ <= 1 then
				arg_211_1.dialog_:SetActive(false)
			end

			local var_214_8 = 1
			local var_214_9 = 1.15

			if var_214_8 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0

				arg_211_1.dialog_:SetActive(true)

				arg_211_1.dialogCg_.alpha = 0

				local var_214_10 = LeanTween.value(arg_211_1.dialog_, 0, 1, 0.3)

				var_214_10:setOnUpdate(LuaHelper.FloatAction(function(arg_215_0)
					arg_211_1.dialogCg_.alpha = arg_215_0
				end))
				var_214_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_211_1.dialog_)
					var_214_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_211_1.duration_ = arg_211_1.duration_ + 0.3

				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_11 = arg_211_1:GetWordFromCfg(114121052)
				local var_214_12 = arg_211_1:FormatText(var_214_11.content)

				arg_211_1.text_.text = var_214_12

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_13 = 46
				local var_214_14 = utf8.len(var_214_12)
				local var_214_15 = var_214_13 <= 0 and var_214_9 or var_214_9 * (var_214_14 / var_214_13)

				if var_214_15 > 0 and var_214_9 < var_214_15 then
					arg_211_1.talkMaxDuration = var_214_15
					var_214_8 = var_214_8 + 0.3

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

			local var_214_16 = var_214_8 + 0.3
			local var_214_17 = math.max(var_214_9, arg_211_1.talkMaxDuration)

			if var_214_16 <= arg_211_1.time_ and arg_211_1.time_ < var_214_16 + var_214_17 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_16) / var_214_17

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_16 + var_214_17 and arg_211_1.time_ < var_214_16 + var_214_17 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play114121053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 114121053
		arg_217_1.duration_ = 3.23

		local var_217_0 = {
			ja = 2.9,
			ko = 3.233,
			zh = 2,
			en = 2.733
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play114121054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = arg_217_1.actors_["1184ui_story"].transform
			local var_220_1 = 0

			if var_220_1 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.var_.moveOldPos1184ui_story = var_220_0.localPosition

				local var_220_2 = "1184ui_story"

				arg_217_1:ShowWeapon(arg_217_1.var_[var_220_2 .. "Animator"].transform, true)
			end

			local var_220_3 = 0.001

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_3 then
				local var_220_4 = (arg_217_1.time_ - var_220_1) / var_220_3
				local var_220_5 = Vector3.New(-0.7, -0.97, -6)

				var_220_0.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1184ui_story, var_220_5, var_220_4)

				local var_220_6 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_6.x, var_220_6.y, var_220_6.z)

				local var_220_7 = var_220_0.localEulerAngles

				var_220_7.z = 0
				var_220_7.x = 0
				var_220_0.localEulerAngles = var_220_7
			end

			if arg_217_1.time_ >= var_220_1 + var_220_3 and arg_217_1.time_ < var_220_1 + var_220_3 + arg_220_0 then
				var_220_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_220_8 = manager.ui.mainCamera.transform.position - var_220_0.position

				var_220_0.forward = Vector3.New(var_220_8.x, var_220_8.y, var_220_8.z)

				local var_220_9 = var_220_0.localEulerAngles

				var_220_9.z = 0
				var_220_9.x = 0
				var_220_0.localEulerAngles = var_220_9
			end

			local var_220_10 = 0

			if var_220_10 < arg_217_1.time_ and arg_217_1.time_ <= var_220_10 + arg_220_0 then
				arg_217_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_220_11 = 0

			if var_220_11 < arg_217_1.time_ and arg_217_1.time_ <= var_220_11 + arg_220_0 then
				arg_217_1:PlayTimeline("1184ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_220_12 = arg_217_1.actors_["1184ui_story"]
			local var_220_13 = 0

			if var_220_13 < arg_217_1.time_ and arg_217_1.time_ <= var_220_13 + arg_220_0 and not isNil(var_220_12) and arg_217_1.var_.characterEffect1184ui_story == nil then
				arg_217_1.var_.characterEffect1184ui_story = var_220_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_14 = 0.2

			if var_220_13 <= arg_217_1.time_ and arg_217_1.time_ < var_220_13 + var_220_14 and not isNil(var_220_12) then
				local var_220_15 = (arg_217_1.time_ - var_220_13) / var_220_14

				if arg_217_1.var_.characterEffect1184ui_story and not isNil(var_220_12) then
					arg_217_1.var_.characterEffect1184ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= var_220_13 + var_220_14 and arg_217_1.time_ < var_220_13 + var_220_14 + arg_220_0 and not isNil(var_220_12) and arg_217_1.var_.characterEffect1184ui_story then
				arg_217_1.var_.characterEffect1184ui_story.fillFlat = false
			end

			local var_220_16 = 0
			local var_220_17 = 0.25

			if var_220_16 < arg_217_1.time_ and arg_217_1.time_ <= var_220_16 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				local var_220_18 = arg_217_1:FormatText(StoryNameCfg[6].name)

				arg_217_1.leftNameTxt_.text = var_220_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_19 = arg_217_1:GetWordFromCfg(114121053)
				local var_220_20 = arg_217_1:FormatText(var_220_19.content)

				arg_217_1.text_.text = var_220_20

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_21 = 10
				local var_220_22 = utf8.len(var_220_20)
				local var_220_23 = var_220_21 <= 0 and var_220_17 or var_220_17 * (var_220_22 / var_220_21)

				if var_220_23 > 0 and var_220_17 < var_220_23 then
					arg_217_1.talkMaxDuration = var_220_23

					if var_220_23 + var_220_16 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_23 + var_220_16
					end
				end

				arg_217_1.text_.text = var_220_20
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121053", "story_v_out_114121.awb") ~= 0 then
					local var_220_24 = manager.audio:GetVoiceLength("story_v_out_114121", "114121053", "story_v_out_114121.awb") / 1000

					if var_220_24 + var_220_16 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_24 + var_220_16
					end

					if var_220_19.prefab_name ~= "" and arg_217_1.actors_[var_220_19.prefab_name] ~= nil then
						local var_220_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_19.prefab_name].transform, "story_v_out_114121", "114121053", "story_v_out_114121.awb")

						arg_217_1:RecordAudio("114121053", var_220_25)
						arg_217_1:RecordAudio("114121053", var_220_25)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_114121", "114121053", "story_v_out_114121.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_114121", "114121053", "story_v_out_114121.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_26 = math.max(var_220_17, arg_217_1.talkMaxDuration)

			if var_220_16 <= arg_217_1.time_ and arg_217_1.time_ < var_220_16 + var_220_26 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_16) / var_220_26

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_16 + var_220_26 and arg_217_1.time_ < var_220_16 + var_220_26 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play114121054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 114121054
		arg_221_1.duration_ = 4.27

		local var_221_0 = {
			ja = 4.266,
			ko = 2.933,
			zh = 2.566,
			en = 2.6
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play114121055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = arg_221_1.actors_["1184ui_story"]
			local var_224_1 = 0

			if var_224_1 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1184ui_story == nil then
				arg_221_1.var_.characterEffect1184ui_story = var_224_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_2 = 0.2

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_2 and not isNil(var_224_0) then
				local var_224_3 = (arg_221_1.time_ - var_224_1) / var_224_2

				if arg_221_1.var_.characterEffect1184ui_story and not isNil(var_224_0) then
					local var_224_4 = Mathf.Lerp(0, 0.5, var_224_3)

					arg_221_1.var_.characterEffect1184ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1184ui_story.fillRatio = var_224_4
				end
			end

			if arg_221_1.time_ >= var_224_1 + var_224_2 and arg_221_1.time_ < var_224_1 + var_224_2 + arg_224_0 and not isNil(var_224_0) and arg_221_1.var_.characterEffect1184ui_story then
				local var_224_5 = 0.5

				arg_221_1.var_.characterEffect1184ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1184ui_story.fillRatio = var_224_5
			end

			local var_224_6 = arg_221_1.actors_["1038ui_story"].transform
			local var_224_7 = 0

			if var_224_7 < arg_221_1.time_ and arg_221_1.time_ <= var_224_7 + arg_224_0 then
				arg_221_1.var_.moveOldPos1038ui_story = var_224_6.localPosition
			end

			local var_224_8 = 0.001

			if var_224_7 <= arg_221_1.time_ and arg_221_1.time_ < var_224_7 + var_224_8 then
				local var_224_9 = (arg_221_1.time_ - var_224_7) / var_224_8
				local var_224_10 = Vector3.New(0.7, -1.11, -5.9)

				var_224_6.localPosition = Vector3.Lerp(arg_221_1.var_.moveOldPos1038ui_story, var_224_10, var_224_9)

				local var_224_11 = manager.ui.mainCamera.transform.position - var_224_6.position

				var_224_6.forward = Vector3.New(var_224_11.x, var_224_11.y, var_224_11.z)

				local var_224_12 = var_224_6.localEulerAngles

				var_224_12.z = 0
				var_224_12.x = 0
				var_224_6.localEulerAngles = var_224_12
			end

			if arg_221_1.time_ >= var_224_7 + var_224_8 and arg_221_1.time_ < var_224_7 + var_224_8 + arg_224_0 then
				var_224_6.localPosition = Vector3.New(0.7, -1.11, -5.9)

				local var_224_13 = manager.ui.mainCamera.transform.position - var_224_6.position

				var_224_6.forward = Vector3.New(var_224_13.x, var_224_13.y, var_224_13.z)

				local var_224_14 = var_224_6.localEulerAngles

				var_224_14.z = 0
				var_224_14.x = 0
				var_224_6.localEulerAngles = var_224_14
			end

			local var_224_15 = 0

			if var_224_15 < arg_221_1.time_ and arg_221_1.time_ <= var_224_15 + arg_224_0 then
				arg_221_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			local var_224_16 = 0

			if var_224_16 < arg_221_1.time_ and arg_221_1.time_ <= var_224_16 + arg_224_0 then
				arg_221_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_224_17 = arg_221_1.actors_["1038ui_story"]
			local var_224_18 = 0

			if var_224_18 < arg_221_1.time_ and arg_221_1.time_ <= var_224_18 + arg_224_0 and not isNil(var_224_17) and arg_221_1.var_.characterEffect1038ui_story == nil then
				arg_221_1.var_.characterEffect1038ui_story = var_224_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_19 = 0.2

			if var_224_18 <= arg_221_1.time_ and arg_221_1.time_ < var_224_18 + var_224_19 and not isNil(var_224_17) then
				local var_224_20 = (arg_221_1.time_ - var_224_18) / var_224_19

				if arg_221_1.var_.characterEffect1038ui_story and not isNil(var_224_17) then
					arg_221_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_221_1.time_ >= var_224_18 + var_224_19 and arg_221_1.time_ < var_224_18 + var_224_19 + arg_224_0 and not isNil(var_224_17) and arg_221_1.var_.characterEffect1038ui_story then
				arg_221_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_224_21 = 0
			local var_224_22 = 0.35

			if var_224_21 < arg_221_1.time_ and arg_221_1.time_ <= var_224_21 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				local var_224_23 = arg_221_1:FormatText(StoryNameCfg[94].name)

				arg_221_1.leftNameTxt_.text = var_224_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_24 = arg_221_1:GetWordFromCfg(114121054)
				local var_224_25 = arg_221_1:FormatText(var_224_24.content)

				arg_221_1.text_.text = var_224_25

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_26 = 14
				local var_224_27 = utf8.len(var_224_25)
				local var_224_28 = var_224_26 <= 0 and var_224_22 or var_224_22 * (var_224_27 / var_224_26)

				if var_224_28 > 0 and var_224_22 < var_224_28 then
					arg_221_1.talkMaxDuration = var_224_28

					if var_224_28 + var_224_21 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_28 + var_224_21
					end
				end

				arg_221_1.text_.text = var_224_25
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114121", "114121054", "story_v_out_114121.awb") ~= 0 then
					local var_224_29 = manager.audio:GetVoiceLength("story_v_out_114121", "114121054", "story_v_out_114121.awb") / 1000

					if var_224_29 + var_224_21 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_29 + var_224_21
					end

					if var_224_24.prefab_name ~= "" and arg_221_1.actors_[var_224_24.prefab_name] ~= nil then
						local var_224_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_24.prefab_name].transform, "story_v_out_114121", "114121054", "story_v_out_114121.awb")

						arg_221_1:RecordAudio("114121054", var_224_30)
						arg_221_1:RecordAudio("114121054", var_224_30)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_114121", "114121054", "story_v_out_114121.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_114121", "114121054", "story_v_out_114121.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_31 = math.max(var_224_22, arg_221_1.talkMaxDuration)

			if var_224_21 <= arg_221_1.time_ and arg_221_1.time_ < var_224_21 + var_224_31 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_21) / var_224_31

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_21 + var_224_31 and arg_221_1.time_ < var_224_21 + var_224_31 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_221_1:InitPlayNodeList()
	end,
	Play114121055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 114121055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
			arg_225_1.auto_ = false
		end

		function arg_225_1.playNext_(arg_227_0)
			arg_225_1.onStoryFinished_()
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			local var_228_0 = arg_225_1.actors_["1184ui_story"].transform
			local var_228_1 = 0

			if var_228_1 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.var_.moveOldPos1184ui_story = var_228_0.localPosition

				local var_228_2 = "1184ui_story"

				arg_225_1:ShowWeapon(arg_225_1.var_[var_228_2 .. "Animator"].transform, false)
			end

			local var_228_3 = 0.001

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_3 then
				local var_228_4 = (arg_225_1.time_ - var_228_1) / var_228_3
				local var_228_5 = Vector3.New(0, 100, 0)

				var_228_0.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1184ui_story, var_228_5, var_228_4)

				local var_228_6 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_6.x, var_228_6.y, var_228_6.z)

				local var_228_7 = var_228_0.localEulerAngles

				var_228_7.z = 0
				var_228_7.x = 0
				var_228_0.localEulerAngles = var_228_7
			end

			if arg_225_1.time_ >= var_228_1 + var_228_3 and arg_225_1.time_ < var_228_1 + var_228_3 + arg_228_0 then
				var_228_0.localPosition = Vector3.New(0, 100, 0)

				local var_228_8 = manager.ui.mainCamera.transform.position - var_228_0.position

				var_228_0.forward = Vector3.New(var_228_8.x, var_228_8.y, var_228_8.z)

				local var_228_9 = var_228_0.localEulerAngles

				var_228_9.z = 0
				var_228_9.x = 0
				var_228_0.localEulerAngles = var_228_9
			end

			local var_228_10 = arg_225_1.actors_["1038ui_story"].transform
			local var_228_11 = 0

			if var_228_11 < arg_225_1.time_ and arg_225_1.time_ <= var_228_11 + arg_228_0 then
				arg_225_1.var_.moveOldPos1038ui_story = var_228_10.localPosition
			end

			local var_228_12 = 0.001

			if var_228_11 <= arg_225_1.time_ and arg_225_1.time_ < var_228_11 + var_228_12 then
				local var_228_13 = (arg_225_1.time_ - var_228_11) / var_228_12
				local var_228_14 = Vector3.New(0, 100, 0)

				var_228_10.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1038ui_story, var_228_14, var_228_13)

				local var_228_15 = manager.ui.mainCamera.transform.position - var_228_10.position

				var_228_10.forward = Vector3.New(var_228_15.x, var_228_15.y, var_228_15.z)

				local var_228_16 = var_228_10.localEulerAngles

				var_228_16.z = 0
				var_228_16.x = 0
				var_228_10.localEulerAngles = var_228_16
			end

			if arg_225_1.time_ >= var_228_11 + var_228_12 and arg_225_1.time_ < var_228_11 + var_228_12 + arg_228_0 then
				var_228_10.localPosition = Vector3.New(0, 100, 0)

				local var_228_17 = manager.ui.mainCamera.transform.position - var_228_10.position

				var_228_10.forward = Vector3.New(var_228_17.x, var_228_17.y, var_228_17.z)

				local var_228_18 = var_228_10.localEulerAngles

				var_228_18.z = 0
				var_228_18.x = 0
				var_228_10.localEulerAngles = var_228_18
			end

			local var_228_19 = 0
			local var_228_20 = 0.925

			if var_228_19 < arg_225_1.time_ and arg_225_1.time_ <= var_228_19 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_21 = arg_225_1:GetWordFromCfg(114121055)
				local var_228_22 = arg_225_1:FormatText(var_228_21.content)

				arg_225_1.text_.text = var_228_22

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_23 = 37
				local var_228_24 = utf8.len(var_228_22)
				local var_228_25 = var_228_23 <= 0 and var_228_20 or var_228_20 * (var_228_24 / var_228_23)

				if var_228_25 > 0 and var_228_20 < var_228_25 then
					arg_225_1.talkMaxDuration = var_228_25

					if var_228_25 + var_228_19 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_25 + var_228_19
					end
				end

				arg_225_1.text_.text = var_228_22
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_26 = math.max(var_228_20, arg_225_1.talkMaxDuration)

			if var_228_19 <= arg_225_1.time_ and arg_225_1.time_ < var_228_19 + var_228_26 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_19) / var_228_26

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_19 + var_228_26 and arg_225_1.time_ < var_228_19 + var_228_26 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1184ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F04",
		"TextureConfig/Background/F05_1"
	},
	voices = {
		"story_v_out_114121.awb"
	}
}
