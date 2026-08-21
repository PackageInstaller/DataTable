return {
	Play116061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116061001
		arg_1_1.duration_ = 8.13

		local var_1_0 = {
			zh = 6.833,
			ja = 8.133
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
				arg_1_0:Play116061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "I05"

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
				if arg_1_0.sceneSettingEffect_ then
					arg_1_1.sceneSettingEffect_.enabled = false
				end

				arg_1_1.sceneSettingGo_:SetActive(true)

				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.I05

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
					if iter_4_0 ~= "I05" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = "10025ui_story"

			if arg_1_1.actors_[var_4_16] == nil then
				local var_4_17 = Asset.Load("Char/" .. "10025ui_story")

				if not isNil(var_4_17) then
					local var_4_18 = Object.Instantiate(Asset.Load("Char/" .. "10025ui_story"), arg_1_1.stage_.transform)

					var_4_18.name = var_4_16
					var_4_18.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_16] = var_4_18

					local var_4_19 = var_4_18:GetComponentInChildren(typeof(CharacterEffect))

					var_4_19.enabled = true

					local var_4_20 = GameObjectTools.GetOrAddComponent(var_4_18, typeof(DynamicBoneHelper))

					if var_4_20 then
						var_4_20:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_19.transform, false)

					arg_1_1.var_[var_4_16 .. "Animator"] = var_4_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_16 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_16 .. "LipSync"] = var_4_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_21 = arg_1_1.actors_["10025ui_story"].transform
			local var_4_22 = 2

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.var_.moveOldPos10025ui_story = var_4_21.localPosition
			end

			local var_4_23 = 0.001

			if var_4_22 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				local var_4_24 = (arg_1_1.time_ - var_4_22) / var_4_23
				local var_4_25 = Vector3.New(0, -1.1, -5.9)

				var_4_21.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10025ui_story, var_4_25, var_4_24)

				local var_4_26 = manager.ui.mainCamera.transform.position - var_4_21.position

				var_4_21.forward = Vector3.New(var_4_26.x, var_4_26.y, var_4_26.z)

				local var_4_27 = var_4_21.localEulerAngles

				var_4_27.z = 0
				var_4_27.x = 0
				var_4_21.localEulerAngles = var_4_27
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				var_4_21.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_4_28 = manager.ui.mainCamera.transform.position - var_4_21.position

				var_4_21.forward = Vector3.New(var_4_28.x, var_4_28.y, var_4_28.z)

				local var_4_29 = var_4_21.localEulerAngles

				var_4_29.z = 0
				var_4_29.x = 0
				var_4_21.localEulerAngles = var_4_29
			end

			local var_4_30 = arg_1_1.actors_["10025ui_story"]
			local var_4_31 = 2

			if var_4_31 < arg_1_1.time_ and arg_1_1.time_ <= var_4_31 + arg_4_0 and not isNil(var_4_30) and arg_1_1.var_.characterEffect10025ui_story == nil then
				arg_1_1.var_.characterEffect10025ui_story = var_4_30:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_32 = 0.2

			if var_4_31 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 and not isNil(var_4_30) then
				local var_4_33 = (arg_1_1.time_ - var_4_31) / var_4_32

				if arg_1_1.var_.characterEffect10025ui_story and not isNil(var_4_30) then
					arg_1_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 and not isNil(var_4_30) and arg_1_1.var_.characterEffect10025ui_story then
				arg_1_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_4_34 = 0

			if var_4_34 < arg_1_1.time_ and arg_1_1.time_ <= var_4_34 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_35 = 2

			if var_4_34 <= arg_1_1.time_ and arg_1_1.time_ < var_4_34 + var_4_35 then
				local var_4_36 = (arg_1_1.time_ - var_4_34) / var_4_35
				local var_4_37 = Color.New(0, 0, 0)

				var_4_37.a = Mathf.Lerp(1, 0, var_4_36)
				arg_1_1.mask_.color = var_4_37
			end

			if arg_1_1.time_ >= var_4_34 + var_4_35 and arg_1_1.time_ < var_4_34 + var_4_35 + arg_4_0 then
				local var_4_38 = Color.New(0, 0, 0)
				local var_4_39 = 0

				arg_1_1.mask_.enabled = false
				var_4_38.a = var_4_39
				arg_1_1.mask_.color = var_4_38
			end

			local var_4_40 = 2

			if var_4_40 < arg_1_1.time_ and arg_1_1.time_ <= var_4_40 + arg_4_0 then
				arg_1_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_1")
			end

			local var_4_41 = 2

			if var_4_41 < arg_1_1.time_ and arg_1_1.time_ <= var_4_41 + arg_4_0 then
				arg_1_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_4_42 = 0
			local var_4_43 = 1

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

			local var_4_48 = 2
			local var_4_49 = 1.5

			if var_4_48 < arg_1_1.time_ and arg_1_1.time_ <= var_4_48 + arg_4_0 then
				local var_4_50 = "play"
				local var_4_51 = "music"

				arg_1_1:AudioAction(var_4_50, var_4_51, "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")

				local var_4_52 = ""

				if var_4_52 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_52 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_52

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_52
						arg_1_1.bgmTxt2_.text = var_4_52
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

			local var_4_53 = 2.2
			local var_4_54 = 0.733333333333333

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				local var_4_55 = "play"
				local var_4_56 = "music"

				arg_1_1:AudioAction(var_4_55, var_4_56, "bgm_activity_1_6_story_story", "dialog_init", "bgm_activity_1_6_story_story.awb")

				local var_4_57 = ""
				local var_4_58 = MusicRecordCfg[95].musicName

				if var_4_58 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_58 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_58

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_58
						arg_1_1.bgmTxt2_.text = var_4_58
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

			local var_4_59 = 2
			local var_4_60 = 0.525

			if var_4_59 < arg_1_1.time_ and arg_1_1.time_ <= var_4_59 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				local var_4_61 = arg_1_1:FormatText(StoryNameCfg[328].name)

				arg_1_1.leftNameTxt_.text = var_4_61

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_62 = arg_1_1:GetWordFromCfg(116061001)
				local var_4_63 = arg_1_1:FormatText(var_4_62.content)

				arg_1_1.text_.text = var_4_63

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_64 = 21
				local var_4_65 = utf8.len(var_4_63)
				local var_4_66 = var_4_64 <= 0 and var_4_60 or var_4_60 * (var_4_65 / var_4_64)

				if var_4_66 > 0 and var_4_60 < var_4_66 then
					arg_1_1.talkMaxDuration = var_4_66

					if var_4_66 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_66 + var_4_59
					end
				end

				arg_1_1.text_.text = var_4_63
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061001", "story_v_out_116061.awb") ~= 0 then
					local var_4_67 = manager.audio:GetVoiceLength("story_v_out_116061", "116061001", "story_v_out_116061.awb") / 1000

					if var_4_67 + var_4_59 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_67 + var_4_59
					end

					if var_4_62.prefab_name ~= "" and arg_1_1.actors_[var_4_62.prefab_name] ~= nil then
						local var_4_68 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_62.prefab_name].transform, "story_v_out_116061", "116061001", "story_v_out_116061.awb")

						arg_1_1:RecordAudio("116061001", var_4_68)
						arg_1_1:RecordAudio("116061001", var_4_68)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_116061", "116061001", "story_v_out_116061.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_116061", "116061001", "story_v_out_116061.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_69 = math.max(var_4_60, arg_1_1.talkMaxDuration)

			if var_4_59 <= arg_1_1.time_ and arg_1_1.time_ < var_4_59 + var_4_69 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_59) / var_4_69

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_59 + var_4_69 and arg_1_1.time_ < var_4_59 + var_4_69 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play116061002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 116061002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play116061003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = arg_8_1.actors_["10025ui_story"]
			local var_11_1 = 0

			if var_11_1 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect10025ui_story == nil then
				arg_8_1.var_.characterEffect10025ui_story = var_11_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.2

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_2 and not isNil(var_11_0) then
				local var_11_3 = (arg_8_1.time_ - var_11_1) / var_11_2

				if arg_8_1.var_.characterEffect10025ui_story and not isNil(var_11_0) then
					local var_11_4 = Mathf.Lerp(0, 0.5, var_11_3)

					arg_8_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_8_1.var_.characterEffect10025ui_story.fillRatio = var_11_4
				end
			end

			if arg_8_1.time_ >= var_11_1 + var_11_2 and arg_8_1.time_ < var_11_1 + var_11_2 + arg_11_0 and not isNil(var_11_0) and arg_8_1.var_.characterEffect10025ui_story then
				local var_11_5 = 0.5

				arg_8_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_8_1.var_.characterEffect10025ui_story.fillRatio = var_11_5
			end

			local var_11_6 = 0
			local var_11_7 = 0.5

			if var_11_6 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				local var_11_8 = arg_8_1:FormatText(StoryNameCfg[7].name)

				arg_8_1.leftNameTxt_.text = var_11_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_9 = arg_8_1:GetWordFromCfg(116061002)
				local var_11_10 = arg_8_1:FormatText(var_11_9.content)

				arg_8_1.text_.text = var_11_10

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_11 = 20
				local var_11_12 = utf8.len(var_11_10)
				local var_11_13 = var_11_11 <= 0 and var_11_7 or var_11_7 * (var_11_12 / var_11_11)

				if var_11_13 > 0 and var_11_7 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_6
					end
				end

				arg_8_1.text_.text = var_11_10
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_14 = math.max(var_11_7, arg_8_1.talkMaxDuration)

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_14 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_6) / var_11_14

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_6 + var_11_14 and arg_8_1.time_ < var_11_6 + var_11_14 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play116061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 116061003
		arg_12_1.duration_ = 6.8

		local var_12_0 = {
			zh = 6,
			ja = 6.8
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play116061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = arg_12_1.actors_["10025ui_story"]
			local var_15_1 = 0

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect10025ui_story == nil then
				arg_12_1.var_.characterEffect10025ui_story = var_15_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_2 = 0.2

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_2 and not isNil(var_15_0) then
				local var_15_3 = (arg_12_1.time_ - var_15_1) / var_15_2

				if arg_12_1.var_.characterEffect10025ui_story and not isNil(var_15_0) then
					arg_12_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= var_15_1 + var_15_2 and arg_12_1.time_ < var_15_1 + var_15_2 + arg_15_0 and not isNil(var_15_0) and arg_12_1.var_.characterEffect10025ui_story then
				arg_12_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_15_4 = 0

			if var_15_4 < arg_12_1.time_ and arg_12_1.time_ <= var_15_4 + arg_15_0 then
				arg_12_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_2")
			end

			local var_15_5 = 0

			if var_15_5 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_15_6 = 0
			local var_15_7 = 0.55

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_8 = arg_12_1:FormatText(StoryNameCfg[328].name)

				arg_12_1.leftNameTxt_.text = var_15_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_9 = arg_12_1:GetWordFromCfg(116061003)
				local var_15_10 = arg_12_1:FormatText(var_15_9.content)

				arg_12_1.text_.text = var_15_10

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 22
				local var_15_12 = utf8.len(var_15_10)
				local var_15_13 = var_15_11 <= 0 and var_15_7 or var_15_7 * (var_15_12 / var_15_11)

				if var_15_13 > 0 and var_15_7 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_10
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061003", "story_v_out_116061.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061003", "story_v_out_116061.awb") / 1000

					if var_15_14 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_6
					end

					if var_15_9.prefab_name ~= "" and arg_12_1.actors_[var_15_9.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_9.prefab_name].transform, "story_v_out_116061", "116061003", "story_v_out_116061.awb")

						arg_12_1:RecordAudio("116061003", var_15_15)
						arg_12_1:RecordAudio("116061003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_116061", "116061003", "story_v_out_116061.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_116061", "116061003", "story_v_out_116061.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_16 and arg_12_1.time_ < var_15_6 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play116061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 116061004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play116061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = arg_16_1.actors_["10025ui_story"]
			local var_19_1 = 0

			if var_19_1 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect10025ui_story == nil then
				arg_16_1.var_.characterEffect10025ui_story = var_19_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.2

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_2 and not isNil(var_19_0) then
				local var_19_3 = (arg_16_1.time_ - var_19_1) / var_19_2

				if arg_16_1.var_.characterEffect10025ui_story and not isNil(var_19_0) then
					local var_19_4 = Mathf.Lerp(0, 0.5, var_19_3)

					arg_16_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_16_1.var_.characterEffect10025ui_story.fillRatio = var_19_4
				end
			end

			if arg_16_1.time_ >= var_19_1 + var_19_2 and arg_16_1.time_ < var_19_1 + var_19_2 + arg_19_0 and not isNil(var_19_0) and arg_16_1.var_.characterEffect10025ui_story then
				local var_19_5 = 0.5

				arg_16_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_16_1.var_.characterEffect10025ui_story.fillRatio = var_19_5
			end

			local var_19_6 = 0
			local var_19_7 = 0.45

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_8 = arg_16_1:FormatText(StoryNameCfg[7].name)

				arg_16_1.leftNameTxt_.text = var_19_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_9 = arg_16_1:GetWordFromCfg(116061004)
				local var_19_10 = arg_16_1:FormatText(var_19_9.content)

				arg_16_1.text_.text = var_19_10

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 18
				local var_19_12 = utf8.len(var_19_10)
				local var_19_13 = var_19_11 <= 0 and var_19_7 or var_19_7 * (var_19_12 / var_19_11)

				if var_19_13 > 0 and var_19_7 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_10
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_14 and arg_16_1.time_ < var_19_6 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play116061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 116061005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play116061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0
			local var_23_1 = 0.9

			if var_23_0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				local var_23_2 = arg_20_1:FormatText(StoryNameCfg[7].name)

				arg_20_1.leftNameTxt_.text = var_23_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_3 = arg_20_1:GetWordFromCfg(116061005)
				local var_23_4 = arg_20_1:FormatText(var_23_3.content)

				arg_20_1.text_.text = var_23_4

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 36
				local var_23_6 = utf8.len(var_23_4)
				local var_23_7 = var_23_5 <= 0 and var_23_1 or var_23_1 * (var_23_6 / var_23_5)

				if var_23_7 > 0 and var_23_1 < var_23_7 then
					arg_20_1.talkMaxDuration = var_23_7

					if var_23_7 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_7 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_4
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play116061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 116061006
		arg_24_1.duration_ = 5.07

		local var_24_0 = {
			zh = 1.999999999999,
			ja = 5.066
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
				arg_24_0:Play116061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = arg_24_1.actors_["10025ui_story"]
			local var_27_1 = 0

			if var_27_1 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10025ui_story == nil then
				arg_24_1.var_.characterEffect10025ui_story = var_27_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.2

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_2 and not isNil(var_27_0) then
				local var_27_3 = (arg_24_1.time_ - var_27_1) / var_27_2

				if arg_24_1.var_.characterEffect10025ui_story and not isNil(var_27_0) then
					arg_24_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= var_27_1 + var_27_2 and arg_24_1.time_ < var_27_1 + var_27_2 + arg_27_0 and not isNil(var_27_0) and arg_24_1.var_.characterEffect10025ui_story then
				arg_24_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_27_4 = 0

			if var_27_4 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_27_5 = 0

			if var_27_5 < arg_24_1.time_ and arg_24_1.time_ <= var_27_5 + arg_27_0 then
				arg_24_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_27_6 = 0
			local var_27_7 = 0.15

			if var_27_6 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				local var_27_8 = arg_24_1:FormatText(StoryNameCfg[328].name)

				arg_24_1.leftNameTxt_.text = var_27_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_9 = arg_24_1:GetWordFromCfg(116061006)
				local var_27_10 = arg_24_1:FormatText(var_27_9.content)

				arg_24_1.text_.text = var_27_10

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 6
				local var_27_12 = utf8.len(var_27_10)
				local var_27_13 = var_27_11 <= 0 and var_27_7 or var_27_7 * (var_27_12 / var_27_11)

				if var_27_13 > 0 and var_27_7 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_10
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061006", "story_v_out_116061.awb") ~= 0 then
					local var_27_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061006", "story_v_out_116061.awb") / 1000

					if var_27_14 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_6
					end

					if var_27_9.prefab_name ~= "" and arg_24_1.actors_[var_27_9.prefab_name] ~= nil then
						local var_27_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_9.prefab_name].transform, "story_v_out_116061", "116061006", "story_v_out_116061.awb")

						arg_24_1:RecordAudio("116061006", var_27_15)
						arg_24_1:RecordAudio("116061006", var_27_15)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_116061", "116061006", "story_v_out_116061.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_116061", "116061006", "story_v_out_116061.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_16 and arg_24_1.time_ < var_27_6 + var_27_16 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play116061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 116061007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play116061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = arg_28_1.actors_["10025ui_story"]
			local var_31_1 = 0

			if var_31_1 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10025ui_story == nil then
				arg_28_1.var_.characterEffect10025ui_story = var_31_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.2

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_2 and not isNil(var_31_0) then
				local var_31_3 = (arg_28_1.time_ - var_31_1) / var_31_2

				if arg_28_1.var_.characterEffect10025ui_story and not isNil(var_31_0) then
					local var_31_4 = Mathf.Lerp(0, 0.5, var_31_3)

					arg_28_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10025ui_story.fillRatio = var_31_4
				end
			end

			if arg_28_1.time_ >= var_31_1 + var_31_2 and arg_28_1.time_ < var_31_1 + var_31_2 + arg_31_0 and not isNil(var_31_0) and arg_28_1.var_.characterEffect10025ui_story then
				local var_31_5 = 0.5

				arg_28_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10025ui_story.fillRatio = var_31_5
			end

			local var_31_6 = 0
			local var_31_7 = 0.225

			if var_31_6 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				local var_31_8 = arg_28_1:FormatText(StoryNameCfg[7].name)

				arg_28_1.leftNameTxt_.text = var_31_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_9 = arg_28_1:GetWordFromCfg(116061007)
				local var_31_10 = arg_28_1:FormatText(var_31_9.content)

				arg_28_1.text_.text = var_31_10

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 9
				local var_31_12 = utf8.len(var_31_10)
				local var_31_13 = var_31_11 <= 0 and var_31_7 or var_31_7 * (var_31_12 / var_31_11)

				if var_31_13 > 0 and var_31_7 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_10
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_14 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_14 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_14

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_14 and arg_28_1.time_ < var_31_6 + var_31_14 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play116061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 116061008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play116061009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0
			local var_35_1 = 0.375

			if var_35_0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_2 = arg_32_1:GetWordFromCfg(116061008)
				local var_35_3 = arg_32_1:FormatText(var_35_2.content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 15
				local var_35_5 = utf8.len(var_35_3)
				local var_35_6 = var_35_4 <= 0 and var_35_1 or var_35_1 * (var_35_5 / var_35_4)

				if var_35_6 > 0 and var_35_1 < var_35_6 then
					arg_32_1.talkMaxDuration = var_35_6

					if var_35_6 + var_35_0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_0
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_1, arg_32_1.talkMaxDuration)

			if var_35_0 <= arg_32_1.time_ and arg_32_1.time_ < var_35_0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_0 + var_35_7 and arg_32_1.time_ < var_35_0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play116061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 116061009
		arg_36_1.duration_ = 4.97

		local var_36_0 = {
			zh = 2.1,
			ja = 4.966
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
				arg_36_0:Play116061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = arg_36_1.actors_["10025ui_story"]
			local var_39_1 = 0

			if var_39_1 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10025ui_story == nil then
				arg_36_1.var_.characterEffect10025ui_story = var_39_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.2

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 and not isNil(var_39_0) then
				local var_39_3 = (arg_36_1.time_ - var_39_1) / var_39_2

				if arg_36_1.var_.characterEffect10025ui_story and not isNil(var_39_0) then
					arg_36_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 and not isNil(var_39_0) and arg_36_1.var_.characterEffect10025ui_story then
				arg_36_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_39_4 = 0

			if var_39_4 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_39_5 = 0

			if var_39_5 < arg_36_1.time_ and arg_36_1.time_ <= var_39_5 + arg_39_0 then
				arg_36_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_39_6 = 0
			local var_39_7 = 0.125

			if var_39_6 < arg_36_1.time_ and arg_36_1.time_ <= var_39_6 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				local var_39_8 = arg_36_1:FormatText(StoryNameCfg[328].name)

				arg_36_1.leftNameTxt_.text = var_39_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_9 = arg_36_1:GetWordFromCfg(116061009)
				local var_39_10 = arg_36_1:FormatText(var_39_9.content)

				arg_36_1.text_.text = var_39_10

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_11 = 5
				local var_39_12 = utf8.len(var_39_10)
				local var_39_13 = var_39_11 <= 0 and var_39_7 or var_39_7 * (var_39_12 / var_39_11)

				if var_39_13 > 0 and var_39_7 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_6
					end
				end

				arg_36_1.text_.text = var_39_10
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061009", "story_v_out_116061.awb") ~= 0 then
					local var_39_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061009", "story_v_out_116061.awb") / 1000

					if var_39_14 + var_39_6 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_6
					end

					if var_39_9.prefab_name ~= "" and arg_36_1.actors_[var_39_9.prefab_name] ~= nil then
						local var_39_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_9.prefab_name].transform, "story_v_out_116061", "116061009", "story_v_out_116061.awb")

						arg_36_1:RecordAudio("116061009", var_39_15)
						arg_36_1:RecordAudio("116061009", var_39_15)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_116061", "116061009", "story_v_out_116061.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_116061", "116061009", "story_v_out_116061.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_7, arg_36_1.talkMaxDuration)

			if var_39_6 <= arg_36_1.time_ and arg_36_1.time_ < var_39_6 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_6) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_6 + var_39_16 and arg_36_1.time_ < var_39_6 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play116061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 116061010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play116061011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = arg_40_1.actors_["10025ui_story"]
			local var_43_1 = 0

			if var_43_1 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10025ui_story == nil then
				arg_40_1.var_.characterEffect10025ui_story = var_43_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.2

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_2 and not isNil(var_43_0) then
				local var_43_3 = (arg_40_1.time_ - var_43_1) / var_43_2

				if arg_40_1.var_.characterEffect10025ui_story and not isNil(var_43_0) then
					local var_43_4 = Mathf.Lerp(0, 0.5, var_43_3)

					arg_40_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_40_1.var_.characterEffect10025ui_story.fillRatio = var_43_4
				end
			end

			if arg_40_1.time_ >= var_43_1 + var_43_2 and arg_40_1.time_ < var_43_1 + var_43_2 + arg_43_0 and not isNil(var_43_0) and arg_40_1.var_.characterEffect10025ui_story then
				local var_43_5 = 0.5

				arg_40_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_40_1.var_.characterEffect10025ui_story.fillRatio = var_43_5
			end

			local var_43_6 = 0
			local var_43_7 = 0.6

			if var_43_6 < arg_40_1.time_ and arg_40_1.time_ <= var_43_6 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				local var_43_8 = arg_40_1:FormatText(StoryNameCfg[7].name)

				arg_40_1.leftNameTxt_.text = var_43_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_9 = arg_40_1:GetWordFromCfg(116061010)
				local var_43_10 = arg_40_1:FormatText(var_43_9.content)

				arg_40_1.text_.text = var_43_10

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_11 = 24
				local var_43_12 = utf8.len(var_43_10)
				local var_43_13 = var_43_11 <= 0 and var_43_7 or var_43_7 * (var_43_12 / var_43_11)

				if var_43_13 > 0 and var_43_7 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_6 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_6
					end
				end

				arg_40_1.text_.text = var_43_10
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_14 = math.max(var_43_7, arg_40_1.talkMaxDuration)

			if var_43_6 <= arg_40_1.time_ and arg_40_1.time_ < var_43_6 + var_43_14 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_6) / var_43_14

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_6 + var_43_14 and arg_40_1.time_ < var_43_6 + var_43_14 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play116061011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 116061011
		arg_44_1.duration_ = 13.67

		local var_44_0 = {
			zh = 7.1,
			ja = 13.666
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
				arg_44_0:Play116061012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = arg_44_1.actors_["10025ui_story"]
			local var_47_1 = 0

			if var_47_1 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10025ui_story == nil then
				arg_44_1.var_.characterEffect10025ui_story = var_47_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.2

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_2 and not isNil(var_47_0) then
				local var_47_3 = (arg_44_1.time_ - var_47_1) / var_47_2

				if arg_44_1.var_.characterEffect10025ui_story and not isNil(var_47_0) then
					arg_44_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= var_47_1 + var_47_2 and arg_44_1.time_ < var_47_1 + var_47_2 + arg_47_0 and not isNil(var_47_0) and arg_44_1.var_.characterEffect10025ui_story then
				arg_44_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_47_4 = 0

			if var_47_4 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_47_5 = 0

			if var_47_5 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_47_6 = 0
			local var_47_7 = 0.5

			if var_47_6 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				local var_47_8 = arg_44_1:FormatText(StoryNameCfg[328].name)

				arg_44_1.leftNameTxt_.text = var_47_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_9 = arg_44_1:GetWordFromCfg(116061011)
				local var_47_10 = arg_44_1:FormatText(var_47_9.content)

				arg_44_1.text_.text = var_47_10

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 20
				local var_47_12 = utf8.len(var_47_10)
				local var_47_13 = var_47_11 <= 0 and var_47_7 or var_47_7 * (var_47_12 / var_47_11)

				if var_47_13 > 0 and var_47_7 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_10
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061011", "story_v_out_116061.awb") ~= 0 then
					local var_47_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061011", "story_v_out_116061.awb") / 1000

					if var_47_14 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_6
					end

					if var_47_9.prefab_name ~= "" and arg_44_1.actors_[var_47_9.prefab_name] ~= nil then
						local var_47_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_9.prefab_name].transform, "story_v_out_116061", "116061011", "story_v_out_116061.awb")

						arg_44_1:RecordAudio("116061011", var_47_15)
						arg_44_1:RecordAudio("116061011", var_47_15)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_116061", "116061011", "story_v_out_116061.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_116061", "116061011", "story_v_out_116061.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_16 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_16 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_16

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_16 and arg_44_1.time_ < var_47_6 + var_47_16 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play116061012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 116061012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play116061013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = arg_48_1.actors_["10025ui_story"]
			local var_51_1 = 0

			if var_51_1 < arg_48_1.time_ and arg_48_1.time_ <= var_51_1 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10025ui_story == nil then
				arg_48_1.var_.characterEffect10025ui_story = var_51_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.2

			if var_51_1 <= arg_48_1.time_ and arg_48_1.time_ < var_51_1 + var_51_2 and not isNil(var_51_0) then
				local var_51_3 = (arg_48_1.time_ - var_51_1) / var_51_2

				if arg_48_1.var_.characterEffect10025ui_story and not isNil(var_51_0) then
					local var_51_4 = Mathf.Lerp(0, 0.5, var_51_3)

					arg_48_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_48_1.var_.characterEffect10025ui_story.fillRatio = var_51_4
				end
			end

			if arg_48_1.time_ >= var_51_1 + var_51_2 and arg_48_1.time_ < var_51_1 + var_51_2 + arg_51_0 and not isNil(var_51_0) and arg_48_1.var_.characterEffect10025ui_story then
				local var_51_5 = 0.5

				arg_48_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_48_1.var_.characterEffect10025ui_story.fillRatio = var_51_5
			end

			local var_51_6 = 0
			local var_51_7 = 1.275

			if var_51_6 < arg_48_1.time_ and arg_48_1.time_ <= var_51_6 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				local var_51_8 = arg_48_1:FormatText(StoryNameCfg[7].name)

				arg_48_1.leftNameTxt_.text = var_51_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_9 = arg_48_1:GetWordFromCfg(116061012)
				local var_51_10 = arg_48_1:FormatText(var_51_9.content)

				arg_48_1.text_.text = var_51_10

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_11 = 51
				local var_51_12 = utf8.len(var_51_10)
				local var_51_13 = var_51_11 <= 0 and var_51_7 or var_51_7 * (var_51_12 / var_51_11)

				if var_51_13 > 0 and var_51_7 < var_51_13 then
					arg_48_1.talkMaxDuration = var_51_13

					if var_51_13 + var_51_6 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_13 + var_51_6
					end
				end

				arg_48_1.text_.text = var_51_10
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_14 = math.max(var_51_7, arg_48_1.talkMaxDuration)

			if var_51_6 <= arg_48_1.time_ and arg_48_1.time_ < var_51_6 + var_51_14 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_6) / var_51_14

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_6 + var_51_14 and arg_48_1.time_ < var_51_6 + var_51_14 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play116061013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 116061013
		arg_52_1.duration_ = 8.17

		local var_52_0 = {
			zh = 5.233,
			ja = 8.166
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play116061014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = arg_52_1.actors_["10025ui_story"]
			local var_55_1 = 0

			if var_55_1 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10025ui_story == nil then
				arg_52_1.var_.characterEffect10025ui_story = var_55_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_2 = 0.2

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_2 and not isNil(var_55_0) then
				local var_55_3 = (arg_52_1.time_ - var_55_1) / var_55_2

				if arg_52_1.var_.characterEffect10025ui_story and not isNil(var_55_0) then
					arg_52_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= var_55_1 + var_55_2 and arg_52_1.time_ < var_55_1 + var_55_2 + arg_55_0 and not isNil(var_55_0) and arg_52_1.var_.characterEffect10025ui_story then
				arg_52_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_55_4 = 0

			if var_55_4 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_2")
			end

			local var_55_5 = 0

			if var_55_5 < arg_52_1.time_ and arg_52_1.time_ <= var_55_5 + arg_55_0 then
				arg_52_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_55_6 = 0
			local var_55_7 = 0.45

			if var_55_6 < arg_52_1.time_ and arg_52_1.time_ <= var_55_6 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				local var_55_8 = arg_52_1:FormatText(StoryNameCfg[328].name)

				arg_52_1.leftNameTxt_.text = var_55_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_9 = arg_52_1:GetWordFromCfg(116061013)
				local var_55_10 = arg_52_1:FormatText(var_55_9.content)

				arg_52_1.text_.text = var_55_10

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 18
				local var_55_12 = utf8.len(var_55_10)
				local var_55_13 = var_55_11 <= 0 and var_55_7 or var_55_7 * (var_55_12 / var_55_11)

				if var_55_13 > 0 and var_55_7 < var_55_13 then
					arg_52_1.talkMaxDuration = var_55_13

					if var_55_13 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_13 + var_55_6
					end
				end

				arg_52_1.text_.text = var_55_10
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061013", "story_v_out_116061.awb") ~= 0 then
					local var_55_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061013", "story_v_out_116061.awb") / 1000

					if var_55_14 + var_55_6 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_14 + var_55_6
					end

					if var_55_9.prefab_name ~= "" and arg_52_1.actors_[var_55_9.prefab_name] ~= nil then
						local var_55_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_9.prefab_name].transform, "story_v_out_116061", "116061013", "story_v_out_116061.awb")

						arg_52_1:RecordAudio("116061013", var_55_15)
						arg_52_1:RecordAudio("116061013", var_55_15)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_116061", "116061013", "story_v_out_116061.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_116061", "116061013", "story_v_out_116061.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_16 = math.max(var_55_7, arg_52_1.talkMaxDuration)

			if var_55_6 <= arg_52_1.time_ and arg_52_1.time_ < var_55_6 + var_55_16 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_6) / var_55_16

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_6 + var_55_16 and arg_52_1.time_ < var_55_6 + var_55_16 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play116061014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 116061014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play116061015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = arg_56_1.actors_["10025ui_story"]
			local var_59_1 = 0

			if var_59_1 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect10025ui_story == nil then
				arg_56_1.var_.characterEffect10025ui_story = var_59_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.2

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_2 and not isNil(var_59_0) then
				local var_59_3 = (arg_56_1.time_ - var_59_1) / var_59_2

				if arg_56_1.var_.characterEffect10025ui_story and not isNil(var_59_0) then
					local var_59_4 = Mathf.Lerp(0, 0.5, var_59_3)

					arg_56_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_56_1.var_.characterEffect10025ui_story.fillRatio = var_59_4
				end
			end

			if arg_56_1.time_ >= var_59_1 + var_59_2 and arg_56_1.time_ < var_59_1 + var_59_2 + arg_59_0 and not isNil(var_59_0) and arg_56_1.var_.characterEffect10025ui_story then
				local var_59_5 = 0.5

				arg_56_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_56_1.var_.characterEffect10025ui_story.fillRatio = var_59_5
			end

			local var_59_6 = 0
			local var_59_7 = 0.1

			if var_59_6 < arg_56_1.time_ and arg_56_1.time_ <= var_59_6 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				local var_59_8 = arg_56_1:FormatText(StoryNameCfg[7].name)

				arg_56_1.leftNameTxt_.text = var_59_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_9 = arg_56_1:GetWordFromCfg(116061014)
				local var_59_10 = arg_56_1:FormatText(var_59_9.content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_11 = 4
				local var_59_12 = utf8.len(var_59_10)
				local var_59_13 = var_59_11 <= 0 and var_59_7 or var_59_7 * (var_59_12 / var_59_11)

				if var_59_13 > 0 and var_59_7 < var_59_13 then
					arg_56_1.talkMaxDuration = var_59_13

					if var_59_13 + var_59_6 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_13 + var_59_6
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_14 = math.max(var_59_7, arg_56_1.talkMaxDuration)

			if var_59_6 <= arg_56_1.time_ and arg_56_1.time_ < var_59_6 + var_59_14 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_6) / var_59_14

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_6 + var_59_14 and arg_56_1.time_ < var_59_6 + var_59_14 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play116061015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 116061015
		arg_60_1.duration_ = 5.87

		local var_60_0 = {
			zh = 5.033,
			ja = 5.866
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play116061016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = arg_60_1.actors_["10025ui_story"]
			local var_63_1 = 0

			if var_63_1 < arg_60_1.time_ and arg_60_1.time_ <= var_63_1 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect10025ui_story == nil then
				arg_60_1.var_.characterEffect10025ui_story = var_63_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_2 = 0.2

			if var_63_1 <= arg_60_1.time_ and arg_60_1.time_ < var_63_1 + var_63_2 and not isNil(var_63_0) then
				local var_63_3 = (arg_60_1.time_ - var_63_1) / var_63_2

				if arg_60_1.var_.characterEffect10025ui_story and not isNil(var_63_0) then
					arg_60_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= var_63_1 + var_63_2 and arg_60_1.time_ < var_63_1 + var_63_2 + arg_63_0 and not isNil(var_63_0) and arg_60_1.var_.characterEffect10025ui_story then
				arg_60_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_63_4 = 0

			if var_63_4 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_63_5 = 0
			local var_63_6 = 0.3

			if var_63_5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_5 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				local var_63_7 = arg_60_1:FormatText(StoryNameCfg[328].name)

				arg_60_1.leftNameTxt_.text = var_63_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_8 = arg_60_1:GetWordFromCfg(116061015)
				local var_63_9 = arg_60_1:FormatText(var_63_8.content)

				arg_60_1.text_.text = var_63_9

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_10 = 12
				local var_63_11 = utf8.len(var_63_9)
				local var_63_12 = var_63_10 <= 0 and var_63_6 or var_63_6 * (var_63_11 / var_63_10)

				if var_63_12 > 0 and var_63_6 < var_63_12 then
					arg_60_1.talkMaxDuration = var_63_12

					if var_63_12 + var_63_5 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_12 + var_63_5
					end
				end

				arg_60_1.text_.text = var_63_9
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061015", "story_v_out_116061.awb") ~= 0 then
					local var_63_13 = manager.audio:GetVoiceLength("story_v_out_116061", "116061015", "story_v_out_116061.awb") / 1000

					if var_63_13 + var_63_5 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_13 + var_63_5
					end

					if var_63_8.prefab_name ~= "" and arg_60_1.actors_[var_63_8.prefab_name] ~= nil then
						local var_63_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_8.prefab_name].transform, "story_v_out_116061", "116061015", "story_v_out_116061.awb")

						arg_60_1:RecordAudio("116061015", var_63_14)
						arg_60_1:RecordAudio("116061015", var_63_14)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_116061", "116061015", "story_v_out_116061.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_116061", "116061015", "story_v_out_116061.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_15 = math.max(var_63_6, arg_60_1.talkMaxDuration)

			if var_63_5 <= arg_60_1.time_ and arg_60_1.time_ < var_63_5 + var_63_15 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_5) / var_63_15

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_5 + var_63_15 and arg_60_1.time_ < var_63_5 + var_63_15 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play116061016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 116061016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play116061017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = arg_64_1.actors_["10025ui_story"]
			local var_67_1 = 0

			if var_67_1 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10025ui_story == nil then
				arg_64_1.var_.characterEffect10025ui_story = var_67_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.2

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_2 and not isNil(var_67_0) then
				local var_67_3 = (arg_64_1.time_ - var_67_1) / var_67_2

				if arg_64_1.var_.characterEffect10025ui_story and not isNil(var_67_0) then
					local var_67_4 = Mathf.Lerp(0, 0.5, var_67_3)

					arg_64_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_64_1.var_.characterEffect10025ui_story.fillRatio = var_67_4
				end
			end

			if arg_64_1.time_ >= var_67_1 + var_67_2 and arg_64_1.time_ < var_67_1 + var_67_2 + arg_67_0 and not isNil(var_67_0) and arg_64_1.var_.characterEffect10025ui_story then
				local var_67_5 = 0.5

				arg_64_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_64_1.var_.characterEffect10025ui_story.fillRatio = var_67_5
			end

			local var_67_6 = 0
			local var_67_7 = 0.15

			if var_67_6 < arg_64_1.time_ and arg_64_1.time_ <= var_67_6 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				local var_67_8 = arg_64_1:FormatText(StoryNameCfg[7].name)

				arg_64_1.leftNameTxt_.text = var_67_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_9 = arg_64_1:GetWordFromCfg(116061016)
				local var_67_10 = arg_64_1:FormatText(var_67_9.content)

				arg_64_1.text_.text = var_67_10

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_11 = 6
				local var_67_12 = utf8.len(var_67_10)
				local var_67_13 = var_67_11 <= 0 and var_67_7 or var_67_7 * (var_67_12 / var_67_11)

				if var_67_13 > 0 and var_67_7 < var_67_13 then
					arg_64_1.talkMaxDuration = var_67_13

					if var_67_13 + var_67_6 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_13 + var_67_6
					end
				end

				arg_64_1.text_.text = var_67_10
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_14 = math.max(var_67_7, arg_64_1.talkMaxDuration)

			if var_67_6 <= arg_64_1.time_ and arg_64_1.time_ < var_67_6 + var_67_14 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_6) / var_67_14

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_6 + var_67_14 and arg_64_1.time_ < var_67_6 + var_67_14 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play116061017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 116061017
		arg_68_1.duration_ = 4.4

		local var_68_0 = {
			zh = 3.5,
			ja = 4.4
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play116061018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = arg_68_1.actors_["10025ui_story"]
			local var_71_1 = 0

			if var_71_1 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10025ui_story == nil then
				arg_68_1.var_.characterEffect10025ui_story = var_71_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_2 = 0.2

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_2 and not isNil(var_71_0) then
				local var_71_3 = (arg_68_1.time_ - var_71_1) / var_71_2

				if arg_68_1.var_.characterEffect10025ui_story and not isNil(var_71_0) then
					arg_68_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= var_71_1 + var_71_2 and arg_68_1.time_ < var_71_1 + var_71_2 + arg_71_0 and not isNil(var_71_0) and arg_68_1.var_.characterEffect10025ui_story then
				arg_68_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_71_4 = 0

			if var_71_4 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_1")
			end

			local var_71_5 = 0

			if var_71_5 < arg_68_1.time_ and arg_68_1.time_ <= var_71_5 + arg_71_0 then
				arg_68_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_71_6 = 0
			local var_71_7 = 0.175

			if var_71_6 < arg_68_1.time_ and arg_68_1.time_ <= var_71_6 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				local var_71_8 = arg_68_1:FormatText(StoryNameCfg[328].name)

				arg_68_1.leftNameTxt_.text = var_71_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_9 = arg_68_1:GetWordFromCfg(116061017)
				local var_71_10 = arg_68_1:FormatText(var_71_9.content)

				arg_68_1.text_.text = var_71_10

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_11 = 7
				local var_71_12 = utf8.len(var_71_10)
				local var_71_13 = var_71_11 <= 0 and var_71_7 or var_71_7 * (var_71_12 / var_71_11)

				if var_71_13 > 0 and var_71_7 < var_71_13 then
					arg_68_1.talkMaxDuration = var_71_13

					if var_71_13 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_13 + var_71_6
					end
				end

				arg_68_1.text_.text = var_71_10
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061017", "story_v_out_116061.awb") ~= 0 then
					local var_71_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061017", "story_v_out_116061.awb") / 1000

					if var_71_14 + var_71_6 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_14 + var_71_6
					end

					if var_71_9.prefab_name ~= "" and arg_68_1.actors_[var_71_9.prefab_name] ~= nil then
						local var_71_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_9.prefab_name].transform, "story_v_out_116061", "116061017", "story_v_out_116061.awb")

						arg_68_1:RecordAudio("116061017", var_71_15)
						arg_68_1:RecordAudio("116061017", var_71_15)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_116061", "116061017", "story_v_out_116061.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_116061", "116061017", "story_v_out_116061.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_16 = math.max(var_71_7, arg_68_1.talkMaxDuration)

			if var_71_6 <= arg_68_1.time_ and arg_68_1.time_ < var_71_6 + var_71_16 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_6) / var_71_16

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_6 + var_71_16 and arg_68_1.time_ < var_71_6 + var_71_16 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play116061018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 116061018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play116061019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = arg_72_1.actors_["10025ui_story"]
			local var_75_1 = 0

			if var_75_1 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect10025ui_story == nil then
				arg_72_1.var_.characterEffect10025ui_story = var_75_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.2

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_2 and not isNil(var_75_0) then
				local var_75_3 = (arg_72_1.time_ - var_75_1) / var_75_2

				if arg_72_1.var_.characterEffect10025ui_story and not isNil(var_75_0) then
					local var_75_4 = Mathf.Lerp(0, 0.5, var_75_3)

					arg_72_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_72_1.var_.characterEffect10025ui_story.fillRatio = var_75_4
				end
			end

			if arg_72_1.time_ >= var_75_1 + var_75_2 and arg_72_1.time_ < var_75_1 + var_75_2 + arg_75_0 and not isNil(var_75_0) and arg_72_1.var_.characterEffect10025ui_story then
				local var_75_5 = 0.5

				arg_72_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_72_1.var_.characterEffect10025ui_story.fillRatio = var_75_5
			end

			local var_75_6 = 0

			if var_75_6 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_2")
			end

			local var_75_7 = 0
			local var_75_8 = 0.575

			if var_75_7 < arg_72_1.time_ and arg_72_1.time_ <= var_75_7 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				local var_75_9 = arg_72_1:FormatText(StoryNameCfg[7].name)

				arg_72_1.leftNameTxt_.text = var_75_9

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_10 = arg_72_1:GetWordFromCfg(116061018)
				local var_75_11 = arg_72_1:FormatText(var_75_10.content)

				arg_72_1.text_.text = var_75_11

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_12 = 23
				local var_75_13 = utf8.len(var_75_11)
				local var_75_14 = var_75_12 <= 0 and var_75_8 or var_75_8 * (var_75_13 / var_75_12)

				if var_75_14 > 0 and var_75_8 < var_75_14 then
					arg_72_1.talkMaxDuration = var_75_14

					if var_75_14 + var_75_7 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_14 + var_75_7
					end
				end

				arg_72_1.text_.text = var_75_11
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_15 = math.max(var_75_8, arg_72_1.talkMaxDuration)

			if var_75_7 <= arg_72_1.time_ and arg_72_1.time_ < var_75_7 + var_75_15 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_7) / var_75_15

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_7 + var_75_15 and arg_72_1.time_ < var_75_7 + var_75_15 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play116061019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 116061019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play116061020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0
			local var_79_1 = 0.65

			if var_79_0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				local var_79_2 = arg_76_1:FormatText(StoryNameCfg[7].name)

				arg_76_1.leftNameTxt_.text = var_79_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_3 = arg_76_1:GetWordFromCfg(116061019)
				local var_79_4 = arg_76_1:FormatText(var_79_3.content)

				arg_76_1.text_.text = var_79_4

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 26
				local var_79_6 = utf8.len(var_79_4)
				local var_79_7 = var_79_5 <= 0 and var_79_1 or var_79_1 * (var_79_6 / var_79_5)

				if var_79_7 > 0 and var_79_1 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_4
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_8 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_8 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_8

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_8 and arg_76_1.time_ < var_79_0 + var_79_8 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play116061020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 116061020
		arg_80_1.duration_ = 6.33

		local var_80_0 = {
			zh = 6.333,
			ja = 5.433
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
				arg_80_0:Play116061021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = arg_80_1.actors_["10025ui_story"]
			local var_83_1 = 0

			if var_83_1 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10025ui_story == nil then
				arg_80_1.var_.characterEffect10025ui_story = var_83_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_2 = 0.2

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_2 and not isNil(var_83_0) then
				local var_83_3 = (arg_80_1.time_ - var_83_1) / var_83_2

				if arg_80_1.var_.characterEffect10025ui_story and not isNil(var_83_0) then
					arg_80_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= var_83_1 + var_83_2 and arg_80_1.time_ < var_83_1 + var_83_2 + arg_83_0 and not isNil(var_83_0) and arg_80_1.var_.characterEffect10025ui_story then
				arg_80_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_83_4 = 0

			if var_83_4 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_83_5 = 0
			local var_83_6 = 0.425

			if var_83_5 < arg_80_1.time_ and arg_80_1.time_ <= var_83_5 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				local var_83_7 = arg_80_1:FormatText(StoryNameCfg[328].name)

				arg_80_1.leftNameTxt_.text = var_83_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_8 = arg_80_1:GetWordFromCfg(116061020)
				local var_83_9 = arg_80_1:FormatText(var_83_8.content)

				arg_80_1.text_.text = var_83_9

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_10 = 17
				local var_83_11 = utf8.len(var_83_9)
				local var_83_12 = var_83_10 <= 0 and var_83_6 or var_83_6 * (var_83_11 / var_83_10)

				if var_83_12 > 0 and var_83_6 < var_83_12 then
					arg_80_1.talkMaxDuration = var_83_12

					if var_83_12 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_12 + var_83_5
					end
				end

				arg_80_1.text_.text = var_83_9
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061020", "story_v_out_116061.awb") ~= 0 then
					local var_83_13 = manager.audio:GetVoiceLength("story_v_out_116061", "116061020", "story_v_out_116061.awb") / 1000

					if var_83_13 + var_83_5 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_13 + var_83_5
					end

					if var_83_8.prefab_name ~= "" and arg_80_1.actors_[var_83_8.prefab_name] ~= nil then
						local var_83_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_8.prefab_name].transform, "story_v_out_116061", "116061020", "story_v_out_116061.awb")

						arg_80_1:RecordAudio("116061020", var_83_14)
						arg_80_1:RecordAudio("116061020", var_83_14)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_116061", "116061020", "story_v_out_116061.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_116061", "116061020", "story_v_out_116061.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_15 = math.max(var_83_6, arg_80_1.talkMaxDuration)

			if var_83_5 <= arg_80_1.time_ and arg_80_1.time_ < var_83_5 + var_83_15 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_5) / var_83_15

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_5 + var_83_15 and arg_80_1.time_ < var_83_5 + var_83_15 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play116061021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 116061021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play116061022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = arg_84_1.actors_["10025ui_story"]
			local var_87_1 = 0

			if var_87_1 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect10025ui_story == nil then
				arg_84_1.var_.characterEffect10025ui_story = var_87_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_2 = 0.2

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_2 and not isNil(var_87_0) then
				local var_87_3 = (arg_84_1.time_ - var_87_1) / var_87_2

				if arg_84_1.var_.characterEffect10025ui_story and not isNil(var_87_0) then
					local var_87_4 = Mathf.Lerp(0, 0.5, var_87_3)

					arg_84_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_84_1.var_.characterEffect10025ui_story.fillRatio = var_87_4
				end
			end

			if arg_84_1.time_ >= var_87_1 + var_87_2 and arg_84_1.time_ < var_87_1 + var_87_2 + arg_87_0 and not isNil(var_87_0) and arg_84_1.var_.characterEffect10025ui_story then
				local var_87_5 = 0.5

				arg_84_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_84_1.var_.characterEffect10025ui_story.fillRatio = var_87_5
			end

			local var_87_6 = 0
			local var_87_7 = 0.425

			if var_87_6 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				local var_87_8 = arg_84_1:FormatText(StoryNameCfg[7].name)

				arg_84_1.leftNameTxt_.text = var_87_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_9 = arg_84_1:GetWordFromCfg(116061021)
				local var_87_10 = arg_84_1:FormatText(var_87_9.content)

				arg_84_1.text_.text = var_87_10

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 17
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
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_14 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_14 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_14

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_14 and arg_84_1.time_ < var_87_6 + var_87_14 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play116061022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 116061022
		arg_88_1.duration_ = 4.5

		local var_88_0 = {
			zh = 3,
			ja = 4.5
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play116061023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = arg_88_1.actors_["10025ui_story"]
			local var_91_1 = 0

			if var_91_1 < arg_88_1.time_ and arg_88_1.time_ <= var_91_1 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10025ui_story == nil then
				arg_88_1.var_.characterEffect10025ui_story = var_91_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_2 = 0.2

			if var_91_1 <= arg_88_1.time_ and arg_88_1.time_ < var_91_1 + var_91_2 and not isNil(var_91_0) then
				local var_91_3 = (arg_88_1.time_ - var_91_1) / var_91_2

				if arg_88_1.var_.characterEffect10025ui_story and not isNil(var_91_0) then
					arg_88_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= var_91_1 + var_91_2 and arg_88_1.time_ < var_91_1 + var_91_2 + arg_91_0 and not isNil(var_91_0) and arg_88_1.var_.characterEffect10025ui_story then
				arg_88_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_91_4 = 0

			if var_91_4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
				arg_88_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_91_5 = 0

			if var_91_5 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_91_6 = 0
			local var_91_7 = 0.15

			if var_91_6 < arg_88_1.time_ and arg_88_1.time_ <= var_91_6 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				local var_91_8 = arg_88_1:FormatText(StoryNameCfg[328].name)

				arg_88_1.leftNameTxt_.text = var_91_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_9 = arg_88_1:GetWordFromCfg(116061022)
				local var_91_10 = arg_88_1:FormatText(var_91_9.content)

				arg_88_1.text_.text = var_91_10

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_11 = 6
				local var_91_12 = utf8.len(var_91_10)
				local var_91_13 = var_91_11 <= 0 and var_91_7 or var_91_7 * (var_91_12 / var_91_11)

				if var_91_13 > 0 and var_91_7 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_6
					end
				end

				arg_88_1.text_.text = var_91_10
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061022", "story_v_out_116061.awb") ~= 0 then
					local var_91_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061022", "story_v_out_116061.awb") / 1000

					if var_91_14 + var_91_6 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_6
					end

					if var_91_9.prefab_name ~= "" and arg_88_1.actors_[var_91_9.prefab_name] ~= nil then
						local var_91_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_9.prefab_name].transform, "story_v_out_116061", "116061022", "story_v_out_116061.awb")

						arg_88_1:RecordAudio("116061022", var_91_15)
						arg_88_1:RecordAudio("116061022", var_91_15)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_116061", "116061022", "story_v_out_116061.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_116061", "116061022", "story_v_out_116061.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_16 = math.max(var_91_7, arg_88_1.talkMaxDuration)

			if var_91_6 <= arg_88_1.time_ and arg_88_1.time_ < var_91_6 + var_91_16 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_6) / var_91_16

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_6 + var_91_16 and arg_88_1.time_ < var_91_6 + var_91_16 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play116061023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 116061023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play116061024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = arg_92_1.actors_["10025ui_story"].transform
			local var_95_1 = 0

			if var_95_1 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.var_.moveOldPos10025ui_story = var_95_0.localPosition
			end

			local var_95_2 = 0.001

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_2 then
				local var_95_3 = (arg_92_1.time_ - var_95_1) / var_95_2
				local var_95_4 = Vector3.New(0, 100, 0)

				var_95_0.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos10025ui_story, var_95_4, var_95_3)

				local var_95_5 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_5.x, var_95_5.y, var_95_5.z)

				local var_95_6 = var_95_0.localEulerAngles

				var_95_6.z = 0
				var_95_6.x = 0
				var_95_0.localEulerAngles = var_95_6
			end

			if arg_92_1.time_ >= var_95_1 + var_95_2 and arg_92_1.time_ < var_95_1 + var_95_2 + arg_95_0 then
				var_95_0.localPosition = Vector3.New(0, 100, 0)

				local var_95_7 = manager.ui.mainCamera.transform.position - var_95_0.position

				var_95_0.forward = Vector3.New(var_95_7.x, var_95_7.y, var_95_7.z)

				local var_95_8 = var_95_0.localEulerAngles

				var_95_8.z = 0
				var_95_8.x = 0
				var_95_0.localEulerAngles = var_95_8
			end

			local var_95_9 = 0
			local var_95_10 = 0.975

			if var_95_9 < arg_92_1.time_ and arg_92_1.time_ <= var_95_9 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_11 = arg_92_1:GetWordFromCfg(116061023)
				local var_95_12 = arg_92_1:FormatText(var_95_11.content)

				arg_92_1.text_.text = var_95_12

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 39
				local var_95_14 = utf8.len(var_95_12)
				local var_95_15 = var_95_13 <= 0 and var_95_10 or var_95_10 * (var_95_14 / var_95_13)

				if var_95_15 > 0 and var_95_10 < var_95_15 then
					arg_92_1.talkMaxDuration = var_95_15

					if var_95_15 + var_95_9 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_15 + var_95_9
					end
				end

				arg_92_1.text_.text = var_95_12
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_10, arg_92_1.talkMaxDuration)

			if var_95_9 <= arg_92_1.time_ and arg_92_1.time_ < var_95_9 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_9) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_9 + var_95_16 and arg_92_1.time_ < var_95_9 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_92_1:InitPlayNodeList()
	end,
	Play116061024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 116061024
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play116061025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0
			local var_99_1 = 0.475

			if var_99_0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				local var_99_2 = arg_96_1:FormatText(StoryNameCfg[7].name)

				arg_96_1.leftNameTxt_.text = var_99_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:GetWordFromCfg(116061024)
				local var_99_4 = arg_96_1:FormatText(var_99_3.content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 19
				local var_99_6 = utf8.len(var_99_4)
				local var_99_7 = var_99_5 <= 0 and var_99_1 or var_99_1 * (var_99_6 / var_99_5)

				if var_99_7 > 0 and var_99_1 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_0
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_8 = math.max(var_99_1, arg_96_1.talkMaxDuration)

			if var_99_0 <= arg_96_1.time_ and arg_96_1.time_ < var_99_0 + var_99_8 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_0) / var_99_8

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_0 + var_99_8 and arg_96_1.time_ < var_99_0 + var_99_8 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play116061025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 116061025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play116061026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0
			local var_103_1 = 0.2

			if var_103_0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				local var_103_2 = arg_100_1:FormatText(StoryNameCfg[7].name)

				arg_100_1.leftNameTxt_.text = var_103_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:GetWordFromCfg(116061025)
				local var_103_4 = arg_100_1:FormatText(var_103_3.content)

				arg_100_1.text_.text = var_103_4

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 8
				local var_103_6 = utf8.len(var_103_4)
				local var_103_7 = var_103_5 <= 0 and var_103_1 or var_103_1 * (var_103_6 / var_103_5)

				if var_103_7 > 0 and var_103_1 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_0
					end
				end

				arg_100_1.text_.text = var_103_4
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_8 = math.max(var_103_1, arg_100_1.talkMaxDuration)

			if var_103_0 <= arg_100_1.time_ and arg_100_1.time_ < var_103_0 + var_103_8 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_0) / var_103_8

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_0 + var_103_8 and arg_100_1.time_ < var_103_0 + var_103_8 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play116061026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 116061026
		arg_104_1.duration_ = 4.73

		local var_104_0 = {
			zh = 4.733,
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
				arg_104_0:Play116061027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = arg_104_1.actors_["10025ui_story"]
			local var_107_1 = 0

			if var_107_1 < arg_104_1.time_ and arg_104_1.time_ <= var_107_1 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect10025ui_story == nil then
				arg_104_1.var_.characterEffect10025ui_story = var_107_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_2 = 0.2

			if var_107_1 <= arg_104_1.time_ and arg_104_1.time_ < var_107_1 + var_107_2 and not isNil(var_107_0) then
				local var_107_3 = (arg_104_1.time_ - var_107_1) / var_107_2

				if arg_104_1.var_.characterEffect10025ui_story and not isNil(var_107_0) then
					arg_104_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= var_107_1 + var_107_2 and arg_104_1.time_ < var_107_1 + var_107_2 + arg_107_0 and not isNil(var_107_0) and arg_104_1.var_.characterEffect10025ui_story then
				arg_104_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_107_4 = 0

			if var_107_4 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_1")
			end

			local var_107_5 = 0

			if var_107_5 < arg_104_1.time_ and arg_104_1.time_ <= var_107_5 + arg_107_0 then
				arg_104_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_107_6 = arg_104_1.actors_["10025ui_story"].transform
			local var_107_7 = 0

			if var_107_7 < arg_104_1.time_ and arg_104_1.time_ <= var_107_7 + arg_107_0 then
				arg_104_1.var_.moveOldPos10025ui_story = var_107_6.localPosition
			end

			local var_107_8 = 0.001

			if var_107_7 <= arg_104_1.time_ and arg_104_1.time_ < var_107_7 + var_107_8 then
				local var_107_9 = (arg_104_1.time_ - var_107_7) / var_107_8
				local var_107_10 = Vector3.New(0, -1.1, -5.9)

				var_107_6.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10025ui_story, var_107_10, var_107_9)

				local var_107_11 = manager.ui.mainCamera.transform.position - var_107_6.position

				var_107_6.forward = Vector3.New(var_107_11.x, var_107_11.y, var_107_11.z)

				local var_107_12 = var_107_6.localEulerAngles

				var_107_12.z = 0
				var_107_12.x = 0
				var_107_6.localEulerAngles = var_107_12
			end

			if arg_104_1.time_ >= var_107_7 + var_107_8 and arg_104_1.time_ < var_107_7 + var_107_8 + arg_107_0 then
				var_107_6.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_107_13 = manager.ui.mainCamera.transform.position - var_107_6.position

				var_107_6.forward = Vector3.New(var_107_13.x, var_107_13.y, var_107_13.z)

				local var_107_14 = var_107_6.localEulerAngles

				var_107_14.z = 0
				var_107_14.x = 0
				var_107_6.localEulerAngles = var_107_14
			end

			local var_107_15 = 0
			local var_107_16 = 0.375

			if var_107_15 < arg_104_1.time_ and arg_104_1.time_ <= var_107_15 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				local var_107_17 = arg_104_1:FormatText(StoryNameCfg[328].name)

				arg_104_1.leftNameTxt_.text = var_107_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_18 = arg_104_1:GetWordFromCfg(116061026)
				local var_107_19 = arg_104_1:FormatText(var_107_18.content)

				arg_104_1.text_.text = var_107_19

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_20 = 15
				local var_107_21 = utf8.len(var_107_19)
				local var_107_22 = var_107_20 <= 0 and var_107_16 or var_107_16 * (var_107_21 / var_107_20)

				if var_107_22 > 0 and var_107_16 < var_107_22 then
					arg_104_1.talkMaxDuration = var_107_22

					if var_107_22 + var_107_15 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_22 + var_107_15
					end
				end

				arg_104_1.text_.text = var_107_19
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061026", "story_v_out_116061.awb") ~= 0 then
					local var_107_23 = manager.audio:GetVoiceLength("story_v_out_116061", "116061026", "story_v_out_116061.awb") / 1000

					if var_107_23 + var_107_15 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_23 + var_107_15
					end

					if var_107_18.prefab_name ~= "" and arg_104_1.actors_[var_107_18.prefab_name] ~= nil then
						local var_107_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_18.prefab_name].transform, "story_v_out_116061", "116061026", "story_v_out_116061.awb")

						arg_104_1:RecordAudio("116061026", var_107_24)
						arg_104_1:RecordAudio("116061026", var_107_24)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_116061", "116061026", "story_v_out_116061.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_116061", "116061026", "story_v_out_116061.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_25 = math.max(var_107_16, arg_104_1.talkMaxDuration)

			if var_107_15 <= arg_104_1.time_ and arg_104_1.time_ < var_107_15 + var_107_25 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_15) / var_107_25

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_15 + var_107_25 and arg_104_1.time_ < var_107_15 + var_107_25 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play116061027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 116061027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play116061028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = arg_108_1.actors_["10025ui_story"]
			local var_111_1 = 0

			if var_111_1 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect10025ui_story == nil then
				arg_108_1.var_.characterEffect10025ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.2

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_2 and not isNil(var_111_0) then
				local var_111_3 = (arg_108_1.time_ - var_111_1) / var_111_2

				if arg_108_1.var_.characterEffect10025ui_story and not isNil(var_111_0) then
					local var_111_4 = Mathf.Lerp(0, 0.5, var_111_3)

					arg_108_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_108_1.var_.characterEffect10025ui_story.fillRatio = var_111_4
				end
			end

			if arg_108_1.time_ >= var_111_1 + var_111_2 and arg_108_1.time_ < var_111_1 + var_111_2 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect10025ui_story then
				local var_111_5 = 0.5

				arg_108_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_108_1.var_.characterEffect10025ui_story.fillRatio = var_111_5
			end

			local var_111_6 = 0
			local var_111_7 = 0.125

			if var_111_6 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				local var_111_8 = arg_108_1:FormatText(StoryNameCfg[7].name)

				arg_108_1.leftNameTxt_.text = var_111_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_9 = arg_108_1:GetWordFromCfg(116061027)
				local var_111_10 = arg_108_1:FormatText(var_111_9.content)

				arg_108_1.text_.text = var_111_10

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_11 = 5
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
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_14 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_14 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_14

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_14 and arg_108_1.time_ < var_111_6 + var_111_14 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play116061028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 116061028
		arg_112_1.duration_ = 9

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play116061029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = "I05d"

			if arg_112_1.bgs_[var_115_0] == nil then
				local var_115_1 = Object.Instantiate(arg_112_1.paintGo_)

				var_115_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_115_0)
				var_115_1.name = var_115_0
				var_115_1.transform.parent = arg_112_1.stage_.transform
				var_115_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.bgs_[var_115_0] = var_115_1
			end

			local var_115_2 = 2

			if var_115_2 < arg_112_1.time_ and arg_112_1.time_ <= var_115_2 + arg_115_0 then
				if arg_112_0.sceneSettingEffect_ then
					arg_112_1.sceneSettingEffect_.enabled = false
				end

				arg_112_1.sceneSettingGo_:SetActive(true)

				local var_115_3 = manager.ui.mainCamera.transform.localPosition
				local var_115_4 = Vector3.New(0, 0, 10) + Vector3.New(var_115_3.x, var_115_3.y, 0)
				local var_115_5 = arg_112_1.bgs_.I05d

				var_115_5.transform.localPosition = var_115_4
				var_115_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_115_6 = var_115_5:GetComponent("SpriteRenderer")

				if var_115_6 and var_115_6.sprite then
					local var_115_7 = (var_115_5.transform.localPosition - var_115_3).z
					local var_115_8 = manager.ui.mainCameraCom_
					local var_115_9 = 2 * var_115_7 * Mathf.Tan(var_115_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_115_10 = var_115_9 * var_115_8.aspect
					local var_115_11 = var_115_6.sprite.bounds.size.x
					local var_115_12 = var_115_6.sprite.bounds.size.y
					local var_115_13 = var_115_10 / var_115_11
					local var_115_14 = var_115_9 / var_115_12
					local var_115_15 = var_115_14 < var_115_13 and var_115_13 or var_115_14

					var_115_5.transform.localScale = Vector3.New(var_115_15, var_115_15, 0)
				end

				for iter_115_0, iter_115_1 in pairs(arg_112_1.bgs_) do
					if iter_115_0 ~= "I05d" then
						iter_115_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_115_16 = 0

			if var_115_16 < arg_112_1.time_ and arg_112_1.time_ <= var_115_16 + arg_115_0 then
				arg_112_1.mask_.enabled = true
				arg_112_1.mask_.raycastTarget = true

				arg_112_1:SetGaussion(false)
			end

			local var_115_17 = 2

			if var_115_16 <= arg_112_1.time_ and arg_112_1.time_ < var_115_16 + var_115_17 then
				local var_115_18 = (arg_112_1.time_ - var_115_16) / var_115_17
				local var_115_19 = Color.New(0, 0, 0)

				var_115_19.a = Mathf.Lerp(0, 1, var_115_18)
				arg_112_1.mask_.color = var_115_19
			end

			if arg_112_1.time_ >= var_115_16 + var_115_17 and arg_112_1.time_ < var_115_16 + var_115_17 + arg_115_0 then
				local var_115_20 = Color.New(0, 0, 0)

				var_115_20.a = 1
				arg_112_1.mask_.color = var_115_20
			end

			local var_115_21 = 2

			if var_115_21 < arg_112_1.time_ and arg_112_1.time_ <= var_115_21 + arg_115_0 then
				arg_112_1.mask_.enabled = true
				arg_112_1.mask_.raycastTarget = true

				arg_112_1:SetGaussion(false)
			end

			local var_115_22 = 2

			if var_115_21 <= arg_112_1.time_ and arg_112_1.time_ < var_115_21 + var_115_22 then
				local var_115_23 = (arg_112_1.time_ - var_115_21) / var_115_22
				local var_115_24 = Color.New(0, 0, 0)

				var_115_24.a = Mathf.Lerp(1, 0, var_115_23)
				arg_112_1.mask_.color = var_115_24
			end

			if arg_112_1.time_ >= var_115_21 + var_115_22 and arg_112_1.time_ < var_115_21 + var_115_22 + arg_115_0 then
				local var_115_25 = Color.New(0, 0, 0)
				local var_115_26 = 0

				arg_112_1.mask_.enabled = false
				var_115_25.a = var_115_26
				arg_112_1.mask_.color = var_115_25
			end

			local var_115_27 = arg_112_1.actors_["10025ui_story"].transform
			local var_115_28 = 1.966

			if var_115_28 < arg_112_1.time_ and arg_112_1.time_ <= var_115_28 + arg_115_0 then
				arg_112_1.var_.moveOldPos10025ui_story = var_115_27.localPosition
			end

			local var_115_29 = 0.001

			if var_115_28 <= arg_112_1.time_ and arg_112_1.time_ < var_115_28 + var_115_29 then
				local var_115_30 = (arg_112_1.time_ - var_115_28) / var_115_29
				local var_115_31 = Vector3.New(0, 100, 0)

				var_115_27.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos10025ui_story, var_115_31, var_115_30)

				local var_115_32 = manager.ui.mainCamera.transform.position - var_115_27.position

				var_115_27.forward = Vector3.New(var_115_32.x, var_115_32.y, var_115_32.z)

				local var_115_33 = var_115_27.localEulerAngles

				var_115_33.z = 0
				var_115_33.x = 0
				var_115_27.localEulerAngles = var_115_33
			end

			if arg_112_1.time_ >= var_115_28 + var_115_29 and arg_112_1.time_ < var_115_28 + var_115_29 + arg_115_0 then
				var_115_27.localPosition = Vector3.New(0, 100, 0)

				local var_115_34 = manager.ui.mainCamera.transform.position - var_115_27.position

				var_115_27.forward = Vector3.New(var_115_34.x, var_115_34.y, var_115_34.z)

				local var_115_35 = var_115_27.localEulerAngles

				var_115_35.z = 0
				var_115_35.x = 0
				var_115_27.localEulerAngles = var_115_35
			end

			if arg_112_1.frameCnt_ <= 1 then
				arg_112_1.dialog_:SetActive(false)
			end

			local var_115_36 = 4
			local var_115_37 = 0.3

			if var_115_36 < arg_112_1.time_ and arg_112_1.time_ <= var_115_36 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0

				arg_112_1.dialog_:SetActive(true)

				arg_112_1.dialogCg_.alpha = 0

				local var_115_38 = LeanTween.value(arg_112_1.dialog_, 0, 1, 0.3)

				var_115_38:setOnUpdate(LuaHelper.FloatAction(function(arg_116_0)
					arg_112_1.dialogCg_.alpha = arg_116_0
				end))
				var_115_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_112_1.dialog_)
					var_115_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_112_1.duration_ = arg_112_1.duration_ + 0.3

				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_39 = arg_112_1:GetWordFromCfg(116061028)
				local var_115_40 = arg_112_1:FormatText(var_115_39.content)

				arg_112_1.text_.text = var_115_40

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_41 = 12
				local var_115_42 = utf8.len(var_115_40)
				local var_115_43 = var_115_41 <= 0 and var_115_37 or var_115_37 * (var_115_42 / var_115_41)

				if var_115_43 > 0 and var_115_37 < var_115_43 then
					arg_112_1.talkMaxDuration = var_115_43
					var_115_36 = var_115_36 + 0.3

					if var_115_43 + var_115_36 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_43 + var_115_36
					end
				end

				arg_112_1.text_.text = var_115_40
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_44 = var_115_36 + 0.3
			local var_115_45 = math.max(var_115_37, arg_112_1.talkMaxDuration)

			if var_115_44 <= arg_112_1.time_ and arg_112_1.time_ < var_115_44 + var_115_45 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_44) / var_115_45

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_44 + var_115_45 and arg_112_1.time_ < var_115_44 + var_115_45 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play116061029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 116061029
		arg_118_1.duration_ = 4.77

		local var_118_0 = {
			zh = 4.766,
			ja = 4.6
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
				arg_118_0:Play116061030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = "1084ui_story"

			if arg_118_1.actors_[var_121_0] == nil then
				local var_121_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_121_1) then
					local var_121_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_118_1.stage_.transform)

					var_121_2.name = var_121_0
					var_121_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_118_1.actors_[var_121_0] = var_121_2

					local var_121_3 = var_121_2:GetComponentInChildren(typeof(CharacterEffect))

					var_121_3.enabled = true

					local var_121_4 = GameObjectTools.GetOrAddComponent(var_121_2, typeof(DynamicBoneHelper))

					if var_121_4 then
						var_121_4:EnableDynamicBone(false)
					end

					arg_118_1:ShowWeapon(var_121_3.transform, false)

					arg_118_1.var_[var_121_0 .. "Animator"] = var_121_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_118_1.var_[var_121_0 .. "Animator"].applyRootMotion = true
					arg_118_1.var_[var_121_0 .. "LipSync"] = var_121_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_121_5 = arg_118_1.actors_["1084ui_story"].transform
			local var_121_6 = 0

			if var_121_6 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.var_.moveOldPos1084ui_story = var_121_5.localPosition
			end

			local var_121_7 = 0.001

			if var_121_6 <= arg_118_1.time_ and arg_118_1.time_ < var_121_6 + var_121_7 then
				local var_121_8 = (arg_118_1.time_ - var_121_6) / var_121_7
				local var_121_9 = Vector3.New(-0.7, -0.97, -6)

				var_121_5.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1084ui_story, var_121_9, var_121_8)

				local var_121_10 = manager.ui.mainCamera.transform.position - var_121_5.position

				var_121_5.forward = Vector3.New(var_121_10.x, var_121_10.y, var_121_10.z)

				local var_121_11 = var_121_5.localEulerAngles

				var_121_11.z = 0
				var_121_11.x = 0
				var_121_5.localEulerAngles = var_121_11
			end

			if arg_118_1.time_ >= var_121_6 + var_121_7 and arg_118_1.time_ < var_121_6 + var_121_7 + arg_121_0 then
				var_121_5.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_121_12 = manager.ui.mainCamera.transform.position - var_121_5.position

				var_121_5.forward = Vector3.New(var_121_12.x, var_121_12.y, var_121_12.z)

				local var_121_13 = var_121_5.localEulerAngles

				var_121_13.z = 0
				var_121_13.x = 0
				var_121_5.localEulerAngles = var_121_13
			end

			local var_121_14 = arg_118_1.actors_["1084ui_story"]
			local var_121_15 = 0

			if var_121_15 < arg_118_1.time_ and arg_118_1.time_ <= var_121_15 + arg_121_0 and not isNil(var_121_14) and arg_118_1.var_.characterEffect1084ui_story == nil then
				arg_118_1.var_.characterEffect1084ui_story = var_121_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_16 = 0.2

			if var_121_15 <= arg_118_1.time_ and arg_118_1.time_ < var_121_15 + var_121_16 and not isNil(var_121_14) then
				local var_121_17 = (arg_118_1.time_ - var_121_15) / var_121_16

				if arg_118_1.var_.characterEffect1084ui_story and not isNil(var_121_14) then
					arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= var_121_15 + var_121_16 and arg_118_1.time_ < var_121_15 + var_121_16 + arg_121_0 and not isNil(var_121_14) and arg_118_1.var_.characterEffect1084ui_story then
				arg_118_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_121_18 = 0

			if var_121_18 < arg_118_1.time_ and arg_118_1.time_ <= var_121_18 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			local var_121_19 = 0

			if var_121_19 < arg_118_1.time_ and arg_118_1.time_ <= var_121_19 + arg_121_0 then
				arg_118_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_121_20 = 0
			local var_121_21 = 0.325

			if var_121_20 < arg_118_1.time_ and arg_118_1.time_ <= var_121_20 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				local var_121_22 = arg_118_1:FormatText(StoryNameCfg[6].name)

				arg_118_1.leftNameTxt_.text = var_121_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_23 = arg_118_1:GetWordFromCfg(116061029)
				local var_121_24 = arg_118_1:FormatText(var_121_23.content)

				arg_118_1.text_.text = var_121_24

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_25 = 13
				local var_121_26 = utf8.len(var_121_24)
				local var_121_27 = var_121_25 <= 0 and var_121_21 or var_121_21 * (var_121_26 / var_121_25)

				if var_121_27 > 0 and var_121_21 < var_121_27 then
					arg_118_1.talkMaxDuration = var_121_27

					if var_121_27 + var_121_20 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_27 + var_121_20
					end
				end

				arg_118_1.text_.text = var_121_24
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061029", "story_v_out_116061.awb") ~= 0 then
					local var_121_28 = manager.audio:GetVoiceLength("story_v_out_116061", "116061029", "story_v_out_116061.awb") / 1000

					if var_121_28 + var_121_20 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_28 + var_121_20
					end

					if var_121_23.prefab_name ~= "" and arg_118_1.actors_[var_121_23.prefab_name] ~= nil then
						local var_121_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_23.prefab_name].transform, "story_v_out_116061", "116061029", "story_v_out_116061.awb")

						arg_118_1:RecordAudio("116061029", var_121_29)
						arg_118_1:RecordAudio("116061029", var_121_29)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_116061", "116061029", "story_v_out_116061.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_116061", "116061029", "story_v_out_116061.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_30 = math.max(var_121_21, arg_118_1.talkMaxDuration)

			if var_121_20 <= arg_118_1.time_ and arg_118_1.time_ < var_121_20 + var_121_30 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_20) / var_121_30

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_20 + var_121_30 and arg_118_1.time_ < var_121_20 + var_121_30 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play116061030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 116061030
		arg_122_1.duration_ = 6.5

		local var_122_0 = {
			zh = 4.4,
			ja = 6.5
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
				arg_122_0:Play116061031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = arg_122_1.actors_["1084ui_story"].transform
			local var_125_1 = 0

			if var_125_1 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.var_.moveOldPos1084ui_story = var_125_0.localPosition
			end

			local var_125_2 = 0.001

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_2 then
				local var_125_3 = (arg_122_1.time_ - var_125_1) / var_125_2
				local var_125_4 = Vector3.New(-0.7, -0.97, -6)

				var_125_0.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1084ui_story, var_125_4, var_125_3)

				local var_125_5 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_5.x, var_125_5.y, var_125_5.z)

				local var_125_6 = var_125_0.localEulerAngles

				var_125_6.z = 0
				var_125_6.x = 0
				var_125_0.localEulerAngles = var_125_6
			end

			if arg_122_1.time_ >= var_125_1 + var_125_2 and arg_122_1.time_ < var_125_1 + var_125_2 + arg_125_0 then
				var_125_0.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_125_7 = manager.ui.mainCamera.transform.position - var_125_0.position

				var_125_0.forward = Vector3.New(var_125_7.x, var_125_7.y, var_125_7.z)

				local var_125_8 = var_125_0.localEulerAngles

				var_125_8.z = 0
				var_125_8.x = 0
				var_125_0.localEulerAngles = var_125_8
			end

			local var_125_9 = "1011ui_story"

			if arg_122_1.actors_[var_125_9] == nil then
				local var_125_10 = Asset.Load("Char/" .. "1011ui_story")

				if not isNil(var_125_10) then
					local var_125_11 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_122_1.stage_.transform)

					var_125_11.name = var_125_9
					var_125_11.transform.localPosition = Vector3.New(0, 100, 0)
					arg_122_1.actors_[var_125_9] = var_125_11

					local var_125_12 = var_125_11:GetComponentInChildren(typeof(CharacterEffect))

					var_125_12.enabled = true

					local var_125_13 = GameObjectTools.GetOrAddComponent(var_125_11, typeof(DynamicBoneHelper))

					if var_125_13 then
						var_125_13:EnableDynamicBone(false)
					end

					arg_122_1:ShowWeapon(var_125_12.transform, false)

					arg_122_1.var_[var_125_9 .. "Animator"] = var_125_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_122_1.var_[var_125_9 .. "Animator"].applyRootMotion = true
					arg_122_1.var_[var_125_9 .. "LipSync"] = var_125_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_125_14 = arg_122_1.actors_["1011ui_story"].transform
			local var_125_15 = 0

			if var_125_15 < arg_122_1.time_ and arg_122_1.time_ <= var_125_15 + arg_125_0 then
				arg_122_1.var_.moveOldPos1011ui_story = var_125_14.localPosition
			end

			local var_125_16 = 0.001

			if var_125_15 <= arg_122_1.time_ and arg_122_1.time_ < var_125_15 + var_125_16 then
				local var_125_17 = (arg_122_1.time_ - var_125_15) / var_125_16
				local var_125_18 = Vector3.New(0.7, -0.71, -6)

				var_125_14.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1011ui_story, var_125_18, var_125_17)

				local var_125_19 = manager.ui.mainCamera.transform.position - var_125_14.position

				var_125_14.forward = Vector3.New(var_125_19.x, var_125_19.y, var_125_19.z)

				local var_125_20 = var_125_14.localEulerAngles

				var_125_20.z = 0
				var_125_20.x = 0
				var_125_14.localEulerAngles = var_125_20
			end

			if arg_122_1.time_ >= var_125_15 + var_125_16 and arg_122_1.time_ < var_125_15 + var_125_16 + arg_125_0 then
				var_125_14.localPosition = Vector3.New(0.7, -0.71, -6)

				local var_125_21 = manager.ui.mainCamera.transform.position - var_125_14.position

				var_125_14.forward = Vector3.New(var_125_21.x, var_125_21.y, var_125_21.z)

				local var_125_22 = var_125_14.localEulerAngles

				var_125_22.z = 0
				var_125_22.x = 0
				var_125_14.localEulerAngles = var_125_22
			end

			local var_125_23 = arg_122_1.actors_["1084ui_story"]
			local var_125_24 = 0

			if var_125_24 < arg_122_1.time_ and arg_122_1.time_ <= var_125_24 + arg_125_0 and not isNil(var_125_23) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = var_125_23:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_25 = 0.2

			if var_125_24 <= arg_122_1.time_ and arg_122_1.time_ < var_125_24 + var_125_25 and not isNil(var_125_23) then
				local var_125_26 = (arg_122_1.time_ - var_125_24) / var_125_25

				if arg_122_1.var_.characterEffect1084ui_story and not isNil(var_125_23) then
					local var_125_27 = Mathf.Lerp(0, 0.5, var_125_26)

					arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1084ui_story.fillRatio = var_125_27
				end
			end

			if arg_122_1.time_ >= var_125_24 + var_125_25 and arg_122_1.time_ < var_125_24 + var_125_25 + arg_125_0 and not isNil(var_125_23) and arg_122_1.var_.characterEffect1084ui_story then
				local var_125_28 = 0.5

				arg_122_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1084ui_story.fillRatio = var_125_28
			end

			local var_125_29 = arg_122_1.actors_["1011ui_story"]
			local var_125_30 = 0

			if var_125_30 < arg_122_1.time_ and arg_122_1.time_ <= var_125_30 + arg_125_0 and not isNil(var_125_29) and arg_122_1.var_.characterEffect1011ui_story == nil then
				arg_122_1.var_.characterEffect1011ui_story = var_125_29:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_31 = 0.2

			if var_125_30 <= arg_122_1.time_ and arg_122_1.time_ < var_125_30 + var_125_31 and not isNil(var_125_29) then
				local var_125_32 = (arg_122_1.time_ - var_125_30) / var_125_31

				if arg_122_1.var_.characterEffect1011ui_story and not isNil(var_125_29) then
					arg_122_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= var_125_30 + var_125_31 and arg_122_1.time_ < var_125_30 + var_125_31 + arg_125_0 and not isNil(var_125_29) and arg_122_1.var_.characterEffect1011ui_story then
				arg_122_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_125_33 = 0

			if var_125_33 < arg_122_1.time_ and arg_122_1.time_ <= var_125_33 + arg_125_0 then
				arg_122_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_125_34 = 0

			if var_125_34 < arg_122_1.time_ and arg_122_1.time_ <= var_125_34 + arg_125_0 then
				arg_122_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_125_35 = 0
			local var_125_36 = 0.5

			if var_125_35 < arg_122_1.time_ and arg_122_1.time_ <= var_125_35 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				local var_125_37 = arg_122_1:FormatText(StoryNameCfg[37].name)

				arg_122_1.leftNameTxt_.text = var_125_37

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_38 = arg_122_1:GetWordFromCfg(116061030)
				local var_125_39 = arg_122_1:FormatText(var_125_38.content)

				arg_122_1.text_.text = var_125_39

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_40 = 20
				local var_125_41 = utf8.len(var_125_39)
				local var_125_42 = var_125_40 <= 0 and var_125_36 or var_125_36 * (var_125_41 / var_125_40)

				if var_125_42 > 0 and var_125_36 < var_125_42 then
					arg_122_1.talkMaxDuration = var_125_42

					if var_125_42 + var_125_35 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_42 + var_125_35
					end
				end

				arg_122_1.text_.text = var_125_39
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061030", "story_v_out_116061.awb") ~= 0 then
					local var_125_43 = manager.audio:GetVoiceLength("story_v_out_116061", "116061030", "story_v_out_116061.awb") / 1000

					if var_125_43 + var_125_35 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_43 + var_125_35
					end

					if var_125_38.prefab_name ~= "" and arg_122_1.actors_[var_125_38.prefab_name] ~= nil then
						local var_125_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_38.prefab_name].transform, "story_v_out_116061", "116061030", "story_v_out_116061.awb")

						arg_122_1:RecordAudio("116061030", var_125_44)
						arg_122_1:RecordAudio("116061030", var_125_44)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_116061", "116061030", "story_v_out_116061.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_116061", "116061030", "story_v_out_116061.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_45 = math.max(var_125_36, arg_122_1.talkMaxDuration)

			if var_125_35 <= arg_122_1.time_ and arg_122_1.time_ < var_125_35 + var_125_45 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_35) / var_125_45

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_35 + var_125_45 and arg_122_1.time_ < var_125_35 + var_125_45 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play116061031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 116061031
		arg_126_1.duration_ = 9.17

		local var_126_0 = {
			zh = 4.3,
			ja = 9.166
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play116061032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = arg_126_1.actors_["1084ui_story"]
			local var_129_1 = 0

			if var_129_1 < arg_126_1.time_ and arg_126_1.time_ <= var_129_1 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1084ui_story == nil then
				arg_126_1.var_.characterEffect1084ui_story = var_129_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_2 = 0.2

			if var_129_1 <= arg_126_1.time_ and arg_126_1.time_ < var_129_1 + var_129_2 and not isNil(var_129_0) then
				local var_129_3 = (arg_126_1.time_ - var_129_1) / var_129_2

				if arg_126_1.var_.characterEffect1084ui_story and not isNil(var_129_0) then
					arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= var_129_1 + var_129_2 and arg_126_1.time_ < var_129_1 + var_129_2 + arg_129_0 and not isNil(var_129_0) and arg_126_1.var_.characterEffect1084ui_story then
				arg_126_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_129_4 = arg_126_1.actors_["1011ui_story"]
			local var_129_5 = 0

			if var_129_5 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect1011ui_story == nil then
				arg_126_1.var_.characterEffect1011ui_story = var_129_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_6 = 0.2

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_6 and not isNil(var_129_4) then
				local var_129_7 = (arg_126_1.time_ - var_129_5) / var_129_6

				if arg_126_1.var_.characterEffect1011ui_story and not isNil(var_129_4) then
					local var_129_8 = Mathf.Lerp(0, 0.5, var_129_7)

					arg_126_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1011ui_story.fillRatio = var_129_8
				end
			end

			if arg_126_1.time_ >= var_129_5 + var_129_6 and arg_126_1.time_ < var_129_5 + var_129_6 + arg_129_0 and not isNil(var_129_4) and arg_126_1.var_.characterEffect1011ui_story then
				local var_129_9 = 0.5

				arg_126_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1011ui_story.fillRatio = var_129_9
			end

			local var_129_10 = 0

			if var_129_10 < arg_126_1.time_ and arg_126_1.time_ <= var_129_10 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action457")
			end

			local var_129_11 = 0

			if var_129_11 < arg_126_1.time_ and arg_126_1.time_ <= var_129_11 + arg_129_0 then
				arg_126_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_129_12 = 0
			local var_129_13 = 0.45

			if var_129_12 < arg_126_1.time_ and arg_126_1.time_ <= var_129_12 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				local var_129_14 = arg_126_1:FormatText(StoryNameCfg[6].name)

				arg_126_1.leftNameTxt_.text = var_129_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_15 = arg_126_1:GetWordFromCfg(116061031)
				local var_129_16 = arg_126_1:FormatText(var_129_15.content)

				arg_126_1.text_.text = var_129_16

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_17 = 18
				local var_129_18 = utf8.len(var_129_16)
				local var_129_19 = var_129_17 <= 0 and var_129_13 or var_129_13 * (var_129_18 / var_129_17)

				if var_129_19 > 0 and var_129_13 < var_129_19 then
					arg_126_1.talkMaxDuration = var_129_19

					if var_129_19 + var_129_12 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_19 + var_129_12
					end
				end

				arg_126_1.text_.text = var_129_16
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061031", "story_v_out_116061.awb") ~= 0 then
					local var_129_20 = manager.audio:GetVoiceLength("story_v_out_116061", "116061031", "story_v_out_116061.awb") / 1000

					if var_129_20 + var_129_12 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_20 + var_129_12
					end

					if var_129_15.prefab_name ~= "" and arg_126_1.actors_[var_129_15.prefab_name] ~= nil then
						local var_129_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_15.prefab_name].transform, "story_v_out_116061", "116061031", "story_v_out_116061.awb")

						arg_126_1:RecordAudio("116061031", var_129_21)
						arg_126_1:RecordAudio("116061031", var_129_21)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_116061", "116061031", "story_v_out_116061.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_116061", "116061031", "story_v_out_116061.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_22 = math.max(var_129_13, arg_126_1.talkMaxDuration)

			if var_129_12 <= arg_126_1.time_ and arg_126_1.time_ < var_129_12 + var_129_22 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_12) / var_129_22

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_12 + var_129_22 and arg_126_1.time_ < var_129_12 + var_129_22 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play116061032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 116061032
		arg_130_1.duration_ = 10.2

		local var_130_0 = {
			zh = 10.2,
			ja = 10.033
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play116061033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 0

			if var_133_0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_0 + arg_133_0 then
				arg_130_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_133_1 = 0
			local var_133_2 = 1.075

			if var_133_1 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				local var_133_3 = arg_130_1:FormatText(StoryNameCfg[6].name)

				arg_130_1.leftNameTxt_.text = var_133_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_4 = arg_130_1:GetWordFromCfg(116061032)
				local var_133_5 = arg_130_1:FormatText(var_133_4.content)

				arg_130_1.text_.text = var_133_5

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_6 = 41
				local var_133_7 = utf8.len(var_133_5)
				local var_133_8 = var_133_6 <= 0 and var_133_2 or var_133_2 * (var_133_7 / var_133_6)

				if var_133_8 > 0 and var_133_2 < var_133_8 then
					arg_130_1.talkMaxDuration = var_133_8

					if var_133_8 + var_133_1 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_8 + var_133_1
					end
				end

				arg_130_1.text_.text = var_133_5
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061032", "story_v_out_116061.awb") ~= 0 then
					local var_133_9 = manager.audio:GetVoiceLength("story_v_out_116061", "116061032", "story_v_out_116061.awb") / 1000

					if var_133_9 + var_133_1 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_9 + var_133_1
					end

					if var_133_4.prefab_name ~= "" and arg_130_1.actors_[var_133_4.prefab_name] ~= nil then
						local var_133_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_4.prefab_name].transform, "story_v_out_116061", "116061032", "story_v_out_116061.awb")

						arg_130_1:RecordAudio("116061032", var_133_10)
						arg_130_1:RecordAudio("116061032", var_133_10)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_116061", "116061032", "story_v_out_116061.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_116061", "116061032", "story_v_out_116061.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_11 = math.max(var_133_2, arg_130_1.talkMaxDuration)

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_11 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_1) / var_133_11

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_1 + var_133_11 and arg_130_1.time_ < var_133_1 + var_133_11 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play116061033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 116061033
		arg_134_1.duration_ = 9.77

		local var_134_0 = {
			zh = 9.766,
			ja = 4
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play116061034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0

			if var_137_0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_0 + arg_137_0 then
				arg_134_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011actionlink/1011action426")
			end

			local var_137_1 = 0

			if var_137_1 < arg_134_1.time_ and arg_134_1.time_ <= var_137_1 + arg_137_0 then
				arg_134_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_137_2 = arg_134_1.actors_["1084ui_story"]
			local var_137_3 = 0

			if var_137_3 < arg_134_1.time_ and arg_134_1.time_ <= var_137_3 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.characterEffect1084ui_story == nil then
				arg_134_1.var_.characterEffect1084ui_story = var_137_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_4 = 0.2

			if var_137_3 <= arg_134_1.time_ and arg_134_1.time_ < var_137_3 + var_137_4 and not isNil(var_137_2) then
				local var_137_5 = (arg_134_1.time_ - var_137_3) / var_137_4

				if arg_134_1.var_.characterEffect1084ui_story and not isNil(var_137_2) then
					local var_137_6 = Mathf.Lerp(0, 0.5, var_137_5)

					arg_134_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1084ui_story.fillRatio = var_137_6
				end
			end

			if arg_134_1.time_ >= var_137_3 + var_137_4 and arg_134_1.time_ < var_137_3 + var_137_4 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.characterEffect1084ui_story then
				local var_137_7 = 0.5

				arg_134_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1084ui_story.fillRatio = var_137_7
			end

			local var_137_8 = arg_134_1.actors_["1011ui_story"]
			local var_137_9 = 0

			if var_137_9 < arg_134_1.time_ and arg_134_1.time_ <= var_137_9 + arg_137_0 and not isNil(var_137_8) and arg_134_1.var_.characterEffect1011ui_story == nil then
				arg_134_1.var_.characterEffect1011ui_story = var_137_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_10 = 0.2

			if var_137_9 <= arg_134_1.time_ and arg_134_1.time_ < var_137_9 + var_137_10 and not isNil(var_137_8) then
				local var_137_11 = (arg_134_1.time_ - var_137_9) / var_137_10

				if arg_134_1.var_.characterEffect1011ui_story and not isNil(var_137_8) then
					arg_134_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= var_137_9 + var_137_10 and arg_134_1.time_ < var_137_9 + var_137_10 + arg_137_0 and not isNil(var_137_8) and arg_134_1.var_.characterEffect1011ui_story then
				arg_134_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_137_12 = 0
			local var_137_13 = 1.025

			if var_137_12 < arg_134_1.time_ and arg_134_1.time_ <= var_137_12 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				local var_137_14 = arg_134_1:FormatText(StoryNameCfg[37].name)

				arg_134_1.leftNameTxt_.text = var_137_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_15 = arg_134_1:GetWordFromCfg(116061033)
				local var_137_16 = arg_134_1:FormatText(var_137_15.content)

				arg_134_1.text_.text = var_137_16

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_17 = 41
				local var_137_18 = utf8.len(var_137_16)
				local var_137_19 = var_137_17 <= 0 and var_137_13 or var_137_13 * (var_137_18 / var_137_17)

				if var_137_19 > 0 and var_137_13 < var_137_19 then
					arg_134_1.talkMaxDuration = var_137_19

					if var_137_19 + var_137_12 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_19 + var_137_12
					end
				end

				arg_134_1.text_.text = var_137_16
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061033", "story_v_out_116061.awb") ~= 0 then
					local var_137_20 = manager.audio:GetVoiceLength("story_v_out_116061", "116061033", "story_v_out_116061.awb") / 1000

					if var_137_20 + var_137_12 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_20 + var_137_12
					end

					if var_137_15.prefab_name ~= "" and arg_134_1.actors_[var_137_15.prefab_name] ~= nil then
						local var_137_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_15.prefab_name].transform, "story_v_out_116061", "116061033", "story_v_out_116061.awb")

						arg_134_1:RecordAudio("116061033", var_137_21)
						arg_134_1:RecordAudio("116061033", var_137_21)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_116061", "116061033", "story_v_out_116061.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_116061", "116061033", "story_v_out_116061.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_22 = math.max(var_137_13, arg_134_1.talkMaxDuration)

			if var_137_12 <= arg_134_1.time_ and arg_134_1.time_ < var_137_12 + var_137_22 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_12) / var_137_22

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_12 + var_137_22 and arg_134_1.time_ < var_137_12 + var_137_22 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play116061034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 116061034
		arg_138_1.duration_ = 5.47

		local var_138_0 = {
			zh = 4.7,
			ja = 5.466
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play116061035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0

			if var_141_0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_141_1 = 0
			local var_141_2 = 0.475

			if var_141_1 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				local var_141_3 = arg_138_1:FormatText(StoryNameCfg[37].name)

				arg_138_1.leftNameTxt_.text = var_141_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_4 = arg_138_1:GetWordFromCfg(116061034)
				local var_141_5 = arg_138_1:FormatText(var_141_4.content)

				arg_138_1.text_.text = var_141_5

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_6 = 19
				local var_141_7 = utf8.len(var_141_5)
				local var_141_8 = var_141_6 <= 0 and var_141_2 or var_141_2 * (var_141_7 / var_141_6)

				if var_141_8 > 0 and var_141_2 < var_141_8 then
					arg_138_1.talkMaxDuration = var_141_8

					if var_141_8 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_8 + var_141_1
					end
				end

				arg_138_1.text_.text = var_141_5
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061034", "story_v_out_116061.awb") ~= 0 then
					local var_141_9 = manager.audio:GetVoiceLength("story_v_out_116061", "116061034", "story_v_out_116061.awb") / 1000

					if var_141_9 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_9 + var_141_1
					end

					if var_141_4.prefab_name ~= "" and arg_138_1.actors_[var_141_4.prefab_name] ~= nil then
						local var_141_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_4.prefab_name].transform, "story_v_out_116061", "116061034", "story_v_out_116061.awb")

						arg_138_1:RecordAudio("116061034", var_141_10)
						arg_138_1:RecordAudio("116061034", var_141_10)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_116061", "116061034", "story_v_out_116061.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_116061", "116061034", "story_v_out_116061.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_11 = math.max(var_141_2, arg_138_1.talkMaxDuration)

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_11 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_1) / var_141_11

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_1 + var_141_11 and arg_138_1.time_ < var_141_1 + var_141_11 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play116061035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 116061035
		arg_142_1.duration_ = 7.3

		local var_142_0 = {
			zh = 5.866,
			ja = 7.3
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play116061036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = arg_142_1.actors_["1084ui_story"]
			local var_145_1 = 0

			if var_145_1 < arg_142_1.time_ and arg_142_1.time_ <= var_145_1 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1084ui_story == nil then
				arg_142_1.var_.characterEffect1084ui_story = var_145_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_2 = 0.2

			if var_145_1 <= arg_142_1.time_ and arg_142_1.time_ < var_145_1 + var_145_2 and not isNil(var_145_0) then
				local var_145_3 = (arg_142_1.time_ - var_145_1) / var_145_2

				if arg_142_1.var_.characterEffect1084ui_story and not isNil(var_145_0) then
					arg_142_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= var_145_1 + var_145_2 and arg_142_1.time_ < var_145_1 + var_145_2 + arg_145_0 and not isNil(var_145_0) and arg_142_1.var_.characterEffect1084ui_story then
				arg_142_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_145_4 = arg_142_1.actors_["1011ui_story"]
			local var_145_5 = 0

			if var_145_5 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 and not isNil(var_145_4) and arg_142_1.var_.characterEffect1011ui_story == nil then
				arg_142_1.var_.characterEffect1011ui_story = var_145_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_6 = 0.2

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_6 and not isNil(var_145_4) then
				local var_145_7 = (arg_142_1.time_ - var_145_5) / var_145_6

				if arg_142_1.var_.characterEffect1011ui_story and not isNil(var_145_4) then
					local var_145_8 = Mathf.Lerp(0, 0.5, var_145_7)

					arg_142_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_142_1.var_.characterEffect1011ui_story.fillRatio = var_145_8
				end
			end

			if arg_142_1.time_ >= var_145_5 + var_145_6 and arg_142_1.time_ < var_145_5 + var_145_6 + arg_145_0 and not isNil(var_145_4) and arg_142_1.var_.characterEffect1011ui_story then
				local var_145_9 = 0.5

				arg_142_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_142_1.var_.characterEffect1011ui_story.fillRatio = var_145_9
			end

			local var_145_10 = 0

			if var_145_10 < arg_142_1.time_ and arg_142_1.time_ <= var_145_10 + arg_145_0 then
				arg_142_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action476")
			end

			local var_145_11 = 0

			if var_145_11 < arg_142_1.time_ and arg_142_1.time_ <= var_145_11 + arg_145_0 then
				arg_142_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_145_12 = 0
			local var_145_13 = 0.3

			if var_145_12 < arg_142_1.time_ and arg_142_1.time_ <= var_145_12 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				local var_145_14 = arg_142_1:FormatText(StoryNameCfg[6].name)

				arg_142_1.leftNameTxt_.text = var_145_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_15 = arg_142_1:GetWordFromCfg(116061035)
				local var_145_16 = arg_142_1:FormatText(var_145_15.content)

				arg_142_1.text_.text = var_145_16

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_17 = 12
				local var_145_18 = utf8.len(var_145_16)
				local var_145_19 = var_145_17 <= 0 and var_145_13 or var_145_13 * (var_145_18 / var_145_17)

				if var_145_19 > 0 and var_145_13 < var_145_19 then
					arg_142_1.talkMaxDuration = var_145_19

					if var_145_19 + var_145_12 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_19 + var_145_12
					end
				end

				arg_142_1.text_.text = var_145_16
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061035", "story_v_out_116061.awb") ~= 0 then
					local var_145_20 = manager.audio:GetVoiceLength("story_v_out_116061", "116061035", "story_v_out_116061.awb") / 1000

					if var_145_20 + var_145_12 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_20 + var_145_12
					end

					if var_145_15.prefab_name ~= "" and arg_142_1.actors_[var_145_15.prefab_name] ~= nil then
						local var_145_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_15.prefab_name].transform, "story_v_out_116061", "116061035", "story_v_out_116061.awb")

						arg_142_1:RecordAudio("116061035", var_145_21)
						arg_142_1:RecordAudio("116061035", var_145_21)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_116061", "116061035", "story_v_out_116061.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_116061", "116061035", "story_v_out_116061.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_22 = math.max(var_145_13, arg_142_1.talkMaxDuration)

			if var_145_12 <= arg_142_1.time_ and arg_142_1.time_ < var_145_12 + var_145_22 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_12) / var_145_22

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_12 + var_145_22 and arg_142_1.time_ < var_145_12 + var_145_22 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play116061036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 116061036
		arg_146_1.duration_ = 8.53

		local var_146_0 = {
			zh = 7.7,
			ja = 8.533
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play116061037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = arg_146_1.actors_["1084ui_story"]
			local var_149_1 = 0

			if var_149_1 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1084ui_story == nil then
				arg_146_1.var_.characterEffect1084ui_story = var_149_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_2 = 0.2

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_2 and not isNil(var_149_0) then
				local var_149_3 = (arg_146_1.time_ - var_149_1) / var_149_2

				if arg_146_1.var_.characterEffect1084ui_story and not isNil(var_149_0) then
					local var_149_4 = Mathf.Lerp(0, 0.5, var_149_3)

					arg_146_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_146_1.var_.characterEffect1084ui_story.fillRatio = var_149_4
				end
			end

			if arg_146_1.time_ >= var_149_1 + var_149_2 and arg_146_1.time_ < var_149_1 + var_149_2 + arg_149_0 and not isNil(var_149_0) and arg_146_1.var_.characterEffect1084ui_story then
				local var_149_5 = 0.5

				arg_146_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_146_1.var_.characterEffect1084ui_story.fillRatio = var_149_5
			end

			local var_149_6 = arg_146_1.actors_["1011ui_story"]
			local var_149_7 = 0

			if var_149_7 < arg_146_1.time_ and arg_146_1.time_ <= var_149_7 + arg_149_0 and not isNil(var_149_6) and arg_146_1.var_.characterEffect1011ui_story == nil then
				arg_146_1.var_.characterEffect1011ui_story = var_149_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_8 = 0.2

			if var_149_7 <= arg_146_1.time_ and arg_146_1.time_ < var_149_7 + var_149_8 and not isNil(var_149_6) then
				local var_149_9 = (arg_146_1.time_ - var_149_7) / var_149_8

				if arg_146_1.var_.characterEffect1011ui_story and not isNil(var_149_6) then
					arg_146_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_146_1.time_ >= var_149_7 + var_149_8 and arg_146_1.time_ < var_149_7 + var_149_8 + arg_149_0 and not isNil(var_149_6) and arg_146_1.var_.characterEffect1011ui_story then
				arg_146_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_149_10 = 0

			if var_149_10 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 then
				arg_146_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_149_11 = 0
			local var_149_12 = 0.7

			if var_149_11 < arg_146_1.time_ and arg_146_1.time_ <= var_149_11 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				local var_149_13 = arg_146_1:FormatText(StoryNameCfg[37].name)

				arg_146_1.leftNameTxt_.text = var_149_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_14 = arg_146_1:GetWordFromCfg(116061036)
				local var_149_15 = arg_146_1:FormatText(var_149_14.content)

				arg_146_1.text_.text = var_149_15

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_16 = 28
				local var_149_17 = utf8.len(var_149_15)
				local var_149_18 = var_149_16 <= 0 and var_149_12 or var_149_12 * (var_149_17 / var_149_16)

				if var_149_18 > 0 and var_149_12 < var_149_18 then
					arg_146_1.talkMaxDuration = var_149_18

					if var_149_18 + var_149_11 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_18 + var_149_11
					end
				end

				arg_146_1.text_.text = var_149_15
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061036", "story_v_out_116061.awb") ~= 0 then
					local var_149_19 = manager.audio:GetVoiceLength("story_v_out_116061", "116061036", "story_v_out_116061.awb") / 1000

					if var_149_19 + var_149_11 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_19 + var_149_11
					end

					if var_149_14.prefab_name ~= "" and arg_146_1.actors_[var_149_14.prefab_name] ~= nil then
						local var_149_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_14.prefab_name].transform, "story_v_out_116061", "116061036", "story_v_out_116061.awb")

						arg_146_1:RecordAudio("116061036", var_149_20)
						arg_146_1:RecordAudio("116061036", var_149_20)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_116061", "116061036", "story_v_out_116061.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_116061", "116061036", "story_v_out_116061.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_21 = math.max(var_149_12, arg_146_1.talkMaxDuration)

			if var_149_11 <= arg_146_1.time_ and arg_146_1.time_ < var_149_11 + var_149_21 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_11) / var_149_21

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_11 + var_149_21 and arg_146_1.time_ < var_149_11 + var_149_21 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play116061037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 116061037
		arg_150_1.duration_ = 4.93

		local var_150_0 = {
			zh = 4.933,
			ja = 3.566
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play116061038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = arg_150_1.actors_["1084ui_story"]
			local var_153_1 = 0

			if var_153_1 < arg_150_1.time_ and arg_150_1.time_ <= var_153_1 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1084ui_story == nil then
				arg_150_1.var_.characterEffect1084ui_story = var_153_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_2 = 0.2

			if var_153_1 <= arg_150_1.time_ and arg_150_1.time_ < var_153_1 + var_153_2 and not isNil(var_153_0) then
				local var_153_3 = (arg_150_1.time_ - var_153_1) / var_153_2

				if arg_150_1.var_.characterEffect1084ui_story and not isNil(var_153_0) then
					arg_150_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= var_153_1 + var_153_2 and arg_150_1.time_ < var_153_1 + var_153_2 + arg_153_0 and not isNil(var_153_0) and arg_150_1.var_.characterEffect1084ui_story then
				arg_150_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_153_4 = arg_150_1.actors_["1011ui_story"]
			local var_153_5 = 0

			if var_153_5 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect1011ui_story == nil then
				arg_150_1.var_.characterEffect1011ui_story = var_153_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_6 = 0.2

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_6 and not isNil(var_153_4) then
				local var_153_7 = (arg_150_1.time_ - var_153_5) / var_153_6

				if arg_150_1.var_.characterEffect1011ui_story and not isNil(var_153_4) then
					local var_153_8 = Mathf.Lerp(0, 0.5, var_153_7)

					arg_150_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_150_1.var_.characterEffect1011ui_story.fillRatio = var_153_8
				end
			end

			if arg_150_1.time_ >= var_153_5 + var_153_6 and arg_150_1.time_ < var_153_5 + var_153_6 + arg_153_0 and not isNil(var_153_4) and arg_150_1.var_.characterEffect1011ui_story then
				local var_153_9 = 0.5

				arg_150_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_150_1.var_.characterEffect1011ui_story.fillRatio = var_153_9
			end

			local var_153_10 = 0

			if var_153_10 < arg_150_1.time_ and arg_150_1.time_ <= var_153_10 + arg_153_0 then
				arg_150_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action464")
			end

			local var_153_11 = 0

			if var_153_11 < arg_150_1.time_ and arg_150_1.time_ <= var_153_11 + arg_153_0 then
				arg_150_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_153_12 = 0
			local var_153_13 = 0.55

			if var_153_12 < arg_150_1.time_ and arg_150_1.time_ <= var_153_12 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				local var_153_14 = arg_150_1:FormatText(StoryNameCfg[6].name)

				arg_150_1.leftNameTxt_.text = var_153_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_15 = arg_150_1:GetWordFromCfg(116061037)
				local var_153_16 = arg_150_1:FormatText(var_153_15.content)

				arg_150_1.text_.text = var_153_16

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_17 = 22
				local var_153_18 = utf8.len(var_153_16)
				local var_153_19 = var_153_17 <= 0 and var_153_13 or var_153_13 * (var_153_18 / var_153_17)

				if var_153_19 > 0 and var_153_13 < var_153_19 then
					arg_150_1.talkMaxDuration = var_153_19

					if var_153_19 + var_153_12 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_19 + var_153_12
					end
				end

				arg_150_1.text_.text = var_153_16
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061037", "story_v_out_116061.awb") ~= 0 then
					local var_153_20 = manager.audio:GetVoiceLength("story_v_out_116061", "116061037", "story_v_out_116061.awb") / 1000

					if var_153_20 + var_153_12 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_20 + var_153_12
					end

					if var_153_15.prefab_name ~= "" and arg_150_1.actors_[var_153_15.prefab_name] ~= nil then
						local var_153_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_15.prefab_name].transform, "story_v_out_116061", "116061037", "story_v_out_116061.awb")

						arg_150_1:RecordAudio("116061037", var_153_21)
						arg_150_1:RecordAudio("116061037", var_153_21)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_116061", "116061037", "story_v_out_116061.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_116061", "116061037", "story_v_out_116061.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_22 = math.max(var_153_13, arg_150_1.talkMaxDuration)

			if var_153_12 <= arg_150_1.time_ and arg_150_1.time_ < var_153_12 + var_153_22 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_12) / var_153_22

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_12 + var_153_22 and arg_150_1.time_ < var_153_12 + var_153_22 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play116061038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 116061038
		arg_154_1.duration_ = 6.2

		local var_154_0 = {
			zh = 4.366,
			ja = 6.2
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play116061039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = arg_154_1.actors_["1084ui_story"]
			local var_157_1 = 0

			if var_157_1 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1084ui_story == nil then
				arg_154_1.var_.characterEffect1084ui_story = var_157_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_2 = 0.2

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_2 and not isNil(var_157_0) then
				local var_157_3 = (arg_154_1.time_ - var_157_1) / var_157_2

				if arg_154_1.var_.characterEffect1084ui_story and not isNil(var_157_0) then
					local var_157_4 = Mathf.Lerp(0, 0.5, var_157_3)

					arg_154_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_154_1.var_.characterEffect1084ui_story.fillRatio = var_157_4
				end
			end

			if arg_154_1.time_ >= var_157_1 + var_157_2 and arg_154_1.time_ < var_157_1 + var_157_2 + arg_157_0 and not isNil(var_157_0) and arg_154_1.var_.characterEffect1084ui_story then
				local var_157_5 = 0.5

				arg_154_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_154_1.var_.characterEffect1084ui_story.fillRatio = var_157_5
			end

			local var_157_6 = arg_154_1.actors_["1011ui_story"]
			local var_157_7 = 0

			if var_157_7 < arg_154_1.time_ and arg_154_1.time_ <= var_157_7 + arg_157_0 and not isNil(var_157_6) and arg_154_1.var_.characterEffect1011ui_story == nil then
				arg_154_1.var_.characterEffect1011ui_story = var_157_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_8 = 0.2

			if var_157_7 <= arg_154_1.time_ and arg_154_1.time_ < var_157_7 + var_157_8 and not isNil(var_157_6) then
				local var_157_9 = (arg_154_1.time_ - var_157_7) / var_157_8

				if arg_154_1.var_.characterEffect1011ui_story and not isNil(var_157_6) then
					arg_154_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_154_1.time_ >= var_157_7 + var_157_8 and arg_154_1.time_ < var_157_7 + var_157_8 + arg_157_0 and not isNil(var_157_6) and arg_154_1.var_.characterEffect1011ui_story then
				arg_154_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_157_10 = 0

			if var_157_10 < arg_154_1.time_ and arg_154_1.time_ <= var_157_10 + arg_157_0 then
				arg_154_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			local var_157_11 = 0

			if var_157_11 < arg_154_1.time_ and arg_154_1.time_ <= var_157_11 + arg_157_0 then
				arg_154_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_157_12 = 0
			local var_157_13 = 0.45

			if var_157_12 < arg_154_1.time_ and arg_154_1.time_ <= var_157_12 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				local var_157_14 = arg_154_1:FormatText(StoryNameCfg[37].name)

				arg_154_1.leftNameTxt_.text = var_157_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_15 = arg_154_1:GetWordFromCfg(116061038)
				local var_157_16 = arg_154_1:FormatText(var_157_15.content)

				arg_154_1.text_.text = var_157_16

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_17 = 18
				local var_157_18 = utf8.len(var_157_16)
				local var_157_19 = var_157_17 <= 0 and var_157_13 or var_157_13 * (var_157_18 / var_157_17)

				if var_157_19 > 0 and var_157_13 < var_157_19 then
					arg_154_1.talkMaxDuration = var_157_19

					if var_157_19 + var_157_12 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_19 + var_157_12
					end
				end

				arg_154_1.text_.text = var_157_16
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061038", "story_v_out_116061.awb") ~= 0 then
					local var_157_20 = manager.audio:GetVoiceLength("story_v_out_116061", "116061038", "story_v_out_116061.awb") / 1000

					if var_157_20 + var_157_12 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_20 + var_157_12
					end

					if var_157_15.prefab_name ~= "" and arg_154_1.actors_[var_157_15.prefab_name] ~= nil then
						local var_157_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_15.prefab_name].transform, "story_v_out_116061", "116061038", "story_v_out_116061.awb")

						arg_154_1:RecordAudio("116061038", var_157_21)
						arg_154_1:RecordAudio("116061038", var_157_21)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_116061", "116061038", "story_v_out_116061.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_116061", "116061038", "story_v_out_116061.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_22 = math.max(var_157_13, arg_154_1.talkMaxDuration)

			if var_157_12 <= arg_154_1.time_ and arg_154_1.time_ < var_157_12 + var_157_22 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_12) / var_157_22

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_12 + var_157_22 and arg_154_1.time_ < var_157_12 + var_157_22 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play116061039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 116061039
		arg_158_1.duration_ = 9

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play116061040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = "ST02"

			if arg_158_1.bgs_[var_161_0] == nil then
				local var_161_1 = Object.Instantiate(arg_158_1.paintGo_)

				var_161_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_161_0)
				var_161_1.name = var_161_0
				var_161_1.transform.parent = arg_158_1.stage_.transform
				var_161_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_158_1.bgs_[var_161_0] = var_161_1
			end

			local var_161_2 = 2

			if var_161_2 < arg_158_1.time_ and arg_158_1.time_ <= var_161_2 + arg_161_0 then
				if arg_158_0.sceneSettingEffect_ then
					arg_158_1.sceneSettingEffect_.enabled = false
				end

				arg_158_1.sceneSettingGo_:SetActive(true)

				local var_161_3 = manager.ui.mainCamera.transform.localPosition
				local var_161_4 = Vector3.New(0, 0, 10) + Vector3.New(var_161_3.x, var_161_3.y, 0)
				local var_161_5 = arg_158_1.bgs_.ST02

				var_161_5.transform.localPosition = var_161_4
				var_161_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_161_6 = var_161_5:GetComponent("SpriteRenderer")

				if var_161_6 and var_161_6.sprite then
					local var_161_7 = (var_161_5.transform.localPosition - var_161_3).z
					local var_161_8 = manager.ui.mainCameraCom_
					local var_161_9 = 2 * var_161_7 * Mathf.Tan(var_161_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_161_10 = var_161_9 * var_161_8.aspect
					local var_161_11 = var_161_6.sprite.bounds.size.x
					local var_161_12 = var_161_6.sprite.bounds.size.y
					local var_161_13 = var_161_10 / var_161_11
					local var_161_14 = var_161_9 / var_161_12
					local var_161_15 = var_161_14 < var_161_13 and var_161_13 or var_161_14

					var_161_5.transform.localScale = Vector3.New(var_161_15, var_161_15, 0)
				end

				for iter_161_0, iter_161_1 in pairs(arg_158_1.bgs_) do
					if iter_161_0 ~= "ST02" then
						iter_161_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_161_16 = arg_158_1.actors_["1084ui_story"].transform
			local var_161_17 = 1.98333333333333

			if var_161_17 < arg_158_1.time_ and arg_158_1.time_ <= var_161_17 + arg_161_0 then
				arg_158_1.var_.moveOldPos1084ui_story = var_161_16.localPosition
			end

			local var_161_18 = 0.001

			if var_161_17 <= arg_158_1.time_ and arg_158_1.time_ < var_161_17 + var_161_18 then
				local var_161_19 = (arg_158_1.time_ - var_161_17) / var_161_18
				local var_161_20 = Vector3.New(0, 100, 0)

				var_161_16.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1084ui_story, var_161_20, var_161_19)

				local var_161_21 = manager.ui.mainCamera.transform.position - var_161_16.position

				var_161_16.forward = Vector3.New(var_161_21.x, var_161_21.y, var_161_21.z)

				local var_161_22 = var_161_16.localEulerAngles

				var_161_22.z = 0
				var_161_22.x = 0
				var_161_16.localEulerAngles = var_161_22
			end

			if arg_158_1.time_ >= var_161_17 + var_161_18 and arg_158_1.time_ < var_161_17 + var_161_18 + arg_161_0 then
				var_161_16.localPosition = Vector3.New(0, 100, 0)

				local var_161_23 = manager.ui.mainCamera.transform.position - var_161_16.position

				var_161_16.forward = Vector3.New(var_161_23.x, var_161_23.y, var_161_23.z)

				local var_161_24 = var_161_16.localEulerAngles

				var_161_24.z = 0
				var_161_24.x = 0
				var_161_16.localEulerAngles = var_161_24
			end

			local var_161_25 = arg_158_1.actors_["1011ui_story"].transform
			local var_161_26 = 1.98333333333333

			if var_161_26 < arg_158_1.time_ and arg_158_1.time_ <= var_161_26 + arg_161_0 then
				arg_158_1.var_.moveOldPos1011ui_story = var_161_25.localPosition
			end

			local var_161_27 = 0.001

			if var_161_26 <= arg_158_1.time_ and arg_158_1.time_ < var_161_26 + var_161_27 then
				local var_161_28 = (arg_158_1.time_ - var_161_26) / var_161_27
				local var_161_29 = Vector3.New(0, 100, 0)

				var_161_25.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1011ui_story, var_161_29, var_161_28)

				local var_161_30 = manager.ui.mainCamera.transform.position - var_161_25.position

				var_161_25.forward = Vector3.New(var_161_30.x, var_161_30.y, var_161_30.z)

				local var_161_31 = var_161_25.localEulerAngles

				var_161_31.z = 0
				var_161_31.x = 0
				var_161_25.localEulerAngles = var_161_31
			end

			if arg_158_1.time_ >= var_161_26 + var_161_27 and arg_158_1.time_ < var_161_26 + var_161_27 + arg_161_0 then
				var_161_25.localPosition = Vector3.New(0, 100, 0)

				local var_161_32 = manager.ui.mainCamera.transform.position - var_161_25.position

				var_161_25.forward = Vector3.New(var_161_32.x, var_161_32.y, var_161_32.z)

				local var_161_33 = var_161_25.localEulerAngles

				var_161_33.z = 0
				var_161_33.x = 0
				var_161_25.localEulerAngles = var_161_33
			end

			local var_161_34 = 0

			if var_161_34 < arg_158_1.time_ and arg_158_1.time_ <= var_161_34 + arg_161_0 then
				arg_158_1.mask_.enabled = true
				arg_158_1.mask_.raycastTarget = true

				arg_158_1:SetGaussion(false)
			end

			local var_161_35 = 2

			if var_161_34 <= arg_158_1.time_ and arg_158_1.time_ < var_161_34 + var_161_35 then
				local var_161_36 = (arg_158_1.time_ - var_161_34) / var_161_35
				local var_161_37 = Color.New(0.01886791, 0.01886791, 0.01886791)

				var_161_37.a = Mathf.Lerp(0, 1, var_161_36)
				arg_158_1.mask_.color = var_161_37
			end

			if arg_158_1.time_ >= var_161_34 + var_161_35 and arg_158_1.time_ < var_161_34 + var_161_35 + arg_161_0 then
				local var_161_38 = Color.New(0.01886791, 0.01886791, 0.01886791)

				var_161_38.a = 1
				arg_158_1.mask_.color = var_161_38
			end

			local var_161_39 = 2

			if var_161_39 < arg_158_1.time_ and arg_158_1.time_ <= var_161_39 + arg_161_0 then
				arg_158_1.mask_.enabled = true
				arg_158_1.mask_.raycastTarget = true

				arg_158_1:SetGaussion(false)
			end

			local var_161_40 = 2

			if var_161_39 <= arg_158_1.time_ and arg_158_1.time_ < var_161_39 + var_161_40 then
				local var_161_41 = (arg_158_1.time_ - var_161_39) / var_161_40
				local var_161_42 = Color.New(0.01886791, 0.01886791, 0.01886791)

				var_161_42.a = Mathf.Lerp(1, 0, var_161_41)
				arg_158_1.mask_.color = var_161_42
			end

			if arg_158_1.time_ >= var_161_39 + var_161_40 and arg_158_1.time_ < var_161_39 + var_161_40 + arg_161_0 then
				local var_161_43 = Color.New(0.01886791, 0.01886791, 0.01886791)
				local var_161_44 = 0

				arg_158_1.mask_.enabled = false
				var_161_43.a = var_161_44
				arg_158_1.mask_.color = var_161_43
			end

			if arg_158_1.frameCnt_ <= 1 then
				arg_158_1.dialog_:SetActive(false)
			end

			local var_161_45 = 3.999999999999
			local var_161_46 = 0.425

			if var_161_45 < arg_158_1.time_ and arg_158_1.time_ <= var_161_45 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0

				arg_158_1.dialog_:SetActive(true)

				arg_158_1.dialogCg_.alpha = 0

				local var_161_47 = LeanTween.value(arg_158_1.dialog_, 0, 1, 0.3)

				var_161_47:setOnUpdate(LuaHelper.FloatAction(function(arg_162_0)
					arg_158_1.dialogCg_.alpha = arg_162_0
				end))
				var_161_47:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_158_1.dialog_)
					var_161_47:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_158_1.duration_ = arg_158_1.duration_ + 0.3

				SetActive(arg_158_1.leftNameGo_, true)

				local var_161_48 = arg_158_1:FormatText(StoryNameCfg[7].name)

				arg_158_1.leftNameTxt_.text = var_161_48

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, true)
				arg_158_1.iconController_:SetSelectedState("hero")

				arg_158_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_158_1.callingController_:SetSelectedState("normal")

				arg_158_1.keyicon_.color = Color.New(1, 1, 1)
				arg_158_1.icon_.color = Color.New(1, 1, 1)

				local var_161_49 = arg_158_1:GetWordFromCfg(116061039)
				local var_161_50 = arg_158_1:FormatText(var_161_49.content)

				arg_158_1.text_.text = var_161_50

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_51 = 17
				local var_161_52 = utf8.len(var_161_50)
				local var_161_53 = var_161_51 <= 0 and var_161_46 or var_161_46 * (var_161_52 / var_161_51)

				if var_161_53 > 0 and var_161_46 < var_161_53 then
					arg_158_1.talkMaxDuration = var_161_53
					var_161_45 = var_161_45 + 0.3

					if var_161_53 + var_161_45 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_53 + var_161_45
					end
				end

				arg_158_1.text_.text = var_161_50
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_54 = var_161_45 + 0.3
			local var_161_55 = math.max(var_161_46, arg_158_1.talkMaxDuration)

			if var_161_54 <= arg_158_1.time_ and arg_158_1.time_ < var_161_54 + var_161_55 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_54) / var_161_55

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_54 + var_161_55 and arg_158_1.time_ < var_161_54 + var_161_55 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play116061040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 116061040
		arg_164_1.duration_ = 2.37

		local var_164_0 = {
			zh = 1.999999999999,
			ja = 2.366
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
				arg_164_0:Play116061041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = arg_164_1.actors_["10025ui_story"].transform
			local var_167_1 = 0

			if var_167_1 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.var_.moveOldPos10025ui_story = var_167_0.localPosition
			end

			local var_167_2 = 0.001

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_2 then
				local var_167_3 = (arg_164_1.time_ - var_167_1) / var_167_2
				local var_167_4 = Vector3.New(0, -1.1, -5.9)

				var_167_0.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos10025ui_story, var_167_4, var_167_3)

				local var_167_5 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_5.x, var_167_5.y, var_167_5.z)

				local var_167_6 = var_167_0.localEulerAngles

				var_167_6.z = 0
				var_167_6.x = 0
				var_167_0.localEulerAngles = var_167_6
			end

			if arg_164_1.time_ >= var_167_1 + var_167_2 and arg_164_1.time_ < var_167_1 + var_167_2 + arg_167_0 then
				var_167_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_167_7 = manager.ui.mainCamera.transform.position - var_167_0.position

				var_167_0.forward = Vector3.New(var_167_7.x, var_167_7.y, var_167_7.z)

				local var_167_8 = var_167_0.localEulerAngles

				var_167_8.z = 0
				var_167_8.x = 0
				var_167_0.localEulerAngles = var_167_8
			end

			local var_167_9 = arg_164_1.actors_["10025ui_story"]
			local var_167_10 = 0

			if var_167_10 < arg_164_1.time_ and arg_164_1.time_ <= var_167_10 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect10025ui_story == nil then
				arg_164_1.var_.characterEffect10025ui_story = var_167_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_11 = 0.2

			if var_167_10 <= arg_164_1.time_ and arg_164_1.time_ < var_167_10 + var_167_11 and not isNil(var_167_9) then
				local var_167_12 = (arg_164_1.time_ - var_167_10) / var_167_11

				if arg_164_1.var_.characterEffect10025ui_story and not isNil(var_167_9) then
					arg_164_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= var_167_10 + var_167_11 and arg_164_1.time_ < var_167_10 + var_167_11 + arg_167_0 and not isNil(var_167_9) and arg_164_1.var_.characterEffect10025ui_story then
				arg_164_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_167_13 = 0

			if var_167_13 < arg_164_1.time_ and arg_164_1.time_ <= var_167_13 + arg_167_0 then
				arg_164_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_167_14 = 0

			if var_167_14 < arg_164_1.time_ and arg_164_1.time_ <= var_167_14 + arg_167_0 then
				arg_164_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_167_15 = 0
			local var_167_16 = 0.1

			if var_167_15 < arg_164_1.time_ and arg_164_1.time_ <= var_167_15 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				local var_167_17 = arg_164_1:FormatText(StoryNameCfg[328].name)

				arg_164_1.leftNameTxt_.text = var_167_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_18 = arg_164_1:GetWordFromCfg(116061040)
				local var_167_19 = arg_164_1:FormatText(var_167_18.content)

				arg_164_1.text_.text = var_167_19

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_20 = 4
				local var_167_21 = utf8.len(var_167_19)
				local var_167_22 = var_167_20 <= 0 and var_167_16 or var_167_16 * (var_167_21 / var_167_20)

				if var_167_22 > 0 and var_167_16 < var_167_22 then
					arg_164_1.talkMaxDuration = var_167_22

					if var_167_22 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_22 + var_167_15
					end
				end

				arg_164_1.text_.text = var_167_19
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061040", "story_v_out_116061.awb") ~= 0 then
					local var_167_23 = manager.audio:GetVoiceLength("story_v_out_116061", "116061040", "story_v_out_116061.awb") / 1000

					if var_167_23 + var_167_15 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_23 + var_167_15
					end

					if var_167_18.prefab_name ~= "" and arg_164_1.actors_[var_167_18.prefab_name] ~= nil then
						local var_167_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_18.prefab_name].transform, "story_v_out_116061", "116061040", "story_v_out_116061.awb")

						arg_164_1:RecordAudio("116061040", var_167_24)
						arg_164_1:RecordAudio("116061040", var_167_24)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_116061", "116061040", "story_v_out_116061.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_116061", "116061040", "story_v_out_116061.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_25 = math.max(var_167_16, arg_164_1.talkMaxDuration)

			if var_167_15 <= arg_164_1.time_ and arg_164_1.time_ < var_167_15 + var_167_25 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_15) / var_167_25

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_15 + var_167_25 and arg_164_1.time_ < var_167_15 + var_167_25 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play116061041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 116061041
		arg_168_1.duration_ = 5

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play116061042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = arg_168_1.actors_["10025ui_story"]
			local var_171_1 = 0

			if var_171_1 < arg_168_1.time_ and arg_168_1.time_ <= var_171_1 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10025ui_story == nil then
				arg_168_1.var_.characterEffect10025ui_story = var_171_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.2

			if var_171_1 <= arg_168_1.time_ and arg_168_1.time_ < var_171_1 + var_171_2 and not isNil(var_171_0) then
				local var_171_3 = (arg_168_1.time_ - var_171_1) / var_171_2

				if arg_168_1.var_.characterEffect10025ui_story and not isNil(var_171_0) then
					local var_171_4 = Mathf.Lerp(0, 0.5, var_171_3)

					arg_168_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_168_1.var_.characterEffect10025ui_story.fillRatio = var_171_4
				end
			end

			if arg_168_1.time_ >= var_171_1 + var_171_2 and arg_168_1.time_ < var_171_1 + var_171_2 + arg_171_0 and not isNil(var_171_0) and arg_168_1.var_.characterEffect10025ui_story then
				local var_171_5 = 0.5

				arg_168_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_168_1.var_.characterEffect10025ui_story.fillRatio = var_171_5
			end

			local var_171_6 = 0
			local var_171_7 = 0.425

			if var_171_6 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_8 = arg_168_1:GetWordFromCfg(116061041)
				local var_171_9 = arg_168_1:FormatText(var_171_8.content)

				arg_168_1.text_.text = var_171_9

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_10 = 17
				local var_171_11 = utf8.len(var_171_9)
				local var_171_12 = var_171_10 <= 0 and var_171_7 or var_171_7 * (var_171_11 / var_171_10)

				if var_171_12 > 0 and var_171_7 < var_171_12 then
					arg_168_1.talkMaxDuration = var_171_12

					if var_171_12 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_12 + var_171_6
					end
				end

				arg_168_1.text_.text = var_171_9
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_13 = math.max(var_171_7, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_13 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_6) / var_171_13

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_13 and arg_168_1.time_ < var_171_6 + var_171_13 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play116061042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 116061042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play116061043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 0
			local var_175_1 = 0.175

			if var_175_0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				local var_175_2 = arg_172_1:FormatText(StoryNameCfg[7].name)

				arg_172_1.leftNameTxt_.text = var_175_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_3 = arg_172_1:GetWordFromCfg(116061042)
				local var_175_4 = arg_172_1:FormatText(var_175_3.content)

				arg_172_1.text_.text = var_175_4

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 7
				local var_175_6 = utf8.len(var_175_4)
				local var_175_7 = var_175_5 <= 0 and var_175_1 or var_175_1 * (var_175_6 / var_175_5)

				if var_175_7 > 0 and var_175_1 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_4
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_8 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_8 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_8

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_8 and arg_172_1.time_ < var_175_0 + var_175_8 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play116061043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 116061043
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play116061044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0
			local var_179_1 = 0.6

			if var_179_0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_0 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, false)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_2 = arg_176_1:GetWordFromCfg(116061043)
				local var_179_3 = arg_176_1:FormatText(var_179_2.content)

				arg_176_1.text_.text = var_179_3

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_4 = 24
				local var_179_5 = utf8.len(var_179_3)
				local var_179_6 = var_179_4 <= 0 and var_179_1 or var_179_1 * (var_179_5 / var_179_4)

				if var_179_6 > 0 and var_179_1 < var_179_6 then
					arg_176_1.talkMaxDuration = var_179_6

					if var_179_6 + var_179_0 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_6 + var_179_0
					end
				end

				arg_176_1.text_.text = var_179_3
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)
				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_7 = math.max(var_179_1, arg_176_1.talkMaxDuration)

			if var_179_0 <= arg_176_1.time_ and arg_176_1.time_ < var_179_0 + var_179_7 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_0) / var_179_7

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_0 + var_179_7 and arg_176_1.time_ < var_179_0 + var_179_7 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play116061044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 116061044
		arg_180_1.duration_ = 9

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play116061045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			local var_183_0 = "ST03"

			if arg_180_1.bgs_[var_183_0] == nil then
				local var_183_1 = Object.Instantiate(arg_180_1.paintGo_)

				var_183_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_183_0)
				var_183_1.name = var_183_0
				var_183_1.transform.parent = arg_180_1.stage_.transform
				var_183_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_180_1.bgs_[var_183_0] = var_183_1
			end

			local var_183_2 = 2

			if var_183_2 < arg_180_1.time_ and arg_180_1.time_ <= var_183_2 + arg_183_0 then
				if arg_180_0.sceneSettingEffect_ then
					arg_180_1.sceneSettingEffect_.enabled = false
				end

				arg_180_1.sceneSettingGo_:SetActive(true)

				local var_183_3 = manager.ui.mainCamera.transform.localPosition
				local var_183_4 = Vector3.New(0, 0, 10) + Vector3.New(var_183_3.x, var_183_3.y, 0)
				local var_183_5 = arg_180_1.bgs_.ST03

				var_183_5.transform.localPosition = var_183_4
				var_183_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_183_6 = var_183_5:GetComponent("SpriteRenderer")

				if var_183_6 and var_183_6.sprite then
					local var_183_7 = (var_183_5.transform.localPosition - var_183_3).z
					local var_183_8 = manager.ui.mainCameraCom_
					local var_183_9 = 2 * var_183_7 * Mathf.Tan(var_183_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_183_10 = var_183_9 * var_183_8.aspect
					local var_183_11 = var_183_6.sprite.bounds.size.x
					local var_183_12 = var_183_6.sprite.bounds.size.y
					local var_183_13 = var_183_10 / var_183_11
					local var_183_14 = var_183_9 / var_183_12
					local var_183_15 = var_183_14 < var_183_13 and var_183_13 or var_183_14

					var_183_5.transform.localScale = Vector3.New(var_183_15, var_183_15, 0)
				end

				for iter_183_0, iter_183_1 in pairs(arg_180_1.bgs_) do
					if iter_183_0 ~= "ST03" then
						iter_183_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_183_16 = 0

			if var_183_16 < arg_180_1.time_ and arg_180_1.time_ <= var_183_16 + arg_183_0 then
				arg_180_1.mask_.enabled = true
				arg_180_1.mask_.raycastTarget = true

				arg_180_1:SetGaussion(false)
			end

			local var_183_17 = 2

			if var_183_16 <= arg_180_1.time_ and arg_180_1.time_ < var_183_16 + var_183_17 then
				local var_183_18 = (arg_180_1.time_ - var_183_16) / var_183_17
				local var_183_19 = Color.New(0, 0, 0)

				var_183_19.a = Mathf.Lerp(0, 1, var_183_18)
				arg_180_1.mask_.color = var_183_19
			end

			if arg_180_1.time_ >= var_183_16 + var_183_17 and arg_180_1.time_ < var_183_16 + var_183_17 + arg_183_0 then
				local var_183_20 = Color.New(0, 0, 0)

				var_183_20.a = 1
				arg_180_1.mask_.color = var_183_20
			end

			local var_183_21 = 2

			if var_183_21 < arg_180_1.time_ and arg_180_1.time_ <= var_183_21 + arg_183_0 then
				arg_180_1.mask_.enabled = true
				arg_180_1.mask_.raycastTarget = true

				arg_180_1:SetGaussion(false)
			end

			local var_183_22 = 2

			if var_183_21 <= arg_180_1.time_ and arg_180_1.time_ < var_183_21 + var_183_22 then
				local var_183_23 = (arg_180_1.time_ - var_183_21) / var_183_22
				local var_183_24 = Color.New(0, 0, 0)

				var_183_24.a = Mathf.Lerp(1, 0, var_183_23)
				arg_180_1.mask_.color = var_183_24
			end

			if arg_180_1.time_ >= var_183_21 + var_183_22 and arg_180_1.time_ < var_183_21 + var_183_22 + arg_183_0 then
				local var_183_25 = Color.New(0, 0, 0)
				local var_183_26 = 0

				arg_180_1.mask_.enabled = false
				var_183_25.a = var_183_26
				arg_180_1.mask_.color = var_183_25
			end

			local var_183_27 = arg_180_1.actors_["10025ui_story"].transform
			local var_183_28 = 1.966

			if var_183_28 < arg_180_1.time_ and arg_180_1.time_ <= var_183_28 + arg_183_0 then
				arg_180_1.var_.moveOldPos10025ui_story = var_183_27.localPosition
			end

			local var_183_29 = 0.001

			if var_183_28 <= arg_180_1.time_ and arg_180_1.time_ < var_183_28 + var_183_29 then
				local var_183_30 = (arg_180_1.time_ - var_183_28) / var_183_29
				local var_183_31 = Vector3.New(0, 100, 0)

				var_183_27.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos10025ui_story, var_183_31, var_183_30)

				local var_183_32 = manager.ui.mainCamera.transform.position - var_183_27.position

				var_183_27.forward = Vector3.New(var_183_32.x, var_183_32.y, var_183_32.z)

				local var_183_33 = var_183_27.localEulerAngles

				var_183_33.z = 0
				var_183_33.x = 0
				var_183_27.localEulerAngles = var_183_33
			end

			if arg_180_1.time_ >= var_183_28 + var_183_29 and arg_180_1.time_ < var_183_28 + var_183_29 + arg_183_0 then
				var_183_27.localPosition = Vector3.New(0, 100, 0)

				local var_183_34 = manager.ui.mainCamera.transform.position - var_183_27.position

				var_183_27.forward = Vector3.New(var_183_34.x, var_183_34.y, var_183_34.z)

				local var_183_35 = var_183_27.localEulerAngles

				var_183_35.z = 0
				var_183_35.x = 0
				var_183_27.localEulerAngles = var_183_35
			end

			if arg_180_1.frameCnt_ <= 1 then
				arg_180_1.dialog_:SetActive(false)
			end

			local var_183_36 = 4
			local var_183_37 = 1.3

			if var_183_36 < arg_180_1.time_ and arg_180_1.time_ <= var_183_36 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0

				arg_180_1.dialog_:SetActive(true)

				arg_180_1.dialogCg_.alpha = 0

				local var_183_38 = LeanTween.value(arg_180_1.dialog_, 0, 1, 0.3)

				var_183_38:setOnUpdate(LuaHelper.FloatAction(function(arg_184_0)
					arg_180_1.dialogCg_.alpha = arg_184_0
				end))
				var_183_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_180_1.dialog_)
					var_183_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_180_1.duration_ = arg_180_1.duration_ + 0.3

				SetActive(arg_180_1.leftNameGo_, false)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_39 = arg_180_1:GetWordFromCfg(116061044)
				local var_183_40 = arg_180_1:FormatText(var_183_39.content)

				arg_180_1.text_.text = var_183_40

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_41 = 52
				local var_183_42 = utf8.len(var_183_40)
				local var_183_43 = var_183_41 <= 0 and var_183_37 or var_183_37 * (var_183_42 / var_183_41)

				if var_183_43 > 0 and var_183_37 < var_183_43 then
					arg_180_1.talkMaxDuration = var_183_43
					var_183_36 = var_183_36 + 0.3

					if var_183_43 + var_183_36 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_43 + var_183_36
					end
				end

				arg_180_1.text_.text = var_183_40
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_44 = var_183_36 + 0.3
			local var_183_45 = math.max(var_183_37, arg_180_1.talkMaxDuration)

			if var_183_44 <= arg_180_1.time_ and arg_180_1.time_ < var_183_44 + var_183_45 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_44) / var_183_45

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_44 + var_183_45 and arg_180_1.time_ < var_183_44 + var_183_45 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play116061045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 116061045
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play116061046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0
			local var_189_1 = 0.45

			if var_189_0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				local var_189_2 = arg_186_1:FormatText(StoryNameCfg[7].name)

				arg_186_1.leftNameTxt_.text = var_189_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_186_1.callingController_:SetSelectedState("normal")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_3 = arg_186_1:GetWordFromCfg(116061045)
				local var_189_4 = arg_186_1:FormatText(var_189_3.content)

				arg_186_1.text_.text = var_189_4

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_5 = 18
				local var_189_6 = utf8.len(var_189_4)
				local var_189_7 = var_189_5 <= 0 and var_189_1 or var_189_1 * (var_189_6 / var_189_5)

				if var_189_7 > 0 and var_189_1 < var_189_7 then
					arg_186_1.talkMaxDuration = var_189_7

					if var_189_7 + var_189_0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_7 + var_189_0
					end
				end

				arg_186_1.text_.text = var_189_4
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_8 = math.max(var_189_1, arg_186_1.talkMaxDuration)

			if var_189_0 <= arg_186_1.time_ and arg_186_1.time_ < var_189_0 + var_189_8 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_0) / var_189_8

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_0 + var_189_8 and arg_186_1.time_ < var_189_0 + var_189_8 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play116061046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 116061046
		arg_190_1.duration_ = 6.4

		local var_190_0 = {
			zh = 6.166,
			ja = 6.4
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
				arg_190_0:Play116061047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			local var_193_0 = arg_190_1.actors_["10025ui_story"].transform
			local var_193_1 = 0

			if var_193_1 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.var_.moveOldPos10025ui_story = var_193_0.localPosition
			end

			local var_193_2 = 0.001

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_2 then
				local var_193_3 = (arg_190_1.time_ - var_193_1) / var_193_2
				local var_193_4 = Vector3.New(0, -1.1, -5.9)

				var_193_0.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos10025ui_story, var_193_4, var_193_3)

				local var_193_5 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_5.x, var_193_5.y, var_193_5.z)

				local var_193_6 = var_193_0.localEulerAngles

				var_193_6.z = 0
				var_193_6.x = 0
				var_193_0.localEulerAngles = var_193_6
			end

			if arg_190_1.time_ >= var_193_1 + var_193_2 and arg_190_1.time_ < var_193_1 + var_193_2 + arg_193_0 then
				var_193_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_193_7 = manager.ui.mainCamera.transform.position - var_193_0.position

				var_193_0.forward = Vector3.New(var_193_7.x, var_193_7.y, var_193_7.z)

				local var_193_8 = var_193_0.localEulerAngles

				var_193_8.z = 0
				var_193_8.x = 0
				var_193_0.localEulerAngles = var_193_8
			end

			local var_193_9 = arg_190_1.actors_["10025ui_story"]
			local var_193_10 = 0

			if var_193_10 < arg_190_1.time_ and arg_190_1.time_ <= var_193_10 + arg_193_0 and not isNil(var_193_9) and arg_190_1.var_.characterEffect10025ui_story == nil then
				arg_190_1.var_.characterEffect10025ui_story = var_193_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_11 = 0.2

			if var_193_10 <= arg_190_1.time_ and arg_190_1.time_ < var_193_10 + var_193_11 and not isNil(var_193_9) then
				local var_193_12 = (arg_190_1.time_ - var_193_10) / var_193_11

				if arg_190_1.var_.characterEffect10025ui_story and not isNil(var_193_9) then
					arg_190_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= var_193_10 + var_193_11 and arg_190_1.time_ < var_193_10 + var_193_11 + arg_193_0 and not isNil(var_193_9) and arg_190_1.var_.characterEffect10025ui_story then
				arg_190_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_193_13 = 0

			if var_193_13 < arg_190_1.time_ and arg_190_1.time_ <= var_193_13 + arg_193_0 then
				arg_190_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_193_14 = 0

			if var_193_14 < arg_190_1.time_ and arg_190_1.time_ <= var_193_14 + arg_193_0 then
				arg_190_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			local var_193_15 = 0
			local var_193_16 = 0.45

			if var_193_15 < arg_190_1.time_ and arg_190_1.time_ <= var_193_15 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				local var_193_17 = arg_190_1:FormatText(StoryNameCfg[328].name)

				arg_190_1.leftNameTxt_.text = var_193_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_18 = arg_190_1:GetWordFromCfg(116061046)
				local var_193_19 = arg_190_1:FormatText(var_193_18.content)

				arg_190_1.text_.text = var_193_19

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_20 = 18
				local var_193_21 = utf8.len(var_193_19)
				local var_193_22 = var_193_20 <= 0 and var_193_16 or var_193_16 * (var_193_21 / var_193_20)

				if var_193_22 > 0 and var_193_16 < var_193_22 then
					arg_190_1.talkMaxDuration = var_193_22

					if var_193_22 + var_193_15 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_22 + var_193_15
					end
				end

				arg_190_1.text_.text = var_193_19
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061046", "story_v_out_116061.awb") ~= 0 then
					local var_193_23 = manager.audio:GetVoiceLength("story_v_out_116061", "116061046", "story_v_out_116061.awb") / 1000

					if var_193_23 + var_193_15 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_23 + var_193_15
					end

					if var_193_18.prefab_name ~= "" and arg_190_1.actors_[var_193_18.prefab_name] ~= nil then
						local var_193_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_18.prefab_name].transform, "story_v_out_116061", "116061046", "story_v_out_116061.awb")

						arg_190_1:RecordAudio("116061046", var_193_24)
						arg_190_1:RecordAudio("116061046", var_193_24)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_116061", "116061046", "story_v_out_116061.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_116061", "116061046", "story_v_out_116061.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_25 = math.max(var_193_16, arg_190_1.talkMaxDuration)

			if var_193_15 <= arg_190_1.time_ and arg_190_1.time_ < var_193_15 + var_193_25 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_15) / var_193_25

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_15 + var_193_25 and arg_190_1.time_ < var_193_15 + var_193_25 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play116061047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 116061047
		arg_194_1.duration_ = 6.37

		local var_194_0 = {
			zh = 3,
			ja = 6.366
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play116061048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0

			if var_197_0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_0 + arg_197_0 then
				arg_194_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_2")
			end

			local var_197_1 = 0

			if var_197_1 < arg_194_1.time_ and arg_194_1.time_ <= var_197_1 + arg_197_0 then
				arg_194_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_197_2 = 0
			local var_197_3 = 0.25

			if var_197_2 < arg_194_1.time_ and arg_194_1.time_ <= var_197_2 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				local var_197_4 = arg_194_1:FormatText(StoryNameCfg[328].name)

				arg_194_1.leftNameTxt_.text = var_197_4

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_5 = arg_194_1:GetWordFromCfg(116061047)
				local var_197_6 = arg_194_1:FormatText(var_197_5.content)

				arg_194_1.text_.text = var_197_6

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_7 = 10
				local var_197_8 = utf8.len(var_197_6)
				local var_197_9 = var_197_7 <= 0 and var_197_3 or var_197_3 * (var_197_8 / var_197_7)

				if var_197_9 > 0 and var_197_3 < var_197_9 then
					arg_194_1.talkMaxDuration = var_197_9

					if var_197_9 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_9 + var_197_2
					end
				end

				arg_194_1.text_.text = var_197_6
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061047", "story_v_out_116061.awb") ~= 0 then
					local var_197_10 = manager.audio:GetVoiceLength("story_v_out_116061", "116061047", "story_v_out_116061.awb") / 1000

					if var_197_10 + var_197_2 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_10 + var_197_2
					end

					if var_197_5.prefab_name ~= "" and arg_194_1.actors_[var_197_5.prefab_name] ~= nil then
						local var_197_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_5.prefab_name].transform, "story_v_out_116061", "116061047", "story_v_out_116061.awb")

						arg_194_1:RecordAudio("116061047", var_197_11)
						arg_194_1:RecordAudio("116061047", var_197_11)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_116061", "116061047", "story_v_out_116061.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_116061", "116061047", "story_v_out_116061.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_12 = math.max(var_197_3, arg_194_1.talkMaxDuration)

			if var_197_2 <= arg_194_1.time_ and arg_194_1.time_ < var_197_2 + var_197_12 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_2) / var_197_12

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_2 + var_197_12 and arg_194_1.time_ < var_197_2 + var_197_12 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play116061048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 116061048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play116061049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = arg_198_1.actors_["10025ui_story"]
			local var_201_1 = 0

			if var_201_1 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect10025ui_story == nil then
				arg_198_1.var_.characterEffect10025ui_story = var_201_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.2

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_2 and not isNil(var_201_0) then
				local var_201_3 = (arg_198_1.time_ - var_201_1) / var_201_2

				if arg_198_1.var_.characterEffect10025ui_story and not isNil(var_201_0) then
					local var_201_4 = Mathf.Lerp(0, 0.5, var_201_3)

					arg_198_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_198_1.var_.characterEffect10025ui_story.fillRatio = var_201_4
				end
			end

			if arg_198_1.time_ >= var_201_1 + var_201_2 and arg_198_1.time_ < var_201_1 + var_201_2 + arg_201_0 and not isNil(var_201_0) and arg_198_1.var_.characterEffect10025ui_story then
				local var_201_5 = 0.5

				arg_198_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_198_1.var_.characterEffect10025ui_story.fillRatio = var_201_5
			end

			local var_201_6 = 0
			local var_201_7 = 0.775

			if var_201_6 < arg_198_1.time_ and arg_198_1.time_ <= var_201_6 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				local var_201_8 = arg_198_1:FormatText(StoryNameCfg[7].name)

				arg_198_1.leftNameTxt_.text = var_201_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_9 = arg_198_1:GetWordFromCfg(116061048)
				local var_201_10 = arg_198_1:FormatText(var_201_9.content)

				arg_198_1.text_.text = var_201_10

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_11 = 31
				local var_201_12 = utf8.len(var_201_10)
				local var_201_13 = var_201_11 <= 0 and var_201_7 or var_201_7 * (var_201_12 / var_201_11)

				if var_201_13 > 0 and var_201_7 < var_201_13 then
					arg_198_1.talkMaxDuration = var_201_13

					if var_201_13 + var_201_6 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_13 + var_201_6
					end
				end

				arg_198_1.text_.text = var_201_10
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_14 = math.max(var_201_7, arg_198_1.talkMaxDuration)

			if var_201_6 <= arg_198_1.time_ and arg_198_1.time_ < var_201_6 + var_201_14 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_6) / var_201_14

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_6 + var_201_14 and arg_198_1.time_ < var_201_6 + var_201_14 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play116061049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 116061049
		arg_202_1.duration_ = 2

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play116061050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0

			if var_205_0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_0 + arg_205_0 then
				arg_202_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action1_1")
			end

			local var_205_1 = 0

			if var_205_1 < arg_202_1.time_ and arg_202_1.time_ <= var_205_1 + arg_205_0 then
				arg_202_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_205_2 = arg_202_1.actors_["10025ui_story"]
			local var_205_3 = 0

			if var_205_3 < arg_202_1.time_ and arg_202_1.time_ <= var_205_3 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.characterEffect10025ui_story == nil then
				arg_202_1.var_.characterEffect10025ui_story = var_205_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_4 = 0.2

			if var_205_3 <= arg_202_1.time_ and arg_202_1.time_ < var_205_3 + var_205_4 and not isNil(var_205_2) then
				local var_205_5 = (arg_202_1.time_ - var_205_3) / var_205_4

				if arg_202_1.var_.characterEffect10025ui_story and not isNil(var_205_2) then
					arg_202_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= var_205_3 + var_205_4 and arg_202_1.time_ < var_205_3 + var_205_4 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.characterEffect10025ui_story then
				arg_202_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_205_6 = 0
			local var_205_7 = 0.1

			if var_205_6 < arg_202_1.time_ and arg_202_1.time_ <= var_205_6 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				local var_205_8 = arg_202_1:FormatText(StoryNameCfg[328].name)

				arg_202_1.leftNameTxt_.text = var_205_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_9 = arg_202_1:GetWordFromCfg(116061049)
				local var_205_10 = arg_202_1:FormatText(var_205_9.content)

				arg_202_1.text_.text = var_205_10

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_11 = 4
				local var_205_12 = utf8.len(var_205_10)
				local var_205_13 = var_205_11 <= 0 and var_205_7 or var_205_7 * (var_205_12 / var_205_11)

				if var_205_13 > 0 and var_205_7 < var_205_13 then
					arg_202_1.talkMaxDuration = var_205_13

					if var_205_13 + var_205_6 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_13 + var_205_6
					end
				end

				arg_202_1.text_.text = var_205_10
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061049", "story_v_out_116061.awb") ~= 0 then
					local var_205_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061049", "story_v_out_116061.awb") / 1000

					if var_205_14 + var_205_6 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_14 + var_205_6
					end

					if var_205_9.prefab_name ~= "" and arg_202_1.actors_[var_205_9.prefab_name] ~= nil then
						local var_205_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_9.prefab_name].transform, "story_v_out_116061", "116061049", "story_v_out_116061.awb")

						arg_202_1:RecordAudio("116061049", var_205_15)
						arg_202_1:RecordAudio("116061049", var_205_15)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_116061", "116061049", "story_v_out_116061.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_116061", "116061049", "story_v_out_116061.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_16 = math.max(var_205_7, arg_202_1.talkMaxDuration)

			if var_205_6 <= arg_202_1.time_ and arg_202_1.time_ < var_205_6 + var_205_16 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_6) / var_205_16

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_6 + var_205_16 and arg_202_1.time_ < var_205_6 + var_205_16 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play116061050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 116061050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play116061051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			local var_209_0 = arg_206_1.actors_["10025ui_story"]
			local var_209_1 = 0

			if var_209_1 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect10025ui_story == nil then
				arg_206_1.var_.characterEffect10025ui_story = var_209_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.2

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_2 and not isNil(var_209_0) then
				local var_209_3 = (arg_206_1.time_ - var_209_1) / var_209_2

				if arg_206_1.var_.characterEffect10025ui_story and not isNil(var_209_0) then
					local var_209_4 = Mathf.Lerp(0, 0.5, var_209_3)

					arg_206_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_206_1.var_.characterEffect10025ui_story.fillRatio = var_209_4
				end
			end

			if arg_206_1.time_ >= var_209_1 + var_209_2 and arg_206_1.time_ < var_209_1 + var_209_2 + arg_209_0 and not isNil(var_209_0) and arg_206_1.var_.characterEffect10025ui_story then
				local var_209_5 = 0.5

				arg_206_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_206_1.var_.characterEffect10025ui_story.fillRatio = var_209_5
			end

			local var_209_6 = 0
			local var_209_7 = 0.75

			if var_209_6 < arg_206_1.time_ and arg_206_1.time_ <= var_209_6 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				local var_209_8 = arg_206_1:FormatText(StoryNameCfg[7].name)

				arg_206_1.leftNameTxt_.text = var_209_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, true)
				arg_206_1.iconController_:SetSelectedState("hero")

				arg_206_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_206_1.callingController_:SetSelectedState("normal")

				arg_206_1.keyicon_.color = Color.New(1, 1, 1)
				arg_206_1.icon_.color = Color.New(1, 1, 1)

				local var_209_9 = arg_206_1:GetWordFromCfg(116061050)
				local var_209_10 = arg_206_1:FormatText(var_209_9.content)

				arg_206_1.text_.text = var_209_10

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_11 = 30
				local var_209_12 = utf8.len(var_209_10)
				local var_209_13 = var_209_11 <= 0 and var_209_7 or var_209_7 * (var_209_12 / var_209_11)

				if var_209_13 > 0 and var_209_7 < var_209_13 then
					arg_206_1.talkMaxDuration = var_209_13

					if var_209_13 + var_209_6 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_13 + var_209_6
					end
				end

				arg_206_1.text_.text = var_209_10
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_14 = math.max(var_209_7, arg_206_1.talkMaxDuration)

			if var_209_6 <= arg_206_1.time_ and arg_206_1.time_ < var_209_6 + var_209_14 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_6) / var_209_14

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_6 + var_209_14 and arg_206_1.time_ < var_209_6 + var_209_14 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play116061051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 116061051
		arg_210_1.duration_ = 2.43

		local var_210_0 = {
			zh = 2.433,
			ja = 1.833
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play116061052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			local var_213_0 = 0
			local var_213_1 = 0.125

			if var_213_0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_0 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				local var_213_2 = arg_210_1:FormatText(StoryNameCfg[6].name)

				arg_210_1.leftNameTxt_.text = var_213_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, true)
				arg_210_1.iconController_:SetSelectedState("hero")

				arg_210_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_210_1.callingController_:SetSelectedState("normal")

				arg_210_1.keyicon_.color = Color.New(1, 1, 1)
				arg_210_1.icon_.color = Color.New(1, 1, 1)

				local var_213_3 = arg_210_1:GetWordFromCfg(116061051)
				local var_213_4 = arg_210_1:FormatText(var_213_3.content)

				arg_210_1.text_.text = var_213_4

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_5 = 5
				local var_213_6 = utf8.len(var_213_4)
				local var_213_7 = var_213_5 <= 0 and var_213_1 or var_213_1 * (var_213_6 / var_213_5)

				if var_213_7 > 0 and var_213_1 < var_213_7 then
					arg_210_1.talkMaxDuration = var_213_7

					if var_213_7 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_7 + var_213_0
					end
				end

				arg_210_1.text_.text = var_213_4
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061051", "story_v_out_116061.awb") ~= 0 then
					local var_213_8 = manager.audio:GetVoiceLength("story_v_out_116061", "116061051", "story_v_out_116061.awb") / 1000

					if var_213_8 + var_213_0 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_8 + var_213_0
					end

					if var_213_3.prefab_name ~= "" and arg_210_1.actors_[var_213_3.prefab_name] ~= nil then
						local var_213_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_3.prefab_name].transform, "story_v_out_116061", "116061051", "story_v_out_116061.awb")

						arg_210_1:RecordAudio("116061051", var_213_9)
						arg_210_1:RecordAudio("116061051", var_213_9)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_116061", "116061051", "story_v_out_116061.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_116061", "116061051", "story_v_out_116061.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_10 = math.max(var_213_1, arg_210_1.talkMaxDuration)

			if var_213_0 <= arg_210_1.time_ and arg_210_1.time_ < var_213_0 + var_213_10 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_0) / var_213_10

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_0 + var_213_10 and arg_210_1.time_ < var_213_0 + var_213_10 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play116061052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 116061052
		arg_214_1.duration_ = 4.03

		local var_214_0 = {
			zh = 3.666,
			ja = 4.033
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play116061053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			local var_217_0 = 0
			local var_217_1 = 0.25

			if var_217_0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_0 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				local var_217_2 = arg_214_1:FormatText(StoryNameCfg[37].name)

				arg_214_1.leftNameTxt_.text = var_217_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:GetWordFromCfg(116061052)
				local var_217_4 = arg_214_1:FormatText(var_217_3.content)

				arg_214_1.text_.text = var_217_4

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 10
				local var_217_6 = utf8.len(var_217_4)
				local var_217_7 = var_217_5 <= 0 and var_217_1 or var_217_1 * (var_217_6 / var_217_5)

				if var_217_7 > 0 and var_217_1 < var_217_7 then
					arg_214_1.talkMaxDuration = var_217_7

					if var_217_7 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_7 + var_217_0
					end
				end

				arg_214_1.text_.text = var_217_4
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061052", "story_v_out_116061.awb") ~= 0 then
					local var_217_8 = manager.audio:GetVoiceLength("story_v_out_116061", "116061052", "story_v_out_116061.awb") / 1000

					if var_217_8 + var_217_0 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_8 + var_217_0
					end

					if var_217_3.prefab_name ~= "" and arg_214_1.actors_[var_217_3.prefab_name] ~= nil then
						local var_217_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_3.prefab_name].transform, "story_v_out_116061", "116061052", "story_v_out_116061.awb")

						arg_214_1:RecordAudio("116061052", var_217_9)
						arg_214_1:RecordAudio("116061052", var_217_9)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_116061", "116061052", "story_v_out_116061.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_116061", "116061052", "story_v_out_116061.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_10 = math.max(var_217_1, arg_214_1.talkMaxDuration)

			if var_217_0 <= arg_214_1.time_ and arg_214_1.time_ < var_217_0 + var_217_10 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_0) / var_217_10

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_0 + var_217_10 and arg_214_1.time_ < var_217_0 + var_217_10 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play116061053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 116061053
		arg_218_1.duration_ = 6.13

		local var_218_0 = {
			zh = 5.433,
			ja = 6.133
		}
		local var_218_1 = manager.audio:GetLocalizationFlag()

		if var_218_0[var_218_1] ~= nil then
			arg_218_1.duration_ = var_218_0[var_218_1]
		end

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play116061054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 0

			if var_221_0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_0 + arg_221_0 then
				arg_218_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_221_1 = 0

			if var_221_1 < arg_218_1.time_ and arg_218_1.time_ <= var_221_1 + arg_221_0 then
				arg_218_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_221_2 = arg_218_1.actors_["10025ui_story"]
			local var_221_3 = 0

			if var_221_3 < arg_218_1.time_ and arg_218_1.time_ <= var_221_3 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.characterEffect10025ui_story == nil then
				arg_218_1.var_.characterEffect10025ui_story = var_221_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_4 = 0.2

			if var_221_3 <= arg_218_1.time_ and arg_218_1.time_ < var_221_3 + var_221_4 and not isNil(var_221_2) then
				local var_221_5 = (arg_218_1.time_ - var_221_3) / var_221_4

				if arg_218_1.var_.characterEffect10025ui_story and not isNil(var_221_2) then
					arg_218_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_218_1.time_ >= var_221_3 + var_221_4 and arg_218_1.time_ < var_221_3 + var_221_4 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.characterEffect10025ui_story then
				arg_218_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_221_6 = 0
			local var_221_7 = 0.35

			if var_221_6 < arg_218_1.time_ and arg_218_1.time_ <= var_221_6 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				local var_221_8 = arg_218_1:FormatText(StoryNameCfg[328].name)

				arg_218_1.leftNameTxt_.text = var_221_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_9 = arg_218_1:GetWordFromCfg(116061053)
				local var_221_10 = arg_218_1:FormatText(var_221_9.content)

				arg_218_1.text_.text = var_221_10

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_11 = 14
				local var_221_12 = utf8.len(var_221_10)
				local var_221_13 = var_221_11 <= 0 and var_221_7 or var_221_7 * (var_221_12 / var_221_11)

				if var_221_13 > 0 and var_221_7 < var_221_13 then
					arg_218_1.talkMaxDuration = var_221_13

					if var_221_13 + var_221_6 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_13 + var_221_6
					end
				end

				arg_218_1.text_.text = var_221_10
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061053", "story_v_out_116061.awb") ~= 0 then
					local var_221_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061053", "story_v_out_116061.awb") / 1000

					if var_221_14 + var_221_6 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_14 + var_221_6
					end

					if var_221_9.prefab_name ~= "" and arg_218_1.actors_[var_221_9.prefab_name] ~= nil then
						local var_221_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_218_1.actors_[var_221_9.prefab_name].transform, "story_v_out_116061", "116061053", "story_v_out_116061.awb")

						arg_218_1:RecordAudio("116061053", var_221_15)
						arg_218_1:RecordAudio("116061053", var_221_15)
					else
						arg_218_1:AudioAction("play", "voice", "story_v_out_116061", "116061053", "story_v_out_116061.awb")
					end

					arg_218_1:RecordHistoryTalkVoice("story_v_out_116061", "116061053", "story_v_out_116061.awb")
				end

				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_16 = math.max(var_221_7, arg_218_1.talkMaxDuration)

			if var_221_6 <= arg_218_1.time_ and arg_218_1.time_ < var_221_6 + var_221_16 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_6) / var_221_16

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_6 + var_221_16 and arg_218_1.time_ < var_221_6 + var_221_16 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play116061054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 116061054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play116061055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = arg_222_1.actors_["10025ui_story"]
			local var_225_1 = 0

			if var_225_1 < arg_222_1.time_ and arg_222_1.time_ <= var_225_1 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect10025ui_story == nil then
				arg_222_1.var_.characterEffect10025ui_story = var_225_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_2 = 0.2

			if var_225_1 <= arg_222_1.time_ and arg_222_1.time_ < var_225_1 + var_225_2 and not isNil(var_225_0) then
				local var_225_3 = (arg_222_1.time_ - var_225_1) / var_225_2

				if arg_222_1.var_.characterEffect10025ui_story and not isNil(var_225_0) then
					local var_225_4 = Mathf.Lerp(0, 0.5, var_225_3)

					arg_222_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_222_1.var_.characterEffect10025ui_story.fillRatio = var_225_4
				end
			end

			if arg_222_1.time_ >= var_225_1 + var_225_2 and arg_222_1.time_ < var_225_1 + var_225_2 + arg_225_0 and not isNil(var_225_0) and arg_222_1.var_.characterEffect10025ui_story then
				local var_225_5 = 0.5

				arg_222_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_222_1.var_.characterEffect10025ui_story.fillRatio = var_225_5
			end

			local var_225_6 = 0
			local var_225_7 = 0.2

			if var_225_6 < arg_222_1.time_ and arg_222_1.time_ <= var_225_6 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				local var_225_8 = arg_222_1:FormatText(StoryNameCfg[7].name)

				arg_222_1.leftNameTxt_.text = var_225_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_9 = arg_222_1:GetWordFromCfg(116061054)
				local var_225_10 = arg_222_1:FormatText(var_225_9.content)

				arg_222_1.text_.text = var_225_10

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_11 = 8
				local var_225_12 = utf8.len(var_225_10)
				local var_225_13 = var_225_11 <= 0 and var_225_7 or var_225_7 * (var_225_12 / var_225_11)

				if var_225_13 > 0 and var_225_7 < var_225_13 then
					arg_222_1.talkMaxDuration = var_225_13

					if var_225_13 + var_225_6 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_13 + var_225_6
					end
				end

				arg_222_1.text_.text = var_225_10
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_14 = math.max(var_225_7, arg_222_1.talkMaxDuration)

			if var_225_6 <= arg_222_1.time_ and arg_222_1.time_ < var_225_6 + var_225_14 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_6) / var_225_14

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_6 + var_225_14 and arg_222_1.time_ < var_225_6 + var_225_14 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play116061055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 116061055
		arg_226_1.duration_ = 7.97

		local var_226_0 = {
			zh = 7.966,
			ja = 3.166
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play116061056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0

			if var_229_0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_0 + arg_229_0 then
				arg_226_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action486")
			end

			local var_229_1 = 0

			if var_229_1 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_229_2 = arg_226_1.actors_["10025ui_story"]
			local var_229_3 = 0

			if var_229_3 < arg_226_1.time_ and arg_226_1.time_ <= var_229_3 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.characterEffect10025ui_story == nil then
				arg_226_1.var_.characterEffect10025ui_story = var_229_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_4 = 0.2

			if var_229_3 <= arg_226_1.time_ and arg_226_1.time_ < var_229_3 + var_229_4 and not isNil(var_229_2) then
				local var_229_5 = (arg_226_1.time_ - var_229_3) / var_229_4

				if arg_226_1.var_.characterEffect10025ui_story and not isNil(var_229_2) then
					arg_226_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= var_229_3 + var_229_4 and arg_226_1.time_ < var_229_3 + var_229_4 + arg_229_0 and not isNil(var_229_2) and arg_226_1.var_.characterEffect10025ui_story then
				arg_226_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_229_6 = 0
			local var_229_7 = 0.475

			if var_229_6 < arg_226_1.time_ and arg_226_1.time_ <= var_229_6 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				local var_229_8 = arg_226_1:FormatText(StoryNameCfg[328].name)

				arg_226_1.leftNameTxt_.text = var_229_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_9 = arg_226_1:GetWordFromCfg(116061055)
				local var_229_10 = arg_226_1:FormatText(var_229_9.content)

				arg_226_1.text_.text = var_229_10

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_11 = 19
				local var_229_12 = utf8.len(var_229_10)
				local var_229_13 = var_229_11 <= 0 and var_229_7 or var_229_7 * (var_229_12 / var_229_11)

				if var_229_13 > 0 and var_229_7 < var_229_13 then
					arg_226_1.talkMaxDuration = var_229_13

					if var_229_13 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_6
					end
				end

				arg_226_1.text_.text = var_229_10
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061055", "story_v_out_116061.awb") ~= 0 then
					local var_229_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061055", "story_v_out_116061.awb") / 1000

					if var_229_14 + var_229_6 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_14 + var_229_6
					end

					if var_229_9.prefab_name ~= "" and arg_226_1.actors_[var_229_9.prefab_name] ~= nil then
						local var_229_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_9.prefab_name].transform, "story_v_out_116061", "116061055", "story_v_out_116061.awb")

						arg_226_1:RecordAudio("116061055", var_229_15)
						arg_226_1:RecordAudio("116061055", var_229_15)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_116061", "116061055", "story_v_out_116061.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_116061", "116061055", "story_v_out_116061.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_16 = math.max(var_229_7, arg_226_1.talkMaxDuration)

			if var_229_6 <= arg_226_1.time_ and arg_226_1.time_ < var_229_6 + var_229_16 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_6) / var_229_16

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_6 + var_229_16 and arg_226_1.time_ < var_229_6 + var_229_16 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play116061056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 116061056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play116061057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = arg_230_1.actors_["10025ui_story"].transform
			local var_233_1 = 0

			if var_233_1 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.var_.moveOldPos10025ui_story = var_233_0.localPosition
			end

			local var_233_2 = 0.001

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_2 then
				local var_233_3 = (arg_230_1.time_ - var_233_1) / var_233_2
				local var_233_4 = Vector3.New(0, 100, 0)

				var_233_0.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos10025ui_story, var_233_4, var_233_3)

				local var_233_5 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_5.x, var_233_5.y, var_233_5.z)

				local var_233_6 = var_233_0.localEulerAngles

				var_233_6.z = 0
				var_233_6.x = 0
				var_233_0.localEulerAngles = var_233_6
			end

			if arg_230_1.time_ >= var_233_1 + var_233_2 and arg_230_1.time_ < var_233_1 + var_233_2 + arg_233_0 then
				var_233_0.localPosition = Vector3.New(0, 100, 0)

				local var_233_7 = manager.ui.mainCamera.transform.position - var_233_0.position

				var_233_0.forward = Vector3.New(var_233_7.x, var_233_7.y, var_233_7.z)

				local var_233_8 = var_233_0.localEulerAngles

				var_233_8.z = 0
				var_233_8.x = 0
				var_233_0.localEulerAngles = var_233_8
			end

			local var_233_9 = 0
			local var_233_10 = 1

			if var_233_9 < arg_230_1.time_ and arg_230_1.time_ <= var_233_9 + arg_233_0 then
				local var_233_11 = "play"
				local var_233_12 = "effect"

				arg_230_1:AudioAction(var_233_11, var_233_12, "se_story_side_1026", "se_story_1026_cat02", "")
			end

			local var_233_13 = 0
			local var_233_14 = 0.525

			if var_233_13 < arg_230_1.time_ and arg_230_1.time_ <= var_233_13 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_15 = arg_230_1:GetWordFromCfg(116061056)
				local var_233_16 = arg_230_1:FormatText(var_233_15.content)

				arg_230_1.text_.text = var_233_16

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_17 = 21
				local var_233_18 = utf8.len(var_233_16)
				local var_233_19 = var_233_17 <= 0 and var_233_14 or var_233_14 * (var_233_18 / var_233_17)

				if var_233_19 > 0 and var_233_14 < var_233_19 then
					arg_230_1.talkMaxDuration = var_233_19

					if var_233_19 + var_233_13 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_19 + var_233_13
					end
				end

				arg_230_1.text_.text = var_233_16
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_20 = math.max(var_233_14, arg_230_1.talkMaxDuration)

			if var_233_13 <= arg_230_1.time_ and arg_230_1.time_ < var_233_13 + var_233_20 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_13) / var_233_20

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_13 + var_233_20 and arg_230_1.time_ < var_233_13 + var_233_20 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play116061057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 116061057
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play116061058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			local var_237_0 = 0
			local var_237_1 = 0.2

			if var_237_0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_0 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				local var_237_2 = arg_234_1:FormatText(StoryNameCfg[7].name)

				arg_234_1.leftNameTxt_.text = var_237_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, true)
				arg_234_1.iconController_:SetSelectedState("hero")

				arg_234_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_234_1.callingController_:SetSelectedState("normal")

				arg_234_1.keyicon_.color = Color.New(1, 1, 1)
				arg_234_1.icon_.color = Color.New(1, 1, 1)

				local var_237_3 = arg_234_1:GetWordFromCfg(116061057)
				local var_237_4 = arg_234_1:FormatText(var_237_3.content)

				arg_234_1.text_.text = var_237_4

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 8
				local var_237_6 = utf8.len(var_237_4)
				local var_237_7 = var_237_5 <= 0 and var_237_1 or var_237_1 * (var_237_6 / var_237_5)

				if var_237_7 > 0 and var_237_1 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_0 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_0
					end
				end

				arg_234_1.text_.text = var_237_4
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_8 = math.max(var_237_1, arg_234_1.talkMaxDuration)

			if var_237_0 <= arg_234_1.time_ and arg_234_1.time_ < var_237_0 + var_237_8 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_0) / var_237_8

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_0 + var_237_8 and arg_234_1.time_ < var_237_0 + var_237_8 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play116061058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 116061058
		arg_238_1.duration_ = 5.43

		local var_238_0 = {
			zh = 3.1,
			ja = 5.433
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play116061059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			local var_241_0 = arg_238_1.actors_["10025ui_story"].transform
			local var_241_1 = 0

			if var_241_1 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.var_.moveOldPos10025ui_story = var_241_0.localPosition
			end

			local var_241_2 = 0.001

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_2 then
				local var_241_3 = (arg_238_1.time_ - var_241_1) / var_241_2
				local var_241_4 = Vector3.New(0, -1.1, -5.9)

				var_241_0.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10025ui_story, var_241_4, var_241_3)

				local var_241_5 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_5.x, var_241_5.y, var_241_5.z)

				local var_241_6 = var_241_0.localEulerAngles

				var_241_6.z = 0
				var_241_6.x = 0
				var_241_0.localEulerAngles = var_241_6
			end

			if arg_238_1.time_ >= var_241_1 + var_241_2 and arg_238_1.time_ < var_241_1 + var_241_2 + arg_241_0 then
				var_241_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_241_7 = manager.ui.mainCamera.transform.position - var_241_0.position

				var_241_0.forward = Vector3.New(var_241_7.x, var_241_7.y, var_241_7.z)

				local var_241_8 = var_241_0.localEulerAngles

				var_241_8.z = 0
				var_241_8.x = 0
				var_241_0.localEulerAngles = var_241_8
			end

			local var_241_9 = 0

			if var_241_9 < arg_238_1.time_ and arg_238_1.time_ <= var_241_9 + arg_241_0 then
				arg_238_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_241_10 = 0

			if var_241_10 < arg_238_1.time_ and arg_238_1.time_ <= var_241_10 + arg_241_0 then
				arg_238_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_241_11 = arg_238_1.actors_["10025ui_story"]
			local var_241_12 = 0

			if var_241_12 < arg_238_1.time_ and arg_238_1.time_ <= var_241_12 + arg_241_0 and not isNil(var_241_11) and arg_238_1.var_.characterEffect10025ui_story == nil then
				arg_238_1.var_.characterEffect10025ui_story = var_241_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_13 = 0.2

			if var_241_12 <= arg_238_1.time_ and arg_238_1.time_ < var_241_12 + var_241_13 and not isNil(var_241_11) then
				local var_241_14 = (arg_238_1.time_ - var_241_12) / var_241_13

				if arg_238_1.var_.characterEffect10025ui_story and not isNil(var_241_11) then
					arg_238_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= var_241_12 + var_241_13 and arg_238_1.time_ < var_241_12 + var_241_13 + arg_241_0 and not isNil(var_241_11) and arg_238_1.var_.characterEffect10025ui_story then
				arg_238_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_241_15 = 0
			local var_241_16 = 0.25

			if var_241_15 < arg_238_1.time_ and arg_238_1.time_ <= var_241_15 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				local var_241_17 = arg_238_1:FormatText(StoryNameCfg[328].name)

				arg_238_1.leftNameTxt_.text = var_241_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_18 = arg_238_1:GetWordFromCfg(116061058)
				local var_241_19 = arg_238_1:FormatText(var_241_18.content)

				arg_238_1.text_.text = var_241_19

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_20 = 10
				local var_241_21 = utf8.len(var_241_19)
				local var_241_22 = var_241_20 <= 0 and var_241_16 or var_241_16 * (var_241_21 / var_241_20)

				if var_241_22 > 0 and var_241_16 < var_241_22 then
					arg_238_1.talkMaxDuration = var_241_22

					if var_241_22 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_22 + var_241_15
					end
				end

				arg_238_1.text_.text = var_241_19
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061058", "story_v_out_116061.awb") ~= 0 then
					local var_241_23 = manager.audio:GetVoiceLength("story_v_out_116061", "116061058", "story_v_out_116061.awb") / 1000

					if var_241_23 + var_241_15 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_23 + var_241_15
					end

					if var_241_18.prefab_name ~= "" and arg_238_1.actors_[var_241_18.prefab_name] ~= nil then
						local var_241_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_18.prefab_name].transform, "story_v_out_116061", "116061058", "story_v_out_116061.awb")

						arg_238_1:RecordAudio("116061058", var_241_24)
						arg_238_1:RecordAudio("116061058", var_241_24)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_116061", "116061058", "story_v_out_116061.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_116061", "116061058", "story_v_out_116061.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_25 = math.max(var_241_16, arg_238_1.talkMaxDuration)

			if var_241_15 <= arg_238_1.time_ and arg_238_1.time_ < var_241_15 + var_241_25 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_15) / var_241_25

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_15 + var_241_25 and arg_238_1.time_ < var_241_15 + var_241_25 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play116061059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 116061059
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play116061060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = arg_242_1.actors_["10025ui_story"]
			local var_245_1 = 0

			if var_245_1 < arg_242_1.time_ and arg_242_1.time_ <= var_245_1 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect10025ui_story == nil then
				arg_242_1.var_.characterEffect10025ui_story = var_245_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.2

			if var_245_1 <= arg_242_1.time_ and arg_242_1.time_ < var_245_1 + var_245_2 and not isNil(var_245_0) then
				local var_245_3 = (arg_242_1.time_ - var_245_1) / var_245_2

				if arg_242_1.var_.characterEffect10025ui_story and not isNil(var_245_0) then
					local var_245_4 = Mathf.Lerp(0, 0.5, var_245_3)

					arg_242_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_242_1.var_.characterEffect10025ui_story.fillRatio = var_245_4
				end
			end

			if arg_242_1.time_ >= var_245_1 + var_245_2 and arg_242_1.time_ < var_245_1 + var_245_2 + arg_245_0 and not isNil(var_245_0) and arg_242_1.var_.characterEffect10025ui_story then
				local var_245_5 = 0.5

				arg_242_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_242_1.var_.characterEffect10025ui_story.fillRatio = var_245_5
			end

			local var_245_6 = 0
			local var_245_7 = 0.625

			if var_245_6 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_8 = arg_242_1:GetWordFromCfg(116061059)
				local var_245_9 = arg_242_1:FormatText(var_245_8.content)

				arg_242_1.text_.text = var_245_9

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_10 = 25
				local var_245_11 = utf8.len(var_245_9)
				local var_245_12 = var_245_10 <= 0 and var_245_7 or var_245_7 * (var_245_11 / var_245_10)

				if var_245_12 > 0 and var_245_7 < var_245_12 then
					arg_242_1.talkMaxDuration = var_245_12

					if var_245_12 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_12 + var_245_6
					end
				end

				arg_242_1.text_.text = var_245_9
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_13 = math.max(var_245_7, arg_242_1.talkMaxDuration)

			if var_245_6 <= arg_242_1.time_ and arg_242_1.time_ < var_245_6 + var_245_13 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_6) / var_245_13

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_6 + var_245_13 and arg_242_1.time_ < var_245_6 + var_245_13 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play116061060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 116061060
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play116061061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_0 = 0
			local var_249_1 = 0.575

			if var_249_0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_0 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, true)

				local var_249_2 = arg_246_1:FormatText(StoryNameCfg[7].name)

				arg_246_1.leftNameTxt_.text = var_249_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_246_1.leftNameTxt_.transform)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1.leftNameTxt_.text)
				SetActive(arg_246_1.iconTrs_.gameObject, true)
				arg_246_1.iconController_:SetSelectedState("hero")

				arg_246_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_246_1.callingController_:SetSelectedState("normal")

				arg_246_1.keyicon_.color = Color.New(1, 1, 1)
				arg_246_1.icon_.color = Color.New(1, 1, 1)

				local var_249_3 = arg_246_1:GetWordFromCfg(116061060)
				local var_249_4 = arg_246_1:FormatText(var_249_3.content)

				arg_246_1.text_.text = var_249_4

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 23
				local var_249_6 = utf8.len(var_249_4)
				local var_249_7 = var_249_5 <= 0 and var_249_1 or var_249_1 * (var_249_6 / var_249_5)

				if var_249_7 > 0 and var_249_1 < var_249_7 then
					arg_246_1.talkMaxDuration = var_249_7

					if var_249_7 + var_249_0 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_7 + var_249_0
					end
				end

				arg_246_1.text_.text = var_249_4
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_8 = math.max(var_249_1, arg_246_1.talkMaxDuration)

			if var_249_0 <= arg_246_1.time_ and arg_246_1.time_ < var_249_0 + var_249_8 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_0) / var_249_8

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_0 + var_249_8 and arg_246_1.time_ < var_249_0 + var_249_8 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play116061061 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 116061061
		arg_250_1.duration_ = 5.27

		local var_250_0 = {
			zh = 5.266,
			ja = 3.233
		}
		local var_250_1 = manager.audio:GetLocalizationFlag()

		if var_250_0[var_250_1] ~= nil then
			arg_250_1.duration_ = var_250_0[var_250_1]
		end

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play116061062(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0

			if var_253_0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_0 + arg_253_0 then
				arg_250_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_253_1 = 0

			if var_253_1 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_253_2 = arg_250_1.actors_["10025ui_story"]
			local var_253_3 = 0

			if var_253_3 < arg_250_1.time_ and arg_250_1.time_ <= var_253_3 + arg_253_0 and not isNil(var_253_2) and arg_250_1.var_.characterEffect10025ui_story == nil then
				arg_250_1.var_.characterEffect10025ui_story = var_253_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_253_4 = 0.2

			if var_253_3 <= arg_250_1.time_ and arg_250_1.time_ < var_253_3 + var_253_4 and not isNil(var_253_2) then
				local var_253_5 = (arg_250_1.time_ - var_253_3) / var_253_4

				if arg_250_1.var_.characterEffect10025ui_story and not isNil(var_253_2) then
					arg_250_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_250_1.time_ >= var_253_3 + var_253_4 and arg_250_1.time_ < var_253_3 + var_253_4 + arg_253_0 and not isNil(var_253_2) and arg_250_1.var_.characterEffect10025ui_story then
				arg_250_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_253_6 = 0
			local var_253_7 = 0.575

			if var_253_6 < arg_250_1.time_ and arg_250_1.time_ <= var_253_6 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, true)

				local var_253_8 = arg_250_1:FormatText(StoryNameCfg[328].name)

				arg_250_1.leftNameTxt_.text = var_253_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_250_1.leftNameTxt_.transform)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1.leftNameTxt_.text)
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_9 = arg_250_1:GetWordFromCfg(116061061)
				local var_253_10 = arg_250_1:FormatText(var_253_9.content)

				arg_250_1.text_.text = var_253_10

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_11 = 23
				local var_253_12 = utf8.len(var_253_10)
				local var_253_13 = var_253_11 <= 0 and var_253_7 or var_253_7 * (var_253_12 / var_253_11)

				if var_253_13 > 0 and var_253_7 < var_253_13 then
					arg_250_1.talkMaxDuration = var_253_13

					if var_253_13 + var_253_6 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_13 + var_253_6
					end
				end

				arg_250_1.text_.text = var_253_10
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061061", "story_v_out_116061.awb") ~= 0 then
					local var_253_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061061", "story_v_out_116061.awb") / 1000

					if var_253_14 + var_253_6 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_14 + var_253_6
					end

					if var_253_9.prefab_name ~= "" and arg_250_1.actors_[var_253_9.prefab_name] ~= nil then
						local var_253_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_250_1.actors_[var_253_9.prefab_name].transform, "story_v_out_116061", "116061061", "story_v_out_116061.awb")

						arg_250_1:RecordAudio("116061061", var_253_15)
						arg_250_1:RecordAudio("116061061", var_253_15)
					else
						arg_250_1:AudioAction("play", "voice", "story_v_out_116061", "116061061", "story_v_out_116061.awb")
					end

					arg_250_1:RecordHistoryTalkVoice("story_v_out_116061", "116061061", "story_v_out_116061.awb")
				end

				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_16 = math.max(var_253_7, arg_250_1.talkMaxDuration)

			if var_253_6 <= arg_250_1.time_ and arg_250_1.time_ < var_253_6 + var_253_16 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_6) / var_253_16

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_6 + var_253_16 and arg_250_1.time_ < var_253_6 + var_253_16 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play116061062 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 116061062
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play116061063(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			local var_257_0 = arg_254_1.actors_["10025ui_story"].transform
			local var_257_1 = 0

			if var_257_1 < arg_254_1.time_ and arg_254_1.time_ <= var_257_1 + arg_257_0 then
				arg_254_1.var_.moveOldPos10025ui_story = var_257_0.localPosition
			end

			local var_257_2 = 0.001

			if var_257_1 <= arg_254_1.time_ and arg_254_1.time_ < var_257_1 + var_257_2 then
				local var_257_3 = (arg_254_1.time_ - var_257_1) / var_257_2
				local var_257_4 = Vector3.New(0, 100, 0)

				var_257_0.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos10025ui_story, var_257_4, var_257_3)

				local var_257_5 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_5.x, var_257_5.y, var_257_5.z)

				local var_257_6 = var_257_0.localEulerAngles

				var_257_6.z = 0
				var_257_6.x = 0
				var_257_0.localEulerAngles = var_257_6
			end

			if arg_254_1.time_ >= var_257_1 + var_257_2 and arg_254_1.time_ < var_257_1 + var_257_2 + arg_257_0 then
				var_257_0.localPosition = Vector3.New(0, 100, 0)

				local var_257_7 = manager.ui.mainCamera.transform.position - var_257_0.position

				var_257_0.forward = Vector3.New(var_257_7.x, var_257_7.y, var_257_7.z)

				local var_257_8 = var_257_0.localEulerAngles

				var_257_8.z = 0
				var_257_8.x = 0
				var_257_0.localEulerAngles = var_257_8
			end

			local var_257_9 = 0
			local var_257_10 = 0.4

			if var_257_9 < arg_254_1.time_ and arg_254_1.time_ <= var_257_9 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, false)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_11 = arg_254_1:GetWordFromCfg(116061062)
				local var_257_12 = arg_254_1:FormatText(var_257_11.content)

				arg_254_1.text_.text = var_257_12

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_13 = 16
				local var_257_14 = utf8.len(var_257_12)
				local var_257_15 = var_257_13 <= 0 and var_257_10 or var_257_10 * (var_257_14 / var_257_13)

				if var_257_15 > 0 and var_257_10 < var_257_15 then
					arg_254_1.talkMaxDuration = var_257_15

					if var_257_15 + var_257_9 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_15 + var_257_9
					end
				end

				arg_254_1.text_.text = var_257_12
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_16 = math.max(var_257_10, arg_254_1.talkMaxDuration)

			if var_257_9 <= arg_254_1.time_ and arg_254_1.time_ < var_257_9 + var_257_16 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_9) / var_257_16

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_9 + var_257_16 and arg_254_1.time_ < var_257_9 + var_257_16 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play116061063 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 116061063
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play116061064(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 0
			local var_261_1 = 0.2

			if var_261_0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				local var_261_2 = arg_258_1:FormatText(StoryNameCfg[7].name)

				arg_258_1.leftNameTxt_.text = var_261_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, true)
				arg_258_1.iconController_:SetSelectedState("hero")

				arg_258_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_258_1.callingController_:SetSelectedState("normal")

				arg_258_1.keyicon_.color = Color.New(1, 1, 1)
				arg_258_1.icon_.color = Color.New(1, 1, 1)

				local var_261_3 = arg_258_1:GetWordFromCfg(116061063)
				local var_261_4 = arg_258_1:FormatText(var_261_3.content)

				arg_258_1.text_.text = var_261_4

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_5 = 8
				local var_261_6 = utf8.len(var_261_4)
				local var_261_7 = var_261_5 <= 0 and var_261_1 or var_261_1 * (var_261_6 / var_261_5)

				if var_261_7 > 0 and var_261_1 < var_261_7 then
					arg_258_1.talkMaxDuration = var_261_7

					if var_261_7 + var_261_0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_7 + var_261_0
					end
				end

				arg_258_1.text_.text = var_261_4
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_8 = math.max(var_261_1, arg_258_1.talkMaxDuration)

			if var_261_0 <= arg_258_1.time_ and arg_258_1.time_ < var_261_0 + var_261_8 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_0) / var_261_8

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_0 + var_261_8 and arg_258_1.time_ < var_261_0 + var_261_8 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play116061064 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 116061064
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play116061065(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			local var_265_0 = manager.ui.mainCamera.transform
			local var_265_1 = 0

			if var_265_1 < arg_262_1.time_ and arg_262_1.time_ <= var_265_1 + arg_265_0 then
				arg_262_1.var_.shakeOldPos = var_265_0.localPosition
			end

			local var_265_2 = 0.3

			if var_265_1 <= arg_262_1.time_ and arg_262_1.time_ < var_265_1 + var_265_2 then
				local var_265_3 = (arg_262_1.time_ - var_265_1) / 0.066
				local var_265_4, var_265_5 = math.modf(var_265_3)

				var_265_0.localPosition = Vector3.New(var_265_5 * 0.13, var_265_5 * 0.13, var_265_5 * 0.13) + arg_262_1.var_.shakeOldPos
			end

			if arg_262_1.time_ >= var_265_1 + var_265_2 and arg_262_1.time_ < var_265_1 + var_265_2 + arg_265_0 then
				var_265_0.localPosition = arg_262_1.var_.shakeOldPos
			end

			local var_265_6 = manager.ui.mainCamera.transform
			local var_265_7 = 0.4

			if var_265_7 < arg_262_1.time_ and arg_262_1.time_ <= var_265_7 + arg_265_0 then
				arg_262_1.var_.shakeOldPos = var_265_6.localPosition
			end

			local var_265_8 = 0.3

			if var_265_7 <= arg_262_1.time_ and arg_262_1.time_ < var_265_7 + var_265_8 then
				local var_265_9 = (arg_262_1.time_ - var_265_7) / 0.066
				local var_265_10, var_265_11 = math.modf(var_265_9)

				var_265_6.localPosition = Vector3.New(var_265_11 * 0.13, var_265_11 * 0.13, var_265_11 * 0.13) + arg_262_1.var_.shakeOldPos
			end

			if arg_262_1.time_ >= var_265_7 + var_265_8 and arg_262_1.time_ < var_265_7 + var_265_8 + arg_265_0 then
				var_265_6.localPosition = arg_262_1.var_.shakeOldPos
			end

			local var_265_12 = manager.ui.mainCamera.transform
			local var_265_13 = 0.8

			if var_265_13 < arg_262_1.time_ and arg_262_1.time_ <= var_265_13 + arg_265_0 then
				arg_262_1.var_.shakeOldPos = var_265_12.localPosition
			end

			local var_265_14 = 0.3

			if var_265_13 <= arg_262_1.time_ and arg_262_1.time_ < var_265_13 + var_265_14 then
				local var_265_15 = (arg_262_1.time_ - var_265_13) / 0.066
				local var_265_16, var_265_17 = math.modf(var_265_15)

				var_265_12.localPosition = Vector3.New(var_265_17 * 0.13, var_265_17 * 0.13, var_265_17 * 0.13) + arg_262_1.var_.shakeOldPos
			end

			if arg_262_1.time_ >= var_265_13 + var_265_14 and arg_262_1.time_ < var_265_13 + var_265_14 + arg_265_0 then
				var_265_12.localPosition = arg_262_1.var_.shakeOldPos
			end

			local var_265_18 = manager.ui.mainCamera.transform
			local var_265_19 = 1.2

			if var_265_19 < arg_262_1.time_ and arg_262_1.time_ <= var_265_19 + arg_265_0 then
				arg_262_1.var_.shakeOldPos = var_265_18.localPosition
			end

			local var_265_20 = 0.3

			if var_265_19 <= arg_262_1.time_ and arg_262_1.time_ < var_265_19 + var_265_20 then
				local var_265_21 = (arg_262_1.time_ - var_265_19) / 0.066
				local var_265_22, var_265_23 = math.modf(var_265_21)

				var_265_18.localPosition = Vector3.New(var_265_23 * 0.13, var_265_23 * 0.13, var_265_23 * 0.13) + arg_262_1.var_.shakeOldPos
			end

			if arg_262_1.time_ >= var_265_19 + var_265_20 and arg_262_1.time_ < var_265_19 + var_265_20 + arg_265_0 then
				var_265_18.localPosition = arg_262_1.var_.shakeOldPos
			end

			local var_265_24 = 0
			local var_265_25 = 0.325

			if var_265_24 < arg_262_1.time_ and arg_262_1.time_ <= var_265_24 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_26 = arg_262_1:GetWordFromCfg(116061064)
				local var_265_27 = arg_262_1:FormatText(var_265_26.content)

				arg_262_1.text_.text = var_265_27

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_28 = 13
				local var_265_29 = utf8.len(var_265_27)
				local var_265_30 = var_265_28 <= 0 and var_265_25 or var_265_25 * (var_265_29 / var_265_28)

				if var_265_30 > 0 and var_265_25 < var_265_30 then
					arg_262_1.talkMaxDuration = var_265_30

					if var_265_30 + var_265_24 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_30 + var_265_24
					end
				end

				arg_262_1.text_.text = var_265_27
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_31 = math.max(var_265_25, arg_262_1.talkMaxDuration)

			if var_265_24 <= arg_262_1.time_ and arg_262_1.time_ < var_265_24 + var_265_31 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_24) / var_265_31

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_24 + var_265_31 and arg_262_1.time_ < var_265_24 + var_265_31 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play116061065 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 116061065
		arg_266_1.duration_ = 4.1

		local var_266_0 = {
			zh = 4.1,
			ja = 2.233
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play116061066(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			local var_269_0 = 0
			local var_269_1 = 0.525

			if var_269_0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_0 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				local var_269_2 = arg_266_1:FormatText(StoryNameCfg[6].name)

				arg_266_1.leftNameTxt_.text = var_269_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, true)
				arg_266_1.iconController_:SetSelectedState("hero")

				arg_266_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_266_1.callingController_:SetSelectedState("normal")

				arg_266_1.keyicon_.color = Color.New(1, 1, 1)
				arg_266_1.icon_.color = Color.New(1, 1, 1)

				local var_269_3 = arg_266_1:GetWordFromCfg(116061065)
				local var_269_4 = arg_266_1:FormatText(var_269_3.content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_5 = 21
				local var_269_6 = utf8.len(var_269_4)
				local var_269_7 = var_269_5 <= 0 and var_269_1 or var_269_1 * (var_269_6 / var_269_5)

				if var_269_7 > 0 and var_269_1 < var_269_7 then
					arg_266_1.talkMaxDuration = var_269_7

					if var_269_7 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_7 + var_269_0
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061065", "story_v_out_116061.awb") ~= 0 then
					local var_269_8 = manager.audio:GetVoiceLength("story_v_out_116061", "116061065", "story_v_out_116061.awb") / 1000

					if var_269_8 + var_269_0 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_8 + var_269_0
					end

					if var_269_3.prefab_name ~= "" and arg_266_1.actors_[var_269_3.prefab_name] ~= nil then
						local var_269_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_3.prefab_name].transform, "story_v_out_116061", "116061065", "story_v_out_116061.awb")

						arg_266_1:RecordAudio("116061065", var_269_9)
						arg_266_1:RecordAudio("116061065", var_269_9)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_116061", "116061065", "story_v_out_116061.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_116061", "116061065", "story_v_out_116061.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_10 = math.max(var_269_1, arg_266_1.talkMaxDuration)

			if var_269_0 <= arg_266_1.time_ and arg_266_1.time_ < var_269_0 + var_269_10 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_0) / var_269_10

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_0 + var_269_10 and arg_266_1.time_ < var_269_0 + var_269_10 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play116061066 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 116061066
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play116061067(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			local var_273_0 = 0
			local var_273_1 = 0.9

			if var_273_0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_0 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				local var_273_2 = arg_270_1:FormatText(StoryNameCfg[7].name)

				arg_270_1.leftNameTxt_.text = var_273_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, true)
				arg_270_1.iconController_:SetSelectedState("hero")

				arg_270_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_270_1.callingController_:SetSelectedState("normal")

				arg_270_1.keyicon_.color = Color.New(1, 1, 1)
				arg_270_1.icon_.color = Color.New(1, 1, 1)

				local var_273_3 = arg_270_1:GetWordFromCfg(116061066)
				local var_273_4 = arg_270_1:FormatText(var_273_3.content)

				arg_270_1.text_.text = var_273_4

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 36
				local var_273_6 = utf8.len(var_273_4)
				local var_273_7 = var_273_5 <= 0 and var_273_1 or var_273_1 * (var_273_6 / var_273_5)

				if var_273_7 > 0 and var_273_1 < var_273_7 then
					arg_270_1.talkMaxDuration = var_273_7

					if var_273_7 + var_273_0 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_7 + var_273_0
					end
				end

				arg_270_1.text_.text = var_273_4
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_8 = math.max(var_273_1, arg_270_1.talkMaxDuration)

			if var_273_0 <= arg_270_1.time_ and arg_270_1.time_ < var_273_0 + var_273_8 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_0) / var_273_8

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_0 + var_273_8 and arg_270_1.time_ < var_273_0 + var_273_8 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play116061067 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 116061067
		arg_274_1.duration_ = 3.13

		local var_274_0 = {
			zh = 2.366,
			ja = 3.133
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
				arg_274_0:Play116061068(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			local var_277_0 = 0
			local var_277_1 = 0.225

			if var_277_0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_0 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				local var_277_2 = arg_274_1:FormatText(StoryNameCfg[6].name)

				arg_274_1.leftNameTxt_.text = var_277_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, true)
				arg_274_1.iconController_:SetSelectedState("hero")

				arg_274_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_274_1.callingController_:SetSelectedState("normal")

				arg_274_1.keyicon_.color = Color.New(1, 1, 1)
				arg_274_1.icon_.color = Color.New(1, 1, 1)

				local var_277_3 = arg_274_1:GetWordFromCfg(116061067)
				local var_277_4 = arg_274_1:FormatText(var_277_3.content)

				arg_274_1.text_.text = var_277_4

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_5 = 9
				local var_277_6 = utf8.len(var_277_4)
				local var_277_7 = var_277_5 <= 0 and var_277_1 or var_277_1 * (var_277_6 / var_277_5)

				if var_277_7 > 0 and var_277_1 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_0
					end
				end

				arg_274_1.text_.text = var_277_4
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061067", "story_v_out_116061.awb") ~= 0 then
					local var_277_8 = manager.audio:GetVoiceLength("story_v_out_116061", "116061067", "story_v_out_116061.awb") / 1000

					if var_277_8 + var_277_0 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_0
					end

					if var_277_3.prefab_name ~= "" and arg_274_1.actors_[var_277_3.prefab_name] ~= nil then
						local var_277_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_3.prefab_name].transform, "story_v_out_116061", "116061067", "story_v_out_116061.awb")

						arg_274_1:RecordAudio("116061067", var_277_9)
						arg_274_1:RecordAudio("116061067", var_277_9)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_116061", "116061067", "story_v_out_116061.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_116061", "116061067", "story_v_out_116061.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_10 = math.max(var_277_1, arg_274_1.talkMaxDuration)

			if var_277_0 <= arg_274_1.time_ and arg_274_1.time_ < var_277_0 + var_277_10 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_0) / var_277_10

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_0 + var_277_10 and arg_274_1.time_ < var_277_0 + var_277_10 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play116061068 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 116061068
		arg_278_1.duration_ = 11.77

		local var_278_0 = {
			zh = 5.966,
			ja = 11.766
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
				arg_278_0:Play116061069(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			local var_281_0 = 0
			local var_281_1 = 0.525

			if var_281_0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				local var_281_2 = arg_278_1:FormatText(StoryNameCfg[37].name)

				arg_278_1.leftNameTxt_.text = var_281_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, true)
				arg_278_1.iconController_:SetSelectedState("hero")

				arg_278_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_278_1.callingController_:SetSelectedState("normal")

				arg_278_1.keyicon_.color = Color.New(1, 1, 1)
				arg_278_1.icon_.color = Color.New(1, 1, 1)

				local var_281_3 = arg_278_1:GetWordFromCfg(116061068)
				local var_281_4 = arg_278_1:FormatText(var_281_3.content)

				arg_278_1.text_.text = var_281_4

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 21
				local var_281_6 = utf8.len(var_281_4)
				local var_281_7 = var_281_5 <= 0 and var_281_1 or var_281_1 * (var_281_6 / var_281_5)

				if var_281_7 > 0 and var_281_1 < var_281_7 then
					arg_278_1.talkMaxDuration = var_281_7

					if var_281_7 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_7 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_4
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061068", "story_v_out_116061.awb") ~= 0 then
					local var_281_8 = manager.audio:GetVoiceLength("story_v_out_116061", "116061068", "story_v_out_116061.awb") / 1000

					if var_281_8 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_8 + var_281_0
					end

					if var_281_3.prefab_name ~= "" and arg_278_1.actors_[var_281_3.prefab_name] ~= nil then
						local var_281_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_3.prefab_name].transform, "story_v_out_116061", "116061068", "story_v_out_116061.awb")

						arg_278_1:RecordAudio("116061068", var_281_9)
						arg_278_1:RecordAudio("116061068", var_281_9)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_116061", "116061068", "story_v_out_116061.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_116061", "116061068", "story_v_out_116061.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_10 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_10 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_10

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_10 and arg_278_1.time_ < var_281_0 + var_281_10 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play116061069 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 116061069
		arg_282_1.duration_ = 5.07

		local var_282_0 = {
			zh = 5.066,
			ja = 3.5
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
				arg_282_0:Play116061070(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			local var_285_0 = 0
			local var_285_1 = 0.55

			if var_285_0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_0 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				local var_285_2 = arg_282_1:FormatText(StoryNameCfg[6].name)

				arg_282_1.leftNameTxt_.text = var_285_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, true)
				arg_282_1.iconController_:SetSelectedState("hero")

				arg_282_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_282_1.callingController_:SetSelectedState("normal")

				arg_282_1.keyicon_.color = Color.New(1, 1, 1)
				arg_282_1.icon_.color = Color.New(1, 1, 1)

				local var_285_3 = arg_282_1:GetWordFromCfg(116061069)
				local var_285_4 = arg_282_1:FormatText(var_285_3.content)

				arg_282_1.text_.text = var_285_4

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_5 = 22
				local var_285_6 = utf8.len(var_285_4)
				local var_285_7 = var_285_5 <= 0 and var_285_1 or var_285_1 * (var_285_6 / var_285_5)

				if var_285_7 > 0 and var_285_1 < var_285_7 then
					arg_282_1.talkMaxDuration = var_285_7

					if var_285_7 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_7 + var_285_0
					end
				end

				arg_282_1.text_.text = var_285_4
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061069", "story_v_out_116061.awb") ~= 0 then
					local var_285_8 = manager.audio:GetVoiceLength("story_v_out_116061", "116061069", "story_v_out_116061.awb") / 1000

					if var_285_8 + var_285_0 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_8 + var_285_0
					end

					if var_285_3.prefab_name ~= "" and arg_282_1.actors_[var_285_3.prefab_name] ~= nil then
						local var_285_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_3.prefab_name].transform, "story_v_out_116061", "116061069", "story_v_out_116061.awb")

						arg_282_1:RecordAudio("116061069", var_285_9)
						arg_282_1:RecordAudio("116061069", var_285_9)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_116061", "116061069", "story_v_out_116061.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_116061", "116061069", "story_v_out_116061.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_10 = math.max(var_285_1, arg_282_1.talkMaxDuration)

			if var_285_0 <= arg_282_1.time_ and arg_282_1.time_ < var_285_0 + var_285_10 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_0) / var_285_10

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_0 + var_285_10 and arg_282_1.time_ < var_285_0 + var_285_10 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play116061070 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 116061070
		arg_286_1.duration_ = 4.3

		local var_286_0 = {
			zh = 3.466,
			ja = 4.3
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
				arg_286_0:Play116061071(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			local var_289_0 = 0
			local var_289_1 = 0.275

			if var_289_0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_0 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				local var_289_2 = arg_286_1:FormatText(StoryNameCfg[6].name)

				arg_286_1.leftNameTxt_.text = var_289_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, true)
				arg_286_1.iconController_:SetSelectedState("hero")

				arg_286_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_286_1.callingController_:SetSelectedState("normal")

				arg_286_1.keyicon_.color = Color.New(1, 1, 1)
				arg_286_1.icon_.color = Color.New(1, 1, 1)

				local var_289_3 = arg_286_1:GetWordFromCfg(116061070)
				local var_289_4 = arg_286_1:FormatText(var_289_3.content)

				arg_286_1.text_.text = var_289_4

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 11
				local var_289_6 = utf8.len(var_289_4)
				local var_289_7 = var_289_5 <= 0 and var_289_1 or var_289_1 * (var_289_6 / var_289_5)

				if var_289_7 > 0 and var_289_1 < var_289_7 then
					arg_286_1.talkMaxDuration = var_289_7

					if var_289_7 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_7 + var_289_0
					end
				end

				arg_286_1.text_.text = var_289_4
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061070", "story_v_out_116061.awb") ~= 0 then
					local var_289_8 = manager.audio:GetVoiceLength("story_v_out_116061", "116061070", "story_v_out_116061.awb") / 1000

					if var_289_8 + var_289_0 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_8 + var_289_0
					end

					if var_289_3.prefab_name ~= "" and arg_286_1.actors_[var_289_3.prefab_name] ~= nil then
						local var_289_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_3.prefab_name].transform, "story_v_out_116061", "116061070", "story_v_out_116061.awb")

						arg_286_1:RecordAudio("116061070", var_289_9)
						arg_286_1:RecordAudio("116061070", var_289_9)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_116061", "116061070", "story_v_out_116061.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_116061", "116061070", "story_v_out_116061.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_10 = math.max(var_289_1, arg_286_1.talkMaxDuration)

			if var_289_0 <= arg_286_1.time_ and arg_286_1.time_ < var_289_0 + var_289_10 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_0) / var_289_10

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_0 + var_289_10 and arg_286_1.time_ < var_289_0 + var_289_10 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play116061071 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 116061071
		arg_290_1.duration_ = 9

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play116061072(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			local var_293_0 = 0

			if var_293_0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_0 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_1 = 2

			if var_293_0 <= arg_290_1.time_ and arg_290_1.time_ < var_293_0 + var_293_1 then
				local var_293_2 = (arg_290_1.time_ - var_293_0) / var_293_1
				local var_293_3 = Color.New(0, 0, 0)

				var_293_3.a = Mathf.Lerp(0, 1, var_293_2)
				arg_290_1.mask_.color = var_293_3
			end

			if arg_290_1.time_ >= var_293_0 + var_293_1 and arg_290_1.time_ < var_293_0 + var_293_1 + arg_293_0 then
				local var_293_4 = Color.New(0, 0, 0)

				var_293_4.a = 1
				arg_290_1.mask_.color = var_293_4
			end

			local var_293_5 = 2

			if var_293_5 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 then
				arg_290_1.mask_.enabled = true
				arg_290_1.mask_.raycastTarget = true

				arg_290_1:SetGaussion(false)
			end

			local var_293_6 = 2

			if var_293_5 <= arg_290_1.time_ and arg_290_1.time_ < var_293_5 + var_293_6 then
				local var_293_7 = (arg_290_1.time_ - var_293_5) / var_293_6
				local var_293_8 = Color.New(0, 0, 0)

				var_293_8.a = Mathf.Lerp(1, 0, var_293_7)
				arg_290_1.mask_.color = var_293_8
			end

			if arg_290_1.time_ >= var_293_5 + var_293_6 and arg_290_1.time_ < var_293_5 + var_293_6 + arg_293_0 then
				local var_293_9 = Color.New(0, 0, 0)
				local var_293_10 = 0

				arg_290_1.mask_.enabled = false
				var_293_9.a = var_293_10
				arg_290_1.mask_.color = var_293_9
			end

			if arg_290_1.frameCnt_ <= 1 then
				arg_290_1.dialog_:SetActive(false)
			end

			local var_293_11 = 3.999999999999
			local var_293_12 = 0.725

			if var_293_11 < arg_290_1.time_ and arg_290_1.time_ <= var_293_11 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0

				arg_290_1.dialog_:SetActive(true)

				arg_290_1.dialogCg_.alpha = 0

				local var_293_13 = LeanTween.value(arg_290_1.dialog_, 0, 1, 0.3)

				var_293_13:setOnUpdate(LuaHelper.FloatAction(function(arg_294_0)
					arg_290_1.dialogCg_.alpha = arg_294_0
				end))
				var_293_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_290_1.dialog_)
					var_293_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_290_1.duration_ = arg_290_1.duration_ + 0.3

				SetActive(arg_290_1.leftNameGo_, false)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_14 = arg_290_1:GetWordFromCfg(116061071)
				local var_293_15 = arg_290_1:FormatText(var_293_14.content)

				arg_290_1.text_.text = var_293_15

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_16 = 29
				local var_293_17 = utf8.len(var_293_15)
				local var_293_18 = var_293_16 <= 0 and var_293_12 or var_293_12 * (var_293_17 / var_293_16)

				if var_293_18 > 0 and var_293_12 < var_293_18 then
					arg_290_1.talkMaxDuration = var_293_18
					var_293_11 = var_293_11 + 0.3

					if var_293_18 + var_293_11 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_18 + var_293_11
					end
				end

				arg_290_1.text_.text = var_293_15
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_19 = var_293_11 + 0.3
			local var_293_20 = math.max(var_293_12, arg_290_1.talkMaxDuration)

			if var_293_19 <= arg_290_1.time_ and arg_290_1.time_ < var_293_19 + var_293_20 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_19) / var_293_20

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_19 + var_293_20 and arg_290_1.time_ < var_293_19 + var_293_20 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play116061072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 116061072
		arg_296_1.duration_ = 5

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play116061073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			local var_299_0 = 0
			local var_299_1 = 0.675

			if var_299_0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_0 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, false)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_2 = arg_296_1:GetWordFromCfg(116061072)
				local var_299_3 = arg_296_1:FormatText(var_299_2.content)

				arg_296_1.text_.text = var_299_3

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_4 = 27
				local var_299_5 = utf8.len(var_299_3)
				local var_299_6 = var_299_4 <= 0 and var_299_1 or var_299_1 * (var_299_5 / var_299_4)

				if var_299_6 > 0 and var_299_1 < var_299_6 then
					arg_296_1.talkMaxDuration = var_299_6

					if var_299_6 + var_299_0 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_6 + var_299_0
					end
				end

				arg_296_1.text_.text = var_299_3
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)
				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_7 = math.max(var_299_1, arg_296_1.talkMaxDuration)

			if var_299_0 <= arg_296_1.time_ and arg_296_1.time_ < var_299_0 + var_299_7 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_0) / var_299_7

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_0 + var_299_7 and arg_296_1.time_ < var_299_0 + var_299_7 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play116061073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 116061073
		arg_300_1.duration_ = 5

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play116061074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			local var_303_0 = 0
			local var_303_1 = 0.525

			if var_303_0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_0 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				local var_303_2 = arg_300_1:FormatText(StoryNameCfg[7].name)

				arg_300_1.leftNameTxt_.text = var_303_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_3 = arg_300_1:GetWordFromCfg(116061073)
				local var_303_4 = arg_300_1:FormatText(var_303_3.content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_5 = 21
				local var_303_6 = utf8.len(var_303_4)
				local var_303_7 = var_303_5 <= 0 and var_303_1 or var_303_1 * (var_303_6 / var_303_5)

				if var_303_7 > 0 and var_303_1 < var_303_7 then
					arg_300_1.talkMaxDuration = var_303_7

					if var_303_7 + var_303_0 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_0
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)
				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_8 = math.max(var_303_1, arg_300_1.talkMaxDuration)

			if var_303_0 <= arg_300_1.time_ and arg_300_1.time_ < var_303_0 + var_303_8 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_0) / var_303_8

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_0 + var_303_8 and arg_300_1.time_ < var_303_0 + var_303_8 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play116061074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 116061074
		arg_304_1.duration_ = 4.93

		local var_304_0 = {
			zh = 4.933,
			ja = 3.133
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
				arg_304_0:Play116061075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = arg_304_1.actors_["10025ui_story"].transform
			local var_307_1 = 0

			if var_307_1 < arg_304_1.time_ and arg_304_1.time_ <= var_307_1 + arg_307_0 then
				arg_304_1.var_.moveOldPos10025ui_story = var_307_0.localPosition
			end

			local var_307_2 = 0.001

			if var_307_1 <= arg_304_1.time_ and arg_304_1.time_ < var_307_1 + var_307_2 then
				local var_307_3 = (arg_304_1.time_ - var_307_1) / var_307_2
				local var_307_4 = Vector3.New(0, -1.1, -5.9)

				var_307_0.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos10025ui_story, var_307_4, var_307_3)

				local var_307_5 = manager.ui.mainCamera.transform.position - var_307_0.position

				var_307_0.forward = Vector3.New(var_307_5.x, var_307_5.y, var_307_5.z)

				local var_307_6 = var_307_0.localEulerAngles

				var_307_6.z = 0
				var_307_6.x = 0
				var_307_0.localEulerAngles = var_307_6
			end

			if arg_304_1.time_ >= var_307_1 + var_307_2 and arg_304_1.time_ < var_307_1 + var_307_2 + arg_307_0 then
				var_307_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_307_7 = manager.ui.mainCamera.transform.position - var_307_0.position

				var_307_0.forward = Vector3.New(var_307_7.x, var_307_7.y, var_307_7.z)

				local var_307_8 = var_307_0.localEulerAngles

				var_307_8.z = 0
				var_307_8.x = 0
				var_307_0.localEulerAngles = var_307_8
			end

			local var_307_9 = 0

			if var_307_9 < arg_304_1.time_ and arg_304_1.time_ <= var_307_9 + arg_307_0 then
				arg_304_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			local var_307_10 = 0

			if var_307_10 < arg_304_1.time_ and arg_304_1.time_ <= var_307_10 + arg_307_0 then
				arg_304_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_307_11 = arg_304_1.actors_["10025ui_story"]
			local var_307_12 = 0

			if var_307_12 < arg_304_1.time_ and arg_304_1.time_ <= var_307_12 + arg_307_0 and not isNil(var_307_11) and arg_304_1.var_.characterEffect10025ui_story == nil then
				arg_304_1.var_.characterEffect10025ui_story = var_307_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_13 = 0.2

			if var_307_12 <= arg_304_1.time_ and arg_304_1.time_ < var_307_12 + var_307_13 and not isNil(var_307_11) then
				local var_307_14 = (arg_304_1.time_ - var_307_12) / var_307_13

				if arg_304_1.var_.characterEffect10025ui_story and not isNil(var_307_11) then
					arg_304_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= var_307_12 + var_307_13 and arg_304_1.time_ < var_307_12 + var_307_13 + arg_307_0 and not isNil(var_307_11) and arg_304_1.var_.characterEffect10025ui_story then
				arg_304_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_307_15 = 0
			local var_307_16 = 0.275

			if var_307_15 < arg_304_1.time_ and arg_304_1.time_ <= var_307_15 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				local var_307_17 = arg_304_1:FormatText(StoryNameCfg[328].name)

				arg_304_1.leftNameTxt_.text = var_307_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_18 = arg_304_1:GetWordFromCfg(116061074)
				local var_307_19 = arg_304_1:FormatText(var_307_18.content)

				arg_304_1.text_.text = var_307_19

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_20 = 11
				local var_307_21 = utf8.len(var_307_19)
				local var_307_22 = var_307_20 <= 0 and var_307_16 or var_307_16 * (var_307_21 / var_307_20)

				if var_307_22 > 0 and var_307_16 < var_307_22 then
					arg_304_1.talkMaxDuration = var_307_22

					if var_307_22 + var_307_15 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_22 + var_307_15
					end
				end

				arg_304_1.text_.text = var_307_19
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061074", "story_v_out_116061.awb") ~= 0 then
					local var_307_23 = manager.audio:GetVoiceLength("story_v_out_116061", "116061074", "story_v_out_116061.awb") / 1000

					if var_307_23 + var_307_15 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_23 + var_307_15
					end

					if var_307_18.prefab_name ~= "" and arg_304_1.actors_[var_307_18.prefab_name] ~= nil then
						local var_307_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_18.prefab_name].transform, "story_v_out_116061", "116061074", "story_v_out_116061.awb")

						arg_304_1:RecordAudio("116061074", var_307_24)
						arg_304_1:RecordAudio("116061074", var_307_24)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_116061", "116061074", "story_v_out_116061.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_116061", "116061074", "story_v_out_116061.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_25 = math.max(var_307_16, arg_304_1.talkMaxDuration)

			if var_307_15 <= arg_304_1.time_ and arg_304_1.time_ < var_307_15 + var_307_25 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_15) / var_307_25

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_15 + var_307_25 and arg_304_1.time_ < var_307_15 + var_307_25 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play116061075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 116061075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play116061076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			local var_311_0 = arg_308_1.actors_["10025ui_story"]
			local var_311_1 = 0

			if var_311_1 < arg_308_1.time_ and arg_308_1.time_ <= var_311_1 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect10025ui_story == nil then
				arg_308_1.var_.characterEffect10025ui_story = var_311_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_2 = 0.2

			if var_311_1 <= arg_308_1.time_ and arg_308_1.time_ < var_311_1 + var_311_2 and not isNil(var_311_0) then
				local var_311_3 = (arg_308_1.time_ - var_311_1) / var_311_2

				if arg_308_1.var_.characterEffect10025ui_story and not isNil(var_311_0) then
					local var_311_4 = Mathf.Lerp(0, 0.5, var_311_3)

					arg_308_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_308_1.var_.characterEffect10025ui_story.fillRatio = var_311_4
				end
			end

			if arg_308_1.time_ >= var_311_1 + var_311_2 and arg_308_1.time_ < var_311_1 + var_311_2 + arg_311_0 and not isNil(var_311_0) and arg_308_1.var_.characterEffect10025ui_story then
				local var_311_5 = 0.5

				arg_308_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_308_1.var_.characterEffect10025ui_story.fillRatio = var_311_5
			end

			local var_311_6 = 0
			local var_311_7 = 0.9

			if var_311_6 < arg_308_1.time_ and arg_308_1.time_ <= var_311_6 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_8 = arg_308_1:GetWordFromCfg(116061075)
				local var_311_9 = arg_308_1:FormatText(var_311_8.content)

				arg_308_1.text_.text = var_311_9

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_10 = 36
				local var_311_11 = utf8.len(var_311_9)
				local var_311_12 = var_311_10 <= 0 and var_311_7 or var_311_7 * (var_311_11 / var_311_10)

				if var_311_12 > 0 and var_311_7 < var_311_12 then
					arg_308_1.talkMaxDuration = var_311_12

					if var_311_12 + var_311_6 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_12 + var_311_6
					end
				end

				arg_308_1.text_.text = var_311_9
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_13 = math.max(var_311_7, arg_308_1.talkMaxDuration)

			if var_311_6 <= arg_308_1.time_ and arg_308_1.time_ < var_311_6 + var_311_13 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_6) / var_311_13

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_6 + var_311_13 and arg_308_1.time_ < var_311_6 + var_311_13 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {}

		arg_308_1:InitPlayNodeList()
	end,
	Play116061076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 116061076
		arg_312_1.duration_ = 5

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play116061077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			local var_315_0 = 0
			local var_315_1 = 0.775

			if var_315_0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_0 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				local var_315_2 = arg_312_1:FormatText(StoryNameCfg[7].name)

				arg_312_1.leftNameTxt_.text = var_315_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, true)
				arg_312_1.iconController_:SetSelectedState("hero")

				arg_312_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_312_1.callingController_:SetSelectedState("normal")

				arg_312_1.keyicon_.color = Color.New(1, 1, 1)
				arg_312_1.icon_.color = Color.New(1, 1, 1)

				local var_315_3 = arg_312_1:GetWordFromCfg(116061076)
				local var_315_4 = arg_312_1:FormatText(var_315_3.content)

				arg_312_1.text_.text = var_315_4

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_5 = 31
				local var_315_6 = utf8.len(var_315_4)
				local var_315_7 = var_315_5 <= 0 and var_315_1 or var_315_1 * (var_315_6 / var_315_5)

				if var_315_7 > 0 and var_315_1 < var_315_7 then
					arg_312_1.talkMaxDuration = var_315_7

					if var_315_7 + var_315_0 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_7 + var_315_0
					end
				end

				arg_312_1.text_.text = var_315_4
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)
				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_8 = math.max(var_315_1, arg_312_1.talkMaxDuration)

			if var_315_0 <= arg_312_1.time_ and arg_312_1.time_ < var_315_0 + var_315_8 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_0) / var_315_8

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_0 + var_315_8 and arg_312_1.time_ < var_315_0 + var_315_8 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {}

		arg_312_1:InitPlayNodeList()
	end,
	Play116061077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 116061077
		arg_316_1.duration_ = 5.47

		local var_316_0 = {
			zh = 5.466,
			ja = 5
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
				arg_316_0:Play116061078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0

			if var_319_0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_0 + arg_319_0 then
				arg_316_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025actionlink/10025action448")
			end

			local var_319_1 = 0

			if var_319_1 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_319_2 = arg_316_1.actors_["10025ui_story"]
			local var_319_3 = 0

			if var_319_3 < arg_316_1.time_ and arg_316_1.time_ <= var_319_3 + arg_319_0 and not isNil(var_319_2) and arg_316_1.var_.characterEffect10025ui_story == nil then
				arg_316_1.var_.characterEffect10025ui_story = var_319_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_4 = 0.2

			if var_319_3 <= arg_316_1.time_ and arg_316_1.time_ < var_319_3 + var_319_4 and not isNil(var_319_2) then
				local var_319_5 = (arg_316_1.time_ - var_319_3) / var_319_4

				if arg_316_1.var_.characterEffect10025ui_story and not isNil(var_319_2) then
					arg_316_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_316_1.time_ >= var_319_3 + var_319_4 and arg_316_1.time_ < var_319_3 + var_319_4 + arg_319_0 and not isNil(var_319_2) and arg_316_1.var_.characterEffect10025ui_story then
				arg_316_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_319_6 = 0
			local var_319_7 = 0.325

			if var_319_6 < arg_316_1.time_ and arg_316_1.time_ <= var_319_6 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				local var_319_8 = arg_316_1:FormatText(StoryNameCfg[328].name)

				arg_316_1.leftNameTxt_.text = var_319_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_9 = arg_316_1:GetWordFromCfg(116061077)
				local var_319_10 = arg_316_1:FormatText(var_319_9.content)

				arg_316_1.text_.text = var_319_10

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_11 = 13
				local var_319_12 = utf8.len(var_319_10)
				local var_319_13 = var_319_11 <= 0 and var_319_7 or var_319_7 * (var_319_12 / var_319_11)

				if var_319_13 > 0 and var_319_7 < var_319_13 then
					arg_316_1.talkMaxDuration = var_319_13

					if var_319_13 + var_319_6 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_13 + var_319_6
					end
				end

				arg_316_1.text_.text = var_319_10
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061077", "story_v_out_116061.awb") ~= 0 then
					local var_319_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061077", "story_v_out_116061.awb") / 1000

					if var_319_14 + var_319_6 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_14 + var_319_6
					end

					if var_319_9.prefab_name ~= "" and arg_316_1.actors_[var_319_9.prefab_name] ~= nil then
						local var_319_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_9.prefab_name].transform, "story_v_out_116061", "116061077", "story_v_out_116061.awb")

						arg_316_1:RecordAudio("116061077", var_319_15)
						arg_316_1:RecordAudio("116061077", var_319_15)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_116061", "116061077", "story_v_out_116061.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_116061", "116061077", "story_v_out_116061.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_16 = math.max(var_319_7, arg_316_1.talkMaxDuration)

			if var_319_6 <= arg_316_1.time_ and arg_316_1.time_ < var_319_6 + var_319_16 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_6) / var_319_16

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_6 + var_319_16 and arg_316_1.time_ < var_319_6 + var_319_16 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play116061078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 116061078
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play116061079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			local var_323_0 = arg_320_1.actors_["10025ui_story"]
			local var_323_1 = 0

			if var_323_1 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect10025ui_story == nil then
				arg_320_1.var_.characterEffect10025ui_story = var_323_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_2 = 0.2

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_2 and not isNil(var_323_0) then
				local var_323_3 = (arg_320_1.time_ - var_323_1) / var_323_2

				if arg_320_1.var_.characterEffect10025ui_story and not isNil(var_323_0) then
					local var_323_4 = Mathf.Lerp(0, 0.5, var_323_3)

					arg_320_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_320_1.var_.characterEffect10025ui_story.fillRatio = var_323_4
				end
			end

			if arg_320_1.time_ >= var_323_1 + var_323_2 and arg_320_1.time_ < var_323_1 + var_323_2 + arg_323_0 and not isNil(var_323_0) and arg_320_1.var_.characterEffect10025ui_story then
				local var_323_5 = 0.5

				arg_320_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_320_1.var_.characterEffect10025ui_story.fillRatio = var_323_5
			end

			local var_323_6 = 0
			local var_323_7 = 0.3

			if var_323_6 < arg_320_1.time_ and arg_320_1.time_ <= var_323_6 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				local var_323_8 = arg_320_1:FormatText(StoryNameCfg[7].name)

				arg_320_1.leftNameTxt_.text = var_323_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_9 = arg_320_1:GetWordFromCfg(116061078)
				local var_323_10 = arg_320_1:FormatText(var_323_9.content)

				arg_320_1.text_.text = var_323_10

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_11 = 12
				local var_323_12 = utf8.len(var_323_10)
				local var_323_13 = var_323_11 <= 0 and var_323_7 or var_323_7 * (var_323_12 / var_323_11)

				if var_323_13 > 0 and var_323_7 < var_323_13 then
					arg_320_1.talkMaxDuration = var_323_13

					if var_323_13 + var_323_6 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_13 + var_323_6
					end
				end

				arg_320_1.text_.text = var_323_10
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_14 = math.max(var_323_7, arg_320_1.talkMaxDuration)

			if var_323_6 <= arg_320_1.time_ and arg_320_1.time_ < var_323_6 + var_323_14 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_6) / var_323_14

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_6 + var_323_14 and arg_320_1.time_ < var_323_6 + var_323_14 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play116061079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 116061079
		arg_324_1.duration_ = 2.97

		local var_324_0 = {
			zh = 2.966,
			ja = 2.6
		}
		local var_324_1 = manager.audio:GetLocalizationFlag()

		if var_324_0[var_324_1] ~= nil then
			arg_324_1.duration_ = var_324_0[var_324_1]
		end

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play116061080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 0

			if var_327_0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_0 + arg_327_0 then
				arg_324_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_327_1 = 0

			if var_327_1 < arg_324_1.time_ and arg_324_1.time_ <= var_327_1 + arg_327_0 then
				arg_324_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_327_2 = arg_324_1.actors_["10025ui_story"]
			local var_327_3 = 0

			if var_327_3 < arg_324_1.time_ and arg_324_1.time_ <= var_327_3 + arg_327_0 and not isNil(var_327_2) and arg_324_1.var_.characterEffect10025ui_story == nil then
				arg_324_1.var_.characterEffect10025ui_story = var_327_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_4 = 0.2

			if var_327_3 <= arg_324_1.time_ and arg_324_1.time_ < var_327_3 + var_327_4 and not isNil(var_327_2) then
				local var_327_5 = (arg_324_1.time_ - var_327_3) / var_327_4

				if arg_324_1.var_.characterEffect10025ui_story and not isNil(var_327_2) then
					arg_324_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= var_327_3 + var_327_4 and arg_324_1.time_ < var_327_3 + var_327_4 + arg_327_0 and not isNil(var_327_2) and arg_324_1.var_.characterEffect10025ui_story then
				arg_324_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_327_6 = 0
			local var_327_7 = 0.25

			if var_327_6 < arg_324_1.time_ and arg_324_1.time_ <= var_327_6 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				local var_327_8 = arg_324_1:FormatText(StoryNameCfg[328].name)

				arg_324_1.leftNameTxt_.text = var_327_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_9 = arg_324_1:GetWordFromCfg(116061079)
				local var_327_10 = arg_324_1:FormatText(var_327_9.content)

				arg_324_1.text_.text = var_327_10

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_11 = 10
				local var_327_12 = utf8.len(var_327_10)
				local var_327_13 = var_327_11 <= 0 and var_327_7 or var_327_7 * (var_327_12 / var_327_11)

				if var_327_13 > 0 and var_327_7 < var_327_13 then
					arg_324_1.talkMaxDuration = var_327_13

					if var_327_13 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_13 + var_327_6
					end
				end

				arg_324_1.text_.text = var_327_10
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061079", "story_v_out_116061.awb") ~= 0 then
					local var_327_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061079", "story_v_out_116061.awb") / 1000

					if var_327_14 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_14 + var_327_6
					end

					if var_327_9.prefab_name ~= "" and arg_324_1.actors_[var_327_9.prefab_name] ~= nil then
						local var_327_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_9.prefab_name].transform, "story_v_out_116061", "116061079", "story_v_out_116061.awb")

						arg_324_1:RecordAudio("116061079", var_327_15)
						arg_324_1:RecordAudio("116061079", var_327_15)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_116061", "116061079", "story_v_out_116061.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_116061", "116061079", "story_v_out_116061.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_16 = math.max(var_327_7, arg_324_1.talkMaxDuration)

			if var_327_6 <= arg_324_1.time_ and arg_324_1.time_ < var_327_6 + var_327_16 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_6) / var_327_16

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_6 + var_327_16 and arg_324_1.time_ < var_327_6 + var_327_16 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play116061080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 116061080
		arg_328_1.duration_ = 5

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play116061081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			local var_331_0 = arg_328_1.actors_["10025ui_story"]
			local var_331_1 = 0

			if var_331_1 < arg_328_1.time_ and arg_328_1.time_ <= var_331_1 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect10025ui_story == nil then
				arg_328_1.var_.characterEffect10025ui_story = var_331_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_2 = 0.2

			if var_331_1 <= arg_328_1.time_ and arg_328_1.time_ < var_331_1 + var_331_2 and not isNil(var_331_0) then
				local var_331_3 = (arg_328_1.time_ - var_331_1) / var_331_2

				if arg_328_1.var_.characterEffect10025ui_story and not isNil(var_331_0) then
					local var_331_4 = Mathf.Lerp(0, 0.5, var_331_3)

					arg_328_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_328_1.var_.characterEffect10025ui_story.fillRatio = var_331_4
				end
			end

			if arg_328_1.time_ >= var_331_1 + var_331_2 and arg_328_1.time_ < var_331_1 + var_331_2 + arg_331_0 and not isNil(var_331_0) and arg_328_1.var_.characterEffect10025ui_story then
				local var_331_5 = 0.5

				arg_328_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_328_1.var_.characterEffect10025ui_story.fillRatio = var_331_5
			end

			local var_331_6 = 0
			local var_331_7 = 0.575

			if var_331_6 < arg_328_1.time_ and arg_328_1.time_ <= var_331_6 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				local var_331_8 = arg_328_1:FormatText(StoryNameCfg[7].name)

				arg_328_1.leftNameTxt_.text = var_331_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_9 = arg_328_1:GetWordFromCfg(116061080)
				local var_331_10 = arg_328_1:FormatText(var_331_9.content)

				arg_328_1.text_.text = var_331_10

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_11 = 23
				local var_331_12 = utf8.len(var_331_10)
				local var_331_13 = var_331_11 <= 0 and var_331_7 or var_331_7 * (var_331_12 / var_331_11)

				if var_331_13 > 0 and var_331_7 < var_331_13 then
					arg_328_1.talkMaxDuration = var_331_13

					if var_331_13 + var_331_6 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_13 + var_331_6
					end
				end

				arg_328_1.text_.text = var_331_10
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)
				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_14 = math.max(var_331_7, arg_328_1.talkMaxDuration)

			if var_331_6 <= arg_328_1.time_ and arg_328_1.time_ < var_331_6 + var_331_14 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_6) / var_331_14

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_6 + var_331_14 and arg_328_1.time_ < var_331_6 + var_331_14 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {}

		arg_328_1:InitPlayNodeList()
	end,
	Play116061081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 116061081
		arg_332_1.duration_ = 9

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play116061082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			local var_335_0 = arg_332_1.actors_["10025ui_story"].transform
			local var_335_1 = 1.98333333333333

			if var_335_1 < arg_332_1.time_ and arg_332_1.time_ <= var_335_1 + arg_335_0 then
				arg_332_1.var_.moveOldPos10025ui_story = var_335_0.localPosition
			end

			local var_335_2 = 0.001

			if var_335_1 <= arg_332_1.time_ and arg_332_1.time_ < var_335_1 + var_335_2 then
				local var_335_3 = (arg_332_1.time_ - var_335_1) / var_335_2
				local var_335_4 = Vector3.New(0, 100, 0)

				var_335_0.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10025ui_story, var_335_4, var_335_3)

				local var_335_5 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_5.x, var_335_5.y, var_335_5.z)

				local var_335_6 = var_335_0.localEulerAngles

				var_335_6.z = 0
				var_335_6.x = 0
				var_335_0.localEulerAngles = var_335_6
			end

			if arg_332_1.time_ >= var_335_1 + var_335_2 and arg_332_1.time_ < var_335_1 + var_335_2 + arg_335_0 then
				var_335_0.localPosition = Vector3.New(0, 100, 0)

				local var_335_7 = manager.ui.mainCamera.transform.position - var_335_0.position

				var_335_0.forward = Vector3.New(var_335_7.x, var_335_7.y, var_335_7.z)

				local var_335_8 = var_335_0.localEulerAngles

				var_335_8.z = 0
				var_335_8.x = 0
				var_335_0.localEulerAngles = var_335_8
			end

			local var_335_9 = 0

			if var_335_9 < arg_332_1.time_ and arg_332_1.time_ <= var_335_9 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_10 = 2

			if var_335_9 <= arg_332_1.time_ and arg_332_1.time_ < var_335_9 + var_335_10 then
				local var_335_11 = (arg_332_1.time_ - var_335_9) / var_335_10
				local var_335_12 = Color.New(0, 0, 0)

				var_335_12.a = Mathf.Lerp(0, 1, var_335_11)
				arg_332_1.mask_.color = var_335_12
			end

			if arg_332_1.time_ >= var_335_9 + var_335_10 and arg_332_1.time_ < var_335_9 + var_335_10 + arg_335_0 then
				local var_335_13 = Color.New(0, 0, 0)

				var_335_13.a = 1
				arg_332_1.mask_.color = var_335_13
			end

			local var_335_14 = 2

			if var_335_14 < arg_332_1.time_ and arg_332_1.time_ <= var_335_14 + arg_335_0 then
				arg_332_1.mask_.enabled = true
				arg_332_1.mask_.raycastTarget = true

				arg_332_1:SetGaussion(false)
			end

			local var_335_15 = 2

			if var_335_14 <= arg_332_1.time_ and arg_332_1.time_ < var_335_14 + var_335_15 then
				local var_335_16 = (arg_332_1.time_ - var_335_14) / var_335_15
				local var_335_17 = Color.New(0, 0, 0)

				var_335_17.a = Mathf.Lerp(1, 0, var_335_16)
				arg_332_1.mask_.color = var_335_17
			end

			if arg_332_1.time_ >= var_335_14 + var_335_15 and arg_332_1.time_ < var_335_14 + var_335_15 + arg_335_0 then
				local var_335_18 = Color.New(0, 0, 0)
				local var_335_19 = 0

				arg_332_1.mask_.enabled = false
				var_335_18.a = var_335_19
				arg_332_1.mask_.color = var_335_18
			end

			if arg_332_1.frameCnt_ <= 1 then
				arg_332_1.dialog_:SetActive(false)
			end

			local var_335_20 = 4
			local var_335_21 = 0.65

			if var_335_20 < arg_332_1.time_ and arg_332_1.time_ <= var_335_20 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0

				arg_332_1.dialog_:SetActive(true)

				arg_332_1.dialogCg_.alpha = 0

				local var_335_22 = LeanTween.value(arg_332_1.dialog_, 0, 1, 0.3)

				var_335_22:setOnUpdate(LuaHelper.FloatAction(function(arg_336_0)
					arg_332_1.dialogCg_.alpha = arg_336_0
				end))
				var_335_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_332_1.dialog_)
					var_335_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_332_1.duration_ = arg_332_1.duration_ + 0.3

				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_23 = arg_332_1:GetWordFromCfg(116061081)
				local var_335_24 = arg_332_1:FormatText(var_335_23.content)

				arg_332_1.text_.text = var_335_24

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_25 = 26
				local var_335_26 = utf8.len(var_335_24)
				local var_335_27 = var_335_25 <= 0 and var_335_21 or var_335_21 * (var_335_26 / var_335_25)

				if var_335_27 > 0 and var_335_21 < var_335_27 then
					arg_332_1.talkMaxDuration = var_335_27
					var_335_20 = var_335_20 + 0.3

					if var_335_27 + var_335_20 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_27 + var_335_20
					end
				end

				arg_332_1.text_.text = var_335_24
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_28 = var_335_20 + 0.3
			local var_335_29 = math.max(var_335_21, arg_332_1.talkMaxDuration)

			if var_335_28 <= arg_332_1.time_ and arg_332_1.time_ < var_335_28 + var_335_29 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_28) / var_335_29

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_28 + var_335_29 and arg_332_1.time_ < var_335_28 + var_335_29 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play116061082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 116061082
		arg_338_1.duration_ = 5.7

		local var_338_0 = {
			zh = 5.2,
			ja = 5.7
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
				arg_338_0:Play116061083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			local var_341_0 = arg_338_1.actors_["1084ui_story"].transform
			local var_341_1 = 0

			if var_341_1 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1.var_.moveOldPos1084ui_story = var_341_0.localPosition
			end

			local var_341_2 = 0.001

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_2 then
				local var_341_3 = (arg_338_1.time_ - var_341_1) / var_341_2
				local var_341_4 = Vector3.New(0, -0.97, -6)

				var_341_0.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1084ui_story, var_341_4, var_341_3)

				local var_341_5 = manager.ui.mainCamera.transform.position - var_341_0.position

				var_341_0.forward = Vector3.New(var_341_5.x, var_341_5.y, var_341_5.z)

				local var_341_6 = var_341_0.localEulerAngles

				var_341_6.z = 0
				var_341_6.x = 0
				var_341_0.localEulerAngles = var_341_6
			end

			if arg_338_1.time_ >= var_341_1 + var_341_2 and arg_338_1.time_ < var_341_1 + var_341_2 + arg_341_0 then
				var_341_0.localPosition = Vector3.New(0, -0.97, -6)

				local var_341_7 = manager.ui.mainCamera.transform.position - var_341_0.position

				var_341_0.forward = Vector3.New(var_341_7.x, var_341_7.y, var_341_7.z)

				local var_341_8 = var_341_0.localEulerAngles

				var_341_8.z = 0
				var_341_8.x = 0
				var_341_0.localEulerAngles = var_341_8
			end

			local var_341_9 = 0

			if var_341_9 < arg_338_1.time_ and arg_338_1.time_ <= var_341_9 + arg_341_0 then
				arg_338_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_341_10 = 0

			if var_341_10 < arg_338_1.time_ and arg_338_1.time_ <= var_341_10 + arg_341_0 then
				arg_338_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_341_11 = arg_338_1.actors_["1084ui_story"]
			local var_341_12 = 0

			if var_341_12 < arg_338_1.time_ and arg_338_1.time_ <= var_341_12 + arg_341_0 and not isNil(var_341_11) and arg_338_1.var_.characterEffect1084ui_story == nil then
				arg_338_1.var_.characterEffect1084ui_story = var_341_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_13 = 0.2

			if var_341_12 <= arg_338_1.time_ and arg_338_1.time_ < var_341_12 + var_341_13 and not isNil(var_341_11) then
				local var_341_14 = (arg_338_1.time_ - var_341_12) / var_341_13

				if arg_338_1.var_.characterEffect1084ui_story and not isNil(var_341_11) then
					arg_338_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_338_1.time_ >= var_341_12 + var_341_13 and arg_338_1.time_ < var_341_12 + var_341_13 + arg_341_0 and not isNil(var_341_11) and arg_338_1.var_.characterEffect1084ui_story then
				arg_338_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_341_15 = 0
			local var_341_16 = 0.425

			if var_341_15 < arg_338_1.time_ and arg_338_1.time_ <= var_341_15 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				local var_341_17 = arg_338_1:FormatText(StoryNameCfg[6].name)

				arg_338_1.leftNameTxt_.text = var_341_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_18 = arg_338_1:GetWordFromCfg(116061082)
				local var_341_19 = arg_338_1:FormatText(var_341_18.content)

				arg_338_1.text_.text = var_341_19

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_20 = 17
				local var_341_21 = utf8.len(var_341_19)
				local var_341_22 = var_341_20 <= 0 and var_341_16 or var_341_16 * (var_341_21 / var_341_20)

				if var_341_22 > 0 and var_341_16 < var_341_22 then
					arg_338_1.talkMaxDuration = var_341_22

					if var_341_22 + var_341_15 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_22 + var_341_15
					end
				end

				arg_338_1.text_.text = var_341_19
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061082", "story_v_out_116061.awb") ~= 0 then
					local var_341_23 = manager.audio:GetVoiceLength("story_v_out_116061", "116061082", "story_v_out_116061.awb") / 1000

					if var_341_23 + var_341_15 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_23 + var_341_15
					end

					if var_341_18.prefab_name ~= "" and arg_338_1.actors_[var_341_18.prefab_name] ~= nil then
						local var_341_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_18.prefab_name].transform, "story_v_out_116061", "116061082", "story_v_out_116061.awb")

						arg_338_1:RecordAudio("116061082", var_341_24)
						arg_338_1:RecordAudio("116061082", var_341_24)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_116061", "116061082", "story_v_out_116061.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_116061", "116061082", "story_v_out_116061.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_25 = math.max(var_341_16, arg_338_1.talkMaxDuration)

			if var_341_15 <= arg_338_1.time_ and arg_338_1.time_ < var_341_15 + var_341_25 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_15) / var_341_25

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_15 + var_341_25 and arg_338_1.time_ < var_341_15 + var_341_25 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play116061083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 116061083
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play116061084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = arg_342_1.actors_["1084ui_story"].transform
			local var_345_1 = 0

			if var_345_1 < arg_342_1.time_ and arg_342_1.time_ <= var_345_1 + arg_345_0 then
				arg_342_1.var_.moveOldPos1084ui_story = var_345_0.localPosition
			end

			local var_345_2 = 0.001

			if var_345_1 <= arg_342_1.time_ and arg_342_1.time_ < var_345_1 + var_345_2 then
				local var_345_3 = (arg_342_1.time_ - var_345_1) / var_345_2
				local var_345_4 = Vector3.New(0, 100, 0)

				var_345_0.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos1084ui_story, var_345_4, var_345_3)

				local var_345_5 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_5.x, var_345_5.y, var_345_5.z)

				local var_345_6 = var_345_0.localEulerAngles

				var_345_6.z = 0
				var_345_6.x = 0
				var_345_0.localEulerAngles = var_345_6
			end

			if arg_342_1.time_ >= var_345_1 + var_345_2 and arg_342_1.time_ < var_345_1 + var_345_2 + arg_345_0 then
				var_345_0.localPosition = Vector3.New(0, 100, 0)

				local var_345_7 = manager.ui.mainCamera.transform.position - var_345_0.position

				var_345_0.forward = Vector3.New(var_345_7.x, var_345_7.y, var_345_7.z)

				local var_345_8 = var_345_0.localEulerAngles

				var_345_8.z = 0
				var_345_8.x = 0
				var_345_0.localEulerAngles = var_345_8
			end

			local var_345_9 = 0
			local var_345_10 = 0.75

			if var_345_9 < arg_342_1.time_ and arg_342_1.time_ <= var_345_9 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				local var_345_11 = arg_342_1:FormatText(StoryNameCfg[7].name)

				arg_342_1.leftNameTxt_.text = var_345_11

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_12 = arg_342_1:GetWordFromCfg(116061083)
				local var_345_13 = arg_342_1:FormatText(var_345_12.content)

				arg_342_1.text_.text = var_345_13

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_14 = 30
				local var_345_15 = utf8.len(var_345_13)
				local var_345_16 = var_345_14 <= 0 and var_345_10 or var_345_10 * (var_345_15 / var_345_14)

				if var_345_16 > 0 and var_345_10 < var_345_16 then
					arg_342_1.talkMaxDuration = var_345_16

					if var_345_16 + var_345_9 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_16 + var_345_9
					end
				end

				arg_342_1.text_.text = var_345_13
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_17 = math.max(var_345_10, arg_342_1.talkMaxDuration)

			if var_345_9 <= arg_342_1.time_ and arg_342_1.time_ < var_345_9 + var_345_17 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_9) / var_345_17

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_9 + var_345_17 and arg_342_1.time_ < var_345_9 + var_345_17 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play116061084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 116061084
		arg_346_1.duration_ = 5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play116061085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_0 = 0
			local var_349_1 = 1.15

			if var_349_0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_0 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, false)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_2 = arg_346_1:GetWordFromCfg(116061084)
				local var_349_3 = arg_346_1:FormatText(var_349_2.content)

				arg_346_1.text_.text = var_349_3

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_4 = 34
				local var_349_5 = utf8.len(var_349_3)
				local var_349_6 = var_349_4 <= 0 and var_349_1 or var_349_1 * (var_349_5 / var_349_4)

				if var_349_6 > 0 and var_349_1 < var_349_6 then
					arg_346_1.talkMaxDuration = var_349_6

					if var_349_6 + var_349_0 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_6 + var_349_0
					end
				end

				arg_346_1.text_.text = var_349_3
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)
				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_7 = math.max(var_349_1, arg_346_1.talkMaxDuration)

			if var_349_0 <= arg_346_1.time_ and arg_346_1.time_ < var_349_0 + var_349_7 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_0) / var_349_7

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_0 + var_349_7 and arg_346_1.time_ < var_349_0 + var_349_7 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {}

		arg_346_1:InitPlayNodeList()
	end,
	Play116061085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 116061085
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play116061086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			local var_353_0 = 0
			local var_353_1 = 0.4

			if var_353_0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_0 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_2 = arg_350_1:GetWordFromCfg(116061085)
				local var_353_3 = arg_350_1:FormatText(var_353_2.content)

				arg_350_1.text_.text = var_353_3

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_4 = 14
				local var_353_5 = utf8.len(var_353_3)
				local var_353_6 = var_353_4 <= 0 and var_353_1 or var_353_1 * (var_353_5 / var_353_4)

				if var_353_6 > 0 and var_353_1 < var_353_6 then
					arg_350_1.talkMaxDuration = var_353_6

					if var_353_6 + var_353_0 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_6 + var_353_0
					end
				end

				arg_350_1.text_.text = var_353_3
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_7 = math.max(var_353_1, arg_350_1.talkMaxDuration)

			if var_353_0 <= arg_350_1.time_ and arg_350_1.time_ < var_353_0 + var_353_7 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_0) / var_353_7

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_0 + var_353_7 and arg_350_1.time_ < var_353_0 + var_353_7 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play116061086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 116061086
		arg_354_1.duration_ = 9

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play116061087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 2

			if var_357_0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_0 + arg_357_0 then
				if arg_354_0.sceneSettingEffect_ then
					arg_354_1.sceneSettingEffect_.enabled = false
				end

				arg_354_1.sceneSettingGo_:SetActive(true)

				local var_357_1 = manager.ui.mainCamera.transform.localPosition
				local var_357_2 = Vector3.New(0, 0, 10) + Vector3.New(var_357_1.x, var_357_1.y, 0)
				local var_357_3 = arg_354_1.bgs_.I05d

				var_357_3.transform.localPosition = var_357_2
				var_357_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_357_4 = var_357_3:GetComponent("SpriteRenderer")

				if var_357_4 and var_357_4.sprite then
					local var_357_5 = (var_357_3.transform.localPosition - var_357_1).z
					local var_357_6 = manager.ui.mainCameraCom_
					local var_357_7 = 2 * var_357_5 * Mathf.Tan(var_357_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_357_8 = var_357_7 * var_357_6.aspect
					local var_357_9 = var_357_4.sprite.bounds.size.x
					local var_357_10 = var_357_4.sprite.bounds.size.y
					local var_357_11 = var_357_8 / var_357_9
					local var_357_12 = var_357_7 / var_357_10
					local var_357_13 = var_357_12 < var_357_11 and var_357_11 or var_357_12

					var_357_3.transform.localScale = Vector3.New(var_357_13, var_357_13, 0)
				end

				for iter_357_0, iter_357_1 in pairs(arg_354_1.bgs_) do
					if iter_357_0 ~= "I05d" then
						iter_357_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_357_14 = 0

			if var_357_14 < arg_354_1.time_ and arg_354_1.time_ <= var_357_14 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_15 = 2

			if var_357_14 <= arg_354_1.time_ and arg_354_1.time_ < var_357_14 + var_357_15 then
				local var_357_16 = (arg_354_1.time_ - var_357_14) / var_357_15
				local var_357_17 = Color.New(0, 0, 0)

				var_357_17.a = Mathf.Lerp(0, 1, var_357_16)
				arg_354_1.mask_.color = var_357_17
			end

			if arg_354_1.time_ >= var_357_14 + var_357_15 and arg_354_1.time_ < var_357_14 + var_357_15 + arg_357_0 then
				local var_357_18 = Color.New(0, 0, 0)

				var_357_18.a = 1
				arg_354_1.mask_.color = var_357_18
			end

			local var_357_19 = 2

			if var_357_19 < arg_354_1.time_ and arg_354_1.time_ <= var_357_19 + arg_357_0 then
				arg_354_1.mask_.enabled = true
				arg_354_1.mask_.raycastTarget = true

				arg_354_1:SetGaussion(false)
			end

			local var_357_20 = 2

			if var_357_19 <= arg_354_1.time_ and arg_354_1.time_ < var_357_19 + var_357_20 then
				local var_357_21 = (arg_354_1.time_ - var_357_19) / var_357_20
				local var_357_22 = Color.New(0, 0, 0)

				var_357_22.a = Mathf.Lerp(1, 0, var_357_21)
				arg_354_1.mask_.color = var_357_22
			end

			if arg_354_1.time_ >= var_357_19 + var_357_20 and arg_354_1.time_ < var_357_19 + var_357_20 + arg_357_0 then
				local var_357_23 = Color.New(0, 0, 0)
				local var_357_24 = 0

				arg_354_1.mask_.enabled = false
				var_357_23.a = var_357_24
				arg_354_1.mask_.color = var_357_23
			end

			if arg_354_1.frameCnt_ <= 1 then
				arg_354_1.dialog_:SetActive(false)
			end

			local var_357_25 = 4
			local var_357_26 = 0.3

			if var_357_25 < arg_354_1.time_ and arg_354_1.time_ <= var_357_25 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0

				arg_354_1.dialog_:SetActive(true)

				arg_354_1.dialogCg_.alpha = 0

				local var_357_27 = LeanTween.value(arg_354_1.dialog_, 0, 1, 0.3)

				var_357_27:setOnUpdate(LuaHelper.FloatAction(function(arg_358_0)
					arg_354_1.dialogCg_.alpha = arg_358_0
				end))
				var_357_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_354_1.dialog_)
					var_357_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_354_1.duration_ = arg_354_1.duration_ + 0.3

				SetActive(arg_354_1.leftNameGo_, true)

				local var_357_28 = arg_354_1:FormatText(StoryNameCfg[7].name)

				arg_354_1.leftNameTxt_.text = var_357_28

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, true)
				arg_354_1.iconController_:SetSelectedState("hero")

				arg_354_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_354_1.callingController_:SetSelectedState("normal")

				arg_354_1.keyicon_.color = Color.New(1, 1, 1)
				arg_354_1.icon_.color = Color.New(1, 1, 1)

				local var_357_29 = arg_354_1:GetWordFromCfg(116061086)
				local var_357_30 = arg_354_1:FormatText(var_357_29.content)

				arg_354_1.text_.text = var_357_30

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_31 = 12
				local var_357_32 = utf8.len(var_357_30)
				local var_357_33 = var_357_31 <= 0 and var_357_26 or var_357_26 * (var_357_32 / var_357_31)

				if var_357_33 > 0 and var_357_26 < var_357_33 then
					arg_354_1.talkMaxDuration = var_357_33
					var_357_25 = var_357_25 + 0.3

					if var_357_33 + var_357_25 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_33 + var_357_25
					end
				end

				arg_354_1.text_.text = var_357_30
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_34 = var_357_25 + 0.3
			local var_357_35 = math.max(var_357_26, arg_354_1.talkMaxDuration)

			if var_357_34 <= arg_354_1.time_ and arg_354_1.time_ < var_357_34 + var_357_35 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_34) / var_357_35

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_34 + var_357_35 and arg_354_1.time_ < var_357_34 + var_357_35 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play116061087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 116061087
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play116061088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 0
			local var_363_1 = 0.8

			if var_363_0 < arg_360_1.time_ and arg_360_1.time_ <= var_363_0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_2 = arg_360_1:GetWordFromCfg(116061087)
				local var_363_3 = arg_360_1:FormatText(var_363_2.content)

				arg_360_1.text_.text = var_363_3

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_4 = 32
				local var_363_5 = utf8.len(var_363_3)
				local var_363_6 = var_363_4 <= 0 and var_363_1 or var_363_1 * (var_363_5 / var_363_4)

				if var_363_6 > 0 and var_363_1 < var_363_6 then
					arg_360_1.talkMaxDuration = var_363_6

					if var_363_6 + var_363_0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_6 + var_363_0
					end
				end

				arg_360_1.text_.text = var_363_3
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_7 = math.max(var_363_1, arg_360_1.talkMaxDuration)

			if var_363_0 <= arg_360_1.time_ and arg_360_1.time_ < var_363_0 + var_363_7 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - var_363_0) / var_363_7

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= var_363_0 + var_363_7 and arg_360_1.time_ < var_363_0 + var_363_7 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play116061088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 116061088
		arg_364_1.duration_ = 5

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play116061089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 0
			local var_367_1 = 0.525

			if var_367_0 < arg_364_1.time_ and arg_364_1.time_ <= var_367_0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, false)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_2 = arg_364_1:GetWordFromCfg(116061088)
				local var_367_3 = arg_364_1:FormatText(var_367_2.content)

				arg_364_1.text_.text = var_367_3

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_4 = 21
				local var_367_5 = utf8.len(var_367_3)
				local var_367_6 = var_367_4 <= 0 and var_367_1 or var_367_1 * (var_367_5 / var_367_4)

				if var_367_6 > 0 and var_367_1 < var_367_6 then
					arg_364_1.talkMaxDuration = var_367_6

					if var_367_6 + var_367_0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_6 + var_367_0
					end
				end

				arg_364_1.text_.text = var_367_3
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)
				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_7 = math.max(var_367_1, arg_364_1.talkMaxDuration)

			if var_367_0 <= arg_364_1.time_ and arg_364_1.time_ < var_367_0 + var_367_7 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - var_367_0) / var_367_7

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= var_367_0 + var_367_7 and arg_364_1.time_ < var_367_0 + var_367_7 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play116061089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 116061089
		arg_368_1.duration_ = 5

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play116061090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 0
			local var_371_1 = 0.375

			if var_371_0 < arg_368_1.time_ and arg_368_1.time_ <= var_371_0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, false)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_2 = arg_368_1:GetWordFromCfg(116061089)
				local var_371_3 = arg_368_1:FormatText(var_371_2.content)

				arg_368_1.text_.text = var_371_3

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_4 = 15
				local var_371_5 = utf8.len(var_371_3)
				local var_371_6 = var_371_4 <= 0 and var_371_1 or var_371_1 * (var_371_5 / var_371_4)

				if var_371_6 > 0 and var_371_1 < var_371_6 then
					arg_368_1.talkMaxDuration = var_371_6

					if var_371_6 + var_371_0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_6 + var_371_0
					end
				end

				arg_368_1.text_.text = var_371_3
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)
				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_1, arg_368_1.talkMaxDuration)

			if var_371_0 <= arg_368_1.time_ and arg_368_1.time_ < var_371_0 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - var_371_0) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= var_371_0 + var_371_7 and arg_368_1.time_ < var_371_0 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play116061090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 116061090
		arg_372_1.duration_ = 2.73

		local var_372_0 = {
			zh = 1.999999999999,
			ja = 2.733
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play116061091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = arg_372_1.actors_["10025ui_story"].transform
			local var_375_1 = 0

			if var_375_1 < arg_372_1.time_ and arg_372_1.time_ <= var_375_1 + arg_375_0 then
				arg_372_1.var_.moveOldPos10025ui_story = var_375_0.localPosition
			end

			local var_375_2 = 0.001

			if var_375_1 <= arg_372_1.time_ and arg_372_1.time_ < var_375_1 + var_375_2 then
				local var_375_3 = (arg_372_1.time_ - var_375_1) / var_375_2
				local var_375_4 = Vector3.New(0, -1.1, -5.9)

				var_375_0.localPosition = Vector3.Lerp(arg_372_1.var_.moveOldPos10025ui_story, var_375_4, var_375_3)

				local var_375_5 = manager.ui.mainCamera.transform.position - var_375_0.position

				var_375_0.forward = Vector3.New(var_375_5.x, var_375_5.y, var_375_5.z)

				local var_375_6 = var_375_0.localEulerAngles

				var_375_6.z = 0
				var_375_6.x = 0
				var_375_0.localEulerAngles = var_375_6
			end

			if arg_372_1.time_ >= var_375_1 + var_375_2 and arg_372_1.time_ < var_375_1 + var_375_2 + arg_375_0 then
				var_375_0.localPosition = Vector3.New(0, -1.1, -5.9)

				local var_375_7 = manager.ui.mainCamera.transform.position - var_375_0.position

				var_375_0.forward = Vector3.New(var_375_7.x, var_375_7.y, var_375_7.z)

				local var_375_8 = var_375_0.localEulerAngles

				var_375_8.z = 0
				var_375_8.x = 0
				var_375_0.localEulerAngles = var_375_8
			end

			local var_375_9 = 0

			if var_375_9 < arg_372_1.time_ and arg_372_1.time_ <= var_375_9 + arg_375_0 then
				arg_372_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_1")
			end

			local var_375_10 = 0

			if var_375_10 < arg_372_1.time_ and arg_372_1.time_ <= var_375_10 + arg_375_0 then
				arg_372_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_375_11 = arg_372_1.actors_["10025ui_story"]
			local var_375_12 = 0

			if var_375_12 < arg_372_1.time_ and arg_372_1.time_ <= var_375_12 + arg_375_0 and not isNil(var_375_11) and arg_372_1.var_.characterEffect10025ui_story == nil then
				arg_372_1.var_.characterEffect10025ui_story = var_375_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_375_13 = 0.2

			if var_375_12 <= arg_372_1.time_ and arg_372_1.time_ < var_375_12 + var_375_13 and not isNil(var_375_11) then
				local var_375_14 = (arg_372_1.time_ - var_375_12) / var_375_13

				if arg_372_1.var_.characterEffect10025ui_story and not isNil(var_375_11) then
					arg_372_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_372_1.time_ >= var_375_12 + var_375_13 and arg_372_1.time_ < var_375_12 + var_375_13 + arg_375_0 and not isNil(var_375_11) and arg_372_1.var_.characterEffect10025ui_story then
				arg_372_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_375_15 = 0
			local var_375_16 = 0.125

			if var_375_15 < arg_372_1.time_ and arg_372_1.time_ <= var_375_15 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				local var_375_17 = arg_372_1:FormatText(StoryNameCfg[328].name)

				arg_372_1.leftNameTxt_.text = var_375_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_18 = arg_372_1:GetWordFromCfg(116061090)
				local var_375_19 = arg_372_1:FormatText(var_375_18.content)

				arg_372_1.text_.text = var_375_19

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_20 = 5
				local var_375_21 = utf8.len(var_375_19)
				local var_375_22 = var_375_20 <= 0 and var_375_16 or var_375_16 * (var_375_21 / var_375_20)

				if var_375_22 > 0 and var_375_16 < var_375_22 then
					arg_372_1.talkMaxDuration = var_375_22

					if var_375_22 + var_375_15 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_22 + var_375_15
					end
				end

				arg_372_1.text_.text = var_375_19
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061090", "story_v_out_116061.awb") ~= 0 then
					local var_375_23 = manager.audio:GetVoiceLength("story_v_out_116061", "116061090", "story_v_out_116061.awb") / 1000

					if var_375_23 + var_375_15 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_23 + var_375_15
					end

					if var_375_18.prefab_name ~= "" and arg_372_1.actors_[var_375_18.prefab_name] ~= nil then
						local var_375_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_18.prefab_name].transform, "story_v_out_116061", "116061090", "story_v_out_116061.awb")

						arg_372_1:RecordAudio("116061090", var_375_24)
						arg_372_1:RecordAudio("116061090", var_375_24)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_116061", "116061090", "story_v_out_116061.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_116061", "116061090", "story_v_out_116061.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_25 = math.max(var_375_16, arg_372_1.talkMaxDuration)

			if var_375_15 <= arg_372_1.time_ and arg_372_1.time_ < var_375_15 + var_375_25 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - var_375_15) / var_375_25

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= var_375_15 + var_375_25 and arg_372_1.time_ < var_375_15 + var_375_25 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10025ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_372_1:InitPlayNodeList()
	end,
	Play116061091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 116061091
		arg_376_1.duration_ = 5

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play116061092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = arg_376_1.actors_["10025ui_story"]
			local var_379_1 = 0

			if var_379_1 < arg_376_1.time_ and arg_376_1.time_ <= var_379_1 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect10025ui_story == nil then
				arg_376_1.var_.characterEffect10025ui_story = var_379_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_379_2 = 0.2

			if var_379_1 <= arg_376_1.time_ and arg_376_1.time_ < var_379_1 + var_379_2 and not isNil(var_379_0) then
				local var_379_3 = (arg_376_1.time_ - var_379_1) / var_379_2

				if arg_376_1.var_.characterEffect10025ui_story and not isNil(var_379_0) then
					local var_379_4 = Mathf.Lerp(0, 0.5, var_379_3)

					arg_376_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_376_1.var_.characterEffect10025ui_story.fillRatio = var_379_4
				end
			end

			if arg_376_1.time_ >= var_379_1 + var_379_2 and arg_376_1.time_ < var_379_1 + var_379_2 + arg_379_0 and not isNil(var_379_0) and arg_376_1.var_.characterEffect10025ui_story then
				local var_379_5 = 0.5

				arg_376_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_376_1.var_.characterEffect10025ui_story.fillRatio = var_379_5
			end

			local var_379_6 = 0
			local var_379_7 = 0.3

			if var_379_6 < arg_376_1.time_ and arg_376_1.time_ <= var_379_6 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				local var_379_8 = arg_376_1:FormatText(StoryNameCfg[7].name)

				arg_376_1.leftNameTxt_.text = var_379_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, true)
				arg_376_1.iconController_:SetSelectedState("hero")

				arg_376_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_376_1.callingController_:SetSelectedState("normal")

				arg_376_1.keyicon_.color = Color.New(1, 1, 1)
				arg_376_1.icon_.color = Color.New(1, 1, 1)

				local var_379_9 = arg_376_1:GetWordFromCfg(116061091)
				local var_379_10 = arg_376_1:FormatText(var_379_9.content)

				arg_376_1.text_.text = var_379_10

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_11 = 12
				local var_379_12 = utf8.len(var_379_10)
				local var_379_13 = var_379_11 <= 0 and var_379_7 or var_379_7 * (var_379_12 / var_379_11)

				if var_379_13 > 0 and var_379_7 < var_379_13 then
					arg_376_1.talkMaxDuration = var_379_13

					if var_379_13 + var_379_6 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_13 + var_379_6
					end
				end

				arg_376_1.text_.text = var_379_10
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)
				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_14 = math.max(var_379_7, arg_376_1.talkMaxDuration)

			if var_379_6 <= arg_376_1.time_ and arg_376_1.time_ < var_379_6 + var_379_14 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - var_379_6) / var_379_14

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= var_379_6 + var_379_14 and arg_376_1.time_ < var_379_6 + var_379_14 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play116061092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 116061092
		arg_380_1.duration_ = 4.93

		local var_380_0 = {
			zh = 4.933,
			ja = 4.866
		}
		local var_380_1 = manager.audio:GetLocalizationFlag()

		if var_380_0[var_380_1] ~= nil then
			arg_380_1.duration_ = var_380_0[var_380_1]
		end

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play116061093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 0

			if var_383_0 < arg_380_1.time_ and arg_380_1.time_ <= var_383_0 + arg_383_0 then
				arg_380_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_383_1 = arg_380_1.actors_["10025ui_story"]
			local var_383_2 = 0

			if var_383_2 < arg_380_1.time_ and arg_380_1.time_ <= var_383_2 + arg_383_0 and not isNil(var_383_1) and arg_380_1.var_.characterEffect10025ui_story == nil then
				arg_380_1.var_.characterEffect10025ui_story = var_383_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_383_3 = 0.2

			if var_383_2 <= arg_380_1.time_ and arg_380_1.time_ < var_383_2 + var_383_3 and not isNil(var_383_1) then
				local var_383_4 = (arg_380_1.time_ - var_383_2) / var_383_3

				if arg_380_1.var_.characterEffect10025ui_story and not isNil(var_383_1) then
					arg_380_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_380_1.time_ >= var_383_2 + var_383_3 and arg_380_1.time_ < var_383_2 + var_383_3 + arg_383_0 and not isNil(var_383_1) and arg_380_1.var_.characterEffect10025ui_story then
				arg_380_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_383_5 = 0
			local var_383_6 = 0.425

			if var_383_5 < arg_380_1.time_ and arg_380_1.time_ <= var_383_5 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, true)

				local var_383_7 = arg_380_1:FormatText(StoryNameCfg[328].name)

				arg_380_1.leftNameTxt_.text = var_383_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_380_1.leftNameTxt_.transform)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1.leftNameTxt_.text)
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_8 = arg_380_1:GetWordFromCfg(116061092)
				local var_383_9 = arg_380_1:FormatText(var_383_8.content)

				arg_380_1.text_.text = var_383_9

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_10 = 17
				local var_383_11 = utf8.len(var_383_9)
				local var_383_12 = var_383_10 <= 0 and var_383_6 or var_383_6 * (var_383_11 / var_383_10)

				if var_383_12 > 0 and var_383_6 < var_383_12 then
					arg_380_1.talkMaxDuration = var_383_12

					if var_383_12 + var_383_5 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_12 + var_383_5
					end
				end

				arg_380_1.text_.text = var_383_9
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061092", "story_v_out_116061.awb") ~= 0 then
					local var_383_13 = manager.audio:GetVoiceLength("story_v_out_116061", "116061092", "story_v_out_116061.awb") / 1000

					if var_383_13 + var_383_5 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_13 + var_383_5
					end

					if var_383_8.prefab_name ~= "" and arg_380_1.actors_[var_383_8.prefab_name] ~= nil then
						local var_383_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_380_1.actors_[var_383_8.prefab_name].transform, "story_v_out_116061", "116061092", "story_v_out_116061.awb")

						arg_380_1:RecordAudio("116061092", var_383_14)
						arg_380_1:RecordAudio("116061092", var_383_14)
					else
						arg_380_1:AudioAction("play", "voice", "story_v_out_116061", "116061092", "story_v_out_116061.awb")
					end

					arg_380_1:RecordHistoryTalkVoice("story_v_out_116061", "116061092", "story_v_out_116061.awb")
				end

				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_15 = math.max(var_383_6, arg_380_1.talkMaxDuration)

			if var_383_5 <= arg_380_1.time_ and arg_380_1.time_ < var_383_5 + var_383_15 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_5) / var_383_15

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_5 + var_383_15 and arg_380_1.time_ < var_383_5 + var_383_15 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play116061093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 116061093
		arg_384_1.duration_ = 5

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play116061094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = arg_384_1.actors_["10025ui_story"]
			local var_387_1 = 0

			if var_387_1 < arg_384_1.time_ and arg_384_1.time_ <= var_387_1 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect10025ui_story == nil then
				arg_384_1.var_.characterEffect10025ui_story = var_387_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_387_2 = 0.2

			if var_387_1 <= arg_384_1.time_ and arg_384_1.time_ < var_387_1 + var_387_2 and not isNil(var_387_0) then
				local var_387_3 = (arg_384_1.time_ - var_387_1) / var_387_2

				if arg_384_1.var_.characterEffect10025ui_story and not isNil(var_387_0) then
					local var_387_4 = Mathf.Lerp(0, 0.5, var_387_3)

					arg_384_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_384_1.var_.characterEffect10025ui_story.fillRatio = var_387_4
				end
			end

			if arg_384_1.time_ >= var_387_1 + var_387_2 and arg_384_1.time_ < var_387_1 + var_387_2 + arg_387_0 and not isNil(var_387_0) and arg_384_1.var_.characterEffect10025ui_story then
				local var_387_5 = 0.5

				arg_384_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_384_1.var_.characterEffect10025ui_story.fillRatio = var_387_5
			end

			local var_387_6 = 0
			local var_387_7 = 0.675

			if var_387_6 < arg_384_1.time_ and arg_384_1.time_ <= var_387_6 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				local var_387_8 = arg_384_1:FormatText(StoryNameCfg[7].name)

				arg_384_1.leftNameTxt_.text = var_387_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, true)
				arg_384_1.iconController_:SetSelectedState("hero")

				arg_384_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_384_1.callingController_:SetSelectedState("normal")

				arg_384_1.keyicon_.color = Color.New(1, 1, 1)
				arg_384_1.icon_.color = Color.New(1, 1, 1)

				local var_387_9 = arg_384_1:GetWordFromCfg(116061093)
				local var_387_10 = arg_384_1:FormatText(var_387_9.content)

				arg_384_1.text_.text = var_387_10

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_11 = 27
				local var_387_12 = utf8.len(var_387_10)
				local var_387_13 = var_387_11 <= 0 and var_387_7 or var_387_7 * (var_387_12 / var_387_11)

				if var_387_13 > 0 and var_387_7 < var_387_13 then
					arg_384_1.talkMaxDuration = var_387_13

					if var_387_13 + var_387_6 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_13 + var_387_6
					end
				end

				arg_384_1.text_.text = var_387_10
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)
				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_14 = math.max(var_387_7, arg_384_1.talkMaxDuration)

			if var_387_6 <= arg_384_1.time_ and arg_384_1.time_ < var_387_6 + var_387_14 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - var_387_6) / var_387_14

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= var_387_6 + var_387_14 and arg_384_1.time_ < var_387_6 + var_387_14 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play116061094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 116061094
		arg_388_1.duration_ = 5

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play116061095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0
			local var_391_1 = 1.275

			if var_391_0 < arg_388_1.time_ and arg_388_1.time_ <= var_391_0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, false)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_2 = arg_388_1:GetWordFromCfg(116061094)
				local var_391_3 = arg_388_1:FormatText(var_391_2.content)

				arg_388_1.text_.text = var_391_3

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_4 = 51
				local var_391_5 = utf8.len(var_391_3)
				local var_391_6 = var_391_4 <= 0 and var_391_1 or var_391_1 * (var_391_5 / var_391_4)

				if var_391_6 > 0 and var_391_1 < var_391_6 then
					arg_388_1.talkMaxDuration = var_391_6

					if var_391_6 + var_391_0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_6 + var_391_0
					end
				end

				arg_388_1.text_.text = var_391_3
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)
				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_7 = math.max(var_391_1, arg_388_1.talkMaxDuration)

			if var_391_0 <= arg_388_1.time_ and arg_388_1.time_ < var_391_0 + var_391_7 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - var_391_0) / var_391_7

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= var_391_0 + var_391_7 and arg_388_1.time_ < var_391_0 + var_391_7 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play116061095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 116061095
		arg_392_1.duration_ = 5

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play116061096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 0
			local var_395_1 = 0.45

			if var_395_0 < arg_392_1.time_ and arg_392_1.time_ <= var_395_0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				local var_395_2 = arg_392_1:FormatText(StoryNameCfg[7].name)

				arg_392_1.leftNameTxt_.text = var_395_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, true)
				arg_392_1.iconController_:SetSelectedState("hero")

				arg_392_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_392_1.callingController_:SetSelectedState("normal")

				arg_392_1.keyicon_.color = Color.New(1, 1, 1)
				arg_392_1.icon_.color = Color.New(1, 1, 1)

				local var_395_3 = arg_392_1:GetWordFromCfg(116061095)
				local var_395_4 = arg_392_1:FormatText(var_395_3.content)

				arg_392_1.text_.text = var_395_4

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_5 = 18
				local var_395_6 = utf8.len(var_395_4)
				local var_395_7 = var_395_5 <= 0 and var_395_1 or var_395_1 * (var_395_6 / var_395_5)

				if var_395_7 > 0 and var_395_1 < var_395_7 then
					arg_392_1.talkMaxDuration = var_395_7

					if var_395_7 + var_395_0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_7 + var_395_0
					end
				end

				arg_392_1.text_.text = var_395_4
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)
				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_8 = math.max(var_395_1, arg_392_1.talkMaxDuration)

			if var_395_0 <= arg_392_1.time_ and arg_392_1.time_ < var_395_0 + var_395_8 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - var_395_0) / var_395_8

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= var_395_0 + var_395_8 and arg_392_1.time_ < var_395_0 + var_395_8 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play116061096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 116061096
		arg_396_1.duration_ = 6.03

		local var_396_0 = {
			zh = 6.033,
			ja = 5.966
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play116061097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0

			if var_399_0 < arg_396_1.time_ and arg_396_1.time_ <= var_399_0 + arg_399_0 then
				arg_396_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_399_1 = arg_396_1.actors_["10025ui_story"]
			local var_399_2 = 0

			if var_399_2 < arg_396_1.time_ and arg_396_1.time_ <= var_399_2 + arg_399_0 and not isNil(var_399_1) and arg_396_1.var_.characterEffect10025ui_story == nil then
				arg_396_1.var_.characterEffect10025ui_story = var_399_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_399_3 = 0.2

			if var_399_2 <= arg_396_1.time_ and arg_396_1.time_ < var_399_2 + var_399_3 and not isNil(var_399_1) then
				local var_399_4 = (arg_396_1.time_ - var_399_2) / var_399_3

				if arg_396_1.var_.characterEffect10025ui_story and not isNil(var_399_1) then
					arg_396_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_396_1.time_ >= var_399_2 + var_399_3 and arg_396_1.time_ < var_399_2 + var_399_3 + arg_399_0 and not isNil(var_399_1) and arg_396_1.var_.characterEffect10025ui_story then
				arg_396_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_399_5 = 0
			local var_399_6 = 0.475

			if var_399_5 < arg_396_1.time_ and arg_396_1.time_ <= var_399_5 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				local var_399_7 = arg_396_1:FormatText(StoryNameCfg[328].name)

				arg_396_1.leftNameTxt_.text = var_399_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_8 = arg_396_1:GetWordFromCfg(116061096)
				local var_399_9 = arg_396_1:FormatText(var_399_8.content)

				arg_396_1.text_.text = var_399_9

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_10 = 19
				local var_399_11 = utf8.len(var_399_9)
				local var_399_12 = var_399_10 <= 0 and var_399_6 or var_399_6 * (var_399_11 / var_399_10)

				if var_399_12 > 0 and var_399_6 < var_399_12 then
					arg_396_1.talkMaxDuration = var_399_12

					if var_399_12 + var_399_5 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_12 + var_399_5
					end
				end

				arg_396_1.text_.text = var_399_9
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061096", "story_v_out_116061.awb") ~= 0 then
					local var_399_13 = manager.audio:GetVoiceLength("story_v_out_116061", "116061096", "story_v_out_116061.awb") / 1000

					if var_399_13 + var_399_5 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_13 + var_399_5
					end

					if var_399_8.prefab_name ~= "" and arg_396_1.actors_[var_399_8.prefab_name] ~= nil then
						local var_399_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_8.prefab_name].transform, "story_v_out_116061", "116061096", "story_v_out_116061.awb")

						arg_396_1:RecordAudio("116061096", var_399_14)
						arg_396_1:RecordAudio("116061096", var_399_14)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_116061", "116061096", "story_v_out_116061.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_116061", "116061096", "story_v_out_116061.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_15 = math.max(var_399_6, arg_396_1.talkMaxDuration)

			if var_399_5 <= arg_396_1.time_ and arg_396_1.time_ < var_399_5 + var_399_15 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - var_399_5) / var_399_15

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= var_399_5 + var_399_15 and arg_396_1.time_ < var_399_5 + var_399_15 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play116061097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 116061097
		arg_400_1.duration_ = 5

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play116061098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = arg_400_1.actors_["10025ui_story"]
			local var_403_1 = 0

			if var_403_1 < arg_400_1.time_ and arg_400_1.time_ <= var_403_1 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.characterEffect10025ui_story == nil then
				arg_400_1.var_.characterEffect10025ui_story = var_403_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_403_2 = 0.2

			if var_403_1 <= arg_400_1.time_ and arg_400_1.time_ < var_403_1 + var_403_2 and not isNil(var_403_0) then
				local var_403_3 = (arg_400_1.time_ - var_403_1) / var_403_2

				if arg_400_1.var_.characterEffect10025ui_story and not isNil(var_403_0) then
					local var_403_4 = Mathf.Lerp(0, 0.5, var_403_3)

					arg_400_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_400_1.var_.characterEffect10025ui_story.fillRatio = var_403_4
				end
			end

			if arg_400_1.time_ >= var_403_1 + var_403_2 and arg_400_1.time_ < var_403_1 + var_403_2 + arg_403_0 and not isNil(var_403_0) and arg_400_1.var_.characterEffect10025ui_story then
				local var_403_5 = 0.5

				arg_400_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_400_1.var_.characterEffect10025ui_story.fillRatio = var_403_5
			end

			local var_403_6 = 0
			local var_403_7 = 0.525

			if var_403_6 < arg_400_1.time_ and arg_400_1.time_ <= var_403_6 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, false)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_8 = arg_400_1:GetWordFromCfg(116061097)
				local var_403_9 = arg_400_1:FormatText(var_403_8.content)

				arg_400_1.text_.text = var_403_9

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_10 = 21
				local var_403_11 = utf8.len(var_403_9)
				local var_403_12 = var_403_10 <= 0 and var_403_7 or var_403_7 * (var_403_11 / var_403_10)

				if var_403_12 > 0 and var_403_7 < var_403_12 then
					arg_400_1.talkMaxDuration = var_403_12

					if var_403_12 + var_403_6 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_12 + var_403_6
					end
				end

				arg_400_1.text_.text = var_403_9
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)
				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_13 = math.max(var_403_7, arg_400_1.talkMaxDuration)

			if var_403_6 <= arg_400_1.time_ and arg_400_1.time_ < var_403_6 + var_403_13 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - var_403_6) / var_403_13

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= var_403_6 + var_403_13 and arg_400_1.time_ < var_403_6 + var_403_13 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play116061098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 116061098
		arg_404_1.duration_ = 3.87

		local var_404_0 = {
			zh = 3.866,
			ja = 1.999999999999
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play116061099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0

			if var_407_0 < arg_404_1.time_ and arg_404_1.time_ <= var_407_0 + arg_407_0 then
				arg_404_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action8_2")
			end

			local var_407_1 = 0

			if var_407_1 < arg_404_1.time_ and arg_404_1.time_ <= var_407_1 + arg_407_0 then
				arg_404_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_407_2 = arg_404_1.actors_["10025ui_story"]
			local var_407_3 = 0

			if var_407_3 < arg_404_1.time_ and arg_404_1.time_ <= var_407_3 + arg_407_0 and not isNil(var_407_2) and arg_404_1.var_.characterEffect10025ui_story == nil then
				arg_404_1.var_.characterEffect10025ui_story = var_407_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_407_4 = 0.2

			if var_407_3 <= arg_404_1.time_ and arg_404_1.time_ < var_407_3 + var_407_4 and not isNil(var_407_2) then
				local var_407_5 = (arg_404_1.time_ - var_407_3) / var_407_4

				if arg_404_1.var_.characterEffect10025ui_story and not isNil(var_407_2) then
					arg_404_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_404_1.time_ >= var_407_3 + var_407_4 and arg_404_1.time_ < var_407_3 + var_407_4 + arg_407_0 and not isNil(var_407_2) and arg_404_1.var_.characterEffect10025ui_story then
				arg_404_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_407_6 = 0
			local var_407_7 = 0.125

			if var_407_6 < arg_404_1.time_ and arg_404_1.time_ <= var_407_6 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				local var_407_8 = arg_404_1:FormatText(StoryNameCfg[328].name)

				arg_404_1.leftNameTxt_.text = var_407_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_9 = arg_404_1:GetWordFromCfg(116061098)
				local var_407_10 = arg_404_1:FormatText(var_407_9.content)

				arg_404_1.text_.text = var_407_10

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_11 = 5
				local var_407_12 = utf8.len(var_407_10)
				local var_407_13 = var_407_11 <= 0 and var_407_7 or var_407_7 * (var_407_12 / var_407_11)

				if var_407_13 > 0 and var_407_7 < var_407_13 then
					arg_404_1.talkMaxDuration = var_407_13

					if var_407_13 + var_407_6 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_13 + var_407_6
					end
				end

				arg_404_1.text_.text = var_407_10
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061098", "story_v_out_116061.awb") ~= 0 then
					local var_407_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061098", "story_v_out_116061.awb") / 1000

					if var_407_14 + var_407_6 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_14 + var_407_6
					end

					if var_407_9.prefab_name ~= "" and arg_404_1.actors_[var_407_9.prefab_name] ~= nil then
						local var_407_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_9.prefab_name].transform, "story_v_out_116061", "116061098", "story_v_out_116061.awb")

						arg_404_1:RecordAudio("116061098", var_407_15)
						arg_404_1:RecordAudio("116061098", var_407_15)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_116061", "116061098", "story_v_out_116061.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_116061", "116061098", "story_v_out_116061.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_16 = math.max(var_407_7, arg_404_1.talkMaxDuration)

			if var_407_6 <= arg_404_1.time_ and arg_404_1.time_ < var_407_6 + var_407_16 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - var_407_6) / var_407_16

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= var_407_6 + var_407_16 and arg_404_1.time_ < var_407_6 + var_407_16 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play116061099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 116061099
		arg_408_1.duration_ = 5

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play116061100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = arg_408_1.actors_["10025ui_story"]
			local var_411_1 = 0

			if var_411_1 < arg_408_1.time_ and arg_408_1.time_ <= var_411_1 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect10025ui_story == nil then
				arg_408_1.var_.characterEffect10025ui_story = var_411_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_411_2 = 0.2

			if var_411_1 <= arg_408_1.time_ and arg_408_1.time_ < var_411_1 + var_411_2 and not isNil(var_411_0) then
				local var_411_3 = (arg_408_1.time_ - var_411_1) / var_411_2

				if arg_408_1.var_.characterEffect10025ui_story and not isNil(var_411_0) then
					local var_411_4 = Mathf.Lerp(0, 0.5, var_411_3)

					arg_408_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_408_1.var_.characterEffect10025ui_story.fillRatio = var_411_4
				end
			end

			if arg_408_1.time_ >= var_411_1 + var_411_2 and arg_408_1.time_ < var_411_1 + var_411_2 + arg_411_0 and not isNil(var_411_0) and arg_408_1.var_.characterEffect10025ui_story then
				local var_411_5 = 0.5

				arg_408_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_408_1.var_.characterEffect10025ui_story.fillRatio = var_411_5
			end

			local var_411_6 = 0
			local var_411_7 = 1.05

			if var_411_6 < arg_408_1.time_ and arg_408_1.time_ <= var_411_6 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, false)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_8 = arg_408_1:GetWordFromCfg(116061099)
				local var_411_9 = arg_408_1:FormatText(var_411_8.content)

				arg_408_1.text_.text = var_411_9

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_10 = 42
				local var_411_11 = utf8.len(var_411_9)
				local var_411_12 = var_411_10 <= 0 and var_411_7 or var_411_7 * (var_411_11 / var_411_10)

				if var_411_12 > 0 and var_411_7 < var_411_12 then
					arg_408_1.talkMaxDuration = var_411_12

					if var_411_12 + var_411_6 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_12 + var_411_6
					end
				end

				arg_408_1.text_.text = var_411_9
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)
				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_13 = math.max(var_411_7, arg_408_1.talkMaxDuration)

			if var_411_6 <= arg_408_1.time_ and arg_408_1.time_ < var_411_6 + var_411_13 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_6) / var_411_13

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_6 + var_411_13 and arg_408_1.time_ < var_411_6 + var_411_13 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play116061100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 116061100
		arg_412_1.duration_ = 5

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play116061101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0
			local var_415_1 = 0.375

			if var_415_0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				local var_415_2 = arg_412_1:FormatText(StoryNameCfg[7].name)

				arg_412_1.leftNameTxt_.text = var_415_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_3 = arg_412_1:GetWordFromCfg(116061100)
				local var_415_4 = arg_412_1:FormatText(var_415_3.content)

				arg_412_1.text_.text = var_415_4

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_5 = 15
				local var_415_6 = utf8.len(var_415_4)
				local var_415_7 = var_415_5 <= 0 and var_415_1 or var_415_1 * (var_415_6 / var_415_5)

				if var_415_7 > 0 and var_415_1 < var_415_7 then
					arg_412_1.talkMaxDuration = var_415_7

					if var_415_7 + var_415_0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_0
					end
				end

				arg_412_1.text_.text = var_415_4
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)
				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_8 = math.max(var_415_1, arg_412_1.talkMaxDuration)

			if var_415_0 <= arg_412_1.time_ and arg_412_1.time_ < var_415_0 + var_415_8 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_0) / var_415_8

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_0 + var_415_8 and arg_412_1.time_ < var_415_0 + var_415_8 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play116061101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 116061101
		arg_416_1.duration_ = 6

		local var_416_0 = {
			zh = 6,
			ja = 3.866
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play116061102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0

			if var_419_0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_0 + arg_419_0 then
				arg_416_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_1")
			end

			local var_419_1 = 0

			if var_419_1 < arg_416_1.time_ and arg_416_1.time_ <= var_419_1 + arg_419_0 then
				arg_416_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_419_2 = arg_416_1.actors_["10025ui_story"]
			local var_419_3 = 0

			if var_419_3 < arg_416_1.time_ and arg_416_1.time_ <= var_419_3 + arg_419_0 and not isNil(var_419_2) and arg_416_1.var_.characterEffect10025ui_story == nil then
				arg_416_1.var_.characterEffect10025ui_story = var_419_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_419_4 = 0.2

			if var_419_3 <= arg_416_1.time_ and arg_416_1.time_ < var_419_3 + var_419_4 and not isNil(var_419_2) then
				local var_419_5 = (arg_416_1.time_ - var_419_3) / var_419_4

				if arg_416_1.var_.characterEffect10025ui_story and not isNil(var_419_2) then
					arg_416_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_416_1.time_ >= var_419_3 + var_419_4 and arg_416_1.time_ < var_419_3 + var_419_4 + arg_419_0 and not isNil(var_419_2) and arg_416_1.var_.characterEffect10025ui_story then
				arg_416_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_419_6 = 0
			local var_419_7 = 0.3

			if var_419_6 < arg_416_1.time_ and arg_416_1.time_ <= var_419_6 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				local var_419_8 = arg_416_1:FormatText(StoryNameCfg[328].name)

				arg_416_1.leftNameTxt_.text = var_419_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_9 = arg_416_1:GetWordFromCfg(116061101)
				local var_419_10 = arg_416_1:FormatText(var_419_9.content)

				arg_416_1.text_.text = var_419_10

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_11 = 12
				local var_419_12 = utf8.len(var_419_10)
				local var_419_13 = var_419_11 <= 0 and var_419_7 or var_419_7 * (var_419_12 / var_419_11)

				if var_419_13 > 0 and var_419_7 < var_419_13 then
					arg_416_1.talkMaxDuration = var_419_13

					if var_419_13 + var_419_6 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_13 + var_419_6
					end
				end

				arg_416_1.text_.text = var_419_10
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061101", "story_v_out_116061.awb") ~= 0 then
					local var_419_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061101", "story_v_out_116061.awb") / 1000

					if var_419_14 + var_419_6 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_14 + var_419_6
					end

					if var_419_9.prefab_name ~= "" and arg_416_1.actors_[var_419_9.prefab_name] ~= nil then
						local var_419_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_9.prefab_name].transform, "story_v_out_116061", "116061101", "story_v_out_116061.awb")

						arg_416_1:RecordAudio("116061101", var_419_15)
						arg_416_1:RecordAudio("116061101", var_419_15)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_116061", "116061101", "story_v_out_116061.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_116061", "116061101", "story_v_out_116061.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_16 = math.max(var_419_7, arg_416_1.talkMaxDuration)

			if var_419_6 <= arg_416_1.time_ and arg_416_1.time_ < var_419_6 + var_419_16 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_6) / var_419_16

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_6 + var_419_16 and arg_416_1.time_ < var_419_6 + var_419_16 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play116061102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 116061102
		arg_420_1.duration_ = 5

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play116061103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			local var_423_0 = arg_420_1.actors_["10025ui_story"]
			local var_423_1 = 0

			if var_423_1 < arg_420_1.time_ and arg_420_1.time_ <= var_423_1 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect10025ui_story == nil then
				arg_420_1.var_.characterEffect10025ui_story = var_423_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_423_2 = 0.2

			if var_423_1 <= arg_420_1.time_ and arg_420_1.time_ < var_423_1 + var_423_2 and not isNil(var_423_0) then
				local var_423_3 = (arg_420_1.time_ - var_423_1) / var_423_2

				if arg_420_1.var_.characterEffect10025ui_story and not isNil(var_423_0) then
					local var_423_4 = Mathf.Lerp(0, 0.5, var_423_3)

					arg_420_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_420_1.var_.characterEffect10025ui_story.fillRatio = var_423_4
				end
			end

			if arg_420_1.time_ >= var_423_1 + var_423_2 and arg_420_1.time_ < var_423_1 + var_423_2 + arg_423_0 and not isNil(var_423_0) and arg_420_1.var_.characterEffect10025ui_story then
				local var_423_5 = 0.5

				arg_420_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_420_1.var_.characterEffect10025ui_story.fillRatio = var_423_5
			end

			local var_423_6 = 0
			local var_423_7 = 0.2

			if var_423_6 < arg_420_1.time_ and arg_420_1.time_ <= var_423_6 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				local var_423_8 = arg_420_1:FormatText(StoryNameCfg[7].name)

				arg_420_1.leftNameTxt_.text = var_423_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, true)
				arg_420_1.iconController_:SetSelectedState("hero")

				arg_420_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_420_1.callingController_:SetSelectedState("normal")

				arg_420_1.keyicon_.color = Color.New(1, 1, 1)
				arg_420_1.icon_.color = Color.New(1, 1, 1)

				local var_423_9 = arg_420_1:GetWordFromCfg(116061102)
				local var_423_10 = arg_420_1:FormatText(var_423_9.content)

				arg_420_1.text_.text = var_423_10

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_11 = 8
				local var_423_12 = utf8.len(var_423_10)
				local var_423_13 = var_423_11 <= 0 and var_423_7 or var_423_7 * (var_423_12 / var_423_11)

				if var_423_13 > 0 and var_423_7 < var_423_13 then
					arg_420_1.talkMaxDuration = var_423_13

					if var_423_13 + var_423_6 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_13 + var_423_6
					end
				end

				arg_420_1.text_.text = var_423_10
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)
				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_14 = math.max(var_423_7, arg_420_1.talkMaxDuration)

			if var_423_6 <= arg_420_1.time_ and arg_420_1.time_ < var_423_6 + var_423_14 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_6) / var_423_14

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_6 + var_423_14 and arg_420_1.time_ < var_423_6 + var_423_14 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play116061103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 116061103
		arg_424_1.duration_ = 7.13

		local var_424_0 = {
			zh = 4.233,
			ja = 7.133
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play116061104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0

			if var_427_0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_0 + arg_427_0 then
				arg_424_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_427_1 = arg_424_1.actors_["10025ui_story"]
			local var_427_2 = 0

			if var_427_2 < arg_424_1.time_ and arg_424_1.time_ <= var_427_2 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect10025ui_story == nil then
				arg_424_1.var_.characterEffect10025ui_story = var_427_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_427_3 = 0.2

			if var_427_2 <= arg_424_1.time_ and arg_424_1.time_ < var_427_2 + var_427_3 and not isNil(var_427_1) then
				local var_427_4 = (arg_424_1.time_ - var_427_2) / var_427_3

				if arg_424_1.var_.characterEffect10025ui_story and not isNil(var_427_1) then
					arg_424_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_424_1.time_ >= var_427_2 + var_427_3 and arg_424_1.time_ < var_427_2 + var_427_3 + arg_427_0 and not isNil(var_427_1) and arg_424_1.var_.characterEffect10025ui_story then
				arg_424_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_427_5 = 0

			if var_427_5 < arg_424_1.time_ and arg_424_1.time_ <= var_427_5 + arg_427_0 then
				arg_424_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action3_2")
			end

			local var_427_6 = 0
			local var_427_7 = 0.475

			if var_427_6 < arg_424_1.time_ and arg_424_1.time_ <= var_427_6 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				local var_427_8 = arg_424_1:FormatText(StoryNameCfg[328].name)

				arg_424_1.leftNameTxt_.text = var_427_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_9 = arg_424_1:GetWordFromCfg(116061103)
				local var_427_10 = arg_424_1:FormatText(var_427_9.content)

				arg_424_1.text_.text = var_427_10

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_11 = 19
				local var_427_12 = utf8.len(var_427_10)
				local var_427_13 = var_427_11 <= 0 and var_427_7 or var_427_7 * (var_427_12 / var_427_11)

				if var_427_13 > 0 and var_427_7 < var_427_13 then
					arg_424_1.talkMaxDuration = var_427_13

					if var_427_13 + var_427_6 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_13 + var_427_6
					end
				end

				arg_424_1.text_.text = var_427_10
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061103", "story_v_out_116061.awb") ~= 0 then
					local var_427_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061103", "story_v_out_116061.awb") / 1000

					if var_427_14 + var_427_6 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_14 + var_427_6
					end

					if var_427_9.prefab_name ~= "" and arg_424_1.actors_[var_427_9.prefab_name] ~= nil then
						local var_427_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_9.prefab_name].transform, "story_v_out_116061", "116061103", "story_v_out_116061.awb")

						arg_424_1:RecordAudio("116061103", var_427_15)
						arg_424_1:RecordAudio("116061103", var_427_15)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_116061", "116061103", "story_v_out_116061.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_116061", "116061103", "story_v_out_116061.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_16 = math.max(var_427_7, arg_424_1.talkMaxDuration)

			if var_427_6 <= arg_424_1.time_ and arg_424_1.time_ < var_427_6 + var_427_16 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_6) / var_427_16

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_6 + var_427_16 and arg_424_1.time_ < var_427_6 + var_427_16 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play116061104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 116061104
		arg_428_1.duration_ = 5

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play116061105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = arg_428_1.actors_["10025ui_story"]
			local var_431_1 = 0

			if var_431_1 < arg_428_1.time_ and arg_428_1.time_ <= var_431_1 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect10025ui_story == nil then
				arg_428_1.var_.characterEffect10025ui_story = var_431_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_431_2 = 0.2

			if var_431_1 <= arg_428_1.time_ and arg_428_1.time_ < var_431_1 + var_431_2 and not isNil(var_431_0) then
				local var_431_3 = (arg_428_1.time_ - var_431_1) / var_431_2

				if arg_428_1.var_.characterEffect10025ui_story and not isNil(var_431_0) then
					local var_431_4 = Mathf.Lerp(0, 0.5, var_431_3)

					arg_428_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_428_1.var_.characterEffect10025ui_story.fillRatio = var_431_4
				end
			end

			if arg_428_1.time_ >= var_431_1 + var_431_2 and arg_428_1.time_ < var_431_1 + var_431_2 + arg_431_0 and not isNil(var_431_0) and arg_428_1.var_.characterEffect10025ui_story then
				local var_431_5 = 0.5

				arg_428_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_428_1.var_.characterEffect10025ui_story.fillRatio = var_431_5
			end

			local var_431_6 = 0
			local var_431_7 = 0.375

			if var_431_6 < arg_428_1.time_ and arg_428_1.time_ <= var_431_6 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				local var_431_8 = arg_428_1:FormatText(StoryNameCfg[7].name)

				arg_428_1.leftNameTxt_.text = var_431_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_9 = arg_428_1:GetWordFromCfg(116061104)
				local var_431_10 = arg_428_1:FormatText(var_431_9.content)

				arg_428_1.text_.text = var_431_10

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_11 = 15
				local var_431_12 = utf8.len(var_431_10)
				local var_431_13 = var_431_11 <= 0 and var_431_7 or var_431_7 * (var_431_12 / var_431_11)

				if var_431_13 > 0 and var_431_7 < var_431_13 then
					arg_428_1.talkMaxDuration = var_431_13

					if var_431_13 + var_431_6 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_13 + var_431_6
					end
				end

				arg_428_1.text_.text = var_431_10
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_14 = math.max(var_431_7, arg_428_1.talkMaxDuration)

			if var_431_6 <= arg_428_1.time_ and arg_428_1.time_ < var_431_6 + var_431_14 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_6) / var_431_14

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_6 + var_431_14 and arg_428_1.time_ < var_431_6 + var_431_14 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play116061105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 116061105
		arg_432_1.duration_ = 6.77

		local var_432_0 = {
			zh = 6.133,
			ja = 6.766
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play116061106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			local var_435_0 = 0

			if var_435_0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_0 + arg_435_0 then
				arg_432_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action5_1")
			end

			local var_435_1 = 0

			if var_435_1 < arg_432_1.time_ and arg_432_1.time_ <= var_435_1 + arg_435_0 then
				arg_432_1:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_435_2 = arg_432_1.actors_["10025ui_story"]
			local var_435_3 = 0

			if var_435_3 < arg_432_1.time_ and arg_432_1.time_ <= var_435_3 + arg_435_0 and not isNil(var_435_2) and arg_432_1.var_.characterEffect10025ui_story == nil then
				arg_432_1.var_.characterEffect10025ui_story = var_435_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_435_4 = 0.2

			if var_435_3 <= arg_432_1.time_ and arg_432_1.time_ < var_435_3 + var_435_4 and not isNil(var_435_2) then
				local var_435_5 = (arg_432_1.time_ - var_435_3) / var_435_4

				if arg_432_1.var_.characterEffect10025ui_story and not isNil(var_435_2) then
					arg_432_1.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if arg_432_1.time_ >= var_435_3 + var_435_4 and arg_432_1.time_ < var_435_3 + var_435_4 + arg_435_0 and not isNil(var_435_2) and arg_432_1.var_.characterEffect10025ui_story then
				arg_432_1.var_.characterEffect10025ui_story.fillFlat = false
			end

			local var_435_6 = 0
			local var_435_7 = 0.525

			if var_435_6 < arg_432_1.time_ and arg_432_1.time_ <= var_435_6 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				local var_435_8 = arg_432_1:FormatText(StoryNameCfg[328].name)

				arg_432_1.leftNameTxt_.text = var_435_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_9 = arg_432_1:GetWordFromCfg(116061105)
				local var_435_10 = arg_432_1:FormatText(var_435_9.content)

				arg_432_1.text_.text = var_435_10

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_11 = 21
				local var_435_12 = utf8.len(var_435_10)
				local var_435_13 = var_435_11 <= 0 and var_435_7 or var_435_7 * (var_435_12 / var_435_11)

				if var_435_13 > 0 and var_435_7 < var_435_13 then
					arg_432_1.talkMaxDuration = var_435_13

					if var_435_13 + var_435_6 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_13 + var_435_6
					end
				end

				arg_432_1.text_.text = var_435_10
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116061", "116061105", "story_v_out_116061.awb") ~= 0 then
					local var_435_14 = manager.audio:GetVoiceLength("story_v_out_116061", "116061105", "story_v_out_116061.awb") / 1000

					if var_435_14 + var_435_6 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_14 + var_435_6
					end

					if var_435_9.prefab_name ~= "" and arg_432_1.actors_[var_435_9.prefab_name] ~= nil then
						local var_435_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_9.prefab_name].transform, "story_v_out_116061", "116061105", "story_v_out_116061.awb")

						arg_432_1:RecordAudio("116061105", var_435_15)
						arg_432_1:RecordAudio("116061105", var_435_15)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_116061", "116061105", "story_v_out_116061.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_116061", "116061105", "story_v_out_116061.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_16 = math.max(var_435_7, arg_432_1.talkMaxDuration)

			if var_435_6 <= arg_432_1.time_ and arg_432_1.time_ < var_435_6 + var_435_16 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_6) / var_435_16

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_6 + var_435_16 and arg_432_1.time_ < var_435_6 + var_435_16 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {}

		arg_432_1:InitPlayNodeList()
	end,
	Play116061106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 116061106
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play116061107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			local var_439_0 = arg_436_1.actors_["10025ui_story"]
			local var_439_1 = 0

			if var_439_1 < arg_436_1.time_ and arg_436_1.time_ <= var_439_1 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect10025ui_story == nil then
				arg_436_1.var_.characterEffect10025ui_story = var_439_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_439_2 = 0.2

			if var_439_1 <= arg_436_1.time_ and arg_436_1.time_ < var_439_1 + var_439_2 and not isNil(var_439_0) then
				local var_439_3 = (arg_436_1.time_ - var_439_1) / var_439_2

				if arg_436_1.var_.characterEffect10025ui_story and not isNil(var_439_0) then
					local var_439_4 = Mathf.Lerp(0, 0.5, var_439_3)

					arg_436_1.var_.characterEffect10025ui_story.fillFlat = true
					arg_436_1.var_.characterEffect10025ui_story.fillRatio = var_439_4
				end
			end

			if arg_436_1.time_ >= var_439_1 + var_439_2 and arg_436_1.time_ < var_439_1 + var_439_2 + arg_439_0 and not isNil(var_439_0) and arg_436_1.var_.characterEffect10025ui_story then
				local var_439_5 = 0.5

				arg_436_1.var_.characterEffect10025ui_story.fillFlat = true
				arg_436_1.var_.characterEffect10025ui_story.fillRatio = var_439_5
			end

			local var_439_6 = 0
			local var_439_7 = 0.5

			if var_439_6 < arg_436_1.time_ and arg_436_1.time_ <= var_439_6 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_8 = arg_436_1:GetWordFromCfg(116061106)
				local var_439_9 = arg_436_1:FormatText(var_439_8.content)

				arg_436_1.text_.text = var_439_9

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_10 = 20
				local var_439_11 = utf8.len(var_439_9)
				local var_439_12 = var_439_10 <= 0 and var_439_7 or var_439_7 * (var_439_11 / var_439_10)

				if var_439_12 > 0 and var_439_7 < var_439_12 then
					arg_436_1.talkMaxDuration = var_439_12

					if var_439_12 + var_439_6 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_12 + var_439_6
					end
				end

				arg_436_1.text_.text = var_439_9
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_13 = math.max(var_439_7, arg_436_1.talkMaxDuration)

			if var_439_6 <= arg_436_1.time_ and arg_436_1.time_ < var_439_6 + var_439_13 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_6) / var_439_13

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_6 + var_439_13 and arg_436_1.time_ < var_439_6 + var_439_13 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play116061107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 116061107
		arg_440_1.duration_ = 5

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play116061108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0
			local var_443_1 = 0.5

			if var_443_0 < arg_440_1.time_ and arg_440_1.time_ <= var_443_0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, false)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_440_1.iconTrs_.gameObject, false)
				arg_440_1.callingController_:SetSelectedState("normal")

				local var_443_2 = arg_440_1:GetWordFromCfg(116061107)
				local var_443_3 = arg_440_1:FormatText(var_443_2.content)

				arg_440_1.text_.text = var_443_3

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_4 = 20
				local var_443_5 = utf8.len(var_443_3)
				local var_443_6 = var_443_4 <= 0 and var_443_1 or var_443_1 * (var_443_5 / var_443_4)

				if var_443_6 > 0 and var_443_1 < var_443_6 then
					arg_440_1.talkMaxDuration = var_443_6

					if var_443_6 + var_443_0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_6 + var_443_0
					end
				end

				arg_440_1.text_.text = var_443_3
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)
				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_7 = math.max(var_443_1, arg_440_1.talkMaxDuration)

			if var_443_0 <= arg_440_1.time_ and arg_440_1.time_ < var_443_0 + var_443_7 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - var_443_0) / var_443_7

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= var_443_0 + var_443_7 and arg_440_1.time_ < var_443_0 + var_443_7 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play116061108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 116061108
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
			arg_444_1.auto_ = false
		end

		function arg_444_1.playNext_(arg_446_0)
			arg_444_1.onStoryFinished_()
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 0
			local var_447_1 = 0.45

			if var_447_0 < arg_444_1.time_ and arg_444_1.time_ <= var_447_0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, false)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_2 = arg_444_1:GetWordFromCfg(116061108)
				local var_447_3 = arg_444_1:FormatText(var_447_2.content)

				arg_444_1.text_.text = var_447_3

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_4 = 18
				local var_447_5 = utf8.len(var_447_3)
				local var_447_6 = var_447_4 <= 0 and var_447_1 or var_447_1 * (var_447_5 / var_447_4)

				if var_447_6 > 0 and var_447_1 < var_447_6 then
					arg_444_1.talkMaxDuration = var_447_6

					if var_447_6 + var_447_0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_6 + var_447_0
					end
				end

				arg_444_1.text_.text = var_447_3
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_7 = math.max(var_447_1, arg_444_1.talkMaxDuration)

			if var_447_0 <= arg_444_1.time_ and arg_444_1.time_ < var_447_0 + var_447_7 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - var_447_0) / var_447_7

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= var_447_0 + var_447_7 and arg_444_1.time_ < var_447_0 + var_447_7 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I05",
		"TextureConfig/Background/I05d",
		"TextureConfig/Background/ST02",
		"TextureConfig/Background/ST03"
	},
	voices = {
		"story_v_out_116061.awb"
	}
}
