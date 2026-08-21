return {
	Play122031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122031001
		arg_1_1.duration_ = 7.3

		local var_1_0 = {
			ja = 7.3,
			ko = 4.4,
			zh = 4.4
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
				arg_1_0:Play122031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST29a"

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
				local var_4_5 = arg_1_1.bgs_.ST29a

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
					if iter_4_0 ~= "ST29a" then
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

			local var_4_22 = "10044ui_story"

			if arg_1_1.actors_[var_4_22] == nil then
				local var_4_23 = Asset.Load("Char/" .. "10044ui_story")

				if not isNil(var_4_23) then
					local var_4_24 = Object.Instantiate(Asset.Load("Char/" .. "10044ui_story"), arg_1_1.stage_.transform)

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

			local var_4_27 = arg_1_1.actors_["10044ui_story"].transform
			local var_4_28 = 1.8

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.moveOldPos10044ui_story = var_4_27.localPosition
			end

			local var_4_29 = 0.001

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / var_4_29
				local var_4_31 = Vector3.New(0, -0.72, -6.3)

				var_4_27.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10044ui_story, var_4_31, var_4_30)

				local var_4_32 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_32.x, var_4_32.y, var_4_32.z)

				local var_4_33 = var_4_27.localEulerAngles

				var_4_33.z = 0
				var_4_33.x = 0
				var_4_27.localEulerAngles = var_4_33
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_4_34 = manager.ui.mainCamera.transform.position - var_4_27.position

				var_4_27.forward = Vector3.New(var_4_34.x, var_4_34.y, var_4_34.z)

				local var_4_35 = var_4_27.localEulerAngles

				var_4_35.z = 0
				var_4_35.x = 0
				var_4_27.localEulerAngles = var_4_35
			end

			local var_4_36 = arg_1_1.actors_["10044ui_story"]
			local var_4_37 = 1.8

			if var_4_37 < arg_1_1.time_ and arg_1_1.time_ <= var_4_37 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect10044ui_story == nil then
				arg_1_1.var_.characterEffect10044ui_story = var_4_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_38 = 0.200000002980232

			if var_4_37 <= arg_1_1.time_ and arg_1_1.time_ < var_4_37 + var_4_38 and not isNil(var_4_36) then
				local var_4_39 = (arg_1_1.time_ - var_4_37) / var_4_38

				if arg_1_1.var_.characterEffect10044ui_story and not isNil(var_4_36) then
					arg_1_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_37 + var_4_38 and arg_1_1.time_ < var_4_37 + var_4_38 + arg_4_0 and not isNil(var_4_36) and arg_1_1.var_.characterEffect10044ui_story then
				arg_1_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_4_40 = 1.8

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_4_41 = 1.8

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_4_42 = 0
			local var_4_43 = 0.4

			if var_4_42 < arg_1_1.time_ and arg_1_1.time_ <= var_4_42 + arg_4_0 then
				local var_4_44 = "play"
				local var_4_45 = "music"

				arg_1_1:AudioAction(var_4_44, var_4_45, "ui_battle", "ui_battle_stopbgm", "")

				local var_4_46 = ""
				local var_4_47 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_4_47 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_47 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_47

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_47
						arg_1_1.bgmTxt2_.text = var_4_47
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

			local var_4_48 = 1.30000000298023
			local var_4_49 = 0.7

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_activity_2_2_ui", "bgm_activity_2_2_ui", "bgm_activity_2_2_ui.awb")

				local var_4_52 = ""
				local var_4_53 = manager.audio:GetAudioName("bgm_activity_2_2_ui", "bgm_activity_2_2_ui")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_54 = 2
			local var_4_55 = 0.35

			if var_4_54 < arg_1_1.time_ and arg_1_1.time_ <= var_4_54 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_56 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_56:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_57 = arg_1_1:FormatText(StoryNameCfg[380].name)

				arg_1_1.leftNameTxt_.text = var_4_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_58 = arg_1_1:GetWordFromCfg(122031001)
				local var_4_59 = arg_1_1:FormatText(var_4_58.content)

				arg_1_1.text_.text = var_4_59

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_60 = 14
				local var_4_61 = utf8.len(var_4_59)
				local var_4_62 = var_4_60 <= 0 and var_4_55 or var_4_55 * (var_4_61 / var_4_60)

				if var_4_62 > 0 and var_4_55 < var_4_62 then
					arg_1_1.talkMaxDuration = var_4_62
					var_4_54 = var_4_54 + 0.3

					if var_4_62 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_62 + var_4_54
					end
				end

				arg_1_1.text_.text = var_4_59
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031001", "story_v_out_122031.awb") ~= 0 then
					local var_4_63 = manager.audio:GetVoiceLength("story_v_out_122031", "122031001", "story_v_out_122031.awb") / 1000

					if var_4_63 + var_4_54 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_63 + var_4_54
					end

					if var_4_58.prefab_name ~= "" and arg_1_1.actors_[var_4_58.prefab_name] ~= nil then
						local var_4_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_58.prefab_name].transform, "story_v_out_122031", "122031001", "story_v_out_122031.awb")

						arg_1_1:RecordAudio("122031001", var_4_64)
						arg_1_1:RecordAudio("122031001", var_4_64)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_122031", "122031001", "story_v_out_122031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_122031", "122031001", "story_v_out_122031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_65 = var_4_54 + 0.3
			local var_4_66 = math.max(var_4_55, arg_1_1.talkMaxDuration)

			if var_4_65 <= arg_1_1.time_ and arg_1_1.time_ < var_4_65 + var_4_66 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_65) / var_4_66

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_65 + var_4_66 and arg_1_1.time_ < var_4_65 + var_4_66 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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
	Play122031002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 122031002
		arg_9_1.duration_ = 6.9

		local var_9_0 = {
			ja = 6.9,
			ko = 6.466,
			zh = 6.466
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
				arg_9_0:Play122031003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = arg_9_1.actors_["10044ui_story"]
			local var_12_1 = 0

			if var_12_1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect10044ui_story == nil then
				arg_9_1.var_.characterEffect10044ui_story = var_12_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_2 and not isNil(var_12_0) then
				local var_12_3 = (arg_9_1.time_ - var_12_1) / var_12_2

				if arg_9_1.var_.characterEffect10044ui_story and not isNil(var_12_0) then
					local var_12_4 = Mathf.Lerp(0, 0.5, var_12_3)

					arg_9_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10044ui_story.fillRatio = var_12_4
				end
			end

			if arg_9_1.time_ >= var_12_1 + var_12_2 and arg_9_1.time_ < var_12_1 + var_12_2 + arg_12_0 and not isNil(var_12_0) and arg_9_1.var_.characterEffect10044ui_story then
				local var_12_5 = 0.5

				arg_9_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10044ui_story.fillRatio = var_12_5
			end

			local var_12_6 = 0
			local var_12_7 = 0.775

			if var_12_6 < arg_9_1.time_ and arg_9_1.time_ <= var_12_6 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				local var_12_8 = arg_9_1:FormatText(StoryNameCfg[433].name)

				arg_9_1.leftNameTxt_.text = var_12_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, true)
				arg_9_1.iconController_:SetSelectedState("hero")

				arg_9_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifangw")

				arg_9_1.callingController_:SetSelectedState("normal")

				arg_9_1.keyicon_.color = Color.New(1, 1, 1)
				arg_9_1.icon_.color = Color.New(1, 1, 1)

				local var_12_9 = arg_9_1:GetWordFromCfg(122031002)
				local var_12_10 = arg_9_1:FormatText(var_12_9.content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_11 = 31
				local var_12_12 = utf8.len(var_12_10)
				local var_12_13 = var_12_11 <= 0 and var_12_7 or var_12_7 * (var_12_12 / var_12_11)

				if var_12_13 > 0 and var_12_7 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_6
					end
				end

				arg_9_1.text_.text = var_12_10
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031002", "story_v_out_122031.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_122031", "122031002", "story_v_out_122031.awb") / 1000

					if var_12_14 + var_12_6 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_6
					end

					if var_12_9.prefab_name ~= "" and arg_9_1.actors_[var_12_9.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_9.prefab_name].transform, "story_v_out_122031", "122031002", "story_v_out_122031.awb")

						arg_9_1:RecordAudio("122031002", var_12_15)
						arg_9_1:RecordAudio("122031002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_122031", "122031002", "story_v_out_122031.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_122031", "122031002", "story_v_out_122031.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_7, arg_9_1.talkMaxDuration)

			if var_12_6 <= arg_9_1.time_ and arg_9_1.time_ < var_12_6 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_6) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_6 + var_12_16 and arg_9_1.time_ < var_12_6 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play122031003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 122031003
		arg_13_1.duration_ = 5.37

		local var_13_0 = {
			ja = 5.366,
			ko = 3.266,
			zh = 3.266
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
				arg_13_0:Play122031004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = arg_13_1.actors_["10044ui_story"]
			local var_16_1 = 0

			if var_16_1 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect10044ui_story == nil then
				arg_13_1.var_.characterEffect10044ui_story = var_16_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_2 and not isNil(var_16_0) then
				local var_16_3 = (arg_13_1.time_ - var_16_1) / var_16_2

				if arg_13_1.var_.characterEffect10044ui_story and not isNil(var_16_0) then
					arg_13_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= var_16_1 + var_16_2 and arg_13_1.time_ < var_16_1 + var_16_2 + arg_16_0 and not isNil(var_16_0) and arg_13_1.var_.characterEffect10044ui_story then
				arg_13_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_16_4 = 0

			if var_16_4 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_2")
			end

			local var_16_5 = 0
			local var_16_6 = 0.4

			if var_16_5 < arg_13_1.time_ and arg_13_1.time_ <= var_16_5 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				local var_16_7 = arg_13_1:FormatText(StoryNameCfg[380].name)

				arg_13_1.leftNameTxt_.text = var_16_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_8 = arg_13_1:GetWordFromCfg(122031003)
				local var_16_9 = arg_13_1:FormatText(var_16_8.content)

				arg_13_1.text_.text = var_16_9

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_10 = 16
				local var_16_11 = utf8.len(var_16_9)
				local var_16_12 = var_16_10 <= 0 and var_16_6 or var_16_6 * (var_16_11 / var_16_10)

				if var_16_12 > 0 and var_16_6 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12

					if var_16_12 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_5
					end
				end

				arg_13_1.text_.text = var_16_9
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031003", "story_v_out_122031.awb") ~= 0 then
					local var_16_13 = manager.audio:GetVoiceLength("story_v_out_122031", "122031003", "story_v_out_122031.awb") / 1000

					if var_16_13 + var_16_5 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_5
					end

					if var_16_8.prefab_name ~= "" and arg_13_1.actors_[var_16_8.prefab_name] ~= nil then
						local var_16_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_8.prefab_name].transform, "story_v_out_122031", "122031003", "story_v_out_122031.awb")

						arg_13_1:RecordAudio("122031003", var_16_14)
						arg_13_1:RecordAudio("122031003", var_16_14)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_122031", "122031003", "story_v_out_122031.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_122031", "122031003", "story_v_out_122031.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_15 = math.max(var_16_6, arg_13_1.talkMaxDuration)

			if var_16_5 <= arg_13_1.time_ and arg_13_1.time_ < var_16_5 + var_16_15 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_5) / var_16_15

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_5 + var_16_15 and arg_13_1.time_ < var_16_5 + var_16_15 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play122031004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 122031004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play122031005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = arg_17_1.actors_["10044ui_story"]
			local var_20_1 = 0

			if var_20_1 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10044ui_story == nil then
				arg_17_1.var_.characterEffect10044ui_story = var_20_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_2 and not isNil(var_20_0) then
				local var_20_3 = (arg_17_1.time_ - var_20_1) / var_20_2

				if arg_17_1.var_.characterEffect10044ui_story and not isNil(var_20_0) then
					local var_20_4 = Mathf.Lerp(0, 0.5, var_20_3)

					arg_17_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10044ui_story.fillRatio = var_20_4
				end
			end

			if arg_17_1.time_ >= var_20_1 + var_20_2 and arg_17_1.time_ < var_20_1 + var_20_2 + arg_20_0 and not isNil(var_20_0) and arg_17_1.var_.characterEffect10044ui_story then
				local var_20_5 = 0.5

				arg_17_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10044ui_story.fillRatio = var_20_5
			end

			local var_20_6 = arg_17_1.actors_["10044ui_story"].transform
			local var_20_7 = 0

			if var_20_7 < arg_17_1.time_ and arg_17_1.time_ <= var_20_7 + arg_20_0 then
				arg_17_1.var_.moveOldPos10044ui_story = var_20_6.localPosition
			end

			local var_20_8 = 0.001

			if var_20_7 <= arg_17_1.time_ and arg_17_1.time_ < var_20_7 + var_20_8 then
				local var_20_9 = (arg_17_1.time_ - var_20_7) / var_20_8
				local var_20_10 = Vector3.New(0, 100, 0)

				var_20_6.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10044ui_story, var_20_10, var_20_9)

				local var_20_11 = manager.ui.mainCamera.transform.position - var_20_6.position

				var_20_6.forward = Vector3.New(var_20_11.x, var_20_11.y, var_20_11.z)

				local var_20_12 = var_20_6.localEulerAngles

				var_20_12.z = 0
				var_20_12.x = 0
				var_20_6.localEulerAngles = var_20_12
			end

			if arg_17_1.time_ >= var_20_7 + var_20_8 and arg_17_1.time_ < var_20_7 + var_20_8 + arg_20_0 then
				var_20_6.localPosition = Vector3.New(0, 100, 0)

				local var_20_13 = manager.ui.mainCamera.transform.position - var_20_6.position

				var_20_6.forward = Vector3.New(var_20_13.x, var_20_13.y, var_20_13.z)

				local var_20_14 = var_20_6.localEulerAngles

				var_20_14.z = 0
				var_20_14.x = 0
				var_20_6.localEulerAngles = var_20_14
			end

			local var_20_15 = 0
			local var_20_16 = 1.15

			if var_20_15 < arg_17_1.time_ and arg_17_1.time_ <= var_20_15 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_17 = arg_17_1:GetWordFromCfg(122031004)
				local var_20_18 = arg_17_1:FormatText(var_20_17.content)

				arg_17_1.text_.text = var_20_18

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_19 = 46
				local var_20_20 = utf8.len(var_20_18)
				local var_20_21 = var_20_19 <= 0 and var_20_16 or var_20_16 * (var_20_20 / var_20_19)

				if var_20_21 > 0 and var_20_16 < var_20_21 then
					arg_17_1.talkMaxDuration = var_20_21

					if var_20_21 + var_20_15 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_21 + var_20_15
					end
				end

				arg_17_1.text_.text = var_20_18
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_22 = math.max(var_20_16, arg_17_1.talkMaxDuration)

			if var_20_15 <= arg_17_1.time_ and arg_17_1.time_ < var_20_15 + var_20_22 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_15) / var_20_22

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_15 + var_20_22 and arg_17_1.time_ < var_20_15 + var_20_22 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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
	Play122031005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 122031005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play122031006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0
			local var_24_1 = 0.866666666666667

			if var_24_0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_0 + arg_24_0 then
				local var_24_2 = "play"
				local var_24_3 = "effect"

				arg_21_1:AudioAction(var_24_2, var_24_3, "se_story_122_01", "se_story_122_01_buildinghit01", "")
			end

			local var_24_4 = 0
			local var_24_5 = 1.675

			if var_24_4 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(122031005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_8 = 67
				local var_24_9 = utf8.len(var_24_7)
				local var_24_10 = var_24_8 <= 0 and var_24_5 or var_24_5 * (var_24_9 / var_24_8)

				if var_24_10 > 0 and var_24_5 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_11 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_11 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_11

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_11 and arg_21_1.time_ < var_24_4 + var_24_11 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play122031006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 122031006
		arg_25_1.duration_ = 4.5

		local var_25_0 = {
			ja = 4.5,
			ko = 3,
			zh = 3
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
				arg_25_0:Play122031007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0
			local var_28_1 = 1

			if var_28_0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_0 + arg_28_0 then
				local var_28_2 = "play"
				local var_28_3 = "effect"

				arg_25_1:AudioAction(var_28_2, var_28_3, "se_story_122_01", "se_story_122_01_monsterattack01_loop", "")
			end

			local var_28_4 = 0
			local var_28_5 = 0.375

			if var_28_4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				local var_28_6 = arg_25_1:FormatText(StoryNameCfg[433].name)

				arg_25_1.leftNameTxt_.text = var_28_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifangw")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_7 = arg_25_1:GetWordFromCfg(122031006)
				local var_28_8 = arg_25_1:FormatText(var_28_7.content)

				arg_25_1.text_.text = var_28_8

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 15
				local var_28_10 = utf8.len(var_28_8)
				local var_28_11 = var_28_9 <= 0 and var_28_5 or var_28_5 * (var_28_10 / var_28_9)

				if var_28_11 > 0 and var_28_5 < var_28_11 then
					arg_25_1.talkMaxDuration = var_28_11

					if var_28_11 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_11 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_8
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031006", "story_v_out_122031.awb") ~= 0 then
					local var_28_12 = manager.audio:GetVoiceLength("story_v_out_122031", "122031006", "story_v_out_122031.awb") / 1000

					if var_28_12 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_4
					end

					if var_28_7.prefab_name ~= "" and arg_25_1.actors_[var_28_7.prefab_name] ~= nil then
						local var_28_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_7.prefab_name].transform, "story_v_out_122031", "122031006", "story_v_out_122031.awb")

						arg_25_1:RecordAudio("122031006", var_28_13)
						arg_25_1:RecordAudio("122031006", var_28_13)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_122031", "122031006", "story_v_out_122031.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_122031", "122031006", "story_v_out_122031.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_14 and arg_25_1.time_ < var_28_4 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play122031007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 122031007
		arg_29_1.duration_ = 5.9

		local var_29_0 = {
			ja = 5.9,
			ko = 1.999999999999,
			zh = 1.999999999999
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
				arg_29_0:Play122031008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = arg_29_1.actors_["10044ui_story"].transform
			local var_32_1 = 0

			if var_32_1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.var_.moveOldPos10044ui_story = var_32_0.localPosition
			end

			local var_32_2 = 0.001

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_2 then
				local var_32_3 = (arg_29_1.time_ - var_32_1) / var_32_2
				local var_32_4 = Vector3.New(0, -0.72, -6.3)

				var_32_0.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10044ui_story, var_32_4, var_32_3)

				local var_32_5 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_5.x, var_32_5.y, var_32_5.z)

				local var_32_6 = var_32_0.localEulerAngles

				var_32_6.z = 0
				var_32_6.x = 0
				var_32_0.localEulerAngles = var_32_6
			end

			if arg_29_1.time_ >= var_32_1 + var_32_2 and arg_29_1.time_ < var_32_1 + var_32_2 + arg_32_0 then
				var_32_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_32_7 = manager.ui.mainCamera.transform.position - var_32_0.position

				var_32_0.forward = Vector3.New(var_32_7.x, var_32_7.y, var_32_7.z)

				local var_32_8 = var_32_0.localEulerAngles

				var_32_8.z = 0
				var_32_8.x = 0
				var_32_0.localEulerAngles = var_32_8
			end

			local var_32_9 = arg_29_1.actors_["10044ui_story"]
			local var_32_10 = 0

			if var_32_10 < arg_29_1.time_ and arg_29_1.time_ <= var_32_10 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect10044ui_story == nil then
				arg_29_1.var_.characterEffect10044ui_story = var_32_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_11 = 0.200000002980232

			if var_32_10 <= arg_29_1.time_ and arg_29_1.time_ < var_32_10 + var_32_11 and not isNil(var_32_9) then
				local var_32_12 = (arg_29_1.time_ - var_32_10) / var_32_11

				if arg_29_1.var_.characterEffect10044ui_story and not isNil(var_32_9) then
					arg_29_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= var_32_10 + var_32_11 and arg_29_1.time_ < var_32_10 + var_32_11 + arg_32_0 and not isNil(var_32_9) and arg_29_1.var_.characterEffect10044ui_story then
				arg_29_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_32_13 = 0

			if var_32_13 < arg_29_1.time_ and arg_29_1.time_ <= var_32_13 + arg_32_0 then
				arg_29_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_32_14 = 0

			if var_32_14 < arg_29_1.time_ and arg_29_1.time_ <= var_32_14 + arg_32_0 then
				arg_29_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_32_15 = 0
			local var_32_16 = 0.4

			if var_32_15 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				local var_32_17 = "play"
				local var_32_18 = "effect"

				arg_29_1:AudioAction(var_32_17, var_32_18, "se_story_122_01", "se_story_122_01_buildinghit02", "")
			end

			local var_32_19 = 0.433333333333333
			local var_32_20 = 0.466666666666667

			if var_32_19 < arg_29_1.time_ and arg_29_1.time_ <= var_32_19 + arg_32_0 then
				local var_32_21 = "play"
				local var_32_22 = "effect"

				arg_29_1:AudioAction(var_32_21, var_32_22, "se_story_122_01", "se_story_122_01_buildinghit01", "")
			end

			local var_32_23 = 0
			local var_32_24 = 0.125

			if var_32_23 < arg_29_1.time_ and arg_29_1.time_ <= var_32_23 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				local var_32_25 = arg_29_1:FormatText(StoryNameCfg[380].name)

				arg_29_1.leftNameTxt_.text = var_32_25

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_26 = arg_29_1:GetWordFromCfg(122031007)
				local var_32_27 = arg_29_1:FormatText(var_32_26.content)

				arg_29_1.text_.text = var_32_27

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_28 = 5
				local var_32_29 = utf8.len(var_32_27)
				local var_32_30 = var_32_28 <= 0 and var_32_24 or var_32_24 * (var_32_29 / var_32_28)

				if var_32_30 > 0 and var_32_24 < var_32_30 then
					arg_29_1.talkMaxDuration = var_32_30

					if var_32_30 + var_32_23 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_30 + var_32_23
					end
				end

				arg_29_1.text_.text = var_32_27
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031007", "story_v_out_122031.awb") ~= 0 then
					local var_32_31 = manager.audio:GetVoiceLength("story_v_out_122031", "122031007", "story_v_out_122031.awb") / 1000

					if var_32_31 + var_32_23 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_31 + var_32_23
					end

					if var_32_26.prefab_name ~= "" and arg_29_1.actors_[var_32_26.prefab_name] ~= nil then
						local var_32_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_26.prefab_name].transform, "story_v_out_122031", "122031007", "story_v_out_122031.awb")

						arg_29_1:RecordAudio("122031007", var_32_32)
						arg_29_1:RecordAudio("122031007", var_32_32)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_122031", "122031007", "story_v_out_122031.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_122031", "122031007", "story_v_out_122031.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_33 = math.max(var_32_24, arg_29_1.talkMaxDuration)

			if var_32_23 <= arg_29_1.time_ and arg_29_1.time_ < var_32_23 + var_32_33 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_23) / var_32_33

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_23 + var_32_33 and arg_29_1.time_ < var_32_23 + var_32_33 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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
	Play122031008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 122031008
		arg_33_1.duration_ = 14.3

		local var_33_0 = {
			ja = 13.7,
			ko = 14.3,
			zh = 14.3
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
				arg_33_0:Play122031009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0

			if var_36_0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_0 + arg_36_0 then
				arg_33_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_36_1 = 0

			if var_36_1 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_36_2 = 0
			local var_36_3 = 1.4

			if var_36_2 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				local var_36_4 = arg_33_1:FormatText(StoryNameCfg[380].name)

				arg_33_1.leftNameTxt_.text = var_36_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_5 = arg_33_1:GetWordFromCfg(122031008)
				local var_36_6 = arg_33_1:FormatText(var_36_5.content)

				arg_33_1.text_.text = var_36_6

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_7 = 56
				local var_36_8 = utf8.len(var_36_6)
				local var_36_9 = var_36_7 <= 0 and var_36_3 or var_36_3 * (var_36_8 / var_36_7)

				if var_36_9 > 0 and var_36_3 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_6
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031008", "story_v_out_122031.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_122031", "122031008", "story_v_out_122031.awb") / 1000

					if var_36_10 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_2
					end

					if var_36_5.prefab_name ~= "" and arg_33_1.actors_[var_36_5.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_5.prefab_name].transform, "story_v_out_122031", "122031008", "story_v_out_122031.awb")

						arg_33_1:RecordAudio("122031008", var_36_11)
						arg_33_1:RecordAudio("122031008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_122031", "122031008", "story_v_out_122031.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_122031", "122031008", "story_v_out_122031.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_12 and arg_33_1.time_ < var_36_2 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play122031009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 122031009
		arg_37_1.duration_ = 5.3

		local var_37_0 = {
			ja = 4.466,
			ko = 5.3,
			zh = 5.3
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
				arg_37_0:Play122031010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_0 = 0
			local var_40_1 = 0.7

			if var_40_0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				local var_40_2 = arg_37_1:FormatText(StoryNameCfg[380].name)

				arg_37_1.leftNameTxt_.text = var_40_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_3 = arg_37_1:GetWordFromCfg(122031009)
				local var_40_4 = arg_37_1:FormatText(var_40_3.content)

				arg_37_1.text_.text = var_40_4

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 28
				local var_40_6 = utf8.len(var_40_4)
				local var_40_7 = var_40_5 <= 0 and var_40_1 or var_40_1 * (var_40_6 / var_40_5)

				if var_40_7 > 0 and var_40_1 < var_40_7 then
					arg_37_1.talkMaxDuration = var_40_7

					if var_40_7 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_7 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_4
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031009", "story_v_out_122031.awb") ~= 0 then
					local var_40_8 = manager.audio:GetVoiceLength("story_v_out_122031", "122031009", "story_v_out_122031.awb") / 1000

					if var_40_8 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_0
					end

					if var_40_3.prefab_name ~= "" and arg_37_1.actors_[var_40_3.prefab_name] ~= nil then
						local var_40_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_3.prefab_name].transform, "story_v_out_122031", "122031009", "story_v_out_122031.awb")

						arg_37_1:RecordAudio("122031009", var_40_9)
						arg_37_1:RecordAudio("122031009", var_40_9)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_122031", "122031009", "story_v_out_122031.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_122031", "122031009", "story_v_out_122031.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_10 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_10 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_10

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_10 and arg_37_1.time_ < var_40_0 + var_40_10 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play122031010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 122031010
		arg_41_1.duration_ = 6.87

		local var_41_0 = {
			ja = 4.5,
			ko = 6.866,
			zh = 6.866
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
				arg_41_0:Play122031011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = arg_41_1.actors_["10044ui_story"]
			local var_44_1 = 0

			if var_44_1 < arg_41_1.time_ and arg_41_1.time_ <= var_44_1 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10044ui_story == nil then
				arg_41_1.var_.characterEffect10044ui_story = var_44_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if var_44_1 <= arg_41_1.time_ and arg_41_1.time_ < var_44_1 + var_44_2 and not isNil(var_44_0) then
				local var_44_3 = (arg_41_1.time_ - var_44_1) / var_44_2

				if arg_41_1.var_.characterEffect10044ui_story and not isNil(var_44_0) then
					local var_44_4 = Mathf.Lerp(0, 0.5, var_44_3)

					arg_41_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_41_1.var_.characterEffect10044ui_story.fillRatio = var_44_4
				end
			end

			if arg_41_1.time_ >= var_44_1 + var_44_2 and arg_41_1.time_ < var_44_1 + var_44_2 + arg_44_0 and not isNil(var_44_0) and arg_41_1.var_.characterEffect10044ui_story then
				local var_44_5 = 0.5

				arg_41_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_41_1.var_.characterEffect10044ui_story.fillRatio = var_44_5
			end

			local var_44_6 = 0
			local var_44_7 = 0.675

			if var_44_6 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				local var_44_8 = arg_41_1:FormatText(StoryNameCfg[433].name)

				arg_41_1.leftNameTxt_.text = var_44_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, true)
				arg_41_1.iconController_:SetSelectedState("hero")

				arg_41_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifangw")

				arg_41_1.callingController_:SetSelectedState("normal")

				arg_41_1.keyicon_.color = Color.New(1, 1, 1)
				arg_41_1.icon_.color = Color.New(1, 1, 1)

				local var_44_9 = arg_41_1:GetWordFromCfg(122031010)
				local var_44_10 = arg_41_1:FormatText(var_44_9.content)

				arg_41_1.text_.text = var_44_10

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 27
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

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031010", "story_v_out_122031.awb") ~= 0 then
					local var_44_14 = manager.audio:GetVoiceLength("story_v_out_122031", "122031010", "story_v_out_122031.awb") / 1000

					if var_44_14 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_14 + var_44_6
					end

					if var_44_9.prefab_name ~= "" and arg_41_1.actors_[var_44_9.prefab_name] ~= nil then
						local var_44_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_9.prefab_name].transform, "story_v_out_122031", "122031010", "story_v_out_122031.awb")

						arg_41_1:RecordAudio("122031010", var_44_15)
						arg_41_1:RecordAudio("122031010", var_44_15)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_122031", "122031010", "story_v_out_122031.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_122031", "122031010", "story_v_out_122031.awb")
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
	Play122031011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 122031011
		arg_45_1.duration_ = 7.7

		local var_45_0 = {
			ja = 7.666,
			ko = 7.7,
			zh = 7.7
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
				arg_45_0:Play122031012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 0
			local var_48_1 = 0.825

			if var_48_0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				local var_48_2 = arg_45_1:FormatText(StoryNameCfg[433].name)

				arg_45_1.leftNameTxt_.text = var_48_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, true)
				arg_45_1.iconController_:SetSelectedState("hero")

				arg_45_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifangw")

				arg_45_1.callingController_:SetSelectedState("normal")

				arg_45_1.keyicon_.color = Color.New(1, 1, 1)
				arg_45_1.icon_.color = Color.New(1, 1, 1)

				local var_48_3 = arg_45_1:GetWordFromCfg(122031011)
				local var_48_4 = arg_45_1:FormatText(var_48_3.content)

				arg_45_1.text_.text = var_48_4

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 33
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

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031011", "story_v_out_122031.awb") ~= 0 then
					local var_48_8 = manager.audio:GetVoiceLength("story_v_out_122031", "122031011", "story_v_out_122031.awb") / 1000

					if var_48_8 + var_48_0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_0
					end

					if var_48_3.prefab_name ~= "" and arg_45_1.actors_[var_48_3.prefab_name] ~= nil then
						local var_48_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_3.prefab_name].transform, "story_v_out_122031", "122031011", "story_v_out_122031.awb")

						arg_45_1:RecordAudio("122031011", var_48_9)
						arg_45_1:RecordAudio("122031011", var_48_9)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_122031", "122031011", "story_v_out_122031.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_122031", "122031011", "story_v_out_122031.awb")
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
	Play122031012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 122031012
		arg_49_1.duration_ = 2.53

		local var_49_0 = {
			ja = 2.066,
			ko = 2.533,
			zh = 2.533
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
				arg_49_0:Play122031013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = arg_49_1.actors_["10044ui_story"]
			local var_52_1 = 0

			if var_52_1 < arg_49_1.time_ and arg_49_1.time_ <= var_52_1 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10044ui_story == nil then
				arg_49_1.var_.characterEffect10044ui_story = var_52_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if var_52_1 <= arg_49_1.time_ and arg_49_1.time_ < var_52_1 + var_52_2 and not isNil(var_52_0) then
				local var_52_3 = (arg_49_1.time_ - var_52_1) / var_52_2

				if arg_49_1.var_.characterEffect10044ui_story and not isNil(var_52_0) then
					arg_49_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= var_52_1 + var_52_2 and arg_49_1.time_ < var_52_1 + var_52_2 + arg_52_0 and not isNil(var_52_0) and arg_49_1.var_.characterEffect10044ui_story then
				arg_49_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_52_4 = 0

			if var_52_4 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_2")
			end

			local var_52_5 = 0

			if var_52_5 < arg_49_1.time_ and arg_49_1.time_ <= var_52_5 + arg_52_0 then
				arg_49_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_52_6 = 0
			local var_52_7 = 0.25

			if var_52_6 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				local var_52_8 = arg_49_1:FormatText(StoryNameCfg[380].name)

				arg_49_1.leftNameTxt_.text = var_52_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_9 = arg_49_1:GetWordFromCfg(122031012)
				local var_52_10 = arg_49_1:FormatText(var_52_9.content)

				arg_49_1.text_.text = var_52_10

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 10
				local var_52_12 = utf8.len(var_52_10)
				local var_52_13 = var_52_11 <= 0 and var_52_7 or var_52_7 * (var_52_12 / var_52_11)

				if var_52_13 > 0 and var_52_7 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_10
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031012", "story_v_out_122031.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_122031", "122031012", "story_v_out_122031.awb") / 1000

					if var_52_14 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_6
					end

					if var_52_9.prefab_name ~= "" and arg_49_1.actors_[var_52_9.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_9.prefab_name].transform, "story_v_out_122031", "122031012", "story_v_out_122031.awb")

						arg_49_1:RecordAudio("122031012", var_52_15)
						arg_49_1:RecordAudio("122031012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_122031", "122031012", "story_v_out_122031.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_122031", "122031012", "story_v_out_122031.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_16 and arg_49_1.time_ < var_52_6 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play122031013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 122031013
		arg_53_1.duration_ = 10.7

		local var_53_0 = {
			ja = 9.933,
			ko = 10.7,
			zh = 10.7
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
				arg_53_0:Play122031014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0
			local var_56_1 = 1.225

			if var_56_0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				local var_56_2 = arg_53_1:FormatText(StoryNameCfg[380].name)

				arg_53_1.leftNameTxt_.text = var_56_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_3 = arg_53_1:GetWordFromCfg(122031013)
				local var_56_4 = arg_53_1:FormatText(var_56_3.content)

				arg_53_1.text_.text = var_56_4

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_5 = 49
				local var_56_6 = utf8.len(var_56_4)
				local var_56_7 = var_56_5 <= 0 and var_56_1 or var_56_1 * (var_56_6 / var_56_5)

				if var_56_7 > 0 and var_56_1 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_4
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031013", "story_v_out_122031.awb") ~= 0 then
					local var_56_8 = manager.audio:GetVoiceLength("story_v_out_122031", "122031013", "story_v_out_122031.awb") / 1000

					if var_56_8 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_8 + var_56_0
					end

					if var_56_3.prefab_name ~= "" and arg_53_1.actors_[var_56_3.prefab_name] ~= nil then
						local var_56_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_3.prefab_name].transform, "story_v_out_122031", "122031013", "story_v_out_122031.awb")

						arg_53_1:RecordAudio("122031013", var_56_9)
						arg_53_1:RecordAudio("122031013", var_56_9)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_122031", "122031013", "story_v_out_122031.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_122031", "122031013", "story_v_out_122031.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_10 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_10 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_10

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_10 and arg_53_1.time_ < var_56_0 + var_56_10 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play122031014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 122031014
		arg_57_1.duration_ = 8.9

		local var_57_0 = {
			ja = 8.6,
			ko = 8.9,
			zh = 8.9
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
				arg_57_0:Play122031015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0
			local var_60_1 = 1.05

			if var_60_0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				local var_60_2 = arg_57_1:FormatText(StoryNameCfg[380].name)

				arg_57_1.leftNameTxt_.text = var_60_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_3 = arg_57_1:GetWordFromCfg(122031014)
				local var_60_4 = arg_57_1:FormatText(var_60_3.content)

				arg_57_1.text_.text = var_60_4

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_5 = 42
				local var_60_6 = utf8.len(var_60_4)
				local var_60_7 = var_60_5 <= 0 and var_60_1 or var_60_1 * (var_60_6 / var_60_5)

				if var_60_7 > 0 and var_60_1 < var_60_7 then
					arg_57_1.talkMaxDuration = var_60_7

					if var_60_7 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_7 + var_60_0
					end
				end

				arg_57_1.text_.text = var_60_4
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031014", "story_v_out_122031.awb") ~= 0 then
					local var_60_8 = manager.audio:GetVoiceLength("story_v_out_122031", "122031014", "story_v_out_122031.awb") / 1000

					if var_60_8 + var_60_0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_0
					end

					if var_60_3.prefab_name ~= "" and arg_57_1.actors_[var_60_3.prefab_name] ~= nil then
						local var_60_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_3.prefab_name].transform, "story_v_out_122031", "122031014", "story_v_out_122031.awb")

						arg_57_1:RecordAudio("122031014", var_60_9)
						arg_57_1:RecordAudio("122031014", var_60_9)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_122031", "122031014", "story_v_out_122031.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_122031", "122031014", "story_v_out_122031.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_10 = math.max(var_60_1, arg_57_1.talkMaxDuration)

			if var_60_0 <= arg_57_1.time_ and arg_57_1.time_ < var_60_0 + var_60_10 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_0) / var_60_10

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_0 + var_60_10 and arg_57_1.time_ < var_60_0 + var_60_10 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play122031015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 122031015
		arg_61_1.duration_ = 12.8

		local var_61_0 = {
			ja = 10.7,
			ko = 12.8,
			zh = 12.8
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
				arg_61_0:Play122031016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			local var_64_0 = 0
			local var_64_1 = 1.55

			if var_64_0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_0 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				local var_64_2 = arg_61_1:FormatText(StoryNameCfg[380].name)

				arg_61_1.leftNameTxt_.text = var_64_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_3 = arg_61_1:GetWordFromCfg(122031015)
				local var_64_4 = arg_61_1:FormatText(var_64_3.content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_5 = 62
				local var_64_6 = utf8.len(var_64_4)
				local var_64_7 = var_64_5 <= 0 and var_64_1 or var_64_1 * (var_64_6 / var_64_5)

				if var_64_7 > 0 and var_64_1 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_0
					end
				end

				arg_61_1.text_.text = var_64_4
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031015", "story_v_out_122031.awb") ~= 0 then
					local var_64_8 = manager.audio:GetVoiceLength("story_v_out_122031", "122031015", "story_v_out_122031.awb") / 1000

					if var_64_8 + var_64_0 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_0
					end

					if var_64_3.prefab_name ~= "" and arg_61_1.actors_[var_64_3.prefab_name] ~= nil then
						local var_64_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_3.prefab_name].transform, "story_v_out_122031", "122031015", "story_v_out_122031.awb")

						arg_61_1:RecordAudio("122031015", var_64_9)
						arg_61_1:RecordAudio("122031015", var_64_9)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_122031", "122031015", "story_v_out_122031.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_122031", "122031015", "story_v_out_122031.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_10 = math.max(var_64_1, arg_61_1.talkMaxDuration)

			if var_64_0 <= arg_61_1.time_ and arg_61_1.time_ < var_64_0 + var_64_10 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_0) / var_64_10

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_0 + var_64_10 and arg_61_1.time_ < var_64_0 + var_64_10 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play122031016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 122031016
		arg_65_1.duration_ = 10.13

		local var_65_0 = {
			ja = 9.333,
			ko = 10.133,
			zh = 10.133
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
				arg_65_0:Play122031017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = arg_65_1.actors_["10044ui_story"]
			local var_68_1 = 0

			if var_68_1 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10044ui_story == nil then
				arg_65_1.var_.characterEffect10044ui_story = var_68_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_2 and not isNil(var_68_0) then
				local var_68_3 = (arg_65_1.time_ - var_68_1) / var_68_2

				if arg_65_1.var_.characterEffect10044ui_story and not isNil(var_68_0) then
					local var_68_4 = Mathf.Lerp(0, 0.5, var_68_3)

					arg_65_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10044ui_story.fillRatio = var_68_4
				end
			end

			if arg_65_1.time_ >= var_68_1 + var_68_2 and arg_65_1.time_ < var_68_1 + var_68_2 + arg_68_0 and not isNil(var_68_0) and arg_65_1.var_.characterEffect10044ui_story then
				local var_68_5 = 0.5

				arg_65_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10044ui_story.fillRatio = var_68_5
			end

			local var_68_6 = 0
			local var_68_7 = 1

			if var_68_6 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				local var_68_8 = arg_65_1:FormatText(StoryNameCfg[433].name)

				arg_65_1.leftNameTxt_.text = var_68_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifangw")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_9 = arg_65_1:GetWordFromCfg(122031016)
				local var_68_10 = arg_65_1:FormatText(var_68_9.content)

				arg_65_1.text_.text = var_68_10

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 40
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

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031016", "story_v_out_122031.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_122031", "122031016", "story_v_out_122031.awb") / 1000

					if var_68_14 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_6
					end

					if var_68_9.prefab_name ~= "" and arg_65_1.actors_[var_68_9.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_9.prefab_name].transform, "story_v_out_122031", "122031016", "story_v_out_122031.awb")

						arg_65_1:RecordAudio("122031016", var_68_15)
						arg_65_1:RecordAudio("122031016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_122031", "122031016", "story_v_out_122031.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_122031", "122031016", "story_v_out_122031.awb")
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
	Play122031017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 122031017
		arg_69_1.duration_ = 10.83

		local var_69_0 = {
			ja = 5.766,
			ko = 10.833,
			zh = 10.833
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
				arg_69_0:Play122031018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = arg_69_1.actors_["10044ui_story"]
			local var_72_1 = 0

			if var_72_1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10044ui_story == nil then
				arg_69_1.var_.characterEffect10044ui_story = var_72_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_2 and not isNil(var_72_0) then
				local var_72_3 = (arg_69_1.time_ - var_72_1) / var_72_2

				if arg_69_1.var_.characterEffect10044ui_story and not isNil(var_72_0) then
					arg_69_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= var_72_1 + var_72_2 and arg_69_1.time_ < var_72_1 + var_72_2 + arg_72_0 and not isNil(var_72_0) and arg_69_1.var_.characterEffect10044ui_story then
				arg_69_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_72_4 = 0

			if var_72_4 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_72_5 = 0

			if var_72_5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_5 + arg_72_0 then
				arg_69_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_72_6 = 0
			local var_72_7 = 1.375

			if var_72_6 < arg_69_1.time_ and arg_69_1.time_ <= var_72_6 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				local var_72_8 = arg_69_1:FormatText(StoryNameCfg[380].name)

				arg_69_1.leftNameTxt_.text = var_72_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_9 = arg_69_1:GetWordFromCfg(122031017)
				local var_72_10 = arg_69_1:FormatText(var_72_9.content)

				arg_69_1.text_.text = var_72_10

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_11 = 55
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

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031017", "story_v_out_122031.awb") ~= 0 then
					local var_72_14 = manager.audio:GetVoiceLength("story_v_out_122031", "122031017", "story_v_out_122031.awb") / 1000

					if var_72_14 + var_72_6 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_14 + var_72_6
					end

					if var_72_9.prefab_name ~= "" and arg_69_1.actors_[var_72_9.prefab_name] ~= nil then
						local var_72_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_9.prefab_name].transform, "story_v_out_122031", "122031017", "story_v_out_122031.awb")

						arg_69_1:RecordAudio("122031017", var_72_15)
						arg_69_1:RecordAudio("122031017", var_72_15)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_122031", "122031017", "story_v_out_122031.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_122031", "122031017", "story_v_out_122031.awb")
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
	Play122031018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 122031018
		arg_73_1.duration_ = 7.63

		local var_73_0 = {
			ja = 7.633,
			ko = 3.933,
			zh = 3.933
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
				arg_73_0:Play122031019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = arg_73_1.actors_["10044ui_story"]
			local var_76_1 = 0

			if var_76_1 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10044ui_story == nil then
				arg_73_1.var_.characterEffect10044ui_story = var_76_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_2 = 0.200000002980232

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_2 and not isNil(var_76_0) then
				local var_76_3 = (arg_73_1.time_ - var_76_1) / var_76_2

				if arg_73_1.var_.characterEffect10044ui_story and not isNil(var_76_0) then
					local var_76_4 = Mathf.Lerp(0, 0.5, var_76_3)

					arg_73_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10044ui_story.fillRatio = var_76_4
				end
			end

			if arg_73_1.time_ >= var_76_1 + var_76_2 and arg_73_1.time_ < var_76_1 + var_76_2 + arg_76_0 and not isNil(var_76_0) and arg_73_1.var_.characterEffect10044ui_story then
				local var_76_5 = 0.5

				arg_73_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10044ui_story.fillRatio = var_76_5
			end

			local var_76_6 = 0
			local var_76_7 = 0.25

			if var_76_6 < arg_73_1.time_ and arg_73_1.time_ <= var_76_6 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				local var_76_8 = arg_73_1:FormatText(StoryNameCfg[433].name)

				arg_73_1.leftNameTxt_.text = var_76_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifangw")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_9 = arg_73_1:GetWordFromCfg(122031018)
				local var_76_10 = arg_73_1:FormatText(var_76_9.content)

				arg_73_1.text_.text = var_76_10

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_11 = 10
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

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031018", "story_v_out_122031.awb") ~= 0 then
					local var_76_14 = manager.audio:GetVoiceLength("story_v_out_122031", "122031018", "story_v_out_122031.awb") / 1000

					if var_76_14 + var_76_6 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_14 + var_76_6
					end

					if var_76_9.prefab_name ~= "" and arg_73_1.actors_[var_76_9.prefab_name] ~= nil then
						local var_76_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_9.prefab_name].transform, "story_v_out_122031", "122031018", "story_v_out_122031.awb")

						arg_73_1:RecordAudio("122031018", var_76_15)
						arg_73_1:RecordAudio("122031018", var_76_15)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_122031", "122031018", "story_v_out_122031.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_122031", "122031018", "story_v_out_122031.awb")
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
	Play122031019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 122031019
		arg_77_1.duration_ = 8.53

		local var_77_0 = {
			ja = 7.566,
			ko = 8.533,
			zh = 8.533
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
				arg_77_0:Play122031020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0
			local var_80_1 = 0.9

			if var_80_0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				local var_80_2 = arg_77_1:FormatText(StoryNameCfg[433].name)

				arg_77_1.leftNameTxt_.text = var_80_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifangw")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_3 = arg_77_1:GetWordFromCfg(122031019)
				local var_80_4 = arg_77_1:FormatText(var_80_3.content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_5 = 36
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

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031019", "story_v_out_122031.awb") ~= 0 then
					local var_80_8 = manager.audio:GetVoiceLength("story_v_out_122031", "122031019", "story_v_out_122031.awb") / 1000

					if var_80_8 + var_80_0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_8 + var_80_0
					end

					if var_80_3.prefab_name ~= "" and arg_77_1.actors_[var_80_3.prefab_name] ~= nil then
						local var_80_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_3.prefab_name].transform, "story_v_out_122031", "122031019", "story_v_out_122031.awb")

						arg_77_1:RecordAudio("122031019", var_80_9)
						arg_77_1:RecordAudio("122031019", var_80_9)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_122031", "122031019", "story_v_out_122031.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_122031", "122031019", "story_v_out_122031.awb")
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
	Play122031020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 122031020
		arg_81_1.duration_ = 8.8

		local var_81_0 = {
			ja = 8.8,
			ko = 8.033,
			zh = 8.033
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
				arg_81_0:Play122031021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			local var_84_0 = arg_81_1.actors_["10044ui_story"]
			local var_84_1 = 0

			if var_84_1 < arg_81_1.time_ and arg_81_1.time_ <= var_84_1 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10044ui_story == nil then
				arg_81_1.var_.characterEffect10044ui_story = var_84_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if var_84_1 <= arg_81_1.time_ and arg_81_1.time_ < var_84_1 + var_84_2 and not isNil(var_84_0) then
				local var_84_3 = (arg_81_1.time_ - var_84_1) / var_84_2

				if arg_81_1.var_.characterEffect10044ui_story and not isNil(var_84_0) then
					arg_81_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= var_84_1 + var_84_2 and arg_81_1.time_ < var_84_1 + var_84_2 + arg_84_0 and not isNil(var_84_0) and arg_81_1.var_.characterEffect10044ui_story then
				arg_81_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_84_4 = 0

			if var_84_4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action437")
			end

			local var_84_5 = 0

			if var_84_5 < arg_81_1.time_ and arg_81_1.time_ <= var_84_5 + arg_84_0 then
				arg_81_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_84_6 = 0
			local var_84_7 = 1.075

			if var_84_6 < arg_81_1.time_ and arg_81_1.time_ <= var_84_6 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				local var_84_8 = arg_81_1:FormatText(StoryNameCfg[380].name)

				arg_81_1.leftNameTxt_.text = var_84_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_9 = arg_81_1:GetWordFromCfg(122031020)
				local var_84_10 = arg_81_1:FormatText(var_84_9.content)

				arg_81_1.text_.text = var_84_10

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_11 = 43
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

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031020", "story_v_out_122031.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_122031", "122031020", "story_v_out_122031.awb") / 1000

					if var_84_14 + var_84_6 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_6
					end

					if var_84_9.prefab_name ~= "" and arg_81_1.actors_[var_84_9.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_9.prefab_name].transform, "story_v_out_122031", "122031020", "story_v_out_122031.awb")

						arg_81_1:RecordAudio("122031020", var_84_15)
						arg_81_1:RecordAudio("122031020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_122031", "122031020", "story_v_out_122031.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_122031", "122031020", "story_v_out_122031.awb")
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
	Play122031021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 122031021
		arg_85_1.duration_ = 9.8

		local var_85_0 = {
			ja = 9.8,
			ko = 6.266,
			zh = 6.266
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
				arg_85_0:Play122031022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			local var_88_0 = 0
			local var_88_1 = 0.85

			if var_88_0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				local var_88_2 = arg_85_1:FormatText(StoryNameCfg[380].name)

				arg_85_1.leftNameTxt_.text = var_88_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_3 = arg_85_1:GetWordFromCfg(122031021)
				local var_88_4 = arg_85_1:FormatText(var_88_3.content)

				arg_85_1.text_.text = var_88_4

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_5 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031021", "story_v_out_122031.awb") ~= 0 then
					local var_88_8 = manager.audio:GetVoiceLength("story_v_out_122031", "122031021", "story_v_out_122031.awb") / 1000

					if var_88_8 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_8 + var_88_0
					end

					if var_88_3.prefab_name ~= "" and arg_85_1.actors_[var_88_3.prefab_name] ~= nil then
						local var_88_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_3.prefab_name].transform, "story_v_out_122031", "122031021", "story_v_out_122031.awb")

						arg_85_1:RecordAudio("122031021", var_88_9)
						arg_85_1:RecordAudio("122031021", var_88_9)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_122031", "122031021", "story_v_out_122031.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_122031", "122031021", "story_v_out_122031.awb")
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
	Play122031022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 122031022
		arg_89_1.duration_ = 8.93

		local var_89_0 = {
			ja = 8.933,
			ko = 7.633,
			zh = 7.633
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
				arg_89_0:Play122031023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = arg_89_1.actors_["10044ui_story"]
			local var_92_1 = 0

			if var_92_1 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10044ui_story == nil then
				arg_89_1.var_.characterEffect10044ui_story = var_92_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_2 and not isNil(var_92_0) then
				local var_92_3 = (arg_89_1.time_ - var_92_1) / var_92_2

				if arg_89_1.var_.characterEffect10044ui_story and not isNil(var_92_0) then
					local var_92_4 = Mathf.Lerp(0, 0.5, var_92_3)

					arg_89_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10044ui_story.fillRatio = var_92_4
				end
			end

			if arg_89_1.time_ >= var_92_1 + var_92_2 and arg_89_1.time_ < var_92_1 + var_92_2 + arg_92_0 and not isNil(var_92_0) and arg_89_1.var_.characterEffect10044ui_story then
				local var_92_5 = 0.5

				arg_89_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10044ui_story.fillRatio = var_92_5
			end

			local var_92_6 = 0
			local var_92_7 = 0.85

			if var_92_6 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				local var_92_8 = arg_89_1:FormatText(StoryNameCfg[433].name)

				arg_89_1.leftNameTxt_.text = var_92_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, true)
				arg_89_1.iconController_:SetSelectedState("hero")

				arg_89_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_sifangw")

				arg_89_1.callingController_:SetSelectedState("normal")

				arg_89_1.keyicon_.color = Color.New(1, 1, 1)
				arg_89_1.icon_.color = Color.New(1, 1, 1)

				local var_92_9 = arg_89_1:GetWordFromCfg(122031022)
				local var_92_10 = arg_89_1:FormatText(var_92_9.content)

				arg_89_1.text_.text = var_92_10

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 34
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

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031022", "story_v_out_122031.awb") ~= 0 then
					local var_92_14 = manager.audio:GetVoiceLength("story_v_out_122031", "122031022", "story_v_out_122031.awb") / 1000

					if var_92_14 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_14 + var_92_6
					end

					if var_92_9.prefab_name ~= "" and arg_89_1.actors_[var_92_9.prefab_name] ~= nil then
						local var_92_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_9.prefab_name].transform, "story_v_out_122031", "122031022", "story_v_out_122031.awb")

						arg_89_1:RecordAudio("122031022", var_92_15)
						arg_89_1:RecordAudio("122031022", var_92_15)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_122031", "122031022", "story_v_out_122031.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_122031", "122031022", "story_v_out_122031.awb")
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
	Play122031023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 122031023
		arg_93_1.duration_ = 6.9

		local var_93_0 = {
			ja = 6.9,
			ko = 6.833,
			zh = 6.833
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
				arg_93_0:Play122031024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10044ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10044ui_story == nil then
				arg_93_1.var_.characterEffect10044ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 and not isNil(var_96_0) then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect10044ui_story and not isNil(var_96_0) then
					arg_93_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and not isNil(var_96_0) and arg_93_1.var_.characterEffect10044ui_story then
				arg_93_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_96_4 = 0

			if var_96_4 < arg_93_1.time_ and arg_93_1.time_ <= var_96_4 + arg_96_0 then
				arg_93_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_96_5 = 0
			local var_96_6 = 0.7

			if var_96_5 < arg_93_1.time_ and arg_93_1.time_ <= var_96_5 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_7 = arg_93_1:FormatText(StoryNameCfg[380].name)

				arg_93_1.leftNameTxt_.text = var_96_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_8 = arg_93_1:GetWordFromCfg(122031023)
				local var_96_9 = arg_93_1:FormatText(var_96_8.content)

				arg_93_1.text_.text = var_96_9

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_10 = 28
				local var_96_11 = utf8.len(var_96_9)
				local var_96_12 = var_96_10 <= 0 and var_96_6 or var_96_6 * (var_96_11 / var_96_10)

				if var_96_12 > 0 and var_96_6 < var_96_12 then
					arg_93_1.talkMaxDuration = var_96_12

					if var_96_12 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_12 + var_96_5
					end
				end

				arg_93_1.text_.text = var_96_9
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031023", "story_v_out_122031.awb") ~= 0 then
					local var_96_13 = manager.audio:GetVoiceLength("story_v_out_122031", "122031023", "story_v_out_122031.awb") / 1000

					if var_96_13 + var_96_5 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_5
					end

					if var_96_8.prefab_name ~= "" and arg_93_1.actors_[var_96_8.prefab_name] ~= nil then
						local var_96_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_8.prefab_name].transform, "story_v_out_122031", "122031023", "story_v_out_122031.awb")

						arg_93_1:RecordAudio("122031023", var_96_14)
						arg_93_1:RecordAudio("122031023", var_96_14)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_122031", "122031023", "story_v_out_122031.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_122031", "122031023", "story_v_out_122031.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_15 = math.max(var_96_6, arg_93_1.talkMaxDuration)

			if var_96_5 <= arg_93_1.time_ and arg_93_1.time_ < var_96_5 + var_96_15 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_5) / var_96_15

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_5 + var_96_15 and arg_93_1.time_ < var_96_5 + var_96_15 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play122031024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 122031024
		arg_97_1.duration_ = 9.67

		local var_97_0 = {
			ja = 6.033,
			ko = 9.666,
			zh = 9.666
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play122031025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_100_1 = 0
			local var_100_2 = 1.325

			if var_100_1 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_3 = arg_97_1:FormatText(StoryNameCfg[380].name)

				arg_97_1.leftNameTxt_.text = var_100_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_4 = arg_97_1:GetWordFromCfg(122031024)
				local var_100_5 = arg_97_1:FormatText(var_100_4.content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 53
				local var_100_7 = utf8.len(var_100_5)
				local var_100_8 = var_100_6 <= 0 and var_100_2 or var_100_2 * (var_100_7 / var_100_6)

				if var_100_8 > 0 and var_100_2 < var_100_8 then
					arg_97_1.talkMaxDuration = var_100_8

					if var_100_8 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_5
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031024", "story_v_out_122031.awb") ~= 0 then
					local var_100_9 = manager.audio:GetVoiceLength("story_v_out_122031", "122031024", "story_v_out_122031.awb") / 1000

					if var_100_9 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_1
					end

					if var_100_4.prefab_name ~= "" and arg_97_1.actors_[var_100_4.prefab_name] ~= nil then
						local var_100_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_4.prefab_name].transform, "story_v_out_122031", "122031024", "story_v_out_122031.awb")

						arg_97_1:RecordAudio("122031024", var_100_10)
						arg_97_1:RecordAudio("122031024", var_100_10)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_122031", "122031024", "story_v_out_122031.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_122031", "122031024", "story_v_out_122031.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_11 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_11 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_11

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_11 and arg_97_1.time_ < var_100_1 + var_100_11 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play122031025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 122031025
		arg_101_1.duration_ = 8.03

		local var_101_0 = {
			ja = 8.033,
			ko = 5.733,
			zh = 5.733
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
				arg_101_0:Play122031026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = 0
			local var_104_1 = 0.775

			if var_104_0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_0 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				local var_104_2 = arg_101_1:FormatText(StoryNameCfg[380].name)

				arg_101_1.leftNameTxt_.text = var_104_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_3 = arg_101_1:GetWordFromCfg(122031025)
				local var_104_4 = arg_101_1:FormatText(var_104_3.content)

				arg_101_1.text_.text = var_104_4

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_5 = 31
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

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031025", "story_v_out_122031.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_122031", "122031025", "story_v_out_122031.awb") / 1000

					if var_104_8 + var_104_0 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_0
					end

					if var_104_3.prefab_name ~= "" and arg_101_1.actors_[var_104_3.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_3.prefab_name].transform, "story_v_out_122031", "122031025", "story_v_out_122031.awb")

						arg_101_1:RecordAudio("122031025", var_104_9)
						arg_101_1:RecordAudio("122031025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_122031", "122031025", "story_v_out_122031.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_122031", "122031025", "story_v_out_122031.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_1, arg_101_1.talkMaxDuration)

			if var_104_0 <= arg_101_1.time_ and arg_101_1.time_ < var_104_0 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_0) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_0 + var_104_10 and arg_101_1.time_ < var_104_0 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play122031026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 122031026
		arg_105_1.duration_ = 8.8

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play122031027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = arg_105_1.actors_["10044ui_story"].transform
			local var_108_1 = 1.96599999815226

			if var_108_1 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.var_.moveOldPos10044ui_story = var_108_0.localPosition
			end

			local var_108_2 = 0.001

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_2 then
				local var_108_3 = (arg_105_1.time_ - var_108_1) / var_108_2
				local var_108_4 = Vector3.New(0, 100, 0)

				var_108_0.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10044ui_story, var_108_4, var_108_3)

				local var_108_5 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_5.x, var_108_5.y, var_108_5.z)

				local var_108_6 = var_108_0.localEulerAngles

				var_108_6.z = 0
				var_108_6.x = 0
				var_108_0.localEulerAngles = var_108_6
			end

			if arg_105_1.time_ >= var_108_1 + var_108_2 and arg_105_1.time_ < var_108_1 + var_108_2 + arg_108_0 then
				var_108_0.localPosition = Vector3.New(0, 100, 0)

				local var_108_7 = manager.ui.mainCamera.transform.position - var_108_0.position

				var_108_0.forward = Vector3.New(var_108_7.x, var_108_7.y, var_108_7.z)

				local var_108_8 = var_108_0.localEulerAngles

				var_108_8.z = 0
				var_108_8.x = 0
				var_108_0.localEulerAngles = var_108_8
			end

			local var_108_9 = arg_105_1.actors_["10044ui_story"]
			local var_108_10 = 1.96599999815226

			if var_108_10 < arg_105_1.time_ and arg_105_1.time_ <= var_108_10 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect10044ui_story == nil then
				arg_105_1.var_.characterEffect10044ui_story = var_108_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_11 = 0.034000001847744

			if var_108_10 <= arg_105_1.time_ and arg_105_1.time_ < var_108_10 + var_108_11 and not isNil(var_108_9) then
				local var_108_12 = (arg_105_1.time_ - var_108_10) / var_108_11

				if arg_105_1.var_.characterEffect10044ui_story and not isNil(var_108_9) then
					local var_108_13 = Mathf.Lerp(0, 0.5, var_108_12)

					arg_105_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_105_1.var_.characterEffect10044ui_story.fillRatio = var_108_13
				end
			end

			if arg_105_1.time_ >= var_108_10 + var_108_11 and arg_105_1.time_ < var_108_10 + var_108_11 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect10044ui_story then
				local var_108_14 = 0.5

				arg_105_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_105_1.var_.characterEffect10044ui_story.fillRatio = var_108_14
			end

			local var_108_15 = 2
			local var_108_16 = 0.3

			if var_108_15 < arg_105_1.time_ and arg_105_1.time_ <= var_108_15 + arg_108_0 then
				local var_108_17 = "play"
				local var_108_18 = "effect"

				arg_105_1:AudioAction(var_108_17, var_108_18, "se_story_122_01", "se_story_122_01_buildinghit02", "")
			end

			local var_108_19 = 2
			local var_108_20 = 0.3

			if var_108_19 < arg_105_1.time_ and arg_105_1.time_ <= var_108_19 + arg_108_0 then
				local var_108_21 = "stop"
				local var_108_22 = "effect"

				arg_105_1:AudioAction(var_108_21, var_108_22, "se_story_122_01", "se_story_122_01_monsterattack01_loop", "")
			end

			local var_108_23 = 0

			if var_108_23 < arg_105_1.time_ and arg_105_1.time_ <= var_108_23 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_24 = 2

			if var_108_23 <= arg_105_1.time_ and arg_105_1.time_ < var_108_23 + var_108_24 then
				local var_108_25 = (arg_105_1.time_ - var_108_23) / var_108_24
				local var_108_26 = Color.New(0, 0, 0)

				var_108_26.a = Mathf.Lerp(0, 1, var_108_25)
				arg_105_1.mask_.color = var_108_26
			end

			if arg_105_1.time_ >= var_108_23 + var_108_24 and arg_105_1.time_ < var_108_23 + var_108_24 + arg_108_0 then
				local var_108_27 = Color.New(0, 0, 0)

				var_108_27.a = 1
				arg_105_1.mask_.color = var_108_27
			end

			local var_108_28 = 2

			if var_108_28 < arg_105_1.time_ and arg_105_1.time_ <= var_108_28 + arg_108_0 then
				arg_105_1.mask_.enabled = true
				arg_105_1.mask_.raycastTarget = true

				arg_105_1:SetGaussion(false)
			end

			local var_108_29 = 2

			if var_108_28 <= arg_105_1.time_ and arg_105_1.time_ < var_108_28 + var_108_29 then
				local var_108_30 = (arg_105_1.time_ - var_108_28) / var_108_29
				local var_108_31 = Color.New(0, 0, 0)

				var_108_31.a = Mathf.Lerp(1, 0, var_108_30)
				arg_105_1.mask_.color = var_108_31
			end

			if arg_105_1.time_ >= var_108_28 + var_108_29 and arg_105_1.time_ < var_108_28 + var_108_29 + arg_108_0 then
				local var_108_32 = Color.New(0, 0, 0)
				local var_108_33 = 0

				arg_105_1.mask_.enabled = false
				var_108_32.a = var_108_33
				arg_105_1.mask_.color = var_108_32
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_34 = 3.8
			local var_108_35 = 1.075

			if var_108_34 < arg_105_1.time_ and arg_105_1.time_ <= var_108_34 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				arg_105_1.dialogCg_.alpha = 0

				local var_108_36 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_36:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_36:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_36:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_37 = arg_105_1:GetWordFromCfg(122031026)
				local var_108_38 = arg_105_1:FormatText(var_108_37.content)

				arg_105_1.text_.text = var_108_38

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_39 = 43
				local var_108_40 = utf8.len(var_108_38)
				local var_108_41 = var_108_39 <= 0 and var_108_35 or var_108_35 * (var_108_40 / var_108_39)

				if var_108_41 > 0 and var_108_35 < var_108_41 then
					arg_105_1.talkMaxDuration = var_108_41
					var_108_34 = var_108_34 + 0.3

					if var_108_41 + var_108_34 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_41 + var_108_34
					end
				end

				arg_105_1.text_.text = var_108_38
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_42 = var_108_34 + 0.3
			local var_108_43 = math.max(var_108_35, arg_105_1.talkMaxDuration)

			if var_108_42 <= arg_105_1.time_ and arg_105_1.time_ < var_108_42 + var_108_43 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_42) / var_108_43

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_42 + var_108_43 and arg_105_1.time_ < var_108_42 + var_108_43 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play122031027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 122031027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play122031028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = 0
			local var_114_1 = 1

			if var_114_0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_0 + arg_114_0 then
				local var_114_2 = "play"
				local var_114_3 = "effect"

				arg_111_1:AudioAction(var_114_2, var_114_3, "se_story_122_01", "se_story_122_01_metaldoor", "")
			end

			local var_114_4 = 0
			local var_114_5 = 1.525

			if var_114_4 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_6 = arg_111_1:GetWordFromCfg(122031027)
				local var_114_7 = arg_111_1:FormatText(var_114_6.content)

				arg_111_1.text_.text = var_114_7

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_8 = 61
				local var_114_9 = utf8.len(var_114_7)
				local var_114_10 = var_114_8 <= 0 and var_114_5 or var_114_5 * (var_114_9 / var_114_8)

				if var_114_10 > 0 and var_114_5 < var_114_10 then
					arg_111_1.talkMaxDuration = var_114_10

					if var_114_10 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_4
					end
				end

				arg_111_1.text_.text = var_114_7
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_11 = math.max(var_114_5, arg_111_1.talkMaxDuration)

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_11 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_4) / var_114_11

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_4 + var_114_11 and arg_111_1.time_ < var_114_4 + var_114_11 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play122031028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 122031028
		arg_115_1.duration_ = 10.9

		local var_115_0 = {
			ja = 10.066,
			ko = 10.9,
			zh = 10.9
		}
		local var_115_1 = manager.audio:GetLocalizationFlag()

		if var_115_0[var_115_1] ~= nil then
			arg_115_1.duration_ = var_115_0[var_115_1]
		end

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play122031029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10044ui_story"].transform
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 then
				arg_115_1.var_.moveOldPos10044ui_story = var_118_0.localPosition
			end

			local var_118_2 = 0.001

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2
				local var_118_4 = Vector3.New(0, -0.72, -6.3)

				var_118_0.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10044ui_story, var_118_4, var_118_3)

				local var_118_5 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_5.x, var_118_5.y, var_118_5.z)

				local var_118_6 = var_118_0.localEulerAngles

				var_118_6.z = 0
				var_118_6.x = 0
				var_118_0.localEulerAngles = var_118_6
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 then
				var_118_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_118_7 = manager.ui.mainCamera.transform.position - var_118_0.position

				var_118_0.forward = Vector3.New(var_118_7.x, var_118_7.y, var_118_7.z)

				local var_118_8 = var_118_0.localEulerAngles

				var_118_8.z = 0
				var_118_8.x = 0
				var_118_0.localEulerAngles = var_118_8
			end

			local var_118_9 = arg_115_1.actors_["10044ui_story"]
			local var_118_10 = 0

			if var_118_10 < arg_115_1.time_ and arg_115_1.time_ <= var_118_10 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect10044ui_story == nil then
				arg_115_1.var_.characterEffect10044ui_story = var_118_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_11 = 0.200000002980232

			if var_118_10 <= arg_115_1.time_ and arg_115_1.time_ < var_118_10 + var_118_11 and not isNil(var_118_9) then
				local var_118_12 = (arg_115_1.time_ - var_118_10) / var_118_11

				if arg_115_1.var_.characterEffect10044ui_story and not isNil(var_118_9) then
					arg_115_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= var_118_10 + var_118_11 and arg_115_1.time_ < var_118_10 + var_118_11 + arg_118_0 and not isNil(var_118_9) and arg_115_1.var_.characterEffect10044ui_story then
				arg_115_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_118_13 = 0

			if var_118_13 < arg_115_1.time_ and arg_115_1.time_ <= var_118_13 + arg_118_0 then
				arg_115_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action2_1")
			end

			local var_118_14 = 0

			if var_118_14 < arg_115_1.time_ and arg_115_1.time_ <= var_118_14 + arg_118_0 then
				arg_115_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_118_15 = 0
			local var_118_16 = 1.15

			if var_118_15 < arg_115_1.time_ and arg_115_1.time_ <= var_118_15 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				local var_118_17 = arg_115_1:FormatText(StoryNameCfg[380].name)

				arg_115_1.leftNameTxt_.text = var_118_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_18 = arg_115_1:GetWordFromCfg(122031028)
				local var_118_19 = arg_115_1:FormatText(var_118_18.content)

				arg_115_1.text_.text = var_118_19

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_20 = 46
				local var_118_21 = utf8.len(var_118_19)
				local var_118_22 = var_118_20 <= 0 and var_118_16 or var_118_16 * (var_118_21 / var_118_20)

				if var_118_22 > 0 and var_118_16 < var_118_22 then
					arg_115_1.talkMaxDuration = var_118_22

					if var_118_22 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_22 + var_118_15
					end
				end

				arg_115_1.text_.text = var_118_19
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031028", "story_v_out_122031.awb") ~= 0 then
					local var_118_23 = manager.audio:GetVoiceLength("story_v_out_122031", "122031028", "story_v_out_122031.awb") / 1000

					if var_118_23 + var_118_15 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_23 + var_118_15
					end

					if var_118_18.prefab_name ~= "" and arg_115_1.actors_[var_118_18.prefab_name] ~= nil then
						local var_118_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_18.prefab_name].transform, "story_v_out_122031", "122031028", "story_v_out_122031.awb")

						arg_115_1:RecordAudio("122031028", var_118_24)
						arg_115_1:RecordAudio("122031028", var_118_24)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_122031", "122031028", "story_v_out_122031.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_122031", "122031028", "story_v_out_122031.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_25 = math.max(var_118_16, arg_115_1.talkMaxDuration)

			if var_118_15 <= arg_115_1.time_ and arg_115_1.time_ < var_118_15 + var_118_25 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_15) / var_118_25

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_15 + var_118_25 and arg_115_1.time_ < var_118_15 + var_118_25 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play122031029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 122031029
		arg_119_1.duration_ = 7.83

		local var_119_0 = {
			ja = 7.833,
			ko = 2,
			zh = 2
		}
		local var_119_1 = manager.audio:GetLocalizationFlag()

		if var_119_0[var_119_1] ~= nil then
			arg_119_1.duration_ = var_119_0[var_119_1]
		end

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play122031030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action2_2")
			end

			local var_122_1 = 0

			if var_122_1 < arg_119_1.time_ and arg_119_1.time_ <= var_122_1 + arg_122_0 then
				arg_119_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_122_2 = 0
			local var_122_3 = 0.225

			if var_122_2 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				local var_122_4 = arg_119_1:FormatText(StoryNameCfg[380].name)

				arg_119_1.leftNameTxt_.text = var_122_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_5 = arg_119_1:GetWordFromCfg(122031029)
				local var_122_6 = arg_119_1:FormatText(var_122_5.content)

				arg_119_1.text_.text = var_122_6

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_7 = 9
				local var_122_8 = utf8.len(var_122_6)
				local var_122_9 = var_122_7 <= 0 and var_122_3 or var_122_3 * (var_122_8 / var_122_7)

				if var_122_9 > 0 and var_122_3 < var_122_9 then
					arg_119_1.talkMaxDuration = var_122_9

					if var_122_9 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_9 + var_122_2
					end
				end

				arg_119_1.text_.text = var_122_6
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031029", "story_v_out_122031.awb") ~= 0 then
					local var_122_10 = manager.audio:GetVoiceLength("story_v_out_122031", "122031029", "story_v_out_122031.awb") / 1000

					if var_122_10 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_10 + var_122_2
					end

					if var_122_5.prefab_name ~= "" and arg_119_1.actors_[var_122_5.prefab_name] ~= nil then
						local var_122_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_5.prefab_name].transform, "story_v_out_122031", "122031029", "story_v_out_122031.awb")

						arg_119_1:RecordAudio("122031029", var_122_11)
						arg_119_1:RecordAudio("122031029", var_122_11)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_122031", "122031029", "story_v_out_122031.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_122031", "122031029", "story_v_out_122031.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_12 = math.max(var_122_3, arg_119_1.talkMaxDuration)

			if var_122_2 <= arg_119_1.time_ and arg_119_1.time_ < var_122_2 + var_122_12 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_2) / var_122_12

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_2 + var_122_12 and arg_119_1.time_ < var_122_2 + var_122_12 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play122031030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 122031030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play122031031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = arg_123_1.actors_["10044ui_story"].transform
			local var_126_1 = 0

			if var_126_1 < arg_123_1.time_ and arg_123_1.time_ <= var_126_1 + arg_126_0 then
				arg_123_1.var_.moveOldPos10044ui_story = var_126_0.localPosition
			end

			local var_126_2 = 0.001

			if var_126_1 <= arg_123_1.time_ and arg_123_1.time_ < var_126_1 + var_126_2 then
				local var_126_3 = (arg_123_1.time_ - var_126_1) / var_126_2
				local var_126_4 = Vector3.New(0, 100, 0)

				var_126_0.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10044ui_story, var_126_4, var_126_3)

				local var_126_5 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_5.x, var_126_5.y, var_126_5.z)

				local var_126_6 = var_126_0.localEulerAngles

				var_126_6.z = 0
				var_126_6.x = 0
				var_126_0.localEulerAngles = var_126_6
			end

			if arg_123_1.time_ >= var_126_1 + var_126_2 and arg_123_1.time_ < var_126_1 + var_126_2 + arg_126_0 then
				var_126_0.localPosition = Vector3.New(0, 100, 0)

				local var_126_7 = manager.ui.mainCamera.transform.position - var_126_0.position

				var_126_0.forward = Vector3.New(var_126_7.x, var_126_7.y, var_126_7.z)

				local var_126_8 = var_126_0.localEulerAngles

				var_126_8.z = 0
				var_126_8.x = 0
				var_126_0.localEulerAngles = var_126_8
			end

			local var_126_9 = arg_123_1.actors_["10044ui_story"]
			local var_126_10 = 0

			if var_126_10 < arg_123_1.time_ and arg_123_1.time_ <= var_126_10 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect10044ui_story == nil then
				arg_123_1.var_.characterEffect10044ui_story = var_126_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if var_126_10 <= arg_123_1.time_ and arg_123_1.time_ < var_126_10 + var_126_11 and not isNil(var_126_9) then
				local var_126_12 = (arg_123_1.time_ - var_126_10) / var_126_11

				if arg_123_1.var_.characterEffect10044ui_story and not isNil(var_126_9) then
					local var_126_13 = Mathf.Lerp(0, 0.5, var_126_12)

					arg_123_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10044ui_story.fillRatio = var_126_13
				end
			end

			if arg_123_1.time_ >= var_126_10 + var_126_11 and arg_123_1.time_ < var_126_10 + var_126_11 + arg_126_0 and not isNil(var_126_9) and arg_123_1.var_.characterEffect10044ui_story then
				local var_126_14 = 0.5

				arg_123_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10044ui_story.fillRatio = var_126_14
			end

			local var_126_15 = 0
			local var_126_16 = 1.35

			if var_126_15 < arg_123_1.time_ and arg_123_1.time_ <= var_126_15 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_17 = arg_123_1:GetWordFromCfg(122031030)
				local var_126_18 = arg_123_1:FormatText(var_126_17.content)

				arg_123_1.text_.text = var_126_18

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_19 = 54
				local var_126_20 = utf8.len(var_126_18)
				local var_126_21 = var_126_19 <= 0 and var_126_16 or var_126_16 * (var_126_20 / var_126_19)

				if var_126_21 > 0 and var_126_16 < var_126_21 then
					arg_123_1.talkMaxDuration = var_126_21

					if var_126_21 + var_126_15 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_21 + var_126_15
					end
				end

				arg_123_1.text_.text = var_126_18
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_22 = math.max(var_126_16, arg_123_1.talkMaxDuration)

			if var_126_15 <= arg_123_1.time_ and arg_123_1.time_ < var_126_15 + var_126_22 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_15) / var_126_22

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_15 + var_126_22 and arg_123_1.time_ < var_126_15 + var_126_22 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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
	Play122031031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 122031031
		arg_127_1.duration_ = 1.83

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play122031032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 0
			local var_130_1 = 0.05

			if var_130_0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_2 = arg_127_1:FormatText(StoryNameCfg[68].name)

				arg_127_1.leftNameTxt_.text = var_130_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, true)
				arg_127_1.iconController_:SetSelectedState("hero")

				arg_127_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3039")

				arg_127_1.callingController_:SetSelectedState("normal")

				arg_127_1.keyicon_.color = Color.New(1, 1, 1)
				arg_127_1.icon_.color = Color.New(1, 1, 1)

				local var_130_3 = arg_127_1:GetWordFromCfg(122031031)
				local var_130_4 = arg_127_1:FormatText(var_130_3.content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_5 = 2
				local var_130_6 = utf8.len(var_130_4)
				local var_130_7 = var_130_5 <= 0 and var_130_1 or var_130_1 * (var_130_6 / var_130_5)

				if var_130_7 > 0 and var_130_1 < var_130_7 then
					arg_127_1.talkMaxDuration = var_130_7

					if var_130_7 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_7 + var_130_0
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031031", "story_v_out_122031.awb") ~= 0 then
					local var_130_8 = manager.audio:GetVoiceLength("story_v_out_122031", "122031031", "story_v_out_122031.awb") / 1000

					if var_130_8 + var_130_0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_8 + var_130_0
					end

					if var_130_3.prefab_name ~= "" and arg_127_1.actors_[var_130_3.prefab_name] ~= nil then
						local var_130_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_3.prefab_name].transform, "story_v_out_122031", "122031031", "story_v_out_122031.awb")

						arg_127_1:RecordAudio("122031031", var_130_9)
						arg_127_1:RecordAudio("122031031", var_130_9)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_122031", "122031031", "story_v_out_122031.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_122031", "122031031", "story_v_out_122031.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_10 = math.max(var_130_1, arg_127_1.talkMaxDuration)

			if var_130_0 <= arg_127_1.time_ and arg_127_1.time_ < var_130_0 + var_130_10 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_0) / var_130_10

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_0 + var_130_10 and arg_127_1.time_ < var_130_0 + var_130_10 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play122031032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 122031032
		arg_131_1.duration_ = 8.03

		local var_131_0 = {
			ja = 8.033,
			ko = 3.566,
			zh = 3.566
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play122031033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10044ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos10044ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(0, -0.72, -6.3)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10044ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["10044ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect10044ui_story == nil then
				arg_131_1.var_.characterEffect10044ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 and not isNil(var_134_9) then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect10044ui_story and not isNil(var_134_9) then
					arg_131_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and not isNil(var_134_9) and arg_131_1.var_.characterEffect10044ui_story then
				arg_131_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_134_13 = 0

			if var_134_13 < arg_131_1.time_ and arg_131_1.time_ <= var_134_13 + arg_134_0 then
				arg_131_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_134_14 = 0

			if var_134_14 < arg_131_1.time_ and arg_131_1.time_ <= var_134_14 + arg_134_0 then
				arg_131_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_134_15 = 0
			local var_134_16 = 0.325

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_17 = arg_131_1:FormatText(StoryNameCfg[380].name)

				arg_131_1.leftNameTxt_.text = var_134_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_18 = arg_131_1:GetWordFromCfg(122031032)
				local var_134_19 = arg_131_1:FormatText(var_134_18.content)

				arg_131_1.text_.text = var_134_19

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_20 = 13
				local var_134_21 = utf8.len(var_134_19)
				local var_134_22 = var_134_20 <= 0 and var_134_16 or var_134_16 * (var_134_21 / var_134_20)

				if var_134_22 > 0 and var_134_16 < var_134_22 then
					arg_131_1.talkMaxDuration = var_134_22

					if var_134_22 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_22 + var_134_15
					end
				end

				arg_131_1.text_.text = var_134_19
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031032", "story_v_out_122031.awb") ~= 0 then
					local var_134_23 = manager.audio:GetVoiceLength("story_v_out_122031", "122031032", "story_v_out_122031.awb") / 1000

					if var_134_23 + var_134_15 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_23 + var_134_15
					end

					if var_134_18.prefab_name ~= "" and arg_131_1.actors_[var_134_18.prefab_name] ~= nil then
						local var_134_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_18.prefab_name].transform, "story_v_out_122031", "122031032", "story_v_out_122031.awb")

						arg_131_1:RecordAudio("122031032", var_134_24)
						arg_131_1:RecordAudio("122031032", var_134_24)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_122031", "122031032", "story_v_out_122031.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_122031", "122031032", "story_v_out_122031.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_25 = math.max(var_134_16, arg_131_1.talkMaxDuration)

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_25 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_15) / var_134_25

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_15 + var_134_25 and arg_131_1.time_ < var_134_15 + var_134_25 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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
	Play122031033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 122031033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play122031034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10044ui_story"].transform
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 then
				arg_135_1.var_.moveOldPos10044ui_story = var_138_0.localPosition
			end

			local var_138_2 = 0.001

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2
				local var_138_4 = Vector3.New(0, 100, 0)

				var_138_0.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10044ui_story, var_138_4, var_138_3)

				local var_138_5 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_5.x, var_138_5.y, var_138_5.z)

				local var_138_6 = var_138_0.localEulerAngles

				var_138_6.z = 0
				var_138_6.x = 0
				var_138_0.localEulerAngles = var_138_6
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 then
				var_138_0.localPosition = Vector3.New(0, 100, 0)

				local var_138_7 = manager.ui.mainCamera.transform.position - var_138_0.position

				var_138_0.forward = Vector3.New(var_138_7.x, var_138_7.y, var_138_7.z)

				local var_138_8 = var_138_0.localEulerAngles

				var_138_8.z = 0
				var_138_8.x = 0
				var_138_0.localEulerAngles = var_138_8
			end

			local var_138_9 = arg_135_1.actors_["10044ui_story"]
			local var_138_10 = 0

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 and not isNil(var_138_9) and arg_135_1.var_.characterEffect10044ui_story == nil then
				arg_135_1.var_.characterEffect10044ui_story = var_138_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_11 = 0.200000002980232

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_11 and not isNil(var_138_9) then
				local var_138_12 = (arg_135_1.time_ - var_138_10) / var_138_11

				if arg_135_1.var_.characterEffect10044ui_story and not isNil(var_138_9) then
					local var_138_13 = Mathf.Lerp(0, 0.5, var_138_12)

					arg_135_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10044ui_story.fillRatio = var_138_13
				end
			end

			if arg_135_1.time_ >= var_138_10 + var_138_11 and arg_135_1.time_ < var_138_10 + var_138_11 + arg_138_0 and not isNil(var_138_9) and arg_135_1.var_.characterEffect10044ui_story then
				local var_138_14 = 0.5

				arg_135_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10044ui_story.fillRatio = var_138_14
			end

			local var_138_15 = 0
			local var_138_16 = 1.1

			if var_138_15 < arg_135_1.time_ and arg_135_1.time_ <= var_138_15 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_17 = arg_135_1:GetWordFromCfg(122031033)
				local var_138_18 = arg_135_1:FormatText(var_138_17.content)

				arg_135_1.text_.text = var_138_18

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_19 = 44
				local var_138_20 = utf8.len(var_138_18)
				local var_138_21 = var_138_19 <= 0 and var_138_16 or var_138_16 * (var_138_20 / var_138_19)

				if var_138_21 > 0 and var_138_16 < var_138_21 then
					arg_135_1.talkMaxDuration = var_138_21

					if var_138_21 + var_138_15 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_21 + var_138_15
					end
				end

				arg_135_1.text_.text = var_138_18
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_22 = math.max(var_138_16, arg_135_1.talkMaxDuration)

			if var_138_15 <= arg_135_1.time_ and arg_135_1.time_ < var_138_15 + var_138_22 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_15) / var_138_22

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_15 + var_138_22 and arg_135_1.time_ < var_138_15 + var_138_22 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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
	Play122031034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 122031034
		arg_139_1.duration_ = 6

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play122031035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = manager.ui.mainCamera.transform
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.var_.shakeOldPos = var_142_0.localPosition
			end

			local var_142_2 = 1

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / 0.066
				local var_142_4, var_142_5 = math.modf(var_142_3)

				var_142_0.localPosition = Vector3.New(var_142_5 * 0.13, var_142_5 * 0.13, var_142_5 * 0.13) + arg_139_1.var_.shakeOldPos
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 then
				var_142_0.localPosition = arg_139_1.var_.shakeOldPos
			end

			local var_142_6 = 0

			if var_142_6 < arg_139_1.time_ and arg_139_1.time_ <= var_142_6 + arg_142_0 then
				arg_139_1.allBtn_.enabled = false
			end

			local var_142_7 = 1

			if arg_139_1.time_ >= var_142_6 + var_142_7 and arg_139_1.time_ < var_142_6 + var_142_7 + arg_142_0 then
				arg_139_1.allBtn_.enabled = true
			end

			local var_142_8 = 0
			local var_142_9 = 1

			if var_142_8 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				local var_142_10 = "play"
				local var_142_11 = "effect"

				arg_139_1:AudioAction(var_142_10, var_142_11, "se_story_122_01", "se_story_122_01_buildinghit03", "")
			end

			if arg_139_1.frameCnt_ <= 1 then
				arg_139_1.dialog_:SetActive(false)
			end

			local var_142_12 = 1
			local var_142_13 = 1.575

			if var_142_12 < arg_139_1.time_ and arg_139_1.time_ <= var_142_12 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0

				arg_139_1.dialog_:SetActive(true)

				arg_139_1.dialogCg_.alpha = 0

				local var_142_14 = LeanTween.value(arg_139_1.dialog_, 0, 1, 0.3)

				var_142_14:setOnUpdate(LuaHelper.FloatAction(function(arg_143_0)
					arg_139_1.dialogCg_.alpha = arg_143_0
				end))
				var_142_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_139_1.dialog_)
					var_142_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_139_1.duration_ = arg_139_1.duration_ + 0.3

				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_15 = arg_139_1:GetWordFromCfg(122031034)
				local var_142_16 = arg_139_1:FormatText(var_142_15.content)

				arg_139_1.text_.text = var_142_16

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_17 = 63
				local var_142_18 = utf8.len(var_142_16)
				local var_142_19 = var_142_17 <= 0 and var_142_13 or var_142_13 * (var_142_18 / var_142_17)

				if var_142_19 > 0 and var_142_13 < var_142_19 then
					arg_139_1.talkMaxDuration = var_142_19
					var_142_12 = var_142_12 + 0.3

					if var_142_19 + var_142_12 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_19 + var_142_12
					end
				end

				arg_139_1.text_.text = var_142_16
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_20 = var_142_12 + 0.3
			local var_142_21 = math.max(var_142_13, arg_139_1.talkMaxDuration)

			if var_142_20 <= arg_139_1.time_ and arg_139_1.time_ < var_142_20 + var_142_21 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_20) / var_142_21

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_20 + var_142_21 and arg_139_1.time_ < var_142_20 + var_142_21 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play122031035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 122031035
		arg_145_1.duration_ = 9.8

		local var_145_0 = {
			ja = 9.8,
			ko = 8.733,
			zh = 8.733
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
				arg_145_0:Play122031036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = arg_145_1.actors_["10044ui_story"].transform
			local var_148_1 = 0

			if var_148_1 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.var_.moveOldPos10044ui_story = var_148_0.localPosition
			end

			local var_148_2 = 0.001

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_2 then
				local var_148_3 = (arg_145_1.time_ - var_148_1) / var_148_2
				local var_148_4 = Vector3.New(0, -0.72, -6.3)

				var_148_0.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10044ui_story, var_148_4, var_148_3)

				local var_148_5 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_5.x, var_148_5.y, var_148_5.z)

				local var_148_6 = var_148_0.localEulerAngles

				var_148_6.z = 0
				var_148_6.x = 0
				var_148_0.localEulerAngles = var_148_6
			end

			if arg_145_1.time_ >= var_148_1 + var_148_2 and arg_145_1.time_ < var_148_1 + var_148_2 + arg_148_0 then
				var_148_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_148_7 = manager.ui.mainCamera.transform.position - var_148_0.position

				var_148_0.forward = Vector3.New(var_148_7.x, var_148_7.y, var_148_7.z)

				local var_148_8 = var_148_0.localEulerAngles

				var_148_8.z = 0
				var_148_8.x = 0
				var_148_0.localEulerAngles = var_148_8
			end

			local var_148_9 = arg_145_1.actors_["10044ui_story"]
			local var_148_10 = 0

			if var_148_10 < arg_145_1.time_ and arg_145_1.time_ <= var_148_10 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect10044ui_story == nil then
				arg_145_1.var_.characterEffect10044ui_story = var_148_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_11 = 0.200000002980232

			if var_148_10 <= arg_145_1.time_ and arg_145_1.time_ < var_148_10 + var_148_11 and not isNil(var_148_9) then
				local var_148_12 = (arg_145_1.time_ - var_148_10) / var_148_11

				if arg_145_1.var_.characterEffect10044ui_story and not isNil(var_148_9) then
					arg_145_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= var_148_10 + var_148_11 and arg_145_1.time_ < var_148_10 + var_148_11 + arg_148_0 and not isNil(var_148_9) and arg_145_1.var_.characterEffect10044ui_story then
				arg_145_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_148_13 = 0

			if var_148_13 < arg_145_1.time_ and arg_145_1.time_ <= var_148_13 + arg_148_0 then
				arg_145_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_148_14 = 0

			if var_148_14 < arg_145_1.time_ and arg_145_1.time_ <= var_148_14 + arg_148_0 then
				arg_145_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_148_15 = 0
			local var_148_16 = 0.8

			if var_148_15 < arg_145_1.time_ and arg_145_1.time_ <= var_148_15 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				local var_148_17 = arg_145_1:FormatText(StoryNameCfg[380].name)

				arg_145_1.leftNameTxt_.text = var_148_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_18 = arg_145_1:GetWordFromCfg(122031035)
				local var_148_19 = arg_145_1:FormatText(var_148_18.content)

				arg_145_1.text_.text = var_148_19

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_20 = 32
				local var_148_21 = utf8.len(var_148_19)
				local var_148_22 = var_148_20 <= 0 and var_148_16 or var_148_16 * (var_148_21 / var_148_20)

				if var_148_22 > 0 and var_148_16 < var_148_22 then
					arg_145_1.talkMaxDuration = var_148_22

					if var_148_22 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_22 + var_148_15
					end
				end

				arg_145_1.text_.text = var_148_19
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031035", "story_v_out_122031.awb") ~= 0 then
					local var_148_23 = manager.audio:GetVoiceLength("story_v_out_122031", "122031035", "story_v_out_122031.awb") / 1000

					if var_148_23 + var_148_15 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_23 + var_148_15
					end

					if var_148_18.prefab_name ~= "" and arg_145_1.actors_[var_148_18.prefab_name] ~= nil then
						local var_148_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_18.prefab_name].transform, "story_v_out_122031", "122031035", "story_v_out_122031.awb")

						arg_145_1:RecordAudio("122031035", var_148_24)
						arg_145_1:RecordAudio("122031035", var_148_24)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_122031", "122031035", "story_v_out_122031.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_122031", "122031035", "story_v_out_122031.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_25 = math.max(var_148_16, arg_145_1.talkMaxDuration)

			if var_148_15 <= arg_145_1.time_ and arg_145_1.time_ < var_148_15 + var_148_25 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_15) / var_148_25

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_15 + var_148_25 and arg_145_1.time_ < var_148_15 + var_148_25 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play122031036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 122031036
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play122031037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = arg_149_1.actors_["10044ui_story"].transform
			local var_152_1 = 0

			if var_152_1 < arg_149_1.time_ and arg_149_1.time_ <= var_152_1 + arg_152_0 then
				arg_149_1.var_.moveOldPos10044ui_story = var_152_0.localPosition
			end

			local var_152_2 = 0.001

			if var_152_1 <= arg_149_1.time_ and arg_149_1.time_ < var_152_1 + var_152_2 then
				local var_152_3 = (arg_149_1.time_ - var_152_1) / var_152_2
				local var_152_4 = Vector3.New(0, 100, 0)

				var_152_0.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos10044ui_story, var_152_4, var_152_3)

				local var_152_5 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_5.x, var_152_5.y, var_152_5.z)

				local var_152_6 = var_152_0.localEulerAngles

				var_152_6.z = 0
				var_152_6.x = 0
				var_152_0.localEulerAngles = var_152_6
			end

			if arg_149_1.time_ >= var_152_1 + var_152_2 and arg_149_1.time_ < var_152_1 + var_152_2 + arg_152_0 then
				var_152_0.localPosition = Vector3.New(0, 100, 0)

				local var_152_7 = manager.ui.mainCamera.transform.position - var_152_0.position

				var_152_0.forward = Vector3.New(var_152_7.x, var_152_7.y, var_152_7.z)

				local var_152_8 = var_152_0.localEulerAngles

				var_152_8.z = 0
				var_152_8.x = 0
				var_152_0.localEulerAngles = var_152_8
			end

			local var_152_9 = arg_149_1.actors_["10044ui_story"]
			local var_152_10 = 0

			if var_152_10 < arg_149_1.time_ and arg_149_1.time_ <= var_152_10 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect10044ui_story == nil then
				arg_149_1.var_.characterEffect10044ui_story = var_152_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_11 = 0.200000002980232

			if var_152_10 <= arg_149_1.time_ and arg_149_1.time_ < var_152_10 + var_152_11 and not isNil(var_152_9) then
				local var_152_12 = (arg_149_1.time_ - var_152_10) / var_152_11

				if arg_149_1.var_.characterEffect10044ui_story and not isNil(var_152_9) then
					local var_152_13 = Mathf.Lerp(0, 0.5, var_152_12)

					arg_149_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10044ui_story.fillRatio = var_152_13
				end
			end

			if arg_149_1.time_ >= var_152_10 + var_152_11 and arg_149_1.time_ < var_152_10 + var_152_11 + arg_152_0 and not isNil(var_152_9) and arg_149_1.var_.characterEffect10044ui_story then
				local var_152_14 = 0.5

				arg_149_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10044ui_story.fillRatio = var_152_14
			end

			local var_152_15 = 0
			local var_152_16 = 1.45

			if var_152_15 < arg_149_1.time_ and arg_149_1.time_ <= var_152_15 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_17 = arg_149_1:GetWordFromCfg(122031036)
				local var_152_18 = arg_149_1:FormatText(var_152_17.content)

				arg_149_1.text_.text = var_152_18

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_19 = 58
				local var_152_20 = utf8.len(var_152_18)
				local var_152_21 = var_152_19 <= 0 and var_152_16 or var_152_16 * (var_152_20 / var_152_19)

				if var_152_21 > 0 and var_152_16 < var_152_21 then
					arg_149_1.talkMaxDuration = var_152_21

					if var_152_21 + var_152_15 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_21 + var_152_15
					end
				end

				arg_149_1.text_.text = var_152_18
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_22 = math.max(var_152_16, arg_149_1.talkMaxDuration)

			if var_152_15 <= arg_149_1.time_ and arg_149_1.time_ < var_152_15 + var_152_22 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_15) / var_152_22

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_15 + var_152_22 and arg_149_1.time_ < var_152_15 + var_152_22 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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
	Play122031037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 122031037
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play122031038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 0
			local var_156_1 = 0.85

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

				local var_156_2 = arg_153_1:GetWordFromCfg(122031037)
				local var_156_3 = arg_153_1:FormatText(var_156_2.content)

				arg_153_1.text_.text = var_156_3

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 34
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
	Play122031038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 122031038
		arg_157_1.duration_ = 8.93

		local var_157_0 = {
			ja = 6.4,
			ko = 8.933,
			zh = 8.933
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
				arg_157_0:Play122031039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			local var_160_0 = arg_157_1.actors_["10044ui_story"].transform
			local var_160_1 = 0

			if var_160_1 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.var_.moveOldPos10044ui_story = var_160_0.localPosition
			end

			local var_160_2 = 0.001

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_2 then
				local var_160_3 = (arg_157_1.time_ - var_160_1) / var_160_2
				local var_160_4 = Vector3.New(0, -0.72, -6.3)

				var_160_0.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos10044ui_story, var_160_4, var_160_3)

				local var_160_5 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_5.x, var_160_5.y, var_160_5.z)

				local var_160_6 = var_160_0.localEulerAngles

				var_160_6.z = 0
				var_160_6.x = 0
				var_160_0.localEulerAngles = var_160_6
			end

			if arg_157_1.time_ >= var_160_1 + var_160_2 and arg_157_1.time_ < var_160_1 + var_160_2 + arg_160_0 then
				var_160_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_160_7 = manager.ui.mainCamera.transform.position - var_160_0.position

				var_160_0.forward = Vector3.New(var_160_7.x, var_160_7.y, var_160_7.z)

				local var_160_8 = var_160_0.localEulerAngles

				var_160_8.z = 0
				var_160_8.x = 0
				var_160_0.localEulerAngles = var_160_8
			end

			local var_160_9 = arg_157_1.actors_["10044ui_story"]
			local var_160_10 = 0

			if var_160_10 < arg_157_1.time_ and arg_157_1.time_ <= var_160_10 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect10044ui_story == nil then
				arg_157_1.var_.characterEffect10044ui_story = var_160_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_11 = 0.200000002980232

			if var_160_10 <= arg_157_1.time_ and arg_157_1.time_ < var_160_10 + var_160_11 and not isNil(var_160_9) then
				local var_160_12 = (arg_157_1.time_ - var_160_10) / var_160_11

				if arg_157_1.var_.characterEffect10044ui_story and not isNil(var_160_9) then
					arg_157_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= var_160_10 + var_160_11 and arg_157_1.time_ < var_160_10 + var_160_11 + arg_160_0 and not isNil(var_160_9) and arg_157_1.var_.characterEffect10044ui_story then
				arg_157_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_160_13 = 0

			if var_160_13 < arg_157_1.time_ and arg_157_1.time_ <= var_160_13 + arg_160_0 then
				arg_157_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_160_14 = 0

			if var_160_14 < arg_157_1.time_ and arg_157_1.time_ <= var_160_14 + arg_160_0 then
				arg_157_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_160_15 = 0
			local var_160_16 = 0.8

			if var_160_15 < arg_157_1.time_ and arg_157_1.time_ <= var_160_15 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				local var_160_17 = arg_157_1:FormatText(StoryNameCfg[380].name)

				arg_157_1.leftNameTxt_.text = var_160_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_18 = arg_157_1:GetWordFromCfg(122031038)
				local var_160_19 = arg_157_1:FormatText(var_160_18.content)

				arg_157_1.text_.text = var_160_19

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_20 = 32
				local var_160_21 = utf8.len(var_160_19)
				local var_160_22 = var_160_20 <= 0 and var_160_16 or var_160_16 * (var_160_21 / var_160_20)

				if var_160_22 > 0 and var_160_16 < var_160_22 then
					arg_157_1.talkMaxDuration = var_160_22

					if var_160_22 + var_160_15 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_22 + var_160_15
					end
				end

				arg_157_1.text_.text = var_160_19
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031038", "story_v_out_122031.awb") ~= 0 then
					local var_160_23 = manager.audio:GetVoiceLength("story_v_out_122031", "122031038", "story_v_out_122031.awb") / 1000

					if var_160_23 + var_160_15 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_23 + var_160_15
					end

					if var_160_18.prefab_name ~= "" and arg_157_1.actors_[var_160_18.prefab_name] ~= nil then
						local var_160_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_18.prefab_name].transform, "story_v_out_122031", "122031038", "story_v_out_122031.awb")

						arg_157_1:RecordAudio("122031038", var_160_24)
						arg_157_1:RecordAudio("122031038", var_160_24)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_122031", "122031038", "story_v_out_122031.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_122031", "122031038", "story_v_out_122031.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_25 = math.max(var_160_16, arg_157_1.talkMaxDuration)

			if var_160_15 <= arg_157_1.time_ and arg_157_1.time_ < var_160_15 + var_160_25 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_15) / var_160_25

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_15 + var_160_25 and arg_157_1.time_ < var_160_15 + var_160_25 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play122031039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 122031039
		arg_161_1.duration_ = 16.17

		local var_161_0 = {
			ja = 13.8,
			ko = 16.166,
			zh = 16.166
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
				arg_161_0:Play122031040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 0

			if var_164_0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_0 + arg_164_0 then
				arg_161_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_2")
			end

			local var_164_1 = 0

			if var_164_1 < arg_161_1.time_ and arg_161_1.time_ <= var_164_1 + arg_164_0 then
				arg_161_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_2 = 0
			local var_164_3 = 1.45

			if var_164_2 < arg_161_1.time_ and arg_161_1.time_ <= var_164_2 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				local var_164_4 = arg_161_1:FormatText(StoryNameCfg[380].name)

				arg_161_1.leftNameTxt_.text = var_164_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_5 = arg_161_1:GetWordFromCfg(122031039)
				local var_164_6 = arg_161_1:FormatText(var_164_5.content)

				arg_161_1.text_.text = var_164_6

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 58
				local var_164_8 = utf8.len(var_164_6)
				local var_164_9 = var_164_7 <= 0 and var_164_3 or var_164_3 * (var_164_8 / var_164_7)

				if var_164_9 > 0 and var_164_3 < var_164_9 then
					arg_161_1.talkMaxDuration = var_164_9

					if var_164_9 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_9 + var_164_2
					end
				end

				arg_161_1.text_.text = var_164_6
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031039", "story_v_out_122031.awb") ~= 0 then
					local var_164_10 = manager.audio:GetVoiceLength("story_v_out_122031", "122031039", "story_v_out_122031.awb") / 1000

					if var_164_10 + var_164_2 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_10 + var_164_2
					end

					if var_164_5.prefab_name ~= "" and arg_161_1.actors_[var_164_5.prefab_name] ~= nil then
						local var_164_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_5.prefab_name].transform, "story_v_out_122031", "122031039", "story_v_out_122031.awb")

						arg_161_1:RecordAudio("122031039", var_164_11)
						arg_161_1:RecordAudio("122031039", var_164_11)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_122031", "122031039", "story_v_out_122031.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_122031", "122031039", "story_v_out_122031.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_12 = math.max(var_164_3, arg_161_1.talkMaxDuration)

			if var_164_2 <= arg_161_1.time_ and arg_161_1.time_ < var_164_2 + var_164_12 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_2) / var_164_12

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_2 + var_164_12 and arg_161_1.time_ < var_164_2 + var_164_12 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play122031040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 122031040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play122031041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = arg_165_1.actors_["10044ui_story"].transform
			local var_168_1 = 0

			if var_168_1 < arg_165_1.time_ and arg_165_1.time_ <= var_168_1 + arg_168_0 then
				arg_165_1.var_.moveOldPos10044ui_story = var_168_0.localPosition
			end

			local var_168_2 = 0.001

			if var_168_1 <= arg_165_1.time_ and arg_165_1.time_ < var_168_1 + var_168_2 then
				local var_168_3 = (arg_165_1.time_ - var_168_1) / var_168_2
				local var_168_4 = Vector3.New(0, 100, 0)

				var_168_0.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10044ui_story, var_168_4, var_168_3)

				local var_168_5 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_5.x, var_168_5.y, var_168_5.z)

				local var_168_6 = var_168_0.localEulerAngles

				var_168_6.z = 0
				var_168_6.x = 0
				var_168_0.localEulerAngles = var_168_6
			end

			if arg_165_1.time_ >= var_168_1 + var_168_2 and arg_165_1.time_ < var_168_1 + var_168_2 + arg_168_0 then
				var_168_0.localPosition = Vector3.New(0, 100, 0)

				local var_168_7 = manager.ui.mainCamera.transform.position - var_168_0.position

				var_168_0.forward = Vector3.New(var_168_7.x, var_168_7.y, var_168_7.z)

				local var_168_8 = var_168_0.localEulerAngles

				var_168_8.z = 0
				var_168_8.x = 0
				var_168_0.localEulerAngles = var_168_8
			end

			local var_168_9 = arg_165_1.actors_["10044ui_story"]
			local var_168_10 = 0

			if var_168_10 < arg_165_1.time_ and arg_165_1.time_ <= var_168_10 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect10044ui_story == nil then
				arg_165_1.var_.characterEffect10044ui_story = var_168_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_11 = 0.200000002980232

			if var_168_10 <= arg_165_1.time_ and arg_165_1.time_ < var_168_10 + var_168_11 and not isNil(var_168_9) then
				local var_168_12 = (arg_165_1.time_ - var_168_10) / var_168_11

				if arg_165_1.var_.characterEffect10044ui_story and not isNil(var_168_9) then
					local var_168_13 = Mathf.Lerp(0, 0.5, var_168_12)

					arg_165_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_165_1.var_.characterEffect10044ui_story.fillRatio = var_168_13
				end
			end

			if arg_165_1.time_ >= var_168_10 + var_168_11 and arg_165_1.time_ < var_168_10 + var_168_11 + arg_168_0 and not isNil(var_168_9) and arg_165_1.var_.characterEffect10044ui_story then
				local var_168_14 = 0.5

				arg_165_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_165_1.var_.characterEffect10044ui_story.fillRatio = var_168_14
			end

			local var_168_15 = 0
			local var_168_16 = 1

			if var_168_15 < arg_165_1.time_ and arg_165_1.time_ <= var_168_15 + arg_168_0 then
				local var_168_17 = "play"
				local var_168_18 = "effect"

				arg_165_1:AudioAction(var_168_17, var_168_18, "se_story_122_01", "se_story_122_01_monsterattack02_loop", "")
			end

			local var_168_19 = 0
			local var_168_20 = 1.275

			if var_168_19 < arg_165_1.time_ and arg_165_1.time_ <= var_168_19 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_21 = arg_165_1:GetWordFromCfg(122031040)
				local var_168_22 = arg_165_1:FormatText(var_168_21.content)

				arg_165_1.text_.text = var_168_22

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_23 = 51
				local var_168_24 = utf8.len(var_168_22)
				local var_168_25 = var_168_23 <= 0 and var_168_20 or var_168_20 * (var_168_24 / var_168_23)

				if var_168_25 > 0 and var_168_20 < var_168_25 then
					arg_165_1.talkMaxDuration = var_168_25

					if var_168_25 + var_168_19 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_25 + var_168_19
					end
				end

				arg_165_1.text_.text = var_168_22
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_26 = math.max(var_168_20, arg_165_1.talkMaxDuration)

			if var_168_19 <= arg_165_1.time_ and arg_165_1.time_ < var_168_19 + var_168_26 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_19) / var_168_26

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_19 + var_168_26 and arg_165_1.time_ < var_168_19 + var_168_26 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play122031041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 122031041
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play122031042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0
			local var_172_1 = 1.175

			if var_172_0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_2 = arg_169_1:GetWordFromCfg(122031041)
				local var_172_3 = arg_169_1:FormatText(var_172_2.content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_4 = 47
				local var_172_5 = utf8.len(var_172_3)
				local var_172_6 = var_172_4 <= 0 and var_172_1 or var_172_1 * (var_172_5 / var_172_4)

				if var_172_6 > 0 and var_172_1 < var_172_6 then
					arg_169_1.talkMaxDuration = var_172_6

					if var_172_6 + var_172_0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_0
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_7 = math.max(var_172_1, arg_169_1.talkMaxDuration)

			if var_172_0 <= arg_169_1.time_ and arg_169_1.time_ < var_172_0 + var_172_7 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_0) / var_172_7

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_0 + var_172_7 and arg_169_1.time_ < var_172_0 + var_172_7 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play122031042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 122031042
		arg_173_1.duration_ = 5.8

		local var_173_0 = {
			ja = 5.8,
			ko = 4.033,
			zh = 4.033
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
				arg_173_0:Play122031043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			local var_176_0 = arg_173_1.actors_["10044ui_story"].transform
			local var_176_1 = 0

			if var_176_1 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.var_.moveOldPos10044ui_story = var_176_0.localPosition
			end

			local var_176_2 = 0.001

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_2 then
				local var_176_3 = (arg_173_1.time_ - var_176_1) / var_176_2
				local var_176_4 = Vector3.New(0, -0.72, -6.3)

				var_176_0.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10044ui_story, var_176_4, var_176_3)

				local var_176_5 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_5.x, var_176_5.y, var_176_5.z)

				local var_176_6 = var_176_0.localEulerAngles

				var_176_6.z = 0
				var_176_6.x = 0
				var_176_0.localEulerAngles = var_176_6
			end

			if arg_173_1.time_ >= var_176_1 + var_176_2 and arg_173_1.time_ < var_176_1 + var_176_2 + arg_176_0 then
				var_176_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_176_7 = manager.ui.mainCamera.transform.position - var_176_0.position

				var_176_0.forward = Vector3.New(var_176_7.x, var_176_7.y, var_176_7.z)

				local var_176_8 = var_176_0.localEulerAngles

				var_176_8.z = 0
				var_176_8.x = 0
				var_176_0.localEulerAngles = var_176_8
			end

			local var_176_9 = arg_173_1.actors_["10044ui_story"]
			local var_176_10 = 0

			if var_176_10 < arg_173_1.time_ and arg_173_1.time_ <= var_176_10 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect10044ui_story == nil then
				arg_173_1.var_.characterEffect10044ui_story = var_176_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_11 = 0.200000002980232

			if var_176_10 <= arg_173_1.time_ and arg_173_1.time_ < var_176_10 + var_176_11 and not isNil(var_176_9) then
				local var_176_12 = (arg_173_1.time_ - var_176_10) / var_176_11

				if arg_173_1.var_.characterEffect10044ui_story and not isNil(var_176_9) then
					arg_173_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= var_176_10 + var_176_11 and arg_173_1.time_ < var_176_10 + var_176_11 + arg_176_0 and not isNil(var_176_9) and arg_173_1.var_.characterEffect10044ui_story then
				arg_173_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_176_13 = 0

			if var_176_13 < arg_173_1.time_ and arg_173_1.time_ <= var_176_13 + arg_176_0 then
				arg_173_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_176_14 = 0

			if var_176_14 < arg_173_1.time_ and arg_173_1.time_ <= var_176_14 + arg_176_0 then
				arg_173_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_176_15 = 0
			local var_176_16 = 0.25

			if var_176_15 < arg_173_1.time_ and arg_173_1.time_ <= var_176_15 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				local var_176_17 = arg_173_1:FormatText(StoryNameCfg[380].name)

				arg_173_1.leftNameTxt_.text = var_176_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_18 = arg_173_1:GetWordFromCfg(122031042)
				local var_176_19 = arg_173_1:FormatText(var_176_18.content)

				arg_173_1.text_.text = var_176_19

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_20 = 10
				local var_176_21 = utf8.len(var_176_19)
				local var_176_22 = var_176_20 <= 0 and var_176_16 or var_176_16 * (var_176_21 / var_176_20)

				if var_176_22 > 0 and var_176_16 < var_176_22 then
					arg_173_1.talkMaxDuration = var_176_22

					if var_176_22 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_22 + var_176_15
					end
				end

				arg_173_1.text_.text = var_176_19
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031042", "story_v_out_122031.awb") ~= 0 then
					local var_176_23 = manager.audio:GetVoiceLength("story_v_out_122031", "122031042", "story_v_out_122031.awb") / 1000

					if var_176_23 + var_176_15 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_23 + var_176_15
					end

					if var_176_18.prefab_name ~= "" and arg_173_1.actors_[var_176_18.prefab_name] ~= nil then
						local var_176_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_18.prefab_name].transform, "story_v_out_122031", "122031042", "story_v_out_122031.awb")

						arg_173_1:RecordAudio("122031042", var_176_24)
						arg_173_1:RecordAudio("122031042", var_176_24)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_122031", "122031042", "story_v_out_122031.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_122031", "122031042", "story_v_out_122031.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_25 = math.max(var_176_16, arg_173_1.talkMaxDuration)

			if var_176_15 <= arg_173_1.time_ and arg_173_1.time_ < var_176_15 + var_176_25 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_15) / var_176_25

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_15 + var_176_25 and arg_173_1.time_ < var_176_15 + var_176_25 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play122031043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 122031043
		arg_177_1.duration_ = 1.83

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play122031044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			local var_180_0 = arg_177_1.actors_["10044ui_story"].transform
			local var_180_1 = 0

			if var_180_1 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.var_.moveOldPos10044ui_story = var_180_0.localPosition
			end

			local var_180_2 = 0.001

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_2 then
				local var_180_3 = (arg_177_1.time_ - var_180_1) / var_180_2
				local var_180_4 = Vector3.New(0, 100, 0)

				var_180_0.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos10044ui_story, var_180_4, var_180_3)

				local var_180_5 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_5.x, var_180_5.y, var_180_5.z)

				local var_180_6 = var_180_0.localEulerAngles

				var_180_6.z = 0
				var_180_6.x = 0
				var_180_0.localEulerAngles = var_180_6
			end

			if arg_177_1.time_ >= var_180_1 + var_180_2 and arg_177_1.time_ < var_180_1 + var_180_2 + arg_180_0 then
				var_180_0.localPosition = Vector3.New(0, 100, 0)

				local var_180_7 = manager.ui.mainCamera.transform.position - var_180_0.position

				var_180_0.forward = Vector3.New(var_180_7.x, var_180_7.y, var_180_7.z)

				local var_180_8 = var_180_0.localEulerAngles

				var_180_8.z = 0
				var_180_8.x = 0
				var_180_0.localEulerAngles = var_180_8
			end

			local var_180_9 = arg_177_1.actors_["10044ui_story"]
			local var_180_10 = 0

			if var_180_10 < arg_177_1.time_ and arg_177_1.time_ <= var_180_10 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect10044ui_story == nil then
				arg_177_1.var_.characterEffect10044ui_story = var_180_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_11 = 0.200000002980232

			if var_180_10 <= arg_177_1.time_ and arg_177_1.time_ < var_180_10 + var_180_11 and not isNil(var_180_9) then
				local var_180_12 = (arg_177_1.time_ - var_180_10) / var_180_11

				if arg_177_1.var_.characterEffect10044ui_story and not isNil(var_180_9) then
					local var_180_13 = Mathf.Lerp(0, 0.5, var_180_12)

					arg_177_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_177_1.var_.characterEffect10044ui_story.fillRatio = var_180_13
				end
			end

			if arg_177_1.time_ >= var_180_10 + var_180_11 and arg_177_1.time_ < var_180_10 + var_180_11 + arg_180_0 and not isNil(var_180_9) and arg_177_1.var_.characterEffect10044ui_story then
				local var_180_14 = 0.5

				arg_177_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_177_1.var_.characterEffect10044ui_story.fillRatio = var_180_14
			end

			local var_180_15 = manager.ui.mainCamera.transform
			local var_180_16 = 0

			if var_180_16 < arg_177_1.time_ and arg_177_1.time_ <= var_180_16 + arg_180_0 then
				arg_177_1.var_.shakeOldPos = var_180_15.localPosition
			end

			local var_180_17 = 0.6

			if var_180_16 <= arg_177_1.time_ and arg_177_1.time_ < var_180_16 + var_180_17 then
				local var_180_18 = (arg_177_1.time_ - var_180_16) / 0.066
				local var_180_19, var_180_20 = math.modf(var_180_18)

				var_180_15.localPosition = Vector3.New(var_180_20 * 0.13, var_180_20 * 0.13, var_180_20 * 0.13) + arg_177_1.var_.shakeOldPos
			end

			if arg_177_1.time_ >= var_180_16 + var_180_17 and arg_177_1.time_ < var_180_16 + var_180_17 + arg_180_0 then
				var_180_15.localPosition = arg_177_1.var_.shakeOldPos
			end

			local var_180_21 = 0

			if var_180_21 < arg_177_1.time_ and arg_177_1.time_ <= var_180_21 + arg_180_0 then
				arg_177_1.allBtn_.enabled = false
			end

			local var_180_22 = 0.6

			if arg_177_1.time_ >= var_180_21 + var_180_22 and arg_177_1.time_ < var_180_21 + var_180_22 + arg_180_0 then
				arg_177_1.allBtn_.enabled = true
			end

			local var_180_23 = 0
			local var_180_24 = 0.6

			if var_180_23 < arg_177_1.time_ and arg_177_1.time_ <= var_180_23 + arg_180_0 then
				local var_180_25 = "play"
				local var_180_26 = "effect"

				arg_177_1:AudioAction(var_180_25, var_180_26, "se_story_120_00", "se_story_120_00_growl", "")
			end

			local var_180_27 = 0
			local var_180_28 = 0.1

			if var_180_27 < arg_177_1.time_ and arg_177_1.time_ <= var_180_27 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				local var_180_29 = arg_177_1:FormatText(StoryNameCfg[68].name)

				arg_177_1.leftNameTxt_.text = var_180_29

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2080")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_30 = arg_177_1:GetWordFromCfg(122031043)
				local var_180_31 = arg_177_1:FormatText(var_180_30.content)

				arg_177_1.text_.text = var_180_31

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_32 = 4
				local var_180_33 = utf8.len(var_180_31)
				local var_180_34 = var_180_32 <= 0 and var_180_28 or var_180_28 * (var_180_33 / var_180_32)

				if var_180_34 > 0 and var_180_28 < var_180_34 then
					arg_177_1.talkMaxDuration = var_180_34

					if var_180_34 + var_180_27 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_34 + var_180_27
					end
				end

				arg_177_1.text_.text = var_180_31
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031043", "story_v_out_122031.awb") ~= 0 then
					local var_180_35 = manager.audio:GetVoiceLength("story_v_out_122031", "122031043", "story_v_out_122031.awb") / 1000

					if var_180_35 + var_180_27 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_35 + var_180_27
					end

					if var_180_30.prefab_name ~= "" and arg_177_1.actors_[var_180_30.prefab_name] ~= nil then
						local var_180_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_30.prefab_name].transform, "story_v_out_122031", "122031043", "story_v_out_122031.awb")

						arg_177_1:RecordAudio("122031043", var_180_36)
						arg_177_1:RecordAudio("122031043", var_180_36)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_122031", "122031043", "story_v_out_122031.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_122031", "122031043", "story_v_out_122031.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_37 = math.max(var_180_28, arg_177_1.talkMaxDuration)

			if var_180_27 <= arg_177_1.time_ and arg_177_1.time_ < var_180_27 + var_180_37 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_27) / var_180_37

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_27 + var_180_37 and arg_177_1.time_ < var_180_27 + var_180_37 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_177_1:InitPlayNodeList()
	end,
	Play122031044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 122031044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play122031045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0
			local var_184_1 = 1.9

			if var_184_0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_2 = arg_181_1:GetWordFromCfg(122031044)
				local var_184_3 = arg_181_1:FormatText(var_184_2.content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 76
				local var_184_5 = utf8.len(var_184_3)
				local var_184_6 = var_184_4 <= 0 and var_184_1 or var_184_1 * (var_184_5 / var_184_4)

				if var_184_6 > 0 and var_184_1 < var_184_6 then
					arg_181_1.talkMaxDuration = var_184_6

					if var_184_6 + var_184_0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_6 + var_184_0
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_1, arg_181_1.talkMaxDuration)

			if var_184_0 <= arg_181_1.time_ and arg_181_1.time_ < var_184_0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_0 + var_184_7 and arg_181_1.time_ < var_184_0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play122031045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 122031045
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play122031046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0
			local var_188_1 = 1.475

			if var_188_0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, false)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_2 = arg_185_1:GetWordFromCfg(122031045)
				local var_188_3 = arg_185_1:FormatText(var_188_2.content)

				arg_185_1.text_.text = var_188_3

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_4 = 59
				local var_188_5 = utf8.len(var_188_3)
				local var_188_6 = var_188_4 <= 0 and var_188_1 or var_188_1 * (var_188_5 / var_188_4)

				if var_188_6 > 0 and var_188_1 < var_188_6 then
					arg_185_1.talkMaxDuration = var_188_6

					if var_188_6 + var_188_0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_6 + var_188_0
					end
				end

				arg_185_1.text_.text = var_188_3
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_7 = math.max(var_188_1, arg_185_1.talkMaxDuration)

			if var_188_0 <= arg_185_1.time_ and arg_185_1.time_ < var_188_0 + var_188_7 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_0) / var_188_7

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_0 + var_188_7 and arg_185_1.time_ < var_188_0 + var_188_7 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play122031046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 122031046
		arg_189_1.duration_ = 3.97

		local var_189_0 = {
			ja = 3.966,
			ko = 3.8,
			zh = 3.8
		}
		local var_189_1 = manager.audio:GetLocalizationFlag()

		if var_189_0[var_189_1] ~= nil then
			arg_189_1.duration_ = var_189_0[var_189_1]
		end

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play122031047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			local var_192_0 = arg_189_1.actors_["10044ui_story"].transform
			local var_192_1 = 0

			if var_192_1 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.var_.moveOldPos10044ui_story = var_192_0.localPosition
			end

			local var_192_2 = 0.001

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_2 then
				local var_192_3 = (arg_189_1.time_ - var_192_1) / var_192_2
				local var_192_4 = Vector3.New(0, -0.72, -6.3)

				var_192_0.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos10044ui_story, var_192_4, var_192_3)

				local var_192_5 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_5.x, var_192_5.y, var_192_5.z)

				local var_192_6 = var_192_0.localEulerAngles

				var_192_6.z = 0
				var_192_6.x = 0
				var_192_0.localEulerAngles = var_192_6
			end

			if arg_189_1.time_ >= var_192_1 + var_192_2 and arg_189_1.time_ < var_192_1 + var_192_2 + arg_192_0 then
				var_192_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_192_7 = manager.ui.mainCamera.transform.position - var_192_0.position

				var_192_0.forward = Vector3.New(var_192_7.x, var_192_7.y, var_192_7.z)

				local var_192_8 = var_192_0.localEulerAngles

				var_192_8.z = 0
				var_192_8.x = 0
				var_192_0.localEulerAngles = var_192_8
			end

			local var_192_9 = arg_189_1.actors_["10044ui_story"]
			local var_192_10 = 0

			if var_192_10 < arg_189_1.time_ and arg_189_1.time_ <= var_192_10 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect10044ui_story == nil then
				arg_189_1.var_.characterEffect10044ui_story = var_192_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_11 = 0.200000002980232

			if var_192_10 <= arg_189_1.time_ and arg_189_1.time_ < var_192_10 + var_192_11 and not isNil(var_192_9) then
				local var_192_12 = (arg_189_1.time_ - var_192_10) / var_192_11

				if arg_189_1.var_.characterEffect10044ui_story and not isNil(var_192_9) then
					arg_189_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_189_1.time_ >= var_192_10 + var_192_11 and arg_189_1.time_ < var_192_10 + var_192_11 + arg_192_0 and not isNil(var_192_9) and arg_189_1.var_.characterEffect10044ui_story then
				arg_189_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_192_13 = 0

			if var_192_13 < arg_189_1.time_ and arg_189_1.time_ <= var_192_13 + arg_192_0 then
				arg_189_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_192_14 = 0

			if var_192_14 < arg_189_1.time_ and arg_189_1.time_ <= var_192_14 + arg_192_0 then
				arg_189_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_192_15 = 0
			local var_192_16 = 0.525

			if var_192_15 < arg_189_1.time_ and arg_189_1.time_ <= var_192_15 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, true)

				local var_192_17 = arg_189_1:FormatText(StoryNameCfg[380].name)

				arg_189_1.leftNameTxt_.text = var_192_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_189_1.leftNameTxt_.transform)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1.leftNameTxt_.text)
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_18 = arg_189_1:GetWordFromCfg(122031046)
				local var_192_19 = arg_189_1:FormatText(var_192_18.content)

				arg_189_1.text_.text = var_192_19

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_20 = 21
				local var_192_21 = utf8.len(var_192_19)
				local var_192_22 = var_192_20 <= 0 and var_192_16 or var_192_16 * (var_192_21 / var_192_20)

				if var_192_22 > 0 and var_192_16 < var_192_22 then
					arg_189_1.talkMaxDuration = var_192_22

					if var_192_22 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_22 + var_192_15
					end
				end

				arg_189_1.text_.text = var_192_19
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031046", "story_v_out_122031.awb") ~= 0 then
					local var_192_23 = manager.audio:GetVoiceLength("story_v_out_122031", "122031046", "story_v_out_122031.awb") / 1000

					if var_192_23 + var_192_15 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_23 + var_192_15
					end

					if var_192_18.prefab_name ~= "" and arg_189_1.actors_[var_192_18.prefab_name] ~= nil then
						local var_192_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_189_1.actors_[var_192_18.prefab_name].transform, "story_v_out_122031", "122031046", "story_v_out_122031.awb")

						arg_189_1:RecordAudio("122031046", var_192_24)
						arg_189_1:RecordAudio("122031046", var_192_24)
					else
						arg_189_1:AudioAction("play", "voice", "story_v_out_122031", "122031046", "story_v_out_122031.awb")
					end

					arg_189_1:RecordHistoryTalkVoice("story_v_out_122031", "122031046", "story_v_out_122031.awb")
				end

				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_25 = math.max(var_192_16, arg_189_1.talkMaxDuration)

			if var_192_15 <= arg_189_1.time_ and arg_189_1.time_ < var_192_15 + var_192_25 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_15) / var_192_25

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_15 + var_192_25 and arg_189_1.time_ < var_192_15 + var_192_25 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play122031047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 122031047
		arg_193_1.duration_ = 9.5

		local var_193_0 = {
			ja = 9.50000000298023,
			ko = 8.06600000298023,
			zh = 8.06600000298023
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
				arg_193_0:Play122031048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			local var_196_0 = "ST37a"

			if arg_193_1.bgs_[var_196_0] == nil then
				local var_196_1 = Object.Instantiate(arg_193_1.paintGo_)

				var_196_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_196_0)
				var_196_1.name = var_196_0
				var_196_1.transform.parent = arg_193_1.stage_.transform
				var_196_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_193_1.bgs_[var_196_0] = var_196_1
			end

			local var_196_2 = 2.00000000298023

			if var_196_2 < arg_193_1.time_ and arg_193_1.time_ <= var_196_2 + arg_196_0 then
				local var_196_3 = manager.ui.mainCamera.transform.localPosition
				local var_196_4 = Vector3.New(0, 0, 10) + Vector3.New(var_196_3.x, var_196_3.y, 0)
				local var_196_5 = arg_193_1.bgs_.ST37a

				var_196_5.transform.localPosition = var_196_4
				var_196_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_196_6 = var_196_5:GetComponent("SpriteRenderer")

				if var_196_6 and var_196_6.sprite then
					local var_196_7 = (var_196_5.transform.localPosition - var_196_3).z
					local var_196_8 = manager.ui.mainCameraCom_
					local var_196_9 = 2 * var_196_7 * Mathf.Tan(var_196_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_196_10 = var_196_9 * var_196_8.aspect
					local var_196_11 = var_196_6.sprite.bounds.size.x
					local var_196_12 = var_196_6.sprite.bounds.size.y
					local var_196_13 = var_196_10 / var_196_11
					local var_196_14 = var_196_9 / var_196_12
					local var_196_15 = var_196_14 < var_196_13 and var_196_13 or var_196_14

					var_196_5.transform.localScale = Vector3.New(var_196_15, var_196_15, 0)
				end

				for iter_196_0, iter_196_1 in pairs(arg_193_1.bgs_) do
					if iter_196_0 ~= "ST37a" then
						iter_196_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_196_16 = 0

			if var_196_16 < arg_193_1.time_ and arg_193_1.time_ <= var_196_16 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_17 = 2

			if var_196_16 <= arg_193_1.time_ and arg_193_1.time_ < var_196_16 + var_196_17 then
				local var_196_18 = (arg_193_1.time_ - var_196_16) / var_196_17
				local var_196_19 = Color.New(0, 0, 0)

				var_196_19.a = Mathf.Lerp(0, 1, var_196_18)
				arg_193_1.mask_.color = var_196_19
			end

			if arg_193_1.time_ >= var_196_16 + var_196_17 and arg_193_1.time_ < var_196_16 + var_196_17 + arg_196_0 then
				local var_196_20 = Color.New(0, 0, 0)

				var_196_20.a = 1
				arg_193_1.mask_.color = var_196_20
			end

			local var_196_21 = 2

			if var_196_21 < arg_193_1.time_ and arg_193_1.time_ <= var_196_21 + arg_196_0 then
				arg_193_1.mask_.enabled = true
				arg_193_1.mask_.raycastTarget = true

				arg_193_1:SetGaussion(false)
			end

			local var_196_22 = 2

			if var_196_21 <= arg_193_1.time_ and arg_193_1.time_ < var_196_21 + var_196_22 then
				local var_196_23 = (arg_193_1.time_ - var_196_21) / var_196_22
				local var_196_24 = Color.New(0, 0, 0)

				var_196_24.a = Mathf.Lerp(1, 0, var_196_23)
				arg_193_1.mask_.color = var_196_24
			end

			if arg_193_1.time_ >= var_196_21 + var_196_22 and arg_193_1.time_ < var_196_21 + var_196_22 + arg_196_0 then
				local var_196_25 = Color.New(0, 0, 0)
				local var_196_26 = 0

				arg_193_1.mask_.enabled = false
				var_196_25.a = var_196_26
				arg_193_1.mask_.color = var_196_25
			end

			local var_196_27 = arg_193_1.actors_["10044ui_story"].transform
			local var_196_28 = 3.8

			if var_196_28 < arg_193_1.time_ and arg_193_1.time_ <= var_196_28 + arg_196_0 then
				arg_193_1.var_.moveOldPos10044ui_story = var_196_27.localPosition
			end

			local var_196_29 = 0.001

			if var_196_28 <= arg_193_1.time_ and arg_193_1.time_ < var_196_28 + var_196_29 then
				local var_196_30 = (arg_193_1.time_ - var_196_28) / var_196_29
				local var_196_31 = Vector3.New(0, -0.72, -6.3)

				var_196_27.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10044ui_story, var_196_31, var_196_30)

				local var_196_32 = manager.ui.mainCamera.transform.position - var_196_27.position

				var_196_27.forward = Vector3.New(var_196_32.x, var_196_32.y, var_196_32.z)

				local var_196_33 = var_196_27.localEulerAngles

				var_196_33.z = 0
				var_196_33.x = 0
				var_196_27.localEulerAngles = var_196_33
			end

			if arg_193_1.time_ >= var_196_28 + var_196_29 and arg_193_1.time_ < var_196_28 + var_196_29 + arg_196_0 then
				var_196_27.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_196_34 = manager.ui.mainCamera.transform.position - var_196_27.position

				var_196_27.forward = Vector3.New(var_196_34.x, var_196_34.y, var_196_34.z)

				local var_196_35 = var_196_27.localEulerAngles

				var_196_35.z = 0
				var_196_35.x = 0
				var_196_27.localEulerAngles = var_196_35
			end

			local var_196_36 = arg_193_1.actors_["10044ui_story"]
			local var_196_37 = 3.8

			if var_196_37 < arg_193_1.time_ and arg_193_1.time_ <= var_196_37 + arg_196_0 and not isNil(var_196_36) and arg_193_1.var_.characterEffect10044ui_story == nil then
				arg_193_1.var_.characterEffect10044ui_story = var_196_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_38 = 0.200000002980232

			if var_196_37 <= arg_193_1.time_ and arg_193_1.time_ < var_196_37 + var_196_38 and not isNil(var_196_36) then
				local var_196_39 = (arg_193_1.time_ - var_196_37) / var_196_38

				if arg_193_1.var_.characterEffect10044ui_story and not isNil(var_196_36) then
					arg_193_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= var_196_37 + var_196_38 and arg_193_1.time_ < var_196_37 + var_196_38 + arg_196_0 and not isNil(var_196_36) and arg_193_1.var_.characterEffect10044ui_story then
				arg_193_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_196_40 = 3.8

			if var_196_40 < arg_193_1.time_ and arg_193_1.time_ <= var_196_40 + arg_196_0 then
				arg_193_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_196_41 = 3.8

			if var_196_41 < arg_193_1.time_ and arg_193_1.time_ <= var_196_41 + arg_196_0 then
				arg_193_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_196_42 = arg_193_1.actors_["10044ui_story"].transform
			local var_196_43 = 1.96599999815226

			if var_196_43 < arg_193_1.time_ and arg_193_1.time_ <= var_196_43 + arg_196_0 then
				arg_193_1.var_.moveOldPos10044ui_story = var_196_42.localPosition
			end

			local var_196_44 = 0.001

			if var_196_43 <= arg_193_1.time_ and arg_193_1.time_ < var_196_43 + var_196_44 then
				local var_196_45 = (arg_193_1.time_ - var_196_43) / var_196_44
				local var_196_46 = Vector3.New(0, 100, 0)

				var_196_42.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10044ui_story, var_196_46, var_196_45)

				local var_196_47 = manager.ui.mainCamera.transform.position - var_196_42.position

				var_196_42.forward = Vector3.New(var_196_47.x, var_196_47.y, var_196_47.z)

				local var_196_48 = var_196_42.localEulerAngles

				var_196_48.z = 0
				var_196_48.x = 0
				var_196_42.localEulerAngles = var_196_48
			end

			if arg_193_1.time_ >= var_196_43 + var_196_44 and arg_193_1.time_ < var_196_43 + var_196_44 + arg_196_0 then
				var_196_42.localPosition = Vector3.New(0, 100, 0)

				local var_196_49 = manager.ui.mainCamera.transform.position - var_196_42.position

				var_196_42.forward = Vector3.New(var_196_49.x, var_196_49.y, var_196_49.z)

				local var_196_50 = var_196_42.localEulerAngles

				var_196_50.z = 0
				var_196_50.x = 0
				var_196_42.localEulerAngles = var_196_50
			end

			local var_196_51 = 0
			local var_196_52 = 1

			if var_196_51 < arg_193_1.time_ and arg_193_1.time_ <= var_196_51 + arg_196_0 then
				local var_196_53 = "stop"
				local var_196_54 = "effect"

				arg_193_1:AudioAction(var_196_53, var_196_54, "se_story_122_01", "se_story_122_01_monsterattack02_loop", "")
			end

			local var_196_55 = 0
			local var_196_56 = 1

			if var_196_55 < arg_193_1.time_ and arg_193_1.time_ <= var_196_55 + arg_196_0 then
				local var_196_57 = "play"
				local var_196_58 = "effect"

				arg_193_1:AudioAction(var_196_57, var_196_58, "se_story_120_04", "se_story_120_04_dooropen", "")
			end

			if arg_193_1.frameCnt_ <= 1 then
				arg_193_1.dialog_:SetActive(false)
			end

			local var_196_59 = 4.00000000298023
			local var_196_60 = 0.4

			if var_196_59 < arg_193_1.time_ and arg_193_1.time_ <= var_196_59 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0

				arg_193_1.dialog_:SetActive(true)

				arg_193_1.dialogCg_.alpha = 0

				local var_196_61 = LeanTween.value(arg_193_1.dialog_, 0, 1, 0.3)

				var_196_61:setOnUpdate(LuaHelper.FloatAction(function(arg_197_0)
					arg_193_1.dialogCg_.alpha = arg_197_0
				end))
				var_196_61:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_193_1.dialog_)
					var_196_61:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_193_1.duration_ = arg_193_1.duration_ + 0.3

				SetActive(arg_193_1.leftNameGo_, true)

				local var_196_62 = arg_193_1:FormatText(StoryNameCfg[380].name)

				arg_193_1.leftNameTxt_.text = var_196_62

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_63 = arg_193_1:GetWordFromCfg(122031047)
				local var_196_64 = arg_193_1:FormatText(var_196_63.content)

				arg_193_1.text_.text = var_196_64

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_65 = 16
				local var_196_66 = utf8.len(var_196_64)
				local var_196_67 = var_196_65 <= 0 and var_196_60 or var_196_60 * (var_196_66 / var_196_65)

				if var_196_67 > 0 and var_196_60 < var_196_67 then
					arg_193_1.talkMaxDuration = var_196_67
					var_196_59 = var_196_59 + 0.3

					if var_196_67 + var_196_59 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_67 + var_196_59
					end
				end

				arg_193_1.text_.text = var_196_64
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031047", "story_v_out_122031.awb") ~= 0 then
					local var_196_68 = manager.audio:GetVoiceLength("story_v_out_122031", "122031047", "story_v_out_122031.awb") / 1000

					if var_196_68 + var_196_59 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_68 + var_196_59
					end

					if var_196_63.prefab_name ~= "" and arg_193_1.actors_[var_196_63.prefab_name] ~= nil then
						local var_196_69 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_63.prefab_name].transform, "story_v_out_122031", "122031047", "story_v_out_122031.awb")

						arg_193_1:RecordAudio("122031047", var_196_69)
						arg_193_1:RecordAudio("122031047", var_196_69)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_122031", "122031047", "story_v_out_122031.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_122031", "122031047", "story_v_out_122031.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_70 = var_196_59 + 0.3
			local var_196_71 = math.max(var_196_60, arg_193_1.talkMaxDuration)

			if var_196_70 <= arg_193_1.time_ and arg_193_1.time_ < var_196_70 + var_196_71 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_70) / var_196_71

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_70 + var_196_71 and arg_193_1.time_ < var_196_70 + var_196_71 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play122031048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 122031048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play122031049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10044ui_story"].transform
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.var_.moveOldPos10044ui_story = var_202_0.localPosition
			end

			local var_202_2 = 0.001

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2
				local var_202_4 = Vector3.New(0, 100, 0)

				var_202_0.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10044ui_story, var_202_4, var_202_3)

				local var_202_5 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_5.x, var_202_5.y, var_202_5.z)

				local var_202_6 = var_202_0.localEulerAngles

				var_202_6.z = 0
				var_202_6.x = 0
				var_202_0.localEulerAngles = var_202_6
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 then
				var_202_0.localPosition = Vector3.New(0, 100, 0)

				local var_202_7 = manager.ui.mainCamera.transform.position - var_202_0.position

				var_202_0.forward = Vector3.New(var_202_7.x, var_202_7.y, var_202_7.z)

				local var_202_8 = var_202_0.localEulerAngles

				var_202_8.z = 0
				var_202_8.x = 0
				var_202_0.localEulerAngles = var_202_8
			end

			local var_202_9 = arg_199_1.actors_["10044ui_story"]
			local var_202_10 = 0

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect10044ui_story == nil then
				arg_199_1.var_.characterEffect10044ui_story = var_202_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_11 = 0.200000002980232

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_11 and not isNil(var_202_9) then
				local var_202_12 = (arg_199_1.time_ - var_202_10) / var_202_11

				if arg_199_1.var_.characterEffect10044ui_story and not isNil(var_202_9) then
					local var_202_13 = Mathf.Lerp(0, 0.5, var_202_12)

					arg_199_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_199_1.var_.characterEffect10044ui_story.fillRatio = var_202_13
				end
			end

			if arg_199_1.time_ >= var_202_10 + var_202_11 and arg_199_1.time_ < var_202_10 + var_202_11 + arg_202_0 and not isNil(var_202_9) and arg_199_1.var_.characterEffect10044ui_story then
				local var_202_14 = 0.5

				arg_199_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_199_1.var_.characterEffect10044ui_story.fillRatio = var_202_14
			end

			local var_202_15 = 0
			local var_202_16 = 1.6

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_17 = arg_199_1:GetWordFromCfg(122031048)
				local var_202_18 = arg_199_1:FormatText(var_202_17.content)

				arg_199_1.text_.text = var_202_18

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_19 = 64
				local var_202_20 = utf8.len(var_202_18)
				local var_202_21 = var_202_19 <= 0 and var_202_16 or var_202_16 * (var_202_20 / var_202_19)

				if var_202_21 > 0 and var_202_16 < var_202_21 then
					arg_199_1.talkMaxDuration = var_202_21

					if var_202_21 + var_202_15 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_21 + var_202_15
					end
				end

				arg_199_1.text_.text = var_202_18
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_22 = math.max(var_202_16, arg_199_1.talkMaxDuration)

			if var_202_15 <= arg_199_1.time_ and arg_199_1.time_ < var_202_15 + var_202_22 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_15) / var_202_22

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_15 + var_202_22 and arg_199_1.time_ < var_202_15 + var_202_22 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play122031049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 122031049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play122031050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = manager.ui.mainCamera.transform
			local var_206_1 = 0

			if var_206_1 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.var_.shakeOldPos = var_206_0.localPosition
			end

			local var_206_2 = 0.6

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_2 then
				local var_206_3 = (arg_203_1.time_ - var_206_1) / 0.066
				local var_206_4, var_206_5 = math.modf(var_206_3)

				var_206_0.localPosition = Vector3.New(var_206_5 * 0.13, var_206_5 * 0.13, var_206_5 * 0.13) + arg_203_1.var_.shakeOldPos
			end

			if arg_203_1.time_ >= var_206_1 + var_206_2 and arg_203_1.time_ < var_206_1 + var_206_2 + arg_206_0 then
				var_206_0.localPosition = arg_203_1.var_.shakeOldPos
			end

			local var_206_6 = 0

			if var_206_6 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.allBtn_.enabled = false
			end

			local var_206_7 = 0.6

			if arg_203_1.time_ >= var_206_6 + var_206_7 and arg_203_1.time_ < var_206_6 + var_206_7 + arg_206_0 then
				arg_203_1.allBtn_.enabled = true
			end

			local var_206_8 = 0
			local var_206_9 = 0.7

			if var_206_8 < arg_203_1.time_ and arg_203_1.time_ <= var_206_8 + arg_206_0 then
				local var_206_10 = "play"
				local var_206_11 = "effect"

				arg_203_1:AudioAction(var_206_10, var_206_11, "se_story_122_01", "se_story_122_01_door03", "")
			end

			local var_206_12 = 0
			local var_206_13 = 0.1

			if var_206_12 < arg_203_1.time_ and arg_203_1.time_ <= var_206_12 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, false)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_14 = arg_203_1:GetWordFromCfg(122031049)
				local var_206_15 = arg_203_1:FormatText(var_206_14.content)

				arg_203_1.text_.text = var_206_15

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_16 = 4
				local var_206_17 = utf8.len(var_206_15)
				local var_206_18 = var_206_16 <= 0 and var_206_13 or var_206_13 * (var_206_17 / var_206_16)

				if var_206_18 > 0 and var_206_13 < var_206_18 then
					arg_203_1.talkMaxDuration = var_206_18

					if var_206_18 + var_206_12 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_18 + var_206_12
					end
				end

				arg_203_1.text_.text = var_206_15
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_19 = math.max(var_206_13, arg_203_1.talkMaxDuration)

			if var_206_12 <= arg_203_1.time_ and arg_203_1.time_ < var_206_12 + var_206_19 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_12) / var_206_19

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_12 + var_206_19 and arg_203_1.time_ < var_206_12 + var_206_19 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play122031050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 122031050
		arg_207_1.duration_ = 5

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play122031051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = 0
			local var_210_1 = 1.8

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

				local var_210_2 = arg_207_1:GetWordFromCfg(122031050)
				local var_210_3 = arg_207_1:FormatText(var_210_2.content)

				arg_207_1.text_.text = var_210_3

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_4 = 72
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
	Play122031051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 122031051
		arg_211_1.duration_ = 10.9

		local var_211_0 = {
			ja = 8.066,
			ko = 10.9,
			zh = 10.9
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
				arg_211_0:Play122031052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10044ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos10044ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0, -0.72, -6.3)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10044ui_story, var_214_4, var_214_3)

				local var_214_5 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_5.x, var_214_5.y, var_214_5.z)

				local var_214_6 = var_214_0.localEulerAngles

				var_214_6.z = 0
				var_214_6.x = 0
				var_214_0.localEulerAngles = var_214_6
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_214_7 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_7.x, var_214_7.y, var_214_7.z)

				local var_214_8 = var_214_0.localEulerAngles

				var_214_8.z = 0
				var_214_8.x = 0
				var_214_0.localEulerAngles = var_214_8
			end

			local var_214_9 = arg_211_1.actors_["10044ui_story"]
			local var_214_10 = 0

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect10044ui_story == nil then
				arg_211_1.var_.characterEffect10044ui_story = var_214_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_11 = 0.200000002980232

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_11 and not isNil(var_214_9) then
				local var_214_12 = (arg_211_1.time_ - var_214_10) / var_214_11

				if arg_211_1.var_.characterEffect10044ui_story and not isNil(var_214_9) then
					arg_211_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_10 + var_214_11 and arg_211_1.time_ < var_214_10 + var_214_11 + arg_214_0 and not isNil(var_214_9) and arg_211_1.var_.characterEffect10044ui_story then
				arg_211_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_214_13 = 0

			if var_214_13 < arg_211_1.time_ and arg_211_1.time_ <= var_214_13 + arg_214_0 then
				arg_211_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_214_14 = 0

			if var_214_14 < arg_211_1.time_ and arg_211_1.time_ <= var_214_14 + arg_214_0 then
				arg_211_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_214_15 = 0
			local var_214_16 = 0.825

			if var_214_15 < arg_211_1.time_ and arg_211_1.time_ <= var_214_15 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_17 = arg_211_1:FormatText(StoryNameCfg[380].name)

				arg_211_1.leftNameTxt_.text = var_214_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_18 = arg_211_1:GetWordFromCfg(122031051)
				local var_214_19 = arg_211_1:FormatText(var_214_18.content)

				arg_211_1.text_.text = var_214_19

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_20 = 33
				local var_214_21 = utf8.len(var_214_19)
				local var_214_22 = var_214_20 <= 0 and var_214_16 or var_214_16 * (var_214_21 / var_214_20)

				if var_214_22 > 0 and var_214_16 < var_214_22 then
					arg_211_1.talkMaxDuration = var_214_22

					if var_214_22 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_22 + var_214_15
					end
				end

				arg_211_1.text_.text = var_214_19
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031051", "story_v_out_122031.awb") ~= 0 then
					local var_214_23 = manager.audio:GetVoiceLength("story_v_out_122031", "122031051", "story_v_out_122031.awb") / 1000

					if var_214_23 + var_214_15 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_23 + var_214_15
					end

					if var_214_18.prefab_name ~= "" and arg_211_1.actors_[var_214_18.prefab_name] ~= nil then
						local var_214_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_18.prefab_name].transform, "story_v_out_122031", "122031051", "story_v_out_122031.awb")

						arg_211_1:RecordAudio("122031051", var_214_24)
						arg_211_1:RecordAudio("122031051", var_214_24)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_122031", "122031051", "story_v_out_122031.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_122031", "122031051", "story_v_out_122031.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_25 = math.max(var_214_16, arg_211_1.talkMaxDuration)

			if var_214_15 <= arg_211_1.time_ and arg_211_1.time_ < var_214_15 + var_214_25 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_15) / var_214_25

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_15 + var_214_25 and arg_211_1.time_ < var_214_15 + var_214_25 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play122031052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 122031052
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play122031053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10044ui_story"].transform
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.var_.moveOldPos10044ui_story = var_218_0.localPosition
			end

			local var_218_2 = 0.001

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2
				local var_218_4 = Vector3.New(0, 100, 0)

				var_218_0.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10044ui_story, var_218_4, var_218_3)

				local var_218_5 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_5.x, var_218_5.y, var_218_5.z)

				local var_218_6 = var_218_0.localEulerAngles

				var_218_6.z = 0
				var_218_6.x = 0
				var_218_0.localEulerAngles = var_218_6
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 then
				var_218_0.localPosition = Vector3.New(0, 100, 0)

				local var_218_7 = manager.ui.mainCamera.transform.position - var_218_0.position

				var_218_0.forward = Vector3.New(var_218_7.x, var_218_7.y, var_218_7.z)

				local var_218_8 = var_218_0.localEulerAngles

				var_218_8.z = 0
				var_218_8.x = 0
				var_218_0.localEulerAngles = var_218_8
			end

			local var_218_9 = arg_215_1.actors_["10044ui_story"]
			local var_218_10 = 0

			if var_218_10 < arg_215_1.time_ and arg_215_1.time_ <= var_218_10 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect10044ui_story == nil then
				arg_215_1.var_.characterEffect10044ui_story = var_218_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_11 = 0.200000002980232

			if var_218_10 <= arg_215_1.time_ and arg_215_1.time_ < var_218_10 + var_218_11 and not isNil(var_218_9) then
				local var_218_12 = (arg_215_1.time_ - var_218_10) / var_218_11

				if arg_215_1.var_.characterEffect10044ui_story and not isNil(var_218_9) then
					local var_218_13 = Mathf.Lerp(0, 0.5, var_218_12)

					arg_215_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_215_1.var_.characterEffect10044ui_story.fillRatio = var_218_13
				end
			end

			if arg_215_1.time_ >= var_218_10 + var_218_11 and arg_215_1.time_ < var_218_10 + var_218_11 + arg_218_0 and not isNil(var_218_9) and arg_215_1.var_.characterEffect10044ui_story then
				local var_218_14 = 0.5

				arg_215_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_215_1.var_.characterEffect10044ui_story.fillRatio = var_218_14
			end

			local var_218_15 = 0
			local var_218_16 = 1

			if var_218_15 < arg_215_1.time_ and arg_215_1.time_ <= var_218_15 + arg_218_0 then
				local var_218_17 = "play"
				local var_218_18 = "effect"

				arg_215_1:AudioAction(var_218_17, var_218_18, "se_story_122_01", "se_story_122_01_door01", "")
			end

			local var_218_19 = 0
			local var_218_20 = 1.25

			if var_218_19 < arg_215_1.time_ and arg_215_1.time_ <= var_218_19 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_21 = arg_215_1:GetWordFromCfg(122031052)
				local var_218_22 = arg_215_1:FormatText(var_218_21.content)

				arg_215_1.text_.text = var_218_22

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_23 = 50
				local var_218_24 = utf8.len(var_218_22)
				local var_218_25 = var_218_23 <= 0 and var_218_20 or var_218_20 * (var_218_24 / var_218_23)

				if var_218_25 > 0 and var_218_20 < var_218_25 then
					arg_215_1.talkMaxDuration = var_218_25

					if var_218_25 + var_218_19 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_25 + var_218_19
					end
				end

				arg_215_1.text_.text = var_218_22
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_26 = math.max(var_218_20, arg_215_1.talkMaxDuration)

			if var_218_19 <= arg_215_1.time_ and arg_215_1.time_ < var_218_19 + var_218_26 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_19) / var_218_26

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_19 + var_218_26 and arg_215_1.time_ < var_218_19 + var_218_26 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play122031053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 122031053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play122031054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0
			local var_222_1 = 1

			if var_222_0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_0 + arg_222_0 then
				local var_222_2 = "play"
				local var_222_3 = "effect"

				arg_219_1:AudioAction(var_222_2, var_222_3, "se_story_122_01", "se_story_122_01_door02", "")
			end

			local var_222_4 = 0
			local var_222_5 = 0.625

			if var_222_4 < arg_219_1.time_ and arg_219_1.time_ <= var_222_4 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_6 = arg_219_1:GetWordFromCfg(122031053)
				local var_222_7 = arg_219_1:FormatText(var_222_6.content)

				arg_219_1.text_.text = var_222_7

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_8 = 25
				local var_222_9 = utf8.len(var_222_7)
				local var_222_10 = var_222_8 <= 0 and var_222_5 or var_222_5 * (var_222_9 / var_222_8)

				if var_222_10 > 0 and var_222_5 < var_222_10 then
					arg_219_1.talkMaxDuration = var_222_10

					if var_222_10 + var_222_4 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_10 + var_222_4
					end
				end

				arg_219_1.text_.text = var_222_7
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_11 = math.max(var_222_5, arg_219_1.talkMaxDuration)

			if var_222_4 <= arg_219_1.time_ and arg_219_1.time_ < var_222_4 + var_222_11 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_4) / var_222_11

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_4 + var_222_11 and arg_219_1.time_ < var_222_4 + var_222_11 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play122031054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 122031054
		arg_223_1.duration_ = 2.97

		local var_223_0 = {
			ja = 2.966,
			ko = 2.4,
			zh = 2.4
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
				arg_223_0:Play122031055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10044ui_story"].transform
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.var_.moveOldPos10044ui_story = var_226_0.localPosition
			end

			local var_226_2 = 0.001

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2
				local var_226_4 = Vector3.New(0, -0.72, -6.3)

				var_226_0.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10044ui_story, var_226_4, var_226_3)

				local var_226_5 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_5.x, var_226_5.y, var_226_5.z)

				local var_226_6 = var_226_0.localEulerAngles

				var_226_6.z = 0
				var_226_6.x = 0
				var_226_0.localEulerAngles = var_226_6
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 then
				var_226_0.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_226_7 = manager.ui.mainCamera.transform.position - var_226_0.position

				var_226_0.forward = Vector3.New(var_226_7.x, var_226_7.y, var_226_7.z)

				local var_226_8 = var_226_0.localEulerAngles

				var_226_8.z = 0
				var_226_8.x = 0
				var_226_0.localEulerAngles = var_226_8
			end

			local var_226_9 = arg_223_1.actors_["10044ui_story"]
			local var_226_10 = 0

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect10044ui_story == nil then
				arg_223_1.var_.characterEffect10044ui_story = var_226_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_11 = 0.200000002980232

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_11 and not isNil(var_226_9) then
				local var_226_12 = (arg_223_1.time_ - var_226_10) / var_226_11

				if arg_223_1.var_.characterEffect10044ui_story and not isNil(var_226_9) then
					arg_223_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_10 + var_226_11 and arg_223_1.time_ < var_226_10 + var_226_11 + arg_226_0 and not isNil(var_226_9) and arg_223_1.var_.characterEffect10044ui_story then
				arg_223_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_226_13 = 0

			if var_226_13 < arg_223_1.time_ and arg_223_1.time_ <= var_226_13 + arg_226_0 then
				arg_223_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action2_1")
			end

			local var_226_14 = 0

			if var_226_14 < arg_223_1.time_ and arg_223_1.time_ <= var_226_14 + arg_226_0 then
				arg_223_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_226_15 = 0
			local var_226_16 = 0.275

			if var_226_15 < arg_223_1.time_ and arg_223_1.time_ <= var_226_15 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_17 = arg_223_1:FormatText(StoryNameCfg[380].name)

				arg_223_1.leftNameTxt_.text = var_226_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_18 = arg_223_1:GetWordFromCfg(122031054)
				local var_226_19 = arg_223_1:FormatText(var_226_18.content)

				arg_223_1.text_.text = var_226_19

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_20 = 11
				local var_226_21 = utf8.len(var_226_19)
				local var_226_22 = var_226_20 <= 0 and var_226_16 or var_226_16 * (var_226_21 / var_226_20)

				if var_226_22 > 0 and var_226_16 < var_226_22 then
					arg_223_1.talkMaxDuration = var_226_22

					if var_226_22 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_22 + var_226_15
					end
				end

				arg_223_1.text_.text = var_226_19
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031054", "story_v_out_122031.awb") ~= 0 then
					local var_226_23 = manager.audio:GetVoiceLength("story_v_out_122031", "122031054", "story_v_out_122031.awb") / 1000

					if var_226_23 + var_226_15 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_23 + var_226_15
					end

					if var_226_18.prefab_name ~= "" and arg_223_1.actors_[var_226_18.prefab_name] ~= nil then
						local var_226_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_18.prefab_name].transform, "story_v_out_122031", "122031054", "story_v_out_122031.awb")

						arg_223_1:RecordAudio("122031054", var_226_24)
						arg_223_1:RecordAudio("122031054", var_226_24)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_122031", "122031054", "story_v_out_122031.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_122031", "122031054", "story_v_out_122031.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_25 = math.max(var_226_16, arg_223_1.talkMaxDuration)

			if var_226_15 <= arg_223_1.time_ and arg_223_1.time_ < var_226_15 + var_226_25 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_15) / var_226_25

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_15 + var_226_25 and arg_223_1.time_ < var_226_15 + var_226_25 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play122031055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 122031055
		arg_227_1.duration_ = 3.8

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play122031056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 1.8

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action423")
			end

			local var_230_1 = 1.8

			if var_230_1 < arg_227_1.time_ and arg_227_1.time_ <= var_230_1 + arg_230_0 then
				arg_227_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_230_2 = 0

			if var_230_2 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				arg_227_1.mask_.enabled = true
				arg_227_1.mask_.raycastTarget = true

				arg_227_1:SetGaussion(false)
			end

			local var_230_3 = 2

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_3 then
				local var_230_4 = (arg_227_1.time_ - var_230_2) / var_230_3
				local var_230_5 = Color.New(1, 1, 1)

				var_230_5.a = Mathf.Lerp(1, 0, var_230_4)
				arg_227_1.mask_.color = var_230_5
			end

			if arg_227_1.time_ >= var_230_2 + var_230_3 and arg_227_1.time_ < var_230_2 + var_230_3 + arg_230_0 then
				local var_230_6 = Color.New(1, 1, 1)
				local var_230_7 = 0

				arg_227_1.mask_.enabled = false
				var_230_6.a = var_230_7
				arg_227_1.mask_.color = var_230_6
			end

			if arg_227_1.frameCnt_ <= 1 then
				arg_227_1.dialog_:SetActive(false)
			end

			local var_230_8 = 2
			local var_230_9 = 0.075

			if var_230_8 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0

				arg_227_1.dialog_:SetActive(true)

				arg_227_1.dialogCg_.alpha = 0

				local var_230_10 = LeanTween.value(arg_227_1.dialog_, 0, 1, 0.3)

				var_230_10:setOnUpdate(LuaHelper.FloatAction(function(arg_231_0)
					arg_227_1.dialogCg_.alpha = arg_231_0
				end))
				var_230_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_227_1.dialog_)
					var_230_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_227_1.duration_ = arg_227_1.duration_ + 0.3

				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_11 = arg_227_1:FormatText(StoryNameCfg[380].name)

				arg_227_1.leftNameTxt_.text = var_230_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_12 = arg_227_1:GetWordFromCfg(122031055)
				local var_230_13 = arg_227_1:FormatText(var_230_12.content)

				arg_227_1.text_.text = var_230_13

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_14 = 3
				local var_230_15 = utf8.len(var_230_13)
				local var_230_16 = var_230_14 <= 0 and var_230_9 or var_230_9 * (var_230_15 / var_230_14)

				if var_230_16 > 0 and var_230_9 < var_230_16 then
					arg_227_1.talkMaxDuration = var_230_16
					var_230_8 = var_230_8 + 0.3

					if var_230_16 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_16 + var_230_8
					end
				end

				arg_227_1.text_.text = var_230_13
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031055", "story_v_out_122031.awb") ~= 0 then
					local var_230_17 = manager.audio:GetVoiceLength("story_v_out_122031", "122031055", "story_v_out_122031.awb") / 1000

					if var_230_17 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_17 + var_230_8
					end

					if var_230_12.prefab_name ~= "" and arg_227_1.actors_[var_230_12.prefab_name] ~= nil then
						local var_230_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_12.prefab_name].transform, "story_v_out_122031", "122031055", "story_v_out_122031.awb")

						arg_227_1:RecordAudio("122031055", var_230_18)
						arg_227_1:RecordAudio("122031055", var_230_18)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_122031", "122031055", "story_v_out_122031.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_122031", "122031055", "story_v_out_122031.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_19 = var_230_8 + 0.3
			local var_230_20 = math.max(var_230_9, arg_227_1.talkMaxDuration)

			if var_230_19 <= arg_227_1.time_ and arg_227_1.time_ < var_230_19 + var_230_20 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_19) / var_230_20

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_19 + var_230_20 and arg_227_1.time_ < var_230_19 + var_230_20 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play122031056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 122031056
		arg_233_1.duration_ = 3.9

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play122031057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = arg_233_1.actors_["10044ui_story"].transform
			local var_236_1 = 0

			if var_236_1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_1 + arg_236_0 then
				arg_233_1.var_.moveOldPos10044ui_story = var_236_0.localPosition
			end

			local var_236_2 = 0.001

			if var_236_1 <= arg_233_1.time_ and arg_233_1.time_ < var_236_1 + var_236_2 then
				local var_236_3 = (arg_233_1.time_ - var_236_1) / var_236_2
				local var_236_4 = Vector3.New(0, 100, 0)

				var_236_0.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos10044ui_story, var_236_4, var_236_3)

				local var_236_5 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_5.x, var_236_5.y, var_236_5.z)

				local var_236_6 = var_236_0.localEulerAngles

				var_236_6.z = 0
				var_236_6.x = 0
				var_236_0.localEulerAngles = var_236_6
			end

			if arg_233_1.time_ >= var_236_1 + var_236_2 and arg_233_1.time_ < var_236_1 + var_236_2 + arg_236_0 then
				var_236_0.localPosition = Vector3.New(0, 100, 0)

				local var_236_7 = manager.ui.mainCamera.transform.position - var_236_0.position

				var_236_0.forward = Vector3.New(var_236_7.x, var_236_7.y, var_236_7.z)

				local var_236_8 = var_236_0.localEulerAngles

				var_236_8.z = 0
				var_236_8.x = 0
				var_236_0.localEulerAngles = var_236_8
			end

			local var_236_9 = arg_233_1.actors_["10044ui_story"]
			local var_236_10 = 0

			if var_236_10 < arg_233_1.time_ and arg_233_1.time_ <= var_236_10 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect10044ui_story == nil then
				arg_233_1.var_.characterEffect10044ui_story = var_236_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_11 = 0.05

			if var_236_10 <= arg_233_1.time_ and arg_233_1.time_ < var_236_10 + var_236_11 and not isNil(var_236_9) then
				local var_236_12 = (arg_233_1.time_ - var_236_10) / var_236_11

				if arg_233_1.var_.characterEffect10044ui_story and not isNil(var_236_9) then
					local var_236_13 = Mathf.Lerp(0, 0.5, var_236_12)

					arg_233_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_233_1.var_.characterEffect10044ui_story.fillRatio = var_236_13
				end
			end

			if arg_233_1.time_ >= var_236_10 + var_236_11 and arg_233_1.time_ < var_236_10 + var_236_11 + arg_236_0 and not isNil(var_236_9) and arg_233_1.var_.characterEffect10044ui_story then
				local var_236_14 = 0.5

				arg_233_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_233_1.var_.characterEffect10044ui_story.fillRatio = var_236_14
			end

			local var_236_15 = "1074ui_story"

			if arg_233_1.actors_[var_236_15] == nil then
				local var_236_16 = Asset.Load("Char/" .. "1074ui_story")

				if not isNil(var_236_16) then
					local var_236_17 = Object.Instantiate(Asset.Load("Char/" .. "1074ui_story"), arg_233_1.stage_.transform)

					var_236_17.name = var_236_15
					var_236_17.transform.localPosition = Vector3.New(0, 100, 0)
					arg_233_1.actors_[var_236_15] = var_236_17

					local var_236_18 = var_236_17:GetComponentInChildren(typeof(CharacterEffect))

					var_236_18.enabled = true

					local var_236_19 = GameObjectTools.GetOrAddComponent(var_236_17, typeof(DynamicBoneHelper))

					if var_236_19 then
						var_236_19:EnableDynamicBone(false)
					end

					arg_233_1:ShowWeapon(var_236_18.transform, false)

					arg_233_1.var_[var_236_15 .. "Animator"] = var_236_18.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_233_1.var_[var_236_15 .. "Animator"].applyRootMotion = true
					arg_233_1.var_[var_236_15 .. "LipSync"] = var_236_18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_236_20 = arg_233_1.actors_["1074ui_story"].transform
			local var_236_21 = 0

			if var_236_21 < arg_233_1.time_ and arg_233_1.time_ <= var_236_21 + arg_236_0 then
				arg_233_1.var_.moveOldPos1074ui_story = var_236_20.localPosition

				local var_236_22 = "1074ui_story"

				arg_233_1:ShowWeapon(arg_233_1.var_[var_236_22 .. "Animator"].transform, true)
			end

			local var_236_23 = 0.001

			if var_236_21 <= arg_233_1.time_ and arg_233_1.time_ < var_236_21 + var_236_23 then
				local var_236_24 = (arg_233_1.time_ - var_236_21) / var_236_23
				local var_236_25 = Vector3.New(0, -1.055, -6.12)

				var_236_20.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1074ui_story, var_236_25, var_236_24)

				local var_236_26 = manager.ui.mainCamera.transform.position - var_236_20.position

				var_236_20.forward = Vector3.New(var_236_26.x, var_236_26.y, var_236_26.z)

				local var_236_27 = var_236_20.localEulerAngles

				var_236_27.z = 0
				var_236_27.x = 0
				var_236_20.localEulerAngles = var_236_27
			end

			if arg_233_1.time_ >= var_236_21 + var_236_23 and arg_233_1.time_ < var_236_21 + var_236_23 + arg_236_0 then
				var_236_20.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_236_28 = manager.ui.mainCamera.transform.position - var_236_20.position

				var_236_20.forward = Vector3.New(var_236_28.x, var_236_28.y, var_236_28.z)

				local var_236_29 = var_236_20.localEulerAngles

				var_236_29.z = 0
				var_236_29.x = 0
				var_236_20.localEulerAngles = var_236_29
			end

			local var_236_30 = arg_233_1.actors_["1074ui_story"]
			local var_236_31 = 0

			if var_236_31 < arg_233_1.time_ and arg_233_1.time_ <= var_236_31 + arg_236_0 and not isNil(var_236_30) and arg_233_1.var_.characterEffect1074ui_story == nil then
				arg_233_1.var_.characterEffect1074ui_story = var_236_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_32 = 0.200000002980232

			if var_236_31 <= arg_233_1.time_ and arg_233_1.time_ < var_236_31 + var_236_32 and not isNil(var_236_30) then
				local var_236_33 = (arg_233_1.time_ - var_236_31) / var_236_32

				if arg_233_1.var_.characterEffect1074ui_story and not isNil(var_236_30) then
					arg_233_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= var_236_31 + var_236_32 and arg_233_1.time_ < var_236_31 + var_236_32 + arg_236_0 and not isNil(var_236_30) and arg_233_1.var_.characterEffect1074ui_story then
				arg_233_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_236_34 = 0

			if var_236_34 < arg_233_1.time_ and arg_233_1.time_ <= var_236_34 + arg_236_0 then
				arg_233_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action7_1")
			end

			local var_236_35 = 0

			if var_236_35 < arg_233_1.time_ and arg_233_1.time_ <= var_236_35 + arg_236_0 then
				arg_233_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_236_36 = 0
			local var_236_37 = 0.4

			if var_236_36 < arg_233_1.time_ and arg_233_1.time_ <= var_236_36 + arg_236_0 then
				local var_236_38 = "play"
				local var_236_39 = "music"

				arg_233_1:AudioAction(var_236_38, var_236_39, "ui_battle", "ui_battle_stopbgm", "")

				local var_236_40 = ""
				local var_236_41 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_236_41 ~= "" then
					if arg_233_1.bgmTxt_.text ~= var_236_41 and arg_233_1.bgmTxt_.text ~= "" then
						if arg_233_1.bgmTxt2_.text ~= "" then
							arg_233_1.bgmTxt_.text = arg_233_1.bgmTxt2_.text
						end

						arg_233_1.bgmTxt2_.text = var_236_41

						arg_233_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_233_1.bgmTxt_.text = var_236_41
						arg_233_1.bgmTxt2_.text = var_236_41
					end

					if arg_233_1.bgmTimer then
						arg_233_1.bgmTimer:Stop()

						arg_233_1.bgmTimer = nil
					end

					if arg_233_1.settingData.show_music_name == 1 then
						arg_233_1.musicController:SetSelectedState("show")
						arg_233_1.musicAnimator_:Play("open", 0, 0)

						if arg_233_1.settingData.music_time ~= 0 then
							arg_233_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_233_1.settingData.music_time), function()
								if arg_233_1 == nil or isNil(arg_233_1.bgmTxt_) then
									return
								end

								arg_233_1.musicController:SetSelectedState("hide")
								arg_233_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_236_42 = 0
			local var_236_43 = 0.05

			if var_236_42 < arg_233_1.time_ and arg_233_1.time_ <= var_236_42 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				local var_236_44 = arg_233_1:FormatText(StoryNameCfg[410].name)

				arg_233_1.leftNameTxt_.text = var_236_44

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_45 = arg_233_1:GetWordFromCfg(122031056)
				local var_236_46 = arg_233_1:FormatText(var_236_45.content)

				arg_233_1.text_.text = var_236_46

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_47 = 2
				local var_236_48 = utf8.len(var_236_46)
				local var_236_49 = var_236_47 <= 0 and var_236_43 or var_236_43 * (var_236_48 / var_236_47)

				if var_236_49 > 0 and var_236_43 < var_236_49 then
					arg_233_1.talkMaxDuration = var_236_49

					if var_236_49 + var_236_42 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_49 + var_236_42
					end
				end

				arg_233_1.text_.text = var_236_46
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031056", "story_v_out_122031.awb") ~= 0 then
					local var_236_50 = manager.audio:GetVoiceLength("story_v_out_122031", "122031056", "story_v_out_122031.awb") / 1000

					if var_236_50 + var_236_42 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_50 + var_236_42
					end

					if var_236_45.prefab_name ~= "" and arg_233_1.actors_[var_236_45.prefab_name] ~= nil then
						local var_236_51 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_45.prefab_name].transform, "story_v_out_122031", "122031056", "story_v_out_122031.awb")

						arg_233_1:RecordAudio("122031056", var_236_51)
						arg_233_1:RecordAudio("122031056", var_236_51)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_122031", "122031056", "story_v_out_122031.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_122031", "122031056", "story_v_out_122031.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_52 = math.max(var_236_43, arg_233_1.talkMaxDuration)

			if var_236_42 <= arg_233_1.time_ and arg_233_1.time_ < var_236_42 + var_236_52 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_42) / var_236_52

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_42 + var_236_52 and arg_233_1.time_ < var_236_42 + var_236_52 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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

		arg_233_1:InitPlayNodeList()
	end,
	Play122031057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 122031057
		arg_238_1.duration_ = 8.17

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play122031058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["1074ui_story"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos1074ui_story = var_241_0.localPosition
			end

			local var_241_2 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2
				local var_241_4 = Vector3.New(0, 100, 0)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1074ui_story, var_241_4, var_241_3)

				local var_241_5 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_5.x, var_241_5.y, var_241_5.z)

				local var_241_6 = var_241_0.localEulerAngles

				var_241_6.z = 0
				var_241_6.x = 0
				var_241_0.localEulerAngles = var_241_6
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(0, 100, 0)

				local var_241_7 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_7.x, var_241_7.y, var_241_7.z)

				local var_241_8 = var_241_0.localEulerAngles

				var_241_8.z = 0
				var_241_8.x = 0
				var_241_0.localEulerAngles = var_241_8
			end

			local var_241_9 = arg_238_1.actors_["1074ui_story"]
			local var_241_10 = 0

			if var_241_10 < arg_238_1.time_ and arg_238_1.time_ <= var_241_10 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect1074ui_story == nil then
				arg_238_1.var_.characterEffect1074ui_story = var_241_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_11 = 0.200000002980232

			if var_241_10 <= arg_238_1.time_ and arg_238_1.time_ < var_241_10 + var_241_11 and not isNil(var_241_9) then
				local var_241_12 = (arg_238_1.time_ - var_241_10) / var_241_11

				if arg_238_1.var_.characterEffect1074ui_story and not isNil(var_241_9) then
					local var_241_13 = Mathf.Lerp(0, 0.5, var_241_12)

					arg_238_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1074ui_story.fillRatio = var_241_13
				end
			end

			if arg_238_1.time_ >= var_241_10 + var_241_11 and arg_238_1.time_ < var_241_10 + var_241_11 + arg_241_0 and not isNil(var_241_9) and arg_238_1.var_.characterEffect1074ui_story then
				local var_241_14 = 0.5

				arg_238_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1074ui_story.fillRatio = var_241_14
			end

			local var_241_15 = 0
			local var_241_16 = 1

			if var_241_15 < arg_238_1.time_ and arg_238_1.time_ <= var_241_15 + arg_241_0 then
				local var_241_17 = "play"
				local var_241_18 = "effect"

				arg_238_1:AudioAction(var_241_17, var_241_18, "se_story_122_01", "se_story_122_01_bomb", "")
			end

			local var_241_19 = 0

			if var_241_19 < arg_238_1.time_ and arg_238_1.time_ <= var_241_19 + arg_241_0 then
				arg_238_1.mask_.enabled = true
				arg_238_1.mask_.raycastTarget = true

				arg_238_1:SetGaussion(false)
			end

			local var_241_20 = 3.5

			if var_241_19 <= arg_238_1.time_ and arg_238_1.time_ < var_241_19 + var_241_20 then
				local var_241_21 = (arg_238_1.time_ - var_241_19) / var_241_20
				local var_241_22 = Color.New(1, 1, 1)

				var_241_22.a = Mathf.Lerp(1, 0, var_241_21)
				arg_238_1.mask_.color = var_241_22
			end

			if arg_238_1.time_ >= var_241_19 + var_241_20 and arg_238_1.time_ < var_241_19 + var_241_20 + arg_241_0 then
				local var_241_23 = Color.New(1, 1, 1)
				local var_241_24 = 0

				arg_238_1.mask_.enabled = false
				var_241_23.a = var_241_24
				arg_238_1.mask_.color = var_241_23
			end

			if arg_238_1.frameCnt_ <= 1 then
				arg_238_1.dialog_:SetActive(false)
			end

			local var_241_25 = 3.16666666666667
			local var_241_26 = 1.3

			if var_241_25 < arg_238_1.time_ and arg_238_1.time_ <= var_241_25 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0

				arg_238_1.dialog_:SetActive(true)

				arg_238_1.dialogCg_.alpha = 0

				local var_241_27 = LeanTween.value(arg_238_1.dialog_, 0, 1, 0.3)

				var_241_27:setOnUpdate(LuaHelper.FloatAction(function(arg_242_0)
					arg_238_1.dialogCg_.alpha = arg_242_0
				end))
				var_241_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_238_1.dialog_)
					var_241_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_238_1.duration_ = arg_238_1.duration_ + 0.3

				SetActive(arg_238_1.leftNameGo_, false)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_28 = arg_238_1:GetWordFromCfg(122031057)
				local var_241_29 = arg_238_1:FormatText(var_241_28.content)

				arg_238_1.text_.text = var_241_29

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_30 = 52
				local var_241_31 = utf8.len(var_241_29)
				local var_241_32 = var_241_30 <= 0 and var_241_26 or var_241_26 * (var_241_31 / var_241_30)

				if var_241_32 > 0 and var_241_26 < var_241_32 then
					arg_238_1.talkMaxDuration = var_241_32
					var_241_25 = var_241_25 + 0.3

					if var_241_32 + var_241_25 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_32 + var_241_25
					end
				end

				arg_238_1.text_.text = var_241_29
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_33 = var_241_25 + 0.3
			local var_241_34 = math.max(var_241_26, arg_238_1.talkMaxDuration)

			if var_241_33 <= arg_238_1.time_ and arg_238_1.time_ < var_241_33 + var_241_34 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_33) / var_241_34

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_33 + var_241_34 and arg_238_1.time_ < var_241_33 + var_241_34 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
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

		arg_238_1:InitPlayNodeList()
	end,
	Play122031058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 122031058
		arg_244_1.duration_ = 14.37

		local var_244_0 = {
			ja = 14.366,
			ko = 6.233333333332,
			zh = 6.233333333332
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play122031059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			local var_247_0 = arg_244_1.actors_["1074ui_story"].transform
			local var_247_1 = 3.8

			if var_247_1 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.var_.moveOldPos1074ui_story = var_247_0.localPosition

				local var_247_2 = "1074ui_story"

				arg_244_1:ShowWeapon(arg_244_1.var_[var_247_2 .. "Animator"].transform, false)
			end

			local var_247_3 = 0.001

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_3 then
				local var_247_4 = (arg_244_1.time_ - var_247_1) / var_247_3
				local var_247_5 = Vector3.New(-0.7, -1.055, -6.12)

				var_247_0.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1074ui_story, var_247_5, var_247_4)

				local var_247_6 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_6.x, var_247_6.y, var_247_6.z)

				local var_247_7 = var_247_0.localEulerAngles

				var_247_7.z = 0
				var_247_7.x = 0
				var_247_0.localEulerAngles = var_247_7
			end

			if arg_244_1.time_ >= var_247_1 + var_247_3 and arg_244_1.time_ < var_247_1 + var_247_3 + arg_247_0 then
				var_247_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_247_8 = manager.ui.mainCamera.transform.position - var_247_0.position

				var_247_0.forward = Vector3.New(var_247_8.x, var_247_8.y, var_247_8.z)

				local var_247_9 = var_247_0.localEulerAngles

				var_247_9.z = 0
				var_247_9.x = 0
				var_247_0.localEulerAngles = var_247_9
			end

			local var_247_10 = arg_244_1.actors_["1074ui_story"]
			local var_247_11 = 3.8

			if var_247_11 < arg_244_1.time_ and arg_244_1.time_ <= var_247_11 + arg_247_0 and not isNil(var_247_10) and arg_244_1.var_.characterEffect1074ui_story == nil then
				arg_244_1.var_.characterEffect1074ui_story = var_247_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_12 = 0.200000002980232

			if var_247_11 <= arg_244_1.time_ and arg_244_1.time_ < var_247_11 + var_247_12 and not isNil(var_247_10) then
				local var_247_13 = (arg_244_1.time_ - var_247_11) / var_247_12

				if arg_244_1.var_.characterEffect1074ui_story and not isNil(var_247_10) then
					arg_244_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= var_247_11 + var_247_12 and arg_244_1.time_ < var_247_11 + var_247_12 + arg_247_0 and not isNil(var_247_10) and arg_244_1.var_.characterEffect1074ui_story then
				arg_244_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_247_14 = 3.8

			if var_247_14 < arg_244_1.time_ and arg_244_1.time_ <= var_247_14 + arg_247_0 then
				arg_244_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_247_15 = 3.8

			if var_247_15 < arg_244_1.time_ and arg_244_1.time_ <= var_247_15 + arg_247_0 then
				arg_244_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_247_16 = arg_244_1.actors_["10044ui_story"].transform
			local var_247_17 = 3.8

			if var_247_17 < arg_244_1.time_ and arg_244_1.time_ <= var_247_17 + arg_247_0 then
				arg_244_1.var_.moveOldPos10044ui_story = var_247_16.localPosition
			end

			local var_247_18 = 0.001

			if var_247_17 <= arg_244_1.time_ and arg_244_1.time_ < var_247_17 + var_247_18 then
				local var_247_19 = (arg_244_1.time_ - var_247_17) / var_247_18
				local var_247_20 = Vector3.New(0.7, -0.72, -6.3)

				var_247_16.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10044ui_story, var_247_20, var_247_19)

				local var_247_21 = manager.ui.mainCamera.transform.position - var_247_16.position

				var_247_16.forward = Vector3.New(var_247_21.x, var_247_21.y, var_247_21.z)

				local var_247_22 = var_247_16.localEulerAngles

				var_247_22.z = 0
				var_247_22.x = 0
				var_247_16.localEulerAngles = var_247_22
			end

			if arg_244_1.time_ >= var_247_17 + var_247_18 and arg_244_1.time_ < var_247_17 + var_247_18 + arg_247_0 then
				var_247_16.localPosition = Vector3.New(0.7, -0.72, -6.3)

				local var_247_23 = manager.ui.mainCamera.transform.position - var_247_16.position

				var_247_16.forward = Vector3.New(var_247_23.x, var_247_23.y, var_247_23.z)

				local var_247_24 = var_247_16.localEulerAngles

				var_247_24.z = 0
				var_247_24.x = 0
				var_247_16.localEulerAngles = var_247_24
			end

			local var_247_25 = arg_244_1.actors_["10044ui_story"]
			local var_247_26 = 3.8

			if var_247_26 < arg_244_1.time_ and arg_244_1.time_ <= var_247_26 + arg_247_0 and not isNil(var_247_25) and arg_244_1.var_.characterEffect10044ui_story == nil then
				arg_244_1.var_.characterEffect10044ui_story = var_247_25:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_27 = 0.200000002980232

			if var_247_26 <= arg_244_1.time_ and arg_244_1.time_ < var_247_26 + var_247_27 and not isNil(var_247_25) then
				local var_247_28 = (arg_244_1.time_ - var_247_26) / var_247_27

				if arg_244_1.var_.characterEffect10044ui_story and not isNil(var_247_25) then
					local var_247_29 = Mathf.Lerp(0, 0.5, var_247_28)

					arg_244_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_244_1.var_.characterEffect10044ui_story.fillRatio = var_247_29
				end
			end

			if arg_244_1.time_ >= var_247_26 + var_247_27 and arg_244_1.time_ < var_247_26 + var_247_27 + arg_247_0 and not isNil(var_247_25) and arg_244_1.var_.characterEffect10044ui_story then
				local var_247_30 = 0.5

				arg_244_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_244_1.var_.characterEffect10044ui_story.fillRatio = var_247_30
			end

			local var_247_31 = 0
			local var_247_32 = 0.133333333333333

			if var_247_31 < arg_244_1.time_ and arg_244_1.time_ <= var_247_31 + arg_247_0 then
				local var_247_33 = "play"
				local var_247_34 = "music"

				arg_244_1:AudioAction(var_247_33, var_247_34, "ui_battle", "ui_battle_stopbgm", "")

				local var_247_35 = ""
				local var_247_36 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if var_247_36 ~= "" then
					if arg_244_1.bgmTxt_.text ~= var_247_36 and arg_244_1.bgmTxt_.text ~= "" then
						if arg_244_1.bgmTxt2_.text ~= "" then
							arg_244_1.bgmTxt_.text = arg_244_1.bgmTxt2_.text
						end

						arg_244_1.bgmTxt2_.text = var_247_36

						arg_244_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_244_1.bgmTxt_.text = var_247_36
						arg_244_1.bgmTxt2_.text = var_247_36
					end

					if arg_244_1.bgmTimer then
						arg_244_1.bgmTimer:Stop()

						arg_244_1.bgmTimer = nil
					end

					if arg_244_1.settingData.show_music_name == 1 then
						arg_244_1.musicController:SetSelectedState("show")
						arg_244_1.musicAnimator_:Play("open", 0, 0)

						if arg_244_1.settingData.music_time ~= 0 then
							arg_244_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_244_1.settingData.music_time), function()
								if arg_244_1 == nil or isNil(arg_244_1.bgmTxt_) then
									return
								end

								arg_244_1.musicController:SetSelectedState("hide")
								arg_244_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_247_37 = 0.200000002980232
			local var_247_38 = 0.7

			if var_247_37 < arg_244_1.time_ and arg_244_1.time_ <= var_247_37 + arg_247_0 then
				local var_247_39 = "play"
				local var_247_40 = "music"

				arg_244_1:AudioAction(var_247_39, var_247_40, "bgm_activity_2_0_battle_tianlu", "bgm_activity_2_0_battle_tianlu", "bgm_activity_2_0_battle_tianlu.awb")

				local var_247_41 = ""
				local var_247_42 = manager.audio:GetAudioName("bgm_activity_2_0_battle_tianlu", "bgm_activity_2_0_battle_tianlu")

				if var_247_42 ~= "" then
					if arg_244_1.bgmTxt_.text ~= var_247_42 and arg_244_1.bgmTxt_.text ~= "" then
						if arg_244_1.bgmTxt2_.text ~= "" then
							arg_244_1.bgmTxt_.text = arg_244_1.bgmTxt2_.text
						end

						arg_244_1.bgmTxt2_.text = var_247_42

						arg_244_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_244_1.bgmTxt_.text = var_247_42
						arg_244_1.bgmTxt2_.text = var_247_42
					end

					if arg_244_1.bgmTimer then
						arg_244_1.bgmTimer:Stop()

						arg_244_1.bgmTimer = nil
					end

					if arg_244_1.settingData.show_music_name == 1 then
						arg_244_1.musicController:SetSelectedState("show")
						arg_244_1.musicAnimator_:Play("open", 0, 0)

						if arg_244_1.settingData.music_time ~= 0 then
							arg_244_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_244_1.settingData.music_time), function()
								if arg_244_1 == nil or isNil(arg_244_1.bgmTxt_) then
									return
								end

								arg_244_1.musicController:SetSelectedState("hide")
								arg_244_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_247_43 = 0

			if var_247_43 < arg_244_1.time_ and arg_244_1.time_ <= var_247_43 + arg_247_0 then
				arg_244_1.mask_.enabled = true
				arg_244_1.mask_.raycastTarget = true

				arg_244_1:SetGaussion(false)
			end

			local var_247_44 = 2

			if var_247_43 <= arg_244_1.time_ and arg_244_1.time_ < var_247_43 + var_247_44 then
				local var_247_45 = (arg_244_1.time_ - var_247_43) / var_247_44
				local var_247_46 = Color.New(0, 0, 0)

				var_247_46.a = Mathf.Lerp(0, 1, var_247_45)
				arg_244_1.mask_.color = var_247_46
			end

			if arg_244_1.time_ >= var_247_43 + var_247_44 and arg_244_1.time_ < var_247_43 + var_247_44 + arg_247_0 then
				local var_247_47 = Color.New(0, 0, 0)

				var_247_47.a = 1
				arg_244_1.mask_.color = var_247_47
			end

			local var_247_48 = 2

			if var_247_48 < arg_244_1.time_ and arg_244_1.time_ <= var_247_48 + arg_247_0 then
				arg_244_1.mask_.enabled = true
				arg_244_1.mask_.raycastTarget = true

				arg_244_1:SetGaussion(false)
			end

			local var_247_49 = 2

			if var_247_48 <= arg_244_1.time_ and arg_244_1.time_ < var_247_48 + var_247_49 then
				local var_247_50 = (arg_244_1.time_ - var_247_48) / var_247_49
				local var_247_51 = Color.New(0, 0, 0)

				var_247_51.a = Mathf.Lerp(1, 0, var_247_50)
				arg_244_1.mask_.color = var_247_51
			end

			if arg_244_1.time_ >= var_247_48 + var_247_49 and arg_244_1.time_ < var_247_48 + var_247_49 + arg_247_0 then
				local var_247_52 = Color.New(0, 0, 0)
				local var_247_53 = 0

				arg_244_1.mask_.enabled = false
				var_247_52.a = var_247_53
				arg_244_1.mask_.color = var_247_52
			end

			if arg_244_1.frameCnt_ <= 1 then
				arg_244_1.dialog_:SetActive(false)
			end

			local var_247_54 = 4
			local var_247_55 = 0.3

			if var_247_54 < arg_244_1.time_ and arg_244_1.time_ <= var_247_54 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0

				arg_244_1.dialog_:SetActive(true)

				arg_244_1.dialogCg_.alpha = 0

				local var_247_56 = LeanTween.value(arg_244_1.dialog_, 0, 1, 0.3)

				var_247_56:setOnUpdate(LuaHelper.FloatAction(function(arg_250_0)
					arg_244_1.dialogCg_.alpha = arg_250_0
				end))
				var_247_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_244_1.dialog_)
					var_247_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_244_1.duration_ = arg_244_1.duration_ + 0.3

				SetActive(arg_244_1.leftNameGo_, true)

				local var_247_57 = arg_244_1:FormatText(StoryNameCfg[410].name)

				arg_244_1.leftNameTxt_.text = var_247_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_58 = arg_244_1:GetWordFromCfg(122031058)
				local var_247_59 = arg_244_1:FormatText(var_247_58.content)

				arg_244_1.text_.text = var_247_59

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_60 = 12
				local var_247_61 = utf8.len(var_247_59)
				local var_247_62 = var_247_60 <= 0 and var_247_55 or var_247_55 * (var_247_61 / var_247_60)

				if var_247_62 > 0 and var_247_55 < var_247_62 then
					arg_244_1.talkMaxDuration = var_247_62
					var_247_54 = var_247_54 + 0.3

					if var_247_62 + var_247_54 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_62 + var_247_54
					end
				end

				arg_244_1.text_.text = var_247_59
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031058", "story_v_out_122031.awb") ~= 0 then
					local var_247_63 = manager.audio:GetVoiceLength("story_v_out_122031", "122031058", "story_v_out_122031.awb") / 1000

					if var_247_63 + var_247_54 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_63 + var_247_54
					end

					if var_247_58.prefab_name ~= "" and arg_244_1.actors_[var_247_58.prefab_name] ~= nil then
						local var_247_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_58.prefab_name].transform, "story_v_out_122031", "122031058", "story_v_out_122031.awb")

						arg_244_1:RecordAudio("122031058", var_247_64)
						arg_244_1:RecordAudio("122031058", var_247_64)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_122031", "122031058", "story_v_out_122031.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_122031", "122031058", "story_v_out_122031.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_65 = var_247_54 + 0.3
			local var_247_66 = math.max(var_247_55, arg_244_1.talkMaxDuration)

			if var_247_65 <= arg_244_1.time_ and arg_244_1.time_ < var_247_65 + var_247_66 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_65) / var_247_66

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_65 + var_247_66 and arg_244_1.time_ < var_247_65 + var_247_66 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1074ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play122031059 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 122031059
		arg_252_1.duration_ = 9.27

		local var_252_0 = {
			ja = 9.266,
			ko = 5.1,
			zh = 5.1
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
				arg_252_0:Play122031060(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = arg_252_1.actors_["10044ui_story"]
			local var_255_1 = 0

			if var_255_1 < arg_252_1.time_ and arg_252_1.time_ <= var_255_1 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect10044ui_story == nil then
				arg_252_1.var_.characterEffect10044ui_story = var_255_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_2 = 0.200000002980232

			if var_255_1 <= arg_252_1.time_ and arg_252_1.time_ < var_255_1 + var_255_2 and not isNil(var_255_0) then
				local var_255_3 = (arg_252_1.time_ - var_255_1) / var_255_2

				if arg_252_1.var_.characterEffect10044ui_story and not isNil(var_255_0) then
					arg_252_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= var_255_1 + var_255_2 and arg_252_1.time_ < var_255_1 + var_255_2 + arg_255_0 and not isNil(var_255_0) and arg_252_1.var_.characterEffect10044ui_story then
				arg_252_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_255_4 = 0

			if var_255_4 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action434")
			end

			local var_255_5 = 0

			if var_255_5 < arg_252_1.time_ and arg_252_1.time_ <= var_255_5 + arg_255_0 then
				arg_252_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_255_6 = arg_252_1.actors_["1074ui_story"]
			local var_255_7 = 0

			if var_255_7 < arg_252_1.time_ and arg_252_1.time_ <= var_255_7 + arg_255_0 and not isNil(var_255_6) and arg_252_1.var_.characterEffect1074ui_story == nil then
				arg_252_1.var_.characterEffect1074ui_story = var_255_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_8 = 0.200000002980232

			if var_255_7 <= arg_252_1.time_ and arg_252_1.time_ < var_255_7 + var_255_8 and not isNil(var_255_6) then
				local var_255_9 = (arg_252_1.time_ - var_255_7) / var_255_8

				if arg_252_1.var_.characterEffect1074ui_story and not isNil(var_255_6) then
					local var_255_10 = Mathf.Lerp(0, 0.5, var_255_9)

					arg_252_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1074ui_story.fillRatio = var_255_10
				end
			end

			if arg_252_1.time_ >= var_255_7 + var_255_8 and arg_252_1.time_ < var_255_7 + var_255_8 + arg_255_0 and not isNil(var_255_6) and arg_252_1.var_.characterEffect1074ui_story then
				local var_255_11 = 0.5

				arg_252_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1074ui_story.fillRatio = var_255_11
			end

			local var_255_12 = 0
			local var_255_13 = 0.525

			if var_255_12 < arg_252_1.time_ and arg_252_1.time_ <= var_255_12 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				local var_255_14 = arg_252_1:FormatText(StoryNameCfg[380].name)

				arg_252_1.leftNameTxt_.text = var_255_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_15 = arg_252_1:GetWordFromCfg(122031059)
				local var_255_16 = arg_252_1:FormatText(var_255_15.content)

				arg_252_1.text_.text = var_255_16

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_17 = 21
				local var_255_18 = utf8.len(var_255_16)
				local var_255_19 = var_255_17 <= 0 and var_255_13 or var_255_13 * (var_255_18 / var_255_17)

				if var_255_19 > 0 and var_255_13 < var_255_19 then
					arg_252_1.talkMaxDuration = var_255_19

					if var_255_19 + var_255_12 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_19 + var_255_12
					end
				end

				arg_252_1.text_.text = var_255_16
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031059", "story_v_out_122031.awb") ~= 0 then
					local var_255_20 = manager.audio:GetVoiceLength("story_v_out_122031", "122031059", "story_v_out_122031.awb") / 1000

					if var_255_20 + var_255_12 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_20 + var_255_12
					end

					if var_255_15.prefab_name ~= "" and arg_252_1.actors_[var_255_15.prefab_name] ~= nil then
						local var_255_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_15.prefab_name].transform, "story_v_out_122031", "122031059", "story_v_out_122031.awb")

						arg_252_1:RecordAudio("122031059", var_255_21)
						arg_252_1:RecordAudio("122031059", var_255_21)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_122031", "122031059", "story_v_out_122031.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_122031", "122031059", "story_v_out_122031.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_22 = math.max(var_255_13, arg_252_1.talkMaxDuration)

			if var_255_12 <= arg_252_1.time_ and arg_252_1.time_ < var_255_12 + var_255_22 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_12) / var_255_22

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_12 + var_255_22 and arg_252_1.time_ < var_255_12 + var_255_22 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play122031060 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 122031060
		arg_256_1.duration_ = 4.4

		local var_256_0 = {
			ja = 4.4,
			ko = 2.233,
			zh = 2.233
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play122031061(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = arg_256_1.actors_["1074ui_story"]
			local var_259_1 = 0

			if var_259_1 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1074ui_story == nil then
				arg_256_1.var_.characterEffect1074ui_story = var_259_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_2 and not isNil(var_259_0) then
				local var_259_3 = (arg_256_1.time_ - var_259_1) / var_259_2

				if arg_256_1.var_.characterEffect1074ui_story and not isNil(var_259_0) then
					arg_256_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= var_259_1 + var_259_2 and arg_256_1.time_ < var_259_1 + var_259_2 + arg_259_0 and not isNil(var_259_0) and arg_256_1.var_.characterEffect1074ui_story then
				arg_256_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_259_4 = arg_256_1.actors_["10044ui_story"]
			local var_259_5 = 0

			if var_259_5 < arg_256_1.time_ and arg_256_1.time_ <= var_259_5 + arg_259_0 and not isNil(var_259_4) and arg_256_1.var_.characterEffect10044ui_story == nil then
				arg_256_1.var_.characterEffect10044ui_story = var_259_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_6 = 0.200000002980232

			if var_259_5 <= arg_256_1.time_ and arg_256_1.time_ < var_259_5 + var_259_6 and not isNil(var_259_4) then
				local var_259_7 = (arg_256_1.time_ - var_259_5) / var_259_6

				if arg_256_1.var_.characterEffect10044ui_story and not isNil(var_259_4) then
					local var_259_8 = Mathf.Lerp(0, 0.5, var_259_7)

					arg_256_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_256_1.var_.characterEffect10044ui_story.fillRatio = var_259_8
				end
			end

			if arg_256_1.time_ >= var_259_5 + var_259_6 and arg_256_1.time_ < var_259_5 + var_259_6 + arg_259_0 and not isNil(var_259_4) and arg_256_1.var_.characterEffect10044ui_story then
				local var_259_9 = 0.5

				arg_256_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_256_1.var_.characterEffect10044ui_story.fillRatio = var_259_9
			end

			local var_259_10 = 0
			local var_259_11 = 0.1

			if var_259_10 < arg_256_1.time_ and arg_256_1.time_ <= var_259_10 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				local var_259_12 = arg_256_1:FormatText(StoryNameCfg[410].name)

				arg_256_1.leftNameTxt_.text = var_259_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_13 = arg_256_1:GetWordFromCfg(122031060)
				local var_259_14 = arg_256_1:FormatText(var_259_13.content)

				arg_256_1.text_.text = var_259_14

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_15 = 4
				local var_259_16 = utf8.len(var_259_14)
				local var_259_17 = var_259_15 <= 0 and var_259_11 or var_259_11 * (var_259_16 / var_259_15)

				if var_259_17 > 0 and var_259_11 < var_259_17 then
					arg_256_1.talkMaxDuration = var_259_17

					if var_259_17 + var_259_10 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_17 + var_259_10
					end
				end

				arg_256_1.text_.text = var_259_14
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031060", "story_v_out_122031.awb") ~= 0 then
					local var_259_18 = manager.audio:GetVoiceLength("story_v_out_122031", "122031060", "story_v_out_122031.awb") / 1000

					if var_259_18 + var_259_10 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_18 + var_259_10
					end

					if var_259_13.prefab_name ~= "" and arg_256_1.actors_[var_259_13.prefab_name] ~= nil then
						local var_259_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_13.prefab_name].transform, "story_v_out_122031", "122031060", "story_v_out_122031.awb")

						arg_256_1:RecordAudio("122031060", var_259_19)
						arg_256_1:RecordAudio("122031060", var_259_19)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_122031", "122031060", "story_v_out_122031.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_122031", "122031060", "story_v_out_122031.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_20 = math.max(var_259_11, arg_256_1.talkMaxDuration)

			if var_259_10 <= arg_256_1.time_ and arg_256_1.time_ < var_259_10 + var_259_20 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_10) / var_259_20

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_10 + var_259_20 and arg_256_1.time_ < var_259_10 + var_259_20 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play122031061 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 122031061
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play122031062(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = arg_260_1.actors_["1074ui_story"].transform
			local var_263_1 = 0

			if var_263_1 < arg_260_1.time_ and arg_260_1.time_ <= var_263_1 + arg_263_0 then
				arg_260_1.var_.moveOldPos1074ui_story = var_263_0.localPosition
			end

			local var_263_2 = 0.001

			if var_263_1 <= arg_260_1.time_ and arg_260_1.time_ < var_263_1 + var_263_2 then
				local var_263_3 = (arg_260_1.time_ - var_263_1) / var_263_2
				local var_263_4 = Vector3.New(0, 100, 0)

				var_263_0.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1074ui_story, var_263_4, var_263_3)

				local var_263_5 = manager.ui.mainCamera.transform.position - var_263_0.position

				var_263_0.forward = Vector3.New(var_263_5.x, var_263_5.y, var_263_5.z)

				local var_263_6 = var_263_0.localEulerAngles

				var_263_6.z = 0
				var_263_6.x = 0
				var_263_0.localEulerAngles = var_263_6
			end

			if arg_260_1.time_ >= var_263_1 + var_263_2 and arg_260_1.time_ < var_263_1 + var_263_2 + arg_263_0 then
				var_263_0.localPosition = Vector3.New(0, 100, 0)

				local var_263_7 = manager.ui.mainCamera.transform.position - var_263_0.position

				var_263_0.forward = Vector3.New(var_263_7.x, var_263_7.y, var_263_7.z)

				local var_263_8 = var_263_0.localEulerAngles

				var_263_8.z = 0
				var_263_8.x = 0
				var_263_0.localEulerAngles = var_263_8
			end

			local var_263_9 = arg_260_1.actors_["1074ui_story"]
			local var_263_10 = 0

			if var_263_10 < arg_260_1.time_ and arg_260_1.time_ <= var_263_10 + arg_263_0 and not isNil(var_263_9) and arg_260_1.var_.characterEffect1074ui_story == nil then
				arg_260_1.var_.characterEffect1074ui_story = var_263_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_11 = 0.200000002980232

			if var_263_10 <= arg_260_1.time_ and arg_260_1.time_ < var_263_10 + var_263_11 and not isNil(var_263_9) then
				local var_263_12 = (arg_260_1.time_ - var_263_10) / var_263_11

				if arg_260_1.var_.characterEffect1074ui_story and not isNil(var_263_9) then
					local var_263_13 = Mathf.Lerp(0, 0.5, var_263_12)

					arg_260_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1074ui_story.fillRatio = var_263_13
				end
			end

			if arg_260_1.time_ >= var_263_10 + var_263_11 and arg_260_1.time_ < var_263_10 + var_263_11 + arg_263_0 and not isNil(var_263_9) and arg_260_1.var_.characterEffect1074ui_story then
				local var_263_14 = 0.5

				arg_260_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1074ui_story.fillRatio = var_263_14
			end

			local var_263_15 = arg_260_1.actors_["10044ui_story"].transform
			local var_263_16 = 0

			if var_263_16 < arg_260_1.time_ and arg_260_1.time_ <= var_263_16 + arg_263_0 then
				arg_260_1.var_.moveOldPos10044ui_story = var_263_15.localPosition
			end

			local var_263_17 = 0.001

			if var_263_16 <= arg_260_1.time_ and arg_260_1.time_ < var_263_16 + var_263_17 then
				local var_263_18 = (arg_260_1.time_ - var_263_16) / var_263_17
				local var_263_19 = Vector3.New(0, 100, 0)

				var_263_15.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos10044ui_story, var_263_19, var_263_18)

				local var_263_20 = manager.ui.mainCamera.transform.position - var_263_15.position

				var_263_15.forward = Vector3.New(var_263_20.x, var_263_20.y, var_263_20.z)

				local var_263_21 = var_263_15.localEulerAngles

				var_263_21.z = 0
				var_263_21.x = 0
				var_263_15.localEulerAngles = var_263_21
			end

			if arg_260_1.time_ >= var_263_16 + var_263_17 and arg_260_1.time_ < var_263_16 + var_263_17 + arg_263_0 then
				var_263_15.localPosition = Vector3.New(0, 100, 0)

				local var_263_22 = manager.ui.mainCamera.transform.position - var_263_15.position

				var_263_15.forward = Vector3.New(var_263_22.x, var_263_22.y, var_263_22.z)

				local var_263_23 = var_263_15.localEulerAngles

				var_263_23.z = 0
				var_263_23.x = 0
				var_263_15.localEulerAngles = var_263_23
			end

			local var_263_24 = arg_260_1.actors_["10044ui_story"]
			local var_263_25 = 0

			if var_263_25 < arg_260_1.time_ and arg_260_1.time_ <= var_263_25 + arg_263_0 and not isNil(var_263_24) and arg_260_1.var_.characterEffect10044ui_story == nil then
				arg_260_1.var_.characterEffect10044ui_story = var_263_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_26 = 0.200000002980232

			if var_263_25 <= arg_260_1.time_ and arg_260_1.time_ < var_263_25 + var_263_26 and not isNil(var_263_24) then
				local var_263_27 = (arg_260_1.time_ - var_263_25) / var_263_26

				if arg_260_1.var_.characterEffect10044ui_story and not isNil(var_263_24) then
					local var_263_28 = Mathf.Lerp(0, 0.5, var_263_27)

					arg_260_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_260_1.var_.characterEffect10044ui_story.fillRatio = var_263_28
				end
			end

			if arg_260_1.time_ >= var_263_25 + var_263_26 and arg_260_1.time_ < var_263_25 + var_263_26 + arg_263_0 and not isNil(var_263_24) and arg_260_1.var_.characterEffect10044ui_story then
				local var_263_29 = 0.5

				arg_260_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_260_1.var_.characterEffect10044ui_story.fillRatio = var_263_29
			end

			local var_263_30 = 0
			local var_263_31 = 1.1

			if var_263_30 < arg_260_1.time_ and arg_260_1.time_ <= var_263_30 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_32 = arg_260_1:GetWordFromCfg(122031061)
				local var_263_33 = arg_260_1:FormatText(var_263_32.content)

				arg_260_1.text_.text = var_263_33

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_34 = 44
				local var_263_35 = utf8.len(var_263_33)
				local var_263_36 = var_263_34 <= 0 and var_263_31 or var_263_31 * (var_263_35 / var_263_34)

				if var_263_36 > 0 and var_263_31 < var_263_36 then
					arg_260_1.talkMaxDuration = var_263_36

					if var_263_36 + var_263_30 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_36 + var_263_30
					end
				end

				arg_260_1.text_.text = var_263_33
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_37 = math.max(var_263_31, arg_260_1.talkMaxDuration)

			if var_263_30 <= arg_260_1.time_ and arg_260_1.time_ < var_263_30 + var_263_37 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_30) / var_263_37

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_30 + var_263_37 and arg_260_1.time_ < var_263_30 + var_263_37 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
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
	Play122031062 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 122031062
		arg_264_1.duration_ = 5

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play122031063(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0
			local var_267_1 = 0.85

			if var_267_0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, false)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_2 = arg_264_1:GetWordFromCfg(122031062)
				local var_267_3 = arg_264_1:FormatText(var_267_2.content)

				arg_264_1.text_.text = var_267_3

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_4 = 34
				local var_267_5 = utf8.len(var_267_3)
				local var_267_6 = var_267_4 <= 0 and var_267_1 or var_267_1 * (var_267_5 / var_267_4)

				if var_267_6 > 0 and var_267_1 < var_267_6 then
					arg_264_1.talkMaxDuration = var_267_6

					if var_267_6 + var_267_0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_6 + var_267_0
					end
				end

				arg_264_1.text_.text = var_267_3
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)
				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_7 = math.max(var_267_1, arg_264_1.talkMaxDuration)

			if var_267_0 <= arg_264_1.time_ and arg_264_1.time_ < var_267_0 + var_267_7 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_0) / var_267_7

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_0 + var_267_7 and arg_264_1.time_ < var_267_0 + var_267_7 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play122031063 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 122031063
		arg_268_1.duration_ = 4.7

		local var_268_0 = {
			ja = 4.7,
			ko = 3.333,
			zh = 3.333
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play122031064(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			local var_271_0 = arg_268_1.actors_["10044ui_story"].transform
			local var_271_1 = 0

			if var_271_1 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.var_.moveOldPos10044ui_story = var_271_0.localPosition
			end

			local var_271_2 = 0.001

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_2 then
				local var_271_3 = (arg_268_1.time_ - var_271_1) / var_271_2
				local var_271_4 = Vector3.New(-0.7, -0.72, -6.3)

				var_271_0.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos10044ui_story, var_271_4, var_271_3)

				local var_271_5 = manager.ui.mainCamera.transform.position - var_271_0.position

				var_271_0.forward = Vector3.New(var_271_5.x, var_271_5.y, var_271_5.z)

				local var_271_6 = var_271_0.localEulerAngles

				var_271_6.z = 0
				var_271_6.x = 0
				var_271_0.localEulerAngles = var_271_6
			end

			if arg_268_1.time_ >= var_271_1 + var_271_2 and arg_268_1.time_ < var_271_1 + var_271_2 + arg_271_0 then
				var_271_0.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_271_7 = manager.ui.mainCamera.transform.position - var_271_0.position

				var_271_0.forward = Vector3.New(var_271_7.x, var_271_7.y, var_271_7.z)

				local var_271_8 = var_271_0.localEulerAngles

				var_271_8.z = 0
				var_271_8.x = 0
				var_271_0.localEulerAngles = var_271_8
			end

			local var_271_9 = arg_268_1.actors_["10044ui_story"]
			local var_271_10 = 0

			if var_271_10 < arg_268_1.time_ and arg_268_1.time_ <= var_271_10 + arg_271_0 and not isNil(var_271_9) and arg_268_1.var_.characterEffect10044ui_story == nil then
				arg_268_1.var_.characterEffect10044ui_story = var_271_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_11 = 0.200000002980232

			if var_271_10 <= arg_268_1.time_ and arg_268_1.time_ < var_271_10 + var_271_11 and not isNil(var_271_9) then
				local var_271_12 = (arg_268_1.time_ - var_271_10) / var_271_11

				if arg_268_1.var_.characterEffect10044ui_story and not isNil(var_271_9) then
					arg_268_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= var_271_10 + var_271_11 and arg_268_1.time_ < var_271_10 + var_271_11 + arg_271_0 and not isNil(var_271_9) and arg_268_1.var_.characterEffect10044ui_story then
				arg_268_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_271_13 = 0

			if var_271_13 < arg_268_1.time_ and arg_268_1.time_ <= var_271_13 + arg_271_0 then
				arg_268_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action443")
			end

			local var_271_14 = 0

			if var_271_14 < arg_268_1.time_ and arg_268_1.time_ <= var_271_14 + arg_271_0 then
				arg_268_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_271_15 = arg_268_1.actors_["1074ui_story"].transform
			local var_271_16 = 0

			if var_271_16 < arg_268_1.time_ and arg_268_1.time_ <= var_271_16 + arg_271_0 then
				arg_268_1.var_.moveOldPos1074ui_story = var_271_15.localPosition
			end

			local var_271_17 = 0.001

			if var_271_16 <= arg_268_1.time_ and arg_268_1.time_ < var_271_16 + var_271_17 then
				local var_271_18 = (arg_268_1.time_ - var_271_16) / var_271_17
				local var_271_19 = Vector3.New(0.7, -1.055, -6.12)

				var_271_15.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1074ui_story, var_271_19, var_271_18)

				local var_271_20 = manager.ui.mainCamera.transform.position - var_271_15.position

				var_271_15.forward = Vector3.New(var_271_20.x, var_271_20.y, var_271_20.z)

				local var_271_21 = var_271_15.localEulerAngles

				var_271_21.z = 0
				var_271_21.x = 0
				var_271_15.localEulerAngles = var_271_21
			end

			if arg_268_1.time_ >= var_271_16 + var_271_17 and arg_268_1.time_ < var_271_16 + var_271_17 + arg_271_0 then
				var_271_15.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_271_22 = manager.ui.mainCamera.transform.position - var_271_15.position

				var_271_15.forward = Vector3.New(var_271_22.x, var_271_22.y, var_271_22.z)

				local var_271_23 = var_271_15.localEulerAngles

				var_271_23.z = 0
				var_271_23.x = 0
				var_271_15.localEulerAngles = var_271_23
			end

			local var_271_24 = arg_268_1.actors_["1074ui_story"]
			local var_271_25 = 0

			if var_271_25 < arg_268_1.time_ and arg_268_1.time_ <= var_271_25 + arg_271_0 and not isNil(var_271_24) and arg_268_1.var_.characterEffect1074ui_story == nil then
				arg_268_1.var_.characterEffect1074ui_story = var_271_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_26 = 0.200000002980232

			if var_271_25 <= arg_268_1.time_ and arg_268_1.time_ < var_271_25 + var_271_26 and not isNil(var_271_24) then
				local var_271_27 = (arg_268_1.time_ - var_271_25) / var_271_26

				if arg_268_1.var_.characterEffect1074ui_story and not isNil(var_271_24) then
					local var_271_28 = Mathf.Lerp(0, 0.5, var_271_27)

					arg_268_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_268_1.var_.characterEffect1074ui_story.fillRatio = var_271_28
				end
			end

			if arg_268_1.time_ >= var_271_25 + var_271_26 and arg_268_1.time_ < var_271_25 + var_271_26 + arg_271_0 and not isNil(var_271_24) and arg_268_1.var_.characterEffect1074ui_story then
				local var_271_29 = 0.5

				arg_268_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_268_1.var_.characterEffect1074ui_story.fillRatio = var_271_29
			end

			local var_271_30 = 0
			local var_271_31 = 0.275

			if var_271_30 < arg_268_1.time_ and arg_268_1.time_ <= var_271_30 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				local var_271_32 = arg_268_1:FormatText(StoryNameCfg[380].name)

				arg_268_1.leftNameTxt_.text = var_271_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_33 = arg_268_1:GetWordFromCfg(122031063)
				local var_271_34 = arg_268_1:FormatText(var_271_33.content)

				arg_268_1.text_.text = var_271_34

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_35 = 11
				local var_271_36 = utf8.len(var_271_34)
				local var_271_37 = var_271_35 <= 0 and var_271_31 or var_271_31 * (var_271_36 / var_271_35)

				if var_271_37 > 0 and var_271_31 < var_271_37 then
					arg_268_1.talkMaxDuration = var_271_37

					if var_271_37 + var_271_30 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_37 + var_271_30
					end
				end

				arg_268_1.text_.text = var_271_34
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031063", "story_v_out_122031.awb") ~= 0 then
					local var_271_38 = manager.audio:GetVoiceLength("story_v_out_122031", "122031063", "story_v_out_122031.awb") / 1000

					if var_271_38 + var_271_30 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_38 + var_271_30
					end

					if var_271_33.prefab_name ~= "" and arg_268_1.actors_[var_271_33.prefab_name] ~= nil then
						local var_271_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_33.prefab_name].transform, "story_v_out_122031", "122031063", "story_v_out_122031.awb")

						arg_268_1:RecordAudio("122031063", var_271_39)
						arg_268_1:RecordAudio("122031063", var_271_39)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_122031", "122031063", "story_v_out_122031.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_122031", "122031063", "story_v_out_122031.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_40 = math.max(var_271_31, arg_268_1.talkMaxDuration)

			if var_271_30 <= arg_268_1.time_ and arg_268_1.time_ < var_271_30 + var_271_40 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_30) / var_271_40

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_30 + var_271_40 and arg_268_1.time_ < var_271_30 + var_271_40 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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

		arg_268_1:InitPlayNodeList()
	end,
	Play122031064 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 122031064
		arg_272_1.duration_ = 12

		local var_272_0 = {
			ja = 12,
			ko = 9.266,
			zh = 9.266
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play122031065(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0
			local var_275_1 = 1.225

			if var_275_0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				local var_275_2 = arg_272_1:FormatText(StoryNameCfg[380].name)

				arg_272_1.leftNameTxt_.text = var_275_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_3 = arg_272_1:GetWordFromCfg(122031064)
				local var_275_4 = arg_272_1:FormatText(var_275_3.content)

				arg_272_1.text_.text = var_275_4

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_5 = 49
				local var_275_6 = utf8.len(var_275_4)
				local var_275_7 = var_275_5 <= 0 and var_275_1 or var_275_1 * (var_275_6 / var_275_5)

				if var_275_7 > 0 and var_275_1 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_0
					end
				end

				arg_272_1.text_.text = var_275_4
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031064", "story_v_out_122031.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_out_122031", "122031064", "story_v_out_122031.awb") / 1000

					if var_275_8 + var_275_0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_0
					end

					if var_275_3.prefab_name ~= "" and arg_272_1.actors_[var_275_3.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_3.prefab_name].transform, "story_v_out_122031", "122031064", "story_v_out_122031.awb")

						arg_272_1:RecordAudio("122031064", var_275_9)
						arg_272_1:RecordAudio("122031064", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_122031", "122031064", "story_v_out_122031.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_122031", "122031064", "story_v_out_122031.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_1, arg_272_1.talkMaxDuration)

			if var_275_0 <= arg_272_1.time_ and arg_272_1.time_ < var_275_0 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_0) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_0 + var_275_10 and arg_272_1.time_ < var_275_0 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play122031065 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 122031065
		arg_276_1.duration_ = 7.53

		local var_276_0 = {
			ja = 7.533,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play122031066(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = arg_276_1.actors_["1074ui_story"]
			local var_279_1 = 0

			if var_279_1 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect1074ui_story == nil then
				arg_276_1.var_.characterEffect1074ui_story = var_279_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_2 = 0.200000002980232

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_2 and not isNil(var_279_0) then
				local var_279_3 = (arg_276_1.time_ - var_279_1) / var_279_2

				if arg_276_1.var_.characterEffect1074ui_story and not isNil(var_279_0) then
					arg_276_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= var_279_1 + var_279_2 and arg_276_1.time_ < var_279_1 + var_279_2 + arg_279_0 and not isNil(var_279_0) and arg_276_1.var_.characterEffect1074ui_story then
				arg_276_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_279_4 = 0

			if var_279_4 < arg_276_1.time_ and arg_276_1.time_ <= var_279_4 + arg_279_0 then
				arg_276_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_279_5 = arg_276_1.actors_["10044ui_story"]
			local var_279_6 = 0

			if var_279_6 < arg_276_1.time_ and arg_276_1.time_ <= var_279_6 + arg_279_0 and not isNil(var_279_5) and arg_276_1.var_.characterEffect10044ui_story == nil then
				arg_276_1.var_.characterEffect10044ui_story = var_279_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_7 = 0.200000002980232

			if var_279_6 <= arg_276_1.time_ and arg_276_1.time_ < var_279_6 + var_279_7 and not isNil(var_279_5) then
				local var_279_8 = (arg_276_1.time_ - var_279_6) / var_279_7

				if arg_276_1.var_.characterEffect10044ui_story and not isNil(var_279_5) then
					local var_279_9 = Mathf.Lerp(0, 0.5, var_279_8)

					arg_276_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_276_1.var_.characterEffect10044ui_story.fillRatio = var_279_9
				end
			end

			if arg_276_1.time_ >= var_279_6 + var_279_7 and arg_276_1.time_ < var_279_6 + var_279_7 + arg_279_0 and not isNil(var_279_5) and arg_276_1.var_.characterEffect10044ui_story then
				local var_279_10 = 0.5

				arg_276_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_276_1.var_.characterEffect10044ui_story.fillRatio = var_279_10
			end

			local var_279_11 = 0
			local var_279_12 = 0.125

			if var_279_11 < arg_276_1.time_ and arg_276_1.time_ <= var_279_11 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				local var_279_13 = arg_276_1:FormatText(StoryNameCfg[410].name)

				arg_276_1.leftNameTxt_.text = var_279_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_14 = arg_276_1:GetWordFromCfg(122031065)
				local var_279_15 = arg_276_1:FormatText(var_279_14.content)

				arg_276_1.text_.text = var_279_15

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_16 = 5
				local var_279_17 = utf8.len(var_279_15)
				local var_279_18 = var_279_16 <= 0 and var_279_12 or var_279_12 * (var_279_17 / var_279_16)

				if var_279_18 > 0 and var_279_12 < var_279_18 then
					arg_276_1.talkMaxDuration = var_279_18

					if var_279_18 + var_279_11 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_18 + var_279_11
					end
				end

				arg_276_1.text_.text = var_279_15
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031065", "story_v_out_122031.awb") ~= 0 then
					local var_279_19 = manager.audio:GetVoiceLength("story_v_out_122031", "122031065", "story_v_out_122031.awb") / 1000

					if var_279_19 + var_279_11 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_19 + var_279_11
					end

					if var_279_14.prefab_name ~= "" and arg_276_1.actors_[var_279_14.prefab_name] ~= nil then
						local var_279_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_14.prefab_name].transform, "story_v_out_122031", "122031065", "story_v_out_122031.awb")

						arg_276_1:RecordAudio("122031065", var_279_20)
						arg_276_1:RecordAudio("122031065", var_279_20)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_122031", "122031065", "story_v_out_122031.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_122031", "122031065", "story_v_out_122031.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_21 = math.max(var_279_12, arg_276_1.talkMaxDuration)

			if var_279_11 <= arg_276_1.time_ and arg_276_1.time_ < var_279_11 + var_279_21 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_11) / var_279_21

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_11 + var_279_21 and arg_276_1.time_ < var_279_11 + var_279_21 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play122031066 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 122031066
		arg_280_1.duration_ = 2

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play122031067(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			local var_283_0 = arg_280_1.actors_["10044ui_story"]
			local var_283_1 = 0

			if var_283_1 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect10044ui_story == nil then
				arg_280_1.var_.characterEffect10044ui_story = var_283_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_2 = 0.200000002980232

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_2 and not isNil(var_283_0) then
				local var_283_3 = (arg_280_1.time_ - var_283_1) / var_283_2

				if arg_280_1.var_.characterEffect10044ui_story and not isNil(var_283_0) then
					arg_280_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= var_283_1 + var_283_2 and arg_280_1.time_ < var_283_1 + var_283_2 + arg_283_0 and not isNil(var_283_0) and arg_280_1.var_.characterEffect10044ui_story then
				arg_280_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_283_4 = 0

			if var_283_4 < arg_280_1.time_ and arg_280_1.time_ <= var_283_4 + arg_283_0 then
				arg_280_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_2")
			end

			local var_283_5 = 0

			if var_283_5 < arg_280_1.time_ and arg_280_1.time_ <= var_283_5 + arg_283_0 then
				arg_280_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_283_6 = arg_280_1.actors_["1074ui_story"]
			local var_283_7 = 0

			if var_283_7 < arg_280_1.time_ and arg_280_1.time_ <= var_283_7 + arg_283_0 and not isNil(var_283_6) and arg_280_1.var_.characterEffect1074ui_story == nil then
				arg_280_1.var_.characterEffect1074ui_story = var_283_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_8 = 0.200000002980232

			if var_283_7 <= arg_280_1.time_ and arg_280_1.time_ < var_283_7 + var_283_8 and not isNil(var_283_6) then
				local var_283_9 = (arg_280_1.time_ - var_283_7) / var_283_8

				if arg_280_1.var_.characterEffect1074ui_story and not isNil(var_283_6) then
					local var_283_10 = Mathf.Lerp(0, 0.5, var_283_9)

					arg_280_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1074ui_story.fillRatio = var_283_10
				end
			end

			if arg_280_1.time_ >= var_283_7 + var_283_8 and arg_280_1.time_ < var_283_7 + var_283_8 + arg_283_0 and not isNil(var_283_6) and arg_280_1.var_.characterEffect1074ui_story then
				local var_283_11 = 0.5

				arg_280_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1074ui_story.fillRatio = var_283_11
			end

			local var_283_12 = 0
			local var_283_13 = 0.1

			if var_283_12 < arg_280_1.time_ and arg_280_1.time_ <= var_283_12 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				local var_283_14 = arg_280_1:FormatText(StoryNameCfg[380].name)

				arg_280_1.leftNameTxt_.text = var_283_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_15 = arg_280_1:GetWordFromCfg(122031066)
				local var_283_16 = arg_280_1:FormatText(var_283_15.content)

				arg_280_1.text_.text = var_283_16

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_17 = 4
				local var_283_18 = utf8.len(var_283_16)
				local var_283_19 = var_283_17 <= 0 and var_283_13 or var_283_13 * (var_283_18 / var_283_17)

				if var_283_19 > 0 and var_283_13 < var_283_19 then
					arg_280_1.talkMaxDuration = var_283_19

					if var_283_19 + var_283_12 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_19 + var_283_12
					end
				end

				arg_280_1.text_.text = var_283_16
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031066", "story_v_out_122031.awb") ~= 0 then
					local var_283_20 = manager.audio:GetVoiceLength("story_v_out_122031", "122031066", "story_v_out_122031.awb") / 1000

					if var_283_20 + var_283_12 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_20 + var_283_12
					end

					if var_283_15.prefab_name ~= "" and arg_280_1.actors_[var_283_15.prefab_name] ~= nil then
						local var_283_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_15.prefab_name].transform, "story_v_out_122031", "122031066", "story_v_out_122031.awb")

						arg_280_1:RecordAudio("122031066", var_283_21)
						arg_280_1:RecordAudio("122031066", var_283_21)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_122031", "122031066", "story_v_out_122031.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_122031", "122031066", "story_v_out_122031.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_22 = math.max(var_283_13, arg_280_1.talkMaxDuration)

			if var_283_12 <= arg_280_1.time_ and arg_280_1.time_ < var_283_12 + var_283_22 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_12) / var_283_22

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_12 + var_283_22 and arg_280_1.time_ < var_283_12 + var_283_22 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play122031067 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 122031067
		arg_284_1.duration_ = 10.7

		local var_284_0 = {
			ja = 10.7,
			ko = 8.133,
			zh = 8.133
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play122031068(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = arg_284_1.actors_["1074ui_story"]
			local var_287_1 = 0

			if var_287_1 < arg_284_1.time_ and arg_284_1.time_ <= var_287_1 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1074ui_story == nil then
				arg_284_1.var_.characterEffect1074ui_story = var_287_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if var_287_1 <= arg_284_1.time_ and arg_284_1.time_ < var_287_1 + var_287_2 and not isNil(var_287_0) then
				local var_287_3 = (arg_284_1.time_ - var_287_1) / var_287_2

				if arg_284_1.var_.characterEffect1074ui_story and not isNil(var_287_0) then
					arg_284_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= var_287_1 + var_287_2 and arg_284_1.time_ < var_287_1 + var_287_2 + arg_287_0 and not isNil(var_287_0) and arg_284_1.var_.characterEffect1074ui_story then
				arg_284_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_287_4 = 0

			if var_287_4 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			local var_287_5 = 0

			if var_287_5 < arg_284_1.time_ and arg_284_1.time_ <= var_287_5 + arg_287_0 then
				arg_284_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_287_6 = arg_284_1.actors_["10044ui_story"]
			local var_287_7 = 0

			if var_287_7 < arg_284_1.time_ and arg_284_1.time_ <= var_287_7 + arg_287_0 and not isNil(var_287_6) and arg_284_1.var_.characterEffect10044ui_story == nil then
				arg_284_1.var_.characterEffect10044ui_story = var_287_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_8 = 0.200000002980232

			if var_287_7 <= arg_284_1.time_ and arg_284_1.time_ < var_287_7 + var_287_8 and not isNil(var_287_6) then
				local var_287_9 = (arg_284_1.time_ - var_287_7) / var_287_8

				if arg_284_1.var_.characterEffect10044ui_story and not isNil(var_287_6) then
					local var_287_10 = Mathf.Lerp(0, 0.5, var_287_9)

					arg_284_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_284_1.var_.characterEffect10044ui_story.fillRatio = var_287_10
				end
			end

			if arg_284_1.time_ >= var_287_7 + var_287_8 and arg_284_1.time_ < var_287_7 + var_287_8 + arg_287_0 and not isNil(var_287_6) and arg_284_1.var_.characterEffect10044ui_story then
				local var_287_11 = 0.5

				arg_284_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_284_1.var_.characterEffect10044ui_story.fillRatio = var_287_11
			end

			local var_287_12 = 0
			local var_287_13 = 0.875

			if var_287_12 < arg_284_1.time_ and arg_284_1.time_ <= var_287_12 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				local var_287_14 = arg_284_1:FormatText(StoryNameCfg[410].name)

				arg_284_1.leftNameTxt_.text = var_287_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_15 = arg_284_1:GetWordFromCfg(122031067)
				local var_287_16 = arg_284_1:FormatText(var_287_15.content)

				arg_284_1.text_.text = var_287_16

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_17 = 35
				local var_287_18 = utf8.len(var_287_16)
				local var_287_19 = var_287_17 <= 0 and var_287_13 or var_287_13 * (var_287_18 / var_287_17)

				if var_287_19 > 0 and var_287_13 < var_287_19 then
					arg_284_1.talkMaxDuration = var_287_19

					if var_287_19 + var_287_12 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_19 + var_287_12
					end
				end

				arg_284_1.text_.text = var_287_16
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031067", "story_v_out_122031.awb") ~= 0 then
					local var_287_20 = manager.audio:GetVoiceLength("story_v_out_122031", "122031067", "story_v_out_122031.awb") / 1000

					if var_287_20 + var_287_12 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_20 + var_287_12
					end

					if var_287_15.prefab_name ~= "" and arg_284_1.actors_[var_287_15.prefab_name] ~= nil then
						local var_287_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_15.prefab_name].transform, "story_v_out_122031", "122031067", "story_v_out_122031.awb")

						arg_284_1:RecordAudio("122031067", var_287_21)
						arg_284_1:RecordAudio("122031067", var_287_21)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_122031", "122031067", "story_v_out_122031.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_122031", "122031067", "story_v_out_122031.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_22 = math.max(var_287_13, arg_284_1.talkMaxDuration)

			if var_287_12 <= arg_284_1.time_ and arg_284_1.time_ < var_287_12 + var_287_22 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_12) / var_287_22

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_12 + var_287_22 and arg_284_1.time_ < var_287_12 + var_287_22 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play122031068 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 122031068
		arg_288_1.duration_ = 12.37

		local var_288_0 = {
			ja = 12.366,
			ko = 5.433,
			zh = 5.433
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play122031069(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = arg_288_1.actors_["10044ui_story"]
			local var_291_1 = 0

			if var_291_1 < arg_288_1.time_ and arg_288_1.time_ <= var_291_1 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect10044ui_story == nil then
				arg_288_1.var_.characterEffect10044ui_story = var_291_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_2 = 0.200000002980232

			if var_291_1 <= arg_288_1.time_ and arg_288_1.time_ < var_291_1 + var_291_2 and not isNil(var_291_0) then
				local var_291_3 = (arg_288_1.time_ - var_291_1) / var_291_2

				if arg_288_1.var_.characterEffect10044ui_story and not isNil(var_291_0) then
					arg_288_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= var_291_1 + var_291_2 and arg_288_1.time_ < var_291_1 + var_291_2 + arg_291_0 and not isNil(var_291_0) and arg_288_1.var_.characterEffect10044ui_story then
				arg_288_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_291_4 = 0

			if var_291_4 < arg_288_1.time_ and arg_288_1.time_ <= var_291_4 + arg_291_0 then
				arg_288_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action2_1")
			end

			local var_291_5 = 0

			if var_291_5 < arg_288_1.time_ and arg_288_1.time_ <= var_291_5 + arg_291_0 then
				arg_288_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_291_6 = arg_288_1.actors_["1074ui_story"]
			local var_291_7 = 0

			if var_291_7 < arg_288_1.time_ and arg_288_1.time_ <= var_291_7 + arg_291_0 and not isNil(var_291_6) and arg_288_1.var_.characterEffect1074ui_story == nil then
				arg_288_1.var_.characterEffect1074ui_story = var_291_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_8 = 0.200000002980232

			if var_291_7 <= arg_288_1.time_ and arg_288_1.time_ < var_291_7 + var_291_8 and not isNil(var_291_6) then
				local var_291_9 = (arg_288_1.time_ - var_291_7) / var_291_8

				if arg_288_1.var_.characterEffect1074ui_story and not isNil(var_291_6) then
					local var_291_10 = Mathf.Lerp(0, 0.5, var_291_9)

					arg_288_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_288_1.var_.characterEffect1074ui_story.fillRatio = var_291_10
				end
			end

			if arg_288_1.time_ >= var_291_7 + var_291_8 and arg_288_1.time_ < var_291_7 + var_291_8 + arg_291_0 and not isNil(var_291_6) and arg_288_1.var_.characterEffect1074ui_story then
				local var_291_11 = 0.5

				arg_288_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_288_1.var_.characterEffect1074ui_story.fillRatio = var_291_11
			end

			local var_291_12 = 0
			local var_291_13 = 0.55

			if var_291_12 < arg_288_1.time_ and arg_288_1.time_ <= var_291_12 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				local var_291_14 = arg_288_1:FormatText(StoryNameCfg[380].name)

				arg_288_1.leftNameTxt_.text = var_291_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_15 = arg_288_1:GetWordFromCfg(122031068)
				local var_291_16 = arg_288_1:FormatText(var_291_15.content)

				arg_288_1.text_.text = var_291_16

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_17 = 22
				local var_291_18 = utf8.len(var_291_16)
				local var_291_19 = var_291_17 <= 0 and var_291_13 or var_291_13 * (var_291_18 / var_291_17)

				if var_291_19 > 0 and var_291_13 < var_291_19 then
					arg_288_1.talkMaxDuration = var_291_19

					if var_291_19 + var_291_12 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_19 + var_291_12
					end
				end

				arg_288_1.text_.text = var_291_16
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031068", "story_v_out_122031.awb") ~= 0 then
					local var_291_20 = manager.audio:GetVoiceLength("story_v_out_122031", "122031068", "story_v_out_122031.awb") / 1000

					if var_291_20 + var_291_12 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_20 + var_291_12
					end

					if var_291_15.prefab_name ~= "" and arg_288_1.actors_[var_291_15.prefab_name] ~= nil then
						local var_291_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_15.prefab_name].transform, "story_v_out_122031", "122031068", "story_v_out_122031.awb")

						arg_288_1:RecordAudio("122031068", var_291_21)
						arg_288_1:RecordAudio("122031068", var_291_21)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_122031", "122031068", "story_v_out_122031.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_122031", "122031068", "story_v_out_122031.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_22 = math.max(var_291_13, arg_288_1.talkMaxDuration)

			if var_291_12 <= arg_288_1.time_ and arg_288_1.time_ < var_291_12 + var_291_22 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_12) / var_291_22

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_12 + var_291_22 and arg_288_1.time_ < var_291_12 + var_291_22 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play122031069 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 122031069
		arg_292_1.duration_ = 5

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play122031070(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			local var_295_0 = arg_292_1.actors_["10044ui_story"].transform
			local var_295_1 = 0

			if var_295_1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_1 + arg_295_0 then
				arg_292_1.var_.moveOldPos10044ui_story = var_295_0.localPosition
			end

			local var_295_2 = 0.001

			if var_295_1 <= arg_292_1.time_ and arg_292_1.time_ < var_295_1 + var_295_2 then
				local var_295_3 = (arg_292_1.time_ - var_295_1) / var_295_2
				local var_295_4 = Vector3.New(0, 100, 0)

				var_295_0.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos10044ui_story, var_295_4, var_295_3)

				local var_295_5 = manager.ui.mainCamera.transform.position - var_295_0.position

				var_295_0.forward = Vector3.New(var_295_5.x, var_295_5.y, var_295_5.z)

				local var_295_6 = var_295_0.localEulerAngles

				var_295_6.z = 0
				var_295_6.x = 0
				var_295_0.localEulerAngles = var_295_6
			end

			if arg_292_1.time_ >= var_295_1 + var_295_2 and arg_292_1.time_ < var_295_1 + var_295_2 + arg_295_0 then
				var_295_0.localPosition = Vector3.New(0, 100, 0)

				local var_295_7 = manager.ui.mainCamera.transform.position - var_295_0.position

				var_295_0.forward = Vector3.New(var_295_7.x, var_295_7.y, var_295_7.z)

				local var_295_8 = var_295_0.localEulerAngles

				var_295_8.z = 0
				var_295_8.x = 0
				var_295_0.localEulerAngles = var_295_8
			end

			local var_295_9 = arg_292_1.actors_["10044ui_story"]
			local var_295_10 = 0

			if var_295_10 < arg_292_1.time_ and arg_292_1.time_ <= var_295_10 + arg_295_0 and not isNil(var_295_9) and arg_292_1.var_.characterEffect10044ui_story == nil then
				arg_292_1.var_.characterEffect10044ui_story = var_295_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_11 = 0.200000002980232

			if var_295_10 <= arg_292_1.time_ and arg_292_1.time_ < var_295_10 + var_295_11 and not isNil(var_295_9) then
				local var_295_12 = (arg_292_1.time_ - var_295_10) / var_295_11

				if arg_292_1.var_.characterEffect10044ui_story and not isNil(var_295_9) then
					local var_295_13 = Mathf.Lerp(0, 0.5, var_295_12)

					arg_292_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_292_1.var_.characterEffect10044ui_story.fillRatio = var_295_13
				end
			end

			if arg_292_1.time_ >= var_295_10 + var_295_11 and arg_292_1.time_ < var_295_10 + var_295_11 + arg_295_0 and not isNil(var_295_9) and arg_292_1.var_.characterEffect10044ui_story then
				local var_295_14 = 0.5

				arg_292_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_292_1.var_.characterEffect10044ui_story.fillRatio = var_295_14
			end

			local var_295_15 = arg_292_1.actors_["1074ui_story"].transform
			local var_295_16 = 0

			if var_295_16 < arg_292_1.time_ and arg_292_1.time_ <= var_295_16 + arg_295_0 then
				arg_292_1.var_.moveOldPos1074ui_story = var_295_15.localPosition
			end

			local var_295_17 = 0.001

			if var_295_16 <= arg_292_1.time_ and arg_292_1.time_ < var_295_16 + var_295_17 then
				local var_295_18 = (arg_292_1.time_ - var_295_16) / var_295_17
				local var_295_19 = Vector3.New(0, 100, 0)

				var_295_15.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1074ui_story, var_295_19, var_295_18)

				local var_295_20 = manager.ui.mainCamera.transform.position - var_295_15.position

				var_295_15.forward = Vector3.New(var_295_20.x, var_295_20.y, var_295_20.z)

				local var_295_21 = var_295_15.localEulerAngles

				var_295_21.z = 0
				var_295_21.x = 0
				var_295_15.localEulerAngles = var_295_21
			end

			if arg_292_1.time_ >= var_295_16 + var_295_17 and arg_292_1.time_ < var_295_16 + var_295_17 + arg_295_0 then
				var_295_15.localPosition = Vector3.New(0, 100, 0)

				local var_295_22 = manager.ui.mainCamera.transform.position - var_295_15.position

				var_295_15.forward = Vector3.New(var_295_22.x, var_295_22.y, var_295_22.z)

				local var_295_23 = var_295_15.localEulerAngles

				var_295_23.z = 0
				var_295_23.x = 0
				var_295_15.localEulerAngles = var_295_23
			end

			local var_295_24 = arg_292_1.actors_["1074ui_story"]
			local var_295_25 = 0

			if var_295_25 < arg_292_1.time_ and arg_292_1.time_ <= var_295_25 + arg_295_0 and not isNil(var_295_24) and arg_292_1.var_.characterEffect1074ui_story == nil then
				arg_292_1.var_.characterEffect1074ui_story = var_295_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_26 = 0.200000002980232

			if var_295_25 <= arg_292_1.time_ and arg_292_1.time_ < var_295_25 + var_295_26 and not isNil(var_295_24) then
				local var_295_27 = (arg_292_1.time_ - var_295_25) / var_295_26

				if arg_292_1.var_.characterEffect1074ui_story and not isNil(var_295_24) then
					local var_295_28 = Mathf.Lerp(0, 0.5, var_295_27)

					arg_292_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_292_1.var_.characterEffect1074ui_story.fillRatio = var_295_28
				end
			end

			if arg_292_1.time_ >= var_295_25 + var_295_26 and arg_292_1.time_ < var_295_25 + var_295_26 + arg_295_0 and not isNil(var_295_24) and arg_292_1.var_.characterEffect1074ui_story then
				local var_295_29 = 0.5

				arg_292_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_292_1.var_.characterEffect1074ui_story.fillRatio = var_295_29
			end

			local var_295_30 = 0
			local var_295_31 = 1.375

			if var_295_30 < arg_292_1.time_ and arg_292_1.time_ <= var_295_30 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_32 = arg_292_1:GetWordFromCfg(122031069)
				local var_295_33 = arg_292_1:FormatText(var_295_32.content)

				arg_292_1.text_.text = var_295_33

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_34 = 55
				local var_295_35 = utf8.len(var_295_33)
				local var_295_36 = var_295_34 <= 0 and var_295_31 or var_295_31 * (var_295_35 / var_295_34)

				if var_295_36 > 0 and var_295_31 < var_295_36 then
					arg_292_1.talkMaxDuration = var_295_36

					if var_295_36 + var_295_30 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_36 + var_295_30
					end
				end

				arg_292_1.text_.text = var_295_33
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_37 = math.max(var_295_31, arg_292_1.talkMaxDuration)

			if var_295_30 <= arg_292_1.time_ and arg_292_1.time_ < var_295_30 + var_295_37 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_30) / var_295_37

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_30 + var_295_37 and arg_292_1.time_ < var_295_30 + var_295_37 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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

		arg_292_1:InitPlayNodeList()
	end,
	Play122031070 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 122031070
		arg_296_1.duration_ = 6.83

		local var_296_0 = {
			ja = 6.833,
			ko = 2.1,
			zh = 2.1
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play122031071(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = arg_296_1.actors_["1074ui_story"].transform
			local var_299_1 = 0

			if var_299_1 < arg_296_1.time_ and arg_296_1.time_ <= var_299_1 + arg_299_0 then
				arg_296_1.var_.moveOldPos1074ui_story = var_299_0.localPosition
			end

			local var_299_2 = 0.001

			if var_299_1 <= arg_296_1.time_ and arg_296_1.time_ < var_299_1 + var_299_2 then
				local var_299_3 = (arg_296_1.time_ - var_299_1) / var_299_2
				local var_299_4 = Vector3.New(-0.7, -1.055, -6.12)

				var_299_0.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1074ui_story, var_299_4, var_299_3)

				local var_299_5 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_5.x, var_299_5.y, var_299_5.z)

				local var_299_6 = var_299_0.localEulerAngles

				var_299_6.z = 0
				var_299_6.x = 0
				var_299_0.localEulerAngles = var_299_6
			end

			if arg_296_1.time_ >= var_299_1 + var_299_2 and arg_296_1.time_ < var_299_1 + var_299_2 + arg_299_0 then
				var_299_0.localPosition = Vector3.New(-0.7, -1.055, -6.12)

				local var_299_7 = manager.ui.mainCamera.transform.position - var_299_0.position

				var_299_0.forward = Vector3.New(var_299_7.x, var_299_7.y, var_299_7.z)

				local var_299_8 = var_299_0.localEulerAngles

				var_299_8.z = 0
				var_299_8.x = 0
				var_299_0.localEulerAngles = var_299_8
			end

			local var_299_9 = arg_296_1.actors_["1074ui_story"]
			local var_299_10 = 0

			if var_299_10 < arg_296_1.time_ and arg_296_1.time_ <= var_299_10 + arg_299_0 and not isNil(var_299_9) and arg_296_1.var_.characterEffect1074ui_story == nil then
				arg_296_1.var_.characterEffect1074ui_story = var_299_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_11 = 0.200000002980232

			if var_299_10 <= arg_296_1.time_ and arg_296_1.time_ < var_299_10 + var_299_11 and not isNil(var_299_9) then
				local var_299_12 = (arg_296_1.time_ - var_299_10) / var_299_11

				if arg_296_1.var_.characterEffect1074ui_story and not isNil(var_299_9) then
					arg_296_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= var_299_10 + var_299_11 and arg_296_1.time_ < var_299_10 + var_299_11 + arg_299_0 and not isNil(var_299_9) and arg_296_1.var_.characterEffect1074ui_story then
				arg_296_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_299_13 = 0

			if var_299_13 < arg_296_1.time_ and arg_296_1.time_ <= var_299_13 + arg_299_0 then
				arg_296_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_299_14 = 0

			if var_299_14 < arg_296_1.time_ and arg_296_1.time_ <= var_299_14 + arg_299_0 then
				arg_296_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_299_15 = arg_296_1.actors_["10044ui_story"].transform
			local var_299_16 = 0

			if var_299_16 < arg_296_1.time_ and arg_296_1.time_ <= var_299_16 + arg_299_0 then
				arg_296_1.var_.moveOldPos10044ui_story = var_299_15.localPosition
			end

			local var_299_17 = 0.001

			if var_299_16 <= arg_296_1.time_ and arg_296_1.time_ < var_299_16 + var_299_17 then
				local var_299_18 = (arg_296_1.time_ - var_299_16) / var_299_17
				local var_299_19 = Vector3.New(0.7, -0.72, -6.3)

				var_299_15.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos10044ui_story, var_299_19, var_299_18)

				local var_299_20 = manager.ui.mainCamera.transform.position - var_299_15.position

				var_299_15.forward = Vector3.New(var_299_20.x, var_299_20.y, var_299_20.z)

				local var_299_21 = var_299_15.localEulerAngles

				var_299_21.z = 0
				var_299_21.x = 0
				var_299_15.localEulerAngles = var_299_21
			end

			if arg_296_1.time_ >= var_299_16 + var_299_17 and arg_296_1.time_ < var_299_16 + var_299_17 + arg_299_0 then
				var_299_15.localPosition = Vector3.New(0.7, -0.72, -6.3)

				local var_299_22 = manager.ui.mainCamera.transform.position - var_299_15.position

				var_299_15.forward = Vector3.New(var_299_22.x, var_299_22.y, var_299_22.z)

				local var_299_23 = var_299_15.localEulerAngles

				var_299_23.z = 0
				var_299_23.x = 0
				var_299_15.localEulerAngles = var_299_23
			end

			local var_299_24 = arg_296_1.actors_["10044ui_story"]
			local var_299_25 = 0

			if var_299_25 < arg_296_1.time_ and arg_296_1.time_ <= var_299_25 + arg_299_0 and not isNil(var_299_24) and arg_296_1.var_.characterEffect10044ui_story == nil then
				arg_296_1.var_.characterEffect10044ui_story = var_299_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_26 = 0.200000002980232

			if var_299_25 <= arg_296_1.time_ and arg_296_1.time_ < var_299_25 + var_299_26 and not isNil(var_299_24) then
				local var_299_27 = (arg_296_1.time_ - var_299_25) / var_299_26

				if arg_296_1.var_.characterEffect10044ui_story and not isNil(var_299_24) then
					local var_299_28 = Mathf.Lerp(0, 0.5, var_299_27)

					arg_296_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_296_1.var_.characterEffect10044ui_story.fillRatio = var_299_28
				end
			end

			if arg_296_1.time_ >= var_299_25 + var_299_26 and arg_296_1.time_ < var_299_25 + var_299_26 + arg_299_0 and not isNil(var_299_24) and arg_296_1.var_.characterEffect10044ui_story then
				local var_299_29 = 0.5

				arg_296_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_296_1.var_.characterEffect10044ui_story.fillRatio = var_299_29
			end

			local var_299_30 = 0

			if var_299_30 < arg_296_1.time_ and arg_296_1.time_ <= var_299_30 + arg_299_0 then
				arg_296_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_299_31 = 0

			if var_299_31 < arg_296_1.time_ and arg_296_1.time_ <= var_299_31 + arg_299_0 then
				arg_296_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_299_32 = 0
			local var_299_33 = 0.3

			if var_299_32 < arg_296_1.time_ and arg_296_1.time_ <= var_299_32 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				local var_299_34 = arg_296_1:FormatText(StoryNameCfg[410].name)

				arg_296_1.leftNameTxt_.text = var_299_34

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_35 = arg_296_1:GetWordFromCfg(122031070)
				local var_299_36 = arg_296_1:FormatText(var_299_35.content)

				arg_296_1.text_.text = var_299_36

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_37 = 12
				local var_299_38 = utf8.len(var_299_36)
				local var_299_39 = var_299_37 <= 0 and var_299_33 or var_299_33 * (var_299_38 / var_299_37)

				if var_299_39 > 0 and var_299_33 < var_299_39 then
					arg_296_1.talkMaxDuration = var_299_39

					if var_299_39 + var_299_32 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_39 + var_299_32
					end
				end

				arg_296_1.text_.text = var_299_36
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031070", "story_v_out_122031.awb") ~= 0 then
					local var_299_40 = manager.audio:GetVoiceLength("story_v_out_122031", "122031070", "story_v_out_122031.awb") / 1000

					if var_299_40 + var_299_32 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_40 + var_299_32
					end

					if var_299_35.prefab_name ~= "" and arg_296_1.actors_[var_299_35.prefab_name] ~= nil then
						local var_299_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_35.prefab_name].transform, "story_v_out_122031", "122031070", "story_v_out_122031.awb")

						arg_296_1:RecordAudio("122031070", var_299_41)
						arg_296_1:RecordAudio("122031070", var_299_41)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_122031", "122031070", "story_v_out_122031.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_122031", "122031070", "story_v_out_122031.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_42 = math.max(var_299_33, arg_296_1.talkMaxDuration)

			if var_299_32 <= arg_296_1.time_ and arg_296_1.time_ < var_299_32 + var_299_42 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_32) / var_299_42

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_32 + var_299_42 and arg_296_1.time_ < var_299_32 + var_299_42 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
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
	Play122031071 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 122031071
		arg_300_1.duration_ = 13.2

		local var_300_0 = {
			ja = 13.2,
			ko = 9.033,
			zh = 9.033
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play122031072(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = arg_300_1.actors_["10044ui_story"]
			local var_303_1 = 0

			if var_303_1 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect10044ui_story == nil then
				arg_300_1.var_.characterEffect10044ui_story = var_303_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_2 = 0.200000002980232

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_2 and not isNil(var_303_0) then
				local var_303_3 = (arg_300_1.time_ - var_303_1) / var_303_2

				if arg_300_1.var_.characterEffect10044ui_story and not isNil(var_303_0) then
					arg_300_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= var_303_1 + var_303_2 and arg_300_1.time_ < var_303_1 + var_303_2 + arg_303_0 and not isNil(var_303_0) and arg_300_1.var_.characterEffect10044ui_story then
				arg_300_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_303_4 = 0

			if var_303_4 < arg_300_1.time_ and arg_300_1.time_ <= var_303_4 + arg_303_0 then
				arg_300_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_303_5 = 0

			if var_303_5 < arg_300_1.time_ and arg_300_1.time_ <= var_303_5 + arg_303_0 then
				arg_300_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_303_6 = arg_300_1.actors_["1074ui_story"]
			local var_303_7 = 0

			if var_303_7 < arg_300_1.time_ and arg_300_1.time_ <= var_303_7 + arg_303_0 and not isNil(var_303_6) and arg_300_1.var_.characterEffect1074ui_story == nil then
				arg_300_1.var_.characterEffect1074ui_story = var_303_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_8 = 0.200000002980232

			if var_303_7 <= arg_300_1.time_ and arg_300_1.time_ < var_303_7 + var_303_8 and not isNil(var_303_6) then
				local var_303_9 = (arg_300_1.time_ - var_303_7) / var_303_8

				if arg_300_1.var_.characterEffect1074ui_story and not isNil(var_303_6) then
					local var_303_10 = Mathf.Lerp(0, 0.5, var_303_9)

					arg_300_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_300_1.var_.characterEffect1074ui_story.fillRatio = var_303_10
				end
			end

			if arg_300_1.time_ >= var_303_7 + var_303_8 and arg_300_1.time_ < var_303_7 + var_303_8 + arg_303_0 and not isNil(var_303_6) and arg_300_1.var_.characterEffect1074ui_story then
				local var_303_11 = 0.5

				arg_300_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_300_1.var_.characterEffect1074ui_story.fillRatio = var_303_11
			end

			local var_303_12 = 0
			local var_303_13 = 1.2

			if var_303_12 < arg_300_1.time_ and arg_300_1.time_ <= var_303_12 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_14 = arg_300_1:FormatText(StoryNameCfg[380].name)

				arg_300_1.leftNameTxt_.text = var_303_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_15 = arg_300_1:GetWordFromCfg(122031071)
				local var_303_16 = arg_300_1:FormatText(var_303_15.content)

				arg_300_1.text_.text = var_303_16

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_17 = 48
				local var_303_18 = utf8.len(var_303_16)
				local var_303_19 = var_303_17 <= 0 and var_303_13 or var_303_13 * (var_303_18 / var_303_17)

				if var_303_19 > 0 and var_303_13 < var_303_19 then
					arg_300_1.talkMaxDuration = var_303_19

					if var_303_19 + var_303_12 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_19 + var_303_12
					end
				end

				arg_300_1.text_.text = var_303_16
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031071", "story_v_out_122031.awb") ~= 0 then
					local var_303_20 = manager.audio:GetVoiceLength("story_v_out_122031", "122031071", "story_v_out_122031.awb") / 1000

					if var_303_20 + var_303_12 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_20 + var_303_12
					end

					if var_303_15.prefab_name ~= "" and arg_300_1.actors_[var_303_15.prefab_name] ~= nil then
						local var_303_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_15.prefab_name].transform, "story_v_out_122031", "122031071", "story_v_out_122031.awb")

						arg_300_1:RecordAudio("122031071", var_303_21)
						arg_300_1:RecordAudio("122031071", var_303_21)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_122031", "122031071", "story_v_out_122031.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_122031", "122031071", "story_v_out_122031.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_22 = math.max(var_303_13, arg_300_1.talkMaxDuration)

			if var_303_12 <= arg_300_1.time_ and arg_300_1.time_ < var_303_12 + var_303_22 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_12) / var_303_22

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_12 + var_303_22 and arg_300_1.time_ < var_303_12 + var_303_22 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play122031072 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 122031072
		arg_304_1.duration_ = 5.8

		local var_304_0 = {
			ja = 5.8,
			ko = 3.166,
			zh = 3.166
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play122031073(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["1074ui_story"]
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1074ui_story == nil then
				arg_304_1.var_.characterEffect1074ui_story = var_307_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.200000002980232

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 and not isNil(var_307_0) then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2

				if arg_304_1.var_.characterEffect1074ui_story and not isNil(var_307_0) then
					arg_304_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 and not isNil(var_307_0) and arg_304_1.var_.characterEffect1074ui_story then
				arg_304_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_307_4 = 0

			if var_307_4 < arg_304_1.time_ and arg_304_1.time_ <= var_307_4 + arg_307_0 then
				arg_304_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action1_1")
			end

			local var_307_5 = 0

			if var_307_5 < arg_304_1.time_ and arg_304_1.time_ <= var_307_5 + arg_307_0 then
				arg_304_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_307_6 = arg_304_1.actors_["10044ui_story"]
			local var_307_7 = 0

			if var_307_7 < arg_304_1.time_ and arg_304_1.time_ <= var_307_7 + arg_307_0 and not isNil(var_307_6) and arg_304_1.var_.characterEffect10044ui_story == nil then
				arg_304_1.var_.characterEffect10044ui_story = var_307_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_8 = 0.200000002980232

			if var_307_7 <= arg_304_1.time_ and arg_304_1.time_ < var_307_7 + var_307_8 and not isNil(var_307_6) then
				local var_307_9 = (arg_304_1.time_ - var_307_7) / var_307_8

				if arg_304_1.var_.characterEffect10044ui_story and not isNil(var_307_6) then
					local var_307_10 = Mathf.Lerp(0, 0.5, var_307_9)

					arg_304_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_304_1.var_.characterEffect10044ui_story.fillRatio = var_307_10
				end
			end

			if arg_304_1.time_ >= var_307_7 + var_307_8 and arg_304_1.time_ < var_307_7 + var_307_8 + arg_307_0 and not isNil(var_307_6) and arg_304_1.var_.characterEffect10044ui_story then
				local var_307_11 = 0.5

				arg_304_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_304_1.var_.characterEffect10044ui_story.fillRatio = var_307_11
			end

			local var_307_12 = 0
			local var_307_13 = 0.35

			if var_307_12 < arg_304_1.time_ and arg_304_1.time_ <= var_307_12 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_14 = arg_304_1:FormatText(StoryNameCfg[410].name)

				arg_304_1.leftNameTxt_.text = var_307_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_15 = arg_304_1:GetWordFromCfg(122031072)
				local var_307_16 = arg_304_1:FormatText(var_307_15.content)

				arg_304_1.text_.text = var_307_16

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_17 = 14
				local var_307_18 = utf8.len(var_307_16)
				local var_307_19 = var_307_17 <= 0 and var_307_13 or var_307_13 * (var_307_18 / var_307_17)

				if var_307_19 > 0 and var_307_13 < var_307_19 then
					arg_304_1.talkMaxDuration = var_307_19

					if var_307_19 + var_307_12 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_19 + var_307_12
					end
				end

				arg_304_1.text_.text = var_307_16
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031072", "story_v_out_122031.awb") ~= 0 then
					local var_307_20 = manager.audio:GetVoiceLength("story_v_out_122031", "122031072", "story_v_out_122031.awb") / 1000

					if var_307_20 + var_307_12 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_20 + var_307_12
					end

					if var_307_15.prefab_name ~= "" and arg_304_1.actors_[var_307_15.prefab_name] ~= nil then
						local var_307_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_15.prefab_name].transform, "story_v_out_122031", "122031072", "story_v_out_122031.awb")

						arg_304_1:RecordAudio("122031072", var_307_21)
						arg_304_1:RecordAudio("122031072", var_307_21)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_122031", "122031072", "story_v_out_122031.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_122031", "122031072", "story_v_out_122031.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_22 = math.max(var_307_13, arg_304_1.talkMaxDuration)

			if var_307_12 <= arg_304_1.time_ and arg_304_1.time_ < var_307_12 + var_307_22 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_12) / var_307_22

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_12 + var_307_22 and arg_304_1.time_ < var_307_12 + var_307_22 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play122031073 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 122031073
		arg_308_1.duration_ = 6.33

		local var_308_0 = {
			ja = 5.433,
			ko = 6.333,
			zh = 6.333
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play122031074(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["10044ui_story"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect10044ui_story == nil then
				arg_308_1.var_.characterEffect10044ui_story = var_311_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_2 = 0.200000002980232

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.characterEffect10044ui_story and not isNil(var_311_0) then
					arg_308_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect10044ui_story then
				arg_308_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_311_4 = 0

			if var_311_4 < arg_308_1.time_ and arg_308_1.time_ <= var_311_4 + arg_311_0 then
				arg_308_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_311_5 = arg_308_1.actors_["1074ui_story"]
			local var_311_6 = 0

			if var_311_6 < arg_308_1.time_ and arg_308_1.time_ <= var_311_6 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.characterEffect1074ui_story == nil then
				arg_308_1.var_.characterEffect1074ui_story = var_311_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_7 = 0.200000002980232

			if var_311_6 <= arg_308_1.time_ and arg_308_1.time_ < var_311_6 + var_311_7 and not isNil(var_311_5) then
				local var_311_8 = (arg_308_1.time_ - var_311_6) / var_311_7

				if arg_308_1.var_.characterEffect1074ui_story and not isNil(var_311_5) then
					local var_311_9 = Mathf.Lerp(0, 0.5, var_311_8)

					arg_308_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1074ui_story.fillRatio = var_311_9
				end
			end

			if arg_308_1.time_ >= var_311_6 + var_311_7 and arg_308_1.time_ < var_311_6 + var_311_7 + arg_311_0 and not isNil(var_311_5) and arg_308_1.var_.characterEffect1074ui_story then
				local var_311_10 = 0.5

				arg_308_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1074ui_story.fillRatio = var_311_10
			end

			local var_311_11 = 0
			local var_311_12 = 0.475

			if var_311_11 < arg_308_1.time_ and arg_308_1.time_ <= var_311_11 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				local var_311_13 = arg_308_1:FormatText(StoryNameCfg[380].name)

				arg_308_1.leftNameTxt_.text = var_311_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_14 = arg_308_1:GetWordFromCfg(122031073)
				local var_311_15 = arg_308_1:FormatText(var_311_14.content)

				arg_308_1.text_.text = var_311_15

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_16 = 19
				local var_311_17 = utf8.len(var_311_15)
				local var_311_18 = var_311_16 <= 0 and var_311_12 or var_311_12 * (var_311_17 / var_311_16)

				if var_311_18 > 0 and var_311_12 < var_311_18 then
					arg_308_1.talkMaxDuration = var_311_18

					if var_311_18 + var_311_11 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_18 + var_311_11
					end
				end

				arg_308_1.text_.text = var_311_15
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031073", "story_v_out_122031.awb") ~= 0 then
					local var_311_19 = manager.audio:GetVoiceLength("story_v_out_122031", "122031073", "story_v_out_122031.awb") / 1000

					if var_311_19 + var_311_11 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_19 + var_311_11
					end

					if var_311_14.prefab_name ~= "" and arg_308_1.actors_[var_311_14.prefab_name] ~= nil then
						local var_311_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_14.prefab_name].transform, "story_v_out_122031", "122031073", "story_v_out_122031.awb")

						arg_308_1:RecordAudio("122031073", var_311_20)
						arg_308_1:RecordAudio("122031073", var_311_20)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_122031", "122031073", "story_v_out_122031.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_122031", "122031073", "story_v_out_122031.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_21 = math.max(var_311_12, arg_308_1.talkMaxDuration)

			if var_311_11 <= arg_308_1.time_ and arg_308_1.time_ < var_311_11 + var_311_21 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_11) / var_311_21

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_11 + var_311_21 and arg_308_1.time_ < var_311_11 + var_311_21 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play122031074 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 122031074
		arg_312_1.duration_ = 7.23

		local var_312_0 = {
			ja = 7.233,
			ko = 5.933,
			zh = 5.933
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
				arg_312_0:Play122031075(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = arg_312_1.actors_["1074ui_story"]
			local var_315_1 = 0

			if var_315_1 < arg_312_1.time_ and arg_312_1.time_ <= var_315_1 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.characterEffect1074ui_story == nil then
				arg_312_1.var_.characterEffect1074ui_story = var_315_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_2 = 0.200000002980232

			if var_315_1 <= arg_312_1.time_ and arg_312_1.time_ < var_315_1 + var_315_2 and not isNil(var_315_0) then
				local var_315_3 = (arg_312_1.time_ - var_315_1) / var_315_2

				if arg_312_1.var_.characterEffect1074ui_story and not isNil(var_315_0) then
					arg_312_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= var_315_1 + var_315_2 and arg_312_1.time_ < var_315_1 + var_315_2 + arg_315_0 and not isNil(var_315_0) and arg_312_1.var_.characterEffect1074ui_story then
				arg_312_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_315_4 = 0

			if var_315_4 < arg_312_1.time_ and arg_312_1.time_ <= var_315_4 + arg_315_0 then
				arg_312_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_1")
			end

			local var_315_5 = 0

			if var_315_5 < arg_312_1.time_ and arg_312_1.time_ <= var_315_5 + arg_315_0 then
				arg_312_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_315_6 = arg_312_1.actors_["10044ui_story"]
			local var_315_7 = 0

			if var_315_7 < arg_312_1.time_ and arg_312_1.time_ <= var_315_7 + arg_315_0 and not isNil(var_315_6) and arg_312_1.var_.characterEffect10044ui_story == nil then
				arg_312_1.var_.characterEffect10044ui_story = var_315_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_8 = 0.200000002980232

			if var_315_7 <= arg_312_1.time_ and arg_312_1.time_ < var_315_7 + var_315_8 and not isNil(var_315_6) then
				local var_315_9 = (arg_312_1.time_ - var_315_7) / var_315_8

				if arg_312_1.var_.characterEffect10044ui_story and not isNil(var_315_6) then
					local var_315_10 = Mathf.Lerp(0, 0.5, var_315_9)

					arg_312_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_312_1.var_.characterEffect10044ui_story.fillRatio = var_315_10
				end
			end

			if arg_312_1.time_ >= var_315_7 + var_315_8 and arg_312_1.time_ < var_315_7 + var_315_8 + arg_315_0 and not isNil(var_315_6) and arg_312_1.var_.characterEffect10044ui_story then
				local var_315_11 = 0.5

				arg_312_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_312_1.var_.characterEffect10044ui_story.fillRatio = var_315_11
			end

			local var_315_12 = 0
			local var_315_13 = 0.675

			if var_315_12 < arg_312_1.time_ and arg_312_1.time_ <= var_315_12 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_14 = arg_312_1:FormatText(StoryNameCfg[410].name)

				arg_312_1.leftNameTxt_.text = var_315_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_15 = arg_312_1:GetWordFromCfg(122031074)
				local var_315_16 = arg_312_1:FormatText(var_315_15.content)

				arg_312_1.text_.text = var_315_16

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_17 = 27
				local var_315_18 = utf8.len(var_315_16)
				local var_315_19 = var_315_17 <= 0 and var_315_13 or var_315_13 * (var_315_18 / var_315_17)

				if var_315_19 > 0 and var_315_13 < var_315_19 then
					arg_312_1.talkMaxDuration = var_315_19

					if var_315_19 + var_315_12 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_19 + var_315_12
					end
				end

				arg_312_1.text_.text = var_315_16
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031074", "story_v_out_122031.awb") ~= 0 then
					local var_315_20 = manager.audio:GetVoiceLength("story_v_out_122031", "122031074", "story_v_out_122031.awb") / 1000

					if var_315_20 + var_315_12 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_20 + var_315_12
					end

					if var_315_15.prefab_name ~= "" and arg_312_1.actors_[var_315_15.prefab_name] ~= nil then
						local var_315_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_15.prefab_name].transform, "story_v_out_122031", "122031074", "story_v_out_122031.awb")

						arg_312_1:RecordAudio("122031074", var_315_21)
						arg_312_1:RecordAudio("122031074", var_315_21)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_122031", "122031074", "story_v_out_122031.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_122031", "122031074", "story_v_out_122031.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_22 = math.max(var_315_13, arg_312_1.talkMaxDuration)

			if var_315_12 <= arg_312_1.time_ and arg_312_1.time_ < var_315_12 + var_315_22 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_12) / var_315_22

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_12 + var_315_22 and arg_312_1.time_ < var_315_12 + var_315_22 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play122031075 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 122031075
		arg_316_1.duration_ = 7.63

		local var_316_0 = {
			ja = 7.633,
			ko = 2.533,
			zh = 2.533
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play122031076(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0
			local var_319_1 = 0.3

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_2 = arg_316_1:FormatText(StoryNameCfg[410].name)

				arg_316_1.leftNameTxt_.text = var_319_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_3 = arg_316_1:GetWordFromCfg(122031075)
				local var_319_4 = arg_316_1:FormatText(var_319_3.content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_5 = 12
				local var_319_6 = utf8.len(var_319_4)
				local var_319_7 = var_319_5 <= 0 and var_319_1 or var_319_1 * (var_319_6 / var_319_5)

				if var_319_7 > 0 and var_319_1 < var_319_7 then
					arg_316_1.talkMaxDuration = var_319_7

					if var_319_7 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_0
					end
				end

				arg_316_1.text_.text = var_319_4
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031075", "story_v_out_122031.awb") ~= 0 then
					local var_319_8 = manager.audio:GetVoiceLength("story_v_out_122031", "122031075", "story_v_out_122031.awb") / 1000

					if var_319_8 + var_319_0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_8 + var_319_0
					end

					if var_319_3.prefab_name ~= "" and arg_316_1.actors_[var_319_3.prefab_name] ~= nil then
						local var_319_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_3.prefab_name].transform, "story_v_out_122031", "122031075", "story_v_out_122031.awb")

						arg_316_1:RecordAudio("122031075", var_319_9)
						arg_316_1:RecordAudio("122031075", var_319_9)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_122031", "122031075", "story_v_out_122031.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_122031", "122031075", "story_v_out_122031.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_10 = math.max(var_319_1, arg_316_1.talkMaxDuration)

			if var_319_0 <= arg_316_1.time_ and arg_316_1.time_ < var_319_0 + var_319_10 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_0) / var_319_10

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_0 + var_319_10 and arg_316_1.time_ < var_319_0 + var_319_10 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play122031076 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 122031076
		arg_320_1.duration_ = 3.1

		local var_320_0 = {
			ja = 3.1,
			ko = 2.1,
			zh = 2.1
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play122031077(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["10044ui_story"]
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect10044ui_story == nil then
				arg_320_1.var_.characterEffect10044ui_story = var_323_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_2 = 0.200000002980232

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 and not isNil(var_323_0) then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2

				if arg_320_1.var_.characterEffect10044ui_story and not isNil(var_323_0) then
					arg_320_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect10044ui_story then
				arg_320_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_323_4 = 0

			if var_323_4 < arg_320_1.time_ and arg_320_1.time_ <= var_323_4 + arg_323_0 then
				arg_320_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044actionlink/10044action432")
			end

			local var_323_5 = 0

			if var_323_5 < arg_320_1.time_ and arg_320_1.time_ <= var_323_5 + arg_323_0 then
				arg_320_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_323_6 = arg_320_1.actors_["1074ui_story"]
			local var_323_7 = 0

			if var_323_7 < arg_320_1.time_ and arg_320_1.time_ <= var_323_7 + arg_323_0 and not isNil(var_323_6) and arg_320_1.var_.characterEffect1074ui_story == nil then
				arg_320_1.var_.characterEffect1074ui_story = var_323_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_8 = 0.200000002980232

			if var_323_7 <= arg_320_1.time_ and arg_320_1.time_ < var_323_7 + var_323_8 and not isNil(var_323_6) then
				local var_323_9 = (arg_320_1.time_ - var_323_7) / var_323_8

				if arg_320_1.var_.characterEffect1074ui_story and not isNil(var_323_6) then
					local var_323_10 = Mathf.Lerp(0, 0.5, var_323_9)

					arg_320_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_320_1.var_.characterEffect1074ui_story.fillRatio = var_323_10
				end
			end

			if arg_320_1.time_ >= var_323_7 + var_323_8 and arg_320_1.time_ < var_323_7 + var_323_8 + arg_323_0 and not isNil(var_323_6) and arg_320_1.var_.characterEffect1074ui_story then
				local var_323_11 = 0.5

				arg_320_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_320_1.var_.characterEffect1074ui_story.fillRatio = var_323_11
			end

			local var_323_12 = 0
			local var_323_13 = 0.25

			if var_323_12 < arg_320_1.time_ and arg_320_1.time_ <= var_323_12 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_14 = arg_320_1:FormatText(StoryNameCfg[380].name)

				arg_320_1.leftNameTxt_.text = var_323_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_15 = arg_320_1:GetWordFromCfg(122031076)
				local var_323_16 = arg_320_1:FormatText(var_323_15.content)

				arg_320_1.text_.text = var_323_16

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_17 = 10
				local var_323_18 = utf8.len(var_323_16)
				local var_323_19 = var_323_17 <= 0 and var_323_13 or var_323_13 * (var_323_18 / var_323_17)

				if var_323_19 > 0 and var_323_13 < var_323_19 then
					arg_320_1.talkMaxDuration = var_323_19

					if var_323_19 + var_323_12 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_19 + var_323_12
					end
				end

				arg_320_1.text_.text = var_323_16
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031076", "story_v_out_122031.awb") ~= 0 then
					local var_323_20 = manager.audio:GetVoiceLength("story_v_out_122031", "122031076", "story_v_out_122031.awb") / 1000

					if var_323_20 + var_323_12 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_20 + var_323_12
					end

					if var_323_15.prefab_name ~= "" and arg_320_1.actors_[var_323_15.prefab_name] ~= nil then
						local var_323_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_15.prefab_name].transform, "story_v_out_122031", "122031076", "story_v_out_122031.awb")

						arg_320_1:RecordAudio("122031076", var_323_21)
						arg_320_1:RecordAudio("122031076", var_323_21)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_122031", "122031076", "story_v_out_122031.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_122031", "122031076", "story_v_out_122031.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_22 = math.max(var_323_13, arg_320_1.talkMaxDuration)

			if var_323_12 <= arg_320_1.time_ and arg_320_1.time_ < var_323_12 + var_323_22 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_12) / var_323_22

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_12 + var_323_22 and arg_320_1.time_ < var_323_12 + var_323_22 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play122031077 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 122031077
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play122031078(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = arg_324_1.actors_["10044ui_story"].transform
			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 then
				arg_324_1.var_.moveOldPos10044ui_story = var_327_0.localPosition
			end

			local var_327_2 = 0.001

			if var_327_1 <= arg_324_1.time_ and arg_324_1.time_ < var_327_1 + var_327_2 then
				local var_327_3 = (arg_324_1.time_ - var_327_1) / var_327_2
				local var_327_4 = Vector3.New(0, 100, 0)

				var_327_0.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos10044ui_story, var_327_4, var_327_3)

				local var_327_5 = manager.ui.mainCamera.transform.position - var_327_0.position

				var_327_0.forward = Vector3.New(var_327_5.x, var_327_5.y, var_327_5.z)

				local var_327_6 = var_327_0.localEulerAngles

				var_327_6.z = 0
				var_327_6.x = 0
				var_327_0.localEulerAngles = var_327_6
			end

			if arg_324_1.time_ >= var_327_1 + var_327_2 and arg_324_1.time_ < var_327_1 + var_327_2 + arg_327_0 then
				var_327_0.localPosition = Vector3.New(0, 100, 0)

				local var_327_7 = manager.ui.mainCamera.transform.position - var_327_0.position

				var_327_0.forward = Vector3.New(var_327_7.x, var_327_7.y, var_327_7.z)

				local var_327_8 = var_327_0.localEulerAngles

				var_327_8.z = 0
				var_327_8.x = 0
				var_327_0.localEulerAngles = var_327_8
			end

			local var_327_9 = arg_324_1.actors_["10044ui_story"]
			local var_327_10 = 0

			if var_327_10 < arg_324_1.time_ and arg_324_1.time_ <= var_327_10 + arg_327_0 and not isNil(var_327_9) and arg_324_1.var_.characterEffect10044ui_story == nil then
				arg_324_1.var_.characterEffect10044ui_story = var_327_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_11 = 0.200000002980232

			if var_327_10 <= arg_324_1.time_ and arg_324_1.time_ < var_327_10 + var_327_11 and not isNil(var_327_9) then
				local var_327_12 = (arg_324_1.time_ - var_327_10) / var_327_11

				if arg_324_1.var_.characterEffect10044ui_story and not isNil(var_327_9) then
					local var_327_13 = Mathf.Lerp(0, 0.5, var_327_12)

					arg_324_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_324_1.var_.characterEffect10044ui_story.fillRatio = var_327_13
				end
			end

			if arg_324_1.time_ >= var_327_10 + var_327_11 and arg_324_1.time_ < var_327_10 + var_327_11 + arg_327_0 and not isNil(var_327_9) and arg_324_1.var_.characterEffect10044ui_story then
				local var_327_14 = 0.5

				arg_324_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_324_1.var_.characterEffect10044ui_story.fillRatio = var_327_14
			end

			local var_327_15 = arg_324_1.actors_["1074ui_story"].transform
			local var_327_16 = 0

			if var_327_16 < arg_324_1.time_ and arg_324_1.time_ <= var_327_16 + arg_327_0 then
				arg_324_1.var_.moveOldPos1074ui_story = var_327_15.localPosition
			end

			local var_327_17 = 0.001

			if var_327_16 <= arg_324_1.time_ and arg_324_1.time_ < var_327_16 + var_327_17 then
				local var_327_18 = (arg_324_1.time_ - var_327_16) / var_327_17
				local var_327_19 = Vector3.New(0, 100, 0)

				var_327_15.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1074ui_story, var_327_19, var_327_18)

				local var_327_20 = manager.ui.mainCamera.transform.position - var_327_15.position

				var_327_15.forward = Vector3.New(var_327_20.x, var_327_20.y, var_327_20.z)

				local var_327_21 = var_327_15.localEulerAngles

				var_327_21.z = 0
				var_327_21.x = 0
				var_327_15.localEulerAngles = var_327_21
			end

			if arg_324_1.time_ >= var_327_16 + var_327_17 and arg_324_1.time_ < var_327_16 + var_327_17 + arg_327_0 then
				var_327_15.localPosition = Vector3.New(0, 100, 0)

				local var_327_22 = manager.ui.mainCamera.transform.position - var_327_15.position

				var_327_15.forward = Vector3.New(var_327_22.x, var_327_22.y, var_327_22.z)

				local var_327_23 = var_327_15.localEulerAngles

				var_327_23.z = 0
				var_327_23.x = 0
				var_327_15.localEulerAngles = var_327_23
			end

			local var_327_24 = arg_324_1.actors_["1074ui_story"]
			local var_327_25 = 0

			if var_327_25 < arg_324_1.time_ and arg_324_1.time_ <= var_327_25 + arg_327_0 and not isNil(var_327_24) and arg_324_1.var_.characterEffect1074ui_story == nil then
				arg_324_1.var_.characterEffect1074ui_story = var_327_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_26 = 0.200000002980232

			if var_327_25 <= arg_324_1.time_ and arg_324_1.time_ < var_327_25 + var_327_26 and not isNil(var_327_24) then
				local var_327_27 = (arg_324_1.time_ - var_327_25) / var_327_26

				if arg_324_1.var_.characterEffect1074ui_story and not isNil(var_327_24) then
					local var_327_28 = Mathf.Lerp(0, 0.5, var_327_27)

					arg_324_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_324_1.var_.characterEffect1074ui_story.fillRatio = var_327_28
				end
			end

			if arg_324_1.time_ >= var_327_25 + var_327_26 and arg_324_1.time_ < var_327_25 + var_327_26 + arg_327_0 and not isNil(var_327_24) and arg_324_1.var_.characterEffect1074ui_story then
				local var_327_29 = 0.5

				arg_324_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_324_1.var_.characterEffect1074ui_story.fillRatio = var_327_29
			end

			local var_327_30 = 0
			local var_327_31 = 0.925

			if var_327_30 < arg_324_1.time_ and arg_324_1.time_ <= var_327_30 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_32 = arg_324_1:GetWordFromCfg(122031077)
				local var_327_33 = arg_324_1:FormatText(var_327_32.content)

				arg_324_1.text_.text = var_327_33

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_34 = 37
				local var_327_35 = utf8.len(var_327_33)
				local var_327_36 = var_327_34 <= 0 and var_327_31 or var_327_31 * (var_327_35 / var_327_34)

				if var_327_36 > 0 and var_327_31 < var_327_36 then
					arg_324_1.talkMaxDuration = var_327_36

					if var_327_36 + var_327_30 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_36 + var_327_30
					end
				end

				arg_324_1.text_.text = var_327_33
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_37 = math.max(var_327_31, arg_324_1.talkMaxDuration)

			if var_327_30 <= arg_324_1.time_ and arg_324_1.time_ < var_327_30 + var_327_37 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_30) / var_327_37

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_30 + var_327_37 and arg_324_1.time_ < var_327_30 + var_327_37 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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

		arg_324_1:InitPlayNodeList()
	end,
	Play122031078 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 122031078
		arg_328_1.duration_ = 10.8

		local var_328_0 = {
			ja = 10.8,
			ko = 6.233,
			zh = 6.233
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play122031079(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["10044ui_story"].transform
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 then
				arg_328_1.var_.moveOldPos10044ui_story = var_331_0.localPosition
			end

			local var_331_2 = 0.001

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2
				local var_331_4 = Vector3.New(-0.7, -0.72, -6.3)

				var_331_0.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos10044ui_story, var_331_4, var_331_3)

				local var_331_5 = manager.ui.mainCamera.transform.position - var_331_0.position

				var_331_0.forward = Vector3.New(var_331_5.x, var_331_5.y, var_331_5.z)

				local var_331_6 = var_331_0.localEulerAngles

				var_331_6.z = 0
				var_331_6.x = 0
				var_331_0.localEulerAngles = var_331_6
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 then
				var_331_0.localPosition = Vector3.New(-0.7, -0.72, -6.3)

				local var_331_7 = manager.ui.mainCamera.transform.position - var_331_0.position

				var_331_0.forward = Vector3.New(var_331_7.x, var_331_7.y, var_331_7.z)

				local var_331_8 = var_331_0.localEulerAngles

				var_331_8.z = 0
				var_331_8.x = 0
				var_331_0.localEulerAngles = var_331_8
			end

			local var_331_9 = arg_328_1.actors_["10044ui_story"]
			local var_331_10 = 0

			if var_331_10 < arg_328_1.time_ and arg_328_1.time_ <= var_331_10 + arg_331_0 and not isNil(var_331_9) and arg_328_1.var_.characterEffect10044ui_story == nil then
				arg_328_1.var_.characterEffect10044ui_story = var_331_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_11 = 0.200000002980232

			if var_331_10 <= arg_328_1.time_ and arg_328_1.time_ < var_331_10 + var_331_11 and not isNil(var_331_9) then
				local var_331_12 = (arg_328_1.time_ - var_331_10) / var_331_11

				if arg_328_1.var_.characterEffect10044ui_story and not isNil(var_331_9) then
					arg_328_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= var_331_10 + var_331_11 and arg_328_1.time_ < var_331_10 + var_331_11 + arg_331_0 and not isNil(var_331_9) and arg_328_1.var_.characterEffect10044ui_story then
				arg_328_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_331_13 = 0

			if var_331_13 < arg_328_1.time_ and arg_328_1.time_ <= var_331_13 + arg_331_0 then
				arg_328_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_331_14 = 0

			if var_331_14 < arg_328_1.time_ and arg_328_1.time_ <= var_331_14 + arg_331_0 then
				arg_328_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_331_15 = arg_328_1.actors_["1074ui_story"].transform
			local var_331_16 = 0

			if var_331_16 < arg_328_1.time_ and arg_328_1.time_ <= var_331_16 + arg_331_0 then
				arg_328_1.var_.moveOldPos1074ui_story = var_331_15.localPosition
			end

			local var_331_17 = 0.001

			if var_331_16 <= arg_328_1.time_ and arg_328_1.time_ < var_331_16 + var_331_17 then
				local var_331_18 = (arg_328_1.time_ - var_331_16) / var_331_17
				local var_331_19 = Vector3.New(0.7, -1.055, -6.12)

				var_331_15.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1074ui_story, var_331_19, var_331_18)

				local var_331_20 = manager.ui.mainCamera.transform.position - var_331_15.position

				var_331_15.forward = Vector3.New(var_331_20.x, var_331_20.y, var_331_20.z)

				local var_331_21 = var_331_15.localEulerAngles

				var_331_21.z = 0
				var_331_21.x = 0
				var_331_15.localEulerAngles = var_331_21
			end

			if arg_328_1.time_ >= var_331_16 + var_331_17 and arg_328_1.time_ < var_331_16 + var_331_17 + arg_331_0 then
				var_331_15.localPosition = Vector3.New(0.7, -1.055, -6.12)

				local var_331_22 = manager.ui.mainCamera.transform.position - var_331_15.position

				var_331_15.forward = Vector3.New(var_331_22.x, var_331_22.y, var_331_22.z)

				local var_331_23 = var_331_15.localEulerAngles

				var_331_23.z = 0
				var_331_23.x = 0
				var_331_15.localEulerAngles = var_331_23
			end

			local var_331_24 = arg_328_1.actors_["1074ui_story"]
			local var_331_25 = 0

			if var_331_25 < arg_328_1.time_ and arg_328_1.time_ <= var_331_25 + arg_331_0 and not isNil(var_331_24) and arg_328_1.var_.characterEffect1074ui_story == nil then
				arg_328_1.var_.characterEffect1074ui_story = var_331_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_26 = 0.200000002980232

			if var_331_25 <= arg_328_1.time_ and arg_328_1.time_ < var_331_25 + var_331_26 and not isNil(var_331_24) then
				local var_331_27 = (arg_328_1.time_ - var_331_25) / var_331_26

				if arg_328_1.var_.characterEffect1074ui_story and not isNil(var_331_24) then
					local var_331_28 = Mathf.Lerp(0, 0.5, var_331_27)

					arg_328_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_328_1.var_.characterEffect1074ui_story.fillRatio = var_331_28
				end
			end

			if arg_328_1.time_ >= var_331_25 + var_331_26 and arg_328_1.time_ < var_331_25 + var_331_26 + arg_331_0 and not isNil(var_331_24) and arg_328_1.var_.characterEffect1074ui_story then
				local var_331_29 = 0.5

				arg_328_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_328_1.var_.characterEffect1074ui_story.fillRatio = var_331_29
			end

			local var_331_30 = 0
			local var_331_31 = 0.775

			if var_331_30 < arg_328_1.time_ and arg_328_1.time_ <= var_331_30 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_32 = arg_328_1:FormatText(StoryNameCfg[380].name)

				arg_328_1.leftNameTxt_.text = var_331_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_33 = arg_328_1:GetWordFromCfg(122031078)
				local var_331_34 = arg_328_1:FormatText(var_331_33.content)

				arg_328_1.text_.text = var_331_34

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_35 = 31
				local var_331_36 = utf8.len(var_331_34)
				local var_331_37 = var_331_35 <= 0 and var_331_31 or var_331_31 * (var_331_36 / var_331_35)

				if var_331_37 > 0 and var_331_31 < var_331_37 then
					arg_328_1.talkMaxDuration = var_331_37

					if var_331_37 + var_331_30 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_37 + var_331_30
					end
				end

				arg_328_1.text_.text = var_331_34
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031078", "story_v_out_122031.awb") ~= 0 then
					local var_331_38 = manager.audio:GetVoiceLength("story_v_out_122031", "122031078", "story_v_out_122031.awb") / 1000

					if var_331_38 + var_331_30 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_38 + var_331_30
					end

					if var_331_33.prefab_name ~= "" and arg_328_1.actors_[var_331_33.prefab_name] ~= nil then
						local var_331_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_33.prefab_name].transform, "story_v_out_122031", "122031078", "story_v_out_122031.awb")

						arg_328_1:RecordAudio("122031078", var_331_39)
						arg_328_1:RecordAudio("122031078", var_331_39)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_122031", "122031078", "story_v_out_122031.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_122031", "122031078", "story_v_out_122031.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_40 = math.max(var_331_31, arg_328_1.talkMaxDuration)

			if var_331_30 <= arg_328_1.time_ and arg_328_1.time_ < var_331_30 + var_331_40 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_30) / var_331_40

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_30 + var_331_40 and arg_328_1.time_ < var_331_30 + var_331_40 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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

		arg_328_1:InitPlayNodeList()
	end,
	Play122031079 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 122031079
		arg_332_1.duration_ = 4.33

		local var_332_0 = {
			ja = 4.333,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play122031080(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["1074ui_story"]
			local var_335_1 = 0

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1074ui_story == nil then
				arg_332_1.var_.characterEffect1074ui_story = var_335_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_2 = 0.200000002980232

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 and not isNil(var_335_0) then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2

				if arg_332_1.var_.characterEffect1074ui_story and not isNil(var_335_0) then
					arg_332_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 and not isNil(var_335_0) and arg_332_1.var_.characterEffect1074ui_story then
				arg_332_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_335_4 = 0

			if var_335_4 < arg_332_1.time_ and arg_332_1.time_ <= var_335_4 + arg_335_0 then
				arg_332_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_335_5 = arg_332_1.actors_["10044ui_story"]
			local var_335_6 = 0

			if var_335_6 < arg_332_1.time_ and arg_332_1.time_ <= var_335_6 + arg_335_0 and not isNil(var_335_5) and arg_332_1.var_.characterEffect10044ui_story == nil then
				arg_332_1.var_.characterEffect10044ui_story = var_335_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_7 = 0.200000002980232

			if var_335_6 <= arg_332_1.time_ and arg_332_1.time_ < var_335_6 + var_335_7 and not isNil(var_335_5) then
				local var_335_8 = (arg_332_1.time_ - var_335_6) / var_335_7

				if arg_332_1.var_.characterEffect10044ui_story and not isNil(var_335_5) then
					local var_335_9 = Mathf.Lerp(0, 0.5, var_335_8)

					arg_332_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_332_1.var_.characterEffect10044ui_story.fillRatio = var_335_9
				end
			end

			if arg_332_1.time_ >= var_335_6 + var_335_7 and arg_332_1.time_ < var_335_6 + var_335_7 + arg_335_0 and not isNil(var_335_5) and arg_332_1.var_.characterEffect10044ui_story then
				local var_335_10 = 0.5

				arg_332_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_332_1.var_.characterEffect10044ui_story.fillRatio = var_335_10
			end

			local var_335_11 = 0
			local var_335_12 = 0.175

			if var_335_11 < arg_332_1.time_ and arg_332_1.time_ <= var_335_11 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				local var_335_13 = arg_332_1:FormatText(StoryNameCfg[410].name)

				arg_332_1.leftNameTxt_.text = var_335_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_14 = arg_332_1:GetWordFromCfg(122031079)
				local var_335_15 = arg_332_1:FormatText(var_335_14.content)

				arg_332_1.text_.text = var_335_15

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_16 = 7
				local var_335_17 = utf8.len(var_335_15)
				local var_335_18 = var_335_16 <= 0 and var_335_12 or var_335_12 * (var_335_17 / var_335_16)

				if var_335_18 > 0 and var_335_12 < var_335_18 then
					arg_332_1.talkMaxDuration = var_335_18

					if var_335_18 + var_335_11 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_18 + var_335_11
					end
				end

				arg_332_1.text_.text = var_335_15
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031079", "story_v_out_122031.awb") ~= 0 then
					local var_335_19 = manager.audio:GetVoiceLength("story_v_out_122031", "122031079", "story_v_out_122031.awb") / 1000

					if var_335_19 + var_335_11 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_19 + var_335_11
					end

					if var_335_14.prefab_name ~= "" and arg_332_1.actors_[var_335_14.prefab_name] ~= nil then
						local var_335_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_14.prefab_name].transform, "story_v_out_122031", "122031079", "story_v_out_122031.awb")

						arg_332_1:RecordAudio("122031079", var_335_20)
						arg_332_1:RecordAudio("122031079", var_335_20)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_122031", "122031079", "story_v_out_122031.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_122031", "122031079", "story_v_out_122031.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_21 = math.max(var_335_12, arg_332_1.talkMaxDuration)

			if var_335_11 <= arg_332_1.time_ and arg_332_1.time_ < var_335_11 + var_335_21 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_11) / var_335_21

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_11 + var_335_21 and arg_332_1.time_ < var_335_11 + var_335_21 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play122031080 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 122031080
		arg_336_1.duration_ = 2.77

		local var_336_0 = {
			ja = 2.766,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play122031081(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = arg_336_1.actors_["10044ui_story"]
			local var_339_1 = 0

			if var_339_1 < arg_336_1.time_ and arg_336_1.time_ <= var_339_1 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect10044ui_story == nil then
				arg_336_1.var_.characterEffect10044ui_story = var_339_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_2 = 0.200000002980232

			if var_339_1 <= arg_336_1.time_ and arg_336_1.time_ < var_339_1 + var_339_2 and not isNil(var_339_0) then
				local var_339_3 = (arg_336_1.time_ - var_339_1) / var_339_2

				if arg_336_1.var_.characterEffect10044ui_story and not isNil(var_339_0) then
					arg_336_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= var_339_1 + var_339_2 and arg_336_1.time_ < var_339_1 + var_339_2 + arg_339_0 and not isNil(var_339_0) and arg_336_1.var_.characterEffect10044ui_story then
				arg_336_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_339_4 = 0

			if var_339_4 < arg_336_1.time_ and arg_336_1.time_ <= var_339_4 + arg_339_0 then
				arg_336_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action1_1")
			end

			local var_339_5 = 0

			if var_339_5 < arg_336_1.time_ and arg_336_1.time_ <= var_339_5 + arg_339_0 then
				arg_336_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_339_6 = arg_336_1.actors_["1074ui_story"]
			local var_339_7 = 0

			if var_339_7 < arg_336_1.time_ and arg_336_1.time_ <= var_339_7 + arg_339_0 and not isNil(var_339_6) and arg_336_1.var_.characterEffect1074ui_story == nil then
				arg_336_1.var_.characterEffect1074ui_story = var_339_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_8 = 0.200000002980232

			if var_339_7 <= arg_336_1.time_ and arg_336_1.time_ < var_339_7 + var_339_8 and not isNil(var_339_6) then
				local var_339_9 = (arg_336_1.time_ - var_339_7) / var_339_8

				if arg_336_1.var_.characterEffect1074ui_story and not isNil(var_339_6) then
					local var_339_10 = Mathf.Lerp(0, 0.5, var_339_9)

					arg_336_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_336_1.var_.characterEffect1074ui_story.fillRatio = var_339_10
				end
			end

			if arg_336_1.time_ >= var_339_7 + var_339_8 and arg_336_1.time_ < var_339_7 + var_339_8 + arg_339_0 and not isNil(var_339_6) and arg_336_1.var_.characterEffect1074ui_story then
				local var_339_11 = 0.5

				arg_336_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_336_1.var_.characterEffect1074ui_story.fillRatio = var_339_11
			end

			local var_339_12 = 0
			local var_339_13 = 0.1

			if var_339_12 < arg_336_1.time_ and arg_336_1.time_ <= var_339_12 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				local var_339_14 = arg_336_1:FormatText(StoryNameCfg[380].name)

				arg_336_1.leftNameTxt_.text = var_339_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_15 = arg_336_1:GetWordFromCfg(122031080)
				local var_339_16 = arg_336_1:FormatText(var_339_15.content)

				arg_336_1.text_.text = var_339_16

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_17 = 4
				local var_339_18 = utf8.len(var_339_16)
				local var_339_19 = var_339_17 <= 0 and var_339_13 or var_339_13 * (var_339_18 / var_339_17)

				if var_339_19 > 0 and var_339_13 < var_339_19 then
					arg_336_1.talkMaxDuration = var_339_19

					if var_339_19 + var_339_12 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_19 + var_339_12
					end
				end

				arg_336_1.text_.text = var_339_16
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031080", "story_v_out_122031.awb") ~= 0 then
					local var_339_20 = manager.audio:GetVoiceLength("story_v_out_122031", "122031080", "story_v_out_122031.awb") / 1000

					if var_339_20 + var_339_12 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_20 + var_339_12
					end

					if var_339_15.prefab_name ~= "" and arg_336_1.actors_[var_339_15.prefab_name] ~= nil then
						local var_339_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_15.prefab_name].transform, "story_v_out_122031", "122031080", "story_v_out_122031.awb")

						arg_336_1:RecordAudio("122031080", var_339_21)
						arg_336_1:RecordAudio("122031080", var_339_21)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_122031", "122031080", "story_v_out_122031.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_122031", "122031080", "story_v_out_122031.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_22 = math.max(var_339_13, arg_336_1.talkMaxDuration)

			if var_339_12 <= arg_336_1.time_ and arg_336_1.time_ < var_339_12 + var_339_22 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_12) / var_339_22

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_12 + var_339_22 and arg_336_1.time_ < var_339_12 + var_339_22 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play122031081 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 122031081
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play122031082(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = arg_340_1.actors_["10044ui_story"].transform
			local var_343_1 = 0

			if var_343_1 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1.var_.moveOldPos10044ui_story = var_343_0.localPosition
			end

			local var_343_2 = 0.001

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_2 then
				local var_343_3 = (arg_340_1.time_ - var_343_1) / var_343_2
				local var_343_4 = Vector3.New(0, 100, 0)

				var_343_0.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos10044ui_story, var_343_4, var_343_3)

				local var_343_5 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_5.x, var_343_5.y, var_343_5.z)

				local var_343_6 = var_343_0.localEulerAngles

				var_343_6.z = 0
				var_343_6.x = 0
				var_343_0.localEulerAngles = var_343_6
			end

			if arg_340_1.time_ >= var_343_1 + var_343_2 and arg_340_1.time_ < var_343_1 + var_343_2 + arg_343_0 then
				var_343_0.localPosition = Vector3.New(0, 100, 0)

				local var_343_7 = manager.ui.mainCamera.transform.position - var_343_0.position

				var_343_0.forward = Vector3.New(var_343_7.x, var_343_7.y, var_343_7.z)

				local var_343_8 = var_343_0.localEulerAngles

				var_343_8.z = 0
				var_343_8.x = 0
				var_343_0.localEulerAngles = var_343_8
			end

			local var_343_9 = arg_340_1.actors_["10044ui_story"]
			local var_343_10 = 0

			if var_343_10 < arg_340_1.time_ and arg_340_1.time_ <= var_343_10 + arg_343_0 and not isNil(var_343_9) and arg_340_1.var_.characterEffect10044ui_story == nil then
				arg_340_1.var_.characterEffect10044ui_story = var_343_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_11 = 0.200000002980232

			if var_343_10 <= arg_340_1.time_ and arg_340_1.time_ < var_343_10 + var_343_11 and not isNil(var_343_9) then
				local var_343_12 = (arg_340_1.time_ - var_343_10) / var_343_11

				if arg_340_1.var_.characterEffect10044ui_story and not isNil(var_343_9) then
					local var_343_13 = Mathf.Lerp(0, 0.5, var_343_12)

					arg_340_1.var_.characterEffect10044ui_story.fillFlat = true
					arg_340_1.var_.characterEffect10044ui_story.fillRatio = var_343_13
				end
			end

			if arg_340_1.time_ >= var_343_10 + var_343_11 and arg_340_1.time_ < var_343_10 + var_343_11 + arg_343_0 and not isNil(var_343_9) and arg_340_1.var_.characterEffect10044ui_story then
				local var_343_14 = 0.5

				arg_340_1.var_.characterEffect10044ui_story.fillFlat = true
				arg_340_1.var_.characterEffect10044ui_story.fillRatio = var_343_14
			end

			local var_343_15 = arg_340_1.actors_["1074ui_story"].transform
			local var_343_16 = 0

			if var_343_16 < arg_340_1.time_ and arg_340_1.time_ <= var_343_16 + arg_343_0 then
				arg_340_1.var_.moveOldPos1074ui_story = var_343_15.localPosition
			end

			local var_343_17 = 0.001

			if var_343_16 <= arg_340_1.time_ and arg_340_1.time_ < var_343_16 + var_343_17 then
				local var_343_18 = (arg_340_1.time_ - var_343_16) / var_343_17
				local var_343_19 = Vector3.New(0, 100, 0)

				var_343_15.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos1074ui_story, var_343_19, var_343_18)

				local var_343_20 = manager.ui.mainCamera.transform.position - var_343_15.position

				var_343_15.forward = Vector3.New(var_343_20.x, var_343_20.y, var_343_20.z)

				local var_343_21 = var_343_15.localEulerAngles

				var_343_21.z = 0
				var_343_21.x = 0
				var_343_15.localEulerAngles = var_343_21
			end

			if arg_340_1.time_ >= var_343_16 + var_343_17 and arg_340_1.time_ < var_343_16 + var_343_17 + arg_343_0 then
				var_343_15.localPosition = Vector3.New(0, 100, 0)

				local var_343_22 = manager.ui.mainCamera.transform.position - var_343_15.position

				var_343_15.forward = Vector3.New(var_343_22.x, var_343_22.y, var_343_22.z)

				local var_343_23 = var_343_15.localEulerAngles

				var_343_23.z = 0
				var_343_23.x = 0
				var_343_15.localEulerAngles = var_343_23
			end

			local var_343_24 = arg_340_1.actors_["1074ui_story"]
			local var_343_25 = 0

			if var_343_25 < arg_340_1.time_ and arg_340_1.time_ <= var_343_25 + arg_343_0 and not isNil(var_343_24) and arg_340_1.var_.characterEffect1074ui_story == nil then
				arg_340_1.var_.characterEffect1074ui_story = var_343_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_26 = 0.200000002980232

			if var_343_25 <= arg_340_1.time_ and arg_340_1.time_ < var_343_25 + var_343_26 and not isNil(var_343_24) then
				local var_343_27 = (arg_340_1.time_ - var_343_25) / var_343_26

				if arg_340_1.var_.characterEffect1074ui_story and not isNil(var_343_24) then
					local var_343_28 = Mathf.Lerp(0, 0.5, var_343_27)

					arg_340_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1074ui_story.fillRatio = var_343_28
				end
			end

			if arg_340_1.time_ >= var_343_25 + var_343_26 and arg_340_1.time_ < var_343_25 + var_343_26 + arg_343_0 and not isNil(var_343_24) and arg_340_1.var_.characterEffect1074ui_story then
				local var_343_29 = 0.5

				arg_340_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1074ui_story.fillRatio = var_343_29
			end

			local var_343_30 = 0
			local var_343_31 = 0.675

			if var_343_30 < arg_340_1.time_ and arg_340_1.time_ <= var_343_30 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_32 = arg_340_1:GetWordFromCfg(122031081)
				local var_343_33 = arg_340_1:FormatText(var_343_32.content)

				arg_340_1.text_.text = var_343_33

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_34 = 27
				local var_343_35 = utf8.len(var_343_33)
				local var_343_36 = var_343_34 <= 0 and var_343_31 or var_343_31 * (var_343_35 / var_343_34)

				if var_343_36 > 0 and var_343_31 < var_343_36 then
					arg_340_1.talkMaxDuration = var_343_36

					if var_343_36 + var_343_30 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_36 + var_343_30
					end
				end

				arg_340_1.text_.text = var_343_33
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_37 = math.max(var_343_31, arg_340_1.talkMaxDuration)

			if var_343_30 <= arg_340_1.time_ and arg_340_1.time_ < var_343_30 + var_343_37 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_30) / var_343_37

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_30 + var_343_37 and arg_340_1.time_ < var_343_30 + var_343_37 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10044ui_story",
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

		arg_340_1:InitPlayNodeList()
	end,
	Play122031082 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 122031082
		arg_344_1.duration_ = 10.4

		local var_344_0 = {
			ja = 10.4,
			ko = 8.2,
			zh = 8.2
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play122031083(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = arg_344_1.actors_["1074ui_story"].transform
			local var_347_1 = 0

			if var_347_1 < arg_344_1.time_ and arg_344_1.time_ <= var_347_1 + arg_347_0 then
				arg_344_1.var_.moveOldPos1074ui_story = var_347_0.localPosition
			end

			local var_347_2 = 0.001

			if var_347_1 <= arg_344_1.time_ and arg_344_1.time_ < var_347_1 + var_347_2 then
				local var_347_3 = (arg_344_1.time_ - var_347_1) / var_347_2
				local var_347_4 = Vector3.New(0, -1.055, -6.12)

				var_347_0.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos1074ui_story, var_347_4, var_347_3)

				local var_347_5 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_5.x, var_347_5.y, var_347_5.z)

				local var_347_6 = var_347_0.localEulerAngles

				var_347_6.z = 0
				var_347_6.x = 0
				var_347_0.localEulerAngles = var_347_6
			end

			if arg_344_1.time_ >= var_347_1 + var_347_2 and arg_344_1.time_ < var_347_1 + var_347_2 + arg_347_0 then
				var_347_0.localPosition = Vector3.New(0, -1.055, -6.12)

				local var_347_7 = manager.ui.mainCamera.transform.position - var_347_0.position

				var_347_0.forward = Vector3.New(var_347_7.x, var_347_7.y, var_347_7.z)

				local var_347_8 = var_347_0.localEulerAngles

				var_347_8.z = 0
				var_347_8.x = 0
				var_347_0.localEulerAngles = var_347_8
			end

			local var_347_9 = arg_344_1.actors_["1074ui_story"]
			local var_347_10 = 0

			if var_347_10 < arg_344_1.time_ and arg_344_1.time_ <= var_347_10 + arg_347_0 and not isNil(var_347_9) and arg_344_1.var_.characterEffect1074ui_story == nil then
				arg_344_1.var_.characterEffect1074ui_story = var_347_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_11 = 0.200000002980232

			if var_347_10 <= arg_344_1.time_ and arg_344_1.time_ < var_347_10 + var_347_11 and not isNil(var_347_9) then
				local var_347_12 = (arg_344_1.time_ - var_347_10) / var_347_11

				if arg_344_1.var_.characterEffect1074ui_story and not isNil(var_347_9) then
					arg_344_1.var_.characterEffect1074ui_story.fillFlat = false
				end
			end

			if arg_344_1.time_ >= var_347_10 + var_347_11 and arg_344_1.time_ < var_347_10 + var_347_11 + arg_347_0 and not isNil(var_347_9) and arg_344_1.var_.characterEffect1074ui_story then
				arg_344_1.var_.characterEffect1074ui_story.fillFlat = false
			end

			local var_347_13 = 0

			if var_347_13 < arg_344_1.time_ and arg_344_1.time_ <= var_347_13 + arg_347_0 then
				arg_344_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/story1074/story1074action/1074action5_2")
			end

			local var_347_14 = 0

			if var_347_14 < arg_344_1.time_ and arg_344_1.time_ <= var_347_14 + arg_347_0 then
				arg_344_1:PlayTimeline("1074ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_347_15 = 0
			local var_347_16 = 1.1

			if var_347_15 < arg_344_1.time_ and arg_344_1.time_ <= var_347_15 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				local var_347_17 = arg_344_1:FormatText(StoryNameCfg[410].name)

				arg_344_1.leftNameTxt_.text = var_347_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_18 = arg_344_1:GetWordFromCfg(122031082)
				local var_347_19 = arg_344_1:FormatText(var_347_18.content)

				arg_344_1.text_.text = var_347_19

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_20 = 44
				local var_347_21 = utf8.len(var_347_19)
				local var_347_22 = var_347_20 <= 0 and var_347_16 or var_347_16 * (var_347_21 / var_347_20)

				if var_347_22 > 0 and var_347_16 < var_347_22 then
					arg_344_1.talkMaxDuration = var_347_22

					if var_347_22 + var_347_15 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_22 + var_347_15
					end
				end

				arg_344_1.text_.text = var_347_19
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031082", "story_v_out_122031.awb") ~= 0 then
					local var_347_23 = manager.audio:GetVoiceLength("story_v_out_122031", "122031082", "story_v_out_122031.awb") / 1000

					if var_347_23 + var_347_15 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_23 + var_347_15
					end

					if var_347_18.prefab_name ~= "" and arg_344_1.actors_[var_347_18.prefab_name] ~= nil then
						local var_347_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_18.prefab_name].transform, "story_v_out_122031", "122031082", "story_v_out_122031.awb")

						arg_344_1:RecordAudio("122031082", var_347_24)
						arg_344_1:RecordAudio("122031082", var_347_24)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_122031", "122031082", "story_v_out_122031.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_122031", "122031082", "story_v_out_122031.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_25 = math.max(var_347_16, arg_344_1.talkMaxDuration)

			if var_347_15 <= arg_344_1.time_ and arg_344_1.time_ < var_347_15 + var_347_25 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_15) / var_347_25

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_15 + var_347_25 and arg_344_1.time_ < var_347_15 + var_347_25 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
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

		arg_344_1:InitPlayNodeList()
	end,
	Play122031083 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 122031083
		arg_348_1.duration_ = 6.2

		local var_348_0 = {
			ja = 6.2,
			ko = 3.7,
			zh = 3.7
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play122031084(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0
			local var_351_1 = 0.5

			if var_351_0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				local var_351_2 = arg_348_1:FormatText(StoryNameCfg[410].name)

				arg_348_1.leftNameTxt_.text = var_351_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_3 = arg_348_1:GetWordFromCfg(122031083)
				local var_351_4 = arg_348_1:FormatText(var_351_3.content)

				arg_348_1.text_.text = var_351_4

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_5 = 20
				local var_351_6 = utf8.len(var_351_4)
				local var_351_7 = var_351_5 <= 0 and var_351_1 or var_351_1 * (var_351_6 / var_351_5)

				if var_351_7 > 0 and var_351_1 < var_351_7 then
					arg_348_1.talkMaxDuration = var_351_7

					if var_351_7 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_7 + var_351_0
					end
				end

				arg_348_1.text_.text = var_351_4
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031083", "story_v_out_122031.awb") ~= 0 then
					local var_351_8 = manager.audio:GetVoiceLength("story_v_out_122031", "122031083", "story_v_out_122031.awb") / 1000

					if var_351_8 + var_351_0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_8 + var_351_0
					end

					if var_351_3.prefab_name ~= "" and arg_348_1.actors_[var_351_3.prefab_name] ~= nil then
						local var_351_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_3.prefab_name].transform, "story_v_out_122031", "122031083", "story_v_out_122031.awb")

						arg_348_1:RecordAudio("122031083", var_351_9)
						arg_348_1:RecordAudio("122031083", var_351_9)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_122031", "122031083", "story_v_out_122031.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_122031", "122031083", "story_v_out_122031.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_10 = math.max(var_351_1, arg_348_1.talkMaxDuration)

			if var_351_0 <= arg_348_1.time_ and arg_348_1.time_ < var_351_0 + var_351_10 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_0) / var_351_10

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_0 + var_351_10 and arg_348_1.time_ < var_351_0 + var_351_10 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play122031084 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 122031084
		arg_352_1.duration_ = 4.53

		local var_352_0 = {
			ja = 4.533,
			ko = 1.999999999999,
			zh = 1.999999999999
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
			arg_352_1.auto_ = false
		end

		function arg_352_1.playNext_(arg_354_0)
			arg_352_1.onStoryFinished_()
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = arg_352_1.actors_["1074ui_story"].transform
			local var_355_1 = 0

			if var_355_1 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.var_.moveOldPos1074ui_story = var_355_0.localPosition
			end

			local var_355_2 = 0.001

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_2 then
				local var_355_3 = (arg_352_1.time_ - var_355_1) / var_355_2
				local var_355_4 = Vector3.New(0, 100, 0)

				var_355_0.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos1074ui_story, var_355_4, var_355_3)

				local var_355_5 = manager.ui.mainCamera.transform.position - var_355_0.position

				var_355_0.forward = Vector3.New(var_355_5.x, var_355_5.y, var_355_5.z)

				local var_355_6 = var_355_0.localEulerAngles

				var_355_6.z = 0
				var_355_6.x = 0
				var_355_0.localEulerAngles = var_355_6
			end

			if arg_352_1.time_ >= var_355_1 + var_355_2 and arg_352_1.time_ < var_355_1 + var_355_2 + arg_355_0 then
				var_355_0.localPosition = Vector3.New(0, 100, 0)

				local var_355_7 = manager.ui.mainCamera.transform.position - var_355_0.position

				var_355_0.forward = Vector3.New(var_355_7.x, var_355_7.y, var_355_7.z)

				local var_355_8 = var_355_0.localEulerAngles

				var_355_8.z = 0
				var_355_8.x = 0
				var_355_0.localEulerAngles = var_355_8
			end

			local var_355_9 = arg_352_1.actors_["1074ui_story"]
			local var_355_10 = 0

			if var_355_10 < arg_352_1.time_ and arg_352_1.time_ <= var_355_10 + arg_355_0 and not isNil(var_355_9) and arg_352_1.var_.characterEffect1074ui_story == nil then
				arg_352_1.var_.characterEffect1074ui_story = var_355_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_11 = 0.200000002980232

			if var_355_10 <= arg_352_1.time_ and arg_352_1.time_ < var_355_10 + var_355_11 and not isNil(var_355_9) then
				local var_355_12 = (arg_352_1.time_ - var_355_10) / var_355_11

				if arg_352_1.var_.characterEffect1074ui_story and not isNil(var_355_9) then
					local var_355_13 = Mathf.Lerp(0, 0.5, var_355_12)

					arg_352_1.var_.characterEffect1074ui_story.fillFlat = true
					arg_352_1.var_.characterEffect1074ui_story.fillRatio = var_355_13
				end
			end

			if arg_352_1.time_ >= var_355_10 + var_355_11 and arg_352_1.time_ < var_355_10 + var_355_11 + arg_355_0 and not isNil(var_355_9) and arg_352_1.var_.characterEffect1074ui_story then
				local var_355_14 = 0.5

				arg_352_1.var_.characterEffect1074ui_story.fillFlat = true
				arg_352_1.var_.characterEffect1074ui_story.fillRatio = var_355_14
			end

			local var_355_15 = arg_352_1.actors_["10044ui_story"].transform
			local var_355_16 = 0

			if var_355_16 < arg_352_1.time_ and arg_352_1.time_ <= var_355_16 + arg_355_0 then
				arg_352_1.var_.moveOldPos10044ui_story = var_355_15.localPosition
			end

			local var_355_17 = 0.001

			if var_355_16 <= arg_352_1.time_ and arg_352_1.time_ < var_355_16 + var_355_17 then
				local var_355_18 = (arg_352_1.time_ - var_355_16) / var_355_17
				local var_355_19 = Vector3.New(0, -0.72, -6.3)

				var_355_15.localPosition = Vector3.Lerp(arg_352_1.var_.moveOldPos10044ui_story, var_355_19, var_355_18)

				local var_355_20 = manager.ui.mainCamera.transform.position - var_355_15.position

				var_355_15.forward = Vector3.New(var_355_20.x, var_355_20.y, var_355_20.z)

				local var_355_21 = var_355_15.localEulerAngles

				var_355_21.z = 0
				var_355_21.x = 0
				var_355_15.localEulerAngles = var_355_21
			end

			if arg_352_1.time_ >= var_355_16 + var_355_17 and arg_352_1.time_ < var_355_16 + var_355_17 + arg_355_0 then
				var_355_15.localPosition = Vector3.New(0, -0.72, -6.3)

				local var_355_22 = manager.ui.mainCamera.transform.position - var_355_15.position

				var_355_15.forward = Vector3.New(var_355_22.x, var_355_22.y, var_355_22.z)

				local var_355_23 = var_355_15.localEulerAngles

				var_355_23.z = 0
				var_355_23.x = 0
				var_355_15.localEulerAngles = var_355_23
			end

			local var_355_24 = arg_352_1.actors_["10044ui_story"]
			local var_355_25 = 0

			if var_355_25 < arg_352_1.time_ and arg_352_1.time_ <= var_355_25 + arg_355_0 and not isNil(var_355_24) and arg_352_1.var_.characterEffect10044ui_story == nil then
				arg_352_1.var_.characterEffect10044ui_story = var_355_24:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_355_26 = 0.200000002980232

			if var_355_25 <= arg_352_1.time_ and arg_352_1.time_ < var_355_25 + var_355_26 and not isNil(var_355_24) then
				local var_355_27 = (arg_352_1.time_ - var_355_25) / var_355_26

				if arg_352_1.var_.characterEffect10044ui_story and not isNil(var_355_24) then
					arg_352_1.var_.characterEffect10044ui_story.fillFlat = false
				end
			end

			if arg_352_1.time_ >= var_355_25 + var_355_26 and arg_352_1.time_ < var_355_25 + var_355_26 + arg_355_0 and not isNil(var_355_24) and arg_352_1.var_.characterEffect10044ui_story then
				arg_352_1.var_.characterEffect10044ui_story.fillFlat = false
			end

			local var_355_28 = 0

			if var_355_28 < arg_352_1.time_ and arg_352_1.time_ <= var_355_28 + arg_355_0 then
				arg_352_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/story10044/story10044action/10044action3_1")
			end

			local var_355_29 = 0

			if var_355_29 < arg_352_1.time_ and arg_352_1.time_ <= var_355_29 + arg_355_0 then
				arg_352_1:PlayTimeline("10044ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_355_30 = 0
			local var_355_31 = 0.125

			if var_355_30 < arg_352_1.time_ and arg_352_1.time_ <= var_355_30 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				local var_355_32 = arg_352_1:FormatText(StoryNameCfg[380].name)

				arg_352_1.leftNameTxt_.text = var_355_32

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_33 = arg_352_1:GetWordFromCfg(122031084)
				local var_355_34 = arg_352_1:FormatText(var_355_33.content)

				arg_352_1.text_.text = var_355_34

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_35 = 5
				local var_355_36 = utf8.len(var_355_34)
				local var_355_37 = var_355_35 <= 0 and var_355_31 or var_355_31 * (var_355_36 / var_355_35)

				if var_355_37 > 0 and var_355_31 < var_355_37 then
					arg_352_1.talkMaxDuration = var_355_37

					if var_355_37 + var_355_30 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_37 + var_355_30
					end
				end

				arg_352_1.text_.text = var_355_34
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122031", "122031084", "story_v_out_122031.awb") ~= 0 then
					local var_355_38 = manager.audio:GetVoiceLength("story_v_out_122031", "122031084", "story_v_out_122031.awb") / 1000

					if var_355_38 + var_355_30 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_38 + var_355_30
					end

					if var_355_33.prefab_name ~= "" and arg_352_1.actors_[var_355_33.prefab_name] ~= nil then
						local var_355_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_33.prefab_name].transform, "story_v_out_122031", "122031084", "story_v_out_122031.awb")

						arg_352_1:RecordAudio("122031084", var_355_39)
						arg_352_1:RecordAudio("122031084", var_355_39)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_122031", "122031084", "story_v_out_122031.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_122031", "122031084", "story_v_out_122031.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_40 = math.max(var_355_31, arg_352_1.talkMaxDuration)

			if var_355_30 <= arg_352_1.time_ and arg_352_1.time_ < var_355_30 + var_355_40 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_30) / var_355_40

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_30 + var_355_40 and arg_352_1.time_ < var_355_30 + var_355_40 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {
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
				actorName = "10044ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_352_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST29a",
		"TextureConfig/Background/ST37a"
	},
	voices = {
		"story_v_out_122031.awb"
	}
}
